Assignment:

Finish the implementation of a program that builds on the dependent-load
measurement technique we used in p7 in order to estimate the cache sizes
and latencies of a processor

You need to implement two functions:

 - void prep(int ws)

      Allocate a data structure of the given size in bytes and prepare it
      for use the "doit" function

 - int doit()

      Start a chain of dependent loads in the style of p7 drawn from random
      addresses in the data structure created by "prep" and return the number
      of loads performed.

The main program will iterate over different working set sizes and in each
iteration will:

    - call prep with the working set size
    - call doit multiple times
    - prints the working set and an estimate of the load latency in cycles


Deliverables:

    - finish the implementation of prep and doit

    - edit ANSWERS and provide estimates and reasoning for:

        * Number of cache levels
        * An estimate for the latency of each level as well main memory

To compile:

    - make

To run:

    - make run

Files:

    - Makefile - the make file (leave it alone)
    - main.c - the main program (leave it alone)
    - common.h - shared headers (leave it alone)
    - cstuff.c - put any C code you need here
    - sstuff.c - put any assemble code you need here
    - ANSWERS - your answers
