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
		
		bgt	$v0, STR_MAX_SIZE, else	#if( strlen( argv[0] <= STR_MAX_SIZE )
		
		la	$a0, buf		#strcpy(buf, argv[0])
		lw	$a1, 0($a1)
		jal	strcpy
		
		la	$a0, buf		#print_str(buf)
		li	$v0, 4
		syscall
		
		j	endif0
		
else:		la	$a0, str0		#print_str("Sreing to long. Nothing done!\n");
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


#---------------------------------strcpy--------------------------------------
#-------------------------Acesso por Ponteiros--------------------------------
#Leaf Function -> so usa registos $t -> nao precisa de guardar nada na stack
#	       -> nao usa syscall, MAS precisa de guardar o $a0 para o devolver intacto!

strcpy:
		li	$t0, 0			#i = 0
		move	$t1, $a0		#save $a0 to an auxiliar register
		
do0:		lb	$t2, 0($a1)		# dst[i] = src[i]
		sb	$t2, 0($a0)		
		
		addiu	$a0, $a0, 1		#&dst++
		addiu	$a1, $a1, 1		#&src++
		
		addiu	$t0, $t0, 1		#i++
		
		bne	$t2, '\0', do0		#while(src[i] != '\0')
		
		move	$v0, $t1		#return dst
		
		jr	$ra
