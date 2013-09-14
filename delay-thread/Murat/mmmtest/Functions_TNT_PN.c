/* 
   File:        Functions_TNT_PN.c
   Author:      Murat Bolat
   Description: Helper function which can be included into the client
                source codes supporting multithreading
*/

#include <stdio.h>
#include <stdlib.h>
#include <papi.h>
#include <pthread.h>

#define MBTHREADS 4

int MB_MainThread;
int MB_ThreadNum;
pthread_mutex_t MB_AccessLock;
int MBThreadID[MBTHREADS];
int MBEventSet[MBTHREADS];

long_long MBValue[MBTHREADS];

struct timeval MBTime[8];
long MBDifftime[MBTHREADS];
long MBExectime[MBTHREADS];

int MBInitLLVM (void)
{
  int i;
  FILE *PFile;
  system("rm -f test.mbo");
  MB_MainThread = (int) pthread_self();
  PAPI_library_init(PAPI_VER_CURRENT);
  PAPI_thread_init(pthread_self);
  for (i = 0; i < MBTHREADS; i++) {
    MBValue[i] = 0;
    MBThreadID[i] = 0;
    MBDifftime[i] = 0;
    MBExectime[i] = 0;
    PFile = fopen("TRPN.txt", "w");
    fclose(PFile);
  }
  MB_ThreadNum  = 0;
  pthread_mutex_init(&MB_AccessLock, NULL);
  return 0;
}

int MBStartThread (void)
{
  int ThreadID, Index;
  ThreadID = (int) pthread_self();
  Index = 0;
  if (ThreadID != MB_MainThread) {
    pthread_mutex_lock(&MB_AccessLock);
    Index = MB_ThreadNum % MBTHREADS;
    PAPI_register_thread();
    MBThreadID[Index] = ThreadID;
    MBEventSet[Index] = PAPI_NULL;
    MBExectime[Index] = 0;
    MBDifftime[Index] = 0;
    MBValue[Index] = 0;
    MB_ThreadNum++;
    pthread_mutex_unlock(&MB_AccessLock);
    PAPI_create_eventset(MBEventSet+Index);
    PAPI_add_event(MBEventSet[Index], PAPI_L2_TCM);
    PAPI_start(MBEventSet[Index]);
    Index++;
  }
  return Index;
}

int MBStopThread (int ThreadNum, struct timeval *CurTime)
{
  int ThreadID, Index;
  FILE *PFile;
  long ExeTime;
  long_long Value;
  ThreadID = (int) pthread_self();
  if (ThreadNum > 0) {
    Index = ThreadNum - 1;
    Value = 0;
    PAPI_stop(MBEventSet[Index], &Value);
    ExeTime =
      (CurTime->tv_sec  - (MBTime+ThreadNum)->tv_sec ) * 1000000 +
      (CurTime->tv_usec - (MBTime+ThreadNum)->tv_usec);
    MBThreadID[Index]  = 0;
    pthread_mutex_lock(&MB_AccessLock);
    PFile = fopen("TRPN.txt", "a");
    fprintf(PFile, "# %i %li %li\n", ThreadNum, ExeTime, Value);
    fclose(PFile);
    //printf("Thread: %i => Time: %li  PAPI_L2_TCM: %li\n",
    //   ThreadNum, ExeTime, Value);
    pthread_mutex_unlock(&MB_AccessLock);
    MBDifftime[Index] = 0;
    PAPI_unregister_thread();
  }
  return 0;
}
