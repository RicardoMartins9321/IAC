		.eqv SIZE, 3
		.data
array:		.word		str0, str1, str2
str0:		.asciiz		"Array"
str1:		.asciiz		"de"
str2:		.asciiz		"Ponteiros"
str3:		.asciiz		"\nString #"
str4:		.asciiz		": "
		
		.text
		.globl main
		
main:		la	$t0, array		# &array
		li	$t1, 0			#i = 0	
		
for0:		bge	$t1, SIZE, endfor0	# i < SIZE
		
		la	$a0, str3		#print_str("\nString # ");
		li	$v0, 4
		syscall	
		
		move	$a0, $t1		#print_int10(i)
		li	$v0, 1
		syscall
		
		la	$a0, str4		#print_str(": ");
		li	$v0, 4
		syscall
		
		lw	$t2, 0($t0)		#array[$t1]
		
while0:		lb	$t3, 0($t2)		#array[$t1][$t2]
		beq	$t3, '\0', endwhile0	#while(*p2 != '\0')
		
		move	$a0, $t3		#print_char(*p2)
		li	$v0, 11
		syscall
		
		li	$a0, '-'		#print_char("-");
		li	$v0, 11
		syscall
		
		addiu	$t2, $t2, 1		#p2++
		
		j	while0
		
endwhile0:	addiu	$t1, $t1, 1		#i++
		addiu	$t0, $t0, 4		#p1++
		
		j	for0
		
endfor0:	jr	$ra