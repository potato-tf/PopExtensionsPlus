# PopfileExtensions+
VScript extensions for use inside population files

This is a greatly expanded fork of the original PopExtensions that aims to recreate many of the features in sigsegv/rafradek's server plugins.

The roadmap for what needs to be added to this script can be found [here](https://trello.com/b/rHmwlmCL/popextensions-todo-list).  We encourage anyone and everyone to submit pull requests to recreate the missing features in VScript. 

How to install:
put scripts directory inside tf directory, merge if necessary

scripts/population/mvm_bigrock_vscript.pop is a demonstrative popfile that makes use of all available hooks

## Example
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
                IncludeScript(`popextensions`)
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
                IncludeScript(`popextensions`)

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
## TODO
Maybe a way to easily create point templates and spawn them on bots, if someone makes it would be welcome
