		.eqv	SIZE, 11
		.data
		.align 3
array:		.double	0:SIZE
str0:		.asciiz	"Fahrenheit: "
str1:		.asciiz "Temperaturas em Celsius: "
str2:		.asciiz	"\nTemperatura Maxima: "
str3:		.asciiz	"\nTemperatura Media: "
str4:		.asciiz	"\nTemperatura Mediana: "
str5: 		.asciiz "\nVariancia:"
str6:		.asciiz	"\nDesvio Padrao: "
		.text
		.globl main
		
main:		
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return addres to stack
		
		or	$s0, $0, $0		#i = 0
		la	$s1, array		#&array
		
for0:		bge	$s0, SIZE, endfor0	
		
		la	$a0, str0		#print_str("Fahrenheit: ")
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#value = read_int();
		syscall
		
		mtc1	$v0, $f12		#move value to coprocessor register and convert from integer to double
		cvt.d.w $f12, $f12
		
		jal	f2c			#convert from fahrenheit to Celsius
		
		sll	$t0, $s0, 3		#i * 2 ^ 3
		add	$t0, $s1, $t0		#&array[i]
		s.d	$f0, 0($t0)		#store value in array
		
		addiu	$s0, $s0, 1		#i++
		
		j	for0
		
endfor0:	la	$a0, str2		#print_str("Temperaturas em Celsius: ")
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $s1		#print_double_array(*array, nval)
		addiu	$a1, $0, SIZE
		jal	print_double_array
		
		la	$a0, str2		#print_str("Temperatra Maxima: ")
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $s1		#print_double( max(*array, nval) )
		addiu	$a1, $0, SIZE
		jal	max
		
		mov.d	$f12, $f0
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str3		#print_str("Temperatura Media: ")
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $s1		#print_double( average(*array, nval) )
		addiu	$a1, $0, SIZE
		jal	average
		
		mov.d	$f12, $f0
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str4		#print_str("temperatura Mediana: ")
		addiu	$v0, $0, 4
		syscall	
		
		or	$a0, $0, $s1		#print_double( sort(*array, nval))
		addiu	$a1, $0, SIZE
		jal	sort
		
		mov.d	$f12, $f0
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str5		#print_str("Variancia: ")
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $s1		#print_double( var(*array, nval) )
		addi	$a1, $0, SIZE
		jal	var
		
		mov.d	$f12, $f0
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str6		#print_str("Desvio Padrao: ")
		addiu	$v0, $0, 4
		syscall
		
		or	$a0, $0, $s1		#print_double( stdev(*array, nval) )
		addiu	$a1, $0, SIZE
		jal	stdev
		
		mov.d	$f12, $f0
		addiu	$v0, $0, 3
		syscall
		
		
		lw	$ra, 0($sp)		#restore return address
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		or	$s0, $0, $0		#i = 0
		la	$s0, array		#&array
		
for1:		bge	$t0, SIZE, endfor1
		la	$a0, str0		#print_str("Valor: ");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#read_int
		syscall
		
		sll	$t2, $t0, 3		# i*8
		addu	$t2, $s0, $t2		#&array[i] -> get array index
		
		
		mtc1 	$v0, $f4		#move integer to coprocessor and convert to double
		cvt.d.w	$f4, $f4
		
		s.d	$f4, 0($t2)		#store double in array
		
		addiu	$t0, $t0, 1		#i++
		
		j	for1
		
endfor1:
		la	$a0, str1		#print_str("Media:")
		addiu	$v0,$0,  4
		syscall
		
		or	$a0, $0, $s0		#average(&array, SIZE)
		addiu	$a1, $0, SIZE
		jal	average
		
		mov.d	$f12, $f0		#print_double(average(&array, SIZE))
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str2		#print_str("MAx:")
		addiu	$v0,$0,  4
		syscall
		
		or	$a0, $0, $s0		#max(&array, SIZE)
		addiu	$a1, $0, SIZE
		jal	max
		
		mov.d	$f12, $f0		#print_double(max(&array, SIZE))
		addiu	$v0, $0, 3
		syscall
		
		
		la	$a0, str3		#print_str("Mediana:")
		addiu	$v0,$0,  4
		syscall
		
		or	$a0, $0, $s0		#sort(&array, SIZE)
		addiu	$a1, $0, SIZE
		jal	sort
		
		mov.d	$f12, $f0		#print_double(sort(&array, SIZE))
		addiu	$v0, $0, 3
		syscall
		
		la	$a0, str4		#print_str("Valores ordenados:\n")
		addiu	$v0,$0,  4
		syscall
		
		or	$a0, $0, $s0		#max(&array, SIZE)
		addiu	$a1, $0, SIZE
		jal	print_double_array
		
		lw	$ra, 0($sp)
		addiu	$sp, $sp,4
		
		jr	$ra
		
				
