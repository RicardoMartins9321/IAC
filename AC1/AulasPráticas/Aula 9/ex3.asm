		.eqv	SIZE, 4
		.data
array:		.word 	7692, 23, 5, 234 	#int array[] = {7693, 23, 5, 234]
str0:		.asciiz "A soma dos elementos do array e: "

		.text
		.globl main
	

main:		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address in stack
		
		la	$a0, str0		#print_str( "A soma dos elemtentos do array e: ");
		addiu	$v0, $0, 4
		syscall
		
		la	$a0, array		#soma(&array, SIZE)
		addi	$a1, $0, SIZE
		
		jal	soma
		
		or	$a0, $0, $v0		#print_int10( soma( &array, SIZE ) );
		addiu	$v0, $0, 1
		syscall
		
		lw	$ra, 0($sp)		#restore returna address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra



#---------------------------soma recursiva------------------
#

soma:
		beq	$a1, $0, else		#if( nelem != 0 )
		
		addi	$sp, $sp, -8		#allocate memory
		sw	$ra, 4($sp)		#save returna address in memory
		sw	$a0, 0($sp)		#recursive call array current argument
		
		addiu	$a0, $a0, 4		#array + 1
		addi	$a1, $a1, -1		#nelem - 1
		
		jal	soma			#soma( array + 1, nelem - 1)
		
		lw	$a0, 0($sp)		#array
		lw	$ra, 4($sp)		#save return address
		
		addi	$sp, $sp, 8		#deallocate memory
		
		lw	$t0, 0($a0)		#*array
		add	$v0, $t0, $v0		#return *array + soma(array + 1, nelem - 1)
		
		jr	$ra
		
else:		or	$v0, $0, $0		#return 0

		jr	$ra
		
		
