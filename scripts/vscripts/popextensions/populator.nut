const EFL_SPAWNER_PENDING = 1048576 // EFL_IS_BEING_LIFTED_BY_BARNACLE
const EFL_SPAWNER_ACTIVE = 1073741824 //EFL_NO_PHYSCANNON_INTERACTION
const EFL_SPAWNER_EXPENDED = 33554432 //EFL_DONTBLOCKLOS

::PopExtPopulator <- {

	WaveArray = []

	SpawnHookTable = {
		function SetSpawner(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local spawner = FindByClassnameNearest("bot_generator", self.GetOrigin(), 32)

			player.GetScriptScope().spawner <- GetPropString(spawner, "m_iName")
		}

		function WaitBetweenSpawnsAfterDeath(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			//disable our spawner if we have WaitBetweenSpawnsAfterDeath
			EntFireByHandle(player, "RunScriptCode", @"

				local spawner = FindByName(null, self.GetScriptScope().spawner)

				if (`WaitBetweenSpawnsAfterDeath` in spawner.GetScriptScope().WaveSpawn)
					EntFireByHandle(spawner, `Disable`, ``, -1, null, null)

			", SINGLE_TICK, null, null)
		}
	}

	DeathHookTable = {

		function RemoveIcon(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local scope = player.GetScriptScope()
			local spawner = FindByName(null, scope.spawner)

			PopExt.DecrementWaveIconSpawnCount(spawner.GetScriptScope().WaveSpawn.TFBot.ClassIcon, 0, 1)
		}

		function WaitBetweenSpawnsAfterDeath(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local spawner = FindByName(null, player.GetScriptScope().spawner)

			if ("WaitBetweenSpawnsAfterDeath" in spawner.GetScriptScope().WaveSpawn)
			{
				EntFireByHandle(spawner, "Enable", "", float delay, handle activator, handle caller)
				EntFireByHandle(spawner, "SpawnBot", "", float delay, handle activator, handle caller)
			}
		}
	}
	Events = {

		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()

			foreach (name, func in PopExtPopulator.SpawnHookTable) func(params)
		}
		function OnGameEvent_player_death(params) {

			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()

			foreach (name, func in PopExtPopulator.DeathHookTable) func(params)
		}

		function OnGameEvent_teamplay_round_start(params) {

			if ("InitWaveOutput" in WaveSchedule[PopExtUtil.CurrentWaveNum]) {

				local Target = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Target
				local Action = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Action

				local Param, Delay, Activator
				"Param" in WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput ? Param = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Param : ""
				"Delay" in WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput ? Delay = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Delay : -1
				"Activator" in WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput ? Activator = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Activator : null
				"Caller" in WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput ? Caller = WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Caller : null

				typeof WaveSchedule[PopExtUtil.CurrentWaveNum].InitWaveOutput.Target == "string" ? DoEntFire(Target, Action, Param, Delay, Activator, Caller) : EntFireByHandle(Target, Action, Param, Delay, Activator, Caller)
			}
		}

		function OnGameEvent_mvm_begin_wave(params) {

			if ("AutoRelay" in WaveSchedule[PopExtUtil.CurrentWaveNum]) EntFire("wave_start_relay", "Trigger")

			if ("StartWaveOutput" in WaveSchedule[PopExtUtil.CurrentWaveNum]) {

				local Target = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Target
				local Action = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Action

				local Param, Delay, Activator
				"Param" in WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput ? Param = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Param : ""
				"Delay" in WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput ? Delay = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Delay : -1
				"Activator" in WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput ? Activator = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Activator : null
				"Caller" in WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput ? Caller = WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Caller : null

				typeof WaveSchedule[PopExtUtil.CurrentWaveNum].StartWaveOutput.Target == "string" ? DoEntFire(Target, Action, Param, Delay, Activator, Caller) : EntFireByHandle(Target, Action, Param, Delay, Activator, Caller)
			}
		}

		function OnGameEvent_mvm_wave_complete(params) {

			if ("AutoRelay" in WaveSchedule[PopExtUtil.CurrentWaveNum]) EntFire("wave_finished_relay", "Trigger")

			if ("DoneOutput" in WaveSchedule[PopExtUtil.CurrentWaveNum]) {

				local Target = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Target
				local Action = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Action

				local Param, Delay, Activator
				"Param" in WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput ? Param = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Param : ""
				"Delay" in WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput ? Delay = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Delay : -1
				"Activator" in WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput ? Activator = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Activator : null
				"Caller" in WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput ? Caller = WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Caller : null

				typeof WaveSchedule[PopExtUtil.CurrentWaveNum].DoneOutput.Target == "string" ? DoEntFire(Target, Action, Param, Delay, Activator, Caller) : EntFireByHandle(Target, Action, Param, Delay, Activator, Caller)
			}
		}
	}


	PopulatorFunctions = {

		function Mission() {
			printl("mission spawner")
		}
	}

	function InitializeWave() {

		if (!("WaveSchedule" in getroottable())) return

		local WaveArray = this.WaveArray

		("CustomWaveOrder" in WaveSchedule) ? WaveArray = WaveSchedule.CustomWaveOrder : WaveArray = array(WaveSchedule.len())

		foreach(wave, wavespawns in WaveSchedule) {

			if (!("CustomWaveOrder" in WaveSchedule) && typeof wave == "integer") WaveArray[wave] = array(wavespawns.len())

			if (wave == "MissionAttrs") MissionAttributes.MissionAttrs(wavespawns)

			//special support populators fire an additional function of the same name
			if (wave in PopExtPopulator.PopulatorFunctions)
				PopExtPopulator.PopulatorFunctions.wave()

			foreach (wavespawn, keyvalues in wavespawns) {

				foreach(k, v in keyvalues) {

					if (k.tolower() == "tfbot") {
						local icon = ""
						local playerclass = ""

						"Class" in keyvalues ? playerclass = (typeof keyvalues.Class != "integer" ? keyvalues.Class : PopExtUtil.Classes[keyvalues.Class]) : playerclass = PopExtUtil.Classes[RandomInt(1, 9)] // don't use bot_generators "auto" here, grab a random player class string instead so we can use playerclass for icon fallback

						"ClassIcon" in v ? icon = v.ClassIcon : icon = playerclass

						PopExt.AddCustomIcon(
							icon,
							keyvalues.TotalCount,
							("Attributes" in v && v.Attributes.find(ALWAYS_CRIT)) ? true : false,
							("Attributes" in v && v.Attributes.find(MINIBOSS)) ? true : false,
							("Support" in keyvalues) ? true : false,
							("Support" in keyvalues && (keyvalues.Support > 1 || (typeof keyvalues.Support == "string" && keyvalues.Support.tolower() == "limited"))) ? true : false
						)

						local generator = CreateByClassname("bot_generator")
						WaveArray[wave][wavespawn] = { generator = keyvalues }

						generator.KeyValueFromInt("spawnOnlyWhenTriggered", "WaitBetweenSpawnsAfterDeath" in keyvalues || ("SpawnCount" in keyvalues && keyvalues.SpawnCount > 1) ? 1 : 0)
						generator.KeyValueFromFloat("interval", "WaitBetweenSpawns" in keyvalues ? keyvalues.WaitBetweenSpawns.tofloat() : SINGLE_TICK)
						generator.KeyValueFromInt("useTeamSpawnPoint", 0)
						generator.KeyValueFromInt("maxActive", keyvalues.MaxActive.tointeger())
						generator.KeyValueFromInt("count", keyvalues.TotalCount.tointeger())
						generator.KeyValueFromInt("difficulty", "Skill" in keyvalues ? keyvalues.Skill.tointeger() : 1)
						generator.KeyValueFromInt("disableDodge", "disableDodge" in keyvalues ? keyvalues.disableDodge.tointeger() : 0)
						generator.KeyValueFromString("team", "TeamString" in keyvalues ? keyvalues.TeamString : "blue" )
						generator.KeyValueFromString("targetname", "Name" in keyvalues ? keyvalues.Name : format("__popext_generator%d", generator.entindex()) )
						generator.KeyValueFromString("class", playerclass)

						local org = keyvalues.Where

						if (typeof org == "string")
						{
							//check targetname first
							local spawnpoints = []
							for (local ent; ent = FindByName(ent, org);) spawnpoints.append(ent)

							if (spawnpoints.len())
							{
								org = spawnpoints[RandomInt(0, spawnpoints.len() - 1)].GetOrigin()
								return
							}

							//no targetnames found, assume KVString
							local split = split(org, " ").apply(function(val) { return val.tofloat() })

							org = Vector(split[0], split[1], split[2])
						}

						generator.SetOrigin(org)

						AddOutput(generator, "OnExpended", "!self", "RunScriptCode", "self.AddEFlags(EFL_SPAWNER_EXPENDED)", -1, -1)

						generator.AddEFlags(EFL_SPAWNER_PENDING)

						DispatchSpawn(generator)

						if ("WaitForAllDead" in keyvalues || "WaitForAllSpawned" in keyvalues || "WaitBetweenSpawnsAfterDeath") EntFireByHandle(generator, "Disable", "", -1, null, null)

						generator.ValidateScriptScope()
						generator.GetScriptScope().GeneratorThink <- function() {

							//we've finished spawning, look for other WaveSpawns that wait for this one and change their flag from PENDING to ACTIVE
							if (self.IsEFlagSet(EFL_SPAWNER_EXPENDED)) {

								for (local g; g = FindByClassname(g, "bot_generator");) {

									if ("WaitForAllSpawned" in g.GetScriptScope().WaveSpawn) {

										g.AddEFlags(EFL_SPAWNER_ACTIVE)
										g.RemoveEFlags(EFL_SPAWNER_PENDING)

									}
								}
							}
							else if (generator.IsEFlagSet(EFL_SPAWNER_ACTIVE)) {

							}

							return -1
						}

						generator.GetScriptScope().WaveSpawn <- keyvalues
						AddThinkToEnt(generator, "GeneratorThink")
					}
				}
			}
		}
		// foreach(wave, wavespawn in WaveSchedule) {
		// 	PopulatorArray.append(wavespawn)
		// }
	}

	function AddBotToWave(args = {}) {

	}
}

