.data
conteudo: .asciiz "O conteudo do Array e: \n"
lista: .word 4,3,-2,1,27,45,47
coiso: .asciiz ";"
.text
main:
	# print_str ("O conteudo do Array é: \n");
	li $v0, 4
	la $a0, conteudo
	syscall
	
	# i = 0
	addi $t0, $0, 0
	
	# a1 = lista[0]
	la $a1, lista
	
	# Inicio do for
for:
	bgt $t0, 6, exitfor
	addi $t1, $t0, 0
	sll $t1, $t1, 2 	# t1 = 4i
	addu $a2, $a1, $t1 	# a2 = lista + 4i
	lw $a0, 0($a2)
	
	# print(lista[i])
	li $v0, 1
	syscall
	
	# meter um -
	la $a0, coiso
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1	# i++
	
	j for
exitfor:
	# Terminar o programa
	li $v0, 10
	syscall
