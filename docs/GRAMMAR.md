# jnr Language - Context-Free Grammar

> [!IMPORTANT]
> **Updated for JNR v4.0** - Simplified operator set! Features `!` statement terminator, `real` keyword, `show()`/`ask()` functions, and `#` comments. Bitwise and logical operators have been removed for educational simplicity.

This document presents the formal Context-Free Grammar (CFG) for the jnr programming language in multiple formats.

---

## 1. BNF Notation (Backus-Naur Form)

### Complete Grammar

```
<program>        ::= <statement-list>

<statement-list> ::= <statement>
                   | <statement-list> <statement>

<statement>      ::= <declaration> "!"
                   | <assignment> "!"
                   | <print-func> "!"
                   | <input-func> "!"

<declaration>    ::= "int" IDENTIFIER "=" <expression>
                   | "char" IDENTIFIER "=" CHAR-LITERAL
                   | "real" IDENTIFIER "=" <expression>

<assignment>     ::= IDENTIFIER "=" <expression>

<print-func>     ::= "show" "(" <expression> ")"
                   | "show" "(" CHAR-LITERAL ")"
                   | "show" "(" IDENTIFIER ")"

<input-func>     ::= "ask" "(" IDENTIFIER ")"

<expression>     ::= <expression> "+" <expression>
                   | <expression> "-" <expression>
                   | <expression> "*" <expression>
                   | <expression> "/" <expression>
                   | <expression> "%" <expression>
                   | <expression> "<" <expression>
                   | <expression> ">" <expression>
                   | <expression> "<=" <expression>
                   | <expression> ">=" <expression>
                   | <expression> "==" <expression>
                   | <expression> "!=" <expression>
                   | "(" <expression> ")"
                   | NUMBER
                   | FLOAT-LITERAL
                   | IDENTIFIER

IDENTIFIER       ::= LETTER (LETTER | DIGIT | "_")*
NUMBER           ::= DIGIT+
FLOAT-LITERAL    ::= DIGIT+ "." DIGIT+
CHAR-LITERAL     ::= "'" CHARACTER "'"
EXCLAIM          ::= "!"
COMMENT          ::= "#" (any character)* NEWLINE
LETTER           ::= "a" | "b" | ... | "z" | "A" | "B" | ... | "Z"
DIGIT            ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
CHARACTER        ::= any printable character except "'"
```

---

## 2. Operator Precedence & Associativity

**Simplified operator precedence for JNR v4.0.**

| Level | Operators | Associativity | Description |
|-------|-----------|---------------|-------------|
| 6 (Highest) | `( )` | N/A | Parentheses |
| 5 | `*` `/` `%` | Left | Multiplication, Division, Modulo |
| 4 | `+` `-` | Left | Addition, Subtraction |
| 3 | `<` `>` `<=` `>=` | Left | Relational Comparison |
| 2 | `==` `!=` | Left | Equality Comparison |
| 1 (Lowest) | `=` | Right | Assignment |

### Example: `2 + 3 * 4`
Parses as: `2 + (3 * 4)` = `2 + 12` = `14`

---

## 3. Complete Operator Reference

### Arithmetic Operators
- `+` : Addition
- `-` : Subtraction
- `*` : Multiplication
- `/` : Division
- `%` : Modulo (remainder)

### Comparison Operators
- `<` : Less than
- `>` : Greater than
- `<=` : Less than or equal
- `>=` : Greater than or equal
- `==` : Equal to
- `!=` : Not equal to

All comparison operators return 1 for true, 0 for false.

---

## 4. Grammar Properties

### Type
- **Context-Free Grammar (Type 2)** in Chomsky hierarchy

### Characteristics
- **Ambiguous (resolved):** The expression grammar is inherently ambiguous
- **Resolution:** Bison uses `%left` precedence declarations to resolve ambiguity
- **Left-Associative:** All binary operators associate left-to-right

### Production Count
- **Non-terminals:** 8 (program, statement-list, statement, declaration, assignment, print-func, input-func, expression)
- **Terminals:** 35+ (keywords, operators, literals, identifiers)
- **Productions:** 40+ total

### Language Class
- **Deterministic Context-Free Language (DCFL)**
- Parseable by deterministic pushdown automaton (DPDA)
- Implemented using LALR(1) parser (Bison)

---

## 4. Grammar Compatibility

