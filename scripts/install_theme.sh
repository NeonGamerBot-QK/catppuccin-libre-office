#!/usr/bin/env bash
flavor="$1"
accent="$2"

if [ -z "$flavor" ] || [ -z "$accent" ]; then
  echo "Usage: $0 <flavor> <accent>   e.g. $0 mocha mauve"
  exit 1
fi

# Resolve the theme relative to the repository, not the current directory, so
# the script works from anywhere (the README invokes it as ./scripts/...).
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
theme="$repo_dir/themes/$flavor/$accent/catppuccin-$flavor-$accent.xcu"

if ! [ -f "$theme" ]; then
  echo "No theme at $theme. Check the flavor and accent names. Aborting ..."
  exit 1
fi

echo "Installation for $flavor - $accent"
echo "Applying application colors ..."
if [ "$(uname)" = "Linux" ]; then
  # First check Flatpak per-app config path used by Flatpak installs of LibreOffice
  flatpak_glob="$HOME/.var/app/org.libreoffice.LibreOffice/config/libreoffice/*/user/registrymodifications.xcu"
  if compgen -G "$flatpak_glob" > /dev/null; then
    # take the first match
    matched_file="$(compgen -G "$flatpak_glob" | head -n1)"
    fname="$(realpath "$matched_file")"
  else
    fname="${XDG_CONFIG_HOME:-$HOME/.config}"/libreoffice/*/user/registrymodifications.xcu
    fname="$(realpath "$fname")" # expand
  fi
elif [ "$(uname)" = "Darwin" ]; then
  cd "$HOME/Library/Application Support/LibreOffice"/*/user # no realpath on macos
  fname="$(pwd)/registrymodifications.xcu"
  cd - > /dev/null
else
  echo "Unsupported operating system. Aborting ..."
  exit 1
fi

# Check settings file
if ! [ -f "$fname" ]; then
  echo "Settings file doesn't exist in expected location. Aborting ..."
  exit 1
elif ! tail -n1 "$fname" | grep -E -q '^</oor:items>$'; then
  echo "Settings file doesn't match expected format. Aborting ..."
  exit 1
fi

# Create backup of LibreOffice registry before modifications
backup="$fname.$(date -u +"%Y-%m-%dT%H:%M:%SZ").bak"
cp "$fname" "$backup"

# Insert the theme before the closing tag, dropping any previously installed
# Catppuccin scheme so repeat runs replace rather than accumulate.
tmp="$(mktemp)"
grep -v '<node oor:name="Catppuccin ' "$fname" | grep -v '^</oor:items>$' > "$tmp"
cat "$theme" >> "$tmp"
printf '\n</oor:items>\n' >> "$tmp"

# Write new settings to settings file
cat "$tmp" > "$fname"
rm -f "$tmp"

echo "Done. Backup written to $backup"
echo "Select \"Catppuccin $flavor - $accent\" under"
echo "Tools > Options > LibreOffice > Application Colors (with application theming enabled)."
