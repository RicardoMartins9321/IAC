		.text
		.globl stdev
		
stdev:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)
		
		jal	var			#var(array, nval) -> arguments already in correct order
		
		mov.d	$f12, $f0		#move returning from var to argument of sqrt
		
		jal	sqrt			#sqrt( var( array, nval)) 
		
		lw	$ra, 0($sp)		#restore $ra address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra			#return value is already in $f0 -> returned from sqrt...