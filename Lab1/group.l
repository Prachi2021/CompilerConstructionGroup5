/*** Definition Section has 3 variables
which can be accessed inside yylex() 
and main() ***/

%{
int count_lowercase = 0;  // Initializing a counter for lowercase letters
int count_uppercase = 0;  // Initializing a counter for uppercase letters
int count_numbers = 0;    // Initializing a counter for numbers
int count_special = 0;    // Initializing a counter for punctuations and special characters
%}
 
/*** Rule Section has five rules ***/
%%
[A-Z] {                    // Checks for uppercase letters
    printf("%c is an uppercase letter\n", yytext[0]);  // Prints and displays the uppercase letter
    count_uppercase++;     // Increments the uppercase letter counter
}
[a-z] {                    // Checks for lowercase letters
    printf("%c is a lowercase letter\n", yytext[0]);  // Prints and displays the lowercase letter
    count_lowercase++;     // Increments the lowercase letter counter
}
[0-9] {                    // Checks for numerical digit
    printf("%c is a number\n", yytext[0]);            // Prints and displays the numerical digit
    count_numbers++;       // Increments the numerical digit counter
}
[\t ]+ {}  // Ignore spaces and tabs 
[^a-zA-Z0-9\t\n] {                        // Check for punctuations or special characters
    printf("%c is a special character\n", yytext[0]);        // Prints and displays the special character
    count_special++;       // Increments the special character counter
}
%%

/*** Code Section ***/
int yywrap() { }

int main() {
    char input_sentence[200];
    printf("Enter a sentence: ");

    // Reads a sentence as input
    fgets(input_sentence, sizeof(input_sentence), stdin);

    // Set yyin to read characters from a sentence string
    yy_scan_string(input_sentence);

    yylex();  // Invoking the lexer


    // Displaying the counts of each character type
    printf("Count of Uppercase characters: %d\n", count_uppercase);
    printf("Count of Lowercase characters: %d\n", count_lowercase);
    printf("Count of Numerical characters: %d\n", count_numbers);
    printf("Count of Special characters: %d\n", count_special);

    return 0;
}