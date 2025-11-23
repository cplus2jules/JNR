# jnr Language - Context-Free Grammar

This document presents the formal Context-Free Grammar (CFG) for the jnr programming language in multiple formats.

---

## 1. BNF Notation (Backus-Naur Form)

### Complete Grammar

```
<program>        ::= <statement-list>

<statement-list> ::= <statement>
                   | <statement-list> <statement>

<statement>      ::= <declaration> NEWLINE
                   | <assignment> NEWLINE
                   | <print-func> NEWLINE
                   | <input-func> NEWLINE
                   | NEWLINE

<declaration>    ::= "int" IDENTIFIER "=" <expression>
                   | "char" IDENTIFIER "=" CHAR-LITERAL
                   | "float" IDENTIFIER "=" <expression>

<assignment>     ::= IDENTIFIER "=" <expression>

<print-func>     ::= "print" "(" <expression> ")"
                   | "print" "(" CHAR-LITERAL ")"
                   | "print" "(" IDENTIFIER ")"

<input-func>     ::= "input" "(" IDENTIFIER ")"

<expression>     ::= <expression> "+" <expression>
                   | <expression> "-" <expression>
                   | <expression> "*" <expression>
                   | <expression> "/" <expression>
                   | "(" <expression> ")"
                   | NUMBER
                   | FLOAT-LITERAL
                   | IDENTIFIER

IDENTIFIER       ::= LETTER (LETTER | DIGIT | "_")*
NUMBER           ::= DIGIT+
FLOAT-LITERAL    ::= DIGIT+ "." DIGIT+
CHAR-LITERAL     ::= "'" CHARACTER "'"
NEWLINE          ::= "\n"
LETTER           ::= "a" | "b" | ... | "z" | "A" | "B" | ... | "Z"
DIGIT            ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
CHARACTER        ::= any printable character except "'"
```

---

## 2. EBNF Notation (Extended BNF)

Using `*` for zero or more, `+` for one or more, `?` for optional, `|` for alternatives.

```ebnf
program        = statement+ ;

statement      = ( declaration | assignment | print-func | input-func )? NEWLINE ;

declaration    = ( "int" | "float" ) IDENTIFIER "=" expression
               | "char" IDENTIFIER "=" CHAR-LITERAL ;

assignment     = IDENTIFIER "=" expression ;

print-func     = "print" "(" ( expression | CHAR-LITERAL | IDENTIFIER ) ")" ;

input-func     = "input" "(" IDENTIFIER ")" ;

expression     = term ( ( "+" | "-" ) term )* ;

term           = factor ( ( "*" | "/" ) factor )* ;

factor         = NUMBER
               | FLOAT-LITERAL
               | IDENTIFIER
               | "(" expression ")" ;

IDENTIFIER     = LETTER ( LETTER | DIGIT | "_" )* ;
NUMBER         = DIGIT+ ;
FLOAT-LITERAL  = DIGIT+ "." DIGIT+ ;
CHAR-LITERAL   = "'" CHARACTER "'" ;
```

---

## 3. Production Rules with Left/Right Recursion

### Left-Recursive (Original)

```
<expression> ::= <expression> "+" <expression>
               | <expression> "-" <expression>
               | <expression> "*" <expression>
               | <expression> "/" <expression>
               | <term>

<term>       ::= NUMBER
               | FLOAT-LITERAL
               | IDENTIFIER
               | "(" <expression> ")"
```

### Right-Recursive (Equivalent)

```
<expression>  ::= <term> <expr-tail>

<expr-tail>   ::= "+" <term> <expr-tail>
                | "-" <term> <expr-tail>
                | ε

<term>        ::= <factor> <term-tail>

<term-tail>   ::= "*" <factor> <term-tail>
                | "/" <factor> <term-tail>
                | ε

<factor>      ::= NUMBER
                | FLOAT-LITERAL
                | IDENTIFIER
                | "(" <expression> ")"
```

---

## 4. Operator Precedence & Associativity

