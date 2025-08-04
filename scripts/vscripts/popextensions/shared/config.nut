POPEXT_CREATE_SCOPE( "__popext_config", "PopExtConfig" )

/****************************************************
* Set to false to manually include specific modules *
****************************************************/
PopExtConfig.IncludeAllModules <- true

/************************************************
* Enable debug logging for whitelisted modules *
************************************************/
PopExtConfig.DebugText <- false

/*********************************************
* Files/modules to enable debug logging for *
*********************************************/
PopExtConfig.DebugFiles <- {

    "missionattributes" : null
    "util" 				: null
    "tags" 				: null
}

/************************************************************************************************************
* manual cleanup flag, set to true for missions that are created for a specific map.                        *
* purpose-built map/mission combos where per-round cleanup is not necessary (mvm_redridge) should use this. *
* this should also be used if you change the popfile name mid-mission.                                      *
*************************************************************************************************************/
PopExtConfig.ManualCleanup <- false

/*************************************************************************************************************
* ignore these variables when cleaning up player scope                                                      *
* "Preserved" is a special table that will persist through the cleanup process unless full_cleanup is true. *
* any player scoped variables you want to use across multiple waves should be added here                    *
*************************************************************************************************************/
PopExtConfig.IgnoreTable <- {

    "self"         		   : null
    "__vname"      		   : null
    "__vrefs"      		   : null
    "Preserved"    		   : null
    "ExtraLoadout" 		   : null
    "templates_to_kill"    : null
    "wearables_to_kill"    : null
}