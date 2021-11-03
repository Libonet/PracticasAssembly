.data
V: .byte 1, 2, 3, 4, 5, 6, 7, 8, 9
dimensionN: .byte 3 # 3 filas
dimensionM: .byte 3 # 3 colummas
indiceI: .byte 2 # fila 2
indiceJ: .byte 3 # 3er elemento
res: .word 0

.text
.globl main
main:
    la $a0, V
    lb $a1, dimensionN
    lb $a2, dimensionM
    lb $a3, indiceI
    lb $t0, indiceJ
    addi $sp, $sp, -1 # reclamación de la pila
    sb $t0, ($sp)
    jal extractor
    sw $v0, res

    li $v0, 10
    syscall

extractor:
    lb $s0, ($sp)
    addi $sp, $sp, 1 # liberación de la pila
    
    li $v0, 0
    sge $t0, $a3, $0
    slt $t1, $a3, $a1
    and $t0, $t0, $t1
    beq $t0, $0, end1
    
    sgt $t0, $s0, $0
    sle $t1, $s0, $a2
    and $t0, $t0, $t1
    beq $t0, $0, end1

    mul $t0, $a1, $a3
    sub $t1, $a2, $s0
    sub $t0, $t0, $t1
    addi $t0, $t0, -1

    add $a0, $a0, $t0
    lb $v0, ($a0)
end1:
    jr $ra