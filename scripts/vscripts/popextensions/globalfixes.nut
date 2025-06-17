// most global fixes have been moved to missionattributes.nut
// piles of dummy functions are here for backwards compatibility
// these will be removed once red ridge is updated to remove `delete GlobalFixes.ThinkTable.HolidayPunchFix`

const EFL_USER = 1048576

local GlobalFixesEntity = FindByName( null, "__popext_globalfixes" )
if ( GlobalFixesEntity == null ) GlobalFixesEntity = SpawnEntityFromTable( "info_teleport_destination", { targetname = "__popext_globalfixes" } )

::GlobalFixes <- {

	ThinkTable = {

		//add think table to all projectiles
		//there is apparently no better way to do this lol
		function AddProjectileThink() {

			for ( local projectile; projectile = FindByClassname( projectile, "tf_projectile*" ); ) {
				if ( projectile.GetEFlags() & EFL_USER ) continue

				projectile.ValidateScriptScope()
				local scope = projectile.GetScriptScope()
				local owner = projectile.GetOwner()

				if ( owner && owner.IsValid() ) {

					local owner_scope = owner.GetScriptScope()
					if ( !owner_scope ) {

						owner.ValidateScriptScope()
						owner_scope = owner.GetScriptScope()
					}

					// this should not be a thing.  Preserved gets added in player_spawn but we still get does not exist errors
					if ( !( "Preserved" in owner_scope ) )
						owner_scope.Preserved <- {}

					if ( !( "ActiveProjectiles" in owner_scope.Preserved ) )
						owner_scope.Preserved.ActiveProjectiles <- {}

					owner_scope.Preserved.ActiveProjectiles[projectile.entindex()] <- [projectile, Time()]

					PopExtUtil.SetDestroyCallback( projectile, function() {
						if ( "ActiveProjectiles" in owner_scope.Preserved && self.entindex() in owner_scope.Preserved.ActiveProjectiles )
							delete owner_scope.Preserved.ActiveProjectiles[self.entindex()]
					})
				}

				if ( !( "ProjectileThinkTable" in scope ) )
					scope.ProjectileThinkTable <- {}

				scope.ProjectileThink <- function () {

					foreach ( name, func in scope.ProjectileThinkTable )
						func.call( scope )

					return -1
				}

				_AddThinkToEnt( projectile, "ProjectileThink" )

				projectile.AddEFlags( EFL_USER )
			}
		}
	}
}

GlobalFixesEntity.ValidateScriptScope()

GlobalFixesEntity.GetScriptScope().GlobalFixesThink <- function() {
	foreach( func in GlobalFixes.ThinkTable ) func()
	return -1
}

AddThinkToEnt( GlobalFixesEntity, "GlobalFixesThink" )
