::popExtensionsVersion <- "06.12.2025.1"

local ROOT = getroottable()

// these get defined here so we can use them
// for some reason including constants in this same file still throws not found errors
const POPEXT_ERROR   = "POPEXTENSIONS ERROR: "
const POPEXT_WARNING = "POPEXTENSIONS WARNING: "
const POPEXT_DEBUG   = "POPEXTENSIONS DEBUG: "

local o = Entities.FindByClassname(null, "tf_objective_resource")

//save popfile name in global scope when we first initialize
//if the popfile name changed, a new pop has loaded, clean everything up.
::__popname <- NetProps.GetPropString(o, "m_iszMvMPopfileName")

// ::commentaryNode <- SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

// overwrite AddThinkToEnt
// certain entity types use think tables, meaning any external scripts will conflict with this and break everything
// don't want to confuse new scripters by allowing adding multiple thinks with AddThinkToEnt in our library and our library only
// spew a big fat warning below so they know what's going on

local banned_think_classnames = {
	player = "PlayerThinkTable"
	tank_boss = "TankThinkTable"
	tf_projectile_ = "ProjectileThinkTable"
	tf_weapon_ = "ItemThinkTable"
	tf_wearable = "ItemThinkTable"
}

if (!("_AddThinkToEnt" in ROOT))
{
	//rename so we can still use it elsewhere
	//this also allows people to override the think restriction by using _AddThinkToEnt(ent, "FuncNameHere") instead
	//I'm not including this in the warning, only the people that know what they're doing already and can find it here should know about it.
	::_AddThinkToEnt <- AddThinkToEnt

	::AddThinkToEnt <- function(ent, func)
	{
		//mission unloaded, revert back to vanilla AddThinkToEnt
		if (!("__popname" in ROOT))
		{
			_AddThinkToEnt(ent, func)
			AddThinkToEnt <- _AddThinkToEnt
			return
		}

		foreach (k, v in banned_think_classnames)
			if (startswith(ent.GetClassname(), k))
			{
				error(format("ERROR: **POPEXTENSIONS WARNING: AddThinkToEnt on '%s' entity overwritten!**\n", k))
				// ClientPrint(null, HUD_PRINTTALK, format("\x08FFB4B4FF**WARNING: AddThinkToEnt on '%s' entities is forbidden!**\n\n Use PopExtUtil.AddThinkToEnt instead.\n\nExample: AddThinkToEnt(ent, \"%s\") -> PopExtUtil.AddThinkToEnt(ent, \"%s\")", k, func, func))

				//we use printl instead of printf because it's redirected to player console on potato servers
				printl(format("\n\n**POPEXTENSIONS WARNING: AddThinkToEnt on '%s' overwritten!**\n\nAddThinkToEnt(ent, \"%s\") -> PopExtUtil.AddThinkToEnt(ent, \"%s\")\n\n", ent.tostring(), func, func))
				PopExtUtil.AddThinkToEnt(ent, func)
				return
			}

		_AddThinkToEnt(ent, func)
	}
}

// include event wrapper here instead of at the bottom as
// PopExtMain contains and registers events
try
	IncludeScript( "popextensions/event_wrapper", ROOT )
catch ( e )
	printl( e )

