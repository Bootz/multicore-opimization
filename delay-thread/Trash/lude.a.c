#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <f2c.h>
#include <clapack.h>
#include <unistd.h>
#include <dthread.h>
#include <pthread.h>
#include <papi.h>
#include <sys/timerfd.h>

//typedef struct {
 // pthread_t tid[8];
  //long nthread;
//} __dt_tidinfo;

//__dt_tidinfo __dt_atidinfo;

double frand(void) {
	double value;

	value = ((double) rand() / (RAND_MAX));

	return value;
}


// Print a column major matrix
void printMatrix(double *dMatrix, int nRows, int nCols) {
	int row, col;
	for (row = 0; row < nRows; row++) {
		for (col = 0; col < nCols; col++)
			printf("%d: %f ", col * nRows + row, dMatrix[col * nRows + row]);
		printf("\n");
	}
}


int test(int argc, char **argv) {
	long int i, j, MSIZE;
	double *dMatrix;
	long int *nPivotIndices;
	long int *info;
	int nResult;
	unsigned int seed = 123456789;
  int nthread = 0;

	pthread_attr_t attr;
	pthread_t Thread;

	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

	//  if (argc == 2){
	//   MSIZE = atoi(argv[1]);
	//} else {
	// MSIZE = 2048;
	//}
	MSIZE = (argc == 2 ? atoi(argv[1]) : 2048);

	// Allocate a new array on the heap, copy (clutching at straws here)
	dMatrix = (double*) malloc(sizeof(double) * MSIZE * MSIZE);
	srand(seed);

	for (i = 0; i < MSIZE; i++) {
		for (j = 0; j < MSIZE; j++) {
			dMatrix[i * MSIZE + j] = frand();
		}
	}

	// Resulting pivots
	nPivotIndices = (long int*) malloc(MSIZE * sizeof(long int));
	info = (long int*) malloc(sizeof(long int));

	// Check matrix
	//printMatrix(dMatrix, 4, 4);

	// Do calculation
  nthread = 1;
	pthread_create(&Thread, &attr, __dt_papi_kernel2, &nthread);
  //pthread_t aaa = pthread_self();
  //__dt_setpid(&aaa);
  //__dt_atidinfo.tid[__dt_atidinfo.nthread++] = Thread;
	nResult = dgetrf_(&MSIZE, &MSIZE, dMatrix, &MSIZE, nPivotIndices, info);
	pthread_cancel(Thread);
	//printf("Result: %d\n", nResult);

	// Print result matrix
	//printMatrix(dMatrix, 4, 4);

	// Print permutation vector
	//for (i = 0; i < MSIZE; i++)
	//  printf("%d: %d\n", i, nPivotIndices[i]);
	free(dMatrix);
	free(nPivotIndices);
	free(info);
	return 0;
}

int main(int argc, char *argv[]) {
	char filename[50];

	/* create output file in gnuplot format */

	int MSIZE = (argc == 2 ? atoi(argv[1]) : 2048);
	sprintf(filename, "ludecomp_%d_1thread.txt", MSIZE);
  __dt_papi_prolog(filename);

	test(argc, argv);

  __dt_papi_epilog();


	return 0;
}
