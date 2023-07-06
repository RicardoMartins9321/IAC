		.eqv	MAX_SIZE, 33
		
		.data
		
buf:		.byte	0:MAX_SIZE

		.text
		.globl print_int_ac1
		
print_int_ac1:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address to stack
		
		la	$a2, buf		#$a0 and $a1 already have the correct paramethers 
		
		jal	itoa			
		
		addu	$a0, $0, $v0		#print_str( itoa(val, base, buf) )
		addiu	$v0, $0, 4
		syscall	
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory