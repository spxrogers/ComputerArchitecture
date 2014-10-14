Assignment:
~~~~~~~~~~~

    Practice your memory management skills by implementing a simple, in-kernel,
page mapping, unmapping, and fault handling.

    Your assignment if to finish the implementation of the vmm API defined in
kernel/vmm.h.

        - void pageFault       -- called when a page-fault occurs. Should
                                  allocate a new frame, fill it with zero,
                                  then map it to the faulting va
        - void vmm_map(va, pa) -- map the given virtual address to the given
                                  physical address (both page aligned)
        - uint32_t vmm_frame() -- allocate an available physical memory frame
                                  and return its PA
        - void vmm_unmap(va)   -- unmap the given va
        - int vmm_dirty(va)    -- return 1 if the page containing the va is
                                  dirty, 0 otherwise
        - int vmm_accessed(va) -- return 1 if the page containing the va is
                                  accessed, 0 otherwise
        - uint32_t vmm_pa(va)  -- return the PA to which the VA is mapped,
                                  0xffffffff if it's not mapped

You will be developing part of an operating system kernel and as a result,
the programming environment will be strange and unfamiliar.

    * User-level code doesn't have direct access to the MMU
    * Your code has to run in supervisor state
    * You can't do that on a shared machine and, even if you could, debugging
      is very hard
    * We use an emulator (qemu), which is a user-level program that emulates
      hardware
    * We also have to build the code in a special way because it will be
      running as the operating system kernel
    * You could will not have the benefit of an operating system because it
      is the operating system so simple things like: printf, malloc, etc, are
      not available to you

You don't have to understand most of those intricate details (you'll learn
them all in 439) and you can focus your attention on two files:

    * kernel/vmm.c where you need to add the missing mode (marked by MISSING())
    * kernel/kernel.c where the tests are run

Here are some functions that might be useful:

    * sayHex: print a string and a hex value
    * putHex: print a hex value
    * putStr: print a string
    * getPD(): return a pointer to the PD (page-directory)
    * vmm_dump(): dump the contents of the MMU (the PD and any valid PT)

Simplifying assumptions
~~~~~~~~~~~~~~~~~~~~~~~

- we always run in supervisor mode

- the machine has 2M of physical memory

- the kernel uses physical memory in the range 0 to 1M, the rest is available
  for allocation

- all mappings are RW

- all allocated frames are zero-filled

- a page fault is resolved by allocating a zero-filled frame, mapping it to
  the faulted VA and retrying the faulted instruction

- kernel/kernel.c contains the kernel entry point and the testing
  code (leave it alone)

- you're free to add, remove, or modify other files
                            
To compile:
~~~~~~~~~~~

    make

To look at the output:
~~~~~~~~~~~

    make run

To run test:
~~~~~~~~~~~~

    make test

To make the output less noisy:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    make -s test

To run by hand
~~~~~~~~~~~~~~

    make
    qemu -nographic --serial mon:stdio -hdc kernel/kernel.img

To attach with gdb
~~~~~~~~~~~~~~~~~~

It's a good idea to change the -O3 to -O0 in common.mak if you want to debug
with gdb

    make
    qemu -S -s -nographic --serial mon:stdio -hdc kernel/kernel.img

  then in another window

    > gdb kernel/kernel
    (gdb) target remote localhost:1234
    (gdb) # define breakpoint, etc
    (gdb) cont

Files:
~~~~~~

    test.ok         -- expected output
    test.out        -- your output
    kernel/vmm.c    -- the only file you're allowed to change
    kernel/kernel.c -- the kernel entry and the test cases
    kernel/mbr.S    -- the bootstrap code (the code that runs when the machine
                       starts)
    kernel/*        -- the rest of the kernel code
    e0.tcl          -- test script

