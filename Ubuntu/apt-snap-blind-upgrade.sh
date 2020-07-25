#!/bin/sh
#
# Do not run this on production servers unless you can afford downtime.
# This script may blindly restart critical services such as Apache.
#
# This script was originally created for friends and family whose /boot
# partitions would fill to capacity due to too many concurrently installed
# kernels.

# Update the apt repositories then blindly autoremove all
apt update

# Remove all cached uninstalled package files.
apt autoclean

# Blindly remove packages that were automatically installed to satisfy
# dependencies but are no longer needed. Blindly full-upgrade all packages
# then autoremove again. This was to make sure that there was always enough
# free space on the /boot partition and to prevent upgrade failures.
apt -y autoremove
apt -y full-upgrade
apt -y autoremove

# Refresh all snaps. Run twice because sometimes the first run doesn't fully
# update the snap.
snap refresh
snap refresh

# Display canonical-livepatch status to view currently-deployed fixes.
/snap/bin/canonical-livepatch status --verbose
