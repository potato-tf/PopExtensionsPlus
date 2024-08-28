//"reminder that constants are resolved at preprocessor level and not runtime"
//"if you add them dynamically to the table they wont show up until you execute a new script as the preprocessor isnt aware yet"

//fold into both const and root table to work around this.

::CONST <- getconsttable()
::ROOT <- getroottable()

if (!("ConstantNamingConvention" in ROOT)) {

	foreach(a, b in Constants)
		foreach(k, v in b)
		{
			CONST[k] <- v != null ? v : 0
			ROOT[k] <- v != null ? v : 0
		}
}

CONST.setdelegate({ _newslot = @(k, v) compilestring("const " + k + "=" + (typeof(v) == "string" ? ("\"" + v + "\"") : v))() })
CONST.MAX_CLIENTS <- MaxClients().tointeger()

foreach(k, v in ::NetProps.getclass())
	if (k != "IsValid" && !(k in ROOT))
		ROOT[k] <- ::NetProps[k].bindenv(::NetProps)

foreach(k, v in ::Entities.getclass())
	if (k != "IsValid" && !(k in ROOT))
		ROOT[k] <- ::Entities[k].bindenv(::Entities)

foreach(k, v in ::EntityOutputs.getclass())
	if (k != "IsValid" && !(k in ROOT))
		ROOT[k] <- ::EntityOutputs[k].bindenv(::EntityOutputs)

foreach(k, v in ::NavMesh.getclass())
	if (k != "IsValid" && !(k in ROOT))
		ROOT[k] <- ::NavMesh[k].bindenv(::NavMesh)

const POPEXT_ERROR = "POPEXTENSIONS ERROR: "
const STRING_NETPROP_ITEMDEF = "m_AttributeManager.m_Item.m_iItemDefinitionIndex"
const SINGLE_TICK = 0.015

// Clientprint chat colors
const COLOR_LIME       = "22FF22"
const COLOR_YELLOW     = "FFFF66"
const TF_COLOR_RED     = "FF3F3F"
const TF_COLOR_BLUE    = "99CCFF"
const TF_COLOR_SPEC    = "CCCCCC"
const TF_COLOR_DEFAULT = "FBECCB"

const INT_COLOR_WHITE = 16777215

// redefine crit/uber conds so we don't end up using different conds all over the place

const COND_CRITBOOST = 39 //TF_COND_CRITBOOSTED_CTF_CAPTURE
const COND_UBERCHARGE = 57 //TF_COND_INVULNERABLE_CARD_EFFECT

//redefine EFlags
const EFL_USER = 1048576 // EFL_IS_BEING_LIFTED_BY_BARNACLE
const EFL_USER2 = 1073741824 //EFL_NO_PHYSCANNON_INTERACTION
const EFL_SPAWNTEMPLATE = 33554432 //EFL_DONTBLOCKLOS
const EFL_PROJECTILE = 2097152 //EFL_NO_ROTORWASH_PUSH
const EFL_BOT = 268435456 //EFL_NO_MEGAPHYSCANNON_RAGDOLL
const EFL_BOT2 = 67108864 //EFL_DONTWALKON

// CONST.COLOR_END <- "\x07"
// CONST.COLOR_DEFAULT <- "\x07FBECCB"
// CONST.COLOR_BLUE <- "\x07FF3F3F"
// CONST.COLOR_RED <- "\x07FF3F3F"
// CONST.COLOR_SPECTATOR <- "\x07CCCCCC"
// CONST.COLOR_NAVY_BLUE <- "\x071337AD"
// CONST.COLOR_DEEP_RED <- "\x07FF0000"
// CONST.COLOR_LIME <- "\x0722FF22"
// CONST.COLOR_YELLOW <- "\x07FFFF66"

//m_nModelIndexOverrides
const VISION_MODE_NONE      = 0
const VISION_MODE_PYRO      = 1
const VISION_MODE_HALLOWEEN = 2
const VISION_MODE_ROME      = 3

