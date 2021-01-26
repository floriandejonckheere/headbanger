#!/usr/bin/env sh
#
# convert.sh - convert logo to favicon
#

SIZES=(16 32 48)

for SIZE in ${SIZES[@]}; do
  inkscape -w ${SIZE} -h ${SIZE} logo.svg --export-png=logo${SIZE}.png
done

convert logo*.png favicon.ico

rm logo*.png
