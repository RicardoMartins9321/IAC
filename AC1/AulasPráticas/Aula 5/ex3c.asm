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
			
			
Readfor:	bgeu	$t0, SIZE, ReadEndfor		# i < SIZE
		
		la	$a0, strRead			#print_str(strRead)
		li	$v0, 4
		syscall
		
		li	$v0, 5				#read_int()
		syscall
		
		sw	$v0, 0($t1)			#MEM[$t1] = $v0
		
		addiu	$t1, $t1, 4			#p = p + 4
		addiu	$t0, $t0, 1			#i++
		
		j	Readfor				#next iteration
ReadEndfor:	
		
		la	$t1, lista			#base address of lista
		
		li	$t3, SIZE			#SIZE - 1
		subiu	$t3, $t3, 1			
		
BubbleDo:	li	$t2, 0				#houveTrocas = 0
		li	$t0, 0				#i = 0
		
BubbleFor:	bgeu	$t0, $t3, BubbleEndFor		# i < SIZE - 1
		
		sll	$t4, $t0, 2			#idx = i * 4
		addu	$t4, $t4, $t1			#idx = idx + base_Address
		
		lw	$t5, 0($t4)			#lista[idx]
		lw	$t6, 4($t4)			#lista[idx+1]
		
		bleu	$t5, $t6, endif			#if(lista[idx] > lista[idx+1])
		
		sw	$t6, 0($t4)			#lista[idx] = lista[idx + 1]
		sw	$t5, 4($t4)			#lista[idx+1] = list[idx]
		
		li	$t2, 1				#houveTroca = TRUE
endif:		
		addiu	$t0, $t0, 1			#i++
		
		j	BubbleFor			#next BubbleFor Iteration
		
BubbleEndFor:	
		bne	$t2, $0, BubbleDo		#while(houveTroca)
		
		
		
		li	$t0, 0				#i = 0
		
		la	$a0, strOrd			#print_str(strOrd)
		li	$v0, 4
		syscall
		
PrintFor:	bgeu	$t0, SIZE, PrintEndFor		# i < SIZE

		sll	$t3, $t0, 2			#idx = i * 4
		addu	$t3, $t3, $t1			#idx = idx + base_address
		
		lw	$a0, 0($t3)			#$t4 = lista[idx]
		li	$v0, 36				#print_intu10()
		syscall
		
		li	$a0, ' '			#print_char(' ')
		li	$v0, 11
		syscall
		
		addiu	$t0, $t0, 1			#i++
		
		j	PrintFor			#next Iteration
PrintEndFor:
		jr	$ra			
		