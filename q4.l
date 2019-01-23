%{
	int ns = 0, np = 0;
%}

%%

"scanf" { ns++; fputs("READ",yyout); }
"printf" { np++; fputs("WRITE",yyout); }
"." { fputs(yytext,yyout); }

%%

int main(int argc, char* argv[])
{
	if(argc < 2){

		printf("Name of 1 C file required\n");
		exit(0);
	}

	yyin = fopen(argv[1], "r");
	yyout = fopen("out.c","w");
	yylex(); 
	printf("scanf count: %d printf count: %d \n", ns, np);
	return 0;
	
}

int yywrap() {

	return 1;
}
