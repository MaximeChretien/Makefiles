# Makefile for C programs
# v1.3
# Made by Maxime Chretien (MixLeNain)

CC=gcc
CFLAGS=-Wall -O -std=c17
LDFLAGS=
DEPFLAGS=-MMD
TARGET=main
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(OBJS:.o=.d)
LIBS=

.PHONY: all clean mrproper

all: $(TARGET)

exe: $(TARGET)
	./$(TARGET)

$(TARGET) : $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS) $(LIBS)

%.o:%.c
	$(CC) -o $@ -c $< $(CFLAGS) $(DEPFLAGS) $(LIBS)

clean:
	rm -f *.o core *.d

mrproper: clean
	rm -f $(TARGET)

-include $(DEPS)