| Operator | Precedence | Associativity | Description |
|----------|------------|---------------|-------------|
| `( )`    | Highest    | N/A           | Parentheses |
| `*` `/`  | 2          | Left          | Multiplication, Division |
| `+` `-`  | 1 (Lowest) | Left          | Addition, Subtraction |

### Example: `2 + 3 * 4`
Parses as: `2 + (3 * 4)` = `2 + 12` = `14`

---

## 5. Syntax Diagrams (Railroad Diagrams)

### Program
```
program → ┌─→ statement ─┐
          └──────←───────┘
```

### Statement
```
statement → ┬─→ declaration ─┬─→ NEWLINE ─┐
            ├─→ assignment ──┤            │
            ├─→ print-func ──┤            ├─→
            ├─→ input-func ──┤            │
            └─→ NEWLINE ─────┘            │
```

### Declaration
```
declaration → ┬─→ "int" ──────┬─→ IDENTIFIER ─→ "=" ─→ expression ─→
              ├─→ "float" ────┤
              └─→ "char" ─→ IDENTIFIER ─→ "=" ─→ CHAR-LITERAL ─→
```

### Expression
```
expression → ─→ term ─┬──────────────────┬─→
                      └─→ ┬─ "+" ─┬ term ┘
                           ├─ "-" ─┤
                           ├─ "*" ─┤
                           └─ "/" ─┘
```

### Term
```
term → ┬─→ NUMBER ────────┐
       ├─→ FLOAT-LITERAL ─┤
       ├─→ IDENTIFIER ────┤
       └─→ "(" ─→ expression ─→ ")" ─┘
```

---

## 6. Parse Tree Examples

### Example 1: Integer Declaration
**Code:** `int x = 10`

```
         <statement>
              |
        <declaration>
         /    |    \
       /      |     \
     "int"  IDENTIFIER  "="  <expression>
              |                  |
             "x"               <term>
                                 |
                              NUMBER
                                 |
                                "10"
```

### Example 2: Arithmetic Expression
**Code:** `print(x + y * 2)`

```
              <statement>
                   |
              <print-func>
                /  |  \
              /    |   \
          "print" "(" <expression> ")"
                        |
                   <expression>
                    /    |    \
                   /     |     \
            <expression> "+"  <expression>
                 |               |
              <term>         <expression>
                 |            /    |    \
            IDENTIFIER       /     |     \
                 |      <expression> "*" <expression>
                "x"          |               |
                          <term>          <term>
                             |               |
                        IDENTIFIER        NUMBER
                             |               |
                            "y"             "2"
```

### Example 3: Character Declaration
**Code:** `char c = 'A'`

```
         <statement>
              |
        <declaration>
         /    |    \
       /      |     \
    "char" IDENTIFIER "=" CHAR-LITERAL
              |              |
             "c"            'A'
```

---

## 7. Derivation Examples

### Example: `x = 5 + 3`

**Leftmost Derivation:**
```
<program>
⇒ <statement-list>
⇒ <statement>
⇒ <assignment> NEWLINE
⇒ IDENTIFIER "=" <expression> NEWLINE
⇒ "x" "=" <expression> NEWLINE
⇒ "x" "=" <expression> "+" <expression> NEWLINE
⇒ "x" "=" <term> "+" <expression> NEWLINE
⇒ "x" "=" NUMBER "+" <expression> NEWLINE
⇒ "x" "=" "5" "+" <expression> NEWLINE
⇒ "x" "=" "5" "+" <term> NEWLINE
⇒ "x" "=" "5" "+" NUMBER NEWLINE
⇒ "x" "=" "5" "+" "3" NEWLINE
```

**Rightmost Derivation:**
```
<program>
⇒ <statement-list>
⇒ <statement>
⇒ <assignment> NEWLINE
⇒ <assignment> "\n"
⇒ IDENTIFIER "=" <expression> "\n"
⇒ IDENTIFIER "=" <expression> "+" <expression> "\n"
⇒ IDENTIFIER "=" <expression> "+" <term> "\n"
⇒ IDENTIFIER "=" <expression> "+" NUMBER "\n"
⇒ IDENTIFIER "=" <expression> "+" "3" "\n"
⇒ IDENTIFIER "=" <term> "+" "3" "\n"
⇒ IDENTIFIER "=" NUMBER "+" "3" "\n"
⇒ IDENTIFIER "=" "5" "+" "3" "\n"
⇒ "x" "=" "5" "+" "3" "\n"
```

