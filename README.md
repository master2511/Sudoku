# Sudoku
Solving a 9*9 sudoku puzzle using optimization technique and linear systems.

The sudoku_2 file is an implementation of a sudoku example.
The sudoku_interactive is can be used for solving a general 9*9 sudoku puzzle.
While entering the given clues for the sudoku enter the x and y coordinates. 
The coordinates vary from (1,1) to (9,9).

To run this code in matlab one needs to install the cvx library in matlab first.
cvx is used for solving the optimization problem, i.e finding the x for minimum 1st norm, given to the constraint A*x=b.
