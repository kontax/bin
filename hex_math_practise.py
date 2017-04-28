#!/usr/bin/python
# A small app to practise basic hexadecimal maths.


import os
import sys
import random as rnd

def add(num_bytes):
    
    # Set the maximum range of bytes that
    # can be represented
    max_range = 2**(4*num_bytes)-1

    # Set the format string so everything
    # is viewed on screen properly
    fmt = "  {num1:#0{n}x}\n+ {num2:#0{n}x}\n= "
    n = num_bytes+2


    while True:

        # Pick two numbers
        num1 = rnd.randrange(0, max_range)
        num2 = rnd.randrange(0, max_range)

        # Setup the answers
        ans = num1 + num2
        userans = None

        # Keep going until either the answer
        # matches the user's, or Ctrl-C
        while ans != userans:
            try:
                # Get a number from the user
                tmp = input(fmt.format(num1=num1, num2=num2, n=n))
                userans = int(tmp, 16)
            except (NameError, ValueError):
                userans = None
            except KeyboardInterrupt:
                # If quitting, show the answer
                print("Answer: {0:#x}".format(ans))
                try:
                    sys.exit(0)
                except SystemExit:
                    os._exit(0)
            if ans == userans:
                print("Correct!")
            else:
                print("Incorrect")

if __name__ == '__main__':
    print("Practise adding hex numbers.")
    while True:
        choice = input("Choose the number of bytes to practise: ")
        try:
            num_bytes = int(choice)
            break
        except:
            pass

    add(num_bytes)
