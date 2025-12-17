%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

enum VarType { TYPE_INT, TYPE_CHAR };

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


int get_symbol(char* name) {
    for(int i=0; i<symbolCount; i++) {
        if(strcmp(symbolTable[i].name, name) == 0) {
            switch(symbolTable[i].type) {
                case TYPE_INT: return symbolTable[i].value.intval;
                case TYPE_CHAR: return (int)symbolTable[i].value.charval;
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
    char charval;
    char* string;
}

%token <number> NUM
%token <charval> CHARLIT
%token <string> ID
%token START INT CHAR SHOW ASSIGN EXCLAIM COMMA
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN LBRACE RBRACE

%left PLUS MINUS
%left MULT DIV

%type <number> expr

%%

program:
    START LPAREN RPAREN LBRACE statement_list RBRACE
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    declaration EXCLAIM
    | assignment EXCLAIM
    | print_func EXCLAIM
    ;

declaration:
    INT var_list_int
    | CHAR var_list_char
    ;

var_list_int:
    ID ASSIGN expr                      { set_symbol_int($1, (int)$3); }
    | ID                                { set_symbol_int($1, 0); }
    | var_list_int COMMA ID ASSIGN expr { set_symbol_int($3, (int)$5); }
    | var_list_int COMMA ID             { set_symbol_int($3, 0); }
    ;

var_list_char:
    ID ASSIGN CHARLIT                       { set_symbol_char($1, $3); }
    | ID                                    { set_symbol_char($1, '\0'); }
    | var_list_char COMMA ID ASSIGN CHARLIT { set_symbol_char($3, $5); }
    | var_list_char COMMA ID                { set_symbol_char($3, '\0'); }
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
    SHOW LPAREN expr RPAREN    { printf("%d\n", $3); }
    | SHOW LPAREN CHARLIT RPAREN { printf("%c\n", $3); }
    | SHOW LPAREN ID RPAREN    {
        for(int i=0; i<symbolCount; i++) {
            if(strcmp(symbolTable[i].name, $3) == 0) {
                switch(symbolTable[i].type) {
                    case TYPE_INT:
                        printf("%d\n", symbolTable[i].value.intval);
                        break;
                    case TYPE_CHAR:
                        printf("%c\n", symbolTable[i].value.charval);
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



expr:
    NUM                     { $$ = $1; }
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
