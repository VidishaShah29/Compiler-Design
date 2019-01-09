/*Program to recognize all keywords and print them along with their line and column numbers*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

int main(){

FILE *fa;
int lc = 1, cc = 0, ca, i=0, f=0;
char key[11][10] = {"int","if","char","float","while","case","include","while","for","break","else"};
char buf[100]={0};

fa = fopen("q3.c","r");

//check if exists
if(fa == NULL){
	
	printf("Cannot open file \n");
	exit(0);
}

//read input file
ca = getc(fa); cc++;

while(ca != EOF){
	
		i=0; f=0;
		while( isalpha(ca)) {	buf[i++] = ca;
					ca = getc(fa); cc++;
		}
		buf[i] = '\0';

		for(i=0; i<11; i++){
			if(strcmp(buf,key[i]) == 0){

				f=1; break;
			}
		}
		
		if(f == 1){
			int c = cc - strlen(key[i]);
			printf("\n%s        LC: %d  CC: %d \n",(key[i]),lc,c);

		}
	if(ca == '\n') {lc++; cc=0;}

	ca = getc(fa); cc++;
}


//close the files
fclose(fa);

return 0;

}	
