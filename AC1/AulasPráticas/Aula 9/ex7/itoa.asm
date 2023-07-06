		.text
		.globl itoa
		
		
#NON-LEAF FUNCTION -> chama a fun��o 
#� necessario guardar na stack os seus endere�os de memoria
#
#Argumentos da fun��o
# $a0 -> n
# $a1 -> b
# $a2 -> s
#Aproveitar o facto de as fun��es chamadas pela itoa so necessitarem de 1 argumento
#so � preciso guardar no $s o $a0
#endere�os em $s
# p -> $s0
# n -> $s1
#
#Mapeamento de Registos
# digit -> $t0
itoa:
		addi	$sp, $sp, -20		#allocate memory
		sw	$ra, 16($sp)		#save return address
		sw	$s0, 12($sp)		#save $s registers
		sw	$s1, 8($sp)
		sw	$s2, 4($sp)
		sw	$s3, 0($sp)
		
		move	$s0, $a0		#move n to a safer register
		move	$s1, $a1		#move b to a safer register
		move	$s2, $a2		#char *p = s
		move	$s3, $a2		#initial s
		
do0:		rem	$t0, $s0, $s1		#digit = n % b
		
		div	$s0, $s0, $s1		#n = n / b
		
		move	$a0, $t0		# toascii( digit )
		jal	toascii
		
		sb	$v0, 0($s2)		#*P = toascii( digit )
		
		addiu	$s2, $s2, 1		#p++
		
		bgt	$s0, $0, do0		#while( n > 0 )
		
		li	$t0, '\0'		#*p = '\0'
		sb	$t0, 0($s2)		
		
		move	$a0, $s3		#strrev	(s)
		jal	strrev			#strrev guarda o endere�o incial e devolve esse mesmo endere�o
						#nao necessita de um move para o $v0 do $s3
		
		lw	$s3, 0($sp)		#restore $s registers
		lw	$s2, 4($sp)
		lw	$s1, 8($sp)		
		lw	$s0, 12($sp)		
		lw	$ra, 16($sp)		#resdore return address
		addi	$sp, $sp, 20		#deallocate memory
		
		jr	$ra			
		
			
		
				
