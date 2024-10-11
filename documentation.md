# PopExtensionsPlus Documentation

*Documentation last updated [date]*

A work-in-progress documentation for [PopExt](https://github.com/potato-tf/PopExtensionsPlus). Pull requests on areas that are still being worked on are most welcomed.

As updates to PopExt are made consistently, this documentation will inevitably fall slightly behind. Please also feel free to make pull requests to fill in new missing parts.

## Table of Contents

> [!NOTE]
> A section that does not have a link means that it does not exist in the documentation yet.

└─ [README and the example pop](#readme-and-the-example-pop)  
└─ **Menus and references**  
⠀⠀⠀└─ popextensions_main  
⠀⠀⠀└─ botbehaviour  
⠀⠀⠀└─ [customattributes](#customattributes)  
⠀⠀⠀└─ customweapons  
⠀⠀⠀└─ ent_additions  
⠀⠀⠀└─ globalfixes  
⠀⠀⠀└─ hooks  
⠀⠀⠀└─ [missionattributes](#missionattributes)  
⠀⠀⠀└─ [popextensions](#popextensions)  
⠀⠀⠀└─ populator  
⠀⠀⠀└─ spawntemplate  
⠀⠀⠀└─ [tags](#tags)  
⠀⠀⠀└─ tutorialtools  
⠀⠀⠀└─ [util](#util)  
⠀⠀⠀└─ [**Constants defined by PopExt**](#constants-defined-by-popext)  
⠀⠀⠀⠀⠀⠀└─ [attribute_map](#attribute_map)  
⠀⠀⠀⠀⠀⠀└─ [constants](#constants)  
⠀⠀⠀⠀⠀⠀└─ [item_map](#item_map)  
⠀⠀⠀⠀⠀⠀└─ [itemdef_constants](#itemdef_constants)  
⠀⠀⠀⠀⠀⠀└─ robotvoicelines

## README and the example pop

The [README](https://github.com/potato-tf/PopExtensionsPlus/blob/main/README.md) contains instruction to installation and usage, as well as a brief idea of what most of the sub-files do.

> [!CAUTION]
> The README has not been maintained in a while and carries possibly outdated information.

The [example pop](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/population/mvm_bigrock_vscript.pop) demonstrates how most of the keyvalues work in a practical setting.

## [customattributes](https://github.com/potato-tf/PopExtensionsPlus/blob/main/scripts/vscripts/popextensions/customattributes.nut) menu

### Attributes

[`fires milk bolt`](#CustomAttributes.FiresMilkBolt)  
[`mod teleporter speed boost`](#CustomAttributes.ModTeleporterSpeedBoost)

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
