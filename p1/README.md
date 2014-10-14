Objective:
~~~~~~~~~~

write a simple program in x86 assembly

Assignment:
~~~~~~~~~~~

Write a program that reads characters from standard input and prints them to
standard output. If a character is contained in your CSID, its case is flipped
before printing it out, otherwise, it is printed as is.

For example, if your CSID is BOB92, the following transformations would take
places:

Hello => HellO
Goodbye => GOOdBye
On to school => on tO schOOl

Files you're allowed to change:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   main.s     -- The program

Files you're supposed to leave alone:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   Makefile   -- rules for compiling and running the program
   test.in    -- the test strings
   id         -- contains your csid
   tr.sh      -- shell script used in testing
   
To compile:
~~~~~~~~~~~

    make

To run test:
~~~~~~~~~~~~

    make clean test

To make the output less noisy:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    make -s clean test

To run by hand
~~~~~~~~~~~~~~

    make
    ./main
