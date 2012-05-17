#!/bin/bash

IFS=$'\n'


for movie in $(find /media/Movies/ -mindepth 1 -maxdepth 1 -type d ! \( -iname *720p* -o -iname *1080p* -o -iname *trash* -o -iname tvshows -o -iname lost+found \)| sed 's/\/.*\///;s/([0-9] CD)//g;s/(//g;s/)//g;s/\ *$//;s/-//g')
do
    echo $movie
    merged=`eval nzbmatrix find $movie 720 | grep -e "Name" -e "NZB Id" | sed 's/.*\:\ //g' | tr '\n' ' ' | sed 's/\[\(......\)\]/\n\1/g' | sed -n 2p`
    echo $merged
    NZBID=`echo $merged | awk '{ print $1 }'`
    DLName=`echo $merged | cut -f 2- -d' '`
    if [ -n "$NZBID" ]
    then
        echo "$merged" >> DLedMovies
        echo "$DLName" >> DLedMovies
        echo "" >> DLedMovies
        eval nzbmatrix down $NZBID
    fi
done
unset $IFS
