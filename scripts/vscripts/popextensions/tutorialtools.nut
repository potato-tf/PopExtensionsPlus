PrecacheSound("replay/enterperformancemode.wav");
PrecacheSound("replay/exitperformancemode.wav");

::PopExtTutorial <- {

	IsPlayingViewcontrol = false

	function round(num, decimals)
	{
		if (decimals <= 0)
			return floor(num + 0.5)
		else
		{
			local mod = pow(10, decimals)
			return floor((num * mod) + 0.5) / mod
		}
	}

	function Clamp360Angle(ang)
	{
		local t = {x = ang.x, y = ang.y, z = ang.z}

		// Clamp
		foreach (index, angle in t)
		{
			if (angle > 360 || angle < -360)
			{
				local x = fabs(angle / 360.0)
				t[index] = PopExtTutorial.round((x - floor(x)) * 360.0, 3)
			}
		}

		// Abs
		foreach (index, angle in t)
			if (angle < 0)
				t[index] = 360.0 - fabs(angle)

		return QAngle(t.x, t.y, t.z)
	}

	function DisableViewcontrolSafe(player, viewcontrol)
	{
			EntFireByHandle(player, "RunScriptCode", "self.GetScriptScope().__ls<-GetPropInt(self,`m_lifeState`);SetPropInt(self,`m_lifeState`,0)", -1, player, player)
			EntFireByHandle(viewcontrol, "RunScriptCode", "SetPropEntity(self, `m_hPlayer`, activator)", -1, player, player)
			EntFireByHandle(viewcontrol, "Disable", null, -1, player, player)
			EntFireByHandle(player, "RunScriptCode", "SetPropInt(self,`m_lifeState`,self.GetScriptScope().__ls);SetPropInt(self,`m_takedamage`,2)", -1, player, player)
	}

	// TODO:
	// - convert to quaternions instead of QAngles for better rotation
	// - look into visibility issues, camera is able to view culled geometry that the player cannot see
	// - robot models do not show while in viewcontrol
	function AnimatedViewControlAll(args = {track = [], speed_mult = 1, fadeargs = {}})
	{
		if (PopExtTutorial.IsPlayingViewcontrol) return
		local keyframes = []
		
		if ("track" in args) keyframes = args.track
		else if ("keyframes" in args) keyframes = args.keyframes

		// Quick format check
		if (!keyframes || keyframes.len() <= 1 || keyframes[0].len() < 3) return

		local camera = SpawnEntityFromTable("point_viewcontrol", { spawnflags = 8 })
		camera.ValidateScriptScope()
		AddThinkToEnt(camera, null)

		// Hack to make it so taunting doesn't fuck up the camera
		SetPropBool(PopExtUtil.GameRules, "m_bShowMatchSummary", true)

		// Put everything back to normal
		camera.GetScriptScope().CleanupCamera <- function()
		{
			SetPropBool(PopExtUtil.GameRules, "m_bShowMatchSummary", false)

			// Loop through our human players
			foreach (player in PopExtUtil.HumanArray)
			{
				player.ValidateScriptScope()
				local scope = player.GetScriptScope()

				// Disable camera
				if (camera && camera.IsValid())
					DisableViewcontrolSafe(player, camera)

				// Cleanup player
				EntFireByHandle(player, "RunScriptCode", "self.SetForceLocalDraw(false);", -1, null, null)
				local fadeparams = { target = player, r = 20, g = 20, b = 20, a = 255, fadeTime = 0.5, fadeHold = 0.5, flags = 1 }
				
				if (fadeargs.len()) fadeparams = fadeargs

				ScreenFade(player, fadeparams.r, fadeparams.g, fadeparams.b, fadeparams.a, fadeparams.fadeTime, fadeparams.fadeHold, fadeparams.flags)
				EmitSoundEx({
					sound_name = "replay/exitperformancemode.wav",
					entity	   = player,
				})
				player.RemoveCond(TF_COND_TAUNTING)
				player.AddCustomAttribute("move speed penalty", 1, -1)
			}

			if (camera && camera.IsValid())
				EntFireByHandle(camera, "Kill", "", -1, null, null)

			PopExtTutorial.IsPlayingViewcontrol = false
		}

		// Loop through our human players
		foreach (player in PopExtUtil.HumanArray)
		{
			player.ValidateScriptScope()
			player.GetScriptScope().__position <- player.GetOrigin()

			// Allow us to see ourselves while in viewcontrol
			EntFireByHandle(player, "RunScriptCode", "self.SetForceLocalDraw(true)", -1, null, null)

			// Effects
			ScreenFade(player, 20, 20, 20, 255, 0.5, 0.5, 1)
			EmitSoundEx({
				sound_name = "replay/enterperformancemode.wav",
				entity	   = player,
			})
			player.AddCustomAttribute("move speed penalty", 0.01, -1)

			// Start viewcontrol
			EntFireByHandle(camera, "Enable", "", -1, player, player)
		}

		// Setup varibles
		local start_time  = Time()
		local prev_origin = keyframes[0][1]
		local prev_angles = keyframes[0][2]
		local keyframe	  = 1

		camera.SetAbsOrigin(prev_origin)
		camera.SetAbsAngles(prev_angles)

		PopExtTutorial.IsPlayingViewcontrol = true

		// Update camera origin and angles every frame linearly towards keyframe values
		camera.GetScriptScope().CameraThink <- function()
		{
			// Stop thinking once we finish going through keyframes
			if (keyframe >= keyframes.len())
			{
				SetPropString(self, "m_iszScriptThinkFunction", "")
				CleanupCamera()
				return -1
			}

			// Gay babyjail our human players to prevent them from moving with things like conga

			foreach (player in PopExtUtil.HumanArray)
			{

				player.ValidateScriptScope()

				SetPropInt(player, "movetype", MOVETYPE_WALK)
				player.SetAbsOrigin(player.GetScriptScope().__position)
			}

			// Ignore malformed Keyframes
			if (keyframe < keyframes.len() && keyframes[keyframe].len() < 3)
			{
				keyframe = keyframe + 1
				return -1
			}

			local t = keyframes[keyframe]
			local current_time	  = Time()
			local next_time		  = t[0]
			local next_origin	  = t[1]
			local next_angles	  = Clamp360Angle(t[2])

			local should_teleport = (keyframes[keyframe].len() > 3) ? t[3] : false

			local ticks_left = floor((start_time + next_time - current_time) / SINGLE_TICK)

			if (should_teleport)
			{
				if (ticks_left > 0) return -1
				else
				{
					self.SetAbsOrigin(next_origin)
					self.SetAbsAngles(next_angles)
				}
			}

			// We're done with this keyframe
			if (ticks_left <= 0)
			{
				keyframe	= keyframe + 1
				start_time	= Time()
				prev_origin = next_origin
				prev_angles = next_angles
				return -1
			}

			// Increment our position and angles based on the total time the keyframe should take
			local pos_vector  = next_origin - self.GetOrigin()
			local ang		  = Clamp360Angle(self.GetAbsAngles())
			local ang_vector  = QAngle(next_angles.x - ang.x, next_angles.y - ang.y, next_angles.z - ang.z)
			local incr_pos	  = Vector(pos_vector.x / ticks_left, pos_vector.y / ticks_left, pos_vector.z / ticks_left)
			local incr_ang	  = QAngle(ang_vector.x / ticks_left, ang_vector.y / ticks_left, ang_vector.z / ticks_left)
			local speed_mult = args.speed_mult

			self.KeyValueFromVector("origin", self.GetOrigin() + (incr_pos * speed_mult)) //kv origin interpolates its position
			self.SetAbsAngles(self.GetAbsAngles() + incr_ang)

			return -1
		}

		AddThinkToEnt(camera, "CameraThink")

		return camera
	}
}

