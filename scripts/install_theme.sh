#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <flavor> <accent>"
  exit 1
fi

flavor="$1"
accent="$2"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(dirname "$script_dir")"
theme_dir="$repo_dir/themes/$flavor/$accent"
soc_file="$theme_dir/catppuccin-$flavor-$accent.soc"
xcu_file="$theme_dir/catppuccin-$flavor-$accent.xcu"
theme_name="Catppuccin $flavor - $accent"

if ! [ -f "$soc_file" ] || ! [ -f "$xcu_file" ]; then
  echo "Theme not found: $flavor/$accent"
  exit 1
fi

registry=""
case "$(uname)" in
  Linux)
    for path in \
      "$HOME/.var/app/org.libreoffice.LibreOffice/config/libreoffice"/*/user/registrymodifications.xcu \
      "${XDG_CONFIG_HOME:-$HOME/.config}"/libreoffice/*/user/registrymodifications.xcu
    do
      [ -f "$path" ] && registry="$path" && break
    done
    ;;
  Darwin)
    for path in "$HOME/Library/Application Support/LibreOffice"/*/user/registrymodifications.xcu; do
      [ -f "$path" ] && registry="$path" && break
    done
    ;;
  *)
    echo "Unsupported operating system. Aborting ..."
    exit 1
    ;;
esac

if [ -z "$registry" ]; then
  echo "LibreOffice settings file not found. Open LibreOffice once, enable application theming, close it, then rerun this script."
  exit 1
fi

if ! tail -n1 "$registry" | grep -E -q '^</oor:items>$'; then
  echo "Settings file doesn't match expected format: $registry"
  exit 1
fi

config_dir="$(dirname "$registry")/config"
mkdir -p "$config_dir"
cp "$soc_file" "$config_dir/"

if grep -Fq "oor:name=\"$theme_name\"" "$registry"; then
  echo "Theme already installed: $theme_name"
  exit 0
fi

backup="$registry.$(date -u +"%Y%m%dT%H%M%SZ").bak"
cp "$registry" "$backup"

tmp="$(mktemp "$registry.XXXXXX")"
sed '$d' "$registry" > "$tmp"
cat "$xcu_file" >> "$tmp"
printf '\n' >> "$tmp"
tail -n1 "$registry" >> "$tmp"
mv "$tmp" "$registry"

echo "Installed $theme_name"
echo "Palette: $config_dir/$(basename "$soc_file")"
echo "Backup: $backup"