// m_iSelectedSpellIndex
const SPELL_ROLLING    = -2
const SPELL_EMPTY      = -1
const SPELL_FIREBALL   =  0
const SPELL_BATS       =  1
const SPELL_OVERHEAL   =  2
const SPELL_PUMPKIN    =  3
const SPELL_SUPERJUMP  =  4
const SPELL_STEALTH    =  5
const SPELL_TELEPORT   =  6
const SPELL_ENERGYORB  =  7
const SPELL_MINIFY     =  8
const SPELL_METEOR     =  9
const SPELL_MONOCULOUS =  10
const SPELL_SKELETON   =  11
const SPELL_BUMPER_BOXING_ROCKET = 12
const SPELL_BUMPER_PARACHUTE     = 13
const SPELL_BUMPER_OVERHEAL      = 14
const SPELL_BUMPER_BOMBHEAD      = 15
const SPELL_COUNT = 16

// Weapon slots
const SLOT_PRIMARY   = 0
const SLOT_SECONDARY = 1
const SLOT_MELEE     = 2
const SLOT_UTILITY   = 3
const SLOT_BUILDING  = 4
const SLOT_PDA       = 5
const SLOT_PDA2      = 6
const SLOT_COUNT     = 7

// Cosmetic slots (UNTESTED)
const LOADOUT_POSITION_HEAD   = 8
const LOADOUT_POSITION_MISC   = 9
const LOADOUT_POSITION_ACTION = 10
const LOADOUT_POSITION_MISC2  = 11

// Taunt slots (UNTESTED)
const LOADOUT_POSITION_TAUNT  = 12
const LOADOUT_POSITION_TAUNT2 = 13
const LOADOUT_POSITION_TAUNT3 = 14
const LOADOUT_POSITION_TAUNT4 = 15
const LOADOUT_POSITION_TAUNT5 = 16
const LOADOUT_POSITION_TAUNT6 = 17
const LOADOUT_POSITION_TAUNT7 = 18
const LOADOUT_POSITION_TAUNT8 = 19

// m_bloodColor
const DONT_BLEED         = -1
const BLOOD_COLOR_RED    = 0
const BLOOD_COLOR_YELLOW = 1
const BLOOD_COLOR_GREEN  = 2
const BLOOD_COLOR_MECH   = 3

// m_iTeleportType
const TTYPE_NONE     = 0
const TTYPE_ENTRANCE = 1
const TTYPE_EXIT     = 2

// env_shake/ScreenShake function
const SHAKE_START = 0
const SHAKE_STOP = 1

// tf_gamerules m_iRoundState
const GR_STATE_BONUS        = 9
const GR_STATE_BETWEEN_RNDS = 10

// m_lifeState
const LIFE_ALIVE       = 0 // alive
const LIFE_DYING       = 1 // playing death animation or still falling off of a ledge waiting to hit ground
const LIFE_DEAD        = 2 // dead. lying still.
const LIFE_RESPAWNABLE = 3
const LIFE_DISCARDBODY = 4

//pattach points
const PATTACH_ABSORIGIN 		= 0
const PATTACH_ABSORIGIN_FOLLOW  = 1
const PATTACH_CUSTOMORIGIN 		= 2
const PATTACH_POINT 			= 3
const PATTACH_POINT_FOLLOW 		= 4
const PATTACH_WORLDORIGIN 		= 5
const PATTACH_ROOTBONE_FOLLOW 	= 6

// Object flags
const OF_ALLOW_REPEAT_PLACEMENT      = 1
const OF_MUST_BE_BUILT_ON_ATTACHMENT = 2
const OF_DOESNT_HAVE_A_MODEL         = 4
const OF_PLAYER_DESTRUCTION          = 8

