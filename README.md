# Resumo de Antes

## Sistema Operacional
Conjunto de hardware e software usado como ferramenta na solução de problemas.

Arquitetura é o conjunto de atributos visíveis ao programador (conj. de instruções, número de bits usados para representação de dados, mecanismos de E/S, etc).

Organização é como esses atributos estão implementados (sinais de controle, interfaces, tecnologia de memória).

Normalmente, as famílias de processador e tals compartilham a mesma arquitetura básica, mas a organização varia entre as diferentes versões.

## Arquitetura de von Neumann

Composta por conjunto de componentes lógicos básicos + programação.
- Dados e instruções são representados na memória;
- A memória é enderaçada pela posição e não pelo conteúdo; 
- A execução das instruções é considerada sequencial;

Hardware de proósito geral
- Programa determina uma sequência de passos; cada operação requer sinais de controle diferentes;

Função da Unidade de Controle
- Para cada operação, um código único é fornecido: ADD, MOVE...
- Função da unidade de controle: interpretar o código e gerar os sinais de controle que executarão a instrução requerida

### Componentes

CPU (UC + ULA)
- Patterson & Hennessy: UC + Caminho de Dados (barramento interno + unidades funcionais)

E/S - comunicação com o mundo exterior
- permite inserir dados e instruções no computador
- permite enviar resultados para fora do computador

Memória principal - responsável por:
- fornecer instruções e operandos para execução
- armazenar resultados fora da CPU

