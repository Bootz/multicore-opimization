#include <dthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <papi.h>
#include <assert.h>
#include <sys/timerfd.h>

static int dto_events[4];
static int dto_eventset;
static int dto_eventnum = 4;
static long long dto_values[4];
static FILE *dto_gnuplotfile;
static const char *dto_filename;
static long long dto_start;
static long long dto_end;
static long long dto_program_start;
//static long long dto_cycle_start;
//static long long dto_cycle_end;

typedef struct {
  pthread_t tid[8];
  int nthread;
} dto_tidinfo;

typedef struct {
  char dirname[256];
  char filename[256];
  unsigned looplineno;
  unsigned iter;
} dto_position;

dto_position DTO_pos[8];
dto_tidinfo DTO_atidinfo;

struct periodic_info {
  int timer_fd;
  unsigned long long wakeups_missed;
};

inline void DTO_setpid(pthread_t *pid) {
  DTO_atidinfo.tid[DTO_atidinfo.nthread++] = *pid;
}

inline int DTO_getpid(pthread_t *pid) {
  int i;

  if(DTO_atidinfo.nthread == 0) return 0;

  // printf("DTO_atidinfo.nthread is %d\n", DTO_atidinfo.nthread);
  for (i = 0; i < DTO_atidinfo.nthread; i++) {
    if (pthread_equal(DTO_atidinfo.tid[i], *pid)) {
      // found match
      return i;
    }
  }

  // not found match
  // if this function is called before papi thread is created
  // then return 0
  assert(0 && "should not be here!!\n");
  //return 0;
}

static int make_periodic(unsigned int period, struct periodic_info *info) {
  int ret;
  unsigned int ns;
  unsigned int sec;
  int fd;
  struct itimerspec itval;

  /* Create the timer */
  fd = timerfd_create(CLOCK_MONOTONIC, 0);
  info->wakeups_missed = 0;
  info->timer_fd = fd;
  if (fd == -1)
    return fd;

  /* Make the timer periodic */
  sec = period / 1000000;
  ns = (period - (sec * 1000000)) * 1000;
  itval.it_interval.tv_sec = sec;
  itval.it_interval.tv_nsec = ns;
  itval.it_value.tv_sec = sec;
  itval.it_value.tv_nsec = ns;
  ret = timerfd_settime(fd, 0, &itval, NULL);
  return ret;
}

static void wait_period(struct periodic_info *info) {
  unsigned long long missed;
  int ret;

  /* Wait for the next timer event. If we have missed any the
   number is written to "missed" */
  ret = read(info->timer_fd, &missed, sizeof(missed));
  if (ret == -1) {
    perror("read timer");
    return;
  }

  /* "missed" should always be >= 1, but just to be sure, check it is not 0 anyway */
  if (missed > 0)
    info->wakeups_missed += (missed - 1);
}

void DTO_setfilename(const char *filename) {
  dto_filename = filename;
}


void DTO_flush_cache() {
  const int LLC_CACHE_SIZE_KB = 8200;
  int cs = LLC_CACHE_SIZE_KB * 1024 / sizeof(double);
  double* flush = (double*) calloc (cs, sizeof(double));
  int i;
  double tmp = 0.0;

  for (i = 0; i < cs; i++)
    tmp += flush[i];
  assert (tmp <= 10.0);
  free (flush);
}