// EmitSoundEx flags
const SND_NOFLAGS         = 0
const SND_CHANGE_VOL      = 1
const SND_CHANGE_PITCH    = 2
const SND_STOP            = 4
const SND_SPAWNING        = 8
const SND_DELAY           = 16
const SND_STOP_LOOPING    = 32
const SND_SPEAKER         = 64
const SND_SHOULDPAUSE     = 128
const SND_IGNORE_PHONEMES = 256
const SND_IGNORE_NAME     = 512
const SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL = 1024

// EmitSoundEx channels
const CHAN_REPLACE    = -1
const CHAN_AUTO       =  0
const CHAN_WEAPON     =  1
const CHAN_VOICE      =  2
const CHAN_ITEM       =  3
const CHAN_BODY       =  4
const CHAN_STREAM     =  5
const CHAN_STATIC     =  6
const CHAN_VOICE2     =  7
const CHAN_VOICE_BASE =  8
const CHAN_USER_BASE  =  136

// DMG type bits, less confusing than shit like DMG_AIRBOAT or DMG_SLOWBURN
const DMG_USE_HITLOCATIONS   = 33554432  // DMG_AIRBOAT
const DMG_HALF_FALLOFF       = 262144    // DMG_RADIATION
const DMG_CRITICAL           = 1048576   // DMG_ACID
const DMG_RADIUS_MAX         = 1024      // DMG_ENERGYBEAM
const DMG_IGNITE             = 16777216  // DMG_PLASMA
const DMG_FROM_OTHER_SAPPER  = 16777216  // same as DMG_IGNITE
const DMG_USEDISTANCEMOD     = 2097152   // DMG_SLOWBURN
const DMG_NOCLOSEDISTANCEMOD = 131072    // DMG_POISON
const DMG_MELEE              = 134217728 // DMG_BLAST_SURFACE
const DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE = 67108864 //DMG_DISSOLVE

//can only be used with trigger_hurts
const DMG_IGNORE_MAXHEALTH = 2
const DMG_IGNORE_DEBUFFS = 4

//stun flags
const TF_STUN_NONE = 0
const TF_STUN_MOVEMENT = 1
const TF_STUN_CONTROLS = 2
const TF_STUN_MOVEMENT_FORWARD_ONLY = 4
const TF_STUN_SPECIAL_SOUND = 8
const TF_STUN_DODGE_COOLDOWN = 16
const TF_STUN_NO_EFFECTS = 32
const TF_STUN_LOSER_STATE = 64
const TF_STUN_BY_TRIGGER = 128
const TF_STUN_BOTH = 256

//powerup
const TF_POWERUP_LIFETIME = 30

// Bot behavior flags
// only useful for bot_generator
const TFBOT_IGNORE_ENEMY_SCOUTS      = 1
const TFBOT_IGNORE_ENEMY_SOLDIERS    = 2
const TFBOT_IGNORE_ENEMY_PYROS       = 4
const TFBOT_IGNORE_ENEMY_DEMOMEN     = 8
const TFBOT_IGNORE_ENEMY_HEAVIES     = 16
const TFBOT_IGNORE_ENEMY_MEDICS      = 32
const TFBOT_IGNORE_ENEMY_ENGINEERS   = 64
const TFBOT_IGNORE_ENEMY_SNIPERS     = 128
const TFBOT_IGNORE_ENEMY_SPIES       = 256
const TFBOT_IGNORE_ENEMY_SENTRY_GUNS = 512
const TFBOT_IGNORE_SCENARIO_GOALS    = 1024

// m_iAmmo
const TF_AMMO_PRIMARY = 1
const TF_AMMO_SECONDARY = 2
const TF_AMMO_METAL = 3
const TF_AMMO_GRENADES1 = 4
const TF_AMMO_GRENADES2 = 5
const TF_AMMO_GRENADES3 = 6
const TF_AMMO_COUNT = 7

// m_iObjectType
const OBJ_DISPENSER         = 0
const OBJ_TELEPORTER        = 1
const OBJ_SENTRYGUN         = 2
const OBJ_ATTACHMENT_SAPPER = 3

