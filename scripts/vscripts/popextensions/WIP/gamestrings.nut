// Accessing any entity in VScript will allocate a string that never gets freed, eventually causing a CUtlRBTree overflow.
// Hook existing API functions to free them ourselves.

function CBaseEntity::KeyValueFromString( key, value ) {

	// TODO: find another way to do this, dot notation for function calls is expensive
	CBaseEntity.__KeyValueFromString.call( this, key, value )

    SetPropBool( self, STRING_NETPROP_PURGESTRINGS, true )
}

::SetPropStringArray <- function( entity, property, value, index ) {

    NetProps.SetPropStringArray( entity, property, value, index )

    SetPropBool( entity, STRING_NETPROP_PURGESTRINGS, true )
}

::SetPropString <- @( entity, property, value ) SetPropStringArray( entity, property, value, 0 )

// ::CreateByClassname <- function( classname ) {

//     SetPropBool( self, STRING_NETPROP_PURGESTRINGS, true )

//     return Entities.CreateByClassname( classname )
// }

foreach( name, func in Entities.getclass() ) {

	if ( name == "IsValid" ) continue

	local original = format( " _%s", name )

	// if ( !( original in ROOT ) ) {

	// __DumpScope( 0, func.getinfos() )
		printl( name )
		ROOT[ name ] <- function( ... ) {
			
			// foreach( i, arg in vargv )
				// printl( name + " : " + i + " : " + arg )
			// try {
				local result = ::Entities[ name ].bindenv( ::Entities ).acall( [ this ].extend( vargv ) )
				printl( result )
			// } catch ( e ) {
			// 	foreach( i, arg in vargv )
			// 		printl( name + "\n : " + i + " : " + arg )
			// 	Assert( false, name )
			// }

			// local result = func.bindenv( ::Entities ).acall( [ this ].extend( vargv ) )

			// printl( "\n" )
		}

		// ROOT[ original ] <- func.bindenv( ::Entities )
	// }
}