local classes = ["scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"]
//behavior tags
local popext_funcs =
{
    popext_addcond = function(bot, args)
    {
        if (args.len() == 1)
            if (args[0].tointeger() == 43)
                bot.ForceChangeTeam(2, false)
            else 
                bot.AddCond(args[0].tointeger())
                
        else if (args.len() >= 2)
            bot.AddCondEx(args[0].tointeger(), args[1].tointeger(), null)
    }

    popext_reprogrammed = function(bot, args)
    {
        bot.ForceChangeTeam(2, false)
    }

    popext_reprogrammed_neutral = function(bot, args)
    {
        bot.ForceChangeTeam(0, false)
    }

    popext_altfire = function(bot, args)
    {
        if (args.len() == 1)
            bot.PressAltFireButton(99999)
        else if (args.len() >= 2)
            bot.PressAltFireButton(args[1].tointeger())
    }

    popext_usehumanmodel = function(bot, args)
    {
        bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", classes[bot.GetPlayerClass()]))
    }

    popext_alwaysglow = function(bot, args)
    {
        NetProps.SetPropBool(bot, "m_bGlowEnabled", true)
    }

    popext_stripslot = function(bot, args)
    {
        if (args.len() == 1) args.append(-1)
        local slot = args[1].tointeger()

        if (slot == -1) slot = player.GetActiveWeapon().GetSlot()

        for (local i = 0; i < SLOT_COUNT; i++)
        {
            local weapon = GetWeaponInSlot(player, i)
    
            if (weapon == null || weapon.GetSlot() != slot) continue
    
            weapon.Destroy()
            break
        }
    }

    popext_fireweapon = function(bot, args)
    {
        //think function
        function FireWeaponThink(bot)
        {

        }

    }

    //this is a very simple method for giving bots weapons. 
    popext_giveweapon = function(bot, args)
    {
        local weapon = Entities.CreateByClassname(args[0])
        NetProps.SetPropInt(weapon, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", args[1])
        NetProps.SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
        NetProps.SetPropBool(weapon, "m_bValidatedAttachedEntity", true)
        weapon.SetTeam(player.GetTeam())
        Entities.DispatchSpawn(weapon)
        
        player.Weapon_Equip(weapon)
        
        for (local i = 0; i < 7; i++)
        {
            local heldWeapon = NetProps.GetPropEntityArray(player, "m_hMyWeapons", i)
            if (heldWeapon == null)
                continue
            if (heldWeapon.GetSlot() != weapon.GetSlot())
                continue
            heldWeapon.Destroy()
            NetProps.SetPropEntityArray(player, "m_hMyWeapons", weapon, i)
            break
        }
        
        player.Weapon_Switch(weapon)
    
        return weapon
    }

    popext_usebestweapon = function(bot, args)
    {
        function BestWeaponThink(bot)
        {
            switch(bot.GetPlayerClass())
            {
            case 1: //TF_CLASS_SCOUT

                //scout and pyro's UseBestWeapon is inverted
                //switch them to secondaries, then back to primary when enemies are close
                if (bot.GetActiveWeapon() != NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))
                    bot.Weapon_Switch(NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))

                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam()) continue
                    local primary = GetPropEntityArray(bot, "m_hMyWeapons", 0) //SLOT_PRIMARY
                    bot.Weapon_Switch(primary)
                    primary.AddCustomAttribute("disable weapon switch", 1, 1)
                    primary.ReapplyProvision()
                }
                break

            case 2: //TF_CLASS_SNIPER
                for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 750);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().GetSlot() == 2) continue //potentially not break sniper ai
                    local secondary = GetPropEntityArray(bot, "m_hMyWeapons", 1) //SLOT_SECONDARY
                    bot.Weapon_Switch(secondary)
                    secondary.AddCustomAttribute("disable weapon switch", 1, 1)
                    secondary.ReapplyProvision()
                }
                break
            
            case 3: //TF_CLASS_SOLDIER
                for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().Clip1() != 0) continue
                    local secondary = GetPropEntityArray(bot, "m_hMyWeapons", 1) //SLOT_SECONDARY
                    bot.Weapon_Switch(secondary)
                    secondary.AddCustomAttribute("disable weapon switch", 1, 2)
                    secondary.ReapplyProvision()
                }
                break
            
            case (7): //TF_CLASS_PYRO
            
                //scout and pyro's UseBestWeapon is inverted
                //switch them to secondaries, then back to primary when enemies are close
                //TODO: check if we're targetting a soldier with a simple raycaster, or wait for more bot functions to be exposed
                if (bot.GetActiveWeapon() != NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))
                    bot.Weapon_Switch(NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))

                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam()) continue
                    local primary = GetPropEntityArray(bot, "m_hMyWeapons", 0) //SLOT_PRIMARY
                    bot.Weapon_Switch(primary)
                    primary.AddCustomAttribute("disable weapon switch", 1, 1)
                    primary.ReapplyProvision()
                }
                break
            }
        }
        bot.GetScriptScope().thinktable.BestWeaponThink <- BestWeaponThink
    }
}

//override the default think function
::_AddThinkToEnt <- AddThinkToEnt
::AddThinkToEnt <- function(entity, func)
{
    if (entity.IsPlayer())
        entity.GetScriptScope().thinktable.func <- func
    else
        _AddThinkToEnt(entity, func) 
}

// ::AddThinkToEnt <- function(entity, func)
// {
//     if (entity.IsPlayer())
//         // add to think table
//     else
//         OrigAddThinkToEnt(entity, func) 
// }

::GetBotBehaviorFromTags <- function(bot) 
{
    local tags = {}
    local scope = bot.GetScriptScope()
    bot.GetAllBotTags(tags)
    
    if (tags.len() == 0) return
    
    foreach (tag in tags) 
    {
        local args = split(tag, "|")
        if (args.len() == 0) continue
        local func = args.remove(0)
        if (func in popext_funcs)
            popext_funcs[func](bot, args)
    }
    function PopExt_BotThinks()
    {
        if (scope.thinktable.len() < 1) return;

        foreach (think in scope.thinktable)
           scope.thinktable[think](bot)
    }
    AddThinkToEnt(bot, "PopExt_BotThinks")
}

::_PopExt_Behavior <- {

    function OnGameEvent_player_spawn(params) {
        local bot = GetPlayerFromUserID(params.userid)
        if (!bot.IsBotOfType(1337)) return

        local thinktable = {}
        bot.ValidateScriptScope()
        bot.GetScriptScope().thinktable <- thinktable
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
__CollectGameEventCallbacks(_PopExt_Behavior)