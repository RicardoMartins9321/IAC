		.text
		.globl average
#--------------------------average---------------------------------------------
#			double average( double *array,  unsigned int n)

#Entradas
#$a0 -> endere�o do array
#$a1 -> n
#
#Saida
#$f0 -> media dos valores double do array

average:	
		or	$t0, $0, $0		#i = 0
		
		mtc1	$0, $f4			#sum = 0
		cvt.d.w	$f4, $f4
		
for0:		bge	$t0, $a1, endfor0	# i < n

		l.d	$f6, 0($a0)		#load double to coprocessor register $f6
		
		add.d	$f4, $f4, $f6		#sum
		
		addiu	$t0, $t0, 1		#i++
		addiu	$a0, $a0, 8
		j	for0
		
endfor0:
		mtc1	$a1, $f8		#move n o coprocessor
		cvt.d.w	$f8, $f8		#convert n from integer to floating point double
		div.d	$f0, $f4, $f8
		
		jr	$ra
