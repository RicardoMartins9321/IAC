	.data
prompt1:.asciiz "Introduza um numero: "
dash:	.asciiz "-"
	.text

main:
# $s0 = num; $t0 = i

	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, prompt1 	# Apresenta o prompt 
	syscall
	
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall			# Pede um numero ao utilizador
	move $s0, $v0		# $s0 = num
					
	addi $t0, $0, 0		# i = 0
for:				# for(i = 0; i < num; i++)
	slt $t1, $t0, $s0	# $t1 = (i < num) ? 1:0
	beq $t1, $0, end 	# if ($t1==0) goto end
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, dash	 	# Apresenta o prompt 
	syscall
	addi $t0, $t0, 1	# i++
	j for			# goto for loop
	
end:	  
	li $v0, 10		# $v0 = 10 (syscall "exit(void)")
	syscall
	