::PopExtMain <- {

	DebugText = false

	// manual cleanup flag, set to true for missions that are created for a specific map.
	// automated unloading is meant for multiple missions on one map, purpose-built map/mission combos (like mvm_redridge) don't need this.
	// this should also be used if you change the popfile name mid-mission.
	ManualCleanup = false


	// ignore these variables when cleaning up
	// "Preserved" is a special table that will persist through the cleanup process
	// any player scoped variables you want to use across multiple waves should be added here
	IgnoreTable = {
		"self"         			: null
		"__vname"      			: null
		"__vrefs"      			: null
		"Preserved"    			: null
		"ExtraLoadout" 			: null
		"PointTemplatesToKill" 	: null
		"popWearablesToDestroy" : null
	}

	function PlayerCleanup(player) {

		NetProps.SetPropInt(player, "m_nRenderMode", kRenderNormal)
		NetProps.SetPropInt(player, "m_clrRender", 0xFFFFFF)

		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		if (scope.len() <= IgnoreTable.len()) return

		foreach (k, v in scope)
			if (!(k in IgnoreTable))
				delete scope[k]
	}
	Error = {

		RaisedParseError = false

		function DebugLog(LogMsg) {
			if (!PopExtMain.DebugText) return
			ClientPrint(null, HUD_PRINTCONSOLE, format("%s %s.", POPEXT_DEBUG, LogMsg))
		}

		function GenericWarning(msg) {
			ClientPrint(null, HUD_PRINTCONSOLE, format("%s %s.", POPEXT_WARNING, msg))
		}

		function DeprecationWarning(old, new) {
			ClientPrint(null, HUD_PRINTCONSOLE, format("%s %s is DEPRECATED. Use %s instead.", POPEXT_WARNING, old, new))
		}

		// TODO: implement a try catch raise system instead of this

		// Raises an error if the user passes an index that is out of range.
		// Example: Allowed values are 1-2, but user passed 3.
		function RaiseIndexError(attr, max = [0, 1])
			ParseError(format("Index out of range for %s, value range: %d - %d", attr, max[0], max[1]))

		// Raises an error if the user passes an argument of the wrong type.
		// Example: Allowed values are strings, but user passed a float.
		function RaiseTypeError(attr, type)
			ParseError(format("Bad type for %s (should be %s)", attr, type))

		// Raises an error if the user passes an invalid argument
		// Example: Attribute expects a bitwise operator but value cannot be evenly split into a power of 2
		function RaiseValueError(attr, value, extra = "")
			ParseError(format("Bad value %s	passed to %s. %s", value.tostring(), attr, extra))

		// Raises a template parsing error, if nothing else fits.
		function ParseError(ErrorMsg) {

			if (!RaisedParseError) {

				RaisedParseError = true
				ClientPrint(null, HUD_PRINTTALK, "\x08FFB4B4FFIt is possible that a parsing error has occured. Check console for details.")
			}
			ClientPrint(null, HUD_PRINTCONSOLE, format("%s %s.\n", POPEXT_ERROR, ErrorMsg))

			printf("%s %s.\n", POPEXT_ERROR, ErrorMsg)
		}

		// Raises an exception.
		// Example: Script modification has not been performed correctly. User should never see one of these.
		function RaiseException(ExceptionMsg) {
			Assert(false, format("POPEXT EXCEPTION: %s.", ExceptionMsg))
		}
	}
	Events = {

		function OnGameEvent_player_spawn(params) {

			local player = GetPlayerFromUserID(params.userid)
			local scope = player.GetScriptScope()
			if (!scope)
			{
				player.ValidateScriptScope()
				scope = player.GetScriptScope()
			}
			if (!("Preserved" in scope))
				scope.Preserved <- {}
		}

		function OnGameEvent_post_inventory_application(params) {

			if (GetRoundState() == GR_STATE_PREROUND) return

			local player = GetPlayerFromUserID(params.userid)

			if (player.IsEFlagSet(1073741824)) return // EFL_CUSTOM_WEARABLE

			PopExtMain.PlayerCleanup(player)

			local scope = player.GetScriptScope()

			scope.userid <- params.userid

			if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}

			if (player.IsBotOfType(TF_BOT_TYPE))
			{
				scope.TeamSwitchTable <- {}
				scope.DeathHookTable  <- {}
				scope.TakeDamageTable <- {}

				scope.aibot <- PopExtBotBehavior(player)
				scope.PlayerThinkTable.BotThink <- function() {
						aibot.OnUpdate()
				}
				EntFireByHandle(player, "RunScriptCode", "PopExtTags.EvaluateTags(self)", 0.015, player, player);
			}

			scope.PlayerThinks <- function() { foreach (name, func in scope.PlayerThinkTable) func.call(scope); return -1 }

			_AddThinkToEnt(player, "PlayerThinks")

			if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope))
			{
				scope.BuiltObjectTable <- {}
				scope.buildings <- []
			}

			if ("MissionAttributes" in ROOT) foreach (func in MissionAttributes.SpawnHookTable) func(params)
			// if ("GlobalFixes" in ROOT) foreach (func in GlobalFixes.SpawnHookTable) func(params) //these have all been moved to missionattributes
			if ("CustomAttributes" in ROOT) foreach (func in CustomAttributes.SpawnHookTable) func(params)
			if ("PopExtPopulator" in ROOT) foreach (func in PopExtPopulator.SpawnHookTable) func(params)
			if ("CustomWeapons" in ROOT) foreach (func in CustomWeapons.SpawnHookTable) func(params)
		}
		function OnGameEvent_player_changeclass(params) {
			local player = GetPlayerFromUserID(params.userid)

			for (local model; model = FindByName(model, "__util_bonemerge_model");)
				if (model.GetMoveParent() == player)
					EntFireByHandle(model, "Kill", "", -1, null, null)
		}

		//clean up bot scope on death
		function OnGameEvent_player_death(params) {

			local player = GetPlayerFromUserID(params.userid)

			if (!player.IsBotOfType(TF_BOT_TYPE)) return

			PopExtMain.PlayerCleanup(player)
		}

		function OnGameEvent_teamplay_round_start(_) {

			// clean up lingering wearables
			for (local wearable; wearable = FindByClassname(wearable, "tf_wearable*");)
				if (wearable.GetOwner() == null || IsPlayerABot(wearable.GetOwner()))
					EntFireByHandle(wearable, "Kill", "", -1, null, null)

			//same pop or manual cleanup flag set, don't run
			if (__popname == GetPropString(o, "m_iszMvMPopfileName") || PopExtMain.ManualCleanup) return

			//clean up all players
			local maxclients = MaxClients().tointeger()
			for (local i = 1; i <= maxclients; i++) {

				local player = PlayerInstanceFromIndex(i)

				if (player == null) continue

				PopExtMain.PlayerCleanup(player)
			}

			//clean up missionattributes
			MissionAttributes.Cleanup()

			//nuke it all
			local cleanup = [

				"MissionAttributes"
				"CustomAttributes"
				"GlobalFixes"
				"SpawnTemplate"
				"SpawnTemplateWaveSchedule"
				"SpawnTemplates"
				"VCD_SOUNDSCRIPT_MAP"
				"PointTemplates"
				"CustomWeapons"
				"__popname"
				"ExtraItems"
				"Homing"
				"Include"
				"MAtr"
				"MAtrs"
				"MissionAttr"
				"MissionAttrs"
				"MissionAttrThink"

				"PopExt"
				"PopExtTags"
				"PopExtHooks"
				"PopExtUtil"
				"PopExtPathPoint"
				"PopExtBotBehavior"
				"PopExtWeapons"
				"PopExtAttributes"
				"PopExtItems"
				"PopExtMain"
				"PopExtGlobalThink"
				"PopExtTutorial"
				"popExtThinkFuncSet"
				"popExtensionsVersion"

				"ScriptLoadTable"
				"ScriptUnloadTable"
				"EntAdditions"
				"Explanation"
				"Info"
			]

			foreach(c in cleanup) if (c in ROOT) delete ROOT[c]

			EntFire("__popext*", "Kill")
			EntFire("__util*", "Kill")
			EntFire("__bot*", "Kill")
			EntFire("extratankpath*", "Kill")
		}
	}
}
__CollectGameEventCallbacks(PopExtMain.Events)


//HACK: forces post_inventory_application to fire on pop load
local maxclients = MaxClients().tointeger()
for (local i = 1; i <= maxclients; i++)
	if (PlayerInstanceFromIndex(i) != null)
		EntFireByHandle(PlayerInstanceFromIndex(i), "RunScriptCode", "self.Regenerate(true)", 0.015, null, null)

function Include(path) {
	try IncludeScript(format("popextensions/%s", path), ROOT) catch(e) printl(e)
}

Include("constants") //constants must include first
Include("itemdef_constants") //constants must include first
Include("item_map") //must include second
Include("attribute_map") //must include third (after item_map)
Include("util") //must include fourth

Include("hooks") //must include before popextensions
Include("popextensions")

Include("robotvoicelines") //must include before missionattributes
Include("customattributes") //must include before missionattributes
// Include("customattributes_noloop")
Include("missionattributes")
Include("customweapons")

Include("botbehavior") //must include before tags
Include("tags")

Include("globalfixes")
Include("spawntemplate")

// Include("tutorialtools")
// Include("populator")
