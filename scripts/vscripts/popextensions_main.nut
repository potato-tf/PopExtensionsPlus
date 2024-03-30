//date = last major version push (new features)
//suffix = patch
::popExtensionsVersion <- "03.30.2024.1"
local root = getroottable()

local o = Entities.FindByClassname(null, "tf_objective_resource")
::__popname <- NetProps.GetPropString(o, "m_iszMvMPopfileName")
// ::commentaryNode <- SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

::PopExtMain <- {

	//save popfile name in global scope when we first initialize
	//if the popfile name changed, a new pop has loaded, clean everything up.
	function PlayerCleanup(player) {
		NetProps.SetPropInt(player, "m_nRenderMode", 0)
		NetProps.SetPropInt(player, "m_clrRender", 0xFFFFFF)
		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		if (scope.len() <= 5) return

		local ignore_table = {
			"self"      : null
			"__vname"   : null
			"__vrefs"   : null
			"Preserved" : null
			"popWearablesToDestroy" : null
		}
		foreach (k, v in scope)
			if (!(k in ignore_table))
				delete scope[k]
	}

	function OnGameEvent_post_inventory_application(params) {

		PopExtMain.PlayerCleanup(GetPlayerFromUserID(params.userid))

		local player = GetPlayerFromUserID(params.userid)
		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}

		scope.PlayerThinks <- function() { foreach (name, func in scope.PlayerThinkTable) func(); return -1 }

		AddThinkToEnt(player, "PlayerThinks")

		if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope))
		{
			scope.BuiltObjectTable <- {}
			scope.buildings <- []
		}

		local bot = player
		if (bot.IsBotOfType(1337))
		{
			scope.BotThink <- PopExtTags.BotThink

			EntFireByHandle(bot, "RunScriptCode", "AddThinkToEnt(self, `BotThink`)", -1, null, null)
			EntFireByHandle(bot, "RunScriptCode", "PopExtTags.AI_BotSpawn(self)", -1, null, null)
		}

		foreach (_, func in GlobalFixes.SpawnHookTable) func(params)
		foreach (_, func in MissionAttributes.SpawnHookTable) func(params)
		foreach (_, func in CustomAttributes.SpawnHookTable) func(params)
	}
	function OnGameEvent_player_changeclass(params) {
		local player = GetPlayerFromUserID(params.userid)

		for (local model; model = FindByName(model, "__bot_bonemerge_model");)
			if (model.GetMoveParent() == player)
				EntFireByHandle(model, "Kill", "", -1, null, null)
	}

	//clean up bot scope on death
	function OnGameEvent_player_death(params) {

		local player = GetPlayerFromUserID(params.userid)
		if (!player.IsBotOfType(1337)) return

		PopExtMain.PlayerCleanup(player)
	}

	function OnGameEvent_teamplay_round_start(params) {

		for (local wearable; wearable = FindByClassname(wearable, "tf_wearable*");)
			if (wearable.GetOwner() == null || IsPlayerABot(wearable.GetOwner()))
				EntFireByHandle(wearable, "Kill", "", -1, null, null)

		//same pop, don't run clean-up
		if (__popname == GetPropString(o, "m_iszMvMPopfileName")) return

		EntFire("_popext*", "Kill")
		EntFire("__util*", "Kill")
		EntFire("__bot*", "Kill")

		for (local i = 1; i <= MaxClients().tointeger(); i++) {

			local player = PlayerInstanceFromIndex(i)

			if (player == null) continue

			PopExtMain.PlayerCleanup(player)
		}

		try delete ::MissionAttributes catch(e) return
		try delete ::CustomAttributes catch(e) return
		try delete ::PopExt catch(e) return
		try delete ::PopExtTags catch(e) return
		try delete ::PopExtHooks catch(e) return
		try delete ::GlobalFixes catch(e) return
		try delete ::SpawnTemplate catch(e) return
		try delete ::VCD_SOUNDSCRIPT_MAP catch(e) return
		try delete ::PopExtUtil catch(e) return
		try delete ::__popname catch(e) return
		try delete ::__tagarray catch(e) return
		try delete ::PopExtMain catch(e) return
		try delete ::PointTemplates catch(e) return
	}
}
__CollectGameEventCallbacks(PopExtMain)

//HACK: forces post_inventory_application to fire on pop load
for (local i = 1; i <= MaxClients().tointeger(); i++)
	if (PlayerInstanceFromIndex(i) != null)
		EntFireByHandle(PlayerInstanceFromIndex(i), "RunScriptCode", "self.Regenerate(true)", 0.015, null, null)

function Include(path) {
	try IncludeScript(format("popextensions/%s", path), root) catch(e) printl(e)
}

Include("constants") //constants must include first
Include("itemdef_constants") //constants must include first
Include("item_map") //must include second
Include("util") //must include third

Include("hooks") //must include before popextensions
Include("popextensions")

Include("robotvoicelines") //must include before missionattributes
Include("customattributes") //must include before missionattributes
Include("missionattributes")

Include("botbehavior") //must include before tags
Include("tags")

Include("globalfixes")
Include("spawntemplate")
Include("tutorialtools")
