.data
numerito: .word 0xabcd

.text
.globl main
main:
    li $a0, 4
    jal factorial
    sw $v0, numerito

    li $v0, 10
    syscall

factorial: # dado un n1, n2 devuelve (n1+n2) + 2*(n1-1)
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, ($sp)
    beq $a0, 1, salida
    addi $a0, $a0, -1 # calculo recursivo
    jal factorial
    lw $a0, ($sp)
    mul $v0, $v0, $a0
    j salida2
salida: # caso base
    li $v0, 1
salida2: # salida
    lw $ra, 4($sp)
    lw $a0, ($sp)
    addi $sp, $sp, 8
    jr $ra
.end