![Visao geral](https://i.imgur.com/rRJn4Uc.png)

### Registradores Principais

- PC: program counter - aponta para próx. instrução
- IR: Instruction Register - instrução que está sendo executada
- AC: Accumulator - armazena temporariamente alguns dados
- MAR: Memory Address Register
- MBR: Memory Buffer Register

### Ciclo de Instrução
Dois passos:
- Ciclo de busca (fetch)
- Ciclo de Execução (execute)

![ciclo de instrucao](https://i.imgur.com/o6HeGbm.png)

### Ciclo de Busca
(PC) já está com o endereço da próxima instrução a ser executada

(MAR) <- PC

(MBR) <- MEM(MAR)

(IR) <- (MBR)

(PC) <- (PC) + 1


### Ciclo de Execução
- Decodificação da instrução (UC decodifica a instrução e determina quais ações são necessárias, ou seja, a UC configura os sinais de controle de acordo com a instrução)
- A execução pode ser uma das instruções:

*Processador-Memória:* transferência de dados do processador para a memória ou da memória para o processador

*Processador-E/S:* transferência de dados entre o processador e um dispositivo de E/S

*Processamento de dados:* execução de operações aritméticas ou lógicas sobre os dados

*Controle:* especifica que a sequência de execução de instruções seja alterada

*Combinação dessas 4 possibilidades*

### Visão de uma Máquina Hipotética
Operações:
- 0001: (AC) <- (MEM)
- 0010: (MEM) <- (AC)
- 0101: (AC) <- (AC) + (MEM)

### Arquitetura Simples
Instruções de 16 bits:
endereço (12) | opcode (4)

# MIPS Assembly

## Architecture
MIPS: Microprocessor without interlocked pipeline stages
-32 bits
-32 "general purposes" registers
-32 "floating points" registers

## Labels
- Used to identify some line by reference.

## Data Types
Instructions are 32-bits.
- Byte (8 bits), halfword (2 bytes), word (4 bytes);
- 1 char requires 1 byte
- 1 integer requires 1 word

## Literals
-Numbers are represented just the way they are;
-Characters are represented by single quotes ('a')
-Strings are represented by double quotes ("aoba")

## Registers
The registers can be called by the register number ($0 .. $31) or by their specific names (like $t0).

![List of registers](https://www.cs.fsu.edu/~hawkes/cda3101lects/chap3/F3.13.gif)

## Program Structure
The declaration of data is identified by the directive *.data*. Storage is allocated in RAM.

The code is identified by the directive *.text*. Starting point is identified by the label *main:*. The "return 0;" is made by calling a *system call* on the ending point of main code.

Comments are made using hashtags.

Hello world example:

```assembly
# simple code to print "AOBA"

.data                           # directive of data declaration
	string:	.asciiz "AOBA"	# declaration of a string named string, with the value of "AOBA"
  
.text                           #directive of text segment
	.globl main

main:                           # label of main block - execution starts here
	la $a0, string          # copy adress of string to $a0
	li $v0, 4               # load immediate value into destination register. 4 = code for print_string
	syscall                 # calls the i/o

	li $v0, 10              # load code for exit
	syscall                 # calls the exit
```

## Data Declaration
```assembly
name: storage_type value(s)
```

Examples:

```assembly
var1:	.word 3         # creates integer with initial value 3
array1:	.byte 'a', 'b'	# creates 2-elements array
array2:	.space 40       # allocate 40 consecutive bytes. Can be used as 40 char or 10 integers.
str1:	.asciiz "OI"    # creates string with value "OI"
```

## Load/Store Instructions
RAM access are only allowed with these instructions. Other instructions must use register operands.

### Load:
```assembly
lw	REG_dest, RAM_src
```

```c
*REG_dest = *RAM_src; //copy word at source to destination
```

### Store Word:
```assembly
sw 	REG_src, RAM_dest
```

```c
*RAM_dest = *REG_src; //store word from src to dest
```

### Store Byte:
```assembly
sb 	REG_src, RAM_dest
```

```c
*RAM_dest = *REG_src; //store byte (low-order) from src to dest
```

### Load Immediate:
```assembly
li 	REG_dest, value
```

```c
*REG_dest = value; //store immediate value - no registers envolved
```

## Indirect and Based Addressing
Only used with load/store instructions

### Load Address
```assembly
la 	REG_dest, variable
```

```c
*REG_dest = variable;
```

OBS: Note that *la* is different from *li*. On *li*, a DIRECT VALUE is expected (e.g. 5). On *la*, a variable (pre-defined as a label) is used (e.g. var1).

### Indirect Addressing
Like pointer of pointer in C.

```assembly
lw 	$REG_dest, ($REG_src)

# e.g.:
lw $t2, ($t0)

# Load word at RAM address contained in $t0 into $t2.
```

```assembly
sw 	$REG_src, ($REG_dest)

# e.g.:
sw $t2, ($t0)

# Store word in $REG_src into RAM address contained in $REG_dest.
```

### Based or Indexed Addressing
We can also inform the offset we want.

```assembly
lw 	$t2, 4($t0)

# load word from RAM address ($t0+4) into register $t2.
```

Negative offset values can be used.

Based addressing is especially useful for arrays and stacks.

### Arithmetic Instructions
All operands are registers (no RAM or indirect addressing).

Operand size is a word (4 bytes).

```assembly
add	$t0,$t1,$t2	#  $t0 = $t1 + $t2;   add as signed (2's complement) integers
sub	$t2,$t3,$t4	#  $t2 = $t3 Ð $t4
addi	$t2,$t3, 5	#  $t2 = $t3 + 5;   "add immediate" (no sub immediate)
addu	$t1,$t6,$t7	#  $t1 = $t6 + $t7;   add as unsigned integers
subu	$t1,$t6,$t7	#  $t1 = $t6 + $t7;   subtract as unsigned integers

mult	$t3,$t4		#  multiply 32-bit quantities in $t3 and $t4, and store 64-bit
			#  result in special registers Lo and Hi:  (Hi,Lo) = $t3 * $t4
div	$t5,$t6		#  Lo = $t5 / $t6   (integer quotient)
			#  Hi = $t5 mod $t6   (remainder)
mfhi	$t0		#  move quantity in special register Hi to $t0:   $t0 = Hi
mflo	$t1		#  move quantity in special register Lo to $t1:   $t1 = Lo
			#  used to get at result of product or quotient

move	$t2,$t3	#  $t2 = $t3
```

## Control Structures

### Branches
```assembly
b	target		#  unconditional branch to program label target
beq	$t0,$t1,target	#  branch to target if $t0 == $t1
blt	$t0,$t1,target	#  branch to target if $t0 <  $t1
ble	$t0,$t1,target	#  branch to target if $t0 <= $t1
bgt	$t0,$t1,target	#  branch to target if $t0 >  $t1
bge	$t0,$t1,target	#  branch to target if $t0 >= $t1
bne	$t0,$t1,target	#  branch to target if $t0 != $t1
```

### Jumps
```assembly
j 	target		# Jump to target label
jr 	$t3             # jump to address contained in $t3
```

### Subroutine Calls
```assembly
jal 	sub_label	# jump and link

# copy PC to register $ra, then jump to sub_label
```

## System Calls
Previously, we saw on the AOBA code that syscall is used as system calls (i/o and stuff).

First of all, we must supply values for registers $v0 and $a0-$a1, so the program can find out what we want.

If some result value is provided, it is returned in register $v0.

![syscall codes](http://4.bp.blogspot.com/-Fh1GoVS32Vw/UMsvPVo5hNI/AAAAAAAAAF0/Of4mQ4dHewg/s640/mips.png)

## SLT - set on less than
The following code:
```assembly
SLT REG_tmp, REG_1, REG_2
```

Is equal to this:
```c
*REG_tmp = *REG_1 < *REG_2;
```

## Memory Access
-Each word has 32 bits
-Byte addressing: the starting address of each word always begin in a multiple of 4

## Endianness

### Big-Endian
-Stores the most significant byte at the lowest address.

A0BA0E41 will be stored like this:
A0 a
BA a+1
0E a+2
41 a+3

### Little-Endian
-Stores the most significant byte at the highest address.

A0BA0E41 will be stored like this:
41 a
0E a+1
BA a+2
A0 a+3

### Bi-Endian (MIPS)
-Mixed capacity, according to the host machine.

## .align

.align n: the data is stored in 2^n bytes (on the memory).

```assembly
.align 2	#align integer values (2^2 bytes)
.align 0	#align char values (2^0 bytes)
```

## Memory structure


|  RAM	   |
|:--------:|
|  STACK ↓ |
|   DATA ↑ |
|   CODE   |

On stack, we have a Stack Pointer. So, when pushing something to the stack, we have to move the ```sp``` down the stack. We make it by using ```addi $sp, $sp, - <qtt_words * 4>```.

Remember: ```jr``` points to the last used space.

A default function call:

```assembly
## Evaluates the factorial of $a0, storing the answer in $v0.
calc_factorial:
	addi $sp, $sp, -8	# # #
	sw $a0, 0($sp)		# pushing the numbers to the stack
	sw $ra, 4($sp)		# # #
	
	addi $v0, $zero, 1 #factorial	# # #
	addi $t1, $zero, 1 #count		# Setting default values
	
loop_fac:
	beq $a0, $t1, end_loop_fac	# # #
	mul $v0, $v0, $a0			# Basic loop to calculate the factorial
	addi $a0, $a0, -1			# Decreasing the a0 value
	j loop_fac					# # #

end_loop_fac:	
	lw $a0, 0($sp)		# # #
	lw $ra, 4($sp)		# Going back to the original values
	addi $sp, $sp, 8	# # #
	jr $ra				# Jumping back to the function that called it
```

## Memory commands

```assembly
lw $a0, 0($sp)
# $a0 -> dest reg
# 0 -> shift
# $sp -> base reg

sw $a0, 0($sp)
# inverse of lw

#lw: load from memory to reg
#sw: stores from reg to memory
```

Jump options:
- j label: just jump
- $ra = return address
- jal = jump and link: jump and $ra = PC
- jr $ra = jump register


## Dynamic Allocation

```assembly
li $v0, 9
li $a0, 40
syscall
```
- v0 = 9: opt code for allocation
- a0 = 40: bytes to alloc
- the first address of the alloc'd space is stored on $v0.
