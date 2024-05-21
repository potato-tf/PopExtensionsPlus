class PathPoint {
	constructor(area, pos, how) {
		this.area = area
		this.pos  = pos
		this.how  = how
	}

	area = null
	pos  = null
	how  = null
}

class AI_Bot {
	function constructor(bot) {
		this.bot       = bot
		this.scope     = bot.GetScriptScope()
		this.team      = bot.GetTeam()
		this.cur_eye_ang = bot.EyeAngles()
		this.cur_eye_pos = bot.EyePosition()
		this.cur_eye_fwd = bot.EyeAngles().Forward()
		this.locomotion = bot.GetLocomotionInterface()

		this.time = Time()

		this.threat 			= null
		this.threat_time        = 0.0
		this.threat_lost_time   = 0.0
		this.threat_aim_time    = 0.0
		this.threat_behind_time = 0.0
		this.threat_visible     = false
		this.fire_next_time     = 0.0
		this.aim_time           = FLT_MAX
		this.random_aim_time    = 0.0

		this.path_points = []
		this.path_index = 0
		this.path_areas = {}
		this.path_goalpoint = null
		this.path_recompute_time = 0.0

		this.botLevel = bot.GetDifficulty()

		this.navdebug = false
	}

	function IsLookingTowards(target, cos_tolerance) {
		local to_target = target - bot.EyePosition()
		to_target.Norm()
		local dot = cur_eye_fwd.Dot(to_target)
		return (dot >= cos_tolerance)
	}

	function IsInFieldOfView(target) {
		local tolerance = 0.5736 // cos(110/2)

		local delta = target.GetOrigin() - cur_eye_pos
		delta.Norm()
		if (cur_eye_fwd.Dot(target) >= tolerance)
			return true

		delta = target.GetCenter() - cur_eye_pos
		delta.Norm()
		if (cur_eye_fwd.Dot(delta) >= tolerance)
			return true

		delta = target.EyePosition() - cur_eye_pos
		delta.Norm()
		return (cur_eye_fwd.Dot(delta) >= tolerance)
	}

	function IsVisible(target) {
		local trace = {
			start  = bot.EyePosition(),
			end    = target.EyePosition(),
			mask   = MASK_OPAQUE,
			ignore = bot
		}
		TraceLineEx(trace)
		return !trace.hit
	}

	function IsThreatVisible(target) {
		return IsInFieldOfView(target) && IsVisible(target)
	}

	function GetThreatDistanceSqr(target) {
		return (target.GetOrigin() - bot.GetOrigin()).LengthSqr()
	}

	function FindClosestThreat(min_dist_sqr, must_be_visible = true) {
		local closestThreat = null
		local closestThreatDist = min_dist_sqr

		foreach (player in PopExtUtil.PlayerArray) {

			if (player == bot || !PopExtUtil.IsAlive(player) || player.GetTeam() == team || (must_be_visible && !IsThreatVisible(player))) continue

			local dist = GetThreatDistanceSqr(player)
			if (dist < closestThreatDist) {
				closestThreat = player
				closestThreatDist = dist
			}
		}
		return closestThreat
	}

	function CollectThreats(maxdist = INT_MAX, disguised = false, invisible = false) {
		
		local threatarray = []
		foreach (player in PopExtUtil.PlayerArray)
		{
			if (player == bot || player.GetTeam() == bot.GetTeam() || (player.IsFullyInvisible() && !invisible) || (player.IsStealthed() && !disguised) || GetThreatDistanceSqr(player) > maxdist) continue

			threatarray.append(player)
		}
		return threatarray
	}

	function SetThreat(target, visible) {
		threat = target
		threat_pos = threat.GetOrigin()
		threat_visible = visible
		threat_behind_time = time + 0.5
	}

	function SwitchToBestWeapon() {
		local weapon = bot.GetActiveWeapon()
	}

	function CheckForProjectileThreat() {
		local projectile
		while ((projectile = FindByClassname(projectile, STR_PROJECTILES)) != null) {
			if (projectile.GetTeam() == team || !IsValidProjectile(projectile))
				continue

			local dist = GetThreatDistanceSqr(projectile)
			if (dist <= 67000 && IsVisible(projectile)) //67700
			{
				switch (botLevel) {
				case 1: // Normal Skill, only deflect if in FOV
					if (!IsInFieldOfView(projectile))
						return
				break

				case 2: // Hard skill, deflect regardless of FOV
					LookAt(projectile.GetOrigin(), INT_MAX, INT_MAX)
				break

				case 3: // Expert skill, deflect regardless of FOV back to Sender
					local owner = projectile.GetOwner()
					if (owner != null) {
						// local owner_head = owner.GetAttachmentOrigin(owner.LookupAttachment("head"))
						// LookAt(owner_head, INT_MAX, INT_MAX)
						LookAt(owner.EyePosition(), INT_MAX, INT_MAX)
					}
				break
				}
				bot.PressAltFireButton()
			}
		}
	}

