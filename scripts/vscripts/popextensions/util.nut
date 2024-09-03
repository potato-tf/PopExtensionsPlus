// All Global Utility Functions go here, also use IncludeScript and place it inside Root
::PopExtUtil <- {

	HumanArray = []
	BotArray = []
	PlayerArray = []
	Classes = ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer", "civilian"] //make element 0 a dummy string instead of doing array + 1 everywhere
	ClassesCaps = ["", "Scout", "Sniper", "Soldier", "Demoman", "Medic", "Heavy", "Pyro", "Spy", "Engineer", "Civilian"] //make element 0 a dummy string instead of doing array + 1 everywhere
	Slots   = ["slot_primary", "slot_secondary", "slot_melee", "slot_utility", "slot_building", "slot_pda", "slot_pda2"]
	IsWaveStarted = false //check a global variable instead of accessing a netprop every time to check if we are between waves.
	AllNavAreas = {}
	ROBOT_ARM_PATHS = [
		"", // Dummy
		"models/weapons/c_models/c_scout_bot_arms.mdl",
		"models/weapons/c_models/c_sniper_bot_arms.mdl",
		"models/weapons/c_models/c_soldier_bot_arms.mdl",
		"models/weapons/c_models/c_demo_bot_arms.mdl",
		"models/weapons/c_models/c_medic_bot_arms.mdl",
		"models/weapons/c_models/c_heavy_bot_arms.mdl",
		"models/weapons/c_models/c_pyro_bot_arms.mdl",
		"models/weapons/c_models/c_spy_bot_arms.mdl",
		"models/weapons/c_models/c_engineer_bot_arms.mdl",
		"", // Civilian
	]
	HUMAN_ARM_PATHS =
	[
		"models/weapons/c_models/c_medic_arms.mdl", //dummy
		"models/weapons/c_models/c_scout_arms.mdl",
		"models/weapons/c_models/c_sniper_arms.mdl",
		"models/weapons/c_models/c_soldier_arms.mdl",
		"models/weapons/c_models/c_demo_arms.mdl",
		"models/weapons/c_models/c_medic_arms.mdl",
		"models/weapons/c_models/c_heavy_arms.mdl",
		"models/weapons/c_models/c_pyro_arms.mdl",
		"models/weapons/c_models/c_spy_arms.mdl",
		"models/weapons/c_models/c_engineer_arms.mdl",
		"models/weapons/c_models/c_engineer_gunslinger.mdl",	//CIVILIAN/Gunslinger
	]
	MaxAmmoTable = {
		[TF_CLASS_SCOUT] = {
			["tf_weapon_scattergun"]            = 32,
			["tf_weapon_handgun_scout_primary"] = 32,
			["tf_weapon_soda_popper"]           = 32,
			["tf_weapon_pep_brawler_blaster"]   = 32,

			["tf_weapon_handgun_scout_secondary"] = 36,
			["tf_weapon_pistol"]                  = 36,
		},
		[TF_CLASS_SOLDIER] = {
			["tf_weapon_rocketlauncher"]           = 20,
			["tf_weapon_rocketlauncher_directhit"] = 20,
			["tf_weapon_rocketlauncher_airstrike"] = 20,
			[ID_ROCKET_JUMPER] = 60,

			["tf_weapon_shotgun_soldier"] = 32,
			["tf_weapon_shotgun"]         = 32,
		},
		[TF_CLASS_PYRO] = {
			["tf_weapon_flamethrower"]            = 200,
			["tf_weapon_rocketlauncher_fireball"] = 40,

			["tf_weapon_shotgun_pyro"] = 32,
			["tf_weapon_shotgun"]      = 32,
			["tf_weapon_flaregun"]     = 16,
		},
		[TF_CLASS_DEMOMAN] = {
			["tf_weapon_grenadelauncher"] = 16,
			["tf_weapon_cannon"]          = 16,

			["tf_weapon_pipebomblauncher"] = 24,
			[ID_STICKYBOMB_JUMPER] = 72,
		},
		[TF_CLASS_HEAVYWEAPONS] = {
			["tf_weapon_minigun"]     = 200,

			["tf_weapon_shotgun_hwg"] = 32,
			["tf_weapon_shotgun"]     = 32,
		},
		[TF_CLASS_ENGINEER] = {
			["tf_weapon_shotgun"]                 = 32,
			["tf_weapon_sentry_revenge"]          = 32,
			["tf_weapon_shotgun_building_rescue"] = 16,
			[ID_SHOTGUN_PRIMARY] = 32,

			["tf_weapon_pistol"] = 200,
		},
		[TF_CLASS_MEDIC] = {
			["tf_weapon_syringegun_medic"] = 150,
			["tf_weapon_crossbow"]         = 38,
		},
		[TF_CLASS_SNIPER] = {
			["tf_weapon_sniperrifle"]         = 25,
			["tf_weapon_sniperrifle_decap"]   = 25,
			["tf_weapon_sniperrifle_classic"] = 25,
			["tf_weapon_compound_bow"]        = 12,

			["tf_weapon_smg"]         = 75,
			["tf_weapon_charged_smg"] = 75,
		},
		[TF_CLASS_SPY] = {
			["tf_weapon_revolver"] = 24,
		},
	}

	ItemWhitelist = []
	ItemBlacklist = []

	ROMEVISION_MODELS = {

		[1] = ["models/workshop/player/items/scout/tw_scoutbot_armor/tw_scoutbot_armor.mdl", "models/workshop/player/items/scout/tw_scoutbot_hat/tw_scoutbot_hat.mdl"],
		[2] = ["models/workshop/player/items/sniper/tw_sniperbot_armor/tw_sniperbot_armor.mdl", "models/workshop/player/items/sniper/tw_sniperbot_helmet/tw_sniperbot_helmet.mdl"],
		[3] = ["models/workshop/player/items/soldier/tw_soldierbot_armor/tw_soldierbot_armor.mdl", "models/workshop/player/items/soldier/tw_soldierbot_helmet/tw_soldierbot_helmet.mdl"],
		[4] = ["models/workshop/player/items/demo/tw_demobot_armor/tw_demobot_armor.mdl", "models/workshop/player/items/demo/tw_demobot_helmet/tw_demobot_helmet.mdl", "models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"],
		[5] = ["models/workshop/player/items/medic/tw_medibot_chariot/tw_medibot_chariot.mdl", "models/workshop/player/items/medic/tw_medibot_hat/tw_medibot_hat.mdl"],
		[6] = ["models/workshop/player/items/heavy/tw_heavybot_armor/tw_heavybot_armor.mdl", "models/workshop/player/items/heavy/tw_heavybot_helmet/tw_heavybot_helmet.mdl"],
		[7] = ["models/workshop/player/items/pyro/tw_pyrobot_armor/tw_pyrobot_armor.mdl", "models/workshop/player/items/pyro/tw_pyrobot_helmet/tw_pyrobot_helmet.mdl"],
		[8] = ["models/workshop/player/items/spy/tw_spybot_armor/tw_spybot_armor.mdl", "models/workshop/player/items/spy/tw_spybot_hood/tw_spybot_hood.mdl"],
		[9] = ["models/workshop/player/items/engineer/tw_engineerbot_armor/tw_engineerbot_armor.mdl", "models/workshop/player/items/engineer/tw_engineerbot_helmet/tw_engineerbot_helmet.mdl"],

	}

	ROMEVISION_MODELINDEXES = []

	DeflectableProjectiles = {
		tf_projectile_arrow				   = 1 // Huntsman arrow, Rescue Ranger bolt
		tf_projectile_ball_ornament		   = 1 // Wrap Assassin
		tf_projectile_cleaver			   = 1 // Flying Guillotine
		tf_projectile_energy_ball		   = 1 // Cow Mangler charge shot
		tf_projectile_flare				   = 1 // Flare guns projectile
		tf_projectile_healing_bolt		   = 1 // Crusader's Crossbow
		tf_projectile_jar				   = 1 // Jarate
		tf_projectile_jar_gas			   = 1 // Gas Passer explosion
		tf_projectile_jar_milk			   = 1 // Mad Milk
		tf_projectile_lightningorb		   = 1 // Spell Variant from Short Circuit
		tf_projectile_mechanicalarmorb	   = 1 // Short Circuit energy ball
		tf_projectile_pipe				   = 1 // Grenade Launcher bomb
		tf_projectile_pipe_remote		   = 1 // Stickybomb Launcher bomb
		tf_projectile_rocket				   = 1 // Rocket Launcher rocket
		tf_projectile_sentryrocket		   = 1 // Sentry gun rocket
		tf_projectile_stun_ball			   = 1 // Baseball
	}
	HomingProjectiles = {
		tf_projectile_arrow				= 1
		tf_projectile_energy_ball		= 1 // Cow Mangler
		tf_projectile_healing_bolt		= 1 // Crusader's Crossbow, Rescue Ranger
		tf_projectile_lightningorb		= 1 // Lightning Orb Spell
		tf_projectile_mechanicalarmorb	= 1 // Short Circuit
		tf_projectile_rocket				= 1
		tf_projectile_sentryrocket		= 1
		tf_projectile_spellfireball		= 1
		tf_projectile_energy_ring		= 1 // Bison
		tf_projectile_flare				= 1
	}

	GameRules = FindByClassname(null, "tf_gamerules")
	ObjectiveResource = FindByClassname(null, "tf_objective_resource")
	MonsterResource = FindByClassname(null, "monster_resource")
	MvMLogicEnt = FindByClassname(null, "tf_logic_mann_vs_machine")
	MvMStatsEnt = FindByClassname(null, "tf_mann_vs_machine_stats")
	PlayerManager = FindByClassname(null, "tf_player_manager")
	Worldspawn = FindByClassname(null, "worldspawn")
	StartRelay = FindByName(null, "wave_start_relay")
	FinishedRelay = FindByName(null, "wave_finished_relay")
	TriggerHurt = CreateByClassname("trigger_hurt")

	CurrentWaveNum = GetPropInt(FindByClassname(null, "tf_objective_resource"), "m_nMannVsMachineWaveCount")

	ClientCommand = SpawnEntityFromTable("point_clientcommand", {targetname = "_clientcommand"})
	GameRoundWin = SpawnEntityFromTable("game_round_win", {targetname = "__utilroundwin", TeamNum = TF_TEAM_PVE_INVADERS, force_map_reset = 1})
	RespawnOverride = SpawnEntityFromTable("trigger_player_respawn_override", {spawnflags = SF_TRIGGER_ALLOW_CLIENTS})

	function IsLinuxServer() {
		return RAND_MAX != 32767
	}

	function ShowMessage(message) {
		ClientPrint(null, HUD_PRINTCENTER , message)
	}

	function ForceChangeClass(player, classindex = 1)
	{
		player.SetPlayerClass(classindex);
		SetPropInt(player, "m_Shared.m_iDesiredPlayerClass", classindex);
		player.ForceRegenerateAndRespawn();
	}

	function PlayerClassCount()
	{
		local classes = array(TF_CLASS_COUNT_ALL, 0)
		foreach (player in this.HumanArray)
			++classes[player.GetPlayerClass()]
		return classes
	}

	function ChangePlayerTeamMvM(player, teamnum = TF_TEAM_PVE_INVADERS)
	{
		if (this.GameRules) {
			SetPropBool(this.GameRules, "m_bPlayingMannVsMachine", false);
			player.ForceChangeTeam(teamnum, false);
			SetPropBool(this.GameRules, "m_bPlayingMannVsMachine", true);
		}
	}

	function ShowChatMessage(target, fmt, ...) {
		local result = "\x07FFCC22[Map] "
		local start = 0
		local end = fmt.find("{")
		local i = 0
		while (end != null) {
			result += fmt.slice(start, end)
			start = end + 1
			end = fmt.find("}", start)
			if (end == null)
				break
			local word = fmt.slice(start, end)

			if (word == "player") {
				local player = vargv[i++]

				local team = player.GetTeam()
				if (team == TF_TEAM_RED)
					result += "\x07" + TF_COLOR_RED
				else if (team == TF_TEAM_BLUE)
					result += "\x07" + TF_COLOR_BLUE
				else
					result += "\x07" + TF_COLOR_SPEC
				result += GetPlayerName(player)
			}
			else if (word == "color") {
				result += "\x07" + vargv[i++]
			}
			else if (word == "int" || word == "float") {
				result += vargv[i++].tostring()
			}
			else if (word == "str") {
				result += vargv[i++]
			}
			else {
				result += "{" + word + "}"
			}

			start = end + 1
			end = fmt.find("{", start)
		}

		result += fmt.slice(start)

		ClientPrint(target, HUD_PRINTTALK, result)
	}

	// example
	// ChatPrint(null, "{player} {color}guessed the answer first!", player, TF_COLOR_DEFAULT)
	function CopyTable(table) {
		if (table == null) return
		local newtable = {}
		foreach (key, value in table)
		{
			newtable[key] <- value
			if (typeof(value) == "table" || typeof(value) == "array")
			{
				newtable[key] = CopyTable(value)
			}
			else
			{
				newtable[key] <- value
			}
		}
		return newtable
	}

	function HexToRgb(hex) {

		// Extract the RGB values
		local r = hex.slice(0, 2).tointeger(16)
		local g = hex.slice(2, 4).tointeger(16)
		local b = hex.slice(4, 6).tointeger(16)

		// Return the RGB values as an array
		return [r, g, b]
	}
	function CountAlivePlayers(printout = false)
	{
		if (!this.IsWaveStarted) return

		local playersalive = 0

		foreach (player in this.HumanArray)
		{
			if (this.IsAlive(player))
				playersalive++
		}

		if (printout)
		{
			ClientPrint(null, HUD_PRINTTALK, format("Players Alive: %d", playersalive))
			printf("Players Alive: %d\n", playersalive)
		}

		return playersalive
	}
	function CountAliveBots(printout = false)
	{
		if (!this.IsWaveStarted) return

		local botsalive = 0

		foreach (bot in this.BotArray)
		{
			if (this.IsAlive(bot))
				botsalive++
		}

		if (printout)
		{
			ClientPrint(null, HUD_PRINTTALK, format("Bots Alive: %d", botsalive))
			printf("Bots Alive: %d\n", botsalive)
		}

		return botsalive
	}
	function SetParentLocalOriginDo(child, parent, attachment = null) {
		SetPropEntity(child, "m_hMovePeer", parent.FirstMoveChild())
		SetPropEntity(parent, "m_hMoveChild", child)
		SetPropEntity(child, "m_hMoveParent", parent)

		local origPos = child.GetLocalOrigin()
		child.SetLocalOrigin(origPos + Vector(0, 0, 1))
		child.SetLocalOrigin(origPos)

		local origAngles = child.GetLocalAngles()
		child.SetLocalAngles(origAngles + QAngle(0, 0, 1))
		child.SetLocalAngles(origAngles)

		local origVel = child.GetVelocity()
		child.SetAbsVelocity(origVel + Vector(0, 0, 1))
		child.SetAbsVelocity(origVel)

		EntFireByHandle(child, "SetParent", "!activator", 0, parent, parent)
		if (attachment != null) {
			SetPropEntity(child, "m_iParentAttachment", parent.LookupAttachment(attachment))
			EntFireByHandle(child, "SetParentAttachmentMaintainOffset", attachment, 0, parent, parent)
		}
	}

	// Sets parent immediately in a dirty way. Does not retain absolute origin, retains local origin instead.
	// child parameter may also be an array of entities
	function SetParentLocalOrigin(child, parent, attachment = null) {
		if (typeof child == "array")
			foreach(i, childIn in child)
				this.SetParentLocalOriginDo(childIn, parent, attachment)
		else
			this.SetParentLocalOriginDo(child, parent, attachment)
	}

	// Setup collision bounds of a trigger entity
	function SetupTriggerBounds(trigger, mins = null, maxs = null) {
		trigger.SetModel("models/weapons/w_models/w_rocket.mdl")

		if (mins != null) {
			SetPropVector(trigger, "m_Collision.m_vecMinsPreScaled", mins)
			SetPropVector(trigger, "m_Collision.m_vecMins", mins)
		}
		if (maxs != null) {
			SetPropVector(trigger, "m_Collision.m_vecMaxsPreScaled", maxs)
			SetPropVector(trigger, "m_Collision.m_vecMaxs", maxs)
		}

		trigger.SetSolid(SOLID_BBOX)
	}

	function PrintTable(table) {
		if (table == null) return;

		this.DoPrintTable(table, 0)
	}

	function DoPrintTable(table, indent) {
		local line = ""
		for (local i = 0; i < indent; i++) {
			line += " "
		}
		line += typeof table == "array" ? "[" : "{";

		ClientPrint(null, 2, line)

		indent += 2
		foreach(k, v in table) {
			line = ""
			for (local i = 0; i < indent; i++) {
				line += " "
			}
			line += k.tostring()
			line += " = "

			if (typeof v == "table" || typeof v == "array") {
				ClientPrint(null, 2, line)
				this.DoPrintTable(v, indent)
			}
			else {
				try {
					line += v.tostring()
				}
				catch (e) {
					line += typeof v
				}

				ClientPrint(null, 2, line)
			}
		}
		indent -= 2

		line = ""
		for (local i = 0; i < indent; i++) {
			line += " "
		}
		line += typeof table == "array" ? "]" : "}";

		ClientPrint(null, 2, line)
	}

	// Make a wearable that is attached to the player. The wearable is automatically removed when the owner is killed or respawned
	function CreatePlayerWearable(player, model, bonemerge = true, attachment = null, autoDestroy = true) {
		local modelIndex = GetModelIndex(model)
		if (modelIndex == -1)
			modelIndex = PrecacheModel(model)

		local wearable = CreateByClassname("tf_wearable")
		SetPropInt(wearable, "m_nModelIndex", modelIndex)
		wearable.SetSkin(player.GetTeam())
		wearable.SetTeam(player.GetTeam())
		wearable.SetSolidFlags(4)
		wearable.SetCollisionGroup(11)
		SetPropBool(wearable, "m_bValidatedAttachedEntity", true)
		SetPropBool(wearable, "m_AttributeManager.m_Item.m_bInitialized", true)
		SetPropInt(wearable, "m_AttributeManager.m_Item.m_iEntityQuality", 0)
		SetPropInt(wearable, "m_AttributeManager.m_Item.m_iEntityLevel", 1)
		SetPropInt(wearable, "m_AttributeManager.m_Item.m_iItemIDLow", 2048)
		SetPropInt(wearable, "m_AttributeManager.m_Item.m_iItemIDHigh", 0)

		wearable.SetOwner(player)
		DispatchSpawn(wearable)
		SetPropInt(wearable, "m_fEffects", bonemerge ? EF_BONEMERGE|EF_BONEMERGE_FASTCULL : 0)
		this.SetParentLocalOrigin(wearable, player, attachment)

		player.ValidateScriptScope()
		local scope = player.GetScriptScope()
		if (autoDestroy) {
			if (!("popWearablesToDestroy" in scope))
				scope.popWearablesToDestroy <- []

			scope.popWearablesToDestroy.append(wearable)
		}
		return wearable
	}

	function StripWeapon(player, slot = -1)
	{
		if (slot == -1) slot = player.GetActiveWeapon().GetSlot()

		for (local i = 0; i < SLOT_COUNT; i++)
		{
			local weapon = this.GetItemInSlot(player, i);

			if (weapon == null || weapon.GetSlot() != slot) continue;

			weapon.Kill();
			break;
		}
	}


	// TODO: rework this boosted ass shit
	function SetPlayerAttributes(player, attrib, value, item = null)
	{
		local items = {}
		//setting maxhealth attribs doesn't update current HP
		local healthattribs = {
			"max health additive bonus" : null,
			"max health additive penalty": null,
			"SET BONUS: max health additive bonus": null,
			"hidden maxhealth non buffed": null,
		}

		//some attributes require special handling of their values
		local specialattribs = {

			"paintkit_proto_def_index" : function() {
				value = casti2f(value.tointeger())
			}
		}
		if (attrib in specialattribs) specialattribs[attrib]()

		if (item)
			items[this.HasItemInLoadout(player, item)] <- [attrib, value]
		else
			for (local i = 0; i < GetPropArraySize(player, "m_hMyWeapons"); i++)
				if (GetPropEntityArray(player, "m_hMyWeapons", i))
					items[GetPropEntityArray(player, "m_hMyWeapons", i)] <- [attrib, value]

		// printl(this.HasItemInLoadout(player, item))
		//do the customattributes check first, since we replace some vanilla attributes
		if (attrib in CustomAttributes.Attrs)
			CustomAttributes.AddAttr(player, attrib, value, items)

		else if ("Attributes" in PopExtItems && attrib in PopExtItems.Attributes)
		{
			if ("attribute_type" in PopExtItems.Attributes[attrib] && PopExtItems.Attributes[attrib]["attribute_type"] == "string")
				MissionAttributes.RaiseValueError("PlayerAttributes", attrib, "Cannot set string attributes!")
			else
			{

				if (!item)
					player.AddCustomAttribute(attrib, value.tofloat(), -1)
				// else if ("CustomWeapons" in player.GetScriptScope() && item in player.GetScriptScope().CustomWeapons)
				else
				{
					item.AddAttribute(attrib, value.tofloat(), -1)
					item.ReapplyProvision()
				}
				// else
					// EntFireByHandle(item, "RunScriptCode", format("self.AddAttribute(`%s`, %1.8e, -1); self.ReapplyProvision()", attrib, value.tofloat()), -1, null, null)

				if (attrib in healthattribs) EntFireByHandle(player, "RunScriptCode", "self.SetHealth(self.GetMaxHealth())", -1, null, null)
			}
			//add hidden attributes to our custom attribute display
			if ("hidden" in PopExtItems.Attributes[attrib] && PopExtItems.Attributes[attrib]["hidden"] == "1" && "ShowHiddenAttributes" in MissionAttributes.CurAttrs && MissionAttributes.CurAttrs.ShowHiddenAttributes)
			{
				local scope = player.GetScriptScope()
				if (!("attribinfo" in scope)) scope.attribinfo <- {}

				scope.attribinfo[attrib] <- format("%s: %s" attrib, value.tostring())
				CustomAttributes.RefreshDescs(player)
			}
		}
	}

	function WeaponSwitchSlot(player, slot)
	{
		 EntFireByHandle(this.ClientCommand, "Command", format("slot%d", slot + 1), -1, player, player);
	}

	function Explanation(message, printColor = COLOR_YELLOW, messagePrefix = "Explanation: ", syncChatWithGameText = false, textPrintTime = -1, textScanTime = 0.02) {
		local rgb = this.HexToRgb("FFFF66")
		local txtent = SpawnEntityFromTable("game_text", {
			effect = 2,
			spawnflags = SF_ENVTEXT_ALLPLAYERS,
			color = format("%d %d %d", rgb[0], rgb[1], rgb[2]),
			color2 = "255 254 255",
			fxtime = 0.02,
			// holdtime = 5,
			fadeout = 0.01,
			fadein = 0.01,
			channel = 3,
			x = 0.3,
			y = 0.3
		})
		SetPropBool(txtent, "m_bForcePurgeFixedupStrings", true)
		SetTargetname(txtent, format("__utilExplanationText%d",txtent.entindex()))
		local strarray = []

		//avoid needing to do a ton of function calls for multiple announcements.
		local newlines = split(message, "|")

		foreach (n in newlines)
			if (n.len() > 0) {
				strarray.append(n)
				if (!startswith(n, "PAUSE") && !syncChatWithGameText)
					ClientPrint(null, 3, format("\x07%s %s\x07%s %s", printColor, messagePrefix, TF_COLOR_DEFAULT, n))
			}

		local i = -1
		local textcooldown = 0
		function ExplanationTextThink() {
			if (textcooldown > Time()) return

			i++
			if (i == strarray.len()) {
				SetPropString(txtent, "m_iszScriptThinkFunction", "")

			//	  DoEntFire("!activator", "SetScriptOverlayMaterial", "", -1, player, player)

				// foreach (player in this.HumanArray) DoEntFire("command", "Command", "r_screenoverlay vgui/pauling_text", -1, player, player)

				SetPropString(txtent, "m_iszMessage", "")
				EntFireByHandle(txtent, "Display", "", -1, null, null)
				EntFireByHandle(txtent, "Kill", "", 0.1, null, null)
				return
			}
			local s = strarray[i]

			//make text display slightly longer depending on string length
			local delaybetweendisplays = textPrintTime
			if (delaybetweendisplays == -1) {
				delaybetweendisplays = s.len() / 10
				if (delaybetweendisplays < 2) delaybetweendisplays = 2; else if (delaybetweendisplays > 12) delaybetweendisplays = 12
			}

			//allow for pauses in the announcement
			if (startswith(s, "PAUSE")) {
				local pause = split(s, " ")[1].tofloat()
			//	  DoEntFire("player", "SetScriptOverlayMaterial", "", -1, player, player)
				SetPropString(txtent, "m_iszMessage", "")

				SetPropInt(txtent, "m_textParms.holdTime", pause)
				txtent.KeyValueFromInt("holdtime", pause)

				EntFireByHandle(txtent, "Display", "", -1, null, null)

				textcooldown = Time() + pause
				return 0.033
			}

			//shits fucked
			function calculate_x(string) {
				local len = string.len()
				local t = 1 - (len.tofloat() / 48)
				local x = 1 * (1 - t)
				x = (1 - (x / 3)) / 2.1
				// if (x > 0.5) x = 0.5 else if (x < 0.28) x = 0.28
				return x
			}

			SetPropFloat(txtent, "m_textParms.x", calculate_x(s))
			txtent.KeyValueFromFloat("x", calculate_x(s))

			SetPropString(txtent, "m_iszMessage", s)

			SetPropInt(txtent, "m_textParms.holdTime", delaybetweendisplays)
			txtent.KeyValueFromInt("holdtime", delaybetweendisplays)

			EntFireByHandle(txtent, "Display", "", -1, null, null)
			if (syncChatWithGameText) ClientPrint(null, 3, format("\x07%s %s\x07%s %s", COLOR_YELLOW, messagePrefix, TF_COLOR_DEFAULT, s))

			textcooldown = Time() + delaybetweendisplays

			return 0.033
	   }
	   txtent.ValidateScriptScope()
	   txtent.GetScriptScope().ExplanationTextThink <- ExplanationTextThink
	   AddThinkToEnt(txtent, "ExplanationTextThink")
	}

	function Explanation(message, printColor = COLOR_YELLOW, messagePrefix = "Explanation: ", syncChatWithGameText = false, textPrintTime = -1, textScanTime = 0.02) {
		Explanation.call(PopExtUtil, message, printColor, messagePrefix, syncChatWithGameText, textPrintTime, textScanTime)
	}

	function Info(message, printColor = COLOR_YELLOW, messagePrefix = "Explanation: ", syncChatWithGameText = false, textPrintTime = -1, textScanTime = 0.02) {
		Explanation.call(PopExtUtil, message, printColor, messagePrefix, syncChatWithGameText, textPrintTime, textScanTime)
	}

	function IsAlive(player) {
		return GetPropInt(player, "m_lifeState") == 0
	}

	function IsDucking(player) {
		return player.GetFlags() & FL_DUCKING
	}

	function IsOnGround(player) {
		return player.GetFlags() & FL_ONGROUND
	}

	function RemoveAmmo(player) {
		for ( local i = 0; i < 32; i++ ) {
			SetPropIntArray(player, "m_iAmmo", 0, i)
		}
	}
	function GetAllEnts() {
		local entdata = { "entlist": [], "numents": 0 }
		for (local i = MAX_CLIENTS, ent; i <= MAX_EDICTS; i++) {
			if (ent = EntIndexToHScript(i)) {
				entdata.numents++
				entdata.entlist.append(ent)
			}
		}
		return entdata
	}

	//sets m_hOwnerEntity and m_hOwner to the same value
	function _SetOwner(ent, owner) {
		//incase we run into an ent that for some reason uses both of these netprops for two different entities
		if (ent.GetOwner() != null && GetPropEntity(ent, "m_hOwnerEntity") != null && ent.GetOwner() != GetPropEntity(ent, "m_hOwnerEntity")) {
			ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
			ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
			ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
			ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
			ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
		}
		ent.SetOwner(owner)
		SetPropEntity(ent, "m_hOwnerEntity", owner)
	}

	function ShowAnnotation(args = {text = "This is an annotation", lifetime = 10, pos = Vector(), id = 0, distance = true, sound = "misc/null.wav", entindex = 0, visbit = 0, effect = true}) {
		SendGlobalGameEvent("show_annotation", {
			text = args.text
			lifetime = args.lifetime
			worldPosX = args.pos.x
			worldPosY = args.pos.y
			worldPosZ = args.pos.z
			id = args.id
			play_sound = args.sound
			show_distance = args.distance
			show_effect = args.effect
			follow_entindex = args.entindex
			visibilityBitfield = args.visbit
		})
	}

	//This may not be necessary and hide_annotation may work, but whatever this works too.
	function HideAnnotation(id) { ShowAnnotation("", 0.0000001, Vector(), id = id) }

	function GetPlayerName(player) {
		return GetPropString(player, "m_szNetname")
	}

	function SetPlayerName(player,	name) {
		return SetPropString(player, "m_szNetname", name)
	}

	function GetPlayerUserID(player) {
		return GetPropIntArray(this.PlayerManager, "m_iUserID", player.entindex()) //TODO replace PlayerManager with the actual entity name
	}

	function PlayerRespawn() {
		self.ForceRegenerateAndRespawn()
	}

	function DisableCloak(player) {
		// High Number to Prevent Player from Cloaking
		SetPropFloat(player, "m_Shared.m_flStealthNextChangeTime", Time() * INT_MAX)
	}

	function InUpgradeZone(player) {
		return GetPropBool(player, "m_Shared.m_bInUpgradeZone")
	}

	function InButton(player, button) {
		return (GetPropInt(player, "m_nButtons") & button)
	}

	function PressButton(player, button) {
		SetPropInt(player, "m_afButtonForced", GetPropInt(player, "m_afButtonForced") | button); SetPropInt(player, "m_nButtons", GetPropInt(player, "m_nButtons") | button)
	}
	function ReleaseButton(player, button) {
		SetPropInt(player, "m_afButtonForced", GetPropInt(player, "m_afButtonForced") & ~button); SetPropInt(player, "m_nButtons", GetPropInt(player, "m_nButtons") & ~button)
	}

	function IsPointInRespawnRoom(point)
	{
		local triggers = []
		for (local trigger; trigger = FindByClassname(trigger, "func_respawnroom");)
		{
			trigger.SetCollisionGroup(0)
			trigger.RemoveSolidFlags(4) // FSOLID_NOT_SOLID
			triggers.append(trigger)
		}

		local trace =
		{
			start = point,
			end = point,
			mask = 0
		}
		TraceLineEx(trace)

		foreach (trigger in triggers)
		{
			trigger.SetCollisionGroup(25) // special collision group used by respawnrooms only
			trigger.AddSolidFlags(4) // FSOLID_NOT_SOLID
		}

		return trace.hit && trace.enthit.GetClassname() == "func_respawnroom"
	}


	//assumes user is using the SLOT_ constants
	function SwitchWeaponSlot(player, slot) {
		EntFireByHandle(ClientCommand, "Command", format("slot%d", slot + 1), -1, player, player)
	}

	function GetItemInSlot(player, slot) {
		local item
		for (local i = 0; i < SLOT_COUNT; i++) {
			local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
			if ( wep == null || wep.GetSlot() != slot) continue

			item = wep
			break
		}
		return item
	}

	function SwitchToFirstValidWeapon(player) {
		for (local i = 0; i < SLOT_COUNT; i++) {
			local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
			if ( wep == null) continue

			player.Weapon_Switch(wep)
			return wep
		}
	}

	function HasEffect(ent, value) {
		return GetPropInt(ent, "m_fEffects") == value
	}

	function SetEffect(ent, value) {
		SetPropInt(ent, "m_fEffects", value)
	}

	function PlayerRobotModel(player, model) {
		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		local wearable = CreateByClassname("tf_wearable")
		SetPropString(wearable, "m_iName", "__bot_bonemerge_model")
		SetPropInt(wearable, "m_nModelIndex", PrecacheModel(model))
		SetPropBool(wearable, "m_bValidatedAttachedEntity", true)
		SetPropBool(wearable, STRING_NETPROP_ITEMDEF, true)
		SetPropEntity(wearable, "m_hOwnerEntity", player)
		wearable.SetTeam(player.GetTeam())
		wearable.SetOwner(player)
		DispatchSpawn(wearable)
		EntFireByHandle(wearable, "SetParent", "!activator", -1, player, player)
		SetPropInt(wearable, "m_fEffects", EF_BONEMERGE|EF_BONEMERGE_FASTCULL)
		scope.wearable <- wearable

		SetPropInt(player, "m_nRenderMode", kRenderTransColor)
		SetPropInt(player, "m_clrRender", 0)

		scope.PlayerThinkTable.BotModelThink <- function() {
			if (wearable.IsValid() && (player.IsTaunting() || wearable.GetMoveParent() != player))
				EntFireByHandle(wearable, "SetParent", "!activator", -1, player, player)
			return -1
		}
	}

	function HasItemInLoadout(player, index) {
		local t = null

		for (local child = player.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
			if (child.GetClassname() == index || child == index || this.GetItemIndex(child) == index || (index in PopExtItems && this.GetItemIndex(child) == PopExtItems[index].id)) {
				t = child
				break
			}
		}

		if (t != null) return t

		//didn't find weapon in children, go through m_hMyWeapons instead
		for (local i = 0; i < SLOT_COUNT; i++) {
			local wep = GetPropEntityArray(player, "m_hMyWeapons", i)

			if (wep == null || wep.GetClassname() != index || wep != index || this.GetItemIndex(wep) != index || (index in PopExtItems && this.GetItemIndex(wep) == PopExtItems[index].id)) continue

			t = wep
			break
		}
		return t
	}

	function StunPlayer(player, duration = 5, type = 1, delay = 0, speedreduce = 0.5) {

		// CreateByClassname is significantly faster than SpawnEntityFromTable

		// local utilstun = SpawnEntityFromTable("trigger_stun", {
		// 	targetname = "__utilstun"
		// 	stun_type = type
		// 	stun_duration = duration
		// 	move_speed_reduction = speedreduce
		// 	trigger_delay = delay
		// 	StartDisabled = 0
		// 	spawnflags = SF_TRIGGER_ALLOW_CLIENTS
		// })

		local utilstun = CreateByClassname("trigger_stun")

		utilstun.KeyValueFromString("targetname", "__utilstun")
		utilstun.KeyValueFromInt("stun_type", type)
		utilstun.KeyValueFromFloat("stun_duration", duration.tofloat())
		utilstun.KeyValueFromFloat("move_speed_reduction", speedreduce.tofloat())
		utilstun.KeyValueFromFloat("trigger_delay", delay.tofloat())
		utilstun.KeyValueFromInt("spawnflags", SF_TRIGGER_ALLOW_CLIENTS)

		DispatchSpawn(utilstun)

		EntFireByHandle(utilstun, "EndTouch", "", -1, player, player)
	}

	function Ignite(player, duration = 10.0, damage = 1)
	{
		local utilignite = FindByName(null, "__utilignite")
		if (utilignite == null)
		{
			utilignite = SpawnEntityFromTable("trigger_ignite", {
				targetname = "__utilignite"
				burn_duration = duration
				damage = damage
				spawnflags = SF_TRIGGER_ALLOW_CLIENTS
			})
		}
		EntFireByHandle(utilignite, "StartTouch", "", -1, player, player)
		EntFireByHandle(utilignite, "EndTouch", "", SINGLE_TICK, player, player)
	}

	function ShowHudHint(text = "This is a hud hint", player = null, duration = 5.0) {
		local hudhint = FindByName(null, "__utilhudhint")

		local flags = (player == null) ? 1 : 0

		if (!hudhint) hudhint = SpawnEntityFromTable("env_hudhint", { targetname = "__utilhudhint", spawnflags = flags, message = text })

		hudhint.KeyValueFromString("message", text)

		EntFireByHandle(hudhint, "ShowHudHint", "", -1, player, player)
		EntFireByHandle(hudhint, "HideHudHint", "", duration, player, player)
	}

	function SetEntityColor(entity, r, g, b, a) {
		local color = (r) | (g << 8) | (b << 16) | (a << 24)
		SetPropInt(entity, "m_clrRender", color)
	}

	function GetEntityColor(entity) {
		local color = GetPropInt(entity, "m_clrRender")
		local clr = {}
		clr.r <- color & 0xFF
		clr.g <- (color >> 8) & 0xFF
		clr.b <- (color >> 16) & 0xFF
		clr.a <- (color >> 24) & 0xFF
		return clr
	}

	function AddAttributeToLoadout(player, attribute, value, duration = -1) {
		for (local i = 0; i < SLOT_COUNT; i++) {

			local wep = GetPropEntityArray(player, "m_hMyWeapons", i)

			if (wep == null) continue

			wep.AddAttribute(attribute, value, duration)
			wep.ReapplyProvision()
		}
	}

	function ShowModelToPlayer(player, model = ["models/player/heavy.mdl", 0], pos = Vector(), ang = QAngle(), duration = INT_MAX) {
		PrecacheModel(model[0])
		local proxy_entity = CreateByClassname("obj_teleporter") // use obj_teleporter to set bodygroups.  not using SpawnEntityFromTable as that creates spawning noises
		proxy_entity.SetAbsOrigin(pos)
		proxy_entity.SetAbsAngles(ang)
		DispatchSpawn(proxy_entity)

		proxy_entity.SetModel(model[0])
		proxy_entity.SetSkin(model[1])
		proxy_entity.AddEFlags(EFL_NO_THINK_FUNCTION) // EFL_NO_THINK_function prevents the entity from disappearing
		proxy_entity.SetSolid(SOLID_NONE)

		SetPropBool(proxy_entity, "m_bPlacing", true)
		SetPropInt(proxy_entity, "m_fObjectFlags", OF_MUST_BE_BUILT_ON_ATTACHMENT) // sets "attachment" flag, prevents entity being snapped to player feet

		// m_hBuilder is the player who the entity will be networked to only
		SetPropEntity(proxy_entity, "m_hBuilder", player)
		EntFireByHandle(proxy_entity, "Kill", "", duration, player, player)
		return proxy_entity
	}


	function LockInPlace(player, enable = true) {
		if (enable) {
			player.AddFlag(FL_ATCONTROLS)
			player.AddCustomAttribute("no_jump", 1, -1)
			player.AddCustomAttribute("no_duck", 1, -1)
			player.AddCustomAttribute("no_attack", 1, -1)
			player.AddCustomAttribute("disable weapon switch", 1, -1)

		}
		else {
			player.RemoveFlag(FL_ATCONTROLS)
			player.RemoveCustomAttribute("no_jump")
			player.RemoveCustomAttribute("no_duck")
			player.RemoveCustomAttribute("no_attack")
			player.RemoveCustomAttribute("disable weapon switch")
		}
	}

	function GetItemIndex(item) {
		return GetPropInt(item, STRING_NETPROP_ITEMDEF)
	}

	function SetItemIndex(item, index) {
		SetPropInt(item, STRING_NETPROP_ITEMDEF, index)
	}

	function SetTargetname(ent, name) {
		SetPropString(ent, "m_iName", name)
	}

	function GetPlayerSteamID(player) {
		return GetPropString(player, "m_szNetworkIDString")
	}

	function GetHammerID(ent) {
		return GetPropInt(ent, "m_iHammerID")
	}

	function GetSpawnFlags(ent) {
		return GetPropInt(self, "m_spawnflags")
	}

	function GetPopfileName() {
		return GetPropString(this.ObjectiveResource, "m_iszMvMPopfileName")
	}

	function PrecacheParticle(name) {
		PrecacheEntityFromTable({ classname = "info_particle_system", effect_name = name })
	}


	function SpawnEffect(player,  effect) {
		local player_angle	   =  player.GetLocalAngles()
		local player_angle_vec =  Vector( player_angle.x, player_angle.y, player_angle.z)

		DispatchParticleEffect(effect, player.GetLocalOrigin(), player_angle_vec)
		return
	}

	function RemoveOutputAll(ent, output) {
		local outputs = []
		for (local i = GetNumElements(ent, output); i >= 0; i--) {
			local t = {}
			GetOutputTable(ent, output, t, i)
			outputs.append(t)
		}
		foreach (o in outputs) foreach(_ in o) RemoveOutput(ent, output, o.target, o.input, o.parameter)
	}

	function RemovePlayerWearables(player) {
		for (local wearable = player.FirstMoveChild(); wearable != null; wearable = wearable.NextMovePeer()) {
			if (wearable.GetClassname() == "tf_wearable")
				wearable.Destroy()
		}
		return
	}

	function GiveWeapon(player, className, itemID)
	{
		if (typeof itemID == "string" && className == "tf_wearable")
		{
			CTFBot.GenerateAndWearItem.call(player, itemID)
			return
		}
		local weapon = CreateByClassname(className)
		SetPropInt(weapon, STRING_NETPROP_ITEMDEF, itemID)
		SetPropBool(weapon, "m_AttributeManager.m_Item.m_bInitialized", true)
		SetPropBool(weapon, "m_bValidatedAttachedEntity", true)
		weapon.SetTeam(player.GetTeam())
		DispatchSpawn(weapon)

		// remove existing weapon in same slot
		for (local i = 0; i < SLOT_COUNT; i++)
		{
			local heldWeapon = GetPropEntityArray(player, "m_hMyWeapons", i)
			if (heldWeapon == null || heldWeapon.GetSlot() != weapon.GetSlot())
				continue
			heldWeapon.Destroy()
			SetPropEntityArray(player, "m_hMyWeapons", null, i)
			break
		}

		player.Weapon_Equip(weapon)
		player.Weapon_Switch(weapon)

		return weapon
	}

	function IsEntityClassnameInList(entity, list) {
		local classname = entity.GetClassname()
		local listType = typeof(list)

		switch (listType) {
			case "table":
				return (classname in list)

			case "array":
				return (list.find(classname) != null)

			default:
				printl("Error: list is neither an array nor a table.")
				return false
		}
	}

	function SetPlayerClassRespawnAndTeleport(player, playerclass, location_set = null) {
		local teleport_origin, teleport_angles, teleport_velocity

		if (!location_set)
			teleport_origin = player.GetOrigin()
		else
			teleport_origin = location_set
		teleport_angles = player.EyeAngles()
		teleport_velocity = player.GetAbsVelocity()
		SetPropInt(player, "m_Shared.m_iDesiredPlayerClass", playerclass)

		player.ForceRegenerateAndRespawn()

		player.Teleport(true, teleport_origin, true, teleport_angles, true, teleport_velocity)
	}

	function PlaySoundOnClient(player, name, volume = 1.0, pitch = 100) {
		EmitSoundEx( {
			sound_name = name,
			volume = volume
			pitch = pitch,
			entity = player,
			filter_type = RECIPIENT_FILTER_SINGLE_PLAYER
		})
	}

	function PlaySoundOnAllClients(name) {
		EmitSoundEx( {
			sound_name = name,
			filter_type = RECIPIENT_FILTER_GLOBAL
		})
	}



	// MATH

	function Min(a, b) {
		return (a <= b) ? a : b
	}

	function Max(a, b) {
		return (a >= b) ? a : b
	}

	function Round(num, decimals=0) {
		if (decimals <= 0)
			return floor(num + 0.5)

		local mod = pow(10, decimals)
		return floor((num * mod) + 0.5) / mod
	}

	function Clamp(x, a, b) {
		return Min(b, Max(a, x))
	}

	function RemapVal(v, A, B, C, D) {
		if (A == B) {
			if (v >= B)
				return D
			return C
		}
		return C + (D - C) * (v - A) / (B - A)
	}

	function RemapValClamped(v, A, B, C, D) {
		if (A == B) {
			if (v >= B)
				return D
			return C
		}
		local cv = (v - A) / (B - A)
		if (cv <= 0.0)
			return C
		if (cv >= 1.0)
			return D
		return C + (D - C) * cv
	}

	function IntersectionPointBox(pos, mins, maxs) {
		if (pos.x < mins.x || pos.x > maxs.x ||
			pos.y < mins.y || pos.y > maxs.y ||
			pos.z < mins.z || pos.z > maxs.z)
			return false

		return true
	}

	function NormalizeAngle(target) {
		target %= 360.0
		if (target > 180.0)
			target -= 360.0
		else if (target < -180.0)
			target += 360.0
		return target
	}

	function ApproachAngle(target, value, speed) {
		target = this.NormalizeAngle(target)
		value = this.NormalizeAngle(value)
		local delta = this.NormalizeAngle(target - value)
		if (delta > speed)
			return value + speed
		else if (delta < -speed)
			return value - speed
		return target
	}

	function VectorAngles(forward) {
		local yaw, pitch
		if ( forward.y == 0.0 && forward.x == 0.0 ) {
			yaw = 0.0
			if (forward.z > 0.0)
				pitch = 270.0
			else
				pitch = 90.0
		}
		else {
			yaw = (atan2(forward.y, forward.x) * 180.0 / Pi)
			if (yaw < 0.0)
				yaw += 360.0
			pitch = (atan2(-forward.z, forward.Length2D()) * 180.0 / Pi)
			if (pitch < 0.0)
				pitch += 360.0
		}

		return QAngle(pitch, yaw, 0.0)
	}

	function AnglesToVector(angles) {
		local pitch = angles.x * Pi / 180.0
		local yaw = angles.y * Pi / 180.0
		local x = cos(pitch) * cos(yaw)
		local y = cos(pitch) * sin(yaw)
		local z = sin(pitch)
		return Vector(x, y, z)
	}

	function QAngleDistance(a, b) {
	  local dx = a.x - b.x
	  local dy = a.y - b.y
	  local dz = a.z - b.z
	  return sqrt(dx*dx + dy*dy + dz*dz)
	}

	function CheckBitwise(num) {
		return (num != 0 && ((num & (num - 1)) == 0))
	}

	function StopAndPlayMVMSound(player, soundscript, delay) {
		player.ValidateScriptScope()
		local scope = player.GetScriptScope()
		scope.sound <- soundscript

		EntFireByHandle(player, "RunScriptCode", "self.StopSound(sound);", delay, null, null)

		local sound	   =  scope.sound
		local dotindex =  sound.find(".")
		if (dotindex == null) return

		scope.mvmsound <- sound.slice(0, dotindex+1) + "MVM_" + sound.slice(dotindex+1)

		EntFireByHandle(player, "RunScriptCode", "self.EmitSound(mvmsound);", delay + SINGLE_TICK, null, null)
	}

	function StringReplace(str, findwhat, replace) {
		local returnstring = ""
		local findwhatlen  = findwhat.len()
		local splitlist	   = [];

		local start = 0
		local previndex = 0
		while (start < str.len()) {
			local index = str.find(findwhat, start)
			if (index == null) {
				if (start < str.len() - 1)
					splitlist.append(str.slice(start))
				break
			}

			splitlist.append(str.slice(previndex, index))

			start = index + findwhatlen
			previndex = start
		}

		foreach (index, s in splitlist) {
			if (index < splitlist.len() - 1)
				returnstring += s + replace;
			else
				returnstring += s
		}

		return returnstring
	}

	// Python's string.capwords()
	function capwords(s, sep = null) {
		if (sep == null) sep = " ";
		local words = [];
		local start = 0;
		local end = s.find(sep);
		while (end != null) {
			words.push(s.slice(start, end));
			start = end + sep.len();
			end = s.find(sep, start);
		}
		words.push(s.slice(start));

		local result = [];
		foreach (word in words) {
			local firstChar = word.slice(0, 1).toupper();
			local restOfWord = word.slice(1);
			result.push(firstChar + restOfWord);
		}

		local finalResult = "";
		foreach (i, word in result) {
			if (i > 0) finalResult += sep;
			finalResult += word;
		}
		return finalResult;
	}

	function EndWaveReverse(doteamswitch = true)
	{
		local temp = CreateByClassname("info_teleport_destination")

		if (!this.IsWaveStarted) return

		//move to red
		if (doteamswitch)
			foreach (player in this.HumanArray)
				this.ChangePlayerTeamMvM(player, TF_TEAM_PVE_DEFENDERS)

		temp.ValidateScriptScope()
		temp.GetScriptScope().ClearWave <- function()
		{
			if (!this.IsWaveStarted) {

				if (doteamswitch)
					foreach (player in this.HumanArray)
						this.ChangePlayerTeamMvM(player, TF_TEAM_PVE_INVADERS)

				SetPropString(self, "m_iszScriptThinkFunction", "")
				EntFireByHandle(self, "Kill", "", -1, null, null)
			}
			//kill all bots
			foreach (bot in this.BotArray)
				if (this.IsAlive(bot) && bot.GetTeam() == TF_TEAM_PVE_DEFENDERS)
					this.KillPlayer(bot);
		}

		AddThinkToEnt(temp, "ClearWave")
	}

	function AddThinkToEnt(ent, func)
	{
		local scope = ent.GetScriptScope()
		local thinktable = ""

		if (ent.IsPlayer())
			thinktable = "PlayerThinkTable"

		else if ((ent.GetClassname() == "tank_boss"))
			thinktable = "TankThinkTable"

		else if (startswith(ent.GetClassname(), "tf_projectile"))
			thinktable = "ProjectileThinkTable"

		else if (HasProp(ent, "m_bValidatedAttachedEntity"))
			thinktable = "ItemThinkTable"
		else
			_AddThinkToEnt(ent, func)

		if (thinktable == "") return

		local thinkfunc
		if(func != null)
		{
			if(func in scope)
				thinkfunc = scope[func]
			else if(func in ROOT)
				thinkfunc = ROOT[func]
			else return
		}

		if (!(thinktable in scope)) scope[thinktable] <- {}

		func == null ? scope[thinktable].clear() : scope[format("%s", thinktable)][func] <- thinkfunc
	}


	function SilentDisguise(player, target = null, tfteam = TF_TEAM_PVE_INVADERS, tfclass = TF_CLASS_SCOUT) {
		if (player == null || !player.IsPlayer()) return

		function FindTargetPlayer(passcond) {
			local target = null
			for (local i = 1; i <= MAX_CLIENTS; i++) {
				local potentialtarget = PlayerInstanceFromIndex(i)
				if (potentialtarget == null || potentialtarget == player) continue

				if (passcond(potentialtarget)) {
					target = potentialtarget
					break
				}
			}
			return target
		}

		if (target == null) {
			// Find disguise target
			target = FindTargetPlayer(@(p) p.GetTeam() == tfteam && p.GetPlayerClass() == tfclass)
			// Couldn't find any targets of tfclass, look for any class this time
			if (target == null)
				target = FindTargetPlayer(@(p) p.GetTeam() == tfteam)
		}

		// Disguise as this player
		if (target != null) {
			SetPropInt(player, "m_Shared.m_nDisguiseTeam", target.GetTeam())
			SetPropInt(player, "m_Shared.m_nDisguiseClass", target.GetPlayerClass())
			SetPropInt(player, "m_Shared.m_iDisguiseHealth", target.GetHealth())
			SetPropEntity(player, "m_Shared.m_hDisguiseTarget", target)
			// When we drop our disguise, the player we disguised as gets this weapon removed for some reason
			//SetPropEntity(player, "m_Shared.m_hDisguiseWeapon", target.GetActiveWeapon())
		}
		// No valid targets, just give us a generic disguise
		else {
			SetPropInt(player, "m_Shared.m_nDisguiseTeam", tfteam)
			SetPropInt(player, "m_Shared.m_nDisguiseClass", tfclass)
		}

		player.AddCond(TF_COND_DISGUISED)

		// Hack to get our movespeed set correctly for our disguise
		player.AddCond(TF_COND_SPEED_BOOST)
		player.RemoveCond(TF_COND_SPEED_BOOST)
	}

	function GetPlayerReadyCount() {
		local roundtime = GetPropFloat(this.GameRules, "m_flRestartRoundTime")
		if (this.IsWaveStarted) return 0
		local ready = 0

		for (local i = 0; i < GetPropArraySize(this.GameRules, "m_bPlayerReady"); ++i) {
			if (!GetPropBoolArray(this.GameRules, "m_bPlayerReady", i)) continue
			++ready
		}

		return ready
	}

	function GetWeaponMaxAmmo(player, wep) {

		if (wep == null) return

		local slot      = wep.GetSlot()
		local classname = wep.GetClassname()
		local itemid    = this.GetItemIndex(wep)

		local table = this.MaxAmmoTable[player.GetPlayerClass()]

		if (!(itemid in table) && !(classname in table))
			return -1

		local base_max = (itemid in table) ? table[itemid] : table[classname]

		/*
		local mod = 1.0

		local incr
		local decr
		local hid
		if (slot == SLOT_PRIMARY) {
			incr = wep.GetAttribute("maxammo primary increased", 1.0)
			decr = wep.GetAttribute("maxammo primary reduced", 1.0)
			hid  = wep.GetAttribute("hidden primary max ammo bonus", 1.0)
		}
		else if (slot == SLOT_SECONDARY) {
			incr = wep.GetAttribute("maxammo secondary increased", 1.0)
			decr = wep.GetAttribute("maxammo secondary reduced", 1.0)
			hid  = wep.GetAttribute("hidden secondary max ammo penalty", 1.0)
		}

		mod *= incr * decr * hid
		return base_max * mod
		*/

		return base_max
	}

	function TeleportNearVictim(ent, victim, attempt) {

		if (victim == null)
			return false

		if (victim.GetLastKnownArea() == null)
			return

		const max_surround_travel_range = 6000.0

		local surround_travel_range = 1500.0 + 500.0 * attempt
		surround_travel_range = Max(surround_travel_range, max_surround_travel_range)

		local areas = {}
		GetNavAreasInRadius(victim.GetLastKnownArea().GetCenter(), surround_travel_range, areas)

		local ambush_areas = []

		foreach (name, area in areas) {
			if (!area.IsValidForWanderingPopulation())
				continue

			if (area.IsPotentiallyVisibleToTeam(victim.GetTeam()))
				continue

			ambush_areas.push(area)
		}

		if (ambush_areas.len() == 0)
			return false

		local max_tries = Min(10, ambush_areas.len())

		for (local retry = 0; retry < max_tries; ++retry) {
			local which = RandomInt(0, ambush_areas.len() - 1)
			local where = ambush_areas[which].GetCenter() + Vector(0, 0, STEP_HEIGHT)

			if (this.IsSpaceToSpawnHere(where, ent.GetBoundingMins(), ent.GetBoundingMaxs())) {
				ent.SetAbsOrigin(where)
				return true
			}
		}

		return false
	}

	function IsSpaceToSpawnHere(where, hullmin, hullmax) {

		local trace = {
			start = where,
			end = where,
			hullmin = hullmin,
			hullmax = hullmax,
			mask = MASK_PLAYERSOLID
		}
		TraceHull(trace)

		return trace.fraction >= 1.0
	}

	function ClearLastKnownArea(bot) {

		local trigger = SpawnEntityFromTable("trigger_remove_tf_player_condition", {
			spawnflags = SF_TRIGGER_ALLOW_CLIENTS,
			condition = TF_COND_TMPDAMAGEBONUS,
		})
		EntFireByHandle(trigger, "StartTouch", "!activator", -1, bot, bot)
		EntFireByHandle(trigger, "Kill", "", -1, null, null)
	}

	function KillPlayer(player) {
		player.TakeDamage(INT_MAX, 0, this.TriggerHurt);
	}

	function KillAllBots() {
		foreach (bot in this.BotArray)
			if (this.IsAlive(bot))
				this.KillPlayer(bot)
	}

	function SetDestroyCallback(entity, callback)
	{
		entity.ValidateScriptScope();
		local scope = entity.GetScriptScope();
		scope.setdelegate({}.setdelegate({
				parent   = scope.getdelegate()
				id       = entity.GetScriptId()
				index    = entity.entindex()
				callback = callback
				_get = function(k)
				{
					return parent[k];
				}
				_delslot = function(k)
				{
					if (k == id)
					{
						entity = EntIndexToHScript(index);
						local scope = entity.GetScriptScope();
						scope.self <- entity;
						callback.pcall(scope);
					}
					delete parent[k];
				}
			})
		);
	}

	Events = {

		function OnGameEvent_mvm_wave_complete(params) { PopExtUtil.IsWaveStarted = false }
		function OnGameEvent_mvm_wave_failed(params) { PopExtUtil.IsWaveStarted = false }
		function OnGameEvent_mvm_begin_wave(params) { PopExtUtil.IsWaveStarted = true }
		function OnGameEvent_mvm_reset_stats(params) { PopExtUtil.IsWaveStarted = true } //used for manually jumping waves

		function OnGameEvent_teamplay_round_start(params) {

			for (local i = 1; i <= MAX_CLIENTS; i++) {
				local player = PlayerInstanceFromIndex(i)

				// printl(player)

				if (player != null && player.IsBotOfType(TF_BOT_TYPE) && PopExtUtil.BotArray.find(player) == null)
					PopExtUtil.BotArray.append(player)

				else if (player != null && !player.IsBotOfType(TF_BOT_TYPE) && PopExtUtil.HumanArray.find(player) == null)
					PopExtUtil.HumanArray.append(player)

				if (player != null && PopExtUtil.PlayerArray.find(player) == null)
					PopExtUtil.PlayerArray.append(player)
			}
		}

		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)

			player.ValidateScriptScope()
			local scope = player.GetScriptScope()

			//sort weapons by slot
			local myweapons = {}
			for (local i = 0; i < SLOT_COUNT; i++) {

				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
				if (wep == null) continue

				myweapons[wep.GetSlot()] <- wep

				//add weapon think table while we're here

				wep.ValidateScriptScope()
				local scope = wep.GetScriptScope()

				scope.ItemThinkTable <- {}

				scope.ItemThinks <- function() { foreach (name, func in scope.ItemThinkTable) func.call(scope); return -1 }

				_AddThinkToEnt(wep, "ItemThinks")
			}

			for (local child = player.FirstMoveChild(); child != null; child = child.NextMovePeer())
			{
				child.ValidateScriptScope()
				local scope = child.GetScriptScope()
				if (!("ItemThinkTable" in scope)) scope.ItemThinkTable <- {}

				if(child.GetClassname() == "tf_wearable")
				{
					scope.ItemThinks <- function() { foreach (name, func in scope.ItemThinkTable) func.call(scope); return -1 }
					_AddThinkToEnt(child, "ItemThinks")
				}
			}
			foreach(slot, wep in myweapons)
			{
				local wep = GetPropEntityArray(player, "m_hMyWeapons", slot)

				SetPropEntityArray(player, "m_hMyWeapons", wep, slot)
			}

			if (player.IsBotOfType(TF_BOT_TYPE) && PopExtUtil.BotArray.find(player) == null)
				PopExtUtil.BotArray.append(player)

			else if (!player.IsBotOfType(TF_BOT_TYPE) && PopExtUtil.HumanArray.find(player) == null)
				PopExtUtil.HumanArray.append(player)

			if (PopExtUtil.PlayerArray.find(player) == null)
				PopExtUtil.PlayerArray.append(player)

		}

		function OnGameEvent_player_activate(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE) && PopExtUtil.HumanArray.find(player) == null)
				PopExtUtil.HumanArray.append(player)

			else if (PopExtUtil.PlayerArray.find(player) == null)
				PopExtUtil.PlayerArray.append(player)
		}

		function OnGameEvent_player_disconnect(params) {
			local player = GetPlayerFromUserID(params.userid)

			for (local i = PopExtUtil.HumanArray.len() - 1; i >= 0; i--)
				if (PopExtUtil.HumanArray[i] == null || PopExtUtil.HumanArray[i] == player)
					PopExtUtil.HumanArray.remove(i)

			for (local i = PopExtUtil.PlayerArray.len() - 1; i >= 0; i--)
				if (PopExtUtil.PlayerArray[i] == null || PopExtUtil.PlayerArray[i] == player)
					PopExtUtil.PlayerArray.remove(i)
		}
	}
}

PopExtUtil.TriggerHurt.DispatchSpawn()

NavMesh.GetAllAreas(PopExtUtil.AllNavAreas)

__CollectGameEventCallbacks(PopExtUtil.Events)

PopExtUtil.RespawnOverride.SetSolid(2);
PopExtUtil.RespawnOverride.SetSize(Vector(), Vector(1, 1, 1))

//fix delayed starttouch crash
function RespawnStartTouch() { return (activator == null) ? false : true; }
function RespawnEndTouch() { return (activator == null) ? false : true; }

PopExtUtil.RespawnOverride.ValidateScriptScope();
PopExtUtil.RespawnOverride.GetScriptScope().InputStartTouch <- RespawnStartTouch;
PopExtUtil.RespawnOverride.GetScriptScope().Inputstarttouch <- RespawnStartTouch;
PopExtUtil.RespawnOverride.GetScriptScope().InputEndTouch <- RespawnEndTouch;
PopExtUtil.RespawnOverride.GetScriptScope().Inputendtouch <- RespawnEndTouch;
