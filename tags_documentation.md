# PopExtensionsPlus Tags Documentation

*Documentation last updated [04.23.2025]*

This document provides reference for all tags available in the PopExtensionsPlus system.

popext_ Tags allow you to add special behaviors to bots in your popfiles. The syntax for using tags is:

```
Tag "popext_tagname{key1 = value1, key2 = value2}"
```
>[!NOTE]
>All sound-related tags will simply pass the entire table to an `EmitSoundEx` function.  All valid arguments for EmitSoundEx (minus sound_name) are valid here as well.
>`origin` and `entity` will default to the bot this tag is applied to, but can be overridden.
>See the [EmitSoundEx](https://developer.valvesoftware.com/wiki/Team_Fortress_2/Scripting/Script_Functions/EmitSoundEx) page for more information.

>[!NOTE]
>Both `true/false` and `1/0` can be used interchangeably for boolean logic.

>[!NOTE]
>Tags with multiple arguments can be broken into newlines for better readability.

Example:
```
Tag "popext_fireweapon{
    button   = IN_RELOAD
    cooldown = 3
    delay    = 10
}"
```
With that being said...

>[!CAUTION]
>Tags have a length limit of 256 characters.  If you see console errors mentioning `QUIET_TRUNCATION`, or the multi-line tag is cut short in the vscript error printed to console, your tag is too long.
> If you are using multi-line tags:
> - Change your End-of-Line sequence from CRLF to LF if you haven't already (for VSCode this is at the bottom right corner of the editor, or hit CTRL+SHIFT+P and search for "end of line").
> - If you are using VSCode (Recommended), install [VSCode VDF](https://marketplace.visualstudio.com/items?itemName=pfwobcke.vscode-vdf).  VSCode VDF will highlight tags that are too long.
> - For very long multi-line tags with many arguments, use raw numbers instead of constants, use `1/0` instead of `true/false`, and try to condense certain parts of the tag into the same line.

Example:
```
Tag "popext_actionpoint{
    target = `-1792 5952 896`
    repeats = 4 duration = 1 cooldown = 6
    aimtarget = `ClosestPlayer` alwayslook = 1
    waituntildone = 1
}"
```

## Available Tags

---

<a name="popext_addcond"></a>

### popext_addcond

```js
// Adds a condition to the bot, duration optional
// TF_COND_REPROGRAMMED has special handling to change team

// example usage
Tag "popext_addcond{cond = TF_COND_SPEED_BOOST, duration = 15}"
```

---

<a name="popext_reprogrammed"></a>

### popext_reprogrammed

```js
// Changes the bot to the defending team
// No parameters required

// example usage
Tag "popext_reprogrammed"
```

>[!NOTE]
>This applies `ammo regen 999` to the bot automatically.

---

<a name="popext_altfire"></a>

### popext_altfire

```js
// Makes the bot hold secondary fire button
// Duration is optional

// example usage
Tag "popext_altfire{duration = 30}" // hold for 30 seconds after spawning
Tag "popext_altfire" // hold indefinitely
```

---

<a name="popext_deathsound"></a>

### popext_deathsound

```js
// Customizes the sound played when the bot dies
// See EmitSoundEx for valid arguments

// example usage
Tag "popext_deathsound{sound = `ui/chime_rd_2base_neg.wav`}"
```

---

<a name="popext_stepsound"></a>

### popext_stepsound

```js
// Customizes the sound played when the bot takes a step
// See EmitSoundEx for valid arguments

// example usage
Tag "popext_stepsound{sound = `ui/chime_rd_2base_pos.wav`}"
```

> [!WARNING]
> Does not sync correctly for anything with reduced move speed (Giants).  Step sounds will always play at the same interval regardless of move speed penalties/bonuses.

---

<a name="popext_usehumanmodel"></a>

### popext_usehumanmodel

```js
// Makes the bot use the human player model instead of robot model
// No parameters required

// example usage
Tag "popext_usehumanmodel"
```

---

<a name="popext_usecustommodel"></a>

### popext_usecustommodel

```js
// Applies a custom model to the bot
// Requires model parameter

// example usage
Tag "popext_usecustommodel{model = `models/player/heavy.mdl`}"
```

---

<a name="popext_usehumananims"></a>

### popext_usehumananims

```js
// Makes the bot use human animations while keeping robot appearance
// No parameters required

// example usage
Tag "popext_usehumananims"
```

> [!WARNING]
> This tag is currently incompatible with popext_usecustommodel!

---

<a name="popext_alwaysglow"></a>

### popext_alwaysglow

```js
// Makes the bot permanently glow
// No parameters required

// example usage
Tag "popext_alwaysglow"
```
> [!NOTE]
> This is the same effect as tank/bomb carrier outlines and is affected by the `glow_outline_effect_enable` client command.

---

<a name="popext_stripslot"></a>

### popext_stripslot

```js
// Removes the weapon in the specified slot
// Requires slot parameter

// example usage
Tag "popext_stripslot{slot = SLOT_MELEE}"
```

---

<a name="popext_fireweapon"></a>

### popext_fireweapon

```js
// Makes the bot press a button with various conditions
// Only button parameter is required, others are optional

// example usage
Tag "popext_fireweapon{button = IN_RELOAD, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, duration = 2}"
```

> [!NOTE]
> This makes the bot hold the reload key for 2 seconds every 10 seconds, 5 times, but only if below 100 HP.

---

<a name="popext_weaponswitch"></a>

### popext_weaponswitch

```js
// Makes the bot switch to a weapon with various conditions
// Only slot parameter is required, others are optional

// example usage
Tag "popext_weaponswitch{slot = SLOT_SECONDARY, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100}"
```

---

<a name="popext_spell"></a>

### popext_spell

```js
// Makes the bot cast a spell
// Only type parameter is required, others are optional
// See constants.nut for spell type values

// example usage
Tag "popext_spell{type = SPELL_SKELETON, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, charges = 5}"
```

---

<a name="popext_spawntemplate"></a>

### popext_spawntemplate

```js
// Spawns a point template from the global PointTemplates table parented to the bot
// Requires template parameter

// example usage
Tag "popext_spawntemplate{template = `MyTemplateName`}"
```

---

<a name="popext_forceromevision"></a>

### popext_forceromevision

```js
// Forces romevision cosmetics on the bot regardless of player settings
// No parameters required

// example usage
Tag "popext_forceromevision"
```
>[!NOTE]
> Romevision cosmetics do not apply to the bot ragdoll on death, this may be fixed in the future.

---

<a name="popext_customattr"></a>

### popext_customattr

```js
// Applies a custom attribute to a bot or its weapon
// Requires attribute and value parameters
// See customattributes.nut for a list of valid attributes

// example usage
Tag "popext_customattr{attribute = `wet immunity`, value = 1}"
Tag "popext_customattr{weapon = `tf_weapon_scattergun`, attribute = `last shot crits`, value = 1, delay = 10}"
```

> [!NOTE]
> You can use either "attribute" or "attr" as the key name.
> For custom warpaints on bots, use `popext_warpaint`

---

<a name="popext_ringoffire"></a>

### popext_ringoffire

```js
// Creates a damaging ring of fire around the bot
// Requires damage, interval, and radius parameters

// example usage
Tag "popext_ringoffire{damage = 20, interval = 3, radius = 150}"
Tag "popext_ringoffire{damage = 20, interval = 3, radius = 150, hide_particle_effect = 1}"
```

> [!NOTE]
> The huo-long particle effect does not scale with radius! If you intend to use a custom effect, set "hide_particle_effect" to true.

---

<a name="popext_meleeai"></a>

### popext_meleeai

```js
// Improves AI for melee combat
// Parameters are optional

// example usage
Tag "popext_meleeai{turnrate = 1500}"
```

---

<a name="popext_mobber"></a>

### popext_mobber

```js
// Makes the bot hunt down players
// Parameters are optional

// example usage
Tag "popext_mobber{threat_type = `closest`, threat_dist = 256.0, lookat = false, turnrate = 150}"
```

>Valid threat types are `closest` and `random`.  `random` will pick a single random player on spawn and will not lose focus on them until the player dies.

---

<a name="popext_movetopoint"></a>

### popext_movetopoint

```js
// OBSOLETE - Use popext_actionpoint instead
// Makes the bot move to a specified point
// Requires target parameter

// example usage
Tag "popext_movetopoint{target = `entity_to_move_to`}"
Tag "popext_movetopoint{target = `500 500 500`}"
```

---

<a name="popext_actionpoint"></a>

### popext_actionpoint

```js
// Creates an action point for the bot to move to
// Only target parameter is required, others are optional
// Action points control bot movement and targeting behaviors

// example usage
Tag "popext_actionpoint{target = `action_point_targetname`}"
Tag "popext_actionpoint{target = `500 500 500`, next_action_point = `optional_next_action_point_targetname`, desired_distance = 50, duration = 10, command = `attack sentry at next action point`}"
```

> - Accepts entity handle, targetnames or x y z string coordinates for the target parameter
> - Parameters:
>   - **target**: Where to place the action point (required)
>   - **aimtarget**: What the bot should aim at while at the action point
>   - **killaimtarget**: Bitflag for buttons to press when the bot reaches the point (e.g., IN_ATTACK2)
>     - Setting to 1 makes the bot use primary fire
>     - See FButtons constants for valid button values
>   - **alwayslook**: Whether the bot should always look at the aim target
>   - **next_action_point**: Targetname of next action point to move to
>   - **waituntildone**: Whether to wait until the action is complete
>   - **distance/desired_distance**: How close the bot needs to be to count as "at" the point
>   - **duration**: How long the bot stays at the point
>   - **stay_time**: How long the bot stays at the point (note: ineffective for populator spawned bots)
>   - **command**: What the bot should do at the action point
>   - **delay**: Time before the bot is given this action point
>   - **repeats**: How many times to repeat this action point
>   - **cooldown**: Time between repeats
>
> [!WARNING]
> This tag has different behavior for bot_generator spawned bots versus populator spawned bots.  See bot_action_point on the VDC.
> For populator spawned bots, stay_time parameter does nothing
> For bot_generator spawned bots, duration < stay_time will override stay_time.

---

<a name="popext_fireinput"></a>

### popext_fireinput

```js
// Fires an entity input as soon as the bot spawns
// Requires target and action parameters, others are optional

// example usage
Tag "popext_fireinput{target = `bignet`, action = `RunScriptCode`, param = `ClientPrint(null, 3, \`I spawned one second ago!\`)`, delay = 1, activator = `activator_targetname_here`, caller = `caller_targetname_here`}"
```

---

<a name="popext_weaponresist"></a>

### popext_weaponresist

```js
// Makes the bot resistant to damage from specific weapons
// Requires weapon and amount parameters

// example usage
Tag "popext_weaponresist{weapon = `tf_weapon_minigun`, amount = 0.5}"
```

> [!NOTE]
> This gives 50% damage resistance to miniguns. Accepts item index, item classname, and string name found in item_map.nut.

---

<a name="popext_setskin"></a>

### popext_setskin

```js
// Sets a custom skin index for the bot
// Requires skin parameter

// example usage
Tag "popext_setskin{skin = 2}"
```

---

<a name="popext_dispenseroverride"></a>

### popext_dispenseroverride

```js
// Makes engineer bots build dispensers instead of other buildings
// Requires type parameter

// example usage
Tag "popext_dispenseroverride{type = OBJ_SENTRYGUN}"
```

---

<a name="popext_giveweapon"></a>

### popext_giveweapon

```js
// Gives the bot a weapon
// Requires weapon and id parameters

// example usage
Tag "popext_giveweapon{weapon = `tf_weapon_shotgun_pyro`, id = 425}"

// with custom attributes
Tag "popext_giveweapon{weapon = `tf_weapon_drg_pomson`, id = ID_POMSON_6000, attrs = {`fire rate bonus`: 0.6, `faster reload rate`: -0.8}}"
```

> [!WARNING]
> This does not work with custom weapons!

---

<a name="popext_meleewhenclose"></a>

### popext_meleewhenclose

```js
// Makes the bot switch to melee when enemies are close
// Requires distance parameter

// example usage
Tag "popext_meleewhenclose{distance = 250}"
```

---

<a name="popext_usebestweapon"></a>

### popext_usebestweapon

```js
// Makes the bot use the most appropriate weapon for different situations
// No parameters required

// example usage
Tag "popext_usebestweapon"
```

> [!NOTE]
> This replicates the rafmod UseBestWeapon 1 keyvalue.

---

<a name="popext_homingprojectile"></a>

### popext_homingprojectile

```js
// Makes the bot's projectiles home in on targets
// All parameters are optional

// example usage
Tag "popext_homingprojectile{turn_power = 1.0, speed_mult = 1.0, ignoreStealthedSpies = true, ignoreDisguisedSpies = false}"
```

> [!NOTE]
> See "HomingProjectiles" in util.nut for which projectiles will work with this tag.

---

<a name="popext_rocketcustomtrail"></a>

### popext_rocketcustomtrail

```js
// Applies a custom particle trail to rockets
// Requires name parameter

// example usage
Tag "popext_rocketcustomtrail{name = `eyeboss_projectile`}"
```

---

<a name="popext_customweaponmodel"></a>

### popext_customweaponmodel

```js
// Applies a custom model to a weapon
// Requires model parameter, slot is optional

// example usage
Tag "popext_customweaponmodel{model = `models/player/heavy.mdl`, slot = SLOT_SECONDARY}"
```

---

<a name="popext_spawnhere"></a>

### popext_spawnhere

```js
// Makes the bot spawn at a specific location
// Requires where parameter, others are optional

// example usage
Tag "popext_spawnhere{where = `ent_to_spawn_at`, spawn_uber_duration = 5.0}"
Tag "popext_spawnhere{where = `500 500 500`}"
```

---

<a name="popext_improvedairblast"></a>

### popext_improvedairblast

```js
// Improves Pyro bot airblast behavior
// Level parameter is optional, defaults to bot difficulty

// example usage
Tag "popext_improvedairblast{level = 3}"
Tag "popext_improvedairblast"
```

> [!NOTE]
> Levels: 1=Normal (deflect in FOV), 2=Advanced (snap to projectile), 3=Expert (redirect to sender)

---

<a name="popext_aimat"></a>

### popext_aimat

```js
// Makes the bot aim at a specific attachment point on targets
// Requires target parameter

// example usage
Tag "popext_aimat{target = `foot_L`}"
```

---

<a name="popext_warpaint"></a>

### popext_warpaint

```js
// Applies a warpaint to a bot's weapon
// Requires idx parameter, others are optional

// example usage
Tag "popext_warpaint{idx = 303, slot = 0, wear = 1.0, seed = `8873643875`}"
```

> [!NOTE]
> Texture wear values: 0.2=Factory New, 0.4=Minimal Wear, 0.6=Field-Tested, 0.8=Well-Worn, 1.0=Battle Scarred

---

<a name="popext_halloweenboss"></a>

### popext_halloweenboss

```js
// Spawns a Halloween boss associated with this bot
// Requires type, where, health, and boss_team parameters

// example usage
Tag "popext_halloweenboss{type = `headless_hatman`, where = `halloween_boss_spawnpoint`, health = 5000, duration = 100, boss_team = TF_TEAM_PVE_INVADERS}"
Tag "popext_halloweenboss{type = `merasmus`, where = `500 500 500`, health = `BOTHP`, duration = 60, boss_team = 5}"
```

---

<a name="popext_teleportnearvictim"></a>

### popext_teleportnearvictim

```js
// Makes the bot teleport near victims, similar to spy behavior
// No parameters required

// example usage
Tag "popext_teleportnearvictim"
```

---

<a name="popext_disbandsquadafter"></a>

### popext_disbandsquadafter

```js
// Disbands the bot's squad after a delay
// Requires delay parameter

// example usage
Tag "popext_disbandsquadafter{delay = 20}"
```

---

<a name="popext_leavesquadafter"></a>

### popext_leavesquadafter

```js
// Makes the bot leave its squad after a delay
// Requires delay parameter

// example usage
Tag "popext_leavesquadafter{delay = 20}"
```

---

<a name="popext_mission"></a>

### popext_mission

```js
// Assigns a mission to the bot
// Requires mission parameter, target is optional

// example usage
Tag "popext_mission{mission = MISSION_DESTROY_SENTRIES, target = `sentry_1`}"
```

---

<a name="popext_suicidecounter"></a>

### popext_suicidecounter

```js
// Damages the bot at regular intervals
// All parameters are optional

// example usage
Tag "popext_suicidecounter{interval = 0.5, amount = 2.0, damage_type = DMG_BURN, damage_custom = TF_DMG_CUSTOM_BURNING}"
```

---

<a name="popext_iconcount"></a>

### popext_iconcount

```js
// Sets wave icon spawn count
// Requires icon and count parameters

// example usage
Tag "popext_iconcount{icon = `scout`, count = 5}"
```

---

<a name="popext_changeattributes"></a>

### popext_changeattributes

```js
// Changes the bot's attributes
// Requires name parameter, others are optional

// example usage
Tag "popext_changeattributes{name = `AttribSetName`, delay = 10, cooldown = 10.0, repeats = 1, ifseetarget = false, ifhealthbelow = 100}"
```

---

<a name="popext_taunt"></a>

### popext_taunt

```js
// Makes the bot perform a taunt
// Requires id parameter, others are optional

// example usage
Tag "popext_taunt{id = 1015, delay = 1, cooldown = 10.0, repeats = 1, duration = 5}"
```

---

<a name="popext_playsequence"></a>

### popext_playsequence

```js
// Makes the bot play an animation sequence
// Requires sequence parameter, others are optional

// example usage
Tag "popext_playsequence{sequence = `primary_shoot`, playback_rate = 1.0, delay = 0, cooldown = 10.0, repeats = 1}"
``` 