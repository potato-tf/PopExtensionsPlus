local root = getroottable()
IncludeScript("popextensions_util", root)
IncludeScript("popextensions_botbehavior", root)

//behavior tags
local popext_funcs =
{
    popext_addcond = function(bot, args)
    {
        printl(args[0])
        if (args.len() == 1)
            if (args[0].tointeger() == 43)
                bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, false)
            else
                bot.AddCond(args[0].tointeger())

        else if (args.len() >= 2)
            bot.AddCondEx(args[0].tointeger(), args[1].tointeger(), null)
    }

    popext_reprogrammed = function(bot, args)
    {
        bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, false)
    }

    popext_reprogrammed_neutral = function(bot, args)
    {
        bot.ForceChangeTeam(TEAM_UNASSIGNED, false)
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
        bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", Classes[bot.GetPlayerClass()]))
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
        NetProps.SetPropInt(weapon, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", args[1].tointeger())
        NetProps.SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
        NetProps.SetPropBool(weapon, "m_bValidatedAttachedEntity", true)
        weapon.SetTeam(bot.GetTeam())
        Entities.DispatchSpawn(weapon)

        bot.Weapon_Equip(weapon)

        for (local i = 0; i < 7; i++)
        {
            local heldWeapon = NetProps.GetPropEntityArray(bot, "m_hMyWeapons", i)
            if (heldWeapon == null)
                continue
            if (heldWeapon.GetSlot() != weapon.GetSlot())
                continue
            heldWeapon.Destroy()
            NetProps.SetPropEntityArray(bot, "m_hMyWeapons", weapon, i)
            break
        }

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
                    local primary;

                    for (local i = 0; i < 7; i++)
                    {
                        local wep = NetProps.GetPropEntityArray(bot, "m_hMyWeapons", i)
                        if ( wep == null || wep.GetSlot() != 0) continue

                        primary = wep
                        break
                    }
                    bot.Weapon_Switch(primary)
                    primary.AddAttribute("disable weapon switch", 1, 1)
                    primary.ReapplyProvision()
                }
                break

            case 2: //TF_CLASS_SNIPER
                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 750);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().GetSlot() == 2) continue //potentially not break sniper ai
                    local secondary;

                    for (local i = 0; i < 7; i++)
                    {
                        local wep = NetProps.GetPropEntityArray(bot, "m_hMyWeapons", i)
                        if ( wep == null || wep.GetSlot() != 1) continue

                        secondary = wep
                        break
                    }

                    bot.Weapon_Switch(secondary)
                    secondary.AddAttribute("disable weapon switch", 1, 1)
                    secondary.ReapplyProvision()
                }
                break

            case 3: //TF_CLASS_SOLDIER
                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().Clip1() != 0) continue

                    local secondary;

                    for (local i = 0; i < 7; i++)
                    {
                        local wep = NetProps.GetPropEntityArray(bot, "m_hMyWeapons", i)
                        if ( wep == null || wep.GetSlot() != 1) continue

                        secondary = wep
                        break
                    }
                    bot.Weapon_Switch(secondary)

                    secondary.AddAttribute("disable weapon switch", 1, 2)
                    secondary.ReapplyProvision()
                }
                break

            case 7: //TF_CLASS_PYRO

                //scout and pyro's UseBestWeapon is inverted
                //switch them to secondaries, then back to primary when enemies are close
                //TODO: check if we're targetting a soldier with a simple raycaster, or wait for more bot functions to be exposed
                if (bot.GetActiveWeapon() != NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))
                    bot.Weapon_Switch(NetProps.GetPropEntityArray(bot, "m_hMyWeapons", 1))

                for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);)
                {
                    if (p.GetTeam() == bot.GetTeam()) continue
                    local primary;

                    for (local i = 0; i < 7; i++)
                    {
                        local wep = NetProps.GetPropEntityArray(bot, "m_hMyWeapons", i)
                        if ( wep == null || wep.GetSlot() != 0) continue

                        primary = wep
                        break
                    }
                    bot.Weapon_Switch(primary)
                    primary.AddAttribute("disable weapon switch", 1, 1)
                    primary.ReapplyProvision()
                }
                break
            }
        }
        bot.GetScriptScope().ThinkTable.BestWeaponThink <- BestWeaponThink
    }
    popext_homingprojectile = function(bot, args)
    {
        // Tag homingprojectile |turnpower|speedmult|ignoreStealthedSpies|ignoreDisguisedSpies

        local args_len = args.len()

        local turn_power = (args_len > 0) ? args[0].tofloat() : 0.75
        local speed_mult = (args_len > 1) ? args[1].tofloat() : 1.0
        local ignoreStealthedSpies = (args_len > 2) ? args[2].tointeger() : 1
        local ignoreDisguisedSpies = (args_len > 3) ? args[3].tointeger() : 1

        function HomingProjectileScanner(bot)
        {
            local projectile
            while ((projectile = Entities.FindByClassname(projectile, "tf_projectile_*")) != null) {

                if (projectile.GetOwner() != bot) continue

                if (!IsValidProjectile(projectile, HomingProjectiles)) continue

        		if (projectile.GetScriptThinkFunc() == "HomingProjectileThink") continue

                // Any other parameters needed by the projectile thinker can be set here
                AttachProjectileThinker(projectile, speed_mult, turn_power, ignoreDisguisedSpies, ignoreStealthedSpies)
            }
        }
        bot.GetScriptScope().ThinkTable.HomingProjectileScanner <- HomingProjectileScanner

        function HomingTakeDamage(params)
        {
            if (!params.const_entity.IsPlayer()) return

            local classname = params.inflictor.GetClassname()
            if (classname != "tf_projectile_flare" && classname != "tf_projectile_energy_ring")
                return

            EntFireByHandle(params.inflictor, "Kill", null, 0.5, null, null)
        }
        bot.GetScriptScope().TakeDamageTable.HomingTakeDamage <- HomingTakeDamage
    }
    // popext_rocketcustomtrail = function (bot, args)
    // {
    //     local projectile;
    //     while (projectile = Entities.FindByClassname(null, "tf_projectile_rocket"))
    //     {
    //         if (GetPropEntity(projectile, "m_hOwnerEntity") != bot) continue

    //         EntFireByHandle(projectile, "DispatchEffect", "ParticleEffectStop", -1, null, null)
    //     }
    // }
    popext_rocketcustomparticle = function (bot, args)
    {
        local projectile;
        while (projectile = Entities.FindByClassname(null, "tf_projectile_rocket"))
        {
            if (GetPropEntity(projectile, "m_hOwnerEntity") != bot) continue

            EntFireByHandle(projectile, "DispatchEffect", "ParticleEffectStop", -1, null, null)
            EntFireByHandle(projectile, "RunScriptCode", format("self.DispatchParticleEffect(%s, self.GetOrigin(), self.GetAbsAngles())", args), -1, null, null)
        }
    }
    popext_improvedairblast = function (bot, args)
    {
        function ImprovedAirblastThink()
        {
            local projectile
            while ((projectile = FindByClassname(projectile, "tf_projectile_*")) != null)
            {
                if (projectile.GetTeam() == team || !IsValidProjectile(projectile, DeflectableProjectiles))
                    continue

                local dist = GetThreatDistanceSqr(projectile)
                if (dist <= 67000 && IsVisible(projectile)) //67700
                {
                    switch (botLevel) {
                        case 1: // Basic Airblast, only deflect if in FOV

                            if (!IsInFieldOfView(projectile))
                                return
                            break
                        case 2: // Advanced Airblast, deflect regardless of FOV

                            LookAt(projectile.GetOrigin(), 9999, 9999)
                            break
                        case 3: // Expert Airblast, deflect regardless of FOV back to Sender

                            local owner = projectile.GetOwner()
                            if (owner != null)
                            {
                                local owner_head = owner.GetAttachmentOrigin(owner.LookupAttachment("head"))
                                LookAt(owner_head, 9999, 9999)
                            }
                            break
                    }
                    bot.PressAltFireButton(0.0)
                }
            }
        }
        bot.GetScriptScope().ThinkTable.ImprovedAirblastThink <- ImprovedAirblastThink
    }
    popext_addcondonhit = function(bot, args)
    {
        // Tag addcondonhit |cond|duration|threshold|crit

        // Leave Duration blank for infinite duration
        // Leave Threshold blank to apply effect on any hit

        local args_len = args.len()

        local cond = args[0].tointeger()
        local duration = (args_len >= 2) ? args[1].tofloat() : -1.0
        local dmgthreshold = (args_len >= 3) ? args[2].tofloat() : 0.0
        local critOnly = (args_len >= 4) ? args[3].tointeger() : 0

        // Add the new variables to the bot's scope
        local bot_scope = bot.GetScriptScope()
        bot_scope.CondOnHit = true
        bot_scope.CondOnHitVal = cond
        bot_scope.CondOnHitDur = duration
        bot_scope.CondOnHitDmgThres = dmgthreshold
        bot_scope.CondOnHitCritOnly    = critOnly

        function AddCondOnHitTakeDamage(params)
        {
            if (!params.const_entity.IsPlayer()) return

            local victim = params.const_entity
            local attacker = params.attacker

            if (attacker != null && victim != attacker)
            {
                local attacker_scope = attacker.GetScriptScope()

                if (!attacker_scope.CondOnHit) return

                local hurt_damage = params.damage
                local victim_health = victim.GetHealth() - hurt_damage
                local isCrit = params.crit

                if (victim_health <= 0) return

                if (attacker_scope.CondOnHitCritOnly == 1 && !isCrit) return

                if ((attacker_scope.CondOnHitCritOnly == 1 && isCrit) || (attacker_scope.CondOnHitDmgThres == 0.0 || hurt_damage >= attacker_scope.CondOnHitDmgThres))
                    victim.AddCondEx(attacker_scope.CondOnHitVal, attacker_scope.CondOnHitDur, null)
            }
        }

        bot.GetScriptScope().TakeDamageTable.AddCondOnHitTakeDamage <- AddCondOnHitTakeDamage
    }
}

