	.data
	str0:	.space	20		#static char str[20]
	
	.text
	.globl main

	
main: 
	li	$t0, 0			#num = 0
	la	$t1, str0		#p

	#read_string
	la	$a0, str0		#load memory address
	li	$a1, 20			#load string length
	li	$v0, 8			#load read_string(char *buf, int length), *buf -> $a0, length -> $a1
	syscall				#system call read_string
	
while:	lb	$t2, 0($t1)		#*p = str[p + 0]
	beq	$t2, 0x00, endwhile	#while(*p != '\0')
	
	sge	$t3, $t2, '0'		#(*p >= '0')
	sle	$t4, $t2, '9'		#(*p <= '9')
	and	$t3, $t3, $t4		#( (*p >= '0') && (*p <= '9') )
	
	beq	$t3, $0, endif
	addi	$t0, $t0, 1		#num++
	
endif:	addi	$t1, $t1, 1		#p = p + 1
	
	j	while			#goto label while
	
endwhile:
	or	$a0, $0, $t0		#load function argument
	li	$v0, 1
	syscall
	
	jr	$ra
