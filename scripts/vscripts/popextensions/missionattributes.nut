::MissionAttributes <- {

    CurAttrs = {} // Array storing currently modified attributes.
    ConVars = {} //table storing original convar values

    ThinkTable = {}
    TakeDamageTable = {}
    SpawnHookTable = {}
    DeathHookTable = {}
    InitWaveTable = {}
    DisconnectTable = {}

    DebugText = false
    RaisedParseError = false
	
	InitWave = function() {
		foreach (_, func in MissionAttributes.InitWaveTable) func()

		foreach (attr, value in MissionAttributes.CurAttrs) printl(attr+" = "+value)
		MissionAttributes.RaisedParseError = false
	}

    Events = {

        function OnScriptHook_OnTakeDamage(params) { foreach (_, func in MissionAttributes.TakeDamageTable) func(params) }
        // function OnGameEvent_player_spawn(params) { foreach (_, func in MissionAttributes.SpawnHookTable) func(params) }
        function OnGameEvent_player_death(params) { foreach (_, func in MissionAttributes.DeathHookTable) func(params) }
        function OnGameEvent_player_disconnect(params) { foreach (_, func in MissionAttributes.DisconnectTable) func(params) }

        function OnGameEvent_post_inventory_application(params) { 
            local player = GetPlayerFromUserID(params.userid)
            player.ValidateScriptScope()
            local scope = player.GetScriptScope()
            if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}
    
			function PlayerThinks() { foreach (_, func in scope.PlayerThinkTable) func(); return -1 }
            scope.PlayerThinks <- PlayerThinks
            AddThinkToEnt(player, "PlayerThinks")
    
            foreach (_, func in MissionAttributes.SpawnHookTable) func(params)
        } 
        // Hook all wave inits to reset parsing error counter.
        
        function OnGameEvent_recalculate_holidays(params)
        {
            if (GetRoundState() != 3) return
			
			MissionAttributes.InitWave();
        }
    
        function GameEvent_mvm_wave_complete(params) 
        { 
            ResetConvars()
            delete ::MissionAttributes
            DebugLog(format("Cleaned up mission attribute %s", attr))
        }
    }
};
__CollectGameEventCallbacks(MissionAttributes.Events);

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

local MissionAttrEntity = FindByName(null, "popext_missionattr_ent")
if (MissionAttrEntity == null) MissionAttrEntity = SpawnEntityFromTable("info_teleport_destination", {targetname = "popext_missionattr_ent"});

function MissionAttributes::SetConvar(convar, value, hideChatMessage = true)
{
    local commentaryNode = Entities.FindByClassname(null, "point_commentary_node")
    if (commentaryNode == null && hideChatMessage) commentaryNode = SpawnEntityFromTable("point_commentary_node", {})

    //save original values to restore later
    if (!(convar in MissionAttributes.ConVars))
        MissionAttributes.ConVars[convar] <- Convars.GetStr(convar);

    if (Convars.GetStr(convar) != value) Convars.SetValue(convar, value)

    EntFireByHandle(commentaryNode, "Kill", "", 1.1, null, null)
}

function MissionAttributes::ResetConvars()
{
    foreach (convar, value in MissionAttributes.ConVars)
        Convars.SetValue(convar, value)
    MissionAttributes.ConVars.clear()
}

