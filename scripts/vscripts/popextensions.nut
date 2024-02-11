::popExtensionsVersion <- 6;
popExtEntity <- Entities.FindByName(null, "pop_extension_ent");

if (popExtEntity == null) {
	popExtEntity <- SpawnEntityFromTable("move_rope", {targetname = "pop_extension_ent", vscripts="popextensions_hooks"});
}

popExtEntity.ValidateScriptScope();
popExtScope <- popExtEntity.GetScriptScope();

popExtScope.robotTags <- {};
popExtScope.tankNames <- {};
popExtScope.tankNamesWildcard <- {};
popExtThinkFuncSet <- false;
AddThinkToEnt(popExtEntity, null);

::SetParentLocalOriginDo <- function(child, parent, attachment = null)
{
	NetProps.SetPropEntity(child, "m_hMovePeer", parent.FirstMoveChild());
	NetProps.SetPropEntity(parent, "m_hMoveChild", child);
	NetProps.SetPropEntity(child, "m_hMoveParent", parent);
	local origPos = child.GetLocalOrigin();
	child.SetLocalOrigin(origPos + Vector(0, 0, 1));
	child.SetLocalOrigin(origPos);
	local origAngles = child.GetLocalAngles();
	child.SetLocalAngles(origAngles + QAngle(0, 0, 1));
	child.SetLocalAngles(origAngles);
	local origVel = child.GetVelocity();
	child.SetVelocity(origVel + Vector(0, 0, 1));
	child.SetVelocity(origVel);

	EntFireByHandle(child, "SetParent", "!activator", 0, parent, parent);
	if (attachment != null) {
		NetProps.SetPropEntity(child, "m_iParentAttachment", parent.LookupAttachment(attachment));
		EntFireByHandle(child, "SetParentAttachmentMaintainOffset", attachment, 0, parent, parent);
	}
}
// Sets parent immediately in a dirty way. Does not retain absolute origin, retains local origin instead.
// child parameter may also be an array of entities
::SetParentLocalOrigin <- function(child, parent, attachment = null)
{
	if (typeof child == "array") {
		foreach(i, childIn in child) {
			SetParentLocalOriginDo(childIn, parent, attachment)
		}
	}
	else {
		SetParentLocalOriginDo(child, parent, attachment)
	}
}

// Make a wearable that is attached to the player. The wearable is automatically removed when the owner is killed or respawned
::CreatePlayerWearable <- function(player, model, bonemerge = true, attachment = null, autoDestroy = true)
{
	local modelIndex = GetModelIndex(model);
	if (modelIndex == -1) {
		modelIndex = PrecacheModel(model);
	}
	local wearable = Entities.CreateByClassname("tf_wearable");
	NetProps.SetPropInt(wearable, "m_nModelIndex", modelIndex);
	wearable.SetSkin(player.GetTeam());
	wearable.SetTeam(player.GetTeam());
	wearable.SetSolidFlags(4);
	wearable.SetCollisionGroup(11);
	NetProps.SetPropBool(wearable, "m_bValidatedAttachedEntity", true);
	NetProps.SetPropBool(wearable, "m_AttributeManager.m_Item.m_bInitialized", true);
	NetProps.SetPropInt(wearable, "m_AttributeManager.m_Item.m_iEntityQuality", 0);
	NetProps.SetPropInt(wearable, "m_AttributeManager.m_Item.m_iEntityLevel", 1);
	NetProps.SetPropInt(wearable, "m_AttributeManager.m_Item.m_iItemIDLow", 2048);
	NetProps.SetPropInt(wearable, "m_AttributeManager.m_Item.m_iItemIDHigh", 0);

	wearable.SetOwner(player);
	Entities.DispatchSpawn(wearable);
	NetProps.SetPropInt(wearable, "m_fEffects", bonemerge ? 129 : 0);
	SetParentLocalOrigin(wearable, player, attachment);
	player.ValidateScriptScope();
	local scope = player.GetScriptScope();
	if (autoDestroy) {
		if (!("popWearablesToDestroy" in scope)) {
			scope.popWearablesToDestroy <- [];
		}
		scope.popWearablesToDestroy.append(wearable);
	}
	return wearable;
}

