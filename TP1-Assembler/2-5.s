.data 0x10010000

filas_A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9
columnas_A: .word 1, 4, 7, 2, 5, 8, 3, 6, 9


.text
.globl main

main:
    li $v0, 10
    syscall
.end