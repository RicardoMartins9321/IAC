		.text
		.globl max
		
max:
		l.d	$f0, 0($a0)		#max = *array
		addiu	$t0, $0, 1		#i = 1
		addiu	$a0, $a0, 8		#array++
		
for0:		bge	$t0, $a1, endfor0	
		l.d	$f4, 0($a0)		
		
		c.le.d	0, $f4, $f0		#if(*array > max)
		bc1t	0, endif0
		mov.d	$f0, $f4		#max = array
endif0:		
		addiu	$t0, $t0, 1		#i++	
		addiu	$a0, $a0, 8		#array++
		
		j	for0

endfor0:	jr	$ra			#max already in return register
		
