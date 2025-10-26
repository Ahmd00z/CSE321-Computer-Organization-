.data
prompt1:    .asciiz "Enter first number: "
prompt2:    .asciiz "Enter second number: "
prompt3:    .asciiz "Enter third number: "
prompt4:    .asciiz "Enter fourth number: "
resultMsg:  .asciiz "The average is: "

.text
main:
    # ==== Input 1 ====
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0        # store first number

    # ==== Input 2 ====
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0        # store second number

    # ==== Input 3 ====
    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 5
    syscall
    move $t2, $v0        # store third number

    # ==== Input 4 ====
    li $v0, 4
    la $a0, prompt4
    syscall

    li $v0, 5
    syscall
    move $t3, $v0        # store fourth number

    # ==== Compute sum ====
    add $t4, $t0, $t1    # t4 = first + second
    add $t4, $t4, $t2    # t4 = t4 + third
    add $t4, $t4, $t3    # t4 = t4 + fourth

    # ==== Compute average ====
    li $t5, 4            # divisor = 4
    div $t4, $t5         # divide sum by 4
    mflo $t6             # move quotient (average) to $t6

    # ==== Display result ====
    li $v0, 4
    la $a0, resultMsg
    syscall

    move $a0, $t6
    li $v0, 1
    syscall

    # ==== Exit ====
    li $v0, 10
    syscall