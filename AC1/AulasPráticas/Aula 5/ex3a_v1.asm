	.data
str0:	.asciiz	"Introduza um numero: "	
str1:	.asciiz	"Array Ordenado: "
SIZE:	.byte	10

	.align 	2
lista:	.space	40	#10 * 4 -> cada inteiro ocupa 4 bytes

	.text
	.globl main
	
main:
	#READ DATA
	li	$t0, 0		# i = 0
	la	$t1, lista	#base_Address
	
	#GET ARRAY SIZE
	la	$s0, SIZE	#get SIZE
	lb	$s0, 0($s0)
	
	#READ DATA CYCLE
for0:	sll	$t3, $t0, 2	# offset from base_address = i << 2 = i * 4
	add	$t2, $t3, $t1 	# idx = $t3 + base_address 
	
	bge	$t0, $s0, endfor0	#i < SIZE
	
	#print_str("\nIntroduza um numero: ")
	la	$a0, str0	#load str0 address to function paramether
	li	$v0, 4		#load print_str() instruction
	syscall			#execute
	
	#Read Int from user
	li	$v0, 5		#load read_int() instruction
	syscall			#execute MARS system call
	
	#Store Integer from user
	sw	$v0, 0($t2)	#lista[i] = read_int()
	
	#Increment for counter
	addi	$t0, $t0, 1	# i = i + 1
	
	j	for0		#jump to label for1
endfor0:


############################################################
#----------------------------------------------------------#
#----------------------------------------------------------#
#-------------------------Bubble Sort----------------------#
#----------------------------------------------------------#
#----------------------------------------------------------#
############################################################
	
	
	#Reset values
	sub	$s1, $s0, 1	#SIZE - 1
	
	la	$t2, lista	#lista base address
	
	#BUBBLE SORT EXTERNAL CYCLE
do:	li	$t1, 0		#houveTroca = FALSE;
	li	$t0, 0		# i = 0
	li	$t3, 0	

	#BUBBLE SORT INTERNAL CYCLE
for2:	bge	$t0, $s1 , endfor2	#i < SIZE - 1
	
	sll	$t3, $t0, 2	#update_idx = i * 4 (indices multiplos de 4
	add	$t3, $t3, $t2	#idx = update_idx + base_address
	
	lw	$t4, 0($t3)	#lista[i]
	lw	$t5, 4($t3)	#lista[i+1]
	
	ble	$t4, $t5, endif	#if (lista[i] > lista[i+1]
	
	#save to memory -> no need to have aux!!! valores ja estao guardados em registos para a comparação!
	sw	$t5, 0($t3)	#lista[i] = lista[i+1]
	sw	$t4, 4($t3)	#lista[i+1] = lista[i]
	li	$t1, 1		#houveTroca == TRUE
	
endif: 	addi	$t0, $t0, 1	#i++
	j	for2		#jump to inner bubble sort inner cycle
	
endfor2: beq 	$t1, 1, do	#while (houveTroca 00 TRUE);
		
		
	
	
	
	#PRINT ARRAY
	#reset data
	li	$t0, 0		#i = 0
	la	$t1, lista	#p = base_address(lista)

	#print_str("\nConteudo do array:\n");
	la	$a0, str1	#load str0 address to $a0
	li	$v0, 4		#load print_str instruction
	syscall			#execute MARS system call
	
	#PRINT DATA CYCLE
for1:	bge	$t0, $s0, endfor1	# i < SIZE

	#
	lw	$a0, 0($t1)	#*p = lista[p]
	li	$v0, 1		#print_int10();
	syscall
	
	#PRINT CHAR BETWEEN INTEEGERS
	li	$a0, ' '	#print_char(' ') ao inves de print_char('-')
	li	$v0, 11
	syscall
	
	#INCREMENT COUNTERS
	addi	$t1, $t1, 4	#p = p + 1 (*4)
	addi	$t0, $t0, 1	# i++
	
	j	for1		#jump to print cycle
	
endfor1:
	
	jr	$ra
