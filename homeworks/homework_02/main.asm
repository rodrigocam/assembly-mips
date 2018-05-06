.data
	msg_error: .asciiz "O modulo nao eh primo.\n"
	msg_r1: .asciiz "A exponenciacao modular "
	msg_r2: .asciiz " elavado a "
	msg_r3: .asciiz " (mod "
	msg_r4: .asciiz ") eh "

.text
	
	main:
		# -- read the base of the exponentiation --
		jal read_int
		addi $s0, $v0, 0 # move the number to $s0 because read_int stores the number in $v0	
		
		# -- read the exp of the exponentiation --
		jal read_int
		addi $s1, $v0, 0
		
		# -- read the mod of the exponentiation --
		jal read_int
		addi $s2, $v0, 0
		
		# move the mod of the exponentiation to $a0 for is_prime function
		addi $a0, $s2, 0
		jal is_prime
		
		# if mod is not prime print error
		beq $v0, 1, print_error
		beq $v0, 1, end_program
		
		# if mod is prime calc exponentiation
		addi $a0, $s0, 0 # pass "base" as argument
		addi $a1, $s1, 0 # pass "exp" as argument
		addi $a2, $s2, 0 # pass "mod" as argument
		jal calc_exp
		
		addi $a3, $v0, 0 # load the result of the calc_exp into $a3 to pass to the print function
		jal print_result
		j end_program
		
	
	calc_exp:
		li $v0, 1
		li $t0, 0 # iterator
		loop_calc_exp:
			bge $t0, $a1, end_calc_exp_loop
			
			mult $v0, $a0
			mflo $t1
			div $t1, $t1, $a2
			mfhi $t2
			addi $v0, $t2, 0
			addi $t0, $t0, 1 # increase iterator
			j loop_calc_exp
		end_calc_exp_loop:
			jr $ra
	
	is_prime:
		# -- if number <= 1 return--
		sle $v0, $a0, 1
		beq $v0, 1, end_is_prime
		
		# -- number % 2 == 0 && number > 2 return --
		div $t0, $a0, 2
		mfhi $t0, # load the remainder of the previous division
		seq $v0, $t0, 0
		bne $v0, 1, end_prime_if # if the first condition is false, skip the conditional
		sgt $v0, $a0, 2
		beq $v0, 1, end_is_prime
		end_prime_if:
		
		# -- for(int i = 3; i<number/2; i+=2)
		li $t0, 3
		add $t1, $a0, 0 # move the passed number to iterate
		div $t1, $t1, 2 # number/2
		prime_loop:
			bge $t0, $t1, end_prime_loop # loop condition
			div $t2, $a0, $t0
			mfhi $t2
			seq $v0, $t2, 0
			beq $v0, 1, end_is_prime
			addi $t0, $t0, 2 # iterator += 2
			j prime_loop
		end_prime_loop:
			li $v0, 0
	end_is_prime:		
		jr $ra
	
	read_int:
		# read the and integer and saves in $v0
		li $v0, 5
		syscall
		jr $ra
			
	print_error:
		li $v0, 4 # instruction to print string
		la $a0, msg_error # load the content of the string on the resgister to print
		syscall
		j end_program
		
	# -- print_result(int base, int exp, int mod, int result) --
	# $a0 - base, $a1 - exp, $a2 - mod, $a3 - result
	print_result:
		addi $t0, $a0, 0 # move the "base" argument to a tmp register
		addi $t1, $a1, 0 # move the "exp" argument to a tmp register
		addi $t2, $a2, 0 # move the "mod" argument to a tmp register
		addi $t3, $a3, 0 # move the "result" argument to a tmp register
		
		# print the begin of the message
		li $v0, 4
		la $a0, msg_r1
		syscall 
		
		# print the "base"
		li $v0, 1
		addi $a0, $t0, 0
		syscall
		
		# print "elevado a"
		li $v0, 4
		la $a0, msg_r2
		syscall 
		
		# print the "exp"
		li $v0, 1
		addi $a0, $t1, 0
		syscall
		
		# print "(mod"
		li $v0, 4
		la $a0, msg_r3
		syscall
		
		# print the "mod"
		li $v0, 1
		addi $a0, $t2, 0
		syscall
		
		# print ") eh"
		li $v0, 4
		la $a0, msg_r4
		syscall
		
		# print the "result"
		li $v0, 1
		addi $a0, $t3, 0
		syscall
		
		jr $ra
		
	end_program:
