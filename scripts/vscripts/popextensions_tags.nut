local classes = ["scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"]
//behavior tags
local popext_funcs =
{
    popext_addcond = function(args)
    {
        if (args.len() == 2)
            if (args[1].tointeger() == 43)
                bot.ForceChangeTeam(2, false)
            else 
                bot.AddCond(args[1].tointeger())
                
        else if (args.len() >= 3)
            bot.AddCondEx(args[1].tointeger(), args[2].tointeger(), null)
    }
    popext_reprogrammed = function(args)
    {
        bot.ForceChangeTeam(2, false)
    }
    popext_reprogrammed_neutral = function(args)
    {
        bot.ForceChangeTeam(0, false)
    }
    popext_altfire = function(args)
    {
        if (args.len() == 1)
            bot.PressAltFireButton(99999)
        else if (args.len() >= 2)
            bot.PressAltFireButton(args[1].tointeger())
    }
    popext_usehumanmodel = function(args)
    {
        bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", classes[bot.GetPlayerClass()]))
    }
    popext_alwaysglow = function(args)
    {
        NetProps.SetPropBool(bot, "m_bGlowEnabled", true)
    }
    popext_stripslot = function(args)
    {
        if (args.len() == 1) args.append(-1)
        local slot = args[1].tointeger()

        if (slot == -1) slot = player.GetActiveWeapon().GetSlot()

        for (local i = 0; i < SLOT_COUNT; i++)
        {
            local weapon = GetWeaponInSlot(player, i);
    
            if (weapon == null || weapon.GetSlot() != slot) continue;
    
            weapon.Destroy();
            break;
        }
    }
    popext_fireweapon = function(args)
    {
        //think function
    }
    popext_usebestweapon = function(args)
    {
        function BestWeaponThink(bot)
        {
            switch(bot.GetPlayerClass())
            {
            case (1): //TF_CLASS_SCOUT

                //scout and pyro's UseBestWeapon is inverted
                //switch them to secondaries, then back to primary when enemies are close
                if (bot.GetActiveWeapon() != NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))
                    bot.Weapon_Switch(NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))

                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam()) continue
                    local primary = GetPropEntityArray(bot, "m_hMyWeapons", 0); //SLOT_PRIMARY
                    bot.Weapon_Switch(primary);
                    primary.AddCustomAttribute("disable weapon switch", 1, 1);
                    primary.ReapplyProvision();
                }
                break

            case (2): //TF_CLASS_SNIPER
                for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 750);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().GetSlot() == 2) continue //potentially not break sniper ai
                    local secondary = GetPropEntityArray(bot, "m_hMyWeapons", 1); //SLOT_SECONDARY
                    bot.Weapon_Switch(secondary);
                    secondary.AddCustomAttribute("disable weapon switch", 1, 1);
                    secondary.ReapplyProvision();
                }
                break
            
            case (3): //TF_CLASS_SOLDIER
                for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().Clip1() != 0) continue
                    local secondary = GetPropEntityArray(bot, "m_hMyWeapons", 1); //SLOT_SECONDARY
                    bot.Weapon_Switch(secondary);
                    secondary.AddCustomAttribute("disable weapon switch", 1, 2);
                    secondary.ReapplyProvision();
                }
                break
            
            case (7): //TF_CLASS_PYRO
            
                //scout and pyro's UseBestWeapon is inverted
                //switch them to secondaries, then back to primary when enemies are close
                if (bot.GetActiveWeapon() != NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))
                    bot.Weapon_Switch(NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))

                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam()) continue
                    local primary = GetPropEntityArray(bot, "m_hMyWeapons", 0); //SLOT_PRIMARY
                    bot.Weapon_Switch(primary);
                    primary.AddCustomAttribute("disable weapon switch", 1, 1);
                    primary.ReapplyProvision();
                }
                break
            }
        }
    }
}

::GetBotBehaviorFromTags <- function(bot) {
    local tags = {}
    bot.GetAllBotTags(tags)
    
    if (tags.len() == 0) return
    
    foreach (tag in tags) 
    {
        local args = split(tag, "|")
        if (args.len() == 0) continue
        local func = args.remove(0)
        if (func in popext_funcs)
            popext_funcs[func](args)
    }
}

::PopExt_Behavior <- {

    function OnGameEvent_player_spawn(params) {
        local bot = GetPlayerFromUserID(params.userid)
        if (!bot.IsBotOfType(1337)) return

        EntFireByHandle(bot, "RunScriptCode", "GetBotBehaviorFromTags(self)", -1, null, null);
    }

    function OnGameEvent_player_builtobject(params) {
        local bot = GetPlayerFromUserID(params.userid)
        if (!IsBotOfType(1337)) return

        local building = EntIndexToHScript(params.entindex)
        if ((bot.HasBotTag("popext_dispenserasteleporter") && params.object == 1) || (bot.HasBotTag("popext_dispenserassentry") && params.object == 2))
        {
            local dispenser = SpawnEntityFromTable("obj_dispenser", {
                targetname = "dispenserasteleporter"+params.index,
                defaultupgrade = 3,
                origin = building.GetOrigin()
            })
            NetProps.SetPropEntity(dispenser, "m_hBuilder", bot)
            dispenser.SetOwner(bot)
            building.Kill()
        }
    }
}
__CollectGameEventCallbacks(__PopExt_Behavior)