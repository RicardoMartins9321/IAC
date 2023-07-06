	.text
	.globl	main
main:	ori	$t0, $0, 3     #$t0 = x (subsituir val_x pelo valor de x pretendido)
	ori	$t2, $0, 8     #st2 = 8
	add	$t1, $t0, $t0  #st1 = x + x = 2 * x
	sub	$t1, $t1, $t2  #st1 = y = 2 * x - 8
	jr	$ra	       #fim do programa