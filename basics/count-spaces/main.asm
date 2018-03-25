.data
	input_string: .space 80 # 80 bytes of memory allocated for the string
	space_representation: .byte 32 # space decimal representation on ascii table
.text
	main:
		### GETTING THE STRING FROM THE USER ###
		li $v0, 8 # command to get a string from console
		la $a0, input_string # map the address of 'input_string' to $a0, so when we get the string, it will be stored on 'input_string'
		li $a1, 80 # maximum number of bytes(characters) that should be read in
		syscall

		lb $t1, space_representation # space representation to compare
		li $s0, 0 # index of the array
		li $s1, 0 # amount of spaces on the string
		
		### LOOP OVER THE INPUT STRING  AND COMPARE IF WE REACHED A SPACE ###
		loop:
			lb $t2, input_string($s0) # get the character on the index position
			beq $t2, 0, end_loop # if we reached the end of the string, stop loop
			beq $t2, $t1, increase_space_counter # if we find a space, increase the space counter
			increase_array_index:
				addi $s0, $s0, 1 # increase the index of the array
			j loop # the magic of the loop, always sending to the begining
		end_loop:
			j print_result # at this point we alredy checked all the characters on the string, so print the number of spaces found
	
	increase_space_counter:
		addi $s1, $s1, 1 # add the space counter by one
		j increase_array_index # return to the normal flow of the loop
	
	print_result:
		li $v0, 1 # instruction to print an integer
		addi $a0, $s1, 0 # move the content of $s1 to $a0, for printing
		syscall
		
