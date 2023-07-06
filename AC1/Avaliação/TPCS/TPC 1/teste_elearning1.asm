	.text
	.globl main
	
main: 
	lw $t3, 12($t2)
	addi $t0, $t0, 4
	lw   $t7, 20($t0)
	sub $t1, $t7, $s0
	jr $ra
