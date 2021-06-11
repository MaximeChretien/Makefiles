# Makefile for AVR microcontrollers using ASM
# v1.0
# Made by Maxime Chretien (MixLeNain)

# Device settings
DEVICE=atmega328p
CLOCK=1000000
FUSES=-U lfuse:w:0x62:m -U hfuse:w:0xD9:m -U efuse:w:0xFF:m

# Programmer settings
BAUD=19200
PROGRAMMER=stk500v1
PORT=/dev/ttyACM0
UPLOADER=avrdude -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) -p $(DEVICE)

# Build settings
CC=avra
TARGET=main.hex
SRC=$(TARGET:.hex=.asm)

.PHONY: all install flash fuse clean mrproper

all: $(TARGET)

install: flash fuse

flash:	all
	$(UPLOADER) -U flash:w:$(TARGET):i

fuse:
	$(UPLOADER) $(FUSES)

$(TARGET) : $(SRC)
	rm -f $(TARGET)
	$(CC) $<

clean:
	rm -f *.obj

mrproper: clean
	rm -f $(TARGET) $(TARGET:.hex=.lst) $(TARGET:.hex=.eep.hex) 

-include $(DEPS)
