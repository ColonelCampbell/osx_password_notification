OSX PASSWORD NOTIFICATION TOOL
Date: 2017-08-28


- - - Information - - -
This tool will notify a user of the days left until their AD password expires.
- config.cfg          : The configuration file. Set variables here
- README.txt          : This is the file you are reading now
- get_password_age.sh : Gathers the expiration information from local directory
- notify_pwd_age.sh   : Produces an OSX system notification

Any possible configuration changes should be made only in 'config.cfg'.
Should there be issues that require other changes to be made, please
contact the creator, or change AT YOUR OWN RISK.


- - - Instructions - - -
Copy the directory and its contents to the top of the users folder:
- /Users/<username>/osx_pwd_notify/

Each file in this directory should be executable by the system/owner -> 755
- $ ls -lart


- - - CRON CONFIGURATION - - -
This tool runs off of the local cron.
Cron Configuration Cadence: (0 8-13 * * *) Once every hour between 8am - 1pm

We've chosen to alert the user 5 times a day with this notification, everyday
that their account password is less than the 'notification_threshold' parameter
in 'config.cfg'. This can, of course, be changed at a whim.

Edit your local crontab ($ crontab -e)
Add a cron job for each bash script in the osx_pwd_notify directory

The jobs should look like this:

1/15 * * * * cd ~/osx_pwd_notify && bash ./get_password_age.sh
0 8-13 * * * cd ~/osx_pwd_notify && bash ./notify_pwd_age.sh

