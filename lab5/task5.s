.data
n: .word 6                 # Input value for Fibonacci calculation

.text
main:
    lw a0, n               # Load the value of n into a0
    jal fibonacci          # Call the Fibonacci function
    li a0, 1               # Syscall for print integer
    ecall

    li a0, 10              # Syscall for exit
    ecall

fibonacci:
    addi sp, sp, -12       # Allocate stack space
    sw ra, 8(sp)          # Save return address
    sw s0, 4(sp)           # Save s0 (current value of n)

    mv s0, a0              # Move input (n) to s0
    li t0, 1               # t0 = 1
    ble s0, t0, Base_Case  # If n <= 1, return n (base case)

    # Recursive call: fibonacci(n - 1)
    addi a0, s0, -1        # a0 = n - 1
    jal fibonacci          # Call fibonacci(n - 1)
    sw a1, 0(sp)
    # Recursive call: fibonacci(n - 2)
    addi a0, s0, -2        # a0 = n - 2
    jal fibonacci          # Call fibonacci(n - 2)
    mv t2, a1              # Store result of fibonacci(n - 2) in t2
    
    lw t1, 0(sp)

    add a1, t1, t2         # a1 = fibonacci(n - 1) + fibonacci(n - 2)
    j End_Fibonacci        # Jump to the end

Base_Case:
    mv a1, s0              # a1 = n (base case result)

End_Fibonacci:
    lw ra, 8(sp)          # Restore return address
    lw s0, 4(sp)           # Restore s0
    addi sp, sp, 12        # Deallocate stack space
    jr ra                  # Return to caller
