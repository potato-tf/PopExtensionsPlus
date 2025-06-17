//fold constants/functions again here so this can be standalone
if ( !( "CONST" in getroottable() ) ) {

    ::CONST <- getconsttable()
    ::ROOT <- getroottable()

    CONST.setdelegate( { _newslot = @( k, v ) compilestring( "const " + k + "=" + ( typeof v == "string" ? ( "\"" + v + "\"" ) : v ) )() } )
    CONST.MAX_CLIENTS <- MaxClients().tointeger()

    foreach( k, v in ::NetProps.getclass() )
        if ( k != "IsValid" && !( k in ROOT ) )
            ROOT[k] <- ::NetProps[k].bindenv( ::NetProps )

    foreach( k, v in ::Entities.getclass() )
        if ( k != "IsValid" && !( k in ROOT ) )
            ROOT[k] <- ::Entities[k].bindenv( ::Entities )

    foreach( k, v in ::EntityOutputs.getclass() )
        if ( k != "IsValid" && !( k in ROOT ) )
            ROOT[k] <- ::EntityOutputs[k].bindenv( ::EntityOutputs )

    foreach( k, v in ::NavMesh.getclass() )
        if ( k != "IsValid" && !( k in ROOT ) )
            ROOT[k] <- ::NavMesh[k].bindenv( ::NavMesh )

    if ( !( "ConstantNamingConvention" in ROOT ) ) {

        foreach( a, b in Constants )
            foreach( k, v in b ) {

                CONST[k] <- v != null ? v : 0
                ROOT[k] <- v != null ? v : 0
            }
    }
}

local SINGLE_TICK = 0.015

