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

## Feistel Networks (Luby-Rackoff Construction)

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

---

## Block Cipher Modes of Operation

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

---

## Block-Cipher-Based Hash Compression Functions

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

---

## Password Hashing & Memory-Hard KDFs

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

**State of the art:** Argon2id (RFC 9106, PHC winner) is the current recommendation for new systems. bcrypt and PBKDF2 remain dominant in legacy deployments. See [Key Exchange & KDFs](categories/03-key-exchange-key-management.md) for general-purpose KDFs.

---

## HKDF (Extract-and-Expand Key Derivation)

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

---

## Hardware-Oriented Stream Ciphers (eSTREAM / 3GPP)

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

## SM4 / Chinese National Standard Block Ciphers

**Goal:** Sovereign symmetric encryption. China's national commercial cryptography standards define a family of block ciphers and stream ciphers that serve as mandatory alternatives to AES in Chinese critical infrastructure, finance, and government systems — and increasingly in international standards via ISO/IEC.

| Algorithm | Year | Type | Note |
|-----------|------|------|------|
| **SM4** | 2006 | Block cipher (SPN) | 128-bit block, 128-bit key, 32 rounds; Feistel-like with 8×8 S-box; Chinese national standard GB/T 32907-2016; ISO/IEC 18033-3/Amd.1 (2021) [[1]](https://www.rfc-editor.org/rfc/rfc8998) |
| **SM1** | 2006 | Block cipher | 128-bit block/key; classified algorithm; hardware-only (used in smart cards, IC chips) [[1]](https://en.wikipedia.org/wiki/SM1_(cipher)) |
| **SSF33 / SM0** | ~2000 | Block cipher | Earlier classified predecessor; used in WLAN WAPI [[1]](https://en.wikipedia.org/wiki/WAPI) |
| **ZUC (祖冲之)** | 2011 | Stream cipher | 128-bit key; eEA3/eIA3 in LTE/5G; also see [Hardware Stream Ciphers](#hardware-oriented-stream-ciphers-estream--3gpp) [[1]](https://www.gsma.com/security/wp-content/uploads/2019/05/ZUC_specification_3.pdf) |

**SM4 structure:** 32-round Type-2 Feistel variant; non-linear layer uses a single 8×8 S-box applied four times; linear diffusion via the τ and L transforms. Constant-time implementations exist and TLS 1.3 cipher suites are standardized (RFC 8998).

**State of the art:** SM4 is mandatory in China's TLCP/GM standard and supported in TLS 1.3 via RFC 8998 (2021). ISO/IEC 18033-3:2010/Amd.1:2021 makes it an international standard. Widely deployed in Chinese banking (UnionPay), government PKI, and 5G networks.

---

## ARIA Block Cipher

**Goal:** Sovereign symmetric encryption (Korea). A national-standard 128-bit block cipher for Korean government and public-sector cryptography, designed as an independent alternative to AES while matching its security levels and supporting the same key sizes.

| Variant | Key size | Rounds | Note |
|---------|----------|--------|------|
| **ARIA-128** | 128 bit | 12 | Korean standard KS X 1213:2004; RFC 5794 [[1]](https://www.rfc-editor.org/rfc/rfc5794) |
| **ARIA-192** | 192 bit | 14 | Extended key schedule; same block size [[1]](https://www.rfc-editor.org/rfc/rfc5794) |
| **ARIA-256** | 256 bit | 16 | Highest security level; 16 rounds [[1]](https://www.rfc-editor.org/rfc/rfc5794) |

**Structure:** Substitution-permutation network (SPN) closely related to AES; uses two 8×8 S-boxes and their inverses alternating across rounds, plus a 128-bit binary matrix for diffusion. Efficient on 32-bit processors; PKCS#11 support since 2007; TLS cipher suites in RFC 6209.

**State of the art:** ARIA is the South Korean national standard (KS X 1213:2004); specified in RFC 5794 (2010) and RFC 6209 (TLS). Mandatory for Korean government systems; also used in Korean financial sector and e-government. No practical attacks beyond those on the full AES.

---

## Tweakable Block Ciphers (LRW / XEX / XTS)

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

---

## Even-Mansour Construction

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

---

## SipHash

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

---

## Merkle-Damgård Construction

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

---

## RC4 Stream Cipher (Historical)

**Goal:** Fast software stream cipher. RC4 (Rivest Cipher 4) was the dominant stream cipher for two decades: used in SSL/TLS, WEP, WPA-TKIP, PDF, and SSH. Its byte-at-a-time output and minimal code size made it ubiquitous in embedded and software environments. It is now fully broken and prohibited in all new protocols.

| Variant | Year | Key size | Note |
|---------|------|----------|------|
| **RC4 (ARC4)** | 1987 | 40–2048 bit | Alleged RC4; 256-byte S-box state; Fluhrer-Mantin-Shamir (2001) attack cracks WEP [[1]](https://link.springer.com/chapter/10.1007/3-540-45537-X_1) |
| **RC4-drop[n]** | 2006 | — | Drop first n bytes (typically 256 or 3072) of keystream to mitigate bias; insufficient [[1]](https://eprint.iacr.org/2005/007) |
| **WEP** | 1999 | 40/104 bit | 802.11 protocol using RC4; IV reuse + FMS attack → key recovery in minutes; **deprecated** [[1]](https://link.springer.com/chapter/10.1007/3-540-45537-X_1) |
| **BEAST / POODLE / RC4 in TLS** | 2011–2015 | — | Series of attacks on RC4 in TLS; RFC 7465 (2015) **prohibits RC4 in TLS** [[1]](https://www.rfc-editor.org/rfc/rfc7465) |

**Why it failed:** RC4's key-scheduling algorithm (KSA) produces biased initial keystream bytes and short-cycle weaknesses. The keystream byte at position 2 is biased toward 0 with probability 2/256 instead of 1/256. Statistical attacks accumulate bias across many sessions to recover plaintexts. Additionally, if two messages share an IV (as in WEP), XOR of ciphertexts reveals XOR of plaintexts.

**State of the art:** RC4 is fully prohibited — RFC 7465 bans it in TLS; NIST and IETF documentation mark it deprecated. For stream encryption use ChaCha20 (see [Symmetric Encryption](#symmetric-encryption)) or AES-CTR (see [Block Cipher Modes of Operation](#block-cipher-modes-of-operation)).

---

## Software-Oriented eSTREAM Stream Ciphers (Rabbit / HC-128)

**Goal:** High-throughput software stream encryption with small state and simple implementation. The eSTREAM competition (2004–2008) Profile 1 selected stream ciphers optimized for general-purpose CPUs, filling the gap between AES-CTR (slower on non-AES-NI hardware) and ChaCha20 (which did not yet exist). These designs achieve 2–4 cycles/byte on 32-bit platforms.

| Cipher | Year | State | Note |
|--------|------|-------|------|
| **Rabbit** | 2003 | 128-bit state + 64-bit IV | eSTREAM Profile 1 finalist; 8 counters + 8 state words; ~3.7 cycles/byte on x86; RFC 4503 [[1]](https://www.rfc-editor.org/rfc/rfc4503) |
| **HC-128** | 2004 | 4 KB (two 512-entry tables) | eSTREAM Profile 1 winner; ~3.05 cycles/byte (x86); 128-bit key, 128-bit IV [[1]](https://link.springer.com/chapter/10.1007/978-3-540-68351-3_9) |
| **HC-256** | 2004 | 8 KB (two 1024-entry tables) | Higher-security variant; 256-bit key, 256-bit IV; slower but large-table ensures no algebraic shortcuts [[1]](https://eprint.iacr.org/2004/092) |
| **SOSEMANUK** | 2005 | 160-bit LFSR + 32-bit FSM | eSTREAM Profile 1 winner; Serpent-derived S-box; fast in software [[1]](https://eprint.iacr.org/2005/028) |

**eSTREAM Profile 1 portfolio (2008):** HC-128, Rabbit, Salsa20/12, SOSEMANUK — all selected for software environments. Salsa20 and ChaCha20 ultimately displaced all others due to constant-time, cache-timing-resistant ARX design and wider adoption.

**State of the art:** HC-128 and Rabbit remain unbroken but are rarely used in new systems. ChaCha20 (see [Symmetric Encryption](#symmetric-encryption)) has superseded all eSTREAM Profile 1 ciphers for software use, owing to its simpler implementation, vectorization, and TLS 1.3 adoption.

---

## Wegman-Carter MAC (One-Time and Multi-Use)

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

---

## TupleHash / ParallelHash (NIST SP 800-185)

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

---

## RIPEMD-160

**Goal:** Collision-resistant 160-bit hash optimized for software and used as a compact fingerprint in legacy PKI and Bitcoin address derivation. Designed by Dobbertin, Bosselaers, and Preneel (1996) as a strengthened replacement for RIPEMD-128, independent of the NSA/NIST SHA lineage.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **RIPEMD-128** | 1996 | MD (dual-stream Feistel) | 128-bit output; predecessor, now considered weak [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |
| **RIPEMD-160** | 1996 | MD (dual parallel stream) | 160-bit output; two parallel Merkle-Damgård streams merged; ISO/IEC 10118-3 [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |
| **RIPEMD-256 / RIPEMD-320** | 1997 | MD (parallel streams) | Extended variants; wider output; no additional security over 160/128-bit [[1]](https://homes.esat.kuleuven.be/~bosselae/ripemd160.html) |

**Design:** Two independent streams of 80 rounds each, using different constants and round-function orderings, then combined with a final merge step. Avoids length-extension attacks through independent left/right processing.

**Used in:** Bitcoin address derivation (`HASH160 = RIPEMD-160(SHA-256(pubkey))`), PGP key fingerprints (OpenPGP legacy), X.509 certificate fingerprints (historical). No known practical collision attack against RIPEMD-160 (unlike MD5/SHA-1).

**State of the art:** No practical collision found as of 2024; theoretical attack on reduced rounds by Liu-Mendel-Wang (2022) reaches 36/80 rounds. Still considered acceptable for the specific Bitcoin use case, but new designs should prefer SHA-256 or SHA-3. See [Hash Functions](#hash-functions).

---

## SM3 Hash Function

**Goal:** Sovereign cryptographic hash for Chinese national standards. SM3 is the Chinese national standard hash function (GM/T 0004-2012 / GB/T 32905-2016), producing 256-bit digests. Mandatory in Chinese government, finance, and 5G systems; increasingly adopted in international standards as an alternative to SHA-256.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **SM3** | 2010 | Merkle-Damgård + Davies-Meyer | 256-bit output; 64 rounds; 512-bit blocks; GB/T 32905-2016; ISO/IEC 10118-3:2018 [[1]](https://www.rfc-editor.org/rfc/rfc8998) |

**Design:** SM3 uses a Merkle-Damgård construction with a modified Davies-Meyer compression function. Key differences from SHA-256: a more complex message expansion (60-step mixing vs SHA-256's simple σ functions), a different round function with two non-linear Boolean functions, and additional XOR mixing of message words. The design resists the Wang-style differential attacks that broke MD5 and SHA-1.

**Used in:** SM2 signature verification (SM3 as the hash), TLS 1.3 cipher suites in China (RFC 8998), Chinese banking (UnionPay), national PKI and e-government. IETF RFC 8998 defines TLS_SM4_GCM_SM3 and TLS_SM4_CCM_SM3 cipher suites.

**State of the art:** GB/T 32905-2016 and ISO/IEC 10118-3:2018; no practical collision or preimage attack known. Widely deployed in Chinese critical infrastructure alongside [SM4 / Chinese National Standard Block Ciphers](#sm4--chinese-national-standard-block-ciphers).

---

## GOST R 34.11-2012 (Streebog) and GOST R 34.10-2012

**Goal:** Russian national cryptographic standards for hashing and digital signatures, replacing the 1994-era GOST R 34.11-94 hash and GOST R 34.10-2001 signature. Streebog provides 256-bit and 512-bit hash outputs; GOST R 34.10-2012 defines ECDSA-like signatures over Russian standardized elliptic curves. Both are mandatory for Russian government use and specified in IETF RFCs.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Streebog-256 (GOST R 34.11-2012)** | 2012 | Merkle-Damgård + AES-like SPN | 256-bit output; 512-bit internal state; 12-round compression; RFC 6986 [[1]](https://www.rfc-editor.org/rfc/rfc6986) |
| **Streebog-512 (GOST R 34.11-2012)** | 2012 | Merkle-Damgård + AES-like SPN | 512-bit output; full internal state used; RFC 6986 [[1]](https://www.rfc-editor.org/rfc/rfc6986) |
| **GOST R 34.10-2012** | 2012 | ECDSA variant | 256-bit and 512-bit modes; Weierstrass curves (id-tc26-gost-3410-2012-256/512); RFC 7091 [[1]](https://www.rfc-editor.org/rfc/rfc7091) |
| **GOST R 34.11-94 (historical)** | 1994 | MD + custom compression | Predecessor hash; replaced 2013; weaknesses discovered by Mendel et al. [[1]](https://eprint.iacr.org/2008/421) |

**Streebog design:** The compression function resembles AES — SubBytes (8×8 S-box), ShiftBytes, MixColumns (MDS over GF(2⁸)), and AddRoundKey, iterated 12 rounds with 512-bit block and state size. A Miyaguchi-Preneel feed-forward links compression rounds to the chaining value. An additional checksum accumulation step strengthens collision resistance.

**State of the art:** Streebog and GOST R 34.10-2012 are mandatory in Russian federal IT systems. RFC 6986 (Streebog) and RFC 7091 (GOST 34.10-2012) enable interoperability. Third-party cryptanalysis (Guo-Peyrin-Sasaki-Wang 2013) found rebound attacks on reduced-round Streebog but no practical break. See [Hash Functions](#hash-functions) and [Digital Signatures](#digital-signatures).

---

## Whirlpool and Tiger Hash Functions

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

---

## Non-Cryptographic Hash Functions (FNV / MurmurHash / xxHash)

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

---

## GOST R 34.12-2015 Block Ciphers (Grasshopper / Magma)

**Goal:** Russian national symmetric encryption standard. GOST R 34.12-2015 defines two block ciphers mandatory for Russian federal information systems: Kuznyechik ("Grasshopper"), a 128-bit block / 256-bit key SPN cipher, and Magma, a 64-bit block / 256-bit key Feistel update of the original 1989 GOST 28147-89. Together they replace the aging single-algorithm standard with a two-cipher portfolio covering both modern (128-bit block) and legacy (64-bit block) requirements.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **GOST 28147-89** | 1989 | 64-bit Feistel, 32 rounds | Original Soviet block cipher; 256-bit key; eight 4-bit S-boxes (classified until 1994); RFC 5830 [[1]](https://www.rfc-editor.org/rfc/rfc5830) |
| **Magma (GOST R 34.12-2015 Part 1)** | 2015 | 64-bit Feistel, 32 rounds | Standardized update of GOST 28147-89 with fixed public S-boxes; RFC 8891 [[1]](https://www.rfc-editor.org/rfc/rfc8891) |
| **Kuznyechik / Grasshopper (GOST R 34.12-2015 Part 2)** | 2015 | 128-bit SPN, 10 rounds | AES-like; SubBytes (π), LinearTransform (MDS over GF(2⁸)), AddRoundKey; RFC 7801 [[1]](https://www.rfc-editor.org/rfc/rfc7801) |

**Kuznyechik structure:** Ten-round SPN with 128-bit block and 256-bit key. Round function applies (1) a nonlinear byte substitution S using an 8×8 S-box, (2) a linear transformation L using a 16-byte MDS matrix over GF(2⁸) with primitive polynomial x⁸ + x⁷ + x⁶ + x + 1, and (3) XOR with a round subkey. Key schedule expands 256-bit master key to ten 128-bit round keys using the cipher itself in a Feistel-like network.

**Modes of operation:** GOST R 34.13-2015 defines CTR, OFB, CBC, CFB, and MAC modes for both ciphers. MGM (Multilinear Galois Mode) is the AEAD standard for both, specified in RFC 9058.

**Cryptanalysis note:** The S-box of Kuznyechik attracted academic scrutiny (Biryukov-Perrin 2019 found hidden structure suggesting a non-random derivation), but no practical attack has been found. Best known attacks on reduced-round Kuznyechik reach 7/10 rounds.

**State of the art:** GOST R 34.12-2015 is mandatory for Russian federal cryptography. RFC 7801 (Kuznyechik) and RFC 8891 (Magma) enable IETF interoperability; MGM (RFC 9058) provides the AEAD mode. See [GOST R 34.11-2012 (Streebog)](#gost-r-3411-2012-streebog-and-gost-r-3410-2012) for the companion hash and signature standards.

---

## Authenticated Encryption Security Models

**Goal:** Formal framework for AEAD. Authenticated encryption with associated data (AEAD) provides both confidentiality and integrity in a single pass. Security models differ in what the adversary controls — in particular, whether reusing a nonce breaks all security guarantees or only leaks limited information. Choosing the right model determines which AEAD scheme is appropriate and whether nonce management is the responsibility of the protocol or the primitive.

**Core AEAD security definition (NIST SP 800-38D / Rogaway 2002):** An AEAD scheme is secure if an adversary cannot distinguish its output from random bits (IND-CPA) and cannot forge valid ciphertexts (INT-CTXT), assuming the nonce is never repeated under the same key.

| Model | Nonce reuse impact | Examples | Note |
|-------|-------------------|----------|------|
| **Nonce-Respecting (NR-AEAD)** | Catastrophic — full confidentiality and integrity loss | AES-GCM, ChaCha20-Poly1305, OCB, CCM | Standard model; nonce uniqueness is caller's responsibility [[1]](https://csrc.nist.gov/pubs/sp/800/38/d/final) |
| **Nonce-Misuse-Resistant (NMR-AEAD)** | Graceful — only reveals whether two plaintexts were identical | AES-GCM-SIV (RFC 8452), AES-SIV (RFC 5297), Deoxys-II | Rogaway-Shrimpton 2006 definition; SIV construction [[1]](https://eprint.iacr.org/2006/221) |
| **Nonce-Misuse-Resilient** | Partial — ciphertext indistinguishability lost but integrity preserved | SCT, CAEAD variants | Weaker than NMR; confidentiality leakage bounded [[1]](https://eprint.iacr.org/2015/189) |
| **Online AEAD (OAE2)** | Catastrophic with reuse | STREAM, most streaming AEAD | Supports online processing without buffering; Hoang-Reyhanitabar-Rogaway-Vizár model [[1]](https://eprint.iacr.org/2015/189) |
| **Committing AEAD (CMT)** | — | AES-GCM-SIV, AEGIS with binding | Ciphertext uniquely commits to the key; prevents partition oracle attacks; see [Key-Committing AEAD](categories/02-authenticated-structured-encryption.md#key-committing-aead) [[1]](https://eprint.iacr.org/2020/1153) |

**The SIV (Synthetic IV) construction (Rogaway-Shrimpton 2006):** Generates the nonce/IV synthetically as a PRF of the plaintext and associated data, then encrypts under that IV. If the same plaintext is encrypted twice, the ciphertexts are identical (revealing equality), but confidentiality is otherwise maintained even under nonce reuse. AES-SIV (RFC 5297) and AES-GCM-SIV (RFC 8452) are the deployed instances.

**Nonce reuse disasters:** AES-GCM nonce reuse leaks the authentication key (GHASH key H = E_K(0)), enabling universal forgery. For ChaCha20-Poly1305, nonce reuse similarly leaks the Poly1305 one-time key. A single reuse under the same (key, nonce) pair is catastrophic for all NR-AEAD schemes.

**State of the art:** AES-GCM (NR-AEAD) dominates deployed systems; use AES-GCM-SIV (RFC 8452) or AES-SIV (RFC 5297) when nonce management is unreliable. AEGIS offers NR-AEAD with superior performance. See [Block Cipher Modes of Operation](#block-cipher-modes-of-operation) and [Key-Committing AEAD](categories/02-authenticated-structured-encryption.md#key-committing-aead).

---

## Keccak-p Permutation

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

---

## BLAKE2 Hash Function Internals

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

---

## ElGamal Encryption over Groups

**Goal:** Public-key encryption based on the hardness of the discrete logarithm problem. A sender uses the recipient's public key (a group element) together with a fresh random scalar to produce a ciphertext pair; decryption uses the private exponent to undo the Diffie-Hellman blinding. Semantically secure under DDH in the random-oracle model; naturally extends to elliptic curves (EC-ElGamal) and pairing groups.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **ElGamal (original)** | 1985 | DLP in Z*p | Probabilistic PKE; ciphertext (g^r, m·y^r); IND-CPA under DDH [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **EC-ElGamal** | ~1987 | ECDLP | Same construction over an elliptic curve group; shorter keys (256-bit ≈ 3072-bit RSA) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **ElGamal with Schnorr proof** | 1990 | DDH + Σ-protocol | Add a zero-knowledge proof of well-formedness; used in e-voting [[1]](https://eprint.iacr.org/2005/385) |
| **Twisted ElGamal** | 2019 | EC-ElGamal variant | Swap plaintext and blinding factor placement; enables efficient ZK range proofs for confidential transactions [[1]](https://eprint.iacr.org/2019/319) |

**Homomorphic property:** EC-ElGamal is additively homomorphic over the message exponent: Enc(m₁) + Enc(m₂) = Enc(m₁ + m₂) (pointwise group operation on ciphertext pairs). This enables tallying encrypted votes without decryption — a core primitive in e-voting and secure aggregation. Decryption requires solving a discrete log on the result, limiting plaintext space to small integers.

**State of the art:** EC-ElGamal over Ristretto255 or BN254 is the canonical additively homomorphic primitive in ZK and e-voting systems (see [Paillier Cryptosystem](#paillier-cryptosystem-additive-homomorphic-encryption) for integer-based additive HE). Twisted ElGamal is used in Bulletproofs-based confidential transactions (see [Confidential Transactions](categories/13-blockchain-distributed-ledger.md)).

---

## Paillier Cryptosystem (Additive Homomorphic Encryption)

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

**State of the art:** Paillier with 2048-bit modulus (112-bit security) is the standard deployment. Threshold Paillier (Damgård-Jurik-Nielsen 2010) is used in production threshold ECDSA (e.g., GG20, CGGMP21). For post-quantum additive HE, see [Homomorphic Encryption](categories/07-homomorphic-functional-encryption.md) (BFV/BGV/CKKS).

---

## Lai-Massey Structure and IDEA Cipher

**Goal:** Alternative block cipher structure providing full diffusion with provable algebraic properties. The Lai-Massey scheme (1990) uses a mix of operations from incompatible algebraic groups — XOR (addition in Z₂ⁿ), addition mod 2^16, and multiplication mod 2^16+1 — to achieve complete diffusion with no component being a linear operation over any other's field. IDEA (International Data Encryption Algorithm) instantiates this structure and was the dominant cipher in PGP 2.x and OpenPGP legacy implementations.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **IDEA (International Data Encryption Algorithm)** | 1991 | Lai-Massey, mixed-algebraic | 64-bit block, 128-bit key, 8.5 rounds; PGP 2.x default; ISO/IEC 18033-3 [[1]](https://link.springer.com/chapter/10.1007/3-540-54508-8_24) |
| **IDEA NXT (FOX)** | 2004 | Lai-Massey + SPN | 64 or 128-bit block; improved design by Junod-Vaudenay [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_8) |
| **SAFER / SAFER+** | 1993 | Lai-Massey variant | Used in Bluetooth (E0 cipher stack); byte-level operations [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_26) |

**Lai-Massey structure:** Unlike Feistel (which splits the block into halves and XORs) or SPN (which applies a global nonlinear layer), Lai-Massey applies a half-round function H and XOR-then-adds between left and right halves: `L' = L ⊕ H(L ⊕ R)`, `R' = R ⊕ H(L ⊕ R)`. The three incompatible operations (⊕, +, ×) prevent simple algebraic attacks that work against uniform-field structures. The multiplication mod (2^16 + 1) in IDEA has been particularly resistant to differential and linear attacks.

**Security status:** IDEA (64-bit block) is legacy — 64-bit block ciphers are vulnerable to birthday-bound attacks at ~32 GB data (SWEET32, 2016). No practical key-recovery attack on full 8.5-round IDEA is known, but block size limits modern use.

**State of the art:** IDEA is standardized in ISO/IEC 18033-3 and supported in OpenPGP (RFC 4880) as a legacy cipher; prohibited in TLS since RFC 7525. New designs should use AES or ChaCha20. The Lai-Massey construction remains theoretically significant and appears in IDEA NXT/FOX. See [Feistel Networks](#feistel-networks-luby-rackoff-construction) for the analogous Feistel theory.

---

## Multi-Prime RSA and RSA-CRT

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

---

## Extendable Output Functions (XOF)

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

---

## Montgomery Arithmetic and Barrett Reduction

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

---

## Constant-Time Implementations and Timing Attack Mitigations

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

---

## Double PRF and Related-Key Attack Resistance

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

**State of the art:** AES-128 is preferred over AES-256 in RKA-sensitive contexts (AES-128 has no known RKA weakness). HMAC's two-key derivation remains standard. Double PRF (independent keys) is the practical mitigation for protocols needing RKA resistance; see [Puncturable / Constrained PRF](#puncturable--constrained-prf) for key delegation, and [Key Exchange & KDFs](categories/03-key-exchange-key-management.md) for key derivation patterns.

---
