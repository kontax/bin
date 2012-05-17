#!/bin/bash
# movie-rename.sh
# rename all the files in the movie directory as the name
# of the directory, without the year and quality

if [ $# == 1 ]
then
    pushd . >/dev/null
    cd $1
    IFS=$'\n'
    totalcounter=0
    
    for file in `find . -mindepth 2 -maxdepth 2 -type f | sort -n`
    do
        extension="`basename $file | sed 's/^.*\(...\)$/\1/'`"
        dir="`dirname $file`"
        
        if [ `ls $dir | grep $extension | sed 's/^.*\(...\)$/\1/' | sort -n | uniq -c | head -1 | awk '{ print $1 }'` -eq 1 ]
        then
            renamedfile=`echo $dir | sed 's/\.\/\(.*\)/\1/g;s/\ (.*)//g;s/\(.*\)/\L\1/g;s/://g' | tr ' ' '.'`
            if [ `basename $file` != $renamedfile.$extension ]
            then
                echo "$file being renamed to:  $renamedfile.$extension"
                echo
                mv -i $file $dir/$renamedfile.$extension
                let totalcounter=$totalcounter+1
            else
                echo "" >/dev/null
            fi
        else
            counter=1
            count=`ls $dir/ | grep $extension | sed 's/^.*\(...\)$/\1/' | sort -n | uniq -c | awk '{ print $1 }'`
            while [ $counter -le $count ]
            do
                renamedfile2=`echo $dir | sed 's/\.\/\(.*\)/\1/g;s/\ (.*)//;s/\(.*\)/\L\1/;s/://g' | tr ' ' '.'`
                newfilename=$renamedfile2.cd$counter.$extension
                if [ -a $dir/$newfilename ]
                then
                    echo "" >/dev/null
                else
                    echo "$file being renamed to: $newfilename"
                    echo
                    mv -i $file $dir/$newfilename
                    let totalcounter=$totalcounter+1
                    break
                fi
                let counter=$counter+1
            done
        fi
    done
    
    echo "A total of $totalcounter movies renamed"
    unset IFS
    popd >/dev/null
    
else
    echo "Usage: movie-rename.sh {root target directory}"
fi
