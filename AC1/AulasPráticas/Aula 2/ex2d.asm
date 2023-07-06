	.text
	.globl main
main:
	ori 	$t0, $0, 0x12345678	#load data
	ori	$t1, $0, 0xF0000000	#load catcher
	ori	$t2, $0, 0xA		#load carriage return
	
	
	#print first
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 28		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#load a new line into register $a0 (using a carriage return, 0xD doesnt work!
	ori	$v0, $0, 11		#print_char
	syscall
	
	
	#print second 
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 24		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	
	#print third
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 20		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	
	#print fourth
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 16		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	
	#print fifth
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 12		#shift full right
	srl	$t1, $t1, 11		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	
	#print sixth
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 8		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	
	#print seventh
	and 	$t3, $t1, $t0		#catch bits
	srl	$t3, $t3, 4		#shift full right
	srl	$t1, $t1, 4		#shift catcher one hex to right
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall
	
	#print eighth
	and 	$t3, $t1, $t0		#catch bits
	
	or	$a0, $0, $t3		#move to register $a0
	ori	$v0, $0, 34		#print_int16
	syscall
	
	or	$a0, $0, $t2		#move carriage return to register $a0
	ori	$v0, $0, 11		#print_string
	syscall


	jr	$ra
