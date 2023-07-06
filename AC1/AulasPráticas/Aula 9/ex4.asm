		.data
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
		
		li	$v0, 5			# num = read_int()
		syscall
		move	$s0, $v0		#save num in a safer register
		
		la	$a0, str1		#print_str( "\nIntroduza uma base (entre 2 e 16): "
		li	$v0, 4
		syscall
		
		li	$v0, 5			#base = read_int()
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
		move	$a0, $s0 		#print_int_ac1(n, b)
		move	$a1, $v0		
	
		jal 	print_int_ac1		

enderror:
		lw	$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr	$ra
		
#-----------------------print_int_ac1 recursiva----------------------
#
#
#

print_int_ac1:
		addi	$sp, $sp, -12		#allocate memory
		sw	$ra, 8($sp)		#save return address
		sw	$a1, 4($sp)		#save recursive call current arguments
		sw	$a0, 0($sp)
		
		div	$a0, $a0, $a1		#num / base
		beq	$a0, $0, print		#if( num / base )
		
		jal	print_int_ac1

print:				
		lw	$a0, 0($sp)		#restore recursive call arguments
		lw	$a1, 4($sp)		#need to be here coz of overwriting -> save registers 
		
		rem	$a0, $a0, $a1		#num % base
		
		jal	toascii			#toascii( num % base )
		
		or	$a0, $0, $v0		#print_char( toascii( num % base ) );
		addiu	$v0, $0, 11
		syscall
		
		lw	$ra, 8($sp)		
		addiu	$sp, $sp, 12		#deallocate memory
		
		jr 	$ra
		
		
#---------------------------toascii---------------------------
#
#
#
toascii:	
		addiu	$a0, $a0, '0'		#v+=0
		
		ble	$a0, '9', endif		#if( v > '9' )
		addi	$a0, $a0, 7		#'A' - '9' - 1
endif:
		move	$v0, $a0		#return v
		
		jr	$ra	
		

		
