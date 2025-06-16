import sys
from r2v_dicts import itemdefs, propdict, offset

COLOR = {
	'CYAN': '\033[96m',
	'HEADER': '\033[95m',
	'GREEN': '\033[94m',
	'YELLOW': '\033[93m',
	'GREEN': '\033[92m',
	'RED': '\033[91m',
	"ENDC": '\033[0m',
}
from os import system
system('color')

convertedkeys = [
	'$playsoundtoself',
	'$displaytextchat',
	'$displaytextcenter',
	'$addcond',
	'$removecond',
	'$addplayerattribute',
	'$removeplayerattribute',
	'$setprop',
	'$setclientprop',
	'$addcurrency',
	'$removecurrency',
	'$setmodeloverride',
	'$teleporttoentity',
	'$setkey',
	'$giveitem',
	'$awardandgiveextraitem',
	'$weaponswitchslot',
	'$changeattributes',
	'$setowner',
	'$weaponstripslot',
	'$takedamage',
	'$displaytexthint',
	'$stopvo',
	'$enableall',
	'$disableall'
]

textcolors = {
	'blue': '99ccff',
	'red': 'ff3f3f',
	'green': '99ff99',
	'darkgreen': '40ff40',
	'yellow': 'ffb200',
	'grey': 'cccccc',
	'newline': '\\n'
}
# a recursive function that returns keyvalue pairs in a list
def ParseTree(popfile, index):
	indexnumber = index
	keyvaluepairs = []
	key = ''
	value = ''
	iskey = True
	inquote = False
	insubtree = False
	depth = 0			   # used to determine how many layers of brackets we're in after calling the function

	for i in popfile[index:]:
		indexnumber = indexnumber + 1

		if inquote == False:
			# skip these characters
			if i == '{':
				depth += 1
				if depth == 1:
					insubtree = True
					# call this function again when we get to a subtree and pass the list of keyvalues through, index is at the curly bracket
					value = ParseTree(popfile, indexnumber)
					keyvaluepairs.append({key : value})
					key = ''
					value = ''
					# need this to be True
					iskey = True
				continue

			if i == '}':
				depth -= 1
				if depth == 0:
					insubtree = False
					continue
				# index started at the last open curly bracket, exit the function at the first closing curly bracket
				if depth == -1:
					return keyvaluepairs

		# keep quotes
		if i == '"':
			inquote = not inquote

		if insubtree == False:
			if inquote == False:
				if i.isspace() == False:
					#if the index character is not whitespace, write character to key string, or value if its not a key
					if iskey == True:
						key = key + i
					else:
						value = value + i

				# if key is being written and we reach a white space, end the key and start value
				if key != '' and i.isspace() == True:
					iskey = False
				# when we each the end of the value, update dictionary and reset key and value buffers
				if value != '' and i.isspace() == True:
					iskey = True
					if value != '{':
						keyvaluepairs.append({key : value})
						key = ''
						value = ''

			#if we're inside a quote, include spaces
			else:
				if iskey == True:
					key = key + i
				else:
					value = value + i

	#if you've made it here, the end of the popfile has been reached
	return keyvaluepairs

#extracts pointtemplates from ParseTree's return

def getpointtemplates(pop, keylist):
	for i in pop:
		key = list(i)[0]
		value = i.get(key)
		if key.lower() == "pointtemplates":
			keylist.append(i)
		if isinstance(value, list):
			getpointtemplates(value, keylist)
	return keylist

