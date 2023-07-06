		.data
		.align 3
CONST1:		.double	5
		.align 3
CONST2:		.double	9
		.align 3
CONST3:		.double	-32
		
		.text
		.globl f2c

#-------------------------Conversão de graus Fahrenheit para Celsius-----------------------------
#				double f2c( double ft )
#
#$f4 -> 5
#$f6 -> 9
#$f8 -> -32

#$f12 -> argumento da função, F
#$f0 -> registo de retorno, C

f2c:
		ldc1	$f4, CONST1		#load constants
		ldc1	$f6, CONST2
		ldc1	$f8, CONST3
		
		add.d	$f0, $f12, $f8 		# F - 32 -> already saved in return register ($f0)
		div.d	$f10, $f4, $f6		# 5 / 9
		mul.d	$f0, $f0, $f10		# C = % / 9 * (F - 32)
		
		jr	$ra
