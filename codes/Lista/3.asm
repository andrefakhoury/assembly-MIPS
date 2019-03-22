	.data
	
	.text
	.globl main
main:
	li $v0, 5
	syscall
	
	move $t0, $v0 #the initial number
	li $t1, 10 #number 10
	li $t2, 0 #cur number
	
loop:
	beq $t0, $zero, end_loop
	
	div $t0, $t1
	
	mfhi $t4
	mflo $t0
	
	mul $t2, $t2, $t1
	add $t2, $t2, $t4
	
	j loop
	
end_loop:	
	move $t0, $t2

	li $v0, 1
	move $a0, $t0
	syscall