#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <papi.h>


int test() {
  int i,j;
  int numInt;
  int numCachelineUsed;
  int *a;
  
  numInt = 2*1024*1024;
  //numInt = 1024*1024;
  numCachelineUsed = 8*1024*1024/64;
  //numCachelineUsed = 4*1024*1024/64;
  a = (int*) malloc(sizeof(int)*numInt);

  pthread_attr_t attr;
  pthread_t Thread;
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  pthread_create(&Thread, &attr, PapiKernel, NULL);
  
  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++) {
      //strcpy(__dt_pos.dirname, __dt_curdirname);
      //strcpy(__dt_pos.filename, __dt_curfilename);
      //__dt_pos.looplineno = 100;
      //__dt_pos.iter = 200;
      a[i*16+j]++;
    }

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

  pthread_cancel(Thread);

  return 0;
}
