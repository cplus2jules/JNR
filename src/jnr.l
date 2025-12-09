%{
#include <stdio.h>
#include <string.h>
#include "jnr.tab.h"
%}

%%

"int"                   { return INT; }
"char"                  { return CHAR; }
"real"                  { return REAL; }
"show"                  { return SHOW; }
"ask"                   { return ASK; }

"<="                    { return LTE; }
">="                    { return GTE; }
"=="                    { return EQ; }
"!="                    { return NEQ; }

[0-9]+\.[0-9]+          { yylval.floatval = atof(yytext); return FLOATLIT; }
[0-9]+                  { yylval.number = atoi(yytext); return NUM; }
'[^']'                  { yylval.charval = yytext[1]; return CHARLIT; }
[a-zA-Z][a-zA-Z0-9_]*   { yylval.string = strdup(yytext); return ID; }

"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MULT; }
"/"                     { return DIV; }
"%"                     { return MOD; }
"<"                     { return LT; }
">"                     { return GT; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"!"                     { return EXCLAIM; }
","                     { return COMMA; }

"#".*                   ;  /* Hash comments */
[ \t\r\n]               ;
.                       { return yytext[0]; }

%%

int yywrap() { return 1; }
