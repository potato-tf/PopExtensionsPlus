POPEXT_CREATE_SCOPE( "__popext_gamestrings", "PopGameStrings", null, "PopGameStringsThink" )

StringFix.StringTable <- {}

function PopGameStrings::PurgeString( str ) {

    local temp = CreateByClassname( "logic_autosave" )
    SetPropString( temp, "m_iName", str )
    SetPropBool( temp, STRING_NETPROP_PURGESTRING, true )
    temp.Kill()
    delete StringTable[ str ]
}

function PopGameStrings::PurgeStringBatch( strings = {}) {

	local template = CreateByClassname( "point_script_template" )
	SetTargetname( template, "__popext_purgestringbatch" )
	SetPropBool( template, STRING_NETPROP_PURGESTRINGS, true )

	TemplateScope <- template.GetScriptScope()
	TemplateScope.ents <- []

	TemplateScope.__EntityMakerResult <- { entities = TemplateScope.ents }.setdelegate({

		function _newslot( _, value ) {

			entities.append( value )
		}
	})

	function TemplateScope::PostSpawn() {

		foreach ( i, ent in ents ) {

			SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
			EntFireByHandle( ent, "Kill", "", i * 0.1, null, null )
		}
		ents.clear()
	}

	foreach ( k, v in strings ) {

		template.AddTemplate( "logic_autosave", { targetname = arg })
		if ( !( i % 8 ) && i )
			template.AcceptInput( "ForceSpawn", "", null, null )
	}

	template.AcceptInput( "ForceSpawn", "", null, null )

	template.Kill()
}

function PopGameStrings::StringFixGenerator() {

    for ( local i = 0, ent; i <= MAX_EDICTS; ent = EntIndexToHScript(i), i++ )
    {
        if ( !ent || GetPropBool( ent, STRING_NETPROP_PURGESTRING ) )
            continue

        SetPropBool( ent, STRING_NETPROP_PURGESTRING, true )

        // remove everything between the comments if this causes problems
        ////////////////////////////////////
        local script_id = ent.GetScriptId()
        if ( script_id )
            StringTable[ script_id ] <- null
        StringTable[ ent.GetName() ] <- null
        StringTable[ ent.GetClassname() ] <- null
        ////////////////////////////////////
        yield ent
    }

    local string_table = clone StringTable

    foreach ( str in string_table.keys() ) {

        PurgeString( str )
        yield str
    }
}

local gen = null
function PopGameStrings::ThinkTable::StringFixThink() {

    if ( !gen || gen.getstatus() == "dead" )
        gen = StringFixGenerator()

    local result = resume gen

    // console spam for every string being purged
    // if ( result )
    //     printl( result )
    return -1
}

foreach ( i, func in [ "EntFireByHandle", "DoEntFire", "EntFire" ] ) {

    local copy_name = format( "_%s", func )

    if ( copy_name in ROOT )
        continue

    ROOT[ copy_name ] <- ROOT[ func ]

    compilestring( format( @"

        function %s( ... ) {

            local target    = vargv[0]
            local action    = vargv[1]
            local param     = 2 in vargv ? vargv[2] : """"
            local delay     = 3 in vargv ? vargv[3] : 0.0
            local activator = 4 in vargv ? vargv[4] : null
            local caller    = 5 in vargv ? vargv[5] : null

            if ( param && typeof param == ""string"" && param != """" )
                PopGameStrings.StringTable[ param ] <- null

            if ( !i && target && target.IsValid() )
                SetPropBool( target, STRING_NETPROP_PURGESTRING, true )
            else
                for ( local ent; ent = FindByName( null, ent ); )
                    SetPropBool( ent, STRING_NETPROP_PURGESTRING, true )
        }

    ", func ) )()

    return ROOT[ func ]( target, action, param, delay, activator, caller )
}
// if (!("_EntFireByHandle" in ROOT)) {

//     ::_EntFireByHandle <- EntFireByHandle

//     function ROOT::EntFireByHandle( target, action, param, delay, activator, caller ) {

//         if ( param && typeof param == "string" && param != "" )
//             PopGameStrings.StringTable[ param ] <- null

//         _EntFireByHandle( target, action, param, delay, activator, caller )

//         SetPropBool( target, STRING_NETPROP_PURGESTRING, true )
//     }
// }

// if (!("_DoEntFire" in ROOT)) {

//     ::_DoEntFire <- DoEntFire

//     function ROOT::DoEntFire( target, action, param, delay, activator, caller ) {

//         if ( param && typeof param == "string" && param != "" )
//             PopGameStrings.StringTable[ param ] <- null

//         return _DoEntFire( target, action, param, delay, activator, caller )
//     }
// }

// if (!("_EntFire" in ROOT)) {

//     ::_EntFire <- EntFire

//     function ROOT::EntFire( target, action, param, delay, activator ) {

//         if ( param && typeof param == "string" && param != "" )
//             PopGameStrings.StringTable[ param ] <- null

//         return _EntFire( target, action, param, delay, activator )
//     }
// }

// might cause perf warnings on maps that spam this function
function CBaseEntity::KeyValueFromString( key, value ) {

    if ( value && typeof value == "string" && value != "" )
        PopGameStrings.StringTable[ value ] <- null

    return CBaseEntity.__KeyValueFromString.call( this, key, value )
}

function SetPropStringArray( ent, prop, value, index = 0 ) {

    if ( value && typeof value == "string" && value != "" )
        PopGameStrings.StringTable[ value ] <- null

    return NetProps.SetPropStringArray( ent, prop, value, index )
}

::SetPropString <- SetPropStringArray