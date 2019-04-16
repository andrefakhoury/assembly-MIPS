#***************************************************************#
#                                                               #
#        Calculadora que executa determinadas funcoes.          #
#                                                               #
# Feito por:                                                    #
#       André Luís Mendes Fakhoury, 4482145                     #
#       David Cairuz da Silva, 10830061                         #
#       Gustavo Vinicius Vieira Silva Soares, 10734428          #
#       Thiago Preischadt Pinheiro, 10723801                    #
#                                                               #
# Docente: Sarita Mazzini Bruschi                               #
#                                                               #
#           USP - São Carlos. 2019                              #
#                                                               #
#***************************************************************#

		.data
str_menu:	.asciiz "Selecione uma opcao:\n1. Soma de dois numeros\n2. Subtracao de dois numeros\n3. Multiplicacao de dois numeros\n4. Divisao de dois numeros\n5. Potencia\n6. Raiz Quadrada\n7. Tabuada de um numero\n8. Calculo do IMC\n9. Fatorial de um numero\n10. Fibonacci\n0. Encerrar o programa\n"
str_num:	.asciiz "Digite um numero: "
str_num_float:	.asciiz "Digite um numero de ponto flutuante: "
str_peso:	.asciiz "Digite o peso: "
str_altura:	.asciiz "Digite a altura em metros: "
str_imc:	.asciiz "O IMC e: "
str_sum:	.asciiz " + "
str_sub:	.asciiz " - "
str_mul:	.asciiz " * "
str_div:	.asciiz " / "
str_pot:	.asciiz " ^ "
str_equ:	.asciiz " = "
str_sqt:	.asciiz "Raiz quadrada de "
str_fat:	.asciiz "Fatorial de "
str_fibo:	.asciiz "A sequencia de fibonacci no intervalo ["
str_fibo2:	.asciiz "] e: "
str_endl:	.asciiz "\n"
str_space:	.asciiz " "
str_comma:	.asciiz ", "
str_invalido:	.asciiz "O valor inserido e invalido.\n"
str_res_inv:	.asciiz "Resultado invalido. Valores inseridos geraram um resultado grande demais.\n"

		.text
		.globl main

main:
		li $v0, 4		# # #
		la $a0, str_menu	# Imprime o menu com todas as opcoes
		syscall			# # #

		li $v0, 5		# Le a opcao inserida pela usuario
		syscall			# # #

		move $t0, $v0		# t0 = Opcao digitada pelo usuario
	
		addi $t1, $zero, 1	# t1 = 1 (Soma)
		beq $t0, $t1, soma	# Vai para soma
	
		addi $t1, $zero, 2	# t1 = 2 (Subtracao)
		beq $t0, $t1, subtracao	# Vai para subtracao
	
		addi $t1, $zero, 3	# t1 = 3 (Multiplicacao)
		beq $t0, $t1, multip 	# Vai para a multiplicacao
	
		addi $t1, $zero, 4	# t1 = 4 (Divisao)
		beq $t0, $t1, divisao	# Vai para a divisao

		addi $t1, $zero, 5	# t1 = 5 (Potencia)
		beq $t0, $t1, potencia	# Vai para a potencia
	
		addi $t1, $zero, 6	# t1 = 6, opcao de raiz quadrada
		beq $t0, $t1, raiz	# vai para a raiz quadrada
	
		addi $t1, $zero, 7	# t1 = 7 (Tabuada)
		beq $t0, $t1, tabuada	# Vai para a tabuada
	
		addi $t1, $zero, 8	# t1 = 8 (IMC)
		beq $t0, $t1, calc_imc	# Vai para o IMC
	
		addi $t1, $zero, 9	# t1 = 9 (Fatorial)
		beq $t0, $t1, fatorial	# Vai para o fatorial
	
		addi $t1, $zero, 10	# t1 = 10 (Fibonacci)
		beq $t0, $t1, fibonacci	# Vai para o fibonacci
	
		addi $t1, $zero, 0	# t1 = 0 (Encerra o programa)
		beq $t0, $t1, fim_prog	# Encerra o programa
	
		j invalido		# Opcao invalida
	
