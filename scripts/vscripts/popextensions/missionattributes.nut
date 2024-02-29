::MissionAttributes <- {

	CurAttrs = {} // Array storing currently modified attributes.
	ConVars  = {} //table storing original convar values

	ThinkTable      = {}
	TakeDamageTable = {}
	SpawnHookTable  = {}
	DeathHookTable  = {}
	// InitWaveTable = {}
	DisconnectTable = {}

	DebugText        = false
	RaisedParseError = false

	PathNum = 0

	// function InitWave() {
	// 	foreach (_, func in MissionAttributes.InitWaveTable) func()

	// 	foreach (attr, value in MissionAttributes.CurAttrs) printl(attr+" = "+value)
	// 	MissionAttributes.RaisedParseError = false
	// }

	Events = {

		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in MissionAttributes.TakeDamageTable) func(params) }
		// function OnGameEvent_player_spawn(params) { foreach (_, func in MissionAttributes.SpawnHookTable) func(params) }
		function OnGameEvent_player_death(params) { foreach (_, func in MissionAttributes.DeathHookTable) func(params) }
		function OnGameEvent_player_disconnect(params) { foreach (_, func in MissionAttributes.DisconnectTable) func(params) }

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
				player.GetScriptScope().PopExtPlayerScope <- PopExtPlayerScope
			}
			local scope = player.GetScriptScope().PopExtPlayerScope
			foreach(k, v in scope.PlayerThinkTable)
				printl(k+ " : " + v)
			function PlayerThinks() {

				foreach (name, func in scope.PlayerThinkTable) { printl(name); func(); return -1 }
			}

			if (!("PlayerThinks" in scope)) {
				scope.PlayerThinks <- PlayerThinks
				AddThinkToEnt(player, "PlayerThinks")
			}
			local scope = player.GetScriptScope().PopExtPlayerScope

			foreach (_, func in MissionAttributes.SpawnHookTable) func(params)
		}
		// Hook all wave inits to reset parsing error counter.

		function OnGameEvent_recalculate_holidays(params) {

			if (GetRoundState() != GR_STATE_PREROUND) return

			MissionAttributes.ResetConvars()
			MissionAttributes.PathNum = 0

			MissionAttributes.DebugLog(format("Cleaned up mission attributes"))
		}

		function OnGameEvent_mvm_wave_complete(params) {

			MissionAttributes.ResetConvars()
			MissionAttributes.PathNum = 0

			MissionAttributes.DebugLog(format("Cleaned up mission attributes"))
		}

		function OnGameEvent_mvm_mission_complete(params) {

			MissionAttributes.ResetConvars()
			if (FindByName(null, "popext_missionattr_ent") != null) MissionAttrEntity.Kill()
			delete ::MissionAttributes
		}
	}
};
__CollectGameEventCallbacks(MissionAttributes.Events);

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

local MissionAttrEntity = FindByName(null, "popext_missionattr_ent")
if (MissionAttrEntity == null) MissionAttrEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_missionattr_ent"});

function MissionAttributes::SetConvar(convar, value, hideChatMessage = true) {

	local commentaryNode = Entities.FindByClassname(null, "point_commentary_node")
	if (commentaryNode == null && hideChatMessage) commentaryNode = SpawnEntityFromTable("point_commentary_node", {})

	//save original values to restore later
	if (!(convar in MissionAttributes.ConVars)) MissionAttributes.ConVars[convar] <- Convars.GetStr(convar);

	if (Convars.GetStr(convar) != value) Convars.SetValue(convar, value)

	EntFireByHandle(commentaryNode, "Kill", "", 1.1, null, null)
}

function MissionAttributes::ResetConvars(hideChatMessage = true) {

	local commentaryNode = Entities.FindByClassname(null, "point_commentary_node")

	foreach (convar, value in MissionAttributes.ConVars) Convars.SetValue(convar, value)
	MissionAttributes.ConVars.clear()

	EntFireByHandle(commentaryNode, "Kill", "", 1.1, null, null)
}

