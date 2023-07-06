		.eqv		SIZE, 3
		.data
array:		.word		str0, str1, str2
str0:		.asciiz		"Array"
str1:		.asciiz		"de"
str2:		.asciiz		"Ponteiros"

		.text
		.globl main
		
main:		la	$t0, array		#array base_address
		
		li	$t1, SIZE		#array last address
		sll	$t1, $t1, 2		
		add	$t1, $t1, $t0		
		
for0:		bge	$t0, $t1, endfor0
		
		lw	$a0, 0($t0)		#print_str(*p)
		li	$v0, 4
		syscall
		
		li	$a0, '\n'		#print_char('\n') -> mudar de linha
		li	$v0, 11
		syscall
		
		addiu	$t0, $t0, 4		#p++
		
		j	for0
		
endfor0:	jr	$ra