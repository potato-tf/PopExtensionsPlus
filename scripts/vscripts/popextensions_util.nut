// All Global Utility Functions go here, also use IncludeScript and place it inside Root

::ROOT <- getroottable()
if (!("ConstantNamingConvention" in ROOT))
{
	foreach (a,b in Constants)
		foreach (k,v in b)
			ROOT[k] <- v != null ? v : 0;

    foreach (k, v in ::NetProps.getclass())
    if (k != "IsValid")
        getroottable()[k] <- ::NetProps[k].bindenv(::NetProps)
}



::Classes <- ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere


function IsAlive(player)
{
	return GetPropInt(player, "m_lifeState") == 0
}

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

    player.Teleport(true, teleport_origin, true, teleport_angles, true, teleport_velocity);
}

function GetPlayerName(player)
{
	return GetPropString(player, "m_szNetname");
}
function GetPlayerUserID(player)
{
    return GetPropIntArray(PlayerManager, "m_iUserID", player.entindex());
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
	});
}

function PlaySoundOnAllClients(name)
{
	EmitSoundEx(
	{
		sound_name = name,
		filter_type = RECIPIENT_FILTER_GLOBAL
	});
}