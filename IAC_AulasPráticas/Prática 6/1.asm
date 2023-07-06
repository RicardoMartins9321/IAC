	.text
main:	li	$t0, 0x12345678
	li	$t1, 0x0000ABCD
	
	and 	$t2,$t0,$t1	# $t2 = $t0 and $t1
	li 	$v0, 1 		# $v0 = 1 (syscall "print_int10")
 	syscall			#
 	 
	or 	$t3,$t0,$t1	# $t2 = $t0 or $t1
	li 	$v0, 1 		# $v0 = 1 (syscall "print_int10")
 	syscall
 	 
	nor 	$t4,$t0,$t1	# $t2 = $t0 nor $t1
	li 	$v0, 1 		# $v0 = 1 (syscall "print_int10")
 	syscall
 	 
	xor 	$t5,$t0,$t1	# $t2 = $t0 xor $t1
	li 	$v0, 1 		# $v0 = 1 (syscall "print_int10")
 	syscall 
	
	li 	$v0,10		#
	syscall			# exit()
