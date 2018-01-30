CC=g++

PLFS_PATH ?= $(HOME)

OPTS = -g -fPIC -shared -I$(PLFS_PATH)/include -fvisibility=hidden
LINKOPTS = -g -fPIC -shared -fvisibility=hidden -Wl,-soname,libsoplfs.so.1 -o libsoplfs.so.1.0.1 -lpthread -ldl -lplfs -L$(PLFS_PATH)/lib -I$(PLFS_PATH)/include

all: libsoplfs

soplfs.o: soplfs.cpp
	$(CC) $(OPTS) -O3 -c soplfs.cpp

libsoplfs.so.1.0.1: soplfs.o
	$(CC) $(LINKOPTS) -O3 soplfs.o

libsoplfs.so.1: libsoplfs.so.1.0.1
	ln -sf libsoplfs.so.1.0.1 libsoplfs.so.1

libsoplfs.so: libsoplfs.so.1
	ln -sf libsoplfs.so.1 libsoplfs.so

libsoplfs: libsoplfs.so
	
clean:
	rm -f *.o *.so *.so.*
