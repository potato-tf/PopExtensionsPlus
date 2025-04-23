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

Adds a condition to the bot, duration optional.
TF_COND_REPROGRAMMED has special handling to change team.

```js
Tag "popext_addcond{cond = TF_COND_SPEED_BOOST, duration = 15}"
```

---

<a name="popext_reprogrammed"></a>

### popext_reprogrammed

Changes the bot to the defending team.
No parameters required.

```js
Tag "popext_reprogrammed"
```

>[!NOTE]
>This applies `ammo regen 999` to the bot automatically.  Use `popext_addcond{cond = TF_COND_REPROGRAMMED}` if you don't want this

---

<a name="popext_altfire"></a>

### popext_altfire

Makes the bot hold their secondary fire button.  Set duration to a very large number to always hold alt-fire.

```js
Tag "popext_altfire{duration = 30}" // hold for 30 seconds after spawning
```

>[!NOTE]
> See `popext_fireweapon` for a more comprehensive way to control button presses

---

<a name="popext_deathsound"></a>

### popext_deathsound

Customizes the sound played when the bot dies.
See EmitSoundEx for valid arguments.

```js
Tag "popext_deathsound{sound = `ui/chime_rd_2base_neg.wav`}"
```

---

<a name="popext_stepsound"></a>

### popext_stepsound

Customizes the sound played when the bot takes a step.
See EmitSoundEx for valid arguments.

```js
Tag "popext_stepsound{sound = `ui/chime_rd_2base_pos.wav`}"
```

> [!WARNING]
> Does not sync correctly for anything with reduced move speed (Giants).  Step sounds will always play at the same interval regardless of move speed penalties/bonuses.

---

<a name="popext_usehumanmodel"></a>

### popext_usehumanmodel

Makes the bot use the human player model instead of robot model.
No parameters required.

```js
Tag "popext_usehumanmodel"
```

---

<a name="popext_usecustommodel"></a>

### popext_usecustommodel

Applies a custom model to the bot.

```js
Tag "popext_usecustommodel{model = `models/player/heavy.mdl`}"
```

---

<a name="popext_usehumananims"></a>

### popext_usehumananims

Makes the bot use human animations while keeping robot appearance.
No parameters required.

```js
Tag "popext_usehumananims"
```

> [!WARNING]
> This tag is currently incompatible with popext_usecustommodel!

---

<a name="popext_alwaysglow"></a>

### popext_alwaysglow

Makes the bot permanently glow.
No parameters required.

```js
Tag "popext_alwaysglow"
```
> [!NOTE]
> This is the same effect as tank/bomb carrier outlines and is affected by the `glow_outline_effect_enable` client command.

---

<a name="popext_stripslot"></a>

### popext_stripslot

Removes the weapon in the specified slot.

```js
Tag "popext_stripslot{slot = SLOT_MELEE}"
```

---

<a name="popext_fireweapon"></a>

### popext_fireweapon

Makes the bot press a button with various conditions.
Only button parameter is required, others are optional.

```js
Tag "popext_fireweapon{button = IN_RELOAD, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, duration = 2}"
```

> [!NOTE]
> This makes the bot hold the reload key for 2 seconds every 10 seconds, 5 times, but only if below 100 HP.

---

<a name="popext_weaponswitch"></a>

### popext_weaponswitch

Makes the bot switch to a weapon with various conditions.
Only slot parameter is required, others are optional.

```js
Tag "popext_weaponswitch{slot = SLOT_SECONDARY, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100}"
```

---

<a name="popext_spell"></a>

### popext_spell

Makes the bot cast a spell.
Only type parameter is required, others are optional.
See constants.nut for spell type values.

```js
Tag "popext_spell{type = SPELL_SKELETON, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, charges = 5}"
```

---

<a name="popext_spawntemplate"></a>

### popext_spawntemplate

Spawns a point template from the global PointTemplates table parented to the bot.
Requires template parameter.

```js
Tag "popext_spawntemplate{template = `MyTemplateName`}"
```

---

<a name="popext_forceromevision"></a>

### popext_forceromevision

Forces romevision cosmetics on the bot regardless of player settings.
No parameters required.

