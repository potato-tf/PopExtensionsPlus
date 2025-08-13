VSCRIPT_API_DOCS <- {
    ScriptFunctions = {
        CBaseEntity = {
            AcceptInput = {
                info = "'bool AcceptInput(string ''input'', string ''param'', handle ''activator'', handle ''caller'')'"
                args = 4
                description = "Generate a synchronous I/O event. Unlike 'EntFireByHandle', this is processed immediately. Returns false if ''input'' is a null/empty string, or if the input wasn't handled."
            }
            AddEFlags = {
                info = "'void AddEFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FEntityEFlags|FEntityEFlags]] ''flags'')'"
                args = 1
                description = "Adds the supplied ''flags'' to the '''Entity Flags''' in the entity. ''(m_iEFlags datamap)''"
                note = ["Adding 'EFL_KILLME' will make the entity unkillable, even on round resets, until the flag is removed."]
            }
            AddFlag = {
                info = "'void AddFlag([[Team_Fortress_2/Scripting/Script_Functions/Constants#FPlayer|FPlayer]] ''flags'')'"
                args = 1
                description = "Adds the supplied ''flags'' to another separate player-related entity flags system in the entity. ''(m_fFlags datamap)''"
            }
            AddSolidFlags = {
                info = "'void AddSolidFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FSolid|FSolid]] ''flags'')'"
                args = 1
                description = "Adds the supplied ''flags'' to the ''Solid Flags'' in the entity. ''(m_Collision.m_usSolidFlags datamap)''"
            }
            ApplyAbsVelocityImpulse = {
                info = "'void ApplyAbsVelocityImpulse(Vector ''impulse'')'"
                args = 1
                description = "Apply a Velocity Impulse as a world space impulse vector. Works for most physics-based objects including dropped weapons and even dropped Sandviches."
            }
            ApplyLocalAngularVelocityImpulse = {
                info = "'void ApplyLocalAngularVelocityImpulse(Vector ''impulse'')'"
                args = 1
                description = "Apply an Angular Velocity Impulse in entity local space. The direction of the input vector is the rotation axis, and the length is the magnitude of the impulse."
            }
            BecomeRagdollOnClient = {
                info = "'bool BecomeRagdollOnClient(Vector ''impulse'')'"
                args = 1
                description = "Acts like the 'BecomeRagdoll' input, with the required ''impulse'' value applied as a force on the ragdoll. Does NOT spawn a '[[prop_ragdoll]]' or any other entity."
                warning = ["These are a special group of ragdolls that never disappear by default. To limit them or force them to disappear, use the [[game_ragdoll_manager]] entity."]
            }
            ClearFlags = {
                info = "'void ClearFlags()'"
                args = 0
                description = "Sets the player-related entity flags to 0 on an entity, clearing them."
            }
            ClearSolidFlags = {
                info = "'void ClearSolidFlags()'"
                args = 0
                description = "Sets ''Solid Flags'' to 0 on an entity, clearing them."
            }
            ConnectOutput = {
                info = "'void ConnectOutput(string ''output_name'', string ''function_name'')'"
                args = 2
                description = "Adds an I/O connection that will call the named function when the specified output fires."
                note = ["If you are trying to access 'activator' and 'caller' in the called function and it doesn't exist, this means the entity has no script scope. Use 'ValidateScriptScope' to fix this."]
            }
            Destroy = {
                info = "'void Destroy()'"
                args = 0
                description = "Removes the entity. Simply calls [[UTIL_Remove]]."
            }
            DisableDraw = {
                info = "'void DisableDraw()'"
                args = 0
                description = "Disable drawing and transmitting the entity to clients. ''(adds EF_NODRAW)''"
            }
            DisconnectOutput = {
                info = "'void DisconnectOutput(string ''output_name'', string ''function_name'')'"
                args = 2
                description = "Removes a connected script function from an I/O event."
            }
            DispatchSpawn = {
                info = "'void DispatchSpawn()'"
                args = 0
                description = ""
                note = ["Calling this on players will cause them to respawn. In {{css"]
            }
            EmitSound = {
                info = "'void EmitSound(string ''sound_name'')'"
                args = 1
                description = "Plays a sound from this entity. The sound must be precached first for it to play (using 'PrecacheSound' or 'PrecacheScriptSound')."
                warning = ["Looping sounds will not stop on the entity when it's destroyed and will persist forever! To workaround this, run 'StopSound' in the 'OnDestroy' callback."]
            }
            EnableDraw = {
                info = "'void EnableDraw()'"
                args = 0
                description = "Enable drawing and transmitting the entity to clients. ''(removes EF_NODRAW)''"
            }
            entindex = {
                info = "'int entindex()'"
                args = 0
                description = "Returns the entity index."
            }
            EyeAngles = {
                info = "'QAngle EyeAngles()'"
                args = 0
                description = "Returns the entity's eye angles. Acts like 'GetAbsAngles' if the entity does not support it."
            }
            EyePosition = {
                info = "'Vector EyePosition()'"
                args = 0
                description = "Get vector to eye position - absolute coords. Acts like 'GetOrigin' if the entity does not support it."
            }
            FirstMoveChild = {
                info = "'handle FirstMoveChild()'"
                args = 0
                description = "Returns the most-recent entity parented to this one."
                tip = ["Example usage: <source lang=js>for (local child = entity.FirstMoveChild(); child != null; child = child.NextMovePeer())</source>"]
            }
            GetAbsAngles = {
                info = "'QAngle GetAbsAngles()'"
                args = 0
                description = "Get the entity's pitch, yaw, and roll as '''QAngles'''."
            }
            GetAbsVelocity = {
                info = "'Vector GetAbsVelocity()'"
                args = 0
                description = "Returns the current absolute velocity of the entity."
            }
            GetAngularVelocity = {
                info = "'Vector GetAngularVelocity()'"
                args = 0
                description = "Get the local angular velocity - returns a '''Vector''' of pitch, yaw, and roll."
            }
            GetBaseVelocity = {
                info = "'Vector GetBaseVelocity()'"
                args = 0
                description = "Returns any constant velocity currently being imparted onto the entity. This includes being pushed by effects like {{ent|trigger_push}} and players standing on moving geometry like elevators. Should always returns a zero vector if the entity is not affected by any movement effects."
            }
            GetBoundingMaxs = {
                info = "'Vector GetBoundingMaxs()'"
                args = 0
                description = "Get a vector containing max bounds, centered on object."
            }
            GetBoundingMaxsOriented = {
                info = "'Vector GetBoundingMaxsOriented()'"
                args = 0
                description = "Get a vector containing max bounds, centered on object, taking the object's orientation into account."
                bug = ["hidetested=1|This does not transform the bounds correctly and in some cases the bounding box will not cover the whole entity. As a workaround, use the non-oriented bounds and perform an AABB transformation using a matrix constructed from the entity's origin and angles."]
            }
            GetBoundingMins = {
                info = "'Vector GetBoundingMins()'"
                args = 0
                description = "Get a vector containing min bounds, centered on object."
            }
            GetBoundingMinsOriented = {
                info = "'Vector GetBoundingMinsOriented()'"
                args = 0
                description = "Get a vector containing min bounds, centered on object, taking the object's orientation into account."
                bug = ["hidetested=1|This does not transform the bounds correctly and in some cases the bounding box will not cover the whole entity. As a workaround, use the non-oriented bounds and perform an AABB transformation using a matrix constructed from the entity's origin and angles."]
            }
            GetCenter = {
                info = "'Vector GetCenter()'"
                args = 0
                description = "Gets center point of the entity in world coordinates."
            }
            GetClassname = {
                info = "'string GetClassname()'"
                args = 0
                description = ""
            }
            GetCollisionGroup = {
                info = "'int GetCollisionGroup()'"
                args = 0
                description = "Gets the current collision group of the entity. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ECollisionGroup|Constants.ECollisionGroup]]"
            }
            GetEFlags = {
                info = "'int GetEFlags()'"
                args = 0
                description = "Get the entity's engine flags. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#FEntityEFlags|Constants.FEntityEFlags]]."
            }
            GetFlags = {
                info = "'int GetFlags()'"
                args = 0
                description = "Get the entity's flags. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#FPlayer|Constants.FPlayer]]."
                tip = ["Example usage: <source lang=js> if (entity.GetFlags() & Constants.FPlayer.FL_ONGROUND) { printl(\"Entity is on the ground!\") } </source>"]
            }
            GetEntityHandle = {
                info = "'ehandle GetEntityHandle()'"
                args = 0
                description = "Get the entity as an EHANDLE. {{deprecated|Leftover from earlier versions of VScript.}}"
            }
            GetEntityIndex = {
                info = "'int GetEntityIndex()'"
                args = 0
                description = ""
            }
            GetForwardVector = {
                info = "'Vector GetForwardVector()'"
                args = 0
                description = "Get the forward vector of the entity."
                note = ["If you intend to get a player's eye forward vector, use 'EyeAngles().Forward()' instead as it's more accurate."]
            }
            GetFriction = {
                info = "'float GetFriction()'"
                args = 0
                description = "Get PLAYER friction, ignored for objects."
            }
            GetGravity = {
                info = "'float GetGravity()'"
                args = 0
                description = ""
            }
            GetHealth = {
                info = "'int GetHealth()'"
                args = 0
                description = ""
            }
            GetLocalAngles = {
                info = "'QAngle GetLocalAngles()'"
                args = 0
                description = ""
            }
            GetLocalOrigin = {
                info = "'Vector GetLocalOrigin()'"
                args = 0
                description = ""
            }
            GetLocalVelocity = {
                info = "'Vector GetLocalVelocity()'"
                args = 0
                description = "Get Entity relative velocity."
            }
            GetMaxHealth = {
                info = "'int GetMaxHealth()'"
                args = 0
                description = ""
            }
            GetModelKeyValues = {
                info = "'CScriptKeyValues GetModelKeyValues()'"
                args = 0
                description = "Get a KeyValue class instance on this entity's model."
            }
            GetModelName = {
                info = "'string GetModelName()'"
                args = 0
                description = ""
                note = ["When you try to call this method on weapons the returned model would be a player hand model. For naturally spawned weapons you can receive the model index from 'm_iWorldModelIndex' netprop, however, artificially spawned weapons always have this netprop set to 0. Instead you can create a 'tf_wearable' with the same definition index and get it's model: {{ExpandBox|<source lang=\"js\"> function DefinitionIndexModel(index) { local wearable = Entities.CreateByClassname(\"tf_wearable\") NetProps.SetPropInt(wearable, \"m_AttributeManager.m_Item.m_iItemDefinitionIndex\", index) NetProps.SetPropBool(wearable, \"m_AttributeManager.m_Item.m_bInitialized\", true) NetProps.SetPropBool(wearable, \"m_bForcePurgeFixedupStrings\", true) wearable.DispatchSpawn() local model = wearable.GetModelName() wearable.Destroy() return model } </source>"]
            }
            GetMoveParent = {
                info = "'handle GetMoveParent()'"
                args = 0
                description = "If in hierarchy, retrieves the entity's parent."
            }
            GetMoveType = {
                info = "'int GetMoveType()'"
                args = 0
                description = ""
            }
            GetName = {
                info = "'string GetName()'"
                args = 0
                description = "Get entity's targetname."
            }
            GetOrigin = {
                info = "'Vector GetOrigin()'"
                args = 0
                description = "This is 'GetAbsOrigin' with a funny script name for some reason. Not changing it for legacy compat though."
            }
            GetOwner = {
                info = "'handle GetOwner()'"
                args = 0
                description = "Gets this entity's owner."
                note = ["This is a wrapper for 'm_hOwnerEntity' netprop. To get 'm_hOwner' you would need to use 'NetProps.GetPropEntity(entity, \"m_hOwner\")'."]
            }
            GetPhysAngularVelocity = {
                info = "'Vector GetPhysAngularVelocity()'"
                args = 0
                description = ""
            }
            GetPhysVelocity = {
                info = "'Vector GetPhysVelocity()'"
                args = 0
                description = ""
            }
            GetPreTemplateName = {
                info = "'string GetPreTemplateName()'"
                args = 0
                description = "Get the entity name stripped of template unique decoration."
            }
            GetRightVector = {
                info = "'Vector GetRightVector()'"
                args = 0
                description = "Get the right vector of the entity."
            }
            GetRootMoveParent = {
                info = "'handle GetRootMoveParent()'"
                args = 0
                description = "If in hierarchy, walks up the hierarchy to find the root parent."
            }
            GetScriptId = {
                info = "'string GetScriptId()'"
                args = 0
                description = "Retrieve the unique identifier used to refer to the entity within the scripting system."
            }
            GetScriptScope = {
                info = "'table GetScriptScope()'"
                args = 0
                description = "Retrieve the script-side data associated with an entity."
            }
            GetScriptThinkFunc = {
                info = "'string GetScriptThinkFunc()'"
                args = 0
                description = "Retrieve the name of the current script think func."
            }
            GetSolid = {
                info = "'int GetSolid()'"
                args = 0
                description = "See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ESolidType|ESolidType]]."
            }
            GetSoundDuration = {
                info = "'float GetSoundDuration(string ''sound_name'', string ''actor_model_name'')'"
                args = 2
                description = ""
                todo = ["Actor model name is likely a leftover from {{hl2|2"]
                warning = ["Does not work on dedicated servers as they do not have audio libraries built-in to load sounds."]
            }
            GetTeam = {
                info = "'int GetTeam()'"
                args = 0
                description = "See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]]."
            }
            GetUpVector = {
                info = "'Vector GetUpVector()'"
                args = 0
                description = "Get the up vector of the entity."
            }
            GetWaterLevel = {
                info = "'int GetWaterLevel()'"
                args = 0
                description = "This function tells you how much of the entity is underwater. It returns a value of 0 if not underwater, 1 if the feet are (touching water brush), 2 if the waist is (center of the hull of the entity), and 3 if the head is (eyes position)."
                note = ["Some entities might not return 1 despite touching water. In some cases you might get 0 and 3 only, or sometimes 0, 2 and 3."]
            }
            GetWaterType = {
                info = "'int GetWaterType()'"
                args = 0
                description = "It returns the type of water the entity is currently submerged in. 32 for water and 16 for slime."
            }
            IsAlive = {
                info = "'bool IsAlive()'"
                args = 0
                description = "Am I alive?"
            }
            IsEFlagSet = {
                info = "'bool IsEFlagSet([[Team_Fortress_2/Scripting/Script_Functions/Constants#FEntityEFlags|FEntityEFlags]] ''flag'')'"
                args = 1
                description = ""
            }
            IsPlayer = {
                info = "'bool IsPlayer()'"
                args = 0
                description = "Checks whether the entity is a player or not."
            }
            IsSolid = {
                info = "'bool IsSolid()'"
                args = 0
                description = ""
            }
            IsSolidFlagSet = {
                info = "'bool IsSolidFlagSet([[Team_Fortress_2/Scripting/Script_Functions/Constants#FSolid|FSolid]] ''flag'')'"
                args = 1
                description = ""
            }
            IsValid = {
                info = "'bool IsValid()'"
                args = 0
                description = "Checks whether the entity still exists. Useful when storing entity handles and needing to check if the entity was not deleted."
                note = ["This function is never necessary to call on handles returned from built-in script functions, as they are guaranteed to be valid or 'null'."]
            }
            KeyValueFromFloat = {
                info = "'bool KeyValueFromFloat(string ''key'', float ''value'')'"
                args = 2
                description = "Executes KeyValue with a float."
                warning = ["Does not update the internal network state of the entity, which can result in any desired visual changes being delayed for clients if used after spawning. [[#CNetPropManager|Netprops ↓]] can be used instead which correctly updates the networking state and results in an immediate update. An exception is the 'origin' keyvalue, which does update network state immediately."]
            }
            KeyValueFromInt = {
                info = "'bool KeyValueFromInt(string ''key'', int ''value'')'"
                args = 2
                description = "Executes KeyValue with an int."
                warning = ["See above."]
            }
            KeyValueFromString = {
                info = "'bool KeyValueFromString(string ''key'', string ''value'')'"
                args = 2
                description = "Executes KeyValue with a string."
                warning = ["See above."]
            }
            KeyValueFromVector = {
                info = "'bool KeyValueFromVector(string ''key'', Vector ''value'')'"
                args = 2
                description = "Executes KeyValue with a vector."
                warning = ["See above."]
            }
            Kill = {
                info = "'void Kill()'"
                args = 0
                description = "Removes the entity. Equivalent of firing the 'Kill' I/O input, but instantaneous."
                warning = ["This clears the owner entity ('m_hOwnerEntity' netprop) before removing, this may cause unexpected problems with entities that rely on cleaning up data related to their owner, such as Medigun healing targets. In those cases, use 'Destroy' instead."]
            }
            LocalEyeAngles = {
                info = "'QAngle LocalEyeAngles()'"
                args = 0
                description = "Returns the entity's local eye angles."
            }
            NextMovePeer = {
                info = "'handle NextMovePeer()'"
                args = 0
                description = "Returns the next entity parented ''with'' the entity. Intended for iteration use with 'FirstMoveChild()'."
            }
            PrecacheModel = {
                info = "'void PrecacheModel(string ''model_name'')'"
                args = 1
                description = "Precache a model ('.mdl') or sprite ('.vmt'). The extension must be specified."
                note = [
                    "This has no return, unlike the global 'PrecacheModel' function. Use the latter if you need the model index."
                    "Does not precache gibs. See 'PrecacheEntityFromTable' instead."
                ]
            }
            PrecacheScriptSound = {
                info = "'void PrecacheScriptSound(string ''sound_script'')'"
                args = 1
                description = "Precache a sound script. Same as 'PrecacheSoundScript'."
            }
            PrecacheSoundScript = {
                info = "'void PrecacheSoundScript(string ''sound_script'')'"
                args = 1
                description = "Precache a sound script. Same as 'PrecacheScriptSound'."
            }
            RemoveEFlags = {
                info = "'void RemoveEFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FEntityEFlags|FEntityEFlags]] ''flags'')'"
                args = 1
                description = ""
            }
            RemoveFlag = {
                info = "'void RemoveFlag([[Team_Fortress_2/Scripting/Script_Functions/Constants#FPlayer|FPlayer]] ''flags'')'"
                args = 1
                description = ""
            }
            RemoveSolidFlags = {
                info = "'void RemoveSolidFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FSolid|FSolid]] ''flags'')'"
                args = 1
                description = ""
            }
            SetAbsAngles = {
                info = "'void SetAbsAngles(QAngle ''angles'')'"
                args = 1
                description = "Set entity pitch, yaw, roll as QAngles. Does not work on players, use 'SnapEyeAngles' instead."
            }
            SetAbsVelocity = {
                info = "'void SetAbsVelocity(Vector ''velocity'')'"
                args = 1
                description = "Sets the current absolute velocity of the entity. Does nothing on [[VPhysics]] objects (such as 'prop_physics'). For those, use 'SetPhysVelocity' instead."
            }
            SetAbsOrigin = {
                info = "'void SetAbsOrigin(Vector ''origin'')'"
                args = 1
                description = "Sets the absolute origin of the entity."
                note = ["On some entities, this won't interpolate positions and therefore moving entities might look jittery. In those cases, use 'KeyValueFromVector(\"origin\", pos)' instead."]
            }
            SetAngularVelocity = {
                info = "'void SetAngularVelocity(float ''pitch'', float ''yaw'', float ''roll'')'"
                args = 3
                description = "Set the local angular velocity."
            }
            SetCollisionGroup = {
                info = "'void SetCollisionGroup([[Team_Fortress_2/Scripting/Script_Functions/Constants#ECollisionGroup|ECollisionGroup]] ''group'')'"
                args = 1
                description = "Set the current collision group of the entity."
            }
            SetDrawEnabled = {
                info = "'void SetDrawEnabled(bool ''toggle'')'"
                args = 1
                description = "Enables drawing if you pass true, disables drawing if you pass false."
            }
            SetEFlags = {
                info = "'void SetEFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FEntityEFlags|FEntityEFlags]] ''flags'')'"
                args = 1
                description = ""
            }
            SetForwardVector = {
                info = "'void SetForwardVector(Vector ''forward'')'"
                args = 1
                description = ""
                note = [
                    "If used on the players the resulting orientation will not be normalized which can lead to console warnings in some cases. To avoid this convert the vector to an angle with the following function and pass the result into 'SnapEyeAngles': {{ExpandBox|<source lang=js> function VectorAngles(forward) { local yaw, pitch if (forward.y == 0.0 && forward.x == 0.0) { yaw = 0.0 if (forward.z > 0.0) pitch = 270.0 else pitch = 90.0 } else { yaw = (atan2(forward.y, forward.x) * 180.0 / Constants.Math.Pi) if (yaw < 0.0) yaw += 360.0 pitch = (atan2(-forward.z, forward.Length2D()) * 180.0 / Constants.Math.Pi) if (pitch < 0.0) pitch += 360.0 } return QAngle(pitch, yaw, 0.0) } </source>"
                    "If used on the players consider the note on 'SnapEyeAngles' in [[#CBasePlayer|CBasePlayer ↓]]."
                ]
            }
            SetFriction = {
                info = "'void SetFriction(float ''friction'')'"
                args = 1
                description = ""
            }
            SetGravity = {
                info = "'void SetGravity(float ''gravity'')'"
                args = 1
                description = "Sets a multiplier for gravity. 1 is default gravity."
                note = ["0 gravity will not work. Instead, set it to something like '0.000001' as a workaround."]
            }
            SetHealth = {
                info = "'void SetHealth(int ''health'')'"
                args = 1
                description = ""
            }
            SetLocalAngles = {
                info = "'void SetLocalAngles(QAngle ''angles'')'"
                args = 1
                description = ""
            }
            SetLocalOrigin = {
                info = "'void SetLocalOrigin(Vector ''origin'')'"
                args = 1
                description = ""
            }
            SetMaxHealth = {
                info = "'void SetMaxHealth(int ''health'')'"
                args = 1
                description = "Sets the maximum health this entity can have. Does not update the current health, so 'SetHealth' should be used afterwards."
                note = ["Does nothing on players. Add the 'max health additive bonus' attribute via 'AddCustomAttribute' instead."]
            }
            SetModel = {
                info = "'void SetModel(string ''model_name'')'"
                args = 1
                description = "Set a model for this entity."
                note = ["Does nothing on players. Use 'SetCustomModel' in that case."]
                warning = ["Make sure the model was already precached before using this function or otherwise the game will crash! Alternatively, 'SetModelSimple' will precache the entity for you."]
            }
            SetMoveType = {
                info = "'void SetMoveType([[Team_Fortress_2/Scripting/Script_Functions/Constants#EMoveType|EMoveType]] ''movetype'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#EMoveCollide|EMoveCollide]] ''movecollide'')'"
                args = 2
                description = ""
            }
            SetOwner = {
                info = "'void SetOwner(handle ''entity'')'"
                args = 1
                description = "Sets this entity's owner."
                note = ["This is a wrapper for 'm_hOwnerEntity' netprop. To set 'm_hOwner' you would need to use 'NetProps.SetPropEntity(entity, \"m_hOwner\", owner)'."]
            }
            SetPhysAngularVelocity = {
                info = "'void SetPhysAngularVelocity(Vector ''angular_velocity'')'"
                args = 1
                description = ""
            }
            SetPhysVelocity = {
                info = "'void SetPhysVelocity(Vector ''velocity'')'"
                args = 1
                description = ""
            }
            SetSize = {
                info = "'void SetSize(Vector ''mins'', Vector ''maxs'')'"
                args = 2
                description = "Sets the bounding box's scale for this entity."
                warning = ["If any component of mins/maxs is backwards (i.e. mins.x > maxs.x), the engine will exit with a fatal error."]
            }
            SetSolid = {
                info = "'void SetSolid([[Team_Fortress_2/Scripting/Script_Functions/Constants#ESolidType|ESolidType]] ''solid'')'"
                args = 1
                description = ""
            }
            SetSolidFlags = {
                info = "'void SetSolidFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FSolid|FSolid]] ''flags'')'"
                args = 1
                description = ""
            }
            SetTeam = {
                info = "'void SetTeam([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Sets entity team."
                note = ["Use 'ForceChangeTeam' on players instead."]
            }
            SetWaterLevel = {
                info = "'void SetWaterLevel(int ''water_level'')'"
                args = 1
                description = "This sets how much of the entity is underwater. Setting it to 0 means it is not underwater, 1 if the feet are (touching water brush), 2 if the waist is (center of the hull of the entity), and 3 if the head is (eyes position)."
            }
            SetWaterType = {
                info = "'void SetWaterType(int ''water_type'')'"
                args = 1
                description = "Set the type of water the entity is currently submerged in. Generic values to use are 32 for water and 16 for slime."
            }
            StopSound = {
                info = "'void StopSound(string ''sound_name'')'"
                args = 1
                description = "Stops a sound on this entity."
            }
            TakeDamage = {
                info = "'void TakeDamage(float ''damage'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#FDmgType|FDmgType]] ''damage_type'', handle ''attacker'')'"
                args = 3
                description = "Deals damage to the entity."
            }
            TakeDamageEx = {
                info = "'void TakeDamageEx(handle ''inflictor'', handle ''attacker'', handle ''weapon'', Vector ''damage_force'', Vector ''damage_position'', float ''damage'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#FDmgType|FDmgType]] ''damage_type'')'"
                args = 7
                description = "Extended version of 'TakeDamage'."
                note = ["If ''damage_force'' is Vector(0, 0, 0), the game will automatically calculate it from ''damage_position'' and ''damage''. However, specifying a custom damage force requires a really, really big value to have visible effect (in the hundreds of thousands)."]
            }
            TakeDamageCustom = {
                info = "'void TakeDamageCustom(handle ''inflictor'', handle ''attacker'', handle ''weapon'', Vector ''damage_force'', Vector ''damage_position'', float ''damage'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#FDmgType|FDmgType]] ''damage_type'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFDmgCustom|ETFDmgCustom]] ''custom_damage_type'')'"
                args = 8
                description = "Extended version of 'TakeDamageEx' that can apply a custom damage type."
            }
            Teleport = {
                info = "'void Teleport(bool ''use_origin'', Vector ''origin'', bool ''use_angles'', QAngle ''angles'', bool ''use_velocity'', Vector ''velocity'')'"
                args = 6
                description = "Teleports this entity. For this function, set the bools to false if you want that entity's property unchanged. (do not use null arguments!)"
            }
            TerminateScriptScope = {
                info = "'void TerminateScriptScope()'"
                args = 0
                description = "Clear the current script scope for this entity."
            }
            ToggleFlag = {
                info = "'void ToggleFlag([[Team_Fortress_2/Scripting/Script_Functions/Constants#FPlayer|FPlayer]] ''flags'')'"
                args = 1
                description = ""
            }
            ValidateScriptScope = {
                info = "'bool ValidateScriptScope()'"
                args = 0
                description = "Create a script scope for an entity if it doesn't already exist. The return value is always true, unless the script VM is disabled in launch options."
                note = ["This is unnecessary to run on entities that have an entity script assigned. Entity scripts will already create the script scope themselves."]
                tip = ["On players, this only needs to be called once. Script scopes remain permanent on players until their entity is removed, i.e. disconnected. The best place to call this is in the 'player_spawn' event when 'params.team' equals 0 (unassigned). The event is always fired once for team unassigned when the player entity spawns. Similarly, for engineer buildings, this function can also be called once. The 'player_builtobject' is fired when an engineer building is created (or re-placed after moving, but this shouldn't matter)."]
            }
            const_entity = {
                info = "'handle'"
                args = 0
                description = "The entity which took damage."
            }
            inflictor = {
                info = "'handle'"
                args = 0
                description = "The entity which dealt the damage, can be null."
            }
            weapon = {
                info = "'handle'"
                args = 0
                description = "The weapon which dealt the damage, can be null."
            }
            attacker = {
                info = "'handle'"
                args = 0
                description = "The owner of the damage, can be null."
            }
            damage = {
                info = "'float'"
                args = 0
                description = "Damage amount."
            }
            max_damage = {
                info = "'float'"
                args = 0
                description = "Damage cap."
            }
            damage_bonus = {
                info = "'float'"
                args = 0
                description = "Additional damage (e.g. from crits)."
                warning = ["Always 0 because this hook is run before this is calculated."]
            }
            damage_bonus_provider = {
                info = "'handle'"
                args = 0
                description = "Owner of the damage bonus."
                warning = ["Always 0 because this hook is run before this is calculated."]
            }
            const_base_damage = {
                info = "'float'"
                args = 0
                description = "Base damage."
            }
            damage_force = {
                info = "'Vector'"
                args = 0
                description = "Damage force."
            }
            damage_for_force_calc = {
                info = "'float'"
                args = 0
                description = ""
                bug = ["hidetested=1|This value does not seem to do anything."]
            }
            damage_position = {
                info = "'Vector'"
                args = 0
                description = "World position of where the damage came from. E.g. end position of a bullet or a rocket."
            }
            reported_position = {
                info = "'Vector'"
                args = 0
                description = "World position of where the damage supposedly came from."
            }
            damage_type = {
                info = "'int'"
                args = 0
                description = "Combination of damage types. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#FDmgType|Constants.FDmgType]]"
            }
            damage_custom = {
                info = "'int'"
                args = 0
                description = ""
                bug = ["hidetested=1|Because of a code oversight, this value is read-only. Use 'damage_stats' instead which can be read and written."]
            }
            damage_stats = {
                info = "'int'"
                args = 0
                description = "Special damage type. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFDmgCustom|Constants.ETFDmgCustom]]. Unlike 'damage_type', only one custom damage type can be set."
            }
            force_friendly_fire = {
                info = "'bool'"
                args = 0
                description = "If true, force the damage to friendlyfire, regardless of this entity's and attacker's team."
                note = ["Hitscan/melee will not run OnTakeDamage unless the 'mp_friendlyfire' convar is set to 1."]
            }
            ammo_type = {
                info = "'int'"
                args = 0
                description = "Unused."
            }
            player_penetration_count = {
                info = "'int'"
                args = 0
                description = "How many players the damage has penetrated so far."
            }
            damaged_other_players = {
                info = "'int'"
                args = 0
                description = "How many players other than the attacker has the damage been applied to. Used for rocket jump damage reduction."
            }
            crit_type = {
                info = "'int'"
                args = 0
                description = ""
                warning = ["Always 0 because this hook is run before this is set. You can check for 'DMG_ACID' in 'damage_type', which is set when the shot will be critical, however, it doesn't show ordinary hits which would be converted to critical ones like Neon Annihilator hitting a soaked target or a Bushwacka hitting with a mini-crit. Alternative would be to check whether the damage is crit in 'player_hurt' event, which also works for mini-crits as well, the downside is that this event happens only after the damage has been dealt so no changes inside the hook are possible. If you want to force the damage to be critical you need to set 'DMG_ACID' to be included in 'damage_type': <source lang=\"js\"> params.damage_type = params.damage_type | Constants.FDmgType.DMG_ACID </source> For players, if you want to force the damage to be a mini-crit you can add a mini-crit cond to the attacker inside this hook and remove it in 'player_hurt' or 'npc_hurt' respective events afterwards. Example: {{ExpandBox|<source lang=js> function RemoveBuff(player) { local scope = player.GetScriptScope() if (\"remove_buff\" in scope && scope.remove_buff) { player.RemoveCond(Constants.ETFCond.TF_COND_OFFENSEBUFF) scope.remove_buff = false } } events <- { function OnScriptHook_OnTakeDamage(params) { local attacker = params.attacker if (!attacker) return local scope = attacker.GetScriptScope() if (!(\"force_minicrit\" in scope) || !scope.force_minicrit) return if (attacker.InCond(Constants.ETFCond.TF_COND_OFFENSEBUFF)) return if (params.const_entity.IsPlayer() || params.const_entity instanceof NextBotCombatCharacter) { attacker.AddCond(Constants.ETFCond.TF_COND_OFFENSEBUFF) scope.remove_buff = true } } function OnGameEvent_player_hurt(params) { local attacker = GetPlayerFromUserID(params.attacker) if (!attacker) return RemoveBuff(attacker) } function OnGameEvent_npc_hurt(params) { local attacker = GetPlayerFromUserID(params.attacker_player) if (!attacker) return RemoveBuff(attacker) } } __CollectGameEventCallbacks(events) local player = GetListenServerHost() player.ValidateScriptScope() local scope = player.GetScriptScope() scope.force_minicrit <- true scope.remove_buff <- false </source> {{bug|hidetested=1|Only mini-crits if the owner was alive during the hit, e.g. firing a rocket and dying before the rocket lands will not result in a mini-crit. When hitting the players you can apply TF_COND_MARKEDFORDEATH on them instead which would fix this issue, however, any hits to the victim from other sources that were dealt in the same tick as your intended mini-crit hit will also turn into the mini-crits.The addconds cannot be applied on nextbots making this solution completely irrelevant to them."]
                note = ["Setting this to 1 makes the damage act as a mini-crit, while producing full crit sounds and visuals, this can be used for cases where the attacker is not a player since only physical aspect of the damage would matter. Setting it to 2 has no effect."]
            }
            early_out = {
                info = "'bool'"
                args = 0
                description = "If set to true by the script, the game's damage routine will not run and it will simply return the currently set damage."
            }
        }
        CBaseAnimating = {
            DispatchAnimEvents = {
                info = "'void DispatchAnimEvents(CBaseAnimating ''entity'')'"
                args = 1
                description = "Dispatch animation events to a CBaseAnimating entity."
            }
            FindBodygroupByName = {
                info = "'int FindBodygroupByName(string ''name'')'"
                args = 1
                description = "Find a bodygroup ID by name. Returns -1 if the bodygroup does not exist."
            }
            GetAttachmentAngles = {
                info = "'QAngle GetAttachmentAngles(int ''id'')'"
                args = 1
                description = "Get an attachment's angles as a QAngle, by ID."
            }
            GetAttachmentBone = {
                info = "'int GetAttachmentBone(int ''id'')'"
                args = 1
                description = "Get an attachment's parent bone index by ID."
            }
            GetAttachmentOrigin = {
                info = "'Vector GetAttachmentOrigin(int ''id'')'"
                args = 1
                description = "Get an attachment's origin as a Vector, by ID."
            }
            GetBodygroup = {
                info = "'int GetBodygroup(int ''id'')'"
                args = 1
                description = "Get the bodygroup value by bodygroup ID."
            }
            GetBodygroupName = {
                info = "'string GetBodygroupName(int ''id'')'"
                args = 1
                description = "Get the bodygroup's name by ID."
            }
            GetBodygroupPartName = {
                info = "'string GetBodygroupPartName(int ''group'', int ''part'')'"
                args = 2
                description = "Get the bodygroup's name by group and part."
            }
            GetBoneAngles = {
                info = "'QAngle GetBoneAngles(int ''id'')'"
                args = 1
                description = "Get the bone's angles as a QAngle, by ID."
                warning = ["For performance, bone transforms are cached by the game. The cache is updated once per frame. Setting new sequences, cycles etc may cause this to access stale bone data. If this is a problem, then call 'SetModelSimple' first, which will update the bone cache."]
            }
            GetBoneOrigin = {
                info = "'Vector GetBoneOrigin(int ''id'')'"
                args = 1
                description = "Get the bone's origin Vector by ID."
                warning = ["See above."]
            }
            GetCycle = {
                info = "'float GetCycle()'"
                args = 0
                description = "Gets the model's current animation cycle rate. Ranges from 0.0 to 1.0."
            }
            GetModelScale = {
                info = "'float GetModelScale()'"
                args = 0
                description = "Get the model's scale."
            }
            GetPlaybackRate = {
                info = "'float GetPlaybackRate()'"
                args = 0
                description = "Get the current animation's playback rate."
            }
            GetSequence = {
                info = "'int GetSequence()'"
                args = 0
                description = "Get the current-playing sequence's ID."
            }
            GetSequenceActivityName = {
                info = "'string GetSequenceActivityName(int ''id'')'"
                args = 1
                description = "Get the activity name for a sequence by sequence ID."
            }
            GetSequenceDuration = {
                info = "'float GetSequenceDuration(int ''id'')'"
                args = 1
                description = "Get a sequence duration in seconds by sequence ID."
            }
            GetSequenceName = {
                info = "'string GetSequenceName(int ''id'')'"
                args = 1
                description = "Get a sequence name by sequence ID. Returns \"Not Found!\" if ID is -1, \"Unknown\" if the sequence doesn't exist or \"No model!\" if no model is assigned."
            }
            GetSkin = {
                info = "'int GetSkin()'"
                args = 0
                description = "Gets the current skin index."
            }
            IsSequenceFinished = {
                info = "'bool IsSequenceFinished()'"
                args = 0
                description = "Ask whether the main sequence is done playing."
            }
            LookupActivity = {
                info = "'int LookupActivity(string ''activity'')'"
                args = 1
                description = "Get the named activity index. Returns -1 if the activity does not exist."
            }
            LookupAttachment = {
                info = "'int LookupAttachment(string ''name'')'"
                args = 1
                description = "Get the named attachment index. Returns 0 if the attachment does not exist."
            }
            LookupBone = {
                info = "'int LookupBone(string ''bone'')'"
                args = 1
                description = "Get the named bone index. Returns -1 if the bone does not exist."
            }
            LookupPoseParameter = {
                info = "'int LookupPoseParameter(string ''name'')'"
                args = 1
                description = "Gets the pose parameter's index. Returns -1 if the pose parameter does not exist."
            }
            LookupSequence = {
                info = "'int LookupSequence(string ''name'')'"
                args = 1
                description = "Looks up a sequence by names of sequences or activities. Returns -1 if the sequence does not exist."
            }
            ResetSequence = {
                info = "'void ResetSequence(int ''id'')'"
                args = 1
                description = "Reset a sequence by sequence ID. If the ID is different than the current sequence, switch to the new sequence."
            }
            SetBodygroup = {
                info = "'void SetBodygroup(int ''id'', int ''value'')'"
                args = 2
                description = "Set the bodygroup by ID."
            }
            SetCycle = {
                info = "'void SetCycle(float ''cycle'')'"
                args = 1
                description = "Sets the model's current animation cycle from 0 to 1."
                note = ["This only works if the entity has 'm_bClientSideAnimation' set to false. Some entities such as [[prop_dynamic]] have this true by default and therefore SetCycle will visually not do anything until that netprop is turned off."]
            }
            SetModelSimple = {
                info = "'void SetModelSimple(string ''model_name'')'"
                args = 1
                description = "Set a model for this entity. Matches easier behaviour of the SetModel input, automatically precaches, maintains sequence/cycle if possible. Also clears the bone cache."
                note = ["Does nothing on players. Use 'SetCustomModel' in that case."]
            }
            SetModelScale = {
                info = "'void SetModelScale(float ''scale'', float ''change_duration'')'"
                args = 2
                description = "Changes a model's scale over time. Set the change duration to 0.0 to change the scale instantly."
            }
            SetPlaybackRate = {
                info = "'void SetPlaybackRate(float ''rate'')'"
                args = 1
                description = "Set the current animation's playback rate."
            }
            SetPoseParameter = {
                info = "'float SetPoseParameter(int ''id'', float ''value'')'"
                args = 2
                description = "Sets a pose parameter value. Returns the effective value after clamping or looping."
                note = ["Does nothing on players. Pose parameters aren't networked on players."]
                bug = ["hidetested=1|[[prop_dynamic]] will have visual glitches with server-sided pose parameters. Use [[point_posecontroller]], or another entity like [[base_boss]] or [[funCBaseFlex]]."]
            }
            SetSequence = {
                info = "'void SetSequence(int ''id'')'"
                args = 1
                description = "Plays a sequence by sequence ID."
                warning = ["This can cause animation stutters when transitioning between sequences, or sequences to not be set at all on some entities (such as [[obj_sentrygun]]). Using 'ResetSequence' instead will prevent this. Only tested on [[base_boss]]."]
                note = ["Does nothing on players. Players use a different animation system."]
            }
            SetSkin = {
                info = "'void SetSkin(int ''index'')'"
                args = 1
                description = "Sets the model's skin."
            }
            StopAnimation = {
                info = "'void StopAnimation()'"
                args = 0
                description = "Stop the current animation (same as SetPlaybackRate 0.0)."
            }
            StudioFrameAdvance = {
                info = "'void StudioFrameAdvance()'"
                args = 0
                description = "Advance animation frame to some time in the future with an automatically calculated interval."
            }
            StudioFrameAdvanceManual = {
                info = "'void StudioFrameAdvanceManual(float ''dt'')'"
                args = 1
                description = "Advance animation frame to some time in the future with a manual interval."
            }
        }
        CBaseCombatWeapon = {
            CanBeSelected = {
                info = "'bool CanBeSelected()'"
                args = 0
                description = "Can this weapon be selected."
            }
            Clip1 = {
                info = "'int Clip1()'"
                args = 0
                description = "Current ammo in clip1."
            }
            Clip2 = {
                info = "'int Clip2()'"
                args = 0
                description = "Current ammo in clip2."
            }
            GetDefaultClip1 = {
                info = "'int GetDefaultClip1()'"
                args = 0
                description = "Default size of clip1."
            }
            GetDefaultClip2 = {
                info = "'int GetDefaultClip2()'"
                args = 0
                description = "Default size of clip2."
            }
            GetMaxClip1 = {
                info = "'int GetMaxClip1()'"
                args = 0
                description = "Max size of clip1."
            }
            GetMaxClip2 = {
                info = "'int GetMaxClip2()'"
                args = 0
                description = "Max size of clip2."
            }
            GetName = {
                info = "'string GetName()'"
                args = 0
                description = "Gets the weapon's internal name (not the targetname!)"
                warning = ["This conflicts with CBaseEntity's 'GetName' function. To get the targetname of the weapon, call it like this instead 'CBaseEntity.GetName.call(weapon)'. Alternatively you can fetch the property directly 'NetProps.GetPropString(weapon, \"m_iName\")'."]
            }
            GetPosition = {
                info = "'int GetPosition()'"
                args = 0
                description = "Gets the weapon's current position."
            }
            GetPrimaryAmmoCount = {
                info = "'int GetPrimaryAmmoCount()'"
                args = 0
                description = "Current primary ammo count if no clip is used or to give a player if they pick up this weapon legacy style (not TF)."
            }
            GetPrimaryAmmoType = {
                info = "'int GetPrimaryAmmoType()'"
                args = 0
                description = "Returns the primary ammo type."
            }
            GetPrintName = {
                info = "'string GetPrintName()'"
                args = 0
                description = "Gets the weapon's print name."
            }
            GetSecondaryAmmoCount = {
                info = "'int GetSecondaryAmmoCount()'"
                args = 0
                description = "Current secondary ammo count if no clip is used or to give a player if they pick up this weapon legacy style (not TF)."
            }
            GetSecondaryAmmoType = {
                info = "'int GetSecondaryAmmoType()'"
                args = 0
                description = "Returns the secondary ammo type."
            }
            GetSlot = {
                info = "'int GetSlot()'"
                args = 0
                description = "Gets the weapon's current slot."
            }
            GetSubType = {
                info = "'int GetSubType()'"
                args = 0
                description = "Get the weapon subtype."
            }
            GetWeaponFlags = {
                info = "'int GetWeaponFlags()'"
                args = 0
                description = "Get the weapon flags."
            }
            GetWeight = {
                info = "'int GetWeight()'"
                args = 0
                description = "Get the weapon weighting/importance."
            }
            HasAnyAmmo = {
                info = "'bool HasAnyAmmo()'"
                args = 0
                description = "Do we have any ammo?"
            }
            HasPrimaryAmmo = {
                info = "'bool HasPrimaryAmmo()'"
                args = 0
                description = "Do we have any primary ammo?"
            }
            HasSecondaryAmmo = {
                info = "'bool HasSecondaryAmmo()'"
                args = 0
                description = "Do we have any secondary ammo?"
            }
            IsAllowedToSwitch = {
                info = "'bool IsAllowedToSwitch()'"
                args = 0
                description = "Are we allowed to switch to this weapon?"
            }
            IsMeleeWeapon = {
                info = "'bool IsMeleeWeapon()'"
                args = 0
                description = "Returns whether this is a melee weapon."
                note = ["'tf_weapon_buff_item' (entity for Soldier's banner items), are considered melee in the code."]
            }
            PrimaryAttack = {
                info = "'void PrimaryAttack()'"
                args = 0
                description = "Force a primary attack."
                tip = ["This allows arbitrarily firing weapons that do not actually belong to any player. This can be useful for creating entities that might not fully work on their own, for example rockets. Most weapons will work as long as the 'm_hOwner' netprop on the weapon is set to an existing player. Weapons spawned manually might also need 'SetClip(-1)', and 'm_flNextPrimaryAttack' (or 'm_flSecondaryPrimaryAttack') set to 0 before calling this function to always allow firing without delays."]
                warning = [
                    "Hitscan and melee weapons require [[lag compensation]] information to be present, or the game will crash! Calling this from a player's think function or OnTakeDamage hook (whose source is a player's hitscan weapon) is sufficient. Alternatively, lag compensation can be temporarily disabled which allows calling this function from anywhere, with the side effect of poor hit registration for high latency players. This can be achieved by setting the 'm_bLagCompensation' [[#CNetPropManager|netprop ↓]] on the player to to false, calling this function, and reverting it back to true."
                    "This will play the weapon's fire sound to everyone except the owner. If the sound is desired, the sound can be played to the owner exclusively via 'EmitSoundEx'. If the sound is not desired, it can be stopped by calling 'StopSound' after this function."
                ]
            }
            SecondaryAttack = {
                info = "'void SecondaryAttack()'"
                args = 0
                description = "Force a secondary attack."
                warning = ["See above."]
            }
            SetClip1 = {
                info = "'void SetClip1(int ''amount'')'"
                args = 1
                description = "Set current ammo in clip1."
            }
            SetClip2 = {
                info = "'void SetClip2(int ''amount'')'"
                args = 1
                description = "Set current ammo in clip2."
            }
            SetCustomViewModel = {
                info = "'void SetCustomViewModel(string ''model_name'')'"
                args = 1
                description = "Sets a custom view model for this weapon by model name."
            }
            SetCustomViewModelModelIndex = {
                info = "'void SetCustomViewModelModelIndex(int ''model_index'')'"
                args = 1
                description = "Sets a custom view model for this weapon by modelindex."
            }
            SetSubType = {
                info = "'void SetSubType(int ''subtype'')'"
                args = 1
                description = "Set the weapon subtype."
            }
            UsesClipsForAmmo1 = {
                info = "'bool UsesClipsForAmmo1()'"
                args = 0
                description = "Do we use clips for ammo 1?"
            }
            UsesClipsForAmmo2 = {
                info = "'bool UsesClipsForAmmo2()'"
                args = 0
                description = "Do we use clips for ammo 2?"
            }
            UsesPrimaryAmmo = {
                info = "'bool UsesPrimaryAmmo()'"
                args = 0
                description = "Do we use primary ammo?"
            }
            UsesSecondaryAmmo = {
                info = "'bool UsesSecondaryAmmo()'"
                args = 0
                description = "Do we use secondary ammo?"
            }
            VisibleInWeaponSelection = {
                info = "'bool VisibleInWeaponSelection()'"
                args = 0
                description = "Is this weapon visible in weapon selection?"
            }
        }
        CBaseFlex = {
            PlayScene = {
                info = "'float PlayScene(string ''scene_file'', float ''delay'')'"
                args = 2
                description = "Play the specified .vcd file, causing the related characters to speak and subtitles to play."
                tip = ["Open 'tf2_misc_dir.vpk' and browse the files in 'scripts/talker/...' to find .vcd files. Alternatively, use the 'rr_debugresponses 1' command with 'developer 1' to find .vcds from in-game voicelines."]
            }
        }
        CBaseCombatCharacter = {
            GetLastKnownArea = {
                info = "'handle GetLastKnownArea()'"
                args = 0
                description = "Return the last nav area occupied, NULL if unknown. See [[#CTFNavArea|CTFNavArea ↓]]."
            }
        }
        CBasePlayer = {
            GetForceLocalDraw = {
                info = "'bool GetForceLocalDraw()'"
                args = 0
                description = "Whether the player is being forced by SetForceLocalDraw to be drawn."
            }
            GetPlayerMaxs = {
                info = "'Vector GetPlayerMaxs()'"
                args = 0
                description = "Get a vector containing max bounds of the player in local space. The player's model scale will affect the result."
            }
            GetPlayerMins = {
                info = "'Vector GetPlayerMins()'"
                args = 0
                description = "Get a vector containing min bounds of the player in local space. The player's model scale will affect the result."
            }
            GetScriptOverlayMaterial = {
                info = "'string GetScriptOverlayMaterial()'"
                args = 0
                description = "Gets the current overlay material set by SetScriptOverlayMaterial."
            }
            IsNoclipping = {
                info = "'bool IsNoclipping()'"
                args = 0
                description = "Returns true if the player is in noclip mode."
            }
            SetForceLocalDraw = {
                info = "'void SetForceLocalDraw(bool ''toggle'')'"
                args = 1
                description = "Forces the player to be drawn as if they were in thirdperson."
            }
            SetScriptOverlayMaterial = {
                info = "'void SetScriptOverlayMaterial(string ''material'')'"
                args = 1
                description = "Sets the overlay material that can't be overriden by other overlays. E.g. Jarate."
            }
            SnapEyeAngles = {
                info = "'void SnapEyeAngles(QAngle ''angles'')'"
                args = 1
                description = ""
                note = ["Do not use this if you are setting the angles temporarily and reverting it in the same frame (for example if firing projectiles at a specific angle). This will cause camera jitter in multiplayer. Instead, modify the 'pl.v_angle' netprop and then revert that (which is what the game reads for eye angles internally). Example: {{ExpandBox|<source lang=js> local eye_angles = player.LocalEyeAngles() NetProps.SetPropVector(player, \"pl.v_angle\", angles + Vector()) NetProps.SetPropEntity(flaregun, \"m_hOwner\", player) NetProps.SetPropFloat(flaregun, \"m_flNextPrimaryAttack\", 0) flaregun.PrimaryAttack() NetProps.SetPropVector(player, \"pl.v_angle\", eye_angles + Vector()) </source>"]
            }
            ViewPunch = {
                info = "'void ViewPunch(QAngle ''angle_offset'')'"
                args = 1
                description = "Ow! Punches the player's view."
            }
            ViewPunchReset = {
                info = "'void ViewPunchReset(float ''tolerance'')'"
                args = 1
                description = "Reset's the player's view punch if the offset stays below the given tolerance."
            }
        }
        CEconEntity = {
            AddAttribute = {
                info = "'void AddAttribute(string ''name'', float ''value'', float ''duration'')'"
                args = 3
                description = "Add an attribute to the entity. <s>Set duration to 0 or lower for the attribute to be applied forever</s> See the bug below. The attribute must be one that exists in the game, invalid ones will not be added."
                note = ["For players the attribute functions are named 'AddCustomAttribute', 'GetCustomAttribute', and 'RemoveCustomAttribute'."]
                bug = ["hidetested=1|This method will always produce attributes with infinite duration, making the 'duration' parameter non-functional."]
                warning = ["Some integer-valued attributes aren't being casted from floating point input number to an integer correctly. The game doesn't do a smart conversion from float to an integer (e.g. 230.0 -> 230), instead it just takes a bit representation of the input value and simply does a data type change (so 230.0 would actually become 1130758144, while they look a lot different in decimal, the bit representation of both numbers is the exact same). You're not allowed to pass in an integer as a value and the Squirrel does smart conversion to a float if you try to do so. The workaround is to wrap your integer value into 'casti2f' which would do the same literal type change, but now from integer to the float, allowing the game to read it properly afterwards. <source lang=\"js\"> weapon.AddAttribute(\"paintkit_proto_def_index\", casti2f(230), 0) </source>"]
            }
            GetAttribute = {
                info = "'float GetAttribute(string ''name'', float ''default_value'')'"
                args = 2
                description = "Get an attribute float from the entity. If the attribute does not exist, returns 'default_value'."
                warning = ["See above, but in this case to receive the proper integer value use 'castf2i'. Also make sure to restrict the number to 32 bit: <source lang=\"js\"> castf2i(weapon.GetAttribute(\"paintkit_proto_def_index\", 0.0)) & 0xFFFFFFFF </source>"]
            }
            RemoveAttribute = {
                info = "'void RemoveAttribute(string ''name'')'"
                args = 1
                description = "Remove an attribute from the entity."
                note = ["Static attributes (i.e. attributes that exist by default on the item) cannot be removed. However, you can override their value with 'AddAttribute' to effectively modify or disable them."]
            }
            ReapplyProvision = {
                info = "'void ReapplyProvision()'"
                args = 0
                description = "Relinks attributes to provisioners, e.g. calling this on a weapon will add it's attributes to the player."
            }
        }
        CTFPlayer = {
            AddCond = {
                info = "'void AddCond([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'')'"
                args = 1
                description = ""
            }
            AddCondEx = {
                info = "'void AddCondEx([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'', float ''duration'', handle ''provider'')'"
                args = 3
                description = ""
            }
            AddCurrency = {
                info = "'void AddCurrency(int ''amount'')'"
                args = 1
                description = "Kaching! Give the player some cash for game modes with upgrades, ie. MvM. The new value is bounded between 0-30000."
                note = ["Using 'RemoveCurrency'/'SetCurrency' instead or setting the 'm_nCurrency' netprop directly will bypass the bounds checking."]
            }
            AddCustomAttribute = {
                info = "'void AddCustomAttribute(string ''name'', float ''value'', float ''duration'')'"
                args = 3
                description = "Add a custom attribute to the player. Set duration to 0 or lower for the attribute to be applied forever. The attribute must be one that exists in the game, invalid ones will not be added."
                note = [
                    "This does not work when applied in the 'player_spawn' event, because custom attributes are cleared immediately after the event. As a workaround, it can be applied with a delay. See the [[Team_Fortress_2/Scripting/VScript_Examples#Adding_attributes_to_player_on_spawn|example]] code."
                    "For weapons and cosmetics, the attribute functions are named 'AddAttribute', 'GetAttribute', and 'RemoveAttribute'."
                ]
            }
            AddHudHideFlags = {
                info = "'void AddHudHideFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FHideHUD|FHideHUD]] ''flags'')'"
                args = 1
                description = "Hides a hud element(-s)."
            }
            ApplyPunchImpulseX = {
                info = "'bool ApplyPunchImpulseX(float ''impulse'')'"
                args = 1
                description = "Apply a view punch along the pitch angle. Used to flinch players when hit. If the player is a fully charged scoped-in sniper and the weapon has the 'aiming_no_flinch' attribute, the punch will not apply. Returns true if the punch was applied."
            }
            BleedPlayer = {
                info = "'void BleedPlayer(float ''duration'')'"
                args = 1
                description = "Make a player bleed for a set duration of time."
            }
            BleedPlayerEx = {
                info = "'void BleedPlayerEx(float ''duration'', int ''damage'', bool ''endless'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFDmgCustom|ETFDmgCustom]] ''custom_damage_type'')'"
                args = 4
                description = "Make a player bleed for a set duration of time, or forever, with specific damage per tick and damage_custom index."
            }
            CancelTaunt = {
                info = "'void CancelTaunt()'"
                args = 0
                description = "Cancels any taunt in progress."
            }
            CanAirDash = {
                info = "'bool CanAirDash()'"
                args = 0
                description = "Can the player air dash/double jump?"
            }
            CanBeDebuffed = {
                info = "'bool CanBeDebuffed()'"
                args = 0
                description = ""
            }
            CanBreatheUnderwater = {
                info = "'bool CanBreatheUnderwater()'"
                args = 0
                description = ""
            }
            CanDuck = {
                info = "'bool CanDuck()'"
                args = 0
                description = "Can the player duck?"
            }
            CanGetWet = {
                info = "'bool CanGetWet()'"
                args = 0
                description = "Can the player get wet by jarate/milk?"
            }
            CanJump = {
                info = "'bool CanJump()'"
                args = 0
                description = "Can the player jump? Returns false if the player is taunting or if the 'no_jump' attribute is present and non-zero. There is other conditions that prevent jumping but this function by itself doesn't check those."
            }
            ClearCustomModelRotation = {
                info = "'void ClearCustomModelRotation()'"
                args = 0
                description = ""
            }
            ClearSpells = {
                info = "'void ClearSpells()'"
                args = 0
                description = ""
            }
            ClearTauntAttack = {
                info = "'void ClearTauntAttack()'"
                args = 0
                description = "Stops active taunt from damaging or cancels Rock-Paper-Scissors result."
            }
            CanPlayerMove = {
                info = "'bool CanPlayerMove()'"
                args = 0
                description = "Can the player move?"
            }
            DoTauntAttack = {
                info = "'void DoTauntAttack()'"
                args = 0
                description = "Performs taunts attacks if available. Player must be already taunting and taunt must have a valid attack assigned ('taunt attack name' attribute)."
            }
            DropFlag = {
                info = "'void DropFlag(bool ''silent'')'"
                args = 1
                description = "Force player to drop the flag (intelligence)."
            }
            DropRune = {
                info = "'void DropRune(bool ''apply_force'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 2
                description = "Force player to drop the rune."
                tip = ["This can be abused to spawn arbitrary Mannpower powerups. See [[Team_Fortress_2/Scripting/VScript_Examples#Creating_Mannpower_powerups|the example]]."]
            }
            EndLongTaunt = {
                info = "'void EndLongTaunt()'"
                args = 0
                description = "Stops a looping taunt (obeys minimum time rules and plays outro animation if available)."
            }
            EquipWearableViewModel = {
                info = "'void EquipWearableViewModel(handle ''entity'')'"
                args = 1
                description = "Equips a wearable on the viewmodel. Intended to be used with [[tf_wearable_vm]] entities."
            }
            ExtinguishPlayerBurning = {
                info = "'void ExtinguishPlayerBurning()'"
                args = 0
                description = ""
            }
            FiringTalk = {
                info = "'void FiringTalk()'"
                args = 0
                description = "Makes eg. a heavy go AAAAAAAAAAaAaa like they are firing their minigun.   {{workaround|The input 'SpeakResponseConcept' can be used to play voicelines by supplying a [[Team_Fortress_2/Scripting/Script_Functions/Constants#MP_CONCEPT|Concept]].}}"
                note = ["This only works in a few situations as it requires certain gameplay conditions to be true. An example of when this will work: when the player is invulnerable."]
                bug = ["hidetested=1|Unfortunately does not work for Heavy's minigun due to the above quirk."]
            }
            ForceChangeTeam = {
                info = "'void ForceChangeTeam([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'', bool ''full_team_switch'')'"
                args = 2
                description = "Force player to change their team. Setting the bool to true will not remove nemesis relationships or reset the player's class, as well as not slaying the player."
                note = ["This will not work if a player is in a duel. Setting the 'm_bIsCoaching' [[#CNetPropManager|netprop ↓]] to true on the player and reverting it afterwards is a workaround."]
            }
            ForceRegenerateAndRespawn = {
                info = "'void ForceRegenerateAndRespawn()'"
                args = 0
                description = "Force regenerates and respawns the player."
                note = ["This will not work if the player does not have a desired class set. This can be worked around by setting the 'm_Shared.m_iDesiredPlayerClass' netprop to a class index."]
            }
            ForceRespawn = {
                info = "'void ForceRespawn()'"
                args = 0
                description = "Force respawns the player."
                note = ["This will not work if the player does not have a desired class set. This can be worked around by setting the 'm_Shared.m_iDesiredPlayerClass' netprop to a class index."]
            }
            GetActiveWeapon = {
                info = "'CTFWeapon GetActiveWeapon()'"
                args = 0
                description = "Get the player's current weapon."
            }
            GetBackstabs = {
                info = "'int GetBackstabs()'"
                args = 0
                description = ""
            }
            GetBonusPoints = {
                info = "'int GetBonusPoints()'"
                args = 0
                description = ""
            }
            GetBotType = {
                info = "'int GetBotType()'"
                args = 0
                description = ""
            }
            GetBuildingsDestroyed = {
                info = "'int GetBuildingsDestroyed()'"
                args = 0
                description = ""
            }
            GetCaptures = {
                info = "'int GetCaptures()'"
                args = 0
                description = ""
            }
            GetClassEyeHeight = {
                info = "'Vector GetClassEyeHeight()'"
                args = 0
                description = "Gets the eye height of the player."
            }
            GetCondDuration = {
                info = "'float GetCondDuration([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'')'"
                args = 1
                description = "Returns duration of the condition. Returns 0 if the cond is not applied. Returns -1 if the cond is infinite."
            }
            GetCustomAttribute = {
                info = "'float GetCustomAttribute(string ''name'', float ''default_value'')'"
                args = 2
                description = "Get an attribute float from the player. If the attribute does not exist, returns 'default_value'."
            }
            GetCurrency = {
                info = "'int GetCurrency()'"
                args = 0
                description = "Get player's cash for game modes with upgrades, ie. MvM."
            }
            GetCurrentTauntMoveSpeed = {
                info = "'float GetCurrentTauntMoveSpeed()'"
                args = 0
                description = ""
            }
            GetDefenses = {
                info = "'int GetDefenses()'"
                args = 0
                description = ""
            }
            GetDisguiseAmmoCount = {
                info = "'int GetDisguiseAmmoCount()'"
                args = 0
                description = ""
            }
            GetDisguiseTarget = {
                info = "'CTFPlayer GetDisguiseTarget()'"
                args = 0
                description = ""
            }
            GetDisguiseTeam = {
                info = "'int GetDisguiseTeam()'"
                args = 0
                description = ""
            }
            GetDominations = {
                info = "'int GetDominations()'"
                args = 0
                description = ""
            }
            GetGrapplingHookTarget = {
                info = "'handle GetGrapplingHookTarget()'"
                args = 0
                description = "What entity is the player grappling?"
            }
            GetHeadshots = {
                info = "'int GetHeadshots()'"
                args = 0
                description = ""
            }
            GetHealPoints = {
                info = "'int GetHealPoints()'"
                args = 0
                description = ""
            }
            GetHealTarget = {
                info = "'handle GetHealTarget()'"
                args = 0
                description = "Who is the medic healing?"
            }
            GetHudHideFlags = {
                info = "'int GetHudHideFlags()'"
                args = 0
                description = "Gets current hidden hud elements. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#FHideHUD|Constants.FHideHUD]]."
            }
            GetInvulns = {
                info = "'int GetInvulns()'"
                args = 0
                description = ""
            }
            GetKillAssists = {
                info = "'int GetKillAssists()'"
                args = 0
                description = ""
            }
            GetLastWeapon = {
                info = "'CTFWeapon GetLastWeapon()'"
                args = 0
                description = ""
            }
            GetNextChangeClassTime = {
                info = "'float GetNextChangeClassTime()'"
                args = 0
                description = "Get next change class time."
            }
            GetNextChangeTeamTime = {
                info = "'float GetNextChangeTeamTime()'"
                args = 0
                description = "Get next change team time."
            }
            GetNextRegenTime = {
                info = "'float GetNextRegenTime()'"
                args = 0
                description = "Get next health regen time."
            }
            GetPlayerClass = {
                info = "'int GetPlayerClass()'"
                args = 0
                description = ""
            }
            GetRageMeter = {
                info = "'float GetRageMeter()'"
                args = 0
                description = ""
            }
            GetResupplyPoints = {
                info = "'int GetResupplyPoints()'"
                args = 0
                description = ""
            }
            GetRevenge = {
                info = "'int GetRevenge()'"
                args = 0
                description = ""
            }
            GetScoutHypeMeter = {
                info = "'float GetScoutHypeMeter()'"
                args = 0
                description = ""
            }
            GetSpyCloakMeter = {
                info = "'float GetSpyCloakMeter()'"
                args = 0
                description = ""
            }
            GetTeleports = {
                info = "'int GetTeleports()'"
                args = 0
                description = ""
            }
            GetTauntAttackTime = {
                info = "'float GetTauntAttackTime()'"
                args = 0
                description = "Timestamp until a taunt attack \"lasts\". 0 if unavailable."
            }
            GetTauntRemoveTime = {
                info = "'float GetTauntRemoveTime()'"
                args = 0
                description = "Timestamp until taunt is stopped."
            }
            GetVehicleReverseTime = {
                info = "'float GetVehicleReverseTime()'"
                args = 0
                description = "Timestamp when kart was reversed."
            }
            GetTimeSinceCalledForMedic = {
                info = "'float GetTimeSinceCalledForMedic()'"
                args = 0
                description = "When did the player last call medic."
            }
            GrantOrRemoveAllUpgrades = {
                info = "'void GrantOrRemoveAllUpgrades(bool ''remove'', bool ''refund'')'"
                args = 2
                description = ""
            }
            HasItem = {
                info = "'bool HasItem()'"
                args = 0
                description = "Currently holding an item? Eg. capture flag."
                tip = ["Fetch the 'm_hItem' netprop to get the entity handle."]
            }
            HandleTauntCommand = {
                info = "'void HandleTauntCommand(int ''taunt_slot'')'"
                args = 1
                description = "Spoofs a taunt command from the player, as if they selected this taunt. This can be abused to give the player any taunt, see the [[Team_Fortress_2/Scripting/VScript_Examples#Giving a taunt|examples page]]."
            }
            IgnitePlayer = {
                info = "'void IgnitePlayer()'"
                args = 0
                description = ""
                bug = ["hidetested=1|Does nothing except play on-fire sound and voicelines. {{workaround|Create a [[trigger_ignite]] and EntFire 'StartTouch' input on it."]
            }
            InAirDueToExplosion = {
                info = "'bool InAirDueToExplosion()'"
                args = 0
                description = ""
            }
            InAirDueToKnockback = {
                info = "'bool InAirDueToKnockback()'"
                args = 0
                description = ""
            }
            InCond = {
                info = "'bool InCond([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'')'"
                args = 1
                description = ""
            }
            IsAirDashing = {
                info = "'bool IsAirDashing()'"
                args = 0
                description = ""
            }
            IsAllowedToRemoveTaunt = {
                info = "'bool IsAllowedToRemoveTaunt()'"
                args = 0
                description = "Returns true if the taunt will be stopped."
            }
            IsAllowedToTaunt = {
                info = "'bool IsAllowedToTaunt()'"
                args = 0
                description = ""
            }
            IsBotOfType = {
                info = "'bool IsBotOfType([[Team_Fortress_2/Scripting/Script_Functions/Constants#EBotType|EBotType]] ''type'')'"
                args = 1
                description = "Returns true if the player matches this bot type. Only one type of bot exists which is reserved for AI bots (not [https://wiki.teamfortress.com/wiki/Bots#Puppet_bots puppet bots]). 0 is used for real players or puppet bots. Use 'IsFakeClient' to check for a puppet bot instead."
            }
            IsCallingForMedic = {
                info = "'bool IsCallingForMedic()'"
                args = 0
                description = "Is this player calling for medic?"
            }
            IsCarryingRune = {
                info = "'bool IsCarryingRune()'"
                args = 0
                description = ""
            }
            IsControlStunned = {
                info = "'bool IsControlStunned()'"
                args = 0
                description = ""
            }
            IsCritBoosted = {
                info = "'bool IsCritBoosted()'"
                args = 0
                description = ""
            }
            IsFakeClient = {
                info = "'bool IsFakeClient()'"
                args = 0
                description = "Returns true if the player is a puppet or AI bot. To check if the player is a AI bot ('CTFBot') specifically, use 'IsBotOfType' instead."
            }
            IsFireproof = {
                info = "'bool IsFireproof()'"
                args = 0
                description = ""
            }
            IsFullyInvisible = {
                info = "'bool IsFullyInvisible()'"
                args = 0
                description = ""
            }
            IsHypeBuffed = {
                info = "'bool IsHypeBuffed()'"
                args = 0
                description = ""
            }
            IsImmuneToPushback = {
                info = "'bool IsImmuneToPushback()'"
                args = 0
                description = ""
            }
            IsInspecting = {
                info = "'bool IsInspecting()'"
                args = 0
                description = ""
            }
            IsInvulnerable = {
                info = "'bool IsInvulnerable()'"
                args = 0
                description = ""
            }
            IsJumping = {
                info = "'bool IsJumping()'"
                args = 0
                description = ""
            }
            IsMiniBoss = {
                info = "'bool IsMiniBoss()'"
                args = 0
                description = "Is this player an MvM mini-boss?"
            }
            IsParachuteEquipped = {
                info = "'bool IsParachuteEquipped()'"
                args = 0
                description = ""
            }
            IsPlacingSapper = {
                info = "'bool IsPlacingSapper()'"
                args = 0
                description = "Returns true if we placed a sapper in the last few moments."
            }
            IsRageDraining = {
                info = "'bool IsRageDraining()'"
                args = 0
                description = ""
            }
            IsRegenerating = {
                info = "'bool IsRegenerating()'"
                args = 0
                description = ""
            }
            IsSapping = {
                info = "'bool IsSapping()'"
                args = 0
                description = "Returns true if we are currently sapping."
            }
            IsSnared = {
                info = "'bool IsSnared()'"
                args = 0
                description = ""
            }
            IsStealthed = {
                info = "'bool IsStealthed()'"
                args = 0
                description = ""
            }
            IsTaunting = {
                info = "'bool IsTaunting()'"
                args = 0
                description = ""
            }
            IsUsingActionSlot = {
                info = "'bool IsUsingActionSlot()'"
                args = 0
                description = ""
            }
            IsViewingCYOAPDA = {
                info = "'bool IsViewingCYOAPDA()'"
                args = 0
                description = ""
            }
            Regenerate = {
                info = "'void Regenerate(bool ''refill_health_ammo'')'"
                args = 1
                description = "Resupplies a player. If refill health/ammo is set, clears negative conds, gives back player health/ammo."
            }
            RemoveAllItems = {
                info = "'void RemoveAllItems(bool ''unused'')'"
                args = 1
                description = ""
                bug = ["hidetested=1|This does not actually remove all items. It only drops the passtime ball, intelligence, disables radius healing, and hides the Spy invis watch. {{workaround|Iterate through player's children, and destroy subclass instances of CEconEntity. {{ExpandBox|<source lang=js> function RemoveAllItems(player) { // If you destroy an entity it becomes invalid // It will not longer keep a track of the next child and .NextMovePeer method becomes unavailable so the next iteration will fail // To prevent this you can store a reference the next child for (local next, current = player.FirstMoveChild(); current != null; current = next) { NetProps.SetPropBool(current, \"m_bForcePurgeFixedupStrings\", true) // Store the next handle next = current.NextMovePeer() if (current instanceof CEconEntity) current.Destroy() } } //Example RemoveAllItems(GetListenServerHost()) </source>"]
            }
            RemoveAllObjects = {
                info = "'void RemoveAllObjects(bool ''explode'')'"
                args = 1
                description = "Remove all player objects. Eg. dispensers/sentries."
            }
            RemoveCond = {
                info = "'void RemoveCond([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'')'"
                args = 1
                description = "Removes a condition. Does not remove a condition if the minimum duration has not passed. Does nothing if the condition isn't added (interally does 'InCond' check)."
            }
            RemoveCondEx = {
                info = "'void RemoveCondEx([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'', bool ''ignore_duration'')'"
                args = 2
                description = "Extended version of above function. Allows forcefully removing the condition even if minimum duration is not met."
            }
            RemoveCurrency = {
                info = "'void RemoveCurrency(int ''amount'')'"
                args = 1
                description = "Take away money from a player for reasons such as ie. spending. Lower bounded to 0."
                note = ["Unlike 'AddCurrency', negative values will go past the 30000 limit."]
            }
            RemoveCustomAttribute = {
                info = "'void RemoveCustomAttribute(string ''name'')'"
                args = 1
                description = "Remove a custom attribute to the player."
            }
            RemoveDisguise = {
                info = "'void RemoveDisguise()'"
                args = 0
                description = "Undisguise a spy."
            }
            RemoveHudHideFlags = {
                info = "'void RemoveHudHideFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FHideHUD|FHideHUD]] ''flags'')'"
                args = 1
                description = "Unhides a hud element(-s)."
            }
            RemoveInvisibility = {
                info = "'void RemoveInvisibility()'"
                args = 0
                description = "Un-invisible a spy."
            }
            RemoveTeleportEffect = {
                info = "'void RemoveTeleportEffect()'"
                args = 0
                description = ""
            }
            ResetScores = {
                info = "'void ResetScores()'"
                args = 0
                description = ""
            }
            RollRareSpell = {
                info = "'void RollRareSpell()'"
                args = 0
                description = ""
            }
            SetCondDuration = {
                info = "'void SetCondDuration([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'', float ''duration'')'"
                args = 2
                description = ""
            }
            SetCurrency = {
                info = "'void SetCurrency(int ''amount'')'"
                args = 1
                description = "Set player's cash for game modes with upgrades, ie. MvM. Does not have any bounds checking."
            }
            SetCurrentTauntMoveSpeed = {
                info = "'void SetCurrentTauntMoveSpeed(float ''speed'')'"
                args = 1
                description = ""
            }
            SetCustomModel = {
                info = "'void SetCustomModel(string ''model_name'')'"
                args = 1
                description = "Sets a custom player model without animations (model will T-pose). To enable animations, use 'SetCustomModelWithClassAnimations' instead."
            }
            SetCustomModelOffset = {
                info = "'void SetCustomModelOffset(Vector ''offset'')'"
                args = 1
                description = ""
            }
            SetCustomModelRotates = {
                info = "'void SetCustomModelRotates(bool ''toggle'')'"
                args = 1
                description = ""
            }
            SetCustomModelRotation = {
                info = "'void SetCustomModelRotation(QAngle ''angles'')'"
                args = 1
                description = ""
            }
            SetCustomModelVisibleToSelf = {
                info = "'void SetCustomModelVisibleToSelf(bool ''toggle'')'"
                args = 1
                description = ""
            }
            SetCustomModelWithClassAnimations = {
                info = "'void SetCustomModelWithClassAnimations(string ''model_name'')'"
                args = 1
                description = "Sets a custom player model with full animations."
            }
            SetDisguiseAmmoCount = {
                info = "'void SetDisguiseAmmoCount(int ''count'')'"
                args = 1
                description = ""
            }
            SetForcedTauntCam = {
                info = "'void SetForcedTauntCam(int ''toggle'')'"
                args = 1
                description = ""
            }
            SetGrapplingHookTarget = {
                info = "'void SetGrapplingHookTarget(handle ''entity'', bool ''bleed'')'"
                args = 2
                description = "Set the player's target grapple entity."
            }
            SetHudHideFlags = {
                info = "'void SetHudHideFlags([[Team_Fortress_2/Scripting/Script_Functions/Constants#FHideHUD|FHideHUD]] ''flags'')'"
                args = 1
                description = "Force hud hide flags to a value."
            }
            SetIsMiniBoss = {
                info = "'void SetIsMiniBoss(bool ''toggle'')'"
                args = 1
                description = "Make this player an MvM mini-boss."
            }
            SetNextChangeClassTime = {
                info = "'void SetNextChangeClassTime(float ''time'')'"
                args = 1
                description = "Set next change class time."
            }
            SetNextChangeTeamTime = {
                info = "'void SetNextChangeTeamTime(float ''time'')'"
                args = 1
                description = "Set next change team time."
            }
            SetNextRegenTime = {
                info = "'void SetNextRegenTime(float ''time'')'"
                args = 1
                description = "Set next available resupply time."
            }
            SetPlayerClass = {
                info = "'void SetPlayerClass([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFClass|ETFClass]] ''class_index'')'"
                args = 1
                description = "Sets the player class. Updates the player's visuals and model."
                note = [
                    "Does not force the class to be changed and can be buggy for server-side scripts. This can be resolved by calling 'NetProps.SetPropInt(player, \"m_Shared.m_iDesiredPlayerClass\", class_index)' after 'SetPlayerClass' and before 'ForceRegenerateAndRespawn'. This resolves issues like the player respawning as their \"desired\" class instead or loadout showing the desired class rather than what they are."
                    "Does not regenerate class properties, such as health or weapons. This can be done by calling 'ForceRegenerateAndRespawn' afterwards."
                ]
                warning = ["If the player is not respawned, the hitbox set will be used from the old class! Calling 'SetCustomModel' with a blank parameter is sufficient to update it."]
            }
            SetRageMeter = {
                info = "'void SetRageMeter(float ''percent'')'"
                args = 1
                description = "Sets rage meter from 0 - 100."
            }
            SetRPSResult = {
                info = "'void SetRPSResult(int ''result'')'"
                args = 1
                description = "Rig the result of Rock-Paper-Scissors (0 - rock, 1 - paper, 2 - scissors)."
            }
            SetScoutHypeMeter = {
                info = "'void SetScoutHypeMeter(float ''percent'')'"
                args = 1
                description = "Sets hype meter from 0 - 100."
            }
            SetSpyCloakMeter = {
                info = "'void SetSpyCloakMeter(float)'"
                args = 1
                description = "Sets cloakmeter from 0 - 100."
            }
            SetVehicleReverseTime = {
                info = "'void SetVehicleReverseTime(float ''time'')'"
                args = 1
                description = "Set the timestamp when kart was reversed."
            }
            SetUseBossHealthBar = {
                info = "'void SetUseBossHealthBar(bool ''toggle'')'"
                args = 1
                description = ""
            }
            StopTaunt = {
                info = "'void StopTaunt(bool ''remove_prop'')'"
                args = 1
                description = "Stops current taunt. If ''remove_prop'' is true, the taunt prop will be immediately deleted instead of potentially delaying."
            }
            StunPlayer = {
                info = "'void StunPlayer(float ''duration'', float ''move_speed_reduction'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#TF_STUN|TF_STUN]] ''flags'', handle ''attacker'')'"
                args = 4
                description = ""
                note = ["Doesn't allow you to set 'm_bStunEffects' which is responsible for \"scared\" particle effects and sounds. {{workaround|Create a [[trigger_stun]] and fire 'StartTouch' on it with activator being a player. Note that this trigger can only be activated once per player."]
            }
            Taunt = {
                info = "'void Taunt([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTaunts|FTaunts]] ''taunt_index'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#MP_CONCEPT|MP_CONCEPT]] ''taunt_concept'')'"
                args = 2
                description = "Performs a taunt if allowed. Concept is the \"voiceline\" index to use with the taunt. For 'TAUNT_SHOW_ITEM' and 'TAUNT_BASE_WEAPON' this is set automatically. 'TAUNT_LONG' is not supported."
                tip = [
                    "TAUNT_MISC_ITEM with a concept of 'MP_CONCEPT_TAUNT_LAUGH' will make the player laugh. Concept 'MP_CONCEPT_TAUNT_REPLAY' will play the replay taunt."
                    "To perform any taunt such as conga, see the [[Team_Fortress_2/Scripting/VScript_Examples#Giving a taunt|examples page]]."
                ]
            }
            TryToPickupBuilding = {
                info = "'bool TryToPickupBuilding()'"
                args = 0
                description = "Make the player attempt to pick up a building in front of them."
            }
            UpdateSkin = {
                info = "'void UpdateSkin(int ''skin'')'"
                args = 1
                description = ""
            }
            WasInCond = {
                info = "'bool WasInCond([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFCond|ETFCond]] ''cond'')'"
                args = 1
                description = ""
            }
            Weapon_CanUse = {
                info = "'bool Weapon_CanUse(CTFWeapon ''weapon'')'"
                args = 1
                description = ""
            }
            Weapon_Drop = {
                info = "'void Weapon_Drop(CTFWeapon ''weapon'')'"
                args = 1
                description = "Does nothing!"
            }
            Weapon_DropEx = {
                info = "'void Weapon_DropEx(CTFWeapon ''weapon'', Vector ''target'', Vector ''velocity'')'"
                args = 3
                description = "Does nothing!"
            }
            Weapon_Equip = {
                info = "'void Weapon_Equip(CTFWeapon ''weapon'')'"
                args = 1
                description = "Equips a weapon in the player. This places it inside the 'm_hMyWeapons' array."
            }
            Weapon_SetLast = {
                info = "'void Weapon_SetLast(CTFWeapon ''weapon'')'"
                args = 1
                description = ""
            }
            Weapon_ShootPosition = {
                info = "'Vector Weapon_ShootPosition()'"
                args = 0
                description = ""
                note = ["While the weapon shoot position matches with eye position for hitscan and melee weapons, it does not reflect the actual shoot position of most projectile weapons since they have an additional offset from the eye location. To get the exact shoot position you can use the following function: {{ExpandBox|<source lang=js> function GetWeaponShootPosition(player) { local weapon = player.GetActiveWeapon() local offset = null switch (NetProps.GetPropInt(weapon, \"m_AttributeManager.m_Item.m_iItemDefinitionIndex\")) { case 441: // The Cow Mangler offset = Vector(23.5, 8.0, player.GetFlags() & Constants.FPlayer.FL_DUCKING ? 8.0 : -3.0) break case 513: // The Original offset = Vector(23.5, 0.0, player.GetFlags() & Constants.FPlayer.FL_DUCKING ? 8.0 : -3.0) break case 18: // Rocket Launcher case 127: // The Direct Hit case 1104: // The Air Strike case 205: // Rocket Launcher (Renamed/Strange) case 228: // The Black Box case 237: // Rocket Jumper case 414: // The Liberty Launcher case 658: // Festive Rocket Launcher case 730: // The Beggar's Bazooka case 800: // Silver Botkiller Rocket Launcher Mk.I case 809: // Gold Botkiller Rocket Launcher Mk.I case 889: // Rust Botkiller Rocket Launcher Mk.I case 898: // Blood Botkiller Rocket Launcher Mk.I case 907: // Carbonado Botkiller Rocket Launcher Mk.I case 916: // Diamond Botkiller Rocket Launcher Mk.I case 965: // Silver Botkiller Rocket Launcher Mk.II case 974: // Gold Botkiller Rocket Launcher Mk.II case 1085: // Festive Black Box case 15006: // Woodland Warrior case 15014: // Sand Cannon case 15028: // American Pastoral case 15043: // Smalltown Bringdown case 15052: // Shell Shocker case 15057: // Aqua Marine case 15081: // Autumn case 15104: // Blue Mew case 15105: // Brain Candy case 15129: // Coffin Nail case 15130: // High Roller's case 15150: // Warhawk case 39: // The Flare Gun case 351: // The Detonator case 595: // The Manmelter case 740: // The Scorch Shot case 1081: // Festive Flare Gun offset = Vector(23.5, 12.0, player.GetFlags() & Constants.FPlayer.FL_DUCKING ? 8.0 : -3.0) break case 56: // Hunstman case 1005: // Festive Huntsman case 1092: // The Fortified Compound case 997: // Rescue Ranger case 305: // Crusader's Crossbow case 1079: // Festive Crusader's Crossbow offset = Vector(23.5, 12.0, -3.0) break case 442: // The Righteous Bison case 588: // The Pomson 6000 offset = Vector(23.5, 8.0, player.GetFlags() & Constants.FPlayer.FL_DUCKING ? 8.0 : -3.0) break case 222: // The Mad Milk case 1121: // Mutated Milk case 1180: // Gas Passer case 58: // Jarate case 751: // Festive Jarate case 1105: // The Self-Aware Beauty Mark case 19: // Grenade Launcher case 206: // Grenade Launcher (Renamed/Strange) case 308: // The Loch-n-Load case 996: // The Loose Cannon case 1007: // Festive Grenade Launcher case 1151: // The Iron Bomber case 15077: // Autumn case 15079: // Macabre Web case 15091: // Rainbow case 15092: // Sweet Dreams case 15116: // Coffin Nail case 15117: // Top Shelf case 15142: // Warhawk case 15158: // Butcher Bird case 20: // Stickybomb Launcher case 207: // Stickybomb Launcher (Renamed/Strange) case 130: // The Scottish Resistance case 265: // Sticky Jumper case 661: // Festive Stickybomb Launcher case 797: // Silver Botkiller Stickybomb Launcher Mk.I case 806: // Gold Botkiller Stickybomb Launcher Mk.I case 886: // Rust Botkiller Stickybomb Launcher Mk.I case 895: // Blood Botkiller Stickybomb Launcher Mk.I case 904: // Carbonado Botkiller Stickybomb Launcher Mk.I case 913: // Diamond Botkiller Stickybomb Launcher Mk.I case 962: // Silver Botkiller Stickybomb Launcher Mk.II case 971: // Gold Botkiller Stickybomb Launcher Mk.II case 1150: // The Quickiebomb Launcher case 15009: // Sudden Flurry case 15012: // Carpet Bomber case 15024: // Blasted Bombardier case 15038: // Rooftop Wrangler case 15045: // Liquid Asset case 15048: // Pink Elephant case 15082: // Autumn case 15083: // Pumpkin Patch case 15084: // Macabre Web case 15113: // Sweet Dreams case 15137: // Coffin Nail case 15138: // Dressed to Kill case 15155: // Blitzkrieg offset = Vector(16.0, 8.0, -6.0) break case 17: // Syringe Gun case 204: // Syringe Gun (Renamed/Strange) case 36: // The Blutsauger case 412: // The Overdose offset = Vector(16.0, 6.0, -8.0) break case 812: // The Flying Guillotine case 833: // The Flying Guillotine (Genuine) offset = Vector(32.0, 0.0, 15.0) break case 528: // The Short Curcuit offset = Vector(40.0, 15.0, -10.0) break case 44: // Sandman case 648: // The Wrap Assassin return player.GetOrigin() + player.GetModelScale() * (player.EyeAngles().Forward() * 32.0 + Vector(0.0, 0.0, 50.0)) default: return player.EyePosition() } if (Convars.GetClientConvarValue(\"cl_flipviewmodels\", player.entindex()) == \"1\") offset.y *= -1 local eye_angles = player.EyeAngles() return player.EyePosition() + eye_angles.Up() * offset.z + eye_angles.Left() * offset.y + eye_angles.Forward() * offset.x } // Example usage // Works only for the rocket launchers local player = GetListenServerHost() local eye_position = player.EyePosition() local shoot_position = GetWeaponShootPosition(player) local eye_vector = player.EyeAngles().Forward() local trace = { start = shoot_position end = eye_position + eye_vector * 32768.0 ignore = player hullmin = Vector(-1.0, -1.0, -1.0) hullmax = Vector(1.0, 1.0, 1.0) } TraceHull(trace) DebugDrawLine(shoot_position, trace.pos, 255, 255, 255, false, 5.0) DebugDrawBox(trace.pos, Vector(-2.0, -2.0, -2.0), Vector(2.0, 2.0, 2.0), 255, 0, 0, 255, 5.0) </source>"]
            }
            Weapon_Switch = {
                info = "'void Weapon_Switch(CTFWeapon ''weapon'')'"
                args = 1
                description = "Attempts a switch to the given weapon, if present in the player's inventory ('m_hMyWeapons' array).  * Player has 'TF_COND_CANNOT_SWITCH_FROM_MELEE' condition (from eating Buffalo Steak Sandvich) and is holding a melee -> Remove 'TF_COND_CANNOT_SWITCH_FROM_MELEE' condition. * Using the Thermal Thruster: <source lang=js> // assuming \"weapon\" is the thermal thruster NetProps.SetPropEntity(player, \"m_hActiveWeapon\", null) if (player.InCond(Constants.ETFCond.TF_COND_ROCKETPACK)) { // needed to stop air sound SendGlobalGameEvent(\"rocketpack_landed\", { userid = GetPlayerUserID(player) }) player.RemoveCond(Constants.ETFCond.TF_COND_ROCKETPACK) } </source> }}"
                note = ["Most of the time a weapon switch will succeed, except in these circumstances. Workarounds are provided in each case to allow a forced switch. * Revved with a minigun * Just fired with a sniper rifle * Blowing the horn of a banner item * Holding Half-Zatoichi and under 50 health * Backstab stun from a Razorback -> Set 'm_hActiveWeapon' netprop on the player to null. {{warning|Do not take the lazy way out and run this workaround for every weapon, it will break other weapons like the Huntsman. Only run this workaround for the specific class of weapons above."]
            }
        }
        CTFBot = {
            AddBotAttribute = {
                info = "'void AddBotAttribute([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFBotAttributeType|FTFBotAttributeType]] ''attribute'')'"
                args = 1
                description = "Sets attribute flags on this TFBot."
            }
            AddBotTag = {
                info = "'void AddBotTag(string ''tag'')'"
                args = 1
                description = "Adds a bot tag."
            }
            AddWeaponRestriction = {
                info = "'void AddWeaponRestriction([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBotWeaponRestrictionType|TFBotWeaponRestrictionType]] ''flags'')'"
                args = 1
                description = "Adds weapon restriction flags."
            }
            ClearAllBotAttributes = {
                info = "'void ClearAllBotAttributes()'"
                args = 0
                description = "Clears all attribute flags on this TFBot."
            }
            ClearAllBotTags = {
                info = "'void ClearAllBotTags()'"
                args = 0
                description = "Clears bot tags."
            }
            ClearAllWeaponRestrictions = {
                info = "'void ClearAllWeaponRestrictions()'"
                args = 0
                description = "Removes all weapon restriction flags."
            }
            ClearAttentionFocus = {
                info = "'void ClearAttentionFocus()'"
                args = 0
                description = "Clear current focus."
            }
            ClearBehaviorFlag = {
                info = "'void ClearBehaviorFlag([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBOT_BEHAVIOR|TFBOT_BEHAVIOR]] ''flags'')'"
                args = 1
                description = "Clear the given behavior flag(s) for this bot."
            }
            DelayedThreatNotice = {
                info = "'void DelayedThreatNotice(handle ''threat'', float ''delay'')'"
                args = 2
                description = "Notice the threat after a delay in seconds."
            }
            DisbandCurrentSquad = {
                info = "'void DisbandCurrentSquad()'"
                args = 0
                description = "Forces the current squad to be entirely disbanded by everyone."
            }
            FindVantagePoint = {
                info = "'CTFNavArea FindVantagePoint(float ''max_distance'')'"
                args = 1
                description = "Get the nav area of the closest vantage point (within distance)."
            }
            GenerateAndWearItem = {
                info = "'void GenerateAndWearItem(string ''item_name'')'"
                args = 1
                description = "Give me an item!"
            }
            GetActionPoint = {
                info = "'handle GetActionPoint()'"
                args = 0
                description = "Get the given action point for this bot."
            }
            GetAllBotTags = {
                info = "'void GetAllBotTags(table ''result'')'"
                args = 1
                description = "Get all bot tags. The key is the index, and the value is the tag."
            }
            GetHomeArea = {
                info = "'CTFNavArea GetHomeArea()'"
                args = 0
                description = "Sets the home nav area of the bot."
            }
            GetDifficulty = {
                info = "'int GetDifficulty()'"
                args = 0
                description = "Returns the bot's difficulty level. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotDifficultyType|Constants.ETFBotDifficultyType]]."
            }
            GetMaxVisionRangeOverride = {
                info = "'float GetMaxVisionRangeOverride()'"
                args = 0
                description = "Gets the max vision range override for the bot"
                warning = ["MaxVisionRange overrides, as well as certain other bot modifiers, can persist after a bot has been moved to spectator and assigned a new class/loadout in MvM! Identifying MvM bots by the MaxVisionRange override set in a popfile may not be reliable."]
            }
            GetMission = {
                info = "'int GetMission()'"
                args = 0
                description = "Get this bot's current mission. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotMissionType|ETFBotMissionType]]."
            }
            GetMissionTarget = {
                info = "'handle GetMissionTarget()'"
                args = 0
                description = "Get this bot's current mission target."
            }
            GetNearestKnownSappableTarget = {
                info = "'handle GetNearestKnownSappableTarget()'"
                args = 0
                description = "Gets the nearest known sappable target."
            }
            GetPrevMission = {
                info = "'int GetPrevMission()'"
                args = 0
                description = "Get this bot's previous mission. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotMissionType|ETFBotMissionType]]."
            }
            GetSpawnArea = {
                info = "'CTFNavArea GetSpawnArea()'"
                args = 0
                description = "Return the nav area of where we spawned."
            }
            GetSquadFormationError = {
                info = "'float GetSquadFormationError()'"
                args = 0
                description = "Gets our formation error coefficient."
            }
            HasBotAttribute = {
                info = "'bool HasBotAttribute([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFBotAttributeType|FTFBotAttributeType]] ''attribute'')'"
                args = 1
                description = "Checks if this TFBot has the given attributes."
            }
            HasBotTag = {
                info = "'bool HasBotTag(string ''tag'')'"
                args = 1
                description = "Checks if this TFBot has the given bot tag."
            }
            HasMission = {
                info = "'bool HasMission([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotMissionType|ETFBotMissionType]] ''mission'')'"
                args = 1
                description = "Return true if the given mission is this bot's current mission."
            }
            HasWeaponRestriction = {
                info = "'bool HasWeaponRestriction([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBotWeaponRestrictionType|TFBotWeaponRestrictionType]] ''flags'')'"
                args = 1
                description = "Checks if this TFBot has the given weapon restriction flags."
            }
            IsAmmoFull = {
                info = "'bool IsAmmoFull()'"
                args = 0
                description = ""
            }
            IsAmmoLow = {
                info = "'bool IsAmmoLow()'"
                args = 0
                description = ""
            }
            IsAttentionFocused = {
                info = "'bool IsAttentionFocused()'"
                args = 0
                description = "Is our attention focused right now?"
            }
            IsAttentionFocusedOn = {
                info = "'bool IsAttentionFocusedOn(handle ''entity'')'"
                args = 1
                description = "Is our attention focused on this entity."
            }
            IsBehaviorFlagSet = {
                info = "'bool IsBehaviorFlagSet([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBOT_BEHAVIOR|TFBOT_BEHAVIOR]] ''flags'')'"
                args = 1
                description = "Return true if the given behavior flag(s) are set for this bot."
            }
            IsDifficulty = {
                info = "'bool IsDifficulty([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotDifficultyType|ETFBotDifficultyType]] ''difficulty'')'"
                args = 1
                description = "Returns true/false if the bot's difficulty level matches."
            }
            IsInASquad = {
                info = "'bool IsInASquad()'"
                args = 0
                description = "Checks if we are in a squad."
            }
            IsOnAnyMission = {
                info = "'bool IsOnAnyMission()'"
                args = 0
                description = "Return true if this bot has a current mission."
            }
            IsWeaponRestricted = {
                info = "'bool IsWeaponRestricted(handle ''weapon'')'"
                args = 1
                description = "Checks if the given weapon is restricted for use on the bot."
            }
            LeaveSquad = {
                info = "'void LeaveSquad()'"
                args = 0
                description = "Makes us leave the current squad (if any)."
            }
            PressAltFireButton = {
                info = "'void PressAltFireButton(float ''duration'' = -1)'"
                args = 1
                description = ""
            }
            PressFireButton = {
                info = "'void PressFireButton(float ''duration'' = -1)'"
                args = 1
                description = ""
            }
            PressSpecialFireButton = {
                info = "'void PressSpecialFireButton(float ''duration'' = -1)'"
                args = 1
                description = ""
            }
            RemoveBotAttribute = {
                info = "'void RemoveBotAttribute([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFBotAttributeType|FTFBotAttributeType]] ''attribute'')'"
                args = 1
                description = "Removes attribute flags on this TFBot."
            }
            RemoveBotTag = {
                info = "'void RemoveBotTag(string ''tag'')'"
                args = 1
                description = "Removes a bot tag."
            }
            RemoveWeaponRestriction = {
                info = "'void RemoveWeaponRestriction([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBotWeaponRestrictionType|TFBotWeaponRestrictionType]] ''flags'')'"
                args = 1
                description = "Removes weapon restriction flags."
            }
            SetActionPoint = {
                info = "'void SetActionPoint(handle ''entity'')'"
                args = 1
                description = "Set the given action point for this bot."
            }
            SetAttentionFocus = {
                info = "'void SetAttentionFocus(handle ''entity'')'"
                args = 1
                description = "Sets our current attention focus to this entity."
            }
            SetAutoJump = {
                info = "'void SetAutoJump(float ''min_time'', float ''max_time'')'"
                args = 2
                description = "Sets if the bot should automatically jump, and how often."
            }
            SetBehaviorFlag = {
                info = "'void SetBehaviorFlag([[Team_Fortress_2/Scripting/Script_Functions/Constants#TFBOT_BEHAVIOR|TFBOT_BEHAVIOR]] ''flags'')'"
                args = 1
                description = "Set the given behavior flag(s) for this bot."
            }
            SetDifficulty = {
                info = "'void SetDifficulty([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotDifficultyType|ETFBotDifficultyType]] ''difficulty'')'"
                args = 1
                description = "Sets the bots difficulty level."
            }
            SetHomeArea = {
                info = "'void SetHomeArea(CTFNavArea ''area'')'"
                args = 1
                description = "Set the home nav area of the bot, may be null."
            }
            SetMaxVisionRangeOverride = {
                info = "'void SetMaxVisionRangeOverride(float ''range'')'"
                args = 1
                description = "Sets max vision range override for the bot."
            }
            SetMission = {
                info = "'void SetMission([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotMissionType|ETFBotMissionType]] ''mission'', bool ''reset_behavior'')'"
                args = 2
                description = "Set this bot's current mission to the given mission."
            }
            SetMissionTarget = {
                info = "'void SetMissionTarget(handle ''entity'')'"
                args = 1
                description = "Set this bot's mission target to the given entity."
            }
            SetPrevMission = {
                info = "'void SetPrevMission([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFBotMissionType|ETFBotMissionType]] ''mission'')'"
                args = 1
                description = "Set this bot's previous mission to the given mission."
            }
            SetScaleOverride = {
                info = "'void SetScaleOverride(float ''scale'')'"
                args = 1
                description = "Sets the scale override for the bot."
            }
            SetShouldQuickBuild = {
                info = "'void SetShouldQuickBuild(bool ''toggle'')'"
                args = 1
                description = "Sets if the bot should build instantly."
            }
            SetSquadFormationError = {
                info = "'void SetSquadFormationError(float ''coefficient'')'"
                args = 1
                description = "Sets our formation error coefficient."
            }
            ShouldAutoJump = {
                info = "'bool ShouldAutoJump()'"
                args = 0
                description = "Returns if the bot should automatically jump."
            }
            ShouldQuickBuild = {
                info = "'bool ShouldQuickBuild()'"
                args = 0
                description = "Returns if the bot should build instantly."
            }
            UpdateDelayedThreatNotices = {
                info = "'void UpdateDelayedThreatNotices()'"
                args = 0
                description = ""
            }
        }
        CTFBaseBoss = {
            SetResolvePlayerCollisions = {
                info = "'void SetResolvePlayerCollisions(bool ''toggle'')'"
                args = 1
                description = "Sets whether the entity should push away players intersecting its bounding box. On by default."
            }
        }
        Convars = {
            GetBool = {
                info = "'bool GetBool(string ''name'')'"
                args = 1
                description = "Returns the convar as a bool. May return null if no such convar."
            }
            GetClientConvarValue = {
                info = "'string GetClientConvarValue(string ''name'', int ''entindex'')'"
                args = 2
                description = ""
                tip = ["The list of available client convars can be printed in console using the 'findflags USERINFO' command."]
                note = ["Notable client convars available: * cl_autoreload : Whether the client wants autoreload after each shot * cl_autorezoom : Whether the client wants auto scope-in after firing a sniper rifle * cl_connectmethod : How the client joined the server. E.g. ''listenserver'', ''serverbrowser_internet'', ''serverbrowser_favorites'' {{todo|List all of them"]
            }
            GetInt = {
                info = "'int GetInt(string ''name'')'"
                args = 1
                description = "Returns the convar as an int. May return null if no such convar."
                warning = ["The entire convar list is searched each time this is called (which is slow!). If you are going to be using it several times per frame, cache off the result."]
            }
            GetStr = {
                info = "'string GetStr(string ''name'')'"
                args = 1
                description = "Returns the convar as a string. May return null if no such convar. Returns 'hunter2' if a protected convar is accessed."
                warning = ["See above."]
            }
            GetFloat = {
                info = "'float GetFloat(string ''name'')'"
                args = 1
                description = "Returns the convar as a float. May return null if no such convar."
                warning = ["See above."]
            }
            IsConVarOnAllowList = {
                info = "'bool IsConVarOnAllowList(string ''name'')'"
                args = 1
                description = "Checks if the convar is allowed to be used and is in cfg/vscript_convar_allowlist.txt. Please be nice with this and use it for *compatibility* if you need check support and NOT to force server owners to allow hostname to be set... or else this will simply lie and return true in future. ;-) You have been warned!"
            }
            SetValue = {
                info = "'void SetValue(string ''name'', any ''value'')'"
                args = 2
                description = "Sets the value of the convar. The convar must be in cfg/vscript_convar_allowlist.txt to be set. Convars marked as cheat-only can be set even if ''sv_cheats'' is off. Convars marked as dev-only (i.e. not visible in console) can also be set. Supported types are bool, int, float, string. The original value of the convar is saved and is reset on map change, in other words convar changes will not persist across maps."
                warning = ["For changes intended to persist for the whole map, set these at the start of each round instead of only once. Otherwise, custom server configs may load after the initial script and not use the correct settings."]
            }
        }
        CEntities = {
            CreateByClassname = {
                info = "'handle CreateByClassname(string ''classname'')'"
                args = 1
                description = "Creates an entity by classname."
                tip = ["Example usage: <source lang=js>local prop = Entities.CreateByClassname(\"prop_dynamic\")</source>"]
            }
            DispatchSpawn = {
                info = "'void DispatchSpawn(handle ''entity'')'"
                args = 1
                description = ""
                note = ["Calling this on players will cause them to respawn. In {{css"]
            }
            FindByClassname = {
                info = "'handle FindByClassname(handle ''previous'', string ''classname'')'"
                args = 2
                description = "Find entities by the string of their 'classname' keyvalue. Pass 'null' value to start an iteration, or reference to a previously found entity to continue a search."
                note = ["The classname keyvalue of an entity can be manipulated and does not necessarily reflect its code class. There might be entities that have a different classname than the one they are created with. For example you can spawn a \"prop_dynamic\" then change its classname to \"my_prop\", and it will retain the functionality of its code class while also not showing up when searching for \"prop_dynamic\"."]
            }
            FindByClassnameNearest = {
                info = "'handle FindByClassnameNearest(string ''classname'', Vector ''center'', float ''radius'')'"
                args = 3
                description = "Find entities by classname nearest to a point within a radius."
            }
            FindByClassnameWithin = {
                info = "'handle FindByClassnameWithin(handle ''previous'', string ''classname'', Vector ''center'', float ''radius'')'"
                args = 4
                description = "Find entities by classname within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            FindByModel = {
                info = "'handle FindByModel(handle ''previous'', string ''model_name'')'"
                args = 2
                description = "Find entities by the string of their 'model' keyvalue. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            FindByName = {
                info = "'handle FindByName(handle ''previous'', string ''targetname'')'"
                args = 2
                description = "Find entities by the string of their {{ent|targetname}} keyvalue. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            FindByNameNearest = {
                info = "'handle FindByNameNearest(string ''targetname'', Vector ''center'', float ''radius'')'"
                args = 3
                description = "Find entities by targetname nearest to a point within a radius."
            }
            FindByNameWithin = {
                info = "'handle FindByNameWithin(handle ''previous'', string ''targetname'', Vector ''center'', float ''radius'')'"
                args = 4
                description = "Find entities by targetname within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            FindByTarget = {
                info = "'handle FindByTarget(handle ''previous'', string ''target'')'"
                args = 2
                description = "Find entities by the string of their 'target' keyvalue.{{confirm}} Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            FindInSphere = {
                info = "'handle FindInSphere(handle ''previous'', Vector ''center'', float ''radius'')'"
                args = 3
                description = "Find entities within a radius. Pass 'null' to start an iteration, or reference to a previously found entity to continue a search."
            }
            First = {
                info = "'handle First()'"
                args = 0
                description = "Begin an iteration over the list of entities. The first entity is always [[worldspawn]]."
            }
            Next = {
                info = "'handle Next(handle ''previous'')'"
                args = 1
                description = "At the given reference of a previously-found entity, returns the next one after it in the list."
            }
        }
        CTFNavArea = {
            AddIncomingConnection = {
                info = "'void AddIncomingConnection(CTFNavArea ''area'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 2
                description = "Add areas that connect TO this area by a ONE-WAY link."
            }
            ClearAttributeTF = {
                info = "'void ClearAttributeTF([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFNavAttributeType|FTFNavAttributeType]] ''bits'')'"
                args = 1
                description = "Clear TF-specific area attribute bits."
            }
            ComputeClosestPointInPortal = {
                info = "'Vector ComputeClosestPointInPortal(CTFNavArea ''to'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'', Vector ''close_pos'')'"
                args = 3
                description = "Compute closest point within the \"portal\" between to an area's direction from the given position."
            }
            ComputeDirection = {
                info = "'int ComputeDirection(Vector ''point'')'"
                args = 1
                description = "Return direction from this area to the given point."
            }
            ConnectTo = {
                info = "'void ConnectTo(CTFNavArea ''area'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 2
                description = "Connect this area to given area in given direction."
            }
            Contains = {
                info = "'bool Contains(CTFNavArea ''area'')'"
                args = 1
                description = "Return true if other area is on or above this area, but no others."
            }
            ContainsOrigin = {
                info = "'bool ContainsOrigin(Vector ''point'')'"
                args = 1
                description = "Return true if given point is on or above this area, but no others."
            }
            DebugDrawFilled = {
                info = "'void DebugDrawFilled(int ''r'', int ''g'', int ''b'', int ''a'', float ''duration'', bool ''no_depth_test'', float ''margin'')'"
                args = 7
                description = "Draw area as a filled rectangle of the given color."
            }
            Disconnect = {
                info = "'void Disconnect(CTFNavArea ''area'')'"
                args = 1
                description = "Disconnect this area from given area."
            }
            FindRandomSpot = {
                info = "'Vector FindRandomSpot()'"
                args = 0
                description = "Get random origin within extent of area."
            }
            GetAdjacentArea = {
                info = "'handle GetAdjacentArea([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'', int ''n'')'"
                args = 2
                description = "Return the n'th adjacent area in the given direction."
                note = ["'Adjacent area' really means ''outgoing'' connection. Adjacent areas don't necessarily have to physically be touching, there can be a height discrepancy (e.g. at a drop ledge)."]
            }
            GetAdjacentAreas = {
                info = "'void GetAdjacentAreas([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'', table ''result'')'"
                args = 2
                description = "Fills a passed in table with all adjacent areas in the given direction."
            }
            GetAdjacentCount = {
                info = "'int GetAdjacentCount([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 1
                description = "Get the number of adjacent areas in the given direction."
            }
            GetAttributes = {
                info = "'int GetAttributes()'"
                args = 0
                description = "Get area attribute bits. See [[Team_Fortress_2/Scripting/Script_Functions/Constants#FNavAttributeType|FNavAttributeType]]."
            }
            GetAvoidanceObstacleHeight = {
                info = "'float GetAvoidanceObstacleHeight()'"
                args = 0
                description = "Returns the maximum height of the obstruction above the ground."
            }
            GetCenter = {
                info = "'Vector GetCenter()'"
                args = 0
                description = "Get center origin of area."
            }
            GetCorner = {
                info = "'Vector GetCorner([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 1
                description = "Get corner origin of area."
            }
            GetDistanceSquaredToPoint = {
                info = "'float GetDistanceSquaredToPoint(Vector ''pos'')'"
                args = 1
                description = "Return shortest distance between point and this area."
            }
            GetDoor = {
                info = "'CBaseAnimating GetDoor()'"
                args = 0
                description = "Returns the door entity above the area."
            }
            GetElevator = {
                info = "'CBaseAnimating GetElevator()'"
                args = 0
                description = "Returns the elevator if in an elevator's path."
            }
            GetElevatorAreas = {
                info = "'void GetElevatorAreas(table ''result'')'"
                args = 1
                description = "Fills table with a collection of areas reachable via elevator from this area."
            }
            GetID = {
                info = "'int GetID()'"
                args = 0
                description = "Get area ID."
            }
            GetIncomingConnections = {
                info = "'void GetIncomingConnections([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'', table ''result'')'"
                args = 2
                description = "Fills a passed in table with areas connected TO this area by a ONE-WAY link (ie: we have no connection back to them)."
            }
            GetParent = {
                info = "'CTFNavArea GetParent()'"
                args = 0
                description = "Returns the area just prior to this one in the search path."
            }
            GetParentHow = {
                info = "'int GetParentHow()'"
                args = 0
                description = "Returns how we get from parent to us."
            }
            GetPlaceName = {
                info = "'string GetPlaceName()'"
                args = 0
                description = "Get place name if it exists, null otherwise."
            }
            GetPlayerCount = {
                info = "'int GetPlayerCount([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Return number of players of given team currently within this area (team of zero means any/all)."
            }
            GetRandomAdjacentArea = {
                info = "'CTFNavArea GetRandomAdjacentArea([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 1
                description = "Return a random adjacent area in the given direction."
            }
            GetSizeX = {
                info = "'float GetSizeX()'"
                args = 0
                description = "Return the area size along the X axis."
            }
            GetSizeY = {
                info = "'float GetSizeY()'"
                args = 0
                description = "Return the area size along the Y axis."
            }
            GetTravelDistanceToBombTarget = {
                info = "'float GetTravelDistanceToBombTarget()'"
                args = 0
                description = "Gets the travel distance to the MvM bomb target."
            }
            GetZ = {
                info = "'float GetZ(Vector ''pos'')'"
                args = 1
                description = "Return Z of area at (x,y) of 'pos'."
            }
            HasAttributeTF = {
                info = "'bool HasAttributeTF([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFNavAttributeType|FTFNavAttributeType]] ''bits'')'"
                args = 1
                description = "Has TF-specific area attribute bits of the given ones. The name is slightly misleading, think of this one as \"HasAttribute'''s'''TF\"."
            }
            HasAttributes = {
                info = "'bool HasAttributes([[Team_Fortress_2/Scripting/Script_Functions/Constants#FNavAttributeType|FNavAttributeType]] ''bits'')'"
                args = 1
                description = "Has area attribute bits of the given ones?."
            }
            HasAvoidanceObstacle = {
                info = "'bool HasAvoidanceObstacle(float ''max_height'')'"
                args = 1
                description = "Returns true if there's a large, immobile object obstructing this area."
            }
            IsBlocked = {
                info = "'bool IsBlocked([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'', bool ''affects_flow'')'"
                args = 2
                description = "Return true if team is blocked in this area."
            }
            IsBottleneck = {
                info = "'bool IsBottleneck()'"
                args = 0
                description = "Returns true if area is a bottleneck. (tiny narrow areas with only one path)."
            }
            IsCompletelyVisibleToTeam = {
                info = "'bool IsCompletelyVisibleToTeam([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Return true if given area is completely visible from somewhere in this area by someone on the team."
            }
            IsConnected = {
                info = "'bool IsConnected(handle ''area'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 2
                description = "Return true if this area is connected to other area in given direction. (If you set direction to -1 or 4, it will automatically check all directions for a connection)."
            }
            IsCoplanar = {
                info = "'bool IsCoplanar(handle ''area'')'"
                args = 1
                description = "Return true if this area and given. area are approximately co-planar."
            }
            IsDamaging = {
                info = "'bool IsDamaging()'"
                args = 0
                description = "Return true if this area is marked to have continuous damage."
            }
            IsDegenerate = {
                info = "'bool IsDegenerate()'"
                args = 0
                description = "Return true if this area is badly formed."
            }
            IsEdge = {
                info = "'bool IsEdge([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 1
                description = "Return true if there are no bi-directional links on the given side."
            }
            IsFlat = {
                info = "'bool IsFlat()'"
                args = 0
                description = "Return true if this area is approximately flat."
            }
            IsOverlapping = {
                info = "'bool IsOverlapping(handle ''area'')'"
                args = 1
                description = "Return true if 'area' overlaps our 2D extents."
            }
            IsOverlappingOrigin = {
                info = "'bool IsOverlappingOrigin(Vector ''pos'', float ''tolerance'')'"
                args = 2
                description = "Return true if 'pos' is within 2D extents of area."
            }
            IsPotentiallyVisibleToTeam = {
                info = "'bool IsPotentiallyVisibleToTeam([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Return true if any portion of this area is visible to anyone on the given team."
            }
            IsReachableByTeam = {
                info = "'bool IsReachableByTeam([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Is this area reachable by the given team?"
            }
            IsRoughlySquare = {
                info = "'bool IsRoughlySquare()'"
                args = 0
                description = "Return true if this area is approximately square."
            }
            IsTFMarked = {
                info = "'bool IsTFMarked()'"
                args = 0
                description = "Is this nav area marked with the current marking scope?"
            }
            IsUnderwater = {
                info = "'bool IsUnderwater()'"
                args = 0
                description = "Return true if area is underwater."
            }
            IsValidForWanderingPopulation = {
                info = "'bool IsValidForWanderingPopulation()'"
                args = 0
                description = "Returns true if area is valid for wandering population."
            }
            IsVisible = {
                info = "'bool IsVisible(Vector ''point'')'"
                args = 1
                description = "Return true if area is visible from the given eyepoint."
            }
            MarkAsBlocked = {
                info = "'void MarkAsBlocked([[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'')'"
                args = 1
                description = "Mark this area as blocked for team."
            }
            MarkAsDamaging = {
                info = "'void MarkAsDamaging(float ''duration'')'"
                args = 1
                description = "Mark this area is damaging for the next 'duration' seconds."
            }
            MarkObstacleToAvoid = {
                info = "'void MarkObstacleToAvoid(float ''height'')'"
                args = 1
                description = "Marks the obstructed status of the nav area."
            }
            RemoveAttributes = {
                info = "'void RemoveAttributes([[Team_Fortress_2/Scripting/Script_Functions/Constants#FNavAttributeType|FNavAttributeType]] ''bits'')'"
                args = 1
                description = "Removes area attribute bits."
            }
            RemoveOrthogonalConnections = {
                info = "'void RemoveOrthogonalConnections([[Team_Fortress_2/Scripting/Script_Functions/Constants#ENavDirType|ENavDirType]] ''dir'')'"
                args = 1
                description = "Removes all connections in directions to left and right of specified direction."
            }
            SetAttributeTF = {
                info = "'void SetAttributeTF([[Team_Fortress_2/Scripting/Script_Functions/Constants#FTFNavAttributeType|FTFNavAttributeType]] ''bits'')'"
                args = 1
                description = "Set TF-specific area attributes."
            }
            SetAttributes = {
                info = "'void SetAttributes([[Team_Fortress_2/Scripting/Script_Functions/Constants#FNavAttributeType|FNavAttributeType]] ''bits'')'"
                args = 1
                description = "Set area attribute bits."
            }
            SetPlaceName = {
                info = "'void SetPlaceName(string ''name'')'"
                args = 1
                description = "Set place name. If you pass null, the place name will be set to nothing."
            }
            TFMark = {
                info = "'void TFMark()'"
                args = 0
                description = "Mark this nav area with the current marking scope."
            }
            UnblockArea = {
                info = "'void UnblockArea()'"
                args = 0
                description = "Unblocks this area."
            }
        }
        CNavMesh = {
            FindNavAreaAlongRay = {
                info = "'CTFNavArea FindNavAreaAlongRay(Vector ''start_pos'', Vector ''end_pos'', handle ''ignore_area'')'"
                args = 3
                description = "Get nav area from ray."
            }
            GetAllAreas = {
                info = "'void GetAllAreas(table ''result'')'"
                args = 1
                description = "Fills a passed in table of all nav areas."
            }
            GetAreasWithAttributes = {
                info = "'void GetAreasWithAttributes([[Team_Fortress_2/Scripting/Script_Functions/Constants#FNavAttributeType|FNavAttributeType]] ''bits'', table ''result'')'"
                args = 2
                description = "Fills a passed in table of all nav areas that have the specified attributes."
            }
            GetNavArea = {
                info = "'CTFNavArea GetNavArea(Vector ''origin'', float ''beneath'')'"
                args = 2
                description = "Given a position in the world, return the nav area that is closest to or below that height."
            }
            GetNavAreaByID = {
                info = "'CTFNavArea GetNavAreaByID(int ''area_id'')'"
                args = 1
                description = "Get nav area by ID."
            }
            GetNavAreaCount = {
                info = "'int GetNavAreaCount()'"
                args = 0
                description = "Return total number of nav areas."
            }
            GetNavAreasFromBuildPath = {
                info = "'bool GetNavAreasFromBuildPath(CTFNavArea ''start_area'', CTFNavArea ''end_area'', Vector ''goal_pos'', float ''max_path_length'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'', bool ''ignore_nav_blockers'', table ''result'')'"
                args = 7
                description = "Fills the table with areas from a path. Returns whether a path was found. If 'end_area' is NULL, will compute a path as close as possible to 'goal_pos'."
                note = ["The areas are passed from end area to the start area."]
            }
            GetNavAreasInRadius = {
                info = "'void GetNavAreasInRadius(Vector ''origin'', float ''radius'', table ''result'')'"
                args = 3
                description = "Fills a passed in table of nav areas within radius."
            }
            GetNavAreasOverlappingEntityExtent = {
                info = "'void GetNavAreasOverlappingEntityExtent(handle ''entity'', table ''result'')'"
                args = 2
                description = "Fills passed in table with areas overlapping entity's extent."
            }
            GetNearestNavArea = {
                info = "'CTFNavArea GetNearestNavArea(Vector ''origin'', float ''max_distance'', bool ''check_los'', bool ''check_ground'')'"
                args = 4
                description = "Given a position in the world, return the nav area that is closest to or below that height."
            }
            GetObstructingEntities = {
                info = "'void GetObstructingEntities(table ''result'')'"
                args = 1
                description = "Fills a passed in table of all obstructing entities."
            }
            NavAreaBuildPath = {
                info = "'bool NavAreaBuildPath(CTFNavArea ''start_area'', CTFNavArea ''end_erea'', Vector ''goal_pos'', float ''max_path_length'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#ETFTeam|ETFTeam]] ''team'', bool ''ignore_nav_blockers'')'"
                args = 6
                description = "Returns true if a path exists."
            }
            NavAreaTravelDistance = {
                info = "'float NavAreaTravelDistance(CTFNavArea ''start_area'', CTFNavArea ''end_area'', float ''max_path_length'')'"
                args = 3
                description = "Compute distance between two areas. Return -1.0 if can't reach 'end_area' from 'start_area'."
            }
            RegisterAvoidanceObstacle = {
                info = "'void RegisterAvoidanceObstacle(handle ''entity'')'"
                args = 1
                description = "Registers avoidance obstacle."
            }
            UnregisterAvoidanceObstacle = {
                info = "'void UnregisterAvoidanceObstacle(handle ''entity'')'"
                args = 1
                description = "Unregisters avoidance obstacle."
            }
        }
        CNetPropManager = {
            GetPropArraySize = {
                info = "'int GetPropArraySize(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Returns the size of an netprop array, or -1."
            }
            GetPropEntity = {
                info = "'handle GetPropEntity(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads an EHANDLE-valued netprop (21 bit integer). Returns the script handle of the entity."
            }
            GetPropEntityArray = {
                info = "'handle GetPropEntityArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads an EHANDLE-valued netprop (21 bit integer) from an array. Returns the script handle of the entity."
            }
            GetPropBool = {
                info = "'bool GetPropBool(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads a boolean-valued netprop."
            }
            GetPropBoolArray = {
                info = "'bool GetPropBoolArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads a boolean-valued netprop from an array."
            }
            GetPropFloat = {
                info = "'float GetPropFloat(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads a float-valued netprop."
            }
            GetPropFloatArray = {
                info = "'float GetPropFloatArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads a float-valued netprop from an array."
            }
            GetPropInfo = {
                info = "'bool GetPropInfo(handle ''entity'', string ''property_name'', int ''array_element'', table ''result'')'"
                args = 4
                description = "Fills in a passed table with property info for the provided entity."
            }
            GetPropInt = {
                info = "'int GetPropInt(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads an integer-valued netprop."
            }
            GetPropIntArray = {
                info = "'int GetPropIntArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads an integer-valued netprop from an array."
            }
            GetPropString = {
                info = "'string GetPropString(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads an string-valued netprop."
            }
            GetPropStringArray = {
                info = "'string GetPropStringArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads an string-valued netprop from an array."
            }
            GetPropType = {
                info = "'string GetPropType(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Returns the name of the netprop type as a string."
            }
            GetPropVector = {
                info = "'Vector GetPropVector(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Reads a 3D vector-valued netprop."
            }
            GetPropVectorArray = {
                info = "'Vector GetPropVectorArray(handle ''entity'', string ''property_name'', int ''array_element'')'"
                args = 3
                description = "Reads a 3D vector-valued netprop from an array."
            }
            GetTable = {
                info = "'void GetTable(handle ''entity'', int ''prop_type'', table ''result'')'"
                args = 3
                description = "Fills in a passed table with all props of a specified type for the provided entity (set prop_type to 0 for SendTable or 1 for DataMap)."
            }
            HasProp = {
                info = "'bool HasProp(handle ''entity'', string ''property_name'')'"
                args = 2
                description = "Checks if a netprop exists."
            }
            SetPropBool = {
                info = "'void SetPropBool(handle ''entity'', string ''property_name'', bool ''value'')'"
                args = 3
                description = "Sets a netprop to the specified boolean."
            }
            SetPropBoolArray = {
                info = "'void SetPropBoolArray(handle ''entity'', string ''property_name'', bool ''value'', int ''array_element'')'"
                args = 4
                description = "Sets a netprop from an array to the specified boolean."
            }
            SetPropEntity = {
                info = "'void SetPropEntity(handle ''entity'', string ''property_name'', handle ''value'')'"
                args = 3
                description = "Sets an EHANDLE-valued netprop (21 bit integer) to reference the specified entity."
            }
            SetPropEntityArray = {
                info = "'void SetPropEntityArray(handle ''entity'', string ''property_name'', handle ''value'', int ''array_element'')'"
                args = 4
                description = "Sets an EHANDLE-valued netprop (21 bit integer) from an array to reference the specified entity."
            }
            SetPropFloat = {
                info = "'void SetPropFloat(handle ''entity'', string ''property_name'', float ''value'')'"
                args = 3
                description = "Sets a netprop to the specified float."
            }
            SetPropFloatArray = {
                info = "'void SetPropFloatArray(handle ''entity'', string ''property_name'', float ''value'', int ''array_element'')'"
                args = 4
                description = "Sets a netprop from an array to the specified float."
            }
            SetPropInt = {
                info = "'void SetPropInt(handle ''entity'', string ''property_name'', int ''value'')'"
                args = 3
                description = "Sets a netprop to the specified integer."
                warning = ["Do not override 'm_iTeamNum' netprops on players or Engineer buildings permanently. Use 'ForceChangeTeam' or 'SetTeam' or respectively. Not doing so will result in unpredictable server crashes later on. Overriding m_iTeamNum temporarily and then reverting it in the same frame is safe however."]
            }
            SetPropIntArray = {
                info = "'void SetPropIntArray(handle ''entity'', string ''property_name'', int ''value'', int ''array_element'')'"
                args = 4
                description = "Sets a netprop from an array to the specified integer."
            }
            SetPropString = {
                info = "'void SetPropString(handle ''entity'', string ''property_name'', string ''value'')'"
                args = 3
                description = "Sets a netprop to the specified string."
            }
            SetPropStringArray = {
                info = "'void SetPropStringArray(handle ''entity'', string ''property_name'', string ''value'', int ''array_element'')'"
                args = 4
                description = "Sets a netprop from an array to the specified string."
            }
            SetPropVector = {
                info = "'void SetPropVector(handle ''entity'', string ''property_name'', Vector ''value'')'"
                args = 3
                description = "Sets a netprop to the specified vector."
            }
            SetPropVectorArray = {
                info = "'void SetPropVectorArray(handle ''entity'', string ''property_name'', Vector ''value'', int ''array_element'')'"
                args = 4
                description = "Sets a netprop from an array to the specified vector."
            }
        }
        CScriptEntityOutputs = {
            AddOutput = {
                info = "'void AddOutput(handle ''entity'', string ''output_name'', string ''targetname'', string ''input_name'', string ''parameter'', float ''delay'', int ''times_to_fire'')'"
                args = 7
                description = "Adds a new output to the entity."
            }
            GetNumElements = {
                info = "'int GetNumElements(handle ''entity'', string ''output_name'')'"
                args = 2
                description = "Returns the number of array elements."
            }
            GetOutputTable = {
                info = "'void GetOutputTable(handle ''entity'', string ''output_name'', table, int ''array_element'')'"
                args = 4
                description = "Fills the passed table with output information."
            }
            HasAction = {
                info = "'bool HasAction(handle ''entity'', string ''output_name'')'"
                args = 2
                description = "Returns true if an action exists for the output."
            }
            HasOutput = {
                info = "'bool HasOutput(handle ''entity'', string ''output_name'')'"
                args = 2
                description = "Returns true if the output exists."
            }
            RemoveOutput = {
                info = "'void RemoveOutput(handle ''entity'', string ''output_name'', string ''targetname'', string ''input_name'', string ''parameter'')'"
                args = 5
                description = "Removes an output from the entity."
                note = ["The order of the internal output data may change after this is performed, which can be problematic if iterating outputs. As a workaround, all the outputs can be stored in an array of tables first and then removed while iterating the array."]
            }
        }
        CScriptKeyValues = {
            FindKey = {
                info = "'CScriptKeyValues FindKey(string ''key'')'"
                args = 1
                description = "Find a sub key by the key name."
            }
            GetFirstSubKey = {
                info = "'CScriptKeyValues GetFirstSubKey()'"
                args = 0
                description = "Return the first sub key object."
            }
            GetKeyBool = {
                info = "'bool GetKeyBool(string ''key'')'"
                args = 1
                description = "Return the key value as a bool."
            }
            GetKeyFloat = {
                info = "'float GetKeyFloat(string ''key'')'"
                args = 1
                description = "Return the key value as a float."
            }
            GetKeyInt = {
                info = "'int GetKeyInt(string ''key'')'"
                args = 1
                description = "Return the key value as an integer."
            }
            GetKeyString = {
                info = "'string GetKeyString(string ''key'')'"
                args = 1
                description = "Return the key value as a string."
            }
            GetNextKey = {
                info = "'CScriptKeyValues GetNextKey()'"
                args = 0
                description = "Return the next neighbor key object to the one the method is called on."
            }
            IsKeyEmpty = {
                info = "'bool IsKeyEmpty(string ''key'')'"
                args = 1
                description = "Returns true if the named key has no value."
            }
            IsValid = {
                info = "'bool IsValid()'"
                args = 0
                description = "Whether the handle belongs to a valid key."
            }
            ReleaseKeyValues = {
                info = "'void ReleaseKeyValues()'"
                args = 0
                description = "Releases the contents of the instance."
            }
        }
        CPlayerVoiceListener = {
            GetPlayerSpeechDuration = {
                info = "'float GetPlayerSpeechDuration(int ''player_index'')'"
                args = 1
                description = "Returns the number of seconds the player has been continuously speaking."
            }
            IsPlayerSpeaking = {
                info = "'bool IsPlayerSpeaking(int ''player_index'')'"
                args = 1
                description = "Returns whether the player specified is speaking."
            }
        }
        CEnvEntityMaker = {
            SpawnEntity = {
                info = "'void SpawnEntity()'"
                args = 0
                description = "Create an entity at the location of the maker."
            }
            SpawnEntityAtEntityOrigin = {
                info = "'void SpawnEntityAtEntityOrigin(handle ''entity'')'"
                args = 1
                description = "Create an entity at the location of a specified entity instance."
            }
            SpawnEntityAtLocation = {
                info = "'void SpawnEntityAtLocation(Vector ''origin'', Vector ''orientation'')'"
                args = 2
                description = "Create an entity at a specified location and orientation, orientation is Euler angle in degrees (pitch, yaw, roll)."
            }
            SpawnEntityAtNamedEntityOrigin = {
                info = "'void SpawnEntityAtNamedEntityOrigin(string ''targetname'')'"
                args = 1
                description = "Create an entity at the location of a named entity. If multiple entities have the same name, only the one with the lowest entity index will be targeted."
            }
        }
        CFuncTrackTrain = {
            GetFuturePosition = {
                info = "'Vector GetFuturePosition(float ''x'', float ''speed'')'"
                args = 2
                description = "Get a position on the track X seconds in the future."
            }
        }
        CPointScriptTemplate = {
            AddTemplate = {
                info = "'void AddTemplate(string ''classname'', table ''keyvalues'')'"
                args = 2
                description = "Add an entity with the given keyvalues to the template spawner, similar to 'SpawnEntityFromTable'. The number of templates allowed is unlimited."
            }
            SetGroupSpawnTables = {
                info = "'void SetGroupSpawnTables(table ''group'', table ''spawn'')'"
                args = 2
                description = "Unused. This only stores a reference to the two tables which is removed when the {{ent|point_script_template}} is deleted."
            }
        }
        CSceneEntity = {
            AddBroadcastTeamTarget = {
                info = "'void AddBroadcastTeamTarget(int ''index'')'"
                args = 1
                description = "Adds a team (by index) to the broadcast list."
            }
            EstimateLength = {
                info = "'float EstimateLength()'"
                args = 0
                description = "Returns length of this scene in seconds."
            }
            FindNamedEntity = {
                info = "'handle FindNamedEntity(string ''reference'')'"
                args = 1
                description = "Given an entity reference, such as !target, get actual entity from scene object."
            }
            IsPaused = {
                info = "'bool IsPaused()'"
                args = 0
                description = "If this scene is currently paused."
            }
            IsPlayingBack = {
                info = "'bool IsPlayingBack()'"
                args = 0
                description = "If this scene is currently playing."
            }
            LoadSceneFromString = {
                info = "'bool LoadSceneFromString(string ''scene_name'', string ''scene'')'"
                args = 2
                description = "Given a dummy scene name and a vcd string, load the scene."
            }
            RemoveBroadcastTeamTarget = {
                info = "'void RemoveBroadcastTeamTarget(int ''index'')'"
                args = 1
                description = "Removes a team (by index) from the broadcast list."
            }
        }
        CCallChainer = {
            constructor = {
                info = "'CCallChainer(string ''function_prefix'', table ''scope'' = null)'"
                args = 2
                description = "Creates a CCallChainer object that'll collect functions that have a matching prefix in the given scope."
            }
            PostScriptExecute = {
                info = "'void PostScriptExecute()'"
                args = 0
                description = "Search for all non-native functions with matching prefixes, then push them into the 'chains' table."
            }
            Call = {
                info = "'bool Call(string ''event'', any ...)'"
                args = 2
                description = "Find an unprefixed function name in the 'chains' table and call it with the given arguments."
            }
            chains = {
                info = "'table'"
                args = 0
                description = "Contains names of unprefixed functions, each with an array of functions to call."
            }
            prefix = {
                info = "'string'"
                args = 0
                description = "Prefix that functions should have to be added into the 'chains' table. Set by the constructor."
            }
            scope = {
                info = "'table'"
                args = 0
                description = "If set, seek functions in this scope instead. Set by the constructor."
            }
        }
        CSimpleCallChainer = {
            constructor = {
                info = "'CSimpleCallChainer(string ''prefix'', table ''scope'' = null, ''exactMatch'' = false)'"
                args = 3
                description = "Creates a CSimpleCallChainer object that'll collect functions that have a matching prefix in the given scope, unless it seek for an exact name match."
            }
            PostScriptExecute = {
                info = "'void PostScriptExecute()'"
                args = 0
                description = "Begin searching for all non-native functions with matching prefixes, then push them into the 'chain' array."
            }
            Call = {
                info = "'bool Call(any ...)'"
                args = 1
                description = "Call all functions inside the 'chain' array with the given arguments."
            }
            chain = {
                info = "'array'"
                args = 0
                description = "All functions to be called by the 'Call()' method."
            }
            exactMatch = {
                info = "'bool'"
                args = 0
                description = "If set, names of non-native functions and 'prefix' must be an exact match.  Set by the constructor."
            }
            prefix = {
                info = "'string'"
                args = 0
                description = "Prefix that functions should have to be added into the 'chain' array. Set by the constructor."
            }
            scope = {
                info = "'table'"
                args = 0
                description = "If set, seek functions in this scope instead. Set by the constructor."
            }
        }
        Vector = {
            constructor = {
                info = "'Vector(float ''x'' = 0.0, float ''y'' = 0.0, float ''z'' = 0.0)'"
                args = 3
                description = "Creates a new vector with the specified Cartesian coordiantes."
            }
            Cross = {
                info = "'Vector Cross(Vector ''factor'')'"
                args = 1
                description = "The vector product of two vectors. Returns a vector orthogonal to the input vectors."
            }
            Dot = {
                info = "'float Dot(Vector ''factor'')'"
                args = 1
                description = "The scalar product of two vectors."
            }
            Length = {
                info = "'float Length()'"
                args = 0
                description = "Magnitude of the vector."
            }
            LengthSqr = {
                info = "'float LengthSqr()'"
                args = 0
                description = "The magnitude of the vector squared."
                tip = ["This can be used to quickly check if the vector is equal to 0 0 0, by checking if the magnitude is 0."]
            }
            Length2D = {
                info = "'float Length2D()'"
                args = 0
                description = "Returns the magnitude of the vector on the x-y plane."
            }
            Length2DSqr = {
                info = "'float Length2DSqr()'"
                args = 0
                description = "Returns the square of the magnitude of the vector on the x-y plane."
            }
            Norm = {
                info = "'float Norm()'"
                args = 0
                description = "Normalizes the vector in place and returns it's length."
            }
            Scale = {
                info = "'Vector Scale(float ''factor'')'"
                args = 1
                description = "Scales the vector magnitude."
            }
            ToKVString = {
                info = "'string ToKVString()'"
                args = 0
                description = "Returns a string without separations commas."
            }
            tostring = {
                info = "'string tostring()'"
                args = 0
                description = "Returns a human-readable string."
            }
            x = {
                info = "'float'"
                args = 0
                description = "Cartesian X axis."
            }
            y = {
                info = "'float'"
                args = 0
                description = "Cartesian Y axis."
            }
            z = {
                info = "'float'"
                args = 0
                description = "Cartesian Z axis."
            }
        }
        QAngle = {
            constructor = {
                info = "'QAngle(float ''pitch'' = 0.0, float ''yaw'' = 0.0, float ''roll'' = 0.0)'"
                args = 3
                description = "Creates a new QAngle."
            }
            Left = {
                info = "'Vector Left()'"
                args = 0
                description = ""
                note = ["Returns the ''right'' Vector of the angles."]
            }
            Pitch = {
                info = "'float Pitch()'"
                args = 0
                description = "Returns the pitch angle in degrees."
            }
            Roll = {
                info = "'float Roll()'"
                args = 0
                description = "Returns the roll angle in degrees."
            }
            ToKVString = {
                info = "'string ToKVString()'"
                args = 0
                description = "Returns a string with the values separated by one space."
            }
            ToQuat = {
                info = "'Quaternion ToQuat()'"
                args = 0
                description = "Returns a quaternion representaion of the orientation."
            }
            Up = {
                info = "'Vector Up()'"
                args = 0
                description = "Returns the Up Vector of the angles."
            }
            Yaw = {
                info = "'float Yaw()'"
                args = 0
                description = "Returns the yaw angle in degrees."
            }
            x = {
                info = "'float'"
                args = 0
                description = "Pitch in degrees."
            }
            y = {
                info = "'float'"
                args = 0
                description = "Yaw in degrees."
            }
            z = {
                info = "'float'"
                args = 0
                description = "Roll in degrees."
            }
        }
        Quaternion = {
            constructor = {
                info = "'Quaternion(float ''x'', float ''y'' = 0.0, float ''z'' = 0.0, float ''w'' = 0.0)'"
                args = 4
                description = "Creates a new quaternion of the form '''w'' + ''x'''''i''' + ''y'''''j''' + ''z'''''k''''."
            }
            Dot = {
                info = "'float Dot(Quaternion ''factor'')'"
                args = 1
                description = "The 4D scalar product of two quaternions. represents the angle between the quaternions in the range [1, 0]."
            }
            Invert = {
                info = "'Quaternion Invert()'"
                args = 0
                description = "Returns a quaternion with the complimentary rotation."
            }
            Norm = {
                info = "'float Norm()'"
                args = 0
                description = "Normalizes the quaternion."
            }
            SetPitchYawRoll = {
                info = "'void SetPitchYawRoll(float ''pitch'', float ''yaw'', float ''roll'')'"
                args = 3
                description = "Recomputes the quaternion from the supplied Euler angles."
            }
            ToKVString = {
                info = "'string ToKVString()'"
                args = 0
                description = "Returns a string with the values separated by one space."
            }
            ToQAngle = {
                info = "'QAngle ToQAngle()'"
                args = 0
                description = "Returns the angles resulting from the rotation."
            }
            x = {
                info = "'float'"
                args = 0
                description = "Vector component along the '''i''' axis."
            }
            y = {
                info = "'float'"
                args = 0
                description = "Vector component along the '''j''' axis."
            }
            z = {
                info = "'float'"
                args = 0
                description = "Vector component along the '''k''' axis."
            }
            w = {
                info = "'float'"
                args = 0
                description = "Scalar part."
            }
        }
        Globals = {
            AddThinkToEnt = {
                info = "'void AddThinkToEnt(handle ''entity'', string ''function_name'')'"
                args = 2
                description = ""
                note = [
                    "If trying to clear a think function while inside a think function, 'AddThinkToEnt' will not work as the think function is restored on the entity after it's finished. <br>'NetProps.SetPropString(self, \"m_iszScriptThinkFunction\", \"\")' must be used to remove the think function. {{warning|This can apply to events if they are chained from a think function, for example killing a player with 'TakeDamage' and then trying to clear the think function in 'player_death' event. The think function will not be cleared unless the line above is also added."
                    "Some entities are sensitive to when this think function executes within a frame. A notable example is modifying the [[tf_player_manager]] entity. The think function must be applied to the manager entity for netprop changes to work correctly, and not any other entity, otherwise modifying its properties will be inconsistent."
                ]
                bug = ["hidetested=1|The think function name stored in the entity is not reset if null is passed as the function name. However this is harmless, and it will only show a warning in console."]
                warning = ["Entities with 'EFL_KILLME' and/or 'EFL_NO_THINK_FUNCTION' entity flags set do not process thinks."]
            }
            AddToScriptHelp = {
                info = "'void AddToScriptHelp(table ''help'')'"
                args = 1
                description = ""
            }
            Assert = {
                info = "'void Assert(bool ''value'', string ''optional_message'' = null)'"
                args = 2
                description = "Test value and if not true, throws exception, optionally with message."
            }
            ClearGameEventCallbacks = {
                info = "'void ClearGameEventCallbacks()'"
                args = 0
                description = "Empties the tables of game event callback functions. {{deprecated|'''Do NOT use this!''' It removes all events, including those from other scripts, and is a common source of script conflicts. Instead, update your event code to use a namespace (define and contain your callback functions inside of a table), which will clean up automatically when this table is removed without interfering with other scripts. Refer to the [[Source_SDK_Base_2013/Scripting/VScript_Examples#Listening_for_Events|examples page]] and expand the example for Team Fortress 2 for guidance on how to set an automatic system for this.}}"
            }
            CreateProp = {
                info = "'CBaseAnimating CreateProp(string ''classname'', Vector ''origin'', string ''model_name'', int ''activity'')'"
                args = 4
                description = "Create a prop."
            }
            CreateSceneEntity = {
                info = "'CBaseAnimating CreateSceneEntity(string ''scene'')'"
                args = 1
                description = "Create a scene entity to play the specified scene."
            }
            developer = {
                info = "'int developer()'"
                args = 0
                description = "The current level of the 'developer' console variable."
            }
            DispatchParticleEffect = {
                info = "'void DispatchParticleEffect(string ''name'', Vector ''origin'', Vector ''direction'')'"
                args = 3
                description = ""
                note = ["For more control over particles such as parenting them to entities, see the [[Source_SDK_Base_2013/Scripting/VScript_Examples#Spawning_a_Particle|examples page]] for alternative methods."]
                warning = [
                    "Does NOT work if called from a player think or OnTakeDamage caused by hitscan/melee due to [[prediction]] suppressing it. Can be workarounded by spawning the particle with a 0 delayed EntFire or spawning [[info_particle_system]] entity"
                    "This does not precache custom particles. As a result, custom particles may show as a burst of red Xs instead on dedicated servers. To precache a particle, use the following function: {{ExpandBox|<source lang=js> function PrecacheParticle(name) { PrecacheEntityFromTable({ classname = \"info_particle_system\", effect_name = name }) } </source>"
                ]
            }
            Document = {
                info = "'void Document(unknown ''symbol_or_table'', unknown ''item_if_symbol'' = null, string ''description_if_symbol'' = null)'"
                args = 3
                description = ""
            }
            DoEntFire = {
                info = "'void DoEntFire(string ''target'', string ''action'', string ''value'', float ''delay'', handle ''activator'', handle ''caller'')'"
                args = 6
                description = "Generate an entity I/O event. The ''caller'' and ''activator'' argument takes a ''CBaseEntity'' script handle, and entities assigned can receive inputs with ''target'' set to ''!self'', or ''!activator'' / ''!caller''. Negative delays are clamped to 0."
                note = ["Does not work if the ''target'' string is 'point_servercommand'."]
            }
            DoIncludeScript = {
                info = "'bool DoIncludeScript(string ''file'', handle/table ''scope'')'"
                args = 2
                description = "Execute a script and put all its content for the argument passed to the'''scope'''parameter. The file must have the '.nut' extension."
                warning = ["Do not put uppercase letters in the path, doing so will cause Linux to fail loading the script from loose directories."]
            }
            IncludeScript = {
                info = "'bool IncludeScript(string ''file'', table ''scope'' = null)'"
                args = 2
                description = "Wrapper for DoIncludeScript."
            }
            EmitAmbientSoundOn = {
                info = "'void EmitAmbientSoundOn(string ''sound_name'', float ''volume'', int ''soundlevel'', int ''pitch'', handle ''entity'')'"
                args = 5
                description = "Play named sound on an entity using configurations similar to [[ambient_generic]]. Soundlevel is in decibels, see [[Soundscripts#SoundLevel|this page]] for real world equivalents."
                tip = [
                    "Sounds may be hard to hear even at full volume. Naming custom sounds according to the [[soundmixer]] can be used to make them naturally louder."
                    "To convert radius in Hammer units to decibels (similar to [[ambient_generic]]), use the following formula: <source lang=js> local soundlevel = (40 + (20 * log10(radius / 36.0))).tointeger() </source>"
                ]
            }
            StopAmbientSoundOn = {
                info = "'void StopAmbientSoundOn(string ''sound_name'', handle ''entity'')'"
                args = 2
                description = "Stop named sound on an entity using configurations similar to [[ambient_generic]]."
            }
            EmitSoundOn = {
                info = "'void EmitSoundOn(string ''sound_script'', handle ''entity'')'"
                args = 2
                description = "Play named sound on given entity. The sound must be precached first for it to play (using 'PrecacheSound' or 'PrecacheScriptSound')."
                warning = ["Looping sounds will not stop on the entity when it's destroyed and will persist forever! To workaround this, run 'StopSound' in the 'OnDestroy' callback."]
            }
            StopSoundOn = {
                info = "'void StopSoundOn(string ''sound_script'', handle ''entity'')'"
                args = 2
                description = "Stop named sound on an entity."
            }
            EmitSoundOnClient = {
                info = "'void EmitSoundOnClient(string ''sound_script'', handle ''player'')'"
                args = 2
                description = "Play named sound only on the client for the specified player. The sound must be precached first for it to play ('PrecacheScriptSound')."
                note = ["This only supports soundscripts."]
            }
            EntFire = {
                info = "'void EntFire(string ''target'', string ''action'', string ''value'' = null, float ''delay'' = 0, handle ''activator'' = null)'"
                args = 5
                description = "Wrapper for DoEntFire() that sets'''activator''' to null, but has no'''caller'''param. Negative delays are clamped to 0."
                note = ["Does not work if the ''target'' string is 'point_servercommand'."]
            }
            EntFireByHandle = {
                info = "'void EntFireByHandle(handle ''entity'', string ''action'', string ''value'', float ''delay'', handle ''activator'', handle ''caller'')'"
                args = 6
                description = ""
                note = ["With a 0 delay, this will be processed at the end of the frame rather than instantly. If you need an instant, synchronous I/O event then use 'AcceptInput' instead."]
                warning = ["Calling 'RunScriptCode' input will add the value provided to the string table. If your code uses a big range of distinct values provided to this input (for example passing a float like timestamp) the string table will eventually exceed it's limit of 65k strings causing the server to crash (CUtlRBTree overflow). To prevent this issue from occurring you can use custom delay function, such as the one implemented in [[Source_2013_MP/Scripting/VScript_Examples#EntFire(ByHandle)|Source SDK 2013 VScript Examples]]. {{note|This also affects 'SetText' input on [[game_text]], but accounting for it is not as vital."]
            }
            EntIndexToHScript = {
                info = "'handle EntIndexToHScript(int ''entindex'')'"
                args = 1
                description = "Turn an entity index integer to an HScript representing that entity's script instance."
            }
            FileToString = {
                info = "'string FileToString(string ''file'')'"
                args = 1
                description = "Reads a string from file located in the game's ''scriptdata'' folder. Returns the string from the file, null if no file or file is greater than 16384 bytes."
                note = [
                    "Files packed inside the [[BSP]] cannot be read."
                    "This opens files in text mode, therefore binary files will not be parsed correctly."
                ]
            }
            FindCircularReference = {
                info = "'FindCircularReference()'"
                args = 0
                description = ""
            }
            FindCircularReferences = {
                info = "'FindCircularReferences()'"
                args = 0
                description = ""
            }
            FireGameEvent = {
                info = "'bool FireGameEvent(string ''name'', table ''params'')'"
                args = 2
                description = "Fire a game event to a listening callback function in script. Parameters are passed in a squirrel table."
                note = ["The name might be misleading. This does not fire an event that the game will pick up, the function that sends a real game event is named 'SendGlobalGameEvent'."]
            }
            FireScriptHook = {
                info = "'bool FireScriptHook(string ''name'', table ''params'')'"
                args = 2
                description = "Fire a script hook to a listening callback function in script. Parameters are passed in a squirrel table."
            }
            FireScriptEvent = {
                info = "'void FireScriptEvent(string ''event'', table ''params'')'"
                args = 2
                description = "Wrapper for '__RunEventCallbacks()'."
            }
            FrameTime = {
                info = "'float FrameTime()'"
                args = 0
                description = "Get the time spent on the server in the last frame. Usually this will be 0.015 (the default tickrate)."
            }
            GetDeveloperLevel = {
                info = "'int GetDeveloperLevel()'"
                args = 0
                description = "Gets the level of 'developer'"
            }
            GetFrameCount = {
                info = "'int GetFrameCount()'"
                args = 0
                description = "Returns the engines current frame count. The counter does not reset between map changes. This is NOT the tick count."
                tip = ["To get the current tick count, read the 'm_nSimulationTick' netprop from any player or moving entity."]
            }
            GetFriction = {
                info = "'float GetFriction(CTFPlayer ''player'')'"
                args = 1
                description = "Returns the Friction on a player entity, meaningless if not a player."
            }
            GetFunctionSignature = {
                info = "'string GetFunctionSignature(function ''func'', string ''prefix'')'"
                args = 2
                description = ""
            }
            GetListenServerHost = {
                info = "'CTFPlayer GetListenServerHost()'"
                args = 0
                description = "Get the local player on a listen server. Returns null on dedicated servers."
                note = ["This depends on the player entity, and therefore this might return null on a listen server if the player doesn't exist yet during map load. Use 'IsDedicatedServer' instead to check if the server is a listen or dedicated server, as it checks it in a different way."]
                tip = ["Alternatively, use 'PlayerInstanceFromIndex(1)' to fetch the first player on the server. For convenience sake (e.g. for script compatibility), you can map this to that function using the following: <source lang=js> ::GetListenServerHost <- @() PlayerInstanceFromIndex(1) </source>"]
            }
            GetMapName = {
                info = "'string GetMapName()'"
                args = 0
                description = "Get the name of the map without extension, e.g. 'ctf_2fort'. For workshop maps, this will be in the format 'workshop/[name].ugc[id]'."
            }
            GetModelIndex = {
                info = "'int GetModelIndex(string ''model_name'')'"
                args = 1
                description = "Returns the index of the named model."
            }
            GetPlayerFromUserID = {
                info = "'CTFPlayer GetPlayerFromUserID(int ''userid'')'"
                args = 1
                description = "Given a user id, return the entity, or null."
                note = ["The 'fake' [[SourceTV]] player will always be returned as null. If you need to actually retrieve the SourceTV player, use 'EntIndexToHScript'."]
                tip = ["For the opposite, getting the user id from an entity, see the [[Source_SDK_Base_2013/Scripting/VScript_Examples#Getting_the_userid_from_a_player_handle|examples page]]."]
            }
            GetSoundDuration = {
                info = "'float GetSoundDuration(string ''sound_name'', string ''actor_model_name'')'"
                args = 2
                description = ""
                todo = ["Actor model name is likely a leftover from {{hl2|2"]
                warning = ["Does not work on dedicated servers as they do not have audio libraries built-in to load sounds."]
            }
            IsDedicatedServer = {
                info = "'bool IsDedicatedServer()'"
                args = 0
                description = "Returns true if this server is a dedicated server."
            }
            IsModelPrecached = {
                info = "'bool IsModelPrecached(string ''model_name'')'"
                args = 1
                description = "Checks if the ''model_name'' is precached."
            }
            IsSoundPrecached = {
                info = "'bool IsSoundPrecached(string ''sound_name'')'"
                args = 1
                description = "Checks if the ''sound_name'' is precached."
            }
            IsPlayerABot = {
                info = "'bool IsPlayerABot(CTFPlayer ''player'')'"
                args = 1
                description = "Is this player/entity a puppet or AI bot. To check if the player is a AI bot ('CTFBot') specifically, use 'IsBotOfType' instead."
            }
            IsWeakref = {
                info = "'bool IsWeakref()'"
                args = 0
                description = ""
            }
            LocalTime = {
                info = "'void LocalTime(table ''result'')'"
                args = 1
                description = "Fills out a table with the local time (second, minute, hour, day, month, year, dayofweek, dayofyear, daylightsavings). This mirrors the 'tm' structure in C++, see the [https://cplusplus.com/reference/ctime/tm/ reference page] for more information."
                warning = ["The month will be 1-12 rather than 0-11."]
            }
            MakeNamespace = {
                info = "'MakeNamespace()'"
                args = 0
                description = ""
            }
            MaxClients = {
                info = "'float MaxClients()'"
                args = 0
                description = "Get the current number of max clients set by the maxplayers command."
                bug = ["hidetested=1|The return value is mistakenly defined as a float. It is best to use '.tointeger()' after calling this."]
            }
            PickupObject = {
                info = "'void PickupObject(CTFPlayer ''player'', handle ''entity'')'"
                args = 2
                description = ""
                note = ["Does nothing in {{tf2|2"]
            }
            PlayerInstanceFromIndex = {
                info = "'CTFPlayer PlayerInstanceFromIndex(int ''index'')'"
                args = 1
                description = "Get a script handle of a player using the player index."
                note = ["The 'fake' [[SourceTV]] player will always be returned as null. If you need to actually retrieve the SourceTV player, use 'EntIndexToHScript'."]
            }
            PrecacheEntityFromTable = {
                info = "'bool PrecacheEntityFromTable(table ''keyvalues'')'"
                args = 1
                description = "Precache an entity from [[KeyValues]] in a table. Internally this function creates the entity, fire 'DispatchSpawn' and removes it instantly. Returns false if the table has no ''classname'' key, if the value of ''classname'' is null or empty, or if the entity failed to be created."
                tip = ["Can be used  to precache gibs for a model on any entity by using [[tf_generic_bomb]]. Example: <source>PrecacheEntityFromTable({ classname = \"tf_generic_bomb\", model = MODEL_NAME })</source>"]
            }
            PrecacheModel = {
                info = "'int PrecacheModel(string ''model_name'')'"
                args = 1
                description = "Precache a model ('.mdl') or sprite ('.vmt') and return model index. The extension must be specified. Returns -1 if null or empty ''model_name'' is passed in. Missing models/sprites will still return a new index."
                note = ["Does not precache gibs. See 'PrecacheEntityFromTable' instead."]
            }
            PrecacheScriptSound = {
                info = "'bool PrecacheScriptSound(string ''sound_name'')'"
                args = 1
                description = "Precache a soundscript. Returns false if soundscript is missing, or if a null or empty sound name is passed in."
            }
            PrecacheSound = {
                info = "'bool PrecacheSound(string ''sound_name'')'"
                args = 1
                description = "Precache a raw sound. Returns false if a null or empty sound name is passed in."
            }
            PrintHelp = {
                info = "'void PrintHelp()'"
                args = 0
                description = "Equivalent to running 'script_help' command."
            }
            RandomFloat = {
                info = "'float RandomFloat(float ''min'', float ''max'')'"
                args = 2
                description = "Generate a random floating-point number within a range, inclusive."
            }
            RandomInt = {
                info = "'int RandomInt(int ''min'', int ''max'')'"
                args = 2
                description = "Generate a random integer within a range, inclusive."
            }
            RegisterFunctionDocumentation = {
                info = "'void RegisterFunctionDocumentation(function ''func'', string ''name'', string ''signature'', string ''description'')'"
                args = 4
                description = ""
            }
            RegisterScriptGameEventListener = {
                info = "'void RegisterScriptGameEventListener(string ''event_name'')'"
                args = 1
                description = "Register as a listener for a game event from script. It's what '__CollectGameEventCallbacks()' uses to register event callbacks to the C++ code."
                note = ["This cannot be used to register non-existent game events."]
            }
            RegisterScriptHookListener = {
                info = "'void RegisterScriptHookListener(string ''name'')'"
                args = 1
                description = "Register as a listener for a script hook from script."
            }
            RetrieveNativeSignature = {
                info = "'string RetrieveNativeSignature(function ''func'')'"
                args = 1
                description = ""
            }
            RotateOrientation = {
                info = "'QAngle RotateOrientation(QAngle ''initial'', QAngle ''rotation'')'"
                args = 2
                description = "Rotate a QAngle by another QAngle."
            }
            RotatePosition = {
                info = "'Vector RotatePosition(Vector ''origin'', QAngle ''rotation'', Vector ''input'')'"
                args = 3
                description = "Rotate the input Vector around an origin."
                bug = ["hidetested=1|This is not calculated correctly and the rotation will always be relative to (0, 0, 0). As a workaround, subtract the origin from the input, call this function and then add the origin back which will perform the expected result."]
            }
            ScreenFade = {
                info = "'void ScreenFade(CTFPlayer ''player'', int ''red'', int ''green'', int ''blue'', int ''alpha'', float ''fade_time'', float ''fade_hold'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#FFADE|FFADE]] ''flags'')'"
                args = 8
                description = "Start a customisable screenfade. If no player is specified, the fade will apply to all players."
            }
            ScreenShake = {
                info = "'void ScreenShake(Vector ''center'', float ''amplitude'', float ''frequency'', float ''duration'', float ''radius'', [[Team_Fortress_2/Scripting/Script_Functions/Constants#SHAKE_COMMAND|SHAKE_COMMAND]] ''command'', bool ''air_shake'')'"
                args = 7
                description = "Start a customisable screenshake. Set ''command'' to 0 to start a shake, or 1 to stop an existing shake. ''air_shake'' determines whether the airborne players should be affected by the shake as well."
            }
            ScriptHooksEnabled = {
                info = "'bool ScriptHooksEnabled()'"
                args = 0
                description = "Returns whether script hooks are currently enabled."
            }
            SendGlobalGameEvent = {
                info = "'bool SendGlobalGameEvent(string ''event_name'', table ''params'')'"
                args = 2
                description = ""
                warning = [
                    "Certain events that are usually clientside only will not work when fired by this function, with an error complaining that \"no listeners are registered for this event\". However, defining an empty event listener will make it work."
                    "Events that upload statistics to Steam servers such as 'player_escort_score' can take as long as 1 millisecond to execute! This can be prevented by temporarily giving the player the 'FL_FAKECLIENT' flag and reverting it afterwards (however be careful not to revert it on actual bots!). Example: {{ExpandBox|<source lang=js> local is_bot = player.IsFakeClient() if (!is_bot) player.AddFlag(Constants.FPlayer.FL_FAKECLIENT) SendGlobalGameEvent(\"player_escort_score\", { player = player.entindex(), points = 1 }) if (!is_bot) player.RemoveFlag(Constants.FPlayer.FL_FAKECLIENT) </source>"
                ]
            }
            SendToConsole = {
                info = "'void SendToConsole(string ''command'')'"
                args = 1
                description = "Issues a command to the local client, as if they typed in the command in their console. Does nothing on dedicated servers."
            }
            SendToServerConsole = {
                info = "'void SendToServerConsole(string ''command'')'"
                args = 1
                description = ""
                note = ["This obeys the behavior of the 'sv_allow_point_servercommand' convar. By default, this command will do nothing unless the server has this command to set to \"always\" {{todo|using this on listen servers without allowing point_servercommand is seemingly inconsistent, check 'IsDedicatedServer()' and use 'SendToConsole' instead."]
            }
            SendToConsoleServer = {
                info = "'void SendToConsoleServer(string ''command'')'"
                args = 1
                description = "Copy of SendToServerConsole with another name for compat."
            }
            SetFakeClientConVarValue = {
                info = "'void SetFakeClientConVarValue(CTFBot ''bot'', string ''cvar'', string ''value'')'"
                args = 3
                description = "Sets a USERINFO client ConVar for a fakeclient."
                tip = ["This can be used to change the name of a bot by using the 'name' cvar."]
            }
            SetSkyboxTexture = {
                info = "'void SetSkyboxTexture(string ''texture'')'"
                args = 1
                description = "Sets the current skybox texture. The path is relative to \"materials/skybox/\". Only the main name of a skybox texture is needed, for example \"sky_gravel_01\"."
            }
            SpawnEntityFromTable = {
                info = "'handle SpawnEntityFromTable(string ''name'', table ''keyvalues'')'"
                args = 2
                description = "Spawn entity from KeyValues in table - 'name' is entity name, rest are KeyValues for spawn.    Example: {{ExpandBox|<source lang=js> SpawnEntityFromTable(\"logic_timer\", { targetname = \"cool\" RefireTime = 60 \"OnTimer#1\" : \"entity,Trigger,,0,-1\" \"OnTimer#2\" : \"somethingelse,Disable,,0,-1\" }) </source> }}"
                note = [
                    "Multiple keys of the same name can be specified by appending the key with an incremental #x suffix."
                    "'parentname' is not resolved and therefore will not work. Instead, fire 'AcceptInput' after spawning (with 'SetParent !activator' parameters), or use 'SpawnEntityGroupFromTable'."
                    "If using a complex model, usually custom models, it might cause stutters to the server when spawning it. To work around this issue instead spawn it with 'CreateByClassname' and set its netprops manually, and don't forget to make sure the model is precached properly too."
                ]
                tip = ["If spawning multiple entities at once, use 'SpawnEntityGroupFromTable' as it will be more efficient."]
                warning = ["If using commas inside the parameter field of a output key, it will not be parsed correctly as the comma will be treated as delimiter. To fix this, an special delimiter also supported by the game can be used named 'ESC'. This cannot be typed on a keyboard normally, and must be copied from another source. The easiest way is to [https://pastebin.com/raw/TaJ7pnVC open this link], and copy + paste the character in a supporting editor such as Notepad++.<br> Example (the character will not display correctly on this page):<br>'\"OnTrigger#5\": \"res,RunScriptCode,NetProps.SetPropString(self, `m_iszMvMPopfileName`, `test`),0,-1\"'<br>would instead be changed to<br> '\"OnTrigger#5\": \"res�RunScriptCode�NetProps.SetPropString(self, `m_iszMvMPopfileName`, `test`)�0�-1\"'"]
            }
            SpawnEntityGroupFromTable = {
                info = "'bool SpawnEntityGroupFromTable(table ''groups'')'"
                args = 1
                description = "Hierarchically spawn an entity group from a set of spawn tables. This computes a spawn order for entities so that parenting is resolved correctly. The table for this must take the following format. 'group' can be any name, as long as it's unique. Each group can only contain one entity. (The table is formatted like this as otherwise it wouldn't be possible to spawn multiple entities of the same classname). The function always returns true, even if entity spawning fails. <source lang=js> { <group> = { <classname> = { // key - values } }, // ... } </source> Example usage: {{ExpandBox|<source lang=js> SpawnEntityGroupFromTable( { a = { info_particle_system = { origin = GetListenServerHost().GetOrigin(), parentname = \"mytarget\", effect_name = \"soldierbuff_blue_soldier\", start_active = true } }, b = { info_particle_system = { origin = GetListenServerHost().GetOrigin(), parentname = \"mytarget\", effect_name = \"soldierbuff_red_soldier\", start_active = true } }, }) </source> }} }}"
                note = ["You will need to hijack an unused string netprop and set the bounding box data for brush entities there, then run a script on the entity to parse it. Example: {{ExpandBox| Make a script file named \"make_brush.nut\" that contains the following: <source lang=js> function OnPostSpawn() { local buf = split(NetProps.GetPropString(self, \"m_iszResponseContext\"), \" \") self.SetSize(Vector(buf[0], buf[1], buf[2]), Vector(buf[3], buf[4], buf[5])) self.SetSolid(2) } </source> Now you can set the min/max bounding box values for a brush ent directly in the ent key/values like so: <source lang=js> SpawnEntityGroupFromTable({ [0] = { func_rotating = { message = \"hl1/ambience/labdrone2.wav\", responsecontext = \"-1 -1 -1 1 1 1\", vscripts = \"make_brush\", volume = 8, targetname = \"crystal_spin\", spawnflags = 65, solidbsp = 0, rendermode = 10, rendercolor = \"255 255 255\", renderamt = 255, maxspeed = 48, fanfriction = 20, angles = QAngle(), origin = Vector(), } }, [1] = { trigger_multiple = { targetname = \"trigger1\", responsecontext = \"-250 -250 -250 250 250 250\", vscripts = \"make_brush\", parentname = \"crystal_spin\", spawnflags = 1, \"OnStartTouchAll#1\": \"!activator�RunScriptCode�ClientPrint(self, 3, `I am in trigger1`)�0�-1\", } }, [2] = { prop_dynamic = { targetname = \"crystal\", solid = 6, renderfx = 15, rendercolor = \"255 255 255\", renderamt = 255, physdamagescale = 1.0, parentname = \"crystal_spin\", modelscale = 1.3, model = \"models/props_moonbase/moon_gravel_crystal_blue.mdl\", MinAnimTime = 5, MaxAnimTime = 10, fadescale = 1.0, fademindist = -1.0, origin = Vector(), angles = QAngle(45, 0, 0) } }, }) </source>"]
                tip = ["If a list of entity handles created from this function is needed, there is two workarounds: *1 - Assign a 'vscripts' file that appends 'this' to a global array. *2 - Use a 'point_script_template', see the [[#CPointScriptTemplate|spawn hook example ↑]]."]
            }
            StringToFile = {
                info = "'void StringToFile(string ''file'', string ''string'')'"
                args = 2
                description = "Stores a string as a file, located in the game's ''scriptdata'' folder."
                warning = [
                    "Since this writes to the disk, the performance will vary depending on the hardware (i.e. HDD or SSD). This function should only be called at checkpoints such as round restart or before level change, and not during gameplay to prevent hitches."
                    "This writes files in text mode, therefore binary files will not be written correctly. As another consequence, if writing multi-line strings directly, this may cause issues due to Window's encoding new lines as \r\n, but Mac/Linux encodes as \n. This can be fixed by setting EOL (end-of-line) encoding to ''Unix'' or ''CR'' in your text editor."
                ]
                bug = ["hidetested=1|A single NULL byte will always be appended to the end of the file."]
            }
            Time = {
                info = "'float Time()'"
                args = 0
                description = "Get the current time since map load in seconds. The time resets on map change. The time may be different compared to the global time if running in the context of a player, such as a player think function or damage callback caused by a player. This adjustment is for [[lag compensation]] and may be up to 1 second ('sv_maxunlag'). Therefore use 'GetFrameCount' if you need to compare if events happened in the same tick."
            }
            TraceLine = {
                info = "'float TraceLine(Vector ''start'', Vector ''end'', handle ''ignore'')'"
                args = 3
                description = "Trace a ray. Return fraction along line that hits world or models. Optionally, ignore the specified entity."
                tip = ["Specify the same start and end point to check whether a point is inside solid geometry/out of bounds."]
            }
            TraceLinePlayersIncluded = {
                info = "'float TraceLinePlayersIncluded(Vector ''start'', Vector ''end'', handle ''ignore'')'"
                args = 3
                description = "Different version of 'TraceLine' that also hits players and NPCs."
            }
            UniqueString = {
                info = "'string UniqueString(string ''suffix'' = null)'"
                args = 1
                description = "Generate a string guaranteed to be unique across the life of the script VM, with an optional suffix. Useful for adding data to tables when not sure what keys are already in use in that table. The format of the string is '_%x%llx_%s', with arguments as follows: random number between 0 and 4095, an incrementing 64-bit counter, and ''suffix''."
            }
            DoUniqueString = {
                info = "'string DoUniqueString(string ''suffix'')'"
                args = 1
                description = "Internal function called by 'UniqueString'."
            }
            VSquirrel_OnCreateScope = {
                info = "'table VSquirrel_OnCreateScope(any ''value'', table ''scope'')'"
                args = 2
                description = "Creates a new scope with the name of value in the submitted table (includes unique params)."
            }
            VSquirrel_OnReleaseScope = {
                info = "'void VSquirrel_OnReleaseScope(table ''created_scope'')'"
                args = 1
                description = "Removes a scope created via VSquirrel_OnCreateScope."
            }
            __CollectEventCallbacks = {
                info = "'void __CollectEventCallbacks(scope, prefix, global_table_name, reg_func)'"
                args = 4
                description = "Overloaded function. Its only used for this: '__CollectEventCallbacks(scope, \"OnGameEvent_\", \"GameEventCallbacks\", ::RegisterScriptGameEventListener)'."
            }
            __CollectGameEventCallbacks = {
                info = "'void __CollectGameEventCallbacks(table ''scope'')'"
                args = 1
                description = "Wrapper that registers callbacks for both [[#Hooks|OnGameEvent_''x'' ↑]] and 'OnScriptEvent_' functions. Done using the '__CollectEventCallbacks' function."
            }
            __ReplaceClosures = {
                info = "'void __ReplaceClosures(script, scope)'"
                args = 2
                description = ""
            }
            __RunEventCallbacks = {
                info = "'void __RunEventCallbacks(event, params, prefix, global_table_name, bool warn_if_missing)'"
                args = 5
                description = "Call all functions in the callback array for the given game event."
            }
            __RunGameEventCallbacks = {
                info = "'void __RunGameEventCallbacks(event, params)'"
                args = 2
                description = "Wrapper for '__RunEventCallbacks()'."
            }
            __RunScriptHookCallbacks = {
                info = "'void __RunScriptHookCallbacks(event, param)'"
                args = 2
                description = ""
            }
        }
    }
}