// All Global Utility Functions go here

POPEXT_CREATE_SCOPE( "__popext_util", "PopExtUtil", "PopExtUtilEntity", "PopExtUtilThink" )

PopExtUtil.HumanTable 	 <- {} // player caching for faster player handle/userid lookups
PopExtUtil.BotTable 	 <- {}
PopExtUtil.PlayerTable   <- {}

PopExtUtil.HumanArray 	 <- [] // array variants, backwards compatible
PopExtUtil.BotArray 	 <- []
PopExtUtil.PlayerArray   <- []

// entity caching for faster iteration/lookup
PopExtUtil.EntTable   	 <- {

	[First()] = {

		name 	  = First().GetName()
		scope     = null
		entidx    = 0
		classname = "worldspawn"
		scriptid  = First().GetScriptId()
		thinkfunc = ""
		cachetime = Time()
	}

	ByName          = { cachetime = Time(), BigNet = { [ FindByName( null, "BigNet" ) ] = {} } }
	ByClassname     = { cachetime = Time(), worldspawn = { [ First() ] = {} } }
	ByModel         = { cachetime = Time(), [ First().GetModelName() ] = { [ First() ] = {} } }
	ByTarget        = { cachetime = Time(), [ GetPropString( First(), "m_target" ) ] = { [ First() ] = {} } }
	ByScriptID      = { cachetime = Time(), [ First().GetScriptId() ] = { [ First() ] = {} } }
	ByThinkFunc     = { cachetime = Time(), [ First().GetScriptThinkFunc() ] = { [ First() ] = {} } }

}.setdelegate({

	function _newslot( key, value ) {

		if ( typeof key != "instance" || !( key instanceof CBaseEntity ) )
			Assert( false, format( "Invalid entity key: %s", key.tostring() ) )
		
		if ( !value ) {

			value = {

				self      = key
				name 	  = key.GetName()
				scope     = key.GetScriptScope()
				entidx    = key.entindex()
				classname = key.GetClassname()
				scriptid  = key.GetScriptId()
				thinkfunc = key.GetScriptThinkFunc()
				cachetime = Time()
			}
		}

		this.rawset( key, value )
	}

	function _delslot( key ) {

		if ( key && key.IsValid() )
			EntFireByHandle( key, "Kill", "", -1, null, null )

		this.rawdelete( key )
	}
})

// class index -> class string lookup
PopExtUtil.Classes 	  	 <- ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer", "civilian"]
PopExtUtil.ClassesCaps   <- ["", "Scout", "Sniper", "Soldier", "Demoman", "Medic", "Heavy", "Pyro", "Spy", "Engineer", "Civilian"]
PopExtUtil.Slots   	  	 <- ["slot_primary", "slot_secondary", "slot_melee", "slot_utility", "slot_building", "slot_pda", "slot_pda2"]

PopExtUtil.AllNavAreas   <- {} // gets filled by GetAllAreas at the end of this file
PopExtUtil.ConVars       <- {} // convar tracking to revert to original values
PopExtUtil.EntShredder   <- {} // entity shredder. One entity is deleted per think.

PopExtUtil.ROBOT_ARM_PATHS <- [

	"", // Dummy
	"models/weapons/c_models/c_scout_bot_arms.mdl",
	"models/weapons/c_models/c_sniper_bot_arms.mdl",
	"models/weapons/c_models/c_soldier_bot_arms.mdl",
	"models/weapons/c_models/c_demo_bot_arms.mdl",
	"models/weapons/c_models/c_medic_bot_arms.mdl",
	"models/weapons/c_models/c_heavy_bot_arms.mdl",
	"models/weapons/c_models/c_pyro_bot_arms.mdl",
	"models/weapons/c_models/c_spy_bot_arms.mdl",
	"models/weapons/c_models/c_engineer_bot_arms.mdl",
	"", // Civilian
]

PopExtUtil.HUMAN_ARM_PATHS <- [

	"models/weapons/c_models/c_medic_arms.mdl", //dummy
	"models/weapons/c_models/c_scout_arms.mdl",
	"models/weapons/c_models/c_sniper_arms.mdl",
	"models/weapons/c_models/c_soldier_arms.mdl",
	"models/weapons/c_models/c_demo_arms.mdl",
	"models/weapons/c_models/c_medic_arms.mdl",
	"models/weapons/c_models/c_heavy_arms.mdl",
	"models/weapons/c_models/c_pyro_arms.mdl",
	"models/weapons/c_models/c_spy_arms.mdl",
	"models/weapons/c_models/c_engineer_arms.mdl",
	"models/weapons/c_models/c_engineer_gunslinger.mdl",	//CIVILIAN/Gunslinger
]

PopExtUtil.MaxAmmoTable <- {

	[TF_CLASS_SCOUT] = {
		["tf_weapon_scattergun"]            = 32,
		["tf_weapon_handgun_scout_primary"] = 32,
		["tf_weapon_soda_popper"]           = 32,
		["tf_weapon_pep_brawler_blaster"]   = 32,

		["tf_weapon_handgun_scout_secondary"] = 36,
		["tf_weapon_pistol"]                  = 36,
	},
	[TF_CLASS_SOLDIER] = {
		["tf_weapon_rocketlauncher"]           = 20,
		["tf_weapon_rocketlauncher_directhit"] = 20,
		["tf_weapon_rocketlauncher_airstrike"] = 20,
		[ID_ROCKET_JUMPER] = 60,

		["tf_weapon_shotgun_soldier"] = 32,
		["tf_weapon_shotgun"]         = 32,
	},
	[TF_CLASS_PYRO] = {
		["tf_weapon_flamethrower"]            = 200,
		["tf_weapon_rocketlauncher_fireball"] = 40,

		["tf_weapon_shotgun_pyro"] = 32,
		["tf_weapon_shotgun"]      = 32,
		["tf_weapon_flaregun"]     = 16,
	},
	[TF_CLASS_DEMOMAN] = {
		["tf_weapon_grenadelauncher"] = 16,
		["tf_weapon_cannon"]          = 16,

		["tf_weapon_pipebomblauncher"] = 24,
		[ID_STICKYBOMB_JUMPER] = 72,
	},
	[TF_CLASS_HEAVYWEAPONS] = {
		["tf_weapon_minigun"]     = 200,

		["tf_weapon_shotgun_hwg"] = 32,
		["tf_weapon_shotgun"]     = 32,
	},
	[TF_CLASS_ENGINEER] = {
		["tf_weapon_shotgun"]                 = 32,
		["tf_weapon_sentry_revenge"]          = 32,
		["tf_weapon_shotgun_building_rescue"] = 16,
		[ID_SHOTGUN_PRIMARY] = 32,

		["tf_weapon_pistol"] = 200,
	},
	[TF_CLASS_MEDIC] = {
		["tf_weapon_syringegun_medic"] = 150,
		["tf_weapon_crossbow"]         = 38,
	},
	[TF_CLASS_SNIPER] = {
		["tf_weapon_sniperrifle"]         = 25,
		["tf_weapon_sniperrifle_decap"]   = 25,
		["tf_weapon_sniperrifle_classic"] = 25,
		["tf_weapon_compound_bow"]        = 12,

		["tf_weapon_smg"]         = 75,
		["tf_weapon_charged_smg"] = 75,
	},
	[TF_CLASS_SPY] = {
		["tf_weapon_revolver"] = 24,
	},
}

PopExtUtil.PROJECTILE_WEAPONS <- {

	tf_weapon_jar_milk 				   = true
	tf_weapon_cleaver 				   = true

	tf_weapon_rocketlauncher 		   = true
	tf_weapon_rocketlauncher_airstrike = true
	tf_weapon_rocketlauncher_directhit = true
	tf_weapon_particle_cannon 		   = true
	tf_weapon_raygun 				   = true

	tf_weapon_rocketlauncher_fireball  = true
	tf_weapon_flaregun 				   = true
	tf_weapon_flaregun_revenge 		   = true
	tf_weapon_jar_gas 				   = true

	tf_weapon_grenadelauncher  		   = true
	tf_weapon_cannon		  		   = true
	tf_weapon_pipebomblauncher 		   = true

	tf_weapon_shotgun_building_rescue  = true
	tf_weapon_drg_pomson 			   = true

	tf_weapon_syringegun_medic 		   = true

	tf_weapon_compound_bow 			   = true
	tf_weapon_jar 					   = true
}

PopExtUtil.ROMEVISION_MODELS <- {

	[1] = ["models/workshop/player/items/scout/tw_scoutbot_armor/tw_scoutbot_armor.mdl", "models/workshop/player/items/scout/tw_scoutbot_hat/tw_scoutbot_hat.mdl"],
	[2] = ["models/workshop/player/items/sniper/tw_sniperbot_armor/tw_sniperbot_armor.mdl", "models/workshop/player/items/sniper/tw_sniperbot_helmet/tw_sniperbot_helmet.mdl"],
	[3] = ["models/workshop/player/items/soldier/tw_soldierbot_armor/tw_soldierbot_armor.mdl", "models/workshop/player/items/soldier/tw_soldierbot_helmet/tw_soldierbot_helmet.mdl"],
	[4] = ["models/workshop/player/items/demo/tw_demobot_armor/tw_demobot_armor.mdl", "models/workshop/player/items/demo/tw_demobot_helmet/tw_demobot_helmet.mdl", "models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"],
	[5] = ["models/workshop/player/items/medic/tw_medibot_chariot/tw_medibot_chariot.mdl", "models/workshop/player/items/medic/tw_medibot_hat/tw_medibot_hat.mdl"],
	[6] = ["models/workshop/player/items/heavy/tw_heavybot_armor/tw_heavybot_armor.mdl", "models/workshop/player/items/heavy/tw_heavybot_helmet/tw_heavybot_helmet.mdl"],
	[7] = ["models/workshop/player/items/pyro/tw_pyrobot_armor/tw_pyrobot_armor.mdl", "models/workshop/player/items/pyro/tw_pyrobot_helmet/tw_pyrobot_helmet.mdl"],
	[8] = ["models/workshop/player/items/spy/tw_spybot_armor/tw_spybot_armor.mdl", "models/workshop/player/items/spy/tw_spybot_hood/tw_spybot_hood.mdl"],
	[9] = ["models/workshop/player/items/engineer/tw_engineerbot_armor/tw_engineerbot_armor.mdl", "models/workshop/player/items/engineer/tw_engineerbot_helmet/tw_engineerbot_helmet.mdl"],

}

PopExtUtil.ROMEVISION_ITEM_INDEXES <- {

	[1] = [ID_TW_SCOUTBOT_ARMOR, ID_TW_SCOUTBOT_HAT],
	[2] = [ID_TW_SNIPERBOT_ARMOR, ID_TW_SNIPERBOT_HELMET],
	[3] = [ID_TW_SOLDIERBOT_ARMOR, ID_TW_SOLDIERBOT_HELMET],
	[4] = [ID_TW_DEMOBOT_ARMOR, ID_TW_DEMOBOT_HELMET, ID_TW_SENTRYBUSTER],
	[5] = [ID_TW_MEDIBOT_CHARIOT, ID_TW_MEDIBOT_HAT],
	[6] = [ID_TW_HEAVYBOT_ARMOR, ID_TW_HEAVYBOT_HELMET],
	[7] = [ID_TW_PYROBOT_ARMOR, ID_TW_PYROBOT_HELMET],
	[8] = [ID_TW_SPYBOT_ARMOR, ID_TW_SPYBOT_HOOD],
	[9] = [ID_TW_ENGINEERBOT_ARMOR, ID_TW_ENGINEERBOT_HELMET],
}

PopExtUtil.ROCKET_LAUNCHER_CLASSNAMES <- [

	"tf_weapon_rocketlauncher",
	"tf_weapon_rocketlauncher_airstrike",
	"tf_weapon_rocketlauncher_directhit",
	"tf_weapon_particle_cannon",
]

PopExtUtil.DeflectableProjectiles <- {

	tf_projectile_arrow				   = 1 // Huntsman arrow, Rescue Ranger bolt
	tf_projectile_ball_ornament		   = 1 // Wrap Assassin
	tf_projectile_cleaver			   = 1 // Flying Guillotine
	tf_projectile_energy_ball		   = 1 // Cow Mangler charge shot
	tf_projectile_flare				   = 1 // Flare guns projectile
	tf_projectile_healing_bolt		   = 1 // Crusader's Crossbow
	tf_projectile_jar				   = 1 // Jarate
	tf_projectile_jar_gas			   = 1 // Gas Passer explosion
	tf_projectile_jar_milk			   = 1 // Mad Milk
	tf_projectile_lightningorb		   = 1 // Spell Variant from Short Circuit
	tf_projectile_mechanicalarmorb	   = 1 // Short Circuit energy ball
	tf_projectile_pipe				   = 1 // Grenade Launcher bomb
	tf_projectile_pipe_remote		   = 1 // Stickybomb Launcher bomb
	tf_projectile_rocket			   = 1 // Rocket Launcher rocket
	tf_projectile_sentryrocket		   = 1 // Sentry gun rocket
	tf_projectile_stun_ball			   = 1 // Baseball
}

function PopExtUtil::_OnDestroy() {

	ResetConvars( false )

	foreach( key in [ "Explanation", "Info" ] )
		if ( key in ROOT )
			delete ROOT[ key ]

	foreach( i, ent in EntShredder.keys() ) {
		if (ent && ent.IsValid()) {
			SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
			EntFireByHandle( ent, "Kill", "", i * 0.1, null, null )
		}
	}
}

function PopExtUtil::EntityManager() {

	foreach( i, ent in EntShredder.keys() ) {

		if ( ent && ent.IsValid() ) {

			SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
			EntFireByHandle( ent, "Kill", null, -1, null, null )
		}
		delete EntShredder[ent]

		if ( !(i % 150 ) && i < ( MAX_EDICTS / 4 ) )
			yield ent
	}

	return null
}

local entmanager_cooldown = 0.0
local gen = null
function PopExtUtil::ThinkTable::EntityManagerThink() {

	if ( Time() < entmanager_cooldown )
		return

	if ( !EntShredder.len() ) {
		entmanager_cooldown = Time() + 0.5
		return
	}

	if ( !gen || gen.getstatus() == "dead" ) 
		gen = EntityManager()

	resume gen
	// resume EntityManager()

	entmanager_cooldown = 0.0
}

function PopExtUtil::GetEntScope( ent ) {

	local scope = ent.GetScriptScope() || ( ent.ValidateScriptScope(), ent.GetScriptScope() )

	if ( !("PRESERVED" in scope ) )
		scope.PRESERVED <- PopExtMain.ScopePreserved

	return scope
}

