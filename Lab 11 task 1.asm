.data
    array:  .word   10, 20, 30, 40, 50    # Initialize array with 5 elements
    size:   .word   5                     # Size of the array
    sum:    .word   0                     # Variable to store the sum
    result: .asciiz "The sum is: "        # Result message

.text
.globl main

main:
    # Initialize registers
    la $t0, array    # Load address of array into $t0
    lw $t1, size     # Load size of array into $t1
    li $t2, 0        # Initialize loop counter to 0
    lw $t3, sum      # Load initial sum (0) into $t3

loop:
    # Check if we've reached the end of the array
    beq $t2, $t1, end_loop

    # Load current array element and add to sum
    lw $t4, ($t0)
    add $t3, $t3, $t4

    # Move to next array element and increment counter
    addi $t0, $t0, 4
    addi $t2, $t2, 1

    # Repeat loop
    j loop

end_loop:
    # Store final sum
    sw $t3, sum

    # Print result message
    li $v0, 4
    la $a0, result
    syscall

    # Print sum
    li $v0, 1
    move $a0, $t3
    syscall

    # Exit program
    li $v0, 10
    syscall