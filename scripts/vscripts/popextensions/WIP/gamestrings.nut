// Accessing any entity in VScript will allocate a string that never gets freed, eventually causing a CUtlRBTree overflow.
// Hook existing API functions to free them ourselves.

function CBaseEntity::KeyValueFromString( key, value ) {

	// TODO: find another way to do this, dot notation for function calls is expensive
	CBaseEntity.__KeyValueFromString.call( this, key, value )
    SetPropBool( this, STRING_NETPROP_PURGESTRINGS, true )
}

function SetPropStringArray( entity, property, value, index ) {

    NetProps.SetPropStringArray( entity, property, value, index )
    SetPropBool( entity, STRING_NETPROP_PURGESTRINGS, true )
}

::SetPropString <- @( entity, property, value ) SetPropStringArray( entity, property, value, 0 )

function CreateByClassname( classname ) {

    local ent = Entities.CreateByClassname( classname )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function DispatchSpawn( ent ) {

    Entities.DispatchSpawn( ent )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
}

function FindByClassname( previous, classname ) {

    local ent = Entities.FindByClassname( previous, classname )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByClassnameNearest( classname, center, radius ) {

    local ent = Entities.FindByClassnameNearest( classname, center, radius )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByClassnameWithin( previous, classname, origin, radius ) {

    local ent = Entities.FindByClassnameWithin( previous, classname, origin, radius )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByModel( previous, model_name ) {

    local ent = Entities.FindByModel( previous, model_name )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByName( previous, name ) {

    local ent = Entities.FindByName( previous, name )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByNameNearest( name, center, radius ) {

    local ent = Entities.FindByNameNearest( name, center, radius )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByNameWithin( previous, name, origin, radius ) {

    local ent = Entities.FindByNameWithin( previous, name, origin, radius )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindByTarget( previous, target ) {

    local ent = Entities.FindByTarget( previous, target )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

function FindInSphere( previous, center, radius ) {

    local ent = Entities.FindInSphere( previous, center, radius )
    SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

if ( !("_SpawnEntityFromTable" in ROOT ) )
	::_SpawnEntityFromTable <- SpawnEntityFromTable

function SpawnEntityFromTable( classname, properties ) {

    local ent = _SpawnEntityFromTable( classname, properties )
    // SetPropBool( ent, STRING_NETPROP_PURGESTRINGS, true )
    return ent
}

// foreach( name, func in Entities.getclass() ) {

// 	if ( name == "IsValid" ) continue

// 	local original = format( " _%s", name )

// 	if ( !( original in ROOT ) ) {

// 	__DumpScope( 0, func.getinfos() )
// 		printl( name )
// 		ROOT[ name ] <- function( ... ) {
			
// 			foreach( i, arg in vargv )
// 				printl( name + " : " + i + " : " + arg )
// 			try {
// 				local result = ::Entities[ name ].bindenv( ::Entities ).acall( [ this ].extend( vargv ) )
// 				printl( result )
// 			} catch ( e ) {
// 				foreach( i, arg in vargv )
// 					printl( name + "\n : " + i + " : " + arg )
// 				Assert( false, name )
// 			}

// 			local result = func.bindenv( ::Entities ).acall( [ this ].extend( vargv ) )

// 			printl( "\n" )
// 		}

// 		ROOT[ original ] <- func.bindenv( ::Entities )
// 	}
// }