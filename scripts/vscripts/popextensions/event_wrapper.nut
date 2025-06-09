::PopExtEvents <- {

    Events = {}
    CompiledEvents = {}

    AddRemoveEventHook = function(event, funcname, func = null, index = "unordered") {

        //remove hook
        if (!func)
        {
            try
                if (event in PopExtEvents.Events && index in PopExtEvents.Events[event] && funcname in PopExtEvents.Events[event][index])
                    delete PopExtEvents.Events[event][index][funcname]

                // invalid index, look for funcname in any index
                // you should avoid hitting this for performance reasons or confusion, use indexes
                else if (event in PopExtEvents.Events && !(index in PopExtEvents.Events[event]))
                    foreach(idx, func_table in PopExtEvents.Events[event])
                        if (funcname in func_table)
                            delete PopExtEvents.Events[event][idx][funcname]
            catch (e)
                error(format("ERROR: **POPEXTENSIONS WARNING: AddRemoveEventHook '%s' on '%s' event failed!**\n", funcname, event))

            return
        }

        if (!(event in PopExtEvents.Events))
            PopExtEvents.Events[event] <- {}

        if (!(index in PopExtEvents.Events[event]))
            PopExtEvents.Events[event][index] <- {}

        PopExtEvents.Events[event][index][funcname] <- func

    }

    CollectEvents = function() {

        foreach (event, event_table in PopExtEvents.Events)
        {
            local call_order = array(event_table.len())

            foreach (index, func_table in event_table)
                if (index != "unordered")
                    call_order[index] = func_table

            if ("unordered" in event_table)
                call_order[call_order.len() - 1] = (event_table["unordered"])

            local event_string = event == "OnTakeDamage" ? "OnScriptHook_" : "OnGameEvent_"

            PopExtEvents.CompiledEvents[format("%s%s", event_string, event)] <- function(params) {

                foreach(tbl in call_order)
                    foreach(name, func in tbl)
                        func(params)
            }
        }

        __CollectGameEventCallbacks(PopExtEvents.CompiledEvents)
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

