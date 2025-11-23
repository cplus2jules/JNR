%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

enum VarType { TYPE_INT, TYPE_CHAR, TYPE_FLOAT };

struct Symbol {
    char name[50];
    enum VarType type;
    union {
        int intval;
        char charval;
        float floatval;
    } value;
};

struct Symbol symbolTable[100];
int symbolCount = 0;

void set_symbol_int(char* name, int val) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].type = TYPE_INT;
            symbolTable[i].value.intval = val;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].type = TYPE_INT;
    symbolTable[symbolCount].value.intval = val;
    symbolCount++;
}

void set_symbol_char(char* name, char val) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].type = TYPE_CHAR;
            symbolTable[i].value.charval = val;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].type = TYPE_CHAR;
    symbolTable[symbolCount].value.charval = val;
    symbolCount++;
}

void set_symbol_float(char* name, float val) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].type = TYPE_FLOAT;
            symbolTable[i].value.floatval = val;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].type = TYPE_FLOAT;
    symbolTable[symbolCount].value.floatval = val;
    symbolCount++;
}

float get_symbol(char* name) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            switch(symbolTable[i].type) {
                case TYPE_INT: return (float)symbolTable[i].value.intval;
                case TYPE_CHAR: return (float)symbolTable[i].value.charval;
                case TYPE_FLOAT: return symbolTable[i].value.floatval;
            }
        }
    }
    printf("Error: Variable '%s' not defined.\n", name);
    exit(1);
}

enum VarType get_symbol_type(char* name) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            return symbolTable[i].type;
        }
    }
    printf("Error: Variable '%s' not defined.\n", name);
    exit(1);
}
%}

%union {
    int number;
    float floatval;
    char charval;
    char* string;
}

%token <number> NUM
%token <floatval> FLOATLIT
%token <charval> CHARLIT
%token <string> ID
%token INT CHAR FLOAT PRINT INPUT ASSIGN NEWLINE
%token PLUS MINUS MULT DIV LPAREN RPAREN

%left PLUS MINUS
%left MULT DIV

%type <floatval> expr

%%

program:
    statement_list
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    declaration NEWLINE
    | assignment NEWLINE
    | print_func NEWLINE
    | input_func NEWLINE
    | declaration
    | assignment
    | print_func
    | input_func
    | NEWLINE
    ;

declaration:
    INT ID ASSIGN expr          { set_symbol_int($2, (int)$4); }
    | CHAR ID ASSIGN CHARLIT    { set_symbol_char($2, $4); }
    | FLOAT ID ASSIGN expr      { set_symbol_float($2, $4); }
    ;

assignment:
    ID ASSIGN expr              { 
        int found = 0;
        for(int i=0; i<symbolCount; i++) {
            if(strcmp(symbolTable[i].name, $1) == 0) {
                found = 1;
                switch(symbolTable[i].type) {
                    case TYPE_INT:
                        symbolTable[i].value.intval = (int)$3;
                        break;
                    case TYPE_CHAR:
                        symbolTable[i].value.charval = (char)$3;
                        break;
                    case TYPE_FLOAT:
                        symbolTable[i].value.floatval = $3;
                        break;
                }
                break;
            }
        }
        if(!found) {
            set_symbol_int($1, (int)$3);
        }
    }
    ;

print_func:
    PRINT LPAREN expr RPAREN    { printf("%.2f\n", $3); }
    | PRINT LPAREN CHARLIT RPAREN { printf("%c\n", $3); }
    | PRINT LPAREN ID RPAREN    {
        for(int i=0; i<symbolCount; i++) {
            if(strcmp(symbolTable[i].name, $3) == 0) {
                switch(symbolTable[i].type) {
                    case TYPE_INT:
                        printf("%d\n", symbolTable[i].value.intval);
                        break;
                    case TYPE_CHAR:
                        printf("%c\n", symbolTable[i].value.charval);
                        break;
                    case TYPE_FLOAT:
                        printf("%.2f\n", symbolTable[i].value.floatval);
                        break;
                }
                goto print_done;
            }
        }
        printf("Error: Variable '%s' not defined.\n", $3);
        exit(1);
        print_done:;
    }
    ;

input_func:
    INPUT LPAREN ID RPAREN  { 
        int val;
        printf("Input value for %s: ", $3);
        scanf("%d", &val);
        set_symbol_int($3, val);
    }
    ;

expr:
    NUM                     { $$ = (float)$1; }
    | FLOATLIT              { $$ = $1; }
    | ID                    { $$ = get_symbol($1); }
    | expr PLUS expr        { $$ = $1 + $3; }
    | expr MINUS expr       { $$ = $1 - $3; }
    | expr MULT expr        { $$ = $1 * $3; }
    | expr DIV expr         { 
        if($3 == 0) { printf("Error: Division by zero\n"); exit(1); }
        $$ = $1 / $3; 
    }
    | LPAREN expr RPAREN    { $$ = $2; }
    ;

%%

int main() {
    printf("Welcome to jnr! (Type your code, Press Ctrl+D to run)\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}
