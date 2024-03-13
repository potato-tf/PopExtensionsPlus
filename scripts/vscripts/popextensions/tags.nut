//behavior tags
IncludeScript("popextensions/botbehavior", getroottable())

local tagfile = format("%s_tags.nut", split(split(__popname, "/")[2], ".")[0])
printl(tagfile)
IncludeScript(tagfile, getroottable())

local popext_funcs = {
	
	popext_addcond = function(bot, args) {
		if (args.len() == 1) {
			if (args[0].tointeger() == 43) {
				bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, true)
				function MoveToSpec(params) {
					EntFirebyHandle(bot, "RunScriptCode", "self.ForceChangeTeam(TEAM_SPECTATOR, true)", 3, null, null)
				}
				// bot.GetScriptScope().DeathHookTable.MoveToSpec <- MoveToSpec
			}
			else
				bot.AddCond(args[0].tointeger())
		}

		else if (args.len() >= 2)
			bot.AddCondEx(args[0].tointeger(), args[1].tointeger(), null)
	}

	popext_reprogrammed = function(bot, args) {
		bot.ForceChangeTeam(TF_TEAM_PVE_DEFENDERS, true)
		function MoveToSpec(params) {
			EntFireByHandle(bot, "RunScriptCode", "self.ForceChangeTeam(TEAM_SPECTATOR, true)", 3, null, null)
		}
		// bot.GetScriptScope().DeathHookTable.MoveToSpec <- MoveToSpec
	}

	popext_reprogrammed_neutral = function(bot, args) {
		bot.ForceChangeTeam(TEAM_UNASSIGNED, true)
	}

	popext_altfire = function(bot, args) {
		if (args.len() == 1)
			bot.PressAltFireButton(INT_MAX)
		else if (args.len() >= 2)
			bot.PressAltFireButton(args[1].tointeger())
	}

	popext_usehumanmodel = function(bot, args) {
		bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", PopExtUtil.Classes[bot.GetPlayerClass()]))
	}

	popext_usehumananims = function(bot, args) {
		local class_string = PopExtUtil.Classes[bot.GetPlayerClass()]
		bot.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", class_string))
		PopExtUtil.PlayerRobotModel(bot, format("models/bots/%s/bot_%s.mdl", class_string, class_string))
	}

	popext_alwaysglow = function(bot, args) {
		SetPropBool(bot, "m_bGlowEnabled", true)
	}

	popext_stripslot = function(bot, args) {
		if (args.len() == 1) args.append(-1)
		local slot = args[1].tointeger()

		if (slot == -1) slot = player.GetActiveWeapon().GetSlot()
		PopExtUtil.GetItemInSlot(player, slot).Kill()
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

		function FireWeaponThink()
		{
			if ((maxrepeats) >= repeats)
			{
				delete bot.GetScriptScope().PlayerThinkTable.FireWeaponThink
				return
			}

			if (Time() < delaytime || (Time() < cooldowntime) || bot.GetHealth() > ifhealthbelow || bot.HasBotAttribute(SUPPRESS_FIRE)) return

			maxrepeats++

			PopExtUtil.PressButton(bot, button)
			cooldowntime = Time() + cooldown
		}
		bot.GetScriptScope().PlayerThinkTable.FireWeaponThink <- FireWeaponThink
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

		function WeaponSwitchThink()
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
		bot.GetScriptScope().PlayerThinkTable.WeaponSwitchThink <- WeaponSwitchThink
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
			local weapon = Entities.CreateByClassname("tf_weapon_spellbook")
			SetPropInt(weapon, STRING_NETPROP_ITEMDEF, ID_SPELLBOOK_MAGAZINE_STOCK)
			SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
			SetPropBool(weapon, "m_bValidatedAttachedEntity", true)

			weapon.SetTeam(bot.GetTeam())
			Entities.DispatchSpawn(weapon)
	
			bot.Weapon_Equip(weapon)

			//try again next think
			return
		}

		local cooldowntime = Time() + cooldown
		local delaytime = Time() + delay

		local maxrepeats = 0
		function SpellThink()
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
		bot.GetScriptScope().PlayerThinkTable.SpellThink <- SpellThink
	}
	popext_forceromevision = function(bot, args) {

		//kill the existing romevision
		EntFireByHandle(bot, "RunScriptCode", @"
		local killrome = []

		if (self.IsBotOfType(1337))
			for (local child = self.FirstMoveChild(); child != null; child = child.NextMovePeer())
				if (child.GetClassname() == `tf_wearable` && startswith(child.GetModelName(), `models/workshop/player/items/`+PopExtUtil.Classes[self.GetPlayerClass()]+`/tw`))
					killrome.append(child)

		for(local i = killrome.len() - 1; i >= 0; i--) killrome[i].Kill()

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

	popext_customattrib = function(bot, args) {
		local args_len = args.len()
		if (args_len == 2)
			CustomAttributes.AddAttr(bot, args[0], args[1])
		else if (args_len == 3)
			CustomAttributes.AddAttr(bot, args[0], args[1], args[2])
	}
	
	popext_ringoffire = function(bot, args) {
		local args_len = args.len()
		local damage = (args_len > 0) ? args[0].tofloat() : 7.5
		local interval = (args_len > 1) ? args[1].tofloat() : 0.5
		local radius = (args_len > 2) ? args[2].tofloat() : 135.0

		local cooldown = Time() + interval
		function RingOfFireThink() {
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
		bot.GetScriptScope().PlayerThinkTable.RingOfFireThink <- RingOfFireThink
	}
	// popext_meleeai = function(bot, args) {
	// 	local visionoverride = bot.GetMaxVisionRangeOverride() == -1 ? INT_MAX : bot.GetMaxVisionRangeOverride()

	// 	function MeleeAIThink() {
	// 		local threat = FindThreat(visionoverride)
			
	// 		if (threat == null || threat.IsFullyInvisible() || threat.IsStealthed()) return

	// 		SetThreat(threat, true)
	// 	}

	// 	bot.GetScriptScope().PlayerThinkTable.MeleeAIThink <- MeleeAIThink
	// }

	popext_weaponresist = function(bot, args) {
		local weapon = args[0]
		local amount = args[1].tofloat()

		function WeaponResistTakeDamage(params)
		{	
			if (!params.const_entity.IsPlayer() || params.weapon == null || (params.weapon.GetClassname() != weapon || PopExtUtil.GetItemIndex(params.weapon) != weapon.tointeger())) return
			printl(params.weapon)
			params.damage *= amount
		}
		
		bot.GetScriptScope().TakeDamageTable.WeaponResistTakeDamage <- WeaponResistTakeDamage
	}

	popext_setskin = function(bot, args) {
		EntFireByHandle(bot, "skin", args[0], SINGLE_TICK, null, null)
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

		function DispenserBuildOverride(params) {

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
		bot.GetScriptScope().BuiltObjectTable.DispenserBuildOverride <- DispenserBuildOverride
	}

	//this is a very simple method for giving bots weapons.
	popext_giveweapon = function(bot, args) {

		local weapon = Entities.CreateByClassname(args[0])
		SetPropInt(weapon, STRING_NETPROP_ITEMDEF, args[1].tointeger())
		SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
		SetPropBool(weapon, "m_bValidatedAttachedEntity", true)
		weapon.SetTeam(bot.GetTeam())
		Entities.DispatchSpawn(weapon)

		PopExtUtil.GetItemInSlot(bot, weapon.GetSlot()).Destroy()

		bot.Weapon_Equip(weapon)

		return weapon
	}

	popext_usebestweapon = function(bot, args) {
		function BestWeaponThink() {
			switch(bot.GetPlayerClass()) {
			case 1: //TF_CLASS_SCOUT

				//scout and pyro's UseBestWeapon is inverted
				//switch them to secondaries, then back to primary when enemies are close

				if (bot.GetActiveWeapon() != PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))
					bot.Weapon_Switch(PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY))

				for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
					if (p.GetTeam() == bot.GetTeam()) continue
					local primary = PopExtUtil.GetItemInSlot(bot, SLOT_PRIMARY)

					bot.Weapon_Switch(primary)
					primary.AddAttribute("disable weapon switch", 1, 1)
					primary.ReapplyProvision()
				}
			break

			case 2: //TF_CLASS_SNIPER
				for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 750);) {
					if (p.GetTeam() == bot.GetTeam() || bot.GetActiveWeapon().GetSlot() == 2) continue //potentially not break sniper ai

					local secondary = PopExtUtil.GetItemInSlot(bot, SLOT_SECONDARY)

					bot.Weapon_Switch(secondary)
					secondary.AddAttribute("disable weapon switch", 1, 1)
					secondary.ReapplyProvision()
				}
			break

			case 3: //TF_CLASS_SOLDIER
				for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
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

				for (local p; p = Entities.FindByClassnameWithin(p, "player", bot.GetOrigin(), 500);) {
					if (p.GetTeam() == bot.GetTeam()) continue

					local primary = PopExtUtil.GetItemInSlot(bot, SLOT_PRIMARY)

					bot.Weapon_Switch(primary)
					primary.AddAttribute("disable weapon switch", 1, 1)
					primary.ReapplyProvision()
				}
			break
			}
		}
		bot.GetScriptScope().PlayerThinkTable.BestWeaponThink <- BestWeaponThink
	}
	popext_homingprojectile = function(bot, args) {
		// Tag homingprojectile |turnpower|speedmult|ignoreStealthedSpies|ignoreDisguisedSpies
		local args_len = args.len()
		local turn_power = (args_len > 0) ? args[0].tofloat() : 0.75
		local speed_mult = (args_len > 1) ? args[1].tofloat() : 1.0
		local ignoreStealthedSpies = (args_len > 2) ? args[2].tointeger() : 1
		local ignoreDisguisedSpies = (args_len > 3) ? args[3].tointeger() : 1

		function HomingProjectileScanner() {
			for (local projectile; projectile = Entities.FindByClassname(projectile, "tf_projectile_*");) {
				if (projectile.GetOwner() != bot || !Homing.IsValidProjectile(projectile, PopExtUtil.HomingProjectiles)) continue
				// Any other parameters needed by the projectile thinker can be set here
				Homing.AttachProjectileThinker(projectile, speed_mult, turn_power, ignoreDisguisedSpies, ignoreStealthedSpies)
			}
		}
		bot.GetScriptScope().PlayerThinkTable.HomingProjectileScanner <- HomingProjectileScanner

		function HomingTakeDamage(params) {
			if (!params.const_entity.IsPlayer()) return

			local classname = params.inflictor.GetClassname()
			if (classname != "tf_projectile_flare" && classname != "tf_projectile_energy_ring") return

			EntFireByHandle(params.inflictor, "Kill", null, 0.5, null, null)
		}
		bot.GetScriptScope().TakeDamageTable.HomingTakeDamage <- HomingTakeDamage
	}
	popext_rocketcustomtrail = function (bot, args) {

		
		function ProjectileTrailThink()
		{
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile_*");) {
				if (projectile.GetEFlags() & EFL_NO_ROTORWASH_PUSH || GetPropEntity(projectile, "m_hOwnerEntity") != bot) continue
				
				if (args.len() > 1) EntFireByHandle(projectile, "DispatchEffect", "ParticleEffectStop", -1, null, null)
				// EntFireByHandle(projectile, "RunScriptCode", format("DispatchParticleEffect(`%s`, self.GetOrigin(), self.GetAngles())", args[0]), SINGLE_TICK, null, null)
				local particle = SpawnEntityFromTable("trigger_particle", {
					particle_name = args[0],
					attachment_type = 1, // PATTACH_ABSORIGIN_FOLLOW,
					spawnflags = 64 // allow everything
				});
				EntFireByHandle(particle, "StartTouch", "!activator", -1, projectile, projectile);
				EntFireByHandle(particle, "Kill", "", -1, null, null);
				projectile.AddEFlags(EFL_NO_ROTORWASH_PUSH)
			}
		}
		bot.GetScriptScope().PlayerThinkTable.ProjectileTrailThink <- ProjectileTrailThink
	}
	popext_spawnhere = function(bot, args) {

		local org = split(args[0], " ")
		bot.Teleport(true, Vector(org[0].tofloat(), org[1].tofloat(), org[2].tofloat()), true, QAngle(), true, bot.GetAbsVelocity())

		if (args.len() < 2) return

		local spawnubertime = args[1].tofloat()
		bot.AddCondEx(TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED, spawnubertime, null)
	}
	popext_improvedairblast = function (bot, args) {

		function ImprovedAirblastThink() {
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile_*");) {
				if (projectile.GetTeam() == bot.GetTeam() || !Homing.IsValidProjectile(projectile, PopExtUtil.DeflectableProjectiles))
					continue

				if (GetThreatDistanceSqr(projectile) <= 67000 && IsVisible(projectile)) {
					switch (botLevel) {
						case 1: // Basic Airblast, only deflect if in FOV

							if (!IsInFieldOfView(projectile))
								return
							break
						case 2: // Advanced Airblast, deflect regardless of FOV

						LookAt(projectile.GetOrigin(), INT_MAX, INT_MAX)
							break
						case 3: // Expert Airblast, deflect regardless of FOV back to Sender

							local owner = projectile.GetOwner()
							if (owner != null) {
								local owner_head = owner.GetAttachmentOrigin(owner.LookupAttachment("head"))
								LookAt(owner_head, INT_MAX, INT_MAX)
							}
							break
					}
					bot.PressAltFireButton(0.0)
				}
			}
		}
		bot.GetScriptScope().PlayerThinkTable.ImprovedAirblastThink <- ImprovedAirblastThink
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
		function AimAtThink()
		{
			foreach (player in PopExtUtil.HumanArray)
			{
				if (bot.IsInFieldOfView(player))
				{
					LookAt(player.GetAttachmentOrigin(player.LookupAttachment(args[0])))
					break
				}
			}
		}
		bot.GetScriptScope().PlayerThinkTable.AimAtThink <- AimAtThink
	}
	popext_addcondonhit = function(bot, args) {
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
		bot_scope.CondOnHitCritOnly	   = critOnly

		function AddCondOnHitTakeDamage(params) {
			if (!params.const_entity.IsPlayer()) return

			local victim = params.const_entity
			local attacker = params.attacker

			if (attacker != null && victim != attacker) {
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
	popext_dropweapon = function(bot, args) {
	
		function DropWeaponDeath(params) {
	
			printl("dropping weapon")
			local slot = (args.len() > 0) ? args[0].tointeger() : -1
			local wep  = (slot == -1) ? bot.GetActiveWeapon() : PopExtUtil.GetItemInSlot(bot, slot)
			if (wep == null) return
	
			local itemid = PopExtUtil.GetItemIndex(wep)
			local wearable = CreateByClassname("tf_wearable")
	
			SetPropBool(wearable, "m_AttributeManager.m_Item.m_bInitialized", true)
			SetPropInt(wearable, STRING_NETPROP_ITEMDEF, itemid)
	
			wearable.DispatchSpawn();
	
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
	
		bot.GetScriptScope().DeathHookTable.DropWeaponDeath <- DropWeaponDeath
	}

}
::Homing <- {
	// Modify the AttachProjectileThinker function to accept projectile speed adjustment if needed
	function AttachProjectileThinker(projectile, speed_mult, turn_power, ignoreDisguisedSpies = true, ignoreStealthedSpies = true) {
		local projectile_speed = projectile.GetAbsVelocity().Norm()

		// printl("speed: " + projectile_speed)

		projectile.ValidateScriptScope()
		local projectile_scope = projectile.GetScriptScope()
		projectile_scope.turn_power			  <- turn_power
		projectile_scope.projectile_speed	  <- projectile_speed // * speed_mult
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

		local scope = projectile.GetScriptScope()
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
			// if (!scope.ignoreStealthedSpies && (victim.IsStealthed() || victim.IsFullyInvisible())) {
			// 	return false
			// }
			// if (!scope.ignoreDisguisedSpies && victim.GetDisguiseTarget() != null) {
			// 	return false
			// }
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

	function AI_BotSpawn(bot) {
		local scope = bot.GetScriptScope()

		scope.bot <- AI_Bot(bot)
		scope.PlayerThinkTable <- {}
		
		foreach(tag in __tagarray) {
			if (bot.HasBotTag(tag)) {
				local args = split(tag, "|")
				local func = args.remove(0)
				if (func in popext_funcs)
					popext_funcs[func](bot, args)
			}
		}
		
		//bot.AddBotAttribute(1024) // IGNORE_ENEMIES
	}
	function BotThink()
	{
		bot.OnUpdate()
		return -1
	}
	
	function OnGameEvent_post_inventory_application(params) {
		local bot = GetPlayerFromUserID(params.userid)
		if (!bot.IsBotOfType(1337)) return

		bot.ValidateScriptScope()
		local scope = bot.GetScriptScope()
		scope.BotThink <- PopExtTags.BotThink
		
		EntFireByHandle(bot, "RunScriptCode", "AddThinkToEnt(self, `BotThink`)", -1, null, null)

		if (!bot.IsBotOfType(1337)) return

		local items = {

			PlayerThinkTable = {}
			TakeDamageTable = {}
			DeathHookTable = {}
		}
		foreach (k,v in items) if (!(k in scope)) scope[k] <- v
		// foreach (k, v in scope) printl(k + " : " + v)
		if (bot.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope)) scope.BuiltObjectTable <- {}

		// PopExtTags.AI_BotSpawn(bot)
		EntFireByHandle(bot, "RunScriptCode", "PopExtTags.AI_BotSpawn(self)", -1, null, null)
	}
	function OnScriptHook_OnTakeDamage(params) {

		local scope = params.attacker.GetScriptScope()

		if (!("TakeDamageTable" in scope)) return

		foreach (_, func in scope.TakeDamageTable) { func(params) }
	}
	function OnGameEvent_player_builtobject(params) {

		local scope = GetPlayerFromUserID(params.userid).GetScriptScope()

		if (!("BuiltObjectTable" in scope)) return

		foreach (_, func in scope.BuiltObjectTable) func(params)
	}

	function OnGameEvent_player_team(params) {

		local bot = GetPlayerFromUserID(params.userid)
		if (params.team == TEAM_SPECTATOR) AddThinkToEnt(bot, null)
	}

	function OnGameEvent_player_death(params) {

		local bot = GetPlayerFromUserID(params.userid)
		if (!bot.IsBotOfType(1337)) return

		local scope = bot.GetScriptScope()
		bot.ClearAllBotTags()
		foreach (_, func in scope.DeathHookTable) func(params)

		AddThinkToEnt(bot, null)
	}
	function OnGameEvent_teamplay_round_start(params) {

		foreach (bot in PopExtUtil.BotArray)
			if (bot.GetTeam() == TF_TEAM_PVE_DEFENDERS)
				bot.ForceChangeTeam(TEAM_SPECTATOR, true)
	}
}
__CollectGameEventCallbacks(PopExtTags)
