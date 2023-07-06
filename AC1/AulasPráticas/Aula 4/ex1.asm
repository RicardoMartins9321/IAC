	.data
	str0: .space 20			#static char str[20]		
	
	.text
	.globl main

	
main: 
	#read_string
	la	$a0, str0		#load memory address
	li	$a1, 20			#load string length
	li	$v0, 8			#load read_string(char *buf, int length), *buf -> $a0, length -> $a1
	syscall				#system call read_string
	
	li	$t0, 0			#num = 0
	li	$t1, 0			#i = 0
	la	$t2, str0		#addres of str[0]
		
while:	add	$t3, $t1, $t2		#indice str = i + address of str[0]
	lb	$t4, 0($t3)		#$t3 = str[$t2 + 0]
	beq	$t4, 0x00, endwhile	#while(str[i] != '\0')
	
	sge	$t5, $t4, '0'		#(str[i] >= '0')
	sle	$t6, $t4, '9'		#(str[i] <= '9')
	and	$t5, $t5, $t6		#( (str[i] >= '0') && (str[i] <= '9') )
	
	beq	$t5, $0, endif
	addi	$t0, $t0, 1		#num++
endif:	addi	$t1, $t1, 1		#i++
	
	
	j	while			#goto label while
	
endwhile:
	or	$a0, $0, $t0		#load function argument
	li	$v0, 1			#load print_int10 instruction
	syscall				#system call print_int10
	
	jr	$ra			#end
