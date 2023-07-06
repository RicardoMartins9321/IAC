	.data
prompt1:.asciiz "Introduza um numero: "
result:	.asciiz "\n O numero em hexadecimal é: "
	.text

main:
# $s0 = num; $t0 = i; $s1 = hexa

	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, prompt1 	# Apresenta o prompt 
	syscall
		
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall			# Pede um numero ao utilizador
	move $s0, $v0		# $s0 = num
	
	addi $t0, $0, 0		# i = 0
for:				# for(i = 0; i < 8; i++)
	slti $t1, $t0, 8	# $t1 = (i < 8) ? 1:0
	beq $t1, $0, end	# if ($t1==0) goto end

	andi $s1,$s0,0xF0000000	# hexa = num and 0xF0000000
	srl $s1, $s1, 28	# hexa = hexa >> 28
	sll $s0, $s0, 2		# num = num << 4 = num*4
	addi $t0, $t0, 1	# i++
	
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, result	 	# Apresenta o prompt  
	syscall
	
	li $v0, 34		# $v0 = 1 (syscall print_int16(int value)) 
	move $a0, $s1		# $a0 = hexa
	syscall
	
	j for			# goto for loop
	
end:	 
	
	
	li $v0, 10		# $v0 = 10 (syscall "exit(void)")
	syscall