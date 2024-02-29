// All Global Utility Functions go here, also use IncludeScript and place it inside Root

::PopExtUtil <- {

	PlayerArray = []
	BotArray = []
	Classes = ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere
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
	PlayerManager = FindByClassname(null, "tf_player_manager")
	Worldspawn = FindByClassname(null, "worldspawn")
	StartRelay = FindByName(null, "wave_start_relay")
	FinishedRelay = FindByName(null, "wave_finished_relay")
	CurrentWaveNum = GetPropInt(FindByClassname(null, "tf_objective_resource"), "m_nMannVsMachineWaveCount")
	ClientCommand = SpawnEntityFromTable("point_clientcommand", {})

	Events = {
		function OnGameEvent_mvm_wave_complete(params) { PopExtUtil.IsWaveStarted = false }
		function OnGameEvent_mvm_wave_failed(params) { PopExtUtil.IsWaveStarted = false }
		function OnGameEvent_mvm_begin_wave(params) { PopExtUtil.IsWaveStarted = true }
		function OnGameEvent_mvm_reset_stats(params) { PopExtUtil.IsWaveStarted = true } //used for manually jumping waves

		function OnGameEvent_teamplay_round_start(params)
		{
			for (local i = 1; i <= MAX_CLIENTS; i++)
			{
				local player = PlayerInstanceFromIndex(i)

				//make a player array to avoid constantly iterating through MAX_CLIENTS
				if (player == null || !player.IsBotOfType(1337) || PopExtUtil.BotArray.find(player) != null) continue;

				PopExtUtil.BotArray.append(player)
			}
		}

		function OnGameEvent_post_inventory_application(params) {

			local player = GetPlayerFromUserID(params.userid)

			player.ValidateScriptScope()
			if (!("PopExtPlayerScope" in player.GetScriptScope()))
			{
				local PopExtPlayerScope = {
					PlayerThinkTable = {}
					TakeDamageTable = {}
					DeathHookTable = {}
				}
				GetPlayerFromUserID(params.userid).GetScriptScope().PopExtPlayerScope <- PopExtPlayerScope
			}

			local scope = player.GetScriptScope().PopExtPlayerScope

			if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope)) scope.BuiltObjectTable <- {}

			function PlayerThinks() {

				foreach (name, func in scope.PlayerThinkTable) { printl(name + " : " + func); func(); return -1 }
			}

			if (!("PlayerThinks" in scope)) {
				scope.PlayerThinks <- PlayerThinks
				AddThinkToEnt(player, "PlayerThinks")
			}

			//sort m_hMyWeapons  by slot
			local myweapons = {}
			for (local i = 0; i < SLOT_COUNT; i++) {

				local wep = GetPropEntityArray(player, "m_hMyWeapons", i)

				if (wep == null) continue

				myweapons[wep.GetSlot()] <- wep
			}

			foreach(slot, wep in myweapons)
				SetPropEntityArray(player, "m_hMyWeapons", wep, slot)

			//make a player array to avoid constantly iterating through MAX_CLIENTS
			if (player.IsBotOfType(1337) && PopExtUtil.BotArray.find(player) == null)
				PopExtUtil.BotArray.append(player)

			else if (PopExtUtil.PlayerArray.find(player) == null)
				PopExtUtil.PlayerArray.append(player)

		}

		function OnGameEvent_player_disconnect(params) {
			local player = GetPlayerFromUserID(params.userid)

			for (local i = PopExtUtil.PlayerArray.len() - 1; i >= 0; i--)
				if (PopExtUtil.PlayerArray[i] == null || PopExtUtil.PlayerArray[i] == player)
					PopExtUtil.PlayerArray.remove(i)
		}
	}
}

NavMesh.GetAllAreas(PopExtUtil.AllNavAreas)

__CollectGameEventCallbacks(PopExtUtil.Events)

//HACK: forces post_inventory_application to fire on pop load
for (local i = 1; i <= MAX_CLIENTS; i++)
	if (PlayerInstanceFromIndex(i) != null)
		EntFireByHandle(PlayerInstanceFromIndex(i), "RunScriptCode", "self.Regenerate(true)", -1, null, null)

