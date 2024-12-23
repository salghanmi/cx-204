 .data
N: .word 5           
space: .byte 32      # (' ')
star: .byte 42       #  ('*')
newline: .byte 10    # ('\n')

.text
_start:
    lw t0, N          
    li t1, 1           

outer_loop:
    bgt t1, t0, end    

    # Print spaces: for (j = 1; j <= N - i; j++)
    sub t2, t0, t1     
    li t3, 1           
space_loop:
    bgt t3, t2, star_loop # Exit space loop if j > N - i
    lb a1, space
#     li a0, ' '
    li a0, 11          
    ecall
    addi t3, t3, 1     # j++
    j space_loop       
    
    # Print stars: for (j = 1; j <= 2 * i - 1; j++)
star_loop:
    li t3, 1           
    slli t4, t1, 1     # t4 = 2 * i
    addi t4, t4, -1    # t4 = 2 * i - 1
star_loop_cond:
    bgt t3, t4, print_newline # Exit star loop if j > 2 * i - 1
    lb a1, star        
    li a0, 11          
    ecall
    addi t3, t3, 1     # j++
    j star_loop_cond   

print_newline:
    lb a1, newline     
    li a0, 11          
    ecall
    addi t1, t1, 1     # i++
    j outer_loop       

end:
    li a0, 10          
    ecall
    
    
    
    