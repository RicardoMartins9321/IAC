.text
main: 	li	$t0 0x12345678
	sll 	$t1,$t0, 1
	srl 	$t2,$t0, 1
	sra 	$t3,$t0, 1
	
	li 	$v0, 10
	syscall
