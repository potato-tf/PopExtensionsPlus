//behavior tags
IncludeScript("popextensions/botbehavior", getroottable())

try IncludeScript(format("%s_tags.nut", split(split(__popname, "/")[2], ".")[0]), getroottable()) catch(e) ::__tagarray <- []

PopExtUtil.PlayerManager.ValidateScriptScope()

local popext_funcs = {

	popext_addcond = function(bot, args) {
		if (args.len() == 1) {
			if (args[0].tointeger() == TF_COND_REPROGRAMMED) {
				bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, true)
				// PopExtTags.DeathHookTable.MoveToSpec <- function (params) {
				// 	if (!IsPlayerABot(bot)) return
				// 	EntFirebyHandle(bot, "RunScriptCode", "self.ForceChangeTeam(TEAM_SPECTATOR, true)", 3, null, null)
				// }

			}
			else
				bot.AddCond(args[0].tointeger())
		}

		else if (args.len() >= 2)
			bot.AddCondEx(args[0].tointeger(), args[1].tointeger(), null)
	}

	popext_reprogrammed = function(bot, args) {

		// EntFireByHandle(bot, "RunScriptCode", "self.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, true)", -1, null, null)
		bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, false)
		bot.AddCustomAttribute("ammo regen", 999.0, -1)
	}

	// popext_reprogrammed_neutral = function(bot, args) {
		// bot.ForceChangeTeam(TEAM_UNASSIGNED, true)
	// }

	popext_altfire = function(bot, args) {

		if (args.len() == 1)
			bot.PressAltFireButton(INT_MAX)
		else if (args.len() >= 2)
			bot.PressAltFireButton(args[1].tointeger())
	}

	popext_deathsound = function(bot, args) {

		PopExtTags.DeathHookTable.DeathSound <- function(params) {

			local victim = GetPlayerFromUserID(params.userid)

			if (victim != bot) return

			EmitSoundEx({sound_name = args[0], entity = victim})
		}
	}

	popext_stepsound = function(bot, args) {

		scope.stepside <- GetPropInt(bot, "m_Local.m_nStepside")

		bot.GetScriptScope().PlayerThinkTable.Stepsound <- function() {

			if (GetPropInt(bot, "m_Local.m_nStepside") != stepside)
				EmitSoundEx({sound_name = args[0], entity = bot})

			scope.stepside = GetPropInt(bot, "m_Local.m_nStepside")
		}
	}

	popext_usehumanmodel = function(bot, args) {

		local class_string = PopExtUtil.Classes[bot.GetPlayerClass()]
		bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", class_string))
		EntFireByHandle(bot, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", class_string), -1, null, null)
	}

	popext_usecustommodel = function(bot, args) {

		if (!IsModelPrecached(args[0])) PrecacheModel(args[0])
		EntFireByHandle(bot, "SetCustomModelWithClassAnimations", args[0], -1, null, null)
	}

	popext_usehumananims = function(bot, args) {

		local class_string = PopExtUtil.Classes[bot.GetPlayerClass()]
		EntFireByHandle(bot, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", class_string), SINGLE_TICK, null, null)
		EntFireByHandle(bot, "RunScriptCode", format("PopExtUtil.PlayerRobotModel(self, `models/bots/%s/bot_%s.mdl`)", class_string, class_string), SINGLE_TICK, null, null)
	}

	popext_alwaysglow = function(bot, args) {

		SetPropBool(bot, "m_bGlowEnabled", true)
	}

	popext_stripslot = function(bot, args) {

		if (args.len() == 1) args.append(-1)
		local slot = args[1].tointeger()

		if (slot == -1) slot = bot.GetActiveWeapon().GetSlot()
		PopExtUtil.GetItemInSlot(bot, slot).Kill()
	}

	popext_fireweapon = function(bot, args) {

		local args_len = args.len()
		local button = args[0].tointeger()
		local cooldown = (args_len > 1) ? args[1].tointeger() : 3
		local duration = (args_len > 2) ? args[2].tointeger() : 1.0
		local delay = (args_len > 3) ? args[3].tointeger() : 0
		local repeats = (args_len > 4) ? args[4].tointeger() : INT_MAX
		local ifhealthbelow = (args_len > 5) ? args[5].tointeger() : INT_MAX
		local ifseetarget = (args_len > 6) ? args[6].tointeger() : 1

		local maxrepeats = 0
		local cooldowntime = Time() + cooldown
		local delaytime = Time() + delay

		bot.GetScriptScope().PlayerThinkTable.FireWeaponThink <- function()
		{
			if ((maxrepeats) >= repeats)
			{
				delete bot.GetScriptScope().PlayerThinkTable.FireWeaponThink
				return
			}

			if (Time() < delaytime || (Time() < cooldowntime) || bot.GetHealth() > ifhealthbelow || bot.HasBotAttribute(SUPPRESS_FIRE)) return

			maxrepeats++

			PopExtUtil.PressButton(bot, button)
			EntFireByHandle(bot, "RunScriptCode", format("PopExtUtil.ReleaseButton(self, %d)", button), duration, null, null)
			cooldowntime = Time() + cooldown
		}
	}

	popext_weaponswitch = function(bot, args) {

		local args_len = args.len()
		local slot = args[0].tointeger()
		local cooldown = (args_len > 1) ? args[1].tointeger() : 3
		local duration = (args_len > 2) ? args[2].tointeger() : 5
		local delay = (args_len > 3) ? args[3].tointeger() : 3
		local repeats = (args_len > 4) ? args[4].tointeger() : INT_MAX
		local ifhealthbelow = (args_len > 5) ? args[5].tointeger() : INT_MAX
		local ifseetarget = (args_len > 6) ? args[6].tointeger() : 1

		local maxrepeats = 0
		local cooldowntime = Time() + cooldown
		local delaytime = Time() + delay

		bot.GetScriptScope().PlayerThinkTable.WeaponSwitchThink <- function()
		{
			if ((maxrepeats) >= repeats)
			{
				delete bot.GetScriptScope().PlayerThinkTable.WeaponSwitchThink
				return
			}

			if (Time() < delaytime || (Time() < cooldowntime) || bot.GetHealth() > ifhealthbelow) return

			maxrepeats++

			bot.Weapon_Switch(PopExtUtil.GetItemInSlot(bot, slot))
			bot.AddCustomAttribute("disable weapon switch", 1, duration)
			EntFireByHandle(bot, "RunScriptCode","self.RemoveCustomAttribute(`disable weapon switch`)", duration, null, null)
			EntFireByHandle(bot, "RunScriptCode", format("self.Weapon_Switch(PopExtUtil.GetItemInSlot(self, %d))", slot), duration+SINGLE_TICK, null, null)
			cooldowntime = Time() + cooldown
		}
	}

	popext_spell = function(bot, args) {

		local args_len = args.len()
		local type = args[0].tointeger()
		local cooldown = args[1].tointeger()
		local delay = (args_len > 2) ? args[2].tointeger() : 3
		local repeats = (args_len > 3) ? args[3].tointeger() : INT_MAX
		local ifhealthbelow = (args_len > 4) ? args[4].tointeger() : INT_MAX
		local charges = (args_len > 5) ? args[5].tointeger() : 1
		local ifseetarget = (args_len > 6) ? args[6].tointeger() : 1

		local spellbook = PopExtUtil.GetItemInSlot(bot, SLOT_PDA)

		//equip a spellbook if the bot doesn't have one
		if (spellbook == null)
		{
			local book = CreateByClassname("tf_weapon_spellbook")
			SetPropInt(book, STRING_NETPROP_ITEMDEF, ID_BASIC_SPELLBOOK)
			SetPropBool(book, "m_AttributeManager.m_Item.m_bInitialized", true)
			SetPropBool(book, "m_bValidatedAttachedEntity", true)
			SetPropEntityArray(bot, "m_hMyWeapons", book, book.GetSlot())

			book.SetTeam(bot.GetTeam())
			DispatchSpawn(book)

			bot.Weapon_Equip(book)

			//try again next think
			return
		}

		local cooldowntime = Time() + cooldown
		local delaytime = Time() + delay

		local maxrepeats = 0

		bot.GetScriptScope().PlayerThinkTable.SpellThink <- function()
		{
			if ((maxrepeats) >= repeats)
			{
				delete bot.GetScriptScope().PlayerThinkTable.SpellThink
				return
			}

			if (Time() < delaytime || (Time() < cooldowntime) || bot.GetHealth() > ifhealthbelow) return

			maxrepeats++

			SetPropInt(spellbook, "m_iSelectedSpellIndex", type)
			SetPropInt(spellbook, "m_iSpellCharges", charges)
			try {

				bot.Weapon_Switch(spellbook)
				spellbook.AddAttribute("disable weapon switch", 1, 1) // duration doesn't work here?
				spellbook.ReapplyProvision()
			} catch(e) printl("can't find spellbook!")

			EntFireByHandle(spellbook, "RunScriptCode", "self.RemoveAttribute(`disable weapon switch`)", 1, null, null)
			EntFireByHandle(spellbook, "RunScriptCode", "self.ReapplyProvision()", 1, null, null)

			cooldowntime = Time() + cooldown
		}
	}

	popext_spawntemplate = function(bot, args) {
		SpawnTemplate(args[0], bot)
	}

	popext_forceromevision = function(bot, args) {

		//kill the existing romevision
		EntFireByHandle(bot, "RunScriptCode", @"
			local killrome = []

			if (self.IsBotOfType(TF_BOT_TYPE))
				for (local child = self.FirstMoveChild(); child != null; child = child.NextMovePeer())
					if (child.GetClassname() == `tf_wearable` && startswith(child.GetModelName(), `models/workshop/player/items/`+PopExtUtil.Classes[self.GetPlayerClass()]+`/tw`))
						killrome.append(child)

			for (local i = killrome.len() - 1; i >= 0; i--) killrome[i].Kill()

			local cosmetics = PopExtUtil.ROMEVISION_MODELS[self.GetPlayerClass()]

			if (self.GetModelName() == `models/bots/demo/bot_sentry_buster.mdl`)
			{
				PopExtUtil.CreatePlayerWearable(self, PopExtUtil.ROMEVISION_MODELS[self.GetPlayerClass()][2])
				return
			}
			foreach (cosmetic in cosmetics)
			{
				local wearable = PopExtUtil.CreatePlayerWearable(self, cosmetic)
				SetPropString(wearable, `m_iName`, `__bot_romevision_model`)
			}
		", -1, null, null)
	}

	popext_customattr = function(bot, args) {

		local args_len = args.len()
		if (args_len == 2)
			CustomAttributes.AddAttr(bot, args[0], args[1], bot.GetActiveWeapon())
		else if (args_len == 3)
			CustomAttributes.AddAttr(bot, args[0], args[1], args[2])
	}

	popext_ringoffire = function(bot, args) {

		local args_len = args.len()
		local damage = (args_len > 0) ? args[0].tofloat() : 7.5
		local interval = (args_len > 1) ? args[1].tofloat() : 0.5
		local radius = (args_len > 2) ? args[2].tofloat() : 135.0

		local cooldown = Time() + interval

		bot.GetScriptScope().PlayerThinkTable.RingOfFireThink <-  function() {

			if (Time() < cooldown) return

			local origin = bot.GetOrigin()
			local angles = bot.GetAngles()

			DispatchParticleEffect("heavy_ring_of_fire", origin, angles)

			for (local player; player = FindByClassnameWithin(player, "player", origin, radius);)
			{
				if (player.GetTeam() == bot.GetTeam() || !PopExtUtil.IsAlive(player)) continue

				player.TakeDamage(damage, DMG_BURN, bot)
				PopExtUtil.Ignite(player)
			}
			cooldown = Time() + interval
		}
	}
	popext_meleeai = function(bot, args) {

		local visionoverride = bot.GetMaxVisionRangeOverride() == -1 ? INT_MAX : bot.GetMaxVisionRangeOverride()

		bot.GetScriptScope().PlayerThinkTable.MeleeAIThink <- function() {

			local t = aibot.FindClosestThreat(visionoverride, false)

			if (t == null || t.IsFullyInvisible() || t.IsStealthed()) return

			if (aibot.threat != t)
			{
				// bot.AddBotAttribute(SUPPRESS_FIRE)
				aibot.SetThreat(t, false)
				aibot.LookAt(t.EyePosition(), 50, 50)
				bot.SetAttentionFocus(t)
			}
			// if (bot.hasbotattrEntFireByHandle(bot, "RunScriptCode", "self.RemoveBotAttribute(SUPPRESS_FIRE)", -1, null, null)
			// bot.RemoveBotAttribute(SUPPRESS_FIRE)

			if (!bot.HasBotTag("popext_mobber"))
				aibot.UpdatePathAndMove(t.GetOrigin())
		}
	}

	popext_mobber = function(bot, args) {

		bot.GetScriptScope().PlayerThinkTable.MobberThink <- function() {
			local threat = aibot.threat;
			if (threat != null && threat.IsValid() && PopExtUtil.IsAlive(threat)) return

			local threats = aibot.CollectThreats()

			local t = threats[RandomInt(0, threats.len() - 1)]

			// Move(t)
			aibot.UpdatePathAndMove(t.GetOrigin())
		}
	}

	popext_movetopoint = function(bot, args) {

		local pos = Vector()
		local point = args[0]

		if (FindByName(null, point) != null)
			pos = FindByName(null, point).GetOrigin()
		else
		{
			local buf = ""
			point.find(",") ?  buf = split(point, ",") : buf = split(point, " ")
			buf.apply(function(v) { return v.tofloat()})

			pos = Vector(buf[0], buf[1], buf[2])
		}

		bot.GetScriptScope().PlayerThinkTable.MoveToPoint <- function() {
			aibot.UpdatePathAndMove(pos)
		}
	}

	popext_fireinput = function(bot, args) {

		local args_len = args.len()

		if (args_len == 2)
			EntFire(args[0], args[1])

		else if (args_len == 3)
			EntFire(args[0], args[1], args[2])

		else if (args_len == 4)
			EntFire(args[0], args[1], args[2], args[3])

		else if (args_len == 5)
			EntFire(args[0], args[1], args[2], args[3], args[4])
	}

	popext_weaponresist = function(bot, args) {

		local weapon = args[0]
		local amount = args[1].tofloat()

		PopExtTags.TakeDamageTable.WeaponResistTakeDamage <- function(params)
		{
			local player = params.const_entity
			if (!player.IsPlayer() || params.attacker == null || params.weapon == null || !PopExtUtil.HasItemInLoadout(player, params.weapon)) return

			if (params.damage * amount < player.GetHealth()) params.damage *= amount
		}
	}

	popext_setskin = function(bot, args) {

		SetPropBool(bot, "m_bForcedSkin", true)
		SetPropInt(bot, "m_nForcedSkin", args[0].tointeger())

		PopExtTags.TakeDamageTable.ResetSkin <- function(params) {

			local victim = params.const_entity

			if (victim == bot && params.damage > victim.GetHealth()) {
				SetPropBool(bot, "m_bForcedSkin", true)
				SetPropInt(bot, "m_nForcedSkin", 1)
			}
		}
		PopExtTags.TeamSwitchTable.ResetSkin <- function(params) {

			local b = GetPlayerFromUserID(params.userid)

			if (b == bot && params.team == TEAM_SPECTATOR) {
				SetPropBool(bot, "m_bForcedSkin", true)
				SetPropInt(bot, "m_nForcedSkin", 1)
			}
		}
	}

	popext_doubledonk = function(bot, args) {

		bot.GetScriptScope().PlayerThinkTable.DoubleDonker <- function() {
			local distance = GetThreatDistanceSqr()
			printl("holdtime: " + (2 * exp(-distance / 10) + 0.5))
		}
	}

	popext_dispenseroverride = function(bot, args) {

		if (args.len() == 0) args.append(1) //sentry override by default

		local alwaysfire = bot.HasBotAttribute(ALWAYS_FIRE_WEAPON)

		//force deploy dispenser when leaving spawn and kill it immediately
		if (!alwaysfire && args[0].tointeger() == 1) bot.PressFireButton(INT_MAX)

		bot.GetScriptScope().PlayerThinkTable.DispenserBuildThink <- function() {

			//start forcing primary attack when near hint
			local hint = FindByClassnameWithin(null, "bot_hint*", bot.GetOrigin(), 16)
				if (hint && !alwaysfire) bot.PressFireButton(0.0)
		}

		bot.GetScriptScope().BuiltObjectTable.DispenserBuildOverride <- function(params) {

			local obj = params.object

			//dispenser built, stop force firing
			if (!alwaysfire) bot.PressFireButton(0.0)

			if ((args[0].tointeger() == 1 && obj == OBJ_SENTRYGUN) || (args[0].tointeger() == 2 && obj == OBJ_TELEPORTER)) {
				if (obj == OBJ_SENTRYGUN) bot.AddCustomAttribute("engy sentry radius increased", FLT_SMALL, -1)

				bot.AddCustomAttribute("upgrade rate decrease", 8, -1)
				local building = EntIndexToHScript(params.index)
				if (obj != OBJ_DISPENSER) {

					building.ValidateScriptScope()
					building.GetScriptScope().CheckBuiltThink <- function() {

						if (GetPropBool(building, "m_bBuilding")) return

						EntFireByHandle(building, "Disable", "", -1, null, null)
						delete building.GetScriptScope().CheckBuiltThink
					}
					AddThinkToEnt(building, "CheckBuiltThink")
				}

				//kill the first alwaysfire built dispenser when leaving spawn
				local hint = FindByClassnameWithin(null, "bot_hint*", building.GetOrigin(), 16)

				if (!hint) {
					building.Kill()
					return
				}

				//hide the building
				building.SetModelScale(0.01, 0.0)
				SetPropInt(building, "m_nRenderMode", kRenderTransColor)
				SetPropInt(building, "m_clrRender", 0)
				building.SetHealth(INT_MAX)
				building.SetSolid(SOLID_NONE)

				PopExtUtil.SetTargetname(building, format("building%d", building.entindex()))

				//create a dispenser
				local dispenser = CreateByClassname("obj_dispenser")

				SetPropEntity(dispenser, "m_hBuilder", bot)

				PopExtUtil.SetTargetname(dispenser, format("dispenser%d", dispenser.entindex()))

				dispenser.SetTeam(bot.GetTeam())
				dispenser.SetSkin(bot.GetSkin())

				dispenser.DispatchSpawn()

				//post-spawn stuff

				// SetPropInt(dispenser, "m_iHighestUpgradeLevel", 2) //doesn't work

				local builder = PopExtUtil.GetItemInSlot(bot, SLOT_PDA)

				local builtobj = GetPropEntity(builder, "m_hObjectBeingBuilt")
				SetPropInt(builder, "m_iObjectType", 0)
				SetPropInt(builder, "m_iBuildState", 2)
				// if (builtobj && builtobj.GetClassname() != "obj_dispenser") builtobj.Kill()
				SetPropEntity(builder, "m_hObjectBeingBuilt", dispenser) //makes dispenser a null reference

				bot.Weapon_Switch(builder)
				builder.PrimaryAttack()

				//m_hObjectBeingBuilt messes with our dispenser reference, do radius check to grab it again
				for (local d; d = FindByClassnameWithin(d, "obj_dispenser", building.GetOrigin(), 128);)
					if (GetPropEntity(d, "m_hBuilder") == bot)
						dispenser = d

				dispenser.SetLocalOrigin(building.GetLocalOrigin())
				dispenser.SetLocalAngles(building.GetLocalAngles())

				AddOutput(dispenser, "OnDestroyed", building.GetName(), "Kill", "", -1, -1) //kill it to avoid showing up in killfeed
				AddOutput(building, "OnDestroyed", dispenser.GetName(), "Destroy", "", -1, -1) //always destroy the dispenser
			}
		}
	}

	popext_giveweapon = function(bot, args) {

		local weapon = CreateByClassname(args[0])
		SetPropInt(weapon, STRING_NETPROP_ITEMDEF, args[1].tointeger())
		SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
		SetPropBool(weapon, "m_bValidatedAttachedEntity", true)
		weapon.SetTeam(bot.GetTeam())
		DispatchSpawn(weapon)

		PopExtUtil.GetItemInSlot(bot, weapon.GetSlot()).Destroy()

		bot.Weapon_Equip(weapon)

		return weapon
	}

	popext_meleewhenclose = function(bot, args) {

		local dist = args[0].tofloat()
		local previouswep = bot.GetActiveWeapon().entindex()

		bot.GetScriptScope().PlayerThinkTable.MeleeWhenClose <- function() {
			if (bot.IsEFlagSet(EFL_BOT)) return
			for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), dist);) {

				if (p.GetTeam() == bot.GetTeam()) continue
				local melee = PopExtUtil.GetItemInSlot(bot, SLOT_MELEE)

				bot.Weapon_Switch(melee)
				melee.AddAttribute("disable weapon switch", 1, 1)
				melee.ReapplyProvision()
				bot.AddEFlags(EFL_BOT)
				EntFireByHandle(melee, "RunScriptCode", "self.RemoveAttribute(`disable weapon switch`); self.ReapplyProvision(); self.GetOwner().RemoveEFlags(EFL_BOT)", 1.1, null, null)
			}
		}
	}

	popext_usebestweapon = function(bot, args) {

		bot.GetScriptScope().PlayerThinkTable.BestWeaponThink <- function() {

			switch(bot.GetPlayerClass()) {
			case 1: //TF_CLASS_SCOUT

				//scout and pyro's UseBestWeapon is inverted
				//switch them to secondaries, then back to primary when enemies are close

				if (bot.GetActiveWeapon() != PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))
					bot.Weapon_Switch(PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))

				for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
					if (p.GetTeam() == bot.GetTeam()) continue
					local primary = PopExtUtil.GetItemInSlot(bot, SLOT_PRIMARY)

					bot.Weapon_Switch(primary)
					primary.AddAttribute("disable weapon switch", 1, 1)
					primary.ReapplyProvision()
				}
			break

			case 2: //TF_CLASS_SNIPER
				for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 750);) {
					if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().GetSlot() == 2) continue //potentially not break sniper ai

					local secondary = PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY)

					bot.Weapon_Switch(secondary)
					secondary.AddAttribute("disable weapon switch", 1, 1)
					secondary.ReapplyProvision()
				}
			break

			case 3: //TF_CLASS_SOLDIER
				for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
					if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().Clip1() != 0) continue

					local secondary = PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY)

					bot.Weapon_Switch(secondary)
					secondary.AddAttribute("disable weapon switch", 1, 2)
					secondary.ReapplyProvision()
				}
			break

			case 7: //TF_CLASS_PYRO

				//scout and pyro's UseBestWeapon is inverted
				//switch them to secondaries, then back to primary when enemies are close
				//TODO: check if we're targetting a soldier with a simple raycaster, or wait for more bot functions to be exposed
				if (bot.GetActiveWeapon() != PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))
					bot.Weapon_Switch(PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))

				for (local p; p = FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
					if (p.GetTeam() == bot.GetTeam()) continue

					local primary = PopExtUtil.GetItemInSlot(bot, SLOT_PRIMARY)

					bot.Weapon_Switch(primary)
					primary.AddAttribute("disable weapon switch", 1, 1)
					primary.ReapplyProvision()
				}
			break
			}
		}
	}

	popext_homingprojectile = function(bot, args) {

		// Tag homingprojectile |turnpower|speedmult|ignoreStealthedSpies|ignoreDisguisedSpies
		local args_len = args.len()
		local turn_power = (args_len > 0) ? args[0].tofloat() : 0.75
		local speed_mult = (args_len > 1) ? args[1].tofloat() : 1.0
		local ignoreStealthedSpies = (args_len > 2) ? args[2].tointeger() : 1
		local ignoreDisguisedSpies = (args_len > 3) ? args[3].tointeger() : 1

		bot.GetScriptScope().PlayerThinkTable.HomingProjectileScanner <- function() {

			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile_*");) {
				if (projectile.GetOwner() != bot || !Homing.IsValidProjectile(projectile, PopExtUtil.HomingProjectiles)) continue
				// Any other parameters needed by the projectile thinker can be set here
				Homing.AttachProjectileThinker(projectile, speed_mult, turn_power, ignoreDisguisedSpies, ignoreStealthedSpies)
			}
		}

		PopExtTags.TakeDamageTable.HomingTakeDamage <- function(params) {

			if (!params.const_entity.IsPlayer()) return

			local classname = params.inflictor.GetClassname()
			if (classname != "tf_projectile_flare" && classname != "tf_projectile_energy_ring") return

			EntFireByHandle(params.inflictor, "Kill", null, 0.5, null, null)
		}
	}

	popext_rocketcustomtrail = function (bot, args) {

		bot.GetScriptScope().PlayerThinkTable.ProjectileTrailThink <- function() {

			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile_*");) {

				if (projectile.IsEFlagSet(EFL_PROJECTILE) || GetPropEntity(projectile, "m_hOwnerEntity") != bot) continue

				if (args.len() > 1) EntFireByHandle(projectile, "DispatchEffect", "ParticleEffectStop", -1, null, null)

				local particle = CreateByClassname("trigger_particle")

				particle.KeyValueFromString("particle_name", args[0])
				particle.KeyValueFromInt("attachment_type", PATTACH_ABSORIGIN_FOLLOW)
				particle.KeyValueFromInt("spawnflags", SF_TRIGGER_ALLOW_ALL)

				DispatchSpawn(particle)

				EntFireByHandle(particle, "StartTouch", "!activator", -1, projectile, projectile)
				EntFireByHandle(particle, "Kill", "", -1, null, null)

				projectile.AddEFlags(EFL_PROJECTILE)
			}
		}
	}

	popext_customweaponmodel = function(bot, args) {

		bot.GetActiveWeapon().SetModelSimple(args[0])
	}

	popext_spawnhere = function(bot, args) {

		if (FindByName(null, args[0]) != null)
			bot.Teleport(true, FindByName(null, args[0]).GetOrigin(), true, bot.EyeAngles(), true, bot.GetAbsVelocity())
		else
		{
			local org = split(args[0], " ")
			org.apply(function(val) { return val.tofloat()})
			bot.Teleport(true, Vector(org[0], org[1], org[2]), true, bot.EyeAngles(), true, bot.GetAbsVelocity())
		}

		if (args.len() < 2) return

		local spawnubertime = args[1].tofloat()
		bot.AddCondEx(TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED, spawnubertime, null)
	}

	popext_improvedairblast = function (bot, args) {

		bot.GetScriptScope().PlayerThinkTable.ImprovedAirblastThink <- function() {
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile_*");) {
				if (projectile.GetTeam() == bot.GetTeam() || !Homing.IsValidProjectile(projectile, PopExtUtil.DeflectableProjectiles))
					continue

				if (aibot.GetThreatDistanceSqr(projectile) <= 67000 && aibot.IsVisible(projectile)) {
					switch (botLevel) {
						case 1: // Basic Airblast, only deflect if in FOV

							if (!aibot.IsInFieldOfView(projectile))
								return
							break
						case 2: // Advanced Airblast, deflect regardless of FOV

						aibot.LookAt(projectile.GetOrigin(), INT_MAX, INT_MAX)
							break
						case 3: // Expert Airblast, deflect regardless of FOV back to Sender

							local owner = projectile.GetOwner()
							if (owner != null) {
								local owner_head = owner.GetAttachmentOrigin(owner.LookupAttachment("head"))
								aibot.LookAt(owner_head, INT_MAX, INT_MAX)
							}
							break
					}
					bot.PressAltFireButton(0.0)
				}
			}
		}
	}
	/* valid attachment points for most playermodels:
		- head
		- eyes
		- righteye/lefteye
		- foot_L/_R
		- back_upper/lower
		- hand_L/R
		- partyhat
		- doublejumpfx (scout)
		- eyeglow_L/R
		- weapon_bone
		- weapon_bone_2/3/4
		- effect_hand_R
		- flag
		- prop_bone
		- prop_bone_1/2/3/4/5/6
	*/
	popext_aimat = function(bot, args) {
		bot.GetScriptScope().PlayerThinkTable.AimAtThink <- function()
		{
			foreach (player in PopExtUtil.HumanArray)
			{
				if (aibot.IsInFieldOfView(player))
				{
					aibot.LookAt(player.GetAttachmentOrigin(player.LookupAttachment(args[0])))
					break
				}
			}
		}
	}

	popext_dropweapon = function(bot, args) {

		bot.GetScriptScope().DeathHookTable.DropWeaponDeath <- function(params) {

			printl("dropping weapon")
			local slot = (args.len() > 0) ? args[0].tointeger() : -1
			local wep  = (slot == -1) ? bot.GetActiveWeapon() : PopExtUtil.GetItemInSlot(bot, slot)
			if (wep == null) return

			local itemid = PopExtUtil.GetItemIndex(wep)
			local wearable = CreateByClassname("tf_wearable")

			SetPropBool(wearable, "m_AttributeManager.m_Item.m_bInitialized", true)
			SetPropInt(wearable, STRING_NETPROP_ITEMDEF, itemid)

			wearable.DispatchSpawn()

			local modelname = wearable.GetModelName()

			wearable.Destroy()

			local droppedweapon = CreateByClassname("tf_dropped_weapon")
			SetPropInt(droppedweapon, "m_Item.m_iItemDefinitionIndex", itemid)
			SetPropInt(droppedweapon, "m_Item.m_iEntityLevel", 5)
			SetPropInt(droppedweapon, "m_Item.m_iEntityQuality", 6)
			SetPropBool(droppedweapon, "m_Item.m_bInitialized", true)
			droppedweapon.SetModelSimple(modelname)
			droppedweapon.SetOrigin(bot.GetOrigin())

			droppedweapon.DispatchSpawn()

			// Store attributes in scope, when it gets picked up add the attributes to the real weapon

		}
	}

	popext_halloweenboss = function(bot, args) {

		if (!("bosskiller" in ROOT)) ::bosskiller <- null

		local scope = bot.GetScriptScope()

		if ("halloweenboss" in scope) return

		local boss = CreateByClassname(args[0])

		scope.halloweenboss <- boss

		local org = split(args[2], " ")
		org.apply(function(v) { return v.tofloat()})
		boss.SetOrigin(Vector(org[0], org[1], org[2]))

		args.len() > 4 ? boss.SetTeam(args[4].tointeger()) : boss.SetTeam(5)

		DispatchSpawn(boss)

		local bosshealth = 0
		args[1] == "BOTHP" ? bosshealth = bot.GetHealth() : bosshealth = args[1].tointeger()

		boss.SetHealth(bosshealth)

		if (args.len() > 3)
		{
			if (args[0] != "headless_hatman")
			{
				local eventname = ""
				args[0] = "eyeball_boss" ? eventname = "eyeball_boss_escape_imminent" : eventname = "merasmus_escape_warning"
				SendGlobalGameEvent(eventname, {time_remaining 	= args[3].tointeger()})
			}
			else
				EntFireByHandle(boss, "RunScriptCode", "self.TakeDamage(INT_MAX, DMG_GENERIC, self)", args[3].tointeger(), null, null)
		}

		PopExtUtil.MonsterResource.ValidateScriptScope()

		PopExtUtil.MonsterResource.GetScriptScope().HealthBarThink <- function() {

			if (!boss.IsValid())
			{
				delete PopExtUtil.MonsterResource.GetScriptScope().HealthBarThink
				return
			}

			local barvalue = (boss.GetHealth().tofloat() / bosshealth.tofloat()) * 255

			if (barvalue < 0) barvalue = 0

			SetPropInt(PopExtUtil.MonsterResource, "m_iBossHealthPercentageByte", barvalue)
			return -1
		}
		AddThinkToEnt(PopExtUtil.MonsterResource, "HealthBarThink")

		scope.PlayerThinkTable.BossHealthThink <- function() {

			if (scope.halloweenboss.IsValid() && boss.GetHealth() != bot.GetHealth() && args[1] == "BOTHP")
				bot.SetHealth(boss.GetHealth())

			if (scope.halloweenboss.IsValid()) return

			local uberconds = [TF_COND_INVULNERABLE, TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED, TF_COND_INVULNERABLE_CARD_EFFECT, TF_COND_INVULNERABLE_USER_BUFF]
			foreach (cond in uberconds)
				if (bot.InCond(cond))
					bot.RemoveCondEx(cond, true)

			bot.TakeDamage(INT_MAX, DMG_GENERIC, bosskiller)
		}
	}

	popext_teleportnearvictim = function(bot, args) {

		local bot_scope = bot.GetScriptScope()
		bot_scope.TeleportAttempt <- 0
		bot_scope.NextTeleportTime <- Time()
		bot_scope.Teleported <- false

		bot_scope.PlayerThinkTable.TeleportNearVictimThink <- function() {

			if (!bot_scope.Teleported && bot_scope.NextTeleportTime <= Time() && !bot.HasItem()) {
				local victim = null
				local players = []

				for (local i = 1; i <= MAX_CLIENTS; i++) {
					local player = PlayerInstanceFromIndex(i)
					if (player == null)
						continue

					if (player.GetTeam() == bot.GetTeam())
						continue

					if (GetPropInt(player, "m_lifeState") != LIFE_ALIVE)
						continue

					players.push(player)
				}

				local n = players.len()
				while (n > 1) {
					local k = RandomInt(0, n - 1)
					n--

					local tmp = players[n]
					players[n] = players[k]
					players[k] = tmp
				}

				for (local i = 0; i < players.len(); ++i) {
					if (PopExtUtil.TeleportNearVictim(bot, players[i], bot_scope.TeleportAttempt)) {
						victim = players[i]
						break
					}
				}

				if (victim == null) {
					bot_scope.NextTeleportTime = Time() + 1.0
					++bot_scope.TeleportAttempt
					return
				}

				bot_scope.Teleported = true
			}
		}
	}
}
::Homing <- {
	// Modify the AttachProjectileThinker function to accept projectile speed adjustment if needed
	function AttachProjectileThinker(projectile, speed_mult, turn_power, ignoreDisguisedSpies = true, ignoreStealthedSpies = true) {

		projectile.ValidateScriptScope()
		local projectile_scope = projectile.GetScriptScope()
		if (!("speedmultiplied" in projectile_scope)) projectile_scope.speedmultiplied <- false

		local projectile_speed = projectile.GetAbsVelocity().Norm()

		if (!projectile_scope.speedmultiplied) {
			projectile_speed *= speed_mult
			projectile_scope.speedmultiplied = true
		}
		// printl("speed: " + projectile_speed)

		projectile_scope.turn_power			  <- turn_power
		projectile_scope.projectile_speed	  <- projectile_speed
		projectile_scope.ignoreDisguisedSpies <- ignoreDisguisedSpies
		projectile_scope.ignoreStealthedSpies <- ignoreStealthedSpies

		//this should be added in globalfixes.nut but sometimes this code tries to run before the table is created
		if (!("ProjectileThinkTable" in projectile_scope)) projectile_scope.ProjectileThinkTable <- {}

		projectile_scope.ProjectileThinkTable.HomingProjectileThink <- Homing.HomingProjectileThink
	}

	function HomingProjectileThink() {
		local new_target = Homing.SelectVictim(self)
		if (new_target != null && Homing.IsLookingAt(self, new_target))
			Homing.FaceTowards(new_target, self, projectile_speed)
	}

	function SelectVictim(projectile) {
		local target
		local min_distance = 32768.0
		foreach (player in PopExtUtil.HumanArray) {

			local distance = (projectile.GetOrigin() - player.GetOrigin()).Length()

			if (IsValidTarget(player, distance, min_distance, projectile)) {
				target = player
				min_distance = distance
			}
		}
		return target
	}

	function IsValidTarget(victim, distance, min_distance, projectile) {

		local projectile_scope = projectile.GetScriptScope()
		// Early out if basic conditions aren't met
		if (distance > min_distance || victim.GetTeam() == projectile.GetTeam() || !PopExtUtil.IsAlive(victim)) {
			return false
		}

		// Check for conditions based on the projectile's configuration
		if (victim.IsPlayer()) {
			if (victim.InCond(TF_COND_HALLOWEEN_GHOST_MODE)) {
				return false
			}

			// Check for stealth and disguise conditions if not ignored
			if (!projectile_scope.ignoreStealthedSpies && (victim.IsStealthed() || victim.IsFullyInvisible())) {
				return false
			}
			if (!projectile_scope.ignoreDisguisedSpies && victim.GetDisguiseTarget() != null) {
				return false
			}
		}

		return true
	}


	function FaceTowards(new_target, projectile, projectile_speed) {
		local scope = projectile.GetScriptScope()
		local desired_dir = new_target.EyePosition() - projectile.GetOrigin()

		desired_dir.Norm()

		local current_dir = projectile.GetForwardVector()
		local new_dir = current_dir + (desired_dir - current_dir) * scope.turn_power
		// printl("Dir: " + new_dir)
		new_dir.Norm()

		local move_ang = PopExtUtil.VectorAngles(new_dir)
		local projectile_velocity = move_ang.Forward() * projectile_speed

		projectile.SetAbsVelocity(projectile_velocity)
		projectile.SetLocalAngles(move_ang)
	}

	function IsLookingAt(projectile, new_target) {
		local target_origin = new_target.GetOrigin()
		local projectile_owner = projectile.GetOwner()
		local projectile_owner_pos = projectile_owner.EyePosition()

		if (TraceLine(projectile_owner_pos, target_origin, projectile_owner)) {
			local direction = (target_origin - projectile_owner.EyePosition())
				direction.Norm()
			local product = projectile_owner.EyeAngles().Forward().Dot(direction)

			if (product > 0.6)
				return true
		}

		return false
	}

	function IsValidProjectile(projectile, table) {
		if (projectile.GetClassname() in table)
			return true

		return false
	}

}
// ::GetBotBehaviorFromTags <- function(bot)
// {
//	   local tags = {}
//	   local scope = bot.GetScriptScope()
//	   bot.GetAllBotTags(tags)

