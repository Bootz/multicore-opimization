/*
   File:        Functions_IPB.c
   Author:      Murat Bolat
   Description: Helper function which can be included into 
                the client source codes
*/

#include <stdio.h>

#ifdef EXETIME
#include <sys/time.h>
#else
#include <papi.h>
#endif

#ifdef EXETIME
struct timeval MB_Start, MB_End;
#else
int MB_EventSet;
#endif

int MBStartPAPI(void)
{
  system("rm -f *.mbo");
#ifdef EXETIME
  gettimeofday(&MB_Start, NULL);
#else
  MB_EventSet = PAPI_NULL;
  PAPI_library_init(PAPI_VER_CURRENT);
  PAPI_create_eventset(&MB_EventSet);
  PAPI_add_event(MB_EventSet, PAPI_TOT_CYC);
  PAPI_start(MB_EventSet);
#endif
  return 0;
}

int MBStopPAPI(void)
{
  FILE * printfile;
#ifdef EXETIME
  long long Value;
  gettimeofday(&MB_End, NULL);
  Value = (long long)
    (MB_End.tv_sec  - MB_Start.tv_sec )*1000000 +
    (MB_End.tv_usec - MB_Start.tv_usec);
#else
  long_long Value;
  Value = 0;
  PAPI_stop(MB_EventSet, &Value);
#endif
  printfile = fopen("benchmarkvalue.txt", "w");
  fprintf(printfile, "Benchmark Value: %lli\n", Value);
  fprintf(printfile, "C %lli\n", Value);
  fclose(printfile);
  return 0;
}
