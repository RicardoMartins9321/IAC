		.data
str0: 		.asciiz	" - "
		.text
		.globl main
		.globl strlen

main:		subiu	$sp, $sp, 4		#save return address in stack
		sw	$ra, 0($sp)

		move 	$s0, $a0		#move argc and argv to a safer registers -> vao ser chamadas funçoes e usdas syscall
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
		
		move	$a0, $t0		#print_int10(strlen(str0));
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
		



#---------------------------------strlen---------------------------
#nao e necessario salvaguardar o valor de registos porque nao se usam na função 
#registos que necessitem de manter o valor que possuem no nivel hierarquico acima
#nao e necessario mover o valor de $a0 porque nao existe nenhuma chamada de função nem syscalls dentro da função strlen
strlen:
		li	$t0, 0			#int len = 0 -> este endereço coincide com um endereço da main mas pode ser corrompido
		
while0:		lb	$t1, 0($a0)		# *s

		beq	$t1, '\0', endwhile0
		
		addiu	$a0, $a0, 1		#p++
		addiu	$t0, $t0, 1		#len++
		
		j	while0
		
endwhile0:	move	$v0, $t0		#return len
		jr	$ra
