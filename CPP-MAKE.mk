# Makefile for C++ programs
# v1.3
# Made by Maxime Chretien (MixLeNain)

CXX=g++
CXXFLAGS=-Wall -O -std=c++17
TARGET=main
SRC=$(wildcard *.cpp)
OBJ=$(SRC:.cpp=.o)
DEPS=$(wildcard *.hpp)
LIBS=

.PHONY: all clean mrproper

all: $(TARGET)

$(TARGET) : $(OBJ)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LDFLAGS) $(LIBS)

%.o:%.cpp $(DEPS)
	$(CXX) -o $@ -c $< $(CXXFLAGS) $(LIBS)

clean:
	rm -f *.o core

mrproper: clean
	rm -f $(TARGET)