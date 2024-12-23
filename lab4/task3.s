
    .data
vector1: .byte 1, 2, 3, 4, 5, 6, 7, 8         # Array of unsigned characters
vector2: .byte 9, 10, 11, 12, 13, 14, 15, 16  # Array of unsigned characters
result:  .space 32                            # Space for 8 integers (4 bytes each)

    .text
    .globl main
main:
    la t0, vector1        # Load address of vector1 into t0
    la t1, vector2        # Load address of vector2 into t1
    la t2, result         # Load address of result into t2
    li t3, 0              # Initialize index i = 0

loop:
    li t6, 8              # stop value 
    bge t3, t6, exit      # If i >= 8, jump to exit

    lbu t4, 0(t0)         # Load unsigned byte from vector1[i]
    lbu t5, 0(t1)         # Load unsigned byte from vector2[i]
    add t4, t4, t5        # Add the bytes from vector1 and vector2
    sw t4, 0(t2)          # Store the result as an integer in result[i]

    addi t0, t0, 1        # Increment the pointer to the next byte of vector1
    addi t1, t1, 1        # Increment the pointer to the next byte of vector2
    addi t2, t2, 4        # Increment the pointer to the next integer of result
    addi t3, t3, 1        # Increment index i by 1
    j loop                # Jump back to the start of the loop

exit:
    li a7, 10             # Prepare to exit by setting syscall number 10 (exit)
    ecall                 # Make a syscall to exit the program
