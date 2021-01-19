# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 6
# Problem 3

	.text			# The text section
	.globl main     # Can be called anywhere   

main:
    li $v0, 4
    la $a0, head
    syscall

	# To print the message asking value of A
	li $v0, 4
	la $a0, msg1
	syscall

    # Scan value of A
    li $v0, 5
    syscall
    move $s0, $v0

    # To print the message asking value of B
	li $v0, 4
	la $a0, msg2
	syscall

    # Scan value of B
    li $v0, 5
    syscall
    move $s1, $v0

    #Sanity Check for inputs within range
    li $t5, 0xffff
    and $t6, $t5, $s0
    and $t7, $t5, $s1

    bne $s0, $t6, SanityFail
    bne $s1, $t7, SanityFail

    move $a0, $s0
    move $a1, $s1

    li $s4, 0                           # Last bit
    li $s5, 16                          # Counter
    li $t0, 0                           # Final Product

seq_mult_unsigned:
    beq $s5,$0, printAns

    andi $s3, $a0, 1                    # $s3 = LSB($s0)
    beq $s3, $0, binZero                # $s3 = 0

binOne:
    add $t1, $t1, $a1

binZero:
    sll $a1, $a1, 1
    sra $a0, $a0, 1                     # Arithmetic right shift
    addi $s5, -1

    j seq_mult_unsigned

printAns:
	# To print the product of A and B
	li $v0, 4
	la $a0, msg3
	syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
	la $a0, newLine
	syscall

End:
    li $v0, 10
    syscall

SanityFail:
    li $v0, 4
    la $a0, msg5
    syscall
    j End

    .data

    head: .asciiz "Sequential Unsigned Binary Multiplication (left-shift version)\n\n"
	msg1: .asciiz "Enter value of A: "
	msg2: .asciiz "Enter value of B: "
	msg3: .asciiz "The product of A and B is: "
	msg4: .asciiz "Input numbers are in the range. Code terminated!\n"
    msg5: .asciiz "Sanity Check failed. Code terminated!\n"
	newLine: .asciiz "\n"