# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 6
# Problem 4

	.text			# The text section
	.globl main		# Can be called anywhere

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
    li $t5, 0x7fff
    xor $t6, $t6, $t6
    lui $t6, 0xffff
    ori $t6, 0x8000

    bgt $s0, $t5, SanityFail
    blt $s0, $t6, SanityFail
    bgt $s1, $t5, SanityFail
    blt $s1, $t6, SanityFail

    move $a0, $s0
    move $a1, $s1

    sll $a0, $a0, 16                     # Shifted to Upper-Halfword for addition/subtraction
    li $s4, 0                            # Last bit
    li $s5, 16                           # Counter

seq_mult_booth:
    andi $s3, $a1, 1                    # $s3 = LSB($s1)
    beq $s3, $s4, Endloop               # 00 or 11 -> continue
    beq $s3, $zero, runEnd              # 01 -> runEnd
    sub $a1, $a1, $a0                   # Run has begun
    j Endloop

runEnd:
    add $a1, $a1, $a0

Endloop:
    sra $a1, $a1, 1                     # Arithmetic right shift
    addi $s5, -1
    move $s4, $s3
    bne $s5, $zero, seq_mult_booth

printAns:
    move $t6, $a1
	# To print the product of A and B
	li $v0, 4
	la $a0, msg3
	syscall

    li $v0, 1
    move $a0, $t6
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

    head: .asciiz "Booth's Algorithm Multiplication\n\n"
	msg1: .asciiz "Enter value of A: "
	msg2: .asciiz "Enter value of B: "
	msg3: .asciiz "The product of A and B is: "
	msg4: .asciiz "Input numbers are in the range. Code terminated!\n"
	msg5: .asciiz "Sanity Check failed. Code terminated!\n"
	newLine: .asciiz "\n"