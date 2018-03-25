.text
	ori $1, $0, 0x01
	sll $1, $1, 1 # set the first bit of the register 1 and so on for each register till register 7
	sll $2, $1, 1
	sll $3, $2, 1
	sll $4, $3, 1
	sll $5, $4, 1
	sll $6, $5, 1
	sll $7, $6, 1