#!/bin/sh

set -e

echo "Cleaning..."
npm run clean

echo "Checking outdated..."
npm outdated
echo
echo "To update, run: npm update" 
