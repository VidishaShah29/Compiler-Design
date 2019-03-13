%{
	#include "q4.tab.h"
%}

%%

"$" { return NL;}

[0-9]+ { return NUM; }

"+" { return PLUS; }

"-" { return MINUS; }

"*" { return PROD; }

"/" { return DIV; }

"^" { return POW; }


%%

int yywrap(){

	return 1;
}
