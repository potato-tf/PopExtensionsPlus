const SCOUT_MONEY_COLLECTION_RADIUS = 288

POPEXT_CREATE_SCOPE( "__popext_missionattr", "MissionAttributes", "MissionAttrEntity", "MissionAttrThink" )

if ( !( "ScriptLoadTable" in ROOT ) )   ::ScriptLoadTable   <- {}
if ( !( "ScriptUnloadTable" in ROOT ) ) ::ScriptUnloadTable <- {}

foreach ( func in ScriptLoadTable )
	func()

delete ::ScriptLoadTable

function MissionAttributes::_OnDestroy() {

	foreach ( func in ScriptUnloadTable )
		func()

	delete ::ScriptUnloadTable

	if ( "ExtraTankPathTracks" in this )
		foreach ( track in ExtraTankPathTracks )
			if ( track && track.IsValid() )
				track.Kill()

	foreach( key in [ "MissionAttr", "MissionAttrs", "MAtr", "MAtrs" ] )
		if ( key in ROOT )
			delete ROOT[ key ]
}

// the rome tank removing stuff loops through every prop_dynamic if it can't find the carrier by name, skip the prop_dynamic loop if we already did it
MissionAttributes.noromecarrier   <- false
MissionAttributes.CurAttrsPre	  <- {}
MissionAttributes.CurAttrs		  <- {}
MissionAttributes.SoundsToReplace <- {}
MissionAttributes.OptimizedTracks <- {}
MissionAttributes.PathNum 		  <- 0
MissionAttributes.RedMoneyValue   <- 0

 // legacy compatibility, use PopExtUtil versions instead
MissionAttributes.SetConvar    <- PopExtUtil
MissionAttributes.ResetConvars <- PopExtUtil

