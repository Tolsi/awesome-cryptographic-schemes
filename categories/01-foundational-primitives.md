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
