		.data		
str0:		.asciiz	"\nIntroduza um numero: "
str1:		.asciiz	"\nO seu fatorial e: "
		.text
		.globl main
		
main:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address

		la	$a0, str0		#print_string("\nIntroduza um numero: "); 
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#num = read_int();
		syscall
		addu	$t0, $0, $v0 
		
		la	$a0, str1		#print_string("\nO seu fatorial e: ")
		addiu	$v0, $0, 4
		syscall
		
		addu	$a0, $0, $t0		#fact(num)
		jal	fact
		
		addu	$a0, $0, $v0
		addiu	$v0, $0, 1
		syscall
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
		
		or	$v0, $0, $0		#return 0
		jr	$ra
		

fact:	
		addi	$sp, $sp, -8		#allocate memory
		sw	$ra, 4($sp)
		sw	$a0, 0($sp)
		
		ble	$a0, 12, endif0		#if(n > 12)
		
		addiu	$v0, $0, 10			#exit(1) //Overflow
		syscall	
endif0:		
		ble	$a0, 1, else1
		addi	$a0, $a0, -1		#n-1
		jal	fact			#fact(n-1)
		
		lw	$a0, 0($sp)		#get n of current execution
		mul	$v0, $a0, $v0		#n * fact(n-1)
		
		j	endif1
else1:		
		addiu	$v0, $0, 1
		
endif1:
	
		lw	$ra, 4($sp)		#restore return adress
		addiu	$sp, $sp, 8		#deallocate memory
		
		jr	$ra