PrecacheModel("models/weapons/w_models/w_rocket.mdl");
// Setup collision bounds of a trigger entity
::SetupTriggerBounds <- function(trigger, mins = null, maxs = null)
{
	trigger.SetModel("models/weapons/w_models/w_rocket.mdl");
	if (mins != null) {
		NetProps.SetPropVector(trigger, "m_Collision.m_vecMinsPreScaled", mins);
		NetProps.SetPropVector(trigger, "m_Collision.m_vecMins", mins);
	}
	if (maxs != null) {
		NetProps.SetPropVector(trigger, "m_Collision.m_vecMaxsPreScaled", maxs);
		NetProps.SetPropVector(trigger, "m_Collision.m_vecMaxs", maxs);
	}
	trigger.SetSolid(Constants.ESolidType.SOLID_BBOX);
}

::PrintTable <- function (table)
{
	if (table == null) return;
	DoPrintTable(table, 0);
}
::DoPrintTable <- function (table, indent)
{
	local line = "";
	for(local i = 0; i < indent; i++) {
		line += " ";
	}
	line += typeof table == "array" ? "[" : "{";
	ClientPrint(null, 2, line);
	indent+=2;
	foreach (k,v in table) {
		line = "";
		for(local i = 0; i < indent; i++) {
			line += " ";
		}
		line += k.tostring();
		line += " = "
		if (typeof v == "table" || typeof v == "array") {
			ClientPrint(null, 2, line);
			DoPrintTable(v, indent);
		}
		else {
			try {
				line += v.tostring();
			}
			catch (e){
				line += typeof v;
			}
			ClientPrint(null, 2, line);
		}
	}
	indent-=2;
	line = "";
	for(local i = 0; i < indent; i++) {
		line += " ";
	}
	line += typeof table == "array" ? "]" : "}";
	ClientPrint(null, 2, line);
}

local objective = Entities.FindByClassname(null,"tf_objective_resource");

function AddRobotTag(tag, table)
{
	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopulatorThink");
		popExtThinkFuncSet = true;
	}
	popExtScope.robotTags[tag] <- table;
}

function AddTankName(name, table)
{
	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopulatorThink");
		popExtThinkFuncSet = true;
	}
	name = name.tolower();
	local wildcard = name[name.len()-1] == '*';
	if (wildcard) {
		name = name.slice(0, name.len()-1);
		popExtScope.tankNamesWildcard[name] <- table;
	}
	else {
		popExtScope.tankNames[name] <- table;
	}
}

::_PopIncrementTankIcon <- function(icon) {
	local flags = MVM_CLASS_FLAG_NORMAL;
	if (icon.isCrit) {
		flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT;
	}
	if (icon.isBoss) {
		flags = flags | MVM_CLASS_FLAG_MINIBOSS;
	}
	if (icon.isSupport) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT;
	}
	if (icon.isSupportLimited) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT_LIMITED;
	}
	DecrementWaveIconSpawnCount("tank", MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS | (icon.isSupport ? MVM_CLASS_FLAG_SUPPORT : 0) | (icon.isSupportLimited ? MVM_CLASS_FLAG_SUPPORT_LIMITED : 0), icon.count, false);
	IncrementWaveIconSpawnCount(icon.name, flags, icon.count, false);
}

::_PopIncrementIcon <- function(icon) {
	local flags = MVM_CLASS_FLAG_NORMAL;
	if (icon.isCrit) {
		flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT;
	}
	if (icon.isBoss) {
		flags = flags | MVM_CLASS_FLAG_MINIBOSS;
	}
	if (icon.isSupport) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT;
	}
	if (icon.isSupportLimited) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT_LIMITED;
	}
	IncrementWaveIconSpawnCount(icon.name, flags, icon.count, true);
}

function AddCustomTankIcon(name, count, isCrit = false, isBoss = true, isSupport = false, isSupportLimited = false)
{
	local icon = {name = name, count = count, isCrit = isCrit, isBoss = isBoss, isSupport = isSupport, isSupportLimited = isSupportLimited};
	popExtScope.tankIcons.append(icon);
	_PopIncrementTankIcon(icon);
}