//m_iTeleportType constants
const TTYPE_NONE     = 0
const TTYPE_ENTRANCE = 1
const TTYPE_EXIT     = 2

// Flags for wavebar functions below
const MVM_CLASS_FLAG_NONE			 = 0
const MVM_CLASS_FLAG_NORMAL          = 1 // Non support or mission icon
const MVM_CLASS_FLAG_SUPPORT         = 2 // Support icon flag. Mission icon does not have this flag
const MVM_CLASS_FLAG_MISSION         = 4 // Mission icon flag. Support icon does not have this flag
const MVM_CLASS_FLAG_MINIBOSS        = 8 // Giant icon flag. Support and mission icons do not display red background when set
const MVM_CLASS_FLAG_ALWAYSCRIT      = 16 // Crit icon flag. Support and mission icons do not display crit outline when set
const MVM_CLASS_FLAG_SUPPORT_LIMITED = 32 // Support limited flag. Game uses it together with support flag

//also add to root table so they can be used in popfiles
::MVM_CLASS_FLAG_NONE            <- 0
::MVM_CLASS_FLAG_NORMAL          <- 1 // Non support or mission icon
::MVM_CLASS_FLAG_SUPPORT         <- 2 // Support icon flag. Mission icon does not have this flag
::MVM_CLASS_FLAG_MISSION         <- 4 // Mission icon flag. Support icon does not have this flag
::MVM_CLASS_FLAG_MINIBOSS        <- 8 // Giant icon flag. Support and mission icons do not display red background when set
::MVM_CLASS_FLAG_ALWAYSCRIT      <- 16 // Crit icon flag. Support and mission icons do not display crit outline when set
::MVM_CLASS_FLAG_SUPPORT_LIMITED <- 32 // Support limited flag. Game uses it together with support flag

// trigger_* entity spawnflags
const SF_TRIGGER_ALLOW_CLIENTS                = 1
const SF_TRIGGER_ALLOW_NPCS                   = 2
const SF_TRIGGER_ALLOW_PUSHABLES              = 4
const SF_TRIGGER_ALLOW_PHYSICS                = 8
const SF_TRIGGER_ONLY_PLAYER_ALLY_NPCS        = 16
const SF_TRIGGER_ONLY_CLIENTS_IN_VEHICLES     = 32
const SF_TRIGGER_ALLOW_ALL                    = 64
const SF_TRIG_PUSH_ONCE                       = 128
const SF_TRIG_PUSH_AFFECT_PLAYER_ON_LADDER    = 256
const SF_TRIGGER_ONLY_CLIENTS_OUT_OF_VEHICLES = 512
const SF_TRIG_TOUCH_DEBRIS                    = 1024
const SF_TRIGGER_ONLY_NPCS_IN_VEHICLES        = 2048
const SF_TRIGGER_DISALLOW_BOTS                = 4096

// game_text entity spawnflags
const SF_ENVTEXT_ALLPLAYERS = 1

// Button spawnflags
const SF_BUTTON_DONTMOVE 				= 1
const SF_ROTBUTTON_NOTSOLID				= 1
const SF_BUTTON_TOGGLE 					= 32		// button stays pushed until reactivated
const SF_BUTTON_TOUCH_ACTIVATES			= 256		// Button fires when touched.
const SF_BUTTON_DAMAGE_ACTIVATES		= 512		// Button fires when damaged.
const SF_BUTTON_USE_ACTIVATES			= 1024	// Button fires when used.
const SF_BUTTON_LOCKED					= 2048	// Whether the button is initially locked.
const SF_BUTTON_SPARK_IF_OFF			= 4096	// button sparks in OFF state
const SF_BUTTON_JIGGLE_ON_USE_LOCKED	= 8192	// whether to jiggle if someone uses us when we're locked

