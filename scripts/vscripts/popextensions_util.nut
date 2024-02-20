// All Global Utility Functions go here, also use IncludeScript and place it inside Root

// Allow expression constants
::CONST <- getconsttable()
::ROOT <- getroottable()

CONST.setdelegate({ _newslot = @(k, v) compilestring("const " + k + "=" + (typeof(v) == "string" ? ("\"" + v + "\"") : v))() })
CONST.MAX_CLIENTS <- MaxClients().tointeger()

if (!("ConstantNamingConvention" in CONST))
{
	foreach (a,b in Constants)
		foreach (k,v in b)
            CONST[k] <- v != null ? v : 0;
}

foreach (k, v in ::NetProps.getclass())
    if (k != "IsValid" && !(k in ROOT))
        ROOT[k] <- ::NetProps[k].bindenv(::NetProps)

foreach (k, v in ::Entities.getclass())
    if (k != "IsValid" && !(k in ROOT))
        ROOT[k] <- ::Entities[k].bindenv(::Entities)
		
IncludeScript("popextensions_robotvoicelines");

::AllNavAreas <- {};
NavMesh.GetAllAreas(AllNavAreas);

//check a global variable instead of accessing a netprop every time to check if we are between waves.
::IsWaveStarted <- false;
::PopExt_UtilEvents <- {
    function OnGameEvent_mvm_wave_complete(params) { IsWaveStarted = false; }
    function OnGameEvent_mvm_wave_failed(params) { IsWaveStarted = false; }
    function OnGameEvent_mvm_begin_wave(params) { IsWaveStarted = true; }

    function OnGameEvent_post_inventory_application(params)
    {
        local player = GetPlayerFromUserID(params.userid)

        if (player.IsBotOfType(1337)) return;

        if (PlayerArray.find(player) == null) PlayerArray.append(player);
    }

    function OnGameEvent_player_disconnect(params)
    {
        local player = GetPlayerFromUserID(params.userid)

        for (local i = PlayerArray.len() - 1; i >= 0; i--)
            if (PlayerArray[i] == null || PlayerArray[i] == player)
                PlayerArray.remove(i);
    }
};
__CollectGameEventCallbacks(PopExt_UtilEvents);

//HACK: forces post_inventory_application to fire on pop load
for (local i = 1; i <= MaxClients(); i++)
    if (PlayerInstanceFromIndex(i) != null)
        EntFireByHandle(PlayerInstanceFromIndex(i), "RunScriptCode", "self.Regenerate(true)", -1, null, null);

::CurrentWaveNum <- GetPropInt(FindByClassname(null, "tf_objective_resource"), "m_nMannVsMachineWaveCount");

//useful ents
::GameRules <- FindByClassname(null, "tf_gamerules");
::ObjectiveResource <- FindByClassname(null, "tf_objective_resource");
::MonsterResource <- FindByClassname(null, "monster_resource");
::MvMLogicEnt <- FindByClassname(null, "tf_logic_mann_vs_machine");
::PlayerManager <- FindByClassname(null, "tf_player_manager");
::Worldspawn <- FindByClassname(null, "worldspawn");
::StartRelay <- FindByName(null, "wave_start_relay");
::FinishedRelay <- FindByName(null, "wave_finished_relay");

//spawn a point_clientcommand
::ClientCommand <- SpawnEntityFromTable("point_clientcommand", {})

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

::PlayerArray <- []

function IsLinuxServer() 
{
	return RAND_MAX != 32767
}

function ShowMessage(message)
{
	ClientPrint(null, HUD_PRINTCENTER , message)
}

