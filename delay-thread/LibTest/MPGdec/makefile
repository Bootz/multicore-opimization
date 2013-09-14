HEADERS =  config global mpeg2dec getvlc 
SRC =  display getbits getblk gethdr getpic getvlc idct idctref motion mpeg2dec\
recon spatscal store subspic systems verify

TARGET = mpeg2dec

#WARNINGS = -Wall
#VERIFY = -DVERIFY

#disable this flag if you do not want bitstream element tracing 
#this will speed up the decoder some since it does not have to test
#the trace flag at several critical inner loop locations.
#TRACE = -DTRACE

#disable this flag if you do not need verbose trace, such as
#header information
#VERBOSE = -DVERBOSE

# uncomment the following two lines if you want to include X11 support

#USE_DISP = -DDISPLAY
#LIBS = -lX11

# uncomment the following two lines if you want to use shared memory
# (faster display if server and client run on the same machine)

#USE_SHMEM = -DSH_MEM
#LIBS = -lXext -lX11

# if your X11 include files / libraries are in a non standard location:
# set INCLUDEDIR to -I followed by the appropriate include file path and
# set LIBRARYDIR to -L followed by the appropriate library path and

#INCLUDEDIR = -I/usr/X11R6/include
#LIBRARYDIR = -L/usr/X11R6/lib

# Use the first one if no threading is needed
# The second USERLIBS is for thread support

#USERLIBS = -lm
USERLIBS = -lm -lpthread -lpapi

# INT_IDCT is for Integer IDCT, gives better performance. Use -DINT_IDCT to enable
# For Thread support, use the 2nd USERFLAGS and enter the desired number of threads

USE_INT_IDCT = -DINT_IDCT -DMATRIX_IDCT=0 -DORIGINAL_IDCT=0
USE_THREADS = -DTHRD -DNUM_THREADS=2
USE_SSE2 = -use_msasm -DSSE2

USERFLAGS = $(USE_INT_IDCT) $(USE_THREADS) 

USE_PENTIUM_4 = -vec- -march=pentium4 -mcpu=pentium4
#USE_GPROF = -p

#INCLUDEDIR = -I/opt/intel_cc_80/include
#LIBRARYDIR = -L/opt/intel_cc_80/lib

# Choose the appropriate compiler gcc or Intel icc

CC = gcc
LD = gcc       # Using GCC as the compiler for now
OPTIMIZE = -g -O4 #-Wall

#LD = /opt/intel_cc_80/bin/icc
#CC = /opt/intel_cc_80/bin/icc
#OPTIMIZE = $(USE_PENTIUM_4) $(USE_SSE2) -DUSE_ICC -g -O3 #-Wall

STATLINK = -dn # Option to force static linkage

CFLAGS = $(USE_GPROF) $(OPTIMIZE) $(USERFLAGS) $(USE_DISP) $(USE_SHMEM) $(INCLUDEDIR) $(TRACE) \
$(VERBOSE) $(VERIFY) $(WARNINGS)

OBJS = $(SRC:%=obj/%.o)

execs/$(TARGET).out: $(OBJS)
	$(LD) $(STATLINK) $(CFLAGS) $(LIBRARYDIR) -o execs/$(TARGET) $(OBJS) $(LIBS) $(USERLIBS)

$(OBJS): $(HEADERS:%=src/%.h) $(SRC:%=src/%.c)
	$(CC) -o $@ $(CFLAGS) -c $(*:obj/%=src/%.c)

clean:
	rm -f obj/*.o execs/$(TARGET)

