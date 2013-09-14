rm -f *~ TRPN.txt
rm -f ./mmmintcnd_org ./mmmintcnd_org.s ./mmmintcnd_org.bc
llvm-gcc -O0 -DTHRD -DTCOND -DTIME12=$1 -DTIME23=$2 -DTIME34=$3 \
-emit-llvm -c ../mmm.c -o ./mmmintcnd_org.bc
llc ./mmmintcnd_org.bc -o ./mmmintcnd_org.s
gcc -O0 ./mmmintcnd_org.s -o ./mmmintcnd_org -lm -lpthread -lrt
