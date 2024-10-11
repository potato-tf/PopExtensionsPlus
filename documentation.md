# PopExtensionsPlus Documentation

*Documentation last updated [11.10.2024]*

A work-in-progress documentation for [PopExt](https://github.com/potato-tf/PopExtensionsPlus). Pull requests on areas that are still being worked on are most welcomed.

As updates to PopExt are made consistently, this documentation will inevitably fall slightly behind. Please also feel free to make pull requests to fill in new missing parts.

For bug reports, please make a post in our [Discord](https://discord.gg/M8YbW3k) under "archive_restoration/PopExtensions Meta" or submit a pull request!

## Table of Contents

> [!NOTE]
> A section that does not have a link means that it does not exist in the documentation yet.

└─ [README and the example pop](#readme-and-the-example-pop)  
└─ **Menus and references**  
⠀⠀⠀└─ popextensions_main  
⠀⠀⠀└─ botbehaviour  
⠀⠀⠀└─ [customattributes](#customattributes-menu)  
⠀⠀⠀└─ customweapons  
⠀⠀⠀└─ ent_additions  
⠀⠀⠀└─ globalfixes  
⠀⠀⠀└─ hooks  
⠀⠀⠀└─ [missionattributes](#missionattributes-menu)  
⠀⠀⠀└─ [popextensions](#popextensions-menu)  
⠀⠀⠀└─ populator  
⠀⠀⠀└─ spawntemplate  
⠀⠀⠀└─ [tags](#tags-menu)  
⠀⠀⠀└─ tutorialtools  
⠀⠀⠀└─ [util](#util-menu)  
⠀⠀⠀└─ [**Constants defined by PopExt**](#constants-defined-by-popext)  
⠀⠀⠀⠀⠀⠀└─ [attribute_map](#attribute_map)  
⠀⠀⠀⠀⠀⠀└─ [constants](#constants)  
⠀⠀⠀⠀⠀⠀└─ [item_map](#item_map)  
⠀⠀⠀⠀⠀⠀└─ [itemdef_constants](#itemdef_constants)  
⠀⠀⠀⠀⠀⠀└─ robotvoicelines

## README and the example pop

The [README](https://github.com/potato-tf/PopExtensionsPlus/blob/main/README.md) contains instruction to installation and usage, as well as a brief idea of what most of the sub-files do.

> [!WARNING]
> The README has not been maintained in a while and carries possibly outdated information.

The [example pop](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/population/mvm_bigrock_vscript.pop) demonstrates how most of the keyvalues work in a practical setting.

## [customattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut) menu

### Attributes

[`fires milk bolt`](#CustomAttributes.FiresMilkBolt)  
[`mod teleporter speed boost`](#CustomAttributes.ModTeleporterSpeedBoost)  
[`set turn to ice`](#CustomAttributes.SetTurnToIce)  
[`mult teleporter recharge rate`](#CustomAttributes.MultTeleporterRechargeTime)  
[`melee cleave attack`](#CustomAttributes.MeleeCleaveAttack)  
[`last shot crits`](#CustomAttributes.LastShotCrits)  
[`wet immunity`](#CustomAttributes.WetImmunity)  
[`can breathe under water`](#CustomAttributes.CanBreatheUnderWater)  
[`mult swim speed`](#CustomAttributes.MultSwimSpeed)  
[`teleport instead of die`](#CustomAttributes.TeleportInsteadOfDie)  
[`mult dmg vs same class`](#CustomAttributes.MultDmgVsSameClass)  
[`uber on damage taken`](#CustomAttributes.UberOnDamageTaken)  
[`build small sentries`](#CustomAttributes.BuildSmallSentries)  
[`crit when health below`](#CustomAttributes.CritWhenHealthBelow)  
[`mvm sentry ammo`](#CustomAttributes.MvmSentryAmmo)  
[`radius sleeper`](#CustomAttributes.RadiusSleeper)  
[`explosive bullets`](#CustomAttributes.ExplosiveBullets)  
[`old sandman stun`](#CustomAttributes.OldSandmanStun)  
[`stun on hit`](#CustomAttributes.StunOnHit)  
[`is miniboss`](#CustomAttributes.IsMiniboss)  
[`replace weapon fire sound`](#CustomAttributes.ReplaceWeaponFireSound)  
[`is invisible`](#CustomAttributes.IsInvisible)  
[`cannot upgrade`](#CustomAttributes.CannotUpgrade)  
[`always crit`](#CustomAttributes.AlwaysCrit)  
[`dont count damage towards crit rate`](#CustomAttributes.DontCountDamageTowardsCritRate)  
[`no damage falloff`](#CustomAttributes.NoDamageFalloff)  
[`can headshot`](#CustomAttributes.CanHeadshot)  
[`cannot headshot`](#CustomAttributes.CannotHeadshot)  
[`cannot be headshot`](#CustomAttributes.CannotBeHeadshot)  
[`projectile lifetime`](#CustomAttributes.ProjectileLifetime)  
[`mult dmg vs tanks`](#CustomAttributes.MultDmgVsTanks)  
[`mult dmg vs giants`](#CustomAttributes.MultDmgVsGiants)  
[`mult dmg vs airborne`](#CustomAttributes.MultDmgVsAirborne)  
[`set damage type`](#CustomAttributes.SetDamageType)  
[`set damage type custom`](#CustomAttributes.SetDamageTypeCustom)  
[`reloads full clip at once`](#CustomAttributes.ReloadsFullClipAtOnce)  
[`fire full clip at once`](#CustomAttributes.FireFullClipAtOnce)  
[`passive reload`](#CustomAttributes.PassiveReload)  
[`mult projectile scale`](#CustomAttributes.MultProjectileScale)  
[`mult building scale`](#CustomAttributes.MultBuildingScale)  
[`mult crit dmg`](#CustomAttributes.MultCritDmg)  
[`arrow ignite`](#CustomAttributes.ArrowIgnite)  
[`add cond on hit`](#CustomAttributes.AddCondOnHit)  
[`remove cond on hit`](#CustomAttributes.RemoveCondOnHit)  
[`self add cond on hit`](#CustomAttributes.SelfAddCondOnHit)  
[`add cond on kill`](#CustomAttributes.SelfAddCondOnKill)  
[`add cond when active`](#CustomAttributes.AddCondWhenActive)  
[`fire input on hit`](#CustomAttributes.FireInputOnHit)  
[`fire input on kill`](#CustomAttributes.FireInputOnKill)  
[`rocket penetration`](#CustomAttributes.RocketPenetration)  
[`collect currency on kill`](#CustomAttributes.CollectCurrencyOnKill)  
[`noclip projectile`](#CustomAttributes.NoclipProjectile)  
[`projectile gravity`](#CustomAttributes.ProjectileGravity)  
[`immune to cond`](#CustomAttributes.ImmuneToCond)  
[`mult max health`](#CustomAttributes.MultMaxHealth)  
[`special item description`](#CustomAttributes.SpecialItemDescription)  
[`alt-fire disabled`](#CustomAttributes.AltFireDisabled)  
[`custom projectile model`](#CustomAttributes.CustomProjectileModel)  
[`dmg bonus while half dead`](#CustomAttributes.DmgBonusWhileHalfDead)  
[`dmg penalty while half alive`](#CustomAttributes.DmgPenaltyWhileHalfAlive)  

## [missionattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/missionattributes.nut) menu

back-and-forth links

## [popextensions](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/popextensions.nut) menu

### Methods

back-and-forth links

## [tags](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/tags.nut) menu

back-and-forth links

## [util](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/util.nut) menu

### Methods

back-and-forth links

## Constants defined by PopExt

### [attribute_map](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/attribute_map.nut)

---

### [constants](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/constants.nut)

insert table here

---

### [item_map](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/item_map.nut)

---

### [itemdef_constants](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/itemdef_constants.nut)

---

## [customattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut) references

<a name="CustomAttributes.FiresMilkBolt"></a>

```js
// hud hint text on inspection
"Secondary attack: fires a bolt that applies milk for %.2f seconds. Regenerates every %.2f seconds."

// example popfile usage
`fires milk bolt`: { duration = 5, recharge = 24 } // defaults to duration = 10, recharge = 20
```

---

<a name="CustomAttributes.ModTeleporterSpeedBoost"></a>

```js
// hud hint text on inspection
"Teleporters grant a speed boost for %.2f seconds"

// example popfile usage
`mod teleporter speed boost`: 5
```

---

<a name="CustomAttributes.SetTurnToIce"></a>

```js
// hud hint text on inspection
"On Kill: Turn victim to ice."

// popfile usage
`set turn to ice`: 1
```

---

<a name="CustomAttributes.MultTeleporterRechargeTime"></a>

```js
// hud hint text on inspection
"Teleporter recharge rate multiplied by %.2f"

// example popfile usage
`mult teleporter recharge time`: 0.25
```

---

<a name="CustomAttributes.MeleeCleaveAttack"></a>

```js
// hud hint text on inspection
"On Swing: Weapon hits multiple targets"

// popfile usage
`melee cleave attack`: 64
```

---

<a name="CustomAttributes.LastShotCrits"></a>

```js
// hud hint text on inspection
"Crit boost on last shot. Crit boost will stay active for %.2f seconds upon holster"

// example popfile usage
`last shot crits`: 0.1
```

---

<a name="CustomAttributes.WetImmunity"></a>

```js
// hud hint text on inspection
"Immune to jar effects"

// popfile usage
`wet immunity`: 1
```

---

<a name="CustomAttributes.CanBreatheUnderWater"></a>

```js
// hud hint text on inspection
"Player can breathe underwater"

// popfile usage
`can breathe under water`: 1
```

---

<a name="CustomAttributes.MultSwimSpeed"></a>

```js
// hud hint text on inspection
"Swimming speed multiplied by %.2f"

// example popfile usage
`mult swim speed`: 1.5
```

---

<a name="CustomAttributes.TeleportInsteadOfDie"></a>

```js
// hud hint text on inspection
"%d⁒ chance of teleporting to spawn with 1 health instead of dying"

// example popfile usage
`teleport instead of die`: 0.5
```

---

<a name="CustomAttributes.MultDmgVsSameClass"></a>

```js
// hud hint text on inspection
"Damage versus %s multiplied by %.2f" // %s is player class

// example popfile usage
`mult dmg vs same class`: 1.3
```

---

<a name="CustomAttributes.UberOnDamageTaken"></a>

```js
// hud hint text on inspection
"On take damage: %d⁒ chance of gaining invicibility for 3 seconds"

// example popfile usage
`uber on damage taken`: 0.5
```

---

<a name="CustomAttributes.BuildSmallSentries"></a>

```js
// hud hint text on inspection
"Sentries are 20⁒ smaller, have 33⁒ less health, take 25⁒ less metal to upgrade"

// popfile usage
`build small sentries`: 1
```

---

<a name="CustomAttributes.CritWhenHealthBelow"></a>

```js
// hud hint text on inspection
"Player is crit boosted when below %d health"

// example popfile usage
`crit when health below`: 75
```

---

<a name="CustomAttributes.MvmSentryAmmo"></a>

```js
// hud hint text on inspection
"Sentry ammo multiplied by %.2f"

// example popfile usage
`mvm sentry ammo`: 3
```

---

<a name="CustomAttributes.RadiusSleeper"></a>

```js
// hud hint text on inspection
"On full charge headshot: create jarate explosion on victim"

// popfile usage
`radius sleeper`: 1
```

---

<a name="CustomAttributes.ExplosiveBullets"></a>

```js
// hud hint text on inspection
"Fires explosive rounds that deal %d damage"

// example popfile usage
`explosive bullets`: 20
```

---

<a name="CustomAttributes.OldSandmanStun"></a>

```js
// hud hint text on inspection
"Uses pre-JI stun mechanics"

// popfile usage
`old sandman stun`: 1
```

---

<a name="CustomAttributes.StunOnHit"></a>

```js
// hud hint text on inspection
"Stuns victim for %.2f seconds on hit"

// example popfile usage
`stun on hit`: { duration = 3, type = 2, speedmult = 0.4, stungiants = true } // defaults to, from left to right: 5, 2, 0.2, true
```

---

<a name="CustomAttributes.IsMiniboss"></a>

```js
// hud hint text on inspection
"When weapon is active: player becomes giant"

// popfile usage
`is miniboss`: 1
```

---

<a name="CustomAttributes.ReplaceWeaponFireSound"></a>

```js
// hud hint text on inspection
"Weapon fire sound replaced with %s"

// example popfile usage
`replace weapon fire sound`: [null, `firesound.wav`] // this file is in a sound folder
```

> [!WARNING]
> This attribute doesn't seem to work currently

---

<a name="CustomAttributes.IsInvisible"></a>

```js
// hud hint text on inspection
"Weapon is invisible"

// popfile usage
`is invisible`: 1
```

---

<a name="CustomAttributes.CannotUpgrade"></a>

```js
// hud hint text on inspection
"Weapon cannot be upgraded"

// popfile usage
`cannot upgrade`: 1
```

---

<a name="CustomAttributes.AlwaysCrit"></a>

```js
// hud hint text on inspection
"Weapon always crits"

// popfile usage
`always crit`: 1
```

---

<a name="CustomAttributes.DontCountDamageTowardsCritRate"></a>

```js
// hud hint text on inspection
"Damage doesn't count towards crit rate"

// popfile usage
`dont count damage towards crit rate`: 1
```

---

<a name="CustomAttributes.NoDamageFalloff"></a>

```js
// hud hint text on inspection
"Weapon has no damage fall-off or ramp-up"

// popfile usage
`no damage falloff`: 1
```

---

<a name="CustomAttributes.CanHeadshot"></a>

```js
// hud hint text on inspection
"Crits on headshot"

// popfile usage
`can headshot`: 1
```

---

<a name="CustomAttributes.CannotHeadshot"></a>

```js
// hud hint text on inspection
"weapon cannot headshot"

// popfile usage
`cannot headshot`: 1
```

---

<a name="CustomAttributes.CannotBeHeadshot"></a>

```js
// hud hint text on inspection
"Immune to headshots"

// popfile usage
`cannot be headshot`: 1
```

---

<a name="CustomAttributes.ProjectileLifetime"></a>

```js
// hud hint text on inspection
"projectile disappears after %.2f seconds"

// example popfile usage
`projectile lifetime`: 8
```

---

<a name="CustomAttributes.MultDmgVsTanks"></a>

```js
// hud hint text on inspection
"Damage vs tanks multiplied by %.2f"

// example popfile usage
`mult dmg vs tanks`: 2
```

---

<a name="CustomAttributes.MultDmgVsGiants"></a>

```js
// hud hint text on inspection
"Damage vs giants multiplied by %.2f"

// example popfile usage
`mult dmg vs giants`: 2
```

---

<a name="CustomAttributes.MultDmgVsAirborne"></a>

```js
// hud hint text on inspection
"damage multiplied by %.2f against airborne targets"

// example popfile usage
`mult dmg vs airborne`: 2
```

---

<a name="CustomAttributes.SetDamageType"></a>

```js
// hud hint text on inspection
"Damage type set to %d"

// example popfile usage
`set damage type`: DMG_CRITICAL // defined in constants.nut as part of popext, thanks!
```

---

<a name="CustomAttributes.SetDamageTypeCustom"></a>

```js
// hud hint text on inspection
"Custom damage type set to %d"

// example popfile usage
`set damage type custom`: DMG_MELEE // defined in constants.nut as part of popext, thanks!
```

---

<a name="CustomAttributes.ReloadsFullClipAtOnce"></a>

```js
// hud hint text on inspection
"This weapon reloads its entire clip at once."

// popfile usage
`reloads full clip at once`: 1
```

---

<a name="CustomAttributes.FireFullClipAtOnce"></a>

```js
// hud hint text on inspection
"weapon fires full clip at once"

// popfile usage
`fire full clip at once`: 1
```

---

<a name="CustomAttributes.PassiveReload"></a>

```js
// hud hint text on inspection
"weapon reloads when holstered"

// popfile usage
`passive reload`: 1
```

---

<a name="CustomAttributes.MultProjectileScale"></a>

```js
// hud hint text on inspection
"projectile scale multiplied by %.2f"

// example popfile usage
`mult projectile scale`: 4
```

---

<a name="CustomAttributes.MultBuildingScale"></a>

```js
// hud hint text on inspection
"building scale multiplied by %.2f"

// example popfile usage
`mult building scale`: 0.25
```

---

<a name="CustomAttributes.MultCritDmg"></a>

```js
// hud hint text on inspection
"crit damage multiplied by %.2f"

// example popfile usage
`mult crit dmg`: 0.5
```

---

<a name="CustomAttributes.ArrowIgnite"></a>

```js
// hud hint text on inspection
"arrows are always ignited"

// popfile usage
`arrow ignite`: 1
```

---

<a name="CustomAttributes.AddCondOnHit"></a>

```js
// hud hint text on inspection
"applies cond %d to victim on hit"

// example popfile usage
`add cond on hit`: 27
`add cond on hit`: [27, 10] // this will apply cond 27 for 10 seconds on hit
```

---

<a name="CustomAttributes.RemoveCondOnHit"></a>

```js
// hud hint text on inspection
"Remove cond %d on hit"

// example popfile usage
`remove cond on hit`: 27
```

---

<a name="CustomAttributes.SelfAddCondOnHit"></a>

```js
// hud hint text on inspection
"applies cond %d to self on hit"

// example popfile usage
`self add cond on hit`: 27
`self add cond on hit`: [27, 10] // this will apply cond 27 to self for 10 seconds on hit
```

---

<a name="CustomAttributes.SelfAddCondOnKill"></a>

```js
// hud hint text on inspection
"applies cond %d to self on kill"

// example popfile usage
`self add cond on kill`: 27
`self add cond on kill`: [27, 10] // this will apply cond 27 to self for 10 seconds on kill
```

---

<a name="CustomAttributes.AddCondWhenActive"></a>

```js
// hud hint text on inspection
"when active: player receives cond %d"

// example popfile usage
`add cond when active`: 27
```

---

<a name="CustomAttributes.FireInputOnHit"></a>

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

> [!WARNING]
> Look out for the escape character (\\`) to represent a quote in the context of nested strings.

---

<a name="CustomAttributes.FireInputOnKill"></a>

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

> [!WARNING]
> Look out for the escape character (\\`) to represent a quote in the context of nested strings.

---

<a name="CustomAttributes.RocketPenetration"></a>

```js
// hud hint text on inspection
"rocket penetrates up to %d enemy players"

// example popfile usage
`rocket penetration`: 2
```

---

<a name="CustomAttributes.CollectCurrencyOnKill"></a>

```js
// hud hint text on inspection
"bots drop money when killed"

// popfile usage
`collect currency on kill`: 1
```

---

<a name="CustomAttributes.NoclipProjectile"></a>

```js
// hud hint text on inspection
"projectiles go through walls and enemies harmlessly"

// popfile usage
`noclip projectile`: 1
```

---

<a name="CustomAttributes.ProjectileGravity"></a>

```js
// hud hint text on inspection
"projectile gravity %d hu/s"

// example popfile usage
`projectile gravity`: 100
```

---

<a name="CustomAttributes.ImmuneToCond"></a>

```js
// hud hint text on inspection
"wielder is immune to cond %d" // more numbers appear if you type in an array

// example popfile usage
`immune to cond`: 30
`immune to cond`: [30, 31, 32, 33, 34] // array length has no limit, hud hint displays accordingly
```

---

<a name="CustomAttributes.MultMaxHealth"></a>

```js
// hud hint text on inspection
"Player max health is multiplied by %.2f"

// example popfile usage
`mult max health`: 2.5
```

---

<a name="CustomAttributes.SpecialItemDescription"></a>

```js
// hud hint text on inspection
"(custom description)"

// example popfile usage
`special item description`: `This description is very cool`
```

---

<a name="CustomAttributes.AltFireDisabled"></a>

```js
// hud hint text on inspection
"Secondary fire disabled"

// popfile usage
`alt-fire disabled`: 1
```

---

<a name="CustomAttributes.CustomProjectileModel"></a>

```js
// hud hint text on inspection
"Fires custom projectile model: %s"

// very goofy example popfile usage, that is, if you have this directory.
`custom projectile model`: `models/props_mvm/robot_hologram_color.mdl`
```

---

<a name="CustomAttributes.DmgBonusWhileHalfDead"></a>

```js
// hud hint text on inspection
"damage bonus while under 50% health"

// example popfile usage
`dmg bonus while half dead`: 3
```

---

<a name="CustomAttributes.DmgPenaltyWhileHalfAlive"></a>

```js
// hud hint text on inspection
"damage penalty while above 50% health"

// example popfile usage
`damage penalty while half alive`: 0.66
```

---