::WaveSchedule <- {

	// CustomWaveOrder = [1,5,2,6,3]

	MissionAttrs = {
		WaveStartCountdown = 3
	}

	Mission = {
		CooldownTime = 10
		WaitBetweenSpawns = 5
		TFBot = {

		}
	},

	[1] = { //wave number

		AutoRelay = true, //set to true to automatically call wave_start_relay and wave_finished_relay without needing to define them

		InitWaveOutput = {
			Target = "bignet"
			Action = "RunScriptCode"
			Param = "Info(`Wave 1 loaded`)"
		},
		// StartWaveOutput = { //not necessary with AutoRelay
		// 	Target = "wave_start_relay"
		// 	Action = "Trigger"
		// },
		// DoneOutput = {
		// 	Target = "wave_finished_relay"
		// 	Action = "Trigger"
		// },
		[1] = { //wavespawn
			Name = "wave1a"
			Where = "500, 200, 300" //accepts KVString
			TotalCount = 5
			MaxActive = 5
			SpawnCount = 1
			WaitBetweenSpawns = 2
			Team = 3
			TFBot = {
				Class = TF_CLASS_SCOUT
				Health = 150
				ClassIcon = "scout_bat"
				Name = "Scout"
				Items = ["The Shortstop", "Bonk! Atomic Punch"]
				Tags = ["popext_usehumananimations", "popext_addcond|11"]
			}
		},
		[2] = { //wavespawn

			Name = "wave1b"
			Where = Vector(1000, 1000, 1000) //accepts vector
			TotalCount = 10
			MaxActive = 10
			SpawnCount = 2
			Team = 3
			WaitForAllDead = "wave1a"
			ActionPoint = "action_point_test"
			RetainBuildings = true

			TFBot = {
				Class = TF_CLASS_SCOUT
				Health = 150
				Name = "Scout"
				Items = ["The Shortstop", "Bonk! Atomic Punch"]
				Tags = ["popext_usehumananimations", "popext_addcond|11"]
			}
		},
		[3] = { //wavespawn

			Name = "wave1c"
			Where = "spawnbot" //accepts targetname
			TotalCount = 100
			MaxActive = 10
			SpawnCount = 5
			Team = 3
			WaitForAllDead = "wave1b"
			RetainBuildings = true

			TFBot = {
				Class = "Engineer"
				Health = 275
				Name = "Scout"
				Items = ["The Shortstop", "Bonk! Atomic Punch"]
				Tags = ["popext_usehumananimations", "popext_addcond|11"]
			}
		}
	}
}