```js
Tag "popext_forceromevision"
```
>[!NOTE]
> Romevision cosmetics do not apply to the bot ragdoll on death, this may be fixed in the future.

---

<a name="popext_customattr"></a>

### popext_customattr

Applies a custom attribute to a bot or its weapon.
Requires attribute and value parameters.
See customattributes.nut for a list of valid attributes.

```js
Tag "popext_customattr{attribute = `wet immunity`, value = 1}"
Tag "popext_customattr{weapon = `tf_weapon_scattergun`, attribute = `last shot crits`, value = 1, delay = 10}"
```

> [!NOTE]
> - Despite the name, this is also used for applying standard non-custom attributes
> - You can use either "attribute" or "attr" as the key name.
> - For custom warpaints on bots, use `popext_warpaint`

> [!WARNING]
> VScript cannot set string attribute types like `item name text override` or `meter_label`.  The only exception in this library is `custom projectile model`, as its functionality has been replaced.
> - `custom projectile model` must be applied with this tag if you intend to use it for anything except for Grenade or Sticky launchers.  Applying it normally through the bots `ItemAttributes` block will use vanilla behavior.
---

<a name="popext_ringoffire"></a>

### popext_ringoffire

Creates a damaging ring of fire around the bot.
Requires damage, interval, and radius parameters.

```js
Tag "popext_ringoffire{damage = 20, interval = 3, radius = 150}"
Tag "popext_ringoffire{damage = 20, interval = 3, radius = 150, hide_particle_effect = 1}"
```

> [!NOTE]
> The huo-long particle effect does not scale with radius! If you intend to use a custom effect, set "hide_particle_effect" to true.

---

<a name="popext_meleeai"></a>

### popext_meleeai

Bots will always target the closest enemy, similar to melee AI, rather than using the standard vision system.

```js
Tag "popext_meleeai{turnrate = 1500}"
```

---

<a name="popext_mobber"></a>

### popext_mobber

Makes the bot hunt down players.  All parameters are optional.

```js
Tag "popext_mobber{threat_type = `closest`, threat_dist = 256.0, lookat = false, turnrate = 150}"
```
Valid threat types are `closest` and `random`.  Default is `closest`.  `random` will pick a single random player on spawn and will not lose focus on them until the player dies.

---

<a name="popext_movetopoint"></a>

### popext_movetopoint

OBSOLETE - Use popext_actionpoint instead.
Makes the bot move to a specified point.
Requires target parameter.

```js
Tag "popext_movetopoint{target = `entity_to_move_to`}"
Tag "popext_movetopoint{target = `500 500 500`}"
```

---

<a name="popext_actionpoint"></a>

### popext_actionpoint

Creates an action point for the bot to move to.
Only target parameter is required, others are optional.
Action points control bot movement and targeting behaviors.

```js
Tag "popext_actionpoint{target = `action_point_targetname`}"
Tag "popext_actionpoint{target = `500 500 500`, next_action_point = `optional_next_action_point_targetname`, desired_distance = 50, duration = 10, command = `attack sentry at next action point`}"
```

Accepts entity handle, targetnames or x y z string coordinates for the target parameter
- Parameters:
    - **target**: Where to place the action point (required)
    - **aimtarget**: What the bot should aim at while at the action point
    - **killaimtarget**: Bitflag for buttons to press when the bot reaches the point (e.g., IN_ATTACK2)
        - Setting to 1 makes the bot use primary fire
        - See FButtons constants for valid button values
    - **alwayslook**: Whether the bot should always look at the aim target
    - **next_action_point**: Targetname of next action point to move to
    - **waituntildone**: Whether to wait until the action is complete
    - **distance/desired_distance**: How close the bot needs to be to count as "at" the point
    - **duration**: How long the bot stays at the point
    - **stay_time**: How long the bot stays at the point (note: ineffective for populator spawned bots)
    - **command**: What the bot should do at the action point
    - **delay**: Time before the bot is given this action point
    - **repeats**: How many times to repeat this action point
    - **cooldown**: Time between repeats

