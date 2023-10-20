%{
    #include <stdio.h>
    int keyword_count = 0;
    int identifier_count = 0;
    int number_count = 0;
    int operator_count = 0;
    int error_count = 0;
    int paren_count = 0;
%}

%x STR COMMENT PREPROCESSOR

%%
"if"|"else"|"while"|"for"|"int"|"char"|"return"   { printf("Keyword: %s\n", yytext); keyword_count++; }
[a-zA-Z_][a-zA-Z0-9_]*                            { printf("Identifier: %s\n", yytext); identifier_count++; }
[0-9]+                                           { printf("Number: %s\n", yytext); number_count++; }
[+\-*/=<>]                                       { printf("Operator: %s\n", yytext); operator_count++; }
\"                                              { BEGIN(STR); }
\/\/[^\n]*                                      { printf("Comment: %s\n", yytext); }
\/\*([^*]|\*+[^*/])*\*+\/                        { printf("Comment: %s\n", yytext); }
\#include                                       { BEGIN(PREPROCESSOR); }
\(|\)                                           { printf("Parenthesis: %s\n", yytext); paren_count++; }
[ \t\n]                                         ; // Ignore whitespace and newline characters
.                                               { printf("Error: Unexpected character '%s' at line %d\n", yytext, yylineno); error_count++; }

<STR>\"([^\"\\]|\\.)*\"                          { printf("String: %s\n", yytext); }
<STR>\n                                        { printf("Error: Newline in string at line %d\n", yylineno); error_count++; }
<STR>.                                         { /* Ignore other characters in strings */ }

<PREPROCESSOR><.*>                             { printf("Preprocessor Directive: %s\n", yytext); BEGIN(INITIAL); }

%%

int main() {
    yylex();
    printf("\nCounts:\nKeywords: %d\nIdentifiers: %d\nNumbers: %d\nOperators: %d\nErrors: %d\nParentheses: %d\n", 
           keyword_count, identifier_count, number_count, operator_count, error_count, paren_count);
    return 0;
}
