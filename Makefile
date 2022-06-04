CFLAGS=-Wall -Wextra -Wformat -pedantic -fPIC

blakeasm=BLAKE3/c/blake3_sse2_x86-64_unix.o BLAKE3/c/blake3_sse41_x86-64_unix.o BLAKE3/c/blake3_avx2_x86-64_unix.o BLAKE3/c/blake3_avx512_x86-64_unix.o

all: asm libblake3.a
.PHONY: all asm

libblake3.a: build/blake3.o build/blake3_dispatch.o build/blake3_hash.o build/blake3_portable.o asm
	ar rcs libblake3.a $(wildcard build/*)

asm:
	mkdir -p build/
	cd build && $(CC) $(CFLAGS) -c ../BLAKE3/c/blake3_sse2_x86-64_unix.S ../BLAKE3/c/blake3_sse41_x86-64_unix.S ../BLAKE3/c/blake3_avx2_x86-64_unix.S ../BLAKE3/c/blake3_avx512_x86-64_unix.S

build/blake3.o: BLAKE3/c/blake3.c
	mkdir -p build/
	$(CC) $(CFLAGS) -c -o build/blake3.o $<

build/blake3_dispatch.o: BLAKE3/c/blake3_dispatch.c
	mkdir -p build/
	$(CC) $(CFLAGS) -c -o build/blake3_dispatch.o $<

build/blake3_hash.o: blake3_hash.c
	mkdir -p build/
	$(CC) $(CFLAGS) -c -o build/blake3_hash.o $<

build/blake3_portable.o: BLAKE3/c/blake3_portable.c
	mkdir -p build/
	$(CC) $(CFLAGS) -c -o build/blake3_portable.o $<

clean:
	rm -rf build libblake3.a example

example: example.c libblake3.a
	$(CC) $(CFLAGS) -o example $^

fmt: $(wildcard *.c)
	clang-format -i *.c *.h --style=WebKit
