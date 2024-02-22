// Allow expression constants
::CONST <- getconsttable()
if (!("ConstantNamingConvention" in CONST))
{
	foreach (a,b in Constants)
		foreach (k,v in b)
            CONST[k] <- v != null ? v : 0;
}
CONST.setdelegate({ _newslot = @(k, v) compilestring("const " + k + "=" + (typeof(v) == "string" ? ("\"" + v + "\"") : v))() })
CONST.MAX_CLIENTS <- MaxClients().tointeger()

::ROOT <- getroottable()
foreach (k, v in ::NetProps.getclass())
    if (k != "IsValid" && !(k in ROOT))
        ROOT[k] <- ::NetProps[k].bindenv(::NetProps)

foreach (k, v in ::Entities.getclass())
    if (k != "IsValid" && !(k in ROOT))
        ROOT[k] <- ::Entities[k].bindenv(::Entities)

//string constants are apparently significantly faster than raw strings
const THINK_ADDED = "ProjectileThinkAdded"

//spell constants
const SPELL_ROLLING = -2;
const SPELL_EMPTY = -1;
const SPELL_FIREBALL = 0;
const SPELL_BATS = 1;
const SPELL_OVERHEAL = 2;
const SPELL_PUMPKIN = 3;
const SPELL_SUPERJUMP = 4;
const SPELL_STEALTH = 5;
const SPELL_TELEPORT = 6;
const SPELL_ENERGYORB = 7;
const SPELL_MINIFY = 8;
const SPELL_METEOR = 9;
const SPELL_MONOCULOUS = 10;
const SPELL_SKELETON = 11;
const SPELL_BUMPER_BOXING_ROCKET = 12;
const SPELL_BUMPER_PARACHUTE = 13;
const SPELL_BUMPER_OVERHEAL = 14;
const SPELL_BUMPER_BOMBHEAD = 15;
const SPELL_COUNT = 16;

//clientprint chat colors
//can be put into the constant table like this? "const" declaration does not allow for newlines in strings
const MATTR_ERROR = "MissionAttr ERROR: "
const STRING_NETPROP_ITEMDEF  = "m_AttributeManager.m_Item.m_iItemDefinitionIndex"
const COLOR_LIME       = "22FF22"
const COLOR_YELLOW     = "FFFF66"
const TF_COLOR_RED     = "FF3F3F"
const TF_COLOR_BLUE    = "99CCFF"
const TF_COLOR_SPEC    = "CCCCCC"
const TF_COLOR_DEFAULT = "FBECCB"

CONST.COLOR_END <- "\x07";
CONST.COLOR_DEFAULT <- "\x07FBECCB";
CONST.COLOR_BLUE <- "\x07FF3F3F";
CONST.COLOR_RED <- "\x07FF3F3F";
CONST.COLOR_SPECTATOR <- "\x07CCCCCC";
CONST.COLOR_NAVY_BLUE <- "\x071337AD";
CONST.COLOR_DEEP_RED <- "\x07FF0000";
// CONST.COLOR_LIME <- "\x0722FF22";
// CONST.COLOR_YELLOW <- "\x07FFFF66";

//wep slot constants
const SLOT_PRIMARY = 0;
const SLOT_SECONDARY = 1;
const SLOT_MELEE = 2;
const SLOT_UTILITY = 3;
const SLOT_BUILDING = 4;
const SLOT_PDA = 5;
const SLOT_PDA2 = 6;
const SLOT_COUNT = 7;

//cosmetic slot constants (UNTESTED)
const LOADOUT_POSITION_HEAD = 8
const LOADOUT_POSITION_MISC = 9
const LOADOUT_POSITION_ACTION = 10
const LOADOUT_POSITION_MISC2 = 11

//taunt slot constants (UNTESTED)
const LOADOUT_POSITION_TAUNT = 12
const LOADOUT_POSITION_TAUNT2 = 13
const LOADOUT_POSITION_TAUNT3 = 14
const LOADOUT_POSITION_TAUNT4 = 15
const LOADOUT_POSITION_TAUNT5 = 16
const LOADOUT_POSITION_TAUNT6 = 17
const LOADOUT_POSITION_TAUNT7 = 18
const LOADOUT_POSITION_TAUNT8 = 19

//m_bloodColor constants
const DONT_BLEED = -1;
const BLOOD_COLOR_RED = 0;
const BLOOD_COLOR_YELLOW = 1;
const BLOOD_COLOR_GREEN = 2;
const BLOOD_COLOR_MECH = 3;

//m_iTeleportType constants
const TTYPE_NONE = 0
const TTYPE_ENTRANCE = 1;
const TTYPE_EXIT = 2;

//tf_gamerules m_iRoundState
const GR_STATE_BONUS = 9;
const GR_STATE_BETWEEN_RNDS = 10;

//m_lifeState constants
const LIFE_ALIVE = 0; // alive
const LIFE_DYING = 1; // playing death animation or still falling off of a ledge waiting to hit ground
const LIFE_DEAD = 2; // dead. lying still.
const LIFE_RESPAWNABLE = 3;
const LIFE_DISCARDBODY = 4;

//emitsoundex flags
const SND_NOFLAGS = 0
const SND_CHANGE_VOL = 1
const SND_CHANGE_PITCH = 2
const SND_STOP = 4
const SND_SPAWNING = 8
const SND_DELAY = 16
const SND_STOP_LOOPING = 32
const SND_SPEAKER = 64
const SND_SHOULDPAUSE = 128
const SND_IGNORE_PHONEMES = 256
const SND_IGNORE_NAME = 512
const SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL = 1024

