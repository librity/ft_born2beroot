# Show cron daemon status
systemctl status cron
# Starts/Stops the unit in question immediately
systemctl start cron
systemctl stop cron
# Marks/Unmarks the unit for autostart at boot time
systemctl enable cron
systemctl disable cron
# Disallows/Allows all and any attempts to start the unit in question
systemctl mask cron
systemctl unmask cron

# Edit monitoring.sh script
nano /sbin/monitoring.sh
# Edit crontab's tasks config file and add create a cronjob that runs the script.
EDITOR="nano" crontab -e
"
# MY CONFIGS ###################################################################
# Run monitoring.sh every ten minutes
*/10 * * * * /sbin/monitoring.sh
# MY CONFIGS END ###############################################################
"
# List cron jobs
crontab -u USERNAME -l
