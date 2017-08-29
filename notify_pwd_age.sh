#!/usr/bin/env bash

# OSX PASSWORD NOTIFICATION TOOL
# Date: 2017-08-28

# Grabs information from config.cfg file and write it to a LoginWindowText

source ./config.cfg

if [ ${password_expiry} ]
then
    if [ ${password_expiry} -le ${notification_threshold} ]
    then
        text="Your login password will expire in ${password_expiry} days"
        # Call AppleScript Command
        osascript -e "display notification \"$text\" with title \"$banner_title\" subtitle \"$banner_subtitle\" "
        # Write to lock screen message
        sudo defaults write /Library/Preferences/com.apple.loginwindow LoginWindowText "$text"
    fi
fi
