# Miscellaneous Support Scripts for Jamstack Sites

## date-lastmod.sh

Generates a timestamp compatible with date: and lastmod: fields in Markdown files.

## escape-svg-quotes.sh

Jamstack markdown may require escaping quotes in SVG files. Takes an SVG file as input, escapes all quotes, and displays on STDOUT.

## npm-clean.sh

Cleans NPM cache.

## strip-lastmod.sh

The `enableGitInfo = true` configuration option automatically generates the lastmod: field from Git. This script strips out manual lastmod: lines from Markdown files. 