function ShowChatMessage(target, fmt, ...)
{
    local result = "\x07FFCC22[Map] ";
    local start = 0;
    local end = fmt.find("{");
    local i = 0;
    while (end != null)
    {
        result += fmt.slice(start, end);
        start = end + 1;
        end = fmt.find("}", start);
        if (end == null)
            break;
        local word = fmt.slice(start, end);

        if (word == "player")
        {
            local player = vargv[i++];

            local team = player.GetTeam();
            if (team == TF_TEAM_RED)
                result += "\x07" + TF_COLOR_RED;
            else if (team == TF_TEAM_BLUE)
                result += "\x07" + TF_COLOR_BLUE;
            else
                result += "\x07" + TF_COLOR_SPEC;
            result += GetPlayerName(player);
        }
        else if (word == "color")
        {
            result += "\x07" + vargv[i++];
        }
        else if (word == "int" || word == "float")
        {
            result += vargv[i++].tostring();
        }
        else if (word == "str")
        {
            result += vargv[i++];
        }
        else
        {
            result += "{" + word + "}";
        }

        start = end + 1;
        end = fmt.find("{", start);
    }

    result += fmt.slice(start);

    ClientPrint(target, HUD_PRINTTALK, result)
}

// example
// ChatPrint(null, "{player} {color}guessed the answer first!", player, TF_COLOR_DEFAULT);


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
function GetAllEnts()
{
    local entdata = { "entlist": [], "numents": 0 };
	for (local i = MAX_CLIENTS, ent; i <= MAX_EDICTS; i++)
	{
        if (ent = EntIndexToHScript(i))
        {
            entdata.numents++;
            entdata.entlist.append(ent)
        }
    }
    return entdata
}

//sets m_hOwnerEntity and m_hOwner to the same value
function _SetOwner(ent, owner)
{
	//incase we run into an ent that for some reason uses both of these netprops for two different entities
    if (ent.GetOwner() != null && GetPropEntity(ent, "m_hOwnerEntity") != null && ent.GetOwner() != GetPropEntity(ent, "m_hOwnerEntity"))
    {
        ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
        ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
        ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
        ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
        ClientPrint(null, 3, "m_hOwnerEntity is "+GetPropEntity(ent, "m_hOwnerEntity")+" but m_hOwner is "+ent.GetOwner())
    }
    ent.SetOwner(owner);
    SetPropEntity(ent, "m_hOwnerEntity", owner);
}

function ShowAnnotation(text = "This is an annotation", lifetime = 10, pos = Vector(), id = 0, distance = true, sound = "misc/null.wav", entindex = 0, visbit = 0, effect = true)
{
    SendGlobalGameEvent("show_annotation", {
        text = text
        lifetime = lifetime
        worldPosX = pos.x
        worldPosY = pos.y
        worldPosZ = pos.z
        id = id
        play_sound = sound
        show_distance = distance
        show_effect = effect
        follow_entindex = entindex
        visibilityBitfield = visbit
    })
}

//This may not be necessary and hide_annotation may work, but whatever this works too.
function HideAnnotation(id) { ShowAnnotation("", 0.0000001, Vector(), id = id) }

function GetPlayerName(player)
{
	return GetPropString(player, "m_szNetname")
}

function SetPlayerName(player,  name)
{
	return SetPropString(player, "m_szNetname", name)
}

function GetPlayerUserID(player)
{
    return GetPropIntArray(PlayerManager, "m_iUserID", player.entindex()) //TODO replace PlayerManager with the actual entity name
}

function PlayerRespawn()
{
	self.ForceRegenerateAndRespawn();
}

function DisableCloak(player)
{
	// High Number to Prevent Player from Cloaking
	SetPropFloat(player, "m_Shared.m_flStealthNextChangeTime", Time() * 99999)
}

function InUpgradeZone(player) 
{ 
	return GetPropBool(player, "m_Shared.m_bInUpgradeZone"); 
}

function InButton(player, button) 
{ 
	return (GetPropInt(player, "m_nButtons") & button) 
}

function PressButton(player, button) 
{ 
	SetPropInt(player, "m_afButtonForced") | button; SetPropInt(player, "m_nButtons") | button 
}

