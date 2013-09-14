#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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


__dt_position __dt_pos[2];
//extern __dt_currentposition __dt_pos;
int events[3] = {PAPI_TOT_CYC, PAPI_L1_TCM, PAPI_L2_TCM};
int eventnum = 3;
long long values[3];
long long tempvalues[3];
int eventset;
FILE *gnuplotfile;
//static char __dt_curfilename[]="test3.c";
//static char __dt_curdirname[]="///";

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

  tempvalues[0]=0;
  tempvalues[1]=0;
  tempvalues[2]=0;

  // 10ms interval
  make_periodic (10000, &info);
  while (1) {
    i+=10;
    /* Do useful work */
    PAPI_read(eventset, values);
    fprintf(gnuplotfile,"%lld\t%lld\t%lld\t%s\t%s\t%u\t%u\n", 
                   i, values[1]-tempvalues[1], values[2]-tempvalues[2],
                   __dt_pos[0].dirname, __dt_pos[1].filename, __dt_pos[0].looplineno, __dt_pos[1].iter);
    tempvalues[1]=values[1];
    tempvalues[2]=values[2];
    wait_period (&info);
  }
  return NULL;
}

int test() {
  int i,j;
  int numInt;
  int numCachelineUsed;
  int *a;
  
  numInt = 2*1024*1024;
  //numInt = 1024*1024;
  numCachelineUsed = 8*1024*1024/64;
  //numCachelineUsed = 4*1024*1024/64;
  a = (int*) malloc(sizeof(int)*numInt);

  pthread_attr_t attr;
  pthread_t Thread;
  
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  pthread_create(&Thread, &attr, PapiKernel, NULL);
  
  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++) {
      //strcpy(__dt_pos.dirname, __dt_curdirname);
      //strcpy(__dt_pos.filename, __dt_curfilename);
      //__dt_pos.looplineno = 100;
      //__dt_pos.iter = 200;
      a[i*16+j]++;
    }

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++)
       a[i*16+j]++;

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  //cache miss = 1
  for(j=0; j<16; j++) 
    for(i=0; i< numCachelineUsed; i++)
       a[i*16+j]++;

  //cache miss = 0
  for(i=0;i<numInt;i++)
     a[i]++;

  pthread_cancel(Thread);

  return 0;
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

  PAPI_event_name_to_code("MEM_LOAD_MISC_RETIRED:LLC_MISS",&eventcode);
  events[1] = eventcode;
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
  gnuplotfile = fopen("test4.txt", "w");
  //fprintf(gnuplotfile,"#time(ms)\tMEM_LOAD_MISC_RETIRED:LLC_MISS\tCPU_CLK_UNHALTED:THREAD_P\n");
  s = PAPI_get_real_usec();
  PAPI_start(eventset);
  test();
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
