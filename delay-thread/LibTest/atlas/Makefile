LLVMDIR = /home/kula85/Research/clapack/llvm/CLAPACK-3.2.1
#LLVMOPDIR = /home/kula85/Research/clapack/llvm-op/CLAPACK-3.2.1
LLVMOPDIR = /home/kula85/Research/clapack/testpthread/CLAPACK-3.2.1
GCCDIR = /home/kula85/Research/clapack/gcc/CLAPACK-3.2.1
LLVMBUILDDIR = /home/kula85/Research/multicore-opimization/llvm-build/bin
CLANG = /home/kula85/Install/llvm/trunk/llvm-without-lci/bin/clang

.PHONY: all clean
all: lude lude2 lude.a.llvm lude.a.llvmop lude.a.gcc CalstrcpyCycles
alllude2: lude2.vtune lude2.vtune.delay lude2.delay.op lude2.delay.noop lude2.nodelay.op lude2.nodelay.noop

lude: lude.c
	clang -o lude lude.c -llapack -lcblas -lf77blas -latlas -ldthread -lpapi -lpthread -I /usr/local/atlas/include -L/usr/local/atlas/lib

lude2.vtune: lude2.vtune.c
	$(CLANG) -g -O2 -o lude2.vtune lude2.vtune.c $(LLVMDIR)/lapack_LINUX.a $(LLVMDIR)/blas_LINUX.a $(LLVMDIR)/F2CLIBS/libf2c.a -lm -lpthread -lrt -I$(LLVMDIR)/INCLUDE/

lude2.vtune.delay: lude2.vtune.c
	$(CLANG) -g -O2 -DDELAY -DDELAYTIME=300 -o lude2.vtune.delay lude2.vtune.c $(LLVMDIR)/lapack_LINUX.a $(LLVMDIR)/blas_LINUX.a $(LLVMDIR)/F2CLIBS/libf2c.a -lm -lpthread -lrt -I$(LLVMDIR)/INCLUDE/

lude2.delay.op: lude2.c
	clang -g -O2 -DPAPITHREAD -DDELAY -DDELAYTIME=300 -o lude2.delay.op lude2.c $(LLVMOPDIR)/lapack_LINUX.a $(LLVMOPDIR)/blas_LINUX.a $(LLVMOPDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -lrt -I$(LLVMOPDIR)/INCLUDE/

lude2.nodelay.op: lude2.c
	clang -g -O2 -DPAPITHREAD -o lude2.nodelay.op lude2.c $(LLVMOPDIR)/lapack_LINUX.a $(LLVMOPDIR)/blas_LINUX.a $(LLVMOPDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(LLVMOPDIR)/INCLUDE/

lude2.delay.noop: lude2.c
	$(CLANG) -g -O2 -DDELAY -DDELAYTIME=300 -o lude2.delay.noop lude2.c $(LLVMDIR)/lapack_LINUX.a $(LLVMDIR)/blas_LINUX.a $(LLVMDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -lrt -I$(LLVMDIR)/INCLUDE/

lude2.nodelay.noop: lude2.c
	$(CLANG) -g -O2 -o lude2.nodelay.noop lude2.c $(LLVMDIR)/lapack_LINUX.a $(LLVMDIR)/blas_LINUX.a $(LLVMDIR)/F2CLIBS/libf2c.a -lm -lpapi -ldthread -lpthread -I$(LLVMDIR)/INCLUDE/

lude.a: lude.a.c
	clang -g -O2 -o lude.a lude.a.c $(LLVMOPDIR)/lapack_LINUX.a $(LLVMOPDIR)/blas_LINUX.a $(LLVMOPDIR)/F2CLIBS/libf2c.a -lm -ldthread -lpapi -lpthread -I$(LLVMOPDIR)/INCLUDE/

lude.a.llvm: lude.a1.c
	clang -g -O2 -o lude.a.llvm lude.a1.c $(LLVMDIR)/lapack_LINUX.a $(LLVMDIR)/blas_LINUX.a $(LLVMDIR)/F2CLIBS/libf2c.a -lm -lpapi -lpthread -I$(LLVMDIR)/INCLUDE/

lude.a.llvmop: lude.a.c
	clang1 -g -O2 -o lude.a.llvmop lude.a.c $(LLVMOPDIR)/lapack_LINUX.a $(LLVMOPDIR)/blas_LINUX.a $(LLVMOPDIR)/F2CLIBS/libf2c.a -lm -lpapi -lpthread -I$(LLVMOPDIR)/INCLUDE/

lude.a.s: lude.a.c
	$(LLVMBUILDDIR)/clang -g -O2 -S -emit-llvm -o lude.a.s lude.a.c -I$(LLVMOPDIR)/INCLUDE/
	#clang -g -O2 -S -emit-llvm -o lude.a.s lude.a.c -I$(LLVMOPDIR)/INCLUDE/

lude.a.gcc: lude.a1.c
	gcc -O2 -o lude.a.gcc lude.a1.c $(GCCDIR)/lapack_LINUX.a $(GCCDIR)/blas_LINUX.a $(GCCDIR)/F2CLIBS/libf2c.a -lm -lpapi -lpthread -I$(GCCDIR)/INCLUDE/

CalstrcpyCycles: CalstrcpyCycles.c
	gcc -O0 -o CalstrcpyCycles CalstrcpyCycles.c -lpapi

clean:
	rm -rf lude lude2 lude.a.llvm lude.a.llvmop lude.a.gcc CalstrcpyCycles


