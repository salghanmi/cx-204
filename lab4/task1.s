.data 
myString0: .string "Equal\n"
myString1: .string "Not Equal\n"

.text 
.globl main

main: 
    li x10, 5      # int x == 5 
    li x11, 10     # int y == 10

    bne x10, x11, ELSE 
    li a7, 64       # syscall number for write
    li a0, 4        # a0 = 1 for stdout
    la a1, myString0 # Load address of "Equal\n"
    li a2, 7        # Length of "Equal\n"
    ecall          # Perform the system call

    j EXIT         # Jump to exit to avoid falling through

ELSE:
    li a7, 64       # syscall number for write
    li a0, 4        # a0 = 1 for stdout
    la a1, myString1 # Load address of "Not Equal\n"
    li a2, 10       # Length of "Not Equal\n"
    ecall          # Perform the system call

EXIT:
    li a7, 93       # syscall number for exit
    li a0, 0        # Exit code 0
    ecall          # Perform exit system call

