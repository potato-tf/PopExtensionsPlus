// By washy
PopExt.waveSchedulePointTemplates <- []
PopExt.wavePointTemplates         <- []
PopExt.globalTemplateSpawnCount   <- 0

//spawns an entity when called, can be called on StartWaveOutput and InitWaveOutput, automatically kills itself after wave completion
::SpawnTemplate <- function( pointtemplate, parent = null, origin = "", angles = "", forceparent = false, attachment = null, parentabsorigin = true, nonsolidchildren = false ) {

	if ( forceparent && parent.IsEFlagSet( EFL_SPAWNTEMPLATE ) )
		parent.RemoveEFlags( EFL_SPAWNTEMPLATE ) //forceparent is set, delete the EFlag to parent another template

	if ( parent != null && parent.IsEFlagSet( EFL_SPAWNTEMPLATE ) )
		return //we already have a template

	// credit to ficool2
	PopExt.globalTemplateSpawnCount <- PopExt.globalTemplateSpawnCount + 1
	local template = CreateByClassname( "point_script_template" )
	DispatchSpawn( template )
	local scope = template.GetScriptScope()

	local nofixup = false
	local keepalive = false
	local removeifkilled = ""

	scope.parent <- parent
	scope.Entities <- []
	scope.EntityFixedUpTargetName <- []
	scope.OnSpawnOutputArray <- []
	scope.OnParentKilledOutputArray <- []
	scope.OnAllKilledOutputArray <- []
	scope.SpawnedEntities <- {}

	scope.__EntityMakerResult <- {
		entities = scope.Entities
	}.setdelegate( {
		_newslot = function( _, value ) {
			entities.append( value )
		}
	})

	scope.PostSpawn <- function( named_entities ) {

		//can only set bounding box size for brush entities after they spawn
		foreach( entity in Entities ) {

			local responsecontext = GetPropString( entity, "m_iszResponseContext" )
			local buf = responsecontext.find( "," ) ? split( responsecontext, "," ) : split( responsecontext, " " )

			if ( buf.len() == 6 ) {

				buf.apply( function( val ) { return val.tofloat() } )
				entity.SetSize( Vector( buf[0], buf[1], buf[2] ), Vector( buf[3], buf[4], buf[5] ) )
				entity.SetSolid( 2 )
			}

			SetPropBool( entity, STRING_NETPROP_PURGESTRINGS, true )

			scope.SpawnedEntities[entity] <- [origin, angles]

			if ( origin != "" || angles != "" ) {

				foreach( k, v in SpawnedEntities ) {

					if ( origin != "" ) {

						if ( typeof origin == "Vector" )
							k.SetAbsOrigin( origin )
						else {

							local orgbuf = v[0].find( "," ) ? split( v[0], "," ) : split( v[0], " " )
							orgbuf.apply( @( val ) val.tofloat() )
							k.SetAbsOrigin( Vector( orgbuf[0], orgbuf[1], orgbuf[2] ) )
						}
					}
					if ( angles != "" ) {

						if ( typeof angles == "QAngle" )
							k.SetAbsAngles( angles )
						else {

							local angbuf = v[1].find( "," ) ? split( v[1], "," ) : split( v[1], " " )
							angbuf.apply( @( val ) val.tofloat() )
							k.SetAbsAngles( QAngle( angbuf[0], angbuf[1], angbuf[2] ) )
						}
					}
				}
			}

			PopExt.wavePointTemplates.append( entity )

			if ( parent != null ) {

				if ( typeof parent == "string" ) parent = FindByName( null, parent )
				if ( parentabsorigin ) {

					entity.AcceptInput( "SetParent", "!activator", parent, parent )
					if ( attachment ) entity.AcceptInput( "SetParentAttachment", attachment, null, null )
				} else {
					PopExtUtil.SetParentLocalOrigin( entity, parent, attachment )
				}

				if ( nonsolidchildren )
					entity.SetSolid( 0 )

				//entities parented to players do not kill itself when the player dies as the player entity is not considered killed
				if ( parent.IsPlayer() ) {

					parent.AddEFlags( EFL_SPAWNTEMPLATE )

					if ( !keepalive ) {
						parent.ValidateScriptScope()
						local scope = parent.GetScriptScope()

						// reused from CreatePlayerWearable function
						if ( !( "templates_to_kill" in scope ) )
							scope.templates_to_kill <- []

						scope.templates_to_kill.append( entity )
					}
				}
			}
		}
		if ( parent && parent.IsValid() ) {

			function FireOnParentKilledOutputs() {

				foreach( output in scope.OnParentKilledOutputArray ) {

					local target 	= output.target
					local action 	= output.action
					local param  	= ( "param" in output ) ? output.param.tostring() : ""
					local delay  	= ( "delay" in output ) ? output.delay.tofloat() : -1
					local activator = ( "activator" in output ) ? ( typeof output.activator == "string" ? FindByName( null, output.activator ) : output.activator ) : null
					local caller 	= ( "caller" in output ) ? ( typeof output.caller == "string" ? FindByName( null, output.caller ) : output.caller ) : null

					local entfirefunc = typeof target == "string" ? DoEntFire : EntFireByHandle
					entfirefunc( target, action, param, delay, activator, caller )
				}
			}

			if ( parent.IsPlayer() ) {

				// copied from popextensions_hooks.nut
				if ( scope.OnParentKilledOutputArray.len() ) {

					local playerscope = parent.GetScriptScope()

					if ( !( "popHooks" in playerscope ) ) {
						playerscope.popHooks <- {}
					}

					if ( !( "OnDeath" in playerscope.popHooks ) ) {
						playerscope.popHooks.OnDeath <- []
					}

					// FireOnParentKilledOutputs()

					playerscope.popHooks.OnDeath.append( FireOnParentKilledOutputs )

					if ( !( "templates_to_kill" in playerscope ) )
						playerscope.templates_to_kill <- []
					playerscope.templates_to_kill.append( FireOnParentKilledOutputs )
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
					if ( FindByName( null, removeifkilled ) == null ) {
						foreach( entity, _ in scope.SpawnedEntities )
							if ( entity && entity.IsValid() )
								entity.Kill()

						SetPropString( self, "m_iszScriptThinkFunction", "" )
					}
				}
				return -1
			}
			"PlayerThinkTable" in scope ?
			scope.PlayerThinkTable.CheckIfKilled <- CheckIfKilled :
			scope.CheckIfKilled <- CheckIfKilled; AddThinkToEnt( template, "CheckIfKilled" )
		}

		//fire OnSpawnOutputs
		foreach( output in scope.OnSpawnOutputArray ) {

			local target 	= output.target
			local action 	= output.action
			local param  	= ( "param" in output ) ? output.param.tostring() : ""
			local delay  	= ( "delay" in output ) ? output.delay.tofloat() : -1
			local activator = ( "activator" in output ) ? ( typeof output.activator == "string" ? FindByName( null, output.activator ) : output.activator ) : null
			local caller 	= ( "caller" in output ) ? ( typeof output.caller == "string" ? FindByName( null, output.caller ) : output.caller ) : null

			local entfirefunc = typeof target == "string" ? DoEntFire : EntFireByHandle
			entfirefunc( target, action, param, delay, activator, caller )
		}
	}

	//make a copy of the pointtemplate
	local pointtemplatecopy = PopExtUtil.CopyTable( PointTemplates[pointtemplate] )

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

		if ( index == "nofixup" && entity )
			nofixup = true

		else if ( index == "keepalive" && entity )
			keepalive = true

		else if ( index == "removeifkilled" )
			scope.removeifkilled <- entity
	}

	//perform name fixup
	if ( !nofixup ) {
		//first, get list of targetnames in the point template for name fixup
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

						// ignore potential file paths, also ignores targetnames with "/"
						if ( value.find( targetname ) != null && value.find( "/" ) == null ) {

							keyvalues[key] <- value.slice( 0, targetname.len() ) + PopExt.globalTemplateSpawnCount + value.slice( targetname.len() )
						}
					}
				}
			}
			if ( index == "removeifkilled" ) scope.removeifkilled <- entity + PopExt.globalTemplateSpawnCount
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
						local buf = keyvalues.origin.find( "," ) ? split( keyvalues.origin, "," ) : split( keyvalues.origin, " " )

						buf.apply( @( val ) val.tofloat() )
						keyvalues.origin = Vector( buf[0], buf[1], buf[2] )
					}
				}
				else keyvalues.origin <- origin

				if ( "angles" in keyvalues ) {

					//if angles is a string, construct qangles to perform math on them if needed
					if ( typeof keyvalues.angles == "string" ) {
						local buf = keyvalues.angles.find( "," ) ? split( keyvalues.angles, "," ) : split( keyvalues.angles, " " )

						buf.apply( @( val ) val.tofloat() )
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
					local mins_sum = ( mins.find( "," ) ? split( mins, "," ) : split( mins, " " ) ).apply( @( val ) val.tofloat() ).reduce( @( a, b ) a + b )
					local maxs_sum = ( maxs.find( "," ) ? split( maxs, "," ) : split( maxs, " " ) ).apply( @( val ) val.tofloat() ).reduce( @( a, b ) a + b )

					if ( mins_sum > maxs_sum ) {
						PopExtMain.Error.RaiseValueError( "mins > maxs in point template ( %s )! Inverting...", "targetname" in keyvalues ? keyvalues.targetname : classname )
						keyvalues.mins <- maxs
						keyvalues.maxs <- mins
						mins = maxs
						maxs = mins
					}

					//overwrite responsecontext even if someone fills it in for some reason
					keyvalues.responsecontext <- format( "%s %s", mins, maxs )
				}

				template.AddTemplate( classname, keyvalues )
			}
		}
	}
	EntFireByHandle( template, "ForceSpawn", "", -1, null, null )
}

