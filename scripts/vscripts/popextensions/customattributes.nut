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
	BuiltObjectTable = {}
	UpgradedObjectTable = {}
	QuickSentryUpgradeTable = {}

    Attrs = {

		"fires milk bolt": function(player, items, attr, value) {
			CustomAttributes.FiresMilkBolt(player, items, value)
			local duration = 10.0, recharge = 20.0
			if ("duration" in value) duration = value.duration
			if ("recharge" in value) recharge = value.recharge
			player.GetScriptScope().attribinfo[attr] <- format("Secondary attack: fires a bolt that applies milk for %.2f seconds. Regenerates every %.2f seconds.", duration.tofloat(), recharge.tofloat())
		}

		"mod teleporter speed boost": function(player, items, attr, value) {
			CustomAttributes.ModTeleporterSpeedBoost(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Teleporters grant a speed boost for %.2f seconds upon exiting", value)
		}

		"set turn to ice": function(player, items, attr, value) {
			CustomAttributes.SetTurnToIce(player, items)
			player.GetScriptScope().attribinfo[attr] <- format("On Kill: Turn victim to ice.", value)
		}

		"mult teleporter recharge rate": function(player, items, attr, value) {
			CustomAttributes.MultTeleporterRechargeTime(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Teleporter recharge rate multiplied by %.2f", value)
		}

		"melee cleave attack": function(player, items, attr, value) {
			CustomAttributes.MeleeCleaveAttack(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- "On Swing: Weapon hits multiple targets"
		}

		"last shot crits": function(player, items, attr, value) {
			CustomAttributes.LastShotCrits(player, items, value)
			local duration = 0.033
			if ("duration" in value) duration = value.duration
			player.GetScriptScope().attribinfo[attr] <- format("Crit boost on last shot. Crit boost will stay active for %.2f seconds after holster", duration.tofloat())
		}

		"wet immunity": function(player, items, attr, value) {
			CustomAttributes.WetImmunity(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Immune to jar effects when active"
		}

		"can breathe under water": function(player, items, attr, value) {
			CustomAttributes.CanBreatheUnderWater(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Player can breathe underwater"
		}

		"mult swim speed": function(player, items, attr, value) {
			CustomAttributes.MultSwimSpeed(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Swimming speed multiplied by %.2f", value.tofloat())
		}

		"teleport instead of die": function(player, items, attr, value) {
			CustomAttributes.TeleportInsteadOfDie(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("%d⁒ chance of teleporting to spawn with 1 health instead of dying", (value.tofloat() * 100).tointeger())
		}

		"mult dmg vs same class": function(player, items, attr, value) {
			CustomAttributes.MultDmgVsSameClass(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Damage versus %s multiplied by %.2f", PopExtUtil.Classes[player.GetPlayerClass()], value.tofloat())
		}

		"uber on damage taken": function(player, items, attr, value) {
			CustomAttributes.UberOnDamageTaken(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("On take damage: %d⁒ chance of gaining invicibility for 3 seconds", (value.tofloat() * 100).tointeger())
		}

		"build small sentries": function(player, items, attr, value) {
			CustomAttributes.BuildSmallSentries(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Sentries are 20⁒ smaller, have 33⁒ less health, take 25⁒ less metal to upgrade"
		}

		"crit when health below": function(player, items, attr, value) {
			CustomAttributes.CritWhenHealthBelow(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Player is crit boosted when below %d health", value)
		}

		"mvm sentry ammo": function(player, items, attr, value) {
			CustomAttributes.MvmSentryAmmo(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Sentry ammo multiplied by %.2f", value.tofloat())
		}

		//FULLY CUSTOM ATTRIBUTES BELOW
		//no hidden dev alternative

		"radius sleeper": function(player, items, attr, value) {
			CustomAttributes.RadiusSleeper(player, items)
			player.GetScriptScope().attribinfo[attr] <- "On full charge headshot: create jarate explosion on victim"
		}

		"explosive bullets": function(player, items, attr, value) {
			CustomAttributes.ExplosiveBullets(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Fires explosive rounds that deal %d damage", value)
		}

		"old sandman stun": function(player, items, attr, value) {
			CustomAttributes.OldSandmanStun(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Uses pre-JI stun mechanics"
		}

		"stun on hit": function(player, items, attr, value) {
			CustomAttributes.StunOnHit(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Stuns victim for %.2f seconds on hit", value["duration"].tofloat())
		}

		"is miniboss": function(player, items, attr, value) {
			CustomAttributes.IsMiniboss(player, items)
			player.GetScriptScope().attribinfo[attr] <- "When weapon is active: player becomes giant"
		}

		"replace weapon fire sound": function(player, items, attr, value) {
			CustomAttributes.ReplaceWeaponFireSound(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Weapon fire sound replaced with %s", value[1])
		}

		"is invisible": function(player, items, attr, value) {
			CustomAttributes.IsInvisible(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Weapon is invisible"
		}

		"cannot upgrade": function(player, items, attr, value) {
			CustomAttributes.CannotUpgrade(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Weapon cannot be upgraded"
		}

		"always crit": function(player, items, attr, value) {
			CustomAttributes.AlwaysCrit(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Weapon always crits"
		}

		"dont count damage towards crit rate": function(player, items, attr, value) {
			CustomAttributes.DontCountDamageTowardsCritRate(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Damage doesn't count towards crit rate"
		}

		"no damage falloff": function(player, items, attr, value) {
			CustomAttributes.NoDamageFalloff(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Weapon has no damage fall-off or ramp-up"
		}

		"can headshot": function(player, items, attr, value) {
			CustomAttributes.CanHeadshot(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Crits on headshot"
		}

		"cannot headshot": function(player, items, attr, value) {
			CustomAttributes.CannotHeadshot(player, items)
			player.GetScriptScope().attribinfo[attr] <- "weapon cannot headshot"
		}

		"cannot be headshot": function(player, items, attr, value) {
			CustomAttributes.CannotBeHeadshot(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Immune to headshots"
		}

		"projectile lifetime": function(player, items, attr, value) {
			CustomAttributes.ProjectileLifetime(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("projectile disappears after %.2f seconds", value.tofloat())
		}

		"mult dmg vs tanks": function(player, items, attr, value) {
			CustomAttributes.MultDmgVsTanks(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Damage vs tanks multiplied by %.2f", value.tofloat())
		}

		"mult dmg vs giants": function(player, items, attr, value) {
			CustomAttributes.MultDmgVsGiants(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Damage vs giants multiplied by %.2f", value.tofloat())
		}

		"mult dmg vs airborne": function(player, items, attr, value) {
			CustomAttributes.MultDmgVsAirborne(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("damage multiplied by %.2f against airborne targets", value.tofloat())
		}

		"set damage type": function(player, items, attr, value) {
			CustomAttributes.SetDamageType(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Damage type set to %d", value)
		}

		"set damage type custom": function(player, items, attr, value) {
			CustomAttributes.SetDamageTypeCustom(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Custom damage type set to %d", value)
		}

		"reloads full clip at once": function(player, items, attr, value) {
			CustomAttributes.ReloadsFullClipAtOnce(player, items)
			player.GetScriptScope().attribinfo[attr] <- "This weapon reloads its entire clip at once."
		}

		"fire full clip at once": function(player, items, attr, value) {
			CustomAttributes.FireFullClipAtOnce(player, items)
			player.GetScriptScope().attribinfo[attr] <- "weapon fires full clip at once"
		}

		"passive reload": function(player, items, attr, value) {
			CustomAttributes.PassiveReload(player, items)
			player.GetScriptScope().attribinfo[attr] <- "weapon reloads when holstered"
		}

		"mult projectile scale": function(player, items, attr, value) {
			CustomAttributes.MultProjectileScale(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("projectile scale multiplied by %.2f", value.tofloat())
		}

		"mult building scale": function(player, items, attr, value) {
			CustomAttributes.MultBuildingScale(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("building scale multiplied by %.2f", value.tofloat())
		}

		"mult crit dmg": function(player, items, attr, value) {
			CustomAttributes.MultCritDmg(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("crit damage multiplied by %.2f", value.tofloat())
		}

		"arrow ignite": function(player, items, attr, value) {
			CustomAttributes.ArrowIgnite(player, items)
			player.GetScriptScope().attribinfo[attr] <- "arrows are always ignited"
		}

		"add cond on hit": function(player, items, attr, value) {
			CustomAttributes.AddCondOnHit(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("applies cond %d to victim on hit", typeof value == "array" ? value[0].tointeger() : value)
		}

		"remove cond on hit": function(player, items, attr, value) {
			CustomAttributes.RemoveCondOnHit(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Remove cond %d on hit", value)
		}

		"self add cond on hit": function(player, items, attr, value) {
			CustomAttributes.SelfAddCondOnHit(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("applies cond %d to self on hit", typeof value == "array" ? value[0].tointeger() : value)
		}

		"self add cond on kill": function(player, items, attr, value) {
			CustomAttributes.SelfAddCondOnKill(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("applies cond %d to self on kill", typeof value == "array" ? value[0].tointeger() : value)
		}

		"add cond when active": function(player, items, attr, value) {
			CustomAttributes.AddCondWhenActive(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("when active: player receives cond %d", value)
		}

		"fire input on hit": function(player, items, attr, value) {
			CustomAttributes.FireInputOnHit(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("fires custom entity input on hit: %s", value)
		}

		"fire input on kill": function(player, items, attr, value) {
			CustomAttributes.FireInputOnKill(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("fires custom entity input on kill: %s", value)
		}

		"rocket penetration": function(player, items, attr, value) {
			CustomAttributes.RocketPenetration(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("rocket penetrates up to %d enemy players", value)
		}

		"collect currency on kill": function(player, items, attr, value) {
			CustomAttributes.CollectCurrencyOnKill(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- "bots drop money when killed"
		}

		"noclip projectile": function(player, items, attr, value) {
			CustomAttributes.NoclipProjectile(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- "projectiles go through walls and enemies harmlessly"
		}

		"projectile gravity": function(player, items, attr, value) {
			CustomAttributes.ProjectileGravity(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("projectile gravity %d hu/s", value)
		}

		"immune to cond": function(player, items, attr, value) {
			if (typeof value == "integer") {
				CustomAttributes.ImmuneToCond(player, items, value)
				player.GetScriptScope().attribinfo[attr] <- format("wielder is immune to cond %d", value)
			} else {
				CustomAttributes.ImmuneToCond(player, items, value)
				local outputString = ""
				foreach (item in value) {
					outputString += (item.tostring() + ", ")
				}
				local finalCommaAndSpace = 2
				outputString = outputString.slice(0, outputString.len() - finalCommaAndSpace)
				player.GetScriptScope().attribinfo[attr] <- format("wielder is immune to cond %s", outputString)
			}
		}

		"mult max health": function(player, items, attr, value) {
			CustomAttributes.MultMaxHealth(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Player max health is multiplied by %.2f", value.tofloat())
		}

		//add custom item description during inspection; wrap text with \n in value
		"special item description": function(player, items, attr, value) {
			player.GetScriptScope().attribinfo[attr] <- format("%s", value)
		}

		//VANILLA ATTRIBUTE REIMPLEMENTATIONS

		"alt-fire disabled": function(player, items, attr, value) {
			CustomAttributes.AltFireDisabled(player, items)
			player.GetScriptScope().attribinfo[attr] <- "Secondary fire disabled"
		}

		"custom projectile model": function(player, items, attr, value) {
			CustomAttributes.CustomProjectileModel(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("Fires custom projectile model: %s", value)
		}

		"dmg bonus while half dead": function(player, items, attr, value) {
			CustomAttributes.DmgBonusWhileHalfDead(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("damage bonus while under 50% health", value)
		}

		"dmg penalty while half alive": function(player, items, attr, value) {
			CustomAttributes.DmgPenaltyWhileHalfAlive(player, items, value)
			player.GetScriptScope().attribinfo[attr] <- format("damage penalty while above 50% health", value)
		}
    }

	function FiresMilkBolt(player, items, value) {

		foreach(item, attrs in items)
		{

			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()
			local playerScope = player.GetScriptScope()

			// mad milk default params
			local duration = 10.0, recharge = 20.0

			if ("duration" in value) duration = value.duration
			if ("recharge" in value) recharge = value.recharge

			scope.milkBoltLastFireTime <- 0.0
			scope.milkBoltRequest <- false

			playerScope.PlayerThinkTable[format("FiresMilkBolt_%d_%d", player.GetScriptScope().userid, wep.entindex())] <- function() {

				if (wep == null || player.GetActiveWeapon() != wep) return

				if (PopExtUtil.InButton(player, IN_ATTACK2) && Time() - scope.milkBoltLastFireTime > recharge) {
					// these 3 following lines must be in this order, otherwise it will break
					scope.milkBoltRequest = true
					wep.PrimaryAttack()
					scope.milkBoltLastFireTime = Time()
				}
				if (PopExtUtil.InButton(player, IN_ATTACK2) && Time() - scope.milkBoltLastFireTime < recharge) {
					ClientPrint(player, HUD_PRINTCENTER, format("Milk bolt is recharging! It will be available in %.1f seconds.", scope.milkBoltLastFireTime - Time() + recharge))
				}
				if (PopExtUtil.InButton(player, IN_ATTACK) || PopExtUtil.InButton(player, IN_ATTACK3) || player.GetActiveWeapon() != wep) {
					scope.milkBoltRequest = false
				}
			}

			CustomAttributes.TakeDamageTable[format("FireMilkBolt_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {


				// local victim = GetPlayerFromUserID(params.userid)
				// local attacker = GetPlayerFromUserID(params.attacker)
				local victim = params.const_entity
				local attacker = params.attacker

				if (!attacker || !victim.IsPlayer()) return

				local wep = PopExtUtil.HasItemInLoadout(player, params.weapon)

				// printl(EntIndexToHScript(params.weaponid))

				local scope = wep ? scope = wep.GetScriptScope() : false

				if (!scope || !victim || !attacker || attacker != player || !("milkBoltRequest" in scope) || !scope.milkBoltRequest || Time() - scope.milkBoltLastFireTime < recharge) return

				victim.AddCondEx(TF_COND_MAD_MILK, duration, attacker)
				scope.milkBoltRequest = false

			}
		}
	}

	function AddCondOnHit(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("AddCondOnHit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity
				local attacker = params.attacker

				if (victim == null || !victim.IsPlayer() || victim.IsInvulnerable() || (typeof value == "array" && victim.InCond(value[0])) || (typeof value == "integer" && victim.InCond(value)) || attacker == null || attacker != player || params.weapon != wep) return

				typeof value == "array" ? victim.AddCondEx(value[0], value[1], attacker) : victim.AddCond(value)
			}
		}
	}

	function RemoveCondOnHit(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamagePostTable[format("RemoveCondOnHit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = GetPlayerFromUserID(params.userid)
				local attacker = GetPlayerFromUserID(params.attacker)

				if (victim == null || attacker == null || !victim.IsPlayer() || !victim.InCond(value) || victim.IsInvulnerable() || attacker != player || params.weapon != wep) return

				victim.RemoveCondEx(value, true)
			}
		}
	}

	function SelfAddCondOnHit(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("SelfAddCondOnHit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity
				local attacker = params.attacker

				if (attacker == null || !attacker.IsPlayer() || victim.IsInvulnerable() || (typeof value == "array" && attacker.InCond(value[0])) || (typeof value == "integer" && attacker.InCond(value))) return

				typeof value == "array" ? attacker.AddCondEx(value[0], value[1], attacker) : attacker.AddCond(value)
			}
		}
	}

	function SelfAddCondOnKill(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.DeathHookTable[format("SelfAddCondOnKill_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local attacker = GetPlayerFromUserID(params.attacker)
				local victim = GetPlayerFromUserID(params.userid)

				if (victim == null || attacker == null || !attacker.IsPlayer()) return

				typeof value == "array" ? attacker.AddCondEx(value[0], value[1], attacker) : attacker.AddCond(value)
			}
		}
	}

	function FireInputOnHit(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local args = split(value, "^")
			local targetname = args[0]
			local input = args[1]
			local param = ""
			local delay = -1
			if (args.len() > 2) param = args[2]
			if (args.len() > 3) delay = args[3].tofloat()

			CustomAttributes.TakeDamageTable[format("FireInputOnHit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.attacker != player || params.weapon != wep) return

				targetname == "!self" ? EntFireByHandle(params.attacker, input, param, delay, null, null) : DoEntFire(targetname, input, param, delay, null, null)
			}
		}
	}

	function FireInputOnKill(player, items, value) {


		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local args = split(value, "^")
			local targetname = args[0]
			local input = args[1]
			local param = ""
			local delay = -1
			if (args.len() > 2) param = args[2]
			if (args.len() > 3) delay = args[3].tofloat()

			CustomAttributes.DeathHookTable[format("FireInputOnKill_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (GetPlayerFromUserID(params.attacker) != player || params.weapon != wep) return

				targetname = "!self" ? EntFireByHandle(GetPlayerFromUserID(params.attacker), input, param, delay, null, null) : DoEntFire(targetname, input, param, delay, null, null)
			}
		}
	}

	function MultDmgVsSameClass(player, items, value) {

		// CustomAttributes.TakeDamageTable.clear()

		// CustomAttributes.TakeDamageTable = cleanup

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("DmgVsSameClass_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <-  function(params) {
				local victim = params.const_entity
				local attacker = params.attacker

				local scope = attacker.GetScriptScope()
				if (
					!attacker.IsPlayer() || !victim.IsPlayer() ||
					!("mult dmg vs same class" in player.GetScriptScope().attribinfo) ||
					attacker.GetPlayerClass() != victim.GetPlayerClass() ||
					player.GetActiveWeapon() != wep
				) return

				params.damage *= value
			}
		}
	}

	function MultDmgVsAirborne(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("MultDmgVsAirborne_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity
				if (victim != null && victim.IsPlayer() && GetPropEntity(victim, "m_hGroundEntity") == null)
					params.damage *= value
			}
		}
	}

	function TeleportInsteadOfDie(player, items, value) {


		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("TeleportInsteadOfDie_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (RandomFloat(0, 1) > value.tofloat()) return

				local player = params.const_entity
				local scope = player.GetScriptScope()

				if (!("attribinfo" in scope)) return

				if (
					!player.IsPlayer() || player.GetHealth() > params.damage ||
					!("teleport instead of die" in scope.attribinfo) ||
					player.IsInvulnerable() || PopExtUtil.IsPointInRespawnRoom(player.EyePosition())
				) return

				local health = player.GetHealth()
				params.early_out = true

				player.ForceRespawn()
				EntFireByHandle(player, "RunScriptCode","self.SetHealth(1)", -1, null, null)
			}
		}
	}

	function MeleeCleaveAttack(player, items, value = 64) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			scope.cleavenextattack <- 0.0
			scope.cleaved <- false

			scope.ItemThinkTable[format("MeleeCleaveAttack_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (scope.cleavenextattack == GetPropFloat(wep, "m_flNextPrimaryAttack") || GetPropFloat(wep, "m_fFireDuration") == 0.0 || player.GetActiveWeapon() != wep || !("melee cleave attack" in player.GetScriptScope().attribinfo)) return

				scope.cleaved = false

				scope.cleavenextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
			}
			CustomAttributes.TakeDamageTable[format("MeleeCleaveAttack_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (scope.cleaved || params.weapon != wep || !("melee cleave attack" in player.GetScriptScope().attribinfo)) return

				scope.cleaved = true
				// params.early_out = true

				local swingpos = player.EyePosition() + (player.EyeAngles().Forward() * 30) - Vector(0, 0, value)

				for (local p; p = FindByClassnameWithin(p, "player", swingpos, value);)
					if (p.GetTeam() != player.GetTeam() && p.GetTeam() != TEAM_SPECTATOR && p != params.const_entity)
						p.TakeDamageCustom(params.inflictor, params.attacker, params.weapon, params.damage_force, params.damage_position, params.damage, params.damage_type, params.damage_custom)
			}
		}
	}

	function TeleporterRechargeTime(player, items, value = 1.0) {

		//not finished
		return
		ClientPrint(player, HUD_PRINTTALK, "DONT USE ME! Teleporter recharge time is not finished!")
		local scope = wep.GetScriptScope()
		scope.teleporterrechargetimemult <- value

		// CustomAttributes.PlayerTeleportTable[format("TeleporterRechargeTime_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {
		//     local teleportedplayer = GetPlayerFromUserID(params.userid)

		//     local teleporter = FindByClassnameNearest("obj_teleporter", teleportedplayer.GetOrigin(), 16)

		//     local chargetime = GetPropFloat(teleporter, "m_flCurrentRechargeDuration")
		// }

		scope.ItemThinkTable[format("TeleporterRechargeTime_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

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
				return
			}
			AddThinkToEnt(teleporter, "TeleportMultThink")
		}
	}

	function UberOnDamageTaken(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("UberOnDamageTaken_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local damagedplayer = params.const_entity

				if (
					damagedplayer != player || RandomInt(0, 1) > value ||
					!("uber on damage taken" in player.GetScriptScope().attribinfo) ||
					damagedplayer.IsInvulnerable() || player.GetActiveWeapon() != wep
				) return

				damagedplayer.AddCondEx(COND_UBERCHARGE, 3.0, player)
				params.early_out = true
			}
		}
	}

	function SetTurnToIce(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			//cleanup before spawning a new one
			for (local knife; knife = FindByClassname(knife, "tf_weapon_knife");)
				if (PopExtUtil.GetItemIndex(knife) == ID_SPY_CICLE && knife.IsEFlagSet(EFL_USER))
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

			CustomAttributes.TakeDamageTable[format("TurnToIce_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

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
	}

	function ModTeleporterSpeedBoost(player, items, value) { //dummy third value to avoid wrong number of parameters errors


		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue
			local scope = wep.GetScriptScope()
			CustomAttributes.PlayerTeleportTable[format("ModTeleporterSpeedBoost_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (!("mod teleporter speed boost" in player.GetScriptScope().attribinfo) || params.builderid != player.GetScriptScope().userid) return

				local teleportedplayer = GetPlayerFromUserID(params.userid)
				teleportedplayer.AddCondEx(TF_COND_SPEED_BOOST, value, player)
			}
		}
	}

	function CanBreatheUnderWater(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		local painfinished = GetPropInt(player, "m_PainFinished")

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()
			scope.ItemThinkTable[format("CanBreatheUnderwater_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("can breathe underwater" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				if (player.GetWaterLevel() == 3)
				{
					SetPropFloat(player, "m_PainFinished", FLT_MAX)
					return
				}
				SetPropFloat(player, "m_PainFinished", 0.0)
			}
		}
	}
	function MultSwimSpeed(player, items, value = 1.25) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			//local speedmult = 1.254901961
			local maxspeed = GetPropFloat(player, "m_flMaxspeed")

			local scope = wep.GetScriptScope()
			scope.ItemThinkTable[format("MultSwimSpeed_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("mult swim speed" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				if (player.GetWaterLevel() == 3)
				{
					SetPropFloat(player, "m_flMaxspeed", maxspeed * value)
					return
				}
				SetPropFloat(player, "m_flMaxspeed", maxspeed)
			}
		}
	}

	function LastShotCrits(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local duration = 0.033
			if ("duration" in value) duration = value.duration

			local scope = wep.GetScriptScope()
			// scope.lastshotcritsnextattack <- 0.0

			scope.ItemThinkTable[format("LastShotCrits_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!wep || !("last shot crits" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				// if (scope.lastshotcritsnextattack == GetPropFloat(wep, "m_flNextPrimaryAttack")) return

				// scope.lastshotcritsnextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")

				if (wep.IsValid() && wep.Clip1() == 1)
					player.AddCondEx(COND_CRITBOOST, duration, null)

				return
			}
		}
	}

	function CritWhenHealthBelow(player, items, value = -1) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("CritWhenHealthBelow_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetHealth() < value && player.GetActiveWeapon() == wep)
				{
					player.AddCondEx(COND_CRITBOOST, 0.033, player)
					return
				}
			}
		}
	}

	function WetImmunity(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local wetconds = [TF_COND_MAD_MILK, TF_COND_URINE, TF_COND_GAS]

			wep.GetScriptScope().ItemThinkTable[format("WetImmunity_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				foreach (cond in wetconds)
					player.RemoveCondEx(cond, true)
			}
		}
	}

	function BuildSmallSentries(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = player.GetScriptScope()
			scope.previousBuiltSentry <- null

			CustomAttributes.BuiltObjectTable[format("BuildSmallSentries_%d_%d", scope.userid, wep.entindex())] <- function(params) {

				local builder = GetPlayerFromUserID(params.userid)

				if (builder != player || params.object != OBJ_SENTRYGUN) return

				local sentry = EntIndexToHScript(params.index)

				if (sentry == scope.previousBuiltSentry) {
					SetPropInt(sentry, "m_iUpgradeMetalRequired", 150)
					return
				}

				scope.previousBuiltSentry = sentry
				EntFireByHandle(sentry, "RunScriptCode", @"
					local maxhealth = self.GetMaxHealth() * 0.66
					self.SetMaxHealth(maxhealth)
					if (self.GetHealth() > self.GetMaxHealth())
					self.SetHealth(maxhealth)

					self.SetModelScale(0.8, -1)

					SetPropInt(self, `m_iUpgradeMetalRequired`, 150)
				", SINGLE_TICK, null, null);
			}

			CustomAttributes.UpgradedObjectTable[format("BuildSmallSentries_%d_%d", scope.userid, wep.entindex())] <- function(params) {

				local upgrader = GetPlayerFromUserID(params.userid)

				if (upgrader != player || params.object != OBJ_SENTRYGUN) return

				local sentry = EntIndexToHScript(params.index)

				EntFireByHandle(sentry, "RunScriptCode", @"
					local maxhealth = self.GetMaxHealth() * 0.66
					self.SetMaxHealth(maxhealth)
					if (self.GetHealth() > self.GetMaxHealth())
					self.SetHealth(maxhealth)

					SetPropInt(self, `m_iUpgradeMetalRequired`, 150)
				", SINGLE_TICK, null, null);
			}

			CustomAttributes.QuickSentryUpgradeTable[format("BuildSmallSentries_%d_%d", scope.userid, wep.entindex())] <- function(params) {

				for (local sentry; sentry = FindByClassname(sentry, "obj_sentrygun");) {
					if (GetPropEntity(sentry, "m_hBuilder") == player) {
						EntFireByHandle(sentry, "RunScriptCode", @"
							local maxhealth = self.GetMaxHealth() * 0.66
							self.SetMaxHealth(maxhealth)
							if (self.GetHealth() > self.GetMaxHealth())
							self.SetHealth(maxhealth)
						", SINGLE_TICK, null, null);
					}
				}
			}
		}
	}

	function RadiusSleeper(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		CustomAttributes.TakeDamagePostTable[format("RadiusSleeper_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

			local victim = GetPlayerFromUserID(params.userid)
			local attacker = GetPlayerFromUserID(params.attacker)

			if (attacker == null) return

			local scope = attacker.GetScriptScope()

			if (!("radius sleeper" in player.GetScriptScope().attribinfo)) return

			if (victim == null || attacker == null || attacker != player || GetPropFloat(attacker.GetActiveWeapon(), "m_flChargedDamage") < 150.0) return

			SpawnEntityFromTable("tf_projectile_jar", {origin = victim.EyePosition()})
		}
	}

	function ExplosiveBullets(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue
			local scope = wep.GetScriptScope()
			//cleanup before spawning a new one
			for (local launcher; launcher = FindByClassname(launcher, "tf_weapon_grenadelauncher");)
				if (launcher.IsEFlagSet(EFL_USER))
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

			scope.ItemThinkTable[format("ExplosiveBullets_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("explosive bullets" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep || scope.explosivebulletsnextattack == GetPropFloat(wep, "m_flLastFireTime")) return

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
	}

	function OldSandmanStun(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			CustomAttributes.TakeDamageTable[format("OldSandmanStun_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {
				local attacker = params.attacker
				local victim = params.const_entity

				if (params.damage_stats == TF_DMG_CUSTOM_BASEBALL && params.weapon == wep)
					PopExtUtil.StunPlayer(victim, 5, TF_STUN_CONTROLS)
			}
		}
	}

	function StunOnHit(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			local duration = 5, type = 2, speedmult = 0.2, stungiants = true

			if ("duration" in value) duration = value.duration
			if ("type" in value) type = value.type
			if ("speedmult" in value) speedmult = value.speedmult
			if ("stungiants" in value) stungiants = value.stungiants

			// `stun on hit`: { duration = 4 type = 2 speedmult = 0.2 stungiants = false } //in order: stun duration in seconds, stun type, stun movespeed multiplier, can stun giants true/false

			CustomAttributes.TakeDamageTable[format("StunOnHit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (!params.const_entity.IsPlayer() || params.weapon != wep || (!stungiants && params.const_entity.IsMiniBoss())) return

				PopExtUtil.StunPlayer(params.const_entity, duration, type, 0, speedmult)
			}
		}
	}

	function IsMiniboss(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local i = 1

			wep.GetScriptScope().ItemThinkTable[format("IsMiniBoss_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() == wep && !player.IsMiniBoss() && player.GetModelScale() == 1.0) {

					player.SetIsMiniBoss(true)
					player.SetModelScale(1.75, -1)
				}

				if (!i)
				{
					player.SetIsMiniBoss(false)
					player.SetModelScale(1.0, -1)
				}

				i++
				if (i > 10) i = 0
			}
		}
	}

	function ReplaceWeaponFireSound(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			PrecacheSound(value[1])
			PrecacheScriptSound(value[1])

			local scope = wep.GetScriptScope()
			scope.attacksound <- 0.0

			scope.ItemThinkTable[format("ReplaceFireSound_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				StopSoundOn(value[0], player)
				player.StopSound(value[0])

				if (!("attacksound" in scope) || GetPropFloat(wep, "m_flLastFireTime") == scope.attacksound) return

				EmitSoundEx({sound_name = value[1], entity = self})
				// EntFireByHandle(player, "RunScriptCode", "EmitSoundEx({sound_name = "+value[1]+", entity = self})", -1, null, null)

				scope.attacksound = GetPropFloat(wep, "m_flLastFireTime")
			}
		}

	}

	function IsInvisible(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("IsInvisible_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep || PopExtUtil.HasEffect(EF_NODRAW)) return

				wep.DisableDraw()
			}
		}
	}
	function CannotUpgrade(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		// EntFire("func_upgradestation", "RunScriptCode", "SetPropString(self, `m_iFilterName`, `__upgradefilter`)")

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local index = PopExtUtil.GetItemIndex(wep)
			local classname = GetPropString(wep, "m_iClassname")

			wep.GetScriptScope().ItemThinkTable[format("CannotUpgrade_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

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
	}

	function AlwaysCrit(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("AlwaysCrit_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() == wep)
					player.AddCondEx(COND_CRITBOOST, 0.033, player)
			}
		}
	}

	function AddCondWhenActive(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("AddCondWhenActive_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() == wep)
					player.AddCondEx(value, 0.033, player)
			}
		}
	}


	function DontCountDamageTowardsCritRate(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("DmgNoCritRate_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.weapon != wep) return
				params.damage_type = params.damage_type | DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE
			}
		}
	}

	function NoDamageFalloff(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("NoDamageFalloff_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.weapon != wep) return
				params.damage_type = params.damage_type &~ DMG_USEDISTANCEMOD
			}
		}
	}

	function CanHeadshot(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("CanHeadshot_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity
				if (params.weapon != wep || !victim.IsPlayer() || GetPropInt(victim, "m_LastHitGroup") != HITGROUP_HEAD) return

				params.damage_type = params.damage_type | DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_HEADSHOT
			}
		}
	}
	function CannotHeadshot(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("CannotHeadshot_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.weapon != wep || params.damage_stats != TF_DMG_CUSTOM_HEADSHOT) return

				params.damage_type = params.damage_type &~ DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_NONE
			}
		}
	}

	function CannotBeHeadshot(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("CannotBeHeadshot_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local scope = params.const_entity.GetScriptScope()

				if (!params.const_entity.IsPlayer() || !("cannot be headshot" in player.GetScriptScope().attribinfo)) return

				params.damage_type = params.damage_type &~ DMG_CRITICAL
				params.damage_stats = TF_DMG_CUSTOM_NONE
			}
		}
	}

	function ProjectileLifetime(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("ProjectileLifeTime_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");) {
					if (projectile.GetOwner() == player || (HasProp(projectile, "m_hThrower") && GetPropEntity(projectile, "m_hThrower") == player && GetPropEntity(projectile, "m_hLauncher") == wep))
						EntFireByHandle(projectile, "Kill", "", value, null, null)
				}
			}
		}
	}

	function MultDmgVsGiants(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("MultDmgVsGiants_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity, attacker = params.attacker

				if (victim.IsPlayer() && victim.IsMiniBoss() && params.weapon == wep) params.damage *= value
			}
		}
	}

	function MultDmgVsTanks(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("MultDmgVsTanks_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				local victim = params.const_entity, attacker = params.attacker

				if (victim.GetClassname() == "tank_boss" && params.weapon == wep) params.damage *= value
			}
		}
	}

	function SetDamageType(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("SetDamageType_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.weapon == wep) params.damage_type = value
			}
		}
	}

	function SetDamageTypeCustom(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("SetDamageType_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.weapon == wep) params.damage_stats = value
			}
		}
	}

	function PassiveReload(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			scope.ItemThinkTable[format("PassiveReload_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				//weapon ent has been destroyed, reference is still valid but the entity isn't
				if (wep && !wep.IsValid())
				{
					delete scope.ItemThinkTable[format("PassiveReload_%d_%d", player.GetScriptScope().userid,  wep.entindex())]
					return
				}

				if (player.GetActiveWeapon() == wep) return

				local ammo = GetPropIntArray(player, "m_iAmmo", wep.GetSlot() + 1)

				if (player.GetActiveWeapon() != wep && wep.Clip1() != wep.GetMaxClip1())
				{
					if (!("ReverseMVMDrainAmmoThink" in scope.ItemThinkTable)) //already takes care of this
						SetPropIntArray(player, "m_iAmmo", ammo - (wep.GetMaxClip1() - wep.Clip1()), wep.GetSlot() + 1)

					wep.SetClip1(wep.GetMaxClip1())
				}
			}
		}
	}

	function CollectCurrencyOnKill(player, items, value) {
		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.ValidateScriptScope()
			local scope = wep.GetScriptScope()
			scope.collectCurrencyOnKill <- true
		}
	}

	function RocketPenetration(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			if (ROCKET_LAUNCHER_CLASSNAMES.find(wep.GetClassname()) == null)
				return


			local scope = wep.GetScriptScope()

			CustomAttributes.TakeDamageTable[format("RocketPenetration_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {
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
				return
			}
			weaponScriptScope.FindRocket <- function(owner) {
				local entity = null
				for (local entity; entity = FindByClassnameWithin(entity, "tf_projectile_*", owner.GetOrigin(), 100);) {
					if (entity.GetOwner() != owner) {
						continue
					}

					entity.ValidateScriptScope()
					if ("chosenAsPenetrationRocket" in entity.GetScriptScope())
						continue

					entity.GetScriptScope().chosenAsPenetrationRocket <- true

					return entity
				}

				return null
			}
			weaponScriptScope.ApplyPenetrationToRocket <- function(owner, rocket) {
				rocket.SetSolid(SOLID_NONE)

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
				if (!("ProjectileThinkTable" in rocketScope)) rocketScope.ProjectileThinkTable <- {}

				rocketScope.ProjectileThinkTable.RocketThink <- function() {

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
						return

					if (!traceTable.enthit)
						return

					if (traceTable.enthit.GetTeam() == player.GetTeam())
						return

					if (collidedTargets.find(traceTable.enthit) != null)
						return

					collidedTargets.append(traceTable.enthit)
					penetrationCount++

					// arrow free penetration through allies without detonating
					if (traceTable.enthit.GetTeam() != player.GetTeam())
						penetrationCount++

					if (penetrationCount > (maxPenetration + 1))
					{
						self.SetSolid(SOLID_BBOX)
						if ("RocketThink" in rocketScope.ProjectileThinkTable) delete rocketScope.ProjectileThinkTable.RocketThink
						return
					}

					if (traceTable.enthit.GetTeam() != player.GetTeam())
						DetonateRocket()

					return
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

			PopExtUtil.AddThinkToEnt(wep, "CheckWeaponFire")
		}
	}

	function ReloadsFullClipAtOnce(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()
			scope.lastClip <- wep.Clip1() // thanks to seelpit for detectreload logic

			scope.ItemThinkTable[format("ReloadFullClipAtOnce_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				local currentClip = wep.Clip1()
				local wepSlot = wep.GetSlot() + 1

				if (currentClip > lastClip) {
					wep.SetClip1(wep.GetMaxClip1())
					local ammoDeducted = (wep.GetMaxClip1() - currentClip)
					local currentAmmo = GetPropIntArray(player, "m_iAmmo", wepSlot)
					SetPropIntArray(player, "m_iAmmo", currentAmmo - ammoDeducted, wepSlot)
					currentClip = wep.Clip1()
				}
				lastClip = currentClip
			}
		}
	}

	function MultProjectileScale(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			scope.ItemThinkTable[format("MultProjectileScale_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("mult projectile scale" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
					if (projectile.GetOwner() == player && projectile.GetModelScale() != value)
						projectile.SetModelScale(value, 0.0)
			}
		}
	}

	function MultBuildingScale(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			if (!("BuiltObjectTable") in scope) return

			scope.BuiltObjectTable.MultBuildingScale <- function(params) {

				local building = EntIndexToHScript(params.index)
				if (GetPropEntity(building, "m_hBuilder") == player && "mult building scale" in player.GetScriptScope().attribinfo)
					building.SetModelScale(value, 0.0)

			}
		}
	}

	function MultCritDmg(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("MultCritDmg_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (params.damage_type & DMG_CRITICAL) params.damage *= value
			}
		}
	}

	function ArrowIgnite(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("ArrowIgnite_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				if (HasProp(wep, "m_bArrowAlight") && !GetPropBool(wep, "m_bArrowAlight"))
					SetPropBool(wep, "m_bArrowAlight", true)
			}
		}
	}

	//REIMPLEMENTED VANILLA ATTRIBUTES

	function AltFireDisabled(player, items, value = null) { //dummy third value to avoid wrong number of parameters errors

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			scope.ItemThinkTable[format("AltFireDisabled_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if ("alt-fire disabled" in player.GetScriptScope().attribinfo && player.GetActiveWeapon() == wep)
				{
					SetPropInt(player, "m_afButtonDisabled", IN_ATTACK2)
					SetPropFloat(wep, "m_flNextSecondaryAttack", INT_MAX)
					return
				}
				SetPropInt(player, "m_afButtonDisabled", 0)
			}
			CustomAttributes.SpawnHookTable[format("AltFireDisabled_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {
				SetPropInt(GetPlayerFromUserID(params.userid), "m_afButtonDisabled", 0)
			}
		}
	}

	function CustomProjectileModel(player, items, value) {

		local projmodel = PrecacheModel(value)
		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			local scope = wep.GetScriptScope()

			scope.ItemThinkTable[format("CustomProjectileModel_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("custom projectile model" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
					if (projectile.GetOwner() == player && GetPropInt(projectile, "m_nModelIndex") != projmodel)
						projectile.SetModel(value)
			}
		}
	}

	function NoclipProjectile(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue
			local scope = wep.GetScriptScope()
			scope.ItemThinkTable[format("NoclipProjectile_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (!("noclip projectile" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
					if (projectile.GetOwner() == player && projectile.GetMoveType != MOVETYPE_NOCLIP)
						projectile.SetMoveType(MOVETYPE_NOCLIP, MOVECOLLIDE_DEFAULT)
			}
		}
	}

	function ProjectileGravity(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue
			local scope = wep.GetScriptScope()
			scope.ItemThinkTable[format("ProjectileGravity_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {
				if (!("projectile gravity" in player.GetScriptScope().attribinfo) || player.GetActiveWeapon() != wep) return

				for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");)
					if (projectile.GetOwner() == player)
					{
						local currentVelocity = projectile.GetAbsVelocity()
						currentVelocity -= Vector(0, 0, value)

						projectile.SetAbsVelocity(currentVelocity)

						local faceDirection = projectile.GetForwardVector()
						self.SetLocalAngles(PopExtUtil.VectorAngles(faceDirection))
					}

			}
		}
	}

	function ImmuneToCond(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.GetScriptScope().ItemThinkTable[format("ImmuneToCond_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function() {

				if (player.GetActiveWeapon() != wep) return

				if (typeof value == "array") {
					foreach (cond in value) {
						player.RemoveCondEx(cond, true)
					}
					return
				}
				player.RemoveCondEx(value, true)
			}
		}
	}

	function MultMaxHealth(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			wep.RemoveAttribute("SET BONUS: max health additive bonus")
			local addHPAmount = player.GetMaxHealth() * (value - 1)
			wep.AddAttribute("SET BONUS: max health additive bonus", addHPAmount, -1)
		}
	}

	function DmgBonusWhileHalfDead(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("ShahanshahAttributeBelowHP_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (!("dmg bonus while half dead" in player.GetScriptScope().attribinfo) || params.weapon != wep || player.GetActiveWeapon() != wep) return

				if (player.GetHealth() < player.GetMaxHealth() / 2)
					params.damage *= value
			}
		}
	}

	function DmgBonusWhileHalfAlive(player, items, value) {

		foreach(item, attrs in items)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)
			if (wep == null) continue

			CustomAttributes.TakeDamageTable[format("ShahanshahAttributeAboveHP_%d_%d", player.GetScriptScope().userid,  wep.entindex())] <- function(params) {

				if (!("dmg penalty while half alive" in player.GetScriptScope().attribinfo) || params.weapon != wep || player.GetActiveWeapon() != wep) return

				if (player.GetHealth() > player.GetMaxHealth() / 2)
					params.damage *= value
			}
		}
	}

	function AddAttr(player, attr, value = 0, item = null) {

		local item_table = {}

		// no item, just apply to the active weapon
		if (item == null) item = player.GetActiveWeapon()

		//entity handle passed
		if (typeof item == "instance")
			item_table[item] <- [attr, value]


		//table of entity handles passed
		else if (typeof item == "table")
			item_table = item

		//array of entity handles passed
		else if (typeof item == "array")
		{
			local temp = {}

			foreach (item in item_table) temp[item] <- [attr, value]

			item_table = temp
		}

		//easy access table in player scope for our items and their attributes
		player.GetScriptScope().CustomAttrItems <- item_table

		//cleanup any previous attribute functions from these CustomAttributes event hooks
		local t = ["TakeDamageTable", "TakeDamagePostTable", "SpawnHookTable", "DeathHookTable", "PlayerTeleportTable"]
		foreach (tablename in t)
			foreach(table, func in CustomAttributes[tablename])
				//remove the attribute for the player from the global CustomAttributes event table
				if (tablename in CustomAttributes) CustomAttributes.CleanupFunctionTable(player, table, attr)

		//cleanup item thinks
		foreach(item, _ in item_table)
			CustomAttributes.CleanupFunctionTable(item, "ItemThinkTable", attr)

		local scope = player.GetScriptScope()
		if (!("attribinfo" in scope)) scope.attribinfo <- {}

		foreach(item, attrs in item_table)
		{
			local wep = PopExtUtil.HasItemInLoadout(player, item)

			if (wep == null || !(attr in CustomAttributes.Attrs)) return

			CustomAttributes.Attrs[attr](player, item_table, attr, value)

			// printl(CustomAttributes.Attrs[attr])

			CustomAttributes.RefreshDescs(player)
		}
	}
	function RefreshDescs(player)
	{
		local cooldowntime = 3.0

		local scope = player.GetScriptScope()
		local formattedtable = []

		// local formatted = ""

		foreach (desc, attr in scope.attribinfo)
		{
			if (!formattedtable.find(attr))
				formattedtable.append(format("%s:\n\n%s\n\n\n", desc, attr))
		}

		local i = 0
		scope.PlayerThinkTable.ShowAttribInfo <- function() {

			if (!formattedtable.len() || !player.IsInspecting() || Time() < cooldowntime) return

			if (i+1 < formattedtable.len())
				PopExtUtil.ShowHudHint(format("%s%s", formattedtable[i], formattedtable[i+1]), player, 3.0 - SINGLE_TICK)
			else
				PopExtUtil.ShowHudHint(formattedtable[i], player, 3.0 - SINGLE_TICK)

			i += 2
			if (i >= formattedtable.len()) i = 0
			cooldowntime = Time() + 3.0
		}
	}
	function GetAttributeFunctionFromStringName(attr) {

		local str = ""
		split(attr, " ").apply(function(s) {
		    str += format("%s%s", s.slice(0, 1).toupper(), s.slice(1, s.len()))
		})
		return str
	}
	function CleanupFunctionTable(handle, table, attr) {

		local str = this.GetAttributeFunctionFromStringName(attr)

		if (attr == "alt-fire disabled") str = "AltFireDisabled"

		// foreach(name, v in table) if (typeof v == "function") printl(name + " : " + format("%s_%d", str, player.GetScriptScope().userid) +  " : " + startswith(name, format("%s_%d", str, player.GetScriptScope().userid)))
		foreach(name, v in table)
			if (typeof v == "function" && startswith(name, format("%s_%d", str, handle.GetScriptScope().userid)))
				delete table[format("%s", name)]
	}
    Events = {

		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in CustomAttributes.TakeDamageTable) func(params); }
		function OnGameEvent_player_hurt(params) { foreach (_, func in CustomAttributes.TakeDamagePostTable) func(params) }
		function OnGameEvent_player_death(params) { foreach (_, func in CustomAttributes.DeathHookTable) func(params) }
		function OnGameEvent_player_teleported(params) { foreach (_, func in CustomAttributes.PlayerTeleportTable) func(params) }
		function OnGameEvent_player_builtobject(params){ foreach (_, func in CustomAttributes.BuiltObjectTable) func(params) }
		function OnGameEvent_player_upgradedobject(params){ foreach (_, func in CustomAttributes.UpgradedObjectTable) func(params) }
		function OnGameEvent_mvm_quick_sentry_upgrade(params){ foreach (_, func in CustomAttributes.QuickSentryUpgradeTable) func(params) }
	}
}
__CollectGameEventCallbacks(CustomAttributes.Events)
