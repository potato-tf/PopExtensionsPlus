::CustomAttributes <- {

    SpawnHookTable = {}
    TakeDamageTable = {}
    TakeDamagePostTable = {}
    PlayerTeleportTable = {}
    DeathHookTable = {}

    Attrs = {
        "fires milk bolt": null
        "mod teleporter speed boost": null
        "mult teleporter recharge rate": null
        "set turn to ice": null
        "melee cleave attack": null
        "extra damage on hit": null
        "scoreboard minigame": null
        "last shot crits": null
        "can breathe under water": null
        "cannot swim": null
        "swimming mastery": null
        "mod minigun can holster while spinning": null
        "wet immunity": null
        "ability master sniper": null
        "keep disguise on attack": null
        "add give health to teammate on hit": null
        "mult dispenser rate": null
        "mvm sentry ammo": null
        "build small sentries": null
        "kill combo fire rate boost": null
        "disguise as dispenser on crouch": null
        "ubercharge transfer": null
        "ubercharge ammo": null
        "teleport instead of die": null
        "mod projectile heat seek power": null
        "mult dmg vs same class": null
        "uber on damage taken": null
        "mult crit when health is below percent": null
        "penetration damage penalty": null
        "firing forward pull": null
        "mod soldier buff range": null
        "mult rocketjump deploy time": null
        "mult nonrocketjump attackrate": null
        "aoe heal chance": null
        "crits on damage": null
        "stun on damage": null
        "aoe blast on damage": null
        "mult dmg with reduced health": null
        "mult airblast primary refire time": null
        "mod flamethrower spinup time": null
        "airblast functionality flags": null
        "reverse airblast": null
        "airblast dashes": null
        "mult sniper charge per sec with enemy under crosshair": null
        "sniper beep with enemy under crosshair": null
    }
    ItemDescriptions = []

    Events = {

        function Cleanup()
        {
            return
        }
        
		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in CustomAttributes.TakeDamageTable) func(params); }
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

function CustomAttributes::FireMilkBolt(player, item, value = 5.0) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return
    
    local scope = player.GetScriptScope()
    scope.milkboltfired <- false

    scope.PlayerThinkTable.FireMilkBolt <- function() {
        
        if (player.GetActiveWeapon() != wep) return

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

        if (victim == null || attacker == null || attacker != player || !scope.milkboltfired) return
        
        victim.AddCondEx(TF_COND_MAD_MILK, value, attacker)
        scope.milkboltfired = false
        
    }
}

function CustomAttributes::MeleeCleaveAttack(player, item, value = 64) {


    local scope = player.GetScriptScope()
    local playerstocleave = []
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return
    local nextattack = 0.0
    scope.cleaved <- false

    scope.PlayerThinkTable.MeleeCleaveAttack <- function() {
        if (nextattack == GetPropFloat(wep, "m_flNextPrimaryAttack") || GetPropFloat(wep, "m_fFireDuration") == 0.0) return

        scope.cleaved = false
        nextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
    }
    CustomAttributes.TakeDamageTable.MeleeCleaveAttack <- function(params) {
        if (scope.cleaved) return

        local wep = PopExtUtil.HasItemInLoadout(player, item)
        if (wep == null) return

        scope.cleaved = true
        // params.early_out = true

        local playerstocleave = []
        
        local swingpos = player.EyePosition() + (player.EyeAngles().Forward() * 30) - Vector(0, 0, value)

        for (local p; p = FindByClassnameWithin(p, "player", swingpos, value);)
            if (p.GetTeam() != player.GetTeam() && p.GetTeam() != TEAM_SPECTATOR)
                p.TakeDamageCustom(params.inflictor, params.attacker, params.weapon, params.damage_force, params.damage_position, params.damage, params.damage_type, params.damage_custom)
            
    }
}

function CustomAttributes::TeleporterRechargeTime(player, item, value = 1.0) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return
    
    scope = player.GetScriptScope()
    scope.teleporterrechargetimemult <- value
    
    CustomAttributes.PlayerTeleportTable.TeleporterRechargeTime <- function(params) {
        local teleportedplayer = GetPlayerFromUserID(params.userid)

        local teleporter = FindByClassnameNearest("obj_teleporter", teleportedplayer.GetOrigin(), 16)

        local chargetime = GetPropFloat(teleporter, "m_flRechargeTime")
        SetPropFloat(teleporter, "m_flRechargeTime", chargetime * teleporterrechargetimemult)
    }
}

