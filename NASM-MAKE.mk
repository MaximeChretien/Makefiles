# Makefile for NASM programs
# v1.0
# Made by Maxime Chretien (MixLeNain)

ASM=nasm
ASMFLAGS=-f elf
DEBUGFLAGS=-g -F dwarf
LD=ld
LDFLAGS=-m elf_i386
TARGET=main
SRC=$(wildcard *.asm)
OBJ=$(SRC:.asm=.o)

.PHONY: all clean mrproper

all: $(TARGET)

$(TARGET) : $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

%.o:%.asm
# Add $(DEBUGFLAGS) at the end for debugging
	$(ASM) -o $@ $< $(ASMFLAGS)

clean:
	rm -f *.o core

mrproper: clean
	rm -f $(TARGET)