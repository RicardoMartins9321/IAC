		.text
		.globl var
		
var:
		addi	$sp, $sp, -28		#allocate memory
		sw	$ra, 24($sp)		#store return address
		sw	$s2, 20($sp)		#store $s registers
		sw	$s1, 16($sp)
		sw	$s0, 12($sp)
		
		
		#s.d	$f22, 8($sp)		#store coprocessor safe registers tha will be used
		#s.d	$f20, 0($sp)
		
		or	$s0, $0, $a0		#save arguments in $s registers
		or	$s1, $0, $a1
		
		jal	average			#arguments alerady in correct position
		mov.d	$f20, $f0		#save return value in coprocessor safe register
		
		or	$s2, $0, $0		#i = 0
		
		mtc1	$0, $f22			#soma = 0 -> move constant zero to coprocessor
		cvt.d.w	$f22, $f22		#convert word to double
		
for0:		bge	$s2, $s1, endfor0	#for(i=0, soma=0.0; i < nval; i++)
		
		sll	$t0, $s2, 3		#i * 2 ^ 3
		addu	$t0, $s0, $t0		#&array[i]
		l.d	$f12, 0($t0)		#array[i]
		sub.d	$f12, $f12, $f20	#array[i] - media
		addiu	$a0, $0, 2		
		jal	xtoy
		
		add.d	$f22, $f22, $f0		#soma += xtoy(array[i] - media, 2);
		
		addiu	$s2, $s2, 1		#i++
		
		j	for0
		
endfor0:	mtc1	$s1, $f0		#move nval to coprocessor
		cvt.d.w	$f0, $f0		#convert nval to double
		div.d	$f0, $f22, $f0		#res = soma / nval
		
		#l.d	$f20, 0($sp)		#restore coprocessor safe registers original values
		#l.d	$f22, 8($sp)
		lw	$s0, 12($sp)		#restore $s original values
		lw	$s1, 16($sp)
		lw	$s2, 20($sp)
		lw	$ra, 24($sp)		#restore $ra original address
		addiu	$sp, $sp, 28		#deallocate memory 
		
		jr	$ra
		
		
