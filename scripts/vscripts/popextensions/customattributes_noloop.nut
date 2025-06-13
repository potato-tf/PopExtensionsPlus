::CustomAttributes <-
{
	ROCKET_LAUNCHER_CLASSNAMES =
	[
		"tf_weapon_rocketlauncher",
		"tf_weapon_rocketlauncher_airstrike",
		"tf_weapon_rocketlauncher_directhit",
		"tf_weapon_particle_cannon",
	]

	Attrs =
	{
		function FiresMilkBolt( player, item, value )
		{
			local scope = item.GetScriptScope()
			local playerScope = player.GetScriptScope()

			// mad milk default params
			local duration = 10.0, recharge = 20.0

			if ( "duration" in value ) duration = value.duration
			if ( "recharge" in value ) recharge = value.recharge

			scope.milkBoltLastFireTime <- 0.0
			scope.milkBoltRequest <- false

			local event_hook_string = format( "FiresMilkBolt_%d_%d", player.GetScriptScope().userid, item.entindex() )

			playerScope.PlayerThinkTable[ event_hook_string ] <- function()
			{
				if ( item == null || player.GetActiveWeapon() != item )
					return

				if ( PopExtUtil.InButton( player, IN_ATTACK2 ) && Time() - scope.milkBoltLastFireTime > recharge )
				{
					// these 3 following lines must be in this order, otherwise it will break
					scope.milkBoltRequest = true
					item.PrimaryAttack()
					scope.milkBoltLastFireTime = Time()
				}
				if ( PopExtUtil.InButton( player, IN_ATTACK2 ) && Time() - scope.milkBoltLastFireTime < recharge )
				{
					ClientPrint( player, HUD_PRINTCENTER, format( "Milk bolt is recharging! It will be available in %.1f seconds.", scope.milkBoltLastFireTime - Time() + recharge ) )
				}
				if ( PopExtUtil.InButton( player, IN_ATTACK ) || PopExtUtil.InButton( player, IN_ATTACK3 ) || player.GetActiveWeapon() != item )
				{
					scope.milkBoltRequest = false
				}
			}

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity
				local attacker = params.attacker

				if ( !attacker || !victim.IsPlayer() ) return

				local item = PopExtUtil.HasItemInLoadout( player, params.weapon )

				local scope = item ? scope = item.GetScriptScope() : false

				if ( !scope || !victim || !attacker || attacker != player || !( "milkBoltRequest" in scope ) || !scope.milkBoltRequest || Time() - scope.milkBoltLastFireTime < recharge )
					return

				victim.AddCondEx( TF_COND_MAD_MILK, duration, attacker )
				scope.milkBoltRequest = false
			})

			player.GetScriptScope().attribinfo[ "fires milk bolt" ] <- format( "Secondary attack: fires a bolt that applies milk for %.2f seconds. Regenerates every %.2f seconds.", duration.tofloat(), recharge.tofloat() )
		}

		function AddCondOnHit( player, item, value )
		{
			local event_hook_string = format( "AddCondOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
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
			})

			local desc_string = typeof value == "array" ?
			format( "applies cond %d to victim on hit for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
			format( "applies cond %d to victim on hit", value )
			player.GetScriptScope().attribinfo[ "add cond on hit" ] <- desc_string
		}

		function RemoveCondOnHit( player, item, value )
		{
			local event_hook_string = format( "RemoveCondOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_hurt", event_hook_string, function( params )
			{
				local victim = GetPlayerFromUserID( params.userid )
				local attacker = GetPlayerFromUserID( params.attacker )

				if ( victim == null || attacker == null || !victim.IsPlayer() || !victim.InCond( value ) || victim.IsInvulnerable() || attacker != player || params.weapon != item )
					return

				victim.RemoveCondEx( value, true )
			})

			player.GetScriptScope().attribinfo[ "remove cond on hit" ] <- format( "removes cond %d from victim", value )
		}

		function SelfAddCondOnHit( player, item, value )
		{
			local event_hook_string = format( "SelfAddCondOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity
				local attacker = params.attacker

				if ( attacker == null || !attacker.IsPlayer() || victim.IsInvulnerable() || ( typeof value == "array" && attacker.InCond( value[ 0 ] ) ) || ( typeof value == "integer" && attacker.InCond( value ) ) )
					return

				typeof value == "array" ? attacker.AddCondEx( value[ 0 ], value[ 1 ], attacker ) : attacker.AddCond( value )
			})

			local desc_string = typeof value == "array" ?
			format( "applies cond %d to self on hit for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
			format( "applies cond %d to self on hit", value )
			player.GetScriptScope().attribinfo[ "self add cond on hit" ] <- desc_string
		}

		function SelfAddCondOnKill( player, item, value )
		{
			local event_hook_string = format( "SelfAddCondOnKill_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_death", event_hook_string, function( params )
			{
				local attacker = GetPlayerFromUserID( params.attacker )
				local victim = GetPlayerFromUserID( params.userid )

				if ( victim == null || attacker == null || !attacker.IsPlayer() )
					return

				typeof value == "array" ? attacker.AddCondEx( value[ 0 ], value[ 1 ], attacker ) : attacker.AddCond( value )
			})

			local desc_string = typeof value == "array" ?
			format( "applies cond %d to self on kill for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
			format( "applies cond %d to self on kill", value )
			player.GetScriptScope().attribinfo[ "self add cond on kill" ] <- desc_string
		}

		function FireInputOnHit( player, item, value )
		{
			local args = split( value, "^" )
			local targetname = args[ 0 ]
			local input = args[ 1 ]
			local param = ""
			local delay = -1

			if ( args.len() > 2 )
				param = args[ 2 ]
			if ( args.len() > 3 )
				delay = args[ 3 ].tofloat()

			local event_hook_string = format( "FireInputOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.attacker != player || params.weapon != item )
					return

				targetname == "!self" ? EntFireByHandle( params.attacker, input, param, delay, null, null ) : DoEntFire( targetname, input, param, delay, null, null )
			})

			player.GetScriptScope().attribinfo[ "fire input on hit" ] <- format( "fires custom entity input on hit: %s", value )
		}

		function FireInputOnKill( player, item, value )
		{
			local args = split( value, "^" )
			local targetname = args[ 0 ]
			local input = args[ 1 ]
			local param = ""
			local delay = -1

			if ( args.len() > 2 )
				param = args[ 2 ]
			if ( args.len() > 3 )
				delay = args[ 3 ].tofloat()

			local event_hook_string = format( "FireInputOnKill_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_death", event_hook_string, function( params )
			{
				if ( GetPlayerFromUserID( params.attacker ) != player || params.weapon != item )
					return

				targetname = "!self" ? EntFireByHandle( GetPlayerFromUserID( params.attacker ), input, param, delay, null, null ) : DoEntFire( targetname, input, param, delay, null, null )
			})

			player.GetScriptScope().attribinfo[ "fire input on kill" ] <- format( "fires custom entity input on kill: %s", value )
		}

		function MultDmgVsSameClass( player, item, value )
		{
			local event_hook_string = format( "MultDmgVsSameClass_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity
				local attacker = params.attacker

				if ( attacker && ( !attacker.IsValid() || attacker.GetTeam() == player.GetTeam() ) )
					return

				local scope = attacker.GetScriptScope()

				if (
					!attacker.IsPlayer() || !victim.IsPlayer() ||
					!( "mult dmg vs same class" in player.GetScriptScope().attribinfo ) ||
					attacker.GetPlayerClass() != victim.GetPlayerClass() ||
					player.GetActiveWeapon() != item
				) return

				params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "mult dmg vs same class" ] <- format( "Damage versus %s multiplied by %.2f", PopExtUtil.Classes[ player.GetPlayerClass() ], value.tofloat() )
		}

		function MultDmgVsAirborne( player, item, value )
		{
			local event_hook_string = format( "MultDmgVsAirborne_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity
				if ( victim != null && victim.IsPlayer() && GetPropEntity( victim, "m_hGroundEntity" ) == null )
				params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "mult dmg vs airborne" ] <- format( "Damage versus airborne targets multiplied by %.2f", value.tofloat() )
		}

		function TeleportInsteadOfDie( player, item, value )
		{
			local event_hook_string = format( "TeleportInsteadOfDie_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( RandomFloat( 0, 1 ) > value.tofloat() )
					return

				local player = params.const_entity
				local scope = player.GetScriptScope()

				if ( !( "attribinfo" in scope ) )
					return

				if (
					!player.IsPlayer() || player.GetHealth() > params.damage ||
					!( "teleport instead of die" in scope.attribinfo ) ||
					player.IsInvulnerable() || PopExtUtil.IsPointInTrigger( player.EyePosition() )
				) return

				local health = player.GetHealth()
				params.early_out = true

				player.ForceRespawn()
				EntFireByHandle( player, "RunScriptCode", "self.SetHealth(1)", -1, null, null )
			})

			player.GetScriptScope().attribinfo[ "teleport instead of die" ] <- format( "%d⁒ chance of teleporting to spawn with 1 health instead of dying", ( value.tofloat() * 100 ).tointeger() )
		}

		function MeleeCleaveAttack( player, item, value = 64 )
		{
			local scope = item.GetScriptScope()

			scope.cleavenextattack <- 0.0
			scope.cleaved <- false

			local event_hook_string = format( "MeleeCleaveAttack_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if (
					scope.cleavenextattack == GetPropFloat( item, "m_flNextPrimaryAttack" )
					|| GetPropFloat( item, "m_fFireDuration" ) == 0.0
					|| player.GetActiveWeapon() != item
					|| !( "melee cleave attack" in player.GetScriptScope().attribinfo )
				) return

				scope.cleaved = false

				scope.cleavenextattack = GetPropFloat( item, "m_flNextPrimaryAttack" )
			}

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( scope.cleaved || params.weapon != item || !( "melee cleave attack" in player.GetScriptScope().attribinfo ) )
					return

				scope.cleaved = true
				// params.early_out = true

				local swingpos = player.EyePosition() + ( player.EyeAngles().Forward() * 30 ) - Vector( 0, 0, value )

				for ( local p; p = FindByClassnameWithin( p, "player", swingpos, value ); )
					if ( p.GetTeam() != player.GetTeam() && p.GetTeam() != TEAM_SPECTATOR && p != params.const_entity )
						p.TakeDamageCustom( params.inflictor, params.attacker, params.weapon, params.damage_force, params.damage_position, params.damage, params.damage_type, params.damage_custom )
			})

			player.GetScriptScope().attribinfo[ "melee cleave attack" ] <- "On Swing: Weapon hits multiple targets"
		}

		// unfinished attribute
		function TeleporterRechargeTime( player, item, value = 1.0 )
		{
			ClientPrint( player, HUD_PRINTTALK, "DONT USE ME! Teleporter recharge time is not finished!" )
			// not finished
			return

			local scope = item.GetScriptScope()
			scope.teleporterrechargetimemult <- value

			local event_hook_string = format( "TeleporterRechargeTime_%d_%d", player.GetScriptScope().userid, item.entindex() )

			// CustomAttributes.PlayerTeleportTable[format("TeleporterRechargeTime_%d_%d", player.GetScriptScope().userid, item.entindex())] <- function(params)
			// {
			//     local teleportedplayer = GetPlayerFromUserID(params.userid)

			//     local teleporter = FindByClassnameNearest("obj_teleporter", teleportedplayer.GetOrigin(), 16)

			//     local chargetime = GetPropFloat(teleporter, "m_flCurrentRechargeDuration")
			// }

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				local mult = scope.teleporterrechargetimemult
				local teleporter = FindByClassnameNearest( "obj_teleporter", player.GetOrigin(), 16 )

				if ( teleporter == null || teleporter.GetScriptThinkFunc() != "" )
					return

				teleporter.ValidateScriptScope()
				local chargetime = GetPropFloat( teleporter, "m_flCurrentRechargeDuration" )

				local teleportscope = teleporter.GetScriptScope()
				if ( !( "rechargetimestamp" in teleportscope ) )
					teleportscope.rechargetimestamp <- 0.0
				if ( !( "rechargeset" in teleportscope ) )
					teleportscope.rechargeset <- false

				teleportscope.TeleportMultThink <- function()
				{
					if ( !teleportscope.rechargeset )
					{
						SetPropFloat( teleporter, "m_flCurrentRechargeDuration", chargetime * mult )
						SetPropFloat( teleporter, "m_flRechargeTime", Time() * mult )

						teleportscope.rechargeset = true
						teleportscope.rechargetimestamp = GetPropFloat( teleporter, "m_flRechargeTime" ) * mult
					}
					if ( GetPropInt( teleporter, "m_iState" ) == 6 && GetPropFloat( teleporter, "m_flRechargeTime" ) >= teleportscope.rechargetimestamp )
					{
						teleportscope.rechargeset = false
					}

					printl( GetPropFloat( teleporter, "m_flRechargeTime" ) + " : " + teleportscope.rechargetimestamp )
					return
				}
				AddThinkToEnt( teleporter, "TeleportMultThink" )
			}

			player.GetScriptScope().attribinfo[ "teleporter recharge time" ] <- format( "Teleporter recharge rate multiplied by %.2f", value )
		}

		function UberOnDamageTaken( player, item, value )
		{
			local event_hook_string = format( "UberOnDamageTaken_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local damagedplayer = params.const_entity

				if (
					damagedplayer != player || RandomInt( 0, 1 ) > value ||
					!( "uber on damage taken" in player.GetScriptScope().attribinfo ) ||
					damagedplayer.IsInvulnerable() || player.GetActiveWeapon() != item
				) return

				damagedplayer.AddCondEx( COND_UBERCHARGE, 3.0, player )
				params.early_out = true
			})

			player.GetScriptScope().attribinfo[ "uber on damage taken" ] <- format( "On take damage: %d⁒ chance of gaining invicibility for 3 seconds", ( value.tofloat() * 100 ).tointeger() )
		}

		function SetTurnToIce( player, item, value = null )
		{
			// cleanup before spawning a new one
			for ( local knife; knife = FindByClassname( knife, "tf_weapon_knife" ); )
				if ( PopExtUtil.GetItemIndex( knife ) == ID_SPY_CICLE && knife.IsEFlagSet( EFL_USER ) )
					EntFireByHandle( knife, "Kill", "", -1, null, null )

			local freeze_proxy_weapon = CreateByClassname( "tf_weapon_knife" )
			SetPropInt( freeze_proxy_weapon, STRING_NETPROP_ITEMDEF, ID_SPY_CICLE )
			SetPropBool( freeze_proxy_weapon, STRING_NETPROP_INIT, true )
			freeze_proxy_weapon.AddEFlags( EFL_USER )
			SetPropEntity( freeze_proxy_weapon, "m_hOwner", player )
			freeze_proxy_weapon.DispatchSpawn()
			freeze_proxy_weapon.DisableDraw()

			// Add the attribute that creates ice statues
			freeze_proxy_weapon.AddAttribute( "freeze backstab victim", 1.0, -1.0 )

			local event_hook_string = format( "SetTurnToIce_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local attacker = params.attacker

				local victim = params.const_entity
				if ( victim.IsPlayer() && attacker == player && params.damage >= victim.GetHealth() && player.GetActiveWeapon() == item )
				{
					victim.TakeDamageCustom( attacker, victim, freeze_proxy_weapon, Vector(), Vector(), params.damage, params.damage_type, params.damage_custom | TF_DMG_CUSTOM_BACKSTAB )

					// I don't remember why this is needed but it's important
					local ragdoll = GetPropEntity( victim, "m_hRagdoll" )
					if ( ragdoll )
						SetPropInt( ragdoll, "m_iDamageCustom", 0 )
					params.early_out = true
				}
			})

			player.GetScriptScope().attribinfo[ "set turn to ice" ] <- format( "On Kill: Turn victim to ice.", value )
		}

		function ModTeleporterSpeedBoost( player, item, value )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "AddCondOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_teleported", event_hook_string, function( params )
			{
				if ( !( "mod teleporter speed boost" in player.GetScriptScope().attribinfo ) || params.builderid != player.GetScriptScope().userid )
					return

				local teleportedplayer = GetPlayerFromUserID(params.userid)
				teleportedplayer.AddCondEx(TF_COND_SPEED_BOOST, value, player)
			})

			player.GetScriptScope().attribinfo[ "mod teleporter speed boost" ] <- format( "Teleporters grant a speed boost for %.2f seconds upon exiting", value )
		}

		function CanBreatheUnderWater( player, item, value = null )
		{
			local painfinished = GetPropInt( player, "m_PainFinished" )

			local scope = item.GetScriptScope()
			local event_hook_string = format( "CanBreatheUnderwater_%d_%d", player.GetScriptScope().userid, item.entindex() )
			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "can breathe under water" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				if ( player.GetWaterLevel() == 3 )
				{
					SetPropFloat( player, "m_PainFinished", FLT_MAX )
					return
				}
				SetPropFloat( player, "m_PainFinished", 0.0 )
			}

			player.GetScriptScope().attribinfo[ "can breathe under water" ] <- "Player can breathe underwater"
		}

		function MultSwimSpeed( player, item, value = 1.25 )
		{
			// local speedmult = 1.254901961
			local maxspeed = GetPropFloat( player, "m_flMaxspeed" )

			local scope = item.GetScriptScope()
			local event_hook_string = format( "MultSwimSpeed_%d_%d", player.GetScriptScope().userid, item.entindex() )
			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "mult swim speed" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				if ( player.GetWaterLevel() == 3 )
				{
					SetPropFloat( player, "m_flMaxspeed", maxspeed * value )
					return
				}
				SetPropFloat( player, "m_flMaxspeed", maxspeed )
			}

			player.GetScriptScope().attribinfo[ "mult swim speed" ] <- format( "Swimming speed multiplied by %.2f", value.tofloat() )
		}

		function LastShotCrits( player, item, value )
		{
			local duration = ( "duration" in value ) ? value.duration : 0.033

			local scope = item.GetScriptScope()
			// scope.lastshotcritsnextattack <- 0.0

			local event_hook_string = format( "LastShotCrits_%d_%d", player.GetScriptScope().userid, item.entindex() )
			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !item || !( "last shot crits" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				// if (scope.lastshotcritsnextattack == GetPropFloat(item, "m_flNextPrimaryAttack")) return

				// scope.lastshotcritsnextattack = GetPropFloat(item, "m_flNextPrimaryAttack")

				if ( item.IsValid() && item.Clip1() == 1 )
					player.AddCondEx( COND_CRITBOOST, duration, null )
			}

			player.GetScriptScope().attribinfo[ "last shot crits" ] <- format( "Crit boost on last shot. Crit boost will stay active for %.2f seconds after holster", duration.tofloat() )
		}

		function CritWhenHealthBelow( player, item, value = -1 )
		{
			local event_hook_string = format( "CritWhenHealthBelow_%d_%d", player.GetScriptScope().userid, item.entindex() )
			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetHealth() < value && player.GetActiveWeapon() == item )
				{
					player.AddCondEx( COND_CRITBOOST, 0.033, player )
					return
				}
			}

			player.GetScriptScope().attribinfo[ "crit when health below" ] <- format( "Player is crit boosted when below %d health", value )
		}

		function WetImmunity( player, item, value = null )
		{
			local wetconds = [ TF_COND_MAD_MILK, TF_COND_URINE, TF_COND_GAS ]

			local event_hook_string = format( "WetImmunity_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() != item )
					return

				foreach ( cond in wetconds )
					player.RemoveCondEx( cond, true )
			}

			player.GetScriptScope().attribinfo[ "wet immunity" ] <- "Immune to jar effects when active"
		}

		function BuildSmallSentries( player, item, value = null )
		{
			local scope = player.GetScriptScope()
			scope.previousBuiltSentry <- null

			local event_hook_string = format( "BuildSmallSentries_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_builtobject", event_hook_string, function( params )
			{
				local builder = GetPlayerFromUserID( params.userid )

				if ( builder != player || params.object != OBJ_SENTRYGUN )
					return

				local sentry = EntIndexToHScript( params.index )

				if ( sentry == scope.previousBuiltSentry )
				{
					SetPropInt( sentry, "m_iUpgradeMetalRequired", 150 )
					return
				}

				scope.previousBuiltSentry = sentry
				EntFireByHandle(sentry, "RunScriptCode", @"
					local maxhealth = self.GetMaxHealth() * 0.66
					self.SetMaxHealth( maxhealth )
					if ( self.GetHealth() > self.GetMaxHealth() )
					self.SetHealth( maxhealth )

					self.SetModelScale( 0.8, -1 )

					SetPropInt( self, `m_iUpgradeMetalRequired`, 150 )
				", SINGLE_TICK, null, null);
			})

			PopExtEvents.AddRemoveEventHook( "player_upgradedobject", event_hook_string, function( params )
			{
				local upgrader = GetPlayerFromUserID( params.userid )

				if ( upgrader != player || params.object != OBJ_SENTRYGUN )
					return

				local sentry = EntIndexToHScript( params.index )

				EntFireByHandle(sentry, "RunScriptCode", @"
					local maxhealth = self.GetMaxHealth() * 0.66
					self.SetMaxHealth( maxhealth )
					if ( self.GetHealth() > self.GetMaxHealth() )
						self.SetHealth( maxhealth )

					SetPropInt( self, `m_iUpgradeMetalRequired`, 150 )
				", SINGLE_TICK, null, null );
			})

			PopExtEvents.AddRemoveEventHook( "mvm_quick_sentry_upgrade", event_hook_string, function( params )
			{
				for ( local sentry; sentry = FindByClassname( sentry, "obj_sentrygun" ); )
				{
					if ( GetPropEntity( sentry, "m_hBuilder" ) == player )
					{
						EntFireByHandle( sentry, "RunScriptCode", @"
							local maxhealth = self.GetMaxHealth() * 0.66
							self.SetMaxHealth( maxhealth )
							if ( self.GetHealth() > self.GetMaxHealth() )
								self.SetHealth( maxhealth )
						", SINGLE_TICK, null, null);
					}
				}
			})

			player.GetScriptScope().attribinfo[ "build small sentries" ] <- "Sentries are 20⁒ smaller, have 33⁒ less health, take 25⁒ less metal to upgrade"
		}

		function RadiusSleeper( player, item, value = null )
		{
			local event_hook_string = format( "RadiusSleeper_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "player_hurt", event_hook_string, function( params )
			{
				local victim = GetPlayerFromUserID( params.userid )
				local attacker = GetPlayerFromUserID( params.attacker )

				if ( attacker == null )
					return

				local scope = attacker.GetScriptScope()

				if ( !( "radius sleeper" in player.GetScriptScope().attribinfo ) )
					return

				if ( victim == null || attacker == null || attacker != player || GetPropFloat( attacker.GetActiveWeapon(), "m_flChargedDamage" ) < 150.0 )
					return

				SpawnEntityFromTable( "tf_projectile_jar", { origin = victim.EyePosition() } )
			})

			player.GetScriptScope().attribinfo[ "radius sleeper" ] <- "On full charge headshot: create jarate explosion on victim"
		}

		// OBSOLETE, use ExplosiveBulletsExt instead
		function ExplosiveBullets( player, item, value )
		{
			local scope = item.GetScriptScope()
			// cleanup before spawning a new one
			for ( local launcher; launcher = FindByClassname( launcher, "tf_weapon_grenadelauncher" ); )
				if ( launcher.IsEFlagSet( EFL_USER ) )
					EntFireByHandle( launcher, "Kill", "", -1, null, null )

			local launcher = CreateByClassname( "tf_weapon_grenadelauncher" )
			SetPropInt( launcher, STRING_NETPROP_ITEMDEF, ID_GRENADELAUNCHER )
			SetPropBool( launcher, STRING_NETPROP_INIT, true )
			launcher.AddEFlags( EFL_USER )
			launcher.SetOwner( player )
			launcher.DispatchSpawn()
			launcher.DisableDraw()

			launcher.AddAttribute( "fuse bonus", 0.0, -1 )
			// launcher.AddAttribute("dmg penalty vs players", 0.0, -1)

			scope.explosivebulletsnextattack <- 0.0
			scope.curammo <- GetPropIntArray( player, "m_iAmmo", item.GetSlot() + 1 )
			if ( item.Clip1() != -1 )
				scope.curclip <- item.Clip1()

			local event_hook_string = format( "ExplosiveBullets_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "explosive bullets" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item || scope.explosivebulletsnextattack == GetPropFloat( item, "m_flLastFireTime" ) )
					return

				local grenade = CreateByClassname( "tf_projectile_pipe" )
				SetPropEntity( grenade, "m_hOwnerEntity", launcher )
				SetPropEntity( grenade, "m_hLauncher", launcher )
				SetPropEntity( grenade, "m_hThrower", player )
				SetPropFloat( grenade, "m_flDamage", value * 2 ) // shithack: multiply damage by 2 to account for distance falloff
				grenade.SetCollisionGroup( COLLISION_GROUP_DEBRIS )

				DispatchSpawn( grenade )
				grenade.DisableDraw()

				local trace =
				{
					start = player.EyePosition(),
					end = player.EyePosition() + ( player.EyeAngles().Forward() * 8192.0 ),
					ignore = player
				}
				TraceLineEx( trace )
				if ( trace.hit && "enthit" in trace )
				{
					if ( trace.enthit.GetClassname() == "worldspawn" )
						grenade.SetAbsOrigin( trace.endpos )
					else
						grenade.SetAbsOrigin( trace.enthit.EyePosition() + Vector( 0, 0, 45 ) )
				}

				scope.explosivebulletsnextattack = GetPropFloat( item, "m_flLastFireTime" )
				scope.curammo = GetPropIntArray( player, "m_iAmmo", item.GetSlot() + 1 )
				if ( "curclip" in scope )
					scope.curclip = item.Clip1()
			}

			player.GetScriptScope().attribinfo[ "explosive bullets" ] <- format( "Fires explosive rounds that deal %d damage.  \nOBSOLETE: USE 'explosive bullets ext' INSTEAD", value )
		}

		function ExplosiveBulletsExt( player, item, value )
		{
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

			local event_hook_string = format( "ExplosiveBulletsExt_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( "explosivebullets" in scope || params.weapon != item || !( "explosive bullets ext" in player.GetScriptScope().attribinfo ) )
					return

				scope.explosivebullets <- true

				local particleent = SpawnEntityFromTable( "info_particle_system", { effect_name = particle } )

				if (
					params.const_entity.GetClassname() == generic_bomb
					|| params.attacker.GetClassname() == generic_bomb
					|| ( params.attacker == player && params.const_entity.GetClassname() == generic_bomb )
				) return

				local bomb = CreateByClassname( generic_bomb )

				SetPropFloat( bomb, "m_flDamage", damage )
				SetPropFloat( bomb, "m_flRadius", radius )
				SetPropString( bomb, "m_explodeParticleName", particle ) // doesn't work
				SetPropString( bomb, "m_strExplodeSoundName", sound )

				bomb.DispatchSpawn()
				bomb.SetOwner( params.attacker )

				bomb.SetTeam( team )
				bomb.SetAbsOrigin( params.damage_position )
				bomb.SetHealth( 1 )
				if ( model != "" )
					bomb.SetModel( model )

				particleent.SetAbsOrigin( bomb.GetOrigin() )
				SetPropString( bomb, "m_iClassname", killicon )
				bomb.TakeDamage( 1, DMG_CLUB, player )
				EntFireByHandle( particleent, "Start", "", -1, null, null )
				EntFireByHandle( particleent, "Stop", "", SINGLE_TICK, null, null )
				EntFireByHandle( particleent, "Kill", "", SINGLE_TICK * 2, null, null )

				if ( "explosivebullets" in scope )
					delete scope.explosivebullets
			})

			player.GetScriptScope().attribinfo[ "explosive bullets ext" ] <- format( "Fires explosive rounds that deal %d damage in a radius of %d", value.damage, value.radius )
		}

		function OldSandmanStun( player, item, value = null )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "OldSandmanStun_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local attacker = params.attacker
				local victim = params.const_entity

				if ( params.damage_stats == TF_DMG_CUSTOM_BASEBALL && params.weapon == item )
					PopExtUtil.StunPlayer( victim, 5, TF_STUN_CONTROLS )
			})

			player.GetScriptScope().attribinfo[ "old sandman stun" ] <- "Uses pre-JI stun mechanics"
		}

		function StunOnHit( player, item, value )
		{
			local scope = item.GetScriptScope()

			local duration = "duration" in value ? value.duration : 5
			local type = "type" in value ? value.type : 2
			local speedmult = "speedmult" in value ? value.speedmult : 0.2
			local stungiants = "stungiants" in value ? value.stungiants : true

			// `stun on hit`: { duration = 4 type = 2 speedmult = 0.2 stungiants = false } //in order: stun duration in seconds, stun type, stun movespeed multiplier, can stun giants true/false

			local event_hook_string = format( "StunOnHit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( !params.const_entity.IsPlayer() || params.weapon != item || ( !stungiants && params.const_entity.IsMiniBoss() ) )
					return

				PopExtUtil.StunPlayer( params.const_entity, duration, type, 0, speedmult )
			})

			player.GetScriptScope().attribinfo[ "stun on hit" ] <- format( "Stuns victim for %.2f seconds on hit", value[ "duration" ].tofloat() )
		}

		function IsMiniboss( player, item, value = null )
		{
			local event_hook_string = format( "OldSandmanStun_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() == item )
				{
					player.SetIsMiniBoss( true )
					player.SetModelScale( 1.75, -1 )
					return
				}
				player.SetIsMiniBoss( false )
				player.SetModelScale( 1.0, -1 )
			}

			player.GetScriptScope().attribinfo[ "is miniboss" ] <- "When weapon is active: player becomes giant"
		}

		function ReplaceWeaponFireSound( player, item, value )
		{
			if ( typeof value != "array" )
			{
				PopExtMain.Error.RaiseValueError( "Replace weapon fire sound must be an array\nFirst Index: sound to replace\nSecond index: new sound name" )
			}

			if ( typeof value[ 1 ] == "array" )
			{
				foreach ( v in value[ 1 ] )
				{
					PrecacheSound( v )
					PrecacheScriptSound( v )
				}
			}
			else
			{
				PrecacheSound( value[ 1 ] )
				PrecacheScriptSound( value[ 1 ] )
			}

			local scope = item.GetScriptScope()
			scope.attacksound <- 0.0

			local event_hook_string = format( "ReplaceWeaponFireSound_%d_%d", player.GetScriptScope().userid, item.entindex() )

			if ( PopExtUtil.IsProjectileWeapon( item ) )
			{
				scope.ItemThinkTable[ event_hook_string ] <- function()
				{
					if (
						player.GetActiveWeapon() != item
						|| !( "attacksound" in scope )
						|| GetPropFloat( item, "m_flLastFireTime" ) == scope.attacksound
					) return

					if ( typeof value[ 0 ] == "array" )
					{
						foreach ( v in value[ 0 ] )
						{
							StopSoundOn( v, player )
							player.StopSound( v )
						}
						// GetLastFiredProjectile must be called in an EntFire delay
						// projectiles are added to the ActiveProjectile array after weapon fire
						PopExtUtil.PlayerScriptEntFire( player, format(@"
							local scope = self.GetScriptScope()
							local projectile = PopExtUtil.GetLastFiredProjectile( self )

							local snd = projectile && GetPropBool( projectile, `m_bCritical` ) ? `%s` : `%s`
							EmitSoundEx( { sound_name = snd, entity = self } )
						", value[ 1 ][ 1 ], value[ 1 ][ 0 ] ) )
					}
					else
					{
						StopSoundOn( value[ 0 ], player )
						player.StopSound( value[ 0 ] )
						EmitSoundEx( { sound_name = value[ 1 ], entity = player } )
					}

					scope.attacksound = GetPropFloat( item, "m_flLastFireTime" )
				}
				return
			}

			SetPropInt( PopExtUtil.Worldspawn, "m_takedamage", 1 )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local _weapon = params.weapon
				printl(_weapon)

				if ( !_weapon || _weapon != item )
					return

				if ( typeof value[ 0 ] == "array" )
				{
					foreach ( v in value[ 0 ] )
					{
						StopSoundOn( v, player )
						player.StopSound( v )
					}

					local snd = value[ 1 ][ params.damage_type & DMG_CRITICAL ? 1 : 0 ]
					EmitSoundEx( { sound_name = snd, entity = player } )
				}
				else
				{
					StopSoundOn( value[ 0 ], player )
					player.StopSound( value[ 0 ] )
					EmitSoundEx( { sound_name = value[ 1 ], entity = player } )
				}
			})

			local infostring = typeof value[ 1 ] == "array" ? format( "Weapon fire sound replaced with %s (normal) and %s (critical)", value[ 1 ][ 0 ], value[ 1 ][ 1 ] ) : format( "Weapon fire sound replaced with %s", value[ 1 ] )
			player.GetScriptScope().attribinfo[ "replace weapon fire sound" ] <- infostring
		}

		function IsInvisible( player, item, value = null )
		{
			local event_hook_string = format( "IsInvisible%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() != item || PopExtUtil.HasEffect( EF_NODRAW ) )
					return

				item.DisableDraw()
			}

			player.GetScriptScope().attribinfo[ "is invisible" ] <- "Weapon is invisible"
		}

		function CannotUpgrade( player, item, value = null )
		{
			local index = PopExtUtil.GetItemIndex( item )
			local classname = GetPropString( item, "m_iClassname" )

			local event_hook_string = format( "CannotUpgrade_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( PopExtUtil.InUpgradeZone( player ) )
				{
					if ( GetPropInt( item, STRING_NETPROP_ITEMDEF ) != -1 && player.GetActiveWeapon() == item )
						ClientPrint( player, HUD_PRINTCENTER, "This weapon cannot be upgraded" )

					SetPropInt( item, STRING_NETPROP_ITEMDEF, -1 )
					SetPropString( item, "m_iClassname", "" )
					return
				}
				SetPropString( item, "m_iClassname", classname )
				SetPropInt( item, STRING_NETPROP_ITEMDEF, index )
			}

			player.GetScriptScope().attribinfo[ "cannot upgrade" ] <- "Weapon cannot be upgraded"
		}

		function AlwaysCrit( player, item, value = null )
		{
			local event_hook_string = format( "AlwaysCrit_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() == item )
					player.AddCondEx( COND_CRITBOOST, 0.033, player )
			}

			player.GetScriptScope().attribinfo[ "always crit" ] <- "Weapon always crits"
		}

		function AddCondWhenActive( player, item, value )
		{
			local duration = typeof value == "array" ? value[ 1 ].tofloat() : 0.033

			local event_hook_string = format( "AddCondWhenActive_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() == item )
					player.AddCondEx( value, duration, player )
			}

			local desc_string = duration != 0.033 ?
			format( "On deploy: player receives cond %d for %.2f seconds", value[ 0 ].tointeger(), value[ 1 ].tofloat() ) :
			format( "When active: player receives cond %d", value )
			player.GetScriptScope().attribinfo[ "add cond when active" ] <- desc_string
		}

		function DontCountDamageTowardsCritRate( player, item, value = null )
		{
			local event_hook_string = format( "DontCountDamageTowardsCritRate_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon != item )
					return params.damage_type = params.damage_type | DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE
			})

			player.GetScriptScope().attribinfo[ "dont count damage towards crit rate" ] <- "Damage doesn't count towards crit rate"
		}

		function NoDamageFalloff( player, item, value = null )
		{
			local event_hook_string = format( "NoDamageFalloff_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon != item )
					return params.damage_type = params.damage_type & ~DMG_USEDISTANCEMOD
			})

			player.GetScriptScope().attribinfo[ "no damage falloff" ] <- "Weapon has no damage fall-off or ramp-up"
		}

		function CanHeadshot( player, item, value = null )
		{
			local event_hook_string = format( "CanHeadshot_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity
				if ( params.weapon != item || !victim.IsPlayer() || GetPropInt( victim, "m_LastHitGroup" ) != HITGROUP_HEAD )
					return

				params.damage_type = params.damage_type | DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_HEADSHOT
			})

			player.GetScriptScope().attribinfo[ "can headshot" ] <- "Crits on headshot"
		}

		function CannotHeadshot( player, item, value = null )
		{
			local event_hook_string = format( "CannotHeadshot_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon != item || params.damage_stats != TF_DMG_CUSTOM_HEADSHOT )
					return

				params.damage_type = params.damage_type & ~DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_NONE
			})

			player.GetScriptScope().attribinfo[ "cannot headshot" ] <- "weapon cannot headshot"
		}

		function CannotBeHeadshot( player, item, value = null )
		{
			local event_hook_string = format( "CannotBeHeadshot_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local scope = params.const_entity.GetScriptScope()

				if ( !params.const_entity.IsPlayer() || !( "cannot be headshot" in player.GetScriptScope().attribinfo ) )
					return

				params.damage_type = params.damage_type & ~DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_NONE
			})

			player.GetScriptScope().attribinfo[ "cannot be headshot" ] <- "Immune to headshots"
		}

		function ProjectileLifetime( player, item, value )
		{
			local event_hook_string = format( "ProjectileLifetime_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() != item )
					return

				// will spew "DoEntFire was passed an invalid entity instance" if projectile dies before this delay but this is harmless afaik
				for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
					if ( projectile.GetOwner() == player || ( HasProp( projectile, "m_hThrower" ) && GetPropEntity( projectile, "m_hThrower" ) == player && GetPropEntity( projectile, "m_hLauncher" ) == item ) )
						EntFireByHandle( projectile, "Kill", "", value, null, null )
			}

			player.GetScriptScope().attribinfo[ "projectile lifetime" ] <- format( "projectile disappears after %.2f seconds", value.tofloat() )
		}

		function MultDmgVsGiants( player, item, value )
		{
			local event_hook_string = format( "MultDmgVsGiants_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity, attacker = params.attacker

				if ( victim.IsPlayer() && victim.IsMiniBoss() && params.weapon == item )
					params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "mult dmg vs giants" ] <- format( "Damage vs giants multiplied by %.2f", value.tofloat() )
		}

		function MultDmgVsTanks( player, item, value )
		{
			local event_hook_string = format( "MultDmgVsTanks_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local victim = params.const_entity, attacker = params.attacker

				if ( victim.GetClassname() == "tank_boss" && params.weapon == item )
					params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "mult dmg vs tanks" ] <- format( "Damage vs tanks multiplied by %.2f", value.tofloat() )
		}

		function SetDamageType( player, item, value )
		{
			local event_hook_string = format( "SetDamageType_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon == item )
					params.damage_type = value
			})

			player.GetScriptScope().attribinfo[ "set damage type" ] <- format( "Damage type set to %d", value )
		}

		function SetDamageTypeCustom( player, item, value )
		{
			local event_hook_string = format( "SetDamageTypeCustom_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon == item )
					params.damage_stats = value
			})

			player.GetScriptScope().attribinfo[ "set damage type custom" ] <- format( "Custom damage type set to %d", value )
		}

		function PassiveReload( player, item, value = null )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "PassiveReload_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				// weapon ent has been destroyed, reference is still valid but the entity isn't
				if ( item && !item.IsValid() )
				{
					delete scope.ItemThinkTable[ event_hook_string ]
					return
				}

				if ( player.GetActiveWeapon() == item )
					return

				local ammo = GetPropIntArray( player, "m_iAmmo", item.GetSlot() + 1 )

				if ( player.GetActiveWeapon() != item && item.Clip1() != item.GetMaxClip1() )
				{
					if ( !( "ReverseMVMDrainAmmoThink" in scope.ItemThinkTable ) ) // already takes care of this
						SetPropIntArray( player, "m_iAmmo", ammo - ( item.GetMaxClip1() - item.Clip1() ), item.GetSlot() + 1 )

					item.SetClip1( item.GetMaxClip1() )
				}
			}

			player.GetScriptScope().attribinfo[ "passive reload" ] <- "weapon reloads when holstered"
		}

		function CollectCurrencyOnKill( player, item, value )
		{
			item.ValidateScriptScope()
			local scope = item.GetScriptScope()
			scope.collectCurrencyOnKill <- true

			player.GetScriptScope().attribinfo[ "collect currency on kill" ] <- "bots drop money when killed"
		}

		function RocketPenetration( player, item, value )
		{
			local event_hook_string = format( "RocketPenetration_%d_%d", player.GetScriptScope().userid, item.entindex() )

			if ( ROCKET_LAUNCHER_CLASSNAMES.find( item.GetClassname() ) == null )
				return

			local scope = item.GetScriptScope()

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				local entity = params.const_entity
				if ( !entity.IsPlayer() )
					return

				local inflictor = params.inflictor

				inflictor.ValidateScriptScope()
				local inflictorScope = inflictor.GetScriptScope()

				if ( !( "isPenetrateMimicRocket" in inflictorScope ) )
					return

				params.player_penetration_count = inflictorScope.penetrationCount // change killicon to penetratt least 1 enemy
			})

			item.ValidateScriptScope()
			local weaponScriptScope = item.GetScriptScope()
			weaponScriptScope.last_fire_time <- 0.0
			weaponScriptScope.forceAttacking <- false

			weaponScriptScope.maxPenetration <- value

			weaponScriptScope.CheckWeaponFire <- function()
			{
				local fire_time = GetPropFloat( self, "m_flLastFireTime" )
				if ( fire_time > last_fire_time && !forceAttacking )
				{
					local owner = self.GetOwner()
					if ( owner )
					{
						OnShot( owner )
					}

					last_fire_time = fire_time
				}
				return
			}
			weaponScriptScope.FindRocket <- function( owner )
			{
				local entity = null
				for ( local entity; entity = FindByClassnameWithin( entity, "tf_projectile_*", owner.GetOrigin(), 100 ); )
				{
					if ( entity.GetOwner() != owner )
					{
						continue
					}

					entity.ValidateScriptScope()
					if ( "chosenAsPenetrationRocket" in entity.GetScriptScope() )
						continue

					entity.GetScriptScope().chosenAsPenetrationRocket <- true

					return entity
				}

				return null
			}
			weaponScriptScope.ApplyPenetrationToRocket <- function( owner, rocket )
			{
				rocket.SetSolid( SOLID_NONE )

				rocket.ValidateScriptScope()
				local rocketScope = rocket.GetScriptScope()
				rocketScope.isCustomRocket <- true
				rocketScope.lastRocketOrigin <- rocket.GetOrigin()
				rocketScope.maxPenetration <- maxPenetration

				rocketScope.collidedTargets <- []
				rocketScope.penetrationCount <- 0
				rocketScope.DetonateRocket <- function()
				{
					local owner = self.GetOwner()
					local launcher = GetPropEntity( self, "m_hLauncher" )

					local charge = GetPropFloat( owner, "m_Shared.m_flItemChargeMeter" )
					local nextAttack = GetPropFloat( launcher, "m_flNextPrimaryAttack" )
					local lastFire = GetPropFloat( launcher, "m_flLastFireTime" )
					local clip = launcher.Clip1()
					local energy = GetPropFloat( launcher, "m_flEnergy" )

					launcher.GetScriptScope().forceAttacking = true

					launcher.SetClip1( 99 )
					SetPropFloat( owner, "m_Shared.m_flItemChargeMeter", 100.0 )
					SetPropBool( owner, "m_bLagCompensation", false )
					SetPropFloat( launcher, "m_flNextPrimaryAttack", 0 )
					SetPropFloat( launcher, "m_flEnergy", 100.0 )

					launcher.AddAttribute( "crit mod disabled hidden", 1, -1 )
					launcher.PrimaryAttack()
					launcher.RemoveAttribute( "crit mod disabled hidden" )

					launcher.GetScriptScope().forceAttacking = false
					launcher.SetClip1( clip )
					SetPropBool( owner, "m_bLagCompensation", true )
					SetPropFloat( launcher, "m_flNextPrimaryAttack", nextAttack )
					SetPropFloat( launcher, "m_flEnergy", energy )
					SetPropFloat( launcher, "m_flLastFireTime", lastFire )
					SetPropFloat( owner, "m_Shared.m_flItemChargeMeter", charge )

					for ( local entity; entity = FindByClassnameWithin( entity, "tf_projectile_*", owner.GetOrigin(), 100 ); )
					{
						if ( entity.GetOwner() != owner )
						{
							continue
						}

						if ( "isCustomRocket" in entity.GetScriptScope() )
							continue

						SetPropBool( self, "m_bCritical", GetPropBool( self, "m_bCritical" ) )
						entity.SetAbsOrigin( self.GetOrigin() )

						entity.ValidateScriptScope()
						entity.GetScriptScope().isPenetrateMimicRocket <- true
						entity.GetScriptScope().originalRocket <- self
						entity.GetScriptScope().penetrationCount <- ( self.GetScriptScope().penetrationCount - 1 )

						break
					}
				} if ( !( "ProjectileThinkTable" in rocketScope ) ) rocketScope.ProjectileThinkTable <-  {}

				rocketScope.ProjectileThinkTable.RocketThink <- function()
				{
					local origin = self.GetOrigin()

					traceTableWorldSpawn <-
					{
						start = lastRocketOrigin
						end = origin + ( self.GetForwardVector() * 50 )
						mask = MASK_SOLID_BRUSHONLY
						ignore = self.GetOwner()
					}

					TraceLineEx( traceTableWorldSpawn )

					if ( traceTableWorldSpawn.hit && traceTableWorldSpawn.enthit )
					{
						self.SetSolid( SOLID_BBOX )
						delete self.GetScriptScope().ProjectileThinkTable.RocketThink
					}

					traceTable <-
					{
						start = lastRocketOrigin
						end = origin
						ignore = self.GetOwner()
					}

					TraceLineEx(traceTable)

					lastRocketOrigin = origin

					if ( !traceTable.hit )
						return

					if ( !traceTable.enthit )
						return

					if ( traceTable.enthit.GetTeam() == player.GetTeam() )
						return

					if ( collidedTargets.find( traceTable.enthit ) != null )
						return

					collidedTargets.append( traceTable.enthit )
					penetrationCount++

					// arrow free penetration through allies without detonating
					if ( traceTable.enthit.GetTeam() != player.GetTeam() )
						penetrationCount++

					if ( penetrationCount > ( maxPenetration + 1 ) )
					{
						self.SetSolid( SOLID_BBOX )
						if ( "RocketThink" in rocketScope.ProjectileThinkTable )
							delete rocketScope.ProjectileThinkTable.RocketThink

						return
					}

					if ( traceTable.enthit.GetTeam() != player.GetTeam() )
						DetonateRocket()

					return
				}
			}
			weaponScriptScope.OnShot <- function( owner )
			{
				local rocket = FindRocket( owner )

				if ( !rocket )
				{
					return
				}

				// don't apply penetration to cowmangler charge shot, because unfortunately it doesn't work :(
				if ( GetPropBool( rocket, "m_bChargedShot" ) )
					return

				ApplyPenetrationToRocket( owner, rocket )
			}

			PopExtUtil.AddThinkToEnt( item, "CheckWeaponFire" )

			player.GetScriptScope().attribinfo[ "rocket penetration" ] <- format( "rocket penetrates up to %d enemy players", value )
		}

		function ReloadsFullClipAtOnce( player, item, value = null )
		{
			local scope = item.GetScriptScope()
			scope.lastClip <- item.Clip1() // thanks to seelpit for detectreload logic

			local event_hook_string = format( "ReloadsFullClipAtOnce_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				local currentClip = item.Clip1()
				local wepSlot = item.GetSlot() + 1

				if ( currentClip > lastClip )
				{
					item.SetClip1( item.GetMaxClip1() )
					local ammoDeducted = ( item.GetMaxClip1() - currentClip )
					local currentAmmo = GetPropIntArray( player, "m_iAmmo", wepSlot )
					SetPropIntArray( player, "m_iAmmo", currentAmmo - ammoDeducted, wepSlot )
					currentClip = item.Clip1()
				}
				lastClip = currentClip
			}

			player.GetScriptScope().attribinfo[ "reloads full clip at once" ] <- "This weapon reloads its entire clip at once."
		}

		function MultProjectileScale( player, item, value )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "MultProjectileScale_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "mult projectile scale" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
					if ( projectile.GetOwner() == player && projectile.GetModelScale() != value )
						projectile.SetModelScale( value, 0.0 )
			}

			player.GetScriptScope().attribinfo[ "mult projectile scale" ] <- format( "projectile scale multiplied by %.2f", value.tofloat() )
		}

		// this needs to be looked at
		function MultBuildingScale( player, item, value )
		{
			local scope = item.GetScriptScope()

			if ( !( "BuiltObjectTable" ) in scope )
				return

			scope.BuiltObjectTable.MultBuildingScale <- function( params )
			{
				local building = EntIndexToHScript( params.index )
				if ( GetPropEntity( building, "m_hBuilder" ) == player && "mult building scale" in player.GetScriptScope().attribinfo )
					building.SetModelScale( value, 0.0 )
			}

			player.GetScriptScope().attribinfo[ "mult building scale" ] <- format( "building scale multiplied by %.2f", value.tofloat() )
		}

		function MultCritDmg( player, item, value )
		{
			local event_hook_string = format( "MultCritDmg_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.damage_type & DMG_CRITICAL )
					params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "mult crit dmg" ] <- format( "critical damage multiplied by %.2f", value.tofloat() )
		}

		function ArrowIgnite( player, item, value = null )
		{
			local event_hook_string = format( "ArrowIgnite_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() != item )
					return

				if ( HasProp( item, "m_bArrowAlight" ) && !GetPropBool( item, "m_bArrowAlight" ) )
					SetPropBool( item, "m_bArrowAlight", true )
			}

			player.GetScriptScope().attribinfo[ "arrow ignite" ] <- "arrows are always ignited"
		}

		function NoclipProjectile( player, item, value )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "NoclipProjectile_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "noclip projectile" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
					if ( projectile.GetOwner() == player && projectile.GetMoveType != MOVETYPE_NOCLIP )
						projectile.SetMoveType( MOVETYPE_NOCLIP, MOVECOLLIDE_DEFAULT )
			}

			player.GetScriptScope().attribinfo[ "noclip projectile" ] <- "projectiles go through walls and enemies harmlessly"
		}

		function ProjectileGravity( player, item, value )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "ProjectileGravity_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "projectile gravity" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
				{
					if ( projectile.GetOwner() == player )
					{
						local currentVelocity = projectile.GetAbsVelocity()
						currentVelocity -= Vector( 0, 0, value )

						projectile.SetAbsVelocity( currentVelocity )

						local faceDirection = projectile.GetForwardVector()
						self.SetLocalAngles( PopExtUtil.VectorAngles( faceDirection ) )
					}
				}
			}

			player.GetScriptScope().attribinfo[ "projectile gravity" ] <- format( "projectile gravity %.2f hu/s", value.tofloat() )
		}

		function ImmuneToCond( player, item, value )
		{
			local event_hook_string = format( "ImmuneToCond_%d_%d", player.GetScriptScope().userid, item.entindex() )

			item.GetScriptScope().ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( player.GetActiveWeapon() != item )
					return

				if ( typeof value == "array" )
				{
					foreach ( cond in value )
					{
						player.RemoveCondEx( cond, true )
					}
					return
				}
				player.RemoveCondEx( value, true )
			}

			if ( typeof value == "integer" )
			{
				player.GetScriptScope().attribinfo[ "immune to cond" ] <- format( "wielder is immune to cond %d", value )
			}
			else
			{
				local outputString = ""
				foreach ( cond in value )
				{
					outputString += ( cond.tostring() + ", " )
				}
				local finalCommaAndSpace = 2
				outputString = outputString.slice( 0, outputString.len() - finalCommaAndSpace )
				player.GetScriptScope().attribinfo[ "immune to cond" ] <- format( "wielder is immune to cond %s", outputString )
			}
		}

		function MultMaxHealth( player, item, value )
		{
			item.RemoveAttribute( "SET BONUS: max health additive bonus" )
			local addHPAmount = player.GetMaxHealth() * ( value - 1 )
			item.AddAttribute( "SET BONUS: max health additive bonus", addHPAmount, -1 )

			player.GetScriptScope().attribinfo[ "mult max health" ] <- format( "max health multiplied by %.2f", value.tofloat() )
		}

		function CustomKillIcon( player, item, value )
		{
			local event_hook_string = format( "CustonKillIcon_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( params.weapon != item || player.GetActiveWeapon() != item )
					return

				local killicon_dummy = CreateByClassname( "info_teleport_destination" )
				SetPropString( killicon_dummy, "m_iName", format( "killicon_dummy_%d_%d", player.GetScriptScope().userid, item.entindex() ) )
				SetPropString( killicon_dummy, "m_iClassname", value )
				params.inflictor = killicon_dummy
			})

			PopExtEvents.AddRemoveEventHook( "player_hurt", event_hook_string, function( params )
			{
				EntFire( format( "killicon_dummy_%d_%d", player.GetScriptScope().userid, item.entindex() ), "Kill" )
			})

			player.GetScriptScope().attribinfo[ "custom kill icon" ] <- format( "custom kill icon: %s", value )
		}

		function SetWarpaintSeed( player, item, value )
		{
			local seed = value.tointeger()

			if ( _intsize_ == 8 )
			{
				// This will overflow a Squirrel int as they're signed, but we don't care
				//  since we only want the bits; the value is irrelevant.
				item.AddAttribute( "custom_paintkit_seed_lo", casti2f( seed & 0xFFFFFFFF ), -1 )
				item.AddAttribute( "custom_paintkit_seed_hi", casti2f( seed >> 32 ), -1 )
			}
			else
			{
				// Decompose a 64-bit decimal seed string in to four 16-bit integers,
				//  and then compile the resulting integers to two 32 bit integers.
				local seed = value.tostring()
				local strlen = seed.len()
				local digitstore = array( strlen, 0 )

				for ( local i = 0; i < strlen; ++i )
				{
					local carry = seed[ i ] - 48
					local tmp = 0

					for ( local i = ( strlen - 1 ); ( i >= 0 ); --i )
					{
						tmp = ( digitstore[ i ] * 10 ) + carry
						digitstore[ i ] = tmp & 0xFFFF
						carry = tmp >> 16
					}
				}

				item.AddAttribute( "custom_paintkit_seed_lo", casti2f( digitstore[ strlen - 2 ] << 16 | digitstore[ strlen - 1 ] ), -1 )
				item.AddAttribute( "custom_paintkit_seed_hi", casti2f( digitstore[ strlen - 4 ] << 16 | digitstore[ strlen - 3 ] ), -1 )
			}
			item.ReapplyProvision()

			player.GetScriptScope().attribinfo[ "set warpaint seed" ] <- format( "warpaint seed: %d", value.tointeger() )
		}

		function MinRespawnTime( player, item, value )
		{
			player.GetScriptScope().attribinfo[ "min respawn time" ] <- format( "Respawn time: %d", value.tointeger() )
		}

		function SpecialItemDescription( player, item, value )
		{
			player.GetScriptScope().attribinfo[ "special item description" ] <- format( "%s", value )
		}

		// REIMPLEMENTED VANILLA ATTRIBUTES

		function AltFireDisabled( player, item, value = null )
		{
			local scope = item.GetScriptScope()

			local event_hook_string = format( "AltFireDisabled_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( "alt-fire disabled" in player.GetScriptScope().attribinfo && player.GetActiveWeapon() == item )
				{
					SetPropInt( player, "m_afButtonDisabled", IN_ATTACK2 )
					SetPropFloat( item, "m_flNextSecondaryAttack", INT_MAX )
					return
				}
				SetPropInt( player, "m_afButtonDisabled", 0 )
			}

			PopExtEvents.AddRemoveEventHook( "post_inventory_application", event_hook_string, function( params )
			{
				SetPropInt( GetPlayerFromUserID( params.userid ), "m_afButtonDisabled", 0 )
			})

			player.GetScriptScope().attribinfo[ "alt-fire disabled" ] <- "Secondary fire disabled"
		}

		function CustomProjectileModel( player, item, value )
		{
			local projmodel = PrecacheModel( value )

			local scope = item.GetScriptScope()

			local event_hook_string = format( "CustomProjectileModel_%d_%d", player.GetScriptScope().userid, item.entindex() )

			scope.ItemThinkTable[ event_hook_string ] <- function()
			{
				if ( !( "custom projectile model" in player.GetScriptScope().attribinfo ) || player.GetActiveWeapon() != item )
					return

				for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); )
					if ( projectile.GetOwner() == player && GetPropInt( projectile, "m_nModelIndex" ) != projmodel )
						projectile.SetModel( value )
			}

			player.GetScriptScope().attribinfo[ "custom projectile model" ] <- format( "custom projectile model set to %s", value )
		}

		function DmgBonusWhileHalfDead( player, item, value )
		{
			local event_hook_string = format( "DmgBonusWhileHalfDead_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( !( "dmg bonus while half dead" in player.GetScriptScope().attribinfo ) || params.weapon != item || player.GetActiveWeapon() != item )
					return

				if ( player.GetHealth() < player.GetMaxHealth() / 2 )
					params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "dmg bonus while half dead" ] <- format( "%d⁒ damage bonus while under half health", ( value.tofloat() * 100 ).tointeger() )
		}

		function DmgPenaltyWhileHalfAlive( player, item, value )
		{
			local event_hook_string = format( "DmgPenaltyWhileHalfAlive_%d_%d", player.GetScriptScope().userid, item.entindex() )

			PopExtEvents.AddRemoveEventHook( "OnTakeDamage", event_hook_string, function( params )
			{
				if ( !( "dmg penalty while half alive" in player.GetScriptScope().attribinfo ) || params.weapon != item || player.GetActiveWeapon() != item )
					return

				if ( player.GetHealth() > player.GetMaxHealth() / 2 )
					params.damage *= value
			})

			player.GetScriptScope().attribinfo[ "dmg penalty while half alive" ] <- format( "%d⁒ damage penalty while above half health", ( value.tofloat() * 100 ).tointeger() )
		}
	}

	function AddAttr( player, attr_string, value = 0, item = null )
	{
		PopExtMain.Error.DeprecationWarning( "CustomAttributes::AddAttr.  Unless you're passing a table or array,", "PopExtUtil::SetPlayerAttributes" )

		local attr = split( attr_string, " ", true ).len() > 1 ? GetAttributeFunctionFromStringName( attr_string ) : attr_string

		local item_table = {}

		// no item, just apply to the active weapon
		if ( item == null ) item = player.GetActiveWeapon()

		switch ( typeof item )
		{
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
			PopExtMain.Error.RaiseValueError( "Invalid item (" + item + ") passed to CustomAttributes::AddAttr!" )
			break
		}

		// easy access table in player scope for our items and their attributes
		player.GetScriptScope().CustomAttrItems <- item_table

		// cleanup any previous attribute functions from these CustomAttributes event hooks
		local t = [ "TakeDamageTable", "TakeDamagePostTable", "SpawnHookTable", "DeathHookTable", "PlayerTeleportTable" ]
		foreach ( tablename in t )
			foreach ( table, func in CustomAttributes[ tablename ] )
				if ( tablename in CustomAttributes )
					CustomAttributes.CleanupFunctionTable( player, table, attr )

		// cleanup item thinks
		foreach ( item, _ in item_table )
			CustomAttributes.CleanupFunctionTable( item, "ItemThinkTable", attr )

		local scope = player.GetScriptScope()
		if ( !( "attribinfo" in scope ) )
			scope.attribinfo <- {}

		foreach ( item, attrs in item_table )
		{
			local item = PopExtUtil.HasItemInLoadout( player, item )

			if ( item == null || !( attr in CustomAttributes.Attrs ) )
				continue

			CustomAttributes.Attrs[ attr ]( player, item, value )

			CustomAttributes.RefreshDescs( player )
		}
	}

	function RefreshDescs( player )
	{
		local cooldowntime = 3.0

		local scope = player.GetScriptScope()
		local formattedtable = []

		foreach ( desc, attr in scope.attribinfo )
			if ( !formattedtable.find( attr ) )
				formattedtable.append( format( "%s:\n\n%s\n\n\n", desc, attr ) )

		local i = 0
		scope.PlayerThinkTable.ShowAttribInfo <- function()
		{
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
	}

	function GetAttributeFunctionFromStringName( attr )
	{
		local special_names =
		{
			"alt-fire disabled" : "AltFireDisabled",
			"mult teleporter recharge rate" : "TeleporterRechargeTime",
		}
		if ( attr in special_names )
			return special_names[ attr ]

		local str = ""
		split( attr, " " ).apply( @(s) str += format( "%s%s", s.slice(0, 1).toupper(), s.slice(1, s.len()) ) )
		return str
	}

	function CleanupFunctionTable( handle, table, attr )
	{
		local str = GetAttributeFunctionFromStringName( attr )

		foreach ( name, v in table )
			if ( typeof v == "function" && startswith( name, format( "%s_%d", str, handle.GetScriptScope().userid ) ) )
				delete table[ format( "%s", name ) ]
	}
}

// TODO: deprecate the old namespace.
::PopExtAttributes <- CustomAttributes