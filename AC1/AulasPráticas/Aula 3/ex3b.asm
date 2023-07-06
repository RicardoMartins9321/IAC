	.data
str0:	.asciiz	"Introduza dois numeros: "
str1:	.asciiz	"Resultado: "
	.text
	.globl main
	
main:
	#print_str("Introduza dois numeros")
	la	$a0, str0	#load str0 address to register $a0
	li	$v0, 4		#load print_string instruction
	syscall			#MARS system call
	
	#mdor = read_int()
	li	$v0, 5		#load print_int instruction
	syscall			#MARS system call
	move	$t0, $v0	#mdor = $t0 -> move value return from the system call tom register $t0
	
	#mdo = read_int
	li	$v0, 5		#load print_int instruction
	syscall			#MARS system call
	move	$t1, $v0	#mdo = $t1 -> move value return from the system call tom register $t0	
	
	
	li	$t2, 0		# i = 0
	li	$t3, 0		#res = 0
	
while:	sne	$t4, $t0, $0	#mdor != 0
	slti	$t5, $t2, 16 	#i < 4
	and	$t4, $t4, $t5	# ( (mdor != 0) && (i < 16) )
	addi	$t2, $t2, 1	#i++
	beq	$t4, $0, endwhile	# while ( (mdor != 0) && (i++ <16) )
	
	andi 	$t4, $t0, 0x1	#mdor & 0x00000001
	beq	$t4, $0, endif	# if ( (mdor & 0x00000001) != 0 )
	add	$t3, $t3, $t1	#res = res + mdo
	
endif:	sll	$t1, $t1, 1	#mdo = mdo << 1
	srl	$t0, $t0, 1	#mdor = mdor >> 1
	
	j	while		#jump to while label
endwhile:
	
	#print_str("Resultado: ")
	la	$a0, str1
	li	$v0, 4
	syscall
	
	#print_int10(res)
	move	$a0, $t3
	li	$v0, 1
	syscall
	
	jr	$ra		#jump to register $ra

	
	