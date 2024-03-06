local root = getroottable()

local o = Entities.FindByClassname(null, "tf_objective_resource")
::__popname <- NetProps.GetPropString(o, "m_iszMvMPopfileName")
// ::commentaryNode <- SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

::Main <- {
	//save popfile name in global scope when we first initialize
	//if the popfile name changed, a new pop has loaded, clean everything up.

	function PlayerCleanup(player) {
		NetProps.SetPropInt(player, "m_nRenderMode", 0)
		NetProps.SetPropInt(player, "m_clrRender", 0xFFFFFF)
		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		if (scope.len() < 4) return

		local ignore_table = {
			"self"      : null
			"__vname"   : null
			"__vrefs"   : null
			"Preserved" : null
		}
		foreach (k, v in scope)
			if (!(k in ignore_table))
				delete scope[k]
	}

	function OnGameEvent_teamplay_round_start(params) {

		if (__popname == NetProps.GetPropString(o, "m_iszMvMPopfileName")) return

		EntFire("_popextensions*", "Kill")

		for (local i = 1; i <= MaxClients().tointeger(); i++) {

			local player = PlayerInstanceFromIndex(i)

			if (player == null) continue

			Main.PlayerCleanup(player)
		}

		try delete ::MissionAttributes catch(e) return
		try delete ::PopExt catch(e) return
		try delete ::PopExtTags catch(e) return
		try delete ::PopExtHooks catch(e) return
		try delete ::GlobalFixes catch(e) return
		try delete ::SpawnTemplate catch(e) return
		try delete ::VCD_SOUNDSCRIPT_MAP catch(e) return
		try delete ::PopExtUtil catch(e) return
		try delete ::__popname catch(e) return
		try delete ::Main catch(e) return
	}
}
__CollectGameEventCallbacks(Main)

function Include(path) {
	try IncludeScript(format("popextensions/%s", path), root) catch(e) printl(e)
}

Include("constants") //constants must include first
Include("itemdef_constants") //constants must include first
Include("util") //must include second

Include("hooks") //must include before popextensions
Include("popextensions")

Include("robotvoicelines") //must include before missionattributes
Include("missionattributes")

Include("botbehavior") //must include before tags
Include("tags")

Include("globalfixes")
Include("spawntemplate")
Include("tutorialtools")
