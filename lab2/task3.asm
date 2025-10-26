.data
menu:        .asciiz "Enter a choice (1-3): "
case1Msg:    .asciiz "You selected case 1\n"
case2Msg:    .asciiz "You selected case 2\n"
case3Msg:    .asciiz "You selected case 3\n"
defaultMsg:  .asciiz "Invalid choice\n"

.text
main:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, case1
    beq $t0, 2, case2
    beq $t0, 3, case3
    j default

case1:
    li $v0, 4
    la $a0, case1Msg
    syscall
    j exit

case2:
    li $v0, 4
    la $a0, case2Msg
    syscall
    j exit

case3:
    li $v0, 4
    la $a0, case3Msg
    syscall
    j exit

default:
    li $v0, 4
    la $a0, defaultMsg
    syscall

exit:
    li $v0, 10
    syscall