//DMG type bits, less confusing than shit like DMG_AIRBOAT or DMG_SLOWBURN
const DMG_USE_HITLOCATIONS = 33554432 //DMG_AIRBOAT
const DMG_HALF_FALLOFF = 262144 //DMG_RADIATION
const DMG_CRITICAL = 1048576 //DMG_ACID
const DMG_RADIUS_MAX = 1024 //DMG_ENERGYBEAM
const DMG_IGNITE = 16777216 //DMG_PLASMA
const DMG_USEDISTANCEMOD = 2097152 //DMG_SLOWBURN
const DMG_NOCLOSEDISTANCEMOD = 131072 //DMG_POISON
const DMG_FROM_OTHER_SAPPER = 16777216 //same as DMG_IGNITE
const DMG_MELEE = 134217728 //DMG_BLAST_SURFACE
const DMG_DONT_COUNT_DAMAGE_TOWARDS_CRIT_RATE = 67108864 //DMG_DISSOLVE

//bot behavior flags
//only useful for bot_generator
const TFBOT_IGNORE_ENEMY_SCOUTS = 1
const TFBOT_IGNORE_ENEMY_SOLDIERS = 2
const TFBOT_IGNORE_ENEMY_PYROS = 4
const TFBOT_IGNORE_ENEMY_DEMOMEN = 8
const TFBOT_IGNORE_ENEMY_HEAVIES = 16
const TFBOT_IGNORE_ENEMY_MEDICS = 32
const TFBOT_IGNORE_ENEMY_ENGINEERS = 64
const TFBOT_IGNORE_ENEMY_SNIPERS = 128
const TFBOT_IGNORE_ENEMY_SPIES = 256
const TFBOT_IGNORE_ENEMY_SENTRY_GUNS = 512
const TFBOT_IGNORE_SCENARIO_GOALS = 1024

//emitsoundex channels
const CHAN_REPLACE = -1
const CHAN_AUTO = 0
const CHAN_WEAPON = 1
const CHAN_VOICE = 2
const CHAN_ITEM = 3
const CHAN_BODY = 4
const CHAN_STREAM = 5
const CHAN_STATIC = 6
const CHAN_VOICE2 = 7
const CHAN_VOICE_BASE = 8
const CHAN_USER_BASE = 136

//ammo
const TF_AMMO_PRIMARY = 1
const TF_AMMO_SECONDARY = 2
const TF_AMMO_METAL = 3
const TF_AMMO_GRENADES1 = 4
const TF_AMMO_GRENADES2 = 5
const TF_AMMO_GRENADES3 = 6
const TF_AMMO_COUNT = 7

//buildings
const OBJ_DISPENSER = 0
const OBJ_TELEPORTER = 1
const OBJ_SENTRYGUN = 2
const OBJ_ATTACHMENT_SAPPER = 3

//m_iTeleportType constants
const TTYPE_NONE = 0
const TTYPE_ENTRANCE = 1;
const TTYPE_EXIT = 2;

//trigger entity spawnflags
const SF_TRIGGER_ALLOW_CLIENTS = 1
const SF_TRIGGER_ALLOW_NPCS = 2
const SF_TRIGGER_ALLOW_PUSHABLES = 4
const SF_TRIGGER_ALLOW_PHYSICS = 8
const SF_TRIGGER_ONLY_PLAYER_ALLY_NPCS = 16
const SF_TRIGGER_ONLY_CLIENTS_IN_VEHICLES = 32
const SF_TRIGGER_ALLOW_ALL = 64
const SF_TRIG_PUSH_ONCE = 128
const SF_TRIG_PUSH_AFFECT_PLAYER_ON_LADDER = 256
const SF_TRIGGER_ONLY_CLIENTS_OUT_OF_VEHICLES = 512
const SF_TRIG_TOUCH_DEBRIS = 1024
const SF_TRIGGER_ONLY_NPCS_IN_VEHICLES = 2048
const SF_TRIGGER_DISALLOW_BOTS = 4096

//default max ammo values
const MAXAMMO_BASE_SCOUT_PRIMARY = 32
const MAXAMMO_BASE_SCOUT_SECONDARY = 36
const MAXAMMO_BASE_SOLDIER_PRIMARY = 20
const MAXAMMO_BASE_SOLDIER_JUMPER = 60
const MAXAMMO_BASE_SOLDIER_SECONDARY = 32
const MAXAMMO_BASE_PYRO_PRIMARY = 200
const MAXAMMO_BASE_PYRO_DRAGONS_FURY = 40
const MAXAMMO_BASE_PYRO_SECONDARY = 32
const MAXAMMO_BASE_PYRO_FLARE = 32
const MAXAMMO_BASE_DEMO_PRIMARY = 16
const MAXAMMO_BASE_DEMO_SECONDARY = 24
const MAXAMMO_BASE_DEMO_SCOTRES_JUMPER = 36
const MAXAMMO_BASE_HEAVY_PRIMARY = 200
const MAXAMMO_BASE_HEAVY_SECONDARY = 32
const MAXAMMO_BASE_ENGI_PRIMARY = 32
const MAXAMMO_BASE_ENGI_RESCUE_RANGER = 16
const MAXAMMO_BASE_ENGI_SECONDARY = 200
const MAXAMMO_BASE_MEDIC_PRIMARY = 150
const MAXAMMO_BASE_MEDIC_CROSSBOW = 38
const MAXAMMO_BASE_SNIPER_PRIMARY = 25
const MAXAMMO_BASE_SNIPER_BOW = 12
const MAXAMMO_BASE_SNIPER_SECONDARY = 75
const MAXAMMO_BASE_SPY_PRIMARY = 24

//random useful constants
const FLT_SMALL = 0.0000001;
const FLT_MIN = 1.175494e-38;
const FLT_MAX = 3.402823466e+38;
const INT_MIN = -2147483648;
const INT_MAX = 2147483647;