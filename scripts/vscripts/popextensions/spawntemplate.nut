// By washy

POPEXT_CREATE_SCOPE( "__popext_spawntemplate", "SpawnTemplates" )

// mission makers can override the "PointTemplates" global table name to something else 
// by adding this line BEFORE "IncludeScript(`popextensions_main`, getroottable())"

// Example:
/*******************************************************************
 *                                                                 *
 * InitWaveOutput {                                                *
 *     Target BigNet                                               *
 *     Action RunScriptCode                                        *
 *     Param "                                                     *
 *         ::SpawnTemplates <- { ROOT_TABLE_NAME = "MyTemplates" } *
 *     "                                                           *
 * }                                                               *
 *******************************************************************/
// ::SpawnTemplates <- { ROOT_TABLE_NAME = "PointTemplates" } 

local ROOT_TABLE_NAME = "SpawnTemplates" in ROOT && "ROOT_TABLE_NAME" in SpawnTemplates ? SpawnTemplates.ROOT_TABLE_NAME : "PointTemplates"

SpawnTemplates.wave_point_templates 		 <- []
SpawnTemplates.global_template_spawn_count   <- 0
SpawnTemplates.wave_schedule_point_templates <- []

// empty table to avoid does not exist errors
ROOT[ROOT_TABLE_NAME] <- {}

function SpawnTemplates::_OnDestroy() {

	foreach( key in [ ROOT_TABLE_NAME, "SpawnTemplate" ] )
		if ( key in ROOT )
			delete ROOT[ key ]
}

