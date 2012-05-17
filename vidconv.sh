#!/bin/bash

# zeroshade's script for remuxing mkv to mp4
# http://cantthinkofa.com

VERSION="1.0"

## remuxer to remux AVC mkv videos to mp4's that can be sent to xbox 360.
#  requires: mkvmerge, mkvextract (package mkvtoolnix), bbe, mplayer, normalize-audio
#            neroAacEnc (http://www.nero.com/eng/downloads-nerodigital-nero-aac-codec.php)
#            mp4creator (package mpeg4ip-server)

MKV=$1
if [ -z "$MKV" ]; then
   echo "Usage: `basename $0` <MKV>";
   exit 5
fi
# using a tmp file allows for extensibility
# if desired, the script can be extended using the audio track
# and codec by uncommenting the lines below
mkvmerge -i "$MKV" > /tmp/info.$$.txt
VID=`grep "Track ID .: video" /tmp/info.$$.txt | awk '{ print sprintf("%d",$3) }'`
#AUDINF=`grep "Track ID .: audio"`/tmp/info.$$.txt`
#AUD=`echo $AUDINF | awk '{ print sprintf("%d",$3) }'`
#AEXT=`echo $AUDINF | awk '{ print $5 }' | sed 's/(A_\|)//g' | awk '{ print tolower($1) }'`
FPS=`mplayer -identify "$MKV" -vc null -ao null -vo null -frames 0 2>/dev/null | grep ^ID_VIDEO_FPS | sed -e 's/^.*=//'`

rm /tmp/info.$$.txt

echo "------Zeroshade's remux script. MKV to mp4 V.$VERSION"
echo 

if [ -z "$VID" ]; then
    echo "Error getting video track from mkvmerge."
    exit 5
fi

if [ -z "$FPS" ]; then
    echo "Error getting framerate from mplayer"
    exit 5
fi

BASE=`echo $MKV | sed 's/\.mkv//'`
echo "------Extracting video track-----------"
mkvextract tracks "$MKV" "$VID:$BASE.h264"

echo "------Changing Profile-----------------"
bbe -e "r 7 \41" --output="$BASE.tmp.h264" "$BASE.h264"
rm "$BASE.h264"

echo "------Extracting audio track-----------"
mplayer "$MKV" -novideo -vc null -vo null -ao pcm:fast:file="$BASE.wav" -channels 2

echo "------Normalizing audio----------------"
normalize-audio "$BASE.wav"

echo "------Encoding audio to m4a------------"
neroAacEnc -lc -ignorelength -q 0.50 -if "$BASE.wav" -of "$BASE.m4a"

echo "------Removing origingal audio dump----"
rm "$BASE.wav"

echo "------Converting m4a to aac"
mp4creator --extract=1 "$BASE.m4a" "$BASE.aac"

echo "------Cleaning up m4a------------------"
rm "$BASE.m4a"

echo "------Creating mp4 video---------------"
mp4creator --create="$BASE.tmp.h264" -rate=$FPS "$BASE.mp4"

echo "------Adding audio to the video--------"
mp4creator --create="$BASE.aac" -rate=$FPS "$BASE.mp4"

echo "------Removing h264 and aac------------"
rm "$BASE.tmp.h264" "$BASE.aac"

echo "------Done! Enjoy your video! =)-------"
