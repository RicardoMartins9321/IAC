		.data
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
		
		addiu	$v0, $0, 5		#x = read_int()
		syscall
		or	$t0, $0, $v0
				
		la	$a0, str1		#print_str("Introduza uma potencia (y): ")
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#y = read_int()
		syscall
		or	$t1, $0, $v0
		
		la	$a0, str2		#print_str("x^y = ")
		addiu	$v0, $0, 4
		syscall
		
		
		or	$a0, $0, $t0		#xtoy(x, y)
		or	$a1, $0, $t1
		jal	xtoy
		
		or	$a0, $0, $v0		#print_int10(xtoy(x, y))
		addiu	$v0, $0, 1
		syscall
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr	$ra
		
xtoy:
		addi	$sp, $sp, -4		#so e preciso guardar o $ra na stack -> depois da chamda recursiva so e preciso valor de x e esse nunca muda
		sw	$ra, 0($sp)
		
		beq	$a1, $0, else0		#if( y != 0)
		
		addi	$a1, $a1, -1		#y = y - 1
		jal	xtoy
		mul	$v0, $a0, $v0
		
		j	endif0
		
else0:		addiu	$v0, $0, 1		
endif0:		
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr	$ra
		
		 