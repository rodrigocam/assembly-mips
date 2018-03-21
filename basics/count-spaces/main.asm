.data
	input_string:	.space 	80 # 80 bytes of memory allocated for the string
	space_representation:	.ascii		" "
.text
	main:
		li $v0 8 # command to get a string from console
		la $a0 input_string # map the address of 'input_string' to $a0, so when we get the string, it will be stored on 'input_string'
		li $a1 80 # maximum number of charcaters that should be read in
		syscall
		
		la $t0 space_representation
		
		
		li $v0 4
		la $a0 input_string
		syscall