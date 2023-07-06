	.data
str0:	.asciiz	"Introduza um numero: "	
	
SIZE:	.byte	5

	.align 	2
lista:	.space	20	#5 * 4 -> cada inteiro ocupa 4 bytes

	.text
	.globl main
	
main:
	
	li	$t0, 0		# i = 0
	la	$t1, lista	#base_Address
	
for:	sll	$t3, $t0, 2	# offset from base_address = i << 2 = i * 4
	add	$t2, $t3, $t1 	# idx = $t3 + base_address 
	
	la	$t3, SIZE	#get SIZE
	lb	$t3, 0($t3)
	
	bge	$t0, $t3, endfor	#i < SIZE
	
	la	$a0, str0	#print_str("\nIntroduza um numero: ")
	li	$v0, 4
	syscall
	
	li	$v0, 5		#read_int()
	syscall
	
	sw	$v0, 0($t2)	#lista[i] = read_int()
	
	
	addi	$t0, $t0, 1	# i = i + 1
	
	j	for
endfor:
	
	jr	$ra
	
	
	
