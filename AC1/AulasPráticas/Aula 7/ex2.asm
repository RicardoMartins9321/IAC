		.data
str0: 		.asciiz	" - "
		.text
		.globl main
		
main:		subiu	$sp, $sp, 4		#save return address in stack
		sw	$ra, 0($sp)
		
		move 	$s0, $a0		#move content from program arguments to secure registers -> o seu conteudo tem de ser preservado
		move	$s1, $a1		#$s0 = argc ; $s1 = argv
		
		li	$s2, 0			# i = 0
						#usar registos $s porque estes valores nao podem ser alterados por outras funções!!!!
						
for0:		bge	$s2, $s0, endfor0	# i < argc
		
		li	$a0, '\n'		#print_char(' ')
		la	$v0, 11
		syscall	
		
		sll	$t0, $s2, 2		#idx = i * 4
		add	$t0, $t0, $s1		#idx = &argv + i * 4
		
		lw	$t1, 0($t0)		# argv[idx]
		
		
		move	$a0, $t1		#print_str( argv[idx] )
		li	$v0, 4
		syscall
		
		la	$a0, str0		#print_str(" - ")
		li	$v0, 4
		syscall
		
		move	$a0, $t1		#print_str(strrev(str0));
		jal	strrev			#call function
		
		move	$a0, $v0		#move return form function to $a0 and print
		li	$v0, 4		
		syscall	
				
			
				
				
		addiu	$s2, $s2, 1		# i++
		
		j	for0

endfor0:	

		li	$v0, 0			#return 0
		
		lw	$ra, 0($sp)		#restore return address form stack
		addiu	$sp, $sp, 4
		
		jr	$ra			#end program
		



#--------------------------strrev-------------------------------------
strrev:		
		
		subiu	$sp, $sp, 16		#allocate memory
		sw	$ra, 12($sp)		#save return address in stack
		sw	$s0, 8($sp)		#save $s registers in stack
		sw	$s1, 4($sp)
		sw	$s3, 0($sp)
						#save arguments ins $s registers
		move	$s0, $a0		#char *p1 = str
		move	$s1, $a0		#char *p2 = str
		move	$s3, $a0		#string base_Address -> saved to return
		
while0:		lb	$t0, 0($s1)		#*p2

		beq	$t0, '\0', endwhile0	#while(	*p2 != '\0' )
		addiu	$s1, $s1, 1		#p2++
		
		j	while0
		
endwhile0:	subiu	$s1, $s1, 1		#p2--

		
while1:		bge	$s0, $s1, endwhile1	#while( p1 < p2 )
		
		move	$a0, $s0		#load arguments for function
		move	$a1, $s1

		jal	exchange		#call function
		
		addiu	$s0, $s0, 1		#p1++;
		subiu	$s1, $s1, 1		#p2--;
				
		j	while1
		
endwhile1:

	
		move	$v0, $s3		#return str
		
		lw	$s3, 0($sp)		#restore values from stack to used $s registers
		lw	$s1, 4($sp)				
		lw	$s0, 8($sp)
		lw	$ra, 12($sp)		#restore return address from stack
		addiu	$sp, $sp, 16		#deallocate memory
		
		
		jr	$ra			#end functon
		

#------------------------exchange----------------------------
exchange:	
		lb	$t0, 0($a0)	#str[$a0] 
		lb	$t1, 0($a1)	#str[$a1] 
				
		sb	$t0, 0($a1) 	#str[$a1] = str[$a0]
		sb	$t1, 0($a0)	#str[$a0] = str[$a1]
		
		jr	$ra