// Player speak concepts
const MP_CONCEPT_FIREWEAPON           = 0
const MP_CONCEPT_HURT                 = 1
const MP_CONCEPT_PLAYER_EXPRESSION    = 2
const MP_CONCEPT_WINDMINIGUN          = 3
const MP_CONCEPT_FIREMINIGUN          = 4
const MP_CONCEPT_PLAYER_MEDIC         = 5
const MP_CONCEPT_DETONATED_OBJECT     = 6
const MP_CONCEPT_KILLED_PLAYER        = 7
const MP_CONCEPT_KILLED_OBJECT        = 8
const MP_CONCEPT_PLAYER_PAIN          = 9
const MP_CONCEPT_PLAYER_ATTACKER_PAIN = 10

const MP_CONCEPT_PLAYER_TAUNT      = 11
const MP_CONCEPT_PLAYER_HELP       = 12
const MP_CONCEPT_PLAYER_GO         = 13
const MP_CONCEPT_PLAYER_MOVEUP     = 14
const MP_CONCEPT_PLAYER_LEFT       = 15
const MP_CONCEPT_PLAYER_RIGHT      = 16
const MP_CONCEPT_PLAYER_YES        = 17
const MP_CONCEPT_PLAYER_NO         = 18
const MP_CONCEPT_PLAYER_INCOMING   = 19
const MP_CONCEPT_PLAYER_CLOAKEDSPY = 20

const MP_CONCEPT_PLAYER_SENTRYAHEAD    = 21
const MP_CONCEPT_PLAYER_TELEPORTERHERE = 22
const MP_CONCEPT_PLAYER_DISPENSERHERE  = 23
const MP_CONCEPT_PLAYER_SENTRYHERE     = 24
const MP_CONCEPT_PLAYER_ACTIVATECHARGE = 25
const MP_CONCEPT_PLAYER_CHARGEREADY    = 26
const MP_CONCEPT_PLAYER_TAUNTS         = 27
const MP_CONCEPT_PLAYER_BATTLECRY      = 28
const MP_CONCEPT_PLAYER_CHEERS         = 29
const MP_CONCEPT_PLAYER_JEERS          = 30

const MP_CONCEPT_PLAYER_POSITIVE      = 31
const MP_CONCEPT_PLAYER_NEGATIVE      = 32
const MP_CONCEPT_PLAYER_NICESHOT      = 33
const MP_CONCEPT_PLAYER_GOODJOB       = 34
const MP_CONCEPT_MEDIC_STARTEDHEALING = 35
const MP_CONCEPT_MEDIC_CHARGEREADY    = 36
const MP_CONCEPT_MEDIC_STOPPEDHEALING = 37
const MP_CONCEPT_MEDIC_CHARGEDEPLOYED = 38
const MP_CONCEPT_FLAGPICKUP           = 39
const MP_CONCEPT_FLAGCAPTURED         = 40

const MP_CONCEPT_ROUND_START        = 41
const MP_CONCEPT_SUDDENDEATH_START  = 42
const MP_CONCEPT_ONFIRE             = 43
const MP_CONCEPT_STALEMATE          = 44
const MP_CONCEPT_BUILDING_OBJECT    = 45
const MP_CONCEPT_LOST_OBJECT        = 46
const MP_CONCEPT_SPY_SAPPER         = 47
const MP_CONCEPT_TELEPORTED         = 48
const MP_CONCEPT_LOST_CONTROL_POINT = 49
const MP_CONCEPT_CAPTURED_POINT     = 50

const MP_CONCEPT_CAPTURE_BLOCKED           = 51
const MP_CONCEPT_HEALTARGET_STARTEDHEALING = 52
const MP_CONCEPT_HEALTARGET_CHARGEREADY    = 53
const MP_CONCEPT_HEALTARGET_STOPPEDHEALING = 54
const MP_CONCEPT_HEALTARGET_CHARGEDEPLOYED = 55
const MP_CONCEPT_MINIGUN_FIREWEAPON        = 56
const MP_CONCEPT_DIED                 = 57
const MP_CONCEPT_PLAYER_THANKS        = 58
const MP_CONCEPT_CART_MOVING_FORWARD  = 59
const MP_CONCEPT_CART_MOVING_BACKWARD = 60

