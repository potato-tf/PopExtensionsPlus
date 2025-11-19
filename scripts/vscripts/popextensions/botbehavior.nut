class PopExtPathPoint {

	constructor( area, pos, how ) {

		this.area = area
		this.pos  = pos
		this.how  = how
	}

	area = null
	pos  = null
	how  = null
}

class PopExtBotBehavior {

	STR_PROJECTILES 	= "tf_projectile*"
	MAX_RECOMPUTE_TIME  = 3.0
	MAX_THREAT_DISTANCE = 32.0 * 32.0 // use LengthSqr for performance
	
	bot   = null
	scope = null
	team  = null
	time  = null

	bot_level   = null
	locomotion = null

	cur_pos     = null
	cur_vel     = null
	cur_speed   = null
	cur_eye_pos = null
	cur_eye_ang = null
	cur_eye_fwd = null
	cur_weapon  = null
	cur_ammo    = null
	cur_melee   = null

	threat              = null
	threat_dist         = null
	threat_time         = null
	threat_lost_time    = null
	threat_aim_time     = null
	threat_behind_time  = null
	threat_visible      = null
	threat_pos          = null

	path_points		    = null
	skip_corners		= null
	path_index			= null
	path_count			= null
	path_areas			= null
	path_goalpoint      = null
	path_recompute_time	= null

	fire_next_time  = null
	aim_time        = null
	random_aim_pos  = null
	random_aim_time = null

	cosmetic = null

	path_debug = null

	constructor( bot ) {

		this.bot       = bot
		this.scope     = bot.GetScriptScope()
		this.team      = bot.GetTeam()
		this.cur_eye_ang = bot.EyeAngles()
		this.cur_eye_pos = bot.EyePosition()
		this.cur_eye_fwd = bot.EyeAngles().Forward()
		this.locomotion = bot.GetLocomotionInterface()

		this.time = Time()

		this.threat 			= null
        this.threat_dist        = 0.0
		this.threat_time        = 0.0
		this.threat_lost_time   = 0.0
		this.threat_aim_time    = 0.0
		this.threat_behind_time = 0.0
		this.threat_visible     = false
		this.fire_next_time     = 0.0
		this.aim_time           = FLT_MAX
		this.random_aim_time    = 0.0

		this.path_points 		 = []
		this.path_index 		 = 0
		this.path_count 		 = 0
		this.path_areas 		 = {}
		this.skip_corners		 = false
		this.path_goalpoint 	 = null
		this.path_recompute_time = 0.0

		this.bot_level = bot.GetDifficulty()

		this.path_debug = false
	}

	function IsLookingTowards( target, cos_tolerance ) {
		local to_target = target - bot.EyePosition()
		to_target.Norm()
		local dot = cur_eye_fwd.Dot( to_target )
		return ( dot >= cos_tolerance )
	}

	function IsInFieldOfView( target ) {
		local tolerance = 0.5736 // cos( 110/2 )

		local delta = target.GetOrigin() - cur_eye_pos
		delta.Norm()
		if ( cur_eye_fwd.Dot( target ) >= tolerance )
			return true

		delta = target.GetCenter() - cur_eye_pos
		delta.Norm()
		if ( cur_eye_fwd.Dot( delta ) >= tolerance )
			return true

		delta = target.EyePosition() - cur_eye_pos
		delta.Norm()
		return ( cur_eye_fwd.Dot( delta ) >= tolerance )
	}

	function IsVisible( target ) {

		if ( !target || !target.IsValid() )
			return false

		local trace = {
			start  = bot.EyePosition(),
			end    = target.EyePosition(),
			mask   = MASK_OPAQUE,
			ignore = bot
		}
		TraceLineEx( trace )
		return !trace.hit
	}

	function IsThreatVisible( target ) 		{ return threat_visible = ( IsInFieldOfView( target ) && IsVisible( target ) ), threat_visible }

	function GetThreatDistance( target ) 	{ return ( ( target.GetOrigin() || Vector() ) - cur_pos ).Length() }

    function GetThreatDistance2D( target ) 	{ return ( ( target.GetOrigin() || Vector() ) - cur_pos ).Length2D() }

	function GetThreatDistanceSqr( target ) { return ( ( target.GetOrigin() || Vector() ) - cur_pos ).LengthSqr() }

	function IsCurThreatVisible() 			{ return threat_visible = ( IsInFieldOfView( threat ) && IsVisible( threat ) ), threat_visible }

