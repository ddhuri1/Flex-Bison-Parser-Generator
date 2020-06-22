**1. CONTENTS OF THE PACKAGE:**

  calc.l		-Flex code for scanning
  calc.y		-Bison code for parsing
  makefile.txt	-instructions to make the program

**2. SYSTEM REQUIREMENTS:**

  gcc-GNU Compiler Colection
  Flex 
  Bison 

**3. COMPILATION AND EXECUTION:**

  flex –l calc.l 
  bison -dv calc.y 
  gcc -o calc calc.tab.c lex.yy.c –lfl 
  ./calc < input // input is the name of the input file

**4. DESCRIPTION:**

  *Lexical analysis is also called scanning and syntax analysis is called parsing.<br />
  *Scanning divides the input into meaningful chunks, called tokens, and parsing figures out how the tokens relate to each other.<br />
  *FLEX (Fast LEXical analyzer generator) is a tool for generating scanners. When the analyzer executes, it analyzes input, 
  looking for strings that match any of its patterns. <br />
  *Parsing is the process of matching grammar symbols to elements in the input data, according to the rules of the grammar. 
  The parser obtains a sequence of tokens from the lexical analyzer. <br />
  *Bison is a general-purpose parser generator that converts a grammar description (Bison Grammar Files) for a context-free grammar
   into a C program to parse that grammar. The Bison parser is a bottom-up parser. <br />
  *It tries, by shifts and reductions, to reduce the entire input down to a single grouping whose symbol is the grammar's start-symbol.<br />

  In this assignment we design a parser Flex and Bison. In this assignment, we maintain a symbol table to store the name, value and type 
  of the variables. Initially all variables are assigned 0 or 0.0. <br />
  As we change the values for the variables (User inputs for the variable or the subtraction and multiplication operation )their value in the symbol table is updated. <br />
  Before assignment of any values their type is checked. If matched only then the operation is performed, else a type mismatch error is prompted.<br />
  In the assignment, all variable declarations have to be done before any definition.  <br />


