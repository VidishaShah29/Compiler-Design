//Program to discard preprocessor directives
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

int main(){

FILE *fa, *fb;
int i, f, ca, cb;
char key[3][10] = {"define","if","include"};
char buf[100]={0};

//open input C file
fa = fopen("test2.c","r");

//check if exists
if(fa == NULL){
	
	printf("Cannot open file \n");
	exit(0);
}

//open output file
fb = fopen("out1.c","w");

//read input file
ca = getc(fa);

while(ca != EOF){
	
	i=0, f=0;
	if(ca == '#'){
		cb = getc(fa);

		
		while( isalpha(cb)) {	buf[i++] = cb;
					//printf("check");
					cb = getc(fa);
		}
		buf[i] = '\0';

		for(i=0; i<3; i++){
			if(strcmp(buf,key[i]) == 0){

				f=1; break;
			}
		}
		
		if(f == 1){
			ca = getc(fa);
			while(ca != '\n') ca = getc(fa);
		}
	
		else{

			putc(ca,fb);
			fprintf(fb,"%s",buf);
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
