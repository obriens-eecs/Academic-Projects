#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexical.h"
#include "nextInputChar.h"
#include "tokenStack.h"
/* Sean O’Brien, 213735741, Monday November 6th 2017
* I have gotten the code to produce the correct answers, but only under specific condit
ions
* I’m not sure why but sometimes my code produces letters instead of integer answers, h
owever
* the letters correspond to the correct integers, (i.e a=1, b=2,...)
* 0 2 + 1 - print produces 1
* 2 2 + 3 - print produces 1
* 2 2 + 2 + 3 - print produces e (aka 5)
*/
static int popInt(struct tokenStack *s)
{
if(s->top <= 0) {
fprintf(stderr,"popInt: popping an empty stack, aborting\n");
exit(1);
}
struct lexToken *tToken;
tToken = popTokenStack(s);
return (tToken->symbol[0] - 0);
}
static void pushInt(struct tokenStack *s, int v)
{
struct lexToken *nToken;
nToken = allocToken();
nToken->kind = LEX_TOKEN_NUMBER;
nToken->symbol[0] = v;
pushTokenStack(s, nToken);
}
static void doOperator(struct tokenStack *s, char *op)
{
if(!strcmp(op,"quit")) {
exit(0);
} else if(!strcmp(op,"print")) {
struct lexToken *t = popTokenStack(s);
dumpToken(stdout, t);
freeToken(t);
} else {
fprintf(stderr,"don’t know |%s|\n", op);
exit(1);
}
}
int main(int argc, char *argv[])
{
setFile(stdin);
int i, j, k, l;
struct tokenStack *tStack;
tStack = createTokenStack();
while(1) {
struct lexToken *nToken;
rpnCalc.c 11/06/17 Page 2 of 2
nToken = nextToken();
switch(nToken->kind) {
case LEX_TOKEN_EOF:
break;
case LEX_TOKEN_IDENTIFIER:
doOperator(tStack, &(nToken->symbol[0]));
break;
case LEX_TOKEN_NUMBER:
pushTokenStack(tStack, nToken);
break;
case LEX_TOKEN_OPERATOR:
switch(nToken->symbol[0]) {
case ’+’:
j = popInt(tStack);
k = popInt(tStack);
l = j + k;
pushInt(tStack, l);
break;
case ’*’:
j = popInt(tStack);
k = popInt(tStack);
l = j * k;
pushInt(tStack, l);
break;
case ’-’:
j = popInt(tStack) - 0;
k = popInt(tStack) - 0;
l = (k - j);
pushInt(tStack, l);
break;
case ’/’:
j = popInt(tStack) - 0;
k = popInt(tStack) - 0;
l = (k / j);
pushInt(tStack, l);
break;
}
}
}
return 0;
}