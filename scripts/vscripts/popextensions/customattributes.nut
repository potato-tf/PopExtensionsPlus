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
        "crit when health below": null

        //begin non-dev fully custom attributes
        "radius sleeper": null
        "explosive bullets": null
        "old sandman stun": null
        "stun on hit": null
        "is miniboss": null
        "is invisible": null
        "cannot upgrade": null
        "always crit": null
        "dont count damage towards crit rate": null
        "no damage falloff": null
        "can headshot": null
        "cannot headshot": null
        "cannot be headshot": null
        "projectile lifetime": null
        "mult dmg vs tanks": null
        "mult dmg vs giants": null
        "set damage type": null
        "set damage type custom": null

        //begin vanilla rewrite attributes
        "alt-fire disabled": null
        "custom projectile model": null
        "dmg bonus while half dead": null
        "dmg bonus while half alive": null
    }
   
    Events = {

        function Cleanup()
        {
            return
        }
        
		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in CustomAttributes.TakeDamageTable) func(params); }
		function OnGameEvent_player_hurt(params) { foreach (_, func in CustomAttributes.TakeDamagePostTable) func(params) }
		function OnGameEvent_player_death(params) { foreach (_, func in CustomAttributes.DeathHookTable) func(params) }
		function OnGameEvent_player_teleported(params) { foreach (_, func in CustomAttributes.PlayerTeleportTable) func(params) }

		function OnGameEvent_post_inventory_application(params) {
            
            local player = GetPlayerFromUserID(params.userid)
            player.ValidateScriptScope()
            player.GetScriptScope().teleporterspeedboost <- false
		}

		function OnGameEvent_recalculate_holidays(params) {

			if (GetRoundState() != GR_STATE_PREROUND) return

            foreach (player in PopExtUtil.HumanArray)
                PopExtMain.PlayerCleanup(player)
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

    local scope = player.GetScriptScope()
    scope.milkboltfired <- false

    scope.PlayerThinkTable.FireMilkBolt <- function() {
        
        local wep = PopExtUtil.HasItemInLoadout(player, item)
        if (wep == null || player.GetActiveWeapon() != wep) return

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
function CustomAttributes::TeleportInsteadOfDie(player, item, value) {


    CustomAttributes.TakeDamageTable.TeleportInsteadOfDie <- function(params) {

        if (RandomFloat(0, 1) > value.tofloat()) return

        local player = params.const_entity
        local scope = player.GetScriptScope()
        if (
            !player.IsPlayer() || player.GetHealth() > params.damage || 
            !("attribinfo" in scope) || !("teleport instead of die" in scope.attribinfo) ||
            player.IsInvulnerable() || PopExtUtil.IsPointInRespawnRoom(player.EyePosition())
        ) return

        local health = player.GetHealth()
        params.early_out = true
        
        player.ForceRespawn()
        EntFireByHandle(player, "RunScriptCode","self.SetHealth(1)", -1, null, null)
    }
}

function CustomAttributes::DmgVsSameClass(player, item, value) {
    
    CustomAttributes.TakeDamageTable.DmgVsSameClass <- function(params) {
        local victim = params.const_entity
        local attacker = params.attacker

        local wep = PopExtUtil.HasItemInLoadout(attacker, item)
        if (wep == null) return
        
        local scope = attacker.GetScriptScope()
        if (
            !attacker.IsPlayer() || !victim.IsPlayer() ||
            !("attribinfo" in scope) || !("mult dmg vs same class" in scope.attribinfo) ||
            attacker.GetPlayerClass() != victim.GetPlayerClass() || 
            player.GetActiveWeapon() != wep
        ) return

        params.damage *= value
    }
}
function CustomAttributes::MeleeCleaveAttack(player, item, value = 64) {

    local scope = player.GetScriptScope()

    scope.cleavenextattack <- 0.0
    scope.cleaved <- false

    scope.PlayerThinkTable.MeleeCleaveAttack <- function() {
        local wep = PopExtUtil.HasItemInLoadout(player, item)
        if (scope.cleavenextattack == GetPropFloat(wep, "m_flNextPrimaryAttack") || GetPropFloat(wep, "m_fFireDuration") == 0.0 || player.GetActiveWeapon() != wep || !("attribinfo" in scope) || !("melee cleave attack" in scope.attribinfo)) return

        scope.cleaved = false

        scope.cleavenextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
    }
    CustomAttributes.TakeDamageTable.MeleeCleaveAttack <- function(params) {
        
        if (scope.cleaved || !("attribinfo" in scope) || !("melee cleave attack" in scope.attribinfo)) return

        local wep = PopExtUtil.HasItemInLoadout(player, item)
        if (wep == null || player.GetActiveWeapon() != wep) return

        scope.cleaved = true
        // params.early_out = true
        
        local swingpos = player.EyePosition() + (player.EyeAngles().Forward() * 30) - Vector(0, 0, value)

        for (local p; p = FindByClassnameWithin(p, "player", swingpos, value);)
            if (p.GetTeam() != player.GetTeam() && p.GetTeam() != TEAM_SPECTATOR)
                p.TakeDamageCustom(params.inflictor, params.attacker, params.weapon, params.damage_force, params.damage_position, params.damage, params.damage_type, params.damage_custom)
            
    }
}

function CustomAttributes::TeleporterRechargeTime(player, item, value = 1.0) {
    
    local scope = player.GetScriptScope()
    scope.teleporterrechargetimemult <- value
    
    // CustomAttributes.PlayerTeleportTable.TeleporterRechargeTime <- function(params) {
    //     local teleportedplayer = GetPlayerFromUserID(params.userid)

    //     local teleporter = FindByClassnameNearest("obj_teleporter", teleportedplayer.GetOrigin(), 16)

    //     local chargetime = GetPropFloat(teleporter, "m_flCurrentRechargeDuration")
    // }

    scope.PlayerThinkTable.TeleporterRechargeTime <- function() {

        local mult = scope.teleporterrechargetimemult
        local teleporter = FindByClassnameNearest("obj_teleporter", player.GetOrigin(), 16)

        if (teleporter == null || teleporter.GetScriptThinkFunc() != "") return

        teleporter.ValidateScriptScope()
        local chargetime = GetPropFloat(teleporter, "m_flCurrentRechargeDuration")

        local teleportscope = teleporter.GetScriptScope()
        if (!("rechargetimestamp" in teleportscope)) teleportscope.rechargetimestamp <- 0.0
        if (!("rechargeset" in teleportscope)) teleportscope.rechargeset <- false
        
        teleportscope.TeleportMultThink <- function() {

            // printl(GetPropFloat(teleporter, "m_flCurrentRechargeDuration"))

            if (!teleportscope.rechargeset)
            {
                SetPropFloat(teleporter, "m_flCurrentRechargeDuration", chargetime * mult)
                SetPropFloat(teleporter, "m_flRechargeTime", Time() * mult)

                teleportscope.rechargeset = true
                teleportscope.rechargetimestamp = GetPropFloat(teleporter, "m_flRechargeTime") * mult
            }
            if (GetPropInt(teleporter, "m_iState") == 6 && GetPropFloat(teleporter, "m_flRechargeTime") >= teleportscope.rechargetimestamp)
            {
                teleportscope.rechargeset = false
            }

            printl(GetPropFloat(teleporter, "m_flRechargeTime") + " : " + teleportscope.rechargetimestamp)
            return -1
        }
        AddThinkToEnt(teleporter, "TeleportMultThink")
    }
}

function CustomAttributes::UberOnDamageTaken(player, item, value) { 
    
    CustomAttributes.TakeDamageTable.UberOnDamageTaken <- function(params) {
    
        local damagedplayer = params.const_entity

        if (
            damagedplayer != player || RandomInt(0, 1) > value ||
            !("attribinfo" in scope) || !("uber on damage taken" in scope.attribinfo) ||
            damagedplayer.IsInvulnerable() || player.GetActiveWeapon() != wep
        ) return
        
        damagedplayer.AddCondEx(COND_UBERCHARGE, 3.0, player)
        params.early_out = true
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

        local victim = params.const_entity
        if (victim.IsPlayer() && attacker == player && params.damage >= victim.GetHealth() && player.GetActiveWeapon() == wep)
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

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.PlayerTeleportTable.TeleporterSpeedBoost <- function(params) {

        if (params.builderid != PopExtUtil.GetPlayerUserID(player)) return
        local teleportedplayer = GetPlayerFromUserID(params.userid)

        if (!("attribinfo" in scope) || !("mod teleporter speed boost" in scope.attribinfo)) teleportedplayer.AddCondEx(TF_COND_SPEED_BOOST, value, player)
    }
}

function CustomAttributes::CanBreatheUnderwater(player, item) {
    
    local painfinished = GetPropInt(player, "m_PainFinished")
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()
   scope.PlayerThinkTable.CanBreatheUnderwater <- function() {

        if (!("attribinfo" in scope) || !("can breathe underwater" in scope.attribinfo)) return

        if (player.GetWaterLevel() == 3)
        {
            SetPropFloat(player, "m_PainFinished", FLT_MAX)
            return
        }
        SetPropFloat(player, "m_PainFinished", 0.0)
    }
}
function CustomAttributes::MultSwimSpeed(player, item, value = 1.25) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    //local speedmult = 1.254901961
    local maxspeed = GetPropFloat(player, "m_flMaxspeed")

    local scope = player.GetScriptScope()
    scope.PlayerThinkTable.MultSwimSpeed <- function() {

        if (!("attribinfo" in scope) || !("mult swim speed" in scope.attribinfo)) return
        
        if (player.GetWaterLevel() == 3) 
        {
            SetPropFloat(player, "m_flMaxspeed", maxspeed * value)
            return
        }
        SetPropFloat(player, "m_flMaxspeed", maxspeed)
    }
}

function CustomAttributes::LastShotCrits(player, item, value = -1) {

    local scope = player.GetScriptScope()
    scope.lastshotcritsnextattack <- 0.0

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    scope.PlayerThinkTable.LastShotCrits <- function() {

        if (!("attribinfo" in scope) || !("last shot crits" in scope.attribinfo)) return

        if (wep == null || scope.lastshotcritsnextattack == GetPropFloat(wep, "m_flNextPrimaryAttack") || player.GetActiveWeapon() != wep) return

        scope.lastshotcritsnextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")

        try 
        {
            if (wep.Clip1() != 1 && !player.IsCritBoosted())
            {
                player.RemoveCondEx(COND_CRITBOOST, true)
                return
            }
            
            if (!player.IsCritBoosted()) player.AddCondEx(COND_CRITBOOST, value, null)
            
        } catch(e) printl(e)
    }
}

function CustomAttributes::CritWhenHealthBelow(player, item, value = -1) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.CritWhenHealthBelow <- function() {

        if (player.GetHealth() < value)
        {
            player.AddCondEx(COND_CRITBOOST, 0.033, player)
            return
        }
    }
}

function CustomAttributes::WetImmunity(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local wetconds = [TF_COND_MAD_MILK, TF_COND_URINE, TF_COND_GAS]

    player.GetScriptScope().PlayerThinkTable.WetImmunity <- function() {

        foreach (cond in wetconds)
            if (player.InCond(cond))
                player.RemoveCondEx(cond, true)
    }
}

function CustomAttributes::BuildSmallSentry(player, item) {
    local scope = player.GetScriptScope()

    if (!("BuiltObjectTable") in scope) return

    scope.BuiltObjectTable.BuildSmallSentry <- function(params) {

        local wep = PopExtUtil.HasItemInLoadout(player, item)
        if (wep == null) return

        if (params.object != OBJ_SENTRYGUN) return

        local sentry = EntIndexToHScript(params.index)
        local maxhealth = sentry.GetMaxHealth() * 0.66

        sentry.SetModelScale(0.8, -1)
        sentry.SetMaxHealth(maxhealth)
        if (sentry.GetHealth() > sentry.GetMaxHealth()) sentry.SetHealth(maxhealth)
        SetPropInt(sentry, "m_iUpgradeMetalRequired", 150)
    }
}

function CustomAttributes::RadiusSleeper(player, item) {

    CustomAttributes.TakeDamagePostTable.RadiusSleeper <- function(params) {

        local victim = GetPlayerFromUserID(params.userid)
        local attacker = GetPlayerFromUserID(params.attacker)
        local scope = attacker.GetScriptScope()

        if (!("attribinfo" in scope) || !("radius sleeper" in scope.attribinfo)) return

        if (victim == null || attacker == null || attacker != player || GetPropFloat(attacker.GetActiveWeapon(), "m_flChargedDamage") < 150.0) return

        SpawnEntityFromTable("tf_projectile_jar", {origin = victim.EyePosition()})
    }
}

function CustomAttributes::ExplosiveBullets(player, item, value) {
    local scope = player.GetScriptScope()

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    //cleanup before spawning a new one
    for (local launcher; launcher = FindByClassname(launcher, "tf_weapon_grenadelauncher");)
        if (launcher.GetEFlags() & EFL_USER)
            EntFireByHandle(launcher, "Kill", "", -1, null, null)
        

    local launcher = CreateByClassname("tf_weapon_grenadelauncher")
    SetPropInt(launcher, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", ID_GRENADELAUNCHER)
    SetPropBool(launcher, "m_AttributeManager.m_Item.m_bInitialized", true)
    launcher.AddEFlags(EFL_USER)
    launcher.SetOwner(player)
    launcher.DispatchSpawn()
    launcher.DisableDraw()
    
    launcher.AddAttribute("fuse bonus", 0.0, -1)
    // launcher.AddAttribute("dmg penalty vs players", 0.0, -1)

    scope.explosivebulletsnextattack <- 0.0
    scope.curammo <- GetPropIntArray(player, "m_iAmmo", wep.GetSlot() + 1)
    if (wep.Clip1() != -1) scope.curclip <- wep.Clip1()

    scope.PlayerThinkTable.ExplosiveBullets <- function() {
        
        if (!("attribinfo" in scope) || !("explosive bullets" in scope.attribinfo) || player.GetActiveWeapon() != wep || scope.explosivebulletsnextattack == GetPropFloat(wep, "m_flLastFireTime") || ("curclip" in scope && scope.curclip != wep.Clip1())) return

        local grenade = CreateByClassname("tf_projectile_pipe")
        SetPropEntity(grenade, "m_hOwnerEntity", launcher)
        SetPropEntity(grenade, "m_hLauncher", launcher)
        SetPropEntity(grenade, "m_hThrower", player)
        SetPropFloat(grenade, "m_flDamage", value * 2) //shithack: multiply damage by 2 to account for distance falloff
        grenade.SetCollisionGroup(COLLISION_GROUP_DEBRIS)

        DispatchSpawn(grenade)
        grenade.DisableDraw()

        local trace = {
            start = player.EyePosition(),
            end = player.EyePosition() + (player.EyeAngles().Forward() * 8192.0),
            ignore = player
        }
        TraceLineEx(trace)
        if (trace.hit && "enthit" in trace) {
            if (trace.enthit.GetClassname() == "worldspawn")
                grenade.SetOrigin(trace.endpos)
            else
                grenade.SetOrigin(trace.enthit.EyePosition() + Vector(0, 0, 45))
        }

        scope.explosivebulletsnextattack = GetPropFloat(wep, "m_flLastFireTime")
        scope.curammo = GetPropIntArray(player, "m_iAmmo", wep.GetSlot() + 1)
        if ("curclip" in scope) scope.curclip = wep.Clip1()

    }
}

function CustomAttributes::OldSandmanStun(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    CustomAttributes.TakeDamageTable.OldSandmanStun <- function(params) {
        local attacker = params.attacker
        local victim = params.const_entity

        if (params.damage_stats == TF_DMG_CUSTOM_BASEBALL && params.weapon == wep)
            PopExtUtil.StunPlayer(victim, 5, TF_STUN_CONTROLS)
    }
}

function CustomAttributes::StunOnHit(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    CustomAttributes.TakeDamageTable.StunOnHit <- function(params) {

        if (!params.const_entity.IsPlayer() || params.weapon != wep || (value.len() == 4 && value[3] && params.const_entity.IsMiniBoss())) return

        PopExtUtil.StunPlayer(params.const_entity, value[0], value[1], 0, value[2])
    }
}

function CustomAttributes::IsMiniBoss(player, item) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.IsMiniBoss <- function() {

        if (player.GetActiveWeapon() == wep && !player.IsMiniBoss() && player.GetModelScale() == 1.0) {

            player.SetIsMiniBoss(true)
            player.SetModelScale(1.75, -1)
        } 
        else if (player.GetActiveWeapon() != wep && player.IsMiniBoss() && player.GetModelScale() == 1.75) {

            player.SetIsMiniBoss(false)
            player.SetModelScale(1.0, -1)
        }
    }
}

function CustomAttributes::IsInvisible(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope.PlayerThinkTable.IsInvisible <- function() {

        if (player.GetActiveWeapon() != wep || PopExtUtil.HasEffect(EF_NODRAW)) return
        wep.DisableDraw()
    }
}
function CustomAttributes::CannotUpgrade(player, item) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope.PlayerThinkTable.CannotUpgrade <- function() {

        if (player.GetActiveWeapon() == wep && GetPropBool(player, "m_bInUpgradeZone")) {

            SetPropBool(player, "m_bInUpgradeZone", false)
            ClientPrint(player, HUD_PRINTCENTER, "This weapon cannot be upgraded")
        }
    }
}

