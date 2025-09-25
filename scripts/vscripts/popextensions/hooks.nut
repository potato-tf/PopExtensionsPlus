POPEXT_CREATE_SCOPE( "__popext_hooks", "PopExtHooks", "PopExtHooksEntity" )
POPEXT_CREATE_SCOPE( "__popext_legacy", "PopExt", "PopExtEntity" )

PopExtHooks.tank_icons <- []
PopExtHooks.icons      <- []

function PopExtHooks::AddHooksToScope( name, table, scope ) {

	foreach( hook_name, func in table ) {
		// Entries in hook table must begin with 'On' to be considered hooks
		if ( hook_name.slice( 0, 2 ) == "On" ) {

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

function PopExtHooks::FireHooks( entity, scope, name ) {
	if ( scope && "popHooks" in scope && name in scope.popHooks )
		foreach( index, func in scope.popHooks[name] )
			func( entity )
}
function PopExtHooks::FireHooksParam( entity, scope, name, param ) {
	if ( scope && "popHooks" in scope && name in scope.popHooks )
		foreach( index, func in scope.popHooks[name] )
			func( entity, param )
}

function PopExtHooks::PopHooksThink() {

	if ( !PopExtUtil.IsWaveStarted )
		return 0.2

	for ( local tank; tank = FindByClassname( tank, "tank_boss" ); ) {

		local scope = PopExtUtil.GetEntScope( tank )

		if ( !( "created" in scope ) && tank.GetScriptThinkFunc() == "" ) {

			scope.created         	 <- true
			scope.max_health         <- tank.GetMaxHealth()
			scope.team            	 <- tank.GetTeam()
			scope.teamchanged     	 <- false
			scope.engineloopreplaced <- false

			scope.cur_health        <- tank.GetHealth()
			scope.last_health_stage <- 0

			function Updates() {
				cur_pos            <- self.GetOrigin()
				cur_vel            <- self.GetAbsVelocity()
				cur_speed          <- cur_vel.Length()
				last_health_percentage <- GetPropFloat( self, "m_lastHealthPercentage" )
			}
			PopExtUtil.AddThink( tank, Updates )

			local tank_name = tank.GetName().tolower()

			foreach( name, table in PopExt.tank_names_wildcard )
				if ( startswith( tank_name, name ) )
					PopExtHooks.AddHooksToScope( tank_name, table, scope )

			if ( tank_name in PopExt.tank_names )
				PopExtHooks.AddHooksToScope( tank_name, PopExt.tank_names[tank_name], scope )

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

					local cooldowntime = 0.0
					if ( "Ping" in sound_overrides ) {

						function PingSound() {

							StopSoundOn( "MVM.TankPing", self )

							if ( Time() < cooldowntime ) return

							EmitSoundEx( {sound_name = sound_overrides.Ping, entity = tank} )

							cooldowntime = Time() + 5.0
						}
						PopExtUtil.AddThink( tank, PingSound )
					}
					if ( "EngineLoop" in sound_overrides && !scope.engineloopreplaced ) {

						StopSoundOn( "MVM.TankEngineLoop", tank )
						EmitSoundEx({
							sound_name = sound_overrides.EngineLoop
							entity = tank
							filter_type = RECIPIENT_FILTER_GLOBAL
							sound_level = 100
						})

						PopExtUtil.SetDestroyCallback( tank, function() {
							EmitSoundEx({
								sound_name = sound_overrides.EngineLoop
								entity = self
								flags = SND_STOP
								filter_type = RECIPIENT_FILTER_GLOBAL
							})
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

						function DeploySound() {

							if ( self.GetSequence() != self.LookupSequence( "deploy" ) ) return

							StopSoundOn( "MVM.TankDeploy", self )

							if ( "EngineLoop" in sound_overrides )
								EmitSoundEx({ sound_name = sound_overrides.EngineLoop, entity = tank, flags = SND_STOP })

							EmitSoundEx({ sound_name = deploysound, entity = tank })

							if ( tank == null ) {

								PopExtUtil.RemoveThink( tank, "DeploySound" )
								return
							}

							delete scope.pop_property.SoundOverrides.Deploy
						}
						PopExtUtil.AddThink( tank, DeploySound )
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

				if ( "NoScreenShake" in scope.pop_property && scope.pop_property.NoScreenShake ) {
					function NoScreenShake() { ScreenShake( self.GetOrigin(), 25.0, 5.0, 5.0, 1000.0, SHAKE_STOP, true ) }
					PopExtUtil.AddThink( tank, NoScreenShake )
				}

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

					function BlimpThink() {

						// this is normally not possible, however we need to do a pretty gross hack that will turn the tank into a null instance sometimes
						if ( self == null ) return

						self.SetAbsOrigin( blimp_train.GetOrigin() )
						self.GetLocomotionInterface().Reset()

						//update func_tracktrain if tank's speed is changed
						if ( GetPropFloat( blimp_train, "m_flSpeed" ) != GetPropFloat( self, "m_speed" ) )
							EntFireByHandle( blimp_train, "SetSpeedReal", GetPropFloat( self, "m_speed" ).tostring(), -1, null, null )
					}
					PopExtUtil.AddThink( tank, BlimpThink )
				}

				if ( "Skin" in scope.pop_property )
					SetPropInt( tank, "m_nSkin", scope.pop_property.Skin )

				if ( "SpawnTemplate" in scope.pop_property && PopExtMain.IncludeModules( "spawntemplate" ) ) {

					SpawnTemplate( scope.pop_property.SpawnTemplate, tank )
					delete scope.pop_property.SpawnTemplate
				}

				if ( "DisableTracks" in scope.pop_property && scope.pop_property.DisableTracks )
					for ( local child = tank.FirstMoveChild(); child; child = child.NextMovePeer() )
						if ( child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl" )
							child.DisableDraw()

				if ( "DisableBomb" in scope.pop_property && scope.pop_property.DisableBomb )
					for ( local child = tank.FirstMoveChild(); child; child = child.NextMovePeer() )
						if ( child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl" )
							child.DisableDraw()

				if ( "DisableSmoke" in scope.pop_property && scope.pop_property.DisableSmoke ) {
					function DisableSmoke() {
						//disables smokestack, still emits one smoke particle when spawning and when moving out from under low ceilings ( solid brushes 300 units or lower )
						EntFireByHandle( self, "DispatchEffect", "ParticleEffectStop", -1, null, null )
					}
					PopExtUtil.AddThink( tank, DisableSmoke )
				}

				if ( "Scale" in scope.pop_property )
					EntFireByHandle( tank, "SetModelScale", scope.pop_property.Scale.tostring(), -1, null, null )

				if ( "AngleOverride" in scope.pop_property ) {

					function AngleOverride() {
						self.SetAbsAngles( PopExtUtil.KVStringToVectorOrQAngle( pop_property.AngleOverride, true ) )
					}
					PopExtUtil.AddThink( tank, AngleOverride )
				}

				if ( "Model" in scope.pop_property ) {

					if ( !( "ModelVisionOnly" in scope.pop_property && scope.pop_property.ModelVisionOnly ) )
						tank.SetModelSimple( scope.pop_property.Model.Default ) //changes bbox size

					scope.cur_model <- scope.pop_property.ModelPrecached.Default

					function TankModelThink() {

						//sets damaged tank models
						if ( cur_health != self.GetHealth() ) {

							local health_stage
							if ( self.GetHealth() <= 0 )
								health_stage = 3
							else
								// how many quarters of max_health has the tank received in damage
								health_stage = floor( ( max_health - self.GetHealth() ) / max_health.tofloat() * 4 )

							if ( last_health_stage != health_stage && "pop_property" in this && "Model" in pop_property ) {

								local name = health_stage == 0 ? "Default" : format( "Damage%d", health_stage )

								if ( !( "ModelVisionOnly" in pop_property && pop_property.ModelVisionOnly ) )
									self.SetModelSimple( pop_property.Model[name] )

								cur_model <- pop_property.ModelPrecached[name]

							}

							cur_health = self.GetHealth()
							last_health_stage = health_stage

						}

						if ( GetPropIntArray( self, STRING_NETPROP_MDLINDEX_OVERRIDES, VISION_MODE_NONE ) != cur_model ) {

							SetPropIntArray( self, STRING_NETPROP_MDLINDEX_OVERRIDES, cur_model, VISION_MODE_NONE )
							SetPropIntArray( self, STRING_NETPROP_MDLINDEX_OVERRIDES, cur_model, VISION_MODE_ROME )
						}
					}
					PopExtUtil.AddThink( tank, TankModelThink )

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

					for ( local child = tank.FirstMoveChild(); child; child = child.NextMovePeer() ) {

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
							SetPropIntArray( child, STRING_NETPROP_MDLINDEX_OVERRIDES, replace_model, VISION_MODE_NONE )
							SetPropIntArray( child, STRING_NETPROP_MDLINDEX_OVERRIDES, replace_model, VISION_MODE_ROME )
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

			foreach( name, table in PopExt.tank_names_wildcard )
				if ( startswith( tank_name, name ) && "OnSpawn" in table )
					table.OnSpawn( tank, tank_name )

			if ( tank_name in PopExt.tank_names ) {
				local table = PopExt.tank_names[tank_name]
				if ( "OnSpawn" in table )
					table.OnSpawn( tank, tank_name )
			}
		}
	}

	foreach ( player in PopExtUtil.BotArray ) {

		local scope = PopExtUtil.GetEntScope( player )

		local alive = player.IsAlive()
		if ( alive && !( "bot_created" in scope ) ) {
			scope.bot_created <- true

			foreach( tag, table in PopExt.robot_tags )

				if ( player.HasBotTag( tag ) ) {

					scope.pop_fired_death_hook <- false
					scope.popFiredDeathHook <- scope.pop_fired_death_hook // backwards compatibility
					PopExtHooks.AddHooksToScope( tag, table, scope )

					if ( "OnSpawn" in table )
						table.OnSpawn( player, tag )
				}
		}
		// Make sure that ondeath hook is fired always
		if ( !alive && "pop_fired_death_hook" in scope ) {
			if ( !scope.pop_fired_death_hook )
				PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )

			delete scope.pop_fired_death_hook
		}
	}
	return -1
}
AddThinkToEnt( PopExtHooksEntity, "PopHooksThink" )

POP_EVENT_HOOK( "OnTakeDamage", "PopHooksTakeDamage", function( params ) {

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

POP_EVENT_HOOK( "player_spawn", "PopHooksPlayerSpawn", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = player.GetScriptScope()

	if ( "pop_fired_death_hook" in scope && !scope.pop_fired_death_hook ) {

		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.pop_fired_death_hook
	}

	// Reset hooks
	if ( "bot_created" in scope )
		delete scope.bot_created

	if ( "popHooks" in scope )
		delete scope.popHooks

}, EVENT_WRAPPER_HOOKS)

POP_EVENT_HOOK( "player_team", "PopHooksPlayerTeam", function( params ) {

	if ( params.team != TEAM_SPECTATOR ) return

	local player = GetPlayerFromUserID( params.userid )
	if ( !player || !player.IsValid() ) return

	local scope = player.GetScriptScope()

	if ( "pop_fired_death_hook" in scope && !scope.pop_fired_death_hook ) {
		PopExtHooks.FireHooksParam( player, scope, "OnDeath", null )
		delete scope.pop_fired_death_hook
	}

		// Reset hooks
	if ( "bot_created" in scope )
		delete scope.bot_created

	if ( "popHooks" in scope )
		delete scope.popHooks

}, EVENT_WRAPPER_HOOKS)

POP_EVENT_HOOK( "player_hurt", "PopHooksPlayerHurt", function( params ) {

	local victim = GetPlayerFromUserID( params.userid )
	local scope = victim.GetScriptScope()

	PopExtHooks.FireHooksParam( victim, scope, "OnTakeDamagePost", params )

	local attacker = GetPlayerFromUserID( params.attacker )

	if ( attacker != null ) {
		local scope = attacker.GetScriptScope()
		PopExtHooks.FireHooksParam( attacker, scope, "OnDealDamagePost", params )
	}
}, EVENT_WRAPPER_HOOKS)

POP_EVENT_HOOK( "player_death", "PopHooksPlayerDeath", function( params ) {

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

POP_EVENT_HOOK( "npc_hurt", "PopHooksNPCHurt", function( params ) {

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
				PopExtUtil.SetTargetname( temp, "__popext_temp_nodeathfx" )

				temp.SetAbsOrigin( victim.GetOrigin() )

				function FindTankDestructionEnt() {

					for ( local destruction; destruction = FindByClassnameWithin( destruction, "tank_destruction", self.GetOrigin(), 1 ); ) {

						if ( pop_property.NoDeathFX == 2 && !has_explode_sound )
							StopSoundOn( "MVM.TankExplodes", PopExtUtil.Worldspawn )

						EntFireByHandle( destruction, "Kill", "", -1, null, null )
						self.Kill()
						return 1
					}

					return -1
				}
				PopExtUtil.GetEntScope( temp ).FindTankDestructionEnt <- FindTankDestructionEnt
				AddThinkToEnt( temp, "FindTankDestructionEnt" )
			}
			if ( "IsBlimp" in pop_property && pop_property.IsBlimp )
				EntFireByHandle( scope.blimpTrain, "Kill", "", -1, null, null )
		}

		if ( dead && scope && !( "pop_fired_death_hook" in scope ) ) {

			scope.pop_fired_death_hook <- true

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
}, EVENT_WRAPPER_HOOKS)

POP_EVENT_HOOK( "mvm_begin_wave", "PopHooksWaveStarts", function( params ) {

	if ( "wave_icons_function" in PopExt )
		PopExt.wave_icons_function()

	foreach( v in PopExtHooks.tank_icons )
		PopExt._PopIncrementTankIcon( v )

	foreach( v in PopExtHooks.icons )
		PopExt._PopIncrementIcon( v )
}, EVENT_WRAPPER_HOOKS)

POP_EVENT_HOOK( "teamplay_round_start", "PopHooksTeamplayRoundStart", function( params ) {

	if ( "wave_icons_function" in PopExt )
		delete PopExt.wave_icons_function

	PopExtHooks.tank_icons <- []
	PopExtHooks.icons     <- []
}, EVENT_WRAPPER_HOOKS)

