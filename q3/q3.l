%{
	#include "q3.tab.h"
%}

%%

[0-9]+ { return NUM; }

"$" { return NL;}

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

"+" { return PLUS; }

"-" { return MINUS; }

"*" { return PROD; }

"/" { return DIV; }

%%

int yywrap(){

	return 1;
}