def convert_proptype(prop, propval, arrayval):
	# manualset = False
	# if (len(propval) < 1) or (not prop in propdict) or (prop in propdict and propdict[prop].startswith('a')):
	# 	print(COLOR['CYAN'], 'Enter Property Type for', COLOR['ENDC'], COLOR['GREEN'], f'{prop}',COLOR['ENDC'])
	# 	print(COLOR['CYAN'],'Acceptable values:',COLOR['ENDC'],COLOR['GREEN'], 'str, int, fl, ent, bool, vec', COLOR['ENDC'])
	# 	print(COLOR['CYAN'],'Alternatively:',COLOR['ENDC'],COLOR['GREEN'], 's, i, f, e, b, v', COLOR['ENDC'])
	# 	proptype = input('Property Type: ')
	# 	manualset = True
	# else:
	proptype = propdict[prop]

	if proptype.startswith('i'):
		# if manualset: proptype = 'Int'
		try:
			test = int(propval)
			proptype = 'Int'
		except Exception as e:
				proptype = 'Entity'

	elif proptype.startswith('s'): proptype = 'String'
	elif proptype.startswith('f'): proptype = 'Float'
	elif proptype.startswith('e'): proptype = 'Entity'
	elif proptype.startswith('b'): proptype = 'Bool'
	elif proptype.startswith('v'): proptype = 'Vector'
	else:
		print(COLOR['RED'],f'ERROR: Invalid Property Type! Search for SetPropINVALID in generated .nut',COLOR['ENDC'])
		proptype = 'INVALID'

	print(COLOR['CYAN'],f'Proptype for {prop} set to',COLOR['ENDC'],COLOR['GREEN'],proptype,COLOR['ENDC'])

	if proptype == "String":
		propval = f'`{propval}`'

	if prop == 'm_iszMvMPopfileName':
		print(COLOR['YELLOW'],f'WARNING: Changing m_iszMvMPopfileName can break map rotation on potato servers! Change back to default on mission complete',COLOR['ENDC'])

	if not arrayval == -1:
		proptype = f'{proptype}Array'
		return f'NetProps.SetProp{proptype}(self, `{prop}`, {propval}, {arrayval})'
	else:
		return f'NetProps.SetProp{proptype}(self, `{prop}`, {propval})'

		# if proptype == 'String':
		# 	if prop == 'm_iszMvMPopfileName':
		# 		# log.append('ALERT: Changing m_iszMvMPopfileName can break map rotation! Change back to default on mission complete')
		# 	return f'NetProps.SetProp{proptype}(self, `{prop}`, `{propval}`)'

		# elif proptype == 'Int':
		# 	if prop == 'm_iTeamNum':
		# 		# log.append('ALERT: Changing m_iTeamNum directly can lead to crashes! use ForceChangeTeam or SetTeam instead')
		# 	return f'NetProps.SetProp{proptype}(self, `{prop}`, {propval})'

		# else:
			# return f'NetProps.SetProp{proptype}(self, `{prop}`, {propval})'