fim_prog:
		li $v0, 10		# Termina a execucao do programa
		syscall		


## Utilizada diversas vezes para ler os valores inseridos
## Pede que o usuario insira um valor inteiro e verifica
## Se e um valor valido.
le_num:
		li $v0, 4
		la $a0, str_num 	# Pede que o usuario digite um numero
		syscall

		li $v0, 5		# Le o numero inserido pelo usuario
		syscall

		bltz $v0, invalido 	# Impede que numeros negativos sejam inseridos

		jr $ra


## Informa o usuario que o valor inserido nao e valido
## e retorna para a main.	
invalido:
		li $v0, 4
		la $a0, str_invalido 	# Informa o usuario que o valor inserido e invalido.
		syscall

		j main		     	# Retorna para a main


## Realiza a soma de dois numeros
## Registradores utilizados:
##	$t1: Primeiro numero
##	$t2: Segundo numero
##	$t3: Resultado		
soma:
		jal le_num		# Le o primeiro numero
		move $t1, $v0

		jal le_num		# Le o segundo numero
		move $t2, $v0

		add $t3, $t1, $t2	# Realiza a soma

		move $a0, $t1		# Movendo os argumentos da funcao
		move $a1, $t2		# que imprime o resultado da operacao
		la $a2, str_sum		# realizada para o usuario
		move $a3, $t3
		jal imp_res		# Imprimindo resultado

		j main			# Fim da execucao, volta para a main


## Realiza a subtracao de dois numeros
## Registradores utilizados:
##	$t1: Primeiro numero
##	$t2: Segundo numero
##	$t3: Resultado	
subtracao:
		jal le_num		# Le o primeiro numero
		move $t1, $v0

		jal le_num		# Le o segundo numero
		move $t2, $v0

		sub $t3, $t1, $t2	# Realiza a subtracao

		move $a0, $t1		# Movendo os argumentos da funcao
		move $a1, $t2
		la $a2, str_sub
		move $a3, $t3
		jal imp_res		# Imprimindo resultado

		j main			# Fim da execucao, volta para a main


## Realiza a multiplicacao de dois numeros de 16 bits.
## Registradores utilizados:
##	$t1: Primeiro numero
##	$t2: Segundo numero
##	$t3: Resultado		
multip:
		jal le_num		# Le o primeiro numero
		move $t1, $v0

		addi $t6, $zero, 32767
		bgt $t1, $t6, invalido 	# Verifica se o numero cabe em 16 bits

		jal le_num		# Le o segundo numero
		move $t2, $v0

		bgt $t2, $t6, invalido 	# Verifica se o numero cabe em 16 bits

		mul $t3, $t1, $t2	# Realiza a multiplicacao

		move $a0, $t1		# Move os argumentos da funcao de impressao
		move $a1, $t2
		la $a2, str_mul
		move $a3, $t3
		jal imp_res		# Imprime resultado na tela

		j main			# Fim da execucao, volta para a main


## Realiza a divisao de dois numeros
## Registradores utilizados:
##	$t1: Primeiro numero
##	$t2: Segundo numero
##	$t3: Resultado				
divisao:
		jal le_num		# Le o primeiro numero
		move $t1, $v0

		jal le_num		# Le o segundo numero
		move $t2, $v0

		beq $t2, $zero, invalido # Verifica se o denominador e diferende de 0

		div $t3, $t1, $t2	# Realiza a divisao

		move $a0, $t1		# Move os argumentos para funcao de impressao
		move $a1, $t2
		la $a2, str_div
		move $a3, $t3
		jal imp_res		# Imprime resultado na tela

		j main			# Fim da execucao, volta para a main


