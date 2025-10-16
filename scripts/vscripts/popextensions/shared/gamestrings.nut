// experimental standalone game string handler

/*************************************************************************************************************************************************************
 * PROBLEM:                                                                                                                                                  *
 * All entity access functions will add the entities scriptID and targetname to the string table                                                             *
 * Additionally, "param" arguments passed to Entity I/O related functions (AcceptInput, EntFire...) will add the param to the string table                   *
 * these strings don't get cleared until map change, eventually causing a CUtlRBTree overflow                                                                *
 * large amounts of rapid entity spawning, modifying, and Entity I/O calls (notably RunScriptCode) will overflow the string table faster                     *
 * freaky fair (and probably some other vscript-heavy maps) have this problem on 100 player servers, after ~40 minutes the server will crash with this error *
 *                                                                                                                                                           *
 * Scripters can largely workaround this issue by:                                                                                                           *
 * 1. setting NetProps.SetPropBool( ent, "m_bForcePurgeFixedUpStrings", true ) on all entities after they are spawned or modified/accessed in any way        *
 * 2. manually hooking and  purging the values passed to the following functions:                                                                            *
 *   - AcceptInput/EntFire/DoEntFire/EntFireByHandle's parameter argument                                                                                    *
 *   - KeyValueFromString                                                                                                                                    *
 *   - SetPropString                                                                                                                                         *
 * 3. constantly purge all targetname/script ID string entries for every entity in a think function to be extra certain.  The risk of doing this are unclear *
 *                                                                                                                                                           *
 * This script does all 3 of these at once, collecting as many strings as possible and batch deleting them in a constantly running generator/think function. *
 *                                                                                                                                                           *
 * It's been recommended by community members to NOT set this netprop until the entity is fully spawned                                                      *
 *  e.g. setting in OnPostSpawn() is safe, setting it in Precache() may break things                                                                         *
 *************************************************************************************************************************************************************/

POPEXT_CREATE_SCOPE( "__popext_gamestrings", "PopGameStrings", null, "PopGameStringsThink" )

local entio_funcs = [ "EntFireByHandle", "DoEntFire", "EntFire" ]

PopGameStrings.StringTable <- {}

if ( !( "_SpawnEntityFromTable" in ROOT ) )
    ::_SpawnEntityFromTable <- SpawnEntityFromTable

function PopGameStrings::_OnDestroy() {

    foreach ( func in entio_funcs ) {

        local copy_name = "_" + func
        ROOT[ func ] <- ROOT[ copy_name ]
        delete ROOT[ copy_name ]
    }

    local last_run = StringFixGenerator()

    while ( last_run.getstatus() != "dead" ) resume last_run

    ::SetPropString                  <- NetProps.SetPropString.bindenv( NetProps )
    ::SetPropStringArray             <- NetProps.SetPropStringArray.bindenv( NetProps )
    ::CBaseEntity.KeyValueFromString <- CBaseEntity.__KeyValueFromString.bindenv( CBaseEntity )

    if ( "_SpawnEntityFromTable" in ROOT ) {

        ::SpawnEntityFromTable <- _SpawnEntityFromTable
        // delete _SpawnEntityFromTable
    }
}

function PopGameStrings::AddStrings( ... ) {

    local arg_len = vargv.len()

    if ( arg_len == 1 && typeof vargv[0] == "array" )
        vargv = vargv[0]

    for ( local i = 0, str; i < arg_len; str = vargv[i], i += 2 ) {

        if ( !str || !( 0 in str ) )
            continue

        StringTable[ str ] <- null

        if ( i + 1 < arg_len )
            StringTable[ str ] = vargv[ i + 1 ]
    }
}

function PopGameStrings::PurgeString( str ) {

    if ( !str || !( 0 in str ) )
        return

    local temp = CreateByClassname( "logic_autosave" )
    SetPropString( temp, STRING_NETPROP_NAME, str )
    SetPropBool( temp, STRING_NETPROP_PURGESTRINGS, true )
    temp.Kill()

    if ( "StringTable" in this && str in StringTable )
        delete StringTable[ str ]
}

// function PopGameStrings::PurgeStringBatch( strings = {} ) {

//     function PurgeStringBatchPostSpawn() {

// 		foreach ( i, ent in ents ) {
//             printl( ent.GetName() )
// 			SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
// 			EntFireByHandle( ent, "Kill", "", i * 0.1, null, null )
// 		}
// 	}

// 	local template = PopExtUtil.PointScriptTemplate( null, PurgeStringBatchPostSpawn )

// 	foreach ( i, k in strings.keys() ) {

// 		template.AddTemplate( "logic_autosave", { targetname = k.tostring() })
// 		template.AddTemplate( "logic_autosave", { targetname = strings[k].tostring() })

// 		if ( !( i % 8 ) && i ) {

