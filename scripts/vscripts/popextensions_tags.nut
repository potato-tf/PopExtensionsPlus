//behavior tags
local popext_funcs =
{
    popext_addcond = function(args)
    {
        if (args.len() == 1)
            bot.AddCond(args[1].tointeger())
        else if (args.len() >= 2)
            bot.AddCondEx(args[0].tointeger(), args[1].tointeger(), null)
    }
    popext_reprogrammed = function(args)
    {
        bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, false)
    }
    popext_altfire = function(args)
    {
        if (args.len() == 1)
            bot.PressAltFireButton(99999)
        else if (args.len() >= 2)
            bot.PressAltFireButton(args[1].tointeger())
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

        if (bot.HasBotTag("popext_dispenserasteleporter") && params.object == 1) //OBJ_TELEPORTER
        {
            SpawnEntityFromTable("obj_dispenser", {

            })
            EntIndexToHScript(params.index)
        }
        else if (bot.HasBotTag("popext_dispenserassentry") && params.object == 2) //OBJ_SENTRYGUN
        {

            SpawnEntityFromTable("obj_dispenser", {
                
            })
        }
    }
}
__CollectGameEventCallbacks(__PopExt_Behavior)