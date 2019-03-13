%{
	#include "q1.tab.h"
%}

%%

"$" { return NL;}

"int" { return INT; }

"float" { return FLOAT; }

"char" { return CHAR; }

"double" { return DOUBLE; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

"," { return comma; }

%%

int yywrap(){

	return 1;
}
