// File: thrdstatseq.c
// Author: Murat Bolat

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define RUNS 3
#define NUMTHREADS 4
#define DIVISION 5

long MinValue;
long WaitTime[4];
long PerfVals[4];
long RunsTime[4];
long Resulting[3];

void RunBaseline (void)
{
  char c;
  int i, thrd;
  long Time;
  FILE *RunFile, *DebugFile;
  MinValue = LONG_MAX;
  for (i = 0; i < NUMTHREADS; i++) {
    WaitTime[i] = 0;
    PerfVals[i] = 0;
    RunsTime[i] = LONG_MAX;
  }
  system("./compiletnt.sh 0 0 0");
  for (i = 0; i < RUNS; i++) {
    system("./runtnt.sh thd PN");
    RunFile = fopen("TRPN.txt", "r");
    while ((c=fgetc(RunFile)) != EOF)
      if (c == '#') {
	fscanf(RunFile, "%i %li", &thrd, &Time);
	if (Time < RunsTime[thrd-1])
	  RunsTime[thrd-1] = Time;
      }
    fclose(RunFile);
  }
  DebugFile = fopen("WaitingStatistic.txt", "w");
  fprintf(DebugFile, "Timing -> T1=%li | T2=%li | T3=%li | T4=%li\n",
	  RunsTime[0], RunsTime[1], RunsTime[2], RunsTime[3]);
  fclose(DebugFile);
}

long RunProcessFile (void)
{
  char c;
  int i;
  long Value, SumValue;
  FILE *RunFile;
  SumValue = 0;
  for (i = 0; i < RUNS; i++) {
    system("./runtnt.sh cnd PN");
    RunFile = fopen("TRPN.txt", "r");
    while ((c=fgetc(RunFile)) != EOF)
      if (c == '#') {
	fscanf(RunFile, "%*i %*i %li", &Value);
	SumValue += Value;
      }
    fclose(RunFile);
  }
  SumValue /= RUNS;
  return SumValue;
}

long GetValue (void)
{
  FILE * RslFile;
  long Value;
  Value = 0;
  RslFile = fopen("benchmarkvalue.txt", "r");
  if (RslFile != NULL)
    while (((char)fgetc(RslFile)) != 'C')
      fscanf(RslFile, "%li", &Value);
  return Value;
}

void RunTimeResults (void)
{
  int i;
  long Value;
  char Name[64];

  Value = 0;
  for (i = 0; i < RUNS; i++) {
    system("./runbnc.sh seq");
    Value += GetValue();
  }
  Resulting[0] = Value / RUNS;
  printf("-----------------------------------\n");

  Value = 0;
  for (i = 0; i < RUNS; i++) {
    system("./runbnc.sh thd");
    Value += GetValue();
  }
  Resulting[1] = Value / RUNS;
  printf("-----------------------------------\n");

#if NUMTHREADS == 2
  sprintf(Name, "./compiletnt.sh %li", WaitTime[0]);
#else
  sprintf(Name, "./compiletnt.sh %li %li %li",
	  WaitTime[0], WaitTime[1], WaitTime[2]);
#endif
  Value = 0;
  for (i = 0; i < RUNS; i++) {
    system("./runbnc.sh cnd");
    Value += GetValue();
  }
  Resulting[2] = Value / RUNS;
  printf("-----------------------------------\n");
}

int main (int argc, char *argv[])
{
  int i,j,k;
  long Value, Wait[3];
  char Name[64];
  FILE *DebugFile;
  RunBaseline();
  printf("-----------------------------------\n");
#if NUMTHREADS == 2
  for (i=0; i<=DIVISION; i++) {
    Wait[0] =
      ((long)((((double)i)/((double)DIVISION))*((double)RunsTime[0])));
    sprintf(Name, "./compiletnt.sh %li", Wait[0]);
    DebugFile = fopen("WaitingStatistic.txt", "a");
    fprintf(DebugFile, "-> %s\n", Name);
    fclose(DebugFile);
    system(Name);
    printf("./compiletnt.sh %li\n",  Wait[0]);
    Value = RunProcessFile();
    if (Value < MinValue) {
      WaitTime[0] = Wait[0];
      MinValue = Value;
      DebugFile = fopen("WaitingStatistic.txt", "a");
      fprintf(DebugFile, "Wait(T1,T2): %li => Value: %li\n",
	      WaitTime[0], MinValue);
      fclose(DebugFile);
    }
    printf("-----------------------------------\n");
  }
#else
  for (i=0; i<=DIVISION; i++)
    for (j=0; j<=DIVISION; j++)
      for (k=0; k<=DIVISION; k++) {
	Wait[0] =
	  ((long)((((double)i)/((double)DIVISION))*((double)RunsTime[0])));
	Wait[1] =
	  ((long)((((double)j)/((double)DIVISION))*((double)RunsTime[1])));
	Wait[2] =
	  ((long)((((double)k)/((double)DIVISION))*((double)RunsTime[2])));
	sprintf(Name, "./compiletnt.sh %li %li %li",
		Wait[0], Wait[1], Wait[2]);
	DebugFile = fopen("WaitingStatistic.txt", "a");
	fprintf(DebugFile, "-> %s\n", Name);
	fclose(DebugFile);
	system(Name);
	printf("./compiletnt.sh %li %li %li\n",  Wait[0], Wait[1], Wait[2]);
	Value = RunProcessFile();
	if (Value < MinValue) {
	  WaitTime[0] = Wait[0];
	  WaitTime[1] = Wait[1];
	  WaitTime[2] = Wait[2];
	  MinValue = Value;
	  DebugFile = fopen("WaitingStatistic.txt", "a");
	  fprintf(DebugFile,
		  "Wait(T1,T2): %li | Wait(T2,T3): %li | Wait(T3,T4): %li",
		  WaitTime[0], WaitTime[1], WaitTime[2]);
	  fprintf(DebugFile, " => Value: %li\n", MinValue);
	  fclose(DebugFile);
	}
        printf("-----------------------------------\n");
      }
#endif
  RunTimeResults();
  DebugFile = fopen("WaitingStatistic.txt", "a");
  fprintf(DebugFile, "Timing -> T1=%li | T2=%li | T3=%li | T4=%li\n",
          RunsTime[0], RunsTime[1], RunsTime[2], RunsTime[3]);
  fprintf(DebugFile,
	  "Wait(T1,T2): %li | Wait(T2,T3): %li | Wait(T3,T4): %li",
	  WaitTime[0], WaitTime[1], WaitTime[2]);
  fprintf(DebugFile, " => Value: %li\n", MinValue);
  fprintf(DebugFile, "Sequential Execution Time: %li\n", Resulting[0]);
  fprintf(DebugFile, "Parallel   Execution Time: %li\n", Resulting[1]);
  fprintf(DebugFile, "Waiting    Execution Time: %li\n", Resulting[2]);
  fclose(DebugFile);
  printf("Timing -> T1=%li | T2=%li | T3=%li | T4=%li\n",
	 RunsTime[0], RunsTime[1], RunsTime[2], RunsTime[3]);
  printf("Wait(T1,T2): %li;  Wait(T2,T3): %li;  Wait(T3,T4): %li",
	 WaitTime[0], WaitTime[1], WaitTime[2]);
  printf(" => Value: %li\n", MinValue);
  printf("Sequential Execution Time: %li\n", Resulting[0]);
  printf("Parallel   Execution Time: %li\n", Resulting[1]);
  printf("Waiting    Execution Time: %li\n", Resulting[2]);
  return 0;
}
