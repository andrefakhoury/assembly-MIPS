	.data
str1: 	.asciiz "zZZABA"
str2:	.asciiz "DBABA"	
str_e: 	.asciiz "EQUAL!"	
str_s: 	.asciiz "FIRST IS GREATER!"
str_g: 	.asciiz "FIRST IS SMALLER!"
	
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
	
	blt $t0, $t1, greater_str
	bgt $t0, $t1, smaller_str
	
	li $t3, 0
loop_cmp:
	beq $t3, $t1, equal_str
	
	lb $t4, str1($t3)
	lb $t5, str2($t3)
	
	blt $t4, $t5, greater_str
	bgt $t4, $t5, smaller_str
	
	addi $t3, $t3, 1
	
	j loop_cmp
	
equal_str:
	la $a0, str_e
	j end_main

greater_str:
	la $a0, str_g
	j end_main
	
smaller_str:
	la $a0, str_s

end_main:
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