	function GetCurThreatDistance() 		{ return ( ( threat_pos || Vector() ) - ( cur_pos || Vector() ) ).Length() }

	function GetCurThreatDistanceSqr() 		{ return ( ( threat_pos || Vector() ) - ( cur_pos || Vector() ) ).LengthSqr() }

	function GetCurThreatDistanceSqr2D() 	{ return ( ( threat_pos || Vector() ) - ( cur_pos || Vector() ) ).Length2DSqr() }

	function FindClosestThreat( min_dist_sqr, must_be_visible = true ) {

		local closest_threat = null
		local closest_threat_dist = min_dist_sqr

		foreach ( player in PopExtUtil.PlayerArray ) {

			if ( !player || !player.IsValid() )
				continue

			else if ( !player.IsAlive() || player.GetTeam() == bot.GetTeam() || ( must_be_visible && !IsThreatVisible( player ) ) )
				continue

			local dist = GetThreatDistanceSqr( player )

			if ( dist < closest_threat_dist ) {

				closest_threat = player
				closest_threat_dist = dist
			}
		}

		if ( path_debug && closest_threat )
			DebugDrawLine( bot.GetOrigin(), closest_threat.GetOrigin(), 255, 0, 0, false, 5.0 )

		return closest_threat
	}

	function CollectThreats( maxdist = INT_MAX, disguised = false, invisible = false, alive = true ) {

		local threatarray = []
		foreach ( player in PopExtUtil.PlayerArray ) {

			if ( player == bot ||
				player.GetTeam() == bot.GetTeam() ||
				( player.IsFullyInvisible() && !invisible ) ||
				( player.IsStealthed() && !disguised ) ||
				( alive && !player.IsAlive() ) ||
				GetThreatDistanceSqr( player ) > maxdist )
				continue

			threatarray.append( player )
		}
		return threatarray
	}

	function SetThreat( target, visible = true ) {

		if ( !target || !target.IsValid() )
			return threat = null

		threat 			   = target
		threat_pos 		   = ( threat || worldspawn ).GetOrigin()
		threat_visible 	   = visible
		threat_time 	   = time
		threat_behind_time = time + 0.5
	}


	// function SwitchToBestWeapon() {
	// 	local weapon = bot.GetActiveWeapon()
	// }

	function CheckForProjectileThreat() {

		for ( local projectile; projectile = FindByClassname( projectile, STR_PROJECTILES ); ) {

			if ( projectile.GetTeam() == team || !IsValidProjectile( projectile ) )
				continue

			local dist = GetThreatDistanceSqr( projectile )
			if ( dist <= 67000 && IsVisible( projectile ) ) {

				switch ( bot_level ) {
				case 1: // Normal Skill, only deflect if in FOV
					if ( !IsInFieldOfView( projectile ) )
						return
				break

				case 2: // Hard skill, deflect regardless of FOV
					LookAt( projectile.GetOrigin(), INT_MAX, INT_MAX )
				break

				case 3: // Expert skill, deflect regardless of FOV back to Sender
					local owner = projectile.GetOwner()
					if ( owner != null ) {
						// local owner_head = owner.GetAttachmentOrigin( owner.LookupAttachment( "head" ) )
						// LookAt( owner_head, INT_MAX, INT_MAX )
						LookAt( owner.EyePosition(), INT_MAX, INT_MAX )
					}
				break
				}
				bot.PressAltFireButton()
			}
		}
	}

	function LookAt( target_pos, min_rate, max_rate ) {

		local dt  = FrameTime()
		local dir = target_pos - cur_eye_pos
		dir.Norm()
		local dot = cur_eye_fwd.Dot( dir )

		local desired_angles = PopExtUtil.VectorAngles( dir )

		local rate_x = PopExtUtil.RemapValClamped( fabs( PopExtUtil.NormalizeAngle( cur_eye_ang.x ) - PopExtUtil.NormalizeAngle( desired_angles.x ) ), 0.0, 180.0, min_rate, max_rate )
		local rate_y = PopExtUtil.RemapValClamped( fabs( PopExtUtil.NormalizeAngle( cur_eye_ang.y ) - PopExtUtil.NormalizeAngle( desired_angles.y ) ), 0.0, 180.0, min_rate, max_rate )

		if ( dot > 0.7 ) {
			local t = PopExtUtil.RemapValClamped( dot, 0.7, 1.0, 1.0, 0.05 )
			local d = sin( 1.57 * t ) // pi/2
			rate_x *= d
			rate_y *= d
		}

		cur_eye_ang.x = PopExtUtil.NormalizeAngle( PopExtUtil.ApproachAngle( desired_angles.x, cur_eye_ang.x, rate_x * dt ) )
		cur_eye_ang.y = PopExtUtil.NormalizeAngle( PopExtUtil.ApproachAngle( desired_angles.y, cur_eye_ang.y, rate_y * dt ) )

		bot.SnapEyeAngles( cur_eye_ang )
	}