function CustomAttributes::TurnToIce(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    //cleanup before spawning a new one
    for (local knife; knife = FindByClassname(knife, "tf_weapon_knife");)
        if (PopExtUtil.GetItemIndex(knife) == ID_SPY_CICLE && knife.GetEFlags() & EFL_USER)
            EntFireByHandle(knife, "Kill", "", -1, null, null)
        

    local freeze_proxy_weapon = CreateByClassname("tf_weapon_knife")
    SetPropInt(freeze_proxy_weapon, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", ID_SPY_CICLE)
    SetPropBool(freeze_proxy_weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
    freeze_proxy_weapon.AddEFlags(EFL_USER)
    SetPropEntity(freeze_proxy_weapon, "m_hOwner", player)
    freeze_proxy_weapon.DispatchSpawn()
    freeze_proxy_weapon.DisableDraw()
    
    // Add the attribute that creates ice statues
    freeze_proxy_weapon.AddAttribute("freeze backstab victim", 1.0, -1.0)

    CustomAttributes.TakeDamageTable.TurnToIce <- function(params) {
        local attacker = params.attacker
        if (PopExtUtil.HasItemInLoadout(attacker, item) == null) return true
        local victim = params.const_entity
        if (victim.IsPlayer() && params.damage >= victim.GetHealth())
        {
            victim.TakeDamageCustom(attacker, victim, freeze_proxy_weapon, Vector(), Vector(), params.damage, params.damage_type, params.damage_custom | TF_DMG_CUSTOM_BACKSTAB)

            // I don't remember why this is needed but it's important
            local ragdoll = GetPropEntity(victim, "m_hRagdoll")
            if (ragdoll) SetPropInt(ragdoll, "m_iDamageCustom", 0)
            params.early_out = true
        }
    }
}

function CustomAttributes::TeleporterSpeedBoost(player, item) {
    local scope = player.GetScriptScope()
    scope.speedboostteleporter <- true
    CustomAttributes.PlayerTeleportTable.TeleporterSpeedBoost <- function(params) {

        local teleportedplayer = GetPlayerFromUserID(params.userid)

        if ("speedboostteleporter" in scope && scope.speedboostteleporter) teleportedplayer.AddCondEx(TF_COND_SPEED_BOOST, value, player)
    }
}

function CustomAttributes::CanBreatheUnderwater(player, item) {
    
    local painfinished = GetPropInt(player, "m_PainFinished")
    
    player.GetScriptScope().PlayerThinkTable.CanBreatheUnderwater <- function() {

        local underwater = player.GetWaterLevel() == 3 ? INT_MAX : painfinished
        if (player.GetWaterLevel() == 3) SetPropInt(player, "m_PainFinished", underwater)
    }
}

function CustomAttributes::LastShotCrits(player, item, value = -1) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local nextattack = 0.0
    
    player.GetScriptScope().PlayerThinkTable.LastShotCrits <- function() {

        if (nextattack == GetPropFloat(wep, "m_flNextPrimaryAttack")) return

        nextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")

        if (wep.Clip1() > 1)
        {
            player.RemoveCondEx(COND_CRITBOOST_TEMPORARY, true)
            return
        }
        
        player.AddCondEx(COND_CRITBOOST_TEMPORARY, value, null)
    }
}

function CustomAttributes::AddAttr(player, attr = "", value = 0, item = null) {

    //TODO: set up error handler
    if (!(attr in CustomAttributes.Attrs)) return

    local attribinfo = {}

	switch(attr) {

        case "fires milk bolt":
            CustomAttributes.FireMilkBolt(player, item, value)
            attribinfo = {attr = attr, desc = format("Secondary attack: fires a bolt that applies milk for %d seconds.", value)}
        break

        case "mod teleporter speed boost":
            CustomAttributes.TeleporterSpeedBoost(player, item)
            attribinfo = {attr = attr, desc = format("Teleporters grant a speed boost for %f seconds", value)}
        break

        case "set turn to ice":
            CustomAttributes.TurnToIce(player, item)
            attribinfo = {attr = attr, desc = format("On Kill: Turn victim to ice.", value)}
        break

        case "mult teleporter recharge rate":
            CustomAttributes.TeleporterRechargeTime(player, item, value)
            attribinfo = {attr = attr, desc = "On Kill: Turn victim to ice"}
        break
        case "melee cleave attack":
            CustomAttributes.MeleeCleaveAttack(player, item, value)
            attribinfo = {attr = attr, desc = "On Swing: Weapon hits multiple targets"}
        break
        case "last shot crits":
            CustomAttributes.LastShotCrits(player, item)
            attribinfo = {attr = attr, desc = "Crit boost on last shot"}

        break
        case "wet immunity": 
            CustomAttributes.WetImmunity(player, item)
            attribinfo = {attr = attr, desc = "Immune to jar effects"}
        break
        
        case "can breathe under water":
            CustomAttributes.CanBreatheUnderwater(player, item, value)
            attribinfo = {attr = attr, desc = "Player can breathe underwater"}
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
                CustomAttributes.AddAttr(player, k, v[0])
            else 
                CustomAttributes.AddAttr(player, k, v[0], v[1])
    }
    
    player.GetScriptScope().PlayerThinkTable.ShowAttribInfo <- function()
    {
        if (player.IsInspecting()) return
    }
}