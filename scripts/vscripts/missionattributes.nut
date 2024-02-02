::MissionAttributes <- {};              // MissionAttributes namespace.
MissionAttributes.CurrAttrs <- [];       // Array storing currently modified attributes.
MissionAttributes.DebugText <- false;     // Print debug text.
MissionAttributes.RaisedParseError <- false;

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.
function MissionAttributes::MissionAttr(attr, value)
{
    local success = true;
    switch(attr) {
    
    // =========================================================
    case "ForceHoliday":
    // Replicates sigsegv-mvm: ForceHoliday.
    // Forces a tf_holiday for the mission.
    // Supported Holidays are:
    //  0 - None
    //  1 - Birthday
    //  2 - Halloween
    //  3 - Christmas
    // @param Holiday       Holiday number to force.
    // @error TypeError     If type is not an integer.
    // @error IndexError    If invalid holiday number is passed.
        // Error Handling
        if (type(value) != "integer") {RaiseTypeError(attr, "int"); success = false; break;}
        if (value < 0 || value > 2) {RaiseIndexError(attr); success = false; break;}
        
        // Set Holiday logic
        SendToServerConsole(format("tf_forced_holiday %d", value));
        if (value == 0) break;
        
        local ent = Entities.FindByName(null, "MissionAttrHoliday");
        if (ent != null) ent.Kill();
        SpawnEntityFromTable("tf_logic_holiday", 
        {
            targetname = "MissionAttrHoliday",
            holiday_type = value
        });
        
        break;
    // ========================================================
    
    // Don't add attribute to clean-up list if it could not be found.
    default:
        ParseError(format("Could not find mission attribute '%s'", attr));
        success = false;
    }
    
    // Add attribute to clean-up list if its modification was successful.
    if (success)
    {
        DebugLog(format("Added mission attribute %s", attr));
        MissionAttributes.CurrAttrs.append(attr);
    }
}

// Allow calling MissionAttributes::MissionAttr() directly with MissionAttr().
function MissionAttr(attr, value)
{
    MissionAttr.call(MissionAttributes, attr, value)
}

// Clean-up Functions
// =========================================================
// Function runs the appropriate clean-up method for the provided attribute.
function MissionAttributes::DoCleanupMethod(attr)
{
    switch(attr) {
    case "ForceHoliday":
        // tf_logic_holiday will be removed by the game. 
        SendToServerConsole("tf_forced_holiday 0");
        break;
    default:
        // Raise an exception if clean-up method is missing
        RaiseException(format("Clean-up method not found for %s", attr));
    }
    
    DebugLog(format("Cleaned up mission attribute %s", attr));
}

// Hook first wave init to run clean-up.
function MissionAttributes::OnGameEvent_teamplay_round_start(params)
{
    ResetDefaults();
    this = {};
}

// Hook all wave inits to reset parsing error counter.
function MissionAttributes::OnGameEvent_mvm_reset_stats(params)
{
    MissionAttributes.RaisedParseError = false;
}

// Function resets and clears all registered changed attributes.
function MissionAttributes::ResetDefaults()
{
    foreach (attr in MissionAttributes.CurrAttrs)
    {
        DoCleanupMethod(attr);
    }
    MissionAttributes.CurrAttrs.clear();
}

// Logging Functions
// =========================================================
// Generic debug message that is visible if PrintDebugText is true.
// Example: Print a message that the script is working as expected.
function MissionAttributes::DebugLog(LogMsg)
{
    if (MissionAttributes.DebugText)
    {
        ClientPrint(null, 2, format("missionattributes.nut: %s.", LogMsg));
    }
}

// Raises an error if the user passes an index that is out of range.
// Example: Allowed values are 1-2, but user passed 3.
function MissionAttributes::RaiseIndexError(attr) ParseError(format("Index out of range for %s", attr));

// Raises an error if the user passes an argument of the wrong type.
// Example: Allowed values are strings, but user passed a float.
function MissionAttributes::RaiseTypeError(attr, type) ParseError(format("Bad type for %s (should be %s)", attr, type));

// Raises a template parsing error, if nothing else fits.
function MissionAttributes::ParseError(ErrorMsg)
{
    if (!MissionAttributes.RaisedParseError)
    {
        MissionAttributes.RaisedParseError = true;
        ClientPrint(null, 3, "\x08FFB4B4FFIt is possible that a parsing error has occured. Check console for details.");
    }
    ClientPrint(null, 2, format("missionattributes.nut ERROR: %s.", ErrorMsg));
}

// Raises an exception.
// Example: Script modification has not been performed correctly. User should never see one of these.
function MissionAttributes::RaiseException(ExceptionMsg)
{
    Assert(false, format("missionattributes.nut EXCEPTION: %s.", ExceptionMsg));
}

// =========================================================
// Register MissionAttributes callbacks.
__CollectGameEventCallbacks(MissionAttributes);
