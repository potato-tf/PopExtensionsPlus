# PopExtensionsPlus Documentation

*Documentation last updated [28.10.2024]*

A work-in-progress documentation for [PopExt](https://github.com/potato-tf/PopExtensionsPlus), so some areas are still being worked on. As updates to PopExt are made consistently, this documentation will also inevitably fall slightly behind.

For the above issues, typos, grammar mistakes, as well as bug reports in PopExt itself, please make a post in our [Discord](https://discord.gg/M8YbW3k) under "archive_restoration/PopExtensions Meta" or submit a pull request!

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

### Attributes

[`ForceHoliday`](#MissionAttributes.ForceHoliday)  
[`RedBotsNoRandomCrit`](#MissionAttributes.RedBotsNoRandomCrit)  
[`NoCrumpkins`](#MissionAttributes.NoCrumpkins)  
[`NoReanimators`](#MissionAttributes.NoReanimators)  
[`AllMobber`](#MissionAttributes.AllMobber)  
[`StandableHeads`](#MissionAttributes.StandableHeads)  
[`666Wavebar`](#MissionAttributes.666Wavebar)  
[`WaveNum`](#MissionAttributes.WaveNum)  
[`MaxWaveNum`](#MissionAttributes.MaxWaveNum)  
[`HuntsmanDamageFix`](#MissionAttributes.HuntsmanDamageFix)  
[`NegativeDmgHeals`](#MissionAttributes.NegativeDmgHeals)  
[`MultiSapper`](#MissionAttributes.MultiSapper)  
[`SetDamageTypeIgniteFix`](#MissionAttributes.SetDamageTypeIgniteFix)  
[`NoRefunds`](#MissionAttributes.NoRefunds)  
[`RefundLimit`](#MissionAttributes.RefundLimit)  
[`RefundGoal`](#MissionAttributes.RefundGoal)  
[`FixedBuybacks`](#MissionAttributes.FixedBuybacks)  
[`BuybacksPerWave`](#MissionAttributes.BuybacksPerWave)  
[`NoBuybacks`](#MissionAttributes.NoBuybacks)  
[`DeathPenalty`](#MissionAttributes.DeathPenalty)  
[`BonusRatioHalf`](#MissionAttributes.BonusRatioHalf)  
[`BonusRatioFull`](#MissionAttributes.BonusRatioFull)  
[`UpgradeFile`](#MissionAttributes.UpgradeFile)  
[`FlagEscortCount`](#MissionAttributes.FlagEscortCount)  
[`BombMovementPenalty`](#MissionAttributes.BombMovementPenalty)  
[`MaxSkeletons`](#MissionAttributes.MaxSkeletons)  
[`TurboPhysics`](#MissionAttributes.TurboPhysics)  
[`Accelerate`](#MissionAttributes.Accelerate)  
[`AirAccelerate`](#MissionAttributes.AirAccelerate)  
[`BotPushaway`](#MissionAttributes.BotPushaway)  
[`TeleUberDuration`](#MissionAttributes.TeleUberDuration)  
[`RedMaxPlayers`](#MissionAttributes.RedMaxPlayers)  
[`MaxVelocity`](#MissionAttributes.MaxVelocity)  
[`ConchHealthOnHitRegen`](#MissionAttributes.ConchHealthOnHitRegen)  
[`MarkForDeathLifetime`](#MissionAttributes.MarkForDeathLifetime)  
[`GrapplingHookEnable`](#MissionAttributes.GrapplingHookEnable)  
[`GiantScale`](#MissionAttributes.GiantScale)  
[`VacNumCharges`](#MissionAttributes.VacNumCharges)  
[`DoubleDonkWindow`](#MissionAttributes.DoubleDonkWindow)  
[`ConchSpeedBoost`](#MissionAttributes.ConchSpeedBoost)  
[`StealthDmgReduction`](#MissionAttributes.StealthDmgReduction)  
[`FlagCarrierCanFight`](#MissionAttributes.FlagCarrierCanFight)  
[`HHHChaseRange`](#MissionAttributes.HHHChaseRange)  
[`HHHAttackRange`](#MissionAttributes.HHHAttackRange)  
[`HHHQuitRange`](#MissionAttributes.HHHQuitRange)  
[`HHHTerrifyRange`](#MissionAttributes.HHHTerrifyRange)  
[`HHHHealthBase`](#MissionAttributes.HHHHealthBase)  
[`HHHHealthPerPlayer`](#MissionAttributes.HHHHealthPerPlayer)  
[`HalloweenBossNotSolidToPlayers`](#MissionAttributes.HalloweenBossNotSolidToPlayers)  
[`SentryHintBombForwardRange`](#MissionAttributes.SentryHintBombForwardRange)  
[`SentryHintBombBackwardRange`](#MissionAttributes.SentryHintBombBackwardRange)  
[`SentryHintMinDistanceFromBomb`](#MissionAttributes.SentryHintMinDistanceFromBomb)  
[`NoBusterFF`](#MissionAttributes.NoBusterFF)  
[`SniperHideLasers`](#MissionAttributes.SniperHideLasers)  
[`TeamWipeWaveLoss`](#MissionAttributes.TeamWipeWaveLoss)  
[`GiantSentryKillCountOffset`](#MissionAttributes.GiantSentryKillCountOffset)  
[`FlagResetTime`](#MissionAttributes.FlagResetTime)  
[`BotHeadshots`](#MissionAttributes.BotHeadshots)  
[`PlayersAreRobots`](#MissionAttributes.PlayersAreRobots)  
[`BotsAreHumans`](#MissionAttributes.BotsAreHumans)  
[`NoRome`](#MissionAttributes.NoRome)  
[`SpellRateCommon`](#MissionAttributes.SpellRateCommon)  
[`SpellRateGiant`](#MissionAttributes.SpellRateGiant)  
[`RareSpellRateCommon`](#MissionAttributes.RareSpellRateCommon)  
[`RareSpellRateGiant`](#MissionAttributes.RareSpellRateGiant)  
[`NoSkeleSplit`](#MissionAttributes.NoSkeleSplit)  
[`WaveStartCountdown`](#MissionAttributes.WaveStartCountdown)  
[`ExtraTankPath`](#MissionAttributes.ExtraTankPath)  
[`HandModelOverride`](#MissionAttributes.HandModelOverride)  
[`AddCond`](#MissionAttributes.AddCond)  
[`PlayerAttributes`](#MissionAttributes.PlayerAttributes)  
[`ItemAttributes`](#MissionAttributes.ItemAttributes)  
[`LoadoutControl`](#MissionAttributes.LoadoutControl)  
[`SoundOverrides`](#MissionAttributes.SoundOverrides)  
[`NoThrillerTaunt`](#MissionAttributes.NoThrillerTaunt)  
[`EnableRandomCrits`](#MissionAttributes.EnableRandomCrits)  
[`ForceRedMoney`](#MissionAttributes.ForceRedMoney)  
[`ReverseMVM`](#MissionAttributes.ReverseMVM)  
[`ClassLimits`](#MissionAttributes.ClassLimits)  
[`ShowHiddenAttributes`](#MissionAttributes.ShowHiddenAttributes)  
[`HideRespawnText`](#MissionAttributes.HideRespawnText)  
[`ReflectableDF`](#MissionAttributes.ReflectableDF)  
[`RestoreYERNerf`](#MissionAttributes.RestoreYERNerf)  

## [popextensions](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/popextensions.nut) menu

### Methods

back-and-forth links

## [tags](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/tags.nut) menu

back-and-forth links

## [util](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/util.nut) menu

### Methods

[`PopExtUtil.IsLinuxServer`](#PopExtUtil.IsLinuxServer)  
[`PopExtUtil.ShowMessage`](#PopExtUtil.ShowMessage)  
[`PopExtUtil.ForceChangeClass`](#PopExtUtil.ForceChangeClass)  
[`PopExtUtil.PlayerClassCount`](#PopExtUtil.PlayerClassCount)  
[`PopExtUtil.ChangePlayerTeamMvM`](#PopExtUtil.ChangePlayerTeamMvM)  
[`PopExtUtil.ShowChatMessage`](#PopExtUtil.ShowChatMessage)  
[`PopExtUtil.CopyTable`](#PopExtUtil.CopyTable)  
[`PopExtUtil.HexToRgb`](#PopExtUtil.HexToRgb)  
[`PopExtUtil.CountAlivePlayers`](#PopExtUtil.CountAlivePlayers)  
[`PopExtUtil.CountAliveBots`](#PopExtUtil.CountAliveBots)  
[`PopExtUtil.SetParentLocalOriginDo`](#PopExtUtil.SetParentLocalOriginDo)  
[`PopExtUtil.SetParentLocalOrigin`](#PopExtUtil.SetParentLocalOrigin)  
[`PopExtUtil.SetupTriggerBounds`](#PopExtUtil.SetupTriggerBounds)  
[`PopExtUtil.PrintTable`](#PopExtUtil.PrintTable)  
[`PopExtUtil.DoPrintTable`](#PopExtUtil.DoPrintTable)  
[`PopExtUtil.CreatePlayerWearable`](#PopExtUtil.CreatePlayerWearable)  
[`PopExtUtil.StripWeapon`](#PopExtUtil.StripWeapon)  
[`PopExtUtil.SetPlayerAttributes`](#PopExtUtil.SetPlayerAttributes)  
[`PopExtUtil.WeaponSwitchSlot`](#PopExtUtil.WeaponSwitchSlot)  
[`PopExtUtil.Explanation`](#PopExtUtil.Explanation)  
[`PopExtUtil.Info`](#PopExtUtil.Info)  
[`PopExtUtil.IsAlive`](#PopExtUtil.IsAlive)  
[`PopExtUtil.IsDucking`](#PopExtUtil.IsDucking)  
[`PopExtUtil.IsOnGround`](#PopExtUtil.IsOnGround)  
[`PopExtUtil.RemoveAmmo`](#PopExtUtil.RemoveAmmo)  
[`PopExtUtil.GetAllEnts`](#PopExtUtil.GetAllEnts)  
[`PopExtUtil._SetOwner`](#PopExtUtil._SetOwner)  
[`PopExtUtil.ShowAnnotation`](#PopExtUtil.ShowAnnotation)  
[`PopExtUtil.HideAnnotation`](#PopExtUtil.HideAnnotation)  
[`PopExtUtil.GetPlayerName`](#PopExtUtil.GetPlayerName)  
[`PopExtUtil.SetPlayerName`](#PopExtUtil.SetPlayerName)  
[`PopExtUtil.GetPlayerUserID`](#PopExtUtil.GetPlayerUserID)  
[`PopExtUtil.PlayerRespawn`](#PopExtUtil.PlayerRespawn)  
[`PopExtUtil.DisableCloak`](#PopExtUtil.DisableCloak)  
[`PopExtUtil.InUpgradeZone`](#PopExtUtil.InUpgradeZone)  
[`PopExtUtil.InButton`](#PopExtUtil.InButton)  
[`PopExtUtil.PressButton`](#PopExtUtil.PressButton)  
[`PopExtUtil.ReleaseButton`](#PopExtUtil.ReleaseButton)  
[`PopExtUtil.IsPointInRespawnRoom`](#PopExtUtil.IsPointInRespawnRoom)  
[`PopExtUtil.SwitchWeaponSlot`](#PopExtUtil.SwitchWeaponSlot)  
[`PopExtUtil.GetItemInSlot`](#PopExtUtil.GetItemInSlot)  
[`PopExtUtil.SwitchToFirstValidWeapon`](#PopExtUtil.SwitchToFirstValidWeapon)  
[`PopExtUtil.HasEffect`](#PopExtUtil.HasEffect)  
[`PopExtUtil.SetEffect`](#PopExtUtil.SetEffect)  
[`PopExtUtil.PlayerRobotModel`](#PopExtUtil.PlayerRobotModel)  
[`PopExtUtil.HasItemInLoadout`](#PopExtUtil.HasItemInLoadout)  
[`PopExtUtil.StunPlayer`](#PopExtUtil.StunPlayer)  
[`PopExtUtil.Ignite`](#PopExtUtil.Ignite)  
[`PopExtUtil.ShowHudHint`](#PopExtUtil.ShowHudHint)  
[`PopExtUtil.SetEntityColor`](#PopExtUtil.SetEntityColor)  
[`PopExtUtil.GetEntityColor`](#PopExtUtil.GetEntityColor)  
[`PopExtUtil.AddAttributeToLoadout`](#PopExtUtil.AddAttributeToLoadout)  
[`PopExtUtil.ShowModelToPlayer`](#PopExtUtil.ShowModelToPlayer)  
[`PopExtUtil.LockInPlace`](#PopExtUtil.LockInPlace)  
[`PopExtUtil.GetItemIndex`](#PopExtUtil.GetItemIndex)  
[`PopExtUtil.SetItemIndex`](#PopExtUtil.SetItemIndex)  
[`PopExtUtil.SetTargetname`](#PopExtUtil.SetTargetname)  
[`PopExtUtil.GetPlayerSteamID`](#PopExtUtil.GetPlayerSteamID)  
[`PopExtUtil.GetHammerID`](#PopExtUtil.GetHammerID)  
[`PopExtUtil.GetSpawnFlags`](#PopExtUtil.GetSpawnFlags)  
[`PopExtUtil.GetPopfileName`](#PopExtUtil.GetPopfileName)  
[`PopExtUtil.PrecacheParticle`](#PopExtUtil.PrecacheParticle)  
[`PopExtUtil.SpawnEffect`](#PopExtUtil.SpawnEffect)  
[`PopExtUtil.RemoveOutputAll`](#PopExtUtil.RemoveOutputAll)  
[`PopExtUtil.RemovePlayerWearables`](#PopExtUtil.RemovePlayerWearables)  
[`PopExtUtil.GiveWeapon`](#PopExtUtil.GiveWeapon)  
[`PopExtUtil.IsEntityClassnameInList`](#PopExtUtil.IsEntityClassnameInList)  
[`PopExtUtil.SetPlayerClassRespawnAndTeleport`](#PopExtUtil.SetPlayerClassRespawnAndTeleport)  
[`PopExtUtil.PlaySoundOnClient`](#PopExtUtil.PlaySoundOnClient)  
[`PopExtUtil.PlaySoundOnAllClients`](#PopExtUtil.PlaySoundOnAllClients)  
[`PopExtUtil.StopAndPlayMVMSound`](#PopExtUtil.StopAndPlayMVMSound)  
[`PopExtUtil.EndWaveReverse`](#PopExtUtil.EndWaveReverse)  
[`PopExtUtil.AddThinkToEnt`](#PopExtUtil.AddThinkToEnt)  
[`PopExtUtil.SilentDisguise`](#PopExtUtil.SilentDisguise)  
[`PopExtUtil.GetPlayerReadyCount`](#PopExtUtil.GetPlayerReadyCount)  
[`PopExtUtil.GetWeaponMaxAmmo`](#PopExtUtil.GetWeaponMaxAmmo)  
[`PopExtUtil.TeleportNearVictim`](#PopExtUtil.TeleportNearVictim)  
[`PopExtUtil.IsSpaceToSpawnHere`](#PopExtUtil.IsSpaceToSpawnHere)  
[`PopExtUtil.ClearLastKnownArea`](#PopExtUtil.ClearLastKnownArea)  
[`PopExtUtil.KillPlayer`](#PopExtUtil.KillPlayer)  
[`PopExtUtil.KillAllBots`](#PopExtUtil.KillAllBots)  
[`PopExtUtil.SetDestroyCallback`](#PopExtUtil.SetDestroyCallback)  
[`PopExtUtil.OnWeaponFire`](#PopExtUtil.OnWeaponFire)  

### Math methods

[`PopExtUtil.Min`](#PopExtUtil.Min)  
[`PopExtUtil.Max`](#PopExtUtil.Max)  
[`PopExtUtil.Round`](#PopExtUtil.Round)  
[`PopExtUtil.Clamp`](#PopExtUtil.Clamp)  
[`PopExtUtil.RemapVal`](#PopExtUtil.RemapVal)  
[`PopExtUtil.RemapValClamped`](#PopExtUtil.RemapValClamped)  
[`PopExtUtil.IntersectionPointBox`](#PopExtUtil.IntersectionPointBox)  
[`PopExtUtil.NormalizeAngle`](#PopExtUtil.NormalizeAngle)  
[`PopExtUtil.ApproachAngle`](#PopExtUtil.ApproachAngle)  
[`PopExtUtil.VectorAngles`](#PopExtUtil.VectorAngles)  
[`PopExtUtil.AnglesToVector`](#PopExtUtil.AnglesToVector)  
[`PopExtUtil.QAngleDistance`](#PopExtUtil.QAngleDistance)  
[`PopExtUtil.CheckBitwise`](#PopExtUtil.CheckBitwise)  
[`PopExtUtil.StringReplace`](#PopExtUtil.StringReplace)  
[`PopExtUtil.capwords`](#PopExtUtil.capwords)  

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

> [!WARNING]
> This attribute doesn't seem to work currently

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

Add/modify item attributes, can be filtered by item index or classname

---

<a name="MissionAttributes.LoadoutControl"></a>

> [!WARNING]
> This attribute is still WIP

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

Hardcoded to only be able to replace specific sounds, because spamming stopsound in a think function is very laggy. See [replace weapon fire sound](#CustomAttributes.ReplaceWeaponFireSound) and more in `customattributes.nut` for weapon sounds. See the tank sound overrides in `hooks.nut` for disabling tank explosions.

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
ReverseMVM = 1
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
> This attribute is very much under heavy development right now. Use this with great caution.

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
// usage
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

<a name="MissionAttributes.ReflectableDF"></a>

```js
// usage
ReflectableDF = 1
```

Reverts the Dragon's Fury global fix in `globalfixes.nut`. [Visit](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/globalfixes.nut) for more info

---

<a name="MissionAttributes.RestoreYERNerf"></a>

```js
// usage
RestoreYERNerf = 1
```

Reverts the Your Eternal Reward global fix in `globalfixes.nut`. [Visit](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/globalfixes.nut) for more info

---

## [util](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/util.nut) references

<a name="PopExtUtil.IsLinuxServer"></a>

```cpp
bool PopExtUtil::IsLinuxServer()
```

Is the current server on linux?

---

<a name="PopExtUtil.ShowMessage"></a>

```cpp
void PopExtUtil::ShowMessage(string message)
```

ClientPrints everyone a message to the centre of the screen

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
table PopExtUtil::GetAllEnts()
```

Returns a table of two kv pairs. First pair is "entlist", which contains an array of all the ents. Second pair is "numents", which is the number of total ents.

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

Sends the `show_annotation` game event with the specified arguments

---

<a name="PopExtUtil.HideAnnotation"></a>

```cpp
void PopExtUtil::HideAnnotation(int id)
```

Hides the annotation with a given id

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
