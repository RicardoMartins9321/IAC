	.data
	str0:	.space	20				#static char str[20]
	str1:	.asciiz	"Introduza uma string: "
	
	.text
	.globl main

main:
	#print_str1
	la	$a0, str1	#load str1 address
	li	$v0, 4		#load print_string instruction
	syscall			#system call print_string
	
	#read_str0
	la	$a0, str0	#load str0 address
	li	$a1, 20		#load str0 length
	li	$v0, 8		#load print_string
	syscall			#execute
	
	la	$t0, str0	#p = str0
	 
	
while:	lb	$t1, 0($t0)	#*p = str0[p]
	beq	$t1, '\0', endwhile	#while(*p != '\0')
	
	subi	$t1, $t1, 'a'	#*p = *p - 'a'
	addi	$t1, $t1, 'A'	#*p = (*p - 'a') + 'A'

	sb	$t1, 0($t0)	#store alterations to memory
	
	addi	$t0,$t0, 1	#p++
	
	j	while		#jumpo to begginning
endwhile:

	#print_string
	la	$a0, str0	#load str0 address
	li	$v0, 4		#load print_string instruction
	syscall			#exectute
	
	jr	$ra		#end
	
