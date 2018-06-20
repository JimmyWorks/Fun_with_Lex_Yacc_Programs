# Lex/Yacc Basic Lisp Program
#
#  Author: Jimmy Nguyen
#  Email: Jimmy@JimmyWorks.net
#
# Makefile for Lex/Yacc Basic Lisp Parser

EXE = basic_lisp
MAIN = main.cc 
LEX = tokenizer.c
YACC = grammar.tab.c
OBJS = $(YACC) $(LEX) $(MAIN)

# make all
all: $(EXE)

$(EXE): $(OBJS) 
	g++ $^ -o $@

$(YACC) $(YACC:.c=.h): $(YACC:.tab.c=.y)
	bison -d $^

$(LEX): $(LEX:.c=.l) $(YACC:.c=.h)
	flex -o $@ $(LEX:.c=.l) 

# make clean
clean:
	rm -f *.o $(EXE) $(LEX) $(YACC:.c=.h) $(YACC)