function PopExtUtil::IsLinuxServer() {
	return RAND_MAX != 32767
}

function PopExtUtil::ShowMessage(message) {
	ClientPrint(null, HUD_PRINTCENTER , message)
}

function PopExtUtil::ShowChatMessage(target, fmt, ...) {
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

function PopExtUtil::HexToRgb(hex) {

	// Extract the RGB values
	local r = hex.slice(0, 2).tointeger(16)
	local g = hex.slice(2, 4).tointeger(16)
	local b = hex.slice(4, 6).tointeger(16)

	// Return the RGB values as an array
	return [r, g, b]
}

function PopExtUtil::SetParentLocalOriginDo(child, parent, attachment = null) {
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
	child.SetVelocity(origVel + Vector(0, 0, 1))
	child.SetVelocity(origVel)

	EntFireByHandle(child, "SetParent", "!activator", 0, parent, parent)
	if (attachment != null) {
		SetPropEntity(child, "m_iParentAttachment", parent.LookupAttachment(attachment))
		EntFireByHandle(child, "SetParentAttachmentMaintainOffset", attachment, 0, parent, parent)
	}
}

// Sets parent immediately in a dirty way. Does not retain absolute origin, retains local origin instead.
// child parameter may also be an array of entities
function PopExtUtil::SetParentLocalOrigin(child, parent, attachment = null) {
	if (typeof child == "array")
		foreach(i, childIn in child)
			SetParentLocalOriginDo(childIn, parent, attachment)
	else
		SetParentLocalOriginDo(child, parent, attachment)
}

// Setup collision bounds of a trigger entity
function PopExtUtil::SetupTriggerBounds(trigger, mins = null, maxs = null) {
	trigger.SetModel("models/weapons/w_models/w_rocket.mdl")

	if (mins != null) {
		SetPropVector(trigger, "m_Collision.m_vecMinsPreScaled", mins)
		SetPropVector(trigger, "m_Collision.m_vecMins", mins)
	}
	if (maxs != null) {
		SetPropVector(trigger, "m_Collision.m_vecMaxsPreScaled", maxs)
		SetPropVector(trigger, "m_Collision.m_vecMaxs", maxs)
	}

	trigger.SetSolid(Constants.ESolidType.SOLID_BBOX)
}

function PopExtUtil::PrintTable(table) {
	if (table == null) return;

	DoPrintTable(table, 0)
}

function PopExtUtil::DoPrintTable(table, indent) {
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
			DoPrintTable(v, indent)
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
function PopExtUtil::CreatePlayerWearable(player, model, bonemerge = true, attachment = null, autoDestroy = true) {
	local modelIndex = GetModelIndex(model)
	if (modelIndex == -1)
		modelIndex = PrecacheModel(model)

	local wearable = Entities.CreateByClassname("tf_wearable")
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
	Entities.DispatchSpawn(wearable)
	SetPropInt(wearable, "m_fEffects", bonemerge ? 129 : 0)
	SetParentLocalOrigin(wearable, player, attachment)

	player.ValidateScriptScope()
	local scope = player.GetScriptScope().PopExtPlayerScope
	if (autoDestroy) {
		if (!("popWearablesToDestroy" in scope))
			scope.popWearablesToDestroy <- []

		scope.popWearablesToDestroy.append(wearable)
	}
	return wearable
}


function PopExtUtil::Explanation(message, printColor = COLOR_YELLOW, messagePrefix = "Explanation: ", syncChatWithGameText = false, textPrintTime = -1, textScanTime = 0.02) {
	local rgb = PopExtUtil.HexToRgb("FFFF66")
	local txtent = SpawnEntityFromTable("game_text", {
		effect = 2,
		spawnflags = 1,
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
	SetTargetname(txtent, format("__ExplanationText%d",txtent.entindex()))
	local strarray = []

	//avoid needing to do a ton of function calls for multiple announcements.
	local newlines = split(message, "|")

	foreach (n in newlines)
		if (n.len() > 0) {
			strarray.append(n)
			if (!startswith(n, "PAUSE") && !syncChatWithGameText)
				ClientPrint(null, 3, format("\x07%s %s\x07%s %s", COLOR_YELLOW, messagePrefix, TF_COLOR_DEFAULT, n))
		}

	local i = -1
	local textcooldown = 0
	function ExplanationTextThink() {
		if (textcooldown > Time()) return

		i++
		if (i == strarray.len()) {
			SetPropString(txtent, "m_iszScriptThinkFunction", "")

		//	  DoEntFire("!activator", "SetScriptOverlayMaterial", "", -1, player, player)

			// foreach (player in PopExtUtil.PlayerArray) DoEntFire("command", "Command", "r_screenoverlay vgui/pauling_text", -1, player, player)

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

function PopExtUtil::IsAlive(player) {
	return GetPropInt(player, "m_lifeState") == 0
}

function PopExtUtil::IsDucking(player) {
	return player.GetFlags() & FL_DUCKING
}

function PopExtUtil::IsOnGround(player) {
	return player.GetFlags() & FL_ONGROUND
}

function PopExtUtil::RemoveAmmo(player) {
	for ( local i = 0; i < 32; i++ ) {
		SetPropIntArray(player, "m_iAmmo", 0, i)
	}
}
function PopExtUtil::GetAllEnts() {
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
function PopExtUtil::_SetOwner(ent, owner) {
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

function PopExtUtil::ShowAnnotation(text = "This is an annotation", lifetime = 10, pos = Vector(), id = 0, distance = true, sound = "misc/null.wav", entindex = 0, visbit = 0, effect = true) {
	SendGlobalGameEvent("show_annotation", {
		text = text
		lifetime = lifetime
		worldPosX = pos.x
		worldPosY = pos.y
		worldPosZ = pos.z
		id = id
		play_sound = sound
		show_distance = distance
		show_effect = effect
		follow_entindex = entindex
		visibilityBitfield = visbit
	})
}

//This may not be necessary and hide_annotation may work, but whatever this works too.
function PopExtUtil::HideAnnotation(id) { ShowAnnotation("", 0.0000001, Vector(), id = id) }

function PopExtUtil::GetPlayerName(player) {
	return GetPropString(player, "m_szNetname")
}

function PopExtUtil::SetPlayerName(player,	name) {
	return SetPropString(player, "m_szNetname", name)
}

function PopExtUtil::GetPlayerUserID(player) {
	return GetPropIntArray(PlayerManager, "m_iUserID", player.entindex()) //TODO replace PlayerManager with the actual entity name
}

function PopExtUtil::PlayerRespawn() {
	self.ForceRegenerateAndRespawn()
}

function PopExtUtil::DisableCloak(player) {
	// High Number to Prevent Player from Cloaking
	SetPropFloat(player, "m_Shared.m_flStealthNextChangeTime", Time() * INT_MAX)
}

function PopExtUtil::InUpgradeZone(player) {
	return GetPropBool(player, "m_Shared.m_bInUpgradeZone")
}

function PopExtUtil::InButton(player, button) {
	return (GetPropInt(player, "m_nButtons") & button)
}

function PopExtUtil::PressButton(player, button) {
	SetPropInt(player, "m_afButtonForced", GetPropInt(player, "m_afButtonForced") | button); SetPropInt(player, "m_nButtons", GetPropInt(player, "m_nButtons") | button)
}

//assumes user is using the SLOT_ constants
function PopExtUtil::SwitchWeaponSlot(player, slot) {
	EntFireByHandle(ClientCommand, "Command", format("slot%d", slot + 1), -1, player, player)
}

function PopExtUtil::GetItemInSlot(player, slot) {
	// local item
	// for (local i = 0; i < SLOT_COUNT; i++) {
	// 	local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
	// 	if ( wep == null || wep.GetSlot() != slot) continue

	// 	item = wep
	// 	break
	// }
	// return item
	//m_hMyWeapons is now sorted by slot
	return GetPropEntityArray(player, "m_hMyWeapons", slot)
}

function PopExtUtil::SwitchToFirstValidWeapon(player) {
	for (local i = 0; i < SLOT_COUNT; i++) {
		local wep = GetPropEntityArray(player, "m_hMyWeapons", i)
		if ( wep == null) continue

		player.Weapon_Switch(wep)
		return wep
	}
}

function PopExtUtil::HasEffect(ent, value) {
	return GetPropInt(ent, "m_fEffects") == value
}

function PopExtUtil::SetEffect(ent, value) {
	SetPropInt(ent, "m_fEffects", value)
}

function PopExtUtil::PlayerRobotModel(player, model) {
	player.ValidateScriptScope()
	local scope = player.GetScriptScope().PopExtPlayerScope

	local wearable = CreateByClassname("tf_wearable")
	SetPropString(wearable, "m_iName", "__bot_bonemerge_model")
	SetPropInt(wearable, "m_nModelIndex", PrecacheModel(model))
	SetPropBool(wearable, "m_bValidatedAttachedEntity", true)
	SetPropBool(wearable, STRING_NETPROP_ITEMDEF, true)
	SetPropEntity(wearable, "m_hOwnerEntity", player)
	wearable.SetTeam(player.GetTeam())
	wearable.SetOwner(player)
	wearable.DispatchSpawn()
	EntFireByHandle(wearable, "SetParent", "!activator", -1, player, player)
	SetPropInt(wearable, "m_fEffects", 129)
	scope.wearable <- wearable

	SetPropInt(player, "m_nRenderMode", 1)
	SetPropInt(player, "m_clrRender", 0)

	function PopExtUtil::BotModelThink() {
		if (wearable && (player.IsTaunting() || wearable.GetMoveParent() != player))
			EntFireByHandle(wearable, "SetParent", "!activator", -1, self, self)
		return -1
	}

	if (!(BotModelThink in scope.PlayerThinkTable))
		scope.PlayerThinkTable.BotModelThink <- BotModelThink
}

function PopExtUtil::HasItemIndex(player, index) {
	local t = false
	for (local child = player.FirstMoveChild(); child != null; child = child.NextMovePeer()) {
		if (GetItemIndex(child) == index) {
			t = true
			break
		}
	}
	return t
}

function PopExtUtil::StunPlayer(player, duration = 5, type = 1, delay = 0, speedreduce = 0.5) {
	local utilstun = SpawnEntityFromTable("trigger_stun", {
		targetname = "__utilstun"
		stun_type = type
		stun_duration = duration
		move_speed_reduction = speedreduce
		trigger_delay = delay
		StartDisabled = 0
		spawnflags = 1
		"OnStunPlayer#1": "!self,Kill,,-1,-1"
	})
	utilstun.SetSolid(2)
	utilstun.SetSize(Vector(-1, -1, -1), Vector())

	EntFireByHandle(utilstun, "EndTouch", "", -1, player, player)
}

function PopExtUtil::Ignite(player, duration = 10)
{
	local utilignite = SpawnEntityFromTable("trigger_ignite", {
		targetname = "__utilignite"
		burn_duration = duration
	})
	utilignite.SetSolid(2)
	utilignite.SetSize(Vector(-1, -1, -1), Vector())
}

function PopExtUtil::ShowHudHint(player, text = "This is a hud hint", duration = 5) {
	local hudhint = FindByName(null, "__hudhint") != null

	local flags = (player == null) ? 1 : 0

	if (!hudhint) ::__hudhint <- SpawnEntityFromTable("env_hudhint", { targetname = "__hudhint", spawnflags = flags, message = text })

	__hudhint.KeyValueFromString("message", text)

	EntFireByHandle(__hudhint, "ShowHudHint", "", -1, player, player)
	EntFireByHandle(__hudhint, "HideHudHint", "", duration, player, player)
}

function PopExtUtil::SetEntityColor(entity, r, g, b, a) {
	local color = (r) | (g << 8) | (b << 16) | (a << 24)
	SetPropInt(entity, "m_clrRender", color)
}

function PopExtUtil::GetEntityColor(entity) {
	local color = GetPropInt(entity, "m_clrRender")
	local clr = {}
	clr.r <- color & 0xFF
	clr.g <- (color >> 8) & 0xFF
	clr.b <- (color >> 16) & 0xFF
	clr.a <- (color >> 24) & 0xFF
	return clr
}

function PopExtUtil::AddAttributeToLoadout(player, attribute, value, duration = -1) {
	for (local i = 0; i < SLOT_COUNT; i++) {

		local wep = GetPropEntityArray(player, "m_hMyWeapons", i)

		if (wep == null) continue

		wep.AddAttribute(attribute, value, duration)
		wep.ReapplyProvision()
	}
}

function PopExtUtil::ShowModelToPlayer(player, model = ["models/player/heavy.mdl", 0], pos = Vector(), ang = QAngle(), duration = INT_MAX) {
	PrecacheModel(model[0])
	local proxy_entity = CreateByClassname("obj_teleporter") // use obj_teleporter to set bodygroups.  not using SpawnEntityFromTable as that creates spawning noises
	proxy_entity.SetAbsOrigin(pos)
	proxy_entity.SetAbsAngles(ang)
	DispatchSpawn(proxy_entity)

	proxy_entity.SetModel(model[0])
	proxy_entity.SetSkin(model[1])
	proxy_entity.AddEFlags(EFL_NO_THINK_FUNCTION) // EFL_NO_THINK_function PopExtUtil::prevents the entity from disappearing
	proxy_entity.SetSolid(SOLID_NONE)

	SetPropBool(proxy_entity, "m_bPlacing", true)
	SetPropInt(proxy_entity, "m_fObjectFlags", 2) // sets "attachment" flag, prevents entity being snapped to player feet

	// m_hBuilder is the player who the entity will be networked to only
	SetPropEntity(proxy_entity, "m_hBuilder", player)
	EntFireByHandle(proxy_entity, "Kill", "", duration, player, player)
	return proxy_entity
}


function PopExtUtil::LockInPlace(player, enable = true) {
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

function PopExtUtil::GetItemIndex(item) {
	return GetPropInt(item, STRING_NETPROP_ITEMDEF)
}

function PopExtUtil::SetItemIndex(item, index) {
	SetPropInt(item, STRING_NETPROP_ITEMDEF, index)
}

function PopExtUtil::SetTargetname(ent, name) {
	SetPropString(ent, "m_iName", name)
}

function PopExtUtil::GetPlayerSteamID(player) {
	return GetPropString(player, "m_szNetworkIDString")
}

function PopExtUtil::GetHammerID(ent) {
	return GetPropInt(ent, "m_iHammerID")
}

function PopExtUtil::GetSpawnFlags(ent) {
	return GetPropInt(self, "m_spawnflags")
}

function PopExtUtil::GetPopfileName() {
	return GetPropString(PopExtUtil.ObjectiveResource, "m_iszMvMPopfileName")
}

function PopExtUtil::PrecacheParticle(name) {
	PrecacheEntityFromTable({ classname = "info_particle_system", effect_name = name })
}


function PopExtUtil::SpawnEffect(player,  effect) {
	local player_angle	   =  player.GetLocalAngles()
	local player_angle_vec =  Vector( player_angle.x, player_angle.y, player_angle.z)

	DispatchParticleEffect(effect, player.GetLocalOrigin(), player_angle_vec)
	return
}

function PopExtUtil::RemoveOutputAll(ent, output) {
	local outputs = []
	for (local i = GetNumElements(ent, output); i >= 0; i--) {
		local t = {}
		GetOutputTable(ent, output, t, i)
		outputs.append(t)
	}
	foreach (o in outputs) foreach(_ in o) RemoveOutput(ent, output, o.target, o.input, o.parameter)
}

function PopExtUtil::RemovePlayerWearables(player) {
	for (local wearable = player.FirstMoveChild(); wearable != null; wearable = wearable.NextMovePeer()) {
		if (wearable.GetClassname() == "tf_wearable")
			wearable.Destroy()
	}
	return
}

function PopExtUtil::IsEntityClassnameInList(entity, list) {
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

function PopExtUtil::SetPlayerClassRespawnAndTeleport(player, playerclass, location_set = null) {
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

function PopExtUtil::PlaySoundOnClient(player, name, volume = 1.0, pitch = 100) {
	EmitSoundEx( {
		sound_name = name,
		volume = volume
		pitch = pitch,
		entity = player,
		filter_type = RECIPIENT_FILTER_SINGLE_PLAYER
	})
}

function PopExtUtil::PlaySoundOnAllClients(name) {
	EmitSoundEx( {
		sound_name = name,
		filter_type = RECIPIENT_FILTER_GLOBAL
	})
}



// MATH

function PopExtUtil::Min(a, b) {
	return (a <= b) ? a : b
}

function PopExtUtil::Max(a, b) {
	return (a >= b) ? a : b
}

function PopExtUtil::Clamp(x, a, b) {
	return Min(b, Max(a, x))
}

function PopExtUtil::RemapVal(v, A, B, C, D) {
	if (A == B) {
		if (v >= B)
			return D
		return C
	}
	return C + (D - C) * (v - A) / (B - A)
}

function PopExtUtil::RemapValClamped(v, A, B, C, D) {
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

function PopExtUtil::IntersectionPointBox(pos, mins, maxs) {
	if (pos.x < mins.x || pos.x > maxs.x ||
		pos.y < mins.y || pos.y > maxs.y ||
		pos.z < mins.z || pos.z > maxs.z)
		return false

	return true
}

function PopExtUtil::NormalizeAngle(target) {
	target %= 360.0
	if (target > 180.0)
		target -= 360.0
	else if (target < -180.0)
		target += 360.0
	return target
}

function PopExtUtil::ApproachAngle(target, value, speed) {
	target = PopExtUtil.NormalizeAngle(target)
	value = PopExtUtil.NormalizeAngle(value)
	local delta = PopExtUtil.NormalizeAngle(target - value)
	if (delta > speed)
		return value + speed
	else if (delta < -speed)
		return value - speed
	return target
}

function PopExtUtil::VectorAngles(forward) {
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

function PopExtUtil::AnglesToVector(angles) {
	local pitch = angles.x * Pi / 180.0
	local yaw = angles.y * Pi / 180.0
	local x = cos(pitch) * cos(yaw)
	local y = cos(pitch) * sin(yaw)
	local z = sin(pitch)
	return Vector(x, y, z)
}

function PopExtUtil::QAngleDistance(a, b) {
  local dx = a.x - b.x
  local dy = a.y - b.y
  local dz = a.z - b.z
  return sqrt(dx*dx + dy*dy + dz*dz)
}

function PopExtUtil::CheckBitwise(num) {
	return (num != 0 && ((num & (num - 1)) == 0))
}

function PopExtUtil::StopAndPlayMVMSound(player, soundscript, delay) {
	player.ValidateScriptScope()
	local scope = player.GetScriptScope().PopExtPlayerScope
	scope.sound <- soundscript

	EntFireByHandle(player, "RunScriptCode", "self.StopSound(sound);", delay, null, null)

	local sound	   =  scope.sound
	local dotindex =  sound.find(".")
	if (dotindex == null) return

	scope.mvmsound <- sound.slice(0, dotindex+1) + "MVM_" + sound.slice(dotindex+1)

	EntFireByHandle(player, "RunScriptCode", "self.EmitSound(mvmsound);", delay + 0.015, null, null)
}

function PopExtUtil::StringReplace(str, findwhat, replace) {
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

function PopExtUtil::SilentDisguise(player, target = null, tfteam = TF_TEAM_PVE_INVADERS, tfclass = TF_CLASS_SCOUT) {
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

function PopExtUtil::GetPlayerReadyCount() {
	local roundtime = GetPropFloat(PopExtUtil.GameRules, "m_flRestartRoundTime")
	if (!GetPropBool(PopExtUtil.ObjectiveResource, "m_bMannVsMachineBetweenWaves")) return 0
	local ready = 0

	for (local i = 0; i < GetPropArraySize(PopExtUtil.GameRules, "m_bPlayerReady"); ++i) {
		if (!GetPropBoolArray(PopExtUtil.GameRules, "m_bPlayerReady", i)) continue
		++ready
	}

	return ready
}
