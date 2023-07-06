		.eqv MAX_SIZE, 33
		.data
str:		.byte 0:MAX_SIZE
str0:		.asciiz	"\nIntroduza um numero: "
str1:		.asciiz "\nIntroduza uma base (entre 2 e 16): "
str2:		.asciiz	"\nERRO! Base invalida! O programa vai abortar!"

		.text
		.globl main
		
main:		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save $ra register
		
		la	$a0, str0		#print_str( "\nIntroduza um numero: " )
		li	$v0, 4
		syscall
		
		li	$v0, 5			# n = read_int()
		syscall
		move	$s0, $v0		#save n in a safer register
		
		la	$a0, str1		#print_str( "\nIntroduza uma base (entre 2 e 16): "
		li	$v0, 4
		syscall
		
		li	$v0, 5			#b = read_int()
		syscall
		
		blt	$v0,  2, error		#  2 <= b <= 16 -> if(b < 2) branch -> fora do intervalo ja
		ble	$v0, 16	 noerror	#if( b <= 16) -> branch-> se chegar aqui é maior pu igual 2. 
						#Assim se for menor ou igual a 16 e valido e nao deve imprimir o erro
						#se for menor, nao faz branch e imprime o erro
error:
		la	$a0, str2		#print_str( "\nERRO! Base invalida! O programa vai abortar!" )
		li	$v0, 4
		syscall
		
		j	enderror		#jump to end
		
noerror:
		move	$a0, $s0 		#itoa(n, b, s)
		move	$a1, $v0		
		la	$a2, str		
		
		jal 	itoa			
		
		move	$a0, $v0		#print_str(s)
		li	$v0, 4
		syscall

enderror:
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr	$ra
		
		
