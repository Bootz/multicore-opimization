#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <clapack.h>
#include <unistd.h>
#include <pthread.h>
#include <papi.h>
#include <sys/timerfd.h>

typedef struct {
	char dirname[256];
	char filename[256];
	unsigned looplineno;
	unsigned iter;
} __dt_position;
__dt_position  __dt_pos[2];

int events[3] = {PAPI_TOT_CYC, PAPI_L1_TCM, PAPI_L2_TCM};
int eventnum = 3;
long long values[3];
int eventset;
FILE *gnuplotfile;

double frand ( void ) {
  double value;

  value = ( ( double ) rand ( ) / ( RAND_MAX ) );

  return value;
}

struct periodic_info
{
	int timer_fd;
	unsigned long long wakeups_missed;
};

static int make_periodic (unsigned int period, struct periodic_info *info)
{
	int ret;
	unsigned int ns;
	unsigned int sec;
	int fd;
	struct itimerspec itval;

	/* Create the timer */
	fd = timerfd_create (CLOCK_MONOTONIC, 0);
	info->wakeups_missed = 0;
	info->timer_fd = fd;
	if (fd == -1)
		return fd;

	/* Make the timer periodic */
	sec = period/1000000;
	ns = (period - (sec * 1000000)) * 1000;
	itval.it_interval.tv_sec = sec;
	itval.it_interval.tv_nsec = ns;
	itval.it_value.tv_sec = sec;
	itval.it_value.tv_nsec = ns;
	ret = timerfd_settime (fd, 0, &itval, NULL);
	return ret;
}

static void wait_period (struct periodic_info *info)
{
	unsigned long long missed;
	int ret;

	/* Wait for the next timer event. If we have missed any the
	   number is written to "missed" */
	ret = read (info->timer_fd, &missed, sizeof (missed));
	if (ret == -1)
	{
		perror ("read timer");
		return;
	}

	/* "missed" should always be >= 1, but just to be sure, check it is not 0 anyway */
	if (missed > 0)
		info->wakeups_missed += (missed - 1);
}

void *PapiKernel (void *Args) {
	struct periodic_info info;
  unsigned i=0;
  long long tempvalues[3];

        tempvalues[0]=0;
        tempvalues[1]=0;
        tempvalues[2]=0;
        //lastmissrate=0;

        // 10ms interval
	make_periodic (10000, &info);
	while (1)
	{
		i+=10;
		/* Do useful work */
		PAPI_read(eventset, values);

		fprintf(gnuplotfile,"%u\t%lld\t%lld\t%lld\n", i, values[1]-tempvalues[1], values[2]-tempvalues[2],values[0]);
                //lastmissrate = missrate;
                tempvalues[1] = values[1];
                tempvalues[2] = values[2];
                
		wait_period (&info);
	}
	return NULL;

}

void *PapiKernel(void *Args) {
	struct periodic_info info;
	long long time = 0;
  float missrate = 0;
  float lastmissrate = 0;
  float llastmissrate = 0;
	long long lastvalues[3];
  __dt_position  temp_pos;

  // initialization
	lastvalues[0] = 0;
	lastvalues[1] = 0;
	lastvalues[2] = 0;
  strcpy(temp_pos.dirname, "");
  strcpy(temp_pos.filename, "");
  temp_pos.looplineno = 0;
  temp_pos.iter = 0;

  // First line of output file
	fprintf(gnuplotfile, "#Time(10ms)\tMissrate\tDirectory\t\
         Filename\tLineNum\tIteration\tPeakOrBottom(1 is peak)\n");

	// 10ms interval
	make_periodic(10000, &info);
	while (1) {
	  // wait 10ms
		wait_period(&info);

		PAPI_read(eventset, values);
		//fprintf(gnuplotfile,"%lld\t%lld\t%lld\n", time, values[1]-lastvalues[1], 
                             // values[2]-lastvalues[2]);
    missrate = (values[1] - lastvalues[1])*180.0/(values[2] - lastvalues[2]);

    // Is this a bottom?
		if ((missrate > lastmissrate) && (llastmissrate > lastmissrate)) {
			fprintf(gnuplotfile, "%lld\t%f\t%s\t%s\t%u\t%u\t%d\n", time, lastmissrate,
					temp_pos.dirname, temp_pos.filename, temp_pos.looplineno,	temp_pos.iter, 0);
    } else if ((missrate < lastmissrate) && (llastmissrate < lastmissrate)) {
			fprintf(gnuplotfile, "%lld\t%f\t%s\t%s\t%u\t%u\t%d\n", time, lastmissrate,
					temp_pos.dirname, temp_pos.filename, temp_pos.looplineno,	temp_pos.iter, 1);
		} else {
			fprintf(gnuplotfile, "%lld\t%f\t%s\t%s\t%u\t%u\n", time, lastmissrate,
					temp_pos.dirname, temp_pos.filename, temp_pos.looplineno,	temp_pos.iter);
    }

		lastvalues[1] = values[1];
		lastvalues[2] = values[2];
    llastmissrate = lastmissrate;
    lastmissrate = missrate;
	  strcpy(temp_pos.dirname, __dt_pos.dirname);
		strcpy(temp_pos.filename, __dt_pos.filename);
  	temp_pos.looplineno = __dt_pos.looplineno;
  	temp_pos.iter = __dt_pos.iter;

		time += 10;
	}
	return NULL;

}


struct ThrdArg
{
  double *dMatrix;
  int MSIZE;
  int *nPivotIndices;
};

