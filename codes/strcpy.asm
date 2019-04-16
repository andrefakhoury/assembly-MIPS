	.data
	.align 0
str1:	.space 10
str2:	.space 10

	.text
	.globl main

main:
	li $v0, 8		# # #
	la $a0, str1		# Le uma string
	li $a1, 10		# e guarda em str1
	syscall			# # #
	
	la $a0, str1
	jal tira_endl

	la $a0, str1		# # #
	jal calc_tamanho	# Calcula o tamanho de str1
	move $t0, $v0		# e guarda em t0
	
#	la $a0, str1		# # #
#	la $a1, str2		# Ajusta os parametros
#	move $a2, $t0		# Chama o strcpy
#	jal strcpy		# # #
	
#	la $a0, str2		# # #
#	li $v0, 4		# Imprime a string copiada
#	syscall			# # #
	
	li $v0, 8		# # #
	la $a0, str2		# Le uma string
	li $a1, 10		# e guarda em str2
	syscall			# # #	

	la $a0, str2		# # #
	jal calc_tamanho	# Calcula o tamanho de str2
	move $t1, $v0		# e guarda em t1
	
#	la $a0, str1
#	la $a1, str2
#	move $a2, $t0
#	move $a3, $t1
#	jal strcmp
	
#	move $a0, $v0
#	li $v0, 1
#	syscall
	
	la $a0, str1
	la $a1, str2
	move $a2, $t0
	move $a3, $t1
	jal strcat
	
	la $a0, str1
	li $v0, 4
	syscall
	
	li $v0, 10		# # #
	syscall			# Finaliza o programa


# # # #
# Tira o \n da string a0
tira_endl:
	lb $t0, 0($a0)
	beq $t0, $zero, end_loop_endl
	addi $a0, $a0, 1
	j tira_endl
end_loop_endl:
	addi $a0, $a0, -1
	sb $zero, 0($a0)
	jr $ra	

# # # #
# Calcula o tamanho da string mandada por $a0.
# Returns: $v0 - tamanho da string
# # # #
calc_tamanho:
	addi $sp, $sp, -12
	sw $t0, 8($sp)
	sw $a0, 4($sp)
	sw $ra, 0($sp)

	li $v0, 0

loop_tamanho:
	lb $t0, 0($a0)
	beq $t0, $zero, end_loop_tamanho
	addi $v0, $v0, 1
	addi $a0, $a0, 1
	j loop_tamanho

end_loop_tamanho:
	lw $t0, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra

# # # #
# Copia o conteudo de $a0 para $a1
# Parametros: $a0, $a1, $a2 (tamanho)
# # # #
strcpy:
	li $t0, 0	# $t0 = counter
	
loop_strcpy:
	beq $t0, $a2, end_loop_strcpy
	
	lb $t1, 0($a0)
	sb $t1, 0($a1)
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	addi $t0, $t0, 1
	j loop_strcpy
end_loop_strcpy:
	sb $zero, 0($a1)
	jr $ra



# # # #
# Compara duas strings mandadas em $a0 e $a1
# com tamanhos mandados em $a2 e $a3
# Retorno: $v0 = -1, 0 ou 1
# # # #
strcmp:
	move $s0, $a0
	move $s1, $a1
	
	move $t0, $a2
	move $t1, $a3
	
	blt $t0, $t1, menor
	bgt $t0, $t1, maior
	
	li $t3, 0
loop_strcmp:
	beq $t3, $t0, end_loop_strcmp
	
	lb $t4, 0($s0)
	lb $t5, 0($s1)
	
	blt $t4, $t5, menor
	bgt $t4, $t5, maior
	
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	addi $t3, $t3, 1
	j loop_strcmp
end_loop_strcmp:
	j igual
	
	
maior:	li $v0, 1
	j fim_strcmp
menor:	li $v0, -1
	j fim_strcmp
igual:	li $v0, 0
	j fim_strcmp

fim_strcmp:
	jr $ra
	
	

# # # #
# Concatena $a0 com o conteudo de $a1
# Tamanhos vao em $a2 e $a3
# Retorna nada
# # # #
strcat:
	add $a0, $a0, $a2	
	li $t2, 0

loop_strcat:
	beq $t2, $a3, end_loop_strcat
	
	lb $t4, 0($a1)
	sb $t4, 0($a0)
	
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	addi $t2, $t2, 1
	j loop_strcat
end_loop_strcat:
	sb $zero, 0($a0)
	jr $ra