# jnr Programming Language

A simple interpreted programming language built with Flex and Bison.

## Features

- **Typed variable declarations** (int, char, float)
- Arithmetic operations (+, -, *, /) with proper precedence
- Print function with type-aware output
- Input function for integers
- Parenthesized expressions

## Grammar (BNF)

```
PROGRAM        → STATEMENT_LIST
STATEMENT_LIST → STATEMENT | STATEMENT_LIST STATEMENT
STATEMENT      → DECLARATION | ASSIGNMENT | PRINT_FUNC | INPUT_FUNC
DECLARATION    → 'int' identifier '=' EXPRESSION
               | 'char' identifier '=' CHARLIT
               | 'float' identifier '=' EXPRESSION
ASSIGNMENT     → identifier '=' EXPRESSION
PRINT_FUNC     → 'print' '(' EXPRESSION ')'
               | 'print' '(' identifier ')'
               | 'print' '(' CHARLIT ')'
INPUT_FUNC     → 'input' '(' identifier ')'
EXPRESSION     → EXPRESSION '+' EXPRESSION
               | EXPRESSION '-' EXPRESSION
               | EXPRESSION '*' EXPRESSION
               | EXPRESSION '/' EXPRESSION
               | '(' EXPRESSION ')'
               | number
               | float_literal
               | identifier
CHARLIT        → 'any_char'
```

## Building

```bash
# Generate parser and lexer
bison -d jnr.y      # Generates jnr.tab.c and jnr.tab.h
flex jnr.l          # Generates lex.yy.c

# Compile
gcc jnr.tab.c lex.yy.c -o jnr
```

## Usage

### Running from file (without input())
```bash
./jnr < test.jnr
```

### Running programs with input() function
For programs using `input()`, you have two options:

**Option 1: Interactive Mode (Recommended)**
```bash
./jnr
# Paste or type your code
# Press Ctrl+D when done
# Type input values when prompted
```

**Option 2: Using a shell script**
```bash
# Create run_test.sh:
#!/bin/bash
(cat yourprogram.jnr; echo "5") | ./jnr

# Run it:
chmod +x run_test.sh
./run_test.sh
```

### Interactive mode (best for testing)
```bash
./jnr
# Type your code, then press Ctrl+D to run
```

## Example Program

### Type Declarations
```
int x = 10
int y = 5
char c = 'A'
float pi = 3.14
print(x + y)
print(c)
print(pi)
```

### Output:
```
Welcome to jnr! (Type your code, Press Ctrl+D to run)
15
A
3.14
```

## Sample Output (Without Input)

For the basic test (test.jnr without input):
```
Welcome to jnr! (Type your code, Press Ctrl+D to run)
15
50
```

## Notes

- Programs using `input()` are best run in interactive mode
- The `input()` function reads integers from stdin  
- Use file mode (`./jnr < file.jnr`) for programs without input
- Arithmetic follows standard precedence: `*` and `/` before `+` and `-`
- Variables can be any identifier starting with a letter
