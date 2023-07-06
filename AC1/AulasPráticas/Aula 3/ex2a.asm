	.data
str0:	.asciiz "Introduza um numero: "
str1:	.asciiz "O valor em hexadecimal: "

	.text
	.globl main
	
main:
	#print str0
	la	$a0, str0
	li	$v0, 4
	syscall
	
	#read_int and move to register 
	li	$v0, 5
	syscall
	
	or	$t0, $0, $v0		# $t0 = value
	
	#print str1
	la	$a0, str1
	li	$v0, 4
	syscall
	
	#while
	li	$t1, 8			#i = 8

while:	andi	$t2, $t0, 0xF0000000	#value & 0xF0000000
	seq	$t2, $t2, $0		# (value & 0xF0000000) == 0
	sgt	$t3, $t1, $0		# i > 0
	and	$t2, $t2, $t3		# (value & 0xF0000000) == 0 && (i > 0)
	
	bne	$t2, $0, endwhile	#while( (value & 0xF0000000) == 0 && (i > 0) )
	
	sll	$t0, $t0, 4		#value = value << 4
	subi	$t1, $t1, 1		# i--
	
endwhile:

do:	
	andi	$t3, $t0, 0xF0000000	#value & 0xF0000000
	srl	$t3, $t3, 28		#digito = (value & 0xF0000000) >> 28
	
	ble	$t3, 9, endif		#if (digito <= 9)
	addi	$t3, $t3, 7		#value = value + 7
	
endif:	addi	$t3, $t3, '0'		#digito + '0'

	#print_char
	or	$a0, $0, $t3
	li	$v0, 11
	syscall	
	
	sll	$t0, $t0, 4		#value = value << 4
	subi	$t1, $t1, 1		#i--
	
	bgt	$t1, $0, do		#while (i > 0)
	
	jr	$ra			#end