//void DTO_papi_prolog(const char *filename) {
void DTO_prolog() {
  int retval;
  int eventcode;
  PAPI_option_t opt;
  int i = 0;

  if (PAPI_VER_CURRENT != PAPI_library_init(PAPI_VER_CURRENT)) {
    fprintf(stderr, "Can't initiate PAPI library!\n");
    exit(EXIT_FAILURE);
  }

  if (PAPI_thread_init(pthread_self) != PAPI_OK) {
    fprintf(stderr, "Can't thread init!\n");
    exit(EXIT_FAILURE);
  }

  dto_eventset = PAPI_NULL;
  if (PAPI_create_eventset(&dto_eventset) != PAPI_OK) {
    fprintf(stderr, "Can't create eventset!\n");
    exit(EXIT_FAILURE);
  }

  if ((retval = PAPI_assign_eventset_component(dto_eventset, 0)) != PAPI_OK) {
    fprintf(stderr, "Can't assign_event_component!\n");
    exit(EXIT_FAILURE);
  }

  memset(&opt, 0x0, sizeof(PAPI_option_t));
  opt.inherit.inherit = PAPI_INHERIT_ALL;
  opt.inherit.eventset = dto_eventset;
  if ((retval = PAPI_set_opt(PAPI_INHERIT, &opt)) != PAPI_OK) {
    printf("Can't set inherit!\n");
    exit(EXIT_FAILURE);
  }

  dto_events[0] = PAPI_TOT_CYC;

  if((PAPI_event_name_to_code("MEM_LOAD_MISC_RETIRED:LLC_MISS", &eventcode)) != PAPI_OK) {
    fprintf(stderr, "PAPI_event_name_to_code fail!\n");
    exit(EXIT_FAILURE);
  }
  dto_events[1] = eventcode;
  //dto_events[1] = PAPI_L3_TCM;

  //if((PAPI_event_name_to_code("CPU_CLK_UNHALTED:THREAD_P", &eventcode)) != PAPI_OK) {
  if((PAPI_event_name_to_code("ix86arch::UNHALTED_CORE_CYCLES", &eventcode)) != PAPI_OK) {
    fprintf(stderr, "PAPI_event_name_to_code fail!\n");
    exit(EXIT_FAILURE);
  }
  dto_events[2] = eventcode;

  //if((PAPI_event_name_to_code("INST_RETIRED:ANY_P", &eventcode)) != PAPI_OK) {
  if((PAPI_event_name_to_code("ix86arch::INSTRUCTION_RETIRED", &eventcode)) != PAPI_OK) {
    fprintf(stderr, "PAPI_event_name_to_code fail!\n");
    exit(EXIT_FAILURE);
  }
  dto_events[3] = eventcode;

  for (i = 0; i < 4; i++) {
    retval = PAPI_add_event(dto_eventset, dto_events[i]);
    if (retval != PAPI_OK) {
      fprintf(stderr, "error %d\n", retval);
      exit(EXIT_FAILURE);
    }
  }

  if (dto_filename)
    dto_gnuplotfile = fopen(dto_filename, "w");

  dto_start = PAPI_get_real_usec();
  dto_program_start = PAPI_get_real_cyc();

  PAPI_start(dto_eventset);
}

void DTO_epilog() {
  PAPI_stop(dto_eventset, dto_values);
  dto_end = PAPI_get_real_usec();
  //dto_cycle_end = PAPI_get_real_cyc();

  if (dto_filename)
    fclose(dto_gnuplotfile);

  printf("cpu time: %lld usec\n", dto_end - dto_start);
  //printf("cpu time(by cycle): %f sec\n", (dto_cycle_end - dto_cycle_start)*1.0/3400000000);
  printf("Total Cycles\t%lld\n", dto_values[0]);
  printf("MEM_LOAD_MISC_RETIRED:LLC_MISS\t%lld\n", dto_values[1]);
  printf("CPU_CLK_UNHALTED:THREAD_P\t%lld\n", dto_values[2]);
  printf("INST_RETIRED:ANY_P\t%lld\n", dto_values[3]);
  printf("LLC Miss\t%f\n", dto_values[1] * 180.0 / dto_values[2]);
  printf("CPI\t%f\n", dto_values[2] * 1.0 / dto_values[3]);
  
}

// three column output. no direct show of missrate. no peak&bottom, no position info
void *DTO_kernel(void *args) {
  struct periodic_info info;
  long long time = 0;
  long long tempvalues[3] = {0, 0, 0};

  // 10ms interval
  make_periodic(10000, &info);
  while (1) {
    /* Do useful work */
    PAPI_read(dto_eventset, dto_values);
    fprintf(dto_gnuplotfile, "%lld\t%lld\t%lld\n", time,
        dto_values[1] - tempvalues[1], dto_values[2] - tempvalues[2]);
    tempvalues[1] = dto_values[1];
    tempvalues[2] = dto_values[2];

    wait_period(&info);
    time += 10;
  }

  return 0;
}

