# Awesome Cryptographic Schemes [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> A curated list of cryptographic schemes, protocols, and primitives — with plain-language descriptions, goals, state-of-the-art algorithms, and references to key papers.

---

## Contents

- [Symmetric Encryption](#symmetric-encryption)
- [Asymmetric (Public-Key) Encryption](#asymmetric-public-key-encryption)
- [Hash Functions](#hash-functions)
- [Message Authentication Codes (MAC)](#message-authentication-codes-mac)
- [Digital Signatures](#digital-signatures)
- [Key Exchange / Key Agreement](#key-exchange--key-agreement)
- [Secret Sharing Schemes (SSS)](#secret-sharing-schemes-sss)
- [Threshold Signature Schemes (TSS)](#threshold-signature-schemes-tss)
- [Verifiable Random Functions (VRF)](#verifiable-random-functions-vrf)
- [Zero-Knowledge Proofs (ZK)](#zero-knowledge-proofs-zk)
- [Homomorphic Encryption (HE)](#homomorphic-encryption-he)
- [Verifiable Encryption](#verifiable-encryption)
- [Commitment Schemes](#commitment-schemes)
- [Oblivious Transfer (OT)](#oblivious-transfer-ot)
- [Multi-Party Computation (MPC)](#multi-party-computation-mpc)
- [Authenticated Encryption (AEAD)](#authenticated-encryption-aead)
- [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake)
- [Attribute-Based & Functional Encryption](#attribute-based--functional-encryption)
- [Blind Signatures](#blind-signatures)
- [Ring & Group Signatures](#ring--group-signatures)
- [Accumulators](#accumulators)
- [Post-Quantum Cryptography](#post-quantum-cryptography)
- [References](#references)

---

## Symmetric Encryption

**Goal:** Confidentiality. Encrypt data with a single shared secret key so that only those who know the key can read it.

| Algorithm | Type | Note |
|-----------|------|------|
| **AES-256** | Block cipher | De-facto standard (NIST), 128-bit block, 256-bit key [1] |
| **ChaCha20** | Stream cipher | Fast in software, constant-time; used in TLS 1.3, WireGuard [2] |
| **Salsa20** | Stream cipher | Predecessor to ChaCha20, eSTREAM portfolio [3] |
| **Serpent** | Block cipher | AES finalist, conservative security margin [4] |
| **Camellia** | Block cipher | ISO/IEC standard, comparable to AES [5] |

**State of the art:** AES-256 (hardware-accelerated via AES-NI) and ChaCha20 for software-only environments.

---

## Asymmetric (Public-Key) Encryption

**Goal:** Confidentiality without pre-shared keys. A sender encrypts with the recipient's public key; only the recipient's private key can decrypt.

| Algorithm | Basis | Note |
|-----------|-------|------|
| **RSA-OAEP** | Integer factorization | First practical PKE; 2048+ bit keys recommended [6] |
| **ECIES** | Elliptic Curve Diffie-Hellman | Hybrid: ECDH + symmetric enc; compact keys [7] |
| **DHIES / DHAES** | Diffie-Hellman | Provably CCA2-secure hybrid scheme [8] |
| **Cramer-Shoup** | DDH | First practical CCA2-secure scheme without random oracles [9] |
| **HPKE** | Hybrid KEM/DEM | Modern standard (RFC 9180): KEM + AEAD + KDF [10] |

**State of the art:** HPKE (RFC 9180) with X25519 KEM + AES-256-GCM — used in TLS Encrypted Client Hello, MLS, OHTTP.

---

## Hash Functions

**Goal:** Integrity & data fingerprinting. Map arbitrary data to a fixed-size digest; must be collision-resistant, preimage-resistant, and second-preimage-resistant.

| Algorithm | Output | Note |
|-----------|--------|------|
| **SHA-256 / SHA-512** | 256 / 512 bit | Merkle-Damgard; NIST standard, ubiquitous [11] |
| **SHA-3 (Keccak)** | 224–512 bit | Sponge construction; NIST standard (FIPS 202) [12] |
| **BLAKE3** | 256 bit | Merkle tree + compression; extremely fast [13] |
| **BLAKE2** | up to 512 bit | Faster than SHA-3, widely used (Argon2, WireGuard) [14] |
| **KangarooTwelve (K12)** | variable | Reduced-round Keccak-p, parallelizable [15] |

**Extendable-Output Functions (XOF):** SHAKE128/256 (SHA-3 family), TurboSHAKE [12].

**State of the art:** BLAKE3 (speed), SHA-3/SHAKE (diversity from SHA-2), SHA-256 (compatibility).

---

## Message Authentication Codes (MAC)

**Goal:** Integrity + Authentication. Verify that a message was not altered and comes from someone who knows the shared key.

| Algorithm | Basis | Note |
|-----------|-------|------|
| **HMAC** | Hash-based | HMAC-SHA256 is the workhorse; provably secure if hash is PRF [16] |
| **CMAC** | Block cipher | Based on CBC-MAC; NIST SP 800-38B [17] |
| **GMAC** | GF(2^128) | MAC-only mode of GCM; very fast with AES-NI [18] |
| **Poly1305** | Polynomial | One-time MAC; used with ChaCha20 in TLS 1.3 [19] |
| **KMAC** | Keccak | SHA-3-based MAC; NIST SP 800-185 [20] |

**State of the art:** HMAC-SHA256 (general), Poly1305 (high speed, paired with ChaCha20).

---

## Digital Signatures

**Goal:** Authentication + Integrity + Non-repudiation. Prove that a specific private-key holder signed a message, and anyone with the public key can verify.

| Algorithm | Basis | Note |
|-----------|-------|------|
| **ECDSA** | Elliptic curves | Widely deployed (TLS, Bitcoin); P-256 or secp256k1 [21] |
| **EdDSA (Ed25519 / Ed448)** | Twisted Edwards curves | Deterministic, fast, misuse-resistant; RFC 8032 [22] |
| **Schnorr** | DLP | Elegant, provably secure; BIP 340 (Bitcoin Taproot) [23] |
| **RSA-PSS** | Factorization | Provably secure RSA variant; PKCS#1 v2.2 [24] |
| **BLS** | Bilinear pairings | Short signatures, native aggregation; Ethereum 2.0 [25] |

**State of the art:** Ed25519 (general), BLS (aggregation), Schnorr (multi-sig via MuSig2 [26]).

---

## Key Exchange / Key Agreement

**Goal:** Establish a shared secret over an insecure channel, providing confidentiality for subsequent communication.

| Algorithm | Basis | Note |
|-----------|-------|------|
| **ECDH (X25519)** | Elliptic curves | Curve25519; default in TLS 1.3, Signal, WireGuard [27] |
| **X448** | Goldilocks curve | 224-bit security; RFC 7748 [28] |
| **Classic DH** | Discrete logarithm | Original key exchange; use 2048+ bit groups [29] |
| **SPAKE2 / OPAQUE** | PAKE | Password-authenticated; no PKI needed [30][31] |
| **MQV / HMQV** | DL + static keys | Implicitly authenticated 2-pass protocol [32] |
| **Noise Framework** | Composable patterns | Modular handshakes: XX, IK, NK, etc. [33] |

**State of the art:** X25519 (ephemeral DH), OPAQUE (PAKE without exposing password to server), Noise XX (modern protocol design).

---

## Secret Sharing Schemes (SSS)

**Goal:** Split a secret into *n* shares so that any *t* shares reconstruct it, but fewer than *t* reveal nothing. Provides confidentiality + availability.

| Scheme | Approach | Note |
|--------|----------|------|
| **Shamir's Secret Sharing** | Polynomial interpolation | Information-theoretically secure; *(t,n)* threshold [34] |
| **Blakley's Scheme** | Hyperplane geometry | Alternative geometric approach [35] |
| **Verifiable SS (VSS) — Feldman** | Commitments on polynomial coeff. | Detects cheating dealer [36] |
| **Verifiable SS — Pedersen** | Double commitments | Information-theoretically hiding [37] |
| **Packed Secret Sharing** | Multi-secret polynomial | Amortized: share multiple secrets at once [38] |
| **Proactive SS** | Periodic share refresh | Tolerates mobile adversary over time [39] |

**State of the art:** Shamir + Feldman VSS (practical), Packed SS (MPC optimization).

---

## Threshold Signature Schemes (TSS)

**Goal:** *t-of-n* parties collectively sign without ever reconstructing the private key. Provides distributed trust and non-repudiation.

| Scheme | Underlying Sig | Note |
|--------|---------------|------|
| **GG18 / GG20** | ECDSA | Threshold ECDSA with presigning; used in MPC wallets [40][41] |
| **CGGMP** | ECDSA | UC-secure, identifiable abort, improved over GG20 [42] |
| **FROST** | Schnorr | Simple, round-efficient threshold Schnorr; 2 rounds [43] |
| **Threshold BLS** | BLS | Deterministic; natural from Shamir + pairing; non-interactive aggregation [25][34] |
| **MuSig2** | Schnorr | 2-round multi-signature (all *n* of *n*); BIP 327 [26] |
| **ROAST** | Schnorr/FROST | Robust wrapper for asynchronous FROST signing [44] |

**State of the art:** FROST (Schnorr threshold), CGGMP (ECDSA threshold), ROAST (robust async).

---

## Verifiable Random Functions (VRF)

**Goal:** Produce a pseudorandom output from a secret key and input so that the output is deterministic, unpredictable, and publicly verifiable. Used in lotteries, leader election, DNS (NSEC5).

| Scheme | Basis | Note |
|--------|-------|------|
| **ECVRF** | Elliptic curves | IETF standard (RFC 9381); based on Elligator [45] |
| **RSA-FDH VRF** | RSA | Full-domain hash approach; larger proofs [46] |
| **BLS-based VRF** | Pairings | Short proofs; naturally threshold-friendly [25] |
| **Threshold VRF (DVRF)** | DKG + VRF | Distributed: t-of-n nodes produce VRF jointly [47] |

**State of the art:** ECVRF (RFC 9381), BLS-VRF (threshold-friendly for blockchain).

---

## Zero-Knowledge Proofs (ZK)

**Goal:** Prove that a statement is true without revealing any information beyond the truth of the statement. Provides privacy + verifiability.

### General-Purpose ZK (for arbitrary circuits)

| System | Type | Note |
|--------|------|------|
| **Groth16** | zk-SNARK (pairing) | Shortest proofs (~192 B), trusted setup per circuit [48] |
| **PLONK** | zk-SNARK (pairing) | Universal trusted setup (powers of tau); widely used [49] |
| **Marlin** | zk-SNARK (pairing) | Universal & updatable setup [50] |
| **Halo 2** | zk-SNARK (no trusted setup) | Recursive; IPA-based; used in Zcash Orchard [51] |
| **STARKs** | Transparent (hash-based) | No trusted setup, post-quantum friendly; larger proofs [52] |
| **Bulletproofs** | IPA-based | No trusted setup; compact range proofs [53] |
| **Nova / SuperNova** | IVC / folding | Incremental Verifiable Computation; minimal per-step cost [54] |
| **Spartan** | Sum-check protocol | No trusted setup, no FFTs; very fast prover [55] |
| **Brakedown / Binius** | Code-based | Hardware-friendly, binary-field proofs [56] |

### Specialized ZK Protocols

| Protocol | Purpose |
|----------|---------|
| **Sigma protocols (Schnorr)** | DL knowledge proof; basis for many schemes [23] |
| **Pedersen + range proof** | Confidential transactions (Monero, Mimblewimble) [53] |
| **zk-EVM (Polygon, Scroll, zkSync)** | Prove EVM execution in ZK [57] |

**State of the art:** PLONK/KZG variants (practical SNARKs), STARKs (transparency + PQ), Nova (IVC/folding for recursion).

---

## Homomorphic Encryption (HE)

**Goal:** Compute on encrypted data without decrypting it. The result, when decrypted, matches computation on plaintext. Provides confidentiality during processing.

| Scheme | Type | Note |
|--------|------|------|
| **BFV** | Leveled HE (integer arith.) | Batch integer computation via SIMD [58] |
| **BGV** | Leveled HE (integer arith.) | Modulus switching for noise control [59] |
| **CKKS** | Approximate HE (real/complex) | ML-friendly; approximate fixed-point [60] |
| **TFHE** | Fully HE (Boolean/small int) | Fast bootstrapping (~10 ms); gate-by-gate [61] |
| **OpenFHE** | Library | Implements BFV, BGV, CKKS, TFHE (successor to PALISADE, HElib, HEAAN) [62] |
| **Paillier** | Additive HE only | Simple; used in e-voting, MPC, federated learning [63] |

**State of the art:** TFHE (fast bootstrapping), CKKS (ML on encrypted data), OpenFHE (reference library).

---

## Verifiable Encryption

**Goal:** Encrypt a value and prove (in zero-knowledge) that the ciphertext contains a plaintext satisfying a given relation — without revealing it. Used in fair exchange, escrow, and group signatures.

| Scheme | Approach | Note |
|--------|----------|------|
| **Camenisch-Shoup** | CCA2 enc + ZKP | General framework; widely cited [64] |
| **Asokan-Shoup-Waidner** | RSA-based | Optimistic fair exchange via TTP [65] |
| **Verifiable Enc. of DL** | ElGamal + Sigma | Prove enc. of discrete log; simple and efficient [64] |
| **ZK + Hybrid Enc.** | SNARK/STARK + Enc. | Modern: prove anything about ciphertext contents [48] |

**State of the art:** Camenisch-Shoup framework + modern SNARKs for generic relations.

---

## Commitment Schemes

**Goal:** Commit to a value (hiding) so it can be revealed later (binding). Like a sealed envelope. Used as a building block in many protocols.

| Scheme | Basis | Note |
|--------|-------|------|
| **Pedersen Commitment** | DLP | Perfectly hiding, computationally binding; additively homomorphic [37] |
| **Hash Commitment** | Hash function | `C = H(m ‖ r)`; simple, practical [11] |
| **KZG (Kate) Commitment** | Pairings + polynomial | Commit to polynomials; constant-size proofs; trusted setup [66] |
| **FRI** | Hash + RS codes | Polynomial commitment; transparent (no setup); used in STARKs [52] |
| **Bulletproofs IPA** | Inner-product argument | Logarithmic-size polynomial commitment [53] |

**State of the art:** KZG (SNARKs, Ethereum danksharding), FRI (STARKs, PQ-friendly).

---

## Oblivious Transfer (OT)

**Goal:** Sender has multiple messages; receiver picks one and learns only that one — sender doesn't learn which was chosen. Foundational for MPC.

| Scheme | Note |
|--------|------|
| **1-out-of-2 OT (Naor-Pinkas)** | Based on DDH; efficient base OT [67] |
| **OT Extension (IKNP)** | Extend few base OTs into millions cheaply via symmetric crypto [68] |
| **Silent OT (Boyle et al.)** | Sublinear communication using pseudorandom correlation generators [69] |
| **Simplest OT (Chou-Orlandi)** | 1 round, 1 exponentiation; practical [70] |

**State of the art:** Silent OT extension (minimal communication), SoftSpokenOT [71].

---

## Multi-Party Computation (MPC)

**Goal:** Multiple parties jointly compute a function over their private inputs without revealing anything except the output. Provides privacy + correctness.

| Protocol | Model | Note |
|----------|-------|------|
| **GMW** | Semi-honest, Boolean | Gate-by-gate OT-based; foundational [72] |
| **BGW** | Info.-theoretic, honest majority | No crypto assumptions if ≥2/3 honest [73] |
| **SPDZ / SPDZ2k** | Malicious, dishonest majority | Preprocessing + MAC-based online phase [74] |
| **ABY / ABY3** | Mixed: Arithmetic, Boolean, Yao | Efficient conversions between share types [75] |
| **Garbled Circuits (Yao)** | 2PC, semi-honest | Constant-round; optimized with free-XOR, half-gates [76] |
| **MP-SPDZ** | Framework | Implements 30+ MPC protocols [77] |

**State of the art:** SPDZ2k (dishonest majority), ABY3 (3-party ML), Silent-OT-based 2PC.

---

## Authenticated Encryption (AEAD)

**Goal:** Confidentiality + Integrity + Authentication in a single primitive. Encrypt and authenticate data so tampering is detectable.

| Algorithm | Note |
|-----------|------|
| **AES-256-GCM** | NIST standard; hardware-accelerated; nonce-misuse vulnerable [18] |
| **ChaCha20-Poly1305** | Software-fast; TLS 1.3, WireGuard; IETF RFC 8439 [2][19] |
| **AES-GCM-SIV** | Nonce-misuse resistant; RFC 8452 [78] |
| **AES-OCB3** | Very fast (single-pass); patent-free since 2021 [79] |
| **AEGIS-128L / AEGIS-256** | AES-round-based stream; fastest AEAD on AES-NI hardware [80] |
| **Ascon** | Lightweight AEAD; NIST LWC winner (2023) [81] |

**State of the art:** AES-256-GCM (standard), AEGIS (speed record on AES-NI), Ascon (constrained devices).

---

## Password-Based Key Derivation (KDF / PAKE)

**Goal:** Derive strong cryptographic keys from weak passwords, or authenticate over a password without exposing it to the server.

### Key Derivation Functions (KDF)

| Algorithm | Note |
|-----------|------|
| **Argon2id** | PHC winner (2015); memory-hard; recommended default [82] |
| **scrypt** | Memory-hard; used in Litecoin, Tarsnap [83] |
| **bcrypt** | Classic; Blowfish-based; still widely deployed [84] |
| **HKDF** | Extract-then-expand; not for passwords; RFC 5869 [85] |
| **Balloon Hashing** | Provably memory-hard; NIST candidate [86] |

### Password-Authenticated Key Exchange (PAKE)

| Protocol | Note |
|----------|------|
| **OPAQUE** | Asymmetric PAKE; server never sees password; IETF draft [31] |
| **SPAKE2** | Symmetric PAKE; simple, round-efficient; RFC 9382 [30] |
| **SRP** | Legacy PAKE; TLS-SRP; widely deployed [87] |
| **CPace** | Balanced PAKE; IETF draft; provably secure in UC model [88] |

**State of the art:** Argon2id (password hashing), OPAQUE (asymmetric PAKE).

---

## Attribute-Based & Functional Encryption

**Goal:** Fine-grained access control embedded in ciphertext. Decrypt only if your attributes/key satisfy a policy. Provides access control + confidentiality.

| Scheme | Type | Note |
|--------|------|------|
| **CP-ABE (Bethencourt-Sahai-Waters)** | Ciphertext-Policy ABE | Policy in ciphertext; key has attributes [89] |
| **KP-ABE (Goyal-Pandey-Sahai-Waters)** | Key-Policy ABE | Policy in key; ciphertext has attributes [90] |
| **FAME** | CP-ABE (prime-order) | Fast, prime-order groups; practical [91] |
| **Inner-Product FE (Abdalla et al.)** | Functional Encryption | Decrypt inner product of attribute vectors [92] |
| **Multi-Input FE** | Functional Encryption | Multiple encryptors, joint function [93] |

**State of the art:** FAME (practical ABE), Inner-Product FE (ML applications).

---

## Blind Signatures

**Goal:** Signer signs a message without seeing its content. Provides anonymity + non-repudiation. Used in e-cash, anonymous credentials, Privacy Pass.

| Scheme | Basis | Note |
|--------|-------|------|
| **RSA Blind Signature** | RSA | Chaum's original; used in Privacy Pass (RFC 9474) [94] |
| **Blind Schnorr** | DLP | Simple but requires care with ROS problem [95] |
| **BBS+ / BBS** | Pairings | Multi-message blind sign + selective disclosure; W3C VC [96] |
| **Abe's Blind Signature** | Pairing | Partially blind; used in anonymous e-cash schemes [97] |

**State of the art:** RSA Blind Sig (Privacy Pass), BBS+ (anonymous credentials & selective disclosure).

---

## Ring & Group Signatures

**Goal:** Sign on behalf of a group/ring without revealing which member signed. Provides anonymity within a set.

| Scheme | Type | Note |
|--------|------|------|
| **Ring Signatures (Rivest-Shamir-Tauman)** | Ring | Ad-hoc group, no setup; used in Monero (pre-2020) [98] |
| **CLSAG** | Ring (linkable) | Compact Linkable Spontaneous; current Monero scheme [99] |
| **Group Signatures (BBS04)** | Group | Requires group manager; revocable anonymity [100] |
| **Short Group Sig (Boneh-Boyen-Shacham)** | Group | Pairing-based; very short signatures [100] |

**State of the art:** CLSAG (privacy coins), BBS Group Sig (enterprise), Raptor (PQ ring sig).

---

## Accumulators

**Goal:** Compactly represent a set and prove (non-)membership of elements. Used for revocation lists, stateless blockchain validation.

| Scheme | Basis | Note |
|--------|-------|------|
| **RSA Accumulator** | Strong RSA | Constant-size; add/delete + membership proofs [101] |
| **Bilinear Accumulator** | Pairings | Efficient non-membership proofs [102] |
| **Merkle Tree** | Hash | Simple; membership proof is O(log n); used everywhere [103] |
| **Verkle Tree** | KZG + Merkle | Smaller proofs than Merkle; proposed for Ethereum [66] |

**State of the art:** Verkle Trees (blockchain), RSA Accumulators + batching [104].

---

## Post-Quantum Cryptography

Schemes designed to resist attacks from quantum computers (Shor's algorithm breaks RSA, DH, ECC; Grover halves symmetric key security).

### PQ Key Encapsulation (KEM) / Encryption

| Algorithm | Basis | Note |
|-----------|-------|------|
| **ML-KEM (Kyber)** | Module lattices (MLWE) | **NIST standard (FIPS 203)**; used in Chrome, Signal [105] |
| **FrodoKEM** | Standard lattices (LWE) | More conservative; no ring structure [106] |
| **Classic McEliece** | Code-based (Goppa) | Very large keys (~1 MB), very small ciphertexts; NIST round 4 [107] |
| **BIKE** | Code-based (QC-MDPC) | Moderate key sizes; NIST round 4 [108] |
| **HQC** | Code-based (Hamming QC) | NIST round 4 alternate [109] |
| **NTRU** | Lattice (NTRU) | One of the oldest PQ schemes (1996); patents expired [110] |

### PQ Digital Signatures

| Algorithm | Basis | Note |
|-----------|-------|------|
| **ML-DSA (Dilithium)** | Module lattices (MLWE) | **NIST standard (FIPS 204)**; general-purpose PQ sig [111] |
| **SLH-DSA (SPHINCS+)** | Hash-based (stateless) | **NIST standard (FIPS 205)**; conservative, no lattice assumption [112] |
| **FN-DSA (Falcon)** | NTRU lattices | NIST standard (FIPS 206); compact signatures, complex signing [113] |
| **XMSS** | Hash-based (stateful) | RFC 8391; stateful — must track index [114] |
| **LMS / HSS** | Hash-based (stateful) | RFC 8554; NIST SP 800-208; simple stateful scheme [115] |
| **SQIsign** | Supersingular isogenies | Shortest PQ signatures (~200 B); very new [116] |

### PQ Zero-Knowledge

| Approach | Note |
|----------|------|
| **STARKs** | Hash-based; inherently post-quantum [52] |
| **Lattice-based ZK** | Emerging; based on SIS/LWE [117] |

### PQ Key Exchange / Hybrid

| Protocol | Note |
|----------|------|
| **X25519Kyber768** | Hybrid: classical X25519 + ML-KEM-768; deployed in Chrome, Signal, Cloudflare [118] |
| **PQ Noise** | Noise Framework patterns with PQ KEMs [33] |

**State of the art:** ML-KEM (FIPS 203) for encryption, ML-DSA (FIPS 204) for signatures, SLH-DSA for conservative hash-based sigs, hybrid X25519+ML-KEM for transition period.

---

## References

| # | Reference |
|---|-----------|
| [1] | Daemen, Rijmen. "The Design of Rijndael: AES — The Advanced Encryption Standard." Springer, 2002. |
| [2] | Bernstein. "ChaCha, a variant of Salsa20." 2008. https://cr.yp.to/chacha.html |
| [3] | Bernstein. "The Salsa20 family of stream ciphers." 2007. https://cr.yp.to/salsa20.html |
| [4] | Anderson, Biham, Knudsen. "Serpent: A Proposal for the Advanced Encryption Standard." 1998. |
| [5] | Aoki et al. "Camellia: A 128-Bit Block Cipher Suitable for Multiple Platforms." SAC 2000. |
| [6] | Rivest, Shamir, Adleman. "A Method for Obtaining Digital Signatures and Public-Key Cryptosystems." CACM, 1978. |
| [7] | Abdalla, Bellare, Rogaway. "DHAES: An Encryption Scheme Based on the Diffie-Hellman Problem." CT-RSA 2001. |
| [8] | Shoup. "A Proposal for an ISO Standard for Public Key Encryption." 2001. |
| [9] | Cramer, Shoup. "A Practical Public Key Cryptosystem Provably Secure Against Adaptive Chosen Ciphertext Attack." CRYPTO 1998. |
| [10] | Barnes et al. "Hybrid Public Key Encryption." RFC 9180, 2022. |
| [11] | NIST. "Secure Hash Standard (SHS)." FIPS 180-4, 2015. |
| [12] | Bertoni et al. "Keccak." SHA-3 submission, 2011. https://keccak.team |
| [13] | O'Connor et al. "BLAKE3: one function, fast everywhere." 2020. https://github.com/BLAKE3-team/BLAKE3-specs |
| [14] | Aumasson et al. "BLAKE2: simpler, smaller, fast as MD5." ACNS 2013. |
| [15] | Guido Bertoni et al. "KangarooTwelve: Fast Hashing Based on Keccak-p." ACNS 2018. |
| [16] | Bellare, Canetti, Krawczyk. "Keying Hash Functions for Message Authentication." CRYPTO 1996. |
| [17] | NIST. "Recommendation for Block Cipher Modes of Operation: The CMAC Mode for Authentication." SP 800-38B. |
| [18] | McGrew, Viega. "The Galois/Counter Mode of Operation (GCM)." 2004. |
| [19] | Bernstein. "The Poly1305-AES Message-Authentication Code." FSE 2005. |
| [20] | NIST. "SHA-3 Derived Functions." SP 800-185, 2016. |
| [21] | Johnson, Menezes, Vanstone. "The Elliptic Curve Digital Signature Algorithm (ECDSA)." IJIS, 2001. |
| [22] | Bernstein et al. "High-speed high-security signatures." J. Cryptographic Engineering, 2012. Ed25519. |
| [23] | Schnorr. "Efficient Signature Generation by Smart Cards." J. Cryptology, 1991. |
| [24] | Bellare, Rogaway. "The Exact Security of Digital Signatures — How to Sign with RSA and Rabin." EUROCRYPT 1996. |
| [25] | Boneh, Lynn, Shacham. "Short Signatures from the Weil Pairing." ASIACRYPT 2001. |
| [26] | Nick, Ruffing, Seurin. "MuSig2: Simple Two-Round Schnorr Multi-Signatures." CRYPTO 2021. |
| [27] | Bernstein. "Curve25519: new Diffie-Hellman speed records." PKC 2006. |
| [28] | Hamburg. "Ed448-Goldilocks, a new elliptic curve." 2015. |
| [29] | Diffie, Hellman. "New Directions in Cryptography." IEEE Trans. Info. Theory, 1976. |
| [30] | Abdalla, Pointcheval. "Simple Password-Based Encrypted Key Exchange Protocols." CT-RSA 2005. |
| [31] | Jarecki, Krawczyk, Xu. "OPAQUE: An Asymmetric PAKE Protocol Secure Against Pre-Computation Attacks." EUROCRYPT 2018. |
| [32] | Krawczyk. "HMQV: A High-Performance Secure Diffie-Hellman Protocol." CRYPTO 2005. |
| [33] | Perrin (ed.). "The Noise Protocol Framework." 2018. https://noiseprotocol.org |
| [34] | Shamir. "How to Share a Secret." CACM, 1979. |
| [35] | Blakley. "Safeguarding cryptographic keys." AFIPS 1979. |
| [36] | Feldman. "A Practical Scheme for Non-Interactive Verifiable Secret Sharing." FOCS 1987. |
| [37] | Pedersen. "Non-Interactive and Information-Theoretic Secure Verifiable Secret Sharing." CRYPTO 1991. |
| [38] | Franklin, Yung. "Communication Complexity of Secure Computation." STOC 1992. |
| [39] | Herzberg et al. "Proactive Secret Sharing, Or: How to Cope with Perpetual Leakage." CRYPTO 1995. |
| [40] | Gennaro, Goldfeder. "Fast Multiparty Threshold ECDSA with Fast Trustless Setup." CCS 2018. (GG18) |
| [41] | Gennaro, Goldfeder. "One Round Threshold ECDSA with Identifiable Abort." 2020. (GG20) |
| [42] | Canetti et al. "UC Non-Interactive, Proactive, Threshold ECDSA with Identifiable Aborts." CCS 2020. (CGGMP) |
| [43] | Komlo, Goldberg. "FROST: Flexible Round-Optimized Schnorr Threshold Signatures." SAC 2020. |
| [44] | Ruffing et al. "ROAST: Robust Asynchronous Schnorr Threshold Signatures." CCS 2022. |
| [45] | Goldberg et al. "Verifiable Random Functions (VRFs)." RFC 9381, 2023. |
| [46] | Micali, Rabin, Vadhan. "Verifiable Random Functions." FOCS 1999. |
| [47] | Galindo et al. "A Practical Distributed VRF and its Use in E-Coupons." 2021. |
| [48] | Groth. "On the Size of Pairing-Based Non-interactive Arguments." EUROCRYPT 2016. (Groth16) |
| [49] | Gabizon, Williamson, Ciobotaru. "PLONK: Permutations over Lagrange-bases for Oecumenical Noninteractive arguments of Knowledge." 2019. |
| [50] | Chiesa et al. "Marlin: Preprocessing zkSNARKs with Universal and Updatable SRS." EUROCRYPT 2020. |
| [51] | Bowe, Grigg, Hopwood. "Recursive Proof Composition without a Trusted Setup." 2019. (Halo) |
| [52] | Ben-Sasson et al. "Scalable, transparent, and post-quantum secure computational integrity." 2018. (STARKs) |
| [53] | Bünz et al. "Bulletproofs: Short Proofs for Confidential Transactions and More." S&P 2018. |
| [54] | Kothapalli, Setty, Tzialla. "Nova: Recursive Zero-Knowledge Arguments from Folding Schemes." CRYPTO 2022. |
| [55] | Setty. "Spartan: Efficient and general-purpose zkSNARKs without trusted setup." CRYPTO 2020. |
| [56] | Golovnev et al. "Brakedown: Linear-time and field-agnostic SNARKs for R1CS." CRYPTO 2023. |
| [57] | Various (Polygon, Scroll, zkSync). "zkEVM: Zero-Knowledge Ethereum Virtual Machine." 2022–2024. |
| [58] | Fan, Vercauteren. "Somewhat Practical Fully Homomorphic Encryption." 2012. (BFV) |
| [59] | Brakerski, Gentry, Vaikuntanathan. "(Leveled) Fully Homomorphic Encryption without Bootstrapping." ITCS 2012. (BGV) |
| [60] | Cheon et al. "Homomorphic Encryption for Arithmetic of Approximate Numbers." ASIACRYPT 2017. (CKKS) |
| [61] | Chillotti et al. "TFHE: Fast Fully Homomorphic Encryption over the Torus." J. Cryptology, 2020. |
| [62] | Al Badawi et al. "OpenFHE: Open-Source Fully Homomorphic Encryption Library." 2022. |
| [63] | Paillier. "Public-Key Cryptosystems Based on Composite Degree Residuosity Classes." EUROCRYPT 1999. |
| [64] | Camenisch, Shoup. "Practical Verifiable Encryption and Decryption of Discrete Logarithms." CRYPTO 2003. |
| [65] | Asokan, Shoup, Waidner. "Optimistic Fair Exchange of Digital Signatures." EUROCRYPT 1998. |
| [66] | Kate, Zaverucha, Goldberg. "Constant-Size Commitments to Polynomials and Their Applications." ASIACRYPT 2010. (KZG) |
| [67] | Naor, Pinkas. "Efficient Oblivious Transfer Protocols." SODA 2001. |
| [68] | Ishai et al. "Extending Oblivious Transfers Efficiently." CRYPTO 2003. (IKNP) |
| [69] | Boyle et al. "Efficient Two-Round OT Extension and Silent Non-Interactive Secure Computation." CCS 2019. |
| [70] | Chou, Orlandi. "The Simplest Protocol for Oblivious Transfer." LATINCRYPT 2015. |
| [71] | Roy. "SoftSpokenOT: Quieter OT Extension from Small-Field Silent VOLE in the Minicrypt Model." CRYPTO 2022. |
| [72] | Goldreich, Micali, Wigderson. "How to Play Any Mental Game." STOC 1987. (GMW) |
| [73] | Ben-Or, Goldwasser, Wigderson. "Completeness Theorems for Non-Cryptographic Fault-Tolerant Distributed Computation." STOC 1988. (BGW) |
| [74] | Damgård et al. "Multiparty Computation from Somewhat Homomorphic Encryption." CRYPTO 2012. (SPDZ) |
| [75] | Demmler, Schneider, Zohner. "ABY — A Framework for Efficient Mixed-Protocol Secure Two-Party Computation." NDSS 2015. |
| [76] | Yao. "How to Generate and Exchange Secrets." FOCS 1986. |
| [77] | Keller. "MP-SPDZ: A Versatile Framework for Multi-Party Computation." CCS 2020. |
| [78] | Gueron, Langley, Lindell. "AES-GCM-SIV: Nonce Misuse-Resistant Authenticated Encryption." RFC 8452, 2019. |
| [79] | Krovetz, Rogaway. "The Software Performance of Authenticated-Encryption Modes." FSE 2011. (OCB) |
| [80] | Denis, Bhargavan, Gueron. "AEGIS: A Fast Authenticated Encryption Algorithm." 2023. |
| [81] | Dobraunig et al. "Ascon v1.2." NIST Lightweight Cryptography winner, 2023. |
| [82] | Biryukov, Dinu, Khovratovich. "Argon2: the memory-hard function for password hashing and other applications." PHC winner, 2015. |
| [83] | Percival. "Stronger Key Derivation via Sequential Memory-Hard Functions." BSDCan 2009. (scrypt) |
| [84] | Provos, Mazières. "A Future-Adaptable Password Scheme." USENIX 1999. (bcrypt) |
| [85] | Krawczyk, Eronen. "HMAC-based Extract-and-Expand Key Derivation Function (HKDF)." RFC 5869, 2010. |
| [86] | Boneh, Corrigan-Gibbs, Schechter. "Balloon Hashing: A Memory-Hard Function Providing Provable Protection Against Sequential Attacks." ASIACRYPT 2016. |
| [87] | Wu. "The SRP Authentication and Key Exchange System." RFC 2945, 2000. |
| [88] | Abdalla et al. "CPace, a balanced composable PAKE." IETF draft, 2023. |
| [89] | Bethencourt, Sahai, Waters. "Ciphertext-Policy Attribute-Based Encryption." S&P 2007. |
| [90] | Goyal, Pandey, Sahai, Waters. "Attribute-Based Encryption for Fine-Grained Access Control of Encrypted Data." CCS 2006. |
| [91] | Agrawal, Chase. "FAME: Fast Attribute-based Message Encryption." CCS 2017. |
| [92] | Abdalla et al. "Simple Functional Encryption Schemes for Inner Products." PKC 2015. |
| [93] | Goldwasser et al. "Multi-Input Functional Encryption." EUROCRYPT 2014. |
| [94] | Chaum. "Blind Signatures for Untraceable Payments." CRYPTO 1982. |
| [95] | Schnorr. "Blind Schnorr Signatures and Signed ElGamal Encryption in the Algebraic Group Model." EUROCRYPT 2021. |
| [96] | Boneh, Boyen, Shacham. "Short Group Signatures." CRYPTO 2004. / Tessaro, Zhu. "Revisiting BBS Signatures." EUROCRYPT 2023. |
| [97] | Abe, Ohkubo. "A Framework for Universally Composable Non-Committing Blind Signatures." ASIACRYPT 2009. |
| [98] | Rivest, Shamir, Tauman. "How to Leak a Secret." ASIACRYPT 2001. |
| [99] | Goodell et al. "Concise Linkable Ring Signatures and Forgery Against Adversarial Keys." 2019. (CLSAG) |
| [100] | Boneh, Boyen, Shacham. "Short Group Signatures." CRYPTO 2004. (BBS04) |
| [101] | Benaloh, de Mare. "One-Way Accumulators: A Decentralized Alternative to Digital Signatures." EUROCRYPT 1993. / Barić, Pfitzmann. 1997. |
| [102] | Nguyen. "Accumulators from Bilinear Pairings and Applications." CT-RSA 2005. |
| [103] | Merkle. "A Digital Signature Based on a Conventional Encryption Function." CRYPTO 1987. |
| [104] | Boneh, Bünz, Fisch. "Batching Techniques for Accumulators with Applications to IOPs and Stateless Blockchains." CRYPTO 2019. |
| [105] | Avanzi et al. "CRYSTALS-Kyber (ML-KEM)." NIST FIPS 203, 2024. |
| [106] | Alkim et al. "FrodoKEM: Learning With Errors Key Encapsulation." 2020. |
| [107] | Bernstein et al. "Classic McEliece." NIST PQC Round 4. |
| [108] | Aragon et al. "BIKE: Bit Flipping Key Encapsulation." NIST PQC Round 4. |
| [109] | Aguilar Melchor et al. "HQC: Hamming Quasi-Cyclic." NIST PQC Round 4. |
| [110] | Hoffstein, Pipher, Silverman. "NTRU: A Ring-Based Public Key Cryptosystem." ANTS 1998. |
| [111] | Ducas et al. "CRYSTALS-Dilithium (ML-DSA)." NIST FIPS 204, 2024. |
| [112] | Bernstein et al. "SPHINCS+: Stateless Hash-Based Signatures (SLH-DSA)." NIST FIPS 205, 2024. |
| [113] | Fouque et al. "Falcon: Fast-Fourier Lattice-based Compact Signatures over NTRU (FN-DSA)." NIST FIPS 206, 2024. |
| [114] | Huelsing et al. "XMSS: eXtended Merkle Signature Scheme." RFC 8391, 2018. |
| [115] | McGrew, Curcio, Fluhrer. "Leighton-Micali Hash-Based Signatures." RFC 8554, 2019. |
| [116] | De Feo et al. "SQIsign: compact post-quantum signatures from quaternions and isogenies." ASIACRYPT 2020. |
| [117] | Lyubashevsky. "Lattice Signatures without Trapdoors." EUROCRYPT 2012. |
| [118] | Stebila, Mosca. "Post-Quantum Key Exchange for the Internet and the Open Quantum Safe Project." SAC 2016. / Chrome: hybrid X25519Kyber768, 2024. |

---

## Contributing

Contributions welcome! Please open an issue or PR to add missing schemes, correct references, or improve descriptions.

---

## License

[![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

This list is dedicated to the public domain under CC0 1.0.
