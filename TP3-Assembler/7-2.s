.data
Nombre: .space 10
Apellidos: .space 15
DNI: .word 0
promptNombre: .asciiz "Introduzca el nombre: "
promptApellidos: .asciiz "Introduzca el apellido: "
promptDNI: .asciiz "Introduzca el DNI: "

.text
.globl main
main:
    li $v0, 4
    la $a0, promptNombre
    syscall
    li $v0, 8
    la $a0, Nombre
    syscall

    li $v0, 4
    la $a0, promptApellidos
    syscall
    li $v0, 8
    la $a0, Apellidos
    syscall

    li $v0, 4
    la $a0, promptDNI
    syscall
    li $v0, 5
    syscall
    sw $v0, DNI

    li $v0, 4
    la $a0, Nombre
    syscall

    li $v0, 4
    la $a0, Apellidos
    syscall

    lw $a0, DNI
    li $v0, 1
    syscall

    li $v0, 10
    syscall