//1 thread pos info with peak&bottom
void *DTO_kernel1(void *args) {
  struct periodic_info info;
  long long time = 0;
  float missrate = 0;
  float lastmissrate = 0;
  float llastmissrate = 0;
  float cpi = 0;
  float lastcpi = 0;
  float llastcpi = 0;
  long long lastvalues[4] = {0, 0, 0, 0};
  dto_position temp_pos;

  // initialization
  strcpy(temp_pos.dirname, "");
  strcpy(temp_pos.filename, "");
  temp_pos.looplineno = 0;
  temp_pos.iter = 0;

  // First line of output file
  fprintf(dto_gnuplotfile,
      "#Time(10ms)\tMissrate\tCPI\tDirectory\t\
         Filename\tLineNum\tIteration\tPeakOrBottom(1 is peak)\n");

  // 10ms interval
  make_periodic(10000, &info);
  while (1) {
    PAPI_read(dto_eventset, dto_values);
    missrate = (dto_values[1] - lastvalues[1]) * 180.0 / (dto_values[2]
        - lastvalues[2]);
    cpi = 1.0 * (dto_values[2] - lastvalues[2]) / (dto_values[3]
        - lastvalues[3]);


    if ((missrate > lastmissrate) && (llastmissrate > lastmissrate)) { // Is this a bottom?
      fprintf(dto_gnuplotfile, "%lld\t%f\t%f\t%s\t%s\t%u\t%u\t%d\n", time,
          lastmissrate, lastcpi, temp_pos.dirname, temp_pos.filename,
          temp_pos.looplineno, temp_pos.iter, 0);
    } else if ((missrate < lastmissrate) && (llastmissrate < lastmissrate)) { // Is this a peak?
      fprintf(dto_gnuplotfile, "%lld\t%f\t%f\t%s\t%s\t%u\t%u\t%d\n", time,
          lastmissrate, lastcpi, temp_pos.dirname, temp_pos.filename,
          temp_pos.looplineno, temp_pos.iter, 1);
    } else {
      fprintf(dto_gnuplotfile, "%lld\t%f\t%f\t%s\t%s\t%u\t%u\n", time,
          lastmissrate, lastcpi, temp_pos.dirname, temp_pos.filename,
          temp_pos.looplineno, temp_pos.iter);
    }

    lastvalues[1] = dto_values[1];
    lastvalues[2] = dto_values[2];
    lastvalues[3] = dto_values[3];
    llastmissrate = lastmissrate;
    lastmissrate = missrate;
    llastcpi = lastcpi;
    lastcpi = cpi;
    strcpy(temp_pos.dirname, DTO_pos[0].dirname);
    strcpy(temp_pos.filename, DTO_pos[0].filename);
    temp_pos.looplineno = DTO_pos[0].looplineno;
    temp_pos.iter = DTO_pos[0].iter;

    // wait 10ms
    wait_period(&info);
    time += 10;
  }
  return 0;

}

//n thread pos info with peak&bottom
void *DTO_kernel2(void *args) {
  int i;
  struct periodic_info info;
  long long time = 0;
  long long cycles = 0;
  //long long realcycles = 0;
  float missrate = 0;
  float lastmissrate = 0;
  float llastmissrate = 0;
  float cpi = 0;
  float lastcpi = 0;
  float llastcpi = 0;
  long long lastvalues[4] = {0, 0, 0, 0};
  dto_position temp_pos[8];
  int nthread = *(int*) args;

  if (nthread > 8) {
    fprintf(stderr, "Not enough space to store info for %d threads. "
                           "Only support up to 8 threads.\n", nthread);
    exit(-1);
  }

  for (i = 0; i < nthread; i++) {
    strcpy(temp_pos[i].dirname, "");
    strcpy(temp_pos[i].filename, "");
    temp_pos[i].looplineno = 0;
    temp_pos[i].iter = 0;
  }

  // First line of output file
  fprintf(dto_gnuplotfile, "#ThreadID\tTime(10ms)\tMissrate\tCPI\tDirectory\t"
                   "Filename\tLineNum\tIteration\tPeakOrBottom(1 is peak)\n");

  // 10ms interval
  make_periodic(10000, &info);
  while (1) {
    //PAPI_read(dto_eventset, dto_values);
    PAPI_read_ts(dto_eventset, dto_values, &cycles);
    //realcycles = PAPI_get_real_cyc();

    //missrate = (dto_values[1] - lastvalues[1]) * 180.0 / (dto_values[2]
    //    - lastvalues[2]);
    //cpi = 1.0 * (dto_values[2] - lastvalues[2]) / (dto_values[3]
    //    - lastvalues[3]);

    //cycles -= dto_program_start;

    // wait 10ms
    wait_period(&info);
    //time += 10;
  }
  return 0;

}
