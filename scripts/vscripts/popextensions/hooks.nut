popExtEntity <- FindByName(null, "_popext")
if (popExtEntity == null) {
	popExtEntity <- SpawnEntityFromTable("info_teleport_destination", { targetname = "_popext" })
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
					scope.popHooks <- {}
				}

				if (!(hookName in scope.popHooks)) {
					scope.popHooks[hookName] <- []
				}

				scope.popHooks[hookName].append(func)
			}
			else {
				if (!("popProperty" in scope)) {
					scope.popProperty <- {}
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
			local attacker = params.attacker
			if (victim != null) {

				local scope = victim.GetScriptScope()
				local attackerscope = attacker.GetScriptScope()
				if (victim.GetClassname() == "tank_boss" && "popProperty" in scope) {

					if (params.damage >= victim.GetHealth()) {
						if ("SoundOverrides" in scope.popProperty && "EngineLoop" in scope.popProperty.SoundOverrides)
						EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.EngineLoop, entity = victim, flags = SND_STOP})
						victim.RemoveEFlags(EFL_KILLME)

						if (params.damage >= victim.GetHealth() && "SoundOverrides" in scope.popProperty && "Destroy" in scope.popProperty.SoundOverrides)
							EntFire("tf_gamerules", "PlayVO", scope.popProperty.SoundOverrides.Destroy)
					}
					if ("CritImmune" in scope.popProperty && scope.popProperty.CritImmune)
						params.damage_type = params.damage_type &~ DMG_CRITICAL


				}
				else if (attacker != null && attacker.GetClassname() == "tank_boss" && "popProperty" in attackerscope && victim.IsPlayer())
					if ("CrushDamageMult" in attackerscope.popProperty)
						params.damage *= attackerscope.popProperty.CrushDamageMult


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

			// if (player.GetScriptScope() != null && "popWearablesToDestroy" in player.GetScriptScope()) {
			// 	foreach(i, wearable in player.GetScriptScope().popWearablesToDestroy)
			// 		if (wearable.IsValid())
			// 			wearable.Kill()

			// 	delete player.GetScriptScope().popWearablesToDestroy
			// }
		}
		function OnGameEvent_npc_hurt(params) {

			local victim = EntIndexToHScript(params.entindex)
			if (victim != null && victim.GetClassname() == "tank_boss") {
				local scope = victim.GetScriptScope()
				local dead  = (victim.GetHealth() - params.damageamount) <= 0

				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamagePost", params)

				if (dead && "popProperty" in scope && "SoundOverrides" in scope.popProperty && "Destroy" in scope.popProperty.SoundOverrides)
					StopSoundOn("MVM.TankExplodes", PopExtUtil.Worldspawn)

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
						if (PopExt.GetWaveIconSpawnCount("tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL) > 0 && PopExt.GetWaveIconSpawnCount(icon.name, flags) > 0)
						PopExt.IncrementWaveIconSpawnCount("tank", MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1, false)

						// Decrement custom tank icon when killed.
						PopExt.DecrementWaveIconSpawnCount(icon.name, flags, 1, false)
					}

					PopExtHooks.FireHooksParam(victim, scope, "OnDeath", params)
				}
			}
		}
		function OnGameEvent_mvm_begin_wave(params) {

			if ("waveIconsFunction" in PopExt)
				PopExt.waveIconsFunction()

			foreach(v in PopExtHooks.tankIcons)
				PopExt._PopIncrementTankIcon(v)

			foreach(v in PopExtHooks.icons)
				PopExt._PopIncrementIcon(v)
		}
		function OnGameEvent_teamplay_round_win(params) {
			for (local tank; tank = FindByClassname(tank, "tank_boss");) {
				local scope = tank.GetScriptScope()
				if ("popProperty" in scope && "SoundOverrides" in scope.popProperty && "EngineLoop" in scope.popProperty.SoundOverrides)
					tank.AddEFlags(EFL_KILLME)
			}
		}
		function OnGameEvent_recalculate_holidays(params) {

			if ("waveIconsFunction" in PopExt)
				delete PopExt.waveIconsFunction

			tankIcons <- []
			icons     <- []

			local tankstokill = []
			for (local tank; tank = FindByClassname(tank, "tank_boss");) {

				local scope = tank.GetScriptScope()

				EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.EngineLoop, entity = tank, flags = SND_STOP})

				tank.RemoveEFlags(EFL_KILLME)
				tankstokill.append(tank)
			}

			//entfire kill is too late, need to kill it on the same frame like this.
			for (local i = tankstokill.len() - 1; i >= 0; i--)
				tankstokill[i].Kill()
		}
	}
}
__CollectGameEventCallbacks(PopExtHooks.Events)
function PopulatorThink() {

	for (local tank; tank = FindByClassname(tank, "tank_boss");) {
		tank.ValidateScriptScope()
		local scope = tank.GetScriptScope()

		if (!("created" in scope)) {
			scope.created         <- true
			scope.TankThinkTable  <- {}
			scope.maxHealth       <- tank.GetMaxHealth()
			scope.team            <- tank.GetTeam()
			scope.teamchanged <- false
			scope.engineloopreplaced <- false

			scope.curHealth       <- tank.GetHealth()
			scope.lastHealthStage <- 0
			scope.TankThinkTable.Updates <- function() {
				this.curPos       <- self.GetOrigin()
				this.curVel       <- self.GetAbsVelocity()
				this.curSpeed     <- curVel.Length()
				this.lastHealthPercentage <- GetPropFloat(self, "m_lastHealthPercentage")
			}

			local tankName = tank.GetName().tolower()
			foreach(name, table in tankNamesWildcard) {
				if (name == tankName || name == tankName.slice(0, name.len()))
					PopExtHooks.AddHooksToScope(tankName, table, scope)
			}
			if (tankName in tankNames)
				PopExtHooks.AddHooksToScope(tankName, tankNames[tankName], scope)
			if ("popProperty" in scope) {
				if ("SoundOverrides" in scope.popProperty) {

					foreach (k, v in scope.popProperty.SoundOverrides)
						PrecacheSound(v)

					local cooldowntime = 0.0
					if ("Ping" in scope.popProperty.SoundOverrides) {

						scope.TankThinkTable.PingSound <- function() {
							StopSoundOn("MVM.TankPing", self)

							if (Time() < cooldowntime) return

							EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.Ping, entity = tank})

							cooldowntime = Time() + 5.0
						}
					}
					if ("EngineLoop" in scope.popProperty.SoundOverrides && !scope.engineloopreplaced) {

							StopSoundOn("MVM.TankEngineLoop", tank)
							EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.EngineLoop, entity = tank})
							scope.engineloopreplaced = true
					}
					if ("Start" in scope.popProperty.SoundOverrides) {
						StopSoundOn("MVM.TankStart", tank)
						EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.Start, entity = tank})
						delete scope.popProperty.SoundOverrides.Start
					}
					if ("Deploy" in scope.popProperty.SoundOverrides) {
						
						//tank becomes a null reference when we start deploying
						//store the sound in a variable to still play it, then delete the think function when this happens

						local deploysound = scope.popProperty.SoundOverrides.Deploy

						scope.TankThinkTable.DeploySound <- function() {
							
							if (self.GetSequence() != self.LookupSequence("deploy")) return

							StopSoundOn("MVM.TankDeploy", self)

							if ("EngineLoop" in scope.popProperty.SoundOverrides)
								EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.EngineLoop, entity = tank, flags = SND_STOP})

							EmitSoundEx({sound_name = deploysound, entity = tank})

							if (tank == null) 
							{
								delete scope.TankThinkTable.DeploySound
								return
							}

							delete scope.popProperty.SoundOverrides.Deploy
						}
					}
				}

				if ("Team" in scope.popProperty && !scope.teamchanged) {
					tank.SetTeam(scope.popProperty.Team)
					scope.teamchanged = true
					scope.team = tank.GetTeam()
				}

				//does not work
				if ("NoScreenShake" in scope.popProperty && scope.popProperty.NoScreenShake)
					ScreenShake(tank.GetOrigin(), 25.0, 5.0, 5.0, 1000.0, SHAKE_STOP, true)

				if ("IsBlimp" in scope.popProperty && scope.popProperty.IsBlimp) {
					//todo alias Model to TankModel, check for tank spawn sound, test turning off reset locomotion, test null model hitbox in raf and here, test rage on same team tank
					scope.popProperty.DisableTracks <- true
					scope.popProperty.DisableBomb <- true
					scope.popProperty.DisableSmoke <- true

					//set default blimp model if not specified
					if (!("TankModel" in scope.popProperty)) {
						local blimpModel = {
							TankModel = {
								Default = "models/bots/boss_bot/boss_blimp.mdl"
								Damage1 = "models/bots/boss_bot/boss_blimp_damage1.mdl"
								Damage2 = "models/bots/boss_bot/boss_blimp_damage2.mdl"
								Damage3 = "models/bots/boss_bot/boss_blimp_damage3.mdl"
								LeftTrack = "models/bots/boss_bot/tankred_track_l.mdl"
								RightTrack = "models/bots/boss_bot/tankred_track_r.mdl"
								Bomb = "models/bots/boss_bot/bombblue_mechanism.mdl"
							}
						}

						PopExtHooks.AddHooksToScope(tank, blimpModel, scope)
					}

					tank.SetAbsAngles(QAngle(0, tank.GetAbsAngles().y, 0))
					tank.KeyValueFromString("OnKilled", "!self, RunScriptCode, blimpTrain.Kill(), -1, -1") // todo callscriptfunction
					local tankspeed = GetPropFloat(tank, "m_speed")
					scope.blimpTrain <- SpawnEntityFromTable("func_tracktrain", {origin = tank.GetOrigin(), speed = tankspeed, startspeed = tankspeed, target = scope.popProperty.StartTrack})

					scope.TankThinkTable.BlimpThink <- function() {
						if (self == null) return //this is normally not possible, however we need to do a pretty gross hack that will turn the tank into a null instance sometimes
						self.SetAbsOrigin(blimpTrain.GetOrigin())
						self.GetLocomotionInterface().Reset()
					}
				}

				if ("SpawnTemplate" in scope.popProperty) {
					SpawnTemplates.SpawnTemplate(scope.SpawnTemplate, tank, tank.GetOrigin(), tank.GetLocalAngles())
					delete scope.popProperty.SpawnTemplate
				}
				if ("DisableTracks" in scope.popProperty && scope.popProperty.DisableTracks) {
					for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
						if (child.GetClassname() != "prop_dynamic") continue

						if (child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl") {
							SetPropInt(child, "m_fEffects", GetPropInt(child, "m_fEffects") | 32)
						}
					}
				}

				if ("DisableBomb" in scope.popProperty && scope.popProperty.DisableBomb) {
					for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
						if (child.GetClassname() != "prop_dynamic") continue

						if (child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl") {
							SetPropInt(child, "m_fEffects", GetPropInt(child, "m_fEffects") | 32)
						}
					}
				}

				if ("DisableSmoke" in scope.popProperty && scope.popProperty.DisableSmoke) {

					scope.TankThinkTable.DisableSmoke <- function() {
						//disables smokestack, will emit one smoke particle when spawning and when moving out from under low ceilings (solid brushes 300 units or lower)
						EntFireByHandle(self, "DispatchEffect", "ParticleEffectStop", -1, null, null)
					}
				}

				if ("Scale" in scope.popProperty)
					EntFireByHandle(tank, "SetModelScale", scope.popProperty.Scale, -1, null, null)

				if ("TankModel" in scope.popProperty) {
					if (!("TankModelVisionOnly" in scope.popProperty && scope.popProperty.TankModelVisionOnly))
						tank.SetModelSimple(scope.popProperty.TankModel.Default) //changes bbox size

					scope.curModel <- scope.popProperty.TankModelPrecached.Default

					scope.TankThinkTable.SetTankModel <- function() {
						SetPropIntArray(self, "m_nModelIndexOverrides", curModel, VISION_MODE_NONE)
						SetPropIntArray(self, "m_nModelIndexOverrides", curModel, VISION_MODE_ROME)
					}

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

			scope.TankThinks <- function() { foreach (name, func in scope.TankThinkTable) func(); return -1 }
			scope.TankThinks() //run thinks for availability in OnSpawn
			_AddThinkToEnt(tank, "TankThinks")

			foreach(name, table in tankNamesWildcard) {

				if ((name == tankName || name == tankName.slice(0, name.len())) && "OnSpawn" in table)
					table.OnSpawn(tank, tankName)
			}

			if (tankName in tankNames) {
				local table = tankNames[tankName]
				if ("OnSpawn" in table)
					table.OnSpawn(tank, tankName)
			}
		}
		else {
			//sets damaged tank models
			if (scope.curHealth != tank.GetHealth()) {
				local health_stage
				if (tank.GetHealth() <= 0) {
					health_stage = 3
				} else {
					//determines how many quarters of maxHealth the tank has received in damage
					health_stage = floor((scope.maxHealth - tank.GetHealth())/scope.maxHealth.tofloat() * 4)
				}

				if (scope.lastHealthStage != health_stage && "TankModel" in scope.popProperty) {
					local name = health_stage == 0 ? "Default" : "Damage" + health_stage

					if (!("TankModelVisionOnly" in scope.popProperty && scope.popProperty.TankModelVisionOnly))
						tank.SetModelSimple(scope.popProperty.TankModel[name])

					scope.curModel <- scope.popProperty.TankModelPrecached[name]
				}

				scope.curHealth = tank.GetHealth() //set this here instead of Updates think to prevent conflict
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
