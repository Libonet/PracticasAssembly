.data
V: .byte 1, -4, -5, 2
res: .space 1

.text
.globl main
main:
    lb $t0, V # cargo las variables
    lb $t1, V+1
    lb $t2, V+2
    lb $t3, V+3

    slt $t0, $t0, $0 # calculo si son menores a 0
    slt $t1, $t1, $0
    slt $t2, $t2, $0
    slt $t3, $t3, $0

    and $t0, $t0, $t1 # hago un and de todas las variables
    and $t0, $t0, $t2 # si todas dan 1,
    and $t0, $t0, $t3 # entonces todas son menores a 0

    sb $t0, res

    li $v0, 10
    syscall