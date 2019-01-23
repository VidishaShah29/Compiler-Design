%{
	int com = 0;
%}

%%

[ ][aA][nN][dD][ ] { com++; }
[ ][oO][Rr][ ] { com++; }

%%

int main(int argc, char* argv[])
{
	yylex();
	if(com == 0) printf("Simple Statement\n");
	else printf("Compound Statement\n");
	return 0;
	
}

int yywrap() {

	return 1;
}
