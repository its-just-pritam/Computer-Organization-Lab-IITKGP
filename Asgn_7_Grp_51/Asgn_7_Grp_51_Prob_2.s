# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 7
# Problem 2

	.data

	msg1: .asciiz "Enter a sequence of numbers line by line:\n"
	msg2: .asciiz "Sorted sequence of numbers:\n"
	gap: .asciiz " "
	newLine: .asciiz "\n"
	Here: .asciiz "Here\n"
	array: 
		.align 2
		.space 32

	.text 			# The text section
	.globl main		# Can be called anywhere

main:
# To print the message asking a sequence of numbers
	li $v0, 4
	la $a0, msg1
	syscall

	li $t0, 1
	li $t1, 7

	li $v0, 5
	syscall

	la $t9, array 		# Array address is stored in $t9
	sw $v0, ($t9)

	li $t2, 0

Read_Array:				# Every number from sequence is read
	li $v0, 5
	syscall

	addi $t2, $t2, 4
	add $t3, $t9, $t2
	sw $v0, ($t3)
	addi $t0, $t0, 1

	ble $t0, $t1, Read_Array	# Loop used to read and store in array

	jal Insertion_Sort

printAns:
	li $v0, 4
	la $a0, msg2
	syscall

	li $t0, 0
	li $t1, 28

printArray:						# Prints the array in sequence

	add $t2, $t9, $t0
	lw $t3, ($t2)

	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 4
	la $a0, gap
	syscall

	addi $t0, $t0, 4
	ble $t0, $t1, printArray

# Endof program
End:
	li $v0, 10
	syscall

#Function to perform insertion sort on the array
Insertion_Sort:
	li $t0, 4				# Starting index is 1
	li $s1, 28				# Ending index is 7 

Resume:						# Loop to traverse every element of array
	add $t2, $t9, $t0
	lw $t3, ($t2)			# $t3 conatins A[i]

	addi $t2, $t2, -4
	lw $t4, ($t2)			# $t4 contains A[i-1]

	bgt $t4, $t3, findPos	# if A[i-1] > A[i] enter a Loop
	j nextIter

	findPos:				# A loop which rigt shifts every element before it until a smaller number thaa A[i] appears
		li $t1, 0			# j starts from i-1 and end at 0

		lw $t5, ($t2)
		ble $t5, $t3, Break	# if A[j] < A[i] end the loop
		sw $t5, 4($t2)		# Rightshift every element of array

		addi $t2, $t2, -4	# --j
		bge $t2, $t1, findPos

	Break:
		addi $t2, $t2, 4
		sw $t3, ($t2)		# A[j_final_pos] = A[i]

nextIter:
	addi $t0, $t0, 4		# ++i
	ble $t0, $s1, Resume		

	j printAns