local FromItemsGame = {
	[1] = {

		"name" : "damage penalty"
		"attribute_class" : "mult_dmg"
		"description_string" : "#Attrib_DamageDone_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[2] = {

		"name" : "damage bonus"
		"attribute_class" : "mult_dmg"
		"description_string" : "#Attrib_DamageDone_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[3] = {

		"name" : "clip size penalty"
		"attribute_class" : "mult_clipsize"
		"description_string" : "#Attrib_ClipSize_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[4] = {

		"name" : "clip size bonus"
		"attribute_class" : "mult_clipsize"
		"description_string" : "#Attrib_ClipSize_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[5] = {

		"name" : "fire rate penalty"
		"attribute_class" : "mult_postfiredelay"
		"description_string" : "#Attrib_FireRate_Negative"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[6] = {

		"name" : "fire rate bonus"
		"attribute_class" : "mult_postfiredelay"
		"description_string" : "#Attrib_FireRate_Positive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[7] = {

		"name" : "heal rate penalty"
		"attribute_class" : "mult_medigun_healrate"
		"description_string" : "#Attrib_HealRate_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[8] = {

		"name" : "heal rate bonus"
		"attribute_class" : "mult_medigun_healrate"
		"description_string" : "#Attrib_HealRate_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[9] = {

		"name" : "ubercharge rate penalty"
		"attribute_class" : "mult_medigun_uberchargerate"
		"description_string" : "#Attrib_UberchargeRate_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[10] = {

		"name" : "ubercharge rate bonus"
		"attribute_class" : "mult_medigun_uberchargerate"
		"description_string" : "#Attrib_UberchargeRate_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[11] = {

		"name" : "overheal bonus"
		"attribute_class" : "mult_medigun_overheal_amount"
		"description_string" : "#Attrib_OverhealAmount_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[12] = {

		"name" : "overheal decay penalty"
		"attribute_class" : "mult_medigun_overheal_decay"
		"description_string" : "#Attrib_OverhealDecay_Negative"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[13] = {

		"name" : "overheal decay bonus"
		"attribute_class" : "mult_medigun_overheal_decay"
		"description_string" : "#Attrib_OverhealDecay_Positive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[14] = {

		"name" : "overheal decay disabled"
		"attribute_class" : "mult_medigun_overheal_decay"
		"description_string" : "#Attrib_OverhealDecay_Disabled"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[15] = {

		"name" : "crit mod disabled"
		"attribute_class" : "mult_crit_chance"
		"description_string" : "#Attrib_CritChance_Disabled"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "no_crits"
		"stored_as_integer" : "0"
	},
	[16] = {

		"name" : "heal on hit for rapidfire"
		"attribute_class" : "add_onhit_addhealth"
		"description_string" : "#Attrib_HealOnHit_Positive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[17] = {

		"name" : "add uber charge on hit"
		"attribute_class" : "add_onhit_ubercharge"
		"description_string" : "#Attrib_AddUber_OnHit_Positive"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[18] = {

		"name" : "medigun charge is crit boost"
		"attribute_class" : "set_charge_type"
		"description_string" : "#Attrib_Medigun_CritBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[19] = {

		"name" : "tmp dmgbuff on hit"
		"attribute_class" : "addperc_ondmgdone_tmpbuff"
		"description_string" : "#Attrib_DamageDoneBonus_Positive"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[20] = {

		"name" : "crit vs burning players"
		"attribute_class" : "or_crit_vs_playercond"
		"description_string" : "#Attrib_CritVsBurning"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[21] = {

		"name" : "dmg penalty vs nonburning"
		"attribute_class" : "mult_dmg_vs_nonburning"
		"description_string" : "#Attrib_DmgPenaltyVsNonBurning"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[22] = {

		"name" : "no crit vs nonburning"
		"attribute_class" : "set_nocrit_vs_nonburning"
		"description_string" : "#Attrib_NoCritVsNonBurning"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[23] = {

		"name" : "mod flamethrower push"
		"attribute_class" : "set_flamethrower_push_disabled"
		"description_string" : "#Attrib_ModFlamethrowerPush"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[24] = {

		"name" : "mod flamethrower back crit"
		"attribute_class" : "set_flamethrower_back_crit"
		"description_string" : "#Attrib_ModFlamethrower_BackCrits"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[25] = {

		"name" : "hidden secondary max ammo penalty"
		"attribute_class" : "mult_maxammo_secondary"
		"description_string" : "unused"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[26] = {

		"name" : "max health additive bonus"
		"attribute_class" : "add_maxhealth"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[27] = {

		"name" : "alt-fire disabled"
		"attribute_class" : "unimplemented_altfire_disabled"
		"description_string" : "#Attrib_AltFire_Disabled"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[28] = {

		"name" : "crit mod disabled hidden"
		"attribute_class" : "mult_crit_chance"
		"description_string" : "#Attrib_CritChance_Disabled"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[30] = {

		"name" : "fists have radial buff"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_FistsHaveRadialBuff"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[31] = {

		"name" : "critboost on kill"
		"attribute_class" : "add_onkill_critboost_time"
		"description_string" : "#Attrib_CritBoost_OnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_kill"
		"stored_as_integer" : "0"
	},
	[32] = {

		"name" : "slow enemy on hit"
		"attribute_class" : "mult_onhit_enemyspeed"
		"description_string" : "#Attrib_Slow_Enemy_OnHit"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[33] = {

		"name" : "set cloak is feign death"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_CloakIsFeignDeath"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"armory_desc" : "cloak_type"
		"stored_as_integer" : "0"
	},
	[34] = {

		"name" : "mult cloak meter consume rate"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"description_string" : "#Attrib_CloakMeterConsumeRate"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[35] = {

		"name" : "mult cloak meter regen rate"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"description_string" : "#Attrib_CloakMeterRegenRate"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[36] = {

		"name" : "spread penalty"
		"attribute_class" : "mult_spread_scale"
		"description_string" : "#Attrib_Spread_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[37] = {

		"name" : "hidden primary max ammo bonus"
		"attribute_class" : "mult_maxammo_primary"
		"description_string" : "unused"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[38] = {

		"name" : "mod bat launches balls"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_BatLaunchesBalls"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[39] = {

		"name" : "dmg penalty vs nonstunned"
		"attribute_class" : "unimplemented_mod_dmg_vs_nonstunned"
		"description_string" : "#Attrib_DmgPenaltyVsNonStunned"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[40] = {

		"name" : "zoom speed mod disabled"
		"attribute_class" : "unimplemented_mod_zoom_speed_disabled"
		"description_string" : "#Attrib_ZoomSpeedMod_Disabled"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[41] = {

		"name" : "sniper charge per sec"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"description_string" : "#Attrib_SniperCharge_Per_Sec"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[42] = {

		"name" : "sniper no headshots"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_SniperNoHeadshots"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[43] = {

		"name" : "scattergun no reload single"
		"attribute_class" : "set_scattergun_no_reload_single"
		"description_string" : "#Attrib_Scattergun_NoReloadSingle"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[44] = {

		"name" : "scattergun has knockback"
		"attribute_class" : "set_scattergun_has_knockback"
		"description_string" : "#Attrib_Scattergun_HasKnockback"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[45] = {

		"name" : "bullets per shot bonus"
		"attribute_class" : "mult_bullets_per_shot"
		"description_string" : "#Attrib_BulletsPerShot_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[46] = {

		"name" : "sniper zoom penalty"
		"attribute_class" : "mult_zoom_fov"
		"description_string" : "#Attrib_SniperZoom_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[47] = {

		"name" : "sniper no charge"
		"attribute_class" : "unimplemented_mod_sniper_no_charge"
		"description_string" : "#Attrib_SniperNoCharge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[48] = {

		"name" : "set cloak is movement based"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_CloakIsMovementBased"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"armory_desc" : "cloak_type"
		"stored_as_integer" : "0"
	},
	[49] = {

		"name" : "no double jump"
		"attribute_class" : "set_scout_doublejump_disabled"
		"description_string" : "#Attrib_NoDoubleJump"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[50] = {

		"name" : "absorb damage while cloaked"
		"attribute_class" : "unimplemented_absorb_dmg_while_cloaked"
		"description_string" : "#Attrib_AbsorbDmgWhileCloaked"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[51] = {

		"name" : "revolver use hit locations"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_RevolverUseHitLocations"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[52] = {

		"name" : "backstab shield"
		"attribute_class" : "set_blockbackstab_once"
		"description_string" : "#Attrib_BackstabShield"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[53] = {

		"name" : "fire retardant"
		"attribute_class" : "set_fire_retardant"
		"description_string" : "#Attrib_FireRetardant"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[54] = {

		"name" : "move speed penalty"
		"attribute_class" : "mult_player_movespeed"
		"description_string" : "#Attrib_MoveSpeed_Penalty"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[55] = {

		"name" : "obsolete ammo penalty"
		"attribute_class" : "obsolete"
		"description_string" : "unused"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[56] = {

		"name" : "jarate description"
		"attribute_class" : "desc_jarate_description"
		"description_string" : "#Attrib_Jarate_Description"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[57] = {

		"name" : "health regen"
		"attribute_class" : "add_health_regen"
		"description_string" : "#Attrib_HealthRegen"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[58] = {

		"name" : "self dmg push force increased"
		"attribute_class" : "mult_dmgself_push_force"
		"description_string" : "#Attrib_SelfDmgPush_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[59] = {

		"name" : "self dmg push force decreased"
		"attribute_class" : "mult_dmgself_push_force"
		"description_string" : "#Attrib_SelfDmgPush_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[60] = {

		"name" : "dmg taken from fire reduced"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[61] = {

		"name" : "dmg taken from fire increased"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[62] = {

		"name" : "dmg taken from crit reduced"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[63] = {

		"name" : "dmg taken from crit increased"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[64] = {

		"name" : "dmg taken from blast reduced"
		"attribute_class" : "mult_dmgtaken_from_explosions"
		"description_string" : "#Attrib_DmgTaken_From_Blast_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[65] = {

		"name" : "dmg taken from blast increased"
		"attribute_class" : "mult_dmgtaken_from_explosions"
		"description_string" : "#Attrib_DmgTaken_From_Blast_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[66] = {

		"name" : "dmg taken from bullets reduced"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[67] = {

		"name" : "dmg taken from bullets increased"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[68] = {

		"name" : "increase player capture value"
		"attribute_class" : "add_player_capturevalue"
		"description_string" : "#Attrib_CaptureValue_Increased"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[69] = {

		"name" : "health from healers reduced"
		"attribute_class" : "mult_health_fromhealers"
		"description_string" : "#Attrib_HealthFromHealers_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[70] = {

		"name" : "health from healers increased"
		"attribute_class" : "mult_health_fromhealers"
		"description_string" : "#Attrib_HealthFromHealers_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[71] = {

		"name" : "weapon burn dmg increased"
		"attribute_class" : "mult_wpn_burndmg"
		"description_string" : "#Attrib_WpnBurnDmg_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[72] = {

		"name" : "weapon burn dmg reduced"
		"attribute_class" : "mult_wpn_burndmg"
		"description_string" : "#Attrib_WpnBurnDmg_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[73] = {

		"name" : "weapon burn time increased"
		"attribute_class" : "mult_wpn_burntime"
		"description_string" : "#Attrib_WpnBurnTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[74] = {

		"name" : "weapon burn time reduced"
		"attribute_class" : "mult_wpn_burntime"
		"description_string" : "#Attrib_WpnBurnTime_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[75] = {

		"name" : "aiming movespeed increased"
		"attribute_class" : "mult_player_aiming_movespeed"
		"description_string" : "#Attrib_AimingMoveSpeed_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[76] = {

		"name" : "maxammo primary increased"
		"attribute_class" : "mult_maxammo_primary"
		"description_string" : "#Attrib_MaxammoPrimary_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[77] = {

		"name" : "maxammo primary reduced"
		"attribute_class" : "mult_maxammo_primary"
		"description_string" : "#Attrib_MaxammoPrimary_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[78] = {

		"name" : "maxammo secondary increased"
		"attribute_class" : "mult_maxammo_secondary"
		"description_string" : "#Attrib_MaxammoSecondary_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[79] = {

		"name" : "maxammo secondary reduced"
		"attribute_class" : "mult_maxammo_secondary"
		"description_string" : "#Attrib_MaxammoSecondary_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[80] = {

		"name" : "maxammo metal increased"
		"attribute_class" : "mult_maxammo_metal"
		"description_string" : "#Attrib_MaxammoMetal_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[81] = {

		"name" : "maxammo metal reduced"
		"attribute_class" : "mult_maxammo_metal"
		"description_string" : "#Attrib_MaxammoMetal_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[82] = {

		"name" : "cloak consume rate increased"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"description_string" : "#Attrib_CloakConsumeRate_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[83] = {

		"name" : "cloak consume rate decreased"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"description_string" : "#Attrib_CloakConsumeRate_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[84] = {

		"name" : "cloak regen rate increased"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"description_string" : "#Attrib_CloakRegenRate_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[85] = {

		"name" : "cloak regen rate decreased"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"description_string" : "#Attrib_CloakRegenRate_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[86] = {

		"name" : "minigun spinup time increased"
		"attribute_class" : "mult_minigun_spinup_time"
		"description_string" : "#Attrib_MinigunSpinup_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[87] = {

		"name" : "minigun spinup time decreased"
		"attribute_class" : "mult_minigun_spinup_time"
		"description_string" : "#Attrib_MinigunSpinup_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[88] = {

		"name" : "max pipebombs increased"
		"attribute_class" : "add_max_pipebombs"
		"description_string" : "#Attrib_MaxPipebombs_Increased"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[89] = {

		"name" : "max pipebombs decreased"
		"attribute_class" : "add_max_pipebombs"
		"description_string" : "#Attrib_MaxPipebombs_Decreased"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[90] = {

		"name" : "SRifle Charge rate increased"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"description_string" : "#Attrib_SRifleChargeRate_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[91] = {

		"name" : "SRifle Charge rate decreased"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"description_string" : "#Attrib_SRifleChargeRate_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[92] = {

		"name" : "Construction rate increased"
		"attribute_class" : "mult_construction_value"
		"description_string" : "#Attrib_ConstructionRate_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[93] = {

		"name" : "Construction rate decreased"
		"attribute_class" : "mult_construction_value"
		"description_string" : "#Attrib_ConstructionRate_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[94] = {

		"name" : "Repair rate increased"
		"attribute_class" : "mult_repair_value"
		"description_string" : "#Attrib_RepairRate_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[95] = {

		"name" : "Repair rate decreased"
		"attribute_class" : "mult_repair_value"
		"description_string" : "#Attrib_RepairRate_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[96] = {

		"name" : "Reload time increased"
		"attribute_class" : "mult_reload_time"
		"description_string" : "#Attrib_ReloadTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[97] = {

		"name" : "Reload time decreased"
		"attribute_class" : "mult_reload_time"
		"description_string" : "#Attrib_ReloadTime_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[98] = {

		"name" : "selfdmg on hit for rapidfire"
		"attribute_class" : "add_onhit_addhealth"
		"description_string" : "#Attrib_HealOnHit_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[99] = {

		"name" : "Blast radius increased"
		"attribute_class" : "mult_explosion_radius"
		"description_string" : "#Attrib_BlastRadius_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[100] = {

		"name" : "Blast radius decreased"
		"attribute_class" : "mult_explosion_radius"
		"description_string" : "#Attrib_BlastRadius_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[101] = {

		"name" : "Projectile range increased"
		"attribute_class" : "mult_projectile_range"
		"description_string" : "#Attrib_ProjectileRange_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[102] = {

		"name" : "Projectile range decreased"
		"attribute_class" : "mult_projectile_range"
		"description_string" : "#Attrib_ProjectileRange_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[103] = {

		"name" : "Projectile speed increased"
		"attribute_class" : "mult_projectile_speed"
		"description_string" : "#Attrib_ProjectileSpeed_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[104] = {

		"name" : "Projectile speed decreased"
		"attribute_class" : "mult_projectile_speed"
		"description_string" : "#Attrib_ProjectileSpeed_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[105] = {

		"name" : "overheal penalty"
		"attribute_class" : "mult_medigun_overheal_amount"
		"description_string" : "#Attrib_OverhealAmount_Negative"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[106] = {

		"name" : "weapon spread bonus"
		"attribute_class" : "mult_spread_scale"
		"description_string" : "#Attrib_Spread_Positive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[107] = {

		"name" : "move speed bonus"
		"attribute_class" : "mult_player_movespeed"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[108] = {

		"name" : "health from packs increased"
		"attribute_class" : "mult_health_frompacks"
		"description_string" : "#Attrib_HealthFromPacks_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[109] = {

		"name" : "health from packs decreased"
		"attribute_class" : "mult_health_frompacks"
		"description_string" : "#Attrib_HealthFromPacks_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[110] = {

		"name" : "heal on hit for slowfire"
		"attribute_class" : "add_onhit_addhealth"
		"description_string" : "#Attrib_HealOnHit_Positive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[111] = {

		"name" : "selfdmg on hit for slowfire"
		"attribute_class" : "add_onhit_addhealth"
		"description_string" : "#Attrib_HealOnHit_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[112] = {

		"name" : "ammo regen"
		"attribute_class" : "addperc_ammo_regen"
		"description_string" : "#Attrib_AmmoRegen"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[113] = {

		"name" : "metal regen"
		"attribute_class" : "add_metal_regen"
		"description_string" : "#Attrib_MetalRegen"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[114] = {

		"name" : "mod mini-crit airborne"
		"attribute_class" : "mini_crit_airborne"
		"description_string" : "#Attrib_MiniCritAirborneEnemies"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[115] = {

		"name" : "mod shovel damage boost"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_ShovelDamageBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[116] = {

		"name" : "mod soldier buff type"
		"attribute_class" : "set_buff_type"
		"description_string" : "#Attrib_SoldierBuffType"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[117] = {

		"name" : "dmg falloff increased"
		"attribute_class" : "mult_dmg_falloff"
		"description_string" : "#Attrib_Dmg_Falloff_Increased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[118] = {

		"name" : "dmg falloff decreased"
		"attribute_class" : "mult_dmg_falloff"
		"description_string" : "#Attrib_Dmg_Falloff_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[119] = {

		"name" : "sticky detonate mode"
		"attribute_class" : "set_detonate_mode"
		"description_string" : "#Attrib_StickyDetonateMode"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[120] = {

		"name" : "sticky arm time penalty"
		"attribute_class" : "sticky_arm_time"
		"description_string" : "#Attrib_StickyArmTimePenalty"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[121] = {

		"name" : "stickies detonate stickies"
		"attribute_class" : "stickies_detonate_stickies"
		"description_string" : "#Attrib_StickiesDetonateStickies"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[122] = {

		"name" : "mod demo buff type"
		"attribute_class" : "set_buff_type"
		"description_string" : "#Attrib_DemoBuffType"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[123] = {

		"name" : "speed boost when active"
		"attribute_class" : "mult_move_speed_when_active"
		"description_string" : "#Attrib_SpeedBoostWhenActive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[124] = {

		"name" : "mod wrench builds minisentry"
		"attribute_class" : "wrench_builds_minisentry"
		"description_string" : "#Attrib_WrenchBuildsMiniSentry"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[125] = {

		"name" : "max health additive penalty"
		"attribute_class" : "add_maxhealth"
		"description_string" : "#Attrib_MaxHealth_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[126] = {

		"name" : "sticky arm time bonus"
		"attribute_class" : "sticky_arm_time"
		"description_string" : "#Attrib_StickyArmTimeBonus"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[127] = {

		"name" : "sticky air burst mode"
		"attribute_class" : "set_detonate_mode"
		"description_string" : "#Attrib_StickyAirBurstMode"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[128] = {

		"name" : "provide on active"
		"attribute_class" : "provide_on_active"
		"description_string" : "#Attrib_ProvideOnActive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[129] = {

		"name" : "health drain"
		"attribute_class" : "add_health_regen"
		"description_string" : "#Attrib_HealthDrain"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[130] = {

		"name" : "medic regen bonus"
		"attribute_class" : "medic_regen"
		"description_string" : "#Attrib_MedicRegenBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[131] = {

		"name" : "medic regen penalty"
		"attribute_class" : "medic_regen"
		"description_string" : "#Attrib_MedicRegenPenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[132] = {

		"name" : "community description"
		"attribute_class" : "desc_community_description"
		"description_string" : "#Attrib_Community_Description"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[133] = {

		"name" : "soldier model index"
		"attribute_class" : "desc_soldiermedal_index"
		"description_string" : "#Attrib_MedalIndex_Description"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[134] = {

		"name" : "attach particle effect"
		"attribute_class" : "set_attached_particle"
		"description_string" : "#Attrib_AttachedParticle"
		"description_format" : "value_is_particle_index"
		"hidden" : "0"
		"effect_type" : "unusual"
		"stored_as_integer" : "0"
		"can_affect_market_name" : "1"
	},
	[135] = {

		"name" : "rocket jump damage reduction"
		"attribute_class" : "rocket_jump_dmg_reduction"
		"description_string" : "#Attrib_RocketJumpDmgReduction"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[136] = {

		"name" : "mod sentry killed revenge"
		"attribute_class" : "sentry_killed_revenge"
		"description_string" : "#Attrib_SentryKilledRevenge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[137] = {

		"name" : "dmg bonus vs buildings"
		"attribute_class" : "mult_dmg_vs_buildings"
		"description_string" : "#Attrib_DmgVsBuilding_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[138] = {

		"name" : "dmg penalty vs players"
		"attribute_class" : "mult_dmg_vs_players"
		"description_string" : "#Attrib_DmgVsPlayer_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[139] = {

		"name" : "lunchbox adds maxhealth bonus"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_LunchboxAddsMaxHealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[140] = {

		"name" : "hidden maxhealth non buffed"
		"attribute_class" : "add_maxhealth_nonbuffed"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[141] = {

		"name" : "selfmade description"
		"attribute_class" : "desc_selfmade_description"
		"description_string" : "#Attrib_Selfmade_Description"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[142] = {

		"name" : "set item tint RGB"
		"attribute_class" : "set_item_tint_rgb"
		"description_string" : "#Attrib_SetItemTintRGB"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[143] = {

		"name" : "custom employee number"
		"attribute_class" : "set_employee_number"
		"description_string" : "#Attrib_EmployeeNumber"
		"description_format" : "value_is_date"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[144] = {

		"name" : "lunchbox adds minicrits"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_LunchboxAddsMinicrits"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[145] = {

		"name" : "taunt is highfive"
		"attribute_class" : "enable_misc2_highfive"
		"description_string" : "#Attrib_DamageDone_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[146] = {

		"name" : "damage applies to sappers"
		"attribute_class" : "set_dmg_apply_to_sapper"
		"description_string" : "#Attrib_DmgAppliesToSappers"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[147] = {

		"name" : "Wrench index"
		"attribute_class" : "desc_wrench_index"
		"description_string" : "#Attrib_WrenchNumber"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[148] = {

		"name" : "building cost reduction"
		"attribute_class" : "building_cost_reduction"
		"description_string" : "#Attrib_BuildingCostReduction"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[149] = {

		"name" : "bleeding duration"
		"attribute_class" : "bleeding_duration"
		"description_string" : "#Attrib_BleedingDuration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit bleed"
		"stored_as_integer" : "0"
	},
	[150] = {

		"name" : "turn to gold"
		"attribute_class" : "set_turn_to_gold"
		"description_string" : "#Attrib_TurnToGold"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[151] = {

		"name" : "DEPRECATED socketed item definition id DEPRECATED "
		"attribute_class" : "socketed_item_definition_id"
		"description_string" : "#Attrib_Socket"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[152] = {

		"name" : "custom texture lo"
		"attribute_class" : "custom_texture_lo"
		"description_string" : "#Attrib_CustomTexture"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[153] = {

		"name" : "cannot trade"
		"attribute_class" : "cannot_trade"
		"description_string" : "#Attrib_CannotTrade"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[154] = {

		"name" : "disguise on backstab"
		"attribute_class" : "set_disguise_on_backstab"
		"description_string" : "#Attrib_DisguiseOnBackstab"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[155] = {

		"name" : "cannot disguise"
		"attribute_class" : "set_cannot_disguise"
		"description_string" : "#Attrib_CannotDisguise"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[156] = {

		"name" : "silent killer"
		"attribute_class" : "set_silent_killer"
		"description_string" : "#Attrib_SilentKiller"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[157] = {

		"name" : "disguise speed penalty"
		"attribute_class" : "disguise_speed_penalty"
		"description_string" : "#Attrib_DisguiseSpeedPenalty"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[158] = {

		"name" : "add cloak on kill"
		"attribute_class" : "add_cloak_on_kill"
		"description_string" : "#Attrib_AddCloakOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[159] = {

		"name" : "SET BONUS: cloak blink time penalty"
		"attribute_class" : "cloak_blink_time_penalty"
		"description_string" : "#Attrib_CloakBlinkTimePenalty"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[160] = {

		"name" : "SET BONUS: quiet unstealth"
		"attribute_class" : "set_quiet_unstealth"
		"description_string" : "#Attrib_QuietUnstealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[161] = {

		"name" : "flame size penalty"
		"attribute_class" : "mult_flame_size"
		"description_string" : "#Attrib_FlameSize_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[162] = {

		"name" : "flame size bonus"
		"attribute_class" : "mult_flame_size"
		"description_string" : "#Attrib_FlameSize_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[163] = {

		"name" : "flame life penalty"
		"attribute_class" : "mult_flame_life"
		"description_string" : "#Attrib_FlameLife_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[164] = {

		"name" : "flame life bonus"
		"attribute_class" : "mult_flame_life"
		"description_string" : "#Attrib_FlameLife_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[165] = {

		"name" : "charged airblast"
		"attribute_class" : "set_charged_airblast"
		"description_string" : "#Attrib_ChargedAirblast"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[166] = {

		"name" : "add cloak on hit"
		"attribute_class" : "add_cloak_on_hit"
		"description_string" : "#Attrib_AddCloakOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[167] = {

		"name" : "disguise damage reduction"
		"attribute_class" : "disguise_damage_reduction"
		"description_string" : "#Attrib_DisguiseDamageReduction"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[168] = {

		"name" : "disguise no burn"
		"attribute_class" : "disguise_no_burn"
		"description_string" : "#Attrib_DisguiseNoBurn"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[169] = {

		"name" : "SET BONUS: dmg from sentry reduced"
		"attribute_class" : "dmg_from_sentry_reduced"
		"description_string" : "#Attrib_DmgFromSentryReduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[170] = {

		"name" : "airblast cost increased"
		"attribute_class" : "mult_airblast_cost"
		"description_string" : "#Attrib_AirblastCost_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[171] = {

		"name" : "airblast cost decreased"
		"attribute_class" : "mult_airblast_cost"
		"description_string" : "#Attrib_AirblastCost_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[172] = {

		"name" : "purchased"
		"attribute_class" : "purchased"
		"description_string" : "#Attrib_Purchased"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[173] = {

		"name" : "flame ammopersec increased"
		"attribute_class" : "mult_flame_ammopersec"
		"description_string" : "#Attrib_FlameAmmoPerSec_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[174] = {

		"name" : "flame ammopersec decreased"
		"attribute_class" : "mult_flame_ammopersec"
		"description_string" : "#Attrib_FlameAmmoPerSec_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[175] = {

		"name" : "jarate duration"
		"attribute_class" : "jarate_duration"
		"description_string" : "#Attrib_JarateDuration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit jarate"
		"stored_as_integer" : "0"
	},
	[176] = {

		"name" : "SET BONUS: no death from headshots"
		"attribute_class" : "no_death_from_headshots"
		"description_string" : "#Attrib_NoDeathFromHeadshots"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[177] = {

		"name" : "deploy time increased"
		"attribute_class" : "mult_deploy_time"
		"description_string" : "#Attrib_DeployTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[178] = {

		"name" : "deploy time decreased"
		"attribute_class" : "mult_deploy_time"
		"description_string" : "#Attrib_DeployTime_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[179] = {

		"name" : "minicrits become crits"
		"attribute_class" : "minicrits_become_crits"
		"description_string" : "#Attrib_MinicritsBecomeCrits"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[180] = {

		"name" : "heal on kill"
		"attribute_class" : "heal_on_kill"
		"description_string" : "#Attrib_HealOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[181] = {

		"name" : "no self blast dmg"
		"attribute_class" : "no_self_blast_dmg"
		"description_string" : "#Attrib_NoSelfBlastDmg"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[182] = {

		"name" : "slow enemy on hit major"
		"attribute_class" : "mult_onhit_enemyspeed_major"
		"description_string" : "#Attrib_Slow_Enemy_OnHit_Major"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[183] = {

		"name" : "aiming movespeed decreased"
		"attribute_class" : "mult_player_aiming_movespeed"
		"description_string" : "#Attrib_AimingMoveSpeed_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[184] = {

		"name" : "duel loser account id"
		"attribute_class" : "duel_loser_account_id"
		"description_string" : "#Attrib_DuelLoserAccountID"
		"description_format" : "value_is_account_id"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[185] = {

		"name" : "event date"
		"attribute_class" : "event_date"
		"description_string" : "#Attrib_EventDate"
		"description_format" : "value_is_date"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[186] = {

		"name" : "gifter account id"
		"attribute_class" : "gifter_account_id"
		"description_string" : "#Attrib_GifterAccountID"
		"description_format" : "value_is_account_id"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[187] = {

		"name" : "set supply crate series"
		"attribute_class" : "supply_crate_series"
		"description_string" : "#Attrib_SupplyCrateSeries"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"can_affect_market_name" : "1"
	},
	[188] = {

		"name" : "preserve ubercharge"
		"attribute_class" : "preserve_ubercharge"
		"description_string" : "#Attrib_PreserveUbercharge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[189] = {

		"name" : "elevate quality"
		"attribute_class" : "set_elevated_quality"
		"description_string" : "#Attrib_ElevateQuality"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[190] = {

		"name" : "active health regen"
		"attribute_class" : "active_item_health_regen"
		"description_string" : "#Attrib_HealthRegen"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[191] = {

		"name" : "active health degen"
		"attribute_class" : "active_item_health_regen"
		"description_string" : "#Attrib_HealthDrain"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[192] = {

		"name" : "referenced item id low"
		"attribute_class" : "referenced_item_id_low"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
	},
	[193] = {

		"name" : "referenced item id high"
		"attribute_class" : "referenced_item_id_high"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
	},
	[194] = {

		"name" : "referenced item def UPDATED"
		"attribute_class" : "referenced_item_def"
		"description_string" : "#Attrib_ReferencedItem"
		"description_format" : "value_is_item_def"
		"hidden" : "1"
		"effect_type" : "neutral"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
	},
	[195] = {

		"name" : "always tradable"
		"attribute_class" : "always_tradable"
		"description_string" : "#Attrib_Always_Tradable"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[196] = {

		"name" : "noise maker"
		"attribute_class" : "enable_misc2_noisemaker"
		"description_string" : "#Attrib_NoiseMaker"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[197] = {

		"name" : "halloween item"
		"attribute_class" : "halloween_item"
		"description_string" : "#Attrib_Halloween_Item"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[198] = {

		"name" : "collection bits DEPRECATED"
		"attribute_class" : "collection_bits_DEPRECATED"
		"description_string" : "#Attrib_Halloween_Item"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[199] = {

		"name" : "switch from wep deploy time decreased"
		"attribute_class" : "mult_switch_from_wep_deploy_time"
		"description_string" : "#Attrib_SingleWepHolsterBonus"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[200] = {

		"name" : "enables aoe heal"
		"attribute_class" : "enables_aoe_heal"
		"description_string" : "#Attrib_EnablesAOEHeal"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[201] = {

		"name" : "gesture speed increase"
		"attribute_class" : "mult_gesture_time"
		"description_string" : "#Attrib_GestureSpeed_Increase"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[202] = {

		"name" : "charge time increased"
		"attribute_class" : "mod_charge_time"
		"description_string" : "#Attrib_ChargeTime_Increase"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[203] = {

		"name" : "drop health pack on kill"
		"attribute_class" : "drop_health_pack_on_kill"
		"description_string" : "#Attrib_DropHealthPackOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[204] = {

		"name" : "hit self on miss"
		"attribute_class" : "hit_self_on_miss"
		"description_string" : "#Attrib_HitSelfOnMiss"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[205] = {

		"name" : "dmg from ranged reduced"
		"attribute_class" : "dmg_from_ranged"
		"description_string" : "#Attrib_DmgFromRanged_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[206] = {

		"name" : "dmg from melee increased"
		"attribute_class" : "dmg_from_melee"
		"description_string" : "#Attrib_DmgFromMelee_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[207] = {

		"name" : "blast dmg to self increased"
		"attribute_class" : "blast_dmg_to_self"
		"description_string" : "#Attrib_BlastDamageToSelf_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[208] = {

		"name" : "Set DamageType Ignite"
		"attribute_class" : "set_dmgtype_ignite"
		"description_string" : "#Attrib_SetDamageType_Ignite"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[209] = {

		"name" : "minicrit vs burning player"
		"attribute_class" : "or_minicrit_vs_playercond_burning"
		"description_string" : "#Attrib_Minicrit_Vs_Burning_Player"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},


	[211] = {

		"name" : "tradable after date"
		"attribute_class" : "tradable_after_date"
		"description_string" : "#Attrib_TradableAfterDate"
		"description_format" : "value_is_date"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[212] = {

		"name" : "force level display"
		"attribute_class" : "force_level_display"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},


	[214] = {

		"name" : "kill eater"
		"attribute_class" : "kill_eater"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
		"can_affect_market_name" : "1"
	},
	[215] = {

		"name" : "apply z velocity on damage"
		"attribute_class" : "apply_z_velocity_on_damage"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[216] = {

		"name" : "apply look velocity on damage"
		"attribute_class" : "apply_look_velocity_on_damage"
		"description_string" : "#Attrib_Knockback"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[217] = {

		"name" : "sanguisuge"
		"attribute_class" : "sanguisuge"
		"description_string" : "#Attrib_Sanguisuge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[218] = {

		"name" : "mark for death"
		"attribute_class" : "mark_for_death"
		"description_string" : "#Attrib_MarkForDeath"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[219] = {

		"name" : "decapitate type"
		"attribute_class" : "decapitate_type"
		"description_string" : "#Attrib_DamageDone_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[220] = {

		"name" : "restore health on kill"
		"attribute_class" : "restore_health_on_kill"
		"description_string" : "#Attrib_RestoreHealthOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[221] = {

		"name" : "mult decloak rate"
		"attribute_class" : "mult_decloak_rate"
		"description_string" : "#Attrib_DecloakRate"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[222] = {

		"name" : "mult sniper charge after bodyshot"
		"attribute_class" : "mult_sniper_charge_after_bodyshot"
		"description_string" : "#Attrib_MultSniperChargeAfterBodyshot"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[223] = {

		"name" : "mult sniper charge after miss"
		"attribute_class" : "mult_sniper_charge_after_miss"
		"description_string" : "#Attrib_MultSniperChargeAfterMiss"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[224] = {

		"name" : "dmg bonus while half dead"
		"attribute_class" : "mult_dmg_bonus_while_half_dead"
		"description_string" : "#Attrib_MultDmgBonusWhileHalfDead"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[225] = {

		"name" : "dmg penalty while half alive"
		"attribute_class" : "mult_dmg_penalty_while_half_alive"
		"description_string" : "#Attrib_MultDmgPenaltyWhileHalfAlive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[226] = {

		"name" : "honorbound"
		"attribute_class" : "honorbound"
		"description_string" : "#Attrib_Honorbound"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[227] = {

		"name" : "custom texture hi"
		"attribute_class" : "custom_texture_hi"
		"description_string" : "#Attrib_CustomTexture"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[228] = {

		"name" : "makers mark id"
		"attribute_class" : "makers_mark_id"
		"description_string" : "#Attrib_MakersMark"
		"description_format" : "value_is_account_id"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[229] = {

		"name" : "unique craft index"
		"attribute_class" : "unique_craft_index"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[230] = {

		"name" : "mod medic killed revenge"
		"attribute_class" : "medic_killed_revenge"
		"description_string" : "#Attrib_MedicKilledRevenge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[231] = {

		"name" : "medigun charge is megaheal"
		"attribute_class" : "set_charge_type"
		"description_string" : "#Attrib_Medigun_MegaHeal"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[232] = {

		"name" : "mod medic killed minicrit boost"
		"attribute_class" : "medic_killed_minicrit_boost"
		"description_string" : "#Attrib_MedicKilledMiniCritBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[233] = {

		"name" : "mod medic healed damage bonus"
		"attribute_class" : "medic_healed_damage_bonus"
		"description_string" : "#Attrib_MedicHealedDamageBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[234] = {

		"name" : "mod medic healed deploy time penalty"
		"attribute_class" : "mod_medic_healed_deploy_time"
		"description_string" : "#Attrib_MedicHealedDeployTimePenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[235] = {

		"name" : "mod shovel speed boost"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_ShovelSpeedBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[236] = {

		"name" : "mod weapon blocks healing"
		"attribute_class" : "weapon_blocks_healing"
		"description_string" : "#Attrib_WeaponBlocksHealing"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
		"apply_tag_to_item_definition" : "prevents_uber"
	},
	[237] = {

		"name" : "mult sniper charge after headshot"
		"attribute_class" : "mult_sniper_charge_after_headshot"
		"description_string" : "#Attrib_MultSniperChargeAfterHeadshot"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[238] = {

		"name" : "minigun no spin sounds"
		"attribute_class" : "minigun_no_spin_sounds"
		"description_string" : "#Attrib_MinigunNoSpinSounds"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[239] = {

		"name" : "ubercharge rate bonus for healer"
		"attribute_class" : "mult_uberchargerate_for_healer"
		"description_string" : "#Attrib_UberchargeRate_ForHealer"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[240] = {

		"name" : "reload time decreased while healed"
		"attribute_class" : "mult_reload_time_while_healed"
		"description_string" : "#Attrib_ReloadTime_Decreased_While_Healed"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[241] = {

		"name" : "reload time increased hidden"
		"attribute_class" : "mult_reload_time_hidden"
		"description_string" : "#Attrib_ReloadTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[242] = {

		"name" : "mod medic killed marked for death"
		"attribute_class" : "medic_killed_marked_for_death"
		"description_string" : "#Attrib_MedicKilledMarkedForDeath"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[243] = {

		"name" : "mod rage on hit penalty"
		"attribute_class" : "rage_on_hit"
		"description_string" : "#Attrib_RageOnHitPenalty"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[244] = {

		"name" : "mod rage on hit bonus"
		"attribute_class" : "rage_on_hit"
		"description_string" : "#Attrib_RageOnHitBonus"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[245] = {

		"name" : "mod rage damage boost"
		"attribute_class" : "rage_damage"
		"description_string" : "#Attrib_RageDamageBoost"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[246] = {

		"name" : "mult charge turn control"
		"attribute_class" : "charge_turn_control"
		"description_string" : "#Attrib_ChargeTurnControl"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[247] = {

		"name" : "no charge impact range"
		"attribute_class" : "no_charge_impact_range"
		"description_string" : "#Attrib_NoChargeImpactRange"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[248] = {

		"name" : "charge impact damage increased"
		"attribute_class" : "charge_impact_damage"
		"description_string" : "#Attrib_ChargeImpactDamageIncreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[249] = {

		"name" : "charge recharge rate increased"
		"attribute_class" : "charge_recharge_rate"
		"description_string" : "#Attrib_ChargeRechargeRateIncreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[250] = {

		"name" : "air dash count"
		"attribute_class" : "air_dash_count"
		"description_string" : "#Attrib_AirDashCountIncreased"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[251] = {

		"name" : "speed buff ally"
		"attribute_class" : "speed_buff_ally"
		"description_string" : "#Attrib_SpeedBuffAlly"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[252] = {

		"name" : "damage force reduction"
		"attribute_class" : "damage_force_reduction"
		"description_string" : "#Attrib_DamageForceReduction"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[253] = {

		"name" : "mult cloak rate"
		"attribute_class" : "mult_cloak_rate"
		"description_string" : "#Attrib_CloakRate"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[255] = {

		"name" : "airblast pushback scale"
		"attribute_class" : "airblast_pushback_scale"
		"description_string" : "#Attrib_AirBlastPushScale"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[256] = {

		"name" : "mult airblast refire time"
		"attribute_class" : "mult_airblast_refire_time"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[257] = {

		"name" : "airblast vertical pushback scale"
		"attribute_class" : "airblast_vertical_pushback_scale"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[258] = {

		"name" : "ammo becomes health"
		"attribute_class" : "ammo_becomes_health"
		"description_string" : "#Attrib_AmmoBecomesHealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[259] = {

		"name" : "boots falling stomp"
		"attribute_class" : "boots_falling_stomp"
		"description_string" : "#Attrib_BootsFallingStomp"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[260] = {

		"name" : "deflection size multiplier"
		"attribute_class" : "deflection_size_multiplier"
		"description_string" : "#Attrib_DeflectionSizeMultiplier"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[261] = {

		"name" : "set item tint RGB 2"
		"attribute_class" : "set_item_tint_rgb_2"
		"description_string" : "#Attrib_SetItemTintRGB"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[262] = {

		"name" : "saxxy award category"
		"attribute_class" : "saxxy_award_category"
		"description_string" : "#Attrib_SaxxyAward"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[263] = {

		"name" : "melee bounds multiplier"
		"attribute_class" : "melee_bounds_multiplier"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[264] = {

		"name" : "melee range multiplier"
		"attribute_class" : "melee_range_multiplier"
		"description_string" : "#Attrib_MeleeRangeMultiplier"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[265] = {

		"name" : "mod mini-crit airborne deploy"
		"attribute_class" : "mini_crit_airborne_deploy"
		"description_string" : "#Attrib_MiniCritAirborneEnemiesDeploy"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[266] = {

		"name" : "projectile penetration"
		"attribute_class" : "projectile_penetration"
		"description_string" : "#Attrib_Penetration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[267] = {

		"name" : "mod crit while airborne"
		"attribute_class" : "crit_while_airborne"
		"description_string" : "#Attrib_CritWhileAirborne"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[268] = {

		"name" : "mult sniper charge penalty DISPLAY ONLY"
		"attribute_class" : "mult_sniper_charge_base_dummy"
		"description_string" : "#Attrib_MultSniperChargePenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[269] = {

		"name" : "mod see enemy health"
		"attribute_class" : "see_enemy_health"
		"description_string" : "#Attrib_SeeEnemyHealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[270] = {

		"name" : "powerup max charges"
		"attribute_class" : "powerup_max_charges"
		"description_string" : "#Attrib_PowerupMaxCharges"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[271] = {

		"name" : "powerup charges"
		"attribute_class" : "powerup_charges"
		"description_string" : "#Attrib_PowerupCharges"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[272] = {

		"name" : "powerup duration"
		"attribute_class" : "powerup_duration"
		"description_string" : "#Attrib_PowerupDuration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[273] = {

		"name" : "critboost"
		"attribute_class" : "critboost"
		"description_string" : "#Attrib_CritBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[274] = {

		"name" : "ubercharge"
		"attribute_class" : "ubercharge"
		"description_string" : "#Attrib_Ubercharge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[275] = {

		"name" : "cancel falling damage"
		"attribute_class" : "cancel_falling_damage"
		"description_string" : "#Attrib_CancelFallingDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[276] = {

		"name" : "bidirectional teleport"
		"attribute_class" : "bidirectional_teleport"
		"description_string" : "#Attrib_BiDirectionalTP"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[277] = {

		"name" : "multiple sentries"
		"attribute_class" : "multiple_sentries"
		"description_string" : "#Attrib_MultipleSentries"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[278] = {

		"name" : "effect bar recharge rate increased"
		"attribute_class" : "effectbar_recharge_rate"
		"description_string" : "#Attrib_EffectBarRechargeRateIncreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[279] = {

		"name" : "maxammo grenades1 increased"
		"attribute_class" : "mult_maxammo_grenades1"
		"description_string" : "#Attrib_MaxammoGrenades1_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[280] = {

		"name" : "override projectile type"
		"attribute_class" : "override_projectile_type"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[281] = {

		"name" : "energy weapon no ammo"
		"attribute_class" : "energy_weapon_no_ammo"
		"description_string" : "#Attrib_EnergyWeaponNoAmmo"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[282] = {

		"name" : "energy weapon charged shot"
		"attribute_class" : "energy_weapon_charged_shot"
		"description_string" : "#Attrib_EnergyWeaponChargedShot"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[283] = {

		"name" : "energy weapon penetration"
		"attribute_class" : "energy_weapon_penetration"
		"description_string" : "#Attrib_EnergyWeaponPenetration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[284] = {

		"name" : "energy weapon no hurt building"
		"attribute_class" : "energy_weapon_no_hurt_building"
		"description_string" : "#Attrib_EnergyWeaponNoHurtBuilding"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[285] = {

		"name" : "energy weapon no deflect"
		"attribute_class" : "energy_weapon_no_deflect"
		"description_string" : "#Attrib_EnergyWeaponNoDeflect"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[286] = {

		"name" : "engy building health bonus"
		"attribute_class" : "mult_engy_building_health"
		"description_string" : "#Attrib_EngyBuildingHealthBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[287] = {

		"name" : "engy sentry damage bonus"
		"attribute_class" : "mult_engy_sentry_damage"
		"description_string" : "#Attrib_EngySentryDamageBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[288] = {

		"name" : "no crit boost"
		"attribute_class" : "no_crit_boost"
		"description_string" : "#Attrib_NoCritBoost"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[289] = {

		"name" : "centerfire projectile"
		"attribute_class" : "centerfire_projectile"
		"description_string" : "#Attrib_CenterFireProjectile"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[292] = {

		"name" : "kill eater score type"
		"attribute_class" : "kill_eater_score_type"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[293] = {

		"name" : "kill eater score type 2"
		"attribute_class" : "kill_eater_score_type_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[294] = {

		"name" : "kill eater 2"
		"attribute_class" : "kill_eater_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[295] = {

		"name" : "has pipboy build interface"
		"attribute_class" : "set_custom_buildmenu"
		"description_string" : ""
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[296] = {

		"name" : "sapper kills collect crits"
		"attribute_class" : "sapper_kills_collect_crits"
		"description_string" : "#Attrib_SapperKillsCollectCrits"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[297] = {

		"name" : "sniper only fire zoomed"
		"attribute_class" : "sniper_only_fire_zoomed"
		"description_string" : "#Attrib_SniperOnlyFireZoomed"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[298] = {

		"name" : "mod ammo per shot"
		"attribute_class" : "mod_ammo_per_shot"
		"description_string" : "#Attrib_AmmoPerShot"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[299] = {

		"name" : "add onhit addammo"
		"attribute_class" : "add_onhit_addammo"
		"description_string" : "#Attrib_OnHit_AddAmmo"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[300] = {

		"name" : "electrical airblast DISPLAY ONLY"
		"attribute_class" : "electrical_airblast_DISPLAY_ONLY"
		"description_string" : "#Attrib_ElectricalAirblast"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[301] = {

		"name" : "mod use metal ammo type"
		"attribute_class" : "mod_use_metal_ammo_type"
		"description_string" : "#Attrib_UseMetalAmmoType"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[302] = {

		"name" : "expiration date"
		"attribute_class" : "expiration_date"
		"description_string" : "#Attrib_ExpirationDate"
		"description_format" : "value_is_date"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[303] = {

		"name" : "mod max primary clip override"
		"attribute_class" : "mod_max_primary_clip_override"
		"description_string" : ""
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[304] = {

		"name" : "sniper full charge damage bonus"
		"attribute_class" : "sniper_full_charge_damage_bonus"
		"description_string" : "#Attrib_Sniper_FullChargeBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[305] = {

		"name" : "sniper fires tracer"
		"attribute_class" : "sniper_fires_tracer"
		"description_string" : "#Attrib_Sniper_FiresTracer"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[306] = {

		"name" : "sniper no headshot without full charge"
		"attribute_class" : "sniper_no_headshot_without_full_charge"
		"description_string" : "#Attrib_Sniper_NoHeadShot"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[307] = {

		"name" : "mod no reload DISPLAY ONLY"
		"attribute_class" : "mod_no_reload_display_only"
		"description_string" : "#Attrib_NoReload"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[308] = {

		"name" : "sniper penetrate players when charged"
		"attribute_class" : "sniper_penetrate_players_when_charged"
		"description_string" : "#Attrib_SniperFullChargePenetration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[309] = {

		"name" : "crit kill will gib"
		"attribute_class" : "crit_kill_will_gib"
		"description_string" : "#Attrib_CritKillWillGib"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[310] = {

		"name" : "recall"
		"attribute_class" : "recall"
		"description_string" : "#Attrib_Recall"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[311] = {

		"name" : "unlimited quantity"
		"attribute_class" : "unlimited_quantity"
		"description_string" : "#Attrib_Unlimited"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[312] = {

		"name" : "disable weapon hiding for animations"
		"attribute_class" : "disable_weapon_hiding_for_animations"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[313] = {

		"name" : "applies snare effect"
		"attribute_class" : "applies_snare_effect"
		"description_string" : "#Attrib_AppliesSnareEffect"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[314] = {

		"name" : "uber duration bonus"
		"attribute_class" : "add_uber_time"
		"description_string" : "#Attrib_UberDurationBonus"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[315] = {

		"name" : "refill_ammo"
		"attribute_class" : "refill_ammo"
		"description_string" : "#Attrib_RefillAmmo"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[317] = {

		"name" : "store sort override DEPRECATED"
		"attribute_class" : "store_sort_override_DEPRECATED"
		"description_string" : "#Attrib_AlternateRocketEffect"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[318] = {

		"name" : "faster reload rate"
		"attribute_class" : "fast_reload"
		"description_string" : "#Attrib_FastReload"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[319] = {

		"name" : "increase buff duration"
		"attribute_class" : "mod_buff_duration"
		"description_string" : "#Attrib_BuffTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[320] = {

		"name" : "robo sapper"
		"attribute_class" : "robo_sapper"
		"description_string" : "#Attrib_RoboSapper"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[321] = {

		"name" : "build rate bonus"
		"attribute_class" : "mod_build_rate"
		"description_string" : "#Attrib_BuildRateBonus"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[322] = {

		"name" : "taunt is press and hold"
		"attribute_class" : "enable_misc2_holdtaunt"
		"description_string" : "#Attrib_DamageDone_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[323] = {

		"name" : "attack projectiles"
		"attribute_class" : "attack_projectiles"
		"description_string" : "#Attrib_AttackProjectiles"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[324] = {

		"name" : "accuracy scales damage"
		"attribute_class" : "accuracy_scales_damage"
		"description_string" : "#Attrib_AccurScalesDmg"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[325] = {

		"name" : "currency bonus"
		"attribute_class" : "currency_bonus"
		"description_string" : "#Attrib_CurrencyBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[326] = {

		"name" : "increased jump height"
		"attribute_class" : "mod_jump_height"
		"description_string" : "#Attrib_JumpHeightBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[327] = {

		"name" : "building instant upgrade"
		"attribute_class" : "building_instant_upgrade"
		"description_string" : "#Attrib_BuildingInstaUpgrade"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[328] = {

		"name" : "disable fancy class select anim"
		"attribute_class" : "disable_fancy_class_select_anim"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[329] = {

		"name" : "airblast vulnerability multiplier"
		"attribute_class" : "airblast_vulnerability_multiplier"
		"description_string" : "#Attrib_AirBlastVulnerabilityMultipier"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[330] = {

		"name" : "override footstep sound set"
		"attribute_class" : "override_footstep_sound_set"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[331] = {

		"name" : "spawn with physics toy"
		"attribute_class" : "spawn_with_physics_toy"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[332] = {

		"name" : "fish damage override"
		"attribute_class" : "fish_damage_override"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[333] = {

		"name" : "SET BONUS: special dsp"
		"attribute_class" : "special_dsp"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[334] = {

		"name" : "bombinomicon effect on death"
		"attribute_class" : "bombinomicon_effect_on_death"
		"description_string" : "#Attrib_BombinomiconEffectOnDeath"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[335] = {

		"name" : "clip size bonus upgrade"
		"attribute_class" : "mult_clipsize_upgrade"
		"description_string" : "#Attrib_ClipSize_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[336] = {

		"name" : "hide enemy health"
		"attribute_class" : "hide_enemy_health"
		"description_string" : "#Attrib_HideEnemyHealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[337] = {

		"name" : "subtract victim medigun charge on hit"
		"attribute_class" : "subtract_victim_medigun_charge_onhit"
		"description_string" : "#Attrib_SubtractVictimMedigunChargeOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[338] = {

		"name" : "subtract victim cloak on hit"
		"attribute_class" : "subtract_victim_cloak_on_hit"
		"description_string" : "#Attrib_SubtractVictimCloakOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[339] = {

		"name" : "reveal cloaked victim on hit"
		"attribute_class" : "reveal_cloaked_victim_on_hit"
		"description_string" : "#Attrib_RevealCloakedVictimOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[340] = {

		"name" : "reveal disguised victim on hit"
		"attribute_class" : "reveal_disguised_victim_on_hit"
		"description_string" : "#Attrib_RevealDisguisedVictimOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[341] = {

		"name" : "jarate backstabber"
		"attribute_class" : "jarate_backstabber"
		"description_string" : "#Attrib_JarateBackstabber"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[343] = {

		"name" : "engy sentry fire rate increased"
		"attribute_class" : "mult_sentry_firerate"
		"description_string" : "#Attrib_SentryFireRate_Increased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[344] = {

		"name" : "engy sentry radius increased"
		"attribute_class" : "mult_sentry_range"
		"description_string" : "#Attrib_SentryRadius_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[345] = {

		"name" : "engy dispenser radius increased"
		"attribute_class" : "mult_dispenser_radius"
		"description_string" : "#Attrib_DispenserRadius_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[346] = {

		"name" : "mod bat launches ornaments"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_BatLaunchesOrnaments"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[347] = {

		"name" : "freeze backstab victim"
		"attribute_class" : "freeze_backstab_victim"
		"description_string" : "#Attrib_FreezeBackstabVictim"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[348] = {

		"name" : "fire rate penalty HIDDEN"
		"attribute_class" : "mult_postfiredelay"
		"description_string" : ""
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[349] = {

		"name" : "energy weapon no drain"
		"attribute_class" : "energy_weapon_no_drain"
		"description_string" : ""
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[350] = {

		"name" : "ragdolls become ash"
		"attribute_class" : "ragdolls_become_ash"
		"description_string" : ""
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[351] = {

		"name" : "engy disposable sentries"
		"attribute_class" : "engy_disposable_sentries"
		"description_string" : "#Attrib_EngyDisposableSentries"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[352] = {

		"name" : "alt fire teleport to spawn"
		"attribute_class" : "alt_fire_teleport_to_spawn"
		"description_string" : "#Attrib_AltFireTeleportToSpawn"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[353] = {

		"name" : "cannot pick up buildings"
		"attribute_class" : "cannot_pick_up_buildings"
		"description_string" : "#Attrib_CannotPickUpBuildings"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[354] = {

		"name" : "stun enemies wielding same weapon"
		"attribute_class" : "stun_enemies_wielding_same_weapon"
		"description_string" : "#Attrib_StunEnemiesWieldingSameWeapon"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[355] = {

		"name" : "mod ammo per shot missed DISPLAY ONLY"
		"attribute_class" : "mod_ammo_per_shot_missed_DISPLAY_ONLY"
		"description_string" : "#Attrib_AmmoPerShotMissed"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[356] = {

		"name" : "airblast disabled"
		"attribute_class" : "airblast_disabled"
		"description_string" : "#Attrib_AirblastDisabled"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[357] = {

		"name" : "increase buff duration HIDDEN"
		"attribute_class" : "mod_buff_duration"
		"description_string" : "#Attrib_BuffTime_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[358] = {

		"name" : "crit forces victim to laugh"
		"attribute_class" : "crit_forces_victim_to_laugh"
		"description_string" : "#Attrib_CritForcesLaugh"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[359] = {

		"name" : "melts in fire"
		"attribute_class" : "melts_in_fire"
		"description_string" : "#Attrib_MeltsInFire"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[360] = {

		"name" : "damage all connected"
		"attribute_class" : "damage_all_connected"
		"description_string" : "#Attrib_DamageAllConnected"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[361] = {

		"name" : "become fireproof on hit by fire"
		"attribute_class" : "become_fireproof_on_hit_by_fire"
		"description_string" : "#Attrib_BecomeFireproofOnHitByFire"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[362] = {

		"name" : "crit from behind"
		"attribute_class" : "crit_from_behind"
		"description_string" : "#Attrib_CritFromBehind"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[363] = {

		"name" : "crit does no damage"
		"attribute_class" : "crit_does_no_damage"
		"description_string" : "#Attrib_CritDoesNoDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[364] = {

		"name" : "add jingle to footsteps"
		"attribute_class" : "add_jingle_to_footsteps"
		"description_string" : "#Attrib_AddJingleToFootsteps"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[365] = {

		"name" : "set icicle knife mode"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_SetIcicleKnifeMode"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[366] = {

		"name" : "mod stun waist high airborne"
		"attribute_class" : "stun_waist_high_airborne"
		"description_string" : "#Attrib_StunWaistHighAirborne"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[367] = {

		"name" : "extinguish earns revenge crits"
		"attribute_class" : "extinguish_revenge"
		"description_string" : "#Attrib_ExtinguishRevenge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[368] = {

		"name" : "burn damage earns rage"
		"attribute_class" : "burn_damage_earns_rage"
		"description_string" : "#Attrib_BurnDamageEarnsRage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[369] = {

		"name" : "tickle enemies wielding same weapon"
		"attribute_class" : "tickle_enemies_wielding_same_weapon"
		"description_string" : "#Attrib_TickleEnemiesWieldingSameWeapon"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[370] = {

		"name" : "attach particle effect static"
		"attribute_class" : "set_attached_particle_static"
		"description_format" : "value_is_particle_index"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[371] = {

		"name" : "cosmetic taunt sound"
		"attribute_class" : "cosmetic_taunt_sound"
		"attribute_type" : "string"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[372] = {

		"name" : "accepted wedding ring account id 1"
		"attribute_class" : "accepted_wedding_ring_account_id_1"
		"description_string" : "#Attrib_AcceptedWeddingRingAccount1"
		"description_format" : "value_is_account_id"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[373] = {

		"name" : "accepted wedding ring account id 2"
		"attribute_class" : "accepted_wedding_ring_account_id_2"
		"description_string" : "#Attrib_AcceptedWeddingRingAccount2"
		"description_format" : "value_is_account_id"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[374] = {

		"name" : "tool escrow until date"
		"attribute_class" : "tool_escrow_until_date"
		"description_string" : "#Attrib_ToolEscrowUntilDate"
		"description_format" : "value_is_date"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[375] = {

		"name" : "generate rage on damage"
		"attribute_class" : "generate_rage_on_dmg"
		"description_string" : "#Attrib_RageOnDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[376] = {

		"name" : "aiming no flinch"
		"attribute_class" : "aiming_no_flinch"
		"description_string" : "#Attrib_AimingNoFlinch"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[377] = {

		"name" : "aiming knockback resistance"
		"attribute_class" : "mult_aiming_knockback_resistance"
		"description_string" : "#Attrib_AimingKnockbackResistance"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[378] = {

		"name" : "sniper aiming movespeed decreased"
		"attribute_class" : "mult_player_aiming_movespeed"
		"description_string" : "#Attrib_SniperAimingMoveSpeed_Decreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[379] = {

		"name" : "kill eater user 1"
		"attribute_class" : "kill_eater_user_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[380] = {

		"name" : "kill eater user score type 1"
		"attribute_class" : "kill_eater_user_score_type_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[381] = {

		"name" : "kill eater user 2"
		"attribute_class" : "kill_eater_user_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[382] = {

		"name" : "kill eater user score type 2"
		"attribute_class" : "kill_eater_user_score_type_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[383] = {

		"name" : "kill eater user 3"
		"attribute_class" : "kill_eater_user_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[384] = {

		"name" : "kill eater user score type 3"
		"attribute_class" : "kill_eater_user_score_type_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[385] = {

		"name" : "strange part new counter ID"
		"attribute_class" : "strange_part_new_counter_id"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[386] = {

		"name" : "mvm completed challenges bitmask"
		"attribute_class" : "mvm_completed_challenges_bitmask"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[387] = {

		"name" : "rage on kill"
		"attribute_class" : "rage_on_kill"
		"description_string" : "#Attrib_RageGainOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[388] = {

		"name" : "kill eater kill type"
		"attribute_class" : "kill_eater_kill_type"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[389] = {

		"name" : "shot penetrate all players"
		"attribute_class" : "shot_penetrate_all_players"
		"description_string" : "#Attrib_ShotPenetration"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[390] = {

		"name" : "headshot damage increase"
		"attribute_class" : "headshot_damage_modify"
		"description_string" : "#Attrib_HeadshotDamageIncrease"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[391] = {

		"name" : "SET BONUS: mystery solving time decrease"
		"attribute_class" : "mystery_solving_time_decrease"
		"description_string" : "#Attrib_MysterySolvingTimeDecrease"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[392] = {

		"name" : "damage penalty on bodyshot"
		"attribute_class" : "bodyshot_damage_modify"
		"description_string" : "#Attrib_DamageDone_Bodyshot_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[393] = {

		"name" : "sniper rage DISPLAY ONLY"
		"attribute_class" : "sniper_rage_DISPLAY_ONLY"
		"description_string" : "#Attrib_SniperRageDisplayOnly"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[394] = {

		"name" : "fire rate bonus HIDDEN"
		"attribute_class" : "mult_postfiredelay"
		"description_string" : "#Attrib_FireRate_Positive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[395] = {

		"name" : "explosive sniper shot"
		"attribute_class" : "explosive_sniper_shot"
		"description_string" : "#Attrib_ExplosiveSniperShot"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[396] = {

		"name" : "melee attack rate bonus"
		"attribute_class" : "mult_postfiredelay"
		"description_string" : "#Attrib_MeleeRate_Positive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[397] = {

		"name" : "projectile penetration heavy"
		"attribute_class" : "projectile_penetration"
		"description_string" : "#Attrib_Penetration_Heavy"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[398] = {

		"name" : "rage on assists"
		"attribute_class" : "rage_on_assists"
		"description_string" : "#Attrib_RageGainOnAssists"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[399] = {

		"name" : "armor piercing"
		"attribute_class" : "armor_piercing"
		"description_string" : "#Attrib_ArmorPiercing"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[400] = {

		"name" : "cannot pick up intelligence"
		"attribute_class" : "cannot_pick_up_intelligence"
		"description_string" : "#Attrib_CannotPickUpIntelligence"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[401] = {

		"name" : "SET BONUS: chance of hunger decrease"
		"attribute_class" : "chance_of_hunger_decrease"
		"description_string" : "#Attrib_ChanceOfHungerDecrease"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[402] = {

		"name" : "cannot be backstabbed"
		"attribute_class" : "cannot_be_backstabbed"
		"description_string" : "#Attrib_CannotBeBackstabbed"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[403] = {

		"name" : "squad surplus claimer id DEPRECATED"
		"attribute_class" : "squad_surplus_claimer_account_id_DEPRECATED"
		"description_string" : "#Attrib_SquadSurplusClaimerAccountID"
		"description_format" : "value_is_account_id"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[404] = {

		"name" : "share consumable with patient"
		"attribute_class" : "share_consumable_with_patient"
		"description_string" : "#Attrib_ShareConsumable"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[405] = {

		"name" : "airblast vertical vulnerability multiplier"
		"attribute_class" : "airblast_vertical_vulnerability_multiplier"
		"description_string" : "#Attrib_AirBlastVerticalVulnerabilityMultipier"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[406] = {

		"name" : "vision opt in flags"
		"attribute_class" : "vision_opt_in_flags"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[407] = {

		"name" : "crit vs disguised players"
		"attribute_class" : "or_crit_vs_playercond"
		"description_string" : "#Attrib_CritVsDisguised"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[408] = {

		"name" : "crit vs non burning players"
		"attribute_class" : "or_crit_vs_not_playercond"
		"description_string" : "#Attrib_CritVsNonBurning"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[409] = {

		"name" : "kill forces attacker to laugh"
		"attribute_class" : "kill_forces_attacker_to_laugh"
		"description_string" : "#Attrib_KillForcesAttackerLaugh"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[410] = {

		"name" : "damage bonus while disguised"
		"attribute_class" : "mult_dmg_disguised"
		"description_string" : "#Attrib_DmgBonus_Disguised"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[411] = {

		"name" : "projectile spread angle penalty"
		"attribute_class" : "projectile_spread_angle"
		"description_string" : "#Attrib_Projectile_Spread_Angle_Negative"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[412] = {

		"name" : "dmg taken increased"
		"attribute_class" : "mult_dmgtaken"
		"description_string" : "#Attrib_DmgTaken_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[413] = {

		"name" : "auto fires full clip"
		"attribute_class" : "auto_fires_full_clip"
		"description_string" : "#Attrib_AutoFiresFullClip"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[414] = {

		"name" : "self mark for death"
		"attribute_class" : "self_mark_for_death"
		"description_string" : "#Attrib_SelfMarkForDeath"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[415] = {

		"name" : "counts as assister is some kind of pet this update is going to be awesome"
		"attribute_class" : "counts_as_assister"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
	},
	[416] = {

		"name" : "mod flaregun fires pellets with knockback"
		"attribute_class" : "set_weapon_mode"
		"description_string" : "#Attrib_FlaregunPelletsWithKnockback"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[417] = {

		"name" : "can overload"
		"attribute_class" : "can_overload"
		"description_string" : "#Attrib_CanOverload"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[418] = {

		"name" : "boost on damage"
		"attribute_class" : "boost_on_damage"
		"description_string" : "#Attrib_BoostOnDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[419] = {

		"name" : "hype resets on jump"
		"attribute_class" : "hype_resets_on_jump"
		"description_string" : "#Attrib_HypeResetsOnJump"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[420] = {

		"name" : "pyro year number"
		"attribute_class" : "pyro_year_number"
		"description_string" : "#Attrib_PyroYearNumber"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[421] = {

		"name" : "no primary ammo from dispensers while active"
		"attribute_class" : "no_primary_ammo_from_dispensers"
		"description_string" : "#Attrib_NoPrimaryAmmoFromDispensers"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[422] = {

		"name" : "pyrovision only DISPLAY ONLY"
		"attribute_class" : "pyrovision_only_display"
		"description_string" : "#Attrib_PyrovisionFilter"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[424] = {

		"name" : "clip size penalty HIDDEN"
		"attribute_class" : "mult_clipsize"
		"description_string" : "#Attrib_ClipSize_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[425] = {

		"name" : "sapper damage bonus"
		"attribute_class" : "mult_sapper_damage"
		"description_string" : "#Attrib_Sapper_Damage_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[426] = {

		"name" : "sapper damage penalty"
		"attribute_class" : "mult_sapper_damage"
		"description_string" : "#Attrib_Sapper_Damage_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[427] = {

		"name" : "sapper damage leaches health"
		"attribute_class" : "sapper_damage_leaches_health"
		"description_string" : "#Attrib_Sapper_Leaches_Health"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[428] = {

		"name" : "sapper health bonus"
		"attribute_class" : "mult_sapper_health"
		"description_string" : "#Attrib_Sapper_Health_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[429] = {

		"name" : "sapper health penalty"
		"attribute_class" : "mult_sapper_health"
		"description_string" : "#Attrib_Sapper_Health_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[430] = {

		"name" : "ring of fire while aiming"
		"attribute_class" : "ring_of_fire_while_aiming"
		"description_string" : "#Attrib_Ring_Of_Fire_While_Aiming"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[431] = {

		"name" : "uses ammo while aiming"
		"attribute_class" : "uses_ammo_while_aiming"
		"description_string" : "#Attrib_Uses_Ammo_While_Aiming"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[433] = {

		"name" : "sapper degenerates buildings"
		"attribute_class" : "sapper_degenerates_buildings"
		"description_string" : "#Attrib_Sapper_Degenerates_Buildings"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[434] = {

		"name" : "sapper damage penalty hidden"
		"attribute_class" : "mult_sapper_damage"
		"description_string" : "#Attrib_Sapper_Damage_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[435] = {

		"name" : "cleaver description"
		"attribute_class" : "desc_cleaver_description"
		"description_string" : "#Attrib_Cleaver_Description"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[436] = {

		"name" : "ragdolls plasma effect"
		"attribute_class" : "ragdolls_plasma_effect"
		"description_string" : ""
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[437] = {

		"name" : "crit vs stunned players"
		"attribute_class" : "or_crit_vs_playercond"
		"description_string" : "#Attrib_CritVsStunned"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[438] = {

		"name" : "crit vs wet players"
		"attribute_class" : "crit_vs_wet_players"
		"description_string" : "#Attrib_CritVsWet"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[439] = {

		"name" : "override item level desc string"
		"attribute_class" : "override_item_level_desc_string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},

	[440] = {

		"name" : "clip size upgrade atomic"
		"attribute_class" : "mult_clipsize_upgrade_atomic"
		"description_string" : "#Attrib_ClipSize_Atomic"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[441] = {

		"name" : "auto fires full clip all at once"
		"attribute_class" : "auto_fires_full_clip_all_at_once"
		"description_string" : "#Attrib_AutoFiresFullClipAllAtOnce"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[442] = {

		"name" : "major move speed bonus"
		"attribute_class" : "mult_player_movespeed"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[443] = {

		"name" : "major increased jump height"
		"attribute_class" : "mod_jump_height"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[444] = {

		"name" : "head scale"
		"attribute_class" : "head_scale"
		"description_format" : "value_is_percentage"
		"description_string" : "#Attrib_NoDoubleJump"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[445] = {

		"name" : "pyrovision opt in DISPLAY ONLY"
		"attribute_class" : "pyrovision_opt_in_display_only"
		"description_string" : "#Attrib_PyroVisionOptIn"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[446] = {

		"name" : "halloweenvision opt in DISPLAY ONLY"
		"attribute_class" : "halloweenvision_opt_in_display_only"
		"description_string" : ""
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[447] = {

		"name" : "halloweenvision filter DISPLAY ONLY"
		"attribute_class" : "halloweenvision_filter_display_only"
		"description_string" : ""
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[448] = {

		"name" : "player skin override"
		"attribute_class" : "player_skin_override"
		"description_string" : "#Attrib_PlayerSkinOverride"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[449] = {

		"name" : "never craftable"
		"attribute_class" : "never_craftable"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[450] = {

		"name" : "zombiezombiezombiezombie"
		"attribute_class" : "zombiezombiezombiezombie"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[451] = {

		"name" : "sapper voice pak"
		"attribute_class" : "sapper_voice_pak"
		"description_string" : "#Attrib_Sapper_Voice_Pak"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[452] = {

		"name" : "sapper voice pak idle wait"
		"attribute_class" : "sapper_voice_pak_idle_wait"
		"description_string" : "#Attrib_Sapper_Voice_Pak_Idle_Wait"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[453] = {

		"name" : "merasmus hat level display ONLY"
		"attribute_class" : "merasmus_hat_level_display_ONLY"
		"description_string" : "#Attrib_Merasmus_Hat_Level"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[454] = {

		"name" : "strange restriction type 1"
		"attribute_class" : "strange_restriction_type_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[455] = {

		"name" : "strange restriction value 1"
		"attribute_class" : "strange_restriction_value_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[456] = {

		"name" : "strange restriction type 2"
		"attribute_class" : "strange_restriction_type_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[457] = {

		"name" : "strange restriction value 2"
		"attribute_class" : "strange_restriction_value_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[458] = {

		"name" : "strange restriction user type 1"
		"attribute_class" : "strange_restriction_user_type_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[459] = {

		"name" : "strange restriction user value 1"
		"attribute_class" : "strange_restriction_user_value_1"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[460] = {

		"name" : "strange restriction user type 2"
		"attribute_class" : "strange_restriction_user_type_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[461] = {

		"name" : "strange restriction user value 2"
		"attribute_class" : "strange_restriction_user_value_2"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[462] = {

		"name" : "strange restriction user type 3"
		"attribute_class" : "strange_restriction_user_type_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[463] = {

		"name" : "strange restriction user value 3"
		"attribute_class" : "strange_restriction_user_value_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[464] = {

		"name" : "engineer sentry build rate multiplier"
		"attribute_class" : "sentry_build_rate_multiplier"
		"description_string" : "#Attrib_Sentry_Build_Rate"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[465] = {

		"name" : "engineer teleporter build rate multiplier"
		"attribute_class" : "teleporter_build_rate_multiplier"
		"description_string" : "#Attrib_Teleporter_Build_Rate"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[466] = {

		"name" : "grenade launcher mortar mode"
		"attribute_class" : "grenade_launcher_mortar_mode"
		"description_string" : "#Attrib_Grenade_Launcher_Mortar_Mode"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[467] = {

		"name" : "grenade not explode on impact"
		"attribute_class" : "grenade_not_explode_on_impact"
		"description_string" : "#Attrib_Grenade_Not_Explode_On_Impact"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[468] = {

		"name" : "strange score selector"
		"attribute_class" : "strange_score_selector"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[469] = {

		"name" : "engineer building teleporting pickup"
		"attribute_class" : "building_teleporting_pickup"
		"description_string" : "#Attrib_Building_Telporting_PickUp"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[470] = {

		"name" : "grenade damage reduction on world contact"
		"attribute_class" : "grenade_damage_reduction_on_world_contact"
		"description_string" : "#Attrib_Grenade_Damage_Reduction_On_World_Contact"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[471] = {

		"name" : "engineer rage on dmg"
		"attribute_class" : "generate_rage_on_dmg"
		"description_string" : "#Attrib_EngineerBuildingRescueRage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[472] = {

		"name" : "mark for death on building pickup"
		"attribute_class" : "mark_for_death_on_building_pickup"
		"description_string" : "#Attrib_MarkedForDeathOnBuildingPickup"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[473] = {

		"name" : "medigun charge is resists"
		"attribute_class" : "set_charge_type"
		"description_string" : "#Attrib_Medigun_Resists"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[474] = {

		"name" : "arrow heals buildings"
		"attribute_class" : "arrow_heals_buildings"
		"description_string" : "#Attrib_ArrowHealsBuildings"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[475] = {

		"name" : "Projectile speed increased HIDDEN"
		"attribute_class" : "mult_projectile_speed"
		"description_string" : "#Attrib_ProjectileSpeed_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[476] = {

		"name" : "damage bonus HIDDEN"
		"attribute_class" : "mult_dmg"
		"description_string" : "#Attrib_DamageDone_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[477] = {

		"name" : "cannonball push back"
		"attribute_class" : "cannonball_push_back"
		"description_string" : "#Attrib_Cannonball_Push_Back"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[478] = {

		"name" : "rage giving scale"
		"attribute_class" : "rage_giving_scale"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[479] = {

		"name" : "overheal fill rate reduced"
		"attribute_class" : "overheal_fill_rate"
		"description_string" : "#Attrib_Overheal_Fill_Rate_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[481] = {

		"name" : "canteen specialist"
		"attribute_class" : "canteen_specialist"
		"description_string" : "#Attrib_Canteen_Specialist"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[482] = {

		"name" : "overheal expert"
		"attribute_class" : "overheal_expert"
		"description_string" : "#Attrib_Overheal_Expert"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[484] = {

		"name" : "mad milk syringes"
		"attribute_class" : "mad_milk_syringes"
		"description_string" : "#Attrib_Medic_MadMilkSyringes"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[488] = {

		"name" : "rocket specialist"
		"attribute_class" : "rocket_specialist"
		"description_string" : "#Attrib_Rocket_Specialist"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[489] = {

		"name" : "SET BONUS: move speed set bonus"
		"attribute_class" : "mult_player_movespeed"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[490] = {

		"name" : "SET BONUS: health regen set bonus"
		"attribute_class" : "add_health_regen"
		"description_string" : "#Attrib_HealthRegen"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[491] = {

		"name" : "SET BONUS: dmg taken from crit reduced set bonus"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[492] = {

		"name" : "SET BONUS: dmg taken from fire reduced set bonus"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[493] = {

		"name" : "healing mastery"
		"attribute_class" : "healing_mastery"
		"description_string" : "#Attrib_Healing_Mastery"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[494] = {

		"name" : "kill eater 3"
		"attribute_class" : "kill_eater_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[495] = {

		"name" : "kill eater score type 3"
		"attribute_class" : "kill_eater_score_type_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[496] = {

		"name" : "strange restriction type 3"
		"attribute_class" : "strange_restriction_type_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[497] = {

		"name" : "strange restriction value 3"
		"attribute_class" : "strange_restriction_value_3"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[498] = {

		"name" : "bot custom jump particle"
		"attribute_class" : "bot_custom_jump_particle"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[499] = {

		"name" : "generate rage on heal"
		"attribute_class" : "generate_rage_on_heal"
		"description_string" : "#Attrib_RageOnHeal"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[500] = {

		"name" : "custom name attr"
		"attribute_class" : "custom_name_attr"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[501] = {

		"name" : "custom desc attr"
		"attribute_class" : "custom_desc_attr"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[503] = {

		"name" : "medigun bullet resist passive"
		"attribute_class" : "medigun_bullet_resist_passive"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[504] = {

		"name" : "medigun blast resist passive"
		"attribute_class" : "medigun_blast_resist_passive"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[505] = {

		"name" : "medigun fire resist passive"
		"attribute_class" : "medigun_fire_resist_passive"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[506] = {

		"name" : "medigun bullet resist deployed"
		"attribute_class" : "medigun_bullet_resist_deployed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[507] = {

		"name" : "medigun blast resist deployed"
		"attribute_class" : "medigun_blast_resist_deployed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[508] = {

		"name" : "medigun fire resist deployed"
		"attribute_class" : "medigun_fire_resist_deployed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[509] = {

		"name" : "medigun crit bullet percent bar deplete"
		"attribute_class" : "medigun_crit_bullet_percent_bar_deplete"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[510] = {

		"name" : "medigun crit blast percent bar deplete"
		"attribute_class" : "medigun_crit_blast_percent_bar_deplete"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[511] = {

		"name" : "medigun crit fire percent bar deplete"
		"attribute_class" : "medigun_crit_fire_percent_bar_deplete"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[512] = {

		"name" : "throwable fire speed"
		"attribute_class" : "throwable_fire_speed"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[513] = {

		"name" : "throwable damage"
		"attribute_class" : "throwable_damage"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[514] = {

		"name" : "throwable healing"
		"attribute_class" : "throwable_healing"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[515] = {

		"name" : "throwable particle trail only"
		"attribute_class" : "throwable_particle_trail_only"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[516] = {

		"name" : "SET BONUS: dmg taken from bullets increased"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[517] = {

		"name" : "SET BONUS: max health additive bonus"
		"attribute_class" : "add_maxhealth"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[518] = {

		"name" : "scattergun knockback mult"
		"attribute_class" : "scattergun_knockback_mult"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[519] = {

		"name" : "particle effect vertical offset"
		"attribute_class" : "particle_effect_vertical_offset"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[520] = {

		"name" : "particle effect use head origin"
		"attribute_class" : "particle_effect_use_head_origin"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[521] = {

		"name" : "use large smoke explosion"
		"attribute_class" : "use_large_smoke_explosion"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[522] = {

		"name" : "damage causes airblast"
		"attribute_class" : "damage_causes_airblast"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[524] = {

		"name" : "increased jump height from weapon"
		"attribute_class" : "mod_jump_height_from_weapon"
		"description_string" : "#Attrib_JumpHeightBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[525] = {

		"name" : "damage force increase"
		"attribute_class" : "damage_force_reduction"
		"description_string" : "#Attrib_DamageForceIncrease"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[526] = {

		"name" : "healing received bonus"
		"attribute_class" : "mult_healing_received"
		"description_string" : "#Attrib_HealingReceivedBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[527] = {

		"name" : "afterburn immunity"
		"attribute_class" : "afterburn_immunity"
		"description_string" : "#Attrib_AfterburnImmunity"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[528] = {

		"name" : "decoded by itemdefindex"
		"attribute_class" : "decoded_by_itemdefindex"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[532] = {

		"name" : "hype decays over time"
		"attribute_class" : "hype_decays_over_time"
		"description_string" : "#Attrib_HypeDecays"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[533] = {

		"name" : "SET BONUS: custom taunt particle attr"
		"attribute_class" : "custom_taunt_particle_attr"
		"description_string" : "#Attrib_TauntParticles"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"is_set_bonus" : "1"
		"stored_as_integer" : "1"
	},
	[534] = {

		"name" : "airblast vulnerability multiplier hidden"
		"attribute_class" : "airblast_vulnerability_multiplier"
		"description_string" : "#Attrib_AirBlastVulnerabilityMultipier"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[535] = {

		"name" : "damage force increase hidden"
		"attribute_class" : "damage_force_reduction"
		"description_string" : "#Attrib_DamageForceIncrease"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[536] = {

		"name" : "damage force increase text"
		"attribute_class" : "damage_force_reduction"
		"description_string" : "#Attrib_DamageForceIncreaseString"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[537] = {

		"name" : "SET BONUS: calling card on kill"
		"attribute_class" : "calling_card_on_kill"
		"description_string" : "#Attrib_CallingCardOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"armory_desc" : "on_wearer"
		"effect_type" : "positive"
		"is_set_bonus" : "1"
		"stored_as_integer" : "1"
	},
	[539] = {

		"name" : "set throwable type"
		"attribute_class" : "set_throwable_type"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[540] = {

		"name" : "add head on hit"
		"attribute_class" : "add_head_on_hit"
		"description_string" : "#Attrib_AddHeadOnHit"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[542] = {

		"name" : "item style override"
		"attribute_class" : "item_style_override"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[543] = {

		"name" : "paint decal enum"
		"attribute_class" : "paint_decal_enum"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[544] = {

		"name" : "show paint description"
		"attribute_class" : "show_paint_description"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[545] = {

		"name" : "bot medic uber health threshold"
		"attribute_class" : "bot_medic_uber_health_threshold"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[546] = {

		"name" : "bot medic uber deploy delay duration"
		"attribute_class" : "bot_medic_uber_deploy_delay_duration"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[547] = {

		"name" : "single wep deploy time decreased"
		"attribute_class" : "mult_single_wep_deploy_time"
		"description_string" : "#Attrib_SingleWepDeployBonus"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},

	[548] = {

		"name" : "halloween reload time decreased"
		"attribute_class" : "hwn_mult_reload_time"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[549] = {

		"name" : "halloween fire rate bonus"
		"attribute_class" : "hwn_mult_postfiredelay"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[550] = {

		"name" : "halloween increased jump height"
		"attribute_class" : "mod_jump_height"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[551] = {

		"name" : "special taunt"
		"attribute_class" : "special_taunt"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[554] = {

		"name" : "revive"
		"attribute_class" : "revive"
		"description_string" : "#Attrib_Revive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[556] = {

		"name" : "taunt attack name"
		"attribute_class" : "taunt_attack_name"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[557] = {

		"name" : "taunt attack time"
		"attribute_class" : "taunt_attack_time"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[600] = {

		"name" : "taunt force move forward"
		"attribute_class" : "taunt_force_move_forward"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[602] = {

		"name" : "taunt mimic"
		"attribute_class" : "taunt_mimic"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[606] = {

		"name" : "taunt success sound"
		"attribute_class" : "taunt_success_sound"
		"attribute_type" : "string"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[607] = {

		"name" : "taunt success sound offset"
		"attribute_class" : "taunt_success_sound_offset"
		"description_string" : "#Attrib_PhaseCloak"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[608] = {

		"name" : "taunt success sound loop"
		"attribute_class" : "taunt_success_sound_loop"
		"attribute_type" : "string"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[609] = {

		"name" : "taunt success sound loop offset"
		"attribute_class" : "taunt_success_sound_loop_offset"
		"description_string" : "#Attrib_PhaseCloak"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[610] = {

		"name" : "increased air control"
		"attribute_class" : "mod_air_control"
		"description_string" : "#Attrib_AirControl"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[612] = {

		"name" : "rocket launch impulse"
		"attribute_class" : "mod_rocket_launch_impulse"
		"description_string" : "#Attrib_RocketLaunchImpulse"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[613] = {

		"name" : "minicritboost on kill"
		"attribute_class" : "add_onkill_minicritboost_time"
		"description_string" : "#Attrib_MiniCritBoost_OnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_kill"
		"stored_as_integer" : "0"
	},
	[614] = {

		"name" : "no metal from dispensers while active"
		"attribute_class" : "no_metal_from_dispensers_while_active"
		"description_string" : "#Attrib_NoMetalFromDispensersWhileActive"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[615] = {

		"name" : "projectile entity name"
		"attribute_class" : "projectile_entity_name"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[616] = {

		"name" : "is throwable primable"
		"attribute_class" : "is_throwable_primable"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[617] = {

		"name" : "throwable detonation time"
		"attribute_class" : "throwable_detonation_time"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[618] = {

		"name" : "throwable recharge time"
		"attribute_class" : "throwable_recharge_time"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[619] = {

		"name" : "closerange backattack minicrits"
		"attribute_class" : "closerange_backattack_minicrits"
		"description_string" : "#Attrib_BackAttackMinicrits"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[620] = {

		"name" : "torso scale"
		"attribute_class" : "torso_scale"
		"description_format" : "value_is_percentage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[621] = {

		"name" : "rocketjump attackrate bonus"
		"attribute_class" : "rocketjump_attackrate_bonus"
		"description_string" : "#Attrib_RocketJumpAttackRateBonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[622] = {

		"name" : "is throwable chargeable"
		"attribute_class" : "is_throwable_chargeable"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[630] = {

		"name" : "back headshot"
		"attribute_class" : "back_headshot"
		"description_string" : "#Attrib_BackHeadshot"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[632] = {

		"name" : "rj air bombardment"
		"attribute_class" : "rj_air_bombardment"
		"description_string" : "#Attrib_AirBombardment"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[633] = {

		"name" : "projectile particle name"
		"attribute_class" : "projectile_particle_name"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[634] = {

		"name" : "air jump on attack"
		"attribute_class" : "air_jump_on_attack"
		"description_string" : "#Attrib_AirJumpOnAttack"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[636] = {

		"name" : "sniper crit no scope"
		"attribute_class" : "sniper_crit_no_scope"
		"description_string" : "#Attrib_SniperCritNoScope"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[637] = {

		"name" : "sniper independent zoom DISPLAY ONLY"
		"attribute_class" : "sniper_independent_zoom_DISPLAY_ONLY"
		"description_string" : "#Attrib_SniperIndependentZoom"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[638] = {

		"name" : "axtinguisher properties"
		"attribute_class" : "axtinguisher_properties"
		"description_string" : "#Attrib_AxtinguisherProperties"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[639] = {

		"name" : "full charge turn control"
		"attribute_class" : "charge_turn_control"
		"description_string" : "#Attrib_ChargeTurnControlFull"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[640] = {

		"name" : "parachute attribute"
		"attribute_class" : "parachute_attribute"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[641] = {

		"name" : "taunt force weapon slot"
		"attribute_class" : "taunt_force_weapon_slot"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[642] = {

		"name" : "mini rockets"
		"attribute_class" : "mini_rockets"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[643] = {

		"name" : "rocket jump damage reduction HIDDEN"
		"attribute_class" : "rocket_jump_dmg_reduction"
		"description_string" : "#Attrib_RocketJumpDmgReduction"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[644] = {

		"name" : "clipsize increase on kill"
		"attribute_class" : "clipsize_increase_on_kill"
		"description_string" : "#Attrib_ExtraRocketsOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[645] = {

		"name" : "breadgloves properties"
		"attribute_class" : "breadgloves_properties"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[646] = {

		"name" : "taunt turn speed"
		"attribute_class" : "taunt_turn_speed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[647] = {

		"name" : "sniper fires tracer HIDDEN"
		"attribute_class" : "sniper_fires_tracer_HIDDEN"
		"description_string" : "#Attrib_Sniper_FiresTracer"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[651] = {

		"name" : "fire rate bonus with reduced health"
		"attribute_class" : "mult_postfiredelay_with_reduced_health"
		"description_string" : "#Attrib_FireRateBonusWithReducedHealth"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[661] = {

		"name" : "tag__summer2014"
		"attribute_class" : "tag__summer2014"
		"description_string" : "#Attrib_Summer2014Tag"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[662] = {

		"name" : "crate generation code"
		"attribute_class" : "crate_generation_code"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[669] = {

		"name" : "stickybomb fizzle time"
		"attribute_class" : "stickybomb_fizzle_time"
		"description_string" : "#Attrib_stickybomb_fizzle_time"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[670] = {

		"name" : "stickybomb charge rate"
		"attribute_class" : "stickybomb_charge_rate"
		"description_string" : "#Attrib_stickybomb_charge_rate"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[671] = {

		"name" : "grenade no bounce"
		"attribute_class" : "grenade_no_bounce"
		"description_string" : "#Attrib_grenade_no_bounce"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[674] = {

		"name" : "class select override vcd"
		"attribute_class" : "class_select_override_vcd"
		"attribute_type" : "string"
		"description_string" : "#Attrib_Class_Select_Override_VCD"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[675] = {

		"name" : "custom projectile model"
		"attribute_class" : "custom_projectile_model"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[676] = {

		"name" : "lose demo charge on damage when charging"
		"attribute_class" : "lose_demo_charge_on_damage_when_charging"
		"description_string" : "#Attrib_LoseDemoChargeOnDamageWhenCharging"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[681] = {

		"name" : "grenade no spin"
		"attribute_class" : "grenade_no_spin"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[684] = {

		"name" : "grenade detonation damage penalty"
		"attribute_class" : "grenade_detonation_damage_penalty"
		"description_string" : "#Attrib_GrenadeDetonationDamagePenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[687] = {

		"name" : "taunt turn acceleration time"
		"attribute_class" : "taunt_turn_acceleration_time"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[688] = {

		"name" : "taunt move acceleration time"
		"attribute_class" : "taunt_move_acceleration"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[689] = {

		"name" : "taunt move speed"
		"attribute_class" : "taunt_move_speed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[690] = {

		"name" : "shuffle crate item def min"
		"attribute_class" : "shuffle_crate_item_def_min"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[691] = {

		"name" : "shuffle crate item def max"
		"attribute_class" : "shuffle_crate_item_def_max"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[692] = {

		"name" : "limited quantity item"
		"attribute_class" : "limited_quantity_item"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[693] = {

		"name" : "SET BONUS: alien isolation xeno bonus pos"
		"attribute_class" : "alien_isolation_xeno_bonus_pos"
		"description_format" : "value_is_additive"
		"description_string" : "#Attrib_AiXenoSetBonusPos"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[694] = {

		"name" : "SET BONUS: alien isolation xeno bonus neg"
		"attribute_class" : "alien_isolation_xeno_bonus_neg"
		"description_format" : "value_is_additive"
		"description_string" : "#Attrib_AiXenoSetBonusNeg"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[695] = {

		"name" : "SET BONUS: alien isolation merc bonus pos"
		"attribute_class" : "alien_isolation_merc_bonus_pos"
		"description_format" : "value_is_additive"
		"description_string" : "#Attrib_AiMercSetBonusPos"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[696] = {

		"name" : "SET BONUS: alien isolation merc bonus neg"
		"attribute_class" : "alien_isolation_merc_bonus_neg"
		"description_format" : "value_is_additive"
		"description_string" : "#Attrib_AiMercSetBonusNeg"
		"hidden" : "0"
		"is_set_bonus" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[698] = {

		"name" : "disable weapon switch"
		"attribute_class" : "disable_weapon_switch"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "1"
	},
	[699] = {

		"name" : "hand scale"
		"attribute_class" : "hand_scale"
		"description_format" : "value_is_percentage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[700] = {

		"name" : "display duck leaderboard"
		"attribute_class" : "display_duck_leaderboard"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[701] = {

		"name" : "duck rating"
		"attribute_class" : "duck_rating"
		"description_string" : "#Attrib_duck_rating"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[702] = {

		"name" : "duck badge level"
		"attribute_class" : "duck_badge_level"
		"description_string" : "#Attrib_duck_badge_level"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[703] = {

		"name" : "tag__eotlearlysupport"
		"attribute_class" : "tag__eotlearlysupport"
		"description_string" : "#Attrib_eotl_early_supporter"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[704] = {

		"name" : "unlimited quantity hidden"
		"attribute_class" : "unlimited_quantity"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[705] = {

		"name" : "duckstreaks active"
		"attribute_class" : "duckstreaks_active"
		"description_string" : "#Attrib_duckstreaks"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[708] = {

		"name" : "panic_attack"
		"attribute_class" : "panic_attack"
		"description_string" : "#Attrib_PanicAttack"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[709] = {

		"name" : "panic_attack_negative"
		"attribute_class" : "panic_attack_negative"
		"description_string" : "#Attrib_PanicAttackNegative"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[710] = {

		"name" : "auto fires full clip penalty"
		"attribute_class" : "auto_fires_full_clip"
		"description_string" : "#Attrib_AutoFiresFullClipNegative"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[711] = {

		"name" : "auto fires when full"
		"attribute_class" : "auto_fires_when_full"
		"description_string" : "#Attrib_AutoFiresWhenFull"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[712] = {

		"name" : "force weapon switch"
		"attribute_class" : "force_weapon_switch"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[719] = {

		"name" : "weapon_uses_stattrak_module"
		"attribute_class" : "weapon_uses_stattrak_module"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "strange"
	},
	[723] = {

		"name" : "is_operation_pass"
		"attribute_class" : "is_operation_pass"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[724] = {

		"name" : "weapon_stattrak_module_scale"
		"attribute_class" : "weapon_stattrak_module_scale"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[725] = {

		"name" : "set_item_texture_wear"
		"attribute_class" : "set_item_texture_wear"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"can_affect_market_name" : "1"
		"stored_as_integer" : "0"
	},
	[726] = {

		"name" : "cloak_consume_on_feign_death_activate"
		"attribute_class" : "cloak_consume_on_feign_death_activate"
		"description_string" : "#Attrib_ConsumeCloakFeignDeath"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[727] = {

		"name" : "stickybomb_charge_damage_increase"
		"attribute_class" : "stickybomb_charge_damage_increase"
		"description_string" : "#Attrib_stickybomb_charge_damage_increase"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[728] = {

		"name" : "NoCloakWhenCloaked"
		"attribute_class" : "NoCloakWhenCloaked"
		"description_string" : "#Attrib_NoCloakWhenCloaked"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[729] = {

		"name" : "ReducedCloakFromAmmo"
		"attribute_class" : "ReducedCloakFromAmmo"
		"description_string" : "#Attrib_ReducedCloakFromAmmo"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[730] = {

		"name" : "elevate to unusual if applicable"
		"attribute_class" : "elevate_to_unusual_if_applicable"
		"description_string" : "#Attrib_ElevateQuality"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[731] = {

		"name" : "weapon_allow_inspect"
		"attribute_class" : "weapon_allow_inspect"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[732] = {

		"name" : "metal_pickup_decreased"
		"attribute_class" : "mult_metal_pickup"
		"description_string" : "#Attrib_metal_pickup_decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[733] = {

		"name" : "lose hype on take damage"
		"attribute_class" : "lose_hype_on_take_damage"
		"description_string" : "#Attrib_losehypeontakedamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[734] = {

		"name" : "healing received penalty"
		"attribute_class" : "mult_healing_received"
		"description_string" : "#Attrib_HealingReceivedPenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[735] = {

		"name" : "crit_vs_burning_FLARES_DISPLAY_ONLY"
		"attribute_class" : "crit_vs_burning_FLARES_DISPLAY_ONLY"
		"description_string" : "#Attrib_CritVsBurning"
		"description_format" : "value_is_or"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[736] = {

		"name" : "speed_boost_on_kill"
		"attribute_class" : "speed_boost_on_kill"
		"description_string" : "#Attrib_SpeedBoostOnKill"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[737] = {

		"name" : "speed_boost_on_hit"
		"attribute_class" : "speed_boost_on_hit"
		"description_string" : "#Attrib_SpeedBoostOnHit"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[738] = {

		"name" : "spunup_damage_resistance"
		"attribute_class" : "spunup_damage_resistance"
		"description_string" : "#Attrib_spup_damage_resistance"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[739] = {

		"name" : "ubercharge overheal rate penalty"
		"attribute_class" : "mult_medigun_overheal_uberchargerate"
		"description_string" : "#Attrib_OverhealUberchargeRate_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[740] = {

		"name" : "reduced_healing_from_medics"
		"attribute_class" : "mult_healing_from_medics"
		"description_string" : "#Attrib_HealingFromMedics_Negative"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[741] = {

		"name" : "health on radius damage"
		"attribute_class" : "add_health_on_radius_damage"
		"description_string" : "#Attrib_HealthOnRadiusDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[742] = {

		"name" : "style changes on strange level"
		"attribute_class" : "style_changes_on_strange_level"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[743] = {

		"name" : "cannot restore"
		"attribute_class" : "cannot_restore"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[744] = {

		"name" : "hide crate series number"
		"attribute_class" : "hide_crate_series_number"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[745] = {

		"name" : "has team color paintkit"
		"attribute_class" : "has_team_color_paintkit"
		"description_string" : "#Attrib_HasTeamColorPaintkit"
		"description_format" : "value_is_additive"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[746] = {

		"name" : "cosmetic_allow_inspect"
		"attribute_class" : "cosmetic_allow_inspect"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[747] = {

		"name" : "hat only unusual effect"
		"attribute_class" : "hat_only_unusual_effect"
		"description_format" : "value_is_particle_index"
		"hidden" : "1"
		"effect_type" : "unusual"
		"stored_as_integer" : "0"
		"can_affect_market_name" : "1"
	},
	[748] = {

		"name" : "items traded in for"
		"attribute_class" : "items_traded_in_for"
		"description_string" : "#Attrib_ItemsTradedIn"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[749] = {

		"name" : "texture_wear_default"
		"attribute_class" : "texture_wear_default"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[750] = {

		"name" : "taunt only unusual effect"
		"attribute_class" : "taunt_only_unusual_effect"
		"description_format" : "value_is_particle_index"
		"hidden" : "1"
		"effect_type" : "unusual"
		"can_affect_market_name" : "1"
		"stored_as_integer" : "1"
	},
	[751] = {

		"name" : "deactive date"
		"attribute_class" : "deactive_date"
		"description_format" : "value_is_date"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
	},
	[752] = {

		"name" : "is giger counter"
		"attribute_class" : "is_giger_counter"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[753] = {

		"name" : "hide_strange_prefix"
		"attribute_class" : "hide_strange_prefix"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[754] = {

		"name" : "always_transmit_so"
		"attribute_class" : "always_transmit_so"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[760] = {

		"name" : "allow_halloween_offering"
		"attribute_class" : "allow_halloween_offering"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[762] = {

		"name" : "cannot_transmute"
		"attribute_class" : "cannot_transmute"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[772] = {

		"name" : "single wep holster time increased"
		"attribute_class" : "mult_switch_from_wep_deploy_time"
		"description_string" : "#Attrib_SingleWepHolsterPenalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[773] = {

		"name" : "single wep deploy time increased"
		"attribute_class" : "mult_single_wep_deploy_time"
		"description_string" : "#Attrib_SingleWepDeployPenalty"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[774] = {

		"name" : "charge time decreased"
		"attribute_class" : "mod_charge_time"
		"description_string" : "#Attrib_ChargeTime_Decrease"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
	},
	[775] = {

		"name" : "dmg penalty vs buildings"
		"attribute_class" : "mult_dmg_vs_buildings"
		"description_string" : "#Attrib_DmgVsBuilding_decreased"
		"description_format" : "value_is_percentage"
		"effect_type" : "negative"
	},
	[776] = {

		"name" : "charge impact damage decreased"
		"attribute_class" : "charge_impact_damage"
		"description_string" : "#Attrib_ChargeImpactDamageDecreased"
		"description_format" : "value_is_percentage"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[777] = {

		"name" : "non economy"
		"attribute_class" : "non_economy"
		"description_string" : "#Attrib_NonEconomyItem"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[778] = {

		"name" : "charge meter on hit"
		"attribute_class" : "charge_meter_on_hit"
		"description_string" : "#Attrib_HitsRefillMeter"
		"description_format" : "value_is_additive_percentage"
		"effect_type" : "positive"
	},
	[779] = {

		"name" : "minicrit_boost_when_charged"
		"attribute_class" : "minicrit_boost_when_charged"
		"description_string" : "#Attrib_MiniCritBoost_WhenCharged"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[780] = {

		"name" : "minicrit_boost_charge_rate"
		"attribute_class" : "minicrit_boost_charge_rate"
		"description_string" : "#Attrib_MiniCritBoost_ChargeRate"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[781] = {

		"name" : "is_a_sword"
		"attribute_class" : "is_a_sword"
		"description_string" : "#Attrib_IsASword"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
	},
	[782] = {

		"name" : "ammo gives charge"
		"attribute_class" : "ammo_gives_charge"
		"description_string" : "#Attrib_AmmoGivesCharge"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[783] = {

		"name" : "extinguish restores health"
		"attribute_class" : "extinguish_restores_health"
		"description_string" : "#Attrib_ExtinguishRestoresHealth"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[784] = {

		"name" : "extinguish reduces cooldown"
		"attribute_class" : "extinguish_reduces_cooldown"
		"description_string" : "#Attrib_ExtinguishReducesCooldown"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[785] = {

		"name" : "cannot giftwrap"
		"attribute_class" : "cannot_giftwrap"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[786] = {

		"name" : "tool needs giftwrap"
		"attribute_class" : "tool_needs_giftwrap"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[787] = {

		"name" : "fuse bonus"
		"attribute_class" : "fuse_mult"
		"description_string" : "#Attrib_Fuse_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[788] = {

		"name" : "move speed bonus shield required"
		"attribute_class" : "mult_player_movespeed_shieldrequired"
		"description_string" : "#Attrib_MoveSpeed_Bonus_ShieldRequired"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[789] = {

		"name" : "damage bonus bullet vs sentry target"
		"attribute_class" : "mult_dmg_bullet_vs_sentry_target"
		"description_string" : "#Attrib_DamageBonusAgainstSentryTarget"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[790] = {

		"name" : "mod teleporter cost"
		"attribute_class" : "mod_teleporter_cost"
		"description_string" : "#Attrib_TeleporterBuildCost"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[791] = {

		"name" : "damage blast push"
		"attribute_class" : "damage_blast_push"
		"description_string" : "#Attrib_DamageBlastPush"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[792] = {

		"name" : "move speed bonus resource level"
		"attribute_class" : "mult_player_movespeed_resource_level"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[793] = {

		"name" : "hype on damage"
		"attribute_class" : "hype_on_damage"
		"description_string" : "#Attrib_HypeOnDamage"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[794] = {

		"name" : "dmg taken from fire reduced on active"
		"attribute_class" : "mult_dmgtaken_from_fire_active"
		"description_string" : "#Attrib_DmgTaken_From_Fire_ReducedActive"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[795] = {

		"name" : "damage bonus vs burning"
		"attribute_class" : "mult_dmg_vs_burning"
		"description_string" : "#Attrib_DmgBonusVsBurning"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[796] = {

		"name" : "min_viewmodel_offset"
		"attribute_class" : "min_viewmodel_offset"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[797] = {

		"name" : "dmg pierces resists absorbs"
		"attribute_class" : "mod_pierce_resists_absorbs"
		"description_string" : "#Attrib_PierceResists"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[798] = {

		"name" : "energy buff dmg taken multiplier"
		"attribute_class" : "energy_buff_dmg_taken_multiplier"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[799] = {

		"name" : "lose revenge crits on death DISPLAY ONLY"
		"attribute_class" : "lose_revenge_crits_on_death_DISPLAY_ONLY"
		"description_string" : "#Attrib_LoseRevengeCritsOnDeath"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[800] = {

		"name" : "patient overheal penalty"
		"attribute_class" : "mult_patient_overheal_penalty"
		"description_string" : "#Attrib_PatientOverheal_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[801] = {

		"name" : "item_meter_charge_rate"
		"attribute_class" : "item_meter_charge_rate"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[804] = {

		"name" : "mult_spread_scale_first_shot"
		"attribute_class" : "mult_spread_scale_first_shot"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[805] = {

		"name" : "unusualifier_attribute_template_name"
		"attribute_class" : "unusualifier_attribute_template_name"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[806] = {

		"name" : "tool_target_item_icon_offset"
		"attribute_class" : "tool_target_item_icon_offset"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[807] = {

		"name" : "add_head_on_kill"
		"attribute_class" : "add_head_on_kill"
		"description_string" : "#Attrib_AddHeadOnKill"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[808] = {

		"name" : "mult_spread_scales_consecutive"
		"attribute_class" : "mult_spread_scales_consecutive"
		"description_string" : "#Attrib_SpreadPenaltyScalesCons"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[809] = {

		"name" : "fixed_shot_pattern"
		"attribute_class" : "fixed_shot_pattern"
		"description_string" : "#Attrib_FixedShotPattern"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[810] = {

		"name" : "mod_cloak_no_regen_from_items"
		"attribute_class" : "mod_cloak_no_regen_from_items"
		"description_string" : "#Attrib_NoCloakFromAmmo"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[811] = {

		"name" : "ubercharge_preserved_on_spawn_max"
		"attribute_class" : "ubercharge_preserved_on_spawn_max"
		"description_string" : "#Attrib_UberchargeSavedOnHit"
		"description_format" : "value_is_additive_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
	},
	[812] = {

		"name" : "mod_air_control_blast_jump"
		"attribute_class" : "mod_air_control_blast_jump"
		"description_string" : "#Attrib_AirControlBlastJump"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[813] = {

		"name" : "spunup_push_force_immunity"
		"attribute_class" : "spunup_push_force_immunity"
		"description_string" : "#Attrib_SpunUpPushForceResist"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[814] = {

		"name" : "mod_mark_attacker_for_death"
		"attribute_class" : "mod_mark_attacker_for_death"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[815] = {

		"name" : "use_model_cache_icon"
		"attribute_class" : "use_model_cache_icon"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[816] = {

		"name" : "mod_disguise_consumes_cloak"
		"attribute_class" : "mod_disguise_consumes_cloak"
		"description_string" : "#Attrib_DisguiseConsumesCloak"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"stored_as_integer" : "1"
		"effect_type" : "negative"
	},
	[817] = {

		"name" : "inspect_viewmodel_offset"
		"attribute_class" : "inspect_viewmodel_offset"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
	},
	[818] = {

		"name" : "is_passive_weapon"
		"attribute_class" : "is_passive_weapon"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[819] = {

		"name" : "no_jump"
		"attribute_class" : "no_jump"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[820] = {

		"name" : "no_duck"
		"attribute_class" : "no_duck"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[821] = {

		"name" : "no_attack"
		"attribute_class" : "no_attack"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[822] = {

		"name" : "airblast_destroy_projectile"
		"attribute_class" : "airblast_destroy_projectile"
		"description_string" : "#Attrib_AirblastDestroyProjectile"
		"description_format" : "value_is_additive"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[823] = {

		"name" : "airblast_pushback_disabled"
		"attribute_class" : "airblast_pushback_disabled"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[824] = {

		"name" : "airblast_pushback_no_stun"
		"attribute_class" : "airblast_pushback_no_stun"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[825] = {

		"name" : "airblast_pushback_no_viewpunch"
		"attribute_class" : "airblast_pushback_no_viewpunch"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[826] = {

		"name" : "airblast_deflect_projectiles_disabled"
		"attribute_class" : "airblast_deflect_projectiles_disabled"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[827] = {

		"name" : "airblast_put_out_teammate_disabled"
		"attribute_class" : "airblast_put_out_teammate_disabled"
		"description_format" : "value_is_additive"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[828] = {

		"name" : "afterburn duration penalty"
		"attribute_class" : "afterburn_duration_mult"
		"description_format" : "value_is_percentage"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[829] = {

		"name" : "afterburn duration bonus"
		"attribute_class" : "afterburn_duration_mult"
		"description_format" : "value_is_percentage"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[830] = {

		"name" : "aoe_deflection"
		"attribute_class" : "aoe_deflection"
		"description_format" : "value_is_additive"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[831] = {

		"name" : "mult_end_flame_size"
		"attribute_class" : "mult_end_flame_size"
		"description_format" : "value_is_percentage"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"hidden" : "1"
	},
	[832] = {

		"name" : "airblast_give_teammate_speed_boost"
		"attribute_class" : "airblast_give_teammate_speed_boost"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[833] = {

		"name" : "airblast_turn_projectile_to_ammo"
		"attribute_class" : "airblast_turn_projectile_to_ammo"
		"description_format" : "value_is_additive"
		"effect_type" : "neutral"
		"stored_as_integer" : "0"
	},
	[834] = {

		"name" : "paintkit_proto_def_index"
		"attribute_class" : "paintkit_proto_def_index"
		"description_format" : "value_is_additive"
		"effect_type" : "neutral"
		"stored_as_integer" : "1"
		"can_affect_market_name" : "1"
	},
	[835] = {

		"name" : "taunt_attr_player_invis_percent"
		"attribute_class" : "taunt_attr_player_invis_percent"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[837] = {

		"name" : "redirected_flame_size_mult"
		"attribute_class" : "redirected_flame_size_mult"
		"description_format" : "value_is_percentage"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[838] = {

		"name" : "flame_reflect_on_collision"
		"attribute_class" : "flame_reflect_on_collision"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[839] = {

		"name" : "flame_spread_degree"
		"attribute_class" : "flame_spread_degree"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[840] = {

		"name" : "holster_anim_time"
		"attribute_class" : "holster_anim_time"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[841] = {

		"name" : "flame_gravity"
		"attribute_class" : "flame_gravity"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[842] = {

		"name" : "flame_ignore_player_velocity"
		"attribute_class" : "flame_ignore_player_velocity"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[843] = {

		"name" : "flame_drag"
		"attribute_class" : "flame_drag"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[844] = {

		"name" : "flame_speed"
		"attribute_class" : "flame_speed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[845] = {

		"name" : "grenades1_resupply_denied"
		"attribute_class" : "grenades1_resupply_denied"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[846] = {

		"name" : "grenades2_resupply_denied"
		"attribute_class" : "grenades2_resupply_denied"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[847] = {

		"name" : "grenades3_resupply_denied"
		"attribute_class" : "grenades3_resupply_denied"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[848] = {

		"name" : "item_meter_resupply_denied"
		"attribute_class" : "item_meter_resupply_denied"
		"description_string" : "#Attrib_MeterResupplyDenied"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[851] = {

		"name" : "mult_player_movespeed_active"
		"attribute_class" : "mult_player_movespeed_active"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[852] = {

		"name" : "mult_dmgtaken_active"
		"attribute_class" : "mult_dmgtaken_active"
		"description_string" : "#Attrib_DmgTaken_Increased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[853] = {

		"name" : "mult_patient_overheal_penalty_active"
		"attribute_class" : "mult_patient_overheal_penalty_active"
		"description_string" : "#Attrib_PatientOverheal_Penalty"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[854] = {

		"name" : "mult_health_fromhealers_penalty_active"
		"attribute_class" : "mult_health_fromhealers_penalty_active"
		"description_string" : "#Attrib_HealthFromHealers_Reduced"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},
	[855] = {

		"name" : "mod_maxhealth_drain_rate"
		"attribute_class" : "mod_maxhealth_drain_rate"
		"description_string" : "#Attrib_MaxHealthDrain"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
	},
	[856] = {

		"name" : "item_meter_charge_type"
		"attribute_class" : "item_meter_charge_type"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[859] = {

		"name" : "max_flame_reflection_count"
		"attribute_class" : "max_flame_reflection_count"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[860] = {

		"name" : "flame_reflection_add_life_time"
		"attribute_class" : "flame_reflection_add_life_time"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[861] = {

		"name" : "reflected_flame_dmg_reduction"
		"attribute_class" : "reflected_flame_dmg_reduction"
		"description_format" : "value_is_percentage"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[862] = {

		"name" : "flame_lifetime"
		"attribute_class" : "flame_lifetime"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[863] = {

		"name" : "flame_random_life_time_offset"
		"attribute_class" : "flame_random_life_time_offset"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[865] = {

		"name" : "flame_up_speed"
		"attribute_class" : "flame_up_speed"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[866] = {

		"name" : "custom_paintkit_seed_lo"
		"attribute_class" : "custom_paintkit_seed_lo"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[867] = {

		"name" : "custom_paintkit_seed_hi"
		"attribute_class" : "custom_paintkit_seed_hi"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[868] = {

		"name" : "crit_dmg_falloff"
		"attribute_class" : "crit_dmg_falloff"
		"description_string" : "#Attrib_Dmg_Crit_Falloff"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[869] = {

		"name" : "crits_become_minicrits"
		"attribute_class" : "crits_become_minicrits"
		"description_string" : "#Attrib_CritsBecomeMinicrits"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[870] = {

		"name" : "falling_impact_radius_pushback"
		"attribute_class" : "falling_impact_radius_pushback"
		"description_string" : "#Attrib_ImpactPushback"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[871] = {

		"name" : "falling_impact_radius_stun"
		"attribute_class" : "falling_impact_radius_stun"
		"description_string" : "#Attrib_ImpactStun"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[872] = {

		"name" : "thermal_thruster_air_launch"
		"attribute_class" : "thermal_thruster_air_launch"
		"description_string" : "#Attrib_ThermalThrusterAirLaunch"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[873] = {

		"name" : "thermal_thruster"
		"attribute_class" : "thermal_thruster"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[874] = {

		"name" : "mult_item_meter_charge_rate"
		"attribute_class" : "mult_item_meter_charge_rate"
		"description_string" : "#Attrib_ChargeMeterRateMult"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"stored_as_integer" : "0"
	},
	[875] = {

		"name" : "explode_on_ignite"
		"attribute_class" : "explode_on_ignite"
		"description_string" : "#Attrib_ExplodeOnIgnite"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"stored_as_integer" : "0"
	},
	[876] = {

		"name" : "lunchbox healing decreased"
		"attribute_class" : "lunchbox_healing_scale"
		"description_string" : "#Attrib_LunchboxHealingDecreased"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[877] = {

		"name" : "speed_boost_on_hit_enemy"
		"attribute_class" : "speed_boost_on_hit_enemy"
		"description_string" : "#Attrib_SpeedBoostEnemy"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[878] = {

		"name" : "item_meter_starts_empty_DISPLAY_ONLY"
		"attribute_class" : "item_meter_starts_empty_DISPLAY_ONLY"
		"description_string" : "#Attrib_MeterStartsEmpty"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[879] = {

		"name" : "item_meter_charge_type_3_DISPLAY_ONLY"
		"attribute_class" : "item_meter_charge_type_3_DISPLAY_ONLY"
		"description_string" : "#Attrib_MeterChargeType3"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[880] = {

		"name" : "repair health to metal ratio DISPLAY ONLY"
		"attribute_class" : "repair_health_to_metal_ratio_DISPLAY_ONLY"
		"description_string" : "#Attrib_RepairHealthToMetalRatio"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[881] = {

		"name" : "health drain medic"
		"attribute_class" : "add_health_regen"
		"description_string" : "#Attrib_HealthDrainMedic"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
	},


	[1000] = {

		"name" : "CARD: damage bonus"
		"attribute_class" : "mult_dmg"
		"description_string" : "#Attrib_DamageDone_Positive"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"is_user_generated" : "1"
	},
	[1001] = {

		"name" : "CARD: dmg taken from bullets reduced"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Reduced"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
	},
	[1002] = {

		"name" : "CARD: move speed bonus"
		"attribute_class" : "mult_player_movespeed"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"description_format" : "value_is_percentage"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
	},
	[1003] = {

		"name" : "CARD: health regen"
		"attribute_class" : "add_health_regen"
		"description_string" : "#Attrib_HealthRegen"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
	},
	[1004] = {

		"name" : "SPELL: set item tint RGB"
		"attribute_class" : "set_item_tint_rgb_override"
		"description_string" : "#Attrib_HalloweenSpell_RGB"
		"description_format" : "value_is_from_lookup_table"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1005] = {

		"name" : "SPELL: set Halloween footstep type"
		"attribute_class" : "halloween_footstep_type"
		"description_string" : "#Attrib_HalloweenSpell_Footstep"
		"description_format" : "value_is_from_lookup_table"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1006] = {

		"name" : "SPELL: Halloween voice modulation"
		"attribute_class" : "halloween_voice_modulation"
		"description_string" : "#Attrib_HalloweenSpell_Voice"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1007] = {

		"name" : "SPELL: Halloween pumpkin explosions"
		"attribute_class" : "halloween_pumpkin_explosions"
		"description_string" : "#Attrib_HalloweenSpell_PumpkinBombs"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1008] = {

		"name" : "SPELL: Halloween green flames"
		"attribute_class" : "halloween_green_flames"
		"description_string" : "#Attrib_HalloweenSpell_GreenFlames"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1009] = {

		"name" : "SPELL: Halloween death ghosts"
		"attribute_class" : "halloween_death_ghosts"
		"description_string" : "#Attrib_HalloweenSpell_DeathGhosts"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "2"
	},
	[1030] = {

		"name" : "Attack not cancel charge"
		"attribute_class" : "attack_not_cancel_charge"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
		"is_user_generated" : "1"
	},
	[2000] = {

		"name" : "recipe component defined item 1"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2001] = {

		"name" : "recipe component defined item 2"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2002] = {

		"name" : "recipe component defined item 3"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2003] = {

		"name" : "recipe component defined item 4"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2004] = {

		"name" : "recipe component defined item 5"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2005] = {

		"name" : "recipe component defined item 6"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2006] = {

		"name" : "recipe component defined item 7"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2007] = {

		"name" : "recipe component defined item 8"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2008] = {

		"name" : "recipe component defined item 9"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2009] = {

		"name" : "recipe component defined item 10"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
		"can_affect_market_name" : "1"
	},
	[2010] = {

		"name" : "start drop date"
		"attribute_class" : "start_drop_date"
		"attribute_type" : "string"
		"description_format" : "value_is_date"
	},
	[2011] = {

		"name" : "end drop date"
		"attribute_class" : "end_drop_date"
		"attribute_type" : "string"
		"description_format" : "value_is_date"
	},
	[2012] = {

		"name" : "tool target item"
		"attribute_class" : "tool_target_item"
		"hidden" : "1"
		"can_affect_market_name" : "1"
	},
	[2013] = {

		"name" : "killstreak effect"
		"attribute_class" : "killstreak_effect"
		"description_string" : "#Attrib_KillStreakEffect"
		"description_format" : "value_is_killstreakeffect_index"
		"stored_as_integer" : "0"
		"effect_type" : "positive"
		"can_affect_recipe_component_name" : "1"
	},
	[2014] = {

		"name" : "killstreak idleeffect"
		"attribute_class" : "killstreak_idleeffect"
		"description_string" : "#Attrib_KillStreakIdleEffect"
		"description_format" : "value_is_killstreak_idleeffect_index"
		"stored_as_integer" : "0"
		"effect_type" : "positive"
		"can_affect_recipe_component_name" : "1"
	},

	[2015] = {

		"name" : "spellbook page attr id"
		"attribute_class" : "spellbook_page_attr_id"
		"hidden" : "1"
	},
	[2016] = {

		"name" : "Halloween Spellbook Page: Tumidum"
		"attribute_class" : "tf_halloween_spell_page"
		"description_string" : "#Attrib_HalloweenSpellbookPage_A"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[2017] = {

		"name" : "Halloween Spellbook Page: Gratanter"
		"attribute_class" : "tf_halloween_spell_page"
		"description_string" : "#Attrib_HalloweenSpellbookPage_B"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[2018] = {

		"name" : "Halloween Spellbook Page: Audere"
		"attribute_class" : "tf_halloween_spell_page"
		"description_string" : "#Attrib_HalloweenSpellbookPage_C"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[2019] = {

		"name" : "Halloween Spellbook Page: Congeriae"
		"attribute_class" : "tf_halloween_spell_page"
		"description_string" : "#Attrib_HalloweenSpellbookPage_D"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[2020] = {

		"name" : "Halloween Spellbook Page: Veteris"
		"attribute_class" : "tf_halloween_spell_page"
		"description_string" : "#Attrib_HalloweenSpellbookPage_E"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "1"
	},
	[2021] = {

		"name" : "additional halloween response criteria name"
		"attribute_class" : "additional_halloween_response_criteria_name"
		"attribute_type" : "string"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
	},
	[2022] = {

		"name" : "loot rarity"
		"attribute_class" : "loot_rarity"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[2023] = {

		"name" : "quality text override"
		"attribute_class" : "quality_text_override"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2024] = {

		"name" : "item name text override"
		"attribute_class" : "item_name_text_override"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2025] = {

		"name" : "killstreak tier"
		"attribute_class" : "killstreak_tier"
		"can_affect_market_name" : "1"
		"description_string" : "#Attrib_KillStreakTier"
		"description_format" : "value_is_additive"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[2026] = {

		"name" : "wide item level"
		"attribute_class" : "wide_item_level"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[2027] = {

		"name" : "is australium item"
		"attribute_class" : "is_australium_item"
		"can_affect_market_name" : "1"
		"hidden" : "1"
		"description_format" : "value_is_additive"
		"stored_as_integer" : "1"
	},
	[2028] = {

		"name" : "is marketable"
		"attribute_class" : "is_marketable"
		"hidden" : "1"
	},
	[2029] = {

		"name" : "allowed in medieval mode"
		"attribute_class" : "allowed_in_medieval_mode"
		"hidden" : "1"
	},
	[2030] = {

		"name" : "crit on hard hit"
		"attribute_class" : "crit_on_hard_hit"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"stored_as_integer" : "0"
	},
	[2031] = {

		"name" : "series number"
		"attribute_class" : "series_number"
		"hidden" : "1"
		"can_affect_market_name" : "1"
	},
	[2032] = {

		"name" : "recipe no partial complete"
		"attribute_class" : "recipe_no_partial_complete"
		"hidden" : "1"
	},
	[2034] = {

		"name" : "kill refills meter"
		"attribute_class" : "kill_refills_meter"
		"description_string" : "#Attrib_KillsRefillMeter"
		"description_format" : "value_is_additive_percentage"
		"stored_as_integer" : "0"
		"effect_type" : "positive"
	},
	[2035] = {

		"name" : "random drop line item unusual chance"
		"hidden" : "1"
	},
	[2036] = {

		"name" : "random drop line item unusual list"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2037] = {

		"name" : "random drop line item 0"
		"stored_as_integer" : "1"
		"hidden" : "1"
	},
	[2038] = {

		"name" : "random drop line item 1"
		"stored_as_integer" : "1"
		"hidden" : "1"
	},
	[2039] = {

		"name" : "random drop line item 2"
		"stored_as_integer" : "1"
		"hidden" : "1"
	},
	[2040] = {

		"name" : "random drop line item 3"
		"stored_as_integer" : "1"
		"hidden" : "1"
	},
	[2041] = {

		"name" : "taunt attach particle index"
		"hidden" : "0"
		"description_string" : "#Attrib_AttachedParticle"
		"description_format" : "value_is_particle_index"
		"effect_type" : "unusual"
		"stored_as_integer" : "1"
		"can_affect_market_name" : "1"
	},
	[2042] = {

		"name" : "loot list name"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2043] = {

		"name" : "upgrade rate decrease"
		"attribute_class" : "upgrade_rate_mod"
		"description_string" : "#Attrib_UpgradeRate_Decreased"
		"description_format" : "value_is_inverted_percentage"
		"hidden" : "0"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[2044] = {

		"name" : "can shuffle crate contents"
		"hidden" : "1"
	},
	[2045] = {

		"name" : "random drop line item footer desc"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2046] = {

		"name" : "is commodity"
		"hidden" : "1"
	},
	[2048] = {

		"name" : "voice pitch scale"
		"attribute_class" : "voice_pitch_scale"
		"description_format" : "value_is_percentage"
		"description_string" : "#Attrib_NoDoubleJump"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "negative"
		"stored_as_integer" : "0"
	},
	[2049] = {

		"name" : "gunslinger punch combo"
		"attribute_class" : "gunslinger_punch_combo"
		"description_format" : "value_is_additive"
		"description_string" : "#Attrib_GunslingerPunchCombo"
		"effect_type" : "positive"
	},
	[2050] = {

		"name" : "cannot delete"
		"hidden" : "1"
	},
	[2051] = {

		"name" : "quest loaner id low"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[2052] = {

		"name" : "quest loaner id hi"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[2053] = {

		"name" : "is_festivized"
		"attribute_class" : "is_festivized"
		"description_string" : "#Attrib_IsFestivized"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "unusual"
		"can_affect_market_name" : "1"
	},
	[2054] = {

		"name" : "fire particle blue"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2055] = {

		"name" : "fire particle red"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2056] = {

		"name" : "fire particle blue crit"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2057] = {

		"name" : "fire particle red crit"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2058] = {

		"name" : "meter_label"
		"attribute_type" : "string"
		"hidden" : "1"
	},
	[2059] = {

		"name" : "item_meter_damage_for_full_charge"
		"attribute_class" : "item_meter_damage_for_full_charge"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"stored_as_integer" : "0"
	},
	[2062] = {

		"name" : "airblast cost scale hidden"
		"attribute_class" : "mult_airblast_cost"
		"hidden" : "1"
		"description_format" : "value_is_percentage"
		"stored_as_integer" : "0"
	},
	[2063] = {

		"name" : "dragons fury positive properties"
		"attribute_class" : "dragons_fury_positive_properties"
		"description_string" : "#TF_Weapon_DragonsFury_PositiveDesc"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[2064] = {

		"name" : "dragons fury negative properties"
		"attribute_class" : "dragons_fury_negative_properties"
		"description_string" : "#TF_Weapon_DragonsFury_NegativeDesc"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "negative"
	},
	[2065] = {

		"name" : "dragons fury neutral properties"
		"attribute_class" : "dragons_fury_neutral_properties"
		"description_string" : "#TF_Weapon_DragonsFury_NeutralDesc"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "neutral"
	},
	[2066] = {

		"name" : "force center wrap"
		"hidden" : "1"
	},
	[2067] = {

		"name" : "attack_minicrits_and_consumes_burning"
		"attribute_class" : "attack_minicrits_and_consumes_burning"
		"description_string" : "#Attrib_ConsumesBurning"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
	},
	[2068] = {

		"name" : "is winter case"
		"hidden" : "1"
	},

	[3000] = {

		"name" : "item slot criteria 1"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3001] = {

		"name" : "item in slot 1"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3002] = {

		"name" : "item slot criteria 2"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3003] = {

		"name" : "item in slot 2"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3004] = {

		"name" : "item slot criteria 3"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3005] = {

		"name" : "item in slot 3"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3006] = {

		"name" : "item slot criteria 4"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3007] = {

		"name" : "item in slot 4"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3008] = {

		"name" : "item slot criteria 5"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3009] = {

		"name" : "item in slot 5"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3010] = {

		"name" : "item slot criteria 6"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3011] = {

		"name" : "item in slot 6"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3012] = {

		"name" : "item slot criteria 7"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3013] = {

		"name" : "item in slot 7"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3014] = {

		"name" : "item slot criteria 8"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	},
	[3015] = {

		"name" : "item in slot 8"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	},
	[3016] = {

		"name" : "quest earned standard points"
		"attribute_class" : "quest_earned_standard_points"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[3017] = {

		"name" : "quest earned bonus points"
		"attribute_class" : "quest_earned_bonus_points"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
	[3018] = {

		"name" : "item drop wave"
		"attribute_class" : "item_drop_wave"
		"hidden" : "1"
		"stored_as_integer" : "1"
	},
}

PopExtItems.GenerateItemAttributeTable <- function() {

	local x = {}
	foreach ( k, v in FromItemsGame ) {

		v.index <- k.tostring()
		x[v.name] <- v
	}
	local filetable = ""
	foreach( k, v in x ) {

		filetable = format( "%s\n\t\"%s\" : {\n", filetable, k )
		// filetable += "\n\t"+k+" : {\n"
			foreach( a, b in v )
				filetable = format( "%s\t\t\"%s\" : \"%s\"\n", filetable, a, b )
				// filetable += "\t\t"+a + " : " + b + "\n"
		filetable += "\t}\n"
	}

	StringToFile( "attribute_map.nut", format( "::PopExtItems.Attributes <- {\n%s\n}", filetable ) )
}

// PopExtItems.GenerateItemAttributeTable()

PopExtItems.Attributes <- {

	"item in slot 5" : {
		"index" : "3009"
		"name" : "item in slot 5"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"mod flamethrower back crit" : {
		"index" : "24"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_flamethrower_back_crit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ModFlamethrower_BackCrits"
		"name" : "mod flamethrower back crit"
		"hidden" : "0"
	}

	"recipe component defined item 7" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 7"
		"index" : "2006"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"item in slot 1" : {
		"index" : "3001"
		"name" : "item in slot 1"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"kill eater user 3" : {
		"effect_type" : "positive"
		"name" : "kill eater user 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "383"
		"attribute_class" : "kill_eater_user_3"
		"hidden" : "1"
	}

	"SRifle Charge rate increased" : {
		"index" : "90"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SRifleChargeRate_Increased"
		"name" : "SRifle Charge rate increased"
		"hidden" : "0"
	}

	"fists have radial buff" : {
		"index" : "30"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_FistsHaveRadialBuff"
		"name" : "fists have radial buff"
		"hidden" : "0"
	}

	"boots falling stomp" : {
		"index" : "259"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "boots_falling_stomp"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BootsFallingStomp"
		"name" : "boots falling stomp"
		"hidden" : "0"
	}

	"building cost reduction" : {
		"index" : "148"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "building_cost_reduction"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BuildingCostReduction"
		"name" : "building cost reduction"
		"hidden" : "0"
	}

	"dmg from ranged reduced" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "dmg_from_ranged"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgFromRanged_Reduced"
		"name" : "dmg from ranged reduced"
		"index" : "205"
		"hidden" : "0"
	}

	"ragdolls plasma effect" : {
		"index" : "436"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "ragdolls_plasma_effect"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "ragdolls plasma effect"
		"hidden" : "1"
	}

	"voice pitch scale" : {
		"index" : "2048"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "voice_pitch_scale"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoDoubleJump"
		"name" : "voice pitch scale"
		"hidden" : "1"
	}

	"fixed_shot_pattern" : {
		"index" : "809"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "fixed_shot_pattern"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FixedShotPattern"
		"name" : "fixed_shot_pattern"
		"hidden" : "0"
	}

	"mod crit while airborne" : {
		"index" : "267"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_while_airborne"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritWhileAirborne"
		"name" : "mod crit while airborne"
		"hidden" : "0"
	}

	"max health additive penalty" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_maxhealth"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxHealth_Negative"
		"name" : "max health additive penalty"
		"index" : "125"
		"hidden" : "0"
	}

	"healing mastery" : {
		"index" : "493"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "healing_mastery"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Healing_Mastery"
		"name" : "healing mastery"
		"hidden" : "0"
	}

	"engy sentry damage bonus" : {
		"index" : "287"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_engy_sentry_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EngySentryDamageBonus"
		"name" : "engy sentry damage bonus"
		"hidden" : "0"
	}

	"SET BONUS: quiet unstealth" : {
		"index" : "160"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_quiet_unstealth"
		"effect_type" : "positive"
		"description_string" : "#Attrib_QuietUnstealth"
		"name" : "SET BONUS: quiet unstealth"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"disguise no burn" : {
		"index" : "168"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "disguise_no_burn"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DisguiseNoBurn"
		"name" : "disguise no burn"
		"hidden" : "0"
	}

	"mod_disguise_consumes_cloak" : {
		"index" : "816"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_disguise_consumes_cloak"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DisguiseConsumesCloak"
		"name" : "mod_disguise_consumes_cloak"
		"hidden" : "0"
	}

	"SET BONUS: chance of hunger decrease" : {
		"index" : "401"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "chance_of_hunger_decrease"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChanceOfHungerDecrease"
		"name" : "SET BONUS: chance of hunger decrease"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"mult cloak rate" : {
		"index" : "253"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mult_cloak_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CloakRate"
		"name" : "mult cloak rate"
		"hidden" : "0"
	}

	"silent killer" : {
		"index" : "156"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_silent_killer"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SilentKiller"
		"name" : "silent killer"
		"hidden" : "0"
	}

	"charge impact damage decreased" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_ChargeImpactDamageDecreased"
		"name" : "charge impact damage decreased"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "charge_impact_damage"
		"index" : "776"
	}

	"scattergun knockback mult" : {
		"effect_type" : "positive"
		"name" : "scattergun knockback mult"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "518"
		"attribute_class" : "scattergun_knockback_mult"
		"hidden" : "1"
	}

	"has team color paintkit" : {
		"effect_type" : "neutral"
		"description_string" : "#Attrib_HasTeamColorPaintkit"
		"name" : "has team color paintkit"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "has_team_color_paintkit"
		"index" : "745"
	}

	"halloweenvision filter DISPLAY ONLY" : {
		"index" : "447"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "halloweenvision_filter_display_only"
		"effect_type" : "negative"
		"description_string" : ""
		"name" : "halloweenvision filter DISPLAY ONLY"
		"hidden" : "0"
	}

	"jarate description" : {
		"index" : "56"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "desc_jarate_description"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Jarate_Description"
		"name" : "jarate description"
		"hidden" : "0"
	}

	"taunt success sound offset" : {
		"index" : "607"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "taunt_success_sound_offset"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PhaseCloak"
		"name" : "taunt success sound offset"
		"hidden" : "1"
	}

	"medigun charge is resists" : {
		"index" : "473"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_charge_type"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Medigun_Resists"
		"name" : "medigun charge is resists"
		"hidden" : "0"
	}

	"no double jump" : {
		"index" : "49"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_scout_doublejump_disabled"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoDoubleJump"
		"name" : "no double jump"
		"hidden" : "0"
	}

	"powerup duration" : {
		"index" : "272"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "powerup_duration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PowerupDuration"
		"name" : "powerup duration"
		"hidden" : "0"
	}

	"soldier model index" : {
		"index" : "133"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "desc_soldiermedal_index"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_MedalIndex_Description"
		"name" : "soldier model index"
		"hidden" : "0"
	}

	"flame size penalty" : {
		"index" : "161"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_size"
		"effect_type" : "negative"
		"description_string" : "#Attrib_FlameSize_Negative"
		"name" : "flame size penalty"
		"hidden" : "0"
	}

	"fish damage override" : {
		"effect_type" : "positive"
		"name" : "fish damage override"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "332"
		"attribute_class" : "fish_damage_override"
		"hidden" : "1"
	}

	"health from packs increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_health_frompacks"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthFromPacks_Increased"
		"name" : "health from packs increased"
		"index" : "108"
		"hidden" : "0"
	}

	"mod rage on hit bonus" : {
		"index" : "244"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "rage_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageOnHitBonus"
		"name" : "mod rage on hit bonus"
		"hidden" : "0"
	}

	"dmg falloff increased" : {
		"index" : "117"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmg_falloff"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Dmg_Falloff_Increased"
		"name" : "dmg falloff increased"
		"hidden" : "0"
	}

	"health drain" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_health_regen"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthDrain"
		"name" : "health drain"
		"index" : "129"
		"hidden" : "0"
	}

	"strange restriction type 2" : {
		"effect_type" : "positive"
		"name" : "strange restriction type 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "456"
		"attribute_class" : "strange_restriction_type_2"
		"hidden" : "1"
	}

	"halloween item" : {
		"index" : "197"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "halloween_item"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Halloween_Item"
		"name" : "halloween item"
		"hidden" : "0"
	}

	"strange score selector" : {
		"effect_type" : "positive"
		"name" : "strange score selector"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "468"
		"attribute_class" : "strange_score_selector"
		"hidden" : "1"
	}

	"vision opt in flags" : {
		"effect_type" : "positive"
		"name" : "vision opt in flags"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"index" : "406"
		"attribute_class" : "vision_opt_in_flags"
		"hidden" : "0"
	}

	"damage force reduction" : {
		"index" : "252"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "damage_force_reduction"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageForceReduction"
		"name" : "damage force reduction"
		"hidden" : "0"
	}

	"grenade detonation damage penalty" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_GrenadeDetonationDamagePenalty"
		"name" : "grenade detonation damage penalty"
		"description_format" : "value_is_percentage"
		"index" : "684"
		"attribute_class" : "grenade_detonation_damage_penalty"
		"hidden" : "0"
	}

	"Reload time decreased" : {
		"index" : "97"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_reload_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ReloadTime_Decreased"
		"name" : "Reload time decreased"
		"hidden" : "0"
	}

	"taunt turn acceleration time" : {
		"effect_type" : "positive"
		"name" : "taunt turn acceleration time"
		"description_format" : "value_is_additive"
		"index" : "687"
		"attribute_class" : "taunt_turn_acceleration_time"
		"hidden" : "1"
	}

	"taunt is highfive" : {
		"index" : "145"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "enable_misc2_highfive"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_DamageDone_Negative"
		"name" : "taunt is highfive"
		"hidden" : "1"
	}

	"sapper health bonus" : {
		"index" : "428"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sapper_health"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Health_Bonus"
		"name" : "sapper health bonus"
		"hidden" : "0"
	}

	"mod flamethrower push" : {
		"index" : "23"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_flamethrower_push_disabled"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ModFlamethrowerPush"
		"name" : "mod flamethrower push"
		"hidden" : "0"
	}

	"obsolete ammo penalty" : {
		"index" : "55"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "obsolete"
		"effect_type" : "neutral"
		"description_string" : "unused"
		"name" : "obsolete ammo penalty"
		"hidden" : "1"
	}

	"robo sapper" : {
		"index" : "320"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "robo_sapper"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RoboSapper"
		"name" : "robo sapper"
		"hidden" : "0"
	}

	"deflection size multiplier" : {
		"index" : "260"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "deflection_size_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DeflectionSizeMultiplier"
		"name" : "deflection size multiplier"
		"hidden" : "0"
	}

	"mod medic healed damage bonus" : {
		"index" : "233"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "medic_healed_damage_bonus"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MedicHealedDamageBonus"
		"name" : "mod medic healed damage bonus"
		"hidden" : "0"
	}

	"recipe no partial complete" : {
		"index" : "2032"
		"attribute_class" : "recipe_no_partial_complete"
		"hidden" : "1"
		"name" : "recipe no partial complete"
	}

	"crit vs non burning players" : {
		"index" : "408"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "or_crit_vs_not_playercond"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsNonBurning"
		"name" : "crit vs non burning players"
		"hidden" : "0"
	}

	"throwable damage" : {
		"effect_type" : "positive"
		"name" : "throwable damage"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "513"
		"attribute_class" : "throwable_damage"
		"hidden" : "1"
	}

	"sticky arm time penalty" : {
		"index" : "120"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sticky_arm_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_StickyArmTimePenalty"
		"name" : "sticky arm time penalty"
		"hidden" : "0"
	}

	"strange restriction type 1" : {
		"effect_type" : "positive"
		"name" : "strange restriction type 1"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "454"
		"attribute_class" : "strange_restriction_type_1"
		"hidden" : "1"
	}

	"force center wrap" : {
		"index" : "2066"
		"name" : "force center wrap"
		"hidden" : "1"
	}

	"strange restriction type 3" : {
		"effect_type" : "positive"
		"name" : "strange restriction type 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "496"
		"attribute_class" : "strange_restriction_type_3"
		"hidden" : "1"
	}

	"head scale" : {
		"index" : "444"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "head_scale"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoDoubleJump"
		"name" : "head scale"
		"hidden" : "0"
	}

	"rocket jump damage reduction HIDDEN" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_RocketJumpDmgReduction"
		"name" : "rocket jump damage reduction HIDDEN"
		"description_format" : "value_is_percentage"
		"index" : "643"
		"attribute_class" : "rocket_jump_dmg_reduction"
		"hidden" : "1"
	}

	"SET BONUS: alien isolation merc bonus pos" : {
		"index" : "695"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "alien_isolation_merc_bonus_pos"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AiMercSetBonusPos"
		"name" : "SET BONUS: alien isolation merc bonus pos"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"sniper no charge" : {
		"index" : "47"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "unimplemented_mod_sniper_no_charge"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SniperNoCharge"
		"name" : "sniper no charge"
		"hidden" : "0"
	}

	"crit mod disabled" : {
		"armory_desc" : "no_crits"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_crit_chance"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CritChance_Disabled"
		"name" : "crit mod disabled"
		"index" : "15"
		"hidden" : "0"
	}

	"canteen specialist" : {
		"index" : "481"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "canteen_specialist"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Canteen_Specialist"
		"name" : "canteen specialist"
		"hidden" : "0"
	}

	"inspect_viewmodel_offset" : {
		"name" : "inspect_viewmodel_offset"
		"index" : "817"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "inspect_viewmodel_offset"
		"attribute_type" : "string"
	}

	"SRifle Charge rate decreased" : {
		"index" : "91"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SRifleChargeRate_Decreased"
		"name" : "SRifle Charge rate decreased"
		"hidden" : "0"
	}

	"makers mark id" : {
		"index" : "228"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "makers_mark_id"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MakersMark"
		"name" : "makers mark id"
		"hidden" : "1"
	}

	"decapitate type" : {
		"index" : "219"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "decapitate_type"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageDone_Negative"
		"name" : "decapitate type"
		"hidden" : "1"
	}

	"clip size upgrade atomic" : {
		"index" : "440"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mult_clipsize_upgrade_atomic"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ClipSize_Atomic"
		"name" : "clip size upgrade atomic"
		"hidden" : "0"
	}

	"add head on hit" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "add_head_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AddHeadOnHit"
		"name" : "add head on hit"
		"index" : "540"
		"hidden" : "0"
	}

	"store sort override DEPRECATED" : {
		"index" : "317"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "store_sort_override_DEPRECATED"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_AlternateRocketEffect"
		"name" : "store sort override DEPRECATED"
		"hidden" : "1"
	}

	"aiming movespeed decreased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_aiming_movespeed"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AimingMoveSpeed_Decreased"
		"name" : "aiming movespeed decreased"
		"index" : "183"
		"hidden" : "0"
	}

	"SET BONUS: alien isolation merc bonus neg" : {
		"index" : "696"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "alien_isolation_merc_bonus_neg"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AiMercSetBonusNeg"
		"name" : "SET BONUS: alien isolation merc bonus neg"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"fire rate bonus with reduced health" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_FireRateBonusWithReducedHealth"
		"name" : "fire rate bonus with reduced health"
		"description_format" : "value_is_inverted_percentage"
		"index" : "651"
		"attribute_class" : "mult_postfiredelay_with_reduced_health"
		"hidden" : "0"
	}

	"increased jump height" : {
		"index" : "326"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_jump_height"
		"effect_type" : "positive"
		"description_string" : "#Attrib_JumpHeightBonus"
		"name" : "increased jump height"
		"hidden" : "0"
	}

	"counts as assister is some kind of pet this update is going to be awesome" : {
		"index" : "415"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "counts_as_assister"
		"effect_type" : "positive"
		"name" : "counts as assister is some kind of pet this update is going to be awesome"
		"hidden" : "1"
		"armory_desc" : "on_wearer"
	}

	"restore health on kill" : {
		"index" : "220"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "restore_health_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RestoreHealthOnKill"
		"name" : "restore health on kill"
		"hidden" : "0"
	}

	"mod medic healed deploy time penalty" : {
		"index" : "234"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_medic_healed_deploy_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MedicHealedDeployTimePenalty"
		"name" : "mod medic healed deploy time penalty"
		"hidden" : "0"
	}

	"rocket launch impulse" : {
		"index" : "612"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_rocket_launch_impulse"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RocketLaunchImpulse"
		"name" : "rocket launch impulse"
		"hidden" : "0"
	}

	"Repair rate decreased" : {
		"index" : "95"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_repair_value"
		"effect_type" : "negative"
		"description_string" : "#Attrib_RepairRate_Decreased"
		"name" : "Repair rate decreased"
		"hidden" : "0"
	}

	"sniper penetrate players when charged" : {
		"index" : "308"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_penetrate_players_when_charged"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SniperFullChargePenetration"
		"name" : "sniper penetrate players when charged"
		"hidden" : "0"
	}

	"health on radius damage" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_health_on_radius_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthOnRadiusDamage"
		"name" : "health on radius damage"
		"index" : "741"
		"hidden" : "0"
	}

	"dmg taken from bullets reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Reduced"
		"name" : "dmg taken from bullets reduced"
		"index" : "66"
		"hidden" : "0"
	}

	"armor piercing" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "armor_piercing"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ArmorPiercing"
		"name" : "armor piercing"
		"index" : "399"
		"hidden" : "0"
	}

	"selfmade description" : {
		"index" : "141"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "desc_selfmade_description"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Selfmade_Description"
		"name" : "selfmade description"
		"hidden" : "1"
	}

	"subtract victim medigun charge on hit" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "subtract_victim_medigun_charge_onhit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SubtractVictimMedigunChargeOnHit"
		"name" : "subtract victim medigun charge on hit"
		"index" : "337"
		"hidden" : "0"
	}

	"damage bonus while disguised" : {
		"index" : "410"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_disguised"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgBonus_Disguised"
		"name" : "damage bonus while disguised"
		"hidden" : "0"
	}

	"disable weapon hiding for animations" : {
		"effect_type" : "positive"
		"name" : "disable weapon hiding for animations"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "312"
		"attribute_class" : "disable_weapon_hiding_for_animations"
		"hidden" : "1"
	}

	"dmg penalty vs nonstunned" : {
		"index" : "39"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "unimplemented_mod_dmg_vs_nonstunned"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgPenaltyVsNonStunned"
		"name" : "dmg penalty vs nonstunned"
		"hidden" : "0"
	}

	"airblast pushback scale" : {
		"index" : "255"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "airblast_pushback_scale"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirBlastPushScale"
		"name" : "airblast pushback scale"
		"hidden" : "0"
	}

	"dmg penalty vs nonburning" : {
		"index" : "21"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_vs_nonburning"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgPenaltyVsNonBurning"
		"name" : "dmg penalty vs nonburning"
		"hidden" : "0"
	}

	"always tradable" : {
		"index" : "195"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "always_tradable"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Always_Tradable"
		"name" : "always tradable"
		"hidden" : "1"
	}

	"dmg from melee increased" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "dmg_from_melee"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgFromMelee_Increased"
		"name" : "dmg from melee increased"
		"index" : "206"
		"hidden" : "0"
	}

	"set_item_texture_wear" : {
		"can_affect_market_name" : "1"
		"name" : "set_item_texture_wear"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "725"
		"attribute_class" : "set_item_texture_wear"
		"hidden" : "1"
	}

	"engy building health bonus" : {
		"index" : "286"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_engy_building_health"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EngyBuildingHealthBonus"
		"name" : "engy building health bonus"
		"hidden" : "0"
	}

	"cannot restore" : {
		"name" : "cannot restore"
		"stored_as_integer" : "1"
		"index" : "743"
		"attribute_class" : "cannot_restore"
		"hidden" : "1"
	}

	"item slot criteria 7" : {
		"index" : "3012"
		"name" : "item slot criteria 7"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"health from healers increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_health_fromhealers"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthFromHealers_Increased"
		"name" : "health from healers increased"
		"index" : "70"
		"hidden" : "0"
	}

	"rocket specialist" : {
		"index" : "488"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "rocket_specialist"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Rocket_Specialist"
		"name" : "rocket specialist"
		"hidden" : "0"
	}

	"heal rate bonus" : {
		"index" : "8"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_healrate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealRate_Positive"
		"name" : "heal rate bonus"
		"hidden" : "0"
	}

	"kill eater score type 2" : {
		"effect_type" : "positive"
		"name" : "kill eater score type 2"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "293"
		"attribute_class" : "kill_eater_score_type_2"
		"hidden" : "1"
	}

	"dmg falloff decreased" : {
		"index" : "118"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_falloff"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Dmg_Falloff_Decreased"
		"name" : "dmg falloff decreased"
		"hidden" : "0"
	}

	"dmg bonus while half dead" : {
		"index" : "224"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_bonus_while_half_dead"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MultDmgBonusWhileHalfDead"
		"name" : "dmg bonus while half dead"
		"hidden" : "0"
	}

	"Repair rate increased" : {
		"index" : "94"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_repair_value"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RepairRate_Increased"
		"name" : "Repair rate increased"
		"hidden" : "0"
	}

	"deactive date" : {
		"effect_type" : "neutral"
		"name" : "deactive date"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"index" : "751"
		"attribute_class" : "deactive_date"
		"hidden" : "1"
	}

	"noise maker" : {
		"index" : "196"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "enable_misc2_noisemaker"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_NoiseMaker"
		"name" : "noise maker"
		"hidden" : "1"
	}

	"sapper degenerates buildings" : {
		"index" : "433"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sapper_degenerates_buildings"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Degenerates_Buildings"
		"name" : "sapper degenerates buildings"
		"hidden" : "0"
	}

	"no_jump" : {
		"name" : "no_jump"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "819"
		"attribute_class" : "no_jump"
		"hidden" : "1"
	}

	"expiration date" : {
		"index" : "302"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"attribute_class" : "expiration_date"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_ExpirationDate"
		"name" : "expiration date"
		"hidden" : "1"
	}

	"maxammo metal increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_metal"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxammoMetal_Increased"
		"name" : "maxammo metal increased"
		"index" : "80"
		"hidden" : "0"
	}

	"SET BONUS: special dsp" : {
		"index" : "333"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "special_dsp"
		"effect_type" : "positive"
		"name" : "SET BONUS: special dsp"
		"is_set_bonus" : "1"
		"hidden" : "1"
	}

	"attach particle effect static" : {
		"effect_type" : "neutral"
		"name" : "attach particle effect static"
		"stored_as_integer" : "0"
		"description_format" : "value_is_particle_index"
		"index" : "370"
		"attribute_class" : "set_attached_particle_static"
		"hidden" : "0"
	}

	"use_model_cache_icon" : {
		"name" : "use_model_cache_icon"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "815"
		"attribute_class" : "use_model_cache_icon"
		"hidden" : "1"
	}

	"alt-fire disabled" : {
		"index" : "27"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "unimplemented_altfire_disabled"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_AltFire_Disabled"
		"name" : "alt-fire disabled"
		"hidden" : "0"
	}

	"mod rage damage boost" : {
		"index" : "245"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "rage_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageDamageBoost"
		"name" : "mod rage damage boost"
		"hidden" : "0"
	}

	"medic regen penalty" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "medic_regen"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MedicRegenPenalty"
		"name" : "medic regen penalty"
		"index" : "131"
		"hidden" : "0"
	}

	"crit_dmg_falloff" : {
		"index" : "868"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_dmg_falloff"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Dmg_Crit_Falloff"
		"name" : "crit_dmg_falloff"
		"hidden" : "0"
	}

	"medigun bullet resist passive" : {
		"effect_type" : "positive"
		"name" : "medigun bullet resist passive"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "503"
		"attribute_class" : "medigun_bullet_resist_passive"
		"hidden" : "1"
	}

	"provide on active" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "provide_on_active"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_ProvideOnActive"
		"name" : "provide on active"
		"index" : "128"
		"hidden" : "0"
	}

	"SET BONUS: dmg taken from fire reduced set bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Reduced"
		"name" : "SET BONUS: dmg taken from fire reduced set bonus"
		"index" : "492"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"flame_spread_degree" : {
		"effect_type" : "positive"
		"name" : "flame_spread_degree"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "flame_spread_degree"
		"index" : "839"
	}

	"weapon burn time reduced" : {
		"index" : "74"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_wpn_burntime"
		"effect_type" : "negative"
		"description_string" : "#Attrib_WpnBurnTime_Reduced"
		"name" : "weapon burn time reduced"
		"hidden" : "0"
	}

	"mult sniper charge after bodyshot" : {
		"index" : "222"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_after_bodyshot"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MultSniperChargeAfterBodyshot"
		"name" : "mult sniper charge after bodyshot"
		"hidden" : "0"
	}

	"sniper no headshot without full charge" : {
		"index" : "306"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_no_headshot_without_full_charge"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sniper_NoHeadShot"
		"name" : "sniper no headshot without full charge"
		"hidden" : "0"
	}

	"arrow heals buildings" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "arrow_heals_buildings"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ArrowHealsBuildings"
		"name" : "arrow heals buildings"
		"index" : "474"
		"hidden" : "0"
	}

	"dragons fury positive properties" : {
		"effect_type" : "positive"
		"description_string" : "#TF_Weapon_DragonsFury_PositiveDesc"
		"name" : "dragons fury positive properties"
		"description_format" : "value_is_additive"
		"index" : "2063"
		"attribute_class" : "dragons_fury_positive_properties"
		"hidden" : "0"
	}

	"taunt success sound loop" : {
		"index" : "608"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"name" : "taunt success sound loop"
		"attribute_class" : "taunt_success_sound_loop"
		"attribute_type" : "string"
	}

	"damage bonus" : {
		"index" : "2"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageDone_Positive"
		"name" : "damage bonus"
		"hidden" : "0"
	}

	"apply z velocity on damage" : {
		"effect_type" : "positive"
		"name" : "apply z velocity on damage"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "215"
		"attribute_class" : "apply_z_velocity_on_damage"
		"hidden" : "1"
	}

	"mod ammo per shot" : {
		"index" : "298"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_ammo_per_shot"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AmmoPerShot"
		"name" : "mod ammo per shot"
		"hidden" : "0"
	}

	"is_operation_pass" : {
		"name" : "is_operation_pass"
		"description_format" : "value_is_additive"
		"index" : "723"
		"hidden" : "1"
		"attribute_class" : "is_operation_pass"
	}

	"airblast cost increased" : {
		"index" : "170"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_airblast_cost"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AirblastCost_Increased"
		"name" : "airblast cost increased"
		"hidden" : "0"
	}

	"uses ammo while aiming" : {
		"index" : "431"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "uses_ammo_while_aiming"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Uses_Ammo_While_Aiming"
		"name" : "uses ammo while aiming"
		"hidden" : "0"
	}

	"metal regen" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_metal_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MetalRegen"
		"name" : "metal regen"
		"index" : "113"
		"hidden" : "0"
	}

	"airblast_deflect_projectiles_disabled" : {
		"effect_type" : "negative"
		"name" : "airblast_deflect_projectiles_disabled"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_deflect_projectiles_disabled"
		"index" : "826"
	}

	"selfdmg on hit for rapidfire" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onhit_addhealth"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealOnHit_Negative"
		"name" : "selfdmg on hit for rapidfire"
		"index" : "98"
		"hidden" : "0"
	}

	"end drop date" : {
		"name" : "end drop date"
		"description_format" : "value_is_date"
		"index" : "2011"
		"attribute_class" : "end_drop_date"
		"attribute_type" : "string"
	}

	"aoe_deflection" : {
		"effect_type" : "neutral"
		"name" : "aoe_deflection"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "aoe_deflection"
		"index" : "830"
	}

	"kill eater" : {
		"can_affect_market_name" : "1"
		"index" : "214"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "kill_eater"
		"effect_type" : "positive"
		"name" : "kill eater"
		"hidden" : "1"
	}

	"kill refills meter" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_KillsRefillMeter"
		"name" : "kill refills meter"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "kill_refills_meter"
		"index" : "2034"
	}

	"duckstreaks active" : {
		"index" : "705"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "duckstreaks_active"
		"effect_type" : "positive"
		"description_string" : "#Attrib_duckstreaks"
		"name" : "duckstreaks active"
		"hidden" : "0"
	}

	"clip size bonus upgrade" : {
		"index" : "335"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_clipsize_upgrade"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ClipSize_Positive"
		"name" : "clip size bonus upgrade"
		"hidden" : "0"
	}

	"CARD: move speed bonus" : {
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
		"attribute_class" : "mult_player_movespeed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"name" : "CARD: move speed bonus"
		"index" : "1002"
		"hidden" : "0"
		"description_format" : "value_is_percentage"
	}

	"grenade damage reduction on world contact" : {
		"index" : "470"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "grenade_damage_reduction_on_world_contact"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Grenade_Damage_Reduction_On_World_Contact"
		"name" : "grenade damage reduction on world contact"
		"hidden" : "0"
	}

	"move speed bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_movespeed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"name" : "move speed bonus"
		"index" : "107"
		"hidden" : "0"
	}

	"hide enemy health" : {
		"index" : "336"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "hide_enemy_health"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HideEnemyHealth"
		"name" : "hide enemy health"
		"hidden" : "0"
	}

	"taunt mimic" : {
		"effect_type" : "positive"
		"name" : "taunt mimic"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "602"
		"attribute_class" : "taunt_mimic"
		"hidden" : "1"
	}

	"quest loaner id low" : {
		"index" : "2051"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "quest loaner id low"
	}

	"medigun crit bullet percent bar deplete" : {
		"effect_type" : "positive"
		"name" : "medigun crit bullet percent bar deplete"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "509"
		"attribute_class" : "medigun_crit_bullet_percent_bar_deplete"
		"hidden" : "1"
	}

	"weapon burn time increased" : {
		"index" : "73"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_wpn_burntime"
		"effect_type" : "positive"
		"description_string" : "#Attrib_WpnBurnTime_Increased"
		"name" : "weapon burn time increased"
		"hidden" : "0"
	}

	"fire retardant" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_fire_retardant"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FireRetardant"
		"name" : "fire retardant"
		"index" : "53"
		"hidden" : "0"
	}

	"damage applies to sappers" : {
		"index" : "146"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_dmg_apply_to_sapper"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgAppliesToSappers"
		"name" : "damage applies to sappers"
		"hidden" : "0"
	}

	"Halloween Spellbook Page: Tumidum" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpellbookPage_A"
		"name" : "Halloween Spellbook Page: Tumidum"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tf_halloween_spell_page"
		"index" : "2016"
	}

	"hit self on miss" : {
		"index" : "204"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "hit_self_on_miss"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HitSelfOnMiss"
		"name" : "hit self on miss"
		"hidden" : "0"
	}

	"zombiezombiezombiezombie" : {
		"effect_type" : "neutral"
		"name" : "zombiezombiezombiezombie"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "450"
		"attribute_class" : "zombiezombiezombiezombie"
		"hidden" : "1"
	}

	"overheal penalty" : {
		"index" : "105"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_medigun_overheal_amount"
		"effect_type" : "negative"
		"description_string" : "#Attrib_OverhealAmount_Negative"
		"name" : "overheal penalty"
		"hidden" : "0"
	}

	"set cloak is feign death" : {
		"armory_desc" : "cloak_type"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_CloakIsFeignDeath"
		"name" : "set cloak is feign death"
		"index" : "33"
		"hidden" : "0"
	}

	"faster reload rate" : {
		"index" : "318"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "fast_reload"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FastReload"
		"name" : "faster reload rate"
		"hidden" : "0"
	}

	"medigun crit blast percent bar deplete" : {
		"effect_type" : "positive"
		"name" : "medigun crit blast percent bar deplete"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "510"
		"attribute_class" : "medigun_crit_blast_percent_bar_deplete"
		"hidden" : "1"
	}

	"event date" : {
		"index" : "185"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"attribute_class" : "event_date"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_EventDate"
		"name" : "event date"
		"hidden" : "1"
	}

	"item in slot 2" : {
		"index" : "3003"
		"name" : "item in slot 2"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"SET BONUS: dmg taken from crit reduced set bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Reduced"
		"name" : "SET BONUS: dmg taken from crit reduced set bonus"
		"index" : "491"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"custom name attr" : {
		"effect_type" : "positive"
		"name" : "custom name attr"
		"index" : "500"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "custom_name_attr"
		"attribute_type" : "string"
	}

	"force weapon switch" : {
		"effect_type" : "positive"
		"name" : "force weapon switch"
		"description_format" : "value_is_additive"
		"index" : "712"
		"attribute_class" : "force_weapon_switch"
		"hidden" : "1"
	}

	"sapper damage penalty hidden" : {
		"index" : "434"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sapper_damage"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sapper_Damage_Penalty"
		"name" : "sapper damage penalty hidden"
		"hidden" : "1"
	}

	"show paint description" : {
		"name" : "show paint description"
		"description_format" : "value_is_additive"
		"index" : "544"
		"hidden" : "1"
		"attribute_class" : "show_paint_description"
	}

	"weapon_stattrak_module_scale" : {
		"name" : "weapon_stattrak_module_scale"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "724"
		"attribute_class" : "weapon_stattrak_module_scale"
		"hidden" : "1"
	}

	"minicrit_boost_charge_rate" : {
		"index" : "780"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "minicrit_boost_charge_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MiniCritBoost_ChargeRate"
		"name" : "minicrit_boost_charge_rate"
		"hidden" : "0"
	}

	"minicrits become crits" : {
		"index" : "179"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "minicrits_become_crits"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MinicritsBecomeCrits"
		"name" : "minicrits become crits"
		"hidden" : "0"
	}

	"disable weapon switch" : {
		"effect_type" : "negative"
		"name" : "disable weapon switch"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "698"
		"attribute_class" : "disable_weapon_switch"
		"hidden" : "1"
	}

	"engineer rage on dmg" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "generate_rage_on_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EngineerBuildingRescueRage"
		"name" : "engineer rage on dmg"
		"index" : "471"
		"hidden" : "0"
	}

	"mult cloak meter regen rate" : {
		"index" : "35"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CloakMeterRegenRate"
		"name" : "mult cloak meter regen rate"
		"hidden" : "0"
	}

	"set item tint RGB 2" : {
		"index" : "261"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_item_tint_rgb_2"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_SetItemTintRGB"
		"name" : "set item tint RGB 2"
		"hidden" : "1"
	}

	"flame size bonus" : {
		"index" : "162"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_size"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FlameSize_Positive"
		"name" : "flame size bonus"
		"hidden" : "0"
	}

	"kill eater kill type" : {
		"effect_type" : "positive"
		"name" : "kill eater kill type"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "388"
		"attribute_class" : "kill_eater_kill_type"
		"hidden" : "1"
	}

	"repair health to metal ratio DISPLAY ONLY" : {
		"index" : "880"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "repair_health_to_metal_ratio_DISPLAY_ONLY"
		"effect_type" : "negative"
		"description_string" : "#Attrib_RepairHealthToMetalRatio"
		"name" : "repair health to metal ratio DISPLAY ONLY"
		"hidden" : "0"
	}

	"airblast_pushback_no_stun" : {
		"effect_type" : "negative"
		"name" : "airblast_pushback_no_stun"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_pushback_no_stun"
		"index" : "824"
	}

	"sniper rage DISPLAY ONLY" : {
		"index" : "393"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_rage_DISPLAY_ONLY"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SniperRageDisplayOnly"
		"name" : "sniper rage DISPLAY ONLY"
		"hidden" : "0"
	}

	"disguise speed penalty" : {
		"index" : "157"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "disguise_speed_penalty"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DisguiseSpeedPenalty"
		"name" : "disguise speed penalty"
		"hidden" : "0"
	}

	"crit vs wet players" : {
		"index" : "438"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "crit_vs_wet_players"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsWet"
		"name" : "crit vs wet players"
		"hidden" : "0"
	}

	"CARD: dmg taken from bullets reduced" : {
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Reduced"
		"name" : "CARD: dmg taken from bullets reduced"
		"index" : "1001"
		"hidden" : "0"
		"description_format" : "value_is_inverted_percentage"
	}

	"grenades3_resupply_denied" : {
		"name" : "grenades3_resupply_denied"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "847"
		"attribute_class" : "grenades3_resupply_denied"
		"hidden" : "1"
	}

	"aiming no flinch" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "aiming_no_flinch"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AimingNoFlinch"
		"name" : "aiming no flinch"
		"index" : "376"
		"hidden" : "0"
	}

	"special taunt" : {
		"effect_type" : "positive"
		"name" : "special taunt"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "551"
		"attribute_class" : "special_taunt"
		"hidden" : "1"
	}

	"custom projectile model" : {
		"effect_type" : "positive"
		"name" : "custom projectile model"
		"index" : "675"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "custom_projectile_model"
		"attribute_type" : "string"
	}

	"pyrovision opt in DISPLAY ONLY" : {
		"index" : "445"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "pyrovision_opt_in_display_only"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PyroVisionOptIn"
		"name" : "pyrovision opt in DISPLAY ONLY"
		"hidden" : "0"
	}

	"stickies detonate stickies" : {
		"index" : "121"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "stickies_detonate_stickies"
		"effect_type" : "positive"
		"description_string" : "#Attrib_StickiesDetonateStickies"
		"name" : "stickies detonate stickies"
		"hidden" : "0"
	}

	"zoom speed mod disabled" : {
		"index" : "40"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "unimplemented_mod_zoom_speed_disabled"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ZoomSpeedMod_Disabled"
		"name" : "zoom speed mod disabled"
		"hidden" : "0"
	}

	"self dmg push force increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgself_push_force"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SelfDmgPush_Increased"
		"name" : "self dmg push force increased"
		"index" : "58"
		"hidden" : "0"
	}

	"airblast_pushback_no_viewpunch" : {
		"effect_type" : "negative"
		"name" : "airblast_pushback_no_viewpunch"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_pushback_no_viewpunch"
		"index" : "825"
	}

	"display duck leaderboard" : {
		"effect_type" : "positive"
		"name" : "display duck leaderboard"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "700"
		"attribute_class" : "display_duck_leaderboard"
		"hidden" : "1"
	}

	"sapper kills collect crits" : {
		"index" : "296"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "sapper_kills_collect_crits"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SapperKillsCollectCrits"
		"name" : "sapper kills collect crits"
		"hidden" : "0"
	}

	"crit vs stunned players" : {
		"index" : "437"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "or_crit_vs_playercond"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsStunned"
		"name" : "crit vs stunned players"
		"hidden" : "0"
	}

	"mod_maxhealth_drain_rate" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_maxhealth_drain_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxHealthDrain"
		"name" : "mod_maxhealth_drain_rate"
		"index" : "855"
		"hidden" : "0"
	}

	"set throwable type" : {
		"name" : "set throwable type"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "539"
		"attribute_class" : "set_throwable_type"
		"hidden" : "1"
	}

	"dmg taken from crit reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Reduced"
		"name" : "dmg taken from crit reduced"
		"index" : "62"
		"hidden" : "0"
	}

	"sapper voice pak" : {
		"index" : "451"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sapper_voice_pak"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Voice_Pak"
		"name" : "sapper voice pak"
		"hidden" : "0"
	}

	"Construction rate decreased" : {
		"index" : "93"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_construction_value"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ConstructionRate_Decreased"
		"name" : "Construction rate decreased"
		"hidden" : "0"
	}

	"max_flame_reflection_count" : {
		"name" : "max_flame_reflection_count"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "859"
		"attribute_class" : "max_flame_reflection_count"
		"hidden" : "1"
	}

	"shuffle crate item def max" : {
		"effect_type" : "positive"
		"name" : "shuffle crate item def max"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "691"
		"attribute_class" : "shuffle_crate_item_def_max"
		"hidden" : "1"
	}

	"mult airblast refire time" : {
		"effect_type" : "positive"
		"name" : "mult airblast refire time"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "256"
		"attribute_class" : "mult_airblast_refire_time"
		"hidden" : "1"
	}

	"fire rate bonus HIDDEN" : {
		"index" : "394"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_postfiredelay"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FireRate_Positive"
		"name" : "fire rate bonus HIDDEN"
		"hidden" : "1"
	}

	"strange restriction user value 3" : {
		"effect_type" : "positive"
		"name" : "strange restriction user value 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "463"
		"attribute_class" : "strange_restriction_user_value_3"
		"hidden" : "1"
	}

	"charge time decreased" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_ChargeTime_Decrease"
		"name" : "charge time decreased"
		"description_format" : "value_is_additive"
		"index" : "774"
		"attribute_class" : "mod_charge_time"
		"armory_desc" : "on_wearer"
	}

	"item style override" : {
		"name" : "item style override"
		"description_format" : "value_is_additive"
		"index" : "542"
		"hidden" : "1"
		"attribute_class" : "item_style_override"
	}

	"explode_on_ignite" : {
		"description_string" : "#Attrib_ExplodeOnIgnite"
		"name" : "explode_on_ignite"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "875"
		"attribute_class" : "explode_on_ignite"
		"hidden" : "0"
	}

	"halloween increased jump height" : {
		"effect_type" : "positive"
		"name" : "halloween increased jump height"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "550"
		"attribute_class" : "mod_jump_height"
		"hidden" : "1"
	}

	"mod sentry killed revenge" : {
		"index" : "136"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sentry_killed_revenge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SentryKilledRevenge"
		"name" : "mod sentry killed revenge"
		"hidden" : "0"
	}

	"breadgloves properties" : {
		"effect_type" : "positive"
		"name" : "breadgloves properties"
		"description_format" : "value_is_additive"
		"index" : "645"
		"attribute_class" : "breadgloves_properties"
		"hidden" : "1"
	}

	"has pipboy build interface" : {
		"index" : "295"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_custom_buildmenu"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "has pipboy build interface"
		"hidden" : "1"
	}

	"strange restriction user type 2" : {
		"effect_type" : "positive"
		"name" : "strange restriction user type 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "460"
		"attribute_class" : "strange_restriction_user_type_2"
		"hidden" : "1"
	}

	"cannot pick up buildings" : {
		"index" : "353"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cannot_pick_up_buildings"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CannotPickUpBuildings"
		"name" : "cannot pick up buildings"
		"hidden" : "0"
	}

	"mod_mark_attacker_for_death" : {
		"effect_type" : "negative"
		"name" : "mod_mark_attacker_for_death"
		"description_format" : "value_is_percentage"
		"index" : "814"
		"attribute_class" : "mod_mark_attacker_for_death"
		"hidden" : "0"
	}

	"healing received bonus" : {
		"index" : "526"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_healing_received"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealingReceivedBonus"
		"name" : "healing received bonus"
		"hidden" : "0"
	}

	"ubercharge overheal rate penalty" : {
		"index" : "739"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_overheal_uberchargerate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_OverhealUberchargeRate_Negative"
		"name" : "ubercharge overheal rate penalty"
		"hidden" : "0"
	}

	"preserve ubercharge" : {
		"index" : "188"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "preserve_ubercharge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PreserveUbercharge"
		"name" : "preserve ubercharge"
		"hidden" : "0"
	}

	"halloween reload time decreased" : {
		"effect_type" : "positive"
		"name" : "halloween reload time decreased"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"index" : "548"
		"attribute_class" : "hwn_mult_reload_time"
		"hidden" : "1"
	}

	"heal on hit for rapidfire" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onhit_addhealth"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealOnHit_Positive"
		"name" : "heal on hit for rapidfire"
		"index" : "16"
		"hidden" : "0"
	}

	"item_meter_damage_for_full_charge" : {
		"name" : "item_meter_damage_for_full_charge"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "2059"
		"attribute_class" : "item_meter_damage_for_full_charge"
		"hidden" : "1"
	}

	"gifter account id" : {
		"index" : "186"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "gifter_account_id"
		"effect_type" : "positive"
		"description_string" : "#Attrib_GifterAccountID"
		"name" : "gifter account id"
		"hidden" : "1"
	}

	"mod bat launches balls" : {
		"index" : "38"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BatLaunchesBalls"
		"name" : "mod bat launches balls"
		"hidden" : "0"
	}

	"mod weapon blocks healing" : {
		"apply_tag_to_item_definition" : "prevents_uber"
		"index" : "236"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "weapon_blocks_healing"
		"effect_type" : "negative"
		"description_string" : "#Attrib_WeaponBlocksHealing"
		"name" : "mod weapon blocks healing"
		"hidden" : "0"
	}

	"kill eater user 1" : {
		"effect_type" : "positive"
		"name" : "kill eater user 1"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "379"
		"attribute_class" : "kill_eater_user_1"
		"hidden" : "1"
	}

	"lose demo charge on damage when charging" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_LoseDemoChargeOnDamageWhenCharging"
		"name" : "lose demo charge on damage when charging"
		"description_format" : "value_is_additive"
		"index" : "676"
		"attribute_class" : "lose_demo_charge_on_damage_when_charging"
		"hidden" : "0"
	}

	"ubercharge rate bonus" : {
		"index" : "10"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_uberchargerate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_UberchargeRate_Positive"
		"name" : "ubercharge rate bonus"
		"hidden" : "0"
	}

	"damage blast push" : {
		"index" : "791"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "damage_blast_push"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageBlastPush"
		"name" : "damage blast push"
		"hidden" : "0"
	}

	"is throwable chargeable" : {
		"effect_type" : "positive"
		"name" : "is throwable chargeable"
		"description_format" : "value_is_additive"
		"index" : "622"
		"attribute_class" : "is_throwable_chargeable"
		"hidden" : "0"
	}

	"Projectile speed increased HIDDEN" : {
		"index" : "475"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_projectile_speed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ProjectileSpeed_Increased"
		"name" : "Projectile speed increased HIDDEN"
		"hidden" : "1"
	}

	"energy weapon charged shot" : {
		"index" : "282"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_charged_shot"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EnergyWeaponChargedShot"
		"name" : "energy weapon charged shot"
		"hidden" : "0"
	}

	"lunchbox adds minicrits" : {
		"index" : "144"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_LunchboxAddsMinicrits"
		"name" : "lunchbox adds minicrits"
		"hidden" : "1"
	}

	"dmg penalty while half alive" : {
		"index" : "225"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_penalty_while_half_alive"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MultDmgPenaltyWhileHalfAlive"
		"name" : "dmg penalty while half alive"
		"hidden" : "0"
	}

	"killstreak idleeffect" : {
		"index" : "2014"
		"stored_as_integer" : "0"
		"description_format" : "value_is_killstreak_idleeffect_index"
		"attribute_class" : "killstreak_idleeffect"
		"effect_type" : "positive"
		"description_string" : "#Attrib_KillStreakIdleEffect"
		"name" : "killstreak idleeffect"
		"can_affect_recipe_component_name" : "1"
	}

	"custom texture hi" : {
		"index" : "227"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "custom_texture_hi"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CustomTexture"
		"name" : "custom texture hi"
		"hidden" : "1"
	}

	"recipe component defined item 2" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 2"
		"index" : "2001"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"damage all connected" : {
		"index" : "360"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "damage_all_connected"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageAllConnected"
		"name" : "damage all connected"
		"hidden" : "0"
	}

	"custom desc attr" : {
		"effect_type" : "positive"
		"name" : "custom desc attr"
		"index" : "501"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "custom_desc_attr"
		"attribute_type" : "string"
	}

	"clip size bonus" : {
		"index" : "4"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_clipsize"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ClipSize_Positive"
		"name" : "clip size bonus"
		"hidden" : "0"
	}

	"health from packs decreased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_health_frompacks"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthFromPacks_Decreased"
		"name" : "health from packs decreased"
		"index" : "109"
		"hidden" : "0"
	}

	"dragons fury negative properties" : {
		"effect_type" : "negative"
		"description_string" : "#TF_Weapon_DragonsFury_NegativeDesc"
		"name" : "dragons fury negative properties"
		"description_format" : "value_is_additive"
		"index" : "2064"
		"attribute_class" : "dragons_fury_negative_properties"
		"hidden" : "0"
	}

	"honorbound" : {
		"index" : "226"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "honorbound"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Honorbound"
		"name" : "honorbound"
		"hidden" : "0"
	}

	"Attack not cancel charge" : {
		"index" : "1030"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "attack_not_cancel_charge"
		"effect_type" : "positive"
		"name" : "Attack not cancel charge"
		"hidden" : "1"
		"is_user_generated" : "1"
	}

	"item drop wave" : {
		"name" : "item drop wave"
		"stored_as_integer" : "1"
		"index" : "3018"
		"attribute_class" : "item_drop_wave"
		"hidden" : "1"
	}

	"mark for death" : {
		"index" : "218"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mark_for_death"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MarkForDeath"
		"name" : "mark for death"
		"hidden" : "0"
	}

	"stickybomb_charge_damage_increase" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_stickybomb_charge_damage_increase"
		"name" : "stickybomb_charge_damage_increase"
		"description_format" : "value_is_percentage"
		"index" : "727"
		"attribute_class" : "stickybomb_charge_damage_increase"
		"hidden" : "0"
	}

	"can shuffle crate contents" : {
		"index" : "2044"
		"name" : "can shuffle crate contents"
		"hidden" : "1"
	}

	"no crit boost" : {
		"index" : "288"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_crit_boost"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoCritBoost"
		"name" : "no crit boost"
		"hidden" : "0"
	}

	"kill eater user score type 2" : {
		"effect_type" : "positive"
		"name" : "kill eater user score type 2"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "382"
		"attribute_class" : "kill_eater_user_score_type_2"
		"hidden" : "1"
	}

	"loot list name" : {
		"index" : "2042"
		"name" : "loot list name"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"lose hype on take damage" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_losehypeontakedamage"
		"name" : "lose hype on take damage"
		"description_format" : "value_is_additive"
		"index" : "733"
		"attribute_class" : "lose_hype_on_take_damage"
		"hidden" : "0"
	}

	"deploy time decreased" : {
		"index" : "178"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_deploy_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DeployTime_Decreased"
		"name" : "deploy time decreased"
		"hidden" : "0"
	}

	"hand scale" : {
		"effect_type" : "negative"
		"name" : "hand scale"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "699"
		"attribute_class" : "hand_scale"
		"hidden" : "0"
	}

	"stickybomb fizzle time" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_stickybomb_fizzle_time"
		"name" : "stickybomb fizzle time"
		"description_format" : "value_is_additive"
		"index" : "669"
		"attribute_class" : "stickybomb_fizzle_time"
		"hidden" : "0"
	}

	"random drop line item 3" : {
		"index" : "2040"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "random drop line item 3"
	}

	"random drop line item 2" : {
		"index" : "2039"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "random drop line item 2"
	}

	"crit vs burning players" : {
		"index" : "20"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "or_crit_vs_playercond"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsBurning"
		"name" : "crit vs burning players"
		"hidden" : "0"
	}

	"random drop line item 1" : {
		"index" : "2038"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "random drop line item 1"
	}

	"damage force increase hidden" : {
		"index" : "535"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "damage_force_reduction"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DamageForceIncrease"
		"name" : "damage force increase hidden"
		"hidden" : "1"
	}

	"recipe component defined item 3" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 3"
		"index" : "2002"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"mod ammo per shot missed DISPLAY ONLY" : {
		"index" : "355"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_ammo_per_shot_missed_DISPLAY_ONLY"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AmmoPerShotMissed"
		"name" : "mod ammo per shot missed DISPLAY ONLY"
		"hidden" : "0"
	}

	"slow enemy on hit major" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mult_onhit_enemyspeed_major"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Slow_Enemy_OnHit_Major"
		"name" : "slow enemy on hit major"
		"index" : "182"
		"hidden" : "0"
	}

	"random drop line item 0" : {
		"index" : "2037"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "random drop line item 0"
	}

	"SPELL: set item tint RGB" : {
		"index" : "1004"
		"stored_as_integer" : "0"
		"description_format" : "value_is_from_lookup_table"
		"attribute_class" : "set_item_tint_rgb_override"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_RGB"
		"name" : "SPELL: set item tint RGB"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"move speed bonus resource level" : {
		"effect_type" : "positive"
		"name" : "move speed bonus resource level"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "792"
		"attribute_class" : "mult_player_movespeed_resource_level"
		"hidden" : "1"
	}

	"recipe component defined item 8" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 8"
		"index" : "2007"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"SPELL: Halloween death ghosts" : {
		"index" : "1009"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "halloween_death_ghosts"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_DeathGhosts"
		"name" : "SPELL: Halloween death ghosts"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"elevate quality" : {
		"index" : "189"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_elevated_quality"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ElevateQuality"
		"name" : "elevate quality"
		"hidden" : "1"
	}

	"non economy" : {
		"index" : "777"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "non_economy"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_NonEconomyItem"
		"name" : "non economy"
		"hidden" : "1"
	}

	"no primary ammo from dispensers while active" : {
		"index" : "421"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_primary_ammo_from_dispensers"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoPrimaryAmmoFromDispensers"
		"name" : "no primary ammo from dispensers while active"
		"hidden" : "0"
	}

	"strange restriction value 2" : {
		"effect_type" : "positive"
		"name" : "strange restriction value 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "457"
		"attribute_class" : "strange_restriction_value_2"
		"hidden" : "1"
	}

	"crit does no damage" : {
		"index" : "363"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_does_no_damage"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CritDoesNoDamage"
		"name" : "crit does no damage"
		"hidden" : "0"
	}

	"bullets per shot bonus" : {
		"index" : "45"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_bullets_per_shot"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BulletsPerShot_Bonus"
		"name" : "bullets per shot bonus"
		"hidden" : "0"
	}

	"SPELL: Halloween green flames" : {
		"index" : "1008"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "halloween_green_flames"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_GreenFlames"
		"name" : "SPELL: Halloween green flames"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"dmg taken from blast increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_from_explosions"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_From_Blast_Increased"
		"name" : "dmg taken from blast increased"
		"index" : "65"
		"hidden" : "0"
	}

	"damage bonus HIDDEN" : {
		"index" : "476"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageDone_Positive"
		"name" : "damage bonus HIDDEN"
		"hidden" : "1"
	}

	"DEPRECATED socketed item definition id DEPRECATED " : {
		"index" : "151"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "socketed_item_definition_id"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Socket"
		"name" : "DEPRECATED socketed item definition id DEPRECATED "
		"hidden" : "0"
	}

	"item_meter_charge_rate" : {
		"name" : "item_meter_charge_rate"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "801"
		"attribute_class" : "item_meter_charge_rate"
		"hidden" : "1"
	}

	"falling_impact_radius_stun" : {
		"index" : "871"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "falling_impact_radius_stun"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ImpactStun"
		"name" : "falling_impact_radius_stun"
		"hidden" : "0"
	}

	"referenced item id low" : {
		"index" : "192"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "referenced_item_id_low"
		"effect_type" : "negative"
		"name" : "referenced item id low"
		"hidden" : "1"
		"armory_desc" : "on_wearer"
	}

	"SPELL: set Halloween footstep type" : {
		"index" : "1005"
		"stored_as_integer" : "0"
		"description_format" : "value_is_from_lookup_table"
		"attribute_class" : "halloween_footstep_type"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_Footstep"
		"name" : "SPELL: set Halloween footstep type"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"random drop line item unusual list" : {
		"index" : "2036"
		"name" : "random drop line item unusual list"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"speed buff ally" : {
		"index" : "251"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "speed_buff_ally"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpeedBuffAlly"
		"name" : "speed buff ally"
		"hidden" : "0"
	}

	"falling_impact_radius_pushback" : {
		"index" : "870"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "falling_impact_radius_pushback"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ImpactPushback"
		"name" : "falling_impact_radius_pushback"
		"hidden" : "0"
	}

	"CARD: health regen" : {
		"armory_desc" : "on_wearer"
		"is_user_generated" : "1"
		"attribute_class" : "add_health_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthRegen"
		"name" : "CARD: health regen"
		"index" : "1003"
		"hidden" : "0"
		"description_format" : "value_is_additive"
	}

	"CARD: damage bonus" : {
		"index" : "1000"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageDone_Positive"
		"name" : "CARD: damage bonus"
		"hidden" : "0"
		"is_user_generated" : "1"
	}

	"reduced_healing_from_medics" : {
		"index" : "740"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_healing_from_medics"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealingFromMedics_Negative"
		"name" : "reduced_healing_from_medics"
		"hidden" : "0"
	}

	"quality text override" : {
		"name" : "quality text override"
		"index" : "2023"
		"attribute_class" : "quality_text_override"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"mod medic killed minicrit boost" : {
		"index" : "232"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "medic_killed_minicrit_boost"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MedicKilledMiniCritBoost"
		"name" : "mod medic killed minicrit boost"
		"hidden" : "0"
	}

	"sticky detonate mode" : {
		"index" : "119"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_detonate_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_StickyDetonateMode"
		"name" : "sticky detonate mode"
		"hidden" : "0"
	}

	"custom_paintkit_seed_lo" : {
		"name" : "custom_paintkit_seed_lo"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "866"
		"attribute_class" : "custom_paintkit_seed_lo"
		"hidden" : "1"
	}

	"additional halloween response criteria name" : {
		"effect_type" : "positive"
		"name" : "additional halloween response criteria name"
		"index" : "2021"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "additional_halloween_response_criteria_name"
		"attribute_type" : "string"
	}

	"maxammo primary reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_primary"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxammoPrimary_Reduced"
		"name" : "maxammo primary reduced"
		"index" : "77"
		"hidden" : "0"
	}

	"Halloween Spellbook Page: Veteris" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpellbookPage_E"
		"name" : "Halloween Spellbook Page: Veteris"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tf_halloween_spell_page"
		"index" : "2020"
	}

	"taunt attack time" : {
		"effect_type" : "positive"
		"name" : "taunt attack time"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "557"
		"attribute_class" : "taunt_attack_time"
		"hidden" : "1"
	}

	"Halloween Spellbook Page: Audere" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpellbookPage_C"
		"name" : "Halloween Spellbook Page: Audere"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tf_halloween_spell_page"
		"index" : "2018"
	}

	"Halloween Spellbook Page: Gratanter" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpellbookPage_B"
		"name" : "Halloween Spellbook Page: Gratanter"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tf_halloween_spell_page"
		"index" : "2017"
	}

	"weapon spread bonus" : {
		"index" : "106"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_spread_scale"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Spread_Positive"
		"name" : "weapon spread bonus"
		"hidden" : "0"
	}

	"spellbook page attr id" : {
		"index" : "2015"
		"attribute_class" : "spellbook_page_attr_id"
		"hidden" : "1"
		"name" : "spellbook page attr id"
	}

	"killstreak effect" : {
		"index" : "2013"
		"stored_as_integer" : "0"
		"description_format" : "value_is_killstreakeffect_index"
		"attribute_class" : "killstreak_effect"
		"effect_type" : "positive"
		"description_string" : "#Attrib_KillStreakEffect"
		"name" : "killstreak effect"
		"can_affect_recipe_component_name" : "1"
	}

	"engineer building teleporting pickup" : {
		"index" : "469"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "building_teleporting_pickup"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Building_Telporting_PickUp"
		"name" : "engineer building teleporting pickup"
		"hidden" : "0"
	}

	"tool target item" : {
		"can_affect_market_name" : "1"
		"name" : "tool target item"
		"index" : "2012"
		"hidden" : "1"
		"attribute_class" : "tool_target_item"
	}

	"rage giving scale" : {
		"effect_type" : "positive"
		"name" : "rage giving scale"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "478"
		"attribute_class" : "rage_giving_scale"
		"hidden" : "1"
	}

	"start drop date" : {
		"name" : "start drop date"
		"description_format" : "value_is_date"
		"index" : "2010"
		"attribute_class" : "start_drop_date"
		"attribute_type" : "string"
	}

	"recipe component defined item 10" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 10"
		"index" : "2009"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"recipe component defined item 9" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 9"
		"index" : "2008"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"recipe component defined item 6" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 6"
		"index" : "2005"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"recipe component defined item 5" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 5"
		"index" : "2004"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"kill eater user 2" : {
		"effect_type" : "positive"
		"name" : "kill eater user 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "381"
		"attribute_class" : "kill_eater_user_2"
		"hidden" : "1"
	}

	"clipsize increase on kill" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_ExtraRocketsOnKill"
		"name" : "clipsize increase on kill"
		"description_format" : "value_is_additive"
		"index" : "644"
		"attribute_class" : "clipsize_increase_on_kill"
		"hidden" : "0"
	}

	"recipe component defined item 4" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 4"
		"index" : "2003"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"strange restriction user type 3" : {
		"effect_type" : "positive"
		"name" : "strange restriction user type 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "462"
		"attribute_class" : "strange_restriction_user_type_3"
		"hidden" : "1"
	}

	"quest earned standard points" : {
		"name" : "quest earned standard points"
		"stored_as_integer" : "1"
		"index" : "3016"
		"attribute_class" : "quest_earned_standard_points"
		"hidden" : "1"
	}

	"series number" : {
		"can_affect_market_name" : "1"
		"name" : "series number"
		"index" : "2031"
		"hidden" : "1"
		"attribute_class" : "series_number"
	}

	"SET BONUS: mystery solving time decrease" : {
		"index" : "391"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mystery_solving_time_decrease"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MysterySolvingTimeDecrease"
		"name" : "SET BONUS: mystery solving time decrease"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"NoCloakWhenCloaked" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoCloakWhenCloaked"
		"name" : "NoCloakWhenCloaked"
		"description_format" : "value_is_additive"
		"index" : "728"
		"attribute_class" : "NoCloakWhenCloaked"
		"hidden" : "0"
	}

	"no crit vs nonburning" : {
		"index" : "22"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_nocrit_vs_nonburning"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoCritVsNonBurning"
		"name" : "no crit vs nonburning"
		"hidden" : "0"
	}

	"is commodity" : {
		"index" : "2046"
		"name" : "is commodity"
		"hidden" : "1"
	}

	"melee bounds multiplier" : {
		"effect_type" : "positive"
		"name" : "melee bounds multiplier"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "263"
		"attribute_class" : "melee_bounds_multiplier"
		"hidden" : "1"
	}

	"hype resets on jump" : {
		"index" : "419"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "hype_resets_on_jump"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HypeResetsOnJump"
		"name" : "hype resets on jump"
		"hidden" : "0"
	}

	"allowed in medieval mode" : {
		"index" : "2029"
		"attribute_class" : "allowed_in_medieval_mode"
		"hidden" : "1"
		"name" : "allowed in medieval mode"
	}

	"throwable healing" : {
		"effect_type" : "positive"
		"name" : "throwable healing"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "514"
		"attribute_class" : "throwable_healing"
		"hidden" : "1"
	}

	"quest earned bonus points" : {
		"name" : "quest earned bonus points"
		"stored_as_integer" : "1"
		"index" : "3017"
		"attribute_class" : "quest_earned_bonus_points"
		"hidden" : "1"
	}

	"recipe component defined item 1" : {
		"can_affect_market_name" : "1"
		"name" : "recipe component defined item 1"
		"index" : "2000"
		"attribute_class" : "dynamic_recipe_component_defined_item"
		"attribute_type" : "dynamic_recipe_component_defined_item"
	}

	"item in slot 8" : {
		"index" : "3015"
		"name" : "item in slot 8"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"item slot criteria 8" : {
		"index" : "3014"
		"name" : "item slot criteria 8"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"ubercharge rate penalty" : {
		"index" : "9"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_uberchargerate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_UberchargeRate_Negative"
		"name" : "ubercharge rate penalty"
		"hidden" : "0"
	}

	"SET BONUS: health regen set bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_health_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthRegen"
		"name" : "SET BONUS: health regen set bonus"
		"index" : "490"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"taunt force weapon slot" : {
		"effect_type" : "positive"
		"name" : "taunt force weapon slot"
		"index" : "641"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "taunt_force_weapon_slot"
		"attribute_type" : "string"
	}

	"minicrit vs burning player" : {
		"index" : "209"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "or_minicrit_vs_playercond_burning"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Minicrit_Vs_Burning_Player"
		"name" : "minicrit vs burning player"
		"hidden" : "0"
	}

	"holster_anim_time" : {
		"effect_type" : "negative"
		"name" : "holster_anim_time"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "840"
		"attribute_class" : "holster_anim_time"
		"hidden" : "0"
	}

	"item slot criteria 6" : {
		"index" : "3010"
		"name" : "item slot criteria 6"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"ammo regen" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "addperc_ammo_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AmmoRegen"
		"name" : "ammo regen"
		"index" : "112"
		"hidden" : "0"
	}

	"override projectile type" : {
		"effect_type" : "positive"
		"name" : "override projectile type"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "280"
		"attribute_class" : "override_projectile_type"
		"hidden" : "0"
	}

	"engy sentry radius increased" : {
		"index" : "344"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sentry_range"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SentryRadius_Increased"
		"name" : "engy sentry radius increased"
		"hidden" : "0"
	}

	"kill eater score type 3" : {
		"effect_type" : "positive"
		"name" : "kill eater score type 3"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "495"
		"attribute_class" : "kill_eater_score_type_3"
		"hidden" : "1"
	}

	"mod no reload DISPLAY ONLY" : {
		"index" : "307"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_no_reload_display_only"
		"effect_type" : "positive"
		"description_string" : "#Attrib_NoReload"
		"name" : "mod no reload DISPLAY ONLY"
		"hidden" : "0"
	}

	"mod flaregun fires pellets with knockback" : {
		"index" : "416"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FlaregunPelletsWithKnockback"
		"name" : "mod flaregun fires pellets with knockback"
		"hidden" : "0"
	}

	"sniper only fire zoomed" : {
		"index" : "297"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_only_fire_zoomed"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SniperOnlyFireZoomed"
		"name" : "sniper only fire zoomed"
		"hidden" : "0"
	}

	"sniper zoom penalty" : {
		"index" : "46"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_zoom_fov"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SniperZoom_Penalty"
		"name" : "sniper zoom penalty"
		"hidden" : "0"
	}

	"item slot criteria 4" : {
		"index" : "3006"
		"name" : "item slot criteria 4"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"bot medic uber health threshold" : {
		"name" : "bot medic uber health threshold"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "545"
		"attribute_class" : "bot_medic_uber_health_threshold"
		"hidden" : "1"
	}

	"item slot criteria 3" : {
		"index" : "3004"
		"name" : "item slot criteria 3"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"item slot criteria 2" : {
		"index" : "3002"
		"name" : "item slot criteria 2"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"item slot criteria 1" : {
		"index" : "3000"
		"name" : "item slot criteria 1"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"hidden primary max ammo bonus" : {
		"index" : "37"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_primary"
		"effect_type" : "positive"
		"description_string" : "unused"
		"name" : "hidden primary max ammo bonus"
		"hidden" : "1"
	}

	"mod shovel damage boost" : {
		"index" : "115"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ShovelDamageBoost"
		"name" : "mod shovel damage boost"
		"hidden" : "0"
	}

	"limited quantity item" : {
		"name" : "limited quantity item"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "692"
		"attribute_class" : "limited_quantity_item"
		"hidden" : "1"
	}

	"enables aoe heal" : {
		"index" : "200"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "enables_aoe_heal"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EnablesAOEHeal"
		"name" : "enables aoe heal"
		"hidden" : "0"
	}

	"damage force increase" : {
		"index" : "525"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "damage_force_reduction"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DamageForceIncrease"
		"name" : "damage force increase"
		"hidden" : "0"
	}

	"taunt success sound loop offset" : {
		"index" : "609"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "taunt_success_sound_loop_offset"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PhaseCloak"
		"name" : "taunt success sound loop offset"
		"hidden" : "1"
	}

	"attack_minicrits_and_consumes_burning" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_ConsumesBurning"
		"name" : "attack_minicrits_and_consumes_burning"
		"description_format" : "value_is_additive"
		"index" : "2067"
		"attribute_class" : "attack_minicrits_and_consumes_burning"
		"hidden" : "0"
	}

	"rage on assists" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "rage_on_assists"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageGainOnAssists"
		"name" : "rage on assists"
		"index" : "398"
		"hidden" : "0"
	}

	"rocketjump attackrate bonus" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_RocketJumpAttackRateBonus"
		"name" : "rocketjump attackrate bonus"
		"description_format" : "value_is_percentage"
		"index" : "621"
		"attribute_class" : "rocketjump_attackrate_bonus"
		"hidden" : "0"
	}

	"airblast_give_teammate_speed_boost" : {
		"effect_type" : "positive"
		"name" : "airblast_give_teammate_speed_boost"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_give_teammate_speed_boost"
		"index" : "832"
	}

	"dragons fury neutral properties" : {
		"effect_type" : "neutral"
		"description_string" : "#TF_Weapon_DragonsFury_NeutralDesc"
		"name" : "dragons fury neutral properties"
		"description_format" : "value_is_additive"
		"index" : "2065"
		"attribute_class" : "dragons_fury_neutral_properties"
		"hidden" : "0"
	}

	"taunt attack name" : {
		"effect_type" : "positive"
		"name" : "taunt attack name"
		"index" : "556"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "taunt_attack_name"
		"attribute_type" : "string"
	}

	"active health degen" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "active_item_health_regen"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthDrain"
		"name" : "active health degen"
		"index" : "191"
		"hidden" : "0"
	}

	"fire particle blue" : {
		"index" : "2054"
		"name" : "fire particle blue"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"selfdmg on hit for slowfire" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onhit_addhealth"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealOnHit_Negative"
		"name" : "selfdmg on hit for slowfire"
		"index" : "111"
		"hidden" : "0"
	}

	"airblast disabled" : {
		"index" : "356"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_disabled"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AirblastDisabled"
		"name" : "airblast disabled"
		"hidden" : "0"
	}

	"airblast cost scale hidden" : {
		"name" : "airblast cost scale hidden"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "2062"
		"attribute_class" : "mult_airblast_cost"
		"hidden" : "1"
	}

	"SET BONUS: dmg taken from bullets increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Increased"
		"name" : "SET BONUS: dmg taken from bullets increased"
		"index" : "516"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"meter_label" : {
		"index" : "2058"
		"name" : "meter_label"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"drop health pack on kill" : {
		"index" : "203"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "drop_health_pack_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DropHealthPackOnKill"
		"name" : "drop health pack on kill"
		"hidden" : "0"
	}

	"ragdolls become ash" : {
		"index" : "350"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "ragdolls_become_ash"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "ragdolls become ash"
		"hidden" : "1"
	}

	"fire particle red crit" : {
		"index" : "2057"
		"name" : "fire particle red crit"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"fire particle blue crit" : {
		"index" : "2056"
		"name" : "fire particle blue crit"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"spread penalty" : {
		"index" : "36"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_spread_scale"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Spread_Negative"
		"name" : "spread penalty"
		"hidden" : "0"
	}

	"fire particle red" : {
		"index" : "2055"
		"name" : "fire particle red"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"Projectile speed decreased" : {
		"index" : "104"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_projectile_speed"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ProjectileSpeed_Decreased"
		"name" : "Projectile speed decreased"
		"hidden" : "0"
	}

	"dmg taken increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_Increased"
		"name" : "dmg taken increased"
		"index" : "412"
		"hidden" : "0"
	}

	"cloak regen rate increased" : {
		"index" : "84"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CloakRegenRate_Increased"
		"name" : "cloak regen rate increased"
		"hidden" : "0"
	}

	"mod max primary clip override" : {
		"index" : "303"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_max_primary_clip_override"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "mod max primary clip override"
		"hidden" : "1"
	}

	"item_meter_charge_type_3_DISPLAY_ONLY" : {
		"index" : "879"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "item_meter_charge_type_3_DISPLAY_ONLY"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MeterChargeType3"
		"name" : "item_meter_charge_type_3_DISPLAY_ONLY"
		"hidden" : "0"
	}

	"engy dispenser radius increased" : {
		"index" : "345"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dispenser_radius"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DispenserRadius_Increased"
		"name" : "engy dispenser radius increased"
		"hidden" : "0"
	}

	"quest loaner id hi" : {
		"index" : "2052"
		"stored_as_integer" : "1"
		"hidden" : "1"
		"name" : "quest loaner id hi"
	}

	"apply look velocity on damage" : {
		"index" : "216"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "apply_look_velocity_on_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Knockback"
		"name" : "apply look velocity on damage"
		"hidden" : "1"
	}

	"reveal disguised victim on hit" : {
		"index" : "340"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "reveal_disguised_victim_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RevealDisguisedVictimOnHit"
		"name" : "reveal disguised victim on hit"
		"hidden" : "0"
	}

	"cannot delete" : {
		"index" : "2050"
		"name" : "cannot delete"
		"hidden" : "1"
	}

	"flame_up_speed" : {
		"name" : "flame_up_speed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "865"
		"attribute_class" : "flame_up_speed"
		"hidden" : "1"
	}

	"gunslinger punch combo" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_GunslingerPunchCombo"
		"name" : "gunslinger punch combo"
		"description_format" : "value_is_additive"
		"attribute_class" : "gunslinger_punch_combo"
		"index" : "2049"
	}

	"squad surplus claimer id DEPRECATED" : {
		"index" : "403"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "squad_surplus_claimer_account_id_DEPRECATED"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SquadSurplusClaimerAccountID"
		"name" : "squad surplus claimer id DEPRECATED"
		"hidden" : "1"
	}

	"attack projectiles" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_AttackProjectiles"
		"name" : "attack projectiles"
		"description_format" : "value_is_additive"
		"index" : "323"
		"attribute_class" : "attack_projectiles"
		"hidden" : "0"
	}

	"Wrench index" : {
		"index" : "147"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "desc_wrench_index"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_WrenchNumber"
		"name" : "Wrench index"
		"hidden" : "0"
	}

	"item name text override" : {
		"name" : "item name text override"
		"index" : "2024"
		"attribute_class" : "item_name_text_override"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"purchased" : {
		"index" : "172"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "purchased"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Purchased"
		"name" : "purchased"
		"hidden" : "1"
	}

	"killstreak tier" : {
		"can_affect_market_name" : "1"
		"index" : "2025"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "killstreak_tier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_KillStreakTier"
		"name" : "killstreak tier"
	}

	"wide item level" : {
		"name" : "wide item level"
		"stored_as_integer" : "1"
		"index" : "2026"
		"attribute_class" : "wide_item_level"
		"hidden" : "1"
	}

	"is australium item" : {
		"can_affect_market_name" : "1"
		"name" : "is australium item"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "2027"
		"attribute_class" : "is_australium_item"
		"hidden" : "1"
	}

	"health drain medic" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_health_regen"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthDrainMedic"
		"name" : "health drain medic"
		"index" : "881"
		"hidden" : "0"
	}

	"item_meter_starts_empty_DISPLAY_ONLY" : {
		"index" : "878"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "item_meter_starts_empty_DISPLAY_ONLY"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MeterStartsEmpty"
		"name" : "item_meter_starts_empty_DISPLAY_ONLY"
		"hidden" : "0"
	}

	"speed boost when active" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_move_speed_when_active"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpeedBoostWhenActive"
		"name" : "speed boost when active"
		"index" : "123"
		"hidden" : "0"
	}

	"thermal_thruster_air_launch" : {
		"index" : "872"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "thermal_thruster_air_launch"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ThermalThrusterAirLaunch"
		"name" : "thermal_thruster_air_launch"
		"hidden" : "1"
	}

	"charged airblast" : {
		"index" : "165"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_charged_airblast"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_ChargedAirblast"
		"name" : "charged airblast"
		"hidden" : "0"
	}

	"lunchbox healing decreased" : {
		"index" : "876"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "lunchbox_healing_scale"
		"effect_type" : "negative"
		"description_string" : "#Attrib_LunchboxHealingDecreased"
		"name" : "lunchbox healing decreased"
		"hidden" : "0"
	}

	"move speed penalty" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_player_movespeed"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MoveSpeed_Penalty"
		"name" : "move speed penalty"
		"index" : "54"
		"hidden" : "0"
	}

	"add onhit addammo" : {
		"index" : "299"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onhit_addammo"
		"effect_type" : "positive"
		"description_string" : "#Attrib_OnHit_AddAmmo"
		"name" : "add onhit addammo"
		"hidden" : "0"
	}

	"reload time increased hidden" : {
		"index" : "241"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_reload_time_hidden"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ReloadTime_Increased"
		"name" : "reload time increased hidden"
		"hidden" : "1"
	}

	"is_passive_weapon" : {
		"name" : "is_passive_weapon"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "818"
		"attribute_class" : "is_passive_weapon"
		"hidden" : "1"
	}

	"share consumable with patient" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "share_consumable_with_patient"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ShareConsumable"
		"name" : "share consumable with patient"
		"index" : "404"
		"hidden" : "0"
	}

	"absorb damage while cloaked" : {
		"index" : "50"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "unimplemented_absorb_dmg_while_cloaked"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AbsorbDmgWhileCloaked"
		"name" : "absorb damage while cloaked"
		"hidden" : "0"
	}

	"attach particle effect" : {
		"can_affect_market_name" : "1"
		"index" : "134"
		"stored_as_integer" : "0"
		"description_format" : "value_is_particle_index"
		"attribute_class" : "set_attached_particle"
		"effect_type" : "unusual"
		"description_string" : "#Attrib_AttachedParticle"
		"name" : "attach particle effect"
		"hidden" : "0"
	}

	"is throwable primable" : {
		"effect_type" : "positive"
		"name" : "is throwable primable"
		"description_format" : "value_is_additive"
		"index" : "616"
		"attribute_class" : "is_throwable_primable"
		"hidden" : "0"
	}

	"hidden secondary max ammo penalty" : {
		"index" : "25"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_secondary"
		"effect_type" : "neutral"
		"description_string" : "unused"
		"name" : "hidden secondary max ammo penalty"
		"hidden" : "1"
	}

	"grenades1_resupply_denied" : {
		"name" : "grenades1_resupply_denied"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "845"
		"attribute_class" : "grenades1_resupply_denied"
		"hidden" : "1"
	}

	"speed_boost_on_hit" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpeedBoostOnHit"
		"name" : "speed_boost_on_hit"
		"description_format" : "value_is_additive"
		"index" : "737"
		"attribute_class" : "speed_boost_on_hit"
		"hidden" : "0"
	}

	"speed_boost_on_hit_enemy" : {
		"index" : "877"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "speed_boost_on_hit_enemy"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpeedBoostEnemy"
		"name" : "speed_boost_on_hit_enemy"
		"hidden" : "0"
	}

	"SPELL: Halloween voice modulation" : {
		"index" : "1006"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "halloween_voice_modulation"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_Voice"
		"name" : "SPELL: Halloween voice modulation"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"crits_become_minicrits" : {
		"index" : "869"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crits_become_minicrits"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CritsBecomeMinicrits"
		"name" : "crits_become_minicrits"
		"hidden" : "0"
	}

	"mod see enemy health" : {
		"index" : "269"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "see_enemy_health"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SeeEnemyHealth"
		"name" : "mod see enemy health"
		"hidden" : "0"
	}

	"sniper independent zoom DISPLAY ONLY" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_SniperIndependentZoom"
		"name" : "sniper independent zoom DISPLAY ONLY"
		"description_format" : "value_is_additive"
		"index" : "637"
		"attribute_class" : "sniper_independent_zoom_DISPLAY_ONLY"
		"hidden" : "0"
	}

	"add_head_on_kill" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "add_head_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AddHeadOnKill"
		"name" : "add_head_on_kill"
		"index" : "807"
		"hidden" : "0"
	}

	"is winter case" : {
		"index" : "2068"
		"name" : "is winter case"
		"hidden" : "1"
	}

	"set supply crate series" : {
		"can_affect_market_name" : "1"
		"index" : "187"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "supply_crate_series"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SupplyCrateSeries"
		"name" : "set supply crate series"
		"hidden" : "0"
	}

	"unlimited quantity hidden" : {
		"effect_type" : "positive"
		"name" : "unlimited quantity hidden"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "704"
		"attribute_class" : "unlimited_quantity"
		"hidden" : "1"
	}

	"kill eater score type" : {
		"effect_type" : "positive"
		"name" : "kill eater score type"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "292"
		"attribute_class" : "kill_eater_score_type"
		"hidden" : "1"
	}

	"loot rarity" : {
		"name" : "loot rarity"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "2022"
		"attribute_class" : "loot_rarity"
		"hidden" : "1"
	}

	"minicrit_boost_when_charged" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_MiniCritBoost_WhenCharged"
		"name" : "minicrit_boost_when_charged"
		"description_format" : "value_is_additive"
		"index" : "779"
		"attribute_class" : "minicrit_boost_when_charged"
		"hidden" : "0"
	}

	"mult_patient_overheal_penalty_active" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_patient_overheal_penalty_active"
		"effect_type" : "negative"
		"description_string" : "#Attrib_PatientOverheal_Penalty"
		"name" : "mult_patient_overheal_penalty_active"
		"index" : "853"
		"hidden" : "0"
	}

	"tradable after date" : {
		"index" : "211"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"attribute_class" : "tradable_after_date"
		"effect_type" : "negative"
		"description_string" : "#Attrib_TradableAfterDate"
		"name" : "tradable after date"
		"hidden" : "1"
	}

	"mult_dmgtaken_active" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_active"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_Increased"
		"name" : "mult_dmgtaken_active"
		"index" : "852"
		"hidden" : "0"
	}

	"flame_random_life_time_offset" : {
		"name" : "flame_random_life_time_offset"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "863"
		"attribute_class" : "flame_random_life_time_offset"
		"hidden" : "1"
	}

	"flame_lifetime" : {
		"name" : "flame_lifetime"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "862"
		"attribute_class" : "flame_lifetime"
		"hidden" : "1"
	}

	"reflected_flame_dmg_reduction" : {
		"name" : "reflected_flame_dmg_reduction"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "861"
		"attribute_class" : "reflected_flame_dmg_reduction"
		"hidden" : "1"
	}

	"flame_reflection_add_life_time" : {
		"name" : "flame_reflection_add_life_time"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "860"
		"attribute_class" : "flame_reflection_add_life_time"
		"hidden" : "1"
	}

	"item_meter_charge_type" : {
		"name" : "item_meter_charge_type"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "856"
		"attribute_class" : "item_meter_charge_type"
		"hidden" : "1"
	}

	"cannot be backstabbed" : {
		"index" : "402"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cannot_be_backstabbed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CannotBeBackstabbed"
		"name" : "cannot be backstabbed"
		"hidden" : "0"
	}

	"override item level desc string" : {
		"effect_type" : "positive"
		"name" : "override item level desc string"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "439"
		"attribute_class" : "override_item_level_desc_string"
		"hidden" : "1"
	}

	"mult_health_fromhealers_penalty_active" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_health_fromhealers_penalty_active"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthFromHealers_Reduced"
		"name" : "mult_health_fromhealers_penalty_active"
		"index" : "854"
		"hidden" : "0"
	}

	"custom texture lo" : {
		"index" : "152"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "custom_texture_lo"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CustomTexture"
		"name" : "custom texture lo"
		"hidden" : "1"
	}

	"freeze backstab victim" : {
		"index" : "347"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "freeze_backstab_victim"
		"effect_type" : "negative"
		"description_string" : "#Attrib_FreezeBackstabVictim"
		"name" : "freeze backstab victim"
		"hidden" : "0"
	}

	"patient overheal penalty" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_patient_overheal_penalty"
		"effect_type" : "negative"
		"description_string" : "#Attrib_PatientOverheal_Penalty"
		"name" : "patient overheal penalty"
		"index" : "800"
		"hidden" : "0"
	}

	"crit kill will gib" : {
		"index" : "309"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_kill_will_gib"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritKillWillGib"
		"name" : "crit kill will gib"
		"hidden" : "0"
	}

	"medigun charge is megaheal" : {
		"index" : "231"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_charge_type"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Medigun_MegaHeal"
		"name" : "medigun charge is megaheal"
		"hidden" : "0"
	}

	"hype decays over time" : {
		"index" : "532"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "hype_decays_over_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HypeDecays"
		"name" : "hype decays over time"
		"hidden" : "0"
	}

	"grenades2_resupply_denied" : {
		"name" : "grenades2_resupply_denied"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "846"
		"attribute_class" : "grenades2_resupply_denied"
		"hidden" : "1"
	}

	"flame_speed" : {
		"name" : "flame_speed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "844"
		"attribute_class" : "flame_speed"
		"hidden" : "1"
	}

	"ammo becomes health" : {
		"index" : "258"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "ammo_becomes_health"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AmmoBecomesHealth"
		"name" : "ammo becomes health"
		"hidden" : "0"
	}

	"blast dmg to self increased" : {
		"index" : "207"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "blast_dmg_to_self"
		"effect_type" : "negative"
		"description_string" : "#Attrib_BlastDamageToSelf_Increased"
		"name" : "blast dmg to self increased"
		"hidden" : "0"
	}

	"crit mod disabled hidden" : {
		"index" : "28"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_crit_chance"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CritChance_Disabled"
		"name" : "crit mod disabled hidden"
		"hidden" : "1"
	}

	"flame_drag" : {
		"name" : "flame_drag"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "843"
		"attribute_class" : "flame_drag"
		"hidden" : "1"
	}

	"taunt is press and hold" : {
		"index" : "322"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "enable_misc2_holdtaunt"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_DamageDone_Negative"
		"name" : "taunt is press and hold"
		"hidden" : "1"
	}

	"revolver use hit locations" : {
		"index" : "51"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RevolverUseHitLocations"
		"name" : "revolver use hit locations"
		"hidden" : "0"
	}

	"flame_ignore_player_velocity" : {
		"name" : "flame_ignore_player_velocity"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "842"
		"attribute_class" : "flame_ignore_player_velocity"
		"hidden" : "1"
	}

	"ubercharge rate bonus for healer" : {
		"index" : "239"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_uberchargerate_for_healer"
		"effect_type" : "positive"
		"description_string" : "#Attrib_UberchargeRate_ForHealer"
		"name" : "ubercharge rate bonus for healer"
		"hidden" : "0"
	}

	"air dash count" : {
		"index" : "250"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "air_dash_count"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirDashCountIncreased"
		"name" : "air dash count"
		"hidden" : "0"
	}

	"fire rate penalty HIDDEN" : {
		"index" : "348"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_postfiredelay"
		"effect_type" : "negative"
		"description_string" : ""
		"name" : "fire rate penalty HIDDEN"
		"hidden" : "1"
	}

	"crit from behind" : {
		"index" : "362"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_from_behind"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritFromBehind"
		"name" : "crit from behind"
		"hidden" : "0"
	}

	"self dmg push force decreased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgself_push_force"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SelfDmgPush_Decreased"
		"name" : "self dmg push force decreased"
		"index" : "59"
		"hidden" : "0"
	}

	"spunup_damage_resistance" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_spup_damage_resistance"
		"name" : "spunup_damage_resistance"
		"description_format" : "value_is_percentage"
		"index" : "738"
		"attribute_class" : "spunup_damage_resistance"
		"hidden" : "0"
	}

	"SET BONUS: no death from headshots" : {
		"index" : "176"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_death_from_headshots"
		"effect_type" : "positive"
		"description_string" : "#Attrib_NoDeathFromHeadshots"
		"name" : "SET BONUS: no death from headshots"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"disguise damage reduction" : {
		"index" : "167"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "disguise_damage_reduction"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DisguiseDamageReduction"
		"name" : "disguise damage reduction"
		"hidden" : "0"
	}

	"dmg taken from fire reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Reduced"
		"name" : "dmg taken from fire reduced"
		"index" : "60"
		"hidden" : "0"
	}

	"charge time increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_charge_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChargeTime_Increase"
		"name" : "charge time increased"
		"index" : "202"
		"hidden" : "0"
	}

	"item in slot 6" : {
		"index" : "3011"
		"name" : "item in slot 6"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"flame_reflect_on_collision" : {
		"effect_type" : "positive"
		"name" : "flame_reflect_on_collision"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "flame_reflect_on_collision"
		"index" : "838"
	}

	"redirected_flame_size_mult" : {
		"effect_type" : "positive"
		"name" : "redirected_flame_size_mult"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "redirected_flame_size_mult"
		"index" : "837"
	}

	"taunt_attr_player_invis_percent" : {
		"name" : "taunt_attr_player_invis_percent"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "835"
		"attribute_class" : "taunt_attr_player_invis_percent"
		"hidden" : "1"
	}

	"paintkit_proto_def_index" : {
		"effect_type" : "neutral"
		"can_affect_market_name" : "1"
		"name" : "paintkit_proto_def_index"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "paintkit_proto_def_index"
		"index" : "834"
	}

	"tmp dmgbuff on hit" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "addperc_ondmgdone_tmpbuff"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageDoneBonus_Positive"
		"name" : "tmp dmgbuff on hit"
		"index" : "19"
		"hidden" : "0"
	}

	"mod bat launches ornaments" : {
		"index" : "346"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BatLaunchesOrnaments"
		"name" : "mod bat launches ornaments"
		"hidden" : "0"
	}

	"reload time decreased while healed" : {
		"index" : "240"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_reload_time_while_healed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ReloadTime_Decreased_While_Healed"
		"name" : "reload time decreased while healed"
		"hidden" : "0"
	}

	"item in slot 4" : {
		"index" : "3007"
		"name" : "item in slot 4"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"engy disposable sentries" : {
		"index" : "351"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "engy_disposable_sentries"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EngyDisposableSentries"
		"name" : "engy disposable sentries"
		"hidden" : "0"
	}

	"disable fancy class select anim" : {
		"effect_type" : "neutral"
		"name" : "disable fancy class select anim"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "328"
		"attribute_class" : "disable_fancy_class_select_anim"
		"hidden" : "1"
	}

	"afterburn duration penalty" : {
		"effect_type" : "negative"
		"name" : "afterburn duration penalty"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "afterburn_duration_mult"
		"index" : "828"
	}

	"airblast_put_out_teammate_disabled" : {
		"effect_type" : "negative"
		"name" : "airblast_put_out_teammate_disabled"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_put_out_teammate_disabled"
		"index" : "827"
	}

	"airblast_pushback_disabled" : {
		"effect_type" : "negative"
		"name" : "airblast_pushback_disabled"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_pushback_disabled"
		"index" : "823"
	}

	"dmg taken from crit increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_from_crit"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_From_Crit_Increased"
		"name" : "dmg taken from crit increased"
		"index" : "63"
		"hidden" : "0"
	}

	"airblast_destroy_projectile" : {
		"effect_type" : "neutral"
		"description_string" : "#Attrib_AirblastDestroyProjectile"
		"name" : "airblast_destroy_projectile"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_destroy_projectile"
		"index" : "822"
	}

	"maxammo secondary reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_secondary"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxammoSecondary_Reduced"
		"name" : "maxammo secondary reduced"
		"index" : "79"
		"hidden" : "0"
	}

	"overheal decay bonus" : {
		"index" : "13"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_medigun_overheal_decay"
		"effect_type" : "positive"
		"description_string" : "#Attrib_OverhealDecay_Positive"
		"name" : "overheal decay bonus"
		"hidden" : "0"
	}

	"weapon burn dmg increased" : {
		"index" : "71"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_wpn_burndmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_WpnBurnDmg_Increased"
		"name" : "weapon burn dmg increased"
		"hidden" : "0"
	}

	"airblast vertical pushback scale" : {
		"effect_type" : "positive"
		"name" : "airblast vertical pushback scale"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "257"
		"attribute_class" : "airblast_vertical_pushback_scale"
		"hidden" : "1"
	}

	"no_duck" : {
		"name" : "no_duck"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "820"
		"attribute_class" : "no_duck"
		"hidden" : "1"
	}

	"strange restriction user value 1" : {
		"effect_type" : "positive"
		"name" : "strange restriction user value 1"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "459"
		"attribute_class" : "strange_restriction_user_value_1"
		"hidden" : "1"
	}

	"spunup_push_force_immunity" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpunUpPushForceResist"
		"name" : "spunup_push_force_immunity"
		"description_format" : "value_is_percentage"
		"index" : "813"
		"attribute_class" : "spunup_push_force_immunity"
		"hidden" : "0"
	}

	"explosive sniper shot" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "explosive_sniper_shot"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ExplosiveSniperShot"
		"name" : "explosive sniper shot"
		"index" : "395"
		"hidden" : "0"
	}

	"crit vs disguised players" : {
		"index" : "407"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "or_crit_vs_playercond"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsDisguised"
		"name" : "crit vs disguised players"
		"hidden" : "0"
	}

	"never craftable" : {
		"effect_type" : "neutral"
		"name" : "never craftable"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "449"
		"attribute_class" : "never_craftable"
		"hidden" : "1"
	}

	"Blast radius increased" : {
		"index" : "99"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_explosion_radius"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BlastRadius_Increased"
		"name" : "Blast radius increased"
		"hidden" : "0"
	}

	"damage bonus bullet vs sentry target" : {
		"index" : "789"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_bullet_vs_sentry_target"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DamageBonusAgainstSentryTarget"
		"name" : "damage bonus bullet vs sentry target"
		"hidden" : "0"
	}

	"taunt attach particle index" : {
		"can_affect_market_name" : "1"
		"index" : "2041"
		"stored_as_integer" : "1"
		"description_format" : "value_is_particle_index"
		"hidden" : "0"
		"effect_type" : "unusual"
		"description_string" : "#Attrib_AttachedParticle"
		"name" : "taunt attach particle index"
	}

	"is_festivized" : {
		"can_affect_market_name" : "1"
		"index" : "2053"
		"description_format" : "value_is_additive"
		"attribute_class" : "is_festivized"
		"effect_type" : "unusual"
		"description_string" : "#Attrib_IsFestivized"
		"name" : "is_festivized"
		"hidden" : "0"
	}

	"mult_spread_scales_consecutive" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "mult_spread_scales_consecutive"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SpreadPenaltyScalesCons"
		"name" : "mult_spread_scales_consecutive"
		"index" : "808"
		"hidden" : "0"
	}

	"tool_target_item_icon_offset" : {
		"name" : "tool_target_item_icon_offset"
		"index" : "806"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "tool_target_item_icon_offset"
		"attribute_type" : "string"
	}

	"auto fires full clip" : {
		"index" : "413"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "auto_fires_full_clip"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AutoFiresFullClip"
		"name" : "auto fires full clip"
		"hidden" : "0"
	}

	"shuffle crate item def min" : {
		"effect_type" : "positive"
		"name" : "shuffle crate item def min"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "690"
		"attribute_class" : "shuffle_crate_item_def_min"
		"hidden" : "1"
	}

	"item_meter_resupply_denied" : {
		"index" : "848"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "item_meter_resupply_denied"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MeterResupplyDenied"
		"name" : "item_meter_resupply_denied"
		"hidden" : "0"
	}

	"lose revenge crits on death DISPLAY ONLY" : {
		"index" : "799"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "lose_revenge_crits_on_death_DISPLAY_ONLY"
		"effect_type" : "negative"
		"description_string" : "#Attrib_LoseRevengeCritsOnDeath"
		"name" : "lose revenge crits on death DISPLAY ONLY"
		"hidden" : "0"
	}

	"class select override vcd" : {
		"index" : "674"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Class_Select_Override_VCD"
		"name" : "class select override vcd"
		"attribute_class" : "class_select_override_vcd"
		"attribute_type" : "string"
	}

	"cannot disguise" : {
		"index" : "155"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_cannot_disguise"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CannotDisguise"
		"name" : "cannot disguise"
		"hidden" : "0"
	}

	"dmg pierces resists absorbs" : {
		"index" : "797"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_pierce_resists_absorbs"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PierceResists"
		"name" : "dmg pierces resists absorbs"
		"hidden" : "0"
	}

	"rocket jump damage reduction" : {
		"index" : "135"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "rocket_jump_dmg_reduction"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RocketJumpDmgReduction"
		"name" : "rocket jump damage reduction"
		"hidden" : "0"
	}

	"maxammo metal reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_metal"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxammoMetal_Reduced"
		"name" : "maxammo metal reduced"
		"index" : "81"
		"hidden" : "0"
	}

	"slow enemy on hit" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "mult_onhit_enemyspeed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Slow_Enemy_OnHit"
		"name" : "slow enemy on hit"
		"index" : "32"
		"hidden" : "0"
	}

	"major move speed bonus" : {
		"index" : "442"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_movespeed"
		"effect_type" : "positive"
		"name" : "major move speed bonus"
		"hidden" : "0"
		"armory_desc" : "on_wearer"
	}

	"damage bonus vs burning" : {
		"index" : "795"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_vs_burning"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgBonusVsBurning"
		"name" : "damage bonus vs burning"
		"hidden" : "0"
	}

	"powerup max charges" : {
		"index" : "270"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "powerup_max_charges"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PowerupMaxCharges"
		"name" : "powerup max charges"
		"hidden" : "0"
	}

	"hype on damage" : {
		"index" : "793"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "hype_on_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HypeOnDamage"
		"name" : "hype on damage"
		"hidden" : "0"
	}

	"random drop line item unusual chance" : {
		"index" : "2035"
		"name" : "random drop line item unusual chance"
		"hidden" : "1"
	}

	"mult sniper charge after miss" : {
		"index" : "223"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_after_miss"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MultSniperChargeAfterMiss"
		"name" : "mult sniper charge after miss"
		"hidden" : "0"
	}

	"mod teleporter cost" : {
		"index" : "790"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_teleporter_cost"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TeleporterBuildCost"
		"name" : "mod teleporter cost"
		"hidden" : "0"
	}

	"throwable detonation time" : {
		"effect_type" : "positive"
		"name" : "throwable detonation time"
		"description_format" : "value_is_additive"
		"index" : "617"
		"attribute_class" : "throwable_detonation_time"
		"hidden" : "0"
	}

	"mod_air_control_blast_jump" : {
		"index" : "812"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_air_control_blast_jump"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirControlBlastJump"
		"name" : "mod_air_control_blast_jump"
		"hidden" : "0"
	}

	"sapper damage leaches health" : {
		"index" : "427"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sapper_damage_leaches_health"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Leaches_Health"
		"name" : "sapper damage leaches health"
		"hidden" : "0"
	}

	"add jingle to footsteps" : {
		"index" : "364"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_jingle_to_footsteps"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AddJingleToFootsteps"
		"name" : "add jingle to footsteps"
		"hidden" : "0"
	}

	"override footstep sound set" : {
		"effect_type" : "positive"
		"name" : "override footstep sound set"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "330"
		"attribute_class" : "override_footstep_sound_set"
		"hidden" : "1"
	}

	"mod shovel speed boost" : {
		"index" : "235"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ShovelSpeedBoost"
		"name" : "mod shovel speed boost"
		"hidden" : "0"
	}

	"fuse bonus" : {
		"index" : "787"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "fuse_mult"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Fuse_Bonus"
		"name" : "fuse bonus"
		"hidden" : "0"
	}

	"halloween fire rate bonus" : {
		"effect_type" : "positive"
		"name" : "halloween fire rate bonus"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"index" : "549"
		"attribute_class" : "hwn_mult_postfiredelay"
		"hidden" : "1"
	}

	"SET BONUS: move speed set bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_movespeed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"name" : "SET BONUS: move speed set bonus"
		"index" : "489"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"tool needs giftwrap" : {
		"name" : "tool needs giftwrap"
		"stored_as_integer" : "1"
		"index" : "786"
		"attribute_class" : "tool_needs_giftwrap"
		"hidden" : "1"
	}

	"increase buff duration HIDDEN" : {
		"index" : "357"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_buff_duration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BuffTime_Increased"
		"name" : "increase buff duration HIDDEN"
		"hidden" : "1"
	}

	"extinguish reduces cooldown" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_ExtinguishReducesCooldown"
		"name" : "extinguish reduces cooldown"
		"description_format" : "value_is_percentage"
		"index" : "784"
		"attribute_class" : "extinguish_reduces_cooldown"
		"hidden" : "0"
	}

	"extinguish restores health" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_ExtinguishRestoresHealth"
		"name" : "extinguish restores health"
		"description_format" : "value_is_additive"
		"index" : "783"
		"attribute_class" : "extinguish_restores_health"
		"hidden" : "0"
	}

	"melee attack rate bonus" : {
		"index" : "396"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_postfiredelay"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MeleeRate_Positive"
		"name" : "melee attack rate bonus"
		"hidden" : "0"
	}

	"ammo gives charge" : {
		"index" : "782"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "ammo_gives_charge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AmmoGivesCharge"
		"name" : "ammo gives charge"
		"hidden" : "0"
	}

	"SET BONUS: calling card on kill" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "calling_card_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CallingCardOnKill"
		"name" : "SET BONUS: calling card on kill"
		"index" : "537"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"switch from wep deploy time decreased" : {
		"index" : "199"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_switch_from_wep_deploy_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SingleWepHolsterBonus"
		"name" : "switch from wep deploy time decreased"
		"hidden" : "0"
	}

	"unique craft index" : {
		"effect_type" : "positive"
		"name" : "unique craft index"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "229"
		"attribute_class" : "unique_craft_index"
		"hidden" : "1"
	}

	"mod soldier buff type" : {
		"index" : "116"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_buff_type"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SoldierBuffType"
		"name" : "mod soldier buff type"
		"hidden" : "1"
	}

	"merasmus hat level display ONLY" : {
		"index" : "453"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "merasmus_hat_level_display_ONLY"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Merasmus_Hat_Level"
		"name" : "merasmus hat level display ONLY"
		"hidden" : "0"
	}

	"is_a_sword" : {
		"effect_type" : "neutral"
		"description_string" : "#Attrib_IsASword"
		"name" : "is_a_sword"
		"description_format" : "value_is_additive"
		"index" : "781"
		"attribute_class" : "is_a_sword"
		"hidden" : "0"
	}

	"critboost" : {
		"index" : "273"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "critboost"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritBoost"
		"name" : "critboost"
		"hidden" : "0"
	}

	"projectile spread angle penalty" : {
		"index" : "411"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "projectile_spread_angle"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Projectile_Spread_Angle_Negative"
		"name" : "projectile spread angle penalty"
		"hidden" : "0"
	}

	"engy sentry fire rate increased" : {
		"index" : "343"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_sentry_firerate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SentryFireRate_Increased"
		"name" : "engy sentry fire rate increased"
		"hidden" : "0"
	}

	"charge meter on hit" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HitsRefillMeter"
		"name" : "charge meter on hit"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "charge_meter_on_hit"
		"index" : "778"
	}

	"boost on damage" : {
		"index" : "418"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "boost_on_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BoostOnDamage"
		"name" : "boost on damage"
		"hidden" : "0"
	}

	"heal on hit for slowfire" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onhit_addhealth"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealOnHit_Positive"
		"name" : "heal on hit for slowfire"
		"index" : "110"
		"hidden" : "0"
	}

	"hat only unusual effect" : {
		"can_affect_market_name" : "1"
		"index" : "747"
		"stored_as_integer" : "0"
		"description_format" : "value_is_particle_index"
		"attribute_class" : "hat_only_unusual_effect"
		"effect_type" : "unusual"
		"name" : "hat only unusual effect"
		"hidden" : "1"
	}

	"major increased jump height" : {
		"index" : "443"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_jump_height"
		"effect_type" : "positive"
		"name" : "major increased jump height"
		"hidden" : "0"
		"armory_desc" : "on_wearer"
	}

	"taunt turn speed" : {
		"effect_type" : "positive"
		"name" : "taunt turn speed"
		"description_format" : "value_is_additive"
		"index" : "646"
		"attribute_class" : "taunt_turn_speed"
		"hidden" : "1"
	}

	"single wep holster time increased" : {
		"index" : "772"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_switch_from_wep_deploy_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SingleWepHolsterPenalty"
		"name" : "single wep holster time increased"
		"hidden" : "0"
	}

	"cannot_transmute" : {
		"name" : "cannot_transmute"
		"description_format" : "value_is_additive"
		"index" : "762"
		"hidden" : "1"
		"attribute_class" : "cannot_transmute"
	}

	"gesture speed increase" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_gesture_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_GestureSpeed_Increase"
		"name" : "gesture speed increase"
		"index" : "201"
		"hidden" : "0"
	}

	"taunt move speed" : {
		"effect_type" : "positive"
		"name" : "taunt move speed"
		"description_format" : "value_is_additive"
		"index" : "689"
		"attribute_class" : "taunt_move_speed"
		"hidden" : "1"
	}

	"always_transmit_so" : {
		"name" : "always_transmit_so"
		"description_format" : "value_is_additive"
		"index" : "754"
		"hidden" : "1"
		"attribute_class" : "always_transmit_so"
	}

	"ubercharge" : {
		"index" : "274"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "ubercharge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Ubercharge"
		"name" : "ubercharge"
		"hidden" : "0"
	}

	"hide crate series number" : {
		"name" : "hide crate series number"
		"stored_as_integer" : "1"
		"index" : "744"
		"attribute_class" : "hide_crate_series_number"
		"hidden" : "1"
	}

	"hide_strange_prefix" : {
		"name" : "hide_strange_prefix"
		"description_format" : "value_is_additive"
		"index" : "753"
		"hidden" : "1"
		"attribute_class" : "hide_strange_prefix"
	}

	"is giger counter" : {
		"name" : "is giger counter"
		"description_format" : "value_is_additive"
		"index" : "752"
		"hidden" : "1"
		"attribute_class" : "is_giger_counter"
	}

	"taunt only unusual effect" : {
		"can_affect_market_name" : "1"
		"index" : "750"
		"stored_as_integer" : "1"
		"description_format" : "value_is_particle_index"
		"attribute_class" : "taunt_only_unusual_effect"
		"effect_type" : "unusual"
		"name" : "taunt only unusual effect"
		"hidden" : "1"
	}

	"single wep deploy time decreased" : {
		"index" : "547"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_single_wep_deploy_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SingleWepDeployBonus"
		"name" : "single wep deploy time decreased"
		"hidden" : "0"
	}

	"community description" : {
		"index" : "132"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "desc_community_description"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Community_Description"
		"name" : "community description"
		"hidden" : "1"
	}

	"items traded in for" : {
		"index" : "748"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "items_traded_in_for"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_ItemsTradedIn"
		"name" : "items traded in for"
		"hidden" : "1"
	}

	"single wep deploy time increased" : {
		"index" : "773"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_single_wep_deploy_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SingleWepDeployPenalty"
		"name" : "single wep deploy time increased"
		"hidden" : "0"
	}

	"cosmetic_allow_inspect" : {
		"name" : "cosmetic_allow_inspect"
		"description_format" : "value_is_additive"
		"index" : "746"
		"hidden" : "1"
		"attribute_class" : "cosmetic_allow_inspect"
	}

	"style changes on strange level" : {
		"name" : "style changes on strange level"
		"stored_as_integer" : "1"
		"index" : "742"
		"attribute_class" : "style_changes_on_strange_level"
		"hidden" : "1"
	}

	"bombinomicon effect on death" : {
		"index" : "334"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "bombinomicon_effect_on_death"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BombinomiconEffectOnDeath"
		"name" : "bombinomicon effect on death"
		"hidden" : "0"
	}

	"speed_boost_on_kill" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_SpeedBoostOnKill"
		"name" : "speed_boost_on_kill"
		"description_format" : "value_is_additive"
		"index" : "736"
		"attribute_class" : "speed_boost_on_kill"
		"hidden" : "0"
	}

	"crit_vs_burning_FLARES_DISPLAY_ONLY" : {
		"index" : "735"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "crit_vs_burning_FLARES_DISPLAY_ONLY"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritVsBurning"
		"name" : "crit_vs_burning_FLARES_DISPLAY_ONLY"
		"hidden" : "0"
	}

	"healing received penalty" : {
		"index" : "734"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_healing_received"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealingReceivedPenalty"
		"name" : "healing received penalty"
		"hidden" : "0"
	}

	"use large smoke explosion" : {
		"effect_type" : "positive"
		"name" : "use large smoke explosion"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "521"
		"attribute_class" : "use_large_smoke_explosion"
		"hidden" : "1"
	}

	"ubercharge_preserved_on_spawn_max" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "ubercharge_preserved_on_spawn_max"
		"effect_type" : "positive"
		"description_string" : "#Attrib_UberchargeSavedOnHit"
		"name" : "ubercharge_preserved_on_spawn_max"
		"index" : "811"
		"hidden" : "0"
	}

	"metal_pickup_decreased" : {
		"index" : "732"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_metal_pickup"
		"effect_type" : "negative"
		"description_string" : "#Attrib_metal_pickup_decreased"
		"name" : "metal_pickup_decreased"
		"hidden" : "0"
	}

	"strange restriction user value 2" : {
		"effect_type" : "positive"
		"name" : "strange restriction user value 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "461"
		"attribute_class" : "strange_restriction_user_value_2"
		"hidden" : "1"
	}

	"dmg bonus vs buildings" : {
		"index" : "137"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_vs_buildings"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgVsBuilding_Increased"
		"name" : "dmg bonus vs buildings"
		"hidden" : "0"
	}

	"mult decloak rate" : {
		"index" : "221"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mult_decloak_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DecloakRate"
		"name" : "mult decloak rate"
		"hidden" : "0"
	}

	"powerup charges" : {
		"index" : "271"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "powerup_charges"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PowerupCharges"
		"name" : "powerup charges"
		"hidden" : "0"
	}

	"ReducedCloakFromAmmo" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_ReducedCloakFromAmmo"
		"name" : "ReducedCloakFromAmmo"
		"description_format" : "value_is_percentage"
		"index" : "729"
		"attribute_class" : "ReducedCloakFromAmmo"
		"hidden" : "0"
	}

	"collection bits DEPRECATED" : {
		"index" : "198"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "collection_bits_DEPRECATED"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Halloween_Item"
		"name" : "collection bits DEPRECATED"
		"hidden" : "1"
	}

	"sticky arm time bonus" : {
		"index" : "126"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sticky_arm_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_StickyArmTimeBonus"
		"name" : "sticky arm time bonus"
		"hidden" : "0"
	}

	"medigun blast resist passive" : {
		"effect_type" : "positive"
		"name" : "medigun blast resist passive"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "504"
		"attribute_class" : "medigun_blast_resist_passive"
		"hidden" : "1"
	}

	"crit on hard hit" : {
		"effect_type" : "positive"
		"name" : "crit on hard hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "2030"
		"attribute_class" : "crit_on_hard_hit"
		"hidden" : "1"
	}

	"random drop line item footer desc" : {
		"index" : "2045"
		"name" : "random drop line item footer desc"
		"hidden" : "1"
		"attribute_type" : "string"
	}

	"sniper fires tracer" : {
		"index" : "305"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_fires_tracer"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sniper_FiresTracer"
		"name" : "sniper fires tracer"
		"hidden" : "0"
	}

	"cloak_consume_on_feign_death_activate" : {
		"index" : "726"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "cloak_consume_on_feign_death_activate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ConsumeCloakFeignDeath"
		"name" : "cloak_consume_on_feign_death_activate"
		"hidden" : "0"
	}

	"mult charge turn control" : {
		"index" : "246"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "charge_turn_control"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChargeTurnControl"
		"name" : "mult charge turn control"
		"hidden" : "0"
	}

	"self mark for death" : {
		"index" : "414"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "self_mark_for_death"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SelfMarkForDeath"
		"name" : "self mark for death"
		"hidden" : "0"
	}

	"mod demo buff type" : {
		"index" : "122"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_buff_type"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DemoBuffType"
		"name" : "mod demo buff type"
		"hidden" : "1"
	}

	"auto fires when full" : {
		"index" : "711"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "auto_fires_when_full"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AutoFiresWhenFull"
		"name" : "auto fires when full"
		"hidden" : "0"
	}

	"no_attack" : {
		"name" : "no_attack"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "821"
		"attribute_class" : "no_attack"
		"hidden" : "1"
	}

	"medigun blast resist deployed" : {
		"effect_type" : "positive"
		"name" : "medigun blast resist deployed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "507"
		"attribute_class" : "medigun_blast_resist_deployed"
		"hidden" : "1"
	}

	"multiple sentries" : {
		"index" : "277"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "multiple_sentries"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MultipleSentries"
		"name" : "multiple sentries"
		"hidden" : "0"
	}

	"set cloak is movement based" : {
		"armory_desc" : "cloak_type"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_CloakIsMovementBased"
		"name" : "set cloak is movement based"
		"index" : "48"
		"hidden" : "0"
	}

	"overheal decay penalty" : {
		"index" : "12"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_medigun_overheal_decay"
		"effect_type" : "negative"
		"description_string" : "#Attrib_OverhealDecay_Negative"
		"name" : "overheal decay penalty"
		"hidden" : "0"
	}

	"panic_attack_negative" : {
		"index" : "709"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "panic_attack_negative"
		"effect_type" : "negative"
		"description_string" : "#Attrib_PanicAttackNegative"
		"name" : "panic_attack_negative"
		"hidden" : "0"
	}

	"Set DamageType Ignite" : {
		"index" : "208"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_dmgtype_ignite"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SetDamageType_Ignite"
		"name" : "Set DamageType Ignite"
		"hidden" : "0"
	}

	"heal on kill" : {
		"index" : "180"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "heal_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealOnKill"
		"name" : "heal on kill"
		"hidden" : "0"
	}

	"panic_attack" : {
		"index" : "708"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "panic_attack"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PanicAttack"
		"name" : "panic_attack"
		"hidden" : "0"
	}

	"dmg taken from blast reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_explosions"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Blast_Reduced"
		"name" : "dmg taken from blast reduced"
		"index" : "64"
		"hidden" : "0"
	}

	"duck badge level" : {
		"index" : "702"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "duck_badge_level"
		"effect_type" : "positive"
		"description_string" : "#Attrib_duck_badge_level"
		"name" : "duck badge level"
		"hidden" : "0"
	}

	"damage causes airblast" : {
		"effect_type" : "positive"
		"name" : "damage causes airblast"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "522"
		"attribute_class" : "damage_causes_airblast"
		"hidden" : "0"
	}

	"bleeding duration" : {
		"armory_desc" : "on_hit bleed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "bleeding_duration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BleedingDuration"
		"name" : "bleeding duration"
		"index" : "149"
		"hidden" : "0"
	}

	"SET BONUS: alien isolation xeno bonus neg" : {
		"index" : "694"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "alien_isolation_xeno_bonus_neg"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AiXenoSetBonusNeg"
		"name" : "SET BONUS: alien isolation xeno bonus neg"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"melts in fire" : {
		"index" : "359"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "melts_in_fire"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MeltsInFire"
		"name" : "melts in fire"
		"hidden" : "0"
	}

	"spawn with physics toy" : {
		"effect_type" : "positive"
		"name" : "spawn with physics toy"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "331"
		"attribute_class" : "spawn_with_physics_toy"
		"hidden" : "1"
	}

	"sniper crit no scope" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_SniperCritNoScope"
		"name" : "sniper crit no scope"
		"description_format" : "value_is_additive"
		"index" : "636"
		"attribute_class" : "sniper_crit_no_scope"
		"hidden" : "0"
	}

	"energy weapon no deflect" : {
		"index" : "285"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_no_deflect"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EnergyWeaponNoDeflect"
		"name" : "energy weapon no deflect"
		"hidden" : "0"
	}

	"scattergun no reload single" : {
		"index" : "43"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_scattergun_no_reload_single"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Scattergun_NoReloadSingle"
		"name" : "scattergun no reload single"
		"hidden" : "1"
	}

	"mult_spread_scale_first_shot" : {
		"name" : "mult_spread_scale_first_shot"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "804"
		"attribute_class" : "mult_spread_scale_first_shot"
		"hidden" : "1"
	}

	"sapper health penalty" : {
		"index" : "429"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sapper_health"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sapper_Health_Penalty"
		"name" : "sapper health penalty"
		"hidden" : "0"
	}

	"taunt move acceleration time" : {
		"effect_type" : "positive"
		"name" : "taunt move acceleration time"
		"description_format" : "value_is_additive"
		"index" : "688"
		"attribute_class" : "taunt_move_acceleration"
		"hidden" : "1"
	}

	"projectile entity name" : {
		"effect_type" : "positive"
		"name" : "projectile entity name"
		"index" : "615"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "projectile_entity_name"
		"attribute_type" : "string"
	}

	"tickle enemies wielding same weapon" : {
		"index" : "369"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "tickle_enemies_wielding_same_weapon"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TickleEnemiesWieldingSameWeapon"
		"name" : "tickle enemies wielding same weapon"
		"hidden" : "0"
	}

	"axtinguisher properties" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_AxtinguisherProperties"
		"name" : "axtinguisher properties"
		"description_format" : "value_is_additive"
		"index" : "638"
		"attribute_class" : "axtinguisher_properties"
		"hidden" : "0"
	}

	"sapper damage bonus" : {
		"index" : "425"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sapper_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Damage_Bonus"
		"name" : "sapper damage bonus"
		"hidden" : "0"
	}

	"stickybomb charge rate" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_stickybomb_charge_rate"
		"name" : "stickybomb charge rate"
		"description_format" : "value_is_inverted_percentage"
		"index" : "670"
		"attribute_class" : "stickybomb_charge_rate"
		"hidden" : "0"
	}

	"crate generation code" : {
		"effect_type" : "positive"
		"name" : "crate generation code"
		"index" : "662"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "crate_generation_code"
		"attribute_type" : "string"
	}

	"tag__summer2014" : {
		"index" : "661"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tag__summer2014"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Summer2014Tag"
		"name" : "tag__summer2014"
		"hidden" : "0"
	}

	"sniper fires tracer HIDDEN" : {
		"index" : "647"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sniper_fires_tracer_HIDDEN"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sniper_FiresTracer"
		"name" : "sniper fires tracer HIDDEN"
		"hidden" : "1"
	}

	"strange part new counter ID" : {
		"effect_type" : "positive"
		"name" : "strange part new counter ID"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "385"
		"attribute_class" : "strange_part_new_counter_id"
		"hidden" : "1"
	}

	"mini rockets" : {
		"effect_type" : "positive"
		"name" : "mini rockets"
		"description_format" : "value_is_additive"
		"index" : "642"
		"attribute_class" : "mini_rockets"
		"hidden" : "1"
	}

	"item in slot 7" : {
		"index" : "3013"
		"name" : "item in slot 7"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"flame ammopersec increased" : {
		"index" : "173"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_ammopersec"
		"effect_type" : "negative"
		"description_string" : "#Attrib_FlameAmmoPerSec_Increased"
		"name" : "flame ammopersec increased"
		"hidden" : "0"
	}

	"health from healers reduced" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_health_fromhealers"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealthFromHealers_Reduced"
		"name" : "health from healers reduced"
		"index" : "69"
		"hidden" : "0"
	}

	"SET BONUS: cloak blink time penalty" : {
		"index" : "159"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cloak_blink_time_penalty"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CloakBlinkTimePenalty"
		"name" : "SET BONUS: cloak blink time penalty"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"back headshot" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_BackHeadshot"
		"name" : "back headshot"
		"description_format" : "value_is_additive"
		"index" : "630"
		"attribute_class" : "back_headshot"
		"hidden" : "0"
	}

	"full charge turn control" : {
		"index" : "639"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "charge_turn_control"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChargeTurnControlFull"
		"name" : "full charge turn control"
		"hidden" : "0"
	}

	"closerange backattack minicrits" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_BackAttackMinicrits"
		"name" : "closerange backattack minicrits"
		"description_format" : "value_is_additive"
		"index" : "619"
		"attribute_class" : "closerange_backattack_minicrits"
		"hidden" : "0"
	}

	"air jump on attack" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirJumpOnAttack"
		"name" : "air jump on attack"
		"description_format" : "value_is_additive"
		"index" : "634"
		"attribute_class" : "air_jump_on_attack"
		"hidden" : "1"
	}

	"projectile particle name" : {
		"effect_type" : "positive"
		"name" : "projectile particle name"
		"index" : "633"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "projectile_particle_name"
		"attribute_type" : "string"
	}

	"rj air bombardment" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirBombardment"
		"name" : "rj air bombardment"
		"description_format" : "value_is_additive"
		"index" : "632"
		"attribute_class" : "rj_air_bombardment"
		"hidden" : "0"
	}

	"Construction rate increased" : {
		"index" : "92"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_construction_value"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ConstructionRate_Increased"
		"name" : "Construction rate increased"
		"hidden" : "0"
	}

	"custom_paintkit_seed_hi" : {
		"name" : "custom_paintkit_seed_hi"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "867"
		"attribute_class" : "custom_paintkit_seed_hi"
		"hidden" : "1"
	}

	"torso scale" : {
		"effect_type" : "negative"
		"name" : "torso scale"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "620"
		"attribute_class" : "torso_scale"
		"hidden" : "0"
	}

	"auto fires full clip all at once" : {
		"index" : "441"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "auto_fires_full_clip_all_at_once"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AutoFiresFullClipAllAtOnce"
		"name" : "auto fires full clip all at once"
		"hidden" : "0"
	}

	"ring of fire while aiming" : {
		"index" : "430"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "ring_of_fire_while_aiming"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Ring_Of_Fire_While_Aiming"
		"name" : "ring of fire while aiming"
		"hidden" : "0"
	}

	"thermal_thruster" : {
		"effect_type" : "positive"
		"name" : "thermal_thruster"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "873"
		"attribute_class" : "thermal_thruster"
		"hidden" : "1"
	}

	"no metal from dispensers while active" : {
		"index" : "614"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_metal_from_dispensers_while_active"
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoMetalFromDispensersWhileActive"
		"name" : "no metal from dispensers while active"
		"hidden" : "0"
	}

	"airblast vulnerability multiplier" : {
		"index" : "329"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "airblast_vulnerability_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirBlastVulnerabilityMultipier"
		"name" : "airblast vulnerability multiplier"
		"hidden" : "0"
	}

	"minigun spinup time decreased" : {
		"index" : "87"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_minigun_spinup_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MinigunSpinup_Decreased"
		"name" : "minigun spinup time decreased"
		"hidden" : "0"
	}

	"currency bonus" : {
		"index" : "325"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "currency_bonus"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CurrencyBonus"
		"name" : "currency bonus"
		"hidden" : "0"
	}

	"grenade no spin" : {
		"effect_type" : "positive"
		"name" : "grenade no spin"
		"description_format" : "value_is_additive"
		"index" : "681"
		"attribute_class" : "grenade_no_spin"
		"hidden" : "1"
	}

	"cannot trade" : {
		"index" : "153"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cannot_trade"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_CannotTrade"
		"name" : "cannot trade"
		"hidden" : "1"
	}

	"medigun charge is crit boost" : {
		"index" : "18"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_charge_type"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Medigun_CritBoost"
		"name" : "medigun charge is crit boost"
		"hidden" : "0"
	}

	"referenced item id high" : {
		"index" : "193"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "referenced_item_id_high"
		"effect_type" : "negative"
		"name" : "referenced item id high"
		"hidden" : "1"
		"armory_desc" : "on_wearer"
	}

	"taunt success sound" : {
		"index" : "606"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"name" : "taunt success sound"
		"attribute_class" : "taunt_success_sound"
		"attribute_type" : "string"
	}

	"subtract victim cloak on hit" : {
		"index" : "338"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "subtract_victim_cloak_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SubtractVictimCloakOnHit"
		"name" : "subtract victim cloak on hit"
		"hidden" : "0"
	}

	"alt fire teleport to spawn" : {
		"index" : "352"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "alt_fire_teleport_to_spawn"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AltFireTeleportToSpawn"
		"name" : "alt fire teleport to spawn"
		"hidden" : "0"
	}

	"medigun bullet resist deployed" : {
		"effect_type" : "positive"
		"name" : "medigun bullet resist deployed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "506"
		"attribute_class" : "medigun_bullet_resist_deployed"
		"hidden" : "1"
	}

	"taunt force move forward" : {
		"effect_type" : "positive"
		"name" : "taunt force move forward"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "600"
		"attribute_class" : "taunt_force_move_forward"
		"hidden" : "1"
	}

	"Halloween Spellbook Page: Congeriae" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpellbookPage_D"
		"name" : "Halloween Spellbook Page: Congeriae"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tf_halloween_spell_page"
		"index" : "2019"
	}

	"revive" : {
		"index" : "554"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "revive"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Revive"
		"name" : "revive"
		"hidden" : "0"
	}

	"scattergun has knockback" : {
		"index" : "44"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_scattergun_has_knockback"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Scattergun_HasKnockback"
		"name" : "scattergun has knockback"
		"hidden" : "0"
	}

	"flame ammopersec decreased" : {
		"index" : "174"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_ammopersec"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FlameAmmoPerSec_Decreased"
		"name" : "flame ammopersec decreased"
		"hidden" : "0"
	}

	"become fireproof on hit by fire" : {
		"index" : "361"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "become_fireproof_on_hit_by_fire"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BecomeFireproofOnHitByFire"
		"name" : "become fireproof on hit by fire"
		"hidden" : "0"
	}

	"overheal bonus" : {
		"index" : "11"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_overheal_amount"
		"effect_type" : "positive"
		"description_string" : "#Attrib_OverhealAmount_Positive"
		"name" : "overheal bonus"
		"hidden" : "0"
	}

	"electrical airblast DISPLAY ONLY" : {
		"index" : "300"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "electrical_airblast_DISPLAY_ONLY"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ElectricalAirblast"
		"name" : "electrical airblast DISPLAY ONLY"
		"hidden" : "0"
	}

	"bot medic uber deploy delay duration" : {
		"name" : "bot medic uber deploy delay duration"
		"description_format" : "value_is_additive"
		"index" : "546"
		"hidden" : "1"
		"attribute_class" : "bot_medic_uber_deploy_delay_duration"
	}

	"set item tint RGB" : {
		"index" : "142"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_item_tint_rgb"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_SetItemTintRGB"
		"name" : "set item tint RGB"
		"hidden" : "1"
	}

	"item in slot 3" : {
		"index" : "3005"
		"name" : "item in slot 3"
		"attribute_class" : "item_in_slot"
		"attribute_type" : "uint64"
	}

	"paint decal enum" : {
		"name" : "paint decal enum"
		"description_format" : "value_is_additive"
		"index" : "543"
		"hidden" : "1"
		"attribute_class" : "paint_decal_enum"
	}

	"damage force increase text" : {
		"index" : "536"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "damage_force_reduction"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DamageForceIncreaseString"
		"name" : "damage force increase text"
		"hidden" : "0"
	}

	"mad milk syringes" : {
		"index" : "484"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mad_milk_syringes"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Medic_MadMilkSyringes"
		"name" : "mad milk syringes"
		"hidden" : "0"
	}

	"cleaver description" : {
		"index" : "435"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "desc_cleaver_description"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Cleaver_Description"
		"name" : "cleaver description"
		"hidden" : "0"
	}

	"bidirectional teleport" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_BiDirectionalTP"
		"name" : "bidirectional teleport"
		"description_format" : "value_is_additive"
		"index" : "276"
		"attribute_class" : "bidirectional_teleport"
		"hidden" : "0"
	}

	"duel loser account id" : {
		"index" : "184"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "duel_loser_account_id"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_DuelLoserAccountID"
		"name" : "duel loser account id"
		"hidden" : "0"
	}

	"airblast vulnerability multiplier hidden" : {
		"index" : "534"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "airblast_vulnerability_multiplier"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AirBlastVulnerabilityMultipier"
		"name" : "airblast vulnerability multiplier hidden"
		"hidden" : "1"
	}

	"SET BONUS: custom taunt particle attr" : {
		"index" : "533"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "custom_taunt_particle_attr"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TauntParticles"
		"name" : "SET BONUS: custom taunt particle attr"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"fire rate penalty" : {
		"index" : "5"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_postfiredelay"
		"effect_type" : "negative"
		"description_string" : "#Attrib_FireRate_Negative"
		"name" : "fire rate penalty"
		"hidden" : "0"
	}

	"tool escrow until date" : {
		"index" : "374"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"attribute_class" : "tool_escrow_until_date"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ToolEscrowUntilDate"
		"name" : "tool escrow until date"
		"hidden" : "1"
	}

	"energy weapon no ammo" : {
		"index" : "281"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_no_ammo"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EnergyWeaponNoAmmo"
		"name" : "energy weapon no ammo"
		"hidden" : "0"
	}

	"maxammo secondary increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_secondary"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxammoSecondary_Increased"
		"name" : "maxammo secondary increased"
		"index" : "78"
		"hidden" : "0"
	}

	"SET BONUS: alien isolation xeno bonus pos" : {
		"index" : "693"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "alien_isolation_xeno_bonus_pos"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AiXenoSetBonusPos"
		"name" : "SET BONUS: alien isolation xeno bonus pos"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"SET BONUS: max health additive bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_maxhealth"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"name" : "SET BONUS: max health additive bonus"
		"index" : "517"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"auto fires full clip penalty" : {
		"index" : "710"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "auto_fires_full_clip"
		"effect_type" : "negative"
		"description_string" : "#Attrib_AutoFiresFullClipNegative"
		"name" : "auto fires full clip penalty"
		"hidden" : "0"
	}

	"weapon burn dmg reduced" : {
		"index" : "72"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_wpn_burndmg"
		"effect_type" : "negative"
		"description_string" : "#Attrib_WpnBurnDmg_Reduced"
		"name" : "weapon burn dmg reduced"
		"hidden" : "0"
	}

	"mod rage on hit penalty" : {
		"index" : "243"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "rage_on_hit"
		"effect_type" : "negative"
		"description_string" : "#Attrib_RageOnHitPenalty"
		"name" : "mod rage on hit penalty"
		"hidden" : "0"
	}

	"add uber charge on hit" : {
		"armory_desc" : "on_hit"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive_percentage"
		"attribute_class" : "add_onhit_ubercharge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AddUber_OnHit_Positive"
		"name" : "add uber charge on hit"
		"index" : "17"
		"hidden" : "0"
	}

	"mod medic killed revenge" : {
		"index" : "230"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "medic_killed_revenge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MedicKilledRevenge"
		"name" : "mod medic killed revenge"
		"hidden" : "0"
	}

	"Reload time increased" : {
		"index" : "96"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_reload_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ReloadTime_Increased"
		"name" : "Reload time increased"
		"hidden" : "0"
	}

	"Blast radius decreased" : {
		"index" : "100"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_explosion_radius"
		"effect_type" : "negative"
		"description_string" : "#Attrib_BlastRadius_Decreased"
		"name" : "Blast radius decreased"
		"hidden" : "0"
	}

	"mod medic killed marked for death" : {
		"index" : "242"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "medic_killed_marked_for_death"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MedicKilledMarkedForDeath"
		"name" : "mod medic killed marked for death"
		"hidden" : "0"
	}

	"halloweenvision opt in DISPLAY ONLY" : {
		"index" : "446"
		"stored_as_integer" : "0"
		"description_format" : "value_is_or"
		"attribute_class" : "halloweenvision_opt_in_display_only"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "halloweenvision opt in DISPLAY ONLY"
		"hidden" : "0"
	}

	"sniper full charge damage bonus" : {
		"index" : "304"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "sniper_full_charge_damage_bonus"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sniper_FullChargeBonus"
		"name" : "sniper full charge damage bonus"
		"hidden" : "0"
	}

	"min_viewmodel_offset" : {
		"name" : "min_viewmodel_offset"
		"index" : "796"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "min_viewmodel_offset"
		"attribute_type" : "string"
	}

	"clip size penalty HIDDEN" : {
		"index" : "424"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_clipsize"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ClipSize_Negative"
		"name" : "clip size penalty HIDDEN"
		"hidden" : "1"
	}

	"engineer teleporter build rate multiplier" : {
		"index" : "465"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "teleporter_build_rate_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Teleporter_Build_Rate"
		"name" : "engineer teleporter build rate multiplier"
		"hidden" : "0"
	}

	"charge recharge rate increased" : {
		"index" : "249"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "charge_recharge_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChargeRechargeRateIncreased"
		"name" : "charge recharge rate increased"
		"hidden" : "0"
	}

	"custom employee number" : {
		"index" : "143"
		"stored_as_integer" : "1"
		"description_format" : "value_is_date"
		"attribute_class" : "set_employee_number"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_EmployeeNumber"
		"name" : "custom employee number"
		"hidden" : "0"
	}

	"throwable fire speed" : {
		"effect_type" : "positive"
		"name" : "throwable fire speed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "512"
		"attribute_class" : "throwable_fire_speed"
		"hidden" : "1"
	}

	"is marketable" : {
		"index" : "2028"
		"attribute_class" : "is_marketable"
		"hidden" : "1"
		"name" : "is marketable"
	}

	"add cloak on kill" : {
		"index" : "158"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_cloak_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AddCloakOnKill"
		"name" : "add cloak on kill"
		"hidden" : "0"
	}

	"pyro year number" : {
		"index" : "420"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "pyro_year_number"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PyroYearNumber"
		"name" : "pyro year number"
		"hidden" : "0"
	}

	"sniper charge per sec" : {
		"index" : "41"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_per_sec"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SniperCharge_Per_Sec"
		"name" : "sniper charge per sec"
		"hidden" : "0"
	}

	"jarate backstabber" : {
		"index" : "341"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "jarate_backstabber"
		"effect_type" : "positive"
		"description_string" : "#Attrib_JarateBackstabber"
		"name" : "jarate backstabber"
		"hidden" : "0"
	}

	"set icicle knife mode" : {
		"index" : "365"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SetIcicleKnifeMode"
		"name" : "set icicle knife mode"
		"hidden" : "1"
	}

	"accepted wedding ring account id 1" : {
		"index" : "372"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "accepted_wedding_ring_account_id_1"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AcceptedWeddingRingAccount1"
		"name" : "accepted wedding ring account id 1"
		"hidden" : "0"
	}

	"increased air control" : {
		"index" : "610"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_air_control"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirControl"
		"name" : "increased air control"
		"hidden" : "0"
	}

	"weapon_allow_inspect" : {
		"name" : "weapon_allow_inspect"
		"description_format" : "value_is_additive"
		"index" : "731"
		"hidden" : "1"
		"attribute_class" : "weapon_allow_inspect"
	}

	"minicritboost on kill" : {
		"armory_desc" : "on_kill"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onkill_minicritboost_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MiniCritBoost_OnKill"
		"name" : "minicritboost on kill"
		"index" : "613"
		"hidden" : "0"
	}

	"deploy time increased" : {
		"index" : "177"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_deploy_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DeployTime_Increased"
		"name" : "deploy time increased"
		"hidden" : "0"
	}

	"referenced item def UPDATED" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "1"
		"description_format" : "value_is_item_def"
		"attribute_class" : "referenced_item_def"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_ReferencedItem"
		"name" : "referenced item def UPDATED"
		"index" : "194"
		"hidden" : "1"
	}

	"texture_wear_default" : {
		"name" : "texture_wear_default"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "749"
		"attribute_class" : "texture_wear_default"
		"hidden" : "1"
	}

	"mod wrench builds minisentry" : {
		"index" : "124"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "wrench_builds_minisentry"
		"effect_type" : "negative"
		"description_string" : "#Attrib_WrenchBuildsMiniSentry"
		"name" : "mod wrench builds minisentry"
		"hidden" : "0"
	}

	"airblast vertical vulnerability multiplier" : {
		"index" : "405"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "airblast_vertical_vulnerability_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirBlastVerticalVulnerabilityMultipier"
		"name" : "airblast vertical vulnerability multiplier"
		"hidden" : "0"
	}

	"kill forces attacker to laugh" : {
		"index" : "409"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "kill_forces_attacker_to_laugh"
		"effect_type" : "positive"
		"description_string" : "#Attrib_KillForcesAttackerLaugh"
		"name" : "kill forces attacker to laugh"
		"hidden" : "0"
	}

	"medigun fire resist passive" : {
		"effect_type" : "positive"
		"name" : "medigun fire resist passive"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "505"
		"attribute_class" : "medigun_fire_resist_passive"
		"hidden" : "1"
	}

	"kill eater user score type 1" : {
		"effect_type" : "positive"
		"name" : "kill eater user score type 1"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "380"
		"attribute_class" : "kill_eater_user_score_type_1"
		"hidden" : "1"
	}

	"no charge impact range" : {
		"index" : "247"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_charge_impact_range"
		"effect_type" : "positive"
		"description_string" : "#Attrib_NoChargeImpactRange"
		"name" : "no charge impact range"
		"hidden" : "0"
	}

	"airblast cost decreased" : {
		"index" : "171"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_airblast_cost"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AirblastCost_Decreased"
		"name" : "airblast cost decreased"
		"hidden" : "0"
	}

	"shot penetrate all players" : {
		"index" : "389"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "shot_penetrate_all_players"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ShotPenetration"
		"name" : "shot penetrate all players"
		"hidden" : "0"
	}

	"mult sniper charge penalty DISPLAY ONLY" : {
		"index" : "268"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_base_dummy"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MultSniperChargePenalty"
		"name" : "mult sniper charge penalty DISPLAY ONLY"
		"hidden" : "0"
	}

	"sniper no headshots" : {
		"index" : "42"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SniperNoHeadshots"
		"name" : "sniper no headshots"
		"hidden" : "0"
	}

	"critboost on kill" : {
		"armory_desc" : "on_kill"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_onkill_critboost_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritBoost_OnKill"
		"name" : "critboost on kill"
		"index" : "31"
		"hidden" : "0"
	}

	"mod mini-crit airborne" : {
		"index" : "114"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mini_crit_airborne"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MiniCritAirborneEnemies"
		"name" : "mod mini-crit airborne"
		"hidden" : "0"
	}

	"sticky air burst mode" : {
		"index" : "127"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_detonate_mode"
		"effect_type" : "negative"
		"description_string" : "#Attrib_StickyAirBurstMode"
		"name" : "sticky air burst mode"
		"hidden" : "0"
	}

	"damage penalty on bodyshot" : {
		"index" : "392"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "bodyshot_damage_modify"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DamageDone_Bodyshot_Negative"
		"name" : "damage penalty on bodyshot"
		"hidden" : "0"
	}

	"bot custom jump particle" : {
		"effect_type" : "positive"
		"name" : "bot custom jump particle"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "498"
		"attribute_class" : "bot_custom_jump_particle"
		"hidden" : "1"
	}

	"disguise on backstab" : {
		"index" : "154"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_disguise_on_backstab"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DisguiseOnBackstab"
		"name" : "disguise on backstab"
		"hidden" : "0"
	}

	"dmg penalty vs buildings" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgVsBuilding_decreased"
		"name" : "dmg penalty vs buildings"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_vs_buildings"
		"index" : "775"
	}

	"mult sniper charge after headshot" : {
		"index" : "237"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sniper_charge_after_headshot"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MultSniperChargeAfterHeadshot"
		"name" : "mult sniper charge after headshot"
		"hidden" : "0"
	}

	"cloak consume rate decreased" : {
		"index" : "83"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CloakConsumeRate_Decreased"
		"name" : "cloak consume rate decreased"
		"hidden" : "0"
	}

	"energy weapon no drain" : {
		"index" : "349"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_no_drain"
		"effect_type" : "positive"
		"description_string" : ""
		"name" : "energy weapon no drain"
		"hidden" : "1"
	}

	"flame_gravity" : {
		"name" : "flame_gravity"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "841"
		"attribute_class" : "flame_gravity"
		"hidden" : "1"
	}

	"maxammo primary increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_primary"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxammoPrimary_Increased"
		"name" : "maxammo primary increased"
		"index" : "76"
		"hidden" : "0"
	}

	"particle effect use head origin" : {
		"effect_type" : "positive"
		"name" : "particle effect use head origin"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "520"
		"attribute_class" : "particle_effect_use_head_origin"
		"hidden" : "1"
	}

	"strange restriction value 3" : {
		"effect_type" : "positive"
		"name" : "strange restriction value 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "497"
		"attribute_class" : "strange_restriction_value_3"
		"hidden" : "1"
	}

	"max pipebombs decreased" : {
		"index" : "89"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_max_pipebombs"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MaxPipebombs_Decreased"
		"name" : "max pipebombs decreased"
		"hidden" : "0"
	}

	"energy weapon no hurt building" : {
		"index" : "284"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_no_hurt_building"
		"effect_type" : "negative"
		"description_string" : "#Attrib_EnergyWeaponNoHurtBuilding"
		"name" : "energy weapon no hurt building"
		"hidden" : "0"
	}

	"weapon_uses_stattrak_module" : {
		"effect_type" : "strange"
		"name" : "weapon_uses_stattrak_module"
		"index" : "719"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "weapon_uses_stattrak_module"
		"attribute_type" : "string"
	}

	"cloak regen rate decreased" : {
		"index" : "85"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_cloak_meter_regen_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CloakRegenRate_Decreased"
		"name" : "cloak regen rate decreased"
		"hidden" : "0"
	}

	"duck rating" : {
		"index" : "701"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "duck_rating"
		"effect_type" : "positive"
		"description_string" : "#Attrib_duck_rating"
		"name" : "duck rating"
		"hidden" : "0"
	}

	"accuracy scales damage" : {
		"index" : "324"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "accuracy_scales_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AccurScalesDmg"
		"name" : "accuracy scales damage"
		"hidden" : "0"
	}

	"sanguisuge" : {
		"index" : "217"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sanguisuge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sanguisuge"
		"name" : "sanguisuge"
		"hidden" : "0"
	}

	"rage on kill" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "rage_on_kill"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageGainOnKill"
		"name" : "rage on kill"
		"index" : "387"
		"hidden" : "0"
	}

	"dmg taken from fire increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_from_fire"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_From_Fire_Increased"
		"name" : "dmg taken from fire increased"
		"index" : "61"
		"hidden" : "0"
	}

	"aiming movespeed increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_aiming_movespeed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AimingMoveSpeed_Increased"
		"name" : "aiming movespeed increased"
		"index" : "75"
		"hidden" : "0"
	}

	"mult_end_flame_size" : {
		"effect_type" : "positive"
		"name" : "mult_end_flame_size"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "831"
		"attribute_class" : "mult_end_flame_size"
		"hidden" : "1"
	}

	"aiming knockback resistance" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_aiming_knockback_resistance"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AimingKnockbackResistance"
		"name" : "aiming knockback resistance"
		"index" : "377"
		"hidden" : "0"
	}

	"medigun fire resist deployed" : {
		"effect_type" : "positive"
		"name" : "medigun fire resist deployed"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "508"
		"attribute_class" : "medigun_fire_resist_deployed"
		"hidden" : "1"
	}

	"stun enemies wielding same weapon" : {
		"index" : "354"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "stun_enemies_wielding_same_weapon"
		"effect_type" : "positive"
		"description_string" : "#Attrib_StunEnemiesWieldingSameWeapon"
		"name" : "stun enemies wielding same weapon"
		"hidden" : "0"
	}

	"medigun crit fire percent bar deplete" : {
		"effect_type" : "positive"
		"name" : "medigun crit fire percent bar deplete"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "511"
		"attribute_class" : "medigun_crit_fire_percent_bar_deplete"
		"hidden" : "1"
	}

	"charge impact damage increased" : {
		"index" : "248"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "charge_impact_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ChargeImpactDamageIncreased"
		"name" : "charge impact damage increased"
		"hidden" : "0"
	}

	"afterburn immunity" : {
		"index" : "527"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "afterburn_immunity"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AfterburnImmunity"
		"name" : "afterburn immunity"
		"hidden" : "0"
	}

	"refill_ammo" : {
		"index" : "315"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "refill_ammo"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RefillAmmo"
		"name" : "refill_ammo"
		"hidden" : "0"
	}

	"heal rate penalty" : {
		"index" : "7"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_healrate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_HealRate_Negative"
		"name" : "heal rate penalty"
		"hidden" : "0"
	}

	"backstab shield" : {
		"index" : "52"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_blockbackstab_once"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BackstabShield"
		"name" : "backstab shield"
		"hidden" : "0"
	}

	"maxammo grenades1 increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_maxammo_grenades1"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxammoGrenades1_Increased"
		"name" : "maxammo grenades1 increased"
		"index" : "279"
		"hidden" : "0"
	}

	"overheal expert" : {
		"index" : "482"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "overheal_expert"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Overheal_Expert"
		"name" : "overheal expert"
		"hidden" : "0"
	}

	"minigun no spin sounds" : {
		"index" : "238"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "minigun_no_spin_sounds"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MinigunNoSpinSounds"
		"name" : "minigun no spin sounds"
		"hidden" : "0"
	}

	"move speed bonus shield required" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_movespeed_shieldrequired"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MoveSpeed_Bonus_ShieldRequired"
		"name" : "move speed bonus shield required"
		"index" : "788"
		"hidden" : "0"
	}

	"crit forces victim to laugh" : {
		"index" : "358"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "crit_forces_victim_to_laugh"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CritForcesLaugh"
		"name" : "crit forces victim to laugh"
		"hidden" : "0"
	}

	"health regen" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_health_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthRegen"
		"name" : "health regen"
		"index" : "57"
		"hidden" : "0"
	}

	"recall" : {
		"index" : "310"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "recall"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Recall"
		"name" : "recall"
		"hidden" : "0"
	}

	"cloak consume rate increased" : {
		"index" : "82"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CloakConsumeRate_Increased"
		"name" : "cloak consume rate increased"
		"hidden" : "0"
	}

	"minigun spinup time increased" : {
		"index" : "86"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_minigun_spinup_time"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MinigunSpinup_Increased"
		"name" : "minigun spinup time increased"
		"hidden" : "0"
	}

	"turn to gold" : {
		"index" : "150"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_turn_to_gold"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TurnToGold"
		"name" : "turn to gold"
		"hidden" : "0"
	}

	"allow_halloween_offering" : {
		"name" : "allow_halloween_offering"
		"description_format" : "value_is_additive"
		"index" : "760"
		"hidden" : "1"
		"attribute_class" : "allow_halloween_offering"
	}

	"max health additive bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_maxhealth"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"name" : "max health additive bonus"
		"index" : "26"
		"hidden" : "0"
	}

	"generate rage on heal" : {
		"index" : "499"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "generate_rage_on_heal"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageOnHeal"
		"name" : "generate rage on heal"
		"hidden" : "0"
	}

	"increase player capture value" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_player_capturevalue"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CaptureValue_Increased"
		"name" : "increase player capture value"
		"index" : "68"
		"hidden" : "0"
	}

	"mod stun waist high airborne" : {
		"index" : "366"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "stun_waist_high_airborne"
		"effect_type" : "positive"
		"description_string" : "#Attrib_StunWaistHighAirborne"
		"name" : "mod stun waist high airborne"
		"hidden" : "0"
	}

	"grenade launcher mortar mode" : {
		"index" : "466"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "grenade_launcher_mortar_mode"
		"effect_type" : "neutral"
		"description_string" : "#Attrib_Grenade_Launcher_Mortar_Mode"
		"name" : "grenade launcher mortar mode"
		"hidden" : "0"
	}

	"effect bar recharge rate increased" : {
		"index" : "278"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "effectbar_recharge_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EffectBarRechargeRateIncreased"
		"name" : "effect bar recharge rate increased"
		"hidden" : "0"
	}

	"jarate duration" : {
		"armory_desc" : "on_hit jarate"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "jarate_duration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_JarateDuration"
		"name" : "jarate duration"
		"index" : "175"
		"hidden" : "0"
	}

	"cannot giftwrap" : {
		"name" : "cannot giftwrap"
		"stored_as_integer" : "1"
		"index" : "785"
		"attribute_class" : "cannot_giftwrap"
		"hidden" : "1"
	}

	"max pipebombs increased" : {
		"index" : "88"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_max_pipebombs"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxPipebombs_Increased"
		"name" : "max pipebombs increased"
		"hidden" : "0"
	}

	"overheal decay disabled" : {
		"index" : "14"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_medigun_overheal_decay"
		"effect_type" : "positive"
		"description_string" : "#Attrib_OverhealDecay_Disabled"
		"name" : "overheal decay disabled"
		"hidden" : "0"
	}

	"add cloak on hit" : {
		"index" : "166"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_cloak_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AddCloakOnHit"
		"name" : "add cloak on hit"
		"hidden" : "0"
	}

	"afterburn duration bonus" : {
		"effect_type" : "positive"
		"name" : "afterburn duration bonus"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "afterburn_duration_mult"
		"index" : "829"
	}

	"tag__eotlearlysupport" : {
		"index" : "703"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "tag__eotlearlysupport"
		"effect_type" : "positive"
		"description_string" : "#Attrib_eotl_early_supporter"
		"name" : "tag__eotlearlysupport"
		"hidden" : "0"
	}

	"Projectile range decreased" : {
		"index" : "102"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_projectile_range"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ProjectileRange_Decreased"
		"name" : "Projectile range decreased"
		"hidden" : "0"
	}

	"medic regen bonus" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "medic_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MedicRegenBonus"
		"name" : "medic regen bonus"
		"index" : "130"
		"hidden" : "0"
	}

	"airblast_turn_projectile_to_ammo" : {
		"effect_type" : "neutral"
		"name" : "airblast_turn_projectile_to_ammo"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "airblast_turn_projectile_to_ammo"
		"index" : "833"
	}

	"applies snare effect" : {
		"index" : "313"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "applies_snare_effect"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AppliesSnareEffect"
		"name" : "applies snare effect"
		"hidden" : "1"
	}

	"engineer sentry build rate multiplier" : {
		"index" : "464"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "sentry_build_rate_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sentry_Build_Rate"
		"name" : "engineer sentry build rate multiplier"
		"hidden" : "0"
	}

	"mod mini-crit airborne deploy" : {
		"index" : "265"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mini_crit_airborne_deploy"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MiniCritAirborneEnemiesDeploy"
		"name" : "mod mini-crit airborne deploy"
		"hidden" : "0"
	}

	"energy weapon penetration" : {
		"index" : "283"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "energy_weapon_penetration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_EnergyWeaponPenetration"
		"name" : "energy weapon penetration"
		"hidden" : "0"
	}

	"centerfire projectile" : {
		"index" : "289"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "centerfire_projectile"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CenterFireProjectile"
		"name" : "centerfire projectile"
		"hidden" : "1"
	}

	"projectile penetration heavy" : {
		"index" : "397"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "projectile_penetration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Penetration_Heavy"
		"name" : "projectile penetration heavy"
		"hidden" : "0"
	}

	"item slot criteria 5" : {
		"index" : "3008"
		"name" : "item slot criteria 5"
		"attribute_class" : "item_slot_criteria"
		"attribute_type" : "item_slot_criteria"
	}

	"hidden maxhealth non buffed" : {
		"index" : "140"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_maxhealth_nonbuffed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MaxHealth_Positive"
		"name" : "hidden maxhealth non buffed"
		"hidden" : "1"
	}

	"decoded by itemdefindex" : {
		"effect_type" : "positive"
		"name" : "decoded by itemdefindex"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "528"
		"attribute_class" : "decoded_by_itemdefindex"
		"hidden" : "1"
	}

	"reveal cloaked victim on hit" : {
		"index" : "339"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "reveal_cloaked_victim_on_hit"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RevealCloakedVictimOnHit"
		"name" : "reveal cloaked victim on hit"
		"hidden" : "0"
	}

	"flame life penalty" : {
		"index" : "163"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_life"
		"effect_type" : "negative"
		"description_string" : "#Attrib_FlameLife_Negative"
		"name" : "flame life penalty"
		"hidden" : "0"
	}

	"accepted wedding ring account id 2" : {
		"index" : "373"
		"stored_as_integer" : "1"
		"description_format" : "value_is_account_id"
		"attribute_class" : "accepted_wedding_ring_account_id_2"
		"effect_type" : "positive"
		"description_string" : "#Attrib_AcceptedWeddingRingAccount2"
		"name" : "accepted wedding ring account id 2"
		"hidden" : "0"
	}

	"overheal fill rate reduced" : {
		"index" : "479"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "overheal_fill_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Overheal_Fill_Rate_Reduced"
		"name" : "overheal fill rate reduced"
		"hidden" : "0"
	}

	"lunchbox adds maxhealth bonus" : {
		"index" : "139"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "set_weapon_mode"
		"effect_type" : "positive"
		"description_string" : "#Attrib_LunchboxAddsMaxHealth"
		"name" : "lunchbox adds maxhealth bonus"
		"hidden" : "0"
	}

	"build rate bonus" : {
		"index" : "321"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mod_build_rate"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BuildRateBonus"
		"name" : "build rate bonus"
		"hidden" : "0"
	}

	"active health regen" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "active_item_health_regen"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HealthRegen"
		"name" : "active health regen"
		"index" : "190"
		"hidden" : "0"
	}

	"cannot pick up intelligence" : {
		"index" : "400"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cannot_pick_up_intelligence"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CannotPickUpIntelligence"
		"name" : "cannot pick up intelligence"
		"hidden" : "0"
	}

	"throwable particle trail only" : {
		"effect_type" : "neutral"
		"name" : "throwable particle trail only"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "515"
		"attribute_class" : "throwable_particle_trail_only"
		"hidden" : "1"
	}

	"generate rage on damage" : {
		"index" : "375"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "generate_rage_on_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_RageOnDamage"
		"name" : "generate rage on damage"
		"hidden" : "0"
	}

	"cancel falling damage" : {
		"index" : "275"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "cancel_falling_damage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_CancelFallingDamage"
		"name" : "cancel falling damage"
		"hidden" : "0"
	}

	"mod_cloak_no_regen_from_items" : {
		"effect_type" : "negative"
		"description_string" : "#Attrib_NoCloakFromAmmo"
		"name" : "mod_cloak_no_regen_from_items"
		"description_format" : "value_is_additive"
		"index" : "810"
		"attribute_class" : "mod_cloak_no_regen_from_items"
		"hidden" : "0"
	}

	"saxxy award category" : {
		"index" : "262"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "saxxy_award_category"
		"effect_type" : "positive"
		"description_string" : "#Attrib_SaxxyAward"
		"name" : "saxxy award category"
		"hidden" : "1"
	}

	"increase buff duration" : {
		"index" : "319"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_buff_duration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BuffTime_Increased"
		"name" : "increase buff duration"
		"hidden" : "0"
	}

	"dmg taken from fire reduced on active" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_dmgtaken_from_fire_active"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgTaken_From_Fire_ReducedActive"
		"name" : "dmg taken from fire reduced on active"
		"index" : "794"
		"hidden" : "0"
	}

	"energy buff dmg taken multiplier" : {
		"effect_type" : "negative"
		"name" : "energy buff dmg taken multiplier"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"index" : "798"
		"attribute_class" : "energy_buff_dmg_taken_multiplier"
		"hidden" : "1"
	}

	"grenade no bounce" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_grenade_no_bounce"
		"name" : "grenade no bounce"
		"description_format" : "value_is_additive"
		"index" : "671"
		"attribute_class" : "grenade_no_bounce"
		"hidden" : "0"
	}

	"clip size penalty" : {
		"index" : "3"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_clipsize"
		"effect_type" : "negative"
		"description_string" : "#Attrib_ClipSize_Negative"
		"name" : "clip size penalty"
		"hidden" : "0"
	}

	"burn damage earns rage" : {
		"index" : "368"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "burn_damage_earns_rage"
		"effect_type" : "positive"
		"description_string" : "#Attrib_BurnDamageEarnsRage"
		"name" : "burn damage earns rage"
		"hidden" : "0"
	}

	"damage penalty" : {
		"index" : "1"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DamageDone_Negative"
		"name" : "damage penalty"
		"hidden" : "0"
	}

	"cosmetic taunt sound" : {
		"index" : "371"
		"description_format" : "value_is_additive"
		"hidden" : "0"
		"effect_type" : "positive"
		"description_string" : "#Attrib_TauntSoundSuccess"
		"name" : "cosmetic taunt sound"
		"attribute_class" : "cosmetic_taunt_sound"
		"attribute_type" : "string"
	}

	"building instant upgrade" : {
		"effect_type" : "positive"
		"description_string" : "#Attrib_BuildingInstaUpgrade"
		"name" : "building instant upgrade"
		"description_format" : "value_is_additive"
		"index" : "327"
		"attribute_class" : "building_instant_upgrade"
		"hidden" : "0"
	}

	"unlimited quantity" : {
		"index" : "311"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "unlimited_quantity"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Unlimited"
		"name" : "unlimited quantity"
		"hidden" : "0"
	}

	"upgrade rate decrease" : {
		"index" : "2043"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "upgrade_rate_mod"
		"effect_type" : "negative"
		"description_string" : "#Attrib_UpgradeRate_Decreased"
		"name" : "upgrade rate decrease"
		"hidden" : "0"
	}

	"sniper aiming movespeed decreased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_aiming_movespeed"
		"effect_type" : "negative"
		"description_string" : "#Attrib_SniperAimingMoveSpeed_Decreased"
		"name" : "sniper aiming movespeed decreased"
		"index" : "378"
		"hidden" : "0"
	}

	"elevate to unusual if applicable" : {
		"index" : "730"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "elevate_to_unusual_if_applicable"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ElevateQuality"
		"name" : "elevate to unusual if applicable"
		"hidden" : "1"
	}

	"uber duration bonus" : {
		"index" : "314"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "add_uber_time"
		"effect_type" : "positive"
		"description_string" : "#Attrib_UberDurationBonus"
		"name" : "uber duration bonus"
		"hidden" : "0"
	}

	"mult_item_meter_charge_rate" : {
		"description_string" : "#Attrib_ChargeMeterRateMult"
		"name" : "mult_item_meter_charge_rate"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"index" : "874"
		"attribute_class" : "mult_item_meter_charge_rate"
		"hidden" : "0"
	}

	"SPELL: Halloween pumpkin explosions" : {
		"index" : "1007"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "halloween_pumpkin_explosions"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HalloweenSpell_PumpkinBombs"
		"name" : "SPELL: Halloween pumpkin explosions"
		"hidden" : "0"
		"is_user_generated" : "2"
	}

	"no self blast dmg" : {
		"index" : "181"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "no_self_blast_dmg"
		"effect_type" : "positive"
		"description_string" : "#Attrib_NoSelfBlastDmg"
		"name" : "no self blast dmg"
		"hidden" : "0"
	}

	"kill eater user score type 3" : {
		"effect_type" : "positive"
		"name" : "kill eater user score type 3"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "384"
		"attribute_class" : "kill_eater_user_score_type_3"
		"hidden" : "1"
	}

	"mvm completed challenges bitmask" : {
		"effect_type" : "positive"
		"name" : "mvm completed challenges bitmask"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "386"
		"attribute_class" : "mvm_completed_challenges_bitmask"
		"hidden" : "1"
	}

	"sapper damage penalty" : {
		"index" : "426"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_sapper_damage"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Sapper_Damage_Penalty"
		"name" : "sapper damage penalty"
		"hidden" : "0"
	}

	"kill eater 2" : {
		"effect_type" : "positive"
		"name" : "kill eater 2"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "294"
		"attribute_class" : "kill_eater_2"
		"hidden" : "1"
	}

	"extinguish earns revenge crits" : {
		"index" : "367"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "extinguish_revenge"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ExtinguishRevenge"
		"name" : "extinguish earns revenge crits"
		"hidden" : "0"
	}

	"headshot damage increase" : {
		"index" : "390"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "headshot_damage_modify"
		"effect_type" : "positive"
		"description_string" : "#Attrib_HeadshotDamageIncrease"
		"name" : "headshot damage increase"
		"hidden" : "0"
	}

	"fire rate bonus" : {
		"index" : "6"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "mult_postfiredelay"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FireRate_Positive"
		"name" : "fire rate bonus"
		"hidden" : "0"
	}

	"particle effect vertical offset" : {
		"effect_type" : "positive"
		"name" : "particle effect vertical offset"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "519"
		"attribute_class" : "particle_effect_vertical_offset"
		"hidden" : "1"
	}

	"parachute attribute" : {
		"effect_type" : "positive"
		"name" : "parachute attribute"
		"description_format" : "value_is_additive"
		"index" : "640"
		"attribute_class" : "parachute_attribute"
		"hidden" : "1"
	}

	"Projectile speed increased" : {
		"index" : "103"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_projectile_speed"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ProjectileSpeed_Increased"
		"name" : "Projectile speed increased"
		"hidden" : "0"
	}

	"unusualifier_attribute_template_name" : {
		"name" : "unusualifier_attribute_template_name"
		"index" : "805"
		"description_format" : "value_is_additive"
		"hidden" : "1"
		"attribute_class" : "unusualifier_attribute_template_name"
		"attribute_type" : "string"
	}

	"projectile penetration" : {
		"index" : "266"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "projectile_penetration"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Penetration"
		"name" : "projectile penetration"
		"hidden" : "0"
	}

	"pyrovision only DISPLAY ONLY" : {
		"index" : "422"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "pyrovision_only_display"
		"effect_type" : "negative"
		"description_string" : "#Attrib_PyrovisionFilter"
		"name" : "pyrovision only DISPLAY ONLY"
		"hidden" : "0"
	}

	"mult_player_movespeed_active" : {
		"armory_desc" : "on_active"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_player_movespeed_active"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MoveSpeed_Bonus"
		"name" : "mult_player_movespeed_active"
		"index" : "851"
		"hidden" : "0"
	}

	"SET BONUS: dmg from sentry reduced" : {
		"index" : "169"
		"stored_as_integer" : "0"
		"description_format" : "value_is_inverted_percentage"
		"attribute_class" : "dmg_from_sentry_reduced"
		"effect_type" : "positive"
		"description_string" : "#Attrib_DmgFromSentryReduced"
		"name" : "SET BONUS: dmg from sentry reduced"
		"is_set_bonus" : "1"
		"hidden" : "0"
	}

	"mark for death on building pickup" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "mark_for_death_on_building_pickup"
		"effect_type" : "negative"
		"description_string" : "#Attrib_MarkedForDeathOnBuildingPickup"
		"name" : "mark for death on building pickup"
		"index" : "472"
		"hidden" : "0"
	}

	"cannonball push back" : {
		"index" : "477"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "cannonball_push_back"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Cannonball_Push_Back"
		"name" : "cannonball push back"
		"hidden" : "0"
	}

	"throwable recharge time" : {
		"effect_type" : "positive"
		"name" : "throwable recharge time"
		"description_format" : "value_is_additive"
		"index" : "618"
		"attribute_class" : "throwable_recharge_time"
		"hidden" : "0"
	}

	"dmg taken from bullets increased" : {
		"armory_desc" : "on_wearer"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmgtaken_from_bullets"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgTaken_From_Bullets_Increased"
		"name" : "dmg taken from bullets increased"
		"index" : "67"
		"hidden" : "0"
	}

	"can overload" : {
		"index" : "417"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "can_overload"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CanOverload"
		"name" : "can overload"
		"hidden" : "0"
	}

	"force level display" : {
		"effect_type" : "positive"
		"name" : "force level display"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"index" : "212"
		"attribute_class" : "force_level_display"
		"hidden" : "1"
	}

	"player skin override" : {
		"index" : "448"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "player_skin_override"
		"effect_type" : "positive"
		"description_string" : "#Attrib_PlayerSkinOverride"
		"name" : "player skin override"
		"hidden" : "1"
	}

	"strange restriction value 1" : {
		"effect_type" : "positive"
		"name" : "strange restriction value 1"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "455"
		"attribute_class" : "strange_restriction_value_1"
		"hidden" : "1"
	}

	"dmg penalty vs players" : {
		"index" : "138"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_dmg_vs_players"
		"effect_type" : "negative"
		"description_string" : "#Attrib_DmgVsPlayer_Decreased"
		"name" : "dmg penalty vs players"
		"hidden" : "0"
	}

	"grenade not explode on impact" : {
		"index" : "467"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "grenade_not_explode_on_impact"
		"effect_type" : "negative"
		"description_string" : "#Attrib_Grenade_Not_Explode_On_Impact"
		"name" : "grenade not explode on impact"
		"hidden" : "0"
	}

	"melee range multiplier" : {
		"index" : "264"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "melee_range_multiplier"
		"effect_type" : "positive"
		"description_string" : "#Attrib_MeleeRangeMultiplier"
		"name" : "melee range multiplier"
		"hidden" : "1"
	}

	"strange restriction user type 1" : {
		"effect_type" : "positive"
		"name" : "strange restriction user type 1"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "458"
		"attribute_class" : "strange_restriction_user_type_1"
		"hidden" : "1"
	}

	"sapper voice pak idle wait" : {
		"index" : "452"
		"stored_as_integer" : "0"
		"description_format" : "value_is_additive"
		"attribute_class" : "sapper_voice_pak_idle_wait"
		"effect_type" : "positive"
		"description_string" : "#Attrib_Sapper_Voice_Pak_Idle_Wait"
		"name" : "sapper voice pak idle wait"
		"hidden" : "0"
	}

	"kill eater 3" : {
		"effect_type" : "positive"
		"name" : "kill eater 3"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"index" : "494"
		"attribute_class" : "kill_eater_3"
		"hidden" : "1"
	}

	"Projectile range increased" : {
		"index" : "101"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_projectile_range"
		"effect_type" : "positive"
		"description_string" : "#Attrib_ProjectileRange_Increased"
		"name" : "Projectile range increased"
		"hidden" : "0"
	}

	"mod use metal ammo type" : {
		"index" : "301"
		"stored_as_integer" : "1"
		"description_format" : "value_is_additive"
		"attribute_class" : "mod_use_metal_ammo_type"
		"effect_type" : "negative"
		"description_string" : "#Attrib_UseMetalAmmoType"
		"name" : "mod use metal ammo type"
		"hidden" : "0"
	}

	"mult cloak meter consume rate" : {
		"index" : "34"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_cloak_meter_consume_rate"
		"effect_type" : "negative"
		"description_string" : "#Attrib_CloakMeterConsumeRate"
		"name" : "mult cloak meter consume rate"
		"hidden" : "0"
	}

	"flame life bonus" : {
		"index" : "164"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mult_flame_life"
		"effect_type" : "positive"
		"description_string" : "#Attrib_FlameLife_Positive"
		"name" : "flame life bonus"
		"hidden" : "0"
	}

	"increased jump height from weapon" : {
		"index" : "524"
		"stored_as_integer" : "0"
		"description_format" : "value_is_percentage"
		"attribute_class" : "mod_jump_height_from_weapon"
		"effect_type" : "positive"
		"description_string" : "#Attrib_JumpHeightBonus"
		"name" : "increased jump height from weapon"
		"hidden" : "0"
	}
}
