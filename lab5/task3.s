.data
array: .word 5, 4, 8, 2, 1  # Input array
n: .word 5                  # Size of the array

.text
main:
    la a0, array            # Load base address of array into a0
    lw a1, n                # Load array size into a1
    jal bubbleSort          # Call the bubbleSort function

    li a0, 10               # Syscall for exit
    ecall

bubbleSort:
    addi sp, sp, -16        # Allocate space on stack
    sw ra, 12(sp)           # Save return address
    sw s0, 8(sp)            # Save s0 (base address)
    sw s1, 4(sp)            # Save s1 (array size)

    mv s0, a0               # s0 = base address of array
    mv s1, a1               # s1 = size of the array

    li t0, 0                # i = 0
Outer_Loop:
    sub t2, s1, t0          # t2 = n - i
    addi t2, t2, -1         # t2 = n - i - 1
    blez t2, End_BubbleSort # Exit if t2 <= 0

    li t1, 0                # j = 0
Inner_Loop:
    bge t1, t2, Next_Outer  # Exit inner loop if j >= n - i - 1
    slli t3, t1, 2          # t3 = j * 4 (word size)
    add t4, s0, t3          # t4 = &arr[j]
    lw t5, 0(t4)            # t5 = arr[j]
    lw t6, 4(t4)            # t6 = arr[j + 1]
    ble t5, t6, No_Swap     # Skip if arr[j] <= arr[j + 1]

    # Swap arr[j] and arr[j + 1]
    sw t6, 0(t4)            # arr[j] = arr[j + 1]
    sw t5, 4(t4)            # arr[j + 1] = arr[j]

No_Swap:
    addi t1, t1, 1          # j++
    j Inner_Loop            # Repeat inner loop

Next_Outer:
    addi t0, t0, 1          # i++
    j Outer_Loop            # Repeat outer loop

End_BubbleSort:
    lw ra, 12(sp)           # Restore return address
    lw s0, 8(sp)            # Restore s0
    lw s1, 4(sp)            # Restore s1
    addi sp, sp, 16         # Deallocate stack space
    jr ra                   # Return to caller
