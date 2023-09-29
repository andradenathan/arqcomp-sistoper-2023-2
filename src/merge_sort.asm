.data
array:	.word 5,3,8,2,1,4,6,7
array_size:	.word 8
newline:    .asciiz "\n"

.text
.globl main

main:
	la $a0, array
	lw $a1, array_size
	
	jal merge_sort
	
	# Imprime o array ordenado
	la $a0, array
	lw $a1, array_size
	jal print_array
	
	# $v0 receber 10 significa que estamos chamando a syscall de finalizar o programa
	li $v0, 10
	syscall
	
merge_sort:
	# checa se o array_size > 1, caso seja 1, retorna o próprio array.
	li $t1, 1
	blt $a1, $t1, end_merge_sort
	
	srl $t0, $a1, 1
	
	add $t2, $a0, $t0
	add $t2, $t2, $t0
	sub $t3, $a1, $t0 
	
	jal merge_sort
	
	move $a0, $a0
	move $a1, $t0
	move $a2, $t2
	move $a3, $t3
	jal merge
		
end_merge_sort:
	jr $ra
	
merge:
	li $v0, 9
	li $t1, 4
	mul $t0, $a1, $t1
	syscall
	move $t4, $v0
	
	li $v0, 9
	mul $t0, $a3, $t1
	syscall
	move $t5, $v0
	
	li $t2, 0
	li $t3, 0
	li $t6, 0
	
merge_loop:
	lw $s0, 0($t4)
	lw $s1, 0($t5)
	bge $s0, $s1, copia
	
	sw $s0, 0($a0)
	addi $t2, $t2, 1
	j incrementa
	
copia:
	sw $s1, 0($a0)
	addi $t3, $t3, 1

incrementa:
	addi $t6, $t6, 1
	addi $a0, $a0, 4 # avança o ponteiro do array
	beq $t2, $a1, copia_restante
	
copia_restante:
	lw $s1, 0($t5)
	sw $s1, 0($a0)
	addi $t3, $t3, 1
	addi $t6, $t6, 1
	addi $a0, $a0, 4
	b termina_merge
	
termina_merge:
	li $v0, 10
	syscall
	jr $ra

print_array:
    li $t0, 0   # Inicializa o índice para percorrer o array

print_loop:
    beq $t0, $a1, print_done  # Se o índice atingir o tamanho, saia do loop

    lw $t1, 0($a0)   # Carrega o próximo elemento do array para $t1
    li $v0, 1        # Código do syscall para imprimir int
    move $a0, $t1    # Coloca o elemento em $a0 para impressão
    syscall

    li $v0, 4        # Código do syscall para imprimir string
    la $a0, newline  # Carrega a string de nova linha
    syscall

    addi $a0, $a0, 4   # Avança o ponteiro do array
    addi $t0, $t0, 1   # Incrementa o índice
    j print_loop

print_done:
    jr $ra
