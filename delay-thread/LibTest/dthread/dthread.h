#include <pthread.h>

void DTO_setpid(pthread_t *pid);

int DTO_getpid(pthread_t *pid);

void DTO_setfilename(const char *filename);

// Initilize PAPI library, add events that need to monitor
//void DTO_papi_prolog(const char *filename);
void DTO_prolog();

void DTO_epilog();

// three column output. no direct show of missrate. no peak&bottom, no position info
void *DTO_kernel(void *args);

//1 thread pos info with peak&bottom
void *DTO_kernel1(void *args);

//n thread pos info with peak&bottom
void *DTO_kernel2(void *args);

