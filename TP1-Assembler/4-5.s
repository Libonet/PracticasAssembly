.data 0x10000000
numero: .word 0x1237

.text
.globl main

main: # multiplica el numero por 2^5
    ; lw $s1, numero
    ; sll $s2, $s1, 5
    
    lw $s1, numero # cargo el numero
    li $s3, 0

    li $s0, 32 # 2^5
    li $s4, 0 # contador del bucle
loop1: 
    beq $s0, $s4, done1 # if $s0 = $s4 jump to "done"

    add $s3, $s3, $s1 # sumo 32 veces

    addi $s4, $s4, 1 # $s4++
    j loop1 # vuelve a loop1
done1:

    li $v0, 10
    syscall
.end