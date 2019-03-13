%{

#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
extern FILE* yyin;

%}

%token NL ID NUM PLUS MINUS DIV PROD
%left '*' '/' '+' '-'

%%

stmt: exp NL;
exp: term|exp PLUS term|exp MINUS term|exp PROD term|exp DIV term;
term: ID|NUM;

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
