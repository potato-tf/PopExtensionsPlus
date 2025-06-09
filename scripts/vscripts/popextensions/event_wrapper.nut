::PopExtEvents <- {

    EventsPreCollect = {}
    TableId = UniqueString("_Compiled")

    AddRemoveEventHook = function( event, funcname, func = null, index = "unordered" ) {

        //remove hook
        if ( !func )
        {
            // try
            // {
                if ( event in EventsPreCollect )
                {
                    // direct index removal
                    if ( index in EventsPreCollect[ event ] && funcname in EventsPreCollect[ event ][ index ] )
                        delete EventsPreCollect[ event ][ index ][ funcname ]

                    // wildcard funcname
                    if ( index in EventsPreCollect[ event ] && endswith( funcname, "*" ) )
                        foreach( name, func in EventsPreCollect[ event ][ index ] )
                            if ( startswith( name, funcname ) )
                                delete EventsPreCollect[ event ][ index ][ name ]

                    // invalid index, look for funcname in any index
                    else if ( !( index in EventsPreCollect[ event ] ) )
                        foreach( idx, func_table in EventsPreCollect[ event ] )
                            if ( funcname in func_table )
                                delete EventsPreCollect[ event ][ idx ][ funcname ]


                    // stil nothing, look for funcname in any event
                    else
                        foreach( e, event_table in EventsPreCollect )
                            foreach( idx, func_table in event_table )
                                if ( funcname in func_table )
                                    delete func_table[ funcname ]
                }
                // remove from all EventsPreCollect at a given index
                else if ( event == "*" )
                    foreach( e, event_table in EventsPreCollect )
                        if ( funcname in event_table[ index ] )
                            delete EventsPreCollect[ e ][ index ][ funcname ]

            // } catch ( e ) {
                // PopExtMain.Error.GenericWarning( format( "AddRemoveEventHook '%s' on '%s' event failed!**\n", funcname, event ) )
            // }
            return
        }

        if ( !( event in EventsPreCollect ) )
            EventsPreCollect[ event ] <- {}

        if ( !( index in EventsPreCollect[ event ] ) )
            EventsPreCollect[ event ][ index ] <- {}

        EventsPreCollect[ event ][ index ][ funcname ] <- func

        CollectEvents()
    }

    CollectEvents = function() {

        // add EventsPreCollect to the old table
        local old_table = {}
        local old_table_name = format( "PopExtEvents_%s", TableId )

        if ( old_table_name in PopExtEvents )
            old_table = PopExtEvents[ old_table_name ]

        foreach ( event, new_table in EventsPreCollect )
        {
            // __DumpScope( 0, new_table )
            local call_order = array( new_table.len() )

            foreach ( index, func_table in new_table )
                if ( index != "unordered" )
                    call_order[ index ] = func_table

            if ( "unordered" in new_table )
                call_order[ call_order.len() - 1 ] = new_table[ "unordered" ]

            foreach ( tbl in call_order )
                foreach ( name, func in tbl )
                    if ( name in old_table && !( name in new_table ) )
                        delete old_table[ name ]

            local event_string = event == "OnTakeDamage" ? "OnScriptHook_" : "OnGameEvent_"

            old_table[ format( "%s%s", event_string, event ) ] <- function( params ) {

                foreach( tbl in call_order )
                    foreach( name, func in tbl )
                        func( params )
            }
        }
        // copy table to new ID, remove old table
        local new_id = UniqueString("_Compiled")
        local new_table_name = format( "PopExtEvents_%s", new_id )

        PopExtEvents[ new_table_name ] <- old_table
        if ( old_table_name in PopExtEvents )
            delete PopExtEvents[ old_table_name ]

        TableId = new_id

        // collect EventsPreCollect
        __CollectGameEventCallbacks( PopExtEvents[ new_table_name ] )
    }
}

//examples
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHereA", function(params) {
//     printl(params.userid + " died first")
// }, 0)
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHereB", function(params) {
//     printl(params.userid + " died first")
// }, 0)
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHere1", function(params) {
//     printl(params.userid + " died1")
// }, 1)
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHere2", function(params) {
//     printl(params.userid + " died2")
// }, 2)
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHere3", function(params) {
//     printl(params.userid + " died3")
// }, 3)
// PopExtEvents.AddRemoveEventHook("player_death", "FuncNameHere4", function(params) {
//     printl(params.userid + " died last")
// })
