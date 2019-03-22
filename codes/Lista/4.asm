	.data
str1: 	.asciiz "begin "
str2:	.asciiz "end.\n"	
	
	.text
	.globl main
	
main:
	li $t0, 0 	# count the number of characters
	
loop_count:
	lb $t1, str1($t0)
	beq $t1, $zero, end_loop_count
	
	addi $t0, $t0, 1
	j loop_count
end_loop_count:

	li $t1, 0
		
loop_count2:
	lb $t2, str2($t1)
	beq $t2, $zero, end_loop_count2
	
	addi $t1, $t1, 1
	j loop_count2
end_loop_count2:	
	
	# strlen(str1) = t0
	# strlen(str2) = t1
	
	li $t3, 0
	
loop_cat:
	beq $t3, $t1, end_loop_cat
	
	lb $t2, str2($t3)
	add $t4, $t0, $t3
	sb $t2, str1($t4)
	
	addi $t3, $t3, 1
	
	j loop_cat
end_loop_cat:

	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 10
	syscall