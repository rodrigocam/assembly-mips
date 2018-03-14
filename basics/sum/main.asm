.data
	input_message1: .asciiz "Enter first number: "
	input_message2: .asciiz "Enter second number: "
	result_message: .asciiz "The result is: "
	
.text

# ask for fisr number of the sum
li $v0, 4	 # 4 is the command to read an integer
la $a0, input_message1	# print what is in $a0, so we load the message defined above into $a0
syscall

# get first number
li $v0, 5 # 5 is the command to read an integer |  the number is stored in $v0 at the begining
syscall

# store first number by moving from $v0 to $t0
move $t0, $v0

# ask for second number of the sum
li $v0, 4
la $a0, input_message2
syscall

# get second number
li $v0, 5
syscall

# store second number
move $t1, $v0

# execute the sum and save the result on $t2
add $t2, $t0, $t1

# print result of the sum
li $v0, 4
la $a0, result_message
syscall

li $v0, 1
move $a0, $t2
syscall