#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <clapack.h>
#include <pthread.h>
#include <dthread.h>

//typedef struct {
//  pthread_t tid[8];
//  int nthread;
//} __dt_tidinfo;
//
//__dt_tidinfo __dt_atidinfo;


double frand ( void ) {
  double value;

  value = ((double)rand()/(RAND_MAX));

  return value;
}


// Print a column major matrix
void printMatrix(double *dMatrix, int nRows, int nCols) {
   int row,col;
   for (row = 0; row < nRows; row++)
   {
      for (col = 0; col < nCols; col++)
         printf("%d: %f ", col * nRows + row, dMatrix[col * nRows + row]);
      printf("\n");
   }
}


int test(int argc, char **argv) {
  int i, j, MSIZE;
  double *dMatrix;
  int *nPivotIndices;
  int nResult;
  unsigned int seed = 123456789;

  pthread_attr_t attr;
  pthread_t Thread;
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  MSIZE = (argc == 2? atoi(argv[1]):2048);

  // Allocate a new array on the heap, copy (clutching at straws here)       
  dMatrix = (double*)malloc(sizeof(double) * MSIZE * MSIZE);
  srand(seed);

  for ( i = 0; i < MSIZE; i++ )
    for ( j = 0; j < MSIZE; j++ )
      dMatrix[i*MSIZE+j] = frand ();

   // Resulting pivots
   nPivotIndices = (int*)malloc(MSIZE * sizeof(int));
   
   // Do calculation
   pthread_create(&Thread, &attr, __dt_papi_kernel, NULL);   
   //__dt_atidinfo.tid[__dt_atidinfo.nthread++] = *Thread;
   nResult = clapack_dgetrf(CblasRowMajor, MSIZE, MSIZE, dMatrix, MSIZE, nPivotIndices);
   pthread_cancel(Thread);

   return 0;
}

int main (int argc, char *argv[])
{
  char filename[50];
  int MSIZE = (argc == 2? atoi(argv[1]):2048);
  sprintf(filename,"ludecomp_%d_1thread.txt", MSIZE);
  
  __dt_papi_prolog(filename);
  
  test(argc, argv);
  
  __dt_papi_epilog();

  return 0;
}
