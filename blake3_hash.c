#include "./blake3_hash.h"

extern void blake3_hash(const void* data, const size_t len, uint8_t hash[BLAKE3_OUT_LEN])
{
    static blake3_hasher hasher;
    blake3_hasher_init(&hasher);
    blake3_hasher_update(&hasher, data, len);
    blake3_hasher_finalize(&hasher, hash, BLAKE3_OUT_LEN);
}
