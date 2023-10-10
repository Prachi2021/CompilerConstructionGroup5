

/***

136291 Shubh Patel	
135736 Sheikh Ali 
137223 Prachi Patel	
135251 Evans Okania	
136730 Kevin Kipkoech	
116827 Kweyu Nicolas Anelka	
136663 Sean Kimutai 
134786 Ryan Lagat	

**/


%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
%}
%option noyywrap

/* Declaring pointers to static identifiers  */
%{
    char* identifiers[] = {
        "myVariable",   /* should output valid identifier */
        "isAVeryLongIdentifierName_1234567890",  /* should output invalid identifier - because it exceeds the length of 30 */
        "hello123",   /* should output valid identifier */
        "783873", /* should output invalid identifier - because it has only digits */
        "_variable",    /* should output valid identifier */
        "1identifier",  /* should output invalid identifier - because it starts with a digit */
        "invalid-identifier",  /* should output invalid identifier - because it has a hyphen */
        "my_var",   /* should output valid identifier */
        "has space",  /* should output invalid identifier - because it has a space */
        "has_no_space"   /* should output valid identifier */
    };
    int numIdentifiers = sizeof(identifiers) / sizeof(identifiers[0]);
%}

%%
[a-z_][a-zA-Z0-9_]{0,29}  { /*   RE to match valid identifiers: starting with small alphabetical letters or an underscore, followed by aplhabetical letter, digits or underscores upto 29 characters   */
    int i;
    bool isValid = false;
    for (i = 0; i < numIdentifiers; i++) {
	/*   Check if the identifier is in the array    */
        if (strcmp(yytext, identifiers[i]) == 0) {
            isValid = true;
            break;
        }
    }
    if (isValid) {
        printf("%s is a valid identifier.\n", yytext);
    } 
}

[0-9][a-zA-Z0-9_]* {
    printf("%s is an invalid identifier (starts with a digit).\n", yytext);
}

[a-zA-Z_].*[-].* {
    printf("%s is an invalid identifier (contains hyphen).\n", yytext);
}

[a-zA-Z_].*[ ]+.* {
    printf("%s is an invalid identifier (contains space).\n", yytext);
}

.{31,} {
    printf("%s is an invalid identifier (exceeds 30 characters).\n", yytext);
}

. {
    printf("%s is an invalid identifier.\n", yytext);
}
%%

int main() {
    printf("----------------------------Checking for valid and invalid identifiers----------------------------\n");
    for (int i = 0; i < numIdentifiers; i++) {
	/*    Passing each identifier to the lexer        */
        yy_scan_string(identifiers[i]); 
        yylex(); 
    }
    return 0;
}