function PopExtUtil::TouchCrashFix() { return activator && activator.IsValid() }

function PopExtUtil::SetTargetname( ent, name ) {

	local oldname = GetPropString( ent, STRING_NETPROP_NAME )
	SetPropString( ent, STRING_NETPROP_NAME, name )

	PURGE_STRINGS( ent.GetScriptId(), oldname )
}

function PopExtUtil::PurgeGameString( str, urgent = false ) {

	if ( urgent ) {

		local tempent = CreateByClassname( "logic_autosave" )
		SetTargetname( tempent, str )
		SetPropBool( tempent, STRING_NETPROP_PURGESTRINGS, true )
		tempent.Kill()
		return
	}

	SpawnEnt( "logic_autosave", str, true )
}

// spawn permanent ents or tempents that are automatically wiped out on map reset/fixed timer
function PopExtUtil::SpawnEnt( ... ) {

	local classname = vargv[0]
	local name = 1 in vargv ? vargv[1] : UniqueString() + classname
	local temp = 2 in vargv ? vargv[2] : false
	local args = 3 in vargv ? vargv.slice( 3 ) : null

	local ent = CreateByClassname( classname )
	SetTargetname( ent, name )

	if ( args && args.len() ) {

		for (local i = 0; i < args.len(); i += 2) {

			if ( !(i in args) || !(i + 1 in args) )
				break

			ent.KeyValueFromString( args[i], args[i + 1].tostring() )
		}
	}

	if ( temp ) {
		EntShredder[ent] <- ent.GetScriptId()
		return ent
	}

	ent.ValidateScriptScope()

	// auto-detect triggers
	if ( HasProp( ent, "m_hTouchingEntities" ) ) {

		SetPropInt( ent, "m_spawnflags", SF_TRIGGER_ALLOW_CLIENTS )
		local scope = GetEntScope( ent )
		scope.InputStartTouch <- TouchCrashFix
		scope.Inputstarttouch <- TouchCrashFix
		scope.InputEndTouch <- TouchCrashFix
		scope.Inputendtouch <- TouchCrashFix
		DispatchSpawn( ent )
		ent.SetSolid( SOLID_BBOX )
		ent.SetSize( sizemin, sizemax )
	}

	SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
	if ( "PopGameStrings" in ROOT ) {
		PopGameStrings.AddStrings( ent.GetClassname(), ent.GetScriptId() )
	}

	return ent
}

PopExtUtil.Worldspawn 		 <- First()
PopExtUtil.StartRelay 		 <- FindByName( null, "wave_start_relay" )
PopExtUtil.FinishedRelay 	 <- FindByName( null, "wave_finished_relay" )
PopExtUtil.GameRules 		 <- FindByClassname( null, "tf_gamerules" )
PopExtUtil.ObjectiveResource <- FindByClassname( null, "tf_objective_resource" )
PopExtUtil.MonsterResource   <- FindByClassname( null, "monster_resource" )
PopExtUtil.MvMLogicEnt 	  	 <- FindByClassname( null, "tf_logic_mann_vs_machine" )
PopExtUtil.MvMStatsEnt 	  	 <- FindByClassname( null, "tf_mann_vs_machine_stats" )
PopExtUtil.PlayerManager 	 <- FindByClassname( null, "tf_player_manager" )
PopExtUtil.TriggerHurt 	     <- PopExtUtil.SpawnEnt( "trigger_hurt", "__popext_triggerhurt" )
PopExtUtil.ClientCommand 	 <- PopExtUtil.SpawnEnt( "point_clientcommand", "__popext_clientcommand" )
PopExtUtil.GameRoundWin 	 <- PopExtUtil.SpawnEnt( "game_round_win", "__popext_roundwin", false, "TeamNum", TF_TEAM_PVE_INVADERS, "force_map_reset", 1 )
PopExtUtil.RespawnOverride   <- PopExtUtil.SpawnEnt( "trigger_player_respawn_override", "__popext_respawnoverride" )
PopExtUtil.TriggerParticle   <- PopExtUtil.SpawnEnt( "trigger_particle", "__popext_triggerparticle" )

PopExtUtil.CommentaryNode	 <- @() FindByName( null, "__popext_commentary_node" ) ||
								PopExtUtil.SpawnEnt( "point_commentary_node", "__popext_commentary_node", true, "commentaryfile", " ", "commentaryfilenohdr", " " )

PopExtUtil.PopInterface 	 <- FindByClassname( null, "point_populator_interface" ) ||
								PopExtUtil.SpawnEnt( "point_populator_interface", "__popext_pop_interface" )

PopExtUtil.NavInterface 	 <- FindByClassname( null, "tf_point_nav_interface" ) ||
								PopExtUtil.SpawnEnt( "tf_point_nav_interface", "__popext_nav_interface" )

PopExtUtil.IsWaveStarted 	 <- false // check a global variable instead of accessing a netprop every time to check if we are between waves.
PopExtUtil.CurrentWaveNum 	 <- GetPropInt( PopExtUtil.ObjectiveResource, "m_nMannVsMachineWaveCount" )
PopExtUtil.IsLinux 		  	 <- RAND_MAX != 32767

// all the one-liners
function PopExtUtil::ShowMessage( message ) 		  { ClientPrint( null, HUD_PRINTCENTER, message ) }
function PopExtUtil::WeaponSwitchSlot( player, slot ) { EntFire( "__popext_clientcommand", "Command", format( "slot%d", slot + 1 ), -1, player ) }
function PopExtUtil::SwitchWeaponSlot( player, slot ) { EntFire( "__popext_clientcommand", "Command", format( "slot%d", slot + 1 ), -1, player ) }
function PopExtUtil::ShowHintMessage( message ) 	  { SendGlobalGameEvent( "player_hintmessage", {hintmessage = message} ) }
function PopExtUtil::HideAnnotation( id = 0 ) 		  { SendGlobalGameEvent( "hide_annotation", {id = id} ) }
function PopExtUtil::SetItemIndex( item, index ) 	  { SetPropInt( item, STRING_NETPROP_ITEMDEF, index ) }
function PopExtUtil::PrecacheParticle( name ) 		  { PrecacheEntityFromTable( { classname = "info_particle_system", effect_name = name } ) }
function PopExtUtil::PrecacheModelGibs( name ) 		  { PrecacheEntityFromTable( { classname = "tf_generic_bomb", model = name } ) }
function PopExtUtil::DisableCloak( player ) 		  { SetPropFloat( player, "m_Shared.m_flStealthNextChangeTime", Time() * INT_MAX ) }
function PopExtUtil::SetPlayerName( player, name ) 	  { SetPropString( player, "m_szNetname", name ) }
function PopExtUtil::PlayerRespawn() 				  { self.ForceRegenerateAndRespawn() }
function PopExtUtil::SetEffect( ent, value ) 		  { SetPropInt( ent, "m_fEffects", value ) }

function PopExtUtil::GetPlayerSteamID( player ) 	  { return GetPropString( player, "m_szNetworkIDString" ) }
function PopExtUtil::IsDucking( player ) 			  { return player.GetFlags() & FL_DUCKING }
function PopExtUtil::IsOnGround( player ) 			  { return player.GetFlags() & FL_ONGROUND }
function PopExtUtil::GetItemIndex( item ) 			  { return GetPropInt( item, STRING_NETPROP_ITEMDEF ) }
function PopExtUtil::GetHammerID( ent ) 			  { return GetPropInt( ent, "m_iHammerID" ) }
function PopExtUtil::GetSpawnFlags( ent ) 			  { return GetPropInt( ent, "m_spawnflags" ) }
function PopExtUtil::GetPopfileName() 	 			  { return GetPropString( ObjectiveResource, STRING_NETPROP_POPNAME ) }
function PopExtUtil::GetPlayerName( player ) 		  { return GetPropString( player, "m_szNetname" ) }
function PopExtUtil::GetPlayerUserID( player ) 		  { return GetPropIntArray( PlayerManager, "m_iUserID", player.entindex() ) }
function PopExtUtil::InUpgradeZone( player ) 		  { return GetPropBool( player, "m_Shared.m_bInUpgradeZone" ) }
function PopExtUtil::InButton( player, button ) 	  { return GetPropInt( player, "m_nButtons" ) & button }
function PopExtUtil::HasEffect( ent, value ) 		  { return GetPropInt( ent, "m_fEffects" ) == value }

function PopExtUtil::IsLinuxServer() {
	PopExtMain.Error.DeprecationWarning( "PopExtUtil.IsLinuxServer()", "PopExtUtil.IsLinux")
	return RAND_MAX != 32767
}

function PopExtUtil::ForceChangeClass( player, classindex = 1 ) {

	player.SetPlayerClass( classindex )
	SetPropInt( player, "m_Shared.m_iDesiredPlayerClass", classindex )
	player.ForceRegenerateAndRespawn()
}

function PopExtUtil::PlayerClassCount() {

	local classes = array( TF_CLASS_COUNT_ALL, 0 )
	foreach ( player in HumanArray )
		classes[player.GetPlayerClass()]++
	return classes
}

function PopExtUtil::ChangePlayerTeamMvM( player, teamnum = TF_TEAM_PVE_INVADERS, forcerespawn = false ) {

	if ( GameRules ) {
		SetPropBool( GameRules, "m_bPlayingMannVsMachine", false )
		player.ForceChangeTeam( teamnum, false )
		SetPropBool( GameRules, "m_bPlayingMannVsMachine", true )

		if ( forcerespawn )
			ScriptEntFireSafe( player, "self.ForceRespawn()", SINGLE_TICK )
	}
}

// example
// ChatPrint( null, "{player} {color}guessed the answer first!", player, TF_COLOR_DEFAULT )
function PopExtUtil::ShowChatMessage( target, fmt, ... ) {

	local result = "\x07FFCC22[Map] "
	local start = 0
	local end = fmt.find( "{" )
	local i = 0
	while ( end != null ) {
		result += fmt.slice( start, end )
		start = end + 1
		end = fmt.find( "}", start )
		if ( end == null )
			break
		local word = fmt.slice( start, end )

		if ( word == "player" ) {
			local player = vargv[i++]

			local team = player.GetTeam()
			if ( team == TF_TEAM_RED )
				result += "\x07" + TF_COLOR_RED
			else if ( team == TF_TEAM_BLUE )
				result += "\x07" + TF_COLOR_BLUE
			else
				result += "\x07" + TF_COLOR_SPEC
			result += GetPlayerName( player )
		}
		else if ( word == "color" ) {
			result += "\x07" + vargv[i++]
		}
		else if ( word == "int" || word == "float" ) {
			result += vargv[i++].tostring()
		}
		else if ( word == "str" ) {
			result += vargv[i++]
		}
		else {
			result += "{" + word + "}"
		}

		start = end + 1
		end = fmt.find( "{", start )
	}

	result += fmt.slice( start )

	ClientPrint( target, HUD_PRINTTALK, result )
}

function PopExtUtil::CopyTable( table, keyfunc = null, valuefunc = null ) {

	if ( table == null || typeof table != "table" ) return

	local newtable = {}

	foreach ( key, value in table ) {

		//run optional functions on the key and value
		if ( keyfunc != null )
			key = keyfunc( key )

		if ( valuefunc != null )
			value = valuefunc( value )

		newtable[key] <- value
		if ( typeof value == "table" || typeof value == "array" ) {

			newtable[key] = CopyTable( value )
		}
		else {

			newtable[key] <- value
		}
	}
	return newtable
}

function PopExtUtil::HexOrIntToRgb( hex_or_int, alpha = false, return_as = null ) {

	local rgba = [0, 0, 0, 255]

	if ( typeof hex_or_int == "string" ) {

		rgba[0] = hex_or_int.slice( 0, 2 ).tointeger( 16 )
		rgba[1] = hex_or_int.slice( 2, 4 ).tointeger( 16 )
		rgba[2] = hex_or_int.slice( 4, 6 ).tointeger( 16 )

		if ( alpha )
			rgba[3] = hex_or_int.slice( 6, 8 ).tointeger( 16 )
	}
	else if ( typeof hex_or_int == "integer" ) {

	rgba[0] = hex_or_int & 0xFF
	rgba[1] = ( hex_or_int >> 8 ) & 0xFF
	rgba[2] = ( hex_or_int >> 16 ) & 0xFF

		if ( alpha )
			rgba[3] = ( hex_or_int >> 24 ) & 0xFF
	}

	if ( return_as ) {

		switch ( return_as ) {

			case "int":
				return rgba[0] | ( rgba[1] << 8 ) | ( rgba[2] << 16 ) | ( rgba[3] << 24 )

			case "hex":
				return format( "#%02X%02X%02X%02X", rgba[0], rgba[1], rgba[2], rgba[3] )

			default:
				PopExtMain.Error.ValueError( return_as, "PopExtUtil.HexOrIntToRgb", "expected 'int', 'hex', or null" )
				return rgba
		}
	}

	return rgba
}

function PopExtUtil::HexToRgb( hex ) {

	PopExtMain.Error.DeprecationWarning( "PopExtUtil.HexToRgb", "PopExtUtil.HexOrIntToRgb" )

	// Extract the RGB values
	local r = hex.slice( 0, 2 ).tointeger( 16 )
	local g = hex.slice( 2, 4 ).tointeger( 16 )
	local b = hex.slice( 4, 6 ).tointeger( 16 )

	// Return the RGB values as an array
	return [r, g, b]
}

function PopExtUtil::CountAlivePlayers( countbots = false, printout = false ) {

	if ( !IsWaveStarted ) return

	local playersalive = 0

	PopExtUtil.ValidatePlayerTables()

	local player_array = countbots ? BotArray : HumanArray

	foreach ( player in player_array )
		if ( player.IsAlive() )
			playersalive++

	if ( printout ) {

		ClientPrint( null, HUD_PRINTTALK, format( "Players Alive: %d", playersalive ) )
		printf( "Players Alive: %d\n", playersalive )
	}

	return playersalive
}

function PopExtUtil::CountAliveBots( printout = false ) {

	PopExtMain.Error.DeprecationWarning( "PopExtUtil.CountAliveBots", "PopExtUtil.CountAlivePlayers( true )" )
	return CountAlivePlayers( true, printout )
}

