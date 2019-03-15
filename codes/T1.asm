	.data
str_menu: .asciiz "Selecione uma opcao:\n1. Soma de dois numeros\n2. Subtracao de dois numeros\n3. Multiplicacao de dois numeros\n4. Divisao de dois numeros\n5. Potencia\n6. Raiz Quadrada\n7. Tabuada de um numero\n8. Calculo do IMC\n9. Fatorial de um numero\n10. Fibonacci\n0. Encerrar o programa\n"
str_num:  .asciiz "Digite um numero: "
str_sum:  .asciiz " + "
str_sub:  .asciiz " - "
str_mul:  .asciiz " * "
str_div:  .asciiz " / "
str_pot:  .asciiz " ^ "
str_equ:  .asciiz " = "
str_endl: .asciiz "\n\n"

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
	
	addi $t1, $zero, 5	# t1 = 4, opcao de potencia
	beq $t0, $t1, potencia	# vai para a potencia
	
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
	jal le_num
	move $t1, $v0
	
	div $t3, $t1, $t2
	
	move $a0, $t1
	move $a1, $t2
	la $a2, str_div
	move $a3, $t3
	jal imp_res	
	
	j main			#fim da execucao, volta para a main
	
	
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