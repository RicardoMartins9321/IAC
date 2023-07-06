	.data
array:	.word 7692, 23, 5, 234 #int array[] = {7693, 23, 5, 234

	.text
	.globl main
	
main:

	li	$t3, 0		#int soma = 0
	la	$t0, array	#p = array
	addi	$t1, $t0, 16	#pultimo = array + 16(4x4)
	
while:	bgt	$t0, $t1, endwhile	#while (p <= pultimo)
	
	lw	$t2, 0($t0)		#$t2 aka *p = array[$t0]
	add	$t3, $t3, $t2		#soma = soma + (*p)
	addi	$t0, $t0, 4		#p++
	
	j	while		#jump to label while

endwhile:
	move	$a0, $t3	#move content of $t3 to functiona arguments
	li	$v0, 1		#load print_int instruction
	syscall			#execute
	
	jr	$ra		#end