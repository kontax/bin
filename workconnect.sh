#!/bin/bash
# connect to work desktop through laptop
# laptop must be on and connected via ssh

rdesktop -u jcoulson -p $PASSWORD -g 1280x1024 -f localhost