## Multiplica um numero n vezes por ele mesmo
## Registradores utilizados:
##	$t1: Base
##	$t2: Expoente
##	$t3: Resultado			
potencia:
		jal le_num		# Le a base
		move $t1, $v0

		jal le_num		# Le o expoente
		move $t2, $v0

	# Faremos $t1 * $t1, $t2 vezes.

		li $t4, 0		#t4 = contador
		li $t3, 1		#t3 = resposta

loop_pot:
		beq $t4, $t2, fim_loop_pot # Quando t4 == t2, acabamos
		mul $t3, $t3, $t1
		addi $t4, $t4, 1
		j loop_pot

fim_loop_pot:	
		move $a0, $t1		# Movendo argumentos para funcao de impressao
		move $a1, $t2
		la $a2, str_pot
		move $a3, $t3

		jal imp_res		# Imprimindo a resposta

		j main			# Fim da execucao, volta para a main


## Calcula a raiz quadrada de um numero
## Registradores utilizados:
##	$f1: Numero
##	$f2: Resultado	
raiz:
		li $v0, 4
		la $a0, str_num_float	# Pede que um numero seja digitado
		syscall

		li $v0, 6
		syscall			# Le um numero de ponto flutuante
		mov.s $f1, $f0

		sqrt.s $f2, $f1		# Calcula a raiz quadrada

		li $v0, 4
		la $a0, str_sqt		# Linhas abaixo exibem a resposta formatada
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

		j main			# Fim da execucao, volta para a main


## Exibe a tabuada de um numero de 1-10
## Registradores utilizados:
##	$t1: Numero desejado
tabuada:
		jal le_num
		move $t1, $v0		# Le numero

		# Partiremos de 1 ate 10, e faremos a multiplicacao de t1 * atual

		li $t2, 1		# t2 = contador
		li $t3, 11		# t3 = condicao de parada

loop_tabuada:
		beq $t2, $t3, fim_loop_tabuada
		mul $t4, $t1, $t2

		# Imprime o resultado atual
		move $a0, $t1	
		move $a1, $t2	
		la $a2, str_mul	
		move $a3, $t4	
		jal imp_res	

		addi $t2, $t2, 1 	# Incrementa o contador
		j loop_tabuada

fim_loop_tabuada:
		# Fim do loop, basta voltar a main
		j main			# Fim da execucao, volta para a main


## Calcula o IMC baseado nos dados inseridos pelo usuario.
## Registradores utilizados:
##	$f1: Peso inserido
##	$f2: Altura inserida
##	$f3: Resposta
calc_imc:
		li $v0, 4
		la $a0, str_peso	# Pede que um numero seja digitado
		syscall

		li $v0, 6
		syscall
		mov.s $f1, $f0		# Lendo peso, f1 = peso

		li $v0, 4
		la $a0, str_altura	# Pede que um numero seja digitado
		syscall

		li $v0, 6
		syscall	
		mov.s $f2, $f0		# Lendo altura, f2 = altura

		mul.s $f3, $f2, $f2	# Realizando as contas
		div.s $f3, $f1, $f3

		li $v0, 4
		la $a0, str_imc		# Indicador de resposta
		syscall

		mov.s $f12, $f3
		li $v0, 2		# Exibindo a resposta
		syscall

		li $v0, 4
		la $a0, str_endl	
		syscall

		j main			# Fim da execucao, volta para a main


## Calcula o fatorial de um numero inserido pelo usuario
## Registradores utilizados:
##	$t1: Numero inserido
##	$t2: Resultado retornado pela funcao
fatorial:
		jal le_num
		move $a0, $v0
		jal calc_fatorial_rec	# Chama a funcao para calcular

		move $t1, $a0		# Numero
		move $t2, $v0		# Fatorial

		li $v0, 4		# Imprimindo resultado
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

