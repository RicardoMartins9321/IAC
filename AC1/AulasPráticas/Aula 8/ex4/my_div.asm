		.text
		.globl my_div
		
my_div:
		sll	$a1, $a1, 16		#divisor = divisor << 16
		andi	$a0, $a0, 0xFFFF	#dividendo = (dividendo & 0xFFFF) << 1
		sll	$a0, $a0, 1		
		
		or	$t0, $0, $0		#i = 0

for0:		bge	$t0, 16, endfor0	#i < 16
		
		or	$t1, $0, $0		#bit = 0
		
		blt	$a0, $a1, endif0	#if(dividendo >= divisor)
		
		sub	$a0, $a0, $a1		#dividendo = dividendo - divisor
		addiu	$t1, $0, 1		#bit = 1
		
endif0:		sll	$a0, $a0, 1		#dividendo = (dividendo << 1) | bit
		or	$a0, $a0, $t1		
		
		addiu	$t0, $t0, 1		#i++
		
		j	for0
		
endfor0:	srl	$v0, $a0, 1		#resto = (dividendo >> 1) & 0xFFFF0000;
		andi	$v0, $v0, 0xFFFF0000
		
		andi	$v1, $a0, 0xFFFF	#quociente = dividendo & 0xFFFF
		
		
		
		jr	$ra