function SpawnTemplates::TemplatePostSpawn( ... ) {

	// can only set bounding box size for brush entities after they spawn
	foreach( entity in Entities ) {


		local responsecontext = GetPropString( entity, "m_iszResponseContext" )
		buf = split( responsecontext, responsecontext.find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() )

		if ( 5 in buf && !(6 in buf) ) {

			entity.SetSize( Vector( buf[0], buf[1], buf[2] ), Vector( buf[3], buf[4], buf[5] ) )
			entity.SetSolid( 2 )
		}

		SetPropBool( entity, STRING_NETPROP_PURGESTRINGS, true )

		SpawnedEntities[entity] <- [origin, angles]

		if ( origin != "" || angles != "" ) {

			foreach( k, v in SpawnedEntities ) {

				if ( origin != "" ) {

					if ( typeof origin == "Vector" )
						k.SetAbsOrigin( origin )
					else {

						buf = split( v[0], v[0].find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() )
						k.SetAbsOrigin( Vector( buf[0], buf[1], buf[2] ) )
					}
				}
				if ( angles != "" ) {

					if ( typeof angles == "QAngle" || typeof angles == "Vector" )
						k.SetAbsAngles( angles + QAngle() )
					else {
						printl( v[1] )
						buf = split( v[1], v[1].find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() )
						k.SetAbsAngles( QAngle( buf[0], buf[1], buf[2] ) )
					}
				}
			}
		}

		SpawnTemplates.wave_point_templates.append( entity )

		if ( parent && parent.IsValid() ) {

			if ( typeof parent == "string" ) 
				parent = FindByName( null, parent )

			if ( parentabsorigin ) {

				entity.AcceptInput( "SetParent", "!activator", parent, parent )
				if ( attachment ) entity.AcceptInput( "SetParentAttachment", attachment, null, null )

			}
			else
				PopExtUtil.SetParentLocalOrigin( entity, parent, attachment )

			// don't make trigger brushes non-solid.
			if ( nonsolidchildren && !HasProp( entity, "m_iFilterName" ) )
				entity.SetSolid( 0 )

			//entities parented to players do not kill itself when the player dies as the player entity is not considered killed
			if ( parent.IsPlayer() ) {

				parent.AddEFlags( EFL_SPAWNTEMPLATE )

				if ( !keepalive ) {

					local parentscope = PopExtUtil.GetEntScope( parent )

					parentscope.PRESERVED.kill_on_death.append( entity )
				}
			}
		}
	}
	if ( parent && parent.IsValid() ) {

		function FireOnParentKilledOutputs() {

			foreach( output in OnParentKilledOutputArray ) {

				local target 	= output.target
				local action 	= output.action
				local param  	= ( "param" in output ) ? output.param.tostring() : ""
				local delay  	= ( "delay" in output ) ? output.delay.tofloat() : -1
				local activator = ( "activator" in output ) ? ( typeof output.activator == "string" ? FindByName( null, output.activator ) : output.activator ) : null
				local caller 	= ( "caller" in output ) 	? ( typeof output["caller"] == "string" ? FindByName( null, output["caller"] ) : output["caller"] ) : null

				local entfirefunc = typeof target == "string" ? DoEntFire : EntFireByHandle
				entfirefunc( target, action, param, delay, activator, caller )
			}
		}

		if ( parent.IsPlayer() ) {

			if ( OnParentKilledOutputArray.len() ) {

				local parentscope = PopExtUtil.GetEntScope( parent )

				if ( !( "spawntemplate_onparentkilled" in parentscope ) )
					parentscope.spawntemplate_onparentkilled <- []

				parentscope.spawntemplate_onparentkilled.append( FireOnParentKilledOutputs.bindenv( parentscope ) )
			}
		}
		//use own think instead of parent's think
		function CheckIfKilled() {

			if ( parent && parent.IsValid() ) {
				lastorigin <- parent.GetOrigin()
				lastangles <- parent.GetAbsAngles()
			}
			else {
				if ( keepalive )
					//spawn template again after being killed
					SpawnTemplate( pointtemplate, null, lastorigin + origin, lastangles + angles )

				//fire OnParentKilledOutputs
				//does not work on its own internal entities if NoFixup is true since the entities are always killed
				FireOnParentKilledOutputs()

				SetPropString( self, "m_iszScriptThinkFunction", "" )
				self.RemoveEFlags( EFL_SPAWNTEMPLATE )
			}

			if ( removeifkilled != "" ) {

				if ( !FindByName( null, removeifkilled ) ) {

					foreach( entity, _ in SpawnedEntities )
						if ( entity && entity.IsValid() )
							entity.Kill()

					SetPropString( self, "m_iszScriptThinkFunction", "" )
				}
			}
			return -1
		}
		PopExtUtil.AddThink( self, CheckIfKilled )
	}

	//fire OnSpawnOutputs
	foreach( output in OnSpawnOutputArray ) {

		local target 	= output.target
		local action 	= output.action
		local param  	= ( "param" in output ) ? output.param.tostring() : ""
		local delay  	= ( "delay" in output ) ? output.delay.tofloat() : -1
		local activator = ( "activator" in output ) ? ( typeof output.activator == "string" ? FindByName( null, output.activator ) : output.activator ) : null
		local caller 	= ( "caller" in output ) 	? ( typeof output["caller"] == "string" ? FindByName( null, output["caller"] ) : output["caller"] ) : null

		local entfirefunc = typeof target == "string" ? DoEntFire : EntFireByHandle
		entfirefunc( target, action, param, delay, activator, caller )
	}
}

