.data 0x10001000
palabras: .word 0x11 # numeros arbitrarios para que QtSpim los muestre
byte: .byte 0x22
otraPalabra: .word 0x33 # No hace falta align porque word alinea solo


.text
.globl main

main:
    li $v0, 10
    syscall
.end