#!/bin/sh
#
# Copyright (c) 2020 Sean Sosik-Hamor <sean@hamor.com>
#
# You should have received a copy of the GPLv3 LICENSE along with
# this file. If not, see <http://www.gnu.org/licenses/>.
#
# Usage
#
# Do not run this on production servers unless you can afford downtime.
# This script may blindly restart critical services such as Apache.
#
# This script was originally created for friends and family whose /boot
# partitions fill to capacity due to too many concurrently installed
# kernels.

# Update the apt repositories then blindly autoremove all
sudo apt update

# Blindly remove packages that were automatically installed to satisfy
# dependencies but are no longer needed.
sudo apt -y autoremove

# Blindly full-upgrade all packages.
sudo apt -y full-upgrade

# Run autoremove again, as newly-installed kernels may mark additional
# old kernels for removal.
sudo apt -y autoremove

# Remove all cached or old uninstalled package files.
sudo apt autoclean
sudo apt clean

# Refresh all snaps. Run twice because some snaps require multpiple
# refreshes to update the snap.
if [ -x /usr/bin/snap ]; then
    sudo snap refresh
    sudo snap refresh
fi

# Display canonical-livepatch status to view currently-deployed fixes.
if [ -x /snap/bin/canonical-livepatch ]; then
    sudo /snap/bin/canonical-livepatch status --verbose
fi
