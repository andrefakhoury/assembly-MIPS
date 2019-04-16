	.data
	.align 0
str: .space 10

	.text
main:
	li $v0, 8
	la $a0, str
	li $a1, 10 # tamanho
	syscall

	## ja mandou pro label da str


################

	.data
	.text
main:
	## aloca espaco
	li $v0, 9
	li $a0, 10 # tamanho
	syscall

	## salva o q alocou
	move $s0, $v0

	## le string
	li $v0, 8
	move $a0, $s0
	li $a1, 10
	syscall