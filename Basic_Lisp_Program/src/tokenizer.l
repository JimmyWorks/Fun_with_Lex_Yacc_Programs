/* Lex/Yacc Basic Lisp Program
*
*  Author: Jimmy Nguyen
*  Email: Jimmy@JimmyWorks.net
*
*  Lex File for Tokenizing Input
*/

%option noyywrap
%option nounput
%option noinput

%{
#include "grammar.tab.h"
%}

%%
[ \t\n]+		{ /*delimiter*/ }
;.*\n			{ /* ignore comments */ }
[+\-*/^=()]		{ return yytext[0]; }
"1-"			{ return DECR; }
"1+"			{ return INCR; }
let			{ return LET; }
print			{ return PRINT; }
EQ			{ return EQ; }
LT			{ return LT; }
LE			{ return LE; }
GT			{ return GT; }
GE			{ return GE; }
NE			{ return NE; }
[sS][tT][oO][pP] 	{ return STOP; }
if			{ return IF; }
[a-zA-Z][a-zA-Z0-9_]*	{ yylval.name = strdup(yytext); return ATOM; }
[0-9]+\.[0-9]+		{ yylval.num = atof(yytext); return DECIMAL; }
0[0-9]+			{ yylval.integer = atoi(yytext); return OCTAL; }
[0-9]|[1-9][0-9]*	{ yylval.num = atoi(yytext); return INTEGER; }

%%
