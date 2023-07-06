.data
prompt: .asciiz "Insira um numero: \n"
lista: .space 24 #6x4
coiso: .asciiz "/"
.text
main:
	addi $t0, $0, 0 # i = 0
	#a0 = lista[0]
	la $a0, lista
	
for:
	bge $t0, 6, exitfor
		
	#Print prompt
	li $v0, 4
	la $a0, prompt
	syscall
		
	#Pedir numero
	li $v0, 5
	syscall
		
	#$t1 = i*4
	sll $t1,$t0,2
	#$t1 = lista + i*4
	addu $t1,$a0,$t1
	#$v0 = lista[i];
	sw $v0,0($t1)
	# i++ 
	addi $t0,$t0,1
		
	j for
		
exitfor:

	addi $t0, $0, 0		# i = 0
	la $a1, lista		# a1 = lista[0]
	
	
for1:
	bgt $t0, 6, exitfor1
	addi $t1, $t0, 0
	sll $t1, $t1, 2 #t1 = 4i
	addu $a2, $a1, $t1 #a2 = lista + 4i
	lw $a0, 0($a2)
	
	#print(lista[i])
	li $v0, 1
	syscall
	
	#meter um -
	la $a0, coiso
	li $v0, 4
	syscall
	
	# i++
	addi $t0, $t0, 1
	
	j for1
exitfor1:
#Terminar programa
	li $v0, 10
	syscall
