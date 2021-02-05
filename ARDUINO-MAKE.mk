# Makefile for microcontrollers using arduino-cli
# v1.0
# Made by Maxime Chretien (MixLeNain)

# Device settings
BOARD=arduino:avr:uno
PORT=/dev/ttyACM0

# Build settings
TARGET=SketchName
FLAGS=-v

.PHONY: all install

all: $(TARGET)

install: all
	arduino-cli upload -b $(BOARD) -p $(PORT) $(TARGET) $(FLAGS)

$(TARGET):
	arduino-cli compile -b $(BOARD) $(TARGET) $(FLAGS)
