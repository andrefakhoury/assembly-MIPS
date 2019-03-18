	.data
str_menu: .asciiz "Selecione uma opcao:\n1. Soma de dois numeros\n2. Subtracao de dois numeros\n3. Multiplicacao de dois numeros\n4. Divisao de dois numeros\n5. Potencia\n6. Raiz Quadrada\n7. Tabuada de um numero\n8. Calculo do IMC\n9. Fatorial de um numero\n10. Fibonacci\n0. Encerrar o programa\n"
str_num:  .asciiz "Digite um numero: "
str_num_float:  .asciiz "Digite um numero de ponto flutuante: "
str_sum:  .asciiz " + "
str_sub:  .asciiz " - "
str_mul:  .asciiz " * "
str_div:  .asciiz " / "
str_pot:  .asciiz " ^ "
str_equ:  .asciiz " = "
str_sqt:  .asciiz "Raiz quadrada de "
str_fat:  .asciiz "Fatorial de "
str_fibo:  .asciiz "Fibonacci de "
str_imc:  .asciiz "IMC de peso "
str_altu: .asciiz " e altura "
str_endl: .asciiz "\n"

	.text
	.globl main
	
main:
	li $v0, 4		# # #
	la $a0, str_menu	# imprime a opcao de menu
	syscall			# # #
	
	li $v0, 5		# le a opcao desejada
	syscall			# # #
	
	move $t0, $v0		# t0 = opcao digitada no menu
	
	addi $t1, $zero, 1	# t1 = 1, opcao de soma
	beq $t0, $t1, soma	# vai para a soma
	
	addi $t1, $zero, 2	# t1 = 2, opcao de subtracao
	beq $t0, $t1, subtracao	# vai para a subtracao
	
	addi $t1, $zero, 3		# t1 = 3, opcao de multiplicacao
	beq $t0, $t1, multiplicacao 	# vai para a multiplicacao
	
	addi $t1, $zero, 4	# t1 = 4, opcao de divisao
	beq $t0, $t1, divisao	# vai para a divisao
	
	addi $t1, $zero, 5	# t1 = 5, opcao de potencia
	beq $t0, $t1, potencia	# vai para a potencia
	
	addi $t1, $zero, 6	# t1 = 6, opcao de raiz quadrada
	beq $t0, $t1, raiz	# vai para a raiz quadrada
	
	addi $t1, $zero, 7	# t1 = 7, opcao de tabuada
	beq $t0, $t1, tabuada	# vai para a tabuada
	
	addi $t1, $zero, 8	# t1 = 8, opcao de IMC
	beq $t0, $t1, calc_imc	# vai para o IMC
	
	addi $t1, $zero, 9	# t1 = 9, opcao de fatorial
	beq $t0, $t1, fatorial	# vai para o fatorial
	
	addi $t1, $zero, 10	# t1 = 10, opcao de fibonacci
	beq $t0, $t1, fibonacci	# vai para o fibonacci
	
	addi $t1, $zero, 0	# t1 = 0, opcao de encerrar programa
	beq $t0, $t1, fim_prog	# encerra o programa
	
	j main			# o usuario digitou uma opcao invalida, voltando para o menu.

fim_prog:
	li $v0, 10		# termino do programa
	syscall		

le_num:
	li $v0, 4
	la $a0, str_num
	syscall
	
	li $v0, 5
	syscall
	
	jr $ra
	
soma:
	jal le_num
	move $t1, $v0
	
	jal le_num
	move $t2, $v0
	
	add $t3, $t1, $t2
	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_sum
	move $a3, $t3
	jal imp_res
	
	j main			#fim da execucao, volta para a main


subtracao:
	jal le_num
	move $t1, $v0
	
	jal le_num
	move $t2, $v0
	
	sub $t3, $t1, $t2
	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_sub
	move $a3, $t3
	jal imp_res
	
	j main			#fim da execucao, volta para a main
	
multiplicacao:
	jal le_num
	move $t1, $v0
	
	jal le_num
	move $t2, $v0
	
	mul $t3, $t1, $t2
	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_mul
	move $a3, $t3
	jal imp_res
	
	j main			#fim da execucao, volta para a main
			
divisao:
	jal le_num
	move $t1, $v0
	
	jal le_num
	move $t2, $v0
	
	div $t3, $t1, $t2
	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_div
	move $a3, $t3
	jal imp_res	
	
	j main			#fim da execucao, volta para a main
		
potencia:
	jal le_num
	move $t1, $v0
	
	jal le_num
	move $t2, $v0
	
	# tenho que fazer $t1 * $t1, $t2 vezes.
	li $t4, 0	#t4 sera o contador
	li $t3, 1	#t3 sera a minha resposta
	
