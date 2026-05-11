#!/usr/bin/env  dash
# @tuna.name Open links in Helium Work profile
# @tuna.subtitle Shrink selected files for email
# @tuna.icon symbol:photo.badge.arrow.down
# @tuna.mode background
# @tuna.input arguments
# @tuna.output none

if [ -n "$1" ]; then
    /Applications/Helium.app/Contents/MacOS/Helium --arg --profile-directory="Profile 1" "$1"
else
    /Applications/Helium.app/Contents/MacOS/Helium --arg --profile-directory="Profile 1" https://www.google.com
fi
