/* Lex/Yacc Basic Lisp Program
*
*  Author: Jimmy Nguyen
*  Email: Jimmy@JimmyWorks.net
*
*  C++ Program Main Source File
*  Program simulating basic Lisp functionality
*/

#include <stdio.h>
#include "grammar.tab.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

int main(void)
{
        return yyparse();
}