	function LookAt(target_pos, min_rate, max_rate) {
		local dt  = FrameTime()
		local dir = target_pos - cur_eye_pos
		dir.Norm()
		local dot = cur_eye_fwd.Dot(dir)

		local desired_angles = PopExtUtil.VectorAngles(dir)

		local rate_x = PopExtUtil.RemapValClamped(fabs(PopExtUtil.NormalizeAngle(cur_eye_ang.x) - PopExtUtil.NormalizeAngle(desired_angles.x)), 0.0, 180.0, min_rate, max_rate)
		local rate_y = PopExtUtil.RemapValClamped(fabs(PopExtUtil.NormalizeAngle(cur_eye_ang.y) - PopExtUtil.NormalizeAngle(desired_angles.y)), 0.0, 180.0, min_rate, max_rate)

		if (dot > 0.7) {
			local t = PopExtUtil.RemapValClamped(dot, 0.7, 1.0, 1.0, 0.05)
			local d = sin(1.57 * t) // pi/2
			rate_x *= d
			rate_y *= d
		}

		cur_eye_ang.x = PopExtUtil.NormalizeAngle(PopExtUtil.ApproachAngle(desired_angles.x, cur_eye_ang.x, rate_x * dt))
		cur_eye_ang.y = PopExtUtil.NormalizeAngle(PopExtUtil.ApproachAngle(desired_angles.y, cur_eye_ang.y, rate_y * dt))

		bot.SnapEyeAngles(cur_eye_ang)
	}

	//260 Hammer Units or 67700 SQR
	function FireWeapon() {
		if (cur_melee) {
			if (threat != null) {
				local threat_dist = GetThreatDistanceSqr(threat)
				if (threat_dist < 16384.0) // 128
					bot.PressFireButton(0.2)
			}

			return true
		}

		if (fire_next_time > time) {
			bot.AddBotAttribute(IGNORE_ENEMIES)
			bot.PressFireButton()
			bot.RemoveBotAttribute(IGNORE_ENEMIES)
			return false
		}

		if (cur_ammo == 0)
			return false

		local duration     = 0.11
		local velocity_max = 50.0

		if (1)
			if (cur_vel.Length() < velocity_max)
				bot.PressFireButton(duration)
		else
			fire_next_time = time + RandomFloat(0.3, 0.6)

		return true
	}

	function StartAimWithWeapon() {
		if (aim_time != FLT_MAX)
			return

		bot.PressAltFireButton(INT_MAX)
		aim_time = time
	}

	function EndAimWithWeapon() {
		if (aim_time == FLT_MAX)
			return

		bot.AddBotAttribute(SUPPRESS_FIRE)
		bot.PressAltFireButton()
		bot.RemoveBotAttribute(SUPPRESS_FIRE)
		aim_time = FLT_MAX
	}

