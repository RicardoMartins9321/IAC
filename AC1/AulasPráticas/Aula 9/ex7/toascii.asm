		.text
		.globl toascii
		
toascii:	
		addiu	$a0, $a0, '0'		#v+=0
		
		ble	$a0, '9', endif		#if( v > '9' )
		addi	$a0, $a0, 7		#'A' - '9' - 1
endif:
		move	$v0, $a0		#return v
		
		jr	$ra	
		