local noRomeCarrier = false
function MissionAttributes::MissionAttr(attr, value = 0)
{
    local success = true
    switch(attr) {

    // =========================================================
    case "ForceHoliday":
    // Replicates sigsegv-mvm: ForceHoliday.
    // Forces a tf_holiday for the mission.
    // Supported Holidays are:
    //  0 - None
    //  1 - Birthday
    //  2 - Halloween
    //  3 - Christmas
    // @param Holiday       Holiday number to force.
    // @error TypeError     If type is not an integer.
    // @error IndexError    If invalid holiday number is passed.
        // Error Handling
    try (value.tointeger()) catch(_) {RaiseTypeError(attr, "int"); success = false; break}
    if (type(value) != "integer") {RaiseTypeError(attr, "int"); success = false; break}
    if (value < 0 || value > 11) {RaiseIndexError(attr, [0, 11]); success = false; break}

        // Set Holiday logic
        SetConvar("tf_forced_holiday", value)
    if (value == 0) break;

        local ent = Entities.FindByName(null, "MissionAttrHoliday");
        if (ent != null) ent.Kill();
        SpawnEntityFromTable("tf_logic_holiday",
        {
            targetname = "MissionAttrHoliday",
            holiday_type = value
        });

    break;

    // ========================================================

    case "NoCrumpkins":
        local pumpkinIndex = PrecacheModel("models/props_halloween/pumpkin_loot.mdl");
        function MissionAttributes::NoCrumpkins()
        {
            switch(value)
            {

                case 1:

                for (local pumpkin; pumpkin = Entities.FindByClassname(pumpkin, "tf_ammo_pack");)
                    if (GetPropInt(pumpkin, "m_nModelIndex") == pumpkinIndex)
                        EntFireByHandle(pumpkin, "Kill", "", -1, null, null) //should't do .Kill() in the loop, entfire kill is delayed to the end of the frame.
            }
            for (local i = 1, player; i <= MaxClients(); i++)
                if (player = PlayerInstanceFromIndex(i), player && player.InCond(TF_COND_CRITBOOSTED_PUMPKIN)) //TF_COND_CRITBOOSTED_PUMPKIN
                    EntFireByHandle(player, "RunScriptCode", "self.RemoveCond(TF_COND_CRITBOOSTED_PUMPKIN)", -1, null, null)
        }
        MissionAttributes.ThinkTable.NoCrumpkins <- MissionAttributes.NoCrumpkins
    break;

    // =========================================================

    case "NoReanimators":
        if (value < 1) return
        function MissionAttributes::NoReanimators(params)
        {
            for (local revivemarker; revivemarker = Entities.FindByClassname(revivemarker, "entity_revive_marker");)
                EntFireByHandle(revivemarker, "Kill", "", -1, null, null)
        }
        MissionAttributes.DeathHookTable.NoReanimators <- MissionAttributes.NoReanimators
    break;

    // =========================================================
    
    case "StandableHeads":
        local movekeys = IN_FORWARD | IN_BACK | IN_LEFT | IN_RIGHT
        function MissionAttributes::StandableHeads(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            if (player.IsBotOfType(1337)) return

            function StandableHeads()
            {
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
    break;

    // =========================================================

    case "WaveNum":
        SetPropInt(PopExtUtil.ObjectiveResource, "m_nMannVsMachineWaveCount", value)
    break;

    // =========================================================

    case "MaxWaveNum":
        SetPropInt(PopExtUtil.ObjectiveResource, "m_nMannVsMachineMaxWaveCount", value)
    break;

    // =========================================================

    case "MultiSapper":
        function MissionAttributes::MultiSapperThink()
        {
            for (local sapper; sapper = FindByClassname("obj_attachment_sapper");)
                SetPropBool(sapper, "m_bDisposableBuilding", true)
        }
        MissionAttributes.ThinkTable.MultiSapperThink <- MissionAttributes.MultiSapperThink
    break;
    
    // =========================================================

    //all of these could just be set directly in the pop easily, however popfile's have a 4096 character limit for vscript so might as well save space
    case "NoRefunds":
        SetConvar("tf_mvm_respec_enabled", 0);
    break;

    // =========================================================

    case "RefundLimit":
        SetConvar("tf_mvm_respec_enabled", 1)
        SetConvar("tf_mvm_respec_limit", value)
    break;

    // =========================================================

    case "RefundGoal":
        SetConvar("tf_mvm_respec_enabled", 1)
        SetConvar("tf_mvm_respec_credit_goal", value)
    break;

    // =========================================================

    case "FixedBuybacks":
        SetConvar("tf_mvm_buybacks_method", 1)
    break;

    // =========================================================

    case "BuybacksPerWave":
        SetConvar("tf_mvm_buybacks_per_wave", value)
    break;

    // =========================================================

    case "NoBuybacks":
        SetConvar("tf_mvm_buybacks_method", value)
        SetConvar("tf_mvm_buybacks_per_wave", 0)
    break;

    // =========================================================

    case "DeathPenalty":
        SetConvar("tf_mvm_death_penalty", value)
    break;

    // =========================================================

    case "BonusRatioHalf":
        SetConvar("tf_mvm_currency_bonus_ratio_min", value)
    break;

    // =========================================================

    case "BonusRatioFull":
        SetConvar("tf_mvm_currency_bonus_ratio_max", value)
    break;

    // =========================================================

    case "UpgradeFile":
        DoEntFire("tf_gamerules", "SetCustomUpgradesFile", value, -1, null, null);
    break;

    // =========================================================

    case "FlagEscortCount":
        SetConvar("tf_bot_flag_escort_max_count", value)
    break;

    // =========================================================

    case "BombMovementPenalty":
        SetConvar("tf_mvm_bot_flag_carrier_movement_penalty", value)
    break;

    // =========================================================
    
    case "MaxSkeletons":
        SetConvar("tf_max_active_zombie", value)
    break;

    // =========================================================

    case "TurboPhysics":
        SetConvar("sv_turbophysics", value)
    break;
        
    // =========================================================

    case "Accelerate":
        SetConvar("sv_accelerate", value)
    break;
        
    // =========================================================

    case "AirAccelerate":
        SetConvar("sv_airaccelerate", value)
    break;
        
    // =========================================================

    case "BotPushaway":
        SetConvar("tf_avoidteammates_pushaway", value)
    break;

    // =========================================================

    case "TeleUberDuration":
        SetConvar("tf_mvm_engineer_teleporter_uber_duration", value)
    break;

    // =========================================================

    case "RedMaxPlayers":
        SetConvar("tf_mvm_defenders_team_size", value)
    break;

    // =========================================================

    case "MaxVelocity":
        SetConvar("sv_maxvelocity", value)
    break;

    // =========================================================

    case "ConchHealthOnHitRegen":
        SetConvar("tf_dev_health_on_damage_recover_percentage", value)
    break;

    // =========================================================

    case "MarkForDeathLifetime":
        SetConvar("tf_dev_marked_for_death_lifetime", value)
    break;

    // =========================================================

    case "VacNumCharges":
        SetConvar("weapon_medigun_resist_num_chunks", value)
    break;

    // =========================================================

    case "DoubleDonkWindow":
        SetConvar("tf_double_donk_window", value)
    break;

    // =========================================================

    case "ConchSpeedBoost":
        SetConvar("tf_whip_speed_increase", value)
    break;

    // =========================================================

    case "StealthDmgReduction":
        SetConvar("tf_stealth_damage_reduction", value)
    break;

    // =========================================================

    case "FlagCarrierCanFight":
        SetConvar("tf_mvm_bot_allow_flag_carrier_to_fight", value)
    break;

    // =========================================================
    
    case "HHHChaseRange":
        SetConvar("tf_halloween_bot_chase_range", value)
    break;

    // =========================================================
    
    case "HHHAttackRange":
        SetConvar("tf_halloween_bot_attack_range", value)
    break;

    // =========================================================
    
    case "HHHQuitRange":
        SetConvar("tf_halloween_bot_quit_range", value)
    break;

    // =========================================================
    
    case "HHHTerrifyRange":
        SetConvar("tf_halloween_bot_terrify_radius", value)
    break;

    // =========================================================
    
    case "HHHHealthBase":
        SetConvar("tf_halloween_bot_health_base", value)
    break;

    // =========================================================
    
    case "HHHHealthPerPlayer":
        SetConvar("tf_halloween_bot_health_per_player", value)
    break;

    // =========================================================

    case "SentryHintBombForwardRange":
        SetConvar("tf_bot_engineer_mvm_sentry_hint_bomb_forward_range", value)
    break;

    // =========================================================

    case "SentryHintBombBackwardRange":
        SetConvar("tf_bot_engineer_mvm_sentry_hint_bomb_backward_range", value)
    break;

    // =========================================================

    case "SentryHintMinDistanceFromBomb":
        SetConvar("tf_bot_engineer_mvm_hint_min_distance_from_bomb", value)
    break;

    // =========================================================

    case "NoBusterFF":
        if (value != 1 || value != 0 ) RaiseIndexError(attr)
        SetConvar("tf_bot_suicide_bomb_friendly_fire", value = 1 ? 0 : 1)
    break;

    // =========================================================

    case "SniperHideLasers":
        if (value < 1) return
        function MissionAttributes::SniperHideLasers()
        {
            for (local dot; dot = Entities.FindByClassname(dot, "env_sniperdot");)
                if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
                    EntFireByHandle(dot, "Kill", "", -1, null, null)

            for (local dot; dot = Entities.FindByClassname(dot, "env_laserdot");)
                if (dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS)
                    EntFireByHandle(dot, "Kill", "", -1, null, null)
            return -1;
        }
        // if (!(MissionAttributes.SniperHideLasers in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.SniperHideLasers <- MissionAttributes.SniperHideLasers
    break;

    // =========================================================

    case "BotHeadshots":
        if (value < 1) return
        function MissionAttributes::BotHeadshots(params)
        {
            local player = params.attacker, victim = params.const_entity
        
            // //gib bots on explosive/crit dmg, doesn't work
            // if (!victim.IsMiniBoss() && (params.damage_type & DMG_CRITICAL || params.damage_type & DMG_BLAST))
            // {
            // 	victim.SetModelScale(1.00000001, 0.0);
            // 	// EntFireByHandle(victim, "CallScriptFunction", "dmg", -1, null, null); //wait 1 frame
            // 	return
            // }
            
            //re-enable headshots for snipers and ambassador
            if (!player.IsPlayer() || !victim.IsPlayer() || IsPlayerABot(player)) return //check if non-bot victim
            if (player.GetPlayerClass() != TF_CLASS_SPY && player.GetPlayerClass() != TF_CLASS_SNIPER) return //check if we're spy/sniper
            if (GetPropInt(victim, "m_LastHitGroup") != HITGROUP_HEAD) return //check for headshot
            if (player.GetPlayerClass() == TF_CLASS_SNIPER && (player.GetActiveWeapon().GetSlot() == SLOT_SECONDARY || GetItemIndex(player.GetActiveWeapon()) == ITEMINDEX_THE_SYDNEY_SLEEPER)) return //ignore sydney sleeper and SMGs
            if (player.GetPlayerClass() == TF_CLASS_SPY && GetItemIndex(player.GetActiveWeapon()) != ITEMINDEX_THE_AMBASSADOR) return //ambassador only
            params.damage_type | (DMG_USE_HITLOCATIONS | DMG_CRITICAL) //DMG_USE_HITLOCATIONS doesn't actually work here, no headshot icon.
            return true
        }
        // if (!(MissionAttributes.SniperHideLasers in MissionAttributes.TakeDamageTable))
            MissionAttributes.TakeDamageTable.BotHeadshots <- MissionAttributes.BotHeadshots
    break;

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
        function MissionAttributes::PlayersAreRobots(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            if (player.IsBotOfType(1337)) return
            
            player.ValidateScriptScope()
            local scope = player.GetScriptScope()

            if ("wearable" in scope && scope.wearable != null)
            {
                scope.wearable.Destroy()
                scope.wearable <- null
            }
            
            local playerclass  = player.GetPlayerClass()
            local class_string = PopExtUtil.Classes[playerclass]
            local model = format("models/bots/%s/bot_%s.mdl", class_string, class_string)
            
            if (value & 1)
            {
                //sticky anims and thruster anims are particularly problematic
                if ((playerclass == TF_CLASS_DEMOMAN && PopExtUtil.GetItemInSlot(player, SLOT_SECONDARY).GetClassname() == "tf_weapon_pipebomblauncher") || (playerclass == TF_CLASS_PYRO && PopExtUtil.HasItemIndex(player, ITEMINDEX_THERMAL_THRUSTER))) 
                {
                    PopExtUtil.PlayerRobotModel(player, model)
                    return
                }
                EntFireByHandle(player, "SetCustomModelWithClassAnimations", model, 1, null, null)
                PopExtUtil.SetEntityColor(player, 255, 255, 255, 255)
                SetPropInt(player, "m_nRenderMode", kRenderFxNone) //dangerous constant name lol

            }

            if (value & 2)
            {   
                if (value & 1) value | 1 //incompatible flags
                PopExtUtil.PlayerRobotModel(player, model)
            }

            if (value & 4)
            {
                scope.stepside <- GetPropInt(player, "m_Local.m_nStepside")

                function StepThink()
                {
					if (self.GetPlayerClass() == TF_CLASS_MEDIC) return
					
                    if (GetPropInt(self,"m_Local.m_nStepside") != stepside)
                        EmitSoundOn("MVM.BotStep", self)

                    scope.stepside = GetPropInt(self,"m_Local.m_nStepside")
                    return -1
                }
                if (!("StepThink" in scope.PlayerThinkTable)) 
                    scope.PlayerThinkTable.StepThink <- StepThink


            } else if ("StepThink" in scope.PlayerThinkTable) delete scope.PlayerThinkTable.StepThink
			
			if (value & 8)
			{
				function RobotVOThink()
				{
					for (local ent; ent = Entities.FindByClassname(ent, "instanced_scripted_scene"); )
					{
						if (ent.GetEFlags() & CONST.EFL_IS_BEING_LIFTED_BY_BARNACLE) continue
						ent.AddEFlags(CONST.EFL_IS_BEING_LIFTED_BY_BARNACLE)
						
						local owner = GetPropEntity(ent, "m_hOwner")
						if (owner != null && !owner.IsBotOfType(1337))
						{
						  
							local vcdpath = GetPropString(ent, "m_szInstanceFilename");
							if (!vcdpath || vcdpath == "") return -1
							
							local dotindex   = vcdpath.find(".")
							local slashindex = null;
							for (local i = dotindex; i >= 0; --i)
							{
								if (vcdpath[i] == '/' || vcdpath[i] == '\\')
								{
									slashindex = i
									break;
								}
							}
							
							owner.ValidateScriptScope()
							local scope = owner.GetScriptScope()
							scope.soundtable <- VCD_SOUNDSCRIPT_MAP[owner.GetPlayerClass()]
							scope.vcdname    <- vcdpath.slice(slashindex+1, dotindex)
							
							if (scope.vcdname in scope.soundtable)
							{
								EntFireByHandle(owner, "RunScriptCode", "self.StopSound(soundtable[vcdname]);", -1, null, null)
								
								local sound    =  scope.soundtable[scope.vcdname]
								dotindex       =  sound.find(".")
								scope.mvmsound <- sound.slice(0, dotindex+1) + "MVM_" + sound.slice(dotindex+1)
								
								EntFireByHandle(owner, "RunScriptCode", "self.EmitSound(mvmsound);", 0.015, null, null)
							}
						}
					}

					return -1;					
				}

				if (!("RobotVOThink" in MissionAttributes.ThinkTable))
					MissionAttributes.ThinkTable.RobotVOThink <- RobotVOThink

            } else if ("RobotVOThink" in scope.PlayerThinkTable) delete scope.PlayerThinkTable.RobotVOThink
			
            if (value & 16)
            {
				function RobotArmThink()
				{
					local vmodel   = PopExtUtil.ROBOT_ARM_PATHS[player.GetPlayerClass()]
					local playervm = GetPropEntity(player, "m_hViewModel")
					if (playervm.GetModelName() != vmodel && player.InCond(TF_COND_INVULNERABLE)) playervm.SetModelSimple(vmodel)
					
					for (local i = 0; i < SLOT_COUNT; i++)
					{
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
    break;

    // =========================================================

    case "BotsAreHumans":
        function MissionAttributes::BotsAreHumans(params)
        {
            local player = GetPlayerFromUserID(params.userid)
            if (!player.IsBotOfType(1337)) return
            EntFireByHandle(player, "SetCustomModelWithClassAnimations", format("models/player/%s.mdl", PopExtUtil.Classes[bot.GetPlayerClass()]), -1, null, null)
        }

        // if (!(MissionAttributes.BotsAreHumans in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.BotsAreHumans <- MissionAttributes.BotsAreHumans
    break;

    // =========================================================

    case "NoRome":
        local carrierPartsIndex = GetModelIndex("models/bots/boss_bot/carrier_parts.mdl")
        function MissionAttributes::NoRome(params)
        {
            local bot = GetPlayerFromUserID(params.userid)
            if (bot.IsBotOfType(1337))
                for (local child = bot.FirstMoveChild(); child != null; child = child.NextMovePeer())
                    if (!bot.HasBotTag("popext_forceromevision") && child.GetClassname() == "tf_wearable" && startswith(child.GetModelName(), "models/workshop/player/items/"+PopExtUtil.Classes[bot.GetPlayerClass()]+"/tw"))
                        EntFireByHandle(child, "Kill", "", -1, null, null)

            //set value to 2 to also kill the carrier tank addon model
            if (value < 2 || noRomeCarrier) return

            local carrier = Entities.FindByName(null, "botship_dynamic") //some maps have a targetname for it
    
            if (carrier == null)
            {
                for (local props; props = Entities.FindByClassname(props, "prop_dynamic");)
                {
                    if (GetPropInt(props, "m_nModelIndex") != carrierPartsIndex) continue

                    carrier = props
                    break;
                }

            }
            SetPropIntArray(carrier, "m_nModelIndexOverrides", carrierPartsIndex, 3)
            noRomeCarrier = true
        }
        // if (!(MissionAttributes.NoRome in MissionAttributes.SpawnHookTable))
            MissionAttributes.SpawnHookTable.NoRome <- MissionAttributes.NoRome
    break;

    // =========================================================

    case "SpellDropRateCommon":
        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::SpellDropRateCommon(params)
        {
            if (RandomFloat(0, 1) > value) return

            local bot = GetPlayerFromUserID(params.userid)

            if (!bot.IsBotOfType(1337) || bot.IsMiniBoss()) return

            local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_commonspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" })
        }
        // if (!(MissionAttributes.SpellDropRateCommon in MissionAttributes.DeathHookTable))
            MissionAttributes.DeathHookTable.SpellDropRateCommon <- MissionAttributes.SpellDropRateCommon
    break;

    // =========================================================

    case "SpellDropRateGiant":
        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::SpellDropRateCommon(params)
        {
            if (RandomFloat(0, 1) > value) return

            local bot = GetPlayerFromUserID(params.userid)

            if (!bot.IsBotOfType(1337) || !bot.IsMiniBoss()) return

            local spell = SpawnEntityFromTable("tf_spell_pickup", {targetname = "_giantspell" origin = bot.GetLocalOrigin() TeamNum = 2 tier = 0 "OnPlayerTouch": "!self,Kill,,0,-1" })
        }
        // if (!(MissionAttributes.SpellDropRateCommon in MissionAttributes.DeathHookTable))
            MissionAttributes.DeathHookTable.SpellDropRateCommon <- MissionAttributes.SpellDropRateCommon
    break;

    // =========================================================

    case "GiantsRareSpells":
        SetConvar("tf_spells_enabled", 1)
        function MissionAttributes::GiantsRareSpells()
        {
            for (local spells; spells = Entities.FindByName(spells, "_giantspell");)
                SetPropInt(spells, "m_nTier", 1)
        }

        // if (!(MissionAttributes.GiantsRareSpells in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.GiantsRareSpells <- MissionAttributes.GiantsRareSpells
    break;

    // =========================================================

    case "GrapplingHookEnable":
        SetConvar("tf_grapplinghook_enable", value)
    break;

    // =========================================================

    case "GiantScale":
        SetConvar("tf_mvm_miniboss_scale", value)
    break;

    // =========================================================

    case "NoSkeleSplit":
        function MissionAttributes::NoSkeleSplit()
        {
            //kill skele spawners before they split from tf_zombie_spawner
            for (local skelespell; skelespell = FindByClassname(skelespell, "tf_projectile_spellspawnzombie"); )
                if (GetPropEntity(skelespell, "m_hThrower") == null)
                    EntFireByHandle(skelespell, "Kill", "", -1, null, null)

            // m_hThrower does not change when the skeletons split for spell-casted skeles, just need to kill them after spawning
            for (local skeles; skeles = FindByClassname(skeles, "tf_zombie");  )
            {
                //kill blu split skeles
                if (skeles.GetModelScale() == 0.5 && GetPropEntity(skelespell, "m_hThrower").IsBotOfType(1337))
                {
                    EntFireByHandle(skeles, "Kill", "", -1, null, null)
                    return
                }
                if (skeles.GetTeam() == 5)
                {
                    skeles.SetTeam(TF_TEAM_PVE_INVADERS)
                    skeles.SetSkin(1)
                }
                // smoove skele, unfinished

                // local locomotion = skeles.GetLocomotionInterface();
                // locomotion.Reset();
                // skeles.FlagForUpdate(true);
                // locomotion.ComputeUpdateInterval(); //not necessary
                // foreach (a in areas)
                // {
                //     if (a.GetPlayerCount(TF_TEAM_PVE_DEFENDERS) < 1) continue

                //     skeles.ClearImmobileStatus();
                //     locomotion.SetDesiredSpeed(280.0);
                //     locomotion.Approach(a.FindRandomSpot(), 999.0);
                // }
            }
        }
        // if (!(MissionAttributes.NoSkeleSplit in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.NoSkeleSplit <- MissionAttributes.NoSkeleSplit

    break;

    // =========================================================

    case "WaveStartCountdown":
        function MissionAttributes::WaveStartCountdown()
        {
            local roundtime = GetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime")
            if (!GetPropBool(PopExtUtil.ObjectiveResource, "m_bMannVsMachineBetweenWaves")) return
            local ready = 0

            if (roundtime > Time() + value)
            {
                for (local i = 0; i < GetPropArraySize(PopExtUtil.GameRules, "m_bPlayerReady"); i++)
                {
                    if (!GetPropBoolArray(PopExtUtil.GameRules, "m_bPlayerReady", i)) continue
                    ready++;
                    // printl(ready +" : "+ CountAllPlayers());
                    if (ready >= PopExtUtil.PlayerArray.len() || (roundtime <= 12.0))
                        SetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime", Time() + value)
                }
            }

        }
        // if (!(MissionAttributes.WaveStartCountdown in MissionAttributes.ThinkTable))
            MissionAttributes.ThinkTable.WaveStartCountdown <- MissionAttributes.WaveStartCountdown
    break;
	
    // =========================================================

	// MissionAttr("HandModelOverride", "path")
	// MissionAttr("HandModelOverride", ["defaultpath", "scoutpath", "sniperpath"])
	// "path" and "defaultpath" will have %class in the string replaced with the player class
    case "HandModelOverride":
		function MissionAttributes::HandModelOverride(params)
		{
            local player = GetPlayerFromUserID(params.userid)
            if (player.IsBotOfType(1337)) return
            
            player.ValidateScriptScope()
            local scope = player.GetScriptScope()

			function ArmThink()
			{
				local tfclass      = player.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]
				
				local vmodel   = null
				local playervm = GetPropEntity(player, "m_hViewModel")
				
				if (typeof value == "string")
					vmodel = PopExtUtil.StringReplace(value, "%class", class_string);
				else if (typeof value == "array")
				{
					if (value.len() == 0) return
					
					if (tfclass >= value.len())
						vmodel = PopExtUtil.StringReplace(value[0], "%class", class_string);
					else
						vmodel = value[tfclass]
				}
				else
				{
					// do we need to do anything special for thinks??
					MissionAttributes.RaiseValueError("HandModelOverride", value, extra = "Value must be string or list of strings")
					return
				}

				if (vmodel == null) return
				
				if (playervm.GetModelName() != vmodel) playervm.SetModelSimple(vmodel)
				
				for (local i = 0; i < SLOT_COUNT; i++)
				{
					local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
					if (wep == null || (wep.GetModelName() == vmodel)) continue

					wep.SetModelSimple(vmodel)
					wep.SetCustomViewModel(vmodel)
				}
			}
			
			if (!("ArmThink" in scope.PlayerThinkTable))
				scope.PlayerThinkTable.ArmThink <- ArmThink	
		}
		
		if (!("HandModelOverride" in MissionAttributes.SpawnHookTable))
			MissionAttributes.SpawnHookTable.HandModelOverride <- MissionAttributes.HandModelOverride
    break;

    //Options to revert global fixes below:

    // =========================================================

    case "ReflectableDF":
        if ("DragonsFuryFix" in GlobalFixes.ThinkTable)
            delete GlobalFixes.ThinkTable.DragonsFuryFix
    break;
    
    // =========================================================

    case "RestoreYERNerf":
        if ("YERDisguiseFix" in GlobalFixes.TakeDamageTable)
            delete GlobalFixes.TakeDamageTable.YERDisguiseFix
    break;

    // =========================================================

    // Don't add attribute to clean-up list if it could not be found.
    default:
        ParseError(format("Could not find mission attribute '%s'", attr))
        success = false
    }

    // Add attribute to clean-up list if its modification was successful.
    if (success)
    {
        DebugLog(format("Added mission attribute %s", attr))
        MissionAttributes.CurAttrs[attr] <- value
    }
}

function MissionAttrThink()
{
    foreach (_, func in MissionAttributes.ThinkTable) func()
    return -1
}

MissionAttrEntity.ValidateScriptScope();
MissionAttrEntity.GetScriptScope().MissionAttrThink <- MissionAttrThink
AddThinkToEnt(MissionAttrEntity, "MissionAttrThink")


// Allow calling MissionAttributes::MissionAttr() directly with MissionAttr().
function MissionAttr(attr, value)
{
    MissionAttr.call(MissionAttributes, attr, value)
}
//super truncated version incase the pop character limit becomes an issue.
function MAtr(attr, value)
{
    MissionAttr.call(MissionAttributes, attr, value)
}

// Logging Functions
// =========================================================
// Generic debug message that is visible if PrintDebugText is true.
// Example: Print a message that the script is working as expected.
function MissionAttributes::DebugLog(LogMsg)
{
    if (MissionAttributes.DebugText)
    {
        ClientPrint(null, 2, format("MissionAttr: %s.", LogMsg))
    }
}
// Raises an error if the user passes an index that is out of range.
// Example: Allowed values are 1-2, but user passed 3.
function MissionAttributes::RaiseIndexError(attr, max = [0, 1]) ParseError(format("Index out of range for %s, value range: %d - %d", attr, max[0], max[1]))

// Raises an error if the user passes an argument of the wrong type.
// Example: Allowed values are strings, but user passed a float.
function MissionAttributes::RaiseTypeError(attr, type) ParseError(format("Bad type for %s (should be %s)", attr, type))

// Raises an error if the user passes an invalid argument
// Example: Attribute expects a bitwise operator but value cannot be evenly split into a power of 2
function MissionAttributes::RaiseValueError(attr, value, extra = "") ParseError(format("Bad value   %s  passed to %s.%s", value.tostring(), attr, extra))

// Raises a template parsing error, if nothing else fits.
function MissionAttributes::ParseError(ErrorMsg)
{
    if (!MissionAttributes.RaisedParseError)
    {
        MissionAttributes.RaisedParseError = true
        ClientPrint(null, 3, "\x08FFB4B4FFIt is possible that a parsing error has occured. Check console for details.")
    }
    ClientPrint(null, 2, format("%s %s.\n", MATTR_ERROR, ErrorMsg))

    foreach (player in PopExtUtil.PlayerArray)
    {
        if (player == null) continue

        EntFireByHandle(ClientCommand, "Command", format("echo %s %s.\n", MATTR_ERROR, ErrorMsg), -1, player, player)
    }
    printf("%s %s.\n", MATTR_ERROR, ErrorMsg)
}

// Raises an exception.
// Example: Script modification has not been performed correctly. User should never see one of these.
function MissionAttributes::RaiseException(ExceptionMsg)
{
    Assert(false, format("MissionAttr EXCEPTION: %s.", ExceptionMsg))
}
