subc: lex.yy.o 
	gcc -o subc lex.yy.o -ll
lex.yy.o: lex.yy.c
	gcc -c -g lex.yy.c
lex.yy.c: subc.l
	flex subc.l
