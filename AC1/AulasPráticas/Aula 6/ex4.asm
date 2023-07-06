		.data
str0:		.asciiz		"Nr. de parametros: "
str1:		.asciiz		"\nP"
str2:		.asciiz		": "

		.text
		.globl main
		
main:		move	$t0, $a0		#guardar os valores que foram passados ao programa
		move	$t1, $a1		#senão na chamada da funções vai se corromper os argumentos do programa


		la	$a0, str0		#print_str("Nr. de parametros: ");
		li	$v0, 4
		syscall
		
		move	$a0, $t0		#print_int(i);
		li	$v0, 1
		syscall
		
		li	$t2, 0			# i = 0
		
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
						
						
		lw	$a0, 0($t3)		#print_str(argv[i]); -> atraves do lw obtem se o endereço de inicio da string
		li	$v0, 4
		syscall
		
		addiu	$t2, $t2, 1		#i++
		
		j	for0
		
endfor0: 	li	$v0, 0			#return 0

		jr	$ra