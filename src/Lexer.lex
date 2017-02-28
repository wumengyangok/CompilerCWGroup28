import java_cup.runtime.*;
import java.lang.*;
import java.util.regex.Pattern;
import java.util.*;

%%

%class Lexer
%unicode
%cup
%line
%column

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
  }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
  }

%}

/* Begin working on Macro Statement */

/* some basic regex */
EndOfLine = \r\n|\n|\r
ValidChar = [^\r\n]
Letter = [a-zA-Z]
Digit = [0-9]
IdChar = {Letter} | {Digit} | "_"
WhiteSpace = \r|\n|\r\n|" "|"\t"

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
EndOfLineComment = "#"{ValidChar}*{EndOfLine}?
TraditionalComment = "/#" [^#]* "#/" | "/#" [#]+ "/"

/* identifier */
Identifier = {Letter}{IdChar}*

/* character */
Character = [A-Za-z0-9!\"#$%&\'()*+,\-./:;<=>?@\[\\\]\^_`{|}~]


/* numbers */
Integer = 0|[1-9]{Digit}*
Rational = ({Integer}_)?{Integer}\/{Integer}
Float = {Integer}\.{Digit}+


%state STRING
%state CHAR


%%

<YYINITIAL> {
	/* string */
\" {string.setLength(0); yybegin(STRING);}
\' {yybegin(CHAR);}

		/* data type */
"char" {return symbol(sym.CHARACTER);}
"bool" {return symbol(sym.BOOLEAN);}
"int"  {return symbol(sym.INTEGER);}
"rat"  {return symbol(sym.RATIONAL);}
"float" {return symbol(sym.FLOAT);}
"top"   {return symbol(sym.TOP);}
"string" {return symbol(sym.STRING);}
"dict" {return symbol(sym.DICTIONARY);}
"seq"  {return symbol(sym.SEQUENCE);}
	
		/* declaration */
"tdef" {return symbol(sym.TYPEDEF);}
"fdef" {return symbol(sym.FUNCTIONDEF);}
"alias" {return symbol(sym.ALIAS);}
"null" {return symbol(sym.NULL);}

		/* statement */
"if"    {return symbol(sym.IF);}
"fi"    {return symbol(sym.ENDIF);}
"else"  {return symbol(sym.ELSE);}
"then"  {return symbol(sym.THEN);}
"read"  {return symbol(sym.READ);}
"print" {return symbol(sym.PRINT);}
"in"    {return symbol(sym.IN);}
"main"  {return symbol(sym.MAIN);}
"len"	{return symbol(sym.LENGTH);}
"return" {return symbol(sym.RETURN);}
"loop" {return symbol(sym.LOOP);}
"break" {return symbol(sym.BREAK);}
"pool" {return symbol(sym.POOL);}

/* boolean */
"T" {return symbol(sym.BOOLEAN_LITERAL_TRUE);}
"F" {return symbol(sym.BOOLEAN_LITERAL_FALSE);}

	/* punctuation */
"(" {return symbol(sym.LPAREN);}
")" {return symbol(sym.RPAREN);}
"{" {return symbol(sym.LBRACE);}
"}" {return symbol(sym.RBRACE);}
"[" {return symbol(sym.LBRACK);}
"]" {return symbol(sym.RBRACK);}
";" {return symbol(sym.SEMICOLON);}
"," {return symbol(sym.COMMA);}
"." {return symbol(sym.DOT);}
":" {return symbol(sym.COLON);}

	/* operator */
"=>" {return symbol(sym.IMPLICATION);}
"+"  {return symbol(sym.PLUS);}
"-"  {return symbol(sym.MINUS);}
"*"  {return symbol(sym.TIMES);}
"/"  {return symbol(sym.DIVIDE);}
"^"  {return symbol(sym.POWER);}
"=" {return symbol(sym.EQEQ);}
":="  {return symbol(sym.ASSIGN);}
"!=" {return symbol(sym.NOTEQ);}
"<"  {return symbol(sym.LESS);}
"<=" {return symbol(sym.LESSEQ);}
">"	 {return symbol(sym.RANGLEBRACKT);}
"&&" {return symbol(sym.ANDAND);}
"||" {return symbol(sym.OROR);}
"!"  {return symbol(sym.NOT);}
"::" {return symbol(sym.CONCATENATE);}
"?" {return symbol(sym.QUESTIONMARK);}


	/* comment */
{Comment} { /* ignore */ }
	/* whitespace */
{WhiteSpace} { /* ignore */ }


	/* identifier */
{Identifier} {return symbol(sym.IDENTIFIER);}

	/* number */
{Integer}    {return symbol(sym.INTEGER_LITERAL);}
{Rational}   {return symbol(sym.RATIONAL_LITERAL);} 
{Float}      {return symbol(sym.FLOAT_LITERAL);}



}

<STRING> {
\"   			{yybegin(YYINITIAL); 
					return symbol(sym.STRING_LITERAL);}
	
[^\n\r\"\\]+ 	{string.append(yytext());}
\\t			{string.append('\t');}
\\n			{string.append('\n');}
\\r			{string.append('\r');}
\\\"        {string.append('\"');}
\\          {string.append('\\');}
}

<CHAR> {
  \'  {yybegin(YYINITIAL);}
  {Character} {return symbol(sym.CHARACTER_LITERAL);}
}


[^]  {
  System.out.println("file:" + (yyline+1) +
    ":0: Error: Invalid input '" + yytext()+"'");
  throw new Error("Illegal character <"+yytext()+">");
}


