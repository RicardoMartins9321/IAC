		.eqv	TRUE 1
		.eqv	FALSE 0
		
		.text
		.globl sort
		
sort:
		addi	$t0, $t0, -1		#nval - 1 -> do it here coz doesn need to be repeted
		
do0:		
		ori	$t1, $0, FALSE		#houveTroca = FALSE
		or	$t2, $0, $0		#i = 0
		
for0:		bge	$t2, $t0, endfor0	#for(i = 0; i < nval - 1; i++)
		
		sll	$t3, $t2, 3		# i * 2^3
		addu	$t3, $a0, $t3		#&array[i]
		
		l.d	$f4, 0($t3)		#array[i]
		l.d	$f6, 8($t3)		#array[i+1]
		
		c.le.d	0, $f4, $f6		#if(array[i] > array[i+1])
		bc1t	0, endif0		
		
		s.d	$f6, 0($t3)		#array[i] = array[i+1]
		s.d	$f4, 8($t3)		#array[i+1] = array[i]
		ori	$t1, $0, TRUE		#houveTroca = TRUE
		
endif0:		addiu	$t2, $t2, 1		#i++
		j	for0
		
endfor0:
		beq	$t1, TRUE, do0		#while(houveTroca == TRUE)
		
		div	$t4, $a1 , 2		#nval / 2
		sll	$t4, $t4, 3		#nval / 2 * 2 ^ 3
		addu	$t4, $a0, $t4		#&array[nval / 2]
		l.d	$f0, 0($t4)
		
		jr	$ra
		
		
		
		
