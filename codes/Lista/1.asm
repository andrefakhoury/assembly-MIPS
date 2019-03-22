	.data
vet:	.word 1, 5, 3, 7, 6
str_endl: .asciiz "\n"
str_spc: .asciiz " "
	
	.text
	.globl main
main:
	li $t3, 20	#T3 = MAX
	li $t0, 0	#t0 = i = 1
	
loopi:
	beq $t0, $t3, end_loopi
	
	move $t1, $t3	 #j = MAX
	addu $t1, $t1, -4
	
loopj:
	beq $t1, $t0, end_loopj
	
	move $t2, $t1
	addi $t2, $t2, -4 #t2 = j-1
	
	lw $t5, vet($t2) #t5 =num(j-1)
	lw $t6, vet($t1) #t6 =num(j)
	
	bge $t6, $t5, end_if
	
	move $t7, $t5
	sw $t6, vet($t2)
	sw $t7, vet($t1)
	
end_if:
	addi $t1, $t1, -4
	j loopj
end_loopj:
		
	addi $t0, $t0, 4
	j loopi
end_loopi:

	jal print_vet
		
	li $v0, 10
	syscall


print_vet:
	li $s0, 0
loopp2:
	beq $s0, $t3, end_loopp2
	
	lw $a0, vet($s0)
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, str_spc
	syscall
	
	addi $s0, $s0, 4
	j loopp2
	
end_loopp2:	
	li $v0, 4
	la $a0, str_endl
	syscall
	
	jr $ra

