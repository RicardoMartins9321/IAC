		.eqv	SIZE, 10

		.data					#data Segment
strRead:	.asciiz	"Introduza um numero: "
strOrd:		.asciiz	"\nArray Ordenado: "		
		.align	2
lista:		.word	0:SIZE

		.text
		.globl main
		
main:		li	$t0, 0				# i = 0
		la	$t1, lista			#base address of lista
			
			
Readfor:	bge	$t0, SIZE, ReadEndfor		# i < SIZE
		
		la	$a0, strRead			#print_str(strRead)
		li	$v0, 4
		syscall
		
		li	$v0, 5				#read_int()
		syscall
		
		sw	$v0, 0($t1)			#MEM[$t1] = $v0
		
		addi	$t1, $t1, 4			#p = p + 4
		addi	$t0, $t0, 1			#i++
		
		j	Readfor				#next iteration
ReadEndfor:	

		li	$t0, 0				#i = 0
		la	$t1, lista			#lista base_address
		
		li	$t2, SIZE			#SIZE
		subi	$t2, $t2, 1				#SIZE - 1
		
OutFor:		bge	$t0, $t2, OutEndFor		#i < SIZE - 1
		
		sll	$t4, $t0, 2			#idx1 = i * 4
		add	$t4, $t4, $t1			#idx1 = i*4 + lista_base_address
		
		addi	$t3, $t0, 1			#j = i + 1
		
InFor:		bge	$t3, SIZE, InEndFor		#j < SIZE

		sll	$t5, $t3, 2			#idx2 = j * 4
		add	$t5, $t5, $t1			#idx2 = lista_base_address + j * 4
		
		lw	$t6, 0($t4)			#lista[idx1]
		lw	$t7, 0($t5)			#lista[idx2]
		
		ble	$t6, $t7, endif			#if(lista[idx1] > lista[idx2])
		
		sw	$t7, 0($t4)			#lista[idx1] = lista[idx2]
		sw	$t6, 0($t5)			#lista[idx2] = lista[idx1]
		
endif:		addi	$t3, $t3, 1			#j++

		j	InFor				#next inner iteration
		
InEndFor:	addi	$t0, $t0, 1			#i++

		j 	OutFor				#next outter iteration
		
OutEndFor:	
		li	$t0, 0				#i = 0
		
		la	$a0, strOrd			#print_str(strOrd)
		li	$v0, 4
		syscall
		
PrintFor:	bge	$t0, SIZE, PrintEndFor		# i < SIZE

		sll	$t3, $t0, 2			#idx = i * 4
		add	$t3, $t3, $t1			#idx = idx + base_address
		
		lw	$a0, 0($t3)			#$t4 = lista[idx]
		li	$v0, 1				#print_int10()
		syscall
		
		li	$a0, ' '			#print_char(' ')
		li	$v0, 11
		syscall
		
		addi	$t0, $t0, 1			#i++
		
		j	PrintFor			#next Iteration
PrintEndFor:
		jr	$ra			
		
		

		
		
		