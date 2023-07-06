		.data
xn:		.double	1.0
CONST0:		.double 0.5
str0:		.asciiz	"Numero: "


		.text
		.globl main

main:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		la	$a0, str0		#print_str("Numero: ")
		addiu	$v0, $0, 4		
		syscall
		
		addiu	$v0, $0, 7		#x = read_double();
		syscall
		mov.d	$f12, $f0

		jal	sqrt
		
		mov.d	$f12, $f0		#move result from xtoy for printing
		addiu	$v0, $0, 3		
		syscall
		
		lw	$ra, 0($sp)		#restore returna address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr 	$ra


#double sqrt(double val)
# val -> $f12

sqrt:
		addiu	$t0, $0, 0	#i = 0
		
		mtc1.d	$0, $f2		#load constant zero to coprocesor
		cvt.d.w	$f2, $f2	#and convert to double

		c.le.d	$f12, $f2	#val <= 0.0
		
		bc1f	0, endif0	#if( val <= 0.0)
		
		mov.d	$f0, $f2	#return 0.0
		jr	$ra		
endif0:
		
		la	$t1, xn
		l.d	$f2, 0($t1)	#xn
		
do0:		
		
		mov.d	$f4, $f2	#aux = xn
		
		div.d	$f6, $f12, $f2	# val/xn
		
		
		add.d	$f6, $f2, $f6	#(xn + val/xn) 
		
		
		la	$t1, CONST0	#0.5
		l.d	$f8, 0($t1)
		
		mul.d	$f2, $f8, $f6	#xn = 0.5 * (xn + val/xn)
		
		addiu	$t0, $t0, 1	#i++
		
		c.eq.d	0, $f4, $f2	#aux == xn
		bc1t	0, endwhile0	#aux != xn	
		
		blt	$t0, 25, do0	#++i < 25
		
endwhile0:	
		
		mov.d	$f0, $f2	#return xn
		jr	$ra
 
 		
		
		
		

