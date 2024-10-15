#!/usr/bin/env bash
echo "Installation for $1 - $2"
echo "Copying palette to config directory ..."
if [ "$(uname)" = "Linux" ]; then
  fname="${XDG_CONFIG_HOME:-$HOME/.config}"/libreoffice/*/user/registrymodifications.xcu
  fname="$(realpath $fname)" # expand
elif [ "$(uname)" = "Darwin" ]; then
  cd "$HOME/Library/Application Support/LibreOffice"/*/user # no realpath on macos
  fname="$(pwd)/registrymodifications.xcu"
  cd - > /dev/null
else
  echo "Unsupported operating system. Aborting ..."
  exit 1
fi

# Create backup of LibreOffice registry before modifications
cp -i "$fname" registrymodifications.xcu.$(date -u +"%Y-%m-%dT%H:%M:%SZ")bak

# Check settings file
if ! [ -f "$fname" ]; then
  echo "Settings file doesn't exist in expected location. Aborting ..."
  exit 1
elif ! tail -n1 "$fname" | grep -E -q '^</oor:items>$'; then
  echo "Settings file doesn't match expected format. Aborting ..."
  exit 1
fi

# Insert theme between last two lines if not present
new_settings="$(head -n $(($(wc < "$fname" -l) - 1)) "$fname" && cat ../themes/$1/$2/catppuccin-$1-$2.soc && tail -n1 "$fname")"

# Write new settings to settings file
echo "$new_settings" > "$fname"
