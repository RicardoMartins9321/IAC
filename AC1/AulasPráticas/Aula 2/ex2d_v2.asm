	.text
	.globl main
main:
	ori 	$t0, $0, 0x12345678	#load data
	
	
	#print first
	andi 	$t1, $t0, 0xF0000000	#catch bits
	srl	$t1, $t1, 28		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print second
	andi 	$t1, $t0, 0x0F000000	#catch bits
	srl	$t1, $t1, 24		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall	
	
	
	#print third
	andi 	$t1, $t0, 0x00F00000	#catch bits
	srl	$t1, $t1, 20		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print fourth
	andi 	$t1, $t0, 0x000F0000	#catch bits
	srl	$t1, $t1, 16		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print five
	andi 	$t1, $t0, 0x0000F000	#catch bits
	srl	$t1, $t1, 12		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print sixth
	andi 	$t1, $t0, 0x00000F00	#catch bits
	srl	$t1, $t1, 8		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print seventh
	andi 	$t1, $t0, 0x000000F0	#catch bits
	srl	$t1, $t1, 4		#shift full right
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print eight
	andi 	$t1, $t0, 0x0000000F	#catch bits	
	
	or	$a0, $0, $t1		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	ori	$a0, $0, 0xA		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	jr $ra
