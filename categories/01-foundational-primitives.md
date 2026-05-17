# Foundational Primitives


<!-- TOC -->
## Contents (64 schemes)

**[Symmetric Ciphers](#symmetric-ciphers)**
- [Symmetric Encryption](#symmetric-encryption)
- [Asymmetric (Public-Key) Encryption](#asymmetric-public-key-encryption)
- [Pseudorandom Functions (PRF) & Pseudorandom Permutations (PRP)](#pseudorandom-functions-prf--pseudorandom-permutations-prp)
- [Pseudorandom Generators (PRG)](#pseudorandom-generators-prg)
- [ChaCha8Rand (C2SP CSPRNG)](#chacha8rand-c2sp-csprng)
- [Sponge Construction / Duplex](#sponge-construction--duplex)
- [Lightweight Cryptography / ASCON](#lightweight-cryptography--ascon)
- [Feistel Networks (Luby-Rackoff Construction)](#feistel-networks-luby-rackoff-construction)
- [Block Cipher Modes of Operation](#block-cipher-modes-of-operation)
- [Block-Cipher-Based Hash Compression Functions](#block-cipher-based-hash-compression-functions)
- [Hardware-Oriented Stream Ciphers (eSTREAM / 3GPP)](#hardware-oriented-stream-ciphers-estream--3gpp)
- [Tweakable Block Ciphers (LRW / XEX / XTS)](#tweakable-block-ciphers-lrw--xex--xts)
- [Even-Mansour Construction](#even-mansour-construction)
- [RC4 Stream Cipher (Historical)](#rc4-stream-cipher-historical)
- [Software-Oriented eSTREAM Stream Ciphers (Rabbit / HC-128)](#software-oriented-estream-stream-ciphers-rabbit--hc-128)
- [Whirlpool and Tiger Hash Functions](#whirlpool-and-tiger-hash-functions)
- [Lai-Massey Structure and IDEA Cipher](#lai-massey-structure-and-idea-cipher)
- [Extendable Output Functions (XOF)](#extendable-output-functions-xof)
- [Constant-Time Implementations and Timing Attack Mitigations](#constant-time-implementations-and-timing-attack-mitigations)
- [Double PRF and Related-Key Attack Resistance](#double-prf-and-related-key-attack-resistance)
- [PRESENT, GIFT, and SKINNY (Lightweight Block Ciphers)](#present-gift-and-skinny-lightweight-block-ciphers)
- [ARX Ciphers (Add-Rotate-XOR Design Paradigm)](#arx-ciphers-add-rotate-xor-design-paradigm)
- [Wide Block Ciphers (Adiantum / HCTR2)](#wide-block-ciphers-adiantum--hctr2)
- [Threefish and Skein (SHA-3 Finalist)](#threefish-and-skein-sha-3-finalist)
- [Legacy Block Ciphers (Pre-AES Historical)](#legacy-block-ciphers-pre-aes-historical)
- [Legacy Stream Ciphers (Pre-eSTREAM Historical)](#legacy-stream-ciphers-pre-estream-historical)

**[Public-Key Encryption](#public-key-encryption)**
- [One-Time Pad / Information-Theoretic Security](#one-time-pad--information-theoretic-security)
- [Trapdoor Functions / Trapdoor Permutations](#trapdoor-functions--trapdoor-permutations)
- [Universal Hash Functions (Carter-Wegman)](#universal-hash-functions-carter-wegman)
- [Universal One-Way Hash Functions (UOWHF)](#universal-one-way-hash-functions-uowhf)
- [Fujisaki-Okamoto Transform](#fujisaki-okamoto-transform)
- [SipHash](#siphash)
- [Wegman-Carter MAC (One-Time and Multi-Use)](#wegman-carter-mac-one-time-and-multi-use)
- [Non-Cryptographic Hash Functions (FNV / MurmurHash / xxHash)](#non-cryptographic-hash-functions-fnv--murmurhash--xxhash)
- [Authenticated Encryption Security Models](#authenticated-encryption-security-models)
- [ElGamal Encryption over Groups](#elgamal-encryption-over-groups)
- [Paillier Cryptosystem (Additive Homomorphic Encryption)](#paillier-cryptosystem-additive-homomorphic-encryption)
- [Multi-Prime RSA and RSA-CRT](#multi-prime-rsa-and-rsa-crt)
- [Montgomery Arithmetic and Barrett Reduction](#montgomery-arithmetic-and-barrett-reduction)

**[Hash Functions](#hash-functions)**
- [Hash Functions](#hash-functions)
- [Message Authentication Codes (MAC)](#message-authentication-codes-mac)
- [Randomness Extractors](#randomness-extractors)
- [Correlation-Intractable Hash Functions](#correlation-intractable-hash-functions)
- [ZK-Friendly Hash Functions (Arithmetization-Oriented)](#zk-friendly-hash-functions-arithmetization-oriented)
- [Password Hashing & Memory-Hard KDFs](#password-hashing--memory-hard-kdfs)
- [HKDF (Extract-and-Expand Key Derivation)](#hkdf-extract-and-expand-key-derivation)
- [Merkle-Damgård Construction](#merkle-damgård-construction)
- [TupleHash / ParallelHash (NIST SP 800-185)](#tuplehash--parallelhash-nist-sp-800-185)
- [SequenceHash and SequenceMAC (C2SP)](#sequencehash-and-sequencemac-c2sp)
- [RIPEMD-160](#ripemd-160)
- [Keccak-p Permutation](#keccak-p-permutation)
- [BLAKE2 Hash Function Internals](#blake2-hash-function-internals)
- [Ascon (NIST Lightweight AEAD and Hashing Winner)](#ascon-nist-lightweight-aead-and-hashing-winner)
- [TurboSHAKE and MarsupilamiFourteen](#turboshake-and-marsupilamifourteen)
- [Correlation-Robust Hash Functions](#correlation-robust-hash-functions)

**[Digital Signatures](#digital-signatures)**
- [Digital Signatures](#digital-signatures)
- [Batch Verification](#batch-verification)

**[Pseudorandom Primitives](#pseudorandom-primitives)**
- [Puncturable / Constrained PRF](#puncturable--constrained-prf)
- [Key-Homomorphic PRF](#key-homomorphic-prf)
- [DRBG (Deterministic Random Bit Generators)](#drbg-deterministic-random-bit-generators)
- [Legendre PRF](#legendre-prf)

**[Extractors and Information-Theoretic Primitives](#extractors-and-information-theoretic-primitives)**
- [Fuzzy Extractors / Secure Sketches](#fuzzy-extractors--secure-sketches)

**[Trapdoor and Structural Primitives](#trapdoor-and-structural-primitives)**
- [Ristretto255 / Decaf (Prime-Order Group Abstractions)](#ristretto255--decaf-prime-order-group-abstractions)
- [jq255 (jq255e and jq255s Prime-Order Groups)](#jq255-jq255e-and-jq255s-prime-order-groups)

<!-- /TOC -->

## Symmetric Ciphers

---
### Symmetric Encryption

**Goal:** Confidentiality. Encrypt data with a single shared secret key so that only those who know the key can read it.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **AES-256** | 2001 | Block cipher | De-facto standard (NIST), 128-bit block, 256-bit key [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **ChaCha20** | 2008 | Stream cipher | Fast in software, constant-time; used in TLS 1.3, WireGuard [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf) |
| **Salsa20** | 2005 | Stream cipher | Predecessor to ChaCha20, eSTREAM portfolio [[1]](https://cr.yp.to/snuffle/salsafamily-20071225.pdf) |
| **Serpent** | 1998 | Block cipher | AES finalist, conservative security margin [[1]](https://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf) |
| **Camellia** | 2000 | Block cipher | ISO/IEC standard, comparable to AES [[1]](https://tools.ietf.org/html/rfc3713) |

**State of the art:** AES-256 (hardware-accelerated via [[1]](https://en.wikipedia.org/wiki/AES_instruction_set) AES-NI) and ChaCha20 for software-only environments.

**Production readiness:** Production
Deployed at scale in TLS 1.3, WireGuard, disk encryption (BitLocker, FileVault), and virtually every modern protocol.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-NI accelerated, ubiquitous
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ChaCha20/Salsa20, misuse-resistant API
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, Google's OpenSSL fork with ChaCha20-Poly1305
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, embedded-focused TLS with AES/ChaCha20

**Security status:** Secure
AES-256 and ChaCha20 have no known practical attacks at recommended parameters. Salsa20 and Serpent are also unbroken.

**Community acceptance:** Standard
AES is NIST FIPS 197; ChaCha20 is IETF RFC 8439; Camellia is ISO/IEC 18033-3. All are broadly endorsed.

---

### Asymmetric (Public-Key) Encryption

**Goal:** Confidentiality without pre-shared keys. A sender encrypts with the recipient's public key; only the recipient's private key can decrypt.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **RSA-OAEP** | 1977 | Integer factorization | First practical PKE; 2048+ bit keys recommended [[1]](https://dl.acm.org/doi/10.1145/359340.359342) |
| **ECIES** | 2001 | Elliptic Curve Diffie-Hellman | Hybrid: ECDH + symmetric enc; compact keys [[1]](https://eprint.iacr.org/1999/007) |
| **DHIES / DHAES** | 1999 | Diffie-Hellman | Provably CCA2-secure hybrid scheme [[1]](https://shoup.net/papers/iso-2_1.pdf) |
| **Cramer-Shoup** | 1998 | DDH | First practical CCA2-secure scheme without random oracles [[1]](https://eprint.iacr.org/1998/008) |
| **HPKE** | 2022 | Hybrid KEM/DEM | Modern standard (RFC 9180): KEM + AEAD + KDF [[1]](https://www.rfc-editor.org/rfc/rfc9180) |

**State of the art:** HPKE (RFC 9180) with X25519 KEM + [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) AES-256-GCM — used in TLS Encrypted Client Hello, MLS, OHTTP.

**Production readiness:** Production
RSA-OAEP and ECIES are deployed at massive scale; HPKE is in TLS ECH, MLS, and OHTTP.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA-OAEP, ECIES, HPKE (3.2+)
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, HPKE used in Chrome ECH
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, crypto_box (X25519+XSalsa20-Poly1305)
- [hpke-rs](https://github.com/cryspen/hpke-rs) ⭐ 48 — Rust, RFC 9180 implementation

**Security status:** Secure
RSA-OAEP requires 2048+ bit keys; ECIES and HPKE are secure at recommended parameters. Cramer-Shoup provides CCA2 without random oracles.

**Community acceptance:** Standard
RSA-OAEP is PKCS#1/NIST; HPKE is IETF RFC 9180; ECIES is IEEE 1363a and SECG SEC 1.

---

### Pseudorandom Functions (PRF) & Pseudorandom Permutations (PRP)

**Goal:** Security foundation. A PRF is indistinguishable from a truly random function; a PRP from a random permutation. Underlies MACs, KDFs, stream ciphers, OT, and garbled circuits.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGM PRF** | 1986 | PRG tree | First PRF from any one-way function; tree construction [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **Naor-Reingold PRF** | 1997 | DDH / EC | Efficient number-theoretic construction [[1]](https://dl.acm.org/doi/10.1145/258533.258592) |
| **AES as PRP** | 2001 | Block cipher | De-facto standard PRP instantiation [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **HMAC as PRF** | 1996 | Hash (NMAC) | Proven PRF assuming compression fn is PRF [[1]](https://csrc.nist.gov/publications/detail/fips/198/1/final) |

**State of the art:** AES-128/256 (PRP, hardware-accelerated), HMAC-SHA256 (PRF in software).

**Production readiness:** Production
AES as PRP and HMAC as PRF are deployed in virtually every cryptographic system worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES and HMAC with hardware acceleration
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, AES-NI optimized PRP/PRF
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, HMAC-SHA256/512 as PRF

**Security status:** Secure
AES as PRP is secure under the standard-model PRP assumption; HMAC-SHA256 is a provably secure PRF. GGM and Naor-Reingold are foundational constructions with no known attacks.

**Community acceptance:** Standard
AES is NIST FIPS 197; HMAC is NIST FIPS 198-1. GGM and Naor-Reingold are foundational theoretical constructions widely cited in the literature.

---

### Pseudorandom Generators (PRG)

**Goal:** Stretch randomness. A PRG takes a short truly random seed and outputs a longer string indistinguishable from random. The most basic cryptographic primitive — PRFs, stream ciphers, commitments, and ZK all build on PRGs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum-Micali PRG** | 1984 | DLP | First PRG from discrete log; output = hard-core bit of g^x [[1]](https://dl.acm.org/doi/10.1145/800057.808667) |
| **Blum-Blum-Shub (BBS)** | 1986 | Quadratic residuosity | x_{n+1} = x_n² mod N; provably secure under factoring [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_8) |
| **GGM PRG→PRF** | 1986 | Any PRG | PRG is sufficient to build PRF (tree construction); see [PRF](#pseudorandom-functions-prf--pseudorandom-permutations-prp) [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **AES-CTR as PRG** | 2001 | Block cipher in CTR mode | Practical: AES in counter mode is a fast PRG [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **ChaCha20 as PRG** | 2008 | Stream cipher | ChaCha20(key, counter) outputs pseudorandom stream; see [Symmetric Encryption](#symmetric-encryption) [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf) |

**State of the art:** AES-CTR / ChaCha20 (practical PRGs), Blum-Micali (theoretical foundation). PRG → PRF → PRP is the fundamental hierarchy of pseudorandomness.

**Production readiness:** Production
AES-CTR and ChaCha20 as PRGs are deployed at scale in TLS, DRBG, and OS entropy systems.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-CTR-DRBG as PRG
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ChaCha20 stream as PRG
- [Linux kernel CSPRNG](https://github.com/torvalds/linux) ⭐ 225k — C, ChaCha20-based /dev/urandom

**Security status:** Secure
AES-CTR and ChaCha20 are secure PRGs. BBS is provably secure under factoring but too slow for practice. Blum-Micali is secure under DLP.

**Community acceptance:** Standard
AES-CTR is NIST SP 800-38A; ChaCha20 is RFC 8439. The PRG→PRF→PRP hierarchy is a foundational result in theoretical cryptography.

---

### ChaCha8Rand (C2SP CSPRNG)

**Goal:** Fast key-erasure CSPRNG with near non-cryptographic speed. Designed by Russ Cox / Filippo Valsorda as the default source for Go's `math/rand/v2` and `runtime` packages. Accepts a 32-byte seed, operates on 289 bytes of state, can serialize to 33 bytes (forward-secret after at most 992 additional output bytes). Optimized for 128/256/512-bit SIMD vectorization.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ChaCha8Rand** | 2024 | ChaCha8 + fast key erasure | C2SP spec; each iteration produces 992 RNG bytes + 32 chain bytes via reduced-round ChaCha8 [[1]](https://c2sp.org/chacha8rand) [[2]](https://go.dev/issue/61716) |

**State of the art:** ChaCha8Rand (2024) is the default math/rand/v2 source in Go 1.22+. Reduces ChaCha20 to 8 rounds (still cryptographically secure at this output volume) and uses a custom permutation/subtraction step to match SIMD layout. Replaces previous non-CSPRNG `math/rand` source; preserves forward secrecy. See [Pseudorandom Generators (PRG)](#pseudorandom-generators-prg).

**Production readiness:** Production
Ships in Go 1.22+ standard library (`math/rand/v2`, `runtime`); used everywhere Go random numbers are drawn. Third-party Rust/Swift/Odin ports exist.

**Implementations:**
- [golang/go](https://github.com/golang/go) ⭐ 134k — Go, reference implementation in `runtime` and `math/rand/v2`
- [hanna-kruppe/chacha8rand](https://github.com/hanna-kruppe/chacha8rand) ⭐ 2 — Rust port
- [nixberg/chacha8rand-rs](https://github.com/nixberg/chacha8rand-rs) ⭐ 1 — Rust port
- [C2SP/CCTV](https://github.com/C2SP/CCTV) ⭐ 101 — test vectors

**Security status:** Secure
8-round ChaCha provides ample security margin at the 992-byte output budget per iteration; forward secrecy under fast key erasure. No known attacks. Reviewed by Filippo Valsorda and Go cryptography team.

**Community acceptance:** Emerging
Default in Go since 1.22 (2024); C2SP-blessed spec; not yet an IETF/NIST RFC but rapidly establishing as the modern CSPRNG default for Go ecosystem.

---

### Sponge Construction / Duplex

**Goal:** Versatile primitive. A single permutation-based construction that can serve as hash, MAC, stream cipher, AEAD, PRG, and KDF — all from one core design. Replaces the need for separate block-cipher modes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sponge Construction** | 2007 | Permutation | Absorb input, squeeze output; basis of SHA-3 (Keccak) [[1]](https://keccak.team/files/SpongeFunctions.pdf) |
| **Duplex Construction** | 2010 | Permutation | Online variant: interleave absorb/squeeze for authenticated encryption [[1]](https://keccak.team/files/SpongeDuplex.pdf) |
| **Keccak / SHA-3** | 2012 | 1600-bit permutation | NIST SHA-3 standard (FIPS 202); 24-round Keccak-f [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **STROBE** | 2017 | Keccak-f[1600] | Protocol framework: one sponge instance handles all symmetric operations [[1]](https://strobe.sourceforge.io/papers/strobe-20170130.pdf) |
| **Xoodyak** | 2020 | Xoodoo permutation | Lightweight duplex; NIST LWC finalist for constrained devices [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/xoodyak-spec-final.pdf) |

**State of the art:** SHA-3/Keccak (FIPS 202) dominant; STROBE for protocol-level use; Xoodyak for IoT. The sponge paradigm underpins most modern permutation-based crypto.

**Production readiness:** Production
SHA-3/Keccak is a NIST standard deployed in TLS, ML-KEM, and ML-DSA. STROBE is used in some protocols. Xoodyak was a NIST LWC finalist.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, official Keccak team reference with optimized permutations
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, SHA-3 and SHAKE
- [tiny_sha3](https://github.com/mjosaarinen/tiny_sha3) ⭐ 227 — C, minimal SHA-3 for embedded
- [STROBE](https://strobe.sourceforge.io/) — C, protocol framework on Keccak

**Security status:** Secure
No practical attacks on full-round Keccak-f[1600] (24 rounds). Best attacks reach 7-8 of 24 rounds. The sponge construction has strong provable security in the random permutation model.

**Community acceptance:** Standard
Keccak/SHA-3 is NIST FIPS 202. The sponge construction is endorsed by the Keccak team and adopted by NIST for SHA-3, SHAKE, and the SP 800-185 derived functions.

---

### Lightweight Cryptography / ASCON

**Goal:** Secure encryption and hashing for constrained devices. AES is too heavy for many IoT microcontrollers. Lightweight ciphers provide AEAD and hashing with minimal gate count, RAM, and energy — without sacrificing security.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ASCON** | 2019 | Sponge / permutation | **NIST LWC standard (2023)**; AEAD + hash; 320-bit state, tiny footprint [[1]](https://ascon.iaik.tugraz.at/) |
| **GIFT-COFB** | 2020 | Block cipher (GIFT-128) | Combined feedback mode; NIST LWC finalist [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/gift-cofb-spec-final.pdf) |
| **PHOTON-Beetle** | 2020 | Sponge (PHOTON) | Lightweight AEAD + hash; NIST LWC finalist [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/photon-beetle-spec-final.pdf) |
| **PRESENT** | 2007 | SPN block cipher | 64-bit block, 80/128-bit key; ISO/IEC 29192-2 standard [[1]](https://link.springer.com/chapter/10.1007/978-3-540-74735-2_31) |
| **SIMON / SPECK** | 2013 | Feistel / ARX | NSA designs for IoT; SIMON (hardware), SPECK (software) [[1]](https://eprint.iacr.org/2013/404) |

**State of the art:** ASCON (NIST standard 2023); designed for constrained devices (see also [Sponge Construction](#sponge-construction--duplex) for the underlying paradigm).

**Production readiness:** Production
ASCON is the NIST Lightweight Cryptography standard (2023). PRESENT is ISO-standardized. SIMON/SPECK are deployed in some IoT contexts.

**Implementations:**
- [Ascon](https://github.com/ascon/ascon-c) ⭐ 276 — C, official reference implementation
- [SIMON/SPECK](https://github.com/nsacyber/simon-speck-supercop) ⭐ 50 — C, NSA reference implementations
- [PRESENT](https://github.com/Pepton21/present-cipher) ⭐ 8 — C/Python, reference implementations

**Security status:** Secure
ASCON has no known practical attacks on full rounds. PRESENT and GIFT are unbroken. SIMON/SPECK are cryptanalytically sound but their NSA origin raises concerns for some users.

**Community acceptance:** Standard
ASCON is NIST SP 800-232 (2023). PRESENT is ISO/IEC 29192-2. SIMON/SPECK are controversial due to NSA origin and lack of design rationale, but have passed extensive third-party cryptanalysis.

---

### Feistel Networks (Luby-Rackoff Construction)

**Goal:** Build a secure block cipher (PRP) from a simpler round function. A Feistel network splits a block into two halves and alternates XOR-with-round-function across rounds. The Luby-Rackoff theorem proves this is sufficient: 3 rounds from a PRF yield a PRP; 4 rounds yield a strong PRP (SPRP). The construction underpins DES, Blowfish, Twofish, CAST, Camellia, and dozens of other block ciphers.

**Round structure (one round):**
```
(L, R) → (R,  L ⊕ F(K_i, R))
```
Repeat for r rounds, then swap the final halves. Decryption uses the same structure with subkeys in reverse order — the round function F need not be invertible.

| Cipher | Year | Rounds | Note |
|--------|------|--------|------|
| **DES** | 1977 | 16 | First widely deployed Feistel cipher; 56-bit key (retired) [[1]](https://csrc.nist.gov/publications/detail/fips/46/3/archive/1999-10-25) |
| **Blowfish** | 1993 | 16 | 64-bit block, up to 448-bit key; still used in bcrypt [[1]](https://www.schneier.com/academic/blowfish/) |
| **Twofish** | 1998 | 16 | AES finalist; 128-bit block, 128/192/256-bit key; MDS matrix mixing [[1]](https://www.schneier.com/academic/twofish/) |
| **Luby-Rackoff (abstract)** | 1988 | 3–4 | Theoretical foundation: PRF → PRP (3 rounds) / SPRP (4 rounds) [[1]](https://dl.acm.org/doi/10.1145/12130.12162) |

**State of the art:** AES (SPN) has displaced Feistel ciphers in new designs, but Feistel construction remains theoretically important via the Luby-Rackoff theorem and is widely deployed (3DES legacy, Blowfish in bcrypt). See [Pseudorandom Functions (PRF)](#pseudorandom-functions-prf--pseudorandom-permutations-prp).

**Production readiness:** Deprecated
DES is retired; 3DES is deprecated (NIST 2023). Blowfish survives in bcrypt. Twofish is available but rarely chosen over AES. The Luby-Rackoff theorem remains theoretically foundational.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, DES, 3DES, Blowfish (legacy)
- [bcrypt](https://github.com/pyca/bcrypt) ⭐ 1.5k — Python/C, Blowfish-based password hashing
- [Twofish](https://www.schneier.com/academic/twofish/) — reference C implementation

**Security status:** Caution
DES (56-bit key) is broken by brute force. 3DES has a 64-bit block birthday-bound issue (SWEET32). Blowfish has a 64-bit block limit. Twofish is unbroken but not widely deployed. The Luby-Rackoff construction itself is provably secure.

**Community acceptance:** Standard
The Luby-Rackoff theorem is a foundational result. DES was NIST FIPS 46 (withdrawn). 3DES is NIST SP 800-67 (deprecated 2023). AES has superseded Feistel ciphers for new designs.

---

### Block Cipher Modes of Operation

**Goal:** Extend a block cipher (which encrypts exactly one fixed-size block) to encrypt arbitrary-length messages, optionally providing authentication. The mode determines how successive plaintext blocks interact with each other, the key, and a nonce/IV.

**Confidentiality-only modes (NIST SP 800-38A):**

| Mode | Year | Property | Note |
|------|------|----------|------|
| **ECB** (Electronic Codebook) | 1981 | Deterministic | Identical plaintext blocks → identical ciphertext blocks; **never use** [[1]](https://csrc.nist.gov/pubs/sp/800/38/a/final) |
| **CBC** (Cipher Block Chaining) | 1981 | Sequential | C_i = E_K(P_i ⊕ C_{i-1}); IV must be random; parallelizable decrypt only [[1]](https://csrc.nist.gov/pubs/sp/800/38/a/final) |
| **CTR** (Counter) | 1979 | Parallelizable | E_K(nonce ∥ counter) ⊕ P_i; turns block cipher into stream cipher [[1]](https://csrc.nist.gov/pubs/sp/800/38/a/final) |
| **OFB** (Output Feedback) | 1981 | Keystream-based | Keystream independent of plaintext; single-bit errors don't propagate [[1]](https://csrc.nist.gov/pubs/sp/800/38/a/final) |
| **CFB** (Cipher Feedback) | 1981 | Self-synchronising | Error propagation limited; rarely preferred today [[1]](https://csrc.nist.gov/pubs/sp/800/38/a/final) |

**Authenticated Encryption with Associated Data (AEAD) modes:**

| Mode | Year | Basis | Note |
|------|------|-------|------|
| **GCM** (Galois/Counter Mode) | 2004 | CTR + GHASH | NIST SP 800-38D; dominant AEAD; hardware-accelerated [[1]](https://csrc.nist.gov/pubs/sp/800/38/d/final) |
| **CCM** (Counter + CBC-MAC) | 2004 | CTR + CBC-MAC | NIST SP 800-38C; used in 802.11i (WPA2), TLS, IoT [[1]](https://csrc.nist.gov/pubs/sp/800/38/c/upd1/final) |
| **EAX** | 2004 | CTR + OMAC | Two-pass; patent-free; used in OpenPGP [[1]](https://eprint.iacr.org/2003/069) |
| **OCB** (Offset Codebook) | 2001 | Single-pass | Fastest AEAD; 1-pass; RFC 7253; patent-free since 2021 [[1]](https://www.rfc-editor.org/rfc/rfc7253) |
| **AES-GCM-SIV** | 2017 | SIV + POLYVAL | Nonce-misuse resistant; RFC 8452; safe if nonce repeated [[1]](https://www.rfc-editor.org/rfc/rfc8452) |
| **XTS-AES** | 2010 | Tweakable block cipher | NIST SP 800-38E; disk/storage encryption (FileVault, BitLocker) [[1]](https://csrc.nist.gov/pubs/sp/800/38/e/final) |

**State of the art:** AES-GCM (internet, TLS 1.3, most cloud APIs); CCM (embedded/IoT); XTS-AES (disk encryption); AES-GCM-SIV for nonce-misuse-resistant settings. CTR underlies most stream-cipher-style use of AES. See [Symmetric Encryption](#symmetric-encryption) and [Sponge Construction](#sponge-construction--duplex) for alternative approaches.

**Production readiness:** Production
AES-GCM is the dominant AEAD in TLS 1.3, cloud APIs, and networking. XTS-AES is in BitLocker, FileVault, and LUKS. CBC is ubiquitous in legacy systems.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, all modes (ECB, CBC, CTR, GCM, CCM, XTS, OCB, GCM-SIV)
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, AES-GCM and AES-GCM-SIV
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, AES-256-GCM (hardware-accelerated)
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, AES modes for embedded/FIPS

**Security status:** Caution
ECB must never be used. CBC requires random IVs and is vulnerable to padding oracle attacks if not combined with MAC (encrypt-then-MAC). CTR/GCM/CCM are secure with unique nonces. AES-GCM-SIV is nonce-misuse resistant.

**Community acceptance:** Standard
NIST SP 800-38A (confidentiality modes), SP 800-38D (GCM), SP 800-38C (CCM), SP 800-38E (XTS). AES-GCM-SIV is RFC 8452. OCB is RFC 7253.

---

### Block-Cipher-Based Hash Compression Functions

**Goal:** Build a one-way compression function from a block cipher. These constructions turn a block cipher E_K(M) into a collision-resistant compression function h(H, M) by wiring the chaining value and message block into the cipher's key and plaintext ports in different ways. They underlie SHA-1 and SHA-2 (Davies-Meyer with a dedicated cipher), and are provably secure when E is an ideal cipher.

**The twelve Preneel-Govaerts-Vandewalle constructions** reduce to three canonical families with optimal collision resistance:

| Construction | Formula | Used in | Note |
|-------------|---------|---------|------|
| **Davies-Meyer** | h = E_{M_i}(H_{i-1}) ⊕ H_{i-1} | SHA-1, SHA-256, SHA-512 | Message is the key; chaining value is plaintext [[1]](https://en.wikipedia.org/wiki/One-way_compression_function) |
| **Matyas-Meyer-Oseas** | h = E_{H_{i-1}}(M_i) ⊕ M_i | Whirlpool variant | Chaining value is the key; message is plaintext [[1]](https://en.wikipedia.org/wiki/One-way_compression_function) |
| **Miyaguchi-Preneel** | h = E_{H_{i-1}}(M_i) ⊕ M_i ⊕ H_{i-1} | Whirlpool | Combines both XOR inputs; stronger feed-forward [[1]](https://en.wikipedia.org/wiki/One-way_compression_function) |
| **Hirose double-block** | 2006 variant | — | Two-pass; double-length output; provably secure in ideal cipher [[1]](https://eprint.iacr.org/2006/090) |

**Security note:** Davies-Meyer allows computation of fixed points (H such that E_H(h) ⊕ h = h), but no practical attack exploits this.

**State of the art:** Davies-Meyer + Merkle-Damgård is the backbone of SHA-2 (SHA-256/512). Miyaguchi-Preneel underlies Whirlpool. For new designs the sponge construction (see [Sponge Construction](#sponge-construction--duplex)) is preferred over block-cipher-based compression.

**Production readiness:** Production
Davies-Meyer is inside SHA-1, SHA-256, and SHA-512 — deployed in billions of devices. Miyaguchi-Preneel is in Whirlpool (ISO standard).

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, SHA-256/512 uses Davies-Meyer internally
- [mbedtls](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C, SHA-2 with Davies-Meyer compression
- [Whirlpool](https://www.larc.usp.br/~pbarreto/WhirlpoolPage.html) — C, Miyaguchi-Preneel reference

**Security status:** Secure
Davies-Meyer is provably collision-resistant in the ideal cipher model. All three canonical constructions (Davies-Meyer, Matyas-Meyer-Oseas, Miyaguchi-Preneel) are secure when instantiated with a strong block cipher.

**Community acceptance:** Standard
Davies-Meyer is the implicit standard via SHA-2 (NIST FIPS 180-4). The Preneel-Govaerts-Vandewalle analysis is a foundational result in hash function theory.

---

### Hardware-Oriented Stream Ciphers (eSTREAM / 3GPP)

**Goal:** High-speed encryption in hardware-constrained environments — mobile chipsets, network ASICs, smart cards — where AES-CTR carries too much gate-count overhead. These stream ciphers are designed specifically for hardware gate efficiency and/or 3GPP radio standards.

| Cipher | Year | Architecture | Note |
|--------|------|-------------|------|
| **Trivium** | 2006 | 3 shift registers (288-bit state) | eSTREAM Profile 2 (hardware); 80-bit key; ~3500 gates; parallelisable [[1]](https://link.springer.com/chapter/10.1007/978-3-540-68351-3_18) |
| **Grain v1** | 2006 | LFSR + NLFSR (160-bit state) | eSTREAM Profile 2; 80-bit key; ultra-low area [[1]](https://eprint.iacr.org/2011/068) |
| **Grain-128a** | 2011 | LFSR + NLFSR + MAC | 128-bit key; adds authentication; eSTREAM portfolio [[1]](https://eprint.iacr.org/2011/068) |
| **SNOW 3G** | 2006 | LFSR + FSM | 3GPP UEA2/UIA2 (UMTS); 128-bit key; confidentiality + integrity in 4G [[1]](https://www.gsma.com/security/wp-content/uploads/2019/05/SNOW_3G_specification_1.1.pdf) |
| **ZUC (祖冲之)** | 2011 | LFSR + FSM + NL | 3GPP 128-EEA3/128-EIA3 (LTE/5G); 128-bit key; Chinese national standard (GM/T 0001) [[1]](https://www.gsma.com/security/wp-content/uploads/2019/05/ZUC_specification_3.pdf) |
| **ZUC-256** | 2019 | Extended ZUC | 256-bit key variant; 5G security [[1]](https://eprint.iacr.org/2022/634) |

**eSTREAM Portfolio (2008):** Profile 1 (software): HC-128, Rabbit, Salsa20/12, SOSEMANUK. Profile 2 (hardware): Grain v1, MICKEY v2, Trivium.

**State of the art:** ZUC and SNOW 3G are mandatory 3GPP ciphers in all 4G LTE and 5G deployments. Trivium and Grain are reference hardware designs. For software use, ChaCha20 (see [Symmetric Encryption](#symmetric-encryption)) dominates.

**Production readiness:** Production
ZUC and SNOW 3G are deployed in every 4G/5G base station and handset globally. Trivium is a reference hardware stream cipher.

**Implementations:**
- [3GPP reference implementations](https://www.3gpp.org/) — C, SNOW 3G and ZUC for UEA2/UIA2 and EEA3/EIA3
- [Trivium/Grain](https://www.ecrypt.eu.org/stream/) — C, eSTREAM reference implementations
- [libsnow](https://github.com/TheSilverBoy/libsnow) ⭐ 1 — C, SNOW 3G reference

**Security status:** Secure
SNOW 3G, ZUC, and Trivium have no known practical attacks at full strength. ZUC-256 extends to 256-bit security for 5G. Grain-128a adds authentication.

**Community acceptance:** Standard
SNOW 3G and ZUC are 3GPP TS 35.201/35.221 standards, mandatory in all LTE/5G deployments. Trivium and Grain are in the eSTREAM portfolio (2008). ZUC is also a Chinese national standard (GM/T 0001).

---

### Tweakable Block Ciphers (LRW / XEX / XTS)

**Goal:** Block cipher with a public per-invocation parameter (the "tweak") that changes the permutation without a full re-keying. Tweaks allow the same key to produce independent permutations for each disk sector, packet sequence number, or message index — eliminating codebook attacks and enabling parallelizable, nonce-based modes.

**Formalization:** Liskov, Rivest, and Wagner (Crypto 2002) defined a tweakable block cipher as a family Ẽ(K, T, ·) where K is the secret key and T is the public tweak; security requires Ẽ(K, T₁, ·) and Ẽ(K, T₂, ·) to be independent random permutations for T₁ ≠ T₂.

| Construction | Year | Formula | Note |
|-------------|------|---------|------|
| **LRW1 / LRW2** | 2002 | E_K(x ⊕ f(T)) or E_K(x) ⊕ f(T) | Liskov-Rivest-Wagner; birthday-bound secure; first formal definition [[1]](https://link.springer.com/article/10.1007/s00145-010-9073-y) |
| **XEX** (xor-encrypt-xor) | 2004 | E_K(x ⊕ T·Δ) ⊕ T·Δ | Rogaway; single-key; tweak via GF(2¹²⁸) multiplication; efficient [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/nonce.pdf) |
| **XTS-AES** | 2010 | XEX with sector/index tweak | NIST SP 800-38E; IEEE P1619; disk encryption standard (BitLocker, FileVault, VeraCrypt) [[1]](https://csrc.nist.gov/pubs/sp/800/38/e/final) |
| **SKINNY** | 2016 | Dedicated TBC | Tweakable lightweight cipher; NIST LWC; TWEAKEY framework [[1]](https://eprint.iacr.org/2016/660) |
| **Deoxys-BC** | 2016 | Dedicated TBC | TWEAKEY-based; AES-like; used in Deoxys-II (CAESAR winner) [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |

**XTS-AES note:** The XEX tweak encodes sector address and block index via the field element Δ = E_K(i) · α^j (α primitive in GF(2¹²⁸)). Only encrypts full blocks; the last partial block uses ciphertext stealing. Provides no authentication — must be combined with a MAC or used in a verified-boot context.

**State of the art:** XTS-AES (NIST SP 800-38E / IEEE P1619) is the universal disk-encryption standard. SKINNY and Deoxys-BC are the reference dedicated TBCs. Tweakable block ciphers underlie OCB, PMAC, and virtually all modern AEAD designs.

**Production readiness:** Production
XTS-AES is in BitLocker, FileVault, VeraCrypt, and LUKS. SKINNY and Deoxys-BC are used in NIST LWC candidates.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-XTS
- [Linux dm-crypt](https://gitlab.com/cryptsetup/cryptsetup) — C, XTS-AES for LUKS disk encryption
- [SKINNY](https://sites.google.com/site/skinaboretx/) — C, reference TBC implementation

**Security status:** Secure
XTS-AES is secure for disk encryption (no authentication). LRW has birthday-bound security. SKINNY and Deoxys-BC are unbroken on full rounds. XTS does not provide authentication; relies on verified boot or external integrity checks.

**Community acceptance:** Standard
XTS-AES is NIST SP 800-38E and IEEE P1619. The tweakable block cipher formalization (Liskov-Rivest-Wagner 2002) is a widely cited theoretical foundation. SKINNY is an academic reference TBC.

---

### Even-Mansour Construction

**Goal:** Simplest provably secure block cipher. Build a pseudorandom permutation from a single public random permutation P (available to all parties) by XOR-ing secret keys before and after: E_K(x) = P(x ⊕ k₁) ⊕ k₂. Achieves optimal birthday-bound security n/2 bits with minimal secret material — the theoretical foundation for AES-like constructions and iterated permutation-based ciphers.

**Construction variants:**

| Variant | Year | Formula | Security | Note |
|---------|------|---------|----------|------|
| **Even-Mansour (2-key)** | 1991 | P(x ⊕ k₁) ⊕ k₂ | n/2 bits | Original; minimal keyed cipher from public permutation [[1]](https://link.springer.com/chapter/10.1007/3-540-57220-1_60) |
| **Single-key Even-Mansour** | 2012 | P(x ⊕ k) ⊕ k | n/2 bits | k₁ = k₂; same security; simplest possible PRP [[1]](https://eprint.iacr.org/2011/541.pdf) |
| **Iterated Even-Mansour (r rounds)** | 2012 | r applications of P_i with independent round keys | rn/(r+1) bits | Foundation of AES-like round structure [[1]](https://eprint.iacr.org/2012/620) |
| **Tweakable Even-Mansour (TEM)** | 2015 | Round keys derived from key ⊕ f(tweak) | Beyond-birthday | Underlies SKINNY, Deoxys-BC [[1]](https://eprint.iacr.org/2015/363) |

**Why it matters:** The 12-round iterated Even-Mansour construction (with independent public permutations and a key schedule) is indifferentiable from an ideal cipher. AES can be modeled as a 10/12/14-round iterated Even-Mansour cipher; this view justifies AES's security in the ideal cipher model and connects block cipher design to permutation-based cryptography.

**Attacks:** Best attack on single-key Even-Mansour requires qE·qP ≈ 2ⁿ queries (information-theoretic lower bound); no sub-birthday attack is possible. The multi-key setting (Biryukov-Khovratovich 2015) gives ≈ 2^(n/2)/√u security against u users — relevant for TLS where millions of keys share the same protocol.

**State of the art:** Even-Mansour provides the theoretical security foundation for AES and all modern SPN block ciphers. The tweakable variant underlies SKINNY/Deoxys (NIST LWC). See [Feistel Networks](#feistel-networks-luby-rackoff-construction) for the analogous result for Feistel ciphers.

**Production readiness:** Research
Foundational theoretical construction; not deployed as a standalone cipher but instantiated via AES and SKINNY/Deoxys.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES (the primary Even-Mansour instantiation) with AES-NI
- [SKINNY-C](https://github.com/AsmOptC-RiscV/Assembly-Optimized-C-RiscV) ⭐ 16 — C, SKINNY tweakable block cipher (tweakable Even-Mansour)

**Security status:** Secure
Proven optimal birthday-bound security (n/2 bits) in the ideal permutation model; iterated variants achieve beyond-birthday security.

**Community acceptance:** Widely trusted
Foundational result in block cipher theory; universally cited in provable security literature; underlies AES security proofs in the ideal cipher model.

---

### RC4 Stream Cipher (Historical)

**Goal:** Fast software stream cipher. RC4 (Rivest Cipher 4) was the dominant stream cipher for two decades: used in SSL/TLS, WEP, WPA-TKIP, PDF, and SSH. Its byte-at-a-time output and minimal code size made it ubiquitous in embedded and software environments. It is now fully broken and prohibited in all new protocols.

| Variant | Year | Key size | Note |
|---------|------|----------|------|
| **RC4 (ARC4)** | 1987 | 40–2048 bit | Alleged RC4; 256-byte S-box state; Fluhrer-Mantin-Shamir (2001) attack cracks WEP [[1]](https://link.springer.com/chapter/10.1007/3-540-45537-X_1) |
| **RC4-drop[n]** | 2006 | — | Drop first n bytes (typically 256 or 3072) of keystream to mitigate bias; insufficient [[1]](https://eprint.iacr.org/2005/007) |
| **WEP** | 1999 | 40/104 bit | 802.11 protocol using RC4; IV reuse + FMS attack → key recovery in minutes; **deprecated** [[1]](https://link.springer.com/chapter/10.1007/3-540-45537-X_1) |
| **BEAST / POODLE / RC4 in TLS** | 2011–2015 | — | Series of attacks on RC4 in TLS; RFC 7465 (2015) **prohibits RC4 in TLS** [[1]](https://www.rfc-editor.org/rfc/rfc7465) |

**Why it failed:** RC4's key-scheduling algorithm (KSA) produces biased initial keystream bytes and short-cycle weaknesses. The keystream byte at position 2 is biased toward 0 with probability 2/256 instead of 1/256. Statistical attacks accumulate bias across many sessions to recover plaintexts. Additionally, if two messages share an IV (as in WEP), XOR of ciphertexts reveals XOR of plaintexts.

**State of the art:** RC4 is fully prohibited — RFC 7465 bans it in TLS; NIST and IETF documentation mark it deprecated. For stream encryption use ChaCha20 (see [Symmetric Encryption](#symmetric-encryption)) or AES-CTR (see [Block Cipher Modes of Operation](#block-cipher-modes-of-operation)).

**Production readiness:** Deprecated
Prohibited in TLS (RFC 7465), WEP deprecated, WPA-TKIP deprecated. Must not be used in any new system.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RC4 retained for legacy compatibility only; disabled by default in modern builds

**Security status:** Broken
Keystream biases enable plaintext recovery in TLS within ~2^26 sessions (AlFardan-Bernstein-Paterson-Poettering-Schuldt 2013). WEP key recovery in minutes via FMS attack.

**Community acceptance:** Standard
RFC 7465 formally prohibits RC4 in TLS. NIST deprecates RC4. Universal consensus that RC4 must not be used.

---

### Software-Oriented eSTREAM Stream Ciphers (Rabbit / HC-128)

**Goal:** High-throughput software stream encryption with small state and simple implementation. The eSTREAM competition (2004–2008) Profile 1 selected stream ciphers optimized for general-purpose CPUs, filling the gap between AES-CTR (slower on non-AES-NI hardware) and ChaCha20 (which did not yet exist). These designs achieve 2–4 cycles/byte on 32-bit platforms.

| Cipher | Year | State | Note |
|--------|------|-------|------|
| **Rabbit** | 2003 | 128-bit state + 64-bit IV | eSTREAM Profile 1 finalist; 8 counters + 8 state words; ~3.7 cycles/byte on x86; RFC 4503 [[1]](https://www.rfc-editor.org/rfc/rfc4503) |
| **HC-128** | 2004 | 4 KB (two 512-entry tables) | eSTREAM Profile 1 winner; ~3.05 cycles/byte (x86); 128-bit key, 128-bit IV [[1]](https://link.springer.com/chapter/10.1007/978-3-540-68351-3_9) |
| **HC-256** | 2004 | 8 KB (two 1024-entry tables) | Higher-security variant; 256-bit key, 256-bit IV; slower but large-table ensures no algebraic shortcuts [[1]](https://eprint.iacr.org/2004/092) |
| **SOSEMANUK** | 2005 | 160-bit LFSR + 32-bit FSM | eSTREAM Profile 1 winner; Serpent-derived S-box; fast in software [[1]](https://eprint.iacr.org/2005/028) |

**eSTREAM Profile 1 portfolio (2008):** HC-128, Rabbit, Salsa20/12, SOSEMANUK — all selected for software environments. Salsa20 and ChaCha20 ultimately displaced all others due to constant-time, cache-timing-resistant ARX design and wider adoption.

**State of the art:** HC-128 and Rabbit remain unbroken but are rarely used in new systems. ChaCha20 (see [Symmetric Encryption](#symmetric-encryption)) has superseded all eSTREAM Profile 1 ciphers for software use, owing to its simpler implementation, vectorization, and TLS 1.3 adoption.

**Production readiness:** Deprecated
Functionally superseded by ChaCha20. Rabbit has RFC 4503 but minimal deployment; HC-128 and SOSEMANUK have no significant production use.

**Implementations:**
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, Rabbit, HC-128, SOSEMANUK
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, Rabbit (RFC 4503)

**Security status:** Superseded
All ciphers remain cryptographically unbroken at full rounds, but superseded by ChaCha20 which offers better constant-time properties and wider ecosystem support.

**Community acceptance:** Niche
eSTREAM portfolio recognition but no NIST or broad IETF standardization beyond RFC 4503 (Rabbit). Salsa20/ChaCha20 captured all adoption.

---

### Whirlpool and Tiger Hash Functions

**Goal:** Legacy cryptographic hashes designed as alternatives to SHA-1/SHA-2 with independent security analysis. Whirlpool (ISO/IEC 10118-3) produces 512-bit digests from a Miyaguchi-Preneel construction over a dedicated AES-inspired block cipher. Tiger was designed for 64-bit platforms and became widely used in P2P file-sharing via Tiger Tree Hash (TTH).

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Whirlpool** | 2003 | Miyaguchi-Preneel + W block cipher | 512-bit output; 10-round W cipher; ISO/IEC 10118-3:2004; designed by Barreto & Rijmen [[1]](https://www.larc.usp.br/~pbarreto/whirlpool.zip) |
| **Tiger** | 1995 | 3-pass Davies-Meyer style | 192-bit output (3×64-bit); 24 rounds; designed for 64-bit CPUs; Ross Anderson & Eli Biham [[1]](https://www.cl.cam.ac.uk/~rja14/Papers/tiger.pdf) |
| **Tiger2** | 2003 | Tiger + revised padding | Revised padding compatible with MD-strengthening; recommended over Tiger [[1]](https://www.cl.cam.ac.uk/~rja14/Papers/tiger.pdf) |
| **Tiger Tree Hash (TTH)** | 1998 | Merkle tree over Tiger | Root of a binary Merkle tree hashing 1 KB leaves with Tiger; used in eD2k, DC++, THEX [[1]](https://www.open-content.net/specs/draft-jchapweske-thex-02.html) |

**Whirlpool:** W is an AES-like cipher with 8×8 bytes, 10 rounds, a different S-box (π), and a 512-bit block. The Miyaguchi-Preneel feed-forward (h ← E_m(h) ⊕ m ⊕ h) provides strong second-preimage resistance. No practical collision or preimage attack; cryptanalysis reaches at most 9.5/10 rounds.

**Tiger:** Three 8×8 lookup tables (s-boxes) provide diffusion; three passes over the message with different multipliers. Designed to be fast on 64-bit Alphas. Practical collision attacks on Tiger up to 19/23 rounds (Mendel-Rijmen 2006), but the full 23-round Tiger has no known practical collision. TTH is truncated to 192 bits (three 64-bit words), often encoded as base32 magnet links.

**State of the art:** Whirlpool is an ISO/IEC standard and unbroken; rarely used in new designs. Tiger/TTH was standard in early 2000s P2P networks (eD2k, DC++); superseded by SHA-1/SHA-256 tree hashes. New designs should use [Hash Functions](#hash-functions) (BLAKE3 for tree hashing, SHA-3/SHA-256 for general use).

**Production readiness:** Deprecated
Whirlpool is ISO-standardized but rarely deployed in new systems. Tiger/TTH is legacy P2P only. Both superseded by SHA-2/SHA-3/BLAKE.

**Implementations:**
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, Whirlpool and Tiger
- [Botan](https://github.com/randombit/botan) ⭐ 3.2k — C++, Whirlpool
- [RHash](https://github.com/rhash/RHash) ⭐ 706 — C, Tiger, TTH, Whirlpool

**Security status:** Superseded
No practical collision on full-round Whirlpool or Tiger, but both are superseded by SHA-2/SHA-3/BLAKE for all use cases.

**Community acceptance:** Niche
Whirlpool is ISO/IEC 10118-3; Tiger has no formal standard. Neither is recommended by NIST or IETF for new deployments.

---

### Lai-Massey Structure and IDEA Cipher

**Goal:** Alternative block cipher structure providing full diffusion with provable algebraic properties. The Lai-Massey scheme (1990) uses a mix of operations from incompatible algebraic groups — XOR (addition in Z₂ⁿ), addition mod 2^16, and multiplication mod 2^16+1 — to achieve complete diffusion with no component being a linear operation over any other's field. IDEA (International Data Encryption Algorithm) instantiates this structure and was the dominant cipher in PGP 2.x and OpenPGP legacy implementations.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **IDEA (International Data Encryption Algorithm)** | 1991 | Lai-Massey, mixed-algebraic | 64-bit block, 128-bit key, 8.5 rounds; PGP 2.x default; ISO/IEC 18033-3 [[1]](https://link.springer.com/chapter/10.1007/3-540-54508-8_24) |
| **IDEA NXT (FOX)** | 2004 | Lai-Massey + SPN | 64 or 128-bit block; improved design by Junod-Vaudenay [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_8) |
| **SAFER / SAFER+** | 1993 | Lai-Massey variant | Used in Bluetooth (E0 cipher stack); byte-level operations [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_26) |

**Lai-Massey structure:** Unlike Feistel (which splits the block into halves and XORs) or SPN (which applies a global nonlinear layer), Lai-Massey applies a half-round function H and XOR-then-adds between left and right halves: `L' = L ⊕ H(L ⊕ R)`, `R' = R ⊕ H(L ⊕ R)`. The three incompatible operations (⊕, +, ×) prevent simple algebraic attacks that work against uniform-field structures. The multiplication mod (2^16 + 1) in IDEA has been particularly resistant to differential and linear attacks.

**Security status:** IDEA (64-bit block) is legacy — 64-bit block ciphers are vulnerable to birthday-bound attacks at ~32 GB data (SWEET32, 2016). No practical key-recovery attack on full 8.5-round IDEA is known, but block size limits modern use.

**State of the art:** IDEA is standardized in ISO/IEC 18033-3 and supported in OpenPGP (RFC 4880) as a legacy cipher; prohibited in TLS since RFC 7525. New designs should use AES or ChaCha20. The Lai-Massey construction remains theoretically significant and appears in IDEA NXT/FOX. See [Feistel Networks](#feistel-networks-luby-rackoff-construction) for the analogous Feistel theory.

**Production readiness:** Deprecated
IDEA was the default cipher in PGP 2.x; prohibited in TLS (RFC 7525). 64-bit block size makes it unsafe for bulk encryption. Legacy only.

**Implementations:**
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, IDEA
- [Botan](https://github.com/randombit/botan) ⭐ 3.2k — C++, IDEA (legacy support)
- [GnuPG](https://github.com/gpg/gnupg) ⭐ 906 — C, IDEA in OpenPGP legacy mode

**Security status:** Superseded
No practical key-recovery attack on full 8.5-round IDEA, but the 64-bit block size is vulnerable to birthday-bound attacks (SWEET32) at ~32 GB of data.

**Community acceptance:** Niche
ISO/IEC 18033-3; historically important but fully superseded by AES. IDEA patents expired in 2012. Lai-Massey structure remains of theoretical interest.

---

### Extendable Output Functions (XOF)

**Goal:** Variable-length pseudorandom output from a hash-like primitive. An XOF absorbs input of any length and then squeezes out an arbitrary number of output bytes, behaving like a keyed (or unkeyed) stream cipher seeded by the input. XOFs replace the need for separate PRG, KDF, and challenge-generation primitives in ZK proof systems, key derivation, and stream encryption.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **SHAKE128** | 2015 | Keccak sponge, 128-bit security | FIPS 202; capacity 256 bits; squeeze unlimited bytes; used in ML-KEM, NTRU [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **SHAKE256** | 2015 | Keccak sponge, 256-bit security | FIPS 202; capacity 512 bits; squeeze unlimited bytes; used in ML-DSA, SLH-DSA [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **TurboSHAKE128 / TurboSHAKE256** | 2023 | Keccak-p[1600, 12] | Reduced-round (12 vs 24) Keccak; ~2× faster; IETF draft [[1]](https://eprint.iacr.org/2023/342) |
| **KangarooTwelve (K12)** | 2016 | TurboSHAKE128 + tree | Parallel tree over 8 KB chunks; ~4× faster than SHA-3; IETF RFC 9560 [[1]](https://www.rfc-editor.org/rfc/rfc9560) |
| **BLAKE2X** | 2016 | BLAKE2b/s + XOF mode | Variable output from BLAKE2; parameter block encodes desired output length [[1]](https://www.blake2.net/blake2x.pdf) |
| **BLAKE3 (unlimited output)** | 2020 | Merkle tree + XOF | Counter-based tree extension; squeeze any length after initial 32-byte output [[1]](https://github.com/BLAKE3-team/BLAKE3-specs/blob/master/blake3.pdf) |

**Squeeze mechanics (SHAKE):** After absorbing all input, the sponge is in a "squeezing" phase. Each invocation of Keccak-f extracts `rate` bits from the state and continues. The caller can request any number of output bytes — there is no inherent length limit. Output bytes beyond the capacity are as hard to distinguish from random as a fixed-length hash.

**Distinguishing XOF from fixed-length hash:** A 256-bit SHA-3 output is a truncated SHAKE256 output. Using SHAKE256 directly avoids the truncation, enables domain separation via `cSHAKE256`, and allows the output length to be a protocol parameter rather than a constant.

**Used in:** ML-KEM (SHAKE128/256 for key generation and encapsulation), ML-DSA (SHAKE256 throughout), Kyber/Dilithium (SHAKE), ZK proof transcript generation (Fiat-Shamir via SHAKE), KDF in HPKE (LabeledExpand via SHAKE), libsodium `crypto_stream_xchacha20` analog via BLAKE3.

**State of the art:** SHAKE128/256 (FIPS 202) are the standardized XOFs; KangarooTwelve (RFC 9560) is the performance champion. BLAKE3's unlimited output is the fastest XOF on modern CPUs with SIMD. All NIST PQC standards (ML-KEM, ML-DSA, SLH-DSA) rely on SHAKE as their core XOF. See [Sponge Construction / Duplex](#sponge-construction--duplex) and [Hash Functions](#hash-functions).

**Production readiness:** Production
SHAKE128/256 are in all NIST PQC standards (ML-KEM, ML-DSA, SLH-DSA); KangarooTwelve is RFC 9560; BLAKE3 XOF is widely deployed.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, SHAKE128/256, KangarooTwelve reference
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, SHAKE128/256 (3.0+)
- [BLAKE3](https://github.com/BLAKE3-team/BLAKE3) ⭐ 6.1k — Rust/C, unlimited output mode

**Security status:** Secure
SHAKE128/256 based on full 24-round Keccak; KangarooTwelve uses 12 rounds with comfortable margin. All have no known practical attacks.

**Community acceptance:** Standard
SHAKE is NIST FIPS 202; KangarooTwelve is IETF RFC 9560; BLAKE3 XOF is widely trusted but not NIST-standardized.

---

### Constant-Time Implementations and Timing Attack Mitigations

**Goal:** Prevent secret information from leaking through execution time, cache access patterns, or power consumption. Even a mathematically secure scheme is broken in practice if the implementation branches on secret values or accesses memory in secret-dependent patterns. Timing attacks (Kocher 1996) and cache-timing attacks (Bernstein 2005) have broken RSA, AES, ECDSA, and AES-GCM in deployed software.

| Technique | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Kocher timing attack** | 1996 | Timing side-channel | RSA decryption time reveals private exponent bits via branch prediction and multiplication latency [[1]](https://link.springer.com/chapter/10.1007/3-540-68697-5_9) |
| **Cache-timing attack (Bernstein AES)** | 2005 | Cache side-channel | AES table-lookup timing reveals key; `AES_encrypt` in OpenSSL was vulnerable [[1]](https://cr.yp.to/antiforgery/cachetiming-20050414.pdf) |
| **Constant-time comparison** | — | cmov / branchless | Use bitwise operations to compare without data-dependent branches; `crypto_verify_32` pattern [[1]](https://bearssl.org/constanttime.html) |
| **Bitsliced AES** | 2009 | Boolean circuit | Represent AES S-box as bitwise ops; no table lookups; constant time on all CPUs; Käsper-Schwabe [[1]](https://eprint.iacr.org/2009/129) |
| **AES-NI hardware acceleration** | 2010 | Hardware instruction | Intel/AMD AESENC/AESD/AESKEYGENASSIST; single-cycle S-box; inherently constant-time; CLMULQDQ for GHASH [[1]](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-advanced-encryption-standard-instructions-aes-ni.html) |
| **Leakage-resilient crypto (CHES)** | 2008 | Masking / shuffling | Mask intermediate values with random shares; provably limits leakage per operation [[1]](https://eprint.iacr.org/2008/482) |
| **CTGRIND / ct-verif** | 2010s | Static analysis | Tools (ct-verif, dudect, ctgrind) check constant-time properties at binary or IR level [[1]](https://eprint.iacr.org/2016/1123) |

**Key rules for constant-time code:**
- No secret-dependent branches (`if (secret)`) — use `cmov` or branchless bitwise selection
- No secret-dependent memory indices (array[secret_bit]) — use linear scans or bitslicing
- No variable-latency instructions on secret operands (integer divide on secret values on some CPUs)
- Compiler optimizations can reintroduce branches — use `volatile`, compiler barriers, or assembly

**AES-NI:** The `AESENC` instruction (Intel Sandy Bridge, 2010; AMD Bulldozer, 2011) executes one AES round in a single CPU cycle, eliminating table lookups entirely and providing constant-time execution at ~0.6 cycles/byte for AES-128-GCM with pipelining. `CLMULQDQ` provides constant-time GF(2¹²⁸) multiplication for GHASH. Together they make AES-GCM the fastest AEAD on modern x86.

**State of the art:** AES-NI + CLMULQDQ is the gold standard for constant-time, high-performance AES-GCM. On non-AES-NI platforms, bitsliced AES (Käsper-Schwabe) or ChaCha20 (inherently constant-time ARX) are preferred. The CHES masking literature provides provable leakage bounds. See [Symmetric Encryption](#symmetric-encryption) and [Montgomery Arithmetic](#montgomery-arithmetic-and-barrett-reduction).

**Production readiness:** Production
Constant-time coding practices and AES-NI are mandatory in all production cryptographic libraries (OpenSSL, BoringSSL, libsodium, NSS).

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C/Assembly, AES-NI, constant-time RSA/ECC
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, designed for constant-time from the ground up
- [BearSSL](https://bearssl.org/) — C, explicitly constant-time TLS library
- [dudect](https://github.com/oreparaz/dudect) ⭐ 201 — C, statistical timing leak detection tool

**Security status:** Secure
When correctly implemented, constant-time code eliminates timing and cache side channels. Verification tools (ct-verif, dudect) provide assurance. AES-NI provides hardware-guaranteed constant-time AES.

**Community acceptance:** Standard
Constant-time implementation is a universal requirement in production cryptographic code. AES-NI is an Intel/AMD standard instruction set extension.

---

### Double PRF and Related-Key Attack Resistance

**Goal:** Strengthen a PRF or block cipher against related-key attacks — adversarial queries where the adversary can obtain outputs under keys that are related to the target key by known offsets or transforms. Double PRF applies two independent PRF calls (with independent keys) to increase effective key entropy and eliminate algebraic key structure that RKA exploits. Relevant to key wrapping, multi-user security, and AES usage in protocols.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Double PRF (2PRF)** | 2003 | Cascaded PRF | F_{K1}(F_{K2}(x)); adds a full PRF layer; secure even if one key is related-key-attacked [[1]](https://eprint.iacr.org/2003/174) |
| **Related-Key Attack on AES-192/256** | 2009 | Differential RKA | Biryukov-Khovratovich: AES-256 broken in RKA model in 2^99.5; AES-128 remains secure [[1]](https://eprint.iacr.org/2009/317) |
| **RKA-secure PRF (Bellare-Cash)** | 2010 | Algebraic hardness | Formal model; security under polynomial RKA functions; construction from DDH [[1]](https://eprint.iacr.org/2010/471) |
| **3DES (Triple DES)** | 1998 | EDE with 2 or 3 keys | Enc_{K1}(Dec_{K2}(Enc_{K1}(x))) — a Double-Encrypt pattern; NIST SP 800-67 (deprecated 2023) [[1]](https://csrc.nist.gov/publications/detail/sp/800/67/r2/final) |
| **HMAC double-wrap** | — | HMAC outer/inner keys | HMAC's ipad/opad construction is a two-key derivation protecting against length-extension and related-key variants on the underlying hash [[1]](https://csrc.nist.gov/publications/detail/fips/198/1/final) |

**Related-key attacks (RKA):** In the standard model, an adversary queries F(K, ·); in the RKA model they also query F(K ⊕ Δ, ·) for chosen Δ values. AES-256's key schedule was found to have algebraic structure enabling differential RKA with 2^99.5 complexity (Biryukov-Khovratovich 2009), dramatically below brute force. AES-128 has no known RKA distinguisher. The attack matters for protocols that derive related subkeys from a master key without domain separation.

**Double PRF protection:** If F₁ and F₂ are independently keyed PRFs, then G(K₁∥K₂, x) = F₁(K₁, F₂(K₂, x)) is secure in the RKA model even if one of the PRFs leaks under RKA — the independent key prevents correlated attacks. Key wrapping (NIST SP 800-38F, AES-KW) uses a similar two-key philosophy.

**State of the art:** AES-128 is preferred over AES-256 in RKA-sensitive contexts (AES-128 has no known RKA weakness). HMAC's two-key derivation remains standard. Double PRF (independent keys) is the practical mitigation for protocols needing RKA resistance; see [Puncturable / Constrained PRF](#puncturable--constrained-prf) for key delegation, and [Key Exchange & KDFs](03-key-exchange-key-management.md) for key derivation patterns.

**Production readiness:** Mature
Double PRF concepts are embedded in HMAC and key wrapping (AES-KW), though rarely deployed as a standalone primitive. RKA-secure PRF is primarily theoretical.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-KW (key wrapping with double-key philosophy)
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, HMAC (inherent double-key construction)

**Security status:** Secure
AES-128 has no known RKA weakness. AES-256 has a 2^99.5 related-key attack (Biryukov-Khovratovich 2009) — theoretical, not practical, but motivates domain-separated key derivation.

**Community acceptance:** Niche
RKA resistance is a well-studied theoretical concept; practically addressed through proper key derivation (HKDF, NIST SP 800-108) rather than explicit double PRF deployment.

---

### PRESENT, GIFT, and SKINNY (Lightweight Block Ciphers)

**Goal:** Ultra-compact block ciphers optimized for hardware implementation in area-constrained environments (RFID tags, smart cards, sensor nodes), achieving security in as few logic gates as possible.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **PRESENT** | 2007 | Block cipher | 64-bit block, 80/128-bit key; 31-round SPN; ISO/IEC 29192-2; ~1570 GE in hardware [[1]](https://link.springer.com/chapter/10.1007/978-3-540-74735-2_31) |
| **GIFT-128** | 2017 | Block cipher | 128-bit block, 128-bit key; 40-round SPN; improved PRESENT with better diffusion and efficiency; basis of GIFT-COFB (NIST LWC finalist) [[1]](https://eprint.iacr.org/2017/622) |
| **SKINNY** | 2016 | Tweakable block cipher | 64/128-bit block; lightweight tweakable cipher based on TWEAKEY framework; designed as a "competition for SIMON" [[1]](https://eprint.iacr.org/2016/660) |
| **Midori** | 2015 | Block cipher | 64/128-bit block; optimized for low energy consumption (not just area); uses almost-MDS matrices [[1]](https://eprint.iacr.org/2015/1142) |

**State of the art:** PRESENT is the ISO standard for lightweight block ciphers. GIFT-COFB was a NIST LWC finalist (lost to Ascon). SKINNY is widely used in academic constructions and as a building block for MACs and AEAD modes (e.g., Romulus, another NIST LWC finalist). See [Lightweight Symmetric Primitives](#symmetric-encryption).

**Production readiness:** Mature
PRESENT is ISO-standardized and deployed in constrained hardware. SKINNY and GIFT are used in academic AEAD constructions; GIFT-COFB and Romulus were NIST LWC finalists.

**Implementations:**
- [SKINNY-C](https://github.com/AsmOptC-RiscV/Assembly-Optimized-C-RiscV) ⭐ 16 — C, SKINNY reference and optimized
- [GIFT reference](https://github.com/giftcipher/gift) ⭐ 13 — C, GIFT-128 reference
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, PRESENT

**Security status:** Secure
No practical attacks on full rounds of PRESENT, GIFT-128, or SKINNY at recommended parameters. PRESENT's 64-bit block limits data volume (birthday bound).

**Community acceptance:** Niche
PRESENT is ISO/IEC 29192-2. GIFT and SKINNY are well-studied in the academic community and NIST LWC process but not broadly standardized as standalone primitives.

---

### ARX Ciphers (Add-Rotate-XOR Design Paradigm)

**Goal:** Design fast, efficient symmetric primitives using only addition, rotation, and XOR — no lookup tables, making them naturally constant-time and suitable for software and FPGAs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Salsa20 / ChaCha20** | 2005/2008 | ARX stream cipher | IETF RFC 7539/8439 [[1]](https://datatracker.ietf.org/doc/html/rfc8439) |
| **BLAKE2 / BLAKE3** | 2012/2020 | ARX hash/PRF | Fastest secure hash in software [[2]](https://blake3.io) |
| **SPECK** | 2013 | ARX block cipher | NSA lightweight design, software-optimized [[3]](https://eprint.iacr.org/2013/404.pdf) |
| **Chaskey** | 2014 | ARX MAC | ISO/IEC 29192-6, microcontroller MAC [[4]](https://mouha.be/chaskey/) |

**State of the art:** ChaCha20-Poly1305 is the dominant TLS 1.3 cipher suite on non-AES hardware (mobile, IoT). BLAKE3 is the fastest cryptographic hash in benchmarks. ARX designs dominate when AES-NI is unavailable.

**Production readiness:** Production
Deployed at massive scale — ChaCha20-Poly1305 in TLS 1.3, BLAKE3 in production storage systems and package managers.

**Implementations:**
- [chacha20poly1305 (RustCrypto)](https://github.com/RustCrypto/stream-ciphers) ⭐ 664 — Rust, IETF-compliant, no_std
- [BLAKE3 reference](https://github.com/BLAKE3-team/BLAKE3) ⭐ 5.2k — Rust/C, multithreaded tree hashing
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ChaCha20/BLAKE2 production library

**Security status:** Secure
No known structural weaknesses. ChaCha20 has 256-bit security, BLAKE3 256-bit collision resistance. SPECK has some academic differential/linear analysis but no practical breaks at full rounds.

**Community acceptance:** Widely trusted
ChaCha20 standardized in RFC 8439. BLAKE3 widely adopted by major projects. IETF, NIST, and industry endorse these designs.

---

### Wide Block Ciphers (Adiantum / HCTR2)

**Goal:** Encrypt disk sectors and arbitrary-length data with a tweakable wide-block cipher that provides strong security without requiring AES hardware, suitable for low-end Android and embedded devices.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Adiantum** | 2018 | ChaCha12 + Poly1305 + AES | Android 9+ on low-end devices [[1]](https://eprint.iacr.org/2018/720.pdf) |
| **HCTR2** | 2021 | XCTR + GHASH | Android 12+ preferred wide-block cipher [[2]](https://eprint.iacr.org/2021/1441.pdf) |
| **HPolyC** | 2018 | Hash-then-encrypt (ChaCha20) | Predecessor to Adiantum [[3]](https://eprint.iacr.org/2018/720.pdf) |

**State of the art:** HCTR2 supersedes Adiantum on devices with AES instructions; Adiantum remains standard for Cortex-A5/A7 class devices without AES-NI. Both are deployed in the Linux kernel and Android. See [AES-XTS (Disk Encryption)](#aes-xts-and-disk-encryption).

**Production readiness:** Production
Adiantum shipped in Android 9 (2018) for low-end devices; HCTR2 added in Android 12 / Linux 5.17 (2022). Tens of millions of devices.

**Implementations:**
- [adiantum (Linux kernel)](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) ⭐ 190k — C, upstream kernel crypto
- [adiantum-rs](https://github.com/google/adiantum) ⭐ 279 — Rust, Google reference implementation
- [hctr2 (Linux kernel)](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) ⭐ 190k — C, mainline since 5.17

**Security status:** Secure
Adiantum proven secure as a super-pseudorandom permutation under standard assumptions. HCTR2 has improved security proof. No known attacks.

**Community acceptance:** Widely trusted
Google-designed, peer-reviewed at FSE/IACR, deployed in AOSP and mainline Linux.

---

### Threefish and Skein (SHA-3 Finalist)

**Goal:** Provide a large-state tweakable block cipher (Threefish) and a flexible hash function family (Skein) built on it, targeting 256/512/1024-bit security levels with a clean ARX design.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threefish-256/512/1024** | 2008 | ARX tweakable block cipher | Core primitive of Skein [[1]](https://www.skein-hash.info/sites/default/files/skein1.3.pdf) |
| **Skein-256/512/1024** | 2008 | UBI chaining + Threefish | SHA-3 finalist, NIST competition [[2]](https://www.skein-hash.info) |
| **Skein-MAC / Skein-KDF** | 2008 | Tree/sequential modes | Built-in MAC, KDF, PRNG modes |

**State of the art:** Skein did not win SHA-3 (Keccak did), but remains a respected design. Threefish is used in some niche applications requiring large tweakable block ciphers. Not widely deployed but well-analyzed.

**Production readiness:** Mature
Well-studied reference implementations exist. Used in some niche applications (e.g., Whirlpool alternatives, custom PKIs), but not mainstream.

**Implementations:**
- [skein (RustCrypto)](https://github.com/RustCrypto/hashes) ⭐ 1.9k — Rust, pure implementation
- [sphlib](https://www.saphir2.com/sphlib/) — C, reference from SHA-3 competition
- [bcgit/bc-java](https://github.com/bcgit/bc-java) ⭐ 2.3k — Java, Bouncy Castle includes Skein/Threefish

**Security status:** Secure
No known practical attacks on full-round Threefish or Skein at recommended parameters. Third-party cryptanalysis found no weaknesses.

**Community acceptance:** Niche
Strong academic reputation as SHA-3 finalist. Not standardized post-competition. Limited adoption outside security research.

---

### Legacy Block Ciphers (Pre-AES Historical)

**Goal:** Reference catalog of pre-AES block ciphers that appear in cryptanalysis literature, legacy protocols, and "Applied Cryptography" (Schneier). Most are either broken, superseded by AES, or retained only for backward compatibility.

| Cipher | Year | Designer | Block / Key | Status |
|--------|------|----------|-------------|--------|
| **Lucifer** | 1971 | Feistel (IBM) | 128/128 | Direct DES precursor; partially broken (Biham-Shamir DC) [[1]](https://www.iacr.org/cryptodb/data/paper.php?pubkey=20034) |
| **Madryga** | 1984 | Madryga | variable | Bit-orientation novel; broken by Biham-Shamir 1991 [[1]](https://link.springer.com/chapter/10.1007/3-540-46416-6_18) |
| **NewDES** | 1985 | Scott | 64/120 | DES alternative without S-boxes; key-schedule weaknesses; not adopted [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_25) |
| **FEAL-4/8/N/NX** | 1987 | Shimizu-Miyaguchi (NTT) | 64/64 (FEAL-N: 64/128) | First target of differential cryptanalysis; FEAL-4 broken with 8 chosen pairs; FEAL-N broken for all N [[1]](https://link.springer.com/chapter/10.1007/3-540-46877-3_2) |
| **REDOC II / III** | 1990 | Wood | 80/160-bit / 70/varying | Patented (Cryptech); REDOC II reduced rounds broken; REDOC III obscure [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_23) |
| **Khufu / Khafre** | 1990 | Merkle (Xerox) | 64/512 | Khufu: S-boxes from key; Khafre: fixed S-boxes; Biham-Shamir DC breaks reduced rounds [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_22) |
| **LOKI89 / LOKI91 / LOKI97** | 1990–1997 | Brown-Pieprzyk-Seberry (Australia) | 64/64 or 128/256 | DES alternative; LOKI89 broken by DC; LOKI97 broken by Knudsen-Rijmen [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_22) |
| **MMB (Modular Multiplication-Based)** | 1993 | Daemen | 128/128 | IDEA-style modular multiplication; broken by Wagner 1995 (related-key) [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_22) |
| **SAFER K-64 / K-128 / SK / + / ++** | 1993–1998 | Massey (Cylink) | 64/64 or 128/128 | SAFER+ was AES candidate; SAFER++ in Bluetooth E0/E1 derivation; key-schedule attacks on early variants [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_2) |
| **Skipjack** | 1993 (declass. 1998) | NSA | 64/80 | Designed for Clipper chip; unbalanced Feistel; reduced-round impossible-differential breaks (Biham-Biryukov-Shamir 1999) [[1]](https://www.iacr.org/archive/eurocrypt99/15920012/15920012.pdf) |
| **3-Way** | 1994 | Daemen-Govaerts-Vandewalle | 96/96 | Bit-slice friendly; related-key attacks [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_24) |
| **GOST 28147-89** | 1989 | Soviet government | 64/256 | Soviet/Russian standard; weak keys; analyzed in [GOST R Block Cipher](21-regional-national-cryptography.md) |
| **CAST-128 (CAST5) / CAST-256** | 1996/1998 | Adams-Tavares | 64/128 or 128/256 | CAST-128 in RFC 2144 (used in OpenPGP, GnuPG); CAST-256 was AES candidate [[1]](https://www.rfc-editor.org/rfc/rfc2144) |
| **RC2** | 1987/1996 | Rivest (RSA Inc.) | 64/8–1024 | Designed as DES drop-in; export-controlled at 40 bits; broken at 40-bit by brute force in hours; RFC 2268 [[1]](https://www.rfc-editor.org/rfc/rfc2268) |
| **RC5** | 1994 | Rivest | 32/64/128 / 0–2040 | Variable-parameter ARX-style cipher; family of designs; basis for RC6 (AES candidate); Distributed.net RC5-64 broken in 2002 [[1]](https://people.csail.mit.edu/rivest/Rivest-rc5rev.pdf) |
| **SXAL8 / MBAL** | 1993 | Hitachi | 64/64 (SXAL) | Japanese substitution-XOR-add-look ciphers; obscure; reduced-round breaks [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_26) |
| **CA-1.1** | 1991 | Gutowitz | 384/1088 | Cellular automaton-based; obscure, no widely-cited break [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_30) |
| **CRAB** | 1993 | Kaliski-Robshaw (RSA Labs) | 8192/varying | Hash-function-based block cipher experiment; never deployed [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_27) |

**State of the art:** All these ciphers are retired in favor of [AES](#symmetric-encryption). Skipjack was an interesting NSA case study (Clipper chip controversy). FEAL is the classical example used in cryptanalysis courses since it motivated differential cryptanalysis. SAFER+ influenced Bluetooth E0/E1 key derivation. RC5's ARX style influenced ChaCha20 and Speck. See [Differential Cryptanalysis](22-attacks-cryptanalysis.md#differential-cryptanalysis-biham-shamir) and [Linear Cryptanalysis](22-attacks-cryptanalysis.md#linear-cryptanalysis-matsuis-attack) for the analytical techniques that ended this generation.

**Production readiness:** Deprecated
Universally retired from new designs. CAST-128 remains in OpenPGP for legacy compatibility; Skipjack appeared in some US-government legacy systems before deprecation in 2010.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, includes CAST-128, RC2, RC5 (legacy modules)
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.1k — C++, reference implementations of most legacy ciphers (SAFER, MARS, CAST, GOST, IDEA, Skipjack)
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.8k — Java, comprehensive legacy cipher support
- [GnuPG](https://gnupg.org/) — C, CAST-128 (RFC 2440 legacy compatibility)

**Security status:** Broken
FEAL-N (all rounds), Madryga, MMB, LOKI89, REDOC II reduced-round all have practical breaks. RC2-40 is brute-forceable. Skipjack 31-round reduced version has impossible-differential attacks; full 32-round Skipjack has no practical break but 80-bit key is below modern minimum. RC5 with 64-bit blocks is vulnerable to SWEET32-style birthday attacks.

**Community acceptance:** Deprecated
NIST removed Skipjack from approved algorithms in 2016. CAST-128 retained in RFC 2144 for OpenPGP legacy. All others are textbook examples only; no new deployments since ~2001 (AES standardization).

---

### Legacy Stream Ciphers (Pre-eSTREAM Historical)

**Goal:** Reference catalog of pre-eSTREAM (pre-2008) stream ciphers — GSM voice encryption, archive encryption, hardware-oriented designs that appear in legacy protocols, "Applied Cryptography" (Schneier), and stream cipher cryptanalysis literature.

| Cipher | Year | Designer | State / Key | Status |
|--------|------|----------|-------------|--------|
| **A5/1** | 1987 | ETSI (GSM) | 64 bits across 3 LFSRs / 54-bit effective | GSM voice over Europe/US; broken by Biryukov-Shamir-Wagner (2000) real-time attack; Karsten Nohl rainbow tables (2009) [[1]](https://link.springer.com/chapter/10.1007/3-540-44706-7_1) |
| **A5/2** | 1989 | ETSI | weakened A5/1 | Export-grade GSM; trivially broken (Goldberg-Wagner-Briceno 1999); banned by 3GPP in 2007 [[1]](https://link.springer.com/chapter/10.1007/978-3-540-39887-5_5) |
| **A5/3 (KASUMI)** | 1999 | ETSI/3GPP | 64-bit block (used as stream) / 128 | UMTS/3G/2.5G; related-key sandwich attack (Dunkelman-Keller-Shamir 2010) gives theoretical full-key break but not practical for UMTS deployment [[1]](https://eprint.iacr.org/2010/013) |
| **E0 (Bluetooth)** | 1999 | Bluetooth SIG | 128-bit state / 128 | Combiner of 4 LFSRs; Lu-Meier-Vaudenay 2005 broke with 2^39 known keystream [[1]](https://link.springer.com/chapter/10.1007/11535218_8) |
| **RC4** | 1987 (1994 leak) | Rivest (RSA) | 2048-bit state / 40–2048 | Used in WEP, TLS, SSH-1; broken by FMS attack (Fluhrer-Mantin-Shamir 2001), AlFardan-Bernstein-Paterson 2013, and bias-based plaintext recovery; NOMORE removed RC4 from TLS in RFC 7465 [[1]](https://www.rsa.com/rsalabs/node.asp?id=2009) — covered separately at [RC4 Stream Cipher (Historical)](#rc4-stream-cipher-historical) |
| **SEAL 3.0** | 1997 | Rogaway-Coppersmith (IBM) | SHA-1-based / 160 | Software-optimized; SEAL 2.0 broken by Fluhrer-Lucks; SEAL 3.0 has distinguisher attacks but no practical break [[1]](https://link.springer.com/chapter/10.1007/978-3-540-78967-3_27) |
| **WAKE (Word Auto-Key Encryption)** | 1993 | Wheeler | 128-bit / variable | Self-modifying key schedule; broken by chosen-plaintext attack (Biham 1994) [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_28) |
| **PKZIP Stream Cipher** | 1989 | Roger Schlafly (PKWARE) | 96-bit / password-derived | Used in ZIP archive encryption; broken by Biham-Kocher 1994 known-plaintext attack; replaced by AES-256 in ZIP 2.0 spec [[1]](https://link.springer.com/chapter/10.1007/3-540-60590-8_12) |
| **GIFFORD** | 1985 | Gifford (MIT) | 64-bit / 64 | Newspaper distribution cipher; broken by Cain-Schneier 1997 [[1]](https://link.springer.com/article/10.1007/BF02620231) |
| **ORYX** | 1990s | TIA | LFSR-based / 96 | US cellular (TDMA/IS-54); broken by Wagner-Schneier-Kelsey 1998 [[1]](https://www.schneier.com/academic/paperfiles/paper-cmea.html) |
| **CMEA (Cellular Message Encryption Algorithm)** | 1991 | TIA | 64-bit block (used as stream) / 64 | US cellular signaling; broken by Wagner-Schneier-Kelsey 1997 [[1]](https://www.schneier.com/academic/paperfiles/paper-cmea.html) |
| **NANOTEQ** | 1990s | Nanoteq (South Africa) | proprietary | South African military stream cipher; details classified, no public cryptanalysis [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_28) |
| **RAMBUTAN** | 1990s | CESG (UK) | proprietary | UK government stream cipher; classified, no public spec [[1]](https://en.wikipedia.org/wiki/Rambutan_(cryptography)) |
| **Hughes XPD/KPD** | 1990s | Hughes Aircraft | proprietary | Voice encryption for military radios; no public cryptanalysis |

**State of the art:** Modern designs (ChaCha20, Trivium, Grain, ZUC, SNOW 3G in [Hardware-Oriented Stream Ciphers](#hardware-oriented-stream-ciphers-estream--3gpp)) have replaced all of these. Cryptanalysis of A5/1 and RC4 are textbook examples illustrating LFSR weaknesses and key-scheduling vulnerabilities respectively. GSM still negotiates A5/1 in many networks despite its being broken.

**Production readiness:** Deprecated
RC4 was removed from TLS by RFC 7465 (2015). A5/2 was banned by 3GPP in 2007. PKZIP cipher is replaced by AES-256 in archive software. SEAL, WAKE, GIFFORD, CMEA, ORYX have no current deployments.

**Implementations:**
- [Osmocom](https://github.com/osmocom/libosmocore) ⭐ 50 — C, A5/1 and A5/2 for GSM testing
- [gr-gsm](https://github.com/ptrkrysik/gr-gsm) ⭐ 2.3k — Python/C++, A5/1 cryptanalysis using rainbow tables
- [Bluetooth E0 reference](https://github.com/greatscottgadgets/ubertooth) ⭐ 1.7k — C, E0 implementation for Bluetooth sniffing
- [pkcrack](https://github.com/keyunluo/pkcrack) ⭐ 240 — C, Biham-Kocher attack on PKZIP cipher

**Security status:** Broken
A5/1, A5/2, E0, RC4 (in TLS context), PKZIP cipher, CMEA, ORYX, GIFFORD all have practical breaks. SEAL 3.0 has only theoretical distinguishers. KASUMI has theoretical related-key break but is still secure as deployed in 3G.

**Community acceptance:** Deprecated
3GPP banned A5/2 in 2007. IETF removed RC4 from TLS in 2015 (RFC 7465). PKZIP and CMEA are legacy compatibility only. Bluetooth E0 replaced by AES-CCM in Bluetooth 4.0+ LE.

---


## Public-Key Encryption

---
### One-Time Pad / Information-Theoretic Security

**Goal:** Perfect secrecy. The only encryption scheme proven unconditionally secure (Shannon 1949): a truly random key as long as the message, used exactly once. Ciphertext reveals zero information about the plaintext regardless of adversary's computational power.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Vernam Cipher (One-Time Pad)** | 1917 | XOR with random key | C = M ⊕ K; key must be truly random, |K| ≥ |M|, never reused [[1]](https://ieeexplore.ieee.org/document/6769090) |
| **Shannon's Theorem** | 1949 | Information theory | Perfect secrecy ⟺ H(K) ≥ H(M); OTP is optimal [[1]](https://ieeexplore.ieee.org/document/6769090) |
| **Two-Time Pad Attack** | — | XOR | If key is reused: C1 ⊕ C2 = M1 ⊕ M2 — catastrophic failure; demonstrates why reuse is fatal |

**State of the art:** OTP is used in diplomatic/military hotlines and combined with QKD for information-theoretically secure channels.

**Production readiness:** Mature
OTP is used in diplomatic/military hotlines and QKD channels. Impractical for general-purpose use due to key length requirements.

**Implementations:**
- No general-purpose library needed — OTP is a simple XOR operation. Any language's bitwise XOR suffices given a truly random key source.

**Security status:** Secure
Unconditionally secure (Shannon's theorem) when used correctly. The two-time pad attack is catastrophic if keys are reused; security is entirely dependent on key management.

**Community acceptance:** Standard
Shannon's theorem (1949) is the foundational result of information-theoretic security. Universally accepted as the gold standard for perfect secrecy, but impractical for most applications.

---

### Trapdoor Functions / Trapdoor Permutations

**Goal:** One-way with a backdoor. A function easy to compute but hard to invert — unless you know the secret trapdoor. Foundation of all public-key encryption: anyone can encrypt (evaluate), only the key holder can decrypt (invert).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Function** | 1977 | Factoring | f(x) = x^e mod N; trapdoor = (p,q); first TDP; see [Asymmetric Encryption](#asymmetric-public-key-encryption) [[1]](https://dl.acm.org/doi/10.1145/359340.359342) |
| **Rabin Function** | 1979 | Factoring | f(x) = x² mod N; provably hard as factoring; 2-to-1 [[1]](https://apps.dtic.mil/sti/pdfs/ADA078416.pdf) |
| **Goldreich-Levin Hard-Core Predicate** | 1989 | Any OWF | Extract a hard-core bit from any one-way function; foundational [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **Lattice Trapdoors (Gentry-Peikert-Vaikuntanathan)** | 2008 | LWE / SIS | PQ trapdoor from lattices; basis of lattice IBE and sigs [[1]](https://eprint.iacr.org/2007/432) |
| **Lossy Trapdoor Functions (Peikert-Waters)** | 2008 | DDH / LWE | Injective or lossy mode; enables CCA security [[1]](https://eprint.iacr.org/2007/279) |

**State of the art:** RSA (deployed), Lattice trapdoors (PQ), Lossy TDFs (clean CCA proofs).

**Production readiness:** Production
RSA trapdoor is deployed everywhere (TLS, SSH, PGP). Lattice trapdoors underlie ML-KEM/ML-DSA (NIST PQ standards). Lossy TDFs remain theoretical.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA trapdoor functions
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, lattice-based trapdoors (ML-KEM, ML-DSA)
- [GMP](https://gmplib.org/) — C, arbitrary-precision arithmetic for Rabin and RSA

**Security status:** Secure
RSA requires 2048+ bit keys; Rabin is provably as hard as factoring. Lattice trapdoors (GPV) are secure under LWE/SIS assumptions with post-quantum resistance.

**Community acceptance:** Standard
RSA is PKCS#1/NIST; lattice trapdoors are the basis of NIST PQ standards. Goldreich-Levin and Lossy TDFs are foundational theoretical results.

---

### Universal Hash Functions (Carter-Wegman)

**Goal:** Fast, provably collision-resistant hashing with a key. Unlike cryptographic hashes, security is information-theoretic (depends only on key randomness). Foundation of Poly1305, UMAC, randomness extraction, and commitments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Carter-Wegman UHF** | 1979 | Polynomial / matrix | Original universal hash family; collision prob ≤ 1/p [[1]](https://dl.acm.org/doi/10.1145/800105.803400) |
| **Poly1305 (as UHF)** | 2005 | Polynomial over GF(2^130-5) | Fast UHF component; combined with cipher for MAC [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **GHASH** | 2004 | GF(2^128) multiplication | UHF inside AES-GCM; hardware-accelerated via PCLMULQDQ [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **UMAC / VMAC** | 1999 | NH + polynomial | Very fast MAC from universal hashing [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/umac-full.pdf) |

**State of the art:** GHASH (AES-GCM hardware), Poly1305 (software), Carter-Wegman paradigm (theoretical foundation).

**Production readiness:** Production
GHASH is inside every AES-GCM deployment; Poly1305 is in TLS 1.3 and WireGuard; UMAC is in OpenSSH.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, GHASH with CLMULQDQ acceleration
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Poly1305 implementation
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, UMAC-64/128

**Security status:** Secure
Information-theoretically secure as universal hash families. Security of the MAC depends on the nonce/key management of the enclosing construction.

**Community acceptance:** Standard
GHASH is part of NIST SP 800-38D (AES-GCM); Poly1305 is RFC 8439; UMAC is RFC 4418. Carter-Wegman (1979) is a foundational result.

---

### Universal One-Way Hash Functions (UOWHF)

**Goal:** Weaker-than-collision-resistance hashing. Adversary commits to x₁ before seeing the hash key, then cannot find x₂ ≠ x₁ with the same hash. Weaker than collision resistance but sufficient for signatures, CCA encryption, and more — and exists under weaker assumptions (any OWF).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Yung UOWHF** | 1989 | Any one-way function | First UOWHF; exists if any OWF exists (vs CR needs stronger assumptions) [[1]](https://doi.org/10.1145/73007.73011) |
| **Rompel UOWHF from OWF** | 1990 | Any OWF | Proved UOWHF from any OWF; simplified by Katz-Koo-Shin [[1]](https://doi.org/10.1145/100216.100269) |
| **UOWHF for Signatures (Bellare-Rogaway)** | 1997 | UOWHF + OWF | Hash-and-sign paradigm: UOWHF suffices (CR not needed) [[1]](https://eprint.iacr.org/2006/285) |

**State of the art:** UOWHF = target collision resistance; foundational for minimal-assumption cryptography. Weaker than [Hash Functions](#hash-functions) (collision resistance) but sufficient for most applications.

**Production readiness:** Research
Theoretical constructions; practical systems use full collision-resistant hashes (SHA-256) rather than explicit UOWHF instantiations.

**Implementations:**
- No dedicated UOWHF libraries. In practice, SHA-256 and SHA-3 provide collision resistance which implies target collision resistance (UOWHF).

**Security status:** Secure
UOWHF exists under the minimal assumption that one-way functions exist. The theoretical framework is sound and well-established.

**Community acceptance:** Niche
Foundational theoretical concept (Naor-Yung 1989, Rompel 1990). Important for minimal-assumption proofs but not directly instantiated in deployed systems.

---

### Fujisaki-Okamoto Transform

**Goal:** CPA→CCA upgrade. Transform any CPA-secure public-key encryption or KEM into a CCA-secure one. Used in ALL NIST post-quantum KEMs (ML-KEM, etc.).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fujisaki-Okamoto (original)** | 1999 | ROM (random oracle model) | Hybrid: PKE + symmetric enc; CCA from CPA [[1]](https://link.springer.com/chapter/10.1007/978-3-540-48405-1_32) |
| **FO⊥ / FO⊥̸ (variants)** | 2017 | QROM | Quantum-safe variants; used in ML-KEM (Kyber), NTRU [[1]](https://eprint.iacr.org/2017/604) |
| **OAEP (Bellare-Rogaway)** | 1994 | ROM | Earlier CPA→CCA transform specific to RSA [[1]](https://eprint.iacr.org/1994/009) |

**State of the art:** FO⊥̸ transform (QROM-secure) — mandatory component in all NIST PQ KEMs.

**Production readiness:** Production
The FO transform is a mandatory component in ML-KEM (Kyber), which is a NIST standard. OAEP is deployed in RSA everywhere.

**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM uses FO transform internally
- [pqcrypto](https://github.com/pqclean/PQClean) ⭐ 893 — C, clean PQ implementations using FO
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA-OAEP

**Security status:** Secure
The FO transform is provably CCA-secure in ROM; QROM variants are secure against quantum adversaries. OAEP is secure in the random oracle model.

**Community acceptance:** Standard
The FO transform is a mandatory component of all NIST PQ KEM standards. OAEP is PKCS#1 v2.2 / RFC 8017. Widely endorsed by the cryptographic community.

---

### SipHash

**Goal:** Fast short-input PRF for hash-table protection. A keyed hash function optimized for speed on short messages (≤ 64 bytes), designed specifically to defeat hash-flooding (HashDoS) denial-of-service attacks where adversaries craft inputs causing worst-case hash-table collisions. Provides PRF security (not just collision resistance) at higher speed than HMAC on short inputs.

| Variant | Rounds | Output | Use case |
|---------|--------|--------|----------|
| **SipHash-2-4** | 2 compress + 4 finalize | 64 bit | Default; fast path for hash tables [[1]](https://eprint.iacr.org/2012/351) |
| **SipHash-4-8** | 4 compress + 8 finalize | 64 bit | Conservative; higher security margin [[1]](https://eprint.iacr.org/2012/351) |
| **SipHash-2-4-128** | 2 compress + 4 finalize | 128 bit | 128-bit tag variant; for MACs [[1]](https://github.com/veorq/SipHash) |
| **HalfSipHash-2-4** | 2 + 4 | 32 bit | 32-bit platforms; OpenSSH protocol sequence numbers [[1]](https://github.com/veorq/SipHash) |

**Design (Aumasson-Bernstein, INDOCRYPT 2012):** ARX (add-rotate-XOR) construction with a 256-bit internal state initialized from a 128-bit key. The SipRound mixes two 64-bit words with message words in an unkeyed compression function, then applies additional rounds at finalization. Unlike HMAC, SipHash requires no hash function and has almost zero overhead on short inputs.

**Context:** Created in late 2011 in response to coordinated HashDoS attacks on Perl, PHP, Python, Ruby, Java, and ASP.NET, which all used unkeyed hash functions vulnerable to adversarial input. SipHash is now the default hash function seed in Rust's `HashMap`, Python 3.4+, Ruby 1.9+, Linux kernel (since 4.1), OpenSSH, and many network stacks.

**State of the art:** SipHash-2-4 (Aumasson-Bernstein 2012) [[1]](https://eprint.iacr.org/2012/351) is the de-facto standard for keyed hash tables and short-input MACs. It is not a replacement for HMAC on long messages, but is the correct primitive for network packet authentication, hash-table salting, and any context requiring a fast PRF over short inputs.

**Production readiness:** Production
Default hash function in Rust HashMap, Python 3.4+, Ruby, Linux kernel (since 4.1), and OpenSSH.

**Implementations:**
- [SipHash reference](https://github.com/veorq/SipHash) ⭐ 752 — C, official reference by Aumasson and Bernstein
- [Rust std::collections::HashMap](https://github.com/rust-lang/rust) ⭐ 111k — Rust, SipHash-1-3 as default hasher
- [Linux kernel](https://github.com/torvalds/linux) ⭐ 225k — C, SipHash used in net/core and random subsystem

**Security status:** Secure
No known attacks on SipHash-2-4 at full rounds; provably secure PRF under standard assumptions for 128-bit key.

**Community acceptance:** Widely trusted
De-facto industry standard for keyed hash tables; endorsed by major language runtimes and operating systems; no formal standards body standardization.

---

### Wegman-Carter MAC (One-Time and Multi-Use)

**Goal:** Unconditionally and computationally secure message authentication via universal hashing. The Wegman-Carter paradigm combines a universal hash function (fast, information-theoretically secure over short keys) with a pseudorandom value (one-time pad or PRF output) to produce a MAC that is either perfectly secure (one-time key) or computationally secure (PRF-based nonce). Poly1305, GMAC, and UMAC are all Wegman-Carter MACs.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Wegman-Carter MAC (original)** | 1981 | UHF + OTP | MAC(m) = H_a(m) ⊕ pad_i; perfect security if pad is one-time and truly random [[1]](https://dl.acm.org/doi/10.1145/800076.802600) |
| **Poly1305** | 2005 | Polynomial UHF + AES/ChaCha20 | H over GF(2¹³⁰−5); pad = AES(key, nonce) or ChaCha20 block; used in TLS 1.3 [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **GHASH + CTR (GMAC)** | 2004 | GF(2¹²⁸) UHF + AES-CTR | MAC component of AES-GCM; NIST SP 800-38D; hardware-accelerated [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **UMAC** | 1999 | NH + polynomial + PRF | Multi-layer UHF; very fast (< 1 cycle/byte with AES-NI); RFC 4418 [[1]](https://www.rfc-editor.org/rfc/rfc4418) |
| **VMAC** | 2007 | 64-bit NH + polynomial | 64-bit variant optimized for 64-bit CPUs; ~0.5 cycles/byte [[1]](https://fastcrypto.org/vmac/vmac.pdf) |

**Security model:** In the one-time setting, if H is ε-almost-universal (collision probability ≤ ε) and the pad is uniform, then the MAC has forgery probability exactly ε. In the multi-use setting (PRF-generated pad), forgery probability is ε + Adv_PRF, typically negligible.

**State of the art:** Poly1305 (paired with ChaCha20, RFC 8439) and GMAC (inside AES-GCM) are the two dominant deployed Wegman-Carter MACs. UMAC (RFC 4418) and VMAC achieve sub-cycle throughput for bulk data. See [Universal Hash Functions (Carter-Wegman)](#universal-hash-functions-carter-wegman) and [Message Authentication Codes (MAC)](#message-authentication-codes-mac).

**Production readiness:** Production
Poly1305 is in TLS 1.3 and WireGuard; GMAC is inside every AES-GCM deployment; UMAC is in OpenSSH.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, GMAC, Poly1305
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Poly1305 (crypto_onetimeauth)
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, UMAC-64/128

**Security status:** Secure
Information-theoretically secure in the one-time setting; computationally secure with PRF-generated pads. Nonce reuse breaks one-time key secrecy.

**Community acceptance:** Standard
Poly1305 is IETF RFC 8439; GMAC is NIST SP 800-38D; UMAC is IETF RFC 4418. Wegman-Carter is the standard paradigm for high-speed MACs.

---

### Non-Cryptographic Hash Functions (FNV / MurmurHash / xxHash)

**Goal:** Fast, high-quality hash functions for hash tables, checksums, and data deduplication — explicitly NOT designed for cryptographic security. These functions prioritize throughput and distribution quality over collision resistance, preimage resistance, or resistance to adversarial inputs. They should never be used where an adversary can control inputs (use [SipHash](#siphash) instead) but are appropriate for in-process hash tables with random seeds or offline data structures.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **FNV-1a** | 1991 | Multiply-XOR (Fowler-Noll-Vo) | 32/64/128-bit variants; simplest non-crypto hash; fast on short strings; no seed [[1]](http://www.isthe.com/chongo/tech/comp/fnv/) |
| **MurmurHash3** | 2008 | Multiply-rotate-XOR | 32/128-bit output; finalization avalanche; fast bulk throughput; Austin Appleby [[1]](https://github.com/aappleby/smhasher) |
| **xxHash32 / xxHash64** | 2012 | Multiple lanes + finalize | Yann Collet; ~10 GB/s; used in LZ4, RocksDB, ClickHouse, Zstandard [[1]](https://xxhash.com/) |
| **XXH3 / XXH128** | 2019 | SIMD-friendly, secret-seeded | Vectorized; ~30–60 GB/s; secret (per-process random) seed for HashDoS resistance [[1]](https://xxhash.com/) |
| **CRC-32 / CRC-64** | 1961 | Linear feedback (GF(2) polynomial) | Error-detection only; not a hash function; easily forged; used in Ethernet, ZIP, gzip [[1]](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) |

**CRC vs cryptographic hash:** A CRC is a remainder from polynomial long division over GF(2); it detects accidental bit errors efficiently but provides zero security against intentional manipulation — any desired CRC value can be computed in O(1). Cryptographic hashes (SHA-256, BLAKE3) provide collision and preimage resistance but are 10–100× slower for bulk data.

**HashDoS context:** Unkeyed non-cryptographic hashes (FNV, early MurmurHash) are vulnerable to hash-flooding attacks: an adversary who knows the hash function can craft inputs that all map to the same bucket, degrading hash-table lookup from O(1) to O(n). Solutions: per-process random seed (XXH3 secret), or switch to a keyed PRF ([SipHash-2-4](#siphash)) for externally influenced keys.

**State of the art:** xxHash3 / XXH128 (2019) for highest-throughput non-cryptographic hashing; SipHash-2-4 when adversarial input is possible; SHA-256 or BLAKE3 for any security-relevant use. See [Universal Hash Functions (Carter-Wegman)](#universal-hash-functions-carter-wegman) for the information-theoretically secure alternative.

**Production readiness:** Production
xxHash is used in LZ4, Zstandard, RocksDB, ClickHouse; MurmurHash3 in Apache Spark, Cassandra; CRC-32 in Ethernet, gzip, ZIP.

**Implementations:**
- [xxHash](https://github.com/Cyan4973/xxHash) ⭐ 10k — C, official xxHash32/64/XXH3/XXH128
- [smhasher](https://github.com/aappleby/smhasher) ⭐ 2.9k — C++, MurmurHash3 reference and test suite
- [FNV reference](http://www.isthe.com/chongo/tech/comp/fnv/) — C, FNV-1/FNV-1a reference

**Security status:** Broken
Not cryptographic — no collision resistance, preimage resistance, or adversarial security. Trivially forgeable. Must not be used for any security purpose.

**Community acceptance:** Widely trusted
Industry standard for non-cryptographic use cases. xxHash and MurmurHash are ubiquitous in databases, compression, and data processing. CRC is an IEEE/ISO standard for error detection.

---

### Authenticated Encryption Security Models

**Goal:** Formal framework for AEAD. Authenticated encryption with associated data (AEAD) provides both confidentiality and integrity in a single pass. Security models differ in what the adversary controls — in particular, whether reusing a nonce breaks all security guarantees or only leaks limited information. Choosing the right model determines which AEAD scheme is appropriate and whether nonce management is the responsibility of the protocol or the primitive.

**Core AEAD security definition (NIST SP 800-38D / Rogaway 2002):** An AEAD scheme is secure if an adversary cannot distinguish its output from random bits (IND-CPA) and cannot forge valid ciphertexts (INT-CTXT), assuming the nonce is never repeated under the same key.

| Model | Nonce reuse impact | Examples | Note |
|-------|-------------------|----------|------|
| **Nonce-Respecting (NR-AEAD)** | Catastrophic — full confidentiality and integrity loss | AES-GCM, ChaCha20-Poly1305, OCB, CCM | Standard model; nonce uniqueness is caller's responsibility [[1]](https://csrc.nist.gov/pubs/sp/800/38/d/final) |
| **Nonce-Misuse-Resistant (NMR-AEAD)** | Graceful — only reveals whether two plaintexts were identical | AES-GCM-SIV (RFC 8452), AES-SIV (RFC 5297), Deoxys-II | Rogaway-Shrimpton 2006 definition; SIV construction [[1]](https://eprint.iacr.org/2006/221) |
| **Nonce-Misuse-Resilient** | Partial — ciphertext indistinguishability lost but integrity preserved | SCT, CAEAD variants | Weaker than NMR; confidentiality leakage bounded [[1]](https://eprint.iacr.org/2015/189) |
| **Online AEAD (OAE2)** | Catastrophic with reuse | STREAM, most streaming AEAD | Supports online processing without buffering; Hoang-Reyhanitabar-Rogaway-Vizár model [[1]](https://eprint.iacr.org/2015/189) |
| **Committing AEAD (CMT)** | — | AES-GCM-SIV, AEGIS with binding | Ciphertext uniquely commits to the key; prevents partition oracle attacks; see [Key-Committing AEAD](02-authenticated-structured-encryption.md#key-committing-aead) [[1]](https://eprint.iacr.org/2020/1153) |

**The SIV (Synthetic IV) construction (Rogaway-Shrimpton 2006):** Generates the nonce/IV synthetically as a PRF of the plaintext and associated data, then encrypts under that IV. If the same plaintext is encrypted twice, the ciphertexts are identical (revealing equality), but confidentiality is otherwise maintained even under nonce reuse. AES-SIV (RFC 5297) and AES-GCM-SIV (RFC 8452) are the deployed instances.

**Nonce reuse disasters:** AES-GCM nonce reuse leaks the authentication key (GHASH key H = E_K(0)), enabling universal forgery. For ChaCha20-Poly1305, nonce reuse similarly leaks the Poly1305 one-time key. A single reuse under the same (key, nonce) pair is catastrophic for all NR-AEAD schemes.

**State of the art:** AES-GCM (NR-AEAD) dominates deployed systems; use AES-GCM-SIV (RFC 8452) or AES-SIV (RFC 5297) when nonce management is unreliable. AEGIS offers NR-AEAD with superior performance. See [Block Cipher Modes of Operation](#block-cipher-modes-of-operation) and [Key-Committing AEAD](02-authenticated-structured-encryption.md#key-committing-aead).

**Production readiness:** Production
NR-AEAD (AES-GCM, ChaCha20-Poly1305) deployed in TLS 1.3, WireGuard. NMR-AEAD (AES-GCM-SIV) deployed in Google Tink and Android.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-GCM, AES-CCM, ChaCha20-Poly1305
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, AES-GCM-SIV (RFC 8452)
- [miscreant](https://github.com/miscreant/miscreant) ⭐ 475 [archived] — Multi-language, AES-SIV and AES-PMAC-SIV

**Security status:** Secure
Individual schemes are secure at recommended parameters. Security model choice (NR vs NMR) depends on nonce management discipline; NMR is strictly stronger.

**Community acceptance:** Standard
AES-GCM is NIST SP 800-38D; AES-SIV is RFC 5297; AES-GCM-SIV is RFC 8452; the SIV/NMR security model is widely accepted in the cryptographic community.

---

### ElGamal Encryption over Groups

**Goal:** Public-key encryption based on the hardness of the discrete logarithm problem. A sender uses the recipient's public key (a group element) together with a fresh random scalar to produce a ciphertext pair; decryption uses the private exponent to undo the Diffie-Hellman blinding. Semantically secure under DDH in the random-oracle model; naturally extends to elliptic curves (EC-ElGamal) and pairing groups.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **ElGamal (original)** | 1985 | DLP in Z*p | Probabilistic PKE; ciphertext (g^r, m·y^r); IND-CPA under DDH [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **EC-ElGamal** | ~1987 | ECDLP | Same construction over an elliptic curve group; shorter keys (256-bit ≈ 3072-bit RSA) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **ElGamal with Schnorr proof** | 1990 | DDH + Σ-protocol | Add a zero-knowledge proof of well-formedness; used in e-voting [[1]](https://eprint.iacr.org/2005/385) |
| **Twisted ElGamal** | 2019 | EC-ElGamal variant | Swap plaintext and blinding factor placement; enables efficient ZK range proofs for confidential transactions [[1]](https://eprint.iacr.org/2019/319) |

**Homomorphic property:** EC-ElGamal is additively homomorphic over the message exponent: Enc(m₁) + Enc(m₂) = Enc(m₁ + m₂) (pointwise group operation on ciphertext pairs). This enables tallying encrypted votes without decryption — a core primitive in e-voting and secure aggregation. Decryption requires solving a discrete log on the result, limiting plaintext space to small integers.

**State of the art:** EC-ElGamal over Ristretto255 or BN254 is the canonical additively homomorphic primitive in ZK and e-voting systems (see [Paillier Cryptosystem](#paillier-cryptosystem-additive-homomorphic-encryption) for integer-based additive HE). Twisted ElGamal is used in Bulletproofs-based confidential transactions (see [Confidential Transactions](13-blockchain-distributed-ledger.md)).

**Production readiness:** Production
EC-ElGamal is deployed in e-voting systems (Helios, Belenios) and confidential transaction schemes; Twisted ElGamal is in Solana's Token-2022.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Ristretto255 group operations (ElGamal building block)
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, Ristretto255 ElGamal
- [Helios](https://github.com/glondu/belenios) ⭐ 147 — OCaml, ElGamal-based e-voting

**Security status:** Secure
IND-CPA under DDH; requires CCA2 extension (e.g., Cramer-Shoup or HPKE) for chosen-ciphertext security. Additive homomorphism limited to small plaintext spaces.

**Community acceptance:** Widely trusted
Foundational public-key encryption scheme; universally taught and deployed. No formal standard as a standalone primitive, but embedded in numerous protocols.

---

### Paillier Cryptosystem (Additive Homomorphic Encryption)

**Goal:** Public-key encryption with native integer addition homomorphism. Paillier encryption allows anyone to compute Enc(m₁ + m₂) = Enc(m₁) · Enc(m₂) mod n² — addition of plaintexts corresponds to multiplication of ciphertexts — without knowing the plaintexts. A scalar multiple Enc(k·m) is also computable from Enc(m) via exponentiation. Foundation of privacy-preserving statistics, secure aggregation, and threshold decryption.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Paillier (original)** | 1999 | Decisional Composite Residuosity (DCR) | Enc(m, r) = g^m · r^n mod n²; 1024–3072-bit modulus [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |
| **Damgård-Jurik generalization** | 2001 | DCR | Extends Paillier to Z_{n^(s+1)}; larger plaintext space; simpler key generation [[1]](https://link.springer.com/chapter/10.1007/3-540-44987-6_9) |
| **Threshold Paillier** | 2001 | DCR + Shamir sharing | Distributed decryption: t-of-n parties required; no single point of key exposure [[1]](https://eprint.iacr.org/2001/010) |
| **Paillier with ZK proofs** | 2003 | DCR + Σ-protocols | Efficient proofs of plaintext range, equality, and well-formedness; essential in practice [[1]](https://eprint.iacr.org/2002/161) |

**Homomorphic operations:**
- Addition: `Enc(m₁) · Enc(m₂) mod n² = Enc(m₁ + m₂ mod n)`
- Scalar multiply: `Enc(m)^k mod n² = Enc(k·m mod n)`
- Subtraction: multiply by `Enc(-m₂) = Enc(n − m₂)`

**Used in:** Private set intersection cardinality, federated learning secure aggregation (Google's secure aggregation protocol), e-voting tallying (Helios, Belenios), CKKS bootstrapping comparisons, MPC protocols (e.g., SPDZ uses Paillier for offline preprocessing).

**State of the art:** Paillier with 2048-bit modulus (112-bit security) is the standard deployment. Threshold Paillier (Damgård-Jurik-Nielsen 2010) is used in production threshold ECDSA (e.g., GG20, CGGMP21). For post-quantum additive HE, see [Homomorphic Encryption](07-homomorphic-functional-encryption.md) (BFV/BGV/CKKS).

**Production readiness:** Production
Used in threshold ECDSA (GG20, CGGMP21), e-voting (Helios, Belenios), and federated learning secure aggregation.

**Implementations:**
- [python-paillier](https://github.com/data61/python-paillier) ⭐ 634 — Python, CSIRO Data61's Paillier library
- [libpaillier](https://github.com/niclabs/tcpaillier) ⭐ 20 — Go, threshold Paillier
- [rust-paillier](https://github.com/KZen-networks/rust-paillier) ⭐ 37 — Rust, Paillier with ZK proofs for threshold ECDSA

**Security status:** Secure
Semantic security (IND-CPA) under the Decisional Composite Residuosity assumption. Requires 2048+ bit modulus for 112-bit security. Not CCA2-secure without additional proof mechanisms.

**Community acceptance:** Widely trusted
No formal NIST/IETF standard, but the de-facto standard additive homomorphic encryption scheme. Widely cited, peer-reviewed, and deployed in production MPC and e-voting.

---

### Multi-Prime RSA and RSA-CRT

**Goal:** Speed up RSA private-key operations (decryption and signing) using the Chinese Remainder Theorem, and extend RSA to more than two prime factors to reduce key generation time and private-key computation cost. RSA-CRT reduces the cost of decryption by a factor of ~4; multi-prime RSA (MPRIME) reduces it further for larger key sizes.

| Technique | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **RSA-CRT (2-prime)** | 1982 | CRT over Z_p × Z_q | Compute d_p = d mod (p−1), d_q = d mod (q−1), then combine via CRT; ~4× speedup [[1]](https://link.springer.com/chapter/10.1007/978-1-4615-3386-3_17) |
| **Multi-prime RSA (MPRIME)** | 1998 | CRT over k primes | n = p₁·p₂·…·p_k; k-prime CRT gives k²/4 speedup; PKCS#1 v2.2 supports up to 10 primes [[1]](https://www.rfc-editor.org/rfc/rfc8017) |
| **Bellcore fault attack on RSA-CRT** | 1996 | Differential fault analysis | A single computation fault during CRT signing leaks the prime factorization; mitigated by verification [[1]](https://eprint.iacr.org/1996/004) |
| **RSA-CRT with blinding** | 1999 | Randomized CRT | Multiply by random r before CRT, divide after; defeats timing and simple power analysis [[1]](https://eprint.iacr.org/2003/020) |

**CRT speedup mechanics:** For 2048-bit RSA, instead of one 2048-bit modular exponentiation, perform two 1024-bit exponentiations (mod p and mod q separately) and combine. Exponentiation cost scales as O(k³) in key size, so two 1024-bit ops cost ≈ 2 × (1024/2048)³ = 1/4 the full-size cost. Multi-prime with k primes achieves O(k²/4) relative speedup.

**Security note:** Multi-prime RSA with 3+ factors requires larger total modulus for equivalent security — NIST SP 800-131A recommends at least 2048-bit n regardless of prime count. The Bellcore attack (Boneh-DeMillo-Lipton 1996) is a seminal result: a single bit flip during CRT computation enables full private key recovery via GCD with the valid signature. All implementations must verify signatures before returning them.

**State of the art:** RSA-CRT is universally implemented in OpenSSL, NSS, and hardware security modules. PKCS#1 v2.2 (RFC 8017) specifies the multi-prime variant. For new deployments, ECDSA/Ed25519 or ML-DSA offer better performance with smaller keys. See [Asymmetric Encryption](#asymmetric-public-key-encryption) and [Trapdoor Functions](#trapdoor-functions--trapdoor-permutations).

**Production readiness:** Production
RSA-CRT is the universal RSA implementation in all major libraries and HSMs. Multi-prime RSA is supported in PKCS#1 v2.2.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA-CRT and multi-prime RSA
- [mbedTLS](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C, RSA-CRT for embedded systems
- [NSS](https://github.com/nss-dev/nss) ⭐ 178 — C, RSA-CRT in Firefox/Thunderbird

**Security status:** Caution
RSA-CRT is secure but requires fault-attack countermeasures (signature verification before output). The Bellcore attack recovers the private key from a single faulty CRT computation. Blinding is mandatory.

**Community acceptance:** Standard
PKCS#1 v2.2 (RFC 8017); universally implemented. RSA-CRT is the default RSA mode in all major cryptographic libraries.

---

### Montgomery Arithmetic and Barrett Reduction

**Goal:** Efficient modular multiplication without expensive division. Division is the bottleneck in modular exponentiation (RSA, DH, ECC scalar multiplication). Montgomery form and Barrett reduction each replace division by the modulus with cheaper multiplications and shifts, enabling practical public-key cryptography on general-purpose hardware and microcontrollers.

| Technique | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Montgomery multiplication** | 1985 | Residue representation | Convert operands to Montgomery form; replace mod-n division with a shift; O(n²) multiplications [[1]](https://dl.acm.org/doi/10.1090/S0025-5718-1985-0777282-X) |
| **Montgomery ladder** | 1987 | Uniform-time scalar mult | Double-and-add with uniform access pattern; constant-time ECC; used in X25519 [[1]](https://cr.yp.to/ecdh/curve25519-20060209.pdf) |
| **Barrett reduction** | 1986 | Pre-computed reciprocal | Approximate modular reduction using integer multiply instead of division; faster setup, no form conversion [[1]](https://link.springer.com/chapter/10.1007/3-540-47721-7_14) |
| **Karatsuba multiplication** | 1962 | Divide-and-conquer | O(n^1.585) multi-precision multiplication; used inside Montgomery for large integers [[1]](https://www.sciencedirect.com/science/article/pii/S0012365X10004656) |
| **CIOS / FIOS (Montgomery variants)** | 1996 | Coarsely/Finely Integrated | Interleave multiplication and reduction; reduce memory bandwidth; used in hardware RSA/ECC accelerators [[1]](https://ieeexplore.ieee.org/document/502403) |

**Montgomery form:** Given modulus n, convert integer a → ã = a·R mod n where R = 2^k for some k ≥ log₂n. Multiplication ã·b̃ = (a·b)·R mod n stays in Montgomery form. "Montgomery reduction" computes ã·b̃·R⁻¹ mod n using only a shift (by k bits) and a multiply by a pre-computed constant n' = −n⁻¹ mod R — no division. Exiting Montgomery form (final reduction) is one extra step.

**Why constant-time matters:** Naive modular reduction (remainder after division) leaks the modulus through data-dependent branching. Montgomery reduction with constant-time conditional subtraction avoids this. The Montgomery ladder for ECC performs the same sequence of operations regardless of the scalar bit, preventing simple power analysis (SPA) and timing attacks.

**State of the art:** Montgomery multiplication is the universal implementation technique for RSA, DH, and classical ECC. Barrett reduction is preferred for software polynomial arithmetic (NTT in ML-KEM/ML-DSA uses Barrett). The Montgomery ladder is mandatory for X25519/X448 (RFC 7748). See [Constant-Time Implementations](#constant-time-implementations-and-timing-attack-mitigations) for the security context.

**Production readiness:** Production
Montgomery multiplication and Barrett reduction are in every RSA/ECC/PQC implementation. The Montgomery ladder is mandatory for X25519/X448.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C/Assembly, Montgomery multiplication with CIOS for RSA/ECC
- [GMP](https://gmplib.org/) — C/Assembly, multi-precision Montgomery and Karatsuba
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, Montgomery ladder for X25519

**Security status:** Secure
Implementation techniques, not cryptographic primitives. Constant-time Montgomery ladder and Barrett reduction prevent timing side channels when correctly implemented.

**Community acceptance:** Standard
Universal implementation standard; described in every applied cryptography textbook. Montgomery ladder is specified in RFC 7748 for X25519/X448.

---


## Hash Functions

---
### Hash Functions

**Goal:** Integrity & data fingerprinting. Map arbitrary data to a fixed-size digest; must be collision-resistant, preimage-resistant, and second-preimage-resistant.

| Algorithm | Year | Output | Note |
|-----------|------|--------|------|
| **SHA-256 / SHA-512** | 2002 | 256 / 512 bit | Merkle-Damgard; NIST standard, ubiquitous [[1]](https://csrc.nist.gov/publications/detail/fips/180/4/final) |
| **SHA-3 (Keccak)** | 2015 | 224–512 bit | Sponge construction; NIST standard (FIPS 202) [[1]](https://keccak.team/keccak.html) |
| **BLAKE3** | 2020 | 256 bit | Merkle tree + compression; extremely fast [[1]](https://github.com/BLAKE3-team/BLAKE3-specs/blob/master/blake3.pdf) |
| **BLAKE2** | 2012 | up to 512 bit | Faster than SHA-3, widely used (Argon2, WireGuard) [[1]](https://www.blake2.net/blake2.pdf) |
| **KangarooTwelve (K12)** | 2016 | variable | Reduced-round Keccak-p, parallelizable [[1]](https://eprint.iacr.org/2016/770) |

**Extendable-Output Functions (XOF):** Hash functions with variable-length output — absorb input, then squeeze out as many bytes as needed. Used as KDF, PRNG, keystream, or challenge generator in ZK proofs. Examples: SHAKE128/256 (SHA-3 family), TurboSHAKE [[1]](https://keccak.team/keccak.html).

**State of the art:** BLAKE3 (speed), SHA-3/SHAKE (diversity from SHA-2), SHA-256 (compatibility).

**Production readiness:** Production
SHA-256/512 are ubiquitous (TLS, Bitcoin, Git); SHA-3 is NIST-standardized; BLAKE3 is rapidly adopted.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, SHA-2 and SHA-3 with hardware acceleration
- [BLAKE3](https://github.com/BLAKE3-team/BLAKE3) ⭐ 6.1k — Rust/C, official BLAKE3 with SIMD
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, Keccak team's reference SHA-3/SHAKE/K12
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, BLAKE2b, SHA-256/512

**Security status:** Secure
All listed hashes have no known practical collision or preimage attacks at full rounds. SHA-256 provides 128-bit collision resistance; SHA-3 adds structural diversity.

**Community acceptance:** Standard
SHA-2 is NIST FIPS 180-4; SHA-3 is NIST FIPS 202; BLAKE2 is RFC 7693; BLAKE3 is widely trusted but not yet formally standardized by NIST.

---

### Message Authentication Codes (MAC)

**Goal:** Integrity + Authentication. Verify that a message was not altered and comes from someone who knows the shared key.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **HMAC** | 1996 | Hash-based | HMAC-SHA256 is the workhorse; provably secure if hash is PRF [[1]](https://csrc.nist.gov/publications/detail/fips/198/1/final) |
| **CMAC** | 2005 | Block cipher | Based on CBC-MAC; NIST SP 800-38B [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/b/final) |
| **GMAC** | 2004 | GF(2^128) | MAC-only mode of GCM; very fast with AES-NI [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **Poly1305** | 2005 | Polynomial | One-time MAC; used with ChaCha20 in TLS 1.3 [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **KMAC** | 2016 | Keccak | SHA-3-based MAC; NIST SP 800-185 [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |

**State of the art:** HMAC-SHA256 (general), Poly1305 (high speed, paired with ChaCha20).

**Production readiness:** Production
HMAC-SHA256 is in every TLS deployment; Poly1305 is in TLS 1.3 and WireGuard; GMAC is inside AES-GCM.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, HMAC, CMAC, GMAC
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Poly1305, HMAC-SHA256/512
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, HMAC, Poly1305
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, KMAC reference implementation

**Security status:** Secure
HMAC-SHA256 is provably secure if the compression function is a PRF. Poly1305 is information-theoretically secure as a one-time MAC. KMAC is based on SHA-3.

**Community acceptance:** Standard
HMAC is NIST FIPS 198-1 and IETF RFC 2104; CMAC is NIST SP 800-38B; KMAC is NIST SP 800-185; Poly1305 is RFC 8439.

---

### Randomness Extractors

**Goal:** Entropy purification. Convert weakly random sources (physical noise, biased bits, blockchain hashes) into nearly uniform random bits suitable for cryptographic keys. Foundation of all practical randomness.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Leftover Hash Lemma (ILL)** | 1989 | Universal hashing | Foundational: 2-universal hash family extracts randomness [[1]](https://dl.acm.org/doi/10.1145/73007.73009) |
| **Trevisan's Extractor** | 1999 | List-decodable codes | Near-optimal seed length; from error-correcting codes [[1]](https://dl.acm.org/doi/10.1145/301250.301292) |
| **Two-Source Extractors** | 2016 | Combinatorial | Extract from two independent weak sources; breakthrough [[1]](https://dl.acm.org/doi/10.1145/2897518.2897528) |

**State of the art:** Leftover Hash Lemma (practical), HKDF uses extract-then-expand pattern.

**Production readiness:** Mature
The Leftover Hash Lemma underlies HKDF-Extract and practical randomness extraction; Trevisan's and two-source extractors remain theoretical.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, HKDF-Extract implements the extraction pattern
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, randombytes_buf uses extraction internally
- [HKDF (RFC 5869)](https://github.com/casebeer/python-hkdf) ⭐ 22 — Python, reference HKDF with extract phase

**Security status:** Secure
The Leftover Hash Lemma is information-theoretically secure. Two-source extractors have rigorous proofs. No known attacks on these foundational constructions.

**Community acceptance:** Standard
The extract-then-expand pattern is endorsed by NIST SP 800-56C and IETF RFC 5869. The Leftover Hash Lemma is a cornerstone of theoretical cryptography.

---

### Correlation-Intractable Hash Functions

**Goal:** Secure Fiat-Shamir for all NP. A hash function H is correlation-intractable for a relation R if no one can find x such that R(x, H(x)) holds. Enables provably secure non-interactive proofs from interactive ones via Fiat-Shamir — resolving a decades-old open question.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti CI Hash (definition)** | 2001 | — | Formal definition; showed no CI hash for all relations in standard model [[1]](https://eprint.iacr.org/1998/015) |
| **Peikert-Shiehian CI from LWE** | 2019 | LWE | First CI hash for all efficiently searchable relations; Fiat-Shamir for NP [[1]](https://eprint.iacr.org/2018/1004) |
| **Canetti-Chen-Holmgren-Lombardi-Rothblum-Rothblum** | 2019 | LWE | CI hash for bounded-depth relations; simpler construction [[1]](https://eprint.iacr.org/2018/1003) |

**State of the art:** CI hash from LWE (Peikert-Shiehian 2019); proves Fiat-Shamir sound for NP under standard assumptions. Connects [Sigma Protocols](04-zero-knowledge-proof-systems.md#sigma-protocols--schnorr-identification) and [NIZK](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Research
Purely theoretical constructions; no production implementations exist. The results justify practical use of Fiat-Shamir in the random oracle model.

**Implementations:**
- No production implementations. These are theoretical feasibility results; practical ZK systems use random oracle heuristic (SHA-3/SHAKE) instead.

**Security status:** Secure
Provably secure under LWE. The constructions validate the soundness of the Fiat-Shamir heuristic for all of NP under standard assumptions.

**Community acceptance:** Niche
Landmark theoretical results (Crypto/STOC 2019) resolving a long-standing open question. Widely cited in the ZK and complexity theory communities but not directly deployed.

---

### ZK-Friendly Hash Functions (Arithmetization-Oriented)

**Goal:** Hash functions optimized for ZK circuits. Standard hashes (SHA-256, BLAKE) have massive circuit size in ZK; arithmetization-oriented hashes minimize multiplicative depth and constraint count, enabling 10-100x speedup for in-SNARK hashing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Poseidon** | 2019 | Partial SPN over Fp | First widely-deployed ZK hash; S-box = x^α over prime field [[1]](https://eprint.iacr.org/2019/458) |
| **Poseidon2** | 2023 | Improved Poseidon | 2-4x faster than Poseidon; optimized linear layer [[1]](https://eprint.iacr.org/2023/323) |
| **Poseidon(2)b** | 2025 | Binary extension field Poseidon/Poseidon2 | Designed for [Binius](04-zero-knowledge-proof-systems.md#binary-field-proof-systems) and other binary-field proving systems; 128-bit security; smaller proofs and faster verification vs prime-field variants and Vision-32b [[1]](https://eprint.iacr.org/2025/1893) [[2]](https://github.com/Poseidon-Hash/Poseidon2b) |
| **Anemoi / Jive** | 2023 | Flystel S-box | Novel "Flystel" structure + Jive compression; 2x improvement over Poseidon in R1CS [[1]](https://eprint.iacr.org/2022/840) |
| **Griffin** | 2022 | Degree-3 S-box | Distinct non-linear/linear interaction; optimized for Groth16 [[1]](https://eprint.iacr.org/2022/403) |
| **Reinforced Concrete** | 2022 | Lookup-table + algebraic | Combines lookup-based "bricks" with algebraic structure; CCS 2022 [[1]](https://eprint.iacr.org/2021/1038) |
| **Tip5** | 2023 | Lookup-based (AIR) | Optimized for STARK/AIR proof systems; lookup-table S-box [[1]](https://eprint.iacr.org/2023/107) |

**State of the art:** Poseidon2 (general ZK), Tip5 (STARKs), Reinforced Concrete (R1CS). A new primitive class bridging [Hash Functions](#hash-functions) and [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Experimental
Poseidon is deployed in Filecoin, Zcash (Orchard), and many ZK rollups. Poseidon2, Anemoi, and Tip5 are newer with growing adoption.

**Implementations:**
- [poseidon2](https://github.com/HorizenLabs/poseidon2) ⭐ 73 — Rust, Poseidon2 reference
- [Plonky3](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust, includes Poseidon2 and Tip5 for STARKs

**Security status:** Caution
Poseidon and Poseidon2 have undergone significant cryptanalysis but are newer than traditional hashes. Griffin had an algebraic attack discovered in 2023 (Bariant-Leurent). Ongoing active cryptanalysis is expected.

**Community acceptance:** Emerging
Poseidon is the de facto standard in ZK proof systems. Poseidon2 and Tip5 are gaining adoption. No NIST/IETF standardization; community-driven by ZK ecosystem developers and researchers.

---

### Password Hashing & Memory-Hard KDFs

**Goal:** Slow, resource-intensive key derivation for password storage and password-based key derivation. Unlike general KDFs (HKDF), password hashers must resist GPU/ASIC offline attacks by requiring large amounts of memory and/or computation per evaluation. A correct scheme means an attacker must pay significant hardware cost per password guess.

| Scheme | Year | Memory-hard | Note |
|--------|------|-------------|------|
| **bcrypt** | 1999 | No (4 KB state) | Blowfish-based; work factor 2^cost; widely deployed but ASIC-attackable [[1]](https://www.usenix.org/legacy/events/usenix99/provos/provos.pdf) |
| **PBKDF2** | 2000 | No | HMAC iterated t times; NIST SP 800-132, RFC 8018; FIPS-compliant but weak against GPU [[1]](https://www.rfc-editor.org/rfc/rfc8018) |
| **scrypt** | 2009 | Yes (configurable) | Colin Percival; sequential memory-hard via ROMix; N×r×p parameters [[1]](https://www.rfc-editor.org/rfc/rfc7914) |
| **Argon2d** | 2015 | Yes | PHC winner; data-dependent memory access; maximally MHF, resist TMTO [[1]](https://www.rfc-editor.org/rfc/rfc9106) |
| **Argon2i** | 2015 | Yes | Data-independent; side-channel-resistant; suitable for sensitive environments [[1]](https://www.rfc-editor.org/rfc/rfc9106) |
| **Argon2id** | 2015 | Yes | Hybrid: Argon2i first pass + Argon2d remainder; **recommended default** (RFC 9106) [[1]](https://www.rfc-editor.org/rfc/rfc9106) |
| **Balloon Hashing** | 2016 | Yes | Provably memory-hard under standard assumptions; simple design [[1]](https://eprint.iacr.org/2016/027) |

**Parameters (Argon2id recommended defaults):** memory ≥ 19 MiB, iterations ≥ 2, parallelism = 1. OWASP 2023 guidance: 64 MiB / 3 iterations / 4 threads.

**State of the art:** Argon2id (RFC 9106, PHC winner) is the current recommendation for new systems. bcrypt and PBKDF2 remain dominant in legacy deployments. See [Key Exchange & KDFs](03-key-exchange-key-management.md) for general-purpose KDFs.

**Production readiness:** Production
Argon2id, bcrypt, and PBKDF2 are deployed at massive scale in authentication systems worldwide. scrypt is used in Litecoin and Tarsnap.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Argon2id (crypto_pwhash)
- [bcrypt](https://github.com/pyca/bcrypt) ⭐ 1.5k — Python/C, bcrypt password hashing
- [argon2](https://github.com/P-H-C/phc-winner-argon2) ⭐ 5.2k — C, official PHC winner reference
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, PBKDF2, scrypt (3.0+), Argon2 (3.2+)

**Security status:** Secure
Argon2id is the recommended default (RFC 9106). bcrypt is secure but not memory-hard (ASIC-attackable). PBKDF2 is weak against GPU attacks but FIPS-compliant. Use adequate parameters per OWASP guidance.

**Community acceptance:** Standard
Argon2id is RFC 9106 and OWASP-recommended. bcrypt is the long-standing industry standard. PBKDF2 is NIST SP 800-132 / RFC 8018. Balloon Hashing has NIST endorsement in draft guidance.

---

### HKDF (Extract-and-Expand Key Derivation)

**Goal:** Derive one or more cryptographically strong keys from any source of keying material — shared secrets, passwords, or raw entropy — using a structured two-phase process. HKDF separates randomness extraction (weak → uniform) from key expansion (one PRK → many keys), cleanly composing the Randomness Extractor and PRF abstractions.

**Two-phase design (RFC 5869):**

```
HKDF-Extract(salt, IKM)  →  PRK  (pseudorandom key, 32 bytes for SHA-256)
HKDF-Expand(PRK, info, L)  →  OKM  (output keying material, L bytes)
```

- **Extract:** `PRK = HMAC-Hash(salt, IKM)` — acts as a randomness extractor; salt plays the role of the hash key
- **Expand:** `OKM = T(1) ∥ T(2) ∥ …` where `T(i) = HMAC-Hash(PRK, T(i-1) ∥ info ∥ i)`; `info` allows domain separation / context binding

| Instantiation | Hash | PRK size | Max OKM |
|---------------|------|----------|---------|
| HKDF-SHA256 | SHA-256 | 32 B | 8160 B |
| HKDF-SHA512 | SHA-512 | 64 B | 16320 B |

**Used in:** TLS 1.3 (all key derivation), HPKE (RFC 9180), Signal Protocol (X3DH + Double Ratchet), Noise Protocol Framework, OPAQUE (RFC 9106), WireGuard.

**State of the art:** RFC 5869 (2010); NIST SP 800-56C Rev. 2 endorses the extract-then-expand pattern. HKDF-SHA256 is the de facto key-derivation workhorse in modern protocols. See [Randomness Extractors](#randomness-extractors) for the theoretical foundation.

**Production readiness:** Production
HKDF is used in TLS 1.3, HPKE, Signal Protocol, Noise Framework, OPAQUE, and WireGuard. Universal key derivation primitive.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, HKDF-SHA256/SHA512 (EVP_KDF)
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, HKDF for TLS 1.3
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, crypto_kdf (BLAKE2b-based, similar pattern)
- [hkdf](https://github.com/casebeer/python-hkdf) ⭐ 22 — Python, RFC 5869 reference

**Security status:** Secure
HKDF is provably secure when the underlying HMAC is a PRF. The extract-then-expand pattern cleanly separates entropy extraction from key expansion.

**Community acceptance:** Standard
IETF RFC 5869; NIST SP 800-56C Rev. 2 endorses extract-then-expand. HKDF is the mandatory KDF in TLS 1.3 (RFC 8446) and HPKE (RFC 9180).

---

### Merkle-Damgård Construction

**Goal:** Build a collision-resistant hash function for arbitrary-length messages from a fixed-input-length compression function. The construction iterates the compression function over message blocks, threading a chaining value between rounds. A proper length-padding scheme (MD-strengthening) ensures that collision resistance of the compression function implies collision resistance of the full hash.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Merkle-Damgård (MD)** | 1989 | Iterated compression | Pad message with length; h_i = f(h_{i-1}, m_i); foundational [[1]](https://link.springer.com/chapter/10.1007/0-387-34805-0_39) |
| **MD-strengthening** | 1989 | Length encoding | Append message bit-length as final padded block; prevents fixed-point / extension attacks [[1]](https://link.springer.com/chapter/10.1007/0-387-34805-0_39) |
| **Length extension vulnerability** | — | Attack class | H(k ∥ m) forgeable without k if H is plain MD; counters: HMAC, prefix-MAC with HAIFA or sponge [[1]](https://eprint.iacr.org/2004/304) |
| **HAIFA (wide-pipe / strengthened MD)** | 2006 | Counter-augmented MD | Adds bit-counter and salt to each compression call; thwarts multi-collision and length-extension attacks [[1]](https://eprint.iacr.org/2006/069) |
| **Wide-pipe** | 2004 | Double-width chaining | Internal state twice the output size; prevents Joux multi-collision attacks; used in SHA-512/256 [[1]](https://eprint.iacr.org/2004/304) |

**Deployed instances:** SHA-1, SHA-256, SHA-512, MD5 — all use basic Merkle-Damgård with Davies-Meyer compression (see [Block-Cipher-Based Hash Compression Functions](#block-cipher-based-hash-compression-functions)). SHA-512/256 uses a wide-pipe variant.

**State of the art:** Merkle-Damgård is the structural backbone of SHA-2, but modern designs prefer the [Sponge Construction](#sponge-construction--duplex) (SHA-3, BLAKE3) which avoids length-extension and supports variable output natively.

**Production readiness:** Production
Underlies SHA-1, SHA-256, SHA-512, and MD5 — deployed in virtually every cryptographic system worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, SHA-2 family (all Merkle-Damgard)
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, SHA-256/512
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, SHA-2 with hardware acceleration

**Security status:** Caution
The construction itself is sound (collision resistance reduces to compression function), but suffers from length-extension attacks when used naively as a MAC. Wide-pipe and HAIFA variants mitigate known structural weaknesses.

**Community acceptance:** Standard
NIST FIPS 180-4 (SHA-2) is built on Merkle-Damgard. Universally understood and deployed; the most widely implemented hash construction in history.

---

### TupleHash / ParallelHash (NIST SP 800-185)

**Goal:** Structured and parallel hashing from the SHA-3 family. NIST SP 800-185 (2016) defines four Keccak-based functions that extend SHA-3/SHAKE with domain separation, structured input encoding, and tree-parallel hashing — filling gaps left by the base FIPS 202 standard for production cryptographic applications.

| Function | Year | Type/Basis | Note |
|----------|------|------------|------|
| **cSHAKE128 / cSHAKE256** | 2016 | SHAKE + domain separation | Customizable SHAKE: adds function-name and customization strings; prevents cross-protocol collisions [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |
| **KMAC128 / KMAC256** | 2016 | Keccak-based MAC | Keyed hash from cSHAKE; variable output length; also usable as KDF; see [MAC](#message-authentication-codes-mac) [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |
| **TupleHash128 / TupleHash256** | 2016 | cSHAKE + length encoding | Hash tuples of byte strings with unambiguous encoding; prevents length-extension on structured inputs [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |
| **ParallelHash128 / ParallelHash256** | 2016 | Tree hash over cSHAKE | Divide message into B-byte blocks, hash in parallel with cSHAKE, combine; vectorizable [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |

**TupleHash detail:** Encodes each element of a tuple as `left_encode(len(s)) ∥ s`, then hashes the concatenation with cSHAKE. This means `TupleHash("ab", "c") ≠ TupleHash("a", "bc")` — critical for authenticated data structures, protocol transcripts, and commitment schemes where naive concatenation is ambiguous.

**ParallelHash detail:** Partitions the message into B-byte blocks (B is a parameter), applies cSHAKE independently to each block (parallelizable across cores), then applies a final cSHAKE to the outputs. Enables throughput scaling on multi-core CPUs and streaming hardware.

**State of the art:** NIST SP 800-185 (2016); all four functions are unbroken and safe for production use. TupleHash is increasingly used in ZK protocol transcripts and commitment schemes where domain separation is critical. See [Sponge Construction](#sponge-construction--duplex) for the underlying Keccak permutation.

**Production readiness:** Mature
NIST-standardized (SP 800-185) with production-quality implementations; adoption growing but less ubiquitous than SHA-3/SHAKE.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, official Keccak team reference for cSHAKE, KMAC, TupleHash, ParallelHash
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, KMAC support (3.0+)
- [Go crypto](https://github.com/golang/crypto) ⭐ 3.3k — Go, cSHAKE and KMAC in golang.org/x/crypto/sha3

**Security status:** Secure
Based on full 24-round Keccak-f[1600]; no known attacks. Security inherits directly from SHA-3/SHAKE.

**Community acceptance:** Standard
NIST SP 800-185 (2016). KMAC is referenced in NIST SP 800-108 Rev. 1 for KDF and in post-quantum standards.

---

### SequenceHash and SequenceMAC (C2SP)

**Goal:** Hash-agnostic, byte-oriented, unambiguous hashing of *sequences* of byte strings — like TupleHash, but built on any hash function (SHA-256, BLAKE2, etc.), not just Keccak. Solves the naive-concatenation ambiguity (`H("ab","c") ≠ H("a","bc")`) for arbitrary modern hashes with native domain-separation strings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SequenceHash** | 2024 | Double-hash (HMAC-like) + unambiguous length encoding | TupleHash-equivalent for SHA-2/BLAKE2/etc.; resists length extension; built-in customization string [[1]](https://c2sp.org/sequencehash) |
| **SequenceMAC** | 2024 | Keyed SequenceHash | MAC variant; same construction with key prepended to sequence [[1]](https://c2sp.org/sequencehash) |

**State of the art:** SequenceHash (C2SP, Opal Wright + Scott Arciszewski, 2024). Provides [TupleHash](#tuplehash--parallelhash-nist-sp-800-185) semantics for hash functions that don't support customization natively. Useful in ZK transcripts, signatures of structured data, and protocol commitments where domain separation matters but Keccak isn't the target hash. See also [Hash Functions](#hash-functions), [HKDF](#hkdf-extract-and-expand-key-derivation).

**Production readiness:** Experimental
C2SP spec published 2024; reference implementations under development. No major production deployment yet, but conceptually trivial to implement on top of any compliant SHA-2/BLAKE2/etc. library.

**Implementations:**
- No widely-used reference implementation released as of 2026-05; the spec is implementable directly from text.

**Security status:** Secure
Construction is HMAC-style double hashing; security reduces to the underlying hash's collision/preimage resistance. Length-extension resistant even when built on Merkle-Damgård hashes.

**Community acceptance:** Emerging
Published as a C2SP spec; cited by hash-agnostic protocols seeking TupleHash-like semantics without Keccak dependency. Not yet IETF-standardized.

---

### RIPEMD-160

**Goal:** Collision-resistant 160-bit hash optimized for software and used as a compact fingerprint in legacy PKI and Bitcoin address derivation. Designed by Dobbertin, Bosselaers, and Preneel (1996) as a strengthened replacement for RIPEMD-128, independent of the NSA/NIST SHA lineage.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **RIPEMD-128** | 1996 | MD (dual-stream Feistel) | 128-bit output; predecessor, now considered weak [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |
| **RIPEMD-160** | 1996 | MD (dual parallel stream) | 160-bit output; two parallel Merkle-Damgård streams merged; ISO/IEC 10118-3 [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |
| **RIPEMD-256 / RIPEMD-320** | 1997 | MD (parallel streams) | Extended variants; wider output; no additional security over 160/128-bit [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |

**Design:** Two independent streams of 80 rounds each, using different constants and round-function orderings, then combined with a final merge step. Avoids length-extension attacks through independent left/right processing.

**Used in:** Bitcoin address derivation (`HASH160 = RIPEMD-160(SHA-256(pubkey))`), PGP key fingerprints (OpenPGP legacy), X.509 certificate fingerprints (historical). No known practical collision attack against RIPEMD-160 (unlike MD5/SHA-1).

**State of the art:** No practical collision found as of 2024; theoretical attack on reduced rounds by Liu-Mendel-Wang (2022) reaches 36/80 rounds. Still considered acceptable for the specific Bitcoin use case, but new designs should prefer SHA-256 or SHA-3. See [Hash Functions](#hash-functions).

**Production readiness:** Mature
Deployed in Bitcoin (HASH160) and legacy PGP; no new adoption recommended but existing uses remain safe.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RIPEMD-160
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, RIPEMD-128/160/256/320
- [Bitcoin Core](https://github.com/bitcoin/bitcoin) ⭐ 88k — C++, RIPEMD-160 for address derivation

**Security status:** Caution
No practical collision attack on full 80 rounds, but 160-bit output provides only 80-bit collision resistance. Not recommended for new designs; use SHA-256 or SHA-3.

**Community acceptance:** Niche
ISO/IEC 10118-3 standard but largely superseded by SHA-2/SHA-3 outside the Bitcoin ecosystem.

---

### Keccak-p Permutation

**Goal:** Core building block of SHA-3 and all sponge-based cryptography. Keccak-p[b, nᵣ] is a family of unkeyed, invertible permutations over a b-bit state. The full Keccak-f[1600] permutation (b = 1600, nᵣ = 24) underlies SHA-3, SHAKE128/256, KMAC, and KangarooTwelve. Reduced-round variants power lightweight designs. Understanding Keccak-p is essential for implementing, analyzing, or building protocols on top of the SHA-3 family.

**State structure:** b-bit state arranged as a 5×5×w array of lanes (w = b/25 bits per lane). For the standard b = 1600: w = 64, each lane is a 64-bit word — the state is a 5×5 matrix of uint64 values.

**Round structure (one round of Keccak-p):** Five sequential steps, each operating on the full state:

| Step | Symbol | Operation |
|------|--------|-----------|
| **Theta** | θ | Column parity mixing: each bit XORed with parity of two adjacent columns |
| **Rho** | ρ | Intra-lane bit rotation: each of 25 lanes rotated by a fixed offset |
| **Pi** | π | Lane permutation: rearranges the 25 lanes in the 5×5 array |
| **Chi** | χ | Row-wise nonlinear layer: `A[x] ^= (~A[x+1]) & A[x+2]` per row |
| **Iota** | ι | Round constant addition: XOR one of 24 precomputed 64-bit constants into lane (0,0) |

**χ is the only nonlinear step** — a degree-2 Boolean function applied row-wise. All other steps are GF(2)-linear. Algebraic degree doubles with each χ application, reaching near-full degree after a few rounds, making algebraic attacks infeasible.

**Round counts and security:**

| Variant | State (bits) | Rounds | Used in |
|---------|-------------|--------|---------|
| **Keccak-f[1600]** | 1600 | 24 | SHA-3, SHAKE128/256, KMAC (FIPS 202) [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **Keccak-p[1600, 12]** | 1600 | 12 | KangarooTwelve, MarsupilamiFourteen [[1]](https://eprint.iacr.org/2016/770) |
| **Keccak-f[800]** | 800 | 22 | PHOTON-Beetle (NIST LWC finalist) [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/photon-beetle-spec-final.pdf) |
| **Keccak-f[200]** | 200 | 18 | Ultra-lightweight embedded variants |

**Best known attacks:** Differential and algebraic attacks on reduced-round Keccak reach 7–8 of 24 rounds for collision finding (Song-Liao-Guo 2017 MILP-based). No practical attack on full 24-round Keccak-f[1600]. Best attack on 12-round Keccak-p[1600] reaches 6 rounds.

**State of the art:** Keccak-f[1600] (FIPS 202, 2015) is the definitive standard permutation; Keccak-p[1600, 12] enables KangarooTwelve's ~4× throughput advantage over SHA-3. See [Sponge Construction / Duplex](#sponge-construction--duplex) for how the permutation composes into a hash or AEAD, and [Hash Functions](#hash-functions) for the standardized SHA-3 outputs.

**Production readiness:** Production
Core of SHA-3 (FIPS 202), SHAKE, KMAC, and KangarooTwelve — deployed in every SHA-3 implementation worldwide.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C/Assembly, official Keccak team reference with AVX2/AVX-512 optimizations
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, Keccak-f[1600] in SHA-3/SHAKE
- [tiny_sha3](https://github.com/mjosaarinen/tiny_sha3) ⭐ 227 — C, minimal Keccak-f[1600] implementation

**Security status:** Secure
No practical attack on full 24-round Keccak-f[1600]; best differential/algebraic attacks reach 7-8 rounds. 12-round Keccak-p has a comfortable security margin.

**Community acceptance:** Standard
NIST FIPS 202 (SHA-3); Keccak-f[1600] is the most analyzed cryptographic permutation. Designed by the Keccak team (Bertoni, Daemen, Peeters, Van Assche).

---

### BLAKE2 Hash Function Internals

**Goal:** Fast, secure general-purpose hash with a simpler design than SHA-2 and higher performance than SHA-3. BLAKE2 (Aumasson, Neves, Wilcox-O'Hearn, Winnerlein, 2012) improves on the SHA-3 finalist BLAKE by removing padding rounds, simplifying the permutation schedule, and adding built-in keying, salting, personalization, and tree hashing without any external wrapper. Standardized as RFC 7693.

**Two main variants:**

| Variant | Word size | Max output | Optimized for |
|---------|-----------|------------|---------------|
| **BLAKE2b** | 64-bit | 512 bit | 64-bit CPUs; replaces SHA-512 [[1]](https://www.rfc-editor.org/rfc/rfc7693) |
| **BLAKE2s** | 32-bit | 256 bit | 32-bit / embedded CPUs; replaces SHA-256 [[1]](https://www.rfc-editor.org/rfc/rfc7693) |
| **BLAKE2bp** | 64-bit | 512 bit | 4-way parallel; multi-core / SIMD [[1]](https://www.blake2.net/blake2.pdf) |
| **BLAKE2sp** | 32-bit | 256 bit | 8-way parallel; multi-core / SIMD [[1]](https://www.blake2.net/blake2.pdf) |
| **BLAKE2X** | 64 or 32-bit | arbitrary | XOF mode; variable-length output [[1]](https://www.blake2.net/blake2x.pdf) |

**Core compression function:** Inherits BLAKE's G mixing function, adapted from ChaCha20's quarter-round, applied to a 4×4 matrix of 64-bit (BLAKE2b) or 32-bit (BLAKE2s) words. Each compression call runs 12 rounds (BLAKE2b) or 10 rounds (BLAKE2s). Eight G applications per round: four column-wise then four diagonal. The G function per BLAKE2b:

```
G(a, b, c, d, x, y):
  a = a + b + x;  d = ROTR64(d ^ a, 32)
  c = c + d;      b = ROTR64(b ^ c, 24)
  a = a + b + y;  d = ROTR64(d ^ a, 16)
  c = c + d;      b = ROTR64(b ^ c, 63)
```

**Built-in parameter block features (no external wrapper needed):**
- **Keyed mode:** Include a 0–64 byte key; produces a MAC equivalent without HMAC
- **Salt:** 16-byte per-instance salt mixed into the initial state
- **Personalization:** 16-byte application-specific domain separator
- **Tree hashing:** Fan-out, leaf size, and node offset parameters enable parallel Merkle-tree hashing

**Performance:** BLAKE2b runs at ~3.5 cycles/byte on modern x86 without SHA extensions (vs ~8 for SHA-256 without SHA-NI, ~17 for SHA-3 on the same hardware). With SHA-NI, SHA-256 reaches ~1.5 cycles/byte, but BLAKE2b requires no special instruction extensions.

**Used in:** Argon2 (PHC winner, RFC 9106) uses BLAKE2b as its core compression function; WireGuard uses BLAKE2s for handshake hashing; libsodium's `crypto_generichash` defaults to BLAKE2b; Zcash uses BLAKE2b for its Merkle trees and note commitment scheme.

**State of the art:** RFC 7693 (2015) standardizes BLAKE2b and BLAKE2s. BLAKE3 (2020) further improves with a tree structure enabling near-linear parallel scaling, but BLAKE2b/2s remain widely deployed and are the correct choice when RFC compliance is required or BLAKE3 is unavailable. See [Hash Functions](#hash-functions).

**Production readiness:** Production
BLAKE2b is the core of Argon2 (RFC 9106) and WireGuard; libsodium defaults to BLAKE2b; deployed in Zcash and numerous applications.

**Implementations:**
- [BLAKE2 reference](https://github.com/BLAKE2/BLAKE2) ⭐ 694 — C, official reference for BLAKE2b/2s/2bp/2sp
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, BLAKE2b as crypto_generichash
- [blake2-rfc](https://github.com/cesarb/blake2-rfc) ⭐ 66 — Rust, BLAKE2b/2s per RFC 7693

**Security status:** Secure
No known attacks on full-round BLAKE2b (12 rounds) or BLAKE2s (10 rounds). Security margin is comfortable; best cryptanalysis reaches reduced rounds only.

**Community acceptance:** Standard
IETF RFC 7693; widely trusted by the cryptographic community. Used in Argon2 (PHC winner), WireGuard, libsodium, and Zcash.

---

### Ascon (NIST Lightweight AEAD and Hashing Winner)

**Goal:** Provide authenticated encryption with associated data (AEAD) and hashing for constrained devices (microcontrollers, embedded sensors, IoT), selected by NIST as the primary standard from the Lightweight Cryptography competition.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **Ascon-128 / Ascon-128a** | 2014 | AEAD (sponge) | 128-bit key, 128-bit nonce; duplex sponge with 320-bit permutation (64-bit words x 5); Ascon-128a has double-rate for higher throughput [[1]](https://ascon.iaik.tugraz.at/) |
| **Ascon-Hash / Ascon-XOF** | 2014 | Hash / XOF | 256-bit hash output; sponge-based; NIST SP 800-232 (2025) [[1]](https://csrc.nist.gov/pubs/sp/800/232/final) |
| **Ascon permutation** | 2014 | Permutation | 5-round (p_a=12, p_b=6/8) SPN on 5x64-bit state; designed for efficient bitsliced and 32-bit implementations [[1]](https://eprint.iacr.org/2021/1574) |

**State of the art:** NIST selected Ascon as the winner of the Lightweight Cryptography Standardization Process in February 2023, published as NIST SP 800-232. Best cryptanalysis reaches 7 of 12 rounds on the permutation. Hardware implementations achieve <3000 GE. See [Lightweight Symmetric Primitives](#symmetric-encryption) and [Authenticated Encryption (AEAD)](02-authenticated-structured-encryption.md#authenticated-encryption-aead).

**Production readiness:** Experimental
NIST SP 800-232 published in 2025; adoption is beginning in IoT and embedded systems but not yet at scale.

**Implementations:**
- [Ascon reference](https://github.com/ascon/ascon-c) ⭐ 276 — C, official reference implementation
- [ascon-rust](https://github.com/sebastinas/ascon-aead) ⭐ 21 — Rust, Ascon AEAD
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, Ascon permutation variants

**Security status:** Secure
Best cryptanalysis reaches 7 of 12 rounds on the permutation. Extensive analysis during NIST LWC competition found no practical weakness.

**Community acceptance:** Standard
NIST SP 800-232 (2025); winner of the NIST Lightweight Cryptography Standardization Process. Endorsed for constrained environments.

---

### TurboSHAKE and MarsupilamiFourteen

**Goal:** High-performance extendable-output functions (XOFs) derived from reduced-round Keccak, offering faster hashing than SHAKE while retaining comfortable security margins; used as building blocks for protocols, KDFs, and randomness generation.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **TurboSHAKE128 / TurboSHAKE256** | 2023 | XOF | 12-round Keccak-p (vs 24 for SHA-3); 128/256-bit security; domain-separated via single separator byte; NIST SP 800-185 draft [[1]](https://keccak.team/files/TurboSHAKE.pdf) |
| **MarsupilamiFourteen** | 2023 | XOF | 14-round Keccak-p variant; 256-bit security; conservative margin between TurboSHAKE (12 rounds) and full Keccak (24 rounds) [[1]](https://keccak.team/files/TurboSHAKE.pdf) |
| **KangarooTwelve (K12)** | 2016 | XOF | 12-round Keccak-p + Sakura tree hashing for parallelism; same round count as TurboSHAKE but adds tree structure for large inputs [[1]](https://keccak.team/kangarootwelve.html) |

**State of the art:** TurboSHAKE provides ~2x speedup over SHAKE with a 6x security margin against known attacks (best attack reaches 8 of 12 rounds). Increasingly adopted in post-quantum schemes (e.g., ML-KEM and ML-DSA internal hashing). MarsupilamiFourteen offers a middle ground for conservative deployments. See [Hash Functions](#hash-functions) and [Extendable-Output Functions](#hash-functions).

**Production readiness:** Experimental
TurboSHAKE is in NIST SP 800-185 draft and gaining adoption; KangarooTwelve (same round count) is RFC 9560. MarsupilamiFourteen is newer with limited deployment.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C, TurboSHAKE and MarsupilamiFourteen reference by the Keccak team
- [K12](https://github.com/XKCP/K12) ⭐ 52 — C, KangarooTwelve (same 12-round Keccak-p base as TurboSHAKE)

**Security status:** Secure
12-round Keccak-p has a comfortable security margin; best attack reaches 8 rounds. MarsupilamiFourteen's 14 rounds provide additional margin.

**Community acceptance:** Emerging
TurboSHAKE is proposed for NIST SP 800-185 update; KangarooTwelve is IETF RFC 9560. Growing adoption in PQC implementations. Designed by the Keccak team.

---

### Correlation-Robust Hash Functions

**Goal:** Provide hash functions with correlation-robustness properties needed for OT extension, garbled circuits, and other MPC protocols — typically instantiated with fixed-key AES in a specific mode.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fixed-Key AES (correlation-robust)** | 2019 | AES-NI hardware | Guo-Katz-Weng practical instantiation [[1]](https://eprint.iacr.org/2019/074.pdf) |
| **TMMO / MMO / MP constructions** | 2019 | AES-based | Provably correlation-robust under AES assumptions [[2]](https://eprint.iacr.org/2019/074.pdf) |
| **MiMC / HadesMiMC (ZK-friendly)** | 2016/2019 | Low-multiplicative complexity | Preferred in ZK circuit contexts [[3]](https://eprint.iacr.org/2016/492.pdf) |

**State of the art:** Fixed-key AES with the Matyas-Meyer-Oseas (MMO) or Davies-Meyer construction is the practical standard for OT extension (e.g., libOTe, EMP-toolkit). Guo-Katz-Weng 2019 provides the tightest formal justification. See also [Garbled Circuits](../categories/06-multi-party-computation.md#garbled-circuits) and [OT Extension](../categories/06-multi-party-computation.md#oblivious-transfer-ot-and-ot-extension).

**Production readiness:** Production
Used in every high-performance OT extension library. The fixed-key AES approach achieves ~1 billion OTs/second in optimized implementations.

**Implementations:**
- [libOTe](https://github.com/osu-crypto/libOTe) ⭐ 565 — C++, AES-NI accelerated OT/OT-ext
- [EMP-toolkit](https://github.com/emp-toolkit/emp-ot) ⭐ 195 — C++, correlation-robust hash for garbling
- [fancy-garbling](https://github.com/GaloisInc/fancy-garbling) ⭐ 112 — Rust, uses fixed-key AES

**Security status:** Caution
Correlation-robustness is a weaker property than collision resistance. Security relies on AES behaving as an ideal cipher. No standard formal definition covers all uses — implementers must match the construction to the security proof.

**Community acceptance:** Widely trusted
Universally used in MPC/OT implementations. Guo-Katz-Weng analysis is peer-reviewed and widely cited, but not formally standardized.

---


## Digital Signatures

---
### Digital Signatures

**Goal:** Authentication + Integrity + Non-repudiation. Prove that a specific private-key holder signed a message, and anyone with the public key can verify.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ECDSA** | 1992 | Elliptic curves | Widely deployed (TLS, Bitcoin); P-256 or secp256k1 [[1]](https://doi.org/10.1007/s102070100048) |
| **EdDSA (Ed25519 / Ed448)** | 2011 | Twisted Edwards curves | Deterministic, fast, misuse-resistant; RFC 8032 [[1]](https://eprint.iacr.org/2011/368) |
| **Schnorr** | 1989 | DLP | Elegant, provably secure; BIP 340 (Bitcoin Taproot) [[1]](https://link.springer.com/article/10.1007/BF00196725) |
| **RSA-PSS** | 1996 | Factorization | Provably secure RSA variant; PKCS#1 v2.2 [[1]](https://eprint.iacr.org/1996/002) |
| **BLS** | 2001 | Bilinear pairings | Short signatures, native aggregation; Ethereum 2.0 [[1]](https://eprint.iacr.org/2001/002) |
| **Aggregate Signatures** | 2003 | Bilinear pairings | Combine *n* independent signatures into one short sig; used in certificate transparency, Ethereum BLS [[1]](https://eprint.iacr.org/2002/175) |
| **Redactable Signatures** | 2001 | Hash trees | Sign document parts independently; authorized parties can redact sections [[1]](https://link.springer.com/chapter/10.1007/3-540-47719-5_17) |
| **Designated Verifier Sig.** | 1996 | DLP | Only a designated party can verify; non-transferable proof [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_13) |

**State of the art:** Ed25519 (general), BLS (aggregation), Schnorr (multi-sig via [[1]](https://eprint.iacr.org/2020/1261) MuSig2).

**Production readiness:** Production
ECDSA is in TLS and Bitcoin; Ed25519 is in SSH, Signal, and Tor; BLS is in Ethereum 2.0 consensus.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, ECDSA, Ed25519, RSA-PSS
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Ed25519 signing/verification
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/Rust, BLS12-381 signatures, Ethereum-focused
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, Ed25519 with batch verification
- [secp256k1](https://github.com/bitcoin-core/secp256k1) ⭐ 2.4k — C, ECDSA and Schnorr for Bitcoin

**Security status:** Secure
All listed signature schemes are secure at recommended parameters. ECDSA requires careful nonce generation (RFC 6979 deterministic nonces recommended). RSA-PSS requires 2048+ bit keys.

**Community acceptance:** Standard
ECDSA and Ed25519 are NIST/IETF standards (FIPS 186-5, RFC 8032); RSA-PSS is PKCS#1 v2.2; BLS is IETF draft and Ethereum standard; Schnorr is BIP 340.

---

### Batch Verification

**Goal:** Amortized verification. Verify n signatures in significantly less time than n individual verifications — typically using random linear combinations to batch pairing/exponentiation checks into one. Critical for blockchain nodes processing thousands of transactions per block.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Garay-Rabin Batch Verification** | 1998 | Random linear combination | General technique: combine n checks with random coefficients; one multi-exp [[1]](https://doi.org/10.1007/BFb0054136) |
| **BLS Batch Verification** | 2003 | Pairings | Verify n BLS sigs with ~2 pairings + n multi-exp instead of 2n pairings [[1]](https://eprint.iacr.org/2002/029) |
| **Ed25519 Batch Verification** | 2012 | Curve25519 | Batch Schnorr verification; ~3x speedup for 64 signatures [[1]](https://ed25519.cr.yp.to/ed25519-20110926.pdf) |
| **Bulletproofs Batch Verification** | 2018 | Inner product | Batch-verify n range proofs; marginal cost per additional proof [[1]](https://eprint.iacr.org/2017/1066) |

**State of the art:** Random linear combination technique (universal); BLS batch verification in Ethereum consensus. See [Aggregate Signatures](08-signatures-advanced.md#aggregate-signatures-bls-aggregate), [Digital Signatures](#digital-signatures).

**Production readiness:** Production
Ed25519 batch verification is in libsodium and ed25519-dalek. BLS batch verification is in Ethereum 2.0 consensus clients.

**Implementations:**
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, Ed25519 batch verification
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/Rust, BLS12-381 batch verification
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Ed25519 batch verify API

**Security status:** Secure
Batch verification maintains the same security level as individual verification with overwhelming probability (random linear combination technique).

**Community acceptance:** Widely trusted
Batch verification is a standard optimization in blockchain systems. Ed25519 batch verification is in RFC 8032. BLS batch verification is standard in Ethereum consensus.

---


## Pseudorandom Primitives

---
### Puncturable / Constrained PRF

**Goal:** Fine-grained key delegation. A PRF key can be "punctured" at specific points: the punctured key works everywhere *except* those points. Enables forward secrecy without state and 0-RTT key exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Puncturable PRF (Boneh-Waters)** | 2013 | GGM tree | Puncture at any polynomial set of points [[1]](https://eprint.iacr.org/2013/602) |
| **Constrained PRF (BW/KPTZ)** | 2013 | GGM / lattice | Key evaluates only on a constrained input set (e.g., prefix, circuit) [[1]](https://eprint.iacr.org/2013/352) |

**State of the art:** GGM-based puncturable PRFs (used in forward-secure 0-RTT, Bloom Filter Encryption).

**Production readiness:** Research
Theoretical constructions used in academic protocols (forward-secure 0-RTT, Bloom Filter Encryption). No widespread production deployment.

**Implementations:**
- No widely-used standalone libraries. Puncturable PRFs are typically implemented within specific protocol frameworks (e.g., 0-RTT key exchange research prototypes).

**Security status:** Secure
GGM-based puncturable PRFs are provably secure under standard PRG assumptions. Constrained PRFs have clean security proofs.

**Community acceptance:** Niche
Well-studied in the theoretical cryptography community (Boneh-Waters 2013, Kiayias-Papadopoulos-Triandopoulos-Zacharias 2013). Used as building blocks in advanced protocol designs.

---

### Key-Homomorphic PRF

**Goal:** Algebraic key structure. A PRF where outputs are homomorphic with respect to the key: F(k1⊕k2, x) = F(k1,x) ⊕ F(k2,x). Enables distributed PRF evaluation, key rotation, and updatable encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas-Reingold** | 2002 | DDH | F(k,x) = g^{k·H(x)}; perfect key-homomorphism [[1]](https://eprint.iacr.org/1999/018) |
| **Boneh et al. (LWE-based)** | 2013 | LWE lattice | Almost key-homomorphic (small error); post-quantum [[1]](https://eprint.iacr.org/2013/196) |
| **Key-Homomorphic PRF for Group Actions** | 2020 | Isogeny / group action | From group actions; potential PQ KH-PRF [[1]](https://eprint.iacr.org/2019/1188) |

**State of the art:** DDH-based (practical, used in updatable encryption), LWE-based (post-quantum).

**Production readiness:** Experimental
Used in updatable encryption research prototypes and distributed PRF protocols. Limited production deployment.

**Implementations:**
- Research prototypes only. Key-homomorphic PRFs are typically implemented within specific updatable encryption or distributed key rotation systems.

**Security status:** Secure
DDH-based constructions are secure under the DDH assumption. LWE-based constructions provide post-quantum security with a small approximation error.

**Community acceptance:** Niche
Active research area with applications in updatable encryption, key rotation, and distributed PRF evaluation. Not yet standardized.

---

### DRBG (Deterministic Random Bit Generators)

**Goal:** Standardized cryptographic PRNG. Generate pseudorandom bits from an initial seed (entropy) using a deterministic algorithm. All practical crypto depends on DRBG quality — a weak DRBG breaks everything. Must support reseeding, prediction resistance, and backtracking resistance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HMAC-DRBG** | 2006 | HMAC | NIST SP 800-90A; HMAC-based; widely deployed (OpenSSL default) [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **CTR-DRBG** | 2006 | AES-CTR | NIST SP 800-90A; AES in counter mode; hardware-accelerated [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **Hash-DRBG** | 2006 | SHA-256/512 | NIST SP 800-90A; hash-based; simple design [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **Dual_EC_DRBG (withdrawn)** | 2006 | Elliptic curve | **Backdoored by NSA**; withdrawn 2014; cautionary tale [[1]](https://projectbullrun.org/dual-ec/documents.html) |
| **Fortuna** | 2003 | AES + SHA-256 | Ferguson-Schneier; multiple entropy pools; used in FreeBSD, Windows [[1]](https://www.schneier.com/academic/fortuna/) |

**State of the art:** HMAC-DRBG and CTR-DRBG (NIST SP 800-90A); Fortuna for OS-level entropy pooling. Foundation of all practical crypto — see [PRG](#pseudorandom-generators-prg).

**Production readiness:** Production
CTR-DRBG and HMAC-DRBG are deployed in every FIPS-validated cryptographic module. Fortuna is in FreeBSD and Windows.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, CTR-DRBG and HMAC-DRBG (NIST SP 800-90A)
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C, CTR-DRBG
- [Linux kernel](https://github.com/torvalds/linux) ⭐ 225k — C, ChaCha20-based CSPRNG (replaces older designs)
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, HMAC-DRBG, Hash-DRBG

**Security status:** Caution
HMAC-DRBG and CTR-DRBG are secure when properly seeded. Dual_EC_DRBG was backdoored by the NSA and is withdrawn. Entropy source quality is critical for all DRBGs.

**Community acceptance:** Standard
HMAC-DRBG and CTR-DRBG are NIST SP 800-90A. Dual_EC_DRBG was removed from SP 800-90A Rev 1 (2015). Fortuna is widely respected but not formally standardized.

---

### Legendre PRF

**Goal:** Provide an MPC-friendly pseudorandom function based on the Legendre symbol modulo a prime, enabling efficient threshold and distributed PRF evaluation without multiplication-heavy circuits.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Legendre PRF** | 2011 | Number-theoretic (Legendre symbol) | Damgård 1988/Grassi et al. 2022 [[1]](https://eprint.iacr.org/2019/1059.pdf) |
| **Power Residue PRF** | 2019 | Generalization of Legendre symbol | Beullens-Beyne-Bossaers extension [[2]](https://eprint.iacr.org/2019/1530.pdf) |

**State of the art:** The Legendre PRF is of significant interest in MPC and post-quantum contexts because it has very low multiplicative complexity — ideal for secret-shared evaluation. Under active study for use in Ethereum VDF constructions and MPC-friendly PRF applications. Not yet in production systems.

**Production readiness:** Experimental
Academic interest is high (Ethereum Foundation funded research). No production deployments yet. Efficient MPC implementations exist as proofs of concept.

**Implementations:**
- [legendre-prf](https://github.com/csiblock/legendre-prf) ⭐ 12 — Python, research prototype
- [mpc-friendly-prf](https://github.com/KULeuven-COSIC/mpc-friendly-prf) ⭐ 28 — C++, Beyne et al. benchmarks

**Security status:** Caution
Conjectured secure under standard number-theoretic assumptions, but less studied than AES-based PRFs. Best known attacks are subexponential. Parameter sizes need care for long-term security.

**Community acceptance:** Niche
Primarily of interest to MPC researchers and Ethereum Foundation for VDF/randomness beacons. Limited peer review compared to mainstream PRF constructions.

---


## Extractors and Information-Theoretic Primitives

---
### Fuzzy Extractors / Secure Sketches

**Goal:** Biometric key derivation. Derive a stable, reproducible cryptographic key from noisy biometric data (fingerprints, iris, typing patterns) that varies between readings. Sketch leaks minimal entropy about the source.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Reyzin-Smith** | 2004 | Information-theoretic | Formal definitions; Gen/Rep paradigm [[1]](https://eprint.iacr.org/2003/235) |
| **Boyen Fuzzy IBE** | 2004 | Pairings + error-tolerance | Identity-based encryption with biometric keys [[1]](https://eprint.iacr.org/2004/086) |
| **Computational Fuzzy Extractors** | 2013 | Computational assumptions | Relaxed model; better parameters for real biometrics [[1]](https://eprint.iacr.org/2013/416) |

**State of the art:** Computational Fuzzy Extractors (practical biometric systems), Dodis-Reyzin-Smith (theoretical foundation).

**Production readiness:** Experimental
Deployed in some biometric authentication systems and PUF key generation, but not standardized at scale.

**Implementations:**
- [NIST SP 800-90B](https://csrc.nist.gov/publications/detail/sp/800-90b/final) — entropy source validation (related framework)
- [fuzzy-extractor](https://github.com/hbhdytf/Fuzzy-extractor) ⭐ 9 — Python, reference implementation of Gen/Rep

**Security status:** Secure
Information-theoretically sound (Dodis-Reyzin-Smith) or computationally secure under standard assumptions. Security depends on accurate min-entropy estimation of the biometric source.

**Community acceptance:** Niche
Well-studied in the academic community; used in biometric and PUF applications. No NIST/IETF standard specifically for fuzzy extractors, but the concepts underlie NIST SP 800-90B.

---


## Trapdoor and Structural Primitives

---
### Ristretto255 / Decaf (Prime-Order Group Abstractions)

**Goal:** Provide a prime-order group over an efficient elliptic curve (Curve25519 / Ed448-Goldilocks) by quotienting out the cofactor — eliminating small-subgroup attacks and cofactor-related pitfalls while retaining the speed advantage of the underlying curve.

**The cofactor problem:**
- Curve25519 has cofactor 8 (group order = 8 × prime p)
- Standard X25519/Ed25519 implementations must carefully handle cofactors
- Failing to do so: small-subgroup attacks in DH, key recovery in group signatures, ECDSA nonce bias
- Protocols requiring a prime-order group (e.g., Schnorr signatures, OPRFs, anonymous credentials) cannot safely use raw Curve25519 without cofactor clearing

**Ristretto255 (RFC 9496, 2023):**
- Defines a prime-order group of order 2²⁵² + 27742317777372353535851937790883648493
- Points are equivalence classes of Ed25519 points: one Ristretto point ↔ four Ed25519 points
- Encoding/decoding maps are bijective and uniform → no distinguishable structure
- Arithmetic is Ed25519 internally; overhead: ~2 field muls for encode/decode

**Decaf (RFC 9496, 2023 — Decaf448):**
- Same idea over Ed448-Goldilocks (cofactor 4)
- 56-byte compressed point encoding
- Higher security level: ~224-bit classical, ~112-bit quantum

| Scheme | Curve | Group order | RFC |
|--------|-------|-------------|-----|
| **Ristretto255** | Curve25519 | ~2²⁵² | RFC 9496 |
| **Decaf448** | Ed448 | ~2⁴⁴⁶ | RFC 9496 |

**Used in:** OPAQUE (RFC 9106), Privacy Pass (VOPRF, RFC 9497), Signal Anonymous Credentials (Ristretto255 + CMZ), FROST threshold signatures, many ZK protocols requiring prime-order groups.

**State of the art:** RFC 9496 (2023) standardizes both. Ristretto255 is the preferred prime-order group for new CFRG protocols on the 128-bit security level — replaces ad-hoc cofactor clearing.

**Production readiness:** Production
Ristretto255 is used in OPAQUE, Privacy Pass (VOPRF), Signal anonymous credentials, and FROST threshold signatures.

**Implementations:**
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, ristretto255 with full API
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ristretto255 (crypto_core_ristretto255)
- [ristretto255-group](https://github.com/gtank/ristretto255) ⭐ 110 — Go, ristretto255 implementation

**Security status:** Secure
Ristretto255 provides a clean prime-order group abstraction, eliminating cofactor-related attacks. Security reduces to the hardness of the discrete log on Curve25519.

**Community acceptance:** Standard
RFC 9496 (2023) is an IETF standard. Ristretto255 is the recommended prime-order group for CFRG protocols. Widely adopted in the Rust cryptography ecosystem.

---

### jq255 (jq255e and jq255s Prime-Order Groups)

**Goal:** Compact, exception-free, constant-time-friendly prime-order elliptic-curve groups for 128-bit security. Each group element fits in 32 bytes with canonical encoding (single representation per element, decoder rejects invalid encodings → no invalid-curve attacks, no cofactor issues). Alternative to [Ristretto255](#ristretto255--decaf-prime-order-group-abstractions) with smaller scalars (~254 bits) and a fast endomorphism on jq255e for accelerated scalar multiplication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **jq255e** | 2022 | Edwards curve over GF(2^255 − 18651) + endomorphism | Prime-order group of order ≈ 2^254; ~25% faster mul via GLV endomorphism [[1]](https://c2sp.org/jq255) |
| **jq255s** | 2022 | Short-Weierstrass / Edwards over GF(2^255 − 3957) | Prime-order group; no endomorphism but simpler reductions [[1]](https://c2sp.org/jq255) |
| **jq255e/s Key Exchange + Signatures** | 2022 | DH + Schnorr over jq255 | Companion KEX and signature ciphersuites defined in the spec [[1]](https://c2sp.org/jq255) |

**State of the art:** Designed by Thomas Pornin (NCC Group); published as C2SP spec 2022. Competes with [Ristretto255](#ristretto255--decaf-prime-order-group-abstractions) and the [Decaf](#ristretto255--decaf-prime-order-group-abstractions) family for clean prime-order group APIs. Particularly attractive on constrained microcontrollers due to small/canonical encoding and endomorphism-accelerated jq255e.

**Production readiness:** Experimental
Reference implementations in C/Go/Python by Thomas Pornin (doubleodd org); no major protocol has standardized on jq255 yet. Best regarded as a research-quality alternative.

**Implementations:**
- [doubleodd/c-jq255](https://github.com/doubleodd/c-jq255) ⭐ 1 — C, reference implementation
- [doubleodd/go-jq255](https://github.com/doubleodd/go-jq255) ⭐ 0 — Go port
- [doubleodd/py-jq255](https://github.com/doubleodd/py-jq255) ⭐ 0 — Python port

**Security status:** Secure
Discrete log security at the ~127-bit level (group order ≈ 2^254). No known attacks on the underlying curves; endomorphism on jq255e is well-understood (GLV-style). Constant-time formulas without exceptional cases.

**Community acceptance:** Niche
C2SP spec exists; cited in cryptographic engineering circles but no IETF/NIST track. Most new CFRG protocols continue to standardize on Ristretto255.

---
