/* You do not need to change anything up here. */
package lexer;

import frontend.Token;
import static frontend.Token.Type.*;

%%

%public
%final
%class Lexer
%function nextToken
%type Token
%unicode
%line
%column

%{
	/* These two methods are for the convenience of rules to create token objects.
	* If you do not want to use them, delete them
	* otherwise add the code in 
	*/
	
	private Token token(Token.Type type) {
		if(type==Token.Type.STRING_LITERAL){
			String tmp = yytext();
			return new Token(type, yyline, yycolumn, tmp.substring(1,tmp.length()-1));
		}
		else{
			return new Token(type, yyline, yycolumn, yytext());
		}
	}
	
	/* Use this method for rules where you need to process yytext() to get the lexeme of the token.
	 *
	 * Useful for string literals; e.g., the quotes around the literal are part of yytext(),
	 *       but they should not be part of the lexeme. 
	*/
	private Token token(Token.Type type, String text) {
		return new Token(type, yyline, yycolumn, text);
	}
%}

/* This definition may come in handy. If you wish, you can add more definitions here. */
WhiteSpace = [ ] | \t | \f | \n | \r
Identifier = [a-zA-Z][a-zA-Z0-9_]*
Int_Literal = [0-9]+
NonEmpty_String = \"([^\n\"]+)\"
Empty_String = \"\"


%%
/* put in your rules here.    */
/* keywords */
<YYINITIAL> "boolean" 		{return token(Token.Type.BOOLEAN);}
<YYINITIAL> "break" 		{return token(Token.Type.BREAK);}
<YYINITIAL> "else" 			{return token(Token.Type.ELSE);}
<YYINITIAL> "false" 		{return token(Token.Type.FALSE);}
<YYINITIAL> "if" 			{return token(Token.Type.IF);}
<YYINITIAL> "import" 		{return token(Token.Type.IMPORT);}
<YYINITIAL> "int" 			{return token(Token.Type.INT);}
<YYINITIAL> "module" 		{return token(Token.Type.MODULE);}
<YYINITIAL> "public" 		{return token(Token.Type.PUBLIC);}
<YYINITIAL> "return" 		{return token(Token.Type.RETURN);}
<YYINITIAL> "true" 			{return token(Token.Type.TRUE);}
<YYINITIAL> "type" 			{return token(Token.Type.TYPE);}
<YYINITIAL> "void" 			{return token(Token.Type.VOID);}
<YYINITIAL> "while" 		{return token(Token.Type.WHILE);}

/* punctuation */
<YYINITIAL> "," 			{return token(Token.Type.COMMA);}
<YYINITIAL> "[" 			{return token(Token.Type.LBRACKET);}
<YYINITIAL> "{" 			{return token(Token.Type.LCURLY);}
<YYINITIAL> "(" 			{return token(Token.Type.LPAREN);}
<YYINITIAL> "]" 			{return token(Token.Type.RBRACKET);}
<YYINITIAL> "}" 			{return token(Token.Type.RCURLY);}
<YYINITIAL> ")" 			{return token(Token.Type.RPAREN);}
<YYINITIAL> ";" 			{return token(Token.Type.SEMICOLON);}

/* operators */
<YYINITIAL> "/"				{return token(Token.Type.DIV);}
<YYINITIAL> "=="			{return token(Token.Type.EQEQ);}
<YYINITIAL> "="				{return token(Token.Type.EQL);}
<YYINITIAL> ">="			{return token(Token.Type.GEQ);}
<YYINITIAL> ">"				{return token(Token.Type.GT);}
<YYINITIAL> "<="			{return token(Token.Type.LEQ);}
<YYINITIAL> "<"				{return token(Token.Type.LT);}
<YYINITIAL> "-"				{return token(Token.Type.MINUS);}
<YYINITIAL> "!="			{return token(Token.Type.NEQ);}
<YYINITIAL> "+"				{return token(Token.Type.PLUS);}
<YYINITIAL> "*"				{return token(Token.Type.TIMES);}

/* identifier */
<YYINITIAL> {Identifier}	{return token(Token.Type.ID);}

/* integers */
<YYINITIAL> {Int_Literal}	{return token(Token.Type.INT_LITERAL);}

/* string */
<YYINITIAL> {NonEmpty_String}	{return token(Token.Type.STRING_LITERAL);}
<YYINITIAL> {Empty_String}		{return token(Token.Type.STRING_LITERAL, "");}

/* whitespace */
<YYINITIAL> {WhiteSpace}	{  /* ignore */ }

 

/* You don't need to change anything below this line. */
.							{ throw new Error("unexpected character '" + yytext() + "'"); }
<<EOF>>						{ return token(EOF); }