MissionAttributes.Attrs <- {

	// =========================================
		// Replicates sigsegv-mvm: ForceHoliday.
		// Forces a tf_holiday for the mission.
		// Supported Holidays are:
		//	0 - None
		//	1 - Birthday
		//	2 - Halloween
		//	3 - Christmas
	// =========================================
	function ForceHoliday( value ) {

		// @param Holiday		Holiday number to force.
		// @error TypeError		If type is not an integer.
		// @error IndexError	If invalid holiday number is passed.
			// Error Handling

		value = PopExtUtil.ToStrictNum( value )

		if ( value == null ) {
			PopExtMain.Error.RaiseTypeError( "ForceHoliday", "int" )
			return false
		}
		else if ( value < kHoliday_None || value >= kHolidayCount ) {
			PopExtMain.Error.RaiseIndexError( "ForceHoliday", [kHoliday_None, kHolidayCount - 1] )
			return false
		}

		// Set Holiday logic
		PopExtUtil.SetConvar( "tf_forced_holiday", value )

		if ( value == kHoliday_None ) return

		local ent = FindByName( null, "__popext_missionattr_holiday" )
		if ( ent != null ) ent.Kill()

		SpawnEntityFromTable( "tf_logic_holiday", {
			targetname   = "__popext_missionattr_holiday",
			holiday_type = value
		})

	}

	function NoHolidayPickups( value ) {

		[ "item_healthkit*", "item_ammopack*" ]
		.apply( function ( pickup ) {

			for ( local pack; pack = FindByClassname( pack, pickup ); )
				for ( local i = 0; i < GetPropArraySize( pack, STRING_NETPROP_MDLINDEX_OVERRIDES ); i++ )
					SetPropIntArray( pack, STRING_NETPROP_MDLINDEX_OVERRIDES, 0, i )
		})
	}

	// =========================================
	// Restore original YER disguise behavior
	// =========================================
	function YERDisguiseFix( value = null ) {

		POP_EVENT_HOOK( "OnTakeDamage", "YERDisguiseFix", function( params ) {

			local victim   = params.const_entity
			local attacker = params.inflictor

			if ( victim.IsPlayer() && params.damage_custom == TF_DMG_CUSTOM_BACKSTAB &&
				attacker != null && !attacker.IsBotOfType( TF_BOT_TYPE ) &&
				( PopExtUtil.GetItemIndex( params.weapon ) == ID_YOUR_ETERNAL_REWARD || PopExtUtil.GetItemIndex( params.weapon ) == ID_WANGA_PRICK )
			) {
				attacker.GetScriptScope().stabvictim <- victim
				PopExtUtil.ScriptEntFireSafe( attacker, "PopExtUtil.SilentDisguise( self, stabvictim )", -1 )
			}
		}, EVENT_WRAPPER_MISSIONATTR )

		POP_EVENT_HOOK( "post_inventory_application", "RemoveYERAttribute", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			local wep   = PopExtUtil.GetItemInSlot( player, SLOT_MELEE )
			local index = PopExtUtil.GetItemIndex( wep )

			if ( index == ID_YOUR_ETERNAL_REWARD || index == ID_WANGA_PRICK )
				wep.RemoveAttribute( "disguise on backstab" )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================
	// Fix loose cannon damage
	// =========================================
	function LooseCannonFix( value = null ) {

		POP_EVENT_HOOK( "OnTakeDamage", "LooseCannonFix", function( params ) {
			local wep = params.weapon

			if ( PopExtUtil.GetItemIndex( wep ) != ID_LOOSE_CANNON || params.damage_custom != TF_DMG_CUSTOM_CANNONBALL_PUSH ) return

			params.damage *= wep.GetAttribute( "damage bonus", 1.0 )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function BotGibFix( value = null ) {

		POP_EVENT_HOOK( "OnTakeDamage", "BotGibFix", function( params ) {
			local victim = params.const_entity
			if ( victim.IsPlayer() && !victim.IsMiniBoss() && victim.GetModelScale() <= 1.0 && params.damage >= victim.GetHealth() && ( params.damage_type & DMG_CRITICAL || params.damage_type & DMG_BLAST ) )
			victim.SetModelScale( 1.0000001, 0.0 )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function HolidayPunchFix( value = null ) {

		POP_EVENT_HOOK( "OnTakeDamage", "HolidayPunchFix", function( params ) {
			local wep   = params.weapon
			local index = PopExtUtil.GetItemIndex( wep )
			if ( index != ID_HOLIDAY_PUNCH || !( params.damage_type & DMG_CRITICAL ) ) return

			local victim = params.const_entity
			if ( victim != null && victim.IsPlayer() && victim.IsBotOfType( TF_BOT_TYPE ) ) {
				victim.Taunt( TAUNT_MISC_ITEM, MP_CONCEPT_TAUNT_LAUGH )

				local tfclass = victim.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]

				if ( victim.GetModelName() == format( "models/player/%s.mdl", class_string ) ) return

				local botmodel = format( "models/bots/%s/bot_%s.mdl", class_string, class_string )

				victim.SetCustomModelWithClassAnimations( format( "models/player/%s.mdl", class_string ) )

				PopExtUtil.PlayerBonemergeModel( victim, botmodel )

				//overwrite the existing bot model think to remove it after taunt
				function BotModelThink() {

					if ( Time() > victim.GetTauntRemoveTime() ) {
						if ( wearable != null ) wearable.Kill()

						SetPropInt( self, "m_clrRender", 0xFFFFFF )
						SetPropInt( self, "m_nRenderMode", kRenderNormal )
						self.SetCustomModelWithClassAnimations( botmodel )

						SetPropString( self, "m_iszScriptThinkFunction", "" )
					}
				}
				PopExtUtil.AddThink( victim, BotModelThink )
			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function EnableGlobalFixes( value = null ) {

		[
			"DragonsFuryFix",
			"FastNPCUpdate",
			"NoCreditVelocity",
			"ScoutBetterMoneyCollection",
			"HoldFireUntilFullReloadFix",
			"EngineerBuildingPushbackFix",
			"YERDisguiseFix",
			"HolidayPunchFix",
			"LooseCannonFix",
			"BotGibFix"
		].apply( @( fix ) MissionAttributes.Attrs[ fix ]() )
	}

	function DragonsFuryFix( value = null ) {
		function MissionAttributes::ThinkTable::DragonsFuryFix() {
			for ( local fireball; fireball = FindByClassname( fireball, "tf_projectile_balloffire" ); )
				fireball.RemoveFlag( FL_GRENADE )
		}
	}

	function FastNPCUpdate( value = null ) {

		function MissionAttributes::ThinkTable::FastNPCUpdate() {

			foreach ( npc in [ "headless_hatman", "eyeball_boss", "merasmus", "tf_zombie" ] )
				for ( local n; n = FindByClassname( n, npc ); )
					n.FlagForUpdate( true )
		}
	}

	function NoCreditVelocity( value = null ) {

		POP_EVENT_HOOK( "player_death", "NoCreditVelocity", function( params ) {
			local player = GetPlayerFromUserID( params.userid )
			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			for ( local money; money = FindByClassname( money, "item_currencypack*" ); )
				money.SetAbsVelocity( Vector( 1, 1, 1 ) ) //0 velocity breaks our reverse mvm money pickup methods.  set to 1hu instead
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function ScoutBetterMoneyCollection( value = null ) {

		POP_EVENT_HOOK( "post_inventory_application", "ScoutBetterMoneyCollection", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) || player.GetPlayerClass() != TF_CLASS_SCOUT ) return

			function MoneyThink() {

				if ( player.GetPlayerClass() != TF_CLASS_SCOUT ) {
					PopExtUtil.RemoveThink( player, "MoneyThink" )
					return
				}

				local origin = player.GetOrigin()
				for ( local money; money = FindByClassnameWithin( money, "item_currencypack*", player.GetOrigin(), SCOUT_MONEY_COLLECTION_RADIUS ); )
					money.SetAbsOrigin( origin )
			}
			PopExtUtil.AddThink( player, MoneyThink )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function HoldFireUntilFullReloadFix( value = null ) {

		POP_EVENT_HOOK( "post_inventory_application", "HoldFireUntilFullReloadFix", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()
			scope.holdingfire <- false
			scope.lastfiretime <- 0.0

			function HoldFireThink() {

				if ( !player.HasBotAttribute( HOLD_FIRE_UNTIL_FULL_RELOAD ) ) return

				local activegun = player.GetActiveWeapon()
				if ( activegun == null ) return
				local clip = activegun.Clip1()
				if ( clip == 0 ) {

					player.AddBotAttribute( SUPPRESS_FIRE )
					scope.holdingfire = true
				}
				else if ( clip == activegun.GetMaxClip1() && scope.holdingfire ) {

					player.RemoveBotAttribute( SUPPRESS_FIRE )
					scope.holdingfire = false
				}
			}
			PopExtUtil.AddThink( player, HoldFireThink )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// Doesn't fully work correctly, need to investigate
	function EngineerBuildingPushbackFix( value = null ) {

		POP_EVENT_HOOK( "post_inventory_application", "EngineerBuildingPushbackFix", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			// if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()

			// 400, 500 ( range, force )
			local epsilon = 20.0

			local blastjump_weapons = {
				tf_weapon_rocketlauncher = null
				tf_weapon_rocketlauncher_directhit = null
				tf_weapon_rocketlauncher_airstrike = null
			}

			scope.lastvelocity <- player.GetAbsVelocity()
			scope.nextthink <- -1
			function EngineerBuildingPushbackThink() {

				if ( !( "nextthink" in scope ) || ( scope.nextthink > -1 && Time() < scope.nextthink ) ) return

				if ( !player.IsAlive() ) return

				local velocity = player.GetAbsVelocity()

				local wep       = player.GetActiveWeapon()
				local classname = ( wep != null ) ? wep.GetClassname() : ""
				local lastfire  = GetPropFloat( wep, "m_flLastFireTime" )

				// We might have been pushed by an engineer building something, lets double check
				if ( "lastvelocity" in scope && fabs( ( scope.lastvelocity - velocity ).Length() - 700 ) < epsilon ) {
					// Blast jumping can generate this type of velocity change in a frame, lets check for that
					if ( player.InCond( TF_COND_BLASTJUMPING ) && classname in blastjump_weapons && ( Time() - lastfire < 0.1 ) )
						return

					// Even with the above check, some things still sneak through so lets continue filtering

					// Look around us to see if there's a building hint and bot engineer within range
					local origin   = player.GetOrigin()
					local engie    = null
					local hint     = null

					for ( local player; player = Entities.FindByClassnameWithin( player, "player", origin, 650 ); ) {
						if ( !player.IsBotOfType( TF_BOT_TYPE ) || player.GetPlayerClass() != TF_CLASS_ENGINEER ) continue

						engie = player
						break
					}

					if ( engie != null )
						hint = Entities.FindByClassnameWithin( null, "bot_hint_*", engie.GetOrigin(), 200 )

					// Counteract impulse velocity
					if ( hint != null && engie != null ) {
						// ClientPrint( null, 3, "COUNTERACTING VELOCITY" )
						local dir =  player.EyePosition() - hint.GetOrigin()

						dir.z = 0
						dir.Norm()
						dir.z = 1

						local push = dir * 500
						player.SetAbsVelocity( velocity - push )

						scope.nextthink = Time() + 1
					}
				}

				scope.lastvelocity = velocity
			}
			PopExtUtil.AddThink( player, EngineerBuildingPushbackThink )
		}, EVENT_WRAPPER_MISSIONATTR )
	}
	// =================================
	// disable random crits for red bots
	// =================================

	function RedBotsNoRandomCrit( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "RedBotsNoRandomCrit", function( params ) {
			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( !player.IsBotOfType( TF_BOT_TYPE ) && player.GetTeam() != TF_TEAM_PVE_DEFENDERS ) return

			PopExtUtil.AddAttributeToLoadout( player, "crit mod disabled hidden", 0 )
		}, EVENT_WRAPPER_MISSIONATTR )

	}

	// =====================
	// disable crit pumpkins
	// =====================

	function NoCrumpkins( value ) {

		if ( !value ) return

		local pumpkin_index = PrecacheModel( "models/props_halloween/pumpkin_loot.mdl" )

		function MissionAttributes::ThinkTable::NoCrumpkins() {

			for ( local pumpkin; pumpkin = FindByClassname( pumpkin, "tf_ammo_pack" ); )
				if ( GetPropInt( pumpkin, STRING_NETPROP_MODELINDEX ) == pumpkin_index )
					EntFireByHandle( pumpkin, "Kill", "", -1, null, null ) //should't do .Kill() in the loop, entfire kill is delayed to the end of the frame.

			foreach ( player in PopExtUtil.PlayerArray )
				player.RemoveCond( TF_COND_CRITBOOSTED_PUMPKIN )
		}

	}

	// ===================
	// disable reanimators
	// ===================

	function NoReanimators( value ) {

		if ( value < 1 ) return

		POP_EVENT_HOOK( "player_death", "NoReanimators", function( params ) {
			for ( local revivemarker; revivemarker = FindByClassname( revivemarker, "entity_revive_marker" ); )
				EntFireByHandle( revivemarker, "Kill", "", -1, null, null )
		}, EVENT_WRAPPER_MISSIONATTR )

	}


	// ====================
	// set all mobber cvars
	// ====================

	function AllMobber( value ) {

		if ( value < 1 ) return

		PopExtUtil.SetConvar( "tf_bot_escort_range", INT_MAX )
		PopExtUtil.SetConvar( "tf_bot_flag_escort_range", INT_MAX )
		PopExtUtil.SetConvar( "tf_bot_flag_escort_max_count", 0 )

	}

	// ===========================
	// allow standing on bot heads
	// ===========================

	function StandableHeads( value ) {

		local movekeys = IN_FORWARD | IN_BACK | IN_LEFT | IN_RIGHT
		// PopExtUtil.PrintTable( GetListenServerHost().GetScriptScope() )
		POP_EVENT_HOOK( "post_inventory_application", "StandableHeads", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			function StandableHeadsThink() {

				local groundent = GetPropEntity( player, "m_hGroundEntity" )

				if ( !groundent || !groundent.IsPlayer() || PopExtUtil.InButton( player, movekeys ) ) return
				player.SetAbsVelocity( Vector() )
			}
			PopExtUtil.AddThink( player, StandableHeadsThink )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ===================================================================
	// sets wavebar hud to display "Wave 666" flavour text w/o the zombies
	// ===================================================================

	//need quotes for this guy.
	"666Wavebar": function( value ) {

		POP_EVENT_HOOK( "mvm_begin_wave", "EventWavebar", function( params ) {

			SetPropInt( PopExtUtil.ObjectiveResource, "m_nMvMEventPopfileType", value )
			// also needs to set maxwavenum to be zero, thanks ptyx
			if ( value == 0 ) return
			SetPropInt( PopExtUtil.ObjectiveResource, "m_nMannVsMachineMaxWaveCount", 0 )
		}, EVENT_WRAPPER_MISSIONATTR )
		// needs to be delayed for the hud to load properly
		PopExtUtil.ScriptEntFireSafe( PopExtUtil.ObjectiveResource, format( "SetPropInt( self, `m_nMvMEventPopfileType`, %d )", value ), SINGLE_TICK )
	}

	// ===================================
	// sets the wave number on the wavebar
	// ===================================

	function WaveNum( value ) {

		POP_EVENT_HOOK( "mvm_begin_wave", "SetWaveNum", function( params ) {

			SetPropInt( PopExtUtil.ObjectiveResource, "m_nMannVsMachineWaveCount", value )
		}, EVENT_WRAPPER_MISSIONATTR )
		// needs to be delayed for the hud to load properly
		PopExtUtil.ScriptEntFireSafe( PopExtUtil.ObjectiveResource, format( "SetPropInt( self, `m_nMannVsMachineWaveCount`, %d )", value ), SINGLE_TICK )
	}

	// =======================================
	// sets the max wave number on the wavebar
	// =======================================

	function MaxWaveNum( value ) {

		POP_EVENT_HOOK( "mvm_begin_wave", "SetMaxWaveNum", function( params ) {
			SetPropInt( PopExtUtil.ObjectiveResource, "m_nMannVsMachineMaxWaveCount", value )
		}, EVENT_WRAPPER_MISSIONATTR )
		PopExtUtil.ScriptEntFireSafe( PopExtUtil.ObjectiveResource, format( "SetPropInt( self, `m_nMannVsMachineMaxWaveCount`, %d )", value ), SINGLE_TICK )
	}

	// ========
	// OBSOLETE
	// ========

	HuntsmanDamageFix = @() PopExtMain.Error.GenericWarning( "HuntsmanDamageFix is obsolete" )

	// =========================================================
	// UNFINISHED
	// =========================================================

	function NegativeDmgHeals( value ) {
		// function NegativeDmgHeals( params ) {
		// 	local player = params.const_entity

		// 	local damage = params.damage
		// 	if ( !player.IsPlayer() || damage > 0 ) return

		// 	if ( ( value == 2 && player.GetHealth() - damage > player.GetMaxHealth() ) || //don't overheal is value is 2
		// 	( value == 1 && player.GetHealth() - damage > player.GetMaxHealth() * 1.5 ) ) return //don't go past max overheal if value is 1

		// 	player.SetHealth( player.GetHealth() - damage )

		// }
		// MissionAttributes.TakeDamageTable.NegativeDmgHeals <- MissionAttributes.NegativeDmgHeals
	}
	// ==============================================================
	// Allows spies to place multiple sappers when item meter is full
	// ==============================================================

	function MultiSapper( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "MultiSapper", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) || player.GetPlayerClass() < TF_CLASS_SPY ) return

			POP_EVENT_HOOK( "player_builtobject", format( "MultiSapper_%d", PopExtUtil.PlayerTable[ player ] ), function( params ) {

				if ( params.object != OBJ_ATTACHMENT_SAPPER ) return
				local sapper = EntIndexToHScript( params.index )
				SetPropBool( sapper, "m_bDisposableBuilding", true )

			}, EVENT_WRAPPER_MISSIONATTR )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =======================================================================================
	// Fix "Set DamageType Ignite" not actually making most weapons ignite on hit
	// WARNING: Rafmod already does this, enabling this on potato servers will ALWAYS stack,
	// 			since there does not seem to be a way to turn off the rafmod fix
	// =======================================================================================

	function SetDamageTypeIgniteFix( value ) {

		// Afterburn damage and duration varies from weapon to weapon, we don't want to override those
		// This list leaves out only the volcano fragment and the heater
		local igniting_weapons_classname = {
			"tf_weapon_particle_cannon" : null,
			"tf_weapon_flamethrower" : null,
			"tf_weapon_rocketlauncher_fireball" : null,
			"tf_weapon_flaregun" : null,
			"tf_weapon_flaregun_revenge" : null,
			"tf_weapon_compound_bow" : null,
			[ID_HUO_LONG_HEATMAKER] = null,
			[ID_SHARPENED_VOLCANO_FRAGMENT] = null
		}

		POP_EVENT_HOOK( "OnTakeDamage", "SetDamageTypeIgniteFix", function( params ) {

			local wep = params.weapon
			local victim = params.const_entity
			local attacker = params.inflictor

			if ( wep == null || attacker == null || attacker == victim
				|| wep.GetClassname() in igniting_weapons_classname
				|| PopExtUtil.GetItemIndex( wep ) in igniting_weapons_classname
				|| wep.GetAttribute( "Set DamageType Ignite", 10 ) == 10
			) return

			PopExtUtil.Ignite( victim )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	//all of these could just be set directly in the pop easily, however popfile's have a 4096 character limit for vscript so might as well save space

	// =========================================================

	function NoRefunds( value ) {
		PopExtUtil.SetConvar( "tf_mvm_respec_enabled", 0 )
	}

	// =========================================================

	function RefundLimit( value ) {
		PopExtUtil.SetConvar( "tf_mvm_respec_enabled", 1 )
		PopExtUtil.SetConvar( "tf_mvm_respec_limit", value )
	}

	// =========================================================

	function RefundGoal( value ) {
		PopExtUtil.SetConvar( "tf_mvm_respec_enabled", 1 )
		PopExtUtil.SetConvar( "tf_mvm_respec_credit_goal", value )
	}

	// =========================================================

	function FixedBuybacks( value ) {
		PopExtUtil.SetConvar( "tf_mvm_buybacks_method", 1 )
	}

	// =========================================================

	function BuybacksPerWave( value ) {
		PopExtUtil.SetConvar( "tf_mvm_buybacks_per_wave", value )
	}

	// =========================================================

	function NoBuybacks( value ) {
		PopExtUtil.SetConvar( "tf_mvm_buybacks_method", value )
		PopExtUtil.SetConvar( "tf_mvm_buybacks_per_wave", 0 )
	}

	// =========================================================

	function DeathPenalty( value ) {
		PopExtUtil.SetConvar( "tf_mvm_death_penalty", value )
	}

	// =========================================================

	function BonusRatioHalf( value ) {
		PopExtUtil.SetConvar( "tf_mvm_currency_bonus_ratio_min", value )
	}

	// =========================================================

	function BonusRatioFull( value ) {
		PopExtUtil.SetConvar( "tf_mvm_currency_bonus_ratio_max", value )
	}

	// =========================================================

	function UpgradeFile( value ) {
		EntFire( "tf_gamerules", "SetCustomUpgradesFile", value )
	}

	// =========================================================

	function FlagEscortCount( value ) {
		PopExtUtil.SetConvar( "tf_bot_flag_escort_max_count", value )
	}

	// =========================================================

	function BombMovementPenalty( value ) {
		PopExtUtil.SetConvar( "tf_mvm_bot_flag_carrier_movement_penalty", value )
	}

	// =========================================================

	function MaxSkeletons( value ) {
		PopExtUtil.SetConvar( "tf_max_active_zombie", value )
	}

	// =========================================================

	function TurboPhysics( value ) {
		PopExtUtil.SetConvar( "sv_turbophysics", value )
	}

	// =========================================================

	function Accelerate( value ) {
		PopExtUtil.SetConvar( "sv_accelerate", value )
	}

	// =========================================================

	function AirAccelerate( value ) {
		PopExtUtil.SetConvar( "sv_airaccelerate", value )
	}

	// =========================================================

	function BotPushaway( value ) {
		PopExtUtil.SetConvar( "tf_avoidteammates_pushaway", value )
	}

	// =========================================================

	function TeleUberDuration( value ) {
		PopExtUtil.SetConvar( "tf_mvm_engineer_teleporter_uber_duration", value )
	}

	// =========================================================

	function RedMaxPlayers( value ) {
		PopExtUtil.SetConvar( "tf_mvm_defenders_team_size", value )
	}

	// =========================================================

	function MaxVelocity( value ) {
		PopExtUtil.SetConvar( "sv_maxvelocity", value )
	}

	// =========================================================

	function ConchHealthOnHitRegen( value ) {
		PopExtUtil.SetConvar( "tf_dev_health_on_damage_recover_percentage", value )
	}

	// =========================================================

	function MarkForDeathLifetime( value ) {
		PopExtUtil.SetConvar( "tf_dev_marked_for_death_lifetime", value )
	}

	// =========================================================

	function GrapplingHookEnable( value ) {
		PopExtUtil.SetConvar( "tf_grapplinghook_enable", value )
	}

	// =========================================================

	function GiantScale( value ) {
		PopExtUtil.SetConvar( "tf_mvm_miniboss_scale", value )
	}

	// =========================================================

	function VacNumCharges( value ) {
		PopExtUtil.SetConvar( "weapon_medigun_resist_num_chunks", value )
	}

	// =========================================================

	function DoubleDonkWindow( value ) {
		PopExtUtil.SetConvar( "tf_double_donk_window", value )
	}

	// =========================================================

	function ConchSpeedBoost( value ) {
		PopExtUtil.SetConvar( "tf_whip_speed_increase", value )
	}

	// =========================================================

	function StealthDmgReduction( value ) {
		PopExtUtil.SetConvar( "tf_stealth_damage_reduction", value )
	}

	// =========================================================

	function FlagCarrierCanFight( value ) {
		PopExtUtil.SetConvar( "tf_mvm_bot_allow_flag_carrier_to_fight", value )
	}

	// =========================================================

	function HHHChaseRange( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_chase_range", value )
	}

	// =========================================================

	function HHHAttackRange( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_attack_range", value )
	}

	// =========================================================

	function HHHQuitRange( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_quit_range", value )
	}

	// =========================================================

	function HHHTerrifyRange( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_terrify_radius", value )
	}

	// =========================================================

	function HHHHealthBase( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_health_base", value )
	}

	// =========================================================

	function HHHHealthPerPlayer( value ) {
		PopExtUtil.SetConvar( "tf_halloween_bot_health_per_player", value )
	}

	// =========================================================

	function SentryHintBombForwardRange( value ) {
		PopExtUtil.SetConvar( "tf_bot_engineer_mvm_sentry_hint_bomb_forward_range", value )
	}

	// =========================================================

	function SentryHintBombBackwardRange( value ) {
		PopExtUtil.SetConvar( "tf_bot_engineer_mvm_sentry_hint_bomb_backward_range", value )
	}

	// =========================================================

	function SentryHintMinDistanceFromBomb( value ) {
		PopExtUtil.SetConvar( "tf_bot_engineer_mvm_hint_min_distance_from_bomb", value )
	}

	// =========================================================

	function NoBusterFF( value ) {
		if ( value != 1 && value != 0 ) {
			PopExtMain.Error.RaiseIndexError( "NoBusterFF", [0, 1] )
			return false
		}

		PopExtUtil.SetConvar( "tf_bot_suicide_bomb_friendly_fire", value = 1 ? 0 : 1 )
	}

	// =========================================================

	function RobotLimit( value ) {

		if ( value > ( MAX_CLIENTS - GetInt( "tf_mvm_defenders_team_size" ) ) ) {

			PopExtMain.Error.RaiseValueError( "RobotLimit", value, "MAX INVADERS > MAX PLAYERS! Update your servers maxplayers!" )
			return false
		}
		if (!IsConVarOnAllowList("tf_mvm_max_invaders"))
			PopExtMain.Error.RaiseValueError( "RobotLimit", value, "tf_mvm_max_invaders is not on the allow list!" )
			return false

		PopExtUtil.SetConvar( "tf_mvm_max_invaders", value )
	}

	// =========================================================

	function HalloweenBossNotSolidToPlayers( value ) {

		if (!value) return

		POP_EVENT_HOOK( "pumpkin_lord_summoned", "HalloweenBossNotSolidToPlayers", function( params ) {

			for ( local boss; boss = FindByClassname( boss, "headless_hatman" ); )
				boss.SetCollisionGroup( COLLISION_GROUP_PUSHAWAY )
		}, EVENT_WRAPPER_MISSIONATTR )

		POP_EVENT_HOOK( "eyeball_boss_summoned", "HalloweenBossNotSolidToPlayers", function( params ) {

			for ( local boss; boss = FindByClassname( boss, "eyeball_boss" ); )
				boss.SetCollisionGroup( COLLISION_GROUP_PUSHAWAY )
		}, EVENT_WRAPPER_MISSIONATTR )

		POP_EVENT_HOOK( "merasmus_summoned", "HalloweenBossNotSolidToPlayers", function( params ) {

			for ( local boss; boss = FindByClassname( boss, "merasmus" ); )
				boss.SetCollisionGroup( COLLISION_GROUP_PUSHAWAY )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================================

	// =====================
	// Disable sniper lasers
	// =====================

	function SniperHideLasers( value ) {

		if ( value < 1 ) return

		function MissionAttributes::ThinkTable::SniperHideLasers() {

			for ( local dot; dot = FindByClassname( dot, "env_sniperdot" ); )
				if ( dot.GetOwner().GetTeam() == TF_TEAM_PVE_INVADERS )
					EntFireByHandle( dot, "Kill", "", -1, null, null )

			return -1
		}
	}

	// ===================================
	// lose wave when all players are dead
	// ===================================

	function TeamWipeWaveLoss( value ) {

		POP_EVENT_HOOK( "player_death", "TeamWipeWaveLoss", function( params ) {

			if ( !PopExtUtil.IsWaveStarted ) return

			PopExtUtil.ScriptEntFireSafe( "__popext_util", "if ( CountAlivePlayers() == 0 ) EntFire( `__popext_roundwin`, `RoundWin` )" )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =============================================================================
	// change sentry kill count per giant kill.  -4 will make giants count as 1 kill
	// =============================================================================

	function GiantSentryKillCountOffset( value ) {

		POP_EVENT_HOOK( "player_death", "GiantSentryKillCount", function( params ) {

			local sentry = EntIndexToHScript( params.inflictor_entindex )
			local victim = GetPlayerFromUserID( params.userid )

			if ( sentry == null ) return

			if ( sentry.GetClassname() != "obj_sentrygun" || !victim.IsMiniBoss() ) return
			local kills = GetPropInt( sentry, "m_iKills" )
			SetPropInt( sentry, "m_iKills", kills + value )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ========================================================================
	// set reset time for flags ( bombs ).
	// accepts a key/value table of flag targetnames and their new return times
	// can also just accept a float value to apply to all flags
	// ========================================================================

	function FlagResetTime( value ) {

		if ( typeof value == "table" )

			foreach ( k, v in value )

				EntFire( k, "SetReturnTime", v.tostring() )
		else

			EntFire( "item_teamflag", "SetReturnTime", value.tostring() )
	}

	BombResetTime = @( value ) FlagResetTime( value )

	// =============================
	// enable bot/blu team headshots
	// =============================

	function BotHeadshots( value ) {

		if ( value < 1 ) return

		POP_EVENT_HOOK( "OnTakeDamage", "BotHeadshots", function( params ) {

			local player = params.attacker, victim = params.const_entity
			local wep = params.weapon

			if ( !player.IsPlayer() || !victim.IsPlayer() ) return

			function CanHeadshot() {

				//check for head hitgroup, or for headshot dmg type but no crit dmg type ( huntsman quirk )
				if ( GetPropInt( victim, "m_LastHitGroup" ) == HITGROUP_HEAD || ( params.damage_stats == TF_DMG_CUSTOM_HEADSHOT && !( params.damage_type & DMG_CRITICAL ) ) ) {

					//are we sniper and do we have a non-sleeper primary?
					if ( player.GetPlayerClass() == TF_CLASS_SNIPER && wep && wep.GetSlot() != SLOT_SECONDARY && PopExtUtil.GetItemIndex( wep ) != ID_SYDNEY_SLEEPER )
						return true

					//are we using classic and is charge meter > 150?  This isn't correct but no GetAttributeValue
					if ( GetPropFloat( wep, "m_flChargedDamage" ) >= 150.0 && PopExtUtil.GetItemIndex( wep ) == ID_CLASSIC )
						return true

					//are we using the ambassador?
					if ( PopExtUtil.GetItemIndex( wep ) == ID_AMBASSADOR || PopExtUtil.GetItemIndex( wep ) == ID_FESTIVE_AMBASSADOR )
						return true

					//did the victim just get explosive headshot? only checks for bleed cond + stun effect so can be edge cases where this returns false erroneously.
					if ( !victim.InCond( TF_COND_BLEEDING ) && !( GetPropInt( victim, "m_iStunFlags" ) & TF_STUN_MOVEMENT ) ) //check for explosive headshot victim.
						return true
				}
				return false
			}

			if ( !CanHeadshot() ) return

			params.damage_type = params.damage_type | DMG_CRITICAL //DMG_USE_HITLOCATIONS doesn't actually work here, no headshot icon.
			params.damage_stats = TF_DMG_CUSTOM_HEADSHOT

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ==============================================================
	// Uses bitflags to enable certain behavior
	// 1  = Robot animations ( excluding sticky demo and jetpack pyro )
	// 2  = Human animations
	// 4  = Enable footstep sfx
	// 8  = Enable voicelines ( WIP )
	// 16 = Enable viewmodels ( WIP )
	// ==============================================================

	function PlayersAreRobots( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "PlayersAreRobots", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()

			if ( "wearable" in scope && scope.wearable != null ) {
				scope.wearable.Kill()
				scope.wearable <- null
			}

			local playerclass  = player.GetPlayerClass()
			local class_string = PopExtUtil.Classes[playerclass]
			local model = format( "models/bots/%s/bot_%s.mdl", class_string, class_string )

			if ( value & 1 ) {
				// sticky anims and thruster anims are particularly problematic
				if ( PopExtUtil.HasItemInLoadout( player, "tf_weapon_pipebomblauncher" ) || PopExtUtil.HasItemInLoadout( player, ID_THERMAL_THRUSTER ) ) {
					PopExtUtil.PlayerBonemergeModel( player, model )
					return
				}

				EntFireByHandle( player, "SetCustomModelWithClassAnimations", model, SINGLE_TICK, null, null )
				PopExtUtil.SetEntityColor( player, 255, 255, 255, 255 )
				SetPropInt( player, "m_nRenderMode", kRenderFxNone )
				// doesn't completely remove the eye-glow but makes it less visible
				EntFireByHandle( player, "DispatchEffect", "ParticleEffectStop", SINGLE_TICK, null, null )
			}

			if ( value & 2 ) {
				// incompatible flags
				if ( value & 1 ) value = value & 1
				PopExtUtil.PlayerBonemergeModel( player, model )
			}

			if ( value & 4 ) {
				scope.stepside <- GetPropInt( player, "m_Local.m_nStepside" )

				function StepThink() {
					if ( self.GetPlayerClass() == TF_CLASS_MEDIC ) return

					if ( GetPropInt( self,"m_Local.m_nStepside" ) != scope.stepside )
						EmitSoundOn( "MVM.BotStep", self )

					scope.stepside = GetPropInt( self,"m_Local.m_nStepside" )
					return -1
				}
				PopExtUtil.AddThink( player, StepThink )
			}
			else
				PopExtUtil.RemoveThink( player, "StepThink" )

			if ( value & 8 ) {

				if ( !PopExtMain.IncludeModules( "robotvoicelines" ) )
					return false

				function MissionAttributes::ThinkTable::RobotVOThink() {

					for ( local ent; ent = FindByClassname( ent, "instanced_scripted_scene" ); ) {

						if ( ent.IsEFlagSet( EFL_USER ) ) continue

						ent.AddEFlags( EFL_USER )

						local owner = GetPropEntity( ent, "m_hOwner" )
						if ( owner != null && !owner.IsBotOfType( TF_BOT_TYPE ) ) {

							local vcdpath = GetPropString( ent, "m_szInstanceFilename" )
							if ( !vcdpath || vcdpath == "" ) return -1

							local dotindex	 = vcdpath.find( "." )
							local slashindex = null
							for ( local i = dotindex; i >= 0; i-- ) {
								if ( vcdpath[i] == '/' || vcdpath[i] == '\\' ) {
									slashindex = i
									break
								}
							}

							local scope = PopExtUtil.GetEntScope( owner )
							scope.soundtable <- POPEXT_ROBOT_VO[owner.GetPlayerClass()]
							scope.vcdname	 <- vcdpath.slice( slashindex+1, dotindex )

							if ( scope.vcdname in scope.soundtable ) {

								local soundscript = scope.soundtable[scope.vcdname]

								if ( typeof soundscript == "string" )
									PopExtUtil.StopAndPlayMVMSound( owner, soundscript, 0 )
								else if ( typeof soundscript == "array" )
									foreach ( sound in soundscript )
										PopExtUtil.StopAndPlayMVMSound( owner, sound[1], sound[0] )
							}
						}
					}
					return -1
				}

			} else
				PopExtUtil.RemoveThink( player, "RobotVOThink" )

			if ( value & 16 ) {

				//run this with a delay for LoadoutControl
				PopExtUtil.ScriptEntFireSafe( player, @"

					if ( `HandModelOverride` in MissionAttributes.CurAttrs ) return

					local vmodel   = PopExtUtil.ROBOT_ARM_PATHS[self.GetPlayerClass()]
					local playervm = GetPropEntity( self, `m_hViewModel` )
					if ( playervm == null ) return
					playervm.GetOrigin()

					if ( playervm == null ) return

					if ( playervm.GetModelName() != vmodel ) playervm.SetModelSimple( vmodel )

					for ( local i = 0; i < SLOT_COUNT; i++ ) {

						local wep = GetPropEntityArray( self, `m_hMyWeapons`, i )
						if ( wep == null || wep.GetModelName() == vmodel ) continue

						wep.SetModelSimple( vmodel )
						wep.SetCustomViewModel( vmodel )
					}

				", SINGLE_TICK )

			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =======================================================
	// Uses bitflags to change behavior:
	// 1   = Blu bots use human models.
	// 2   = Blu bots use zombie models. Overrides human models.
	// 4   = Red bots use human models.
	// 8   = Red bots use zombie models. Overrides human models.
	// 128  = Include buster
	// =======================================================

	function BotsAreHumans( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "BotsAreHumans", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) || !player.IsBotOfType( TF_BOT_TYPE ) )
				return

			if ( "usingcustommodel" in player.GetScriptScope() || ( !( value & 128 ) && player.GetModelName() ==  "models/bots/demo/bot_sentry_buster.mdl" ) ) return

			local classname = PopExtUtil.Classes[player.GetPlayerClass()]
			if ( player.GetTeam() == TF_TEAM_PVE_INVADERS && value > 0 ) {

				if ( value & 2 ) {

					// GenerateAndWearItem() works here, but causes a big perf warning spike on bot spawn
					// faking it doesn't do this

					// this function doesn't apply cosmetics to ragdolls on death
					// PopExtUtil.CreatePlayerWearable( player, format( "models/player/items/%s/%s_zombie.mdl", classname, classname ) )

					// this one does
					PopExtUtil.GiveWearableItem( player, CONST[format( "ID_ZOMBIE_%s", classname.toupper() )], format( "models/player/items/%s/%s_zombie.mdl", classname, classname ) )
					SetPropBool( player, "m_bForcedSkin", true )
					SetPropInt( player, "m_nForcedSkin", player.GetSkin() + 4 )
					SetPropInt( player, "m_iPlayerSkinOverride", 1 )
				}
				EntFireByHandle( player, "SetCustomModelWithClassAnimations", format( "models/player/%s.mdl", classname ), -1, null, null )
			}

			if ( player.GetTeam() == TF_TEAM_PVE_INVADERS && value & 4 ) {

				if ( value & 8 ) {


					// this function doesn't apply cosmetics to ragdolls on death
					// PopExtUtil.CreatePlayerWearable( player, format( "models/player/items/%s/%s_zombie.mdl", classname, classname ) )

					// this one does
					PopExtUtil.GiveWearableItem( player, CONST[format( "ID_ZOMBIE_%s", classname.toupper() )], format( "models/player/items/%s/%s_zombie.mdl", classname, classname ) )
					SetPropBool( player, "m_bForcedSkin", true )
					SetPropInt( player, "m_nForcedSkin", player.GetSkin() + 4 )
					SetPropInt( player, "m_iPlayerSkinOverride", 1 )
				}
				EntFireByHandle( player, "SetCustomModelWithClassAnimations", format( "models/player/%s.mdl", classname ), -1, null, null )
			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ==============================================================
	// 1 = disables romevision on bots 2 = disables rome carrier tank
	// ==============================================================

	function NoRome( value ) {

		local carrier_parts_index = GetModelIndex( "models/bots/boss_bot/carrier_parts.mdl" )

		POP_EVENT_HOOK( "post_inventory_application", "NoRome", function( params ) {

			local bot = GetPlayerFromUserID( params.userid )

			if ( !bot.IsBotOfType( TF_BOT_TYPE ) || bot.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			PopExtUtil.ScriptEntFireSafe( bot, @"

				local armor_model = format( `models/workshop/player/items/%s/tw`, PopExtUtil.Classes[self.GetPlayerClass()] )

				for ( local child = self.FirstMoveChild(); child; child = child.NextMovePeer() )
					if ( child instanceof CEconEntity && startswith( child.GetModelName(), armor_model ) ) {
						SetPropBool( child, STRING_NETPROP_PURGESTRINGS, true )
						EntFireByHandle( child, `Kill`, ``, -1, null, null )
					}
			", -1 )

			if ( value < 2 || MissionAttributes.noromecarrier ) return

			// some maps have a targetname for it
			local carrier = FindByName( null, "botship_dynamic" )

			if ( carrier == null ) {

				for ( local props; props = FindByClassname( props, "prop_dynamic" ); ) {

					if ( GetPropInt( props, STRING_NETPROP_MODELINDEX ) != carrier_parts_index ) continue

					carrier = props
					break
				}
			}

			SetPropIntArray( carrier, STRING_NETPROP_MDLINDEX_OVERRIDES, carrier_parts_index, VISION_MODE_ROME )
			MissionAttributes.noromecarrier = true
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================================

	function SpellRateCommon( value ) {

		PopExtUtil.SetConvar( "tf_spells_enabled", 1 )

		POP_EVENT_HOOK( "player_death", "SpellRateCommon", function( params ) {

			if ( RandomFloat( 0, 1 ) > value ) return

			local bot = GetPlayerFromUserID( params.userid )

			if ( !bot.IsBotOfType( TF_BOT_TYPE ) || bot.IsMiniBoss() ) return

			local spell = SpawnEntityFromTable( "tf_spell_pickup", {

				targetname = "__popext_commonspell"
				origin = bot.GetLocalOrigin()
				TeamNum = TF_TEAM_PVE_DEFENDERS
				tier = 0 
				"OnPlayerTouch#1": "!self,Kill,,0,-1"
			})

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================================

	function SpellRateGiant( value ) {

		PopExtUtil.SetConvar( "tf_spells_enabled", 1 )

		POP_EVENT_HOOK( "player_death", "SpellRateGiant", function( params ) {

			if ( RandomFloat( 0, 1 ) > value ) return

			local bot = GetPlayerFromUserID( params.userid )

			if ( !bot.IsBotOfType( TF_BOT_TYPE ) || !bot.IsMiniBoss() ) return

			local spell = SpawnEntityFromTable( "tf_spell_pickup", {

				targetname = format( "__popext_giantspell_%d", bot.entindex() )
				origin = bot.GetLocalOrigin()
				TeamNum = TF_TEAM_PVE_DEFENDERS
				tier = 0
				"OnPlayerTouch#1": "!self,Kill,,0,-1"
			})

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================================

	function RareSpellRateCommon( value ) {

		PopExtUtil.SetConvar( "tf_spells_enabled", 1 )

		POP_EVENT_HOOK( "player_death", "RareSpellRateCommon", function( params ) {

			if ( RandomFloat( 0, 1 ) > value ) return

			local bot = GetPlayerFromUserID( params.userid )
			if ( !bot.IsBotOfType( TF_BOT_TYPE ) || bot.IsMiniBoss() ) return

			local spell = SpawnEntityFromTable( "tf_spell_pickup", {
				targetname = format( "__popext_commonspell_%d", bot.entindex() )
				origin = bot.GetLocalOrigin()
				TeamNum = TF_TEAM_PVE_DEFENDERS
				tier = 1
				"OnPlayerTouch#1": "!self,Kill,,0,-1"
			})

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =========================================================

	function RareSpellRateGiant( value ) {

		PopExtUtil.SetConvar( "tf_spells_enabled", 1 )

		POP_EVENT_HOOK( "player_death", "RareSpellRateGiant", function( params ) {

			if ( RandomFloat( 0, 1 ) > value ) return

			local bot = GetPlayerFromUserID( params.userid )
			if ( !bot.IsBotOfType( TF_BOT_TYPE ) || !bot.IsMiniBoss() ) return

			local spell = SpawnEntityFromTable( "tf_spell_pickup", {

				targetname = format( "__popext_giantspell_%d", bot.entindex() )
				origin = bot.GetLocalOrigin()
				TeamNum = TF_TEAM_PVE_DEFENDERS
				tier = 1
				"OnPlayerTouch#1": "!self,Kill,,0,-1"
			})

		}, EVENT_WRAPPER_MISSIONATTR )

	}

	// ============================================================================================
	// skeleton's spawned by bots or tf_zombie entities will no longer split into smaller skeletons
	// ============================================================================================

	function NoSkeleSplit( value ) {

		function MissionAttributes::ThinkTable::NoSkeleSplitThink() {

			if ( !PopExtUtil.IsWaveStarted ) return

			//kill skele spawners before they split from tf_zombie_spawner
			for ( local skelespell; skelespell = FindByClassname( skelespell, "tf_projectile_spellspawnzombie" ); ) {

				if ( !GetPropBool( skelespell, STRING_NETPROP_PURGESTRINGS ) )
					SetPropBool( skelespell, STRING_NETPROP_PURGESTRINGS, true )

				if ( !GetPropEntity( skelespell, "m_hThrower" ) )
					EntFireByHandle( skelespell, "Kill", "", -1, null, null )
			}

			// m_hThrower does not change when the skeletons split for spell-casted skeles, just need to kill them after spawning
			for ( local skeles; skeles = FindByClassname( skeles, "tf_zombie" );  ) {
				// kill bot owned split skeles
				if ( !skeles.GetModelScale().tointeger() && ( !skeles.GetOwner() || skeles.GetOwner().IsBotOfType( TF_BOT_TYPE ) ) ) {
					SetPropBool( skeles, STRING_NETPROP_PURGESTRINGS, true )
					EntFireByHandle( skeles, "Kill", "", -1, null, null )
					return
				}
				// if ( skeles.GetTeam() == 5 ) {
				// 	skeles.SetTeam( TF_TEAM_PVE_INVADERS )
				// 	skeles.SetSkin( 1 )
				// }
			}
		}
	}

	// ====================================================================
	// ready-up countdown time.  Values below 9 will disable starting music
	// ====================================================================

	function WaveStartCountdown( value ) {

		function MissionAttributes::ThinkTable::WaveStartCountdownThink() {

			if ( PopExtUtil.IsWaveStarted ) return

			local roundtime = GetPropFloat( PopExtUtil.GameRules, "m_flRestartRoundTime" )

			if ( roundtime > Time() + value ) {

				local ready = PopExtUtil.GetPlayerReadyCount()
				if ( ready >= PopExtUtil.HumanTable.len() || ( roundtime <= 12.0 ) )
					SetPropFloat( PopExtUtil.GameRules, "m_flRestartRoundTime", Time() + value )
			}
		}
	}
	// =====================================================================================
	// stores all path_track positions in a table and re-spawns them dynamically when needed
	// Breaks branching paths!
	// =====================================================================================
	function OptimizePathTracks( value ) {

		local optimized_tracks = {}
		local preserved_tracks = []

		for ( local train; train = FindByClassname( train, "func_tracktrain" ); ) {

			local starting_track = FindByName( null, GetPropString( train, "m_target" ) )
			local next_track = GetPropEntity( starting_track, "m_pnext" )
			preserved_tracks.extend( [starting_track, next_track] )
		}
		for ( local payload; payload = FindByClassname( payload, "team_train_watcher" ); ) {

			local starting_track = FindByName( null, GetPropString( payload, "m_iszStartNode" ) )
			local goal_track = FindByName( null, GetPropString( payload, "m_iszGoalNode" ) )
			local next_track = GetPropEntity( starting_track, "m_pnext" )
			preserved_tracks.extend( [starting_track, next_track, goal_track] )
		}
		for ( local track; track = FindByClassname( track, "path_track" ); ) {

			local trackname = track.GetName()

			local split_trackname = split( trackname, "_" ), last = split_trackname[split_trackname.len() - 1]

			optimized_tracks[last] <- {

				targetname 		= track.GetName()
				target 			= GetPropString( track, "m_target" )
				origin 			= track.GetOrigin()
				orientationtype = GetPropInt( track, "m_eOrientationType" )
				altpath 		= GetPropString( track, "m_altName" )
				speed 			= GetPropFloat( track, "m_flSpeed" )

				"OnPass#1"		: "!self,CallScriptFunction,SpawnNextTrack,0,-1"
				"OnPass#2"		: "!self,Kill,,0.1,-1"

				outputs 		= PopExtUtil.GetAllOutputs( track, "OnPass" )
			}
			optimized_tracks[last].outputs.append( PopExtUtil.GetAllOutputs( track, "OnTeleport" ) )

			EntFireByHandle( track, "Kill", "", -1, null, null )
		}

		MissionAttributes.OptimizedTracks = optimized_tracks

		foreach( k,v in optimized_tracks ) {

			local pos = v.origin
			DebugDrawBox( pos, Vector( -8, -8, -8 ), Vector( 8, 8, 8 ), 255, 0, 100, 150, 30 )
			// printl( k + " : " + v.targetname )
		}
	}

	// =======================================================================================================================
	// array of arrays with xyz values to spawn path_tracks at, also accepts vectors
	// path_track names are ordered based on where they are listed in the array

	// example:

	//`ExtraTankPath`: [
	//	[`686 4000 392`, `667 4358 390`, `378 4515 366`, `-193 4250 289`], // starting node: extratankpath1_1
	//	[`640 5404 350`, `640 4810 350`, `640 4400 550`, `1100 4100 650`, `1636 3900 770`] //starting node: extratankpath2_1
	//]
	// the last track in the list will have _lastnode appended to the targetname
	// ======================================================================================================================

	function ExtraTankPath( value ) {

		if ( typeof value != "array" && typeof value != "table" ) {

			PopExtMain.Error.RaiseTypeError( "ExtraTankPath", "array or table" )
			return false
		}

		if ( !( "ExtraTankPathTracks" in MissionAttributes ) )
			MissionAttributes.ExtraTankPathTracks <- []

		local path_name = "extratankpath"

		if ( typeof value == "table" ) {

			if ( "name" in value )
				path_name = value.name

			value = value.tracks
		}

		// we get silly
		// converts a mixed array of space/comma separated xyz values, or Vectors, into an array of Vectors
		local paths = value.map( @( path )( path.map( @( pos ) typeof pos == "Vector" ? pos : ( ( ( pos.find( "," ) ? split( pos, "," ) : split( pos, " " ) ).apply( @( val ) val.tofloat() ) ).apply( @( _, _, val ) Vector( val[0], val[1], val[2] ) )[0] ) ) ) )

		local spawner = CreateByClassname( "point_script_template" )
		local scope = PopExtUtil.GetEntScope( spawner )

		scope.tracks <- []
		scope.__EntityMakerResult <- {
			entities = scope.tracks
		}.setdelegate( {
			function _newslot( _, value ) {
				entities.append( value )
			}
		})

		foreach ( path in paths ) {

			PathNum++

			for ( local path; path = FindByName( path, format( "%s*", path_name ) ); )
				EntFireByHandle( path, "Kill", "", -1, null, null )

			foreach ( i, pos in path ) {

				local trackname = format( "%s%d_%d", path_name, PathNum, i+1 )
				local nexttrackname = format( "%s%d_%d", path_name, PathNum, i+2 )

				local track = {
					targetname = trackname
					origin = pos
				}
				if ( i+1 in path )
					track.target <- nexttrackname

				spawner.AddTemplate( "path_track", track )
			}
		}
		spawner.AcceptInput( "ForceSpawn", "", null, null )
		ExtraTankPathTracks.extend( scope.tracks )
		spawner.Kill()
	}


	// =======================================
	// replace viewmodel arms with custom ones
	// =======================================

	function HandModelOverride( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "HandModelOverride", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = player.GetScriptScope()

			function ArmThink() {

				local tfclass	   = player.GetPlayerClass()
				local class_string = PopExtUtil.Classes[tfclass]

				local vmodel   = null
				local playervm = GetPropEntity( player, "m_hViewModel" )

				if ( typeof value == "string" )
					vmodel = PopExtUtil.StringReplace( value, "%class", class_string )
				else if ( typeof value == "array" ) {
					if ( value.len() == 0 ) return

					if ( tfclass >= value.len() )
						vmodel = PopExtUtil.StringReplace( value[0], "%class", class_string )
					else
						vmodel = value[tfclass]
				}
				else {
					// do we need to do anything special for thinks??
					PopExtMain.Error.RaiseValueError( "HandModelOverride", value, "Value must be string or array of strings" )
					return false
				}

				if ( vmodel == null ) return

				if ( playervm.GetModelName() != vmodel ) playervm.SetModelSimple( vmodel )

				for ( local i = 0; i < SLOT_COUNT; i++ ) {
					local wep = GetPropEntityArray( player, STRING_NETPROP_MYWEAPONS, i )
					if ( wep == null || ( wep.GetModelName() == vmodel ) ) continue

					wep.SetModelSimple( vmodel )
					wep.SetCustomViewModel( vmodel )
				}
			}
			PopExtUtil.AddThink( player, "ArmThink" )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ===========================================================
	// add cond to every player on spawn with an optional duration
	// ===========================================================

	function AddCond( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "AddCond", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			if ( typeof value == "array" ) {

				player.RemoveCondEx( value[0], true )
				PopExtUtil.ScriptEntFireSafe( player, format( "self.AddCondEx( %d, %f, null )", value[0], value[1] ), -1 )
			}
			else if ( typeof value == "integer" ) {

				player.RemoveCond( value )
				PopExtUtil.ScriptEntFireSafe( player, format( "self.AddCond( %d )", value ), -1 )
			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ======================================================
	// add/modify player attributes, can be filtered by class
	// ======================================================

	function PlayerAttributes( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "PlayerAttributes", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			if ( typeof value != "table" ) {
				PopExtMain.Error.RaiseTypeError( "PlayerAttributes", "table" )
				return false
			}

			local tfclass = player.GetPlayerClass()
			foreach ( k, v in value ) {

				if ( typeof v != "table" )
					PopExtUtil.SetPlayerAttributes( player, k, v )
				else if ( tfclass in value ) {

					local table = value[tfclass]
					foreach ( k, v in table ) {
						PopExtUtil.SetPlayerAttributes( player, k, v )
					}
				}
			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ======================================================================
	// add/modify item attributes, can be filtered by item index or classname
	// ======================================================================

	function ItemAttributes( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "ItemAttributes", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			if ( typeof value != "table" ) {
				PopExtMain.Error.RaiseTypeError( "ItemAttributes", "table" )
				return false
			}

			local showhidden = "ShowHiddenAttributes" in MissionAttributes.CurAttrs && MissionAttributes.CurAttrs.ShowHiddenAttributes

			foreach( item, attributes in value )
				PopExtUtil.SetPlayerAttributesMulti( player, item, attributes, false, showhidden )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// ============================================================
	// TODO: once we have our own giveweapon functions, finish this
	// ============================================================

	function LoadoutControl( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "LoadoutControl", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			function DoLoadoutControl( item, replacement ) {

				local wep = PopExtUtil.HasItemInLoadout( player, item )

				if ( !wep ) return

				if ( GetPropEntity( wep, "m_hExtraWearable" ) ) {

					GetPropEntity( wep, "m_hExtraWearableViewModel" ).Kill()
					GetPropEntity( wep, "m_hExtraWearable" ).Kill()
				}

				wep.Kill()

				if ( !replacement ) return

				try

					if ( "ExtraItems" in ROOT && replacement in ExtraItems )

						PopExtWeapons.GiveItem( replacement, player )
					else

						PopExtUtil.GiveWeapon( player, PopExtItems[replacement].item_class, PopExtItems[replacement].id )

				catch( _ )

					if ( typeof replacement == "table" )

						foreach ( classname, itemid in replacement )

							PopExtUtil.GiveWeapon( player, classname, itemid )

					else if ( typeof replacement == "string" )

						if ( "ExtraItems" in ROOT && replacement in ExtraItems )

							PopExtWeapons.GiveItem( replacement, player )

						else if ( replacement in PopExtItems )

							PopExtUtil.GiveWeapon( player, PopExtItems[replacement].item_class, PopExtItems[replacement].id )

					else

						PopExtMain.Error.RaiseTypeError( format( "LoadoutControl: %s", replacement.tostring() ), "table or item_map string" )
			}

			foreach ( item, replacement in value ) {

				if ( typeof item == "string" && item.find( "," ) ) {

					local idarray = split( item, "," )

					if ( idarray.len() > 1 )
						idarray.apply( @( val ) val.tointeger() )
					item = idarray
				}
				if ( typeof item == "array" )
					foreach ( i in item )
						DoLoadoutControl( i, replacement )
				else
					DoLoadoutControl( item, replacement )
			}

			PopExtUtil.ScriptEntFireSafe( player, "PopExtUtil.SwitchToFirstValidWeapon( self )", SINGLE_TICK )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// =====================================================================================
	// mostly used for replacing teamplay_broadcast_audio sounds
	// also hardcoded to replace specific sounds for tanks/deaths

	// see `replace weapon fire sound` and more in customattributes.nut for wep sounds
	// see the tank sound overrides in hooks.nut for more comprehensive tank sound overrides
	// =====================================================================================

	function SoundOverrides( value ) {

		if ( typeof value != "table" ) {
			PopExtMain.Error.RaiseTypeError( "SoundOverrides", "table" )
			return false
		}

		local DeathSounds = {

			"MVM.GiantCommonExplodes": null
			"MVM.SentryBusterExplode": null
			"MVM.PlayerDied": null
		}

		local TankSounds = {

			"MVM.TankStart"		 : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankEnd" 		 : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankPing" 		 : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankEngineLoop" : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankSmash" 	 : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankDeploy" 	 : "SOUNDOVERRIDE_PLACEHOLDER"
			"MVM.TankExplodes" 	 : "SOUNDOVERRIDE_PLACEHOLDER"
		}

		foreach ( sound, override in value ) {

			PrecacheSound( sound )
			PrecacheScriptSound( sound )

			if ( override != null ) {

				PrecacheSound( override )
				PrecacheScriptSound( override )
			}

			if ( sound in DeathSounds ) {

				DeathSounds[ sound ] <- []
				if ( override != null ) DeathSounds[ sound ].append( override )
			}
			// sound.split( sound, "k" )[1]
			if ( sound in TankSounds ) {

				TankSounds[	sound ] <- []
				if ( override != null ) TankSounds[ sound ].append( override )
			}

			MissionAttributes.SoundsToReplace[ sound ] <- override
		}

		//tank overrides
		function MissionAttributes::ThinkTable::SetTankSounds() {

			for ( local tank; tank = FindByClassname( tank, "tank_boss" ); ) {

				local scope = PopExtUtil.GetEntScope( tank )

				if ( !( "popProperty" in scope ) )
					scope.popProperty <- {}

				if ( !( "SoundOverrides" in scope ) )
					scope.popProperty.SoundOverrides <- {}

				local sound_overrides = scope.popProperty.SoundOverrides
				foreach ( tanksound, tankoverride in TankSounds ) {

					local tanksound_popproperty = split( tanksound, "k" )[1]

					if ( !( tanksound_popproperty in sound_overrides ) && tankoverride != "SOUNDOVERRIDE_PLACEHOLDER" )
						sound_overrides[ tanksound_popproperty ] <- tankoverride
				}
			}
		}

		//death overrides
		POP_EVENT_HOOK( "player_death", "SoundOverrides", function( params ) {

			local victim = GetPlayerFromUserID( params.userid )

			foreach ( sound, override in DeathSounds ) {

				if ( override ) {

					// StopSoundOn( sound, victim )
					function MissionAttributes::EmitSoundFunc() {

						if ( override && override.len() )
							EmitSoundEx( {sound_name = override[0], entity = victim} )
					}

					PopExtUtil.ScriptEntFireSafe( victim, format( "StopSoundOn( `%s`, self )", sound ), -1 )
					EntFireByHandle( MissionAttrEntity, "CallScriptFunction", "EmitSoundFunc", -1, null, null )
				}
			}

			if ( MissionAttributes.SoundsToReplace.len() ) {

				foreach ( sound, override in MissionAttributes.SoundsToReplace ) {

					foreach ( player in PopExtUtil.HumanArray ) {

						StopSoundOn( sound, player )
						if ( override == null ) continue
						EmitSoundEx( {sound_name = MissionAttributes.SoundsToReplace[sound], entity = player} )
					}
				}
			}

		}, EVENT_WRAPPER_MISSIONATTR )

		//unused
		// POP_EVENT_HOOK( "OnTakeDamage", "SoundOverrides", function( params ) {

		// }, EVENT_WRAPPER_MISSIONATTR )
	}

	function NoThrillerTaunt( value ) {

		POP_EVENT_HOOK( "post_inventory_application", "NoThrillerTaunt", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			function NoThrillerTauntThink() {

				if ( self.IsTaunting() ) {

					for ( local scene; scene = FindByClassname( scene, "instanced_scripted_scene" ); ) {

						local owner = GetPropEntity( scene, "m_hOwner" )
						if ( owner == self ) {

							local name = GetPropString( scene, "m_szInstanceFilename" )
							local thriller_name = self.GetPlayerClass() == TF_CLASS_MEDIC ? "taunt07" : "taunt06"
							if ( name.find( thriller_name ) != null ) {

								scene.Kill()
								self.RemoveCond( TF_COND_TAUNTING )
								self.Taunt( TAUNT_BASE_WEAPON, 0 )
								break
							}
						}
					}
				}
			}
			PopExtUtil.AddThink( player, NoThrillerTauntThink )
		}, EVENT_WRAPPER_MISSIONATTR )
	}
	// =====================================
	// uses bitflags to enable random crits:
	// 1 - Blue humans
	// 2 - Blue robots
	// 4 - Red  robots
	// =====================================

	function EnableRandomCrits( value ) {

		if ( value == 0.0 ) return

		local user_chance = ( args.len() > 2 ) ? args[2] : null

		// Simplified rare high moments
		local base_ranged_crit_chance = 0.0005
		local max_ranged_crit_chance  = 0.0020
		local base_melee_crit_chance  = 0.15
		local max_melee_crit_chance   = 0.60
		// 4 kills to reach max chance

		local timed_crit_weapons = {
			"tf_weapon_handgun_scout_secondary" : null,
			"tf_weapon_pistol_scout" : null,
			"tf_weapon_flamethrower" : null,
			"tf_weapon_minigun" : null,
			"tf_weapon_pistol" : null,
			"tf_weapon_syringegun_medic" : null,
			"tf_weapon_smg" : null,
			"tf_weapon_charged_smg" : null,
		}

		local no_crit_weapons = {
			"tf_weapon_laser_pointer" : null,
			"tf_weapon_medigun"	: null,
			"tf_weapon_sniperrifle" : null,
		}

		function MissionAttributes::ThinkTable::EnableRandomCritsThink() {

			if ( !PopExtUtil.IsWaveStarted ) return -1

			foreach ( player in PopExtUtil.PlayerArray ) {

				if ( !( ( value & 1 && player.GetTeam() == TF_TEAM_PVE_INVADERS && !player.IsBotOfType( TF_BOT_TYPE ) ) ||
					( value & 2 && player.GetTeam() == TF_TEAM_PVE_INVADERS && player.IsBotOfType( TF_BOT_TYPE ) )  ||
					( value & 4 && player.GetTeam() == TF_TEAM_PVE_DEFENDERS && player.IsBotOfType( TF_BOT_TYPE ) ) ) )
					continue

				local scope = player.GetScriptScope()
				if ( !( "crit_weapon" in scope ) )
					scope.crit_weapon <- null

				if ( !( "ranged_crit_chance" in scope ) || !( "melee_crit_chance" in scope ) ) {

					scope.ranged_crit_chance <- base_ranged_crit_chance
					scope.melee_crit_chance <- base_melee_crit_chance
				}

				if ( !player.IsAlive() || player.GetTeam() == TEAM_SPECTATOR ) continue

				local wep       = player.GetActiveWeapon()
				local index     = PopExtUtil.GetItemIndex( wep )
				local classname = wep.GetClassname()

				// Lose the crits if we switch weapons
				if ( scope.crit_weapon != null && scope.crit_weapon != wep )
					player.RemoveCond( TF_COND_CRITBOOSTED_CTF_CAPTURE )

				// Wait for bot to use its crits
				if ( scope.crit_weapon != null && player.InCond( TF_COND_CRITBOOSTED_CTF_CAPTURE ) ) continue

				// We handle melee weapons elsewhere in OnTakeDamage
				if ( wep == null || wep.IsMeleeWeapon() ) continue
				// Certain weapon types never receive random crits
				if ( classname in no_crit_weapons || wep.GetSlot() > 2 ) continue
				// Ignore weapons with certain attributes
				// if ( wep.GetAttribute( "crit mod disabled", 1 ) == 0 || wep.GetAttribute( "crit mod disabled hidden", 1 ) == 0 ) continue

				local crit_chance_override = ( user_chance > 0 ) ? user_chance : null
				local chance_to_use        = ( crit_chance_override != null ) ? crit_chance_override : scope.ranged_crit_chance

				// Roll for random crits
				if ( RandomFloat( 0, 1 ) < chance_to_use ) {

					player.AddCond( TF_COND_CRITBOOSTED_CTF_CAPTURE )
					scope.crit_weapon <- wep

					// Detect weapon fire to remove our crits
					PopExtUtil.GetEntScope( wep ).last_fire_time <- Time()

					function Think() {

						local fire_time = GetPropFloat( self, "m_flLastFireTime" )
						if ( fire_time > last_fire_time ) {

							local owner = self.GetOwner()
							owner.RemoveCond( TF_COND_CRITBOOSTED_CTF_CAPTURE )

							local scope = PopExtUtil.GetEntScope( owner )

							// Continuous fire weapons get 2 seconds of crits once they fire
							if ( classname in timed_crit_weapons ) {

								owner.AddCondEx( TF_COND_CRITBOOSTED_CTF_CAPTURE, 2, null )
								PopExtUtil.ScriptEntFireSafe( owner, format( "crit_weapon <- null; ranged_crit_chance <- %f", base_ranged_crit_chance ), 2 )
							}
							else {

								scope.crit_weapon <- null
								scope.ranged_crit_chance <- base_ranged_crit_chance
							}

							SetPropString( self, "m_iszScriptThinkFunction", "" )
						}
						return -1
					}
					PopExtUtil.GetEntScope( wep ).Think <- Think
					AddThinkToEnt( wep, "Think" )
				}
			}
		}

		POP_EVENT_HOOK( "player_death", "EnableRandomCritsKill", function( params ) {

			local attacker = GetPlayerFromUserID( params.attacker )
			if ( attacker == null || !attacker.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = PopExtUtil.GetEntScope( attacker )
			if ( !( "ranged_crit_chance" in scope ) || !( "melee_crit_chance" in scope ) ) return

			if ( scope.ranged_crit_chance + base_ranged_crit_chance > max_ranged_crit_chance )
				scope.ranged_crit_chance <- max_ranged_crit_chance
			else
				scope.ranged_crit_chance <- scope.ranged_crit_chance + base_ranged_crit_chance

			if ( scope.melee_crit_chance + base_melee_crit_chance > max_melee_crit_chance )
				scope.melee_crit_chance <- max_melee_crit_chance
			else
				scope.melee_crit_chance <- scope.melee_crit_chance + base_melee_crit_chance

		}, EVENT_WRAPPER_MISSIONATTR )

		POP_EVENT_HOOK( "OnTakeDamage", "EnableRandomCritsTakeDamage", function( params ) {

			if ( !( "inflictor" in params ) ) return

			local attacker = params.inflictor
			if ( attacker == null || !attacker.IsPlayer() || !attacker.IsBotOfType( TF_BOT_TYPE ) ) return

			local scope = PopExtUtil.GetEntScope( attacker )
			if ( !( "melee_crit_chance" in scope ) ) return

			// Already a crit
			if ( params.damage_type & DMG_CRITICAL ) return

			// Only Melee weapons
			local wep = attacker.GetActiveWeapon()
			if ( !wep.IsMeleeWeapon() ) return

			// Certain weapon types never receive random crits
			if ( attacker.GetPlayerClass() == TF_CLASS_SPY ) return
			// Ignore weapons with certain attributes
			// if ( wep.GetAttribute( "crit mod disabled", 1 ) == 0 || wep.GetAttribute( "crit mod disabled hidden", 1 ) == 0 ) return

			// Roll our crit chance
			if ( RandomFloat( 0, 1 ) < scope.melee_crit_chance ) {
				params.damage_type = params.damage_type | DMG_CRITICAL
				// We delay here to allow death code to run so the reset doesn't get overriden
				PopExtUtil.ScriptEntFireSafe( attacker, format( "melee_crit_chance <- %f", base_melee_crit_chance ), SINGLE_TICK )
			}

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	// auto-collect all money on drop
	function ForceRedMoney( value ) {
		PopExtUtil.SetRedMoney( value )
	}

	// =======================================
	// 1 = enables basic Reverse MvM behavior
	// 2 = blu players cannot pick up bombs
	// 4 = blu players have infinite ammo
	// 8 = blu spies have infinite cloak
	// 16 = blu players have spawn protection
	// 32 = blu players cannot attack in spawn
	// 64 = remove blu footsteps
	// =======================================

	function ReverseMVM( value ) {

		// Prevent bots on red team from hogging slots so players can always join and get switched to blue
		// TODO: Needs testing
		// also need to reset it
		// PopExtUtil.SetConvar( "tf_mvm_defenders_team_size", 999 )
		local max_team_size = GetInt( "tf_mvm_defenders_team_size" )

		function MissionAttributes::DeployBombStart( player ) {

			//do this so we can do CancelPending
			local deployrelay = SpawnEntityFromTable( "logic_relay", {

				targetname = format( "__popext_bombdeploy_%d", player.entindex() )

				"OnTrigger#1": "__popext_util,CallScriptFunction,EndWaveReverse,2,-1"
				"OnTrigger#2": "boss_deploy_relay,Trigger,,2,-1"
			})

			if ( !GetPropEntity( player, "m_hItem" ) ) return

			player.DisableDraw()

			for ( local child = player.FirstMoveChild(); child; child = child.NextMovePeer() )
				child.DisableDraw()

			player.AddCustomAttribute( "move speed bonus", 0.00001, -1 )
			player.AddCustomAttribute( "no_jump", 1, -1 )

			local dummy = CreateByClassname( "prop_dynamic" )

			PopExtUtil.SetTargetname( dummy, format( "__deployanim%d", player.entindex() ) )
			dummy.SetAbsOrigin( player.GetOrigin() )
			dummy.SetAbsAngles( player.GetAbsAngles() )
			dummy.SetModel( player.GetModelName() )
			dummy.SetSkin( player.GetSkin() )

			DispatchSpawn( dummy )
			dummy.ResetSequence( dummy.LookupSequence( "primary_deploybomb" ) )

			EmitSoundEx({
				sound_name = player.IsMiniBoss() ? "MVM.DeployBombGiant" : "MVM.DeployBombSmall"
				entity = player
				flags = SND_CHANGE_VOL
				volume = 0.5
			})

			EntFireByHandle( player, "SetForcedTauntCam", "1", -1, null, null )
			EntFireByHandle( player, "SetHudVisibility", "0", -1, null, null )
			EntFire( format( "__popext_bombdeploy_%d", player.entindex() ), "Trigger" )
		}

		function MissionAttributes::DeployBombStop( player ) {

			if ( !GetPropEntity( player, "m_hItem" ) ) return

			player.EnableDraw()

			for ( local child = player.FirstMoveChild(); child; child = child.NextMovePeer() )
				child.EnableDraw()

			player.RemoveCustomAttribute( "move speed bonus" )
			player.RemoveCustomAttribute( "no_jump" )

			FindByName( null, format( "__deployanim%d", player.entindex() ) ).Kill()

			StopSoundOn( player.IsMiniBoss() ? "MVM.DeployBombGiant" : "MVM.DeployBombSmall", player )

			EntFireByHandle( player, "SetForcedTauntCam", "0", -1, null, null )
			EntFireByHandle( player, "SetHudVisibility", "1", -1, null, null )
			EntFire( format( "__popext_bombdeploy_%d", player.entindex() ), "CancelPending" )
			EntFire( format( "__popext_bombdeploy_%d", player.entindex() ), "Kill" )
		}

		// Enforce max team size
		function MissionAttributes::ThinkTable::ReverseMVMThink() {

			foreach ( i, player in PopExtUtil.HumanArray ) {

				if ( i + 1 > max_team_size && player.GetTeam() != TEAM_SPECTATOR )
					player.ForceChangeTeam( TEAM_SPECTATOR, false )
			}

			// Readying up starts the round
			if ( !( "WaveStartCountdown" in MissionAttributes ) && !PopExtUtil.IsWaveStarted ) {

				local ready = PopExtUtil.GetPlayerReadyCount()
				if (
					ready && ready >= PopExtUtil.HumanTable.len()
					&& GetPropFloat( PopExtUtil.GameRules, "m_flRestartRoundTime" ) >= Time() + 12.0
				) {
					SetPropFloat( PopExtUtil.GameRules, "m_flRestartRoundTime", Time() + 10.0 )
				}
			}
		}

		POP_EVENT_HOOK( "post_inventory_application", "ReverseMVMSpawn", function( params ) {

			if ( !("ReverseMVM" in MissionAttributes.CurAttrsPre) && !("ReverseMVM" in MissionAttributes.CurAttrs) ) {

				foreach ( i, player in PopExtUtil.HumanArray ) {

					PopExtUtil.RemoveThink( player, "ReverseMVMLaserThink" )
					PopExtUtil.RemoveThink( player, "ReverseMVMCurrencyThink" )
					PopExtUtil.RemoveThink( player, "ReverseMVMPackThink" )
					PopExtUtil.RemoveThink( player, "ReverseMVMDrainAmmoThink" )
				}

				POP_EVENT_HOOK( "post_inventory_application", "ReverseMVMSpawn", null, EVENT_WRAPPER_MISSIONATTR )
				return
			}

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsBotOfType( TF_BOT_TYPE ) || player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) )
				return

			local scope = player.GetScriptScope()

			// Switch to blue team
			if ( player.GetTeam() != TF_TEAM_PVE_INVADERS ) {
				PopExtUtil.ScriptEntFireSafe( player, "PopExtUtil.ChangePlayerTeamMvM( self, TF_TEAM_PVE_INVADERS, true )", SINGLE_TICK )
			}

			// Kill any phantom lasers from respawning as engie ( yes this is real )
			PopExtUtil.ScriptEntFireSafe( player, @"
				for ( local ent; ent = FindByClassname( ent, `env_laserdot` ); )
					if ( ent.GetOwner() == self )
						EntFireByHandle( ent, `Kill`, ``, -1, null, null )
			", 0.5 )

			// Temporary solution for engie wrangler laser
			scope.handled_laser   <- false
			function ReverseMVMLaserThink() {

				if ( !( "laser_spawntime" in scope ) )
					scope.laser_spawntime <- -1

				local laser_spawntime = scope.laser_spawntime

				if ( !player.IsAlive() || player.GetTeam() == TEAM_SPECTATOR ) return

				local wep = player.GetActiveWeapon()

				if ( wep && wep.GetClassname() == "tf_weapon_laser_pointer" ) {
					if ( laser_spawntime == -1 )
						laser_spawntime = Time() + 0.55
				}
				else {
					if ( laser_spawntime > -1 ) {
						laser_spawntime = -1
						handled_laser   = false
					}
					return
				}

				if ( handled_laser ) return
				if ( Time() < laser_spawntime ) return

				local laser = null
				for ( local ent; ent = FindByClassname( ent, "env_laserdot" ); ) {
					if ( ent.GetOwner() == player ) {
						laser = ent
						break
					}
				}

				for ( local ent; ent = FindByClassname( ent, "obj_sentrygun" ); ) {
					local builder = GetPropEntity( ent, "m_hBuilder" )
					if ( builder != player ) continue

					if ( !GetPropBool( ent, "m_bPlayerControlled" ) || laser == null ) continue

					originalposition <- player.GetOrigin()
					originalvelocity <- player.GetAbsVelocity()
					originalmovetype <- player.GetMoveType()
					player.SetAbsOrigin( ent.GetOrigin() + Vector( 0, 0, -32 ) )
					player.SetAbsVelocity( Vector() )
					player.SetMoveType( MOVETYPE_NOCLIP, MOVECOLLIDE_DEFAULT )
					PopExtUtil.ScriptEntFireSafe( laser, "self.SetTeam( TF_TEAM_PVE_DEFENDERS )", SINGLE_TICK )
					PopExtUtil.ScriptEntFireSafe( self, "self.SetAbsOrigin( originalposition ); self.SetAbsVelocity( originalvelocity ); self.SetMoveType( originalmovetype, MOVECOLLIDE_DEFAULT )", SINGLE_TICK )

					handled_laser = true
					return
				}

				if ( !handled_laser && laser != null )
					laser.Kill()
			}

			// Allow money collection
			local collectionradius = 0
			function ReverseMVMCurrencyThink() {

				// Find currency near us
				local origin = player.GetOrigin()
				player.GetPlayerClass() != TF_CLASS_SCOUT ? collectionradius = 72 : collectionradius = 288

				for ( local moneypile; moneypile = FindByClassnameWithin( moneypile, "item_currencypack_*", origin, collectionradius ); ) {

					// NEW COLLECTION METHOD ( royal )
					local objective_resource = PopExtUtil.ObjectiveResource
					local money_before = GetPropInt( objective_resource, "m_nMvMWorldMoney" )

					moneypile.SetAbsOrigin( Vector( -1000000, -1000000, -1000000 ) )
					moneypile.Kill()

					local money_after = GetPropInt( objective_resource, "m_nMvMWorldMoney" )

					local money_value = money_before - money_after

					local credits_acquired_prop = "m_currentWaveStats.nCreditsAcquired"
					local mvm_stats_ent = PopExtUtil.MvMStatsEnt
					SetPropInt( mvm_stats_ent, credits_acquired_prop, GetPropInt( mvm_stats_ent, credits_acquired_prop ) + money_value )

					foreach( player in PopExtUtil.HumanArray )
						player.AddCurrency( money_value )

					EmitSoundOn( "MVM.MoneyPickup", player )

					// scout money healing
					if ( player.GetPlayerClass() == TF_CLASS_SCOUT ) {

						local cur_health = player.GetHealth()
						local max_health = player.GetMaxHealth()
						local health_addition = cur_health < max_health ? 50 : 25

						// If we cross the border into insanity, scale the reward
						local health_cap = max_health * 4
						if ( cur_health > health_cap ) {

							health_addition = PopExtUtil.RemapValClamped( cur_health, health_cap, ( health_cap * 1.5 ), 20, 5 )
						}

						player.SetHealth( cur_health + health_addition )
					}
				}
			}

			// Allow health/ammo pack pickup
			function ReverseMVMPackThink() {

				local origin = player.GetOrigin()

				for ( local ent; ent = FindByClassnameWithin( ent, "item_*", origin, 40 ); ) {

					if ( ent.IsEFlagSet( EFL_USER ) || GetPropInt( ent, "m_fEffects" ) & EF_NODRAW ) continue

					local classname = ent.GetClassname()
					if ( startswith( classname, "item_currencypack_" ) ) continue

					local refill    = false
					local is_health = false

					local multiplier = 0.0
					if ( endswith( classname, "_small" ) )       multiplier = 0.2
					else if ( endswith( classname, "_medium" ) ) multiplier = 0.5
					else if ( endswith( classname, "_full" ) )   multiplier = 1.0

					if ( startswith( classname, "item_ammopack_" ) ) {

						local metal    = GetPropIntArray( player, STRING_NETPROP_AMMO, TF_AMMO_METAL )
						local maxmetal = 200

						if ( metal < maxmetal ) {

							local maxmult  = PopExtUtil.Round( maxmetal * multiplier )
							local setvalue = ( metal + maxmult > maxmetal ) ? maxmetal : metal + maxmult

							SetPropIntArray( player, STRING_NETPROP_AMMO, setvalue, TF_AMMO_METAL )
							refill = true
						}

						for ( local i = 0; i < SLOT_MELEE; i++ ) {
							local wep     = PopExtUtil.GetItemInSlot( player, i )
							local ammo    = GetPropIntArray( player, STRING_NETPROP_AMMO, i+1 )
							local maxammo = PopExtUtil.GetWeaponMaxAmmo( player, wep )

							if ( ammo >= maxammo )
								continue
							else {
								local maxmult  = PopExtUtil.Round( maxammo * multiplier )
								local setvalue = ( ammo + maxmult > maxammo ) ? maxammo : ammo + maxmult

								SetPropIntArray( player, STRING_NETPROP_AMMO, setvalue, i+1 )
								refill = true
							}
						}

					}
					else if ( startswith( classname, "item_healthkit_" ) ) {

						is_health = true

						local hp    = player.GetHealth()
						local maxhp = player.GetMaxHealth()
						if ( hp >= maxhp ) continue

						refill = true

						local maxmult  = PopExtUtil.Round( maxhp * multiplier )
						local setvalue = ( hp + maxmult > maxhp ) ? maxhp : hp + maxmult
						player.ExtinguishPlayerBurning()

						SendGlobalGameEvent( "player_healed", {
							patient = PopExtUtil.PlayerTable[ player ]
							healer  = 0
							amount  = setvalue - hp
						})
						SendGlobalGameEvent( "player_healonhit", {
							entindex         = player.entindex()
							weapon_def_index = 65535
							amount           = setvalue - hp
						})

						player.SetHealth( setvalue )
					}

					if ( refill ) {

						if ( is_health )
							EmitSoundOnClient( "HealthKit.Touch", player )
						else
							EmitSoundOnClient( "AmmoPack.Touch", player )

						ent.AddEFlags( EFL_USER )
						EntFireByHandle( ent, "Disable", "", -1, null, null )

						EntFireByHandle( ent, "Enable", "", 10, null, null )
						PopExtUtil.ScriptEntFireSafe( ent, "self.RemoveEFlags( EFL_USER )", 10 )
					}
				}
			}

			// Drain player ammo on weapon usage
			function ReverseMVMDrainAmmoThink() {

				if ( value & 4 ) return
				local buttons = GetPropInt( player, "m_nButtons" )

				local wep = player.GetActiveWeapon()
				if ( wep == null || wep.IsMeleeWeapon() ) return

				local scope = PopExtUtil.GetEntScope( wep )
				if ( !( "nextattack" in scope ) ) {
					scope.nextattack <- -1
					scope.lastattack <- -1
				}


				local classname = wep.GetClassname()
				local itemid    = PopExtUtil.GetItemIndex( wep )
				local sequence  = wep.GetSequence()

				// These weapons have clips but either function fine or don't need to be handled
				if ( classname == "tf_weapon_particle_cannon"  || classname == "tf_weapon_raygun"     ||
					classname == "tf_weapon_flaregun_revenge" || classname == "tf_weapon_drg_pomson" ||
					classname == "tf_weapon_medigun" ) return

				local clip = wep.Clip1()

				if ( clip > -1 ) {
					if ( !( "lastclip" in scope ) )
						scope.lastclip <- clip

					// We reloaded
					if ( clip > scope.lastclip ) {
						local difference = clip - scope.lastclip
						if ( player.GetPlayerClass() == TF_CLASS_SPY && classname == "tf_weapon_revolver" ) {
							local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, SLOT_SECONDARY + 1 )
							SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - difference, SLOT_SECONDARY + 1 )
						}
						else {
							local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )
							SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - difference, wep.GetSlot() + 1 )
						}
					}

					scope.lastclip <- clip
				}
				else {
					if ( classname == "tf_weapon_rocketlauncher_fireball" ) {
						local recharge = GetPropFloat( player, "m_Shared.m_flItemChargeMeter" )
						if ( recharge == 0 ) {
							local cost = ( sequence == 13 ) ? 2 : 1
							local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )

							if ( maxammo - cost > -1 )
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - cost, wep.GetSlot() + 1 )
						}
					}
					else if ( classname == "tf_weapon_flamethrower" ) {
						if ( sequence == 12 ) return // Weapon deploy
						if ( Time() < scope.nextattack ) return

						local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )

						// The airblast sequence lasts 0.25s too long so we check against it here
						if ( buttons & IN_ATTACK && sequence != 13 ) {
							if ( maxammo - 1 > -1 ) {
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - 1, wep.GetSlot() + 1 )
								scope.nextattack <- Time() + 0.105
							}
						}
						else if ( buttons & IN_ATTACK2 ) {
							local cost = 20
							if ( itemid == ID_BACKBURNER || itemid == ID_FESTIVE_BACKBURNER_2014 ) // Backburner
								cost = 50
							else if ( itemid == ID_DEGREASER ) // Degreaser
								cost = 25

							if ( maxammo - cost > -1 ) {
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - cost, wep.GetSlot() + 1 )
								scope.nextattack <- Time() + 0.75
							}
						}
					}
					else if ( classname == "tf_weapon_flaregun" ) {
						local nextattack = GetPropFloat( wep, "m_flNextPrimaryAttack" )
						if ( Time() < nextattack ) return

						local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )
						if ( buttons & IN_ATTACK ) {
							if ( maxammo - 1 > -1 )
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - 1, wep.GetSlot() + 1 )
						}
					}
					else if ( classname == "tf_weapon_minigun" ) {
						local nextattack = GetPropFloat( wep, "m_flNextPrimaryAttack" )
						if ( Time() < nextattack ) return

						local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )
						if ( sequence == 21 ) {
							if ( maxammo - 1 > -1 )
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - 1, wep.GetSlot() + 1 )
						}
						else if ( sequence == 25 ) {
							if ( Time() < scope.nextattack ) return
							if ( itemid != ID_HUO_LONG_HEATMAKER && itemid != ID_GENUINE_HUO_LONG_HEATMAKER ) return

							if ( maxammo - 1 > -1 ) {
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - 1, wep.GetSlot() + 1 )
								scope.nextattack <- Time() + 0.25
							}
						}
					}
					else if ( classname == "tf_weapon_mechanical_arm" ) {
						// Reset hack
						SetPropIntArray( player, STRING_NETPROP_AMMO, 0, TF_AMMO_GRENADES1 )
						SetPropInt( wep, "m_iPrimaryAmmoType", TF_AMMO_METAL )

						local nextattack1 = GetPropFloat( wep, "m_flNextPrimaryAttack" )
						local nextattack2 = GetPropFloat( wep, "m_flNextSecondaryAttack" )

						local maxmetal = GetPropIntArray( player, STRING_NETPROP_AMMO, TF_AMMO_METAL )

						if ( buttons & IN_ATTACK ) {
							if ( Time() < nextattack1 ) return
							if ( maxmetal - 5 > -1 ) {
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxmetal - 5, TF_AMMO_METAL )
								// This prevents an exploit where you M1 and M2 in rapid succession to evade the 65 orb cost
								SetPropFloat( wep, "m_flNextSecondaryAttack", Time() + 0.25 )
							}
						}
						else if ( buttons & IN_ATTACK2 ) {
							if ( Time() < nextattack2 ) return

							if ( maxmetal - 65 > -1 ) {
								// Hack to get around the game blocking SecondaryAttack below 65 metal
								SetPropIntArray( player, STRING_NETPROP_AMMO, INT_MAX, TF_AMMO_GRENADES1 )
								SetPropInt( wep, "m_iPrimaryAmmoType", TF_AMMO_GRENADES1 )

								SetPropIntArray( player, STRING_NETPROP_AMMO, maxmetal - 65, TF_AMMO_METAL )
							}
						}
					}
					else if ( itemid == ID_WIDOWMAKER ) { // Widowmaker
						local nextattack = GetPropFloat( wep, "m_flNextPrimaryAttack" )
						if ( Time() < nextattack ) return

						local maxmetal = GetPropIntArray( player, STRING_NETPROP_AMMO, TF_AMMO_METAL )

						if ( buttons & IN_ATTACK ) {
							if ( maxmetal - 30 > -1 )
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxmetal - 30, TF_AMMO_METAL )
						}
					}
					else if ( classname == "tf_weapon_sniperrifle" || itemid == ID_BAZAAR_BARGAIN || itemid == ID_CLASSIC ) {
						local lastfire = GetPropFloat( wep, "m_flLastFireTime" )
						if ( scope.lastattack == lastfire ) return

						scope.lastattack <- lastfire
						local maxammo = GetPropIntArray( player, STRING_NETPROP_AMMO, wep.GetSlot() + 1 )
						if ( scope.lastattack > 0 && scope.lastattack < Time() ) {
							if ( maxammo - 1 > -1 )
								SetPropIntArray( player, STRING_NETPROP_AMMO, maxammo - 1, wep.GetSlot() + 1 )
						}
					}
				}
			}

			PopExtUtil.AddThink( player, ReverseMVMLaserThink )
			PopExtUtil.AddThink( player, ReverseMVMCurrencyThink )
			PopExtUtil.AddThink( player, ReverseMVMPackThink )
			PopExtUtil.AddThink( player, ReverseMVMDrainAmmoThink )

			if ( player.GetPlayerClass() == TF_CLASS_ENGINEER ) {

				// Drain metal on built objects
				POP_EVENT_HOOK( "player_builtobject", format( "DrainMetal_%d", PopExtUtil.PlayerTable[ player ] ), function( params ) {

					if ( value & 4 ) return

					local player = GetPlayerFromUserID( params.userid )
					local scope = player.GetScriptScope()
					local curmetal = GetPropIntArray( player, STRING_NETPROP_AMMO, TF_AMMO_METAL )
					local buildings = "buildings" in scope ? scope.buildings : [-1, array( 2 ), -1]

					// don't drain metal if this buildings entindex exists in the players scope
					if ( scope.buildings.find( params.index ) != null || scope.buildings[1].find( params.index ) != null ) return

					// add entindexes to player scope
					if ( params.object == OBJ_TELEPORTER )
						if ( GetPropInt( EntIndexToHScript( params.index ), "m_iTeleportType" ) == TTYPE_ENTRANCE )
							buildings[1][0] = params.index
						else
							buildings[1][1] = params.index
					else
						scope.buildings[params.object] = params.index

					switch( params.object ) {

						case OBJ_DISPENSER:
							SetPropIntArray( player, STRING_NETPROP_AMMO, curmetal - 100, TF_AMMO_METAL )
						break

						case OBJ_TELEPORTER:
							if ( PopExtUtil.HasItemInLoadout( player, ID_EUREKA_EFFECT ) )
								SetPropIntArray( player, STRING_NETPROP_AMMO, curmetal - 25, TF_AMMO_METAL )
							else
								SetPropIntArray( player, STRING_NETPROP_AMMO, curmetal - 50, TF_AMMO_METAL )
						break

						case OBJ_SENTRYGUN:
							if ( PopExtUtil.HasItemInLoadout( player, ID_GUNSLINGER ) )
								SetPropIntArray( player, STRING_NETPROP_AMMO, curmetal - 100, TF_AMMO_METAL )
							else
								SetPropIntArray( player, STRING_NETPROP_AMMO, curmetal - 130, TF_AMMO_METAL )
						break
					}
					if ( GetPropIntArray( player, STRING_NETPROP_AMMO, TF_AMMO_METAL ) < 0 )
						PopExtUtil.ScriptEntFireSafe( player, "SetPropIntArray( self, STRING_NETPROP_AMMO, 0, TF_AMMO_METAL )", -1 )

				}, EVENT_WRAPPER_MISSIONATTR )

			}

			//bitflags
			//cannot pick up intel
			if ( value & 2 && !player.IsBotOfType( TF_BOT_TYPE ) )
				player.AddCustomAttribute( "cannot pick up intelligence", 1, -1 )

			//infinite cloak
			if ( value & 8 && player.GetPlayerClass() == TF_CLASS_SPY )
				//setting it to -FLT_MAX makes it display as +inf%
				player.AddCustomAttribute( "cloak consume rate decreased", -FLT_MAX, -1 )

			//spawnroom behavior.  16 = spawn protection 32 = can't attack
			if ( value & 16 || value & 32 ) {

				function InRespawnThink() {

					if ( !PopExtUtil.IsPointInTrigger( player.EyePosition() ) ) return

					if ( value & 16 && !player.InCond( TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED ) )
						player.AddCondEx( TF_COND_INVULNERABLE_HIDE_UNLESS_DAMAGED, 2.0, null )

					if ( value & 32 )
						player.AddCustomAttribute( "no_attack", 1, 0.033 )
				}
				PopExtUtil.AddThink( player, InRespawnThink )
			}

			// disable footsteps
			if ( value & 64 ) {
				// player.AddCond( TF_COND_DISGUISED )
				// PopExtUtil.AddThink( player, function RemoveFootsteps() {
				// 	if ( !player.IsMiniBoss() ) player.SetIsMiniBoss( true )
				// })

				//stop explosion sound
				POP_EVENT_HOOK( "player_death", "RemoveFootsteps", function( params ) {
					foreach ( player in PopExtUtil.HumanArray )
						StopSoundOn( "MVM.GiantCommonExplodes", player )
				}, EVENT_WRAPPER_MISSIONATTR )
			}
			//disable bomb deploy
			if ( !( value & 128 ) ) {

				for ( local roundwin; roundwin = FindByClassname( roundwin, "game_round_win" ); )
					if ( roundwin.GetTeam() == TF_TEAM_PVE_INVADERS )
						EntFireByHandle( roundwin, "Kill", "", -1, null, null )

				for ( local capturezone; capturezone = FindByClassname( capturezone, "func_capturezone" ); ) {

					SetPropBool( capturezone, STRING_NETPROP_PURGESTRINGS, true )

					AddOutput( capturezone, "OnStartTouch", "!activator", "RunScriptCode", "MissionAttributes.DeployBombStart( self )", -1, -1 )
					AddOutput( capturezone, "OnEndTouch", "!activator", "RunScriptCode", "MissionAttributes.DeployBombStop( self )", -1, -1 )
				}
			}
		}, EVENT_WRAPPER_MISSIONATTR )

		POP_EVENT_HOOK( "player_team", "BlockSpectator", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player || !player.IsValid() || player.IsBotOfType( TF_BOT_TYPE ) ) 
				return

			local cls = player.GetPlayerClass()

			if ( params.team == TEAM_SPECTATOR ) {

				PopExtUtil.ScriptEntFireSafe( player, format( @"

					PopExtUtil.ChangePlayerTeamMvM( self, TF_TEAM_PVE_DEFENDERS, true )
					PopExtUtil.ForceChangeClass( self, %d )
					self.ForceRespawn()

				", cls ), 0.1, null, null, true )
			}

			if ( !("ReverseMVM" in MissionAttributes.CurAttrsPre) && !("ReverseMVM" in MissionAttributes.CurAttrs) ) {

				foreach ( player in PopExtUtil.HumanArray ) {

					PopExtUtil.ScriptEntFireSafe( player, format( @"

						PopExtUtil.ChangePlayerTeamMvM( self, TF_TEAM_PVE_DEFENDERS, true )
						PopExtUtil.ForceChangeClass( self, %d )
						self.ForceRespawn()

					", cls ), 0.1, null, null, true )
				}

				POP_EVENT_HOOK( "player_team", "BlockSpectator", null, EVENT_WRAPPER_MISSIONATTR )
			}
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function HumansMustJoinTeam( value ) {
		PopExtUtil.SetConvar( "mp_humans_must_join_team", value )
	}

	// =========================================================
	function ClassLimits( value ) {

		if ( typeof value != "table" ) {
			PopExtMain.Error.RaiseTypeError( "ClassLimits", "table" )
			return false
		}

		local no_sound = ["", "Scout.No3", "Sniper.No4", "Soldier.No1", "Demoman.No3", "Medic.No3", "Heavy.No2", "Pyro.No1", "Spy.No2", "Engineer.No3", "Scout.No3"]

		POP_EVENT_HOOK( "player_changeclass", "ClassLimits", function( params ) {

			local player = GetPlayerFromUserID( params.userid )
			if ( player.IsBotOfType( TF_BOT_TYPE ) ) return

			// Note that player_changeclass fires before a class swap actually occurs.
			// This means that player.GetPlayerClass() can be used to get the previous class,
			// and that PopExtUtil::PlayerClassCount() will return the current class array.

			local player_class = params["class"]
			local classcount = PopExtUtil.PlayerClassCount()[player_class] + 1

			if ( player_class in value && classcount > value[player_class] ) {

				PopExtUtil.ForceChangeClass( player, player.GetPlayerClass() )

				if ( value[player_class] == 0 )
					PopExtUtil.ShowMessage( format( "%s is not allowed on this mission.", PopExtUtil.ClassesCaps[player_class] ) )
				else
					PopExtUtil.ShowMessage( format( "%s is limited to %i for this mission.", PopExtUtil.ClassesCaps[player_class], value[player_class] ) )

				EmitSoundOn( no_sound[player_class], player )
			}
		}, EVENT_WRAPPER_MISSIONATTR )

		// Accept string identifiers for classes to limit.
		foreach ( k, v in value ) {

			if ( typeof k != "string" ) continue

			local class_string_idx = PopExtUtil.Classes.find( k.tolower() )
			if ( class_string_idx == null ) continue

			value[class_string_idx] <- v
			delete value[k]
		}

		MissionAttributes.ClassLimits <- value

		// Dump overflow players to free classes on wave init.
		PopExtUtil.ScriptEntFireSafe( "__popext_missionattr", @"

			local initcounts = PopExtUtil.PlayerClassCount()
			local classes = array( TF_CLASS_COUNT_ALL, 0 )

			foreach ( player in PopExtUtil.HumanArray ) {

				local pclass = player.GetPlayerClass()
				classes[pclass]++

				if ( pclass in ClassLimits && classes[pclass] > ClassLimits[pclass] ) {

					local nobreak = 1
					foreach ( i, targetcount in ClassLimits ) {

						if ( targetcount > initcounts[i] ) {

							initcounts[i]++
							PopExtUtil.ForceChangeClass( player, i )
							nobreak = 0
							break
						}
					}
					if ( nobreak ) {

						PopExtUtil.ForceChangeClass( player, RandomInt( 1, 9 ) )
						PopExtMain.Error.ParseError( `ClassLimits could not find a free class slot.` )
						break
					}
				}
			}", SINGLE_TICK )

	}

	// =========================================================

	function ShowHiddenAttributes( value ) {
		MissionAttributes.CurAttrs.ShowHiddenAttributes <- value
	}

	// =========================================================
	// Hides the "Respawn in: # seconds" text
	// 0 = Default behaviour ( countdown )
	// 1 = Hide completely
	// 2 = Show only 'Prepare to Respawn'
	// =========================================================

	function HideRespawnText( value ) {

		local rtime = 0.0
		switch ( value ) {
			case 1: break
			case 2: rtime = 1.0; break
			default:
				if ( "RespawnTextThink" in PopExtUtil.PlayerManager.GetScriptScope() ) {
					AddThinkToEnt( PopExtUtil.PlayerManager, null )
					delete PopExtUtil.PlayerManager.GetScriptScope().RespawnTextThink
				}
				return
		}

		function RespawnTextThink() {

			if ( !("PopExtUtil" in ROOT) )
				return SetPropString( self, "m_iszScriptThinkFunction", "" )

			foreach ( player in PopExtUtil.HumanArray ) {
				if ( player.IsAlive() == true ) continue
				SetPropFloatArray( PopExtUtil.PlayerManager, "m_flNextRespawnTime", rtime, player.entindex() )
			}
			return -1
		}
		PopExtUtil.GetEntScope( PopExtUtil.PlayerManager ).RespawnTextThink <- RespawnTextThink
		AddThinkToEnt( PopExtUtil.PlayerManager, "RespawnTextThink" )
	}

	// =========================================================================================================
	// Override or remove icons from the specified wave.
	// if no wave specified it will override the current wave.
	//
	// WARNING: Bots must have an associated popext_iconoverride tag for decrementing/incrementing on death.
	//
	// Example:
	//
	// IconOverride = {

	// 	 heavy_mittens = { //set count to 2 for wave 2
	// 	 	wave = 2
	// 	 	flags = 0 // see constants.nut for flags
	// 	 	count = 2
	// 	 }

	// 	 scout = { //remove from current wave
	// 	 	count = 0, //remove
	// 	 }

	// 	pyro = { //replace with a new icon
	// 		replace = `scout_bat`
	// 		count = 20 //set count to 20 for current wave
	// 		flags = MVM_CLASS_FLAG_ALWAYSCRIT|MVM_CLASS_FLAG_MINIBOSS // see constants.nut for flags
	//		// index is required if you want to preserve the icon order on the wavebar
	// 		// icon index is going to be trial and error and is not consistent, try values until it works.
	//		// for example in the bigrock pop the pyro icon index is normally 0, but gets changed to 4 by IconOverride
	// 		// this will change if you update your wave with more bots
	//
	//		index = 4
	// 	}
	// }
	//
	// =========================================================================================================
	function IconOverride( value ) {

		if ( typeof value != "table" ) {
			PopExtMain.Error.RaiseTypeError( "IconOverride", "table" )
			return false
		}

		if ( !PopExtMain.IncludeModules( "wavebar" ) )
			return false

		local wave = PopExtUtil.CurrentWaveNum

		PopExtWavebar.SetWaveIconsFunction( function() {

			foreach ( icon, params in value ) {

				if ( typeof params != "table" || ( "wave" in params && params.wave != wave ) ) continue

				local replace 	   = "replace" in params ? params.replace : icon
				local count   	   = "count" in params ? params.count : null
				local flags   	   = "flags" in params ? params.flags : null
				local index   	   = "index" in params ? params.index : -1

				PopExtWavebar.SetWaveIconSlot( icon, replace, flags, count, index, false, flags != null && !( flags & MVM_CLASS_FLAG_SUPPORT_LIMITED || flags & MVM_CLASS_FLAG_SUPPORT ) )

				if ( "newflags" in params ) {
					PopExtWavebar.SetWaveIconFlags( replace, params.newflags )
				}
			}
		})
	}

	/**********************************************************
		* Disable the upgrade station                         	   *
		* 1 = disable the upgrade station and print a message 	   *
		* 2 = silently disable the upgrade station            	   *
		**********************************************************/
	function NoUpgrades( value ) {

		EntFire( "func_upgradestation", "Disable" )

		if ( value == 2 ) return

		for ( local upgradestation; upgradestation = FindByClassname( upgradestation, "func_upgradestation" ); ) {

			local trigger = CreateByClassname( "trigger_multiple" )
			trigger.KeyValueFromString( "model", GetPropString( upgradestation, "m_ModelName" ) )
			PopExtUtil.SetTargetname( trigger, "__popext_upgradestop" )
			trigger.KeyValueFromInt( "spawnflags", SF_TRIGGER_ALLOW_CLIENTS )
			AddOutput( trigger, "OnStartTouch", "!activator", "RunScriptCode", "ClientPrint( self, HUD_PRINTCENTER, `The upgrade station is disabled for this wave.` )", -1, 0 )
			trigger.SetAbsOrigin( upgradestation.GetOrigin() )
			DispatchSpawn( trigger )
		}
	}

	function BotSpectateTime( value ) {

		POP_EVENT_HOOK( "player_death", "BotSpectateTime", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( !player.IsBotOfType( TF_BOT_TYPE ) ) return

			PopExtUtil.ScriptEntFireSafe( player, "self.ForceChangeTeam( TEAM_SPECTATOR, true )", value.tofloat() )
		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function FastEntityNameLookup( value ) {

		PopExtUtil.GetAllEnts(false, function( ent ) {

			local entname = ent.GetName()

			if ( entname == "" ) return

			SetPropString( ent, STRING_NETPROP_NAME, entname.tolower() )
		})
	}

	function RemoveBotViewmodels( value ) {

		// TODO: investigate this more
		return

		POP_EVENT_HOOK( "post_inventory_application", "RemoveBotViewmodels", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if ( player.IsEFlagSet( EFL_CUSTOM_WEARABLE ) || !player.IsBotOfType( TF_BOT_TYPE ) )
				return

			local viewmodel = GetPropEntityArray( player, "m_hViewModel", 0 )

			if ( viewmodel && viewmodel.IsValid() )
				viewmodel.Kill()

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function UnusedGiantFootsteps( value ) {

		local validclasses = {
			[TF_CLASS_SCOUT] = null,
			[TF_CLASS_SOLDIER] = null,
			[TF_CLASS_PYRO] = null ,
			[TF_CLASS_DEMOMAN] = null ,
			[TF_CLASS_HEAVYWEAPONS] = null
		}

		POP_EVENT_HOOK( "post_inventory_application", "UnusedGiantFootsteps", function( params ) {

			local player = GetPlayerFromUserID( params.userid )

			if (
				player.IsEFlagSet( EFL_CUSTOM_WEARABLE )
				|| ( !player.IsBotOfType( TF_BOT_TYPE ) && !(value & 2) )
				|| !( player.GetPlayerClass() in validclasses )
			) return

			player.AddCustomAttribute( "override footstep sound set", 0, -1 )

			local cstring = PopExtUtil.Classes[player.GetPlayerClass()]

			local scope = player.GetScriptScope()

			scope.stepside <- GetPropInt( player, "m_Local.m_nStepside" )
			scope.stepcount <- 1

			for (local i = 1; i < 5; i++) {

				local footstepsound = format( "^mvm/giant_%s/giant_%s_step_0%d.wav", cstring, cstring, i )

				if ( player.GetPlayerClass() == TF_CLASS_DEMOMAN )
					footstepsound = format( "^mvm/giant_demoman/giant_demoman_step_0%d.wav", i )

				else if ( player.GetPlayerClass() == TF_CLASS_SOLDIER || player.GetPlayerClass() == TF_CLASS_HEAVYWEAPONS )
					footstepsound = format( "^mvm/giant_%s/giant_%s_step0%d.wav", cstring, cstring, i )

				PrecacheSound( footstepsound )
			}

			function UnusedGiantFootstepsThink() {

				if ( !player.IsMiniBoss() ) return

				if ( !"stepside" in scope )
					scope.stepside <- GetPropInt( player, "m_Local.m_nStepside" )

				if ( !("stepcount" in scope) )
					scope.stepcount <- 1

				if ( GetPropInt( player, "m_Local.m_nStepside" ) == scope.stepside ) return

				local footstepsound = format( "^mvm/giant_%s/giant_%s_step_0%d.wav", cstring, cstring, RandomInt( 1, 4 ) )

				if ( player.GetPlayerClass() == TF_CLASS_DEMOMAN )
					footstepsound = format( "^mvm/giant_demoman/giant_demoman_step_0%d.wav", RandomInt( 1, 4 ) )

				else if ( player.GetPlayerClass() == TF_CLASS_SOLDIER || player.GetPlayerClass() == TF_CLASS_HEAVYWEAPONS )
					footstepsound = format( "^mvm/giant_%s/giant_%s_step0%d.wav", cstring, cstring, RandomInt( 1, 4 ) )

				// play sound every other step, otherwise it's spammy
				if ( value & 4 || scope.stepcount % 2 == 0 )
					player.EmitSound( footstepsound )

				scope.stepcount++
				scope.stepside = ( GetPropInt( player, "m_Local.m_nStepside" ) )
			}
			PopExtUtil.AddThink( player, UnusedGiantFootstepsThink )

		}, EVENT_WRAPPER_MISSIONATTR )
	}

	function MissionUnloadOutput( value ) {

		if ( typeof value != "table" ) {

			PopExtMain.Error.RaiseValueError( "MissionUnloadOutput must be a table" )
			return
		}

		function ScriptUnloadTable::UnloadOutput( value ) {

			local target = value.target
			local action = value.action
			local param = "param" in value ? value.param : ""
			local delay = "delay" in value ? value.delay : 0
			local activator = "activator" in value ? value.activator : null
			local caller = "caller" in value ? value.caller : null
			DoEntFire( target, action, param, delay, activator, caller )
		}

	}

	/***************************************************************
		* rafmod kv's for compatibility                               *
		* blu human ... options must be done with ReverseMVM instead. *
		***************************************************************/
	function DisableUpgradeStation    	    ( value )  { NoUpgrades( value ) }
	function NoRomevisionCosmetics    	    ( value )  { NoRome( value ) }
	function MaxRedPlayers 		     	    ( value )  { MaxRedPlayers( value ) }
	function AllowMultipleSappers     	    ( value )  { MultiSapper( value ) }
	function RespecEnabled 		     	    ( value )  { NoRefunds( value ) }
	function RespecLimit 		     	    ( value )  { RefundLimit( value ) }
	function NoCreditsVelocity 	     	    ( value )  { NoCreditVelocity( value ) }
	function CustomUpgradesFile 	        ( value )  { UpgradeFile( value ) }
	function SentryBusterFriendlyFire 	    ( value )  { NoBusterFF( value ) }
	function SendBotsToSpectatorImmediately ( value )  { BotSpectateTime( -1 ) }
	function BotsRandomCrit 	     	    ( value )  { EnableRandomCrits( 6 ) }
	function FlagCarrierMovementPenalty     ( value )  { BombMovementPenalty( value ) }
	function BotTeleportUberDuration        ( value )  { TeleUberDuration( value ) }
	function AllowFlagCarrierToFight        ( value )  { FlagCarrierCanFight( value ) }
	function FlagEscortCountOffset          ( value )  { FlagEscortCount( value ) }
	function MinibossSentrySingleKill       ( value )  { GiantSentryKillCountOffset( 1 ) }
	function NoRedBotsRandomCrit            ( value )  { RedBotsNoRandomCrit( 0 ) }
	function DefaultMiniBossScale           ( value )  { GiantScale( value ) }
	function ConchHealthOnHit               ( value )  { ConchHealthOnHitRegen( value ) }
	function MarkedForDeathLifetime         ( value )  { MarkForDeathLifetime( value ) }
	function StealthDamageReduction         ( value )  { StealthDmgReduction( value ) }
	function SpellDropRateCommon            ( value )  { SpellRateCommon( value ) }
	function SpellDropRateGiant             ( value )  { SpellRateGiant( value ) }
	function GiantsDropRareSpells           ( value )  { RareSpellRateGiant( 1 ) }
	function NoCritPumpkin                  ( value )  { NoCrumpkins( value ) }
	function NoSkeletonSplit                ( value )  { NoSkeleSplit( value ) }
	function MaxActiveSkeletons             ( value )  { MaxSkeletons( value ) }
	function ZombiesNoWave666               ( value )  { this["666Wavebar"]( value ) }
	function HHHNonSolidToPlayers           ( value )  { HalloweenBossNotSolidToPlayers( value ) }
	function OverrideSounds                 ( value )  { SoundOverrides( value ) }
	function PlayerAddCond                  ( value )  { AddCond( value ) }
	function RemoveUnusedOffhandViewmodel   ( value )  { RemoveBotViewmodels( value ) }
	function SniperAllowHeadshots           ( value )  { BotHeadshots( value ) }

	function SpellsEnabled( value ) {
		PopExtMain.Error.GenericWarning( "Obsolete keyvalue 'SpellsEnabled', ignoring" )
	}

	function BotsDropSpells( value ) {
		PopExtMain.Error.GenericWarning( "Obsolete keyvalue 'BotsDropSpells', ignoring" )
	}

	function NoMvMDeathTune( value ) { SoundOverrides( { "MVM.PlayerDied" : null } ) }

}

// Mission Attribute Functions
// =========================================================
// Function is called in popfile by mission maker to modify mission attributes.

MissionAttributes.SetConvar    <- PopExtUtil.SetConvar.bindenv( PopExtUtil ) // legacy compatibility, people should use PopExtUtil.SetConvar instead
MissionAttributes.ResetConvars <- PopExtUtil.ResetConvars.bindenv( PopExtUtil ) // legacy compatibility, people should use PopExtUtil.ResetConvars instead

function MissionAttributes::MissionAttr( ... ) {

	local args = vargv
	local attr
	local value

	if ( !args.len() ) return

	else if ( args.len() == 1 ) {
		attr  = args[0]
		value = null
	}
	else {
		attr  = args[0]
		value = args[1]
	}

	if ( attr in Attrs ) {

		Attrs[attr] <- Attrs[attr].bindenv( MissionAttributes )

		CurAttrsPre[attr] <- value
		local success = Attrs[attr]( value )
		if ( success == false ) {
			PopExtMain.Error.ParseError( "Failed to add mission attribute " + attr )
			return
		}
	
		CurAttrs[attr] <- value
		delete CurAttrsPre[attr]
		PopExtMain.Error.DebugLog( "Added mission attribute " + attr + " : " + CurAttrs[attr] )
		return
	}

	PopExtMain.Error.ParseError( "Could not find mission attribute " + attr.tostring() )
}

// This only supports key = value pairs, if you want var args call MissionAttr directly
function MissionAttrs( attrs = {} ) {
	foreach ( attr, value in attrs )
		MissionAttributes.MissionAttr( attr, value )
}

//super truncated version incase the pop character limit becomes an issue.
function MAtrs( attrs = {} ) {
	foreach ( attr, value in attrs )
		MissionAttributes.MissionAttr( attr, value )
}

// Allow calling MissionAttr() directly with MissionAttr().
function MissionAttr( ... ) {
	MissionAttr.acall( vargv.insert( 0, MissionAttributes ) )
}

//super truncated version incase the pop character limit becomes an issue.
function MAtr( ... ) {
	MissionAttr.acall( vargv.insert( 0, MissionAttributes ) )
}

POP_EVENT_HOOK( "teamplay_round_start", "MissionAttributesCleanup", function( params ) {

	foreach ( bot in PopExtUtil.BotArray )
		if ( bot.IsValid() && bot.GetTeam() == TF_TEAM_PVE_DEFENDERS )
			bot.ForceChangeTeam( TEAM_SPECTATOR, true )

}, EVENT_WRAPPER_MISSIONATTR )

POP_EVENT_HOOK( "teamplay_broadcast_audio", "SoundOverrides", function( params ) {

	if ( !MissionAttributes.SoundsToReplace.len() ) return

	if ( params.sound in MissionAttributes.SoundsToReplace ) {

		local split_sound = split( params.sound, "." )
		local sound_last = split_sound[split_sound.len() - 1]

		foreach ( player in PopExtUtil.HumanArray )
			sound_last == "wav" || sound_last == "mp3" ? player.StopSound( params.sound ) : StopSoundOn( params.sound, player )

		if ( MissionAttributes.SoundsToReplace[params.sound] == null ) return

		EmitSoundEx( {sound_name = MissionAttributes.SoundsToReplace[params.sound]} )
	}
}, EVENT_WRAPPER_MISSIONATTR )

POP_EVENT_HOOK( "mvm_mission_complete", "MissionAttributeFireUnload", function( params ) {

	foreach ( func in ScriptUnloadTable ) func()
}, EVENT_WRAPPER_MISSIONATTR )
