BARE_PATH := .bare
BARE_FLAGS := utils std.fs std.io

all: main_asm

bare.asm: $(BARE_FLAGS)
	for feat in $(BARE_FLAGS); do \
		echo "%include \"$(BARE_PATH)/$${feat}.asm\"" >> $@; \
	done

main_asm: main.asm bare.asm
	nasm -f elf -I. -o main.o main.asm
	ld main.o

clean:
	rm -f bare.asm main.o