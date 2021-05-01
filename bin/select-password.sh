#!/bin/bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Copyright (C) 2016-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#####################
### CONFIGURATION ###
#####################

# Key file
KEY_FILE=${HOME}/Documents/perso/enigma.key

# Password database file
DB_FILE=${HOME}/Documents/perso/Passwords.kdbx

# Start from specified entry
SELECTED_ENTRY='default-group'

# Timeout before the password is deleted from clipbord
TIMEOUT=5


# Get all entries and pass them to dmenu, to allow the user to select one
function show_entries {
	if [[ ! -z "$1" ]]; then
		# Trim tailing slash
		INPUT="${1/\//}"
		# Append to existing string
		SELECTED_ENTRY=$SELECTED_ENTRY/$INPUT
	fi

	# Get entries
	ENTRY="$(keepassxc-cli ls -k "$KEY_FILE" "$DB_FILE" "$SELECTED_ENTRY" --no-password | dmenu -i -l 10)"
}

# Get the password for the selected entry
function get_pass {

	# Create notification
	notify-send "$SELECTED_ENTRY" "Password copied to clipboard for $TIMEOUT seconds" -t $(( TIMEOUT * 1000 ))
	# Copy password to clipboard
	keepassxc-cli clip -q -k $KEY_FILE $DB_FILE "$SELECTED_ENTRY" --no-password $TIMEOUT
}

# Show entry's contents
function show_entry_contents {
	SELECTED_ENTRY=$SELECTED_ENTRY/$1

	# Get contents of entry, but remove password and title
	CONTENTS=$(keepassxc-cli show -k "$KEY_FILE" "$DB_FILE" "$SELECTED_ENTRY" --no-password | grep -v 'Password: ' | grep -v 'Title: ')
	# Add a dummy password entry, and run dmenu
	INFO=$(echo -e "Password: ***\n$CONTENTS" | dmenu -i -l 10)

	# If the password entry was selected, use keepassxc-cli to copy the password
	# Else, remove the "Label: " string and copy the rest to clipboard
	if [[ $INFO == "Password: ***" ]]; then
		get_pass
	else
		LABEL=$(echo -n $INFO | sed 's/:.*$//g')
		VALUE=$(echo -n $INFO | sed 's/^\w\+:\s\?//g')
		notify-send "$SELECTED_ENTRY" "$LABEL copied to clipboard"
		echo -n $VALUE | xclip -selection clipboard
	fi
}

show_entries

# If $ENTRY ends in /, show child entries
while [[ $ENTRY = *\/ ]]; do
	show_entries $ENTRY
done

# When a leaf entry is selected, show the entry's contents
if [[ ! -z $ENTRY ]]; then
	show_entry_contents "$ENTRY"
fi
