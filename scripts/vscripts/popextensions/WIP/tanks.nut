popext_tanks_entity <- FindByName( null, "__popext_tanks" )
if ( popext_tanks_entity == null ) popext_tanks_entity = SpawnEntityFromTable( "info_teleport_destination", { targetname = "__popext_tanks" } )
popext_tanks_entity.ValidateScriptScope()

// there's no game event for tank spawn, loop through tanks in a think.
::PopExtTanks <- {

    tank_names = {}

    function AddTankName( name, table ) {

        if ( !pop_ext_think_func_set ) {
            AddThinkToEnt( popext_tanks_entity, "TankThink" )
            pop_ext_think_func_set = true
        }

        if ( "Icon" in table ) {

            if ( typeof table.Icon == "table" ) {

                local icon 			     = "name" in table.Icon ? table.Icon.name : table.Icon.icon
                local count  		     = "count" in table.Icon ? table.Icon.count : 1
                local is_crit 		     = "is_crit" in table.Icon ? table.Icon.is_crit : false
                local is_boss 		     = "is_boss" in table.Icon ? table.Icon.is_boss : true
                local is_support 	     = "is_support" in table.Icon ? table.Icon.is_support : false
                local is_support_limited = "is_support_limited" in table.Icon ? table.Icon.is_support_limited : false

                PopExtWavebar.AddCustomTankIcon( icon, count, is_crit, is_boss, is_support, is_support_limited )
            }
            else
                PopExtWavebar.AddCustomTankIcon( table.Icon, 1 )
        }

        name = name.tolower()
        tank_names[ name ] <- table
    }

    // alias with more intuitive name
    CustomTank = AddTankName

    
    sound_funcs = {

        Destroy = function( scope ) {

            scope.pop_property.SoundOverrides.Explodes <- sound_overrides.Destroy
        },

        Ping = function( scope ) {

            scope.cooldowntime <- 0.0

            scope.TankThinkTable.PingSound <- function() {

                StopSoundOn( "MVM.TankPing", self )

                if ( Time() < cooldowntime ) return

                EmitSoundEx({ sound_name = sound_overrides.Ping, entity = tank })

                cooldowntime = Time() + 5.0
            }
        },

        EngineLoop = function( scope ) {

            if ( scope.engineloopreplaced ) return

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
        },

        Start = function( scope ) {

            StopSoundOn( "MVM.TankStart", tank )
            EmitSoundEx( {sound_name = sound_overrides.Start, entity = tank} )
            delete scope.pop_property.SoundOverrides.Start
        },

        Deploy = function( scope ) {

            //tank becomes a null reference when we start deploying
            //store the sound in a variable to still play it, then delete the think function when this happens

            local deploysound = sound_overrides.Deploy

            scope.TankThinkTable.DeploySound <- function() {

                if ( self.GetSequence() != self.LookupSequence( "deploy" ) ) 
                    return

                StopSoundOn( "MVM.TankDeploy", self )

                if ( "EngineLoop" in sound_overrides )
                    EmitSoundEx({ sound_name = sound_overrides.EngineLoop, entity = tank, flags = SND_STOP })

                EmitSoundEx({ sound_name = deploysound, entity = tank })

                if ( tank == null ) {

                    delete scope.TankThinkTable.DeploySound
                    return
                }

                delete scope.pop_property.SoundOverrides.Deploy
            }
        }
    }

    tank_funcs = {

        TankModelVisionOnly = function( scope ) {
            scope.pop_property.ModelVisionOnly <- scope.pop_property.TankModelVisionOnly
        },

        SoundOverrides = function( scope ) {

            local sound_overrides = scope.pop_property.SoundOverrides

            foreach ( k, v in sound_overrides ) {

                PrecacheSound( v )
                if ( k in PopExtTanks.sound_funcs )
                    PopExtTanks.sound_funcs[k]( scope )
            }
        },

        Team = function( scope ) {

            if (scope.teamchanged) return

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
        },

        NoScreenShake = function( scope ) {

            if ( scope.pop_property.NoScreenShake )
                scope.TankThinkTable.NoScreenShake <- @() ScreenShake( self.GetOrigin(), 25.0, 5.0, 5.0, 1000.0, SHAKE_STOP, true )
        },

        IsBlimp = function( scope ) {

            if ( !scope.pop_property.IsBlimp ) return

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
        },
        

        Skin = function( scope ) {
            SetPropInt( tank, "m_nSkin", scope.pop_property.Skin )
        },

        SpawnTemplate = function( scope ) {

            if ( !("SpawnTemplate" in ROOT) ) {
                PopExtMain.Error.RaiseModuleError( "SpawnTemplate", "AddTankName/CustomTank", true )
                return
            }

            SpawnTemplate( scope.pop_property.SpawnTemplate, tank )
        },

        DisableTracks = function( scope ) {

            if ( !scope.pop_property.DisableTracks ) return

            for ( local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer() )
                if ( child.GetClassname() == "prop_dynamic" )
                    if ( child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl" )
                        child.DisableDraw()
        },

        DisableBomb = function( scope ) {

            if ( !scope.pop_property.DisableBomb ) return

            for ( local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer() )
                if ( child.GetClassname() == "prop_dynamic" )
                    if ( child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl" )
                        child.DisableDraw()
        },

        DisableSmoke = function( scope ) {

            if ( !scope.pop_property.DisableSmoke ) return

            scope.TankThinkTable.DisableSmoke <- function() {
                //disables smokestack, still emits one smoke particle when spawning and when moving out from under low ceilings ( solid brushes 300 units or lower )
                EntFireByHandle( self, "DispatchEffect", "ParticleEffectStop", -1, null, null )
            }
        },

        Scale = function( scope ) {
            EntFireByHandle( tank, "SetModelScale", scope.pop_property.Scale.tostring(), -1, null, null )
        },
        
        AngleOverride = function( scope ) {
            scope.TankThinkTable.AngleOverride <- function() {
                self.SetAbsAngles( PopExtUtil.KVStringToVectorOrQAngle( pop_property.AngleOverride, true ) )
            }
        },

        Model = function( scope ) {

            local mdl = scope.pop_property.Model

            local model_names = typeof mdl == "string" ? {} : mdl

            if ( typeof mdl == "string" ) {

                model_names.Default <- mdl
                model_names.Damage1 <- mdl
                model_names.Damage2 <- mdl
                model_names.Damage3 <- mdl
            }
            scope.pop_property.Model <- model_names

            local model_names_precached = {}

            foreach( k, v in model_names )
                model_names_precached[k] <- PrecacheModel( v )

            scope.pop_property.ModelPrecached <- model_names_precached

            scope.cur_model <- scope.pop_property.ModelPrecached.Default

            if ( "ModelVisionOnly" in scope.pop_property && !scope.pop_property.ModelVisionOnly )
                tank.SetModelSimple( scope.pop_property.Model.Default ) //changes bbox size
            
            // using a think prevents tank from briefly becoming invisible when changing damage models
            scope.TankThinkTable.SetModel <- function() {

                SetPropIntArray( self, "m_nModelIndexOverrides", cur_model, VISION_MODE_NONE )
                SetPropIntArray( self, "m_nModelIndexOverrides", cur_model, VISION_MODE_ROME )

                local health_stage = cur_health <= 0 ? 3 : floor( ( max_health - cur_health ) / max_health.tofloat() * 4 )

                if ( last_health_stage != health_stage ) {

                    local name = health_stage == 0 ? "Default" : format( "Damage%d", health_stage )

                    if ( !( "ModelVisionOnly" in pop_property && pop_property.ModelVisionOnly ) )
                        tank.SetModelSimple( pop_property.Model[name] )

                    cur_model <- pop_property.ModelPrecached[name]
                    last_health_stage = health_stage
                }
            }

            if ( "LeftTrack" in scope.pop_property.Model ) {
                scope.pop_property.Model.TrackL <- scope.pop_property.Model.LeftTrack
                scope.pop_property.ModelPrecached.TrackL <- scope.pop_property.ModelPrecached.LeftTrack
                delete scope.pop_property.Model.LeftTrack
                delete scope.pop_property.ModelPrecached.LeftTrack
            }
            if ( "RightTrack" in scope.pop_property.Model ) {
                scope.pop_property.Model.TrackR <- scope.pop_property.Model.RightTrack
                scope.pop_property.ModelPrecached.TrackR <- scope.pop_property.ModelPrecached.RightTrack
                delete scope.pop_property.Model.RightTrack
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
        },

        TankModel = function( scope ) {

            scope.pop_property.Model <- scope.pop_property.TankModel
            Model( scope )
        }
    }

    props_to_delete = {

        TankModel           = null
        TankModelVisionOnly = null
        SpawnTemplate       = null
    }
}

popext_tanks_entity.GetScriptScope().TankThink <- function() {

    if ( !PopExtUtil.IsWaveStarted )
        return 0.2

    for ( local tank; tank = FindByClassname( tank, "tank_boss" ); ) {

        tank.ValidateScriptScope()
        local scope = tank.GetScriptScope()

        if ( !( "created" in scope ) ) {

			scope.created         	 <- true
			scope.TankThinkTable  	 <- {}
			scope.max_health         <- tank.GetMaxHealth()
			scope.cur_health         <- tank.GetHealth()
			scope.last_health_stage  <- 0
			scope.team            	 <- tank.GetTeam()
			scope.teamchanged     	 <- false
			scope.engineloopreplaced <- false

            local tank_name = tank.GetName().tolower()

            if ( "pop_property" in scope ) {

                foreach ( name, func in scope.pop_property )

                    if ( name in tank_funcs )

                        tank_funcs[ name ]( scope )

                local prop_keys = scope.pop_property.keys()

                for ( local i = prop_keys.len(); i >= 0; i-- )

                    if ( prop_keys[ i ] in props_to_delete )

                        delete scope.pop_property[ prop_keys[ i ] ]
            }            

            scope.TankThinks <- function() { foreach ( name, func in scope.TankThinkTable ) func.call( scope ); return -1 }
            scope.TankThinks() //run thinks for availability in OnSpawn
            _AddThinkToEnt( tank, "TankThinks" )

            foreach( name, table in tank_names ) {

                if ( (tank_name == name || ( endswith( name, "*" ) && startswith( tank_name, name.slice( 0, -1 ) ) ) ) && "OnSpawn" in table ) {

                    table.OnSpawn( tank, tank_name )
                    break
                }
            }
        }
    }
    return -1
}

PopExtUtil.AddThinkToEnt( popext_tanks_entity, "TankThink" )

PopExtEvents.AddRemoveEventHook( "npc_hurt", "PopExtTankHurt", function( params ) {

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
				if ( PopExtWavebar.GetWaveIcon( "tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL ) > 0 && PopExtWavebar.GetWaveIcon( icon_name, flags ) > 0 )
					PopExtWavebar.IncrementWaveIcon( "tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1, false )

				// Decrement custom tank icon when killed.
				PopExtWavebar.DecrementWaveIcon( icon_name, flags, 1, false )
			}

			PopExtHooks.FireHooksParam( victim, scope, "OnDeath", params )
		}
	}
}, EVENT_WRAPPER_HOOKS)