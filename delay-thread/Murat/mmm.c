#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <emmintrin.h>

#ifdef TCOND
#include <unistd.h>
#endif


#ifdef FP
typedef float TYPE;
#elif DP
typedef double TYPE;
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
#elif DP
      fprintf(OutputFile, " %e", C[i*N+j]);
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


void *MatMulKernel (void *Args)
{
  int i, j, k;
  struct ThrdArg *Argument = (struct ThrdArg *) Args;
  TYPE *A=Argument->A;
  TYPE *B=Argument->B;
  TYPE *C=Argument->C;
  int T=Argument->T;
  int P=Argument->P;
  int N=Argument->N;
  printf("<=== Thread %i -> Before Matrix Multiplication ===>\n", T);
  for (i = 0; i < P; i++) {
#ifdef TCONDBAR
    if((!(i+1) % (P/4))) {
      pthread_barrier_wait(Argument->barr);
    }
#endif
    for (j = 0; j < N; j++)
      for (k = 0; k < N; k++) {
        C[i*N+j] += 
                     A[i*N+k]*
                     B[k*N+j];
      }
  }
  printf("<=== Thread %i -> After  Matrix Multiplication ===>\n", T);
  //pthread_exit(0);
}

// M is the total number of threads.
void MatMul (TYPE *A, TYPE *B, TYPE *C, int N, int M)
{
  int i, j, status;
  struct ThrdArg Argument[M];
  pthread_attr_t attr;
#ifdef BASE
  pthread_t Thread;
#else
  pthread_t Thread[M+1];
#endif

#ifdef TCOND
  struct timespec CondTime;
  struct timeval  ContTv;
  pthread_cond_t  Condition;
  pthread_mutex_t CondMutex;
#endif

#ifdef TCONDBAR
  pthread_barrier_t barrier1; 
  pthread_barrierattr_t barrattr;
  pthread_barrier_init(&barrier1, &barrattr, M);
#endif

  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

for(i = 0; i < M; i++) {
    (Argument+i)->A = A+i*N*N/M;
    (Argument+i)->B = B;
    (Argument+i)->C = C+i*N*N/M;
    (Argument+i)->T = i;
    (Argument+i)->P = N/M;
    (Argument+i)->N = N;
#ifdef TCONDBAR
    (Argument+i)->barr = &barrier1;
#endif
}

#ifdef SEQ
for(i = 0; i < M; i++) {
  pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
  pthread_join(Thread[i], (void **)&status);
}
#elif TCOND
  pthread_mutex_init(&CondMutex, NULL);
  pthread_cond_init (&Condition, NULL);
  for(i = 0; i < M; i++) {
  	if(i != 0) {
      pthread_mutex_lock(&CondMutex);
      pthread_cond_timedwait(&Condition,&CondMutex,&CondTime);
      pthread_mutex_unlock(&CondMutex);
	  }
    pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
    clock_gettime(CLOCK_REALTIME,&CondTime);
    CondTime.tv_nsec += TIME*1000;
  }

  for(i = 0; i < M; i++)
    pthread_join(Thread[i], (void **)&status);
#elif BASE
  MatMulKernel((void *)Argument);
#else
  for(i = 0; i < M; i++)
    pthread_create(Thread+i, &attr, MatMulKernel, (void*) (Argument+i));
  
  for(i = 0; i < M; i++)
    pthread_join(Thread[i], (void **)&status);
#endif

}

int main (int argc, char *argv[])
{
  int i, j, k, N, M;
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
//  Print(A,N,"mmmthra.txt");
//  Print(B,N,"mmmthrb.txt");
//  Print(C,N,"mmmthrc.txt");

  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++) {
      _mm_clflush((const void *)(A+i*N+j));
      _mm_clflush((const void *)(B+i*N+j));
      _mm_clflush((const void *)(C+i*N+j));
    }

  free(A);
  free(B);
  free(C);

  return 0;
}
