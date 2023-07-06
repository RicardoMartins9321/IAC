		.text
		.globl main
		
main:		
		#ex1
		lw	$t7, 20($t0)
		sub	$t1, $t7, $s0
		addi	$t0, $t0, 4
		
		
		#ex2
		ble	$s0, $s1, etc
		blt	$s0, $s1, etc
		bgt	$s0, $s1, etc
		
		#ex3
		li	$t0, 0x1002002C
		
		#ex4
		bge	$t0, $t1, etc
		blt	$t0, $t1, etc
etc:
		jr	$ra