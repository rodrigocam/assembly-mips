.# ------------------- harmonic series -----------------
.data
	counter: .double 1
	constant: .double 1
	initial_result: .double 0
	message: .asciiz "The harmonic series sum is: "
.text
	# -- input number of terms --
	li $v0, 7
	syscall
	
	l.d $f2, counter # loop counter i = 1
	l.d $f4, constant # constant 1
	l.d $f8, initial_result # initiate the result with 0 ( result = 0 )
	
	add.d $f0, $f0, $f4 # increment the number of terms by 1 because the loop counter begins with 1

	loop:
		c.eq.d $f0, $f2 # if $f0 == $f2 true ( i == input value)
		bc1t end_loop # end loop if counter reaches the input value
		
		# loop instructions
		div.d $f6, $f4, $f2
		add.d $f8, $f8, $f6
			
		add.d $f2, $f2, $f4 # increment 1
		j loop
	end_loop:
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 3
	mov.d $f12, $f8
	syscall