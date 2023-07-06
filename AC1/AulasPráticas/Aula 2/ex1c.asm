	.text
	.globl main
main:	
	nor	$t1, $0, $t0	#nor	$t1, $t0, $t0 	is also possible
	
	jr	$ra 