if ( !( "EntAdditions" in ROOT ) ) {

    ::EntAdditions <- class {

        function SetDestroyCallback( entity, callback ) {

            entity.ValidateScriptScope()
            local scope = entity.GetScriptScope()
            scope.setdelegate( {}.setdelegate( {
                    parent   = scope.getdelegate()
                    id       = entity.GetScriptId()
                    index    = entity.entindex()
                    callback = callback
                    _get = function( k ) {

                        return parent[k]
                    }
                    _delslot = function( k ) {

                        if ( k == id ) {

                            entity = EntIndexToHScript( index )
                            local scope = entity.GetScriptScope()
                            scope.self <- entity
                            callback.pcall( scope )
                        }
                        delete parent[k]
                    }
                } )
            )
        }
        Precache = {
            //mini-sentry spawnflag
            obj_sentrygun = function( ent, spawnflags ) {
                if ( spawnflags & 64 )
                    SetPropBool( ent, "m_bMiniBuilding", true )
            }
        }
        OnPostSpawn = {
            //non-solid spawnflag
            func_button = function( ent, spawnflags ) {
                if ( spawnflags & 16384 ) {

                    ent.AddEFlags( EFL_USE_PARTITION_WHEN_NOT_SOLID )
                    ent.AddSolidFlags( FSOLID_NOT_SOLID )
                }
            }
            func_rot_button = function( ent, spawnflags ) {
                //fix broken locked spawnflag
                if ( spawnflags & SF_BUTTON_LOCKED )
                    SetPropBool( ent, "m_bLocked", true )
            }
            //mini-sentry spawnflag
            obj_sentrygun = function( ent, spawnflags ) {
                if ( spawnflags & 64 ) {

                    ent.SetModelScale( 0.75, 0.0 )
                    ent.SetSkin( ent.GetSkin() + 2 )
                }
            }
            //fix invulnerable flag not working
            obj_dispenser = function( ent, spawnflags ) {
                if ( spawnflags & 2 )
                    SetPropInt( ent, "m_takedamage", 0 )
            }
            //start disabled spawnflag
            light_dynamic = function( ent, spawnflags ) {
                if ( spawnflags & 16 )
                    ent.AcceptInput( "TurnOff", "", null, null )
            }
            //fix func_rotating capping at 360,000 degrees
            //fix killing func_rotating before stopping sound causing sound to play forever
            func_rotating = function( ent, spawnflags ) {

                local maxangle = 350000.0 //max angle is actually 360,000.0, reset it a bit earlier just in case
                local xyz = array( 3, 0.0 )
                ent.ValidateScriptScope()
                local scope = ent.GetScriptScope()
                scope.RotateFixThink <- function() {

                    for ( local i = 0; i < 3; i++ ) {

                        xyz[i] = GetPropFloat( ent, format( "m_angRotation[%d]", i ) )
                        if ( xyz[i] == 0.0 || xyz[i] < maxangle ) continue

                        xyz[i] %= 360.0
                        // xyz[i] = 0; //jitter on reset
                        ent.SetLocalAngles( QAngle( xyz[0], xyz[1], xyz[2] ) )
                        break
                    }
                    return -1
                }
                AddThinkToEnt( ent, "RotateFixThink" )
                scope.noise <- GetPropString( ent, "m_NoiseRunning" )

                EntAdditions.SetDestroyCallback( ent, @() StopAmbientSoundOn( self.GetScriptScope().noise, self ) )
            }
            // add spawnflag to apply to all players
            // add spawnflag to allow for taking damage
            // fix not being able to disable on dead players
            // fix persisting between map/round changes
            point_viewcontrol = function( ent, spawnflags ) {

                function InputEnable() {

                    if ( !ent || !ent.IsValid() )
                        return true

                    if ( spawnflags & 512 ) {

                        local takedamage = GetPropInt( activator, "m_takedamage" )
                        SetPropEntity( ent, "m_hPlayer", null )
                        EntFireByHandle( activator, "RunScriptCode", format( "SetPropInt( self, `m_takedamage`, %d )", takedamage ), SINGLE_TICK, null, null )
                    }
                    if ( ent.IsEFlagSet( EFL_IS_BEING_LIFTED_BY_BARNACLE ) )
                        return true

                    if ( spawnflags & 256 ) {

                        ent.AddEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )
                        for ( local i = 1; i <= MAX_CLIENTS; i++ ) {

                            local player = PlayerInstanceFromIndex( i )
                            if ( player && player.IsValid() ) {

                                ent.AcceptInput( "Enable", "", player, player )
                                SetPropEntity( ent, "m_hPlayer", player )
                            }
                        }
                        ent.RemoveEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )
                    }

                    return true
                }

                function InputDisable() {

                    if ( !ent || !ent.IsValid() || ent.IsEFlagSet( EFL_IS_BEING_LIFTED_BY_BARNACLE ) )
                        return true

                    if ( !activator.IsAlive() ) {

                        SetPropEntity( ent, "m_hPlayer", activator )
                        local life_state = GetPropInt( activator, "m_lifeState" )
                        SetPropInt( activator, "m_lifeState", LIFE_ALIVE )
                        EntFireByHandle( activator, "RunScriptCode", format( "SetPropInt( self, `m_lifeState`, %d )", life_state ), SINGLE_TICK, null, null )
                    }

                    if ( spawnflags & 256 ) {

                        ent.AddEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )
                        for ( local i = 1; i <= MAX_CLIENTS; i++ ) {

                            local player = PlayerInstanceFromIndex( i )
                            if ( player && player.IsValid() ) {

                                SetPropEntity( ent, "m_hPlayer", player )
                                local life_state = GetPropInt( player, "m_lifeState" )
                                SetPropInt( player, "m_lifeState", LIFE_ALIVE )
                                ent.AcceptInput( "Disable", "", player, player )
                                EntFireByHandle( player, "RunScriptCode", format( "SetPropInt( self, `m_lifeState`, %d )", life_state ), SINGLE_TICK, null, null )
                            }
                        }
                        ent.RemoveEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )
                    }
                    return true
                }

                ent.ValidateScriptScope()
                local scope = ent.GetScriptScope()
                scope.InputEnable <- InputEnable
                scope.Inputenable <- InputEnable
                scope.InputDisable <- InputDisable
                scope.Inputdisable <- InputDisable
            }
            //fix TeamNum not working
            //fix FireSound not working, added volume setting ( example: "sound_name_here.wav|40" )
            //fix ModelScale not working on arrows/rockets
            tf_point_weapon_mimic = function( ent, spawnflags ) {
                local particle = CreateByClassname( "trigger_particle" )
                ent.ValidateScriptScope()

                local modelscale = GetPropFloat( ent, "m_flModelScale" )
                local firesound = GetPropString( ent, "m_pzsFireSound" )

                ent.GetScriptScope().ProjectileFixes <- function() {

                    for ( local projectile; projectile = FindByClassnameWithin( projectile, "tf_projectile*", ent.GetOrigin(), 1 ); ) {

                        if ( projectile.GetEFlags() & EFL_NO_MEGAPHYSCANNON_RAGDOLL ) continue

                        if ( modelscale != 1 )
                            projectile.SetModelScale( modelscale, 0.0 )

                        if ( firesound != "" ) {

                            local vol = 1.0
                            if ( firesound.find( "|" ) ) {

                                local split = split( firesound, "|" )
                                firesound = split[0]
                                vol = split[1].tofloat()
                            }

                            EmitSoundEx( {sound_name = firesound, entity = ent, volume = vol} )
                        }

                        projectile.SetTeam( ent.GetTeam() )

                        if ( startswith( projectile.GetClassname(), "tf_projectile_pipe" ) ) {

                            projectile.SetSkin( ent.GetTeam() - 2 )
                            projectile.AcceptInput( "DispatchEffect", "ParticleEffectStop", null, null )

                            local particlename = ""

                            projectile.GetTeam() < 3 ? particlename = "pipebombtrail_red" : particlename = "pipebombtrail_blue"

                            particle.KeyValueFromString( "particle_name", particlename )
                            particle.KeyValueFromInt( "attachment_type", PATTACH_ABSORIGIN_FOLLOW )
                            particle.KeyValueFromInt( "spawnflags", SF_TRIGGER_ALLOW_ALL )

                            DispatchSpawn( particle )

                            EntFireByHandle( particle, "StartTouch", "!activator", -1, projectile, projectile )

                            if ( GetPropBool( ent, "m_bCrits" ) ) {

                                local particlecrits = projectile.GetTeam() < 3 ? "critical_pipe_red" : "critical_pipe_blue"

                                particle.KeyValueFromString( "particle_name", particlecrits )
                                EntFireByHandle( particle, "StartTouch", "!activator", -1, projectile, projectile )

                            }
                        }
                        projectile.AddEFlags( EFL_NO_MEGAPHYSCANNON_RAGDOLL )
                    }

                    return -1
                }
                AddThinkToEnt( ent, "ProjectileFixes" )
            }
        }
        Events = {

            function OnGameEvent_recalculate_holidays( _ ) {

                if ( GetRoundState() == GR_STATE_GAME_OVER )
                    EntFire( "player", "RunScriptCode", "DoEntFire( `point_viewcontrol`, `Disable`, ``, -1, self, self )" )
            }

            function OnGameEvent_round_start( _ ) {
                EntFire( "player", "RunScriptCode", "DoEntFire( `point_viewcontrol`, `Disable`, ``, -1, self, self )" )
            }

            function OnGameEvent_teamplay_round_start( _ ) {
                EntFire( "player", "RunScriptCode", "DoEntFire( `point_viewcontrol`, `Disable`, ``, -1, self, self )" )
            }
        }
    }
    __CollectGameEventCallbacks( EntAdditions.Events )
}

function Precache() {

    local classname = self.GetClassname()
    local spawnflags = GetPropInt( self, "m_spawnflags" )

    if ( classname in EntAdditions.Precache )
        EntAdditions.Precache[classname]( self, spawnflags )
}

function OnPostSpawn() {

    local classname = self.GetClassname()
    local spawnflags = GetPropInt( self, "m_spawnflags" )
    if ( classname in EntAdditions.OnPostSpawn )
        EntAdditions.OnPostSpawn[classname]( self, spawnflags )
}
