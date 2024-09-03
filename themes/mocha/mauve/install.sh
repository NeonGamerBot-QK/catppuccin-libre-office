#!/bin/sh
echo "Installation for mocha - mauve"
echo "Copying palette to config directory ..."
if [ "$(uname)" = "Linux" ]; then
	fname="${XDG_CONFIG_HOME:-$HOME/.config}"/libreoffice/*/user/registrymodifications.xcu
	fname="$(realpath $fname)" # expand
elif [ "$(uname -o)" = "Msys" ]; then
	fname="$HOME/AppData/Roaming/LibreOffice"/*/user/registrymodifications.xcu
	fname="$(realpath $fname)"
elif [ "$(uname)" = "Darwin" ]; then
	cd "$HOME/Library/Application Support/LibreOffice"/*/user # no realpath on macos
	fname="$(pwd)/registrymodifications.xcu"
	cd - >/dev/null
else
	echo "Unsupported operating system. Aborting ..."
	exit 1
fi

# Create backup of LibreOffice registry before modifications
cp -i "$fname" registrymodifications.xcu.bak

# Check settings file
if ! [ -f "$fname" ]; then
	echo "Settings file doesn't exist in expected location. Aborting ..."
	exit 1
elif ! tail -n1 "$fname" | grep -E -q '^</oor:items>$'; then
	echo "Settings file doesn't match expected format. Aborting ..."
	exit 1
fi

# Check if color scheme it present already
existing_theme="$(grep -n \
	'<item oor:path="/org.openoffice.Office.UI/ColorScheme/ColorSchemes"><node oor:name="Catppuccin mocha - mauve"' \
	"$fname")"
exit_code=$?
theme_line="$(echo "$existing_theme" | sed 's|:.*||')"

if [ $exit_code -eq 0 ]; then
	echo "Dracula theme appears to already be installed. Replacing it ..."
	# Replace existing line with
	settings_start="$(head -n $((theme_line-1)) "$fname")"
	settings_end="$(tail -n +$((theme_line+1)) "$fname")"
	new_settings="$(echo "$settings_start" \
	             && cat ./catppuccin-mocha-mauve.xcu \
	             && echo "$settings_end")"
else
	# Insert theme between last two lines if not present
	new_settings="$(head -n $(($(<"$fname" wc -l)-1)) "$fname" && cat ./catppuccin-mocha-mauve.xcu && tail -n1 "$fname")"
fi

# Write new settings to settings file
echo "$new_settings" > "$fname"