function PopExtUtil::SetParentLocalOriginDo( child, parent, attachment = null ) {

	SetPropEntity( child, "m_hMovePeer", parent.FirstMoveChild() )
	SetPropEntity( parent, "m_hMoveChild", child )
	SetPropEntity( child, "m_hMoveParent", parent )

	local orig_pos = child.GetLocalOrigin()
	child.SetLocalOrigin( orig_pos + Vector( 0, 0, 1 ) )
	child.SetLocalOrigin( orig_pos )

	local orig_angles = child.GetLocalAngles()
	child.SetLocalAngles( orig_angles + QAngle( 0, 0, 1 ) )
	child.SetLocalAngles( orig_angles )

	local orig_vel = child.GetAbsVelocity()
	child.SetAbsVelocity( orig_vel + Vector( 0, 0, 1 ) )
	child.SetAbsVelocity( orig_vel )

	EntFireByHandle( child, "SetParent", "!activator", -1, parent, parent )
	if ( attachment != null ) {
		SetPropEntity( child, "m_iParentAttachment", parent.LookupAttachment( attachment ) )
		EntFireByHandle( child, "SetParentAttachmentMaintainOffset", attachment, -1, parent, parent )
	}
}

// Sets parent immediately in a dirty way. Does not retain absolute origin, retains local origin instead.
// child parameter may also be an array of entities
function PopExtUtil::SetParentLocalOrigin( child, parent, attachment = null ) {

	if ( typeof child == "array" )
		foreach( child_in in child )
			SetParentLocalOriginDo( child_in, parent, attachment )
	else
		SetParentLocalOriginDo( child, parent, attachment )
}

// Setup collision bounds of a trigger entity
// TODO: probably obsolete? what does this do that SetSize doesn't?
function PopExtUtil::SetupTriggerBounds( trigger, mins = null, maxs = null ) {

	trigger.SetModel( "models/weapons/w_models/w_rocket.mdl" )

	if ( mins != null ) {
		SetPropVector( trigger, "m_Collision.m_vecMinsPreScaled", mins )
		SetPropVector( trigger, "m_Collision.m_vecMins", mins )
	}
	if ( maxs != null ) {
		SetPropVector( trigger, "m_Collision.m_vecMaxsPreScaled", maxs )
		SetPropVector( trigger, "m_Collision.m_vecMaxs", maxs )
	}

	trigger.SetSolid( SOLID_BBOX )
}

function PopExtUtil::PrintTable( table ) {

	if ( table == null || ( typeof table != "table" && typeof table != "array" ) ) {
		ClientPrint( null, 2, ""+table )
		return
	}

	DoPrintTable( table, 0 )
}

function PopExtUtil::DoPrintTable( table, indent ) {

	local line = ""
	for ( local i = 0; i < indent; i++ ) {
		line += " "
	}
	line += typeof table == "array" ? "[" : "{"

	ClientPrint( null, 2, line )

	indent += 2
	foreach( k, v in table ) {
		line = ""
		for ( local i = 0; i < indent; i++ ) {
			line += " "
		}
		line += k.tostring()
		line += " = "

		if ( typeof v == "table" || typeof v == "array" ) {
			ClientPrint( null, 2, line )
			DoPrintTable( v, indent )
		}
		else {
			try {
				line += v.tostring()
			}
			catch ( e ) {
				line += typeof v
			}

			ClientPrint( null, 2, line )
		}
	}
	indent -= 2

	line = ""
	for ( local i = 0; i < indent; i++ ) {
		line += " "
	}
	line += typeof table == "array" ? "]" : "}"

	ClientPrint( null, 2, line )
}

// LEGACY: THIS DOES NOT APPLY TO RAGDOLLS! use GiveWearableItem instead
function PopExtUtil::CreatePlayerWearable( player, model, bonemerge = true, attachment = null, auto_destroy = true ) {

	if ( bonemerge )
		PopExtMain.Error.DeprecationWarning( "PopExtUtil.CreatePlayerWearable", "PopExtUtil.GiveWearableItem" )

	local model_index = GetModelIndex( model )
	if ( model_index == -1 )
		model_index = PrecacheModel( model )

	local wearable = CreateByClassname( "tf_wearable" )
	SetPropInt( wearable, STRING_NETPROP_MODELINDEX, model_index )
	wearable.SetSkin( player.GetTeam() )
	wearable.SetTeam( player.GetTeam() )
	wearable.SetSolidFlags( 4 )
	wearable.SetCollisionGroup( 11 )
	SetPropBool( wearable, STRING_NETPROP_ATTACH, true )
	SetPropBool( wearable, STRING_NETPROP_INIT, true )
	SetPropInt( wearable, "m_AttributeManager.m_Item.m_iEntityQuality", 0 )
	SetPropInt( wearable, "m_AttributeManager.m_Item.m_iEntityLevel", 1 )
	SetPropInt( wearable, "m_AttributeManager.m_Item.m_iItemIDLow", 2048 )
	SetPropInt( wearable, "m_AttributeManager.m_Item.m_iItemIDHigh", 0 )

	wearable.SetOwner( player )
	DispatchSpawn( wearable )
	SetPropBool( wearable, STRING_NETPROP_PURGESTRINGS, true )
	SetPropInt( wearable, "m_fEffects", bonemerge ? EF_BONEMERGE|EF_BONEMERGE_FASTCULL : 0 )
	SetParentLocalOrigin( wearable, player, attachment )

	if ( auto_destroy )
		player.GetScriptScope().PRESERVED.kill_on_death.append( wearable )

	return wearable
}

// Make a fake wearable that is attached to the player.  Applies to ragdolls
// The wearable is automatically removed on respawn.
function PopExtUtil::GiveWearableItem( player, item_id, model = null, on_death = false ) {

	local dummy = CreateByClassname( "tf_weapon_parachute" )
	SetPropInt( dummy, STRING_NETPROP_ITEMDEF, ID_BASE_JUMPER )
	SetPropBool( dummy, STRING_NETPROP_INIT, true )
	dummy.SetTeam( player.GetTeam() )
	DispatchSpawn( dummy )
	player.Weapon_Equip( dummy )

	local wearable = GetPropEntity( dummy, "m_hExtraWearable" )
	dummy.Kill()

	InitEconItem( wearable, item_id )
	DispatchSpawn( wearable )
	SetTargetname( wearable, format( "__popext_wearable_%d", wearable.entindex() ) )
	SetPropBool( wearable, STRING_NETPROP_PURGESTRINGS, true )

	if ( model ) 
		wearable.SetModelSimple( model )

	// avoid infinite loops from post_inventory_application hooks
	player.AddEFlags( EFL_CUSTOM_WEARABLE )
	SendGlobalGameEvent( "post_inventory_application", { userid = PlayerTable[ player ] } )
	player.RemoveEFlags( EFL_CUSTOM_WEARABLE )

	wearable.SetOwner( player )

	player.GetScriptScope().PRESERVED[on_death ? "kill_on_death" : "kill_on_spawn"].append( wearable )

	return wearable
}

function PopExtUtil::StripWeapon( player, slot = -1 ) {

	if ( slot == -1 ) 
		slot = player.GetActiveWeapon().GetSlot()

	local weapon = GetItemInSlot( player, slot )

	if ( weapon && weapon.IsValid() )
		weapon.Kill()
	
	return weapon
}

// big function for applying both custom and vanilla attributes to either a player or weapon
function PopExtUtil::SetPlayerAttributes( player, attrib, value, item = null, customwep_force = false, showhidden = false ) {

	// the table is for handling weapon-agnostic attributes for our custom attributes by applying them to our entire loadout
	// for applying non-custom attributes to the entire player loadout look at PopExtUtil.AddAttributeToLoadout
	local items = {}

	// setting maxhealth attribs doesn't update current HP
	local healthattribs = {
		"max health additive bonus" : null,
		"max health additive penalty": null,
		"SET BONUS: max health additive bonus": null,
		"hidden maxhealth non buffed": null,
	}

	// some attributes require special handling of their values
	local specialattribs = {

		"paintkit_proto_def_index" : function() {
			value = casti2f( value.tointeger() )
		}
	}

	if ( attrib in specialattribs )
		specialattribs[attrib]()

	// get the item handle for our weapon
	local item_handle = HasItemInLoadout( player, item )

	local scope = player.GetScriptScope()

	// handle custom weapons first
	if ( "CustomWeapons" in scope && item_handle in scope.CustomWeapons && !customwep_force ) {

		PopExtMain.Error.DebugLog( "Ignoring attributes for custom weapon: " + item )
		return
	}

	// add the item to our items table
	else if ( item_handle && item_handle.IsValid() )
		items[item_handle] <- [attrib, value]
	else
		// null/invalid item handle, apply the attribute to our entire loadout
		ForEachItem( player, @( item ) items[item] <- [attrib, value], true )

	//do the customattributes check first, since we replace some vanilla attributes
	local customattr_function = PopExtAttributes.GetAttributeFunctionFromStringName( attrib )

	if ( "PopExtAttributes" in ROOT && customattr_function in PopExtAttributes.Attrs ) {

		//easy access table in player scope for our items and their attributes
		scope.CustomAttrItems <- items

		// wipe out old event hooks
		POP_EVENT_HOOK( "*", format( "%s_%d_*", customattr_function, PlayerTable[ player ] ), null, EVENT_WRAPPER_CUSTOMATTR )

		//cleanup item thinks
		foreach( item in items.keys() )
			PopExtAttributes.CleanupFunctionTable( item, "ItemThinkTable", customattr_function )

		foreach( item, attrs in items ) {

			if ( !HasItemInLoadout( player, item ) )
				continue

			if ( !("ItemThinkTable" in scope) )
				AddThink( item, "" )

			PopExtAttributes.SetDesc( player, attrib )

			PopExtAttributes.Attrs[customattr_function]( player, item, value )

			PopExtAttributes.RefreshDescs( player )

			if ( PopExtConfig.DebugText )
				foreach( attr, value in attrs )
					PopExtMain.Error.DebugLog( format( "Added custom attribute '%s' to player %d ( weapon %d )", customattr_function, PlayerTable[ player ], item ? item.entindex() : -1 ) )
		}
	}
	else if ( "Attributes" in PopExtItems && attrib in PopExtItems.Attributes ) {

		if ( "attribute_type" in PopExtItems.Attributes[attrib] && PopExtItems.Attributes[attrib]["attribute_type"] == "string" )
			PopExtMain.Error.RaiseValueError( "PlayerAttributes", attrib, "Cannot set string attributes!" )
		else {

			// player attributes
			// TODO: does this need to be delayed?
			if ( !item_handle || !( item_handle instanceof CEconEntity ) )
				ScriptEntFireSafe( player, format( "self.AddCustomAttribute( `%s`, %.2f, -1 )", attrib, value.tofloat() ), -1 )
			else {

				// custom weapons need their attributes applied immediately
				if ( "CustomWeapons" in scope && item_handle in scope.CustomWeapons ) {

					item_handle.AddAttribute( attrib, value.tofloat(), -1 )
					item_handle.ReapplyProvision()
				}
				else {

					// warpaint attributes need the full float value, rest can be truncated for cleaner printouts
					local formatstr = attrib in specialattribs ? @"%1.8e" : "%.2f"
					local finalstr = format( "self.AddAttribute( `%s`, %s, -1 ); self.ReapplyProvision()", attrib, formatstr )
					ScriptEntFireSafe( item_handle, format( finalstr, value.tofloat() ), -1 )
				}
			}

			if ( attrib in healthattribs )
				ScriptEntFireSafe( player, "self.SetHealth( self.GetMaxHealth() )", -1 )
		}
		// add hidden attributes to our custom attribute display
		if (
			showhidden
			&& "hidden" in PopExtItems.Attributes[attrib]
			&& PopExtItems.Attributes[attrib]["hidden"] == "1"
		) {
			scope.attribinfo[attrib] <- format( "%s: %s", attrib, value.tostring() )
			PopExtAttributes.RefreshDescs( player )
		}
	}
	else {

		local errorstr = format( "Unknown attribute: '%s'", attrib )

		if ( !("PopExtAttributes" in ROOT) )
			errorstr += ".  'customattributes' module not found."

		PopExtMain.Error.GenericWarning( errorstr )
	}
}

// wrapper for applying a table of attributes to an item or array of items
function PopExtUtil::SetPlayerAttributesMulti( player, item, attributes, customwep_force = false, showhidden = false ) {

	local weps = []

	if ( typeof item == "array" || (typeof item == "string" && item.find( "," ) ) ) {

		item = typeof item == "array" ? item : split(item, ",", true)

		foreach ( _item in item ) {

			local idx = ToStrictNum(_item)

			local wep = HasItemInLoadout( player, idx != null ? idx : _item )

			if ( wep == null ) continue

			weps.append( wep )
		}
	}
	else {

		local wep = HasItemInLoadout( player, item )

		if ( wep == null ) return

		weps.append( wep )
	}

	local scope = player.GetScriptScope()

	foreach ( wep in weps ) {

		foreach ( attrib, value in attributes ) {

			// warpaint seeds must be set before paintkit_proto_def_index
			// otherwise it won't appear until the player/weapon respawns
			local set_warpaint_seed = "set warpaint seed"
			if ( set_warpaint_seed in attributes && ( !( "attribinfo" in scope ) || !( set_warpaint_seed in scope.attribinfo ) ) ) {

				SetPlayerAttributes( player, set_warpaint_seed, attributes[set_warpaint_seed], wep, customwep_force, showhidden )
				continue
			}
			SetPlayerAttributes( player, attrib, value, wep, customwep_force, showhidden )
		}
	}
}

// wrapper for game_text for displaying timed messages
// very basic custom syntax support for separating messages with "|"
// "Message1|PAUSE 5|Message2" will display Message1, wait for 5 seconds, then display Message2