// 			template.AcceptInput( "ForceSpawn", "", null, null )
//             EntFire( template.GetName(), "Kill", "", 0.1 )
//             template = PopExtUtil.PointScriptTemplate( null, PurgeStringBatchPostSpawn )
//             continue
//         }
// 	}

// 	template.AcceptInput( "ForceSpawn", "", null, null )
// 	template.Kill()
// }

function PopGameStrings::StringFixGenerator() {

    if ( !("PopGameStrings" in ROOT) )
        return

    local PurgeString = PopGameStrings.PurgeString
    local string_table = clone StringTable

    local i = 1
    foreach ( k, v in string_table ) {

        PurgeString( k )
        PurgeString( v )

        PopExtMain.Error.DebugLog(format( "GAME STRINGS : %s : %s : %d", k.tostring(), v ? v.tostring() : "null", i ))
        if ( !( i % 2 ) )
            yield k || true

        i++
    }

    for ( local ent = First(), i = 1; ent; ent = Next( ent ), i++ ) {

        if ( !( i % 4 ) )
            yield ent

        if ( !ent || !ent.IsValid() || GetPropBool( ent, STRING_NETPROP_PURGESTRINGS ) )
            continue

        local classname = ent.GetClassname()
        SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
        PopExtMain.Error.DebugLog(format( "GAME STRINGS : %s : %d", ent.tostring(), i ))
        AddStrings( ent.GetScriptId() )
    }
}

local gen = null
local cooldown = 0.0
function PopGameStrings::ThinkTable::StringFixThink() {

    if ( Time() < cooldown )
        return

    if ( !StringTable.len() ) {

        cooldown = Time() + 0.2
        return
    }

    if ( !gen || gen.getstatus() == "dead" )
        gen = StringFixGenerator()

    local result = resume gen
}

// replace base entity I/O functions to handle the string table
foreach ( i, func in entio_funcs ) {

    local copy_name = format( "_%s", func )

    if ( copy_name in ROOT )
        continue

    ROOT[ copy_name ] <- ROOT[ func ]

    // local _func = ROOT[ copy_name ]

    // // ROOT[ func ] <- function( ... ) {

    // //     local target    = vargv[0]
    // //     local param     = 2 in vargv ? vargv[2] : null
    // //     local copy_name = format( "_%s", func )

    // //     if ( "PopGameStrings" in ROOT && param && typeof param == "string" && ( 0 in param ) )
    // //         PURGE_STRINGS( param )

    // //     if ( func == "EntFireByHandle" && target && target.IsValid() )
    // //         SetPropBool( target, STRING_NETPROP_PURGESTRINGS, true )

    // //     // __DumpScope( 0, vargv )
    // //     return _func.acall( [ this ].extend( vargv ) )
    // // }

    compilestring(format( @"

        local func_name = %s

        function %s( ... ) {

            local target    = vargv[0]
            local param     = 2 in vargv ? vargv[2] : null

            if ( ""PopGameStrings"" in ROOT && param && (typeof param)[0] == 's' && ( 0 in param ) )
                PURGE_STRINGS( param )

            if ( 9 in func_name && func_name[9] == 'H' )
                if ( target && target.IsValid() )
                    SetPropBool( target, STRING_NETPROP_PURGESTRINGS, true )

            // __DumpScope( 0, vargv )
            return _%s.acall( [ this ].extend( vargv ) )
        }
    ", "\"" + func + "\"", func, func ) ).call( ROOT )

}

// Purge entity keyvalue/netprop related strings
// DO NOT DO PURGE THE VALUE!!! 
// if someone sets m_iClassname/m_iName/modelname and you purge it, you will break things

// might cause perf warnings on maps that spam this function
function CBaseEntity::KeyValueFromString( key, value ) {

    // if ( "PopGameStrings" in ROOT && value && typeof value == "string" && ( 0 in value ) )
        // PURGE_STRINGS( value )
    SetPropBool( this, STRING_NETPROP_PURGESTRINGS, true )
    return this.__KeyValueFromString( key, value )
}

// non-array functions are just wrappers around these at index 0
function SetPropStringArray( ent, prop, value, index = 0 ) {

    // if ( "PopGameStrings" in ROOT && value && typeof value == "string" && ( 0 in value ) )
        // PURGE_STRINGS( value )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )

    return NetProps.SetPropStringArray( ent, prop, value, index )
}

::SetPropString <- SetPropStringArray

// Setting this netprop before the internal Spawn() function fires seemingly causes issues for some ents
// CreateByClassname does not call Spawn()
// function CreateByClassname( classname ) {

//     local ent = Entities.CreateByClassname( classname )
//     SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
//     return ent
// }

function SpawnEntityFromTable( classname, table ) {

    if ( !("_SpawnEntityFromTable" in ROOT) )
        return SpawnEntityFromTable( classname, table )

    local ent = _SpawnEntityFromTable( classname, table )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )

    PURGE_STRINGS( ent.GetScriptId() )

    return ent
}

::PURGE_STRINGS <- PopGameStrings.AddStrings