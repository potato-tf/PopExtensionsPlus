POPEXT_CREATE_SCOPE( "__popext_customattributes", "PopExtAttributes" )

function PopExtAttributes::_OnDestroy() {

	if ( "CustomAttributes" in ROOT )
		delete ::CustomAttributes
}

PopExtAttributes.Descs <- {

	"fires milk bolt" 				: "Secondary attack: fires a bolt that applies milk for %.2f seconds. Regenerates every %.2f seconds.",
	"add cond on hit" 				: "applies cond %d to victim on hit for %.2f seconds",
	"remove cond on hit" 			: "removes cond %d from victim",
	"self add cond on hit" 			: "applies cond %d to self on hit for %.2f seconds",
	"self add cond on kill" 		: "applies cond %d to self on kill for %.2f seconds",
	"fire input on hit" 			: "fires custom entity input on hit: %s",
	"fire input on kill" 			: "fires custom entity input on kill: %s",
	"mult dmg vs same class" 		: "Damage versus %s multiplied by %.2f",
	"mult dmg vs airborne" 			: "Damage versus airborne targets multiplied by %.2f",
	"teleport instead of die" 		: "%d⁒ chance of teleporting to spawn with 1 health instead of dying",
	"melee cleave attack" 			: "On Swing: Weapon hits multiple targets",
	"mult teleporter recharge time" : "Teleporter recharge rate multiplied by %.2f",
	"uber on damage taken" 			: "On damage taken: gain %d⁒ of uber",
	"set turn to ice" 				: "On Kill: Turn victim to ice.",
	"mod teleporter speed boost" 	: "Teleporters grant a speed boost for %.2f seconds",
	"can breathe under water" 		: "Player can breathe underwater",
	"mult swim speed" 				: "Swimming speed multiplied by %.2f",
	"last shot crits" 				: "Crit boost on last shot. Crit boost will stay active for %.2f seconds after holster",
	"crit when health below" 		: "On health below %d⁒: gain crit boost",
	"wet immunity" 					: "Immune to jar effects",
	"build small sentries" 			: "On kill: build a small sentry",
	"mvm sentry ammo" 				: "On kill: gain %d rounds of sentry ammo",
	"radius sleeper" 				: "On kill: sleep radius of %.2f",
	"explosive bullets" 			: "On hit: explode for %.2f damage",
	"explosive bullets ext" 		: "On hit: explode for %.2f damage",
	"old sandman stun" 				: "On hit: stun for %.2f seconds",
	"stun on hit" 					: "On hit: stun for %.2f seconds",
	"is miniboss" 					: "Is miniboss",
	"replace weapon fire sound" 	: "Weapon fire sound replaced with %s",
	"is invisible" 					: "Weapon is invisible",
	"cannot upgrade" 				: "Weapon cannot be upgraded",
	"always crit" 					: "Weapon always crits",
	"add cond when active" 			: "On deploy: player receives cond %d for %.2f seconds",
	"dont count damage towards crit rate" : "Damage doesn't count towards crit rate",
	"no damage falloff" 			: "Weapon has no damage fall-off or ramp-up",
	"can headshot" 					: "Crits on headshot",
	"cannot headshot" 				: "weapon cannot headshot",
	"cannot be headshot" 			: "Immune to headshots",
	"projectile lifetime" 			: "projectile disappears after %.2f seconds",
	"mult dmg vs tanks" 			: "Damage vs tanks multiplied by %.2f",
	"mult dmg vs giants" 			: "Damage vs giants multiplied by %.2f",
	"set damage type" 				: "Sets damage type to %s",
	"set damage type custom" 		: "Sets damage type to custom",
	"passive reload" 				: "Passive reload",
	"collect currency on kill" 		: "On kill: collect currency",
	"rocket penetration" 			: "Rocket penetrates up to %d enemy players",
	"reloads full clip at once" 	: "Reloads full clip at once",
	"mult projectile scale" 		: "Projectile scale multiplied by %.2f",
	"mult building scale" 			: "Building scale multiplied by %.2f",
	"mult crit dmg" 				: "Crit damage multiplied by %.2f",
	"arrow ignite" 					: "Arrows are always ignited",
	"noclip projectile" 			: "Projectiles go through walls and enemies harmlessly",
	"projectile gravity" 			: "Projectile gravity %d hu/s",
	"immune to cond" 				: "Immune to cond %d",
	"mult max health" 				: "Player max health is multiplied by %.2f",
	"custom kill icon" 				: "Custom kill icon: %s",
	"set warpaint seed" 			: "Sets warpaint seed to %d",
	"min respawn time"				: "Min respawn time: %.2f seconds",
	"effect cond override" 			: "Effect cond override: %d",
	"mult player model scale" 		: "Player model scale multiplied by %.2f",
	"alt-fire disabled" 			: "Secondary fire disabled",
	"custom projectile model" 		: "Fires custom projectile model: %s",
	"dmg bonus while half dead" 	: "%d⁒ damage bonus while half dead",
	"dmg penalty while half alive"  : "%d⁒ damage penalty while half alive"
}

