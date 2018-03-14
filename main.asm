.data
first_value: .word 0
second_value: .word 0

.text
# get first integer from user
li $v0, 5
syscall
sw $v0, first_value

# get second integer from user
li $v0, 5
syscall
sw $v0, second_value

#print first value
li $v0, 1
la $a0, first_value
syscall