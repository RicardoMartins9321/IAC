	.data
str0:	.asciiz "Introduza um numero: "
str1:	.asciiz "O valor em binario e: "

	.text
	.globl main
main:
	#print str0
	la	$a0, str0		#load register $a0 with str0
	ori	$v0, $0, 4		#load the print_string instruction
	syscall				#execute the print_string
	
	#new line
	ori	$a0, $0, 0xa	#load to register $a0 the ASCII code for '1'
	ori	$v0, $0, 11	#load the print_char instruction
	syscall
		
	#read int
	ori	$v0, $0, 5		#load to register $v0 the read_int intruction
	syscall				#system call
	
	#move int to temporary address
	or	$t0, $0, $v0
	
	#print str1
	la	$a0, str1		#load register $a0 with str1
	or	$v0, $0, 4		#load print_sting instruction
	syscall				#execute the print_string
	
	#for
	li	$t1, 0			#inicialize for counter
for:	bge	$t1, 32, endfor		#if($t1 >= 32) then goto endfor
	andi	$t2, $t0, 0x80000000	#get most significative bit from $t0 and store in $t2
	
	#if structure
	bnez	$t2, else		#branch to label else if $t2 != 0x0
		ori	$a0, $0, '0'	#load to register $a0 the ASCII code for '0'
		ori	$v0, $0, 11	#load the print_char instruction
		syscall
		
		j	endif		#jump to label endif
	else:
		ori	$a0, $0, '1'	#load to register $a0 the ASCII code for '1'
		ori	$v0, $0, 11	#load the print_char instruction
		syscall
	endif:

	sll	$t0, $t0, 1		#$t0 = $t0 << 1
	addi	$t1, $t1, 1		#$t1 += 1
	j	for			#jump to the begging of the for cycle
endfor:
	
	jr	$ra