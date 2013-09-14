DFLAG = -DDP
OP = -O0 -g -msse2
LINKLIB = -lpthread -lrt

.PHONY : all clean

all: mmmseq mmmtcond mmmbase mmmelse

mmmseq: mmm.c
	gcc $(DFLAG) $(OP) -DSEQ -o $@ $< $(LINKLIB)

mmmtcond: mmm.c
	gcc $(DFLAG) $(OP) -DTCOND -DTIME=7000 -o $@ $< $(LINKLIB)

mmmbase: mmm.c
	gcc $(DFLAG) $(OP) -DBASE -o $@ $< $(LINKLIB)

mmmelse: mmm.c
	gcc $(DFLAG) $(OP) -o $@ $< $(LINKLIB)

clean:
	rm -f mmmseq mmmtcond mmmbase mmmelse
