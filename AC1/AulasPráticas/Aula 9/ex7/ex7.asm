		.data
str0:		.asciiz "\nIntroduza o numero de discos: "
str1:		.asciiz	"\n"
str2:		.asciiz	" - Mover disco de topo de "
str3:		.asciiz	" para "

		.text
		.globl main
		
main:
		addi	$sp, $sp, -4		#allocate memory
		sw	$ra, 0($sp)		#save return address
		
		la	$a0, str0		#print_str("\nIntroduza o numero de discos");
		addiu	$v0, $0, 4
		syscall
		
		addiu	$v0, $0, 5		#ndiscs = read_int();
		syscall
		
		ble	$v0, $0, end		#if(ndisc > 0)

		or	$a0, $0, $v0		#tohanoi(ndiscs, 1, 3, 2)
		addiu	$a1, $0, 1
		addiu	$a2, $0, 3
		addiu	$a3, $0, 2
		
		addi	$gp, $gp, -4		#allocate space in global pointer for static int count -> intruction need to be here... but is correct??
		sw	$0, 0($gp)		#static int count = 0 
	
		jal	tohanoi	
		
		addiu	$gp, $gp, 4		#deallocate memory from global pointer
end:		
		or	$v0, $0, $0		#return 0
				
		lw	$ra, 0($sp)		#restore return address value	
		addiu	$sp, $sp, 4		#deallocate memory
		
		jr	$ra
		




#------------------------------------------------------------------------------------
#void tohanoi(int n, int p1, int p2, int p3)

tohanoi:
		addi	$sp, $sp, -24		#allocate memory
		sw	$ra, 20($sp)		#save return address
						#$s0 is a global register -> no need to save in stack
		
						#save arguments of recursive call in stack
		sw	$a3, 12($sp)		#p3
		sw	$a2, 8($sp)		#p2
		sw	$a1, 4($sp)		#p1
		sw	$a0, 0($sp)		#n
		
		
		
		beq	$a0, 1, else0		#if( n != 1)
						
						#tohanoi(n-1, p1, p3, p2)
		addi	$a0, $a0, -1		#n = n -1
						#$a1 is already correct
		or	$t0, $0, $a2		#change position of $a2 and $a3
		or	$a2, $0, $a3
		or	$a3, $0, $t0
		
		jal	tohanoi
		
						#print_msg(p1, p2, ++count)
		lw	$a0, 4($sp)		#load p1 and p2 from memory -> restore correct values
		lw	$a1, 8($sp)
		
		lw	$t0, 0($gp)		#load count from global pointer
		addiu	$t0, $t0, 1		#++count
		sw	$t0, 0($gp)		#store changes in count
		
		or	$a2, $0, $t0		#move count to function argument $a2
		jal	print_msg
			
						#tohanoi(n-1, p3, p2, p1) -> need to restore values from stack
		lw	$a0, 0($sp)		#n
		addi	$a0, $a0, -1		#n = n - 1
		lw	$a1, 12($sp)		#p3
		lw	$a2, 8($sp)		#p2
		lw	$a3, 4($sp)		#p1
		
		jal	tohanoi
		
		j	endif0
		
else0:		
		or	$a0, $0, $a1		#print_msg(p1, p2, ++count)
		or	$a1, $0, $a2		#just need to change order of arguments
		
		lw	$t0, 0($gp)		#load count from global pointer
		addiu	$t0, $t0, 1		#++count
		sw	$t0, 0($gp)		#store changes in count
		
		or	$a2, $0, $t0
		jal	print_msg
		
endif0:
		lw	$ra, 20($sp)		#restore return address
		addiu	$sp, $sp, 24		#deallocate memory
		
		jr	$ra

	
		
#------------------------------------------------------------------------------------------
#void print_msg(int t1, int t2, int cnt)
print_msg:
		addi	$sp, $sp, -16		#allocate memory
		sw	$ra, 12($sp)		#save return address
		sw	$s2, 8($sp)		#need to save $s registers in stack
		sw	$s1, 4($sp)		
		sw	$s0, 0($sp)		
		
		or	$s0, $0, $a0		#save function arguments in $s registers 
		or	$s1, $0, $a1		
		or	$s2, $0, $a2
		
		la	$a0, str1		#print_str("\n")
		addiu	$v0, $0, 4
		syscall
		
		lw	$a0, 0($gp)		#print_int_ac1(cnt, 10)
		addiu	$a1, $0, 10
		jal 	print_int_ac1
		
		la	$a0, str2		#print_str(" - Mover disco de topo de ");
		addiu	$v0, $0, 4		
		syscall
		
		or	$a0, $0, $s0		#print_int_ac1(t1, 10)
		addiu	$a1, $0, 10
		jal 	print_int_ac1
		
		la	$a0, str3		#print_str(" para ");
		addiu	$v0, $0, 4		
		syscall
		
		or	$a0, $0, $s1		#print_int_ac1(t2, 10)
		addiu	$a1, $0, 10
		jal 	print_int_ac1
		
		
		lw	$s0, 0($sp)		#restore $s registers previous value
		lw	$s1, 4($sp)
		lw	$s2, 8($sp)
		lw	$ra, 12($sp)		#restore return address value
		addiu	$sp, $sp, 16		#deallocate memory
		
		jr	$ra