## Calcula o fatorial do numero enviado em $a0, e retorna em $v0.
calc_fatorial_rec:
		addi $sp, $sp, -8	# Empilhando registradores
		sw $a0, 0($sp)
		sw $ra, 4($sp)

		li $t1, 1

		bne $a0, $t1, fac_rec	# caso base
		li $v0, 1
		j return_rec

fac_rec:
		addi $a0, $a0, -1
		jal calc_fatorial_rec	# Chamada da funcao recursiva
		addi $a0, $a0, 1
		mul $v0, $a0, $v0	# Multiplicacao

return_rec:	
		lw $a0, 0($sp)		# Desempilha valores e encerra a funcao
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra

## Calcula fibonacci em um range [a, b]
## Regitradores utilizados:
##	$t8: Primeiro numero
##	$t9: Segundo numero
##	Alguns registradores auxiliares
fibonacci:
		addi $sp, $sp, -28	# Empilhando registradores
		sw $a0, 0($sp)
		sw $v0, 4($sp)
		sw $t8, 8($sp)
		sw $t9, 12($sp)
		sw $t0, 16($sp)
		sw $t1, 20($sp)
		sw $t2, 24($sp)

		jal le_num
		move $t8, $v0 		# Le o primeiro numero do intervalo

		jal le_num
		move $t9, $v0		# Le o segundo numero do intervalo

		blt $t9, $t8, invalido 	# Verifica se temos um intervalo valido (a < b)

		li $v0, 4
		la $a0, str_fibo	# Indicador de resposta
		syscall

		li $v0, 1
		move $a0, $t8		# Primeiro numero
		syscall

		li $v0, 4
		la $a0, str_comma	#  Virgula
		syscall

		li $v0, 1
		move $a0, $t9		# Segundo numero
		syscall

		li $v0, 4
		la $a0, str_fibo2	# Indicador de resposta
		syscall

		addi $t8, $t8, -1

		# Casos base
		li $t1, 1		# f(x+1)
		li $t2, 1		# f(x)
		li $t0, 1		# x

fib_loop:
		# se x > a - 1, imprime
		slt $t3, $t9, $t0
		bgt $t3, $zero, fib_end

		slt $t3, $t8, $t0
		bgt $t3, $zero, fib_print
		j fib_continue

fib_print:
		li $v0, 1		# imprime a resposta atual
		move $a0, $t2
		syscall

		li $v0, 4
		la $a0, str_space
		syscall

fib_continue:
		# Calcula o proximo elemento
		move $t3, $t1
		add $t1, $t1, $t2
		move $t2, $t3
		addi $t0, $t0, 1
		j fib_loop

fib_end:
		move $t1, $a0		# Numero
		move $t2, $v0		# Fibonacci

		li $v0, 4
		la $a0, str_endl
		syscall

		lw $a0, 0($sp)		# desempilha
		lw $v0, 4($sp)
		lw $t8, 8($sp)
		lw $t9, 12($sp)
		lw $t0, 16($sp)
		lw $t1, 20($sp)
		lw $t2, 24($sp)
		addi $sp, $sp, 28

		j main

## Imprime o resultado da operacao binaria no seguinte estilo: a OP b = c
## Sendo que OP deve ser uma string, representando a operacao (*, /, +, -, ...)
## Registradores utilizados:
## 	$a0 = a
##	$a1 = b
##	$a2 = OP
##	$a3 = c
##
## OBS: Os registradores serao perdidos no meio do processo.
imp_res:
		li $v0, 1
		move $a0, $a0		# a
		syscall	

		li $v0, 4		#op
		move $a0, $a2
		syscall

		li $v0, 1
		move $a0, $a1		# b
		syscall	

		li $v0, 4
		la $a0, str_equ		# = 
		syscall

		li $v0, 1		# c
		move $a0, $a3
		syscall	

		li $v0, 4
		la $a0, str_endl	# Pula um linha
		syscall

		jr $ra