customweapons = {}
def convert_raf_keyvalues(value):

	global switchslot, changeattribs, stripweps, customweapons
	splitval_addoutput = []
	if 'addoutput' in value.lower() and ':' in value.lower():
		splitval = value.split(':')
		splitval_addoutput = value.split(':')
		splitval[0] = splitval_addoutput[0].split(' ')[1]

	elif len(value.split('')) > 1:
		splitval = value.split('')

	else:
		splitval = value.split(',')

	try:
		entinput = splitval[1].lower().strip()
	except Exception as e:
		print(e, splitval)
		return

	# convert global $PlaySoundToSelf inputs to tf_gamerules PlayVO
	if 'player' in splitval[0].lower() and '$playsoundtoself' in entinput:
		print(COLOR['GREEN'],f'Converting global {splitval[1]} input to PlayVO',COLOR['ENDC'])
		splitval[0] = 'tf_gamerules'
		splitval[1] = 'PlayVO'
		splitval[2] = splitval[2].replace('\\', '/')

		if '|' in splitval[2]:
			splitval[2] = splitval[2].split('|')[1]
			print(COLOR['YELLOW'],f'WARNING: ignoring pipe separator in {splitval[2]} for $playsoundtoself',COLOR['ENDC'])
		splitval[-1] = splitval[-1].split('"')[0]


	# convert tf_gamerules StopVO to VScript stopsound on every player
	elif '$stopvo' in splitval[1].lower():
		print(COLOR['GREEN'],f'Converting {splitval[1]} input to StopSound',COLOR['ENDC'])
		splitval[0] = 'player'
		splitval[1] = 'RunScriptCode'
		filetype = splitval[2].split('.')[-1]
		if not filetype == 'wav' and not filetype == 'mp3':
			splitval[2] = f'StopSoundOn(`{splitval[2]}`, self)'
		else:
			splitval[2] = f'self.StopSound(`{splitval[2]}`)'

	elif '$displaytexthint' in splitval[1].lower():
		print(COLOR['GREEN'],f'Converting {splitval[1]} to VScript alternative',COLOR['ENDC'])
		splitval[0] = 'bignet'
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'SendGlobalGameEvent(`player_hintmessage`, {{hintmessage = `{splitval[2]}`}})'

	# use emitsoundex vscript function instead
	elif not 'player' in splitval[0].lower() and '$playsoundtoself' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} input to EmitSoundEx',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'EmitSoundEx({{sound_name = `{splitval[2]}`, channel = 0, volume = 1, pitch = 1, entity = self, filter_type = 4 }})'

	# NOTE: this requires spawnflags 256 on your point_viewcontrol to work
	elif '$enableall' in splitval[1].lower() or '$disableall' in splitval[1].lower():
		print(COLOR['YELLOW'],f'WARNING: converted {splitval[1]} to Enable/Disable, this will not work until you add spawnflags 256 to your point_viewcontrol',COLOR['ENDC'])
		splitval[1] = 'Enable' if '$enableall' in splitval[1].lower() else 'Disable'

	# convert $SetProp and $SetClientProp to vscript alternative
	elif '$setclientprop' in entinput or '$setprop' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])
		splitprop = splitval[1].split('$')
		if len(splitprop) == 4:
			arrayval = splitprop[3]
		else:
			arrayval = -1
		splitval[1] = 'RunScriptCode'
		splitval[2] = convert_proptype(splitprop[2], splitval[2], arrayval)

	#convert $DisplayText to ClientPrint
	elif '$displaytextchat' in entinput or '$displaytextcenter' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to ClientPrint',COLOR['ENDC'])
		if splitval[2].startswith('{') and '$displaytextchat' in entinput:
			splitcolor = splitval[2].split('{')
			removebracket = splitcolor[1].split('}')
			removebracket[0] = textcolors[removebracket[0]]
			color = r'\x07' + ''.join(removebracket)
			splitval[1] = 'RunScriptCode'
			if splitval[0] == 'player':
				splitval[0] = 'tf_gamerules'
				splitval[2] = f'ClientPrint(null, 3, `{color}`)'
			else:
				splitval[2] = f'ClientPrint(self, 3, `{color}`)'

		else:
			splitval[1] = 'RunScriptCode'
			if splitval[0] == 'player':
				splitval[0] = 'tf_gamerules'
				splitval[2] = f'ClientPrint(null, 4, `{splitval[2]}`)'
			else:
				splitval[2] = f'ClientPrint(self, 4, `{splitval[2]}`)'
		# input('')

	#convert $SetKey to KeyValueFromX
	elif '$setkey' in entinput:
		splitkey = splitval[1].split('$')
		print(COLOR['GREEN'],f'Converting {splitval[1]} to KeyValueFromString',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'self.KeyValueFromString(`{splitkey[2]}`, `{splitval[2]}`)'

	elif '$addcond' in entinput or '$removecond' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])
		if '$addcond' in entinput:
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.AddCond({splitval[2]})'
		else:
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.RemoveCond({splitval[2]})'

	elif '$addplayerattribute' in entinput or '$removeplayerattribute' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])
		if '$addplayerattribute' in entinput:
			splitattrib = splitval[2].split('|')
			# print(splitattrib)
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.AddCustomAttribute(`{splitattrib[0]}`, {splitattrib[1]}, -1)'
		else:
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.RemoveCustomAttribute(`{splitval[2]}`)'

	elif '$teleporttoentity' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'self.Teleport(true, {splitval[2]}.GetOrigin(), true,  {splitval[2]}.GetAbsAngles, true, {splitval[2]}.GetAbsVelocity())'
	# 	print(splitval)

	elif '$setmodeloverride' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to SetCustomModelWithClassAnimations',COLOR['ENDC'])
		splitval[1] = 'SetCustomModelWithClassAnimations'

	elif '$removeoutput' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to SetCustomModelWithClassAnimations',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'PopExtUtil.RemoveOutputAll(self, `{splitval[2]}`)'

	elif '$takedamage' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to self.TakeDamage()',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'self.TakeDamage({splitval[2]}, 0, null)'

	elif '$giveitem' in entinput or '$awardandgiveextraitem' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to PopExt alternative',COLOR['ENDC'])

		stringval = splitval[2].strip().lower()

		if stringval in itemdefs or stringval.removeprefix('the ') in itemdefs:

			if stringval.startswith('tf_'):
				if stringval in itemdefs:
					formatval = f'{stringval} ? {itemdefs[stringval]}'

			else:
				try:
					index = itemdefs[stringval] - offset
				except Exception as KeyError:
					index = itemdefs[stringval.removeprefix('the ')] - offset
				for k, v in itemdefs.items():
					# print(v, index, '\n', stringval, k)

					if v == index:
						stringval = k
						break

				formatval = f'{stringval} ? {index}'

				# input(stringval)

		else:

			if splitval[2] in customweapons:
				try:
					formatval = f'{customweapons[splitval[2]][0] } ? {customweapons[splitval[2]][1]}'
				except Exception as IndexError:
					formatval = 'INVALID ? -1 ? null'
			else:
				print(COLOR['CYAN'], 'Enter The item classname and definiton index for',COLOR['ENDC'],COLOR['HEADER'],f'{splitval[2].strip()}',COLOR['ENDC'])
				print(COLOR['CYAN'],'Find them here:',COLOR['ENDC'],COLOR['GREEN'],'https://wiki.alliedmods.net/Team_fortress_2_item_definition_indexes',COLOR['ENDC'])
				print(COLOR['CYAN'],'Enter null for wearable model if you are not creating a tf_wearable weapon',COLOR['ENDC'])
				print(COLOR['HEADER'], 'Enter ? for an example input',COLOR['ENDC'])
				formatval = 'a ? a'
				formatval = input('Format: Classname ? Index: ')

				if formatval == '?':
					print(COLOR['CYAN'],'Example input (the bat outta hell for demo):',COLOR['ENDC'],COLOR['GREEN'], 'tf_weapon_bottle ? 939', COLOR['ENDC'])
					print(COLOR['CYAN'],'Example tf_wearable input (cozy camper):',COLOR['ENDC'],COLOR['GREEN'], 'tf_wearable ? 642', COLOR['ENDC'])
					formatval = input('Format: Classname ? Index: ')

		customweapons.update({splitval[2] : formatval})
		formatsplit = formatval.split('?')

		if len(formatsplit) == 2:
			formatsplit.append('null')

		if len(formatsplit) != 3:
			print(COLOR['RED'],'ERROR: Invalid GiveWeapon input, search for `INVALID` in the generated .nut file',COLOR['ENDC'])
			formatsplit = ['INVALID', '-1', 'null']

		splitval[1] = 'RunScriptCode'
		funcname = 'GiveWeapon' if not stringval.startswith('tf_wearable') else 'GiveWearableItem'
		try:
			splitval[2] = f'PopExtUtil.{funcname}(self,`{formatsplit[0].strip()}`,{int(formatsplit[1])})'
		except Exception as ValueError:
			print(COLOR['RED'],'ERROR: Invalid GiveWeapon input, search for `INVALID` in the generated .nut file',COLOR['ENDC'])
			splitval[2] = f'PopExtUtil.{funcname}(self,`{formatsplit[0].strip()}`,{-1})'

	elif '$addcurrency' in entinput or '$removecurrency' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])

		if '$addcurrency' in entinput:
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.AddCurrency({splitval[2]})'
		else:
			splitval[1] = 'RunScriptCode'
			splitval[2] = f'self.RemoveCurrency({splitval[2]})'

	elif '$weaponswitchslot' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to vscript alternative',COLOR['ENDC'])
		switchslot = True
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'PopExtUtil.WeaponSwitchSlot(self, {splitval[2]})'

	elif '$changeattributes' in entinput:
		print(COLOR['YELLOW'],f'WARNING: converted {splitval[1]} to ChangeBotAttributes.  This will cause issues with multiple events under the same name!',COLOR['ENDC'])
		changeattribs = True
		splitval[0] = 'point_populator_interface'
		splitval[1] = 'ChangeBotAttributes'
		splitval[-1] = splitval[-1].split('"')[0]

	elif '$setowner' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to self.SetOwner()',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'self.SetOwner({splitval[2]})'

	elif '$weaponstripslot' in entinput:
		print(COLOR['GREEN'],f'Converting {splitval[1]} to PopExtUtil.StripWeapon()',COLOR['ENDC'])
		stripweps = True
		splitval[1] = 'RunScriptCode'
		splitval[2] = f'PopExtUtil.StripWeapon(self, {splitval[2]})'

	elif '$changelevel' in splitval[1].lower():
		print(COLOR['GREEN'],f'Converting {splitval[1]} to PopExtUtil.ChangeLevel()',COLOR['ENDC'])
		splitval[1] = 'RunScriptCode'
		splitkey = splitval[2].split('|')
		if len(splitkey) > 1:
			print(COLOR['YELLOW'],f'WARNING: {splitkey[1]} will not be loaded automatically!',COLOR['ENDC'])
		splitval[2] = f'PopExtUtil.ChangeLevel(`{splitkey[0]}`)'

	elif '$pausewavespawn' in splitval[1].lower() or '$resumewavespawn' in splitval[1].lower():
		print(COLOR['RED'],f'ERROR: {splitval[1]} is not supported!\nSpawn bots at unique spawn points and enable/disable the spawns instead.',COLOR['ENDC'])

	if '@p@' in splitval[0] and 'self' in splitval[2]:
		print(COLOR['GREEN'],f'Converting {splitval[0]} and {splitval[1]} to self.GetMoveParent()',COLOR['ENDC'])
		splitval[2] = splitval[2].replace('self', 'self.GetMoveParent()')
		splitval[0] = splitval[0].replace('"@p@', '"')

	# input('')
	lower = [v.lower() for v in splitval]
	if len(splitval_addoutput) > 1:

		# if 'runscriptcode' in lower[1] and ',' in lower[2]:
			# splitval[0] = ''.join(splitval[0].split(','))
			# splitval[-1] = ''.join(splitval[-1].split(','))

		splitval[0] = splitval_addoutput[0].split(' ')[0] + f' {splitval[0]}'
		value = ':'.join(splitval)
		return value.removeprefix('"').removesuffix('"')

	else:
		if 'runscriptcode' in lower[1] and ',' in lower[2]:
			value = ''.join(splitval)
		else:
			value = ','.join(splitval)
		return value.removeprefix('"').removesuffix('"')

