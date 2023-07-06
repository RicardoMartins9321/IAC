.data
	frase1: .asciiz "Num1: "
	frase2: .asciiz "Num2: "
	frase3: .asciiz "A soma desses dois numeros: "
.text
main:	
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, frase1
	syscall
	
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall
	move $s0, $v0		# $s0 = $v0 ( num = read_int() )
	
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, frase2
	syscall
	
	li $v0, 5		# $v0 = 5 (syscall "read_int")
	syscall
	move $s1, $v0		# $s1 = $v0 ( num = read_int() )
	
	add $t0, $s0, $s1
		
	li $v0, 4		# $v0 = 4 (syscall "print_str")
	la $a0, frase3
	syscall
	
	li $v0, 1		# $v0 = 1 (syscall "print_int10")
	move $a0, $t0
	syscall
	