function CustomAttributes::AlwaysCrit(player, item) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope.PlayerThinkTable.AlwaysCrit <- function() {

        if (player.GetActiveWeapon() == wep)
            player.AddCondEx(COND_CRITBOOST, 0.033, player)
    }
}

function CustomAttributes::DmgNoCritRate(player, item) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.DmgNoCritRate <- function(params) {

        if (params.weapon != wep) return
        params.damage_type = params.damage_type | DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE
    }
}

function CustomAttributes::NoDamageFalloff(player, item) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.NoDamageFalloff <- function(params) {

        if (params.weapon != wep) return

        params.damage_type = params.damage_type &~ DMG_USEDISTANCEMOD
    }
}

function CustomAttributes::CanHeadshot(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.CanHeadshot <- function(params) {

        if (params.weapon != wep) return

        params.damage_type = params.damage_type | DMG_CRITICAL
        params.damage_stats = TF_DMG_CUSTOM_HEADSHOT
    }
}
function CustomAttributes::CannotHeadshot(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.CannotHeadshot <- function(params) {

        if (params.weapon != wep || params.damage_stats != TF_DMG_CUSTOM_HEADSHOT) return

        params.damage_type = params.damage_type &~ DMG_CRITICAL
        params.damage_stats = TF_DMG_CUSTOM_NONE
    }
}

