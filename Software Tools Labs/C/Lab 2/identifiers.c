identifiers.c 09/21/17 Page 1 of 1
# include <stdio.h>
# include "identifiers.h"
/**
Sean O’Brien
213735741
Thursday September 21st 2017
* identifiers.c - This is my solution to the second lab of eecs2031, here are the chan
ges i made to each function
q1 - I casted 5 and 9 into doubles so that integer division doesn’t reduce 5/9
to 0.
q2 - The equation for converting celsius to fahrenheit is 32 plus c*1.8, not 32
times c*1.8 as was given.
q3 - This function properly rearranged the elements, however it goes too far an
d puts all the elements back in their
original positions, so I changed the condition of the for loop so that it itera
tes the correct number of times.
q4 - This function was missing brackets and executing incorrectly, I added the
needed ones and it worked.
**/
/* Q1.convert a temperature in F to it in C */
float fahrenheit2celsius(const float f) {
return (double)5 / (double)9 * (f-32);
}
/* Q2. convert a temperature in C to F */
float celsius2fahrenheit(const float c) {
return 32 + (c * 1.8);
}
/* Q3. reverse the elements in an array of int’s in place */
void reverse_elements(int vals[], int count){
int i;
for(i=0;i<count-i;i++) {
int t = vals[i];
vals[i] = vals[count-1-i];
vals[count-1-i] = t;
}
}
/* Q4. Count the number of ’*’ in the string given */
int count_stars(const char *s)
{
int count;
for(count = 0;*s;s++){
if(*s == ’*’){
count++;
}
}
return count;
}