.data
V: .byte 2, -4, -6
res: .space 3

.text
.globl main
main:
    lb $t0, V # greater or equal de V
    sge $t0, $t0, $0 
    sb $t0, res

    lb $t0, V+1 # greater or equal de V+1
    sge $t0, $t0, $0
    sb $t0, res+1

    lb $t0, V+2 # greater or equal de V+2
    sge $t0, $t0, $0
    sb $t0, res+2

    li $v0, 10
    syscall