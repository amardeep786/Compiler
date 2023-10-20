%{
    #include <stdio.h>
%}

%%
[0-9]+          { printf("Matched a number: %s\n", yytext); }
[a-zA-Z]+       { printf("Matched a word: %s\n", yytext); }
"if"            { printf("Matched the keyword 'if'\n"); }
"else"          { printf("Matched the keyword 'else'\n"); }
"while"         { printf("Matched the keyword 'while'\n"); }
"for"           { printf("Matched the keyword 'for'\n"); }
"=="            { printf("Matched '==' operator\n"); }
"+"            { printf("Matched '+' operator\n"); }
"*"            { printf("Matched '*' operator\n"); }
"!="            { printf("Matched '!=' operator\n"); }
[ \t\n]         ; // Ignore whitespace and newline characters
.               { printf("Unknown character: %s\n", yytext); }

%%
int main() {
    yylex();
    return 0;
}
