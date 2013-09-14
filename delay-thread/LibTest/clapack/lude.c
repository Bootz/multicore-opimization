#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <f2c.h>
#include <clapack.h>
#include <pthread.h>

#ifndef NTHREAD
#define NTHREAD 2
#endif

doublereal frand() {
  return ((doublereal) rand() / (RAND_MAX)*100);
  //return 8.888;
}

//doublereal frand(double min, double max) 
//{
    //double range = (max - min); 
    //double div = RAND_MAX / range;
    //return min + (rand() / div);
    //return 8.88;
//}

struct ThreadArgs {
  doublereal *matrix;
  integer matrix_size;
  integer *pivot_index;
};


void *luKernel(void *arg) {
  struct ThreadArgs *argument = (struct ThreadArgs *) arg;
  doublereal *matrix = argument->matrix;
  integer matrix_size = argument->matrix_size;
  integer *pivot_index = argument->pivot_index;
  integer info;
  int result;

  result = dgetrf_(&matrix_size, &matrix_size, matrix,
      &matrix_size, pivot_index, &info);
}


// Print a column major matrix
void printMatrix(double *matrix, int nRows, int nCols) {
  int row, col;
  for (row = 0; row < nRows; row++) {
    for (col = 0; col < nCols; col++)
      printf("%d: %f ", col * nRows + row, matrix[col * nRows + row]);
    printf("\n");
  }
}


int test(int argc, char **argv) {
  int i, j, k, status;
  int p = 0;
  int nthread = NTHREAD;
  integer matrix_size;
  unsigned int seed = 123456789;
  doublereal *matrix[nthread];
  //doublereal *padding[5*nthread];
  integer *pivot_index[nthread];
  struct ThreadArgs argument[nthread];

  pthread_attr_t attr;
  pthread_t Thread[nthread];

  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  matrix_size = (argc == 2 ? atoi(argv[1]) : 2048);

  for (k = 0; k < nthread; k++) {
    // Allocate a new array on the heap, copy (clutching at straws here)
    //padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    //padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    //padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    //padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    //padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    matrix[k] = (doublereal*) malloc(sizeof(doublereal) * matrix_size * matrix_size);
    //srand(seed);

    for (i = 0; i < matrix_size; i++)
      for (j = 0; j < matrix_size; j++)
        matrix[k][i * matrix_size + j] = frand(1,1000);

    // Resulting pivots
    pivot_index[k] = (integer*) malloc(matrix_size * sizeof(integer));

    argument[k].matrix = matrix[k];
    argument[k].matrix_size = matrix_size;
    argument[k].pivot_index = pivot_index[k];
  }

  // Do calculation
  for (k = 0; k < nthread; k++) {
    pthread_create(Thread + k, &attr, luKernel, &argument[k]);
#ifdef DELAYTIME
    usleep((unsigned)(DELAYTIME*1000000));
#endif
  }

  for (k = 0; k < nthread; k++)
    pthread_join(Thread[k], (void **) &status);


  for (k = 0; k < nthread; k++) {
    free(matrix[k]);
    free(pivot_index[k]);
  }


  return 0;
}


int main(int argc, char *argv[]) {
  test(argc, argv);

  return 0;
}

