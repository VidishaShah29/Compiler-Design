%{

#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
extern FILE* yyin;

%}

%token IF LB RB LCB RCB ELSE NL ID NUM RELOP EQ

%%

DM: IF LB EXP RB LCB STMT RCB EL NL;
EL: |ELSE LCB STMT RCB;
EXP: TERM RELOP TERM;
TERM: ID|NUM;
STMT: TERM EQ TERM;;

%%

int yyerror(){

	printf("Invalid\n");
	return 1;
}

void main(){

	yyin = fopen("in.c","r");
	do{
		if(yyparse()){
			
			printf("FAILURE\n");
			exit(0);
		}
		
	}while(!feof(yyin));
	printf("SUCCESS\n");
}
