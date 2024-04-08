class AI_Bot {
	function constructor(bot) {
		this.bot       = bot
		this.scope     = bot.GetScriptScope()
		this.team      = bot.GetTeam()
		// this.cur_ammo  = 0
		// this.cur_melee = false
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

		this.path = []
		this.path_index = 0
		this.path_areas = {}
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
			mask   = CONST.MASK_OPAQUE,
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

	function FindThreat(min_dist_sqr, must_be_visible = true) {
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

		// foreach (k, v in bot.GetLocomotionInterface()) 
		// printl(bot.GetLocomotionInterface())
		// printl(bot.GetVisionInterface())
		foreach (_, func in scope.PlayerThinkTable) func()

		//SwitchToBestWeapon()
		//DrawDebugInfo()

		return -1
	}
	function FindPathToThreat()
	{
		if (path_recompute_time < time)
		{
			local threat_cur_pos = threat.GetOrigin()
			
			if ((path.len() == 0) || ((threat_pos - threat_cur_pos).LengthSqr() > 4096.0)) // 64
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
		path.clear()
		path_index = 0

		local kill = []
		for (local rope; rope = FindByName(rope, "__rope");) kill.append(rope)

		foreach (k in kill) k.Kill()
	}
	function UpdatePathAndMove(target_pos)
	{
		ResetPath()
		local pos_start = bot.GetOrigin()
		local pos_end = target_pos

		
		local area_start = GetNavArea(pos_start, 128.0)
		local area_end = GetNavArea(pos_end, 128.0)

		if (area_start == null)
			area_start = GetNearestNavArea(pos_start, 128.0, false, true)
		if (area_end == null)
			area_end = GetNearestNavArea(pos_end, 128.0, false, true)

		if (area_start == null || area_end == null)
			return false

		GetNavAreasFromBuildPath(area_start, area_end, pos_end, 0.0, TEAM_ANY, false, path_areas)
		
		foreach (name, area in path_areas)
		{
			local navareasize = (area.GetSizeX() * area.GetSizeY())
			local vec_max = bot.GetBoundingMaxs(), vec_min = bot.GetBoundingMins()
			
			local diff_x = vec_max.x - vec_min.x
			local diff_y = vec_max.y - vec_min.y
			local diff_z = vec_max.z - vec_min.z

			# Calculate areas of faces
			// local area_x = diff_y * diff_z
			// local area_y = diff_x * diff_z 
			// local area_z = diff_x * diff_y 

			# Total surface area
			local botareasize = diff_x * diff_y  # Two faces per axis
			// printl(navareasize + " : " + botareasize)

			local adjacentcount = 0
			for (local i = 0; i < NUM_DIRECTIONS; i++)
				if (area.GetAdjacentCount(i) != 0) adjacentcount++

			// likely a corner nav square we'll get stuck on
			if (navareasize < botareasize && adjacentcount < 4)
			{
				if (navdebug)
				{
					area.DebugDrawFilled(255, 0, 0, 255, 1.0, true, SINGLE_TICK)
					DebugDrawText(area.GetCenter()+ Vector(0, 0, 10), "TOO SMALL!", false, SINGLE_TICK)
				}

				local potentialareas = {}

				//check all surrounding connected nav areas
				for (local i = 0; i < NUM_DIRECTIONS; i++)
					area.GetAdjacentAreas(i, potentialareas)
				
				
				foreach (_, a in potentialareas)
				{
					local potentialadjacentcount = 0

					for (local i = 0; i < NUM_DIRECTIONS; i++)
						if (a.GetAdjacentCount(i) != 0) potentialadjacentcount++

					if (potentialadjacentcount < 4 || a.GetSizeX() * a.GetSizeY() < botareasize) continue
	
					if (navdebug)
						a.DebugDrawFilled(0, 0, 255, 255, 1.0, true, SINGLE_TICK)

					// area = a
					break
				}
			}

			path.append(area)
			if (navdebug)
				DebugDrawText(area.GetCenter(), name, false, SINGLE_TICK)
		}

		if (navdebug)
			foreach (p in path)
				p.DebugDrawFilled(0, 255, 0, 254, 1.0, true, SINGLE_TICK)
			
		if (path.len())
			locomotion.Approach(path[0].FindRandomSpot(), 1.0)
		
		// if (bot.GetOrigin() - path[0].GetCenter().LengthSqr() < 50.0) path.remove(0)

	}


	bot   = null
	scope = null
	team  = null
	time  = null

	botLevel = null
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

	path				= null
	path_index			= null
	path_areas			= null
	path_recompute_time	= null

	fire_next_time  = null
	aim_time        = null
	random_aim_pos  = null
	random_aim_time = null

	cosmetic = null

	navdebug = null
}
