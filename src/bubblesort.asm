.data
A: .word 5, 2, 9, 3, 4
tamanho: .word 5

.text
.globl main

main:
	la $a0, A # $a0 = &A
	lw $t0, tamanho # $t0 = tamanho
	li $t1, 0 # i = 0
	li $t2, 0 # j = 0
for:
	li $t2, 0 # j = 0
while:
	mul $t3, $t2, 4 
	add $t4, $a0, $t3 
	lw $t5, ($t4) # $t5 = A[j]
	lw $t6, 4($t4) # $t6 = A[j+1]
	
	ble $t5, $t6, increment
	
	# swap variaveis
	sw $t5, 4($t4)
	sw $t6, ($t4)	
increment:
	addi $t2, $t2, 1
	blt $t2, $t0 while # j++
	
	addi $t1, $t1, 1 # i++
	blt $t1, $t0, for
	
	li $v0, 10
	syscall