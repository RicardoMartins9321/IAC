		.eqv		SIZE, 3
		.data
array:		.word		str0, str1, str2
str0:		.asciiz		"Array"
str1:		.asciiz		"de"
str2:		.asciiz		"Ponteiros"
str3:		.asciiz		"\nString #"
str4:		.asciiz		": "
		.text
		.globl main
		
main:		la	$t0, array		#array base_address
		
		li	$t1, 0			#i = 0
		
for0:		bge	$t1, SIZE, endfor0	#i < SIZE
		
		la	$a0, str3		#print_str( "\nString #" );
		li	$v0, 4
		syscall
		
		move	$a0, $t1		#print_int10( i );
		li	$v0, 1
		syscall
		
		la	$a0, str4		#print_str( ": " );
		li	$v0, 4
		syscall
		
		sll	$t3, $t1, 2		#idx1 = i * 4
		addu	$t3, $t3, $t0		#idx1 = array base_address + i*4
		
		li	$t2, 0			#j = 0
		
while0:		lw	$t4, 0($t3)		#get array[idx1] base_address
		addu	$t4, $t4, $t2		#idx2 = array[idx1] + j
		
		lb	$t5, 0 ($t4)		# get array[idx1] [idx2]
		
		beq	$t5, '\0', endwhile0	#while( array{i][j] != '\0')
		
		move	$a0, $t5		#print_char(array[i][j]);
		li	$v0, 11
		syscall
		
		li	$a0, '-'		#print_char('-');
		li	$v0, 11
		syscall
		
		addiu	$t2, $t2, 1		#j++
		
		j	while0
		
endwhile0:	addiu	$t1, $t1, 1		#i++
		
		j	for0

endfor0:	jr	$ra	