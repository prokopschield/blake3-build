#ifndef __BLAKE3_HASH_H__
#define __BLAKE3_HASH_H__

#include "./BLAKE3/c/blake3.h"

void blake3_hash(const void* restrict data, const size_t len, uint8_t hash[BLAKE3_OUT_LEN]);

#endif
