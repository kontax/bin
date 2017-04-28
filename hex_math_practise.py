#!/usr/bin/python
# A small app to practise basic hexadecimal maths.


import random as rnd

def add_practise(num_bytes):

    if num_bytes == 2:
        max_range = 255
        f = '4'

    while True:
        num1 = rnd.randrange(0,max_range)
        num2 = rnd.randrange(0,max_range)
        ans = num1 + num2
        userans = None

        while ans != userans:
            try:
                tmp = input("  {0:#04x}\n+ {1:#04x}\n= ".format(num1, num2))
                userans = int(tmp)
            except NameError:
                userans = None
            if ans == userans:
                print("Correct!")
            else:
                print("Incorrect")

add_practise(2)
