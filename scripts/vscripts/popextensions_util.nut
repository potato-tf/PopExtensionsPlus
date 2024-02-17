// All Global Utility Functions go here, also use IncludeScript and place it inside Root


// Allow expression constants
::CONST <- getconsttable()
::ROOT <- getroottable()
CONST.setdelegate({ _newslot = @(k, v) compilestring("const " + k + "=" + (typeof(v) == "string" ? ("\"" + v + "\"") : v))() })


if (!("ConstantNamingConvention" in CONST))
{
	foreach (a,b in Constants)
		foreach (k,v in b)
            CONST[k] <- v != null ? v : 0;

	foreach (k, v in ::NetProps.getclass())
		if (k != "IsValid")
			ROOT[k] <- ::NetProps[k].bindenv(::NetProps)
}

::Classes <- ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere

// it's a table cuz much faster
::HomingProjectiles <-
{
	tf_projectile_arrow				= 1
	tf_projectile_energy_ball		= 1 // Cow Mangler
	tf_projectile_healing_bolt		= 1 // Crusader's Crossbow, Rescue Ranger
	tf_projectile_lightningorb		= 1 // Lightning Orb Spell
	tf_projectile_mechanicalarmorb	= 1 // Short Circuit
	tf_projectile_rocket			= 1
	tf_projectile_sentryrocket		= 1
	tf_projectile_spellfireball		= 1
	tf_projectile_energy_ring		= 1 // Bison
	tf_projectile_flare				= 1
}

::DeflectableProjectiles <-
{
    tf_projectile_arrow                 = 1 // Huntsman arrow, Rescue Ranger bolt
    tf_projectile_ball_ornament         = 1 // Wrap Assassin
    tf_projectile_cleaver               = 1 // Flying Guillotine
    tf_projectile_energy_ball           = 1 // Cow Mangler charge shot
    tf_projectile_flare                 = 1 // Flare guns projectile
    tf_projectile_healing_bolt          = 1 // Crusader's Crossbow
    tf_projectile_jar                   = 1 // Jarate
    tf_projectile_jar_gas               = 1 // Gas Passer explosion
    tf_projectile_jar_milk              = 1 // Mad Milk
    tf_projectile_lightningorb          = 1 // Spell Variant from Short Circuit
    tf_projectile_mechanicalarmorb      = 1 // Short Circuit energy ball
    tf_projectile_pipe                  = 1 // Grenade Launcher bomb
    tf_projectile_pipe_remote           = 1 // Stickybomb Launcher bomb
    tf_projectile_rocket                = 1 // Rocket Launcher rocket
    tf_projectile_sentryrocket          = 1 // Sentry gun rocket
    tf_projectile_stun_ball             = 1 // Baseball
}




function IsAlive(player)
{
	return GetPropInt(player, "m_lifeState") == 0
}

function IsDucking(player)
{
	return player.GetFlags() & FL_DUCKING
}
function IsOnGround(player)
{
	return player.GetFlags() & FL_ONGROUND
}
function RemoveAmmo(player)
{
	for ( local i = 0; i < 32; i++ )
    {
        SetPropIntArray(player, "m_iAmmo", 0, i)
    }
}

function DisableCloak(player)
{
	// High Number to Prevent Player from Cloaking
	SetPropFloat(player, "m_Shared.m_flStealthNextChangeTime", Time() * 99999)
}

::LockInPlace <- function(player, enable = true)
{
    if (enable)
    {
        player.AddFlag(FL_ATCONTROLS)
        player.AddCustomAttribute("no_jump", 1, -1)
        player.AddCustomAttribute("no_duck", 1, -1)
        player.AddCustomAttribute("no_attack", 1, -1)
        player.AddCustomAttribute("disable weapon switch", 1, -1)

    }
    else
    {
        player.RemoveFlag(FL_ATCONTROLS)
        player.RemoveCustomAttribute("no_jump")
        player.RemoveCustomAttribute("no_duck")
        player.RemoveCustomAttribute("no_attack")
        player.RemoveCustomAttribute("disable weapon switch")
    }
}


function PrecacheParticle(name)
{
    PrecacheEntityFromTable({ classname = "info_particle_system", effect_name = name })
}


function SpawnEffect(player,  effect)
{
    local player_angle     =  player.GetLocalAngles()
    local player_angle_vec =  Vector( player_angle.x, player_angle.y, player_angle.z)

    DispatchParticleEffect(effect, player.GetLocalOrigin(), player_angle_vec)
    return
}

RemovePlayerWearables <- function(player)
{
    for (local wearable = player.FirstMoveChild(); wearable != null; wearable = wearable.NextMovePeer())
    {
        if (wearable.GetClassname() == "tf_wearable")
		    wearable.Destroy()
    }
    return
}



function IsEntityClassnameInList(entity, list)
{
    local classname = entity.GetClassname()
    local listType = typeof(list)

    switch (listType)
    {
        case "table":
            return (classname in list)

        case "array":
            return (list.find(classname) != null)

        default:
            printl("Error: list is neither an array nor a table.")
            return false
    }
}

function SetPlayerClassRespawnAndTeleport(player, playerclass, location_set = null)
{
    local teleport_origin, teleport_angles, teleport_velocity

    if (!location_set)
        teleport_origin = player.GetOrigin()
    else
        teleport_origin = location_set
    teleport_angles = player.EyeAngles()
    teleport_velocity = player.GetAbsVelocity()
    SetPropInt(player, "m_Shared.m_iDesiredPlayerClass", playerclass)

    player.ForceRegenerateAndRespawn()

    player.Teleport(true, teleport_origin, true, teleport_angles, true, teleport_velocity)
}

function GetPlayerName(player)
{
	return GetPropString(player, "m_szNetname")
}

function GetPlayerUserID(player)
{
    return GetPropIntArray(PlayerManager, "m_iUserID", player.entindex()) //TODO replace PlayerManager with the actual entity name
}

function PlayerRespawn()
{
	self.ForceRegenerateAndRespawn();
}

function PlaySoundOnClient(player, name, volume = 1.0, pitch = 100)
{
	EmitSoundEx(
	{
		sound_name = name,
		volume = volume
		pitch = pitch,
		entity = player,
		filter_type = RECIPIENT_FILTER_SINGLE_PLAYER
	})
}

function PlaySoundOnAllClients(name)
{
	EmitSoundEx(
	{
		sound_name = name,
		filter_type = RECIPIENT_FILTER_GLOBAL
	})
}



// MATH

function Min(a, b)
{
    return (a <= b) ? a : b;
}

function Max(a, b)
{
    return (a >= b) ? a : b;
}

function Clamp(x, a, b)
{
    return Min(b, Max(a, x));
}

function RemapVal(v, A, B, C, D)
{
	if (A == B)
	{
		if (v >= B)
			return D;
		return C;
	}
	return C + (D - C) * (v - A) / (B - A);
}

function RemapValClamped(v, A, B, C, D)
{
	if (A == B)
	{
		if (v >= B)
			return D;
		return C;
	}
	local cv = (v - A) / (B - A);
	if (cv <= 0.0)
		return C;
	if (cv >= 1.0)
		return D;
	return C + (D - C) * cv;
}

function IntersectionPointBox(pos, mins, maxs)
{
	if (pos.x < mins.x || pos.x > maxs.x ||
		pos.y < mins.y || pos.y > maxs.y ||
		pos.z < mins.z || pos.z > maxs.z)
		return false;

	return true;
}

function NormalizeAngle(target)
{
	target %= 360.0;
	if (target > 180.0)
		target -= 360.0;
	else if (target < -180.0)
		target += 360.0;
	return target;
}

function ApproachAngle(target, value, speed)
{
	target = NormalizeAngle(target);
	value = NormalizeAngle(value);
	local delta = NormalizeAngle(target - value);
	if (delta > speed)
		return value + speed;
	else if (delta < -speed)
		return value - speed;
	return target;
}

function VectorAngles(forward)
{
	local yaw, pitch;
	if ( forward.y == 0.0 && forward.x == 0.0 )
	{
		yaw = 0.0;
		if (forward.z > 0.0)
			pitch = 270.0;
		else
			pitch = 90.0;
	}
	else
	{
		yaw = (atan2(forward.y, forward.x) * 180.0 / Constants.Math.Pi);
		if (yaw < 0.0)
			yaw += 360.0;
		pitch = (atan2(-forward.z, forward.Length2D()) * 180.0 / Constants.Math.Pi);
		if (pitch < 0.0)
			pitch += 360.0;
	}

	return QAngle(pitch, yaw, 0.0);
}

function AnglesToVector(angles)
{
    local pitch = angles.x * Constants.Math.Pi / 180.0
    local yaw = angles.y * Constants.Math.Pi / 180.0
    local x = cos(pitch) * cos(yaw)
    local y = cos(pitch) * sin(yaw)
    local z = sin(pitch)
    return Vector(x, y, z)
}

function QAngleDistance(a, b)
{
  local dx = a.x - b.x
  local dy = a.y - b.y
  local dz = a.z - b.z
  return sqrt(dx*dx + dy*dy + dz*dz)
}