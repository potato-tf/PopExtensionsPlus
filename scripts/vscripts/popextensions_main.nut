// Core popextensions script
// Error handling, think table management, cleanup management, etc.

local ROOT = getroottable()
::POPEXT_VERSION <- "11.11.2025.1"

local function Include( path, continue_on_error = false, include_only_if_missing = null, scope_to_check = ROOT ) {

	if ( scope_to_check != ROOT && scope_to_check in ROOT )
		scope_to_check = ROOT[scope_to_check]

	if ( include_only_if_missing && include_only_if_missing in scope_to_check )
		return true

	try {

		IncludeScript( "popextensions/" + path, getroottable() )
		return true
	}
	catch( e ) {

		local msg = e + "\n"
		continue_on_error ? error( msg ) : Assert( false, msg )
		return false
	}

	return true
}

// INCLUDE ORDER IS IMPORTANT
// These are required regardless of the modules you use
Include( "shared/constants", false ) 								  // Generic constants used by all scripts, including main.  Already skips re-including internally
Include( "shared/itemdef_constants", false, "ID_SNUG_SHARPSHOOTER" )  // Item definitions.  check a random constant to avoid re-including
Include( "shared/item_map", false, "PopExtItems" ) 		   		      // Item map for english name item look-ups
Include( "shared/attribute_map", false, "Attributes", "PopExtItems" ) // Attribute map for attribute info look-ups

/*********************************************************************************************
 * Namespacing wrapper for creating self-contained scopes for modules.					     *
 * - name: Targetname of the entity.  "__popext" prefixed names are cleaned up on unload	 *
 * - scope_ref: Root table reference to the scope.                                           *
 * - entity_ref: Root table reference to the entity.                                         *
 * - think_func: Create a think function for this entity/scope, depending on argument type.  *
 * 	  - String: Create a new think function that iterates over a 'ThinkTable' table.		 *
 * 	  - Function: Does NOT create 'ThinkTable', sets the think function directly.			 *
 * - preserved: If true, will not be deleted on round reset                                  *
 *********************************************************************************************/
if ( !( "__active_scopes" in ROOT ) )
	::__active_scopes <- {}

function POPEXT_CREATE_SCOPE( name, scope_ref = null, entity_ref = null, think_func = null, preserved = true, classname_override = null ) {

	local classname = classname_override || "logic_autosave"

	// empty vscripts kv will do ValidateScriptScope automatically
	local ent = FindByName( null, name ) || SpawnEntityFromTable( classname, { targetname = name, vscripts = " " } )
	SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )

	if ( preserved ) {

		ent.DisableDraw()
		ent.SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	}

	if ( "PURGE_STRINGS" in ROOT )
		PURGE_STRINGS( ent.GetScriptId() )

	__active_scopes[ ent ] <- scope_ref

	local scope = ent.GetScriptScope()

	scope_ref  =  scope_ref  || name + "Scope"
	entity_ref =  entity_ref || name + "Entity"
	ROOT[ scope_ref ]  <- scope
	ROOT[ entity_ref ] <- ent

	if ( think_func ) {

		// Add the think function directly to the entity
		if ( endswith( typeof think_func, "function" ) ) {

			local think_name = think_func.getinfos().name || name + "_Think"

			scope[ think_name ] <- think_func
			try { _AddThinkToEnt( ent, think_name ) } catch (_) { AddThinkToEnt( ent, think_name ) }
			return
		}

		scope.ThinkTable <- {}

		// Always create a named function to satisfy the perf counter
		compilestring( "function " + think_func + "() { foreach ( func in ThinkTable || {} ) func(); return -1 }" ).call( scope )

		try { _AddThinkToEnt( ent, think_func ) } catch (_) { AddThinkToEnt( ent, think_func ) }
	}

	scope.setdelegate({

		function _newslot( k, v ) {

			if ( k == "_OnDestroy" && !_OnDestroy )
				_OnDestroy = v.bindenv( scope )

			scope.rawset( k, v )

			if ( typeof v == "function" ) {

				if ( k == "_OnCreate" )
					_OnCreate()

				// fix anonymous function declarations in perf counter
				else if ( v.getinfos().name == null )
					compilestring( format( @"local _%s = %s; function %s() { _%s() }", k, k, k, k ) ).call(scope)
			}
		}

	}.setdelegate({

			parent     = scope.getdelegate()
			id         = ent.GetScriptId()
			index      = ent.entindex()
			_OnDestroy = null

			function _get( k ) { return parent[k] }

			function _delslot( k ) {

				if ( k == id ) {

					if ( _OnDestroy )
						_OnDestroy()

					if ( scope_ref in ROOT )
						delete ROOT[ scope_ref ]

					if ( entity_ref in ROOT )
						delete ROOT[ entity_ref ]
				}

				delete parent[k]
			}
		})
	)

	if ( preserved )
		SetPropString( ent, STRING_NETPROP_CLASSNAME, "move_rope" )

	return { Entity = ent, Scope = scope }
}

