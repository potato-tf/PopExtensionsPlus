const EFL_SPAWNER_PENDING = 1048576 // EFL_IS_BEING_LIFTED_BY_BARNACLE
const EFL_SPAWNER_ACTIVE = 1073741824 //EFL_NO_PHYSCANNON_INTERACTION
const EFL_SPAWNER_EXPENDED = 33554432 //EFL_DONTBLOCKLOS

::PopExtPopulator <- {

	SpawnHookTable = {
		function SetSpawner(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local spawner = FindByClassnameNearest("bot_generator", self.GetOrigin(), 32)

			player.GetScriptScope().spawner <- spawner
		}

		function WaitBetweenSpawnsAfterDeath(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			//disable our spawner if we have WaitBetweenSpawnsAfterDeath
			EntFireByHandle(player, "RunScriptCode", @"

				local spawner = self.GetScriptScope().spawner

				if (`WaitBetweenSpawnsAfterDeath` in spawner.GetScriptScope().WaveSpawn)
					EntFireByHandle(spawner, `Disable`, ``, -1, null, null)

			", SINGLE_TICK, null, null)
		}
	}

	DeathHookTable = {
		function WaitBetweenSpawnsAfterDeath(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			local spawner = player.GetScriptScope().spawner

			if ("WaitBetweenSpawnsAfterDeath" in spawner.GetScriptScope().WaveSpawn)
				EntFireByHandle(spawner, "Enable", "", float delay, handle activator, handle caller)
		}
	}
	Events = {
		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()

			foreach (name, func in PopExtPopulator.SpawnHookTable) func.call(scope)
		}
		function OnGameEvent_player_death(params) {

			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()

			foreach (name, func in PopExtPopulator.DeathHookTable) func.call(scope)
		}
	}


	PopulatorFunctions = {

		function Mission() {
			printl("mission spawner")
		}
	}

	function InitializeWave() {

		("CustomWaveOrder" in WaveSchedule) ? PopulatorArray = WaveSchedule.CustomWaveOrder : PopulatorArray = array(WaveSchedule.len())

		foreach(wave, wavespawns in WaveSchedule) {
			if (!("CustomWaveOrder" in WaveSchedule) && typeof wave == "integer") PopulatorArray[wave] = array(keyvalues.len())

			//special support populators fire an additional function of the same name
			if (wave in PopExtPopulator.PopulatorFunctions)
				PopExtPopulator.PopulatorFunctions.wave()

			foreach (wavespawn, keyvalues in wavespawns) {

				if (k.tolower() == "tfbot" || k.tolower() == "bot") {

					local generator = CreateByClassname("bot_generator")
					PopulatorArray[wave][wavespawn] = { generator = keyvalues }

					generator.KeyValueFromInt("spawnOnlyWhenTriggered", "WaitBetweenSpawnsAfterDeath" in table || "SpawnCount" ? 1 : 0)
					generator.KeyValueFromFloat("interval", "WaitBetweenSpawns" in table ? keyvalues.WaitBetweenSpawns.tofloat() : SINGLE_TICK)
					generator.KeyValueFromInt("useTeamSpawnPoint", 1)
					generator.KeyValueFromInt("maxActive", keyvalues.MaxActive.tointeger())
					generator.KeyValueFromInt("count", keyvalues.TotalCount.tointeger())
					generator.KeyValueFromInt("difficulty", "Skill" in table ? keyvalues.Skill.tointeger() : 1)
					generator.KeyValueFromInt("disableDodge", "disableDodge" in table ? keyvalues.disableDodge.tointeger() : 0)
					generator.KeyValueFromString("team", "TeamString" in table ? keyvalues.TeamString : "blue" )
					generator.KeyValueFromString("targetname", "Name" in table ? keyvalues.Name : format("__popext_generator%d", generator.entindex()) )
					generator.KeyValueFromString("class", "Class" in table ? (typeof keyvalues.Class != "integer" ? keyvalues.Class : PopExtUtil.Classes[keyvalues.Class]) : PopExtUtil.Classes[RandomInt(1, 9)])

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

					if ("WaitForAllDead" in table || "WaitForAllSpawned" in table || "WaitBetweenSpawnsAfterDeath") EntFireByHandle(generator, "Disable", "", -1, null, null)

					generator.ValidateScriptScope()
					generator.GetScriptScope().WaveSpawn <- table
				}
			}
		}
		// foreach(wave, wavespawn in WaveSchedule) {
		// 	PopulatorArray.append(wavespawn)
		// }
	}

	function PopulationThink() {

		for (local generator; generator = FindByClassname(generator, "bot_generator");) {

		}
	}

	function AddBotToWave(args = {}) {

	}
}

::WaveSchedule <- {

	// CustomWaveOrder = [1,5,2,6,3]

	MissionAttrs = {

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
		StartWaveOutput = {
			Target = "wave_start_relay"
			Action = "Trigger"
		},
		DoneOutput = {
			Target = "wave_finished_relay"
			Action = "Trigger"
		},
		[1] = { //wavespawn
			Name = "wave1a"
			Where = "500, 200, 300"
			TotalCount = 100
			MaxActive = 10
			SpawnCount = 2
			Team = 3
			TFBot = {
				Class = TF_CLASS_SCOUT
				Health = 150
				Name = "Scout"
				Items = ["The Shortstop", "Bonk! Atomic Punch"]
				Tags = ["popext_usehumananimations", "popext_addcond|11"]
			}
		},
		[2] = { //wavespawn

			Name = "wave1b"
			Where = Vector(1000, 1000, 1000)
			TotalCount = 100
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
			Where = "spawnbot"
			TotalCount = 100
			MaxActive = 10
			SpawnCount = 2
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
	},

	[2] = {

	}
}
