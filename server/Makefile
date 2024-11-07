# Linux Makefile
#

CC  := gcc
CXX := g++
CFLAGS := -g -c
CXXFLAGS := -g -c 
LDFLAGS :=  -lssl -lcrypto
DEPS := Socket.h
TARGETS := Server.out 

ALL := $(TARGETS)
$(info $$TARGETS = $(TARGETS))

%.o: %.cc $(DEPS)
	$(CXX) $(CXXFLAGS) $<

%.out: %.o VSocket.o Socket.o
	$(info $$^ = $^)
	$(CXX) $^ $(LDFLAGS) -o $@

Server.out:	Server.o VSocket.o Socket.o
	$(CXX) Server.o VSocket.o Socket.o $(LDFLAGS) -o $@
	
clean:
	rm -f *.o *.out