//	   if (tags.len() == 0) return

//	   foreach (tag in tags)
//	   {
//		   local args = split(tag, "|")
//		   if (args.len() == 0) continue
//		   local func = args.remove(0)
//		   if (func in popext_funcs)
//			   popext_funcs[func](bot, args)
//	   }
	// function PopExt_BotThinks()
	// {
	//	   local scope = self.GetScriptScope()
	//	   if (scope.PlayerThinkTable.len() < 1) return

	//	   foreach (_, func in scope.PlayerThinkTable)
	//		  func(self)
	// }
//	   AddThinkToEnt(bot, "PopExt_BotThinks")
// }

::PopExtTags <- {

	TakeDamageTable = {}
	DeathHookTable = {}
	TeamSwitchTable = {}

	function EvaluateTags(bot) {
		foreach(tag in __tagarray) {
			if (bot.HasBotTag(tag)) {
				local args = split(tag, "|")
				local func = args.remove(0)
				if (func in popext_funcs)
					popext_funcs[func](bot, args)
			}
		}
	}

	function OnScriptHook_OnTakeDamage(params) {

		local scope = params.attacker.GetScriptScope()

		foreach (_, func in this.TakeDamageTable) { func(params) }
	}

	function OnGameEvent_player_team(params) {

		local bot = GetPlayerFromUserID(params.userid)
		if (params.team == TEAM_SPECTATOR) _AddThinkToEnt(bot, null)

		foreach (_, func in this.TeamSwitchTable) func(params)
	}

	function OnGameEvent_player_death(params) {

		local bot = GetPlayerFromUserID(params.userid)
		if (!bot.IsBotOfType(TF_BOT_TYPE)) return

		local scope = bot.GetScriptScope()
		bot.ClearAllBotTags()
		foreach (_, func in this.DeathHookTable) func(params)

		_AddThinkToEnt(bot, null)
	}
	function OnGameEvent_teamplay_round_start(params) {

		foreach (bot in PopExtUtil.BotArray)
			if (bot.GetTeam() != TEAM_SPECTATOR)
				bot.ForceChangeTeam(TEAM_SPECTATOR, true)
	}
	function OnGameEvent_halloween_boss_killed(params) {
		::bosskiller <- GetPlayerFromUserID(params.killer)
	}
}
__CollectGameEventCallbacks(PopExtTags)