function PopExtUtil::DoExplanation( message, print_color = COLOR_YELLOW, message_prefix = "Explanation: ", sync_chat_with_game_text = false, text_print_time = -1, text_scan_time = 0.02 ) {

	local rgb = HexOrIntToRgb( "FFFF66" )

	local txtent = SpawnEntityFromTable( "game_text", {
		effect = 2,
		spawnflags = SF_ENVTEXT_ALLPLAYERS,
		color = format( "%d %d %d", rgb[0], rgb[1], rgb[2] ),
		color2 = "255 254 255",
		fxtime = text_scan_time,
		// holdtime = 5,
		fadeout = 0.01,
		fadein = 0.01,
		channel = 3,
		x = 0.3,
		y = 0.3
	})

	SetPropBool( txtent, STRING_NETPROP_PURGESTRINGS, true )
	SetTargetname( txtent, format( "__popext_explanation_text%d", txtent.entindex() ) )
	local strarray = []

	//avoid needing to do a ton of function calls for multiple announcements.
	local newlines = split( message, "|" )

	foreach ( n in newlines )
		if ( n.len() ) {
			strarray.append( n )
			if ( !startswith( n, "PAUSE" ) && !sync_chat_with_game_text )
				ClientPrint( null, 3, format( "\x07%s %s\x07%s %s", print_color, message_prefix, TF_COLOR_DEFAULT, n ) )
		}

	local i = -1
	local textcooldown = 0
	function ExplanationTextThink() {

		if ( textcooldown > Time() ) return

		i++
		if ( !(i in strarray) ) {

			SetPropString( txtent, "m_iszMessage", "" )
			txtent.AcceptInput( "Display", "", null, null )

			PopGameStrings.AddStrings( strarray )
			txtent.Kill()
			return
		}
		local s = strarray[i]

		//make text display slightly longer depending on string length
		local delaybetweendisplays = text_print_time
		if ( delaybetweendisplays == -1 ) {
			delaybetweendisplays = s.len() / 10
			if ( delaybetweendisplays < 2 ) delaybetweendisplays = 2; else if ( delaybetweendisplays > 12 ) delaybetweendisplays = 12
		}

		//allow for pauses in the announcement
		if ( startswith( s, "PAUSE" ) ) {
			local pause = split( s, " " )[1].tofloat()
		//	  DoEntFire( "player", "SetScriptOverlayMaterial", "", -1, player, player )
			SetPropString( txtent, "m_iszMessage", "" )

			SetPropInt( txtent, "m_textParms.holdTime", pause )
			txtent.KeyValueFromInt( "holdtime", pause )

			txtent.AcceptInput( "Display", "", null, null )

			textcooldown = Time() + pause
			return 0.033
		}

		//shits fucked
		function calculate_x( str ) {
			local len = str.len()
			local t = 1 - ( len.tofloat() / 48 )
			local x = 1 * ( 1 - t )
			x = ( 1 - ( x / 3 ) ) / 2.1
			// if ( x > 0.5 ) x = 0.5 else if ( x < 0.28 ) x = 0.28
			return x
		}

		SetPropFloat( txtent, "m_textParms.x", calculate_x( s ) )
		txtent.KeyValueFromFloat( "x", calculate_x( s ) )

		SetPropString( txtent, "m_iszMessage", s )

		SetPropInt( txtent, "m_textParms.holdTime", delaybetweendisplays )
		txtent.KeyValueFromInt( "holdtime", delaybetweendisplays )

		txtent.AcceptInput( "Display", "", null, null )
		if ( sync_chat_with_game_text )
			ClientPrint( null, 3, format( "\x07%s %s\x07%s %s", COLOR_YELLOW, message_prefix, TF_COLOR_DEFAULT, s ) )

		textcooldown = Time() + delaybetweendisplays

		return 0.033
	}

	AddThink( txtent, ExplanationTextThink )
}

// LEGACY: keeping this around since some archive missions use it
function PopExtUtil::IsAlive( player ) {
	PopExtMain.Error.DeprecationWarning( "PopExtUtil.IsAlive( player )", "player.IsAlive()" )
	return player.IsAlive()
}

function PopExtUtil::RemoveAmmo( player, slot = -1 ) {

	if (slot != -1)
		return slot < TF_AMMO_COUNT ? SetPropIntArray( player, STRING_NETPROP_AMMO, 0, slot) : PopExtMain.Error.RaiseIndexError( "RemoveAmmo", [0, TF_AMMO_COUNT - 1] )

	local ammo_array = GetPropArraySize( player, STRING_NETPROP_AMMO )

	for ( local i = 0; i < ammo_array; i++ )
		SetPropIntArray( player, STRING_NETPROP_AMMO, 0, i )
}

function PopExtUtil::GetAllEnts( count_players = false, callback = null ) {

	local entlist = []

	local start = count_players.tointeger() || MAX_CLIENTS

	for ( local i = start, ent; i <= MAX_EDICTS; ent = EntIndexToHScript( i ), i++ )
		if ( ent )
			entlist.append( ent )

	if ( callback != null ) {
		PopExtMain.Error.DeprecationWarning( "PopExtUtil.GetAllEnts callback feature", "PopExtUtil.ForEachEnt" )
		foreach ( ent in entlist )
			callback( ent )
	}

	return { "entlist": entlist, "numents": entlist.len() }
}

// optimized entity cache iteration for large numbers of static entities
function PopExtUtil::ForEachEnt( identifier = null, filter = null, callback = null, findby = "FindByClassname", force_update = true ) {

	local entlist = []

	// no lambda so perf counter prints it
	local function foreachent_filter( ent ) { return true }

	if ( filter )
		foreachent_filter = filter.bindenv( this )

	if ( !findby || !(findby in ROOT) )
		findby = "FindByClassname"

	local cache_key = findby.slice( 4 )

	local ent_table = EntTable

	local update_entity_cache = force_update || ( identifier && !(identifier in ent_table[cache_key]) )

	// check the existing entity cache instead
	if ( !update_entity_cache ) {

		local tbl = identifier ? ent_table[ cache_key ][ identifier ] : ent_table

		foreach ( i, ent in tbl ) {

			if ( identifier || ( typeof ent == "instance" && foreachent_filter( ent ) ) ) {

				if ( ent_table[ ent ].cachetime < Time() + 5 )
					ent = EntIndexToHScript( i )

				entlist.append( ent )

				if ( callback ) callback( ent )
			}
		}

		return { "entlist": entlist, "numents": entlist.len() }
	}

	// check using FindByX functions
	if ( identifier ) {

		// special case for players
		if ( identifier == "player" && findby == "FindByClassname" ) {

			if ( PlayerArray.len() )
				entlist.extend( PlayerArray )

			// we should at least have the bots in this list.
			if ( IsMannVsMachineMode() && entlist.len() < GetInt( "tf_mvm_max_invaders" ) )
				for ( local i = 1, player; i <= MAX_CLIENTS; player = PlayerInstanceFromIndex( i ), i++ )
					if ( player )
						entlist.append( player )
		}
		// non-players
		else
			for ( local ent; ent = ROOT[ findby ]( ent, identifier ); )
				entlist.append( ent )
	}

	// get every entity
	else
		for ( local ent = First(); ent; ent = Next( ent ) )
			entlist.append( ent )

	// run callbacks and update entity cache
	local ent_table_keys = { ByName = "name", ByModel = "model", ByThinkFunc = "thinkfunc", ByClassname = "classname", ByScriptID = "scriptid" }

	foreach ( ent in entlist ) {

		if ( callback )
			callback( ent )

		PopExtUtil.EntTable[ent] <- {

			self      = ent
			name 	  = ent.GetName()
			model     = ent.GetModelName()
			scope     = ent.GetScriptScope()
			entidx    = ent.entindex()
			classname = ent.GetClassname()
			scriptid  = ent.GetScriptId()
			thinkfunc = ent.GetScriptThinkFunc()
			cachetime = Time()
		}

		local this_ent = clone PopExtUtil.EntTable[ ent ]

		foreach ( cachekey, entval in ent_table_keys ) {

			local val = this_ent[ entval ]

			if ( val == "" ) continue

			if ( !(val in PopExtUtil.EntTable[ cachekey ]) )
				PopExtUtil.EntTable[ cachekey ][ val ] <- {}

			PopExtUtil.EntTable[ cachekey ][ val ][ ent ] <- this_ent
		}

		local target = GetPropString( ent, "m_target" )
		if ( target != "" ) {

			if ( !(target in PopExtUtil.EntTable.ByTarget) )
				PopExtUtil.EntTable.ByTarget[ target ] <- {}

			PopExtUtil.EntTable.ByTarget[ target ][ ent ] <- this_ent
		}

	}
	return { "entlist": entlist, "numents": entlist.len() }
}

function PopExtUtil::PointScriptTemplate( targetname = null, onspawn = null ) {

	local template = CreateByClassname( "point_script_template" )
	SetTargetname( template, targetname || template.GetScriptId() )
	SetPropBool( template, STRING_NETPROP_PURGESTRINGS, true )

	local template_scope = GetEntScope( template )
	template_scope.ents <- []

	template_scope.__EntityMakerResult <- { entities = template_scope.ents }.setdelegate({

		function _newslot( _, value ) {

			entities.append( value )
		}
	})

	if ( onspawn )
		template_scope.PostSpawn <- onspawn.bindenv( template_scope )

	return template
}

//sets m_hOwnerEntity and m_hOwner to the same value
function PopExtUtil::_SetOwner( ent, owner ) {

	//incase we run into an ent that for some reason uses both of these netprops for two different entities
	if ( ent.GetOwner() && GetPropEntity( ent, "m_hOwner" ) && ent.GetOwner() != GetPropEntity( ent, "m_hOwner" ) )
		PopExtMain.Error.GenericWarning( "m_hOwner is "+GetPropEntity( ent, "m_hOwner" )+" but m_hOwnerEntity is "+ent.GetOwner() )

	ent.SetOwner( owner )
	SetPropEntity( ent, "m_hOwner", owner )
}

/**
	* Displays a training annotation.
	*
	* @param table args        Annotation settings.
	*
	* Example usage:
	*  PopExtUtil.ShowAnnotation( {
	*      text = `Defend the hatch!`
	*      entity = Entities.FindByModel( null, `models/props_mvm/mann_hatch.mdl` )
	*      //pos = Vector( -64.0, -1984.0, 446.5 )
	*      lifetime = 5.0
	*      distance = true
	*      sound = `ui/hint.wav`
	*      players = [GetListenServerHost()]
	*  } )
	*
	* ALL AVAILABLE ARGUMENTS:
	*  text    ( string ): Annotation message to display.
	*    Defaults to "This is an annotation."
	*
	*  lifetime ( float ): Duration to display the annotation for in seconds.
	*    Defaults to 10 seconds.
	*    Pass -1.0 to make the annotation fade in and display forever.
	*
	*  sound   ( string ): Sound to play when the annotation is shown.
	*    Must be a raw sound, SoundScripts will not work.
	*    Defaults to no sound.
	*
	*  distance  ( bool ): Display the distance between the player and the annotation.
	*    Defaults to false.
	*
	*  id     ( integer ): Annotation ID.
	*    Annotations must have a unique ID to display multiple simultaneously.
	*    Defaults to 0.
	*
	*  entity  ( handle ): Entity this annotation should follow. ( Default: None )
	*    Overrides "pos" and "normal" arguments.
	*    Note that the entity must be networked to the client for this argument to work.a
	*
	*  pos     ( Vector ): Annotation position in the world.
	*    Defaults to the world origin ( Vector( 0, 0, 0 ) ).
	*
	*  ping      ( bool ): Display a green in-world ping under the annotation as it appears.
	*    Defaults to false.
	*
	*  normal  ( Vector ): Relative ping effect offset from the animation.
	*    Requires "ping" to be set to true.
	*    Defaults to no offset.
	*
	*  players  ( array ): Players handles that are allowed to see the annotation.
	*    Overrides "visbit" argument.
	*    Defaults visibility to all players when left empty.
	*
	*  visbit ( integer ): Bitfield that controls which players can see the annotation.
	*    Can be used for manual bitfield input instead of using the "players" array.
	*    Defaults visibility to all players.
	*    Note that it is only possible to filter annotations to the first 32/64 players depending on the server's _intsize_.
	*      TODO: This is untested; it may be the case that only the first 32 players may be targeted even on a 64-bit server.
	**/
function PopExtUtil::ShowAnnotation( args = {} ) {

	if ( !( "pos" in args ) )
		args.pos <- Vector()

	if ( !( "normal" in args ) )
		args.normal <- Vector()
	else
		// Normal offset is normally 20x the input value, so we correct it here.
		args.normal *= 0.05

	if ( "players" in args && args.players.len() > 0 ) {
		// Create visibility bitfield from passed player handles.
		args.visbit <- 0

		foreach ( p in args.players )
			if ( p && p.IsValid() )
				args.visbit = args.visbit | ( 1 << p.entindex() )

		// visibilityBitfield == 0 causes the annotation to show to everyone, we override that
		//  here otherwise "players = [<nullptr>]" would show to everyone.
		if ( args.visbit == 0 ) return
	}

	// "entindex" and "effect" arguments are only supported for legacy compatiability.
	if ( "entity" in args ) args.entindex <- args.entity.entindex()
	if ( "ping" in args ) args.effect <- args.ping

	SendGlobalGameEvent( "show_annotation", {
		text 			   = "text" in args ? args.text : "This is an annotation."
		lifetime 		   = "lifetime" in args ? args.lifetime : 10.0
		worldPosX 		   = args.pos.x
		worldPosY 		   = args.pos.y
		worldPosZ 		   = args.pos.z
		id 				   = "id" in args ? args.id : 0
		play_sound 		   = "sound" in args ? args.sound : "misc/null.wav"
		show_distance 	   = "distance" in args ? args.distance : false
		show_effect 	   = "effect" in args ? args.effect : false
		follow_entindex    = "entindex" in args ? args.entindex : 0
		visibilityBitfield = "visbit" in args ? args.visbit : 0
		worldNormalX 	   = args.normal.x
		worldNormalY 	   = args.normal.y
		worldNormalZ 	   = args.normal.z
	})
}

function PopExtUtil::TrainingHUD( title, text, duration = 5.0 ) {

	EntFire( "func_upgradestation", "Disable" )

	local tutorial_text = CreateByClassname( "tf_logic_training_mode" )

	SetPropBool( GameRules, "m_bIsInTraining", true )
	SetPropBool( GameRules, "m_bAllowTrainingAchievements", true )

	tutorial_text.AcceptInput( "ShowTrainingHUD","", null, null )
	tutorial_text.AcceptInput( "ShowTrainingObjective", title, null, null )
	tutorial_text.AcceptInput( "ShowTrainingMsg", text, null, null )
	tutorial_text.Kill()

	SetValue( "hide_server", 0 )

	ScriptEntFireSafe( GameRules, "SetPropBool( self, `m_bIsInTraining`, false )", duration )

	EntFire( "func_upgradestation", "Enable", "", duration )
}

function PopExtUtil::PressButton( player, button, duration = -1 ) {

	SetPropInt( player, "m_afButtonForced", GetPropInt( player, "m_afButtonForced" ) | button )
	SetPropInt( player, "m_nButtons", GetPropInt( player, "m_nButtons" ) | button )

	if ( duration != -1 )
		ScriptEntFireSafe( player, format( "PopExtUtil.ReleaseButton( self, %d )", button ), duration )
}

