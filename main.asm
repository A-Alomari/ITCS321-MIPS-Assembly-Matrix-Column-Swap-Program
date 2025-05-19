#***********************************************************************************************
# ITCS 321 Date: 12/11/24
# Description: This MIPS Assembly program defines a static 8x10 matrix `mymat`, prints its elements
# 10 per line with tabs, prompts the user to input two column indices (val1 and val2) for swapping.
# It validates the input and swaps the columns if valid. Then it prints the updated matrix with
# hash signs (#) separating the values. It also creates a dynamic array from row #6 of `mymat`,
# and prints the elements separated by (?), with a new line at the start.
#***********************************************************************************************

.data
# Define the 8x10 matrix (80 integers)
mymat: .word  22, 49, 37, 14, 58, 13, 17, 61, 41, 17, 30, 19, 53, 76, 65, 34, 12, 40, 33, 59,
              26, 25, 19, 52, 28, 13, 72, 15, 74, 45, 11, 43, 68, 60, 21, 69, 10, 78, 14, 35,
              50, 23, 31, 73, 29, 62, 46, 18, 70, 57, 66, 56, 12, 18, 51, 38, 32, 63, 64, 48,
              42, 36, 71, 15, 39, 54, 55, 77, 27, 24, 44, 20, 67, 16, 75, 11, 47, 79, 80, 29

# Strings for user prompts and formatting
InvalidUserInput: .asciiz "Invalid input. Please enter numbers between 0 and 9.\n"
DynamicArray: .asciiz "\nThe dynamic array filled by elements from row #6:\n"
AskUser: .asciiz "\n Enter two column numbers (0-9): "
UpdatedMatrix: .asciiz "\n The updated matrix:\n"
OriginalMatrix: .asciiz "The original matrix:\n"
QuestionMark: .asciiz " ? "
NewLine: .asciiz "\n"
Hash: .asciiz " # "
Tab: .asciiz "\t"

.text
.globl main
main:
    # Print original matrix
    li $v0, 4
    la $a0, OriginalMatrix
    syscall
    jal PrintMatrixTab

    # Ask user for column indices
    jal MethodAskUser

    # Swap the columns
    jal SwapColumns

    # Print updated matrix
    li $v0, 4
    la $a0, UpdatedMatrix
    syscall
    jal printMatrixHash

    # Print dynamic array message
    li $v0, 4
    la $a0, DynamicArray
    syscall

    # Allocate space for dynamic array (10 integers = 40 bytes)
    li $a0, 40
    li $v0, 9
    syscall
    move $s0, $v0  # Save base address of dynamic array

    # Load address of row #6 (6 * 10 = 60 elements = 240 bytes offset)
    la $t0, mymat
    addi $t0, $t0, 240

    li $t1, 10       # Counter for 10 elements
    move $t2, $s0    # Destination pointer

FillDynamicArray:
    lw $t3, 0($t0)   # Load element from matrix
    sw $t3, 0($t2)   # Store in dynamic array
    addi $t0, $t0, 4
    addi $t2, $t2, 4
    subi $t1, $t1, 1
    bnez $t1, FillDynamicArray

    # Print dynamic array with ? separator
    li $t1, 10
    move $t2, $s0

PrintDynamicArray:
    lw $a0, 0($t2)
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, QuestionMark
    syscall
    addi $t2, $t2, 4
    subi $t1, $t1, 1
    bnez $t1, PrintDynamicArray

    # Exit program
    li $v0, 10
    syscall

#------------------------------------------------------------
# PrintMatrixTab: Prints the matrix with tab separators
#------------------------------------------------------------
PrintMatrixTab:
    li $t0, 0
    la $t2, mymat

PrintRows:
    bge $t0, 8, Stop
    li $t1, 0

PrintColumns:
    bge $t1, 10, PrintNewLineColumnsTab
    lw $t3, 0($t2)
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, Tab
    li $v0, 4
    syscall
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j PrintColumns

PrintNewLineColumnsTab:
    la $a0, NewLine
    li $v0, 4
    syscall
    addi $t0, $t0, 1
    j PrintRows

#------------------------------------------------------------
# MethodAskUser: Prompts and validates user input
#------------------------------------------------------------
MethodAskUser:
    li $v0, 4
    la $a0, AskUser
    syscall
    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 4
    la $a0, AskUser
    syscall
    li $v0, 5
    syscall
    move $s1, $v0

ValidateInput:
    blt $s0, 0, MethodInvalidUserInput
    bge $s0, 10, MethodInvalidUserInput
    blt $s1, 0, MethodInvalidUserInput
    bge $s1, 10, MethodInvalidUserInput
    jr $ra

MethodInvalidUserInput:
    li $v0, 4
    la $a0, InvalidUserInput
    syscall
    j MethodAskUser

#------------------------------------------------------------
# SwapColumns: Swaps two columns in the matrix
#------------------------------------------------------------
SwapColumns:
    li $t0, 0
    la $t2, mymat

SwapRow:
    bge $t0, 8, Stop
    mul $t1, $t0, 40       # Row offset (10 cols * 4 bytes = 40)
    add $t4, $t1, $t2      # Base address of current row

    mul $t5, $s0, 4        # Offset for column s0
    add $t4, $t4, $t5
    lw $t6, 0($t4)         # Load value at column s0

    mul $t7, $s1, 4        # Offset for column s1
    add $t8, $t1, $t7
    add $t8, $t8, $t2
    lw $t9, 0($t8)         # Load value at column s1

    sw $t9, 0($t4)         # Swap values
    sw $t6, 0($t8)

    addi $t0, $t0, 1
    j SwapRow

#------------------------------------------------------------
# printMatrixHash: Prints the matrix with hash separators
#------------------------------------------------------------
printMatrixHash:
    li $t0, 0
    la $t2, mymat

PrintRowsHash:
    bge $t0, 8, Stop
    li $t1, 0

PrintColumnsHash:
    bge $t1, 10, PrintNewLineColumnsHash
    lw $t3, 0($t2)
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, Hash
    li $v0, 4
    syscall
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j PrintColumnsHash

PrintNewLineColumnsHash:
    la $a0, NewLine
    li $v0, 4
    syscall
    addi $t0, $t0, 1
    j PrintRowsHash
    
Stop:
    jr $ra
