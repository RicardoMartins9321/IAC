.data
prompt1: .asciiz "Introduza um numero: "
result:	.asciiz "\n O numero em hexadecimal e: "
.text
main:	
	#Print do prompt						
	li $v0,4
	la $a0,prompt1
	syscall	
	
	#Pedir numer
	li $v0,5
	syscall
	move $t1,$v0
	
	#Print result					
	li $v0,4
	la $a0,result
	syscall
	
	# n = 0					
	addi $t0,$0 ,0
for:	bge $t0,32,coiso #if n>=32
	li $v0,1
	andi $a0,$t1,0x80000000
	#$a0= $a0 >> 31
	srl $a0,$a0,31
	syscall
	#num = num << 1
	sll $t1,$t1,1
	#n++
	addi $t0,$t0,1					
	j for
	
	#Fim do programa
coiso:	li $v0,10
	syscall	
