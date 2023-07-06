		.data
str0:		.asciiz		"Nr. de parametros: "
str1:		.asciiz		"\n\nP"
str2:		.asciiz		": "
str3:		.asciiz		"\nNumero de Caracteres: "
str4:		.asciiz		"\nNumero de Letras: "
str5:		.asciiz		"\n\nMaior String: "

		.text
		.globl main
		
main:		move	$t0, $a0		#guardar os valores que foram passados ao programa
		move	$t1, $a1		#senão na chamada da funções vai se corromper os argumentos do programa


		la	$a0, str0		#print_str("Nr. de parametros: ");
		li	$v0, 4
		syscall
		
		move	$a0, $t0		#print_int(argc);
		li	$v0, 1
		syscall
		
		li	$t2, 0			# i = 0
		li	$t7, 0			#max_nr_letters = 0
		
for0:		bge	$t2, $t0, endfor0	# i < argc

		la	$a0, str1		#print_str("\nP");
		li	$v0, 4			
		syscall
		
		move	$a0, $t2		#print_int10(i);
		li	$v0, 1
		syscall
		
		la	$a0, str2		#print_str(": ");
		li	$v0, 4
		syscall
		
		sll	$t3, $t2, 2		#idx = i * 4
		addu	$t3, $t3, $t1		#idx = argv base address + i * 4
						# obtem-se o endereço para o indice pretendido do array
						
		lw	$t4, 0($t3)		# argv[i] base address		
		
		move	$a0, $t4		#print_str(argv[i]);
		li	$v0, 4
		syscall
		
		li	$t5, 0			#j = 0
		li	$t6, 0			#letra = 0
		
while0:		addu	$t8, $t4, $t5		#idx2 = argv[i] + j
		lb	$t9, 0($t8)		#argv[i][j]
		
		beq	$t9, '\0', endwhile0	#while( argv[i][j] != '\0' )

		sge	$s0, $t9, 'A'		# if( (argv[i][j] >= 'A' 
		sle	$s1, $t9, 'Z'		# && argv[i][j] <= 'Z')
		and	$s0, $s0, $s1			
		sge	$s1, $t9, 'a'		# || ( argv[i][j] >= 'a'
		sle	$s2, $t9, 'z'		# && argv[i][j] <= 'z') )
		and	$s1, $s1, $s2
		or	$s0, $s0, $s1
		
		beq	$s0, $0, endif0
		addiu	$t6, $t6, 1		#letra++
		
endif0:		addiu	$t5, $t5, 1		#j++
		j	while0

		
endwhile0:	
		ble	$t5, $t7, endif1	#if( j > max )
		move	$t7, $t5		#max = j
		move	$s3, $t4		#max_address = argv[i]
endif1:

		la	$a0, str3		#print_str("\nNumero de Caracteres: ")
		li	$v0, 4
		syscall
		
		move	$a0, $t5		#print_int10(j)
		li	$v0, 1	
		syscall
		
		la	$a0, str4		#print_str("\nNumero de letras: ")
		li	$v0, 4
		syscall	
		
		move	$a0, $t6		#print_int10(letras)
		li	$v0, 1
		syscall	
		
		addiu	$t2, $t2, 1		#i++
		
		j	for0
		
endfor0: 	la	$a0, str5		#print_str("\n\nMaior String")
		li	$v0, 4
		syscall
		
		move	$a0, $s3		#print_str(max_address)
		li	$v0, 4
		syscall


		li	$v0, 0			#return 0
		
		jr	$ra
