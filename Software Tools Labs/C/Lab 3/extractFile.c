#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <strings.h>
#include "dos2sd.h"
/**
**/
static void dumpSector(FILE *fd, struct ATRSSDISK *disk, int id) {
int i, j;
for(j = 0; j < ATR_SECTOR_SIZE; j += 32) {
for(i = 0; i < 32; i++)
fprintf(fd, "%c", disk -> sector[id][i + j]);
}
}
static void extractFile(FILE *fd, struct ATRSSDISK *disk, char *fileName) {
int sector, entry, i, count, start, baseFileNumber, fileIsFound = 0;
char name[9], fName[9], ext[4], fExt[4];
baseFileNumber = 0;
for(sector = 361; sector <= 368; sector++) {
for(entry = 0; entry < ATR_SECTOR_SIZE; entry += 16) {
if(disk->sector[sector - 1][entry] == 0x042) {
for(i = 0; i < 8; i++)
name[i] = disk->sector[sector - 1][entry + 5 + i];
name[8] = ’\0’;
for(i = 0; i < 3; i++)
ext[i] = disk->sector[sector - 1][entry + 13 + i];
ext[3] = ’\0’;
count = disk->sector[sector - 1][entry + 1] | disk->sector[sector - 1][
entry + 2] << 8;
start = disk->sector[sector - 1][entry + 3] | disk->sector[sector - 1][
entry + 4] << 8;
/*fprintf(fd,"File entry %d %s.%s sector count %d start %d\n", baseFile
Number, name, ext, count, start);*/
sscanf(fileName, "%[^.].%s", fName, fExt);
if (!strcmp(name, fName) && !strcmp(ext, fExt)) {
fileIsFound = 1;
for (i = start - 1; i < start + count - 1; i++) {
/* fprintf(fd, " %d ", i); */
dumpSector(fd, disk, i);
}
}
}
baseFileNumber++;
}
}
extractFile.c 10/05/17 Page 2 of 2
if (!fileIsFound)
printf("File is not in this disk.\n");
}
int main(int argc, char *argv[])
{
struct ATRSSDISK *disk;
FILE *fpIn;
fpIn = fopen("SAMPLEOUTPUT.txt", "w");
if(argc != 3) {
fprintf(stderr,"usage: %s disk.atr filename\n", argv[0]);
exit(1);
}
if((disk = readDisk(argv[1])) == (struct ATRSSDISK *) NULL) {
fprintf(stderr,"Unable to read disk %s\n", argv[1]);
exit(1);
}
extractFile(fpIn, disk, argv[2]);
freeDisk(disk);
return 0;
}