# PRITAM MALLICK (18CS10042)
# SMAYAN DAS (18CS30011)
# Group 51
# Assignment 7
# Problem 3

	.data

	msg1: .asciiz "Enter a sequence of numbers:\n"
	msg2: .asciiz "Sequence of numbers sorted!\n"
	newLine: .asciiz "\n"
	msg_query:	.asciiz "Enter the number to be searched: "
	msg_present: .asciiz "The number in sorted sequence is present at index: "
	msg_absent:	.asciiz "The number is not present in the sorted sequence\n"
	array: 
		.align 2
		.space 36

	.text 			# The text section
	.globl main		# Can be called anywhere

main:
# To print the message asking a sequence of numbers
	li $v0, 4
	la $a0, msg1
	syscall

	li $t0, 1
	li $t1, 8

	li $v0, 5
	syscall

	la $t9, array 				# Array address is stored in $t9
	sw $v0, ($t9)

	li $t2, 0

Read_Array:						# Every number from sequence is read
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

searchAlgo:
	la $a0, msg_query # enter the numbers
	li $v0 , 4
	syscall
			
	li $v0 , 5 # reading the first element
	syscall 
		 
	lw $t3, ($t9)
	beq $v0, $t3, Present
	lw $t3, 36($t9)

	li $t0, 1 # store the start index
	li $t1, 8 # store the end index
	li $t6, 2
	li $t4, 4

	jal binarySearch

# Endof program
End:
	li $v0, 10
	syscall

#Function to perform insertion sort on the array
Insertion_Sort:
	li $t0, 4				# Starting index is 1
	li $s1, 32				# Ending index is 8

Resume:						# Loop to traverse every element of array
	add $t2, $t9, $t0		
	lw $t3, ($t2)			# $t3 conatins A[i]

	addi $t2, $t2, -4
	lw $t4, ($t2)			# $t4 contains A[i-1]

	bgt $t4, $t3, findPos
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
		sw $t3, ($t2)		
		sw $t3, ($t2)		# A[j_final_pos] = A[i]

nextIter:
	addi $t0, $t0, 4		# ++i
	ble $t0, $s1, Resume		

	j printAns

#Function to perform recursive binary search on the sorted array
binarySearch:
			add $t3, $t0, $t1
			div $t3, $t6
			mflo $t3						# $t3 is mid = (start+end)/2

			move $t8, $t3
			mult $t3, $t4
			mflo $t3
			add $t5, $t9, $t3				# $t5 = A + mid

			lw $t7, ($t5)					# $t7 = A[mid]

			beq $v0, $t7, Present 			# if A[mid] is a match then end the search
			blt $v0, $t7, Less				# if A[mid] < value to search

			addi $t0, $t8, 1				# If A[mid] > value to search, start = mid + 1
			bgt $t0, $t1, Absent			# Base condition

			jal binarySearch				# If number is not present at all
			
		Less:								
			addi $t1, $t8, -1				# end = mid - 1
			bgt $t0, $t1, Absent
			
			jal binarySearch

		Present:							#After locating the number
			la $a0, msg_present
			li $v0 , 4
			syscall
			li $v0, 1
			move $a0, $t8
			syscall
			j End			
			
		Absent:								# Return from the function if number not present
			la $a0, msg_absent
			li $v0 , 4
			syscall
			j End