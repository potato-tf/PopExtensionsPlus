//credit to ficool2, Yaki and LizardofOz
IncludeScript("item_map.nut")
IncludeScript("popextensions.nut")

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

// copied from Yaki GTFW
::GTFW_MODEL_ARMS <-
[
	"models/weapons/c_models/c_medic_arms.mdl", //dummy
	"models/weapons/c_models/c_scout_arms.mdl",
	"models/weapons/c_models/c_sniper_arms.mdl",
	"models/weapons/c_models/c_soldier_arms.mdl",
	"models/weapons/c_models/c_demo_arms.mdl",
	"models/weapons/c_models/c_medic_arms.mdl",
	"models/weapons/c_models/c_heavy_arms.mdl",
	"models/weapons/c_models/c_pyro_arms.mdl",
	"models/weapons/c_models/c_spy_arms.mdl",
	"models/weapons/c_models/c_engineer_arms.mdl",
	"models/weapons/c_models/c_engineer_gunslinger.mdl",	//CIVILIAN/Gunslinger
]

//give item to specified player
//itemname accepts strings
::GiveItem <- function(itemname, player)
{
    if (!player) return

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

    if (itemname in TFItemMap)
    {
        id = TFItemMap[itemname].id
        item_class = TFItemMap[itemname].item_class

        //multiclass items will not spawn unless they are specified for a certain class
        //this includes multiclass shotguns, pistols, melees, base jumper, pain train (but not half zatoichi)
    }
    else return

    //create item entity
    local item = Entities.CreateByClassname(item_class);
    NetProps.SetPropInt(item, "m_AttributeManager.m_Item.m_iItemDefinitionIndex", id);
    NetProps.SetPropBool(item, "m_AttributeManager.m_Item.m_bInitialized", true);
    NetProps.SetPropBool(item, "m_bValidatedAttachedEntity", true);
    item.SetTeam(player.GetTeam());
    Entities.DispatchSpawn(item);

    foreach (attribute, value in extraitem)
    {
        if (!(attribute == "OriginalItemName" || attribute == "Name" || attribute == "Model" || attribute == "AnimSet"))
        {
            item.AddAttribute(attribute, value, -1.0);
        }
    }

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
        player.Weapon_Equip(item);

        // copied from ficool2 mw2_highrise
        // viewmodel
        local main_viewmodel = NetProps.GetPropEntity(player, "m_hViewModel");
        item.SetModelSimple("models/weapons/c_models/c_" + animset + "_arms.mdl");
        item.SetCustomViewModel("models/weapons/c_models/c_" + animset + "_arms.mdl");
        item.SetCustomViewModelModelIndex(GetModelIndex("models/weapons/c_models/c_" + animset + "_arms.mdl"));
        NetProps.SetPropInt(item, "m_iViewModelIndex", GetModelIndex("models/weapons/c_models/c_" + animset + "_arms.mdl"));

        // worldmodel
        local tpWearable = Entities.CreateByClassname("tf_wearable");
        NetProps.SetPropInt(tpWearable, "m_nModelIndex", modelindex);
        NetProps.SetPropBool(tpWearable, "m_bValidatedAttachedEntity", true);
        NetProps.SetPropBool(tpWearable, "m_AttributeManager.m_Item.m_bInitialized", true);
        NetProps.SetPropEntity(tpWearable, "m_hOwnerEntity", player);
        tpWearable.SetOwner(player);
        tpWearable.DispatchSpawn();
        EntFireByHandle(tpWearable, "SetParent", "!activator", 0.0, player, player);
        NetProps.SetPropInt(tpWearable, "m_fEffects", 129); // EF_BONEMERGE|EF_BONEMERGE_FASTCULL

        // copied from LizardOfOz open fortress dm_crossfire
        // viewmodel arms
        NetProps.SetPropInt(item, "m_nRenderMode", 1);
        NetProps.SetPropInt(item, "m_clrRender", 1);

        local hands = SpawnEntityFromTable("tf_wearable_vm", {
            modelindex = PrecacheModel(format("models/weapons/c_models/c_%s_arms.mdl", playerclass))
        })
        NetProps.SetPropBool(hands, "m_bForcePurgeFixedupStrings", true);
        player.EquipWearableViewModel(hands);

        local hands2 = SpawnEntityFromTable("tf_wearable_vm", {
            modelindex = PrecacheModel(model)
        })
        NetProps.SetPropBool(hands2, "m_bForcePurgeFixedupStrings", true);
        player.EquipWearableViewModel(hands2);

        NetProps.SetPropEntity(hands2, "m_hWeaponAssociatedWith", item);
        NetProps.SetPropEntity(item, "m_hExtraWearableViewModel", hands2);

        player.Weapon_Switch(item);
        player.ValidateScriptScope()
    }
    return item;
}

//returns the slot number of entities with classname tf_weapon_
//also includes exceptions for passive weapons such as demo shields, soldier/demo boots and sniper backpacks
//action slot items return 6 so as to not conflict with engineer's toolbox (tf_weapon_builder)
//action items includes canteen, spellbook, grappling hook, contracker
//return null if the entity is not a weapon or passive weapon
::FindSlot <- function(item)
{
    if (item.GetClassname().find("tf_weapon_") == 0) return item.GetSlot()
    else
    {
        //base jumper and invis watches are not included as they have classnames starting with "tf_weapon_"
        local id = NetProps.GetPropInt(item, "m_AttributeManager.m_Item.m_iItemDefinitionIndex")

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

GiveItem("Wasp Launcher", GetListenServerHost())
PrintTable(ExtraItems["Wasp Launcher"])

