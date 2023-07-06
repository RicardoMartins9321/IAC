		.data
str0:		.asciiz "\narray["
str1:		.asciiz "]: "

		.text
		.globl print_double_array
		
# void print_double_array(int *array, int n)
print_double_array:

		or	$t0, $0, $a0		#save $a0
		or	$t1, $0, $a1		#save $a1
		
		or	$t2, $0, $0		#i = 0
for0:		bge	$t2, $t1, endfor0
		
		la	$a0, str0		#print_str("array[");
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $t2		#print_int(i);
		addiu	$v0, $0, 1
		syscall
		
		la	$a0, str1		#print_str("]: ");
		addiu	$v0, $0, 4
		syscall			
		
		l.d	$f12, 0($t0)		#print_double(*array)
		addiu	$v0, $0, 3
		syscall
		
		addiu	$t0, $t0, 8		#array++
		addiu	$t2, $t2, 1		#i++
		
		j	for0
		
endfor0:
		jr	$ra
