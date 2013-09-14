#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <clapack.h>
#include <pthread.h>
#include <dthread.h>

#ifndef NTHREAD
#define NTHREAD 2
#endif

double frand() {
  return ((double) rand() / (RAND_MAX));
  return 8.88;
}

struct ThreadArgs {
  double *matrix;
  int matrix_size;
  int *pivot_index;
};


void *luKernel(void *arg) {
  struct ThreadArgs *argument = (struct ThreadArgs *) arg;
  double *matrix = argument->matrix;
  int matrix_size = argument->matrix_size;
  int *pivot_index = argument->pivot_index;
  int result;

  result = clapack_dgetrf(CblasRowMajor, matrix_size, matrix_size, matrix,
      matrix_size, pivot_index);

  return 0;
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
  int matrix_size;
  unsigned int seed = 123456789;
  double *matrix[nthread];
  double *padding[5*nthread];
  int *pivot_index[nthread];
  struct ThreadArgs argument[nthread];

  pthread_attr_t attr;
  pthread_t Thread[nthread];

  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  matrix_size = (argc == 2 ? atoi(argv[1]) : 2048);

  for (k = 0; k < nthread; k++) {
    // Allocate a new array on the heap, copy (clutching at straws here)
    padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    padding[p++] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    matrix[k] = (double*) malloc(sizeof(double) * matrix_size * matrix_size);
    srand(seed);

    for (i = 0; i < matrix_size; i++)
      for (j = 0; j < matrix_size; j++)
        matrix[k][i * matrix_size + j] = frand();

    // Resulting pivots
    pivot_index[k] = (int*) malloc(matrix_size * sizeof(int));

    argument[k].matrix = matrix[k];
    argument[k].matrix_size = matrix_size;
    argument[k].pivot_index = pivot_index[k];
  }

  // Do calculation
  for (k = 0; k < nthread; k++) {
    pthread_create(Thread + k, &attr, luKernel, &argument[k]);
#ifdef DELAYTIME
    usleep((unsigned)DELAYTIME*1000000);
#endif
  }

  for (k = 0; k < nthread; k++)
    pthread_join(Thread[k], (void **) &status);


  for (k = 0; k < nthread; k++) {
    free(matrix[k]);
    free(pivot_index[k]);
  }

  for (k = 0; k < p; k++) 
    free(padding[k]);

  return 0;
}


int main(int argc, char *argv[]) {
  test(argc, argv);

  return 0;
}

