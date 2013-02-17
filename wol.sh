#!/bin/bash

# definition of MAC addresses
coolio=00:24:1d:cd:a7:9d

while [ "$input1" != quit ]; do
echo "Which PC to wake?"
echo "a) coolio"
echo "q) quit and take no action"
read input1

if [ $input1 == g ]; then
  /usr/bin/wol -v -h -p 9 ghost $ghost
  exit 1
fi

if [ $input1 == Q ] || [ $input1 == q ]; then
echo "later!"
exit 1
fi

done
echo  "this is the (quit) end!! c-ya!"
