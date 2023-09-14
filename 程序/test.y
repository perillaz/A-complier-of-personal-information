%{
#include <stdio.h>
#include <string.h>
/*#ifndef BTOD_H_INCLUDEN
#define BTOD_H_INCLUDED
typedef struct
{
	int count;
	char* val;
}myStruct;
#endif
#define YYSTYPE myStruct*/
int yylex(void);
int infos=0;
void yyerror(char *);
%}

/*%union{
	char * sval;
}*/
//%token<sval> Name
%debug
%token Info Name Id Unit Occupation Phone Time No Connect Colon Dot
%token IdNumber Tag PhoneNumber Date
%token IdNumber_ERROR PhoneNumber_ERROR
%%

info:
  | Info lines 
   {
    //$$.count=$2.count;
	if (infos==6)
	{
		printf("Pass Parser\n");
		printf("There are %d info.",infos);
	}
	else
	{
		printf("Pass Parser\n");
		printf("You may miss some blanks.");
	}	
	}
  ;
lines:
   | line lines 
	 {
		//$$.count=$1.count+$2.count;
	 } 
   ;
line:
    No Dot prompt Colon filling
	{
		printf("quaternary:(%s,%s,%s,%s)\n",$4,$3,$5,$1);
		infos=infos+1;
		//$$.count=1;
	}
  ;
filling:  
  | IdNumber {$$=$1;}
  | Tag {$$=$1;}
  | PhoneNumber {$$=$1;}
  | Date {$$=$1;}
  ;
prompt:
  | Name {$$=$1;}
  | Id  {$$=$1;}
  | Unit  {$$=$1;}
  | Occupation  {$$=$1;}
  | Phone  {$$=$1;}
  | Time  {$$=$1;}
  ;
%%
void yyerror(char *str){
	fprintf(stderr,"error :%s\n",str);
}
int yywrap(void){
	return 1;
}
int main(int argc, char* argv[])
{
	//extern FILE *yyout;
	//yyout=fopen("outLex.txt","w");
	//freopen("outSyntax.txt","w",stdout);
	//yydebug=1;
	yyparse();
	//fclose(yyout);
}