.data
	frase1: .asciiz "Introduza dois numeros: "
	frase2: .asciiz "A soma desses dois numeros e: "
.text
main:	
	li $v0, 4
	la $a0, frase1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	add $t0, $s0, $s1
	
	li $v0, 4
	la $a0, frase2
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall