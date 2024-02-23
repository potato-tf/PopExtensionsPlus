#by washy
popExtScope.waveSchedulePointTemplates <- []
popExtScope.wavePointTemplates <- []
popExtScope.globalTemplateSpawnCount <- 0

::CopyTable <- function(table)
{
    if (table == null) return
    local newtable = {}
    foreach (key, value in table)
    {
        newtable[key] <- value
        if (typeof(value) == "table" || typeof(value) == "array")
        {
            newtable[key] = CopyTable(value)
        }
        else 
        {
            newtable[key] <- value
        }
    }
    return newtable
}

//spawns an entity when called, can be called on StartWaveOutput and InitWaveOutput, automatically kills itself after wave completion
::SpawnTemplate <- function(pointtemplate, parent = null, origin = Vector(), angles = QAngle())
{
    // credit to ficool2
    popExtScope.globalTemplateSpawnCount <- popExtScope.globalTemplateSpawnCount + 1

    local template = SpawnEntityFromTable("point_script_template", {})
    local scope = template.GetScriptScope()

    local nofixup = false
    local keepalive = false
    local removeifkilled = ""

    scope.parent <- parent
    scope.Entities <- []
    scope.EntityFixedUpTargetName <- []
    scope.OnSpawnOutputArray <- []
    scope.OnParentKilledOutputArray <- []
    scope.SpawnedEntities <- []

    scope.__EntityMakerResult <- {entities = scope.Entities}.setdelegate({_newslot = function(_, value) {entities.append(value)}})
    scope.PostSpawn <- function(named_entities)
    {
        //can only set bounding box size for brush entities after they spawn
        foreach (entity in Entities) {
            local buf = split(NetProps.GetPropString(entity, "m_iszResponseContext"), ",")
            if (buf.len() == 6)
            {
                entity.SetSize(Vector(buf[0].tointeger(), buf[1].tointeger(), buf[2].tointeger()), Vector(buf[3].tointeger(), buf[4].tointeger(), buf[5].tointeger()))
                entity.SetSolid(2)
            }

            scope.SpawnedEntities.append(entity)
            popExtScope.wavePointTemplates.append(entity)

            if (parent != null)
            {
                //this function is defined in popextensions.nut
                SetParentLocalOrigin(entity, parent)
    
                //entities parented to players do not kill itself when the player dies as the player entity is not considered killed
                if (parent.IsPlayer())
                {
                    if (keepalive == false)
                    {
                        parent.ValidateScriptScope()
                        local scope = parent.GetScriptScope()
                        // reused from CreatePlayerWearable function
                        if (!("popWearablesToDestroy" in scope)) {
                            scope.popWearablesToDestroy <- []
                        }
                        scope.popWearablesToDestroy.append(entity)
                    }
                }
            }
        }
        if (parent != null)
        {
            if (parent.IsPlayer())
            {
                // copied from popextensions_hooks.nut
                if (scope.OnParentKilledOutputArray.len() > 0)
                {
                    local playerscope = parent.GetScriptScope()
                    if (!("popHooks" in playerscope)) {
                        playerscope["popHooks"] <- {};
                    }
                    if (!("OnDeath" in playerscope.popHooks)) {
                        playerscope.popHooks["OnDeath"] <- []
                    }
                    
                    local FireOnParentKilledOutputs = function(bot, params) { 
                        foreach (output in scope.OnParentKilledOutputArray) {
                            local target = output.Target
                            local action = output.Action
                            local param = ("Param" in output) ? output.Param : null
                            local delay = ("Delay" in output) ? output.Delay : 0
                
                            EntFire(target, action, param, delay, null)
                        }
                    }

                    playerscope.popHooks["OnDeath"].append(FireOnParentKilledOutputs);
                }
            }
            //use own think instead of parent's think
            local function CheckIfKilled()
            {
                if (parent.IsValid())
                {
                    lastorigin <- parent.GetOrigin()
                    lastangles <- parent.GetAbsAngles()
                }
                else
                {
                    if (keepalive == true)
                    {
                        //spawn template again after being killed
                        SpawnTemplate(pointtemplate, null, lastorigin + origin, lastangles + angles)
                    }

                    //fire OnParentKilledOutputs
                    //does not work on its own internal entities if NoFixup is true since the entities are always killed
                    if (OnParentKilledOutputArray.len() > 0)
                    {
                        foreach (output in OnParentKilledOutputArray) {
                            local target = output.Target
                            local action = output.Action
                            local param = ("Param" in output) ? output.Param : null
                            local delay = ("Delay" in output) ? output.Delay : 0
                
                            EntFire(target, action, param, delay, null)
                        }
                    }
                    NetProps.SetPropString(self, "m_iszScriptThinkFunction", "");
                }

                if (removeifkilled != "")
                {
                    if(FindByName(null, removeifkilled) == null)
                    {
                        foreach (entity in scope.SpawnedEntities) 
                        {
                            if (entity.IsValid()) {
                                entity.Kill();
                            }
                        }
                        NetProps.SetPropString(self, "m_iszScriptThinkFunction", "");
                    }
                }
                return -1
            }
            scope.CheckIfKilled <- CheckIfKilled
            AddThinkToEnt(template, "CheckIfKilled")
        }

        //fire OnSpawnOutputs
        foreach (output in OnSpawnOutputArray) {
            local target = output.Target
            local action = output.Action
            local param = ("Param" in output) ? output.Param : null
            local delay = ("Delay" in output) ? output.Delay : 0

            EntFire(target, action, param, delay, null)
        }
    }

    //make a copy of the pointtemplate
    local pointtemplatecopy = CopyTable(pointtemplate)

    //establish "flags"
    foreach (index, entity in pointtemplatecopy) {
        if (typeof(index) == "string")
        {
            if (index == "NoFixup" && entity == true) nofixup = true
            else if (index == "KeepAlive" && entity == true) keepalive = true
            else if (index == "RemoveIfKilled") scope.removeifkilled <- entity
        }
    }

    //perform name fixup
    if (nofixup == false)
    {
        //first, get list of targetnames in the point template for name fixup
        foreach (index, entity in pointtemplatecopy) 
        {
            if (typeof(entity) == "table")
            {
                foreach (classname, keyvalues in entity) 
                {
                    foreach(key, value in keyvalues)
                    {
                        if (key == "targetname" && scope.EntityFixedUpTargetName.find(value) == null)
                        {
                            scope.EntityFixedUpTargetName.append(value)
                        }
                    }
                }
            }
        }

        //iterate through all entities and fixup every value containing a valid targetname
        //may have issues with targetnames that are substrings of other targetnames?
        //this should cover targetnames, parentnames, target, and output params
        foreach (index, entity in pointtemplatecopy) 
        {
            if (typeof(entity) == "table")
            {
                foreach (classname, keyvalues in entity) 
                {
                    foreach(key, value in keyvalues)
                    {
                        if (typeof(value) == "string")
                        {
                            foreach(targetname in scope.EntityFixedUpTargetName)
                            {
                                if (value.find(targetname) != null && value.find("/") == null) //ignore potential file paths, also ignores targetnames with "/"
                                {
                                    keyvalues[key] <- value.slice(0, targetname.len()) + popExtScope.globalTemplateSpawnCount + value.slice(targetname.len())
                                }
                            }
                        }
                    }
                }
            }
            if (index == "RemoveIfKilled") scope.removeifkilled <- entity + popExtScope.globalTemplateSpawnCount
        }
    }

    //add templates to point_script_template
    foreach (index, entity in pointtemplatecopy) 
    {
        if (typeof(entity) == "table")
        {
            foreach (classname, keyvalues in entity) 
            {
                if (classname == "OnSpawnOutput")
                {
                    scope.OnSpawnOutputArray.append(keyvalues)
                }
                else if (classname == "OnParentKilledOutput")
                {
                    scope.OnParentKilledOutputArray.append(keyvalues)
                }
                else
                {
                    //adjust origin and angles
                    if ("origin" in keyvalues) keyvalues.origin += origin
                    else keyvalues.origin <- origin
                    if ("angles" in keyvalues) keyvalues.angles += angles
                    else keyvalues.angles <- angles

                    //needed for brush entities
                    if ("mins" in keyvalues || "maxs" in keyvalues)
                    {
                        local mins = ("mins" in keyvalues) ? keyvalues.mins : Vector()
                        local maxs = ("maxs" in keyvalues) ? keyvalues.maxs : Vector()

                        //overwrite responsecontext even if someone fills it in for some reason
                        keyvalues.responsecontext <- mins.ToKVString() + " " + maxs.ToKVString()
                    }

                    template.AddTemplate(classname, keyvalues)
                }
            }
        }
    }
    EntFireByHandle(template, "ForceSpawn", "", -1, null, null);
}

