.data
prompt1: .asciiz "Introduza uma string: "
result: .asciiz "O numero de carateres numericos: "
str: .space 40

.text
main:
	#Print prompt1
	li $v0, 4
	la $a0, prompt1
	syscall
	
	# read_string(str,40)
	la $a0, str
	li $a1, 40
	li $v0, 8
	syscall
	
	
	addi $t1, $0, 0		#i = 0
	
				#Comeco ciclo for
	addi $t0, $0, 0 	# i = 0
	la $t4, str 		# t4 = str[0]
for:
	addu $t2, $t4, $t0 	#t2 = str[i]
	lb $t3, 0($t2)
	beq $t3, '\0', exitfor

	blt $t3, '0', nexti	# if (str[i]<0) goto nexti
	bgt, $t3, '9', nexti	# if (str[i]>9) goto nexti
	
	addi $t1, $t1, 1 # n++
	
nexti:	addi $t0, $t0, 1 #i++
	j for

exitfor:
	# Print result
	la $a0, result
	li $v0, 4
	syscall
	
	# Print n
	move $a0, $t1
	li $v0, 1
	syscall
	
	# Fim do programa
	li $v0, 10
	syscall 
	
