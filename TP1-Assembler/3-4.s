.data 0x10000000
palabras: .word 0xF0203040

.text
.globl main

main:
    la $t0, palabras

    lh $t1, 0($t0)
    lh $t2, 2($t0)

    sh $t1, 2($t0)
    sh $t2, 0($t0)

    li $v0, 10
    syscall
.end