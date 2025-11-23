# jnr Language - Logic and Implementation

This document explains the internal logic and implementation details of the jnr programming language interpreter.

## Architecture Overview

The jnr interpreter consists of two main components:

1. **Lexer (`jnr.l`)** - Tokenizes input into lexical units
2. **Parser (`jnr.y`)** - Parses tokens and executes statements

## Lexer (jnr.l)

### Purpose
The lexer performs lexical analysis, converting raw text input into tokens that the parser can understand.

### Token Recognition Patterns

| Pattern | Token | Description |
|---------|-------|-------------|
| `"int"` | `INT` | Integer type keyword |
| `"char"` | `CHAR` | Character type keyword |
| `"float"` | `FLOAT` | Float type keyword |
| `"print"` | `PRINT` | Print function keyword |
| `"input"` | `INPUT` | Input function keyword |
| `[0-9]+\.[0-9]+` | `FLOATLIT` | Float literal (e.g., 3.14) |
| `[0-9]+` | `NUM` | Integer literal (e.g., 42) |
| `'[^']'` | `CHARLIT` | Character literal (e.g., 'A') |
| `[a-zA-Z][a-zA-Z0-9_]*` | `ID` | Identifier (variable name) |
| `"="` | `ASSIGN` | Assignment operator |
| `"+"` | `PLUS` | Addition operator |
| `"-"` | `MINUS` | Subtraction operator |
| `"*"` | `MULT` | Multiplication operator |
| `"/"` | `DIV` | Division operator |
| `"("` | `LPAREN` | Left parenthesis |
| `")"` | `RPAREN` | Right parenthesis |
| `[ \t\r]` | (ignored) | Whitespace |
| `\n` | `NEWLINE` | Newline character |
| `<<EOF>>` | `NEWLINE` then 0 | End of file handling |

### EOF Handling Logic

The lexer uses a special EOF rule to ensure proper termination:

```c
<<EOF>> { static int once = 0; if (!once) { once = 1; return NEWLINE; } else { return 0; } }
```

**How it works:**
1. First EOF encounter: Returns `NEWLINE` to terminate the last statement
2. Second EOF encounter: Returns 0 (real EOF signal)
3. Static variable `once` ensures this happens only once per input

**Why needed:** The parser expects every statement to end with NEWLINE. Without this, files lacking a trailing newline would cause syntax errors.

## Parser (jnr.y)

### Symbol Table

**Data Structure:**
```c
enum VarType { TYPE_INT, TYPE_CHAR, TYPE_FLOAT };

struct Symbol {
    char name[50];       // Variable name
    enum VarType type;   // Variable type
    union {              // Value storage (only one active at a time)
        int intval;
        char charval;
        float floatval;
    } value;
};
```

**Design Decisions:**
- **Union for values**: Memory efficient - stores only one value type per variable
- **Enum for types**: Type-safe type tracking
- **Array-based**: Simple implementation, supports 100 variables

### Symbol Table Functions

#### `set_symbol_int(char* name, int val)`
Creates or updates an integer variable.

**Logic:**
1. Search symbol table for existing variable with same name
2. If found: Update type to INT and set new value
3. If not found: Add new entry at `symbolTable[symbolCount]` and increment counter

#### `set_symbol_char(char* name, char val)`
Same logic as `set_symbol_int` but for character type.

#### `set_symbol_float(char* name, float val)`
Same logic as `set_symbol_int` but for float type.

#### `get_symbol(char* name)`
Retrieves variable value (always returns as float for arithmetic).

**Logic:**
1. Search symbol table for variable
2. Convert value to float based on type:
   - INT: `(float)intval`
   - CHAR: `(float)charval` (ASCII value)
   - FLOAT: `floatval` (no conversion)
3. If not found: Print error and exit

**Why return float:** Allows mixed-type arithmetic operations.

### Grammar Rules

#### Program Structure
```
program → statement_list
statement_list → statement_list statement | statement
statement → declaration | assignment | print_func | input_func | NEWLINE
```

**Logic:** A program is a list of statements. Statements can optionally be followed by NEWLINE.

#### Declarations
```
declaration → INT ID ASSIGN expr
            | CHAR ID ASSIGN CHARLIT
            | FLOAT ID ASSIGN expr
```

**Semantic Actions:**
- `INT ID = expr`: Call `set_symbol_int()` with identifier and expression value
- `CHAR ID = 'c'`: Call `set_symbol_char()` with identifier and character
- `FLOAT ID = expr`: Call `set_symbol_float()` with identifier and expression value

#### Assignments
```
assignment → ID ASSIGN expr
```

**Logic:**
1. Look up variable in symbol table
2. If found: Update value while maintaining original type
3. If not found: Create new INT variable (default behavior)

**Type preservation:** Assignments respect the original declaration type.

#### Print Function
```
print_func → PRINT LPAREN expr RPAREN
           | PRINT LPAREN CHARLIT RPAREN
           | PRINT LPAREN ID RPAREN
```

**Three variants:**
1. **`print(expr)`**: Evaluate expression and print as float (%.2f)
2. **`print('c')`**: Print character literal
3. **`print(var)`**: Look up variable and print based on its type:
   - INT: Format as `%d`
   - CHAR: Format as `%c`
   - FLOAT: Format as `%.2f`

**Type-aware output:** The third variant uses a switch statement on the variable's type.

#### Input Function
```
input_func → INPUT LPAREN ID RPAREN
```

