#!/bin/sh

if [ $1 ]; then
    echo
    cat ${1} | sed s/\"/\\\\\"/g
    echo
    echo
else
    echo "No SVG file specified..."
fi
