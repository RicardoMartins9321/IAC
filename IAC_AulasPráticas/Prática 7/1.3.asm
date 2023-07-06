.data
prompt1:.asciiz "Introduza um numero: "
result:	.asciiz "O fatorial do numero inserido é: "
.text
	
main:
# $s0 = num; $t0 = i; $t1 = 1

	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, prompt1 	# Apresenta o prompt 
	syscall
	
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall			# Pede um numero ao utilizador
	move $t0, $v0		# $t0 = i
	addi $t1, $0, 1		# f = 1
	
for:				# for(i = num; i > 0; i--)
	beq $t0, $0, end 	# if ($t1==0) goto end
	mult $t1, $t0		# f*i
	mflo $t1		# f = f*i
	subi $t0, $t0, 1	# i--
	j for			# goto for loop
	
end:	
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, result 		# Apresenta o prompt 
	syscall
	
	li $v0, 1		# $v0 = 1 (syscall print_int10(int value)) 
	move $a0, $t1		# $a0 = f
	syscall 
	
	li $v0, 10		# $v0 = 10 (syscall "exit(void)")
	syscall