Include( "shared/gamestrings" )									// Experimental string leak handler
Include( "shared/config" )										// Configuration file for end users, always re-include this
Include( "shared/event_wrapper", "PopExtEvents" ) 	   		    // Event wrapper for all events
Include( "shared/util", "PopExtUtil" )						    // misc utils/entities

// initialize main scope
POPEXT_CREATE_SCOPE( "__popext_main", "PopExtMain", "PopExtMainEntity", "PopExtMainThink" )

/**************************************************************************************************************
 * Save popfile name in global scope when we first initialize                                                 *
 * If the popfile name changed, a new pop has loaded, clean everything up.                                    *
 * TODO: this will break if the popfile name is changed mid-mission and not reverted back.  Find a better way *
 *************************************************************************************************************/
local objres = FindByClassname( null, "tf_objective_resource" )
::__popname <- GetPropString( objres, STRING_NETPROP_POPNAME )

// wrapper so it shows up in the perf warnings instead of just "main"
function PopExtMain::collectgarbage() { ::collectgarbage() }

local unload_cleanup = [
	"__popname"
	"PopExtItems"
	"EntAdditions"
	"POPEXT_VERSION"
	"POPEXT_CREATE_SCOPE"
	"POPEXT_ROBOT_VO"
]
/***********************
 * Destructor function *
 ***********************/
function PopExtMain::_OnDestroy() {

	::AddThinkToEnt <- _AddThinkToEnt

	if ( "_EntFireByHandle" in ROOT )
		::EntFireByHandle <- ::_EntFireByHandle

	foreach( key in unload_cleanup )
		if ( key in ROOT )
			delete ROOT[ key ]
}

/********************************
 * Error/Warning/Debug handling *
 ********************************/
PopExtMain.Error <- {

	raised_parse_error = false

	// generic exception
	function RaiseException( error_msg ) { Assert( false, format( "%s: %s.", POPEXT_LOG_FATAL, error_msg ) ) }

	// generic parsing error
	function ParseError( error_msg, error_level = POPEXT_LOG_ERROR, assert = false ) {

		if ( !raised_parse_error && error_level != POPEXT_LOG_DEBUG) {

			raised_parse_error = true
			ClientPrint( null, HUD_PRINTTALK, POPEXT_LOG_PARSE_ERROR )
		}
		if ( error_level == POPEXT_LOG_FATAL || assert ) {
			RaiseException( error_msg + ".\n" )
		}
		else {
			ClientPrint( null, HUD_PRINTTALK, format( "%s %s.\n", POPEXT_LOG_ERROR, error_msg ) )
			printf( "%s %s.\n", POPEXT_LOG_ERROR, error_msg )
		}
	}

	// debug logging
	function DebugLog( LogMsg ) {

		local src = getstackinfos(2).src
		if ( PopExtConfig.DebugText && ( src in PopExtConfig.DebugFiles || src.slice(0, -4) in PopExtConfig.DebugFiles ) )
			ClientPrint( null, HUD_PRINTCONSOLE, format( "%s %s.", POPEXT_LOG_DEBUG, LogMsg ) )
	}

	// warnings/deprecations
	function GenericWarning( msg ) 			{ ClientPrint( null, HUD_PRINTCONSOLE, format( "%s %s.", POPEXT_LOG_WARNING, msg ) ) }
	function DeprecationWarning( old, new ) { ClientPrint( null, HUD_PRINTCONSOLE, format( "%s %s is DEPRECATED and may be removed in a future update. Use %s instead.", POPEXT_LOG_WARNING, old, new ) ) }

	// errors/exceptions
	function RaiseIndexError( key, max = [0, 1], assert = false ) 	   { ParseError( format( "Index out of range for '%s', value range: %d - %d", key, max[0], max[1] ), assert ) }
	function RaiseTypeError( key, type, assert = false ) 			   { ParseError( format( "Bad type for '%s' (should be %s)", key, type ), assert ) }
	function RaiseValueError( key, value, extra = "", assert = false ) { ParseError( format( "Bad value '%s' passed to %s. %s", value.tostring(), key, extra ), assert ) }
	function RaiseModuleError( module, module_user, assert = false )   { ParseError( format( "Missing module or incorrect include order: '%s' (%s).", module, module_user ), assert ) }
}

