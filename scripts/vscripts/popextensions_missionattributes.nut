local classes = ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere
::MissionAttributes <- {

    CurrAttrs = [] // Array storing currently modified attributes.

    ConVars = {} //table storing original convar values
    
    ThinkTable = { //sub-think table.  Pre-fill with some global fixes

        //remove with MissionAttr("ReflectableDF", 1)
        DragonsFuryFix = function()
        {
            for (local fireball; fireball = Entities.FindByClassname(fireball, "tf_projectile_balloffire");)
                rocket.RemoveFlag(2097152); //FL_GRENADE
        }
    }
    
    TakeDamageTable = {}
    SpawnHookTable = {}
    DeathHookTable = {}
   
    DebugText = false
    RaisedParseError = false
};

local pumpkinIndex = PrecacheModel("models/props_halloween/pumpkin_loot.mdl");
local resource = Entities.FindByClassname(null, "tf_objective_resource");

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

local MissionAttrEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_missionattributes_ent"});
printl(MissionAttrEntity.GetClassname())
function MissionAttributes::SetConvar(convar, value)
{
    //save original values to restore later
    if (!(convar in MissionAttributes.ConVars))
        MissionAttributes.ConVars[convar] <- Convars.GetStr(convar);
    
    if (Convars.GetStr(convar) != value)
        Convars.SetValue(convar, value);
}

function MissionAttributes::ResetConvars()
{
    foreach (convar, value in MissionAttributes.ConVars)
        Convars.SetValue(convar, value);
    MissionAttributes.ConVars.clear()
}

