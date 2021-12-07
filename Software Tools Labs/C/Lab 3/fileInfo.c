#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "dos2sd.h"
/**
* Sean O’Brien
* 213735741
* Thursday October 5th 2017
* fileInfo.c - This is my solution to part 1 of lab 3, the code
* uses the main pieces of listFiles.c to parse through test1.atr
* and then uses sscanf to retrieve the name of the file and then
* strcmp to verify that the file exists. The list of sectors is
* found using the count and start integers established in listFiles
* and the total file size is found using the same integers.
**/
static void fileInfo(FILE *fd, struct ATRSSDISK *disk, char *fileName)
{
int fileFound = 0;
char fName[32];
char fExt[32];
int sector, entry, i, count, start;
char name[9], ext[4];
baseFileNumber = 0;
for(sector=361;sector<=368;sector++) {
for(entry=0;entry<ATR_SECTOR_SIZE;entry+=16) {
if(disk->sector[sector-1][entry] == 0x042) {
for(i=0;i<8;i++)
name[i] = disk->sector[sector-1][entry+5+i];
name[8] = ’\0’;
for(i=0;i<3;i++)
ext[i] = disk->sector[sector-1][entry+13+i];
ext[3] = ’\0’;
count = disk->sector[sector-1][entry+1]|disk->sector[sector-1][entry+2]<<8;
start = disk->sector[sector-1][entry+3]|disk->sector[sector-1][entry+4]<<8;
sscanf(fileName, "%[^.].%s", fName, fExt);
if (!strcmp(name, fName) && !strcmp(ext, fExt)) {
fileFound = 1;
fprintf(fd, "%s.%s sector List", name, ext);
for (i = start; i < start + count; i++) {
fprintf(fd, " %d ", i);
}
fprintf(fd, "Total file size %d\n", count * 128);
}
}
}
}
if (!fileFound) {
printf("File is not in this disk.\n");
}
}
fileInfo.c 10/05/17 Page 2 of 2
int main(int argc, char *argv[])
{
struct ATRSSDISK *disk;
if(argc != 3) {
fprintf(stderr,"usage: %s disk\n", argv[0]);
exit(1);
}
if((disk = readDisk(argv[1])) == (struct ATRSSDISK *)NULL) {
fprintf(stderr,"Unable to read disk %s\n", argv[1]);
exit(1);
}
fileInfo(stdout, disk, argv[2]);
freeDisk(disk);
return 0;
}