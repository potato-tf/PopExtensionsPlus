
### Any existing code that breaks these rules predates these guidelines and/or is too load-bearing/widely used to change
**Offending lines of code that already exist are not a pass to break them yourself.**

## General
- Use PopExtUtil functions as much as possible, all generic re-usable functions go here
- Always use constants defined in constants.nut/itemdef_constants.nut, avoid magic numbers
## Error Logging:
- Use `PopExtMain.Error` for errors and warnings, do not use `error()` or other print functions
    - ### Debug:
    - Print to Console if `PopExtConfig.DebugText` is true and Debug Logging for the module is whitelisted in `PopExtConfig.DebugFiles`
        - `PopExtMain.Error.DebugLog` - Generic Debug Logging with the `POPEXT DEBUG:` prefix
    - ### Warnings:
    - Always print to console with the `POPEXT WARNING:` prefix
    - `PopExtMain.Error.GenericWarning` - Self-explanatory
    - `PopExtMain.Error.DeprecationWarning` - Deprecation warning.  First argument is old function/variable name, Second argument is the new name.
    - `PopExtMain.Error.RaiseIndexError` - Index out-of-range error, set the 3rd argument to `true` to trigger an assert/full vscript error
    - `PopExtMain.Error.RaiseTypeError` - Type error, see above for assert
    - `PopExtMain.Error.RaiseValueError` - Generic value error, see above for assert (argument 4 instead of 3)
    - `PopExtMain.Error.RaiseModuleError` - Module import error, `PopExtMain.IncludeModules` will handle this automatically
    - `PopExtMain.Error.ParseError` - Generic parsing errors.
    - `PopExtMain.Error.RaiseException` - Generic Exceptions/Asserts.

## Naming Conventions:
- ### snake_case:
    - all internal variables
- ### PascalCase:
    - function names
    - global or regularly accessed class/table names (e.g. ThinkTable)
- ### ALL_UPPERCASE:
    - constant names
    - "constant-like" values (e.g. `ROBOT_ARM_PATHS` in util.nut)


## Formatting
- no trailing semicolons, only use in for-loops and one-liners
- K&R syntax (inline opening braces, newline after)
- Valve-style argument formatting (spaces between opening/closing parentheses)
- Trim whitespace (Ctrl+M then Ctrl+X in VSCode)
- No inline comments, comments should always be above the code they are meant to explain
- Use ternaries and lambda functions where appropriate
    - simple yes/no conditional checks, simple functions that return a value and do nothing else, do not look at ExtraTankPath xd
- format() > string concatenation
- functions must be declared as `function name( args )`, DO NOT use `name = function( args )` or `name <- function(args)`
    - This is done for the perf counter.  `name <- function( args )` creates an anonymous function that will just print `<lambda or free run script>`

## Game events
- See event_wrapper.nut for an example of how to use the event hooking system

## Think functions
- Use `PopExtUtil.AddThink( ent, func )`
    - This accepts both function string names and actual function references, handles scoping automatically for function references.
- You should almost never use `_AddThinkToEnt`, this will break other think functions on certain entities if you don't know what you are doing.

## Cleanup
- all entity targetnames prefixed with these will be wiped out on wave/mission change:
    - `__popext`
    - `extratankpath`
- See the `teamplay_round_start` event in popextensions_main.nut for dealing with global variable cleanup
    - You should scope your variables to an existing table where possible instead of adding it to the cleanup array.

## Performance
- various strings are cached as constants for performance or ease of writing, notably netprop strings
- `PopExtUtil.AllNavAreas`, a pre-collected table of all nav areas for nav related code
- Always use folded constant names and API functions (e.g. SetPropString instead of NetProps.SetPropString)
    - Every API function that can be folded is already folded, check constants.nut

### Single-line control flow:
- This is fine:
```js
if ( condition1 == 3 )
    foreach( thing in myarray )
        printl( thing )
```

- This is also fine for single conditional checks
```js
if ( condition1 == 3 ) foreach( thing in myarray ) printl( thing )
```

- Whitespace after control flow lines for complex nested statements is preferred, see event_wrapper.nut
```js
if ( condition1 != 0 )

    if ( condition2 == 3 )

        foreach( thing in myarray )

            printl( thing )

    else if ( condition2 == 8 )

        printl( condition2 )

else

    printl( condition1 )
```

- Brackets for root scope, or everything, is also fine
```js
if ( condition1 != 0 ) {

    if ( condition2 == 3 )

        foreach( thing in myarray )

            printl( thing )

    else if ( condition2 == 8 )

        printl( condition2 )
}

else {

    printl( condition1 )
}

```

- This is NOT fine! Always enclose parent brackets around children.
```js

if ( condition1 != 0 )

    if ( condition2 == 3 )
        // wrong! condition1 and condition2 checks must also have enclosing brackets.
        foreach( thing in myarray ) {

            somevar = thing1
            printl( thing )
        }

```

### Long AND/OR comparisons
- Format like this:
```js
if (
    condition1
    || condition2
    || condition3
    || condition4
) {
    printl( "stuff" )
}
```
Consolidate into single-lines for short and/or comparisons
```js
if (
    condition1
    || ( condition3 && condition4 )
    || condition1 != condition2
) {
    printl( "stuff" )
}
```

### VSCode regex Find/Replace patterns
- Trailing semicolons:
    - Find: ``;\s*$``
    - Replace: empty string
- Convert all Allman-style syntax (opening brace on newline) to K&R:
    - Functions/Misc:
        - Find: ``((?:function\s+\w+|function|\w+\s*=\s*function|\w+)\s*\([^)]*\)\s*)\n\s*\{``
    - Control flow (if statements, loops, etc):
        - Find: ``((|if|else\s+if|else|for|while|switch|try|catch|class\s+\w+)\s*(?:\([^)]*\))?\s*)\n\s*\{``
    - Replace: ``$1 { \n``
    - Finding broken brackets due to inline comments: ``\/\/ s* \{``
- Correct function declaration syntax:
    - Find: ``(\w+\s*)=\s*function``
    - Replace: ``$1 = function $1``
- Valve-style argument formatting:
    - WARNING: will break regex capture groups, manually fix these after running it
    - Opening parentheses:
        - Find: ``\(([^\s)])``
        - Replace: ``( $1``
    - Closing parentheses:
        - Find: ``([^\s])\)``
        - Replace: ``$1 )``
    - Disable regex search
    - Find: ``( )`` Replace: ``()``
    - Find: ``))`` Replace: ``) )``
- Trim whitespace:
    - Find: ``\s+$``
    - Replace: empty string

