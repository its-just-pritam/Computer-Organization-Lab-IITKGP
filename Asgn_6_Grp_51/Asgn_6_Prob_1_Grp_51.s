# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 6
# Problem 1


	.text 			# The text section
	.globl main		# Can be called anywhere

main:
# To print the message asking value of A
	li $v0, 4
	la $a0, msg1
	syscall

# Scan value of A
	li $v0, 5
	syscall
	move $t0, $v0

# To print the message asking value of B
	li $v0, 4
	la $a0, msg2
	syscall

# Scan value of B
	li $v0, 5
	syscall
	move $t1, $v0

# Sanity Checking
	bgt $t0, 0, Sanity
	j SanityFail

Sanity:
	bgt $t1, 0, GCD

SanityFail:
	li $v0, 4
	la $a0, msg4
	syscall
	j End

# Function to compute GCD of A and B
GCD:
	beq $t0, $t1, printAns

	bgt $t0, $t1, Greater

Lesser:
	sub $t1, $t1, $t0
	j GCD

Greater:
	sub $t0, $t0, $t1
	j GCD

printAns:

# To print the GCD of A and B
	li $v0, 4
	la $a0, msg3
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

# To move to a new line
	li $v0, 4
	la $a0, newLine
	syscall

End:
	li $v0, 10
	syscall

	.data

	msg1: .asciiz "Enter value of A: "
	msg2: .asciiz "Enter value of B: "
	msg3: .asciiz "The GCD of A and B is: "
	msg4: .asciiz "Input numbers are not positive. Code terminated!\n"
	newLine: .asciiz "\n"