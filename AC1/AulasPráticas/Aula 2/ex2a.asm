	.text
	.globl main
main:
	
	sll	$t1, $t0, 4	#Shift Left Logical
	srl	$t2, $t0, 4	#Shift Right Logical
	sra	$t3, $t0, 4	#Shift Right Arithmetic
	
	jr	$ra