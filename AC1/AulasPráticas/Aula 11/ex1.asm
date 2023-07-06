		.data
result:		.double 1.0
str0:		.asciiz "Introduza uma base (x): "
str1:		.asciiz "Introduza uma potencia (y)"
str2:		.asciiz	"x^y = "

		.text
		.globl main
		
main:
		addi	$sp, $sp, -4
		sw	$ra, 0($sp)

		la	$a0, str0		#print_str("Introduza uma base (x)");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0,$0, 7		#x = read_double();
		syscall
		mov.d	$f12, $f0
				
		la	$a0, str1		#print_str("Introduza uma potencia (y): ")
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#y = read_int();
		syscall
		or	$a0, $0, $v0		
		
		jal	xtoy			
		
		la	$a0, str2		#print_str("x^y = ")
		addiu	$v0, $0, 4
		syscall
		
					
		mov.d	$f12, $f0		#print_double(xtoy(x, y))
		addiu	$v0, $0, 3
		syscall
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr	$ra
		
		







#double xtoy(double x, int y)
# x -> $f12
#y -> $a0
xtoy:
		addi	$sp, $sp, -8		#allocate memory
		sw	$ra, 4($sp)		#save return address to stack
		sw	$s0, 0($sp)		#save $s0 content to stack
		
		addiu	$t0, $0, 0		#i = 0
		la	$t1, result		#result
		
		jal	my_abs
		add	$s0, $0, $v0		#move $vo (abs(y)) to $s0
 		
 		
for0:		bge	$t0, $s0, endfor0	#i < abs(y)
 
 		l.d	$f0, 0($t1)		#load result
 		
 		ble	$a0, $0, else0		#if(y > 0)
 		
 		mul.d	$f0, $f0, $f12		#result *= x
 		
 		j	endif0
 		
else0:		div.d	$f0, $f0, $f12		#result *= x
 
endif0:		s.d	$f0, 0($t1)		#store calculation in result

		addiu	$t0, $t0, 1		#i++
		
		j	for0
		
endfor0:
		
		lw	$s0, 0($sp)		#restore $s0 originbal value
		lw	$ra, 4($sp)		#restore return address original valur
		addiu	$sp, $sp, 8		#deallocate memory
		
		jr	$ra


#int abs( int val)
my_abs:
		add	$v0, $0, $a0		#move $a0 to $v0
		bge	$v0, $0, endif1		#if (val < 0)
		sub	$v0, $0, $v0		#val = -val

endif1:		jr	$ra
		
 
 
 
 
 
 		
 		
