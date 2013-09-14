/home/kula85/Install/llvm/2.7/bin/llc mmmint$1_org.bc -f -o mmmint_ipb.s
gcc -O0 -dn mmmint_ipb.s -o mmmint_ipb -lm -lpthread -lrt

#opcontrol --separate=all --vmlinux=/usr/src/linux/vmlinux
#opcontrol --setup --event=L2_RQSTS:20000:0xaa:1:1
opcontrol --start
opcontrol --reset
./mmmint_ipb
opcontrol --stop
