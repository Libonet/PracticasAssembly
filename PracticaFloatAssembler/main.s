.data
prompt1: .asciiz "\nIntroduzca un numero flotante: "
prompt2: .asciiz "Representacion hexadecimal: "
prompt3: .asciiz "\nRepresentacion binaria: "
prompt4: .asciiz "\nSigno: "
prompt5: .asciiz "\nExponente: "
prompt6: .asciiz "\nMantisa: "
hexa: .ascii "0x"
      .space 9
bin: .space 33
promptPositivo: .asciiz "Positivo"
promptNegativo: .asciiz "Negativo"

.text
.globl main
main: # En el main esta el input, las llamadas, y el output
    la $a0, prompt1 # "Introduzca un numero flotante: "
    li $v0, 4
    syscall
    li $v0, 6 # input
    syscall

    mfc1 $s0, $f0 # guardo el float para su uso posterior
    beq $s0, $0, endMain # si el ingreso es 0 se termina el programa

    # el ingreso de tomarBinaria es: a0 = numero; a1 = direccion de guardado
    move $a0, $s0
    la $a1, bin
    jal tomarBinaria # toma el numero y lo transforma a binario, lo guarda en "bin"
    # el ingreso de tomarHexadecimal es: a0 = numero; a1 = direccion de guardado
    la $a0, bin
    la $a1, hexa
    jal tomarHexadecimal # toma el numero (ya en binario) y lo transforma a hexadecimal, lo guarda en "hexa"

    la $a0, prompt2 # "Representacion hexadecimal: "
    li $v0, 4
    syscall
    la $a0, hexa # muestro el hexa
    li $v0, 4
    syscall
    
    la $a0, prompt3 # "Representacion binaria: "
    li $v0, 4
    syscall
    la $a0, bin # muestro el bin
    li $v0, 4
    syscall

    la $a0, prompt4 # "Signo: "
    li $v0, 4
    syscall
    # el ingreso de signo es: a0 = numero binario
    la $a0, bin
    jal signo # muestra el signo de un float en pantalla

    la $a0, prompt5 # "Exponente: "
    li $v0, 4
    syscall
    # el ingreso de exponente es: a0 = direccion numero float
    la $a0, bin
    jal exponente # muestra el exponente de un float en pantalla

    la $a0, prompt6 # "Mantisa: "
    li $v0, 4
    syscall
    # el ingreso de mantisa es: a0 = numero float
    move $a0, $s0
    jal mantisa # muestra la mantisa de un float en pantalla
    
    j main # retorno al main hasta el ingreso de un 0
endMain:
    li $v0, 10
    syscall

tomarHexadecimal: # devuelve el float (ya en binario) formateado a hexadecimal
    la $t0, 2($a1) # determina el principio del hexadecimal (y final del loop)
    addi $a1, $a1, 9 # determina el final del hexadecimal
    addi $a0, $a0, 31 # ubico el puntero al principio del binario
loop2: # en este loop se formatea en ascii el numero obtenido en el loop anidado
    blt $a1, $t0, end2

    li $t1, 0
    li $t3, 0
loopAnidado1: # tomo de a 4 bits (caracteres) para formar cada numero/letra del hexa
    beq $t1, 4, endAnidado1

    # transformo el ascii a 0/1 y lo desplazo hasta su posicion en la forma binaria (si 1 está en la 3ra posición, lo desplaza 3 veces a la izquierda lo que resulta en 0100. Esto se suma a los demás valores para formar el numero)
    lb $t2, ($a0) 
    addi $t2, $t2, -48 # diferencia entre el ascii de 0/1 con el propio 0/1
    sllv $t2, $t2, $t1
    add $t3, $t3, $t2

    addi $t1, $t1, 1 # el contador determina la cantidad de sll
    addi $a0, $a0, -1
    j loopAnidado1
endAnidado1:

    # si el numero es mayor o igual a 10 le suma 55 para tener el valor ascii de las letras
    bge $t3, 10, else1 
    addi $t3, $t3, 48 # si es menor a 10, se le suma 48 para obtener el valor ascii de los numeros
    j else2
