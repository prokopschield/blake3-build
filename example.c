#include "blake3_hash.h"
#include <stdio.h>

#define SIZE (0x1000000)

int main(void)
{
    static uint8_t buffer[SIZE];
    static uint8_t hash[BLAKE3_OUT_LEN] = "";

    size_t nread = 0;
    size_t lread = 0;

    do {
        nread = 0;

        do {
            nread += (lread = fread(buffer + nread, 1, SIZE - nread, stdin));
        } while (lread);

        if (nread) {
            blake3_hash(buffer, nread, hash);

            for (uint8_t i = 0; i < BLAKE3_OUT_LEN; ++i) {
                printf("%02x", hash[i]);
            }
            putchar('\n');
        }
    } while (nread);
}
