.data
palabra: .word 3
byte: .byte 0x10
      .align 2
espacio: .space 4
veinte_byte: .byte 20

.text
.globl main

main:
    li $v0, 10
    syscall
.end