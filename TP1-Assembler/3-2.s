.data 0x10000000

vector_V: .word 10, 20, 25, 500, 3

;.data 0x10010000
;vector_copia_V: .word 0, 0, 0, 0, 0 otra opción medio rara
;vector_copia_V: .data 0x10010000

.text
.globl main

main:
    la $s5, 0x10010000

    lw $s0, vector_V($0)
    lw $s1, vector_V+4($0)
    lw $s2, vector_V+8($0)
    lw $s3, vector_V+12($0)
    lw $s4, vector_V+16($0)

    sw $s0, ($s5)
    sw $s1, 4($s5)
    sw $s2, 8($s5)
    sw $s3, 12($s5)
    sw $s4, 16($s5)

    li $v0, 10
    syscall
.end