#!/bin/sh

hex_color="$1"
if [ "${hex_color:0:1}" = "#" ]; then
    hex_color="${hex_color:1}"
fi

r=$((0x${hex_color:0:2}))
g=$((0x${hex_color:2:2}))
b=$((0x${hex_color:4:2}))

r_5=$(( (r + 25) / 51 ))
g_5=$(( (g + 25) / 51 ))
b_5=$(( (b + 25) / 51 ))

color_256=$(( 16 + (r_5 * 36) + (g_5 * 6) + b_5 ))
echo "RGB 5-level: $r_5,$g_5,$b_5"
echo "Color 256: $color_256"
