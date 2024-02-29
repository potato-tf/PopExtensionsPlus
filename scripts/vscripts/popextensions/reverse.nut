local classes = ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer"] //make element 0 a dummy string instead of doing array + 1 everywhere

::ChangePlayerTeamMvM <- function(player, teamnum = 3) {
	SetPropBool(FindByClassname(null, "tf_gamerules"), "m_bPlayingMannVsMachine", false)
	player.ForceChangeTeam(teamnum, false)
	SetPropBool(FindByClassname(null, "tf_gamerules"), "m_bPlayingMannVsMachine", true)
}

//set the sequences and max ammo values for the player's current loadout to deal with reloading
::SetPlayerWeaponInfo <-  function(player, sequence = [0], metal = 200) {
	foreach(i, a in ammo)
		if (a == 0)
			ammo[i] = 1

	local scope = player.GetScriptScope().PopExtPlayerScope

	// if (IsSigmod()) sequence.clear() //use rafmod ammo draining instead

	scope.sequencearray <- sequence
	scope.maxammo       <- ammo

	if (player.GetPlayerClass() != TF_CLASS_ENGINEER) return

	scope.maxmetal <- metal
	scope.curmetal <- GetPropIntArray(player, "m_iAmmo", 3)
}

::SetReserveAmmo <- function(wep, amount = 999, slot = -1, nounderflow = true) {
	//allow for just passing a single player variable to set primary + secondary reserve ammo to 999
	if (wep != null && wep.IsPlayer() && slot == -1) {
		if (nounderflow && amount < 0) amount = 0
		SetPropIntArray(wep, "m_iAmmo", amount, SLOT_PRIMARY)
		SetPropIntArray(wep, "m_iAmmo", amount, SLOT_SECONDARY)
		return
	}

	local player;
	if (wep == null) return
	if (wep.IsPlayer()) {
		player = wep
		wep = wep.GetActiveWeapon()
	} else
		player = wep.GetOwner()

	if (wep == null) return

	if (slot == -1) slot = wep.GetSlot()

	if (nounderflow && amount < 0) amount = 0

	SetPropIntArray(player, "m_iAmmo", amount, slot + 1)
}

