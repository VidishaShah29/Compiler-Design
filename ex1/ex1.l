%{
	int chars = 0, words = 0, lines = 0, blanks = 0;
%}

%%

[a-zA-Z]+ { words++; chars+= strlen(yytext); }
\n { chars++; lines++; }
" " { blanks++; }
. { chars++; }

%%

int main(int argc, char* argv[])
{
	yylex();
	printf("Lines: %d Words: %d Characters: %d Blanks: %d\n", lines, words, chars, blanks);
	return 0;
	
}

int yywrap() {

	return 1;
}
