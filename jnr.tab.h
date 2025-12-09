/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUM = 258,
     FLOATLIT = 259,
     CHARLIT = 260,
     ID = 261,
     INT = 262,
     CHAR = 263,
     REAL = 264,
     SHOW = 265,
     ASK = 266,
     ASSIGN = 267,
     EXCLAIM = 268,
     COMMA = 269,
     PLUS = 270,
     MINUS = 271,
     MULT = 272,
     DIV = 273,
     MOD = 274,
     LT = 275,
     GT = 276,
     LTE = 277,
     GTE = 278,
     EQ = 279,
     NEQ = 280,
     LPAREN = 281,
     RPAREN = 282
   };
#endif
/* Tokens.  */
#define NUM 258
#define FLOATLIT 259
#define CHARLIT 260
#define ID 261
#define INT 262
#define CHAR 263
#define REAL 264
#define SHOW 265
#define ASK 266
#define ASSIGN 267
#define EXCLAIM 268
#define COMMA 269
#define PLUS 270
#define MINUS 271
#define MULT 272
#define DIV 273
#define MOD 274
#define LT 275
#define GT 276
#define LTE 277
#define GTE 278
#define EQ 279
#define NEQ 280
#define LPAREN 281
#define RPAREN 282




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 91 "src/jnr.y"
{
    int number;
    float floatval;
    char charval;
    char* string;
}
/* Line 1529 of yacc.c.  */
#line 110 "jnr.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

