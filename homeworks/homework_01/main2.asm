.data
	hexa:	.word	0x0000FACE
.text
	lw $t0, hexa # load the hexadecimal value into the temporary register $t0
	add $at,  $zero, $t0 # moving the hexa value from $t0 to $at register
	
	andi $t0, $at, 0x0F0F # this hexadecimal value is a mask | $t0 = 0x00000A0E
	
	srl $t1, $at, 4 # shift 4 bits to the right to get off with 'E' of the the 'hexa' variable | $t1 = 0x00000FAC
	sll $t1, $t1, 28 # shift 28 bits to the left to get off with 'FA' of the the 'hexa' variable | $t1 = 0xC0000000
	srl $t1, $t1, 16 # shift 16 bits to the right to align the two hexadecimals | $t1 = 0x0000C000
	
	srl $t2, $at, 12 # shift 12 bits to the right to get off with 'ACE'  of the 'hexa' variable | $t2 = 0x0000000F
	sll $t2, $t2, 4 # shift 4 bits to the left to align the two hexadecimals | $t2 = 0x000000F0
	
	or $t3, $t0, $t1 # join the hexadecimal 0x000000A0E with 0x0000C000 forming the hexadecimal 0x0000CA0E
	or $t2, $t2, $t3 # join the hexadecimal 0x00000CA0E with 0x000000F0 forming the hexadecimal 0x0000CAFE
	