//spawns an entity when called, can be called on StartWaveOutput and InitWaveOutput, automatically kills itself after wave completion
function SpawnTemplates::SpawnTemplate( pointtemplate, parent = null, origin = "", angles = "", forceparent = false, attachment = null, parentabsorigin = true, nonsolidchildren = false ) {

	// forceparent is set, delete the EFlag to parent another template
	if ( forceparent && parent.IsEFlagSet( EFL_SPAWNTEMPLATE ) )
		parent.RemoveEFlags( EFL_SPAWNTEMPLATE )

	// we already have a template
	if ( parent && parent.IsEFlagSet( EFL_SPAWNTEMPLATE ) )
		return

	// credit to ficool2
	global_template_spawn_count++
	local template = CreateByClassname( "point_script_template" )
	template.DispatchSpawn()
	local scope = template.GetScriptScope()

	local nofixup 		 = false
	local keepalive 	 = false
	local removeifkilled = ""

	scope.buf 						<- [] //reuseable buffer for origin/angles splitting instead of repeatedly creating and dumping new arrays
	scope.parent 					<- parent
	scope.origin 					<- origin
	scope.angles 					<- angles
	scope.parentabsorigin 			<- parentabsorigin
	scope.nonsolidchildren 			<- nonsolidchildren
	scope.attachment 				<- attachment
	scope.Entities 					<- []
	scope.SpawnedEntities 			<- {}
	scope.OnSpawnOutputArray 		<- []
	scope.OnAllKilledOutputArray 	<- []
	scope.EntityFixedUpTargetName 	<- []
	scope.OnParentKilledOutputArray <- []

	// unnamed ents/ents that share a targetname need an array
	scope.__EntityMakerResult <- {
		entities = scope.Entities
	}.setdelegate({
		function _newslot( _, value ) {
			entities.append( value )
		}
	})

	scope.PostSpawn <- TemplatePostSpawn.bindenv( scope )

	//make a copy of the pointtemplate
	local pointtemplatecopy = PopExtUtil.CopyTable( ROOT[ROOT_TABLE_NAME][pointtemplate] )

	//establish "flags", lowercase all keys
	foreach( index, entity in pointtemplatecopy ) {

		if ( typeof entity == "table" ) {

			foreach( k, v in entity )
			if ( typeof k == "string" ) {

				delete entity[k]
				entity[k.tolower()] <- v
			}
		}

		if ( typeof index != "string" ) continue

		index = index.tolower()

		if ( entity )
			if ( index == "nofixup" )
				nofixup = true
			else if ( index == "keepalive" )
				keepalive = true

		else if ( index == "removeifkilled" )
			scope.removeifkilled <- entity
	}

	// perform name fixup
	if ( !nofixup ) {

		// first, get list of targetnames in the point template for name fixup
		foreach( index, entity in pointtemplatecopy ) {

			if ( typeof entity != "table" ) continue

			foreach( classname, keyvalues in entity )
				foreach( key, value in keyvalues )
					if ( key == "targetname" && scope.EntityFixedUpTargetName.find( value ) == null )
						scope.EntityFixedUpTargetName.append( value )

		}

		//iterate through all entities and fixup every value containing a valid targetname
		//may have issues with targetnames that are substrings of other targetnames?
		//this should cover targetnames, parentnames, target, and output params
		foreach( index, entity in pointtemplatecopy ) {

			if ( typeof entity != "table" ) continue

			foreach( classname, keyvalues in entity ) {

				foreach( key, value in keyvalues ) {

					if ( typeof value != "string" ) continue

					foreach( targetname in scope.EntityFixedUpTargetName ) {
						
						local targetname_len = targetname.len()

						// ignore potential file paths, also ignores targetnames with "/"
						if ( value.find( targetname ) != null && value.find( "/" ) == null )
							keyvalues[key] <- value.slice( 0, targetname_len ) + global_template_spawn_count + value.slice( targetname_len )
					}
				}
			}
			if ( index == "removeifkilled" ) scope.removeifkilled <- entity + global_template_spawn_count
		}
	}

	//add templates to point_script_template
	foreach( index, entity in pointtemplatecopy ) {

		if ( typeof entity != "table" ) continue

		foreach( classname, keyvalues in entity ) {

			foreach( k, v in keyvalues ) {

				if ( typeof v == "string" ) {

					delete keyvalues[k]
					keyvalues[k.tolower()] <- v
				}
			}
			if ( classname == "onspawnoutput" )
				scope.OnSpawnOutputArray.append( keyvalues )

			else if ( classname == "onparentkilledoutput" )
				scope.OnParentKilledOutputArray.append( keyvalues )

			else if ( classname == "onallkilledoutput" )
				scope.OnAllKilledOutputArray.append( keyvalues )

			else {

				//adjust origin and angles
				if ( "origin" in keyvalues ) {

					if ( typeof keyvalues.origin == "string" ) {
						
						local buf = scope.buf
						buf = split( keyvalues.origin, keyvalues.origin.find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() )
						keyvalues.origin = Vector( buf[0], buf[1], buf[2] )
					}
				}
				else keyvalues.origin <- origin

				if ( "angles" in keyvalues ) {

					//if angles is a string, construct qangles to perform math on them if needed
					if ( typeof keyvalues.angles == "string" ) {

						local buf = scope.buf
						buf = split( keyvalues.angles, keyvalues.angles.find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() )
						keyvalues.angles = QAngle( buf[0], buf[1], buf[2] )
					}
				}
				else keyvalues.angles <- angles

				//needed for brush entities
				if ( "mins" in keyvalues || "maxs" in keyvalues ) {

					local mins = ( "mins" in keyvalues ) ? keyvalues.mins : Vector()
					local maxs = ( "maxs" in keyvalues ) ? keyvalues.maxs : Vector()

					if ( typeof mins == "Vector" ) mins =  mins.ToKVString()
					if ( typeof maxs == "Vector" ) maxs =  maxs.ToKVString()

					// guard against inverted mins and maxs values
					// rafmod PTs silently handle this, this normally crashes the server
					
					// sum up the mins/maxs values, if mins > maxs, swap them.
					local mins_sum = split( mins, mins.find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() ).reduce( @( a, b ) a + b )
					local maxs_sum = split( maxs, maxs.find( "," ) ? "," : " " ).apply( @( val ) val.tofloat() ).reduce( @( a, b ) a + b )

					if ( mins_sum > maxs_sum ) {
						PopExtMain.Error.RaiseValueError( "mins > maxs in point template (" + ("targetname" in keyvalues ? keyvalues.targetname : classname) + ")! Inverting..." )
						local temp = mins
						mins = maxs
						maxs = temp
					}

					//overwrite responsecontext even if someone fills it in for some reason
					keyvalues.responsecontext <- mins + " " + maxs
				}

				template.AddTemplate( classname, keyvalues )
			}
		}
	}
	// template.AcceptInput( "ForceSpawn", null, null, null )
	EntFireByHandle( template, "ForceSpawn", "", -1, null, null )
}

