%{
#include <stdio.h>
#include <string.h>
#include "jnr.tab.h"
%}

%%

"int"                   { return INT; }
"char"                  { return CHAR; }
"float"                 { return FLOAT; }
"print"                 { return PRINT; }
"input"                 { return INPUT; }
[0-9]+\.[0-9]+          { yylval.floatval = atof(yytext); return FLOATLIT; }
[0-9]+                  { yylval.number = atoi(yytext); return NUM; }
'[^']'                  { yylval.charval = yytext[1]; return CHARLIT; }
[a-zA-Z][a-zA-Z0-9_]*   { yylval.string = strdup(yytext); return ID; }
"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MULT; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
[ \t\r]                 ;
\n                      { return NEWLINE; }
<<EOF>>                 { static int once = 0; if (!once) { once = 1; return NEWLINE; } else { return 0; } }
.                       { return yytext[0]; }

%%

int yywrap() { return 1; }
