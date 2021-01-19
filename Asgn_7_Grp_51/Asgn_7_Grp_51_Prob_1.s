# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 7
# Problem 1


	.text 			# The text section
	.globl main		# Can be called anywhere

main:
# To print the message asking a String
	li $v0, 4
	la $a0, msg1
	syscall

# Scan value of the String
	li $v0, 8
	la $a0, buffer
	li $a1, 50
	move $a1, $a0
	syscall

# To store the converted String
	la $s1, LowerString

	jal toLower

# Prints the converted String
printAns:
	li $v0, 4
	la $a0, msg2
	syscall

	li $v0, 4
	la $a0, LowerString
	syscall

# Endof program
End:
	li $v0, 10
	syscall

#Function to convert Upper case characters to Lower case
toLower:
	lb $t1, ($a1)

	beqz $t1, printAns

	blt $t1, 65, Pass
	bgt $t1, 90, Pass

changeCase:					# Upper to Lower
	addi $t1, $t1, 32

Pass:
	sb $t1, ($s1)

	addi $a1, $a1, 1
	addi $s1, $s1, 1

	j toLower

	.data

	buffer: .space 100
	LowerString: .space 100
	msg1: .asciiz "Enter a String: "
	msg2: .asciiz "Converted String is: "
	newLine: .asciiz "\n"