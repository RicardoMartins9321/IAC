		.text
		.globl strrev
#--------------------------strrev-------------------------------------
strrev:		
		
		subiu	$sp, $sp, 12		#allocate memory
		sw	$ra, 8($sp)		#save return address in stack
		sw	$s0, 4($sp)		#save $s registers in stack
		sw	$s1, 0($sp)
		
						#save arguments ins $s registers
		move	$s0, $a0		#char *p1 = str
		move	$s1, $a0		#char *p2 = str
		move	$s3, $a0		#save $a0 for returning!
		
while0:		lb	$t0, 0($s1)		#*p2

		beq	$t0, '\0', endwhile0	#while(	*p2 != '\0' )
		addiu	$s1, $s1, 1		#p2++
		
		j	while0
		
endwhile0:	subiu	$s1, $s1, 1		#p2--

		
while1:		bgt	$s0, $s1, endwhile1	#while( p1 < p2 )
		
		move	$a0, $s0		#load arguments for function
		move	$a1, $s1

		jal	exchange		#call function
		
		addiu	$s0, $s0, 1		#p1++;
		subiu	$s1, $s1, 1		#p2--;
				
		j	while1
		
endwhile1:
		move	$v0, $s3		#return str
		
		lw	$s1, 0($sp)		#restore values from stack to used $s registers		
		lw	$s0, 4($sp)
		lw	$ra, 8($sp)		#restore return address from stack
		addiu	$sp, $sp, 12		#deallocate memory
		
		
		jr	$ra			#end functon
		

#------------------------exchange----------------------------
exchange:	
		lb	$t0, 0($a0)	#str[$a0] 
		lb	$t1, 0($a1)	#str[$a1] 
				
		sb	$t0, 0($a1) 	#str[$a1] = str[$a0]
		sb	$t1, 0($a0)	#str[$a0] = str[$a1]
		
		jr	$ra
