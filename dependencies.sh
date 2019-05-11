#!/bin/sh -

eggs="
srfi-69
test
sdl2
"

for egg in $eggs; do
	chicken-install $egg
done
