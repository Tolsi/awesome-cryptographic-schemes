# Foundational Primitives

## Symmetric Encryption

**Goal:** Confidentiality. Encrypt data with a single shared secret key so that only those who know the key can read it.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **AES-256** | 2001 | Block cipher | De-facto standard (NIST), 128-bit block, 256-bit key [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **ChaCha20** | 2008 | Stream cipher | Fast in software, constant-time; used in TLS 1.3, WireGuard [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf) |
| **Salsa20** | 2005 | Stream cipher | Predecessor to ChaCha20, eSTREAM portfolio [[1]](https://cr.yp.to/snuffle/salsafamily-20071225.pdf) |
| **Serpent** | 1998 | Block cipher | AES finalist, conservative security margin [[1]](https://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf) |
| **Camellia** | 2000 | Block cipher | ISO/IEC standard, comparable to AES [[1]](https://tools.ietf.org/html/rfc3713) |

**State of the art:** AES-256 (hardware-accelerated via [[1]](https://en.wikipedia.org/wiki/AES_instruction_set) AES-NI) and ChaCha20 for software-only environments.

---

## Asymmetric (Public-Key) Encryption

**Goal:** Confidentiality without pre-shared keys. A sender encrypts with the recipient's public key; only the recipient's private key can decrypt.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **RSA-OAEP** | 1977 | Integer factorization | First practical PKE; 2048+ bit keys recommended [[1]](https://dl.acm.org/doi/10.1145/359340.359342) |
| **ECIES** | 2001 | Elliptic Curve Diffie-Hellman | Hybrid: ECDH + symmetric enc; compact keys [[1]](https://eprint.iacr.org/1999/007) |
| **DHIES / DHAES** | 1999 | Diffie-Hellman | Provably CCA2-secure hybrid scheme [[1]](https://shoup.net/papers/iso-2_1.pdf) |
| **Cramer-Shoup** | 1998 | DDH | First practical CCA2-secure scheme without random oracles [[1]](https://eprint.iacr.org/1998/008) |
| **HPKE** | 2022 | Hybrid KEM/DEM | Modern standard (RFC 9180): KEM + AEAD + KDF [[1]](https://www.rfc-editor.org/rfc/rfc9180) |

**State of the art:** HPKE (RFC 9180) with X25519 KEM + [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) AES-256-GCM — used in TLS Encrypted Client Hello, MLS, OHTTP.

---

## Hash Functions

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

---

## Message Authentication Codes (MAC)

**Goal:** Integrity + Authentication. Verify that a message was not altered and comes from someone who knows the shared key.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **HMAC** | 1996 | Hash-based | HMAC-SHA256 is the workhorse; provably secure if hash is PRF [[1]](https://csrc.nist.gov/publications/detail/fips/198/1/final) |
| **CMAC** | 2005 | Block cipher | Based on CBC-MAC; NIST SP 800-38B [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/b/final) |
| **GMAC** | 2004 | GF(2^128) | MAC-only mode of GCM; very fast with AES-NI [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **Poly1305** | 2005 | Polynomial | One-time MAC; used with ChaCha20 in TLS 1.3 [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **KMAC** | 2016 | Keccak | SHA-3-based MAC; NIST SP 800-185 [[1]](https://csrc.nist.gov/publications/detail/sp/800/185/final) |

**State of the art:** HMAC-SHA256 (general), Poly1305 (high speed, paired with ChaCha20).

---

## Digital Signatures

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

---

## Pseudorandom Functions (PRF) & Pseudorandom Permutations (PRP)

**Goal:** Security foundation. A PRF is indistinguishable from a truly random function; a PRP from a random permutation. Underlies MACs, KDFs, stream ciphers, OT, and garbled circuits.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGM PRF** | 1986 | PRG tree | First PRF from any one-way function; tree construction [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **Naor-Reingold PRF** | 1997 | DDH / EC | Efficient number-theoretic construction [[1]](https://dl.acm.org/doi/10.1145/258533.258592) |
| **AES as PRP** | 2001 | Block cipher | De-facto standard PRP instantiation [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **HMAC as PRF** | 1996 | Hash (NMAC) | Proven PRF assuming compression fn is PRF [[1]](https://csrc.nist.gov/publications/detail/fips/198/1/final) |

**State of the art:** AES-128/256 (PRP, hardware-accelerated), HMAC-SHA256 (PRF in software).

---

## Pseudorandom Generators (PRG)

**Goal:** Stretch randomness. A PRG takes a short truly random seed and outputs a longer string indistinguishable from random. The most basic cryptographic primitive — PRFs, stream ciphers, commitments, and ZK all build on PRGs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum-Micali PRG** | 1984 | DLP | First PRG from discrete log; output = hard-core bit of g^x [[1]](https://dl.acm.org/doi/10.1145/800057.808667) |
| **Blum-Blum-Shub (BBS)** | 1986 | Quadratic residuosity | x_{n+1} = x_n² mod N; provably secure under factoring [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_8) |
| **GGM PRG→PRF** | 1986 | Any PRG | PRG is sufficient to build PRF (tree construction); see [PRF](#pseudorandom-functions-prf--pseudorandom-permutations-prp) [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **AES-CTR as PRG** | 2001 | Block cipher in CTR mode | Practical: AES in counter mode is a fast PRG [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf) |
| **ChaCha20 as PRG** | 2008 | Stream cipher | ChaCha20(key, counter) outputs pseudorandom stream; see [Symmetric Encryption](#symmetric-encryption) [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf) |

**State of the art:** AES-CTR / ChaCha20 (practical PRGs), Blum-Micali (theoretical foundation). PRG → PRF → PRP is the fundamental hierarchy of pseudorandomness.

---

## Randomness Extractors

**Goal:** Entropy purification. Convert weakly random sources (physical noise, biased bits, blockchain hashes) into nearly uniform random bits suitable for cryptographic keys. Foundation of all practical randomness.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Leftover Hash Lemma (ILL)** | 1989 | Universal hashing | Foundational: 2-universal hash family extracts randomness [[1]](https://dl.acm.org/doi/10.1145/73007.73009) |
| **Trevisan's Extractor** | 1999 | List-decodable codes | Near-optimal seed length; from error-correcting codes [[1]](https://dl.acm.org/doi/10.1145/301250.301292) |
| **Two-Source Extractors** | 2016 | Combinatorial | Extract from two independent weak sources; breakthrough [[1]](https://dl.acm.org/doi/10.1145/2897518.2897528) |

**State of the art:** Leftover Hash Lemma (practical), HKDF uses extract-then-expand pattern.

---

## Fuzzy Extractors / Secure Sketches

**Goal:** Biometric key derivation. Derive a stable, reproducible cryptographic key from noisy biometric data (fingerprints, iris, typing patterns) that varies between readings. Sketch leaks minimal entropy about the source.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Reyzin-Smith** | 2004 | Information-theoretic | Formal definitions; Gen/Rep paradigm [[1]](https://eprint.iacr.org/2003/235) |
| **Boyen Fuzzy IBE** | 2004 | Pairings + error-tolerance | Identity-based encryption with biometric keys [[1]](https://eprint.iacr.org/2004/086) |
| **Computational Fuzzy Extractors** | 2013 | Computational assumptions | Relaxed model; better parameters for real biometrics [[1]](https://eprint.iacr.org/2013/416) |

**State of the art:** Computational Fuzzy Extractors (practical biometric systems), Dodis-Reyzin-Smith (theoretical foundation).

---

## One-Time Pad / Information-Theoretic Security

**Goal:** Perfect secrecy. The only encryption scheme proven unconditionally secure (Shannon 1949): a truly random key as long as the message, used exactly once. Ciphertext reveals zero information about the plaintext regardless of adversary's computational power.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Vernam Cipher (One-Time Pad)** | 1917 | XOR with random key | C = M ⊕ K; key must be truly random, |K| ≥ |M|, never reused [[1]](https://ieeexplore.ieee.org/document/6769090) |
| **Shannon's Theorem** | 1949 | Information theory | Perfect secrecy ⟺ H(K) ≥ H(M); OTP is optimal [[1]](https://ieeexplore.ieee.org/document/6769090) |
| **Two-Time Pad Attack** | — | XOR | If key is reused: C1 ⊕ C2 = M1 ⊕ M2 — catastrophic failure; demonstrates why reuse is fatal |

**State of the art:** OTP is used in diplomatic/military hotlines and combined with QKD for information-theoretically secure channels.

---

## Trapdoor Functions / Trapdoor Permutations

**Goal:** One-way with a backdoor. A function easy to compute but hard to invert — unless you know the secret trapdoor. Foundation of all public-key encryption: anyone can encrypt (evaluate), only the key holder can decrypt (invert).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Function** | 1977 | Factoring | f(x) = x^e mod N; trapdoor = (p,q); first TDP; see [Asymmetric Encryption](#asymmetric-public-key-encryption) [[1]](https://dl.acm.org/doi/10.1145/359340.359342) |
| **Rabin Function** | 1979 | Factoring | f(x) = x² mod N; provably hard as factoring; 2-to-1 [[1]](https://apps.dtic.mil/sti/pdfs/ADA078416.pdf) |
| **Goldreich-Levin Hard-Core Predicate** | 1989 | Any OWF | Extract a hard-core bit from any one-way function; foundational [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **Lattice Trapdoors (Gentry-Peikert-Vaikuntanathan)** | 2008 | LWE / SIS | PQ trapdoor from lattices; basis of lattice IBE and sigs [[1]](https://eprint.iacr.org/2007/432) |
| **Lossy Trapdoor Functions (Peikert-Waters)** | 2008 | DDH / LWE | Injective or lossy mode; enables CCA security [[1]](https://eprint.iacr.org/2007/279) |

**State of the art:** RSA (deployed), Lattice trapdoors (PQ), Lossy TDFs (clean CCA proofs).

---

## Universal Hash Functions (Carter-Wegman)

**Goal:** Fast, provably collision-resistant hashing with a key. Unlike cryptographic hashes, security is information-theoretic (depends only on key randomness). Foundation of Poly1305, UMAC, randomness extraction, and commitments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Carter-Wegman UHF** | 1979 | Polynomial / matrix | Original universal hash family; collision prob ≤ 1/p [[1]](https://dl.acm.org/doi/10.1145/800105.803400) |
| **Poly1305 (as UHF)** | 2005 | Polynomial over GF(2^130-5) | Fast UHF component; combined with cipher for MAC [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **GHASH** | 2004 | GF(2^128) multiplication | UHF inside AES-GCM; hardware-accelerated via PCLMULQDQ [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **UMAC / VMAC** | 1999 | NH + polynomial | Very fast MAC from universal hashing [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/umac-full.pdf) |

**State of the art:** GHASH (AES-GCM hardware), Poly1305 (software), Carter-Wegman paradigm (theoretical foundation).

---

## Correlation-Intractable Hash Functions

**Goal:** Secure Fiat-Shamir for all NP. A hash function H is correlation-intractable for a relation R if no one can find x such that R(x, H(x)) holds. Enables provably secure non-interactive proofs from interactive ones via Fiat-Shamir — resolving a decades-old open question.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti CI Hash (definition)** | 2001 | — | Formal definition; showed no CI hash for all relations in standard model [[1]](https://eprint.iacr.org/1998/015) |
| **Peikert-Shiehian CI from LWE** | 2019 | LWE | First CI hash for all efficiently searchable relations; Fiat-Shamir for NP [[1]](https://eprint.iacr.org/2018/1004) |
| **Canetti-Chen-Holmgren-Lombardi-Rothblum-Rothblum** | 2019 | LWE | CI hash for bounded-depth relations; simpler construction [[1]](https://eprint.iacr.org/2018/1003) |

**State of the art:** CI hash from LWE (Peikert-Shiehian 2019); proves Fiat-Shamir sound for NP under standard assumptions. Connects [Sigma Protocols](#sigma-protocols--schnorr-identification) and [NIZK](#zero-knowledge-proofs-zk).

---

## Universal One-Way Hash Functions (UOWHF)

**Goal:** Weaker-than-collision-resistance hashing. Adversary commits to x₁ before seeing the hash key, then cannot find x₂ ≠ x₁ with the same hash. Weaker than collision resistance but sufficient for signatures, CCA encryption, and more — and exists under weaker assumptions (any OWF).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Yung UOWHF** | 1989 | Any one-way function | First UOWHF; exists if any OWF exists (vs CR needs stronger assumptions) [[1]](https://doi.org/10.1145/73007.73011) |
| **Rompel UOWHF from OWF** | 1990 | Any OWF | Proved UOWHF from any OWF; simplified by Katz-Koo-Shin [[1]](https://doi.org/10.1145/100216.100269) |
| **UOWHF for Signatures (Bellare-Rogaway)** | 1997 | UOWHF + OWF | Hash-and-sign paradigm: UOWHF suffices (CR not needed) [[1]](https://eprint.iacr.org/2006/285) |

**State of the art:** UOWHF = target collision resistance; foundational for minimal-assumption cryptography. Weaker than [Hash Functions](#hash-functions) (collision resistance) but sufficient for most applications.

---

## Sponge Construction / Duplex

**Goal:** Versatile primitive. A single permutation-based construction that can serve as hash, MAC, stream cipher, AEAD, PRG, and KDF — all from one core design. Replaces the need for separate block-cipher modes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sponge Construction** | 2007 | Permutation | Absorb input, squeeze output; basis of SHA-3 (Keccak) [[1]](https://keccak.team/files/SpongeFunctions.pdf) |
| **Duplex Construction** | 2010 | Permutation | Online variant: interleave absorb/squeeze for authenticated encryption [[1]](https://keccak.team/files/SpongeDuplex.pdf) |
| **Keccak / SHA-3** | 2012 | 1600-bit permutation | NIST SHA-3 standard (FIPS 202); 24-round Keccak-f [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **STROBE** | 2017 | Keccak-f[1600] | Protocol framework: one sponge instance handles all symmetric operations [[1]](https://strobe.sourceforge.io/papers/strobe-20170130.pdf) |
| **Xoodyak** | 2020 | Xoodoo permutation | Lightweight duplex; NIST LWC finalist for constrained devices [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/xoodyak-spec-final.pdf) |

**State of the art:** SHA-3/Keccak (FIPS 202) dominant; STROBE for protocol-level use; Xoodyak for IoT. The sponge paradigm underpins most modern permutation-based crypto.

---

## Lightweight Cryptography / ASCON

**Goal:** Secure encryption and hashing for constrained devices. AES is too heavy for many IoT microcontrollers. Lightweight ciphers provide AEAD and hashing with minimal gate count, RAM, and energy — without sacrificing security.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ASCON** | 2019 | Sponge / permutation | **NIST LWC standard (2023)**; AEAD + hash; 320-bit state, tiny footprint [[1]](https://ascon.iaik.tugraz.at/) |
| **GIFT-COFB** | 2020 | Block cipher (GIFT-128) | Combined feedback mode; NIST LWC finalist [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/gift-cofb-spec-final.pdf) |
| **PHOTON-Beetle** | 2020 | Sponge (PHOTON) | Lightweight AEAD + hash; NIST LWC finalist [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/photon-beetle-spec-final.pdf) |
| **PRESENT** | 2007 | SPN block cipher | 64-bit block, 80/128-bit key; ISO/IEC 29192-2 standard [[1]](https://link.springer.com/chapter/10.1007/978-3-540-74735-2_31) |
| **SIMON / SPECK** | 2013 | Feistel / ARX | NSA designs for IoT; SIMON (hardware), SPECK (software) [[1]](https://eprint.iacr.org/2013/404) |

**State of the art:** ASCON (NIST standard 2023); designed for constrained devices (see also [Sponge Construction](#sponge-construction--duplex) for the underlying paradigm).

---

## ZK-Friendly Hash Functions (Arithmetization-Oriented)

**Goal:** Hash functions optimized for ZK circuits. Standard hashes (SHA-256, BLAKE) have massive circuit size in ZK; arithmetization-oriented hashes minimize multiplicative depth and constraint count, enabling 10-100x speedup for in-SNARK hashing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Poseidon** | 2019 | Partial SPN over Fp | First widely-deployed ZK hash; S-box = x^α over prime field [[1]](https://eprint.iacr.org/2019/458) |
| **Poseidon2** | 2023 | Improved Poseidon | 2-4x faster than Poseidon; optimized linear layer [[1]](https://eprint.iacr.org/2023/323) |
| **Anemoi / Jive** | 2023 | Flystel S-box | Novel "Flystel" structure + Jive compression; 2x improvement over Poseidon in R1CS [[1]](https://eprint.iacr.org/2022/840) |
| **Griffin** | 2022 | Degree-3 S-box | Distinct non-linear/linear interaction; optimized for Groth16 [[1]](https://eprint.iacr.org/2022/403) |
| **Reinforced Concrete** | 2022 | Lookup-table + algebraic | Combines lookup-based "bricks" with algebraic structure; CCS 2022 [[1]](https://eprint.iacr.org/2021/1038) |
| **Tip5** | 2023 | Lookup-based (AIR) | Optimized for STARK/AIR proof systems; lookup-table S-box [[1]](https://eprint.iacr.org/2023/107) |

**State of the art:** Poseidon2 (general ZK), Tip5 (STARKs), Reinforced Concrete (R1CS). A new primitive class bridging [Hash Functions](#hash-functions) and [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Fujisaki-Okamoto Transform

**Goal:** CPA→CCA upgrade. Transform any CPA-secure public-key encryption or KEM into a CCA-secure one. Used in ALL NIST post-quantum KEMs (ML-KEM, etc.).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fujisaki-Okamoto (original)** | 1999 | ROM (random oracle model) | Hybrid: PKE + symmetric enc; CCA from CPA [[1]](https://link.springer.com/chapter/10.1007/978-3-540-48405-1_32) |
| **FO⊥ / FO⊥̸ (variants)** | 2017 | QROM | Quantum-safe variants; used in ML-KEM (Kyber), NTRU [[1]](https://eprint.iacr.org/2017/604) |
| **OAEP (Bellare-Rogaway)** | 1994 | ROM | Earlier CPA→CCA transform specific to RSA [[1]](https://eprint.iacr.org/1994/009) |

**State of the art:** FO⊥̸ transform (QROM-secure) — mandatory component in all NIST PQ KEMs.

---

## Puncturable / Constrained PRF

**Goal:** Fine-grained key delegation. A PRF key can be "punctured" at specific points: the punctured key works everywhere *except* those points. Enables forward secrecy without state and 0-RTT key exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Puncturable PRF (Boneh-Waters)** | 2013 | GGM tree | Puncture at any polynomial set of points [[1]](https://eprint.iacr.org/2013/602) |
| **Constrained PRF (BW/KPTZ)** | 2013 | GGM / lattice | Key evaluates only on a constrained input set (e.g., prefix, circuit) [[1]](https://eprint.iacr.org/2013/352) |

**State of the art:** GGM-based puncturable PRFs (used in forward-secure 0-RTT, Bloom Filter Encryption).

---

## Key-Homomorphic PRF

**Goal:** Algebraic key structure. A PRF where outputs are homomorphic with respect to the key: F(k1⊕k2, x) = F(k1,x) ⊕ F(k2,x). Enables distributed PRF evaluation, key rotation, and updatable encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas-Reingold** | 2002 | DDH | F(k,x) = g^{k·H(x)}; perfect key-homomorphism [[1]](https://eprint.iacr.org/1999/018) |
| **Boneh et al. (LWE-based)** | 2013 | LWE lattice | Almost key-homomorphic (small error); post-quantum [[1]](https://eprint.iacr.org/2013/196) |
| **Key-Homomorphic PRF for Group Actions** | 2020 | Isogeny / group action | From group actions; potential PQ KH-PRF [[1]](https://eprint.iacr.org/2019/1188) |

**State of the art:** DDH-based (practical, used in updatable encryption), LWE-based (post-quantum).

---

## Ristretto255 / Decaf (Prime-Order Group Abstractions)

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

---

## DRBG (Deterministic Random Bit Generators)

**Goal:** Standardized cryptographic PRNG. Generate pseudorandom bits from an initial seed (entropy) using a deterministic algorithm. All practical crypto depends on DRBG quality — a weak DRBG breaks everything. Must support reseeding, prediction resistance, and backtracking resistance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HMAC-DRBG** | 2006 | HMAC | NIST SP 800-90A; HMAC-based; widely deployed (OpenSSL default) [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **CTR-DRBG** | 2006 | AES-CTR | NIST SP 800-90A; AES in counter mode; hardware-accelerated [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **Hash-DRBG** | 2006 | SHA-256/512 | NIST SP 800-90A; hash-based; simple design [[1]](https://csrc.nist.gov/pubs/sp/800/90/a/r1/final) |
| **Dual_EC_DRBG (withdrawn)** | 2006 | Elliptic curve | **Backdoored by NSA**; withdrawn 2014; cautionary tale [[1]](https://projectbullrun.org/dual-ec/documents.html) |
| **Fortuna** | 2003 | AES + SHA-256 | Ferguson-Schneier; multiple entropy pools; used in FreeBSD, Windows [[1]](https://www.schneier.com/academic/fortuna/) |

**State of the art:** HMAC-DRBG and CTR-DRBG (NIST SP 800-90A); Fortuna for OS-level entropy pooling. Foundation of all practical crypto — see [PRG](#pseudorandom-generators-prg).

---

## Batch Verification

**Goal:** Amortized verification. Verify n signatures in significantly less time than n individual verifications — typically using random linear combinations to batch pairing/exponentiation checks into one. Critical for blockchain nodes processing thousands of transactions per block.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Garay-Rabin Batch Verification** | 1998 | Random linear combination | General technique: combine n checks with random coefficients; one multi-exp [[1]](https://doi.org/10.1007/BFb0054136) |
| **BLS Batch Verification** | 2003 | Pairings | Verify n BLS sigs with ~2 pairings + n multi-exp instead of 2n pairings [[1]](https://eprint.iacr.org/2002/029) |
| **Ed25519 Batch Verification** | 2012 | Curve25519 | Batch Schnorr verification; ~3x speedup for 64 signatures [[1]](https://ed25519.cr.yp.to/ed25519-20110926.pdf) |
| **Bulletproofs Batch Verification** | 2018 | Inner product | Batch-verify n range proofs; marginal cost per additional proof [[1]](https://eprint.iacr.org/2017/1066) |

**State of the art:** Random linear combination technique (universal); BLS batch verification in Ethereum consensus. See [Aggregate Signatures](#aggregate-signatures-bls-aggregate), [Digital Signatures](#digital-signatures).

---
