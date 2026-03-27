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
- [Pseudorandom Functions (PRF) & Pseudorandom Permutations (PRP)](#pseudorandom-functions-prf--pseudorandom-permutations-prp)
- [Oblivious PRF (OPRF)](#oblivious-prf-oprf)
- [Verifiable Delay Functions (VDF)](#verifiable-delay-functions-vdf)
- [Distributed Key Generation (DKG)](#distributed-key-generation-dkg)
- [Identity-Based Encryption (IBE)](#identity-based-encryption-ibe)
- [Proxy Re-Encryption (PRE)](#proxy-re-encryption-pre)
- [Signcryption](#signcryption)
- [Private Set Intersection (PSI)](#private-set-intersection-psi)
- [Oblivious RAM (ORAM)](#oblivious-ram-oram)
- [Private Information Retrieval (PIR)](#private-information-retrieval-pir)
- [Searchable Encryption (SSE / PEKS)](#searchable-encryption-sse--peks)
- [Format-Preserving Encryption (FPE)](#format-preserving-encryption-fpe)
- [Anonymous Credentials](#anonymous-credentials)
- [One-Time Signatures (OTS)](#one-time-signatures-ots)
- [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd)
- [Chameleon Hash (Trapdoor Hash)](#chameleon-hash-trapdoor-hash)
- [Threshold Decryption](#threshold-decryption)
- [Publicly Verifiable Secret Sharing (PVSS)](#publicly-verifiable-secret-sharing-pvss)
- [Broadcast Encryption](#broadcast-encryption)
- [Time-Lock Puzzles / Timed-Release Encryption](#time-lock-puzzles--timed-release-encryption)
- [Randomness Beacons / Coin Tossing](#randomness-beacons--coin-tossing)
- [Verifiable Computation (VC)](#verifiable-computation-vc)
- [Proof of Work (PoW) / Proof of Space](#proof-of-work-pow--proof-of-space)
- [Deniable Encryption](#deniable-encryption)
- [Fuzzy Extractors / Secure Sketches](#fuzzy-extractors--secure-sketches)
- [Mix Networks (Mixnets)](#mix-networks-mixnets)
- [Order-Preserving / Order-Revealing Encryption (OPE / ORE)](#order-preserving--order-revealing-encryption-ope--ore)
- [Deterministic Encryption / Convergent Encryption](#deterministic-encryption--convergent-encryption)
- [Key Encapsulation Mechanism (KEM) / DEM Paradigm](#key-encapsulation-mechanism-kem--dem-paradigm)
- [Indistinguishability Obfuscation (iO)](#indistinguishability-obfuscation-io)
- [Updatable Encryption](#updatable-encryption)
- [Rerandomizable Encryption](#rerandomizable-encryption)
- [Puncturable / Constrained PRF](#puncturable--constrained-prf)
- [Non-Malleable Encryption / Commitments](#non-malleable-encryption--commitments)
- [Secret Handshakes / Hidden Credentials](#secret-handshakes--hidden-credentials)
- [Randomness Extractors](#randomness-extractors)
- [Secure Channels / Protocol Constructions](#secure-channels--protocol-constructions)
- [Fujisaki-Okamoto Transform](#fujisaki-okamoto-transform)
- [Universal Hash Functions (Carter-Wegman)](#universal-hash-functions-carter-wegman)
- [Adaptor Signatures / Scriptless Scripts](#adaptor-signatures--scriptless-scripts)
- [Secure Aggregation (SecAgg)](#secure-aggregation-secagg)
- [Multi-Key / Threshold FHE](#multi-key--threshold-fhe)
- [Group Key Agreement](#group-key-agreement)
- [Multilinear Maps](#multilinear-maps)
- [Proof-Carrying Data (PCD)](#proof-carrying-data-pcd)
- [Certificate Transparency (CT)](#certificate-transparency-ct)
- [Prio / VDAF (Privacy-Preserving Aggregation)](#prio--vdaf-privacy-preserving-aggregation)
- [Steganography](#steganography)
- [Physical Unclonable Functions (PUF)](#physical-unclonable-functions-puf)
- [White-Box Cryptography](#white-box-cryptography)
- [Leakage-Resilient Cryptography](#leakage-resilient-cryptography)
- [Differential Privacy](#differential-privacy)
- [Attribute-Based Signatures (ABS)](#attribute-based-signatures-abs)
- [Key-Homomorphic PRF](#key-homomorphic-prf)
- [Batch Arguments (BARG) / Accumulation Schemes](#batch-arguments-barg--accumulation-schemes)
- [Garbled Circuits (expanded)](#garbled-circuits-expanded)
- [Circular / KDM Security](#circular--kdm-security)
- [Accountable Multi-Signatures / Subgroup Signatures](#accountable-multi-signatures--subgroup-signatures)
- [One-Time Pad / Information-Theoretic Security](#one-time-pad--information-theoretic-security)
- [Commit-Reveal Schemes](#commit-reveal-schemes)
- [Interactive Oracle Proofs (IOP) / PCP](#interactive-oracle-proofs-iop--pcp)
- [Folding Schemes](#folding-schemes)
- [zkML (Zero-Knowledge Machine Learning)](#zkml-zero-knowledge-machine-learning)
- [Function Secret Sharing (FSS) / Distributed Point Functions (DPF)](#function-secret-sharing-fss--distributed-point-functions-dpf)
- [Homomorphic Secret Sharing (HSS)](#homomorphic-secret-sharing-hss)
- [Homomorphic Signatures](#homomorphic-signatures)
- [Sanitizable Signatures](#sanitizable-signatures)
- [Proxy Signatures](#proxy-signatures)
- [DC-Nets (Dining Cryptographers Networks)](#dc-nets-dining-cryptographers-networks)
- [Onion Routing](#onion-routing)
- [Hierarchical Deterministic Keys (BIP32 / HD Wallets)](#hierarchical-deterministic-keys-bip32--hd-wallets)
- [Token-Based Authentication (TOTP / FIDO2 / WebAuthn)](#token-based-authentication-totp--fido2--webauthn)
- [Puncturable Encryption](#puncturable-encryption)
- [Matchmaking Encryption](#matchmaking-encryption)
- [Registration-Based Encryption (RBE)](#registration-based-encryption-rbe)
- [Pseudorandom Generators (PRG)](#pseudorandom-generators-prg)
- [Trapdoor Functions / Trapdoor Permutations](#trapdoor-functions--trapdoor-permutations)
- [Forward-Secure Signatures & Encryption](#forward-secure-signatures--encryption)
- [Disk Encryption / Tweakable Block Ciphers](#disk-encryption--tweakable-block-ciphers)
- [Key Wrapping / Envelope Encryption](#key-wrapping--envelope-encryption)
- [End-to-End Verifiable E-Voting](#end-to-end-verifiable-e-voting)
- [Message Franking / Abuse Reporting in E2E](#message-franking--abuse-reporting-in-e2e)
- [Data Availability Sampling (DAS)](#data-availability-sampling-das)
- [Encrypted Mempools / Threshold Encryption for Transaction Ordering](#encrypted-mempools--threshold-encryption-for-transaction-ordering)
- [Sequential Aggregate Signatures](#sequential-aggregate-signatures)
- [Private Function Evaluation (PFE)](#private-function-evaluation-pfe)
- [Oblivious Sorting / Oblivious Data Structures](#oblivious-sorting--oblivious-data-structures)
- [Covert Security / Publicly Auditable MPC](#covert-security--publicly-auditable-mpc)
- [SNARG (Succinct Non-Interactive Arguments without Zero-Knowledge)](#snarg-succinct-non-interactive-arguments-without-zero-knowledge)
- [Witness Encryption](#witness-encryption)
- [Honey Encryption](#honey-encryption)
- [Designated Verifier Signatures / Proofs](#designated-verifier-signatures--proofs)
- [Undeniable Signatures](#undeniable-signatures)
- [Certificateless Cryptography](#certificateless-cryptography)
- [Privacy Pass / Anonymous Tokens](#privacy-pass--anonymous-tokens)
- [Non-Interactive Key Exchange (NIKE)](#non-interactive-key-exchange-nike)
- [Cryptographic Reverse Firewalls](#cryptographic-reverse-firewalls)
- [Non-Malleable Codes](#non-malleable-codes)
- [Silent OT / Pseudorandom Correlation Generators (PCG)](#silent-ot--pseudorandom-correlation-generators-pcg)
- [Delay Encryption](#delay-encryption)
- [Vector Commitments](#vector-commitments)
- [Sponge Construction / Duplex](#sponge-construction--duplex)
- [Lightweight Cryptography / ASCON](#lightweight-cryptography--ascon)
- [Lookup Arguments](#lookup-arguments)
- [Sumcheck Protocol](#sumcheck-protocol)
- [Double Ratchet / Symmetric Ratchet](#double-ratchet--symmetric-ratchet)
- [Continuous Group Key Agreement (CGKA) / MLS](#continuous-group-key-agreement-cgka--mls)
- [Proofs of Retrievability (PoR) / Provable Data Possession](#proofs-of-retrievability-por--provable-data-possession)
- [Functional Commitments](#functional-commitments)
- [Laconic Cryptography](#laconic-cryptography)
- [Verifiable Information Dispersal (VID)](#verifiable-information-dispersal-vid)
- [Sigma Protocols / Schnorr Identification](#sigma-protocols--schnorr-identification)
- [Structure-Preserving Signatures (SPS)](#structure-preserving-signatures-sps)
- [Groth-Sahai Proofs](#groth-sahai-proofs)
- [Semaphore / Anonymous Group Signaling (RLN)](#semaphore--anonymous-group-signaling-rln)
- [Garbled RAM](#garbled-ram)
- [Anonymous IBE](#anonymous-ibe)
- [Password Hardened Encryption (PHE)](#password-hardened-encryption-phe)
- [Oblivious Message Retrieval (OMR)](#oblivious-message-retrieval-omr)
- [Incremental Cryptography](#incremental-cryptography)
- [Rerandomizable Signatures (PS Signatures)](#rerandomizable-signatures-ps-signatures)
- [Key Transparency / CONIKS](#key-transparency--coniks)
- [Proactive Secret Sharing](#proactive-secret-sharing)
- [Visual Cryptography](#visual-cryptography)
- [Non-Interactive DKG (NIDKG)](#non-interactive-dkg-nidkg)
- [Asynchronous BFT / Asynchronous MPC](#asynchronous-bft--asynchronous-mpc)
- [Key-Insulated Cryptography](#key-insulated-cryptography)
- [Client Puzzles / Proof of Effort](#client-puzzles--proof-of-effort)
- [Identity-Based Signatures (IBS)](#identity-based-signatures-ibs)
- [Oblivious Linear Evaluation (OLE) / VOLE](#oblivious-linear-evaluation-ole--vole)
- [Multi-Authority ABE](#multi-authority-abe)
- [Keyed-Verification Anonymous Credentials (KVAC)](#keyed-verification-anonymous-credentials-kvac)
- [MPC-in-the-Head (MPCitH)](#mpc-in-the-head-mpcith)
- [Packed Secret Sharing](#packed-secret-sharing)
- [Verifiable Timed Commitments](#verifiable-timed-commitments)
- [Constrained / Policy-Based Signatures](#constrained--policy-based-signatures)
- [Aggregate Signatures (BLS Aggregate)](#aggregate-signatures-bls-aggregate)
- [Linkable Ring Signatures](#linkable-ring-signatures)
- [Distributed PRF (DPRF)](#distributed-prf-dprf)
- [Zero-Knowledge Sets](#zero-knowledge-sets)
- [Broadcast Authentication (TESLA)](#broadcast-authentication-tesla)
- [Compressed Sigma Protocols](#compressed-sigma-protocols)
- [Proof of Solvency / Proof of Reserves](#proof-of-solvency--proof-of-reserves)
- [Confidential Transactions (CT)](#confidential-transactions-ct)
- [Range Proofs](#range-proofs)
- [Fair Exchange / Atomic Swaps](#fair-exchange--atomic-swaps)
- [Batch Verification](#batch-verification)
- [Partially Blind Signatures](#partially-blind-signatures)
- [Sealed-Bid Auction Protocols](#sealed-bid-auction-protocols)
- [Oblivious Key-Value Store (OKVS)](#oblivious-key-value-store-okvs)
- [Non-Committing Encryption](#non-committing-encryption)
- [Conditional Disclosure of Secrets (CDS)](#conditional-disclosure-of-secrets-cds)
- [Witness PRF](#witness-prf)
- [Traceable Signatures](#traceable-signatures)
- [Post-Quantum Cryptography](#post-quantum-cryptography)

---

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

## Key Exchange / Key Agreement

**Goal:** Establish a shared secret over an insecure channel, providing confidentiality for subsequent communication.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ECDH (X25519)** | 2006 | Elliptic curves | Curve25519; default in TLS 1.3, Signal, WireGuard [[1]](https://cr.yp.to/ecdh/curve25519-20060209.pdf) |
| **X448** | 2015 | Goldilocks curve | 224-bit security; RFC 7748 [[1]](https://eprint.iacr.org/2015/625) |
| **Classic DH** | 1976 | Discrete logarithm | Original key exchange; use 2048+ bit groups [[1]](https://ee.stanford.edu/~hellman/publications/24.pdf) |
| **SPAKE2 / OPAQUE** | 2005 | PAKE | Password-authenticated; no PKI needed [[1]](https://eprint.iacr.org/2005/096)[[2]](https://eprint.iacr.org/2018/163) |
| **MQV / HMQV** | 1995 | DL + static keys | Implicitly authenticated 2-pass protocol [[1]](https://eprint.iacr.org/2005/176) |
| **Noise Framework** | 2016 | Composable patterns | Modular handshakes: XX, IK, NK, etc. [[1]](https://noiseprotocol.org/noise.html) |

**State of the art:** X25519 (ephemeral DH), OPAQUE (PAKE without exposing password to server), Noise XX (modern protocol design).

---

## Secret Sharing Schemes (SSS)

**Goal:** Split a secret into *n* shares so that any *t* shares reconstruct it, but fewer than *t* reveal nothing. Provides confidentiality + availability.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Shamir's Secret Sharing** | 1979 | Polynomial interpolation | Information-theoretically secure; *(t,n)* threshold [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Blakley's Scheme** | 1979 | Hyperplane geometry | Alternative geometric approach [[1]](https://doi.org/10.1109/AFIPS.1979.98) |
| **Verifiable SS (VSS) — Feldman** | 1987 | Commitments on polynomial coeff. | Detects cheating dealer [[1]](https://doi.org/10.1109/SFCS.1987.4) |
| **Verifiable SS — Pedersen** | 1991 | Double commitments | Information-theoretically hiding [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Packed Secret Sharing** | 1992 | Multi-secret polynomial | Amortized: share multiple secrets at once [[1]](https://dl.acm.org/doi/10.1145/129712.129780) |
| **Proactive SS** | 1995 | Periodic share refresh | Tolerates mobile adversary over time [[1]](https://link.springer.com/chapter/10.1007/3-540-44750-4_27) |

**State of the art:** Shamir + Feldman VSS (practical), Packed SS (MPC optimization).

---

## Threshold Signature Schemes (TSS)

**Goal:** *t-of-n* parties collectively sign without ever reconstructing the private key. Provides distributed trust and non-repudiation.

| Scheme | Year | Underlying Sig | Note |
|--------|------|---------------|------|
| **GG18 / GG20** | 2018 | ECDSA | Threshold ECDSA with presigning; used in MPC wallets [[1]](https://eprint.iacr.org/2019/114)[[2]](https://eprint.iacr.org/2020/540) |
| **CGGMP** | 2021 | ECDSA | UC-secure, identifiable abort, improved over GG20 [[1]](https://eprint.iacr.org/2021/060) |
| **FROST** | 2020 | Schnorr | Simple, round-efficient threshold Schnorr; 2 rounds [[1]](https://eprint.iacr.org/2020/852) |
| **Threshold BLS** | 2001 | BLS | Deterministic; natural from Shamir + pairing; non-interactive aggregation [[1]](https://eprint.iacr.org/2001/002)[[2]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **MuSig2** | 2020 | Schnorr | 2-round multi-signature (all *n* of *n*); BIP 327 [[1]](https://eprint.iacr.org/2020/1261) |
| **ROAST** | 2022 | Schnorr/FROST | Robust wrapper for asynchronous FROST signing [[1]](https://eprint.iacr.org/2022/550) |

**State of the art:** FROST (Schnorr threshold), CGGMP (ECDSA threshold), ROAST (robust async).

---

## Verifiable Random Functions (VRF)

**Goal:** Produce a pseudorandom output from a secret key and input so that the output is deterministic, unpredictable, and publicly verifiable. Used in lotteries, leader election, DNS (NSEC5).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ECVRF** | 2023 | Elliptic curves | IETF standard (RFC 9381); based on Elligator [[1]](https://www.rfc-editor.org/rfc/rfc9381) |
| **RSA-FDH VRF** | 1999 | RSA | Full-domain hash approach; larger proofs [[1]](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Pseudo%20Randomness/Verifiable_Random_Functions.pdf) |
| **BLS-based VRF** | 2001 | Pairings | Short proofs; naturally threshold-friendly [[1]](https://eprint.iacr.org/2001/002) |
| **Threshold VRF (DVRF)** | 2020 | DKG + VRF | Distributed: t-of-n nodes produce VRF jointly [[1]](https://eprint.iacr.org/2020/096) |

**State of the art:** ECVRF (RFC 9381), BLS-VRF (threshold-friendly for blockchain).

---

## Zero-Knowledge Proofs (ZK)

**Goal:** Prove that a statement is true without revealing any information beyond the truth of the statement. Provides privacy + verifiability.

### General-Purpose ZK (for arbitrary circuits)

| System | Year | Type | Note |
|--------|------|------|------|
| **Groth16** | 2016 | zk-SNARK (pairing) | Shortest proofs (~192 B), trusted setup per circuit [[1]](https://eprint.iacr.org/2016/260) |
| **PLONK** | 2019 | zk-SNARK (pairing) | Universal trusted setup (powers of tau); widely used [[1]](https://eprint.iacr.org/2019/953) |
| **Marlin** | 2019 | zk-SNARK (pairing) | Universal & updatable setup [[1]](https://eprint.iacr.org/2019/1047) |
| **Halo 2** | 2019 | zk-SNARK (no trusted setup) | Recursive; IPA-based; used in Zcash Orchard [[1]](https://eprint.iacr.org/2019/1021) |
| **STARKs** | 2018 | Transparent (hash-based) | No trusted setup, post-quantum friendly; larger proofs [[1]](https://eprint.iacr.org/2018/046) |
| **Bulletproofs** | 2017 | IPA-based | No trusted setup; compact range proofs [[1]](https://eprint.iacr.org/2017/1066) |
| **Nova / SuperNova** | 2021 | IVC / folding | Incremental Verifiable Computation; minimal per-step cost [[1]](https://eprint.iacr.org/2021/370) |
| **Spartan** | 2019 | Sum-check protocol | No trusted setup, no FFTs; very fast prover [[1]](https://eprint.iacr.org/2019/550) |
| **Brakedown / Binius** | 2021 | Code-based | Hardware-friendly, binary-field proofs [[1]](https://eprint.iacr.org/2021/1043) |

### Specialized ZK Protocols

| Protocol | Year | Purpose |
|----------|------|---------|
| **Sigma protocols (Schnorr)** | 1989 | DL knowledge proof; basis for many schemes [[1]](https://link.springer.com/article/10.1007/BF00196725) |
| **Pedersen + range proof** | 1991 | Confidential transactions (Monero, Mimblewimble) [[1]](https://eprint.iacr.org/2017/1066) |
| **zk-EVM (Polygon, Scroll, zkSync)** | 2022 | Prove EVM execution in ZK [[1]](https://eprint.iacr.org/2022/1692) |
| **Fiat-Shamir Transform** | 1987 | Hash-based | Convert interactive Sigma protocol → non-interactive; foundation of all SNARKs and many signature schemes [[1]](https://link.springer.com/chapter/10.1007/3-540-47721-7_12) |
| **Groth-Sahai Proofs** | 2008 | Pairings | NIZK for pairing-based equations; no trusted setup [[1]](https://eprint.iacr.org/2007/155) |
| **Lookup Arguments (Plookup / Lasso)** | 2020 | Polynomial IOP | Prove table lookups inside ZK circuits; used in all modern ZK-EVMs [[1]](https://eprint.iacr.org/2020/315)[[2]](https://eprint.iacr.org/2023/1216) |

**State of the art:** PLONK/KZG variants (practical SNARKs), STARKs (transparency + PQ), Nova (IVC/folding for recursion).

---

## Homomorphic Encryption (HE)

**Goal:** Compute on encrypted data without decrypting it. The result, when decrypted, matches computation on plaintext. Provides confidentiality during processing.

| Scheme | Year | Type | Supported Operations | Note |
|--------|------|------|---------------------|------|
| **BFV** | 2012 | Leveled HE (integer arith.) | add, mul (leveled), SIMD batching | Batch integer computation via SIMD [[1]](https://eprint.iacr.org/2012/144) |
| **BGV** | 2011 | Leveled HE (integer arith.) | add, mul (leveled), mod switching | Modulus switching for noise control [[1]](https://eprint.iacr.org/2011/277) |
| **CKKS** | 2017 | Approximate HE (real/complex) | add, mul (approx. real/complex), SIMD | ML-friendly; approximate fixed-point [[1]](https://eprint.iacr.org/2016/421) |
| **TFHE** | 2016 | Fully HE (Boolean/small int) | any Boolean gate, small int add/mul, fast bootstrapping | Fast bootstrapping (~10 ms); gate-by-gate [[1]](https://eprint.iacr.org/2018/421) |
| **OpenFHE** | 2022 | Library | all of above (library) | Implements BFV, BGV, CKKS, TFHE (successor to PALISADE, HElib, HEAAN) [[1]](https://eprint.iacr.org/2022/915) |
| **Paillier** | 1999 | Additive HE only | add only, scalar mul | Simple; used in e-voting, MPC, federated learning [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |

**State of the art:** TFHE (fast bootstrapping), CKKS (ML on encrypted data), OpenFHE (reference library).

---

## Verifiable Encryption

**Goal:** Encrypt a value and prove (in zero-knowledge) that the ciphertext contains a plaintext satisfying a given relation — without revealing it. Used in fair exchange, escrow, and group signatures.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Camenisch-Shoup** | 2003 | CCA2 enc + ZKP | General framework; widely cited [[1]](https://eprint.iacr.org/2002/161) |
| **Asokan-Shoup-Waidner** | 1998 | RSA-based | Optimistic fair exchange via TTP [[1]](https://link.springer.com/chapter/10.1007/BFb0054144) |
| **Verifiable Enc. of DL** | 2003 | ElGamal + Sigma | Prove enc. of discrete log; simple and efficient [[1]](https://eprint.iacr.org/2002/161) |
| **ZK + Hybrid Enc.** | 2016 | SNARK/STARK + Enc. | Modern: prove anything about ciphertext contents [[1]](https://eprint.iacr.org/2016/260) |

**State of the art:** Camenisch-Shoup framework + modern SNARKs for generic relations.

---

## Commitment Schemes

**Goal:** Commit to a value (hiding) so it can be revealed later (binding). Like a sealed envelope. Used as a building block in many protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen Commitment** | 1991 | DLP | Perfectly hiding, computationally binding; additively homomorphic [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Hash Commitment** | 2002 | Hash function | `C = H(m ‖ r)`; simple, practical [[1]](https://csrc.nist.gov/publications/detail/fips/180/4/final) |
| **KZG (Kate) Commitment** | 2010 | Pairings + polynomial | Commit to polynomials; constant-size proofs; trusted setup [[1]](https://eprint.iacr.org/2010/274) |
| **FRI** | 2017 | Hash + RS codes | Polynomial commitment; transparent (no setup); used in STARKs [[1]](https://eprint.iacr.org/2018/046) |
| **Bulletproofs IPA** | 2017 | Inner-product argument | Logarithmic-size polynomial commitment [[1]](https://eprint.iacr.org/2017/1066) |
| **Vector Commitments** | 2013 | Pairings / RSA | Commit to a vector; open any single position with constant-size proof; used in Verkle trees [[1]](https://eprint.iacr.org/2011/495) |
| **Ajtai Commitment** | 1996 | Lattices (SIS) | Lattice-based, post-quantum; collision-resistance from hardness of SIS [[1]](https://dl.acm.org/doi/10.1145/237814.237838) |

**State of the art:** KZG (SNARKs, Ethereum danksharding), FRI (STARKs, PQ-friendly).

---

## Oblivious Transfer (OT)

**Goal:** Sender has multiple messages; receiver picks one and learns only that one — sender doesn't learn which was chosen. Foundational for MPC.

| Scheme | Year | Note |
|--------|------|------|
| **1-out-of-2 OT (Naor-Pinkas)** | 2001 | Based on DDH; efficient base OT [[1]](https://dl.acm.org/doi/10.5555/365411.365502) |
| **OT Extension (IKNP)** | 2003 | Extend few base OTs into millions cheaply via symmetric crypto [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45146-4_9) |
| **Silent OT (Boyle et al.)** | 2019 | Sublinear communication using pseudorandom correlation generators [[1]](https://eprint.iacr.org/2019/1159) |
| **Simplest OT (Chou-Orlandi)** | 2015 | 1 round, 1 exponentiation; practical [[1]](https://eprint.iacr.org/2015/267) |
| **SoftSpokenOT** | 2022 | Optimized OT extension [[1]](https://eprint.iacr.org/2022/192) |

**State of the art:** Silent OT extension (minimal communication), SoftSpokenOT.

---

## Multi-Party Computation (MPC)

**Goal:** Multiple parties jointly compute a function over their private inputs without revealing anything except the output. Provides privacy + correctness.

| Protocol | Year | Model | Note |
|----------|------|-------|------|
| **GMW** | 1987 | Semi-honest, Boolean | Gate-by-gate OT-based; foundational [[1]](https://dl.acm.org/doi/10.1145/28395.28420) |
| **BGW** | 1988 | Info.-theoretic, honest majority | No crypto assumptions if ≥2/3 honest [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **SPDZ / SPDZ2k** | 2012 | Malicious, dishonest majority | Preprocessing + MAC-based online phase [[1]](https://eprint.iacr.org/2011/535) |
| **ABY / ABY3** | 2015 | Mixed: Arithmetic, Boolean, Yao | Efficient conversions between share types [[1]](https://eprint.iacr.org/2018/403) |
| **Garbled Circuits (Yao)** | 1986 | 2PC, semi-honest | Constant-round; optimized with free-XOR, half-gates [[1]](https://eprint.iacr.org/2014/756) |
| **MP-SPDZ** | 2020 | Framework | Implements 30+ MPC protocols [[1]](https://eprint.iacr.org/2020/521) |

**State of the art:** SPDZ2k (dishonest majority), ABY3 (3-party ML), Silent-OT-based 2PC.

---

## Authenticated Encryption (AEAD)

**Goal:** Confidentiality + Integrity + Authentication in a single primitive. Encrypt and authenticate data so tampering is detectable.

| Algorithm | Year | Note |
|-----------|------|------|
| **AES-256-GCM** | 2004 | NIST standard; hardware-accelerated; nonce-misuse vulnerable [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **ChaCha20-Poly1305** | 2013 | Software-fast; TLS 1.3, WireGuard; IETF RFC 8439 [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf)[[2]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **AES-GCM-SIV** | 2019 | Nonce-misuse resistant; RFC 8452 [[1]](https://www.rfc-editor.org/rfc/rfc8452) |
| **AES-OCB3** | 2011 | Very fast (single-pass); patent-free since 2021 [[1]](https://link.springer.com/article/10.1007/s00145-011-9107-9) |
| **AEGIS-128L / AEGIS-256** | 2014 | AES-round-based stream; fastest AEAD on AES-NI hardware [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-aegis-aead/) |
| **Ascon** | 2023 | Lightweight AEAD; NIST LWC winner (2023) [[1]](https://ascon.iaik.tugraz.at/) |

**State of the art:** AES-256-GCM (standard), AEGIS (speed record on AES-NI), Ascon (constrained devices).

---

## Password-Based Key Derivation (KDF / PAKE)

**Goal:** Derive strong cryptographic keys from weak passwords, or authenticate over a password without exposing it to the server.

### Key Derivation Functions (KDF)

| Algorithm | Year | Note |
|-----------|------|------|
| **Argon2id** | 2015 | PHC winner (2015); memory-hard; recommended default [[1]](https://github.com/P-H-C/phc-winner-argon2/blob/master/argon2-specs.pdf) |
| **scrypt** | 2009 | Memory-hard; used in Litecoin, Tarsnap [[1]](https://www.tarsnap.com/scrypt/scrypt.pdf) |
| **bcrypt** | 1999 | Classic; Blowfish-based; still widely deployed [[1]](https://www.usenix.org/legacy/publications/library/proceedings/usenix99/provos/provos.pdf) |
| **HKDF** | 2010 | Extract-then-expand; not for passwords; RFC 5869 [[1]](https://www.rfc-editor.org/rfc/rfc5869) |
| **Balloon Hashing** | 2016 | Provably memory-hard; NIST candidate [[1]](https://eprint.iacr.org/2016/027) |

### Password-Authenticated Key Exchange (PAKE)

| Protocol | Year | Note |
|----------|------|------|
| **OPAQUE** | 2018 | Asymmetric PAKE; server never sees password; IETF draft [[1]](https://eprint.iacr.org/2018/163) |
| **SPAKE2** | 2005 | Symmetric PAKE; simple, round-efficient; RFC 9382 [[1]](https://eprint.iacr.org/2005/096) |
| **SRP** | 2000 | Legacy PAKE; TLS-SRP; widely deployed [[1]](https://www.rfc-editor.org/rfc/rfc2945) |
| **CPace** | 2018 | Balanced PAKE; IETF draft; provably secure in UC model [[1]](https://eprint.iacr.org/2018/286) |

**State of the art:** Argon2id (password hashing), OPAQUE (asymmetric PAKE).

---

## Attribute-Based & Functional Encryption

**Goal:** Fine-grained access control embedded in ciphertext. Decrypt only if your attributes/key satisfy a policy. Provides access control + confidentiality.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **CP-ABE (Bethencourt-Sahai-Waters)** | 2007 | Ciphertext-Policy ABE | Policy in ciphertext; key has attributes [[1]](https://eprint.iacr.org/2006/309) |
| **KP-ABE (Goyal-Pandey-Sahai-Waters)** | 2006 | Key-Policy ABE | Policy in key; ciphertext has attributes [[1]](https://eprint.iacr.org/2006/309) |
| **FAME** | 2017 | CP-ABE (prime-order) | Fast, prime-order groups; practical [[1]](https://eprint.iacr.org/2017/807) |
| **Inner-Product FE (Abdalla et al.)** | 2015 | Functional Encryption | Decrypt inner product of attribute vectors [[1]](https://eprint.iacr.org/2015/017) |
| **Multi-Input FE** | 2014 | Functional Encryption | Multiple encryptors, joint function [[1]](https://eprint.iacr.org/2013/774) |
| **Predicate Encryption (KSW)** | 2008 | Pairings | Generalization of ABE: decrypt iff predicate(key attrs, ct attrs) = true [[1]](https://eprint.iacr.org/2008/290) |

**State of the art:** FAME (practical ABE), Inner-Product FE (ML applications).

---

## Blind Signatures

**Goal:** Signer signs a message without seeing its content. Provides anonymity + non-repudiation. Used in e-cash, anonymous credentials, Privacy Pass.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Blind Signature** | 1982 | RSA | Chaum's original; used in Privacy Pass (RFC 9474) [[1]](https://eprint.iacr.org/2022/895) |
| **Blind Schnorr** | 1989 | DLP | Simple but requires care with ROS problem [[1]](https://eprint.iacr.org/2019/877) |
| **BBS+ / BBS** | 2004 | Pairings | Multi-message blind sign + selective disclosure; W3C VC [[1]](https://eprint.iacr.org/2023/275) |
| **Abe's Blind Signature** | 1997 | Pairing | Partially blind; used in anonymous e-cash schemes [[1]](https://link.springer.com/chapter/10.1007/978-3-642-10366-7_35) |

**State of the art:** RSA Blind Sig (Privacy Pass), BBS+ (anonymous credentials & selective disclosure).

---

## Ring & Group Signatures

**Goal:** Sign on behalf of a group/ring without revealing which member signed. Provides anonymity within a set.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **Ring Signatures (Rivest-Shamir-Tauman)** | 2001 | Ring | Ad-hoc group, no setup; used in Monero (pre-2020) [[1]](https://link.springer.com/chapter/10.1007/3-540-45682-1_32) |
| **CLSAG** | 2019 | Ring (linkable) | Compact Linkable Spontaneous; current Monero scheme [[1]](https://eprint.iacr.org/2019/654) |
| **Group Signatures (BBS04)** | 2004 | Group | Requires group manager; revocable anonymity [[1]](https://eprint.iacr.org/2004/174) |
| **Short Group Sig (Boneh-Boyen-Shacham)** | 2004 | Group | Pairing-based; very short signatures [[1]](https://eprint.iacr.org/2004/174) |

**State of the art:** CLSAG (privacy coins), BBS Group Sig (enterprise), Raptor (PQ ring sig).

---

## Accumulators

**Goal:** Compactly represent a set and prove (non-)membership of elements. Used for revocation lists, stateless blockchain validation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Accumulator** | 1993 | Strong RSA | Constant-size; add/delete + membership proofs [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_24) |
| **Bilinear Accumulator** | 2005 | Pairings | Efficient non-membership proofs [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30580-4_14) |
| **Merkle Tree** | 1979 | Hash | Simple; membership proof is O(log n); used everywhere [[1]](https://link.springer.com/chapter/10.1007/3-540-48184-2_32) |
| **Verkle Tree** | 2018 | KZG + Merkle | Smaller proofs than Merkle; proposed for Ethereum [[1]](https://eprint.iacr.org/2010/274) |
| **Bloom Filter** | 1970 | Hash-based | Probabilistic set membership test; false positives, no false negatives; ubiquitous [[1]](https://dl.acm.org/doi/10.1145/362686.362692) |
| **Garbled Bloom Filter** | 2014 | Symmetric | Privacy-preserving set membership; used in PSI protocols [[1]](https://eprint.iacr.org/2013/620) |

**State of the art:** Verkle Trees (blockchain), RSA Accumulators + batching [[1]](https://eprint.iacr.org/2018/1188).

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

## Oblivious PRF (OPRF)

**Goal:** Privacy. A client and server jointly evaluate a PRF on the client's input using the server's key — the client learns only the output, the server learns nothing. Provides input confidentiality + unlinkability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **2HashDH OPRF** | 2009 | DLEQ / EC | Simple DH-based; basis of most deployed OPRFs [[1]](https://eprint.iacr.org/2014/650) |
| **VOPRF** | 2021 | EC + DLEQ proof | Verifiable: client can check server evaluated correctly [[1]](https://www.rfc-editor.org/rfc/rfc9497) |
| **POPRF** | 2021 | EC + tweak | Partially-oblivious: server adds a public tweak to evaluation [[1]](https://www.rfc-editor.org/rfc/rfc9497) |

**State of the art:** VOPRF (RFC 9497) with Ristretto255 — used in Privacy Pass, OPAQUE password protocol, PSI.

---

## Verifiable Delay Functions (VDF)

**Goal:** Unpredictability + public verifiability. Compute a function that requires at least T sequential steps, but whose output can be verified quickly. Used in unbiasable randomness beacons and blockchain leader election.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pietrzak VDF** | 2019 | RSA groups | Recursive halving proof; O(√T) proof size [[1]](https://eprint.iacr.org/2018/627) |
| **Wesolowski VDF** | 2019 | RSA / class groups | Single group element proof; O(1) size [[1]](https://eprint.iacr.org/2018/623) |
| **MinRoot VDF** | 2022 | Prime field | SNARK-friendly; low multiplicative depth [[1]](https://eprint.iacr.org/2022/1626) |

**State of the art:** Wesolowski VDF (Ethereum randomness, Chia), MinRoot (ZK-provable VDF).

---

## Distributed Key Generation (DKG)

**Goal:** Availability + distributed trust. Generate a threshold public/private keypair among *n* parties so that no single party — nor any coalition below threshold *t* — ever knows the full private key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen DKG** | 1991 | VSS + commitments | Simple, widely deployed; not robust against rushing [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **GJKR DKG** | 1999 | VSS + ZK | Provably secure; handles malicious parties [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_10) |
| **Aggregatable DKG** | 2020 | KZG + pairings | O(n log n) communication; scalable to thousands of nodes [[1]](https://eprint.iacr.org/2021/005) |
| **FROST DKG** | 2020 | Schnorr + VSS | Designed to pair with FROST threshold signing [[1]](https://eprint.iacr.org/2020/852) |

**State of the art:** Aggregatable DKG (large-scale blockchains), GJKR (security-critical threshold systems).

---

## Identity-Based Encryption (IBE)

**Goal:** Confidentiality without PKI. Encrypt to an arbitrary identity string (email address, phone number, domain) — the recipient obtains a private key from a trusted authority and decrypts.

**Architecture:** A trusted **Private Key Generator (PKG)** holds a master secret key (msk) and publishes a master public key (mpk). Anyone can encrypt to an identity string using mpk. The recipient contacts the PKG, authenticates, and receives their identity-specific secret key via `Extract(msk, id) → sk_id`. **Key escrow problem:** the PKG can decrypt all messages — motivating [Registration-Based Encryption](#registration-based-encryption-rbe) which removes this trust assumption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Franklin IBE** | 2001 | Bilinear pairings | First practical IBE; Weil pairing on elliptic curves [[1]](https://eprint.iacr.org/2001/090) |
| **Waters IBE** | 2005 | Pairings | Selective-ID secure without random oracles [[1]](https://eprint.iacr.org/2004/180) |
| **HIBE (Gentry-Silverberg)** | 2002 | Pairings | Hierarchical IBE; delegatable to sub-authorities [[1]](https://eprint.iacr.org/2002/107) |
| **Lattice IBE (Gentry-Peikert-Vaikuntanathan)** | 2008 | LWE | Post-quantum IBE [[1]](https://eprint.iacr.org/2007/432) |

**State of the art:** Boneh-Franklin (widely taught), lattice IBE (PQ setting).

---

## Proxy Re-Encryption (PRE)

**Goal:** Delegated confidentiality. A semi-trusted proxy can re-encrypt Alice's ciphertext so Bob can decrypt it — without the proxy ever seeing the plaintext. Used in cloud storage access delegation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blaze-Bleumer-Strauss PRE** | 1998 | ElGamal | First scheme; bidirectional re-encryption [[1]](https://link.springer.com/chapter/10.1007/BFb0054122) |
| **AFGH PRE** | 2006 | Pairings | Unidirectional, non-interactive; CPA-secure [[1]](https://eprint.iacr.org/2005/028) |
| **Umbral (NuCypher)** | 2018 | EC + AFGH | Threshold PRE: *t-of-n* proxies needed [[1]](https://eprint.iacr.org/2017/206) |

**State of the art:** AFGH (single-hop), Umbral (threshold, deployed in NuCypher/Threshold network).

---

## Signcryption

**Goal:** Confidentiality + Authentication + Non-repudiation in a single pass. More efficient than sequential sign-then-encrypt; security is proven jointly (IND-CCA2 + EUF-CMA).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zheng Signcryption** | 1997 | DLP / EC | First scheme; ~50% cost reduction vs. sign+encrypt [[1]](https://link.springer.com/chapter/10.1007/BFb0052234) |
| **ECSC (Bao-Deng)** | 1998 | ECDLP | Elliptic curve variant; formal security proof [[1]](https://link.springer.com/chapter/10.1007/BFb0052237) |
| **Signcryption KEM/DEM** | 2004 | Hybrid | Modular: KEM provides authenticated key + DEM encrypts [[1]](https://eprint.iacr.org/2004/075) |

**State of the art:** Hybrid signcryption KEM/DEM (provable security), used in secure messaging design.

---

## Private Set Intersection (PSI)

**Goal:** Privacy-preserving intersection. Two parties compute the intersection of their private sets, learning only the intersection — nothing about non-matching elements. Used in contact discovery (Signal, Apple), private advertising measurement.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DH-based PSI** | 1986 | DDH | Simple commutative hash approach; not maliciously secure [[1]](https://link.springer.com/chapter/10.1007/978-3-662-10199-5_5) |
| **OPRF-based PSI** | 2019 | OPRF + hashing | State of the art; near-optimal communication [[1]](https://eprint.iacr.org/2016/799) |
| **Circuit PSI** | 2018 | Garbled circuits | Maliciously secure; outputs secret-shared intersection [[1]](https://eprint.iacr.org/2018/120) |
| **PSI-CA** | 2012 | Various | Cardinality only: learn size of intersection, not elements [[1]](https://eprint.iacr.org/2011/141) |

**State of the art:** OPRF-based PSI (semi-honest), circuit PSI (malicious), PSI-CA (minimal leakage).

---

## Oblivious RAM (ORAM)

**Goal:** Access pattern hiding. Access a remote encrypted store so that the server cannot tell which locations are being read or written — even across many accesses.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Goldreich-Ostrovsky ORAM** | 1996 | Hierarchical hash tables | Foundational; O(log³ n) overhead [[1]](https://dl.acm.org/doi/10.1145/233551.233553) |
| **Path ORAM** | 2013 | Binary tree | Simple, practical; O(log n) bandwidth [[1]](https://eprint.iacr.org/2013/280) |
| **Circuit ORAM** | 2015 | Circuit-friendly | Optimized for MPC; minimal circuit size [[1]](https://eprint.iacr.org/2014/672) |
| **Onion ORAM** | 2016 | Layered encryption | Constant bandwidth in amortized setting [[1]](https://eprint.iacr.org/2015/005) |

**State of the art:** Path ORAM (practical deployments), Circuit ORAM (MPC context).

---

## Private Information Retrieval (PIR)

**Goal:** Query privacy. A client retrieves an element from a database without the server learning which element was fetched.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IT-PIR (Chor et al.)** | 1995 | Information-theoretic | Requires 2+ non-colluding servers; optimal communication [[1]](https://dl.acm.org/doi/10.1145/293347.293350) |
| **Kushilevitz-Ostrovsky PIR** | 1997 | Quadratic residues | First single-server computational PIR [[1]](https://dl.acm.org/doi/10.1145/258533.258559) |
| **SealPIR** | 2018 | RLWE / BFV | Practical single-server PIR; ~1 ms/query [[1]](https://eprint.iacr.org/2017/1142) |
| **SimplePIR / DoublePIR** | 2023 | LWE | Fastest practical PIR; near-optimal [[1]](https://eprint.iacr.org/2022/949) |

**State of the art:** SimplePIR/DoublePIR (speed), IT-PIR (information-theoretic setting).

---

## Searchable Encryption (SSE / PEKS)

**Goal:** Confidential search. Search over encrypted data without decrypting it. A server executes keyword queries on ciphertexts and returns matching documents.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SSE (Song-Wagner-Perrig)** | 2000 | Symmetric, stream cipher | First practical SSE; sequential scan [[1]](https://ieeexplore.ieee.org/document/848445) |
| **PEKS (Boneh et al.)** | 2004 | Pairings | Public-key keyword search; anyone can generate trapdoors [[1]](https://eprint.iacr.org/2003/195) |
| **OXT** | 2013 | Symmetric + OT | Conjunctive queries; sublinear search time [[1]](https://eprint.iacr.org/2013/169) |
| **Dynamic SSE (Kamara-Papamanthou)** | 2013 | PRF + inverted index | Supports updates; leakage-optimal [[1]](https://eprint.iacr.org/2012/563) |

**State of the art:** OXT (multi-keyword), Dynamic SSE (updatable datasets).

---

## Format-Preserving Encryption (FPE)

**Goal:** Confidentiality with structural compatibility. Ciphertext has the exact same format as plaintext — a 16-digit credit card number encrypts to another 16-digit number. Required for PCI-DSS tokenization and legacy systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FF1** | 2016 | Feistel + AES | NIST SP 800-38G standard; variable-radix alphabet [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/final) |
| **FF3-1** | 2019 | Feistel + AES tweaked | NIST SP 800-38G Rev.1; replaces broken FF3 [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/rev-1/final) |
| **BPS (Bellare-Pian-Shi)** | 2010 | Feistel | Theoretical foundation for FPE security [[1]](https://eprint.iacr.org/2009/251) |

**State of the art:** FF1 (general), FF3-1 (tweakable, NIST standard).

---

## Anonymous Credentials

**Goal:** Selective disclosure + unlinkability. Prove possession of attributes (age, nationality, membership) without revealing identity or linking multiple presentations. Used in digital IDs, privacy-preserving access control.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CL Signatures (Camenisch-Lysyanskaya)** | 2001 | RSA-based | Show any subset of signed attributes in ZK [[1]](https://eprint.iacr.org/2001/019) |
| **U-Prove** | 2010 | DLP | One-show tokens; minimal disclosure; Microsoft research [[1]](https://www.microsoft.com/en-us/research/project/u-prove/) |
| **idemix (IBM)** | 2001 | CL + ZK | Multi-show credentials with unlinkability [[1]](https://idemix.wordpress.com/) |
| **PS Signatures (Pointcheval-Sanders)** | 2016 | Pairings | Short, randomizable; used in Coconut / Nym network [[1]](https://eprint.iacr.org/2015/525) |

**State of the art:** PS Signatures (blockchain/Nym), CL Signatures (enterprise), BBS+ (W3C Verifiable Credentials).

---

## One-Time Signatures (OTS)

**Goal:** Post-quantum authentication. Sign exactly one message; the signing key is spent. Quantum-safe: security depends only on hash function collision resistance. Building block of XMSS, LMS, and SPHINCS+.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lamport OTS** | 1979 | Hash function | Simplest OTS; key size = 2n×hash; one message only [[1]](https://dl.acm.org/doi/10.1145/357980.358017) |
| **WOTS (Winternitz OTS)** | 1980 | Hash chains | Compact variant; trade key size vs. signing cost [[1]](https://link.springer.com/chapter/10.1007/978-1-4684-4730-9_10) |
| **WOTS+** | 2012 | Hash chains + bitmask | Tighter security proof; used inside XMSS and SPHINCS+ [[1]](https://eprint.iacr.org/2017/965) |
| **FORS** | 2019 | Hash forest | Few-time variant; used inside SPHINCS+ for hypertree leaves [[1]](https://eprint.iacr.org/2017/349) |

**State of the art:** WOTS+ (used in XMSS, LMS, SPHINCS+), FORS (SPHINCS+ inner layer).

---

## Quantum Key Distribution (QKD)

**Goal:** Information-theoretic key establishment. Distribute a shared secret key using quantum mechanics — any eavesdropping attempt disturbs the quantum state and is detectable. Unlike PQ crypto (software), QKD requires quantum hardware.

| Protocol | Year | Encoding | Note |
|----------|------|----------|------|
| **BB84** | 1984 | Photon polarization | First QKD protocol; 4 polarization states [[1]](https://www.sciencedirect.com/science/article/pii/S0304397514004241) |
| **E91** | 1991 | Entangled pairs | Bell inequality violation as security test [[1]](https://link.springer.com/chapter/10.1007/978-3-319-53412-1_2) |
| **B92** | 1992 | 2 non-orthogonal states | Simpler than BB84; less efficient [[1]](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.68.3121) |
| **MDI-QKD** | 2012 | Measurement-device-independent | Removes detector side-channels; more practical [[1]](https://eprint.iacr.org/2012/003) |

**State of the art:** BB84 (deployed in commercial QKD, China's Micius satellite), MDI-QKD (practical lab deployments).

---

## Chameleon Hash (Trapdoor Hash)

**Goal:** Controlled collision resistance. A hash function that appears collision-resistant to everyone except the holder of a secret trapdoor key, who can find arbitrary collisions. Enables redactable signatures and updatable blockchain transactions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Krawczyk-Rabin Chameleon Hash** | 1997 | DLP | First scheme; trapdoor = discrete log [[1]](https://link.springer.com/chapter/10.1007/3-540-49677-7_17) |
| **EC Chameleon Hash** | 2004 | ECDLP | Elliptic curve variant; compact keys [[1]](https://link.springer.com/chapter/10.1007/978-3-540-28632-5_2) |
| **Chameleon-Hash with Ephemeral Trapdoors** | 2017 | Pairings | Per-message trapdoor; used in sanitizable signatures [[1]](https://eprint.iacr.org/2017/018) |

**State of the art:** EC Chameleon Hash (redactable blockchain, GDPR-compliant chains), Sanitizable Signatures (document workflows).

---

## Threshold Decryption

**Goal:** Distributed confidentiality. *t-of-n* parties jointly decrypt a ciphertext without any single party reconstructing the full private key. Complement to Threshold Signatures for the encryption side.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold ElGamal** | 1994 | DDH + Shamir SSS | Classic; partial decryptions combined [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_3) |
| **Threshold RSA (Shoup)** | 2000 | RSA + VSS | Secure threshold RSA decryption [[1]](https://eprint.iacr.org/1999/011) |
| **PVSS-based Threshold Dec.** | 2001 | PVSS + ElGamal | Publicly verifiable shares; no trusted dealer [[1]](https://eprint.iacr.org/1999/041) |
| **TPKE (Threshold BLS Enc.)** | 2020 | Pairings + Shamir | Non-interactive; used in Ethereum DVT, Dusk Network [[1]](https://eprint.iacr.org/2021/339) |

**State of the art:** Threshold ElGamal (general), TPKE (blockchain applications, DVT).

---

## Publicly Verifiable Secret Sharing (PVSS)

**Goal:** Transparency + integrity. A verifiable secret sharing scheme where *anyone* (not just participants) can verify that shares are correctly computed — even without a trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Stadler PVSS** | 1996 | DLP + ZK | First practical PVSS [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_6) |
| **Schoenmakers PVSS** | 1999 | DLP | Simpler, more efficient; widely deployed [[1]](https://eprint.iacr.org/1999/011) |
| **Aggregatable PVSS** | 2021 | KZG + pairings | O(1) verification; scalable for blockchain randomness [[1]](https://eprint.iacr.org/2021/339) |

**State of the art:** Aggregatable PVSS (randomness beacons, DKG), Schoenmakers (classic deployments).

---

## Broadcast Encryption

**Goal:** Selective confidentiality. Encrypt to an arbitrary subset of *N* registered users so only authorized members can decrypt. Efficient revocation without re-keying all users. Used in DRM (Blu-ray AACS), pay-TV, multicast.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fiat-Naor BE** | 1993 | Combinatorial | First formal broadcast encryption scheme [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_40) |
| **NNL (Subset-Difference)** | 2001 | Key trees | Used in AACS (Blu-ray); O(r log(N/r)) header size [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_4) |
| **Boneh-Gentry-Waters** | 2005 | Bilinear pairings | O(1) ciphertext header; short keys [[1]](https://eprint.iacr.org/2005/018) |
| **Traitor Tracing (BSW)** | 2006 | Pairings | Identify leakers of decryption keys; combines with BE [[1]](https://eprint.iacr.org/2006/056) |

**State of the art:** NNL (industry standard in AACS/CPPM), Boneh-Gentry-Waters (short ciphertexts).

---

## Time-Lock Puzzles / Timed-Release Encryption

**Goal:** Temporal confidentiality. Force a minimum sequential computation time *T* before a secret can be recovered — even with unlimited parallelism. "Encrypt to the future."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest-Shamir-Wagner TLP** | 1996 | Repeated squaring (RSA group) | First time-lock puzzle; foundational [[1]](https://people.csail.mit.edu/rivest/pubs/RSW96.pdf) |
| **Malavolta-Thyagarajan TLP** | 2019 | Generic (any sequential function) | TLP without RSA assumption [[1]](https://eprint.iacr.org/2019/635) |
| **Homomorphic TLP** | 2020 | RSA + HE | Compute on time-locked data without unlocking [[1]](https://eprint.iacr.org/2019/635) |

**State of the art:** RSW TLP (practical, used with VDFs), Homomorphic TLP (privacy-preserving auctions).

---

## Randomness Beacons / Coin Tossing

**Goal:** Public unpredictability. Generate random values that are publicly verifiable, unpredictable before publication, and unbiasable by any party. Used in lotteries, parameter generation, leader election.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum Coin Tossing** | 1981 | Commitment | First 2-party fair coin toss protocol [[1]](https://dl.acm.org/doi/10.1145/800076.802493) |
| **NIST Randomness Beacon** | 2013 | Hardware RNG | Centralized public beacon; 512-bit values every 60s [[1]](https://csrc.nist.gov/projects/interoperable-randomness-beacons) |
| **drand (League of Entropy)** | 2020 | Threshold BLS | Decentralized beacon; Cloudflare, Protocol Labs, etc. [[1]](https://eprint.iacr.org/2023/728) |
| **RANDAO + VDF** | 2022 | Commit-reveal + VDF | Ethereum Beacon Chain; bias-resistant via VDF [[1]](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/attestations/) |

**State of the art:** drand (decentralized, production-grade), RANDAO+VDF (Ethereum consensus).

---

## Verifiable Computation (VC)

**Goal:** Delegated integrity. Outsource computation to an untrusted server and verify correctness of the result efficiently — faster than re-executing. Foundation of rollups, cloud computing, and proof-carrying data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Interactive Proofs (GMR)** | 1985 | Information-theoretic | Foundational: prover convinces verifier of statement truth [[1]](https://dl.acm.org/doi/10.1145/22145.22178) |
| **Pinocchio** | 2013 | QAPs + pairings | First practical VC; basis of many zkSNARKs [[1]](https://eprint.iacr.org/2013/279) |
| **GGP (FHE-based VC)** | 2010 | FHE | Verify any computation via bootstrapping [[1]](https://eprint.iacr.org/2009/547) |
| **vnTinyRAM / TinyRAM** | 2013 | SNARK for RAM | VC for arbitrary programs (not just circuits) [[1]](https://eprint.iacr.org/2013/507) |

**State of the art:** modern zkSNARKs/STARKs subsume VC; Pinocchio historically foundational.

---

## Proof of Work (PoW) / Proof of Space

**Goal:** Sybil resistance. Prove that computational or storage resources were expended. Unforgeable and adjustable in difficulty. Foundation of permissionless consensus (Bitcoin, Zcash, Chia).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hashcash** | 1997 | SHA-1 / hash | First practical PoW; anti-spam email [[1]](http://www.hashcash.org/papers/hashcash.pdf) |
| **Bitcoin PoW** | 2008 | Double-SHA256 | Difficulty-adjustable PoW; Nakamoto consensus [[1]](https://bitcoin.org/bitcoin.pdf) |
| **Equihash** | 2016 | Generalized birthday | Memory-hard PoW; ASIC-resistant; used in Zcash [[1]](https://eprint.iacr.org/2015/946) |
| **Proof of Space (Dziembowski)** | 2015 | Graph pebbling | Store data instead of compute; used in Chia Network [[1]](https://eprint.iacr.org/2013/796) |

**State of the art:** Bitcoin PoW (deployed, highest hashrate), Proof of Space (energy-efficient alternative).

---

## Deniable Encryption

**Goal:** Coercion resistance. After encryption, the sender/receiver can produce fake randomness making it look like a different plaintext was encrypted. Protects under duress or legal compulsion.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CDNO Deniable Encryption** | 1997 | Sender-deniable PKE | Foundational definitions; first constructions [[1]](https://link.springer.com/chapter/10.1007/BFb0052229) |
| **Sahai-Waters Receiver-Deniable** | 2014 | iO (indistinguishability obfuscation) | First receiver-deniable PKE (from iO) [[1]](https://eprint.iacr.org/2014/381) |
| **OTR Messaging** | 2004 | DH + MAC (no signatures) | Practical deniability in chat; no non-repudiation [[1]](https://otr.cypherpunks.ca/otr-wpes.pdf) |
| **Signal Protocol (deniability)** | 2013 | Triple-DH + ratchet | Deniable by design: no binding signatures on messages [[1]](https://signal.org/docs/specifications/doubleratchet/) |

**State of the art:** Signal Protocol (practical messaging), OTR (classic chat), Sahai-Waters (theoretical).

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

## Mix Networks (Mixnets)

**Goal:** Sender anonymity. Messages are shuffled through a chain of servers; each removes a layer of encryption and permutes the batch, so the link between sender and recipient is hidden. Foundation of anonymous communication and e-voting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum Decryption Mix** | 1981 | PKE + layered enc | First mixnet proposal; onion encryption through relay chain [[1]](https://link.springer.com/chapter/10.1007/978-1-4757-0602-4_18) |
| **Re-encryption Mixnet** | 1993 | Rerandomizable enc | Rerandomize ciphertexts without decrypting at each hop [[1]](https://link.springer.com/chapter/10.1007/3-540-57220-1_66) |
| **Verifiable Shuffle (Neff)** | 2001 | ZK proofs | Prove shuffle correctness; used in e-voting (Verificatum) [[1]](https://dl.acm.org/doi/10.1145/501983.502000) |
| **Loopix / Nym** | 2017 | Poisson mixing + cover traffic | Continuous-time mixnet; resists traffic analysis [[1]](https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/piotrowska) |

**State of the art:** Loopix/Nym (modern anonymous comm.), Verifiable Shuffle (e-voting).

---

## Order-Preserving / Order-Revealing Encryption (OPE / ORE)

**Goal:** Encrypted range queries. Ciphertext preserves or reveals the numerical order of plaintexts, enabling range queries on encrypted databases without decrypting. **Warning:** inherent leakage; weaker than standard encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boldyreva OPE** | 2009 | Hypergeometric sampling | First provably secure OPE; leaks order + approximate distance [[1]](https://eprint.iacr.org/2009/197) |
| **Chenette-Lewi-Wu ORE** | 2016 | PRF + block cipher | Reveals only order, not distance; "best-possible" ORE [[1]](https://eprint.iacr.org/2016/612) |
| **Lewi-Wu Practical ORE** | 2016 | PRF | Efficient; used in CryptDB-like systems [[1]](https://eprint.iacr.org/2016/612) |

**State of the art:** Lewi-Wu ORE (practical), but SSE/FHE approaches preferred when leakage is unacceptable.

---

## Deterministic Encryption / Convergent Encryption

**Goal:** Encrypted deduplication & lookup. Same plaintext always produces the same ciphertext, enabling equality checks without decryption. Leaks plaintext equality — not suitable where this matters.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SIV Mode (Rogaway-Shrimpton)** | 2006 | AES + CMAC | Deterministic AEAD; misuse-resistant; IV = MAC(header, plaintext) [[1]](https://eprint.iacr.org/2006/221) |
| **Convergent Encryption** | 2002 | Hash-as-key | Key = H(plaintext); enables cloud dedup of encrypted data [[1]](https://dl.acm.org/doi/10.5555/514236.514238) |
| **MLE (Message-Locked Encryption)** | 2013 | Various | Formalization of convergent encryption with security definitions [[1]](https://eprint.iacr.org/2012/631) |

**State of the art:** AES-SIV (misuse-resistant AEAD, RFC 5297), MLE (cloud deduplication).

---

## Key Encapsulation Mechanism (KEM) / DEM Paradigm

**Goal:** Modular encryption design. Split public-key encryption into two clean steps: (1) KEM produces a shared symmetric key from public key, (2) DEM encrypts data with that key. Enables clean security proofs and mix-and-match of components.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shoup KEM/DEM** | 2001 | Any PKE | Formal paradigm definition; cleaner than direct PKE proofs [[1]](https://shoup.net/papers/kem-dem.pdf) |
| **RSA-KEM** | 2003 | RSA | Random RSA encapsulation; NIST SP 800-56B [[1]](https://csrc.nist.gov/publications/detail/sp/800/56/b/rev-2/final) |
| **DHKEM (X25519)** | 2022 | ECDH | DH-based KEM used in HPKE (RFC 9180) [[1]](https://www.rfc-editor.org/rfc/rfc9180) |
| **ML-KEM (Kyber)** | 2024 | MLWE lattice | NIST PQ standard KEM (FIPS 203) [[1]](https://csrc.nist.gov/pubs/fips/203/final) |

**State of the art:** all modern encryption standards use KEM/DEM (HPKE, ML-KEM, ECIES). The paradigm is the default design pattern.

---

## Indistinguishability Obfuscation (iO)

**Goal:** Maximum software protection. Make a program "unintelligible" while preserving its input/output behavior. Theoretical "crypto-complete" primitive: iO + one-way functions → almost any cryptographic primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH+SW13 (first candidate)** | 2013 | Multilinear maps | First iO candidate construction; broken/patched repeatedly [[1]](https://eprint.iacr.org/2013/451) |
| **Jain-Lin-Sahai** | 2021 | LWE + LPN + PRG assumptions | First iO from well-studied assumptions; breakthrough [[1]](https://eprint.iacr.org/2020/1003) |
| **Witness Encryption (GGSW)** | 2013 | Multilinear maps / iO | Encrypt to an NP statement; decrypt with witness [[1]](https://eprint.iacr.org/2013/258) |

**State of the art:** Jain-Lin-Sahai (2021) — theoretical milestone; iO remains impractical but is the "holy grail" of crypto.

---

## Updatable Encryption

**Goal:** Key rotation without re-download. Server applies a short re-encryption token to update all ciphertexts from an old key to a new key — without decrypting or downloading data. Used in cloud storage key rotation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BLMR (Boneh et al.)** | 2013 | ElGamal / AES | Formal model for ciphertext-independent updates [[1]](https://eprint.iacr.org/2012/021) |
| **Lehmann-Tackmann** | 2018 | Hybrid (KEM + DEM) | CCA-secure updatable encryption [[1]](https://eprint.iacr.org/2018/794) |
| **Klooß-Lehmann-Rupp** | 2019 | Forward-secure enc | Forward + post-compromise security [[1]](https://eprint.iacr.org/2019/043) |

**State of the art:** Klooß-Lehmann-Rupp (strongest security guarantees), BLMR (foundational).

---

## Rerandomizable Encryption

**Goal:** Unlinkable ciphertexts. Anyone can publicly transform a ciphertext into a fresh-looking encryption of the same plaintext — unlinkable to the original. Foundation of mixnets and anonymous credentials.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ElGamal (rerandomizable)** | 1985 | DDH | Naturally rerandomizable: multiply by Enc(1) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **Groth RCCA** | 2004 | Pairings | CCA-secure under rerandomization (RCCA model) [[1]](https://eprint.iacr.org/2003/174) |
| **Prabhakaran-Rosulek RCCA** | 2007 | DDH | Efficient RCCA without pairings [[1]](https://eprint.iacr.org/2007/064) |

**State of the art:** Groth RCCA (provable security), ElGamal (practical in mixnets/voting).

---

## Puncturable / Constrained PRF

**Goal:** Fine-grained key delegation. A PRF key can be "punctured" at specific points: the punctured key works everywhere *except* those points. Enables forward secrecy without state and 0-RTT key exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Puncturable PRF (Boneh-Waters)** | 2013 | GGM tree | Puncture at any polynomial set of points [[1]](https://eprint.iacr.org/2013/602) |
| **Constrained PRF (BW/KPTZ)** | 2013 | GGM / lattice | Key evaluates only on a constrained input set (e.g., prefix, circuit) [[1]](https://eprint.iacr.org/2013/352) |

**State of the art:** GGM-based puncturable PRFs (used in forward-secure 0-RTT, Bloom Filter Encryption).

---

## Non-Malleable Encryption / Commitments

**Goal:** Integrity against related-message attacks. An adversary who sees a ciphertext/commitment cannot produce a valid ciphertext/commitment for a *related* message. Stronger than CCA2 in certain settings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dolev-Dwork-Naor** | 1991 | Simulation-based | First definition + construction of non-malleable encryption [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **Non-Malleable Commitments** | 1991 | Complexity-theoretic | Cannot produce related commitment from seeing one; used in MPC [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **CCA2 as NM** | 1998 | Various | CCA2 security implies non-malleability for encryption (Bellare et al.) [[1]](https://eprint.iacr.org/1998/006) |

**State of the art:** CCA2-secure encryption (standard), explicit non-malleability needed for commitments in MPC protocols.

---

## Secret Handshakes / Hidden Credentials

**Goal:** Mutual private authentication. Two parties discover if they share a group membership — if not, neither learns anything about the other. No information leaks on failed authentication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Balfanz-Durfee-et-al.** | 2003 | Pairing-based | First secret handshake scheme; CA issues group credentials [[1]](https://dl.acm.org/doi/10.1145/948109.948126) |
| **Multi-Group SH (Castelluccia)** | 2004 | Bilinear maps | Support for multiple simultaneous group memberships [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30108-0_22) |
| **Unlinkable SH (Jarecki-Liu)** | 2009 | OPRF + ZK | Unlinkable across sessions; stronger privacy [[1]](https://eprint.iacr.org/2008/332) |

**State of the art:** Unlinkable Secret Handshakes (strongest privacy), pairing-based SH (practical).

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

## Secure Channels / Protocol Constructions

**Goal:** End-to-end security. Combine key exchange, encryption, authentication, and ratcheting into a complete secure communication protocol. These are where all the primitives come together.

| Protocol | Year | Components | Note |
|----------|------|------------|------|
| **TLS 1.3** | 2018 | ECDHE + AEAD + HKDF | Standard Internet security protocol; 1-RTT handshake; RFC 8446 [[1]](https://www.rfc-editor.org/rfc/rfc8446) |
| **Signal Protocol (Double Ratchet)** | 2013 | X3DH + AES-CBC + HMAC-SHA256 | Asynchronous E2E messaging; forward secrecy + post-compromise security [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **WireGuard** | 2017 | Noise IK + X25519 + ChaCha20-Poly1305 | Minimalist VPN; ~4000 lines of code [[1]](https://www.wireguard.com/papers/wireguard.pdf) |
| **MLS (Messaging Layer Security)** | 2023 | TreeKEM + HPKE + AEAD | Scalable group E2E messaging; RFC 9420 [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **Noise Framework** | 2018 | DH patterns + AEAD | Composable handshake patterns (XX, IK, NK, etc.) [[1]](https://noiseprotocol.org/noise.html) |

**State of the art:** TLS 1.3 (web), Signal (messaging), MLS (group chat), WireGuard (VPN).

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

## Adaptor Signatures / Scriptless Scripts

**Goal:** Conditional signatures. A "pre-signature" that becomes a valid signature only when a secret value is revealed — and revealing the signature reveals the secret. Enables trustless atomic swaps and payment channels without scripting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schnorr Adaptor Signatures** | 2018 | Schnorr / DLP | Pre-sign with respect to a point T; completion reveals discrete log of T [[1]](https://eprint.iacr.org/2020/476) |
| **ECDSA Adaptor Signatures** | 2020 | ECDSA | Adaptor for ECDSA; enables scriptless scripts on Bitcoin pre-Taproot [[1]](https://eprint.iacr.org/2020/476) |
| **Scriptless Scripts (Poelstra)** | 2017 | Schnorr + adaptor | Atomic swaps, payment channels, discreet log contracts — no on-chain scripts [[1]](https://download.wpsoftware.net/bitcoin/wizardry/mw-slides/2017-03-mit-bitcoin-expo/slides.pdf) |

**State of the art:** Schnorr adaptor sigs (Bitcoin Taproot), ECDSA adaptors (cross-chain swaps).

---

## Secure Aggregation (SecAgg)

**Goal:** Privacy-preserving summation. Multiple clients send encrypted inputs to a server, which learns only the aggregate (sum/average) — not individual contributions. Core primitive for federated learning.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bonawitz et al. (Google SecAgg)** | 2017 | Secret sharing + DH masking | Tolerates dropouts; used in Gboard federated learning [[1]](https://eprint.iacr.org/2017/281) |
| **Bell et al. (SecAgg+)** | 2020 | Sparse secret sharing | O(n log n) communication; improved scalability [[1]](https://eprint.iacr.org/2020/704) |
| **FLAME (LWE-based)** | 2023 | LWE | Post-quantum secure aggregation [[1]](https://eprint.iacr.org/2023/224) |

**State of the art:** SecAgg+ (Google/Apple production), FLAME (PQ setting).

---

## Multi-Key / Threshold FHE

**Goal:** Joint computation on data encrypted under different keys. Multiple parties each encrypt their data under their own key; a computation is performed on all ciphertexts jointly without any party decrypting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Multi-Key FHE (López-Alt et al.)** | 2012 | NTRU lattice | First MKFHE; N parties, joint decryption [[1]](https://eprint.iacr.org/2011/613) |
| **Threshold BFV/BGV** | 2012 | Shamir + HE | Secret-share FHE key among N parties; joint bootstrapping [[1]](https://eprint.iacr.org/2011/535) |
| **Multi-Party CKKS** | 2020 | RLWE + SS | Privacy-preserving ML on distributed encrypted data [[1]](https://eprint.iacr.org/2020/304) |

**State of the art:** Multi-Party CKKS (federated ML), Threshold BFV (joint computation with no single key holder).

---

## Group Key Agreement

**Goal:** Multi-party key establishment. Extend 2-party Diffie-Hellman to *n* parties who jointly establish a shared group key. Used in group messaging, conferencing, multicast.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burmester-Desmedt** | 1994 | DH / DLP | 2-round group DH; all parties contribute [[1]](https://link.springer.com/chapter/10.1007/BFb0053443) |
| **Tree-DH (Kim-Perrig-Tsudik)** | 2004 | DH binary tree | Logarithmic rounds; efficient join/leave [[1]](https://dl.acm.org/doi/10.1145/1030083.1030088) |
| **TreeKEM (MLS)** | 2018 | DH + ratchet tree | Used in MLS (RFC 9420); efficient group ratcheting [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **Continuous Group Key Agreement (CGKA)** | 2020 | Formal model | Security model for TreeKEM and MLS [[1]](https://eprint.iacr.org/2019/1189) |

**State of the art:** TreeKEM/MLS (messaging), Burmester-Desmedt (classic group DH).

---

## Multilinear Maps

**Goal:** Generalized pairings. A *k*-linear map takes elements from *k* groups and outputs an element in a target group, enabling richer algebraic operations than bilinear pairings. Theoretical foundation for early iO and multi-party non-interactive key exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH13** | 2013 | Ideal lattices | First candidate multilinear map; zeroizing attacks found [[1]](https://eprint.iacr.org/2012/610) |
| **CLT13** | 2013 | CRT over integers | Alternative construction; also broken in many settings [[1]](https://eprint.iacr.org/2013/183) |
| **GGH15 (Graph-Induced)** | 2015 | Lattice | More structured; partial resistance to zeroizing attacks [[1]](https://eprint.iacr.org/2014/645) |

**State of the art:** no fully secure multilinear map candidate exists; research continues. Modern iO (Jain-Lin-Sahai 2021) avoids multilinear maps.

---

## Proof-Carrying Data (PCD)

**Goal:** Distributed IVC. Extend incrementally verifiable computation to distributed settings: each node in a computation graph produces a proof that all prior computation was correct. Foundation of blockchain interoperability and recursive SNARKs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chiesa-Tromer (PCD)** | 2010 | Recursive SNARKs | First PCD construction; compliance proofs for distributed protocols [[1]](https://eprint.iacr.org/2010/174) |
| **Recursive SNARK composition** | 2014 | Cycles of curves | Practical PCD via SNARK verifier inside a SNARK (Ben-Sasson et al.) [[1]](https://eprint.iacr.org/2014/595) |
| **Nova-based PCD** | 2022 | Folding schemes | IVC + folding for lightweight distributed proof chains [[1]](https://eprint.iacr.org/2021/370) |

**State of the art:** Nova-based PCD (efficient), recursive SNARKs on cycles of elliptic curves (Mina, Pickles).

---

## Certificate Transparency (CT)

**Goal:** Public auditability of certificates. Append-only Merkle-tree log of all TLS certificates issued by CAs, so misissued certificates are publicly detectable. Not a cryptographic primitive per se, but a critical cryptographic protocol.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Certificate Transparency (RFC 6962)** | 2013 | Merkle tree + signatures | Google initiative; all major CAs participate [[1]](https://www.rfc-editor.org/rfc/rfc6962) |
| **Signed Certificate Timestamps (SCT)** | 2013 | Ed25519 / ECDSA | Proof of log inclusion; embedded in TLS certificates [[1]](https://www.rfc-editor.org/rfc/rfc6962) |
| **Verifiable Data Structures** | 2015 | Merkle / append-only | General framework: key transparency, binary transparency (Google) [[1]](https://transparency.dev/) |

**State of the art:** CT v2 (mandatory for Chrome), Key Transparency (Google/Apple for E2E messaging).

---

## Prio / VDAF (Privacy-Preserving Aggregation)

**Goal:** Verifiable private aggregation. Clients secret-share their data across multiple servers; servers jointly compute the aggregate and can verify that each client's input is well-formed — without learning individual inputs. Used in privacy-preserving telemetry.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Prio** | 2017 | Secret sharing + SNIPs | First practical system; used in Firefox, ISRG [[1]](https://crypto.stanford.edu/prio/paper.pdf) |
| **Prio3 / VDAF** | 2023 | IETF DAP protocol | Standardized VDAF (RFC 9709-area); FLP + secret sharing [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-vdaf/) |
| **Poplar / Prio+** | 2021 | Heavy hitters + IDPF | Find popular strings privately; Mozilla/Apple telemetry [[1]](https://eprint.iacr.org/2021/017) |

**State of the art:** Prio3/VDAF (IETF standard), Poplar (heavy-hitter queries in Chrome, Firefox).

---

## Steganography

**Goal:** Covert communication. Hide the very existence of a secret message within an innocent-looking cover medium (image, audio, text). Even if an adversary inspects the medium, they cannot detect that a hidden message exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LSB Steganography** | 1990s | Spatial domain | Replace least significant bits of image pixels; simple but detectable [[1]](https://ieeexplore.ieee.org/document/4655281) |
| **Provably Secure Stego (Hopper-Langford-von Ahn)** | 2002 | Rejection sampling | First formal security definitions; stego from any PRG [[1]](https://eprint.iacr.org/2002/137) |
| **Meteor (LLM Stego)** | 2023 | Language model sampling | Hide messages in LLM-generated text; provably undetectable [[1]](https://eprint.iacr.org/2023/1029) |

**State of the art:** Provably-secure stego (theory), Meteor (AI-era steganography in LLM text).

---

## Physical Unclonable Functions (PUF)

**Goal:** Hardware-based authentication. A PUF exploits manufacturing variations in a chip to produce unique, unpredictable challenge-response pairs. Acts as a physical "fingerprint" for devices. Cannot be cloned, even by the manufacturer.

| Type | Year | Basis | Note |
|------|------|-------|------|
| **Arbiter PUF** | 2002 | Race condition | Two signal paths compete; winner depends on manufacturing variations [[1]](https://ieeexplore.ieee.org/document/1003580) |
| **SRAM PUF** | 2007 | Power-up state | Each SRAM cell powers up to 0 or 1 deterministically per device [[1]](https://ieeexplore.ieee.org/document/4261993) |
| **Ring Oscillator PUF** | 2003 | Frequency differences | Compare oscillation frequencies of identically-designed rings [[1]](https://dl.acm.org/doi/10.1145/611892.611996) |

**State of the art:** SRAM PUF (commercial: NXP, Intrinsic ID), combined with fuzzy extractors for stable key derivation.

---

## White-Box Cryptography

**Goal:** Key hiding in hostile environments. Implement cryptographic algorithms so that the secret key cannot be extracted even by an adversary who has full access to the running software and execution environment. Used in DRM, mobile payments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chow et al. WB-AES** | 2002 | Lookup tables + mixing bijections | First white-box AES; series of table lookups encoding key [[1]](https://link.springer.com/chapter/10.1007/3-540-36492-7_17) |
| **Billet et al. (cryptanalysis)** | 2004 | Algebraic attack | Broke Chow WB-AES; showed key extraction is possible [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_16) |
| **WBC Challenge (CHES)** | 2017 | Competition | Ongoing competitions show no WBC scheme survives long-term attack [[1]](https://www.whiteboxcrypto.com/) |

**State of the art:** no provably secure WBC exists; practical deployments rely on obfuscation + tamper-detection layers. Active research area.

---

## Leakage-Resilient Cryptography

**Goal:** Side-channel resistance in theory. Schemes that remain secure even when an adversary obtains partial information about the secret key (via power analysis, timing, EM emanation, cold boot attacks).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dziembowski-Pietrzak (LR stream cipher)** | 2008 | PRG + alternating extraction | First leakage-resilient stream cipher [[1]](https://eprint.iacr.org/2008/135) |
| **Faust-Kiltz-Pietrzak-Rothblum** | 2010 | Any LR-PRG | Leakage-resilient signatures from any LR-secure PRG [[1]](https://eprint.iacr.org/2009/282) |
| **Prouff-Rivain (masking)** | 2013 | Boolean masking | Practical higher-order masking for AES; provable security [[1]](https://eprint.iacr.org/2013/468) |

**State of the art:** Prouff-Rivain masking (industry standard for smart cards), theoretical LR frameworks (complementary).

---

## Differential Privacy

**Goal:** Quantifiable privacy. Add calibrated noise to query results so that the presence or absence of any single individual's data cannot be distinguished. Mathematical guarantee, composable. Used in census data, Apple/Google telemetry.

| Mechanism | Year | Basis | Note |
|-----------|------|-------|------|
| **Laplace Mechanism** | 2006 | Calibrated Laplace noise | First DP mechanism; ε-differential privacy [[1]](https://link.springer.com/chapter/10.1007/11681878_14) |
| **Gaussian Mechanism** | 2006 | Gaussian noise | (ε,δ)-DP; better for high-dimensional data [[1]](https://link.springer.com/chapter/10.1007/11681878_14) |
| **Local DP (RAPPOR)** | 2014 | Randomized response | Each client randomizes locally; no trusted server needed; Google Chrome [[1]](https://arxiv.org/abs/1407.6981) |
| **Rényi / zCDP** | 2016 | Rényi divergence | Tighter composition; concentrated DP [[1]](https://arxiv.org/abs/1605.02065) |

**State of the art:** zCDP (tight composition), Local DP (Apple, Google deployment), DP-SGD (federated ML).

---

## Attribute-Based Signatures (ABS)

**Goal:** Policy-based authentication. Sign a message with a set of attributes; the signature verifies if the signer's attributes satisfy a policy — without revealing which attributes or the signer's identity. Dual of ABE for signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maji-Prabhakaran-Rosulek ABS** | 2011 | Pairings | First ABS with expressive policies (monotone span programs) [[1]](https://eprint.iacr.org/2010/595) |
| **Sakai-Attrapadung ABS** | 2016 | Pairings | Efficient constant-size signatures for AND policies [[1]](https://eprint.iacr.org/2016/246) |
| **Lattice ABS** | 2014 | SIS / LWE | Post-quantum attribute-based signatures [[1]](https://eprint.iacr.org/2014/279) |

**State of the art:** Pairing-based ABS (practical), Lattice ABS (PQ setting).

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

## Batch Arguments (BARG) / Accumulation Schemes

**Goal:** Efficient batch verification. Prove many statements simultaneously with a proof shorter than proving each individually. Used in blockchain rollups and recursive proof composition.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BARG (Choudhuri et al.)** | 2021 | LWE + RAM SNARKs | Batch NP statements with poly-size proof [[1]](https://eprint.iacr.org/2021/1423) |
| **Accumulation Schemes (Bünz et al.)** | 2020 | IPA / polynomial commitment | Accumulate proofs incrementally; used in Halo 2 [[1]](https://eprint.iacr.org/2020/499) |
| **ProtoStar** | 2023 | IVC + accumulation | Generic accumulation for PLONK-like systems [[1]](https://eprint.iacr.org/2023/620) |

**State of the art:** ProtoStar (modern folding/accumulation), BARG from LWE (theoretical breakthrough).

---

## Garbled Circuits (expanded)

*Note: already a row in MPC section, but deserves own section for the optimization techniques.*

**Goal:** Secure 2-party computation in constant rounds. One party "garbles" a Boolean circuit (encrypts gate-by-gate); the other evaluates it on their input without learning the circuit's intermediate values.

| Technique | Year | Basis | Note |
|-----------|------|-------|------|
| **Yao's Garbled Circuit** | 1986 | Symmetric encryption | Original construction; each gate = 4 ciphertexts [[1]](https://ieeexplore.ieee.org/document/4568207) |
| **Point-and-Permute** | 1990 | Pointer bit | Reduce evaluation to 1 decryption per gate [[1]](https://dl.acm.org/doi/10.1145/100216.100287) |
| **Free-XOR** | 2008 | Global offset Δ | XOR gates cost zero garbling/evaluation [[1]](https://eprint.iacr.org/2008/096) |
| **Half-Gates** | 2015 | Two half-garbled gates | AND gates cost 2 ciphertexts instead of 4 (optimal) [[1]](https://eprint.iacr.org/2014/756) |
| **Stacked Garbling** | 2020 | Conditional branching | Garble only the taken branch; sublinear for branching programs [[1]](https://eprint.iacr.org/2020/973) |

**State of the art:** Half-Gates + Free-XOR (standard), Stacked Garbling (branching programs).

---

## Circular / KDM Security

**Goal:** Security when encrypting the key itself. An encryption scheme is KDM-secure (Key-Dependent Message) if it remains secure even when the plaintext is a function of the secret key. Critical for FHE bootstrapping and disk encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Halevi-Hamburg-Ostrovsky** | 2008 | DDH | First KDM-CPA secure encryption from standard assumptions [[1]](https://eprint.iacr.org/2008/140) |
| **Applebaum-Cash-Peikert-Sahai** | 2009 | LWE | KDM-secure for affine functions of the key [[1]](https://eprint.iacr.org/2009/070) |
| **Barak-Haitner-Hofheinz-Ishai** | 2010 | Any CPA enc (bounded) | KDM security for bounded polynomial cycles [[1]](https://eprint.iacr.org/2010/198) |

**State of the art:** LWE-based KDM (used in FHE bootstrapping security proofs), DDH-based (practical).

---

## Accountable Multi-Signatures / Subgroup Signatures

**Goal:** Identify non-signers. In a multi-signature or threshold protocol, produce a compact proof that identifies *which* parties signed (or failed to sign). Important for BFT consensus where non-signing validators must be slashed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Drijvers-Neven (Compact Multi-Sig)** | 2018 | BLS + aggregation | Aggregate BLS sigs with signer bitmap; used in Ethereum [[1]](https://eprint.iacr.org/2018/483) |
| **Accountable Subgroup Multi-Sig (ASM)** | 2021 | Schnorr / BLS | Identify exactly which subset signed; penalty for absence [[1]](https://eprint.iacr.org/2021/1351) |
| **Pixel (forward-secure multi-sig)** | 2019 | Pairings | Forward-secure aggregatable sigs for blockchain consensus [[1]](https://eprint.iacr.org/2019/514) |

**State of the art:** BLS + bitmap (Ethereum consensus), ASM (PoS slashing).

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

## Commit-Reveal Schemes

**Goal:** Fairness and ordering. A two-phase protocol: first commit a hidden value (binding), then reveal it later (hiding until reveal). Prevents front-running, enables fair coin-toss, sealed-bid auctions, and MEV protection in blockchains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hash-Based Commit-Reveal** | 1991 | H(value ‖ nonce) | Simplest: commit = hash; reveal = value + nonce. Used in ENS, NFT mints [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Pedersen Commit-Reveal** | 1991 | DLP | Perfectly hiding, computationally binding; see [Commitment Schemes](#commitment-schemes) [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Submarine Sends** | 2018 | Smart contract + hash | MEV-resistant: commit tx hash on-chain, reveal later [[1]](https://eprint.iacr.org/2018/985) |
| **Commit-Chain (RANDAO)** | 2015 | Sequential commit-reveal | Validators commit randomness; sequential reveal; see [Randomness Beacons](#randomness-beacons--coin-tossing) |

**State of the art:** hash commit-reveal (ubiquitous), Submarine Sends (DeFi MEV protection).

---

## Interactive Oracle Proofs (IOP) / PCP

**Goal:** Foundation of modern proof systems. An IOP combines an interactive proof with oracle access to the prover's messages. The PCP Theorem shows any NP statement has a proof checkable by reading only O(1) bits. STARKs, Plonky2, and most modern ZK systems are built on IOPs.

| Concept | Year | Basis | Note |
|---------|------|-------|------|
| **PCP Theorem** | 1992 | Complexity theory | NP = PCP(O(log n), O(1)); any NP proof can be checked by reading ~3 bits [[1]](https://dl.acm.org/doi/10.1145/273865.273901) |
| **Interactive Oracle Proofs (BCS)** | 2016 | IOP framework | Generalization of IP + PCP; prover sends oracles, verifier queries. Foundation of STARKs [[1]](https://eprint.iacr.org/2016/116) |
| **Polynomial IOP** | 2019 | Polynomial commitments + IOP | Prover sends polynomial oracles; PLONK, Marlin, etc. are polynomial IOPs compiled with KZG/FRI [[1]](https://eprint.iacr.org/2019/953) |
| **Linear PCP** | 2012 | Linear algebra | Prover's oracle is a linear function; basis of Pinocchio and Groth16 [[1]](https://eprint.iacr.org/2012/215) |

**State of the art:** Polynomial IOPs (PLONK, Marlin) compiled with KZG or FRI; IOP + Fiat-Shamir = STARK.

---

## Folding Schemes

**Goal:** Efficient recursion. Instead of verifying a proof inside another proof (expensive), "fold" two instances into one of the same size. Enables incremental verifiable computation (IVC) with minimal per-step overhead. Hottest topic in ZK research (2022–).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Nova** | 2022 | R1CS + Pedersen | First folding scheme; fold two R1CS instances into one; see [ZK Proofs](#zero-knowledge-proofs-zk) [[1]](https://eprint.iacr.org/2021/370) |
| **SuperNova** | 2022 | Nova + multiple circuits | Non-uniform IVC: different circuits at each step [[1]](https://eprint.iacr.org/2022/1758) |
| **HyperNova** | 2023 | CCS + multilinear | Fold customizable constraint systems (generalizes R1CS, Plonkish) [[1]](https://eprint.iacr.org/2023/573) |
| **ProtoStar** | 2023 | Plonkish + accumulation | Non-uniform IVC for PLONK-like systems; see [BARG](#batch-arguments-barg--accumulation-schemes) [[1]](https://eprint.iacr.org/2023/620) |
| **Protostar/Protogalaxy** | 2023 | Lattice folding | Fold with logarithmic verifier [[1]](https://eprint.iacr.org/2023/1106) |

**State of the art:** HyperNova (most general), Nova (simplest), ProtoStar (PLONK-compatible). Active area with new schemes monthly.

---

## zkML (Zero-Knowledge Machine Learning)

**Goal:** Verifiable AI inference. Prove that an ML model was evaluated correctly on an input without revealing the model weights, the input, or both. Enables trustless AI-as-a-service, on-chain ML verification, and private inference.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **EZKL** | 2023 | Halo2 / KZG | Prove ONNX model inference in ZK; production-grade [[1]](https://github.com/zkonduit/ezkl) |
| **Modulus Labs (Remainder)** | 2023 | Custom arithmetic circuits | ZK inference for transformers; on-chain verification [[1]](https://eprint.iacr.org/2023/1584) |
| **Daniel Kang et al. (zkCNN)** | 2022 | GKR + sumcheck | Prove CNN inference; interactive → Fiat-Shamir [[1]](https://eprint.iacr.org/2021/673) |
| **Giza (ONNX→Cairo)** | 2023 | STARKs | Compile ONNX to Cairo (STARK-provable) [[1]](https://github.com/gizatechxyz/orion) |

**State of the art:** EZKL (practical), zkCNN (academic foundation), active race between SNARK/STARK approaches.

---

## Function Secret Sharing (FSS) / Distributed Point Functions (DPF)

**Goal:** Secret-share a function. Split a function f into shares f₀, f₁ such that each share reveals nothing, but f₀(x) + f₁(x) = f(x) for all x. Enables efficient PIR, anonymous messaging, private database queries with sublinear communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Distributed Point Function (GI14)** | 2014 | PRG tree | Secret-share a point function (1 at target, 0 elsewhere); O(λ log N) key size [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for intervals/comparison** | 2015 | DPF + prefix tree | Extend DPF to interval functions; private range queries [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for decision trees** | 2021 | DPF composition | Secret-share a decision tree for private inference [[1]](https://eprint.iacr.org/2020/1392) |

**State of the art:** DPF (used in Brave/STAR, Google Privacy Sandbox), FSS for intervals (private analytics).

---

## Homomorphic Secret Sharing (HSS)

**Goal:** Non-interactive secure computation. Secret-share data and compute on shares locally (without interaction between servers), then reconstruct the result. Like MPC but without communication rounds during computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HSS for branching programs (BGI)** | 2016 | DDH / DCR | Evaluate branching programs on shares with no interaction [[1]](https://eprint.iacr.org/2015/084) |
| **HSS from LWE** | 2019 | LWE | Post-quantum HSS; more expressive function classes [[1]](https://eprint.iacr.org/2019/1318) |
| **HSS for NC1** | 2016 | Group actions | Evaluate any NC1 circuit on secret-shared data [[1]](https://eprint.iacr.org/2015/084) |

**State of the art:** DDH-based HSS (practical for simple functions), LWE-based (PQ, richer function classes).

---

## Homomorphic Signatures

**Goal:** Compute on authenticated data. Given signatures on messages m₁,...,mₙ, anyone can derive a valid signature on f(m₁,...,mₙ) without the signing key. Enables verifiable delegation of computation on signed datasets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Linearly Homomorphic Sig (Boneh-Freeman)** | 2011 | Pairings | Sign vectors; derive sig on any linear combination [[1]](https://eprint.iacr.org/2009/025) |
| **Fully Homomorphic Sig (Gennaro-Wichs)** | 2013 | FHE + SNARK | Sign data; derive sig on ANY computable function [[1]](https://eprint.iacr.org/2012/023) |
| **Homomorphic Sig for Polynomials (Catalano-Fiore)** | 2013 | Pairings | Evaluate multivariate polynomials on signed data [[1]](https://eprint.iacr.org/2013/433) |

**State of the art:** Linear homomorphic sigs (practical, used in network coding), fully homomorphic sigs (theoretical).

---

## Sanitizable Signatures

**Goal:** Authorized modification. A signer designates a "sanitizer" who can modify specified parts of a signed message while keeping the signature valid. Non-designated parts remain immutable. Used in medical records, redactable documents.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ateniese et al.** | 2005 | Chameleon hash + sig | First sanitizable sig; sanitizer can change designated blocks [[1]](https://eprint.iacr.org/2004/245) |
| **Brzuska et al. (formal model)** | 2009 | Generic | Formal security definitions: immutability, accountability, transparency [[1]](https://link.springer.com/chapter/10.1007/978-3-642-00468-1_28) |
| **Sanitizable Sig with Accountability** | 2015 | Group sig + chameleon hash | Detect who sanitized; full accountability [[1]](https://eprint.iacr.org/2015/845) |

**State of the art:** Accountable sanitizable sigs (GDPR: right to modify medical records while preserving audit trail).

---

## Proxy Signatures

**Goal:** Delegated signing. Alice delegates her signing authority to Bob (proxy) who can sign messages on her behalf. The resulting signature is verifiable as a proxy signature, distinguishable from Alice's direct signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mambo-Usuda-Okamoto** | 1996 | DLP | First proxy signature scheme; delegation by warrant [[1]](https://link.springer.com/chapter/10.1007/BFb0028379) |
| **Boldyreva et al. (proxy re-sig)** | 2003 | Bilinear pairings | Proxy re-signatures: convert Alice's sig into Bob's; see also [PRE](#proxy-re-encryption-pre) [[1]](https://eprint.iacr.org/2003/096) |
| **Short Proxy Sig (Fuchsbauer-Pointcheval)** | 2008 | Pairings | Efficient, short proxy signatures with security proof [[1]](https://eprint.iacr.org/2008/460) |

**State of the art:** proxy re-signatures (certificate translation), delegation by warrant (enterprise workflows).

---

## DC-Nets (Dining Cryptographers Networks)

**Goal:** Information-theoretically anonymous broadcast. A group of participants can broadcast a message so that an adversary (even computationally unbounded) cannot determine who sent it — as long as at least one participant is honest. Stronger than mixnets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum DC-Net** | 1988 | Shared secrets + XOR | Original: participants XOR shared bits; anonymous 1-bit broadcast [[1]](https://www.cs.cornell.edu/people/egs/herbivore/dcnets.html) |
| **Herbivore** | 2003 | DC-net + groups | Practical DC-net for small groups; scalability improvements [[1]](https://www.cs.cornell.edu/people/egs/herbivore/) |
| **Verdict (Corrigan-Gibbs-Ford)** | 2013 | DC-net + ZKP | Accountable: detect disruptors via zero-knowledge proofs [[1]](https://dl.acm.org/doi/10.1145/2508859.2516683) |

**State of the art:** Verdict (accountability + anonymity), DC-nets remain strongest anonymity guarantee but hard to scale.

---

## Onion Routing

**Goal:** Low-latency anonymous communication. Messages are wrapped in layers of encryption ("onion"); each relay peels one layer, learning only the next hop. Provides sender anonymity in real-time (unlike high-latency mixnets).

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Original Onion Routing** | 1996 | RSA + DH | First onion routing proposal; layered encryption through relays [[1]](https://ieeexplore.ieee.org/document/501689) |
| **Tor** | 2004 | TLS + DH + AES | Deployed network; 6000+ relays; 2M+ daily users [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Sphinx Packet Format** | 2009 | DH + HMAC | Compact, provably secure onion packet format; used in Lightning Network [[1]](https://eprint.iacr.org/2009/482) |

**State of the art:** Tor (largest deployed anonymity network), Sphinx (Lightning, Nym transport layer).

---

## Hierarchical Deterministic Keys (BIP32 / HD Wallets)

**Goal:** Structured key derivation. From a single master seed, deterministically derive an entire tree of key pairs. Each branch can be delegated (extended public key) without exposing the master. Standard in every cryptocurrency wallet.

| Standard | Year | Basis | Note |
|----------|------|-------|------|
| **BIP32 (HD Wallets)** | 2012 | HMAC-SHA512 + secp256k1 | Master seed → child key tree; supports extended public keys for watch-only [[1]](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) |
| **BIP44 (Multi-Account)** | 2014 | BIP32 + derivation paths | Standard paths: m/purpose'/coin'/account'/change/index [[1]](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) |
| **SLIP-10** | 2016 | BIP32 for Ed25519/NIST | Extend HD derivation to non-secp256k1 curves [[1]](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) |

**State of the art:** BIP32/44 (every Bitcoin/Ethereum wallet), SLIP-10 (Solana, Cardano, multi-curve wallets).

---

## Token-Based Authentication (TOTP / FIDO2 / WebAuthn)

**Goal:** Practical user authentication. Protocols for proving identity using time-based codes, hardware tokens, or biometric-gated cryptographic keys — replacing or supplementing passwords.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **HOTP** | 2005 | HMAC-SHA1 + counter | Event-based OTP; RFC 4226 [[1]](https://www.rfc-editor.org/rfc/rfc4226) |
| **TOTP** | 2011 | HMAC-SHA1 + time | Time-based OTP; 30-second codes; Google Authenticator; RFC 6238 [[1]](https://www.rfc-editor.org/rfc/rfc6238) |
| **FIDO2 / WebAuthn** | 2019 | ECDSA / Ed25519 + challenge-response | Passwordless auth; hardware keys (YubiKey) or platform biometrics; W3C standard [[1]](https://www.w3.org/TR/webauthn-2/) |
| **Passkeys** | 2022 | FIDO2 + cloud sync | Cross-device FIDO2 credentials; Apple/Google/Microsoft [[1]](https://fidoalliance.org/passkeys/) |

**State of the art:** FIDO2/Passkeys (passwordless, phishing-resistant), TOTP (legacy 2FA).

---

## Puncturable Encryption

**Goal:** Forward-secure decryption. A recipient can "puncture" their secret key on specific ciphertexts they've already decrypted — the punctured key can decrypt everything *except* those messages. Provides forward secrecy without sender-side changes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Green-Miers Puncturable Enc** | 2015 | Puncturable PRF + IBE | Puncture decryption key at tags; based on HIBE [[1]](https://eprint.iacr.org/2014/984) |
| **Bloom Filter Encryption** | 2018 | BF + puncturable PRF | Efficiently puncture on a Bloom filter of processed messages [[1]](https://eprint.iacr.org/2018/199) |
| **0-RTT with Puncturable Enc** | 2017 | TLS + puncturable enc | Replay-resistant 0-RTT key exchange without server state [[1]](https://eprint.iacr.org/2017/004) |

**State of the art:** Bloom Filter Encryption (practical), 0-RTT puncturable (TLS optimization).

---

## Matchmaking Encryption

**Goal:** Dual-policy encryption. Message is decryptable only when BOTH the sender's attributes match the receiver's policy AND the receiver's attributes match the sender's policy. Neither party learns if decryption failed due to the other's policy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ateniese et al. ME** | 2019 | ABE + ZK | First matchmaking encryption; bilateral access control [[1]](https://eprint.iacr.org/2018/1094) |
| **Efficient ME (Chen et al.)** | 2021 | Pairings | Practical construction with shorter ciphertexts [[1]](https://eprint.iacr.org/2021/680) |

**State of the art:** pairing-based ME; applications in dating platforms, classified communication, bilateral credential matching.

---

## Registration-Based Encryption (RBE)

**Goal:** IBE without trusted authority. Like [IBE](#identity-based-encryption-ibe) but replaces the trusted PKG with a transparent public bulletin board. Users register their own public keys; anyone can encrypt to an identity; no single party holds a master secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garg-Hajiabadi-Mahmoody-Rahimi** | 2018 | Lattices / iO | First RBE construction; removes key escrow [[1]](https://eprint.iacr.org/2018/040) |
| **Efficient RBE (Glaeser et al.)** | 2022 | Pairings + accumulators | Practical: O(log N) ciphertext from accumulator-based approach [[1]](https://eprint.iacr.org/2022/1505) |

**State of the art:** pairing + accumulator RBE (practical); resolves IBE's key escrow problem.

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

## Forward-Secure Signatures & Encryption

**Goal:** Protect the past. If the current secret key is compromised, all messages/signatures from previous time periods remain secure. The key evolves forward; past keys are deleted.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Miner Forward-Secure Sig** | 1999 | Key evolution tree | First FS signature; binary tree of keys; update = move to next leaf [[1]](https://eprint.iacr.org/1999/009) |
| **Itkis-Reyzin FS-Sig** | 2001 | Factoring | Efficient FS signature based on Guillou-Quisquater [[1]](https://eprint.iacr.org/2001/006) |
| **Canetti-Halevi-Katz FS-PKE** | 2003 | HIBE → FS-PKE | Elegant reduction: binary tree HIBE = forward-secure encryption [[1]](https://eprint.iacr.org/2003/083) |
| **0-RTT TLS (forward secrecy)** | 2018 | Ephemeral DH + puncturable enc | TLS 1.3 0-RTT achieves FS via session ticket puncturing; see [Puncturable Encryption](#puncturable-encryption) [[1]](https://www.rfc-editor.org/rfc/rfc8446) |

**State of the art:** TLS 1.3 ephemeral DH (practical FS), Signal ratchet (continuous FS), puncturable encryption (0-RTT FS).

---

## Disk Encryption / Tweakable Block Ciphers

**Goal:** At-rest confidentiality. Encrypt each disk sector independently with a sector-number-dependent tweak, so sectors can be read/written randomly without decrypting the whole disk. Used in BitLocker, FileVault, LUKS, Android FBE.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **XTS-AES** | 2007 | Tweakable AES | IEEE 1619; sector-level encryption; tweak = sector number [[1]](https://ieeexplore.ieee.org/document/4493450) |
| **XEX (Rogaway)** | 2004 | Tweakable block cipher | Foundation: xor-encrypt-xor; XTS is a variant [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30539-2_2) |
| **Adiantum** | 2019 | ChaCha + NH + Poly1305 | Google; for devices without AES-NI (low-end Android) [[1]](https://eprint.iacr.org/2018/720) |
| **AES-HCTR2** | 2021 | AES + universal hash | Wide-block tweakable cipher; successor to Adiantum on AES-NI devices [[1]](https://eprint.iacr.org/2021/1441) |

**State of the art:** XTS-AES (BitLocker, FileVault, LUKS), Adiantum (low-end Android), AES-HCTR2 (modern Android).

---

## Key Wrapping / Envelope Encryption

**Goal:** Protect keys with keys. Encrypt a secret key (DEK) under a key-encryption key (KEK), providing confidentiality + integrity for key material. Standard pattern in HSMs, cloud KMS, and key hierarchies.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **AES-KW (Key Wrap)** | 2001 | AES + Feistel | NIST SP 800-38F; RFC 3394; 64-bit integrity check [[1]](https://www.rfc-editor.org/rfc/rfc3394) |
| **AES-KWP (Key Wrap with Padding)** | 2001 | AES-KW + padding | For non-aligned key sizes; RFC 5649 [[1]](https://www.rfc-editor.org/rfc/rfc5649) |
| **Envelope Encryption** | 2006 | KEM + DEK pattern | AWS KMS / GCP CMEK pattern: wrap DEK with KEK; store wrapped DEK alongside data [[1]](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#enveloping) |
| **SIV for Key Wrapping** | 2006 | AES-SIV | Misuse-resistant alternative; see [Deterministic Encryption](#deterministic-encryption--convergent-encryption) [[1]](https://www.rfc-editor.org/rfc/rfc5297) |

**State of the art:** AES-KW (NIST/HSMs), Envelope Encryption (all major cloud KMS).

---

## End-to-End Verifiable E-Voting

**Goal:** Voter-verifiable elections. Anyone can verify that votes were correctly counted, each voter can verify their vote was included, and ballot secrecy is maintained. Combines mixnets, HE, ZK, and blind signatures.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Helios** | 2008 | ElGamal HE + ZK | First practical web-based verifiable voting; used in IACR elections [[1]](https://www.usenix.org/legacy/events/sec08/tech/full_papers/adida/adida.pdf) |
| **Belenios** | 2015 | Helios + mixnet | Adds stronger ballot privacy via mixnet decryption; French academic elections [[1]](https://hal.inria.fr/hal-02066930/document) |
| **Civitas** | 2008 | Blind sig + credential | Coercion-resistant; voter gets real + fake credentials [[1]](https://ieeexplore.ieee.org/document/4531145) |
| **Swiss Post / Scytl** | 2019 | Mixnet + ZK shuffle | National-scale; verifiable shuffle of encrypted ballots [[1]](https://eprint.iacr.org/2019/838) |

**State of the art:** Belenios (academic/organization elections), mixnet-based (national scale). E-voting remains one of the hardest applied crypto problems.

---

## Message Franking / Abuse Reporting in E2E

**Goal:** Accountable encryption. In E2E encrypted messaging, allow a recipient to report an abusive message to the platform in a way that proves the message content and sender — without giving the platform a decryption backdoor.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Facebook Message Franking** | 2017 | HMAC commitment + AEAD | Sender commits to plaintext via HMAC; platform can verify if reported [[1]](https://eprint.iacr.org/2017/664) |
| **Asymmetric Message Franking (Grubbs et al.)** | 2017 | Compactly committing AEAD | Stronger: works even if sender is malicious [[1]](https://eprint.iacr.org/2017/664) |
| **Traceback for E2E (Hecate)** | 2022 | Threshold tracing + ZK | Trace source of viral content without breaking E2E [[1]](https://eprint.iacr.org/2021/1548) |

**State of the art:** Facebook/Meta message franking (deployed at scale), Hecate (academic, for viral content tracing).

---

## Data Availability Sampling (DAS)

**Goal:** Verify data exists without downloading it. Light clients randomly sample small chunks of erasure-coded data; if enough samples succeed, the full data is available with high probability. Core to blockchain scalability (Ethereum danksharding).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **KZG-based DAS** | 2020 | KZG + Reed-Solomon | Commit to data with KZG polynomial; sample random evaluations; see [Commitment Schemes](#commitment-schemes) [[1]](https://eprint.iacr.org/2019/1205) |
| **2D KZG DAS (Danksharding)** | 2022 | KZG over 2D grid | Ethereum's approach: rows + columns of KZG commitments [[1]](https://eprint.iacr.org/2022/1592) |
| **FRI-based DAS** | 2023 | FRI + RS codes | No trusted setup (unlike KZG); used in Celestia, Avail [[1]](https://eprint.iacr.org/2023/1172) |

**State of the art:** KZG-based (Ethereum EIP-4844), FRI-based (Celestia). Critical for modular blockchain scalability.

---

## Encrypted Mempools / Threshold Encryption for Transaction Ordering

**Goal:** MEV prevention. Transactions are encrypted before submission to the mempool; a threshold committee decrypts them only after ordering is finalized. Prevents front-running, sandwich attacks, and censorship.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold BLS Encryption for Mempools** | 2022 | TPKE + threshold BLS | Validators jointly decrypt after block ordering; Shutter Network, Penumbra [[1]](https://eprint.iacr.org/2022/898) |
| **Commit-Reveal Mempool** | 2019 | Hash commitment + reveal | Simpler: commit hash, reveal after inclusion; see [Commit-Reveal](#commit-reveal-schemes) |
| **Delay Encryption** | 2021 | VDF + encryption | Decrypt only after a time delay; combines VDF with encryption; see [VDF](#verifiable-delay-functions-vdf) [[1]](https://eprint.iacr.org/2021/1490) |

**State of the art:** Threshold encryption (Shutter, Penumbra), Delay encryption (theoretical), commit-reveal (simplest deployed).

---

## Sequential Aggregate Signatures

**Goal:** Chain-ordered aggregation. Each signer in sequence adds their signature to the aggregate — the final result is one compact signature validating all signers in order. Used in BGP route attestation, certificate chains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lysyanskaya-Micali-Reyzin-Shacham (LMRS)** | 2004 | RSA + certified trapdoor | First sequential aggregate sig; signer-by-signer aggregation [[1]](https://eprint.iacr.org/2003/197) |
| **Boneh-Gentry-Lynn-Shacham (BGLS)** | 2003 | BLS + pairings | Non-sequential aggregate: any order; see [Digital Signatures](#digital-signatures) for BLS [[1]](https://eprint.iacr.org/2002/175) |
| **History-Free Sequential Aggregate (HSA)** | 2012 | RSA-based | No need to see previous messages; only aggregate sig passed along [[1]](https://eprint.iacr.org/2012/486) |

**State of the art:** BGLS (general aggregation), LMRS (sequential/routing), HSA (bandwidth-optimized).

---

## Private Function Evaluation (PFE)

**Goal:** Hide the function. In standard MPC, the computed function is public. In PFE, even the function is private — one party's input is the circuit/program itself. Used when the algorithm is proprietary (trade secret evaluation, private credit scoring).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Universal Circuits (Valiant)** | 1976 | Circuit topology | Simulate any circuit of size n with O(n log n) universal circuit [[1]](https://dl.acm.org/doi/10.1145/800113.803649) |
| **PFE via Universal Circuit + GC** | 2008 | Garbled universal circuit | Embed function into UC, then garble; see [Garbled Circuits](#garbled-circuits-expanded) [[1]](https://eprint.iacr.org/2008/491) |
| **PFE from OT (Mohassel-Sadeghian)** | 2013 | OT + permutation network | More efficient: use extended OT to evaluate switching network [[1]](https://eprint.iacr.org/2013/239) |

**State of the art:** OT-based PFE (practical), Universal Circuits (theoretical foundation).

---

## Oblivious Sorting / Oblivious Data Structures

**Goal:** Sort or access data structures without revealing access patterns. Even the sorted order or query pattern is hidden. Critical building block for ORAM, private databases, and MPC on large datasets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bitonic Sort (Batcher)** | 1968 | Comparison network | O(n log² n) oblivious sort; data-independent comparison pattern [[1]](https://dl.acm.org/doi/10.1145/1468075.1468121) |
| **AKS Sorting Network** | 1983 | Expander graphs | O(n log n) optimal oblivious sort; impractical constants [[1]](https://dl.acm.org/doi/10.1145/800061.808726) |
| **Oblivious Bucket Sort (Asharov et al.)** | 2022 | Hashing + padding | Practical O(n log n) with small constants; MPC-friendly [[1]](https://eprint.iacr.org/2022/1243) |
| **Oblivious Priority Queue** | 2014 | Path ORAM + PQ | Oblivious insertions and extract-min; for graph algorithms on encrypted data [[1]](https://eprint.iacr.org/2014/344) |

**State of the art:** Oblivious Bucket Sort (practical MPC), Bitonic Sort (simplest, widely implemented).

---

## Covert Security / Publicly Auditable MPC

**Goal:** Intermediate MPC security. Stronger than semi-honest (passive), weaker than full malicious. In covert security, cheating is detected with probability ε — a rational adversary won't cheat if the reputational cost of detection outweighs the benefit. Much cheaper than malicious security.

| Model | Year | Basis | Note |
|-------|------|-------|------|
| **Covert Security (Aumann-Lindell)** | 2007 | Cut-and-choose | Detect cheating with prob ε; 1/ε overhead instead of κ for malicious [[1]](https://eprint.iacr.org/2007/060) |
| **Publicly Auditable MPC (Baum et al.)** | 2014 | Commitments + audit trail | Any external party can verify correctness of MPC execution post-hoc [[1]](https://eprint.iacr.org/2014/075) |
| **Publicly Verifiable Covert (PVC)** | 2018 | Covert + public audit | Combine covert deterrence with public verifiability [[1]](https://eprint.iacr.org/2018/1108) |

**State of the art:** Covert security (practical for honest-but-curious business settings), PVC (compliance-friendly MPC).

---

## SNARG (Succinct Non-Interactive Arguments without Zero-Knowledge)

**Goal:** Verifiable computation without privacy. Like a SNARK but the proof need not hide the witness — only succinctness and soundness matter. Useful when you want to verify computation but don't care about privacy (rollup state transitions, compliance proofs).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali CS Proofs** | 2000 | PCP + random oracle | First SNARG via PCP + Fiat-Shamir in ROM [[1]](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Proof%20Systems/Computationally_Sound_Proofs.pdf) |
| **Incrementally Verifiable Computation (Valiant)** | 2008 | Recursive SNARGs | Each step proves correctness of all prior steps; precursor to IVC/Nova [[1]](https://link.springer.com/chapter/10.1007/978-3-540-78524-8_18) |
| **Designated-Verifier SNARG (Kalai et al.)** | 2023 | LWE | SNARG from standard lattice assumptions; designated verifier [[1]](https://eprint.iacr.org/2023/1542) |

**State of the art:** zk-SNARKs subsume SNARGs in practice; designated-verifier SNARGs from LWE (theoretical breakthrough, 2023).

---

## Witness Encryption

**Goal:** Confidentiality tied to NP statements. Encrypt a message so that anyone possessing a valid witness for an NP statement can decrypt, without needing a secret key from a trusted authority. If the statement is false, the ciphertext hides the message.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH+SW Witness Encryption** | 2013 | Multilinear maps | First construction; encrypt under NP statement, decrypt with witness [[1]](https://eprint.iacr.org/2013/258) |
| **Witness Encryption from iO** | 2013 | iO + OWF | Indistinguishability obfuscation implies WE [[1]](https://eprint.iacr.org/2013/454) |
| **Extractable Witness Encryption** | 2013 | Knowledge assumptions | Stronger notion: adversary that distinguishes must "know" a witness [[1]](https://eprint.iacr.org/2013/258) |
| **Witness Encryption for Timelock (WE-TLP)** | 2021 | Sequential squaring | Practical WE variant tied to computational puzzles [[1]](https://eprint.iacr.org/2021/1423) |

**State of the art:** Theoretical foundation; practical constructions remain elusive without multilinear maps or iO. Timelock-based variants most practical today.

---

## Honey Encryption

**Goal:** Brute-force resistance. Decrypting with any wrong key produces a plausible-looking plaintext, so an attacker cannot tell when they found the correct key. Protects low-entropy secrets (passwords, PINs, credit card numbers).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Honey Encryption (HE)** | 2014 | DTE (distribution-transforming encoder) | Foundational; each wrong key yields valid-looking plaintext [[1]](https://eprint.iacr.org/2014/155) |
| **Natural Language HE** | 2015 | NLP + DTE | Honey encryption for natural language messages; GPT-based DTEs [[1]](https://eprint.iacr.org/2015/032) |
| **Honey Encryption for Genomic Data** | 2016 | Genomic DTE | Domain-specific for protecting genome sequences [[1]](https://doi.org/10.1145/2976749.2978370) |

**State of the art:** Juels-Ristenpart HE (2014) with domain-specific DTEs; adopted in password vault research. Key challenge: designing accurate DTEs for arbitrary domains.

---

## Designated Verifier Signatures / Proofs

**Goal:** Restricted verifiability. Only the designated verifier can check the signature's validity; they cannot convince any third party. Provides non-transferability of authentication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **JSI Designated Verifier Signature** | 1996 | DLP | First DVS; designated verifier can simulate valid-looking signatures [[1]](https://link.springer.com/chapter/10.1007/3-540-49677-7_30) |
| **Strong DVS (Saeednia-Kremer-Markowitch)** | 2003 | DLP | Strong: even the designated verifier cannot transfer conviction [[1]](https://link.springer.com/chapter/10.1007/978-3-540-39927-8_5) |
| **Universal DVS (Steinfeld-Bull-Wang-Pieprzyk)** | 2003 | Any signature scheme | Transform any signature into a designated-verifier variant [[1]](https://eprint.iacr.org/2003/192) |
| **Identity-Based DVS (Susilo-Zhang-Mu)** | 2004 | Pairings | DVS in identity-based setting; no PKI needed [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30108-0_16) |

**State of the art:** Strong DVS with efficient pairing-based constructions; used in privacy-preserving authentication where non-transferability is critical.

---

## Undeniable Signatures

**Goal:** Controlled verifiability. The signer must cooperate interactively for signature verification — prevents unsanctioned redistribution of signatures. Signer can also run a *disavowal* protocol to prove a forgery.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum-van Antwerpen** | 1989 | DLP | First undeniable signature; interactive verify + disavowal [[1]](https://link.springer.com/chapter/10.1007/0-387-34805-0_20) |
| **Chaum (improved)** | 1991 | DLP | Zero-knowledge confirmation and disavowal protocols [[1]](https://doi.org/10.1007/3-540-46766-1_28) |
| **Designated Confirmer Signatures** | 1994 | DLP | Third party can confirm; signer need not be online [[1]](https://doi.org/10.1007/BFb0053434) |
| **Convertible Undeniable Signatures (Boyar et al.)** | 1991 | DLP | Signer can release a token to make the signature universally verifiable [[1]](https://doi.org/10.1007/3-540-38424-3_17) |

**State of the art:** Largely superseded by designated-verifier signatures and chameleon signatures for most applications, but foundational to the concept of controlled verification.

---

## Certificateless Cryptography

**Goal:** No certificates, no key escrow. Eliminates the heavy PKI of traditional public-key crypto AND the key-escrow problem of IBE. A KGC (Key Generation Center) provides partial keys, but the user adds their own secret — KGC alone cannot decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Al-Riyami-Paterson CL-PKE** | 2003 | Pairings | First certificateless PKE; KGC partial key + user secret [[1]](https://eprint.iacr.org/2003/126) |
| **CL-PKS (Certificateless Signatures)** | 2005 | Pairings | Certificateless signature scheme [[1]](https://eprint.iacr.org/2005/220) |
| **Self-Certified Keys (Girault)** | 1991 | RSA | Precursor: public key implicitly certified by its structure [[1]](https://doi.org/10.1007/3-540-46416-6_42) |

**State of the art:** Pairing-based CL-PKE; fills the gap between IBE (see [IBE](#identity-based-encryption-ibe)) and traditional PKI. Popular in IoT research where certificate management is expensive.

---

## Privacy Pass / Anonymous Tokens

**Goal:** Unlinkable authorization. A client obtains a batch of tokens from a server (e.g., by solving a CAPTCHA once), then redeems them later without the server being able to link redemption to issuance. Rate-limiting without tracking.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Privacy Pass v1** | 2018 | VOPRF (EC) | Cloudflare's protocol; blind token issuance via VOPRF (see [OPRF](#oblivious-prf-oprf)) [[1]](https://doi.org/10.1515/popets-2018-0026) |
| **Privacy Pass v3 (IETF)** | 2023 | VOPRF / blind RSA | Standardized (RFC 9576–9578); public/private metadata, rate-limited tokens [[1]](https://www.rfc-editor.org/rfc/rfc9576) |
| **Apple Private Access Tokens** | 2022 | Blind RSA (RSA-BPOP) | Built on Privacy Pass; used in iOS/macOS for CAPTCHA-free auth [[1]](https://developer.apple.com/news/?id=huqjyh7k) |
| **Trust Token API (Chrome)** | 2020 | VOPRF | Google's Privacy Pass variant for anti-fraud without cookies [[1]](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/) |

**State of the art:** Privacy Pass v3 (IETF RFC 9576–9578) with VOPRF or blind RSA; deployed by Cloudflare, Apple, Chrome.

---

## Non-Interactive Key Exchange (NIKE)

**Goal:** Implicit key agreement. Two parties compute a shared secret from each other's public keys alone — no message exchange at all. Stronger than DH which requires ephemeral exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Static Diffie-Hellman** | 1976 | DLP | g^(ab) from static keys; simplest NIKE but no forward secrecy [[1]](https://ieeexplore.ieee.org/document/1055638) |
| **Freire-Hofheinz-Kiltz-Paterson NIKE** | 2013 | DDH + trapdoor | First NIKE with CKS-heavy security from standard assumptions [[1]](https://eprint.iacr.org/2012/732) |
| **CSIDH** | 2018 | Isogenies | Post-quantum NIKE from supersingular isogeny group actions [[1]](https://eprint.iacr.org/2018/383) |

**State of the art:** CSIDH for PQ-NIKE (but slow); static-DH widely used in practice (see [Key Exchange](#key-exchange--key-agreement)). True NIKE is rare — most protocols prefer ephemeral key exchange for forward secrecy.

---

## Cryptographic Reverse Firewalls

**Goal:** Subversion resistance. A middlebox ("reverse firewall") re-randomizes a party's protocol messages so that even if the party's implementation is subverted (backdoored), no information leaks — without the firewall knowing any secrets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mironov-Stephens-Davidowitz CRF** | 2015 | Rerandomization | Formal model; CRFs for key exchange, signatures, ZK proofs [[1]](https://eprint.iacr.org/2014/758) |
| **CRF for OT (Chakraborty et al.)** | 2020 | UC framework | Reverse firewalls for oblivious transfer protocols [[1]](https://eprint.iacr.org/2020/156) |
| **CRF for 2PC (Chen-Haeberlen-Hicks-Tzialla)** | 2022 | Garbled circuits | Subversion-resistant two-party computation [[1]](https://eprint.iacr.org/2022/849) |

**State of the art:** Theoretical framework (Mironov-Stephens-Davidowitz 2015); active research area post-Snowden. Practical deployment limited by performance overhead.

---

## Non-Malleable Codes

**Goal:** Tamper resilience. An encoding scheme where any tampering with the codeword either leaves the decoded message unchanged or produces a completely unrelated message — an adversary cannot cause "related" modifications.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dziembowski-Pietrzak-Wichs NMC** | 2010 | Split-state model | Foundational definition; adversary tampers with each state half independently [[1]](https://eprint.iacr.org/2009/608) |
| **Continuous NMC (Faust et al.)** | 2014 | Split-state | Resist continuous (repeated) tampering, not just one-shot [[1]](https://eprint.iacr.org/2014/050) |
| **NMC for Bounded Tampering (Chandran et al.)** | 2016 | Information-theoretic | For bounded number of tampering attempts [[1]](https://eprint.iacr.org/2015/1178) |
| **Rate-1 NMC (Aggarwal-Dodis-Lovett)** | 2014 | Split-state | Asymptotically optimal rate (message ≈ codeword size) [[1]](https://eprint.iacr.org/2013/565) |

**State of the art:** Split-state NMC (Dziembowski-Pietrzak-Wichs); used to protect against physical memory tampering (see [Leakage-Resilient Crypto](#leakage-resilient-cryptography)).

---

## Silent OT / Pseudorandom Correlation Generators (PCG)

**Goal:** Communication-efficient MPC setup. Generate enormous numbers of correlated random values (OT correlations, Beaver triples) from a short correlated seed — turning an O(n) communication task into O(n^ε) or O(polylog n).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Silent OT (BCGI+)** | 2019 | LPN | Generate millions of OT correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **PCG for Beaver Triples** | 2020 | Ring-LPN | Extend PCG to multiplication triples for general MPC [[1]](https://eprint.iacr.org/2020/924) |
| **Silver (Couteau et al.)** | 2021 | LDPC + LPN | Optimized Silent OT with quasi-linear computation [[1]](https://eprint.iacr.org/2021/1150) |
| **VOLE-in-the-head (Baum et al.)** | 2023 | VOLE + PCG | Use PCG-based VOLE for efficient ZK proofs [[1]](https://eprint.iacr.org/2023/996) |

**State of the art:** Silent OT / PCG (Boyle et al. 2019+); transformative for MPC (see [MPC](#multi-party-computation-mpc)) preprocessing — reduces communication by orders of magnitude.

---

## Delay Encryption

**Goal:** Time-based decryption without trusted setup. Like IBE where the "identity" is a future time slot; anyone can encrypt to time T, but decryption requires solving a VDF (sequential computation) until time T. No PKG or trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burdges-De Feo Delay Encryption** | 2021 | Isogeny + VDF | First formal construction; VDF-based time-release without trusted setup [[1]](https://eprint.iacr.org/2021/118) |
| **Practical Delay Enc (Chvojka et al.)** | 2023 | Pairings + TLP | More efficient; combines time-lock puzzles with IBE techniques [[1]](https://eprint.iacr.org/2023/1060) |

**State of the art:** Burdges-De Feo (2021); closely related to [VDFs](#verifiable-delay-functions-vdf) and [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption). Active research area for fair blockchain protocols.

---

## Vector Commitments

**Goal:** Position binding. Commit to an ordered sequence of values and later open any individual position with a short proof — without revealing other positions. Generalizes Merkle trees with constant-size proofs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Catalano-Fiore VC** | 2013 | RSA / CDH | First formal definition; constant-size openings from RSA assumption [[1]](https://eprint.iacr.org/2011/495) |
| **Lai-Malavolta VC** | 2019 | Groups of unknown order | Subvector openings; aggregatable proofs [[1]](https://eprint.iacr.org/2018/1188) |
| **Verkle Trees (Kuszmaul)** | 2019 | Polynomial commitments | Logarithmic branching with constant proofs; proposed for Ethereum state [[1]](https://math.mit.edu/research/highschool/primes/materials/2018/Kuszmaul.pdf) |
| **Pointproofs (Gorbunov et al.)** | 2020 | Pairings | Cross-commitment aggregation; efficient for blockchain [[1]](https://eprint.iacr.org/2020/419) |

**State of the art:** Verkle trees for Ethereum state migration; Pointproofs for blockchain validation. Closely related to [Commitment Schemes](#commitment-schemes) and [Accumulators](#accumulators).

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

## Lookup Arguments

**Goal:** Efficient ZK table lookups. Prove that a value belongs to a precomputed table without expressing the lookup as arithmetic constraints — dramatically reduces circuit size for operations like range checks, bitwise ops, and hash functions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Plookup** | 2020 | Polynomial IOP | First practical lookup argument; sorted-concatenation technique [[1]](https://eprint.iacr.org/2020/315) |
| **LogUp** | 2022 | Logarithmic derivatives | Reduces lookup to logarithmic derivative sum; better for large tables [[1]](https://eprint.iacr.org/2022/1530) |
| **Lasso** | 2023 | Sumcheck + sparse polynomials | Lookup from structured tables without committing to full table; sublinear prover [[1]](https://eprint.iacr.org/2023/1216) |
| **Baloo** | 2022 | KZG + lookup | Lookup argument with logarithmic proof size [[1]](https://eprint.iacr.org/2022/1565) |
| **cq (Cached Quotients)** | 2022 | KZG | Table-independent preprocessing; efficient for shared tables [[1]](https://eprint.iacr.org/2022/1763) |

**State of the art:** Lasso (2023) for structured tables; LogUp for general use. Lookups are now a core building block in zkVMs (see [ZK Proofs](#zero-knowledge-proofs-zk), [Folding Schemes](#folding-schemes)).

---

## Sumcheck Protocol

**Goal:** Verifiable summation. An interactive proof where the prover convinces the verifier of the value of a sum of a multivariate polynomial over the Boolean hypercube — in logarithmic rounds. Foundation of most modern interactive proof systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LFKN Sumcheck** | 1992 | Multivariate polynomials | Original sumcheck protocol; #P verifiable in IP [[1]](https://doi.org/10.1016/S0022-0000(05)80005-0) |
| **GKR Protocol** | 2008 | Layered circuits + sumcheck | Efficient interactive proof for layered arithmetic circuits [[1]](https://doi.org/10.1145/2699436) |
| **Spartan** | 2020 | Sumcheck + multilinear PCS | Transparent zkSNARK built entirely on sumcheck; no trusted setup [[1]](https://eprint.iacr.org/2019/550) |
| **Jolt** | 2024 | Sumcheck + Lasso | zkVM using sumcheck + lookup arguments; no custom circuits [[1]](https://eprint.iacr.org/2023/1217) |

**State of the art:** Sumcheck-based SNARKs (Spartan, Jolt, HyperNova) are increasingly dominant due to simplicity and transparency. Closely related to [IOP/PCP](#interactive-oracle-proofs-iop--pcp).

---

## Double Ratchet / Symmetric Ratchet

**Goal:** Continuous key renewal. Each message uses a fresh encryption key derived from a ratcheting chain, providing forward secrecy (past messages stay safe if key leaks) and post-compromise security (future messages heal after compromise). Core of modern secure messaging.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OTR (Off-the-Record) Ratchet** | 2004 | DH | First ratcheting protocol; per-message DH for forward secrecy [[1]](https://otr.cypherpunks.ca/otr-wpes.pdf) |
| **Axolotl / Double Ratchet** | 2016 | DH + KDF chain | Signal's protocol: DH ratchet (asymmetric) + symmetric KDF chain [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **Sesame (Signal)** | 2017 | Double Ratchet + X3DH | Session management for multiple devices [[1]](https://signal.org/docs/specifications/sesame/) |
| **Matrix / Megolm** | 2016 | Symmetric ratchet | Group messaging ratchet; sender ratchet only (efficient for groups) [[1]](https://gitlab.matrix.org/matrix-org/olm/-/blob/master/docs/megolm.md) |

**State of the art:** Signal Double Ratchet (WhatsApp, Signal, Google Messages); Megolm for large groups. See also [Secure Channels](#secure-channels--protocol-constructions).

---

## Continuous Group Key Agreement (CGKA) / MLS

**Goal:** Scalable group E2E encryption. Efficiently manage a shared group key as members join and leave — with forward secrecy and post-compromise security. Extension of the double ratchet to groups of thousands.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ART (Asynchronous Ratcheting Tree)** | 2018 | DH tree | First tree-based group ratchet; O(log n) update cost [[1]](https://eprint.iacr.org/2017/666) |
| **TreeKEM** | 2018 | KEM + binary tree | Core of MLS; each member holds a leaf; update = path of KEMs [[1]](https://inria.hal.science/hal-02425247) |
| **MLS (Messaging Layer Security)** | 2023 | TreeKEM + proposals | **IETF RFC 9420**; standard for group E2E messaging [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **CoCoA (Continuous Cooperative Key Agreement)** | 2022 | Server-aided CGKA | Relaxed model; server helps coordinate but learns nothing [[1]](https://eprint.iacr.org/2022/251) |

**State of the art:** MLS (RFC 9420); adopted by Cisco Webex, Wire, Matrix. Extends [Double Ratchet](#double-ratchet--symmetric-ratchet) to groups.

---

## Proofs of Retrievability (PoR) / Provable Data Possession

**Goal:** Remote storage verification. A client can efficiently verify that a cloud server actually stores their data — without downloading it. The server produces a compact proof from a random challenge.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PDP (Ateniese et al.)** | 2007 | RSA | Provable Data Possession; spot-check random blocks via homomorphic tags [[1]](https://eprint.iacr.org/2007/432) |
| **PoR (Juels-Kaliski)** | 2007 | Error codes + MAC | Proof of Retrievability; sentinel-based, bounded verifications [[1]](https://doi.org/10.1145/1315245.1315317) |
| **Compact PoR (Shacham-Waters)** | 2008 | BLS / Homomorphic tags | Publicly verifiable, compact proofs; unlimited verifications [[1]](https://eprint.iacr.org/2008/073) |
| **Filecoin PoRep** | 2017 | zk-SNARK + PoS | Proof of Replication: prove unique physical copy is stored [[1]](https://filecoin.io/proof-of-replication.pdf) |

**State of the art:** Compact PoR (Shacham-Waters) for traditional cloud; Filecoin PoRep for decentralized storage. Related to [PoW/PoSpace](#proof-of-work-pow--proof-of-space).

---

## Functional Commitments

**Goal:** Committed function evaluation. Commit to a function f, then later open f(x) for any input x with a short proof — without revealing f itself. Generalizes polynomial commitments and vector commitments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Libert-Ramanna-Yung FC** | 2016 | Pairings | First functional commitment for linear functions [[1]](https://eprint.iacr.org/2015/1017) |
| **Peikert-Pepin-Sharp FC** | 2021 | Lattices | Functional commitments from lattice assumptions [[1]](https://eprint.iacr.org/2021/1443) |
| **de Castro-Peikert FC** | 2023 | Lattices (SIS) | Succinct FC for polynomial-size circuits; from standard assumptions [[1]](https://eprint.iacr.org/2022/1368) |

**State of the art:** Lattice-based FC (de Castro-Peikert 2023); subsumes [Vector Commitments](#vector-commitments) and [Polynomial Commitments (KZG)](#commitment-schemes) as special cases.

---

## Laconic Cryptography

**Goal:** Minimal interaction. Two-message protocols where the first message is a short hash (digest) of a potentially huge input — the second message depends on this digest. Enables receiver-efficient OT, FE, and more from simple hash assumptions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Laconic OT (CDG+)** | 2017 | Hash + garbled circuits | Two-message OT where receiver sends short hash of selection bits [[1]](https://eprint.iacr.org/2017/799) |
| **Laconic FE (Quach-Wee-Wichs)** | 2018 | LWE | Functional encryption with succinct ciphertexts from laconic techniques [[1]](https://eprint.iacr.org/2018/325) |
| **Laconic PSI** | 2022 | Laconic OT | Private set intersection where one party sends only a short digest [[1]](https://eprint.iacr.org/2022/094) |
| **Registered FE (Laconic approach)** | 2023 | Laconic + pairings | Connect laconic techniques to registration-based crypto [[1]](https://eprint.iacr.org/2023/398) |

**State of the art:** Laconic OT from hash functions (CDG+ 2017); emerging paradigm connecting to [RBE](#registration-based-encryption-rbe), [PSI](#private-set-intersection-psi).

---

## Verifiable Information Dispersal (VID)

**Goal:** Reliable data distribution with verification. A dealer encodes data into N shares using erasure coding; each recipient can verify they received a valid share without reconstructing the full data. Foundation of blockchain data availability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cachin-Tessaro VID** | 2005 | Reed-Solomon + hash | Original VID; Byzantine-tolerant dispersal with verification [[1]](https://doi.org/10.1109/RELDIS.2005.5) |
| **AVID (Async VID, Hendricks et al.)** | 2007 | Erasure codes + Merkle | Asynchronous protocol; O(n|M|) total communication [[1]](https://doi.org/10.1145/1281100.1281131) |
| **DispersedLedger** | 2022 | VID + BFT consensus | VID integrated into BFT; separate data from consensus [[1]](https://eprint.iacr.org/2021/868) |
| **EigenDA VID** | 2024 | KZG + RS codes | KZG-committed VID for Ethereum rollup data availability [[1]](https://docs.eigenlayer.xyz/eigenda/overview) |

**State of the art:** KZG-based VID (EigenDA, Ethereum danksharding); closely related to [DAS](#data-availability-sampling-das) and [Commitment Schemes](#commitment-schemes).

---

## Sigma Protocols / Schnorr Identification

**Goal:** Foundation of efficient ZK proofs. A 3-move interactive protocol (commit → challenge → response) where the prover demonstrates knowledge of a secret without revealing it. The universal building block for discrete-log-based ZK and digital signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schnorr Identification** | 1989 | DLP | Prove knowledge of discrete log; basis of Schnorr signatures via Fiat-Shamir [[1]](https://doi.org/10.1007/0-387-34805-0_22) |
| **Guillou-Quisquater (GQ)** | 1988 | RSA | Sigma protocol for RSA-based identification [[1]](https://doi.org/10.1007/0-387-34799-2_16) |
| **Chaum-Pedersen** | 1992 | DLP | Prove equality of discrete logarithms (DLEQ); core of VOPRF, VRF [[1]](https://link.springer.com/chapter/10.1007/3-540-48071-4_7) |
| **AND/OR Composition (CDS)** | 1994 | Any sigma | Compose sigma protocols with AND/OR logic; prove compound statements [[1]](https://link.springer.com/chapter/10.1007/BFb0053443) |
| **Damgård's Techniques** | 2000 | Any sigma | Formal framework: special soundness + HVZK → Fiat-Shamir secure [[1]](https://www.cs.au.dk/~ivan/Sigma.pdf) |

**State of the art:** Sigma protocols + Fiat-Shamir transform = foundation of Schnorr signatures, DLEQ proofs, and most discrete-log ZK. See [ZK Proofs](#zero-knowledge-proofs-zk), [Digital Signatures](#digital-signatures).

---

## Structure-Preserving Signatures (SPS)

**Goal:** Composability with pairing-based proofs. Messages, public keys, and signatures are all group elements — enabling direct composition with Groth-Sahai proofs without hashing into the group. Foundation of provably secure anonymous credentials.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Abe-Haralambiev-Ohkubo (AHO)** | 2010 | Pairings (Type III) | First SPS; signatures on group element vectors [[1]](https://eprint.iacr.org/2010/133) |
| **Abe-Groth-Ohkubo (AGO)** | 2011 | Pairings | Optimal SPS: 7 group elements, tight reduction [[1]](https://eprint.iacr.org/2011/358) |
| **Equivalence-Class Signatures (EQS)** | 2014 | Pairings | Sign equivalence classes of vectors; basis of delegatable credentials [[1]](https://eprint.iacr.org/2014/944) |
| **Mercurial Signatures** | 2008 | Pairings | Sign on equivalence classes with additional randomizability [[1]](https://eprint.iacr.org/2008/163) |

**State of the art:** EQS (Hanser-Slamanig 2014) for anonymous credentials; SPS are the "right" primitive for composable pairing-based crypto. See [Anonymous Credentials](#anonymous-credentials).

---

## Groth-Sahai Proofs

**Goal:** Non-interactive ZK for pairing equations. Prove satisfiability of equations over group elements and scalars in bilinear groups — without random oracles. The standard NIZK framework for pairing-based cryptography.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth-Sahai (GS) Proofs** | 2008 | Pairings (DLIN/SXDH) | NIZK for pairing-product equations; witness-indistinguishable or ZK [[1]](https://eprint.iacr.org/2007/155) |
| **GS Proofs for Linear Equations** | 2008 | Pairings | Special case: linear equations have constant-size proofs [[1]](https://eprint.iacr.org/2007/155) |
| **Extractable GS** | 2012 | Knowledge assumptions | Proofs of knowledge variant; extractable witnesses [[1]](https://eprint.iacr.org/2012/028) |

**State of the art:** Groth-Sahai (2008); the canonical NIZK for pairing-based constructions. Enables [SPS](#structure-preserving-signatures-sps), group signatures, and anonymous credentials without random oracles.

---

## Semaphore / Anonymous Group Signaling (RLN)

**Goal:** Anonymous membership proof with rate limiting. Prove you belong to a group and broadcast a signal — without revealing which member you are. RLN (Rate-Limiting Nullifiers) adds: sending more than one signal per epoch reveals your secret key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Semaphore** | 2019 | zk-SNARK + Merkle | Anonymous group signaling via ZK membership proof in a Merkle tree [[1]](https://semaphore.pse.dev/V1) |
| **RLN v1 (Rate-Limiting Nullifiers)** | 2020 | Semaphore + Shamir | Rate-limited: >1 signal per epoch → secret key reconstructable [[1]](https://rate-limiting-nullifier.github.io/rln-docs/) |
| **RLN v2** | 2023 | Groth16 + slashing | Improved; variable rate limits per epoch [[1]](https://rate-limiting-nullifier.github.io/rln-docs/v2) |
| **Zupass / Semaphore v4** | 2024 | Groth16 / PLONK | Identity framework: ZK proofs of attributes, event tickets, voting [[1]](https://github.com/semaphore-protocol/semaphore) |

**State of the art:** Semaphore v4 + RLN v2; used in Ethereum (spam prevention), Waku messaging, Zupass identity. Related to [Ring Signatures](#ring--group-signatures), [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Garbled RAM

**Goal:** Efficient MPC for RAM programs. Extend garbled circuits to support random-access memory — instead of unrolling memory access into a massive circuit, emulate RAM with ORAM. Exponential improvement for memory-intensive computations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lu-Ostrovsky Garbled RAM** | 2013 | ORAM + GC | First garbled RAM; polylog overhead per memory access [[1]](https://eprint.iacr.org/2013/229) |
| **Garg-Lu-Ostrovsky-Scafuro** | 2015 | ORAM + succinct GC | Improved; sublinear garbled program size for RAM computations [[1]](https://eprint.iacr.org/2014/656) |
| **Heath-Kolesnikov RAM-MPC** | 2020 | Stacked garbling + RAM | Practical garbled RAM with stacked garbling optimizations [[1]](https://eprint.iacr.org/2020/973) |

**State of the art:** Heath-Kolesnikov (2020) for practical use; extends [Garbled Circuits](#garbled-circuits-expanded) and [ORAM](#oblivious-ram-oram) into a unified MPC framework.

---

## Anonymous IBE

**Goal:** Recipient privacy in IBE. The ciphertext hides not just the message but also the identity of the intended recipient. An eavesdropper cannot determine who can decrypt — even given the master public key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boyen-Waters Anonymous IBE** | 2006 | Pairings | First efficient anonymous IBE; ciphertext hides recipient identity [[1]](https://eprint.iacr.org/2005/029) |
| **Gentry Anonymous IBE** | 2006 | Pairings | Anonymous + CCA-secure; tight reduction [[1]](https://eprint.iacr.org/2006/077) |
| **Lattice Anonymous IBE (Agrawal et al.)** | 2010 | LWE | Post-quantum anonymous IBE from lattices [[1]](https://eprint.iacr.org/2010/383) |
| **Anonymous HIBE (Ducas-Lyubashevsky)** | 2018 | LWE | Hierarchical + anonymous + post-quantum [[1]](https://eprint.iacr.org/2018/088) |

**State of the art:** Lattice-based anonymous IBE (PQ-secure); extends [IBE](#identity-based-encryption-ibe) with recipient anonymity. Useful for anonymous broadcast and PIR-like scenarios.

---

## Password Hardened Encryption (PHE)

**Goal:** Two-factor encryption. Decryption requires both the user's password and a server-side key. A server breach alone is useless (no password); a password brute-force alone is useless (no server key). The server never sees plaintext.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lai-Tlejben-Abel-Polyakov PHE** | 2018 | OPRF + AE | PHE from oblivious PRF; server evaluates OPRF on password [[1]](https://eprint.iacr.org/2018/003) |
| **Pythia PRF** | 2015 | Partially-oblivious PRF | Server-side key-rotation without re-encrypting; verifiable [[1]](https://eprint.iacr.org/2015/644) |
| **OPAQUE (as PHE)** | 2018 | aPAKE | Can serve as PHE base: server stores password file, client derives key [[1]](https://eprint.iacr.org/2018/163) |

**State of the art:** PHE (Lai et al. 2018); deployed by Virgil Security. Related to [OPRF](#oblivious-prf-oprf) and [PAKE](#password-based-key-derivation-kdf--pake).

---

## Oblivious Message Retrieval (OMR)

**Goal:** Private message delivery. Messages are posted to a public bulletin board; a recipient can detect and download their messages without the server learning which messages belong to whom. Like PIR but optimized for the "mailbox" setting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Liu-Tromer OMR** | 2021 | FHE (BFV) | First OMR; server runs FHE detection on behalf of recipient [[1]](https://eprint.iacr.org/2021/1256) |
| **Cohn-Gordon et al. OMR** | 2023 | PIR + FHE | Improved; practical for millions of messages, ~5 sec server time [[1]](https://eprint.iacr.org/2022/1528) |
| **FrodoPIR-based OMR** | 2023 | Lattice PIR | Lightweight variant using offline preprocessing [[1]](https://eprint.iacr.org/2022/981) |

**State of the art:** FHE-based OMR (Liu-Tromer 2021+); enables private messaging without metadata leakage. Extends [PIR](#private-information-retrieval-pir) to the messaging domain.

---

## Incremental Cryptography

**Goal:** Efficient updates. When data is modified (insert, delete, edit), update the hash, MAC, or signature incrementally — without recomputing from scratch. Critical for large files, streaming data, and version-controlled content.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Incremental Hashing (BGG)** | 1994 | Universal hash | First formalization; update hash after data modification in O(change size) [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Incremental MAC (Bellare et al.)** | 1995 | XOR-based MAC | Update MAC without rehashing entire message [[1]](https://doi.org/10.1007/BFb0015744) |
| **Incremental Signatures (Bellare et al.)** | 1994 | Tree-based | Update signature when document changes; logarithmic cost [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Authenticated Data Structures (Tamassia)** | 2003 | Merkle + skip lists | Generalized framework: any data structure with authenticated incremental updates [[1]](https://doi.org/10.1007/3-540-39658-0_2) |

**State of the art:** Merkle-based authenticated data structures (widely deployed); incremental hashing in rsync, IPFS, git. See [Accumulators](#accumulators), [Hash Functions](#hash-functions).

---

## Rerandomizable Signatures (PS Signatures)

**Goal:** Unlinkable credential presentation. A signature can be publicly rerandomized into a fresh, valid signature on the same message — unlinkable to the original. Enables multi-show anonymous credentials without interaction with the issuer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CL Signatures (Camenisch-Lysyanskaya)** | 2004 | RSA / pairings | First practical rerandomizable sigs for anonymous credentials [[1]](https://eprint.iacr.org/2004/076) |
| **PS Signatures (Pointcheval-Sanders)** | 2016 | Pairings (Type III) | Short, efficient, rerandomizable; basis of modern anon credentials [[1]](https://eprint.iacr.org/2015/525) |
| **BBS+ Signatures** | 2004 | Pairings | Rerandomizable with selective disclosure; W3C Verifiable Credentials [[1]](https://eprint.iacr.org/2009/095) |
| **PS Multi-Message** | 2018 | Pairings | Sign multiple messages; selectively disclose subset [[1]](https://eprint.iacr.org/2017/1197) |

**State of the art:** BBS+ (W3C VC standard, ISO mDL); PS signatures for academic constructions. Foundation of [Anonymous Credentials](#anonymous-credentials) and [Structure-Preserving Signatures](#structure-preserving-signatures-sps).

---

## Key Transparency / CONIKS

**Goal:** Verifiable key directory. A public, append-only log that maps usernames to public keys — anyone can audit that the server hasn't secretly swapped someone's key. Prevents misbinding attacks where a server substitutes a malicious key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CONIKS** | 2015 | Merkle prefix tree | First key transparency system; users verify their own key bindings [[1]](https://eprint.iacr.org/2014/1004) |
| **Google Key Transparency** | 2017 | Sparse Merkle + VRF | Production system; verifiable log of key-to-account bindings [[1]](https://github.com/google/keytransparency) |
| **SEEMless (Meta)** | 2023 | Verifiable log | WhatsApp key transparency; Auditable Key Directory [[1]](https://engineering.fb.com/2023/04/13/security/whatsapp-key-transparency/) |
| **Signal Key Transparency** | 2024 | Merkle + monitoring | Detects key substitution in Signal's server [[1]](https://signal.org/blog/key-transparency/) |

**State of the art:** SEEMless (WhatsApp), Signal Key Transparency (2024). Closely related to [Certificate Transparency](#certificate-transparency-ct).

---

## Proactive Secret Sharing

**Goal:** Long-term threshold security. Periodically refresh secret shares without changing the secret — so an adversary who compromises different parties in different time periods never accumulates enough shares. Defends against "mobile adversaries."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Herzberg-Jarecki-Krawczyk-Yung (HJKY)** | 1995 | Shamir + rerandomization | First proactive SS; parties jointly rerandomize shares each epoch [[1]](https://doi.org/10.1007/3-540-44750-4_27) |
| **Proactive RSA (Frankel et al.)** | 1997 | RSA threshold | Proactive threshold RSA signatures; share refresh without new key [[1]](https://doi.org/10.1007/BFb0052253) |
| **CHURP** | 2019 | Bivariate polynomials | Proactive SS with dynamic committee changes; Byzantine-tolerant [[1]](https://eprint.iacr.org/2019/017) |
| **Proactive Refresh for BLS** | 2022 | BLS threshold | Refresh threshold BLS shares; used in Ethereum validator key management [[1]](https://eprint.iacr.org/2022/898) |

**State of the art:** CHURP (2019) for dynamic committees; proactive BLS for blockchain validators. Extends [Secret Sharing](#secret-sharing-schemes-sss) and [DKG](#distributed-key-generation-dkg).

---

## Visual Cryptography

**Goal:** Information-theoretic image sharing. Split an image into N shares printed on transparencies — overlaying any t shares reveals the image, fewer than t shares reveal nothing. No computation, no cryptographic assumptions — purely visual.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Shamir Visual SS** | 1994 | Pixel expansion | First (2,2) visual scheme; each pixel → 2×2 subpixels per share [[1]](https://doi.org/10.1007/BFb0053419) |
| **(k,n) Visual SS** | 1996 | Combinatorial | General threshold; Ateniese-Blundo-De Santis-Stinson [[1]](https://doi.org/10.1016/S0020-0190(96)00127-4) |
| **Extended Visual Crypto (EVC)** | 1996 | Meaningful shares | Each share looks like a valid image (not noise); shares reveal secret when overlaid [[1]](https://doi.org/10.1007/BFb0052995) |
| **Colored Visual Crypto** | 1997 | Color mixing | Extension to color images [[1]](https://doi.org/10.1007/BFb0028175) |

**State of the art:** (k,n) visual SS with meaningful shares; applications in physical document security. Pure information-theoretic security — see [OTP](#one-time-pad--information-theoretic-security).

---

## Non-Interactive DKG (NIDKG)

**Goal:** One-round distributed key generation. Generate a shared public key and individual secret key shares in a single broadcast round — no back-and-forth communication. Critical for blockchain protocols where interactive rounds are expensive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth NIDKG** | 2021 | Pairings + NIZK | Non-interactive; publicly verifiable; O(n) transcript size [[1]](https://eprint.iacr.org/2021/339) |
| **Gurkan et al. NIDKG** | 2021 | KZG + gossip | Aggregatable DKG; used in Celo blockchain [[1]](https://eprint.iacr.org/2021/005) |
| **Groth-Shoup NIDKG** | 2022 | Forward-secure enc | Used in Internet Computer (DFINITY); asynchronous, robust [[1]](https://eprint.iacr.org/2022/087) |

**State of the art:** Groth-Shoup NIDKG (DFINITY/Internet Computer); Gurkan et al. (Celo). Extends [DKG](#distributed-key-generation-dkg) to non-interactive setting.

---

## Asynchronous BFT / Asynchronous MPC

**Goal:** Consensus and computation without timing assumptions. Protocols that tolerate arbitrary message delays — no timeouts, no synchrony assumptions. Necessary for truly decentralized systems where network conditions are unpredictable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ben-Or-Canetti-Goldreich Async MPC** | 1993 | Information-theoretic | First async MPC; tolerates t < n/3 corruptions [[1]](https://doi.org/10.1145/167088.167109) |
| **HoneyBadgerBFT** | 2016 | Threshold encryption + ACS | First practical async BFT; uses threshold encryption for censorship resistance [[1]](https://eprint.iacr.org/2016/199) |
| **Dumbo** | 2020 | MVBA + ABA | Improved async BFT; better latency than HoneyBadger [[1]](https://eprint.iacr.org/2020/841) |
| **VABA (Validated Async BA)** | 2019 | Threshold sigs + MVBA | Async BA with external validity; basis of many async protocols [[1]](https://eprint.iacr.org/2019/1460) |
| **DAG-Rider** | 2021 | DAG + zero-message overhead | BFT from DAG structure; no extra consensus messages [[1]](https://eprint.iacr.org/2021/1362) |

**State of the art:** DAG-based BFT (DAG-Rider, Bullshark, Narwhal-Tusk); used in Aptos, Sui. Related to [MPC](#multi-party-computation-mpc), [Threshold Decryption](#threshold-decryption).

---

## Key-Insulated Cryptography

**Goal:** Temporal key isolation. Compromise of the current secret key does not reveal past or future keys — even without secure erasure. A physically secure "helper" device updates the user's key each time period, but the helper alone cannot sign or decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Katz-Xu-Yung Key-Insulated Sigs** | 2002 | DLP / RSA | First key-insulated scheme; helper updates user key per period [[1]](https://eprint.iacr.org/2002/064) |
| **Strong Key-Insulation** | 2003 | DLP | Even compromising helper + one period doesn't break other periods [[1]](https://doi.org/10.1007/3-540-39200-9_8) |
| **Intrusion-Resilient Sigs (Itkis-Reyzin)** | 2002 | DLP | Combines forward security + key-insulation [[1]](https://doi.org/10.1007/3-540-36178-2_33) |

**State of the art:** Key-insulated schemes fill the gap between [Forward-Secure Crypto](#forward-secure-signatures--encryption) (no helper needed) and [Proactive SS](#proactive-secret-sharing) (distributed). Used in smart card + host scenarios.

---

## Client Puzzles / Proof of Effort

**Goal:** DoS resistance. A server issues a computational puzzle to a client before committing resources — legitimate clients solve easily, but an attacker must spend proportional effort per request. Adjustable difficulty without centralized rate limiting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Juels-Brainard Client Puzzles** | 1999 | Hash inversion | First formal client puzzle; find partial hash preimage [[1]](https://doi.org/10.1007/978-1-4471-0641-2_11) |
| **Merkle Puzzles** | 1978 | Symmetric encryption | Original "puzzle" construction for key exchange; O(n²) vs O(n) gap [[1]](https://doi.org/10.1007/978-1-4684-3386-7_5) |
| **TLS Client Puzzles (RFC draft)** | 2019 | Hash | Extension to TLS handshake; server issues puzzle during ClientHello [[1]](https://datatracker.ietf.org/doc/draft-nir-tls-puzzles/) |
| **VDF-based Puzzles** | 2018 | Sequential squaring | Non-parallelizable puzzles; fair regardless of hardware [[1]](https://eprint.iacr.org/2018/601) |

**State of the art:** VDF-based puzzles for fairness; hash-based puzzles for simplicity. Precursor to [PoW](#proof-of-work-pow--proof-of-space). See also [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption).

---

## Identity-Based Signatures (IBS)

**Goal:** Sign with identity, verify with identity. The signer obtains a signing key from a PKG using their identity string; anyone can verify using the signer's identity and master public key — no certificate lookup needed. Complement to IBE.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir IBS (concept)** | 1984 | — | First proposal of identity-based signatures alongside IBE [[1]](https://doi.org/10.1007/3-540-39568-7_5) |
| **Cha-Cheon IBS** | 2003 | Pairings (BDH) | Efficient pairing-based IBS from Gap-DH [[1]](https://eprint.iacr.org/2002/083) |
| **Paterson-Schuldt IBS** | 2006 | Pairings | Provably secure in standard model (no random oracle) [[1]](https://eprint.iacr.org/2006/080) |
| **Lattice IBS (Rückert)** | 2010 | SIS/LWE | Post-quantum identity-based signatures [[1]](https://eprint.iacr.org/2009/222) |

**State of the art:** Pairing-based IBS (standard model); lattice IBS for PQ. Complement to [IBE](#identity-based-encryption-ibe); same PKG architecture.

---

## Oblivious Linear Evaluation (OLE) / VOLE

**Goal:** Arithmetic oblivious transfer. Sender holds (a, b), receiver holds x; receiver learns ax + b and nothing else, sender learns nothing. VOLE (Vector OLE) extends this to vectors. The arithmetic foundation of modern MPC over large fields.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gilboa OLE** | 1999 | OT extension | First efficient OLE from OT; basis of arithmetic MPC [[1]](https://doi.org/10.1007/3-540-48405-1_8) |
| **VOLE from LPN (Boyle et al.)** | 2019 | LPN + PCG | Generate massive VOLE correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **Wolverine** | 2021 | VOLE + ZK | ZK proofs from VOLE: efficient field arithmetic proofs [[1]](https://eprint.iacr.org/2020/925) |
| **QuickSilver** | 2021 | VOLE | Optimized VOLE-based ZK; practical for arithmetic circuits [[1]](https://eprint.iacr.org/2021/076) |

**State of the art:** PCG-based VOLE (Boyle et al. 2019+); foundation of SPDZ preprocessing (see [MPC](#multi-party-computation-mpc)) and VOLE-in-the-head ZK (see [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg)).

---

## Multi-Authority ABE

**Goal:** Decentralized access control. Multiple independent attribute authorities each manage a subset of attributes — no single authority can decrypt alone. Eliminates single point of trust in ABE systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase Multi-Authority ABE** | 2007 | Pairings | First multi-authority CP-ABE; central authority + attribute authorities [[1]](https://eprint.iacr.org/2007/010) |
| **Chase-Chow (no central authority)** | 2009 | Pairings | Removes central authority; fully decentralized [[1]](https://eprint.iacr.org/2009/094) |
| **Lewko-Waters Decentralized ABE** | 2011 | Pairings (dual system) | Any party can become an authority; no global setup [[1]](https://eprint.iacr.org/2011/414) |
| **MAABE for Large Universe (Rouselakis-Waters)** | 2015 | Pairings | Large attribute universe; efficient multi-authority [[1]](https://eprint.iacr.org/2015/016) |

**State of the art:** Lewko-Waters (2011) for fully decentralized; Rouselakis-Waters for large universes. Extends [ABE/FE](#attribute-based--functional-encryption) to remove single trust assumptions.

---

## Keyed-Verification Anonymous Credentials (KVAC)

**Goal:** Lightweight anonymous credentials. Issuer gives user a credential; user can prove possession anonymously — but only the issuer (who holds the verification key) can verify. No pairings needed; very efficient. Used in Signal's anonymous groups.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CMZ KVAC (Chase-Meiklejohn-Zaverucha)** | 2014 | Algebraic MAC + ZK | First KVAC; MAC-based anonymous credentials; efficient without pairings [[1]](https://eprint.iacr.org/2013/516) |
| **Signal Anonymous Credentials** | 2020 | CMZ + Ristretto | Signal's implementation for anonymous group membership [[1]](https://signal.org/blog/signal-private-group-system/) |
| **KVAC with Attributes** | 2019 | Algebraic MAC | Selective disclosure of attributes; blind issuance [[1]](https://eprint.iacr.org/2019/344) |

**State of the art:** CMZ-based KVAC (Signal Private Groups); lightweight alternative to [BBS+/PS Signatures](#rerandomizable-signatures-ps-signatures) when issuer-only verification suffices. See [Anonymous Credentials](#anonymous-credentials).

---

## MPC-in-the-Head (MPCitH)

**Goal:** ZK proofs from MPC. The prover mentally simulates an MPC protocol between virtual parties, commits to their views, and opens a random subset. The verifier checks consistency — if the "MPC" was honest, the statement must be true. Enables ZK from symmetric-key primitives.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IKOS (Ishai-Kushilevitz-Ostrovsky-Sahai)** | 2007 | Any MPC protocol | Foundational transformation: MPC protocol → ZK proof [[1]](https://doi.org/10.1145/1250790.1250794) |
| **ZKBoo** | 2016 | 3-party MPC | Practical MPCitH; 3 virtual parties, efficient for Boolean circuits [[1]](https://eprint.iacr.org/2016/163) |
| **ZKB++ / Picnic** | 2017 | ZKBoo + Fiat-Shamir | NIST PQ signature candidate; ZK from AES/LowMC circuits [[1]](https://eprint.iacr.org/2017/279) |
| **Limbo** | 2021 | N-party MPCitH | Generalized to N parties; tradeoff: more parties → shorter proofs [[1]](https://eprint.iacr.org/2021/215) |
| **Banquet** | 2021 | MPCitH + algebraic | Optimized for algebraic hash functions; shorter signatures [[1]](https://eprint.iacr.org/2021/068) |

**State of the art:** Picnic/Banquet for PQ signatures (see [Post-Quantum](#post-quantum-cryptography)); MPCitH is a general ZK paradigm alongside [IOPs](#interactive-oracle-proofs-iop--pcp) and [Sigma Protocols](#sigma-protocols--schnorr-identification).

---

## Packed Secret Sharing

**Goal:** Amortized secret sharing. Share k secrets simultaneously using a single polynomial of degree t + k − 1, instead of k separate Shamir sharings. Reduces communication in MPC by a factor of k — crucial for large-scale secure computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Franklin-Yung Packed SS** | 1992 | Polynomial | First packed SS; k secrets in one degree-(t+k−1) polynomial [[1]](https://doi.org/10.1007/3-540-48071-4_12) |
| **Packed SS for MPC (Damgård et al.)** | 2006 | Packed Shamir | Amortized MPC: evaluate k gates in one round via packed shares [[1]](https://eprint.iacr.org/2005/264) |
| **Turbopack** | 2022 | Packed SS + batch | Further optimize MPC with packed SS; near-optimal communication [[1]](https://eprint.iacr.org/2022/1316) |

**State of the art:** Turbopack (2022) for high-throughput MPC; packed SS is a core optimization in [MPC](#multi-party-computation-mpc) and [Secret Sharing](#secret-sharing-schemes-sss).

---

## Verifiable Timed Commitments

**Goal:** Forced opening after delay. A commitment that the committer can open instantly, but anyone can force-open after time T by performing sequential computation. Guarantees fairness in exchange protocols — no party can withhold forever.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Naor Timed Commitments** | 2000 | RSA + sequential squaring | First construction; forced opening via repeated squaring mod N [[1]](https://doi.org/10.1007/3-540-44598-6_15) |
| **Homomorphic Timed Commitments** | 2020 | Class groups | Compute on timed commitments before opening; enables timed auctions [[1]](https://eprint.iacr.org/2019/635) |
| **Efficient Timed Commitments (Thyagarajan et al.)** | 2021 | Pairings + TLP | Batch verification; more efficient than RSA-based [[1]](https://eprint.iacr.org/2021/1272) |

**State of the art:** Homomorphic timed commitments for auction/voting applications. Combines [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption) with [Commitment Schemes](#commitment-schemes).

---

## Constrained / Policy-Based Signatures

**Goal:** Delegated signing with restrictions. Derive a constrained signing key that can only sign messages satisfying a predicate (e.g., "emails from @company.com", "transactions under $1000"). The master key signs anything; constrained keys are limited.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Fuchsbauer Policy-Based Sigs** | 2014 | Generic | Formal model; signing key restricted to a message space defined by a policy [[1]](https://eprint.iacr.org/2014/100) |
| **Boneh-Kim Constrained Sigs** | 2017 | Pairings / lattices | Constrained keys for circuit predicates; related to constrained PRFs [[1]](https://eprint.iacr.org/2017/502) |
| **Functional Signatures (Boyle-Goldwasser-Ivan)** | 2014 | iO / pairings | Sign f(m) using a key for function f, without seeing m [[1]](https://eprint.iacr.org/2013/401) |

**State of the art:** Constrained signatures from lattices (Boneh-Kim 2017); related to [Constrained PRFs](#puncturable--constrained-prf). Enables fine-grained delegation without proxy re-signing.

---

## Aggregate Signatures (BLS Aggregate)

**Goal:** Non-interactive signature compression. Anyone can combine N signatures from N different signers on N different messages into a single short aggregate signature. Verification checks all N messages at once. Critical for blockchain consensus scalability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BGLS Aggregate Signatures** | 2003 | Pairings (BLS) | First aggregate sigs; combine n BLS sigs into one; verify in O(n) pairings [[1]](https://eprint.iacr.org/2002/029) |
| **BGLS Same-Message Aggregate** | 2003 | Pairings | n signers on same message → one sig; single pairing to verify [[1]](https://eprint.iacr.org/2002/029) |
| **Ethereum BLS Aggregation** | 2020 | BLS12-381 | Aggregate 100k+ validator attestations per epoch; EIP-2537 [[1]](https://eips.ethereum.org/EIPS/eip-2537) |
| **Compact Multi-Signatures (Boneh-Drijvers-Neven)** | 2018 | Pairings | Aggregate sigs with proof of possession; prevents rogue-key attacks [[1]](https://eprint.iacr.org/2018/483) |

**State of the art:** BLS aggregation on BLS12-381 (Ethereum consensus); differs from [Sequential Aggregate Signatures](#sequential-aggregate-signatures) in that aggregation is non-interactive and order-independent.

---

## Linkable Ring Signatures

**Goal:** Anonymous signing with double-spend detection. Sign anonymously within a ring, but if the same signer signs twice (on the same tag/epoch), the two signatures are publicly linkable — without revealing the signer. Foundation of privacy-preserving cryptocurrencies.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Liu-Wei-Wong LRS** | 2004 | DLP | First linkable ring signature; linking tag derived from signer's key [[1]](https://eprint.iacr.org/2004/027) |
| **CryptoNote Ring Signatures** | 2013 | EC + key images | One-time ring sigs with key images for double-spend detection; Monero [[1]](https://www.getmonero.org/resources/research-lab/pubs/whitepaper_annotated.pdf) |
| **RingCT (Ring Confidential Transactions)** | 2016 | Pedersen + Borromean | Combines linkable ring sigs + confidential amounts; Monero v2+ [[1]](https://eprint.iacr.org/2015/1098) |
| **Triptych** | 2021 | DLP + commitments | Logarithmic-size linkable ring sigs; Monero research [[1]](https://eprint.iacr.org/2020/018) |

**State of the art:** Triptych / Seraphis for next-gen Monero; RingCT currently deployed. Extends [Ring & Group Signatures](#ring--group-signatures) with linkability.

---

## Distributed PRF (DPRF)

**Goal:** Threshold PRF evaluation. t-of-n servers jointly evaluate a PRF on input x — no single server knows the PRF key, and fewer than t servers learn nothing about the output. Enables distributed key derivation and tokenization.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas-Reingold DPRF** | 1999 | DDH | First DPRF; threshold Naor-Reingold PRF [[1]](https://doi.org/10.1007/3-540-48910-X_16) |
| **Dodis-Yampolskiy DVRF/DPRF** | 2005 | Pairings | Verifiable DPRF; each server proves correct partial evaluation [[1]](https://eprint.iacr.org/2004/310) |
| **Threshold OPRF (TOPRF)** | 2020 | EC + threshold | Threshold + oblivious: client input hidden, key distributed [[1]](https://eprint.iacr.org/2017/363) |

**State of the art:** TOPRF for distributed password authentication (extends [OPRF](#oblivious-prf-oprf)); DPRF for distributed key management. Related to [PRF](#pseudorandom-functions-prf--pseudorandom-permutations-prp).

---

## Zero-Knowledge Sets

**Goal:** Private set with membership/non-membership proofs. A prover commits to a set S without revealing it, then proves for any element x whether x ∈ S or x ∉ S — without leaking S's size or other elements. Stronger than accumulators.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali-Rabin-Kilian ZK Sets** | 2003 | Merkle + trapdoor hash | First ZK sets; prove membership AND non-membership without revealing set [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |
| **Chase-Healy-Lysyanskaya-Malkin-Reyzin** | 2005 | q-SDH | Efficient ZK sets from bilinear assumptions [[1]](https://eprint.iacr.org/2005/292) |
| **ZK Elementary Database (ZK-EDB)** | 2003 | Trapdoor commitments | Key-value database with ZK proofs for queries and non-existence [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |

**State of the art:** ZK sets from Merkle trees + trapdoor hashing. Extends [Accumulators](#accumulators) with non-membership proofs and set hiding.

---

## Broadcast Authentication (TESLA)

**Goal:** Asymmetric authentication from symmetric primitives. Authenticate broadcast/multicast messages using only MACs — the time delay between sending and key disclosure creates an asymmetry that prevents forgery. No public-key crypto needed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **TESLA** | 2000 | Hash chain + MAC | Timed Efficient Stream Loss-tolerant Authentication; delayed key disclosure [[1]](https://doi.org/10.1109/JSAC.2002.806128) |
| **μTESLA** | 2002 | TESLA + sensor optimizations | Lightweight TESLA for sensor networks; base station bootstraps keys [[1]](https://doi.org/10.1145/586110.586132) |
| **TESLA++** | 2003 | TESLA + immediate auth | Hybrid: some packets immediately verifiable, rest via TESLA [[1]](https://doi.org/10.1145/948109.948113) |

**State of the art:** TESLA for multicast authentication; μTESLA for IoT/sensor networks. Alternative to [Digital Signatures](#digital-signatures) when computation is constrained.

---

## Compressed Sigma Protocols

**Goal:** Logarithmic proof compression. Compress n parallel Sigma protocol executions into a proof of size O(log n) — using an inner-product-like recursive argument. Generalizes the Bulletproofs inner-product technique to arbitrary Sigma protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bulletproofs IPA** | 2018 | Pedersen + DLP | Inner-product argument: compress n multiplications to O(log n) proof [[1]](https://eprint.iacr.org/2017/1066) |
| **Compressed Σ-Protocols (Attema-Cramer)** | 2020 | Any Sigma + pivot | General framework: compress any Sigma protocol for homomorphic relations [[1]](https://eprint.iacr.org/2020/152) |
| **Compressed Σ for Lattices** | 2021 | SIS/LWE | Extension to lattice-based Sigma protocols; post-quantum compressed proofs [[1]](https://eprint.iacr.org/2021/307) |

**State of the art:** Attema-Cramer (2020) as general framework; Bulletproofs IPA as most deployed instance. Extends [Sigma Protocols](#sigma-protocols--schnorr-identification) and [Bulletproofs](#zero-knowledge-proofs-zk).

---

## Proof of Solvency / Proof of Reserves

**Goal:** Financial auditability with privacy. A custodian (e.g., crypto exchange) proves that total assets ≥ total liabilities — without revealing individual account balances or the full asset breakdown. Builds trust without full transparency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maxwell Proof of Reserves** | 2014 | Merkle sum tree | Merkle tree of (hash, balance) pairs; users verify inclusion [[1]](https://web.archive.org/web/20170927023529/https://iwilcox.me.uk/2014/proving-bitcoin-reserves) |
| **Provisions** | 2015 | Pedersen + ZK range proofs | Privacy-preserving PoR; hides individual balances, proves solvency in ZK [[1]](https://eprint.iacr.org/2015/1008) |
| **Summa** | 2023 | KZG + Merkle | Modern PoR with polynomial commitments; efficient for millions of accounts [[1]](https://github.com/summa-dev/summa-solvency) |

**State of the art:** Summa / KZG-based (2023); post-FTX industry standard push. Combines [Commitment Schemes](#commitment-schemes), [ZK Proofs](#zero-knowledge-proofs-zk), and [Accumulators](#accumulators).

---

## Confidential Transactions (CT)

**Goal:** Hidden amounts on public ledgers. Transaction amounts are replaced by Pedersen commitments — the network verifies that inputs equal outputs (no inflation) without seeing any amounts. Combined with range proofs to ensure no negative values.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maxwell Confidential Transactions** | 2015 | Pedersen commitments | First CT proposal; homomorphic commitments for amount hiding on Bitcoin [[1]](https://elementsproject.org/features/confidential-transactions/investigation) |
| **RingCT (Monero)** | 2016 | Pedersen + Borromean range proofs | CT combined with linkable ring sigs; default in Monero since 2017 [[1]](https://eprint.iacr.org/2015/1098) |
| **Mimblewimble** | 2016 | Pedersen + cut-through | CT-native protocol; transactions are just kernels + commitments; no addresses [[1]](https://docs.grin.mw/wiki/introduction/mimblewimble/mimblewimble/) |
| **Bulletproofs CT (Monero)** | 2018 | Bulletproofs range proofs | Replaced Borromean proofs in Monero; 80% size reduction [[1]](https://eprint.iacr.org/2017/1066) |
| **Liquid CT (Blockstream)** | 2018 | Pedersen + surjection proofs | Bitcoin sidechain with CT + confidential assets (hide asset type too) [[1]](https://blockstream.com/liquid/) |

**State of the art:** Bulletproofs-based CT (Monero); Mimblewimble (Grin/Beam). Combines [Commitment Schemes](#commitment-schemes) and [Range Proofs](#range-proofs).

---

## Range Proofs

**Goal:** Committed value in range. Prove that a Pedersen-committed value v lies in [0, 2^n) without revealing v. Essential building block for confidential transactions, e-voting, anonymous credentials, and any system where committed values must be non-negative.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boudot Range Proof** | 2000 | Integer commitments | First efficient range proof; based on Fujisaki-Okamoto commitments [[1]](https://doi.org/10.1007/3-540-45539-6_31) |
| **Borromean Ring Range Proof** | 2015 | Ring signatures | Per-bit ring signature; used in original Monero CT [[1]](https://github.com/Blockstream/borromean_paper/blob/master/borromean_draft_0.01_34241bb.pdf) |
| **Bulletproofs Range Proof** | 2018 | Inner product argument | Logarithmic-size; no trusted setup; aggregatable [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs++** | 2022 | Reciprocal argument | ~15% smaller than Bulletproofs; optimized for range proofs [[1]](https://eprint.iacr.org/2022/510) |
| **ZK-range from SNARKs** | 2020 | PLONK / Groth16 | Embed range check as circuit constraint; efficient when batched [[1]](https://eprint.iacr.org/2019/953) |

**State of the art:** Bulletproofs++ (2022) for standalone range proofs; SNARK-embedded range checks for ZK circuits. See [ZK Proofs](#zero-knowledge-proofs-zk), [Confidential Transactions](#confidential-transactions-ct).

---

## Fair Exchange / Atomic Swaps

**Goal:** Simultaneous exchange without trust. Two parties swap digital assets atomically — either both receive the other's asset, or neither does. No trusted third party needed in the optimistic case. Foundation of cross-chain trading.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Asokan-Shoup-Waidner Optimistic Fair Exchange** | 2000 | Verifiable escrow | TTP intervenes only on dispute; efficient for honest case [[1]](https://doi.org/10.1007/3-540-45539-6_4) |
| **HTLC (Hash Time-Locked Contracts)** | 2013 | Hash preimage + timelock | Cross-chain atomic swaps; Alice reveals preimage to claim both sides [[1]](https://en.bitcoin.it/wiki/Hash_Time_Locked_Contracts) |
| **Adaptor Signature Atomic Swaps** | 2018 | Adaptor sigs | Scriptless swaps using adaptor signatures; better privacy than HTLC [[1]](https://eprint.iacr.org/2020/476) |
| **Submarine Swaps** | 2018 | HTLC (on-chain ↔ off-chain) | Swap between Lightning Network and on-chain Bitcoin [[1]](https://docs.lightning.engineering/the-lightning-network/multihop-payments/hash-time-lock-contract-htlc) |

**State of the art:** Adaptor signature swaps for privacy (see [Adaptor Signatures](#adaptor-signatures--scriptless-scripts)); HTLC for simplicity. Atomic swaps enable trustless DEXs.

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

## Partially Blind Signatures

**Goal:** Controlled anonymity with public metadata. The signer blindly signs a message m without seeing it, but both parties agree on a public info field c embedded in the signature. Enables e-cash with visible denominations but hidden serial numbers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Abe-Fujisaki PBS** | 1996 | DLP | First partially blind signature; public info c agreed before signing [[1]](https://doi.org/10.1007/BFb0054858) |
| **Abe-Okamoto PBS** | 2000 | DLP | Provably secure partially blind Schnorr-type scheme [[1]](https://doi.org/10.1007/3-540-44598-6_17) |
| **Pairing-Based PBS** | 2005 | Pairings | Short partially blind signatures from bilinear maps [[1]](https://eprint.iacr.org/2005/123) |
| **Lattice PBS (Rückert)** | 2010 | SIS | Post-quantum partially blind signatures from lattices [[1]](https://eprint.iacr.org/2009/220) |

**State of the art:** Pairing-based PBS for efficiency; lattice PBS for PQ. Extends [Blind Signatures](#blind-signatures) with issuer-visible metadata. Used in e-cash systems and [Privacy Pass](#privacy-pass--anonymous-tokens).

---

## Sealed-Bid Auction Protocols

**Goal:** Private bidding. Bidders submit encrypted bids; the protocol determines the winner (and optionally the clearing price) without revealing losing bids. Prevents bid sniping, collusion, and underbidding.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brandt Sealed-Bid Auction** | 2002 | Homomorphic enc + ZK | First practical sealed-bid auction; Vickrey (second-price) via MPC [[1]](https://doi.org/10.1007/3-540-36563-X_5) |
| **Lipmaa-Asokan-Niemi** | 2002 | Paillier + range proofs | Efficient first-price sealed-bid auction; additive homomorphic [[1]](https://doi.org/10.1007/3-540-36563-X_4) |
| **Bogetoft et al. (Danish Sugar Beet Auction)** | 2009 | MPC (Shamir SS) | First real-world MPC auction; 1200+ farmers, Danish sugar beet contracts [[1]](https://doi.org/10.1007/978-3-642-03549-4_19) |
| **MEV Auction / Fair Ordering** | 2023 | Threshold encryption | Transaction ordering auctions to prevent MEV extraction; see [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering) [[1]](https://eprint.iacr.org/2023/1063) |

**State of the art:** MPC-based auctions for high-value settings; threshold encryption auctions for blockchain MEV. Combines [MPC](#multi-party-computation-mpc), [HE](#homomorphic-encryption-he), and [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Oblivious Key-Value Store (OKVS)

**Goal:** Efficient private encoding of key-value maps. Encode a set of (key, value) pairs into a compact structure where querying a key returns the value, but querying any other key returns random noise. Core data structure behind state-of-the-art PSI and circuit-PSI protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garbled Bloom Filter (GBF)** | 2014 | XOR-based | Encode key-value pairs in Bloom filter structure; see [Accumulators](#accumulators) [[1]](https://doi.org/10.1145/2660267.2660323) |
| **PaXoS (Probe-and-XOR of Strings)** | 2020 | Linear system | Solve linear system over GF(2); compact encoding, fast decode [[1]](https://eprint.iacr.org/2020/193) |
| **OKVS (Garimella et al.)** | 2021 | Banded matrix | Near-optimal rate (encoding ≈ n items); backbone of fast PSI [[1]](https://eprint.iacr.org/2021/883) |
| **RB-OKVS (Random Band)** | 2022 | Banded linear algebra | Improved; O(n) encode/decode; used in fastest PSI implementations [[1]](https://eprint.iacr.org/2022/320) |

**State of the art:** RB-OKVS (2022); enables PSI on millions of items in seconds. Key building block for [PSI](#private-set-intersection-psi) and [Silent OT](#silent-ot--pseudorandom-correlation-generators-pcg).

---

## Non-Committing Encryption

**Goal:** Simulation security for encryption. After generating a ciphertext, the simulator can "explain" it as an encryption of any message — by revealing fake randomness. Required for UC-secure (universally composable) protocols, where standard CPA/CCA encryption is insufficient.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Feige-Goldreich-Naor NCE** | 1996 | OT | First NCE; based on oblivious transfer [[1]](https://doi.org/10.1145/237814.237866) |
| **Nielsen NCE** | 2002 | Trapdoor permutations | Efficient NCE from any trapdoor permutation [[1]](https://doi.org/10.1007/3-540-45539-6_14) |
| **Adaptively Secure NCE (Choi et al.)** | 2009 | DDH | Non-committing encryption secure against adaptive corruption [[1]](https://eprint.iacr.org/2009/035) |
| **Non-Committing Authenticated Enc** | 2017 | AEAD + NCE | Combine authenticity with non-committing property for UC channels [[1]](https://eprint.iacr.org/2017/332) |

**State of the art:** DDH-based NCE (Choi et al.); essential for UC-secure [Secure Channels](#secure-channels--protocol-constructions) and [MPC](#multi-party-computation-mpc) in the adaptive corruption model.

---

## Conditional Disclosure of Secrets (CDS)

**Goal:** Predicate-gated secret release. Two parties each hold an input (x, y) and a referee holds a secret s. The secret s is revealed if and only if f(x, y) = 1 — with minimal communication. A fundamental building block for more complex protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gertner-Ishai-Kushilevitz-Malkin CDS** | 2000 | Secret sharing | First CDS formalization; connections to secret sharing and OT [[1]](https://doi.org/10.1007/3-540-44598-6_3) |
| **CDS for General Predicates** | 2014 | Branching programs | CDS for any predicate computable by branching programs [[1]](https://eprint.iacr.org/2014/213) |
| **Attribute-Based CDS** | 2017 | LWE / pairings | CDS with policies on attributes; connects to ABE [[1]](https://eprint.iacr.org/2017/614) |
| **CDS with Reusable Setup** | 2020 | DDH | Amortized: one setup, many CDS instances [[1]](https://eprint.iacr.org/2020/431) |

**State of the art:** CDS from standard assumptions (DDH/LWE); building block for [PSI](#private-set-intersection-psi), [OT extension](#oblivious-transfer-ot), and [Garbled Circuits](#garbled-circuits-expanded).

---

## Witness PRF

**Goal:** NP-gated pseudorandom evaluation. A PRF where anyone holding a witness w for an NP statement x can compute PRF(x) — without a secret key. Combines properties of PRFs, witness encryption, and constrained PRFs into one powerful primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zhandry Witness PRF** | 2016 | Multilinear maps | First construction; evaluate PRF using NP witness instead of secret key [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF from iO** | 2016 | Indistinguishability obfuscation | Alternative construction from iO; more general [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF Applications** | 2016 | — | Implies multi-party key exchange, secret sharing for NP, more [[1]](https://eprint.iacr.org/2016/597) |

**State of the art:** Theoretical; constructions require [iO](#indistinguishability-obfuscation-io) or [Multilinear Maps](#multilinear-maps). Implies [Witness Encryption](#witness-encryption), [Constrained PRFs](#puncturable--constrained-prf), and more.

---

## Traceable Signatures

**Goal:** Accountability in group signatures. A group member can sign anonymously, but if they exceed a signing quota (e.g., sign more than k times in an epoch), the group manager can trace and identify them. Stronger than linkability — full identity recovery.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Traceable Sigs** | 2004 | DLP + pairings | First traceable sigs; manager traces over-signers; CCA-anonymous [[1]](https://eprint.iacr.org/2004/007) |
| **Traceable Sigs with Stepping Capabilities** | 2008 | Pairings | Incremental tracing: trace after threshold violations [[1]](https://doi.org/10.1007/978-3-540-78967-3_7) |
| **Lattice Traceable Sigs** | 2019 | LWE / SIS | Post-quantum traceable group signatures [[1]](https://eprint.iacr.org/2019/1158) |

**State of the art:** Lattice-based traceable sigs for PQ; extends [Ring & Group Signatures](#ring--group-signatures) and [Linkable Ring Signatures](#linkable-ring-signatures) with full traceability.

---

## Post-Quantum Cryptography

Schemes designed to resist attacks from quantum computers (Shor's algorithm breaks RSA, DH, ECC; Grover halves symmetric key security).

### PQ Key Encapsulation (KEM) / Encryption

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ML-KEM (Kyber)** | 2024 | Module lattices (MLWE) | **NIST standard (FIPS 203)**; used in Chrome, Signal [[1]](https://csrc.nist.gov/pubs/fips/203/final) |
| **FrodoKEM** | 2016 | Standard lattices (LWE) | More conservative; no ring structure [[1]](https://frodokem.org/files/FrodoKEM-specification-20210604.pdf) |
| **Classic McEliece** | 2017 | Code-based (Goppa) | Very large keys (~1 MB), very small ciphertexts; NIST round 4 [[1]](https://classic.mceliece.org/) |
| **BIKE** | 2017 | Code-based (QC-MDPC) | Moderate key sizes; NIST round 4 [[1]](https://bikesuite.org/) |
| **HQC** | 2017 | Code-based (Hamming QC) | NIST round 4 alternate [[1]](https://pqc-hqc.org/) |
| **NTRU** | 1996 | Lattice (NTRU) | One of the oldest PQ schemes (1996); patents expired [[1]](https://eprint.iacr.org/1996/002) |

### PQ Digital Signatures

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ML-DSA (Dilithium)** | 2024 | Module lattices (MLWE) | **NIST standard (FIPS 204)**; general-purpose PQ sig [[1]](https://csrc.nist.gov/pubs/fips/204/final) |
| **SLH-DSA (SPHINCS+)** | 2024 | Hash-based (stateless) | **NIST standard (FIPS 205)**; conservative, no lattice assumption [[1]](https://csrc.nist.gov/pubs/fips/205/final) |
| **FN-DSA (Falcon)** | 2024 | NTRU lattices | NIST standard (FIPS 206); compact signatures, complex signing [[1]](https://csrc.nist.gov/pubs/fips/206/final) |
| **XMSS** | 2011 | Hash-based (stateful) | RFC 8391; stateful — must track index [[1]](https://www.rfc-editor.org/rfc/rfc8391) |
| **LMS / HSS** | 2019 | Hash-based (stateful) | RFC 8554; NIST SP 800-208; simple stateful scheme [[1]](https://www.rfc-editor.org/rfc/rfc8554) |
| **SQIsign** | 2020 | Supersingular isogenies | Shortest PQ signatures (~200 B); very new [[1]](https://eprint.iacr.org/2020/1240) |

### PQ Zero-Knowledge

| Approach | Year | Note |
|----------|------|------|
| **STARKs** | 2018 | Hash-based; inherently post-quantum [[1]](https://eprint.iacr.org/2018/046) |
| **Lattice-based ZK** | 2011 | Emerging; based on SIS/LWE [[1]](https://eprint.iacr.org/2011/537) |

### PQ Key Exchange / Hybrid

| Protocol | Year | Note |
|----------|------|------|
| **X25519Kyber768** | 2024 | Hybrid: classical X25519 + ML-KEM-768; deployed in Chrome, Signal, Cloudflare [[1]](https://eprint.iacr.org/2016/1017) |
| **PQ Noise** | 2016 | Noise Framework patterns with PQ KEMs [[1]](https://noiseprotocol.org/noise.html) |

**State of the art:** ML-KEM (FIPS 203) for encryption, ML-DSA (FIPS 204) for signatures, SLH-DSA for conservative hash-based sigs, hybrid X25519+ML-KEM for transition period.

---

## Contributing

Contributions welcome! Please open an issue or PR to add missing schemes, correct references, or improve descriptions.

---

## License

[![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

This list is dedicated to the public domain under CC0 1.0.
