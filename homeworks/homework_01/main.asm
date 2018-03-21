.data
	hexa:	.word	0x55555555
.text
	lw $t0, hexa # load the hexadecimal value into the temporary register $t0
	add $at,  $zero, $t0 # moving the hexa value from $t0 to $at register
	
	sll $v0, $at, 1 # shift the hexadecimal value of one position and save on $v0
	or $v1, $at, $v0 # bitwise 'or' between the hexadecimal value and its shifted value and save in $v1
	and $a0, $at, $v0 # bitwise 'and' between the hexadecimal value and its shifted value and save in $a0
	xor $a1, $at, $v0 # bitwise 'xor' between the hexadecimal value and its shifted value and save in $a1
	
	
# results:
# $v0 (left shifted hexadecimal value) - 0xaaaaaaaa
# $v1 (bitwise 'or' between hexadecimal and its shifted value) - 0xffffffff
# $a0 (bitwise 'and' between hexadecimal and its shifted value) - 0x00000000
# $a1 (bitwise 'xor' between hexadecimal and its shifted value)  - 0xffffffff
