.data
prompt1: .asciiz "Introduza um numero\n"
result: .asciiz "O fatorial do numero inserido e: "
.text
main:
	# Print do prompt
	li $v0, 4
	la $a0, prompt1
	syscall
	
	# Pedir o valor de n
	li $v0, 5
	syscall
	move $a0, $v0 # $a0 = num
	
	# chamar a funcao
	jal fatorial
	move $t0, $v0
	
	# print result
	li $v0, 4
	la $a0, result
	syscall
	
	move $a0, $t0
	
	# print valor
	li $v0, 1	# print_int10
	syscall
	
	# termina programa
	li $v0, 10
	syscall
	
fatorial:
	move $t0, $a0 	# i = num
	li $v0, 1 	# res = 1
	
	for:
		blez $t0, fimfor
		mul $v0, $v0, $t0 	# res = res*i
		sub $t0, $t0, 1 	# i--
		j for
	fimfor:
		jr $ra 			# da return das cenas
	
	
	
