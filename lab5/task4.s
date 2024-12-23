.data
n: .word 5                 # Input value for factorial calculation

.text
main:
    lw a0, n               # Load the value of n into a0
    jal factorial          # Call the factorial function
    mv a0, a1              # Move the result to a0 for printing
    li a0, 1               # Syscall for print integer
    ecall

    li a0, 10              # Syscall for exit
    ecall

factorial:
    addi sp, sp, -16       # Allocate stack space
    sw ra, 12(sp)          # Save return address
    sw s0, 8(sp)           # Save s0 (current value of n)

    mv s0, a0              # Move input (n) to s0
    li t0, 1               # t0 = 1
    ble s0, t0, Base_Case  # If n <= 1, return 1 (base case)

    addi a0, s0, -1        # a0 = n - 1
    jal factorial          # Recursive call: factorial(n - 1)
    mv t1, a1              # Store result of factorial(n - 1) in t1
    mul a1, s0, t1         # a1 = n * factorial(n - 1)
    j End_Factorial        # Jump to the end

Base_Case:
    li a1, 1               # a1 = 1 (base case result)

End_Factorial:
    lw ra, 12(sp)          # Restore return address
    lw s0, 8(sp)           # Restore s0
    addi sp, sp, 16        # Deallocate stack space
    jr ra                  # Return to caller
