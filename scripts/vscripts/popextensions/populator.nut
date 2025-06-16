// HOW IT WORKS:

// PopExtPopulator.InitializeWave() is fired on wave init, this is the main function that parses the WaveSchedule table.

// InitializeWave does the following:
// - Spawns bot generators at the location provided in the "Where" keyvalue and sets the appropriate keyvalues
// - attaches a think function to the generators that handles most of the spawning logic
// - Adds icons to the wavebar
// - fills out the WaveArray

// Each element in WaveArray in another array that contains the WaveSpawn information
// Each element in this nested array is a table where the key is the bot_generator, and the value is the keyvalue table for the wavespawn.
// To access the bot_generator and the keyvalues from waves and individual wavespawns, use the PopExtPopulator.GetWavespawnInfo() function.

// Major syntax differences compared to standard popfiles:
// - Does not support unordered WaveSpawns, there is a fixed order of execution.  If you wanna rearrange your wavespawns you can't just change the names/waits around
// - CASE SENSITIVE! may change this in the future but it makes table look-ups easier for now.
// - Tags and Items are applied to bots in a single array value

// TODO:
// - Tank, Halloween NPC, and SentryGun spawners
// - RandomChoice and Squad spawners
// - reliable icon decrementing

const EFL_SPAWNER_PENDING = 1048576 // EFL_IS_BEING_LIFTED_BY_BARNACLE
const EFL_SPAWNER_ACTIVE = 1073741824 //EFL_NO_PHYSCANNON_INTERACTION
const EFL_SPAWNER_EXPENDED = 33554432 //EFL_DONTBLOCKLOS
const MAX_WAVESPAWNS_PER_WAVE = 128

local PopulatorEnt = CreateByClassname( "info_teleport_destination" )