function PopExtUtil::ReleaseButton( player, button ) {

	SetPropInt( player, "m_afButtonForced", GetPropInt( player, "m_afButtonForced" ) & ~button )
	SetPropInt( player, "m_nButtons", GetPropInt( player, "m_nButtons" ) & ~button )
}

//LEGACY: use IsPointInTrigger instead
function PopExtUtil::IsPointInRespawnRoom( point ) {

	PopExtMain.Error.DeprecationWarning( "PopExtUtil.IsPointInRespawnRoom", "PopExtUtil.IsPointInTrigger" )

	local triggers = []
	for ( local trigger; trigger = FindByClassname( trigger, "func_respawnroom" ); ) {

		trigger.SetCollisionGroup( 0 )
		trigger.RemoveSolidFlags( 4 ) // FSOLID_NOT_SOLID
		triggers.append( trigger )
	}

	local trace = {

		start = point,
		end = point,
		mask = 0
	}
	TraceLineEx( trace )

	foreach ( trigger in triggers ) {

		trigger.SetCollisionGroup( 25 ) // special collision group used by respawnrooms only
		trigger.AddSolidFlags( 4 ) // FSOLID_NOT_SOLID
	}

	return trace.hit && trace.enthit.GetClassname() == "func_respawnroom"
}

function PopExtUtil::IsPointInTrigger( point, classname = "func_respawnroom" ) {

	local triggers = []
	for ( local trigger; trigger = FindByClassname( trigger, classname ); ) {

		if ( classname == "func_respawnroom" )
			trigger.SetCollisionGroup( COLLISION_GROUP_NONE )

		trigger.RemoveSolidFlags( FSOLID_NOT_SOLID )
		triggers.append( trigger )
	}

	local trace = {

		start = point,
		end = point,
		mask = 0
	}
	TraceLineEx( trace )

	foreach ( trigger in triggers ) {

		if ( classname == "func_respawnroom" )
			trigger.SetCollisionGroup( TFCOLLISION_GROUP_RESPAWNROOMS )

		trigger.AddSolidFlags( FSOLID_NOT_SOLID )
	}

	return trace.hit && trace.enthit.GetClassname() == classname
}

function PopExtUtil::GetItemInSlot( player, slot ) {

	for ( local child = player.FirstMoveChild(); child; child = child.NextMovePeer() )
		if ( child instanceof CBaseCombatWeapon && child.GetSlot() == slot )
			return child
}

function PopExtUtil::SwitchToFirstValidWeapon( player ) {

	for ( local i = 0; i < SLOT_COUNT; i++ ) {
		local wep = GetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, i )
		if ( wep == null ) continue

		player.Weapon_Switch( wep )
		return wep
	}
}

// misleading name, this can accept any model
// previously was only used for popext_usehumananimations
function PopExtUtil::PlayerRobotModel( player, model ) {

	PopExtMain.Error.DeprecationWarning( "PopExtUtil.PlayerRobotModel", "PopExtUtil.PlayerBonemergeModel" )

	local scope = player.GetScriptScope()

	local wearable = CreateByClassname( "tf_wearable" )
	SetPropString( wearable, STRING_NETPROP_NAME, "__popext_bonemerge_model" )
	SetPropInt( wearable, STRING_NETPROP_MODELINDEX, PrecacheModel( model ) )
	SetPropBool( wearable, STRING_NETPROP_ATTACH, true )
	SetPropEntity( wearable, "m_hOwnerEntity", player )
	wearable.SetTeam( player.GetTeam() )
	wearable.SetOwner( player )
	DispatchSpawn( wearable )
	SetPropBool( wearable, STRING_NETPROP_PURGESTRINGS, true )
	EntFireByHandle( wearable, "SetParent", "!activator", -1, player, player )
	SetPropInt( wearable, "m_fEffects", EF_BONEMERGE|EF_BONEMERGE_FASTCULL )
	scope.wearable <- wearable

	SetPropInt( player, "m_nRenderMode", kRenderTransColor )
	SetPropInt( player, "m_clrRender", 0 )

	function BotModelThink() {
		if ( wearable.IsValid() && ( player.IsTaunting() || wearable.GetMoveParent() != player ) )
			wearable.AcceptInput( "SetParent", "!activator", player, player )
		return -1
	}
	AddThink( player, BotModelThink )
}

function PopExtUtil::PlayerBonemergeModel( player, model ) {

	local scope = player.GetScriptScope()

	if ( "bonemerge_model" in scope && scope.bonemerge_model && scope.bonemerge_model.IsValid() )
		scope.bonemerge_model.Kill()

	local bonemerge_model = CreateByClassname( "tf_wearable" )
	SetPropString( bonemerge_model, STRING_NETPROP_NAME, "__popext_bonemerge_model" )
	SetPropInt( bonemerge_model, STRING_NETPROP_MODELINDEX, PrecacheModel( model ) )
	SetPropBool( bonemerge_model, STRING_NETPROP_ATTACH, true )
	SetPropEntity( bonemerge_model, "m_hOwner", player )
	bonemerge_model.SetTeam( player.GetTeam() )
	bonemerge_model.SetOwner( player )
	DispatchSpawn( bonemerge_model )
	SetPropBool( bonemerge_model, STRING_NETPROP_PURGESTRINGS, true )
	EntFireByHandle( bonemerge_model, "SetParent", "!activator", -1, player, player )
	SetPropInt( bonemerge_model, "m_fEffects", EF_BONEMERGE|EF_BONEMERGE_FASTCULL )
	scope.bonemerge_model <- bonemerge_model

	SetPropInt( player, "m_nRenderMode", kRenderTransColor )
	SetPropInt( player, "m_clrRender", 0 )

	function BonemergeModelThink() {

		if ( bonemerge_model.IsValid() && ( player.IsTaunting() || bonemerge_model.GetMoveParent() != player ) )
			bonemerge_model.AcceptInput( "SetParent", "!activator", player, player )
		return -1
	}
	AddThink( player, BonemergeModelThink )
}

function PopExtUtil::PlayerSequence( player, sequence, model_override = "", playbackrate = 1.0, freeze_player = false, thirdperson = false ) {

	SetPropInt( player, "m_nRenderMode", kRenderTransColor )
	SetPropInt( player, "m_clrRender", 0 )
	local scope = player.GetScriptScope()

	local has_bonemerge_model = "bonemerge_model" in scope && scope.bonemerge_model && scope.bonemerge_model.IsValid()

	local dummy = CreateByClassname( "funCBaseFlex" )
	SetTargetname( dummy, format( "__popext_sequence_dummy%d", player.entindex() ) )

	// SetModelSimple is more expensive but handles precaching and refreshes bone cache automatically
	if ( model_override != "" )
		dummy.SetModelSimple( model_override )
	else
		dummy.SetModel( has_bonemerge_model ? scope.bonemerge_model.GetModelName() : player.GetModelName() )

	dummy.SetAbsOrigin( player.GetOrigin() )
	dummy.SetSkin( player.GetSkin() )
	dummy.SetAbsAngles( QAngle( 0, player.EyeAngles().y, 0 ) )

	DispatchSpawn( dummy )
	dummy.AcceptInput( "SetParent", "!activator", player, player )

	dummy.ResetSequence( typeof sequence == "string" ? dummy.LookupSequence( sequence ) : sequence )
	dummy.SetPlaybackRate( playbackrate )

	function PlaySequenceThink() {

		// kv origin/angles are smoothly interpolated, SetOrigin/SetAngles may look choppy in comparison
		dummy.KeyValueFromVector( "origin", player.GetOrigin() )
		dummy.KeyValueFromString( "angles", player.GetAbsAngles().ToKVString() )

		if ( GetPropFloat( dummy, "m_flCycle" ) >= 0.99 ) {

			SetPropInt( player, "m_clrRender", 0xFFFFFFFF )
			if ( freeze_player ) LockInPlace( player, false )
			if ( thirdperson ) player.AcceptInput( "SetForcedTauntCam", "0", null, null )
			if ( dummy.IsValid() ) dummy.Kill()
			return // no -1 think to avoid null instance errors
		}
		dummy.StudioFrameAdvance()
		return -1
	}
	AddThink( dummy, PlaySequenceThink )

	if ( freeze_player ) LockInPlace( player )
	if ( thirdperson ) player.AcceptInput( "SetForcedTauntCam", "1", null, null )

}

function PopExtUtil::HasItemInLoadout( player, item ) {

	for ( local child = player.FirstMoveChild(); child; child = child.NextMovePeer() ) {
		
		//entity handle or classname
		if ( child == item || child.GetClassname() == item )
			return child
		// item index
		else if ( item != -1 && GetItemIndex( child ) == item )
			return child
		// english item name
		else if ( item in PopExtItems && GetItemIndex( child ) == PopExtItems[item].id )
			return child
	}


	//didn't find weapon in children, go through m_hMyWeapons instead
	for ( local i = 0; i < SLOT_COUNT; i++ ) {

		local wep = GetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, i )

		if ( !wep || !wep.IsValid() ) continue

		// entity handle or classname
		if ( wep == item || wep.GetClassname() == item )
			return wep
		// item index
		else if ( item != -1 && GetItemIndex( wep ) == item )
			return wep
		// english item name
		else if ( item in PopExtItems && GetItemIndex( wep ) == PopExtItems[item].id )
			return wep
	}

	// check for custom weapons
	// only accepts weapon handle or weapon string name
	local scope = player.GetScriptScope()
	if ( "CustomWeapons" in scope ) {

		foreach ( wep, wepinfo in scope.CustomWeapons ) {

			if ( wep == "worldmodel" ) 
				continue

			else if ( wep == item || wepinfo.name == item )
				return wep
		}
	}
}

// This was made before StunPlayer was exposed, however StunPlayer doesn't control m_bStunEffects like this does.
function PopExtUtil::StunPlayer( player, duration = 5, type = 1, delay = 0, speedreduce = 0.5, scared = false ) {

	local utilstun = CreateByClassname( "trigger_stun" )

	SetTargetname( utilstun, "__popext_stun" )
	utilstun.KeyValueFromInt( "stun_type", type )
	utilstun.KeyValueFromInt( "stun_effects", scared.tointeger() )
	utilstun.KeyValueFromFloat( "stun_duration", duration.tofloat() )
	utilstun.KeyValueFromFloat( "move_speed_reduction", speedreduce.tofloat() )
	utilstun.KeyValueFromFloat( "trigger_delay", delay.tofloat() )
	utilstun.KeyValueFromInt( "spawnflags", SF_TRIGGER_ALLOW_CLIENTS )

	DispatchSpawn( utilstun )

	utilstun.AcceptInput( "EndTouch", "", player, player )
	utilstun.Kill()
}

function PopExtUtil::Ignite( player, duration = 10.0, damage = 1 ) {

	local utilignite = FindByName( null, "__popext_ignite" ) || SpawnEntityFromTable( "trigger_ignite", {
			targetname = "__popext_ignite"
			burn_duration = duration
			damage = damage
			spawnflags = SF_TRIGGER_ALLOW_CLIENTS
		})
	EntFireByHandle( utilignite, "StartTouch", "", -1, player, player )
	EntFireByHandle( utilignite, "EndTouch", "", SINGLE_TICK, player, player )
}

function PopExtUtil::ShowHudHint( text = "This is a hud hint", player = null, duration = 5.0 ) {

	local hudhint = FindByName( null, "__popext_hudhint" ) || SpawnEntityFromTable( "env_hudhint", {
		targetname = "__popext_hudhint"
		spawnflags = !player ? 1 : 0
		message = text
	})
	SetPropBool( hudhint, STRING_NETPROP_PURGESTRINGS, true )
	hudhint.KeyValueFromString( "message", text )

	hudhint.AcceptInput("ShowHudHint", "", player, player )
	EntFireByHandle( hudhint, "HideHudHint", "", duration, player, player )

	if ( "PopGameStrings" in ROOT )
		PopGameStrings.StringTable[ text ] <- "env_hudhint"
}

function PopExtUtil::SetEntityColor( entity, r, g, b, a ) {

	local color = ( r ) | ( g << 8 ) | ( b << 16 ) | ( a << 24 )
	SetPropInt( entity, "m_clrRender", color )
}

function PopExtUtil::GetEntityColor( entity ) {

	local color = GetPropInt( entity, "m_clrRender" )
	local clr = {}
	clr.r <- color & 0xFF
	clr.g <- ( color >> 8 ) & 0xFF
	clr.b <- ( color >> 16 ) & 0xFF
	clr.a <- ( color >> 24 ) & 0xFF
	return clr
}

function PopExtUtil::AddAttributeToLoadout( player, attribute, value, duration = -1 ) {

	ForEachItem( player, function( item ) { item.AddAttribute( attribute, value, duration ); item.ReapplyProvision() }, true )
}

function PopExtUtil::ShowModelToPlayer( player, model = ["models/player/heavy.mdl", 0], pos = Vector(), ang = QAngle(), duration = INT_MAX, bodygroup = null ) {

	PrecacheModel( model[0] )
	local proxy_entity = CreateByClassname( "obj_teleporter" ) // use obj_teleporter to set bodygroups.  not using SpawnEntityFromTable as that creates spawning noises
	proxy_entity.SetAbsOrigin( pos )
	proxy_entity.SetAbsAngles( ang )
	DispatchSpawn( proxy_entity )

	proxy_entity.SetModel( model[0] )
	proxy_entity.SetSkin( model[1] )
	proxy_entity.AddEFlags( EFL_NO_THINK_FUNCTION ) // EFL_NO_THINK_function prevents the entity from disappearing
	proxy_entity.SetSolid( SOLID_NONE )

	SetPropBool( proxy_entity, "m_bPlacing", true )
	SetPropInt( proxy_entity, "m_fObjectFlags", OF_MUST_BE_BUILT_ON_ATTACHMENT ) // sets "attachment" flag, prevents entity being snapped to player feet

	// m_hBuilder is the player who the entity will be networked to only
	SetPropEntity( proxy_entity, "m_hBuilder", player )
	EntFireByHandle( proxy_entity, "Kill", "", duration, player, player )
	return proxy_entity
}

function PopExtUtil::LockInPlace( player, enable = true ) {

	if ( enable ) {
		player.AddFlag( FL_ATCONTROLS )
		player.AddCustomAttribute( "no_jump", 1, -1 )
		player.AddCustomAttribute( "no_duck", 1, -1 )
		player.AddCustomAttribute( "no_attack", 1, -1 )
		player.AddCustomAttribute( "disable weapon switch", 1, -1 )
		return

	}

	player.RemoveFlag( FL_ATCONTROLS )
	player.RemoveCustomAttribute( "no_jump" )
	player.RemoveCustomAttribute( "no_duck" )
	player.RemoveCustomAttribute( "no_attack" )
	player.RemoveCustomAttribute( "disable weapon switch" )
}

function PopExtUtil::InitEconItem( item, index ) {

	SetPropInt( item, STRING_NETPROP_ITEMDEF, index )
	SetPropBool( item, STRING_NETPROP_INIT, true )
	SetPropBool( item, STRING_NETPROP_ATTACH, true )
}

function PopExtUtil::SpawnEffect( player, effect ) {

	local player_angle	   =  player.GetLocalAngles()
	local player_angle_vec =  Vector( player_angle.x, player_angle.y, player_angle.z )

	DispatchParticleEffect( effect, player.GetLocalOrigin(), player_angle_vec )
}

function PopExtUtil::RemoveOutputAll( ent, output ) {
	local outputs = []

	for ( local i = GetNumElements( ent, output ); i >= 0; i-- ) {

		local t = {}
		GetOutputTable( ent, output, t, i )
		outputs.append( t )
	}

	foreach ( o in outputs )
		foreach( _ in o )
			RemoveOutput( ent, output, o.target, o.input, o.parameter )
}

function PopExtUtil::GetAllOutputs( ent, output ) {
	local outputs = []
	for ( local i = GetNumElements( ent, output ); i >= 0; i-- ) {
		local t = {}
		GetOutputTable( ent, output, t, i )
		outputs.append( t )
	}
	return outputs
}

function PopExtUtil::GetPropAny( ent, prop, i = 0 ) {

	local type = GetPropType( ent, prop )

	if ( type == "instance" )
		return GetPropEntityArray( ent, prop, i )
	else if ( type == "integer" )
		return GetPropIntArray( ent, prop, i )
	else {

		local funcname = format( "GetProp%sArray", type.slice( 0, 1 ).toupper() + type.slice( 1 ) )
		return ROOT[funcname]( ent, prop, i )
	}
}

function PopExtUtil::SetPropAny( ent, prop, value, i = 0 ) {

	local type = GetPropType( ent, prop )

	if ( type == "instance" )
		SetPropEntityArray( ent, prop, value, i )
	else if ( type == "integer" )
		SetPropIntArray( ent, prop, value, i )

	else {

		local converted = type == "bool" ? value.tointeger() : value[format("to%s", type)]()

		local funcname = format( "SetProp%sArray", type.slice( 0, 1 ).toupper() + type.slice( 1 ) )
		ROOT[funcname]( ent, prop, value, i )
	}

	SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
}

function PopExtUtil::RemovePlayerWearables( player ) {

	for ( local wearable = player.FirstMoveChild(); wearable; wearable = wearable.NextMovePeer() ) {

		if ( wearable instanceof CBaseCombatWeapon )
			continue 
		else if ( !(wearable instanceof CEconEntity) ) 
			continue

		SetPropBool( wearable, STRING_NETPROP_PURGESTRINGS, true )
		EntFireByHandle( wearable, "Kill", "", -1, null, null )
	}
	return
}

function PopExtUtil::GiveWeapon( player, class_name, item_id ) {

	if ( typeof item_id == "string" && class_name == "tf_wearable" ) {

		CTFBot.GenerateAndWearItem.call( player, item_id )
		return
	}
	else if ( class_name == "saxxy" || class_name == "tf_weapon_shotgun" ) {

		local item_info = PopExtItems[class_name == "saxxy" ? "Saxxy" : "TF_WEAPON_SHOTGUN_PRIMARY"]
		local class_string = PopExtUtil.Classes[player.GetPlayerClass()]

		if ( !(class_string in item_info.animset) )
			class_name = "tf_weapon_shotgun_soldier"
		else
			class_name = item_info.item_class[item_info.animset.find(class_string)]

		PopExtMain.Error.GenericWarning( "multi-class classnames (saxxy, tf_weapon_shotgun) are discouraged, use the stock classname (" + class_name + ") instead" )
	}
	local weapon = CreateByClassname( class_name )
	InitEconItem( weapon, item_id )
	weapon.SetTeam( player.GetTeam() )
	DispatchSpawn( weapon )
	SetPropBool( weapon, STRING_NETPROP_PURGESTRINGS, true )

	// remove existing weapon in same slot
	ForEachItem( player, function( item ) {

		if ( item.GetSlot() != weapon.GetSlot() )
			return

		SetPropBool( item, STRING_NETPROP_PURGESTRINGS, true )
		EntFireByHandle( item, "Kill", "", -1, null, null )
		// SetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, null, slot )
	}, true)

	player.Weapon_Equip( weapon )
	player.Weapon_Switch( weapon )

	return weapon
}

function PopExtUtil::IsEntityClassnameInList( entity, list ) {

	local classname = entity.GetClassname()
	local list_type = typeof list

	switch ( list_type ) {
		case "table":
			return ( classname in list )

		case "array":
			return ( list.find( classname ) != null )

		default:
			PopExtMain.Error.RaiseTypeError( "list", "array or table" )
			return false
	}
}

function PopExtUtil::SetPlayerClassRespawnAndTeleport( player, playerclass, location_set = null ) {
	local teleport_origin, teleport_angles, teleport_velocity

	if ( !location_set )
		teleport_origin = player.GetOrigin()
	else
		teleport_origin = location_set
	teleport_angles = player.EyeAngles()
	teleport_velocity = player.GetAbsVelocity()
	SetPropInt( player, "m_Shared.m_iDesiredPlayerClass", playerclass )

	player.ForceRegenerateAndRespawn()

	player.Teleport( true, teleport_origin, true, teleport_angles, true, teleport_velocity )
}

function PopExtUtil::PlaySoundOnClient( player, name, volume = 1.0, pitch = 100 ) {
	EmitSoundEx( {
		sound_name = name,
		volume = volume
		pitch = pitch,
		entity = player,
		filter_type = RECIPIENT_FILTER_SINGLE_PLAYER
	})
}

function PopExtUtil::PlaySoundOnAllClients( name ) {
	EmitSoundEx( {
		sound_name = name,
		filter_type = RECIPIENT_FILTER_GLOBAL
	})
}

function PopExtUtil::StopAndPlayMVMSound( player, soundscript, delay ) {

	local scope = player.GetScriptScope()
	scope.sound <- soundscript

	ScriptEntFireSafe( player, "self.StopSound( sound );", delay )

	local sound	   =  scope.sound
	local dotindex =  sound.find( "." )
	if ( dotindex == null ) return

	scope.mvmsound <- sound.slice( 0, dotindex+1 ) + "MVM_" + sound.slice( dotindex+1 )

	ScriptEntFireSafe( player, "self.EmitSound( mvmsound );", delay + SINGLE_TICK )
}

/**************************************
 * GENERIC NON-MVM SPECIFIC UTILITIES *
 **************************************/

function PopExtUtil::StringReplace( str, findwhat, replace ) {

	local returnstring = ""
	local strlen 	   = str.len()
	local findwhatlen  = findwhat.len()
	local split_list   = []

	local start = 0
	local previndex = 0
	while ( start < strlen ) {

		local index = str.find( findwhat, start )

		if ( index == null ) {
			if ( start < strlen - 1 )
				split_list.append( str.slice( start ) )
			break
		}

		split_list.append( str.slice( previndex, index ) )

		start = index + findwhatlen
		previndex = start
	}

	local split_list_length = split_list.len() - 1

	for (local index = 0, s; index < split_list_length; s = split_list[index], index++)
		returnstring += s + replace

	returnstring += split_list[split_list_length]

	return returnstring
}

function PopExtUtil::CharReplace( str, findwhat, replace, firstonly = false ) {

	local returnstring = ""
	local strlen = str.len()

	if ( typeof findwhat == "string" )
		findwhat = findwhat[0]
	
	if ( typeof replace == "integer" )
		replace = replace.tochar()

	// one-liner version
	// ( array(strlen, "").apply( @(i, c) str[i] == findwhat ? replace : c ) ).apply( @(c) returnstring += c.tochar() )

	// local charlist = array(strlen, "").apply( @(c, i) str[i] == findwhat ? replace : c )

	foreach( i, c in str ) {

		if ( c == findwhat ) {

			returnstring += replace

			if ( firstonly )
				return returnstring + str.slice( i + 1 )

			continue
		}
		returnstring += c.tochar()
	}

	return returnstring
}

// more early returns for failed matches
// direct integer comparisons using binary search
// supports arrays too

// NOTE FOR MAXIMUM PERFORMANCE: 
// you are expected to pass the length of the comparison string/array MINUS ONE as an argument
// this way you can e.g. cache off its length outside of a loop for repeated calls
// if length is passed correctly, this function only does basic integer comparisons.
function PopExtUtil::StartsWithFast( str, prefix, prefixlen ) {

	// first/last character doesn't match, or string is shorter than comparison
	if ( str[0] != prefix[0] || !( prefixlen in str ) || str[prefixlen] != prefix[prefixlen] )
		return false

	local middle = prefixlen >> 1

	if ( str[middle] != prefix[middle] )
		return false

	// binary step through the prefix string/array
	// early returns if one side doesn't match
	for ( local behind = 0, ahead = middle+1; ahead < prefixlen; behind = prefixlen - ahead, ahead++ )
		if ( str[ahead] != prefix[ahead] || str[behind] != prefix[behind] )
			return false

	return true
}

function PopExtUtil::EndsWithFast( str, suffix, strlen, suffixlen ) {

	// first/last character doesn't match, or string is shorter than comparison
	local suffixstart = strlen - suffixlen
	if ( str[strlen] != suffix[suffixlen] || str[suffixstart+1] != suffix[0] )
		return false

	local middle = suffixlen >> 1

	if ( str[suffixstart+middle] != suffix[middle] )
		return false

	// binary step through the suffix string/array
	// early returns if one side doesn't match
	for ( local behind = 0, ahead = middle+1; ahead < strlen; behind = suffixlen - ahead, ahead++ )
		if ( str[ahead] != suffix[ahead] || str[behind] != suffix[behind] )
			return false

	return true
}

// Python's string.capwords()
function PopExtUtil::CapWords( s, sep = null ) {

	if ( sep == null ) sep = " "
	local words = []
	local start = 0
	local end = s.find( sep )
	while ( end != null ) {
		words.push( s.slice( start, end ) )
		start = end + sep.len()
		end = s.find( sep, start )
	}
	words.push( s.slice( start ) )

	local result = []
	foreach ( word in words ) {
		local first_char = word.slice( 0, 1 ).toupper()
		local rest_of_word = word.slice( 1 )
		result.push( first_char + rest_of_word )
	}

	local final_result = ""
	foreach ( i, word in result ) {
		if ( i > 0 ) final_result += sep
		final_result += word
	}
	return final_result
}

// backwards compatibility
PopExtUtil.capwords <- PopExtUtil.CapWords

// Python's string.partition(), except the separator itself is not returned
// Basically like calling python's string.split( sep, 1 ), notice the 1 meaning to only split once
function PopExtUtil::SplitOnce( s, sep = null ) {

	if ( sep == null ) return [s, null]

	local pos = s.find( sep )
	local result_left = pos == 0 ? null : s.slice( 0, pos )
	local result_right = pos == s.len() - 1 ? null : s.slice( pos + 1 )

	return [result_left, result_right]
}

function PopExtUtil::EndWaveReverse( doteamswitch = true ) {

	local temp = CreateByClassname( "logic_autosave" )
	SetPropString( temp, STRING_NETPROP_PURGESTRINGS, true )

	if ( !IsWaveStarted ) return

	//move to red
	if ( doteamswitch )
		foreach ( player in PopExtUtil.HumanArray )
			ChangePlayerTeamMvM( player, TF_TEAM_PVE_DEFENDERS )

	function ClearWaveThink() {

		if ( !PopExtUtil.IsWaveStarted ) {

			if ( doteamswitch )
				foreach ( player in PopExtUtil.HumanArray )
					PopExtUtil.ChangePlayerTeamMvM( player, TF_TEAM_PVE_INVADERS )

			self.Kill()
			return 1
		}
		//kill all bots
		foreach ( bot in PopExtUtil.BotArray )
			if ( bot.IsAlive() && bot.GetTeam() == TF_TEAM_PVE_DEFENDERS )
				PopExtUtil.KillPlayer( bot )
	}
	AddThink( temp, ClearWaveThink )
}

function PopExtUtil::AddThink( ent, func ) {

	local thinktable_name = null
	local thinktable_func = null

	if ( !ent || !ent.IsValid() )
		return

	foreach ( k, v in PopExtConfig.ThinkTableSetup ) {

		if ( typeof v != "array" )
			continue

		if ( startswith( ent.GetClassname(), k ) ) {

			thinktable_name = 0 in v ? v[0] : "ThinkTable"
			thinktable_func = 1 in v ? v[1] : format( "%s_Think", ent.GetName() )

			// if ( thinktable_name == "PlayerThinkTable" ) {

			// 	ForEachItem( ent, @( item ) AddThink( item, func ))
			// }
			break
		}
	}

	local scope = GetEntScope( ent )

	if ( ent.IsPlayer() && !( "PRESERVED" in scope ) )
		scope.PRESERVED <- PopExtMain.ScopePreserved

	// no think table setup, normal function
	if ( !thinktable_name || !thinktable_func ) {

		local func_name = ""

		if ( endswith( typeof func, "function" ) ) {

			func_name = func.getinfos().name || format( "__%s_ANONYMOUS_THINK", ent.GetName() )
			scope[ func_name ] <- func
		}
		else if ( !(func in scope) && func in ROOT ) {

			func_name = func
			scope[ func_name ] <- ROOT[ func_name ].bindenv( scope )
		}

		"_AddThinkToEnt" in ROOT ? _AddThinkToEnt( ent, func_name ) : AddThinkToEnt( ent, func_name )

		return
	}

	// setup thinktable if it doesn't exist
	if ( !( thinktable_name in scope ) )
		scope[ thinktable_name ] <- {}

	scope.__thinktable_name <- thinktable_name

	if ( !( thinktable_func in scope ) ) {

		scope[ thinktable_func ] <- function() {

			foreach ( name, _func in scope[ thinktable_name ] || {} )
				_func.call( scope )

			return -1
		}

        // fix anonymous function declaration
        compilestring( format( @"local _%s = %s; function %s() { _%s() }", thinktable_func, thinktable_func, thinktable_func, thinktable_func ) ).call(scope)

		try { _AddThinkToEnt( ent, thinktable_func ) } catch ( e ) { AddThinkToEnt( ent, thinktable_func ) }
	}
	// only initialize blank think setup for empty string
	if ( func == "" )
		return

	// add think function to thinktable
	else if ( func ) {

		if ( endswith( typeof func, "function" ) ) {

			scope[ thinktable_name ][ func.getinfos().name || format( "__%s_ANONYMOUS_THINK", ent.GetName() ) ] <- func
			return
		}

		else if (
			typeof func == "string"
			&& !( func in scope[ thinktable_name ] )
			&& ( ( func in this && endswith( typeof this[ func ], "function" ) ) || ( func in ROOT && endswith( typeof ROOT[ func ], "function" ) ) )
		) {

			scope[ thinktable_name ][ func ] <- func in this ? this[ func ].bindenv( scope ) : ROOT[ func ].bindenv( scope )
			return
		}
	}
	else {

		scope[ thinktable_name ].clear()
		return
	}

}

PopExtUtil.AddThinkToEnt <- PopExtUtil.AddThink

function PopExtUtil::RemoveThink( ent, func = null ) {

	local scope = GetEntScope( ent )

	if ( !( "__thinktable_name" in scope ) ) {
		SetPropString( ent, "m_iszScriptThinkFunction", "" )
		return
	}

	local thinktable_name = scope.__thinktable_name

	if ( typeof func == "function" )
		func = func.getinfos().name || format( "__%s_ANONYMOUS_THINK", ent.GetName() )

	if ( !( func in scope[ thinktable_name ] ) )
		return

	func == null ? scope[ thinktable_name ].clear() : delete scope[ thinktable_name ][ func ]
}

function PopExtUtil::SilentDisguise( player, target = null, tfteam = TF_TEAM_PVE_INVADERS, tfclass = TF_CLASS_SCOUT ) {

	if ( player == null || !player.IsPlayer() ) return

	function FindTargetPlayer( passcond ) {

		local target = null
		foreach( potentialtarget in HumanArray ) {

			if ( potentialtarget == player || !passcond( potentialtarget ) ) continue

			target = potentialtarget
			break
		}
		return target
	}

	if ( target == null ) {
		// Find disguise target
		target = FindTargetPlayer( @( p ) p.GetTeam() == tfteam && p.GetPlayerClass() == tfclass )
		// Couldn't find any targets of tfclass, look for any class this time
		if ( target == null )
			target = FindTargetPlayer( @( p ) p.GetTeam() == tfteam )
	}

	// Disguise as this player
	if ( target != null ) {
		SetPropInt( player, "m_Shared.m_nDisguiseTeam", target.GetTeam() )
		SetPropInt( player, "m_Shared.m_nDisguiseClass", target.GetPlayerClass() )
		SetPropInt( player, "m_Shared.m_iDisguiseHealth", target.GetHealth() )
		SetPropEntity( player, "m_Shared.m_hDisguiseTarget", target )
		// When we drop our disguise, the player we disguised as gets this weapon removed for some reason
		//SetPropEntity( player, "m_Shared.m_hDisguiseWeapon", target.GetActiveWeapon() )
	}
	// No valid targets, just give us a generic disguise
	else {
		SetPropInt( player, "m_Shared.m_nDisguiseTeam", tfteam )
		SetPropInt( player, "m_Shared.m_nDisguiseClass", tfclass )
	}

	player.AddCond( TF_COND_DISGUISED )

	// Hack to get our movespeed set correctly for our disguise
	player.AddCond( TF_COND_SPEED_BOOST )
	player.RemoveCond( TF_COND_SPEED_BOOST )
}

function PopExtUtil::GetPlayerReadyCount() {

	if ( IsWaveStarted ) 
		return 0

	local ready = 0

	local size = GetPropArraySize( GameRules, "m_bPlayerReady" )

	for ( local i = 0; i < size; i++ ) 
		if ( GetPropBoolArray( GameRules, "m_bPlayerReady", i ) )
			ready++

	return ready
}

function PopExtUtil::GetWeaponMaxAmmo( player, wep ) {

	if ( wep == null ) return

	local slot      = wep.GetSlot()
	local classname = wep.GetClassname()
	local itemid    = GetItemIndex( wep )

	local table = MaxAmmoTable[player.GetPlayerClass()]

	if ( !( itemid in table ) && !( classname in table ) )
		return -1

	local base_max = ( itemid in table ) ? table[itemid] : table[classname]

	/*
	local mod = 1.0

	local incr
	local decr
	local hid
	if ( slot == SLOT_PRIMARY ) {
		incr = wep.GetAttribute( "maxammo primary increased", 1.0 )
		decr = wep.GetAttribute( "maxammo primary reduced", 1.0 )
		hid  = wep.GetAttribute( "hidden primary max ammo bonus", 1.0 )
	}
	else if ( slot == SLOT_SECONDARY ) {
		incr = wep.GetAttribute( "maxammo secondary increased", 1.0 )
		decr = wep.GetAttribute( "maxammo secondary reduced", 1.0 )
		hid  = wep.GetAttribute( "hidden secondary max ammo penalty", 1.0 )
	}

	mod *= incr * decr * hid
	return base_max * mod
	*/

	return base_max
}

function PopExtUtil::TeleportNearVictim( ent, victim, attempt ) {

	if ( victim == null )
		return false

	if ( victim.GetLastKnownArea() == null )
		return

	const max_surround_travel_range = 6000.0

	local surround_travel_range = 1500.0 + 500.0 * attempt
	surround_travel_range = Max( surround_travel_range, max_surround_travel_range )

	local areas = {}
	GetNavAreasInRadius( victim.GetLastKnownArea().GetCenter(), surround_travel_range, areas )

	local ambush_areas = []

	foreach ( name, area in areas ) {
		if ( !area.IsValidForWanderingPopulation() )
			continue

		if ( area.IsPotentiallyVisibleToTeam( victim.GetTeam() ) )
			continue

		ambush_areas.push( area )
	}

	if ( ambush_areas.len() == 0 )
		return false

	local max_tries = Min( 10, ambush_areas.len() )

	for ( local retry = 0; retry < max_tries; ++retry ) {
		local which = RandomInt( 0, ambush_areas.len() - 1 )
		local where = ambush_areas[which].GetCenter() + Vector( 0, 0, STEP_HEIGHT )

		if ( IsSpaceToSpawnHere( where, ent.GetBoundingMins(), ent.GetBoundingMaxs() ) ) {
			ent.SetAbsOrigin( where )
			return true
		}
	}

	return false
}

function PopExtUtil::IsSpaceToSpawnHere( where, hullmin, hullmax ) {

	local trace = {
		start = where,
		end = where,
		hullmin = hullmin,
		hullmax = hullmax,
		mask = MASK_PLAYERSOLID
	}
	TraceHull( trace )

	return trace.fraction >= 1.0
}

function PopExtUtil::ClearLastKnownArea( bot ) {

	local trigger = SpawnEntityFromTable( "trigger_remove_tf_player_condition", {
		spawnflags = SF_TRIGGER_ALLOW_CLIENTS,
		condition = TF_COND_TMPDAMAGEBONUS,
	})
	EntFireByHandle( trigger, "StartTouch", "!activator", -1, bot, bot )
	EntFireByHandle( trigger, "Kill", "", -1, null, null )
}

function PopExtUtil::KillPlayer( player ) {
	player.TakeDamage( INT_MAX, 0, TriggerHurt )
}

function PopExtUtil::KillAllBots() {
	foreach ( bot in BotArray )
		if ( bot.IsAlive() )
			KillPlayer( bot )
}

// EntFire wrapper for:
// - Purging game strings to avoid CUtlRBTree Overflow crashes
// - Logging for invalid targets when debug mode is enabled
// - Handling dead players without putting isalive checks everywhere
function PopExtUtil::ScriptEntFireSafe( target, code, delay = -1, activator = null, caller = null, allow_dead = false ) {

	local entfirefunc = typeof target == "string" ? DoEntFire : EntFireByHandle

	entfirefunc( target, "RunScriptCode", format( @"

		if ( self && self.IsValid() ) {

			SetPropBool( self, STRING_NETPROP_PURGESTRINGS, true )

			if ( self.IsPlayer() && !self.IsAlive() && %d == 0 ) {

				PopExtMain.Error.DebugLog( `Ignoring dead player in ScriptEntFireSafe: ` + self )
				return
			}

			// code passed to ScriptEntFireSafe
			%s

			return
		}

		PopExtMain.Error.DebugLog( `Invalid target passed to ScriptEntFireSafe: ` + self )

	", allow_dead.tointeger(), code ), delay, activator, caller )

	PURGE_STRINGS( code )
}

function PopExtUtil::RunWithDelay( delay, func, bindto = this, preserved = false ) {

	local ent = preserved ? self : Worldspawn
	local scope = GetEntScope( ent )

	local funcname = func.getinfos().name || "PopExtUtil_RunWithDelay_" + UniqueString()

	scope[ funcname ] <- function[bindto]() { 
		
		func()
		PURGE_STRINGS( funcname )
		delete scope[ funcname ]
	}

	// anonymous func, redefine to avoid '<lambda or free run script>' in console
	compilestring( format( "local _%s = %s; function %s() { _%s() }", funcname, funcname, funcname, funcname ) ).call( scope )

	EntFireByHandle( ent, "CallScriptFunction", funcname, delay, null, null )
	return funcname
}

function PopExtUtil::SetDestroyCallback( entity, callback ) {

	local scope = GetEntScope( entity )

	if ( "__popext_destroy_callback" in scope )
		return

	scope.__popext_destroy_callback <- callback.bindenv( scope )

	scope.setdelegate({}.setdelegate({

			parent   = scope.getdelegate()
			id       = entity.GetScriptId()
			index    = entity.entindex()

			function _get( k ) {

				return parent[k]
			}

			function _delslot( k ) {

				if ( k == id ) {

					entity = EntIndexToHScript( index )
					local scope = entity.GetScriptScope()
					scope.self <- entity
					scope.__popext_destroy_callback()
					PURGE_STRINGS( id )
				}
				delete parent[k]
			}
		})
	)
}

function PopExtUtil::OnWeaponFire( wep, func ) {

	if ( wep == null ) return

	local scope = GetEntScope( wep )

	scope.last_fire_time <- 0.0

	function OnWeaponFireThink() {

		local fire_time = GetPropFloat( self, "m_flLastFireTime" )
		if ( fire_time > last_fire_time ) {
			func.call( scope )
			last_fire_time = fire_time
		}
		return
	}
	AddThink( wep, OnWeaponFireThink )
}

function PopExtUtil::ForEachItem( player, func, weapons_only = false ) {

	for ( local child = player.FirstMoveChild(); child; child = child.NextMovePeer() )
		if ( !weapons_only || child instanceof CBaseCombatWeapon )
			func( child )
}

function PopExtUtil::IsProjectileWeapon( wep ) {

	local wep_classname = wep.GetClassname()
	local override_projectile = wep.GetAttribute( "override projectile type", 0.0 )

	return ( wep_classname in PROJECTILE_WEAPONS && override_projectile != 1 ) || override_projectile > 1
}

function PopExtUtil::GetLastFiredProjectile( player ) {

	local active_projectiles = GetEntScope( player ).PRESERVED.active_projectiles
	local projectiles = []

	foreach ( projectile, info in active_projectiles )
		projectiles.append( info )

	projectiles.sort( @( a, b ) a[1] <=> b[1] )

	local projectiles_len = projectiles.len()
	return projectiles_len ? projectiles[ projectiles_len - 1 ][ 0 ] : null

}

function PopExtUtil::ChangeLevel( mapname = "", delay = 1.0, mvm_cyclemissionfile = false ) {

	if ( mapname != "" ) {

		// listen servers can just do this
		if ( !IsDedicatedServer() )
			SendToConsole( format( "nextlevel %s", mapname ) )

		// check for allow point_servercommand
		else if ( GetStr( "sv_allow_point_servercommand" ) == "always" )
			SendToServerConsole( format( "nextlevel %s", mapname ) )

		// check the allowlist
		else if ( IsConVarOnAllowList( "nextlevel" ) )
			SetValue( "nextlevel", mapname )

		// can't set it, just load the next map in the mapcycle file or hope the server sets nextlevel for us
		else
			PopExtMain.Error.ParseError( "PopExtUtil.ChangeLevel: cannot set nextlevel! loading next map instead..." )
	}

	// required for GoToIntermission
	SetValue( "mp_tournament", 0 )

	// wait at scoreboard for this many seconds
	SetValue( "mp_chattime", delay )

	local intermission = Entities.CreateByClassname( "point_intermission" )

	// for mvm, otherwise it'll ignore delay and switch to the next map in the missioncycle file
	if ( !mvm_cyclemissionfile )
		EntFire( "info_populator", "Kill" )

	// don't use acceptinput so we execute after info_populator kill
	EntFireByHandle( intermission, "Activate", "", -1, null, null )
}

function PopExtUtil::ToStrictNum( str, float = false ) {

	if ( typeof str == "string" ) {

		str = strip(str)
		local rex = regexp( @"-?[0-9]+(\.[0-9]+)?" )
		if ( !rex.match( str ) ) return
	}

	try
		return float ? str.tofloat() : str.tointeger()
	catch ( _ )
		return
}

function PopExtUtil::SetRedMoney( value ) {

	if ( !value ) {

		POP_EVENT_HOOK( "player_death", "ForceRedMoneyKill", null, EVENT_WRAPPER_UTIL )
		return
	}

	POP_EVENT_HOOK("player_death", "ForceRedMoneyKill", function( params ) {

		local should_collect = false

		if ( value >= 1 )
			should_collect = true
		else {

			local attacker = GetPlayerFromUserID( params.attacker )

			if ( attacker ) {

				for ( local i = 0; i < SLOT_COUNT; i++ ) {

					local weapon = GetPropEntityArray( attacker, STRING_NETPROP_MYWEAPONS, i )

					if ( weapon == null )
						continue

					if ( GetItemIndex( weapon ) != params.weapon_def_index )
						continue

					local weapon_scope = GetEntScope( weapon )
					if ( weapon_scope && "collect_currency_on_kill" in weapon_scope )
						should_collect = true
				}
			}
		}

		if ( !should_collect )
			return

		local player = GetPlayerFromUserID( params.userid )

		// bots only drop item_currencypack_custom, but all other pack classes are supported just in case
		for ( local entity; entity = FindByClassnameWithin( entity, "item_currencypack_*", player.GetOrigin(), 100 ); ) {

			local scope = GetEntScope( entity )
			scope.real_origin <- entity.GetOrigin()

			function CollectPack() {

				local pack = self

				if ( !pack.IsValid() )
					return

				if ( GetPropBool( pack, "m_bDistributed" ) )
					return

				local origin = GetEntScope( pack ).real_origin
				local owner = GetPropEntity( pack, "m_hOwnerEntity" )
				local model_path = pack.GetModelName()

				local objective_resource = PopExtUtil.ObjectiveResource

				local money_before = GetPropInt( objective_resource, "m_nMvMWorldMoney" )
				pack.Kill()
				local money_after = GetPropInt( objective_resource, "m_nMvMWorldMoney" )

				local pack_price = money_before - money_after

				local mvm_stats = PopExtUtil.MvMStatsEnt

				SetPropInt( mvm_stats, "m_currentWaveStats.nCreditsAcquired", GetPropInt( mvm_stats, "m_currentWaveStats.nCreditsAcquired" ) + pack_price )

				for ( local i = 1, player; i <= MaxClients(); i++ )
					if ( player = PlayerInstanceFromIndex( i ), player && !player.IsBotOfType( TF_BOT_TYPE ) )
						player.AddCurrency( pack_price )

				// spawn a worthless currencypack which can be collected by a scout for overheal
				local fake_pack = CreateByClassname( "item_currencypack_custom" )
				SetPropBool( fake_pack, "m_bDistributed", true )
				SetPropEntity( fake_pack, "m_hOwnerEntity", owner )
				DispatchSpawn( fake_pack )
				fake_pack.SetModel( model_path )

				// position to ground, as fake pack won't have any velocity
				trace_world <- {
					start = origin,
					end = origin - Vector( 0, 0, 50000 )
					mask = MASK_SOLID_BRUSHONLY
				}

				TraceLineEx( trace_world )

				if ( trace_world.hit ) {

					fake_pack.SetAbsOrigin( trace_world.pos + Vector( 0, 0, 5 ) )
				}
				else
					fake_pack.SetAbsOrigin( origin )


				GetEntScope( fake_pack ).despawn_time <- Time() + TF_POWERUP_LIFETIME

				function DespawnThink() {

					if ( Time() < despawn_time )
						return

					fake_pack.Kill()
				}
				AddThink( fake_pack, DespawnThink )
			}
			scope.CollectPack <- CollectPack

			entity.SetAbsOrigin( Vector( -1000000, -1000000, -1000000 ) )
			EntFireByHandle( entity, "CallScriptFunction", "CollectPack", 0, null, null )
		}

	}, EVENT_WRAPPER_UTIL )
}

function PopExtUtil::SetConvar( convar, value, duration = 0, hide_chat_message = false ) {

	// TODO: this hack doesn't seem to work.
	local commentary_node = hide_chat_message ? CommentaryNode() : null

	// save original values to restore later
	if ( !( convar in ConVars ) ) ConVars[convar] <- GetStr( convar )

	// delay to ensure its set after any server configs
	if ( GetStr( convar ) != value )
		RunWithDelay( 0.1, @() SetValue( convar, value.tostring() ) )

	if ( duration > 0 )
		RunWithDelay( duration, @() SetValue( convar, ConVars[convar].tostring() ) )

	if ( commentary_node )
		EntFireByHandle( commentary_node, "Kill", "", 1, null, null )
}

function PopExtUtil::ResetConvars( hide_chat_message = true ) {

	local commentary_node = hide_chat_message ? CommentaryNode() : null

	foreach ( convar, value in ConVars )
		SetValue( convar, value.tostring() )

	ConVars.clear()

	if ( commentary_node )
		EntFireByHandle( commentary_node, "Kill", "", -1, null, null )
}

function PopExtUtil::ValidatePlayerTables() {

	// remove invalid players from the table
	local invalid = []

	foreach(player, _ in PlayerTable)
		if ( !player || !player.IsValid() )
			invalid.append( player )

	foreach( player in invalid ) {

		delete PlayerTable[ player ]

		if ( player in HumanTable )
			delete HumanTable[ player ]

		if ( player in BotTable )
			delete BotTable[ player ]
	}

	// copy data to backwards compatible arrays
	HumanArray  = HumanTable.keys()
	BotArray    = BotTable.keys()
	PlayerArray = PlayerTable.keys()
}

function PopExtUtil::KVStringToVectorOrQAngle( str, angles = false, startidx = 0 ) {

	if ( typeof str == "Vector" || typeof str == "QAngle" )
		return str

	local separator = str.find( "," ) ? "," : " "

	local split = split( str, separator, true ).apply( @( v ) PopExtUtil.ToStrictNum( v, true ) )

	local errorstr = "KVString CONVERSION ERROR: %s"

	if ( !( 2 in split ) ) {

		PopExtMain.Error.ParseError( format( errorstr, "Not enough values (need at least 3)" ), true )
		return angles ? QAngle() : Vector()
	}

	local invalid = split.find( null )

	if (invalid != null) {

		local invalid_kvstringidx = invalid
		if ( invalid ) {

			local invalid_mod = invalid % 3
			invalid_kvstringidx = !invalid_mod ? 2 : invalid_mod - 1
		}

		local kvstringvalue = angles ? ["yaw", "pitch", "roll"] : ["X", "Y", "Z"]
		PopExtMain.Error.ParseError( format( errorstr, format("Could not convert string to number for KVString %s (index %d)", kvstringvalue[ invalid_kvstringidx ], invalid ) ), true )
		return angles ? QAngle() : Vector()
	}

	return angles ? QAngle( split[ startidx ], split[ startidx + 1 ], split[ startidx + 2 ] ) : Vector( split[ startidx ], split[ startidx + 1 ], split[ startidx + 2 ] )
}

// MATH

function PopExtUtil::Min( a, b ) {
	return ( a <= b ) ? a : b
}

function PopExtUtil::Max( a, b ) {
	return ( a >= b ) ? a : b
}

function PopExtUtil::Round( num, decimals=0 ) {

	if ( decimals <= 0 )
		return floor( num + 0.5 )

	local mod = pow( 10, decimals )
	return floor( ( num * mod ) + 0.5 ) / mod
}

function PopExtUtil::Clamp( x, a, b ) {
	return Min( b, Max( a, x ) )
}

function PopExtUtil::RemapVal( v, A, B, C, D ) {

	if ( A == B ) {
		if ( v >= B )
			return D
		return C
	}
	return C + ( D - C ) * ( v - A ) / ( B - A )
}

function PopExtUtil::RemapValClamped( v, A, B, C, D ) {

	if ( A == B ) {
		if ( v >= B )
			return D
		return C
	}
	local cv = ( v - A ) / ( B - A )
	if ( cv <= 0.0 )
		return C
	if ( cv >= 1.0 )
		return D
	return C + ( D - C ) * cv
}

function PopExtUtil::IntersectionPointBox( pos, mins, maxs ) {

	if ( pos.x < mins.x || pos.x > maxs.x ||
		pos.y < mins.y || pos.y > maxs.y ||
		pos.z < mins.z || pos.z > maxs.z )
		return false

	return true
}

function PopExtUtil::NormalizeAngle( target ) {

	target %= 360.0
	if ( target > 180.0 )
		target -= 360.0
	else if ( target < -180.0 )
		target += 360.0
	return target
}

function PopExtUtil::ApproachAngle( target, value, speed ) {

	target = NormalizeAngle( target )
	value = NormalizeAngle( value )
	local delta = NormalizeAngle( target - value )
	if ( delta > speed )
		return value + speed
	else if ( delta < -speed )
		return value - speed
	return target
}

function PopExtUtil::VectorAngles( forward ) {

	local yaw, pitch
	if ( forward.y == 0.0 && forward.x == 0.0 ) {
		yaw = 0.0
		if ( forward.z > 0.0 )
			pitch = 270.0
		else
			pitch = 90.0
	}
	else {
		yaw = ( atan2( forward.y, forward.x ) * 180.0 / Pi )
		if ( yaw < 0.0 )
			yaw += 360.0
		pitch = ( atan2( -forward.z, forward.Length2D() ) * 180.0 / Pi )
		if ( pitch < 0.0 )
			pitch += 360.0
	}

	return QAngle( pitch, yaw, 0.0 )
}

function PopExtUtil::AnglesToVector( angles ) {

	local pitch = angles.x * Pi / 180.0
	local yaw = angles.y * Pi / 180.0
	local x = cos( pitch ) * cos( yaw )
	local y = cos( pitch ) * sin( yaw )
	local z = sin( pitch )
	return Vector( x, y, z )
}

function PopExtUtil::QAngleDistance( a, b ) {

	local dx = a.x - b.x
	local dy = a.y - b.y
	local dz = a.z - b.z
	return sqrt( dx*dx + dy*dy + dz*dz )
}

function PopExtUtil::Clamp360Angle( ang ) {

	local t = {x = ang.x, y = ang.y, z = ang.z}

	// Clamp
	foreach ( index, angle in t ) {

		if ( angle > 360 || angle < -360 ) {

			local x = fabs( angle / 360.0 )
			t[index] = Round( ( x - floor( x ) ) * 360.0, 3 )
		}
	}

	// Abs
	foreach ( index, angle in t )
		if ( angle < 0 )
			t[index] = 360.0 - fabs( angle )

	return QAngle( t.x, t.y, t.z )
}

function PopExtUtil::CheckBitwise( num ) {
	return ( num != 0 && ( ( num & ( num - 1 ) ) == 0 ) )
}

POP_EVENT_HOOK( "mvm_wave_failed", "UtilWaveStatus", function ( params ) { PopExtUtil.IsWaveStarted = false }, EVENT_WRAPPER_UTIL )
POP_EVENT_HOOK( "mvm_begin_wave", "UtilWaveStatus", function ( params ) { PopExtUtil.IsWaveStarted = true }, EVENT_WRAPPER_UTIL )

POP_EVENT_HOOK( "mvm_wave_complete", "UtilWaveStatus", function ( params ) {

	PopExtUtil.IsWaveStarted = false
	PopExtUtil.ResetConvars()

}, EVENT_WRAPPER_UTIL )

POP_EVENT_HOOK( "teamplay_round_start", "UtilRoundStart", function ( params ) {

	PopExtUtil.IsWaveStarted = false
	SetPropBool( PopExtUtil.GameRules, "m_bIsInTraining", false )
	PopExtUtil.ResetConvars()

}, EVENT_WRAPPER_UTIL )

POP_EVENT_HOOK( "player_activate", "UtilPlayerActivate", function ( params ) {

	local player = GetPlayerFromUserID( params.userid )

	if ( !player.IsBotOfType( TF_BOT_TYPE ) && !( player in PopExtUtil.HumanTable ) )
		PopExtUtil.HumanTable[ player ] <- params.userid

	else if ( !( player in PopExtUtil.PlayerTable ) )
		PopExtUtil.PlayerTable[ player ] <- params.userid

	PopExtUtil.ValidatePlayerTables()

}, EVENT_WRAPPER_UTIL)

POP_EVENT_HOOK( "player_disconnect", "UtilPlayerDisconnect", function ( params ) {

	local player = GetPlayerFromUserID( params.userid )

	local bot_table    = PopExtUtil.BotTable
	local human_table  = PopExtUtil.HumanTable
	local player_table = PopExtUtil.PlayerTable

	if ( player in human_table )
		delete human_table[ player ]

	// this is normally not needed, but certain missions (red ridge) will kick bots instead of moving them to spectator
	if ( player in bot_table )
		delete bot_table[ player ]

	if ( player in player_table )
		delete player_table[ player ]

	PopExtUtil.ValidatePlayerTables()

}, EVENT_WRAPPER_UTIL)

POP_EVENT_HOOK( "post_inventory_application", "UtilPostInventoryApplication", function( params ) {

	local player = GetPlayerFromUserID( params.userid )

	if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
		return

	local scope = player.GetScriptScope()

	//sort weapons by slot
	local myweapons = {}

	PopExtUtil.ForEachItem( player, @( child ) myweapons[child.GetSlot()] <- child, true)

	foreach( slot, wep in myweapons ) {

		local wep = GetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, slot )

		SetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, wep, slot )
	}

	local bot_table    = PopExtUtil.BotTable
	local human_table  = PopExtUtil.HumanTable
	local player_table = PopExtUtil.PlayerTable

	if ( !player_table.len() || !human_table.len() || !bot_table.len() ) {

		for ( local i = 1, player; i <= MAX_CLIENTS; player = PlayerInstanceFromIndex( i ), i++ ) {

			if ( !player ) continue

			local scope = PopExtUtil.GetEntScope( player )
			local userid = PopExtUtil.GetPlayerUserID( player )

			if ( player.IsBotOfType( TF_BOT_TYPE ) )
				bot_table[ player ] <- userid
			else
				human_table[ player ] <- userid

			player_table[ player ] <- userid
		}

		return
	}

	if ( player.IsBotOfType( TF_BOT_TYPE ) )
		bot_table[ player ] <- params.userid

	else if ( !( player in human_table ) )
		human_table[ player ] <- params.userid

	if ( !( player in player_table ) )
		player_table[ player ] <- params.userid

	PopExtUtil.ValidatePlayerTables()

	PopExtUtil.HumanArray  = human_table.keys()
	PopExtUtil.BotArray    = bot_table.keys()
	PopExtUtil.PlayerArray = player_table.keys()

}, EVENT_WRAPPER_UTIL)

//shorter syntax in popfiles ( Info( message ) vs PopExtUtil.Info( message ) )
function Info( message, print_color = COLOR_YELLOW, message_prefix = "Explanation: ", sync_chat_with_game_text = false, text_print_time = -1, text_scan_time = 0.02 ) {
	PopExtUtil.DoExplanation( message, print_color, message_prefix, sync_chat_with_game_text, text_print_time, text_scan_time )
}

function Explanation( message, print_color = COLOR_YELLOW, message_prefix = "Explanation: ", sync_chat_with_game_text = false, text_print_time = -1, text_scan_time = 0.02 ) {
	PopExtUtil.DoExplanation( message, print_color, message_prefix, sync_chat_with_game_text, text_print_time, text_scan_time )
}

GetAllAreas( PopExtUtil.AllNavAreas )
// PopExtUtil.ForEachEnt( null, null, null, null, true )
