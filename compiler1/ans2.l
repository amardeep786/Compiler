%{
    #include <stdio.h>
    int keyword_count = 0;
    int identifier_count = 0;
    int number_count = 0;
    int operator_count = 0;
    int string_count = 0;
    int comment_count = 0;
    int float_count = 0;
%}

%x STR COMMENT FLOAT

%%
"if"|"else"|"while"|"for"|"int"|"char"|"return"   { printf("Keyword: %s\n", yytext); keyword_count++; }
[a-zA-Z_][a-zA-Z0-9_]*                            { printf("Identifier: %s\n", yytext); identifier_count++; }
[0-9]+                                           { printf("Number: %s\n", yytext); number_count++; }
[+\-*/=<>]                                       { printf("Operator: %s\n", yytext); operator_count++; }
\"                                              { BEGIN(STR); }
\/\/[^\n]*                                      { BEGIN(COMMENT); }
\/\*                                            { BEGIN(COMMENT); }
[ \t\n]                                         ; // Ignore whitespace and newline characters
.                                               { printf("Unknown token: %s\n", yytext); }

<STR>\"([^\"\\]|\\.)*\"                          { printf("String: %s\n", yytext); string_count++; BEGIN(INITIAL); }
<COMMENT>\/\/[^\n]*                              { /* Ignore single line comments */ }
<COMMENT>\/\*([^*]|\*+[^*/])*\*+\/              { printf("Comment: %s\n", yytext); comment_count++; BEGIN(INITIAL); }
<COMMENT>\n                                    { /* Ignore newlines in multi-line comments */ }
<COMMENT>.                                     { /* Ignore other characters in multi-line comments */ }
<INITIAL>{DIGIT}*\.{DIGIT}+                     { printf("Float: %s\n", yytext); float_count++; }

%%

int main() {
    yylex();
    printf("\nCounts:\nKeywords: %d\nIdentifiers: %d\nNumbers: %d\nOperators: %d\nStrings: %d\nComments: %d\nFloats: %d\n", 
           keyword_count, identifier_count, number_count, operator_count, string_count, comment_count, float_count);
    return 0;
}
