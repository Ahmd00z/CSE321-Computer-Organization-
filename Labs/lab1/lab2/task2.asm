.data
promptN:     .asciiz "Enter how many numbers (n): "
promptNum:   .asciiz "Enter a number: "
resultMsg:   .asciiz "The average is: "
newline:     .asciiz "\n"

.text
main:
    li $v0, 4
    la $a0, promptN
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li.s $f0, 0.0
    li $t1, 0

loop_start:
    beq $t1, $t0, loop_end

    li $v0, 4
    la $a0, promptNum
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    mtc1 $t2, $f2
    cvt.s.w $f2, $f2
    add.s $f0, $f0, $f2

    addi $t1, $t1, 1
    j loop_start

loop_end:
    mtc1 $t0, $f4
    cvt.s.w $f4, $f4
    div.s $f6, $f0, $f4

    li $v0, 4
    la $a0, resultMsg
    syscall

    mov.s $f12, $f6
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