else1:
    addi $t3, $t3, 55
else2:
    sb $t3, ($a1) # finalmente lo guardamos en "hexa" y seguimos al siguiente caracter
    addi $a1, $a1, -1
    j loop2
end2:
    jr $ra

tomarBinaria: # devuelve el float formateado a binario
    move $t0, $a1
    addi $a1, $a1, 31
    # para obtener los bits del float avanzamos por el numero usando srl, aplicandole la misma máscara en cada vuelta. De esta manera el and siempre devuelve 1 o 0
loop1: # se recorre al numero bit a bit y se lo guarda en "bin"
    blt $a1, $t0, end1 # el loop termina cuando el puntero es menor al espacio en memoria para bin
    andi $t1, $a0, 1
    addi $t1, $t1, 48 # transforma en ascii (0/1)
    sb $t1, ($a1)

    srl $a0, $a0, 1 # desplaza al numero hacia la derecha para aplicar la máscara a la siguiente posición
    addi $a1, $a1, -1
    j loop1
end1: 
    jr $ra

signo: # devuelve el signo
    lb $t0, ($a0)
    beq $t0, 48, out1 # si el signo es 0 (48 en ascii) devuelve "Positivo"
    la $a0, promptNegativo # si el signo es 1 (49 en ascii) devuelve "Negativo"
    li $v0, 4
    syscall
    j out2
out1: 
    la $a0, promptPositivo
    li $v0, 4
    syscall
out2:
    jr $ra

exponente: # devuelve el exponente
    li $t1, 0
    addi $a0, $a0, 8 # ubico al puntero al principio del exponente
    li $t3, 0
    
    # reutilizo el método para obtener los bits binarios de la funcion "hexadecimal"
loopAnidado2: # tomo los 8 bytes en ascii y los paso a bits
    beq $t1, 8, endAnidado2

    # transformo el ascii a 0/1 y lo desplazo hasta su posicion en la forma binaria (si 1 está en la 3ra posición, lo desplaza 3 veces a la izquierda lo que resulta en 0100. Esto se suma a los demás valores para formar el numero)
    lb $t2, ($a0) 
    addi $t2, $t2, -48 # diferencia entre el ascii de 0/1 con el propio 0/1
    sllv $t2, $t2, $t1
    add $t3, $t3, $t2

    addi $t1, $t1, 1 # el contador determina la cantidad de sll
    addi $a0, $a0, -1
    j loopAnidado2
endAnidado2:
    addi $t3, $t3, -127 # des-normalizo el exponente
    move $a0, $t3 # finalmente muestro el resultado como un int
    li $v0, 1
    syscall

    jr $ra

    # Tratando de usar el mismo método que con binario, pero no funcionó
#     la $t0, 1($a1)
#     addi $a1, $a1, 8
#     li $t1, 0
#     li $t2, 0
#     li $t3, 0
#     # para obtener los bits del float avanzamos por el numero usando srl, aplicandole la misma máscara en cada vuelta. De esta manera el and siempre devuelve 1 o 0
# loop3: # se recorre al numero bit a bit y se lo guarda en "bin"
#     blt $a1, $t0, end3 # el loop termina cuando el puntero es menor al espacio en memoria para bin
#     andi $t1, $a0, 1
#     sllv $t1, $t1, $t3
#     add $t2, $t2, $t1

#     addi $t3, $t3, 1
#     addi $a1, $a1, -1
#     j loop3
# end3: 
#     addi $t3, $t3, -127 # des-normalizo el exponente
#     move $a0, $t3 # finalmente muestro el resultado como un int
#     li $v0, 1
#     syscall
#     jr $ra
mantisa: # devuelve la mantisa
    # cambio el exponente a 0 (01111111) para que el syscall 2 muestre únicamente la mantisa
    li $t0, 0x3FFFFFFF # 00111111111111111111111111111111
    and $t1, $a0, $t0
    li $t0, 0x3F800000 # 00111111100000000000000000000000
    or $t1, $t1, $t0

    mtc1 $t1, $f12
    li $v0, 2
    syscall
    jr $ra