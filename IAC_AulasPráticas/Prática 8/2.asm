.data
minus:	.asciiz "texto em minusculas"
maius:	.space 20

.text
	
main:	

	addi $t0, $0, 0		# i = 0
	la $t5, minus		#$t5 = &minus
	
while:	addu $t1, $t5, $t0	#t1 = minus+i*1 = &minus[i]
	lb $t2, 0($t1)		#$t2 ? uma c?pia de minus[i]
	beq $t2, '\0', endw
	addi $t4, $t2, 'A'
	subi $t4, $t4, 'a' 	#$t4=minus[i]+'A'-'a'
	la $t6, maius
	addu $t3, $t6, $t0	
	sb $t4, 0($t3)	
	#i++
	addi $t0, $t0, 1
	j while
	
	
	#print das cenas
endw: 	la $a0, maius
	li $v0, 4
	syscall
	#Fim do progama
	li $v0, 10
	syscall