PopExtAttributes.Attrs <- {

	function FiresMilkBolt( player, item, value ) {

		local scope = item.GetScriptScope()
		local player_scope = player.GetScriptScope()

		// mad milk default params
		local duration = 10.0, recharge = 20.0

		if ( "duration" in value ) duration = value.duration
		if ( "recharge" in value ) recharge = value.recharge

		scope.milk_bolt_last_fire_time <- 0.0
		scope.milk_bolt_request <- false

		local event_hook_string = format( "FiresMilkBolt_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function FiresMilkBoltThink() {

			if ( item == null || player.GetActiveWeapon() != item )
				return

			if ( PopExtUtil.InButton( player, IN_ATTACK2 ) && Time() - scope.milk_bolt_last_fire_time > recharge ) {

				// these 3 following lines must be in this order, otherwise it will break
				scope.milk_bolt_request = true
				item.PrimaryAttack()
				scope.milk_bolt_last_fire_time = Time()
			}
			if ( PopExtUtil.InButton( player, IN_ATTACK2 ) && Time() - scope.milk_bolt_last_fire_time < recharge ) {

				ClientPrint( player, HUD_PRINTCENTER, format( "Milk bolt is recharging! It will be available in %.1f seconds.", scope.milk_bolt_last_fire_time - Time() + recharge ) )
			}
			if ( PopExtUtil.InButton( player, IN_ATTACK ) || PopExtUtil.InButton( player, IN_ATTACK3 ) || player.GetActiveWeapon() != item ) {

				scope.milk_bolt_request = false
			}
		}
		player_scope.PlayerThinkTable[ event_hook_string ] <- FiresMilkBoltThink
		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			local attacker = params.attacker

			if ( !attacker || !victim.IsPlayer() ) return

			local item = PopExtUtil.HasItemInLoadout( player, params.weapon )

			local scope = item ? scope = item.GetScriptScope() : false

			if ( !scope || !victim || !attacker || attacker != player || !( "milk_bolt_request" in scope ) || !scope.milk_bolt_request || Time() - scope.milk_bolt_last_fire_time < recharge )
				return

			victim.AddCondEx( TF_COND_MAD_MILK, duration, attacker )
			scope.milk_bolt_request = false
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function AddCondOnHit( player, item, value ) {

		local event_hook_string = format( "AddCondOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			local attacker = params.attacker

			if (
				victim == null
				|| !victim.IsPlayer()
				|| victim.IsInvulnerable()
				|| ( typeof value == "array" && victim.InCond( value[ 0 ] ) )
				|| ( typeof value == "integer" && victim.InCond( value ) )
				|| attacker == null
				|| attacker != player
				|| params.weapon != item
			) return

			typeof value == "array" ? victim.AddCondEx( value[ 0 ], value[ 1 ], attacker ) : victim.AddCond( value )
		}, EVENT_WRAPPER_CUSTOMATTR )

		local desc_string = typeof value == "array" ?
		format( "applies cond %d to victim on hit for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
		format( "applies cond %d to victim on hit", value )
	}

	function RemoveCondOnHit( player, item, value ) {

		local event_hook_string = format( "RemoveCondOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_hurt", event_hook_string, function( params ) {

			local victim = GetPlayerFromUserID( params.userid )
			local attacker = GetPlayerFromUserID( params.attacker )

			if ( victim == null || attacker == null || !victim.IsPlayer() || !victim.InCond( value ) || victim.IsInvulnerable() || attacker != player || params.weapon != item )
				return

			victim.RemoveCondEx( value, true )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function SelfAddCondOnHit( player, item, value ) {

		local event_hook_string = format( "SelfAddCondOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			local attacker = params.attacker

			if ( attacker == null || !attacker.IsPlayer() || victim.IsInvulnerable() || ( typeof value == "array" && attacker.InCond( value[ 0 ] ) ) || ( typeof value == "integer" && attacker.InCond( value ) ) )
				return

			typeof value == "array" ? attacker.AddCondEx( value[ 0 ], value[ 1 ], attacker ) : attacker.AddCond( value )
		}, EVENT_WRAPPER_CUSTOMATTR )

		local desc_string = typeof value == "array" ?
		format( "applies cond %d to self on hit for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
		format( "applies cond %d to self on hit", value )
	}

	function SelfAddCondOnKill( player, item, value ) {

		local event_hook_string = format( "SelfAddCondOnKill_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_death", event_hook_string, function( params ) {

			local attacker = GetPlayerFromUserID( params.attacker )
			local victim = GetPlayerFromUserID( params.userid )

			if ( victim == null || attacker == null || !attacker.IsPlayer() )
				return

			typeof value == "array" ? attacker.AddCondEx( value[ 0 ], value[ 1 ], attacker ) : attacker.AddCond( value )
		}, EVENT_WRAPPER_CUSTOMATTR )

		local desc_string = typeof value == "array" ?
		format( "applies cond %d to self on kill for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
		format( "applies cond %d to self on kill", value )
	}

	function FireInputOnHit( player, item, value ) {

		if ( typeof value != "string" && typeof value != "array" ) {

			PopExtMain.Error.RaiseTypeError( "FireInputOnHit", "string or array", false )
			return
		}

		local args = typeof value == "string" ? split( value, "^", true ) : value

		local targetname = args[ 0 ]
		local input 	 = args[ 1 ]
		local param 	 = 2 in args ? args[ 2 ] : ""
		local delay 	 = 3 in args ? args[ 3 ].tofloat() : -1
		local activator  = 4 in args ? args[ 4 ] : player
		local caller 	 = 5 in args ? args[ 5 ] : player

		if ( typeof activator == "string" )
			activator = FindByName( null, activator )
		if ( typeof caller == "string" )
			caller = FindByName( null, caller )

		local event_hook_string = format( "FireInputOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.attacker != player || params.weapon != item )
				return

			targetname == "!self" ? EntFireByHandle( params.attacker, input, param, delay, activator, caller ) : DoEntFire( targetname, input, param, delay, activator, caller )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function FireInputOnKill( player, item, value ) {

		if ( typeof value != "string" && typeof value != "array" ) {

			PopExtMain.Error.RaiseTypeError( "FireInputOnKill", "string or array", false )
			return
		}

		local args = typeof value == "string" ? split( value, "^", true ) : value

		local targetname = args[ 0 ]
		local input 	 = args[ 1 ]
		local param 	 = 2 in args ? args[ 2 ] : ""
		local delay 	 = 3 in args ? args[ 3 ].tofloat() : -1
		local activator  = 4 in args ? args[ 4 ] : player
		local caller 	 = 5 in args ? args[ 5 ] : player

		if ( typeof activator == "string" )
			activator = FindByName( null, activator )
		if ( typeof caller == "string" )
			caller = FindByName( null, caller )

		local event_hook_string = format( "FireInputOnKill_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_death", event_hook_string, function( params ) {

			if ( GetPlayerFromUserID( params.attacker ) != player || params.weapon != item )
				return

			targetname = "!self" ? EntFireByHandle( GetPlayerFromUserID( params.attacker ), input, param, delay, activator, caller ) : DoEntFire( targetname, input, param, delay, activator, caller )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function MultDmgVsSameClass( player, item, value ) {

		local event_hook_string = format( "MultDmgVsSameClass_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			local attacker = params.attacker

			if ( !attacker || !attacker.IsValid() )
				return

			else if ( !PopExtAttributes.HasAttr( attacker, "mult dmg vs same class" ) )
				return

			else if ( !attacker.IsPlayer() || !victim.IsPlayer() ) 
				return

			else if ( attacker.GetPlayerClass() != victim.GetPlayerClass() || params.weapon != item)
				return

			params.damage *= value

		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function MultDmgVsAirborne( player, item, value ) {

		local event_hook_string = format( "MultDmgVsAirborne_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			if ( victim != null && victim.IsPlayer() && GetPropEntity( victim, "m_hGroundEntity" ) == null )
			params.damage *= value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function TeleportInsteadOfDie( player, item, value ) {

		local event_hook_string = format( "TeleportInsteadOfDie_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( RandomFloat( 0, 1 ) > value.tofloat() )
				return

			local player = params.const_entity

			if ( !PopExtAttributes.HasAttr( player, "teleport instead of die" ) )
				return

			else if ( !player.IsPlayer() || player.GetHealth() > params.damage )
				return

			else if ( player.IsInvulnerable() || PopExtUtil.IsPointInTrigger( player.EyePosition() ) )
				return

			params.early_out = true
			player.ForceRespawn()
			PopExtUtil.ScriptEntFireSafe( player, "self.SetHealth( 1 )", -1 )

		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function MeleeCleaveAttack( player, item, value = 64 ) {

		local scope = item.GetScriptScope()

		scope.cleavenextattack <- 0.0
		scope.cleaved <- false

		local event_hook_string = format( "MeleeCleaveAttack_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function MeleeCleaveAttackThink() {

			if ( player.GetActiveWeapon() != item || !PopExtAttributes.HasAttr( player, "melee cleave attack" ) )
				return

			if ( scope.cleavenextattack == GetPropFloat( item, "m_flNextPrimaryAttack" ) || GetPropFloat( item, "m_fFireDuration" ) == 0.0 ) 
				return

			scope.cleaved = false

			scope.cleavenextattack = GetPropFloat( item, "m_flNextPrimaryAttack" )
		}
		scope.ItemThinkTable[ event_hook_string ] <- MeleeCleaveAttackThink

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( scope.cleaved || params.weapon != item || !PopExtAttributes.HasAttr( player, "melee cleave attack" ) )
				return

			scope.cleaved = true
			// params.early_out = true

			local swingpos = player.EyePosition() + ( player.EyeAngles().Forward() * 30 ) - Vector( 0, 0, value )

			for ( local p; p = FindByClassnameWithin( p, "player", swingpos, value ); )
				if ( p.GetTeam() != player.GetTeam() && p.GetTeam() != TEAM_SPECTATOR && p != params.const_entity )
					p.TakeDamageCustom( params.inflictor, params.attacker, params.weapon, params.damage_force, params.damage_position, params.damage, params.damage_type, params.damage_custom )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	// unfinished attribute
	function TeleporterRechargeTime( player, item, value = 1.0 ) {

		PopExtMain.Error.GenericWarning( "custom attribute TeleporterRechargeTime is not finished!" )

		local scope = item.GetScriptScope()
		scope.teleporterrechargetimemult <- value

		local event_hook_string = format( "TeleporterRechargeTime_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		// CustomAttributes.PlayerTeleportTable[format( "TeleporterRechargeTime_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )] <- function( params )
		// {
		//     local teleportedplayer = GetPlayerFromUserID( params.userid )

		//     local teleporter = FindByClassnameNearest( "obj_teleporter", teleportedplayer.GetOrigin(), 16 )

		//     local chargetime = GetPropFloat( teleporter, "m_flCurrentRechargeDuration" )
		// }

		function TeleporterRechargeTimeThink() {

			local mult = scope.teleporterrechargetimemult
			local teleporter = FindByClassnameNearest( "obj_teleporter", player.GetOrigin(), 16 )

			if ( teleporter == null || teleporter.GetScriptThinkFunc() != "" )
				return

			local chargetime = GetPropFloat( teleporter, "m_flCurrentRechargeDuration" )

			local teleportscope = PopExtUtil.GetEntScope( teleporter )
			if ( !( "rechargetimestamp" in teleportscope ) )
				teleportscope.rechargetimestamp <- 0.0
			if ( !( "rechargeset" in teleportscope ) )
				teleportscope.rechargeset <- false

			function TeleportMultThink() {

				if ( !teleportscope.rechargeset ) {

					SetPropFloat( teleporter, "m_flCurrentRechargeDuration", chargetime * mult )
					SetPropFloat( teleporter, "m_flRechargeTime", Time() * mult )

					teleportscope.rechargeset = true
					teleportscope.rechargetimestamp = GetPropFloat( teleporter, "m_flRechargeTime" ) * mult
				}
				if ( GetPropInt( teleporter, "m_iState" ) == 6 && GetPropFloat( teleporter, "m_flRechargeTime" ) >= teleportscope.rechargetimestamp ) {

					teleportscope.rechargeset = false
				}

				printl( GetPropFloat( teleporter, "m_flRechargeTime" ) + " : " + teleportscope.rechargetimestamp )
				return
			}
			PopExtUtil.AddThink( teleporter, TeleportMultThink )
		}
		scope.ItemThinkTable[ event_hook_string ] <- TeleporterRechargeTimeThink
	}

	function UberOnDamageTaken( player, item, value ) {

		local event_hook_string = format( "UberOnDamageTaken_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local damagedplayer = params.const_entity

			if (
				damagedplayer != player || RandomInt( 0, 1 ) > value ||
				!PopExtAttributes.HasAttr( player, "uber on damage taken" ) ||
				damagedplayer.IsInvulnerable() || player.GetActiveWeapon() != item
			) return

			damagedplayer.AddCondEx( COND_UBERCHARGE, 3.0, player )
			params.early_out = true
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function SetTurnToIce( player, item, value = null ) {

		// cleanup before spawning a new one
		for ( local knife; knife = FindByClassname( knife, "tf_weapon_knife" ); )
			if ( PopExtUtil.GetItemIndex( knife ) == ID_SPY_CICLE && knife.IsEFlagSet( EFL_USER ) )
				EntFireByHandle( knife, "Kill", "", -1, null, null )

		local freeze_proxy_weapon = CreateByClassname( "tf_weapon_knife" )
		SetPropInt( freeze_proxy_weapon, STRING_NETPROP_ITEMDEF, ID_SPY_CICLE )
		SetPropBool( freeze_proxy_weapon, STRING_NETPROP_INIT, true )
		freeze_proxy_weapon.AddEFlags( EFL_USER )
		PopExtUtil._SetOwner( freeze_proxy_weapon, player )
		DispatchSpawn( freeze_proxy_weapon )
		freeze_proxy_weapon.DisableDraw()

		// Add the attribute that creates ice statues
		freeze_proxy_weapon.AddAttribute( "freeze backstab victim", 1.0, -1.0 )

		local event_hook_string = format( "SetTurnToIce_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local attacker = params.attacker

			local victim = params.const_entity
			if ( victim.IsPlayer() && attacker == player && params.damage >= victim.GetHealth() && player.GetActiveWeapon() == item ) {

				victim.TakeDamageCustom( attacker, victim, freeze_proxy_weapon, Vector(), Vector(), params.damage, params.damage_type, params.damage_custom | TF_DMG_CUSTOM_BACKSTAB )

				// I don't remember why this is needed but it's important
				local ragdoll = GetPropEntity( victim, "m_hRagdoll" )
				if ( ragdoll )
					SetPropInt( ragdoll, "m_iDamageCustom", 0 )
				params.early_out = true
			}
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function ModTeleporterSpeedBoost( player, item, value ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "AddCondOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_teleported", event_hook_string, function( params ) {

			if ( !PopExtAttributes.HasAttr( player, "mod teleporter speed boost" ) || params.builderid != PopExtUtil.PlayerTable[ player ] )
				return

			local teleportedplayer = GetPlayerFromUserID( params.userid )
			teleportedplayer.AddCondEx( TF_COND_SPEED_BOOST, value, player )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function CanBreatheUnderWater( player, item, value = null ) {

		local painfinished = GetPropInt( player, "m_PainFinished" )

		local scope = item.GetScriptScope()
		local event_hook_string = format( "CanBreatheUnderwater_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )
		function CanBreatheUnderWaterThink() {

			if ( !PopExtAttributes.HasAttr( player, "can breathe under water" ) || player.GetActiveWeapon() != item )
				return

			if ( player.GetWaterLevel() == 3 ) {

				SetPropFloat( player, "m_PainFinished", FLT_MAX )
				return
			}
			SetPropFloat( player, "m_PainFinished", 0.0 )
		}
		scope.ItemThinkTable[ event_hook_string ] <- CanBreatheUnderWaterThink
	}

	function MultSwimSpeed( player, item, value = 1.25 ) {

		// local speedmult = 1.254901961
		local maxspeed = GetPropFloat( player, "m_flMaxspeed" )

		local scope = item.GetScriptScope()
		local event_hook_string = format( "MultSwimSpeed_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )
		function MultSwimSpeedThink() {

			if ( !PopExtAttributes.HasAttr( player, "mult swim speed" ) || player.GetActiveWeapon() != item )
				return

			if ( player.GetWaterLevel() == 3 ) {

				SetPropFloat( player, "m_flMaxspeed", maxspeed * value )
				return
			}
			SetPropFloat( player, "m_flMaxspeed", maxspeed )
		}
		scope.ItemThinkTable[ event_hook_string ] <- MultSwimSpeedThink
	}

	function LastShotCrits( player, item, value ) {

		local duration = ( "duration" in value ) ? value.duration : 0.033

		local scope = item.GetScriptScope()
		// scope.lastshotcritsnextattack <- 0.0

		local event_hook_string = format( "LastShotCrits_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )
		function LastShotCritsThink() {

			if ( !item || !PopExtAttributes.HasAttr( player, "last shot crits" ) || player.GetActiveWeapon() != item )
				return

			// if ( scope.lastshotcritsnextattack == GetPropFloat( item, "m_flNextPrimaryAttack" ) ) return

			// scope.lastshotcritsnextattack = GetPropFloat( item, "m_flNextPrimaryAttack" )

			if ( item.IsValid() && item.Clip1() == 1 )
				player.AddCondEx( COND_CRITBOOST, duration, null )
		}
		scope.ItemThinkTable[ event_hook_string ] <- LastShotCritsThink
	}

	function CritWhenHealthBelow( player, item, value = -1 ) {

		local event_hook_string = format( "CritWhenHealthBelow_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )
		function CritWhenHealthBelowThink() {

			if ( player.GetHealth() < value && player.GetActiveWeapon() == item ) {

				player.AddCondEx( COND_CRITBOOST, 0.033, player )
				return
			}
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- CritWhenHealthBelowThink
	}

	function WetImmunity( player, item, value = null ) {

		local wetconds = [ TF_COND_MAD_MILK, TF_COND_URINE, TF_COND_GAS ]

		local event_hook_string = format( "WetImmunity_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function WetImmunityThink() {

			if ( player.GetActiveWeapon() != item )
				return

			foreach ( cond in wetconds )
				player.RemoveCondEx( cond, true )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- WetImmunityThink
	}

	function BuildSmallSentries( player, item, value = null ) {

		local scope = player.GetScriptScope()
		scope.previousBuiltSentry <- null

		local event_hook_string = format( "BuildSmallSentries_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_builtobject", event_hook_string, function( params ) {

			local builder = GetPlayerFromUserID( params.userid )

			if ( builder != player || params.object != OBJ_SENTRYGUN )
				return

			local sentry = EntIndexToHScript( params.index )

			if ( sentry == scope.previousBuiltSentry ) {

				SetPropInt( sentry, "m_iUpgradeMetalRequired", 150 )
				return
			}

			scope.previousBuiltSentry = sentry
			PopExtUtil.ScriptEntFireSafe( sentry, @"
				local maxhealth = self.GetMaxHealth() * 0.66
				self.SetMaxHealth( maxhealth )
				if ( self.GetHealth() > self.GetMaxHealth() )
				self.SetHealth( maxhealth )

				self.SetModelScale( 0.8, -1 )

				SetPropInt( self, `m_iUpgradeMetalRequired`, 150 )
			", SINGLE_TICK )
		}, EVENT_WRAPPER_CUSTOMATTR )

		POP_EVENT_HOOK( "player_upgradedobject", event_hook_string, function( params ) {

			local upgrader = GetPlayerFromUserID( params.userid )

			if ( upgrader != player || params.object != OBJ_SENTRYGUN )
				return

			local sentry = EntIndexToHScript( params.index )

			PopExtUtil.ScriptEntFireSafe( sentry, @"
				local maxhealth = self.GetMaxHealth() * 0.66
				self.SetMaxHealth( maxhealth )
				if ( self.GetHealth() > self.GetMaxHealth() )
					self.SetHealth( maxhealth )

				SetPropInt( self, `m_iUpgradeMetalRequired`, 150 )
			", SINGLE_TICK )
		}, EVENT_WRAPPER_CUSTOMATTR )

		POP_EVENT_HOOK( "mvm_quick_sentry_upgrade", event_hook_string, function( params ) {

			for ( local sentry; sentry = FindByClassname( sentry, "obj_sentrygun" ); ) {

				if ( GetPropEntity( sentry, "m_hBuilder" ) == player ) {

					PopExtUtil.ScriptEntFireSafe( sentry, @"
						local maxhealth = self.GetMaxHealth() * 0.66
						self.SetMaxHealth( maxhealth )
						if ( self.GetHealth() > self.GetMaxHealth() )
							self.SetHealth( maxhealth )
					", SINGLE_TICK )
				}
			}
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function RadiusSleeper( player, item, value = null ) {

		local event_hook_string = format( "RadiusSleeper_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "player_hurt", event_hook_string, function( params ) {

			local victim = GetPlayerFromUserID( params.userid )
			local attacker = GetPlayerFromUserID( params.attacker )

			if ( !attacker || attacker != player || !PopExtAttributes.HasAttr( player, "radius sleeper" ) )
				return
				
			else if ( GetPropFloat( attacker.GetActiveWeapon(), "m_flChargedDamage" ) < 150.0 )
				return

			SpawnEntityFromTable( "tf_projectile_jar", { origin = victim.EyePosition() } )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	// OBSOLETE, use ExplosiveBulletsExt instead
	function ExplosiveBullets( player, item, value ) {

		local scope = item.GetScriptScope()
		// cleanup before spawning a new one
		for ( local launcher; launcher = FindByClassname( launcher, "tf_weapon_grenadelauncher" ); )
			if ( launcher.IsEFlagSet( EFL_USER ) )
				EntFireByHandle( launcher, "Kill", "", -1, null, null )

		local launcher = CreateByClassname( "tf_weapon_grenadelauncher" )
		SetPropInt( launcher, STRING_NETPROP_ITEMDEF, ID_GRENADELAUNCHER )
		SetPropBool( launcher, STRING_NETPROP_INIT, true )
		launcher.AddEFlags( EFL_USER )
		PopExtUtil._SetOwner( launcher, player )
		DispatchSpawn( launcher )
		launcher.DisableDraw()

		launcher.AddAttribute( "fuse bonus", 0.0, -1 )
		// launcher.AddAttribute( "dmg penalty vs players", 0.0, -1 )

		scope.explosivebulletsnextattack <- 0.0
		scope.curammo <- GetPropIntArray( player, STRING_NETPROP_AMMO, item.GetSlot() + 1 )
		if ( item.Clip1() != -1 )
			scope.curclip <- item.Clip1()

		local event_hook_string = format( "ExplosiveBullets_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function ExplosiveBulletsThink() {

			if ( !PopExtAttributes.HasAttr( player, "explosive bullets" ) || player.GetActiveWeapon() != item || scope.explosivebulletsnextattack == GetPropFloat( item, "m_flLastFireTime" ) )
				return

			local grenade = CreateByClassname( "tf_projectile_pipe" )
			grenade.SetOwner( launcher )
			SetPropEntity( grenade, "m_hLauncher", launcher )
			SetPropEntity( grenade, "m_hThrower", player )
			SetPropFloat( grenade, "m_flDamage", value * 2 ) // shithack: multiply damage by 2 to account for distance falloff
			grenade.SetCollisionGroup( COLLISION_GROUP_DEBRIS )

			DispatchSpawn( grenade )
			grenade.DisableDraw()

			local trace = {

				start = player.EyePosition(),
				end = player.EyePosition() + ( player.EyeAngles().Forward() * 8192.0 ),
				ignore = player
			}
			TraceLineEx( trace )
			if ( trace.hit && "enthit" in trace ) {

				if ( trace.enthit.GetClassname() == "worldspawn" )
					grenade.SetAbsOrigin( trace.endpos )
				else
					grenade.SetAbsOrigin( trace.enthit.EyePosition() + Vector( 0, 0, 45 ) )
			}

			scope.explosivebulletsnextattack = GetPropFloat( item, "m_flLastFireTime" )
			scope.curammo = GetPropIntArray( player, STRING_NETPROP_AMMO, item.GetSlot() + 1 )
			if ( "curclip" in scope )
				scope.curclip = item.Clip1()
		}
		scope.ItemThinkTable[ event_hook_string ] <- ExplosiveBulletsThink
	}

	function ExplosiveBulletsExt( player, item, value ) {

		SetPropInt( PopExtUtil.Worldspawn, "m_takedamage", 1 )

		local generic_bomb = "tf_generic_bomb"

		local damage = "damage" in value ? value.damage : 150
		local radius = "radius" in value ? value.radius : 150
		local team = "team" in value ? value.team : player.GetTeam()
		local model = "model" in value ? value.model : ""
		local particle = "particle" in value ? value.particle : "mvm_loot_explosion"
		local sound = "sound" in value ? value.sound : "weapons/pipe_bomb1.wav"
		local killicon = "killicon" in value ? value.killicon : "megaton"

		PrecacheSound( sound )

		local scope = player.GetScriptScope()

		local event_hook_string = format( "ExplosiveBulletsExt_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( "explosivebullets" in scope || params.weapon != item || !PopExtAttributes.HasAttr( player, "explosive bullets ext" ) )
				return

			scope.explosivebullets <- true

			local particleent = SpawnEntityFromTable( "info_particle_system", { effect_name = particle } )

			if ( params.const_entity.GetClassname() == generic_bomb || params.attacker.GetClassname() == generic_bomb )
				return

			else if ( params.attacker == player && params.const_entity.GetClassname() == generic_bomb )
				return

			local bomb = CreateByClassname( generic_bomb )

			SetPropFloat( bomb, "m_flDamage", damage )
			SetPropFloat( bomb, "m_flRadius", radius )
			SetPropString( bomb, "m_explodeParticleName", particle ) // doesn't work
			SetPropString( bomb, "m_strExplodeSoundName", sound )

			DispatchSpawn( bomb )
			PopExtUtil._SetOwner( bomb, params.attacker )

			bomb.SetTeam( team )
			bomb.SetAbsOrigin( params.damage_position )
			bomb.SetHealth( 1 )
			if ( model != "" )
				bomb.SetModel( model )

			particleent.SetAbsOrigin( bomb.GetOrigin() )
			SetPropString( bomb, STRING_NETPROP_CLASSNAME, killicon )
			bomb.TakeDamage( 1, DMG_CLUB, player )
			EntFireByHandle( particleent, "Start", "", -1, null, null )
			EntFireByHandle( particleent, "Stop", "", SINGLE_TICK, null, null )
			EntFireByHandle( particleent, "Kill", "", SINGLE_TICK * 2, null, null )

			if ( "explosivebullets" in scope )
				delete scope.explosivebullets
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function OldSandmanStun( player, item, value = null ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "OldSandmanStun_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local attacker = params.attacker
			local victim = params.const_entity
			if ( params.damage_stats == TF_DMG_CUSTOM_BASEBALL && params.weapon == item && ( !victim.IsMiniBoss() || value == 2 ) )
				PopExtUtil.StunPlayer( victim, 5, TF_STUN_CONTROLS )

		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function StunOnHit( player, item, value ) {

		local scope = item.GetScriptScope()

		local duration   = "duration" in value ? value.duration : 5
		local type 		 = "type" in value ? value.type : 2
		local speedmult  = "speedmult" in value ? value.speedmult : 0.2
		local stungiants = "stungiants" in value ? value.stungiants : true

		// `stun on hit`: { duration = 4 type = 2 speedmult = 0.2 stungiants = false } //in order: stun duration in seconds, stun type, stun movespeed multiplier, can stun giants true/false

		local event_hook_string = format( "StunOnHit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( !params.const_entity.IsPlayer() || params.weapon != item || ( !stungiants && params.const_entity.IsMiniBoss() ) )
				return

			PopExtUtil.StunPlayer( params.const_entity, duration, type, 0, speedmult )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function IsMiniboss( player, item, value = null ) {

		local event_hook_string = format( "IsMiniboss_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function IsMinibossThink() {

			if ( player.GetActiveWeapon() == item || value == 2 ) {

				if ( !player.IsMiniBoss() ) {

					player.SetIsMiniBoss( true )
					player.SetModelScale( 1.75, -1 )
				}
				return
			}
			player.SetIsMiniBoss( false )
			player.SetModelScale( 1.0, -1 )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- IsMinibossThink
	}

	function ReplaceWeaponFireSound( player, item, value ) {

		if ( typeof value != "array" ) {

			PopExtMain.Error.RaiseValueError( "Replace weapon fire sound must be an array\nFirst Index: sound to replace\nSecond index: new sound name" )
		}

		if ( typeof value[ 1 ] == "array" ) {

			foreach ( v in value[ 1 ] ) {

				PrecacheSound( v )
				PrecacheScriptSound( v )
			}
		}
		else {

			PrecacheSound( value[ 1 ] )
			PrecacheScriptSound( value[ 1 ] )
		}

		local scope = PopExtUtil.GetEntScope( item )
		scope.attacksound <- 0.0

		local event_hook_string = format( "ReplaceWeaponFireSound_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		if ( PopExtUtil.IsProjectileWeapon( item ) ) {

			function ReplaceWeaponFireSoundThink() {

				if (
					player.GetActiveWeapon() != item
					|| !( "attacksound" in scope )
					|| GetPropFloat( item, "m_flLastFireTime" ) == scope.attacksound
				) return

				if ( typeof value[ 0 ] == "array" ) {

					foreach ( v in value[ 0 ] ) {

						StopSoundOn( v, player )
						player.StopSound( v )
					}
					// GetLastFiredProjectile must be called in an EntFire delay
					// projectiles are added to the ActiveProjectile array after weapon fire
					PopExtUtil.ScriptEntFireSafe( player, format( @"
						local scope = self.GetScriptScope()
						local projectile = PopExtUtil.GetLastFiredProjectile( self )

						local snd = projectile && GetPropBool( projectile, `m_bCritical` ) ? `%s` : `%s`
						EmitSoundEx( { sound_name = snd, entity = self } )
					", value[ 1 ][ 1 ], value[ 1 ][ 0 ] ) )
				}
				else {

					StopSoundOn( value[ 0 ], player )
					player.StopSound( value[ 0 ] )
					EmitSoundEx( { sound_name = value[ 1 ], entity = player } )
				}

				scope.attacksound = GetPropFloat( item, "m_flLastFireTime" )
			}
			scope.ItemThinkTable[ event_hook_string ] <- ReplaceWeaponFireSoundThink
			return
		}

		SetPropInt( PopExtUtil.Worldspawn, "m_takedamage", 1 )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local _weapon = params.weapon

			if ( !_weapon || _weapon != item )
				return

			if ( typeof value[ 0 ] == "array" ) {

				foreach ( v in value[ 0 ] ) {

					StopSoundOn( v, player )
					player.StopSound( v )
				}

				local snd = value[ 1 ][ params.damage_type & DMG_CRITICAL ? 1 : 0 ]
				EmitSoundEx( { sound_name = snd, entity = player } )
			}
			else {

				StopSoundOn( value[ 0 ], player )
				player.StopSound( value[ 0 ] )
				EmitSoundEx( { sound_name = value[ 1 ], entity = player } )
			}
		}, EVENT_WRAPPER_CUSTOMATTR )

		local infostring = typeof value[ 1 ] == "array" ? format( "Weapon fire sound replaced with %s ( normal ) and %s ( critical )", value[ 1 ][ 0 ], value[ 1 ][ 1 ] ) : format( "Weapon fire sound replaced with %s", value[ 1 ] )
	}

	function IsInvisible( player, item, value = null ) {

		local event_hook_string = format( "IsInvisible%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function IsInvisibleThink() {

			if ( player.GetActiveWeapon() != item || PopExtUtil.HasEffect( EF_NODRAW ) )
				return

			item.DisableDraw()
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- IsInvisibleThink
	}

	function CannotUpgrade( player, item, value = null ) {

		local index = PopExtUtil.GetItemIndex( item )
		local classname = GetPropString( item, STRING_NETPROP_CLASSNAME )

		local event_hook_string = format( "CannotUpgrade_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function CannotUpgradeThink() {

			if ( PopExtUtil.InUpgradeZone( player ) ) {

				if ( GetPropInt( item, STRING_NETPROP_ITEMDEF ) != -1 && player.GetActiveWeapon() == item )
					ClientPrint( player, HUD_PRINTCENTER, "This weapon cannot be upgraded" )

				SetPropInt( item, STRING_NETPROP_ITEMDEF, -1 )
				SetPropString( item, STRING_NETPROP_CLASSNAME, "" )
				return
			}
			SetPropString( item, STRING_NETPROP_CLASSNAME, classname )
			SetPropInt( item, STRING_NETPROP_ITEMDEF, index )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- CannotUpgradeThink
	}

	function AlwaysCrit( player, item, value = null ) {

		local event_hook_string = format( "AlwaysCrit_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function AlwaysCritThink() {

			if ( player.GetActiveWeapon() == item )
				player.AddCondEx( COND_CRITBOOST, 0.033, player )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- AlwaysCritThink
	}

	function AddCondWhenActive( player, item, value ) {

		local duration = typeof value == "array" ? value[ 1 ].tofloat() : 0.033

		local event_hook_string = format( "AddCondWhenActive_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function AddCondWhenActiveThink() {

			if ( player.GetActiveWeapon() == item )
				player.AddCondEx( value, duration, player )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- AddCondWhenActiveThink
		local desc_string = duration != 0.033 ?
		format( "On deploy: player receives cond %d for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
		format( "When active: player receives cond %d", value )
	}

	function DontCountDamageTowardsCritRate( player, item, value = null ) {

		local event_hook_string = format( "DontCountDamageTowardsCritRate_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon != item )
				return params.damage_type = params.damage_type | DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function NoDamageFalloff( player, item, value = null ) {

		local event_hook_string = format( "NoDamageFalloff_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon != item )
				return params.damage_type = params.damage_type & ~DMG_USEDISTANCEMOD
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function CanHeadshot( player, item, value = null ) {

		local event_hook_string = format( "CanHeadshot_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity
			if ( params.weapon != item || !victim.IsPlayer() || GetPropInt( victim, "m_LastHitGroup" ) != HITGROUP_HEAD )
				return

			params.damage_type = params.damage_type | DMG_CRITICAL
			params.damage_stats = TF_DMG_CUSTOM_HEADSHOT
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function CannotHeadshot( player, item, value = null ) {

		local event_hook_string = format( "CannotHeadshot_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon != item || params.damage_stats != TF_DMG_CUSTOM_HEADSHOT )
				return

			params.damage_type = params.damage_type & ~DMG_CRITICAL
			params.damage_stats = TF_DMG_CUSTOM_NONE
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function CannotBeHeadshot( player, item, value = null ) {

		local event_hook_string = format( "CannotBeHeadshot_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( !params.const_entity.IsPlayer() || !PopExtAttributes.HasAttr( player, "cannot be headshot" ) )
				return

			params.damage_type = params.damage_type & ~DMG_CRITICAL
			params.damage_stats = TF_DMG_CUSTOM_NONE
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function ProjectileLifetime( player, item, value ) {

		local event_hook_string = format( "ProjectileLifetime_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function ProjectileLifetimeThink() {

			if ( player.GetActiveWeapon() != item )
				return

			// will spew "DoEntFire was passed an invalid entity instance" if projectile dies before this delay but this is harmless afaik
			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
				if ( projectile.GetOwner() == player || ( HasProp( projectile, "m_hThrower" ) && GetPropEntity( projectile, "m_hThrower" ) == player && GetPropEntity( projectile, "m_hLauncher" ) == item ) )
					EntFireByHandle( projectile, "Kill", "", value, null, null )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- ProjectileLifetimeThink
	}

	function MultDmgVsGiants( player, item, value ) {

		local event_hook_string = format( "MultDmgVsGiants_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity, attacker = params.attacker

			if ( victim.IsPlayer() && victim.IsMiniBoss() && params.weapon == item )
				params.damage *= value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function MultDmgVsTanks( player, item, value ) {

		local event_hook_string = format( "MultDmgVsTanks_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local victim = params.const_entity, attacker = params.attacker

			if ( victim.GetClassname() == "tank_boss" && params.weapon == item )
				params.damage *= value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function SetDamageType( player, item, value ) {

		local event_hook_string = format( "SetDamageType_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon == item )
				params.damage_type = value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function SetDamageTypeCustom( player, item, value ) {

		local event_hook_string = format( "SetDamageTypeCustom_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon == item )
				params.damage_stats = value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function PassiveReload( player, item, value = null ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "PassiveReload_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function PassiveReloadThink() {

			// weapon ent has been destroyed, reference is still valid but the entity isn't
			if ( item && !item.IsValid() ) {

				PopExtUtil.RemoveThink( item, event_hook_string )
				return
			}

			if ( player.GetActiveWeapon() == item )
				return

			local ammo = GetPropIntArray( player, STRING_NETPROP_AMMO, item.GetSlot() + 1 )

			if ( player.GetActiveWeapon() != item && item.Clip1() != item.GetMaxClip1() ) {

				if ( !( "ReverseMVMDrainAmmoThink" in scope.ItemThinkTable ) ) // already takes care of this
					SetPropIntArray( player, STRING_NETPROP_AMMO, ammo - ( item.GetMaxClip1() - item.Clip1() ), item.GetSlot() + 1 )

				item.SetClip1( item.GetMaxClip1() )
			}
		}
		scope.ItemThinkTable[ event_hook_string ] <- PassiveReloadThink
	}

	function CollectCurrencyOnKill( player, item, value ) {

		local scope = PopExtUtil.GetEntScope( item )
		scope.collectCurrencyOnKill <- true

	}

	function RocketPenetration( player, item, value ) {

		local event_hook_string = format( "RocketPenetration_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		if ( PopExtUtil.ROCKET_LAUNCHER_CLASSNAMES.find( item.GetClassname() ) == null )
			return

		local scope = item.GetScriptScope()

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			local entity = params.const_entity
			if ( !entity.IsPlayer() )
				return

			local inflictor = params.inflictor

			local inflictor_scope = PopExtUtil.GetEntScope( inflictor )

			if ( !( "is_penetrate_mimic_rocket" in inflictor_scope ) )
				return

			params.player_penetration_count = inflictor_scope.penetration_count // change killicon to penetratt least 1 enemy
		}, EVENT_WRAPPER_CUSTOMATTR )

		local weapon_scope = PopExtUtil.GetEntScope( item )
		weapon_scope.last_fire_time <- 0.0
		weapon_scope.force_attacking <- false

		weapon_scope.max_penetration <- value

		function CheckWeaponFire() {

			local fire_time = GetPropFloat( self, "m_flLastFireTime" )
			if ( fire_time > last_fire_time && !force_attacking ) {

				local owner = self.GetOwner()
				if ( owner ) {

					OnShot( owner )
				}

				last_fire_time = fire_time
			}
			return
		}
		weapon_scope.CheckWeaponFire <- CheckWeaponFire

		function FindRocket( owner ) {

			local entity = null
			for ( local entity; entity = FindByClassnameWithin( entity, "tf_projectile_*", owner.GetOrigin(), 100 ); ) {

				if ( entity.GetOwner() != owner )
					continue

				local entity_scope = PopExtUtil.GetEntScope( entity )
				if ( "chosenAsPenetrationRocket" in entity_scope )
					continue

				entity_scope.chosenAsPenetrationRocket <- true

				return entity
			}

			return null
		}
		weapon_scope.FindRocket <- FindRocket

		function ApplyPenetrationToRocket( owner, rocket ) {

			rocket.SetSolid( SOLID_NONE )

			local rocket_scope = PopExtUtil.GetEntScope( rocket )
			rocket_scope.is_custom_rocket <- true
			rocket_scope.last_rocket_origin <- rocket.GetOrigin()
			rocket_scope.max_penetration <- max_penetration

			rocket_scope.collided_targets <- []
			rocket_scope.penetration_count <- 0

			function DetonateRocket() {

				local owner = self.GetOwner()
				local launcher = GetPropEntity( self, "m_hLauncher" )

				local charge = GetPropFloat( owner, "m_Shared.m_flItemChargeMeter" )
				local next_attack = GetPropFloat( launcher, "m_flNextPrimaryAttack" )
				local last_fire = GetPropFloat( launcher, "m_flLastFireTime" )
				local clip = launcher.Clip1()
				local energy = GetPropFloat( launcher, "m_flEnergy" )

				launcher.GetScriptScope().force_attacking = true

				launcher.SetClip1( 99 )
				SetPropFloat( owner, "m_Shared.m_flItemChargeMeter", 100.0 )
				SetPropBool( owner, "m_bLagCompensation", false )
				SetPropFloat( launcher, "m_flNextPrimaryAttack", 0 )
				SetPropFloat( launcher, "m_flEnergy", 100.0 )

				launcher.AddAttribute( "crit mod disabled hidden", 1, -1 )
				launcher.PrimaryAttack()
				launcher.RemoveAttribute( "crit mod disabled hidden" )

				launcher.GetScriptScope().force_attacking = false
				launcher.SetClip1( clip )
				SetPropBool( owner, "m_bLagCompensation", true )
				SetPropFloat( launcher, "m_flNextPrimaryAttack", next_attack )
				SetPropFloat( launcher, "m_flEnergy", energy )
				SetPropFloat( launcher, "m_flLastFireTime", last_fire )
				SetPropFloat( owner, "m_Shared.m_flItemChargeMeter", charge )

				for ( local entity; entity = FindByClassnameWithin( entity, "tf_projectile_*", owner.GetOrigin(), 100 ); ) {

					if ( entity.GetOwner() != owner ) {

						continue
					}

					local entity_scope = PopExtUtil.GetEntScope( entity )
					if ( "is_custom_rocket" in entity_scope )
						continue

					SetPropBool( self, "m_bCritical", GetPropBool( self, "m_bCritical" ) )
					entity.SetAbsOrigin( self.GetOrigin() )

					entity_scope.is_penetrate_mimic_rocket <- true
					entity_scope.original_rocket <- self
					entity_scope.penetration_count <- ( entity_scope.penetration_count - 1 )

					break
				}
			}

			function RocketThink() {

				local origin = self.GetOrigin()

				trace_worldspawn <- {

					start = last_rocket_origin
					end = origin + ( self.GetForwardVector() * 50 )
					mask = MASK_SOLID_BRUSHONLY
					ignore = self.GetOwner()
				}

				TraceLineEx( trace_worldspawn )

				if ( trace_worldspawn.hit && trace_worldspawn.enthit ) {

					self.SetSolid( SOLID_BBOX )
					delete rocket_scope.ProjectileThinkTable.RocketThink
				}

				trace_table <- {

					start = last_rocket_origin
					end = origin
					ignore = self.GetOwner()
				}

				TraceLineEx( trace_table )

				last_rocket_origin = origin

				if ( !trace_table.hit )
					return

				if ( !trace_table.enthit )
					return

				if ( trace_table.enthit.GetTeam() == player.GetTeam() )
					return

				if ( collided_targets.find( trace_table.enthit ) != null )
					return

				collided_targets.append( trace_table.enthit )
				penetration_count++

				// arrow free penetration through allies without detonating
				if ( trace_table.enthit.GetTeam() != player.GetTeam() )
					penetration_count++

				if ( penetration_count > ( max_penetration + 1 ) ) {

					self.SetSolid( SOLID_BBOX )
					if ( "RocketThink" in rocket_scope.ProjectileThinkTable )
						delete rocket_scope.ProjectileThinkTable.RocketThink

					return
				}

				if ( trace_table.enthit.GetTeam() != player.GetTeam() )
					DetonateRocket()

				return
			}

			PopExtUtil.AddThink( rocket, RocketThink)
			rocket_scope.DetonateRocket <- DetonateRocket
		}

		function OnShot( owner ) {

			local rocket = FindRocket( owner )

			if ( !rocket ) {

				return
			}

			// don't apply penetration to cowmangler charge shot, because unfortunately it doesn't work :(
			if ( GetPropBool( rocket, "m_bChargedShot" ) )
				return

			ApplyPenetrationToRocket( owner, rocket )
		}
		weapon_scope.OnShot <- OnShot
		weapon_scope.ApplyPenetrationToRocket <- ApplyPenetrationToRocket

	}

	function ReloadsFullClipAtOnce( player, item, value = null ) {

		local scope = item.GetScriptScope()
		scope.last_clip <- item.Clip1() // thanks to seelpit for detectreload logic

		local event_hook_string = format( "ReloadsFullClipAtOnce_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function ReloadsFullClipAtOnceThink() {

			local current_clip = item.Clip1()
			local wep_slot = item.GetSlot() + 1
			local last_clip = scope.last_clip

			if ( current_clip > last_clip ) {

				item.SetClip1( item.GetMaxClip1() )
				local ammo_deducted = ( item.GetMaxClip1() - current_clip )
				local current_ammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep_slot )
				SetPropIntArray( player, STRING_NETPROP_AMMO, current_ammo - ammo_deducted, wep_slot )
				current_clip = item.Clip1()
			}
			scope.last_clip = current_clip
		}
		scope.ItemThinkTable[ event_hook_string ] <- ReloadsFullClipAtOnceThink
	}

	function MultProjectileScale( player, item, value ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "MultProjectileScale_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function MultProjectileScaleThink() {

			if ( !PopExtAttributes.HasAttr( player, "mult projectile scale" ) || player.GetActiveWeapon() != item )
				return

			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
				if ( projectile.GetOwner() == player && projectile.GetModelScale() != value )
					projectile.SetModelScale( value, 0.0 )
		}
		scope.ItemThinkTable[ event_hook_string ] <- MultProjectileScaleThink
	}

	// this needs to be looked at
	function MultBuildingScale( player, item, value ) {

		local scope = item.GetScriptScope()

		POP_EVENT_HOOK( "player_builtobject", format( "MultBuildingScale_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() ), function( params ) {

			local building = EntIndexToHScript( params.index )
			if ( GetPropEntity( building, "m_hBuilder" ) == player && PopExtAttributes.HasAttr( player, "mult building scale" ) )
				building.SetModelScale( value, 0.0 )

		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function MultCritDmg( player, item, value ) {

		local event_hook_string = format( "MultCritDmg_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.damage_type & DMG_CRITICAL )
				params.damage *= value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function ArrowIgnite( player, item, value = null ) {

		local event_hook_string = format( "ArrowIgnite_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		local netprop_arrow_ignite = "m_bArrowAlight"

		function ArrowIgniteThink() {

			if ( player.GetActiveWeapon() != item )
				return

			if ( HasProp( item, "m_bArrowAlight" ) && !GetPropBool( item, "m_bArrowAlight" ) )
				SetPropBool( item, "m_bArrowAlight", true )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- ArrowIgniteThink
	}

	function NoclipProjectile( player, item, value ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "NoclipProjectile_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function NoclipProjectileThink() {

			if ( !PopExtAttributes.HasAttr( player, "noclip projectile" ) || player.GetActiveWeapon() != item )
				return

			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
				if ( projectile.GetOwner() == player && projectile.GetMoveType != MOVETYPE_NOCLIP )
					projectile.SetMoveType( MOVETYPE_NOCLIP, MOVECOLLIDE_DEFAULT )
		}
		scope.ItemThinkTable[ event_hook_string ] <- NoclipProjectileThink
	}

	function ProjectileGravity( player, item, value ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "ProjectileGravity_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function ProjectileGravityThink() {

			if ( !PopExtAttributes.HasAttr( player, "projectile gravity" ) || player.GetActiveWeapon() != item )
				return

			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); ) {

				if ( projectile.GetOwner() == player ) {

					local current_velocity = projectile.GetAbsVelocity()
					current_velocity -= Vector( 0, 0, value )

					projectile.SetAbsVelocity( current_velocity )

					local face_direction = projectile.GetForwardVector()
					self.SetLocalAngles( PopExtUtil.VectorAngles( face_direction ) )
				}
			}
		}
		scope.ItemThinkTable[ event_hook_string ] <- ProjectileGravityThink
	}

	function ImmuneToCond( player, item, value ) {

		local event_hook_string = format( "ImmuneToCond_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function ImmuneToCondThink() {

			if ( player.GetActiveWeapon() != item )
				return

			if ( typeof value == "array" ) {

				foreach ( cond in value ) {

					player.RemoveCondEx( cond, true )
				}
				return
			}
			player.RemoveCondEx( value, true )
		}
		item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- ImmuneToCondThink
		if ( typeof value == "integer" ) {

		}
		else {

			local output_string = ""
			foreach ( cond in value ) {

				output_string += ( cond.tostring() + ", " )
			}
			local final_comma_and_space = 2
			output_string = output_string.slice( 0, output_string.len() - final_comma_and_space )
		}
	}

	function MultMaxHealth( player, item, value ) {

		item.RemoveAttribute( "SET BONUS: max health additive bonus" )
		local add_hp_amount = player.GetMaxHealth() * ( value - 1 )
		item.AddAttribute( "SET BONUS: max health additive bonus", add_hp_amount, -1 )

	}

	function CustomKillIcon( player, item, value ) {

		local event_hook_string = format( "CustonKillIcon_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )


		local killicon_dummy = CreateByClassname( "info_teleport_destination" )
		local dummy_name = format( "killicon_dummy_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		SetPropString( killicon_dummy, STRING_NETPROP_NAME, dummy_name )
		SetPropString( killicon_dummy, STRING_NETPROP_CLASSNAME, value )
		SetPropBool( killicon_dummy, STRING_NETPROP_PURGESTRINGS, true )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

            // OnTakeDamage fires before damage calculations
			// always assume the worst possible damage rampup scenario (point blank minicrit scattergun)
			// player_hurt would be better, but doesn't have an easy way to get the weapon
			if (
				!params.weapon
                || params.weapon != item
                || params.const_entity.GetHealth() - ( ( params.damage * 1.75 ) * 1.35 ) > 0
            ) return

			params.inflictor = killicon_dummy

		}, EVENT_WRAPPER_CUSTOMATTR )

		player.GetScriptScope().kill_on_death.append( killicon_dummy )

	}

	function SetWarpaintSeed( player, item, value ) {

		local seed = value.tointeger()

		if ( _intsize_ == 8 ) {

			// This will overflow a Squirrel int as they're signed, but we don't care
			//  since we only want the bits; the value is irrelevant.
			item.AddAttribute( "custom_paintkit_seed_lo", casti2f( seed & 0xFFFFFFFF ), -1 )
			item.AddAttribute( "custom_paintkit_seed_hi", casti2f( seed >> 32 ), -1 )
		}
		else {

			// Decompose a 64-bit decimal seed string in to four 16-bit integers,
			//  and then compile the resulting integers to two 32 bit integers.
			local seed = value.tostring()
			local strlen = seed.len()
			local digitstore = array( strlen, 0 )

			for ( local i = 0; i < strlen; i++ ) {

				local carry = seed[ i ] - 48
				local tmp = 0

				for ( local i = ( strlen - 1 ); ( i >= 0 ); i-- ) {

					tmp = ( digitstore[ i ] * 10 ) + carry
					digitstore[ i ] = tmp & 0xFFFF
					carry = tmp >> 16
				}
			}

			item.AddAttribute( "custom_paintkit_seed_lo", casti2f( digitstore[ strlen - 2 ] << 16 | digitstore[ strlen - 1 ] ), -1 )
			item.AddAttribute( "custom_paintkit_seed_hi", casti2f( digitstore[ strlen - 4 ] << 16 | digitstore[ strlen - 3 ] ), -1 )
		}
		item.ReapplyProvision()

	}

	function MinRespawnTime( player, item, value ) {

		POP_EVENT_HOOK( "post_inventory_application", format( "MinRespawnTime_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() ), function( params ) {

			if (!PopExtUtil.IsWaveStarted) return

			if ( GetPlayerFromUserID(params.userid).IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			local respawn_override = PopExtUtil.RespawnOverride

			if ( !respawn_override.IsValid() )
				return

			local prev_respawn = GetPropFloat(respawn_override, "m_flRespawnTime")
			respawn_override.AcceptInput("SetRespawnTime", value.tostring(), null, null)
			respawn_override.AcceptInput("StartTouch", "", player, player)

			// TODO: see if this actually needs the delay
			// respawn_override.AcceptInput("SetRespawnTime", prev_respawn.tostring(), null, null)
			EntFireByHandle(respawn_override, "SetRespawnTime", prev_respawn.tostring(), -1, null, null)

		}, EVENT_WRAPPER_CUSTOMATTR)

	}

	function EffectCondOverride( player, item, value ) {

		local buff_conds = [ -1, TF_COND_OFFENSEBUFF, TF_COND_DEFENSEBUFF, TF_COND_REGENONDAMAGEBUFF, -1, TF_COND_CRITBOOSTED_RAGE_BUFF, TF_COND_SNIPERCHARGE_RAGE_BUFF, TF_COND_ENERGY_BUFF, TF_COND_ENERGY_BUFF ]
		local buff_type = item.GetAttribute( "mod soldier buff type", 0.0 )
		local item_classname = item.GetClassname()

		if ( 17 in item_classname && ( item_classname == "tf_weapon_charged_smg" || startswith( item_classname, "tf_weapon_lunchbox" ) ) )
			buff_type = PopExtUtil.GetItemIndex( item ) == ID_BUFFALO_STEAK_SANDVICH ? 8 : 7

		local event_hook_string = format( "EffectCondOverride_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		switch( buff_type ) {

			case 1:
			case 2:
			case 3:

				item.AddAttribute( "mod soldier buff type", 4, -1 ) // dummy buff type, does nothing
				item.ReapplyProvision()

				POP_EVENT_HOOK( "deploy_buff_banner", format( "EffectCondOverride_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() ), function( params ) {

					if ( params.buff_owner == PopExtUtil.PlayerTable[ player ] ) {
						// player.RemoveCondEx( buff_conds[ buff_type ], true )
						player.AddCondEx( value, item.GetAttribute( "increase buff duration", 1.0 ) * 10.0, player )
					}
				}, EVENT_WRAPPER_CUSTOMATTR )
			break
			case 5:
			case 6:
			case 7: // these two aren't actually valid buff types, just reusing the same logic for the buffs
			case 8:

				function EffectCondOverrideThink() {

					if ( ( buff_type != 7 && player.GetActiveWeapon() != item ) || !player.InCond( buff_conds[ buff_type ] ) )
						return

					player.RemoveCondEx( buff_conds[ buff_type ], true )
					player.AddCondEx( value, 0.33, player )

					if ( buff_type == 8 )
						player.RemoveCondEx( TF_COND_CANNOT_SWITCH_FROM_MELEE, true )
				}
				item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- EffectCondOverrideThink
			break
		}

		if ( item_classname == "tf_weapon_medigun" ) {

			POP_EVENT_HOOK( "player_chargedeployed", format( "EffectCondOverride_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() ), function( params ) {

				if ( params.userid != PopExtUtil.PlayerTable[ player ] )
					return

				local uberconds = [ TF_COND_INVULNERABLE, TF_COND_CRITBOOSTED, TF_COND_MEGAHEAL, TF_COND_MEDIGUN_UBER_BULLET_RESIST, TF_COND_MEDIGUN_UBER_BLAST_RESIST, TF_COND_MEDIGUN_UBER_FIRE_RESIST ]

				function EffectCondOverrideThink() {

					if ( player.GetActiveWeapon() != item )
						return

					foreach ( cond in uberconds ) {

						if ( player.InCond( cond ) ) {

							player.RemoveCondEx( cond, true )
							player.AddCondEx( value, 0.33, player )
							local heal_target = player.GetHealTarget()

							if ( heal_target != null ) {

								heal_target.RemoveCondEx( cond, true )
								heal_target.AddCondEx( value, 0.33, player )
							}
							break
						}
					}
				}
				item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- EffectCondOverrideThink
			}, EVENT_WRAPPER_CUSTOMATTR )
		}

	}

	function SpecialItemDescription( player, item, value ) {

	}

	function MultPlayerModelScale( player, item, value ) {

		player.SetModelScale( value, 0.0 )

	}


	/************************************
		* REIMPLEMENTED VANILLA ATTRIBUTES *
		************************************/

	function AltFireDisabled( player, item, value = null ) {

		local scope = item.GetScriptScope()

		local event_hook_string = format( "AltFireDisabled_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function AltFireDisabledThink() {

			if ( PopExtAttributes.HasAttr( player, "alt-fire disabled" ) && player.GetActiveWeapon() == item ) {

				SetPropInt( player, "m_afButtonDisabled", IN_ATTACK2 )
				SetPropFloat( item, "m_flNextSecondaryAttack", INT_MAX )
				return
			}
			SetPropInt( player, "m_afButtonDisabled", 0 )
		}
		scope.ItemThinkTable[ event_hook_string ] <- AltFireDisabledThink
		POP_EVENT_HOOK( "post_inventory_application", event_hook_string, function( params ) {

			if ( GetPlayerFromUserID( params.userid ).IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			SetPropInt( GetPlayerFromUserID( params.userid ), "m_afButtonDisabled", 0 )
		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function CustomProjectileModel( player, item, value ) {

		local projmodel = PrecacheModel( value )

		local scope = item.GetScriptScope()

		local event_hook_string = format( "CustomProjectileModel_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		function CustomProjectileModelThink() {

			if ( !PopExtAttributes.HasAttr( player, "custom projectile model" ) || player.GetActiveWeapon() != item )
				return

			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
				if ( projectile.GetOwner() == player && GetPropInt( projectile, STRING_NETPROP_MODELINDEX ) != projmodel )
					projectile.SetModel( value )
		}
		scope.ItemThinkTable[ event_hook_string ] <- CustomProjectileModelThink
	}

	function DmgBonusWhileHalfDead( player, item, value ) {

		local event_hook_string = format( "DmgBonusWhileHalfDead_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if (  params.weapon != item || !PopExtAttributes.HasAttr( player, "dmg bonus while half dead" ) )
				return

			if ( player.GetHealth() < ( player.GetMaxHealth() >> 1 ) )
				params.damage *= value

		}, EVENT_WRAPPER_CUSTOMATTR )

	}

	function DmgPenaltyWhileHalfAlive( player, item, value ) {

		local event_hook_string = format( "DmgPenaltyWhileHalfAlive_%d_%d", PopExtUtil.PlayerTable[ player ], item.entindex() )

		POP_EVENT_HOOK( "OnTakeDamage", event_hook_string, function( params ) {

			if ( params.weapon != item || !PopExtAttributes.HasAttr( player, "dmg penalty while half alive" ) )
				return

			if ( player.GetHealth() > ( player.GetMaxHealth() >> 1 ) )
				params.damage *= value
		}, EVENT_WRAPPER_CUSTOMATTR )

	}
}

function PopExtAttributes::SetDesc( player, attr ) {

	local scope = player.GetScriptScope()

	if ( !( "attribinfo" in scope ) )
		scope.attribinfo <- {}

	scope.attribinfo[ attr ] <- Descs[ attr ]
	PopExtAttributes.RefreshDescs( player )
}

function PopExtAttributes::HasAttr( player, attr ) {

	local scope = player.GetScriptScope()
	return "attribinfo" in scope && attr in scope.attribinfo
}

function PopExtAttributes::RefreshDescs( player ) {

	local cooldowntime = 3.0

	local scope = player.GetScriptScope()
	local formattedtable = []

	if ( !("attribinfo" in scope) )
		return

	foreach ( desc, attr in scope.attribinfo )
		if ( !formattedtable.find( attr ) )
			formattedtable.append( format( "%s:\n\n%s\n\n\n", desc, attr ) )

	local i = 0
	function ShowAttribInfoThink() {

		if ( !formattedtable.len() || !player.IsInspecting() || Time() < cooldowntime )
			return

		if ( i + 1 < formattedtable.len() )
			PopExtUtil.ShowHudHint( format( "%s%s", formattedtable[ i ], formattedtable[ i + 1 ] ), player, 3.0 - SINGLE_TICK )
		else
			PopExtUtil.ShowHudHint( formattedtable[ i ], player, 3.0 - SINGLE_TICK )

		i += 2

		if ( i >= formattedtable.len() )
			i = 0

		cooldowntime = Time() + 3.0
	}
	PopExtUtil.AddThink( player, ShowAttribInfoThink )
}

function PopExtAttributes::GetAttributeFunctionFromStringName( attr ) {

	local special_names = {

		"alt-fire disabled" : "AltFireDisabled",
		"mult teleporter recharge rate" : "TeleporterRechargeTime",
	}
	if ( attr in special_names )
		return special_names[ attr ]

	local str = ""
	split( attr, " ", true ).apply( @( s ) str += format( "%s%s", s.slice( 0, 1 ).toupper(), s.slice( 1 ) ) )
	return str
}

function PopExtAttributes::CleanupFunctionTable( handle, table, attr ) {

	local str = GetAttributeFunctionFromStringName( attr )

	foreach ( name, v in table )
		if ( typeof v == "function" && startswith( name, format( "%s_%d", str, PlayerTable[ handle ] ) ) )
			delete table[ format( "%s", name ) ]
}



// DEPRECATED: DO NOT USE
function PopExtAttributes::AddAttr( player, attr_string, value = 0, item = null ) {

	PopExtMain.Error.DeprecationWarning( "CustomAttributes::AddAttr", "PopExtUtil::SetPlayerAttributes" )

	local attr = split( attr_string, " ", true ).len() > 1 ? GetAttributeFunctionFromStringName( attr_string ) : attr_string

	local item_table = {}

	// no item, just apply to the active weapon
	if ( item == null ) item = player.GetActiveWeapon()

	switch ( typeof item ) {

	// entity handle passed
	case "instance":
		item_table[ item ] <- [ attr, value ]
		break

	// table of entity handles passed
	case "table":
		item_table = item
		break

	// array of entity handles passed
	case "array":
		foreach ( handle in item )
			item_table[ handle ] <- [ attr, value ]
		break

	// invalid item
	default:
		PopExtMain.Error.RaiseValueError( "Invalid item ( " + item + " ) passed to CustomAttributes::AddAttr!" )
		break
	}

	// easy access table in player scope for our items and their attributes
	player.GetScriptScope().CustomAttrItems <- item_table

	// cleanup any previous attribute functions from these CustomAttributes event hooks
	local t = [ "TakeDamageTable", "TakeDamagePostTable", "SpawnHookTable", "DeathHookTable", "PlayerTeleportTable" ]
	foreach ( tablename in t )
		foreach ( table, func in PopExtAttributes[ tablename ] )
			if ( tablename in PopExtAttributes )
				PopExtAttributes.CleanupFunctionTable( player, table, attr )

	// cleanup item thinks
	foreach ( item, _ in item_table )
		PopExtAttributes.CleanupFunctionTable( item, "ItemThinkTable", attr )

	local scope = player.GetScriptScope()
	if ( !( "attribinfo" in scope ) )
		scope.attribinfo <- {}

	foreach ( item, attrs in item_table ) {

		local item = PopExtUtil.HasItemInLoadout( player, item )

		if ( item == null || !( attr in PopExtAttributes.Attrs ) )
			continue

		PopExtAttributes.Attrs[ attr ]( player, item, value )

		PopExtAttributes.RefreshDescs( player )
	}
}

// TODO: deprecate the old namespace.
::CustomAttributes <- PopExtAttributes