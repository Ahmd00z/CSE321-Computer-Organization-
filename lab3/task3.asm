.data
A:  .word 4
B:  .word 6

.text

# ===========================
# Function: compute(a, b)
# returns (a + b) * 2
# ===========================
compute:
    # Callee-save step (allocate stack)
    addiu $sp, $sp, -8       # Allocate space for 2 words on stack
    sw    $s0, 4($sp)        # Save $s0 (we're using it)
    sw    $ra, 0($sp)        # Save return address (good practice)

    add  $s0, $a0, $a1      # s0 = a + b
    sll  $v0, $s0, 1        # v0 = s0 * 2

    # Callee-restore step
    lw    $s0, 4($sp)        # Restore $s0
    lw    $ra, 0($sp)        # Restore return address
    addiu $sp, $sp, 8        # Deallocate stack space

    jr   $ra


# ===========================
# main function (caller)
# ===========================
main:
    lw   $t0, A
    lw   $t1, B
    li   $s0, 99

    # Caller-save step
    addiu $sp, $sp, -12      # Allocate space for 3 words
    sw    $t0, 8($sp)        # Save $t0 (contains A)
    sw    $t1, 4($sp)        # Save $t1 (contains B) 
    sw    $s0, 0($sp)        # Save $s0 (contains 99)

    move $a0, $t0            # Set first argument (a0 = A)
    move $a1, $t1            # Set second argument (a1 = B)
    jal  compute             # Call function

    move $t3, $v0            # Store result in $t3
    
    # Caller-restore step
    lw    $s0, 0($sp)        # Restore $s0
    lw    $t1, 4($sp)        # Restore $t1
    lw    $t0, 8($sp)        # Restore $t0
    addiu $sp, $sp, 12       # Deallocate stack space

    jr $ra

