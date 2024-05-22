popExtEntity <- FindByName(null, "_popext")
if (popExtEntity == null) popExtEntity = SpawnEntityFromTable("info_teleport_destination", { targetname = "_popext" })

popExtEntity.ValidateScriptScope()
PopExt <- popExtEntity.GetScriptScope()

::PopExtHooks <- {

	tankIcons = []
	icons 	  = []

	function AddHooksToScope(name, table, scope) {
		foreach(hookName, func in table) {
			// Entries in hook table must begin with 'On' to be considered hooks
			if (hookName.slice(0,2) == "On") {
				if (!("popHooks" in scope))
					scope.popHooks <- {}

				if (!(hookName in scope.popHooks))
					scope.popHooks[hookName] <- []

				scope.popHooks[hookName].append(func)
			}
			else {
				if (!("popProperty" in scope))
					scope.popProperty <- {}

				scope.popProperty[hookName] <- func

				if (hookName == "Model" || hookName == "TankModel") {
					local modelNames = typeof func == "string" ? {} : func

					if (typeof func == "string") {
						modelNames.Default <- func
						modelNames.Damage1 <- func
						modelNames.Damage2 <- func
						modelNames.Damage3 <- func
					}
					scope.popProperty[hookName] <- modelNames

					local modelNamesPrecached = {}
					foreach(k, v in modelNames)
						modelNamesPrecached[k] <- PrecacheModel(v)
					scope.popProperty.ModelPrecached <- modelNamesPrecached
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
				
				if (victim.GetClassname() == "tank_boss" && "popProperty" in scope) 
					if ("CritImmune" in scope.popProperty && scope.popProperty.CritImmune)
						params.damage_type = params.damage_type &~ DMG_CRITICAL

				else if (attacker != null && attacker.GetClassname() == "tank_boss" && "popProperty" in attackerscope && victim.IsPlayer())
					if ("CrushDamageMult" in attackerscope.popProperty)
						params.damage *= attackerscope.popProperty.CrushDamageMult

				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamage", params)
			}

			local attacker = params.attacker
			if (attacker != null && attacker.IsPlayer() && attacker.IsBotOfType(TF_BOT_TYPE)) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam(attacker, scope, "OnDealDamage", params)
			}
		}
		function OnGameEvent_player_spawn(params) {
			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()

			if (scope != null && "popWearablesToDestroy" in scope) {
				foreach(wearable in scope.popWearablesToDestroy)
					if (wearable.IsValid()) EntFireByHandle(wearable, "Kill", "", -1, null, null)

				delete scope.popWearablesToDestroy
			}

			if (player.IsBotOfType(TF_BOT_TYPE)) {
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
			local scope = player.GetScriptScope()

			if (scope != null && "popWearablesToDestroy" in scope) {
				foreach(wearable in scope.popWearablesToDestroy)
					if (wearable.IsValid()) EntFireByHandle(wearable, "Kill", "", -1, null, null)

				delete scope.popWearablesToDestroy
			}

			if (player.IsBotOfType(TF_BOT_TYPE)) {
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
			if (victim.IsBotOfType(TF_BOT_TYPE)) {
				local scope = victim.GetScriptScope()
				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamagePost", params)
			}

			local attacker = GetPlayerFromUserID(params.attacker)
			if (attacker != null && attacker.IsBotOfType(TF_BOT_TYPE)) {
				local scope = attacker.GetScriptScope()
				PopExtHooks.FireHooksParam(attacker, scope, "OnDealDamagePost", params)
			}
		}
		function OnGameEvent_player_death(params) {
			local player = GetPlayerFromUserID(params.userid)
			if (player.IsBotOfType(TF_BOT_TYPE)) {
				local scope = player.GetScriptScope()
				scope.popFiredDeathHook <- true
				PopExtHooks.FireHooksParam(player, scope, "OnDeath", params)
			}

			local attacker = GetPlayerFromUserID(params.attacker)
			if (attacker != null && attacker.IsBotOfType(TF_BOT_TYPE)) {
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
			if (victim.GetClassname() == "tank_boss") {
				local scope = victim.GetScriptScope()
				local dead  = (victim.GetHealth() - params.damageamount) <= 0

				PopExtHooks.FireHooksParam(victim, scope, "OnTakeDamagePost", params)

				if (dead && "popProperty" in scope)
				{
					if ("SoundOverrides" in scope.popProperty)
					{
						if ("EngineLoop" in scope.popProperty.SoundOverrides)
						{
							EmitSoundEx({sound_name = scope.popProperty.SoundOverrides.EngineLoop, entity = victim, flags = SND_STOP})
						}

						if ("Explodes" in scope.popProperty.SoundOverrides)
						{
							StopSoundOn("MVM.TankExplodes", PopExtUtil.Worldspawn)
							EntFire("tf_gamerules", "PlayVO", scope.popProperty.SoundOverrides.Explodes)
						}
					}
					if ("NoDeathFX" in scope.popProperty && scope.popProperty.NoDeathFX > 0)
					{
						victim.SetOrigin(victim.GetOrigin() - Vector(0, 0, 10000))
						function FindTankDestructionEnt()
						{
							for (local destruction; destruction = FindByClassnameWithin(destruction, "tank_destruction", self.GetOrigin(), 1);)
							{
								EntFireByHandle(destruction, "Kill", "", -1, null, null)
							}

							return -1
						}
						local temp = CreateByClassname("info_teleport_destination")
						temp.SetOrigin(victim.GetOrigin())
						temp.ValidateScriptScope()
						temp.GetScriptScope().FindTankDestructionEnt <- FindTankDestructionEnt
						AddThinkToEnt(temp, "FindTankDestructionEnt")
						DispatchSpawn(temp)

						if (scope.popProperty.NoDeathFX > 1)
						{
							if ("SoundOverrides" in scope.popProperty && "Explodes" in scope.popProperty.SoundOverrides) return

							StopSoundOn("MVM.TankExplodes", PopExtUtil.Worldspawn)
						}
					}
					if ("IsBlimp" in scope.popProperty && scope.popProperty.IsBlimp)
						EntFireByHandle(scope.blimpTrain, "Kill", "", -1, null, null)
				}

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
			scope.teamchanged     <- false
			scope.engineloopreplaced <- false

			scope.curHealth       <- tank.GetHealth()
			scope.lastHealthStage <- 0
			scope.TankThinkTable.Updates <- function() {
				curPos            <- self.GetOrigin()
				curVel            <- self.GetAbsVelocity()
				curSpeed          <- curVel.Length()
				lastHealthPercentage <- GetPropFloat(self, "m_lastHealthPercentage")
			}

			local tankName = tank.GetName().tolower()
			foreach(name, table in tankNamesWildcard)
				if (name == tankName)
					PopExtHooks.AddHooksToScope(tankName, table, scope)
			if (tankName in tankNames)
				PopExtHooks.AddHooksToScope(tankName, tankNames[tankName], scope)

			if ("popProperty" in scope) {
				if ("TankModel" in scope.popProperty) {
					scope.popProperty.Model <- scope.popProperty.TankModel
					delete scope.popProperty.TankModel
				}

				if ("TankModelVisionOnly" in scope.popProperty) {
					scope.popProperty.ModelVisionOnly <- scope.popProperty.TankModelVisionOnly
					delete scope.popProperty.TankModelVisionOnly
				}

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
					switch(scope.popProperty.Team.tostring().toupper()) {
						case "RED":
							scope.popProperty.Team = TF_TEAM_PVE_DEFENDERS
							break
						case "BLU":
						case "BLUE":
							scope.popProperty.Team = TF_TEAM_PVE_INVADERS
							break
						case "GRY":
						case "GRAY":
						case "GREY":
						case "SPEC":
						case "SPECTATOR":
							scope.popProperty.Team = TEAM_SPECTATOR
					}
					tank.SetTeam(scope.popProperty.Team)
					scope.teamchanged = true
					scope.team = tank.GetTeam()
				}

				//does not work
				if ("NoScreenShake" in scope.popProperty && scope.popProperty.NoScreenShake)
					ScreenShake(tank.GetOrigin(), 25.0, 5.0, 5.0, 1000.0, SHAKE_STOP, true)

				if ("IsBlimp" in scope.popProperty && scope.popProperty.IsBlimp) {
					//todo fix rage on same team tank
					if (!("DisableTracks" in scope.popProperty))
						scope.popProperty.DisableTracks <- true
					if (!("DisableBomb" in scope.popProperty))
						scope.popProperty.DisableBomb <- true
					if (!("DisableSmoke" in scope.popProperty))
						scope.popProperty.DisableSmoke <- true

					//set default blimp model if not specified
					if (!("Model" in scope.popProperty)) {
						local blimpModel = {
							Model = {
								//version of blimp where model is in the lower half of the bounding box
								Default = "models/bots/boss_bot/boss_blimp_main.mdl" // MD5: 59242bf074a617a95701b34f93b37549
								Damage1 = "models/bots/boss_bot/boss_blimp_main_damage1.mdl"
								Damage2 = "models/bots/boss_bot/boss_blimp_main_damage2.mdl"
								Damage3 = "models/bots/boss_bot/boss_blimp_main_damage3.mdl"
							}
						}

						PopExtHooks.AddHooksToScope(tank, blimpModel, scope)

						//ModelVisionOnly true is best for this blimp model
						if (!("ModelVisionOnly" in scope.popProperty))
							scope.popProperty.ModelVisionOnly <- true
					}

					if (!("Skin" in scope.popProperty))
						switch(scope.team) {
							case TF_TEAM_PVE_DEFENDERS:
							case TF_TEAM_PVE_INVADERS:
								scope.popProperty.Skin <- scope.team - 2
								break
							case TEAM_SPECTATOR:
								scope.popProperty.Skin <- 2
								break
							default:
								scope.popProperty.Skin <- 1
						}

					tank.SetAbsAngles(QAngle(0, tank.GetAbsAngles().y, 0))
					scope.blimpTrain <- SpawnEntityFromTable("func_tracktrain", {origin = tank.GetOrigin(), startspeed = INT_MAX, target = scope.popProperty.StartTrack})

					scope.TankThinkTable.BlimpThink <- function() {
						if (self == null) return //this is normally not possible, however we need to do a pretty gross hack that will turn the tank into a null instance sometimes
						self.SetAbsOrigin(blimpTrain.GetOrigin())
						self.GetLocomotionInterface().Reset()
						//update func_tracktrain if tank's speed is changed
						if (GetPropFloat(blimpTrain, "m_flSpeed") != GetPropFloat(self, "m_speed"))
							EntFireByHandle(blimpTrain, "SetSpeedReal", GetPropFloat(self, "m_speed").tostring(), -1, null, null)
					}
				}
				
				if ("Skin" in scope.popProperty)
					SetPropInt(tank, "m_nSkin", scope.popProperty.Skin)

				if ("SpawnTemplate" in scope.popProperty) {
					SpawnTemplate(scope.popProperty.SpawnTemplate, tank)
					delete scope.popProperty.SpawnTemplate
				}

				if ("DisableTracks" in scope.popProperty && scope.popProperty.DisableTracks)
					for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer())
						if (child.GetClassname() == "prop_dynamic")
							if (child.GetModelName() == "models/bots/boss_bot/tank_track_L.mdl" || child.GetModelName() == "models/bots/boss_bot/tank_track_R.mdl")
								child.DisableDraw()

				if ("DisableBomb" in scope.popProperty && scope.popProperty.DisableBomb)
					for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer())
						if (child.GetClassname() == "prop_dynamic")
							if (child.GetModelName() == "models/bots/boss_bot/bomb_mechanism.mdl") 
								child.DisableDraw()

				if ("DisableSmoke" in scope.popProperty && scope.popProperty.DisableSmoke) {
					scope.TankThinkTable.DisableSmoke <- function() {
						//disables smokestack, still emits one smoke particle when spawning and when moving out from under low ceilings (solid brushes 300 units or lower)
						EntFireByHandle(self, "DispatchEffect", "ParticleEffectStop", -1, null, null)
					}
				}

				if ("Scale" in scope.popProperty)
					EntFireByHandle(tank, "SetModelScale", scope.popProperty.Scale.tostring(), -1, null, null)

				if ("Model" in scope.popProperty) {
					if (!("ModelVisionOnly" in scope.popProperty && scope.popProperty.ModelVisionOnly))
						tank.SetModelSimple(scope.popProperty.Model.Default) //changes bbox size

					scope.curModel <- scope.popProperty.ModelPrecached.Default

					//using a think prevents tank from briefly becoming invisible when changing damage models
					scope.TankThinkTable.SetModel <- function() {
						SetPropIntArray(self, "m_nModelIndexOverrides", curModel, VISION_MODE_NONE)
						SetPropIntArray(self, "m_nModelIndexOverrides", curModel, VISION_MODE_ROME)
					}

					if ("LeftTrack" in scope.popProperty.Model) {
						scope.popProperty.Model.TrackL <- scope.popProperty.Model.LeftTrack
						delete scope.popProperty.Model.LeftTrack
						scope.popProperty.ModelPrecached.TrackL <- scope.popProperty.ModelPrecached.LeftTrack
						delete scope.popProperty.ModelPrecached.LeftTrack
					}
					if ("RightTrack" in scope.popProperty.Model) {
						scope.popProperty.Model.TrackR <- scope.popProperty.Model.RightTrack
						delete scope.popProperty.Model.RightTrack
						scope.popProperty.ModelPrecached.TrackR <- scope.popProperty.ModelPrecached.RightTrack
						delete scope.popProperty.ModelPrecached.RightTrack
					}

					for (local child = tank.FirstMoveChild(); child != null; child = child.NextMovePeer()) {

						if (child.GetClassname() != "prop_dynamic") continue

						local replace_model     = -1
						local replace_model_str = ""
						local is_track          = false
						local childModelName    = child.GetModelName()

						if ("Bomb" in scope.popProperty.Model && childModelName == "models/bots/boss_bot/bomb_mechanism.mdl") {
							replace_model     = scope.popProperty.ModelPrecached.Bomb
							replace_model_str = scope.popProperty.Model.Bomb
						}
						else if ("TrackL" in scope.popProperty.Model && childModelName == "models/bots/boss_bot/tank_track_L.mdl") {
							replace_model     = scope.popProperty.ModelPrecached.TrackL
							replace_model_str = scope.popProperty.Model.TrackL
							is_track          = true
						}
						else if ("TrackR" in scope.popProperty.Model && childModelName == "models/bots/boss_bot/tank_track_R.mdl") {
							replace_model     = scope.popProperty.ModelPrecached.TrackR
							replace_model_str = scope.popProperty.Model.TrackR
							is_track          = true
						}

						if (replace_model != -1) {
							child.SetModel(replace_model_str)
							SetPropIntArray(child, "m_nModelIndexOverrides", replace_model, VISION_MODE_NONE)
							SetPropIntArray(child, "m_nModelIndexOverrides", replace_model, VISION_MODE_ROME)
						}

						if (is_track) {
							local animSequence = child.LookupSequence("forward")
							if (animSequence != -1) {
								child.SetSequence(animSequence)
								child.SetPlaybackRate(1.0)
								child.SetCycle(0)
							}
						}
					}
				}
			}

			scope.TankThinks <- function() { foreach (name, func in scope.TankThinkTable) func.call(scope); return -1 }
			scope.TankThinks() //run thinks for availability in OnSpawn
			_AddThinkToEnt(tank, "TankThinks")

			foreach(name, table in tankNamesWildcard)
				if (name == tankName && "OnSpawn" in table)
					table.OnSpawn(tank, tankName)

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
				if (tank.GetHealth() <= 0)
					health_stage = 3
				else
					// how many quarters of maxHealth has the tank received in damage
					health_stage = floor((scope.maxHealth - tank.GetHealth())/scope.maxHealth.tofloat() * 4)

				if (scope.lastHealthStage != health_stage && "popProperty" in scope && "Model" in scope.popProperty) {
					local name = health_stage == 0 ? "Default" : "Damage" + health_stage

					if (!("ModelVisionOnly" in scope.popProperty && scope.popProperty.ModelVisionOnly))
						tank.SetModelSimple(scope.popProperty.Model[name])

					scope.curModel <- scope.popProperty.ModelPrecached[name]
				}

				scope.curHealth = tank.GetHealth() //set this here instead of Updates think to prevent conflict
				scope.lastHealthStage = health_stage
			}
		}
	}

	foreach (player in PopExtUtil.BotArray) {

		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		local alive = PopExtUtil.IsAlive(player)
		if (alive && !("botCreated" in scope)) {
			scope.botCreated <- true

			foreach(tag, table in robotTags)
				if (player.HasBotTag(tag)) {
					scope.popFiredDeathHook <- false
					PopExtHooks.AddHooksToScope(tag, table, scope)

					if ("OnSpawn" in table)
						table.OnSpawn(player, tag)
				}
		}
		// Make sure that ondeath hook is fired always
		if (!alive && "popFiredDeathHook" in scope) {
			if (!scope.popFiredDeathHook)
				PopExtHooks.FireHooksParam(player, scope, "OnDeath", null)

			delete scope.popFiredDeathHook
		}
	}

	return -1
}
