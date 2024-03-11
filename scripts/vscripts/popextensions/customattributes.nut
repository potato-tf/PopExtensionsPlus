::CustomAttributes <- {

    SpawnHookTable = {}
    TakeDamageTable = {}
    TakeDamagePostTable = {}
    PlayerTeleportTable = {}
    DeathHookTable = {}

    Events = {

        function Cleanup()
        {
            return
        }
        
		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in CustomAttributes.TakeDamageTable) func(params) }
		function OnGameEvent_player_hurt(params) { foreach (_, func in CustomAttributes.TakeDamagePostTable) func(params) }
		// function OnGameEvent_player_spawn(params) { foreach (_, func in CustomAttributes.SpawnHookTable) func(params) }
		function OnGameEvent_player_death(params) { foreach (_, func in CustomAttributes.DeathHookTable) func(params) }
		function OnGameEvent_player_teleported(params) {  foreach (_, func in CustomAttributes.PlayerTeleportTable) func(params) }
		// function OnGameEvent_player_disconnect(params) { foreach (_, func in CustomAttributes.DisconnectTable) func(params) }
		// function OnGameEvent_mvm_begin_wave(params) { foreach (_, func in CustomAttributes.StartWaveTable) func(params) }

		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)
			player.ValidateScriptScope()
			local scope = player.GetScriptScope()	

            local items = {

                PlayerThinkTable = {}
                teleporterspeedboost = false
                milkboltfired = false
                // PlayerTeleportTable = {}
            }

            foreach (k,v in items) if (!(k in scope)) scope[k] <- v

			foreach (_, func in CustomAttributes.SpawnHookTable) func(params)

			scope.PlayerThinks <- function() { foreach (name, func in scope.PlayerThinkTable) func(); return -1 }

			AddThinkToEnt(player, "PlayerThinks")

			if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope)) 
			{
				scope.BuiltObjectTable <- {}
			}
		}

		function OnGameEvent_recalculate_holidays(params) {

			if (GetRoundState() != GR_STATE_PREROUND) return

            foreach (player in PopExtUtil.HumanArray)
                Main.PlayerCleanup(player)

			delete ::CustomAttributes
		}

		// function OnGameEvent_mvm_wave_complete(params) {

		// 	CustomAttributes.Cleanup()
		// }

		function OnGameEvent_mvm_mission_complete(params) {

			delete ::CustomAttributes
		}
	}
}
__CollectGameEventCallbacks(CustomAttributes.Events)

function CustomAttributes::ItemAttr(player, attr = "", value = 0, item = null) {
	switch(attr) {

        //TODO: this is not how this attribute is supposed to work.
        //Implement a secondary attack check to do this instead
        case "fires milk bolt":

            if (value < 1) return
            local scope = player.GetScriptScope()

            scope.PlayerThinkTable.FireMilkBolt <- function() {
                local wep = player.GetActiveWeapon()
                local nextattack = 0.0

                if (PopExtUtil.InButton(player, IN_ATTACK2)) 
                {
                    wep.PrimaryAttack()
                    scope.milkboltfired = true

                } else if (PopExtUtil.InButton(player, IN_ATTACK)) 
                    scope.milkboltfired = false
            }
            CustomAttributes.TakeDamagePostTable.FireMilkBolt <- function(params) {

                local victim = GetPlayerFromUserID(params.userid)
                local attacker = GetPlayerFromUserID(params.attacker)

                if (victim == null || attacker == null || !scope.milkboltfired) return
                
                if (item == null || (typeof item == "integer" && (PopExtUtil.HasItemIndex(attacker, ID_CRUSADERS_CROSSBOW) || PopExtUtil.HasItemIndex(attacker, ID_FESTIVE_CRUSADERS_CROSSBOW))) || (typeof item == "string" && PopExtUtil.GetItemInSlot(player, SLOT_PRIMARY).GetClassname() == item))
                {
                    victim.AddCondEx(TF_COND_MAD_MILK, value, attacker)
                    scope.milkboltfired = false
                }
            }
            
        break

        case "mod teleporter speed boost":

            CustomAttributes.PlayerTeleportTable.TeleporterSpeedBoost <- function(params) {

                GetPlayerFromUserID(params.userid).AddCondEx(TF_COND_SPEED_BOOST, value, GetPlayerFromUserID(params.builderid))

            }
        break

        case "set turn to ice":

            //cleanup before spawning a new one 
            for (local knife; knife = FindByClassname(knife, "tf_weapon_knife");)
                if (knife.GetOwner().IsBotOfType(1337) && PopExtUtil.GetItemIndex(knife) == ID_SPY_CICLE)
                    EntFireByHandle(knife, "Kill", "", -1, null, null)
                

            local freeze_proxy_weapon = CreateByClassname("tf_weapon_knife")
            SetPropInt(freeze_proxy_weapon, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", ID_SPY_CICLE)
            SetPropBool(freeze_proxy_weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
            freeze_proxy_weapon.SetOwner(PopExtUtil.BotArray[RandomInt(0, PopExtUtil.BotArray.len() - 1)]) //set owner to random bot.  Don't set to a player since bots can't disconnect
            freeze_proxy_weapon.DispatchSpawn()
            freeze_proxy_weapon.DisableDraw()
            
            // Add the attribute that creates ice statues
            freeze_proxy_weapon.AddAttribute("freeze backstab victim", 1.0, -1.0)
        break
    }
}
function CustomAttrs(attrs = {}) {
    CustomAttributes.SpawnHookTable.ApplyCustomAttribs <- function(params)
    {
        local player = GetPlayerFromUserID(params.userid)
        if (player.IsBotOfType(1337)) return
        foreach (k, v in attrs)
            if (v.len() == 1)
                CustomAttributes.ItemAttr(player, k, v[0])
            else 
                CustomAttributes.ItemAttr(player, k, v[0], v[1])
    }
}