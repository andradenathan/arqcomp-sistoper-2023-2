.data
    numbers: .word 5, 4, 3, 2, 1

.text
    la   $a0, numbers          # Load address of numbers array
    li   $a1, 5                # Load size of array
    jal  sort                  # Call sort function
    j    finish                # Jump to finish

sort:   addi $sp, $sp, -24
        sw   $ra, 20($sp)
        sw   $s0, 16($sp)
        sw   $s1, 12($sp)
        sw   $s2, 8($sp)
        sw   $s3, 4($sp)
        sw   $s4, 0($sp)
        move $s3, $a0
        move $s4, $a1
        addi $s0, $zero, 0     # Initialize i to 0
loop1:
        addi $t0, $s4, -1
        slt  $t0, $s0, $t0
        beq  $t0, $zero, endloop1
        addi $s2, $s0, 0       # minIndex = i
        addi $s1, $s0, 1       # j = i + 1
loop2:
        slt  $t0, $s1, $s4
        beq  $t0, $zero, endloop2
        sll  $t0, $s1, 2
        sll  $t1, $s2, 2
        add  $t0, $s3, $t0
        add  $t1, $s3, $t1
        lw   $t0, 0($t0)
        lw   $t1, 0($t1)
        slt  $t0, $t0, $t1
        beq  $t0, $zero, skip
        addi $s2, $s1, 0       # minIndex = j
skip:
        addi $s1, $s1, 1
        j    loop2
endloop2:
        beq $s0, $s2, next
        move $a0, $s3
        move $a1, $s0
        move $a2, $s2
        jal  swapElements
next:
        addi $s0, $s0, 1
        j    loop1
endloop1:
        lw   $s4, 0($sp)
        lw   $s3, 4($sp)
        lw   $s2, 8($sp)
        lw   $s1, 12($sp)
        lw   $s0, 16($sp)
        lw   $ra, 20($sp)
        addi $sp, $sp, 24
        jr   $ra

swapElements:
        sll  $t1, $a1, 2
        sll  $t2, $a2, 2
        add  $t1, $a0, $t1
        add  $t2, $a0, $t2
        lw   $t0, 0($t1)
        lw   $t3, 0($t2)
        sw   $t3, 0($t1)
        sw   $t0, 0($t2)
        jr   $ra

finish:
