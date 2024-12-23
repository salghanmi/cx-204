.data 
array: .word

.text 
main: 

li x10 0 # i=0 
la t0, array  # load base address for array 

Loop: 
    li x7 101 # limit 100 into x6 
    bge  x10, x7, Exit # Exit if i >= 100
    sw x10 , 0(t0) # Store value in the current register 
    addi t0, t0 ,4 # Address t0 increment 
    addi x10, x10, 1 # i =i+1
    j Loop 
Exit: 
    li x10, 0 
    ecall 