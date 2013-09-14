#include <stdio.h>
#include <stdlib.h>

#ifdef TCOND
#include <unistd.h>
#endif

#include <pthread.h>

#ifdef FP
typedef float TYPE;
#else
typedef int TYPE;
#endif

void Print(TYPE *C, int N, char *Name)
{
  int i, j;
  FILE *OutputFile;
  OutputFile = fopen(Name, "w");
  fprintf(OutputFile, "Matrix C:\n");
  for (i = 0; i < N; i++) {
    fprintf(OutputFile, "     ");
    for (j = 0; j < N; j++) {
#ifdef FP
      fprintf(OutputFile, " %f", C[i*N+j]);
#else
      fprintf(OutputFile, " %i", C[i*N+j]);
#endif
    }
    fprintf(OutputFile, "\n");
  }
}

struct ThrdArg
{
  TYPE *A; // First  Matrix
  TYPE *B; // Second Matrix
  TYPE *C; // Result Matrix
  int T;   // Thread Number
  int P;   // Part
  int N;   // Size
#ifdef TCONDBAR
  pthread_barrier_t *barr;
#endif
};

void * MatMulKernel (void *Args)
{
  int i, j, k;
  struct ThrdArg *Argument;
  Argument = (struct ThrdArg *) Args;
  printf("<=== Thread %i -> Before Matrix Multiplication ===>\n",
    Argument->T);
  for (i = 0; i < (Argument->P); i++) {
#ifdef TCONDBAR
    if( (!(i+1) % (Argument->P / 4))) {
      pthread_barrier_wait(Argument->barr);
    }
#endif
    for (j = 0; j < (Argument->P); j++)
      for (k = 0; k < (Argument->N); k++)
        Argument->C[i*(Argument->N)+j] +=
	 				 Argument->A[i*(Argument->N)+k] *
	  			 Argument->B[k*(Argument->N)+j] ;
  }
  printf("<=== Thread %i -> After  Matrix Multiplication ===>\n",
		Argument->T);
  pthread_exit(0);
}

// M^2 is the total number of threads.
void MatMul (TYPE *A, TYPE *B, TYPE *C, int N, int M)
{
  int i, j, status;
	int Step = N/M;
  struct ThrdArg Argument[M*M];
  pthread_t Thread[M*M];
  pthread_attr_t attr;

#ifdef TCOND
  struct timespec CondTime;
  struct timeval  ContTv;
  pthread_cond_t  Condition;
  pthread_mutex_t CondMutex;
#endif

#ifdef TCONDBAR
  pthread_barrier_t barrier1; 
  pthread_barrierattr_t barrattr;
  pthread_barrier_init(&barrier1, &barrattr, M*M);
#endif

  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

for(i = 0; i < M; i++) {
  for(j = 0; j < M; j++) {
    (Argument+i+j*M)->A = A+Step*N*j;
    (Argument+i+j*M)->B = B+Step*i;
    (Argument+i+j*M)->C = C+Step*i+Step*N*j;
    (Argument+i+j*M)->T = i+j*M;
    (Argument+i+j*M)->P = Step;
    (Argument+i+j*M)->N = N;
#ifdef TCONDBAR
    (Argument+i+j*M)->barr = &barrier1;
#endif
  }
}

#ifdef SEQ
for(i = 0; i < M*M; i++) {
  pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
  pthread_join(Thread[i], (void **)&status);
}
#elif TCOND
  pthread_mutex_init(&CondMutex, NULL);
  pthread_cond_init (&Condition, NULL);
  for(i = 0; i < M*M; i++) {
  	if(i != 0) {
      pthread_mutex_lock(&CondMutex);
      pthread_cond_timedwait(&Condition,&CondMutex,&CondTime);
      pthread_mutex_unlock(&CondMutex);
	  }
    pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
    clock_gettime(CLOCK_REALTIME,&CondTime);
    CondTime.tv_nsec += TIME*1000;
  }

  for(i = 0; i < M*M; i++)
    pthread_join(Thread[i], (void **)&status);
#elif BASE
  MatMulKernel((void *)Argument);
#else
  for(i = 0; i < M*M; i++)
    pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
  
  for(i = 0; i < M*M; i++)
    pthread_join(Thread[i], (void **)&status);
#endif

}

int main (int argc, char *argv[])
{
  int i, j, N, M;
  TYPE *A, *B, *C;
  if (argc == 3){
    N = atoi(argv[1]);
    M = atoi(argv[2]);
	} else {
    N = 512;
    M = 2;
	}
  A = (TYPE *) calloc(N*N,sizeof(TYPE));
  B = (TYPE *) calloc(N*N,sizeof(TYPE));
  C = (TYPE *) calloc(N*N,sizeof(TYPE));
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++) {
      A[i*N+j] = (TYPE) rand();
      B[i*N+j] = (TYPE) rand();
    }
  MatMul(A,B,C,N,M);
  Print(C,N,"mmmthr.txt");

  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++) {
      __builtin_ia32_clflush((const void *)(A+i*N+j));
      __builtin_ia32_clflush((const void *)(B+i*N+j));
      __builtin_ia32_clflush((const void *)(C+i*N+j));
    }

  free(A);
  free(B);
  free(C);
  return 0;
}