function CustomAttributes::CannotBeHeadshot(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.CannotBeHeadshot <- function(params) {
        
        local scope = params.const_entity.GetScriptScope()

        if (!params.const_entity.IsPlayer() || !("attribinfo" in scope) || !("cannot be headshot" in scope.attribinfo)) return

        params.damage_type = params.damage_type &~ DMG_CRITICAL
        params.damage_stats = TF_DMG_CUSTOM_NONE
    }
}

function CustomAttributes::ProjectileLifeTime(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.ProjectileLifeTime <- function() {
        for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");) {
            if ((projectile.GetOwner() == player && player.GetActiveWeapon() == wep) || (HasProp(projectile, "m_hThrower") && GetPropEntity(projectile, "m_hThrower") == player && GetPropEntity(projectile, "m_hLauncher") == wep))
                EntFireByHandle(projectile, "Kill", "", value, null, null)
        }
    }
}

function CustomAttributes::MultDmgVsGiants(player, item, value) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.MultDmgVsGiants <- function(params) {

        local victim = params.const_entity, attacker = params.attacker

        if (victim.IsPlayer() && victim.IsMiniBoss() && params.weapon == wep) params.damage *= value
    }
}

function CustomAttributes::MultDmgVsTanks(player, item, value) {
    
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.MultDmgVsGiants <- function(params) {

        local victim = params.const_entity, attacker = params.attacker

        if (victim.GetClassname() == "tank_boss" && params.weapon == wep) params.damage *= value
    }
}