#print pointtemplates in new format
def convertpointtemplates(pop, indentationnumber, depth):
	newindent = 0
	index = 0
	uniqueoutputs = {}
	minmax_check = {}
	valid_minmax = False
	for i in pop:
		key = list(i)[0]
		value = i.get(key)
		print('\t' * indentationnumber, end = '', file=output)
		if isinstance(value, list):
			if depth == 2 and key.lower() not in ["keepalive", "nofixup", "removeifkilled"]:
				print("[" + str(index) + "] =", file=output)
				print('\t' * indentationnumber, end = '{\n', file=output)
				indentationnumber += 1
				print('\t' * indentationnumber, end = '', file=output)
				print(key, end = ' =\n', file=output)
				print('\t' * indentationnumber, end = '{\n', file=output)
				indentationnumber += 1
				convertpointtemplates(value, indentationnumber, depth + 1)
				indentationnumber -= 1
				print('\t' * indentationnumber, end = '},\n', file=output)
				indentationnumber -= 1
				print('\t' * indentationnumber, end = '},\n', file=output)
				index += 1
			else:
				if key.lower() == "pointtemplates":
					print("::PointTemplates <- ", file=output)
				else:
					print(key, end = ' =\n', file=output)
				print('\t' * indentationnumber, end = '{\n', file=output)
				indentationnumber += 1
				newindent += 1
				convertpointtemplates(value, indentationnumber, depth + 1)
				indentationnumber -= 1
				newindent -= 1
				if newindent == 0:
					if depth != 0:
						print('\t' * indentationnumber, end = '},\n', file=output)
					else:
						print('\t' * indentationnumber, end = '}', file=output)
		else:
			key_prefixes = [
				'on',
				'$on',
				'out'
			]

			if key[0] == '"' and key[-1] == '"':
				key = key[1:-1]

			if type(value) == str and value.count(',') == 4: value = convert_raf_keyvalues(value)

			newvalue = value.replace('\\', '/')

			if any(key.lower().startswith(x) for x in key_prefixes):

				if key.lower() in uniqueoutputs.keys():
					uniqueoutputs.update({key.lower() : uniqueoutputs[key.lower()] + 1})

				else:
					uniqueoutputs.update({key.lower() : 1})
				print('"' + key + '#' + str(uniqueoutputs[key.lower()]) + '"', end = '', file=output)
				print(" : ", end = '', file=output)

				if newvalue[0] == '"' and newvalue[-1] == '"':
					newvalue = newvalue[1:-1]

				separator = ',' if not '' in newvalue else ''
				newoutput = newvalue.split(separator)

				if len(newoutput) == 3:
					newoutput.append("0")
					newoutput.append("-1")

				if len(newoutput) == 4:
					if newoutput[3] == '':
						newoutput[3] = "0"
					newoutput.append("-1")

				if len(newoutput) == 5:
					if newoutput[4] == '':
						newoutput[4] = "-1"

				print('"' + separator.join(newoutput) + '",', file=output)

			else:
				if (key == 'mins' or key == 'maxs') and not valid_minmax:
					v = value.replace('"', '').strip().split(' ')
					minmax_check[key] = v

				if 'mins' in minmax_check and 'maxs' in minmax_check:
					minsum = sum(float(i) for i in minmax_check['mins'])
					maxsum = sum(float(i) for i in minmax_check['maxs'])

					if minsum > maxsum:
						print(COLOR['RED'],f'ERROR: mins ({minsum}) > maxs ({maxsum})!\nINVERT THIS IN THE OUTPUT FILE TO AVOID A SERVER CRASH!\n',COLOR['ENDC'])
						print(COLOR['RED'],pop,COLOR['ENDC'])
					minmax_check.clear()

				print(key, end = '', file=output)
				print(" = ", end = '', file=output)

				if newvalue[0] == '"' and newvalue[-1] == '"':
					newvalue = newvalue[1:-1]

				try:
					float(newvalue)
				except:
					print('"' + newvalue + '"' + ',', file=output)

				else:
					if newvalue[0] == '.':
						print('0' + newvalue + ',', file=output)

					else:
						print(newvalue + ',', file=output)

