SHELL=/bin/sh
SOURCE=$(shell pwd)
TARGET=/home/nshields/.config/home-manager

.PHONY: all
all: build

.PHONY: switch build test
switch build: 
	home-manager $@ 

.PHONY: 
bootstrap:
	ln -s $(SOURCE)/home-manager/* $(TARGET)

.PHONY: clean
clean:
