	.data
lista:	.word	8, -4, 3, 5, 124, -15, 87, 9, 27, 15
str0:	.asciiz	"Conteudo do array: "
	.align  2
SIZE:	.byte	10

	.text
	.globl main
	
main:
	li	$t0, 0		# i = 0
	la	$t1, lista	#p = base_address(lista)
	
	la	$s0, SIZE	#get SIZE
	lb	$s0, 0($s0)
	
	la	$a0, str0	#print_str("\nConteudo do array:\n");
	li	$v0, 4		
	syscall
	
for:	bge	$t0, $s0, endfor	# i < SIZE

	lw	$a0, 0($t1)	#*p = lista[p]
	li	$v0, 1		#print_int10();
	syscall
	 
	li	$a0, ' '	#print_char(' ') ao inves de print_char('-')
	li	$v0, 11
	syscall
	
	addi	$t1, $t1, 4	#p = p + 1 (*4)
	addi	$t0, $t0, 1	# i++
	j	for
	
endfor:	jr	$ra
