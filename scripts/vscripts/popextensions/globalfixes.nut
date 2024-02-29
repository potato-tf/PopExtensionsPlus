const SCOUT_MONEY_COLLECTION_RADIUS = 288
const HUNTSMAN_DAMAGE_FIX_MOD       = 1.263157
const EFL_USER = 1048576
local GlobalFixesEntity = FindByName(null, "popext_globalfixes_ent")
if (GlobalFixesEntity == null) GlobalFixesEntity = SpawnEntityFromTable("info_teleport_destination", { targetname = "popext_globalfixes_ent" })

::GlobalFixes <- {
	InitWaveTable = {}
	TakeDamageTable = {

		function YERDisguiseFix(params) {
			local victim   = params.const_entity
			local attacker = params.inflictor

			if ( victim.IsPlayer() && params.damage_custom == TF_DMG_CUSTOM_BACKSTAB && attacker != null && !attacker.IsBotOfType(1337) ) {
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
			if (victim != null && victim.IsBotOfType(1337)) {
				victim.Taunt(TAUNT_MISC_ITEM, MP_CONCEPT_TAUNT_LAUGH)

				local tfclass      = victim.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]
				local botmodel     = format("models/bots/%s/bot_%s.mdl", class_string, class_string)

				victim.SetCustomModelWithClassAnimations(format("models/player/%s.mdl", class_string))

				PopExtUtil.PlayerRobotModel(player, botmodel)

				//overwrite the existing bot model think to remove it after taunt
				function BotModelThink() {

					if (Time() > victim.GetTauntRemoveTime()) {
						if (wearable != null) wearable.Destroy()

						SetPropInt(self, "m_clrRender", 0xFFFFFF)
						SetPropInt(self, "m_nRenderMode", 0)
						self.SetCustomModelWithClassAnimations(botmodel)

						SetPropString(self, "m_iszScriptThinkFunction", "")
					}

					return -1
				}
				AddThinkToEnt(victim, "Think")
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
		function ProjectileThink() {
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");) {
				if (projectile.GetEFlags() & EFL_USER) continue

				projectile.ValidateScriptScope()
				local scope = projectile.GetScriptScope()

				if (!("ProjectileThinkTable" in scope)) scope.ProjectileThinkTable <- {}

				projectile.AddEFlags(EFL_USER)
			}
		}
	}

	DeathHookTable = {
		function NoCreditVelocity(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (!player.IsBotOfType(1337)) return

			for (local money; money = FindByClassname(money, "item_currencypack*");)
				money.SetAbsVelocity(Vector())
		}
	}

	SpawnHookTable = {

		function ScoutBetterMoneyCollection(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337) || player.GetPlayerClass() != TF_CLASS_SCOUT) return

			function MoneyThink() {
				if (player.GetPlayerClass() != TF_CLASS_SCOUT) {
					delete player.GetScriptScope().PopExtPlayerScope.PlayerThinkTable.MoneyThink
					return
				}
				local origin = player.GetOrigin()
				for (local money; money = FindByClassnameWithin(money, "item_currencypack*", player.GetOrigin(), SCOUT_MONEY_COLLECTION_RADIUS);)
					money.SetOrigin(origin)
			}
			player.GetScriptScope().PopExtPlayerScope.PlayerThinkTable.MoneyThink <- MoneyThink
		}

		function RemoveYERAttribute(params) {

			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			local wep   = PopExtUtil.GetItemInSlot(player, SLOT_MELEE)
			local index = PopExtUtil.GetItemIndex(wep)

			if (index == ID_YOUR_ETERNAL_REWARD || index == ID_WANGA_PRICK)
				wep.RemoveAttribute("disguise on backstab")
		}

		function HoldFireUntilFullReloadFix(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(1337)) return

			local scope = player.GetScriptScope().PopExtPlayerScope
			scope.holdingfire <- false

			function HoldFireThink() {

				if (!player.HasBotAttribute(HOLD_FIRE_UNTIL_FULL_RELOAD)) return

				local activegun = player.GetActiveWeapon()

				if (activegun.Clip1() == 0)
				{
					player.AddBotAttribute(SUPPRESS_FIRE)
					scope.holdingfire = true
					return -1
				}

				else if (activegun.Clip1() == activegun.GetMaxClip1() && scope.holdingfire)
				{
					player.RemoveBotAttribute(SUPPRESS_FIRE)
					scope.holdingfire = false
					return -1
				}
			}

			player.GetScriptScope().PopExtPlayerScope.PlayerThinkTable.HoldFireThink <- HoldFireThink
		}
	}

	Events = {

		function OnScriptHook_OnTakeDamage(params) { foreach(_, func in GlobalFixes.TakeDamageTable) func(params) }
		// function OnGameEvent_player_spawn(params) { foreach (_, func in GlobalFixes.SpawnHookTable) func(params) }
		function OnGameEvent_player_death(params) { foreach(_, func in GlobalFixes.DeathHookTable) func(params) }
		function OnGameEvent_player_disconnect(params) { foreach(_, func in GlobalFixes.DisconnectTable) func(params) }

		function OnGameEvent_post_inventory_application(params) {
			local player = GetPlayerFromUserID(params.userid)
			player.ValidateScriptScope()
			if (!("PopExtPlayerScope" in player.GetScriptScope()))
			{
				local PopExtPlayerScope = {
					PlayerThinkTable = {}
					TakeDamageTable = {}
					DeathHookTable = {}
				}
				GetPlayerFromUserID(params.userid).GetScriptScope().PopExtPlayerScope <- PopExtPlayerScope
			}
			local scope = player.GetScriptScope().PopExtPlayerScope
			foreach(k, v in scope)
				printl(k+ " : " + v)
			function PlayerThinks() {

				foreach (name, func in scope.PlayerThinkTable) { printl(name); func(); return -1 }
			}

			if (!("PlayerThinks" in scope)) {
				scope.PlayerThinks <- PlayerThinks
				AddThinkToEnt(player, "PlayerThinks")
			}

			foreach(_, func in GlobalFixes.SpawnHookTable) func(params)

		}
		// Hook all wave inits to reset parsing error counter.

		function OnGameEvent_recalculate_holidays(params) {
			if (GetRoundState() != 3) return

			foreach(_, func in GlobalFixes.InitWaveTable) func(params)
		}

		function GameEvent_mvm_wave_complete(params) { delete GlobalFixes }
	}
}
__CollectGameEventCallbacks(GlobalFixes.Events)

function GlobalFixesThink() {
	foreach(_, func in GlobalFixes.ThinkTable) func()
	return -1
}

GlobalFixesEntity.ValidateScriptScope()
GlobalFixesEntity.GetScriptScope().GlobalFixesThink <- GlobalFixesThink
AddThinkToEnt(GlobalFixesEntity, "GlobalFixesThink")
