%{

#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
extern FILE* yyin;

%}

%token NL NUM PLUS MINUS PROD DIV POW

%%

IN: IN LINE | ;
LINE: NL|EXP NL;
EXP: NUM | EXP EXP PLUS | EXP EXP MINUS | EXP EXP PROD | EXP EXP DIV | EXP EXP POW ;

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
