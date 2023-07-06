		.eqv	SIZE, 11
		.data
array:		.double	0:SIZE
str0:		.asciiz	"Valor: "
str1:		.asciiz	"Media: "

		.text
		.globl main
		
main:		
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return addres to stack
		
		or	$t0, $0, $0		#i = 0
		la	$t1, array		#&array
		
for1:		bge	$t0, SIZE, endfor1
		la	$a0, str0		#print_str("Valor: ");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#read_int
		syscall
		
		sll	$t2, $t0, 3		# i*8
		addu	$t2, $t1, $t2		#&array[i] -> get array index
		
		
		mtc1 	$v0, $f4		#move integer to coprocessor and convert to double
		cvt.d.w	$f4, $f4
		
		s.d	$f4, 0($t2)		#store double in array
		
		addiu	$t0, $t0, 1		#i++
		
		j	for1
		
endfor1:
		la	$a0, str1		#print_str("Media:")
		addiu	$v0,$0,  4
		syscall
		
		or	$a0, $0, $t1		#average(&array, SIZE)
		addiu	$a1, $0, SIZE
		jal	average
		
		mov.d	$f12, $f0		#print_double(average(&array, SIZE))
		addiu	$v0, $0, 3
		syscall
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp,4
		
		jr	$ra
		
		

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
		
