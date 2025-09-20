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
    "gamestrings"       : null
    "util" 				: null
    "tags" 				: null
}

/************************************************************************************************************
* manual cleanup flag                                                                                       *
* purpose-built map/mission combos where per-round cleanup is not necessary (mvm_redridge) should use this. *
* this should also be used if you change the popfile name mid-mission.                                      *
* to manually clean everything up, call PopExtMain.FullCleanup()                                            *
*************************************************************************************************************/
PopExtConfig.ManualCleanup <- false

/*************************************************************************************************************
* ignore these variables when cleaning up player scope                                                      *
* "PRESERVED" is a special table that will persist through the player death/spawn cleanup steps.            *
* any entity scoped variables you want to use across multiple lives should be added here                    *
*************************************************************************************************************/
PopExtConfig.IgnoreTable <- {

    "self"         		   : null
    "__vname"      		   : null
    "__vrefs"      		   : null
    "PRESERVED"    		   : null
}

//
// All entity classname prefixes listed here will have their think functions overwritten and throw a warning
// Think functions will instead be added to a table with the value of the first element in the array
// You should always use PopExtUtil.AddThink instead to handle these gracefully.

// e.g. calling AddThinkToEnt( player, "MyFunc") with the default config:
// - Creates a table named "PlayerThinkTable" and a think function named "PlayerThinks" in player scope
// - The "true" think function is set to "PlayerThinks", this function iterates over the table and calls each function
// - Passing null will simply clear the think table


PopExtConfig.ThinkTableSetup <- {

    // entity classname prefixes to overwrite, and the name of the think table
    player 			= [ "PlayerThinkTable", "PlayerThinks" ]
    tank_boss 		= [ "TankThinkTable", "TankThinks" ]
    tf_projectile_ 	= [ "ProjectileThinkTable", "ProjectileThinks" ]
    tf_weapon_ 		= [ "ItemThinkTable", "ItemThinks" ]
    tf_wearable 	= [ "ItemThinkTable", "ItemThinks" ]
}