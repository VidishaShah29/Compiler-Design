%{
	int pf = 0, nf = 0, p = 0, n = 0;
%}

%%

"+"?[0-9]+"."[0-9]+ pf++;
"-"[0-9]+"."[0-9]+ nf++;
"+"?[0-9]+ p++;
"-"[0-9]+ n++;

%%

int main(int argc, char* argv[])
{
	yylex();
	printf("Positive floating point numbers: %d \nNegative floating point numbers: %d \nPositive integers: %d \nNegative integers: %d\n", pf, nf, p, n);
	return 0;
	
}

int yywrap() {

	return 1;
}
