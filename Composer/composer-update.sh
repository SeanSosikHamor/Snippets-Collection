#!/bin/sh

if [ -f "composer.json" ]; then
    composer update
else
    echo "Composer project not found..."
fi