loop_pot:
	beq $t4, $t2, fim_loop_pot
	mul $t3, $t3, $t1
	addi $t4, $t4, 1
	j loop_pot	
fim_loop_pot:	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_pot
	move $a3, $t3
	jal imp_res
	
	j main			#fim da execucao, volta para a main

raiz:
	li $v0, 4
	la $a0, str_num_float
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	sqrt.s $f2, $f1
	
	li $v0, 4
	la $a0, str_sqt
	syscall
	
	mov.s $f12, $f1
	li $v0, 2
	syscall
	
	li $v0, 4
	la $a0, str_equ
	syscall
	
	li $v0, 2
	mov.s $f12, $f2
	syscall
	
	li $v0, 4
	la $a0, str_endl
	syscall
	
	j main			#fim da execucao, volta para a main
	
tabuada:
	jal le_num
	move $t1, $v0
	
	# eu tenho que partir de 1 ate 10, e fazer a multiplicacao de t1 * atual
	
	li $t2, 1	# t2 = count
	li $t3, 11	# t3 = condicao de parada
	
loop_tabuada:
	beq $t2, $t3, fim_loop_tabuada
	mul $t4, $t1, $t2
	
	# imprime o resultado atual
	move $a0, $t1	# # #
	move $a1, $t2	# # #
	la $a2, str_mul	# # #
	move $a3, $t4	# # #
	jal imp_res	# # #
	# fim da impressao atual
	
	addi $t2, $t2, 1 # acrescenta o contador
	j loop_tabuada

fim_loop_tabuada:
	# acabou o loop, basta voltar a main
	j main			#fim da execucao, volta para a main
	

		
calc_imc:
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 6
	syscall	
	mov.s $f2, $f0
	
	# f1 = peso, f2 = altura
	mul.s $f3, $f2, $f2
	div.s $f3, $f1, $f3
	
	mov.s $f12, $f3
	li $v0, 2
	syscall
	
	j main			#fim da execucao, volta para a main


fatorial:
	jal le_num
	move $a0, $v0
	jal calc_fatorial_rec
	
	move $t1, $a0	#numero
	move $t2, $v0	#fatorial
	
	li $v0, 4
	la $a0, str_fat
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_equ
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, str_endl
	syscall
	
	j main
	
fibonacci:
	jal le_num
	move $a0, $v0
	jal calc_fibo_rec
	
	move $t1, $a0	#numero
	move $t2, $v0	#fibonacci
	
	li $v0, 4
	la $a0, str_fibo
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_equ
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, str_endl
	syscall
	
	j main
	


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
	
## Calcula o fatorial do numero enviado em $a0, e retorna em $v0.
calc_fatorial_rec:
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	
	li $t1, 1
	
	bne $a0, $t1, fac_rec
	li $v0, 1
	j return_rec
	
fac_rec:
	addi $a0, $a0, -1
	jal calc_fatorial_rec
	addi $a0, $a0, 1
	mul $v0, $a0, $v0
	
return_rec:	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra
		
## Calcula o fatorial do numero enviado em $a0, e retorna em $v0.
calc_fibo_rec:
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	
	li $t1, 1
	beq $a0, $t1, default_fibo
	li $t1, 2
	beq $a0, $t1, default_fibo
	
	addi $a0, $a0, -1
	jal calc_fibo_rec
	move $t0, $v0
	
	addi $a0, $a0, -1
	jal calc_fibo_rec
	move $t1, $v0
	
	add $v0, $t0, $t1
	j return_fibo_rec
	
default_fibo:
	li $v0, 1

return_fibo_rec:	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	addi $sp, $sp, 16
	jr $ra
	

		
## Imprime o resultado da operacao binaria no seguinte estilo: a OP b = c
## Sendo que OP deve ser uma string, representando a operacao (*, /, +, -, ...)
## Registradores utilizados:
## 	$a0 = a
##	$a1 = b
##	$a2 = OP
##	$a3 = c
## Obs: os registradores serao perdidos no meio do processo.
imp_res:
	li $v0, 1
	move $a0, $a0		# a
	syscall	
	
	li $v0, 4		#op
	move $a0, $a2
	syscall
	
	li $v0, 1
	move $a0, $a1		#b
	syscall	
	
	li $v0, 4
	la $a0, str_equ		# = 
	syscall
	
	li $v0, 1		# c
	move $a0, $a3
	syscall	
	
	li $v0, 4
	la $a0, str_endl	# pula linha
	syscall
	
	jr $ra
