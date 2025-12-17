%{
#include <stdio.h>
#include <string.h>
#include "jnr.tab.h"
%}

%%

"start"                 { return START; }
"int"                   { return INT; }
"char"                  { return CHAR; }
"show"                  { return SHOW; }

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
"{"                     { return LBRACE; }
"}"                     { return RBRACE; }
"!"                     { return EXCLAIM; }
","                     { return COMMA; }

"#".*                   ;  /* Hash comments */
[ \t\r\n]               ;
.                       { return yytext[0]; }

%%

int yywrap() { return 1; }
