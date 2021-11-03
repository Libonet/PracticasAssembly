.data
V: .byte 5, 0, 2, 0, (-3), (-4), 0
cant: .byte 7
total: .byte 0

.text
.globl main
main:
    lb $s0, cant # cargo la cantidad
    la $s1, V # y la direccion de V
loop1:
    lb $t3, ($s1)
    beq $t0, $s0, end1
    bne $t3, $0, nequal0 # si el valor de V no es 0, no cuenta
    addi $t1, $t1, 1 # si es 0, lo cuenta
nequal0:
    addi $s1, $s1, 1 # avanzo la lista
    addi $t0, $t0, 1 # avanzo el contador
    j loop1
end1:
    sb $t1, total
    
    li $v0, 10
    syscall