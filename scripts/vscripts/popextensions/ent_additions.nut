function Precache()
{
    local classname = self.GetClassname()
    if (classname == "obj_sentrygun" && GetPropInt(self, "m_spawnflags") & 64)
        SetPropBool(self, "m_bMiniBuilding", true);
}

function OnPostSpawn()
{
    local classname = self.GetClassname()
    if (endswith(classname, "_button"))
    {
        //https://github.com/ValveSoftware/source-sdk-2013/pull/401
        if (GetPropInt(self, "m_spawnflags") & SF_BUTTON_LOCKED)
            SetPropBool(self, "m_bLocked", true)

        //add non-solid spawnflag to func_button
        if (GetPropInt(self, "m_spawnflags") & 16384)
        {
            self.AddEFlags(EFL_USE_PARTITION_WHEN_NOT_SOLID)
            self.AddSolidFlags(FSOLID_NOT_SOLID)
        }
    }
    //add start disabled spawnflag
    else if (classname == "light_dynamic" && GetPropInt(self, "m_spawnflags") & 16)
        EntFireByHandle(self, "TurnOff", "", -1, null, null)

    //mini-sentry spawnflag
    else if (classname == "obj_sentrygun" && GetPropInt(self, "m_spawnflags") & 64)
    {
        self.SetModelScale(0.75, 0.0)
        self.SetSkin(self.GetSkin() + 2)
    }

    //fix func_rotating capping at 360,000 degrees
    else if (classname == "func_rotating")
    {
        local thinkinterval = 1
        local maxangle = 180000.0 //max angle is actually 360,000.0 not 180,000.0.  Reset it early because whatever
        local xyz = [0.0, 0.0, 0.0]

        self.ValidateScriptScope()
        self.GetScriptScope().RotateFixThink <- function() {
            for (local i = 0; i < 3; i++)
            {
                xyz[i] = GetPropFloat(self, format("m_angRotation[%d]", i))
                if ( xyz[i] == 0.0 || xyz[i] < maxangle) continue

                xyz[i] %= 360.0
                // xyz[i] = 0; //jitter on reset
                self.SetLocalAngles(QAngle(xyz[0], xyz[1], xyz[2]))
                break
            }
            return thinkinterval
        }
        AddThinkToEnt(self, "RotateFixThink")

        //fix killing func_rotating before stopping sound causing sound to play forever
        //UNTESTED

        self.AddEFlags(EFL_KILLME)
        function InputKill()
        {
            self.RemoveEFlags(EFL_KILLME)
            SetPropFloat(self, "m_flVolume", 0.01)
            self.StopSound(GetPropString(self, "m_NoiseRunning"))
            self.Kill()
            return false
        }
        function InputKillHierarchy()
        {
            self.RemoveEFlags(EFL_KILLME)
            SetPropFloat(self, "m_flVolume", 0.01)
            self.StopSound(GetPropString(self, "m_NoiseRunning"))
            self.Kill()
            return false
        }
        self.ValidateScriptScope()
        self.GetScriptScope().InputKill <- InputKill
        self.GetScriptScope().Inputkill <- InputKill
        self.GetScriptScope().InputKillHierarchy <- InputKillHierarchy
        self.GetScriptScope().Inputkillhierarchy <- InputKillHierarchy
        InputKillHierarchy()
    }
    else if (classname == "tf_point_weapon_mimic")
    {
        local particle = CreateByClassname("trigger_particle")
        self.ValidateScriptScope()

        local modelscale = GetPropFloat(self, "m_flModelScale")
        local firesound = GetPropString(self, "m_pzsFireSound")

        self.GetScriptScope().ProjectileFixes <- function()
        {
            for (local projectile; projectile = FindByClassnameWithin(projectile, "tf_projectile*", self.GetOrigin(), 1);)
            {
                if (projectile.GetEFlags() & EFL_NO_MEGAPHYSCANNON_RAGDOLL) continue

                if (modelscale != 1)
                    projectile.SetModelScale(modelscale, 0.0)

                if (firesound != "")
                {
                    local vol = 1.0
                    if (firesound.find("|"))
                    {
                        local split = split(firesound, "|")
                        firesound = split[0]
                        vol = split[1].tofloat()
                    }

                    EmitSoundEx({sound_name = firesound, entity = self, volume = vol})
                }

                projectile.SetTeam(self.GetTeam())

                if (startswith(projectile.GetClassname(), "tf_projectile_pipe"))
                {
                    projectile.SetSkin(self.GetTeam() - 2)
                    EntFireByHandle(projectile, "DispatchEffect", "ParticleEffectStop", -1, null, null)

                    local particlename = ""

                    projectile.GetTeam() < 3 ? particlename = "pipebombtrail_red" : particlename = "pipebombtrail_blue"

                    particle.KeyValueFromString("particle_name", particlename)
                    particle.KeyValueFromInt("attachment_type", PATTACH_ABSORIGIN_FOLLOW)
                    particle.KeyValueFromInt("spawnflags", SF_TRIGGER_ALLOW_ALL)

                    DispatchSpawn(particle)

                    EntFireByHandle(particle, "StartTouch", "!activator", -1, projectile, projectile)

                    if (GetPropBool(self, "m_bCrits"))
                    {
                        local particlecrits = ""

                        projectile.GetTeam() < 3 ? particlecrits = "critical_pipe_red" : particlecrits = "critical_pipe_blue"

                        particle.KeyValueFromString("particle_name", particlecrits)
                        EntFireByHandle(particle, "StartTouch", "!activator", -1, projectile, projectile)

                    }
                }
                projectile.AddEFlags(EFL_NO_MEGAPHYSCANNON_RAGDOLL)
            }

            return -1
        }
        AddThinkToEnt(self, "ProjectileFixes")
    }
}

::RotateEvent <- {
    function OnGameEvent_recalculate_holidays(_)
    {
        if (GetRoundState() != GR_STATE_PREROUND) return

        for (local rotate; rotate = FindByClassname(rotate, "func_rotating");)
            EntFireByHandle(rotate, "Kill", "", -1, null, null)
    }
}
__CollectGameEventCallbacks(RotateEvent)
