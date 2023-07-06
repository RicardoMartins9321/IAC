		.data
str0: 		.asciiz	" - "

		.text
		.globl main
		
main:		subiu	$sp, $sp, 4		#save return address in stack
		sw	$ra, 0($sp)

		move 	$s0, $a0		#move argc and argv to a safer registers -> vao ser chamadas fun�oes e usdas syscall
		move 	$s1, $a1		
		
		li	$s2, 0			# i = 0 -> registo $s, o seu valor nao pode se corrompido
		
for0:		bge	$s2, $s0, endfor0	# i < argc
		
		li	$a0, '\n'		#print_char('\n')
		la	$v0, 11
		syscall
		
		sll	$t0, $s2, 2		# idx = i * 4
		addu	$t0, $t0, $s1
		lw	$t0, 0($t0)
		
		move	$a0, $t0		#print_str( argv[i] )
		li	$v0, 4
		syscall
		
		la	$a0, str0		#print_str(" - ");
		li	$v0, 4
		syscall
		
		move	$a0, $t0		#print_int10(strlen(argv[i]));
		jal	strlen			#call function
		
		move	$a0, $v0		#move return form function to $a0 and print
		li	$v0, 1		
		syscall
		
		addiu	$s2, $s2, 1		# i++
		
		j	for0

endfor0:	li	$v0, 0			#return 0
		
		lw	$ra, 0($sp)		#restore jump register from stack
		addiu	$sp, $sp, 4
		
		jr	$ra
		


#----------------------------strlen recursiva---------------------------
#
#
#
#

strlen:
		lb	$t0, 0($a0)		#*s
		
		beq	$t0, '\0', else		#if(*s != '\0')
		
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		addiu	$a0, $a0, 1		#s + 1
		jal	strlen			#strlen( s + 1 )
		
		addiu	$v0, $v0, 1		#return ( 1 + strlen( s + 1 ) );
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra			#end recursive call
		
else:
		addiu	$v0, $0, 0		#return 0
		
		jr	$ra
