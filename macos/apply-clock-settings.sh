#!/usr/bin/env zsh

##
# Whenever macOS installs an update, it resets the clock settings to the default. This
# script will apply the clock settings that I prefer.
#
# References:
# - https://github.com/tech-otaku/menu-bar-clock/blob/main/menu-bar-clock.sh
##

set -e

##
# Print out the current clock settings.
##
echo "Current clock settings:"
defaults read com.apple.menuextra.clock
echo

##
# Apply each of the clock settings that I prefer.
##

# Use a digital display
defaults write com.apple.menuextra.clock.plist IsAnalog -bool false

# Apply the date format
# NOTE: This currently appears to be wrong. Leaving this as is for now.
# FORMATSTRING="EEE H:mm"
# defaults write com.apple.menuextra.clock.plist DateFormat -string "$FORMATSTRING"

# Show the date
defaults write com.apple.menuextra.clock.plist ShowDate -bool true
# Show the day of week
defaults write com.apple.menuextra.clock.plist ShowDayOfWeek -bool true
# Show seconds
defaults write com.apple.menuextra.clock.plist ShowSeconds -bool true

##
# Restart the ControlCenter process so the changes take effect.
##
# ???

