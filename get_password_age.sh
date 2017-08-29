#!/usr/bin/env bash

# OSX PASSWORD NOTIFICATION TOOL
# Date: 2017-08-28

# Retrieves the password age value from local directory copy
# Write value to config file

source ./config.cfg
expireAgeUnix=$(($max_password_age))
# Divide to get Days
expireAge=$(echo "$expireAgeUnix / 86400" | bc -l)
# Get PasswordLastSet Attribute from local AD cache
pwdSetDateRaw=$(dscl localhost read /Search/Users/${user_name}| awk '/LastSet:/{print $2}')
pwdSetDateRaw=$(echo ${pwdSetDateRaw} | awk '{print $2}')
echo 'Password Retrieval Gave us' ${pwdSetDateRaw}
# Convert horrid Windows timestamp to epoch seconds
pwdSetDateUnix=$(echo "$pwdSetDateRaw / 10000000 - 11644473600" | bc -l)

# Divide to get Days
pwdSetDate=$(echo "$pwdSetDateUnix / 86400" | bc -l)
todayUnix=$(date +%s)
today=$(echo "$todayUnix / 86400" | bc -l)
daysUntilExp=$(echo "$expireAge - ($today - $pwdSetDate)" | bc -l)
daysUntilExpNice=$(echo "$daysUntilExp" | awk -F. '{print $1}')

# Renew most current expiry days in config file
sed -i '' "s/\(${password_expiry} *= *\).*/\1${daysUntilExpNice}/" config.cfg