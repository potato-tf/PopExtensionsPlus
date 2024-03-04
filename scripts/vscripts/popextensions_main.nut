local root = getroottable()

//save popfile name in global scope when we first initialize
//if it has, a new pop has loaded, clean everything up.

local o = Entities.FindByClassname(null, "tf_objective_resource")
::__popname <- NetProps.GetPropString(o, "m_iszMvMPopfileName")
// ::commentaryNode <- SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

::Main <- {
	//cleanup function

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

		delete ::PopExt
		delete ::PopExtTags
		delete ::PopExtHooks
		delete ::GlobalFixes
		delete ::SpawnTemplate
		delete ::MissionAttributes
		delete ::VCD_SOUNDSCRIPT_MAP
		delete ::PopExtUtil

		delete ::__popname
		delete ::Main
	}
}
__CollectGameEventCallbacks(Main)

function Include(path) {
	try IncludeScript(format("popextensions/%s", path), root) catch(e) printl(e)
}

Include("constants.nut") //constants must include first
Include("itemdef_constants.nut") //constants must include first
Include("util.nut") //must include second

Include("hooks.nut") //must include before popextensions
Include("popextensions.nut")

Include("robotvoicelines.nut") //must include before missionattributes
Include("missionattributes.nut")

Include("botbehavior.nut") //must include before tags
Include("tags.nut")

Include("globalfixes.nut")
Include("spawntemplate.nut")
Include("tutorialtools.nut")
