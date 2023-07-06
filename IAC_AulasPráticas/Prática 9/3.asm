.macro	print_str (%str)
	la	$a0, %str
	li	$v0, 4
	syscall
.end_macro

.macro	print_str_simple
	li	$v0, 4
	syscall
.end_macro

	.data
src:	.asciiz	"abcdefgh"
dst:	.space	8

p1:	.asciiz "strcopy\n"
p2:	.asciiz	"strcat\n"
line:	.asciiz	"\n"

	.text
	.globl	main
main:
	print_str (p1)
	la	$a0, dst
	la	$a1, src
	jal	strcopy
	print_str (dst)
	print_str (line)
	print_str (line)
	
	print_str (p2)
	la	$a0, dst
	la	$a1, src
	jal	strcat
	move $a0, $v0
	print_str_simple
	li	$v0, 10
	syscall

strcopy:
	li	$t0, 0			#i = 0
cwh:	addu	$t1, $a0, $t0
	addu	$t2, $a1, $t0
	lb	$t3, ($t2)
	beq	$t3, $0, cewh
	sb	$t3, ($t1)
	addi	$t0, $t0, 1
	j	cwh
cewh:	sb	$t3, ($t1)
	jr	$ra

strcat:
	addiu	$sp, $sp, -8		#alocate space for $ra and dst
	sw	$ra, 0($sp)		#save $ra to stack
	sw	$a0, 4($sp)		#save dst to stack
jwh:	lb	$t0, ($a0)
	beq	$t0, $0, jewh
	addu	$a0, $a0, 1
	j	jwh
jewh:	jal	strcopy
	lw	$ra, 0($sp)		#restore $ra
	lw	$v0, 4($sp)		#restore dst
	addiu	$sp, $sp, 8		#restore stack
	jr	$ra