const MP_CONCEPT_CART_STOP   = 61
const MP_CONCEPT_ATE_FOOD    = 62
const MP_CONCEPT_DOUBLE_JUMP = 63
const MP_CONCEPT_DODGING     = 64
const MP_CONCEPT_DODGE_SHOT  = 65
const MP_CONCEPT_GRAB_BALL   = 66
const MP_CONCEPT_REGEN_BALL  = 67
const MP_CONCEPT_DEFLECTED   = 68
const MP_CONCEPT_BALL_MISSED = 69
const MP_CONCEPT_STUNNED     = 70

const MP_CONCEPT_STUNNED_TARGET    = 71
const MP_CONCEPT_TIRED             = 72
const MP_CONCEPT_BAT_BALL          = 73
const MP_CONCEPT_ACHIEVEMENT_AWARD = 74
const MP_CONCEPT_JARATE_HIT        = 75
const MP_CONCEPT_JARATE_LAUNCH     = 76
const MP_CONCEPT_HIGHFIVE_SUCCESS  = 77
const MP_CONCEPT_HIGHFIVE_SUCCESS_FULL = 78
const MP_CONCEPT_HIGHFIVE_FAILURE      = 79
const MP_CONCEPT_HIGHFIVE_FAILURE_FULL = 80

const MP_CONCEPT_PLAYER_TAUNT2          = 81
const MP_CONCEPT_PICKUP_BUILDING        = 82
const MP_CONCEPT_REDEPLOY_BUILDING      = 83
const MP_CONCEPT_CARRYING_BUILDING      = 84
const MP_CONCEPT_DUEL_REQUEST           = 85
const MP_CONCEPT_DUEL_TARGET_REJECT     = 86
const MP_CONCEPT_DUEL_REJECTED          = 87
const MP_CONCEPT_DUEL_TARGET_ACCEPT     = 88
const MP_CONCEPT_DUEL_ACCEPTED          = 89
const MP_CONCEPT_PLAYER_SHOW_ITEM_TAUNT = 90

const MP_CONCEPT_TAUNT_REPLAY          = 91
const MP_CONCEPT_TAUNT_LAUGH           = 92
const MP_CONCEPT_TAUNT_HEROIC_POSE     = 93
const MP_CONCEPT_PARTNER_TAUNT_READY   = 94
const MP_CONCEPT_HOLDTAUNT             = 95
const MP_CONCEPT_TAUNT_PYRO_ARMAGEDDON = 96
const MP_CONCEPT_ROCKET_DESTOYED       = 97
const MP_CONCEPT_MVM_BOMB_DROPPED      = 98
const MP_CONCEPT_MVM_BOMB_CARRIER_UPGRADE1 = 99
const MP_CONCEPT_MVM_BOMB_CARRIER_UPGRADE2 = 100

const MP_CONCEPT_MVM_BOMB_CARRIER_UPGRADE3 = 101
const MP_CONCEPT_MVM_DEFENDER_DIED         = 102
const MP_CONCEPT_MVM_FIRST_BOMB_PICKUP     = 103
const MP_CONCEPT_MVM_BOMB_PICKUP           = 104
const MP_CONCEPT_MVM_SENTRY_BUSTER         = 105
const MP_CONCEPT_MVM_SENTRY_BUSTER_DOWN    = 106
const MP_CONCEPT_MVM_SNIPER_CALLOUT        = 107
const MP_CONCEPT_MVM_LAST_MAN_STANDING     = 108
const MP_CONCEPT_MVM_ENCOURAGE_MONEY       = 109
const MP_CONCEPT_MVM_MONEY_PICKUP          = 110

