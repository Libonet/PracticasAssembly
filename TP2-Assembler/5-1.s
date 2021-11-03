.data
V: .byte 0, 1, 1, 1, 0
res: .space 3

.text
.globl main
main:
    lb $t0, V # V[1] and V[5]
    lb $t1, V+4
    and $t0, $t0, $t1
    sb $t0, res+0

    lb $t0, V+1 # V[2] or V[4]
    lb $t1, V+3
    or $t0, $t0, $t1
    sb $t0, res+1

    lb $t0, V # (V[1] or V[2]) and V[3]
    lb $t1, V+1
    lb $t2, V+2
    or $t0, $t0, $t1
    and $t0, $t0, $t2
    sb $t0, res+2

    li $v0, 10
    syscall