# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 6
# Problem 2


	.text 			# The text section
	.globl main		# Can be called anywhere

main:
# To print the message asking value of X
	li $v0, 4
	la $a0, msg1
	syscall

# Scan value of X
	li $v0, 5
	syscall
	move $t4, $v0

	li $t0, 2

# Sanity Checking
	bgt $t4, 1, PrimalityTest

	li $v0, 4
	la $a0, msg4
	syscall
	j End

# Function to test primality of X

PrimalityTest:
	mul $t1, $t0, $t0
	bgt $t1, $t4, primeAns

	div $t4, $t0
	mfhi $t2
	beq $t2, 0, compositeAns

	addi $t0, $t0, 1
	j PrimalityTest

# Print if X is prime

primeAns:
	li $v0, 4
	la $a0, msg2
	syscall
	j End

# Print if X is composite

compositeAns:
	li $v0, 4
	la $a0, msg3
	syscall
	j End

End:
	li $v0, 10
	syscall

	.data

	msg1: .asciiz "Enter value of X: "
	msg2: .asciiz "Entered value is Prime!\n"
	msg3: .asciiz "Entered value is Composite!\n"
	msg4: .asciiz "Input numbers are not greater than or equat to 2. Code terminated!\n"
	newLine: .asciiz "\n"