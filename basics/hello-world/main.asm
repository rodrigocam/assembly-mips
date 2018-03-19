.data
	message: 	.asciiz	"Hello World"
.text
	main:
		li $v0 4 # four is the instruction to print a string
		la $a0 message # load the address of the variable 'message' to the register that syscall use to print
		syscall