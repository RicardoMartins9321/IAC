		.text
		.globl main
		
main:		
		subiu	$sp, $sp, 4		#allocate memory
		sw	$ra, 0($sp)		#save return address in stack
		
		li	$v0, 5			#user input
		syscall
		move	$a0, $v0
		
		jal	fact			#call sum(n)
		
		move	$a0, $v0		#program output
		li	$v0, 1
		syscall
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
			
		jr	$ra			

		
fact:
		subiu	$sp, $sp, 8		#allocate memory
		sw	$s0, 4($sp)		#save $s registers		
		sw	$s1, 0($sp)		#
		
		li	$s0, 1			#i = 1
		li	$s1, 1			#prod = 1
		
for0:		bgt	$s0, $a0, endfor0
		mul	$s1, $s1, $s0
		addiu	$s0, $s0, 1
		j	for0
		
endfor0:	move	$v0, $s1
		
		lw	$s1, 4($sp)
		lw	$s0, 0($sp)
		addiu	$sp, $sp, 8
		
		jr	$ra