::GivePackReverse <-  function(player, pack) {
	if (GetPropInt(pack, "m_fEffects") == EF_NODRAW || player.GetTeam() != TF_TEAM_PVE_INVADERS) return;

	local classname = pack.GetClassname()
	local refill    = false

	//AMMO PACKS
	if (startswith(classname, "item_ammopack_")) {
		local wep   = player.GetActiveWeapon()
		local scope = player.GetScriptScope().PopExtPlayerScope

		switch (player.GetPlayerClass()) {
		case 1: //TF_CLASS_SCOUT
			if (NetProps.GetPropEntityArray(self, "m_hMyWeapons", 1).GetClassname() == "tf_weapon_jar_milk" || NetProps.GetPropEntityArray(self, "m_hMyWeapons", 1).GetClassname() == "tf_weapon_cleaver")
				scope.maxammo.scout[1] = -1

		case 3: //TF_CLASS_SOLDIER
			if (GetPropInt(NetProps.GetPropEntityArray(self, "m_hMyWeapons", 0), "m_AttributeManager.m_Item.m_iItemDefinitionIndex") == 237)
				scope.maxammo.soldier[0] *= 3
		break

		case 4: //TF_CLASS_DEMOMAN
			if (GetPropInt(NetProps.GetPropEntityArray(self, "m_hMyWeapons", 1), "m_AttributeManager.m_Item.m_iItemDefinitionIndex") == 130) //scotres index
				scope.maxammo.demo[1] *= 1.5
		break

		case 5: //TF_CLASS_MEDIC
			if (NetProps.GetPropEntityArray(self, "m_hMyWeapons", 0).GetClassname() == "tf_weapon_crossbow")
				scope.maxammo.medic[0] *= 0.25
		break

		case 7: //TF_CLASS_PYRO
			if (NetProps.GetPropEntityArray(self, "m_hMyWeapons", 0).GetClassname() == "tf_weapon_flaregun")
				scope.maxammo.pyro[1] *= 0.5
		break
		}
		//engi metal
		if (player.GetPlayerClass() == TF_CLASS_ENGINEER) ammo.append(scope.maxmetal);

		for (local i = 0; i < ammo.len(); i++) {
			local ammoslot = GetAmmoInSlot(player, i)
			if (ammoslot >= ammo[i]) continue

			refill = true

			if (endswith(classname, "_small"))
				SetReserveAmmo(wep, (ammo[i] * 0.2) + ammoslot, i)
			else if (endswith(classname, "_medium"))
				SetReserveAmmo(wep, (ammo[i] * 0.5) + ammoslot, i)
			else if (endswith(classname, "_full"))
				SetReserveAmmo(wep, ammo[i], i)
		}

		//check to make sure we don't have more ammo than expected
		for (local i = 0; i < ammo.len(); i++)
			if (GetPropIntArray(player, "m_iAmmo", i + 1) > ammo[i])
				EntFireByHandle(player, "RunScriptCode", "SetReserveAmmo(self, " + ammo[i] + "," + i + ")", -1, null, null)

		if (refill) {
			EmitSoundOnClient("AmmoPack.Touch", player)
			pack.SetOrigin(pack.GetOrigin() - Vector(0, 0, 2000))
			EntFireByHandle(pack, "Disable", "", -1, null, null)
			EntFireByHandle(pack, "RunScriptCode", "self.SetOrigin(self.GetOrigin() + Vector(0, 0, 2000))", 9.9, null, null)
			EntFireByHandle(pack, "Enable", "", 10, null, null)
		}
	}
	//HEALTH KITS
	else if (startswith(classname, "item_healthkit_")) {
		local hp    = player.GetHealth()
		local maxhp = player.GetMaxHealth()
		if (hp >= maxhp) return

		EmitSoundOnClient("HealthKit.Touch", player)
		local hpamount   = 0
		local multiplier = 0

		if (endswith(classname, "_small"))       multiplier = 0.2
		else if (endswith(classname, "_medium")) multiplier = 0.5
		else if (endswith(classname, "_full"))   multiplier = 1.0

		hpamount = (maxhp * multiplier) + hp

		if (hpamount > maxhp) hpamount = maxhp
		player.ExtinguishPlayerBurning()

		SendGlobalGameEvent("player_healed", {
			patient = GetPlayerUserID(player)
			healer  = 0
			amount  = hp > maxhp * multiplier ? maxhp - hp : maxhp * multiplier
		})
		SendGlobalGameEvent("player_healonhit", {
			entindex         = player.entindex()
			weapon_def_index = 65535
			amount           = hp > maxhp * multiplier ? maxhp - hp : maxhp * multiplier
		})

		player.SetHealth(hpamount)

		pack.SetOrigin(pack.GetOrigin() - Vector(0, 0, 2000))
		EntFireByHandle(pack, "Disable", "", -1, null, null)
		EntFireByHandle(pack, "RunScriptCode", "self.SetOrigin(self.GetOrigin() + Vector(0, 0, 2000))", 9.9, null, null)
		EntFireByHandle(pack, "Enable", "", 10, null, null)
	}
}
//ammo draining think function
::DrainAmmo <-  function(player) {

	local scope     = player.GetScriptScope().PopExtPlayerScope
	local activegun = player.GetActiveWeapon()
	if (activegun == null) return

	local vm        = GetViewmodelEntity(player)
	local ammoslot  = GetAmmoInSlot(player, activegun.GetSlot())
	local metalslot = GetReserveMetal(player)

	local timestamp = (activegun.GetMaxClip1() == -1 || activegun.GetClassname() == "tf_weapon_compound_bow") ? GetPropFloat(activegun, "m_flNextPrimaryAttack") : GetPropFloat(activegun, "m_flReloadPriorNextFire")

	//m_flReloadPriorNextFire is a timestamp of when the player STARTS reloading
	//we need to wait until the ammo has actually been reloaded
	// if (scope.sequencearray.find(activegun.GetSequence()) != null) printl(GetPropFloat(vm, "m_flCycle"))
	if (((scope.lastreload != timestamp) || (GetItemIndex(activegun) == ID_DRAGONS_FURY && GetPropFloat(player, "m_Shared.m_flItemChargeMeter") < 0.001)) && ammoslot > 0 && scope.sequencearray.find(activegun.GetSequence()) != null) {
		//flamethrower/minigun ammo drains differently
		if ((player.GetPlayerClass() == TF_CLASS_PYRO || player.GetPlayerClass() == TF_CLASS_HEAVYWEAPONS) && scope.cooldown > Time()) return

		//set drain amount depending on if weapon is single reload or clip-based
		if (activegun.GetMaxClip1() == -1 || activegun.GetClassname() == "tf_weapon_compound_bow" || GetPropBool(activegun, "m_bReloadsSingly")) {
			scope.ammodrained   = true
			scope.drainedamount = 1

			//13 = airblast sequence
			if (activegun.GetSequence() == 13)
				if (GetItemIndex(activegun) == ID_BACKBURNER)
					scope.drainedamount = 50
				else if (GetItemIndex(activegun) == ID_DEGREASER)
					scope.drainedamount = 25
			else if (GetItemIndex(activegun) == ID_DRAGONS_FURY)
				scope.drainedamount = 2
			else
				scope.drainedamount = 20

			//metal draining weapons
			//see cfive_events OnGameEvent_player_builtobject for building metal draining
			if (player.GetPlayerClass() == TF_CLASS_ENGINEER) {
				//widowmaker drains metal instead
				if (GetItemIndex(activegun) == ID_WIDOWMAKER && metalslot >= 30) SetReserveMetal(player, metalslot - 30)
				//short circuit drain
				else if (GetItemIndex(activegun) == ID_SHORT_CIRCUIT && metalslot >= 5)
					if (InButton(player, IN_ATTACK2) && metalslot >= 65)
						SetReserveMetal(player, metalslot - 65)
					else if (!InButton(player, IN_ATTACK2))
						SetReserveMetal(player, metalslot - 5)
			}
		}
		else {
			scope.ammodrained   = true
			scope.drainedamount = activegun.GetMaxClip1() - activegun.Clip1()
		}

		//only drain one DF ammo
		if (GetItemIndex(activegun) == ID_DRAGONS_FURY)
			scope.dfdrained = true

		lastreload = timestamp

		// block reloading if our reserve is less than our current clip
		// if (ammoslot <= activegun.Clip1())
		// {
		//	activegun.AddAttribute("reload time increased hidden", INT_MAX, -1);
		//	activegun.ReapplyProvision();
		// }

		//firing speed changes
		if (GetItemIndex(activegun) == ID_TOMISLAV)
			scope.cooldown = Time() + 0.12
		else if (GetItemIndex(activegun) == ID_HUO_LONG_HEATER)
			scope.cooldown = Time() + 0.07 //do this better
		else
			scope.cooldown = Time() + 0.1
	}

	//some weapons don't actually finish their cycle before reloading.
	//cutoff generally seems to be 0.85 for most clip-based weapons
	local cycletime = 0.8
	if (activegun.GetSlot() == SLOT_PRIMARY && player.GetPlayerClass() == TF_CLASS_SOLDIER) cycletime = GetItemIndex(activegun) == ID_BEGGARS_BAZOOKA ? 0.0 : 0.42
	if ((player.GetPlayerClass() == TF_CLASS_SCOUT || player.GetPlayerClass() == TF_CLASS_DEMOMAN) && GetPropBool(activegun, "m_bReloadsSingly")) cycletime = 1.0
	if (activegun.GetMaxClip1() == -1) cycletime = 0.0
	if (activegun.GetClassname() == "tf_weapon_compound_bow") cycletime = 0.55

	// if (scope.sequencearray.find(activegun.GetSequence()) != null) printl(GetPropFloat(vm, "m_flCycle") + " : " + activegun.GetMaxClip1() + " : " + activegun.GetClassname())
	if (scope.sequencearray.find(activegun.GetSequence()) != null && scope.ammodrained && GetPropFloat(vm, "m_flCycle") >= cycletime) {
		scope.ammodrained = false
		// if (activegun.Clip1() != activegun.GetMaxClip1()) return;
		SetReserveAmmo(activegun, ammoslot - scope.drainedamount, activegun.GetSlot())

		//spy is fucked
		if (player.GetPlayerClass() == TF_CLASS_SPY)
			SetReserveAmmo(activegun, ammoslot - scope.drainedamount, activegun.GetSlot() + 1)
		return
	}

	if (GetItemIndex(GetWeaponInSlot(player, SLOT_PRIMARY)) == ID_DRAGONS_FURY && GetPropFloat(player, "m.Shared.m_flItemChargeMeter") == 100) scope.dfdrained = false
}