---

## 8. Grammar Properties

### Type
- **Context-Free Grammar (Type 2)** in Chomsky hierarchy

### Characteristics
- **Ambiguous:** The arithmetic expression grammar is ambiguous
- **Resolution:** Bison uses precedence declarations to resolve ambiguity
- **Left-Recursive:** Expression rules use left recursion for efficiency

### Production Count
- **Non-terminals:** 8 (program, statement-list, statement, declaration, assignment, print-func, input-func, expression)
- **Terminals:** 17 (keywords, operators, literals, identifiers)
- **Productions:** 23 total

### Language Class
- **Deterministic Context-Free Language (DCFL)**
- Parseable by deterministic pushdown automaton (DPDA)
- Implemented using LALR(1) parser (Bison)

---

## 9. First and Follow Sets

### FIRST Sets

```
FIRST(program)        = { "int", "char", "float", "print", "input", IDENTIFIER, NEWLINE }
FIRST(statement-list) = { "int", "char", "float", "print", "input", IDENTIFIER, NEWLINE }
FIRST(statement)      = { "int", "char", "float", "print", "input", IDENTIFIER, NEWLINE }
FIRST(declaration)    = { "int", "char", "float" }
FIRST(assignment)     = { IDENTIFIER }
FIRST(print-func)     = { "print" }
FIRST(input-func)     = { "input" }
FIRST(expression)     = { NUMBER, FLOAT-LITERAL, IDENTIFIER, "(" }
```

### FOLLOW Sets

```
FOLLOW(program)        = { $ }
FOLLOW(statement-list) = { $ }
FOLLOW(statement)      = { "int", "char", "float", "print", "input", IDENTIFIER, NEWLINE, $ }
FOLLOW(declaration)    = { NEWLINE }
FOLLOW(assignment)     = { NEWLINE }
FOLLOW(print-func)     = { NEWLINE }
FOLLOW(input-func)     = { NEWLINE }
FOLLOW(expression)     = { ")", "+", "-", "*", "/", NEWLINE }
```

---

## 10. Sample Programs with Parse Trees

### Program 1: Complete Example

**Code:**
```
int x = 10
float y = 3.14
char c = 'A'
print(x)
print(y)
print(c)
```

**Parse Tree:** (Simplified)
```
<program>
    |
<statement-list>
    |
    ├── <statement> (int x = 10)
    ├── <statement> (float y = 3.14)
    ├── <statement> (char c = 'A')
    ├── <statement> (print(x))
    ├── <statement> (print(y))
    └── <statement> (print(c))
```

---

## 11. Visual Grammar Summary

```
┌─────────────────────────────────────────┐
│           jnr Language Grammar          │
├─────────────────────────────────────────┤
│                                         │
│  Start Symbol: <program>                │
│                                         │
│  Statement Types:                       │
│    • Declarations (int, char, float)    │
│    • Assignments                        │
│    • Print function                     │
│    • Input function                     │
│                                         │
│  Expression Operations:                 │
│    • Addition (+)                       │
│    • Subtraction (-)                    │
│    • Multiplication (*)                 │
│    • Division (/)                       │
│    • Parentheses ()                     │
│                                         │
│  Data Types:                            │
│    • Integer literals                   │
│    • Float literals                     │
│    • Character literals                 │
│    • Identifiers (variables)            │
│                                         │
└─────────────────────────────────────────┘
```

---

## Conclusion

This Context-Free Grammar defines the complete syntax of the jnr programming language. It supports:
- Three data types (int, char, float)
- Arithmetic expressions with proper precedence
- Type-safe variable declarations
- I/O operations (print, input)
- Standard mathematical operators

The grammar is implemented using Bison/Yacc with LALR(1) parsing.
