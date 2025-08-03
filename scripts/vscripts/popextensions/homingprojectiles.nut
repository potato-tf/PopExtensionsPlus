local scope = PopExtMain.CreateScope( "__popext_homing" )
::PopExtHoming <- scope.Scope

// Modify the AttachProjectileThinker function to accept projectile speed adjustment if needed
function PopExtHoming::AttachProjectileThinker( projectile, speed_mult, turn_power, ignore_disguised_spies = true, ignore_stealthed_spies = true ) {

    projectile.ValidateScriptScope()
    local projectile_scope = projectile.GetScriptScope()
    if ( !( "speedmultiplied" in projectile_scope ) ) projectile_scope.speedmultiplied <- false

    local projectile_speed = projectile.GetAbsVelocity().Norm()

    if ( !projectile_scope.speedmultiplied ) {
        projectile_speed *= speed_mult
        projectile_scope.speedmultiplied = true
    }

    projectile_scope.turn_power			  <- turn_power
    projectile_scope.projectile_speed	  <- projectile_speed
    projectile_scope.ignore_disguised_spies <- ignore_disguised_spies
    projectile_scope.ignore_stealthed_spies <- ignore_stealthed_spies

    // sometimes this code tries to run before the table is created
    if ( !( "ProjectileThinkTable" in projectile_scope ) ) 
        projectile_scope.ProjectileThinkTable <- {}

    projectile_scope.ProjectileThinkTable.HomingProjectileThink <- PopExtHoming.HomingProjectileThink
}

function PopExtHoming::HomingProjectileThink() {

    local new_target = PopExtHoming.SelectVictim( self )
    if ( new_target != null && PopExtHoming.IsLookingAt( self, new_target ) )
        PopExtHoming.FaceTowards( new_target, self, projectile_speed )
}

function PopExtHoming::SelectVictim( projectile ) {
    local target
    local min_distance = 32768.0
    foreach ( player in PopExtUtil.HumanArray ) {

        local distance = ( projectile.GetOrigin() - player.GetOrigin() ).Length()

        if ( IsValidTarget( player, distance, min_distance, projectile ) ) {
            target = player
            min_distance = distance
        }
    }
    return target
}

function PopExtHoming::IsValidTarget( victim, distance, min_distance, projectile ) {

    local projectile_scope = projectile.GetScriptScope()
    // Early out if basic conditions aren't met
    if ( distance > min_distance || victim.GetTeam() == projectile.GetTeam() || !victim.IsAlive() ) {
        return false
    }

    // Check for conditions based on the projectile's configuration
    if ( victim.IsPlayer() ) {
        if ( victim.InCond( TF_COND_HALLOWEEN_GHOST_MODE ) ) {
            return false
        }

        // Check for stealth and disguise conditions if not ignored
        if ( !projectile_scope.ignore_stealthed_spies && ( victim.IsStealthed() || victim.IsFullyInvisible() ) ) {
            return false
        }
        if ( !projectile_scope.ignore_disguised_spies && victim.GetDisguiseTarget() != null ) {
            return false
        }
    }

    return true
}


function FaceTowards( new_target, projectile, projectile_speed ) {
    local scope = projectile.GetScriptScope()
    local desired_dir = new_target.EyePosition() - projectile.GetOrigin()

    desired_dir.Norm()

    local current_dir = projectile.GetForwardVector()
    local new_dir = current_dir + ( desired_dir - current_dir ) * scope.turn_power
    new_dir.Norm()

    local move_ang = PopExtUtil.VectorAngles( new_dir )
    local projectile_velocity = move_ang.Forward() * projectile_speed

    projectile.SetAbsVelocity( projectile_velocity )
    projectile.SetLocalAngles( move_ang )
}

function PopExtHoming::IsLookingAt( projectile, new_target ) {
    local target_origin = new_target.GetOrigin()
    local projectile_owner = projectile.GetOwner()
    local projectile_owner_pos = projectile_owner.EyePosition()

    if ( TraceLine( projectile_owner_pos, target_origin, projectile_owner ) ) {
        local direction = ( target_origin - projectile_owner.EyePosition() )
            direction.Norm()
        local product = projectile_owner.EyeAngles().Forward().Dot( direction )

        if ( product > 0.6 )
            return true
    }

    return false
}

function PopExtHoming::IsValidProjectile( projectile, table ) {
    if ( projectile.GetClassname() in table )
        return true

    return false
}