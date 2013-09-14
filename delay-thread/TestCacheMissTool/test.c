#include<stdlib.h>

int main() {
  int i,j;
  int numInt;
  int numCachelineUsed;
  int *a;
  
  numInt = 2*1024*1024;
  //numInt = 1024*1024;
  numCachelineUsed = 8*1024*1024/64;
  //numCachelineUsed = 4*1024*1024/64;
  a = (int*) malloc(sizeof(int)*numInt);

  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++)
       a[i*16+j]++;

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++)
       a[i*16+j]++;

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++)
       a[i*16+j]++;

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  return 0;
}
