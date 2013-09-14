.PHONY: all
all: test test2 test3 test4

test: test.c
	gcc -O0 -o test test.c

test2: test2.c
	gcc -O0 -o test2 test2.c -lpapi -lpthread

test3: test3.c
	clang -g -O2 -o test3 test3.c -lpapi -lpthread

test4: test4.c
	/home/kula85/Research/llvm-build/bin/clang -g -O2 -o test4 test4.c -lpapi -lpthread