function CustomAttributes::SetDamageType(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.SetDamageType <- function(params) {

        if (params.weapon == wep) params.damage_type = value
    }
}

function CustomAttributes::SetDamageTypeCustom(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.SetDamageType <- function(params) {

        if (params.weapon == wep) params.damage_stats = value
    }
}


//REIMPLEMENTED VANILLA ATTRIBUTES

function CustomAttributes::AltFireDisabled(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.PlayerThinkTable.AltFireDisabled <- function() {
        
        if (!("attribinfo" in scope) || !("alt-fire disabled" in scope.attribinfo) || player.GetActiveWeapon() != wep) return
        
        SetPropInt(player, "m_afButtonDisabled", IN_ATTACK2)
    }
}

function CustomAttributes::CustomProjectileModel(player, item, value) {

    local projmodel = PrecacheModel(value)
    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.PlayerThinkTable.CustomProjectileModel <- function() {

        if (!("attribinfo" in scope) || !("custom projectile model" in scope.attribinfo) || player.GetActiveWeapon() != wep) return
        
        for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
            if (projectile.GetOwner() == player && GetPropInt(projectile, "m_nModelIndex") != projmodel)
                projectile.SetModel(value)
    } 
}

function CustomAttributes::ShahanshahAttributeBelowHP(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return
    
    CustomAttributes.TakeDamageTable.ShahanshahAttributeBelowHP <- function(params) {

        if (!("attribinfo" in scope) || !("dmg bonus while half dead" in scope.attribinfo) || params.weapon != wep || player.GetActiveWeapon() != wep) return
        
        if (player.GetHealth() < player.GetMaxHealth() / 2)
            params.damage *= value
    }
}

