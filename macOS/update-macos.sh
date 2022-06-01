#!/bin/sh

for UPDATE in brew-update.sh gem-update.sh; do
    "$(dirname $0)"/$UPDATE
done
