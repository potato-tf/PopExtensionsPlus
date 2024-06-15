//credit to ficool2, Yaki and LizardofOz
ExtraItems <-
{
	"Wasp Launcher" :
	{
        OriginalItemName = "Upgradeable TF_WEAPON_ROCKETLAUNCHER"
        Model = "models/weapons/c_models/c_wasp_launcher/c_wasp_launcher.mdl"
        AnimSet = "soldier"
        "blast radius increased" : 1.5
        "max health additive bonus" : 100
	}
	"Thumper" :
	{
        OriginalItemName = "Upgradeable TF_WEAPON_SHOTGUN_PRIMARY"
        Model = "models/weapons/c_models/c_rapidfire/c_rapidfire_1.mdl"
        AnimSet = "engineer"
		ItemClassOverride = "tf_weapon_shotgun_priamry"
        "damage bonus" : 2.3
        "clip size bonus" : 1.25
        "weapon spread bonus" : 0.85
        "maxammo secondary increased" : 1.5
        "fire rate penalty" : 1.2
        "bullets per shot bonus" : 0.5
        "Reload time increased" : 1.13
        "single wep deploy time increased" : 1.15
        "minicritboost on kill" : 5
	}
	"Crowbar" :
	{
        OriginalItemName = "Necro Smasher"
        Model = "models/weapons/c_models/c_cratesmasher/c_cratesmasher_1.mdl"
        AnimSet = "scout"
		"deploy time decreased" : 0.75
		"fire rate bonus" : 0.30
		"damage penalty" : 0.54
	}
}

