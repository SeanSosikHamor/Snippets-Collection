#!/bin/sh
#
# Author: Sean Sosik-Hamor <sean@hamor.com>
# License: GPLv3
#
# Description:
# Find the latest published summary URL on Newsvoice.com, iterate through a list of
# all recently-submitted summaries (both published and unpublished), and search for
# a single-word string that appears in the title (case-insensitive).

# Seconds to wait in between wget requests.
LIMIT="0.25"

# Set Web site and channels.
SITE="https://newsvoice.com"
CHANNELS="world national tech politics business coronavirus"
URLS="$(for URL in $CHANNELS; do echo $SITE/c/$URL; done)"

# Text to search for when we run out of valid summary URLs.
NOTFOUND="\[404.jpg\]"

# Check to see if there's a search term argument on the command line.
if [ "$1" != "" ]; then
    MYSUMMARY="$1"
    echo "Searching for $MYSUMMARY"
    echo
else
    echo "Usage: $0 search-term"
    echo
    exit
fi

echo "$URLS" | grep -q "$MYSUMMARY"
STATUS="$?"
if [ "$STATUS" -eq 0 ]; then
    echo "The search term exists in the Web site URL or channel name."
    echo "There will be too many results. Automatically exiting..."
    echo
    exit
fi

echo "Fetching latest summary URLs...hit Ctrl-C to stop..."

# Iterate through site and channels searching for summary URLs.
#
# TODO: The summary primary key is currently comprised of 7 digits. This script will
# break once the key is contains greater than 7 digits.
i="$(for URL in $SITE $URLS; do lynx -dump $URL; done | grep "/i/" | grep -o "[[:digit:]]\{7\}" | sort -u | tail -1)"

while true; do
    URL="$SITE/i/$i"
    echo "Hit Ctrl-C to stop. Searching: $URL"

    OUTPUT="$(lynx -dump $SITE/i/$i | egrep -i "($MYSUMMARY|$NOTFOUND)")"

    echo "$OUTPUT" | grep -q -i -o "$MYSUMMARY"
    STATUS="$?"
    if [ "$STATUS" -eq 1 ]; then
        echo "Search term not found..."
        echo
    elif [ "$STATUS" -eq 0 ]; then
        echo "Found search term: $OUTPUT"
        echo
    fi

    echo "$OUTPUT" | grep -q -o "$NOTFOUND"
    STATUS="$?"
    if [ "$STATUS" -eq 0 ]; then
        echo "Hit 404 at $URL. Automatically exiting..."
        echo
        exit
    fi

    sleep "$LIMIT"
    ((i++))
done
