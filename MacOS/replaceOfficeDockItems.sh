#!/bin/sh
# This script is designed to replace any dock items in a user's dock
# with items for Office 2016

# Relies on docktutil from https://github.com/kcrawford/dockutil
declare -a apps=("Microsoft Excel" "Microsoft Word" "Microsoft Outlook" "Microsoft PowerPoint");

for app in "${apps[@]}"
do
OUTPUT=$(./dockutil --find "$app")
if [[ $OUTPUT == *"was found"* ]]
then
echo "$app was found, replacing";
./dockutil --add "/Applications/$app.app" --replacing "$app";

fi
done



