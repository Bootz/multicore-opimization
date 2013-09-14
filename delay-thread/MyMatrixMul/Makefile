all:	mmmint thrdstatseq


mmmint:
	llvm-gcc -O0 -emit-llvm -c mmm.c -o mmmintthd_org.bc
	mv mmmintthd_org.bc mmmtest

	llvm-gcc -O0 -DSEQ -emit-llvm -c mmm.c -o mmmintseq_org.bc
	mv mmmintseq_org.bc mmmtest


thrdstatseq: Makefile
	gcc -O0 thrdstatseq.c -o thrdstatseq -lm
	mv thrdstatseq mmmtest


clean:
	rm -f *.s *.bc *.ll *~
	rm -f mmmintthd_org mmmintseq_org mmmintcnd_org thrdstatseq
