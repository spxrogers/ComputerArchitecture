Objective:
~~~~~~~~~~

Learn how to reason about the impact of instruction selection on performance


Deliverables:
~~~~~~~~~~~~~

You're asked to make an educated guess about the expected performance of
a program, finish its implementation, then explain the actual performance.

- edit the file named GUESS and try to guess the missing information. Your
  score will not depend on your guess.

- finish the implementation

- edit the file named EXPLAIN and do your best to explain the actual results.

Assignment:
~~~~~~~~~~~

You need to finish the implementation of two x86-32 assembly functions:
"count1" and "count2"

    int count1(int array[], int size, int limit);
    int count2(int array[], int size, int limit);

Where:

   array         is an array of integers
   size          specifies the number of integers in the array
   limit         is some integer value

Both count1 and count2 return the number of array elements that are less
than the given limit.

Restrictions:
~~~~~~~~~~~~~

count1 is not allowed to use the "cmov" family of instructions

count2 can have a maximum of one conditional jump in its implementation and
       is required to use a "cmov" instruction in its implementation


The test driver
~~~~~~~~~~~~~~~

The test program fills a large array with random values between 0 and 9 then
calls your test functions with limits of 0, 1, 2, ..., 10.

It then prints a table that shows:

- the limit
- ratio of array elements that are less than limit
- an estimate for the number of nano-seconds per iteration in your
  implementation 

   
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


Correct output:
~~~~~~~~~~~~~~~

A correct implementation will produce output similar to the following. The
question marks will have values specific to your imlpementation.

without cmov
value ratio ns/iteration
    0  0.00         ?
    1  0.10         ?
    2  0.20         ?
    3  0.30         ?
    4  0.40         ?
    5  0.50         ?
    6  0.60         ?
    7  0.70         ?
    8  0.80         ?
    9  0.90         ?
   10  1.00         ?

with cmov
value ratio ns/iteration
    0  0.00         ?
    1  0.10         ?
    2  0.20         ?
    3  0.30         ?
    4  0.40         ?
    5  0.50         ?
    6  0.60         ?
    7  0.70         ?
    8  0.80         ?
    9  0.90         ?
   10  1.00         ?

