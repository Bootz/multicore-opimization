#include <papi.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static unsigned len = 1000000;

int events[1] = {PAPI_TOT_CYC};
int eventnum = 1;
char b[] = "abcdersldjfweurlsjljsfljlsdfjsdl;fjdsl;n.n.vxcn;lsj;jfpeulnsfljfd";

void func()
{
	int i;
  char a[256];

	for(i=0; i<len; i++){
		strcpy(a, b);
	}
}

int main()
{
	long long values[1];
	int eventset;
  int i;
	int retval;


	if(PAPI_VER_CURRENT != PAPI_library_init(PAPI_VER_CURRENT)){
		printf("Can't initiate PAPI library!\n");
		exit(-1);
	}

	eventset = PAPI_NULL;
	if(PAPI_create_eventset(&eventset) != PAPI_OK){
		printf("Can't create eventset!\n");
		exit(-3);
	}

        /* set multiplexing */
//	PAPI_multiplex_init();
 //       retval = PAPI_set_multiplex(eventset);
  //      if ((retval == PAPI_EINVAL) && (PAPI_get_multiplex(eventset) > 0))
   //       printf("This event set already has multiplexing enabled\n");
    //    else if (retval != PAPI_OK) {
		//printf("Can't set multiplexing!\n");
		//exit(-3);
     //   }

	if(PAPI_OK != PAPI_add_events(eventset, events, eventnum)){
		printf("Can't add events!\n");
		exit(-4);
	}
        //for(i=0;i<5;i++) {
  	 // retval = PAPI_add_event(eventset, events[i]);
	  //if(retval != PAPI_OK){
		//printf("i=%d\n",i);
	//	printf("error %d\n",retval);
	//	exit(-4);
	 // }
        //}

	PAPI_start(eventset);
	func();
	PAPI_stop(eventset, values);

	/*Print out PAPI reading*/
	printf("Total Cycles\t\t%lld\n", values[0]);
	//printf("L1 Cache Miss\t\t%lld\n", values[1]);
	//printf("L2 Cache Miss\t\t%lld\n", values[2]);
	//printf("Data TLB Miss\t\t%lld\n", values[3]);
	//printf("Instruction TLB Miss\t%lld\n", values[4]);
	//printf("Total TLB Miss\t\t%lld\n", values[3]+values[4]);
}