> [!NOTE]
> **Simplified for Education**
> 
> JNR v4.0 has been simplified by removing bitwise and logical operators. The language now focuses on:
> - Arithmetic operations for mathematical calculations
> - Comparison operators for conditional logic
> - Type-safe variable declarations (int, char, real)
> - Unique syntax with `!` terminator and `show()`/`ask()` functions

---

## 6. Parse Tree Examples

### Example 1: Integer Declaration with Arithmetic
**Code:** `int x = 10 + 5 * 2!`

```
         <statement>
              |
        <declaration>
         /    |    \
       /      |     \
     "int"  IDENTIFIER  "="  <expression>
              |                  |
             "x"            <expression>
                            /    |    \
                           /     |     \
                    <expression> "+" <expression>
                         |               |
                       NUMBER       <expression>
                         |            /    |    \
                        "10"         /     |     \
                                <expression> "*" <expression>
                                    |               |
                                  NUMBER          NUMBER
                                    |               |
                                    "5"             "2"
```

### Example 2: Comparison Operations
**Code:** `int flag = 5 > 3!`

```
              <statement>
                   |
              <declaration>
               /    |    \
             /      |     \
          "int" IDENTIFIER "=" <expression>
                   |               |
                 "flag"       <expression>
                              /    |    \
                             /     |     \
                       <expression> ">" <expression>
                            |               |
                          NUMBER          NUMBER
                            |               |
                           "5"             "3"
```

---

## 7. Derivation Examples

### Example: `x = 5 + 3!`

**Leftmost Derivation:**
```
<program>
⇒ <statement-list>
⇒ <statement>
⇒ <assignment> "!"
⇒ IDENTIFIER "=" <expression> "!"
⇒ "x" "=" <expression> "!"
⇒ "x" "=" <expression> "+" <expression> "!"
⇒ "x" "=" NUMBER "+" <expression> "!"
⇒ "x" "=" "5" "+" <expression> "!"
⇒ "x" "=" "5" "+" NUMBER "!"
⇒ "x" "=" "5" "+" "3" "!"
```

---

## 8. Sample Programs

### Program 1: Arithmetic Operations
```
int x = 10 + 5 * 2!
show(x)!

int y = 17 % 5!
show(y)!
```

**Output:**
```
20
2
```

### Program 2: Comparison Operations
```
# Comparison example
int test1 = 5 < 10!
show(test1)!

int test2 = 5 == 5!
show(test2)!

int test3 = 5 != 3!
show(test3)!
```

**Output:**
```
1
1
1
```

### Program 3: Complex Expressions
```
# Complex precedence example
int result = 2 + 3 * 4!
show(result)!
```

**Output:**
```
14
```

**Evaluation:**
1. `3 * 4 = 12` (multiplication, precedence 5)
2. `2 + 12 = 14` (addition, precedence 4)

---

## 9. Implementation Notes

### Bison Precedence Declarations

The grammar uses Bison's `%left` declarations to specify operator precedence:

```yacc
%left EQ NEQ          // Lowest precedence
%left LT GT LTE GTE
%left PLUS MINUS
%left MULT DIV MOD    // Highest precedence
```

Operators declared later have higher precedence. All operators are left-associative.

### Type Handling

- All expressions evaluate to `float` type
- Bitwise, logical, and shift operations cast operands to `int`
- Results are cast back to `float` for consistency
- Comparison and logical operators return `1.0` (true) or `0.0` (false)

---

## 10. Unique Syntax Features

### Statement Terminator
JNR uses `!` instead of `;` for statement termination, giving the language an energetic, unique feel.

### Keywords
- `int` - Integer type (whole numbers)
- `char` - Character type (single characters)
- `real` - Real number type (decimals, replaces traditional `float`)

### I/O Functions
- `show()` - Display output (replaces `print`)
- `ask()` - Get user input (replaces `input`)

### Comments
JNR supports Python-style hash comments:
```
# This is a comment
int x = 10!  # Comments can also go at the end of lines
```

---

## 10. Conclusion

This Context-Free Grammar defines the complete syntax of the jnr programming language v4.0. It supports:
- Three data types (int, char, real)
- Unique syntax with `!` terminator and `show()`/`ask()` functions
- Hash-style comments for code documentation
- Arithmetic expressions with 5 operators (+, -, *, /, %)
- Comparison operations (6 operators: <, >, <=, >=, ==, !=)
- Proper operator precedence for educational clarity
- Type-safe variable declarations

The grammar is implemented using Bison/Yacc with LALR(1) parsing and has been simplified from v3.0 by removing bitwise and logical operators to focus on fundamental programming concepts suitable for introductory computer science education.
