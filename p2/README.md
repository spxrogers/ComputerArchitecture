Objective:
~~~~~~~~~~

Practice your x86 assembly skills by manipulating stacks and pointers

Assignment:
~~~~~~~~~~~

You need to finish the implementation of two functions: check and reverse

You should be able to clone, compile, test, and push on either Linux or
MacOS but your final submission needs to work correctly on the CS Linux
machines.

int check(Node* head);
void reverse(Node* head);

"check" takes a single argument which is a pointer to the first node in
a linked list and returns an integer value. The returned value is either:

    * -1 if the list contains a cycle (loops on itself)
    * number of nodes in the list if the list is linear (doesn't contain
      a cycle)

You can't make any assumptions about the number of nodes in the list.

There is a neat trick to help you find a cycle in a linked list. Please
feel free to discuss the algorithm on Piazza without sharing code.

"reverse" takes a single argument which is a pointer to the first node
in a linked list and reverses the contents of the list in-place by replacing
the values in the nodes not by manipulating the pointers.

For example, if the original list contained [1, 2, 3], calling reverse on
the list will move the values around and make it contain [3, 2, 1]

Each node in the list contains 8 bytes. The first 4 bytes are a pointer to
the next node in the list and next 4 contain an integer value.

Files you're allowed to change:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   func.s     -- contains the implementation of check and reverse

Files you're supposed to leave alone:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   Makefile   -- rules for compiling and running the program
   prog.c     -- the main program
   
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
