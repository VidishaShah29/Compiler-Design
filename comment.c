//Program to remove single and multiline comments from a C file
#include<stdio.h>
#include<stdlib.h>

int main(){

FILE *fa, *fb;
int ca, cb;

//open input C file
fa = fopen("comment.c","r");

//check if exists
if(fa == NULL){
	
	printf("Cannot open file \n");
	exit(0);
}

//open output file
fb = fopen("out.c","w");

//read input file
ca = getc(fa);
while(ca != EOF){

	if(ca == '/'){
	
		cb = getc(fa);
		if(cb == '/'){

			while(ca != '\n')
				ca = getc(fa);
		}
		else if(cb == '*'){

			do {

				while(ca != '*') ca = getc(fa);
				ca = getc(fa);
			} while(ca != '/');
		}
		else{
	
			putc(ca,fb);
			putc(cb,fb);
		}
	}
	else putc(ca,fb);
	ca = getc(fa);
}

//close the files
fclose(fa);
fclose(fb);
return 0;

}
