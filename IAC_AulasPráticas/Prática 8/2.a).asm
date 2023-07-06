	.data
prompt1:.asciiz "Introduza um texto em minusculas: "
result:	.asciiz "\nInput transformado em maiusculas: "
input:	.space 20
	.text

main:
# $s0 = texto_min; $t0 = i; $s1 = texto_Max

	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, prompt1 	# Apresenta o prompt 
	syscall
	
	# read_string(str,20)
	la $a0, input
	li $a1, 20
	li $v0, 8		# $v0 = 8 (syscall "read_string")
	syscall			# Pede um texto ao utilizador

    	li $t0, 0		# i = 0
    	
while:				# while (minus[i] != ‘\0’)
	lb $t1, input($t0)	# load the array at index i, $t1=input[i]
	
	beq $t1, 0, end		# if (str[i]=='\0') goto end
	blt $t1, 'a', nexti	# if (str[i]<'a') goto nexti
	bgt $t1, 'z', nexti	# if (str[i]>'z') goto next1
	sub $t1, $t1, 32	# convert from lowercase to uppercase
	
	sb $t1, input($t0)	# store back the value
	
nexti:	addi $t0, $t0, 1	# i++
	j while			# goto while loop
	
end:	 
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, result	 	# Apresenta o prompt  
	syscall
	
	li $v0, 4		# $v0 = 4 (syscall print_string(char*str)) 
	la $a0, input		# $a0 = texto_maiusculas
	syscall
	
	li $v0, 10		# $v0 = 10 (syscall "exit(void)")
	syscall
	
