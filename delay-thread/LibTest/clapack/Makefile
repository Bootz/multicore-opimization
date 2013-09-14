CLAPACK_LLVMDIR = /home/kula85/Install/clapack/llvm/CLAPACK-3.2.1
CLAPACK_LLVMLCIDIR = /home/kula85/Install/clapack/llvmlci/CLAPACK-3.2.1
CLAPACK_LLVMLCIDIR2 = /home/kula85/Install/clapack/llvmlci2/CLAPACK-3.2.1
CLAPACK_GCCDIR = /home/kula85/Install/clapack/gcc/CLAPACK-3.2.1
CLAPACK_GCOVDIR = /home/kula85/Install/clapack/gcov/CLAPACK-3.2.1
CLAPACK_GPROFDIR = /home/kula85/Install/clapack/gprof/CLAPACK-3.2.1
ATLAS_GCCDIR = /home/kula85/Install/atlas/gcc/
CLANG = /home/kula85/Install/llvm/trunk_/bin/clang

LINKOP = $(CLAPACK_GCCDIR)/lapack_LINUX.a $(CLAPACK_GCCDIR)/blas_LINUX.a $(CLAPACK_GCCDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_GCCDIR)/INCLUDE/ 

LINKOP0 = $(CLAPACK_GPROFDIR)/lapack_LINUX.a $(CLAPACK_GPROFDIR)/blas_LINUX.a $(CLAPACK_GPROFDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_GPROFDIR)/INCLUDE/ 

LINKOP1 = $(CLAPACK_GCOVDIR)/lapack_LINUX.a $(CLAPACK_GCOVDIR)/blas_LINUX.a $(CLAPACK_GCOVDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_GCOVDIR)/INCLUDE/ 

LINKOP2 = $(CLAPACK_LLVMDIR)/lapack_LINUX.a $(CLAPACK_LLVMDIR)/blas_LINUX.a $(CLAPACK_LLVMDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_LLVMDIR)/INCLUDE/ 

LINKOP3 = $(CLAPACK_LLVMLCIDIR)/lapack_LINUX.a $(CLAPACK_LLVMLCIDIR)/blas_LINUX.a $(CLAPACK_LLVMLCIDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_LLVMLCIDIR)/INCLUDE/ 

LINKOP4 = $(CLAPACK_LLVMLCIDIR2)/lapack_LINUX.a $(CLAPACK_LLVMLCIDIR2)/blas_LINUX.a $(CLAPACK_LLVMLCIDIR2)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(CLAPACK_LLVMLCIDIR2)/INCLUDE/ 

.PHONY: all clean
all: lude lude2 lude.a.llvm lude.a.llvmop lude.a.gcc
alllude: lude_atlas lude_atlas_delay lude lude2 lude_papi3 lude_delay lude_papi lude_papi_delay lude_papi2 lude_papi2_delay
alllude2: lude2.vtune lude2.vtune.delay lude2.delay.op lude2.delay.noop lude2.nodelay.op lude2.nodelay.noop

lude_atlas: luatlas.c
	gcc -DNTHREAD=10 -o lude_atlas luatlas.c -llapack -lcblas -lf77blas -latlas -lpthread -I $(ATLAS_GCCDIR)/include -L$(ATLAS_GCCDIR)/lib

lude_atlas_delay: luatlas.c
	gcc -DNTHREAD=10 -DDELAYTIME=0.5 -o lude_atlas_delay luatlas.c -llapack -lcblas -lf77blas -latlas -lpthread -I $(ATLAS_GCCDIR)/include -L$(ATLAS_GCCDIR)/lib

lude: lude.c
	gcc -DNTHREAD=2 -O0 -o lude lude.c $(CLAPACK_GCCDIR)/lapack_LINUX.a $(CLAPACK_GCCDIR)/blas_LINUX.a $(CLAPACK_GCCDIR)/F2CLIBS/libf2c.a -lm -lpthread -I$(CLAPACK_GCCDIR)/INCLUDE/
	#gcc -DNTHREAD=4 -g -O2 -o lude lude.c $(CLAPACK_GCCDIR)/lapack_LINUX.a $(CLAPACK_GCCDIR)/blas_LINUX.a $(CLAPACK_GCCDIR)/F2CLIBS/libf2c.a -lm -lpthread -I$(CLAPACK_GCCDIR)/INCLUDE/
lude2: lude.c
	gcc -DNTHREAD=2 -fprofile-arcs -ftest-coverage -O0 -o lude2 lude.c $(LINKOP1)

lude3: lude.c
	gcc -DNTHREAD=2 -O0 -o lude3 lude.c $(LINKOP0) -pg

lude_delay: lude.c
	gcc -DNTHREAD=4 -DDELAYTIME=1 -O0 -o lude_delay lude.c $(CLAPACK_GCCDIR)/lapack_LINUX.a $(CLAPACK_GCCDIR)/blas_LINUX.a $(CLAPACK_GCCDIR)/F2CLIBS/libf2c.a -lm -lpthread -lrt -I$(CLAPACK_GCCDIR)/INCLUDE/
	#gcc -g -DDELAY -DDELAYTIME=300 -o lude_delay lude.c $(CLAPACK_GCCDIR)/lapack_LINUX.a $(CLAPACK_GCCDIR)/blas_LINUX.a $(CLAPACK_GCCDIR)/F2CLIBS/libf2c.a -lm -lpthread -lrt -I$(CLAPACK_GCCDIR)/INCLUDE/

lude_papi: lude_papi.c
	$(CLANG) -g -O0 -o lude_papi lude_papi.c $(LINKOP2)

lude_papi_delay: lude_papi.c
	$(CLANG) -g -O0 -DDELAYTIME=2 -o lude_papi_delay lude_papi.c $(LINKOP2) -lrt

lude_papi2: lude_papi.c
	$(CLANG) -mllvm -enable-lci -g -O0 -DPAPITHREAD -o lude_papi2 lude_papi.c $(LINKOP4)

lude_papi3: lude_papi.c
	$(CLANG) -mllvm -enable-lci -g -O0 -o lude_papi3 lude_papi.c $(LINKOP4)

lude_papi2_delay: lude_papi.c
	$(CLANG) -mllvm -enable-lci -g -O0 -DPAPITHREAD -DDELAYTIME=2 -o lude_papi2_delay lude_papi.c $(LINKOP4) -lrt

clean:
	rm -rf lude_atlas lude_atlas_delay lude lude2 lude_papi3 lude_delay lude_papi lude_papi_delay lude_papi2 lude_papi2_delay 


