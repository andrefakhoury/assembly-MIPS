# simple code to print "AOBA"

.data                     # directive of data declaration
	string:	.asciiz "AOBA"	# declaration of a string named string, with the value of "AOBA"
  
.text                     #directive of text segment
	.globl main

main:                     # label of main block - execution starts here

	la $a0, string
	li $v0, 4
	
	syscall

	li $v0, 10
	syscall