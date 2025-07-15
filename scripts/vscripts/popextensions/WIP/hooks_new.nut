popext_entity <- FindByName( null, "__popext" )
if ( popext_entity == null ) popext_entity = SpawnEntityFromTable( "info_teleport_destination", { targetname = "__popext" } )

popext_entity.ValidateScriptScope()
PopExt <- popext_entity.GetScriptScope()

::PopExtHooks <- {

	tank_icons = []
	icons 	   = []

	function AddHooksToScope( name, table, scope ) {

		foreach( hook_name, func in table ) {
			// Entries in hook table must begin with 'On' to be considered hooks
			if ( hook_name.slice( 0,2 ) == "On" ) {

				if ( !( "popHooks" in scope ) )
					scope.popHooks <- {}

				if ( !( hook_name in scope.popHooks ) )
					scope.popHooks[hook_name] <- []

				scope.popHooks[hook_name].append( func )
			}
			else {
				if ( !( "pop_property" in scope ) )
					scope.pop_property <- {}

				scope.pop_property[hook_name] <- func
			}
		}
	}

	function FireHooks( entity, scope, name ) {
		if ( scope != null && "popHooks" in scope && name in scope.popHooks )
			foreach( index, func in scope.popHooks[name] )
				func( entity )
	}
	function FireHooksParam( entity, scope, name, param ) {
		if ( scope != null && "popHooks" in scope && name in scope.popHooks )
			foreach( index, func in scope.popHooks[name] )
				func( entity, param )
	}
}

PopExtEvents.AddRemoveEventHook( "OnTakeDamage", "PopHooksTakeDamage", function( params ) {

	local victim = params.const_entity
	local attacker = params.attacker

	if ( victim != null ) {

		local scope = victim.GetScriptScope()
		if ( attacker != null ) local attackerscope = attacker.GetScriptScope()

		if ( victim.GetClassname() == "tank_boss" && "pop_property" in scope )
			if ( "CritImmune" in scope.pop_property && scope.pop_property.CritImmune && params.damage_type & DMG_CRITICAL )
				params.damage_type = params.damage_type &~ DMG_CRITICAL

		else if ( attacker != null && attacker.GetClassname() == "tank_boss" && "pop_property" in attackerscope && victim.IsPlayer() )
			if ( "CrushDamageMult" in attackerscope.pop_property )
				params.damage *= attackerscope.pop_property.CrushDamageMult

		PopExtHooks.FireHooksParam( victim, scope, "OnTakeDamage", params )
	}

	local attacker = params.attacker
	if ( attacker != null && attacker.IsPlayer() ) {
		local scope = attacker.GetScriptScope()
		PopExtHooks.FireHooksParam( attacker, scope, "OnDealDamage", params )
	}
}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "player_spawn", "PopHooksPlayerSpawn", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = player.GetScriptScope()

	if ( scope != null && "wearables_to_kill" in scope ) {
		foreach( wearable in scope.wearables_to_kill )
			if ( wearable.IsValid() )
				EntFireByHandle( wearable, "Kill", "", -1, null, null )

		delete scope.wearables_to_kill
	}

	if ( "popFiredDeathHook" in scope && !scope.popFiredDeathHook ) {

		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.popFiredDeathHook
	}

	// Reset hooks
	if ( "botCreated" in scope )
		delete scope.botCreated

	if ( "popHooks" in scope )
		delete scope.popHooks

}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "player_team", "PopHooksPlayerTeam", function( params ) {

	if ( params.team != TEAM_SPECTATOR ) return

	local player = GetPlayerFromUserID( params.userid )

	if ( !player ) return //can sometimes be null when the server empties out?

	local scope = player.GetScriptScope()

	if ( scope != null && "wearables_to_kill" in scope ) {
		foreach( wearable in scope.wearables_to_kill )
			if ( wearable.IsValid() )
				EntFireByHandle( wearable, "Kill", "", -1, null, null )

		delete scope.wearables_to_kill
	}

	if ( "popFiredDeathHook" in scope && !scope.popFiredDeathHook ) {
		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.popFiredDeathHook
	}

		// Reset hooks
	if ( "botCreated" in scope )
		delete scope.botCreated

	if ( "popHooks" in scope )
		delete scope.popHooks

}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "player_hurt", "PopHooksPlayerHurt", function( params ) {

	local victim = GetPlayerFromUserID( params.userid )
	local scope = victim.GetScriptScope()

	PopExtHooks.FireHooksParam( victim, scope, "OnTakeDamagePost", params )

	local attacker = GetPlayerFromUserID( params.attacker )

	if ( attacker != null ) {
		local scope = attacker.GetScriptScope()
		PopExtHooks.FireHooksParam( attacker, scope, "OnDealDamagePost", params )
	}
}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "player_death", "PopHooksPlayerDeath", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = player.GetScriptScope()
	scope.popFiredDeathHook <- true
	PopExtHooks.FireHooksParam( player, scope, "OnDeath", params )


	local attacker = GetPlayerFromUserID( params.attacker )
	if ( attacker != null ) {
		local scope = attacker.GetScriptScope()
		PopExtHooks.FireHooksParam( attacker, scope, "OnKill", params )
	}
}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "mvm_begin_wave", "PopHooksWaveStarts", function( params ) {

	if ( "wave_icons_function" in PopExt )
		PopExt.wave_icons_function()

	foreach( v in PopExtHooks.tank_icons )
		PopExt._PopIncrementTankIcon( v )

	foreach( v in PopExtHooks.icons )
		PopExt._PopIncrementIcon( v )
}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "recalculate_holidays", "PopHooksRecalculateHolidays", function( params ) {

	if ( "wave_icons_function" in PopExt )
		delete PopExt.wave_icons_function

	PopExtHooks.tank_icons <- []
	PopExtHooks.icons     <- []
}, EVENT_WRAPPER_HOOKS)

function PopExtGlobalThink() {

	if ( !PopExtUtil.IsWaveStarted )
		return 0.2

	foreach ( player in PopExtUtil.BotTable.keys() ) {

		local scope = player.GetScriptScope()
		// Make sure that ondeath hook is fired always
		if ( !player.IsAlive() && "popFiredDeathHook" in scope ) {
			if ( !scope.popFiredDeathHook )
				PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )

			delete scope.popFiredDeathHook
		}
	}
	return -1
}
