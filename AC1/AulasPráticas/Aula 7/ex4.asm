		.data
str1:		.asciiz	"Arquitectura de "
str2:		.byte	0:50
str3:		.asciiz	"Computadores"

		.text
		.globl main
		
main:		subiu	$sp, $sp, 4		#allocate stack space
		sw	$ra, 0($sp)		#save return address to stack
		
		la	$a0, str2		#strcpy(str2, str1)
		la	$a1, str1
		jal	strcpy
		
		
		la	$a0, str2		#strcat(str2, str3)
		la	$a1, str3
		jal	strcat
		
		move	$a0, $v0		#print_str( strcat(str2, "Computadores") );
		li	$v0, 4
		syscall	
		
		li	$v0, 0			#return 0
		
		lw	$ra, 0($sp)		#restore return address value
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra
		
		

#---------------------------------strcpy--------------------------------------
#-----------------------------Acesso Indexado---------------------------------
#Leaf Function -> so usa registos $t -> nao precisa de guardar nada na stack
#	       -> nao usa syscall, por isso nao precisa de guardar os $a

strcpy:
		li	$t0, 0			#i = 0

do0:		addu	$t1, $a0, $t0		#&dst[i]
		addu	$t2, $a1, $t0		#&src[i]
		
		lb	$t3, 0($t2)		# dst[i] = src[i]
		sb	$t3, 0($t1)		
		
		addiu	$t0, $t0, 1		#i++
		
		bne	$t3, '\0', do0		#while(src[i] != '\0')
		
		move	$v0, $a0		#return dst
		
		jr	$ra
		
		
#-------------------------------strcat----------------------------------------
#NON-LEAF-FUNCTION!!!
#nao precisa de usa registos $s porque depois da invocação da leaf function strcpy nao utiliza mais registos
#precisa de guardar o seu return address na stack
#na chamada da função strcpy nao precisa colocar valores nos argumentos pois esses argumentos coincidem com argumentos os da caller
#nao precisa de fazer move do $v0 depois da chamada de strcpy porque nao necessita desse valor
#precisa de guardar o $a0 <-> dst, porque precisa de o devolver
#o caller é que reserva espaço para a concatenação
strcat:
		subiu	$sp, $sp, 4		#allocate memory
		sw	$ra, 0($sp)		#save return address in stack
		
		move	$s0, $a0		#save $a0 content for later returning
		
while0:		lb	$t0, 0($a0)		#*p = dst

		beq	$t0, '\0', endwhile0	#while(*p != '\0')
		
		addiu	$a0, $a0, 1		#p++
		
		j	while0
		
endwhile0:	
		jal	strcpy			#strcpy(p, src)
						#nao necessita de passagem de argumentos porque
						#em $a0 e $a1 já se encontram os argumentos que precisa
		
		move	$v0, $s0		#return dst
								
		lw	$ra, 0($sp)		#restore return address from stack
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra
		
		
		