> [!WARNING]
> - This tag has different behavior for bot_generator spawned bots versus populator spawned bots.  See bot_action_point on the VDC.
> - For populator spawned bots, `stay_time` does nothing.  Use `duration` instead
> - For bot_generator spawned bots, `duration` < `stay_time` will override `stay_time`.

---

<a name="popext_fireinput"></a>

### popext_fireinput

Fires an entity input as soon as the bot spawns.
Requires target and action parameters, others are optional.

```js
Tag "popext_fireinput{target = `bignet`, action = `RunScriptCode`, param = `ClientPrint(null, 3, \`I spawned one second ago!\`)`, delay = 1, activator = `activator_targetname_here`, caller = `caller_targetname_here`}"
```
> [!NOTE]
> - `activator` and `caller` accept a string targetname and will call VScript's `Entities.FindByName` function internally.
> - `activator` and `caller` default to the bot if not specified
> - use `` target = `!self` `` to target the bot.

> [!CAUTION]
> - This does not handle nested quotes/backticks inside of the `param` very well if you intend to use RunScriptCode here.
> - Define your code in a separate global function in InitWaveOutput/another included script and do `` popext_fireinput{ target = `target_here`, action = `callscriptfunction` param = `FunctionNameHere`} ``

---

<a name="popext_weaponresist"></a>

### popext_weaponresist

Makes the bot resistant to damage from specific weapons.
Requires weapon and amount parameters.

```js
Tag "popext_weaponresist{weapon = `tf_weapon_minigun`, amount = 0.5}"
```

> [!NOTE]
> This gives 50% damage resistance to miniguns. Accepts item index, item classname, and string name found in item_map.nut.

---

<a name="popext_setskin"></a>

### popext_setskin

Sets a custom skin index for the bot.
Requires skin parameter.

```js
Tag "popext_setskin{skin = 2}"
```

---

<a name="popext_dispenseroverride"></a>

### popext_dispenseroverride

Makes engineer bots build dispensers instead of other buildings.
Requires type parameter.

```js
Tag "popext_dispenseroverride{type = OBJ_SENTRYGUN}"
```

---

<a name="popext_giveweapon"></a>

### popext_giveweapon

Gives the bot a weapon.
Requires weapon and id parameters.

```js
Tag "popext_giveweapon{weapon = `tf_weapon_shotgun_pyro`, id = 425}"