local noromecarrier = false
function MissionAttributes::MissionAttr(attr, value = 0) {
	local success = true
	switch(attr) {

	// =========================================================
	case "ForceHoliday":
		// Replicates sigsegv-mvm: ForceHoliday.
		// Forces a tf_holiday for the mission.
		// Supported Holidays are:
		//	0 - None
		//	1 - Birthday
		//	2 - Halloween
		//	3 - Christmas
		// @param Holiday		Holiday number to force.
		// @error TypeError		If type is not an integer.
		// @error IndexError	If invalid holiday number is passed.
			// Error Handling
		try (value.tointeger()) catch(_) {RaiseTypeError(attr, "int"); success = false; break}
		if (type(value) != "integer") {RaiseTypeError(attr, "int"); success = false; break}
		if (value < 0 || value > 11) {RaiseIndexError(attr, [0, 11]); success = false; break}

		// Set Holiday logic
		SetConvar("tf_forced_holiday", value)
		if (value == 0) break

		local ent = Entities.FindByName(null, "MissionAttrHoliday");
		if (ent != null) ent.Kill();

		SpawnEntityFromTable("tf_logic_holiday", {
			targetname   = "MissionAttrHoliday",
			holiday_type = value
		});

	break

	// ========================================================

	case "RedBotsNoRandomCrit":
		function MissionAttributes::RedBotsNoRandomCrit(params)
		{
			local player = GetPlayerFromUserID(params.userid)
			if (!player.IsBotOfType(1337) && player.GetTeam() != TF_TEAM_PVE_DEFENDERS) return

			PopExtUtil.AddAttributeToLoadout(player, "crit mod disabled hidden", 0)
		}
		MissionAttributes.SpawnHookTable.RedBotsNoRandomCrit <- MissionAttributes.RedBotsNoRandomCrit

	// ========================================================

	case "NoCrumpkins":
		local pumpkinIndex = PrecacheModel("models/props_halloween/pumpkin_loot.mdl");
		function MissionAttributes::NoCrumpkins() {
			switch(value) {
			case 1:
				for (local pumpkin; pumpkin = Entities.FindByClassname(pumpkin, "tf_ammo_pack");)
					if (GetPropInt(pumpkin, "m_nModelIndex") == pumpkinIndex)
						EntFireByHandle(pumpkin, "Kill", "", -1, null, null) //should't do .Kill() in the loop, entfire kill is delayed to the end of the frame.
			}

			for (local i = 1, player; i <= MaxClients(); i++)
				if (player = PlayerInstanceFromIndex(i), player && player.InCond(TF_COND_CRITBOOSTED_PUMPKIN)) //TF_COND_CRITBOOSTED_PUMPKIN
					EntFireByHandle(player, "RunScriptCode", "self.RemoveCond(TF_COND_CRITBOOSTED_PUMPKIN)", -1, null, null)
		}

		MissionAttributes.ThinkTable.NoCrumpkins <- MissionAttributes.NoCrumpkins
	break

	// =========================================================

	case "NoReanimators":
		if (value < 1) return

		function MissionAttributes::NoReanimators(params) {
			for (local revivemarker; revivemarker = Entities.FindByClassname(revivemarker, "entity_revive_marker");)
				EntFireByHandle(revivemarker, "Kill", "", -1, null, null)
		}

		MissionAttributes.DeathHookTable.NoReanimators <- MissionAttributes.NoReanimators
	break

	// =========================================================

	case "StandableHeads":
		local movekeys = IN_FORWARD | IN_BACK | IN_LEFT | IN_RIGHT
		function MissionAttributes::StandableHeads(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			function StandableHeads() {
				local groundent = GetPropEntity(player, "m_hGroundEntity")

				if (!groundent || !groundent.IsPlayer() || PopExtUtil.InButton(player, movekeys)) return
				player.SetAbsVelocity(Vector())
			}
			player.GetScriptScope().PopExtPlayerScope.PlayerThinkTable.StandableHeads <- StandableHeads
		}
		MissionAttributes.SpawnHookTable.StandableHeads <- MissionAttributes.StandableHeads
	break

	// =========================================================

	case "666Wavebar": //doesn't work until wave switches, won't work on W1
		SetPropInt(PopExtUtil.ObjectiveResource, "m_nMvMEventPopfileType", value)
	break

	// =========================================================

	case "WaveNum":
		SetPropInt(PopExtUtil.ObjectiveResource, "m_nMannVsMachineWaveCount", value)
	break

	// =========================================================

	case "MaxWaveNum":
		SetPropInt(PopExtUtil.ObjectiveResource, "m_nMannVsMachineMaxWaveCount", value)
	break

	// =========================================================

	case "MultiSapper":
		function MissionAttributes::MultiSapper(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337) || player.GetPlayerClass() < TF_CLASS_SPY) return

			function MultiSapper(params) {
				if (params.object != OBJ_ATTACHMENT_SAPPER) return
				local sapper = EntIndexToHScript(params.index)
				SetPropBool(sapper, "m_bDisposableBuilding", true)
				local flags = GetPropInt(sapper, "m_fObjectFlags")
				printl(flags)
				SetPropInt(sapper, "m_fObjectFlags", flags | OF_ALLOW_REPEAT_PLACEMENT)
				printl(flags)
			}
			player.GetScriptScope().PopExtPlayerScope.BuiltObjectTable.MultiSapper <- MultiSapper
		}
		MissionAttributes.SpawnHookTable.MultiSapper <- MissionAttributes.MultiSapper
	break

	// =========================================================

	//all of these could just be set directly in the pop easily, however popfile's have a 4096 character limit for vscript so might as well save space
	case "NoRefunds":
		SetConvar("tf_mvm_respec_enabled", 0);
	break

	// =========================================================

	case "RefundLimit":
		SetConvar("tf_mvm_respec_enabled", 1)
		SetConvar("tf_mvm_respec_limit", value)
	break

	// =========================================================

	case "RefundGoal":
		SetConvar("tf_mvm_respec_enabled", 1)
		SetConvar("tf_mvm_respec_credit_goal", value)
	break

	// =========================================================

	case "FixedBuybacks":
		SetConvar("tf_mvm_buybacks_method", 1)
	break

	// =========================================================

	case "BuybacksPerWave":
		SetConvar("tf_mvm_buybacks_per_wave", value)
	break

	// =========================================================

	case "NoBuybacks":
		SetConvar("tf_mvm_buybacks_method", value)
		SetConvar("tf_mvm_buybacks_per_wave", 0)
	break

	// =========================================================

	case "DeathPenalty":
		SetConvar("tf_mvm_death_penalty", value)
	break

	// =========================================================

	case "BonusRatioHalf":
		SetConvar("tf_mvm_currency_bonus_ratio_min", value)
	break

	// =========================================================

	case "BonusRatioFull":
		SetConvar("tf_mvm_currency_bonus_ratio_max", value)
	break

	// =========================================================

	case "UpgradeFile":
		DoEntFire("tf_gamerules", "SetCustomUpgradesFile", value, -1, null, null);
	break

	// =========================================================

	case "FlagEscortCount":
		SetConvar("tf_bot_flag_escort_max_count", value)
	break

	// =========================================================

	case "BombMovementPenalty":
		SetConvar("tf_mvm_bot_flag_carrier_movement_penalty", value)
	break

	// =========================================================

	case "MaxSkeletons":
		SetConvar("tf_max_active_zombie", value)
	break

	// =========================================================

	case "TurboPhysics":
		SetConvar("sv_turbophysics", value)
	break

	// =========================================================

	case "Accelerate":
		SetConvar("sv_accelerate", value)
	break

	// =========================================================

	case "AirAccelerate":
		SetConvar("sv_airaccelerate", value)
	break

	// =========================================================

	case "BotPushaway":
		SetConvar("tf_avoidteammates_pushaway", value)
	break

	// =========================================================

	case "TeleUberDuration":
		SetConvar("tf_mvm_engineer_teleporter_uber_duration", value)
	break

	// =========================================================

	case "RedMaxPlayers":
		SetConvar("tf_mvm_defenders_team_size", value)
	break

	// =========================================================

	case "MaxVelocity":
		SetConvar("sv_maxvelocity", value)
	break

	// =========================================================

	case "ConchHealthOnHitRegen":
		SetConvar("tf_dev_health_on_damage_recover_percentage", value)
	break

	// =========================================================

	case "MarkForDeathLifetime":
		SetConvar("tf_dev_marked_for_death_lifetime", value)
	break

	// =========================================================

	case "VacNumCharges":
		SetConvar("weapon_medigun_resist_num_chunks", value)
	break

	// =========================================================

	case "DoubleDonkWindow":
		SetConvar("tf_double_donk_window", value)
	break

	// =========================================================

	case "ConchSpeedBoost":
		SetConvar("tf_whip_speed_increase", value)
	break

	// =========================================================

	case "StealthDmgReduction":
		SetConvar("tf_stealth_damage_reduction", value)
	break

	// =========================================================

	case "FlagCarrierCanFight":
		SetConvar("tf_mvm_bot_allow_flag_carrier_to_fight", value)
	break

	// =========================================================

	case "HHHChaseRange":
		SetConvar("tf_halloween_bot_chase_range", value)
	break

	// =========================================================

	case "HHHAttackRange":
		SetConvar("tf_halloween_bot_attack_range", value)
	break

	// =========================================================

	case "HHHQuitRange":
		SetConvar("tf_halloween_bot_quit_range", value)
	break

	// =========================================================

	case "HHHTerrifyRange":
		SetConvar("tf_halloween_bot_terrify_radius", value)
	break

	// =========================================================

	case "HHHHealthBase":
		SetConvar("tf_halloween_bot_health_base", value)
	break

	// =========================================================

	case "HHHHealthPerPlayer":
		SetConvar("tf_halloween_bot_health_per_player", value)
	break

	// =========================================================

	case "SentryHintBombForwardRange":
		SetConvar("tf_bot_engineer_mvm_sentry_hint_bomb_forward_range", value)
	break

	// =========================================================

	case "SentryHintBombBackwardRange":
		SetConvar("tf_bot_engineer_mvm_sentry_hint_bomb_backward_range", value)
	break

	// =========================================================

	case "SentryHintMinDistanceFromBomb":
		SetConvar("tf_bot_engineer_mvm_hint_min_distance_from_bomb", value)
	break

	// =========================================================

	case "NoBusterFF":
		if (value != 1 || value != 0 ) RaiseIndexError(attr)
		SetConvar("tf_bot_suicide_bomb_friendly_fire", value = 1 ? 0 : 1)
	break

	// =========================================================

	case "SniperHideLasers":
		if (value < 1) return

		function MissionAttributes::SniperHideLasers() {
			for (local dot; dot = Entities.FindByClassname(dot, "env_sniperdot");)
				if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
					EntFireByHandle(dot, "Kill", "", -1, null, null)

			return -1;
		}

		MissionAttributes.ThinkTable.SniperHideLasers <- MissionAttributes.SniperHideLasers
	break

	// =========================================================

	case "BotHeadshots":
		if (value < 1) return

		function MissionAttributes::BotHeadshots(params) {
			local player = params.attacker, victim = params.const_entity

			// //gib bots on explosive/crit dmg, doesn't work
			// if (!victim.IsMiniBoss() && (params.damage_type & DMG_CRITICAL || params.damage_type & DMG_BLAST))
			// {
			//	victim.SetModelScale(1.00000001, 0.0);
			//	// EntFireByHandle(victim, "CallScriptFunction", "dmg", -1, null, null); //wait 1 frame
			//	return
			// }

			//re-enable headshots for snipers and ambassador
			if (!player.IsPlayer() || !victim.IsPlayer() || IsPlayerABot(player)) return //check if non-bot victim
			if (player.GetPlayerClass() != TF_CLASS_SPY && player.GetPlayerClass() != TF_CLASS_SNIPER) return //check if we're spy/sniper
			if (GetPropInt(victim, "m_LastHitGroup") != HITGROUP_HEAD) return //check for headshot
			if (player.GetPlayerClass() == TF_CLASS_SNIPER && (player.GetActiveWeapon().GetSlot() == SLOT_SECONDARY || GetItemIndex(player.GetActiveWeapon()) == ID_SYDNEY_SLEEPER)) return //ignore sydney sleeper and SMGs
			if (player.GetPlayerClass() == TF_CLASS_SPY && GetItemIndex(player.GetActiveWeapon()) != ID_AMBASSADOR) return //ambassador only
			params.damage_type | (DMG_USE_HITLOCATIONS | DMG_CRITICAL) //DMG_USE_HITLOCATIONS doesn't actually work here, no headshot icon.
			return true
		}

		MissionAttributes.TakeDamageTable.BotHeadshots <- MissionAttributes.BotHeadshots
	break

	// =========================================================

	//Uses bitflags to enable certain behavior
	// 1  = Robot animations (excluding sticky demo and jetpack pyro)
	// 2  = Human animations
	// 4  = Enable footstep sfx
	// 8  = Enable voicelines (WIP)
	// 16 = Enable viewmodels (WIP)

	//example: MissionAttr(`PlayersAreRobots`, 6) - Human animations and footsteps enabled
	//example: MissionAttr(`PlayersAreRobots`, 2 | 4) - Same thing if you are lazy

	// TODO: Make PlayersAreRobots 16 and HandModelOverride incompatible

	case "PlayersAreRobots":
		function MissionAttributes::PlayersAreRobots(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope().PopExtPlayerScope

			if ("wearable" in scope && scope.wearable != null) {
				scope.wearable.Destroy()
				scope.wearable <- null
			}

			local playerclass  = player.GetPlayerClass()
			local class_string = PopExtUtil.Classes[playerclass]
			local model = format("models/bots/%s/bot_%s.mdl", class_string, class_string)

			if (value & 1) {
				//sticky anims and thruster anims are particularly problematic
				if ((playerclass == TF_CLASS_DEMOMAN && PopExtUtil.GetItemInSlot(player, SLOT_SECONDARY).GetClassname() == "tf_weapon_pipebomblauncher") || (playerclass == TF_CLASS_PYRO && PopExtUtil.HasItemIndex(player, ID_THERMAL_THRUSTER))) {
					PopExtUtil.PlayerRobotModel(player, model)
					return
				}

				EntFireByHandle(player, "SetCustomModelWithClassAnimations", model, 1, null, null)
				PopExtUtil.SetEntityColor(player, 255, 255, 255, 255)
				SetPropInt(player, "m_nRenderMode", kRenderFxNone) //dangerous constant name lol
			}

			if (value & 2) {
				if (value & 1) value | 1 //incompatible flags
				PopExtUtil.PlayerRobotModel(player, model)
			}

			if (value & 4) {
				scope.stepside <- GetPropInt(player, "m_Local.m_nStepside")

				function StepThink() {
					if (self.GetPlayerClass() == TF_CLASS_MEDIC) return

					if (GetPropInt(self,"m_Local.m_nStepside") != stepside)
						EmitSoundOn("MVM.BotStep", self)

					scope.stepside = GetPropInt(self,"m_Local.m_nStepside")
					return -1
				}
				if (!("StepThink" in scope.PlayerThinkTable))
					scope.PlayerThinkTable.StepThink <- StepThink


			} else if ("StepThink" in scope.PlayerThinkTable) delete scope.PlayerThinkTable.StepThink

			if (value & 8) {
				function RobotVOThink() {
					for (local ent; ent = Entities.FindByClassname(ent, "instanced_scripted_scene"); ) {
						if (ent.GetEFlags() & EFL_IS_BEING_LIFTED_BY_BARNACLE) continue
						ent.AddEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)

						local owner = GetPropEntity(ent, "m_hOwner")
						if (owner != null && !owner.IsBotOfType(1337)) {

							local vcdpath = GetPropString(ent, "m_szInstanceFilename");
							if (!vcdpath || vcdpath == "") return -1

							local dotindex	 = vcdpath.find(".")
							local slashindex = null;
							for (local i = dotindex; i >= 0; --i) {
								if (vcdpath[i] == '/' || vcdpath[i] == '\\') {
									slashindex = i
									break
								}
							}

							owner.ValidateScriptScope()
							local scope = owner.GetScriptScope()
							scope.soundtable <- VCD_SOUNDSCRIPT_MAP[owner.GetPlayerClass()]
							scope.vcdname	 <- vcdpath.slice(slashindex+1, dotindex)

							if (scope.vcdname in scope.soundtable) {
								local soundscript = scope.soundtable[scope.vcdname];
								if (typeof soundscript == "string")
									PopExtUtil.StopAndPlayMVMSound(owner, soundscript, 0);
								else if (typeof soundscript == "array")
									foreach (sound in soundscript)
										PopExtUtil.StopAndPlayMVMSound(owner, sound[1], sound[0]);
							}
						}
					}

					return -1;
				}

				if (!("RobotVOThink" in MissionAttributes.ThinkTable))
					MissionAttributes.ThinkTable.RobotVOThink <- RobotVOThink

			} else if ("RobotVOThink" in scope.PlayerThinkTable) delete scope.PlayerThinkTable.RobotVOThink

			if (value & 16) {
				function RobotArmThink() {
					local vmodel   = PopExtUtil.ROBOT_ARM_PATHS[player.GetPlayerClass()]
					local playervm = GetPropEntity(player, "m_hViewModel")
					if (playervm.GetModelName() != vmodel) playervm.SetModelSimple(vmodel)

					for (local i = 0; i < SLOT_COUNT; i++) {
						local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
						if (wep == null || (wep.GetModelName() == vmodel)) continue

						wep.SetModelSimple(vmodel)
						wep.SetCustomViewModel(vmodel)
					}
				}

				if (!("RobotArmThink" in scope.PlayerThinkTable))
					scope.PlayerThinkTable.RobotArmThink <- RobotArmThink

			} else if ("RobotArmThink" in scope.PlayerThinkTable) delete scope.PlayerThinkTable.RobotArmThink
		}

		MissionAttributes.SpawnHookTable.PlayersAreRobots <- MissionAttributes.PlayersAreRobots
	break

	// =========================================================
	case "Testing":
		PrecacheScriptSound("MVM.MoneyPickup")
		// Find suitable spot to spawn our IRS wannabe entity
		for ( local ent; ent = Entities.FindByClassname(ent, "info_player_teamspawn"); )
		{
			if (ent.GetTeam() != TF_TEAM_RED) continue

			local area = NavMesh.GetNavArea(ent.GetOrigin(), 128)
			if (area == null)
			{
				// Just get the first one we iterate on
				foreach(str, handle in PopExtUtil.AllNavAreas)
					area = handle
					break
			}

			local trigger_hurt = SpawnEntityFromTable("trigger_hurt", {
				name = "_money_collector"
				damage = 5
				origin = area.GetCenter()
			});

			trigger_hurt.SetSolid(2)
			trigger_hurt.SetSize(Vector(-32, -32, -32), Vector(32, 32, 32))
			//trigger_hurt.SetAbsOrigin(Vector(-1500, 4200, 500))
			//trigger_hurt.SetSize(Vector(-128, -128, -1000), Vector(128, 128, 1000))

			break
		}

		function MissionAttributes::Testing()
		{
			for ( local ent; ent = Entities.FindByClassname(ent, "item_currencypack_custom"); )
			{
				if (ent.GetEFlags() & EFL_USER) continue
				ent.AddEFlags(EFL_USER)

				local origin = ent.GetOrigin()
				ent.SetAbsOrigin(Vector(-1500, 4200, 500)) // testing

				local pickup = SpawnEntityFromTable("tf_halloween_pickup", {
					pickup_sound = "MVM.MoneyPickup"
					pickup_particle = ""
				})

				pickup.SetModelSimple("models/items/currencypack_medium.mdl")

				local trace = {
					start = origin
					end   = origin + Vector(0, 0, -16384)
					mask  = 16395 // MASK_SOLID_BRUSHONLY
				}
				if (TraceLineEx(trace))
					pickup.SetAbsOrigin(trace.pos + Vector(0, 0, 16))
				else
					pickup.SetAbsOrigin(origin)

				pickup.ValidateScriptScope()
				local pscope = pickup.GetScriptScope()

				pscope.currency_entity <- ent
				pscope.Think <- function() {
					// Need to implement blinking at 25s + particle effect(s)
					if (currency_entity == null || !currency_entity.IsValid())
					{
						self.Destroy()
						return -1
					}
					for ( local ent; ent = Entities.FindByClassnameWithin(ent, "player", pickup.GetOrigin(), 64); )
					{
						if (ent == null || ent.GetTeam() != TF_TEAM_BLUE || ent.IsBotOfType(1337)) continue

						currency_entity.GetScriptScope().should_delay_collection <- false
						self.EmitSound("MVM.MoneyPickup")
						self.Destroy()

						return -1
					}
					return -1
				}
				AddThinkToEnt(pickup, "Think")

				ent.ValidateScriptScope()
				local scope = ent.GetScriptScope()

				scope.should_delay_collection <- true
				scope.Think <- function() {
					self.SetAbsVelocity(Vector())
					if (should_delay_collection)
					{
						//self.SetAbsOrigin(trigger_hurt.GetOrigin() + Vector(0, 0, 128))
					}
					else
					{
						printl("DONE DELAYING");
						//self.SetAbsOrigin(trigger_hurt.GetOrigin() + Vector(0, 0, 8))
						NetProps.SetPropString(self, "m_iszScriptThinkFunction", "")
					}
					return -1
				}
				AddThinkToEnt(ent, "Think")
			}
		}

		MissionAttributes.ThinkTable.Testing <- MissionAttributes.Testing
	break
	// =========================================================

		//Uses bitflags to change behavior:
		// 1 = Blu bots use human models.
		// 2 = Blu bots use zombie models. Overrides human models.
		// 4 = Red bots use human models.
		// 4 = Red bots use zombie models. Overrides human models.

		case "BotsAreHumans":
			function MissionAttributes::BotsAreHumans(params)
			{
				local player = GetPlayerFromUserID(params.userid)
				if (!player.IsBotOfType(1337)) return

				if (player.GetTeam() == TF_TEAM_PVE_INVADERS && value & 1)
				{
					EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", classes[player.GetPlayerClass()]), -1, null, null)
					if (value & 2) activator.GenerateAndWearItem(format("Zombie %s",classes[player.GetPlayerClass()]))
				}

				if (player.GetTeam() == TF_TEAM_PVE_DEFENDERS && value & 4)
				{
					EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", classes[player.GetPlayerClass()]), -1, null, null)
					if (value & 8) activator.GenerateAndWearItem(format("Zombie %s",classes[player.GetPlayerClass()]))
				}
			}

				MissionAttributes.SpawnHookTable.BotsAreHumans <- MissionAttributes.BotsAreHumans
		break

	// =========================================================

	case "NoRome":
		local carrierPartsIndex = GetModelIndex("models/bots/boss_bot/carrier_parts.mdl")

		function MissionAttributes::NoRome(params) {

			local bot = GetPlayerFromUserID(params.userid)

			EntFireByHandle(bot, "RunScriptCode", @"
				if (self.IsBotOfType(1337))
					// if (!self.HasBotTag(`popext_forceromevision`)) //handle these elsewhere
						for (local child = self.FirstMoveChild(); child != null; child = child.NextMovePeer())
							if (child.GetClassname() == `tf_wearable` && startswith(child.GetModelName(), `models/workshop/player/items/`+PopExtUtil.Classes[self.GetPlayerClass()]+`/tw`))
								EntFireByHandle(child, `Kill`, ``, -1, null, null)
			", -1, null, null)

			//set value to 2 to also un-rome the carrier tank
			if (value < 2 || noromecarrier) return

			local carrier = Entities.FindByName(null, "botship_dynamic") //some maps have a targetname for it

			if (carrier == null) {
				for (local props; props = Entities.FindByClassname(props, "prop_dynamic");) {
					if (GetPropInt(props, "m_nModelIndex") != carrierPartsIndex) continue

					carrier = props
					break
				}

			}
			SetPropIntArray(carrier, "m_nModelIndexOverrides", carrierPartsIndex, 3)
			noromecarrier = true
		}

		MissionAttributes.SpawnHookTable.NoRome <- MissionAttributes.NoRome
	break

	// =========================================================

	case "SpellRateCommon":
		SetConvar("tf_spells_enabled", 1)
		function MissionAttributes::SpellRateCommon(params) {
			if (RandomFloat(0, 1) > value) return

			local bot = GetPlayerFromUserID(params.userid)
			if (!bot.IsBotOfType(1337) || bot.IsMiniBoss()) return

			local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_commonspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" })
		}

		MissionAttributes.DeathHookTable.SpellRateCommon <- MissionAttributes.SpellRateCommon
	break

	// =========================================================

	case "SpellRateGiant":
		SetConvar("tf_spells_enabled", 1)
		function MissionAttributes::SpellRateGiant(params) {
			if (RandomFloat(0, 1) > value) return

			local bot = GetPlayerFromUserID(params.userid)
			if (!bot.IsBotOfType(1337) || !bot.IsMiniBoss()) return

			local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_giantspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" })
		}

		MissionAttributes.DeathHookTable.SpellRateGiant <- MissionAttributes.SpellRateGiant
	break

	// =========================================================

	case "RareSpellRateCommon":
		SetConvar("tf_spells_enabled", 1)
		function MissionAttributes::RareSpellRateCommon(params) {
			if (RandomFloat(0, 1) > value) return

			local bot = GetPlayerFromUserID(params.userid)
			if (!bot.IsBotOfType(1337) || bot.IsMiniBoss()) return

			local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_commonspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 1 "OnPlayerTouch": "!self,Kill,,0,-1" })
		}

		MissionAttributes.DeathHookTable.RareSpellRateCommon <- MissionAttributes.RareSpellRateCommon
	break

	// =========================================================

	case "RareSpellRateGiant":
		SetConvar("tf_spells_enabled", 1)
		function MissionAttributes::RareSpellRateGiant(params) {
			if (RandomFloat(0, 1) > value) return

			local bot = GetPlayerFromUserID(params.userid)
			if (!bot.IsBotOfType(1337) || !bot.IsMiniBoss()) return

			local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_giantspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 1 "OnPlayerTouch": "!self,Kill,,0,-1" })
		}

		MissionAttributes.DeathHookTable.RareSpellRateGiant <- MissionAttributes.RareSpellRateGiant
	break

	// =========================================================

	case "GrapplingHookEnable":
		SetConvar("tf_grapplinghook_enable", value)
	break

	// =========================================================

	case "GiantScale":
		SetConvar("tf_mvm_miniboss_scale", value)
	break

	// =========================================================

	case "NoSkeleSplit":
		function MissionAttributes::NoSkeleSplit() {
			//kill skele spawners before they split from tf_zombie_spawner
			for (local skelespell; skelespell = FindByClassname(skelespell, "tf_projectile_spellspawnzombie"); )
				if (GetPropEntity(skelespell, "m_hThrower") == null)
					EntFireByHandle(skelespell, "Kill", "", -1, null, null)

			// m_hThrower does not change when the skeletons split for spell-casted skeles, just need to kill them after spawning
			for (local skeles; skeles = FindByClassname(skeles, "tf_zombie");  ) {
				//kill blu split skeles
				if (skeles.GetModelScale() == 0.5 && GetPropEntity(skelespell, "m_hThrower").IsBotOfType(1337)) {
					EntFireByHandle(skeles, "Kill", "", -1, null, null)
					return
				}
				if (skeles.GetTeam() == 5) {
					skeles.SetTeam(TF_TEAM_PVE_INVADERS)
					skeles.SetSkin(1)
				}
				// smoove skele, unfinished

				// local locomotion = skeles.GetLocomotionInterface();
				// locomotion.Reset();
				// skeles.FlagForUpdate(true);
				// locomotion.ComputeUpdateInterval(); //not necessary
				// foreach (a in areas)
				// {
				//	   if (a.GetPlayerCount(TF_TEAM_PVE_DEFENDERS) < 1) continue

				//	   skeles.ClearImmobileStatus();
				//	   locomotion.SetDesiredSpeed(280.0);
				//	   locomotion.Approach(a.FindRandomSpot(), 999.0);
				// }
			}
		}

		MissionAttributes.ThinkTable.NoSkeleSplit <- MissionAttributes.NoSkeleSplit
	break

	// =========================================================

	case "WaveStartCountdown":
		function MissionAttributes::WaveStartCountdown() {
			if (!GetPropBool(PopExtUtil.ObjectiveResource, "m_bMannVsMachineBetweenWaves")) return

			local roundtime = GetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime")
			if (roundtime > Time() + value) {
				local ready = PopExtUtil.GetPlayerReadyCount()
				if (ready >= PopExtUtil.PlayerArray.len() || (roundtime <= 12.0))
					SetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime", Time() + value)
			}
		}

		MissionAttributes.ThinkTable.WaveStartCountdown <- MissionAttributes.WaveStartCountdown
	break

	// =========================================================

	case "ExtraTankPath":
		local tracks = []
		if (typeof value != "array") {
			MissionAttributes.RaiseValueError("ItemWhitelist", value, "Value must be array")
			success = false
			break
		}

		MissionAttributes.PathNum++

		foreach (i, pos in value) {

			local org = split(pos, " ")

			local track = SpawnEntityFromTable("path_track", {
				targetname = format("extratankpath%d_%d", MissionAttributes.PathNum, i+1)
				origin = Vector(org[0].tointeger(), org[1].tointeger(), org[2].tointeger())
			})
			tracks.append(track)

			// printf("%s spawned at %s\n", track.GetName(), track.GetOrigin().ToKVString())
		}

		tracks.append(null) //dummy value to put at the end

		for (local i = 0; i < tracks.len() - 1; i++)
			if (tracks[i] != null)
				SetPropEntity(tracks[i], "m_pnext", tracks[i+1])

		break

	// =========================================================

	// MissionAttr("HandModelOverride", "path")
	// MissionAttr("HandModelOverride", ["defaultpath", "scoutpath", "sniperpath"])
	// "path" and "defaultpath" will have %class in the string replaced with the player class

	case "HandModelOverride":

		function MissionAttributes::HandModelOverride(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope().PopExtPlayerScope

			function ArmThink() {
				local tfclass	   = player.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]

				local vmodel   = null
				local playervm = GetPropEntity(player, "m_hViewModel")

				if (typeof value == "string")
					vmodel = PopExtUtil.StringReplace(value, "%class", class_string);
				else if (typeof value == "array") {
					if (value.len() == 0) return

					if (tfclass >= value.len())
						vmodel = PopExtUtil.StringReplace(value[0], "%class", class_string);
					else
						vmodel = value[tfclass]
				}
				else {
					// do we need to do anything special for thinks??
					MissionAttributes.RaiseValueError("HandModelOverride", value, "Value must be string or array of strings")
					return
				}

				if (vmodel == null) return

				if (playervm.GetModelName() != vmodel) playervm.SetModelSimple(vmodel)

				for (local i = 0; i < SLOT_COUNT; i++) {
					local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
					if (wep == null || (wep.GetModelName() == vmodel)) continue

					wep.SetModelSimple(vmodel)
					wep.SetCustomViewModel(vmodel)
				}
			}

			if (!("ArmThink" in scope.PlayerThinkTable))
				scope.PlayerThinkTable.ArmThink <- ArmThink
		}

		MissionAttributes.SpawnHookTable.HandModelOverride <- MissionAttributes.HandModelOverride
	break

	// =========================================================

	case "PlayerAttributes":
		//setting maxhealth attribs doesn't update current HP
		local healthattribs = {
			"max health additive bonus" : null,
			"max health additive penalty": null,
			"SET BONUS: max health additive bonus": null,
			"hidden maxhealth non buffed": null,
		}
		function MissionAttributes::PlayerAttributes(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			if (typeof value != "table") {
				MissionAttributes.RaiseValueError("PlayerAttributes", value, "Value must be table")
				success = false
				return
			}

			local tfclass = player.GetPlayerClass();
			if (!(tfclass in value)) return

			local table = value[tfclass];
			foreach (key, val in table) {
				local valformat = ""
				if (typeof val == "integer")
					valformat = format("self.AddCustomAttribute(`%s`, %d, -1)", key, val)

				else if (typeof val == "string") {
					MissionAttributes.RaiseValueError("PlayerAttributes", val, "Cannot set string attributes!")
					success = false
					return
				}

				else if (typeof val == "float")
					valformat = format("self.AddCustomAttribute(`%s`, %f, -1)", key, val)

				EntFireByHandle(player, "RunScriptCode", valformat, -1, null, null)
				if (key in healthattribs) EntFireByHandle(player, "RunScriptCode", "self.SetHealth(self.GetMaxHealth())", -1, null, null)
			}
		}

		MissionAttributes.SpawnHookTable.PlayerAttributes <- MissionAttributes.PlayerAttributes
	break

	// =========================================================

	case "ItemAttributes":
		function MissionAttributes::ItemAttributes(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			if (typeof value != "table") {
				MissionAttributes.RaiseValueError("ItemAttributes", value, "Value must be table")
				success = false
				return
			}

			for (local i = 0; i < SLOT_COUNT; i++) {
				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
				if (wep == null) continue

				local cls = wep.GetClassname()
				if (cls in value)
					foreach (key, val in value[cls])
						wep.AddAttribute(key, val, -1)
			}
		}

		MissionAttributes.SpawnHookTable.ItemAttributes <- MissionAttributes.ItemAttributes
	break

	// =========================================================

	case "ItemWhitelist":
		if (typeof value != "array") {
			MissionAttributes.RaiseValueError("ItemWhitelist", value, "Value must be array")
			success = false
			break
		}

		PopExtUtil.ItemWhitelist = value
		if (value.len() == 0) return

		function MissionAttributes::ItemWhitelist(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope().PopExtPlayerScope

			function HasVal(arr, val) foreach (v in arr) if (v == val) return true
			for (local i = 0; i < SLOT_COUNT; i++) {
				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
				if (wep == null) continue

				local cls	= wep.GetClassname()
				local index = PopExtUtil.GetItemIndex(wep)

				if ( !(HasVal(value, cls) || HasVal(value, index)) )
					wep.Kill()
			}

			if (PopExtUtil.ItemBlacklist.len() == 0)
				EntFireByHandle(player, "RunScriptCode", "PopExtUtil.SwitchToFirstValidWeapon(self)", 0.015, null, null)
		}

		MissionAttributes.SpawnHookTable.ItemWhitelist <- MissionAttributes.ItemWhitelist
	break

	// =========================================================

	case "ItemBlacklist":
		if (typeof value != "array") {
			MissionAttributes.RaiseValueError("ItemBlacklist", value, "Value must be array")
			success = false
			break
		}

		PopExtUtil.ItemBlacklist = value
		if (value.len() == 0) return

		function MissionAttributes::ItemBlacklist(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			function HasVal(arr, val) foreach (v in arr) if (v == val) return true
			for (local i = 0; i < SLOT_COUNT; i++) {
				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
				if (wep == null) continue

				local cls	= wep.GetClassname()
				local index = PopExtUtil.GetItemIndex(wep)

				if ( HasVal(value, cls) || HasVal(value, index) )
					wep.Kill()
			}

			EntFireByHandle(player, "RunScriptCode", "PopExtUtil.SwitchToFirstValidWeapon(self)", 0.015, null, null)
		}

		MissionAttributes.SpawnHookTable.ItemBlacklist <- MissionAttributes.ItemBlacklist
	break

	// =========================================================

	case "HumansMustJoinTeam":
		if (value != TF_TEAM_RED && value != TF_TEAM_BLUE) {
			MissionAttributes.RaiseValueError("HumansMustJoinTeam", value, "Value must be 2 or 3")
			success = false
			break
		}

		function MissionAttributes::HumansMustJoinTeam(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			if (player.GetTeam() != value) {
				EntFireByHandle(player, "RunScriptCode", format("ChangePlayerTeamMvM(self, %d)", value), 0.015, null, null)
				EntFireByHandle(player, "RunScriptCode", "self.ForceRespawn()", 0.015, null, null)
			}
		}

		function BlueTeamReadyThink() {
			if (value != TF_TEAM_BLUE || !GetPropBool(PopExtUtil.ObjectiveResource, "m_bMannVsMachineBetweenWaves")) return

			local roundtime = GetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime")
			local ready     = PopExtUtil.GetPlayerReadyCount()
			if (ready >= PopExtUtil.PlayerArray.len())
				SetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime", Time())
		}
		MissionAttributes.ThinkTable.BlueTeamReadyThink <- MissionAttributes.BlueTeamReadyThink

		MissionAttributes.SpawnHookTable.HumansMustJoinTeam <- MissionAttributes.HumansMustJoinTeam
	break

	case "BotsRandomCrit":
		if (value == 0.0) return

		// Simplified rare high moments
		local base_ranged_crit_chance = 0.0005
		local max_ranged_crit_chance  = 0.0020
		local base_melee_crit_chance  = 0.15
		local max_melee_crit_chance   = 0.60
		// 4 kills to reach max chance

		function MissionAttributes::BotsRandomCritThink() {
			foreach (bot in PopExtUtil.BotArray) {
				local player = PlayerInstanceFromIndex(i)
				if (player == null || !player.IsBotOfType(1337)) continue

				player.ValidateScriptScope()
				local scope = player.GetScriptScope().PopExtPlayerScope
				if (!("crit_weapon" in scope))
					scope.crit_weapon <- null

				if (!("ranged_crit_chance" in scope) || !("melee_crit_chance" in scope)) {
					scope.ranged_crit_chance <- base_ranged_crit_chance
					scope.melee_crit_chance <- base_melee_crit_chance
				}

				if (!PopExtUtil.IsAlive(player) || player.GetTeam() == TEAM_SPECTATOR) continue

				// Wait for bot to use its crits
				if (scope.crit_weapon != null && player.InCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)) continue

				local wep       = player.GetActiveWeapon()
				local index     = PopExtUtil.GetItemIndex(wep)
				local classname = GetPropString(wep, "m_iClassname")

				// We handle melee weapons elsewhere in OnTakeDamage
				if (wep == null || wep.IsMeleeWeapon()) continue
				// Certain weapon types never receive random crits
				if (classname == "tf_weapon_sniperrifle" || index == 402 || classname == "tf_weapon_medigun" || wep.GetSlot() > 2) continue
				// Ignore weapons with certain attributes
				// if (wep.GetAttribute("crit mod disabled", 1) == 0 || wep.GetAttribute("crit mod disabled hidden", 1) == 0) continue

				// Lose the crits if we switch weapons
				if (scope.crit_weapon != null && scope.crit_weapon != wep)
					player.RemoveCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)

				local crit_chance_override = (value > 0) ? value : null
				local chance_to_use        = (crit_chance_override != null) ? crit_chance_override : scope.ranged_crit_chance

				// Roll for random crits
				if (RandomFloat(0, 1) < chance_to_use) {
					player.AddCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)
					scope.crit_weapon <- wep

					// Detect weapon fire to remove our crits
					wep.ValidateScriptScope()
					wep.GetScriptScope().last_fire_time <- Time()
					wep.GetScriptScope().Think <- function() {
						local fire_time = NetProps.GetPropFloat(self, "m_flLastFireTime");
						if (fire_time > last_fire_time) {
							player.RemoveCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)

							// Continuous fire weapons get 3 seconds of crits once they fire
							if (classname == "tf_weapon_minigun" || classname == "tf_weapon_flamethrower") {
								player.AddCondEx(TF_COND_CRITBOOSTED_CTF_CAPTURE, 3, null)
								EntFireByHandle(player, "RunScriptCode", format("crit_weapon <- null; ranged_crit_chance <- %f", base_ranged_crit_chance), 3, null, null)
							}
							else {
								scope.crit_weapon <- null
								scope.ranged_crit_chance <- base_ranged_crit_chance
							}

							NetProps.SetPropString(self, "m_iszScriptThinkFunction", "")
						}
						return -1
					}
					AddThinkToEnt(wep, "Think")
				}
			}
		}
		MissionAttributes.ThinkTable.BotsRandomCritThink <- MissionAttributes.BotsRandomCritThink

		function MissionAttributes::BotsRandomCritKill(params) {
			local attacker = GetPlayerFromUserID(params.attacker)
			if (attacker == null || !attacker.IsBotOfType(1337)) return

			attacker.ValidateScriptScope()
			local scope = attacker.GetScriptScope()
			if (!("ranged_crit_chance" in scope) || !("melee_crit_chance" in scope)) return

			if (scope.ranged_crit_chance + base_ranged_crit_chance > max_ranged_crit_chance)
				scope.ranged_crit_chance <- max_ranged_crit_chance
			else
				scope.ranged_crit_chance <- scope.ranged_crit_chance + base_ranged_crit_chance

			if (scope.melee_crit_chance + base_melee_crit_chance > max_melee_crit_chance)
				scope.melee_crit_chance <- max_melee_crit_chance
			else
				scope.melee_crit_chance <- scope.melee_crit_chance + base_melee_crit_chance
		}
		MissionAttributes.DeathHookTable.BotsRandomCritKill <- MissionAttributes.BotsRandomCritKill

		function MissionAttributes::BotsRandomCritTakeDamage(params) {
			if (!("inflictor" in params)) return

			local attacker = params.inflictor
			if (attacker == null || !attacker.IsPlayer() || !attacker.IsBotOfType(1337)) return

			attacker.ValidateScriptScope()
			local scope = attacker.GetScriptScope()
			if (!("melee_crit_chance" in scope)) return

			// Already a crit
			if (params.damage_type & DMG_ACID) return

			// Only Melee weapons
			local wep = attacker.GetActiveWeapon()
			if (!wep.IsMeleeWeapon()) return

			// Certain weapon types never receive random crits
			if (attacker.GetPlayerClass() == TF_CLASS_SPY) return
			// Ignore weapons with certain attributes
			// if (wep.GetAttribute("crit mod disabled", 1) == 0 || wep.GetAttribute("crit mod disabled hidden", 1) == 0) return

			// Roll our crit chance
			if (RandomFloat(0, 1) < scope.melee_crit_chance) {
				params.damage_type = params.damage_type | DMG_ACID
				// We delay here to allow death code to run so the reset doesn't get overriden
				EntFireByHandle(attacker, "RunScriptCode", format("melee_crit_chance <- %f", base_melee_crit_chance), 0.015, null, null)
			}
		}
		MissionAttributes.TakeDamageTable.BotsRandomCritTakeDamage <- MissionAttributes.BotsRandomCritTakeDamage
	break

	//Options to revert global fixes below:

	// =========================================================

	case "ReflectableDF":
		if ("DragonsFuryFix" in GlobalFixes.ThinkTable)
			delete GlobalFixes.ThinkTable.DragonsFuryFix
	break

	// =========================================================

	case "RestoreYERNerf":
		if ("YERDisguiseFix" in GlobalFixes.TakeDamageTable)
			delete GlobalFixes.TakeDamageTable.YERDisguiseFix
	break

	// =========================================================

	// Don't add attribute to clean-up list if it could not be found.
	default:
		ParseError(format("Could not find mission attribute '%s'", attr))
		success = false
	}

	// Add attribute to clean-up list if its modification was successful.
	if (success) {
		MissionAttributes.DebugLog(format("Added mission attribute %s", attr))
		MissionAttributes.CurAttrs[attr] <- value
	}
}