// Modify the AttachProjectileThinker function to accept projectile speed adjustment if needed
::AttachProjectileThinker <- function(projectile, speed_mult, turn_power, ignoreDisguisedSpies, ignoreStealthedSpies)
{
	local projectile_speed = projectile.GetAbsVelocity().Norm()

    projectile_speed *= speed_mult

	projectile.ValidateScriptScope()
    local projectile_scope = projectile.GetScriptScope()
	projectile_scope.turn_power           <- turn_power
    projectile_scope.projectile_speed     <- projectile_speed
	projectile_scope.ignoreDisguisedSpies <- ignoreDisguisedSpies
	projectile_scope.ignoreStealthedSpies <- ignoreStealthedSpies

	AddThinkToEnt(projectile, "HomingProjectileThink")
}

::HomingProjectileThink <- function()
{
	local new_target = SelectVictim(self)
	if (new_target != null && IsLookingAt(self, new_target))
		FaceTowards(new_target, self, projectile_speed)

	return -1
}

::SelectVictim <- function(projectile)
{
	local target
	local min_distance = 32768.0
	for (local i = 1; i <= MaxClients(); i++)
	{
		local player = PlayerInstanceFromIndex(i)

		if (player == null)
			continue

		local distance = (projectile.GetOrigin() - player.GetOrigin()).Length()

		if (IsValidTarget(player, distance, min_distance, projectile))
		{
			target = player
			min_distance = distance
		}
	}
	return target
}

