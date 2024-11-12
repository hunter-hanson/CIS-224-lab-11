.data
    fib_array: .word 0:10    # Array to store 10 Fibonacci numbers
    size:      .word 10      # Size of the array
    prompt:    .asciiz "The first 10 Fibonacci numbers are:\n"
    space:     .asciiz " "

.text
.globl main

main:
    # Initialize registers
    la $t0, fib_array    # Load address of array into $t0
    lw $t1, size         # Load size of array into $t1
    li $t2, 1            # First Fibonacci number
    li $t3, 1            # Second Fibonacci number
    li $t4, 2            # Loop counter (start from 2 as we've set first two numbers)

    # Store first two Fibonacci numbers
    sw $t2, 0($t0)
    sw $t3, 4($t0)

    # Generate Fibonacci sequence
loop:
    beq $t4, $t1, print_array   # If we've generated 10 numbers, exit loop

    add $t5, $t2, $t3    # Calculate next Fibonacci number
    sw $t5, 8($t0)       # Store in array

    move $t2, $t3        # Shift numbers for next iteration
    move $t3, $t5
    addi $t0, $t0, 4     # Move to next array position
    addi $t4, $t4, 1     # Increment counter

    j loop

print_array:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Initialize for printing
    la $t0, fib_array
    li $t1, 0

print_loop:
    beq $t1, $t4, exit   # If we've printed all numbers, exit

    # Print number
    li $v0, 1
    lw $a0, ($t0)
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 4     # Move to next array element
    addi $t1, $t1, 1     # Increment counter
    j print_loop

exit:
    # Exit program
    li $v0, 10
    syscall