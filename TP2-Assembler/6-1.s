.data
dato1: .byte 2
dato2: .byte 10
dato3: .byte 50
dato4: .byte 70
dato5: .byte 34
res: .word 0

.text
.globl main
main:
    lb $t0, dato5
    lb $t1, dato1
    lb $t2, dato2

    sge $s0, $t0, $t1 # dato5 mayor que dato1
    sle $s1, $t0, $t2 # dato5 menor que dato2
    and $s0, $s0, $s1

    sge $s1, $t0, $t2 # dato5 mayor que dato2
    sle $s2, $t0, $t1 # dato5 menor que dato1
    and $s1, $s1, $s2

    or $s0, $s0, $s1 # si se da uno de los 2 casos

    lb $t3, dato3
    lb $t4, dato4

    sge $s1, $t0, $t3 # dato5 mayor que dato3
    sle $s2, $t0, $t4 # dato5 menor que dato4
    and $s1, $s1, $s2

    sge $s2, $t0, $t4 # dato5 mayor que dato4
    sle $s3, $t0, $t3 # dato5 menor que dato3
    and $s2, $s2, $s3

    or $s1, $s1, $s2 # si se da uno de los 2 casos

    or $s0, $s0, $s1 # si al menos 1 se da devuelve 1
    sw $s0, res

    li $v0, 10
    syscall