::CustomWeapons <- {
	//give item to specified player
	//itemname accepts strings
	function GiveItem(itemname, player)
	{
		if (!player || player.GetPlayerClass() < 1) return
		local playerclass = PopExtUtil.Classes[player.GetPlayerClass()]

		local extraitem = null
		local model = null
		local modelindex = null
		local animset = null
		//if item is a custom item, overwrite itemname with OriginalItemName
		if (itemname in ExtraItems)
		{
			extraitem = ExtraItems[itemname]
			model = ExtraItems[itemname].Model
			modelindex = GetModelIndex(model)
			animset = ExtraItems[itemname].AnimSet
			itemname = ExtraItems[itemname].OriginalItemName
		}

		local id = null
		local item_class = null

		if (itemname in PopExtItems)
		{
			if ("ItemClassOverride" in PopExtItems[itemname])
			{
				item_class = PopExtItems[itemname].ItemClassOverride
				return
			}
			id = PopExtItems[itemname].id
			item_class = PopExtItems[itemname].item_class

			if (item_class == "tf_weapon_shotgun")
			{
				local shotguns = {
					"soldier" : "tf_weapon_shotgun_soldier"
					"pyro" : "tf_weapon_shotgun_pyro"
					"heavy" : "tf_weapon_shotgun_hwg"
					"engineer" : "tf_weapon_shotgun_primary"
				}

				item_class = shotguns[playerclass]
			}

			//multiclass items will not spawn unless they are specified for a certain class
			//this includes multiclass shotguns, pistols, melees, base jumper, pain train (but not half zatoichi)
		}
		else return

		//create item entity
		local item = CreateByClassname(item_class)
		SetPropInt(item, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", id)
		SetPropBool(item, "m_AttributeManager.m_Item.m_bInitialized", true)
		SetPropBool(item, "m_bValidatedAttachedEntity", true)
		item.SetTeam(player.GetTeam())
		DispatchSpawn(item)
		local reservedKeywords = {
			"OriginalItemName" : null
			"ItemClassOverride" : null
			"Name" : null
			"Model" : null
			"AnimSet" : null
		}
		foreach (attribute, value in extraitem)
			if (!(attribute in reservedKeywords))
				if (attribute in CustomAttributes.Attrs)
					CustomAttributes.AddAttr(player, attribute, value, {item = [attribute, value]})
				else
					item.AddAttribute(attribute, value, -1.0)



		//find the slot of the weapon then iterate through all entities parented to the player
		//and kill the entity that occupies the required slot
		local slot = FindSlot(item)
		if (slot != null)
		{
			local itemreplace = player.FirstMoveChild()
			while (itemreplace)
			{
				if (FindSlot(itemreplace) == slot)
				{
					itemreplace.Destroy()
					break
				}
				itemreplace = itemreplace.NextMovePeer()
			}
			player.Weapon_Equip(item)

			// copied from ficool2 mw2_highrise
			// viewmodel
			local main_viewmodel = GetPropEntity(player, "m_hViewModel")

			local armmodel = ""

			animset ? armmodel = animset : armmodel = main_viewmodel.GetModelName()

			printl(armmodel)

			item.SetModelSimple(armmodel)
			item.SetCustomViewModel(armmodel)
			item.SetCustomViewModelModelIndex(GetModelIndex(armmodel))
			SetPropInt(item, "m_iViewModelIndex", GetModelIndex(armmodel))

			// worldmodel
			local tpWearable = CreateByClassname("tf_wearable")
			SetPropInt(tpWearable, "m_nModelIndex", modelindex)
			SetPropBool(tpWearable, "m_bValidatedAttachedEntity", true)
			SetPropBool(tpWearable, "m_AttributeManager.m_Item.m_bInitialized", true)
			SetPropEntity(tpWearable, "m_hOwnerEntity", player)
			tpWearable.SetOwner(player)
			tpWearable.DispatchSpawn()
			EntFireByHandle(tpWearable, "SetParent", "!activator", 0.0, player, player)
			SetPropInt(tpWearable, "m_fEffects", 129) // EF_BONEMERGE|EF_BONEMERGE_FASTCULL

			// copied from LizardOfOz open fortress dm_crossfire
			// viewmodel arms
			SetPropInt(item, "m_nRenderMode", kRenderTransColor)
			SetPropInt(item, "m_clrRender", 1)

			local hands = SpawnEntityFromTable("tf_wearable_vm", {
				modelindex = PrecacheModel(format("models/weapons/c_models/c_%s_arms.mdl", playerclass))
			})
			SetPropBool(hands, "m_bForcePurgeFixedupStrings", true)
			player.EquipWearableViewModel(hands)

			local hands2 = SpawnEntityFromTable("tf_wearable_vm", {
				modelindex = PrecacheModel(model)
			})
			SetPropBool(hands2, "m_bForcePurgeFixedupStrings", true)
			player.EquipWearableViewModel(hands2)

			SetPropEntity(hands2, "m_hWeaponAssociatedWith", item)
			SetPropEntity(item, "m_hExtraWearableViewModel", hands2)

			player.Weapon_Switch(item)
			player.ValidateScriptScope()
		}
		return item;
	}

	//returns the slot number of entities with classname tf_weapon_
	//also includes exceptions for passive weapons such as demo shields, soldier/demo boots and sniper backpacks
	//action slot items return 6 so as to not conflict with engineer's toolbox (tf_weapon_builder)
	//action items includes canteen, spellbook, grappling hook, contracker
	//return null if the entity is not a weapon or passive weapon
	function FindSlot(item)
	{
		if (item.GetClassname().find("tf_weapon_") == 0) return item.GetSlot()
		else
		{
			//base jumper and invis watches are not included as they have classnames starting with "tf_weapon_"
			local id = GetPropInt(item, "m_AttributeManager.m_Item.m_iItemDefinitionIndex")

			//Ali Baba's Wee Booties and Bootlegger
			if ([405, 608].find(id) != null) return 0

			//Razorback, Gunboats, Darwin's Danger Shield, Mantreads, Cozy Camper
			else if ([57, 133, 231, 444, 642].find(id) != null) return 1

			//All demo shields
			else if (item.GetClassname() == "tf_wearable_demoshield") return 1

			//Action items
			else if ((item.GetClassname() == "tf_powerup_bottle"
			|| item.GetClassname() == "tf_wearable_campaign_item")
			&& (item.GetClassname() == "tf_weapon_grapplinghook"
			|| item.GetClassname() == "tf_weapon_spellbook"))
			{
				return 6
			}
		}
		return null
	}
}

CustomWeapons.GiveItem("Wasp Launcher", GetListenServerHost())
PopExtUtil.PrintTable(ExtraItems["Wasp Launcher"])

