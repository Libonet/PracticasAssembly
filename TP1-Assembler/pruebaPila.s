# $sp es el "stack pointer" (puntero de pila)
# lw y sw se utilizan para almacenar palabras y 
# lb y sb para almacenar bytes. (se puede, pero es peligroso)
# guardar bytes en la pila es problemático porque la pila tiene que estar alineada
# y el sistema operativo no lo hace automáticamente

# la pila es una estructura que siempre debe soportar 2 operaciones
# esas operaciones son: push y pop
# push significa empujar y pop significa extraer
# push agrega un libro arriba y pop saca un libro arriba
# si quiero sacar el libro de abajo tengo que sacar todos los de arriba


# IMPORTANTE:
# la pila en este procesador (mips R2000) crece en direcciones decrecientes
# (el ultimo elemento tiene una dirección menor)

# push($s0)
addi $sp, $sp, -4 # reclamación de la pila
sw $s0, ($sp)

# pop($s0)
lw $s0, ($sp)
addi $sp, $sp, 4 # liberación de la pila

# push($s0) en intel
# push($s1)
addi $sp, $sp, -4
sw $s0, ($sp)
addi $sp, $sp, -4
sw $s1, ($sp)

# push($s0) optimizado
# push($s1)
addi $sp, $sp, -8
sw $s0, 4($sp)
sw $s1, ($sp)

# pop($s0) optimizado
# pop($s1)
lw $s0, 4($sp)
lw $s1, ($sp)
addi $sp, $sp, 8 # liberación de la pila

# push($s0)
# push($s1)
# pop($s1)
# pop($s0)
# lo que acabo de hacer es un swap($s0, $s1)
addi $sp, $sp, -8
sw $s0, 4($sp)
sw $s1, ($sp)
lw $s1, 4($sp)
lw $s0, ($sp)
addi $sp, $sp, 8