# ITCS321: MIPS Assembly Matrix Column Swap Program
#Date [DD/MM/YY]: 12/11/24

## Overview

This project is a MIPS Assembly program developed for **ITCS 321** homework assignment. The program performs operations on a static 8x10 matrix. It prints the matrix, accepts user input to swap two columns, validates the input, performs the column swap, and then outputs the updated matrix. Additionally, it extracts row #6 into a dynamically allocated array and prints it.

## Features

- Displays the original matrix in a tab-separated format.
- Prompts the user to enter two column indices (0–9) for swapping.
- Validates the user input to ensure the indices are within range.
- Swaps the specified columns if the input is valid.
- Displays the updated matrix using `#` as a separator.
- Dynamically allocates memory and fills it with elements from row #6.
- Prints the dynamically created array with `?` separating the values.

## File Structure

- `main.asm`: The main MIPS Assembly source file containing all logic for matrix operations and user interaction.

## How to Run

1. Install a MIPS simulator such as [SPIM](http://spimsimulator.sourceforge.net/) or [MARS](http://courses.missouristate.edu/kenvollmar/mars/).
2. Load the `main.asm` file into the simulator.
3. Run the program.
4. When prompted, enter two integers between 0 and 9 to swap the corresponding matrix columns.

## Notes

- Ensure all inputs are valid integers between 0 and 9.
- Invalid integers input will prompt the user to retry.


