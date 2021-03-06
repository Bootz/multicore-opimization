#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <fftw3.h>
#include <papi.h>
#include <sys/timerfd.h>


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
        long long i=0;
        long long tempvalues[3];

        tempvalues[0]=0;
        tempvalues[1]=0;
        tempvalues[2]=0;

        // 10ms interval
	make_periodic (10000, &info);
	while (1)
	{
		i+=10;
		/* Do useful work */
		PAPI_read(eventset, values);
		fprintf(gnuplotfile,"%lld\t%lld\t%lld\n", i, values[1]-tempvalues[1], values[2]-tempvalues[2]);
                tempvalues[1]=values[1];
                tempvalues[2]=values[2];
                
		wait_period (&info);
	}
	return NULL;

}

void fftwtest ( void ) {
  int i;
  double *in;
  int j;
  int nx = 4096;
  int ny = 4096;
  int nyh;
  fftw_complex *out;
  fftw_plan plan_forward;
  unsigned int seed = 123456789;
  
  pthread_attr_t attr;
  pthread_t Thread;
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

//  printf ( "\n" );
//  printf ( "TEST04\n" );
//  printf ( "  Demonstrate FFTW3 on a %d by %d array of real data.\n",
//    nx, ny );
//  printf ( "\n" );
//  printf ( "  Transform data to FFT coefficients.\n" );
/*
  Create the input array, an NX by NY array of doubles.
*/
  in = malloc ( sizeof ( double ) * nx * ny );

  srand ( seed );

  for ( i = 0; i < nx; i++ )
  {
    for ( j = 0; j < ny; j++ )
    {
      in[i*ny+j] = frand ( );
    }
  }

//  printf ( "\n" );
//  printf ( "  Input Data:\n" );
//  printf ( "\n" );
//
//  for ( i = 0; i < nx; i++ )
//  {
//    for ( j = 0; j < ny; j++ )
//    {
//      printf ( "  %4d  %4d  %12f\n", i, j, in[i*ny+j] );
//    }
//  }
/*
  Create the output array OUT, which is of type FFTW_COMPLEX,
  and of a size NX * NYH that is roughly half the dimension of the input data
  (ignoring the fact that the input data is real, and the FFT
  coefficients are complex).
*/
  nyh = ( ny / 2 ) + 1;

  out = fftw_malloc ( sizeof ( fftw_complex ) * nx * nyh );

  plan_forward = fftw_plan_dft_r2c_2d ( nx, ny, in, out, FFTW_ESTIMATE );

  pthread_create(&Thread, &attr, PapiKernel, NULL);
  fftw_execute ( plan_forward );
  pthread_cancel(Thread);
  
//  printf ( "\n" );
//  printf ( "  Output FFT Coefficients:\n" );
//  printf ( "\n" );

//  for ( i = 0; i < nx; i++ )
//  {
//    for ( j = 0; j < nyh; j++ )
//    {
//      printf ( "  %4d  %4d  %12f  %12f\n", 
//      i, j, out[i*nyh+j][0], out[i*nyh+j][1] );
//    }
//  }
  
/*
  Free up the allocated memory.
*/
  fftw_destroy_plan ( plan_forward );

  free ( in );
  fftw_free ( out );

  return;
}

int main (int argc, char *argv[])
{
  int i, j;

  //papi init code begin
  long long s;
  long long e;
  int retval;
  int eventcode;
  PAPI_option_t opt;

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
  gnuplotfile = fopen("fftw_tcm.txt", "w");
  fprintf(gnuplotfile,"#time(ms)\tMEM_LOAD_MISC_RETIRED:LLC_MISS\tCPU_CLK_UNHALTED:THREAD_P\n");
  s = PAPI_get_real_usec();
  PAPI_start(eventset);
  fftwtest();
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