::PopExtPopulator <- {

	WaveArray = []

	SpawnHookTable = {

		function SetSpawner( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()

			local spawner = FindByClassnameNearest( "bot_generator", player.GetOrigin(), 256 )

			scope.spawner <- spawner.GetName()
			scope.bot_attributes <- BECOME_SPECTATOR_ON_DEATH

			local additional_attributes = 0

			//MVM hack: these keyvalues get removed by mvm logic from bot_generator spawned bots
			local spawner_keyvalues = {
				m_bDisableDodge = DISABLE_DODGE,
				m_bSuppressFire = SUPPRESS_FIRE,
				m_bRetainBuildings = RETAIN_BUILDINGS,
				m_iOnDeathAction = REMOVE_ON_DEATH //1 = remove
			}

			foreach ( key, value in spawner_keyvalues )
				if ( NetProps.GetPropInt( spawner, key ) ) {

					if ( key == "m_iOnDeathAction" && NetProps.GetPropInt( spawner, key ) == 1 )
						scope.bot_attributes = scope.bot_attributes |~ BECOME_SPECTATOR_ON_DEATH

					additional_attributes = additional_attributes | value
				}


			scope.bot_attributes = scope.bot_attributes | additional_attributes

			EntFireByHandle( player, "RunScriptCode", "self.AddBotAttribute( self.GetScriptScope().bot_attributes )", -1, null, null )
		}

		function WaitBetweenSpawnsAfterDeath( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			//disable our spawner if we have WaitBetweenSpawnsAfterDeath
			EntFireByHandle( player, "RunScriptCode", @"

				local spawner = FindByName( null, self.GetScriptScope().spawner )

				if ( `WaitBetweenSpawnsAfterDeath` in spawner.GetScriptScope().WaveSpawn )
					EntFire( self.GetScriptScope().spawner.tostring(), `Disable` )

			", SINGLE_TICK, null, null )
		}
	}

	DeathHookTable = {

		function RemoveIcon( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()
			PopExtUtil.PrintTable( scope )
			local spawner = FindByName( null, scope.spawner )

			PopExt.DecrementWaveIconSpawnCount( spawner.GetScriptScope().WaveSpawn.TFBot.ClassIcon, 0, 1 )
		}

		function WaitBetweenSpawnsAfterDeath( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			local spawner = FindByName( null, player.GetScriptScope().spawner )

			if ( "WaitBetweenSpawnsAfterDeath" in spawner.GetScriptScope().WaveSpawn ) {

				EntFireByHandle( spawner, "Enable", "", float delay, handle activator, handle caller )
				EntFireByHandle( spawner, "SpawnBot", "", float delay, handle activator, handle caller )
			}
		}
	}

	Events = {

		function OnGameEvent_player_death( params ) {

			local player = GetPlayerFromUserID( params.userid )
			local scope = player.GetScriptScope()

			foreach ( name, func in PopExtPopulator.DeathHookTable ) func( params )
		}

		function OnGameEvent_teamplay_round_start( params ) {

			PopExtPopulator.InitializeWave()

			PopExtPopulator.DoEntityIO( "InitWaveOutput" )

		}

		function OnGameEvent_mvm_begin_wave( params ) {

			//grab the first spawner and enable it on wave start
			local firstspawner = PopExtPopulator.WaveArray[PopExtUtil.CurrentWaveNum][0].keys()[0]
			EntFireByHandle( firstspawner, "Enable", "", -1, null, null )

			PopExtPopulator.DoEntityIO( "StartWaveOutput" )

		}

		function OnGameEvent_mvm_wave_complete( params ) {

			PopExtPopulator.DoEntityIO( "DoneOutput" )

		}
	}

	PopulatorFunctions = {

		function Mission() {
			printl( "mission spawner" )
		}
	}

	function DoEntityIO( type ) {

		if ( !( type in WaveSchedule[PopExtUtil.CurrentWaveNum] ) ) return

		local target =  WaveSchedule[PopExtUtil.CurrentWaveNum][type].Target

		local action = "", param = "", delay = -1, activator = null, caller = null

		if ( "Param" in WaveSchedule[PopExtUtil.CurrentWaveNum][type] ) param = WaveSchedule[PopExtUtil.CurrentWaveNum][type].Param
		if ( "Delay" in WaveSchedule[PopExtUtil.CurrentWaveNum][type] ) delay = WaveSchedule[PopExtUtil.CurrentWaveNum][type].Delay
		if ( "Activator" in WaveSchedule[PopExtUtil.CurrentWaveNum][type] ) activator = WaveSchedule[PopExtUtil.CurrentWaveNum][type].Activator
		if( "Caller" in WaveSchedule[PopExtUtil.CurrentWaveNum][type] ) caller = WaveSchedule[PopExtUtil.CurrentWaveNum][type].Caller

		typeof target == "instance" ? EntFireByHandle( target, action, param, delay, activator, caller ) : DoEntFire( target, action, param, delay, activator, caller )
	}

	function InitializeWave() {

		//PopulatorEnt is a null instance when this is initially called, it is valid by the time another teamplay_round_start event fires, so this works reliably
		if ( !( "WaveSchedule" in getroottable() ) || PopulatorEnt.IsValid() ) return

		WaveArray = "CustomWaveOrder" in WaveSchedule ? WaveSchedule.CustomWaveOrder : array( WaveSchedule.len() )

		foreach( wave, wavespawns in WaveSchedule ) {

			printl( "Wave: " + wave )

			if ( !( "CustomWaveOrder" in WaveSchedule ) && typeof wave == "integer" ) WaveArray[wave] = array( wavespawns.len() )

			if ( wave == "MissionAttrs" ) {

				MissionAttrs( wavespawns )
				continue
			}

			//special support populators fire an additional function of the same name
			if ( wave in PopExtPopulator.PopulatorFunctions )
				PopExtPopulator.PopulatorFunctions.wave()

			foreach ( wavespawn, keyvalues in wavespawns ) {

				printl( "\tWaveSpawn: " + wavespawn )

				foreach( k, v in keyvalues ) {
					printl( "\t\t" + k + " : " + v )
					if ( k.tolower() == "tfbot" ) {

						foreach( a, b in v ) printl( "\t\t\t" + a + " : " + b )
						local icon = ""
						local playerclass = ""

						"Class" in v ? playerclass = ( typeof v.Class != "integer" ? v.Class : PopExtUtil.Classes[v.Class] ) : playerclass = PopExtUtil.Classes[RandomInt( 1, 9 )] // don't use bot_generators "auto" here, grab a random player class string instead so we can use playerclass for icon fallback

						"ClassIcon" in v ? icon = v.ClassIcon : icon = playerclass

						PopExt.AddCustomIcon(
							icon,
							keyvalues.TotalCount,
							( "Attributes" in v && v.Attributes.find( ALWAYS_CRIT ) ) ? true : false,
							( "Attributes" in v && v.Attributes.find( MINIBOSS ) ) ? true : false,
							( "Support" in keyvalues ) ? true : false,
							( "Support" in keyvalues && ( keyvalues.Support > 1 || ( typeof keyvalues.Support == "string" && keyvalues.Support.tolower() == "limited" ) ) ) ? true : false
						)

						local generator = CreateByClassname( "bot_generator" )
						// foreach ( w in WaveArray[wave] ) printl( w )
						WaveArray[wave][wavespawn] = {}
						WaveArray[wave][wavespawn][generator] <- keyvalues

						// generator.KeyValueFromInt( "spawnOnlyWhenTriggered", "WaitBetweenSpawnsAfterDeath" in keyvalues || ( "SpawnCount" in keyvalues && keyvalues.SpawnCount > 1 ) ? 1 : 0 ) //we need manual control always for the spawn interval
						generator.KeyValueFromInt( "spawnOnlyWhenTriggered", 1 )
						// generator.KeyValueFromFloat( "interval", "WaitBetweenSpawns" in keyvalues ? keyvalues.WaitBetweenSpawns.tofloat() : SINGLE_TICK )
						generator.KeyValueFromFloat( "interval", SINGLE_TICK ) //this keyvalue is weird, just control the interval in the think function manually
						generator.KeyValueFromInt( "useTeamSpawnPoint", 0 )
						generator.KeyValueFromInt( "maxActive", keyvalues.MaxActive.tointeger() )
						generator.KeyValueFromInt( "count", keyvalues.TotalCount.tointeger() )
						generator.KeyValueFromInt( "difficulty", "Skill" in keyvalues ? keyvalues.Skill.tointeger() : 1 )
						generator.KeyValueFromInt( "disableDodge", "disableDodge" in keyvalues ? keyvalues.disableDodge.tointeger() : 0 )
						generator.KeyValueFromString( "team", "TeamString" in keyvalues ? keyvalues.TeamString : "blue" )
						generator.KeyValueFromString( "targetname", "Name" in keyvalues ? keyvalues.Name : format( "__popext_generator%d", generator.entindex() ) )
						generator.KeyValueFromString( "class", playerclass )

						local org = keyvalues.Where

						if ( typeof org == "string" ) {

							//check targetname first
							local spawnpoints = []
							for ( local ent; ent = FindByName( ent, org ); ) spawnpoints.append( ent )

							if ( spawnpoints.len() ) {

								org = spawnpoints[RandomInt( 0, spawnpoints.len() - 1 )].GetOrigin()
								return
							}

							//no targetnames found, assume KVString
							local split = split( org, " " ).apply( @( val ) val.tofloat() )

							org = Vector( split[0], split[1], split[2] )
						}

						generator.SetAbsOrigin( org )

						AddOutput( generator, "OnExpended", "!self", "RunScriptCode", "self.AddEFlags( EFL_SPAWNER_EXPENDED )", -1, -1 )

						generator.AddEFlags( EFL_SPAWNER_PENDING )
						// generator.AddEFlags( EFL_SPAWNER_PENDING )

						DispatchSpawn( generator )

						generator.AcceptInput( "Disable", "", null, null )

						generator.ValidateScriptScope()

						local genscope = generator.GetScriptScope()

						if ( "WaveSpawn" in genscope && "WaitBetweenSpawns" in genscope.WaveSpawn ) genscope.spawninterval <- genscope.WaveSpawn.WaitBetweenSpawns.tofloat()

						generator.GetScriptScope().GeneratorThink <- function() {

							if ( self.IsEFlagSet( EFL_SPAWNER_ACTIVE ) ) {

								local scope = self.GetScriptScope()

								if ( !( "spawninterval" in scope ) ) scope.spawninterval <- 0.0
								if ( !( "nextspawn" in scope ) ) scope.nextspawn <- 0.0

								if ( Time() < scope.nextspawn ) return

								//spawn 1 bot

								EntFireByHandle( self, "SpawnBot", "", -1, null, null )

								//spawncount is > 1, spawn the SpawnCount number of bots - 1 since we already did 1 above

								if ( "SpawnCount" in genscope.WaveSpawn && genscope.WaveSpawn.SpawnCount > 1 ) for ( local i = 0; i < genscope.WaveSpawn.SpawnCount - 1; i ++ ) EntFireByHandle( self, "SpawnBot", "", -1, null, null )

								scope.nextspawn <- Time() + scope.spawninterval

							}

							//we've finished spawning, look for other WaveSpawns that wait for this one and change their flag from PENDING to ACTIVE
							else if ( self.IsEFlagSet( EFL_SPAWNER_EXPENDED ) ) {

								for ( local g; g = FindByClassname( g, "bot_generator" ); ) {

									if ( !g.IsEFlagSet( EFL_SPAWNER_ACTIVE ) && "WaveSpawn" in g.GetScriptScope() && "WaitForAllSpawned" in g.GetScriptScope().WaveSpawn && self.GetName() == g.GetScriptScope().WaveSpawn.WaitForAllSpawned ) {

										self.AcceptInput( "Disable", "", null, null )
										g.AddEFlags( EFL_SPAWNER_ACTIVE )
										g.RemoveEFlags( EFL_SPAWNER_PENDING )
										g.AcceptInput( "Enable", "", null, null )

									}
								}
							}

							return -1
						}

						generator.GetScriptScope().WaveSpawn <- keyvalues
						AddThinkToEnt( generator, "GeneratorThink" )
					}
				}
			}
		}
	}
	function GetWavespawnInfo( wavenum = 0, wavespawn = 0 ) {

		// this function expects the actual wave number, not the array index ( wavenum 1 would get the array index 0 )
		wavespawn -= 1
		wavenum -= 1

		//specific wave number passed, look at wavespawns at the wavenum index
		if ( wavenum > -1 ) {

			//valid wavespawn index passed, return only information about this wavespawn
			if ( wavespawn > -1 )	{

				return PopExtPopulator.WaveArray[wavenum][wavespawn]
			}
			//wave number passed, but no wavespawn, return every wavespawn in an array
			else {
				local allwavespawns = array( PopExtPopulator.WaveArray[wavenum].len() )

				foreach( i, wavespawn in allwavespawns ) wavespawn = PopExtPopulator.WaveArray[wavenum][i]

				return allwavespawns
			}
		}

		//no wave number passed, put every wave in an array and put every wavespawn in another array at each wave
		else {

			// Create an array with each element being another MAX_WAVESPAWNS_PER_WAVE-length array.
			// If your mission has >MAX_WAVESPAWNS_PER_WAVE wavespawns on a single wave may god help you

			local allwaves = array( GetPropInt( PopExtUtil.ObjectiveResource, "m_nMannVsMachineMaxWaveCount" ), array( MAX_WAVESPAWNS_PER_WAVE,0 ) )

			foreach( i, wave in allwaves ) {

				//valid wavespawn index passed, just get this wavespawn index at every wave
				if ( wavespawn > -1 ) wave = PopExtPopulator.WaveArray[i]

				//no wavespawn index passed, get everything
				else {
					local allwavespawns = array( PopExtPopulator.WaveArray[wavenum].len(), [] )
					foreach( j, _ in PopExtPopulator.WaveArray[i] ) wave[i] = PopExtPopulator.WaveArray[i][j]
				}
			}
			return allwaves
		}
	}
}

::WaveSchedule <- {

	// CustomWaveOrder = [1,5,2,6,3]

	MissionAttrs = {
		WaveStartCountdown = 1
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
			Param = "Info( `Wave 1 loaded` )"
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
			Where = "-198.163635 4760.567871 291.313049" //accepts KVString
			TotalCount = 15
			MaxActive = 5
			WaitBetweenSpawns = 3
			Team = 3
			TFBot = {
				Class = TF_CLASS_SCOUT
				Health = 150
				ClassIcon = "scout_bat"
				Name = "Scout"
				Items = ["The Shortstop", "Bonk! Atomic Punch"]
				Tags = ["popext_addcond|11"]
			}
		},
		[2] = { //wavespawn

			Name = "wave1b"
			Where = Vector( -1071.587646, 4216.348633, 200.016907 ) //accepts vector
			TotalCount = 10
			MaxActive = 10
			SpawnCount = 2
			Team = 3
			WaitForAllSpawned = "wave1a"
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
__CollectGameEventCallbacks( PopExtPopulator.Events )
PopExtPopulator.InitializeWave()
