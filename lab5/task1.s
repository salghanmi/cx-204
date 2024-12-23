.data 
array: .word 1,2,3,4,5,6,7,8,9

.text 
main: 
    la a0, array    # Load base address of array into a0
    li a1, 9        # Size of the array 
    jal sumArray
    li a0,1
    ecall
    
    
    li a0, 10       #Exit the program  
    ecall 
    

sumArray: 
    addi sp, sp, -16        # allocate a space in the stack 
    sw ra, 12(sp)
    sw s0, 8(sp)  #--> Address 
    sw s1, 4(sp)  #--> array size 
    sw s2 , 0(sp)  # --> sum 
    
    mv s0, a0  # Sava array address in s0
    mv s1, a1  # Save the array size in s1 
    mv s2 , x0 # sum =0 
    li t0, 0    # index i =0 

sum_Loop: 
    bge t0, s1 , End_Loop 
    slli t1 , t0, 2
    add t2 , s0, t1 
    lw a1, 0(t2)
    add s2, a1 ,s2
    addi t0, t0, 1
    j sum_Loop

End_Loop: 
    mv a1, s2 
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp) 
    lw s2, 0(sp)
    addi sp, sp, 16 
    jr ra 