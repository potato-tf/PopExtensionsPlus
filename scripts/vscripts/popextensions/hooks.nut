popExtEntity <- FindByName(null, "_popextensions")
if (popExtEntity == null) {
	popExtEntity <- SpawnEntityFromTable("info_teleport_destination", { targetname = "_popextensions" })
}

popExtEntity.ValidateScriptScope()
PopExt <- popExtEntity.GetScriptScope()

::PopExtHooks <- {

	tankIcons = []
	icons 	  = []

	function AddHooksToScope(name, table, scope) {
		foreach(hookName, func in table) {
			// Entries in hook table must begin with 'On' to be considered hooks
			if (hookName[0] == 'O' && hookName[1] == 'n') {
				if (!("popHooks" in scope)) {
					scope["popHooks"] <- {}
				}

				if (!(hookName in scope.popHooks)) {
					scope.popHooks[hookName] <- []
				}

				scope.popHooks[hookName].append(func)
			}
			else {
				if (!("popProperty" in scope)) {
					scope["popProperty"] <- {}
				}
				scope.popProperty[hookName] <- func

				if (hookName == "TankModel") {
					local tankModelNames = typeof func == "string" ? {} : func

					if (typeof func == "string") {
						tankModelNames.Default <- func
						tankModelNames.Damage1 <- func
						tankModelNames.Damage2 <- func
						tankModelNames.Damage3 <- func
					}
					scope.popProperty[hookName] <- tankModelNames
					local tankModelNamesPrecached = {}

					foreach(k, v in tankModelNames)
					tankModelNamesPrecached[k] <- PrecacheModel(v)

					scope.popProperty.TankModelPrecached <- tankModelNamesPrecached
				}
			}
		}
	}

	function FireHooks(entity, scope, name) {
		if (scope != null && "popHooks" in scope && name in scope.popHooks)
			foreach(index, func in scope.popHooks[name])
				func(entity)
	}

	function FireHooksParam(entity, scope, name, param) {
		if (scope != null && "popHooks" in scope && name in scope.popHooks)
			foreach(index, func in scope.popHooks[name])
				func(entity, param)
	}
	Events = {
		function OnScriptHook_OnTakeDamage(params) {
			local victim = params.const_entity
			if (victim != null && ((victim.IsPlayer() && victim.IsBotOfType(1337)) || victim.GetClassname() == "tank_boss")) {
				local scope = victim.GetScriptScope()
				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamage", params)
			}
	
			local attacker = params.attacker
			if (attacker != null && attacker.IsPlayer() && attacker.IsBotOfType(1337)) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam(attacker, scope, "OnDealDamage", params)
			}
		}
	
		function OnGameEvent_player_spawn(params) {
			local player = GetPlayerFromUserID(params.userid)
	
			if (player.GetScriptScope() != null && "popWearablesToDestroy" in player.GetScriptScope()) {
				foreach(wearable in player.GetScriptScope().popWearablesToDestroy)
					if (wearable.IsValid()) EntFireByHandle(wearable, "Kill", "", -1, null, null)
	
				delete player.GetScriptScope().popWearablesToDestroy
			}
	
			if (player != null && player.IsBotOfType(1337)) {
				player.ValidateScriptScope()
				local scope = player.GetScriptScope()
	
				if ("popFiredDeathHook" in scope) {
					if (!scope.popFiredDeathHook)
						PopExtHooks.FireHooksParam(player, scope, "OnDeath", null)
	
					delete scope.popFiredDeathHook
				}
	
				// Reset hooks
				if ("botCreated" in scope)
					delete scope.botCreated
	
				if ("popHooks" in scope)
					delete scope.popHooks
	
			}
		}
		function OnGameEvent_player_team(params) {
			
			if (params.team != TEAM_SPECTATOR) return

			local player = GetPlayerFromUserID(params.userid)

			if (player.GetScriptScope() != null && "popWearablesToDestroy" in player.GetScriptScope()) {
				foreach(wearable in player.GetScriptScope().popWearablesToDestroy)
					if (wearable.IsValid()) EntFireByHandle(wearable, "Kill", "", -1, null, null)
	
				delete player.GetScriptScope().popWearablesToDestroy
			}
	
			if (player != null && player.IsBotOfType(1337)) {
				player.ValidateScriptScope()
				local scope = player.GetScriptScope()
	
				if ("popFiredDeathHook" in scope) {
					if (!scope.popFiredDeathHook)
						PopExtHooks.FireHooksParam(player, scope, "OnDeath", null)
	
					delete scope.popFiredDeathHook
				}
	
				// Reset hooks
				if ("botCreated" in scope)
					delete scope.botCreated
	
				if ("popHooks" in scope)
					delete scope.popHooks
	
			}
		}
	
		function OnGameEvent_player_hurt(params) {
			local victim = GetPlayerFromUserID(params.userid)
			if (victim != null && victim.IsBotOfType(1337)) {
				local scope = victim.GetScriptScope()
				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamagePost", params)
			}
	
			local attacker = GetPlayerFromUserID(params.attacker)
			if (attacker != null && attacker.IsBotOfType(1337)) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam(attacker, scope, "OnDealDamagePost", params)
			}
		}
	
		function OnGameEvent_player_death(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player != null && player.IsBotOfType(1337)) {
				local scope = player.GetScriptScope()
				scope.popFiredDeathHook <- true
				PopExtHooks.FireHooksParam(player, scope, "OnDeath", params)
			}
	
			local attacker = GetPlayerFromUserID(params.attacker)
			if (attacker != null && attacker.IsBotOfType(1337)) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam(attacker, scope, "OnKill", params)
			}
	
			if (player.GetScriptScope() != null && "popWearablesToDestroy" in player.GetScriptScope()) {
				foreach(i, wearable in player.GetScriptScope().popWearablesToDestroy)
					if (wearable.IsValid())
						wearable.Kill()
	
				delete player.GetScriptScope().popWearablesToDestroy
			}
		}
	
		function OnGameEvent_npc_hurt(params) {
			local victim = EntIndexToHScript(params.entindex)
			if (victim != null && victim.GetClassname() == "tank_boss") {
				local scope = victim.GetScriptScope()
				local dead  = (victim.GetHealth() - params.damageamount) <= 0
	
				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamagePost", params)
	
				if (dead && !("popFiredDeathHook" in scope)) {
					scope.popFiredDeathHook <- true
					if ("popProperty" in scope && "Icon" in scope.popProperty) {
						local icon = scope.popProperty.Icon
						local flags = MVM_CLASS_FLAG_NORMAL
	
						if (!("isBoss" in icon) || icon.isBoss)
							flags = flags | MVM_CLASS_FLAG_MINIBOSS
	
						if ("isCrit" in icon && icon.isCrit)
							flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT
	
						// Compensate for the decreasing of normal tank icon
						if (GetWaveIconSpawnCount("tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL) > 0 && GetWaveIconSpawnCount(icon.name, flags) > 0)
							IncrementWaveIconSpawnCount("tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1, false)
	
						// Decrement custom tank icon when killed.
						DecrementWaveIconSpawnCount(icon.name, flags, 1, false)
					}
	
					PopExtHooks.FireHooksParam(victim, scope, "OnDeath", params)
				}
			}
		}
		function OnGameEvent_mvm_begin_wave(params) {
			if ("waveIconsFunction" in PopExt)
				PopExt.waveIconsFunction()
		
			foreach(i, v in PopExtHooks.tankIcons)
				_PopIncrementTankIcon(v)
		
			foreach(i, v in PopExtHooks.icons)
				_PopIncrementIcon(v)
		
		}
		function OnGameEvent_teamplay_round_start(params) {
			if ("waveIconsFunction" in PopExt)
				delete PopExt.waveIconsFunction
		
			tankIcons <- []
			icons     <- []
		}
	}
}
__CollectGameEventCallbacks(PopExtHooks.Events)
function PopulatorThink() {

	for (local tank; tank = FindByClassname(tank, "tank_boss");) {
		tank.ValidateScriptScope()
		local scope = tank.GetScriptScope()

		if (!("created" in scope)) {
			scope.created <- true

			if (!("TankThinkTable" in scope)) scope.TankThinkTable <- {}

			local tankName = tank.GetName().tolower()

			foreach(name, table in tankNamesWildcard) {
				if (name == tankName || name == tankName.slice(0, name.len())) {
					PopExtHooks.AddHooksToScope(tankName, table, scope)

					if ("OnSpawn" in table)
						table.OnSpawn(tank, tankName)
				}
			}

			if (tankName in tankNames) {
				local table = tankNames[tankName]
				PopExtHooks.AddHooksToScope(tankName, table, scope)

				if ("OnSpawn" in table)
					table.OnSpawn(tank, tankName)
			}

			scope.maxHealth <- tank.GetMaxHealth()
			scope.team      <- tank.GetTeam()

			scope.curPos    <- tank.GetOrigin()
			scope.curVel    <- tank.GetAbsVelocity()
			scope.curSpeed  <- scope.curVel.Length()
			scope.curHealth <- tank.GetHealth()
			scope.lastHealthPercentage <- GetPropFloat(tank, "m_lastHealthPercentage")

			scope.TankThinkTable.Updates <- function() {
				this.curPos    <- self.GetOrigin()
				this.curVel    <- self.GetAbsVelocity()
				this.curSpeed  <- curVel.Length()
				this.curHealth <- self.GetHealth()
				this.lastHealthPercentage <- GetPropFloat(self, "m_lastHealthPercentage")
			}

			scope.TankThinks <- function() { foreach (name, func in scope.TankThinkTable) func(); return -1 }

			AddThinkToEnt(tank, "TankThinks")

			if ("popProperty" in scope && "IsBlimp" in scope.popProperty && scope.popProperty.IsBlimp) {
				scope.popProperty.DisableTracks <- true
				scope.popProperty.DisableBomb <- true
				// scope.popProperty.TankModel <- "models/bots/boss_bot/boss_blimp_pure.mdl"

				tank.SetAbsAngles(QAngle(0, tank.GetAbsAngles().y, 0))
				tank.KeyValueFromString("OnKilled", "!self, RunScriptCode, blimpTrain.Kill(), -1, -1")
				// scope.blimpModel <- PrecacheModel("models/bots/boss_bot/boss_blimp_pure.mdl")

				local tankspeed = GetPropFloat(tank, "m_speed")
				scope.blimpTrain <- SpawnEntityFromTable("func_tracktrain", {origin = tank.GetOrigin(), speed = tankspeed, startspeed = tankspeed, target = "extratankpath1_1"})

				scope.BlimpThink <- function() {
					// for(local i=0; i<=3; i++) SetPropIntArray(self, "m_nModelIndexOverrides", blimpModel, i)
					self.SetAbsOrigin(blimpTrain.GetOrigin())
					self.GetLocomotionInterface().Reset()
				}
				scope.TankThinkTable.BlimpThink <- scope.BlimpThink
			}

			if ("popProperty" in scope && "DisableTracks" in scope.popProperty && scope.popProperty.DisableTracks) {
				for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
					if (child.GetClassname() != "prop_dynamic") continue

					if (child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl") {
						SetPropInt(child, "m_fEffects", GetPropInt(child, "m_fEffects") | 32)
					}
				}
			}

			if ("popProperty" in scope && "DisableBomb" in scope.popProperty && scope.popProperty.DisableBomb) {
				for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
					if (child.GetClassname() != "prop_dynamic") continue

					if (child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl") {
						SetPropInt(child, "m_fEffects", GetPropInt(child, "m_fEffects") | 32)
					}
				}
			}

			if ("popProperty" in scope && "DisableSmoke" in scope.popProperty && scope.popProperty.DisableSmoke) {
				scope.DisableSmoke <- function() {
					//disables smokestack, will emit one smoke particle when spawning and when moving out from under low ceilings (solid brushes 300 units or lower)
					EntFireByHandle(self, "DispatchEffect", "ParticleEffectStop", -1, null, null)
				}
				scope.TankThinkTable.DisableSmoke <- scope.DisableSmoke
			}

			if ("popProperty" in scope && "TankModel" in scope.popProperty) {
				if (!("TankModelVisionOnly" in scope.popProperty && scope.popProperty.TankModelVisionOnly)) {
					tank.SetModelSimple(scope.popProperty.TankModel.Default)
				}

				SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached.Default, 0)
				SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached.Default, 3)

				for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
					if (child.GetClassname() != "prop_dynamic") continue

					local replace_model     = -1
					local replace_model_str = ""
					local is_track          = false
					local childModelName    = child.GetModelName()

					if ("Bomb" in scope.popProperty.TankModel && childModelName == "models/bots/boss_bot/bomb_mechanism.mdl") {
						replace_model     = scope.popProperty.TankModelPrecached.Bomb
						replace_model_str = scope.popProperty.TankModel.Bomb
					}
					else if ("LeftTrack" in scope.popProperty.TankModel && childModelName == "models/bots/boss_bot/tank_track_L.mdl") {
						replace_model     = scope.popProperty.TankModelPrecached.LeftTrack
						replace_model_str = scope.popProperty.TankModel.LeftTrack
						is_track          = true
					}
					else if ("RightTrack" in scope.popProperty.TankModel && childModelName == "models/bots/boss_bot/tank_track_R.mdl") {
						replace_model     = scope.popProperty.TankModelPrecached.RightTrack
						replace_model_str = scope.popProperty.TankModel.RightTrack
						is_track          = true
					}

					if (replace_model != -1) {
						child.SetModel(replace_model_str)
						SetPropIntArray(child, "m_nModelIndexOverrides", replace_model, 0)
						SetPropIntArray(child, "m_nModelIndexOverrides", replace_model, 3)
					}

					if (is_track) {
						child.ValidateScriptScope()
						child.GetScriptScope().RestartTrackAnim <- function() {
							local animSequence = self.LookupSequence("forward")
							if (animSequence != -1) {
								self.SetSequence(animSequence)
								self.SetPlaybackRate(1.0)
								self.SetCycle(0)
							}
						}
						EntFireByHandle(child, "CallScriptFunction", "RestartTrackAnim", -1, null, null)
					}
				}
			}
		}
		else {
			if (!("lastHealth" in scope)) {
				scope.lastHealth      <- tank.GetHealth()
				scope.lastHealthStage <- 0
			}

			if (("changeTankModelIndex" in scope)) {
				if (!("TankModelVisionOnly" in scope.popProperty && scope.popProperty.TankModelVisionOnly))
					tank.SetModelSimple(scope.popProperty.TankModel[scope.changeTankModelIndex])

				SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached[scope.changeTankModelIndex], 0)
				SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached[scope.changeTankModelIndex], 3)

				delete scope.changeTankModelIndex
			}

			if (scope.lastHealth != tank.GetHealth()) {
				local health_per_model = tank.GetMaxHealth() / 4
				local health_threshold = tank.GetMaxHealth() - health_per_model
				local health_stage

				for (health_stage = 0; health_stage < 3; health_stage++) {
					if (tank.GetHealth() > health_threshold)
						break

					health_threshold -= health_per_model
				}

				if (scope.lastHealthStage != health_stage && "popProperty" in scope && "TankModel" in scope.popProperty) {
					local name = health_stage == 0 ? "Default" : "Damage" + health_stage
					scope.changeTankModelIndex <- name

					if (!("TankModelVisionOnly" in scope.popProperty && scope.popProperty.TankModelVisionOnly)) {
						tank.SetModelSimple(scope.popProperty.TankModel[name])
					}

					SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached[name], 0)
					SetPropIntArray(tank, "m_nModelIndexOverrides", scope.popProperty.TankModelPrecached[name], 3)
				}

				scope.lastHealth = tank.GetHealth()
				scope.lastHealthStage = health_stage
			}
		}
	}

	for (local i = 0; i < MAX_CLIENTS; i++) {
		local player = PlayerInstanceFromIndex(i)
		if (player == null) continue

		if (player.IsBotOfType(1337)) {
			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			local alive = PopExtUtil.IsAlive(player)
			if (alive && !("botCreated" in scope)) {
				scope.botCreated <- true

				foreach(tag, table in robotTags) {
					if (player.HasBotTag(tag)) {
						scope.popFiredDeathHook <- false
						PopExtHooks.AddHooksToScope(tag, table, scope)

						if ("OnSpawn" in table)
							table.OnSpawn(player, tag)
					}
				}
			}
			// Make sure that ondeath hook is fired always
			if (!alive && "popFiredDeathHook" in scope) {
				local scope = player.GetScriptScope() // TODO: we already got scope above?
				if (!scope.popFiredDeathHook)
					PopExtHooks.FireHooksParam(player, scope, "OnDeath", null)

				delete scope.popFiredDeathHook
			}
		}
	}

	return -1
}