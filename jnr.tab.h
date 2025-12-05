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
     PLUS = 269,
     MINUS = 270,
     MULT = 271,
     DIV = 272,
     MOD = 273,
     LT = 274,
     GT = 275,
     LTE = 276,
     GTE = 277,
     EQ = 278,
     NEQ = 279,
     LPAREN = 280,
     RPAREN = 281
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
#define PLUS 269
#define MINUS 270
#define MULT 271
#define DIV 272
#define MOD 273
#define LT 274
#define GT 275
#define LTE 276
#define GTE 277
#define EQ 278
#define NEQ 279
#define LPAREN 280
#define RPAREN 281




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
#line 108 "jnr.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

