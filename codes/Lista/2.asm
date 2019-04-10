## Calcula o fatorial do numero enviado em $a0, e retorna em $v0.
calc_fatorial:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	addi $v0, $zero, 1 #fatorial
	addi $t1, $zero, 1 #count
	
loop_fac:
	beq $a0, $t1, fim_loop_fac
	mul $v0, $v0, $a0
	addi $a0, $a0, -1
	j loop_fac

fim_loop_fac:	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra