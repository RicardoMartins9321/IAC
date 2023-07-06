	.data
str1:	.asciiz "So para chatear"
str2:	.asciiz "AC1 - aulas praticas"

	.text
	.globl main
	
main:	
	la	$a0, str2	#intrução virtual, decomposta pelo assembler em 2 instruções nativas
	ori	$v0, $0, 4	#print_str
	syscall			
	jr $ra			#end