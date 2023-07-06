	.text
	.globl	main
main:	ori	$v0, $0, 5     #call int read_int(void) -> int read_int(void) é identificada com o numero 5
	syscall
	or	$t0, $0,  $v0  #$t0 = x -> passar o valor lido no teclado para o registo $t0, onde pode ser modificado
	ori	$t2, $0,  8    #st2 = 8
	add	$t1, $t0, $t0  #st1 = x + x = 2 * x
	sub	$t1, $t1, $t2  #st1 = y = 2 * x - 8
	or	$a0, $0,  $t1  #copy from $t1 to $a0 -> print_int16() prints $a0 content
	ori     $v0, $0,  34   #a system call print_int16() é identificada com o número 34
	syscall                #a system call print_int16() é chamada
	jr	$ra	       #fim do programa
