#!/bin/sh

pip freeze | sed s/==/\>=/ > /tmp/requirements.txt
pip install -r /tmp/requirements.txt --upgrade
