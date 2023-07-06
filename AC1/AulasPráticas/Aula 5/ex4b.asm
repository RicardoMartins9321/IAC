		.eqv	SIZE, 10			#define SIZE 10

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
		
		la	$t1, lista			#base address of lista
		
		li	$t3, SIZE			#SIZE 
		subi	$t3, $t3, 1			#SIZE - 1
		sll	$t3, $t3, 2			#(SIZE - 1) * 4
		add	$t3, $t3, $t1			#pUltimo = lista_base_address + (SIZE - 1) * 4
		
BubbleDo:	li	$t2, 0				#houveTroca = FALSE
		move	$t4, $t1			#p = lista_base_address
		
BubbleFor:	bge	$t4, $t3, BubbleEndFor		# p < pUltimo

		lw	$t5, 0($t4)			#*p
		lw	$t6, 4($t4)			#*(p+1)
							
							#se tivesse implementado o registo aux, esse registo podia agr ser eliminado
							#seguindo a implementação atual
							
		ble	$t5, $t6, endif			#if(*p > *(p+1)
		sw	$t6, 0($t4)			#*p = *(p+1)
		sw	$t5, 4($t4)			#*(p+1) = *p
		
		li	$t2, 1				#houveTroca = TRUE

endif:		addi	$t4, $t4, 4			#p = p + 4 (next_word)
		j	BubbleFor			#next Iteration
		
		subi	$t3, $t3, 3			#pUltimo = pUltimo - 4 -> em cada loop completo do for, 
							#o ultimo elemento (ordenação crescente) é o maior elemento do array.
							#Assim poupam-se iterações desnecessarias
		
BubbleEndFor:	bne	$t2, $0, BubbleDo		#while(houveTroca == TRUE)


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
		
		