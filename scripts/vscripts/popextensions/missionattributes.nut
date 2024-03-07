const EFL_USER = 1048576
if (!("ScriptLoadTable" in ROOT))
	::ScriptLoadTable   <- {}
if (!("ScriptUnloadTable" in ROOT))
	::ScriptUnloadTable <- {}

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

	function Cleanup()
	{
		MissionAttributes.ResetConvars()
		MissionAttributes.PathNum = 0

		MissionAttributes.DebugLog(format("Cleaned up mission attributes"))
	}
	Events = {

		function OnScriptHook_OnTakeDamage(params) { foreach (_, func in MissionAttributes.TakeDamageTable) func(params) }
		// function OnGameEvent_player_spawn(params) { foreach (_, func in MissionAttributes.SpawnHookTable) func(params) }
		function OnGameEvent_player_death(params) { foreach (_, func in MissionAttributes.DeathHookTable) func(params) }
		function OnGameEvent_player_disconnect(params) { foreach (_, func in MissionAttributes.DisconnectTable) func(params) }

		function OnGameEvent_player_team(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (!player.IsBotOfType(1337) && params.team == TEAM_SPECTATOR && params.oldteam == TF_TEAM_PVE_INVADERS)
				EntFireByHandle(player, "RunScriptCode", "PopExtUtil.ChangePlayerTeamMvM(self, TF_TEAM_PVE_INVADERS)", -1, null, null)
		}

		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)
			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}

			foreach (_, func in MissionAttributes.SpawnHookTable) func(params)

			scope.PlayerThinks <- function() { foreach (name, func in scope.PlayerThinkTable) func(); return -1 }

			AddThinkToEnt(player, "PlayerThinks")

			if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope)) scope.BuiltObjectTable <- {}
		}
		// Hook all wave inits to reset parsing error counter.

		function OnGameEvent_recalculate_holidays(params) {

			if (GetRoundState() != GR_STATE_PREROUND) return

			MissionAttributes.Cleanup()
		}

		function OnGameEvent_mvm_wave_complete(params) {

			MissionAttributes.Cleanup()
		}

		function OnGameEvent_mvm_mission_complete(params) {

			foreach (_, func in ScriptUnloadTable) func()
			MissionAttributes.ResetConvars()
			DoEntFire("popext_missionattr_ent", "Kill", "", -1, null, null)
			delete ::MissionAttributes
		}
	}
};

foreach (_, func in ScriptLoadTable) func()

__CollectGameEventCallbacks(MissionAttributes.Events);

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

local MissionAttrEntity = FindByName(null, "popext_missionattr_ent")
if (MissionAttrEntity == null) MissionAttrEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_missionattr_ent"});

function MissionAttributes::SetConvar(convar, value, duration = 0, hideChatMessage = true) {

	local commentaryNode = FindByClassname(null, "point_commentary_node")
	if (commentaryNode == null && hideChatMessage) commentaryNode = SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

	//save original values to restore later
	if (!(convar in MissionAttributes.ConVars)) MissionAttributes.ConVars[convar] <- Convars.GetStr(convar);

	if (Convars.GetStr(convar) != value) Convars.SetValue(convar, value)

	if (duration > 0) EntFire("tf_gamerules", "RunScriptCode", "MissionAttributes.SetConvar("+convar+","+MissionAttributes.ConVars[convar]+")", duration)

	if (commentaryNode != null) EntFireByHandle(commentaryNode, "Kill", "", -1, null, null)
}

function MissionAttributes::ResetConvars(hideChatMessage = true) {

	local commentaryNode = FindByClassname(null, "point_commentary_node")
	if (commentaryNode == null && hideChatMessage) commentaryNode = SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

	foreach (convar, value in MissionAttributes.ConVars) Convars.SetValue(convar, value)
	MissionAttributes.ConVars.clear()

	if (commentaryNode != null) EntFireByHandle(commentaryNode, "Kill", "", -1, null, null)
}

