	/* Lex/Yacc Basic Lisp Program
	*
	*  Author: Jimmy Nguyen
	*  Email: Jimmy@JimmyWorks.net
	*
	*  Yacc File for Parsing Tokens
	*/

%{

#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <map>
#include <list>
#include <string>
#include <math.h>
using namespace std;

// Map used to store values to declared identifiers
std::map<string, double> symbolMap;

// Function signatures used in middle section
extern int yylex();
double calculate(char*, list<double>);
void assign(char*, double);
double getSymbolVal(char*);
double convert8To10(int);
void yyerror(char const*);
%}

%union {double num; char* name; int integer;}

%start program

%token INCR DECR LET PRINT STOP
%token EQ LT LE GT GE NE IF
%token ATOM DECIMAL OCTAL INTEGER

%type <num> INTEGER DECIMAL list expr term cond if_then
%type <name> ATOM
%type <integer> OCTAL


%%
program : inputs	{ /* program start */ }

inputs	: input		{ /* one or */ }
	| input inputs	{ /* more inputs for interpreter */ }

input	: expr			{ cout << $1 << endl; }
	| '(' LET ATOM expr ')'	{ assign($3, $4); cout << $4 << endl; }
	| '(' PRINT term ')'	{ cout << $3 << endl; }
	| '(' STOP ')'		{ cout << "GOODBYE!\n"; exit(EXIT_SUCCESS);}

expr	: term				{ $$ = $1; }
	| list				{ $$ = $1; }
	| cond				{ $$ = $1; }
	| if_then			{ $$ = $1; }
	| '(' '+' expr expr ')'		{ $$ = $3 + $4; }
	| '(' '-' expr expr ')'		{ $$ = $3 - $4; }
	| '(' '*' expr expr ')'		{ $$ = $3 * $4; }
	| '(' '/' expr expr ')'		{ $$ = $3 / $4; }
	| '(' '^' expr expr ')' 	{ $$ = pow($3, $4); }
	| '(' INCR expr ')'		{$$ = $3 + 1;}
	| '(' DECR expr ')'		{$$ = $3 - 1;}

cond	: '(' EQ expr expr ')'		{if($3 == $4){$$=1;}else{$$=0;}}
	| '(' LT expr expr ')'		{if($3 <  $4){$$=1;}else{$$=0;}}
	| '(' LE expr expr ')'		{if($3 <= $4){$$=1;}else{$$=0;}}
	| '(' GT expr expr ')'		{if($3 >  $4){$$=1;}else{$$=0;}}
	| '(' GE expr expr ')'		{if($3 >= $4){$$=1;}else{$$=0;}}
	| '(' NE expr expr ')'		{if($3 != $4){$$=1;}else{$$=0;}}

if_then : '(' IF cond expr ')'		{if($3==1){$$=$4;}else{$$=0;}}
	| '(' IF cond expr expr ')'	{if($3==1){$$=$4;}else{$$=$5;}}

list	: '(' expr ')'	{$$ = $2;}

	
term	: INTEGER		{$$ = $1;}
	| DECIMAL		{$$ = $1;}
	| ATOM			{$$ = getSymbolVal($1);}
	| OCTAL			{$$ = convert8To10($1);}


%%
// Store Values to Identifiers
// Stores identifier - value pair into the symbol map
// input: char* name	identifier string
// input: double value	value stored to identifier
// return: none
void assign(char* name, double value)
{
	std::string str(name);
	symbolMap[str] = value;
}

// Get Values for Identifiers
// input: char* name	identifier string
// return: value associated with identifier or reports error
double getSymbolVal(char* name)
{
	std::string str(name);
	if(symbolMap.find(str) == symbolMap.end())
		yyerror("undefined");
	else
		return symbolMap[str];
}

// Convert Octal to Decimal Value
// input: int octal	octal to be converted
// return: decimal value stored in double type
double convert8To10(int octal)
{
	double decimal = 0;
	int i = 0;
	while(octal != 0)
	{
		decimal += (octal % 10) * pow(8,i++);
		octal /= 10;
	}
	return decimal;
}

// Report errors
// input: char const* s		error message
// return: none
void yyerror (char const *s)
{
	fprintf(stderr, "%s\n", s);
}