**Logic:**
1. Display prompt: "Input value for [name]: "
2. Read integer from stdin using `scanf("%d", &val)`
3. Call `set_symbol_int(name, val)` to store

**Limitation:** Currently only supports integer input.

#### Expressions
```
expr → NUM | FLOATLIT | ID
     | expr PLUS expr
     | expr MINUS expr
     | expr MULT expr
     | expr DIV expr
     | LPAREN expr RPAREN
```

**Evaluation:**
- All expressions evaluate to float type
- Numeric literals are converted: `(float)NUM`
- Variables are retrieved via `get_symbol()` (returns float)
- Operators perform standard arithmetic
- Division by zero is checked: `if($3 == 0) { error }`
- Parentheses control precedence: `(expr)` returns inner value

**Operator Precedence:**
Defined using Bison left-associativity directives:
```
%left PLUS MINUS      // Lower precedence
%left MULT DIV        // Higher precedence
```

Result: `2 + 3 * 4` evaluates as `2 + (3 * 4) = 14`

## Execution Flow

### Startup
1. `main()` prints welcome message
2. Calls `yyparse()` to start parsing
3. `yyparse()` calls `yylex()` to get tokens

### Token Processing
1. Lexer reads input character by character
2. Matches patterns and returns tokens
3. Parser consumes tokens and executes grammar actions

### Statement Execution
1. Parser recognizes statement type (declaration, assignment, print, input)
2. Evaluates expressions recursively
3. Executes semantic actions (symbol table updates, I/O)
4. Continues until EOF

### Error Handling
- **Undefined variable**: `get_symbol()` prints error and exits
- **Division by zero**: Expression rule checks and exits
- **Syntax error**: `yyerror()` prints error message

## Type System

### Type Safety
- Variables have fixed types after declaration
- Assignments respect original type (with conversion)
- Print function outputs based on type

### Type Coercion
- All expressions internally use float
- Automatic conversions:
  - INT → FLOAT: `(float)intval`
  - CHAR → FLOAT: `(float)charval` (ASCII)
  - FLOAT → INT: `(int)floatval` (truncation)

### Example Type Flow
```
int x = 10        // x stored as TYPE_INT, value.intval = 10
float y = 3.14    // y stored as TYPE_FLOAT, value.floatval = 3.14
print(x + y)      // x:(float)10 + y:3.14 = 13.14, print as %.2f
```

## Memory Management

### Symbol Table
- Fixed-size array: `Symbol symbolTable[100]`
- Linear search: O(n) lookup time
- No garbage collection needed (statically allocated)

### String Handling
- Identifiers: `strdup(yytext)` allocates heap memory
- Symbol names: `strcpy()` into fixed buffer
- Character arrays: Stack allocated (50 bytes per name)

### Limitations
- Maximum 100 variables
- Maximum 50 characters per variable name
- No dynamic memory cleanup (acceptable for short programs)

## Error Recovery

The interpreter provides minimal error recovery:

1. **Syntax errors**: Parser stops immediately
2. **Runtime errors**: Program exits with error message
3. **No error recovery**: One error terminates execution

**Design rationale:** Simple interpreter for educational purposes. Production interpreters would implement sophisticated error recovery.

## Performance Considerations

### Linear Symbol Table Search
- **Complexity:** O(n) per lookup
- **Acceptable because:** Maximum 100 variables
- **Alternative:** Hash table (overkill for this scale)

### Type-based Dispatch
- **Switch statements:** O(1) constant time
- **Union access:** Zero-cost abstraction

### Expression Evaluation
- **Recursive descent:** Natural for expression trees
- **Stack-based:** Bison handles stack automatically

## Implementation Decisions

### Why Flex/Bison?
- **Industry standard:** Well-tested, robust
- **Automatic:** Generate lexer/parser from specifications
- **Educational:** Clear separation of concerns

### Why Union for Values?
- **Memory efficiency:** Only stores one type at a time
- **Type safety:** Enforced by `enum VarType`
- **Performance:** No dynamic allocation

### Why Float for Expressions?
- **Mixed arithmetic:** Allows `int + float`
- **Precision:** No loss for int/char operations
- **Simplicity:** Single evaluation type

### Why Static Symbol Table?
- **Simplicity:** Easy to understand and debug
- **Sufficient:** 100 variables enough for test programs
- **Fast:** No malloc/free overhead

## Compilation Process

```
jnr.y  ──→  Bison  ──→  jnr.tab.c  ──┐
                          jnr.tab.h    │
                                       ├─→  GCC  ──→  jnr (executable)
jnr.l  ──→  Flex   ──→  lex.yy.c  ──┘
```

1. Bison processes `jnr.y` → generates parser C code
2. Flex processes `jnr.l` → generates lexer C code
3. GCC compiles both → links into executable

## Runtime Behavior

```
User Input
    ↓
Lexer (lex.yy.c) → Tokens
    ↓
Parser (jnr.tab.c) → Parse Tree
    ↓
Semantic Actions → Symbol Table Updates / I/O
    ↓
Output
```

## Testing Strategy

### Unit Tests
- `test.jnr`: Basic arithmetic
- `test_types.jnr`: All three types
- `test_int.jnr`: Integer operations
- `test_char.jnr`: Character handling
- `test_float.jnr`: Float calculations

### Integration Tests
- `make test-all`: Runs all tests sequentially
- Verifies: Lexing, parsing, type system, I/O

## Future Enhancements

Possible improvements (not implemented):
- String type support
- Arrays/collections
- Control flow (if/while)
- Function definitions
- Better error recovery
- Optimized symbol table (hash map)
