# Makefile for C programs
# v1.2
# Made by Maxime Chretien (MixLeNain)

CC=gcc
CFLAGS=-Wall -O -std=c17
TARGET=main
SRC=$(wildcard *.c)
OBJ=$(SRC:.c=.o)
DEPS=$(wildcard *.h)
LIBS=

.PHONY: all clean mrproper

all: $(TARGET)

$(TARGET) : $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS) $(LIBS)

%.o:%.c $(DEPS)
	$(CC) -o $@ -c $< $(CFLAGS) $(LIBS)

clean:
	rm -f *.o core

mrproper: clean
	rm -f $(TARGET)