local noromecarrier = false
function MissionAttributes::MissionAttr(...) {
	local args = vargv
	local attr
	local value

	if (args.len() == 0)
		return
	else if (args.len() == 1) {
		attr  = args[0]
		value = null
	}
	else {
		attr  = args[0]
		value = args[1]
	}

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

		local ent = FindByName(null, "MissionAttrHoliday");
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
				for (local pumpkin; pumpkin = FindByClassname(pumpkin, "tf_ammo_pack");)
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
			for (local revivemarker; revivemarker = FindByClassname(revivemarker, "entity_revive_marker");)
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
			player.GetScriptScope().PlayerThinkTable.StandableHeads <- StandableHeads
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
	case "NegativeDmgHeals":
		function MissionAttributes::NegativeDmgHeals(params) {
			local player = const_entity

			if (!player.IsPlayer() || damage > 0) return

			if ((value == 2 && player.GetHealth() - damage > player.GetMaxHealth()) || //don't overheal is value is 2
			(value == 1 && player.GetHealth() - damage > player.GetMaxHealth() * 1.5)) return //don't go past max overheal if value is 1

			player.SetHealth(player.GetHealth() - damage)

		}
		MissionAttributes.TakeDamageTable.NegativeDmgHeals <- MissionAttributes.NegativeDmgHeals
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
			}
			player.GetScriptScope().BuiltObjectTable.MultiSapper <- MultiSapper
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
		EntFire("tf_gamerules", "SetCustomUpgradesFile", value)
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
			for (local dot; dot = FindByClassname(dot, "env_sniperdot");)
				if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
					EntFireByHandle(dot, "Kill", "", -1, null, null)

			return -1;
		}

		MissionAttributes.ThinkTable.SniperHideLasers <- MissionAttributes.SniperHideLasers
	break

	// =========================================================

	case "TeamWipeWaveLoss":
		function MissionAttributes::TeamWipeWaveLoss(params) {
			if (!PopExtUtil.IsWaveStarted) return
			EntFire("tf_gamerules", "RunScriptCode", "if (PopExtUtil.CountAlivePlayers() == 0) EntFire(`_roundwin`, `RoundWin`)")
		}
		MissionAttributes.DeathHookTable.TeamWipeWaveLoss <- MissionAttributes.TeamWipeWaveLoss
	break

	// =========================================================
	//use -4 to make giants only count as 1 kill
	case "GiantSentryKillCountOffset":

		function MissionAttributes::GiantSentryKillCount(params) {

			local sentry = EntIndexToHScript(params.inflictor_entindex)
			local victim = GetPlayerFromUserID(params.userid)

			if (sentry.GetClassname() != "obj_sentrygun" || !victim.IsMiniBoss()) return
			local kills = GetPropInt(sentry, "m_iKills")
			SetPropInt(sentry, "m_iKills", kills + value)
			// EntFireByHandle(sentry, "RunScriptCode", format("SetPropInt(self, `m_iKills`, GetPropInt(self, `m_iKills`) + %d)", value), -1, null, null)
		}

		MissionAttributes.DeathHookTable.GiantSentryKillCount <- MissionAttributes.GiantSentryKillCount
	break

	// =========================================================
	case "FlagResetTime":
		function MissionAttributes::FlagResetTime() {
			for (local flag; flag = FindByClassname(flag, "item_teamflag");)
			{
				if (typeof value == "string")
				{
					local values = split(value, " ")
				}
			}
		}
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
		// Doesn't work
		/*
		ScriptLoadTable.PlayersAreRobotsReset <- function() {
			DoEntFire("__bot_bonemerge_model", "Kill", "", -1, null, null)
			printl("TEST TEST TEST")
			foreach (player in PopExtUtil.HumanArray) {
				player.ValidateScriptScope()
				local scope = player.GetScriptScope()

				EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", PopExtUtil.Classes[player.GetPlayerClass()]), -1, null, null)
				SetPropInt(player, "m_clrRender", 0xFFFFFF)
				SetPropInt(player, "m_nRenderMode", 0)
			}
			delete ScriptLoadTable.PlayersAreRobotsReset
		}
		*/

		function MissionAttributes::PlayersAreRobots(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

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
					
					for (local ent; ent = FindByClassname(ent, "instanced_scripted_scene"); ) {
						if (ent.GetEFlags() & EFL_USER) continue
						ent.AddEFlags(EFL_USER)
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
				if ("HandModelOverride" in MissionAttributes.SpawnHookTable) return

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
					EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", PopExtUtil.Classes[player.GetPlayerClass()]), -1, null, null)
					if (value & 2) activator.GenerateAndWearItem(format("Zombie %s",PopExtUtil.Classes[player.GetPlayerClass()]))
				}

				if (player.GetTeam() == TF_TEAM_PVE_DEFENDERS && value & 4)
				{
					EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", PopExtUtil.Classes[player.GetPlayerClass()]), -1, null, null)
					if (value & 8) activator.GenerateAndWearItem(format("Zombie %s",PopExtUtil.Classes[player.GetPlayerClass()]))
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

			local carrier = FindByName(null, "botship_dynamic") //some maps have a targetname for it

			if (carrier == null) {
				for (local props; props = FindByClassname(props, "prop_dynamic");) {
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
				skeles.FlagForUpdate(true);
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
				if (ready >= PopExtUtil.HumanArray.len() || (roundtime <= 12.0))
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
			local scope = player.GetScriptScope()

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

	case "AddCond":
		function MissionAttributes::AddCond(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.RemoveCond(value)

			local duration = (args.len() > 2) ? args[2] : -1
			EntFireByHandle(player, "RunScriptCode", format("self.AddCondEx(%d, %f, null)", value, duration), -1, null, null)
		}
		MissionAttributes.SpawnHookTable.AddCond <- MissionAttributes.AddCond
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

				local info = [PopExtUtil.GetItemIndex(wep), wep.GetClassname()]
				foreach (item in info)
					if (item in value)
						foreach(key, val in value[item])
							wep.AddAttribute(key, val, -1)
			}
		}

		MissionAttributes.SpawnHookTable.ItemAttributes <- MissionAttributes.ItemAttributes
	break

	// =========================================================

	// TODO: once we have our own giveweapon functions, finish this
	case "LoadoutControl":
		function MissionAttributes::LoadoutControl(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			function HasVal(arr, val) foreach (v in arr) if (v == val) return true
			function IsInMultiList(arr, val) {
				if (arr.len() <= 0) return false

				local in_list = false
				foreach (a in arr) {
					if (HasVal(a, val)) {
						in_list = true
						break
					}
				}
				return in_list
			}

			for (local i = 0; i < SLOT_COUNT; ++i) {
				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
				if (wep == null) continue

				local tfclass = PopExtUtil.Classes[player.GetPlayerClass()]

				local slot  = PopExtUtil.Slots[i]
				local index = PopExtUtil.GetItemIndex(wep)
				local cls	= wep.GetClassname()

				local whitelists = []
				local tables     = []

				tables.insert(0, value)
				if ("Whitelist" in value) whitelists.insert(0, value.Whitelist)

				if (tfclass in value) {
					tables.insert(0, value[tfclass])
					if ("Whitelist" in value[tfclass])
						whitelists.insert(0, value[tfclass].Whitelist)
				}

				if (tfclass in value && slot in value[tfclass]) {
					tables.insert(0, value[tfclass][slot])
					if ("Whitelist" in value[tfclass][slot])
						whitelists.insert(0, value[tfclass][slot].Whitelist)
				}


				if (whitelists.len() > 0) {
					local in_whitelist = IsInMultiList(whitelists, index) || IsInMultiList(whitelists, cls)

					if (!in_whitelist) {
						wep.Kill()
						continue
					}
				}

				foreach (table in tables) {
					local identifiers = [index, cls]
					local full_break  = false

					foreach (id in identifiers) {
						if (id in table) {
							local value = table[id]

							if (value == null) {
								wep.Kill()
								full_break = true
								break
							}
							else if (value == "") {
								printl("GIVE STOCK ITEM, check with IsInMultiList")
							}
							else if (typeof value == "string" && value.len() > 0) {
								printl("INVALID VALUE "+value+ "FOR KEY: "+id)
								continue
							}
							else {
								try {
									local value = value.tointeger()
									printl("REPLACE ITEM WITH ITEMINDEX "+value)
								}
								catch (e) {}
							}
						}
					}

					if (full_break) break
				}
			}

			EntFireByHandle(player, "RunScriptCode", "PopExtUtil.SwitchToFirstValidWeapon(self)", 0.015, null, null)
		}
		MissionAttributes.SpawnHookTable.LoadoutControl <- MissionAttributes.LoadoutControl
	break

	// =========================================================

	// 1 - Blue humans
	// 2 - Blue robots
	// 4 - Red  robots
	case "EnableRandomCrits":
		if (value == 0.0) return

		local user_chance = (args.len() > 2) ? args[2] : null

		// Simplified rare high moments
		local base_ranged_crit_chance = 0.0005
		local max_ranged_crit_chance  = 0.0020
		local base_melee_crit_chance  = 0.15
		local max_melee_crit_chance   = 0.60
		// 4 kills to reach max chance

		local timed_crit_weapons = {
			"tf_weapon_handgun_scout_secondary" : null,
			"tf_weapon_pistol_scout" : null,
			"tf_weapon_flamethrower" : null,
			"tf_weapon_minigun" : null,
			"tf_weapon_pistol" : null,
			"tf_weapon_syringegun_medic" : null,
			"tf_weapon_smg" : null,
			"tf_weapon_charged_smg" : null,
		}

		local no_crit_weapons = {
			"tf_weapon_laser_pointer" : null,
			"tf_weapon_medigun"	: null,
			"tf_weapon_sniperrifle" : null,
		}

		function MissionAttributes::EnableRandomCritsThink() {
			if (!PopExtUtil.IsWaveStarted) return -1

			foreach (player in PopExtUtil.PlayerArray) {
				if (!( (value & 1 && player.GetTeam() == TF_TEAM_PVE_INVADERS && !player.IsBotOfType(1337)) ||
					   (value & 2 && player.GetTeam() == TF_TEAM_PVE_INVADERS && player.IsBotOfType(1337))  ||
					   (value & 4 && player.GetTeam() == TF_TEAM_PVE_DEFENDERS && player.IsBotOfType(1337)) ))
					continue

				player.ValidateScriptScope()
				local scope = player.GetScriptScope()
				if (!("crit_weapon" in scope))
					scope.crit_weapon <- null

				if (!("ranged_crit_chance" in scope) || !("melee_crit_chance" in scope)) {
					scope.ranged_crit_chance <- base_ranged_crit_chance
					scope.melee_crit_chance <- base_melee_crit_chance
				}

				if (!PopExtUtil.IsAlive(player) || player.GetTeam() == TEAM_SPECTATOR) continue

				local wep       = player.GetActiveWeapon()
				local index     = PopExtUtil.GetItemIndex(wep)
				local classname = wep.GetClassname()

				// Lose the crits if we switch weapons
				if (scope.crit_weapon != null && scope.crit_weapon != wep)
					player.RemoveCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)

				// Wait for bot to use its crits
				if (scope.crit_weapon != null && player.InCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)) continue

				// We handle melee weapons elsewhere in OnTakeDamage
				if (wep == null || wep.IsMeleeWeapon()) continue
				// Certain weapon types never receive random crits
				if (classname in no_crit_weapons || wep.GetSlot() > 2) continue
				// Ignore weapons with certain attributes
				// if (wep.GetAttribute("crit mod disabled", 1) == 0 || wep.GetAttribute("crit mod disabled hidden", 1) == 0) continue

				local crit_chance_override = (user_chance > 0) ? user_chance : null
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
							local owner = self.GetOwner()
							owner.RemoveCond(TF_COND_CRITBOOSTED_CTF_CAPTURE)

							owner.ValidateScriptScope()
							local scope = owner.GetScriptScope()

							// Continuous fire weapons get 2 seconds of crits once they fire
							if (classname in timed_crit_weapons) {
								owner.AddCondEx(TF_COND_CRITBOOSTED_CTF_CAPTURE, 2, null)
								EntFireByHandle(owner, "RunScriptCode", format("crit_weapon <- null; ranged_crit_chance <- %f", base_ranged_crit_chance), 2, null, null)
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
		MissionAttributes.ThinkTable.EnableRandomCritsThink <- MissionAttributes.EnableRandomCritsThink

		function MissionAttributes::EnableRandomCritsKill(params) {
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
		MissionAttributes.DeathHookTable.EnableRandomCritsKill <- MissionAttributes.EnableRandomCritsKill

		function MissionAttributes::EnableRandomCritsTakeDamage(params) {
			if (!("inflictor" in params)) return

			local attacker = params.inflictor
			if (attacker == null || !attacker.IsPlayer() || !attacker.IsBotOfType(1337)) return

			attacker.ValidateScriptScope()
			local scope = attacker.GetScriptScope()
			if (!("melee_crit_chance" in scope)) return

			// Already a crit
			if (params.damage_type & DMG_CRITICAL) return

			// Only Melee weapons
			local wep = attacker.GetActiveWeapon()
			if (!wep.IsMeleeWeapon()) return

			// Certain weapon types never receive random crits
			if (attacker.GetPlayerClass() == TF_CLASS_SPY) return
			// Ignore weapons with certain attributes
			// if (wep.GetAttribute("crit mod disabled", 1) == 0 || wep.GetAttribute("crit mod disabled hidden", 1) == 0) return

			// Roll our crit chance
			if (RandomFloat(0, 1) < scope.melee_crit_chance) {
				params.damage_type = params.damage_type | DMG_CRITICAL
				// We delay here to allow death code to run so the reset doesn't get overriden
				EntFireByHandle(attacker, "RunScriptCode", format("melee_crit_chance <- %f", base_melee_crit_chance), 0.015, null, null)
			}
		}
		MissionAttributes.TakeDamageTable.EnableRandomCritsTakeDamage <- MissionAttributes.EnableRandomCritsTakeDamage
	break

	case "ReverseMVM":
		// Prevent bots on red team from hogging slots so players can always join and get switched to blue
		// TODO: Needs testing
		// also need to reset it
		//MissionAttributes.SetConvar("tf_mvm_defenders_team_size", 999)

		function MissionAttributes::ReverseMVMThink() {
			// Enforce max team size
			local player_count  = 0
			local max_team_size = 6
			foreach (player in PopExtUtil.PlayerArray) {

				if (player_count + 1 > max_team_size) {
					player.ForceChangeTeam(TEAM_SPECTATOR, false)
					continue
				}

				++player_count
			}

			// Readying up starts the round
			if (!PopExtUtil.IsWaveStarted) {
				local ready = PopExtUtil.GetPlayerReadyCount()
				if (ready > 0 && ready >= PopExtUtil.HumanArray.len() && !("WaveStartCountdown" in MissionAttributes) && GetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime") >= Time() + 12.0)
						SetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime", Time() + 10.0)
			}
		}
		MissionAttributes.ThinkTable.ReverseMVMThink <- MissionAttributes.ReverseMVMThink

		function MissionAttributes::ReverseMVMSpawn(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(1337)) return

			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			// Switch to blue team
			// TODO: Need to fix players getting stuck in spec on wave fail, mission complete, etc
			if (player.GetTeam() != TF_TEAM_PVE_INVADERS) {
				EntFireByHandle(player, "RunScriptCode", "PopExtUtil.ChangePlayerTeamMvM(self, TF_TEAM_PVE_INVADERS)", 0.015, null, null)
				EntFireByHandle(player, "RunScriptCode", "self.ForceRespawn()", 0.015, null, null)
			}

			// Kill any phantom lasers from respawning as engie (yes this is real)
			EntFireByHandle(player, "RunScriptCode", @"
				for (local ent; ent = FindByClassname(ent, `env_laserdot`);)
					if (ent.GetOwner() == self)
						ent.Destroy()
			", 0.5, null, null)

			// Temporary solution for engie wrangler laser
			scope.handled_laser   <- false
			scope.laser_spawntime <- -1
			scope.PlayerThinkTable.ReverseMVMLaserThink <- function() {
				if (!PopExtUtil.IsAlive(player) || player.GetTeam() == TEAM_SPECTATOR) return

				local wep = self.GetActiveWeapon()

				if (wep.GetClassname() == "tf_weapon_laser_pointer") {
					if (laser_spawntime == -1)
						laser_spawntime = Time() + 0.55
				}
				else {
					if (laser_spawntime > -1) {
						laser_spawntime = -1
						handled_laser   = false
					}
					return
				}

				if (handled_laser) return
				if (Time() < laser_spawntime) return

				local laser = null
				for (local ent; ent = FindByClassname(ent, "env_laserdot");) {
					if (ent.GetOwner() == self) {
						laser = ent
						break
					}
				}

				for (local ent; ent = FindByClassname(ent, "obj_sentrygun");) {
					local builder = GetPropEntity(ent, "m_hBuilder")
					if (builder != self) continue

					if (!GetPropBool(ent, "m_bPlayerControlled") || laser == null) continue

					originalposition <- self.GetOrigin()
					originalvelocity <- self.GetAbsVelocity()
					originalmovetype <- self.GetMoveType()
					self.SetAbsOrigin(ent.GetOrigin() + Vector(0, 0, -32))
					self.SetAbsVelocity(Vector())
					self.SetMoveType(MOVETYPE_NOCLIP, MOVECOLLIDE_DEFAULT)
					EntFireByHandle(laser, "RunScriptCode", "self.SetTeam(TF_TEAM_PVE_DEFENDERS)", 0.015, null, null)
					EntFireByHandle(self, "RunScriptCode", "self.SetAbsOrigin(originalposition); self.SetAbsVelocity(originalvelocity); self.SetMoveType(originalmovetype, MOVECOLLIDE_DEFAULT)", 0.015, null, null)

					handled_laser = true
					return
				}

				if (!handled_laser && laser != null)
					laser.Destroy()
			}

			// Allow money collection
			scope.PlayerThinkTable.ReverseMVMCurrencyThink <- function() {
				// Save money netprops because we fuck it in the loop below
				local money              = GetPropInt(PopExtUtil.ObjectiveResource, "m_nMvMWorldMoney")
				local prev_wave_money    = GetPropInt(PopExtUtil.MvMStatsEnt, "m_previousWaveStats.nCreditsDropped")
				local current_wave_money = GetPropInt(PopExtUtil.MvMStatsEnt, "m_currentWaveStats.nCreditsDropped")

				// Find currency near us
				local origin = self.GetOrigin()
				for ( local ent; ent = FindByClassnameWithin(ent, "item_currencypack_*", origin, 64); ) {
					// Move the money to the origin and respawn it to allow us to collect it after it touches the ground
					ent.SetAbsOrigin(Vector())
					ent.DispatchSpawn()
				}

				// The money counters are fucked from what we did in the above loop, fix it here
				SetPropInt(PopExtUtil.ObjectiveResource, "m_nMvMWorldMoney", money)
				SetPropInt(PopExtUtil.MvMStatsEnt, "m_previousWaveStats.nCreditsDropped", prev_wave_money)
				SetPropInt(PopExtUtil.MvMStatsEnt, "m_currentWaveStats.nCreditsDropped", current_wave_money)
			}

			// Allow pack collection
			scope.PlayerThinkTable.ReverseMVMPackThink <- function() {
				local origin = self.GetOrigin()
				for ( local ent; ent = FindByClassnameWithin(ent, "item_*", origin, 40); ) {
					if (ent.GetEFlags() & EFL_USER) continue
					if (GetPropInt(ent, "m_fEffects") & EF_NODRAW) continue

					local classname = ent.GetClassname()
					if (startswith(classname, "item_currencypack_")) continue

					local refill    = false
					local is_health = false

					local multiplier = 0.0
					if (endswith(classname, "_small"))       multiplier = 0.2
					else if (endswith(classname, "_medium")) multiplier = 0.5
					else if (endswith(classname, "_full"))   multiplier = 1.0

					if (startswith(classname, "item_ammopack_")) {
						local metal    = GetPropIntArray(self, "m_iAmmo", TF_AMMO_METAL)
						local maxmetal = 200

						if (metal < maxmetal) {
							local maxmult  = PopExtUtil.Round(maxmetal * multiplier)
							local setvalue = (metal + maxmult > maxmetal) ? maxmetal : metal + maxmult

							SetPropIntArray(self, "m_iAmmo", setvalue, TF_AMMO_METAL)
							refill = true
						}

						for (local i = 0; i < SLOT_MELEE; ++i) {
							local wep     = PopExtUtil.GetItemInSlot(self, i)
							local ammo    = GetPropIntArray(self, "m_iAmmo", i+1)
							local maxammo = PopExtUtil.GetWeaponMaxAmmo(self, wep)

							if (ammo >= maxammo)
								continue
							else {
								local maxmult  = PopExtUtil.Round(maxammo * multiplier)
								local setvalue = (ammo + maxmult > maxammo) ? maxammo : ammo + maxmult

								SetPropIntArray(self, "m_iAmmo", setvalue, i+1)
								refill = true
							}
						}

					}
					else if (startswith(classname, "item_healthkit_")) {
						is_health = true

						local hp    = self.GetHealth()
						local maxhp = self.GetMaxHealth()
						if (hp >= maxhp) continue

						refill = true

						local maxmult  = PopExtUtil.Round(maxhp * multiplier)
						local setvalue = (hp + maxmult > maxhp) ? maxhp : hp + maxmult
						self.ExtinguishPlayerBurning()

						SendGlobalGameEvent("player_healed", {
							patient = PopExtUtil.GetPlayerUserID(self)
							healer  = 0
							amount  = setvalue - hp
						})
						SendGlobalGameEvent("player_healonhit", {
							entindex         = self.entindex()
							weapon_def_index = 65535
							amount           = setvalue - hp
						})

						self.SetHealth(setvalue)
					}

					if (refill) {
						if (is_health)
							EmitSoundOnClient("HealthKit.Touch", self)
						else
							EmitSoundOnClient("AmmoPack.Touch", self)

						ent.AddEFlags(EFL_USER)
						EntFireByHandle(ent, "Disable", "", -1, null, null)

						EntFireByHandle(ent, "Enable", "", 10, null, null)
						EntFireByHandle(ent, "RunScriptCode", "self.RemoveEFlags(EFL_USER)", 10, null, null)
					}
				}
			}

			// Drain player ammo on weapon usage
			scope.PlayerThinkTable.ReverseMVMDrainAmmoThink <- function() {
				local buttons = NetProps.GetPropInt(self, "m_nButtons");

				local wep = player.GetActiveWeapon()
				if (wep == null || wep.IsMeleeWeapon()) return

				wep.ValidateScriptScope()
				local scope = wep.GetScriptScope()
				if (!("nextattack" in scope)) {
					scope.nextattack <- -1
					scope.lastattack <- -1
				}


				local classname = wep.GetClassname()
				local itemid    = PopExtUtil.GetItemIndex(wep)
				local sequence  = wep.GetSequence()

				// These weapons have clips but either function fine or don't need to be handled
				if (classname == "tf_weapon_particle_cannon"  || classname == "tf_weapon_raygun"     ||
					classname == "tf_weapon_flaregun_revenge" || classname == "tf_weapon_drg_pomson" ||
					classname == "tf_weapon_medigun") return

				local clip = wep.Clip1()

				if (clip > -1) {
					if (!("lastclip" in scope))
						scope.lastclip <- clip

					// We reloaded
					if (clip > scope.lastclip) {
						local difference = clip - scope.lastclip
						if (self.GetPlayerClass() == TF_CLASS_SPY && classname == "tf_weapon_revolver") {
							local maxammo = GetPropIntArray(self, "m_iAmmo", SLOT_SECONDARY + 1)
							SetPropIntArray(self, "m_iAmmo", maxammo - difference, SLOT_SECONDARY + 1)
						}
						else {
							local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)
							SetPropIntArray(self, "m_iAmmo", maxammo - difference, wep.GetSlot() + 1)
						}
					}

					scope.lastclip <- clip
				}
				else {
					if (classname == "tf_weapon_rocketlauncher_fireball") {
						local recharge = GetPropFloat(player, "m_Shared.m_flItemChargeMeter")
						if (recharge == 0) {
							local cost = (sequence == 13) ? 2 : 1
							local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)

							if (maxammo - cost > -1)
								SetPropIntArray(self, "m_iAmmo", maxammo - cost, wep.GetSlot() + 1)
						}
					}
					else if (classname == "tf_weapon_flamethrower") {
						if (sequence == 12) return // Weapon deploy
						if (Time() < scope.nextattack) return

						local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)

						// The airblast sequence lasts 0.25s too long so we check against it here
						if (buttons & IN_ATTACK && sequence != 13) {
							if (maxammo - 1 > -1) {
								SetPropIntArray(self, "m_iAmmo", maxammo - 1, wep.GetSlot() + 1)
								scope.nextattack <- Time() + 0.105
							}
						}
						else if (buttons & IN_ATTACK2) {
							local cost = 20
							if (itemid == ID_BACKBURNER || itemid == ID_FESTIVE_BACKBURNER) // Backburner
								cost = 50
							else if (itemid == ID_DEGREASER) // Degreaser
								cost = 25

							if (maxammo - cost > -1) {
								SetPropIntArray(self, "m_iAmmo", maxammo - cost, wep.GetSlot() + 1)
								scope.nextattack <- Time() + 0.75
							}
						}
					}
					else if (classname == "tf_weapon_flaregun") {
						local nextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
						if (Time() < nextattack) return

						local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)
						if (buttons & IN_ATTACK) {
							if (maxammo - 1 > -1)
								SetPropIntArray(self, "m_iAmmo", maxammo - 1, wep.GetSlot() + 1)
						}
					}
					else if (classname == "tf_weapon_minigun") {
						local nextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
						if (Time() < nextattack) return

						local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)
						if (sequence == 21) {
							if (maxammo - 1 > -1)
								SetPropIntArray(self, "m_iAmmo", maxammo - 1, wep.GetSlot() + 1)
						}
						else if (sequence == 25) {
							if (Time() < scope.nextattack) return
							if (itemid != ID_HUO_LONG_HEATER && itemid != ID_HUO_LONG_HEATER_GENUINE) return

							if (maxammo - 1 > -1) {
								SetPropIntArray(self, "m_iAmmo", maxammo - 1, wep.GetSlot() + 1)
								scope.nextattack <- Time() + 0.25
							}
						}
					}
					else if (classname == "tf_weapon_mechanical_arm") {
						// Reset hack
						SetPropIntArray(self, "m_iAmmo", 0, TF_AMMO_GRENADES1)
						SetPropInt(wep, "m_iPrimaryAmmoType", 3)

						local nextattack1 = GetPropFloat(wep, "m_flNextPrimaryAttack")
						local nextattack2 = GetPropFloat(wep, "m_flNextSecondaryAttack")

						local maxmetal = GetPropIntArray(self, "m_iAmmo", TF_AMMO_METAL)

						if (buttons & IN_ATTACK) {
							if (Time() < nextattack1) return
							if (maxmetal - 5 > -1) {
								SetPropIntArray(self, "m_iAmmo", maxmetal - 5, TF_AMMO_METAL)
								// This prevents an exploit where you M1 and M2 in rapid succession to evade the 65 orb cost
								SetPropFloat(wep, "m_flNextSecondaryAttack", Time() + 0.25)
							}
						}
						else if (buttons & IN_ATTACK2) {
							if (Time() < nextattack2) return

							if (maxmetal - 65 > -1) {
								// Hack to get around the game blocking SecondaryAttack below 65 metal
								SetPropIntArray(self, "m_iAmmo", INT_MAX, TF_AMMO_GRENADES1)
								SetPropInt(wep, "m_iPrimaryAmmoType", TF_AMMO_GRENADES1)

								SetPropIntArray(self, "m_iAmmo", maxmetal - 65, TF_AMMO_METAL)
							}
						}
					}
					else if (itemid == ID_WIDOWMAKER) { // Widowmaker
						local nextattack = GetPropFloat(wep, "m_flNextPrimaryAttack")
						if (Time() < nextattack) return

						local maxmetal = GetPropIntArray(self, "m_iAmmo", TF_AMMO_METAL)

						if (buttons & IN_ATTACK) {
							if (maxmetal - 30 > -1)
								SetPropIntArray(self, "m_iAmmo", maxmetal - 30, TF_AMMO_METAL)
						}
					}
					else if (classname == "tf_weapon_sniperrifle" || itemid == ID_BAZAAR_BARGAIN || itemid == ID_CLASSIC) {
						local lastfire = GetPropFloat(wep, "m_flLastFireTime")
						if (scope.lastattack == lastfire) return

						scope.lastattack <- lastfire
						local maxammo = GetPropIntArray(self, "m_iAmmo", wep.GetSlot() + 1)
						if (scope.lastattack > 0 && scope.lastattack < Time()) {
							if (maxammo - 1 > -1)
								SetPropIntArray(self, "m_iAmmo", maxammo - 1, wep.GetSlot() + 1)
						}
					}
				}
			}
		}
		MissionAttributes.SpawnHookTable.ReverseMVMSpawn <- MissionAttributes.ReverseMVMSpawn
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

// This only supports key : value pairs, if you want var args call MissionAttr directly
function CollectMissionAttrs(attrs = {}) {
	foreach (attr, value in attrs)
		MissionAttributes.MissionAttr(attr, value)

}
// Allow calling MissionAttributes::MissionAttr() directly with MissionAttr().
function MissionAttr(...) {
	MissionAttr.acall(vargv.insert(0, MissionAttributes))
}

//super truncated version incase the pop character limit becomes an issue.
function MAtr(...) {
	MissionAttr.acall(vargv.insert(0, MissionAttributes))
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

	foreach (player in PopExtUtil.HumanArray) {
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
