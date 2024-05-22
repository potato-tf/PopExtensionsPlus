const SCOUT_MONEY_COLLECTION_RADIUS = 288
const HUNTSMAN_DAMAGE_FIX_MOD       = 1.263157
const EFL_USER = 1048576

local GlobalFixesEntity = FindByName(null, "_popext_globalfixes")
if (GlobalFixesEntity == null) GlobalFixesEntity = SpawnEntityFromTable("info_teleport_destination", { targetname = "_popext_globalfixes" })

::GlobalFixes <- {
	InitWaveTable = {}
	TakeDamageTable = {

		function YERDisguiseFix(params) {
			local victim   = params.const_entity
			local attacker = params.inflictor

			if ( victim.IsPlayer() && params.damage_custom == TF_DMG_CUSTOM_BACKSTAB && attacker != null && !attacker.IsBotOfType(TF_BOT_TYPE) && (PopExtUtil.GetItemIndex(params.weapon) == ID_YOUR_ETERNAL_REWARD || PopExtUtil.GetItemIndex(params.weapon) == ID_WANGA_PRICK)) {
				attacker.GetScriptScope().stabvictim <- victim
				EntFireByHandle(attacker, "RunScriptCode", "PopExtUtil.SilentDisguise(self, stabvictim)", -1, null, null)
			}
		}

		/*
		function LooseCannonFix(params) {
			local wep   = params.weapon
			local index = PopExtUtil.GetItemIndex(wep)
			if (index != 996 || params.damage_custom != TF_DMG_CUSTOM_CANNONBALL_PUSH) return

			params.damage *= wep.GetAttribute("damage bonus", 1.0)
		}
		*/

		function BotGibFix(params) {
			local victim = params.const_entity
			if (victim.IsPlayer() && !victim.IsMiniBoss() && victim.GetModelScale() <= 1.0 && params.damage >= victim.GetHealth() && (params.damage_type & DMG_CRITICAL || params.damage_type & DMG_BLAST))
				victim.SetModelScale(1.0000001, 0.0)
		}

		// Quick hacky non-GetAttribute version
		function HuntsmanDamageBonusFix(params) {
			local wep       = params.weapon
			local classname = GetPropString(wep, "m_iClassname")
			if (classname != "tf_weapon_compound_bow") return

			if ((params.damage_custom == TF_DMG_CUSTOM_HEADSHOT && params.damage > 360.0) || params.damage > 120.0)
				params.damage *= HUNTSMAN_DAMAGE_FIX_MOD
		}
		/*
		function HuntsmanDamageBonusFix(params) {
			local wep       = params.weapon
			local classname = GetPropString(wep, "m_iClassname")
			if (classname != "tf_weapon_compound_bow") return

			local mod = wep.GetAttribute("damage bonus", 1.0)
			if (mod != 1.0)
				params.damage *= HUNTSMAN_DAMAGE_FIX_MOD
		}
		*/

		function HolidayPunchFix(params) {
			local wep   = params.weapon
			local index = PopExtUtil.GetItemIndex(wep)
			if (index != ID_HOLIDAY_PUNCH || !(params.damage_type & DMG_CRITICAL)) return

			local victim = params.const_entity
			if (victim != null && victim.IsPlayer() && victim.IsBotOfType(TF_BOT_TYPE)) {
				victim.Taunt(TAUNT_MISC_ITEM, MP_CONCEPT_TAUNT_LAUGH)

				local tfclass      = victim.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]
				local botmodel     = format("models/bots/%s/bot_%s.mdl", class_string, class_string)

				victim.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", class_string))

				PopExtUtil.PlayerRobotModel(player, botmodel)

				//overwrite the existing bot model think to remove it after taunt
				victim.GetScriptScope().PlayerThinkTable.BotModelThink <- function() {

					if (Time() > victim.GetTauntRemoveTime()) {
						if (wearable != null) wearable.Destroy()

						SetPropInt(self, "m_clrRender", 0xFFFFFF)
						SetPropInt(self, "m_nRenderMode", kRenderNormal)
						self.SetCustomModelWithClassAnimations(botmodel)

						SetPropString(self, "m_iszScriptThinkFunction", "")
					}

					return -1
				}
			}
		}
	}

	DisconnectTable = {}

	ThinkTable = {

		function DragonsFuryFix() {
			for (local fireball; fireball = FindByClassname(fireball, "tf_projectile_balloffire");)
				fireball.RemoveFlag(FL_GRENADE)
		}

		//add think table to all projectiles
		//there is apparently no better way to do this lol
		function AddProjectileThink() {
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");) {
				if (projectile.GetEFlags() & EFL_USER) continue

				projectile.ValidateScriptScope()
				local scope = projectile.GetScriptScope()

				if (!("ProjectileThinkTable" in scope)) scope.ProjectileThinkTable <- {}

				scope.ProjectileThink <- function () { foreach (name, func in scope.ProjectileThinkTable) { func() } return -1 }

				_AddThinkToEnt(projectile, "ProjectileThink")
				projectile.AddEFlags(EFL_USER)
			}
		}
		function FastNPCUpdate() {
			local validnpcs = ["headless_hatman", "eyeball_boss", "merasmus", "tf_zombie"]

			foreach (npc in validnpcs)
				for (local n; n = FindByClassname(n, npc);)
					n.FlagForUpdate(true)
		}
	}

	DeathHookTable = {

		function NoCreditVelocity(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			for (local money; money = FindByClassname(money, "item_currencypack*");)
				money.SetAbsVelocity(Vector(1, 1, 1)) //0 velocity breaks our reverse mvm money pickup methods.  set to 1hu instead
		}
	}

	SpawnHookTable = {

		function ScoutBetterMoneyCollection(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(TF_BOT_TYPE) || player.GetPlayerClass() != TF_CLASS_SCOUT) return

			player.GetScriptScope().PlayerThinkTable.MoneyThink <- function() {

				if (player.GetPlayerClass() != TF_CLASS_SCOUT || "ReverseMVMCurrencyThink" in player.GetScriptScope().PlayerThinkTable) {
					delete player.GetScriptScope().PlayerThinkTable.MoneyThink
					return
				}

				local origin = player.GetOrigin()
				for (local money; money = FindByClassnameWithin(money, "item_currencypack*", player.GetOrigin(), SCOUT_MONEY_COLLECTION_RADIUS);)
					money.SetOrigin(origin)

			}
		}

		function RemoveYERAttribute(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(TF_BOT_TYPE)) return

			local wep   = PopExtUtil.GetItemInSlot(player, SLOT_MELEE)
			local index = PopExtUtil.GetItemIndex(wep)

			if (index == ID_YOUR_ETERNAL_REWARD || index == ID_WANGA_PRICK)
				wep.RemoveAttribute("disguise on backstab")
		}

		function HoldFireUntilFullReloadFix(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local scope = player.GetScriptScope()
			scope.holdingfire <- false
			scope.lastfiretime <- 0.0

			scope.PlayerThinkTable.HoldFireThink <- function() {

				if (!player.HasBotAttribute(HOLD_FIRE_UNTIL_FULL_RELOAD)) return

				local activegun = player.GetActiveWeapon()
				if (activegun == null) return
				local clip = activegun.Clip1()
				if (clip == 0)
				{
					player.AddBotAttribute(SUPPRESS_FIRE)
					scope.holdingfire = true
				}
				else if (clip == activegun.GetMaxClip1() && scope.holdingfire)
				{
					player.RemoveBotAttribute(SUPPRESS_FIRE)
					scope.holdingfire = false
				}
			}
		}

		// function RestoreGiantFootsteps(params) {

		// 	local player = GetPlayerFromUserID(params.userid)

		// 	if (!player.IsBotOfType(TF_BOT_TYPE) || !player.IsMiniBoss()) return
		// 	player.AddCustomAttribute("override footstep sound set", 0, -1)

		// 	local validclasses = {
		// 		[TF_CLASS_SCOUT] = null,
		// 		[TF_CLASS_SOLDIER] = null,
		// 		[TF_CLASS_PYRO] = null ,
		// 		[TF_CLASS_DEMOMAN] = null ,
		// 		[TF_CLASS_HEAVYWEAPONS] = null
		// 	}

		// 	if (!(player.GetPlayerClass() in validclasses)) return

		// 	local cstring = PopExtUtil.Classes[player.GetPlayerClass()]

		// 	player.ValidateScriptScope()
		// 	local scope = player.GetScriptScope()

		// 	scope.stepside <- GetPropInt(player, "m_Local.m_nStepside")
		// 	scope.stepcount <- 0
		// 	scope.PlayerThinkTable.RestoreGiantFootsteps <- function() {

		// 		if ((GetPropInt(player, "m_Local.m_nStepside")) == scope.stepside) return
		// 		// if (GetPropFloat(player, "m_flStepSoundTime") != 400) return

		// 		printl(GetPropFloat(player, "m_flStepSoundTime"))


		// 		local footstepsound = format("^mvm/giant_%s/giant_%s_step_0%d.wav", cstring, cstring, RandomInt(1, 4))

		// 		if (player.GetPlayerClass() == TF_CLASS_DEMOMAN)
		// 			footstepsound = format("^mvm/giant_demoman/giant_demoman_step_0%d.wav", RandomInt(1, 4))

		// 		else if (player.GetPlayerClass() == TF_CLASS_SOLDIER || player.GetPlayerClass() == TF_CLASS_HEAVYWEAPONS)
		// 			footstepsound = format("^mvm/giant_%s/giant_%s_step0%d.wav", cstring, cstring, RandomInt(1, 4))

		// 		PrecacheSound(footstepsound)
		// 		player.EmitSound(footstepsound)

		// 		scope.stepside = (GetPropInt(player, "m_Local.m_nStepside"))
		// 	}
		// }

		// Doesn't fully work correctly, need to investigate
		function EngineerBuildingPushbackFix(params) {
			local player = GetPlayerFromUserID(params.userid)
			// if (player.IsBotOfType(TF_BOT_TYPE)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			// 400, 500 (range, force)
			local epsilon = 20.0

			local blastjump_weapons = {
				"tf_weapon_rocketlauncher" : null
				"tf_weapon_rocketlauncher_directhit" : null
				"tf_weapon_rocketlauncher_airstrike" : null
			}

			scope.lastvelocity <- player.GetAbsVelocity()
			scope.nextthink <- -1
			scope.PlayerThinkTable.EngineerBuildingPushbackFix <- function() {
				if (scope.nextthink > -1 && Time() < scope.nextthink) return

				if (!PopExtUtil.IsAlive(self)) return

				local velocity = self.GetAbsVelocity()

				local wep       = self.GetActiveWeapon()
				local classname = (wep != null) ? wep.GetClassname() : ""
				local lastfire  = GetPropFloat(wep, "m_flLastFireTime")

				// We might have been pushed by an engineer building something, lets double check
				if( fabs((scope.lastvelocity - velocity).Length() - 700) < epsilon) {
					// Blast jumping can generate this type of velocity change in a frame, lets check for that
					if (self.InCond(TF_COND_BLASTJUMPING) && classname in blastjump_weapons && (Time() - lastfire < 0.1))
						return

					// Even with the above check, some things still sneak through so lets continue filtering

					// Look around us to see if there's a building hint and bot engineer within range
					local origin   = self.GetOrigin()
					local engie    = null
					local hint     = null

					for (local player; player = Entities.FindByClassnameWithin(player, "player", origin, 650);) {
						if (!player.IsBotOfType(TF_BOT_TYPE) || player.GetPlayerClass() != TF_CLASS_ENGINEER) continue

						engie = player
						break
					}

					if (engie != null)
						hint = Entities.FindByClassnameWithin(null, "bot_hint_*", engie.GetOrigin(), 200)

					// Counteract impulse velocity
					if (hint != null && engie != null) {
						// ClientPrint(null, 3, "COUNTERACTING VELOCITY")
						local dir =  self.EyePosition() - hint.GetOrigin()

						dir.z = 0
						dir.Norm()
						dir.z = 1

						local push = dir * 500
						self.SetAbsVelocity(velocity - push)

						nextthink = Time() + 1
					}
				}

				lastvelocity = velocity
			}
		}
	}

	Events = {

		function OnScriptHook_OnTakeDamage(params) { foreach(_, func in GlobalFixes.TakeDamageTable) func(params) }
		function OnGameEvent_player_death(params) { foreach(_, func in GlobalFixes.DeathHookTable) func(params) }
		function OnGameEvent_player_disconnect(params) { foreach(_, func in GlobalFixes.DisconnectTable) func(params) }
		// Hook all wave inits to reset parsing error counter.

		function OnGameEvent_recalculate_holidays(params) {
			if (GetRoundState() != 3) return

			foreach(_, func in GlobalFixes.InitWaveTable) func(params)
		}

		function GameEvent_mvm_wave_complete(params) { delete GlobalFixes }
	}
}
__CollectGameEventCallbacks(GlobalFixes.Events)

GlobalFixesEntity.ValidateScriptScope()

GlobalFixesEntity.GetScriptScope().GlobalFixesThink <- function() {
	foreach(_, func in GlobalFixes.ThinkTable) func()
	return -1
}

AddThinkToEnt(GlobalFixesEntity, "GlobalFixesThink")