function MissionAttributes::MissionAttr(attr, value = 0)
{
    local success = true;
    switch(attr) {
    
    // =========================================================
    case "ForceHoliday":
    // Replicates sigsegv-mvm: ForceHoliday.
    // Forces a tf_holiday for the mission.
    // Supported Holidays are:
    //  0 - None
    //  1 - Birthday
    //  2 - Halloween
    //  3 - Christmas
    // @param Holiday       Holiday number to force.
    // @error TypeError     If type is not an integer.
    // @error IndexError    If invalid holiday number is passed.
        // Error Handling
        if (type(value) != "integer") {RaiseTypeError(attr, "int"); success = false; break;}
        if (value < 0 || value > 2) {RaiseIndexError(attr); success = false; break;}
        
        // Set Holiday logic
        SetConvar("tf_forced_holiday", value);
        if (value == 0) break;
        
        local ent = Entities.FindByName(null, "MissionAttrHoliday");
        if (ent != null) ent.Kill();
        SpawnEntityFromTable("tf_logic_holiday", 
        {
            targetname = "MissionAttrHoliday",
            holiday_type = value
        });
        
        break;
    // ========================================================
    
    case "NoCrumpkins":

        function MissionAttributes::NoCrumpkins()
        {

            // printl("NoCrumpkins")
            for (local pumpkin; pumpkin = Entities.FindByClassname(pumpkin, "tf_ammo_pack");)
                if (pumpkin.GetModelIndex() == pumpkinIndex)
                    EntFireByHandle(pumpkin, "Kill", "", -1, null, null); //should't do .Kill() in the loop, entfire kill is delayed to the end of the frame.
                
            for (local i = 1, player; i <= MaxClients(); i++)
                if (player = PlayerInstanceFromIndex(i), player && player.InCond(33)) //TF_COND_CRITBOOSTED_PUMPKIN
                    EntFireByHandle(player, "RunScriptCode", "self.RemoveCond(33)", -1, null, null); 
        }
        MissionAttributes.ThinkTable.NoCrumpkins <- MissionAttributes.NoCrumpkins;
        break;

    // =========================================================

    case "NoReanimators":

        function MissionAttributes::NoReanimators()
        {
            for (local revivemarker; revivemarker = Entities.FindByClassname(revivemarker, "entity_revive_marker");) 
                EntFireByHandle(revivemarker, "Kill", "", -1, null, null);
        }
        MissionAttributes.DeathHookTable.NoReanimators <- MissionAttributes.NoReanimators;
        break;

    // =========================================================

    case "666Wavebar":

        NetProps.SetPropInt(resource, "m_nMvMEventPopfileType", value);
        printl(NetProps.GetPropInt(resource, "m_nMannVsMachineWaveCount"))
        break;

    // =========================================================

    //all of these could just be set directly in the pop easily, however popfile's have a 4096 character limit for vscript so might as well save space
    case "NoRefunds":

        SetConvar("tf_mvm_respec_enabled", 0);
        break;

    case "RefundLimit":
        
        SetConvar("tf_mvm_respec_enabled", 1);
        SetConvar("tf_mvm_respec_limit", value);
        break;

    case "RefundGoal":

        SetConvar("tf_mvm_respec_enabled", 1);
        SetConvar("tf_mvm_respec_credit_goal", value);
        break;

    case "FixedBuybacks":
        SetConvar("tf_mvm_buybacks_method", 1);
        break;

    case "BuybacksPerWave":
        SetConvar("tf_mvm_buybacks_per_wave", value);
        break;

    case "NoBuybacks":
        SetConvar("tf_mvm_buybacks_method", 1);
        SetConvar("tf_mvm_buybacks_per_wave", 0);
        break;

    case "DeathPenalty":
        SetConvar("tf_mvm_death_penalty", value);
        break;

    case "BonusRatioHalf":
        SetConvar("tf_mvm_currency_bonus_ratio_min", value);
        break;

    case "BonusRatioFull":
        SetConvar("tf_mvm_currency_bonus_ratio_max", value);
        break;

    case "UpgradeFile":
        DoEntFire("tf_gamerules", "SetCustomUpgradesFile", value, -1, null, null);
        break;

    case "FlagEscortCount":
        SetConvar("tf_bot_flag_escort_max_count", value);
        break;

    // =========================================================

    case "SniperHideLasers":
        function MissionAttributes::SniperHideLasers()
        {
            // printl("SniperHideLasers")
            for (local dot; dot = Entities.FindByClassname(dot, "env_sniperdot");)
                if (dot.GetOwner().GetTeam() == 3)
                    EntFireByHandle(dot, "Kill", "", -1, null, null);

            for (local dot; dot = Entities.FindByClassname(dot, "env_laserdot");)
                if (dot.GetOwner().GetTeam() == 3)
                    EntFireByHandle(dot, "Kill", "", -1, null, null);
            return -1;
        }
        MissionAttributes.ThinkTable.SniperHideLasers <- MissionAttributes.SniperHideLasers;
        break;

    // =========================================================

    case "NoBusterFF":
        function MissionAttributes::NoBusterFriendlyFire()
        {
            local attacker = params.attacker, victim = params.const_entity;
            //should probably check playermodel instead.  Edge cases with non-buster giant demos may cause problems
            if (IsPlayer(victim) && IsPlayerABot(attacker) && IsPlayerABot(victim) && victim.GetTeam() == attacker.GetTeam() && attacker.GetPlayerClass() == 4 && attacker.IsMiniBoss()) //4 = TF_CLASS_DEMOMAN
            {
                params.early_out = true;
                return false;
            }
        }
        MissionAttributes.TakeDamageTable.NoBusterFriendlyFire <- MissionAttributes.NoBusterFriendlyFire;
        break;
    
    // =========================================================

    //set to 1 for RED players, 2 for BLU players
    case "PlayersAreRobots":

        function MissionAttributes::BluPlayersAreRobots(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            if (player.IsBotOfType(1337) || player.GetTeam() != value + 1) return;
            EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", classes[bot.GetPlayerClass()]), -1, null, null);
        }
        MissionAttributes.SpawnHookTable.BluPlayersAreRobots <- MissionAttributes.BluPlayersAreRobots;
        break;

    // =========================================================

    case "BotsAreHumans":

        function MissionAttributes::BotsAreHumans(params)
        {
            printl("BotsAreHumans")
            local player = GetPlayerFromUserID(params.userid)
            if (!player.IsBotOfType(1337)) return;
            EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", classes[bot.GetPlayerClass()]), -1, null, null);
        }
        MissionAttributes.SpawnHookTable.BotsAreHumans <- MissionAttributes.BotsAreHumans;
        break;
    
    // =========================================================

    case "NoRome":
        function MissionAttributes::NoRome(params)
        {
            printl("NoRome")
            if (GetPlayerFromUserID(params.userid).IsBotOfType(1337))
                for (local child = GetPlayerFromUserID(params.userid).FirstMoveChild(); child != null; child = child.NextMovePeer())
                    if (child.GetClassname() == "tf_wearable" && startswith(child.GetModelName(), "tw_"))
                        EntFireByHandle(child, "Kill", "", -1, null, null);

            //set value to 2 to also kill the carrier tank addon model
            if (value < 2) return

            // local carrierAddonIndex = PrecacheModel("bots/tw2/boss_bot/twcarrier_addon.mdl")
            for (local props; props = FindByClassname(props, "prop_dynamic");)
            {
                if (!props.GetModelName() == "bots/tw2/boss_bot/twcarrier_addon.mdl") continue;
        
                EntFireByHandle(props, "Kill", "", -1, null, null);
                break;
            }
        }
        MissionAttributes.SpawnHookTable.NoRome <- MissionAttributes.NoRome;
        break;
    
    // =========================================================

    case "ReflectableDF":
        if ("DragonsFuryFix" in MissionAttributes.ThinkTable)
            delete MissionAttributes.ThinkTable.DragonsFuryFix
        break;
    // Don't add attribute to clean-up list if it could not be found.
    default:
        ParseError(format("Could not find mission attribute '%s'", attr));
        success = false;
    }
    
    // Add attribute to clean-up list if its modification was successful.
    if (success)
    {
        DebugLog(format("Added mission attribute %s", attr));
        MissionAttributes.CurrAttrs.append(attr);
    }
}

