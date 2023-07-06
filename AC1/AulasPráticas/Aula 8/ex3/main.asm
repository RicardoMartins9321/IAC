		.data
err1:		.asciiz	"\nOperacao Desconhecida"
err2:		.asciiz "\nNumero de argumentos errado"
		
		.text
		.globl main
		
main:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		or	$s0, $a0, $0		#save argc to safe register
		or	$s1, $a1, $0		#save argv to safe register
		
		or	$s2, $0, $0		#exit_code = 0 -> in safe register
		
		bne	$s0, 3, else		#if( argc == 3)
		
		la	$t0, 0($s1)		#argv[0]
		lw	$a0, 0($t0)
		jal	atoi
		add	$s3, $0, $v0		#val1 = atoi(argv[0])
		
		la	$t0, 8($s1)		#argv[2]
		lw	$a0, 0($t0)
		jal	atoi
		add	$s4, $0, $v0		#val2 = atoi(argv[2])
		
		la	$t0, 4($s1)		#get address to string argv[1]
		lw	$t0, 0($t0)
		lb	$s5, 0($t0)		#get argv[1][0]
		
		bne	$s5, 'x', else0		#if(op == 'x')
		mul	$s6, $s3, $s4		#res = val1 * val2
		j	endif0
				
else0:		bne	$s5, '/', else1		#else if(op == '/')
		div	$s6, $s3, $s4		#res = val1 / val2
		j	endif0
		
else1:		bne	$s5, '%', else2		#else if(op == '%')
		rem	$s6, $s3, $s4		#res = val1 % val2
		j	endif0
		
else2:		la	$a0, err1		#print_str("\nOperação desconhecida");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$s2, $0, 1		#exit_code = 1

endif0:		j 	endif
		
		
else:		la	$a0, err2		#print_str("\nNumero de argumentos errado");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$s2, $0, 2		#exit_code = 1	
		
endif:		bne	$s2, $0, end
		
		addiu	$a1, $0, 10		#print_int_ac1(val1, 10)
		add	$a0, $0, $s3		
		jal	print_int_ac1
		
		addu	$a0, $0, $s5		#print_char(op)
		addiu	$v0, $0, 11
		syscall
		
		addiu	$a1, $0, 10		#print_int_ac1(val2, 10)
		add	$a0, $0, $s4		
		jal	print_int_ac1
		
		addu	$a0, $0, '='		#print_char(op)
		addiu	$v0, $0, 11
		syscall
		
		addiu	$a1, $0, 10		#print_int_ac1(res, 10)
		add	$a0, $0, $s6		
		jal	print_int_ac1
		
		
end:

		addu	$v0, $0, $s2		#return exit_code
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra

#----------------------------atoi-------------------------------------
#LEAF FUNCTION -> nao é preciso usar a stack nem registos $s
#
#Mapeamento de registos
#$v0 -> res
#$a0 -> s
#$t0 -> *s
#$t1 -> digit
#
#Nao é necessario mover o registo do res para o $v0 porque ja la está
atoi:	
		li	$v0, 0			#res = 0
		
while0:		lb	$t0, 0($a0)		#*s
		blt	$t0, '0', endwhile0	#*s >= '0'
		bgt	$t0, '9', endwhile0	#*s <= '9'
		
		subi	$t1, $t0, '0'		#digit = *s - '0'
		addiu	$a0, $a0, 1		#s++
		mulu	$v0, $v0, 10		#res = res * 10
		addu	$v0, $v0, $t1		#res = res * 10 + digit
		
		j	while0
		
endwhile0:	
		
		jr	$ra
		