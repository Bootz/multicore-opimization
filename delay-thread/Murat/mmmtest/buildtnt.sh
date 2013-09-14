rm -f *~ *.ll *.s mmmint_ts1.bc mmmint_tnt.bc mmmint_tnt
#cp `llvm-config --obj-root`/lib/Tools/ThreadTest/Version/Functions_TNT.c .
cp Functions_TNT_$2.c Functions_TNT.c

llvm-gcc -O0 -emit-llvm -c Functions_TNT.c \
-o Functions_TNT.bc -I/opt/local/include

llvm-link mmmint$1_org.bc Functions_TNT.bc -f -o mmmint_ts1.bc
opt -load `llvm-config --prefix`/lib/libThreadProj.so \
-threadtestnx mmmint_ts1.bc -f -o mmmint_tnt.bc
llc mmmint_tnt.bc -f -o mmmint_tnt.s

gcc -O0 mmmint_tnt.s -o mmmint_tnt -lm -lpthread -lrt /opt/local/lib/libpapi.a
