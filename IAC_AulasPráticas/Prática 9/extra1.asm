.data
prompt1: .asciiz "Introduza um numero: "
prompt2: .asciiz "Introduza uma potencia: "
result: .asciiz "A potencia do numero inserido é: "
.text

main:
	# Print do prompt 1
	li $v0, 4
	la $a0, prompt1
	syscall				# syscall print_string
	
	# Pedir o valor de num
	li $v0, 5
	syscall				# syscall read_int
	
	move $a0, $v0 			# $a0 = $v0 = num
		
	# Pedir o valor da potencia
	li $v0, 5
	syscall				# syscall read_int
	move $a1, $v0 			# $a1 = $v0 = potencia

	# chamada da função recursiva
	jal	x_to_y			# call function
	move 	$t0, $v0
	
	# print result
	li $v0, 4
	la $a0, result
	syscall				# syscall print_string
	
	move $a0, $t0
	
	# print valor
	li $v0, 1
	syscall				# syscall print_int10
	
	
end:	li	$v0, 10			# syscall exit
	syscall
	

x_to_y:
	beq	$a1, 0, return1		# if(exp==0) goto return1
	
	addiu	$sp, $sp, -4		# make space in stack
	sw	$ra, 0($sp)		# save $ra in the stack
	
	addi	$a1, $a1, -1		# exp - 1
	jal	x_to_y
	mul	$v0, $a0, $v0		# $v0 = $v0 * $a0
	
	exit:	
		lw	$ra, 0($sp)	# restore $ra
		addi	$sp, $sp, 4	# deallocate stack space
		jr	$ra		# return to caller
		
	return1:
		li	$v0, 1		# 
		jr	$ra		# return to caller
	
