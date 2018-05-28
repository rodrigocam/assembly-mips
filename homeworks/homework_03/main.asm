.data
	msg1: .asciiz "A raiz cubica eh "
	msg2: .asciiz ". O erro eh menor que "
	x0: .double 1
	constant: .double 2
.text
	main:
		jal le_double
		j calc_raiz

	# double le_double()
	le_double:
		# ask for a double precision number and stores in $f0
		li $v0, 7
		syscall
		# return to caller
		jr $ra
	
	# double calc_raiz(double number)
	# uses Halley's Rational Formula for cube roots
	# uses register $f0 as parameter
	calc_raiz:
		# load the initial value of the equation
		ldc1 $f2, x0
		# load the constant 2
		ldc1 $f4, constant
		# pass x0 as parameter of calc_cubo
		mov.d $f20, $f2
		# calculate x0^3
		jal calc_cubo
		# 2*number
		mul.d $f6, $f4, $f0
		# x0^3 + 2Q
		add.d $f8, $f22, $f6
		# x0 * (x0^3 + 2Q)
		
		mul.d $f10, $f2, $f8
		#2 * x0^3
		mul.d $f12, $f4, $f22
		# 2x0^3 + Q
		add.d $f14, $f12, $f0
		
		# value of x1
		div.d $f8, $f8, $f14

		# loop counter
		li $t0, 1
		loop:
			# if loop reaches 10 iteractions end loop
			beq $t0, 10, end_loop
			
			# move the previous value of xn
			mov.d $f2, $f8

			# pass xn as parameter of calc_cubo
			mov.d $f20, $f2

			# calculate xn^3
			jal calc_cubo

			# 2*number
			mul.d $f6, $f4, $f0

			# xn^3 + 2number
			add.d $f8, $f22, $f6

			# xn * (xn^3 + 2number)
			mul.d $f10, $f2, $f8
			
			
			#2 * xn^3
			mul.d $f12, $f4, $f22
			# 2xn^3 + number
			add.d $f14, $f12, $f0
		
			div.d $f8, $f10, $f14
			
			addi $t0, $t0, 1
			j loop
		end_loop:
		
		
		# pass the given number as first parameter of calc_erro
		mov.d $f14, $f0
		
		# pass the calc_raiz result as second parameter of calc_erro
		mov.d $f16, $f8
		
		# calculate error
		jal  calc_erro
		
		# pass result of calc_erro as second parameter of imprime_saida
		mov.d $f10, $f18

		# print result
		j imprime_saida
		
	# void imprime_saida(double result, double error)
	# uses register $f8 and $f10 as parameter
	imprime_saida:
		li $v0, 4
		la $a0, msg1
		syscall
		
		li $v0, 3
		mov.d $f12, $f8
		syscall
		
		li $v0, 4
		la $a0, msg2
		syscall
		
		li $v0, 3
		mov.d $f12, $f10
		syscall
		
		j exit
	
	# double calc_erro(double number, double root)
	# uses register $f14 and $f16 as parameters
	# uses register $f18 as return
	calc_erro:
		# root^3
		mul.d $f18, $f16, $f16
		mul.d $f18, $f18, $f16
		# number - root^3
		sub.d $f18, $f14, $f18
		jr $ra

	# double calc_cubo(double number)
	# uses register $f20 as parameter
	# return number^3 in register $f22
	calc_cubo:
		# result = number * number
		mul.d $f22, $f20, $f20
		# result = result * number
		mul.d $f22, $f22, $f20
		# return to caller
		jr $ra
		
	exit:
