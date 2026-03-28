# Homomorphic & Functional Encryption

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
| **TFHE-rs** | 2022 | TFHE (Rust) | Production FHE library | Programmable bootstrapping; used in Zama's fhEVM for encrypted smart contracts [[1]](https://github.com/zama-ai/tfhe-rs) |

**State of the art:** TFHE (fast bootstrapping), CKKS (ML on encrypted data), OpenFHE (reference library), TFHE-rs (production Rust impl.).

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

## Verifiable FHE

**Goal:** Trustworthy outsourced computation on encrypted data. The server performs FHE computation and provides a proof that the computation was done correctly — the client verifies the proof without re-executing. Without this, FHE outsourcing requires trusting the server's correctness.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fiore-Gennaro Verifiable Computation on Enc Data** | 2012 | FHE + homomorphic MAC | Verify FHE computation via homomorphic MAC on plaintexts [[1]](https://eprint.iacr.org/2012/202) |
| **Ganesh-Nitulescu-Soria-Vazquez** | 2021 | SNARK + FHE | Prove correct FHE evaluation with a SNARK; general circuits [[1]](https://eprint.iacr.org/2021/1530) |
| **Rinocchio** | 2021 | SNARK over rings | Adapt Pinocchio/Groth16 to work over polynomial rings (FHE-native) [[1]](https://eprint.iacr.org/2021/322) |

**State of the art:** SNARK-based verifiable FHE (Ganesh et al. 2021); combines [ZK Proofs](#zero-knowledge-proofs-zk) and [HE](#homomorphic-encryption-he). Active research area for trustworthy cloud computation.

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

## Identity-Based Encryption (IBE)

**Goal:** Confidentiality without PKI. Encrypt to an arbitrary identity string (email address, phone number, domain) — the recipient obtains a private key from a trusted authority and decrypts.

**Architecture:** A trusted **Private Key Generator (PKG)** holds a master secret key (msk) and publishes a master public key (mpk). Anyone can encrypt to an identity string using mpk. The recipient contacts the PKG, authenticates, and receives their identity-specific secret key via `Extract(msk, id) → sk_id`. **Key escrow problem:** the PKG can decrypt all messages — motivating [Registration-Based Encryption](#registration-based-encryption-rbe) which removes this trust assumption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Franklin IBE** | 2001 | Bilinear pairings | First practical IBE; Weil pairing on elliptic curves [[1]](https://eprint.iacr.org/2001/090) |
| **Waters IBE** | 2005 | Pairings | Selective-ID secure without random oracles [[1]](https://eprint.iacr.org/2004/180) |
| **HIBE (Gentry-Silverberg)** | 2002 | Pairings | Hierarchical IBE; delegatable to sub-authorities [[1]](https://eprint.iacr.org/2002/107) |
| **Lattice IBE (Gentry-Peikert-Vaikuntanathan)** | 2008 | LWE | Post-quantum IBE [[1]](https://eprint.iacr.org/2007/432) |
| **Revocable IBE (Boldyreva-Goyal-Kumar)** | 2008 | Pairings + binary tree | Efficient revocation: PKG publishes periodic updates; revoked users can't decrypt new ciphertexts [[1]](https://eprint.iacr.org/2008/013) |

**State of the art:** Boneh-Franklin (widely taught), lattice IBE (PQ setting), revocable IBE for deployments requiring key revocation.

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

## Registration-Based Encryption (RBE)

**Goal:** IBE without trusted authority. Like [IBE](#identity-based-encryption-ibe) but replaces the trusted PKG with a transparent public bulletin board. Users register their own public keys; anyone can encrypt to an identity; no single party holds a master secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garg-Hajiabadi-Mahmoody-Rahimi** | 2018 | Lattices / iO | First RBE construction; removes key escrow [[1]](https://eprint.iacr.org/2018/040) |
| **Efficient RBE (Glaeser et al.)** | 2022 | Pairings + accumulators | Practical: O(log N) ciphertext from accumulator-based approach [[1]](https://eprint.iacr.org/2022/1505) |

**State of the art:** pairing + accumulator RBE (practical); resolves IBE's key escrow problem.

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

## Access Control Encryption (ACE)

**Goal:** Enforced communication policy. A sanitizer mediates all communication — it enforces who can send messages to whom according to a policy, without learning message contents. Neither sender nor receiver can bypass the policy. Unlike ABE (controls who reads), ACE controls who communicates.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Damgård-Haagh-Orlandi ACE** | 2016 | iO / witness encryption | First ACE; sanitizer enforces access graph without learning content [[1]](https://eprint.iacr.org/2016/106) |
| **ACE from Pairings (Fuchsbauer et al.)** | 2017 | Pairings + NIZK | Practical ACE without iO; disjunctive normal form policies [[1]](https://eprint.iacr.org/2017/457) |
| **ACE with Accountability** | 2019 | ACE + tracing | Identify policy violators; accountable sanitizer [[1]](https://eprint.iacr.org/2019/904) |

**State of the art:** Pairing-based ACE (2017); combines ideas from [ABE](#attribute-based--functional-encryption), [Proxy Re-Encryption](#proxy-re-encryption-pre), and network access control.

---

## Matchmaking Encryption

**Goal:** Dual-policy encryption. Message is decryptable only when BOTH the sender's attributes match the receiver's policy AND the receiver's attributes match the sender's policy. Neither party learns if decryption failed due to the other's policy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ateniese et al. ME** | 2019 | ABE + ZK | First matchmaking encryption; bilateral access control [[1]](https://eprint.iacr.org/2018/1094) |
| **Efficient ME (Chen et al.)** | 2021 | Pairings | Practical construction with shorter ciphertexts [[1]](https://eprint.iacr.org/2021/680) |

**State of the art:** pairing-based ME; applications in dating platforms, classified communication, bilateral credential matching.

---

## Key-Aggregate Encryption

**Goal:** Compact delegation for cloud storage. Encrypt N files under N different keys; delegate access to any chosen subset S with a single short aggregate key — regardless of |S|. The aggregate key is constant-size (one group element), not proportional to the number of shared files.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chu-Chow-Tzeng-Zhou KAE** | 2014 | Pairings | First KAE; constant-size aggregate key for any subset of ciphertexts [[1]](https://eprint.iacr.org/2013/679) |
| **KAE with Authentication** | 2016 | Pairings + signatures | Authenticated KAE; detect tampering of delegated ciphertexts [[1]](https://doi.org/10.1016/j.jisa.2016.09.001) |
| **Lattice KAE** | 2019 | LWE | Post-quantum key-aggregate encryption [[1]](https://eprint.iacr.org/2019/494) |

**State of the art:** Pairing-based KAE (Chu et al. 2014); lattice KAE for PQ. Useful for cloud access control; related to [Broadcast Encryption](#broadcast-encryption) and [ABE](#attribute-based--functional-encryption).

---

## Proxy Re-Encryption (PRE)

**Goal:** Delegated confidentiality. A semi-trusted proxy can re-encrypt Alice's ciphertext so Bob can decrypt it — without the proxy ever seeing the plaintext. Used in cloud storage access delegation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blaze-Bleumer-Strauss PRE** | 1998 | ElGamal | First scheme; bidirectional re-encryption [[1]](https://link.springer.com/chapter/10.1007/BFb0054122) |
| **AFGH PRE** | 2006 | Pairings | Unidirectional, non-interactive; CPA-secure [[1]](https://eprint.iacr.org/2005/028) |
| **Umbral (NuCypher)** | 2018 | EC + AFGH | Threshold PRE: *t-of-n* proxies needed [[1]](https://eprint.iacr.org/2017/206) |
| **CCA-secure PRE (Libert-Vergnaud)** | 2008 | Pairings | CCA2-secure unidirectional PRE; needed for real-world deployment [[1]](https://eprint.iacr.org/2008/286) |

**State of the art:** AFGH (single-hop, CPA), CCA-secure PRE (Libert-Vergnaud), Umbral (threshold, deployed in NuCypher/Threshold network).

---

## Transciphering / FHE-friendly Ciphers

**Goal:** Efficient client-to-FHE bridge. Client encrypts data with a lightweight symmetric cipher; the server homomorphically evaluates the cipher's decryption circuit to switch into the FHE domain. Avoids sending massive FHE ciphertexts over the network.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kreyvium** | 2016 | Stream cipher (Trivium variant) | Low multiplicative depth (12); optimized for FHE transciphering [[1]](https://eprint.iacr.org/2015/113) |
| **HERA** | 2022 | AES-like (MPC/FHE-friendly) | Designed for transciphering; low ANDdepth; competitive throughput [[1]](https://eprint.iacr.org/2021/731) |
| **Pasta** | 2022 | Feistel (FHE-optimized) | Designed for TFHE/BFV transciphering; affine layers + Sbox [[1]](https://eprint.iacr.org/2021/731) |
| **Elisabeth** | 2022 | Stream cipher (FHE-native) | Designed specifically for TFHE; minimal bootstrapping cost [[1]](https://eprint.iacr.org/2022/099) |

**State of the art:** HERA/Pasta for BFV/BGV transciphering; Elisabeth for TFHE. Bridges [Symmetric Encryption](#symmetric-encryption) and [Homomorphic Encryption](#homomorphic-encryption-he).

---

## Hidden Vector Encryption (HVE)

**Goal:** Conjunctive search on encrypted attributes. Encrypt a vector of attributes (a₁, ..., aₙ); a key for pattern (p₁, ..., pₙ) with wildcards (*) decrypts iff aᵢ = pᵢ for all non-wildcard positions. Enables expressive encrypted search without revealing the query pattern.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Waters HVE** | 2007 | Pairings (composite order) | First HVE; conjunctive, subset, and range queries on encrypted data [[1]](https://eprint.iacr.org/2007/013) |
| **Park-Lee-Lee HVE** | 2011 | Pairings (prime order) | Efficient HVE in prime-order groups; shorter ciphertexts [[1]](https://doi.org/10.1007/978-3-642-21554-4_4) |
| **Lattice HVE (Agrawal-Freeman)** | 2013 | LWE | Post-quantum HVE from lattice assumptions [[1]](https://eprint.iacr.org/2013/328) |

**State of the art:** Lattice HVE for PQ; prime-order pairing HVE for efficiency. Generalizes [Searchable Encryption](#searchable-encryption-sse--peks) and specializes [Predicate Encryption](#attribute-based--functional-encryption).

---