	function OnTakeDamage(params) {
		if (params.attacker != null && params.attacker != this && params.attacker.IsPlayer()) {
			if (threat != null && threat.IsValid()) {
				local threat_dist = GetThreatDistanceSqr(threat) * 0.8

				if (threat_dist > 16384.0) { // 128
					local attacker_dist = GetThreatDistanceSqr(params.attacker)
					local threat_dist   = GetThreatDistanceSqr(threat) * 0.8

					if (attacker_dist > threat_dist)
						return
				}
			}

			SetThreat(params.attacker, true)
		}
	}
	function OnUpdate() {
		cur_pos     = bot.GetOrigin()
		cur_vel     = bot.GetAbsVelocity()
		cur_speed   = cur_vel.Length()
		cur_eye_pos = bot.EyePosition()
		cur_eye_ang = bot.EyeAngles()
		cur_eye_fwd = cur_eye_ang.Forward()

		time = Time()

		//SwitchToBestWeapon()
		//DrawDebugInfo()

		return -1
	}
	function FindPathToThreat()
	{
		if (path_recompute_time < time)
		{
			local threat_cur_pos = threat.GetOrigin()

			if ((path_points.len() == 0) || ((threat_pos - threat_cur_pos).LengthSqr() > 4096.0)) // 64
			{
				local area = GetThreatArea(threat)
				if (area != null)
				{
					UpdatePathAndMove(threat_cur_pos)
				}

				threat_pos = threat_cur_pos
			}

			path_recompute_time = time + 0.5
		}
	}
	function ResetPath()
	{
		path_areas.clear()
		path_points.clear()
		path_index = null
		path_recompute_time = 0
	}
	function UpdatePathAndMove(target_pos)
	{
		local dist_to_target = (target_pos - bot.GetOrigin()).Length()

		if (path_recompute_time < time) {
			ResetPath()

			local pos_start = bot.GetOrigin()
			local pos_end   = target_pos

			local area_start = GetNavArea(pos_start, 128.0)
			local area_end   = GetNavArea(pos_end, 128.0)

			if (!area_start)
				area_start = GetNearestNavArea(pos_start, 128.0, false, true)
			if (!area_end)
				area_end   = GetNearestNavArea(pos_end, 128.0, false, true)

			if (!area_start || !area_end)
				return false
			if (!GetNavAreasFromBuildPath(area_start, area_end, pos_end, 0.0, Constants.ETFTeam.TEAM_ANY, true, path_areas))
				return false
			if (area_start != area_end && !path_areas.len())
				return false

			// Construct path_points
			else {
				path_areas["area"+path_areas.len()] <- area_start
				local area = path_areas["area0"]
				local area_count = path_areas.len()

				// Initial run grabbing area center
				for (local i = 0; i < area_count && area; ++i) {
					// Don't add a point for the end area
					if (i > 0)
						path_points.append(PathPoint(area, area.GetCenter(), area.GetParentHow()))

					area = area.GetParent()
				}

				path_points.reverse()
				path_points.append(PathPoint(area_end, pos_end, 9)) // NUM_TRAVERSE_TYPES

				// Go through again and replace center with border point of next area
				local path_count = path_points.len()
				for (local i = 0; i < path_count; ++i) {
					local path_from = path_points[i]
					local path_to = (i < path_count - 1) ? path_points[i + 1] : null

					if (path_to) {
						local dir_to_from = path_to.area.ComputeDirection(path_from.area.GetCenter())
						local dir_from_to = path_from.area.ComputeDirection(path_to.area.GetCenter())

						local to_c1 = path_to.area.GetCorner(dir_to_from)
						local to_c2 = path_to.area.GetCorner(dir_to_from + 1)
						local fr_c1 = path_from.area.GetCorner(dir_from_to)
						local fr_c2 = path_from.area.GetCorner(dir_from_to + 1)

						local minarea = {}
						local maxarea = {}
						if ( (to_c1 - to_c2).Length() < (fr_c1 - fr_c2).Length() ) {
							minarea.area <- path_to.area
							minarea.c1 <- to_c1
							minarea.c2 <- to_c2

							maxarea.area <- path_from.area
							maxarea.c1 <- fr_c1
							maxarea.c2 <- fr_c2
						}
						else {
							minarea.area <- path_from.area
							minarea.c1 <- fr_c1
							minarea.c2 <- fr_c2

							maxarea.area <- path_to.area
							maxarea.c1 <- to_c1
							maxarea.c2 <- to_c2
						}

						// Get center of smaller area's edge between the two
						local vec = minarea.area.GetCenter()
						if (dir_to_from == 0 || dir_to_from == 2) { // GO_NORTH, GO_SOUTH
							vec.y = minarea.c1.y
							vec.z = minarea.c1.z
						}
						else if (dir_to_from == 1 || dir_to_from == 3) { // GO_EAST, GO_WEST
							vec.x = minarea.c1.x
							vec.z = minarea.c1.z
						}

						path_from.pos = vec;
					}
				}
			}

			// Base recompute off distance to target
			// Every 500hu away increase our recompute time by 0.1s
			local mod = 0.1 * ceil(dist_to_target / 500.0)
			if (mod > 1) mod = 1

			path_recompute_time = time + mod
		}

		if (navdebug) {
			for (local i = 0; i < path_points.len(); ++i) {
				DebugDrawLine(path_points[i].pos, path_points[i].pos + Vector(0, 0, 32), 0, 0, 255, false, 0.075)
			}
			local area = path_areas["area0"]
			local area_count = path_areas.len()

			for (local i = 0; i < area_count && area; ++i) {
				local x = ((area_count - i - 0.0) / area_count) * 255.0
				area.DebugDrawFilled(0, x, 0, 50, 0.075, true, 0.0)

				area = area.GetParent()
			}
		}

		if (path_index == null)
			path_index = 0

		if ((path_points[path_index].pos - bot.GetOrigin()).Length() < 64.0) {
			++path_index
			if (path_index >= path_points.len()) {
				ResetPath()
				return
			}
		}

		local point = path_points[path_index].pos;
		locomotion.Approach(point, 999)

		local look_pos = Vector(point.x, point.y, cur_eye_pos.z);
		if (threat != null)
			LookAt(look_pos, 600.0, 1500.0);
		else
			LookAt(look_pos, 350.0, 600.0);

		// calc lookahead point

		// set eyeang based on lookahead
		// set loco on lookahead if no obstacles found
		// if found obstacle, modify loco
	}


	bot   = null
	scope = null
	team  = null
	time  = null

	botLevel   = null
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

	threat             = null
	threat_time        = null
	threat_lost_time   = null
	threat_aim_time    = null
	threat_behind_time = null
	threat_visible     = null
	threat_pos         = null

	path_points		    = null
	path_index			= null
	path_areas			= null
	path_goalpoint      = null
	path_recompute_time	= null

	fire_next_time  = null
	aim_time        = null
	random_aim_pos  = null
	random_aim_time = null

	cosmetic = null

	navdebug = null
}
