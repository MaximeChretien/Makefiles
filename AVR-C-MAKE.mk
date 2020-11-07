# Makefile for AVR microcontrollers using C
# v1.3
# Made by Maxime Chretien (MixLeNain)

# Device settings
DEVICE=atmega328p
CLOCK=16000000
FUSES=-U lfuse:w:0xDE:m -U hfuse:w:0xD9:m -U efuse:w:0xFF:m

# Programmer settings
BAUD=19200
PROGRAMMER=stk500v1
PORT=/dev/ttyACM0
UPLOADER=avrdude -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) -p $(DEVICE)

# Build settings
CC=avr-gcc
CFLAGS=-Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)
DEPFLAGS=-MMD
TARGET=main.hex
ELF=$(patsubst %.hex, %.elf, $(TARGET))
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(OBJS:.o=.d)

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

$(ELF) : $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

%.o:%.c
	$(CC) -o $@ -c $< $(CFLAGS) $(DEPFLAGS)

disasm:	$(ELF)
	avr-objdump -d $<

clean:
	rm -f *.o core *.d

mrproper: clean
	rm -f $(TARGET) $(ELF)

-include $(DEPS)
