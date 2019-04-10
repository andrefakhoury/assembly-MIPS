###
# Bubble Sort
###

	.data
	.align 2
vet:	.word 1, 4, 2, 5

	.text
	.globl main

main:
	li $t0, 4	# $t0 = MAX
	
	la $s0, vet	# $s0 = array
	la $s1, vet
	addi $s1, $s1, 	$t0
	addi $s1, $s1, 	$t0
	addi $s1, $s1, 	$t0
	
	
	li $t1, 0	# $t1 = counter i
loop_i:
	beq $t1, $t0, end_loop_i
	
	move $s2, $s1
	addi $s3, $s1, -4
	addi $t2, $t0, -1
	
loop_j:
	beq $t1, $t2, end_loop_j
	
	lw $t4, 0($s2) # vet(j)
	lw $t5, 0($s3) # vet(j-1)
	
#senum[j-1] > num[j]entãoaux := num[j-1];num[j-1] := num[j];num[j]:= aux; 
	ble $t5, $t4, final_loop_j
	move $a0, $t5
	move $a1, $t6
	jal swap_num
	
final_loop_j:
	addi $s3, $s3, -4
	addi $s2, $s2, -4
	addi $t2, $t2, -1
	j loop_j
end_loop_j:
	
	addi $t1, $t1, 1
	j loop_i
end_loop_i:
	
	
	li $v0, 10
	syscall