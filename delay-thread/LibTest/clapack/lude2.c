#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <f2c.h>
#include <clapack.h>
#include <pthread.h>
#include <dthread.h>
#include <time.h>


inline double frand() {
  return ((double)rand()/(RAND_MAX));
}


struct ThrdArg {
  double *dMatrix;
  long MSIZE;
  long *nPivotIndices;
};


void *luKernel(void *Args) {
  struct ThrdArg *Argument = (struct ThrdArg *) Args;
  double *dMatrix = Argument->dMatrix;
  long MSIZE = Argument->MSIZE;
  long *nPivotIndices = Argument->nPivotIndices;
  int nResult;
  long *info = (long*)malloc(sizeof(long));

  nResult = dgetrf_(&MSIZE, &MSIZE, dMatrix, &MSIZE, nPivotIndices, info);

  free(info);
  return 0;
}

// Print a column major matrix
void printMatrix(double *dMatrix, int nRows, int nCols) {
   int row,col;
   for (row = 0; row < nRows; row++) {
      for (col = 0; col < nCols; col++)
         printf("%d: %f ", col * nRows + row, dMatrix[col * nRows + row]);
      printf("\n");
   }
}


int test(int argc, char **argv) {
  int i, j, k, status;
  int nthread = 2;
  long MSIZE;
  unsigned int seed = 123456789;
  double *dMatrix[nthread];
  long *nPivotIndices[nthread];
  struct ThrdArg Argument[nthread];

  #ifdef DELAY
  struct timespec CondTime;
  struct timeval  ContTv;
  pthread_mutex_t CondMutex = PTHREAD_MUTEX_INITIALIZER;
  pthread_cond_t  Condition = PTHREAD_COND_INITIALIZER;
  #endif

  pthread_attr_t attr;
  pthread_t Thread[nthread+1];
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  
  MSIZE = (argc == 2? atoi(argv[1]) : 2048);

  for ( k = 0; k < nthread; k++ ) {
   // Allocate a new array on the heap, copy (clutching at straws here)       
   dMatrix[k] = (double*)malloc(sizeof(double) * MSIZE * MSIZE);
   srand ( seed );

  for ( i = 0; i < MSIZE; i++ )
    for ( j = 0; j < MSIZE; j++ )
      dMatrix[k][i*MSIZE+j] = frand();
  

   // Resulting pivots
   nPivotIndices[k] = (long*)malloc(MSIZE * sizeof(long));
   
   Argument[k].dMatrix=dMatrix[k];
   Argument[k].MSIZE=MSIZE;
   Argument[k].nPivotIndices=nPivotIndices[k];
   }

#ifdef PAPITHREAD
   pthread_create(Thread+nthread, &attr, __dt_papi_kernel2, &nthread);   
#endif

   // Do calculation
   for ( k = 0; k < nthread; k++ ) { 
#ifdef DELAY
     if( k != 0) {
      pthread_mutex_lock(&CondMutex);
      pthread_cond_timedwait(&Condition,&CondMutex,&CondTime);
      pthread_mutex_unlock(&CondMutex);
     }
#endif
     pthread_create(Thread+k, &attr, luKernel, &Argument[k]);   
#ifdef DELAY
     clock_gettime(CLOCK_REALTIME,&CondTime);
     //unit of DELAYTIME is ms, milisecond
     CondTime.tv_nsec += DELAYTIME*1000000;
#endif
   }

   
   for(k = 0; k < nthread; k++) 
     pthread_join(Thread[k], (void **)&status);

#ifdef PAPITHREAD
   pthread_cancel(Thread[nthread]);
#endif
  
   // cleanup
#ifdef DELAY
   pthread_mutex_destroy(&CondMutex); 
   pthread_cond_destroy(&Condition);
#endif

   for(k = 0; k < nthread; k++) {
     free(dMatrix[k]);
     free(nPivotIndices[k]);
   }

   return 0;
}

int main(int argc, char *argv[])
{
  int MSIZE;
  char filename[50];
  
  MSIZE = (argc == 2? atoi(argv[1]):2048);
#if defined PAPITHREAD && defined DELAY
  sprintf(filename,"lude_%d_2.delay.txt", MSIZE);
  __dt_papi_setfilename(filename);
#endif

#if defined PAPITHREAD && !defined DELAY
  sprintf(filename,"lude_%d_2.txt", MSIZE);
  __dt_papi_setfilename(filename);
#endif
  
  __dt_papi_prolog();
  test(argc, argv);
  __dt_papi_epilog();

  return 0;
}

