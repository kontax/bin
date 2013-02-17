#!/bin/bash
# Move the files in the transmission directory to the 
# movie directory for couchpotato

mv /media/Downloads/transmission/Movies/* /media/Downloads/complete/Movies
chown -R james:users /media/Downloads/complete/Movies/*
