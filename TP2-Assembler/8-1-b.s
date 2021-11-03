.data
V: .byte 3, 2, 3, 4, 5
cant: .byte 5
input: .byte 3
res: .word 0
.text
.globl main
main: 
    la $a0, V # cargo las direcciones de variables de ingreso
    la $a1, cant
    la $a2, input
    jal calculador
    sw $v0, res

    li $v0, 10
    syscall

calculador:
    li $v0, 0 # reinicio el valor de $v0 para usarlo como output
    lb $t2, ($a1) # cargo la cantidad de valores
    lb $t3, ($a2) # cargo el input
loop1:
    lb $t1, ($a0) # cargo un valor de V
    beq $t0, $t2, end1
    bne $t1, $t3, nequal1 # si es distinto al input, no cuenta
    addi $s0, $s0, 1 # si es igual, lo cuenta
nequal1:
    addi $a0, $a0, 1 # avanzo la lista
    addi $t0, $t0, 1 # avanzo el contador
    j loop1
end1:
    move $v0, $s0
    jr $ra