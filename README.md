# jnr Programming Language

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple interpreted programming language built with Flex and Bison for CSC 112.

## Project Structure

```
jnr/
├── src/                    # Source files
│   ├── jnr.l              # Flex lexer
│   └── jnr.y              # Bison parser
├── tests/                  # Test programs
│   ├── test.jnr           # Basic test
│   ├── test_types.jnr     # All types demo
│   ├── test_int.jnr       # Integer operations
│   ├── test_char.jnr      # Character handling
│   ├── test_float.jnr     # Float calculations
│   ├── test_input.jnr     # Interactive input test
│   └── simple.jnr         # Minimal test
├── docs/                   # Documentation
│   ├── README.md          # This file
│   └── CHANGELOG.md       # Development history
├── scripts/                # Helper scripts
│   └── run_test.sh        # Test runner
├── Makefile               # Build automation
└── jnr                    # Compiled executable
```

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
make

# Or manually:
bison -d src/jnr.y      # Generates jnr.tab.c and jnr.tab.h
flex src/jnr.l          # Generates lex.yy.c
gcc jnr.tab.c lex.yy.c -o jnr
```

## Usage

### Running from file (without input())
```bash
./jnr < tests/test.jnr
```

### Running specific tests
```bash
make test              # Run basic test
make test-types        # Test all types
make test-int          # Test integers
make test-char         # Test characters
make test-float        # Test floats
make test-all          # Run all tests
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
./scripts/run_test.sh
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

For the basic test (tests/test.jnr without input):
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

## CSC 112 Compliance

✅ All requirements met:
- FLEX/Bison interpreter system
- Typed variable declarations (int, char, float)
- Print statement with type-aware output
- Simple arithmetic operations
- Context-Free Grammar in BNF

## Documentation

See `docs/CHANGELOG.md` for complete development history and all implementation details.
