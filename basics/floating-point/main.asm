.data
	message: .asciiz "O resultado é: "
	constant1: .float 5.4
	constant2: .float 12.3
	constant3: .float 18.23
	constant4: .float 8.23
.text
	li $v0, 6
	syscall
	mov.s $f2, $f0 # X
	
	li $v0, 6
	syscall
	mov.s $f4, $f0 # Y
	
	l.s $f6, constant1 # load the first constant
	
	mul.s $f6, $f6, $f2 # multiply 5.4 * X
	
	mul.s $f6, $f6, $f4 # multiply Y for the result of (5.4 * X)
	
	l.s $f8, constant2 # load the second constant
	
	mul.s $f8, $f8, $f4 # multiply 12.3 * Y
	
	sub.s $f6, $f6, $f8 # 5.4xy - 12.3y
	
	l.s $f8, constant3 # load the thirth constant
	
	mul.s $f8, $f8, $f2 # 18.23 * x
	
	l.s $f12, constant4 # load the forth constant
	
	sub.s $f8, $f8, $f12 # 18.23x - 8.23
	
	add.s $f6, $f6, $f8 # (5.4xy - 12.3y) + (18.23x - 8.23)
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 2
	mov.s $f12, $f6
	syscall