function CustomAttributes::ShahanshahAttributeAboveHP(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return
    
    CustomAttributes.TakeDamageTable.ShahanshahAttributeAboveHP <- function(params) {

        if (!("attribinfo" in scope) || !("dmg penalty while half alive" in scope.attribinfo) || params.weapon != wep || player.GetActiveWeapon() != wep) return
        
        if (player.GetHealth() > player.GetMaxHealth() / 2)
            params.damage *= value
    }
}

function CustomAttributes::AddAttr(player, attr = "", value = 0, item = null) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null || player.IsBotOfType(1337)) return
    //TODO: set up error handler
    if (!(attr in CustomAttributes.Attrs)) return

    local scope = player.GetScriptScope()

    local valuepercent = 0
    if (typeof value == "float" || typeof value == "integer")
        valuepercent = (value.tofloat() * 100).tointeger()

    if (!("attribinfo" in scope)) scope.attribinfo <- {}

	switch(attr) {

        case "fires milk bolt":
            CustomAttributes.FireMilkBolt(player, item, value)
            scope.attribinfo[attr] <- format("Secondary attack: fires a bolt that applies milk for %d seconds.", value)
        break

        case "mod teleporter speed boost":
            CustomAttributes.TeleporterSpeedBoost(player, item)
            scope.attribinfo[attr] <- format("Teleporters grant a speed boost for %f seconds", value)
        break

        case "set turn to ice":
            CustomAttributes.TurnToIce(player, item)
            scope.attribinfo[attr] <- format("On Kill: Turn victim to ice.", value)
        break

        case "mult teleporter recharge rate":
            CustomAttributes.TeleporterRechargeTime(player, item, value)
            scope.attribinfo[attr] <- format("Teleporter recharge rate multiplied by %f", value)
        break

        case "melee cleave attack":
            CustomAttributes.MeleeCleaveAttack(player, item, value)
            scope.attribinfo[attr] <- "On Swing: Weapon hits multiple targets"
        break

        case "last shot crits":
            CustomAttributes.LastShotCrits(player, item)
            scope.attribinfo[attr] <- "Crit boost on last shot"
        break

        case "wet immunity": 
            CustomAttributes.WetImmunity(player, item)
            scope.attribinfo[attr] <- "Immune to jar effects"
        break
        
        case "can breathe under water":
            CustomAttributes.CanBreatheUnderwater(player, item)
            scope.attribinfo[attr] <- "Player can breathe underwater"
        break

        case "mult swim speed":
            CustomAttributes.MultSwimSpeed(player, item, value)
            scope.attribinfo[attr] <- format("Swimming speed multiplied by %f", value.tofloat())
        break
        
        case "teleport instead of die":
            CustomAttributes.TeleportInsteadOfDie(player, item, value)
            scope.attribinfo[attr] <- format("%d⁒ chance of teleporting to spawn with 1 health instead of dying", valuepercent)
        break
        
        case "mult dmg vs same class":
            CustomAttributes.DmgVsSameClass(player, item, value)
            scope.attribinfo[attr] <- format("Damage versus %s multiplied by %f", PopExtUtil.Classes[player.GetPlayerClass()], value.tofloat())
        break

        case "uber on damage taken":
            CustomAttributes.UberOnDamageTaken(player, item, value)
            scope.attribinfo[attr] <- format("On take damage: %d⁒ chance of gaining invicibility for 3 seconds", valuepercent)
        break

        case "build small sentries":
            CustomAttributes.BuildSmallSentry(player, item)
            scope.attribinfo[attr] <- "Sentries are 20⁒ smaller. have 33⁒ less health, take 25⁒ less metal to upgrade"
        break

        case "crit when health below":
            CustomAttributes.CritWhenHealthBelow(player, item, value)
            scope.attribinfo[attr] <- format("Player is crit boosted when below %d health", value)
        break

        case "mvm sentry ammo":
            CustomAttributes.SentryAmmo(player, item, value)
            scope.attribinfo[attr] <- format("Sentry ammo multiplied by %f", value.tofloat())
        break

        //FULLY CUSTOM ATTRIBUTES BELOW
        //no hidden dev alternative

        case "radius sleeper":
            CustomAttributes.RadiusSleeper(player, item)
            scope.attribinfo[attr] <- "On full charge headshot: create jarate explosion on victim"
        break

        case "explosive bullets":
            CustomAttributes.ExplosiveBullets(player, item, value)
            scope.attribinfo[attr] <- format("Fires explosive rounds that deal %d damage", value)
        break

        case "old sandman stun":
            CustomAttributes.OldSandmanStun(player, item)
            scope.attribinfo[attr] <- "Uses pre-JI stun mechanics"
        break

        case "stun on hit":
            CustomAttributes.StunOnHit(player, item, value)
            scope.attribinfo[attr] <- format("Stuns victim for %f seconds on hit", value[0].tofloat())
        break

        case "is miniboss": 
            CustomAttributes.IsMiniBoss(player, item)
            scope.attribinfo[attr] <- "When weapon is active: player becomes giant"
        break

        case "is invisible": 
            CustomAttributes.IsInvisible(player, item)
            scope.attribinfo[attr] <- "Weapon is invisible"
        break

        case "cannot upgrade":
            CustomAttributes.CannotUpgrade(player, item)
            scope.attribinfo[attr] <- "Weapon cannot be upgraded"
        break

        case "always crit":
            CustomAttributes.AlwaysCrit(player, item)
            scope.attribinfo[attr] <- "Weapon always crits"
        break

        case "dont count damage towards crit rate":
            CustomAttributes.DmgNoCritRate(player, item)
            scope.attribinfo[attr] <- "Damage doesn't count towards crit rate"
        break

        case "no damage falloff":
            CustomAttributes.NoDamageFalloff(player, item)
            scope.attribinfo[attr] <- "Weapon has no damage fall-off"
        break

        case "can headshot":
            CustomAttributes.CanHeadshot(player, item)
            scope.attribinfo[attr] <- "Crits on headshot"
        break

        case "cannot headshot":
            CustomAttributes.CannotHeadshot(player, item)
            scope.attribinfo[attr] <- "Cannot headshot"
        break

        case "cannot be headshot":
            CustomAttributes.CannotBeHeadshot(player, item)
            scope.attribinfo[attr] <- "Immune to headshots"
        break

        case "projectile lifetime":
            CustomAttributes.ProjectileLifeTime(player, item, value)
            scope.attribinfo[attr] <- format("projectile disappears after %f seconds", value.tofloat())
        break

        case "mult dmg vs tanks":
            CustomAttributes.MultDmgVsTanks(player, item, value)
            scope.attribinfo[attr] <- format("Damage vs tanks multiplied by %f", value.tofloat())
        break

        case "mult dmg vs giants":
            CustomAttributes.MultDmgVsGiants(player, item, value)
            scope.attribinfo[attr] <- format("Damage vs giants multiplied by %f", value.tofloat())
        break

        case "set damage type":
            CustomAttributes.SetDamageType(player, item, value)
            scope.attribinfo[attr] <- format("Damage type set to %d", value)
        break

        case "set damage type custom":
            CustomAttributes.SetDamageTypeCustom(player, item, value)
            scope.attribinfo[attr] <- format("Custom damage type set to %d", value)
        break

        //VANILLA ATTRIBUTE REIMPLEMENTATIONS
        
        //only really recommended for bots
        //certain things like cow mangler charge effects and minigun spin-up animations still play, despite secondary fire being disabled

        case "alt-fire disabled":
            CustomAttributes.AltFireDisabled(player, item)
            scope.attribinfo[attr] <- "Secondary fire disabled"
        break

        case "custom projectile model":
            CustomAttributes.CustomProjectileModel(player, item, value)
            scope.attribinfo[attr] <- format("Fires custom projectile model: %s", value)
        break

        case "dmg bonus while half dead":
            CustomAttributes.ShahanshahAttributeBelowHP(player, item, value)
            scope.attribinfo[attr] <- format("damage bonus while under 50% health", value)
        break

        case "dmg penalty while half alive":
            CustomAttributes.ShahanshahAttributeAboveHP(player, item, value)
            scope.attribinfo[attr] <- format("damage penalty while above 50% health", value)
        break

    }

    local cooldowntime = 3.0

    local scope = player.GetScriptScope()
    local formattedtable = []

    local formatted = ""

    foreach (desc, attr in scope.attribinfo)
    {
        if (!formatted.find(attr))
            formattedtable.append(format("%s:\n\n%s\n\n\n", desc, attr))
    }
            
    local i = 0
    scope.PlayerThinkTable.ShowAttribInfo <- function() {

        if (!player.IsInspecting() || Time() < cooldowntime) return
        
        if (i+1 < formattedtable.len()) 
            PopExtUtil.ShowHudHint(format("%s %s", formattedtable[i], formattedtable[i+1]), player, 3.0 - SINGLE_TICK)
        else
            PopExtUtil.ShowHudHint(formattedtable[i], player, 3.0 - SINGLE_TICK)
        
        i += 2
        if (i >= formattedtable.len()) i = 0
        cooldowntime = Time() + 3.0
    }
}

//obsolete, implemented into item/playerattribs/bot tags
// function CustomAttrs(attrs = {}) {
//     CustomAttributes.SpawnHookTable.ApplyCustomAttribs <- function(params)
//     {
//         local player = GetPlayerFromUserID(params.userid)
//         if (player.IsBotOfType(1337)) return
//         foreach (k, v in attrs)
//             if (v.len() == 1)
//                 CustomAttributes.AddAttr(player, k, v[0])
//             else 
//                 CustomAttributes.AddAttr(player, k, v[0], v[1])
//     }
// }