function MissionAttrThink()
{
    foreach (_, func in MissionAttributes.ThinkTable) func()
}

MissionAttrEntity.ValidateScriptScope();
MissionAttrEntity.GetScriptScope().MissionAttrThink <- MissionAttrThink
AddThinkToEnt(MissionAttrEntity, "MissionAttrThink")

::MissionAttrEvents <- {
    function OnScriptHook_OnTakeDamage(params)
    {
        foreach (_, func in MissionAttributes.TakeDamageTable) func()
    }
    function OnGameEvent_player_spawn(params)
    {
        foreach (_, func in MissionAttributes.SpawnHookTable) func()
    }
    function OnGameEvent_player_death(params)
    {
        foreach (_, func in MissionAttributes.DeathHookTable) func()
    }
    function GameEvent_teamplay_round_start(params)
    {
        ResetDefaults();
        delete MissionAttrEvents;
    }
    // Hook all wave inits to reset parsing error counter.
    function OnGameEvent_recalculate_holidays(params)
    {
        if (GetRoundState() != 3) return;

        MissionAttributes.RaisedParseError = false;
    }
}

// Allow calling MissionAttributes::MissionAttr() directly with MissionAttr().
function MissionAttr(attr, value)
{
    MissionAttr.call(MissionAttributes, attr, value)
}

// Clean-up Functions
// =========================================================
// Function runs the appropriate clean-up method for the provided attribute.
function MissionAttributes::DoCleanupMethod(attr)
{
    //restore old cvars
    DebugLog(format("Cleaned up mission attribute %s", attr));
}

// Function resets and clears all registered changed attributes.
function MissionAttributes::ResetDefaults()
{
    foreach (attr in MissionAttributes.CurrAttrs)
        DoCleanupMethod(attr);
    
    ResetConvars();
    MissionAttributes.CurrAttrs.clear();
}

// Logging Functions
// =========================================================
// Generic debug message that is visible if PrintDebugText is true.
// Example: Print a message that the script is working as expected.
function MissionAttributes::DebugLog(LogMsg)
{
    if (MissionAttributes.DebugText)
    {
        ClientPrint(null, 2, format("missionattributes.nut: %s.", LogMsg));
    }
}

// Raises an error if the user passes an index that is out of range.
// Example: Allowed values are 1-2, but user passed 3.
function MissionAttributes::RaiseIndexError(attr) ParseError(format("Index out of range for %s", attr));

// Raises an error if the user passes an argument of the wrong type.
// Example: Allowed values are strings, but user passed a float.
function MissionAttributes::RaiseTypeError(attr, type) ParseError(format("Bad type for %s (should be %s)", attr, type));

// Raises a template parsing error, if nothing else fits.
function MissionAttributes::ParseError(ErrorMsg)
{
    if (!MissionAttributes.RaisedParseError)
    {
        MissionAttributes.RaisedParseError = true;
        ClientPrint(null, 3, "\x08FFB4B4FFIt is possible that a parsing error has occured. Check console for details.");
    }
    ClientPrint(null, 2, format("missionattributes.nut ERROR: %s.", ErrorMsg));
}

// Raises an exception.
// Example: Script modification has not been performed correctly. User should never see one of these.
function MissionAttributes::RaiseException(ExceptionMsg)
{
    Assert(false, format("missionattributes.nut EXCEPTION: %s.", ExceptionMsg));
}

// =========================================================
// Register MissionAttributes callbacks.
__CollectGameEventCallbacks(MissionAttrEvents);
