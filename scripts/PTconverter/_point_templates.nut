PointTemplates <- 
{
	corelogic =
	{
		NoFixup = 1,
		[0] =
		{
			logic_auto =
			{
				targetname = "mainrelay",
				"OnMapSpawn#1" : "wave_finished_relay,Kill,,0,-1",
				"OnMapSpawn#2" : "door_red_large_win_*,Open,,0,-1",
				"OnMapSpawn#3" : "trigger_multiple,Kill,,0,-1",
				"OnMapSpawn#4" : "trigger_push,Kill,,0,-1",
				"OnMapSpawn#5" : "ufo_*,Kill,,0,-1",
				"OnMapSpawn#6" : "trigger_catapult,Kill,,0,-1",
				"OnMapSpawn#7" : "red_respawnroom1,Kill,,0,-1",
				"OnMapSpawn#8" : "bombpath_arrows_*,Kill,,0,-1",
				"OnMapSpawn#9" : "m0*,Kill,,0,-1",
				"OnMapSpawn#10" : "m10,Kill,,0,-1",
				"OnMapSpawn#11" : "@bb144 -584 0 472 384 160@func_respawnroomvisualizer,Kill,,0,-1",
				"OnMapSpawn#12" : "relay_attributes,Kill,,0,-1",
				"OnMapSpawn#13" : "relay_invisible,Kill,,0,-1",
				OnMapSpawn = "playerRunScriptCodePopExtUtil.RemoveOutputAll(self, `effects`)1-1",
				OnMapSpawn = "playerRunScriptCodePopExtUtil.RemoveOutputAll(self, `effects`)2-1",
				OnMapSpawn = "playerRunScriptCodePopExtUtil.RemoveOutputAll(self, `renderfx`)0-1",
				"OnMapSpawn#14" : "merasmus_*,Kill,,0,-1",
				"OnMapSpawn#15" : "wave_start_relay,AddOutput,OnTrigger gameover:Enable:0:-1,0,-1",
				"OnMapSpawn#16" : "realtimer,trigger,,0,-1",
				"OnMapSpawn#17" : "ee_bool,disable,,0,-1",
				"OnMapSpawn#18" : "wave_start_relay,AddOutput,OnTrigger respawn_relay:Trigger:0:-1,0,-1",
				"OnMapSpawn#19" : "fog_controller,AddOutput,spawnflags 1:0:-1,0,-1",
				"OnMapSpawn#20" : "fog_controller,AddOutput,farz -1:0:-1,0,-1",
				"OnMapSpawn#21" : "player,$ResetExtraItems,,0,-1",
				"OnMapSpawn#22" : "tf_objective_resourceRunScriptCodeNetProps.SetPropString(self, `m_iszMvMPopfileName`, Bauernhof Der Toten)0-1,0,-1",
				"OnMapSpawn#23" : "wave_start_relay,AddOutput,OnTrigger LMA:Enable:0:-1,0,-1",
				"OnMapSpawn#24" : "func_flagdetectionzone,AddOutput,alarm 0,0,-1",
				"OnMapSpawn#25" : "wave_start_relay,AddOutput,OnTrigger DUMMY_*:Kill:0:-1,0,-1",
				"OnMapSpawn#26" : "wave_start_relay,AddOutput,OnTrigger tutorial_relay2:Disable:0:-1,0,-1",
				"OnMapSpawn#27" : "wave_start_relay,AddOutput,OnTrigger hints_*:Kill:0:-1,0,-1",
				"OnMapSpawn#28" : "wave_start_relay,AddOutput,OnTrigger tutorial_*:Kill:0:-1,0,-1",
				"OnMapSpawn#29" : "wave_start_relay,AddOutput,OnTrigger dumpster_hint:Show:2:-1,0,-1",
				"OnMapSpawn#30" : "wave_start_relay,AddOutput,OnTrigger navman:RecomputeBlockers:0:-1,0,-1",
				"OnMapSpawn#31" : "wave_start_relay,AddOutput,OnTrigger navman:RecomputeBlockers:1:-1,0,-1",
				"OnMapSpawn#32" : "wave_start_relay,AddOutput,OnTrigger navman:RecomputeBlockers:2:-1,0,-1",
			},
		},
		[1] =
		{
			tf_point_nav_interface =
			{
				targetname = "navman",
			},
		},
		[2] =
		{
			func_button =
			{
				origin = "2168 40 13604",
				mins = "-12 -10 -6",
				maxs = "24 10 6",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				damagefilter = "filter_redteam",
				speed = 5,
				wait = 20,
				sounds = 3,
				targetname = "revive_button",
				"OnPressed#1" : "popscript,$revivelogic,!activator,0,-1",
			},
		},
		[3] =
		{
			game_forcerespawn =
			{
				targetname = "respawner",
			},
		},
		[4] =
		{
			logic_relay =
			{
				targetname = "respawn_relay",
				"OnTrigger#1" : "respawner,ForceTeamRespawn,2,0,-1",
			},
		},
		[5] =
		{
			trigger_hurt =
			{
				damage = 4500,
				spawnflags = 1,
				mins = "-9999 -9999 -9999",
				maxs = "9999 9999 9999",
				startdisabled = 1,
				targetname = "hologram_nuke_hurt",
				filtername = "filter_notred",
				origin = "0 0 0",
			},
		},
		[6] =
		{
			filter_activator_tfteam =
			{
				targetname = "filter_notred",
				teamnum = 2,
				negated = 1,
			},
		},
		[7] =
		{
			logic_relay =
			{
				targetname = "wave_output_clear",
				OnTrigger = "playerRunScriptCodePopExtUtil.RemoveOutputAll(self, `$OnDamageReceived`)0-1",
				OnTrigger = "playerRunScriptCodePopExtUtil.RemoveOutputAll(self, `$OnDeath`)0-1",
				"OnTrigger#1" : "fog_controller,SetStartDist,600,,-1",
				"OnTrigger#2" : "fog_controller,SetEndDist,4000,,-1",
				"OnTrigger#3" : "fog_controller,SetColor,0 0 0,,-1",
				"OnTrigger#4" : "tf_objective_resourceRunScriptCodeNetProps.SetPropInt(self, `m_nMannVsMachineWaveCount`, 0)-1,0,-1",
			},
		},
		[8] =
		{
			math_counter =
			{
				targetname = "roundscleared",
				startvalue = 0,
				"outValue#1" : "survivalcheck,SetValueCompare,,0,-1",
			},
		},
		[9] =
		{
			logic_compare =
			{
				targetname = "survivalcheck",
				initialValue = 0,
				CompareValue = 4,
				"OnEqualTo#1" : "player,RunScriptCode,self.AddCurrency(1500),,-1",
				"OnEqualTo#2" : "playerRunScriptCodeClientPrint(self, 4, `You've received a 1500 Survival Bonus!`)-1,0,-1",
				"OnEqualTo#3" : "roundscleared,SetValue,0,,-1",
				"OnEqualTo#4" : "survivalcheck,SetValue,0,,-1",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				model = "models/player/demo.mdl",
				disableshadows = 1,
				solid = 0,
				targetname = "ee_demo",
				defaultanim = "crouch_LOSER",
				origin = "-428 2300 -2",
				angles = "0 315 0",
			},
		},
		[11] =
		{
			prop_dynamic_ornament =
			{
				targetname = "ee_bool",
				spawnflags = 256,
				model = "models/weapons/c_models/c_bottle/c_bottle.mdl",
				disableshadows = 1,
				startdisabled = 1,
				origin = "-428 2300 -2",
				lightingorigin = "ee_demo",
				InitialOwner = "ee_demo",
			},
		},
		[12] =
		{
			prop_dynamic_ornament =
			{
				targetname = "ee_shiv",
				spawnflags = 256,
				model = "models/workshop_partner/weapons/c_models/c_prinny_knife/c_prinny_knife.mdl",
				disableshadows = 1,
				startdisabled = 0,
				origin = "-428 2300 -2",
				lightingorigin = "ee_demo",
				InitialOwner = "ee_demo",
			},
		},
		[13] =
		{
			func_flagdetectionzone =
			{
				startdisabled = 0,
				targetname = "ee_detector",
				mins = "-5 -5 -24",
				maxs = "5 5 24",
				origin = "-413 2282 22",
				"OnStartTouchFlag#1" : "ee_beerflag,ForceResetAndDisableSilent,,-1,-1",
				"OnStartTouchFlag#2" : "ee_beerflag,Kill,,1,-1",
				"OnStartTouchFlag#3" : "ee_demo,SetAnimation,taunt03,0,-1",
				"OnStartTouchFlag#4" : "ee_bool,Enable,,0,-1",
				"OnStartTouchFlag#5" : "ee_shiv,Disable,,0,-1",
				"OnStartTouchFlag#6" : "ee_bool,Kill,,4,-1",
				"OnStartTouchFlag#7" : "ee_shiv,Enable,,4,-1",
				"OnStartTouchFlag#8" : "ee_demo,SetAnimation,taunt04,4,-1",
				"OnStartTouchFlag#9" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `items/gunpickup2.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })6.5-1",
				"OnStartTouchFlag#10" : "popscript,$GiveSuperShank,!activator,6.5,-1",
				"OnStartTouchFlag#11" : "!activatorRunScriptCodeClientPrint(self, 4, `Tavish has given you his Super Shank!`)6.5-1,0,-1",
				"OnStartTouchFlag#12" : "ee_shiv,Kill,,7,-1",
				"OnStartTouchFlag#13" : "ee_demo,SetAnimation,taunt_woohoo,7,-1",
				"OnStartTouchFlag#14" : "ee_demo,Kill,,8,-1",
			},
		},
		[14] =
		{
			item_teamflag =
			{
				targetname = "ee_beerflag",
				startdisabled = 1,
				flag_model = "models/player/items/taunts/beer_crate/beer_crate.mdl",
				origin = "2029 333 101",
				returntime = 60000,
				"OnPickup#1" : "!self,setteam,3,,-1",
				"OnDrop#1" : "!self,ForceResetAndDisableSilent,,-1,-1",
				"OnDrop#2" : "!self,Kill,,1,-1",
			},
		},
	},
	Spawn_things =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				model = "models/props/mvm_shadows/spawnroom.mdl",
				disableshadows = 1,
				solid = 6,
				origin = "320 -32 32",
				angles = "0 270 0",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				model = "models/props_gameplay/door_grate003_bottom.mdl",
				disableshadows = 1,
				solid = 6,
				origin = "133 0 -6",
				angles = "90 0 0",
			},
		},
		[2] =
		{
			prop_dynamic =
			{
				model = "models/props_gameplay/door_grate003_bottom.mdl",
				disableshadows = 1,
				solid = 6,
				origin = "59 0 -6",
				angles = "90 180 0",
			},
		},
		[3] =
		{
			prop_dynamic =
			{
				model = "models/props_viaduct_event/fog_plane03.mdl",
				disableshadows = 1,
				solid = 0,
				modelscale = 2,
				rendercolor = "103 103 103",
				origin = "-838 -2608 1634",
				angles = "0 0 -180",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				model = "models/props_viaduct_event/fog_plane03.mdl",
				disableshadows = 1,
				solid = 0,
				modelscale = 2,
				rendercolor = "103 103 103",
				origin = "-854 2690 1634",
				angles = "0 0 -180",
			},
		},
		[5] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-240 -608 -8",
				maxs = "240 608 8",
				origin = "256 16 768",
			},
		},
		[6] =
		{
			trigger_teleport =
			{
				StartDisabled = 1,
				filtername = "filter_redteam",
				spawnflags = 1,
				target = "warp_target",
				targetname = "red_spawn_warp",
				mins = "-232 -448 -16",
				maxs = "232 448 3000",
				origin = "264 -96 0",
			},
		},
		[7] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-240 -192 -284",
				maxs = "240 192 284",
				origin = "256 -400 492",
			},
		},
		[8] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-240 -136 -16",
				maxs = "240 136 3000",
				origin = "256 488 224",
			},
		},
		[9] =
		{
			info_teleport_destination =
			{
				targetname = "warp_target",
				angles = "0 270 0",
				origin = "322 -629 40",
			},
		},
		[10] =
		{
			info_teleport_destination =
			{
				targetname = "warp_target",
				angles = "0 90 0",
				origin = "258 428 40",
			},
		},
		[11] =
		{
			ambient_generic =
			{
				health = 8,
				message = "ambient/atmosphere/thunder1.wav",
				radius = 20,
				spawnflags = 49,
				targetname = "atmos_1",
			},
		},
		[12] =
		{
			ambient_generic =
			{
				health = 8,
				message = "ambient/atmosphere/thunder2.wav",
				radius = 20,
				spawnflags = 49,
				targetname = "atmos_2",
			},
		},
		[13] =
		{
			ambient_generic =
			{
				health = 8,
				message = "ambient/atmosphere/thunder3.wav",
				radius = 20,
				spawnflags = 49,
				targetname = "atmos_3",
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 8,
				message = "ambient/wind_gust2.wav",
				radius = 20,
				spawnflags = 49,
				targetname = "atmos_4",
			},
		},
		[15] =
		{
			logic_case =
			{
				targetname = "thunderpick",
				"OnCase01#1" : "atmos_1,PlaySound,,0,-1",
				"OnCase02#1" : "atmos_2,PlaySound,,0,-1",
				"OnCase03#1" : "atmos_3,PlaySound,,0,-1",
				"OnCase04#1" : "atmos_4,PlaySound,,0,-1",
			},
		},
		[16] =
		{
			logic_timer =
			{
				userandomtime = 1,
				lowerrandombound = 10,
				upperrandombound = 25,
				"OnTimer#1" : "thunderpick,PickRandom,,0,-1",
			},
		},
		[17] =
		{
			logic_relay =
			{
				targetname = "stage_start",
				"OnTrigger#1" : "powerup_timer,Enable,,0,-1",
				"OnTrigger#2" : "roundcounter,add,1,0,-1",
				"OnTrigger#3" : "realtimer,trigger,,0,-1",
				"OnTrigger#4" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#5" : "navman,RecomputeBlockers,,2,-1",
				"OnTrigger#6" : "navman,RecomputeBlockers,,3,-1",
				"OnTrigger#7" : "navman,RecomputeBlockers,,4,-1",
			},
		},
		[18] =
		{
			logic_relay =
			{
				targetname = "stage_start_finale",
				"OnTrigger#1" : "finale_snd,PlaySound,,0,-1",
			},
		},
		[19] =
		{
			logic_relay =
			{
				targetname = "stage_clear",
				"OnTrigger#1" : "roundclear_snd,PlaySound,,-1,-1",
				"OnTrigger#2" : "relay_enemycount_reset,Trigger,,-1,-1",
				"OnTrigger#3" : "medicbonus_relay,Trigger,,-1,-1",
				"OnTrigger#4" : "respawner,ForceTeamRespawn,2,0.7,-1",
				"OnTrigger#5" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#6" : "powerup_timer,Disable,,0,-1",
				"OnTrigger#7" : "hologram_*,Disable,,0,-1",
				"OnTrigger#8" : "plate,skin,0,0,-1",
				"OnTrigger#9" : "roundscleared,Add,1,0,0",
			},
		},
		[20] =
		{
			logic_relay =
			{
				targetname = "stage_clear_finale",
				"OnTrigger#1" : "roundclear_snd,PlaySound,,-1,-1",
				"OnTrigger#2" : "relay_enemycount_reset,Trigger,,-1,-1",
				"OnTrigger#3" : "medicbonus_relay,Trigger,,-1,-1",
				"OnTrigger#4" : "respawner,ForceTeamRespawn,2,0.7,-1",
				"OnTrigger#5" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#6" : "powerup_timer,Disable,,0,-1",
				"OnTrigger#7" : "hologram_*,Disable,,0,-1",
				"OnTrigger#8" : "plate,skin,0,0,-1",
				"OnTrigger#9" : "roundscleared,Add,1,0,0",
			},
		},
		[21] =
		{
			logic_relay =
			{
				targetname = "medicbonus_relay",
			},
		},
		[22] =
		{
			prop_dynamic =
			{
				model = "models/props_viaduct_event/underworld_sky01.mdl",
				targetname = "bossfog_dome",
				disableshadows = 1,
				startdisabled = 1,
				solid = 0,
				scale = 1,
				angles = "0 90 0",
				origin = "0 0 0",
			},
		},
		[23] =
		{
			env_fog_controller =
			{
				targetname = "fog_bossround",
				fogcolor = "129 130 180",
				fogcolor2 = "131 132 177",
				fogenable = 1,
				fogstart = -1000,
				fogend = 9000,
			},
		},
		[24] =
		{
			env_fade =
			{
				targetname = "bossfog_fadein",
				duration = 5,
				rendercolor = "34 38 33",
				renderamt = 255,
			},
		},
		[25] =
		{
			env_fade =
			{
				targetname = "bossfog_fadeout",
				duration = 5,
				rendercolor = "34 38 33",
				spawnflags = 1,
				renderamt = 255,
			},
		},
		[26] =
		{
			logic_relay =
			{
				targetname = "bossstage_start",
				"OnTrigger#1" : "door_red_large_win_*,Close,,0,-1",
				"OnTrigger#2" : "red_spawn_warp,Enable,,0,-1",
				"OnTrigger#3" : "roundcounter,add,1,0,-1",
				"OnTrigger#4" : "realtimer,trigger,,0,-1",
				"OnTrigger#5" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#6" : "bossfog_fadein,Fade,0,-1,-1",
				"OnTrigger#7" : "bossfog_fadeout,Fade,,5,-1",
				"OnTrigger#8" : "bossfog_dome,Enable,,5,-1",
				"OnTrigger#9" : "fog_controller,SetStartDist,-15000,5,-1",
				"OnTrigger#10" : "fog_controller,SetEndDist,6000,5,-1",
				"OnTrigger#11" : "fog_controller,SetColor,34 38 33,5,-1",
				"OnTrigger#12" : "fog_controller,SetColorSecondary,34 38 33,5,-1",
				"OnTrigger#13" : "navman,RecomputeBlockers,,2,-1",
				"OnTrigger#14" : "navman,RecomputeBlockers,,3,-1",
				"OnTrigger#15" : "navman,RecomputeBlockers,,4,-1",
				"OnTrigger#16" : "tf_gamerules,PlayVORed,shadows/announcer_bossround.mp3,7,-1",
				"OnTrigger#17" : "tankround_snd,PlaySound,,14,-1",
				"OnTrigger#18" : "player,SpeakResponseConcept,TLK_MVM_TANK_CALLOUT,17.5,-1",
				"OnTrigger#19" : "player,SpeakResponseConcept,TLK_MVM_ATTACK_THE_TANK ,35,-1",
			},
		},
		[27] =
		{
			logic_relay =
			{
				targetname = "bossstage_start_tread",
				"OnTrigger#1" : "door_red_large_win_*,Close,,0,-1",
				"OnTrigger#2" : "red_spawn_warp,Enable,,0,-1",
				"OnTrigger#3" : "roundcounter,add,1,0,-1",
				"OnTrigger#4" : "realtimer,trigger,,0,-1",
				"OnTrigger#5" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#6" : "bossfog_fadein,Fade,0,-1,-1",
				"OnTrigger#7" : "bossfog_fadeout,Fade,,5,-1",
				"OnTrigger#8" : "bossfog_dome,Enable,,5,-1",
				"OnTrigger#9" : "fog_controller,SetStartDist,-15000,5,-1",
				"OnTrigger#10" : "fog_controller,SetEndDist,6000,5,-1",
				"OnTrigger#11" : "fog_controller,SetColor,34 38 33,5,-1",
				"OnTrigger#12" : "fog_controller,SetColorSecondary,34 38 33,5,-1",
				"OnTrigger#13" : "navman,RecomputeBlockers,,2,-1",
				"OnTrigger#14" : "navman,RecomputeBlockers,,3,-1",
				"OnTrigger#15" : "navman,RecomputeBlockers,,4,-1",
				"OnTrigger#16" : "tf_gamerules,PlayVORed,shadows/announcer_chuckle.mp3,7,-1",
			},
		},
		[28] =
		{
			logic_relay =
			{
				targetname = "bossstage_clear",
				"OnTrigger#1" : "tf_gamerules,PlayVORed,#*shadows/bossround_end.mp3,0,-1",
				"OnTrigger#2" : "relay_enemycount_reset,Trigger,,-1,-1",
				"OnTrigger#3" : "medicbonus_relay,Trigger,,-1,-1",
				"OnTrigger#4" : "respawner,ForceTeamRespawn,2,0.7,-1",
				"OnTrigger#5" : "tankround_snd,volume,0,0,-1",
				"OnTrigger#6" : "bossfight_snd,volume,0,0,-1",
				"OnTrigger#7" : "bossround_music,volume,0,0,-1",
				"OnTrigger#8" : "realtimer,trigger,,0.23,-1",
				"OnTrigger#9" : "powerup_timer,Disable,,0,-1",
				"OnTrigger#10" : "hologram_*,Disable,,0,-1",
				"OnTrigger#11" : "plate,skin,0,0,-1",
				"OnTrigger#12" : "red_spawn_warp,Disable,,0,-1",
				"OnTrigger#13" : "door_red_large_win_*,Open,,0,-1",
				"OnTrigger#14" : "bossfog_fadein,Fade,0,-1,-1",
				"OnTrigger#15" : "bossfog_fadeout,Fade,,5,-1",
				"OnTrigger#16" : "bossfog_dome,Disable,,5,-1",
				"OnTrigger#17" : "roundscleared,Add,1,0,0",
				"OnTrigger#18" : "fog_controller,SetStartDist,600,5,-1",
				"OnTrigger#19" : "fog_controller,SetEndDist,4000,5,-1",
				"OnTrigger#20" : "ee_beerflag,Enable,,5,1",
				"OnTrigger#21" : "fog_controller,SetColor,0 0 0,5,-1",
				"OnTrigger#22" : "fog_controller,SetColorSecondary,255 255 255,5,-1",
			},
		},
		[29] =
		{
			logic_branch =
			{
				targetname = "tgun_check",
				InitialValue = 0,
				"OnFalse#1" : "!activator,$AwardAndGiveExtraItem,Thunder Gun,-1,-1",
				"OnFalse#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnFalse#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_ULTRARARE,0.6,-1",
				"OnFalse#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received an Ãœberweapon: The Thunder Gun!`)0-1,0,-1",
				"OnFalse#5" : "tgun_check,Toggle,,-1,-1",
				"OnTrue#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnTrue#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnTrue#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnTrue#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
			},
		},
		[30] =
		{
			prop_dynamic =
			{
				model = "models/props_forest/wood_stairs96.mdl",
				disableshadows = 1,
				solid = 6,
				angles = "0 180 0",
				origin = "928 1544 96",
			},
		},
		[31] =
		{
			prop_dynamic =
			{
				model = "models/props_forest/wood_stairs96.mdl",
				disableshadows = 1,
				solid = 6,
				angles = "0 180 0",
				origin = "-571 1924 87",
			},
		},
		[32] =
		{
			prop_dynamic =
			{
				model = "models/props_forest/wood_stairs96.mdl",
				disableshadows = 1,
				solid = 6,
				angles = "0 0 0",
				origin = "-568 1914 87",
			},
		},
		[33] =
		{
			prop_dynamic =
			{
				model = "models/props_forest/wood_stairs96.mdl",
				disableshadows = 1,
				solid = 6,
				angles = "0 12 0",
				origin = "-1483 -1834 60",
			},
		},
		[34] =
		{
			prop_dynamic =
			{
				model = "models/props_forest/wood_stairs96.mdl",
				disableshadows = 1,
				solid = 6,
				angles = "0 192 0",
				origin = "-1492 -1827 60",
			},
		},
	},
	Plate_Big =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				model = "models/props_gameplay/cap_point_base.mdl",
				disableshadows = 1,
				solid = 6,
				targetname = "plate",
				origin = "-540 -0 -182",
			},
		},
		[1] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_spinner",
				origin = "-540 -0 -164",
			},
		},
		[2] =
		{
			prop_dynamic =
			{
				model = "models/props_trainyard/cart_bomb_separate.mdl",
				disableshadows = 1,
				solid = 0,
				targetname = "hologram_nuke",
				rendermode = 1,
				renderfx = 15,
				startdisabled = 1,
				rendercolor = "255 0 0",
				parentname = "powerup_spinner",
				angles = "0 90 0",
				origin = "-540 -0 -128",
			},
		},
		[3] =
		{
			env_shake =
			{
				amplitude = 16,
				duration = 3,
				frequency = 40,
				radius = 48,
				spawnflags = 1,
				targetname = "nuke_shake",
			},
		},
		[4] =
		{
			env_fade =
			{
				targetname = "nuke_fade",
				duration = 1.3,
				spawnflags = 1,
				rendercolor = "255 255 255",
			},
		},
		[5] =
		{
			trigger_add_tf_player_condition =
			{
				targetname = "hologram_nuke",
				duration = 1,
				filtername = "filter_redteam",
				spawnflags = 1,
				StartDisabled = 1,
				condition = 23,
				origin = "-540 2 -128",
				mins = "-26 -26 -26",
				maxs = "26 26 26",
				"OnStartTouchAll#1" : "hologram_nuke,Disable,,-1,-1",
				"OnStartTouchAll#2" : "hologram_nuke_snd,PlaySound,,-1,-1",
				"OnStartTouchAll#3" : "nuke_shake,StartShake,,-1,-1",
				"OnStartTouchAll#4" : "nuke_fade,Fade,,-1,-1",
				"OnStartTouchAll#5" : "hologram_nuke_hurt,Enable,,0,-1",
				"OnStartTouchAll#6" : "hologram_nuke_hurt,Disable,,0.7,-1",
				"OnStartTouchAll#7" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/powerup_nuke_01.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })1-1",
				"OnStartTouchAll#8" : "powerup_timer,Enable,,-1,-1",
				"OnStartTouchAll#9" : "plate,skin,0,-1,-1",
				"OnStartTouchAll#10" : "!activator,RunScriptCode,self.AddCurrency(400),3,-1",
			},
		},
		[6] =
		{
			ambient_generic =
			{
				health = 10,
				message = ")misc/doomsday_missile_explosion.wav",
				radius = 20,
				pitch = 100,
				spawnflags = 49,
				targetname = "hologram_nuke_snd",
			},
		},
		[7] =
		{
			prop_dynamic =
			{
				model = "models/props_mvm/mvm_human_skull.mdl",
				disableshadows = 1,
				skin = 1,
				solid = 0,
				modelscale = 3,
				targetname = "hologram_instakill",
				rendermode = 1,
				renderfx = 15,
				startdisabled = 1,
				parentname = "powerup_spinner",
				rendercolor = "255 0 0",
				angles = "0 0 0",
				origin = "-540 -0 -134",
			},
		},
		[8] =
		{
			trigger_add_tf_player_condition =
			{
				targetname = "hologram_instakill",
				duration = 1,
				filtername = "filter_redteam",
				spawnflags = 1,
				StartDisabled = 1,
				condition = 23,
				origin = "-540 2 -128",
				mins = "-26 -26 -26",
				maxs = "26 26 26",
				"OnStartTouchAll#1" : "hologram_instakill,Disable,,-1,-1",
				"OnStartTouchAll#2" : "powerup_timer,Enable,,-1,-1",
				"OnStartTouchAll#3" : "plate,skin,0,-1,-1",
				"OnStartTouchAll#4" : "!activatorRunScriptCodeClientPrint(self, 4, `Instakill!`)0-1,0,-1",
				"OnStartTouchAll#5" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `items/powerup_pickup_crits.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnStartTouchAll#6" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/powerup_instagib.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })1-1",
				"OnStartTouchAll#7" : "!activatorRunScriptCodeself.AddCustomAttribute(`dmg current health`, 1, -1)-1,0,-1",
				"OnStartTouchAll#8" : "!activator,RunScriptCode,self.AddCond(56),,-1",
				"OnStartTouchAll#9" : "!activator,RunScriptCode,self.RemoveCustomAttribute(`dmg current health`),30,-1",
				"OnStartTouchAll#10" : "!activator,RunScriptCode,self.RemoveCond(56),30,-1",
			},
		},
		[9] =
		{
			prop_dynamic =
			{
				model = "models/props_gameplay/resupply_locker.mdl",
				disableshadows = 1,
				skin = 1,
				solid = 0,
				modelscale = 1,
				targetname = "hologram_maxammo",
				rendermode = 1,
				renderfx = 15,
				startdisabled = 1,
				parentname = "powerup_spinner",
				rendercolor = "255 0 0",
				angles = "0 0 0",
				origin = "-540 -0 -134",
			},
		},
		[10] =
		{
			trigger_add_tf_player_condition =
			{
				targetname = "hologram_maxammo",
				duration = 1,
				filtername = "filter_redteam",
				spawnflags = 1,
				StartDisabled = 1,
				condition = 23,
				origin = "-540 2 -128",
				mins = "-26 -26 -26",
				maxs = "26 26 26",
				"OnStartTouchAll#1" : "hologram_maxammo,Disable,,-1,-1",
				"OnStartTouchAll#2" : "powerup_timer,Enable,,-1,-1",
				"OnStartTouchAll#3" : "plate,skin,0,-1,-1",
				"OnStartTouchAll#4" : "!activatorRunScriptCodeClientPrint(self, 4, `Max Ammo!`)0-1,0,-1",
				"OnStartTouchAll#5" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `items/powerup_pickup_agility.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnStartTouchAll#6" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/powerup_resupply_01.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })1-1",
				"OnStartTouchAll#7" : "!activator,$RefillAmmo,,-1,-1",
			},
		},
		[11] =
		{
			prop_dynamic =
			{
				model = "models/items/currencypack_large.mdl",
				disableshadows = 1,
				skin = 1,
				solid = 0,
				modelscale = 1,
				targetname = "hologram_money",
				rendermode = 1,
				renderfx = 15,
				startdisabled = 1,
				parentname = "powerup_spinner",
				rendercolor = "255 0 0",
				angles = "0 0 0",
				origin = "-540 -0 -134",
			},
		},
		[12] =
		{
			trigger_add_tf_player_condition =
			{
				targetname = "hologram_money",
				duration = 1,
				filtername = "filter_redteam",
				spawnflags = 1,
				StartDisabled = 1,
				condition = 23,
				origin = "-540 2 -128",
				mins = "-26 -26 -26",
				maxs = "26 26 26",
				"OnStartTouchAll#1" : "hologram_money,Disable,,-1,-1",
				"OnStartTouchAll#2" : "powerup_timer,Enable,,-1,-1",
				"OnStartTouchAll#3" : "plate,skin,0,-1,-1",
				"OnStartTouchAll#4" : "!activatorRunScriptCodeClientPrint(self, 4, `Bonus Points!`)0-1,0,-1",
				"OnStartTouchAll#5" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `items/powerup_pickup_agility.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnStartTouchAll#6" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/powerup_money_01.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })1-1",
				"OnStartTouchAll#7" : "!activator,$AddCurrency,2000,-1,-1",
			},
		},
		[13] =
		{
			ambient_generic =
			{
				targetname = "powerup_snd",
				spawnflags = 48,
				health = 10,
				radius = 8000,
				pitch = 80,
				message = ")weapons/buffed_on.wav",
			},
		},
		[14] =
		{
			logic_timer =
			{
				targetname = "powerup_timer",
				StartDisabled = 1,
				UseRandomTime = 1,
				LowerRandomBound = 60,
				UpperRandomBound = 85,
				"OnTimer#1" : "powerup_case,PickRandomShuffle,,-1,-1",
				"OnTimer#2" : "powerup_timer,Disable,,-1,-1",
				"OnTimer#3" : "powerup_snd,PlaySound,,-1,-1",
				"OnTimer#4" : "plate,Skin,1,-1,-1",
			},
		},
		[15] =
		{
			logic_case =
			{
				targetname = "powerup_case",
				"OnCase01#1" : "hologram_instakill,Enable,,0,-1",
				"OnCase02#1" : "hologram_money,Enable,,0,-1",
				"OnCase03#1" : "hologram_maxammo,Enable,,0,-1",
				"OnCase05#1" : "hologram_nuke,Enable,,0,-1",
			},
		},
	},
	BuildingBlocks =
	{
		NoFixup = 1,
		[0] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-42 -160 -99",
				maxs = "42 160 99",
				origin = "698 488 63",
			},
		},
		[1] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-70 -58 -99",
				maxs = "70 58 99",
				origin = "914 98 63",
			},
		},
		[2] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-62 -214 -99",
				maxs = "62 214 99",
				origin = "1046 -58 63",
			},
		},
		[3] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-20 -48 -99",
				maxs = "20 48 99",
				origin = "964 -224 63",
			},
		},
		[4] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-110 -157 -99",
				maxs = "110 157 99",
				origin = "969 -928 63",
			},
		},
		[5] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-157 -38 -99",
				maxs = "157 38 99",
				origin = "-465 -560 92",
			},
		},
		[6] =
		{
			func_nobuild =
			{
				AllowDispenser = 0,
				AllowSentry = 0,
				AllowTeleporters = 0,
				StartDisabled = 0,
				Teamnum = 2,
				mins = "-59 -59 -61",
				maxs = "59 59 61",
				origin = "-1525 -1141 59",
			},
		},
		[7] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-106 -288 -26",
				maxs = "106 288 26",
				origin = "-738 -1622 18",
			},
		},
		[8] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-140 -20 -132",
				maxs = "140 20 132",
				origin = "-644 -492 -124",
			},
		},
		[9] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-140 -20 -132",
				maxs = "140 20 132",
				origin = "-644 492 -124",
			},
		},
		[10] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-84 -68 -48",
				maxs = "84 68 48",
				origin = "-556 -1916 50",
			},
		},
		[11] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-384 -68 -48",
				maxs = "384 68 48",
				origin = "-912 -1788 45",
			},
		},
		[12] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-116 -24 -72",
				maxs = "166 24 72",
				origin = "-220 1842 144",
			},
		},
		[13] =
		{
			func_nav_avoid =
			{
				tags = "bigguyalert",
				mins = "-116 -32 -72",
				maxs = "166 32 72",
				origin = "-220 1192 144",
			},
		},
		[14] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-64 -1472 -3168",
				maxs = "64 1472 3168",
				origin = "-5184 0 2912",
			},
		},
		[15] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-4575 -4384 -32",
				maxs = "4575 4384 32",
				origin = "-671 96 1344",
			},
		},
		[16] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-194 -209 -514",
				maxs = "194 209 514",
				origin = "-800 -702 798",
			},
		},
		[17] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-96 -201.5 -480",
				maxs = "96 201.5 480",
				origin = "-1088 -694 832",
			},
		},
		[18] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-192 -112 -560",
				maxs = "192 112 560",
				origin = "192 -720 752",
			},
		},
		[19] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-736 -384 -8",
				maxs = "736 384 8",
				origin = "256 1536 392",
			},
		},
		[20] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-12 -132 -72",
				maxs = "12 132 72",
				origin = "-1036 692 72",
			},
		},
		[21] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-80 -4 -72",
				maxs = "80 4 72",
				origin = "-960 556 72",
			},
		},
		[22] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-48 -4 -48",
				maxs = "48 4 48",
				origin = "-824 556 48",
			},
		},
		[23] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-4 -88 -48",
				maxs = "4 88 48",
				origin = "-780 648 48",
			},
		},
		[24] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-20 -12 -48",
				maxs = "20 12 48",
				origin = "-796 748 48",
			},
		},
		[25] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-40 -12 -58",
				maxs = "40 12 58",
				origin = "-856 748 58",
			},
		},
		[26] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-9 -192 -96",
				maxs = "9 192 96",
				origin = "7 0 96",
			},
		},
		[27] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-194 -608 -414",
				maxs = "194 608 414",
				origin = "128 -1856 900",
			},
		},
		[28] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-96 -143 -412",
				maxs = "96 143 412",
				origin = "416 -1392 900",
			},
		},
		[29] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-84 -143 -12",
				maxs = "84 143 12",
				origin = "428 -1392 476",
			},
		},
		[30] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-72 -143 -12",
				maxs = "72 143 12",
				origin = "440 -1392 452",
			},
		},
		[31] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-64 -143 -12",
				maxs = "64 143 12",
				origin = "448 -1392 428",
			},
		},
		[32] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-52 -143 -12",
				maxs = "52 143 12",
				origin = "460 -1392 404",
			},
		},
		[33] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-44 -143 -12",
				maxs = "44 143 12",
				origin = "468 -1392 380",
			},
		},
		[34] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-44 -143 -12",
				maxs = "44 143 12",
				origin = "477 -1392 356",
			},
		},
		[35] =
		{
			func_forcefield =
			{
				StartDisabled = 0,
				TeamNum = 3,
				mins = "-44 -143 -12",
				maxs = "44 143 12",
				origin = "486 -1392 332",
			},
		},
	},
	Pushblocks =
	{
		[0] =
		{
			trigger_push =
			{
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1 0 194",
				mins = "-1 -192 -2",
				maxs = "1 192 2",
			},
		},
		[1] =
		{
			trigger_push =
			{
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "994 992 160",
				mins = "-32 -110 -11",
				maxs = "32 110 11",
			},
		},
		[2] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "696 472 158",
				mins = "-32 -72 -11",
				maxs = "32 72 11",
			},
		},
		[3] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "696 364 85",
				mins = "-32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[4] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "696 596 85",
				mins = "-32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[5] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "966 88 83",
				mins = "-32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[6] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "892 107 83",
				mins = "-32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[7] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1024 -32 83",
				mins = "-32 -72 -11",
				maxs = "32 72 11",
			},
		},
		[8] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1056 -172 97",
				mins = "32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[9] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1000 -220 97",
				mins = "32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[10] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "973 -915 163",
				mins = "32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[11] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "917 -963 163",
				mins = "32 -28 -11",
				maxs = "32 28 11",
			},
		},
		[12] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "652 -468 276",
				mins = "-10 -181 -12",
				maxs = "10 181 12",
			},
		},
		[13] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1248 1516 204",
				mins = "-224 -12 -12",
				maxs = "224 12 12",
			},
		},
		[14] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1680 1500 196",
				mins = "-208 -28 -20",
				maxs = "208 28 20",
			},
		},
		[15] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1880 1724 196",
				mins = "-16 -196 -20",
				maxs = "16 196 20",
			},
		},
		[16] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "1908 2120 188",
				mins = "-12 -200 -28",
				maxs = "12 200 28",
			},
		},
		[17] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "522 -45 396",
				mins = "-10 -483 -12",
				maxs = "10 483 12",
			},
		},
		[18] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1256 488 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[19] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1278 1475 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[20] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1747 1473 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[21] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1713 798 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[22] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-2112 -574 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[23] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1577 -1785 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[24] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-729 -1737 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[25] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-320 -2530 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[26] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "738 -2496 524",
				mins = "-48 -48 -12",
				maxs = "48 48 12",
			},
		},
		[27] =
		{
			trigger_push =
			{
				pushdir = "0 45 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-2226 -726 232",
				mins = "-175 -175 -48",
				maxs = "175 175 48",
			},
		},
		[28] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-466 -555 84",
				mins = "-158 -43 -84",
				maxs = "158 43 84",
			},
		},
		[29] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-1660 1920 274",
				mins = "-900 -3 -26",
				maxs = "900 3 26",
			},
		},
		[30] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-400 -978 146",
				mins = "-136 -9.5 -12",
				maxs = "136 9.5 12",
			},
		},
		[31] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-272 -908 146",
				mins = "-8 -60 12",
				maxs = "8 60 12",
			},
		},
		[32] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-68 -864 146",
				mins = "-68 -48 12",
				maxs = "68 48 12",
			},
		},
		[33] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "416 -1264 372",
				mins = "-96 -16 -124",
				maxs = "96 16 124",
			},
		},
		[34] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "123 2342 205",
				mins = "-56 -78 -24",
				maxs = "56 78 24",
			},
		},
		[35] =
		{
			trigger_push =
			{
				pushdir = "0 90 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "128 -1276 220",
				mins = "-256 -4 -12",
				maxs = "256 4 12",
			},
		},
		[36] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "108 -1688 390",
				mins = "-68 -8 -4",
				maxs = "68 8 4",
			},
		},
		[37] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "168 -1648 390",
				mins = "-8 -32 -4",
				maxs = "8 32 4",
			},
		},
		[38] =
		{
			trigger_push =
			{
				pushdir = "0 270 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				filtername = "filter_redteam",
				origin = "-72.5 -1856 890.5",
				mins = "-10.5 -608 -421.5",
				maxs = "10.5 608 421.5",
			},
		},
	},
	PlayersLeftLogic =
	{
		NoFixup = 1,
		[0] =
		{
			math_counter =
			{
				targetname = "playersLeftAlive",
				startvalue = 0,
				"outValue#1" : "wipeCheck,SetValueCompare,,0,-1",
			},
		},
		[1] =
		{
			logic_compare =
			{
				targetname = "wipeCheck",
				initialValue = 0,
				CompareValue = 0,
				"OnEqualTo#1" : "gameover,Trigger,,0,-1",
				"OnGreaterThan#1" : "gameover,CancelPending,,0,-1",
			},
		},
		[2] =
		{
			ambient_generic =
			{
				health = 10,
				message = "#*shadows/goodeffort.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "fail_snd",
			},
		},
		[3] =
		{
			ambient_generic =
			{
				health = 10,
				message = "#*shadows/stage_clear.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "roundclear_snd",
			},
		},
		[4] =
		{
			ambient_generic =
			{
				health = 10,
				message = "#*shadows/youdidit.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "win_snd",
			},
		},
		[5] =
		{
			ambient_generic =
			{
				health = 10,
				message = "#*shadows/makeitcount.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "finale_snd",
			},
		},
		[6] =
		{
			ambient_generic =
			{
				health = 10,
				message = "#*shadows/bossround_music.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "tankround_snd",
			},
		},
	},
	PlayerTracker =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "playersLeftAlive",
				Action = "add",
				Param = 1,
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "popscript",
				Action = "$playertracker",
			},
		},
		[2] =
		{
			logic_relay =
			{
				$OnKilled = "playersLeftAlive,Subtract,1,0,0",
			},
		},
		[3] =
		{
			OnParentKilledOutput =
			{
				Target = "popscript",
				Action = "$spawn_revive_marker",
			},
		},
	},
	Revivemarker =
	{
		[0] =
		{
			trigger_multiple =
			{
				targetname = "revive_trigger",
				mins = "-36 -36 -36",
				maxs = "36 36 36",
				spawnflags = 1,
				"OnStartTouch#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to revive your teammate`)0-1,0,-1",
			},
		},
		[1] =
		{
			OnParentKilledOutput =
			{
				Target = "revive_trigger",
				Action = "DisableAndEndTouch",
			},
		},
	},
	EnemyTracker =
	{
		[0] =
		{
			OnParentKilledOutput =
			{
				Target = "!activator",
				Action = "$RemoveOutput",
				Param = "$OnDeath",
			},
		},
		[1] =
		{
			OnParentKilledOutput =
			{
				Target = "relay_enemycount_subtract",
				Action = "trigger",
			},
		},
		[2] =
		{
			OnSpawnOutput =
			{
				Target = "relay_enemycount_add",
				Action = "trigger",
			},
		},
		[3] =
		{
			OnSpawnOutput =
			{
				Target = "popscript",
				Action = "$OnWaveSpawnBot",
			},
		},
		[4] =
		{
			logic_relay =
			{
			},
		},
	},
	Hulk_PT =
	{
		KeepAlive = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "hankerman",
				Action = "SetPlaybackRate",
				Param = 0,
				Delay = 0.01,
			},
		},
		[1] =
		{
			OnParentKilledOutput =
			{
				Target = "hankerman",
				Action = "Enable",
			},
		},
		[2] =
		{
			OnParentKilledOutput =
			{
				Target = "hankerman",
				Action = "SetPlaybackRate",
				Param = 1,
				Delay = 0.02,
			},
		},
		[3] =
		{
			prop_dynamic =
			{
				targetname = "hankerman",
				angles = "0 0 0",
				origin = "0 0 0",
				DisableBoneFollowers = 1,
				disableshadows = 0,
				StartDisabled = 1,
				skin = 1,
				model = "models/kirillian/infected/hank_v4.mdl",
				DefaultAnim = "Death",
				ModelScale = 1.75,
				solid = 0,
				"OnAnimationDone#1" : "!self,SetAnimation,deathpose_incap,0,-1",
				"OnAnimationDone#2" : "!self,SetPlaybackRate,0,,-1",
				"OnAnimationDone#3" : "hanked,start,,,-1",
				"OnAnimationDone#4" : "hanked,kill,,3,-1",
				"OnAnimationDone#5" : "!self,Kill,,,-1",
			},
		},
		[4] =
		{
			info_particle_system =
			{
				targetname = "hanked",
				origin = "0 0 48",
				effect_name = "skull_island_explosion",
			},
		},
	},
	Crawler_PT =
	{
		[0] =
		{
			trigger_push =
			{
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 1000,
				filtername = "filter_crawler",
				StartDisabled = 1,
				targetname = "crawlerpush",
				mins = "-24 -24 -24",
				maxs = "24 24 24",
			},
		},
		[1] =
		{
			ambient_generic =
			{
				targetname = "crawler_hop_sfx",
				spawnflags = 48,
				health = 10,
				radius = 14000,
				pitch = 100,
				message = ")player/pl_scout_jump1.wav",
			},
		},
		[2] =
		{
			logic_timer =
			{
				refiretime = 14,
				"OnTimer#1" : "crawlerpush,Enable,,0,-1",
				"OnTimer#2" : "crawler_hop_sfx,PlaySound,,0,-1",
				"OnTimer#3" : "crawlerpush,Disable,,0.7,-1",
			},
		},
		[3] =
		{
			filter_tf_bot_has_tag =
			{
				targetname = "filter_crawler",
				require_all_tags = 1,
				tags = "crawler",
				Negated = "Allow entities that match criteria",
			},
		},
	},
	Charger_PT =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "popscript",
				Action = "$chargerLogic",
			},
		},
	},
	Soldier_Tank =
	{
		NoFixup = 1,
		KeepAlive = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "autotank_turret_weapon",
				Action = "$SetOwner",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				angles = "0 0 0",
				origin = "0 0 -8",
				DisableBoneFollowers = 1,
				disableshadows = 0,
				model = "models/props_frontline/tank_animated.mdl",
				DefaultAnim = "move_slow",
				ModelScale = 0.55,
				solid = 0,
				skin = 1,
				targetname = "autotank_body",
			},
		},
		[2] =
		{
			prop_dynamic =
			{
				angles = "0 0 0",
				origin = "0 0 -8",
				DisableBoneFollowers = 1,
				disableshadows = 0,
				StartDisabled = 1,
				model = "models/bots/soldier/bot_soldier.mdl",
				DefaultAnim = "PRIMARY_stun_middle",
				ModelScale = 1.75,
				solid = 0,
				skin = 1,
				targetname = "autotank_gibby",
				parentname = "autotank_body",
			},
		},
		[3] =
		{
			info_particle_system =
			{
				angles = "0 0 0",
				origin = "0 0 0",
				effect_name = "cinefx_goldrush",
				start_active = 0,
				targetname = "autotank_blast",
				parentname = "autotank_body",
			},
		},
		[4] =
		{
			ambient_generic =
			{
				targetname = "autotank_deathsound",
				spawnflags = 17,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")shadows/treadkill_death.mp3",
				parentname = "autotank_body",
			},
		},
		[5] =
		{
			ambient_generic =
			{
				targetname = "autotank_explosionsound",
				spawnflags = 17,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")mvm/mvm_tank_explode.wav",
				parentname = "autotank_body",
			},
		},
		[6] =
		{
			info_particle_system =
			{
				angles = "0 180 0",
				origin = "-70 38 52",
				effect_name = "kartdamage_smoke4",
				start_active = 1,
				targetname = "autotank_smoke",
				parentname = "autotank_body",
			},
		},
		[7] =
		{
			info_particle_system =
			{
				angles = "0 180 0",
				origin = "-70 -39 52",
				effect_name = "kartdamage_smoke4",
				start_active = 1,
				targetname = "autotank_smoke",
				parentname = "autotank_body",
			},
		},
		[8] =
		{
			env_shake =
			{
				amplitude = 16,
				duration = 1.5,
				frequency = 2.5,
				radius = 1500,
				spawnflags = 1,
				targetname = "autotank_shake",
			},
		},
		[9] =
		{
			ambient_generic =
			{
				targetname = "autotank_turret_ready",
				spawnflags = 48,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")vehicles/tank_readyfire1.wav",
				parentname = "autotank_body",
			},
		},
		[10] =
		{
			ambient_generic =
			{
				targetname = "autotank_ragemode",
				spawnflags = 48,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")shadows/treadkill_rage.mp3",
				parentname = "autotank_body",
			},
		},
		[11] =
		{
			ambient_generic =
			{
				targetname = "autotank_turret_shoot",
				spawnflags = 48,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")player/taunt_tank_shoot.wav",
				parentname = "autotank_body",
			},
		},
		[12] =
		{
			tf_point_weapon_mimic =
			{
				origin = "125 0 59",
				damage = 75,
				speedmin = 2200,
				speedmax = 2200,
				splashradius = 216,
				targetname = "autotank_turret_weapon",
				parentname = "autotank_body",
			},
		},
		[13] =
		{
			logic_relay =
			{
				targetname = "autotank_turretshoot",
				"OnTrigger#1" : "autotank_turret_ready,PlaySound,,0,-1",
				"OnTrigger#2" : "autotank_body,SetAnimation,shoot_forward,1,-1",
				"OnTrigger#3" : "autotank_turret_weapon,Fireonce,,1.3,-1",
				"OnTrigger#4" : "autotank_turret_shoot,PlaySound,,1.3,-1",
			},
		},
		[14] =
		{
			logic_relay =
			{
				targetname = "autotank_death",
				"OnTrigger#1" : "autotank_idle,StopSound,,0,-1",
				"OnTrigger#2" : "autotank_gibby,Enable,,0,-1",
				"OnTrigger#3" : "autotank_smoke,Stop,,0,-1",
				"OnTrigger#4" : "autotank_gibby,SetAnimation,PRIMARY_Stun_begin,0,-1",
				"OnTrigger#5" : "autotank_gibby,SetPlaybackRate,0.36,0.3,-1",
				"OnTrigger#6" : "autotank_deathsound,PlaySound,,0,-1",
				"OnTrigger#7" : "autotank_gibby,Disable,,3,-1",
				"OnTrigger#8" : "autotank_body,Disable,,3,-1",
				"OnTrigger#9" : "autotank_explosionsound,PlaySound,,3,-1",
				"OnTrigger#10" : "autotank_blast,Start,,3,-1",
				"OnTrigger#11" : "autotank_shake,StartShake,,3,-1",
				"OnTrigger#12" : "autotank_*,Kill,,8,-1",
			},
		},
	},
	Heavy_Boss =
	{
		NoFixup = 1,
		KeepAlive = 1,
		[0] =
		{
			prop_dynamic_ornament =
			{
				InitialOwner = "blord",
				spawnflags = 256,
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				targetname = "battlelord_cosmetics",
				model = "models/workshop/player/items/soldier/hwn2015_hellmet/hwn2015_hellmet.mdl",
			},
		},
		[1] =
		{
			prop_dynamic_ornament =
			{
				InitialOwner = "blord",
				spawnflags = 256,
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				targetname = "battlelord_cosmetics",
				model = "models/workshop/player/items/demo/sf14_deadking_pauldrons/sf14_deadking_pauldrons.mdl",
			},
		},
		[2] =
		{
			prop_dynamic_ornament =
			{
				InitialOwner = "blord",
				spawnflags = 256,
				DisableBoneFollowers = 1,
				disableshadows = 1,
				solid = 0,
				targetname = "battlelord_cosmetics",
				model = "models/workshop/weapons/c_models/c_iron_curtain/c_iron_curtain.mdl",
			},
		},
		[3] =
		{
			logic_relay =
			{
				targetname = "battlelord_cosmetics_relay",
				"OnTrigger#1" : "battlelord_cosmetics,TurnOff,,2,-1",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				angles = "0 0 0",
				origin = "0 0 0",
				DisableBoneFollowers = 1,
				disableshadows = 0,
				StartDisabled = 1,
				model = "models/bots/heavy_boss/bot_heavy_boss.mdl",
				DefaultAnim = "primary_death_01",
				ModelScale = 1.75,
				solid = 0,
				skin = 1,
				targetname = "blord",
			},
		},
		[5] =
		{
			ambient_generic =
			{
				targetname = "blord_deathsound",
				spawnflags = 17,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")shadows/battlelord_death.mp3",
				parentname = "blord",
			},
		},
		[6] =
		{
			info_particle_system =
			{
				angles = "0 0 0",
				origin = "0 0 0",
				effect_name = "cinefx_goldrush",
				start_active = 0,
				targetname = "blord_blast",
				parentname = "blord",
			},
		},
		[7] =
		{
			env_shake =
			{
				amplitude = 16,
				duration = 1.5,
				frequency = 2.5,
				radius = 1500,
				spawnflags = 1,
				targetname = "blord_shake",
			},
		},
		[8] =
		{
			ambient_generic =
			{
				targetname = "blord_explosionsound",
				spawnflags = 17,
				health = 10,
				radius = 18000,
				pitch = 100,
				message = ")mvm/mvm_tank_explode.wav",
				parentname = "blord",
			},
		},
		[9] =
		{
			logic_relay =
			{
				targetname = "blord_death",
				"OnTrigger#1" : "blord,Enable,,0,-1",
				"OnTrigger#2" : "battlelord_cosmetics,TurnOn,,0,-1",
				"OnTrigger#3" : "blord,SetAnimation,primary_death_01,0,-1",
				"OnTrigger#4" : "blord_deathsound,PlaySound,,0,-1",
				"OnTrigger#5" : "blord,Disable,,3.4,-1",
				"OnTrigger#6" : "battlelord_cosmetics,kill,,3.4,-1",
				"OnTrigger#7" : "blord_explosionsound,PlaySound,,3.4,-1",
				"OnTrigger#8" : "blord_blast,Start,,3.4,-1",
				"OnTrigger#9" : "blord_shake,StartShake,,3.4,-1",
				"OnTrigger#10" : "blord_*,Kill,,8,-1",
			},
		},
	},
	tutorial =
	{
		NoFixup = 1,
		[0] =
		{
			logic_relay =
			{
				spawnflags = 2,
				targetname = "tutorial_relay",
				"OnTrigger#1" : "hints_1,Show,,0,-1",
				"OnTrigger#2" : "hints_2,Show,,4,-1",
				"OnTrigger#3" : "hints_3,Show,,8,-1",
				"OnTrigger#4" : "hints_4,Show,,12,-1",
				"OnTrigger#5" : "hints_5,Show,,16,-1",
				"OnTrigger#6" : "hints_6,Show,,20,-1",
				"OnTrigger#7" : "hints_7,Show,,24,-1",
				"OnTrigger#8" : "hints_8,Show,,28,-1",
				"OnTrigger#9" : "hints_9,Show,,32,-1",
				"OnTrigger#10" : "hints_10,Show,,36,-1",
				"OnTrigger#11" : "hints_11,Show,,40,-1",
				"OnTrigger#12" : "hints_12,Show,,44,-1",
				"OnTrigger#13" : "hints_15,Show,,48,-1",
				"OnTrigger#14" : "tutorial_relay2,Trigger,,52,-1",
			},
		},
		[1] =
		{
			logic_relay =
			{
				spawnflags = 2,
				targetname = "tutorial_relay2",
				"OnTrigger#1" : "tutorial_relay,Trigger,,0,-1",
			},
		},
		[2] =
		{
			training_annotation =
			{
				targetname = "hints_1",
				display_text = "Money is earned only by dealing damage and killing enemies.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[3] =
		{
			training_annotation =
			{
				targetname = "hints_2",
				display_text = "Enemies become faster and stronger each round.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[4] =
		{
			training_annotation =
			{
				targetname = "hints_3",
				display_text = "You can purchase Perk Bonuses from vending machines around the map.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[5] =
		{
			training_annotation =
			{
				targetname = "hints_4",
				display_text = "Perk Bonuses are not permanent and are lost on death.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[6] =
		{
			training_annotation =
			{
				targetname = "hints_5",
				display_text = "Perk Bonuses stack with your weapon upgrades.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[7] =
		{
			training_annotation =
			{
				targetname = "hints_6",
				display_text = "Perk Bonuses do not stack per additional purchase.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[8] =
		{
			training_annotation =
			{
				targetname = "hints_7",
				display_text = "You can also receive random weapons from your local Weapons Dumpster.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[9] =
		{
			training_annotation =
			{
				targetname = "hints_8",
				display_text = "Weapons received are returned to you after death.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[10] =
		{
			training_annotation =
			{
				targetname = "hints_9",
				display_text = "Medics supply ammo and health to nearby teammates.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[11] =
		{
			training_annotation =
			{
				targetname = "hints_10",
				display_text = "Moving and crouching both affect your accuracy.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[12] =
		{
			training_annotation =
			{
				targetname = "hints_11",
				display_text = "Powerups have a chance to drop from zombies during waves.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[13] =
		{
			training_annotation =
			{
				targetname = "hints_12",
				display_text = "Powerups despawn after 30 seconds of being dropped.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[14] =
		{
			training_annotation =
			{
				targetname = "hints_15",
				display_text = "Players cannot join the game once it begins.",
				lifetime = 4,
				origin = "328 -150 52",
			},
		},
		[15] =
		{
			OnSpawnOutput =
			{
				Target = "tutorial_relay",
				Action = "Trigger",
				Delay = 4,
			},
		},
	},
	DummyMachines =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "477 -2103 4",
				angles = "0 270 0",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "DUMMY_1",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				origin = "-1157 -597 -198",
				angles = "0 90 0",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "DUMMY_2",
			},
		},
		[2] =
		{
			prop_dynamic =
			{
				origin = "197 -2659 12",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 1,
				targetname = "DUMMY_3",
			},
		},
		[3] =
		{
			prop_dynamic =
			{
				origin = "-19 1893 206",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "DUMMY_4",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "-1794 1236 -2",
				angles = "0 270 0",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "DUMMY_5",
			},
		},
	},
	Vending_Jugg =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 50",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "vm_jug",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				origin = "0 0 164",
				angles = "0 270 0",
				disableshadows = 0,
				model = "models/effects/medicyell.mdl",
				modelscale = 2,
				solid = 0,
				parentname = "vm_jug",
			},
		},
		[2] =
		{
			func_button =
			{
				targetname = "vm_jugbutton",
				parentname = "vm_jug",
				damagefilter = "filter_juggmulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 1,
				sounds = 3,
				origin = "0 -12 128",
				mins = "-24 -8 -44",
				maxs = "24 8 44",
				"OnPressed#1" : "perkbuff_jugg,trigger,0,-1,-1",
			},
		},
		[3] =
		{
			$filter_sendprop =
			{
				targetname = "filter_juggmoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 2500,
				$compare = "greater than or equal",
			},
		},
		[4] =
		{
			filter_multi =
			{
				targetname = "filter_juggmulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_juggmoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[5] =
		{
			filter_damage_type =
			{
				targetname = "filter_melee",
				negated = 0,
				damagetype = 134221952,
			},
		},
		[6] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "vm_jugmsg",
				parentname = "vm_jug",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-128 -128 0",
				maxs = "128 128 128",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to buy Saxton Ale for $2500`)0-1,0,-1",
			},
		},
		[7] =
		{
			ambient_generic =
			{
				targetname = "vm_jugsfx",
				spawnflags = 48,
				health = 10,
				radius = 15000,
				pitch = 100,
				message = "shadows/perk_saxton.mp3",
				parentname = "vm_jug",
			},
		},
		[8] =
		{
			logic_relay =
			{
				targetname = "perkbuff_jugg",
				"OnTrigger#1" : "!activator,$RemoveCurrency,2500,-1,-1",
				"OnTrigger#2" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/perk_usesfx.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnTrigger#3" : "vm_jugsfx,PlaySound,0,2.2,-1",
				"OnTrigger#4" : "!activatorRunScriptCodeself.AddCustomAttribute(`max health additive bonus`, 150, -1)2.2-1,0,-1",
				"OnTrigger#5" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `weapons/buffed_on.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })2.2-1",
				"OnTrigger#6" : "!activatorRunScriptCodeClientPrint(self, 4, `Perk Bonus activated: Extra max health!`)2.2-1,0,-1",
				"OnTrigger#7" : "!activator,SpeakResponseConcept,TLK_PLAYER_SPELL_PICKUP_RARE,2.45,-1",
			},
		},
	},
	Vending_Speed =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 50",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "vm_speed",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				origin = "0 0 164",
				angles = "0 270 0",
				disableshadows = 0,
				model = "models/props_halloween/merasmus_skull_island.mdl",
				solid = 0,
				parentname = "vm_speed",
			},
		},
		[2] =
		{
			func_button =
			{
				targetname = "vm_speedbutton",
				parentname = "vm_speed",
				damagefilter = "filter_speedmulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 3,
				sounds = 3,
				origin = "0 -12 128",
				mins = "-24 -8 -44",
				maxs = "24 8 44",
				"OnPressed#1" : "perkbuff_speed,trigger,0,-1,-1",
			},
		},
		[3] =
		{
			$filter_sendprop =
			{
				targetname = "filter_speedmoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 3000,
				$compare = "greater than or equal",
			},
		},
		[4] =
		{
			filter_multi =
			{
				targetname = "filter_speedmulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_speedmoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[5] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "vm_speedmsg",
				parentname = "vm_speed",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-128 -128 0",
				maxs = "64 64 128",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to buy Meraslixir for $3000`)0-1,0,-1",
			},
		},
		[6] =
		{
			ambient_generic =
			{
				targetname = "vm_speedsfx",
				spawnflags = 48,
				health = 10,
				radius = 15000,
				pitch = 100,
				message = "shadows/perk_meraslixir.mp3",
				parentname = "vm_speed",
			},
		},
		[7] =
		{
			logic_relay =
			{
				targetname = "perkbuff_speed",
				"OnTrigger#1" : "!activator,$RemoveCurrency,3000,-1,-1",
				"OnTrigger#2" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/perk_usesfx.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnTrigger#3" : "vm_speedsfx,PlaySound,0,2.2,-1",
				"OnTrigger#4" : "!activatorRunScriptCodeself.AddCustomAttribute(`faster reload rate`, 0.5, -1)2.2-1,0,-1",
				"OnTrigger#5" : "!activatorRunScriptCodeself.AddCustomAttribute(`move speed bonus`, 1.15, -1)2.2-1,0,-1",
				"OnTrigger#6" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `weapons/buffed_on.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })2.2-1",
				"OnTrigger#7" : "!activatorRunScriptCodeClientPrint(self, 4, `Perk Bonus activated: Increased movement and reload speed!`)2.2-1,0,-1",
				"OnTrigger#8" : "!activator,SpeakResponseConcept,TLK_PLAYER_SPELL_PICKUP_RARE,2.45,-1",
			},
		},
	},
	Vending_Blaster =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 50",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 1,
				targetname = "vm_blaster",
			},
		},
		[1] =
		{
			func_button =
			{
				origin = "0 -12 128",
				targetname = "vm_blasterbutton",
				parentname = "vm_blaster",
				damagefilter = "filter_blastermulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 3,
				sounds = 3,
				mins = "-24 -8 -44",
				maxs = "24 8 44",
				"OnPressed#1" : "perkbuff_blaster,trigger,0,-1,-1",
				"OnPressed#2" : "filter_blastermoney,TestActivator,0,-1,-1",
			},
		},
		[2] =
		{
			$filter_sendprop =
			{
				targetname = "filter_blastermoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 1500,
				$compare = "greater than or equal",
			},
		},
		[3] =
		{
			filter_multi =
			{
				targetname = "filter_blastermulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_blastermoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[4] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "vm_blastermsg",
				parentname = "vm_blaster",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-128 -128 0",
				maxs = "128 128 128",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to buy Head Rattle for $1500`)0-1,0,-1",
			},
		},
		[5] =
		{
			ambient_generic =
			{
				targetname = "vm_blastersfx",
				spawnflags = 48,
				health = 10,
				radius = 15000,
				pitch = 100,
				message = "shadows/perk_headrattle.mp3",
				parentname = "vm_blaster",
			},
		},
		[6] =
		{
			logic_relay =
			{
				targetname = "perkbuff_blaster",
				"OnTrigger#1" : "!activator,$RemoveCurrency,1500,-1,-1",
				"OnTrigger#2" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/perk_usesfx.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnTrigger#3" : "vm_blastersfx,PlaySound,0,2.2,-1",
				"OnTrigger#4" : "!activatorRunScriptCodeself.AddCustomAttribute(`explosive sniper shot`, 2, -1)2.2-1,0,-1",
				"OnTrigger#5" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `weapons/buffed_on.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })2.2-1",
				"OnTrigger#6" : "!activatorRunScriptCodeClientPrint(self, 4, `Perk Bonus activated: Explosive Headshot!`)2.2-1,0,-1",
				"OnTrigger#7" : "!activator,SpeakResponseConcept,TLK_PLAYER_SPELL_PICKUP_RARE,2.45,-1",
			},
		},
	},
	Vending_Doubletap =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 50",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "vm_dt",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				origin = "-24 -16 132",
				angles = "-15 0 0",
				disableshadows = 0,
				model = "models/weapons/c_models/c_shotgun/c_shotgun.mdl",
				modelscale = 2,
				solid = 0,
				parentname = "vm_dt",
			},
		},
		[2] =
		{
			func_button =
			{
				origin = "0 -12 128",
				targetname = "vm_dtbutton",
				parentname = "vm_dt",
				damagefilter = "filter_dtmulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 3,
				sounds = 3,
				mins = "-24 -8 -44",
				maxs = "24 8 44",
				"OnPressed#1" : "perkbuff_dt,trigger,0,-1,-1",
				"OnPressed#2" : "filter_dtmoney,TestActivator,0,-1,-1",
			},
		},
		[3] =
		{
			$filter_sendprop =
			{
				targetname = "filter_dtmoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 2000,
				$compare = "greater than or equal",
			},
		},
		[4] =
		{
			filter_multi =
			{
				targetname = "filter_dtmulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_dtmoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[5] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "vm_dtmsg",
				parentname = "vm_dt",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-128 -128 0",
				maxs = "128 128 128",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to buy Double Tap for $2000`)0-1,0,-1",
			},
		},
		[6] =
		{
			ambient_generic =
			{
				targetname = "vm_dtsfx",
				spawnflags = 48,
				health = 10,
				radius = 15000,
				pitch = 100,
				message = "shadows/perk_doubletap.mp3",
				parentname = "vm_dt",
			},
		},
		[7] =
		{
			logic_relay =
			{
				targetname = "perkbuff_dt",
				"OnTrigger#1" : "!activator,$RemoveCurrency,2000,-1,-1",
				"OnTrigger#2" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/perk_usesfx.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnTrigger#3" : "vm_dtsfx,PlaySound,0,2.2,-1",
				"OnTrigger#4" : "!activator,$AddPlayerAttribute,mult_item_meter_charge_rate|0.67,-1,-1",
				"OnTrigger#5" : "!activator,$AddPlayerAttribute,fire rate bonus|0.67,-1,-1",
				"OnTrigger#6" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `weapons/buffed_on.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })2.2-1",
				"OnTrigger#7" : "!activatorRunScriptCodeClientPrint(self, 4, `Perk Bonus activated: Increased fire rate!`)2.2-1,0,-1",
				"OnTrigger#8" : "!activator,SpeakResponseConcept,TLK_PLAYER_SPELL_PICKUP_RARE,2.45,-1",
			},
		},
	},
	Vending_Quickrevive =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 50",
				disableshadows = 0,
				model = "models/props_misc/vending_machine_01.mdl",
				solid = 6,
				skin = 0,
				targetname = "vm_quickrev",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				origin = "0 0 155",
				angles = "0 270 0",
				disableshadows = 0,
				model = "models/props_mvm/mvm_human_skull.mdl",
				modelscale = 2.5,
				solid = 0,
				parentname = "vm_quickrev",
			},
		},
		[2] =
		{
			func_button =
			{
				origin = "0 -12 128",
				targetname = "vm_quickrevbutton",
				parentname = "vm_quickrev",
				damagefilter = "filter_quickrevmulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 3,
				sounds = 3,
				mins = "-24 -8 -44",
				maxs = "24 8 44",
				"OnPressed#1" : "perkbuff_quickrev,trigger,0,-1,-1",
				"OnPressed#2" : "filter_quickrevmoney,TestActivator,0,-1,-1",
			},
		},
		[3] =
		{
			$filter_sendprop =
			{
				targetname = "filter_quickrevmoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 1500,
				$compare = "greater than or equal",
			},
		},
		[4] =
		{
			filter_multi =
			{
				targetname = "filter_quickrevmulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_quickrevmoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[5] =
		{
			math_counter =
			{
				targetname = "vm_quickrevcount",
				startvalue = 4,
				startdisabled = 0,
				min = 0,
				max = 3,
				"onhitmin#1" : "vm_quickrev*,Kill,,2,-1",
			},
		},
		[6] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "vm_quickrevmsg",
				parentname = "vm_quickrev",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-128 -128 0",
				maxs = "128 128 128",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to buy Ostarion's Reserve for $1500`)0-1,0,-1",
			},
		},
		[7] =
		{
			ambient_generic =
			{
				targetname = "vm_quickrevsfx",
				spawnflags = 48,
				health = 10,
				radius = 15000,
				pitch = 100,
				message = "shadows/perk_regalreserve.mp3",
				parentname = "vm_quickrev",
			},
		},
		[8] =
		{
			logic_relay =
			{
				targetname = "perkbuff_quickrev",
				"OnTrigger#1" : "!activator,$RemoveCurrency,1500,-1,-1",
				"OnTrigger#2" : "vm_quickrevcount,Subtract,1,,-1",
				"OnTrigger#3" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/perk_usesfx.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnTrigger#4" : "vm_quickrevsfx,PlaySound,0,2.2,-1",
				"OnTrigger#5" : "!activator,$AddCond,70,-1,-1",
				"OnTrigger#6" : "!activator,$AddCond,129,-1,-1",
				"OnTrigger#7" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `weapons/buffed_on.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })2.2-1",
				"OnTrigger#8" : "!activatorRunScriptCodeClientPrint(self, 4, `Perk Bonus activated: Survive one fatal attack!`)2.2-1,0,-1",
				"OnTrigger#9" : "!activator,SpeakResponseConcept,TLK_PLAYER_SPELL_PICKUP_RARE,2.45,-1",
			},
		},
	},
	Roundtimer =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "roundcounter",
				Action = "SetValue",
				Param = 0,
			},
		},
		[1] =
		{
			game_text =
			{
				targetname = "roundtext",
				color = "255 65 65",
				color2 = "0 0 0",
				fxtime = 2.3,
				holdtime = 36000,
				spawnflags = 1,
				effect = 2,
				channel = 1,
				x = 0.1,
				y = 0.05,
			},
		},
		[2] =
		{
			game_text =
			{
				targetname = "enemytext",
				color = "255 255 65",
				color2 = "0 0 0",
				holdtime = 36000,
				fxtime = 2.3,
				spawnflags = 1,
				channel = 2,
				effect = 2,
				x = 0.1,
				y = 0.1,
			},
		},
		[3] =
		{
			game_text =
			{
				targetname = "poweruptext",
				color = "255 255 255",
				color2 = "255 255 255",
				holdtime = 36000,
				spawnflags = 1,
				channel = 3,
				x = 0.27,
				y = 0.9,
			},
		},
		[4] =
		{
			math_counter =
			{
				targetname = "roundcounter",
				max = 255,
				outvalue = "roundformatRunScriptCodeself.KeyValueFromString(`case01`, ``)0-1",
				"OutValue#1" : "tf_objective_resourceRunScriptCodeNetProps.SetPropEntity(self, `m_nMannVsMachineWaveCount`, )0-1,0,-1",
				outvalue = "gameoverformatRunScriptCodeself.KeyValueFromString(`case01`, ``)0-1",
			},
		},
		[5] =
		{
			math_counter =
			{
				targetname = "enemycounter",
				startvalue = 0,
				min = 0,
				max = 26,
				outvalue = "enemyformatRunScriptCodeself.KeyValueFromString(`case01`, ``)0-1",
			},
		},
		[6] =
		{
			logic_case =
			{
				targetname = "enemyformat",
				case16 = "% active enemies",
				ondefault = "enemytextRunScriptCodeself.KeyValueFromString(`message`, ``)0-1",
				"ondefault#1" : "enemytext,display,0,0,-1",
			},
		},
		[7] =
		{
			logic_case =
			{
				targetname = "roundformat",
				case16 = "Round %",
			},
		},
		[8] =
		{
			logic_relay =
			{
				targetname = "realtimer",
				spawnflags = 2,
				"ontrigger#1" : "roundformat,$format,,0.01,-1",
				"OnUser2#1" : "gameoverformat,$format,,0.01,-1",
			},
		},
		[9] =
		{
			logic_relay =
			{
				targetname = "relay_enemycount_add",
				spawnflags = 2,
				"ontrigger#1" : "enemyformat,$format,,0.05,-1",
				"ontrigger#2" : "enemyformat,$format,,0.25,-1",
				"ontrigger#3" : "enemycounter,add,1,,-1",
			},
		},
		[10] =
		{
			logic_relay =
			{
				targetname = "relay_enemycount_subtract",
				spawnflags = 2,
				"ontrigger#1" : "enemyformat,$format,,0.05,-1",
				"ontrigger#2" : "enemyformat,$format,,0.25,-1",
				"ontrigger#3" : "enemycounter,subtract,1,,-1",
			},
		},
		[11] =
		{
			logic_relay =
			{
				targetname = "relay_enemycount_reset",
				spawnflags = 2,
				"ontrigger#1" : "enemyformat,$format,,0.01,-1",
				"ontrigger#2" : "enemycounter,setvalue,0,,-1",
			},
		},
	},
	DoublePointsSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "DoublePoints_spawner",
				EntityTemplate = "DoublePointsDrop",
			},
		},
	},
	DoublePointsDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/items/target_duck.mdl",
				solid = 0,
				modelscale = 0.8,
				origin = "0 0 10",
			},
		},
		[2] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "popscript,$ActivateDoublePoints,,-1,-1",
			},
		},
		[4] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
	},
	FireSaleSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "FireSale_spawner",
				EntityTemplate = "FireSaleDrop",
			},
		},
		[1] =
		{
			ambient_generic =
			{
				health = 7,
				message = "#*shadows/gallery_music.mp3",
				radius = 20,
				spawnflags = 49,
				targetname = "firesale_music",
			},
		},
	},
	FireSaleDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/props_doomsday/australium_container.mdl",
				solid = 0,
				modelscale = 1,
				origin = "0 0 24",
				angles = "0 0 45",
			},
		},
		[2] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "popscript,$ActivateFireSale,,-1,-1",
			},
		},
		[4] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
	},
	InstakillSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "Instakill_spawner",
				EntityTemplate = "InstakillDrop",
			},
		},
	},
	InstakillDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/props_mvm/mvm_human_skull.mdl",
				solid = 0,
				modelscale = 2.3,
				origin = "0 0 24",
				angles = "-15 0 0",
			},
		},
		[2] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "popscript,$ActivateInstakill,,-1,-1",
			},
		},
		[4] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
	},
	NukeSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "Nuke_spawner",
				EntityTemplate = "NukeDrop",
			},
		},
	},
	NukeDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				effect_name = "taunt_demo_nuke_shroomcloud",
				targetname = "powerup_particlenuke",
				start_active = 0,
				origin = "0 0 24",
			},
		},
		[2] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/props_trainyard/cart_bomb_separate.mdl",
				solid = 0,
				modelscale = 0.5,
				origin = "0 0 32",
				angles = "-45 0 0",
			},
		},
		[3] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[4] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "powerup_particlenuke,Start,,-1,-1",
				"OnStartTouchAll#3" : "powerup_particlenuke,Kill,,10,-1",
				"OnStartTouchAll#4" : "popscript,$ActivateNuke,,-1,-1",
				"OnStartTouchAll#5" : "hologram_nuke,Disable,,-1,-1",
				"OnStartTouchAll#6" : "hologram_nuke_snd,PlaySound,,-1,-1",
				"OnStartTouchAll#7" : "nuke_shake,StartShake,,-1,-1",
				"OnStartTouchAll#8" : "nuke_fade,Fade,,-1,-1",
				"OnStartTouchAll#9" : "powerup_timer,Enable,,-1,-1",
				"OnStartTouchAll#10" : "plate,skin,0,-1,-1",
				"OnStartTouchAll#11" : "!activator,RunScriptCode,self.AddCurrency(400),3,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[9] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
		[10] =
		{
			env_shake =
			{
				amplitude = 16,
				duration = 3,
				frequency = 40,
				radius = 48,
				spawnflags = 1,
				targetname = "nuke_shake",
			},
		},
		[11] =
		{
			env_fade =
			{
				targetname = "nuke_fade",
				duration = 1.3,
				spawnflags = 1,
				rendercolor = "255 255 255",
			},
		},
		[12] =
		{
			ambient_generic =
			{
				health = 10,
				message = ")misc/doomsday_missile_explosion.wav",
				radius = 20,
				pitch = 100,
				spawnflags = 49,
				targetname = "hologram_nuke_snd",
			},
		},
		[13] =
		{
			trigger_hurt =
			{
				damage = 4500,
				spawnflags = 1,
				mins = "-9999 -9999 -9999",
				maxs = "9999 9999 9999",
				startdisabled = 1,
				targetname = "hologram_nuke_hurt",
				filtername = "filter_notred",
				origin = "0 0 0",
			},
		},
		[14] =
		{
			filter_activator_tfteam =
			{
				targetname = "filter_notred",
				teamnum = 2,
				negated = 1,
			},
		},
	},
	MaxAmmoSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "MaxAmmo_spawner",
				EntityTemplate = "MaxAmmoDrop",
			},
		},
	},
	MaxAmmoDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/items/ammopack_large.mdl",
				solid = 0,
				modelscale = 1,
				origin = "0 0 10",
				angles = "15 0 0",
			},
		},
		[2] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "popscript,$ActivateMaxAmmo,,-1,-1",
			},
		},
		[4] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
	},
	BonusPointsSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "BonusPoints_spawner",
				EntityTemplate = "BonusPointsDrop",
			},
		},
	},
	BonusPointsDrop =
	{
		[0] =
		{
			info_particle_system =
			{
				effect_name = "spellbook_rainbow",
				targetname = "powerup_particle",
				parentname = "powerup_prop",
				start_active = 1,
				origin = "0 0 24",
			},
		},
		[1] =
		{
			prop_dynamic =
			{
				targetname = "powerup_prop",
				parentname = "powerup_rot",
				model = "models/items/currencypack_large.mdl",
				solid = 0,
				modelscale = 1,
				origin = "0 0 10",
				angles = "15 0 0",
			},
		},
		[2] =
		{
			func_rotating =
			{
				spawnflags = 65,
				maxspeed = 48,
				solidbsp = 0,
				rendermode = 10,
				targetname = "powerup_rot",
			},
		},
		[3] =
		{
			trigger_multiple =
			{
				targetname = "powerup_trigger",
				parentname = "powerup_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-12 -12 -12",
				maxs = "12 12 12",
				origin = "0 0 24",
				"OnStartTouchAll#1" : "powerup_rot,KillHierarchy,,-1,-1",
				"OnStartTouchAll#2" : "popscript,$ActivateBonusPoints,,-1,-1",
			},
		},
		[4] =
		{
			logic_timer =
			{
				targetname = "powerup_blinker",
				RefireTime = 0.5,
				spawnflags = 1,
				parentname = "powerup_prop",
				StartDisabled = 1,
				"OnTimerHigh#1" : "powerup_prop,Disable,,0,-1",
				"OnTimerLow#1" : "powerup_prop,Enable,,0,-1",
			},
		},
		[5] =
		{
			logic_timer =
			{
				RefireTime = 15,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,Enable,,-1,-1",
			},
		},
		[6] =
		{
			logic_timer =
			{
				RefireTime = 20,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.25,-1,-1",
			},
		},
		[7] =
		{
			logic_timer =
			{
				RefireTime = 25,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_blinker,RefireTime,0.1,-1,-1",
			},
		},
		[8] =
		{
			logic_timer =
			{
				RefireTime = 30,
				parentname = "powerup_prop",
				"OnTimer#1" : "powerup_rot,KillHierarchy,,-1,-1",
			},
		},
	},
	DumpsterSpawner =
	{
		NoFixup = 1,
		[0] =
		{
			env_entity_maker =
			{
				targetname = "dumpster_spawner1",
				EntityTemplate = "DumpsterBoxRewrite1",
			},
		},
		[1] =
		{
			env_entity_maker =
			{
				targetname = "dumpster_spawner2",
				EntityTemplate = "DumpsterBoxRewrite2",
				angles = "0 270 0",
			},
		},
		[2] =
		{
			env_entity_maker =
			{
				targetname = "dumpster_spawner3",
				EntityTemplate = "DumpsterBoxRewrite3",
			},
		},
		[3] =
		{
			env_entity_maker =
			{
				targetname = "dumpster_spawner4",
				EntityTemplate = "DumpsterBoxRewrite4",
				angles = "0 180 0",
			},
		},
		[4] =
		{
			env_entity_maker =
			{
				targetname = "dumpster_spawner5",
				EntityTemplate = "DumpsterBoxRewrite5",
			},
		},
		[5] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_1",
				origin = "447 -2322 8",
				angles = "0 0 0",
			},
		},
		[6] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_2",
				origin = "-399 -1380 -1",
				angles = "0 270 0",
			},
		},
		[7] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_3",
				origin = "986 1338 96",
				angles = "0 0 0",
			},
		},
		[8] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_4",
				origin = "-788 1016 -1",
				angles = "0 180 0",
			},
		},
		[9] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_5",
				origin = "-548 -2216 3",
				angles = "0 0 0",
			},
		},
		[10] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_out",
				origin = "-512 -25 -1008",
				angles = "0 0 0",
			},
		},
	},
	DumpsterBoxRewrite1 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop1",
				parentname = "dumpster_prop1",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff1",
				parentname = "dumpster_prop1",
			},
		},
		[2] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam1",
				parentname = "dumpster_prop1",
			},
		},
		[3] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				targetname = "dumpster_push1",
				mins = "-32 -66 -16",
				maxs = "12 66 64",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop1",
			},
		},
		[5] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_lid1",
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor1",
			},
		},
		[6] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor1",
				parentname = "dumpster_prop1",
				origin = "24 -24 59",
				distance = 90,
				speed = 160,
				wait = -1,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg1",
				parentname = "dumpster_prop1",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-72 -74 -64",
				maxs = "40 74 96",
			},
		},
		[8] =
		{
			light_dynamic =
			{
				origin = "0 0 20",
				targetname = "dumpster_light1",
				parentname = "dumpster_prop1",
				_light = "255 200 0 275",
				distance = 75,
				brightness = 10,
				spawnflags = 1,
			},
		},
		[9] =
		{
			info_particle_system =
			{
				origin = "0 0 0",
				effect_name = "utaunt_beams_yellow",
				targetname = "dumpster_particles1",
				parentname = "dumpster_prop1",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_weapon1",
				parentname = "dumpster_train1",
				model = "models/weapons/w_models/w_medigun.mdl",
				solid = 0,
			},
		},
		[11] =
		{
			path_track =
			{
				origin = "-4 0 20",
				targetname = "dumpster_track11",
				parentname = "dumpster_prop1",
				target = "dumpster_track21",
				"OnPass#1" : "dumpster_train1,Stop,,0,-1",
			},
		},
		[12] =
		{
			path_track =
			{
				origin = "-4 0 64",
				targetname = "dumpster_track21",
				parentname = "dumpster_prop1",
				target = "dumpster_track11",
				"OnPass#1" : "dumpster_train1,Stop,,0,-1",
			},
		},
		[13] =
		{
			func_tracktrain =
			{
				targetname = "dumpster_train1",
				parentname = "dumpster_prop1",
				target = "dumpster_track11",
				orientationtype = 0,
				velocitytype = 2,
				solid = 0,
				speed = 0,
				startspeed = 90,
				mins = "-4 -4 -4",
				maxs = "4 4 4",
				angles = "90 0 90",
				spawnflags = 8,
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 10,
				message = "shadows/mystery_jingle.mp3",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_jingle1",
				parentname = "dumpster_prop1",
			},
		},
		[15] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_appear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_appear1",
				parentname = "dumpster_prop1",
			},
		},
		[16] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_disappear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_disappear1",
				parentname = "dumpster_prop1",
			},
		},
	},
	DumpsterBoxRewrite2 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop2",
				parentname = "dumpster_prop2",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff2",
				parentname = "dumpster_prop2",
			},
		},
		[2] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam2",
				parentname = "dumpster_prop2",
			},
		},
		[3] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				targetname = "dumpster_push2",
				mins = "-32 -66 -16",
				maxs = "12 66 64",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop2",
			},
		},
		[5] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_lid2",
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor2",
			},
		},
		[6] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor2",
				parentname = "dumpster_prop2",
				origin = "24 -24 59",
				distance = 90,
				speed = 160,
				wait = -1,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg2",
				parentname = "dumpster_prop2",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-72 -74 -64",
				maxs = "40 74 96",
			},
		},
		[8] =
		{
			light_dynamic =
			{
				origin = "0 0 20",
				targetname = "dumpster_light2",
				parentname = "dumpster_prop2",
				_light = "255 200 0 275",
				distance = 75,
				brightness = 10,
				spawnflags = 1,
			},
		},
		[9] =
		{
			info_particle_system =
			{
				origin = "0 0 0",
				effect_name = "utaunt_beams_yellow",
				targetname = "dumpster_particles2",
				parentname = "dumpster_prop2",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_weapon2",
				parentname = "dumpster_train2",
				model = "models/weapons/w_models/w_medigun.mdl",
				solid = 0,
			},
		},
		[11] =
		{
			path_track =
			{
				origin = "-4 0 20",
				targetname = "dumpster_track12",
				parentname = "dumpster_prop2",
				target = "dumpster_track22",
				"OnPass#1" : "dumpster_train2,Stop,,0,-1",
			},
		},
		[12] =
		{
			path_track =
			{
				origin = "-4 0 64",
				targetname = "dumpster_track22",
				parentname = "dumpster_prop2",
				target = "dumpster_track12",
				"OnPass#1" : "dumpster_train2,Stop,,0,-1",
			},
		},
		[13] =
		{
			func_tracktrain =
			{
				targetname = "dumpster_train2",
				parentname = "dumpster_prop2",
				target = "dumpster_track12",
				orientationtype = 0,
				velocitytype = 2,
				solid = 0,
				speed = 0,
				startspeed = 90,
				mins = "-4 -4 -4",
				maxs = "4 4 4",
				angles = "90 0 90",
				spawnflags = 8,
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 10,
				message = "shadows/mystery_jingle.mp3",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_jingle2",
				parentname = "dumpster_prop2",
			},
		},
		[15] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_appear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_appear2",
				parentname = "dumpster_prop2",
			},
		},
		[16] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_disappear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_disappear2",
				parentname = "dumpster_prop2",
			},
		},
	},
	DumpsterBoxRewrite3 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop3",
				parentname = "dumpster_prop3",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff3",
				parentname = "dumpster_prop3",
			},
		},
		[2] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam3",
				parentname = "dumpster_prop3",
			},
		},
		[3] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				targetname = "dumpster_push3",
				mins = "-32 -66 -16",
				maxs = "12 66 64",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop3",
			},
		},
		[5] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_lid3",
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor3",
			},
		},
		[6] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor3",
				parentname = "dumpster_prop3",
				origin = "24 -24 59",
				distance = 90,
				speed = 160,
				wait = -1,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg3",
				parentname = "dumpster_prop3",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-72 -74 -64",
				maxs = "40 74 96",
			},
		},
		[8] =
		{
			light_dynamic =
			{
				origin = "0 0 20",
				targetname = "dumpster_light3",
				parentname = "dumpster_prop3",
				_light = "255 200 0 275",
				distance = 75,
				brightness = 10,
				spawnflags = 1,
			},
		},
		[9] =
		{
			info_particle_system =
			{
				origin = "0 0 0",
				effect_name = "utaunt_beams_yellow",
				targetname = "dumpster_particles3",
				parentname = "dumpster_prop3",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_weapon3",
				parentname = "dumpster_train3",
				model = "models/weapons/w_models/w_medigun.mdl",
				solid = 0,
			},
		},
		[11] =
		{
			path_track =
			{
				origin = "-4 0 20",
				targetname = "dumpster_track13",
				parentname = "dumpster_prop3",
				target = "dumpster_track23",
				"OnPass#1" : "dumpster_train3,Stop,,0,-1",
			},
		},
		[12] =
		{
			path_track =
			{
				origin = "-4 0 64",
				targetname = "dumpster_track23",
				parentname = "dumpster_prop3",
				target = "dumpster_track13",
				"OnPass#1" : "dumpster_train3,Stop,,0,-1",
			},
		},
		[13] =
		{
			func_tracktrain =
			{
				targetname = "dumpster_train3",
				parentname = "dumpster_prop3",
				target = "dumpster_track13",
				orientationtype = 0,
				velocitytype = 2,
				solid = 0,
				speed = 0,
				startspeed = 90,
				mins = "-4 -4 -4",
				maxs = "4 4 4",
				angles = "90 0 90",
				spawnflags = 8,
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 10,
				message = "shadows/mystery_jingle.mp3",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_jingle3",
				parentname = "dumpster_prop3",
			},
		},
		[15] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_appear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_appear3",
				parentname = "dumpster_prop3",
			},
		},
		[16] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_disappear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_disappear3",
				parentname = "dumpster_prop3",
			},
		},
	},
	DumpsterBoxRewrite4 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop4",
				parentname = "dumpster_prop4",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff4",
				parentname = "dumpster_prop4",
			},
		},
		[2] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam4",
				parentname = "dumpster_prop4",
			},
		},
		[3] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				targetname = "dumpster_push4",
				mins = "-32 -66 -16",
				maxs = "12 66 64",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop4",
			},
		},
		[5] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_lid4",
				angles = "0 0 0",
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor4",
			},
		},
		[6] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor4",
				parentname = "dumpster_prop4",
				origin = "-24 -24 59",
				angles = "0 0 0",
				distance = 90,
				speed = 160,
				wait = -1,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg4",
				parentname = "dumpster_prop4",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-72 -74 -64",
				maxs = "40 74 96",
			},
		},
		[8] =
		{
			light_dynamic =
			{
				origin = "0 0 20",
				targetname = "dumpster_light4",
				parentname = "dumpster_prop4",
				_light = "255 200 0 275",
				distance = 75,
				brightness = 10,
				spawnflags = 1,
			},
		},
		[9] =
		{
			info_particle_system =
			{
				origin = "0 0 0",
				effect_name = "utaunt_beams_yellow",
				targetname = "dumpster_particles4",
				parentname = "dumpster_prop4",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_weapon4",
				parentname = "dumpster_train4",
				model = "models/weapons/w_models/w_medigun.mdl",
				solid = 0,
			},
		},
		[11] =
		{
			path_track =
			{
				origin = "-4 0 20",
				targetname = "dumpster_track14",
				parentname = "dumpster_prop4",
				target = "dumpster_track24",
				"OnPass#1" : "dumpster_train4,Stop,,0,-1",
			},
		},
		[12] =
		{
			path_track =
			{
				origin = "-4 0 64",
				targetname = "dumpster_track24",
				parentname = "dumpster_prop4",
				target = "dumpster_track14",
				"OnPass#1" : "dumpster_train4,Stop,,0,-1",
			},
		},
		[13] =
		{
			func_tracktrain =
			{
				targetname = "dumpster_train4",
				parentname = "dumpster_prop4",
				target = "dumpster_track14",
				orientationtype = 0,
				velocitytype = 2,
				solid = 0,
				speed = 0,
				startspeed = 90,
				mins = "-4 -4 -4",
				maxs = "4 4 4",
				angles = "90 0 90",
				spawnflags = 8,
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 10,
				message = "shadows/mystery_jingle.mp3",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_jingle4",
				parentname = "dumpster_prop4",
			},
		},
		[15] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_appear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_appear4",
				parentname = "dumpster_prop4",
			},
		},
		[16] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_disappear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_disappear4",
				parentname = "dumpster_prop4",
			},
		},
	},
	DumpsterBoxRewrite5 =
	{
		NoFixup = 1,
		[0] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop5",
				parentname = "dumpster_prop5",
			},
		},
		[1] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff5",
				parentname = "dumpster_prop5",
			},
		},
		[2] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam5",
				parentname = "dumpster_prop5",
			},
		},
		[3] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 180 0",
				spawnflags = 1,
				speed = 512,
				targetname = "dumpster_push5",
				mins = "-32 -66 -16",
				maxs = "12 66 64",
			},
		},
		[4] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop5",
			},
		},
		[5] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_lid5",
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor5",
			},
		},
		[6] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor5",
				parentname = "dumpster_prop5",
				origin = "24 -24 59",
				distance = 90,
				speed = 160,
				wait = -1,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[7] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg5",
				parentname = "dumpster_prop5",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-72 -74 -64",
				maxs = "40 74 96",
			},
		},
		[8] =
		{
			light_dynamic =
			{
				origin = "0 0 20",
				targetname = "dumpster_light5",
				parentname = "dumpster_prop5",
				_light = "255 200 0 275",
				distance = 75,
				brightness = 10,
				spawnflags = 1,
			},
		},
		[9] =
		{
			info_particle_system =
			{
				origin = "0 0 0",
				effect_name = "utaunt_beams_yellow",
				targetname = "dumpster_particles5",
				parentname = "dumpster_prop5",
			},
		},
		[10] =
		{
			prop_dynamic =
			{
				targetname = "dumpster_weapon5",
				parentname = "dumpster_train5",
				model = "models/weapons/w_models/w_medigun.mdl",
				solid = 0,
			},
		},
		[11] =
		{
			path_track =
			{
				origin = "-4 0 20",
				targetname = "dumpster_track15",
				parentname = "dumpster_prop5",
				target = "dumpster_track25",
				"OnPass#1" : "dumpster_train5,Stop,,0,-1",
			},
		},
		[12] =
		{
			path_track =
			{
				origin = "-4 0 64",
				targetname = "dumpster_track25",
				parentname = "dumpster_prop5",
				target = "dumpster_track15",
				"OnPass#1" : "dumpster_train5,Stop,,0,-1",
			},
		},
		[13] =
		{
			func_tracktrain =
			{
				targetname = "dumpster_train5",
				parentname = "dumpster_prop5",
				target = "dumpster_track15",
				orientationtype = 0,
				velocitytype = 2,
				solid = 0,
				speed = 0,
				startspeed = 90,
				mins = "-4 -4 -4",
				maxs = "4 4 4",
				angles = "90 0 90",
				spawnflags = 8,
			},
		},
		[14] =
		{
			ambient_generic =
			{
				health = 10,
				message = "shadows/mystery_jingle.mp3",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_jingle5",
				parentname = "dumpster_prop5",
			},
		},
		[15] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_appear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_appear5",
				parentname = "dumpster_prop5",
			},
		},
		[16] =
		{
			ambient_generic =
			{
				health = 10,
				message = "misc/halloween/merasmus_disappear.wav",
				radius = 11000,
				spawnflags = 48,
				targetname = "dumpster_disappear5",
				parentname = "dumpster_prop5",
			},
		},
	},
	DumpsterBox =
	{
		NoFixup = 1,
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "dumpster_warp_roulette",
				Action = "PickRandomShuffle",
			},
		},
		[1] =
		{
			$filter_sendprop =
			{
				targetname = "filter_dumpstermoney",
				$name = "m_nCurrency",
				negated = 0,
				$value = 950,
				$compare = "greater than or equal",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[2] =
		{
			filter_multi =
			{
				targetname = "filter_dumpstermulti",
				filtertype = 0,
				negated = 0,
				filter01 = "filter_dumpstermoney",
				filter02 = "filter_melee",
				"OnFail#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `buttons/button8.wav`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
			},
		},
		[3] =
		{
			filter_damage_type =
			{
				targetname = "filter_melee",
				negated = 0,
				damagetype = 134221952,
			},
		},
		[4] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "eyeboss_tp_vortex",
				targetname = "dumpster_warp_eff",
				parentname = "dumpster_prop",
			},
		},
		[5] =
		{
			info_particle_system =
			{
				origin = "0 0 24",
				effect_name = "teleporter_mvm_bot_persist",
				targetname = "dumpster_warp_beam",
				parentname = "dumpster_prop",
			},
		},
		[6] =
		{
			trigger_multiple =
			{
				origin = "0 0 50",
				targetname = "dumpster_msg",
				parentname = "dumpster_prop",
				filtername = "filter_redteam",
				spawnflags = 1,
				mins = "-64 -64 -64",
				maxs = "96 96 96",
				"OnStartTouchAll#1" : "!activatorRunScriptCodeClientPrint(self, 4, `Hold Action key to receive a weapon for $950`)0-1,0,-1",
			},
		},
		[7] =
		{
			trigger_push =
			{
				origin = "0 0 0",
				pushdir = "0 0 0",
				spawnflags = 1,
				speed = 512,
				StartDisabled = 0,
				targetname = "dumpster_push",
				mins = "-12 -64 -16",
				maxs = "12 64 16",
			},
		},
		[8] =
		{
			logic_relay =
			{
				targetname = "dumpster_dud",
				"OnTrigger#1" : "!activator,$AddCurrency,950,-1,-1",
				OnTrigger = "player,$PlaySoundToSelf,misc/happy_birthday_tf_10.wav,,0,-1",
				"OnTrigger#2" : "dumpsterbutton,Lock,,0,-1",
				"OnTrigger#3" : "dumpster_dudprop,Enable,,0,-1",
				"OnTrigger#4" : "tf_gamerules,PlayVORed,shadows/powerup_dud_03.mp3,1,-1",
				"OnTrigger#5" : "dumpster_warp_eff,Start,,3,-1",
				"OnTrigger#6" : "dumpster_warp_beam,Stop,,3,-1",
				"OnTrigger#7" : "tf_gamerules,PlayVORed,misc/halloween/merasmus_disappear.wav,3,-1",
				"OnTrigger#8" : "dumpster_tele_out,Teleport,,4,-1",
				"OnTrigger#9" : "dumpster_warp_eff,Stop,,4.2,-1",
				"OnTrigger#10" : "dumpster_dudprop,Disable,,8,-1",
				"OnTrigger#11" : "dumpster_prop,AddOutput,solid 0,9,-1",
				"OnTrigger#12" : "dumpster_push,Enable,,24,-1",
				"OnTrigger#13" : "dumpster_warp_roulette,PickRandomShuffle,,25,-1",
				"OnTrigger#14" : "dumpster_warp_eff,Start,,25,-1",
				"OnTrigger#15" : "dumpsterbutton,Unlock,,26,-1",
				"OnTrigger#16" : "dumpster_push,Disable,,26,-1",
				"OnTrigger#17" : "dumpster_prop,AddOutput,solid 6,26,-1",
				"OnTrigger#18" : "tf_gamerules,PlayVORed,misc/halloween/merasmus_appear.wav,26,-1",
				"OnTrigger#19" : "dumpster_warp_eff,Stop,,27.2,-1",
			},
		},
		[9] =
		{
			logic_case =
			{
				targetname = "dumpster_warp_roulette",
				"OnCase01#1" : "dumpster_tele_1,Teleport,,-1,-1",
				"OnCase01#2" : "dumpster_warp_beam,Start,,-1,-1",
				"OnCase02#1" : "dumpster_tele_2,Teleport,,-1,-1",
				"OnCase02#2" : "dumpster_warp_beam,Start,,-1,-1",
				"OnCase03#1" : "dumpster_tele_3,Teleport,,-1,-1",
				"OnCase03#2" : "dumpster_warp_beam,Start,,-1,-1",
				"OnCase04#1" : "dumpster_tele_4,Teleport,,-1,-1",
				"OnCase04#2" : "dumpster_warp_beam,Start,,-1,-1",
				"OnCase05#1" : "dumpster_tele_5,Teleport,,-1,-1",
				"OnCase05#2" : "dumpster_warp_beam,Start,,-1,-1",
			},
		},
		[10] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_out",
				target = "dumpster_prop",
				origin = "-512 -25 -1008",
				angles = "0 0 0",
			},
		},
		[11] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_1",
				target = "dumpster_prop",
				origin = "447 -2322 8",
				angles = "0 0 0",
			},
		},
		[12] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_2",
				target = "dumpster_prop",
				origin = "-399 -1380 -1",
				angles = "0 270 0",
			},
		},
		[13] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_3",
				target = "dumpster_prop",
				origin = "986 1338 96",
				angles = "0 0 0",
			},
		},
		[14] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_4",
				target = "dumpster_prop",
				origin = "-788 1016 -1",
				angles = "0 180 0",
			},
		},
		[15] =
		{
			point_teleport =
			{
				targetname = "dumpster_tele_5",
				target = "dumpster_prop",
				origin = "-548 -2216 3",
				angles = "0 0 0",
			},
		},
		[16] =
		{
			logic_case =
			{
				targetname = "dumpster_case",
				Case01 = 1,
				Case02 = 2,
				Case03 = 3,
				Case04 = 4,
				Case05 = 5,
				Case06 = 6,
				Case07 = 7,
				Case08 = 8,
				Case09 = 9,
				"OnCase01#1" : "dumpster_picker_scout,PickRandom,,2.5,-1",
				"OnCase02#1" : "dumpster_picker_sniper,PickRandom,,2.5,-1",
				"OnCase03#1" : "dumpster_picker_soldier,PickRandom,,2.5,-1",
				"OnCase04#1" : "dumpster_picker_demo,PickRandom,,2.5,-1",
				"OnCase05#1" : "dumpster_picker_medic,PickRandom,,2.5,-1",
				"OnCase06#1" : "dumpster_picker_heavy,PickRandom,,2.5,-1",
				"OnCase07#1" : "dumpster_picker_pyro,PickRandom,,2.5,-1",
				"OnCase08#1" : "dumpster_picker_spy,PickRandom,,2.5,-1",
				"OnCase09#1" : "dumpster_picker_engie,PickRandom,,2.5,-1",
			},
		},
		[17] =
		{
			prop_dynamic =
			{
				origin = "0 0 104",
				angles = "90 0 180",
				disableshadows = 0,
				model = "models/workshop/player/items/all_class/mvm_memes_player/mvm_memes_player_heavy.mdl",
				solid = 0,
				startdisabled = 1,
				modelscale = 3,
				targetname = "dumpster_dudprop",
				parentname = "dumpster_prop",
			},
		},
		[18] =
		{
			training_annotation =
			{
				targetname = "dumpster_hint",
				display_text = "Follow the beam of light to find the Weapons Dumpster!",
				lifetime = 5,
				origin = "0 0 256",
			},
		},
		[19] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_body.mdl",
				solid = 6,
				skin = 2,
				targetname = "dumpster_prop",
				lightingorigin = "bombpath_arrows_void",
			},
		},
		[20] =
		{
			light_dynamic =
			{
				_light = "255 249 234 275",
				distance = 512,
				brightness = 1,
				origin = "0 0 36",
				parentname = "dumpster_prop",
			},
		},
		[21] =
		{
			prop_dynamic =
			{
				origin = "0 0 0",
				disableshadows = 0,
				model = "models/props_construction/dumpster_lid.mdl",
				solid = 0,
				skin = 2,
				parentname = "dumpster_rotdoor",
				lightingorigin = "bombpath_arrows_void",
			},
		},
		[22] =
		{
			func_door_rotating =
			{
				targetname = "dumpster_rotdoor",
				parentname = "dumpster_prop",
				origin = "28 -24 60",
				distance = 90,
				speed = 160,
				wait = 5,
				disableshadows = 1,
				forceclosed = 1,
				spawnflags = 128,
				noise1 = "shadows/mystery_open.mp3",
				startclosesound = "misc/null.wav",
				closesound = "doors/door_metal_medium_close1.wav",
				mins = "-2 -2 -2",
				maxs = "2 2 2",
			},
		},
		[23] =
		{
			func_button =
			{
				origin = "-32 -0 24",
				targetname = "dumpsterbutton",
				parentname = "dumpster_prop",
				damagefilter = "filter_dumpstermulti",
				rendermode = 10,
				movedir = "0 180 0",
				spawnflags = 513,
				speed = 5,
				wait = 3,
				sounds = 3,
				mins = "-4 -44 -20",
				maxs = "4 44 20",
				"OnPressed#1" : "!activatorRunScriptCodeEmitSoundEx({sound_name = `shadows/mystery_noise.mp3`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 })0-1",
				"OnPressed#2" : "!activator,$RemoveCurrency,950,-1,-1",
				"OnPressed#3" : "dumpster_rotdoor,Open,,0,-1",
				"OnPressed#4" : "dumpster_case,InValue,$$=!activator.m_iClass,,-1",
				"OnPressed#5" : "dumpster_rotdoor,Close,,3.4,-1",
			},
		},
		[24] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_scout",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,The Shortstop,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shortstop!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,The Shortstop,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shortstop!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,The Force-a-Nature,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Force-a-Nature!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,The Force-a-Nature,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Force-a-Nature!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase12#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase12#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase12#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase12#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase13#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase13#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase13#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase13#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase14#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[25] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_sniper",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,The Crusader's Crossbow,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Crusader's Crossbow!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,The Crusader's Crossbow,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Crusader's Crossbow!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase12#1" : "!activator,$AwardAndGiveExtraItem,Beam Rifle,-1,-1",
				"OnCase12#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase12#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase12#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Beam Rifle!`)0-1,0,-1",
				"OnCase13#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase13#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase13#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase13#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase14#1" : "!activator,$AwardAndGiveExtraItem,The Cleaner's Carbine,-1,-1",
				"OnCase14#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase14#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase14#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Cleaner's Carbine!`)0-1,0,-1",
				"OnCase15#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[26] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_soldier",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_ROCKETLAUNCHER,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Rocket Launcher!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_ROCKETLAUNCHER,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Rocket Launcher!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,Tactigatling,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Tactigatling!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,Beam Rifle,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Beam Rifle!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,The Cleaner's Carbine,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Cleaner's Carbine!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Cleaner's Carbine,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Cleaner's Carbine!`)0-1,0,-1",
				"OnCase12#1" : "tgun_check,Test,,-1,-1",
				"OnCase13#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[27] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_demo",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PIPEBOMBLAUNCHER,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Stickybomb Launcher!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,Tactigatling,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Tactigatling!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,Beam Rifle,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Beam Rifle!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase12#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[28] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_medic",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,Primary SMG,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,Primary SMG,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,The Crusader's Crossbow,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Crusader's Crossbow!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,The Crusader's Crossbow,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Crusader's Crossbow!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Black Box,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Black Box!`)0-1,0,-1",
				"OnCase12#1" : "!activator,$AwardAndGiveExtraItem,Das Maschinenpistole,-1,-1",
				"OnCase12#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase12#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase12#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: Das Maschinenpistole!`)0-1,0,-1",
				"OnCase13#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[29] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_heavy",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_MINIGUN,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Minigun!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_MINIGUN,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Minigun!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,Beam Rifle,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Beam Rifle!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,Tactigatling,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Tactigatling!`)0-1,0,-1",
				"OnCase12#1" : "tgun_check,Test,,-1,-1",
				"OnCase13#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[30] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_pyro",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_FLAMETHROWER,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Flamethrower!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,Double Barrel,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Double Barrel!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,The Dragon's Fury,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Dragon's Fury!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,The Dragon's Fury,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Dragon's Fury!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_MINIGUN,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Minigun!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_MINIGUN,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Minigun!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase12#1" : "!activator,$AwardAndGiveExtraItem,Tactigatling,-1,-1",
				"OnCase12#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase12#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase12#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Tactigatling!`)0-1,0,-1",
				"OnCase13#1" : "tgun_check,Test,,-1,-1",
				"OnCase14#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[31] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_spy",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PISTOL,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Pistol!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_PISTOL,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Pistol!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,Primary Ambassador,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ambassador!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,Primary Ambassador,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ambassador!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,Big Iron,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Big Iron!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,Big Iron,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Big Iron!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PYRO,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase11#1" : "!activator,$AwardAndGiveExtraItem,The Winger,-1,-1",
				"OnCase11#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase11#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase11#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Winger!`)0-1,0,-1",
				"OnCase12#1" : "!activator,$AwardAndGiveExtraItem,The Winger,-1,-1",
				"OnCase12#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase12#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase12#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Winger!`)0-1,0,-1",
				"OnCase13#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase13#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase13#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase13#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase14#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
		[32] =
		{
			logic_case =
			{
				targetname = "dumpster_picker_engie",
				"OnCase01#1" : "!activator,$AwardAndGiveExtraItem,The B.M.M.H,-1,-1",
				"OnCase01#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase01#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase01#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The B.M.M.H!`)0-1,0,-1",
				"OnCase02#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase02#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase02#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase02#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase03#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SMG,-1,-1",
				"OnCase03#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase03#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase03#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The SMG!`)0-1,0,-1",
				"OnCase04#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PRIMARY,-1,-1",
				"OnCase04#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase04#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase04#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase05#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SCATTERGUN,-1,-1",
				"OnCase05#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase05#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase05#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Scattergun!`)0-1,0,-1",
				"OnCase06#1" : "!activator,$AwardAndGiveExtraItem,TF_WEAPON_SHOTGUN_PRIMARY,-1,-1",
				"OnCase06#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase06#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase06#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Shotgun!`)0-1,0,-1",
				"OnCase07#1" : "!activator,$AwardAndGiveExtraItem,The Nostromo Napalmer,-1,-1",
				"OnCase07#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase07#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase07#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Nostromo Napalmer!`)0-1,0,-1",
				"OnCase08#1" : "!activator,$AwardAndGiveExtraItem,The Nostromo Napalmer,-1,-1",
				"OnCase08#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase08#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_COMMON,0.6,-1",
				"OnCase08#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Nostromo Napalmer!`)0-1,0,-1",
				"OnCase09#1" : "!activator,$AwardAndGiveExtraItem,The Ray Gun,-1,-1",
				"OnCase09#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase09#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase09#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Ray Gun!`)0-1,0,-1",
				"OnCase10#1" : "!activator,$AwardAndGiveExtraItem,The Punch Packer,-1,-1",
				"OnCase10#2" : "!activator,$PlaySoundToSelf,items/gunpickup2.wav,-1,-1",
				"OnCase10#3" : "!activator,SpeakResponseConcept,TLK_MVM_LOOT_RARE,0.6,-1",
				"OnCase10#4" : "!activatorRunScriptCodeClientPrint(self, 4, `You've received: The Punch Packer!`)0-1,0,-1",
				"OnCase11#1" : "dumpster_dud,Trigger,-1,0,-1",
			},
		},
	},
	TankTeleport =
	{
		NoFixup = 1,
		[0] =
		{
			trigger_teleport =
			{
				targetname = "tank_warper",
				spawnflags = 1,
				target = "tank_spawnroulette",
				filtername = "filter_tank",
				mins = "-9999 -9999 -9999",
				maxs = "9999 9999 9999",
			},
		},
		[1] =
		{
			trigger_multiple =
			{
				targetname = "tank_spawnroulette",
				spawnflags = 1,
				filtername = "filter_tank",
				origin = "-2168 40 13604",
				mins = "-24 -24 -36",
				maxs = "24 24 36",
				"OnStartTouchAll#1" : "tank_spawn_picker,PickRandomShuffle,,-1,-1",
			},
		},
		[2] =
		{
			trigger_bot_tag =
			{
				targetname = "tank_spawnroulette",
				spawnflags = 1,
				filtername = "filter_tank",
				tags = "swooce",
				add = 0,
				origin = "-2168 40 13604",
				mins = "-128 -128 -128",
				maxs = "128 128 128",
			},
		},
		[3] =
		{
			filter_tf_bot_has_tag =
			{
				targetname = "filter_tank",
				require_all_tags = 1,
				tags = "swooce",
				Negated = "Allow entities that match criteria",
			},
		},
		[4] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_01",
				target = "!activator",
				origin = "-2048 -2432 24",
			},
		},
		[5] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_01_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-2048 -2432 24",
			},
		},
		[6] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_01_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-2048 -2432 24",
			},
		},
		[7] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_02",
				target = "!activator",
				origin = "-352 -3064 8",
			},
		},
		[8] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_02_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-352 -3064 8",
			},
		},
		[9] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_02_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-352 -3064 8",
			},
		},
		[10] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_03",
				target = "!activator",
				origin = "1376 -945 24",
			},
		},
		[11] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_03_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "1376 -945 24",
			},
		},
		[12] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_03_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "1376 -945 24",
			},
		},
		[13] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_04",
				target = "!activator",
				origin = "1376 1120 16",
			},
		},
		[14] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_04_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "1376 1120 16",
			},
		},
		[15] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_04_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "1376 1120 16",
			},
		},
		[16] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_05",
				target = "!activator",
				origin = "-8 1556 224",
			},
		},
		[17] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_05_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-8 1556 224",
			},
		},
		[18] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_05_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-8 1556 224",
			},
		},
		[19] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_06",
				target = "!activator",
				origin = "-792 2280 16",
			},
		},
		[20] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_06_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-792 2280 16",
			},
		},
		[21] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_06_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-792 2280 16",
			},
		},
		[22] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_07",
				target = "!activator",
				origin = "-3136 1272 24",
			},
		},
		[23] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_07_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-3136 1272 24",
			},
		},
		[24] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_07_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-3136 1272 24",
			},
		},
		[25] =
		{
			point_teleport =
			{
				targetname = "tank_spawn_08",
				target = "!activator",
				origin = "-2296 -264 24",
			},
		},
		[26] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_08_eff1",
				effect_name = "utaunt_electricity_cloud_parent_WB",
				origin = "-2296 -264 24",
			},
		},
		[27] =
		{
			info_particle_system =
			{
				targetname = "tank_spawn_08_eff2",
				effect_name = "utaunt_lightning_bolt",
				origin = "-2296 -264 24",
			},
		},
		[28] =
		{
			logic_case =
			{
				targetname = "tank_spawn_picker",
				"OnCase01#1" : "tank_spawn_01_eff1,Start,,-1,-1",
				"OnCase01#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase01#3" : "tank_spawn_01_eff2,Start,,1.75,-1",
				"OnCase01#4" : "tank_spawn_01,Teleport,,1.75,-1",
				"OnCase01#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase01#6" : "tank_spawn_01_eff1,Stop,,1.8,-1",
				"OnCase01#7" : "tank_spawn_01_eff2,Stop,,2,-1",
				"OnCase02#1" : "tank_spawn_02_eff1,Start,,-1,-1",
				"OnCase02#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase02#3" : "tank_spawn_02_eff2,Start,,1.75,-1",
				"OnCase02#4" : "tank_spawn_02,Teleport,,1.75,-1",
				"OnCase02#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase02#6" : "tank_spawn_02_eff1,Stop,,1.8,-1",
				"OnCase02#7" : "tank_spawn_02_eff2,Stop,,2,-1",
				"OnCase03#1" : "tank_spawn_03_eff1,Start,,-1,-1",
				"OnCase03#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase03#3" : "tank_spawn_03_eff2,Start,,1.75,-1",
				"OnCase03#4" : "tank_spawn_03,Teleport,,1.75,-1",
				"OnCase03#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase03#6" : "tank_spawn_03_eff1,Stop,,1.8,-1",
				"OnCase03#7" : "tank_spawn_03_eff2,Stop,,2,-1",
				"OnCase04#1" : "tank_spawn_04_eff1,Start,,-1,-1",
				"OnCase04#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase04#3" : "tank_spawn_04_eff2,Start,,1.75,-1",
				"OnCase04#4" : "tank_spawn_04,Teleport,,1.75,-1",
				"OnCase04#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase04#6" : "tank_spawn_04_eff1,Stop,,1.8,-1",
				"OnCase04#7" : "tank_spawn_04_eff2,Stop,,2,-1",
				"OnCase05#1" : "tank_spawn_05_eff1,Start,,-1,-1",
				"OnCase05#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase05#3" : "tank_spawn_05_eff2,Start,,1.75,-1",
				"OnCase05#4" : "tank_spawn_05,Teleport,,1.75,-1",
				"OnCase05#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase05#6" : "tank_spawn_05_eff1,Stop,,1.8,-1",
				"OnCase05#7" : "tank_spawn_05_eff2,Stop,,2,-1",
				"OnCase06#1" : "tank_spawn_06_eff1,Start,,-1,-1",
				"OnCase06#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase06#3" : "tank_spawn_06_eff2,Start,,1.75,-1",
				"OnCase06#4" : "tank_spawn_06,Teleport,,1.75,-1",
				"OnCase06#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase06#6" : "tank_spawn_06_eff1,Stop,,1.8,-1",
				"OnCase06#7" : "tank_spawn_06_eff2,Stop,,2,-1",
				"OnCase07#1" : "tank_spawn_07_eff1,Start,,-1,-1",
				"OnCase07#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase07#3" : "tank_spawn_07_eff2,Start,,1.75,-1",
				"OnCase07#4" : "tank_spawn_07,Teleport,,1.75,-1",
				"OnCase07#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase07#6" : "tank_spawn_07_eff1,Stop,,1.8,-1",
				"OnCase07#7" : "tank_spawn_07_eff2,Stop,,2,-1",
				"OnCase08#1" : "tank_spawn_08_eff1,Start,,-1,-1",
				"OnCase08#2" : "tf_gamerules,PlayVORed,misc/halloween_eyeball/book_spawn.wav,,-1",
				"OnCase08#3" : "tank_spawn_08_eff2,Start,,1.75,-1",
				"OnCase08#4" : "tank_spawn_08,Teleport,,1.75,-1",
				"OnCase08#5" : "tf_gamerules,PlayVORed,ambient/halloween/thunder_04.wav,1.75,-1",
				"OnCase08#6" : "tank_spawn_08_eff1,Stop,,1.8,-1",
				"OnCase08#7" : "tank_spawn_08_eff2,Stop,,2,-1",
			},
		},
	},
	Camera_Crew_Death =
	{
		NoFixup = 1,
		[0] =
		{
			point_viewcontrol =
			{
				angles = "14 206 0",
				origin = "2948 924 518",
				acceleration = 0,
				deceleration = 0,
				spawnflags = 0,
				targetname = "camera_gameover_1",
				parentname = "camera_spin",
				wait = 5,
				interpolatepositiontoplayer = 0,
				speed = 0,
			},
		},
		[1] =
		{
			func_rotating =
			{
				spawnflags = 64,
				maxspeed = 1,
				solidbsp = 0,
				rendermode = 10,
				targetname = "camera_spin",
				origin = "2948 924 518",
			},
		},
		[2] =
		{
			game_text =
			{
				targetname = "gameovertext",
				color = "222 222 222",
				color2 = "240 110 0",
				fxtime = 8,
				holdtime = 30,
				spawnflags = 1,
				channel = 4,
				effect = 2,
				x = 0.4,
				y = 0.37,
			},
		},
		[3] =
		{
			logic_case =
			{
				targetname = "gameoverformat",
				case16 = "You survived % waves",
				ondefault = "gameovertextRunScriptCodeself.KeyValueFromString(`message`, ``)0-1",
				"ondefault#1" : "gameovertext,display,0,0,-1",
			},
		},
		[4] =
		{
			point_viewcontrol =
			{
				angles = "23 298 0",
				origin = "-2349 1008 479",
				acceleration = 0,
				deceleration = 0,
				spawnflags = 0,
				targetname = "camera_gameover_2",
				wait = 5,
				parentname = "camera_spin_2",
				interpolatepositiontoplayer = 0,
				speed = 0,
			},
		},
		[5] =
		{
			func_rotating =
			{
				spawnflags = 66,
				maxspeed = 1,
				solidbsp = 0,
				rendermode = 10,
				targetname = "camera_spin_2",
				origin = "-2349 1008 479",
			},
		},
		[6] =
		{
			env_fade =
			{
				targetname = "fade_out",
				duration = 2,
				holdtime = 0.5,
				rendercolor = "0 0 0",
			},
		},
		[7] =
		{
			env_fade =
			{
				targetname = "fade_in",
				duration = 2,
				holdtime = 0.5,
				spawnflags = 1,
				rendercolor = "0 0 0",
			},
		},
		[8] =
		{
			point_populator_interface =
			{
				targetname = "populator",
			},
		},
		[9] =
		{
			logic_relay =
			{
				targetname = "gameover",
				startdisabled = 1,
				"OnTrigger#1" : "youwin,Disable,,1.5,-1",
				"OnTrigger#2" : "LMA,Disable,,3,-1",
				"OnTrigger#3" : "populator,PauseBotSpawning,,3,-1",
				"OnTrigger#4" : "player,$PlaySequence,victory,3,-1",
				"OnTrigger#5" : "bossstage_start,CancelPending,,3,-1",
				"OnTrigger#6" : "bossstage_start_tread,CancelPending,,3,-1",
				"OnTrigger#7" : "stage_clear_finale,CancelPending,,3,-1",
				"OnTrigger#8" : "stage_clear,CancelPending,,3,-1",
				"OnTrigger#9" : "playerRunScriptCodeClientPrint(self, 4, `Game over`)3-1,0,-1",
				"OnTrigger#10" : "roundformat,FireUser2,,3,-1",
				"OnTrigger#11" : "realtimer,FireUser2,,3,-1",
				"OnTrigger#12" : "realtimer,FireUser2,,3.7,-1",
				"OnTrigger#13" : "finale_snd,volume,0,3,-1",
				"OnTrigger#14" : "bossfight_snd,volume,0,3,-1",
				"OnTrigger#15" : "tankround_snd,volume,0,3,-1",
				"OnTrigger#16" : "fail_snd,PlaySound,,3,-1",
				"OnTrigger#17" : "fade_out,Fade,,6,-1",
				"OnTrigger#18" : "camera_gameover_1,$EnableAll,,8,-1",
				"OnTrigger#19" : "entity_revive_marker,Kill,,8,-1",
				"OnTrigger#20" : "camera_spin,start,,8,-1",
				"OnTrigger#21" : "player,$PlaySequence,victoryb,8,-1",
				"OnTrigger#22" : "fade_in,Fade,,8,-1",
				"OnTrigger#23" : "fade_out,Fade,,13,-1",
				"OnTrigger#24" : "camera_spin,stop,,15,-1",
				"OnTrigger#25" : "camera_gameover_2,$EnableAll,,15,-1",
				"OnTrigger#26" : "camera_spin_2,start,,15,-1",
				"OnTrigger#27" : "player,$PlaySequence,victory,15,-1",
				"OnTrigger#28" : "fade_in,Fade,,15,-1",
				"OnTrigger#29" : "bots_win,RoundWin,,18.5,-1",
			},
		},
		[10] =
		{
			logic_relay =
			{
				targetname = "youwin",
				"OnTrigger#1" : "finale_snd,volume,0,0,-1",
				"OnTrigger#2" : "playerRunScriptCodeClientPrint(self, 4, `Game over`)0-1,0,-1",
				"OnTrigger#3" : "gameover,Disable,,-1,-1",
				"OnTrigger#4" : "roundformat,FireUser2,,0,-1",
				"OnTrigger#5" : "realtimer,FireUser2,,0,-1",
				"OnTrigger#6" : "realtimer,FireUser2,,0.7,-1",
				"OnTrigger#7" : "win_snd,PlaySound,,0,-1",
				"OnTrigger#8" : "fade_out,Fade,,13,-1",
				"OnTrigger#9" : "camera_gameover_1,$EnableAll,,15,-1",
				"OnTrigger#10" : "entity_revive_marker,Kill,,15,-1",
				"OnTrigger#11" : "camera_spin,start,,15,-1",
				"OnTrigger#12" : "fade_in,Fade,,15,-1",
				"OnTrigger#13" : "fade_out,Fade,,20,-1",
				"OnTrigger#14" : "camera_spin,stop,,22,-1",
				"OnTrigger#15" : "camera_gameover_2,$EnableAll,,22,-1",
				"OnTrigger#16" : "camera_spin_2,start,,22,-1",
				"OnTrigger#17" : "fade_in,Fade,,22,-1",
				"OnTrigger#18" : "hologram_nuke_hurt,Enable,,25.5,-1",
				"OnTrigger#19" : "camera_spin_2,stop,,32,-1",
			},
		},
	},
	FrearmPT =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "!activator",
				Action = "$giveitem",
				Param = "Secondary Revolver",
			},
		},
	},
	ThundergunPT =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun_effect",
				Action = "Start",
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun_hurt",
				Action = "$SetOwner",
				Param = "!activator",
			},
		},
		[2] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun*",
				Action = "Kill",
				Delay = 0.35,
			},
		},
		[3] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 90 90",
			},
		},
		[4] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 65 90",
			},
		},
		[5] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 115 90",
			},
		},
		[6] =
		{
			trigger_hurt =
			{
				damage = 5000,
				damagetype = 4194304,
				targetname = "thundergun_hurt",
				spawnflags = 1,
				nodmgforce = 0,
				filtername = "filter_blueteam",
				mins = "-128 -48 -24",
				maxs = "128 48 24",
			},
		},
	},
	Thundergun_2PT =
	{
		[0] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun_effect",
				Action = "Start",
			},
		},
		[1] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun_hurt",
				Action = "$SetOwner",
				Param = "!activator",
			},
		},
		[2] =
		{
			OnSpawnOutput =
			{
				Target = "thundergun*",
				Action = "Kill",
				Delay = 0.35,
			},
		},
		[3] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 90 90",
			},
		},
		[4] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 65 90",
			},
		},
		[5] =
		{
			info_particle_system =
			{
				targetname = "thundergun_effect",
				effect_name = "utaunt_lightning_bolt",
				angles = "0 115 90",
			},
		},
		[6] =
		{
			trigger_hurt =
			{
				damage = 9750,
				damagetype = 4194304,
				targetname = "thundergun_hurt",
				spawnflags = 1,
				nodmgforce = 0,
				filtername = "filter_blueteam",
				mins = "-128 -48 -24",
				maxs = "128 96 24",
			},
		},
	},
	MedicbagPT =
	{
		[0] =
		{
			dispenser_touch_trigger =
			{
				spawnflags = 1,
				targetname = "medicbag_aoe",
				origin = "0 0 0",
				mins = "-128 -128 -36",
				maxs = "128 128 36",
			},
		},
		[1] =
		{
			mapobj_cart_dispenser =
			{
				spawnflags = 12,
				origin = "0 -12 0",
				targetname = "medicbag_dispbeam",
				TeamNum = 2,
				touch_trigger = "medicbag_aoe",
			},
		},
		[2] =
		{
			trigger_multiple =
			{
				spawnflags = 1,
				filtername = "filter_notred",
				origin = "0 0 0",
				mins = "-128 -128 -36",
				maxs = "128 128 36",
				"OnStartTouchAll#1" : "medicbag_aoe,Disable,,-1,-1",
				"OnEndTouchAll#1" : "medicbag_aoe,Enable,,3,-1",
			},
		},
	},
}