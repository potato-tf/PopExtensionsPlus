//date = last major version push (new features)
//suffix = patch
::popExtensionsVersion <- "06.14.2024.2"
local _root = getroottable()

local o = Entities.FindByClassname(null, "tf_objective_resource")
::__popname <- NetProps.GetPropString(o, "m_iszMvMPopfileName")
// ::commentaryNode <- SpawnEntityFromTable("point_commentary_node", {targetname = "  IGNORE THIS ERROR \r"})

//overwrite AddThinkToEnt
//certain entity types use think tables, meaning any external scripts will conflict with this and break everything
//we could replace this behavior entirely, but this would be misleading to newer scripters
//don't want to lead them astray by allowing adding multiple thinks with AddThinkToEnt in our library and our library only.

local banned_think_classnames = {
	player = "PlayerThinkTable"
	tank_boss = "TankThinkTable"
	tf_projectile_ = "ProjectileThinkTable"
}

if (!("_AddThinkToEnt" in _root))
{
	//rename so we can still use it elsewhere
	::_AddThinkToEnt <- AddThinkToEnt

	::AddThinkToEnt <- function(ent, func)
	{
		foreach (k, v in banned_think_classnames)
			if (startswith(ent.GetClassname(), k))
			{
				error(format("WARNING: Adding thinks to '%s' entities is forbidden! Add your function to the '%s' table instead\n", k, v))
				ClientPrint(null, HUD_PRINTTALK, format("\x08FFB4B4FF**WARNING: Adding thinks to %s entities is forbidden!**\n\n Add your function to \"%s\" instead.\n\nExample: AddThinkToEnt(ent, \"MyFunction\") would become: ent.%s.MyFunction <- MyFunction", k, v, v))
				return
			}

		_AddThinkToEnt(ent, func)
	}
}
::PopExtMain <- {

	//save popfile name in global scope when we first initialize
	//if the popfile name changed, a new pop has loaded, clean everything up.
	function PlayerCleanup(player) {

		NetProps.SetPropInt(player, "m_nRenderMode", kRenderNormal)
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

		local player = GetPlayerFromUserID(params.userid)

		this.PlayerCleanup(player)

		player.ValidateScriptScope()
		local scope = player.GetScriptScope()

		scope.userid <- params.userid

		if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}

		if (player.IsBotOfType(TF_BOT_TYPE))
		{
			EntFireByHandle(player, "RunScriptCode", @"
				PopExtTags.EvaluateTags(self)
				aibot <- AI_Bot(self)

				PlayerThinkTable.BotThink <- function() {
					try
						aibot.OnUpdate()
					catch(e)
						if (e == `the index 'bot' does not exist`) return
				}
			", -1, player, player);

		}

		scope.PlayerThinks <- function() { foreach (name, func in scope.PlayerThinkTable) func.call(scope); return -1 }

		_AddThinkToEnt(player, "PlayerThinks")

		if (player.GetPlayerClass() > TF_CLASS_PYRO && !("BuiltObjectTable" in scope))
		{
			scope.BuiltObjectTable <- {}
			scope.buildings <- []
		}

		if ("MissionAttributes" in _root) foreach (_, func in MissionAttributes.SpawnHookTable) func(params)
		if ("GlobalFixes" in _root) foreach (_, func in GlobalFixes.SpawnHookTable) func(params)
		if ("CustomAttributes" in _root) foreach (_, func in CustomAttributes.SpawnHookTable) func(params)
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

		if (!player.IsBotOfType(TF_BOT_TYPE)) return

		this.PlayerCleanup(player)
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

			this.PlayerCleanup(player)
		}

		try delete ::MissionAttributes catch(e) return
		try delete ::CustomAttributes catch(e) return
		try delete ::PopExt catch(e) return
		try delete ::PopExtTags catch(e) return
		try delete ::PopExtHooks catch(e) return
		try delete ::GlobalFixes catch(e) return
		try delete ::SpawnTemplate catch(e) return
		try delete ::SpawnTemplateWaveSchedule catch(e) return
		try delete ::SpawnTemplates catch(e) return
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
	try IncludeScript(format("popextensions/%s", path), _root) catch(e) printl(e)
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
Include("missionattributes")
Include("customweapons")

Include("botbehavior") //must include before tags
Include("tags")

Include("globalfixes")
Include("spawntemplate")
Include("tutorialtools")
