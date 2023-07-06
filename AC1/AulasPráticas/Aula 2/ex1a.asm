	.text
	.globl main
main:	
	ori	$t0, $0, 0x762A5C1B	#put number in register -> can put it manually after assemble in register window
	ori	$t1, $0, 0x89D5A3E4	#
	
	and 	$t2, $t0, $t1		#register $t0 OR register $t1
	or	$t3, $t0, $t1		#register $t0 AND register $t1
	nor	$t4, $t0, $t1		#register $t0 NOR register $t1
	xor	$t5, $t0, $t1		#register $t0 XOR register $t1
	
	jr	$ra			#end