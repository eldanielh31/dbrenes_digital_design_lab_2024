CC = arm-linux-gnueabi-gcc
AS = arm-linux-gnueabi-as
LD = arm-linux-gnueabi-ld
OBJCOPY = arm-linux-gnueabi-objcopy
FILENAME = text_processor

all: main program.hex message.mif

main: main.o
	$(LD) -o $@ $^

main.o: $(FILENAME).s
	$(AS) -o $@ $^

program.hex: main
	$(OBJCOPY) -O ihex main program.hex

message.mif:
	python3 generate_mif.py

run:
	qemu-arm -L /usr/arm-linux-gnueabi ./main

.PHONY: clean

clean:
	rm -f main main.o program.hex message.mif
