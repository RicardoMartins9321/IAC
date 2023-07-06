	.data
str0:	.asciiz "Introduza 2 numeros: "
str1:	.asciiz "A soma dos dois numeros e: "

	.text
	.globl main

main:
	#print str0
	la	$a0, str0	#load string str0 to a0
	ori	$v0, $0, 4	#load the print_string instruction 
	syscall			#execute $v0 system call
	
	
	#new line
	ori	$a0, $0, 0xA	#load a new line instruction into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11	#load the print_char instruction 
	syscall			#execute $v0 system call
	
	#read number 1
	ori	$v0, $0, 5	#load the read_int instruction
	syscall			#execute $v0 system call
	or	$t0, $0, $v0	#move input number to register $to
	
	#read number 2
	ori	$v0, $0, 5	#load the read_int instruction
	syscall			#execute $v0 system call
	or	$t1, $0, $v0	#move input number to register $t1
	
	#sum
	add	$t2, $t1, $t0	#sum the two numbers
	
	
	#print str1
	la	$a0, str1	#load string str1 to a0
	ori	$v0, $0, 4	#load the print_string instruction
	syscall			#execute $v0 system call
	
	#print sum
	or	$a0, $0, $t2	#move sum to register $a0
	ori	$v0, $0, 1	#print_int10
	syscall
	
	jr	$ra		#end
