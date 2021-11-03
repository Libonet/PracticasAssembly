.data 0x10000010

entero: .word 0xABCD12BD # 1010 1011 1100 1101 0001 0010 1011 1101

.text
.globl main

main:
    lw $s0, entero
    li $t0, 0x144 # 1 en 3, 7, 9

    not $s1, $t0
    and $s2, $s0, $s1

    # and $s3, $s0, 0xfffffebb

    # andi $s4, $s0, 0xfebb

    li $v0, 10
    syscall
.end