/*********************************************************************************************************************************
 * overwrite AddThinkToEnt                                                                                                       *
 * certain entity types use think tables, meaning any external scripts will conflict with this and break everything              *
 * don't want to confuse new scripters by allowing adding multiple thinks with AddThinkToEnt in our library and our library only *
 * spew a big fat warning below so they know what's going on                                                                     *
 *********************************************************************************************************************************/
if ( !( "_AddThinkToEnt" in ROOT ) ) {

	/******************************************************************************************************************************************
	 * rename so we can still use it elsewhere                                                                                                *
	 * this also allows people to override the think restriction by using _AddThinkToEnt( ent, "FuncNameHere" ) instead                       *
	 * I'm not including this in the warning, only the people that know what they're doing already and can find it here should know about it. *
	 ******************************************************************************************************************************************/
	::_AddThinkToEnt <- AddThinkToEnt

	function AddThinkToEnt( ent, func ) {

		local ent_classname = ent.GetClassname()

		foreach ( classname in PopExtConfig.ThinkTableSetup.keys() ) {

			if ( startswith( ent_classname, classname ) ) {

				PopExtMain.Error.GenericWarning( format( "AddThinkToEnt on '%s' overwritten!\n\nAddThinkToEnt( ent, \"%s\" ) -> PopExtUtil.AddThink( ent, \"%s\" )", ent.tostring(), func, func ) )
				PopExtUtil.AddThink( ent, func )
				return
			}
		}

		_AddThinkToEnt( ent, func )
	}
}

/**********************************************************
 * overwrite EntFireByHandle to get invalid/null entities *
 **********************************************************/
if ( PopExtConfig.DebugText && !( "_EntFireByHandle" in ROOT ) ) {

	::_EntFireByHandle <- EntFireByHandle

	function EntFireByHandle( target, action, param, delay, activator, caller ) {

		if ( !target || !target.IsValid() )
			PopExtMain.Error.RaiseException( "Invalid target passed to EntFireByHandle" )

		_EntFireByHandle( target, action, param, delay, activator, caller )
	}
}

PopExtMain.ActiveModules   <- {}
PopExtMain.ScopePreserved  <- {
	kill_on_spawn 	   = []
	kill_on_death 	   = []
	active_projectiles = {}
}

