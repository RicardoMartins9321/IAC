		.data
CONS:		.float	2.59375

		.text
		.globl main
		
main:		#USAR SEMPRE ENDEREÇOS PARES!!!

do0:		
		addiu	$v0, $0, 5		#val = read_int();
		syscall
		mtc1	$v0, $f4		#move val to Coprocessor register $f4
		cvt.s.w	$f4, $f4		#(float)val - >convert word stored in $f4 to single (IEEE - 754)
		
		l.s	$f6, CONS		#load CONS to coprocessor
		mul.s	$f4, $f4, $f6		#res = (float)val * 2.59375
		
		mov.s	$f12, $f4		#move res to floating point register $f12 -> register used for printing float
		addiu	$v0, $0, 2		#print_float( res );
		syscall

		cvt.w.s	$f4, $f4		#convert res from single to integer -> still saved in floating point register
		mfc1	$t0, $f4		#move CONS to Coprocessor register $f6
		
		bne	$t0, $0, do0		#while( res != 0.0)
		
		jr	$ra
		
			