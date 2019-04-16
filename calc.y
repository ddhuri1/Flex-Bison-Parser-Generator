%{
#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
int yylex();
int yyerror(char *s); 
int size=0; 
extern int lineno; 
struct symboltable{
        char name[100];
        char type[100];
        char value[100];
};
struct symboltable sym[100]; 
void printTable();
int search(char nm[]);
void insert(char name[], char type[], char value[]);

%} 
%token TOK_SEMICOLON TOK_SUB TOK_MUL TOK_INT TOK_FLOAT TOK_PRINTLN TOK_PRINT
%token TOK_ID TOK_MAIN TOK_OPENB TOK_CLOSEB TOK_OPENCB TOK_CLOSECB TOK_EQUAL 
%token <data> INT FLOAT 
%union{
	int int_val;
    	float flt_val;
    	char id[100];

	struct data_handle
	{
          	 int int_val;
           	 float flt_val;
           	 char return_type[50];
	}data;
	//struct data_handle data;
}

%type <id> TOK_ID
%type <data> expr CONSTANTS
%left TOK_SUB 
%left TOK_MUL
%start prog 

%%
 prog:TOK_MAIN TOK_OPENB TOK_CLOSEB TOK_OPENCB var stmts TOK_CLOSECB
 
; 

var:
    |vardef TOK_SEMICOLON var
; 

vardef:
        TOK_INT TOK_ID
        {
			int exist;
			exist = search($2);
    
			if(exist == -1)
			{
			insert($2,"int","0");
			printTable();
		}
		else
		{
			printf("Id Exists\n");
			//sym[exist].value=value;
			printTable();
		}
			
		}
	|TOK_FLOAT TOK_ID
        {
                        int exist;
                        exist = search($2);

                        if(exist == -1)
                        {
                        insert($2,"float","0.0");
                        printTable();
                }
                else
                {
                        printf("Id Exists\n");
                        //sym[exist].value=value;
                        printTable();
                }

                }

; stmts:
        |stmt TOK_SEMICOLON stmts
; stmt: 

	| TOK_ID TOK_EQUAL expr
        {
			
			            
			int index1;
			index1=search($1);
			  if(index1>-1)
			{		
				if (strcmp(sym[index1].type,$3.return_type)!=0)
		          	  {
               				 printf(" Line  Number %d : Type Error ", lineno);
                			 exit(1);
            			   }
				else
				   {
					char buf[100];
					 if(strcmp($3.return_type,"int")==0)
		                        {
						sprintf(buf,"%d",$3.int_val);
						strcpy(sym[index1].value,buf);
						printTable();
                        		}
                        		else
                        		{
						 sprintf(buf,"%f",$3.flt_val);
						strcpy(sym[index1].value,buf);
						printTable();            
            		}
					
				   }
			}
            		else
            		{

					 printf(" Line number %d: Variable is used but not declared");
					exit(1);
			}
						
		}
		|TOK_PRINTLN expr
            	{
			 if(strcmp($2.return_type,"int")==0)
                                        {
						printf("the value is %d\n", $2.int_val);
                                        }
                                        else
                                        {
						 printf("the value is %f\n", $2.flt_val);

                                        }

					
                 }
		|TOK_PRINT expr{if(strcmp($2.return_type,"int")==0)
                                        {
						printf("the value is %d\n", $2.int_val);
                                        }
                                        else
                                        {
						 printf("the value is %f\n", $2.flt_val);

                                        }

					
                 }


 			
