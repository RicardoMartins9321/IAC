		.data
CONST1:		.double	5
CONST2:		.double	9
CONST3:		.double	-32
str0:		.asciiz	"\nConversao de Graus Fahrenheit para Graus Celsius\nFahreneheit: "
str1:		.asciiz "\nCelsius: "

		.text
		.globl main

main:	
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return register to stack
		
		
		la	$a0, str0		#print_str(str0)
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 7		#F = read_double(); -> saved in $f0, $f1
		syscall
		
		mov.d	$f2, $f0		#move return value from syscall ($f0, $f1) to argument register of function ($f2, $f3)
		
		jal	f2c
		
		la	$a0, str1		#print_str( str1) -> nao existe problema porque 
						#o registo de retorno da fun��o nao � $v0!
		addiu	$v0, $0, 4	
		syscall	
		
		
		mov.d	$f12, $f0		#move return from f0 to $f12 (register for print_double)
		addiu	$v0, $0, 3		#print_double();
		syscall

		lw	$ra, 0($sp)		#restore return register
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra








#-------------------------Convers�o de graus Fahrenheit para Celsius-----------------------------
#				double f2c( double ft )
#
#$f4 -> 5
#$f6 -> 9
#$f8 -> -32

#$f2 -> argumento da fun��o, F
#$f0 -> registo de retorno, C

f2c:
		ldc1	$f4, CONST1		#load constants
		ldc1	$f6, CONST2
		ldc1	$f8, CONST3
		
		add.d	$f0, $f2, $f8 		# F - 32 -> already saved in return register ($f0)
		div.d	$f10, $f4, $f6		# 5 / 9
		mul.d	$f0, $f0, $f10		# C = % / 9 * (F - 32)
		
		jr	$ra
		
		
