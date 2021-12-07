/**
Sean O’Brien
213735741
Wednesday September 13th 2017
* parsedate.c - This is my solution to the first lab of eecs2031, I used sscanf to
read from the string and store the year, month, and day, then each of the different
functions returns the requested one.
**/
# include <stdio.h>
# include "parsedate.h"
int year, month, day;
int parse_year(const char *buf)
{
sscanf(buf, "%d/%d/%d", &year, &month, &day);
return year;
}
int parse_month(const char *buf)
{
sscanf(buf, "%d/%d/%d", &year, &month, &day);
return month;
}
int parse_day(const char *buf)
{
sscanf(buf, "%d/%d/%d", &year, &month, &day);
return day;
}