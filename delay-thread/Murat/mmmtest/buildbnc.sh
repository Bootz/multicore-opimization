rm -f *~ *.ll *.s mmmint_ipb
llvm-gcc -O0 -DEXETIME -emit-llvm -c Functions_IPB.c -o Functions_IPB.bc

llvm-link mmmint$1_org.bc Functions_IPB.bc -f -o mmmint_ip1.bc
opt -load `llvm-config --prefix`/lib/libThreadProj.so \
-incperfbench mmmint_ip1.bc -f -o mmmint_ipb.bc
llc mmmint_ipb.bc -f -o mmmint_ipb.s
rm mmmint_ip1.bc
rm mmmint_ipb.bc

gcc -O0 -dn mmmint_ipb.s -o mmmint_ipb -lm -lpthread -lrt
rm mmmint_ipb.s


Function_IPB.bc: Functions_IPB.c
	llvm-gcc -O0 -DEXETIME -emit-llvm -c Functions_IPB.c -o Functions_IPB.bc
	
mmmint_ip1.bc: Function
