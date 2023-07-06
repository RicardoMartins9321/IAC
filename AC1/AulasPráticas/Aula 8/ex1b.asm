		.data
str: 		.asciiz	"0111010110111100110100010101?"	#123456789 em binario natural

		.text
		.globl main
		
main:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		la	$a0, str		#load function argument
		jal	atoi			#atoi(str)
		
		move	$a0, $v0		#print_int10( atoi( str ) ) 
		li	$v0, 1	
		syscall
		
		li	$v0, 0			#return 0
		
		lw	$ra, 0($sp)		#restore returna address
		li	$sp, 4			#deallocate memory
		
		jr	$ra
		
#----------------------------atoi-------------------------------------
#LEAF FUNCTION -> nao é preciso usar a stack nem registos $s
#
#Mapeamento de registos
#$v0 -> res
#$a0 -> s
#$t0 -> *s
#$t1 -> digit
#
#Nao é necessario mover o registo do res para o $v0 porque ja la está
atoi:	
		li	$v0, 0			#res = 0
		
while0:		lb	$t0, 0($a0)		#*s
	
		blt	$t0, '0', endwhile0	#*s >= '0'
		bgt	$t0, '1', endwhile0	#*s <= '1'
		
		
		subi	$t1, $t0, '0'		#digit = *s - '0'
		addiu	$a0, $a0, 1		#s++
		sll	$v0, $v0, 1		#res = res * 2
		addu	$v0, $v0, $t1		#res = res * 2 + digit
		
		j	while0
		
endwhile0:	
		
		jr	$ra
		
