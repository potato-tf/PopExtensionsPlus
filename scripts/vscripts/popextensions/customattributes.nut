::CustomAttributes <- {
	ROCKET_LAUNCHER_CLASSNAMES = [
		"tf_weapon_rocketlauncher",
		"tf_weapon_rocketlauncher_airstrike",
		"tf_weapon_rocketlauncher_directhit",
		"tf_weapon_particle_cannon",
	]

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
        "reloads full clip at once": null
        "fire full clip at once": null
        "passive reload": null
        "mult projectile scale": null
        "mult building scale": null
        "mult crit dmg": null
        "arrow ignite": null
        "add cond on hit": null
        "remove cond on hit": null
        "self add cond on hit": null
        "add cond on kill": null
        "add cond when active": null
        "fire input on hit":  null
        "fire input on kill":  null
        "replace weapon fire sound": null
        "rocket penetration": null
        "collect currency on kill": null

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

function CustomAttributes::AddCondOnHit(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.AddCondOnHit <- function(params) {

        local victim = GetPlayerFromUserID(params.userid)
        local attacker = GetPlayerFromUserID(params.attacker)

        if (victim == null || !victim.IsPlayer() || (typeof value == "array" && victim.InCond(value[0])) || (typeof value == "integer" && victim.InCond(value))|| attacker == null || attacker != player || params.weapon != wep) return

        typeof value == "array" ? victim.AddCondEx(v[0], v[1], attacker) : victim.AddCond(value)
    }
}

function CustomAttributes::RemoveCondOnHit(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.RemoveCondOnHit <- function(params) {

        if (victim == null || !victim.IsPlayer() || attacker == null || attacker != player || weapon != wep) return

        victim.RemoveCondEx(value, true)
    }
}

function CustomAttributes::SelfAddCondOnHit(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.SelfAddCondOnHit <- function(params) {
        local victim = params.victim, attacker = params.attacker

        if (attacker == null || !attacker.IsPlayer() || (typeof value == "array" && attacker.InCond(value[0])) || (typeof value == "integer" && attacker.InCond(value)))

        typeof value == "array" ? attacker.AddCondEx(v[0], v[1], attacker) : attacker.AddCond(value)
    }
}

function CustomAttributes::SelfAddCondOnKill(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.DeathHookTable.SelfAddCondOnKill <- function(params) {
        local attacker = GetPlayerFromUserID(params.attacker)
        local victim = GetPlayerFromUserID(params.userid)

        if (victim == null || attacker == null || !attacker.IsPlayer()) return

        typeof value == "array" ? attacker.AddCondEx(v[0], v[1], attacker) : attacker.AddCond(value)
    }
}

function CustomAttributes::FireInputOnHit(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local args = split(value, "^")
    local targetname = args[0]
    local input = args[1]
    local param = ""
    local delay = -1
    if (args.len() > 2) param = args[2]
    if (args.len() > 3) delay = args[3]

    CustomAttributes.TakeDamageTable.FireInputOnHit <- function(params) {

        if (params.attacker != player || params.weapon != wep) return

        targetname == "!self" ? EntFireByHandle(params.attacker, input, param, delay.tofloat(), null, null) : DoEntFire(targetname, input, param, delay.tofloat(), null, null)
    }
}

function CustomAttributes::FireInputOnKill(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local args = split(value, "^")
    local targetname = args[0]
    local input = args[1]
    local param = ""
    local delay = -1
    if (args.len() > 2) param = args[2]
    if (args.len() > 3) delay = args[3]

    CustomAttributes.DeathHookTable.FireInputOnKill <- function(params) {

        if (GetPlayerFromUserID(params.attacker) != player || params.weapon != wep) return

        targetname = "!self" ? EntFireByHandle(GetPlayerFromUserID(params.attacker), input, param, delay, null, null) : DoEntFire(targetname, input, param, delay, null, null)
    }
}

function CustomAttributes::DmgVsSameClass(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.DmgVsSameClass <- function(params) {
        local victim = params.const_entity
        local attacker = params.attacker

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

function CustomAttributes::MultDmgVsAirborne(player, item, value) {


    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.MultDmgVsAirborne <- function(params) {

        local victim = params.const_entity
        if (victim != null && victim.IsPlayer() && GetPropEntity(victim, "m_hGroundEntity") == null)
            params.damage *= value
    }
}

function CustomAttributes::TeleportInsteadOfDie(player, item, value) {


    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

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

function CustomAttributes::MeleeCleaveAttack(player, item, value = 64) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.cleavenextattack <- 0.0
    scope.cleaved <- false

    scope.PlayerThinkTable.MeleeCleaveAttack <- function() {

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

            if (wep.Clip1() != 1 && !player.IsCritBoosted())
            {
                player.RemoveCondEx(COND_CRITBOOST, true)
                return
            }

            if (!player.IsCritBoosted()) player.AddCondEx(COND_CRITBOOST, value, null)
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

        if (attacker == null) return

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

    local duration = 5, type = 2, speedmult = 0.2, stungiants = true

    if ("duration" in value) duration = value.duration
    if ("type" in value) type = value.type
    if ("speedmult" in value) speedmult = value.speedmult
    if ("stungiants" in value) stungiants = value.stungiants

    // `stun on hit`: { duration = 4 type = 2 speedmult = 0.2 stungiants = false] //in order: stun duration in seconds, stun type, stun movespeed multiplier, can stun giants true/false

    CustomAttributes.TakeDamageTable.StunOnHit <- function(params) {

        if (!params.const_entity.IsPlayer() || params.weapon != wep || (!stungiants && params.const_entity.IsMiniBoss())) return

        PopExtUtil.StunPlayer(params.const_entity, duration, type, 0, speedmult)
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

function CustomAttributes::ReplaceFireSound(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    PrecacheSound(value[1])
    PrecacheScriptSound(value[1])

    local scope = player.GetScriptScope()
    scope.attacksound <- 0.0

    scope.PlayerThinkTable.ReplaceFireSound <- function() {

        StopSoundOn(value[0], player)
        player.StopSound(value[0])

        if (!("attacksound" in scope) || GetPropFloat(wep, "m_flLastFireTime") == scope.attacksound) return

        EmitSoundEx({sound_name = value[1], entity = self})
        // EntFireByHandle(player, "RunScriptCode", "EmitSoundEx({sound_name = "+value[1]+", entity = self})", -1, null, null)

        scope.attacksound = GetPropFloat(wep, "m_flLastFireTime")
    }

}

function CustomAttributes::IsInvisible(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.IsInvisible <- function() {

        if (player.GetActiveWeapon() != wep || PopExtUtil.HasEffect(EF_NODRAW)) return
        wep.DisableDraw()
    }
}
function CustomAttributes::CannotUpgrade(player, item) {

    // EntFire("func_upgradestation", "RunScriptCode", "SetPropString(self, `m_iFilterName`, `__upgradefilter`)")

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local index = PopExtUtil.GetItemIndex(wep)
    local classname = GetPropString(wep, "m_iClassname")
    player.GetScriptScope().PlayerThinkTable.CannotUpgrade <- function() {

        if (GetPropBool(player, "m_Shared.m_bInUpgradeZone") && PopExtUtil.GetItemIndex(wep) != -1) {
            DoEntFire("func_upgradestation", "EndTouch", "", -1, player, player)
            // EntFireByHandle(player, "RunScriptCode", "SetPropBool(self, `m_Shared.m_bInUpgradeZone`, false)", -1, null, null)
            ClientPrint(player, HUD_PRINTCENTER, "This weapon cannot be upgraded")
            SetPropInt(wep, STRING_NETPROP_ITEMDEF, -1)
            SetPropString(wep, "m_iClassname", "")
            return
        }

        else if (!GetPropBool(player, "m_Shared.m_bInUpgradeZone") && PopExtUtil.GetItemIndex(wep) == -1) {
            SetPropString(wep, "m_iClassname", classname)
            SetPropInt(wep, STRING_NETPROP_ITEMDEF, index)
        }
    }
}

function CustomAttributes::AlwaysCrit(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.AlwaysCrit <- function() {

        if (player.GetActiveWeapon() == wep)
            player.AddCondEx(COND_CRITBOOST, 0.033, player)
    }
}

function CustomAttributes::AddCondWhenActive(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.AddCondWhenActive <- function() {

        if (player.GetActiveWeapon() == wep)
            player.AddCondEx(value, 0.033, player)
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

        local victim = params.const_entity
        if (params.weapon != wep || !victim.IsPlayer() || GetPropInt(victim, "m_LastHitGroup") != HITGROUP_HEAD) return

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

    CustomAttributes.TakeDamageTable.MultDmgVsTanks <- function(params) {

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

function CustomAttributes::PassiveReload(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()
    scope.PlayerThinkTable.PassiveReload <- function() {

        if (!wep.IsValid()) return
        local ammo = GetPropIntArray(player, "m_iAmmo", wep.GetSlot() + 1)

        if (player.GetActiveWeapon() != wep && wep.Clip1() != wep.GetMaxClip1())
        {
            if (!("ReverseMVMDrainAmmoThink" in scope.PlayerThinkTable)) //already takes care of this
                SetPropIntArray(player, "m_iAmmo", ammo - (wep.GetMaxClip1() - wep.Clip1()), wep.GetSlot() + 1)

            wep.SetClip1(wep.GetMaxClip1())
        }
    }
}

function CustomAttributes::CollectCurrencyOnKill(player, item, value) {
	local wep = PopExtUtil.HasItemInLoadout(player, item)
	if (wep == null) return

	wep.ValidateScriptScope()
	local scope = wep.GetScriptScope()
	scope.collectCurrencyOnKill <- true
}

function CustomAttributes::RocketPenetration(player, item, value) {
	local wep = PopExtUtil.HasItemInLoadout(player, item)
	if (wep == null) return

	if (ROCKET_LAUNCHER_CLASSNAMES.find(wep.GetClassname()) == null)
		return


	local scope = player.GetScriptScope()

	CustomAttributes.TakeDamageTable.RocketPenetration <- function(params) {
		local entity = params.const_entity
		if (!entity.IsPlayer())
			return

		local inflictor = params.inflictor

		inflictor.ValidateScriptScope()
		local inflictorScope = inflictor.GetScriptScope()

		if (!("isPenetrateMimicRocket" in inflictorScope))
			return

		params.player_penetration_count = inflictorScope.penetrationCount // change killicon to penetrate after rocket has penetrated at least 1 enemy
	}

	wep.ValidateScriptScope()
	local weaponScriptScope = wep.GetScriptScope()
	weaponScriptScope.last_fire_time <- 0.0
	weaponScriptScope.forceAttacking <- false

	weaponScriptScope.maxPenetration <- value

	weaponScriptScope.CheckWeaponFire <- function() {
		local fire_time = GetPropFloat(self, "m_flLastFireTime")
		if (fire_time > last_fire_time && !forceAttacking) {
			local owner = self.GetOwner()
			if (owner) {
				OnShot(owner)
			}

			last_fire_time = fire_time
		}
		return -1
	}
	weaponScriptScope.FindRocket <- function(owner) {
		local entity = null
		for (local entity; entity = FindByClassnameWithin(entity, "tf_projectile_*", owner.GetOrigin(), 100);) {
			if (entity.GetOwner() != owner) {
				continue
			}

			return entity
		}

		return null
	}
	weaponScriptScope.ApplyPenetrationToRocket <- function(owner, rocket) {
		rocket.SetSolid(Constants.ESolidType.SOLID_NONE)

		rocket.ValidateScriptScope()
		local rocketScope = rocket.GetScriptScope()
		rocketScope.isCustomRocket <- true
		rocketScope.lastRocketOrigin <- rocket.GetOrigin()
		rocketScope.maxPenetration <- maxPenetration

		rocketScope.collidedTargets <- []
		rocketScope.penetrationCount <- 0
		rocketScope.DetonateRocket <- function () {
			local owner = self.GetOwner()
			local launcher = GetPropEntity(self, "m_hLauncher")

			local charge = GetPropFloat(owner, "m_Shared.m_flItemChargeMeter")
			local nextAttack = GetPropFloat(launcher, "m_flNextPrimaryAttack")
			local lastFire = GetPropFloat(launcher, "m_flLastFireTime")
			local clip =  launcher.Clip1()
			local energy = GetPropFloat(launcher, "m_flEnergy")

			launcher.GetScriptScope().forceAttacking = true

			launcher.SetClip1(99)
			SetPropFloat(owner, "m_Shared.m_flItemChargeMeter", 100.0)
			SetPropBool(owner, "m_bLagCompensation", false)
			SetPropFloat(launcher, "m_flNextPrimaryAttack", 0)
			SetPropFloat(launcher, "m_flEnergy", 100.0)

			launcher.AddAttribute("crit mod disabled hidden", 1, -1)
			launcher.PrimaryAttack()
			launcher.RemoveAttribute("crit mod disabled hidden")

			launcher.GetScriptScope().forceAttacking = false
			launcher.SetClip1(clip)
			SetPropBool(owner, "m_bLagCompensation", true)
			SetPropFloat(launcher, "m_flNextPrimaryAttack", nextAttack)
			SetPropFloat(launcher, "m_flEnergy", energy)
			SetPropFloat(launcher, "m_flLastFireTime", lastFire)
			SetPropFloat(owner, "m_Shared.m_flItemChargeMeter", charge)

			for (local entity; entity = FindByClassnameWithin(entity, "tf_projectile_*", owner.GetOrigin(), 100);) {
				if (entity.GetOwner() != owner) {
					continue
				}

				if ("isCustomRocket" in entity.GetScriptScope())
					continue

				SetPropBool(self, "m_bCritical", GetPropBool(self, "m_bCritical"))
				entity.SetAbsOrigin(self.GetOrigin())

				entity.ValidateScriptScope()
				entity.GetScriptScope().isPenetrateMimicRocket <- true
				entity.GetScriptScope().originalRocket <- self
				entity.GetScriptScope().penetrationCount <- (self.GetScriptScope().penetrationCount - 1)

				break
			}
		}
		rocketScope.ProjectileThinkTable.RocketThink <- function() {
			local MASK_SOLID_BRUSHONLY = 16395

			local origin = self.GetOrigin()

			traceTableWorldSpawn <- {
				start = lastRocketOrigin,
				end = origin + (self.GetForwardVector() * 50)
				mask = MASK_SOLID_BRUSHONLY
				ignore = self.GetOwner()
			}

			TraceLineEx(traceTableWorldSpawn)

			if (traceTableWorldSpawn.hit && traceTableWorldSpawn.enthit)
			{
				self.SetSolid(SOLID_BBOX)
				delete self.GetScriptScope().ProjectileThinkTable.RocketThink
			}

			traceTable <- {
				start = lastRocketOrigin,
				end = origin
				ignore = self.GetOwner()
			}

			TraceLineEx(traceTable)

			lastRocketOrigin = origin

			if (!traceTable.hit)
				return -1

			if (!traceTable.enthit)
				return -1

			if (traceTable.enthit.GetTeam() == player.GetTeam())
				return -1

			if (collidedTargets.find(traceTable.enthit) != null)
				return -1

			collidedTargets.append(traceTable.enthit)
			penetrationCount++

			// arrow free penetration through allies without detonating
			if (traceTable.enthit.GetTeam() != player.GetTeam())
				penetrationCount++

			if (penetrationCount > (maxPenetration + 1))
			{
				self.SetSolid(Constants.ESolidType.SOLID_BBOX)
				SetPropString(self, "m_iszScriptThinkFunction", "")
				return -1
			}

			if (traceTable.enthit.GetTeam() != player.GetTeam())
				DetonateRocket()

			return -1
		}
	}
	weaponScriptScope.OnShot <- function(owner) {
		local rocket = FindRocket(owner)

		if (!rocket) {
			return
		}

		// don't apply penetration to cowmangler charge shot, because unfortunately it doesn't work :(
		if (GetPropBool(rocket, "m_bChargedShot"))
			return

		ApplyPenetrationToRocket(owner, rocket)
	}

	AddThinkToEnt(wep, "CheckWeaponFire")
}

function CustomAttributes::ReloadFullClipAtOnce(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.PlayerThinkTable.ReloadFullClipAtOnce <- function() {

        if (player.GetActiveWeapon() == wep && wep.Clip1() == 0)
            scope.isreloading <- true


        if (player.GetActiveWeapon() == wep && ("isreloading" in scope) && scope.isreloading && wep.Clip1() != 0) {

            wep.SetClip1(wep.GetMaxClip1())
            scope.isreloading = false
        }
    }
}

function CustomAttributes::MultProjectileScale(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.PlayerThinkTable.MultProjectileScale <- function() {

        if (!("attribinfo" in scope) || !("mult projectile scale" in scope.attribinfo) || player.GetActiveWeapon() != wep) return

        for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
            if (projectile.GetOwner() == player && projectile.GetModelScale() != value)
                projectile.SetModelScale(value, 0.0)
    }
}

function CustomAttributes::MultBuildingScale(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    if (!("BuiltObjectTable") in scope) return

    scope.BuiltObjectTable.MultBuildingScale <- function(params) {
        
        local building = EntIndexToHScript(params.index)
        if (GetPropEntity(building, "m_hBuilder") == player && "mult building scale" in scope.attribinfo)
            building.SetModelScale(value, 0.0)

    }
}

function CustomAttributes::MultCritDmg(player, item, value) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    CustomAttributes.TakeDamageTable.MultCritDmg <- function(params) {

        if (params.damage_type & DMG_CRITICAL) params.damage *= value
    }
}

function CustomAttributes::IgniteArrow(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    player.GetScriptScope().PlayerThinkTable.IgniteArrow <- function() {

        if (HasProp(wep, "m_bArrowAlight") && !GetPropBool(wep, "m_bArrowAlight"))
            SetPropBool(wep, "m_bArrowAlight", true)
    }
}

//REIMPLEMENTED VANILLA ATTRIBUTES

function CustomAttributes::AltFireDisabled(player, item) {

    local wep = PopExtUtil.HasItemInLoadout(player, item)
    if (wep == null) return

    local scope = player.GetScriptScope()

    scope.PlayerThinkTable.AltFireDisabled <- function() {

        if ("attribinfo" in scope && "alt-fire disabled" in scope.attribinfo && player.GetActiveWeapon() == wep)
        {
            SetPropInt(player, "m_afButtonDisabled", IN_ATTACK2)
            SetPropFloat(wep, "m_flNextSecondaryAttack", INT_MAX)
            return
        }
        SetPropInt(player, "m_afButtonDisabled", 0)
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
    if (wep == null) return
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
            scope.attribinfo[attr] <- format("Stuns victim for %f seconds on hit", value["duration"].tofloat())
        break

        case "is miniboss":
            CustomAttributes.IsMiniBoss(player, item)
            scope.attribinfo[attr] <- "When weapon is active: player becomes giant"
        break

        case "replace weapon fire sound":
            CustomAttributes.ReplaceFireSound(player, item, value)
            scope.attribinfo[attr] <- format("Weapon fire sound replaced with %s", value[1])
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
            scope.attribinfo[attr] <- "Weapon has no damage fall-off or ramp-up"
        break

        case "can headshot":
            CustomAttributes.CanHeadshot(player, item)
            scope.attribinfo[attr] <- "Crits on headshot"
        break

        case "cannot headshot":
            CustomAttributes.CannotHeadshot(player, item)
            scope.attribinfo[attr] <- "weapon cannot headshot"
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

        case "mult dmg vs airborne":
            CustomAttributes.MultDmgVsAirborne(player, item, value)
            scope.attribinfo[attr] <- format("damage multiplied by %f against airborne targets", value.tofloat())
        break

        case "set damage type":
            CustomAttributes.SetDamageType(player, item, value)
            scope.attribinfo[attr] <- format("Damage type set to %d", value)
        break

        case "set damage type custom":
            CustomAttributes.SetDamageTypeCustom(player, item, value)
            scope.attribinfo[attr] <- format("Custom damage type set to %d", value)
        break

        case "reloads full clip at once":
            CustomAttributes.ReloadFullClipAtOnce(player, item)
            scope.attribinfo[attr] <- "weapon reloads entire clip at once"
        break

        case "fire full clip at once":
            CustomAttributes.FireFullClipAtOnce(player, item)
            scope.attribinfo[attr] <- "weapon fires full clip at once"
        break

        case "passive reload":
            CustomAttributes.PassiveReload(player, item)
            scope.attribinfo[attr] <- "weapon reloads when holstered"
        break

        case "mult projectile scale":
            CustomAttributes.MultProjectileScale(player, item, value)
            scope.attribinfo[attr] <- format("projectile scale multiplied by %f", value.tofloat())
        break

        case "mult building scale":
            CustomAttributes.MultBuildingScale(player, item, value)
            scope.attribinfo[attr] <- format("building scale multiplied by %f", value.tofloat())
        break

        case "mult crit dmg":
            CustomAttributes.MultCritDmg(player, item, value)
            scope.attribinfo[attr] <- format("crit damage multiplied by %f", value.tofloat())
        break

        case "arrow ignite":
            CustomAttributes.IgniteArrow(player, item)
            scope.attribinfo[attr] <- "arrows are always ignited"
        break

        case "cannot upgrade":
            CustomAttributes.CannotUpgrade(player, item)
            scope.attribinfo[attr] <- "weapon cannot be upgraded"
        break

        case "add cond on hit":
            CustomAttributes.AddCondOnHit(player, item, value)
            scope.attribinfo[attr] <- format("applies cond %d to victim on hit", typeof value == "array" ? value[0] : value)
        break

        case "remove cond on hit":
            CustomAttributes.RemoveCondOnHit(player, item, value)
            scope.attribinfo[attr] <- format("Remove cond %d on hit", value)
        break

        case "self add cond on hit":
            CustomAttributes.SelfAddCondOnHit(player, item, value)
            scope.attribinfo[attr] <- format("applies cond %d to self on hit", typeof value == "array" ? value[0] : value)
        break

        case "add cond on kill":
            CustomAttributes.SelfAddCondOnKill(player, item, value)
            scope.attribinfo[attr] <- format("applies cond %d to self on kill", typeof value == "array" ? value[0] : value)
        break

        case "add cond when active":
            CustomAttributes.AddCondWhenActive(player, item, value)
            scope.attribinfo[attr] <- format("when active: player receives cond %d", value)
        break

        case "fire input on hit":
            CustomAttributes.FireInputOnHit(player, item, value)
            scope.attribinfo[attr] <- format("fires custom entity input on hit: %s", value)
        break

        case "fire input on kill":
            CustomAttributes.FireInputOnKill(player, item, value)
            scope.attribinfo[attr] <- format("fires custom entity input on kill: %s", value)
        break

        case "rocket penetration":
            CustomAttributes.RocketPenetration(player, item, value)
            scope.attribinfo[attr] <- format("rocket penetrates up to %d enemy players", value)
        break

		case "collect currency on kill":
            CustomAttributes.CollectCurrencyOnKill(player, item, value)
            scope.attribinfo[attr] <- "bots drop money when killed"
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