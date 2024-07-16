const EFL_SPAWNER_PENDING = 1048576 // EFL_IS_BEING_LIFTED_BY_BARNACLE
const EFL_SPAWNER_ACTIVE = 1073741824 //EFL_NO_PHYSCANNON_INTERACTION
const EFL_SPAWNER_EXPENDED = 33554432 //EFL_DONTBLOCKLOS

::PopExtPopulator <- {

	PopulatorFunctions = {

		function Mission() {
			printl("mission spawner")
		}
	}

	function InitializeWave() {
		("CustomWaveOrder" in WaveSchedule) ? PopulatorArray = WaveSchedule.CustomWaveOrder : PopulatorArray = array(WaveSchedule.len())

		foreach(wave, table in WaveSchedule) {
			if (!("CustomWaveOrder" in WaveSchedule)) PopulatorArray[wave] = table //set up the wave order

			//special support populators fire an additional function of the same name
			if (wave in PopExtPopulator.PopulatorFunctions)
				PopExtPopulator.PopulatorFunctions.wave()


			foreach (k, v in table)
			{
				k = k.tolower(); v = v.tolower()

				if ("tfbot" in table || "bot" in table)
				{
					CreateByClassname("bot_generator")

				}
			}
		}
		// foreach(wave, wavespawn in WaveSchedule) {
		// 	PopulatorArray.append(wavespawn)
		// }
	}

	function PopulationThink() {

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
		[1] = { //waveschedule
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
		}
	},

	[2] = {

	}
}
