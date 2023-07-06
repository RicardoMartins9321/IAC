		.eqv	STR_MAX_SIZE, 10
		.eqv	BUF_MAX_SIZE, 11
		
		.data
buf:		.word	0:BUF_MAX_SIZE
str0:		.asciiz	"String too long. Nothing done!\n"
		.text
		.globl 	main
		
main:		subiu	$sp, $sp, 4		#allocate memory
		sw	$ra, 0($sp)		#save return register in stack


		bne	$a0, 1, endif0		#if(argc == 1)
		
		lw	$a0, 0($a1)		#strlen(argv[0])
		jal	strlen			#
		
		bgt	$v0, STR_MAX_SIZE, else0#if( strlen( argv[0] <= STR_MAX_SIZE )
		
		la	$a0, buf		#strcpy(buf, argv[0])
		lw	$a1, 0($a1)
		jal	strcpy
		
		la	$a0, buf		#print_str(buf)
		li	$v0, 4
		syscall
		
		j	endif0
		
else0:		la	$a0, str0		#print_str("Sreing to long. Nothing done!\n");
		li	$v0, 4
		syscall
		
		li	$v0, 1			#se executou p codigo else então houve erros!
						#devolver 1
		j	end
		
endif0:		li	$v0, 0			#se nao executou o codigo else então a execução do programa foi bem sucedida
						#devolver 0
						
end:		lw	$ra, 0($sp)		#restore return address original value
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra
		
		

#----------------------------------strcpy recursiva------------------------
#
#
#
#

strcpy:
		lb	$t0, 0($a0)		#*dst
		lb	$t1, 0($a1)		#*src
		
		sb	$t1, 0($a0)		#*dst = *src
		beq	$t1, '\0', return	#if( ( *dst = *src ) != '\0' )
		
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address in stcak
		
		addiu	$a0, $a0, 1		#dst + 1
		addiu	$a1, $a1, 1		#src + 1
		
		jal	strcpy			#strcpy(dst + 1, src + 1)
		
		addi	$a0, $a0, -1		#engineer way -> get original dst -> IT WORKS!!
		
		lw	$ra, 0($sp)		#restore returna address
		addiu	$sp, $sp, 4		#deallocate memory
return:		
		move	$v0, $a0		#return dst
		jr	$ra
		
		

#----------------------------strlen recursiva---------------------------
#
#
#
#

strlen:
		lb	$t0, 0($a0)		#*s
		
		beq	$t0, '\0', else1		#if(*s != '\0')
		
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		addiu	$a0, $a0, 1		#s + 1
		jal	strlen			#strlen( s + 1 )
		
		addiu	$v0, $v0, 1		#return ( 1 + strlen( s + 1 ) );
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra			#end recursive call
		
else1:
		addiu	$v0, $0, 0		#return 0
		
		jr	$ra
