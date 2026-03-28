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

## Gentry's Original FHE (Ideal Lattices)

**Goal:** Compute arbitrary functions on ciphertext without decrypting. Craig Gentry's 2009 construction was the first scheme ever proven to support unbounded homomorphic computation, resolving a 30-year open problem.

The scheme proceeds in three steps. First, a *somewhat homomorphic* encryption (SHE) is built from ideal lattices: a polynomial ring modded by a secret ideal, supporting a bounded number of additions and multiplications before noise overwhelms the ciphertext. Second, the SHE is made *bootstrappable* by *squashing the decryption circuit* — the encrypter hints at the secret key so that decryption can be expressed as a low-depth (NC¹) circuit, which the SHE can evaluate homomorphically. Third, by homomorphically evaluating the decryption function on a noisy ciphertext, the noise is "refreshed" and computation can continue indefinitely — this is *bootstrapping*. The security of the squashing step relies on the sparse subset-sum (SSSP) assumption in addition to the underlying lattice hardness. The scheme is exponentially slower than later generations but remains the theoretical blueprint that all subsequent FHE builds on.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gentry FHE (ideal lattices)** | 2009 | Ideal lattices | First FHE; bootstrapping via homomorphic decryption [[1]](https://dl.acm.org/doi/10.1145/1536414.1536440) |
| **Gentry-Halevi HElib (STOC impl.)** | 2011 | Ideal lattices | First implementation; ~6 min per bootstrap gate [[1]](https://eprint.iacr.org/2010/520) |
| **FHE over the Integers (vDGHV)** | 2010 | Integers / hidden subgroup | Conceptually simpler variant of Gentry's idea over integers [[1]](https://eprint.iacr.org/2009/616) |

**State of the art:** Gentry's original construction is superseded in practice by BGV/BFV/CKKS/TFHE, but bootstrapping (noise refresh by homomorphic decryption) remains the conceptual core of all fully homomorphic schemes.

---

## GSW (Gentry-Sahai-Waters) FHE

**Goal:** Leveled and fully homomorphic encryption from LWE with an asymptotically faster, conceptually simpler design based on the *approximate eigenvector* method.

Published at CRYPTO 2013, GSW encodes a bit µ as a matrix **C** ∈ ℤ_q^{N×N} such that **C** · **v** ≈ µ · **v** for a secret vector **v** (the approximate eigenvector). Homomorphic addition is matrix addition; homomorphic multiplication is matrix multiplication. The key insight is that the noise growth during multiplication is *asymmetric*: the noise from the right operand grows linearly while the left operand's noise stays bounded, enabling a noise analysis much simpler than key-switching or modulus-switching. When combined with a gadget decomposition (bit-decomposition of matrices), the scheme achieves polynomial noise growth per level, making it leveled FHE without bootstrapping, or fully homomorphic when bootstrapping is applied.

GSW is the direct precursor of the fast-bootstrapping FHEW and TFHE families. It also natively supports attribute-based encryption constructions because the homomorphic evaluation of predicates follows directly from matrix multiplication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GSW** | 2013 | LWE | Approximate eigenvector method; matrix add/mul; clean noise analysis [[1]](https://eprint.iacr.org/2013/340) |
| **Ring-GSW (RGSW)** | 2014 | RLWE | Ring variant used inside FHEW/TFHE bootstrapping as external-product ciphertexts [[1]](https://eprint.iacr.org/2014/816) |

**State of the art:** GSW/RGSW are not used directly in production but underpin FHEW and TFHE bootstrapping (the blind-rotation step is an RGSW external product). They also inform constructions of [ABE/FE](#attribute-based--functional-encryption) from LWE.

---

## FHEW Bootstrapping

**Goal:** Reduce the bootstrapping bottleneck of FHE to sub-second latency. FHEW (2015) broke the barrier from minutes to under one second per gate by combining a homomorphic NAND gate evaluation with a fast ring-based refresh procedure.

Published at EUROCRYPT 2015 by Ducas and Micciancio, FHEW works over LWE ciphertexts encrypting single bits. Refreshing a noisy bit-ciphertext is recast as evaluating a *lookup table* (specifically the NAND truth table) homomorphically using an RGSW accumulator over a ring ℤ[X]/(Xⁿ+1). The accumulator is initialized to the plaintext polynomial and rotated by each key-bit via an RGSW external product — the so-called *blind rotation*. The final coefficient extracted from the accumulator is the refreshed ciphertext, with noise independent of circuit depth. The implementation ran in ~0.5 s per bootstrap on commodity hardware — compared to ~6 minutes for the prior HElib. The TFHE library (2016/2020) further optimised the same blind-rotation approach to ~10 ms per gate and extended it to *programmable bootstrapping* (evaluate any univariate function during the bootstrap, not just NAND).

| Scheme | Year | Latency | Note |
|--------|------|---------|------|
| **FHEW** | 2015 | ~0.5 s/gate | First sub-second bootstrapping; blind rotation over RLWE [[1]](https://link.springer.com/chapter/10.1007/978-3-662-46800-5_24) |
| **TFHE (Chillotti et al.)** | 2016/2020 | ~10 ms/gate | Torus variant; programmable bootstrapping; evaluates arbitrary LUT during refresh [[1]](https://eprint.iacr.org/2018/421) |
| **FINAL** | 2022 | ~1 ms/gate | Further FHEW-family optimization; improved key sizes [[1]](https://eprint.iacr.org/2021/317) |

**State of the art:** TFHE-rs (Zama) is the production-grade implementation used in encrypted smart contracts and privacy-preserving ML inference. Programmable bootstrapping makes FHEW-family schemes uniquely suited to non-polynomial operations (comparisons, ReLU, integer divisions) without circuit depth overhead.

---

## CKKS Approximate Arithmetic & Rescaling

**Goal:** Homomorphic computation over real and complex numbers with controlled approximation error. CKKS (2017) introduces a *rescaling* operation that manages ciphertext magnitude without expensive exact-integer techniques, making FHE practical for ML and scientific workloads.

Published at ASIACRYPT 2017 by Cheon, Kim, Kim, and Song (hence CKKS), the scheme encodes a vector of real (or complex) numbers into the coefficient slots of a cyclotomic polynomial ring using RLWE. Unlike BGV/BFV which require exact integer plaintext spaces, CKKS deliberately accepts a small additive error after each multiplication and uses *rescaling* — dividing by a factor of the ciphertext modulus — to keep the magnitude of plaintexts bounded. This mirrors floating-point rounding: computations are approximate but with predictable precision loss.

SIMD batching packs ⌊n/2⌋ complex values into one ciphertext (n = ring degree), enabling highly parallelized matrix-vector products, polynomial approximations, and neural-network layer evaluations on encrypted data. The RNS (Residue Number System) representation enables efficient modular arithmetic on commodity 64-bit hardware.

Bootstrapping for CKKS (approximate bootstrapping) is more subtle than for BGV/BFV: the refresh must handle real-valued precision loss. The CKKS bootstrapping approach (Cheon et al. 2018; Han and Ki 2020) homomorphically evaluates the modular reduction as a trigonometric polynomial approximation, recovering sufficient precision levels at the cost of ~10–20 levels of multiplicative depth.

| Feature | Detail |
|---------|--------|
| **Plaintext space** | ℝⁿ/² or ℂⁿ/² (SIMD packed) |
| **Core operation** | Approximate add/mul + rescale (divide-by-Δ after mul) |
| **Bootstrapping** | Approximate mod-reduction via cosine approximation; ~10–20 levels consumed |
| **Primary use** | Privacy-preserving ML inference and training; genome analysis; statistics |

| Scheme / Work | Year | Note |
|---------------|------|------|
| **CKKS original** | 2017 | Approximate HE with rescaling [[1]](https://eprint.iacr.org/2016/421) |
| **CKKS bootstrapping (CHKKS)** | 2018 | Homomorphic mod-reduction via polynomial approx [[1]](https://eprint.iacr.org/2018/153) |
| **RNS-CKKS (Cheon et al.)** | 2019 | RNS-friendly CKKS enabling efficient 64-bit implementation [[1]](https://eprint.iacr.org/2018/931) |
| **HE for ML (SHE-ML)** | 2019 | Systematic study of CKKS for neural network inference [[1]](https://eprint.iacr.org/2018/1056) |

**State of the art:** CKKS (implemented in OpenFHE, HEAAN, Microsoft SEAL) is the dominant scheme for privacy-preserving machine learning. CKKS bootstrapping allows unbounded depth at the cost of precision, which is sufficient for most ML workloads.

---

## Quadratic / Degree-2 Functional Encryption

**Goal:** Decrypt a *quadratic function* of the plaintext — i.e., a bilinear map of the form f(x) = xᵀ · M · y for encrypted vectors — without revealing the vectors themselves. Goes beyond linear inner-product FE to support quadratic features useful in ML and statistics.

Baltico, Catalano, Fiore, and Gay (CRYPTO 2017) gave the first practically efficient FE for the class of bilinear maps on encrypted vectors: given an encryption of vector **x**, a secret key for matrix **M** (or, in the two-input variant, encryptions of both **x** and **y**) allows computing **xᵀM y** mod p. Their constructions over asymmetric bilinear groups are *linear in n* in ciphertext and key size — a public key of 2n+1 group elements, keys of 2 group elements — and are proven selectively secure under Matrix-DDH or adaptively secure in the generic group model.

Degree-2 FE captures a rich class of statistics: Euclidean norms, dot products, chi-squared statistics, second-order features, and polynomial classifiers. The work also yields efficient predicate encryption for degree-2 polynomial predicates.

| Scheme | Year | Security | Note |
|--------|------|----------|------|
| **IPFE (Abdalla et al.)** | 2015 | Selective, DDH/LWE | Inner-product FE (degree 1); practical; used in privacy-preserving data analysis [[1]](https://eprint.iacr.org/2015/017) |
| **Quadratic FE (Baltico-Catalano-Fiore-Gay)** | 2017 | Selective (Matrix-DDH) / adaptive (GGM) | Bilinear map FE; ciphertext size O(n); pairings [[1]](https://eprint.iacr.org/2017/151) |
| **FE for Quadratic Functions from k-Lin (Gay)** | 2020 | Adaptive, standard assumptions | Fully adaptive security from k-Lin without generic group model [[1]](https://eprint.iacr.org/2019/728) |
| **Multi-Client IPFE** | 2019 | Selective, DDH | Multiple encryptors; joint inner product; no interaction [[1]](https://eprint.iacr.org/2017/972) |

**State of the art:** Quadratic FE from pairings (Baltico et al.) is the most practical for single-input second-order functions. Adaptive security from k-Lin (Gay 2020) provides stronger guarantees. These schemes bridge [Inner-Product FE](#attribute-based--functional-encryption) and [Multi-Input FE](#attribute-based--functional-encryption) in the functional encryption hierarchy.

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
