//Program to replace blank spaces and tabs by a single space
#include<stdio.h>
#include<stdlib.h>

int main(){

FILE *fa, *fb;
int ca;

//open input C file
fa = fopen("test2.c","r");

//check if exists
if(fa == NULL){
	
	printf("Cannot open file \n");
	exit(0);
}

//open output file
fb = fopen("out2.c","w");

//read input file
ca = getc(fa);
while(ca != EOF){

	if(ca == ' ' || ca == '\t'){

		while(ca == ' ' || ca == '\t')
			ca = getc(fa);
		putc(' ',fb);
		putc(ca,fb);
	}
	else putc(ca,fb);
	ca = getc(fa);
}

//close the files
fclose(fa);
fclose(fb);

return 0;

}
