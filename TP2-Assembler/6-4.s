.data
V: .asciiz "Lorem ipsum"
input: .ascii "m"
res: .word 0
.text
.globl main
main:
    la $s0, V
    lb $s1, input
loop1:
    lb $t0, ($s0) # tomo un caracter del string
    beq $t0, $0, end1
    bne $t0, $s1, nequal1 # si es distinto al input, no cuenta
    addi $s2, $s2, 1 # si es igual, lo cuenta
nequal1:
    addi $s0, $s0, 1 # avanza el string
    j loop1
end1:
    sw $s2, res

    li $v0, 10
    syscall