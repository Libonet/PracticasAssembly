.data
V: .byte 1, 2, 4, 8, 16
cant: .byte 5
input: .byte 4
res: .word 0

.text
.globl main
main:
    la $a0, V
    lb $a1, cant
    lb $a2, input

    jal extractor
    sw $v0, res

    li $v0, 10
    syscall

extractor:
    li $v0, 0
    sge $t0, $a2, $0
    slt $t1, $a2, $a1
    and $t0, $t0, $t1
    beq $t0, $0, end1

    add $a0, $a0, $a2
    
    lb $v0, ($a0)
end1:
    jr $ra