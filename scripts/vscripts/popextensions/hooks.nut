pop_ext_entity <- FindByName( null, "__popext" )
if ( pop_ext_entity == null ) pop_ext_entity = SpawnEntityFromTable( "info_teleport_destination", { targetname = "__popext" } )

pop_ext_entity.ValidateScriptScope()
PopExt <- pop_ext_entity.GetScriptScope()

::PopExtHooks <- {

	tank_icons = []
	icons 	  = []

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

				if ( hook_name == "Model" || hook_name == "TankModel" ) {
					local model_names = typeof func == "string" ? {} : func

					if ( typeof func == "string" ) {
						model_names.Default <- func
						model_names.Damage1 <- func
						model_names.Damage2 <- func
						model_names.Damage3 <- func
					}
					scope.pop_property[hook_name] <- model_names

					local model_names_precached = {}
					foreach( k, v in model_names )
						model_names_precached[k] <- PrecacheModel( v )
					scope.pop_property.ModelPrecached <- model_names_precached
				}
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

	Events = {

		function OnScriptHook_OnTakeDamage( params ) {

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
		}

		function OnGameEvent_player_spawn( params ) {

			local player = GetPlayerFromUserID( params.userid )
			local scope = player.GetScriptScope()

			if ( scope != null && "pop_wearables_to_destroy" in scope ) {
				foreach( wearable in scope.pop_wearables_to_destroy )
					if ( wearable.IsValid() )
						EntFireByHandle( wearable, "Kill", "", -1, null, null )

				delete scope.pop_wearables_to_destroy
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

		}

		function OnGameEvent_player_team( params ) {

			if ( params.team != TEAM_SPECTATOR ) return

			local player = GetPlayerFromUserID( params.userid )

			if ( !player ) return //can sometimes be null when the server empties out?

			local scope = player.GetScriptScope()

			if ( scope != null && "pop_wearables_to_destroy" in scope ) {
				foreach( wearable in scope.pop_wearables_to_destroy )
					if ( wearable.IsValid() )
						EntFireByHandle( wearable, "Kill", "", -1, null, null )

				delete scope.pop_wearables_to_destroy
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
		}

		function OnGameEvent_player_hurt( params ) {

			local victim = GetPlayerFromUserID( params.userid )
			local scope = victim.GetScriptScope()

			PopExtHooks.FireHooksParam( victim, scope, "OnTakeDamagePost", params )

			local attacker = GetPlayerFromUserID( params.attacker )

			if ( attacker != null ) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam( attacker, scope, "OnDealDamagePost", params )
			}
		}

		function OnGameEvent_player_death( params ) {

			local player = GetPlayerFromUserID( params.userid )
			local scope = player.GetScriptScope()
			scope.popFiredDeathHook <- true
			PopExtHooks.FireHooksParam( player, scope, "OnDeath", params )


			local attacker = GetPlayerFromUserID( params.attacker )
			if ( attacker != null ) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam( attacker, scope, "OnKill", params )
			}
		}

		function OnGameEvent_npc_hurt( params ) {

			local victim = EntIndexToHScript( params.entindex )
			if ( victim.GetClassname() == "tank_boss" ) {
				local scope = victim.GetScriptScope()
				local dead  = ( victim.GetHealth() - params.damageamount ) <= 0

				PopExtHooks.FireHooksParam( victim, scope, "OnTakeDamagePost", params )

				if ( dead && "pop_property" in scope ) {

					local pop_property = scope.pop_property
					if ( "SoundOverrides" in pop_property ) {

						local sound_overrides = pop_property.SoundOverrides

						if ( "Explodes" in sound_overrides ) {

							StopSoundOn( "MVM.TankExplodes", PopExtUtil.Worldspawn )
							EntFire( "tf_gamerules", "PlayVO", sound_overrides.Explodes )
						}
					}
					if ( "NoDeathFX" in pop_property && pop_property.NoDeathFX > 0 ) {

						victim.SetAbsOrigin( victim.GetOrigin() - Vector( 0, 0, 10000 ) )

						local has_explode_sound = "SoundOverrides" in pop_property && "Explodes" in pop_property.SoundOverrides && pop_property.SoundOverrides.Explodes

						local temp = CreateByClassname( "info_teleport_destination" )
						temp.KeyValueFromString( "targetname", "__popext_temp_nodeathfx" )
						temp.SetAbsOrigin( victim.GetOrigin() )
						temp.ValidateScriptScope()
						temp.GetScriptScope().FindTankDestructionEnt <- function() {

							for ( local destruction; destruction = FindByClassnameWithin( destruction, "tank_destruction", self.GetOrigin(), 1 ); ) {

								if ( pop_property.NoDeathFX == 2 && !has_explode_sound )
									StopSoundOn( "MVM.TankExplodes", PopExtUtil.Worldspawn )

								EntFireByHandle( destruction, "Kill", "", -1, null, null )
								self.Kill()
								return 1
							}

							return -1
						}
						AddThinkToEnt( temp, "FindTankDestructionEnt" )
					}
					if ( "IsBlimp" in pop_property && pop_property.IsBlimp )
						EntFireByHandle( scope.blimpTrain, "Kill", "", -1, null, null )
				}

				if ( dead && scope && !( "popFiredDeathHook" in scope ) ) {

					scope.popFiredDeathHook <- true

					if ( "pop_property" in scope && "Icon" in scope.pop_property ) {

						local icon = scope.pop_property.Icon
						local flags = MVM_CLASS_FLAG_NORMAL

						if ( !( "isBoss" in icon ) || icon.isBoss )
							flags = flags | MVM_CLASS_FLAG_MINIBOSS

						if ( "isCrit" in icon && icon.isCrit )
							flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT

						// Compensate for the decreasing of normal tank icon
						local icon_name = typeof icon == "string" ? icon : icon.name
						if ( PopExt.GetWaveIconSpawnCount( "tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL ) > 0 && PopExt.GetWaveIconSpawnCount( icon_name, flags ) > 0 )
							PopExt.IncrementWaveIconSpawnCount( "tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1, false )

						// Decrement custom tank icon when killed.
						PopExt.DecrementWaveIconSpawnCount( icon_name, flags, 1, false )
					}

					PopExtHooks.FireHooksParam( victim, scope, "OnDeath", params )
				}
			}
		}

		function OnGameEvent_mvm_begin_wave( params ) {

			if ( "waveIconsFunction" in PopExt )
				PopExt.waveIconsFunction()

			foreach( v in PopExtHooks.tank_icons )
				PopExt._PopIncrementTankIcon( v )

			foreach( v in PopExtHooks.icons )
				PopExt._PopIncrementIcon( v )
		}

		function OnGameEvent_recalculate_holidays( params ) {

			if ( "waveIconsFunction" in PopExt )
				delete PopExt.waveIconsFunction

			PopExtHooks.tank_icons <- []
			PopExtHooks.icons     <- []
		}
	}
}
__CollectGameEventCallbacks( PopExtHooks.Events )

function PopExtGlobalThink() {

	if ( !PopExtUtil.IsWaveStarted )
		return 0.2

	for ( local tank; tank = FindByClassname( tank, "tank_boss" ); ) {

		tank.ValidateScriptScope()
		local scope = tank.GetScriptScope()

		if ( !( "created" in scope ) ) {

			scope.created         <- true
			scope.TankThinkTable  <- {}
			scope.max_health       <- tank.GetMaxHealth()
			scope.team            <- tank.GetTeam()
			scope.teamchanged     <- false
			scope.engineloopreplaced <- false

			scope.cur_health       <- tank.GetHealth()
			scope.last_health_stage <- 0
			scope.TankThinkTable.Updates <- function() {
				cur_pos            <- self.GetOrigin()
				cur_vel            <- self.GetAbsVelocity()
				cur_speed          <- cur_vel.Length()
				last_health_percentage <- GetPropFloat( self, "m_lastHealthPercentage" )
			}

			local tank_name = tank.GetName().tolower()

			foreach( name, table in tank_names_wildcard )
				if ( startswith( tank_name, name ) )
					PopExtHooks.AddHooksToScope( tank_name, table, scope )

			if ( tank_name in tank_names )
				PopExtHooks.AddHooksToScope( tank_name, tank_names[tank_name], scope )

			if ( "pop_property" in scope ) {

				if ( "TankModel" in scope.pop_property )  {

					scope.pop_property.Model <- scope.pop_property.TankModel
					delete scope.pop_property.TankModel
				}

				if ( "TankModelVisionOnly" in scope.pop_property ) {

					scope.pop_property.ModelVisionOnly <- scope.pop_property.TankModelVisionOnly
					delete scope.pop_property.TankModelVisionOnly
				}

				if ( "SoundOverrides" in scope.pop_property ) {

					foreach ( k, v in scope.pop_property.SoundOverrides )
						PrecacheSound( v )

					local sound_overrides = scope.pop_property.SoundOverrides

					if ( "Destroy" in sound_overrides )
						scope.pop_property.SoundOverrides.Explodes <- sound_overrides.Destroy

					__DumpScope( 0, scope.pop_property )
					local cooldowntime = 0.0
					if ( "Ping" in sound_overrides ) {

						scope.TankThinkTable.PingSound <- function() {
							StopSoundOn( "MVM.TankPing", self )

							if ( Time() < cooldowntime ) return

							EmitSoundEx( {sound_name = sound_overrides.Ping, entity = tank} )

							cooldowntime = Time() + 5.0
						}
					}
					if ( "EngineLoop" in sound_overrides && !scope.engineloopreplaced ) {

						StopSoundOn( "MVM.TankEngineLoop", tank )
						EmitSoundEx( {sound_name = sound_overrides.EngineLoop, entity = tank} )

						PopExtUtil.SetDestroyCallback( tank, function() {
							// needs both of these?
							self.StopSound( sound_overrides.EngineLoop )
							EmitSoundEx( {sound_name = sound_overrides.EngineLoop, entity = self, flags = SND_STOP} )
						})

						scope.engineloopreplaced = true
					}
					if ( "Start" in sound_overrides ) {
						StopSoundOn( "MVM.TankStart", tank )
						EmitSoundEx( {sound_name = sound_overrides.Start, entity = tank} )
						delete scope.pop_property.SoundOverrides.Start
					}
					if ( "Deploy" in sound_overrides ) {

						//tank becomes a null reference when we start deploying
						//store the sound in a variable to still play it, then delete the think function when this happens

						local deploysound = sound_overrides.Deploy

						scope.TankThinkTable.DeploySound <- function() {

							if ( self.GetSequence() != self.LookupSequence( "deploy" ) ) return

							StopSoundOn( "MVM.TankDeploy", self )

							if ( "EngineLoop" in sound_overrides )
								EmitSoundEx( {sound_name = sound_overrides.EngineLoop, entity = tank, flags = SND_STOP} )

							EmitSoundEx( {sound_name = deploysound, entity = tank} )

							if ( tank == null ) {

								delete scope.TankThinkTable.DeploySound
								return
							}

							delete scope.pop_property.SoundOverrides.Deploy
						}
					}
				}

				if ( "Team" in scope.pop_property && !scope.teamchanged ) {

					switch( scope.pop_property.Team.tostring().toupper() ) {
						case "RED":
							scope.pop_property.Team = TF_TEAM_PVE_DEFENDERS
							break
						case "BLU":
						case "BLUE":
							scope.pop_property.Team = TF_TEAM_PVE_INVADERS
							break
						case "GRY":
						case "GRAY":
						case "GREY":
						case "SPEC":
						case "SPECTATOR":
							scope.pop_property.Team = TEAM_SPECTATOR
					}
					tank.SetTeam( scope.pop_property.Team )
					scope.teamchanged = true
					scope.team = tank.GetTeam()
				}

				if ( "NoScreenShake" in scope.pop_property && scope.pop_property.NoScreenShake )
					scope.TankThinkTable.NoScreenShake <- @() ScreenShake( tank.GetOrigin(), 25.0, 5.0, 5.0, 1000.0, SHAKE_STOP, true )

				if ( "IsBlimp" in scope.pop_property && scope.pop_property.IsBlimp ) {

					//todo fix rage on same team tank
					if ( !( "DisableTracks" in scope.pop_property ) )
						scope.pop_property.DisableTracks <- true
					if ( !( "DisableBomb" in scope.pop_property ) )
						scope.pop_property.DisableBomb <- true
					if ( !( "DisableSmoke" in scope.pop_property ) )
						scope.pop_property.DisableSmoke <- true

					//set default blimp model if not specified
					if ( !( "Model" in scope.pop_property ) ) {
						local blimp_model = {
							Model = {
								//version of blimp where model is in the lower half of the bounding box
								Default = "models/bots/boss_bot/boss_blimp_main.mdl" // MD5: 59242bf074a617a95701b34f93b37549
								Damage1 = "models/bots/boss_bot/boss_blimp_main_damage1.mdl"
								Damage2 = "models/bots/boss_bot/boss_blimp_main_damage2.mdl"
								Damage3 = "models/bots/boss_bot/boss_blimp_main_damage3.mdl"
							}
						}

						PopExtHooks.AddHooksToScope( tank, blimp_model, scope )

						//ModelVisionOnly true is best for this blimp model
						if ( !( "ModelVisionOnly" in scope.pop_property ) )
							scope.pop_property.ModelVisionOnly <- true
					}

					if ( !( "Skin" in scope.pop_property ) )
						switch( scope.team ) {
							case TF_TEAM_PVE_DEFENDERS:
							case TF_TEAM_PVE_INVADERS:
								scope.pop_property.Skin <- scope.team - 2
								break
							case TEAM_SPECTATOR:
								scope.pop_property.Skin <- 2
								break
							default:
								scope.pop_property.Skin <- 1
						}

					tank.SetAbsAngles( QAngle( 0, tank.GetAbsAngles().y, 0 ) )
					scope.blimp_train <- SpawnEntityFromTable( "func_tracktrain", {origin = tank.GetOrigin(), startspeed = INT_MAX, target = scope.pop_property.StartTrack} )

					scope.TankThinkTable.BlimpThink <- function() {

						// this is normally not possible, however we need to do a pretty gross hack that will turn the tank into a null instance sometimes
						if ( self == null ) return

						self.SetAbsOrigin( blimp_train.GetOrigin() )
						self.GetLocomotionInterface().Reset()

						//update func_tracktrain if tank's speed is changed
						if ( GetPropFloat( blimp_train, "m_flSpeed" ) != GetPropFloat( self, "m_speed" ) )
							EntFireByHandle( blimp_train, "SetSpeedReal", GetPropFloat( self, "m_speed" ).tostring(), -1, null, null )
					}
				}

				if ( "Skin" in scope.pop_property )
					SetPropInt( tank, "m_nSkin", scope.pop_property.Skin )

				if ( "SpawnTemplate" in scope.pop_property ) {
					SpawnTemplate( scope.pop_property.SpawnTemplate, tank )
					delete scope.pop_property.SpawnTemplate
				}

				if ( "DisableTracks" in scope.pop_property && scope.pop_property.DisableTracks )
					for ( local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer() )
						if ( child.GetClassname() == "prop_dynamic" )
							if ( child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl" )
								child.DisableDraw()

				if ( "DisableBomb" in scope.pop_property && scope.pop_property.DisableBomb )
					for ( local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer() )
						if ( child.GetClassname() == "prop_dynamic" )
							if ( child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl" )
								child.DisableDraw()

				if ( "DisableSmoke" in scope.pop_property && scope.pop_property.DisableSmoke ) {
					scope.TankThinkTable.DisableSmoke <- function() {
						//disables smokestack, still emits one smoke particle when spawning and when moving out from under low ceilings ( solid brushes 300 units or lower )
						EntFireByHandle( self, "DispatchEffect", "ParticleEffectStop", -1, null, null )
					}
				}

				if ( "Scale" in scope.pop_property )
					EntFireByHandle( tank, "SetModelScale", scope.pop_property.Scale.tostring(), -1, null, null )

				if ( "Model" in scope.pop_property ) {
					if ( !( "ModelVisionOnly" in scope.pop_property && scope.pop_property.ModelVisionOnly ) )
						tank.SetModelSimple( scope.pop_property.Model.Default ) //changes bbox size

					scope.curModel <- scope.pop_property.ModelPrecached.Default

					//using a think prevents tank from briefly becoming invisible when changing damage models
					scope.TankThinkTable.SetModel <- function() {
						SetPropIntArray( self, "m_nModelIndexOverrides", cur_model, VISION_MODE_NONE )
						SetPropIntArray( self, "m_nModelIndexOverrides", cur_model, VISION_MODE_ROME )
					}

					if ( "LeftTrack" in scope.pop_property.Model ) {
						scope.pop_property.Model.TrackL <- scope.pop_property.Model.LeftTrack
						delete scope.pop_property.Model.LeftTrack
						scope.pop_property.ModelPrecached.TrackL <- scope.pop_property.ModelPrecached.LeftTrack
						delete scope.pop_property.ModelPrecached.LeftTrack
					}
					if ( "RightTrack" in scope.pop_property.Model ) {
						scope.pop_property.Model.TrackR <- scope.pop_property.Model.RightTrack
						delete scope.pop_property.Model.RightTrack
						scope.pop_property.ModelPrecached.TrackR <- scope.pop_property.ModelPrecached.RightTrack
						delete scope.pop_property.ModelPrecached.RightTrack
					}

					for ( local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer() ) {

						if ( child.GetClassname() != "prop_dynamic" ) continue

						local replace_model     = -1
						local replace_model_str = ""
						local is_track          = false
						local child_model_name    = child.GetModelName()

						if ( "Bomb" in scope.pop_property.Model && child_model_name == "models/bots/boss_bot/bomb_mechanism.mdl" ) {
							replace_model     = scope.pop_property.ModelPrecached.Bomb
							replace_model_str = scope.pop_property.Model.Bomb
						}
						else if ( "TrackL" in scope.pop_property.Model && child_model_name == "models/bots/boss_bot/tank_track_L.mdl" ) {
							replace_model     = scope.pop_property.ModelPrecached.TrackL
							replace_model_str = scope.pop_property.Model.TrackL
							is_track          = true
						}
						else if ( "TrackR" in scope.pop_property.Model && child_model_name == "models/bots/boss_bot/tank_track_R.mdl" ) {
							replace_model     = scope.pop_property.ModelPrecached.TrackR
							replace_model_str = scope.pop_property.Model.TrackR
							is_track          = true
						}

						if ( replace_model != -1 ) {
							child.SetModel( replace_model_str )
							SetPropIntArray( child, "m_nModelIndexOverrides", replace_model, VISION_MODE_NONE )
							SetPropIntArray( child, "m_nModelIndexOverrides", replace_model, VISION_MODE_ROME )
						}

						if ( is_track ) {
							local anim_sequence = child.LookupSequence( "forward" )
							if ( anim_sequence != -1 ) {
								child.SetSequence( anim_sequence )
								child.SetPlaybackRate( 1.0 )
								child.SetCycle( 0 )
							}
						}
					}
				}
			}

			scope.TankThinks <- function() { foreach ( name, func in scope.TankThinkTable ) func.call( scope ); return -1 }
			scope.TankThinks() //run thinks for availability in OnSpawn
			_AddThinkToEnt( tank, "TankThinks" )

			foreach( name, table in tank_names_wildcard )
				if ( startswith( tank_name, name ) && "OnSpawn" in table )
					table.OnSpawn( tank, tank_name )

			if ( tank_name in tank_names ) {
				local table = tank_names[tank_name]
				if ( "OnSpawn" in table )
					table.OnSpawn( tank, tank_name )
			}
		}
		else {
			//sets damaged tank models
			if ( scope.cur_health != tank.GetHealth() ) {
				local health_stage
				if ( tank.GetHealth() <= 0 )
					health_stage = 3
				else
					// how many quarters of max_health has the tank received in damage
					health_stage = floor( ( scope.max_health - tank.GetHealth() )/scope.max_health.tofloat() * 4 )

				if ( scope.lastHealthStage != health_stage && "pop_property" in scope && "Model" in scope.pop_property ) {
					local name = health_stage == 0 ? "Default" : "Damage" + health_stage

					if ( !( "ModelVisionOnly" in scope.pop_property && scope.pop_property.ModelVisionOnly ) )
						tank.SetModelSimple( scope.pop_property.Model[name] )

					scope.curModel <- scope.pop_property.ModelPrecached[name]
				}

				scope.cur_health = tank.GetHealth() //set this here instead of Updates think to prevent conflict
				scope.last_health_stage = health_stage
			}
		}
	}

	foreach ( player in PopExtUtil.BotTable.keys() ) {

		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		local alive = player.IsAlive()
		if ( alive && !( "botCreated" in scope ) ) {
			scope.botCreated <- true

			foreach( tag, table in robot_tags )

				if ( player.HasBotTag( tag ) ) {

					scope.popFiredDeathHook <- false
					PopExtHooks.AddHooksToScope( tag, table, scope )

					if ( "OnSpawn" in table )
						table.OnSpawn( player, tag )
				}
		}
		// Make sure that ondeath hook is fired always
		if ( !alive && "popFiredDeathHook" in scope ) {
			if ( !scope.popFiredDeathHook )
				PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )

			delete scope.popFiredDeathHook
		}
	}
	return -1
}
