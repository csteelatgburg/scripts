#!/bin/sh
## Copies the computer name from the DeployStudio database to the local machine
##
## Written by Chuck Steel
##
# start here
echo "${DS_BOOTCAMP_WINDOWS_COMPUTER_NAME}" >> "/Volumes/Macintosh HD/etc/deploystudio/bootcampname"

exit 0
