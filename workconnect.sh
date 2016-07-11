#!/bin/bash
# connect to work desktop through laptop
# laptop must be on and connected via ssh

#set -x
read -s -p "Password: " PASSWORD
echo 
#exec > /dev/null 2>&1
rdesktop -d PPOWER -u jcoulson -p $PASSWORD -g 1920x1080 -f localhost
