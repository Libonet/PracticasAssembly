.data 0x10010002

espacio: .space 4
bytes: .byte 0x10, 0x20, 0x30, 0x40

.data 0x10010010
palabra: .space 4

.text
.globl main

main:
    lb $s1, bytes($0)
    lb $s2, bytes+1($0)
    lb $s3, bytes+2($0)
    lb $s4, bytes+3($0)

    sb $s1, palabra($0)
    sb $s2, palabra+1($0)
    sb $s3, palabra+2($0)
    sb $s4, palabra+3($0)

    li $v0, 10
    syscall
.end