stemplates = []
def convertspawntemplates(pop):

	file = open(pop, 'r', encoding='utf-8')

	lines = file.readlines()

	# spawntemplates = [l.strip() for l in file if 'spawntemplate' in l.lower()]
	for i, line in enumerate(lines):
		if 'spawntemplate' in line.lower() and len(line.split()) == 1:
			spawntemplates = {}
			j = i + 1
			while j < len(lines) and '}' not in lines[j-1]:
				content = lines[j].strip()
				if content:
					splitcontent = content.split('\n')[0].split()
					# print(splitcontent)
					if len(splitcontent) > 1:

						if splitcontent[0].lower() == 'name':
							spawntemplates[splitcontent[0]] = splitcontent[1]
						elif splitcontent[0].lower() == 'origin' or splitcontent[0].lower() == 'angles':
							spawntemplates[splitcontent[0]] = f'{splitcontent[1]} {splitcontent[2]} {splitcontent[3]}'
				j += 1
			# print(spawntemplates)
			stemplates.append(spawntemplates)
	# print(stemplates)
	funcs = []
	for template in stemplates:

		if len(template) < 1: continue

		func = f'SpawnTemplate({template["Name"]}, null'

		if 'Origin' in template:
			func = func + f', {template["Origin"]}'

		if 'Angles' in template:
			func = func + f', {template["Angles"]}'

		func = func + ')'
		funcs.append(func)

	for f in list(set(funcs)):
		with open(pop[:-4] + "_point_templates.nut", 'a') as file:
			file.write(f'\n{f}')

pop = None
try:
	import tkinter as tk
	from tkinter import filedialog

	root = tk.Tk()
	root.withdraw()

	file_path = filedialog.askopenfilename()
	pop = file_path
	popfile = open(file_path, 'r', encoding='utf-8').read()

except:
	from os import walk
	popfiles = {}
	for _, _, files in walk('./'):
		i = 0
		for file in files:
			if not file.endswith('.pop'):
				continue
			i += 1
			print(i, f': {file}')
			popfiles[i] = file

	file_path = input("enter the number for the file you would like to convert: ")
	pop = popfiles.get(int(file_path))

	popfile = open(pop,'r', encoding='utf-8').read()

# Remove comments
while popfile.find('//') != -1:
	popfile = popfile[:popfile.find('//')] + popfile[popfile.find('\n', popfile.find('//')):]

# Remove [$SIGSEGV] tags
popfile = popfile.replace('[$SIGSEGV]', '')

parsed = ParseTree(popfile, 0)

keylist = getpointtemplates(parsed, [])

output = open(f'{pop[:-4]}_point_templates.nut', 'a+')

convertpointtemplates(keylist, 0, 0)

output.close()

# write out spawntemplates
convertspawntemplates(pop)

input('Press Enter to close...')
