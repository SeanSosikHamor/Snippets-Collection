#!/bin/sh

TMPFILE=$(mktemp)

echo "Saved pip requirements to: ${TMPFILE}"
pip freeze | sed s/==/\>=/ > ${TMPFILE}
pip install -r ${TMPFILE} --upgrade
