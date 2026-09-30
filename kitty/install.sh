#!/bin/sh
# Installs Bamboo Multiplex into kitty's user theme directory and selects it.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
dir="${KITTY_CONFIG_DIRECTORY:-${XDG_CONFIG_HOME:-$HOME/.config}/kitty}"
mkdir -p "$dir/themes"
cp "$here/bamboo-multiplex.conf" "$dir/themes/bamboo-multiplex.conf"
echo "Installed $dir/themes/bamboo-multiplex.conf"
if command -v kitten >/dev/null 2>&1; then
  kitten themes --reload-in=all "Bamboo Multiplex"
  echo "Applied Bamboo Multiplex."
else
  echo 'kitten not found on PATH. In kitty run: kitten themes "Bamboo Multiplex"'
fi
