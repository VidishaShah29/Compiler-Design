%{

#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
extern FILE* yyin;

%}

%token NL ID INT CHAR FLOAT DOUBLE comma

%%

stmt: dec NL;
dec: dtype idlist;;
idlist: ID|ID comma idlist;
dtype: INT|CHAR|FLOAT|DOUBLE;

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
