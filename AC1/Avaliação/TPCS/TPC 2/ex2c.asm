		.text
		.globl main
		
main:		li	$v0, 5
		syscall
		move	$s0, $v0
		
		li	$v0, 5
		syscall
		move	$s1, $v0
		
		slt	$t0, $s1, $s0
		bne	$t0, $0, else
		li	$s0, 0
		j	endif
else:		li	$s1, 0
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