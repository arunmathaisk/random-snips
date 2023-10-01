---

# Laptop Battery Management

This guide provides instructions on finding your laptop's battery name, creating a systemd service to set the battery charge stop threshold, and verifying that the threshold is working.

## Find out laptop battery name

To find out the name of your laptop's battery, run the following command:

```bash
ls /sys/class/power_supply
```

This command should output something like this:

```
AC0  BAT0
```

## Create a systemd service to set the battery charge stop threshold on boot

First, check if your laptop supports limiting battery charging by running the following command:

```bash
ls /sys/class/power_supply/BAT*/charge_control_end_threshold
```

If this command returns the path to `charge_control_end_threshold`, then your laptop supports setting a charge threshold. If the command returns an error saying there's no such file or directory, your laptop doesn't support setting a charge threshold.

## Create a new systemd file

Create a new systemd service file using your preferred text editor. Here, we use `sudo editor` as a placeholder:

```bash
sudo editor /etc/systemd/system/battery-charge-threshold.service
```

## systemd file

Inside the systemd service file, replace `BATTERY_NAME` with the name of your laptop's battery (e.g., BAT0, BAT1, or BATT) and replace `CHARGE_STOP_THRESHOLD` with the desired battery charge stop threshold (ranging between 1 and 100, e.g., 60, 80, or 100).

```ini
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
```

## Enable and start the battery-charge-threshold systemd service

To enable and start the `battery-charge-threshold` systemd service, run the following commands:

```bash
sudo systemctl enable battery-charge-threshold.service
sudo systemctl start battery-charge-threshold.service
```

## Verify that the battery charge stop threshold is working

You can verify that the battery charge stop threshold is working by checking the battery status:

```bash
cat /sys/class/power_supply/BATTERY_NAME/status
```

**Note:** Replace `BATTERY_NAME` and `CHARGE_STOP_THRESHOLD` with your actual battery name and desired threshold value when editing the systemd file.

---
