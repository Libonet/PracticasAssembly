.data 0x10000000

vector_A: .space 80 # 4 bytes * 20 palabras
vector_B: .space 80

.text
.globl main

main:
    li $v0, 10
    syscall
.end