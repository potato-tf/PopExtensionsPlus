local popext_hooks_entity = FindByName( null, "__popext_hooks" )
if ( popext_hooks_entity == null ) 
	popext_hooks_entity = SpawnEntityFromTable( "info_teleport_destination", { targetname = "__popext_hooks" } )

popext_hooks_entity.ValidateScriptScope()
::PopExtHooks <- popext_hooks_entity.GetScriptScope()

function PopExtHooks::AddHooksToScope( name, table, scope ) {

	foreach( hook_name, func in table ) {

		// Entries in hook table must begin with 'On' to be considered hooks
		if ( hook_name.slice( 0,2 ) == "On" ) {

			if ( !( "popext_hooks" in scope ) )
				scope.popext_hooks <- {}

			if ( !( hook_name in scope.popext_hooks ) )
				scope.popext_hooks[hook_name] <- []

			scope.popext_hooks[hook_name].append( func )
		}
		else {
			if ( !( "pop_property" in scope ) )
				scope.pop_property <- {}

			scope.pop_property[hook_name] <- func
		}
		// legacy backwards compatibility, some missions still use the old camelCase names
		scope.popHooks 	  <- scope_popext_hooks
		scope.popProperty <- scope_pop_property
	}
}

function PopExtHooks::FireHooks( entity, scope, name ) {

	if ( scope != null && "popext_hooks" in scope && name in scope.popext_hooks )
		foreach( index, func in scope.popext_hooks[name] )
			func( entity )
}
function PopExtHooks::FireHooksParam( entity, scope, name, param ) {

	if ( scope != null && "popext_hooks" in scope && name in scope.popext_hooks )
		foreach( index, func in scope.popext_hooks[name] )
			func( entity, param )
}

function PopExtHooks::PopExtHooksThink() {

	if ( !PopExtUtil.IsWaveStarted )
		return 0.2

	foreach ( player in PopExtUtil.BotArray ) {

		local scope = player.GetScriptScope()
		// Make sure that ondeath hook is fired always
		if ( !player.IsAlive() && "pop_fired_death_hook" in scope ) {
			if ( !scope.pop_fired_death_hook )
				PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )

			delete scope.pop_fired_death_hook
		}
	}
	return -1
}

AddThinkToEnt( popext_hooks_entity, "PopExtHooksThink" )

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

	if ( "pop_fired_death_hook" in scope && !scope.pop_fired_death_hook ) {

		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.pop_fired_death_hook
	}

	// Reset hooks
	if ( "botCreated" in scope )
		delete scope.botCreated

	if ( "popext_hooks" in scope )
		delete scope.popext_hooks

}, EVENT_WRAPPER_HOOKS)

PopExtEvents.AddRemoveEventHook( "player_team", "PopHooksPlayerTeam", function( params ) {

	if ( params.team != TEAM_SPECTATOR ) return

	local player = GetPlayerFromUserID( params.userid )

	if ( !player ) return // can sometimes be null when the server empties out? Likely a rafmod bug

	local scope = player.GetScriptScope()

	if ( scope != null && "wearables_to_kill" in scope ) {
		foreach( wearable in scope.wearables_to_kill )
			if ( wearable.IsValid() )
				EntFireByHandle( wearable, "Kill", "", -1, null, null )

		delete scope.wearables_to_kill
	}

	if ( "pop_fired_death_hook" in scope && !scope.pop_fired_death_hook ) {
		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.pop_fired_death_hook
	}

		// Reset hooks
	if ( "botCreated" in scope )
		delete scope.botCreated

	if ( "popext_hooks" in scope )
		delete scope.popext_hooks

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
	scope.pop_fired_death_hook <- true
	PopExtHooks.FireHooksParam( player, scope, "OnDeath", params )


	local attacker = GetPlayerFromUserID( params.attacker )
	if ( attacker != null ) {
		local scope = attacker.GetScriptScope()
		PopExtHooks.FireHooksParam( attacker, scope, "OnKill", params )
	}
}, EVENT_WRAPPER_HOOKS)
