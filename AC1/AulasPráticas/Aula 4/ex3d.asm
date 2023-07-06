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
	
	#*p >= 'A' && *p <= 'Z' 
	sge	$t2, $t1, 'A'	#$t2 = *p >= 'S'
	sle	$t3, $t1, 'Z'	#$t3 = *p <= 'Z'
	and	$t2, $t2, $t3	#$t2 = (*p >= 'A' & *p <= 'Z')
	
	beq	$t2, $0, endif	#if(*p >= 'A' & *p <= 'Z')
	
	subi	$t1, $t1, 'A'	#*p = *p - 'A'
	addi	$t1, $t1, 'a'	#*p = (*p - 'A') + 'a'

endif:	sb	$t1, 0($t0)	#store alterations to memory
	
	addi	$t0,$t0, 1	#p++
	
	j	while		#jumpo to begginning
endwhile:

	#print_string
	la	$a0, str0	#load str0 address
	li	$v0, 4		#load print_string instruction
	syscall			#exectute
	
	jr	$ra		#end
	
