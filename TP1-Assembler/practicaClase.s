.data
# num1 = 10010000 
# num2 = 10010004
# num3 = 10010008
num1: .word 6 # 0110
num2: .word 2 # 0010
num3: .word 0
msg: .asciiz "La salida de la suma es: "
msg1: .asciiz "\nLa salida de la suma logica (or) es: "

.text
main:
    ;lw $t0, num1($0) esta es la mejor forma de las 2 lineas de abajo
    la $t3, num1
    lw $t0, 0($t3)

    ;lw $t1, num2($0)
    lw $t1, num1+4($0)

    add $t2, $t0, $t1

    ;sw $t2, num3($0)
    sw $t2, 8($t3)

    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    lw $a0, num3($0)
    syscall

    or $t2, $t0, $t1

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall
.end