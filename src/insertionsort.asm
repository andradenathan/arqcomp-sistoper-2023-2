.data
A:     .word 5, 2, 9, 1, 6
tamanho: .word 5

.text
.globl main

main:
    la $a0, A  # carrega o endereço de A em $a0
    lw $a1, tamanho # carrega o endereço de tamanho em $a1
    
    jal insertion_sort 
    
    li $v0, 10
    syscall
insertion_sort:
    li $t0, 1                  # i = 1
for:
    beq $t0, $a1, end_for     # Se i == tamanho, encerra o for

    lw $t1, 0($a0)            # aux = array[i]
    subi $t2, $t0, 1          # j = i - 1
while:
	blt $t2, $zero, end_while  # Se j < 0, o loop interno está completo
	
	mul $t4, $t2, 4 # calcula o offset de j 
	add $t5, $a0, $t4 # $t5 = &A[j] 

	lw $t6, 0($t5) # carrega o valor de A[j] em $t6
	
	blt $t1, $t6, end_while # aux < A[j] 
	
	sw $t6, 4($t5) # A[j+1] = A[j]
	subi $t2, $t2, 1  # j--;

	j while
end_while:
    sw $t1, 4($t5) # A[j+1] = aux
    addi $t0, $t0, 1          # Incrementa $t0 (índice do próximo elemento)
    addi $a0, $a0, 4          # Move para a próxima posição no array
    j for
end_for:
    jr $ra                     # Retorne à chamada original
