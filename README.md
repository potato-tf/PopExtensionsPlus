This is a greatly expanded fork of the original PopExtensions that aims to recreate many of the features in sigsegv/rafradek's server plugins.

The roadmap for what needs to be added to this script can be found [here](https://trello.com/b/rHmwlmCL/popextensions-todo-list).  We encourage anyone and everyone to submit pull requests to recreate the missing features in VScript.

How to install:
put scripts directory inside tf directory, merge if necessary

scripts/population/mvm_bigrock_vscript.pop is a demonstrative popfile that makes use of all available hooks

A [documentation](https://github.com/potato-tf/PopExtensionsPlus/blob/main/documentation.md) for various structures of the library is slowly being worked on. Check it out!

# How To Use:

The stucture of the library is as follows:

- **PopExt**: This is the original popextensions library, **all functions from the original popextensions library must be prefixed with PopExt now**

- **PopExtHooks**: This is the original hooks.nut file for popextensions.  These functions generally don't need to be touched by the end user

- **PopExtUtil**:  A wide variety of utility functions.  All functions are listed in util.nut and prefixed with `PopExtUtil.`  **Some functions previously included in popextensions.nut have been moved here**

- **MissionAttributes**: Dozens of one-line key-values that mimic many of the features of rafmod/sigmod.  All keyvalues are documented in `missionattributes.nut`

- **SpawnTemplates**: drop-in replacement for rafmod's PointTemplate spawning system, a python script has been supplied to convert your old missions to this new format.

- **Tags**: Every bot tag and what it does is documented in the tags.nut file.  These functions generally don't need to be touched by the end user

- **CustomAttributes**: this works in combination with MissionAttributes and Tags to allow creating completely custom player and item attributes that can be applied to both players and bots.

- **Entity Additions**: This is a file that is run directly on an entity in the `vscripts` keyvalue.  **It is not used like other scripts in this library!**

- **Main**: This is the main cleanup and include file.  These functions generally don't need to be touched by the end user.

# Backwards compatibility with popextensions

All functions from the original popextensions library have been prefixed with `PopExt`.  This means that this code
```
SetWaveIconsFunction(function() {
  // Use custom icon for a tank, first remove the regular tank icon
  SetWaveIconSpawnCount(`tank`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 0)
  // Add our custom tank icon
  SetWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
})
```

Must be rewritten like this:
```
PopExt.SetWaveIconsFunction(function() {
  // Use custom icon for a tank, first remove the regular tank icon
  PopExt.SetWaveIconSpawnCount(`tank`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 0)
  // Add our custom tank icon
  PopExt.SetWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
})
```


The following functions have been moved to a separate utility file and are prefixed with `PopExtUtil.` instead:

- SetParentLocalOrigin
- SetParentLocalOriginDo
- SetupTriggerBounds
- PrintTable
- DoPrintTable
- CreatePlayerWearable

Example:
```CreatePlayerWearable(bot, `models/props_farm/wooden_barrel.mdl`, false, `head`)```

is now

```PopExtUtil.CreatePlayerWearable(bot, `models/props_farm/wooden_barrel.mdl`, false, `head`)```

# Global fixes and balance changes
- The holiday punch can tickle robots once more, with working animations!
- Your Eternal Reward disguises are no longer delayed.
- Improved money collection for scout (collects instantly), money spawns with zero velocity.
- Fixed HoldFireUntilReload on every weapon
- Dragons Fury cannot be reflected.
- All of these can be optionally disabled with a MissionAttributes keyvalue

# PopExt:
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

                // If you are hitting the 4096 character limit inside this script, it would be required to put hooks into separate file
                // IncludeScript(`mypophooks`)
                // Add event hooks for bots with specifed Tag.
                PopExt.AddRobotTag(`abc`, {
                    // Called when the robot is spawned
                    OnSpawn = function(bot, tag) {
                        bot.KeyValueFromString(`rendercolor`, `0 255 0`)
                        // Create a barrel prop on bot's head
                        PopExtUtil.CreatePlayerWearable(bot, `models/props_farm/wooden_barrel.mdl`, false, `head`)
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
                PopExt.SetWaveIconsFunction(function() {
                    // Use custom icon for a tank, first remove the regular tank icon
                    PopExt.SetWaveIconSpawnCount(`tank`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 0)
                    // Add our custom tank icon
                    PopExt.SetWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
                })

                // Add event hooks for tanks with specified Name, also supports wildcard suffix
                PopExt.AddTankName(`abc*`, {
                    // Called when the tank is spawned
                    OnSpawn = function(tank, name) {
                        // Create a prop on top of the tank
                        local prop = SpawnEntityFromTable(`prop_dynamic`, {model = `models/props_badlands/barrel01.mdl`, origin = `0 0 200`})

                        // Create an ignite trigger
                        local trigger = SpawnEntityFromTable(`trigger_ignite`, {origin = `0 0 100`, spawnflags = `1`})
                        PopExtUtil.SetupTriggerBounds(trigger, Vector(-200,-200,-200), Vector(200,200,200))
                        PopExtUtil.SetParentLocalOrigin([prop, trigger], tank)

                        ClientPrint(null, 2, `OnSpawnTank`)
                        tank.KeyValueFromString(`rendercolor`, `255 0 0`)
                    },
                    // Called when the tank is destroyed
                    // Params as in https://wiki.alliedmods.net/Team_Fortress_2_Events#player_hurt:~:text=level-,npc_hurt,-Name%3A
                    OnDeath = function(tank, params) {
                        // Decrement custom tank icon when killed
                        PopExt.DecrementWaveIconSpawnCount(`tank_red`, MVM_CLASS_FLAG_MINIBOSS | MVM_CLASS_FLAG_NORMAL, 1)
                    }
                })
            "
        }
```

# MissionAttributes:
`MissionAttributes` is the equivalent of rafmod's custom WaveSchedule key-values.  This is an extremely powerful and feature-rich part of the library that includes a large portion of the functionality from rafmod.

MissionAttributes are collected in a table on wave init.  The function for doing so is `MissionAttrs({})`

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
Every available MissionAttribute is documented in `missionattributes.nut.`

# SpawnTemplates:
A powerful entity spawning script that leverages the new point_script_template entity.

Inside the python folder you will find a script to convert rafmod's PointTemplates spawner to a vscript equivalent.  Download the latest version of python if you don't have it, run the script, select your popfile, and a script file containing all the templates will be output to a new VScript alternative.  Note that you will need to manually spawn these entities again using the `SpawnTemplate("TemplateName")` function, use the `popext_spawntemplate|TemplateName` tag for bots, or use the `SpawnTemplate = "TemplateName"` property for tanks.

## Writing new PointTemplates

The PointTemplate spawner is structured like so:

```
::PointTemplates <- {
        TemplateName <- {
                NoFixup = 1, //Name fix-up behaves somewhat similarly to point_template name fix-up, appending a unique number to the end of the targetname to separate identical templates.  Set NoFixup 1 to disable this behavior
                [0] = { //first entity to spawn in the template
                        item_teamflag = { //entity classnames here
                                targetname = "example_flag"
                                origin = "0 0 0"
                                angles = "0 0 0"
                                //other item_teamflag key/values go in here
                        }
                }
                [1] = { //second entity to spawn in the template
                        prop_dynamic = {
                                targetname = "example_barrel"
                                parentname = "example_flag" //parent a barrel prop to the flag
                                model = `models/props_badlands/barrel01.mdl`
                        }
                }
        }
}
```
A more advanced example of the point template spawner using Condemned - Trespasser as a base can be found in the python/pt-converter folder.

# Bot Tags
There is a massive selection of bot tags to choose from that replicate many rafmod features, or add new ones entirely.  All tags are prefixed with `popext_` and can be found in tags.nut

Many tags accept additional arguments.  For example:
- `popext_rocketcustomtrail|eyeboss_projectile` will apply the eyeboss_projectile particle to a rocket, giving rockets a purple monoculus trail.
- `popext_homingprojectile|0.5|0.5` will make a bots rockets (and many other projectiles) follow their closest target with half speed and half turn power.
- `popext_reprogrammed` will spawn the bot on RED
- `popext_spawnhere|-779 3302 312` will spawn a bot at these xyz coordinates (near the barn door at the front of bigrock)

# Custom Attributes
This allows mission makers to apply fully custom weapon attributes to both bots and players.  All custom attributes can be found in the `Attrs` table at the top of `customattributes.nut`

### For players:
- Simply add the attribute and the value to an `ItemAttributes` table like any other attribute.  An example of `ItemAttributes` with some custom attributes is provided in the example popfile.
- **IMPORTANT NOTE FOR PLAYER ATTRIBUTES:** Due to limitations with the custom attribute system, attributes applied in the `PlayerAttributes` table will simply be applied to the players current active weapon on spawn (their primary weapon).  This will be fixed in a later version

### For bots:
- use the `popext_customattr` bot tag, with two additional arguments for the attribute and value
- example: `popext_customattr|wet immunity|1`, bot will be immune to jar effects.  Currently, this will only apply to the bots primary active weapon.

# Tank Additions

Pop Extensions Plus expands upon the tank additions added in the original Pop Extensions.
When you call PopExt.AddTankName, the second argument is a table where you set the values for the available properties below. Please see the bigrock pop and [popext bigrock pop](https://github.com/rafradek/VScript-Popfile-Extensions/blob/main/scripts/population/mvm_bigrock_vscript.pop#L136) for usage.

Available Properties:
```
* Model or TankModel    // use custom tank model, can be either a string or a table of strings
  * Default
  * Damage1
  * Damage2
  * Damage3
  * Bomb
  * TrackL or LeftTrack
  * TrackR or RightTrack
* ModelVisionOnly or TankModelVisionOnly // true: keeps original tank bounding box, false (default): changes bounding box to match the custom model
* SoundOverrides
  * Ping
  * EngineLoop
  * Start
  * Destroy
  * Deploy
* Team                  // 2: Red team, 3: Blu team, also accepts strings "RED", "BLU", "GRY"
* NoScreenShake         // does not currently work
* IsBlimp               // true: sets the tank to be a blimp
* SpawnTemplate         // expects a string that is the name of the template in PointTemplates table. see SpawnTemplates section
* DisableTracks
* DisableBomb
* DisableSmoke
* Scale                 // number or string
* Icon                  // expects a table. e.g. { name = `tank_sticky_hellmet`, isCrit = true, isBoss = false }
* CritImmune
* CrushDamageMult
* NoDeathFX             // 1: disables visuals only, 2: disables visuals and sounds
```

# Entity Additions
This library supports custom entity features and spawnflags to enable certain behaviors.  You can add these in the PointTemplate spawner, or in Hammer with SmartEdit disabled.  Simply add `popextensions/ent_additions` to the `vscripts` keyvalue of the entity

### func_rotating
- No longer freezes and prints the `Bad SetLocalAngles` console error when one of the rotation angles exceeds 360,000 degrees.
- Fixes killing the entity before stopping the rotate sound causing the sound to play forever.  Fixes the sound continuing to play after it is killed on round restart as well.
### tf_point_weapon_mimic
- Fired projectiles can have their team assigned with `TeamNum` keyvalue (2 for RED and 3 for BLU). Normally, all fired projectiles always belong to BLU team
- Fixed FireSound not working.  WARNING: sounds can stack for every projectile fired, not recommended for fast-refiring or multiple weapon mimics firing at the same time
- FireSound now takes an optional volume parameter.  Example: `FireSound = "weapons/stickybomblauncher_shoot_crit.wav|0.5"`
- ModelScale now works on rockets, arrows untested.

### obj_sentrygun
- 64: Spawn as Mini-Sentry
### light_dynamic
- 16: Start Disabled
### func_button, func_rot_button, momentary_rot_button
- 2048: Start Locked (now works as intended for all buttons)
- 16384: Not Solid

## Reverse MvM
- Native Reverse MvM support (WIP)
-
# IMPORTANT NOTE FOR SERVER OWNERS
This library has a handful of features that rely on convars that are not included by default in `cfg/vscript_convar_allowlist.txt`.  You will need to modify this cfg file to add the following convars:

```
tf_mvm_defenders_team_size
tf_dev_health_on_damage_recover_percentage
tf_dev_marked_for_death_lifetime
tf_whip_speed_increase
```

# Miscellaneous

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
