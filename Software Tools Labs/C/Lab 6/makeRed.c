#include <stdio.h>
#include <stdlib.h>
#include "ppmtools.h"
#define MAXIMAGE 512*512*3
unsigned char im[MAXIMAGE], out[MAXIMAGE];
int main(int argc, char *argv[])
{
int i, j, width, height;
if(argc != 3) {
fprintf(stderr, "Usage %s in.ppm out.ppm\n", argv[0]);
exit(1);
}
if(readppm(argv[1], im, &width, &height) < 0) {
fprintf(stderr,"%s: read of %s failed\n", argv[0], argv[1]);
exit(1);
}
for(i=0;i<height;i++) {
for(j=0;j<width;j++) {
unsigned char r, g, b;
r = im[i*(3*width)+j*3 + 0];
g = im[i*(3*width)+j*3 + 1];
b = im[i*(3*width)+j*3 + 2];
out[i*(3*width)+j*3 + 0] = r;
out[i*(3*width)+j*3 + 1] = 0;
out[i*(3*width)+j*3 + 2] = 0;
}
}
if(writeppm(argv[2], out, width, height) < 0) {
fprintf(stderr,"%s: write of %s failed\n", argv[0], argv[2]);
exit(1);
}
return 0;
}