	function FireWeapon() {

		if ( cur_melee ) {
			if ( threat != null ) {
				if ( threat_dist < 16384.0 ) // 128
					bot.PressFireButton( 0.2 )
			}

			return true
		}

		if ( fire_next_time > time ) {
			bot.AddBotAttribute( IGNORE_ENEMIES )
			bot.PressFireButton()
			bot.RemoveBotAttribute( IGNORE_ENEMIES )
			return false
		}

		if ( cur_ammo == 0 )
			return false

		local duration     = 0.11
		local velocity_max = 50.0

		if ( 1 )
			if ( cur_speed < velocity_max )
				bot.PressFireButton( duration )
		else
			fire_next_time = time + RandomFloat( 0.3, 0.6 )

		return true
	}

	function StartAimWithWeapon() {
		if ( aim_time != FLT_MAX )
			return

		bot.PressAltFireButton( INT_MAX )
		aim_time = time
	}

	function EndAimWithWeapon() {
		if ( aim_time == FLT_MAX )
			return

		bot.AddBotAttribute( SUPPRESS_FIRE )
		bot.PressAltFireButton()
		bot.RemoveBotAttribute( SUPPRESS_FIRE )
		aim_time = FLT_MAX
	}

	function OnTakeDamage( attacker ) {

		if ( time - threat_time < 3.0 )
			return

		if ( attacker != bot && threat_dist > GetThreatDistanceSqr( attacker ) )
			SetThreat( attacker )
	}

	function OnUpdate() {

		cur_pos     = bot.GetOrigin()
		cur_vel     = bot.GetAbsVelocity()
		cur_speed   = cur_vel.LengthSqr()
		cur_eye_pos = bot.EyePosition()
		cur_eye_ang = bot.EyeAngles()
		cur_eye_fwd = cur_eye_ang.Forward()
		time = Time()

		if ( !threat || !threat.IsValid() )
			return threat = null, threat_pos = Vector()

		threat_pos  = threat.GetOrigin()

		return -1
	}

	function FindPathToThreat() {

		if ( path_recompute_time > time )
			return

		if ( ( !path_count ) || threat_dist > MAX_THREAT_DISTANCE ) {

			local area = GetNavArea( threat_pos, 0.0 )
			if ( area )
				UpdatePath( threat_pos, true )
		}
		threat_dist = GetCurThreatDistanceSqr()
	}

	function ResetPath() {

		path_areas.clear()
		path_points.clear()
		path_index = null
		path_count = 0
		path_recompute_time = 0
	}

