# PopExtensionsPlus Documentation

*Documentation last updated [03.12.2024]*

A work-in-progress documentation for [PopExt](https://github.com/potato-tf/PopExtensionsPlus), so some areas are still being worked on. As updates to PopExt are made consistently, this documentation will also inevitably fall slightly behind.

For the above issues, typos, grammar mistakes, as well as bug reports in PopExt itself, please make a post in our [Discord](https://discord.gg/M8YbW3k) under "archive_restoration/PopExtensions Meta" or submit a pull request!
## Table of Contents

> [!NOTE]
> A section that does not have a link means that it does not exist in the documentation yet.

- [README and the example pop](#readme-and-the-example-pop)
- **Menus and references**
  - popextensions_main
  - botbehaviour
  - [customattributes](#custom-attributes)
  - customweapons
  - ent_additions
  - hooks
  - [missionattributes](#mission-attributes)
  - [popextensions](#popextensions-functions)
  - spawntemplate
  - [tags](#tags)
  - [util](#utility-functions)
  - [**Constants defined by PopExt**](#constants-defined-by-popext)
    - [attribute_map](#attribute_map)
    - [constants](#constants)
    - [item_map](#item_map)
    - [itemdef_constants](#itemdef_constants)
    - robotvoicelines
- Unfinished/undocumented features
  - populator - Heavily unfinished (but semi-functional) attempt at creating an entirely vscript controlled population file replacement.
  - tutorialtools - unfinished attempt at creating a structured tutorial flow system.  Wrappers around common tutorial based entities.

## README and the example pop

The [README](https://github.com/potato-tf/PopExtensionsPlus/blob/main/README.md) contains instruction to installation and usage, as well as a brief idea of what most of the sub-files do.

> [!WARNING]
> The README has not been maintained in a while and carries possibly outdated information.

The [example pop](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/population/mvm_bigrock_vscript.pop) demonstrates how most of the keyvalues work in a practical setting.

## [Custom Attributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut)

- [`fires milk bolt`](#PopExtAttributes.FiresMilkBolt)
- [`mod teleporter speed boost`](#PopExtAttributes.ModTeleporterSpeedBoost)
- [`set turn to ice`](#PopExtAttributes.SetTurnToIce)
- [`mult teleporter recharge rate`](#PopExtAttributes.MultTeleporterRechargeTime)
- [`melee cleave attack`](#PopExtAttributes.MeleeCleaveAttack)
- [`last shot crits`](#PopExtAttributes.LastShotCrits)
- [`wet immunity`](#PopExtAttributes.WetImmunity)
- [`can breathe under water`](#PopExtAttributes.CanBreatheUnderWater)
- [`mult swim speed`](#PopExtAttributes.MultSwimSpeed)
- [`teleport instead of die`](#PopExtAttributes.TeleportInsteadOfDie)
- [`mult dmg vs same class`](#PopExtAttributes.MultDmgVsSameClass)
- [`uber on damage taken`](#PopExtAttributes.UberOnDamageTaken)
- [`build small sentries`](#PopExtAttributes.BuildSmallSentries)
- [`crit when health below`](#PopExtAttributes.CritWhenHealthBelow)
- [`mvm sentry ammo`](#PopExtAttributes.MvmSentryAmmo)
- [`radius sleeper`](#PopExtAttributes.RadiusSleeper)
- [`explosive bullets`](#PopExtAttributes.ExplosiveBullets)
- [`old sandman stun`](#PopExtAttributes.OldSandmanStun)
- [`stun on hit`](#PopExtAttributes.StunOnHit)
- [`is miniboss`](#PopExtAttributes.IsMiniboss)
- [`replace weapon fire sound`](#PopExtAttributes.ReplaceWeaponFireSound)
- [`is invisible`](#PopExtAttributes.IsInvisible)
- [`cannot upgrade`](#PopExtAttributes.CannotUpgrade)
- [`always crit`](#PopExtAttributes.AlwaysCrit)
- [`dont count damage towards crit rate`](#PopExtAttributes.DontCountDamageTowardsCritRate)
- [`no damage falloff`](#PopExtAttributes.NoDamageFalloff)
- [`can headshot`](#PopExtAttributes.CanHeadshot)
- [`cannot headshot`](#PopExtAttributes.CannotHeadshot)
- [`cannot be headshot`](#PopExtAttributes.CannotBeHeadshot)
- [`projectile lifetime`](#PopExtAttributes.ProjectileLifetime)
- [`mult dmg vs tanks`](#PopExtAttributes.MultDmgVsTanks)
- [`mult dmg vs giants`](#PopExtAttributes.MultDmgVsGiants)
- [`mult dmg vs airborne`](#PopExtAttributes.MultDmgVsAirborne)
- [`set damage type`](#PopExtAttributes.SetDamageType)
- [`set damage type custom`](#PopExtAttributes.SetDamageTypeCustom)
- [`reloads full clip at once`](#PopExtAttributes.ReloadsFullClipAtOnce)
- [`fire full clip at once`](#PopExtAttributes.FireFullClipAtOnce)
- [`passive reload`](#PopExtAttributes.PassiveReload)
- [`mult projectile scale`](#PopExtAttributes.MultProjectileScale)
- [`mult building scale`](#PopExtAttributes.MultBuildingScale)
- [`mult crit dmg`](#PopExtAttributes.MultCritDmg)
- [`arrow ignite`](#PopExtAttributes.ArrowIgnite)
- [`add cond on hit`](#PopExtAttributes.AddCondOnHit)
- [`remove cond on hit`](#PopExtAttributes.RemoveCondOnHit)
- [`self add cond on hit`](#PopExtAttributes.SelfAddCondOnHit)
- [`add cond on kill`](#PopExtAttributes.SelfAddCondOnKill)
- [`add cond when active`](#PopExtAttributes.AddCondWhenActive)
- [`fire input on hit`](#PopExtAttributes.FireInputOnHit)
- [`fire input on kill`](#PopExtAttributes.FireInputOnKill)
- [`rocket penetration`](#PopExtAttributes.RocketPenetration)
- [`collect currency on kill`](#PopExtAttributes.CollectCurrencyOnKill)
- [`noclip projectile`](#PopExtAttributes.NoclipProjectile)
- [`projectile gravity`](#PopExtAttributes.ProjectileGravity)
- [`immune to cond`](#PopExtAttributes.ImmuneToCond)
- [`mult max health`](#PopExtAttributes.MultMaxHealth)
- [`special item description`](#PopExtAttributes.SpecialItemDescription)
- [`alt-fire disabled`](#PopExtAttributes.AltFireDisabled)
- [`custom projectile model`](#PopExtAttributes.CustomProjectileModel)
- [`dmg bonus while half dead`](#PopExtAttributes.DmgBonusWhileHalfDead)
- [`dmg penalty while half alive`](#PopExtAttributes.DmgPenaltyWhileHalfAlive)

## [Mission Attributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/missionattributes.nut)

- [`ForceHoliday`](#MissionAttributes.ForceHoliday)
- [`YERDisguiseFix`](#MissionAttributes.YERDisguiseFix)
- [`LooseCannonFix`](#MissionAttributes.LooseCannonFix)
- [`BotGibFix`](#MissionAttributes.BotGibFix)
- [`HolidayPunchFix`](#MissionAttributes.HolidayPunchFix)
- [`EnableGlobalFixes`](#MissionAttributes.EnableGlobalFixes)
- [`DragonsFuryFix`](#MissionAttributes.DragonsFuryFix)
- [`FastNPCUpdate`](#MissionAttributes.FastNPCUpdate)
- [`NoCreditVelocity`](#MissionAttributes.NoCreditVelocity)
- [`ScoutBetterMoneyCollection`](#MissionAttributes.ScoutBetterMoneyCollection)
- [`HoldFireUntilFullReloadFix`](#MissionAttributes.HoldFireUntilFullReloadFix)
- [`EngineerBuildingPushbackFix`](#MissionAttributes.EngineerBuildingPushbackFix)
- [`RedBotsNoRandomCrit`](#MissionAttributes.RedBotsNoRandomCrit)
- [`NoCrumpkins`](#MissionAttributes.NoCrumpkins)
- [`NoReanimators`](#MissionAttributes.NoReanimators)
- [`AllMobber`](#MissionAttributes.AllMobber)
- [`StandableHeads`](#MissionAttributes.StandableHeads)
- [`666Wavebar`](#MissionAttributes.666Wavebar)
- [`WaveNum`](#MissionAttributes.WaveNum)
- [`MaxWaveNum`](#MissionAttributes.MaxWaveNum)
- [`HuntsmanDamageFix`](#MissionAttributes.HuntsmanDamageFix)
- [`NegativeDmgHeals`](#MissionAttributes.NegativeDmgHeals)
- [`MultiSapper`](#MissionAttributes.MultiSapper)
- [`SetDamageTypeIgniteFix`](#MissionAttributes.SetDamageTypeIgniteFix)
- [`NoRefunds`](#MissionAttributes.NoRefunds)
- [`RefundLimit`](#MissionAttributes.RefundLimit)
- [`RefundGoal`](#MissionAttributes.RefundGoal)
- [`FixedBuybacks`](#MissionAttributes.FixedBuybacks)
- [`BuybacksPerWave`](#MissionAttributes.BuybacksPerWave)
- [`NoBuybacks`](#MissionAttributes.NoBuybacks)
- [`DeathPenalty`](#MissionAttributes.DeathPenalty)
- [`BonusRatioHalf`](#MissionAttributes.BonusRatioHalf)
- [`BonusRatioFull`](#MissionAttributes.BonusRatioFull)
- [`UpgradeFile`](#MissionAttributes.UpgradeFile)
- [`FlagEscortCount`](#MissionAttributes.FlagEscortCount)
- [`BombMovementPenalty`](#MissionAttributes.BombMovementPenalty)
- [`MaxSkeletons`](#MissionAttributes.MaxSkeletons)
- [`TurboPhysics`](#MissionAttributes.TurboPhysics)
- [`Accelerate`](#MissionAttributes.Accelerate)
- [`AirAccelerate`](#MissionAttributes.AirAccelerate)
- [`BotPushaway`](#MissionAttributes.BotPushaway)
- [`TeleUberDuration`](#MissionAttributes.TeleUberDuration)
- [`RedMaxPlayers`](#MissionAttributes.RedMaxPlayers)
- [`MaxVelocity`](#MissionAttributes.MaxVelocity)
- [`ConchHealthOnHitRegen`](#MissionAttributes.ConchHealthOnHitRegen)
- [`MarkForDeathLifetime`](#MissionAttributes.MarkForDeathLifetime)
- [`GrapplingHookEnable`](#MissionAttributes.GrapplingHookEnable)
- [`GiantScale`](#MissionAttributes.GiantScale)
- [`VacNumCharges`](#MissionAttributes.VacNumCharges)
- [`DoubleDonkWindow`](#MissionAttributes.DoubleDonkWindow)
- [`ConchSpeedBoost`](#MissionAttributes.ConchSpeedBoost)
- [`StealthDmgReduction`](#MissionAttributes.StealthDmgReduction)
- [`FlagCarrierCanFight`](#MissionAttributes.FlagCarrierCanFight)
- [`HHHChaseRange`](#MissionAttributes.HHHChaseRange)
- [`HHHAttackRange`](#MissionAttributes.HHHAttackRange)
- [`HHHQuitRange`](#MissionAttributes.HHHQuitRange)
- [`HHHTerrifyRange`](#MissionAttributes.HHHTerrifyRange)
- [`HHHHealthBase`](#MissionAttributes.HHHHealthBase)
- [`HHHHealthPerPlayer`](#MissionAttributes.HHHHealthPerPlayer)
- [`HalloweenBossNotSolidToPlayers`](#MissionAttributes.HalloweenBossNotSolidToPlayers)
- [`SentryHintBombForwardRange`](#MissionAttributes.SentryHintBombForwardRange)
- [`SentryHintBombBackwardRange`](#MissionAttributes.SentryHintBombBackwardRange)
- [`SentryHintMinDistanceFromBomb`](#MissionAttributes.SentryHintMinDistanceFromBomb)
- [`NoBusterFF`](#MissionAttributes.NoBusterFF)
- [`SniperHideLasers`](#MissionAttributes.SniperHideLasers)
- [`TeamWipeWaveLoss`](#MissionAttributes.TeamWipeWaveLoss)
- [`GiantSentryKillCountOffset`](#MissionAttributes.GiantSentryKillCountOffset)
- [`FlagResetTime`](#MissionAttributes.FlagResetTime)
- [`BotHeadshots`](#MissionAttributes.BotHeadshots)
- [`PlayersAreRobots`](#MissionAttributes.PlayersAreRobots)
- [`BotsAreHumans`](#MissionAttributes.BotsAreHumans)
- [`NoRome`](#MissionAttributes.NoRome)
- [`SpellRateCommon`](#MissionAttributes.SpellRateCommon)
- [`SpellRateGiant`](#MissionAttributes.SpellRateGiant)
- [`RareSpellRateCommon`](#MissionAttributes.RareSpellRateCommon)
- [`RareSpellRateGiant`](#MissionAttributes.RareSpellRateGiant)
- [`NoSkeleSplit`](#MissionAttributes.NoSkeleSplit)
- [`WaveStartCountdown`](#MissionAttributes.WaveStartCountdown)
- [`ExtraTankPath`](#MissionAttributes.ExtraTankPath)
- [`HandModelOverride`](#MissionAttributes.HandModelOverride)
- [`AddCond`](#MissionAttributes.AddCond)
- [`PlayerAttributes`](#MissionAttributes.PlayerAttributes)
- [`ItemAttributes`](#MissionAttributes.ItemAttributes)
- [`LoadoutControl`](#MissionAttributes.LoadoutControl)
- [`SoundOverrides`](#MissionAttributes.SoundOverrides)
- [`NoThrillerTaunt`](#MissionAttributes.NoThrillerTaunt)
- [`EnableRandomCrits`](#MissionAttributes.EnableRandomCrits)
- [`ForceRedMoney`](#MissionAttributes.ForceRedMoney)
- [`ReverseMVM`](#MissionAttributes.ReverseMVM)
- [`ClassLimits`](#MissionAttributes.ClassLimits)
- [`ShowHiddenAttributes`](#MissionAttributes.ShowHiddenAttributes)
- [`HideRespawnText`](#MissionAttributes.HideRespawnText)

## [PopExtensions Functions](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/popextensions.nut)

back-and-forth links

## [Tags](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/tags.nut)

- [`popext_addcond`](#Tag-popext_addcond)
- [`popext_reprogrammed`](#Tag-popext_reprogrammed)
- [`popext_altfire`](#Tag-popext_altfire)
- [`popext_deathsound`](#Tag-popext_deathsound)
- [`popext_stepsound`](#Tag-popext_stepsound)
- [`popext_usehumanmodel`](#Tag-popext_usehumanmodel)
- [`popext_usecustommodel`](#Tag-popext_usecustommodel)
- [`popext_usehumananims`](#Tag-popext_usehumananims)
- [`popext_bonemergemodel`](#Tag-popext_bonemergemodel)
- [`popext_alwaysglow`](#Tag-popext_alwaysglow)
- [`popext_stripslot`](#Tag-popext_stripslot)
- [`popext_fireweapon`](#Tag-popext_fireweapon)
- [`popext_weaponswitch`](#Tag-popext_weaponswitch)
- [`popext_spell`](#Tag-popext_spell)
- [`popext_spawntemplate`](#Tag-popext_spawntemplate)
- [`popext_forceromevision`](#Tag-popext_forceromevision)
- [`popext_customattr`](#Tag-popext_customattr)
- [`popext_ringoffire`](#Tag-popext_ringoffire)
- [`popext_meleeai`](#Tag-popext_meleeai)
- [`popext_mobber`](#Tag-popext_mobber)
- [`popext_movetopoint`](#Tag-popext_movetopoint)
- [`popext_actionpoint`](#Tag-popext_actionpoint)
- [`popext_fireinput`](#Tag-popext_fireinput)
- [`popext_weaponresist`](#Tag-popext_weaponresist)
- [`popext_setskin`](#Tag-popext_setskin)
- [`popext_doubledonk`](#Tag-popext_doubledonk)
- [`popext_dispenseroverride`](#Tag-popext_dispenseroverride)
- [`popext_giveweapon`](#Tag-popext_giveweapon)
- [`popext_meleewhenclose`](#Tag-popext_meleewhenclose)
- [`popext_usebestweapon`](#Tag-popext_usebestweapon)
- [`popext_homingprojectile`](#Tag-popext_homingprojectile)
- [`popext_rocketcustomtrail`](#Tag-popext_rocketcustomtrail)
- [`popext_customweaponmodel`](#Tag-popext_customweaponmodel)
- [`popext_spawnhere`](#Tag-popext_spawnhere)
- [`popext_improvedairblast`](#Tag-popext_improvedairblast)
- [`popext_aimat`](#Tag-popext_aimat)
- [`popext_warpaint`](#Tag-popext_warpaint)
- [`popext_halloweenboss`](#Tag-popext_halloweenboss)
- [`popext_teleportnearvictim`](#Tag-popext_teleportnearvictim)
- [`popext_disbandsquadafter`](#Tag-popext_disbandsquadafter)
- [`popext_leavesquadafter`](#Tag-popext_leavesquadafter)
- [`popext_mission`](#Tag-popext_mission)
- [`popext_suicidecounter`](#Tag-popext_suicidecounter)
- [`popext_iconcount`](#Tag-popext_iconcount)
- [`popext_changeattributes`](#Tag-popext_changeattributes)
- [`popext_taunt`](#Tag-popext_taunt)
- [`popext_playsequence`](#Tag-popext_playsequence)
- [`popext_ignore`](#Tag-popext_ignore)
- [`popext_iconoverride`](#Tag-popext_iconoverride)

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
> Tags have a length limit of 256 characters.  If you see console errors mentioning `QUIET_TRUNCATION`, or the multi-line tag is cut short in the vscript error printed to console, your tag is too long.
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

>[!CAUTION]
> The older pipe syntax is DEPRECATED and will not be supported going forward, many of the more recently added tags already do not support it.
> - `popext_addcond|32|10` for example would instead become `popext_addcond{cond = 32 duration = 10}`.
> - Simpler, older tags such as `popext_addcond` may still work for the time being, but this will likely change in the future.  You should migrate to the new syntax as soon as possible
---

<a name="Tag popext_addcond"></a>

### popext_addcond

Adds a condition to the bot, duration optional.
TF_COND_REPROGRAMMED has special handling to change team.

```js
Tag "popext_addcond{cond = TF_COND_SPEED_BOOST, duration = 15}"
```

---

<a name="Tag popext_reprogrammed"></a>

### popext_reprogrammed

Changes the bot to the defending team.
No parameters required.

```js
Tag "popext_reprogrammed"
```

>[!NOTE]
>Additional behavior/attributes set:
> - `ammo regen 999`
> - `cannot pick up intelligence 1`.
> -
> Use `popext_addcond{cond = TF_COND_REPROGRAMMED}` if you don't want this

---

<a name="Tag popext_altfire"></a>

### popext_altfire

Makes the bot hold their secondary fire button.  Set duration to a very large number to always hold alt-fire.

```js
Tag "popext_altfire{duration = 30}" // hold for 30 seconds after spawning
```

>[!NOTE]
> See `popext_fireweapon` for a more comprehensive way to control button presses

---

<a name="Tag popext_deathsound"></a>

### popext_deathsound

Customizes the sound played when the bot dies.
See EmitSoundEx for valid arguments.

```js
Tag "popext_deathsound{sound = `ui/chime_rd_2base_neg.wav`}"
```

---

<a name="Tag popext_stepsound"></a>

### popext_stepsound

Customizes the sound played when the bot takes a step.
See EmitSoundEx for valid arguments.

```js
Tag "popext_stepsound{sound = `ui/chime_rd_2base_pos.wav`}"
```

> [!WARNING]
> Does not sync correctly for anything with reduced move speed (Giants).  Step sounds will always play at the same interval regardless of move speed penalties/bonuses.

---

<a name="Tag popext_usehumanmodel"></a>

### popext_usehumanmodel

Makes the bot use the human player model instead of robot model.
No parameters required.

```js
Tag "popext_usehumanmodel"
```

---

<a name="Tag popext_usecustommodel"></a>

### popext_usecustommodel

Applies a custom model to the bot.

```js
Tag "popext_usecustommodel{model = `models/player/heavy.mdl`}"
```

---

<a name="Tag popext_usehumananims"></a>

### popext_usehumananims

Makes the bot use human animations while keeping robot appearance.
No parameters required.

```js
Tag "popext_usehumananims"
```

> [!WARNING]
> This tag is currently incompatible with popext_usecustommodel!

---

<a name="Tag popext_bonemergemodel"></a>

### popext_bonemergemodel

Expanded version of popext_usehumananims and popext_usecustommodel, accepts a custom animation base on any model.
`apply_to_ragdoll` is optional, defaults to true.

> [!NOTE]
> By default, the bots ragdoll will be set to the `bonemerge_model` parameter.  Set `apply_to_ragdoll` to false to disable this.

```js
// bot will play sniper animations on a bot heavy model
Tag "popext_bonemergemodel{anim_set = `models/player/sniper.mdl`, bonemerge_model = `models/bots/heavy/bot_heavy.mdl`, apply_to_ragdoll = true}"
```

---

<a name="Tag popext_alwaysglow"></a>

### popext_alwaysglow

Makes the bot permanently glow.
If no color is specified, uses default team-colored glow.

```js
// bot will always show glow outline
Tag "popext_alwaysglow"

// bot will always show glow outline in red
Tag "popext_alwaysglow{color = `FF0000`}"
```
> [!NOTE]
> - This is the same effect as tank/bomb carrier outlines and is affected by the `glow_outline_effect_enable` client command.
> - Accepts hex or integer color values.

---

<a name="Tag popext_stripslot"></a>

### popext_stripslot

Removes the weapon in the specified slot.

```js
Tag "popext_stripslot{slot = SLOT_MELEE}"
```

---

<a name="Tag popext_fireweapon"></a>

### popext_fireweapon

Makes the bot press a button with various conditions.
Only the button parameter is required, others are optional.

```js
Tag "popext_fireweapon{button = IN_RELOAD, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, duration = 2}"
```

> [!NOTE]
> This makes the bot hold the reload key for 2 seconds every 10 seconds, 5 times, but only if below 100 HP.

---

<a name="Tag popext_weaponswitch"></a>

### popext_weaponswitch

Makes the bot switch to a weapon with various conditions.
Only slot parameter is required, others are optional.

```js
Tag "popext_weaponswitch{slot = SLOT_SECONDARY, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100}"
```

---

<a name="Tag popext_spell"></a>

### popext_spell

Makes the bot cast a spell.
Only type parameter is required, others are optional.
See constants.nut for spell type values.

```js
Tag "popext_spell{type = SPELL_SKELETON, cooldown = 3, delay = 10, repeats = 5, ifhealthbelow = 100, charges = 5}"
```

---

<a name="Tag popext_spawntemplate"></a>

### popext_spawntemplate

Spawns a point template from the global PointTemplates table parented to the bot.
Requires template parameter.

```js
Tag "popext_spawntemplate{template = `MyTemplateName`}"
```

---

<a name="Tag popext_forceromevision"></a>

### popext_forceromevision

Forces romevision cosmetics on the bot regardless of player settings.
No parameters required.

```js
Tag "popext_forceromevision"
```
>[!NOTE]
> Romevision cosmetics do not apply to the bot ragdoll on death, this may be fixed in the future.

---

<a name="Tag popext_customattr"></a>

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

<a name="Tag popext_ringoffire"></a>

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

<a name="Tag popext_meleeai"></a>

### popext_meleeai

Bots will always target the closest enemy, similar to melee AI, rather than using the standard vision system.

```js
Tag "popext_meleeai{turnrate = 1500}"
```

---

<a name="Tag popext_mobber"></a>

### popext_mobber

Makes the bot hunt down players.  All parameters are optional.

```js
Tag "popext_mobber{threat_type = `closest`, threat_dist = 256.0, lookat = false, turnrate = 150}"
```
Valid threat types are `closest` and `random`.  Default is `closest`.  `random` will pick a single random player on spawn and will not lose focus on them until the player dies.

---

<a name="Tag popext_movetopoint"></a>

### popext_movetopoint

OBSOLETE - Use popext_actionpoint instead.
Makes the bot move to a specified point.
Requires target parameter.

```js
Tag "popext_movetopoint{target = `entity_to_move_to`}"
Tag "popext_movetopoint{target = `500 500 500`}"
```

---

<a name="Tag popext_actionpoint"></a>

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

<a name="Tag popext_fireinput"></a>

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

<a name="Tag popext_weaponresist"></a>

### popext_weaponresist

Makes the bot resistant to damage from specific weapons.
Requires weapon and amount parameters.

```js
Tag "popext_weaponresist{weapon = `tf_weapon_minigun`, amount = 0.5}"
```

> [!NOTE]
> This gives 50% damage resistance to miniguns. Accepts item index, item classname, and string name found in item_map.nut.

---

<a name="Tag popext_setskin"></a>

### popext_setskin

Sets a custom skin index for the bot.
Requires skin parameter.

```js
Tag "popext_setskin{skin = 2}"
```

---

<a name="Tag popext_dispenseroverride"></a>

### popext_dispenseroverride

Makes engineer bots build dispensers instead of other buildings.
Requires type parameter.

```js
Tag "popext_dispenseroverride{type = OBJ_SENTRYGUN}"
```

---

<a name="Tag popext_giveweapon"></a>

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

<a name="Tag popext_meleewhenclose"></a>

### popext_meleewhenclose

Makes the bot switch to melee when enemies are close.
Requires distance parameter.

```js
Tag "popext_meleewhenclose{distance = 250}"
```

---

<a name="Tag popext_usebestweapon"></a>

### popext_usebestweapon

Makes the bot use the most appropriate weapon for different situations.
No parameters required.

```js
Tag "popext_usebestweapon"
```

> [!NOTE]
> This replicates the rafmod UseBestWeapon 1 keyvalue.

---

<a name="Tag popext_homingprojectile"></a>

### popext_homingprojectile

Makes the bot's projectiles home in on targets.
All parameters are optional.

```js
Tag "popext_homingprojectile{turn_power = 1.0, speed_mult = 1.0, ignoreStealthedSpies = true, ignoreDisguisedSpies = false}"
```

> [!NOTE]
> See "HomingProjectiles" in util.nut for which projectiles will work with this tag.

---

<a name="Tag popext_rocketcustomtrail"></a>

### popext_rocketcustomtrail

Applies a custom particle trail to rockets.
Requires name parameter.

```js
Tag "popext_rocketcustomtrail{name = `eyeboss_projectile`}"
```

---

<a name="Tag popext_customweaponmodel"></a>

### popext_customweaponmodel

Applies a custom model to a weapon.
Requires model parameter, slot is optional.

```js
Tag "popext_customweaponmodel{model = `models/player/heavy.mdl`, slot = SLOT_SECONDARY}"
```

---

<a name="Tag popext_spawnhere"></a>

### popext_spawnhere

Makes the bot spawn at a specific location.
Requires where parameter, others are optional.

```js
Tag "popext_spawnhere{where = `ent_to_spawn_at`, spawn_uber_duration = 5.0}"
Tag "popext_spawnhere{where = `500 500 500`}"
```

---

<a name="Tag popext_improvedairblast"></a>

### popext_improvedairblast

Improves Pyro bot airblast behavior.
Each level applies progressively stronger airblasting behavior to bots
If `level` is not specified this will default to the bots skill level (Normal/Hard/Expert)

```js
Tag "popext_improvedairblast{level = 3}"
Tag "popext_improvedairblast"
```

> [!NOTE]
> Levels:
> - 1=Normal (deflect in FOV)
> - 2=Advanced (snap to projectile)
> - 3=Expert (redirect to sender)

---

<a name="Tag popext_aimat"></a>

### popext_aimat

Makes the bot aim at a specific attachment point on targets.
Requires target parameter.

```js
Tag "popext_aimat{target = `foot_L`}"
```

---

<a name="Tag popext_warpaint"></a>

### popext_warpaint

Applies a warpaint to a bot's weapon.
Requires idx parameter, others are optional.

```js
Tag "popext_warpaint{idx = 303, slot = 0, wear = 1.0, seed = `8873643875`}"
```

> [!NOTE]
> Texture wear values: 0.2=Factory New, 0.4=Minimal Wear, 0.6=Field-Tested, 0.8=Well-Worn, 1.0=Battle Scarred

---

<a name="Tag popext_halloweenboss"></a>

### popext_halloweenboss

Spawns a Halloween boss associated with this bot.
Requires type, where, health, and boss_team parameters.

```js
Tag "popext_halloweenboss{type = `headless_hatman`, where = `halloween_boss_spawnpoint`, health = 5000, duration = 100, boss_team = TF_TEAM_PVE_INVADERS}"
Tag "popext_halloweenboss{type = `merasmus`, where = `500 500 500`, health = `BOTHP`, duration = 60, boss_team = 5}"
```

---

<a name="Tag popext_teleportnearvictim"></a>

### popext_teleportnearvictim

Makes the bot teleport near victims, similar to spy behavior.
No parameters required.

```js
Tag "popext_teleportnearvictim"
```

---

<a name="Tag popext_disbandsquadafter"></a>

### popext_disbandsquadafter

Disbands the bot's squad after a delay.
Requires delay parameter.

```js
Tag "popext_disbandsquadafter{delay = 20}"
```

---

<a name="Tag popext_leavesquadafter"></a>

### popext_leavesquadafter

Makes the bot leave its squad after a delay.
Requires delay parameter.

```js
Tag "popext_leavesquadafter{delay = 20}"
```

---

<a name="Tag popext_mission"></a>

### popext_mission

Assigns a mission to the bot.
Requires mission parameter, target is optional.

```js
Tag "popext_mission{mission = MISSION_DESTROY_SENTRIES, target = `sentry_1`}"
```

---

<a name="Tag popext_suicidecounter"></a>

### popext_suicidecounter

Damages the bot at regular intervals.
All parameters are optional.

```js
Tag "popext_suicidecounter{interval = 0.5, amount = 2.0, damage_type = DMG_BURN, damage_custom = TF_DMG_CUSTOM_BURNING}"
```

---

<a name="Tag popext_iconcount"></a>

### popext_iconcount

Sets wave icon spawn count.
Requires icon and count parameters.

```js
Tag "popext_iconcount{icon = `scout`, count = 5}"
```

---

<a name="Tag popext_changeattributes"></a>

### popext_changeattributes

Changes the bot's attributes.
Requires name parameter, others are optional.

```js
Tag "popext_changeattributes{name = `AttribSetName`, delay = 10, cooldown = 10.0, repeats = 1, ifseetarget = false, ifhealthbelow = 100}"
```

---

<a name="Tag popext_taunt"></a>

### popext_taunt

Makes the bot perform a taunt.
Requires id parameter, others are optional.

```js
Tag "popext_taunt{id = 1015, delay = 1, cooldown = 10.0, repeats = 1, duration = 5}"
```

---

<a name="Tag popext_playsequence"></a>

### popext_playsequence

Makes the bot play an animation sequence.
Requires sequence parameter, others are optional.

```js
Tag "popext_playsequence{sequence = `primary_shoot`, playback_rate = 1.0, delay = 0, cooldown = 10.0, repeats = 1}"
```

## [Utility](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/util.nut) functions

### Methods

- [`PopExtUtil.IsLinuxServer`](#PopExtUtil.IsLinuxServer)
- [`PopExtUtil.ShowMessage`](#PopExtUtil.ShowMessage)
- [`PopExtUtil.ForceChangeClass`](#PopExtUtil.ForceChangeClass)
- [`PopExtUtil.PlayerClassCount`](#PopExtUtil.PlayerClassCount)
- [`PopExtUtil.ChangePlayerTeamMvM`](#PopExtUtil.ChangePlayerTeamMvM)
- [`PopExtUtil.ShowChatMessage`](#PopExtUtil.ShowChatMessage)
- [`PopExtUtil.CopyTable`](#PopExtUtil.CopyTable)
- [`PopExtUtil.HexToRgb`](#PopExtUtil.HexToRgb)
- [`PopExtUtil.CountAlivePlayers`](#PopExtUtil.CountAlivePlayers)
- [`PopExtUtil.CountAliveBots`](#PopExtUtil.CountAliveBots)
- [`PopExtUtil.SetParentLocalOriginDo`](#PopExtUtil.SetParentLocalOriginDo)
- [`PopExtUtil.SetParentLocalOrigin`](#PopExtUtil.SetParentLocalOrigin)
- [`PopExtUtil.SetupTriggerBounds`](#PopExtUtil.SetupTriggerBounds)
- [`PopExtUtil.PrintTable`](#PopExtUtil.PrintTable)
- [`PopExtUtil.DoPrintTable`](#PopExtUtil.DoPrintTable)
- [`PopExtUtil.CreatePlayerWearable`](#PopExtUtil.CreatePlayerWearable)
- [`PopExtUtil.StripWeapon`](#PopExtUtil.StripWeapon)
- [`PopExtUtil.SetPlayerAttributes`](#PopExtUtil.SetPlayerAttributes)
- [`PopExtUtil.WeaponSwitchSlot`](#PopExtUtil.WeaponSwitchSlot)
- [`PopExtUtil.Explanation`](#PopExtUtil.Explanation)
- [`PopExtUtil.Info`](#PopExtUtil.Info)
- [`PopExtUtil.IsAlive`](#PopExtUtil.IsAlive)
- [`PopExtUtil.IsDucking`](#PopExtUtil.IsDucking)
- [`PopExtUtil.IsOnGround`](#PopExtUtil.IsOnGround)
- [`PopExtUtil.RemoveAmmo`](#PopExtUtil.RemoveAmmo)
- [`PopExtUtil.GetAllEnts`](#PopExtUtil.GetAllEnts)
- [`PopExtUtil._SetOwner`](#PopExtUtil._SetOwner)
- [`PopExtUtil.ShowAnnotation`](#PopExtUtil.ShowAnnotation)
- [`PopExtUtil.HideAnnotation`](#PopExtUtil.HideAnnotation)
- [`PopExtUtil.GetPlayerName`](#PopExtUtil.GetPlayerName)
- [`PopExtUtil.SetPlayerName`](#PopExtUtil.SetPlayerName)
- [`PopExtUtil.GetPlayerUserID`](#PopExtUtil.GetPlayerUserID)
- [`PopExtUtil.PlayerRespawn`](#PopExtUtil.PlayerRespawn)
- [`PopExtUtil.DisableCloak`](#PopExtUtil.DisableCloak)
- [`PopExtUtil.InUpgradeZone`](#PopExtUtil.InUpgradeZone)
- [`PopExtUtil.InButton`](#PopExtUtil.InButton)
- [`PopExtUtil.PressButton`](#PopExtUtil.PressButton)
- [`PopExtUtil.ReleaseButton`](#PopExtUtil.ReleaseButton)
- [`PopExtUtil.IsPointInRespawnRoom`](#PopExtUtil.IsPointInRespawnRoom)
- [`PopExtUtil.SwitchWeaponSlot`](#PopExtUtil.SwitchWeaponSlot)
- [`PopExtUtil.GetItemInSlot`](#PopExtUtil.GetItemInSlot)
- [`PopExtUtil.SwitchToFirstValidWeapon`](#PopExtUtil.SwitchToFirstValidWeapon)
- [`PopExtUtil.HasEffect`](#PopExtUtil.HasEffect)
- [`PopExtUtil.SetEffect`](#PopExtUtil.SetEffect)
- [`PopExtUtil.PlayerRobotModel`](#PopExtUtil.PlayerRobotModel)
- [`PopExtUtil.HasItemInLoadout`](#PopExtUtil.HasItemInLoadout)
- [`PopExtUtil.StunPlayer`](#PopExtUtil.StunPlayer)
- [`PopExtUtil.Ignite`](#PopExtUtil.Ignite)
- [`PopExtUtil.ShowHudHint`](#PopExtUtil.ShowHudHint)
- [`PopExtUtil.SetEntityColor`](#PopExtUtil.SetEntityColor)
- [`PopExtUtil.GetEntityColor`](#PopExtUtil.GetEntityColor)
- [`PopExtUtil.AddAttributeToLoadout`](#PopExtUtil.AddAttributeToLoadout)
- [`PopExtUtil.ShowModelToPlayer`](#PopExtUtil.ShowModelToPlayer)
- [`PopExtUtil.LockInPlace`](#PopExtUtil.LockInPlace)
- [`PopExtUtil.GetItemIndex`](#PopExtUtil.GetItemIndex)
- [`PopExtUtil.SetItemIndex`](#PopExtUtil.SetItemIndex)
- [`PopExtUtil.SetTargetname`](#PopExtUtil.SetTargetname)
- [`PopExtUtil.GetPlayerSteamID`](#PopExtUtil.GetPlayerSteamID)
- [`PopExtUtil.GetHammerID`](#PopExtUtil.GetHammerID)
- [`PopExtUtil.GetSpawnFlags`](#PopExtUtil.GetSpawnFlags)
- [`PopExtUtil.GetPopfileName`](#PopExtUtil.GetPopfileName)
- [`PopExtUtil.PrecacheParticle`](#PopExtUtil.PrecacheParticle)
- [`PopExtUtil.SpawnEffect`](#PopExtUtil.SpawnEffect)
- [`PopExtUtil.RemoveOutputAll`](#PopExtUtil.RemoveOutputAll)
- [`PopExtUtil.RemovePlayerWearables`](#PopExtUtil.RemovePlayerWearables)
- [`PopExtUtil.GiveWeapon`](#PopExtUtil.GiveWeapon)
- [`PopExtUtil.IsEntityClassnameInList`](#PopExtUtil.IsEntityClassnameInList)
- [`PopExtUtil.SetPlayerClassRespawnAndTeleport`](#PopExtUtil.SetPlayerClassRespawnAndTeleport)
- [`PopExtUtil.PlaySoundOnClient`](#PopExtUtil.PlaySoundOnClient)
- [`PopExtUtil.PlaySoundOnAllClients`](#PopExtUtil.PlaySoundOnAllClients)
- [`PopExtUtil.StopAndPlayMVMSound`](#PopExtUtil.StopAndPlayMVMSound)
- [`PopExtUtil.EndWaveReverse`](#PopExtUtil.EndWaveReverse)
- [`PopExtUtil.AddThinkToEnt`](#PopExtUtil.AddThinkToEnt)
- [`PopExtUtil.SilentDisguise`](#PopExtUtil.SilentDisguise)
- [`PopExtUtil.GetPlayerReadyCount`](#PopExtUtil.GetPlayerReadyCount)
- [`PopExtUtil.GetWeaponMaxAmmo`](#PopExtUtil.GetWeaponMaxAmmo)
- [`PopExtUtil.TeleportNearVictim`](#PopExtUtil.TeleportNearVictim)
- [`PopExtUtil.IsSpaceToSpawnHere`](#PopExtUtil.IsSpaceToSpawnHere)
- [`PopExtUtil.ClearLastKnownArea`](#PopExtUtil.ClearLastKnownArea)
- [`PopExtUtil.KillPlayer`](#PopExtUtil.KillPlayer)
- [`PopExtUtil.KillAllBots`](#PopExtUtil.KillAllBots)
- [`PopExtUtil.SetDestroyCallback`](#PopExtUtil.SetDestroyCallback)
- [`PopExtUtil.OnWeaponFire`](#PopExtUtil.OnWeaponFire)

### Math methods

- [`PopExtUtil.Min`](#PopExtUtil.Min)
- [`PopExtUtil.Max`](#PopExtUtil.Max)
- [`PopExtUtil.Round`](#PopExtUtil.Round)
- [`PopExtUtil.Clamp`](#PopExtUtil.Clamp)
- [`PopExtUtil.RemapVal`](#PopExtUtil.RemapVal)
- [`PopExtUtil.RemapValClamped`](#PopExtUtil.RemapValClamped)
- [`PopExtUtil.IntersectionPointBox`](#PopExtUtil.IntersectionPointBox)
- [`PopExtUtil.NormalizeAngle`](#PopExtUtil.NormalizeAngle)
- [`PopExtUtil.ApproachAngle`](#PopExtUtil.ApproachAngle)
- [`PopExtUtil.VectorAngles`](#PopExtUtil.VectorAngles)
- [`PopExtUtil.AnglesToVector`](#PopExtUtil.AnglesToVector)
- [`PopExtUtil.QAngleDistance`](#PopExtUtil.QAngleDistance)
- [`PopExtUtil.CheckBitwise`](#PopExtUtil.CheckBitwise)
- [`PopExtUtil.StringReplace`](#PopExtUtil.StringReplace)
- [`PopExtUtil.capwords`](#PopExtUtil.capwords)

## Constants defined by PopExt

### [attribute_map](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/attribute_map.nut)

---

### [constants](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/constants.nut)

---

### [item_map](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/item_map.nut)

---

### [itemdef_constants](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/itemdef_constants.nut)

---

## [customattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut) references

<a name="PopExtAttributes.FiresMilkBolt"></a>

```js
// hud hint text on inspection
"Secondary attack: fires a bolt that applies milk for %.2f seconds. Regenerates every %.2f seconds."

// example popfile usage
`fires milk bolt`: { duration = 5, recharge = 24 } // defaults to duration = 10, recharge = 20
```

---

<a name="PopExtAttributes.ModTeleporterSpeedBoost"></a>

```js
// hud hint text on inspection
"Teleporters grant a speed boost for %.2f seconds"

// example popfile usage
`mod teleporter speed boost`: 5
```

---

<a name="PopExtAttributes.SetTurnToIce"></a>

```js
// hud hint text on inspection
"On Kill: Turn victim to ice."

// popfile usage
`set turn to ice`: 1
```

---

<a name="PopExtAttributes.MultTeleporterRechargeTime"></a>

```js
// hud hint text on inspection
"Teleporter recharge rate multiplied by %.2f"

// example popfile usage
`mult teleporter recharge time`: 0.25
```

> [!WARNING]
> This attribute doesn't seem to work currently

---

<a name="PopExtAttributes.MeleeCleaveAttack"></a>

```js
// hud hint text on inspection
"On Swing: Weapon hits multiple targets"

// popfile usage
`melee cleave attack`: 64
```

---

<a name="PopExtAttributes.LastShotCrits"></a>

```js
// hud hint text on inspection
"Crit boost on last shot. Crit boost will stay active for %.2f seconds upon holster"

// example popfile usage
`last shot crits`: 0.1
```

---

<a name="PopExtAttributes.WetImmunity"></a>

```js
// hud hint text on inspection
"Immune to jar effects"

// popfile usage
`wet immunity`: 1
```

---

<a name="PopExtAttributes.CanBreatheUnderWater"></a>

```js
// hud hint text on inspection
"Player can breathe underwater"

// popfile usage
`can breathe under water`: 1
```

---

<a name="PopExtAttributes.MultSwimSpeed"></a>

```js
// hud hint text on inspection
"Swimming speed multiplied by %.2f"

// example popfile usage
`mult swim speed`: 1.5
```

---

<a name="PopExtAttributes.TeleportInsteadOfDie"></a>

```js
// hud hint text on inspection
"%d⁒ chance of teleporting to spawn with 1 health instead of dying"

// example popfile usage
`teleport instead of die`: 0.5
```

---

<a name="PopExtAttributes.MultDmgVsSameClass"></a>

```js
// hud hint text on inspection
"Damage versus %s multiplied by %.2f" // %s is player class

// example popfile usage
`mult dmg vs same class`: 1.3
```

---

<a name="PopExtAttributes.UberOnDamageTaken"></a>

```js
// hud hint text on inspection
"On take damage: %d⁒ chance of gaining invicibility for 3 seconds"

// example popfile usage
`uber on damage taken`: 0.5
```

---

<a name="PopExtAttributes.BuildSmallSentries"></a>

```js
// hud hint text on inspection
"Sentries are 20⁒ smaller, have 33⁒ less health, take 25⁒ less metal to upgrade"

// popfile usage
`build small sentries`: 1
```

---

<a name="PopExtAttributes.CritWhenHealthBelow"></a>

```js
// hud hint text on inspection
"Player is crit boosted when below %d health"

// example popfile usage
`crit when health below`: 75
```

---

<a name="PopExtAttributes.MvmSentryAmmo"></a>

```js
// hud hint text on inspection
"Sentry ammo multiplied by %.2f"

// example popfile usage
`mvm sentry ammo`: 3
```

---

<a name="PopExtAttributes.RadiusSleeper"></a>

```js
// hud hint text on inspection
"On full charge headshot: create jarate explosion on victim"

// popfile usage
`radius sleeper`: 1
```

---

<a name="PopExtAttributes.ExplosiveBullets"></a>

```js
// hud hint text on inspection
"Fires explosive rounds that deal %d damage"

// example popfile usage
`explosive bullets`: 20
```

---

<a name="PopExtAttributes.OldSandmanStun"></a>

```js
// hud hint text on inspection
"Uses pre-JI stun mechanics"

// popfile usage
`old sandman stun`: 1
```

---

<a name="PopExtAttributes.StunOnHit"></a>

```js
// hud hint text on inspection
"Stuns victim for %.2f seconds on hit"

// example popfile usage
`stun on hit`: { duration = 3, type = 2, speedmult = 0.4, stungiants = true } // defaults to, from left to right: 5, 2, 0.2, true
```

---

<a name="PopExtAttributes.IsMiniboss"></a>

```js
// hud hint text on inspection
"When weapon is active: player becomes giant"

// popfile usage
`is miniboss`: 1
```

---

<a name="PopExtAttributes.ReplaceWeaponFireSound"></a>

```js
// hud hint text on inspection
"Weapon fire sound replaced with %s"

// example popfile usage
`replace weapon fire sound`: [null, `firesound.wav`] // this file is in a sound folder
```

> [!WARNING]
> This attribute doesn't seem to work currently

---

<a name="PopExtAttributes.IsInvisible"></a>

```js
// hud hint text on inspection
"Weapon is invisible"

// popfile usage
`is invisible`: 1
```

---

<a name="PopExtAttributes.CannotUpgrade"></a>

```js
// hud hint text on inspection
"Weapon cannot be upgraded"

// popfile usage
`cannot upgrade`: 1
```

---

<a name="PopExtAttributes.AlwaysCrit"></a>

```js
// hud hint text on inspection
"Weapon always crits"

// popfile usage
`always crit`: 1
```

---

<a name="PopExtAttributes.DontCountDamageTowardsCritRate"></a>

```js
// hud hint text on inspection
"Damage doesn't count towards crit rate"

// popfile usage
`dont count damage towards crit rate`: 1
```

---

<a name="PopExtAttributes.NoDamageFalloff"></a>

```js
// hud hint text on inspection
"Weapon has no damage fall-off or ramp-up"

// popfile usage
`no damage falloff`: 1
```

---

<a name="PopExtAttributes.CanHeadshot"></a>

```js
// hud hint text on inspection
"Crits on headshot"

// popfile usage
`can headshot`: 1
```

---

<a name="PopExtAttributes.CannotHeadshot"></a>

```js
// hud hint text on inspection
"weapon cannot headshot"

// popfile usage
`cannot headshot`: 1
```

---

<a name="PopExtAttributes.CannotBeHeadshot"></a>

```js
// hud hint text on inspection
"Immune to headshots"

// popfile usage
`cannot be headshot`: 1
```

---

<a name="PopExtAttributes.ProjectileLifetime"></a>

```js
// hud hint text on inspection
"projectile disappears after %.2f seconds"

// example popfile usage
`projectile lifetime`: 8
```

---

<a name="PopExtAttributes.MultDmgVsTanks"></a>

```js
// hud hint text on inspection
"Damage vs tanks multiplied by %.2f"

// example popfile usage
`mult dmg vs tanks`: 2
```

---

<a name="PopExtAttributes.MultDmgVsGiants"></a>

```js
// hud hint text on inspection
"Damage vs giants multiplied by %.2f"

// example popfile usage
`mult dmg vs giants`: 2
```

---

<a name="PopExtAttributes.MultDmgVsAirborne"></a>

```js
// hud hint text on inspection
"damage multiplied by %.2f against airborne targets"

// example popfile usage
`mult dmg vs airborne`: 2
```

---

<a name="PopExtAttributes.SetDamageType"></a>

```js
// hud hint text on inspection
"Damage type set to %d"

// example popfile usage
`set damage type`: DMG_CRITICAL // defined in constants.nut as part of popext, thanks!
```

---

<a name="PopExtAttributes.SetDamageTypeCustom"></a>

```js
// hud hint text on inspection
"Custom damage type set to %d"

// example popfile usage
`set damage type custom`: DMG_MELEE // defined in constants.nut as part of popext, thanks!
```

---

<a name="PopExtAttributes.ReloadsFullClipAtOnce"></a>

```js
// hud hint text on inspection
"This weapon reloads its entire clip at once."

// popfile usage
`reloads full clip at once`: 1
```

---

<a name="PopExtAttributes.FireFullClipAtOnce"></a>

```js
// hud hint text on inspection
"weapon fires full clip at once"

// popfile usage
`fire full clip at once`: 1
```

---

<a name="PopExtAttributes.PassiveReload"></a>

```js
// hud hint text on inspection
"weapon reloads when holstered"

// popfile usage
`passive reload`: 1
```

---

<a name="PopExtAttributes.MultProjectileScale"></a>

```js
// hud hint text on inspection
"projectile scale multiplied by %.2f"

// example popfile usage
`mult projectile scale`: 4
```

---

<a name="PopExtAttributes.MultBuildingScale"></a>

```js
// hud hint text on inspection
"building scale multiplied by %.2f"

// example popfile usage
`mult building scale`: 0.25
```

---

<a name="PopExtAttributes.MultCritDmg"></a>

```js
// hud hint text on inspection
"crit damage multiplied by %.2f"

// example popfile usage
`mult crit dmg`: 0.5
```

---

<a name="PopExtAttributes.ArrowIgnite"></a>

```js
// hud hint text on inspection
"arrows are always ignited"

// popfile usage
`arrow ignite`: 1
```

---

<a name="PopExtAttributes.AddCondOnHit"></a>

```js
// hud hint text on inspection
"applies cond %d to victim on hit"

// example popfile usage
`add cond on hit`: 27
`add cond on hit`: [27, 10] // this will apply cond 27 for 10 seconds on hit
```

---

<a name="PopExtAttributes.RemoveCondOnHit"></a>

```js
// hud hint text on inspection
"Remove cond %d on hit"

// example popfile usage
`remove cond on hit`: 27
```

---

<a name="PopExtAttributes.SelfAddCondOnHit"></a>

```js
// hud hint text on inspection
"applies cond %d to self on hit"

// example popfile usage
`self add cond on hit`: 27
`self add cond on hit`: [27, 10] // this will apply cond 27 to self for 10 seconds on hit
```

---

<a name="PopExtAttributes.SelfAddCondOnKill"></a>

```js
// hud hint text on inspection
"applies cond %d to self on kill"

// example popfile usage
`self add cond on kill`: 27
`self add cond on kill`: [27, 10] // this will apply cond 27 to self for 10 seconds on kill
```

---

<a name="PopExtAttributes.AddCondWhenActive"></a>

```js
// hud hint text on inspection
"when active: player receives cond %d"

// example popfile usage
`add cond when active`: 27
```

---

<a name="PopExtAttributes.FireInputOnHit"></a>

```js
// hud hint text on inspection
"fires custom entity input on hit: %s"

// example popfile usage
`fire input on hit`: `bignet^RunScriptCode^printl(\`Someone got hit 2 seconds ago!\`)^2`

// parameters default to:
// value = ""
// delay = -1 (no delay)
```

> [!NOTE]
> Arguments are separated by the circumflex symbol (^). Arguments in order are: `target`, `action`, `value`, `delay`.

---

<a name="PopExtAttributes.FireInputOnKill"></a>

```js
// hud hint text on inspection
"fires custom entity input on kill: %s"

// example popfile usage
`fire input on kill`: `bignet^RunScriptCode^printl(\`Someone got killed 2 seconds ago!\`)^2`

// parameters default to:
// value = ""
// delay = -1 (no delay)
```

> [!NOTE]
> Arguments are separated by the circumflex symbol (^). Arguments in order are: `target`, `action`, `value`, `delay`.

---

<a name="PopExtAttributes.RocketPenetration"></a>

```js
// hud hint text on inspection
"rocket penetrates up to %d enemy players"

// example popfile usage
`rocket penetration`: 2
```

---

<a name="PopExtAttributes.CollectCurrencyOnKill"></a>

```js
// hud hint text on inspection
"bots drop money when killed"

// popfile usage
`collect currency on kill`: 1
```

---

<a name="PopExtAttributes.NoclipProjectile"></a>

```js
// hud hint text on inspection
"projectiles go through walls and enemies harmlessly"

// popfile usage
`noclip projectile`: 1
```

---

<a name="PopExtAttributes.ProjectileGravity"></a>

```js
// hud hint text on inspection
"projectile gravity %d hu/s"

// example popfile usage
`projectile gravity`: 100
```

---

<a name="PopExtAttributes.ImmuneToCond"></a>

```js
// hud hint text on inspection
"wielder is immune to cond %d" // more numbers appear if you type in an array

// example popfile usage
`immune to cond`: 30
`immune to cond`: [30, 31, 32, 33, 34] // array length has no limit, hud hint displays accordingly
```

---

<a name="PopExtAttributes.MultMaxHealth"></a>

```js
// hud hint text on inspection
"Player max health is multiplied by %.2f"

// example popfile usage
`mult max health`: 2.5
```

---

<a name="PopExtAttributes.SpecialItemDescription"></a>

```js
// hud hint text on inspection
"(custom description)"

// example popfile usage
`special item description`: `This description is very cool`
```

---

<a name="PopExtAttributes.AltFireDisabled"></a>

```js
// hud hint text on inspection
"Secondary fire disabled"

// popfile usage
`alt-fire disabled`: 1
```

---

<a name="PopExtAttributes.CustomProjectileModel"></a>

```js
// hud hint text on inspection
"Fires custom projectile model: %s"

// very goofy example popfile usage, that is, if you have this directory.
`custom projectile model`: `models/props_mvm/robot_hologram_color.mdl`
```

---

<a name="PopExtAttributes.DmgBonusWhileHalfDead"></a>

```js
// hud hint text on inspection
"damage bonus while under 50% health"

// example popfile usage
`dmg bonus while half dead`: 3
```

---

<a name="PopExtAttributes.DmgPenaltyWhileHalfAlive"></a>

```js
// hud hint text on inspection
"damage penalty while above 50% health"

// example popfile usage
`damage penalty while half alive`: 0.66
```

---

## [missionattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/missionattributes.nut) references

<a name="MissionAttributes.ForceHoliday"></a>

```js
// example usage
ForceHoliday = 1
```

Replicates sigsegv-mvm: `ForceHoliday`. Forces a tf_holiday for the mission. Supported holidays are:

- 0 - None
- 1 - Birthday
- 2 - Halloween
- 3 - Christmas

---

<a name="MissionAttributes.YERDisguiseFix"></a>

```js
// usage
YERDisguiseFix = 1
```

Enable to make disguises via Your Eternal Reward backstabs not alert any bots

---

<a name="MissionAttributes.LooseCannonFix"></a>

```js
// usage
LooseCannonFix = 1
```

Fixes incorrect damage scaling on Loose Cannon double donks

---

<a name="MissionAttributes.BotGibFix"></a>

```js
// usage
BotGibFix = 1
```

Enable to make bots properly gib on death

---

<a name="MissionAttributes.HolidayPunchFix"></a>

```js
// usage
HolidayPunchFix = 1
```

Make robots laugh with correct animations when hit with a crit Holiday Punch

---

<a name="MissionAttributes.EnableGlobalFixes"></a>

```js
// usage
EnableGlobalFixes = 1
```

Enables the following mission attributes:
- [`DragonsFuryFix`](#MissionAttributes.DragonsFuryFix)
- [`FastNPCUpdate`](#MissionAttributes.FastNPCUpdate)
- [`NoCreditVelocity`](#MissionAttributes.NoCreditVelocity)
- [`ScoutBetterMoneyCollection`](#MissionAttributes.ScoutBetterMoneyCollection)
- [`HoldFireUntilFullReloadFix`](#MissionAttributes.HoldFireUntilFullReloadFix)
- [`EngineerBuildingPushbackFix`](#MissionAttributes.EngineerBuildingPushbackFix)

---

<a name="MissionAttributes.DragonsFuryFix"></a>

```js
// usage
DragonsFuryFix = 1
```

Makes Dragon's Fury projectile unreflectable

---

<a name="MissionAttributes.FastNPCUpdate"></a>

```js
// usage
FastNPCUpdate = 1
```

Fixes clunky animation fps on the HHH, Monoculus, Merasmus and skeletons

---

<a name="MissionAttributes.NoCreditVelocity"></a>

```js
// usage
NoCreditVelocity = 1
```

Money piles will spawn without spewing around

---

<a name="MissionAttributes.ScoutBetterMoneyCollection"></a>

```js
// usage
ScoutBetterMoneyCollection = 1
```

Scouts will no longer collect money like a magnet, but collect instantly upon entering collection radius (no more money tornado and it getting stuck)

---

<a name="MissionAttributes.HoldFireUntilFullReloadFix"></a>

```js
// usage
HoldFireUntilFullReloadFix = 1
```

Fixes HoldFireUntilFullReload not working on certain weapons (mangler, shotguns, etc)

---

<a name="MissionAttributes.EngineerBuildingPushbackFix"></a>

```js
// usage
EngineerBuildingPushbackFix = 1
```

Removes engineer building pushback

> [!WARNING]
> Does not currently work. Needs further investigation

---

<a name="MissionAttributes.RedBotsNoRandomCrit"></a>

```js
// usage
RedBotsNoRandomCrit = 1
```

Disables random crits for red bots

---

<a name="MissionAttributes.NoCrumpkins"></a>

```js
// usage
NoCrumpkins = 1
```

Disables crit pumpkins

---

<a name="MissionAttributes.NoReanimators"></a>

```js
// usage
NoReanimators = 1
```

Disables reanimators

---

<a name="MissionAttributes.AllMobber"></a>

```js
// usage
AllMobber = 1
```

Sets the following cvars:

- `tf_bot_escort_range` to `INT_MAX`, a really big number
- `tf_bot_flag_escort_range` to `INT_MAX`
- `tf_bot_flag_escort_max_count` to 0

---

<a name="MissionAttributes.StandableHeads"></a>

```js
// usage
StandableHeads = 1
```

Allows standing on bot heads

---

<a name="MissionAttributes.666Wavebar"></a>

```js
// example usage
`666Wavebar`: 69
```

> [!WARNING]
> Bug: seems to do the same thing as the `WaveNum` attribute

---

<a name="MissionAttributes.WaveNum"></a>

```js
// example usage
WaveNum = 69
```

Sets the wave number (number before the slash) on the wavebar

---

<a name="MissionAttributes.MaxWaveNum"></a>

```js
// example usage
MaxWaveNum = 420
```

Sets the max wave number (number after the slash on the wavebar)

---

<a name="MissionAttributes.HuntsmanDamageFix"></a>

```js
// usage
HuntsmanDamageFix = 1
```

Enable this to fix huntsman damage bonus not scaling correctly.

> [!WARNING]
> Rafmod already does this, enabling this on potato servers will stack. A workaround is to disable the rafmod fix and enable the popext fix, though they are equivalent and should only affect local testing experience.

---

<a name="MissionAttributes.NegativeDmgHeals"></a>

```js
// usage
NegativeDmgHeals = 1
```

> [!CAUTION]
> This attribute is unfinished

---

<a name="MissionAttributes.MultiSapper"></a>

```js
// usage
MultiSapper = 1
```

Allows spies to place multiple sappers when item meter is full

---

<a name="MissionAttributes.SetDamageTypeIgniteFix"></a>

```js
// usage
SetDamageTypeIgniteFix = 1
```

Fix "Set DamageType Ignite" not actually making most weapons ignite on hit

> [!WARNING]
> Rafmod already does this, enabling this on potato servers will ALWAYS stack, since there does not seem to be a way to turn off the rafmod fix. Use this with `[$WIN32]` tag for local testing.

---

<a name="MissionAttributes.NoRefunds"></a>

```js
// usage
NoRefunds = 1
```

Disallows refunds

---

<a name="MissionAttributes.RefundLimit"></a>

```js
// example usage
RefundLimit = 5
```

Sets a limit on how many times one can refund

---

<a name="MissionAttributes.RefundGoal"></a>

```js
// example usage
RefundGoal = 1500
```

Sets a credit collected goal on when one can refund

---

<a name="MissionAttributes.FixedBuybacks"></a>

```js
// usage
FixedBuybacks = 1
```

Changes the buyback system so that buybacks are charge-based and finite, as opposed to the regular currency-based system

---

<a name="MissionAttributes.BuybacksPerWave"></a>

```js
// example usage
BuybacksPerWave = 3
```

Sets the number of buybacks allowed in a wave

---

<a name="MissionAttributes.NoBuybacks"></a>

```js
// usage
NoBuybacks = 1
```

Disallows buybacks

---

<a name="MissionAttributes.DeathPenalty"></a>

```js
// example usage
DeathPenalty = 100
```

If set, player will lose this many credits on death

---

<a name="MissionAttributes.BonusRatioHalf"></a>

```js
// example usage
BonusRatioHalf = 0.85
```

Sets the minimum percentage of wave money players must collect in order to qualify for min bonus. Upon reaching this percentage, $50 will be paid out. In this example, upon reaching 85% money collected, all players receive $50. Default is 0.95

> [!NOTE]
> This bonus is independent from the max bonus, i.e. when players see an A+ wave with $100 bonus, both the min and max bonuses have been paid out instead of one $100 lump sum.

---

<a name="MissionAttributes.BonusRatioFull"></a>

```js
// example usage
BonusRatioFull = 0.98
```

Sets the highest percentage of wave money players must collect in order to qualify for max bonus. Upon reaching this percentage, $50 will be paid out. In this example, upon reaching 98% money collected, all players receive $50. Default is 1.00

> [!NOTE]
> This bonus is independent from the min bonus, i.e. when players see an A+ wave with $100 bonus, both the min and max bonuses have been paid out instead of one $100 lump sum.

---

<a name="MissionAttributes.UpgradeFile"></a>

```js
// usage
UpgradeFile = `filepath`
```

Sets a custom upgrades file

---

<a name="MissionAttributes.FlagEscortCount"></a>

```js
// example usage
FlagEscortCount = 10
```

Sets how many bots should escort a bomb-carrying (or in general, a flag-carrying) bot, default is 4

---

<a name="MissionAttributes.BombMovementPenalty"></a>

```js
// example usage
BombMovementPenalty = 0.3
```

Sets the movement multiplier on a bot who is carrying the bomb, default is 0.5

---

<a name="MissionAttributes.MaxSkeletons"></a>

```js
// example usage
MaxSkeletons = 8
```

Sets the maximum number of active skeletons on the map, default is 30

---

<a name="MissionAttributes.TurboPhysics"></a>

```js
// usage
TurboPhysics = 1
```

Turns on turbo physics

---

<a name="MissionAttributes.Accelerate"></a>

```js
// example usage
Accelerate = 20
```

Sets the `sv_accelerate` cvar, default is 10

---

<a name="MissionAttributes.AirAccelerate"></a>

```js
// example usage
AirAccelerate = 20
```

Sets the `sv_airaccelerate` cvar, default is 10

---

<a name="MissionAttributes.BotPushaway"></a>

```js
// usage
BotPushaway = 0
```

Sets whether teammates can push each other: default is 1, to disable set to 0

---

<a name="MissionAttributes.TeleUberDuration"></a>

```js
// example usage
TeleUberDuration = 3
```

Sets how long, in seconds, that bots should be ubered after teleporting to the field via an engineer bot teleporter, default is 5

---

<a name="MissionAttributes.RedMaxPlayers"></a>

```js
// example usage
RedMaxPlayers = 10
```

Sets the max players allowed on RED team

---

<a name="MissionAttributes.MaxVelocity"></a>

```js
// example usage
MaxVelocity = 6900
```

Sets the `sv_maxvelocity` cvar, default is 3500

---

<a name="MissionAttributes.ConchHealthOnHitRegen"></a>

```js
// example usage
ConchHealthOnHitRegen = 0.5
```

Sets the percentage health regained via the Concheror banner effect, default is 0.35 (35%)

---

<a name="MissionAttributes.MarkForDeathLifetime"></a>

```js
// example usage
MarkForDeathLifetime = 8
```

Sets how long, in seconds, that a marked-for-death effect should last, default is 15

---

<a name="MissionAttributes.GrapplingHookEnable"></a>

```js
// usage
GrapplingHookEnable = 1
```

Enables Grappling Hook

---

<a name="MissionAttributes.GiantScale"></a>

```js
// example usage
GiantScale = 1.9
```

Sets how large of a scale giants should be by default, default is 1.75

---

<a name="MissionAttributes.VacNumCharges"></a>

```js
// example usage
VacNumCharges = 5
```

Sets how many Vaccinator charges should be available

---

<a name="MissionAttributes.DoubleDonkWindow"></a>

```js
// example usage
DoubleDonkWindow = 0.8
```

Sets how long, in seconds, that after an impact from a Loose Cannon projectile that an explosion will count as a double donk, default is 0.5

---

<a name="MissionAttributes.ConchSpeedBoost"></a>

```js
// example usage
ConchSpeedBoost = 150
```

Sets the increase amount, in hu/s, from speed bonus effects. This includes, but not limited to: Concheror banner effect, Disciplinary Action whip effect. Default is 105

---

<a name="MissionAttributes.StealthDmgReduction"></a>

```js
// example usage
StealthDmgReduction = 0.6
```

Set the `tf_stealth_damage_reduction` cvar, default is 0.8

---

<a name="MissionAttributes.FlagCarrierCanFight"></a>

```js
// usage
FlagCarrierCanFight = 0
```

If set to 0, disallows bomb (in general, flag) carrier to attack

---

<a name="MissionAttributes.HHHChaseRange"></a>

```js
// example usage
HHHChaseRange = 2500
```

Sets how far the HHH should chase players in units of hu, default is 1500

---

<a name="MissionAttributes.HHHAttackRange"></a>

```js
// example usage
HHHAttackRange = 150
```

Sets the attack range of the HHH in units of hu, default is 200

---

<a name="MissionAttributes.HHHQuitRange"></a>

```js
// example usage
HHHQuitRange = 3000
```

Sets the minimum distance, in hu, that a player should stay away from the HHH for him to give up chasing and attacking the player, default is 2000

---

<a name="MissionAttributes.HHHTerrifyRange"></a>

```js
// example usage
HHHTerrifyRange = 300
```

Sets the HHH terrify effect radius in hu, default is 500

---

<a name="MissionAttributes.HHHHealthBase"></a>

```js
// example usage
HHHHealthBase = 5000
```

Sets the base health of the HHH, default is 3000

---

<a name="MissionAttributes.HHHHealthPerPlayer"></a>

```js
// example usage
HHHHealthPerPlayer = 500
```

Sets the health increment of the HHH per player active in the server, default is 200

---

<a name="MissionAttributes.HalloweenBossNotSolidToPlayers"></a>

```js
// usage
HalloweenBossNotSolidToPlayers = 1
```

Sets Halloween bosses to not be solid to players

---

<a name="MissionAttributes.SentryHintBombForwardRange"></a>

```js
// example usage
SentryHintBombForwardRange = 100
```

Sets the `tf_bot_engineer_mvm_sentry_hint_bomb_forward_range` cvar, default is 0

---

<a name="MissionAttributes.SentryHintBombBackwardRange"></a>

```js
// example usage
SentryHintBombBackwardRange = 2000
```

Sets the `tf_bot_engineer_mvm_sentry_hint_bomb_backward_range` cvar, default is 3000

---

<a name="MissionAttributes.SentryHintMinDistanceFromBomb"></a>

```js
// example usage
SentryHintMinDistanceFromBomb = 1000
```

Sets the `tf_bot_engineer_mvm_hint_min_distance_from_bomb` cvar, default is 1300

---

<a name="MissionAttributes.NoBusterFF"></a>

```js
// usage
NoBusterFF = 1
```

Disables sentry buster friendly fire (it won't blow up friendly bots anymore)

---

<a name="MissionAttributes.SniperHideLasers"></a>

```js
// usage
SniperHideLasers = 1
```

Disables sniper lasers

---

<a name="MissionAttributes.TeamWipeWaveLoss"></a>

```js
// usage
TeamWipeWaveLoss = 1
```

If set, wave will be lost if team is wiped

---

<a name="MissionAttributes.GiantSentryKillCountOffset"></a>

```js
// example usage
GiantSentryKillCountOffset = -4
```

Changes sentry kill count per miniboss (giant) kill. Setting to -4 will make giants count as 1 kill only.

---

<a name="MissionAttributes.FlagResetTime"></a>

```js
// example usage 1
FlagResetTime = { `flagName` : 60 }
// example usage 2
FlagResetTime = 60
```

Sets reset time for flags (bombs). Accepts a keyvalue table of flag targetnames and their new return times like in example 1. Can also just accept a float value to apply to all flags

---

<a name="MissionAttributes.BotHeadshots"></a>

```js
// usage
BotHeadshots = 1
```

Enables headshotting by bots

---

<a name="MissionAttributes.PlayersAreRobots"></a>

```js
// example usage
PlayersAreRobots = 1

```

Uses bitflags to enable certain behaviour.

- 1 - Robot animations (excluding sticky demo and jetpack pyro)
- 2 - Human animations
- 4 - Enable footstep sfx
- 8 - Enable voicelines (WIP)
- 16 - Enable viewmodels (WIP)

---

<a name="MissionAttributes.BotsAreHumans"></a>

```js
// example usage
BotsAreHumans = 2
```

Uses bitflags to change behaviour.

- 1 = Blu bots use human models.
- 2 = Blu bots use zombie models. Overrides human models.
- 4 = Red bots use human models.
- 4 = Red bots use zombie models. Overrides human models.
- 128 = Include buster

---

<a name="MissionAttributes.NoRome"></a>

```js
// example usage
NoRome = 1
```

If set to 1, disables romevision on bots. If set to 2, disables rome carrier tank

---

<a name="MissionAttributes.SpellRateCommon"></a>

```js
// example usage
SpellRateCommon = 0.15
```

Sets the common spellbook drop chances of small bots on death

---

<a name="MissionAttributes.SpellRateGiant"></a>

```js
// example usage
SpellRateGiant = 0.5
```

Sets the common spellbook drop chances of giant bots on death

---

<a name="MissionAttributes.RareSpellRateCommon"></a>

```js
// example usage
RareSpellRateCommon = 0.05
```

Sets the rare spellbook drop chances of small bots on death

---

<a name="MissionAttributes.RareSpellRateGiant"></a>

```js
// example usage
RareSpellRateGiant = 0.3
```

Sets the rare spellbook drop chances of giant bots on death

---

<a name="MissionAttributes.NoSkeleSplit"></a>

```js
// usage
NoSkeleSplit = 1
```

Skeletons spawned by bots or tf_zombie entities will no longer split into smaller skeletons

---

<a name="MissionAttributes.WaveStartCountdown"></a>

```js
// example usage
WaveStartCountdown = 5
```

Sets countdown time when everyone has F4'd. Values below 9 will disable starting music

---

<a name="MissionAttributes.OptimizePathTracks"></a>

```js
// example usage
OptimizePathTracks = 1
```

Incrementally spawn and delete path_tracks to save edicts.

>[!CAUTION]
> Not yet implemented.

---

<a name="MissionAttributes.ExtraTankPath"></a>

```js
// example usage
ExtraTankPath = [
	[`686 4000 392`, `667 4358 390`, `378 4515 366`, `-193 4250 289`], // starting node: extratankpath1_1
	[`640 5404 350`, `640 4810 350`, `640 4400 550`, `1100 4100 650`, `1636 3900 770`] //starting node: extratankpath2_1
	// the last track in the list will have _lastnode appended to the targetname
]
```

Array of arrays with xyz values to spawn path_tracks at. path_track names are ordered based on where they are listed in the array

---

<a name="MissionAttributes.HandModelOverride"></a>

```js
// example usage
HandModelOverride = `modelname.mdl`
```

Replace viewmodel arms with custom ones

---

<a name="MissionAttributes.AddCond"></a>

```js
// example usage 1
AddCond = 27
// example usage 2
AddCond = [27, 10]
```

Add cond to every player on spawn with an optional duration. Second value in array is the duration argument

---

<a name="MissionAttributes.PlayerAttributes"></a>

```js
// example usage, taken from example pop
PlayerAttributes = {
	`damage bonus`: 10,
	`can breathe under water`: 1,
	`mult swim speed`: 3,
	`teleport instead of die`: 1,
	`crit when health below`: 75,
	`is miniboss`: 1,

	[TF_CLASS_SCOUT] = {
		`damage bonus` : 5,
		`fire rate penalty` : 2,
		`max health additive bonus` : 100,
	},

	[TF_CLASS_SOLDIER] = {
		`damage penalty` : 0.5,
		`fire rate bonus` : 0.5,
		`mult dmg vs same class`: 10
	},

	[TF_CLASS_DEMOMAN] = {
		`fire rate bonus` : 0.5,
	}
}
```

Add/modify player attributes, can be filtered by class

---

<a name="MissionAttributes.ItemAttributes"></a>

```js
// example usage, taken from example pop
ItemAttributes = {
	tf_weapon_scattergun = {
		`max health additive bonus` : 100
		`fire rate bonus` : 0.5
		`Reload time decreased` : 0.5
		`clip size bonus` : 2
		`reloads full clip at once`: 1
		`passive reload`: 1
		`collect currency on kill`: 1
	},
	tf_weapon_rocketlauncher = { //string with no spaces (like item classnames) can use this syntax
		`projectile gravity`: 10
		`fire rate penalty` : 3
		`damage bonus` : 10
		`custom projectile model`: `models/player/heavy.mdl`
		`add cond when active`: 91
	},
	tf_weapon_pistol = {
		`passive reload`: 1
	},
	tf_weapon_shotgun = {
		`reloads full clip at once`: 1
	}
	tf_weapon_crossbow = {
		`fires milk bolt`: 1
		`set turn to ice`: 1
		`radius sleeper`: 1
	},
	[132] = { //item id, eyelander
		`melee cleave attack`: 32
		`stun on hit`: { duration = 4 type = 2 speedmult = 0.2 stungiants = true }
	},
	tf_weapon_wrench = {
		`build small sentries`: 1
	},
	`The Sydney Sleeper`: { // localized name in items_game.txt/item_map.nut
		`radius sleeper`: 1
		`explosive bullets`: 30
	}
	`The Sandman` : { // strings with spaces require this syntax.
		`old sandman stun`: 1
	}
	`Iron Curtain` : {
		`alt-fire disabled`: 1
	}
}
```

Replace or blacklist weapons when the player spawns.  Accepts custom weapons.

> [!NOTE]
> Wearable replacements are handled differently and will ONLY accept the string name for the item, not an item index.

---

<a name="MissionAttributes.LoadoutControl"></a>

```js
LoadoutControl = {

	`Mad Milk`: `Pretty Boy's Pocket Pistol`, // accepts string name
	[812] = {`tf_weapon_pistol`: 23}, // accepts item ids
	tf_weapon_sniperrifle = null, // accepts classname, null to blacklist
	[10442] = {`tf_wearable` : `Memes vs Machines Player 2019`}, // for wearable replacements
	`18, 102, 205, 658, 15006, 15014, 15129, 15130, 15150`: {`tf_weapon_minigun`: 23} // comma-separated string of item ids
	`tf_weapon_rocketlauncher_directhit`: `Wasp Launcher`, // accepts custom weapons as well
},
```
---

<a name="MissionAttributes.SoundOverrides"></a>

```js
// example usage, taken from example pop
SoundOverrides = { //overrides teamplay_broadcast_audio sounds
	`Announcer.MVM_Get_To_Upgrade`: null
	`music.mvm_end_last_wave`: null
	`Game.YourTeamWon`: null
	`MVM.PlayerDied`: null
}
```

Hardcoded to only be able to replace specific sounds, because spamming stopsound in a think function is very laggy. See [replace weapon fire sound](#PopExtAttributes.ReplaceWeaponFireSound) and more in `customattributes.nut` for weapon sounds. See the tank sound overrides in `hooks.nut` for disabling tank explosions.

---

<a name="MissionAttributes.NoThrillerTaunt"></a>

```js
// usage
NoThrillerTaunt = 1
```

Stops the Halloween thriller taunt from being played when taunting

---

<a name="MissionAttributes.EnableRandomCrits"></a>

```js
// example usage
EnableRandomCrits = 2
```

Uses bitflags to enable random crits:

- 1 - BLU humans
- 2 - BLU robots
- 4 - RED robots

---

<a name="MissionAttributes.ForceRedMoney"></a>

```js
// usage
ForceRedMoney = 1
```

Forces red money (like those dropped from sniper kills) to drop always

---

<a name="MissionAttributes.ReverseMVM"></a>

```js
// example usage
ReverseMVM = 1|4|8|16|32
```

Accepts bitflags to modify behaviour.

- 1 - enables basic Reverse MvM behavior
- 2 - blu players cannot pick up bombs
- 4 - blu players have infinite ammo
- 8 - blu spies have infinite cloak
- 16 - blu players have spawn protection
- 32 - blu players cannot attack in spawn
- 64 - remove blu footsteps

> [!CAUTION]
> the `remove blu footsteps` bitflag may not work correctly.

---

<a name="MissionAttributes.ClassLimits"></a>

```js
// example usage
ClassLimits = {
	`scout`: 1 // limits to 1 scout max
	`heavy`: 0 // disallows playing as heavy
}

```

Sets a class limit in the mission

---

<a name="MissionAttributes.ShowHiddenAttributes"></a>

```js
// example usage
ShowHiddenAttributes = 1
```

Shows hidden attributes

---

<a name="MissionAttributes.HideRespawnText"></a>

```js
// example usage
HideRespawnText = 0
```

Hides the "Respawn in: # seconds" text. Accepts these inputs:

- 0 - default behaviour (countdown)
- 1 - hide completely
- 2 - show only "Prepare to Respawn"

---

<a name="MissionAttributes.IconOverride"></a>

```js
// example usage
IconOverride = {

	scout = {
		count = 0 //remove from current wave
		flags = MVM_CLASS_FLAG_NORMAL // see constants.nut for flags
	}

	pyro = { //replace with a new icon
		replace = `scout_bat`
		count = 20 //set count to 20 for current wave
		flags = MVM_CLASS_FLAG_NORMAL // see constants.nut for flags
		newflags = MVM_CLASS_FLAG_ALWAYSCRIT|MVM_CLASS_FLAG_MINIBOSS // see constants.nut for flags
		// index is required if you want to preserve the icon order on the wavebar
		// the bigrock pop pyro icon index is normally 0, but gets changed to 4 by IconOverride
		// this will change if you update your wave with more bots
		// use PopExt.GetWaveIconSlot( "pyro", <flags or MVM_CLASS_FLAG_NONE> ) to find the index

		index = 4
	}
}
```

Override or remove icons from the specified wave.
if no wave specified it will override the current wave.

> [!WARNING]
> Bots must have an associated popext_iconoverride tag for decrementing/incrementing on death.

---

<a name="MissionAttributes.NoUpgrades"></a>

```js
// example usage
NoUpgrades = 1
```

Disables the upgrade station and prints a message to the screen.

- 1 - print a message to the screen
- 2 - silently disable the upgrade station

---

<a name="MissionAttributes.BotSpectateTime"></a>

```js
// example usage
BotSpectateTime = 1.0
```

Moves bots to spectator after a specified time.

>[!WARNING]
> Durations greater than 5s will likely cause problems.  This is exclusively meant to *shorten* the spectate timer.

---

<a name="MissionAttributes.FastEntityNameLookup"></a>

```js
// example usage
FastEntityNameLookup = 1
```

Lower-cases all entity targetnames for slightly faster entity I/O calls.

---

<a name="MissionAttributes.RemoveBotViewmodels"></a>

```js
// example usage
RemoveBotViewmodels = 1
```

Removes all viewmodels from bots to save edicts.

---

<a name="MissionAttributes.UnusedGiantFootsteps"></a>

```js
// example usage
UnusedGiantFootsteps = 1
```

- 1 - Enable unused giant footstep sfx
- 2 - Enable for giant players too
- 4 - Use default footstep sound timing (faster, more spammy)

Enables unused class-specific giant footstep sounds.

---

<a name="MissionAttributes.MissionUnloadOutput"></a>

```js
// example usage
MissionUnloadOutput = {
	target = "bignet"
	action = "runscriptcode"
	param = "ClientPrint(null, HUD_PRINTTALK, \"Mission complete!\")"
	delay = 1.0
	activator = null
	caller = null
}
```

Fire an Entity output on mission complete.

## [util](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/util.nut) references

<a name="PopExtUtil.HumanTable"></a>
<a name="PopExtUtil.BotTable"></a>
<a name="PopExtUtil.PlayerTable"></a>

```cpp
table PopExtUtil::HumanTable
table PopExtUtil::BotTable
table PopExtUtil::PlayerTable
```
Pre-collected/managed tables of player handles and their userid's. Automatically updated.

> [!NOTE]
> Array forms also exist as `PopExtUtil.HumanArray`, `PopExtUtil.BotArray`, and `PopExtUtil.PlayerArray`.

---

<a name="PopExtUtil.Classes"></a>
<a name="PopExtUtil.ClassesCaps"></a>

```cpp
array PopExtUtil::Classes // ["", "scout", "sniper", "soldier", "demo", "medic", "heavy", "pyro", "spy", "engineer", "civilian"]
array PopExtUtil::ClassesCaps // ["", "Scout", "Sniper", "Soldier", "Demoman", "Medic", "Heavy", "Pyro", "Spy", "Engineer", "Civilian"]
```

Arrays of player class names for `GetPlayerClass()` lookups.

---

<a name="PopExtUtil.IsWaveStarted"></a>

```cpp
bool PopExtUtil::IsWaveStarted
```

Global variable to check if the current wave has started.

---

<a name="PopExtUtil.IsWaveFinished"></a>

```cpp
table PopExtUtil::MaxAmmoTable
```

Table of default max ammo values for every weapon.  `PopExtUtil.MaxAmmoTable[ player.GetPlayerClass() ][ player.GetActiveWeapon().GetClassname() ]` will return the max ammo for the player's active weapon.

---

<a name="PopExtUtil.IsLinuxServer"></a>

```cpp
bool PopExtUtil::IsLinuxServer()
```

Returns true if the current server is running on Linux.

---

<a name="PopExtUtil.ShowMessage"></a>

```cpp
void PopExtUtil::ShowMessage(string message)
```

Prints a message to everyone in the centre of the screen.

---

<a name="PopExtUtil.ForceChangeClass"></a>

```cpp
void PopExtUtil::ForceChangeClass(handle player, int classindex = 1)
```

Force changes a player's class and respawns them

---

<a name="PopExtUtil.PlayerClassCount"></a>

```cpp
int[11] PopExtUtil::PlayerClassCount()
```

Returns the player count of all the classes in an array. 11 is the constant TF_CLASS_COUNT_ALL

---

<a name="PopExtUtil.ChangePlayerTeamMvM"></a>

```cpp
void PopExtUtil::ChangePlayerTeamMvM(handle player, int teamnum = TF_TEAM_PVE_INVADERS)
```

Changes player team to blu bots. Can accept other `teamnum` arguments to change to different team

---

<a name="PopExtUtil.ShowChatMessage"></a>

```cpp
void PopExtUtil::ShowChatMessage(handle target, string fmt, ...)
```

Prints a chat message to `target`. Pass `null` to print to everyone. For usage of `fmt`, see the below example

```js
PopExtUtil.ShowChatMessage(null, "{player} {color}guessed the answer first!", player, TF_COLOR_DEFAULT)
```

Notice the last two arguments refer back to the placeholders in the `fmt` string

---

<a name="PopExtUtil.CopyTable"></a>

```cpp
table PopExtUtil::CopyTable(table)
```

Copies a table and returns that copy

---

<a name="PopExtUtil.HexToRgb"></a>

```cpp
int[3] PopExtUtil::HexToRgb(string hex)
```

Converts a hex colour string into an array of rgb values [r, g, b]

---

<a name="PopExtUtil.CountAlivePlayers"></a>

```cpp
int PopExtUtil::CountAlivePlayers(bool printout = false)
```

Returns the number of currently alive players. Pass `true` to print to console too

---

<a name="PopExtUtil.CountAliveBots"></a>

```cpp
int PopExtUtil::CountAliveBots(bool printout = false)
```

Returns the number of currently alive bots. Pass `true` to print to console too

---

<a name="PopExtUtil.SetParentLocalOriginDo"></a>

```cpp
void PopExtUtil::SetParentLocalOriginDo(handle child, handle parent, string attachment = null)
```

Sets parent immediately in a dirty way. Does not retain absolute origin, retains local origin instead.

---

<a name="PopExtUtil.SetParentLocalOrigin"></a>

```cpp
void PopExtUtil::SetParentLocalOrigin(handle/[] child, handle parent, string attachment = null)
```

Wrapper for `SetParentLocalOriginDo()` which also accepts an array of `child` ents

---

<a name="PopExtUtil.SetupTriggerBounds"></a>

```cpp
void PopExtUtil::SetupTriggerBounds(handle trigger, Vector mins = null, Vector maxs = null)
```

Setup collision bounds of a trigger entity

---

<a name="PopExtUtil.PrintTable"></a>

```cpp
void PopExtUtil::PrintTable(table)
```

Wrapper for `DoPrintTable()` but with `indent` set to 0

---

<a name="PopExtUtil.DoPrintTable"></a>

```cpp
void PopExtUtil::DoPrintTable(table, int indent)
```

Prints a table to console

---

<a name="PopExtUtil.CreatePlayerWearable"></a>

```cpp
handle PopExtUtil::CreatePlayerWearable(handle player, string model, bool bonemerge = true, string attachment = null, bool autoDestroy = true)
```

Make a wearable that is attached to the player. The wearable is automatically removed when the owner is killed or respawned

---

<a name="PopExtUtil.StripWeapon"></a>

```cpp
void PopExtUtil::StripWeapon(handle player, int slot = -1)
```

---

<a name="PopExtUtil.SetPlayerAttributes"></a>

```cpp
void PopExtUtil::SetPlayerAttributes(handle player, string attrib, int/float/bool/string value, handle item = null)
```

Sets an attribute onto an item of a player ent

---

<a name="PopExtUtil.WeaponSwitchSlot"></a>

```cpp
void PopExtUtil::WeaponSwitchSlot(handle player, int slot)
```

Force changes a player's active weapon to `slot`. This assumes that user is using the SLOT_ constants as defined in [`constants.nut`](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/constants.nut).

---

<a name="PopExtUtil.Explanation"></a>

```cpp
void PopExtUtil::Explanation(string message, string printColor = COLOR_YELLOW, string messagePrefix = "Explanation: ", bool syncChatWithGameText = false, float textPrintTime = -1, float textScanTime = 0.02)
```

Prints a scrolling message to the centre of everyone's screens, while also printing that message in the chat.

---

<a name="PopExtUtil.Info"></a>

```cpp
void PopExtUtil::Info(string message, string printColor = COLOR_YELLOW, string messagePrefix = "Explanation: ", bool syncChatWithGameText = false, float textPrintTime = -1, float textScanTime = 0.02)
```

Does the same thing as [`Explanation`](#PopExtUtil.Explanation)

---

<a name="PopExtUtil.IsAlive"></a>

```cpp
bool PopExtUtil::IsAlive(handle player)
```

Is this player currently alive?

---

<a name="PopExtUtil.IsDucking"></a>

```cpp
bool PopExtUtil::IsDucking(handle player)
```

Is this player currently ducking?

---

<a name="PopExtUtil.IsOnGround"></a>

```cpp
bool PopExtUtil::IsOnGround(handle player)
```

Is this player currently on the ground?

---

<a name="PopExtUtil.RemoveAmmo"></a>

```cpp
void PopExtUtil::RemoveAmmo(handle player)
```

Removes all ammo of all weapons of the player

---

<a name="PopExtUtil.GetAllEnts"></a>

```cpp
table PopExtUtil::GetAllEnts(bool count_players = false, function callback = null)
```

Returns a table of two kv pairs: An array of entity handles (`entlist`), and the number of entities (`numents`).  Use `count_players` to ignore/include players (default is false).

Accepts an optional callback function to be called for each entity.  See `FastEntityNameLookup` in [`missionattributes.nut`](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/missionattributes.nut) for an example.

---

<a name="PopExtUtil._SetOwner"></a>

```cpp
void PopExtUtil::_SetOwner(handle ent, handle owner)
```

Sets netprops m_hOwnerEntity and m_hOwner to the same value

---

<a name="PopExtUtil.ShowAnnotation"></a>

```cpp
void PopExtUtil::ShowAnnotation(table args = {
	string text = "This is an annotation",
	float lifetime = 10,
	Vector pos = Vector(),
	int id = 0,
	bool distance = true,
	string sound = "misc/null.wav",
	int entindex = 0,
	int visbit = 0,
	bool effect = true})
```

`show_annotation` game event wrapper.  Accepts vector arguments for origin, an array of player handles for per-player visibility, and more.  Check the [source](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/shared/util.nut#L947) for more details.

---

<a name="PopExtUtil.HideAnnotation"></a>

```cpp
void PopExtUtil::HideAnnotation(int id)
```

Hides the annotation with a given id

>[!NOTE]
> This is just a wrapper for the `hide_annotation` game event.  No functional difference.

---
<a name="PopExtUtil.TrainingHUD"></a>

```cpp
void PopExtUtil::TrainingHUD(string title, string text, float duration = 5.0)
```

Displays a training mode HUD element with the given title and text for a specified duration.

>[!WARNING]
> Training HUD elements have some important limitations.  See [the VDC page](https://developer.valvesoftware.com/wiki/Tf_logic_training_mode) for more details.

---

<a name="PopExtUtil.GetPlayerName"></a>

```cpp
string PopExtUtil::GetPlayerName(handle player)
```

---

<a name="PopExtUtil.SetPlayerName"></a>

```cpp
string PopExtUtil::SetPlayerName(handle player, string name)
```

Sets player name, also returns this name

---

<a name="PopExtUtil.GetPlayerUserID"></a>

```cpp
int PopExtUtil::GetPlayerUserID(handle player)
```

---

<a name="PopExtUtil.PlayerRespawn"></a>

```cpp
void PopExtUtil::PlayerRespawn()
```

Force resupplies and respawns a player

---

<a name="PopExtUtil.DisableCloak"></a>

```cpp
void PopExtUtil::DisableCloak(handle player)
```

Disables player's ability to cloak

---

<a name="PopExtUtil.InUpgradeZone"></a>

```cpp
bool PopExtUtil::InUpgradeZone(handle player)
```

Is the player in upgrade zone?

---

<a name="PopExtUtil.InButton"></a>

```cpp
bool PopExtUtil::InButton(handle player, Constants.FButtons button)
```

Is the player holding down this button?

---

<a name="PopExtUtil.PressButton"></a>

```cpp
void PopExtUtil::PressButton(handle player, Constants.FButtons button)
```

Presses down a button for the player without releasing it

---

<a name="PopExtUtil.ReleaseButton"></a>

```cpp
void PopExtUtil::ReleaseButton(handle player, Constants.FButtons button)
```

Releases a button for the player

---

<a name="PopExtUtil.IsPointInRespawnRoom"></a>

```cpp
bool PopExtUtil::IsPointInRespawnRoom(Vector point)
```

Is this point in respawn room?

---

<a name="PopExtUtil.SwitchWeaponSlot"></a>

```cpp
void PopExtUtil::SwitchWeaponSlot(handle player, int slot)
```

Does the same thing as [`WeaponSwitchSlot`](#PopExtUtil.WeaponSwitchSlot)

---

<a name="PopExtUtil.GetItemInSlot"></a>

```cpp
handle PopExtUtil::GetItemInSlot(handle player, int slot)
```

Returns the script handle of the weapon of a player, given a slot

---

<a name="PopExtUtil.SwitchToFirstValidWeapon"></a>

```cpp
void PopExtUtil::SwitchToFirstValidWeapon(handle player)
```

Switches to the first valid weapon found

---

<a name="PopExtUtil.HasEffect"></a>

```cpp
bool PopExtUtil::HasEffect(handle ent, int value)
```

Does this ent have this effect?

---

<a name="PopExtUtil.SetEffect"></a>

```cpp
void PopExtUtil::SetEffect(handle ent, int value)
```

Sets an effect onto an ent

---

<a name="PopExtUtil.PlayerRobotModel"></a>

```cpp
void PopExtUtil::PlayerRobotModel(handle player, string model)
```

Set a robot model onto a player

---

<a name="PopExtUtil.HasItemInLoadout"></a>

```cpp
handle PopExtUtil::HasItemInLoadout(handle player, int/string/handle index)
```

Does the player has this item in their loadout? If yes, returns that weapon handle. If not, returns null. `index` accepts many types of weapon identification: a weapon ent handle, a classname, an internal name, and the weapon index itself.

---

<a name="PopExtUtil.StunPlayer"></a>

```cpp
void PopExtUtil::StunPlayer(handle player, float duration = 5, Constants.TF_STUN type = 1, float delay = 0, float speedreduce = 0.5)
```

Stuns a player with the given params.

---

<a name="PopExtUtil.Ignite"></a>

```cpp
void PopExtUtil::Ignite(handle player, float duration = 10.0, float damage = 1)
```

Ignites a player

---

<a name="PopExtUtil.ShowHudHint"></a>

```cpp
void PopExtUtil::ShowHudHint(string text = "This is a hud hint", handle player = null, float duration = 5.0)
```

---

<a name="PopExtUtil.SetEntityColor"></a>

```cpp
void PopExtUtil::SetEntityColor(handle entity, int r, int g, int b, int a)
```

---

<a name="PopExtUtil.GetEntityColor"></a>

```cpp
table PopExtUtil::GetEntityColor(handle entity)
```

Returns an integer-valued table of keys "r", "g", "b", "a"

---

<a name="PopExtUtil.AddAttributeToLoadout"></a>

```cpp
void PopExtUtil::AddAttributeToLoadout(handle player, string attribute, int/float/bool/string value, float duration = -1)
```

---

<a name="PopExtUtil.ShowModelToPlayer"></a>

```cpp
handle PopExtUtil::ShowModelToPlayer(handle player, string model = ["models/player/heavy.mdl", 0], Vector pos = Vector(), QAngle ang = QAngle(), float duration = INT_MAX)
```

`INT_MAX` is a constant defined in [constants.nut](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/constants.nut)

---

<a name="PopExtUtil.LockInPlace"></a>

```cpp
void PopExtUtil::LockInPlace(handle player, bool enable = true)
```

Locks a player in place and disables weapon switching. Pass `false` to `enable` to un-lock a player

---

<a name="PopExtUtil.GetItemIndex"></a>

```cpp
int PopExtUtil::GetItemIndex(handle item)
```

---

<a name="PopExtUtil.SetItemIndex"></a>

```cpp
void PopExtUtil::SetItemIndex(handle item, int index)
```

---

<a name="PopExtUtil.SetTargetname"></a>

```cpp
void PopExtUtil::SetTargetname(handle ent, string name)
```

---

<a name="PopExtUtil.GetPlayerSteamID"></a>

```cpp
string PopExtUtil::GetPlayerSteamID(handle player)
```

---

<a name="PopExtUtil.GetHammerID"></a>

```cpp
int PopExtUtil::GetHammerID(handle ent)
```

---

<a name="PopExtUtil.GetSpawnFlags"></a>

```cpp
int PopExtUtil::GetSpawnFlags(handle ent)
```

---

<a name="PopExtUtil.GetPopfileName"></a>

```cpp
string PopExtUtil::GetPopfileName()
```

---

<a name="PopExtUtil.PrecacheParticle"></a>

```cpp
void PopExtUtil::PrecacheParticle(string name)
```

---

<a name="PopExtUtil.SpawnEffect"></a>

```cpp
void PopExtUtil::SpawnEffect(handle player, string effect)
```

On player spawn, dispatches an effect

---

<a name="PopExtUtil.RemoveOutputAll"></a>

```cpp
void PopExtUtil::RemoveOutputAll(handle ent, string output)
```

Remove all such outputs from an entity

---

<a name="PopExtUtil.RemovePlayerWearables"></a>

```cpp
void PopExtUtil::RemovePlayerWearables(handle player)
```

Remove all player wearables

---

<a name="PopExtUtil.GiveWeapon"></a>

```cpp
handle PopExtUtil::GiveWeapon(handle player, string className, int/string itemID)
```

Gives and equips a weapon onto a player while removing the existing weapon in that slot.

---

<a name="PopExtUtil.IsEntityClassnameInList"></a>

```cpp
bool PopExtUtil::IsEntityClassnameInList(handle entity, table/array list)
```

---

<a name="PopExtUtil.SetPlayerClassRespawnAndTeleport"></a>

```cpp
void PopExtUtil::SetPlayerClassRespawnAndTeleport(handle player, Constants.ETFClass playerclass, Vector location_set = null)
```

---

<a name="PopExtUtil.PlaySoundOnClient"></a>

```cpp
void PopExtUtil::PlaySoundOnClient(handle player, string name, float volume = 1.0, float pitch = 100)
```

A wrapper function for `EmitSoundEx()`

---

<a name="PopExtUtil.PlaySoundOnAllClients"></a>

```cpp
void PopExtUtil::PlaySoundOnAllClients(string name)
```

---

<a name="PopExtUtil.StopAndPlayMVMSound"></a>

```cpp
void PopExtUtil::StopAndPlayMVMSound(handle player, string soundscript, float delay)
```

Stops the current sound and plays an MvM sound

---

<a name="PopExtUtil.EndWaveReverse"></a>

```cpp
void PopExtUtil::EndWaveReverse(bool doteamswitch = true)
```

Ends the wave in reverse mode

---

<a name="PopExtUtil.AddThinkToEnt"></a>

```cpp
void PopExtUtil::AddThinkToEnt(handle ent, function() func)
```

This function replaces the vanilla `AddThinkToEnt()`. If using popext, use this function to add thinks to ents.

---

<a name="PopExtUtil.SilentDisguise"></a>

```cpp
void PopExtUtil::SilentDisguise(handle player, handle target = null, Constants.ETFTeam tfteam = TF_TEAM_PVE_INVADERS, Constants.ETFClass tfclass = TF_CLASS_SCOUT)
```

Silently disguises without raising bot attention

---

<a name="PopExtUtil.GetPlayerReadyCount"></a>

```cpp
int PopExtUtil::GetPlayerReadyCount()
```

---

<a name="PopExtUtil.GetWeaponMaxAmmo"></a>

```cpp
int PopExtUtil::GetWeaponMaxAmmo(handle player, handle wep)
```

---

<a name="PopExtUtil.TeleportNearVictim"></a>

```cpp
bool PopExtUtil::TeleportNearVictim(handle ent, handle victim, int attempt)
```

---

<a name="PopExtUtil.IsSpaceToSpawnHere"></a>

```cpp
bool PopExtUtil::IsSpaceToSpawnHere(Vector where, Vector hullmin, Vector hullmax)
```

Is there space to spawn a thing here?

---

<a name="PopExtUtil.ClearLastKnownArea"></a>

```cpp
void PopExtUtil::ClearLastKnownArea(handle bot)
```

---

<a name="PopExtUtil.KillPlayer"></a>

```cpp
void PopExtUtil::KillPlayer(handle player)
```

---

<a name="PopExtUtil.KillAllBots"></a>

```cpp
void PopExtUtil::KillAllBots()
```

---

<a name="PopExtUtil.SetDestroyCallback"></a>

```cpp
void PopExtUtil::SetDestroyCallback(handle entity, function() callback)
```

Sets a thing to be done when the entity is destroyed. See more info [here on the VDC wiki](https://developer.valvesoftware.com/wiki/Team_Fortress_2/Scripting/Script_Functions#OnDestroy)

---

<a name="PopExtUtil.OnWeaponFire"></a>

```cpp
void PopExtUtil::OnWeaponFire(handle wep, function() func)
```

Sets a thing to be done when the weapon fires.


---

<a name="PopExtUtil.IsProjectileWeapon"></a>

```cpp
bool PopExtUtil::IsProjectileWeapon(handle wep)
```

Returns true if the weapon is a projectile weapon.  See [`PROJECTILE_WEAPONS`](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/shared/util.nut#L111) for a list of projectile weapons.

---

<a name="PopExtUtil.GetLastFiredProjectile"></a>

```cpp
handle PopExtUtil::GetLastFiredProjectile(handle player)
```

Returns the last fired projectile for a player.

>[!NOTE]
> This function must be called after the weapon has fired to correctly detect the last projectile.  See [`replace weapon fire sound`](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut#L905) for an example.

---

<a name="PopExtUtil.ChangeLevel"></a>

```cpp
void PopExtUtil::ChangeLevel(string mapname = "", float delay = 1.0, bool mvm_cyclemissionfile = false)
```

Changes the level to the specified map.  If `mvm_cyclemissionfile` is true, the next map in the missioncycle file will be loaded immediately with no delay.

>[!NOTE]
> For the default `mvm_cyclemissionfile = false` behavior to work, dedicated servers must add `nextlevel` to their vscript convar allowlist, or set `sv_allow_point_servercommand` to `always`.

---

<a name="PopExtUtil.ToStrictNum"></a>

```cpp
float/int PopExtUtil::ToStrictNum(string str, bool float = false)
```

Converts a string to a float or integer.  Returns `null` if the string cannot be converted.

---

<a name="PopExtUtil.SetRedMoney"></a>

```cpp
void PopExtUtil::SetRedMoney(int value)
```

Toggles red money drops (auto-collected money) when a player kills a bot.

---

<a name="PopExtUtil.SetConvar"></a>

```cpp
void PopExtUtil::SetConvar(string convar, string value, float duration = 0, bool hide_chat_message = true)
```

Sets a whitelisted convar that will be automatically reset to its default value on the next wave, or after a specified duration.

---

<a name="PopExtUtil.ResetConvars"></a>

```cpp
void PopExtUtil::ResetConvars(bool hide_chat_message = true)
```

Resets all convars set by `PopExtUtil.SetConvar()` to their default values.

>[!NOTE]
> This will not reset convars set directly by `Convars.SetValue()`.

---

<a name="PopExtUtil.KVStringToVectorOrQAngle"></a>

```cpp
Vector/QAngle PopExtUtil::KVStringToVectorOrQAngle(string str, bool angles = false, int startidx = 0)
```

Converts a string to a Vector or QAngle.  `startidx` will start at a given character for handling combined vector/angle strings such as `"100 100 100 90 0 0"`.

---

<a name="PopExtUtil.ValidatePlayerTables"></a>

```cpp
void PopExtUtil::ValidatePlayerTables()
```


Validates the player tables.  Removes invalid players from the table.

>[!NOTE]
> This is handled internally when player tables are updated, and `PopExtUtil.CountAlivePlayers()` is called.

---

<a name="PopExtUtil.Min"></a>

```cpp
float PopExtUtil::Min(float a, float b)
```

Returns the smaller of the two numbers

---

<a name="PopExtUtil.Max"></a>

```cpp
float PopExtUtil::Max(float a, float b)
```

Returns the greater of the two numbers

---

<a name="PopExtUtil.Round"></a>

```cpp
float PopExtUtil::Round(float num, int decimals = 0)
```

Rounds a number to a certain decimal place precision

---

<a name="PopExtUtil.Clamp"></a>

```cpp
float PopExtUtil::Clamp(float x, float a, float b)
```

Clamps a value between a and b

---

<a name="PopExtUtil.RemapVal"></a>

```cpp
float PopExtUtil::RemapVal(float v, float A, float B, float C, float D)
```

Remaps a value in the range [A,B] to [C,D]

---

<a name="PopExtUtil.RemapValClamped"></a>

```cpp
float PopExtUtil::RemapValClamped(float v, float A, float B, float C, float D)
```

---

<a name="PopExtUtil.IntersectionPointBox"></a>

```cpp
bool PopExtUtil::IntersectionPointBox(Vector pos, Vector mins, Vector maxs)
```

Is this position in the specified box?

---

<a name="PopExtUtil.NormalizeAngle"></a>

```cpp
float PopExtUtil::NormalizeAngle(float target)
```

---

<a name="PopExtUtil.ApproachAngle"></a>

```cpp
float PopExtUtil::ApproachAngle(float target, float value, float speed)
```

---

<a name="PopExtUtil.VectorAngles"></a>

```cpp
QAngle PopExtUtil::VectorAngles(Vector forward)
```

Forward direction vector -> Euler QAngle

---

<a name="PopExtUtil.AnglesToVector"></a>

```cpp
Vector PopExtUtil::AnglesToVector(QAngle angles)
```

---

<a name="PopExtUtil.QAngleDistance"></a>

```cpp
float PopExtUtil::QAngleDistance(QAngle a, QAngle b)
```

---

<a name="PopExtUtil.CheckBitwise"></a>

```cpp
bool PopExtUtil::CheckBitwise(int num)
```

---

<a name="PopExtUtil.StringReplace"></a>

```cpp
string PopExtUtil::StringReplace(string str, string findwhat, string replace)
```

---

<a name="PopExtUtil.capwords"></a>

```cpp
string PopExtUtil::capwords(string s, string sep = null)
```

Python's string.capwords()

---