// with custom attributes
Tag "popext_giveweapon{weapon = `tf_weapon_drg_pomson`, id = ID_POMSON_6000, attrs = {`fire rate bonus`: 0.6, `faster reload rate`: -0.8}}"
```

> [!WARNING]
> This does not work with custom weapons!

---

<a name="popext_meleewhenclose"></a>

### popext_meleewhenclose

Makes the bot switch to melee when enemies are close.
Requires distance parameter.

```js
Tag "popext_meleewhenclose{distance = 250}"
```

---

<a name="popext_usebestweapon"></a>

### popext_usebestweapon

Makes the bot use the most appropriate weapon for different situations.
No parameters required.

```js
Tag "popext_usebestweapon"
```

> [!NOTE]
> This replicates the rafmod UseBestWeapon 1 keyvalue.

---

<a name="popext_homingprojectile"></a>

### popext_homingprojectile

Makes the bot's projectiles home in on targets.
All parameters are optional.

```js
Tag "popext_homingprojectile{turn_power = 1.0, speed_mult = 1.0, ignoreStealthedSpies = true, ignoreDisguisedSpies = false}"
```

> [!NOTE]
> See "HomingProjectiles" in util.nut for which projectiles will work with this tag.

---

<a name="popext_rocketcustomtrail"></a>

### popext_rocketcustomtrail

Applies a custom particle trail to rockets.
Requires name parameter.

```js
Tag "popext_rocketcustomtrail{name = `eyeboss_projectile`}"
```

---

<a name="popext_customweaponmodel"></a>

### popext_customweaponmodel

Applies a custom model to a weapon.
Requires model parameter, slot is optional.

```js
Tag "popext_customweaponmodel{model = `models/player/heavy.mdl`, slot = SLOT_SECONDARY}"
```

---

<a name="popext_spawnhere"></a>

### popext_spawnhere

Makes the bot spawn at a specific location.
Requires where parameter, others are optional.

```js
Tag "popext_spawnhere{where = `ent_to_spawn_at`, spawn_uber_duration = 5.0}"
Tag "popext_spawnhere{where = `500 500 500`}"
```

---

<a name="popext_improvedairblast"></a>

### popext_improvedairblast

Improves Pyro bot airblast behavior.
Level parameter is optional, defaults to bot difficulty.

```js
Tag "popext_improvedairblast{level = 3}"
Tag "popext_improvedairblast"
```

> [!NOTE]
> Levels: 1=Normal (deflect in FOV), 2=Advanced (snap to projectile), 3=Expert (redirect to sender)

---

<a name="popext_aimat"></a>

### popext_aimat

Makes the bot aim at a specific attachment point on targets.
Requires target parameter.

```js
Tag "popext_aimat{target = `foot_L`}"
```

---

<a name="popext_warpaint"></a>

### popext_warpaint

Applies a warpaint to a bot's weapon.
Requires idx parameter, others are optional.

```js
Tag "popext_warpaint{idx = 303, slot = 0, wear = 1.0, seed = `8873643875`}"
```

> [!NOTE]
> Texture wear values: 0.2=Factory New, 0.4=Minimal Wear, 0.6=Field-Tested, 0.8=Well-Worn, 1.0=Battle Scarred

---

<a name="popext_halloweenboss"></a>

### popext_halloweenboss

Spawns a Halloween boss associated with this bot.
Requires type, where, health, and boss_team parameters.

```js
Tag "popext_halloweenboss{type = `headless_hatman`, where = `halloween_boss_spawnpoint`, health = 5000, duration = 100, boss_team = TF_TEAM_PVE_INVADERS}"
Tag "popext_halloweenboss{type = `merasmus`, where = `500 500 500`, health = `BOTHP`, duration = 60, boss_team = 5}"
```

---

<a name="popext_teleportnearvictim"></a>

### popext_teleportnearvictim

Makes the bot teleport near victims, similar to spy behavior.
No parameters required.

```js
Tag "popext_teleportnearvictim"
```

---

<a name="popext_disbandsquadafter"></a>

### popext_disbandsquadafter

Disbands the bot's squad after a delay.
Requires delay parameter.

```js
Tag "popext_disbandsquadafter{delay = 20}"
```

---

<a name="popext_leavesquadafter"></a>

### popext_leavesquadafter

Makes the bot leave its squad after a delay.
Requires delay parameter.

```js
Tag "popext_leavesquadafter{delay = 20}"
```

---

<a name="popext_mission"></a>

### popext_mission

Assigns a mission to the bot.
Requires mission parameter, target is optional.

```js
Tag "popext_mission{mission = MISSION_DESTROY_SENTRIES, target = `sentry_1`}"
```

---

<a name="popext_suicidecounter"></a>

### popext_suicidecounter

Damages the bot at regular intervals.
All parameters are optional.

```js
Tag "popext_suicidecounter{interval = 0.5, amount = 2.0, damage_type = DMG_BURN, damage_custom = TF_DMG_CUSTOM_BURNING}"
```

---

<a name="popext_iconcount"></a>

### popext_iconcount

Sets wave icon spawn count.
Requires icon and count parameters.

```js
Tag "popext_iconcount{icon = `scout`, count = 5}"
```

---

<a name="popext_changeattributes"></a>

### popext_changeattributes

Changes the bot's attributes.
Requires name parameter, others are optional.

```js
Tag "popext_changeattributes{name = `AttribSetName`, delay = 10, cooldown = 10.0, repeats = 1, ifseetarget = false, ifhealthbelow = 100}"
```

---

<a name="popext_taunt"></a>

### popext_taunt

Makes the bot perform a taunt.
Requires id parameter, others are optional.

```js
Tag "popext_taunt{id = 1015, delay = 1, cooldown = 10.0, repeats = 1, duration = 5}"
```

---

<a name="popext_playsequence"></a>

### popext_playsequence

Makes the bot play an animation sequence.
Requires sequence parameter, others are optional.

```js
Tag "popext_playsequence{sequence = `primary_shoot`, playback_rate = 1.0, delay = 0, cooldown = 10.0, repeats = 1}"
``` 