void *luKernel (void *Args) {
  struct ThrdArg *Argument = (struct ThrdArg *) Args;
  double *dMatrix=Argument->dMatrix;
  int MSIZE=Argument->MSIZE;
  int *nPivotIndices=Argument->nPivotIndices;
  int nResult;
  nResult = clapack_dgetrf(CblasRowMajor, MSIZE, MSIZE, dMatrix, MSIZE, nPivotIndices);
  return 0;
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
   int i, j, MSIZE, status;
   double *dMatrix;
   double *dMatrix2;
   int *nPivotIndices;
   int *nPivotIndices2;
   int nResult;
   unsigned int seed = 123456789;
   struct ThrdArg Argument;

  pthread_attr_t attr;
  pthread_t Thread[2];
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

//  if (argc == 2){
 //   MSIZE = atoi(argv[1]);
  //} else {
   // MSIZE = 2048;
  //}
  MSIZE = (argc == 2? atoi(argv[1]):2048);

  // Allocate a new array on the heap, copy (clutching at straws here)       
  dMatrix = (double*)malloc(sizeof(double) * MSIZE * MSIZE);
  dMatrix2 = (double*)malloc(sizeof(double) * MSIZE * MSIZE);
  srand(seed);

  for ( i = 0; i < MSIZE; i++ )
  {
    for ( j = 0; j < MSIZE; j++ )
    {
      dMatrix[i*MSIZE+j] = frand ( );
      dMatrix2[i*MSIZE+j] = frand ( );
    }
  }

   // Resulting pivots
   nPivotIndices = (int*)malloc(MSIZE * sizeof(int));
   nPivotIndices2 = (int*)malloc(MSIZE * sizeof(int));
   
   // Check matrix
   //printMatrix(dMatrix, 4, 4);
   
   Argument.dMatrix=dMatrix2;
   Argument.MSIZE=MSIZE;
   Argument.nPivotIndices=nPivotIndices2;

   // Do calculation
   pthread_create(Thread, &attr, PapiKernel, NULL);   
   pthread_create(Thread+1, &attr, luKernel, &Argument);   
   nResult = clapack_dgetrf(CblasRowMajor, MSIZE, MSIZE, dMatrix, MSIZE, nPivotIndices);
   pthread_t ptp = pthread_self();
   pthread_join(Thread[1], (void **)&status);
   pthread_cancel(Thread[0]);
   //printf("Result: %d\n", nResult);
   
   // Print result matrix
   //printMatrix(dMatrix, 4, 4);
   
   // Print permutation vector
   //for (i = 0; i < MSIZE; i++)
    //  printf("%d: %d\n", i, nPivotIndices[i]);

   return 0;
}

int main (int argc, char *argv[])
{
  int i, j, MSIZE;

  //papi init code begin
  long long s;
  long long e;
  int retval;
  int eventcode;
  PAPI_option_t opt;
  char filename[50];

  if(PAPI_VER_CURRENT != PAPI_library_init(PAPI_VER_CURRENT)){
    printf("Can't initiate PAPI library!\n");
    exit(-1);
  }

  if (PAPI_thread_init(pthread_self) != PAPI_OK) {
    printf("Can't thread init!\n");
    exit(-1);
  }

  eventset = PAPI_NULL;
  if(PAPI_create_eventset(&eventset) != PAPI_OK){
    printf("Can't create eventset!\n");
    exit(-3);
  }

  if ( ( retval = PAPI_assign_eventset_component( eventset, 0 ) ) != PAPI_OK ) {
    printf("Can't assign_event_component!\n");
    exit(-3);
  }                

  memset( &opt, 0x0, sizeof ( PAPI_option_t ) );
  opt.inherit.inherit = PAPI_INHERIT_ALL;
  opt.inherit.eventset = eventset;
  if ( ( retval = PAPI_set_opt( PAPI_INHERIT, &opt ) ) != PAPI_OK ) {
    printf("Can't set inherit!\n");
    exit(-3);
  }

  //PAPI_event_name_to_code("ix86arch::LLC_MISSES",&eventcode);
  PAPI_event_name_to_code("MEM_LOAD_MISC_RETIRED:LLC_MISS",&eventcode);
  events[1] = eventcode;
  //PAPI_event_name_to_code("LLC_REFERENCES",&eventcode);
  PAPI_event_name_to_code("CPU_CLK_UNHALTED:THREAD_P",&eventcode);
  events[2] = eventcode;
  for(i=0;i<3;i++) {
    retval = PAPI_add_event(eventset, events[i]);
    if(retval != PAPI_OK){
      printf("error %d\n",retval);
      exit(-4);
    }
  }
  //papi init code end

  /* create output file in gnuplot format */
  
  MSIZE = (argc == 2? atoi(argv[1]):2048);
  sprintf(filename,"ludecomp_%d_2thread.txt", MSIZE);
  //gnuplotfile = fopen("ludecomp_tcm.txt", "w");
  gnuplotfile = fopen(filename, "w");
 // fprintf(gnuplotfile,"#time(ms)\tMEM_LOAD_MISC_RETIRED:LLC_MISS\tCPU_CLK_UNHALTED:THREAD_P\n");
  s = PAPI_get_real_usec();
  PAPI_start(eventset);
  test(argc, argv);
  PAPI_stop(eventset, values);
  e = PAPI_get_real_usec();
  fclose(gnuplotfile);


  /*Print out PAPI reading*/
  printf("Wallclock time: %lld usec\n",e-s);
  printf("Total Cycles\t%lld\n", values[0]);
  printf("MEM_LOAD_MISC_RETIRED:LLC_MISS\t%lld\n", values[1]);
  printf("CPU_CLK_UNHALTED:THREAD_P\t%lld\n", values[2]);

  return 0;
}