function MissionAttrThink() {
	foreach (_, func in MissionAttributes.ThinkTable) func()
	return -1
}

MissionAttrEntity.ValidateScriptScope();
MissionAttrEntity.GetScriptScope().MissionAttrThink <- MissionAttrThink
AddThinkToEnt(MissionAttrEntity, "MissionAttrThink")

function CollectMissionAttrs(attrs) {
	foreach (attr, value in attrs)
		MissionAttributes.MissionAttr(attr, value)
}
// Allow calling MissionAttributes::MissionAttr() directly with MissionAttr().
function MissionAttr(attr, value) {
	MissionAttr.call(MissionAttributes, attr, value)
}

//super truncated version incase the pop character limit becomes an issue.
function MAtr(attr, value) {
	MissionAttr.call(MissionAttributes, attr, value)
}

// Logging Functions
// =========================================================
// Generic debug message that is visible if PrintDebugText is true.
// Example: Print a message that the script is working as expected.
function MissionAttributes::DebugLog(LogMsg) {
	if (MissionAttributes.DebugText) {
		ClientPrint(null, HUD_PRINTCONSOLE, format("MissionAttr: %s.", LogMsg))
	}
}

// TODO: implement a try catch raise system instead of this

// Raises an error if the user passes an index that is out of range.
// Example: Allowed values are 1-2, but user passed 3.
function MissionAttributes::RaiseIndexError(attr, max = [0, 1]) ParseError(format("Index out of range for %s, value range: %d - %d", attr, max[0], max[1]))

