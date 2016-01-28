#!/bin/sh
if [ $# -eq 0 ] ; then
	echo "This script requires you list a file to be copied and the target location in each profile."
	exit
fi
if [ $# -eq 1 ] ; then
	echo "Please specify a location to copy the file to"
	exit
fi
echo "Copying $1 to $2 in each profile"
for i in /Users/**/; do
	echo "$i"
	if [ "$i" != "/Users/Shared" ] ; then
		cp $1 $i/$2
	fi
done
