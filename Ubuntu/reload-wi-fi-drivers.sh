#!/bin/sh
#
# Wi-Fi was unreliable for a while. Modify this script to unload and load Wi-Fi modules.

# Remove modules.
sudo rmmod iwlmvm
sudo rmmod iwlwifi
sudo rmmod mac80211

# Show some output. Wi-Fi is gone, right?
lsmod | grep wifi

# Load module.
sleep 1
sudo modprobe iwlmvm
sleep 1

# Power save contributed to random Wi-Fi disassociations.
iw dev wlan0 get power_save
sudo iw dev wlan0 set power_save off
iw dev wlan0 get power_save

# Show some output. Wi-Fi is fixed, right?
iw dev wlan0 link
