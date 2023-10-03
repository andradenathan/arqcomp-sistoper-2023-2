.data
A:      .word   3, 28, 10, 9, 2, 6, 5, 7
tamanho: .word   8
newline: .asciiz "\n"

.text
.globl bubble_sort

bubble_sort:
    la $a0, A # $a0 = &A
    lw $t0, tamanho # $t0 = tamanho
    li $t1, 0 # i = 0
    li $t2, 0 # j = 0
for:
	li $t2, 0 # j = 0
for_inner:
	mul $t3, $t2, 4
	add $t4, $a0, $t3 # $t4 = A[j]
	lw $t5, ($t4) # $t5 = &A[j]
	lw $t6, 4($t4) # $t6 = &A[j+1]
	
	blt $t5, $t6, increment
	
	sw $t5, 4($t4)
	sw $t6, ($t4)
increment:
	addi $t2, $t2, 1 # j++
	blt $t2, $t0, for_inner # j > tamanho
	
	addi $t1, $t1, 1 # i++
	blt $t1, $t0, for
	
	jal print
print: 
    la      $t0, A              # Carrega o endereço base do array A em $t0
    lw      $t1, tamanho        # Carrega o tamanho do array em $t1
    li      $t2, 0              # Inicializa $t2 com 0 (índice)

loop_print:
    bge     $t2, $t1, end_print   # Se índice >= tamanho, termine a impressão

    lw      $t3, 0($t0)          # Carrega o elemento atual do array em $t3

    # Prepara o valor do elemento para imprimir
    move    $a0, $t3             # Passa o valor do elemento como argumento
    li      $v0, 1               # Código de serviço para imprimir inteiro
    syscall

    # Imprime uma nova linha
    li      $v0, 4               # Código de serviço para imprimir string
    la      $a0, newline         # Passa a string de nova linha como argumento
    syscall

    addi    $t0, $t0, 4          # Avança para o próximo elemento do array (4 bytes)
    addi    $t2, $t2, 1          # Incrementa o índice
    j       loop_print           # Volta para o início do loop de impressão

end_print:
    li      $v0, 10              # Código de serviço para sair do programa
    syscall
