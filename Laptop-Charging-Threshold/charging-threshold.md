-----------------------------------------------
# Find out laptop battery name.

ls /sys/class/power_supply

This command should output something like this:

AC0  BAT0

-----------------------------------------------
-----------------------------------------------
# Create a systemd service to set the battery charge stop threshold on boot

ls /sys/class/power_supply/BAT*/charge_control_end_threshold


If this command returns the path to charge_control_end_threshold, then your laptop supports limiting battery charging. If the command returns an error, saying there's no such file or directory, then your laptop doesn't support setting a charge threshold.

-----------------------------------------------
-----------------------------------------------
# Create a new systemd file

sudo editor /etc/systemd/system/battery-charge-threshold.service

-----------------------------------------------
-----------------------------------------------
# Systemd file (Here, change BATTERY_NAME with the name of the battery (BAT0, BAT1 or BATT), and CHARGE_STOP_THRESHOLD with the battery charge stop threshold you want to use (ranging between 1 and 100). 60, 80 and 100.

[Unit]
Description=Set the battery charge threshold
After=multi-user.target
StartLimitBurst=0

[Service]
Type=oneshot
Restart=on-failure
ExecStart=/bin/bash -c 'echo CHARGE_STOP_THRESHOLD > /sys/class/power_supply/BATTERY_NAME/charge_control_end_threshold'

[Install]
WantedBy=multi-user.target

-----------------------------------------------
-----------------------------------------------
# Enable and start the battery-charge-threshold systemd service.

sudo systemctl enable battery-charge-threshold.service

sudo systemctl start battery-charge-threshold.service

-----------------------------------------------
-----------------------------------------------
# Verify that the battery charge stop threshold is working.

cat /sys/class/power_supply/BATTERY_NAME/status

-----------------------------------------------






