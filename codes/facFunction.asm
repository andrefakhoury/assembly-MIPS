#int fatorial(int n) {
#	int fat = 1;
#	while (n > 1) fat *= n--;
#	return fat;
#}
#int main() {
#	int n;
#	printf("Digite 1 no: ");
#	scanf("%d", &n);
#	printf("O fatorial de %d eh %d", n, fatorial(n));
#}

.data
.align 0
	dig_str: .asciiz "Digite 1 no: "
	fat_str: .asciiz "O fatorial de "
	val_str: .asciiz " vale "

.text
.globl main

main:
	li $v0, 4		#prepara print
	la $a0, dig_str		#copia o text
	syscall			#printa na tela

	li $v0, 5		#prepara leitura
	syscall			#le um numero N
	move $t0, $v0		#move N para $t0
	
	addi $t1, $zero, 1	#t1 armazenara fat, comeca valendo 0
	# li $t1, 1
	
	add $t2, $zero, $t0	#salva o valor de N em t2 (cont)
	addi $t3, $zero, 1	#condicao de parada

calc:
	ble $t2, $t3, endloop
	mul $t1, $t1, $t2	#fat *= cont
	subi $t2, $t2, 1	#cont--
	j calc

endloop:
	li $v0, 4		#print
	la $a0, fat_str		#print "o fatorial de "
	syscall			#print
	
	li $v0, 1		#print
	move $a0, $t0		#print	n
	syscall			#print
	
	li $v0, 4		#print
	la $a0, val_str		#print	vale
	syscall			#print
	
	li $v0, 1		#print
	move $a0, $t1		#print fac
	syscall			#print
	
	li $v0, 10		#end
	syscall			#end