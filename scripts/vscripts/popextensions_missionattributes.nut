local classes = ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere

::MissionAttributes <- {

    CurrAttrs = [] // Array storing currently modified attributes.

    ConVars = {} //table storing original convar values

    ThinkTable = { //sub-think table.  Pre-fill with some global fixes

        //remove with MissionAttr("ReflectableDF", 1)
        DragonsFuryFix = function()
        {
            for (local fireball; fireball = Entities.FindByClassname(fireball, "tf_projectile_balloffire");)
                fireball.RemoveFlag(FL_GRENADE);
        }
    }

    TakeDamageTable = {}
    SpawnHookTable = {}
    DeathHookTable = {}
    InitWaveTable = {}
    DisconnectTable = {}

    DebugText = false
    RaisedParseError = false
};

local resource = Entities.FindByClassname(null, "tf_objective_resource");

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

local MissionAttrEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_missionattr_ent"});

function MissionAttributes::SetConvar(convar, value, hideChatMessage = true)
{
    local commentaryNode = Entities.FindByClassname(null, "point_commentary_node")
    if (commentaryNode == null && hideChatMessage) commentaryNode = SpawnEntityFromTable("point_commentary_node", {})

    //save original values to restore later
    if (!(convar in MissionAttributes.ConVars))
        MissionAttributes.ConVars[convar] <- Convars.GetStr(convar);

    if (Convars.GetStr(convar) != value) Convars.SetValue(convar, value);

    EntFireByHandle(commentaryNode, "Kill", "", 1.1, null, null)
}

function MissionAttributes::ResetConvars()
{
    foreach (convar, value in MissionAttributes.ConVars)
        Convars.SetValue(convar, value);
    MissionAttributes.ConVars.clear()
}