::IsValidTarget <- function(victim, distance, min_distance, projectile) {

    // Early out if basic conditions aren't met
    if (distance > min_distance || victim.GetTeam() == projectile.GetTeam() || !IsAlive(victim)) {
        return false
    }

    // Check for conditions based on the projectile's configuration
    if (victim.IsPlayer()) {
        if (victim.InCond(TF_COND_HALLOWEEN_GHOST_MODE)) {
            return false
        }

        // Check for stealth and disguise conditions if not ignored
        if (!ignoreStealthedSpies && (victim.IsStealthed() || victim.IsFullyInvisible())) {
            return false
        }
        if (!ignoreDisguisedSpies && victim.GetDisguiseTarget() != null) {
            return false
        }
    }

    return true
}


::FaceTowards <- function(new_target, projectile, projectile_speed)
{
	local desired_dir = new_target.EyePosition() - projectile.GetOrigin()
		desired_dir.Norm()

	local current_dir = projectile.GetForwardVector()
	local new_dir = current_dir + (desired_dir - current_dir) * turn_power
		new_dir.Norm()

	local move_ang = VectorAngles(new_dir)
	local projectile_velocity = move_ang.Forward() * projectile_speed

	projectile.SetAbsVelocity(projectile_velocity)
	projectile.SetLocalAngles(move_ang)
}

