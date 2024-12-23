.data
a:      .word 5                   #  a = 5
b:      .word 6                   #  b = 6
result: .word 0                   # Result = 0

.text
.globl main

main:
    la a0, a                     # Load address of a
    la a1, b                     # Load address of b
    la a2, result                # Load address of result
    lw t0, 0(a0)                 # Load value of a into t0
    lw t1, 0(a1)                 # Load value of b into t1
    lw t2, 0(a2)                 # Load value of result into t2

loop:
    bnez t1, check               # If b != 0, continue; else, end loop
    j done
check:
    andi t3, t1, 1               # Check if least significant bit of b is 1
    bnez t3, add_result          # If LSB == 1, add a to result
    j update_values
add_result:
    add t2, t2, t0               # Add a to result= result + a
    j update_values

update_values:
    slli t0, t0, 1               # Double the value of a
    srli t1, t1, 1               # Halve the value of b
    j loop

done:
    sw t2, 0(a2)                 # Store final result back to memory

    li a7, 10                    # Prepare for exit syscall
    ecall                        # System call to exit



