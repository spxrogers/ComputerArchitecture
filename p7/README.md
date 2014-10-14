Given: a C program and a Makefile that runs it. The program creates
an in-memory matrix and computes its transpose then prints an estimate
of nano seconds needed for each transpose iteration.

You're given a simple (slow implementation) and you're required to
implement a faster one.

Grading:

You will be competing with your peers to see who gets the most speedup.

to compile:

    make

to run:

    make run

Files you can change:

    fast.c: replace the implementation of fast

Files you should leave alone:

    main.c : the main program and the slow implementation
    Makefile : the makefile
    common.h : header file
    
The output will look something like this:

slow count=8 bytes=800000000 N=10000 ns/iter=12.500000
fast count=48 bytes=800000000 N=10000 ns/iter=2.083333
speedup=6.000000


N: the matrix is NxN
count: number of transposes done in 10 seconds
bytes: number of bytes in the arrays
ns/iter: nano-seconds per transpose iteration
