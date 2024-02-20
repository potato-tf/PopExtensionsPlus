const SCOUT_MONEY_COLLECTION_RADIUS = 288


local GlobalFixesEntity = FindByName(null, "popext_globalfixes_ent")
if (GlobalFixesEntity == null) GlobalFixesEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_globalfixes_ent"});

::GlobalFixes <- {
    //remove with MissionAttr("ReflectableDF", 1)
    InitWaveTable = {}
    TakeDamageTable = {}
    ThinkTable = {

        function DragonsFuryFix()
        {
            for (local fireball; fireball = FindByClassname(fireball, "tf_projectile_balloffire");)
                fireball.RemoveFlag(FL_GRENADE);
        }
    }
    DeathHookTable = {
        function NoCreditVelocity(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            
            if (!player.IsBotOfType(1337)) return;

            for (local money; money = FindByClassname(money, "item_currencypack*");)
                money.SetAbsVelocity(Vector())
        }
    }
    SpawnHookTable = {
        function ScoutBetterMoneyCollection(params)
        {
            local player = GetPlayerFromUserID(params.userid)

            if (player.IsBotOfType(1337) || player.GetPlayerClass() != TF_CLASS_SCOUT) return;
            
            function MoneyThink()
            {
                for (local money; money = FindByClassnameWithin(money, "item_currencypack*", player.GetOrigin(), SCOUT_MONEY_COLLECTION_RADIUS);)
                    money.SetOrigin(player.GetOrigin())
            }
            player.GetScriptScope().PlayerThinkTable.MoneyThink <- MoneyThink
        }
    }
    Events = {
        function OnScriptHook_OnTakeDamage(params) { foreach (_, func in GlobalFixes.TakeDamageTable) func(params) }
        // function OnGameEvent_player_spawn(params) { foreach (_, func in GlobalFixes.SpawnHookTable) func(params) }
        function OnGameEvent_player_death(params) { foreach (_, func in GlobalFixes.DeathHookTable) func(params) }
        function OnGameEvent_player_disconnect(params) { foreach (_, func in GlobalFixes.DisconnectTable) func(params) }
        function OnGameEvent_post_inventory_application(params) 
        {
            local player = GetPlayerFromUserID(params.userid)
            player.ValidateScriptScope()
            local scope = player.GetScriptScope()
            if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}
    
            function PlayerThinks()
            {
                foreach (_, func in scope.PlayerThinkTable) func()
            }
            scope.PlayerThinks <- PlayerThinks
            AddThinkToEnt(player, "PlayerThinks")
    
            foreach (_, func in GlobalFixes.SpawnHookTable) func(params)
        } 
        // Hook all wave inits to reset parsing error counter.
        
        function OnGameEvent_recalculate_holidays(params)
        {
            if (GetRoundState() != 3) return;
    
            foreach (_, func in GlobalFixes.InitWaveTable) func(params)
        }
    
        function GameEvent_mvm_wave_complete(params) { delete GlobalFixes }
    }
}
__CollectGameEventCallbacks(GlobalFixes.Events)

function GlobalFixesThink()
{
    foreach (_, func in GlobalFixes.ThinkTable) func()
    return -1
}

GlobalFixesEntity.ValidateScriptScope();
GlobalFixesEntity.GetScriptScope().GlobalFixesThink <- GlobalFixesThink
AddThinkToEnt(GlobalFixesEntity, "GlobalFixesThink")