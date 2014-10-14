Assignment:

Finish the implementation of a program that estimates the performance
characteristics of an x86 processor.

For each type of operation we need to estimate the following:

    - latency: how long does it take for the result of the operation to be
               ready for use
    - rate: how many operations are performed per time unit

The results are reported in nano-seconds and in processor cycles

The instructions to be measured are:

    - integer add instructions
    - integer multiply instructions
    - integer divide instructions
    - load instructions

We also need to measure independent add operations:

    - 32 bit integer add operations
    - 8 bit integer add operations

We also need to measure dependent jumps:

    - unconditional jumps
    - taken conditional jumps
    - untaken conditional jumps

We also need to measure 

For each operation we need to measure two extremes:

    - independent: minimal dependency between sequential instructions
    - dependent: each instruction depends on the one before it

To compile:

    - make

To run:

    - make run

Files:

    - main.c - the main program
    - cstuff.c - put any C code you need here
    - sstuff.c - put any assemble code you need here

Hints:

    - You need to run the things you're measuring in a tight loop
    - Don't let other instructions pollute your measurements. For example, if
      you want to measure the "add" instruction, you don't want to mix it
      with lots of "mov" and "branch" instructions
    - Processors can and do run multiple instructions per cycle.
    - A dog chasing its tail is not always a bad idea
