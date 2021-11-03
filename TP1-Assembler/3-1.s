.data 0x10000000

vector_V: .word 10, 20, 25, 500, 3

.text
.globl main

main:
    lw $s0, vector_V
    lw $s1, vector_V+4
    lw $s2, vector_V+8
    lw $s3, vector_V+12
    lw $s4, vector_V+16

    li $v0, 10
    syscall
.end