//assumes user is using the SLOT_ constants
function SwitchWeaponSlot(player, slot) 
{ 
	EntFireByHandle(ClientCommand, "Command", format("slot%d", slot + 1), -1, player, player); 
}

function GetItemInSlot(player, slot)
{
    local item;
    for (local i = 0; i < SLOT_COUNT; i++)
    {
        local wep = GetPropEntityArray(player, "m_hMyWeapons", i);
        if ( wep == null || wep.GetSlot() != slot) continue;
        
        item = wep;
        break;
    }
    return item;
}

function HasEffect(ent, value)
{ 
	return GetPropInt(ent, "m_fEffects") == value
}

function SetEffect(ent, value) 
{ 
	SetPropInt(ent, "m_fEffects", value); 
}

function PlayerRobotModel(player, model)
{
    player.ValidateScriptScope();
    local scope = player.GetScriptScope();
    scope.parentedmodel <- false;
    
    local wearable = CreateByClassname("tf_wearable");
    SetPropString(wearable, "m_iName", "__bot_bonemerge_model");
    SetPropInt(wearable, "m_nModelIndex", PrecacheModel(model));
    SetPropBool(wearable, "m_bValidatedAttachedEntity", true);
    SetPropBool(wearable, "m_AttributeManager.m_Item.m_bInitialized", true);
    SetPropEntity(wearable, "m_hOwnerEntity", player);
    wearable.SetTeam(player.GetTeam());
    wearable.SetOwner(player);
    wearable.DispatchSpawn();
    EntFireByHandle(wearable, "SetParent", "!activator", -1, player, player);
    SetPropInt(wearable, "m_fEffects", 129);
    scope.wearable <- wearable;
    
    SetPropInt(player, "m_nRenderMode", 1);
    SetPropInt(player, "m_clrRender", 0);   
    
    function BotModelThink()
    {
        if (!wearable) return;
        
        if (self.IsTaunting())
        {
            if (!parentedmodel)
            {
                EntFireByHandle(wearable, "SetParent", "", -1, null, null);
                EntFireByHandle(wearable, "SetParent", "!activator", 0.015, self, self);
                parentedmodel = true;
            }
            return -1
        }
        parentedmodel = false;
        return -1
    }
    if (!("PlayerThinkTable" in scope)) scope.PlayerThinkTable <- {}

    if (!(BotModelThink in scope.PlayerThinkTable))
        scope.PlayerThinkTable.BotModelThink <- BotModelThink

    function PlayerThinks() { foreach (_, func in scope.PlayerThinkTable) func() }

    if (!("PlayerThinks" in scope))
    {
        scope.PlayerThinks <- PlayerThinks
        AddThinkToEnt(player, "PlayerThinks")
    }         
}

function HasItemIndex(player, index)
{
    local t = false;
    for (local child = player.FirstMoveChild(); child != null; child = child.NextMovePeer())
    {
        if (GetItemIndex(child) == index)
        {
            t = true;
            break;
        }
    }
    return t;
}

function StunPlayer(player, duration = 5, type = 1, delay = 0, speedreduce = 0.5)
{
	SpawnEntityFromTable("trigger_stun", {
		targetname = "__utilstun",
		stun_type = type,
		stun_duration = duration,
		move_speed_reduction = speedreduce,
		trigger_delay = delay,
		StartDisabled = 0,
		spawnflags = 1,
		"OnStunPlayer#1": "!self,Kill,,-1,-1"
	});
	__utilstun.SetSolid(2)
	__utilstun.SetSize(Vector(-1, -1, -1), Vector())

	EntFireByHandle(__utilstun, "EndTouch", "", -1, player, player);
}

