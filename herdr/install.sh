#!/bin/sh
# Installs Bamboo Multiplex into herdr's config.toml: sets [theme] name to the base
# theme "one-dark" and replaces any existing [theme.custom] table.
# herdr only accepts built-in theme names and the fixed [theme.custom] table;
# a [theme.bamboo-multiplex] table is rejected as an unknown config key.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
cfg="${HERDR_CONFIG_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr/config.toml}"
base="one-dark"
mkdir -p "$(dirname "$cfg")"
[ -f "$cfg" ] || : > "$cfg"
cp -p "$cfg" "$cfg.bak.$(date +%Y%m%d%H%M%S)"
tmp=$(mktemp "$cfg.tmp.XXXXXX")
trap 'rm -f "$tmp"' EXIT
awk -v base="$base" '
  /^[[:space:]]*\[/ {
    if ($0 ~ /^[[:space:]]*\[theme\.custom(\.[^]]*)?\]/) { skip = 1; buf = ""; next }
    skip = 0
    printf "%s", buf; buf = ""
    print
    intheme = ($0 ~ /^[[:space:]]*\[theme\][[:space:]]*(#.*)?$/)
    if (intheme) { seen = 1; print "name = \"" base "\"" }
    next
  }
  /^[[:space:]]*#/ { buf = buf $0 "\n"; next }
  skip { buf = ""; next }
  {
    printf "%s", buf; buf = ""
    if (intheme && $0 ~ /^[[:space:]]*name[[:space:]]*=/) next
    print
  }
  END {
    if (!skip) printf "%s", buf
    if (!seen) print "\n[theme]\nname = \"" base "\""
  }
' "$cfg" > "$tmp"
{ printf '\n'; cat "$here/bamboo-multiplex.toml"; } >> "$tmp"
cat "$tmp" > "$cfg"
echo "Installed Bamboo Multiplex in $cfg (theme.name = \"$base\")"
if grep -Eq '^[[:space:]]*auto_switch[[:space:]]*=[[:space:]]*true' "$cfg"; then
  echo 'note: auto_switch = true lets light_name / dark_name override theme.name.'
fi
if command -v herdr >/dev/null 2>&1; then
  HERDR_CONFIG_PATH="$cfg" herdr config check
  herdr server reload-config >/dev/null 2>&1 && echo "Reloaded running herdr server." || echo "No running herdr server to reload."
fi