//altenative version of SpawnTemplate that will recreate itself only after wave resets ( after failure, after voting, after using tf_mvm_jump_to_wave ) to imitate spawning in WaveSchedule
//does not accept parent parameter, does not allow parenting entities
// function ROOT::SpawnTemplateWaveSchedule( pointtemplate, origin = null, angles = null ) {
	// SpawnTemplates.wave_schedule_point_templates.append( [PointTemplates[pointtemplate], origin, angles] )
// }

// alternative version that accepts a table of arguments
function SpawnTemplates::DoSpawnTemplate( args = { pointtemplate = null, parent = null, origin = "", angles = "", forceparent = false, parentabsorigin = false, nonsolidchildren = false } ) {
	SpawnTemplate( args.pointtemplate, args.parent, args.origin, args.angles, args.forceparent, args.parentabsorigin, args.nonsolidchildren )
}

::SpawnTemplate <- SpawnTemplates.SpawnTemplate.bindenv( SpawnTemplates )


POP_EVENT_HOOK("mvm_wave_complete", "SpawnTemplateWaveComplete", function( params ) {

	foreach( entity in SpawnTemplates.wave_point_templates )
		if ( entity.IsValid() )
			entity.Kill()

	SpawnTemplates.wave_point_templates.clear()
})

//despite the name, this event also calls on wave reset from voting, and on jumping to wave, and when loading mission
POP_EVENT_HOOK("mvm_wave_failed", "SpawnTemplateWaveFailed", function( params ) {

	foreach( entity in SpawnTemplates.wave_point_templates )
		if ( entity.IsValid() )
			entity.Kill()

	foreach( param in SpawnTemplates.wave_schedule_point_templates )
		SpawnTemplate( param[0], null, param[1], param[2] )
})

POP_EVENT_HOOK("player_death", "SpawnTemplatePlayerDeath", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = PopExtUtil.GetEntScope( player )

	if ( "spawntemplate_onparentkilled" in scope ) {

		foreach ( func in scope.spawntemplate_onparentkilled )
			func()

		scope.spawntemplate_onparentkilled.clear()
	}

	player.RemoveEFlags( EFL_SPAWNTEMPLATE )
})