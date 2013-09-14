#! /bin/bash

if [ -z "$1" ]; then
  echo 'no input source file. exit.'
  exit 0
fi

clang -S -g -emit-llvm $1.c -o $1.s
opt -load=/home/kula85/Research/llvm-build/lib/LLVMDelayThread.so -loop-count-insertion -S $1.s -o $1.1.s
llc -O=0 $1.1.s
gcc -g -o $1 $1.1.s.s -llapack -lcblas -lf77blas -latlas -lpapi -lpthread

rm -rf $1.s $1.1.s $1.1.s.s