//altenative version of SpawnTemplate that will recreate itself only after wave resets (after failure, after voting, after using tf_mvm_jump_to_wave) to imitate spawning in WaveSchedule
//does not accept parent parameter, does not allow parenting entities
::SpawnTemplateWaveSchedule <- function(pointtemplate, origin = null, angles = null)
{
    popExtScope.waveSchedulePointTemplates.append([pointtemplate, origin, angles])
}

//simplifed version of SpawnTemplate, accepts whether or not to perform name fixup as a boolean parameter
::SpawnTemplateSimple <- function(pointtemplate, parent = null, origin = Vector(), angles = QAngle(), fixup = true)
{
    // credit to ficool2
    popExtScope.globalTemplateSpawnCount <- popExtScope.globalTemplateSpawnCount + 1

    local template = SpawnEntityFromTable("point_script_template", {});
    local scope = template.GetScriptScope();

    scope.Entities <- []
    scope.EntityFixedUpTargetName <- []

    scope.__EntityMakerResult <- {entities = scope.Entities}.setdelegate({_newslot = function(_, value) {entities.append(value)}});
    scope.PostSpawn <- function(named_entities)
    {
        //can only set bounding box size for brush entities after they spawn
        foreach (entity in Entities) {
            local buf = split(NetProps.GetPropString(entity, "m_iszResponseContext"), ",");
            if (buf.len() == 6)
            {
                entity.SetSize(Vector(buf[0].tointeger(), buf[1].tointeger(), buf[2].tointeger()), Vector(buf[3].tointeger(), buf[4].tointeger(), buf[5].tointeger()));
                entity.SetSolid(2);
            }

            if (parent != null)
            {
                //this function is defined in popextensions.nut
                SetParentLocalOrigin(entity, parent)
            }
        }
    }

    //make a copy of the pointtemplate
    local pointtemplatecopy = CopyTable(pointtemplate)

    //perform name fixup
    if (fixup == true)
    {
        //first, get list of targetnames in the point template for name fixup
        foreach (index, entity in pointtemplatecopy) 
        {
            if (typeof(entity) == "table")
            {
                foreach (classname, keyvalues in entity) 
                {
                    foreach(key, value in keyvalues)
                    {
                        if (key == "targetname" && scope.EntityFixedUpTargetName.find(value) == null)
                        {
                            scope.EntityFixedUpTargetName.append(value)
                        }
                    }
                }
            }
        }

        //iterate through all entities and fixup every value containing a valid targetname
        //may have issues with targetnames that are substrings of other targetnames?
        //this should cover targetnames, parentnames, target, and output params
        foreach (index, entity in pointtemplatecopy) 
        {
            if (typeof(entity) == "table")
            {
                foreach (classname, keyvalues in entity) 
                {
                    foreach(key, value in keyvalues)
                    {
                        if (typeof(value) == "string")
                        {
                            foreach(targetname in scope.EntityFixedUpTargetName)
                            {
                                if (value.find(targetname) != null && value.find("/") == null) //ignore potential file paths, also ignores targetnames with "/"
                                {
                                    keyvalues[key] <- value.slice(0, targetname.len()) + popExtScope.globalTemplateSpawnCount + value.slice(targetname.len())
                                }   
                            }
                        }
                    }
                }
            }
        }
    }

    //add templates to point_script_template
    foreach (index, entity in pointtemplatecopy) 
    {
        if (typeof(entity) == "table")
        {
            foreach (classname, keyvalues in entity) 
            {
                //adjust origin and angles
                if ("origin" in keyvalues) keyvalues.origin += origin
                else keyvalues.origin <- origin
                if ("angles" in keyvalues) keyvalues.angles += angles
                else keyvalues.angles <- angles

                //needed for brush entities
                if ("mins" in keyvalues || "maxs" in keyvalues)
                {
                    local mins = ("mins" in keyvalues) ? keyvalues.mins : Vector()
                    local maxs = ("maxs" in keyvalues) ? keyvalues.maxs : Vector()

                    //overwrite responsecontext even if someone fills it in for some reason
                    keyvalues.responsecontext <- mins.ToKVString() + " " + maxs.ToKVString()
                }
                template.AddTemplate(classname, keyvalues)
            }
        }
    }
    EntFireByHandle(template, "ForceSpawn", "", -1, null, null);
}

//hook to both of these events to emulate OnWaveInit
function OnGameEvent_mvm_wave_complete(params)
{
    foreach(entity in popExtScope.wavePointTemplates) {
        if (entity.IsValid()) {
            entity.Kill();
        }
    }
    popExtScope.wavePointTemplates.clear()
}
function OnGameEvent_mvm_wave_failed(params) //despite the name, this event also calls on wave reset from voting, and on jumping to wave, and when loading mission
{
    //messy
    foreach(param in popExtScope.waveSchedulePointTemplates) {
        SpawnTemplate(param[0], null, param[1], param[2])
    }
}
__CollectGameEventCallbacks(this);
