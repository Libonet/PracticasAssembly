.data
numerito: .word 0xabcd

.text
.globl main
main:
    li $a0, 3
    li $a1, 2
    jal codigo
    sw $v0, numerito

    li $v0, 10
    syscall

codigo: # dado un n1, n2 devuelve (n1+n2) + 2*(n1-1)
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, ($sp)
    addi $a0, $a0, -1
    jal codigo2
    lw $a0, ($sp)
    add $t0, $a0, $a1
    add $v0, $v0, $t0
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra

codigo2:
    sll $v0, $a0, 1
    jr $ra
.end