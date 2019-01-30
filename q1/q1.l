%{
	int v = 0, c = 0;
%}

%%

[aeiouAEIOU] { v++; }
[a-zA-Z] { c+=1; } 


%%

int main(int argc, char* argv[]){	
	
	yylex();
	printf("Vowels: %d Consonants: %d\n", v, c);
	return 0;
	
}

int yywrap() {

	return 1;
}