	function UpdatePath( target_pos, no_corners = false, move = false, lookat = false ) {

		local dist_to_target = ( target_pos - bot.GetOrigin() ).LengthSqr()
        path_count = path_points.len() - 1

		if ( path_recompute_time < time ) {
			ResetPath()

			local pos_start = bot.GetOrigin()
			local pos_end   = target_pos

			local area_start = GetNavArea( pos_start, 128.0 )
			local area_end   = GetNavArea( pos_end, 128.0 )

			if ( !area_start )
				area_start = GetNearestNavArea( pos_start, 128.0, false, true )
			if ( !area_end )
				area_end   = GetNearestNavArea( pos_end, 128.0, false, true )

			if ( !area_start || !area_end )
				return false
			if ( !GetNavAreasFromBuildPath( area_start, area_end, pos_end, 0.0, team, false, path_areas ) )
				return false
			if ( area_start != area_end && !path_areas.len() )
				return false

			// Construct path_points
			else {

				path_areas["area"+path_areas.len()] <- area_start
				local area = path_areas["area0"]
				local area_count = path_areas.len()

				// Initial run grabbing area center
				for ( local i = 0; i < area_count && area; i++ ) {
					// Don't add a point for the end area
					if ( i > 0 )
						path_points.append( PopExtPathPoint( area, area.GetCenter(), area.GetParentHow() ) )

					area = area.GetParent()
				}

				path_points.reverse()
				path_points.append( PopExtPathPoint( area_end, pos_end, 9 ) ) // NUM_TRAVERSE_TYPES

				// Go through again and replace center with border point of next area

				local to_c1, to_c2, fr_c1, fr_c2
				for ( local i = 0; i <= path_count; i++ ) {

					if ( !( i in path_points) || !(i + 1 in path_points) )
						continue


					local path_from = path_points[i]
					local path_to = ( i < path_count ) ? path_points[i + 1] : null

					if ( path_to ) {

						local dir_to_from = path_to.area.ComputeDirection( path_from.area.GetCenter() )
						local dir_from_to = path_from.area.ComputeDirection( path_to.area.GetCenter() )

						to_c1 = path_to.area.GetCorner( dir_to_from )
						to_c2 = path_to.area.GetCorner( dir_to_from + 1 )
						fr_c1 = path_from.area.GetCorner( dir_from_to )
						fr_c2 = path_from.area.GetCorner( dir_from_to + 1 )

						local minarea = {}
						local maxarea = {}

						if ( ( to_c1 - to_c2 ).LengthSqr() < ( fr_c1 - fr_c2 ).LengthSqr() ) {

							minarea.area <- path_to.area
							maxarea.area <- path_from.area

							if ( !skip_corners ) {

								minarea.c1 <- to_c1
								minarea.c2 <- to_c2

								maxarea.c1 <- fr_c1
								maxarea.c2 <- fr_c2
							}
						}
						else {

							minarea.area <- path_from.area
							maxarea.area <- path_to.area

							if ( !skip_corners ) {

								minarea.c1 <- fr_c1
								minarea.c2 <- fr_c2

								maxarea.c1 <- to_c1
								maxarea.c2 <- to_c2
							}
						}

						// Get center of smaller area's edge between the two
						local vec = minarea.area.GetCenter()

						// don't do any corner shortcuts and follow the strict path
						if ( !skip_corners ) {

							if ( !dir_to_from || dir_to_from == 2 ) { // GO_NORTH, GO_SOUTH
								vec.y = minarea.c1.y
								vec.z = minarea.c1.z
							}
							else if ( dir_to_from == 1 || dir_to_from == 3 ) { // GO_EAST, GO_WEST
								vec.x = minarea.c1.x
								vec.z = minarea.c1.z
							}
						}
						path_from.pos = vec
					}
				}
			}

			// Base recompute off distance to target
			// Every 500hu away increase our recompute time by 0.1s
			local path_recompute_mod = 0.1 * ( dist_to_target / 250000 ) // 500^2 = 250000

			path_recompute_time = time + ( path_recompute_mod > MAX_RECOMPUTE_TIME ? MAX_RECOMPUTE_TIME : path_recompute_mod )
		}

		if ( path_index == null )
			path_index = path_count

		if ( !(path_index in path_points) || ( path_points[path_index].pos - bot.GetOrigin() ).LengthSqr() < 64.0 ) {

			// path_index++

			// printf( "path_index: %d path_count: %d dist_to_target: %f\n", path_index, path_count, dist_to_target )
			// if ( path_index >= path_count )
			return ResetPath()
		}

		if ( path_debug ) {

			for ( local i = 0; i <= path_count; i++ ) {
				if ( i in path_points && path_debug )
					DebugDrawLine( path_points[i].pos, path_points[ i+1 < path_count ? i+1 : i ].pos, 0, 0, 255, false, 0.1 )
				// else
					// __DumpScope( 0, path_points )
			}

			local area_count = path_areas.len()

			for ( local i = 0, _area = path_areas["area0"]; i < area_count; i++ ) {
				
				if ( !_area ) continue

				local x = ( ( area_count - i - 0.0 ) / area_count ) * 255.0
				_area.DebugDrawFilled( 0, x, 0, 50, 0.075, true, 0.0 )

				_area = _area.GetParent()
			}
		}

		if ( move && threat && threat.IsValid() )
			MoveToThreat( lookat )			
	}

