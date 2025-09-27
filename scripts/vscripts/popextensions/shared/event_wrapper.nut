// Event hook/callback wrapper
// - SM-style event hooking
// - Dynamically adding/removing hooks at runtime, automatically handles re-collection
// - Configurable call ordering of events regardless of file include order

// __CollectEventCallbacks internally does something similar, appending functions to an array and then calling them in order.
// This effectively stuffs an array of popextension hook functions into the first available cell for a given event hook array.
// Call order for popext events is handled by this script instead of vscript_server.nut.

// TODO: Performance benchmarks.
// We use this to dynamically add/remove events at potentially critical times (large piles of bot spawns mostly)
// So far I haven't seen any PERF WARNINGS in console using this, some bot tags/custom attributes may yell on bot/player spawn.

// NOTE: rafmod has an issue with player handles being null in player_team events on bot disconnect
// The null checks in player_team are not necessary in vanilla

// example
// player_death functions will be called in the order specified

// POP_EVENT_HOOK( "player_death", "FuncNameHereA", function( params ) {
//     printl( params.userid + " died0" )
// }, 0)
// POP_EVENT_HOOK( "player_death", "FuncNameHereB", function( params ) {
//     printl( params.userid + " died0" )
// }, 0)
// POP_EVENT_HOOK( "player_death", "FuncNameHere1", function( params ) {
//     printl( params.userid + " died1" )
// }, 1)
// POP_EVENT_HOOK( "player_death", "FuncNameHere2", function( params ) {
//     printl( params.userid + " died2" )
// }, 2)
// POP_EVENT_HOOK( "player_death", "FuncNameHere3", function( params ) {
//     printl( params.userid + " died3" )
// }, 3)
// POP_EVENT_HOOK( "player_death", "FuncNameHere4", function( params ) {
//     printl( params.userid + " died last" )
// })

// prints:

// <userid> died0
// <userid> died0
// <userid> died1
// <userid> died2
// <userid> died3
// <userid> died last


POPEXT_CREATE_SCOPE( "__popext_event_wrapper", "PopExtEvents" )

PopExtEvents.EventsPreCollect <- {}
PopExtEvents.CollectedEvents  <- {}

if ( !("TableId" in PopExtEvents) )
    PopExtEvents.TableId <- UniqueString( "_Compiled" )

function PopExtEvents::_OnDestroy() {

    ClearEvents( null )
    delete ::POP_EVENT_HOOK
}

function PopExtEvents::AddRemoveEventHook( event, funcname, func = null, index = "unordered", manual_collect = false ) {

    // remove hook
    if ( !func ) {

        if ( event in EventsPreCollect ) {

            // direct index removal
            if ( index in EventsPreCollect[ event ] && funcname in EventsPreCollect[ event ][ index ] )

                delete EventsPreCollect[ event ][ index ][ funcname ]

            // wildcard funcname
            if ( index in EventsPreCollect[ event ] && funcname[funcname.len() - 1] == '*' )

                foreach( name, func in EventsPreCollect[ event ][ index ] )

                    if ( startswith( name, funcname.slice( 0, -1 ) ) )

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

                if ( index in event_table && funcname in event_table[ index ] )

                    delete EventsPreCollect[ e ][ index ][ funcname ]

                else if ( index in event_table && funcname[funcname.len() - 1] == '*' )

                    foreach( name, func in event_table[ index ] )

                        if ( startswith( name, funcname.slice( 0, -1 ) ) )

                            delete event_table[ index ][ name ]
        return
    }

    if ( !( event in EventsPreCollect ) )

        EventsPreCollect[ event ] <- {}

    if ( !( index in EventsPreCollect[ event ] ) )

        EventsPreCollect[ event ][ index ] <- {}

    EventsPreCollect[ event ][ index ][ funcname ] <- func

    // we don't need this internally, feature for external scripts
    // only here if someone wants to register events then collect them manually at a later time
    if ( manual_collect ) return

    CollectEvents()
}

function PopExtEvents::CollectEvents() {

    local old_table = {}
    local old_table_name = format( "PopExtEvents_%s", TableId )

    if ( old_table_name in CollectedEvents )

        old_table = CollectedEvents[ old_table_name ]

    foreach ( event, new_table in EventsPreCollect ) {

        local call_order = array( MAX_EVENT_FUNCTABLES )

        // set up call order
        foreach ( index, func_table in new_table )

            if ( index != "unordered" )

                call_order[ index ] = func_table

        // add unordered events to the end of the call order
        if ( "unordered" in new_table )

            call_order[ call_order.len() - 1 ] = new_table[ "unordered" ]

        // remove deleted events from the existing table
        foreach ( tbl in call_order )

            foreach ( name, func in tbl || {} )

                if ( name in old_table && !( name in new_table ) )

                    delete old_table[ name ]

        local event_string = event == "OnTakeDamage" ? "OnScriptHook_" : "OnGameEvent_"

        // set up hook table
        local func_name = format( "%s%s", event_string, event )
        old_table[ func_name ] <- function( params ) {

            foreach( i, tbl in call_order )

                foreach( name, func in tbl || {} )

                    if ( func )

                        func( params )
        }
        // fix anonymous function declaration
        compilestring( format( @"local _%s = %s; function %s( params ) { _%s( params ) }", func_name, func_name, func_name, func_name ) ).call(old_table)
    }

    // copy table to new ID
    local new_id = UniqueString( "_Compiled" )
    local new_table_name = format( "PopExtEvents_%s", new_id )

    // old events are copied to new table to preserve existing event hooks
    CollectedEvents[ new_table_name ] <- old_table

    // remove old table
    if ( old_table_name in CollectedEvents )
        delete CollectedEvents[ old_table_name ]

    // update table ID
    TableId = new_id

    // collect new events
    __CollectGameEventCallbacks( CollectedEvents[ new_table_name ] )
}

function PopExtEvents::ClearEvents( index = "unordered" ) {

    if ( !index || index == "*" ) {

        CollectedEvents  = {}
        EventsPreCollect = {}
    } 
    else 
        AddRemoveEventHook( "*", "*", null, index )

    // wipe out leftover null event hooks
    foreach( k, v in ::GameEventCallbacks )
        GameEventCallbacks[k] = v.filter( @( _, e ) e )
}

::POP_EVENT_HOOK <- PopExtEvents.AddRemoveEventHook.bindenv( PopExtEvents )
