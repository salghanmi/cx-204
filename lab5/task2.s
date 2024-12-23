.data 
n: .word 5

.text 
main: 
    lw a0, n    # Load base address of array into a0
    jal fractinal 
    li a0,1
    ecall
    li a0, 10       #Exit the program  
    ecall 
    
fractinal:    
    addi sp, sp, -16        # allocate a space in the stack 
    sw ra, 12(sp)
    sw s0, 8(sp)  #--> n  
    sw s1 , 0(sp)  # --> sum 
    
    mv s0, a0
    li s1, 1
    
    li t0, 1


For_Loop: 
    bge t0, s0 , End_Loop 
    mul s1, s1, t0
    addi t0, t0, 1
    j For_Loop

End_Loop: 
    mv a1, s1 
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp) 
    addi sp, sp, 16 
    jr ra 
  