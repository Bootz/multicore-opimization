.PHONY: install uninstall

install: libdthread.a
	install libdthread.a /usr/local/lib

libdthread.a: dthread.o
	ar rcs libdthread.a dthread.o

dthread.o: dthread.c
	gcc -O2 -c dthread.c -o dthread.o

uninstall:
	rm -rf /usr/local/lib/libdthread.a

clean:
	rm -rf dthread.o libdthread.a

