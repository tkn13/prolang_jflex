%%
%public
%class MyLex
%standalone
%unicode
%type Token // Use Token as the return type

%state ONE_LINE_COMMENT
%state MULTI_LINE_COMMENT

%{
  public class LexerError extends RuntimeException {
    public LexerError(String message) {
      super(message);
    }
  }
%}

WS  = [ \t\r\n]+
PARENTHESES = [()]
SEMICOLON = ;
INTEGER = [0-9]+
INDENTIFIER = [a-zA-Z][a-zA-Z0-9]*
STRING = \"([^\\\"]|\\.)*\"
ERROR = [0-9]+[a-zA-Z]+

%%

<YYINITIAL> {

    {WS} { /* ignore whitespace */ }

    "+"|"-"|"*"|"/"|"="|">"|">="|"<="|"=="|"++"|"--" 
    {
        return new Token(Token.Type.operator, yytext());
    }

    {PARENTHESES}
    {
        return new Token(Token.Type.parentheses, yytext());
    }

    {SEMICOLON}
    {
        return new Token(Token.Type.semicolon, yytext());
    }

    "if"| "then"| "else"| "endif"| "while"| "do"| "endwhile"| "print"| "newline"| "read"
    {
        return new Token(Token.Type.keyword, yytext());
    }

    {INTEGER}
    {
        return new Token(Token.Type.integers, yytext());
    }

    {INDENTIFIER}
    {
        return new Token(Token.Type.identifiers, yytext());
    }

    {STRING}
    {
        return new Token(Token.Type.string, yytext());
    }

    "//" 
    {
        yybegin(ONE_LINE_COMMENT); // Switch to ONE_LINE_COMMENT state
    }

    "/*" 
    {
        yybegin(MULTI_LINE_COMMENT); // Switch to MULTI_LINE_COMMENT state
    }

    {ERROR}
        {
        throw new LexerError("Invalid character: " + yytext());
        }

}

<ONE_LINE_COMMENT> {
    [^\n]+ { /* Ignore the comment text */ }
    \n     { yybegin(YYINITIAL); /* Return to initial state on newline */ }
    <<EOF>> { yybegin(YYINITIAL); /* Return to initial state if EOF reached in comment */ }
}

<MULTI_LINE_COMMENT> {
    [^*/]+ { /* Ignore the comment text */ }
    "*/"   { yybegin(YYINITIAL); /* Return to initial state on comment end */ }
    <<EOF>> { yybegin(YYINITIAL); /* Return to initial state if EOF reached in comment */ }
}

<<EOF>> {
    return null;
}
