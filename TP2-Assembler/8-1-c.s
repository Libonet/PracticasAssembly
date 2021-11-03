.data
V: .byte 3, 2, 3, 3, 5
cant: .byte 5
input: .byte 3
res: .word 0
.text
.globl main
main: # cargo las variables de ingreso en el stack
    la $t0, V
    lb $t1, cant
    lb $t2, input
    addi $sp, $sp, -6 # reclamación optima de la pila
    sw $t0, 2($sp)
    sb $t1, 1($sp)
    sb $t2, ($sp)
    jal calculador
    lb $v0, ($sp)
    addi $sp, $sp, 1
    sw $v0, res

    li $v0, 10
    syscall

calculador:
    li $t0, 0 # reinicio el valor de $t0 para usarlo como contador
    lw $s0, 2($sp)
    lb $s1, 1($sp)
    lb $s2, ($sp)
    addi $sp, $sp, 6 # liberación optima de la pila
loop1:
    lb $t1, ($s0) # cargo un valor de V
    beq $t0, $s1, end1
    bne $t1, $s2, nequal1 # si es distinto al input, no cuenta
    addi $t3, $t3, 1 # si es igual, lo cuenta
nequal1:
    addi $s0, $s0, 1 # avanzo la lista
    addi $t0, $t0, 1 # avanzo el contador
    j loop1
end1:
    move $v0, $t3
    addi $sp, $sp, -1
    sb $v0, ($sp)
    jr $ra