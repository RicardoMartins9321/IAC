		.text
		.globl main
		
sum:		add	$s0, $s0, $s0
		bne	$a0, $0, else		#if ( n == 0)
		move	$v0, $a0		#return 0
		jr	$ra
		
else:
		addi	$sp, $sp, -8		#allocate memory
		sw	$ra, 4($sp)		#save return address in stack
		sw	$a0, 0($sp)		#save current argument of recursive call
		
		
		
		addi	$a0, $a0, -1		#n - 1
		jal	sum			#sum(n - 1)
		
		lw	$a0, 0($sp)		#n
		add	$v0, $v0, $a0		# n + sum( n - 1 )
		
		lw	$ra, 4($sp)		#restore return address
		addi	$sp, $sp, 8		#deallocate memory
		
		jr	$ra			#end function
		
		
main:		
		subiu	$sp, $sp, 4		#allocate memory
		sw	$ra, 0($sp)		#save return address in stack
		
		li	$v0, 5			#user input
		syscall
		move	$a0, $v0
		
		jal	sum			#call sum(n)
		
		move	$a0, $v0		#program output
		li	$v0, 1
		syscall
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
			
		jr	$ra			

