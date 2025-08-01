
### Any existing code that breaks these rules predates these guidelines and is too load-bearing/widely used to change
**Offending lines of code that already exist are not a pass to break them yourself.**

## General
- Use PopExtUtil functions as much as possible, all generic re-usable functions go here
- Use PopExtMain.Error for parse errors and warnings, do not use error() or other print functions
- Always use constants defined in constants.nut/itemdef_constants.nut, avoid magic numbers
    - many netprop strings are cached as constants for performance + ease of writing
- Only popextensions_main.nut is allowed to break these rules due to being included before any other files

## Formatting
- no trailing semicolons, only use in for-loops and one-liners
- snake_case variable names, PascalCase function names, ALL_UPPERCASE constant names, no camelCase
    - "constant-like" values (e.g. ROBOT_ARM_PATH in util.nut) are the only exception
- K&R syntax (inline opening braces, newline after)
- Valve-style argument formatting (spaces between opening/closing parentheses)
- Trim whitespace (Ctrl+M then Ctrl+X in VSCode)
- No inline comments, comments should always be above the code they are meant to explain
- Use ternaries and lambda functions where appropriate
    - simple yes/no conditional checks, simple functions that return a value and do nothing else, do not look at ExtraTankPath xd
- format() > string concatenation

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
- Valve-style argument formatting:
    - Opening parentheses:
        - Find: ``\(([^\s)])``
        - Replace: ``( $1``
    - Closing parentheses:
        - Find: ``([^\s])\)``
        - Replace: ``$1 )``
    - Disable regex search
    - Find: ``( )`` Replace: ``()``
    - Find: ``))`` Replace: ``) )`` (might not need this one?)
- Trim whitespace:
    - Find: ``\s+$``
    - Replace: empty string

## Game events
- See event_wrapper.nut for an example of how to use the event hooking system
- We will be migrating away from using the currently existing hook table setup

## Think functions
- Use `PopExtUtil.AddThinkToEnt( ent, "funcname" )`
- Alternatively, you can directly add your function to the correct think table for the entity (see tags/customattributes/missionattributes).
- You should almost never use `_AddThinkToEnt`, this will break other think functions on certain entities if you don't know what you are doing.

## Cleanup
- all entity targetnames prefixed with these will be wiped out on wave/mission change:
    - `__popext`
    - `extratankpath`
- See the `teamplay_round_start` event in popextensions_main.nut for dealing with global variable cleanup
    - You should scope your variables to an existing table where possible instead of adding it to the cleanup array.
