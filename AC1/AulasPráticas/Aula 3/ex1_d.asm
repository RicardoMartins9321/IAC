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
	ori 	$t4, $0, 0		#flag
	
for:	bge	$t1, 32, endfor		#if($t1 >= 32) then goto endfor
	andi	$t2, $t0, 0x80000000	#get most significative bit from $t0 and store in $t2
	
	or	$t4, $t4, $t2		#flag -> 1 if has already impressed a bit, 0 if not
	
	#if structure 0
	beqz	$t4, endif0		#branch to label endif0 if $t4 == 0x0
	 
	srl	$t2, $t2, 31		#shift full right
	or	$a0, $0, $t2		#load to register $a0 the content of register $t2
	ori	$v0, $0, 1		#load the print_int10 instruction
	syscall				#execute print_int10
	
	endif0:
	
	sll	$t0, $t0, 1		#$t0 = $t0 << 1
	addi	$t1, $t1, 1		#$t1 += 1
	j	for			#jump to the begging of the for cycle
endfor:
	
	jr	$ra
