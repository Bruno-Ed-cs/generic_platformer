#!/bin/sh
echo -ne '\033c\033]0;generic_platformer\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/generic_platformer.x86_64" "$@"
