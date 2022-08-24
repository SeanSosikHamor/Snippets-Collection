#!/bin/sh

if [ -f .hugo_build.lock ]; then
    echo "Deleting public..."
    rm -rf public
    echo "Deleting .DS_Store..."
    find . -type f -name ".DS_Store" -exec rm -f {} \;
    hugo
    hugo server -D
else
    echo ".hugo_build.lock does not exist. Not a hugo project?"
fi
