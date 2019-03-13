%{
	#include "q2.tab.h"
%}

%%

"$" { return NL;}

"if" { return IF; }

"else" { return ELSE; }

"(" { return LB; }

")" { return RB; }

"{" { return LCB; }

"}" { return RCB; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

[0-9]+ { return NUM; }

"=" { return EQ; }

">"|">="|"<"|"<="|"=="|"!=" { return RELOP; }

%%

int yywrap(){

	return 1;
}
