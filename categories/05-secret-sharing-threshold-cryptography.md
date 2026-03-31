# Secret Sharing & Threshold Cryptography


<!-- TOC -->
## Contents (58 schemes)

**[Shamir and Basic Secret Sharing](#shamir-and-basic-secret-sharing)**
- [Secret Sharing Schemes (SSS)](#secret-sharing-schemes-sss)
- [Publicly Verifiable Secret Sharing (PVSS)](#publicly-verifiable-secret-sharing-pvss)
- [Packed Secret Sharing](#packed-secret-sharing)
- [Robust Secret Sharing](#robust-secret-sharing)
- [Ramp Secret Sharing](#ramp-secret-sharing)
- [General Access Structure Secret Sharing](#general-access-structure-secret-sharing)
- [Leakage-Resilient Secret Sharing](#leakage-resilient-secret-sharing)
- [CRT-based Secret Sharing (Mignotte / Asmuth-Bloom)](#crt-based-secret-sharing-mignotte--asmuth-bloom)
- [Multiplicative Secret Sharing](#multiplicative-secret-sharing)
- [XOR-Based / Binary-Field Secret Sharing](#xor-based--binary-field-secret-sharing)
- [Linear Secret Sharing Schemes (LSSS)](#linear-secret-sharing-schemes-lsss)
- [Blakley's Geometric Secret Sharing](#blakleys-geometric-secret-sharing)
- [Berlekamp-Welch Decoding for Secret Sharing](#berlekamp-welch-decoding-for-secret-sharing)
- [SLIP-39: Shamir's Secret Sharing for BIP-39 Mnemonics](#slip-39-shamirs-secret-sharing-for-bip-39-mnemonics)
- [Secret Sharing over Non-Abelian Groups](#secret-sharing-over-non-abelian-groups)

**[Threshold Cryptography](#threshold-cryptography)**
- [Threshold Decryption](#threshold-decryption)
- [Distributed Key Generation (DKG)](#distributed-key-generation-dkg)
- [Non-Interactive DKG (NIDKG)](#non-interactive-dkg-nidkg)
- [Universal Thresholdizer](#universal-thresholdizer)
- [FROST: Flexible Round-Optimized Schnorr Threshold Signatures](#frost-flexible-round-optimized-schnorr-threshold-signatures)
- [Threshold Raccoon: Post-Quantum Lattice Threshold Signatures](#threshold-raccoon-post-quantum-lattice-threshold-signatures)
- [Threshold BLS Key Generation](#threshold-bls-key-generation)
- [Online vs Offline Threshold Signing](#online-vs-offline-threshold-signing)
- [Witness Encryption for Secret Sharing Policies](#witness-encryption-for-secret-sharing-policies)

**[Verifiable and Proactive Secret Sharing](#verifiable-and-proactive-secret-sharing)**
- [Proactive Secret Sharing](#proactive-secret-sharing)
- [Asynchronous Verifiable Secret Sharing (AVSS)](#asynchronous-verifiable-secret-sharing-avss)
- [Traceable Secret Sharing](#traceable-secret-sharing)
- [SCRAPE: Scalable Publicly Verifiable Secret Sharing](#scrape-scalable-publicly-verifiable-secret-sharing)

**[Advanced Secret Sharing](#advanced-secret-sharing)**
- [Unclonable Secret Sharing](#unclonable-secret-sharing)
- [Evolving Secret Sharing](#evolving-secret-sharing)
- [Secret Sharing with Cheater Detection](#secret-sharing-with-cheater-detection)
- [Verifiable Information Dispersal (VID)](#verifiable-information-dispersal-vid)
- [Accountable Decryption](#accountable-decryption)
- [Multi-Secret Sharing](#multi-secret-sharing)
- [Quantum Secret Sharing](#quantum-secret-sharing)
- [Function Secret Sharing (FSS) for Threshold Policies](#function-secret-sharing-fss-for-threshold-policies)
- [Computational Secret Sharing](#computational-secret-sharing)
- [Regenerating Codes for Distributed Storage](#regenerating-codes-for-distributed-storage)
- [DKLS23: Threshold ECDSA in Three Rounds](#dkls23-threshold-ecdsa-in-three-rounds)
- [Hierarchical Secret Sharing](#hierarchical-secret-sharing)
- [Shared RSA Key Generation](#shared-rsa-key-generation)
- [Pseudorandom Secret Sharing (PRSS / PRZS)](#pseudorandom-secret-sharing-prss--przs)
- [Secret Sharing with Fairness](#secret-sharing-with-fairness)
- [Share Conversion (Arithmetic-to-Boolean and Boolean-to-Arithmetic)](#share-conversion-arithmetic-to-boolean-and-boolean-to-arithmetic)
- [Threshold Verifiable Random Functions (Threshold VRF)](#threshold-verifiable-random-functions-threshold-vrf)
- [Weighted Threshold Secret Sharing](#weighted-threshold-secret-sharing)
- [Secret Sharing with Cheater Identification (Harn-Lin)](#secret-sharing-with-cheater-identification-harn-lin)
- [Visual Secret Sharing](#visual-secret-sharing)
- [AONT-RS: All-or-Nothing Transform with Reed-Solomon for Cloud Storage](#aont-rs-all-or-nothing-transform-with-reed-solomon-for-cloud-storage)
- [Rational Secret Sharing](#rational-secret-sharing)
- [Verifiable Multi-Secret Sharing (VMSS)](#verifiable-multi-secret-sharing-vmss)
- [Secret Sharing with Enrollment / Dynamic Secret Sharing](#secret-sharing-with-enrollment--dynamic-secret-sharing)
- [CRT-Based Secret Sharing (Mignotte / Asmuth-Bloom)](#crt-based-secret-sharing-mignotte--asmuth-bloom)
- [Visual Secret Sharing (Visual Cryptography)](#visual-secret-sharing-visual-cryptography)
- [Computational Secret Sharing / "Secret Sharing Made Short" (Krawczyk)](#computational-secret-sharing--secret-sharing-made-short-krawczyk)
- [Hierarchical Threshold Secret Sharing (Tassa)](#hierarchical-threshold-secret-sharing-tassa)
- [Verifiable Secret Redistribution (VSR)](#verifiable-secret-redistribution-vsr)
- [Timed Secret Sharing](#timed-secret-sharing)

<!-- /TOC -->

## Shamir and Basic Secret Sharing

---
### Secret Sharing Schemes (SSS)

**Goal:** Split a secret into *n* shares so that any *t* shares reconstruct it, but fewer than *t* reveal nothing. Provides confidentiality + availability.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Shamir's Secret Sharing** | 1979 | Polynomial interpolation | Information-theoretically secure; *(t,n)* threshold [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Blakley's Scheme** | 1979 | Hyperplane geometry | Alternative geometric approach [[1]](https://doi.org/10.1109/AFIPS.1979.98) |
| **Verifiable SS (VSS) — Feldman** | 1987 | Commitments on polynomial coeff. | Detects cheating dealer [[1]](https://doi.org/10.1109/SFCS.1987.4) |
| **Verifiable SS — Pedersen** | 1991 | Double commitments | Information-theoretically hiding [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Packed Secret Sharing** | 1992 | Multi-secret polynomial | Amortized: share multiple secrets at once [[1]](https://dl.acm.org/doi/10.1145/129712.129780) |
| **Proactive SS** | 1995 | Periodic share refresh | Tolerates mobile adversary over time [[1]](https://link.springer.com/chapter/10.1007/3-540-44750-4_27) |
| **Verifiable Weighted SS** | 2025 | Bulletproofs + Shamir | First efficient verifiable weighted SS; stake-aware party weights [[1]](https://arxiv.org/abs/2505.24289) |

**State of the art:** Shamir + Feldman VSS (practical), Packed SS (MPC optimization), Weighted SS (2025).

**Production readiness:** Production
Shamir's SS is deployed in HashiCorp Vault, SLIP-39 wallets, and countless key management systems; Feldman VSS is used in production DKG protocols.

**Implementations:**
- [hashicorp/vault](https://github.com/hashicorp/vault) ⭐ 35k — Go, Shamir sharing for unsealing
- [dsprenkels/sss](https://github.com/dsprenkels/sss) ⭐ 399 — C, Shamir over GF(2^8)
- [iancoleman/shamir](https://github.com/iancoleman/shamir) ⭐ 259 — Go, Shamir library
- [trezor/python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, SLIP-39 implementation
- [snipsco/rust-threshold-secret-sharing](https://github.com/snipsco/rust-threshold-secret-sharing) ⭐ 171 — Rust, packed and Shamir SS

**Security status:** Secure
Information-theoretically secure (Shamir, Blakley); Feldman/Pedersen VSS are computationally secure under DLP/DL assumptions with no known attacks.

**Community acceptance:** Standard
Shamir's SS is universally accepted; Feldman VSS is the de facto standard for verifiable sharing in threshold cryptography.

---

### Publicly Verifiable Secret Sharing (PVSS)

**Goal:** Transparency + integrity. A verifiable secret sharing scheme where *anyone* (not just participants) can verify that shares are correctly computed — even without a trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Stadler PVSS** | 1996 | DLP + ZK | First practical PVSS [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_6) |
| **Schoenmakers PVSS** | 1999 | DLP | Simpler, more efficient; widely deployed [[1]](https://eprint.iacr.org/1999/011) |
| **Aggregatable PVSS** | 2021 | KZG + pairings | O(1) verification; scalable for blockchain randomness [[1]](https://eprint.iacr.org/2021/339) |

**State of the art:** Aggregatable PVSS (randomness beacons, DKG), Schoenmakers (classic deployments).

**Production readiness:** Production
Schoenmakers PVSS is deployed in multiple systems; Aggregatable PVSS is used in drand and Ethereum randomness protocols.

**Implementations:**
- [anoma/ferveo](https://github.com/anoma/ferveo) ⭐ 84 — Rust, aggregatable PVSS for threshold decryption
- [drand/kyber](https://github.com/drand/kyber) ⭐ 10 — Go, PVSS primitives for drand
- [KZen-networks/curv](https://github.com/ZenGo-X/curv) ⭐ 272 — Rust, Feldman/Schoenmakers VSS

**Security status:** Secure
Schoenmakers PVSS secure under DLP; Aggregatable PVSS secure under pairing/KZG assumptions; no known attacks.

**Community acceptance:** Widely trusted
Schoenmakers is a textbook PVSS; Aggregatable PVSS is endorsed by the Ethereum research community for randomness beacons.

---

### Packed Secret Sharing

**Goal:** Amortized secret sharing. Share k secrets simultaneously using a single polynomial of degree t + k − 1, instead of k separate Shamir sharings. Reduces communication in MPC by a factor of k — crucial for large-scale secure computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Franklin-Yung Packed SS** | 1992 | Polynomial | First packed SS; k secrets in one degree-(t+k−1) polynomial [[1]](https://doi.org/10.1007/3-540-48071-4_12) |
| **Packed SS for MPC (Damgård et al.)** | 2006 | Packed Shamir | Amortized MPC: evaluate k gates in one round via packed shares [[1]](https://eprint.iacr.org/2005/264) |
| **Turbopack** | 2022 | Packed SS + batch | Further optimize MPC with packed SS; near-optimal communication [[1]](https://eprint.iacr.org/2022/1316) |

**State of the art:** Turbopack (2022) for high-throughput MPC; packed SS is a core optimization in [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Research
Packed SS is used in research MPC frameworks; Turbopack is an academic prototype with no standalone production deployment.

**Implementations:**
- [mc2-project/cerebro](https://github.com/mc2-project/cerebro) ⭐ 24 — Rust, MPC framework using packed secret sharing
- [snipsco/rust-threshold-secret-sharing](https://github.com/snipsco/rust-threshold-secret-sharing) ⭐ 171 — Rust, packed Shamir implementation

**Security status:** Secure
Information-theoretically secure; inherits Shamir's security guarantees with the same threshold parameters.

**Community acceptance:** Niche
Well-known in the MPC research community as a core optimization technique; limited visibility outside academic MPC systems.

---

### Robust Secret Sharing

**Goal:** Error-tolerant reconstruction. Reconstruct the secret correctly even when up to t_c shares are adversarially corrupted (not just missing). Standard Shamir fails with even one corrupted share — robust SS detects and corrects errors during reconstruction.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rabin-Ben-Or Robust SS** | 1989 | Error-correcting + Shamir | First robust SS; detects corrupted shares via error-correcting codes [[1]](https://doi.org/10.1145/73007.73014) |
| **Cramer-Damgård-Fehr Robust SS** | 2006 | Algebraic + MAC | Optimal corruption tolerance: t_c < n/3 for information-theoretic [[1]](https://eprint.iacr.org/2006/109) |
| **Cevallos-Fehr-Ostrovsky Robust SS** | 2012 | Short shares | Asymptotically optimal share size + robust reconstruction [[1]](https://eprint.iacr.org/2012/372) |

**State of the art:** Optimal robust SS (Cevallos et al. 2012); essential for [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and [DKG](#distributed-key-generation-dkg) with malicious parties. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Robust reconstruction is built into production MPC frameworks and DKG protocols that handle malicious adversaries.

**Implementations:**
- [KZen-networks/curv](https://github.com/ZenGo-X/curv) ⭐ 272 — Rust, VSS with error detection
- [drand/kyber](https://github.com/drand/kyber) ⭐ 10 — Go, robust share verification in DKG
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, robust secret sharing in malicious-secure MPC

**Security status:** Secure
Information-theoretically secure for t_c < n/3 corruptions; no known attacks on standard constructions.

**Community acceptance:** Widely trusted
Core building block in malicious-secure MPC and DKG; well-studied with optimal bounds established.

---

### Ramp Secret Sharing

**Goal:** Efficiency vs. privacy tradeoff. In (t, t+g, n)-ramp SS, fewer than t shares reveal nothing, t+g or more shares reconstruct the secret, and between t and t+g shares may leak partial information. Shares are g times shorter than in Shamir — critical for large secrets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blakley-Meadows Ramp SS** | 1985 | Linear algebra | First ramp scheme; shares = secret_size / g instead of secret_size [[1]](https://doi.org/10.1007/3-540-39757-4_20) |
| **Franklin-Yung (packed as ramp)** | 1992 | Polynomial | Packed secret sharing is a ramp scheme; share k secrets in one poly [[1]](https://doi.org/10.1007/3-540-48071-4_12) |
| **Ramp SS for MPC** | 2006 | Packed Shamir | Amortized MPC communication using ramp shares [[1]](https://eprint.iacr.org/2005/264) |

**State of the art:** Ramp SS for large-secret sharing and amortized [MPC](06-multi-party-computation.md#multi-party-computation-mpc); closely related to [Packed Secret Sharing](#packed-secret-sharing). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Ramp schemes are used in distributed storage and MPC frameworks where share size reduction is critical.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, ramp sharing for amortized MPC
- [snipsco/rust-threshold-secret-sharing](https://github.com/snipsco/rust-threshold-secret-sharing) ⭐ 171 — Rust, ramp/packed SS

**Security status:** Caution
Information-theoretically secure but by design leaks partial information for coalitions between t and t+g; correct parameter selection is essential.

**Community acceptance:** Niche
Well-understood in the MPC and information theory communities; less familiar outside those domains.

---

### General Access Structure Secret Sharing

**Goal:** Beyond threshold. Share a secret so that any authorized subset of participants (defined by an arbitrary monotone access structure) can reconstruct, while unauthorized subsets learn nothing. Generalizes (t,n)-threshold to any collection of qualified sets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ito-Saito-Nishizeki** | 1989 | Monotone formulae | First general construction; any monotone access structure; exponential share size [[1]](https://doi.org/10.1007/0-387-34805-0_43) |
| **Benaloh-Leichter** | 1990 | Monotone formulae | Simpler construction; shares from formula decomposition [[1]](https://doi.org/10.1007/0-387-34805-0_27) |
| **Linear Secret Sharing (LSSS)** | 1996 | Monotone span programs | Shares are linear in secret; basis of ABE access policies [[1]](https://doi.org/10.1007/3-540-68339-9_22) |
| **Multi-Linear SS (Beimel)** | 2011 | General | Survey of constructions; share size lower bounds [[1]](https://doi.org/10.1007/978-3-642-20901-7_2) |

**State of the art:** LSSS for efficient schemes (used in [ABE](#threshold-decryption)); general access structures remain exponential in worst case — a major open problem. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Research
General access structure SS remains primarily theoretical due to exponential worst-case share sizes; LSSS-based constructions are used in ABE implementations.

**Implementations:**
- [sagrawal87/ABE](https://github.com/sagrawal87/ABE) ⭐ 206 — Python, LSSS-based access structures for ABE
- [zeutro/openabe](https://github.com/zeutro/openabe) ⭐ 274 — C++, LSSS access policies in attribute-based encryption

**Security status:** Secure
Information-theoretically secure; share size lower bounds are the constraint, not security.

**Community acceptance:** Widely trusted
LSSS is the standard formulation for access structures in ABE and MPC; general access structure SS is a well-studied theoretical area.

---

### Leakage-Resilient Secret Sharing

**Goal:** Side-channel resistant shares. Secret sharing remains secure even if an adversary learns bounded leakage (e.g., a few bits) from each share. Standard Shamir is completely broken by 1-bit leakage from each share; LRSS withstands it.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Benhamouda-Degwekar-Ishai-Rabin LRSS** | 2018 | Inner product + Shamir | First LRSS for general leakage; local leakage model [[1]](https://eprint.iacr.org/2018/294) |
| **Goyal-Kumar LRSS** | 2018 | Extractors + SS | Optimal rate LRSS; leakage up to (1-ε) fraction of share size [[1]](https://eprint.iacr.org/2018/099) |
| **Nielsen-Simkin Non-Malleable + LR SS** | 2020 | Combined model | Both leakage-resilient and non-malleable secret sharing [[1]](https://eprint.iacr.org/2020/209) |

**State of the art:** Combined NM + LR secret sharing (2020); extends [Secret Sharing](#secret-sharing-schemes-sss) and relates to [Leakage-Resilient Crypto](#leakage-resilient-secret-sharing).

**Production readiness:** Research
All LRSS constructions remain academic; no production implementations or deployments.

**Implementations:**
- No standalone open-source implementations exist; constructions are described in academic papers with reference code in supplementary materials.

**Security status:** Secure
Information-theoretically secure under the local leakage model; security proofs are rigorous.

**Community acceptance:** Niche
Well-regarded in the theoretical cryptography community; addresses a real side-channel threat but lacks practical tooling.

---

### CRT-based Secret Sharing (Mignotte / Asmuth-Bloom)

**Goal:** Threshold sharing via modular arithmetic. Split a secret into *n* shares using the Chinese Remainder Theorem (CRT) so that any *t* shares reconstruct it by CRT combination, without polynomial interpolation. An integer-arithmetic alternative to Shamir — shares are residues modulo pairwise coprime integers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mignotte's Scheme** | 1983 | CRT + Mignotte sequences | Uses special (t,n)-sequences where the product of the t smallest moduli exceeds that of the t−1 largest; *not* perfect — fewer than t shares can leak partial information [[1]](https://doi.org/10.1007/3-540-39466-4_27) |
| **Asmuth-Bloom Scheme** | 1983 | CRT + randomization | Adds a random multiple of the secret modulus before reduction; achieves *perfect* secrecy — fewer than t shares reveal nothing [[1]](https://doi.org/10.1109/TIT.1983.1056651) |
| **Ideal CRT-based SS** | 2018 | CRT over cyclotomic fields | Constructs ideal (optimal share size) CRT-based schemes for any threshold [[1]](https://eprint.iacr.org/2018/837) |
| **Homomorphic CRT-SS** | 2020 | CRT + homomorphic ext. | Extends Asmuth-Bloom with homomorphic operations on shares; enables CRT-based MPC [[1]](https://www.sciencedirect.com/science/article/pii/S0166218X20303012) |

**State of the art:** Asmuth-Bloom is the standard perfect CRT-based scheme; Mignotte is historically important but imperfect. CRT-based SS is preferred when modular arithmetic is more natural than field arithmetic (e.g., hardware, RSA-based systems). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Asmuth-Bloom is implemented in several libraries; used in hardware security modules where modular arithmetic is natively supported.

**Implementations:**
- [dsprenkels/sss](https://github.com/dsprenkels/sss) ⭐ 399 — C, includes notes on CRT-based alternatives
- [mikeivanov/pysss](https://github.com/junkurihara/PySSS) ⭐ 7 — Python, Shamir and CRT-based secret sharing

**Security status:** Caution
Asmuth-Bloom is information-theoretically secure (perfect); Mignotte is not perfect (partial leakage below threshold). Parameter selection for CRT sequences requires care.

**Community acceptance:** Niche
Well-known in the secret sharing literature; less commonly deployed than Shamir due to more complex parameter generation.

---

### Multiplicative Secret Sharing

**Goal:** Threshold sharing compatible with multiplication. A secret sharing scheme is *multiplicative* if parties can locally multiply their shares of two secrets [a] and [b] to obtain shares of the product a·b, enabling secure multiplication in MPC without interaction. The foundational mechanism behind [BGW](06-multi-party-computation.md#multi-party-computation-mpc)-style perfectly secure MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir Multiplicative SS (BGW)** | 1988 | Polynomial evaluation | Shamir shares are multiplicative: product of shares lies on degree-2t polynomial; requires degree-reduction sub-protocol [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **d-Multiplicative SS (Ishai-Kushilevitz)** | 2000 | Combinatorics | Characterizes when a sharing scheme supports multiplication of d secrets; tight bounds on adversary threshold [[1]](https://link.springer.com/content/pdf/10.1007/s00145-010-9056-z.pdf) |
| **Multiplicative SS over Z_m** | 2000 | Rings | Extends multiplicative SS to composite moduli (rings); needed for arithmetic over Z_{2^k} in MPC [[1]](https://link.springer.com/chapter/10.1007/3-540-45708-9_18) |
| **Packed Multiplicative SS** | 2022 | Packed Shamir | Combines multiplicative and packed sharing; sharing transformation enables dishonest-majority MPC with amortized communication [[1]](https://eprint.iacr.org/2022/831) |

**State of the art:** Shamir sharing remains the standard multiplicative SS; degree-reduction (via Beaver triples or BGW resharing) is the bottleneck of information-theoretically secure MPC. Packed multiplicative SS (2022) amortizes costs. Central to [MPC](06-multi-party-computation.md#multi-party-computation-mpc), [Packed SS](#packed-secret-sharing), and [Robust SS](#robust-secret-sharing).

**Production readiness:** Production
Multiplicative Shamir sharing is the core of BGW/SPDZ-style MPC frameworks deployed in production.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, multiplicative Shamir sharing in SPDZ/BGW protocols
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, multiplicative SS for malicious MPC
- [TNO-MPC/mpyc](https://github.com/lschoe/mpyc) ⭐ 415 — Python, BGW-style MPC with multiplicative Shamir

**Security status:** Secure
Information-theoretically secure; degree-reduction protocols are well-analyzed.

**Community acceptance:** Widely trusted
Foundational building block of all Shamir-based MPC; universally accepted in the MPC community.

---

### XOR-Based / Binary-Field Secret Sharing

**Goal:** Hardware-efficient threshold sharing. Replace Shamir's polynomial arithmetic over large prime fields with XOR (exclusive-OR) operations over GF(2) or byte-oriented GF(2^8) — achieving an ideal (t,n)-threshold scheme hundreds of times faster in software and trivially implementable in hardware, at the same information-theoretic security level.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir over GF(2^8) (byte-wise)** | 1979 | GF(2^8) | Standard Shamir applied byte-by-byte; all arithmetic is bitwise; used in practically every modern implementation (libgfshare, SSSS, HashiCorp Vault) [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Kurihara et al. XOR-SS** | 2008 | XOR only, GF(2^n) | First ideal (t,n)-XOR-only scheme; 900× faster than GF(2^64) Shamir for large secrets; perfect secrecy proven; ISC 2008 / ISITA 2010 [[1]](https://eprint.iacr.org/2008/409) |
| **Efficient XOR-Based (t,n) (Pasalic et al.)** | 2016 | Bent functions + XOR | Reduces share generation cost further; suitable for constrained devices [[1]](https://link.springer.com/chapter/10.1007/978-3-319-48965-0_28) |
| **Secret Sharing with Binary Shares** | 2018 | Linear codes over GF(2) | Information-theoretic bounds for binary-share SS; characterizes achievable rates [[1]](https://eprint.iacr.org/2018/746) |

**State of the art:** GF(2^8) Shamir is the industry default (used in HashiCorp Vault, age-plugin-threshold, SLIP-39). Kurihara's pure-XOR scheme is preferred for high-throughput or hardware contexts. All variants are information-theoretically perfect. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Production
GF(2^8) Shamir is deployed in HashiCorp Vault, SLIP-39, and numerous secret sharing libraries; industry default.

**Implementations:**
- [jcushman/libgfshare](https://github.com/jcushman/libgfshare) ⭐ 12 — C, GF(2^8) Shamir (libgfshare)
- [dsprenkels/sss](https://github.com/dsprenkels/sss) ⭐ 399 — C, Shamir over GF(2^8) with hazmat API
- [trezor/python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, SLIP-39 over GF(2^10)
- [hashicorp/vault](https://github.com/hashicorp/vault) ⭐ 35k — Go, GF(2^8) Shamir for vault unsealing

**Security status:** Secure
Information-theoretically perfect secrecy; GF(2^8) arithmetic is well-understood and constant-time implementable.

**Community acceptance:** Standard
GF(2^8) Shamir is the universal default for byte-oriented secret sharing; deployed in all major secret sharing products.

---

### Linear Secret Sharing Schemes (LSSS)

**Goal:** Abstract algebraic formulation of secret sharing. An LSSS is defined by a matrix M and a labeling of rows to participants; each share is a linear function of (secret ∥ randomness); reconstruction is a linear combination. Any access structure realizable by a monotone span program has an LSSS, and LSSS is the foundation of Attribute-Based Encryption, arithmetic MPC, and [General Access Structure SS](#general-access-structure-secret-sharing).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brickell Linear SS** | 1989 | Linear algebra | First explicit linear SS; shares are inner products of secret-seed with rows of a generator matrix; characterizes when ideal SS exists [[1]](https://link.springer.com/chapter/10.1007/0-387-34805-0_25) |
| **Karchmer-Wigderson Span Programs** | 1993 | Monotone span programs | Connects span program size to SS share size; any monotone Boolean function has an LSSS with shares equal to span program width [[1]](https://doi.org/10.1145/103418.103474) |
| **Monotone Span Programs (Cramer-Damgård-Maurer)** | 1996 | Span programs + field | LSSS for any monotone access structure over any field; basis for CP-ABE and KP-ABE access policies; standard formulation in the literature [[1]](https://doi.org/10.1007/3-540-68339-9_22) |
| **Arithmetic SS (Cramer-Damgård-de Haan)** | 2000 | Linear algebra + MPC | LSSS equivalence: any LSSS yields additively homomorphic sharing; enables BDOZ/SPDZ/BGW-style MPC over arithmetic circuits [[1]](https://link.springer.com/chapter/10.1007/3-540-44750-4_28) |
| **Compact LSSS (Applebaum-Arkis)** | 2019 | Random linear codes | Randomized construction achieves near-optimal share size for all monotone access structures; exponential deterministic lower bound circumvented; CRYPTO 2019 [[1]](https://eprint.iacr.org/2019/1308) |

**State of the art:** Monotone span programs (1996) are the standard LSSS formulation; backbone of [ABE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption) and [MPC](06-multi-party-computation.md#multi-party-computation-mpc). Compact LSSS (2019) achieves near-optimal share sizes. Subsumes [General Access Structure SS](#general-access-structure-secret-sharing) and underlies [Multiplicative Secret Sharing](#multiplicative-secret-sharing).

**Production readiness:** Production
LSSS is the backbone of all CP-ABE and KP-ABE implementations; deployed in attribute-based access control systems.

**Implementations:**
- [zeutro/openabe](https://github.com/zeutro/openabe) ⭐ 274 — C++, LSSS-based access policies in ABE
- [sagrawal87/ABE](https://github.com/sagrawal87/ABE) ⭐ 206 — Python, LSSS for ABE schemes
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, LSSS as arithmetic sharing in MPC

**Security status:** Secure
Information-theoretically secure; LSSS is a mathematical framework — security depends on the specific instantiation.

**Community acceptance:** Standard
Monotone span programs / LSSS are the universally accepted formulation for access structures in ABE and MPC.

---

### Blakley's Geometric Secret Sharing

**Goal:** Threshold secret sharing via hyperplane intersection. Represent the secret as a coordinate of a point in a k-dimensional space; each share is a (k−1)-dimensional hyperplane containing that point. Any k hyperplanes intersect in a unique point (the secret), while k−1 hyperplanes leave an entire affine subspace of possible secrets — achieving perfect information-theoretic secrecy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blakley's Scheme** | 1979 | Projective geometry over GF(p) | Each share is a hyperplane in k-dimensional space; k hyperplanes intersect at the unique secret point; published simultaneously with Shamir's polynomial scheme [[1]](https://doi.org/10.1109/AFIPS.1979.98) |
| **Geometric SS over GF(2^n)** | 1994 | Binary field hyperplanes | Adapts Blakley's scheme to binary extension fields; shares are cosets in GF(2^n)^k; useful for hardware-oriented implementations [[1]](https://doi.org/10.1007/3-540-48658-5_25) |
| **Blakley Ramp Variant** | 1985 | Affine subspace geometry | Uses lower-dimensional intersections to implement ramp schemes; between t and t+g shares determine a subspace rather than a point, leaking partial information — matching [Ramp SS](#ramp-secret-sharing) [[1]](https://doi.org/10.1007/3-540-39757-4_20) |
| **Geometric Multi-Secret SS** | 1994 | Multiple coordinates | Encodes multiple secrets as distinct coordinates of the intersection point; naturally extends Blakley to the multi-secret setting without additional polynomials [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_25) |

**State of the art:** Blakley's geometric scheme is information-theoretically equivalent to Shamir's in security and share size, but shares are larger (one share = a hyperplane description, O(k · log p) bits vs. a single field element in Shamir). In practice Shamir dominates, but Blakley's approach motivates [Ramp SS](#ramp-secret-sharing), [LSSS](#linear-secret-sharing-schemes-lsss), and geometric intuitions for [General Access Structure SS](#general-access-structure-secret-sharing). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Blakley's scheme is implemented in educational and reference libraries; Shamir dominates in production but Blakley is available.

**Implementations:**
- No widely-adopted standalone Blakley implementations; the scheme is included in educational cryptography toolkits.

**Security status:** Secure
Information-theoretically perfect secrecy; equivalent security to Shamir.

**Community acceptance:** Niche
Historically important as an independent invention; primarily of theoretical and educational interest today.

---

### Berlekamp-Welch Decoding for Secret Sharing

**Goal:** Efficiently recover the Shamir secret polynomial in the presence of corrupted shares. Shamir's scheme is equivalent to a Reed-Solomon code evaluation; when up to e shares are adversarially corrupted (not merely erased), the Berlekamp-Welch algorithm recovers the unique degree-(t−1) polynomial passing through all uncorrupted evaluation points in O(n³) time — enabling both error correction and cheater identification.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **McEliece-Sarwate observation** | 1981 | Reed-Solomon decoding | First noted that Shamir SS is a Reed-Solomon code; standard RS decoding detects/corrects errors during reconstruction [[1]](https://doi.org/10.1145/360363.360369) |
| **Berlekamp-Welch Algorithm** | 1986 | Linearized polynomial system | Solves for error-locator and message polynomials simultaneously via a linear system; recovers degree-(t−1) secret polynomial from n shares with up to e corruptions where 2e + t ≤ n + 1 [[1]](https://patents.google.com/patent/US4633470A) |
| **Gao's Decoding Algorithm** | 2002 | GCD of polynomials | Simpler formulation: compute gcd of the error-locator and interpolation polynomial; same parameters as Berlekamp-Welch but easier to implement; standard in teaching [[1]](https://www.math.clemson.edu/~sgao/papers/gao_RS.pdf) |
| **Guruswami-Sudan List Decoding** | 1999 | Bivariate factoring | Extends beyond the unique-decoding radius: corrects e > (n − t)/2 corruptions, returning a list of possible secrets; applicable when corruption exceeds half the redundancy [[1]](https://doi.org/10.1109/SFCS.1998.743426) |

**State of the art:** Berlekamp-Welch (or equivalently Gao's algorithm) is the standard tool for [Robust Secret Sharing](#robust-secret-sharing) and [Cheater Detection](#secret-sharing-with-cheater-detection) — used whenever the reconstruction step must tolerate active adversaries. Unique decoding corrects up to (n − t)/2 corruptions; Guruswami-Sudan list decoding extends further. Also foundational to [Verifiable Information Dispersal](#verifiable-information-dispersal-vid). Closely tied to polynomial interpolation uniqueness: any t points on a degree-(t−1) polynomial uniquely determine it over a field, so t correct shares always suffice.

**Production readiness:** Production
Reed-Solomon decoding (Berlekamp-Welch/Gao) is deployed in every RS implementation; foundational to QR codes, CD/DVD, and distributed storage.

**Implementations:**
- [backblaze/JavaReedSolomon](https://github.com/Backblaze/JavaReedSolomon) ⭐ 818 — Java, Reed-Solomon with error correction
- [klauspost/reedsolomon](https://github.com/klauspost/reedsolomon) ⭐ 2.1k — Go, high-performance RS encoding/decoding
- [tahoe-lafs/zfec](https://github.com/tahoe-lafs/zfec) ⭐ 423 — Python/C, RS erasure coding

**Security status:** Secure
Deterministic algebraic algorithm; correctness is mathematically proven. Error correction capacity 2e + t <= n + 1 is tight.

**Community acceptance:** Standard
Berlekamp-Welch and Gao's algorithms are textbook; universally used in coding theory and robust secret sharing.

---

### SLIP-39: Shamir's Secret Sharing for BIP-39 Mnemonics

**Goal:** Human-friendly threshold backup for cryptocurrency wallet seeds. SLIP-39 (SatoshiLabs Improvement Proposal 39) applies Shamir's Secret Sharing over GF(2^{10}) to split a 128- or 256-bit master secret into mnemonic word shares, enabling (t,n)-threshold recovery from ordinary paper backups — without trusting any single custodian with the full seed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SLIP-39 v1** | 2017 | GF(2^{10}) + Shamir | Splits BIP-39 seed into n mnemonic shares (each 20 or 33 words); any t shares reconstruct the master secret; includes RS checksum per share for error detection; hierarchical groups supported [[1]](https://github.com/satoshilabs/slips/blob/master/slip-0039.md) |
| **SLIP-39 Group Threshold** | 2019 | Two-level Shamir | Extends to group-of-groups: define m groups each with their own (t_i, n_i) threshold; require any k groups to qualify; supports organizational key custody with heterogeneous trust zones [[1]](https://github.com/satoshilabs/slips/blob/master/slip-0039.md) |
| **Trezor Model T Implementation** | 2019 | GF(2^{10}) + PBKDF2 | First hardware wallet with native SLIP-39 support; passphrase mixed via PBKDF2 before Shamir splitting to prevent offline brute force; open-source reference implementation [[1]](https://trezor.io/learn/a/what-is-shamir-backup) |
| **SSKR (Sharded Secret Key Reconstruction)** | 2020 | GF(256) + bytewords | Blockchain Commons variant of SLIP-39 using GF(2^8) and byteword encoding; compatible with CBOR/UR type system; adopted by Gordian ecosystem [[1]](https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-011-sskr.md) |

**State of the art:** SLIP-39 is the dominant standard for mnemonic-based threshold seed backup; implemented in Trezor firmware, Ian Coleman's tool, and the `shamir-mnemonic` Python library. SSKR offers an alternative encoding for the Gordian/UR ecosystem. Both use Shamir over small-characteristic fields (GF(2^8) or GF(2^{10})) for byte-oriented efficiency — contrasting with the prime-field GF(p) arithmetic in Shamir's original paper. Distinct from [XOR-Based SS](#xor-based--binary-field-secret-sharing) (no threshold, just split) and the standalone SLIP-39 entry in [Key Management](03-key-exchange-key-management.md). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Production
SLIP-39 is deployed in Trezor Model T firmware and multiple wallet tools; SSKR is deployed in the Gordian ecosystem.

**Implementations:**
- [trezor/python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, reference SLIP-39 implementation
- [BlockchainCommons/bc-sskr](https://github.com/BlockchainCommons/bc-sskr) ⭐ 22 — C, SSKR (Sharded Secret Key Reconstruction)
- [AshKyd/iancoleman-slip39](https://iancoleman.io/slip39/) — Web tool, SLIP-39 share generation
- [AshKyd/slip39-js](https://github.com/ilap/slip39-js) ⭐ 81 — JavaScript, SLIP-39 for web wallets

**Security status:** Secure
Information-theoretically secure (Shamir over GF(2^10)); PBKDF2 passphrase mixing prevents offline brute force; RS checksum detects transcription errors.

**Community acceptance:** Standard
SLIP-39 is the dominant standard for mnemonic threshold backup in the cryptocurrency ecosystem; endorsed by SatoshiLabs and implemented in major wallets.

---

### Secret Sharing over Non-Abelian Groups

**Goal:** Secret sharing using non-commutative algebraic structures. Replace the underlying abelian group (or field) in Shamir/LSSS with a non-abelian group — opening new design possibilities, stronger security models against quantum adversaries (non-abelian hidden subgroup problem is harder), and connections to group-theoretic cryptography.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Desmedt-Pieprzyk Non-Abelian SS** | 1994 | Permutation groups | First non-abelian SS; shares are elements of a symmetric group S_n; reconstruction via group-theoretic interpolation; information-theoretic security [[1]](https://doi.org/10.1007/BFb0053451) |
| **Algebraic Geometric SS (Chen-Cramer)** | 2006 | Algebraic geometry codes | Generalized algebraic SS using algebraic curves over non-prime fields; extends LSSS to broader algebraic structures [[1]](https://link.springer.com/chapter/10.1007/11818175_32) |
| **Habeeb-Kahrobaei-Shpilrain** | 2012 | Semidirect product groups | SS using semidirect products of non-abelian groups; share reconstruction via non-commutative group operations; proposed as quantum-resistant [[1]](https://doi.org/10.1515/gcc-2012-0006) |
| **Braid Group SS** | 2006 | Braid groups + conjugacy | Uses the conjugacy problem in braid groups; shares are braid words; non-abelian structure resists quantum Fourier sampling attacks [[1]](https://doi.org/10.1007/11889342_20) |

**State of the art:** Non-abelian SS remains primarily theoretical; no schemes have seen practical deployment. Interest is driven by potential quantum resistance (the non-abelian hidden subgroup problem is believed hard for quantum computers, unlike Shor-vulnerable abelian groups). Semidirect product and braid group constructions are the most studied. Extends [Secret Sharing](#secret-sharing-schemes-sss); relates to post-quantum motivations in [Post-Quantum Cryptography](15-quantum-cryptography.md#post-quantum-cryptography).

**Production readiness:** Research
Purely theoretical; no implementations or practical deployments exist.

**Implementations:**
- No open-source implementations available; constructions are described in academic papers only.

**Security status:** Caution
Security relies on non-abelian group-theoretic assumptions (conjugacy problem, hidden subgroup problem) that are less well-studied than standard assumptions; some braid group assumptions have been weakened.

**Community acceptance:** Niche
Of interest to algebraic cryptography and post-quantum researchers; no mainstream adoption or standardization efforts.

---


## Threshold Cryptography

---
### Threshold Decryption

**Goal:** Distributed confidentiality. *t-of-n* parties jointly decrypt a ciphertext without any single party reconstructing the full private key. Complement to Threshold Signatures for the encryption side.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold ElGamal** | 1994 | DDH + Shamir SSS | Classic; partial decryptions combined [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_3) |
| **Threshold RSA (Shoup)** | 2000 | RSA + VSS | Secure threshold RSA decryption [[1]](https://eprint.iacr.org/1999/011) |
| **PVSS-based Threshold Dec.** | 2001 | PVSS + ElGamal | Publicly verifiable shares; no trusted dealer [[1]](https://eprint.iacr.org/1999/041) |
| **TPKE (Threshold BLS Enc.)** | 2020 | Pairings + Shamir | Non-interactive; used in Ethereum DVT, Dusk Network [[1]](https://eprint.iacr.org/2021/339) |
| **Pilvi (Lattice Threshold PKE)** | 2025 | LWE | Post-quantum threshold PKE with small decryption shares; simulation-based security; ASIACRYPT 2025 [[1]](https://eprint.iacr.org/2025/1691) |

**State of the art:** Threshold ElGamal (general), TPKE (blockchain applications, DVT), Pilvi (PQ-secure, 2025).

**Production readiness:** Mature
Threshold ElGamal is deployed in e-voting systems; TPKE is used in Ethereum DVT and Dusk Network; Pilvi is research-stage.

**Implementations:**
- [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) ⭐ 201 — Rust, threshold BLS encryption/decryption
- [tpke (Nucypher)](https://github.com/nucypher/ferveo) ⭐ 5 — Rust, threshold PKE for blockchain
- [ArteMisc/libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, threshold ElGamal primitives

**Security status:** Secure
Threshold ElGamal secure under DDH; TPKE secure under pairing assumptions; Pilvi secure under LWE (post-quantum).

**Community acceptance:** Widely trusted
Threshold ElGamal is a textbook construction; TPKE is deployed in major blockchain systems; Pilvi is an emerging post-quantum candidate.

---

### Distributed Key Generation (DKG)

**Goal:** Availability + distributed trust. Generate a threshold public/private keypair among *n* parties so that no single party — nor any coalition below threshold *t* — ever knows the full private key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen DKG** | 1991 | VSS + commitments | Simple, widely deployed; not robust against rushing [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **GJKR DKG** | 1999 | VSS + ZK | Provably secure; handles malicious parties [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_10) |
| **Aggregatable DKG** | 2020 | KZG + pairings | O(n log n) communication; scalable to thousands of nodes [[1]](https://eprint.iacr.org/2021/005) |
| **FROST DKG** | 2020 | Schnorr + VSS | Designed to pair with FROST threshold signing [[1]](https://eprint.iacr.org/2020/852) |

**State of the art:** Aggregatable DKG (large-scale blockchains), GJKR (security-critical threshold systems).

**Production readiness:** Production
Pedersen DKG and GJKR are deployed in drand, Ethereum DVT, and threshold wallet systems; FROST DKG is in production via Zcash and Safe.

**Implementations:**
- [drand/kyber](https://github.com/drand/kyber) ⭐ 10 — Go, Pedersen and GJKR DKG for drand beacon
- [ZcashFoundation/frost](https://github.com/ZcashFoundation/frost) ⭐ 250 — Rust, FROST DKG
- [celo-org/celo-threshold-bls-rs](https://github.com/celo-org/celo-threshold-bls-rs) ⭐ 81 — Rust, aggregatable DKG for Celo
- [dfinity/ic](https://github.com/dfinity/ic) ⭐ 1.7k — Rust, NIDKG for Internet Computer

**Security status:** Secure
GJKR DKG is provably secure against malicious adversaries; Pedersen DKG is secure against passive adversaries but vulnerable to rushing attacks; FROST DKG secure under DL.

**Community acceptance:** Standard
FROST DKG is part of IETF RFC 9591; Pedersen/GJKR are textbook constructions; Aggregatable DKG is endorsed by Ethereum and Celo research teams.

---

### Non-Interactive DKG (NIDKG)

**Goal:** One-round distributed key generation. Generate a shared public key and individual secret key shares in a single broadcast round — no back-and-forth communication. Critical for blockchain protocols where interactive rounds are expensive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth NIDKG** | 2021 | Pairings + NIZK | Non-interactive; publicly verifiable; O(n) transcript size [[1]](https://eprint.iacr.org/2021/339) |
| **Gurkan et al. NIDKG** | 2021 | KZG + gossip | Aggregatable DKG; used in Celo blockchain [[1]](https://eprint.iacr.org/2021/005) |
| **Groth-Shoup NIDKG** | 2022 | Forward-secure enc | Used in Internet Computer (DFINITY); asynchronous, robust [[1]](https://eprint.iacr.org/2022/087) |

**State of the art:** Groth-Shoup NIDKG (DFINITY/Internet Computer); Gurkan et al. (Celo). Extends [DKG](#distributed-key-generation-dkg) to non-interactive setting.

**Production readiness:** Production
Groth-Shoup NIDKG is deployed in the Internet Computer (DFINITY) mainnet; Gurkan et al. is deployed in Celo blockchain.

**Implementations:**
- [dfinity/ic](https://github.com/dfinity/ic) ⭐ 1.7k — Rust, Groth-Shoup NIDKG for Internet Computer
- [celo-org/celo-threshold-bls-rs](https://github.com/celo-org/celo-threshold-bls-rs) ⭐ 81 — Rust, aggregatable NIDKG for Celo
- [kobigurk/aggregatable-dkg](https://github.com/kobigurk/aggregatable-dkg) ⭐ 49 — Rust, Gurkan et al. NIDKG

**Security status:** Secure
Groth-Shoup NIDKG is provably secure under pairing and forward-secure encryption assumptions; Gurkan et al. secure under KZG assumptions.

**Community acceptance:** Emerging
Deployed in two major blockchain platforms; gaining broader recognition as the standard for non-interactive DKG.

---

### Universal Thresholdizer

**Goal:** Generic threshold compiler. Take any cryptographic scheme (encryption, signatures, PRF, VRF, etc.) and automatically convert it into a threshold version — without designing a bespoke threshold protocol for each primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Komlo Universal Thresholdizer** | 2023 | FHE + threshold decryption | Threshold any scheme: parties jointly FHE-evaluate the scheme, then threshold-decrypt [[1]](https://eprint.iacr.org/2023/636) |
| **Shoup-Smart Threshold Paradigm** | 2000 | Threshold decryption | Template: each party applies its key share, combine partial results [[1]](https://eprint.iacr.org/2000/016) |
| **Damgård-Koprowski Threshold RSA** | 2001 | RSA shares | Generic threshold RSA from any RSA-based scheme [[1]](https://eprint.iacr.org/2001/044) |

**State of the art:** Boneh-Komlo (2023) via FHE: truly universal but expensive; practical threshold schemes remain bespoke (see [TSS](08-signatures-advanced.md#threshold-signature-schemes-tss), [Threshold Decryption](#threshold-decryption)).

**Production readiness:** Research
Universal thresholdizer via FHE is a theoretical construction; no production deployments exist due to FHE overhead.

**Implementations:**
- [zama-ai/tfhe-rs](https://github.com/zama-ai/tfhe-rs) ⭐ 1.6k — Rust, TFHE library that could serve as a building block for universal thresholdizer
- No standalone open-source implementation of the Boneh-Komlo universal thresholdizer exists yet.

**Security status:** Secure
Security reduces to the underlying FHE and threshold decryption schemes; no direct attacks on the framework.

**Community acceptance:** Niche
Theoretically important result from top cryptographers (Boneh, Komlo); practical adoption blocked by FHE performance.

---

### FROST: Flexible Round-Optimized Schnorr Threshold Signatures

**Goal:** Two-round threshold Schnorr signing. Any t-of-n signers collaboratively produce a single valid Schnorr signature in two communication rounds, with the signing key never reconstructed — removing the single point of failure from traditional multisig and threshold schemes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FROST (Komlo-Goldberg)** | 2020 | Schnorr + Shamir VSS | Original protocol; 2-round signing or 1-round with preprocessing; concurrent sessions secure under DL; SAC 2020 [[1]](https://eprint.iacr.org/2020/852) |
| **FROST3 (Security proof)** | 2023 | Schnorr, no AGM | First proof without the Algebraic Group Model; tighter reduction; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/899) |
| **FROST RFC 9591** | 2024 | Schnorr | IETF/CFRG standardization (June 2024); specifies multiple ciphersuites (secp256k1, Ed25519, Ed448, P-256, Ristretto255) [[1]](https://www.rfc-editor.org/rfc/rfc9591.html) |
| **Re-Randomized FROST** | 2024 | Schnorr + rerandomization | Preserves unlinkability of RedDSA spend-auth signatures in Zcash; production deployment via ZIP 312 [[1]](https://eprint.iacr.org/2024/436) |
| **Dynamic-FROST** | 2024 | FROST + committee changes | Supports adding/removing signers and resharing without a full key ceremony [[1]](https://eprint.iacr.org/2024/896) |

**State of the art:** FROST RFC 9591 (2024) is the IETF standard; deployed in production by the Zcash Foundation (ZIP 312, NU6 2024) and integrated into Safe smart accounts on Ethereum. The FROST DKG companion protocol lives in [DKG](#distributed-key-generation-dkg). Related to [Threshold Signature Schemes](08-signatures-advanced.md#threshold-signature-schemes-tss) in the signatures category.

**Production readiness:** Production
FROST is standardized (IETF RFC 9591) and deployed in Zcash (ZIP 312), Safe smart accounts, and multiple threshold wallet implementations.

**Implementations:**
- [ZcashFoundation/frost](https://github.com/ZcashFoundation/frost) ⭐ 250 — Rust, reference implementation of RFC 9591 with multiple ciphersuites
- [jesseposner/FROST-BIP340](https://github.com/jesseposner/FROST-BIP340) ⭐ 49 — C, FROST for Bitcoin Schnorr (BIP-340)
- [LIT-Protocol/frost-ts](https://github.com/isislovecruft/frost-dalek) ⭐ 72 — Rust, FROST on Ristretto255
- [cryspen/frost](https://github.com/taurushq-io/frost-ed25519) ⭐ 75 — Rust, FROST for Ed25519

**Security status:** Secure
Provably secure under DL assumption; FROST3 (CRYPTO 2023) provides a proof without the AGM; RFC 9591 specifies secure ciphersuites.

**Community acceptance:** Standard
IETF RFC 9591 (June 2024); endorsed by CFRG; deployed by Zcash Foundation and integrated into Ethereum ecosystem.

---

### Threshold Raccoon: Post-Quantum Lattice Threshold Signatures

**Goal:** Post-quantum threshold signing. Any t-of-n parties collaboratively produce a lattice-based Schnorr-like signature secure under MLWE/MSIS — the first efficient lattice threshold signature that does not require threshold FHE or homomorphic trapdoor commitments, and is compatible with NIST-standardized ML-DSA (Dilithium).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold Raccoon** | 2024 | MLWE + MSIS + OTM | Pairwise one-time additive masks (OTM) hide partial responses; 13 KiB signatures; up to 1024 signers; EUROCRYPT 2024 [[1]](https://eprint.iacr.org/2024/184) |
| **ML-DSA Threshold (del Pino et al.)** | 2025 | ML-DSA (FIPS 204) | Directly adapts Raccoon technique to standardized ML-DSA; supports up to 6 signers; CRYPTO 2025 [[1]](https://eprint.iacr.org/2025/1166) |
| **Olingo** | 2025 | Lattice + DKG + IA | Adds integrated DKG and identifiable abort to lattice threshold signing; first full-stack PQ threshold signature [[1]](https://eprint.iacr.org/2025/1789) |

**State of the art:** Threshold Raccoon (EUROCRYPT 2024) is the first practical post-quantum threshold signature; its ML-DSA variant (2025) enables drop-in PQ threshold signing against FIPS 204. Open problem: reduce communication cost and achieve one-round signing. Complements [FROST](#frost-flexible-round-optimized-schnorr-threshold-signatures) (classical) and relates to [Post-Quantum Cryptography](15-quantum-cryptography.md#post-quantum-cryptography).

**Production readiness:** Experimental
Threshold Raccoon has working prototypes; ML-DSA threshold variant (2025) is pre-production; Olingo is a recent research result.

**Implementations:**
- No standalone open-source implementations widely available yet; reference code accompanies the EUROCRYPT 2024 paper.

**Security status:** Secure
Provably secure under MLWE/MSIS assumptions; post-quantum security against known quantum attacks.

**Community acceptance:** Emerging
Published at EUROCRYPT 2024 (top venue); ML-DSA variant targets FIPS 204 compatibility; high interest from the PQ community.

---

### Threshold BLS Key Generation

**Goal:** Distributed BLS keypair setup. Generate a BLS private key sk and corresponding public key pk = g^sk among n parties via a joint DKG so that any t-of-n parties can subsequently co-sign (producing a single valid BLS signature) without any party ever holding sk in full. Combines [DKG](#distributed-key-generation-dkg) with the algebraic structure of BLS signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Joint-Feldman DKG for BLS** | 1991 | Feldman VSS | Each party runs Feldman VSS and contributes an additive share; standard in practice; not secure against a rushing adversary biasing the public key [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **GJKR Threshold BLS DKG** | 1999 | VSS + ZK disqualification | Provably secure DKG suitable for BLS; malicious parties are disqualified via complaint rounds; CRYPTO 1999 [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_10) |
| **Aggregatable PVSS DKG for BLS** | 2021 | KZG + pairings | Single-round DKG producing a threshold BLS keypair; O(n log n) communication; deployed in Ethereum DVT and drand randomness beacon [[1]](https://eprint.iacr.org/2021/339) |
| **drand Threshold BLS** | 2020 | GJKR + BLS12-381 | Production deployment: threshold BLS randomness beacon; 20+ nodes operated by Cloudflare, EPFL, Protocol Labs; beacon output used in Filecoin and Ethereum [[1]](https://eprint.iacr.org/2020/1645) |
| **Ethereum DVT (EIP-7441)** | 2024 | Aggregatable DKG + BLS | Distributed validator technology; threshold BLS keygen for Ethereum validators eliminates single-point-of-failure in staking [[1]](https://eips.ethereum.org/EIPS/eip-7441) |

**State of the art:** Aggregatable PVSS DKG (2021) is the most communication-efficient threshold BLS keygen; deployed in drand and Ethereum DVT. Builds on [DKG](#distributed-key-generation-dkg) and [PVSS](#publicly-verifiable-secret-sharing-pvss); produces keys for [BLS Aggregate Signatures](08-signatures-advanced.md#aggregate-signatures-bls-aggregate).

**Production readiness:** Production
Threshold BLS DKG is deployed in drand (League of Entropy) and Ethereum DVT; production-grade implementations exist.

**Implementations:**
- [drand/drand](https://github.com/drand/drand) ⭐ 813 — Go, threshold BLS randomness beacon with DKG
- [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) ⭐ 201 — Rust, threshold BLS keygen and signing
- [Obol-Network/charon](https://github.com/ObolNetwork/charon) ⭐ 219 — Go, Ethereum DVT with threshold BLS

**Security status:** Secure
Secure under pairing assumptions (BLS12-381); Aggregatable DKG provides public verifiability; drand has been audited.

**Community acceptance:** Standard
drand is operated by the League of Entropy (Cloudflare, EPFL, Protocol Labs); Ethereum DVT is an endorsed scaling approach.

---

### Online vs Offline Threshold Signing

**Goal:** Amortize expensive threshold signing costs. Split threshold signature protocols into an *offline* phase (no message needed; run during idle time) and an *online* phase (message-dependent; ultra-low latency). The offline phase precomputes nonces, Beaver triples, or presignatures; the online phase uses them to sign in one or two rounds with minimal computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FROST Offline Precomputation** | 2020 | Schnorr + nonce pairs | FROST's 1.5-round mode: each party pre-broadcasts (D_i, E_i) binding nonce commitments; online phase = 1 message per party; eliminates one full round trip at signing time [[1]](https://eprint.iacr.org/2020/852) |
| **Threshold ECDSA Presignature (GG18/GG20)** | 2018 | Paillier HE + offline MtA | GG18/GG20 split into offline (MtA for multiplicative-to-additive conversion; presignature r) and online (one round to complete s-share); offline cost dominates by ~100× [[1]](https://eprint.iacr.org/2019/114) |
| **Lindell Offline-Online 2-Party ECDSA** | 2017 | OT + Paillier | First explicit offline/online separation for 2-of-2 ECDSA; online phase = 2 messages, ~1 ms; offline = 3 s; IEEE S&P 2017 [[1]](https://eprint.iacr.org/2017/552) |
| **DKLS23 Offline/Online** | 2023 | OT + MtA | Explicit offline/online decomposition for t-of-n ECDSA; offline generates nonce and correlated randomness; online = one round; avoids HE entirely [[1]](https://eprint.iacr.org/2023/765) |
| **Threshold Raccoon Offline Masks** | 2024 | OTM (one-time masks) | Lattice threshold signing: offline phase distributes one-time additive masks; online phase requires only local computation + broadcast; EUROCRYPT 2024 [[1]](https://eprint.iacr.org/2024/184) |

**State of the art:** Offline/online separation is universal in practical threshold signing deployments — the offline phase is run in the background, amortizing expensive MPC sub-protocols so that online signing latency is sub-second. FROST (Schnorr), DKLS23 (ECDSA), and Threshold Raccoon (post-quantum) all support this pattern. Relates to [FROST](#frost-flexible-round-optimized-schnorr-threshold-signatures), [DKLS23](#dkls23-threshold-ecdsa-in-three-rounds), [Threshold Raccoon](#threshold-raccoon-post-quantum-lattice-threshold-signatures), and [MPC Preprocessing](06-multi-party-computation.md#multi-party-computation-mpc).

**Production readiness:** Production
Offline/online decomposition is used in all production threshold signing systems (FROST, GG18/GG20, DKLS23).

**Implementations:**
- [ZcashFoundation/frost](https://github.com/ZcashFoundation/frost) ⭐ 250 — Rust, FROST with offline nonce precomputation
- [ZenGo-X/multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) ⭐ 1.1k — Rust, GG18/GG20 offline/online ECDSA
- [bnb-chain/tss-lib](https://github.com/bnb-chain/tss-lib) ⭐ 1.0k — Go, threshold signing with offline preprocessing

**Security status:** Secure
Security of offline/online decomposition is established by the underlying threshold signing protocol proofs; no additional assumptions required.

**Community acceptance:** Widely trusted
Universal design pattern in threshold cryptography; every major threshold signing system uses offline/online separation.

---

### Witness Encryption for Secret Sharing Policies

**Goal:** Encrypt to an NP statement rather than a key. A witness encryption (WE) scheme allows encrypting a message so that decryption succeeds if and only if the decryptor can produce a witness for a specified NP statement x ∈ L. Applied to secret sharing: encrypt the secret so that any qualified set of participants (whose combined inputs satisfy an NP relation) can jointly decrypt — generalizing threshold decryption to arbitrary NP access policies without a dealer or key distribution.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Witness Encryption (Garg-Gentry-Halevi-Sahai-Waters)** | 2013 | Multilinear maps (GGH) | First construction; encrypt to SAT instance; decryptors with a satisfying assignment recover plaintext; security conjectured from multilinear maps [[1]](https://eprint.iacr.org/2013/258) |
| **WE from Pairings (Benhamouda-Lin)** | 2020 | Pairings + DLIN | Efficient WE for specific NP languages (pairing-product equations); practical for threshold and attribute-based policies without general multilinear maps [[1]](https://eprint.iacr.org/2020/1510) |
| **WE for Secret Sharing Policies** | 2023 | Lattice-based WE | Encrypts under a monotone access structure expressed as an NP statement; lattice-based construction; parties with qualifying shares provide witnesses; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/1264) |
| **WE from eVRF** | 2024 | Extractable VRF | Constructs WE from extractable VRFs; practical for threshold decryption policies tied to randomness beacon outputs [[1]](https://eprint.iacr.org/2024/1204) |

**State of the art:** Witness encryption remains theoretically powerful but practically limited — general constructions rely on multilinear maps or iO (see [Obfuscation](16-obfuscation-advanced-hardness.md#indistinguishability-obfuscation-io)). Pairing-based WE (2020) is the most practical for structured policies. For threshold access specifically, [Threshold Decryption](#threshold-decryption) and [ABE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption) are preferred today. WE subsumes both and connects to [Witness Encryption](16-obfuscation-advanced-hardness.md#witness-encryption) in the obfuscation category.

**Production readiness:** Research
General witness encryption relies on uninstantiated assumptions (multilinear maps/iO); pairing-based WE for restricted languages is experimental.

**Implementations:**
- No production-quality implementations of general witness encryption exist; pairing-based WE for specific languages has research prototypes.

**Security status:** Caution
General WE security relies on multilinear maps (known attacks on candidates) or iO (no efficient construction); pairing-based WE for restricted languages is secure under DLIN.

**Community acceptance:** Controversial
Theoretically groundbreaking (GGHSW 2013 is highly cited); practical security of general constructions remains disputed due to multilinear map vulnerabilities.

---


## Verifiable and Proactive Secret Sharing

---
### Proactive Secret Sharing

**Goal:** Long-term threshold security. Periodically refresh secret shares without changing the secret — so an adversary who compromises different parties in different time periods never accumulates enough shares. Defends against "mobile adversaries."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Herzberg-Jarecki-Krawczyk-Yung (HJKY)** | 1995 | Shamir + rerandomization | First proactive SS; parties jointly rerandomize shares each epoch [[1]](https://doi.org/10.1007/3-540-44750-4_27) |
| **Proactive RSA (Frankel et al.)** | 1997 | RSA threshold | Proactive threshold RSA signatures; share refresh without new key [[1]](https://doi.org/10.1007/BFb0052253) |
| **CHURP** | 2019 | Bivariate polynomials | Proactive SS with dynamic committee changes; Byzantine-tolerant [[1]](https://eprint.iacr.org/2019/017) |
| **Proactive Refresh for BLS** | 2022 | BLS threshold | Refresh threshold BLS shares; used in Ethereum validator key management [[1]](https://eprint.iacr.org/2022/898) |

**State of the art:** CHURP (2019) for dynamic committees; proactive BLS for blockchain validators. Extends [Secret Sharing](#secret-sharing-schemes-sss) and [DKG](#distributed-key-generation-dkg).

**Production readiness:** Experimental
CHURP is implemented as a research prototype; proactive BLS refresh is used in Ethereum validator key management but not yet widely standardized.

**Implementations:**
- [oasisprotocol/oasis-core](https://github.com/oasisprotocol/oasis-core) ⭐ 369 — Go/Rust, CHURP implementation for Oasis Network
- [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) ⭐ 201 — Rust, share refresh primitives
- [AIT-DKMS/proactive-refresh](https://github.com/lyronctk/proactive-refresh) ⭐ 36 — Rust, proactive share refresh

**Security status:** Secure
CHURP is provably secure under bivariate polynomial assumptions with Byzantine tolerance; proactive SS is information-theoretically secure assuming honest majority per epoch.

**Community acceptance:** Emerging
CHURP is well-cited in the blockchain research community; proactive BLS refresh is gaining traction with Ethereum DVT adoption.

---

### Asynchronous Verifiable Secret Sharing (AVSS)

**Goal:** VSS without timing assumptions. The dealer shares a secret so that (1) all honest parties eventually receive valid shares, (2) a unique secret is determined even if the dealer is malicious, (3) no synchrony assumptions — messages can be arbitrarily delayed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Rabin AVSS** | 1993 | Bivariate polynomials | First AVSS; information-theoretic; t < n/3 [[1]](https://doi.org/10.1145/167088.167109) |
| **Cachin-Kursawe-Petzold-Shoup (CKPS)** | 2002 | Pedersen + pairings | Practical AVSS; O(n²) messages; used in async DKG [[1]](https://eprint.iacr.org/2002/134) |
| **Abraham-Chow-Goldfeder-Hazay AVSS** | 2021 | KZG commitments | O(n log n) communication; optimal async VSS [[1]](https://eprint.iacr.org/2021/118) |
| **Haven (Das et al.)** | 2023 | Polynomial eval + async | High-throughput AVSS for async DKG and MPC [[1]](https://eprint.iacr.org/2023/1762) |

**State of the art:** KZG-based AVSS (2021+) for optimal communication; essential for [Async BFT](#asynchronous-verifiable-secret-sharing-avss) and [DKG](#distributed-key-generation-dkg).

**Production readiness:** Experimental
CKPS AVSS is used in async DKG prototypes; KZG-based AVSS is implemented in research systems; Haven is a recent research prototype.

**Implementations:**
- [sourav1547/vss](https://github.com/sourav1547/vss) ⭐ 5 — Rust, high-throughput AVSS (Haven)
- [consensusnetworks/dumbo](https://github.com/tyurek/hbACSS) ⭐ 5 — Python, async complete secret sharing (hbACSS)
- [ISTA-SPiDerS/dpss](https://github.com/timothykim/dpss) ⭐ 4 — Go, async VSS and DKG protocols

**Security status:** Secure
Information-theoretically or computationally secure (depending on variant) for t < n/3; no known attacks on standard constructions.

**Community acceptance:** Emerging
KZG-based AVSS is gaining attention in the async BFT and blockchain communities; foundational for next-generation async protocols.

---

### Traceable Secret Sharing

**Goal:** Leak deterrence for secret shares. If shareholders sell or leak their shares, a tracing algorithm can identify which shares were leaked — even when up to t shareholders collude. A new security property beyond [cheater detection](#secret-sharing-with-cheater-detection) or [robust SS](#robust-secret-sharing).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Partap-Rotem Traceable SS** | 2024 | Fingerprinting + Shamir | First traceable SS; tracing key identifies leaked shares; CRYPTO 2024 [[1]](https://eprint.iacr.org/2024/405) |
| **Traceable SS for General Access** | 2024 | LSSS + tracing | Extension to general access structures (beyond threshold) [[1]](https://eprint.iacr.org/2024/405) |
| **Bottom-Up Traceable SS** | 2025 | Social key recovery | Users self-assign shares; tracing in community key recovery model [[1]](https://eprint.iacr.org/2025/2089) |
| **TVSS (Traceable Verifiable SS)** | 2025 | Feldman/Pedersen + tracing | Combines traceability with verifiability against malicious dealers [[1]](https://eprint.iacr.org/2025/318) |
| **TSS-PV (Public Verifiability)** | 2025 | Indistinguishable dummy shares | First publicly verifiable traceable SS; resolves "Provenance Paradox" [[1]](https://eprint.iacr.org/2025/2261) |

**State of the art:** Boneh-Partap-Rotem (CRYPTO 2024), TVSS (2025), TSS-PV (2025); new security dimension for [Secret Sharing](#secret-sharing-schemes-sss). Analogous to [traitor tracing](#threshold-decryption) but for secret sharing.

**Production readiness:** Research
All traceable SS constructions are recent academic results (2024-2025); no production implementations yet.

**Implementations:**
- No standalone open-source implementations available yet; reference implementations may accompany the CRYPTO 2024 and ePrint papers.

**Security status:** Secure
Security proofs are rigorous under standard assumptions; tracing is information-theoretically or computationally guaranteed depending on the variant.

**Community acceptance:** Emerging
Published at top venues (CRYPTO 2024); rapidly growing area with multiple 2025 follow-up works; expected to gain traction for compliance-sensitive applications.

---

### SCRAPE: Scalable Publicly Verifiable Secret Sharing

**Goal:** O(n) verification PVSS. Standard PVSS (Schoenmakers 1999) requires each verifier to check n independent ZK proofs — O(n) exponentiations per participant, O(n²) total across all verifiers. SCRAPE achieves O(n) total verification by replacing per-share proofs with a single aggregated check based on the dual code of a Reed-Solomon code, while preserving public verifiability and information-theoretic secrecy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schoenmakers PVSS** | 1999 | DLP + DLEQ ZK | Baseline: n individual DLEQ proofs; O(n) exponentiations per verifier, O(n²) total; widely deployed [[1]](https://www.win.tue.nl/~berry/papers/crypto99.pdf) |
| **SCRAPE (Cascudo-David)** | 2017 | Reed-Solomon dual codes | Single aggregated check via dual RS code; O(n) total exponentiations across all verifiers; information-theoretic security under DL; PKC 2017 [[1]](https://eprint.iacr.org/2017/216) |
| **HydRand** | 2020 | SCRAPE + BFT | Deploys SCRAPE in a publicly verifiable randomness beacon; O(n) on-chain verification cost; Ethereum beacon inspiration [[1]](https://eprint.iacr.org/2020/378) |
| **Batchable SCRAPE** | 2022 | SCRAPE + batch ZK | Amortizes multiple SCRAPE instances (multiple epochs) to constant overhead per additional instance; suited for periodic beacon protocols [[1]](https://eprint.iacr.org/2022/1585) |

**State of the art:** SCRAPE (2017) is the standard choice for on-chain or bandwidth-constrained PVSS; deployed in randomness beacons (HydRand, Albatross) and [DKG](#distributed-key-generation-dkg) protocols. Extends [Publicly Verifiable SS](#publicly-verifiable-secret-sharing-pvss).

**Production readiness:** Production
SCRAPE is deployed in HydRand randomness beacon and Nimiq Albatross consensus; used in multiple blockchain PVSS systems.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Information-theoretically secure under DL assumption; O(n) total verification cost is provably optimal for PVSS.

**Community acceptance:** Widely trusted
Standard PVSS construction for blockchain randomness beacons; well-cited (PKC 2017); deployed in multiple systems.

---


## Advanced Secret Sharing

---
### Unclonable Secret Sharing

**Goal:** Secret sharing where quantum shares cannot be cloned. If a shareholder tries to duplicate their quantum share, at least one copy becomes useless for reconstruction. Prevents share proliferation — a new quantum security property for [Secret Sharing](#secret-sharing-schemes-sss).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Unclonable Secret Sharing** | 2024 | Quantum no-cloning | First USS; quantum shares; even t colluding shareholders cannot produce extra working copies [[1]](https://eprint.iacr.org/2024/716) |
| **Unclonable Encryption** | 2023 | Quantum (plain model) | Related: ciphertext can only be decrypted once; constructed without quantum RO [[1]](https://eprint.iacr.org/2023/1825) |

**State of the art:** USS (2024); extends [Quantum Copy-Protection](15-quantum-cryptography.md#quantum-copy-protection--uncloneable-encryption) to the secret sharing domain.

**Production readiness:** Research
Purely theoretical; requires quantum hardware for share distribution and storage; no implementations exist.

**Implementations:**
- No implementations available; constructions rely on quantum no-cloning and are not realizable on current hardware at scale.

**Security status:** Secure
Security relies on fundamental quantum no-cloning theorem; information-theoretically secure in the quantum model.

**Community acceptance:** Niche
Novel concept at the intersection of quantum information and secret sharing; published at top venues but limited to the quantum cryptography community.

---

### Evolving Secret Sharing

**Goal:** Unbounded participants. Share a secret so that new participants can be added indefinitely — without reissuing existing shares and without knowing the total number of participants in advance. Share sizes grow slowly (polylog) with the participant index.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Komargodski-Naor-Yogev Evolving SS** | 2016 | Binary tree + prefix codes | First evolving SS; t-threshold with polylog share size growth [[1]](https://eprint.iacr.org/2016/194) |
| **Evolving SS with Small Shares** | 2017 | Improved construction | Optimized share sizes; O(t · log² i) bits for i-th participant [[1]](https://eprint.iacr.org/2017/510) |
| **Dynamic Evolving SS** | 2020 | Tree-based | Add participants AND update threshold over time [[1]](https://eprint.iacr.org/2020/789) |

**State of the art:** Evolving SS (Komargodski et al. 2016+); useful for long-lived systems where participant set is unknown at setup. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Research
Academic constructions only; no production-quality implementations or real-world deployments.

**Implementations:**
- No standalone open-source implementations; constructions are described in academic papers.

**Security status:** Secure
Information-theoretically secure; share size grows polylogarithmically with participant index.

**Community acceptance:** Niche
Theoretically elegant solution to unbounded-participant sharing; limited practical adoption due to growing share sizes and specialized use case.

---

### Secret Sharing with Cheater Detection

**Goal:** Tamper detection during reconstruction. If a participant submits a forged or modified share, the reconstruction algorithm detects the fraud (cheater detection) or identifies the cheater (cheater identification) — rather than silently outputting a wrong secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tompa-Woll Cheater Detection** | 1988 | Redundant shares | First cheater-detectable SS; honest majority can detect forged shares [[1]](https://doi.org/10.1007/0-387-34799-2_20) |
| **McEliece-Sarwate (error-correcting)** | 1981 | Reed-Solomon | Shamir SS as Reed-Solomon code; detect/correct errors via decoding [[1]](https://doi.org/10.1145/360363.360369) |
| **Cheater Identifiable SS (Ishai-Sahai)** | 2006 | MAC-based | Identify exactly which participants cheated; optimal cheater tolerance [[1]](https://eprint.iacr.org/2006/140) |
| **Unconditionally Secure Cheater Detection (Ogata et al.)** | 2005 | Information-theoretic | Optimal share size with information-theoretic cheater detection [[1]](https://doi.org/10.1007/978-3-540-30576-7_5) |

**State of the art:** MAC-based cheater identification (Ishai-Sahai 2006); used in malicious-secure [MPC](06-multi-party-computation.md#multi-party-computation-mpc). Extends [Secret Sharing](#secret-sharing-schemes-sss), complements [Robust SS](#robust-secret-sharing).

**Production readiness:** Mature
Cheater detection is integrated into production MPC frameworks (SPDZ, MP-SPDZ) via MAC-based verification.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, MAC-based cheater detection in malicious-secure MPC
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, cheater detection via information-theoretic MACs

**Security status:** Secure
Information-theoretically secure cheater detection; optimal share size bounds are well-established.

**Community acceptance:** Widely trusted
Core component of malicious-secure MPC protocols; MAC-based approach is the de facto standard.

---

### Verifiable Information Dispersal (VID)

**Goal:** Reliable data distribution with verification. A dealer encodes data into N shares using erasure coding; each recipient can verify they received a valid share without reconstructing the full data. Foundation of blockchain data availability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cachin-Tessaro VID** | 2005 | Reed-Solomon + hash | Original VID; Byzantine-tolerant dispersal with verification [[1]](https://doi.org/10.1109/RELDIS.2005.5) |
| **AVID (Async VID, Hendricks et al.)** | 2007 | Erasure codes + Merkle | Asynchronous protocol; O(n|M|) total communication [[1]](https://doi.org/10.1145/1281100.1281131) |
| **DispersedLedger** | 2022 | VID + BFT consensus | VID integrated into BFT; separate data from consensus [[1]](https://eprint.iacr.org/2021/868) |
| **EigenDA VID** | 2024 | KZG + RS codes | KZG-committed VID for Ethereum rollup data availability [[1]](https://docs.eigenlayer.xyz/eigenda/overview) |

**State of the art:** KZG-based VID (EigenDA, Ethereum danksharding); closely related to [DAS](13-blockchain-distributed-ledger.md#data-availability-sampling-das) and [Commitment Schemes](09-commitments-verifiability.md#commitment-schemes).

**Production readiness:** Production
EigenDA VID is deployed on Ethereum mainnet; DispersedLedger concepts are used in multiple blockchain DA layers.

**Implementations:**
- [Layr-Labs/eigenda](https://github.com/Layr-Labs/eigenda) ⭐ 261 — Go, KZG-based VID for Ethereum data availability
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, danksharding VID specifications
- [avail-project/avail](https://github.com/availproject/avail) ⭐ 796 — Rust, VID-based data availability layer

**Security status:** Secure
KZG-based VID is secure under pairing assumptions; erasure coding provides information-theoretic fault tolerance.

**Community acceptance:** Emerging
Rapidly adopted in the Ethereum ecosystem for data availability; EigenDA and Avail are major deployments.

---

### Accountable Decryption

**Goal:** Auditable use of decryption keys. Every decryption act produces a publicly verifiable log entry proving the decryption was legitimate. A verifier can identify malicious decryptors who abuse their keys. Distinct from [message franking](12-secure-communication-protocols.md#message-franking--abuse-reporting-in-e2e) (which audits message content, not key usage).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tang Accountable Decryption** | 2023 | Signatures + log | Formal model: decryptor must produce verifiable log entry for every decryption; identifies rogue decryptors [[1]](https://eprint.iacr.org/2023/1519) |
| **Practical Accountable Decryption (IEEE TIFS)** | 2024 | TEE + verifiable logs | Production system: identifies malicious decryptors among 300K log entries in 69 ms [[1]](https://ieeexplore.ieee.org/document/10798458/) |

**State of the art:** TEE-enforced accountable decryption (2024); formal model (2023). Complements [Key Transparency](03-key-exchange-key-management.md#key-transparency--coniks) (audits key bindings) and [Traceable Signatures](#traceable-secret-sharing) (audits signing).

**Production readiness:** Experimental
TEE-based accountable decryption has been benchmarked at production scale (300K log entries); formal model is recent (2023).

**Implementations:**
- No standalone open-source implementations available yet; the IEEE TIFS 2024 paper describes a TEE-based prototype.

**Security status:** Secure
Formal security model established (2023); TEE-based variant relies on hardware trust assumptions.

**Community acceptance:** Niche
New area with limited but growing interest; published at IEEE TIFS (top-tier venue); complements existing audit mechanisms.

---

### Multi-Secret Sharing

**Goal:** Share multiple independent secrets simultaneously. Each secret may have its own access structure (qualified sets). Unlike [Packed Secret Sharing](#packed-secret-sharing), the secrets are not required to share a single threshold; the scheme must hide each secret from unauthorized parties even when some other secrets are revealed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ideal Multi-Secret Sharing (Blundo et al.)** | 1993 | Polynomial | First formal treatment; share k secrets with (possibly distinct) access structures using a single sharing; characterizes when ideal schemes exist [[1]](https://link.springer.com/article/10.1007/BF00189262) |
| **Blundo-De Santis Multi-SS** | 1994 | Polynomial + info theory | CRYPTO '94; information-theoretic lower bounds on share sizes for multi-secret SS [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_17) |
| **Verifiable Multi-SS (Yang-Chang-Hwang)** | 2004 | One-way functions + Shamir | Efficient reusable shares; one polynomial encodes multiple secrets; verification via public commitments [[1]](https://www.sciencedirect.com/science/article/abs/pii/S0140366498001911) |
| **Space-Efficient Computational Multi-SS** | 2018 | PRF + polynomial | Computational multi-SS with share sizes independent of the number of secrets; supports arbitrary access structures [[1]](https://eprint.iacr.org/2018/1010) |

**State of the art:** Computational multi-SS (2018) achieves near-optimal share sizes; widely used in key management, password managers, and threshold wallets where multiple independent secrets must be distributed. Distinct from [Packed SS](#packed-secret-sharing) (which amortizes a single threshold over many secrets) and extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Multi-secret sharing concepts are used in key management systems and password managers; dedicated implementations exist.

**Implementations:**
- No widely-adopted standalone open-source multi-SS libraries; concepts are embedded in key management frameworks.
- [hashicorp/vault](https://github.com/hashicorp/vault) ⭐ 35k — Go, manages multiple secrets with threshold unsealing (related concept)

**Security status:** Secure
Information-theoretically or computationally secure depending on variant; well-established lower bounds on share sizes.

**Community acceptance:** Niche
Well-studied in the secret sharing theory community; practical use cases in key management are well-recognized but dedicated tooling is limited.

---

### Quantum Secret Sharing

**Goal:** Secret sharing for quantum information. Split a quantum state |ψ⟩ into n quantum shares so that any t shares suffice to reconstruct |ψ⟩, while fewer than t shares leave an adversary with zero information — not even classical information. Classical SS cannot directly encode quantum secrets due to the no-cloning theorem; quantum SS uses quantum error-correcting codes and entanglement.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hillery-Bužek-Berthiaume (HBB) QSS** | 1999 | GHZ entangled states | First quantum secret sharing; (2,3)-threshold using GHZ triplets; both quantum and classical secrets; PRA 1999 [[1]](https://doi.org/10.1103/PhysRevA.59.1829) |
| **Cleve-Gottesman-Lo QSS** | 1999 | Quantum error-correcting codes | Reduction: any ((t,n)) quantum threshold SS corresponds to a quantum error-correcting code; characterizes achievable parameters via quantum Singleton bound [[1]](https://doi.org/10.1103/PhysRevLett.83.648) |
| **Karlsson-Koashi-Imoto** | 1999 | Bell pairs + classical shares | Players hold classical shares plus shared entanglement; reconstruction via LOCC [[1]](https://link.aps.org/doi/10.1103/PhysRevA.59.162) |
| **Continuous-Variable QSS** | 2001 | Gaussian states + CV optics | QSS using optical modes (continuous variables); experimentally demonstrated with squeezed light; Physical Review Letters 2001 [[1]](https://doi.org/10.1103/PhysRevLett.88.127902) |
| **Approximate QSS (Ogawa et al.)** | 2005 | Decoupling lemma | Relaxes exact reconstruction to ε-approximate; enables QSS beyond the Singleton bound threshold; CMP 2005 [[1]](https://doi.org/10.1007/s00220-005-1372-8) |
| **Graph-State QSS** | 2006 | Graph states + stabilizer codes | Efficient QSS construction from graph states; arbitrary access structures realizable; measurement-based; PRA 2006 [[1]](https://doi.org/10.1103/PhysRevA.74.032332) |
| **Verifiable QSS** | 2019 | Quantum authentication codes | Handles dishonest dealer; quantum analog of classical VSS [[1]](https://arxiv.org/abs/1907.06564) |

**State of the art:** Cleve-Gottesman-Lo (1999) gives the definitive theory: (t,n)-quantum SS exists if and only if 2t < n (quantum Singleton bound), unlike classical SS which allows any t < n. Graph-state QSS is the leading experimental platform. Verifiable QSS (2019) handles active adversaries including a dishonest dealer, analogous to [PVSS](#publicly-verifiable-secret-sharing-pvss) in the classical setting. Distinct from [Unclonable SS](#unclonable-secret-sharing) (which prevents share cloning for classical secrets) and [Quantum Copy-Protection](15-quantum-cryptography.md#quantum-copy-protection--uncloneable-encryption). Extends [Secret Sharing](#secret-sharing-schemes-sss) to the quantum domain.

**Production readiness:** Research
Quantum SS requires quantum hardware; experimental demonstrations exist (graph-state QSS) but no production deployment.

**Implementations:**
- [quantumlib/Cirq](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, quantum circuit framework for implementing QSS protocols
- [qiskit/qiskit](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, quantum computing SDK with stabilizer/graph-state support

**Security status:** Secure
Information-theoretically secure; quantum Singleton bound provides tight characterization of achievable parameters.

**Community acceptance:** Niche
Foundational in quantum information theory (Cleve-Gottesman-Lo is highly cited); limited to quantum computing research community.

---

### Function Secret Sharing (FSS) for Threshold Policies

**Goal:** Distribute a function rather than a value. In function secret sharing, the dealer splits a function f into n function shares f_1, ..., f_n such that each f_i individually hides f, but any t shares allow pointwise reconstruction of f(x) for any input x. When the function class is restricted to point functions or interval functions, FSS yields compact shares and efficient evaluation — enabling applications like private database queries and distributed point functions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boyle-Gilboa-Ishai FSS** | 2015 | PRG tree + point functions | Foundational FSS construction; 2-party FSS for point functions with O(lambda) share size; enables lightweight PIR and DPF; EUROCRYPT 2015 [[1]](https://eprint.iacr.org/2015/879) |
| **Multi-Party FSS** | 2019 | PRG + replicated SS | Extends FSS to t-of-n threshold; shares of decision tree or interval functions; enables multi-server private queries [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for Arithmetic Circuits** | 2021 | Homomorphic + PRG | FSS for richer function classes (low-degree polynomials, CNFs); enables distributed private analytics [[1]](https://eprint.iacr.org/2020/1392) |
| **Verifiable FSS** | 2023 | FSS + MAC consistency | Adds verification: servers can check their function share evaluations are consistent without learning the function; prevents silent corruption [[1]](https://eprint.iacr.org/2023/1042) |

**State of the art:** Boyle-Gilboa-Ishai (2015) is the foundational scheme; FSS for point functions (DPF) is deployed in private analytics (Prio, Apple/Google exposure notifications) and lightweight [PIR](10-privacy-preserving-computation.md#private-information-retrieval-pir). Multi-party and verifiable FSS (2019-2023) extend to threshold settings. Closely related to [Distributed Point Functions / FSS](06-multi-party-computation.md#function-secret-sharing-fss--distributed-point-functions-dpf) in the MPC category. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Production
DPF (2-party FSS for point functions) is deployed in Prio/VDAF for privacy-preserving telemetry (Apple, Google, Mozilla); multi-party FSS is experimental.

**Implementations:**
- [google/distributed_point_functions](https://github.com/google/distributed_point_functions) ⭐ 79 — C++, DPF library for private analytics
- [divviup/libprio-rs](https://github.com/divviup/libprio-rs) ⭐ 117 — Rust, Prio/VDAF with FSS-based aggregation
- [henrycg/prio](https://github.com/henrycg/prio) ⭐ 64 — Go, original Prio implementation using FSS

**Security status:** Secure
Computationally secure under PRG assumptions; DPF correctness and privacy are well-established.

**Community acceptance:** Widely trusted
DPF is deployed at scale by Apple, Google, and Mozilla for privacy-preserving telemetry; IETF VDAF standardization incorporates FSS concepts.

---

### Computational Secret Sharing

**Goal:** Shares shorter than the secret. In information-theoretic (t,n)-SS each share must be at least as long as the secret. Under computational security assumptions (bounded adversary), shares can be compressed to |secret|/t plus a small key-dependent overhead — giving dramatic savings for large secrets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Krawczyk SSMS ("Secret Sharing Made Short")** | 1993 | IDA + symmetric enc | Share = encrypt secret with random key k, then Shamir-share k; total share size |S|/t + O(κ); computationally secure [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_12) |
| **Rogaway-Bellare RCSS** | 2007 | PRF + commitment | Robust computational SS with unified treatment of all classical SS goals; handles share tampering [[1]](https://dl.acm.org/doi/10.1145/1315245.1315268) |
| **Optimal Computational SS** | 2025 | Information theory + PRF | Tight bounds on share size in the computational model; matches Krawczyk for threshold but extends to general access structures [[1]](https://arxiv.org/abs/2502.02774) |

**State of the art:** Krawczyk's SSMS (1993) remains the standard construction; widely used in practice wherever large files must be split. Key insight: information-theoretic share-size lower bounds do not apply against computationally bounded adversaries. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Production
Krawczyk's SSMS is the basis for TAHOE-LAFS and other distributed storage systems; widely deployed for large-file sharing.

**Implementations:**
- [tahoe-lafs/tahoe-lafs](https://github.com/tahoe-lafs/tahoe-lafs) ⭐ 1.4k — Python, distributed storage using computational SS (IDA + encryption)
- [codahale/shamir](https://github.com/codahale/shamir) ⭐ 217 — Java, Shamir with short shares for key sharing

**Security status:** Secure
Computationally secure under standard symmetric encryption assumptions (IND-CPA); well-analyzed since 1993.

**Community acceptance:** Widely trusted
Krawczyk's construction is a textbook result; deployed in production distributed storage systems for decades.

---

### Regenerating Codes for Distributed Storage

**Goal:** Repair-efficient secret sharing. In a standard (t,n)-SS, repairing a lost share requires downloading the entire secret and re-sharing. Regenerating codes allow a failed node to be repaired by contacting d helper nodes and downloading only a fraction of their data — trading off storage overhead against repair bandwidth, with strong connections to secret sharing and MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dimakis et al. Regenerating Codes** | 2010 | Network coding + cut-set bounds | Foundational paper; identifies MSR (min storage) and MBR (min bandwidth) tradeoff points; file is recoverable from any k of n nodes [[1]](https://doi.org/10.1109/TIT.2010.2054295) |
| **Product-Matrix MSR/MBR** | 2011 | Linear algebra | Explicit optimal exact-regenerating codes at MSR and MBR points; simple product-matrix construction [[1]](https://arxiv.org/abs/1005.4178) |
| **Secure Regenerating Codes** | 2012 | RS codes + secret sharing | Information-theoretic security against eavesdroppers during repair; combines regenerating codes with Shamir sharing [[1]](https://arxiv.org/abs/1210.3664) |
| **Regenerating Codes ↔ Proactive SS** | 2022 | Formal equivalence | Shows formal connections and implications between regenerating codes and proactive secret sharing; unified framework [[1]](https://eprint.iacr.org/2022/096) |

**State of the art:** Regenerating codes are deployed in distributed storage systems (e.g., Azure LRC, Facebook f4) and increasingly connected to [Proactive SS](#proactive-secret-sharing) and [Robust SS](#robust-secret-sharing). Key open problem: efficient exact-repair regenerating codes with strong cryptographic security.

**Production readiness:** Production
Regenerating codes are deployed in Azure LRC, Facebook f4, and Hadoop HDFS-EC for repair-efficient distributed storage.

**Implementations:**
- [apache/hadoop](https://github.com/apache/hadoop) ⭐ 15k — Java, HDFS erasure coding with regenerating code principles
- [ceph/ceph](https://github.com/ceph/ceph) ⭐ 16k — C++, erasure coding plugins including LRC
- [tahoe-lafs/zfec](https://github.com/tahoe-lafs/zfec) ⭐ 423 — Python/C, erasure coding library

**Security status:** Secure
Information-theoretically secure against eavesdroppers when combined with secret sharing; coding-theoretic guarantees are well-established.

**Community acceptance:** Widely trusted
Deployed at hyperscale by Microsoft, Meta, and Apache; foundational in distributed storage research.

---

### DKLS23: Threshold ECDSA in Three Rounds

**Goal:** Practical t-of-n threshold ECDSA. Any t signers from a group of n jointly produce a standard ECDSA signature in three communication rounds, with security against malicious adversaries — without homomorphic encryption, achieving the lowest round complexity known for threshold ECDSA.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DKLs18 (2-party ECDSA)** | 2018 | OT + MtA | First OT-based 2-of-2 ECDSA; avoids Paillier HE; CCS 2018 [[1]](https://eprint.iacr.org/2018/499) |
| **DKLS23 (t-of-n, 3 rounds)** | 2023 | OT + ZK proofs | Generalizes to arbitrary (t,n); 3-round signing; full malicious security proof; CRYPTO 2023; closed-form cost analysis [[1]](https://eprint.iacr.org/2023/765) |

**State of the art:** DKLS23 (2023) is the state-of-the-art threshold ECDSA protocol: 3 rounds, OT-based (no HE), malicious security, supports key resharing and dynamic sets. Deployed in Vultisig, Silence Laboratories (audited by Trail of Bits 2025), and other MPC wallet stacks. Complements [FROST](#frost-flexible-round-optimized-schnorr-threshold-signatures) (Schnorr) and relates to [Threshold Signature Schemes](08-signatures-advanced.md#threshold-signature-schemes-tss).

**Production readiness:** Production
DKLS23 is deployed in Vultisig and Silence Laboratories (audited by Trail of Bits 2025); DKLs18 is used in multiple 2-party wallet systems.

**Implementations:**
- [ZenGo-X/multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) ⭐ 1.1k — Rust, threshold ECDSA (GG18/GG20 and DKLs-style)
- [silence-laboratories/dkls23](https://github.com/ZenGo-X/multi-party-ecdsa) ⭐ 1.1k — Rust, multi-party ECDSA including DKLS variants
- [vultisig/vultisig](https://github.com/bnb-chain/tss-lib) ⭐ 1.0k — Go, TSS library with DKLS support

**Security status:** Secure
Provably secure against malicious adversaries under standard assumptions (OT security); CRYPTO 2023 full proof.

**Community acceptance:** Emerging
Published at CRYPTO 2023; rapidly adopted in the MPC wallet ecosystem; Trail of Bits audit adds confidence.

---

### Hierarchical Secret Sharing

**Goal:** Multi-level access control via sharing. Participants are organized into ordered levels (e.g., executives > managers > employees); a qualified coalition must include enough participants from each level to reconstruct the secret. Generalizes (t,n)-threshold while preserving information-theoretic secrecy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Compartmented SS (Simmons)** | 1990 | Affine geometry | Antecedent to hierarchical SS; separate compartment secrets that must all contribute before reconstruction; models need-all-divisions approval [[1]](https://doi.org/10.1007/0-387-34805-0_28) |
| **Tassa Hierarchical SS** | 2004 | Birkhoff interpolation | First ideal hierarchical SS; shares sized equal to secret; qualified sets defined by a vector of thresholds per level; shares computed via generalized Lagrange interpolation; J. Cryptology 2007 [[1]](https://doi.org/10.1007/s00145-006-0417-1) |
| **Ideal Hierarchical SS (Farràs-Padró)** | 2010 | Matroid theory | Characterizes exactly which hierarchical access structures admit ideal SS (optimal share size) using matroid ports; TCC 2010 [[1]](https://doi.org/10.1007/978-3-642-11799-2_25) |
| **Weighted Hierarchical SS (Beimel-Tassa)** | 2011 | Polynomial + combinatorics | Combines weighted shares with hierarchical levels; models organizational authority with varied voting weights [[1]](https://link.springer.com/article/10.1007/s10623-010-9420-1) |

**State of the art:** Tassa's scheme (2004) is the canonical ideal hierarchical SS; Farràs-Padró (2010) gives the definitive characterization of ideal hierarchical schemes via matroids. Widely used in key management, credential delegation, and corporate governance models. Extends [Secret Sharing](#secret-sharing-schemes-sss) and [General Access Structure SS](#general-access-structure-secret-sharing).

**Production readiness:** Mature
Hierarchical SS concepts are deployed in corporate key management and multi-tier credential systems; Tassa's scheme has reference implementations.

**Implementations:**
- [trezor/python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, SLIP-39 group threshold (two-level hierarchical)
- No standalone open-source implementation of Tassa's Birkhoff-based hierarchical SS; concepts are embedded in enterprise key management tools.

**Security status:** Secure
Information-theoretically secure; ideal share size (share = secret size) for supported weight distributions.

**Community acceptance:** Niche
Well-studied in theoretical secret sharing; practical adoption primarily through SLIP-39 group thresholds and enterprise key management.

---

### Shared RSA Key Generation

**Goal:** Distributed RSA modulus generation. Generate an RSA modulus N = p·q and a corresponding threshold key pair among n parties so that no single party — nor any coalition below threshold t — ever knows the full factorization of N or the private key. Eliminates the need for a trusted key-generation authority in RSA-based threshold systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Franklin Distributed RSA** | 1997 | Biprimality test + MPC | First practical shared RSA keygen; parties jointly generate p, q via distributed primality testing; private key never assembled; ACM CCS 1997 [[1]](https://eprint.iacr.org/1997/005) |
| **Two-Party RSA Keygen (Gilboa)** | 1999 | OT-based multiplication | 2-party RSA modulus generation using OT for distributed multiplication; CRYPTO 1999 [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_26) |
| **Threshold RSA Keygen (Hazay et al.)** | 2019 | Paillier HE + ZK | n-party shared RSA keygen against dishonest majority; practical for 2-of-n settings; IEEE S&P 2019 [[1]](https://eprint.iacr.org/2019/017) |
| **SPRINT** | 2022 | Shamir + distributed sieving | Scalable shared RSA generation via faster distributed sieving; near-linear communication; USENIX Security 2022 [[1]](https://eprint.iacr.org/2022/1035) |

**State of the art:** Boneh-Franklin (1997) is the foundational result; SPRINT (2022) is the most communication-efficient n-party construction. Shared RSA keygen is a prerequisite for deploying [Threshold RSA Decryption](#threshold-decryption) and [Threshold Signatures](08-signatures-advanced.md#threshold-signature-schemes-tss) without a trusted dealer. Builds on [DKG](#distributed-key-generation-dkg) principles adapted to composite-order groups.

**Production readiness:** Experimental
Research prototypes exist; SPRINT has benchmark results but no production deployment; shared RSA keygen remains expensive.

**Implementations:**
- No widely-adopted standalone open-source implementations; the SPRINT paper (USENIX Security 2022) includes evaluation code.
- [AIT-DKMS/threshold-rsa](https://github.com/hlee95/threshold-rsa) ⭐ 4 — research prototype for threshold RSA key generation

**Security status:** Secure
Provably secure under RSA and factoring assumptions; SPRINT achieves near-linear communication complexity.

**Community acceptance:** Niche
Foundational result (Boneh-Franklin 1997) is widely cited; practical adoption limited by computational cost of distributed primality testing.

---

### Pseudorandom Secret Sharing (PRSS / PRZS)

**Goal:** Locally sample shared randomness without communication. All n parties hold correlated keys from a setup phase; at any later point, any subset of t parties can locally compute shares of a pseudorandom value — without any party sending a single message. Eliminates the online communication cost of distributing randomness in MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PRSS (Cramer-Damgård-Ishai)** | 2005 | PRF + access structure | Each party stores a PRF key per qualified set; any authorized subset evaluates its PRFs and XORs/adds locally to get shares of a pseudorandom secret; information-theoretically indistinguishable from fresh randomness [[1]](https://link.springer.com/chapter/10.1007/11535218_16) |
| **PRZS (Pseudorandom Zero-Sharing)** | 2005 | PRF + cancel structure | Variant where shares sum to zero; parties in authorized subsets locally generate sharings of 0 — essential for masking and degree reduction in MPC without interaction [[1]](https://link.springer.com/chapter/10.1007/11535218_16) |
| **PRSS from OWFs** | 2009 | PRG + span programs | Constructs PRSS from one-way functions under computational assumptions; extends to any LSSS access structure [[1]](https://link.springer.com/chapter/10.1007/978-3-642-03356-8_11) |
| **Silent PRSS (PCG-based)** | 2022 | PCG + LPN | Replaces PRF-keyed setup with pseudorandom correlation generators; reduces setup communication from O(n²|secret|) to O(n · polylog); CRYPTO 2022 [[1]](https://eprint.iacr.org/2022/1014) |

**State of the art:** CDI PRSS/PRZS (2005) is the standard; foundational to BGW-style MPC and [Packed SS](#packed-secret-sharing) — PRZS is used for degree-reduction without interaction. Silent PRSS via PCGs (2022) slashes setup cost. Closely related to [Pseudorandom Correlation Generators](06-multi-party-computation.md#silent-ot--pseudorandom-correlation-generators-pcg) and [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
PRSS/PRZS is implemented in all major information-theoretically secure MPC frameworks (MP-SPDZ, MPyC).

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, PRSS/PRZS for BGW-style MPC
- [lschoe/mpyc](https://github.com/lschoe/mpyc) ⭐ 415 — Python, PRSS in honest-majority MPC
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, PRSS for preprocessing

**Security status:** Secure
Computationally secure under PRF assumptions; PRZS sums to zero with overwhelming probability.

**Community acceptance:** Widely trusted
Core primitive in information-theoretic MPC; CDI (2005) is a highly cited foundational paper.

---

### Secret Sharing with Fairness

**Goal:** All-or-nothing reconstruction. Ensure that either all authorized parties reconstruct the secret simultaneously, or none do — preventing a cheating coalition from obtaining the secret while honest parties remain empty-handed. Standard (t,n)-SS has no fairness: whoever collects t shares first wins.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gordon-Hazay-Katz-Lindell** | 2008 | Gradual release + commitments | Shows full information-theoretic fairness is impossible with dishonest majority; achieves it for honest majority [[1]](https://eprint.iacr.org/2007/285) |
| **Timed-Release Fair SS (Garay-Jacobson)** | 2002 | Time-lock puzzles + SS | Parties release shares on a schedule; the last share is time-locked — no party can abort without forfeiting their share [[1]](https://doi.org/10.1007/3-540-45539-6_33) |
| **Gradual SS (Katz-Maurer-Pinkas-Warinschi)** | 2014 | Computational time-lock | Computational fairness via gradual reveal of share fragments; asymptotically near-fair for computationally bounded parties [[1]](https://eprint.iacr.org/2014/990) |
| **Fair SS via VDF** | 2021 | VDF + threshold SS | Share the secret with a VDF-delayed reveal; honest parties who abort early cannot compute the VDF faster than the delay; no trusted third party [[1]](https://eprint.iacr.org/2021/1273) |

**State of the art:** Full unconditional fairness requires honest majority (Gordon et al. 2008); against dishonest majority, practical fairness uses VDFs or time-lock puzzles (2021). Related to [Verifiable Delay Functions](09-commitments-verifiability.md#verifiable-delay-functions-vdf) and [Time-Lock Puzzles](09-commitments-verifiability.md#time-lock-puzzles--timed-release-encryption). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Research
Fair SS constructions are primarily theoretical; VDF-based fairness is experimental with no production deployment.

**Implementations:**
- No standalone open-source implementations of fair secret sharing; VDF libraries can serve as building blocks.
- [ethereum/research](https://github.com/ethereum/research) ⭐ 1.9k — Python, VDF research code applicable to fair SS

**Security status:** Secure
Impossibility result for unconditional fairness with dishonest majority is well-established; computational fairness constructions are provably secure under their assumptions.

**Community acceptance:** Niche
Theoretically important (Gordon et al. 2008 is highly cited); limited practical adoption.

---

### Share Conversion (Arithmetic-to-Boolean and Boolean-to-Arithmetic)

**Goal:** Convert secret shares between arithmetic (mod p or mod 2^k) and Boolean (XOR / bitwise) representations without reconstructing the secret. Mixed-mode MPC protocols compute arithmetic operations in one domain and bitwise operations in the other — share conversion bridges the gap with sub-linear communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Damgård-Fitzi-Kiltz-Nielsen-Toft A2B** | 2006 | Shared carry-ripple adder | First systematic A2B/B2A share conversion for MPC; binary adder circuit evaluated over Shamir shares; O(k) rounds for k-bit values; ASIACRYPT 2006 [[1]](https://eprint.iacr.org/2006/227) |
| **Demmler-Schneider-Zohner (DSZ) conversion** | 2015 | GMW + OT | Constant-round A2B using OT extension; core of ABY framework: Arithmetic, Boolean, Yao — switches between all three [[1]](https://www.ndss-symposium.org/ndss2015/ndss-2015-programme/aby-framework-efficient-mixed-protocol-secure-two-party-computation/) |
| **Mohassel-Zhang (SecureML)** | 2017 | Beaver triples + bit decomp | 2-party A2B via shared truncation and bit-decomposition; used in private ML inference [[1]](https://eprint.iacr.org/2017/396) |
| **Edabit-Based A2B (Escudero et al.)** | 2020 | Edabits + LPN | Efficient A2B using edabits (correlated arithmetic + binary shares of the same value); CRYPTO 2020; significantly fewer OTs than prior work [[1]](https://eprint.iacr.org/2020/338) |
| **Piranha / FantasticFour A2B** | 2022 | GPU + share conversion | GPU-accelerated A2B/B2A conversion in 4-party honest-majority MPC; enables fast private neural network inference [[1]](https://eprint.iacr.org/2022/1288) |

**State of the art:** Edabit-based conversion (2020) is the communication-optimal approach; ABY/ABY3 provide practical mixed-protocol frameworks. Share conversion is the key bottleneck in hybrid [MPC](06-multi-party-computation.md#multi-party-computation-mpc) protocols for private ML and private analytics. Builds on [Multiplicative SS](#multiplicative-secret-sharing) and [XOR-Based SS](#xor-based--binary-field-secret-sharing).

**Production readiness:** Production
ABY framework is widely used in MPC research and private ML; share conversion is deployed in CrypTen, SecureNN, and similar systems.

**Implementations:**
- [encryptogroup/ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, ABY framework with A2B/B2A conversion
- [encryptogroup/ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, 3-party ABY with share conversion
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, edabit-based and mixed-protocol conversion
- [facebookresearch/CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python, share conversion for private ML

**Security status:** Secure
Provably secure under OT/LPN assumptions (edabits) or in the honest-majority model; well-analyzed protocols.

**Community acceptance:** Widely trusted
ABY is the standard mixed-protocol MPC framework; share conversion is a well-studied core MPC technique.

---

### Threshold Verifiable Random Functions (Threshold VRF)

**Goal:** Distributed, bias-resistant pseudorandom outputs. A t-of-n threshold VRF allows t parties to jointly evaluate a VRF on an input x, producing a unique pseudorandom output y and a publicly verifiable proof — without any single party controlling the randomness. Prevents any minority coalition from biasing or predicting the output.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Yampolskiy VRF (basis)** | 2005 | Pairings + DLIN | Single-party VRF; threshold version obtained by distributing the exponent via Shamir; output = e(g, H(x))^(1/sk) [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30576-7_24) |
| **Threshold BLS VRF (Boldyreva)** | 2003 | BLS + Shamir | BLS signature as a VRF; t-of-n threshold via Shamir-shared key; output = H(x)^sk; bilinear pairing proves correctness [[1]](https://link.springer.com/chapter/10.1007/3-540-36288-6_3) |
| **GLOW Threshold VRF** | 2020 | BLS12-381 + DKG | Efficient threshold VRF with a combined DKG + signing protocol; used in Drand v2 randomness beacon [[1]](https://eprint.iacr.org/2020/096) |
| **Ring VRF (Pedersen-VRF threshold)** | 2023 | Schnorr + ring proofs | Anonymous threshold VRF where any authorized subset proves membership without revealing which parties signed; related to [Ring VRF](08-signatures-advanced.md#ring--group-signatures) [[1]](https://eprint.iacr.org/2023/002) |
| **Threshold VRF for PoS Leader Election** | 2024 | Pairings + DKG | Blockchain-grade threshold VRF; unpredictable, unbiasable committee selection; deployed in Algorand and Ethereum PBS research [[1]](https://eprint.iacr.org/2024/506) |

**State of the art:** BLS-based threshold VRF (Drand v2, GLOW 2020) is deployed in production randomness beacons used by Filecoin, Ethereum, and League of Entropy. Builds on [DKG](#distributed-key-generation-dkg), [Threshold BLS](#threshold-bls-key-generation), and relates to [VRF / VDF](09-commitments-verifiability.md#verifiable-random-functions-vrf). Threshold VRF is the preferred primitive for unbiasable on-chain randomness over [PVSS](#publicly-verifiable-secret-sharing-pvss)-based beacons when non-interactivity matters.

**Production readiness:** Production
Threshold BLS VRF is deployed in drand v2, Filecoin, and Algorand for randomness generation and leader election.

**Implementations:**
- [drand/drand](https://github.com/drand/drand) ⭐ 813 — Go, threshold BLS VRF in production randomness beacon
- [algorand/go-algorand](https://github.com/algorand/go-algorand) ⭐ 1.4k — Go, threshold VRF for PoS leader election
- [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) ⭐ 201 — Rust, threshold BLS as VRF

**Security status:** Secure
Secure under pairing assumptions; VRF uniqueness and pseudorandomness are provable under DLIN/co-CDH.

**Community acceptance:** Standard
drand is endorsed by the League of Entropy (Cloudflare, EPFL, Protocol Labs); Algorand deploys threshold VRF at scale.

---

### Weighted Threshold Secret Sharing

**Goal:** Unequal influence in reconstruction. Assign each participant a positive integer weight reflecting their authority or stake; the secret is reconstructible by any coalition whose total weight meets or exceeds a threshold T, while coalitions below T learn nothing. Unlike standard (t,n)-threshold where every party counts equally, weighted SS models organizational hierarchies, PoS validators, and corporate governance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir Replication (naive)** | 1979 | Replicated Shamir shares | Give each party w_i copies of distinct Shamir shares; total threshold t = T; works but share size scales linearly with weight — impractical for large weights [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Benaloh-Leichter Weighted SS** | 1990 | Monotone formulae | Encode weighted threshold as a monotone formula and apply Ito-Saito-Nishizeki; first non-replicated approach but exponential share blowup in the worst case [[1]](https://doi.org/10.1007/0-387-34805-0_27) |
| **Beimel-Tassa-Weinreb** | 2011 | Birkhoff interpolation | Ideal weighted SS for certain weight distributions using derivative evaluation; share size = secret size when weights satisfy divisibility conditions [[1]](https://link.springer.com/article/10.1007/s10623-010-9420-1) |
| **Verifiable Weighted SS (Bulletproofs)** | 2025 | Bulletproofs + Shamir | First efficient verifiable weighted SS; proves correct weight assignment via range proofs; stake-aware for PoS systems [[1]](https://arxiv.org/abs/2505.24289) |

**State of the art:** Ideal weighted SS exists only for restricted weight distributions (Beimel-Tassa 2011); general weights require super-polynomial share sizes (information-theoretic lower bound). Verifiable weighted SS (2025) adds verification for blockchain PoS applications. Related to [Hierarchical SS](#hierarchical-secret-sharing) and [General Access Structure SS](#general-access-structure-secret-sharing). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Experimental
Weighted SS is used conceptually in PoS systems; the naive replication approach is deployed but ideal weighted SS is research-stage.

**Implementations:**
- No standalone open-source ideal weighted SS implementations; the naive approach (replicated Shamir shares) is trivially implementable with any Shamir library.

**Security status:** Secure
Information-theoretically secure for ideal constructions; naive replication inherits Shamir's security.

**Community acceptance:** Niche
Well-studied in secret sharing theory; growing interest with PoS blockchain applications and verifiable weighted SS (2025).

---

### Secret Sharing with Cheater Identification (Harn-Lin)

**Goal:** Pinpoint cheaters by identity. Go beyond cheater *detection* (knowing someone cheated) to cheater *identification* (knowing *who* cheated) during secret reconstruction — even when up to t/3 of the t reconstructing parties submit forged shares. The Harn-Lin family achieves this with minimal share expansion by leveraging pairwise consistency checks and MACs embedded in the sharing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Harn-Lin (t, n) Cheater Identification** | 2009 | Bivariate polynomial + MAC | First efficient cheater-identifying SS for general (t,n); each party holds a row of a bivariate polynomial; pairwise consistency checks identify forged shares; identifies up to floor((t-1)/3) cheaters [[1]](https://doi.org/10.1007/s10623-009-9282-3) |
| **Harn-Lin Strong CI-SS** | 2012 | Multi-polynomial + hash | Strengthened model: cheater identification even when cheaters see honest shares first (rushing adversary); uses multiple polynomials and hash commitments [[1]](https://doi.org/10.1016/j.ipl.2012.06.008) |
| **Xu-Qin-Hu CI-SS** | 2015 | Polynomial + one-way function | Reduced share size: achieves cheater identification with shares only slightly larger than the secret; relaxes bivariate requirement [[1]](https://doi.org/10.1016/j.ins.2015.03.026) |
| **Jhanwar-Safavi-Naini Efficient CI-SS** | 2013 | Universal hash + polynomial | Near-optimal: share size |S| + O(kappa) bits (kappa = security parameter); cheater identification for rushing adversaries; efficient verification [[1]](https://eprint.iacr.org/2013/549) |

**State of the art:** Jhanwar-Safavi-Naini (2013) achieves near-optimal share size for cheater identification; Harn-Lin (2009, 2012) is the foundational construction. Stronger than [Cheater Detection](#secret-sharing-with-cheater-detection) (which only detects, not identifies) and complementary to [Robust SS](#robust-secret-sharing) (which corrects errors without identifying cheaters). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Research
Cheater identification SS constructions are primarily academic; no standalone production implementations.

**Implementations:**
- No standalone open-source implementations; the constructions are described in academic papers with some reference code.

**Security status:** Secure
Information-theoretically secure; identifies up to floor((t-1)/3) cheaters with near-optimal share sizes.

**Community acceptance:** Niche
Well-cited in secret sharing theory; Harn-Lin is the foundational reference; practical adoption is limited.

---

### Visual Secret Sharing

**Goal:** Secret sharing decodable by human vision. Split a binary image (or grayscale/color image) into n printed transparency shares such that stacking any t transparencies reveals the secret image to the naked eye, while fewer than t stacked shares appear as random noise. No computation or devices required for reconstruction — just physical overlay.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Shamir Visual SS** | 1995 | Subpixel expansion | Foundational (2,2)-visual SS; each pixel expanded into m subpixels; stacking reveals black/white contrast; perfect information-theoretic secrecy; EUROCRYPT 1994 [[1]](https://doi.org/10.1007/BFb0053419) |
| **Naor-Shamir (t,n) Generalization** | 1995 | Basis matrices + combinatorics | General (t,n)-threshold visual SS; contrast decreases as t grows; pixel expansion m = O(2^n); EUROCRYPT 1994 [[1]](https://doi.org/10.1007/BFb0053419) |
| **Ateniese-Blundo-De Santis-Stinson** | 1996 | Monotone access structures | Extended visual SS to arbitrary monotone access structures (not just threshold); characterized by contrast and pixel expansion via linear algebra [[1]](https://doi.org/10.1016/S0304-3975(96)00127-6) |
| **Probabilistic Visual SS (Yang)** | 2004 | Probabilistic subpixels | Eliminates pixel expansion: shares are same size as original image; probabilistic reconstruction trades deterministic contrast for no size blow-up [[1]](https://doi.org/10.1016/j.patrec.2004.01.006) |
| **Colored Visual SS (Hou)** | 2003 | CMY color model | Extends visual SS to color images; separate sharing per color channel; meaningful color reconstruction via halftone techniques [[1]](https://doi.org/10.1016/S0031-3203(02)00258-3) |

**State of the art:** Naor-Shamir (1995) is the foundational scheme; probabilistic visual SS (2004) solves the pixel-expansion problem. Visual SS is deployed in anti-counterfeiting, physical key ceremony backup, and low-tech secure authentication. Closely related to [Visual Cryptography](20-applied-niche-protocols.md#visual-cryptography) in the applied protocols category. Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Mature
Visual SS is deployed in anti-counterfeiting, physical key ceremonies, and educational demonstrations; multiple tools available.

**Implementations:**
- [4rtemi5/VisualCrypto](https://github.com/coduri/VisualCrypto) ⭐ 92 — Python, visual cryptography implementation
- [javl/image-splitter](https://github.com/RuyiLi/image-splitter) ⭐ 64 — Python, Naor-Shamir visual secret sharing

**Security status:** Secure
Information-theoretically perfect secrecy; security is unconditional and does not rely on computational assumptions.

**Community acceptance:** Niche
Well-known in cryptography education and anti-counterfeiting; unique property of requiring zero computation for reconstruction.

---

### AONT-RS: All-or-Nothing Transform with Reed-Solomon for Cloud Storage

**Goal:** Secure and efficient data dispersal for cloud/distributed storage. Combine an All-or-Nothing Transform (AONT) — which makes it computationally infeasible to recover any part of the plaintext without all transform output blocks — with Reed-Solomon erasure coding, achieving confidentiality without per-share encryption and fault tolerance without full replication. Dramatically reduces storage overhead compared to encrypt-then-replicate.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest AONT (OAEP-based)** | 1997 | Block cipher + hash | Original All-or-Nothing Transform; encrypts with random key, then XORs all ciphertext blocks into the key block; any missing block renders all blocks useless [[1]](https://doi.org/10.1007/BFb0052345) |
| **AONT-RS (Resch-Plank)** | 2011 | AONT + Reed-Solomon | Combines AONT with systematic RS coding; s data blocks + (n-s) parity blocks; any s of n blocks suffice for recovery; confidentiality from AONT, fault-tolerance from RS; deployed in cloud storage research [[1]](https://doi.org/10.1109/FAST.2011.5544522) |
| **Secure AONT-RS (Kurihara et al.)** | 2013 | Cauchy RS + improved AONT | Optimized AONT-RS with Cauchy Reed-Solomon for faster encoding/decoding; formal security proof under CPA model; reduced computational overhead [[1]](https://doi.org/10.1109/TPDS.2013.52) |
| **CAONT-RS (Yan-Weng-Chen)** | 2017 | Computational AONT + RS | Computationally secure AONT-RS variant; uses AES-based AONT to avoid information-theoretic overhead; suitable for large-scale cloud deployments [[1]](https://doi.org/10.1109/TCC.2017.2679717) |

**State of the art:** AONT-RS (Resch-Plank 2011) is the standard construction for secure distributed storage; achieves 1.5-3x storage overhead (vs. 3x for replication) while providing both confidentiality and fault tolerance. Used in Cleversafe (now IBM Cloud Object Storage), academic secure storage systems, and RAID-like distributed architectures. Distinct from [Computational SS](#computational-secret-sharing) (Krawczyk) which shares a key rather than dispersing data. Extends [Secret Sharing](#secret-sharing-schemes-sss) and relates to [Regenerating Codes](#regenerating-codes-for-distributed-storage).

**Production readiness:** Production
AONT-RS is deployed in IBM Cloud Object Storage (formerly Cleversafe) and academic secure storage systems.

**Implementations:**
- [tahoe-lafs/tahoe-lafs](https://github.com/tahoe-lafs/tahoe-lafs) ⭐ 1.4k — Python, distributed storage with IDA/AONT concepts
- [klauspost/reedsolomon](https://github.com/klauspost/reedsolomon) ⭐ 2.1k — Go, RS coding component for AONT-RS

**Security status:** Secure
Confidentiality from AONT (computationally secure under block cipher assumption); fault tolerance from RS coding (information-theoretic).

**Community acceptance:** Widely trusted
Deployed in IBM Cloud Object Storage at enterprise scale; well-studied in the distributed storage community.

---

### Rational Secret Sharing

**Goal:** Incentive-compatible reconstruction. In standard SS, rational (selfish) players may deviate from the protocol — e.g., withholding their share to learn the secret from others without reciprocating. Rational SS designs mechanisms where following the protocol is a Nash equilibrium: no player benefits from deviating, even when all players are self-interested rather than honest or malicious.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Halpern-Teague Rational SS** | 2004 | Game theory + iterated protocol | First rational SS; shows standard SS has no Nash equilibrium for reconstruction; proposes iterated protocol where parties cannot distinguish the real round from dummy rounds [[1]](https://doi.org/10.1145/1007352.1007392) |
| **Gordon-Katz Rational SS** | 2006 | Computational assumptions | Achieves rational SS in constant rounds under computational assumptions; eliminates the need for physical channels or simultaneous broadcast [[1]](https://eprint.iacr.org/2006/140) |
| **Asharov-Lindell Utility-Independent** | 2010 | Simulation-based | Rational SS that works for any utility function (not just specific payoff matrices); simulation-based security definition; TCC 2010 [[1]](https://eprint.iacr.org/2009/561) |
| **Fuchsbauer-Katz-Naccache** | 2010 | Verifiable computation | Efficient rational SS using verifiable computation to detect deviation; sub-linear communication in repeated games [[1]](https://eprint.iacr.org/2010/142) |

**State of the art:** Asharov-Lindell (2010) gives the definitive utility-independent treatment. Rational SS bridges [Secret Sharing](#secret-sharing-schemes-sss) and game theory; closely related to [Rational Cryptography](19-theoretical-foundations.md#rational-cryptography) and [Secret Sharing with Fairness](#secret-sharing-with-fairness). Primarily theoretical; practical deployments remain limited.

**Production readiness:** Research
Purely theoretical; no production implementations or real-world deployments.

**Implementations:**
- No open-source implementations available; constructions are described in academic papers only.

**Security status:** Secure
Game-theoretic security (Nash equilibrium); provably incentive-compatible under stated utility models.

**Community acceptance:** Niche
Well-cited in the intersection of cryptography and game theory; Asharov-Lindell (2010) is the definitive reference; no practical adoption.

---

### Verifiable Multi-Secret Sharing (VMSS)

**Goal:** Distribute multiple secrets with dealer accountability. A dealer shares k independent secrets among n parties such that (1) each secret has its own threshold/access structure, (2) any party can verify their shares are consistent, and (3) shares are reusable across reconstruction phases for different secrets — without the dealer re-distributing. Combines the goals of [VSS](#secret-sharing-schemes-sss) and [Multi-Secret Sharing](#multi-secret-sharing).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **He-Dawson VMSS** | 1994 | One-way functions + polynomial | First VMSS; single set of shares verifiably encodes multiple secrets; uses hash-based commitments for verification [[1]](https://doi.org/10.1049/el:19941387) |
| **Yang-Chang-Hwang VMSS** | 2004 | Shamir + discrete-log commitments | Efficient VMSS with reusable shares; verification via Feldman-style commitments on each secret polynomial; widely cited [[1]](https://www.sciencedirect.com/science/article/abs/pii/S0140366498001911) |
| **Dehkordi-Mashhadi VMSS** | 2008 | Bilinear pairings + polynomial | VMSS using pairings for efficient batch verification; supports distinct thresholds per secret with constant-size public parameters [[1]](https://doi.org/10.1016/j.ipl.2008.05.006) |
| **Liu-Ning-Liang VMSS** | 2016 | Lattice-based + polynomial | First post-quantum VMSS; verification based on lattice assumptions (SIS); resists quantum adversaries [[1]](https://doi.org/10.1016/j.ins.2016.03.037) |

**State of the art:** Yang-Chang-Hwang (2004) and Dehkordi-Mashhadi (2008) are the most cited practical constructions; Liu et al. (2016) provides a post-quantum path. VMSS is used in key escrow, multi-authority credential systems, and digital rights management where a dealer must commit to multiple secrets simultaneously. Extends [Multi-Secret Sharing](#multi-secret-sharing) and [Verifiable SS](#secret-sharing-schemes-sss).

**Production readiness:** Research
VMSS constructions exist in academic literature; no standalone production implementations.

**Implementations:**
- No widely-adopted open-source implementations; concepts are embedded in key escrow and multi-authority credential systems.

**Security status:** Secure
Computationally secure under DLP/pairing assumptions (Yang-Chang-Hwang, Dehkordi-Mashhadi) or lattice assumptions (Liu et al.).

**Community acceptance:** Niche
Well-cited in the multi-secret sharing literature; practical adoption in key escrow and DRM but without dedicated open-source tooling.

---

### Secret Sharing with Enrollment / Dynamic Secret Sharing

**Goal:** Add or remove participants post-sharing. Allow new participants to receive valid shares, and revoke existing shares, without re-sharing the original secret from scratch or requiring all existing shareholders to participate. Essential for long-lived systems where the participant set changes over time.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blundo-Cresti-De Santis-Vaccaro Dynamic SS** | 1993 | Bivariate polynomial | Dealer precomputes a bivariate polynomial; new shares derived from dealer's master; O(1) enrollment cost per new party; CRYPTO 1993 [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_10) |
| **Desmedt-Jajodia Enrollment** | 1997 | Redistribution + VSS | Existing shareholders jointly issue a new share without dealer involvement; threshold redistribution ensures forward secrecy against departed members [[1]](https://doi.org/10.1109/SECPRI.1997.601329) |
| **CHURP (Dynamic Proactive SS)** | 2019 | Bivariate + committee rotation | Combines dynamic enrollment with proactive refresh; supports committee handoff in blockchain settings; tolerates Byzantine faults [[1]](https://eprint.iacr.org/2019/017) |
| **Mobile Proactive SS (Maram et al.)** | 2024 | Threshold redistribution | Formalized mobile secret sharing: parties join and leave arbitrarily; secret remains secure as long as the threshold is not exceeded in any epoch [[1]](https://eprint.iacr.org/2024/203) |

**State of the art:** CHURP (2019) is the standard for blockchain-era dynamic SS with proactive refresh. Desmedt-Jajodia (1997) introduced dealer-free enrollment. Closely related to [Proactive SS](#proactive-secret-sharing) (which refreshes shares periodically) and [Evolving SS](#evolving-secret-sharing) (which handles unbounded participants but without revocation). Extends [Secret Sharing](#secret-sharing-schemes-sss).

**Production readiness:** Experimental
CHURP has working prototypes deployed in Oasis Network; Desmedt-Jajodia enrollment is implemented in research systems; no widely standardized dynamic SS protocol exists.

**Implementations:**
- [oasisprotocol/oasis-core](https://github.com/oasisprotocol/oasis-core) ⭐ 369 — Go/Rust, CHURP with dynamic committee enrollment
- [ISTA-SPiDerS/dpss](https://github.com/timothykim/dpss) ⭐ 4 — Go, dynamic proactive secret sharing

**Security status:** Secure
CHURP is provably secure under bivariate polynomial assumptions with Byzantine tolerance; redistribution-based enrollment inherits VSS security.

**Community acceptance:** Emerging
CHURP is well-cited in the blockchain research community; dynamic SS is gaining traction with validator rotation in PoS systems.

---

### CRT-Based Secret Sharing (Mignotte / Asmuth-Bloom)

**Goal:** Replace polynomial interpolation with the Chinese Remainder Theorem over pairwise coprime moduli, making reconstruction computationally cheaper via modular arithmetic.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mignotte scheme** | 1982 | CRT, non-perfect | Ramp scheme using consecutive moduli; computationally secret [[1]](https://en.wikipedia.org/wiki/Secret_sharing_using_the_Chinese_remainder_theorem) |
| **Asmuth-Bloom** | 1983 | CRT, information-theoretic | Perfect scheme via random offset; reconstruction by CRT; ePrint 2006/166 [[1]](https://eprint.iacr.org/2006/166) |

**State of the art:** CRT-based schemes generalize cleanly to weighted threshold, hierarchical, and compartmented access structures. Used in hardware security modules where modular arithmetic is accelerated.

**Production readiness:** Mature
Asmuth-Bloom is implemented in several libraries; used in hardware security modules where modular arithmetic is natively supported.

**Implementations:**
- [dsprenkels/sss](https://github.com/dsprenkels/sss) ⭐ 399 — C, includes notes on CRT-based alternatives
- [mikeivanov/pysss](https://github.com/junkurihara/PySSS) ⭐ 7 — Python, Shamir and CRT-based secret sharing

**Security status:** Caution
Asmuth-Bloom is information-theoretically secure (perfect); Mignotte is not perfect (partial leakage below threshold). Parameter selection for CRT sequences requires care.

**Community acceptance:** Niche
Well-known in the secret sharing literature; less commonly deployed than Shamir due to more complex parameter generation.

---

### Visual Secret Sharing (Visual Cryptography)

**Goal:** Split a secret image into n printed transparencies so that any qualifying subset, when physically stacked, reveals the image to the naked eye with zero computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Shamir visual cryptography** | 1994 | Pixel expansion, XOR stacking | No keys, no software, no power needed at decryption; EUROCRYPT 1994 [[1]](https://link.springer.com/chapter/10.1007/BFb0053419) |
| **Extended visual cryptography** | 2002 | Meaningful shares | Each share individually looks like a natural image; Nakajima-Yamaguchi [[1]](https://doi.org/10.1007/3-540-36563-X_25) |

**State of the art:** Used for tamper-evident physical tokens, printed ballots, QR codes, and graphical password authentication. The only secret sharing scheme where decryption requires no computation at all.

**Production readiness:** Mature
Visual SS is deployed in anti-counterfeiting, physical key ceremonies, and educational demonstrations; multiple tools available.

**Implementations:**
- [4rtemi5/VisualCrypto](https://github.com/coduri/VisualCrypto) ⭐ 92 — Python, visual cryptography implementation
- [javl/image-splitter](https://github.com/RuyiLi/image-splitter) ⭐ 64 — Python, Naor-Shamir visual secret sharing

**Security status:** Secure
Information-theoretically perfect secrecy; security is unconditional and does not rely on computational assumptions.

**Community acceptance:** Niche
Well-known in cryptography education and anti-counterfeiting; unique property of requiring zero computation for reconstruction.

---

### Computational Secret Sharing / "Secret Sharing Made Short" (Krawczyk)

**Goal:** Achieve threshold secret sharing with each share of size |S|/m plus a short security-parameter-length tag, by combining information-theoretic dispersal with computationally secure encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Krawczyk SSMS** | 1993 | IDA + symmetric encryption | Shares are 1/m-th the secret size instead of full size (as in Shamir); CRYPTO '93 [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_12) |

**State of the art:** Direct predecessor to practical distributed storage systems like TAHOE-LAFS. Sharing a 1 GB file among 10 parties requires ~1 GB total storage instead of 10 GB.

**Production readiness:** Production
Krawczyk's SSMS is the basis for TAHOE-LAFS and other distributed storage systems; widely deployed for large-file sharing.

**Implementations:**
- [tahoe-lafs/tahoe-lafs](https://github.com/tahoe-lafs/tahoe-lafs) ⭐ 1.4k — Python, distributed storage using computational SS (IDA + encryption)
- [codahale/shamir](https://github.com/codahale/shamir) ⭐ 217 — Java, Shamir with short shares for key sharing

**Security status:** Secure
Computationally secure under standard symmetric encryption assumptions (IND-CPA); well-analyzed since 1993.

**Community acceptance:** Widely trusted
Krawczyk's construction is a textbook result; deployed in production distributed storage systems for decades.

---

### Hierarchical Threshold Secret Sharing (Tassa)

**Goal:** Partition participants into ordered levels so that a subset is authorized iff it satisfies nested per-level threshold conditions, using Birkhoff interpolation on a polynomial.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tassa hierarchical SS** | 2004 | Birkhoff interpolation | Perfect, information-theoretic; single polynomial; TCC 2004 [[1]](https://link.springer.com/chapter/10.1007/978-3-540-24638-1_26) |

**State of the art:** Handles policies like "3 employees, at least 1 of whom is a manager" naturally. Directly applicable to organizational signing policies and multi-tier key management.

**Production readiness:** Mature
Hierarchical SS concepts are deployed in corporate key management and multi-tier credential systems; Tassa's scheme has reference implementations.

**Implementations:**
- [trezor/python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, SLIP-39 group threshold (two-level hierarchical)

**Security status:** Secure
Information-theoretically secure; ideal share size (share = secret size) for supported weight distributions.

**Community acceptance:** Niche
Well-studied in theoretical secret sharing; practical adoption primarily through SLIP-39 group thresholds and enterprise key management.

---

### Verifiable Secret Redistribution (VSR)

**Goal:** Allow existing shareholders to collectively re-share a secret to a new set of shareholders with a potentially different (m',n') threshold, without reconstructing the secret and without a dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wong-Wing VSR** | 2002 | Distributed Feldman VSS | Old shareholders act as dealers for new group; new shareholders verify share validity; CMU TR [[1]](https://www.cs.cmu.edu/~wing/publications/Wong-Wing02b.pdf) |

**State of the art:** Foundational protocol for threshold key lifecycle management — essential when employees leave, trust levels change, or hardware is decommissioned. Distinct from proactive SS (which refreshes among the same set).

**Production readiness:** Experimental
VSR concepts are used in threshold key rotation systems; no standalone production-quality implementation exists.

**Implementations:**
- [poanetwork/threshold_crypto](https://github.com/poanetwork/threshold_crypto) ⭐ 201 — Rust, share redistribution primitives
- [AIT-DKMS/proactive-refresh](https://github.com/lyronctk/proactive-refresh) ⭐ 36 — Rust, proactive share refresh with redistribution support

**Security status:** Secure
Provably secure under Feldman VSS assumptions; new shareholders can verify share validity without trusting departing members.

**Community acceptance:** Niche
Foundational concept for threshold key lifecycle management; well-cited but limited standalone tooling.

---

### Timed Secret Sharing

**Goal:** Enforce both lower and upper time bounds on when a secret can be reconstructed, using cryptographic time-lock mechanisms combined with threshold sharing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kavousi-Abadi-Jovanovic** | 2023 | Time-lock puzzles + SS | First formal definition with both lower and upper temporal bounds on reconstruction; ePrint 2023/1024 [[1]](https://eprint.iacr.org/2023/1024) |

**State of the art:** Enables sealed-bid auctions, time-capsule commitments, timed-release blockchain transactions, and regulatory escrow with cryptographic enforcement of timing policies rather than procedural controls.

**Production readiness:** Research
Timed SS is a recent theoretical construction (2023); no production implementations or deployments exist.

**Implementations:**
- No standalone open-source implementations available; the construction builds on time-lock puzzle libraries as components.

**Security status:** Secure
Security relies on the sequential computation assumption underlying time-lock puzzles; provably secure under standard assumptions.

**Community acceptance:** Niche
Recent result (2023) with growing interest for timed-release applications; limited adoption outside the research community.

---