const MP_CONCEPT_MVM_ENCOURAGE_UPGRADE = 111
const MP_CONCEPT_MVM_UPGRADE_COMPLETE  = 112
const MP_CONCEPT_MVM_GIANT_CALLOUT     = 113
const MP_CONCEPT_MVM_GIANT_HAS_BOMB    = 114
const MP_CONCEPT_MVM_GIANT_KILLED      = 115
const MP_CONCEPT_MVM_GIANT_KILLED_TEAMMATE = 116
const MP_CONCEPT_MVM_SAPPED_ROBOT      = 117
const MP_CONCEPT_MVM_CLOSE_CALL        = 118
const MP_CONCEPT_MVM_TANK_CALLOUT      = 119
const MP_CONCEPT_MVM_TANK_DEAD         = 120

const MP_CONCEPT_MVM_TANK_DEPLOYING  = 121
const MP_CONCEPT_MVM_ATTACK_THE_TANK = 122
const MP_CONCEPT_MVM_TAUNT           = 123
const MP_CONCEPT_MVM_WAVE_START      = 124
const MP_CONCEPT_MVM_WAVE_WIN        = 125
const MP_CONCEPT_MVM_WAVE_LOSE       = 126
const MP_CONCEPT_MVM_DEPLOY_RAGE     = 127
const MP_CONCEPT_MAGIC_BIGHEAD       = 128
const MP_CONCEPT_MAGIC_SMALLHEAD     = 129
const MP_CONCEPT_MAGIC_GRAVITY       = 130

const MP_CONCEPT_MAGIC_GOOD           = 131
const MP_CONCEPT_MAGIC_DANCE          = 132
const MP_CONCEPT_HALLOWEEN_LONGFALL   = 133
const MP_CONCEPT_TAUNT_GUITAR_RIFF    = 134
const MP_CONCEPT_PLAYER_CAST_FIREBALL = 135
const MP_CONCEPT_PLAYER_CAST_MERASMUS_ZAP = 136
const MP_CONCEPT_PLAYER_CAST_SELF_HEAL    = 137
const MP_CONCEPT_PLAYER_CAST_MIRV         = 138
const MP_CONCEPT_PLAYER_CAST_BLAST_JUMP   = 139
const MP_CONCEPT_PLAYER_CAST_STEALTH      = 140

const MP_CONCEPT_PLAYER_CAST_TELEPORT        = 141
const MP_CONCEPT_PLAYER_CAST_LIGHTNING_BALL  = 142
const MP_CONCEPT_PLAYER_CAST_MOVEMENT_BUFF   = 143
const MP_CONCEPT_PLAYER_CAST_MONOCULOUS      = 144
const MP_CONCEPT_PLAYER_CAST_METEOR_SWARM    = 145
const MP_CONCEPT_PLAYER_CAST_SKELETON_HORDE  = 146
const MP_CONCEPT_PLAYER_CAST_BOMB_HEAD_CURSE = 147
const MP_CONCEPT_PLAYER_SPELL_FIREBALL       = 148
const MP_CONCEPT_PLAYER_SPELL_MERASMUS_ZAP   = 149
const MP_CONCEPT_PLAYER_SPELL_SELF_HEAL      = 150

const MP_CONCEPT_PLAYER_SPELL_MIRV       = 151
const MP_CONCEPT_PLAYER_SPELL_BLAST_JUMP = 152
const MP_CONCEPT_PLAYER_SPELL_STEALTH    = 153
const MP_CONCEPT_PLAYER_SPELL_TELEPORT   = 154
const MP_CONCEPT_PLAYER_SPELL_LIGHTNING_BALL  = 155
const MP_CONCEPT_PLAYER_SPELL_MOVEMENT_BUFF   = 156
const MP_CONCEPT_PLAYER_SPELL_MONOCULOUS      = 157
const MP_CONCEPT_PLAYER_SPELL_METEOR_SWARM    = 158
const MP_CONCEPT_PLAYER_SPELL_SKELETON_HORDE  = 159
const MP_CONCEPT_PLAYER_SPELL_BOMB_HEAD_CURSE = 160

