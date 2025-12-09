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
│   ├── test_comma_declarations.jnr  # Comma-separated declarations
│   ├── test_input.jnr     # Interactive input test
│   └── simple.jnr         # Minimal test
├── docs/                   # Documentation
│   ├── README.md          # You're Here
├── scripts/                # Helper scripts
│   └── run_test.sh        # Test runner
├── Makefile               # Build automation
└── jnr                    # Compiled executable
```

## Features

- **Typed variable declarations** (int, char)
- **Comma-separated declarations** (e.g., `int x = 10, y, z = 30!`)
- Arithmetic operations (+, -, *, /, %) with proper precedence
- Comparison operations (<, >, <=, >=, ==, !=)
- Print function (`show()`) with type-aware output
- Input function (`ask()`) for integers
- Parenthesized expressions
- Hash-style comments (`#`)

## Grammar (BNF)

```
PROGRAM        → STATEMENT_LIST
STATEMENT_LIST → STATEMENT | STATEMENT_LIST STATEMENT
STATEMENT      → DECLARATION '!' | ASSIGNMENT '!' | PRINT_FUNC '!' | INPUT_FUNC '!'
DECLARATION    → 'int' VAR_LIST_INT
               | 'char' VAR_LIST_CHAR
VAR_LIST_INT   → identifier
               | identifier '=' EXPRESSION
               | VAR_LIST_INT ',' identifier
               | VAR_LIST_INT ',' identifier '=' EXPRESSION
VAR_LIST_CHAR  → identifier
               | identifier '=' CHARLIT
               | VAR_LIST_CHAR ',' identifier
               | VAR_LIST_CHAR ',' identifier '=' CHARLIT
ASSIGNMENT     → identifier '=' EXPRESSION
PRINT_FUNC     → 'show' '(' EXPRESSION ')'
               | 'show' '(' identifier ')'
               | 'show' '(' CHARLIT ')'
INPUT_FUNC     → 'ask' '(' identifier ')'
EXPRESSION     → EXPRESSION '+' EXPRESSION
               | EXPRESSION '-' EXPRESSION
               | EXPRESSION '*' EXPRESSION
               | EXPRESSION '/' EXPRESSION
               | EXPRESSION '%' EXPRESSION
               | EXPRESSION '<' EXPRESSION
               | EXPRESSION '>' EXPRESSION
               | EXPRESSION '<=' EXPRESSION
               | EXPRESSION '>=' EXPRESSION
               | EXPRESSION '==' EXPRESSION
               | EXPRESSION '!=' EXPRESSION
               | '(' EXPRESSION ')'
               | number
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
make test-all          # Run all tests
```

### Running programs with ask() function
For programs using `ask()`, you have two options:

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

### Type Declarations with Comma-Separated Variables
```
# Multiple variables in one statement
int x = 10, y = 5, sum!
sum = x + y!
show(sum)!

# Character type
char c = 'A'!
show(c)!

# Mixed initialization
int a = 100, b, c = 200!
show(a)!  # 100
show(b)!  # 0 (default)
show(c)!  # 200
```

### Output:
```
Welcome to jnr! (Type your code, Press Ctrl+D to run)
15
A
100
0
200
```

## Sample Output (Without Input)

For the basic test (tests/test.jnr without input):
```
Welcome to jnr! (Type your code, Press Ctrl+D to run)
15
50
```

## Notes

- Programs using `ask()` are best run in interactive mode
- The `ask()` function reads integers from stdin  
- Use file mode (`./jnr < file.jnr`) for programs without input
- Arithmetic follows standard precedence: `*`, `/`, `%` before `+`, `-`
- Comparison operators return 1 (true) or 0 (false)
- Variables can be any identifier starting with a letter
- Statements must end with `!` exclamation mark
- Comments start with `#` and continue to end of line
- **JNR v4.2** supports only `int` and `char` types (float removed for simplicity)

## Documentation

See `docs/CHANGELOG.md` for complete development history and all implementation details.
