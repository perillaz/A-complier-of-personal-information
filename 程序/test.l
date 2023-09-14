%{
#include <stdio.h>
#include <string.h>
#include "test.tab.h"
void yyerror(char*);
int mean_province=1;
int mean_year=0;
int mean_day=0;
int mean_order=0;
int mean_gen=0;
int mean_last=0;
%}
/*记录符号所在行号*/
%option yylineno
/*定义正则表达式*/
letter [A-Za-z]
digit [0-9]
No [1-9]
Info Info
Name Name
Id Id
Unit Unit
Occupation Occupation
Phone Phone
Time Time
Dot \.
Colon \:
Tag {letter}+
IdNumber ({digit}{17})({digit}|[X])
PhoneNumber {digit}{11}
Date ({digit}{4})("-")({digit}{2})("-")({digit}{2})

/*词法分析出错*/
IdNumber_ERROR [0-9]*[a-zA-Z]+[0-9]*|{digit}{0,16}({digit}|[X])|{digit}{17}({digit}|[X])[0-9]+
PhoneNumber_ERROR [0-9]*[a-zA-Z]+[0-9]*|{digit}{0,10}|{digit}{11}[0-9]+

/*空白符*/
SPACE [ \f\r\t\v]+
/*换行*/
EOL \n

%%
{SPACE} {}
{EOL} {}

{No} {
	fprintf(yyout,"(%d,%s)", No,yytext);
	yylval=strdup(yytext);
	return No;}
{Info} {
	fprintf(yyout,"(%d,%s)\n", Info,yytext);
	yylval=strdup(yytext);
	return Info;}
{Name} {
	fprintf(yyout,"(%d,%s)", Name,yytext);
	yylval=strdup(yytext);
	//printf("Name : %s\n",yytext);
	return Name;}
{Id} {
	fprintf(yyout,"(%d,%s)", Id,yytext);
	yylval=strdup(yytext);
	return Id;}
{Unit} {
	fprintf(yyout,"(%d,%s)", Unit,yytext);
	yylval=strdup(yytext);
	return Unit;}
{Occupation} {
	fprintf(yyout,"(%d,%s)", Occupation,yytext);
	yylval=strdup(yytext);
	return Occupation;}
{Phone} {
	fprintf(yyout,"(%d,%s)", Phone,yytext);
	yylval=strdup(yytext);
	return Phone;}
{Time} {
	fprintf(yyout,"(%d,%s)", Time,yytext);
	yylval=strdup(yytext);
	return Time;}

{Dot} {
	fprintf(yyout,"(%d,%s)", Dot,yytext);
	yylval=strdup(yytext);
	return Dot;}
{Colon} {
	fprintf(yyout,"(%d,%s)", Colon,yytext);
	yylval=strdup(yytext);
	return Colon;}

{Tag} {
	fprintf(yyout,"(%d,%s)\n", Tag,yytext);
	yylval=strdup(yytext);
	return Tag;}
{PhoneNumber} {
	fprintf(yyout,"(%d,%s)\n", PhoneNumber,yytext);
	yylval=strdup(yytext);
	return PhoneNumber;}
{Date} {
	fprintf(yyout,"(%d,%s)\n", Date,yytext);
	yylval=strdup(yytext);
	return Date;}
{IdNumber} {
	fprintf(yyout,"(%d,%s)\n", IdNumber,yytext);
	yylval=strdup(yytext);
	return IdNumber;}

{IdNumber_ERROR} {printf("IdNumber_ERROR at line %d: \"%s\"\n",yylineno,yytext);
return IdNumber_ERROR;}
{PhoneNumber_ERROR} {printf("PhoneNumber_ERROR at line %d: \"%s\"\n",yylineno,yytext);
return PhoneNumber_ERROR;}


%%


