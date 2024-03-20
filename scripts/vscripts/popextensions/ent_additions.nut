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
        if (GetPropInt(self, "m_spawnflags") & 2048)
            SetPropBool(self, "m_bLocked", true)

        //add non-solid spawnflag to func_button
        if (GetPropInt(self, "m_spawnflags") & 16384)
            self.SetSolid(0)
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
        self.GetScriptScope().RotateFixThink <- function()
        {
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
    ::RotateEvent <- {
        function OnGameEvent_recalculate_holidays(_)
        {
            if (GetRoundState() != GR_STATE_PREROUND) return

            for (local rotate; rotate = FindByClassname(rotate, "func_rotating");)
                EntFireByHandle(rotate, "Kill", "", -1, null, null)
        }
    }
    __CollectGameEventCallbacks(RotateEvent);
}