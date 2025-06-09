// most global fixes have been moved to missionattributes.nut
// dummy functions here to prevent errors

const EFL_USER = 1048576

local GlobalFixesEntity = FindByName(null, "__popext_globalfixes")
if (GlobalFixesEntity == null) GlobalFixesEntity = SpawnEntityFromTable("info_teleport_destination", { targetname = "__popext_globalfixes" })

::GlobalFixes <- {

	ThinkTable = {

		//add think table to all projectiles
		//there is apparently no better way to do this lol
		function AddProjectileThink()
		{
			for (local projectile; projectile = FindByClassname(projectile, "tf_projectile*");) {
				if (projectile.GetEFlags() & EFL_USER) continue

				projectile.ValidateScriptScope()
				local scope = projectile.GetScriptScope()
				local owner = projectile.GetOwner()

				if (owner && owner.IsValid()) {

					local owner_scope = owner.GetScriptScope()
					if (!owner_scope)
					{
						owner.ValidateScriptScope()
						owner_scope = owner.GetScriptScope()
					}

					if (!("ActiveProjectiles" in owner_scope.Preserved))
						owner_scope.Preserved.ActiveProjectiles <- {}

					owner_scope.Preserved.ActiveProjectiles[projectile.entindex()] <- [projectile, Time()]

					PopExtUtil.SetDestroyCallback(projectile, function() {
						if ("ActiveProjectiles" in owner_scope.Preserved && self.entindex() in owner_scope.Preserved.ActiveProjectiles)
							delete owner_scope.Preserved.ActiveProjectiles[self.entindex()]
					})
				}

				if (!("ProjectileThinkTable" in scope))
					scope.ProjectileThinkTable <- {}

				scope.ProjectileThink <- function ()
				{
					foreach (name, func in scope.ProjectileThinkTable)
						func.call(scope)

					return -1
				}

				_AddThinkToEnt(projectile, "ProjectileThink")

				projectile.AddEFlags(EFL_USER)
			}
		}

		function DragonsFuryFix() { return }
		function FastNPCUpdate() { return }
	}

	SpawnHookTable = {

		function ScoutBetterMoneyCollection() { return }
		function RemoveYERAttribute() { return }
		function HoldFireUntilFullReloadFix() { return }
		function EngineerBuildingPushbackFix() { return }

		// function RestoreGiantFootsteps(params) {

		// 	local player = GetPlayerFromUserID(params.userid)

		// 	if (!player.IsBotOfType(TF_BOT_TYPE) || !player.IsMiniBoss()) return
		// 	player.AddCustomAttribute("override footstep sound set", 0, -1)

		// 	local validclasses = {
		// 		[TF_CLASS_SCOUT] = null,
		// 		[TF_CLASS_SOLDIER] = null,
		// 		[TF_CLASS_PYRO] = null ,
		// 		[TF_CLASS_DEMOMAN] = null ,
		// 		[TF_CLASS_HEAVYWEAPONS] = null
		// 	}

		// 	if (!(player.GetPlayerClass() in validclasses)) return

		// 	local cstring = PopExtUtil.Classes[player.GetPlayerClass()]

		// 	player.ValidateScriptScope()
		// 	local scope = player.GetScriptScope()

		// 	scope.stepside <- GetPropInt(player, "m_Local.m_nStepside")
		// 	scope.stepcount <- 0
		// 	scope.PlayerThinkTable.RestoreGiantFootsteps <- function() {

		// 		if ((GetPropInt(player, "m_Local.m_nStepside")) == scope.stepside) return
		// 		// if (GetPropFloat(player, "m_flStepSoundTime") != 400) return

		// 		printl(GetPropFloat(player, "m_flStepSoundTime"))


		// 		local footstepsound = format("^mvm/giant_%s/giant_%s_step_0%d.wav", cstring, cstring, RandomInt(1, 4))

		// 		if (player.GetPlayerClass() == TF_CLASS_DEMOMAN)
		// 			footstepsound = format("^mvm/giant_demoman/giant_demoman_step_0%d.wav", RandomInt(1, 4))

		// 		else if (player.GetPlayerClass() == TF_CLASS_SOLDIER || player.GetPlayerClass() == TF_CLASS_HEAVYWEAPONS)
		// 			footstepsound = format("^mvm/giant_%s/giant_%s_step0%d.wav", cstring, cstring, RandomInt(1, 4))

		// 		PrecacheSound(footstepsound)
		// 		player.EmitSound(footstepsound)

		// 		scope.stepside = (GetPropInt(player, "m_Local.m_nStepside"))
		// 	}
		// }

	}

	InitWaveTable = {}

	TakeDamageTable = {
		function YERDisguiseFix() { return }
		function LooseCannonFix() { return }
		function BotGibFix() { return }
		function HolidayPunchFix() { return }
	}

	DisconnectTable = {}

	DeathHookTable = {
		function NoCreditVelocity() { return }
	}

	Events = { function GameEvent_mvm_wave_complete(params) { delete GlobalFixes } }
}
__CollectGameEventCallbacks(GlobalFixes.Events)

GlobalFixesEntity.ValidateScriptScope()

GlobalFixesEntity.GetScriptScope().GlobalFixesThink <- function() {
	foreach(func in GlobalFixes.ThinkTable) func()
	return -1
}

AddThinkToEnt(GlobalFixesEntity, "GlobalFixesThink")
