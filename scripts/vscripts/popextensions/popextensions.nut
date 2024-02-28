// ::popExtensionsVersion <- 6; //don't bother with versioning for now since we're constantly updating it
local root = getroottable()

popExtEntity <- FindByName(null, "_popextensions")
if (popExtEntity == null) {
	popExtEntity <- SpawnEntityFromTable("info_teleport_destination", { targetname = "_popextensions" vscripts="popextensions/hooks.nut" })
}

popExtEntity.ValidateScriptScope()
PopExtScope <- popExtEntity.GetScriptScope()

PopExtScope.robotTags         <- {}
PopExtScope.tankNames         <- {}
PopExtScope.tankNamesWildcard <- {}

popExtThinkFuncSet <- false
AddThinkToEnt(popExtEntity, null)

PrecacheModel("models/weapons/w_models/w_rocket.mdl")

function PopExtScope::AddRobotTag(tag, table) {
	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopHooksScope.PopulatorThink")
		popExtThinkFuncSet = true
	}
	PopExtScope.robotTags[tag] <- table
}

function PopExtScope::AddTankName(name, table) {
	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopHooksScope.PopulatorThink")
		popExtThinkFuncSet = true
	}

	name = name.tolower()
	local wildcard = name[name.len() - 1] == '*'
	if (wildcard) {
		name = name.slice(0, name.len() - 1)
		PopExtScope.tankNamesWildcard[name] <- table
	}
	else
		PopExtScope.tankNames[name] <- table
}

function PopExtScope::_PopIncrementTankIcon(icon) {
	local flags = MVM_CLASS_FLAG_NORMAL
	if (icon.isCrit) {
		flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT
	}
	if (icon.isBoss) {
		flags = flags | MVM_CLASS_FLAG_MINIBOSS
	}
	if (icon.isSupport) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT
	}
	if (icon.isSupportLimited) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT_LIMITED
	}

	PopExtScope.DecrementWaveIconSpawnCount("tank", MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS | (icon.isSupport ? MVM_CLASS_FLAG_SUPPORT : 0) | (icon.isSupportLimited ? MVM_CLASS_FLAG_SUPPORT_LIMITED : 0), icon.count, false)
	PopExtScope.IncrementWaveIconSpawnCount(icon.name, flags, icon.count, false)
}

function PopExtScope::_PopIncrementIcon(icon) {
	local flags = MVM_CLASS_FLAG_NORMAL
	if (icon.isCrit) {
		flags = flags | MVM_CLASS_FLAG_ALWAYSCRIT
	}
	if (icon.isBoss) {
		flags = flags | MVM_CLASS_FLAG_MINIBOSS
	}
	if (icon.isSupport) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT
	}
	if (icon.isSupportLimited) {
		flags = flags | MVM_CLASS_FLAG_SUPPORT_LIMITED
	}

	PopExtScope.IncrementWaveIconSpawnCount(icon.name, flags, icon.count, true)
}

function PopExtScope::AddCustomTankIcon(name, count, isCrit = false, isBoss = true, isSupport = false, isSupportLimited = false) {
	local icon = {
		name      = name
		count     = count
		isCrit    = isCrit
		isBoss    = isBoss
		isSupport = isSupport
		isSupportLimited = isSupportLimited
	}
	PopExtScope.tankIcons.append(icon)
	PopExtScope._PopIncrementTankIcon(icon)
}

function PopExtScope::AddCustomIcon(name, count, isCrit = false, isBoss = false, isSupport = false, isSupportLimited = false) {
	local icon = {
		name      = name
		count     = count
		isCrit    = isCrit
		isBoss    = isBoss
		isSupport = isSupport
		isSupportLimited = isSupportLimited
	}
	PopExtScope.icons.append(icon)
	PopExtScope._PopIncrementIcon(icon)
}

function PopExtScope::SetWaveIconsFunction(func) {
	PopExtScope.waveIconsFunction <- func
	func()
}

local resource = FindByClassname(null, "tf_objective_resource")

// Get wavebar spawn count of an icon with specified name and flags
function PopExtScope::GetWaveIconSpawnCount(name, flags) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2"
		for (local i = 0; i < sizeArray * 2; i++) {
			if (GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i) == name &&
				(flags == 0 || GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {

				return GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i)
			}
		}
	}
	return 0
}

// Set wavebar spawn count of an icon with specified name and flags
// If count is set to 0, removes the icon from the wavebar
// Can be used to put custom icons on a wavebar
function PopExtScope::SetWaveIconSpawnCount(name, flags, count, changeMaxEnemyCount = true) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i)
			if (nameSlot == "" && count > 0) {
				SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, name, i)
				SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, count, i)
				SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, flags, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") + count)
				}
				return
			}

			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				local preCount = GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i)
				SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, count, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") + count - preCount)
				}
				if (count <= 0) {
					SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, "", i)
					SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, 0, i)
					SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, false, i)
				}
				return
			}
		}
	}
}
// Increment wavebar spawn count of an icon with specified name and flags
// Can be used to put custom icons on a wavebar
function PopExtScope::IncrementWaveIconSpawnCount(name, flags, count = 1, changeMaxEnemyCount = true) {
	PopExtScope.SetWaveIconSpawnCount(name, flags, PopExtScope.GetWaveIconSpawnCount(name, flags) + count, changeMaxEnemyCount)
	return 0
}

// Increment wavebar spawn count of an icon with specified name and flags
// Use it to decrement the spawn count when the enemy is killed. Should not be used for support type icons
function PopExtScope::DecrementWaveIconSpawnCount(name, flags, count = 1, changeMaxEnemyCount = false) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i)
			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				local preCount = GetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, i)
				SetPropIntArray(resource, "m_nMannVsMachineWaveClassCounts" + suffix, preCount - count > 0 ? preCount - count : 0, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {
					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") - (count > preCount ? preCount : count))
				}

				if (preCount - count <= 0) {
					SetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, "", i)
					SetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, 0, i)
					SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, false, i)
				}
				return
			}
		}
	}
	return 0
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
function PopExtScope::SetWaveIconActive(name, flags, active) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i)
			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				SetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, active, i)
				return
			}
		}
	}
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
function PopExtScope::GetWaveIconActive(name, flags) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")
	for (local a = 0; a < 2; a++) {
		local suffix = a == 0 ? "" : "2";
		for (local i = 0; i < sizeArray; i++) {
			local nameSlot = GetPropStringArray(resource, "m_iszMannVsMachineWaveClassNames" + suffix, i)
			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, "m_nMannVsMachineWaveClassFlags" + suffix, i) == flags)) {
				return GetPropBoolArray(resource, "m_bMannVsMachineWaveClassActive" + suffix, i)
			}
		}
	}
	return false
}
