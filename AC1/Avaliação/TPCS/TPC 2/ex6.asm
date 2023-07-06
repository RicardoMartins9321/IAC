		 .data
um: .double 1.0
dois: .double 2.0
 .text
 .globl eval
eval: subu $sp,$sp,20
 sw $ra, 0($sp)
 sw $s0, 4($sp)
 sw $s1, 8($sp)
 s.d $f20, 12($sp)
 
 move $s0,$a0
if: bne $s0,$0,else # if (n == 0)
 l.d $f0,um # return 1.0
 j final #
else: # else
 # {
 sub.d $f20,$f20,$f20 # sum =0.0
 #
 li $s1,0 # i = 0
for: bge $s1,$s0,endfor # for(; i < n; i++)
 # {
 move $a0,$s1 #
 jal eval #
 add.d $f20,$f20,$f0 # sum += eval(i);
 addi $s1,$s1,1 # i++
 j for # }
endfor: l.d $f0,dois #
 mul.d $f0,$f0,$f20 # $f0 = 2.0 * sum
 mtc1 $s0,$f2 #
 cvt.d.w $f2,$f2 #
 div.d $f0,$f0,$f2 # $f0 = 2.0 * sum / n
 add.d $f0,$f0,$f2 # return (2.0 * sum / n) + n;
final: # }
 lw $ra, 0($sp)
 lw $s0, 4($sp)
 lw $s1, 8($sp)
 l.d $f20, 12($sp)
 addu $sp,$sp,20
 jr $ra

