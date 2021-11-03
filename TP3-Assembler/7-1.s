.data
promptA: .asciiz "Introduzca el valor A: "
promptB: .asciiz "Introduzca el valor B: "
promptRes: .asciiz "A + B = "
.text
.globl main
main:
    li $v0, 4
    la $a0, promptA
    syscall
    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 4
    la $a0, promptB
    syscall
    li $v0, 5
    syscall
    move $s1, $v0

    add $s0, $s0, $s1

    li $v0, 4
    la $a0, promptRes
    syscall
    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 10
    syscall