// Raises an error if the user passes an argument of the wrong type.
// Example: Allowed values are strings, but user passed a float.
function MissionAttributes::RaiseTypeError(attr, type) ParseError(format("Bad type for %s (should be %s)", attr, type))

// Raises an error if the user passes an invalid argument
// Example: Attribute expects a bitwise operator but value cannot be evenly split into a power of 2
function MissionAttributes::RaiseValueError(attr, value, extra = "") ParseError(format("Bad value	%s	passed to %s. %s", value.tostring(), attr, extra))

// Raises a template parsing error, if nothing else fits.
function MissionAttributes::ParseError(ErrorMsg) {
	if (!MissionAttributes.RaisedParseError) {
		MissionAttributes.RaisedParseError = true
		ClientPrint(null, HUD_PRINTTALK, "\x08FFB4B4FFIt is possible that a parsing error has occured. Check console for details.")
	}
	ClientPrint(null, HUD_PRINTCONSOLE, format("%s %s.\n", MATTR_ERROR, ErrorMsg))

	foreach (player in PopExtUtil.PlayerArray) {
		if (player == null) continue

		EntFireByHandle(ClientCommand, "Command", format("echo %s %s.\n", MATTR_ERROR, ErrorMsg), -1, player, player)
	}
	printf("%s %s.\n", MATTR_ERROR, ErrorMsg)
}

// Raises an exception.
// Example: Script modification has not been performed correctly. User should never see one of these.
function MissionAttributes::RaiseException(ExceptionMsg) {
	Assert(false, format("MissionAttr EXCEPTION: %s.", ExceptionMsg))
}