//altenative version of SpawnTemplate that will recreate itself only after wave resets ( after failure, after voting, after using tf_mvm_jump_to_wave ) to imitate spawning in WaveSchedule
//does not accept parent parameter, does not allow parenting entities
::SpawnTemplateWaveSchedule <- function ( pointtemplate, origin = null, angles = null ) {
	PopExt.waveSchedulePointTemplates.append( [PointTemplates[pointtemplate], origin, angles] )
}

::SpawnTemplates <- {
	// alternative version that accepts a table of arguments
	function DoSpawnTemplate( args = { pointtemplate = null, parent = null, origin = "", angles = "", forceparent = false, parentabsorigin = false, nonsolidchildren = false } ) {
		SpawnTemplate( args.pointtemplate, args.parent, args.origin, args.angles, args.forceparent, args.parentabsorigin, args.nonsolidchildren )
	}
}


PopExtEvents.AddRemoveEventHook("mvm_wave_complete", "SpawnTemplateWaveComplete", function( params ) {

	foreach( entity in PopExt.wavePointTemplates )
		if ( entity.IsValid() )
			entity.Kill()

	PopExt.wavePointTemplates.clear()
})

//despite the name, this event also calls on wave reset from voting, and on jumping to wave, and when loading mission
PopExtEvents.AddRemoveEventHook("mvm_wave_failed", "SpawnTemplateWaveFailed", function( params ) {

	foreach( entity in PopExt.wavePointTemplates )
		if ( entity.IsValid() )
			entity.Kill()

	foreach( param in PopExt.waveSchedulePointTemplates )
		SpawnTemplate( param[0], null, param[1], param[2] )
})

PopExtEvents.AddRemoveEventHook("player_death", "SpawnTemplatePlayerDeath", function( params ) {

	local player = GetPlayerFromUserID( params.userid )
	local scope = player.GetScriptScope()

	if ( "templates_to_kill" in scope )
		foreach ( item in scope.templates_to_kill )
			typeof item == "function" ? item() : item.Kill()

	player.RemoveEFlags( EFL_SPAWNTEMPLATE )
})