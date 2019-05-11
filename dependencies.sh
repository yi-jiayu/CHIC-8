#!/bin/sh -

eggs="
srfi-69
test
"

for egg in $eggs; do
	chicken-install $egg
done
