.data

failMsg:    .asciiz "Test case failed!!\n\n"
passMsg:    .asciiz "Test case passed!!\n\n"

excpected:  .asciiz "\tExcepected =\t"
result:     .asciiz "\tResult =\t\t"

newLine:    .asciiz "\n"

test1:   .asciiz "Test fib(0)\n"
test2:   .asciiz "Test fib(1)\n"
test3:   .asciiz "Test fib(2)\n"
test4:   .asciiz "Test fib(3)\n"
test5:   .asciiz "Test fib(4)\n"
test6:   .asciiz "Test fib(5)\n"
test7:   .asciiz "Test fib(6)\n"

.text

#=====================================================
# Fibonacci Function
#   Parameters: $a0 -> n
#   Return:     $v0 -> fib(n)
#=====================================================
fib:
    # Base case: fib(0) = 0
    beq $a0, $zero, fib_zero

    # Base case: fib(1) = 1
    li  $t0, 1
    beq $a0, $t0, fib_one

    # Iterative: compute from 2 → n
    li  $t1, 0        # a = fib(0)
    li  $t2, 1        # b = fib(1)

    li  $t3, 2        # counter = 2
fib_loop:
    bgt $t3, $a0, fib_end
    add $t4, $t1, $t2 # next = a + b
    move $t1, $t2     # a = b
    move $t2, $t4     # b = next
    addi $t3, $t3, 1  # counter++
    j fib_loop

fib_end:
    move $v0, $t2     # return fib(n)
    jr $ra

fib_zero:
    move $v0, $zero
    jr $ra

fib_one:
    li $v0, 1
    jr $ra



#=====================================================
# main: run all tests
#=====================================================
main:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # ========= test fib(0) =========
    li $a0, 0
    jal fib

    li $a0, 0
    move $a1, $v0
    la $a2, test1
    jal assertNotEqual


    # ========= test fib(1) =========
    li $a0, 1
    jal fib

    li $a0, 1
    move $a1, $v0
    la $a2, test2
    jal assertNotEqual

    # ========= test fib(2) =========
    li $a0, 2
    jal fib

    li $a0, 1
    move $a1, $v0
    la $a2, test3
    jal assertNotEqual

    # ========= test fib(3) =========
    li $a0, 3
    jal fib

    li $a0, 2
    move $a1, $v0
    la $a2, test4
    jal assertNotEqual

    # ========= test fib(4) =========
    li $a0, 4
    jal fib

    li $a0, 3
    move $a1, $v0
    la $a2, test5
    jal assertNotEqual

    # ========= test fib(5) =========
    li $a0, 5
    jal fib

    li $a0, 5
    move $a1, $v0
    la $a2, test6
    jal assertNotEqual

    # ========= test fib(6) =========
    li $a0, 6
    jal fib

    li $a0, 8
    move $a1, $v0
    la $a2, test7
    jal assertNotEqual


    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra



#================================================================================
# assertNotEqual  (actually checks equality)
#   Parameters:
#       $a0 -> expected
#       $a1 -> result
#       $a2 -> test message
#================================================================================
assertNotEqual:

    move $t0, $a0   # expected value

    # Print test name
    li $v0, 4
    move $a0, $a2
    syscall

    # Print "Expected = "
    la $a0, excpected
    syscall

    # Print expected value
    li $v0, 1
    move $a0, $t0
    syscall

    # New line
    li $v0, 4
    la $a0, newLine
    syscall

    # Print "Result = "
    la $a0, result
    syscall

    # Print actual result
    li $v0, 1
    move $a0, $a1
    syscall

    # New line
    li $v0, 4
    la $a0, newLine
    syscall

    # Compare expected and result
    bne $t0, $a1, printFail

    # Print pass
    la $a0, passMsg
    syscall

    j return

printFail:
    la $a0, failMsg
    syscall

return:
    jr $ra