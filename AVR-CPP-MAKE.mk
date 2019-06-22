# Makefile for AVR microcontrollers using C++
# v1.1
# Made by Maxime Chretien (MixLeNain)

# Device settings
DEVICE=atmega328p
CLOCK=16000000
FUSES=-U lfuse:w:0x5E:m -U hfuse:w:0xD9:m -U efuse:w:0xFF:m

# Programmer settings
BAUD=19200
PROGRAMMER=stk500v1
PORT=/dev/ttyACM0
UPLOADER=avrdude -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) -p $(DEVICE)

# Build settings
CC=avr-g++
CFLAGS=-Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)
TARGET=main.hex
ELF=$(patsubst %.hex, %.elf, $(TARGET))
SRC=$(wildcard *.cpp)
OBJ=$(SRC:.cpp=.o)
DEPS=$(wildcard *.hpp)

.PHONY: all install flash fuse disasm clean mrproper

all: $(TARGET)

install: flash fuse

flash:	all
	$(UPLOADER) -U flash:w:$(TARGET):i

fuse:
	$(UPLOADER) $(FUSES)

$(TARGET) : $(ELF)
	rm -f $(TARGET)
	avr-objcopy -j .text -j .data -O ihex $(ELF) $(TARGET)

$(ELF) : $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

%.o:%.cpp $(DEPS)
	$(CC) -o $@ -c $< $(CFLAGS)

disasm:	$(ELF)
	avr-objdump -d $<

clean:
	rm -f *.o core

mrproper: clean
	rm -f $(TARGET) $(ELF)