local keyframes = [
	[ 0.0, Vector(400, -2500, 640),	 QAngle(0, 120, 0), ],
	[ 8.0, Vector(-900, -300, 640), QAngle(0, 90, 0), ], // set this to QAngle(-10, 90, 0) to view bad rotations
	[ 2.0, Vector(0, 1800, 480), QAngle(0, 90, 0), true ],
	[ 4.0, Vector(0, 3000, 480), QAngle(0, 90, 0) ],
]

::TestViewBigrock <- function()
{
	PopExtTutorial.AnimatedViewControlAll({track = keyframes})
}

function StartTutorial(eventname)
{
    foreach(k, v in TutorialFlow.eventname)
    {
		local delay = -1 
		
		if (typeof v == "table" && "delay" in v)
			delay = v.delay

		local tutorialfunc = ""
        switch(k)
        {
            case "viewcontrol":
				tutorialfunc = "PopExtTutorial.AnimatedViewControlAll("+v+")"
			break
            
            case "annotation":
				tutorialfunc = "SendGlobalGameEvent(`show_annotation`, "+v+")"
			break
			
			case "spawntemplate":
				tutorialfunc = "SpawnTemplates.DoSpawnTemplate("+v+")"
			break
			
			case "runscriptcode":
				if (typeof v == "string")
					tutorialfunc = v
				else if (typeof v == "array" || typeof v == "table") //allow for making an array/table of things to format into a single RunScriptCode
					foreach (_, func in v) tutorialfunc += format("%s;", func)	
			break

			case "entfire":
				foreach (a, b in v)
					if (typeof b == "string")
						tutorialfunc += format("EntFire(%s, %s);", a, b)
					else if (typeof b == "array")
						if (1 in b && !(2 in b))
							tutorialfunc += format("EntFire(%s, %s, %s);", a, b[0], b[1])
						else if (2 in b && !(3 in b))
							tutorialfunc += format("EntFire(%s, %s, %s, %1.8e);", a, b[0], b[1], b[2].tofloat())
			break
        
            default:
                printl("invalid tutorial type!")
			break
        }
		EntFire("worldspawn", "RunScriptCode", tutorialfunc, delay)
    }
}

::TutorialFlow <- {
    myintrocam = { //name of tutorial event
        viewcontrol = {
            track = [Vector(), Vector()] //array of track positions to move across
            speed_mult = 20 //speed to move between track points 
            //some other parameters here
            delay = 2 //delay in seconds before this event is triggered
        }
        annotation = {
            display_text = "test"
            lifetime = 4.0
            //insert other show_annotation params here
            delay = 3 //delay in seconds before this event is triggered
        }
    }  
}
