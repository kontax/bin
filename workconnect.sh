#!/bin/bash
# connect to work desktop through laptop
# laptop must be on and connected via ssh
set -x
rdesktop -d PPOWER -u jcoulson -p $PASSWORD -g 1920x1080 -f localhost
