//date = last major version push (new features)
//suffix = patch
::popExtensionsVersion <- "03.16.2024.3"
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

		if (scope.len() < 5) return

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
	}
}
__CollectGameEventCallbacks(PopExtMain)

function Include(path) {
	try IncludeScript(format("popextensions/%s", path), root) catch(e) printl(e)
}

Include("constants") //constants must include first
Include("itemdef_constants") //constants must include first
Include("util") //must include second

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
