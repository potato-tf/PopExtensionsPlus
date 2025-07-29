// Accessing any entity in VScript will allocate a string that never gets freed, eventually causing a CUtlRBTree overflow.
// Hook existing API functions to free them ourselves.

local strings_to_purge = {}

::CBaseEntity.KeyValueFromString <- function( key, value ) {

	// TODO: find another way to do this, dot notation for function calls is expensive
	CBaseEntity.__KeyValueFromString.call( this, key, value )

    strings_to_purge[ value ] <- key
}

::SetPropStringArray <- function( entity, property, value, index ) {

    NetProps.SetPropStringArray( entity, property, value, index )

    strings_to_purge[ value ] <- property
}

::SetPropString <- @( entity, property, value ) SetPropStringArray( entity, property, value, 0 )

// ::CreateByClassname <- function( classname ) {

//     strings_to_purge[ classname ] <- null

//     return Entities.CreateByClassname( classname )
// }

foreach( name, func in Entities.getclass() ) {

	ROOT[ name ] <- function( ... ) {

		local result = func.acall( [ this ].extend( vargv ) )

		foreach( arg in vargv )
			if ( typeof arg == "string" )
				strings_to_purge[ arg ] <- null

		return result
	}
}