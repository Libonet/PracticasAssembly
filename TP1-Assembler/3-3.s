.data
palabra: .byte 0x40, 0x30, 0x20, 0x10
invertida: .byte 0x0, 0x0, 0x0, 0x0

.text
.globl main

main:
    lb $s0, palabra($0)
    lb $s1, palabra+1($0)
    lb $s2, palabra+2($0)
    lb $s3, palabra+3($0)

    sb $s3, invertida($0)
    sb $s2, invertida+1($0)
    sb $s1, invertida+2($0)
    sb $s0, invertida+3($0)

    li $v0, 10
    syscall
.end