function PopExtMain::PlayerCleanup( player, full_cleanup = false ) {

	NetProps.SetPropInt( player, "m_nRenderMode", kRenderNormal )
	NetProps.SetPropInt( player, "m_clrRender", 0xFFFFFF )

	// clean up all weapons/wearables
	for ( local child = player.FirstMoveChild(), scope; child; scope = child.GetScriptScope(), child = child.NextMovePeer() ) {

		if ( !(child instanceof CEconEntity) )
			continue

		if ( full_cleanup )
			child.TerminateScriptScope()
		else
			foreach ( k, v in scope || {} )
				if ( !( k in PopExtConfig.IgnoreTable ) )
					delete scope[k]
	}

	local scope = player.GetScriptScope()

	if ( full_cleanup ) {

		foreach ( ent in scope.PRESERVED.kill_on_death )
			if ( ent && ent.IsValid() && ent.GetOwner() == player )
				ent.Kill()
		
		player.TerminateScriptScope()
		return
	}

	foreach ( k in scope.keys() )
		if ( !( k in PopExtConfig.IgnoreTable ) )
			delete scope[k]

	_AddThinkToEnt( player, null )
}

function PopExtMain::FullCleanup() {

	foreach( player in PopExtUtil.PlayerArray )
		PlayerCleanup( player, true )

	foreach( ent in __active_scopes.keys() )
		if ( ent && ent.IsValid() )
			ent.Kill()

	delete ::__active_scopes

	// Kill all remaining popextensions entities
	EntFire( "extratankpath*", "Kill" )
	PURGE_STRINGS( "__popext*", "extratankpath*" )
	PopExtUtil.ScriptEntFireSafe( "__popext*", "SetPropBool( self, STRING_NETPROP_PURGESTRINGS, true ); self.Kill()" )
}

function PopExtMain::IncludeModules( ... ) {

	local failed_modules = {}

	foreach ( module in vargv ) {

		if ( module[0] == '!' && module.slice( 1 ) in ActiveModules ) {

			delete ActiveModules[module.slice( 1 )]
			continue
		}

		if ( !( module in ActiveModules ) ) {

			if ( !Include( module, true ) ) {

				failed_modules[module] <- true
				Error.RaiseModuleError( module, format( "file: %s, func: %s", getstackinfos(2).src, getstackinfos(2).func ), true )
				continue
			}

			ActiveModules[module] <- true
		}
	}

	return failed_modules.len() == 0
}

// add think table to all projectiles
function PopExtMain::ThinkTable::AddProjectileThink() {

	for ( local projectile; projectile = Entities.FindByClassname( projectile, "tf_projectile*" ); ) {

		if ( projectile.GetEFlags() & EFL_USER ) continue

		SetPropBool( projectile, STRING_NETPROP_PURGESTRINGS, true )

		local scope = PopExtUtil.GetEntScope( projectile )
		local owner = projectile.GetOwner()

		if ( owner && owner.IsValid() ) {

			local owner_scope = PopExtUtil.GetEntScope( owner )

			owner_scope.PRESERVED.active_projectiles[projectile.entindex()] <- [projectile, Time()]

			PopExtUtil.SetDestroyCallback( projectile, function() {

				if ( self.entindex() in owner_scope.PRESERVED.active_projectiles )
					delete owner_scope.PRESERVED.active_projectiles[self.entindex()]
			})
		}

		projectile.AddEFlags( EFL_USER )
	}
}

POP_EVENT_HOOK( "player_activate", "MainPlayerActivate", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = PopExtUtil.GetEntScope( player )

	if ( !("PlayerThinkTable" in scope) )
		scope.PlayerThinkTable <- {}

}, EVENT_WRAPPER_MAIN)

POP_EVENT_HOOK( "player_team", "MainPlayerTeam", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	if ( !player || !player.IsValid() ) return
	local scope = PopExtUtil.GetEntScope( player )

	if ( !( "PlayerThinkTable" in scope ) )
		scope.PlayerThinkTable <- {}

	if ( params.oldteam > TEAM_SPECTATOR && params.team == TEAM_SPECTATOR && !player.IsAlive() ) {

		foreach( ent in scope.PRESERVED.kill_on_spawn )
			if ( ent && ent.IsValid() && ent.GetOwner() == player )
				ent.Kill()

		scope.PRESERVED.kill_on_spawn.clear()
	}

}, EVENT_WRAPPER_MAIN)