; 
expr: expr TOK_SUB expr
           {

		struct data_handle handle_sub;
                if(strcmp($1.return_type,$3.return_type)==0)
                {
                    	if(strcmp($1.return_type,"int")==0)
			{
				strcpy(handle_sub.return_type,"int");
				handle_sub.int_val= $1.int_val - $3.int_val;

			}
			else
			{
				strcpy(handle_sub.return_type,"float");
				handle_sub.flt_val= $1.flt_val - $3.flt_val;
			}
                }
                else
                {
                    printf(" Line number %d: type error \n", lineno);
                    exit(1);
                }
			$$=handle_sub;
		}
		
	| expr TOK_MUL expr
           {
		struct data_handle handle_mult;
                if(strcmp($1.return_type,$3.return_type)==0)
                {
		 	if (strcmp($1.return_type,"int")==0)
			{
				strcpy(handle_mult.return_type,"int");
                    		handle_mult.int_val=$1.int_val * $3.int_val;
			}
			else
			{
				strcpy(handle_mult.return_type,"float");
				handle_mult.flt_val=$1.flt_val * $3.flt_val;
			}
                }
                else
                {
                    printf("Line number %d: Type Error \n", lineno);
                    exit(1);
                }
			$$=handle_mult;
        	}

	       |CONSTANTS
		{
			$$=$1;
		}	

		|TOK_ID
            {
		//printf("---%s---",$1);
                int index1=search($1);
				 struct data_handle handle;
				if(index1>-1)
				{
					//int a=atoi(sym[index1].value);
					//$$=a;
					if(strcmp(sym[index1].type,"int")==0)
					{
						strcpy(handle.return_type,"int");
						 handle.int_val=atoi(sym[index1].value);
					}
					else
					{
						strcpy(handle.return_type,"float");
						handle.flt_val=atof(sym[index1].value);
					}
				}
				$$=handle;

			}
		|CONSTANTS TOK_SUB CONSTANTS
		{struct data_handle handle_sub;
                if(strcmp($1.return_type,$3.return_type)==0)
                {
                    	if(strcmp($1.return_type,"int")==0)
			{
				strcpy(handle_sub.return_type,"int");
				handle_sub.int_val= $1.int_val - $3.int_val;

			}
			else
			{
				strcpy(handle_sub.return_type,"float");
				handle_sub.flt_val= $1.flt_val - $3.flt_val;
			}
                }
                else
                {
                    printf(" Line number %d: type error \n", lineno);
                    exit(1);
                }
			$$=handle_sub;
		}
|CONSTANTS TOK_MUL CONSTANTS
{
		struct data_handle handle_mult;
                if(strcmp($1.return_type,$3.return_type)==0)
                {
		 	if (strcmp($1.return_type,"int")==0)
			{
				strcpy(handle_mult.return_type,"int");
                    		handle_mult.int_val=$1.int_val * $3.int_val;
			}
			else
			{
				strcpy(handle_mult.return_type,"float");
				handle_mult.flt_val=$1.flt_val * $3.flt_val;
			}
                }
                else
                {
                    printf("Line number %d: Type Error \n", lineno);
                    exit(1);
                }
			$$=handle_mult;
        	}


;

CONSTANTS: INT  
		{
			$$=$1;
		}
	|FLOAT
		{
			$$=$1;		
	
		}
;
			
%% 
void insert(char name[], char type[], char value[])
{
    
   strcpy(sym[size].name,name);
    strcpy(sym[size].type,type);
    strcpy(sym[size].value,value);
    size++;
    
}
int search(char nm[]) {
    int i;
    for(i=0;i<size;i++)
    {
	//printf("\ntest 5 Value in symbol table at 1th location - %s, value to be searched - %s\n", sym[i].name, nm);
        if(strcmp(sym[i].name, nm) == 0)
            {
	//			printf(" \n for size %d name(%s) index(%d) value(%s)",size,sym[i].name,i,sym[i].value);
				return i;
			}
    }
	return -1;
}
int yyerror(char *s) {
       // extern char *yytext;
	//	printf("Parser error %s \n",y);
		printf("Line number : %d Parsing error\n%s\n", lineno,s);
        exit(1);
}
void printTable() {
	int i;
	for(i = 0; i< size; i++)
	{
		printf("\n%s \t%s \t%s ", sym[i].name, sym[i].type, sym[i].value);
	}
}
int main() {
        yyparse();
        return 0;
}