	function MoveToThreat( lookat = true, turnrate_min = 600, turnrate_max = 1500 ) {

		// if ( !(path_index in path_points) )
		// 	__DumpScope( 0, path_points )

		if ( !threat || !threat.IsValid() )
			return

		// we're underwater or very close and can see our target, just move directly at them
		if ( ( bot.GetWaterLevel() >= 2 || threat_dist <= MAX_THREAT_DISTANCE ) && IsVisible( threat ) ) {

			locomotion.Approach( threat_pos, 0.0 )
			locomotion.FaceTowards( threat_pos )
			return
		}

		if ( path_index == null || !( path_index in path_points ) )
			return UpdatePath( threat_pos, true )

		local point = path_points[0].pos

		local frac = locomotion.FractionPotentiallyTraversable( cur_pos, point, true )

		if ( frac < 0.05 ) {
			
			if ( path_debug ) {

				// printf( "UPDATING PATH! bot: %s frac: %.2f\n", bot.tostring(), frac )
				DebugDrawText( cur_pos, "UPDATING PATH! bot: " + bot.tostring() + " frac: " + frac.tostring(), false, 0.1 )
				DebugDrawLine( cur_pos, point, 255, 0, 100, false, 0.1 )

				if ( bot.GetLastKnownArea() )
					bot.GetLastKnownArea().DebugDrawFilled( 0, 0, 255, 255, 5.0, true, 0.0 )
			}

			return UpdatePath( threat_pos, true )
		}

		if ( bot.GetLastKnownArea() == GetNearestNavArea( point, MAX_THREAT_DISTANCE, false, false ) )
			return path_points.remove( 0 ), path_index ? path_index-- : path_index

		locomotion.FaceTowards( point )
		locomotion.Approach( point, 0.0 )
		// locomotion.DriveTo( point )

		local look_pos = Vector( point.x, point.y, cur_eye_pos.z )

		if ( lookat )
			LookAt( look_pos, turnrate_min, turnrate_max )

		if ( path_debug ) {

			DebugDrawLine( cur_pos, point, 255, 0, 200, false, 0.1 )

			local area_count = path_areas.len()

			local i = 0
			foreach( area in path_areas ) {

				i++
				local x = ( ( area_count - i - 0.0 ) / area_count ) * 255.0
				area.DebugDrawFilled( x, (x / 2), 0, 50, 0.075, true, 0.0 )
			}
		}
		// unstuck behavior, tell the bot to path to another nearby area
		// if we're really stuck, teleport the bot somewhere safe
		local stucktime = locomotion.GetStuckDuration()

		if ( stucktime > 3.0 && path_recompute_time <= time ) {

			path_recompute_time = time + 3.0
			local area = bot.GetLastKnownArea()
			
			if ( !area ) {

				GetNavAreasInRadius( cur_pos, 192.0, areas )
				area = areas.values()[ RandomInt( 0, areas.len() - 1 ) ]
			}
			// no nearby nav, just kill and respawn
			if ( !area )
				PopExtUtil.KillPlayer( bot )

			else {

				// if ( b.path_debug ) {

				// 	printf( "bot %s STUCK!\n pos: %s stuck time: %.2f last known area: '%s'\n", self.tostring(), b.cur_pos.ToKVString(), stucktime, ""+area )
				// 	SetPropBool( bot, "m_bGlowEnabled", stucktime > 5.0 )
				// }
		
				for ( local navdir = 0, center, new_area; navdir < NUM_DIRECTIONS; navdir++ ) {

					new_area = area.GetRandomAdjacentArea( navdir )

					if ( !new_area )
						continue

					center = new_area.GetCenter()

					// 256 hu^2
					if ( ( center - cur_pos ).LengthSqr() <= 65535.0 ) {

						if ( path_debug ) {

							DebugDrawText( center, "bot " + bot.tostring() + " moved to '" + center.ToKVString() + "'", false, 0.1 )
							new_area.DebugDrawFilled( 255, 0, 255, 80, 5.0, true, 0.0 )
						}

						// very stuck, probably in world geometry/map entity
						if ( stucktime > 15.0 ) {

							bot.SetAbsOrigin( center + Vector( 0, 0, 20 ) )
							locomotion.ClearStuckStatus( "Moved to new nav area" )
							stucktime = 0.0
							SetThreat( null )
						}

						UpdatePath( center, skip_corners = !skip_corners, true )
						break
					}

					if ( path_debug )
						new_area.DebugDrawFilled( 255, 255, 0, 50, 0.02, true, 0.0 )
				}
			}
			// area.MarkAsBlocked( TEAM_ZOMBIE )
		}
	}
}

POP_EVENT_HOOK( "player_hurt", "BotBehaviorPlayerHurt", function( params ) {

	local attacker = GetPlayerFromUserID( params.attacker )
	local scope = GetPlayerFromUserID( params.userid ).GetScriptScope()

	if ( attacker && attacker.IsPlayer() && "aibot" in scope )
		scope.aibot.OnTakeDamage( attacker )

})
