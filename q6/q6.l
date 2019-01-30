%{

//to recognize and print tokens 

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define YY_DECL struct token *yylex(void)

enum tokenType { EOFILE = -1, keywords, arithmetic, SS, logical, id, relop, string, num, assignment};

struct token{

	char *lexeme;
	int index;
	unsigned int rowno, colno;
	enum tokenType type;

};

struct token *tk;
int lineno = 1, colno = 1;

struct token* allocToken(){

	struct token *tk;
	tk = (struct token*)malloc(sizeof(struct token));
	tk->lexeme = (char*)malloc(sizeof(char)*10);
	tk->index = -1;
	tk->type = EOFILE;
	return tk;
}

void setTokenArgs(struct token *tk, char *lexeme, int index, int rowno, int colno, enum tokenType type){

	if(tk == NULL) return;

	strcpy(tk->lexeme, lexeme);
	tk->index = index;
	tk->rowno = rowno;
	tk->colno = colno;
	tk->type = type;
}

%}

%%

"/*".*"*/" {

	int i = 0;
	while(yytext[i] != '\0'){

		if(yytext[i] == '\n'){	lineno++; colno = 1; }
		else colno++;
		i++;
	}
}

"//".*"\n" { lineno++; colno = 1; }


"define"|"if"|"include"|"int"|"float"|"char"|"main"|"while"|"case"|"for"|"break"|"else" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, keywords);
	colno += strlen(yytext);
	return (tk);	
}

[0-9]+ { 

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, num);
	colno += strlen(yytext);
	return tk; 
}

[a-zA-Z_][a-zA-Z_0-9]* {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, id);
	colno += strlen(yytext);
	return tk; 
}

(\"(.)*\") { 

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, string);
	colno += strlen(yytext);
	return tk; 
}

","|";"|"{"|"}"|"("|")" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, SS);
	colno++;
	return tk;
}

"+"|"-"|"*"|"/"|"^"|"++"|"--"|"-="|"*="|"/="|"+=" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, arithmetic);
	colno += strlen(yytext);
	return tk;
}

"=" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, assignment);
	colno++;
	return tk;
}

"&&"|"||"|"&"|"|"|"!" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno, logical);
	colno += strlen(yytext);
	return tk;
}

"\t" { colno +=8; }

"<"|">"|"<="|">="|"=="|"!=" {

	tk = allocToken();
	setTokenArgs(tk, yytext, -1, lineno, colno,relop);
	colno += strlen(yytext);
	return tk;
}

. { colno++; }

%%

void getNextToken(){

	int cnt = 0;
	while(tk = yylex()){

		printf("%d %d %d %s %d\n", cnt, tk->rowno, tk->colno, tk->lexeme, tk->type);
		cnt++;
	}

}

int main(int argc, char* argv[]){

	if(argc < 2){

		printf("Name of 1 C file required\n");
		exit(0);
	}

	yyin = fopen(argv[1], "r");

	getNextToken();
	
	return 0;
}

int yywrap() {

	return 1;
}