const MP_CONCEPT_PLAYER_SPELL_PICKUP_COMMON  = 161
const MP_CONCEPT_PLAYER_SPELL_PICKUP_RARE    = 162
const MP_CONCEPT_PLAYER_HELLTOWER_MIDNIGHT   = 163
const MP_CONCEPT_PLAYER_SKELETON_KING_APPEAR = 164
const MP_CONCEPT_MANNHATTAN_GATE_ATK  = 165
const MP_CONCEPT_MANNHATTAN_GATE_TAKE = 166
const MP_CONCEPT_RESURRECTED          = 167
const MP_CONCEPT_MVM_LOOT_COMMON      = 168
const MP_CONCEPT_MVM_LOOT_RARE        = 169
const MP_CONCEPT_MVM_LOOT_ULTRARARE   = 170

const MP_CONCEPT_MEDIC_HEAL_SHIELD   = 171
const MP_CONCEPT_TAUNT_EUREKA_EFFECT_TELEPORT = 172
const MP_CONCEPT_COMBO_KILLED        = 173
const MP_CONCEPT_PLAYER_ASK_FOR_BALL = 174
const MP_CONCEPT_ROUND_START_COMP    = 175
const MP_CONCEPT_GAME_OVER_COMP      = 176
const MP_CONCEPT_MATCH_OVER_COMP     = 177

// Default max ammo values
const MAXAMMO_BASE_SCOUT_PRIMARY   = 32
const MAXAMMO_BASE_SCOUT_SECONDARY = 36

const MAXAMMO_BASE_SOLDIER_PRIMARY   = 20
const MAXAMMO_BASE_SOLDIER_JUMPER    = 60
const MAXAMMO_BASE_SOLDIER_SECONDARY = 32

const MAXAMMO_BASE_PYRO_PRIMARY      = 200
const MAXAMMO_BASE_PYRO_DRAGONS_FURY = 40
const MAXAMMO_BASE_PYRO_SECONDARY    = 32
const MAXAMMO_BASE_PYRO_FLARE        = 32

const MAXAMMO_BASE_DEMO_PRIMARY        = 16
const MAXAMMO_BASE_DEMO_SECONDARY      = 24
const MAXAMMO_BASE_DEMO_SCOTRES_JUMPER = 36

const MAXAMMO_BASE_HEAVY_PRIMARY   = 200
const MAXAMMO_BASE_HEAVY_SECONDARY = 32

const MAXAMMO_BASE_ENGI_PRIMARY       = 32
const MAXAMMO_BASE_ENGI_RESCUE_RANGER = 16
const MAXAMMO_BASE_ENGI_SECONDARY     = 200

const MAXAMMO_BASE_MEDIC_PRIMARY     = 150
const MAXAMMO_BASE_MEDIC_CROSSBOW    = 38

const MAXAMMO_BASE_SNIPER_PRIMARY   = 25
const MAXAMMO_BASE_SNIPER_BOW       = 12
const MAXAMMO_BASE_SNIPER_SECONDARY = 75

const MAXAMMO_BASE_SPY_PRIMARY = 24

// Content masks
CONST.MASK_OPAQUE      <- (CONTENTS_SOLID|CONTENTS_MOVEABLE|CONTENTS_OPAQUE)
CONST.MASK_PLAYERSOLID <- (CONTENTS_SOLID|CONTENTS_MOVEABLE|CONTENTS_PLAYERCLIP|CONTENTS_WINDOW|CONTENTS_MONSTER|CONTENTS_GRATE)
CONST.MASK_SOLID_BRUSHONLY <- (CONTENTS_SOLID|CONTENTS_MOVEABLE|CONTENTS_WINDOW|CONTENTS_GRATE)

// NavMesh related
const STEP_HEIGHT = 18

//random useful constants
const FLT_SMALL = 0.0000001
const FLT_MIN   = 1.175494e-38
const FLT_MAX   = 3.402823466e+38
const INT_MIN   = -2147483648
const INT_MAX   = 2147483647
