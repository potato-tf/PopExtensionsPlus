// fold constants/functions again here so this can be standalone
::CONST <- getconsttable()
::ROOT  <- getroottable()

CONST.setdelegate( { _newslot = @( k, v ) compilestring( "const " + k + "=" + ( typeof v == "string" ? ( "\"" + v + "\"" ) : v ) )() } )
CONST.MAX_CLIENTS <- MaxClients().tointeger()

// fold every class into the root table for performance
foreach( _class in [ "NetProps", "Entities", "EntityOutputs", "NavMesh", "Convars" ])
    foreach( k, v in ROOT[_class].getclass() )
        if ( !( k in ROOT ) && k != "IsValid" )
            ROOT[k] <- ROOT[_class][k].bindenv( ROOT[_class] )

if ( !( "ConstantNamingConvention" in ROOT ) ) {

    foreach( a, b in Constants ) {

        foreach( k, v in b ) {

            if ( k in CONST )
                continue

            if ( v == null )
                v = 0

            CONST[k] <- v
            ROOT[k]  <- v
        }
    }
}

local SINGLE_TICK = FrameTime()

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
                    function _get ( k ) {

                        return parent[k]
                    }
                    function _delslot ( k ) {

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
            function obj_sentrygun ( ent, spawnflags ) {
                if ( spawnflags & 64 )
                    SetPropBool( ent, "m_bMiniBuilding", true )
            }
        }
        OnPostSpawn = {
            //non-solid spawnflag
            function func_button ( ent, spawnflags ) {
                if ( spawnflags & 16384 ) {

                    ent.AddEFlags( EFL_USE_PARTITION_WHEN_NOT_SOLID )
                    ent.AddSolidFlags( FSOLID_NOT_SOLID )
                }
            }
            function func_rot_button ( ent, spawnflags ) {
                //fix broken locked spawnflag
                if ( spawnflags & SF_BUTTON_LOCKED )
                    SetPropBool( ent, "m_bLocked", true )
            }
            //mini-sentry spawnflag
            function obj_sentrygun ( ent, spawnflags ) {
                if ( spawnflags & 64 ) {

                    ent.SetModelScale( 0.75, 0.0 )
                    ent.SetSkin( ent.GetSkin() + 2 )
                }
            }
            //fix invulnerable flag not working
            function obj_dispenser ( ent, spawnflags ) {
                if ( spawnflags & 2 )
                    SetPropInt( ent, "m_takedamage", 0 )
            }
            //start disabled spawnflag
            function light_dynamic ( ent, spawnflags ) {
                if ( spawnflags & 16 )
                    ent.AcceptInput( "TurnOff", "", null, null )
            }
            //fix func_rotating capping at 360,000 degrees
            //fix killing func_rotating before stopping sound causing sound to play forever
            function func_rotating ( ent, spawnflags ) {

                local maxangle = 350000.0 //max angle is actually 360,000.0, reset it a bit earlier just in case
                local xyz = array( 3, 0.0 )
                ent.ValidateScriptScope()
                local scope = ent.GetScriptScope()

                function RotateFixThink() {

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
                scope.RotateFixThink <- RotateFixThink
                AddThinkToEnt( ent, "RotateFixThink" )
                scope.noise <- GetPropString( ent, "m_NoiseRunning" )

                EntAdditions.SetDestroyCallback( ent, @() StopAmbientSoundOn( self.GetScriptScope().noise, self ) )
            }
            // add spawnflag to apply to all players
            // add spawnflag to allow for taking damage
            // fix not being able to disable on dead players
            // fix persisting between map/round changes
            function point_viewcontrol ( ent, spawnflags ) {

                function InputEnable() {

                    if ( !ent || !ent.IsValid() )
                        return true

                    if ( spawnflags & 512 ) {

                        local takedamage = GetPropInt( activator, "m_takedamage" )
                        SetPropEntity( ent, "m_hPlayer", null )
                        local cmd = "SetPropInt( self, `m_takedamage`, " + takedamage + " )"
                        EntFireByHandle( activator, "RunScriptCode", cmd, SINGLE_TICK, null, null )
                        if ( "PopGameStrings" in ROOT )
                            PopGameStrings.AddStrings( cmd )
                    }
                    if ( ent.IsEFlagSet( EFL_IS_BEING_LIFTED_BY_BARNACLE ) )
                        return true

                    if ( spawnflags & 256 ) {

                        ent.AddEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )

                        for ( local i = 1, player; i <= MAX_CLIENTS; player = PlayerInstanceFromIndex( i ), i++ ) {

                            if ( !player ) continue

                            ent.AcceptInput( "Enable", "", player, player )
                            SetPropEntity( ent, "m_hPlayer", player )
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

                        local cmd = "SetPropInt( self, `m_lifeState`, " + life_state + " )"
                        EntFireByHandle( activator, "RunScriptCode", cmd, SINGLE_TICK, null, null )

                        if ( "PopGameStrings" in ROOT )
                            PopGameStrings.AddStrings( cmd )
                    }

                    if ( spawnflags & 256 ) {

                        ent.AddEFlags( EFL_IS_BEING_LIFTED_BY_BARNACLE )

                        for ( local i = 1, player; i <= MAX_CLIENTS; player = PlayerInstanceFromIndex( i ), i++ ) {

                            if ( !player ) continue

                            SetPropEntity( ent, "m_hPlayer", player )
                            local life_state = GetPropInt( player, "m_lifeState" )
                            SetPropInt( player, "m_lifeState", LIFE_ALIVE )
                            ent.AcceptInput( "Disable", "", player, player )

                            local cmd = "SetPropInt( self, `m_lifeState`, " + life_state + " )"
                            EntFireByHandle( player, "RunScriptCode", cmd, SINGLE_TICK, null, null )

                            if ( "PopGameStrings" in ROOT )
                                PopGameStrings.AddStrings( cmd )

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
            function tf_point_weapon_mimic ( ent, spawnflags ) {

                local particle = CreateByClassname( "trigger_particle" )
                ent.ValidateScriptScope()

                local modelscale = GetPropFloat( ent, "m_flModelScale" )
                local firesound = GetPropString( ent, "m_pzsFireSound" )

                function ProjectileFixes() {

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
                ent.GetScriptScope().ProjectileFixes <- ProjectileFixes
                AddThinkToEnt( ent, "ProjectileFixes" )
            }
        }
        Events = {

            function _DisableAll() {

                local cmd = "DoEntFire( `point_viewcontrol`, `Disable`, ``, -1, self, self )"
                EntFire( "player", "RunScriptCode", cmd )

                if ( "PopGameStrings" in ROOT )
                    PopGameStrings.AddStrings( cmd )
            }

            function OnGameEvent_recalculate_holidays( _ ) { if ( GetRoundState() == GR_STATE_GAME_OVER ) _DisableAll() }
            function OnGameEvent_round_start( _ ) { _DisableAll() }
            function OnGameEvent_teamplay_round_start( _ ) { _DisableAll() }
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
