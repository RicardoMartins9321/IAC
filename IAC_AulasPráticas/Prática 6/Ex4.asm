		.text					#
main:		li $s0,0x12345678			#$s0=valor de teste
		li $s1,0xf0000000			#$s1=máscara base
		li $t0,0				#$t0=i
		li $t1,28				#$t1=i limite
for:		bgt $t0,$t1,done			#for(i=0;i<=28;i+=4)
		li $v0,34				#
		sllv $a0,$s0,$t0			# $a0=0x12345678<<i
		and $a0,$a0,$s1				# $a0=$a0 & máscara
		srl $a0,$a0,28				#colocar o nibble à direita
		syscall					#print_int16($a0)
							#
		li $v0,11				#
		li $a0,0x20				#$a0=" "
		syscall					#print_char(" ")
							#
		addi $t1,$t1,4				#i+=4
		j for					#goto for
							#
done:		li $v0,10				#
		syscall					#exit()