function ShowHudHint(player, text = "This is a hud hint", duration = 5)
{
    local hudhint = FindByName(null, "__hudhint") != null

    local flags = (player == null) ? 1 : 0;

    if (!hudhint) ::__hudhint <- SpawnEntityFromTable("env_hudhint", { targetname = "__hudhint", spawnflags = flags, message = text })

    __hudhint.KeyValueFromString("message", text);

    EntFireByHandle(__hudhint, "ShowHudHint", "", -1, player, player);
    EntFireByHandle(__hudhint, "HideHudHint", "", duration, player, player);
}

function SetEntityColor(entity, r, g, b, a)
{
    local color = (r) | (g << 8) | (b << 16) | (a << 24);
    SetPropInt(entity, "m_clrRender", color);
}

function GetEntityColor(entity)
{
    local color = GetPropInt(entity, "m_clrRender");
    local clr = {}
    clr.r <- color & 0xFF;
    clr.g <- (color >> 8) & 0xFF;
    clr.b <- (color >> 16) & 0xFF;
    clr.a <- (color >> 24) & 0xFF;
    return clr;
}

function ShowModelToPlayer(player, model = ["models/player/heavy.mdl", 0], pos = Vector(), ang = QAngle(), duration = 9999.0)
{
    PrecacheModel(model[0])
    local proxy_entity = CreateByClassname("obj_teleporter"); // use obj_teleporter to set bodygroups.  not using SpawnEntityFromTable as that creates spawning noises
    proxy_entity.SetAbsOrigin(pos);
    proxy_entity.SetAbsAngles(ang);
    DispatchSpawn(proxy_entity);

    proxy_entity.SetModel(model[0]);
    proxy_entity.SetSkin(model[1]);
    proxy_entity.AddEFlags(EFL_NO_THINK_FUNCTION); // EFL_NO_THINK_FUNCTION prevents the entity from disappearing
    proxy_entity.SetSolid(SOLID_NONE);

    SetPropBool(proxy_entity, "m_bPlacing", true);
    SetPropInt(proxy_entity, "m_fObjectFlags", 2); // sets "attachment" flag, prevents entity being snapped to player feet

    // m_hBuilder is the player who the entity will be networked to only
    SetPropEntity(proxy_entity, "m_hBuilder", player);
    EntFireByHandle(proxy_entity, "Kill", "", duration, player, player);
    return proxy_entity;
}


function LockInPlace(player, enable = true)
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

function GetItemIndex(item) 
{ 
	return GetPropInt(item, STRING_NETPROP_ITEMDEF) 
}

function SetItemIndex(item, index) 
{ 
	SetPropInt(item, STRING_NETPROP_ITEMDEF, index)
}

function SetTargetname(ent, name)
{ 
	SetPropString(ent, "m_iName", name) 
}

function GetPlayerSteamID(player) 
{ 
	return GetPropString(player, "m_szNetworkIDString") 
}

function GetHammerID(ent) 
{ 
	return GetPropInt(ent, "m_iHammerID") 
}

function GetSpawnFlags(ent) 
{ 
	return GetPropInt(self, "m_spawnflags") 
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

function RemoveOutputAll(ent, output)
{
    local outputs = [];
    for (local i = GetNumElements(ent, output); i >= 0; i--)
    {
        local t = {};
        GetOutputTable(ent, output, t, i);
        outputs.append(t);
    }
    foreach (o in outputs) foreach(_ in o) RemoveOutput(ent, output, o.target, o.input, o.parameter);
}

function RemovePlayerWearables(player)
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
		yaw = (atan2(forward.y, forward.x) * 180.0 / Pi);
		if (yaw < 0.0)
			yaw += 360.0;
		pitch = (atan2(-forward.z, forward.Length2D()) * 180.0 / Pi);
		if (pitch < 0.0)
			pitch += 360.0;
	}

	return QAngle(pitch, yaw, 0.0);
}

function AnglesToVector(angles)
{
    local pitch = angles.x * Pi / 180.0
    local yaw = angles.y * Pi / 180.0
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

function CheckBitwise(num) 
{
    return (num != 0 && ((num & (num - 1)) == 0))
}