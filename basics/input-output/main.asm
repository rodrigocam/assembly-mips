.text
	main:
		li $v0 5 # instruction to read an integer
		syscall
		
		move $a0 $v0 # the input is saved on $v0, so we move to $a0 for output
		li $v0 1 # print what was in $a0 (must be an integer)
		syscall