local noRomeCarrier = false;
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

        local pumpkinIndex = PrecacheModel("models/props_halloween/pumpkin_loot.mdl");
        function MissionAttributes::NoCrumpkins()
        {
            // printl("NoCrumpkins")
            switch(value)
            {

                case 1:

                for (local pumpkin; pumpkin = Entities.FindByClassname(pumpkin, "tf_ammo_pack");)
                    if (NetProps.GetPropInt(pumpkin, "m_nModelIndex") == pumpkinIndex)
                        EntFireByHandle(pumpkin, "Kill", "", -1, null, null); //should't do .Kill() in the loop, entfire kill is delayed to the end of the frame.
            }
            for (local i = 1, player; i <= MaxClients(); i++)
                if (player = PlayerInstanceFromIndex(i), player && player.InCond(TF_COND_CRITBOOSTED_PUMPKIN)) //TF_COND_CRITBOOSTED_PUMPKIN
                    EntFireByHandle(player, "RunScriptCode", "self.RemoveCond(TF_COND_CRITBOOSTED_PUMPKIN)", -1, null, null);
        }
        MissionAttributes.ThinkTable.NoCrumpkins <- MissionAttributes.NoCrumpkins;
        break;

    // =========================================================

    case "NoReanimators":

        function MissionAttributes::NoReanimators(params)
        {
            for (local revivemarker; revivemarker = Entities.FindByClassname(revivemarker, "entity_revive_marker");)
                EntFireByHandle(revivemarker, "Kill", "", -1, null, null);
        }
        MissionAttributes.DeathHookTable.NoReanimators <- MissionAttributes.NoReanimators;
        break;

    // =========================================================

    case "666Wavebar": //doesn't work until wave switches, won't work on W1

        NetProps.SetPropInt(resource, "m_nMvMEventPopfileType", value);
        break;

    // =========================================================

    //all of these could just be set directly in the pop easily, however popfile's have a 4096 character limit for vscript so might as well save space
    case "NoRefunds":

        SetConvar("tf_mvm_respec_enabled", 0);
        break;

    // =========================================================

    case "RefundLimit":

        SetConvar("tf_mvm_respec_enabled", 1);
        SetConvar("tf_mvm_respec_limit", value);
        break;

    // =========================================================

    case "RefundGoal":

        SetConvar("tf_mvm_respec_enabled", 1);
        SetConvar("tf_mvm_respec_credit_goal", value);
        break;

    // =========================================================

    case "FixedBuybacks":

        SetConvar("tf_mvm_buybacks_method", 1);
        break;

    // =========================================================

    case "BuybacksPerWave":

        SetConvar("tf_mvm_buybacks_per_wave", value);
        break;

    // =========================================================

    case "NoBuybacks":

        SetConvar("tf_mvm_buybacks_method", value);
        SetConvar("tf_mvm_buybacks_per_wave", 0);
        break;

    // =========================================================

    case "DeathPenalty":

        SetConvar("tf_mvm_death_penalty", value);
        break;

    // =========================================================

    case "BonusRatioHalf":

        SetConvar("tf_mvm_currency_bonus_ratio_min", value);
        break;

    // =========================================================

    case "BonusRatioFull":

        SetConvar("tf_mvm_currency_bonus_ratio_max", value);
        break;

    // =========================================================

    case "UpgradeFile":

        DoEntFire("tf_gamerules", "SetCustomUpgradesFile", value, -1, null, null);
        break;

    // =========================================================

    case "FlagEscortCount":

        SetConvar("tf_bot_flag_escort_max_count", value);
        break;

    // =========================================================

    case "BombMovementPenalty":
        
        SetConvar("tf_mvm_bot_flag_carrier_movement_penalty", value);
        break;

    case "MaxSkeletons":

        SetConvar("tf_max_active_zombie", value);
        break;

    // =========================================================

    case "SniperHideLasers":

        function MissionAttributes::SniperHideLasers()
        {
            // printl("SniperHideLasers")
            for (local dot; dot = Entities.FindByClassname(dot, "env_sniperdot");)
                if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
                    EntFireByHandle(dot, "Kill", "", -1, null, null);

            for (local dot; dot = Entities.FindByClassname(dot, "env_laserdot");)
                if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
                    EntFireByHandle(dot, "Kill", "", -1, null, null);
            return -1;
        }
        if (!(MissionAttributes.SniperHideLasers in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.SniperHideLasers <- MissionAttributes.SniperHideLasers;
        break;

    // =========================================================

    case "NoBusterFF":

        function MissionAttributes::NoBusterFF(params)
        {
            local attacker = params.attacker, victim = params.const_entity;
            //should probably check playermodel instead.  Edge cases with non-buster giant demos may cause problems
            if (IsPlayer(victim) && IsPlayerABot(attacker) && IsPlayerABot(victim) && victim.GetTeam() == attacker.GetTeam() && attacker.GetPlayerClass() == TF_CLASS_DEMOMAN && attacker.IsMiniBoss())
            {
                params.early_out = true;
                return false;
            }
        }
        if (!(MissionAttributes.NoBusterFF in MissionAttributes.TakeDamageTable))
            MissionAttributes.TakeDamageTable.NoBusterFF <- MissionAttributes.NoBusterFF;
        break;

    // =========================================================

    //set to 1 for RED players, 2 for BLU players
    case "PlayersAreRobots":

        function MissionAttributes::PlayersAreRobots(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            if (player.IsBotOfType(1337) || player.GetTeam() != value + 1) return;
            EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", classes[bot.GetPlayerClass()]), -1, null, null);
        }
        if (!(MissionAttributes.PlayersAreRobots in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.PlayersAreRobots <- MissionAttributes.PlayersAreRobots;
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

        if (!(MissionAttributes.BotsAreHumans in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.BotsAreHumans <- MissionAttributes.BotsAreHumans;
        break;

    // =========================================================

    case "NoRome":

        local carrierPartsIndex = GetModelIndex("models/bots/boss_bot/carrier_parts.mdl")
        function MissionAttributes::NoRome(params)
        {
            local bot = GetPlayerFromUserID(params.userid)
            if (bot.IsBotOfType(1337))
                for (local child = bot.FirstMoveChild(); child != null; child = child.NextMovePeer())
                    if (child.GetClassname() == "tf_wearable" && startswith(child.GetModelName(), "models/workshop/player/items/"+classes[bot.GetPlayerClass()]+"/tw"))
                        EntFireByHandle(child, "Kill", "", -1, null, null);

            //set value to 2 to also kill the carrier tank addon model
            if (value < 2 || noRomeCarrier) return

            local carrier = Entities.FindByName(null, "botship_dynamic") //some maps have a targetname for it
    
            if (carrier == null)
            {
                for (local props; props = Entities.FindByClassname(props, "prop_dynamic");)
                {
                    if (NetProps.GetPropInt(props, "m_nModelIndex") != carrierPartsIndex) continue;

                    carrier = props
                    break;
                }

            }
            NetProps.SetPropIntArray(carrier, "m_nModelIndexOverrides", carrierPartsIndex, 3);
            noRomeCarrier = true;
        }
        if (!(MissionAttributes.NoRome in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.NoRome <- MissionAttributes.NoRome;
        break;

    // =========================================================

    case "SpellDropRateCommon":

        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::SpellDropRateCommon(params)
        {
            if (RandomFloat(0, 1) > value) return;

            local bot = GetPlayerFromUserID(params.userid);

            if (!bot.IsBotOfType(1337) || bot.IsMiniBoss()) return;

            local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_commonspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" });
        }
        if (!(MissionAttributes.SpellDropRateCommon in MissionAttributes.DeathHookTable))
            MissionAttributes.DeathHookTable.SpellDropRateCommon <- MissionAttributes.SpellDropRateCommon
        break;

    // =========================================================

    case "SpellDropRateGiant":

        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::SpellDropRateCommon(params)
        {
            if (RandomFloat(0, 1) > value) return;

            local bot = GetPlayerFromUserID(params.userid);

            if (!bot.IsBotOfType(1337) || !bot.IsMiniBoss()) return;

            local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_giantspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" });
        }
        if (!(MissionAttributes.SpellDropRateCommon in MissionAttributes.DeathHookTable))
            MissionAttributes.DeathHookTable.SpellDropRateCommon <- MissionAttributes.SpellDropRateCommon
        break;

    // =========================================================

    case "GiantsRareSpells":

        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::GiantsRareSpells()
        {
            for (local spells; spells = Entities.FindByName(spells, "_giantspell");)
                NetProps.SetPropInt(spells, "m_nTier", 1)
        }

        if (!(MissionAttributes.GiantsRareSpells in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.GiantsRareSpells <- MissionAttributes.GiantsRareSpells;
        break;

    // =========================================================

    case "GrapplingHookEnable":

        SetConvar("tf_grapplinghook_enable", value);
        break;

    // =========================================================

    case "MiniBossScale":

        SetConvar("tf_mvm_miniboss_scale", value);
        break;

    // =========================================================

    case "NoSkeleSplit":

        function MissionAttributes::NoSkeleSplit()
        {
            //kill skele spawners before they split from tf_zombie_spawner
            for (local skelespell; skelespell = FindByClassname(skelespell, "tf_projectile_spellspawnzombie"); )
                if (NetProps.GetPropEntity(skelespell, "m_hThrower") == null)
                    EntFireByHandle(skelespell, "Kill", "", -1, null, null);

            // m_hThrower does not change when the skeletons split for spell-casted skeles, just need to kill them after spawning
            for (local skeles; skeles = FindByClassname(skeles, "tf_zombie");  )
            {
                //kill blu split skeles
                if (skeles.GetModelScale() == 0.5 && NetProps.GetPropEntity(skelespell, "m_hThrower").IsBotOfType(1337))
                {
                    EntFireByHandle(skeles, "Kill", "", -1, null, null);
                    return;
                }
                if (skeles.GetTeam() == 5)
                {
                    skeles.SetTeam(TF_TEAM_PVE_INVADERS);
                    skeles.SetSkin(1);
                }
                // smoove skele, unfinished

                // local locomotion = skeles.GetLocomotionInterface();
                // locomotion.Reset();
                // skeles.FlagForUpdate(true);
                // locomotion.ComputeUpdateInterval(); //not necessary
                // foreach (a in areas)
                // {
                //     if (a.GetPlayerCount(TF_TEAM_PVE_DEFENDERS) < 1) continue;

                //     skeles.ClearImmobileStatus();
                //     locomotion.SetDesiredSpeed(280.0);
                //     locomotion.Approach(a.FindRandomSpot(), 999.0);
                // }
            }
        }
        if (!(MissionAttributes.NoSkeleSplit in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.NoSkeleSplit <- MissionAttributes.NoSkeleSplit;

        break;

    // =========================================================
    case "WaveStartCountdown":

        local gamerules = Entities.FindByClassname(null, "tf_gamerules")
        local resource = Entities.FindByClassname(null, "tf_objective_resource")
        local playerarray = []
        function MissionAttributes::PlayerCounter(params)
        {
            local player = GetPlayerFromUserID(params.userid)

            if (player.IsBotOfType(1337)) return;

            if (playerarray.find(player) == null)
                playerarray.append(player);
        }

        if (!(MissionAttributes.PlayerCounter in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.PlayerCounter <- MissionAttributes.PlayerCounter;

        function MissionAttributes::PlayerUnCounter(params)
        {
            local player = GetPlayerFromUserID(params.userid)

            for (local i = playerarray.len() - 1; i >= 0; i--)
                if (playerarray[i] == null || playerarray[i] == player)
                    playerarray.remove(i);
        }

        if (!(MissionAttributes.PlayerUnCounter in MissionAttributes.DisconnectTable))
            MissionAttributes.DisconnectTable.PlayerUnCounter <- MissionAttributes.PlayerUnCounter;

        function MissionAttributes::WaveStartCountdown()
        {
            local roundtime = NetProps.GetPropFloat(gamerules, "m_flRestartRoundTime")
            if (!NetProps.GetPropBool(resource, "m_bMannVsMachineBetweenWaves")) return;
            local ready = 0

            if (roundtime > Time() + value)
            {
                for (local i = 0; i < NetProps.GetPropArraySize(gamerules, "m_bPlayerReady"); i++)
                {
                    if (!NetProps.GetPropBoolArray(gamerules, "m_bPlayerReady", i)) continue;
                    printl(playerarray.len())
                    ready++;
                    // printl(ready +" : "+ CountAllPlayers());
                    if (ready >= playerarray.len() || (roundtime <= 12.0))
                        NetProps.SetPropFloat(gamerules, "m_flRestartRoundTime", Time() + value);
                }
            }

        }
        if (!(MissionAttributes.WaveStartCountdown in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.WaveStartCountdown <- MissionAttributes.WaveStartCountdown;
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
    return -1
}

MissionAttrEntity.ValidateScriptScope();
MissionAttrEntity.GetScriptScope().MissionAttrThink <- MissionAttrThink
AddThinkToEnt(MissionAttrEntity, "MissionAttrThink")

::PopExt_MissionAttrEvents <- {

    function OnScriptHook_OnTakeDamage(params) { foreach (_, func in MissionAttributes.TakeDamageTable) func(params) }
    // function OnGameEvent_player_spawn(params) { foreach (_, func in MissionAttributes.SpawnHookTable) func(params) }
    function OnGameEvent_post_inventory_application(params) { foreach (_, func in MissionAttributes.SpawnHookTable) func(params) } //majority of mvm maps do not have a resupply cabinet anyway
    function OnGameEvent_player_death(params) { foreach (_, func in MissionAttributes.DeathHookTable) func(params) }
    function OnGameEvent_player_disconnect(params) { foreach (_, func in MissionAttributes.DisconnectTable) func(params) }

    function GameEvent_mvm_wave_complete(params) { ResetDefaults(); }

    // Hook all wave inits to reset parsing error counter.
    function OnGameEvent_recalculate_holidays(params)
    {
        if (GetRoundState() != 3) return;

        foreach (_, func in MissionAttributes.InitWaveTable) func(params)

        foreach (a in MissionAttributes.CurrAttrs) printl(a)
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

// Function resets and clears all registered changed attributes.
function MissionAttributes::ResetDefaults()
{
    ResetConvars();
    // MissionAttributes.CurrAttrs.clear();
    delete ::PopExt_MissionAttrEvents;
    delete ::MissionAttributes
    DebugLog(format("Cleaned up mission attribute %s", attr));
}

// Logging Functions
// =========================================================
// Generic debug message that is visible if PrintDebugText is true.
// Example: Print a message that the script is working as expected.
function MissionAttributes::DebugLog(LogMsg)
{
    if (MissionAttributes.DebugText)
    {
        ClientPrint(null, 2, format("MissionAttr: %s.", LogMsg));
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
    ClientPrint(null, 2, format("MissionAttr ERROR: %s.", ErrorMsg));
}

// Raises an exception.
// Example: Script modification has not been performed correctly. User should never see one of these.
function MissionAttributes::RaiseException(ExceptionMsg)
{
    Assert(false, format("MissionAttr EXCEPTION: %s.", ExceptionMsg));
}

// =========================================================
// Register MissionAttributes callbacks.
__CollectGameEventCallbacks(PopExt_MissionAttrEvents);
