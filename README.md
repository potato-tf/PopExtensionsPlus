# PopExtensions+
VScript extensions for use inside population files

This is a greatly expanded fork of the original PopExtensions that aims to recreate many of the features in sigsegv/rafradek's server plugins.

The roadmap for what needs to be added to this script can be found [here](https://trello.com/b/rHmwlmCL/popextensions-todo-list).  We encourage anyone and everyone to submit pull requests to recreate the missing features in VScript.

How to install:
put scripts directory inside tf directory, merge if necessary

scripts/population/mvm_bigrock_vscript.pop is a demonstrative popfile that makes use of all available hooks

# Features:

## MissionAttributes
- Dozens of one-line key-values that mimic many of the features of rafmod/sigmod.  Forcibly disable romevision, turn players into Robots, apply global item attributes or conditions to players, and way more than can be reasonably listed here

## Advanced entity spawning system, rafmod PointTemplate converter

Inside the python folder you will find a script to convert rafmod's PointTemplates spawner to a vscript equivalent.  Download the latest version of python if you don't have it, run the script, select your popfile, and a script file containing all the templates will be output to a new VScript alternative.  note that you will need to manually spawn these entities again using the `SpawnTemplate.SpawnTemplate()` function

## Bot Tags

- Dozens of bot tags that mimic many of the rafmod/sigmod TFBot keyvalues
- Enables a variety of AI mechanics previously exclusive to rafmod/sigmod. Spellcasting bots, custom spawn locations, homing rockets, the list goes on.

### IMPORTANT!
Due to current limitations with VScript, you must include a separate script file that has all of the tags for your bots in an array.

Copy/paste all of your bot tags from every bot into a script file with the same name as your mission suffixed with "_tags" (e.g. "mvm_bigrock_vscript_tags.nut")


## Global fixes and balance changes
- The holiday punch can tickle robots once more, with working animations!
- Your Eternal Reward disguises are no longer delayed.
- Improved money collection for scout (collects instantly), money spawns with zero velocity.
- Fixed HoldFireUntilReload on every weapon
- Dragons Fury cannot be reflected.

## Custom entity additions/spawnflags
This library supports custom entity features and spawnflags to enable certain behaviors.  You can add these in the PointTemplate spawner, or in Hammer with SmartEdit disabled.  Simply add `popextensions/ent_additions` to the `vscripts` keyvalue of the entity

### func_rotating
- No longer freezes and prints the `Bad SetLocalAngles` console error when one of the rotation angles exceeds 360,000 degrees.
- Fixes killing the entity before stopping the rotate sound causing the sound to play forever.  Fixes the sound continuing to play after it is killed on round restart as well.
### obj_sentrygun
- 64: Spawn as Mini-Sentry
### light_dynamic
- 16: Start Disabled
### func_button, func_rot_button, momentary_rot_button
- 2048: Start Locked (now works as intended for all buttons)
- 16384: Not Solid

## Reverse MvM
- Native Reverse MvM support (WIP)

## Self-Contained
- no need to worry about cleaning everything up manually, popextensions will automatically remove itself and all of its changes when a new popfile or wave that does not use it is loaded.

## Backwards Compatible
- All the original features of popextensions for adding spawn/death output hooks to bots and tanks are still supported, making this library a drop-in replacement.
-
# IMPORTANT NOTE FOR SERVER OWNERS
This library has a handful of features that rely on convars that are not included by default in `cfg/vscript_convar_allowlist.txt`.  You will need to modify this cfg file to add the following convars:

```
tf_mvm_defenders_team_size
tf_dev_health_on_damage_recover_percentage
tf_dev_marked_for_death_lifetime
tf_whip_speed_increase
```

# Examples

## MissionAttributes Example
Mission attributes are collected in a table on wave init.  The function for doing so is `MissionAttrs({})`

```
        // Add or replace existing InitWaveOutput with code below
        InitWaveOutput
        {
            Target gamerules // gamerules or tf_gamerules, depending on the map
            Action RunScriptCode
            Param "

                // The original InitWaveOutput trigger, change if necessary
                EntFire(`wave_init_relay`, `Trigger`)

                // Load popextensions script
                IncludeScript(`popextensions_main.nut`)

                MissionAttrs({

                    `NoReanimators`: 1
                    `666Wavebar`: 1
                    `ForceHoliday`: 8
                    `NoRome`: 2
                    `WaveStartCountdown`: 5
                    `PlayersAreRobots`: 2|4|8|16
                    `SpellRateCommon`: 0.5
                    `StandableHeads`: 1
                    `PlayerAttributes`: {
                        [TF_CLASS_SCOUT] = {
                            `damage bonus` : 5,
                            `fire rate penalty` : 2,
                            `max health additive bonus` : 100,
                        },
                        [TF_CLASS_SOLDIER] = {
                            `damage penalty` : 0.5,
                            `fire rate bonus` : 0.5,
                        },
                        [TF_CLASS_DEMOMAN] = {
                            `fire rate bonus` : 0.5,
                        }
                    }
                })
            "
        }
```
You can find every single valid keyvalue in `popextensions/missionattributes.nut` under the `MissionAttributes::MissionAttr` function

## Original Popextensions Example

The example below makes bots with tag abc green, spawns a barrel prop on bot's head and gives them a frying pan (thanks to this script to download from here https://tf2maps.net/downloads/vscript-give_tf_weapon.14897/):
```
        // Add or replace existing InitWaveOutput with code below
        InitWaveOutput
        {
            Target gamerules // gamerules or tf_gamerules, depending on the map
            Action RunScriptCode
            Param "
                // The original InitWaveOutput trigger, change if necessary
                EntFire(`wave_init_relay`, `Trigger`)

                // Load popextensions script
                IncludeScript(`popextensions_main.nut`)
                // Yaki's scripts for giving weapons, and making custom ones. Download: https://tf2maps.net/downloads/vscript-give_tf_weapon.14897/
                IncludeScript(`give_tf_weapon/_master`)

                // If you are hitting the 4096 character limit inside this script, it would be required to put hooks into separate file
                // IncludeScript(`mypophooks`)
                // Add event hooks for bots with specifed Tag.
                AddRobotTag(`abc`, {
                    // Called when the robot is spawned
                    OnSpawn = function(bot, tag) {
                        bot.KeyValueFromString(`rendercolor`, `0 255 0`)
                        bot.GiveWeapon(`Frying Pan`)
                        // Create a barrel prop on bot's head
                        CreatePlayerWearable(bot, `models/props_farm/wooden_barrel.mdl`, false, `head`)
                    },
                    // Called when the robot is killed
                    // Params as in player_death event in https://wiki.alliedmods.net/Team_Fortress_2_Events
                    // Params may be null if the bot was forcefully changed to spectator team
                    OnDeath = function(bot, params) {
                        // Restore colors back to normal as necessary
                        bot.KeyValueFromString(`rendercolor`, `255 255 255`)
                    },
                })
            "
        }
```

Example below makes all tanks that begin with name abc red and spawn with a prop and trigger_ignite on top. The tanks also use a custom icon:

```
        InitWaveOutput
        {
            Target gamerules // gamerules or tf_gamerules, depending on the map
            Action RunScriptCode
            Param "
                // The original InitWaveOutput trigger, change if necessary
                EntFire(`wave_init_relay`, `Trigger`)

                // Load popextensions script
                IncludeScript(`popextensions_main.nut`)

                // Set custom wave icons inside this function
                SetWaveIconsFunction(function() {
                    // Use custom icon for a tank, first remove the regular tank icon
                    SetWaveIconSpawnCount(`tank`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 0)
                    // Add our custom tank icon
                    SetWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
                })

                // Add event hooks for tanks with specified Name, also supports wildcard suffix
                AddTankName(`abc*`, {
                    // Called when the tank is spawned
                    OnSpawn = function(tank, name) {
                        // Create a prop on top of the tank
                        local prop = SpawnEntityFromTable(`prop_dynamic`, {model = `models/props_badlands/barrel01.mdl`, origin = `0 0 200`})

                        // Create an ignite trigger
                        local trigger = SpawnEntityFromTable(`trigger_ignite`, {origin = `0 0 100`, spawnflags = `1`})
                        SetupTriggerBounds(trigger, Vector(-200,-200,-200), Vector(200,200,200))
                        SetParentLocalOrigin([prop, trigger], tank)

                        ClientPrint(null, 2, `OnSpawnTank`)
                        tank.KeyValueFromString(`rendercolor`, `255 0 0`)
                    },
                    // Called when the tank is destroyed
                    // Params as in https://wiki.alliedmods.net/Team_Fortress_2_Events#player_hurt:~:text=level-,npc_hurt,-Name%3A
                    OnDeath = function(tank, params) {
                        // Decrement custom tank icon when killed
                        DecrementWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
                    }
                })
            "
        }
```

## Setting ConVars

this library includes the function `function MissionAttributes::SetConvar`.  This will reset the value of any changed ConVars after the wave/mission that uses the changed cvar is unloaded.  **Do not use ConVars.SetValue directly**

```
        // Add or replace existing InitWaveOutput with code below
        InitWaveOutput
        {
            Target gamerules // gamerules or tf_gamerules, depending on the map
            Action RunScriptCode
            Param "

                // The original InitWaveOutput trigger, change if necessary
                EntFire(`wave_init_relay`, `Trigger`)

                // Load popextensions script
                IncludeScript(`popextensions_main.nut`)

                //disable Jungle Inferno airblast behavior
                MissionAttributes.SetConvar(`tf_airblast_cray`, 0)
            "
        }
```

## Changing attributes on players and/or weapons

As shown above in the mission attributes example.  It is possible to apply global attribute changes to players and specific items.  ItemAttributes supports item indexes or classnames for weapons.

**Due to a limitation with VScripts AddAttribute/AddCustomAttribute functions, string attributes cannot be set**.
