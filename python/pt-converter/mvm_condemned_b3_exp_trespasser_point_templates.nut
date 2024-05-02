::PointTemplates <-
{
	disable130 =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "runscriptcode",
				Param = "function Think(){self.RemoveCond(130);return -1};AddThinkToEnt(self,`Think`)",
			},
		},
		[1] =
		{
			OnParentKilledOutput =
			{
				Target = "!activator",
				Action = "runscriptcode",
				Param = "AddThinkToEnt(self,null)",
			},
		},
	},
	overlay_stuff =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "aliveblu_checker",
				Action = "Trigger",
				Delay = 0.1,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "overlay_command_relay",
				Action = "Trigger",
				Delay = 0.21,
			},
		},
		[2] =
		{
			point_clientcommand =
			{
				targetname = "commandme",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "clear_overlay_brush",
				spawnflags = 1,
				StartDisabled = 1,
				mins = "-1 -1 -1",
				maxs = "1 1 1",
				origin = "0 0 30",
				"OnStartTouch#1" : "commandme,Command,r_screenoverlay ~,0,-1",
				"OnStartTouch#2" : "!self,Kill,,0.1,-1",
			},
		},
		[4] =
		{
			logic_relay =
			{
				targetname = "overlay_command_relay",
				"OnTrigger#1" : "commandme,Command,r_screenoverlay effects/combine_binocoverlay,0,-1",
				StartDisabled = 1,
			},
		},
		[5] =
		{
			filter_activator_name =
			{
				targetname = "filter_aliveblu_overlay",
				filtername = "aliveblu",
				"OnPass#1" : "overlay_command_relay,Enable,,0,-1",
				"OnFail#1" : "overlay_command_relay,Disable,,0,-1",
				"OnFail#2" : "clear_overlay_brush,Enable,,0,-1",
			},
		},
		[6] =
		{
			logic_relay =
			{
				targetname = "aliveblu_checker",
				spawnflags = 2,
				"OnTrigger#1" : "!self,Trigger,,0.1,-1",
				"OnTrigger#2" : "filter_aliveblu_overlay,TestActivator,!activator,0,-1",
			},
		},
	},
	ModelandScale_FailSafe_Scout =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/scout.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Soldier =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/soldier.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Pyro =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/pyro.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Demo =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/demo.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Heavy =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/heavy.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Engie =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/engineer.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Medic =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/medic.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Sniper =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/sniper.mdl",
				Delay = 0.1,
			},
		},
	},
	ModelandScale_FailSafe_Spy =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$SetModelOverride",
				Param = "models/player/spy.mdl",
				Delay = 0.1,
			},
		},
	},
	reviveredasblu_player =
	{
		[0] =
		{
			OnParentKilledOutput =
			{
				Target = "lastcounter",
				Action = "subtract",
				Param = 1,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "lastcounter",
				Action = "add",
				Param = 1,
			},
		},
		[2] =
		{
			OnSpawnOutput =
			{
				Target = "users",
				Action = "trigger",
			},
		},
		[3] =
		{
			OnParentKilledOutput =
			{
				Target = "!activator",
				Action = "addoutput",
				Param = "targetname deadred",
			},
		},
		[4] =
		{
			logic_relay =
			{
				targetname = "users",
				"ontrigger#1" : "!activatoraddoutputonuser1 !self:RunScriptCode:self.AddCustomAttribute(`cancel falling damage`, 1, -1):0:-10-1,0,-1",
				"ontrigger#2" : "!activator,addoutput,onuser1 !self:RunScriptCode:self.RemoveCustomAttribute(`cancel falling damage`):5:-1,0,-1",
			},
		},
	},
	reviveredasblu =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				targetname = "newlifetoblu",
				"ontrigger#1" : "redtargetname,disable,,0,-1",
				"ontrigger#2" : "deadredtele,enable,,0,-1",
				"ontrigger#3" : "deadred,$forcerespawndead,,0.05,-1",
				"ontrigger#4" : "redtargetname,enable,,0.5,-1",
				"ontrigger#5" : "deadredtele,disable,,0.5,-1",
			},
		},
		[1] =
		{
			filter_activator_name =
			{
				targetname = "filter_deadred",
				filtername = "deadred",
			},
		},
		[2] =
		{
			filter_activator_name =
			{
				targetname = "filter_aliveblu_no",
				negated = 1,
				filtername = "aliveblu",
			},
		},
		[3] =
		{
			filter_activator_name =
			{
				targetname = "filter_aliveblu",
				filtername = "aliveblu",
			},
		},
		[4] =
		{
			trigger_multiple =
			{
				targetname = "redtargetname",
				mins = "-152 -368 -160",
				maxs = "152 368 160",
				origin = "856 1280 352",
				filtername = "filter_deadred",
				spawnflags = 1,
				"onstarttouch#1" : "!activator,addoutput,targetname alivered,0,-1",
			},
		},
		[5] =
		{
			trigger_teleport =
			{
				targetname = "deadredtele",
				mins = "-152 -368 -160",
				maxs = "152 368 160",
				origin = "856 1280 352",
				spawnflags = 1,
				filtername = "filter_deadred",
				target = "bluspawnpoint",
				startdisabled = 1,
			},
		},
		[6] =
		{
			info_teleport_destination =
			{
				targetname = "bluspawnpoint",
				origin = "-1885 -561 60",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				filtername = "filter_deadred",
				origin = "-1885 -561 60",
				mins = "-64 -64 -64",
				maxs = "64 64 64",
				spawnflags = 1,
				"onstarttouch#1" : "!activator,addoutput,targetname aliveblu,0,-1",
				"onstarttouch#2" : "!activator,RunScriptCode,self.AddCond(43),0,-1",
				"onstarttouch#3" : "!activator,RunScriptCode,self.AddCond(114),0,-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 0)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 1)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 3)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 4)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 5)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.StripWeapon(self, 6)0-1",
				onstarttouch = "!activatorRunScriptCodePopExtUtil.WeaponSwitchSlot(self, 2)0-1",
				"onstarttouch#4" : "!activatorRunScriptCodeself.AddCustomAttribute(`SET BONUS: special dsp`, 38, -1)0-1,0,-1",
				"onstarttouch#5" : "!activatorRunScriptCodeself.AddCustomAttribute(`damage penalty`, 0.5, -1)0-1,0,-1",
				"onstarttouch#6" : "!activatorRunScriptCodeself.AddCustomAttribute(`increased jump height`, 1, -1)0-1,0,-1",
				"onstarttouch#7" : "!activatorRunScriptCodeself.AddCustomAttribute(`dmg taken from crit reduced`, 1, -1)0-1,0,-1",
				"onstarttouch#8" : "!activator,SetCustomModelWithClassAnimations,models/bots/soldier/bot_soldier_gibby.mdl,0.1,-1",
			},
		},
		[8] =
		{
			trigger_stun =
			{
				filtername = "filter_aliveblu",
				origin = "0 1440 228",
				mins = "-9999 -9999 -9999",
				maxs = "9999 9999 9999",
				move_speed_reduction = 0.75,
				stun_effects = 1,
				stun_duration = 6,
				spawnflags = 1,
			},
		},
	},
	p_tankcolored =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "color",
				Param = "0 0 0",
			},
		},
	},
	p_money =
	{
		NoFixup = 1,
		[0] =
		{
			info_particle_system =
			{
				targetname = "money",
				effect_name = "mvm_cash_embers",
				flag_as_weather = 0,
				start_active = 1,
			},
		},
	},
	p_kaboom =
	{
		NoFixup = 1,
		[0] =
		{
			info_particle_system =
			{
				targetname = "kaboom",
				effect_name = "firesmoke_collumnP",
				flag_as_weather = 0,
				start_active = 0,
			},
		},
	},
	p_rock_pusher =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "-1088 984 48",
				mins = "-112 -40 -144",
				maxs = "112 40 144",
				pushdir = "0 -75 0",
				spawnflags = 1,
				speed = 180,
				targetname = "rock_pusher",
			},
		},
	},
	p_crash =
	{
		NoFixup = 1,
		[0] =
		{
			info_particle_system =
			{
				effect_name = "hightower_smoke",
				flag_as_weather = 0,
				start_active = 1,
			},
		},
	},
	p_barnaclehead =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barnacle1",
				model = "models/bornacle.mdl",
				rendercolor = "100 100 100",
				modelscale = 4,
				solid = 0,
				angles = "0 0 -180",
				origin = "0 0 5",
				disableshadows = 1,
				DefaultAnim = "chew_humanoid",
			},
		},
	},
	p_virofix =
	{
		NoFixUp = 1,
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				filtername = "filter_virophage",
				origin = "641 304 -49",
				mins = "-50 -42 -124",
				maxs = "50 42 124",
				pushdir = "-60 -35 0",
				spawnflags = 1,
				speed = 1000,
				StartDisabled = 1,
				targetname = "barrel_pusher",
			},
		},
		[1] =
		{
			trigger_catapult =
			{
				targetname = "jump_barrel",
				useThresholdCheck = 0,
				useExactVelocity = 0,
				upperThreshold = 0.30,
				StartDisabled = 0,
				spawnflags = 3,
				playerSpeed = 350,
				physicsSpeed = 325,
				origin = "641 304 -49",
				mins = "-50 -42 -15",
				maxs = "50 42 15",
				onlyVelocityCheck = 0,
				lowerThreshold = 0.15,
				launchTarget = "jumptarget_barrel",
				launchDirection = "-90 0 -90",
				filtername = "filter_virophage",
				exactVelocityChoiceType = 0,
				entryAngleTolerance = 0.0,
				applyAngularImpulse = 0,
				AirCtrlSupressionTime = -1.0,
				"OnCatapulted#1" : "barrel_pusher,Enable,,0.15,-1",
				"OnCatapulted#2" : "barrel_pusher,Disable,,0.5,-1",
				"OnCatapulted#3" : "catapult_buffer,Trigger,,0,-1",
			},
		},
		[2] =
		{
			logic_relay =
			{
				targetname = "catapult_buffer",
				"OnTrigger#1" : "jump_barrel,Disable,,0,-1",
				"OnTrigger#2" : "jump_barrel,Enable,,2,-1",
			},
		},
		[3] =
		{
			filter_tf_bot_has_tag =
			{
				Negated = "Allow entities that match criteria",
				require_all_tags = 1,
				tags = "bot_virophage",
				targetname = "filter_virophage",
			},
		},
		[4] =
		{
			info_target =
			{
				targetname = "jumptarget_barrel",
				origin = "675 282 144",
			},
		},
	},
	p_virofix2 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_multiple =
			{
				targetname = "jump_generator_fix",
				spawnflags = 1,
				StartDisabled = 0,
				filtername = "filter_red",
				mins = "-66 -45 -96",
				maxs = "66 45 96",
				origin = "3 1232 160",
				"OnStartTouch#1" : "jump_generator,Enable,,0,-1",
				"OnEndTouch#1" : "jump_generator,Disable,,0.5,-1",
				"OnEndTouch#2" : "jump_generator_relay,CancelPending,0.5,0,-1",
			},
		},
		[1] =
		{
			trigger_catapult =
			{
				targetname = "jump_generator",
				useThresholdCheck = 0,
				useExactVelocity = 0,
				upperThreshold = 0.30,
				StartDisabled = 0,
				spawnflags = 3,
				playerSpeed = 350,
				physicsSpeed = 325,
				origin = "-24 1231 83",
				mins = "-85 -45 -18",
				maxs = "85 45 18",
				onlyVelocityCheck = 0,
				lowerThreshold = 0.15,
				launchTarget = "jumptarget_generator",
				launchDirection = "-90 0 0",
				filtername = "filter_virophage",
				exactVelocityChoiceType = 0,
				entryAngleTolerance = 0.0,
				applyAngularImpulse = 0,
				AirCtrlSupressionTime = -1.0,
				StartDisabled = 1,
				"OnCatapulted#1" : "jump_generator_relay,Trigger,,0,-1",
			},
		},
		[2] =
		{
			logic_relay =
			{
				targetname = "jump_generator_relay",
				"OnTrigger#1" : "jump_generator,Disable,,0,-1",
				"OnTrigger#2" : "jump_generator,Enable,,3,-1",
			},
		},
		[3] =
		{
			info_target =
			{
				targetname = "jumptarget_generator",
				origin = "34 1248 250",
			},
		},
	},
	p_spawnfix =
	{
		NoFixup = 1,
		[0] =
		{
			func_brush =
			{
				origin = "992 3072 832",
				mins = "-32 -64 -398",
				maxs = "32 64 398",
			},
		},
	},
	sentry_collision_template =
	{
		NoFixup = 1,
		[0] =
		{
			logic_timer =
			{
				refiretime = 3,
				"ontimer#1" : "obj_sentrygunRunScriptCodeNetProps.SetPropInt(self, `m_CollisionGroup`, 3)0-1,0,-1",
			},
		},
	},
	p_skullhead =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "skull1",
				model = "models/props_viaduct_event/skull_island01.mdl",
				rendercolor = "100 100 100",
				modelscale = 0.075,
				solid = 0,
				angles = "0 90 45",
				origin = "10 0 100",
				disableshadows = 1,
				lightingorigin = "barnacle1",
			},
		},
	},
	p_fade1 =
	{
		NoFixup = 1,
		[0] =
		{
			env_fade =
			{
				targetname = "fade",
				angles = "0 0 0",
				duration = 3,
				rendercolor = "0 0 0",
				spawnflags = 8,
			},
		},
	},
	p_fade2 =
	{
		NoFixup = 1,
		[0] =
		{
			env_fade =
			{
				targetname = "fade2",
				angles = "0 0 0",
				duration = 3,
				rendercolor = "0 0 0",
				spawnflags = 1,
			},
		},
	},
	p_fade3 =
	{
		NoFixup = 1,
		[0] =
		{
			env_fade =
			{
				targetname = "fade3",
				angles = "0 0 0",
				duration = 10,
				rendercolor = "85 0 0",
				spawnflags = 1,
			},
		},
	},
	p_fade4 =
	{
		NoFixup = 1,
		[0] =
		{
			env_fade =
			{
				targetname = "fade4",
				angles = "0 0 0",
				duration = 6,
				rendercolor = "0 0 0",
				spawnflags = 1,
			},
		},
	},
	p_fade5 =
	{
		NoFixup = 1,
		[0] =
		{
			env_fade =
			{
				targetname = "fade5",
				angles = "0 0 0",
				duration = 1,
				rendercolor = "0 0 0",
				spawnflags = 1,
			},
		},
	},
	p_finale_facer =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "cheese",
				mins = "-3392 -3392 -704",
				maxs = "3392 3392 704",
				origin = "768 768 576",
				spawnflags = 1,
				StartDisabled = 1,
				target = "finale_face_target",
				filtername = "filter_red",
				"OnStartTouch#1" : "cheese,Kill,,0,-1",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "finale_face_target",
				origin = "617 -609 0",
				angles = "5.98 -53.51 0",
			},
		},
	},
	p_finale_facerblu =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "cheese2",
				mins = "-3392 -3392 -704",
				maxs = "3392 3392 704",
				origin = "768 768 576",
				spawnflags = 1,
				StartDisabled = 1,
				target = "finale_face_target2",
				filtername = "filter_blu",
				"OnStartTouch#1" : "cheese2,Kill,,0,-1",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "finale_face_target2",
				origin = "413 -280 0",
				angles = "5.98 -53.51 0",
			},
		},
	},
	p_teleporter_brush =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "teleporter",
				mins = "-224 -452 -576",
				maxs = "224 452 576",
				origin = "-160 3132 704",
				spawnflags = 1,
				StartDisabled = 0,
				target = "info_tele",
			},
		},
	},
	p_teleporter_brush_finale =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "teleporterfinale",
				mins = "-224 -452 -576",
				maxs = "224 452 576",
				origin = "-160 3132 704",
				spawnflags = 1,
				StartDisabled = 1,
				target = "parachute_tele",
			},
		},
	},
	p_teleporter =
	{
		NoFixup = 1,
		[0] =
		{
			info_teleport_destination =
			{
				targetname = "info_tele",
				origin = "550 292 250",
				angles = "0 90 0",
			},
		},
	},
	p_teleporterfinale =
	{
		NoFixup = 1,
		[0] =
		{
			info_teleport_destination =
			{
				targetname = "parachute_tele",
				origin = "628 -752 1165",
				angles = "90 90 0",
			},
		},
	},
	p_lastbot =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_multiple =
			{
				targetname = "lastbotnamer",
				mins = "-224 -452 -576",
				maxs = "224 452 576",
				origin = "-160 3132 704",
				spawnflags = 1,
				StartDisabled = 1,
				"OnStartTouch#1" : "!activator,addoutput,targetname victory,0,-1",
			},
		},
	},
	p_voice =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_multiple =
			{
				targetname = "gogogo",
				mins = "-8000 -8000 -1000",
				maxs = "8000 8000 1000",
				StartDisabled = 1,
				spawnflags = 1,
				"OnStartTouch#1" : "!activator,SpeakResponseConcept,tlk_player_go,1,-1",
				"OnStartTouch#2" : "gogogo,Disable,,2,-1",
				"OnStartTouch#3" : "gogogo,Enable,,3,-1",
				filtername = "filter_red",
			},
		},
	},
	p_newlife =
	{
		NoFixup = 1,
		[0] =
		{
			game_forcerespawn =
			{
				targetname = "NEWLIFE",
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "bots_win",
				Action = "Kill",
			},
		},
	},
	p_chat1 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "signchat",
				display_text = "Every death comes with a $250 toll, pardner.",
				lifetime = 8,
				origin = "945 1600 275",
			},
		},
	},
	p_signbomb =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "signbomb",
				display_text = "The Corrupted have brought in a nuclear bomb!",
				lifetime = 8,
				origin = "-1180 -486 203",
			},
		},
	},
	p_badsign =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "badsign",
				display_text = "If this cabinet does not work, the mission will be broken. Please try another server if so",
				lifetime = 8,
				origin = "727 1300 310",
			},
		},
	},
	p_sign666 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign666",
				display_text = "If you become infected you must hide to recover!",
				lifetime = 8,
				origin = "10 1235 165",
			},
		},
	},
	p_sign0 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign0",
				display_text = "YOU ARE THE LAST...",
				lifetime = 10,
				origin = "10 1235 165",
			},
		},
	},
	p_sign1 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign1",
				display_text = "Running out in the open will slow you down",
				lifetime = 8,
				origin = "-680 -139 66",
			},
		},
	},
	p_sign2 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign2",
				display_text = "They come...",
				lifetime = 5,
				origin = "0 121 53",
			},
		},
	},
	p_sign3 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign3",
				display_text = "CHECKPOINT - The shop is open...",
				lifetime = 56.25,
				origin = "856 1530 360",
			},
		},
	},
	p_sign4 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign4",
				display_text = 5,
				lifetime = 1,
				origin = "856 1530 360",
			},
		},
	},
	p_sign5 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign5",
				display_text = 4,
				lifetime = 1,
				origin = "856 1530 360",
			},
		},
	},
	p_sign6 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign6",
				display_text = 3,
				lifetime = 1,
				origin = "856 1530 360",
			},
		},
	},
	p_sign7 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign7",
				display_text = 2,
				lifetime = 1,
				origin = "856 1530 360",
			},
		},
	},
	p_sign8 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign8",
				display_text = 1,
				lifetime = 1,
				origin = "856 1530 360",
			},
		},
	},
	p_sign9 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign9",
				display_text = "Secure the landing zone to escape!",
				lifetime = 15,
				origin = "622 -942 151",
			},
		},
	},
	p_sign10 =
	{
		NoFixup = 1,
		[0] =
		{
			training_annotation =
			{
				targetname = "sign10",
				display_text = "Reinforcements have arrived!",
				lifetime = 10,
				origin = "685 -685 925",
			},
		},
	},
	p_leap =
	{
		NoFixUp = 1,
		[0] =
		{
			trigger_catapult =
			{
				targetname = "jump_column",
				useThresholdCheck = 0,
				useExactVelocity = 0,
				upperThreshold = 0.30,
				StartDisabled = 0,
				spawnflags = 3,
				playerSpeed = 475,
				physicsSpeed = 450,
				origin = "0 598 36",
				mins = "-160 -22 -134",
				maxs = "160 22 134",
				onlyVelocityCheck = 0,
				lowerThreshold = 0.15,
				launchTarget = "jumptarget_column",
				launchDirection = "-90 0 0",
				filtername = "filter_leaper",
				exactVelocityChoiceType = 0,
				entryAngleTolerance = 0.0,
				applyAngularImpulse = 0,
				AirCtrlSupressionTime = -1.0,
				"OnCatapulted#1" : "!self,Disable,,0,-1",
				"OnCatapulted#2" : "!self,Enable,,1.5,-1",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "jumptarget_column",
				origin = "0 598 330",
			},
		},
		[2] =
		{
			trigger_catapult =
			{
				targetname = "jump_stairs",
				origin = "-178 974 -28",
				mins = "-50 -50 -100",
				maxs = "50 50 100",
				useThresholdCheck = 0,
				useExactVelocity = 0,
				upperThreshold = 0.30,
				StartDisabled = 0,
				spawnflags = 3,
				playerSpeed = 475,
				physicsSpeed = 450,
				onlyVelocityCheck = 0,
				lowerThreshold = 0.15,
				launchTarget = "jumptarget_stairs",
				launchDirection = "-90 0 0",
				filtername = "filter_leaper",
				exactVelocityChoiceType = 0,
				entryAngleTolerance = 0.0,
				applyAngularImpulse = 0,
				AirCtrlSupressionTime = -1.0,
				"OnCatapulted#1" : "!self,Disable,,0,-1",
				"OnCatapulted#2" : "!self,Enable,,1.5,-1",
			},
		},
		[3] =
		{
			info_target =
			{
				targetname = "jumptarget_stairs",
				origin = "-170 1000 180",
			},
		},
	},
	p_leap_tele =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "leap_tele",
				mins = "-134.5 -0.5 -217.5",
				maxs = "134.5 0.5 217.5",
				origin = "231.5 1279.5 147.5",
				spawnflags = 1,
				filtername = "filter_leaper",
				target = "leap_telehere",
				"OnStartTouch#1" : "leap_tele,Disable,,0,-1",
				"OnStartTouch#2" : "leap_tele,Enable,,2.5,-1",
				"OnStartTouch#3" : "leap_tele2,Disable,,0,-1",
				"OnStartTouch#4" : "leap_tele2,Enable,,2.5,-1",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "leap_telehere",
				origin = "225 1451 459",
			},
		},
		[2] =
		{
			trigger_teleport =
			{
				targetname = "leap_tele2",
				mins = "-134.5 -0.5 -217.5",
				maxs = "134.5 0.5 217.5",
				origin = "233.5 1288.5 147.5",
				spawnflags = 1,
				filtername = "filter_leaper",
				target = "leap_telehere2",
				"OnStartTouch#1" : "leap_tele,Disable,,0,-1",
				"OnStartTouch#2" : "leap_tele,Enable,,2.5,-1",
				"OnStartTouch#3" : "leap_tele2,Disable,,0,-1",
				"OnStartTouch#4" : "leap_tele2,Enable,,2.5,-1",
			},
		},
		[3] =
		{
			info_target =
			{
				targetname = "leap_telehere2",
				origin = "225 1184 459",
			},
		},
	},
	p_deskblock =
	{
		[0] =
		{
			func_nobuild =
			{
				mins = "-76 -63 -29",
				maxs = "76 63 29",
				AllowTeleporters = 0,
				AllowSentry = 0,
				AllowDispenser = 0,
			},
		},
	},
	p_engiblock =
	{
		[0] =
		{
			func_nobuild =
			{
				mins = "-8000 -8000 -1000",
				maxs = "8000 8000 1000",
				AllowTeleporters = 1,
				AllowSentry = 1,
				AllowDispenser = 1,
			},
		},
	},
	p_survrelay1 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "SURVIVORAISTART",
				"OnTrigger#1" : "point_populator_interface,ChangeBotAttributes,Shop,0,-1",
			},
		},
	},
	p_survrelay2 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "SURVIVORAIEND",
				"OnTrigger#1" : "point_populator_interface,ChangeBotAttributes,Defense,0,-1",
			},
		},
	},
	p_survrelay3 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "SURVIVORAIEXIT",
				"OnTrigger#1" : "point_populator_interface,ChangeBotAttributes,Exit,0,-1",
			},
		},
	},
	p_introcam =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "introcam",
				"OnTrigger#1" : "camera4,$EnableAll,,0,-1",
				"OnTrigger#2" : "camera4,$DisableAll,,3,-1",
			},
		},
	},
	p_beginrelay =
	{
		NoFixup = 1,
		[0] =
		{
			tf_point_nav_interface =
			{
				targetname = "nav_refresh",
			},
		},
		[1] =
		{
			logic_auto =
			{
				"OnMapSpawn#1" : "aliveblu,addoutput,targetname alivered,0,-1",
				"OnMapSpawn#2" : "nav_refresh,RecomputeBlockers,,0.1,-1",
				"OnMapSpawn#3" : "func_upgradestation,AddOutput,targetname station,0,-1",
				"OnMapSpawn#4" : "team_control_point_master,AddOutput,targetname hudthing,0,-1",
				"OnMapSpawn#5" : "team_control_point_master,AddOutput,custom_position_x 2,0,-1",
				"OnMapSpawn#6" : "team_control_point_master,RoundSpawn,,0.1,-1",
				"OnMapSpawn#7" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#8" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#9" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#10" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#11" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#12" : "func_movelinear,Kill,,0,-1",
				"OnMapSpawn#13" : "gate_door_trigger*,Kill,,0,-1",
				"OnMapSpawn#14" : "station,Enable,,0,-1",
				"OnMapSpawn#15" : "cab,Enable,,0,-1",
				"OnMapSpawn#16" : "fog_old,Trigger,,0,-1",
				"OnMapSpawn#17" : "overlay,StartOverlays,,0,-1",
				"OnMapSpawn#18" : "overlay,StopOverlays,,0.1,-1",
				"OnMapSpawn#19" : "hudcome,Trigger,,0,-1",
				"OnMapSpawn#20" : "camera2,$EnableAll,,0,-1",
				"OnMapSpawn#21" : "camera2,$DisableAll,,1,-1",
				"OnSpawn#1" : "player,addoutput,targetname ,0,-1",
				"OnMapSpawn#22" : "camera2,kill,,2,-1",
				"OnMapSpawn#23" : "signchat,Show,,2,-1",
				"OnMapSpawn#24" : "badsign,Show,,12,-1",
				"OnMapSpawn#25" : "player,$SetModelOverride,,-1,-1",
				"OnMapSpawn#26" : "shopgear,setattached,fam,0,-1",
				"OnMapSpawn#27" : "shopgear,setlightingorigin,fam,0,-1",
			},
		},
	},
	p_cabinet =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "locker_model",
				model = "models/props_gameplay/resupply_locker.mdl",
				solid = 0,
				angles = "0 0 0",
				disableshadows = 1,
				rendermode = 1,
				renderamt = 125,
			},
		},
		[1] =
		{
			filter_tf_bot_has_tag =
			{
				Negated = 0,
				require_all_tags = 1,
				tags = "noregen",
				targetname = "filter_redbot",
			},
		},
		[2] =
		{
			func_regenerate =
			{
				targetname = "cab",
				associatedmodel = "locker_model",
				TeamNum = 2,
				origin = "136 112 160",
				mins = "-152 -468 -160",
				maxs = "152 468 160",
				"OnStartTouchAll#1" : "locker_model,SetAnimation,open,0,-1",
				"OnEndTouchAll#1" : "locker_model,SetAnimation,close,0,-1",
			},
		},
	},
	p_spawnremover1 =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "door_1",
				Action = "kill",
			},
		},
	},
	p_spawnremover2 =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "spawn_red",
				Action = "kill",
			},
		},
	},
	p_spawnremover3 =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "func_respawnroomvisualizer",
				Action = "kill",
			},
		},
	},
	p_leet =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "superdisp",
				Action = "skin",
				Param = 1,
			},
		},
		[1] =
		{
			obj_dispenser =
			{
				targetname = "superdisp",
				origin = "0 0 0",
				teamnum = 2,
				SolidToPlayer = 0,
				defaultupgrade = 0,
				lightingorigin = "spawnbot_surprise2",
			},
		},
	},
	p_leet2 =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "superdisp2",
				Action = "skin",
				Param = 1,
			},
		},
		[1] =
		{
			obj_dispenser =
			{
				targetname = "superdisp2",
				origin = "0 0 0",
				teamnum = 2,
				SolidToPlayer = 0,
				defaultupgrade = 0,
			},
		},
	},
	p_mvm_beat =
	{
		NoFixup = 1,
		[0] =
		{
			ambient_generic =
			{
				targetname = "mvm_beat1",
				origin = "440 48 128",
				volstart = 10,
				spinup = 125,
				spindown = 70,
				spawnflags = 17,
				radius = 99999,
				preset = 0,
				pitchstart = 70,
				pitch = 125,
				message = "#music/mvm_class_menu_bg.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 7.5,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
	},
	viro_music =
	{
		NoFixup = 1,
		[0] =
		{
			ambient_generic =
			{
				targetname = "virospook",
				origin = "440 48 128",
				volstart = 7.5,
				spinup = 0,
				spindown = 0,
				spawnflags = 17,
				radius = 99999,
				preset = 0,
				pitchstart = 105,
				pitch = 105,
				message = "#ambient/atmosphere/sewer_air1.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 7.5,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[1] =
		{
			ambient_generic =
			{
				targetname = "virospook2",
				origin = "440 48 128",
				volstart = 10,
				spinup = 0,
				spindown = 0,
				spawnflags = 17,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#ambient/atmosphere/sewer_air1.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 5,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[2] =
		{
			ambient_generic =
			{
				targetname = "osprey",
				origin = "440 48 128",
				volstart = 5,
				spinup = 0,
				spindown = 0,
				spawnflags = 17,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#trespasser/ap_rotor4.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 5,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[3] =
		{
			ambient_generic =
			{
				targetname = "horizon",
				origin = "440 48 128",
				volstart = 10,
				spinup = 0,
				spindown = 0,
				spawnflags = 17,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#trespasser/zombiefinalequiet.mp3",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
	},
	lose_music =
	{
		NoFixup = 1,
		[0] =
		{
			ambient_generic =
			{
				targetname = "gameover",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#music/ravenholm_1.mp3",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 6,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
	},
	lose_music2 =
	{
		NoFixup = 1,
		[0] =
		{
			ambient_generic =
			{
				targetname = "gameover2",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#music/ravenholm_1.mp3",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 6,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
	},
	r_virobeat =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "viro_beaton",
				"OnTrigger#1" : "virospook,PlaySound,,0,-1",
			},
		},
	},
	r_virobeatoff =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "viro_beatoff",
				"OnTrigger#1" : "virospook,StopSound,,0,-1",
			},
		},
	},
	r_beatson =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "mvm_beaton",
				"OnTrigger#1" : "mvm_beat1,PlaySound,,0,-1",
			},
		},
	},
	r_beatsoff =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "mvm_beatoff",
				"OnTrigger#1" : "mvm_beat1,StopSound,,0,-1",
			},
		},
	},
	r_cade_relay =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "relay",
				"OnTrigger#1" : "shitcade_intro,SetAnimation,break2,0,-1",
				"OnTrigger#2" : "shitcade,Kill,,0.25,-1",
				"OnTrigger#3" : "shitcade_intro,Kill,,2.5,-1",
				"OnTrigger#4" : "permadeath_detect_player_spell,Enable,,0,-1",
			},
		},
	},
	r_cade_relay_lower =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "relay2",
				"OnTrigger#1" : "barricade_level2,Kill,,0.25,-1",
			},
		},
	},
	r_cade_relay_window =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "relay3",
				"OnTrigger#1" : "barricade_level1,Kill,,0.25,-1",
			},
		},
	},
	r_cade_relay_last =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "relay4",
				"OnTrigger#1" : "barricade_level3,Kill,,0.25,-1",
			},
		},
	},
	r_respawn_relay =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				targetname = "life_relay",
				"OnTrigger#1" : "NEWLIFE,ForceTeamRespawn,2,0,-1",
			},
		},
	},
	p_shake =
	{
		NoFixup = 1,
		[0] =
		{
			env_shake =
			{
				id = 3,
				classname = "env_shake",
				amplitude = 255,
				duration = 1,
				frequency = 255,
				radius = 50000,
				spawnflags = 5,
				targetname = "shakeit",
				origin = "-189.888 17.0933 65",
			},
		},
	},
	p_shakelong =
	{
		NoFixup = 1,
		[0] =
		{
			env_shake =
			{
				id = 3,
				classname = "env_shake",
				amplitude = 255,
				duration = 3,
				frequency = 255,
				radius = 50000,
				spawnflags = 5,
				targetname = "shakeit2",
				origin = "-189.888 17.0933 65",
			},
		},
	},
	p_rick =
	{
		NoFixup = 1,
		[0] =
		{
			entity_soldier_statue =
			{
				id = 3,
				classname = "entity_soldier_statue",
				origin = "0 0 0",
				disableshadows = 1,
				lightingorigin = "spawnbot_surprise2",
			},
		},
	},
	p_shopengi =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "fam",
				classname = "prop_dynamic",
				DefaultAnim = "competitive_loserstate_idle",
				angles = "0 0 0",
				DisableBoneFollowers = 1,
				disablereceiveshadows = 0,
				disableshadows = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 1,
				skin = 0,
				solid = 0,
				spawnflags = 0,
				origin = "0 0 0",
				model = "models/player/engineer.mdl",
			},
		},
	},
	p_shopitem1 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				targetname = "shopgear",
				classname = "prop_dynamic_ornament",
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				spawnflags = 256,
				initialowner = "fam",
				model = "models/workshop/player/items/engineer/jul13_king_pants/jul13_king_pants.mdl",
			},
		},
	},
	p_shopitem2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				targetname = "shopgear",
				classname = "prop_dynamic_ornament",
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				spawnflags = 256,
				initialowner = "fam",
				model = "models/workshop/player/items/engineer/spr17_double_observatory/spr17_double_observatory.mdl",
			},
		},
	},
	p_shopitem3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				targetname = "shopgear",
				classname = "prop_dynamic_ornament",
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				spawnflags = 256,
				initialowner = "fam",
				model = "models/workshop/player/items/all_class/fall17_jungle_ops/fall17_jungle_ops_engineer.mdl",
			},
		},
	},
	p_shopitem4 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				targetname = "shopgear",
				classname = "prop_dynamic_ornament",
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				spawnflags = 256,
				color = "124 108 87",
				model = "models/workshop/player/items/all_class/fall2013_the_cuban_coverup/fall2013_the_cuban_coverup_engineer.mdl",
			},
		},
	},
	p_shopitem5 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				targetname = "shopgear",
				classname = "prop_dynamic_ornament",
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				spawnflags = 256,
				initialowner = "fam",
				model = "models/workshop/player/items/engineer/all_work_and_no_plaid/all_work_and_no_plaid.mdl",
			},
		},
	},
	p_spook =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "bro",
				classname = "prop_dynamic",
				DefaultAnim = "stand_loser",
				angles = "0 0 0",
				DisableBoneFollowers = 1,
				disablereceiveshadows = 0,
				disableshadows = 1,
				startdisabled = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
				origin = "0 0 0",
				model = "models/bots/skeleton_sniper/skeleton_sniper.mdl",
			},
		},
	},
	p_spook2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "bro2",
				classname = "prop_dynamic",
				DefaultAnim = "taunt_russian",
				angles = "0 0 0",
				DisableBoneFollowers = 1,
				disablereceiveshadows = 0,
				disableshadows = 1,
				startdisabled = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
				origin = "0 0 0",
				model = "models/bots/skeleton_sniper/skeleton_sniper.mdl",
			},
		},
	},
	p_spook3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "bro3",
				classname = "prop_dynamic",
				DefaultAnim = "layer_taunt_i_see_you_primary",
				angles = "0 0 0",
				DisableBoneFollowers = 1,
				disablereceiveshadows = 0,
				disableshadows = 1,
				startdisabled = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
				origin = "0 0 0",
				model = "models/bots/skeleton_sniper/skeleton_sniper.mdl",
			},
		},
	},
	p_viewblocker_window =
	{
		NoFixup = 1,
		[0] =
		{
			func_brush =
			{
				origin = "-1 260 368",
				mins = "-320.5 -4 -144",
				maxs = "320.5 4 144",
			},
		},
	},
	p_plane =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "plane",
				classname = "prop_dynamic",
				model = "models/tf2enhancedmodels/cargoplane_enh.mdl",
				disableshadows = 1,
				modelscale = 2,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				origin = "1900 -745 -109",
				angles = "0 -5 0",
			},
		},
		[1] =
		{
			obj_sentrygun =
			{
				targetname = "planesentry",
				origin = "750 -645 41",
				angles = "0 -175 180",
				teamnum = 2,
				spawnflags = 14,
				SolidToPlayer = 0,
				defaultupgrade = 0,
				modelscale = 0.75,
			},
		},
	},
	p_musicmaker1 =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "music_maker",
				EntityTemplate = "lose_music",
			},
		},
	},
	p_musicmaker2 =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "music_maker2",
				EntityTemplate = "lose_music2",
			},
		},
	},
	p_planemaker =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "plane_maker",
				EntityTemplate = "p_plane",
			},
		},
	},
	p_cargodoor =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "cargodoor",
				classname = "prop_dynamic",
				model = "models/props_vehicles/train_flatcar_container.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_brushbug_fix =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_multiple =
			{
				targetname = "brushbug_fix",
				origin = "136 112 160",
				mins = "-152 -468 -160",
				maxs = "152 468 160",
				spawnflags = 1,
				startdisabled = 1,
				"onstarttouch#1" : "cargodoor,kill,,0,-1",
				"onstarttouch#2" : "!self,disable,,0,-1",
				"onstarttouch#3" : "!self,kill,,0.1,-1",
			},
		},
	},
	p_cargoshop1 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "cargoshop1",
				classname = "prop_dynamic",
				model = "models/props_vehicles/train_flatcar_container.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
				lightingorigin = "desk",
				startdisabled = 1,
			},
		},
	},
	p_cargoshop2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "cargoshop2",
				classname = "prop_dynamic",
				model = "models/props_vehicles/train_flatcar_container.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
				lightingorigin = "desk",
				startdisabled = 1,
			},
		},
	},
	p_cargoshop3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "cargoshop3",
				classname = "prop_dynamic",
				model = "models/props_island/yeti_cell_door.mdl",
				disableshadows = 1,
				modelscale = 1.5,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
				lightingorigin = "item_ammopack_large",
				startdisabled = 1,
			},
		},
	},
	p_pusher =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				filtername = "filter_leaper",
				origin = "-192 1072 0",
				mins = "-53 -29 -64",
				maxs = "53 29 64",
				pushdir = "0 165 0",
				spawnflags = 1,
				speed = 200,
				StartDisabled = 0,
				targetname = "pusher",
			},
		},
		[1] =
		{
			filter_tf_bot_has_tag =
			{
				Negated = "Allow entities that match criteria",
				require_all_tags = 1,
				tags = "bot_leaper",
				targetname = "filter_leaper",
			},
		},
	},
	p_pusher2 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				filtername = "filter_virophage",
				origin = "-1224 2167 736",
				mins = "-74 -62 -544",
				maxs = "74 62 544",
				pushdir = "0 -145 0",
				spawnflags = 1,
				speed = 200,
				StartDisabled = 0,
				targetname = "pusher2",
			},
		},
	},
	p_table =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "table",
				classname = "prop_dynamic",
				model = "models/props_swamp/picnic_table.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_table2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "table",
				classname = "prop_dynamic",
				model = "models/props_swamp/picnic_table.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_desk =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "desk",
				classname = "prop_dynamic",
				model = "models/props_medieval/bar_table.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_desk_intro =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade",
				classname = "prop_dynamic",
				model = "models/props_medieval/bar_table.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_chair_intro =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade",
				classname = "prop_dynamic",
				model = "models/props_manor/chair_01.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_urn =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_manor/vase_01.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_smallammo =
	{
		NoFixup = 1,
		[0] =
		{
			item_ammopack_small =
			{
				classname = "item_ammopack_small",
				disableshadows = 0,
			},
		},
	},
	p_smallammoskin =
	{
		NoFixup = 1,
		[0] =
		{
			item_ammopack_small =
			{
				powerup_model = "models/weapons/w_models/w_rocket.mdl",
				disableshadows = 0,
			},
		},
	},
	p_mediumammo =
	{
		NoFixup = 1,
		[0] =
		{
			item_ammopack_medium =
			{
				classname = "item_ammopack_medium",
				disableshadows = 0,
			},
		},
	},
	p_fullammo =
	{
		NoFixup = 1,
		[0] =
		{
			item_ammopack_full =
			{
				classname = "item_ammopack_full",
				disableshadows = 0,
			},
		},
	},
	p_smallmedkit =
	{
		NoFixup = 1,
		[0] =
		{
			item_healthkit_small =
			{
				classname = "item_healthkit_small",
			},
		},
	},
	p_smallmedkitskin =
	{
		NoFixup = 1,
		[0] =
		{
			item_healthkit_small =
			{
				classname = "item_healthkit_small",
				powerup_model = "models/items/medkit_small_bday.mdl",
			},
		},
	},
	p_mediumkit =
	{
		NoFixup = 1,
		[0] =
		{
			item_healthkit_medium =
			{
				classname = "item_healthkit_medium",
			},
		},
	},
	p_fullkit =
	{
		NoFixup = 1,
		[0] =
		{
			item_healthpack_medium =
			{
				classname = "item_healthkit_full",
				disableshadows = 0,
			},
		},
	},
	p_beam =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "beam",
				classname = "prop_dynamic",
				model = "models/props_farm/wood_pile.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_stair =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "stair",
				classname = "prop_dynamic",
				model = "models/props_coalmines/scaffolding1.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
				lightingorigin = "info_tele",
			},
		},
	},
	p_chair =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "chair",
				classname = "prop_dynamic",
				model = "models/props_spytech/chair.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_box_intro =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade",
				classname = "prop_dynamic",
				model = "models/props_manor/cardboard_box_set_01.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_box =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "box",
				classname = "prop_dynamic",
				model = "models/props_manor/cardboard_box_set_01.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_bookcase =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "bookcase",
				classname = "prop_dynamic",
				model = "models/props_manor/bookcase_132_03.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_bookcase3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_manor/bookcase_132_03.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 1,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_monstercage =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "monstercage",
				classname = "prop_dynamic",
				model = "models/props_island/small_yeti_container01.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barrel =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_medical/beer_barrels.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_beer =
	{
		NoFixup = 1,
		[0] =
		{
			func_wall =
			{
				origin = "654 328 456",
				mins = "-49 -65 -224",
				maxs = "49 65 224",
			},
		},
	},
	p_brokenstairs_clip =
	{
		NoFixup = 1,
		[0] =
		{
			func_wall =
			{
				origin = "188 1248 5",
				mins = "-36 -32 -77",
				maxs = "36 32 77",
			},
		},
		[1] =
		{
			func_wall =
			{
				origin = "256 1248 23",
				mins = "-32 -32 -95",
				maxs = "32 32 95",
			},
		},
		[2] =
		{
			func_wall =
			{
				origin = "326 1248 39",
				mins = "-38 -32 -111",
				maxs = "38 32 111",
			},
		},
		[3] =
		{
			func_wall =
			{
				origin = "365 1248 52",
				mins = "-19 -32 -124",
				maxs = "19 32 124",
			},
		},
		[4] =
		{
			func_wall =
			{
				origin = "388 1256 48",
				mins = "-4 -24 -112",
				maxs = "4 24 112",
			},
		},
		[5] =
		{
			func_wall =
			{
				origin = "396 1264 48",
				mins = "-4 -16 -112",
				maxs = "4 16 112",
			},
		},
		[6] =
		{
			func_wall =
			{
				origin = "404 1272 48",
				mins = "-4 -8 -112",
				maxs = "4 8 112",
			},
		},
	},
	p_crate =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "crate",
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				minhealthdmg = 9999,
			},
		},
	},
	p_ledgefix_left =
	{
		NoFixup = 1,
		[0] =
		{
			func_brush =
			{
				origin = "-544 1596 536",
				mins = "-112 -8 -104",
				maxs = "112 8 104",
			},
		},
		[1] =
		{
			func_brush =
			{
				origin = "-380 1440 520",
				mins = "-8 -112 -120",
				maxs = "8 112 120",
			},
		},
		[2] =
		{
			func_brush =
			{
				origin = "-544 1284 536",
				mins = "-112 -8 -104",
				maxs = "112 8 104",
			},
		},
	},
	p_ledgefix_right =
	{
		NoFixup = 1,
		[0] =
		{
			func_brush =
			{
				origin = "544 1284 536",
				mins = "-112 -8 -104",
				maxs = "112 8 104",
			},
		},
		[1] =
		{
			func_brush =
			{
				origin = "380 1440 520",
				mins = "-8 -112 -120",
				maxs = "8 112 120",
			},
		},
		[2] =
		{
			func_brush =
			{
				origin = "544 1596 536",
				mins = "-112 -8 -104",
				maxs = "112 8 104",
			},
		},
	},
	p_crate2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
				lightingorigin = "spawnbot_surprise2",
				minhealthdmg = 9999,
			},
		},
	},
	p_tomb =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "tomb",
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				minhealthdmg = 9999,
			},
		},
	},
	p_heli =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_island/island_helicopter.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_cratesmall =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate002.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				minhealthdmg = 9999,
			},
		},
	},
	p_crate_intro =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade",
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				minhealthdmg = 9999,
			},
		},
	},
	p_shitcade =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade_intro",
				classname = "prop_dynamic",
				model = "models/props_medieval/tank_entrance_rottenburg.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
				DefaultAnim = "idle",
			},
		},
	},
	p_shitcade2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "shitcade",
				classname = "prop_dynamic",
				model = "models/props_harbor/plates_harbor4.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_level1 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level1",
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_64.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_nolevel =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level",
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_256.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_nolevel2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_short_64.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_nolevel3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_short_64.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 0,
				spawnflags = 0,
			},
		},
	},
	p_barricade_level2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level2",
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_256.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_level3a =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level3",
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_256.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_level3b =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level3",
				classname = "prop_dynamic",
				model = "models/props_coalmines/wood_fence_128.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_plate2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level2",
				classname = "prop_dynamic",
				model = "models/props_harbor/plates_harbor4.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_barricade_plate3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "barricade_level3",
				classname = "prop_dynamic",
				model = "models/props_harbor/plates_harbor4.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_zombie =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				targetname = "zombie",
				classname = "prop_dynamic",
				model = "models/zombie/poison.mdl",
				DefaultAnim = "idle01",
				DisableBoneFollowers = 1,
				RandomAnimation = 0,
				disableshadows = 0,
				modelscale = 3,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
			},
		},
	},
	p_hhhteleporter =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "hhhtele1",
				origin = "0 2176 48",
				filtername = "filter_headless",
				mins = "-384 -160 -80",
				maxs = "384 160 80",
				spawnflags = 64,
				StartDisabled = 0,
				target = "hhhtele2",
				"OnStartTouch#1" : "hhhtele1,Disable,,0,-1",
				"OnStartTouch#2" : "hhhtele1,Enable,,5,-1",
			},
		},
		[1] =
		{
			info_teleport_destination =
			{
				targetname = "hhhtele2",
				origin = "300 2395 200",
				angles = "0 90 0",
			},
		},
		[2] =
		{
			filter_activator_class =
			{
				filterclass = "headless_hatman",
				targetname = "filter_headless",
			},
		},
	},
	p_slower0 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower0",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 1,
				spawnflags = 1,
				origin = "0 2176 48",
				move_speed_reduction = 0.65,
				filtername = "filter_redplayer",
				classname = "trigger_stun",
				mins = "-8000 -8000 -1000",
				maxs = "8000 8000 1000",
				solid = 3,
			},
		},
	},
	p_slower1 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower1",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "0 2176 48",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-384 -160 -80",
				maxs = "384 160 80",
				solid = 3,
			},
		},
	},
	p_slower2 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower2",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "-288 2528 280",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-480 -128 -104",
				maxs = "480 128 104",
				solid = 3,
			},
		},
	},
	p_slower3 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower3",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "-864 2176 280",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-448 -192 -104",
				maxs = "448 192 104",
				solid = 3,
			},
		},
	},
	p_slower4 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower4",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "-1024 1648 280",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-288 -336 -104",
				maxs = "288 336 104",
				solid = 3,
			},
		},
	},
	p_slower5 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower5",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "-1320 1196 280",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-104 -140 -104",
				maxs = "104 140 104",
				solid = 3,
			},
		},
	},
	p_slower6 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower6",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "-1024 96 -7",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-288 -928 -104",
				maxs = "288 928 104",
				solid = 3,
			},
		},
	},
	p_slower7 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower7",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "624 -656 -56",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-1360 -528 -55",
				maxs = "1360 528 55",
				solid = 3,
			},
		},
	},
	p_slower8 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower8",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "1520 416 -7",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-784 -544 -104",
				maxs = "784 544 104",
				solid = 3,
			},
		},
	},
	p_slower9 =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_stun =
			{
				trigger_delay = 0,
				TeamNum = 0,
				targetname = "slower9",
				stun_type = 0,
				stun_effects = 1,
				stun_duration = 1,
				StartDisabled = 0,
				spawnflags = 1,
				origin = "608 64 -7",
				move_speed_reduction = 0.85,
				filtername = "filter_red",
				classname = "trigger_stun",
				mins = "-96 -160 -104",
				maxs = "96 160 104",
				solid = 3,
			},
		},
	},
	p_controlpoint =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				model = "models/props_gameplay/cap_point_base.mdl",
				targetname = "cap_base",
				solid = 0,
				skin = 0,
			},
		},
		[1] =
		{
			trigger_capture_area =
			{
				classname = "trigger_capture_area",
				area_cap_point = "cap_point",
				area_time_to_cap = 60,
				StartDisabled = 0,
				targetname = "cap_area",
				team_cancap_2 = 1,
				team_cancap_3 = 0,
				team_numcap_2 = 1,
				team_numcap_3 = 1,
				team_spawn_2 = 0,
				team_spawn_3 = 0,
				team_startcap_2 = 1,
				team_startcap_3 = 1,
				mins = "-128 -128 -128",
				maxs = "128 128 128",
				origin = "0 0 128",
				spawnflags = 1,
				"OnCapTeam1#1" : "victory,$suicide,,20,-1",
				"OnCapTeam1#2" : "fade4,Fade,,3,-1",
				"OnCapTeam1#3" : "cheese,Enable,,3,-1",
				"OnCapTeam1#4" : "cheese2,Enable,,3,-1",
				"OnCapTeam1#5" : "player,SetForcedTauntCam,1,3,-1",
				"OnCapTeam1#6" : "horizon,StopSound,,3,-1",
				"OnCapTeam1#7" : "gogogo,Enable,,1,-1",
				"OnCapTeam1#8" : "camera3,$enableall,,3,-1",
				"OnCapTeam1#9" : "tf_gamerules,PlayVORed,trespasser/zombieintroquiet.mp3,3,-1",
				"OnCapTeam1#10" : "tf_gamerules,PlayVORed,trespasser/zombieintroquiet.mp3,3,-1",
				"OnCapTeam1#11" : "playerRunScriptCodeClientPrint(self, 4, `You have survived! Awaiting departure...`)3-1,0,-1",
			},
		},
		[2] =
		{
			team_control_point =
			{
				classname = "team_control_point",
				angles = "0 0 0",
				point_default_owner = 0,
				point_group = 0,
				point_index = 2,
				point_printname = "your escape!",
				point_start_locked = 0,
				point_warn_on_cap = 0,
				point_warn_sound = "misc/null.wav",
				random_owner_on_restart = 0,
				spawnflags = 4,
				StartDisabled = 0,
				targetname = "cap_point",
				team_bodygroup_0 = 3,
				team_bodygroup_2 = 1,
				team_bodygroup_3 = 1,
				team_icon_0 = "sprites/obj_icons/icon_obj_neutral",
				team_icon_2 = "sprites/obj_icons/icon_obj_red",
				team_icon_3 = "sprites/obj_icons/icon_obj_blu",
				team_model_0 = "models/effects/cappoint_hologram.mdl",
				team_model_2 = "models/effects/cappoint_hologram.mdl",
				team_model_3 = "models/effects/cappoint_hologram.mdl",
				team_previouspoint_2_0 = "cap_point",
				team_timedpoints_2 = 0,
				team_timedpoints_3 = 0,
				origin = "0 0 4",
			},
		},
		[3] =
		{
			team_control_point_master =
			{
				classname = "team_control_point_master",
				cpm_restrict_team_cap_win = 1,
				custom_position_x = 0.35,
				caplayout = "2,0 1",
				custom_position_y = 0.91,
				partial_cap_points_rate = 0,
				play_all_rounds = 0,
				score_style = 0,
				StartDisabled = 0,
				switch_teams = 0,
				targetname = "cap_master",
				team_base_icon_2 = "sprites/obj_icons/icon_base_red",
				team_base_icon_3 = "sprites/obj_icons/icon_base_blu",
			},
		},
		[4] =
		{
			game_round_win =
			{
				classname = "game_round_win",
				force_map_reset = 0,
				switch_teams = 0,
				targetname = "red_win",
				TeamNum = 2,
			},
		},
		[5] =
		{
			OnSpawnOutput =
			{
				Target = "cap_area",
				Action = "SetControlPoint",
				Param = "cap_point",
			},
		},
		[6] =
		{
			OnSpawnOutput =
			{
				Target = "cap_master",
				Action = "RoundSpawn",
			},
		},
	},
	p_cover =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				Origin = "478 -852 -85",
				Angles = "0 105 10",
				minhealthdmg = 9999,
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				classname = "prop_dynamic",
				model = "models/props_2fort/miningcrate001.mdl",
				disableshadows = 1,
				modelscale = 1,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				Origin = "458 -852 -43",
				Angles = "0 105 10",
				minhealthdmg = 9999,
			},
		},
	},
	p_pointmaker =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "point_maker",
				EntityTemplate = "p_controlpoint",
			},
		},
	},
	p_pointmaker2 =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "point_maker2",
				EntityTemplate = "p_leet2",
			},
		},
	},
	p_shutter_pusher =
	{
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "232 249 521",
				mins = "-456 -7 -7.5",
				maxs = "456 7 7.5",
				pushdir = "0 -90 0",
				spawnflags = 1,
				speed = 400,
				targetname = "shutter_pusher",
			},
		},
	},
	p_shutter_pusher2 =
	{
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "125 244 345",
				mins = "-349 -12.5 -168.5",
				maxs = "349 12.5 168.5",
				pushdir = "0 -90 0",
				spawnflags = 1,
				speed = 400,
				targetname = "shutter_pusher",
			},
		},
	},
	p_brokenwall_pusher =
	{
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "388 2182 587",
				mins = "-4 -5.5 -85",
				maxs = "4 5.5 85",
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 250,
				targetname = "brokenwall_pusher",
			},
		},
	},
	p_brokenwall_pusher2 =
	{
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "-388 1761 365",
				mins = "-4 -163.5 -57.5",
				maxs = "4 163.5 57.5",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 400,
				targetname = "brokenwall_pusher",
			},
		},
		[1] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "-408 1616 430",
				mins = "-24 -15.5 -40.5",
				maxs = "24 15.5 40.5",
				pushdir = "0 135 0",
				spawnflags = 1,
				speed = 400,
				targetname = "brokenwall_pusher",
			},
		},
	},
	p_yeet_failsafe =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "yeet_failsafe",
				mins = "-82.5 -41 -20",
				maxs = "82.5 41 20",
				origin = "0 488 212",
				spawnflags = 1,
				filtername = "filter_red",
				target = "yeet_failsafe_target",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "yeet_failsafe_target",
				origin = "0 488 300",
				angles = "0 90 0",
			},
		},
	},
	p_yeet =
	{
		NoFixUp = 1,
		[0] =
		{
			func_forcefield =
			{
				origin = "0 488 212",
				mins = "-82.5 -41 -20.5",
				maxs = "82.5 41 20.5",
				TeamNum = 3,
				targetname = "desk_barrier",
				StartDisabled = 0,
			},
		},
	},
	p_yeet2 =
	{
		NoFixUp = 1,
		[0] =
		{
			trigger_push =
			{
				origin = "400 1040 191",
				mins = "-16 -156 -16",
				maxs = "16 156 16",
				pushdir = "0 0 0",
				speed = 50,
				StartDisabled = 0,
				spawnflags = 1,
				filtername = "filter_redplayer",
				parentname = "yeetrotate",
			},
		},
		[1] =
		{
			func_rotating =
			{
				targetname = "yeetrotate",
				origin = "400 1040 191",
				mins = "-8 -8 -8",
				maxs = "8 8 8",
				fanfriction = 100,
				maxspeed = 50,
				rendermode = 10,
				spawnflags = 65,
			},
		},
	},
	p_yeet3 =
	{
		NoFixUp = 1,
		[0] =
		{
			trigger_catapult =
			{
				targetname = "jump_lonepillar",
				useThresholdCheck = 0,
				useExactVelocity = 0,
				upperThreshold = 0.30,
				StartDisabled = 0,
				spawnflags = 3,
				playerSpeed = 475,
				physicsSpeed = 450,
				origin = "400 1040 -19",
				mins = "-64 -64 -45",
				maxs = "64 64 45",
				onlyVelocityCheck = 0,
				lowerThreshold = 0.15,
				launchTarget = "jumptarget_lonepillar",
				launchDirection = "-90 0 0",
				filtername = "filter_leaper",
				exactVelocityChoiceType = 0,
				entryAngleTolerance = 0.0,
				applyAngularImpulse = 0,
				AirCtrlSupressionTime = -1.0,
				"OnCatapulted#1" : "!self,Disable,,0,-1",
				"OnCatapulted#2" : "!self,Enable,,3,-1",
			},
		},
		[1] =
		{
			info_target =
			{
				targetname = "jumptarget_lonepillar",
				origin = "400 1040 315",
			},
		},
	},
	p_yeet4 =
	{
		NoFixUp = 1,
		[0] =
		{
			trigger_push =
			{
				alternateticksfix = 0,
				origin = "416 -1056 576",
				mins = "-32 -32 -704",
				maxs = "32 32 704",
				pushdir = "0 -35 0",
				spawnflags = 1,
				speed = 500,
				StartDisabled = 0,
				filtername = "filter_red",
				targetname = "pusherrr",
			},
		},
	},
	p_mapblock =
	{
		NoFixup = 1,
		[0] =
		{
			func_forcefield =
			{
				origin = "-992 997 576",
				mins = "-288 -62 -704",
				maxs = "288 62 704",
				TeamNum = 3,
				targetname = "top_barrier",
				StartDisabled = 0,
			},
		},
	},
	p_bonus =
	{
		NoFixup = 1,
		[0] =
		{
			filter_tf_bot_has_tag =
			{
				negated = 1,
				require_all_tags = 1,
				tags = "bot_notplayer",
				targetname = "filter_notplayer",
			},
		},
		[1] =
		{
			filter_multi =
			{
				targetname = "filter_redplayer",
				filter01 = "filter_red",
				filter02 = "filter_notplayer",
			},
		},
		[2] =
		{
			trigger_add_tf_player_condition =
			{
				targetname = "lastcrits",
				condition = 40,
				duration = 2,
				filtername = "filter_redplayer",
				startdisabled = 1,
				origin = "768 768 576",
				mins = "-3328 -3328 -704",
				maxs = "3328 3328 704",
				spawnflags = 1,
			},
		},
		[3] =
		{
			logic_timer =
			{
				targetname = "lastcritsrefire",
				refiretime = 1,
				startdisabled = 1,
				"ontimer#1" : "lastcrits,enable,,0,-1",
				"ontimer#2" : "lastcrits,disable,,0.5,-1",
			},
		},
		[4] =
		{
			math_counter =
			{
				targetname = "lastcounter",
				max = 6,
				"outvalue#1" : "lastcountercompare,setvaluecompare,,0,-1",
			},
		},
		[5] =
		{
			logic_compare =
			{
				targetname = "lastcountercompare",
				comparevalue = 1,
				"ongreaterthan#1" : "lastdisable_relay,trigger,,0,-1",
				"ongreaterthan#2" : "enable_lastenable_relay,trigger,,0,-1",
				"onequalto#1" : "lastenable_relay,trigger,,0,-1",
				"onequalto#2" : "lastdisable_relay,enable,,0,-1",
			},
		},
		[6] =
		{
			logic_relay =
			{
				targetname = "enable_lastenable_relay",
				startdisabled = 1,
				"ontrigger#1" : "lastenable_relay,enable,,0,-1",
				"onspawn#1" : "wave_start_relay,addoutput,ontrigger enable_lastenable_relay:enable::0:-1,0,-1",
				"onspawn#2" : "wave_start_relay,addoutput,ontrigger lastenable_relay:enable::0:-1,0,-1",
				"onspawn#3" : "wave_start_relay,addoutput,ontrigger lastcountercompare:compare::1:-1,0,-1",
			},
		},
		[7] =
		{
			logic_relay =
			{
				targetname = "lastenable_relay",
				startdisabled = 1,
				"ontrigger#1" : "!self,disable,,0,-1",
				"ontrigger#2" : "lastcritsrefire,enable,,1.5,-1",
				"ontrigger#3" : "slower0,enable,,2.5,-1",
				"ontrigger#4" : "gameover,playsound,,0,-1",
				"ontrigger#5" : "gameover2,playsound,,0,-1",
				"ontrigger#6" : "sign0,show,,2.5,-1",
				"ontrigger#7" : "virospook,playsound,,2.5,-1",
				"ontrigger#8" : "playerRunScriptCodeself.AddCustomAttribute(`mult dmg vs tanks`, 3, -1)0-1,0,-1",
				"ontrigger#9" : "obj_dispenser,removehealth,9999,2.5,-1",
				"ontrigger#10" : "obj_sentrygun,removehealth,9999,2.5,-1",
				"ontrigger#11" : "obj_teleporter,removehealth,9999,2.5,-1",
			},
		},
		[8] =
		{
			logic_relay =
			{
				targetname = "lastdisable_relay",
				startdisabled = 1,
				"ontrigger#1" : "!self,disable,,0,-1",
				"ontrigger#2" : "lastcritsrefire,disable,,0,-1",
				"ontrigger#3" : "slower0,disable,,0,-1",
				"ontrigger#4" : "gameover,stopsound,,0,-1",
				"ontrigger#5" : "gameover2,stopsound,,0,-1",
				"ontrigger#6" : "sign0,hide,,0,-1",
				"ontrigger#7" : "virospook,stopsound,,0,-1",
				"ontrigger#8" : "playerRunScriptCodeself.AddCustomAttribute(`mult dmg vs tanks`, 1, -1)0-1,0,-1",
			},
		},
	},
	p_fog =
	{
		NoFixup = 1,
		[0] =
		{
			env_fog_controller =
			{
				farz = -1,
				fogblend = 1,
				fogcolor = "24 25 36",
				fogcolor2 = "18 20 24",
				fogdir = "1 0 0",
				fogenable = 1,
				fogend = 750,
				foglerptime = 2,
				fogmaxdensity = 1,
				fogstart = 1,
				spawnflags = 1,
				targetname = "mist",
			},
		},
		[1] =
		{
			sky_camera =
			{
				fogmaxdensity = 1,
				origin = "0 0 -1392",
				angles = "0 0 0",
				fogcolor = "0 0 0",
				fogcolor2 = "0 0 0",
				fogdir = "1 0 0",
				fogenable = 1,
				fogend = 1,
				fogstart = 1,
				scale = 16,
				targetname = "mist_camera",
			},
		},
		[2] =
		{
			trigger_multiple =
			{
				targetname = "fog_system",
				origin = "1847 -4007 71",
				mins = "-9999 -9999 -9999",
				maxs = "9999 9999 9999",
				StartDisabled = 1,
				spawnflags = 1,
				"OnStartTouch#1" : "!activator,SetFogController,mist,0.01,-1",
			},
		},
	},
	p_navblocker =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "nav_blocker",
				Action = "BlockNav",
			},
		},
		[1] =
		{
			func_nav_blocker =
			{
				targetname = "nav_blocker",
				start_disabled = 0,
				mins = "-224 -222 -650",
				maxs = "224 222 650",
				origin = "-1632 -77 405",
				team = -2,
			},
		},
	},
	p_navblocker2 =
	{
		NoFixup = 1,
		[0] =
		{
			func_brush =
			{
				mins = "-224 -50 -650",
				maxs = "224 50 650",
				origin = "-1632 -77 405",
				TeamNum = 2,
				targetname = "back_barrier",
				StartDisabled = 0,
			},
		},
	},
	p_survmoveup =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "moveup",
			},
		},
	},
	p_survmoveup2 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "moveup2",
			},
		},
	},
	p_survmoveup3 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "moveup3",
			},
		},
	},
	p_survshop1 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_shop1",
			},
		},
	},
	p_survshop2 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_shop2",
			},
		},
	},
	p_survshop3 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_shop3",
			},
		},
	},
	p_keepertarget =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_keeper",
			},
		},
	},
	p_marketgardener =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_mg",
			},
		},
	},
	p_marketgardener2 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_mg2",
			},
		},
	},
	p_marketgardener3 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_mg3",
			},
		},
	},
	p_marketgardener4 =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_mg4",
			},
		},
	},
	p_tank =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_tank",
			},
		},
	},
	p_tankgo =
	{
		NoFixup = 1,
		[0] =
		{
			info_target =
			{
				targetname = "target_tankgo",
			},
		},
	},
	p_threaten =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "threat",
				"OnTrigger#1" : "player*RunScriptCodeClientPrint(self, 4, `KILL KILL KILL KILL KILL KILL`)0-1,0,-1",
			},
		},
	},
	p_threaten2 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "threat2",
				"OnTrigger#1" : "player*RunScriptCodeClientPrint(self, 4, `LAST CHANCE FOR PURCHASES`)0-1,0,-1",
			},
		},
	},
	p_fogold =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "fog_old",
				"OnTrigger#1" : "player*,SetFogController,fog_controller,0.01,-1",
			},
		},
	},
	p_nohud1 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "hudbgone",
				"OnTrigger#1" : "player*,SetHUDVisibility,0,0,-1",
			},
		},
	},
	p_nohud2 =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "hudcome",
				"OnTrigger#1" : "player*,SetHUDVisibility,1,0,-1",
			},
		},
	},
	p_spawns =
	{
		[0] =
		{
			func_forcefield =
			{
				origin = "-160 2700 736",
				mins = "-224 -20 -464",
				maxs = "224 20 464",
				TeamNum = 3,
				targetname = "back_barrier",
				StartDisabled = 0,
			},
		},
		[1] =
		{
			func_forcefield =
			{
				origin = "1148 2844 672",
				mins = "-4 -156 -448",
				maxs = "4 156 448",
				TeamNum = 3,
				targetname = "back_right_barrier",
				StartDisabled = 0,
			},
		},
		[2] =
		{
			func_forcefield =
			{
				origin = "1072 3004 672",
				mins = "-80 -4 -448",
				maxs = "80 4 448",
				TeamNum = 3,
				targetname = "back_right_barrier",
				StartDisabled = 0,
			},
		},
		[3] =
		{
			func_forcefield =
			{
				origin = "-1136 -448 672",
				mins = "-16 -320 -704",
				maxs = "16 320 704",
				TeamNum = 3,
				targetname = "front_barrier",
				StartDisabled = 0,
			},
		},
		[4] =
		{
			func_forcefield =
			{
				origin = "-1200 576 576",
				mins = "-16 -192 -704",
				maxs = "16 192 704",
				TeamNum = 3,
				targetname = "front_right_barrier",
				StartDisabled = 0,
			},
		},
		[5] =
		{
			func_forcefield =
			{
				origin = "1085 492 576",
				mins = "-56 -113 -704",
				maxs = "56 113 704",
				TeamNum = 3,
				targetname = "front_left_barrier",
				StartDisabled = 0,
			},
		},
		[6] =
		{
			func_forcefield =
			{
				origin = "1109 386 576",
				mins = "-56 -84 -704",
				maxs = "56 84 704",
				TeamNum = 3,
				targetname = "front_left_barrier",
				StartDisabled = 0,
			},
		},
		[7] =
		{
			func_forcefield =
			{
				origin = "1148 216 576",
				mins = "-56 -86 -704",
				maxs = "56 86 704",
				TeamNum = 3,
				targetname = "front_left_barrier",
				StartDisabled = 0,
			},
		},
		[8] =
		{
			func_forcefield =
			{
				origin = "-1307 1992 650",
				mins = "-47 -222 -632",
				maxs = "47 222 632",
				TeamNum = 3,
				targetname = "back_left_barrier",
				StartDisabled = 0,
			},
		},
		[9] =
		{
			func_forcefield =
			{
				origin = "-1260 2121 650",
				mins = "-75 -46 -632",
				maxs = "75 46 632",
				TeamNum = 3,
				targetname = "back_left_barrier",
				StartDisabled = 0,
			},
		},
	},
	p_screen =
	{
		NoFixUp = 1,
		[0] =
		{
			env_screenoverlay =
			{
				targetname = "overlay",
				OverlayName1 = "effects/stealth_overlay.vmt",
				OverlayTime1 = 1.0,
				OverlayTime2 = 1.0,
				OverlayTime3 = 1.0,
				OverlayTime4 = 1.0,
				OverlayTime5 = 1.0,
				OverlayTime6 = 1.0,
				OverlayTime7 = 1.0,
				OverlayTime8 = 1.0,
				OverlayTime9 = 1.0,
				OverlayTime10 = 1.0,
			},
		},
	},
	p_screenblu =
	{
		NoFixUp = 1,
		[0] =
		{
			env_screenoverlay =
			{
				targetname = "overlayrobo",
				OverlayName1 = "effects/combine_binocoverlay",
				OverlayTime1 = 1.0,
				OverlayTime2 = 1.0,
				OverlayTime3 = 1.0,
				OverlayTime4 = 1.0,
				OverlayTime5 = 1.0,
				OverlayTime6 = 1.0,
				OverlayTime7 = 1.0,
				OverlayTime8 = 1.0,
				OverlayTime9 = 1.0,
				OverlayTime10 = 1.0,
			},
		},
	},
	p_plank =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				id = 3,
				classname = "prop_dynamic",
				angles = "0 0 0",
				DisableBoneFollowers = 0,
				disablereceiveshadows = 0,
				disableshadows = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				model = "models/props_2fort/corrugated_metal003.mdl",
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				origin = "0 0 0",
				lightingorigin = "spawnbot_surprise2",
			},
		},
	},
	p_plank2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				id = 3,
				classname = "prop_dynamic",
				angles = "0 0 0",
				DisableBoneFollowers = 0,
				disablereceiveshadows = 0,
				disableshadows = 1,
				ExplodeDamage = 0,
				ExplodeRadius = 0,
				fademaxdist = 0,
				fademindist = -1,
				fadescale = 1,
				MaxAnimTime = 10,
				maxdxlevel = 0,
				MinAnimTime = 5,
				mindxlevel = 0,
				model = "models/props_farm/stairs_wood001b.mdl",
				modelscale = 1,
				PerformanceMode = 0,
				pressuredelay = 0,
				RandomAnimation = 0,
				renderamt = 255,
				renderfx = 0,
				rendermode = 0,
				SetBodyGroup = 0,
				skin = 0,
				solid = 6,
				spawnflags = 0,
				origin = "0 0 0",
				lightingorigin = "spawnbot_surprise2",
			},
		},
	},
	p_camera =
	{
		NoFixup = 1,
		[0] =
		{
			point_viewcontrol =
			{
				acceleration = 0,
				deceleration = 0,
				interpolatepositiontoplayer = 0,
				spawnflags = 0,
				speed = 0,
				wait = 10,
				targetname = "camera",
				origin = "-1619 -580 988",
				angles = "23.32 39.84 0",
			},
		},
	},
	p_camera2 =
	{
		NoFixup = 1,
		[0] =
		{
			point_viewcontrol =
			{
				acceleration = 0,
				deceleration = 0,
				interpolatepositiontoplayer = 0,
				spawnflags = 128,
				speed = 0,
				wait = 10,
				targetname = "camera2",
				origin = "800 1056 267",
				angles = "0 90 0",
			},
		},
	},
	p_camera3 =
	{
		NoFixup = 1,
		[0] =
		{
			point_viewcontrol =
			{
				moveto = "camera_path2",
				targetname = "camera3",
				origin = "253 -196 59",
				angles = "5.98 -53.51 0",
			},
		},
	},
	p_camera4 =
	{
		NoFixup = 1,
		[0] =
		{
			point_viewcontrol =
			{
				acceleration = 0,
				deceleration = 0,
				interpolatepositiontoplayer = 0,
				spawnflags = 128,
				speed = 0,
				wait = 10,
				targetname = "camera4",
				origin = "-257 402 430",
				angles = "22 60 0",
			},
		},
	},
	p_nuke =
	{
		NoFixup = 1,
		[0] =
		{
			game_round_win =
			{
				origin = "-1611.31 4748.55 169.35",
				TeamNum = 3,
				targetname = "bots_win",
				switch_teams = 0,
				force_map_reset = 1,
				classname = "game_round_win",
			},
		},
		[1] =
		{
			env_fade =
			{
				targetname = "fadenuke2",
				angles = "0 0 0",
				duration = 100,
				rendercolor = "255 255 255",
				renderamt = 50,
				spawnflags = 0,
			},
		},
		[2] =
		{
			env_fade =
			{
				targetname = "fadenuke",
				angles = "0 0 0",
				duration = 5,
				holdtime = 5,
				rendercolor = "0 0 0",
				spawnflags = 9,
			},
		},
		[3] =
		{
			env_viewpunch =
			{
				punchangle = "-90 0 0",
				radius = 9999,
				spawnflags = 3,
				targetname = "punch",
				origin = "1184 512 388",
			},
		},
		[4] =
		{
			trigger_hurt =
			{
				targetname = "ded",
				origin = "0 0 0",
				angles = "-45 -90 0",
				mins = "-8000 -8000 -1000",
				maxs = "8000 8000 1000",
				nodmgforce = 0,
				damagetype = 1048576,
				damagemodel = 0,
				damagecap = 0,
				damage = 99999,
				StartDisabled = 1,
				spawnflags = 64,
			},
		},
		[5] =
		{
			ambient_generic =
			{
				targetname = "explode1",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "ambient/explosions/explode_9.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[6] =
		{
			ambient_generic =
			{
				targetname = "explode2",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "ambient/explosions/citadel_end_explosion1.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[7] =
		{
			ambient_generic =
			{
				targetname = "explode3",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "ambient/explosions/citadel_end_explosion1.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[8] =
		{
			ambient_generic =
			{
				targetname = "explode3",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "items/cart_explode.wav",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[9] =
		{
			ambient_generic =
			{
				targetname = "explode4",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#music/stingers/hl1_stinger_song8.mp3",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[10] =
		{
			ambient_generic =
			{
				targetname = "explode5",
				origin = "440 48 128",
				volstart = 0,
				spinup = 0,
				spindown = 0,
				spawnflags = 33,
				radius = 99999,
				preset = 0,
				pitchstart = 100,
				pitch = 100,
				message = "#music/stingers/hl1_stinger_song8.mp3",
				lfotype = 0,
				lforate = 0,
				lfomodvol = 0,
				lfomodpitch = 0,
				health = 10,
				fadeoutsecs = 0,
				fadeinsecs = 0,
				cspinup = 0,
			},
		},
		[11] =
		{
			logic_relay =
			{
				origin = "-1611.31 4748.55 169.35",
				targetname = "nuke_relay",
				"OnTrigger#1" : "lastenable_relay,kill,0,-1,-1",
				"OnTrigger#2" : "punch,ViewPunch,,0,1",
				"OnTrigger#3" : "kaboom,Start,,0,1",
				"OnTrigger#4" : "player,igniteplayer,,0,1",
				"OnTrigger#5" : "shakeit,StartShake,,0,-1",
				"OnTrigger#6" : "shakeit2,StartShake,,0,-1",
				"OnTrigger#7" : "explode1,PlaySound,,0,-1",
				"OnTrigger#8" : "explode2,PlaySound,,0,-1",
				"OnTrigger#9" : "explode3,PlaySound,,0,-1",
				"OnTrigger#10" : "explode4,PlaySound,,3,-1",
				"OnTrigger#11" : "explode5,PlaySound,,3,-1",
				"OnTrigger#12" : "ded,Enable,,0.25,-1",
				"OnTrigger#13" : "hudbgone,Trigger,,0.5,-1",
				"OnTrigger#14" : "camera,$EnableAll,,0.5,-1",
				"OnTrigger#15" : "camera,$DisableAll,,5.25,-1",
				"OnTrigger#16" : "hudcome,Trigger,,5.25,-1",
				"OnTrigger#17" : "obj_dispenser,RemoveHealth,5000,0.25,-1",
				"OnTrigger#18" : "obj_sentrygun,RemoveHealth,5000,0.25,-1",
				"OnTrigger#19" : "obj_teleporter,RemoveHealth,5000,0.25,-1",
			},
		},
		[12] =
		{
			OnSpawnOutput =
			{
				Target = "capturezone_blu",
				Action = "AddOutput",
				Param = "OnCapture nuke_relay:Trigger:0:-1",
			},
		},
	},
	p_switcharoo1 =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$RemoveItem",
				Param = "Darwin's Danger Shield",
				Delay = 0,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$GiveItem",
				Param = "TF_WEAPON_GRAPPLINGHOOK",
				Delay = 0,
			},
		},
	},
	p_switcharoo2 =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$RemoveItem",
				Param = "The Razorback",
				Delay = 0,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$GiveItem",
				Param = "TF_WEAPON_GRAPPLINGHOOK",
				Delay = 0,
			},
		},
	},
	p_switcharoo3 =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$RemoveItem",
				Param = "The Cozy Camper",
				Delay = 0,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$GiveItem",
				Param = "TF_WEAPON_GRAPPLINGHOOK",
				Delay = 0,
			},
		},
	},
}
SpawnTemplate("p_sign10", null)
SpawnTemplate("p_survmoveup", null, "0 380 267")
SpawnTemplate("p_fade2", null)
SpawnTemplate("ModelandScale_FailSafe_Spy", null, "0 0 0")
SpawnTemplate("p_survmoveup3", null, "626 -942 -90")
SpawnTemplate("p_beer", null)
SpawnTemplate("p_plank", null, "-250 1575 205", "45 90 90")
SpawnTemplate("p_crate", null, "-660 1146 -65", "0 90 0")
SpawnTemplate("r_cade_relay_lower", null, "720 1280 192", "0 0 0")
SpawnTemplate("ModelandScale_FailSafe_Heavy", null, "0 0 0")
SpawnTemplate("p_smallammo", null, "-671 1410 192", "0 0 0")
SpawnTemplate("p_leet", null, "345 1662 187", "0 180 0")
SpawnTemplate("p_cover", null)
SpawnTemplate("p_ledgefix_right", null)
SpawnTemplate("p_shitcade2", null, "-75 240 -85", "0 -90 0")
SpawnTemplate("p_smallammo", null, "0 474 230", "0 0 0")
SpawnTemplate("p_navblocker", null)
SpawnTemplate("p_engiblock", null)
SpawnTemplate("p_leet", null, "-152 1255 -65", "0 45 0")
SpawnTemplate("p_fade3", null)
SpawnTemplate("p_bonus", null)
SpawnTemplate("p_slower4", null)
SpawnTemplate("p_voice", null)
SpawnTemplate("p_cargoshop2", null, "936 1603 335", "0 180 0")
SpawnTemplate("p_mediumammo", null, "400 1039 176", "0 0 0")
SpawnTemplate("p_barricade_plate3", null, "-540 1640 185", "0 -90 0")
SpawnTemplate("p_kaboom", null, "-835 1705 200", "0 90 0")
SpawnTemplate("p_marketgardener3", null, "0 1432 267")
SpawnTemplate("p_planemaker", null)
SpawnTemplate("p_chair_intro", null, "-100 332 -65", "-30 90 0")
SpawnTemplate("p_cargoshop1", null, "936 1603 198", "0 180 0")
SpawnTemplate("p_shitcade2", null, "75 240 -85", "0 -90 0")
SpawnTemplate("p_smallammo", null, "-671 1462 192", "0 0 0")
SpawnTemplate("p_survrelay2", null)
SpawnTemplate("p_chair_intro", null, "127 332 -65", "-30 90 0")
SpawnTemplate("p_survshop1", null, "800 1514 267")
SpawnTemplate("viro_music", null)
SpawnTemplate("p_shitcade2", null, "-75 250 -85", "0 90 0")
SpawnTemplate("p_signbomb", null)
SpawnTemplate("p_smallmedkit", null, "671 945 -65", "0 0 0")
SpawnTemplate("p_slower1", null)
SpawnTemplate("p_smallmedkitskin", null, "1115 2545 192", "0 0 0")
SpawnTemplate("p_desk_intro", null, "19 315 -25", "0 0 90")
SpawnTemplate("p_finale_facerblu", null)
SpawnTemplate("p_smallammo", null, "20 498 230", "0 0 0")
SpawnTemplate("r_beatsoff", null)
SpawnTemplate("p_crash", null, "1200 3500 500")
SpawnTemplate("p_yeet2", null)
SpawnTemplate("p_kaboom", null, "0 1792 178", "0 90 0")
SpawnTemplate("p_yeet4", null)
SpawnTemplate("p_teleporter", null)
SpawnTemplate("p_smallammo", null, "671 893 -65", "0 0 0")
SpawnTemplate("p_fog", null)
SpawnTemplate("p_smallammo", null, "671 841 -65", "0 0 0")
SpawnTemplate("p_fullammo", null, "-697 895 350", "90 0 0")
SpawnTemplate("p_brokenwall_pusher", null)
SpawnTemplate("p_kaboom", null, "852 1445 200", "0 180 0")
SpawnTemplate("p_camera3", null)
SpawnTemplate("p_finale_facer", null)
SpawnTemplate("p_newlife", null)
SpawnTemplate("p_mediumkit", null, "-655 1225 30", "0 0 0")
SpawnTemplate("p_stair", null, "710 250 105", "0 90 0")
SpawnTemplate("p_sign6", null)
SpawnTemplate("p_survmoveup2", null, "-647 465 267")
SpawnTemplate("p_kaboom", null, "0 560 -55", "0 -90 0")
SpawnTemplate("p_screen", null)
SpawnTemplate("p_ledgefix_left", null)
SpawnTemplate("p_monstercage", null, "-655 1225 -65", "0 90 0")
SpawnTemplate("p_barricade_plate2", null, "-715 810 -65", "0 0 0")
SpawnTemplate("p_mapblock", null)
SpawnTemplate("r_beatson", null)
SpawnTemplate("p_spawns", null)
SpawnTemplate("p_bookcase", null, "-696 895 192", "0 0 0")
SpawnTemplate("p_hhhteleporter", null)
SpawnTemplate("p_shopitem2", null)
SpawnTemplate("p_barricade_plate2", null, "700 515 -85", "0 0 0")
SpawnTemplate("p_shutter_pusher", null)
SpawnTemplate("p_shopitem3", null)
SpawnTemplate("p_deskblock", null, "0 488 192")
SpawnTemplate("p_money", null)
SpawnTemplate("p_barricade_nolevel2", null, "390 2050 285", "90 90 0")
SpawnTemplate("overlay_stuff", null)
SpawnTemplate("p_plank2", null, "-223 1600 220", "0 90 0")
SpawnTemplate("p_box_intro", null, "9 320 -25", "0 -15 0")
SpawnTemplate("p_camera4", null)
SpawnTemplate("p_shopitem1", null)
SpawnTemplate("p_barrel", null, "647 375 189", "0 180 0")
SpawnTemplate("p_shitcade2", null, "75 250 -85", "0 90 0")
SpawnTemplate("ModelandScale_FailSafe_Engie", null, "0 0 0")
SpawnTemplate("p_kaboom", null, "0 80 -80", "-35 -90 0")
SpawnTemplate("p_barricade_nolevel3", null, "390 1925 345", "-90 90 0")
SpawnTemplate("p_beam", null, "562 1500 -25", "0 90 0")
SpawnTemplate("p_switcharoo1", null)
SpawnTemplate("p_skullhead", null)
SpawnTemplate("p_rick", null, "0 -35 788", "0 -90 0")
SpawnTemplate("p_yeet", null)
SpawnTemplate("p_barricade_plate2", null, "720 515 -65", "0 180 0")
SpawnTemplate("p_smallmedkitskin", null, "1115 2505 192", "0 0 0")
SpawnTemplate("p_slower8", null)
SpawnTemplate("p_desk", null, "0 488 192", "0 0 0")
SpawnTemplate("p_yeet_failsafe", null)
SpawnTemplate("p_barricade_level2", null, "-698 900 -65", "0 90 0")
SpawnTemplate("p_cargoshop3", null, "855 1520 255", "0 -90 0")
SpawnTemplate("p_survrelay3", null)
SpawnTemplate("p_fullkit", null, "554 793 93", "90 -90 0")
SpawnTemplate("p_sign1", null)
SpawnTemplate("p_smallammoskin", null, "1130 2525 212", "-90 0 0")
SpawnTemplate("p_table2", null, "-184 1000 -65", "0 0 0")
SpawnTemplate("p_smallammo", null, "-20 498 230", "0 0 0")
SpawnTemplate("r_cade_relay_last", null, "720 1280 192", "0 0 0")
SpawnTemplate("p_slower2", null)
SpawnTemplate("p_sign3", null)
SpawnTemplate("p_marketgardener", null, "0 676 10")
SpawnTemplate("p_keepertarget", null, "620 1430 267")
SpawnTemplate("p_sign0", null)
SpawnTemplate("p_camera", null)
SpawnTemplate("p_brokenwall_pusher2", null)
SpawnTemplate("p_spook", null, "578 235 215", "0 90 0")
SpawnTemplate("p_teleporter_brush_finale", null)
SpawnTemplate("p_nuke", null)
SpawnTemplate("p_switcharoo3", null)
SpawnTemplate("ModelandScale_FailSafe_Sniper", null, "0 0 0")
SpawnTemplate("p_sign7", null)
SpawnTemplate("p_barricade_nolevel", null, "-650 250 -85", "0 180 0")
SpawnTemplate("p_tank", null)
SpawnTemplate("p_bookcase", null, "555 792 -65", "0 -90 0")
SpawnTemplate("p_slower5", null)
SpawnTemplate("p_virofix", null)
SpawnTemplate("p_viewblocker_window", null)
SpawnTemplate("p_leap", null)
SpawnTemplate("p_slower7", null)
SpawnTemplate("p_sign9", null)
SpawnTemplate("p_sign2", null)
SpawnTemplate("r_cade_relay_window", null, "720 1280 192", "0 0 0")
SpawnTemplate("p_spook2", null, "520 220 225", "0 90 0")
SpawnTemplate("p_smallammo", null, "-671 1436 192", "0 0 0")
SpawnTemplate("p_slower3", null)
SpawnTemplate("p_fogold", null)
SpawnTemplate("ModelandScale_FailSafe_Pyro", null, "0 0 0")
SpawnTemplate("p_leap_tele", null)
SpawnTemplate("p_smallmedkit", null, "20 298 192", "0 0 0")
SpawnTemplate("p_bookcase", null, "696 620 192", "0 180 0")
SpawnTemplate("p_navblocker2", null)
SpawnTemplate("p_barrel", null, "660 375 189", "0 -180 0")
SpawnTemplate("p_beam", null, "562 1500 -50", "0 -90 0")
SpawnTemplate("p_threaten", null)
SpawnTemplate("p_kaboom", null, "0 1163 70", "0 -90 0")
SpawnTemplate("p_brokenstairs_clip", null)
SpawnTemplate("ModelandScale_FailSafe_Medic", null, "0 0 0")
SpawnTemplate("p_lastbot", null)
SpawnTemplate("p_cabinet", null, "720 1296 192", "0 0 0")
SpawnTemplate("p_survshop3", null, "940 1514 267")
SpawnTemplate("p_pointmaker", null, "626 -942 -85", "0 0 0")
SpawnTemplate("p_slower0", null)
SpawnTemplate("p_fullkit", null, "697 617 350", "90 180 0")
SpawnTemplate("p_barricade_level3b", null, "-225 1600 350", "0 0 0")
SpawnTemplate("p_survrelay1", null)
SpawnTemplate("p_kaboom", null, "532 2522 267", "0 45 0")
SpawnTemplate("p_switcharoo2", null)
SpawnTemplate("p_desk_intro", null, "9 320 -65", "0 0 0")
SpawnTemplate("p_barricade_level3a", null, "-475 1610 240", "0 0 0")
SpawnTemplate("p_barricade_level1", null, "515 252 277", "0 0 0")
SpawnTemplate("p_chat1", null)
SpawnTemplate("p_kaboom", null, "0 -240 -80", "0 -90 0")
SpawnTemplate("p_plank", null, "-300 1575 205", "45 90 90")
SpawnTemplate("p_plank", null, "-350 1575 205", "45 90 90")
SpawnTemplate("p_fade1", null)
SpawnTemplate("p_pointmaker2", null, "500 -985 -80", "0 25 0")
SpawnTemplate("p_slower6", null)
SpawnTemplate("p_nohud2", null)
SpawnTemplate("p_mvm_beat", null)
SpawnTemplate("p_crate", null, "-164 1007 -17", "0 90 0")
SpawnTemplate("p_chair", null, "0 450 192", "0 90 0")
SpawnTemplate("p_heli", null, "1200 3200 500", "36 90 0")
SpawnTemplate("p_table", null, "462 854 -65", "0 90 0")
SpawnTemplate("p_cargodoor", null, "636 1435 190", "0 -90 0")
SpawnTemplate("p_crate_intro", null, "-30 380 -65", "0 110 0")
SpawnTemplate("p_barricade_level2", null, "700 415 -65", "0 -90 0")
SpawnTemplate("p_sign4", null)
SpawnTemplate("p_shutter_pusher2", null)
SpawnTemplate("p_crate", null, "275 2350 100", "5 90 -5")
SpawnTemplate("p_crate2", null, "345 1640 150", "0 0 0")
SpawnTemplate("ModelandScale_FailSafe_Soldier", null, "0 0 0")
SpawnTemplate("p_smallmedkitskin", null, "1115 2525 192", "0 0 0")
SpawnTemplate("p_shopitem5", null)
SpawnTemplate("p_smallammo", null, "671 867 -65", "0 0 0")
SpawnTemplate("p_smallmedkit", null, "-20 298 192", "0 0 0")
SpawnTemplate("p_nohud1", null)
SpawnTemplate("p_shopitem4", null)
SpawnTemplate("p_chair_intro", null, "0 300 60", "130 0 0")
SpawnTemplate("p_crate_intro", null, "45 380 -65", "0 90 0")
SpawnTemplate("p_fade5", null)
SpawnTemplate("p_badsign", null)
SpawnTemplate("p_sign5", null)
SpawnTemplate("r_virobeatoff", null)
SpawnTemplate("ModelandScale_FailSafe_Scout", null, "0 0 0")
SpawnTemplate("p_sign8", null)
SpawnTemplate("p_survshop2", null, "870 1514 267")
SpawnTemplate("p_fade4", null)
SpawnTemplate("p_crate", null, "-197 993 -65", "0 90 0")
SpawnTemplate("p_barricade_plate3", null, "-735 1150 185", "0 0 0")
SpawnTemplate("p_smallmedkit", null, "0 325 192", "0 0 0")
SpawnTemplate("p_bookcase", null, "447 265 -65", "0 90 0")
SpawnTemplate("p_mediumammo", null, "-84 1258 80", "0 0 0")
SpawnTemplate("p_crate", null, "-597 1245 -65", "0 180 0")
SpawnTemplate("p_pusher2", null)
SpawnTemplate("p_tankgo", null, "706 -700 0")
SpawnTemplate("p_barricade_level3a", null, "500 1610 310", "0 180 0")
SpawnTemplate("p_shopengi", null, "945 1616 192", "0 -90 0")
SpawnTemplate("p_spawnfix", null)
SpawnTemplate("p_bookcase3", null, "339 1270 -45", "0 -90 -25")
SpawnTemplate("p_spook3", null, "570 220 195", "0 90 0")
SpawnTemplate("sentry_collision_template", null)
SpawnTemplate("p_zombie", null, "562 1600 -140", "0 -90 0")
SpawnTemplate("p_smallammoskin", null, "1130 2545 212", "-90 0 0")
SpawnTemplate("ModelandScale_FailSafe_Demo", null, "0 0 0")
SpawnTemplate("p_chair_intro", null, "-33 320 64", "170 180 0")
SpawnTemplate("p_barricade_level1", null, "575 252 277", "0 180 0")
SpawnTemplate("p_box", null, "-630 550 192", "0 -25 0")
SpawnTemplate("p_smallmedkit", null, "671 919 -65", "0 0 0")
SpawnTemplate("p_musicmaker2", null)
SpawnTemplate("p_teleporterfinale", null)
SpawnTemplate("r_respawn_relay", null, "720 1280 192", "0 0 0")
SpawnTemplate("p_teleporter_brush", null)
SpawnTemplate("p_barricade_plate3", null, "540 1640 185", "0 -90 0")
SpawnTemplate("p_virofix2", null)
SpawnTemplate("p_plank2", null, "-287 1600 220", "0 90 0")
SpawnTemplate("p_screenblu", null)
SpawnTemplate("p_camera2", null)
SpawnTemplate("reviveredasblu_player", null)
SpawnTemplate("r_virobeat", null)
SpawnTemplate("p_slower9", null)
SpawnTemplate("p_pusher", null)
SpawnTemplate("p_marketgardener2", null, "-5 1113 139")
SpawnTemplate("p_musicmaker1", null)
SpawnTemplate("p_shitcade", null, "0 250 -85", "0 180 0")
SpawnTemplate("p_barricade_level2", null, "-710 350 -50", "0 -90 0")
SpawnTemplate("p_smallmedkit", null, "671 971 -65", "0 0 0")
SpawnTemplate("r_cade_relay", null, "720 1280 192", "0 0 0")
SpawnTemplate("p_barricade_level3a", null, "-715 1280 280", "0 90 0")
SpawnTemplate("p_smallammoskin", null, "1130 2505 212", "-90 0 0")
SpawnTemplate("p_threaten2", null)
SpawnTemplate("p_introcam", null)
SpawnTemplate("p_fullammo", null, "444 262 93", "90 90 0")
SpawnTemplate("p_yeet3", null)
SpawnTemplate("p_sign666", null)