		.data
frase1:		.space 20
frase2:		.space 20
frase3:		.space 80
prompt1:	.asciiz "\nInsira a frase1: "
prompt2:	.asciiz "\nInsira a frase2: "
len_res:	.asciiz "\n O numero de caracteres da frase1 é: "
concat_res:	.asciiz "\nA frase concatenada é: " 

		.text
main:		#frase1: $a0,$a1 | frase2: $a0,$a1 | frase3: $a0 | n=$v0
		la $a0,prompt1
		li $v0,4
		syscall					#print_str(prompt1)
		la $a0,frase1
		li $a1,20
		li $v0,8
		syscall					#read_str(frase1,20)
		
		la $a0,prompt2
		li $v0,4
		syscall					#print_str(prompt2)
		la $a0,frase2
		li $a1,20
		li $v0,8
		syscall					#read_str(frase2,20)
		
		la $a0,len_res
		li $v0,4
		syscall					#print_str(len_res)
		la $a0,frase1
		jal strlen				#n=strlen(frase1)
		move $a0,$v0
		li $v0,1
		syscall					#print_int10(n)
			
		la $a0,frase3
		la $a1,frase1
		jal str_copy				#str_copy(frase3,frase1)
		la $a0,frase3
		la $a1,frase2
		jal str_cat				#str_cat(frase3,frase2)
		
		la $a0,concat_res
		li $v0,4
		syscall					#print_str(concat_res)
		la $a0,frase3
		syscall					#print_str(frase3)
		li $v0,10
		syscall					#exit()
			
			
			
strlen:		#str=$a0 | n=$t0 | i=$t1 | $t2=&str[i] | $t3=cópia de str[i] 
		li $t0,0				#n=0
		li $t1,0				#i=0
len_wh:			
		addu $t2,$a0,$t1			#$t2=&str[i]=&str+i
		addi $t1,$t1,1				#i++
		lb $t3,0($t2)				#$t3=cópia de str[i]
		beq $t3,'\0',len_wend
		addi $t0,$t0,1				#n++
		j len_wh
len_wend:
		move $v0,$t0
		jr $ra					#return n

str_copy:	#*dst=$a0 | *src=$a1 | i=$t0 | $t1=&str[i] | $t2=cópia de str[i] | $t3=&dst[i]
		li $t0,0				#i=0
copy_wh:
		addu $t1,$a1,$t0			#$t1=&src[i]=&src+i
		lb $t2,0($t1)				#$t2=cópia de src[i]
		beq $t2,'\0',copy_wend
		addu $t3,$a0,$t0			#$t3=&dst[i]=&dst+1
		sb $t2,0($t3)				#dst[i]=src[i]
		add $t0,$t0,1				#i++
		j copy_wh
copy_wend:		
		addu $t3,$a1,$t0			#$t3=&dst[i]=&dst+i
		sb $0,0($t1)				#dst[i]='\0'
		move $v0,$a0
		jr $ra					#return dst

str_cat:	#dst=$a0 | src=$a1 | aux=$t0,$v0 | cópia de *dst=$t1
		move $t0,$a0				#aux=src
cat_wh:			
		lb $t1,0($a0)
		beq $t1,'\0',cat_wend
		addiu $a0,$a0,1				#*dst++
		j cat_wh
cat_wend:		
		subiu $sp,$sp,8			
		sw $ra,4($sp)				
		sb $t0,0($sp)				
		#não é preciso mudar $a0 e $a1,pois já estão com os valores necessários
		jal str_copy				#str_copy(dst,src)
		lw $ra,4($sp)				
		lw $v0,0($sp)
		addiu $sp,$sp,8
		jr $ra					#return aux
			
