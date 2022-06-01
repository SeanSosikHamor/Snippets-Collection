#!/bin/sh

TMP=$(mktemp)

if [ -f _index.md ]; then
    for file in $(grep -r lastmod: * | cut -d : -f 1); do
        grep -v "lastmod: " ${file} > ${TMP}
        mv -v ${TMP} ${file}
    done
else
    echo "There is no _index.md file. Are you in the correct directory?"
fi

