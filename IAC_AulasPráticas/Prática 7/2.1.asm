	.data
prompt1:.asciiz "Introduza um numero: "
result:	.asciiz "A soma dos números positivos é: "
	.text

main:
# $s0 = num; $t0 = i; $s1 = sum

	addi $s1, $0, 0					
	addi $t0, $0, 5		# i = 5
for:				# for(i = 5; i > 0; i--)
	beq $t0, $0, end	# if (i==0) goto end
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, prompt1 	# Apresenta o prompt 
	syscall
	
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall			# Pede um numero ao utilizador
	move $s0, $v0		# $s0 = num
	
	slt $t1, $s0, $0	# $t1 = (num < 0) ? 1:0
	bne $t1, $0, pos 	# if ($t1!=0) goto pos 
	add $s1, $s1, $s0	# sum = sum + num, this line will be ignored if num < 0

pos:	subi $t0, $t0, 1	# i--
	j for			# goto for loop
	
end:	 
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, result	 	# Apresenta o prompt  
	syscall
	
	li $v0, 1		# $v0 = 1 (syscall print_int10(int value)) 
	move $a0, $s1		# $a0 = sum
	syscall
	
	li $v0, 10		# $v0 = 10 (syscall "exit(void)")
	syscall
