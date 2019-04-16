%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"

//int yylineno = 0;

%}

digit ([0-9])

%%

"println" {return(TOK_PRINTLN);}

"main" {return(TOK_MAIN);}

"(" {return(TOK_OPENB);}

")" {return(TOK_CLOSEB);}

"{" {return(TOK_OPENCB);}

"}" {return(TOK_CLOSECB);}

"=" {return(TOK_EQUAL);}

{digit}+        {
                        yylval.int_val = atoi(yytext);
                        return TOK_INT;
                }

{digit}+\.{digit}+([eE]{digit}+)?
                {
                yylval.flt_val=atof(yytext);
                return TOK_FLOAT;
                }

[a-z][a-zA-Z0-9]* {return(TOK_ID);}

";" {return(TOK_SEMICOLON);}
"-" {return(TOK_SUB);}
"*" {return(TOK_MUL);}
[ \n] {yylineno++ ;}

.       {printf("Invalid character '%c', ignored\n",
                        yytext[0]);
        }

%%
