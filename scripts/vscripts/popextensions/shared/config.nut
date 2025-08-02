class PopExtConfig {

    /****************************************************
     * Include all modules by default, or manually list *
     ****************************************************/
	IncludeAllModules = true

    /************************************************
     * Enable debug logging for whitelisted modules *
     ************************************************/
	DebugText = false

    /*********************************************
     * Files/modules to enable debug logging for *
     *********************************************/
	DebugFiles = {

		"missionattributes" : null
		"util" 				: null
		"tags" 				: null
	}

    /******************************************************************************************************************************************
     * manual cleanup flag, set to true for missions that are created for a specific map.                                                     *
     * automated unloading is meant for multiple missions on one map, purpose-built map/mission combos ( like mvm_redridge ) don't need this. *
     * this should also be used if you change the popfile name mid-mission.                                                                   *
     *****************************************************************************************************************************************/
	ManualCleanup = false

    /*************************************************************************************************************
     * ignore these variables when cleaning up player scope                                                      *
     * "Preserved" is a special table that will persist through the cleanup process unless full_cleanup is true. *
     * any player scoped variables you want to use across multiple waves should be added here                    *
     *************************************************************************************************************/
	IgnoreTable = {

		"self"         		   : null
		"__vname"      		   : null
		"__vrefs"      		   : null
		"Preserved"    		   : null
		"ExtraLoadout" 		   : null
		"templates_to_kill"    : null
		"wearables_to_kill"    : null
	}
}