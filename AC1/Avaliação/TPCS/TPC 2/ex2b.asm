		.text
		.globl main
		
main:		li	$v0, 5
		syscall
		move	$s0, $v0
		
		li	$v0, 5
		syscall
		move	$s1, $v0
		
		slt	$t0, $s0, $s1
		bne	$t0, $0, else
		addi	$s0, $s0, 1
		j	endif
else:		subi	$s0, $s0, 1
endif:		
		move	$a0, $s0
		li	$v0, 1
		syscall
		
		li	$a0, '\n'
		li	$v0, 11
		syscall
		
		move	$a0, $s1
		li	$v0, 1
		syscall
		
		jr	$ra