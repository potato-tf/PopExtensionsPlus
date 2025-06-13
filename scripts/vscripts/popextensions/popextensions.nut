local root = getroottable()

PopExt.robotTags         <- {}
PopExt.tankNames         <- {}
PopExt.tankNamesWildcard <- {}

popExtThinkFuncSet <- false
AddThinkToEnt(popExtEntity, null)

PrecacheModel("models/weapons/w_models/w_rocket.mdl")

function PopExt::AddRobotTag(tag, table) {
	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopExtGlobalThink")
		popExtThinkFuncSet = true
	}
	PopExt.robotTags[tag] <- table
}

function PopExt::AddTankName(name, table) {

	if (!popExtThinkFuncSet) {
		AddThinkToEnt(popExtEntity, "PopExtGlobalThink")
		popExtThinkFuncSet = true
	}

	if ("Icon" in table) {
		if (typeof table.Icon == "table") {
			local icon 			   = "name" in table.Icon ? table.Icon.name : table.Icon.icon
			local count  		   = "count" in table.Icon ? table.Icon.count : 1
			local isCrit 		   = "isCrit" in table.Icon ? table.Icon.isCrit : false
			local isBoss 		   = "isBoss" in table.Icon ? table.Icon.isBoss : true
			local isSupport 	   = "isSupport" in table.Icon ? table.Icon.isSupport : false
			local isSupportLimited = "isSupportLimited" in table.Icon ? table.Icon.isSupportLimited : false

			PopExt.AddCustomTankIcon(icon, count, isCrit, isBoss, isSupport, isSupportLimited)
		}
		else
			PopExt.AddCustomTankIcon(table.Icon, 1)
	}

	name = name.tolower()
	local wildcard = name[name.len() - 1] == '*'
	if (wildcard) {
		name = name.slice(0, name.len() - 1)
		PopExt.tankNamesWildcard[name] <- table
	}
	else
		PopExt.tankNames[name] <- table
}

// wrapper with more intuitive name
PopExt.CustomTank <- PopExt.AddTankName

function PopExt::_PopIncrementTankIcon(icon) {
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

	PopExt.DecrementWaveIconSpawnCount("tank", MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS | (icon.isSupport ? MVM_CLASS_FLAG_SUPPORT : 0) | (icon.isSupportLimited ? MVM_CLASS_FLAG_SUPPORT_LIMITED : 0), icon.count, false)
	PopExt.IncrementWaveIconSpawnCount(icon.name, flags, icon.count, false)
}

function PopExt::_PopIncrementIcon(icon) {
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

	PopExt.IncrementWaveIconSpawnCount(icon.name, flags, icon.count, true)
}

function PopExt::AddCustomTankIcon(name, count, isCrit = false, isBoss = true, isSupport = false, isSupportLimited = false) {

	local icon = {
		name      = name
		count     = count
		isCrit    = isCrit
		isBoss    = isBoss
		isSupport = isSupport
		isSupportLimited = isSupportLimited
	}
	PopExtHooks.tankIcons.append(icon)
	PopExt._PopIncrementTankIcon(icon)
}

function PopExt::AddCustomIcon(name, count, isCrit = false, isBoss = false, isSupport = false, isSupportLimited = false) {

	local icon = {
		name      = name
		count     = count
		isCrit    = isCrit
		isBoss    = isBoss
		isSupport = isSupport
		isSupportLimited = isSupportLimited
	}
	PopExtHooks.icons.append(icon)
	PopExt._PopIncrementIcon(icon)
}

function PopExt::SetWaveIconsFunction(func) {
	PopExt.waveIconsFunction <- func
	func()
}

local resource = FindByClassname(null, "tf_objective_resource")

// Get wavebar spawn count of an icon with specified name and flags
function PopExt::GetWaveIconSpawnCount(name, flags) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray * 2; i++) {

			if (GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i) == name && (flags == 0 || GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i) == flags)) {

				return GetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), i)
			}
		}
	}
	return 0
}

// Set wavebar spawn count of an icon with specified name and flags
// If count is set to 0, removes the icon from the wavebar
// Can be used to put custom icons on a wavebar
// if flags or count are null they will retain their current values
function PopExt::SetWaveIconSpawnCount(name, flags, count, changeMaxEnemyCount = true) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)
			local countSlot = GetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), i)
			local flagsSlot = GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i)
			local enemyCount = GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount")

			if (count == null) count = countSlot
			if (flags == null) flags = flagsSlot

			if (nameSlot == "" && count > 0) {

				SetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), name, i)
				SetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), count, i)
				SetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), flags, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {

					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", enemyCount + count)
				}
				return
			}

			if (nameSlot == name && (flags == 0 || flagsSlot == flags)) {

				local preCount = countSlot
				SetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), count, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {

					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", enemyCount + count - preCount)
				}
				if (count <= 0) {

					SetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), "", i)
					SetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), 0, i)
					SetPropBoolArray(resource, format("m_bMannVsMachineWaveClassActive%s", suffix), false, i)
				}
				return
			}
		}
	}
}

// Replace/update a specific icon on the wavebar
// index override can be used to preserve slot order
// more concise version of the above function
// setting incrementer to true will add/subtract the current count instead of replacing it
function PopExt::SetWaveIconSlot(name, slot = null, flags = null, count = null, index_override = -1, incrementer = false) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")
	local netprop_classnames = "m_iszMannVsMachineWaveClassNames"
	local netprop_flags = "m_nMannVsMachineWaveClassFlags"
	local netprop_counts = "m_nMannVsMachineWaveClassCounts"
	local netprop_active = "m_bMannVsMachineWaveClassActive"
	local netprop_enemycount = "m_nMannVsMachineWaveEnemyCount"

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		local indices = {}

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), i)
			local flagsSlot = GetPropIntArray(resource, format("%s%s", netprop_flags, suffix), i)
			local countSlot = GetPropIntArray(resource, format("%s%s", netprop_counts, suffix), i)
			local enemyCount = GetPropInt(resource, netprop_enemycount)

			if (count == null) count = countSlot
			if (flags == null) flags = flagsSlot

			if (index_override != -1)
			{
				indices[i] <- [nameSlot, flagsSlot, countSlot, false]
				if (flagsSlot & MVM_CLASS_FLAG_MISSION)
					indices[i][3] = true
			}

			if (nameSlot == name) {

				local preCount = countSlot

				if (count == 0) {

					SetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), "", i)
					SetPropIntArray(resource, format("%s%s", netprop_flags, suffix), 0, i)
					SetPropBoolArray(resource, format("%s%s", netprop_active, suffix), false, i)

					SetPropInt(resource, netprop_enemycount, enemyCount - preCount)
					return
				}

				else if (incrementer) {
					count = countSlot + count
					SetPropIntArray(resource, format("%s%s", netprop_counts, suffix), count, i)

					if (countSlot <= 0) {
						SetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), "", i)
						SetPropIntArray(resource, format("%s%s", netprop_flags, suffix), 0, i)
						SetPropBoolArray(resource, format("%s%s", netprop_active, suffix), false, i)
					}
					return
				}

				if (index_override != -1)
				{
					SetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), indices[i][0], i)
					SetPropIntArray(resource, format("%s%s", netprop_flags, suffix), indices[i][1], i)
					SetPropIntArray(resource, format("%s%s", netprop_counts, suffix), indices[i][2], i)
					SetPropBoolArray(resource, format("%s%s", netprop_active, suffix), indices[i][3], i)

					SetPropIntArray(resource, format("%s%s", netprop_counts, suffix), 0, i)
					SetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), "", i)
					SetPropIntArray(resource, format("%s%s", netprop_flags, suffix), 0, i)
				}

				SetPropIntArray(resource, format("%s%s", netprop_counts, suffix), count, index_override)
				SetPropStringArray(resource, format("%s%s", netprop_classnames, suffix), slot, index_override)
				SetPropIntArray(resource, format("%s%s", netprop_flags, suffix), flags, index_override)

				if (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))
					SetPropInt(resource, netprop_enemycount, GetPropInt(resource, netprop_enemycount) + count - preCount)
				return
			}
			if (nameSlot == name)
				break
		}
	}
}
function PopExt::GetWaveIconSlot(name, flags) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)
			local flagsSlot = GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i)

			if (nameSlot == name && (flags == 0 || flagsSlot == flags)) {
				return i
			}
		}
	}
	return -1
}
// Increment wavebar spawn count of an icon with specified name and flags
// Can be used to put custom icons on a wavebar
function PopExt::IncrementWaveIconSpawnCount(name, flags, count = 1, changeMaxEnemyCount = true) {
	PopExt.SetWaveIconSpawnCount(name, flags, PopExt.GetWaveIconSpawnCount(name, flags) + count, changeMaxEnemyCount)
	return 0
}

function PopExt::GetWaveIconFlags(name) {
	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")
	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)

			if (nameSlot == name)
				return GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i)
		}
	}
	return 0
}

// Increment wavebar spawn count of an icon with specified name and flags
// Use it to decrement the spawn count when the enemy is killed. Should not be used for support type icons
function PopExt::DecrementWaveIconSpawnCount(name, flags, count = 1, changeMaxEnemyCount = false) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)

			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i) == flags)) {

				local preCount = GetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), i)

				SetPropIntArray(resource, format("m_nMannVsMachineWaveClassCounts%s", suffix), preCount - count > 0 ? preCount - count : 0, i)

				if (changeMaxEnemyCount && (flags & (MVM_CLASS_FLAG_NORMAL | MVM_CLASS_FLAG_MINIBOSS))) {

					SetPropInt(resource, "m_nMannVsMachineWaveEnemyCount", GetPropInt(resource, "m_nMannVsMachineWaveEnemyCount") - (count > preCount ? preCount : count))
				}

				if (preCount - count <= 0) {

					SetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), "", i)
					SetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), 0, i)
					SetPropBoolArray(resource, format("m_bMannVsMachineWaveClassActive%s", suffix), false, i)
				}
				return
			}
		}
	}
	return 0
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
function PopExt::SetWaveIconActive(name, flags, active) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)

			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i) == flags)) {

				SetPropBoolArray(resource, format("m_bMannVsMachineWaveClassActive%s", suffix), active, i)
				return
			}
		}
	}
}

// Used for mission and support limited bots to display them on a wavebar during the wave, set by the game automatically when an enemy with this icon spawn
function PopExt::GetWaveIconActive(name, flags) {

	local sizeArray = GetPropArraySize(resource, "m_nMannVsMachineWaveClassCounts")

	for (local a = 0; a < 2; a++) {

		local suffix = a == 0 ? "" : "2"

		for (local i = 0; i < sizeArray; i++) {

			local nameSlot = GetPropStringArray(resource, format("m_iszMannVsMachineWaveClassNames%s", suffix), i)

			if (nameSlot == name && (flags == 0 || GetPropIntArray(resource, format("m_nMannVsMachineWaveClassFlags%s", suffix), i) == flags)) {

				return GetPropBoolArray(resource, format("m_bMannVsMachineWaveClassActive%s", suffix), i)
			}
		}
	}
	return false
}
