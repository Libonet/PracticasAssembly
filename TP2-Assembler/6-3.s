.data
V: .byte 1, 10, 15, 20, 12, 50
cant: .byte 6
rango1: .byte 11
rango2: .byte 26
res: .space 1

.text
.globl main
main:
    lb $s3, cant
    lb $t1, rango1
    lb $t2, rango2
    la $t3, V
    li $t4, 0
loop1:
    lb $t0, ($t3)
    beq $t4, $s3, end1

    sge $s0, $t0, $t1 # V[] mayor que rango1
    sle $s1, $t0, $t2 # V[] menor que rango2
    and $s0, $s0, $s1

    sge $s1, $t0, $t2 # V[] mayor que rango2
    sle $s2, $t0, $t1 # V[] menor que rango1
    and $s1, $s1, $s2

    or $s0, $s0, $s1 # si se da uno de los 2 casos
    add $s4, $s4, $s0 # suma 1 si esta en el rango

    addi $t4, $t4, 1 # contador
    addi $t3, $t3, 1 # avanzo la lista
    j loop1
end1:
    sb $s4, res

    li $v0, 10
    syscall