::IsLookingAt <- function(projectile, new_target)
{
	local target_origin = new_target.GetOrigin()
	local projectile_owner = projectile.GetOwner()
	local projectile_owner_pos = projectile_owner.EyePosition()

	if (TraceLine(projectile_owner_pos, target_origin, projectile_owner))
	{
		local direction = (target_origin - projectile_owner.EyePosition())
			direction.Norm()
		local product = projectile_owner.EyeAngles().Forward().Dot(direction)

		if (product > 0.6)
			return true
	}

	return false
}

::IsValidProjectile <-  function(projectile, table)
{
	if (projectile.GetClassname() in table)
		return true

	return false
}

// ::GetBotBehaviorFromTags <- function(bot)
// {
//     local tags = {}
//     local scope = bot.GetScriptScope()
//     bot.GetAllBotTags(tags)

//     if (tags.len() == 0) return

//     foreach (tag in tags)
//     {
//         local args = split(tag, "|")
//         if (args.len() == 0) continue
//         local func = args.remove(0)
//         if (func in popext_funcs)
//             popext_funcs[func](bot, args)
//     }
    // function PopExt_BotThinks()
    // {
    //     local scope = self.GetScriptScope()
    //     if (scope.ThinkTable.len() < 1) return;

    //     foreach (_, func in scope.ThinkTable)
    //        func(self)
    // }
//     AddThinkToEnt(bot, "PopExt_BotThinks")
// }

// local tagtest = "popext_usebestweapon"
//local tagtest = "popext_homingprojectile|1.0|1.0"
local tagtest = "popext_improvedairblast"

::AI_BotSpawn <- function(bot)
{
	local scope = bot.GetScriptScope()

	scope.bot <- AI_Bot(bot)
	scope.BehaviorAttribs <- {}

    if (bot.HasBotTag(tagtest))
    {
        local args = split(tagtest, "|")
        local func = args.remove(0)
        // printl(popext_funcs[func] + " : " + bot + " : " + args[1])
        if (func in popext_funcs)
            popext_funcs[func](bot, args)
    }

	//bot.AddBotAttribute(1024); // IGNORE_ENEMIES

    AddThinkToEnt(bot, "BotThink")
}

::BotThink <- function()
{
    bot.OnUpdate()

    return -1
}

::PopExt_Tags <- {

    function OnGameEvent_post_inventory_application(params)
    {
        local bot = GetPlayerFromUserID(params.userid)

        bot.ValidateScriptScope()
        local scope = bot.GetScriptScope()

        if ("ThinkTable" in scope || !bot.IsBotOfType(1337)) return
		local items = {

			ThinkTable = {}
            TakeDamageTable = {}
            DeathHookTable = {}
		}
        foreach (k,v in items) if (!(k in scope)) scope[k] <- v
        EntFireByHandle(bot, "RunScriptCode", "AI_BotSpawn(self)", -1, null, null);
    }
    function OnScriptHook_OnTakeDamage(params)
    {
        local attacker_scope = params.attacker.GetScriptScope()

        if (!("TakeDamageTable" in attacker_scope)) return;

        foreach (_, func in attacker_scope.TakeDamageTable)
            func(params)
    }
    function OnGameEvent_player_builtobject(params)
    {
        local bot = GetPlayerFromUserID(params.userid)
        if (!bot.IsBotOfType(1337)) return

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

    function OnGameEvent_player_team(params)
    {
        local bot = GetPlayerFromUserID(params.userid)
        if (bot.IsBotOfType(1337) || params.team == TEAM_SPECTATOR)
            AddThinkToEnt(bot, null)
    }

    function OnGameEvent_player_death(params)
    {
        local bot = GetPlayerFromUserID(params.userid)
        if (bot.IsBotOfType(1337))
            AddThinkToEnt(bot, null)
    }
}
__CollectGameEventCallbacks(PopExt_Tags)