POP_EVENT_HOOK( "post_inventory_application", "MainPostInventoryApplication", function( params ) {

	if ( GetRoundState() == 3 ) return

	local player = GetPlayerFromUserID( params.userid )

	if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) ) return

	PopExtMain.PlayerCleanup( player )

	local scope = PopExtUtil.GetEntScope( player )

	if ( !( "PlayerThinkTable" in scope ) )
		scope.PlayerThinkTable <- {}

	if ( player.IsBotOfType( TF_BOT_TYPE ) && "PopExtBotBehavior" in ROOT ) {

		scope.aibot <- PopExtBotBehavior( player )

		function BotThink() {
			scope.aibot.OnUpdate()
		}

		PopExtUtil.AddThink( player, BotThink )
	}

	if ( player.GetPlayerClass() > 7 ) {
		scope.buildings <- []
	}

}, EVENT_WRAPPER_MAIN)

POP_EVENT_HOOK( "player_changeclass", "MainChangeClassCleanup", function( params ) {

	local player = GetPlayerFromUserID( params.userid )

	for ( local model; model = FindByName( model, "__popext_bonemerge_model" ); )
		if ( model.GetMoveParent() == player )
			EntFireByHandle( model, "Kill", "", -1, null, null )

}, EVENT_WRAPPER_MAIN)

//clean up bot scope on death
POP_EVENT_HOOK( "player_death", "MainDeathCleanup", function( params ) {

	local player = GetPlayerFromUserID( params.userid )

	if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

	// clean up all entities that should be killed on death
	local scope = player.GetScriptScope()
	if ( "PRESERVED" in scope ) 
		foreach ( ent in scope.PRESERVED.kill_on_death )
			if ( ent && ent.IsValid() && ent.GetOwner() == player )
				ent.Kill()

	PopExtMain.PlayerCleanup( player )

}, EVENT_WRAPPER_MAIN)

/*************************************
 * FINAL CLEANUP STEP, MUST RUN LAST *
 *************************************/
POP_EVENT_HOOK( "teamplay_round_start", "MainRoundStartCleanup", function( _ ) {

	// clean up lingering wearables/weapons
	for ( local wearable; wearable = FindByClassname( wearable, "tf_wea*" ); )
		if ( !wearable.GetOwner() || wearable.GetOwner().IsBotOfType( TF_BOT_TYPE ) )
			EntFireByHandle( wearable, "Kill", "", -1, null, null )

	foreach ( bot in PopExtUtil.BotArray )
		if ( bot.IsValid() && bot.GetTeam() == TF_TEAM_PVE_DEFENDERS )
			bot.ForceChangeTeam( TEAM_SPECTATOR, true )

	// TODO: this seemingly helps with script performance slowly drifting up on a long-running map
	// There were also other times when this hurt performance, memory caching stuff maybe?
	EntFire( "__popext_main", "CallScriptFunction", "collectgarbage", 0.2 )

	// same pop or manual cleanup flag set, don't run
	if ( __popname == GetPropString( objres, STRING_NETPROP_POPNAME ) || PopExtConfig.ManualCleanup )
		return

	PopExtMain.FullCleanup()

}) // does not run in EVENT_WRAPPER_MAIN on purpose, this event runs last

// populator.nut and tutorialtools.nut are unfinished and not included by default
// They can be manually included in the popfile using PopExtMain.IncludeModules( "populator", "tutorialtools" )
if ( PopExtConfig.IncludeAllModules ) {

	PopExtMain.IncludeModules(

		"hooks",
		"popextensions",
		"wavebar",
		"robotvoicelines",
		"customattributes",
		"missionattributes",
		"customweapons",
		"botbehavior",
		"tags",
		"spawntemplate"/*,
		"populator",
		"tutorialtools" */
	)
}

//HACK: forces post_inventory_application to fire on pop load
PopExtUtil.RunWithDelay( SINGLE_TICK, function() {

	for ( local i = 1, player; i <= MAX_CLIENTS; i++ )
		if ( player = PlayerInstanceFromIndex( i ) ) 
			player.Regenerate( true )
})