function AddCustomIcon(name, count, isCrit = false, isBoss = false, isSupport = false, isSupportLimited = false)
{
	local icon = {name = name, count = count, isCrit = isCrit, isBoss = isBoss, isSupport = isSupport, isSupportLimited = isSupportLimited};
	popExtScope.icons.append(icon);
	_PopIncrementIcon(icon);
}

function SetWaveIconsFunction(func)
{
	popExtScope.waveIconsFunction <- func;
	func();
}

// Flags for wavebar functions below
::MVM_CLASS_FLAG_NONE <-			0;
::MVM_CLASS_FLAG_NORMAL <-			1 << 0; // Non support or mission icon
::MVM_CLASS_FLAG_SUPPORT <-			1 << 1; // Support icon flag. Mission icon does not have this flag
::MVM_CLASS_FLAG_MISSION <-			1 << 2; // Mission icon flag. Support icon does not have this flag
::MVM_CLASS_FLAG_MINIBOSS <-		1 << 3; // Giant icon flag. Support and mission icons do not display red background when set
::MVM_CLASS_FLAG_ALWAYSCRIT <-		1 << 4; // Crit icon flag. Support and mission icons do not display crit outline when set
::MVM_CLASS_FLAG_SUPPORT_LIMITED <-	1 << 5; // Support limited flag. Game uses it together with support flag


local resource = Entities.FindByClassname(null, "tf_objective_resource");

// Get wavebar spawn count of an icon with specified name and flags
::GetWaveIconSpawnCount <- function(name, flags)
{
	local sizeArray = NetProps.GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts");
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray * 2; i++) {
			if (NetProps.GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i) == name &&
				(flags == 0 || NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {

				return NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i);
			}
		}
	}
	return 0;
}

// Set wavebar spawn count of an icon with specified name and flags
// If count is set to 0, removes the icon from the wavebar
// Can be used to put custom icons on a wavebar
::SetWaveIconSpawnCount <- function(name, flags, count, changeMaxEnemyCount = true)
{
	local sizeArray = NetProps.GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts");

	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = NetProps.GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i);
			if (nameSlot == "" && count > 0) {
				NetProps.SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, name, i);
				NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, count, i);
				NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, flags, i);
				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					NetProps.SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", NetProps.GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") + count);
				}
				return;
			}
			if (nameSlot == name && (flags == 0 || NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				local preCount = NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i)
				NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, count, i);
				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					NetProps.SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", NetProps.GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") + count - preCount);
				}
				if (count <= 0) {
					NetProps.SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, "", i);
					NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, 0, i);
					NetProps.SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, false, i);
				}
				return;
			}
		}
	}
}
// Increment wavebar spawn count of an icon with specified name and flags
// Can be used to put custom icons on a wavebar
::IncrementWaveIconSpawnCount <- function(name, flags, count = 1, changeMaxEnemyCount = true)
{
	SetWaveIconSpawnCount(name, flags, GetWaveIconSpawnCount(name, flags) + count, changeMaxEnemyCount);
	return 0;
}

// Increment wavebar spawn count of an icon with specified name and flags
// Use it to decrement the spawn count when the enemy is killed. Should not be used for support type icons
::DecrementWaveIconSpawnCount <- function(name, flags, count = 1, changeMaxEnemyCount = false)
{
	local sizeArray = NetProps.GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts");

	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = NetProps.GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i);
			if (nameSlot == name && (flags == 0 || NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				local preCount = NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i)
				NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, preCount - count > 0 ? preCount - count : 0, i);
				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					NetProps.SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", NetProps.GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") - (count > preCount ? preCount : count));
				}
				if (preCount - count <= 0) {
					NetProps.SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, "", i);
					NetProps.SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, 0, i);
					NetProps.SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, false, i);
				}
				return;
			}
		}
	}
	return 0;
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
::SetWaveIconActive <- function(name, flags, active)
{
	local sizeArray = NetProps.GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts");
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = NetProps.GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i);
			if (nameSlot == name && (flags == 0 || NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				NetProps.SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, active, i);
				return;
			}
		}
	}
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
::GetWaveIconActive <- function(name, flags)
{
	local sizeArray = NetProps.GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts");
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = NetProps.GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i);
			if (nameSlot == name && (flags == 0 || NetProps.GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				return NetProps.GetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, i);
			}
		}
	}
	return false;
}