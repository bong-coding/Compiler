%{
#include <stdio.h>
#include <string.h>

int length = 0;

void print(const char* type) {
    printf("%s\t%s\n", type, yytext);
}
%}

%start AA BB

letter      [A-Za-z_]
digit       [0-9]
id          {letter}({letter}|{digit})*
in_con      {digit}+
f_con       {digit}+"."{digit}*([eE][+-]?{digit}+)?  
keyword     struct|float|int
op1         [+\-=*/%&|!<>=~^]
op2         [\(\)\{\}\;\,\[\]]
newline     [ \t\n]+

%%

<AA>{newline}              ;  
<AA>"/*"                   { length = 1; BEGIN BB; }

<AA>{in_con}".."{in_con} {
	char* find = strstr(yytext, "..");
    if (find) {
        int len1 = find - yytext;
        char a1[5];
		char a2[5];
        strncpy(a1, yytext, len1);
        a1[len1] = '\0';
        strcpy(a2, find + 2);
        printf("INT\t%s\n", a1);
        printf("OP\t..\n");
        printf("INT\t%s\n", a2);
    }
    return 0;
}

<AA>{keyword} { print("KEY"); }
<AA>{id}      { print("ID"); }
<AA>{in_con}  { print("INT"); }
<AA>{f_con}   { print("F"); }
<AA>".."      { print("OP"); }
<AA>{op1}     { print("OP"); }
<AA>{op2}     { print("OP"); }
<BB>"/*"      { length++; }
<BB>"*/"      {
    length--;
    if (length == 0) BEGIN AA;
}
<BB>.|\n    ; 

.      { printf("OP\t%s\n", yytext); }

%%

int main (int argc, char** argv)
{
    ++argv, --argc;
    if (argc > 0) {
        yyin = fopen (argv[0], "r");
    } else {
        yyin = stdin;
    }
    BEGIN AA;
    yylex ();
    return 0;
}
