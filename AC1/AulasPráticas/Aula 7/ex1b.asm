		.data
str0:		.asciiz		"String de Teste"	
	
		.text
		.globl main
main:		
		subiu	$sp, $sp, 4	#save return address to stack
		sw	$ra, 0($sp)
		
		la	$a0, str0	#print_int10(strlen(str0));
		jal	strlen		#call function
		
		move	$a0, $v0	#move return from function to $a0 and print
		li	$v0, 1		
		syscall
		
		li	$v0, 0		#return 0
		
		lw	$ra, 0($sp)	#restore return address
		addiu	$sp, $sp, 4
		
		jr	$ra


#----------------------strlen------------------------------
#nao e necessario proteger registos porque a main nao usa registos
#nao e necessario mover o valor de $a0 porque nao existe nenhuma chamada de função nem syscalls
strlen:
		li	$t0, 0			#int len = 0
		
while0:		lb	$t1, 0($a0)		# *s

		beq	$t1, '\0', endwhile0
		
		addiu	$a0, $a0, 1		#p++
		addiu	$t0, $t0, 1		#len++
		
		j	while0
		
endwhile0:	move	$v0, $t0		#return len

		jr	$ra			#end function -> branch para a a linha a seguir ao jal 
