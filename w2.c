//lexical analyzer
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>

void comment(FILE *fp, int ca);
void pre(FILE *fp, int ca);
void keyid(FILE *fp, int ca);
void literal(FILE *fp, int ca);
void logical(FILE *fp, int ca);

int cc = 0, lc = 1;

int main(){

	char ca, cb, buf[10];

	FILE *fp = fopen("test2.c","r");
	if (fp == NULL){
		printf("Cannot open file\n");
		exit(0);
	}

	ca = fgetc(fp); cc++;
	while (ca != EOF){
		int i = 0; 		
		buf[0] = '\0';

		//check for comments
		if(ca == '/')	comment(fp,ca);
		
		//ignore preprocessor directives
		else if(ca == '#')	pre(fp,ca);
		
		//relational operators
		else if(ca == '='){

			buf[i++] = ca;
			ca = fgetc(fp); cc++;
			if(ca == '='){
				buf[i++] = ca;
				buf[i] = '\0';
				int c = cc - strlen(buf);
				printf("\n%d %d Relational operator: %s",lc,c,buf);
			}
			else {
				int c = cc - strlen(buf);
				printf("\n%d %d Assignment Operator: =",lc,c);	
				fseek(fp,-1,SEEK_CUR); cc--;
				}

			
		}

		else if(ca == '<' || ca == '>' || ca == '!'){

			buf[i++] = ca;
			ca = fgetc(fp); cc++;
			if(ca == '=')
				buf[i++] = ca;
			buf[i] = '\0';
			int c = cc - strlen(buf);
			printf("\n%d %d Relational operator: %s",lc,c,buf);
		fseek(fp,-1,SEEK_CUR); cc--;
		}

		//arithmetic operators
		else if(ca == '*' || ca == '/' || ca == '+' || ca == '-' || ca == '^'){
			int c = cc - strlen(buf);
			printf("\n%d %d Arithmetic operator: %c",lc,c,ca);
		}

		//logical operators
		else if(ca == '&' || ca == '|' || ca == '!') logical(fp,ca);

		//special symbols
		else if(ca == ';' || ca == ',' || ca == '(' || ca == ')' || ca == '{' || ca == '}'){
			int c = cc - strlen(buf);
			printf("\n%d %d Special Symbol: %c",lc,c,ca);
		}

		//num constants
		else if(isdigit(ca)){	
			int c = cc - strlen(buf);			
			printf("\n%d %d Num constant: %c",lc,c,ca);
		}

		//string literals
		else if (ca == '"')	literal(fp,ca);

		//keywords and identifiers
		else if(isalpha(ca)) keyid(fp,ca);

		if(ca == '\n') {lc++; cc=0;}
		ca = fgetc(fp); cc++;
	}
	printf("\n");
}

void comment(FILE *fp, int ca){
		
	char cb = getc(fp); 
	if(cb == '/'){

		while(ca != '\n')
			{ca = getc(fp); }
		lc++; cc=0;
	}
	else if(cb == '*'){

		do {

			while(ca != '*') ca = getc(fp); 
			if(ca == '\n') {lc++; cc=0;}
			ca = getc(fp); 
		} while(ca != '/');
	}

}

void pre(FILE *fp, int ca){
		
	int i = 0, f = 0;
	char key[3][10] = {"define","if","include"};
	char buf[100]={0};
	
	char cb = getc(fp); cc++;

	while(isalpha(cb)) {	buf[i++] = cb;
				cb = getc(fp); cc++;
			}
	buf[i] = '\0';

	for(i=0; i<3; i++){
		if(strcmp(buf,key[i]) == 0){
			f=1; break;
		}
	}
		
	if(f == 1){
		ca = getc(fp); cc++;
		while(ca != '\n') {ca = getc(fp); cc++;}
		lc++; cc=0;
	}
	
}

void literal(FILE *fp, int ca){

	int i = 0; char buf[10];		
	buf[0] = '\0';
	char cb = fgetc(fp); cc++;
	while(cb != '"'){
		buf[i++] = cb;
		cb = fgetc(fp); cc++;
	}
	buf[i] = '\0';
int c = cc - strlen(buf);
	printf("\n%d %d String Literal: %s",lc,c,buf);
}

void logical(FILE *fp, int ca){

	int i = 0; char buf[10];			 	
	buf[0] = '\0';
	buf[i++] = ca;
	ca = fgetc(fp); cc++;
	if(ca == '&' || ca == '|')
		buf[i++] = ca;
	buf[i] = '\0';
int c = cc - strlen(buf);
	printf("\n%d %d Logical operator: %s",lc,c,buf);
	fseek(fp,-1,SEEK_CUR); cc--;
}

void keyid(FILE *fp, int ca){mbol: ;


	char key[12][10] = {"main","int","if","char","float","while","case","include","while","for","break","else"};
	char buf[10]={0};
	int i = 0, f = 0;

	while(isalpha(ca)) {	buf[i++] = ca;
				ca = getc(fp);  cc++;
		}
	buf[i] = '\0';

	for(i=0; i<12; i++){
		if(strcmp(buf,key[i]) == 0){
		f=1; break;
		}
	}
		int c = cc - strlen(buf);
	if(f == 1)	printf("\n%d %d Keyword: %s",lc,c,buf);
	else printf("\n%d %d Identifier: %s",lc,c,buf);

	fseek(fp,-1,SEEK_CUR); cc--;
}
