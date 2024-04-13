import datetime
import os
import typing

import vdf
import tf_item_map

# == CONSTANTS ==
LOCALE: typing.Final[str] = 'english'
OUTPUT_DIR: typing.Final[str] = f'{os.path.dirname(__file__)}/output'
OUTPUT_FILE_NAME: typing.Final[str] = 'itemdef_constants.nut'

# Replacement map for characters in schema "name" strings
# Most entries here are since Squirrel does not support them in var names
SQUIRREL_CONSTNAME_CHARMAP: typing.Final[tuple] = \
(
	# Remove by mapping to empty string
	('\'',''),	# Apostrophe
	('(', ''),	# Open parentheses
	(')', ''),	# Close parentheses
	('!', ''),	# Exclamation mark
	('.', ''),	# Full stop
	(':', ''),	# Colon
	('%', ''),	# Percentage
	(',', ''),	# Comma
	('#', ''),	# Pound
	('/', ''),	# Forward slash
	('&', ''),	# Ampersand

	(' ', '_'),	# Space -> Underscore
	('-', '_')	# Hyphen -> Underscore
)

# Replacement map for substrings in schema "name" strings
# Most entries here are for improved user comprehension
SQUIRREL_CONSTNAME_STRMAP: typing.Final[tuple] = \
(
	('TF_WEAPON_',''),
	('THE ',''),
	('UPGRADEABLE ', 'UNIQUE '),
	('PROMO ', 'GENUINE ')
)

# Comment name override for specific item indices for user clarity
# Overrides should be such that someone using Ctrl+F to find by name should still
#  hit the correct constant.
SCHEMA_NAME_OVERRIDE: typing.Final[tuple] = \
(
	('9', 'Engineer\'s Shotgun'),
	('10', 'Soldier\'s Shotgun'),
	('11', 'Heavy\'s Shotgun'),
	('12', 'Pyro\'s Shotgun')
)

tf_path = f'{os.environ['ProgramW6432']}/Steam/steamapps/common/Team Fortress 2/tf'

if __name__ == "__main__":
	# GPL says you're supposed to do this or something
	print('\nItemdef Constants Generator Script by fellen.\n https://github.com/mtxfellen/\n')

	print('Reading items_game.txt...')
	path_to_schema = os.path.abspath(f'{tf_path}/scripts/items/items_game.txt')
	with open(path_to_schema, 'r') as fp:
		items_game = vdf.parse(fp)
	print(f'Reading tf_{LOCALE}.txt...')
	path_to_loc_file = os.path.abspath(f'{tf_path}/resource/tf_{LOCALE}.txt')
	with open(path_to_loc_file, 'r', encoding='utf-16-le') as fp:
		locfile = vdf.parse(fp)

	items = items_game['items_game']['items']
	prefabs = items_game['items_game']['prefabs']
	del items_game
	items = {'default': items.pop('default'), **dict(sorted(items.items(), key=lambda item: int(item[0])))}

	locfile = locfile['lang']['Tokens']
	locfile = {k.lower(): v for k, v in locfile.items()}

	generation_time = datetime.datetime.now(datetime.timezone.utc)
	const_list = ['// Itemdef constants generated on ' + generation_time.strftime('%H:%M %Y/%m/%d UTC')]
	print('Parsing data from items_game.txt...')

	for key, value in items.items():
		value = tf_item_map.schema_block_from_prefabs(prefabs, value)

		# Format constant name
		constname = value['name'].upper()
		# This is not fast!
		for init, map in SQUIRREL_CONSTNAME_STRMAP:
			if constname.startswith(init):
				constname = constname.replace(init, map)
		for init, map in SQUIRREL_CONSTNAME_CHARMAP:
			constname = constname.replace(init, map)
		# Remove duplicate underscores
		while '_' * 2 in constname:
			constname = constname.replace('_' * 2, '_')

		# Add line comment containing index description
		for init, map in SCHEMA_NAME_OVERRIDE:
			if key == init:
				linecomment = f' // {map}'
				break
		else:
			# Add localised name as comment
			try:
				localisedstring = locfile[value['item_name'][1:].lower()].replace('\n', '\\n')
				# Limit comment localised name length to 40 chars (length of HHHH)
				localisedstring = localisedstring[:40] + '...' * (len(localisedstring) > 40)
				linecomment = f' // \'{localisedstring}\''
			except KeyError:
				# Try to default to unlocalised string if entry is missing.
				try:
					linecomment = f' // \'{value['item_name']}\''
				# Default to empty string if no localisation look-up is specified.
				except KeyError:
					linecomment = ''

		# Catch string index entries in schema
		try:
			const_list.append(f'const ID_{constname} = {int(key)}{linecomment}')
		except ValueError:
			const_list.append(f'const ID_{constname} = "{key}"{linecomment}')

	full_output_path = os.path.abspath(f'{OUTPUT_DIR}/{OUTPUT_FILE_NAME}')
	print(f'Writing to \'{full_output_path}\'... ', end='', flush=True)

	if not os.path.exists(OUTPUT_DIR):
		os.makedirs(OUTPUT_DIR)
	with open(full_output_path, mode='wt', encoding='utf-8', newline='\n') as fp:
		fp.write('\n'.join(const_list) + '\n')

	print('Done.')
	raise SystemExit
