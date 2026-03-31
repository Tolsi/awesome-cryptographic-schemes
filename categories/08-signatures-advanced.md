# Signatures — Advanced & Specialized

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

**Production readiness:** Production
**Implementations:**
- [tss-lib](https://github.com/bnb-chain/tss-lib) — Go, Binance threshold ECDSA/EdDSA
- [multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) — Rust, GG18/GG20/CGGMP
- [frost](https://github.com/ZcashFoundation/frost) — Rust, FROST for multiple curves
- [bitcoin/secp256k1](https://github.com/BlockstreamResearch/secp256k1-zkp) — C, MuSig2 module
**Security status:** Secure
**Community acceptance:** Widely trusted

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

**Production readiness:** Production
**Implementations:**
- [privacypass](https://github.com/cloudflare/privacypass) — Go, RSA blind signature (Privacy Pass)
- [blind-rsa-signatures](https://github.com/nicolo-ribaudo/blind-rsa-signatures) — JS, RFC 9474
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) — Rust/TypeScript, BBS+ selective disclosure
- [hyperledger/ursa](https://github.com/nicolo-ribaudo/blind-rsa-signatures) — Rust, BBS+ and CL sigs
**Security status:** Secure
**Community acceptance:** Standard

---

## Ring & Group Signatures

**Goal:** Sign on behalf of a group/ring without revealing which member signed. Provides anonymity within a set.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **Ring Signatures (Rivest-Shamir-Tauman)** | 2001 | Ring | Ad-hoc group, no setup; used in Monero (pre-2020) [[1]](https://link.springer.com/chapter/10.1007/3-540-45682-1_32) |
| **CLSAG** | 2019 | Ring (linkable) | Compact Linkable Spontaneous; current Monero scheme [[1]](https://eprint.iacr.org/2019/654) |
| **Group Signatures (BBS04)** | 2004 | Group | Requires group manager; revocable anonymity [[1]](https://eprint.iacr.org/2004/174) |
| **Short Group Sig (Boneh-Boyen-Shacham)** | 2004 | Group | Pairing-based; very short signatures [[1]](https://eprint.iacr.org/2004/174) |
| **Dynamic Group Signatures (Bellare-Shi-Zhang)** | 2005 | Group (dynamic) | Efficient join/revoke of members without re-keying; practical for real deployments [[1]](https://eprint.iacr.org/2005/385) |

**State of the art:** CLSAG (privacy coins), dynamic group sigs (enterprise with member management), Raptor (PQ ring sig).

**Production readiness:** Production
**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) — C++, CLSAG implementation
- [ring-signatures](https://github.com/nicolo-ribaudo/ring-signature) — JS, educational RST ring signatures
- [XRPL-Labs/xrpl-groupsig](https://github.com/nicolo-ribaudo/ring-signature) — reference implementations
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Adaptor Signatures / Scriptless Scripts

**Goal:** Conditional signatures. A "pre-signature" that becomes a valid signature only when a secret value is revealed — and revealing the signature reveals the secret. Enables trustless atomic swaps and payment channels without scripting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schnorr Adaptor Signatures** | 2018 | Schnorr / DLP | Pre-sign with respect to a point T; completion reveals discrete log of T [[1]](https://eprint.iacr.org/2020/476) |
| **ECDSA Adaptor Signatures** | 2020 | ECDSA | Adaptor for ECDSA; enables scriptless scripts on Bitcoin pre-Taproot [[1]](https://eprint.iacr.org/2020/476) |
| **Scriptless Scripts (Poelstra)** | 2017 | Schnorr + adaptor | Atomic swaps, payment channels, discreet log contracts — no on-chain scripts [[1]](https://download.wpsoftware.net/bitcoin/wizardry/mw-slides/2017-03-mit-bitcoin-expo/slides.pdf) |

**State of the art:** Schnorr adaptor sigs (Bitcoin Taproot), ECDSA adaptors (cross-chain swaps).

**Production readiness:** Experimental
**Implementations:**
- [LLFourn/secp256kfun](https://github.com/LLFourn/secp256kfun) — Rust, adaptor signatures for secp256k1
- [BlockstreamResearch/scriptless-scripts](https://github.com/BlockstreamResearch/scriptless-scripts) — documentation and reference
- [comit-network/rendezvous](https://github.com/nicolo-ribaudo/ring-signature) — Rust, cross-chain atomic swaps
**Security status:** Secure
**Community acceptance:** Emerging

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

**Production readiness:** Production
**Implementations:**
- [XMSS reference](https://github.com/XMSS/xmss-reference) — C, reference WOTS+ implementation
- [hash-sigs](https://github.com/cisco/hash-sigs) — C, LMS/HSS with LM-OTS
- [sphincsplus](https://github.com/sphincs/sphincsplus) — C, reference SPHINCS+ with WOTS+ and FORS
**Security status:** Secure
**Community acceptance:** Standard

---

## Attribute-Based Signatures (ABS)

**Goal:** Policy-based authentication. Sign a message with a set of attributes; the signature verifies if the signer's attributes satisfy a policy — without revealing which attributes or the signer's identity. Dual of ABE for signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maji-Prabhakaran-Rosulek ABS** | 2011 | Pairings | First ABS with expressive policies (monotone span programs) [[1]](https://eprint.iacr.org/2010/595) |
| **Sakai-Attrapadung ABS** | 2016 | Pairings | Efficient constant-size signatures for AND policies [[1]](https://eprint.iacr.org/2016/246) |
| **Lattice ABS** | 2014 | SIS / LWE | Post-quantum attribute-based signatures [[1]](https://eprint.iacr.org/2014/279) |

**State of the art:** Pairing-based ABS (practical), Lattice ABS (PQ setting).

**Production readiness:** Research
**Implementations:**
- [FAME-ABE](https://github.com/sagrawal87/ABE) — Python, pairing-based ABE (related ABS primitives)
- [lattice-abs](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes only
**Security status:** Secure
**Community acceptance:** Niche

---

## Sanitizable Signatures

**Goal:** Authorized modification. A signer designates a "sanitizer" who can modify specified parts of a signed message while keeping the signature valid. Non-designated parts remain immutable. Used in medical records, redactable documents.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ateniese et al.** | 2005 | Chameleon hash + sig | First sanitizable sig; sanitizer can change designated blocks [[1]](https://eprint.iacr.org/2004/245) |
| **Brzuska et al. (formal model)** | 2009 | Generic | Formal security definitions: immutability, accountability, transparency [[1]](https://link.springer.com/chapter/10.1007/978-3-642-00468-1_28) |
| **Sanitizable Sig with Accountability** | 2015 | Group sig + chameleon hash | Detect who sanitized; full accountability [[1]](https://eprint.iacr.org/2015/845) |

**State of the art:** Accountable sanitizable sigs (GDPR: right to modify medical records while preserving audit trail).

**Production readiness:** Research
**Implementations:**
- [battery-sse/san-sig](https://github.com/battery-sse) — Java, reference sanitizable signature implementations
- No widely-adopted production library exists
**Security status:** Secure
**Community acceptance:** Niche

---

## Homomorphic Signatures

**Goal:** Compute on authenticated data. Given signatures on messages m₁,...,mₙ, anyone can derive a valid signature on f(m₁,...,mₙ) without the signing key. Enables verifiable delegation of computation on signed datasets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Linearly Homomorphic Sig (Boneh-Freeman)** | 2011 | Pairings | Sign vectors; derive sig on any linear combination [[1]](https://eprint.iacr.org/2009/025) |
| **Fully Homomorphic Sig (Gennaro-Wichs)** | 2013 | FHE + SNARK | Sign data; derive sig on ANY computable function [[1]](https://eprint.iacr.org/2012/023) |
| **Homomorphic Sig for Polynomials (Catalano-Fiore)** | 2013 | Pairings | Evaluate multivariate polynomials on signed data [[1]](https://eprint.iacr.org/2013/433) |

**State of the art:** Linear homomorphic sigs (practical, used in network coding), fully homomorphic sigs (theoretical).

**Production readiness:** Research
**Implementations:**
- [linearsig](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes for linearly homomorphic sigs
- No production-quality library; fully homomorphic sigs remain theoretical
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Research
**Implementations:**
- [AHO-SPS reference](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes in pairing libraries
- [MCL](https://github.com/herumi/mcl) — C++, pairing library used to implement SPS schemes
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit suitable for SPS implementations
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Mature
**Implementations:**
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) — Rust/TypeScript, BBS+ rerandomizable sigs
- [hyperledger/ursa](https://github.com/nicolo-ribaudo/blind-rsa-signatures) — Rust, CL signatures
- [coconut](https://github.com/nicolo-ribaudo/ring-signature) — Python, PS-based Coconut credentials
**Security status:** Secure
**Community acceptance:** Widely trusted

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

**Production readiness:** Production
**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) — C, TLS 1.3 ephemeral DH forward secrecy
- [signal-protocol](https://github.com/nicolo-ribaudo/ring-signature) — multiple languages, Double Ratchet forward secrecy
- [rustls](https://github.com/rustls/rustls) — Rust, TLS 1.3 with forward secrecy
**Security status:** Secure
**Community acceptance:** Standard

---

## Sequential Aggregate Signatures

**Goal:** Chain-ordered aggregation. Each signer in sequence adds their signature to the aggregate — the final result is one compact signature validating all signers in order. Used in BGP route attestation, certificate chains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lysyanskaya-Micali-Reyzin-Shacham (LMRS)** | 2004 | RSA + certified trapdoor | First sequential aggregate sig; signer-by-signer aggregation [[1]](https://eprint.iacr.org/2003/197) |
| **Boneh-Gentry-Lynn-Shacham (BGLS)** | 2003 | BLS + pairings | Non-sequential aggregate: any order; see [Digital Signatures](#digital-signatures) for BLS [[1]](https://eprint.iacr.org/2002/175) |
| **History-Free Sequential Aggregate (HSA)** | 2012 | RSA-based | No need to see previous messages; only aggregate sig passed along [[1]](https://eprint.iacr.org/2012/486) |

**State of the art:** BGLS (general aggregation), LMRS (sequential/routing), HSA (bandwidth-optimized).

**Production readiness:** Mature
**Implementations:**
- [blst](https://github.com/nicolo-ribaudo/ring-signature) — C/Rust, BLS aggregation (non-sequential)
- [BGLS-reference](https://github.com/nicolo-ribaudo/ring-signature) — academic reference implementations
**Security status:** Secure
**Community acceptance:** Niche

---

## Accountable Multi-Signatures / Subgroup Signatures

**Goal:** Identify non-signers. In a multi-signature or threshold protocol, produce a compact proof that identifies *which* parties signed (or failed to sign). Important for BFT consensus where non-signing validators must be slashed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Drijvers-Neven (Compact Multi-Sig)** | 2018 | BLS + aggregation | Aggregate BLS sigs with signer bitmap; used in Ethereum [[1]](https://eprint.iacr.org/2018/483) |
| **Accountable Subgroup Multi-Sig (ASM)** | 2021 | Schnorr / BLS | Identify exactly which subset signed; penalty for absence [[1]](https://eprint.iacr.org/2021/1351) |
| **Pixel (forward-secure multi-sig)** | 2019 | Pairings | Forward-secure aggregatable sigs for blockchain consensus [[1]](https://eprint.iacr.org/2019/514) |

**State of the art:** BLS + bitmap (Ethereum consensus), ASM (PoS slashing).

**Production readiness:** Production
**Implementations:**
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) — Python, BLS + bitmap aggregation
- [blst](https://github.com/supranational/blst) — C/Rust, BLS12-381 aggregate sigs for Ethereum
- [AggregatedBLS](https://github.com/nicolo-ribaudo/ring-signature) — reference implementations
**Security status:** Secure
**Community acceptance:** Widely trusted

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

**Production readiness:** Experimental
**Implementations:**
- [blind-rsa-signatures](https://github.com/nicolo-ribaudo/blind-rsa-signatures) — JS/Go, partial blindness variants
- Academic reference implementations only for pairing and lattice PBS
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Production
**Implementations:**
- [blst](https://github.com/supranational/blst) — C/Rust/Go, BLS12-381 aggregation (Ethereum)
- [herumi/bls](https://github.com/herumi/bls) — C++/Go, BLS signature library
- [noble-bls12-381](https://github.com/nicolo-ribaudo/ring-signature) — TypeScript, BLS for web
**Security status:** Secure
**Community acceptance:** Standard

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

**Production readiness:** Production
**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) — C++, RingCT / CLSAG
- [Triptych](https://github.com/nicolo-ribaudo/ring-signature) — Rust, Monero Research Lab prototype
- [ring-ct](https://github.com/nicolo-ribaudo/ring-signature) — academic reference implementations
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Threshold Blind Signatures

**Goal:** Distributed blind signing. A threshold t-of-n signers jointly produce a blind signature — no individual signer sees the message, and no fewer than t signers can produce a valid signature. Combines the anonymity of [Blind Signatures](#blind-signatures) with the distributed trust of [Threshold Signatures](#threshold-signature-schemes-tss).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boldyreva Threshold Blind Sig** | 2003 | Gap-DH | First efficient threshold blind signature; based on BLS [[1]](https://eprint.iacr.org/2002/118) |
| **Threshold Blind BLS (Tomescu et al.)** | 2022 | BLS + DKG | Practical threshold blind BLS for anonymous token issuance [[1]](https://eprint.iacr.org/2022/1095) |
| **Lattice Threshold Blind Sig** | 2025 | SIS | First post-quantum threshold blind signature from lattices [[1]](https://eprint.iacr.org/2025/1566) |

**State of the art:** Lattice-based (PQ, 2025); BLS-based for production use. Combines [Blind Signatures](#blind-signatures), [Threshold Signatures](#threshold-signature-schemes-tss), and [Privacy Pass](#privacy-pass--anonymous-tokens).

**Production readiness:** Experimental
**Implementations:**
- [nicolo-ribaudo/tbs](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes
- [blind-threshold-bls](https://github.com/nicolo-ribaudo/ring-signature) — Rust, experimental threshold blind BLS
**Security status:** Secure
**Community acceptance:** Emerging

---

## Constrained / Policy-Based Signatures

**Goal:** Delegated signing with restrictions. Derive a constrained signing key that can only sign messages satisfying a predicate (e.g., "emails from @company.com", "transactions under $1000"). The master key signs anything; constrained keys are limited.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Fuchsbauer Policy-Based Sigs** | 2014 | Generic | Formal model; signing key restricted to a message space defined by a policy [[1]](https://eprint.iacr.org/2014/100) |
| **Boneh-Kim Constrained Sigs** | 2017 | Pairings / lattices | Constrained keys for circuit predicates; related to constrained PRFs [[1]](https://eprint.iacr.org/2017/502) |
| **Functional Signatures (Boyle-Goldwasser-Ivan)** | 2014 | iO / pairings | Sign f(m) using a key for function f, without seeing m [[1]](https://eprint.iacr.org/2013/401) |

**State of the art:** Constrained signatures from lattices (Boneh-Kim 2017); related to [Constrained PRFs](#puncturable--constrained-prf). Enables fine-grained delegation without proxy re-signing.

**Production readiness:** Research
**Implementations:**
- No production-quality implementations; academic prototypes accompany papers
- Related: [constrained-prf](https://github.com/nicolo-ribaudo/ring-signature) — conceptual overlap with constrained PRFs
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Mature
**Implementations:**
- [DVS-impl](https://github.com/nicolo-ribaudo/ring-signature) — academic reference implementations
- Pairing-based DVS available in [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Deprecated
**Implementations:**
- Historical implementations in early PGP-adjacent libraries
- No actively maintained production library
**Security status:** Superseded
**Community acceptance:** Niche

---

## Fail-Stop Signatures

**Goal:** Provable forgery detection. If an adversary with unbounded computational power forges a signature, the legitimate signer can produce an unconditional proof of forgery — the system "fails and stops" rather than silently accepting. Signers have information-theoretic protection; verifiers have computational protection. Strictly stronger than standard signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pfitzmann-Waidner Fail-Stop Sigs** | 1990 | Factoring + prekey | First fail-stop signature; signer proves forgery unconditionally [[1]](https://epubs.siam.org/doi/10.1137/S009753979324557X) |
| **Pedersen-Pfitzmann FSS** | 1997 | DLP | Efficient fail-stop from discrete log; SIAM J. Computing [[1]](https://epubs.siam.org/doi/10.1137/S009753979324557X) |
| **PQ Fail-Stop Sigs** | 2024 | Lattice | "That's Not My Signature!" — fail-stop for post-quantum world; CRYPTO 2024 [[1]](https://link.springer.com/chapter/10.1007/978-3-031-68376-3_4) |

**State of the art:** PQ fail-stop signatures (CRYPTO 2024); revived interest for post-quantum contexts. Extends [Digital Signatures](#digital-signatures).

**Production readiness:** Research
**Implementations:**
- [fail-stop-sigs](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes (CRYPTO 2024 paper)
- No production-quality library
**Security status:** Secure
**Community acceptance:** Niche

---

## Proxy Signatures

**Goal:** Delegated signing. Alice delegates her signing authority to Bob (proxy) who can sign messages on her behalf. The resulting signature is verifiable as a proxy signature, distinguishable from Alice's direct signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mambo-Usuda-Okamoto** | 1996 | DLP | First proxy signature scheme; delegation by warrant [[1]](https://link.springer.com/chapter/10.1007/BFb0028379) |
| **Boldyreva et al. (proxy re-sig)** | 2003 | Bilinear pairings | Proxy re-signatures: convert Alice's sig into Bob's; see also [PRE](#proxy-re-encryption-pre) [[1]](https://eprint.iacr.org/2003/096) |
| **Short Proxy Sig (Fuchsbauer-Pointcheval)** | 2008 | Pairings | Efficient, short proxy signatures with security proof [[1]](https://eprint.iacr.org/2008/460) |

**State of the art:** proxy re-signatures (certificate translation), delegation by warrant (enterprise workflows).

**Production readiness:** Mature
**Implementations:**
- [proxy-re-sig](https://github.com/nicolo-ribaudo/ring-signature) — academic reference implementations
- Pairing-based constructions implementable via [MCL](https://github.com/herumi/mcl) — C++
**Security status:** Secure
**Community acceptance:** Niche

---

## Traceable Signatures

**Goal:** Accountability in group signatures. A group member can sign anonymously, but if they exceed a signing quota (e.g., sign more than k times in an epoch), the group manager can trace and identify them. Stronger than linkability — full identity recovery.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Traceable Sigs** | 2004 | DLP + pairings | First traceable sigs; manager traces over-signers; CCA-anonymous [[1]](https://eprint.iacr.org/2004/007) |
| **Traceable Sigs with Stepping Capabilities** | 2008 | Pairings | Incremental tracing: trace after threshold violations [[1]](https://doi.org/10.1007/978-3-540-78967-3_7) |
| **Lattice Traceable Sigs** | 2019 | LWE / SIS | Post-quantum traceable group signatures [[1]](https://eprint.iacr.org/2019/1158) |

**State of the art:** Lattice-based traceable sigs for PQ; extends [Ring & Group Signatures](#ring--group-signatures) and [Linkable Ring Signatures](#linkable-ring-signatures) with full traceability.

**Production readiness:** Research
**Implementations:**
- Academic prototypes accompany published papers
- Implementable via [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit
**Security status:** Secure
**Community acceptance:** Niche

---

## Ring VRF

**Goal:** Anonymous pseudorandom identity. Combine ring signature anonymity with VRF pseudorandomness: prove membership in a ring and output a unique, deterministic, unlinkable pseudonym per context — without revealing which ring member you are.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burdges-de Valence-Hopwood-Patak Ring VRF** | 2023 | Schnorr + ring + VRF | First Ring VRF; unlinkable pseudonymous identity across contexts [[1]](https://eprint.iacr.org/2023/002) |
| **ZK Continuations for Ring VRF** | 2023 | Groth16 + recursion | Efficient Ring VRF via recursive ZK proofs [[1]](https://eprint.iacr.org/2023/002) |

**State of the art:** Ring VRF (2023); enables anonymous rate-limiting, anonymous login, and credential systems. Combines [VRF](#verifiable-random-functions-vrf) and [Ring Signatures](#ring--group-signatures).

**Production readiness:** Experimental
**Implementations:**
- [nicolo-ribaudo/ring-vrf](https://github.com/nicolo-ribaudo/ring-signature) — Rust, ring VRF prototype
- [w3f/ring-vrf](https://github.com/nicolo-ribaudo/ring-signature) — Rust, Web3 Foundation ring VRF research
**Security status:** Secure
**Community acceptance:** Emerging

---

## Threshold Ring Signatures

**Goal:** Anonymous threshold signing. At least t members of a ring must cooperate to produce a valid signature, but the ring hides which members signed. Combines the anonymity of ring signatures with the distributed trust of threshold signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bresson-Stern-Szydlo TRS** | 2002 | DLP | First threshold ring signature; t-of-n from a ring of N [[1]](https://doi.org/10.1007/3-540-36178-2_20) |
| **Tsang-Wei TRS** | 2005 | Pairings | Short threshold ring sigs; separable threshold from ring [[1]](https://doi.org/10.1007/978-3-540-30580-4_27) |
| **Lattice TRS (Cayrel et al.)** | 2010 | Lattice (SIS) | Post-quantum threshold ring signatures [[1]](https://doi.org/10.1007/978-3-642-14423-3_18) |

**State of the art:** Lattice-based TRS for PQ. Combines [Ring & Group Signatures](#ring--group-signatures) and [Threshold Signatures](#threshold-signature-schemes-tss).

**Production readiness:** Research
**Implementations:**
- Academic reference implementations only
- Lattice TRS implementable via [liboqs](https://github.com/open-quantum-safe/liboqs) — C, PQ crypto toolkit
**Security status:** Secure
**Community acceptance:** Niche

---

## Broadcast Authentication (TESLA)

**Goal:** Asymmetric authentication from symmetric primitives. Authenticate broadcast/multicast messages using only MACs — the time delay between sending and key disclosure creates an asymmetry that prevents forgery. No public-key crypto needed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **TESLA** | 2000 | Hash chain + MAC | Timed Efficient Stream Loss-tolerant Authentication; delayed key disclosure [[1]](https://doi.org/10.1109/JSAC.2002.806128) |
| **μTESLA** | 2002 | TESLA + sensor optimizations | Lightweight TESLA for sensor networks; base station bootstraps keys [[1]](https://doi.org/10.1145/586110.586132) |
| **TESLA++** | 2003 | TESLA + immediate auth | Hybrid: some packets immediately verifiable, rest via TESLA [[1]](https://doi.org/10.1145/948109.948113) |

**State of the art:** TESLA for multicast authentication; μTESLA for IoT/sensor networks. Alternative to [Digital Signatures](#digital-signatures) when computation is constrained.

**Production readiness:** Mature
**Implementations:**
- [contiki-ng](https://github.com/contiki-ng/contiki-ng) — C, includes TESLA for IoT broadcast auth
- [uTESLA implementations](https://github.com/nicolo-ribaudo/ring-signature) — C, sensor network authentication
**Security status:** Secure
**Community acceptance:** Niche

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

**Production readiness:** Mature
**Implementations:**
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing-based IBS implementations
- [charm-crypto](https://github.com/JHUISI/charm) — Python, pairing-based IBS and IBE
- [MCL](https://github.com/herumi/mcl) — C++, efficient pairings for IBS
**Security status:** Secure
**Community acceptance:** Niche

---

## MuSig / MuSig2 (Schnorr Multi-Signatures)

**Goal:** Key-aggregating n-of-n multi-signatures. All n signers jointly produce a single standard Schnorr signature valid under an aggregate public key indistinguishable from a single-signer key. Enables cooperative Bitcoin Taproot key-path spends with no on-chain multi-sig overhead.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **MuSig1 (Maxwell-Poelstra-Seurin-Wuille)** | 2018 | Schnorr / DLP | First provably secure key-aggregating Schnorr multi-sig; 3 communication rounds [[1]](https://eprint.iacr.org/2018/068) |
| **MuSig2 (Nick-Ruffing-Seurin)** | 2020 | Schnorr / AOMDL | Reduces to 2 rounds (1 preprocessing + 1 online); concurrent-session secure; BIP 327 [[1]](https://eprint.iacr.org/2020/1261) |
| **MuSig-DN (deterministic nonces)** | 2020 | Schnorr + NIZK | Deterministic nonce generation with ZK proof; eliminates per-session randomness [[1]](https://eprint.iacr.org/2020/1057) |
| **MuSig-L (lattice)** | 2022 | Module lattice | First lattice-based multi-sig with key aggregation, PPK-model security, and single online round [[1]](https://eprint.iacr.org/2022/1036) |

MuSig2 is the n-of-n variant of [Threshold Signature Schemes](#threshold-signature-schemes-tss). Key aggregation means the combined public key is computationally indistinguishable from an ordinary Schnorr public key — on-chain footprint is a single 32-byte x-only key (BIP 340) and a single 64-byte signature, regardless of signer count. Security is proved under the algebraic one-more discrete logarithm (AOMDL) assumption. Rogue-key attacks are prevented by requiring a proof of knowledge of each individual public key before aggregation.

**State of the art:** MuSig2 (BIP 327, Bitcoin Taproot); MuSig-L for post-quantum multi-signatures. See [Threshold Signature Schemes](#threshold-signature-schemes-tss) for t-of-n variants.

**Production readiness:** Production
**Implementations:**
- [secp256k1-zkp](https://github.com/BlockstreamResearch/secp256k1-zkp) — C, MuSig2 module
- [musig2-py](https://github.com/nicolo-ribaudo/ring-signature) — Python, BIP 327 reference
- [frost](https://github.com/ZcashFoundation/frost) — Rust, includes MuSig2-compatible signing
**Security status:** Secure
**Community acceptance:** Standard

---

## Boneh-Boyen (BB) Short Signatures

**Goal:** Standard-model short signatures. Achieve existential unforgeability under chosen-message attack without random oracles, using a pairing-based construction and the q-Strong Diffie-Hellman (q-SDH) assumption. Signatures consist of a single group element — the shortest possible for pairing-based schemes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BB Basic (Boneh-Boyen)** | 2004 | Pairings / q-SDH | Short sigs without random oracle; one G₁ element; EUROCRYPT 2004 [[1]](https://eprint.iacr.org/2004/171) |
| **BB Full (Boneh-Boyen)** | 2004 | Pairings / q-SDH + q-BSDH | Stronger unforgeability under two assumptions; signing key can verify [[1]](https://eprint.iacr.org/2004/171) |
| **Waters Signatures** | 2005 | Pairings / CDH | Fully secure standard-model sigs under plain CDH (no q-type assumption); basis of many IBE/IBS constructions [[1]](https://eprint.iacr.org/2005/097) |
| **Short Group Sigs (BBS04)** | 2004 | Pairings / SDH + DLIN | Group signatures of RSA size from q-SDH and Decision Linear; CRYPTO 2004; ancestor of BBS+ [[1]](https://eprint.iacr.org/2004/174) |

BB signatures fill the gap between BLS (random-oracle model, single group element) and earlier standard-model schemes (which required large signatures or strong assumptions). The q-SDH assumption — no PPT adversary can compute a new (c, g^{1/(x+c)}) pair given g, g^x, …, g^{x^q} — is analogous to Strong RSA. Waters signatures weaken the assumption to plain CDH at the cost of slightly larger public keys; they became the template for numerous IBE and ABE constructions. BBS04 group signatures are the structural ancestor of BBS+ rerandomizable credentials.

**State of the art:** BB signatures (standard-model short sigs), Waters signatures (CDH-based, used in IBE/ABS constructions), BBS04 → BBS+ (W3C anonymous credentials). Cross-links: [Structure-Preserving Signatures](#structure-preserving-signatures-sps), [Rerandomizable Signatures](#rerandomizable-signatures-ps-signatures), [BLS Aggregate](#aggregate-signatures-bls-aggregate).

**Production readiness:** Mature
**Implementations:**
- [MCL](https://github.com/herumi/mcl) — C++, pairing library for BB and Waters signatures
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit with BB support
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) — Rust, BBS04/BBS+ (BB descendant)
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Stateful Hash-Based Signatures (XMSS & LMS)

**Goal:** Post-quantum stateful tree signatures. Authenticate many messages using a Merkle tree of one-time keys; the signer advances a state counter so each leaf is used at most once. Security depends only on hash function properties — no number-theoretic assumptions. Standardized for use before PQC deployment is complete.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **XMSS (eXtended Merkle Signature Scheme)** | 2011 | Hash tree + WOTS+ | Single-tree stateful scheme; minimal security assumptions; RFC 8391 (2018) [[1]](https://www.rfc-editor.org/rfc/rfc8391) |
| **XMSS^MT (multi-tree)** | 2013 | Hash forest + WOTS+ | Hierarchical multi-tree variant; fast key generation; RFC 8391 [[1]](https://www.rfc-editor.org/rfc/rfc8391) |
| **LMS (Leighton-Micali Signatures)** | 1995 | Hash tree + LM-OTS | Simpler Merkle tree structure; hardware-friendly; RFC 8554 (2019) [[1]](https://www.rfc-editor.org/rfc/rfc8554) |
| **HSS (Hierarchical Signature System)** | 1995 | LMS forest | Multi-level LMS tree; scales to billions of signatures per key; RFC 8554 [[1]](https://www.rfc-editor.org/rfc/rfc8554) |
| **NIST SP 800-208** | 2020 | XMSS + LMS profiles | NIST recommendation approving both families; governs parameter set selection [[1]](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-208.pdf) |

Stateful schemes require careful state management: reusing a leaf index is catastrophic (it reveals the one-time key). This makes them unsuitable for general software use but appropriate for controlled environments such as firmware signing, code signing, and PKI root CAs. XMSS has the smallest signatures of any hash-based stateful scheme. LMS/HSS is simpler to implement and favored for hardware security modules (HSMs). Both families are built on [One-Time Signatures (OTS)](#one-time-signatures-ots) as leaf-level primitives — XMSS uses WOTS+, LMS uses LM-OTS.

**State of the art:** LMS/HSS preferred for HSM firmware signing (CNSA 2.0 mandated for national-security code signing by 2030); XMSS for applications where signature size is critical. Contrast with [ML-DSA & SLH-DSA](#nist-pqc-signature-standards-ml-dsa--slh-dsa) (stateless, general-purpose PQ standards).

**Production readiness:** Production
**Implementations:**
- [XMSS reference](https://github.com/XMSS/xmss-reference) — C, NIST-recommended reference
- [hash-sigs](https://github.com/cisco/hash-sigs) — C, LMS/HSS reference implementation
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, includes XMSS and LMS
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, XMSS and LMS support
**Security status:** Secure
**Community acceptance:** Standard

---

## NIST PQC Signature Standards (ML-DSA & SLH-DSA)

**Goal:** Drop-in post-quantum replacements for RSA and ECDSA. Standardized by NIST in August 2024 as FIPS 204 (ML-DSA) and FIPS 205 (SLH-DSA), these algorithms are designed to be secure against both classical and quantum adversaries and are the primary migration targets for digital signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ML-DSA (CRYSTALS-Dilithium)** | 2017 | Module LWE + SIS | Lattice-based; FIPS 204; primary standard; three security levels (ML-DSA-44/65/87) [[1]](https://csrc.nist.gov/pubs/fips/204/final) |
| **SLH-DSA (SPHINCS+)** | 2019 | Hash tree + WOTS+ + FORS | Stateless hash-based; FIPS 205; conservative choice; small keys, large sigs [[1]](https://csrc.nist.gov/pubs/fips/205/final) |
| **FALCON (FN-DSA)** | 2017 | NTRU lattice + FFT | NIST selected as FIPS 206; compact sigs; complex implementation; see [PQC](#post-quantum-cryptography-pqc) [[1]](https://csrc.nist.gov/pubs/fips/206/final) |
| **Dilithium-G (CRYSTALS)** | 2018 | Module lattice | Earlier name; Dilithium Mode 2/3/5 maps to ML-DSA-44/65/87; same algorithm [[1]](https://eprint.iacr.org/2017/633) |

ML-DSA is based on the hardness of Module Learning With Errors (MLWE) and Module Short Integer Solution (MSIS) problems. Signing produces a polynomial hint vector alongside a short lattice response; verification checks a linear relation over module lattices. Public keys are ~1312 bytes (level 2); signatures ~2420 bytes — significantly larger than ECDSA but fast to sign and verify. SLH-DSA (SPHINCS+) is the "hash-only" conservative choice: its security reduces entirely to hash function properties (preimage resistance, second-preimage resistance) with no algebraic assumptions. It is stateless (unlike XMSS/LMS), but signatures are large (7–50 KB depending on variant). NIST recommends ML-DSA as the primary standard and SLH-DSA as a conservative backup.

**State of the art:** FIPS 204 (ML-DSA) and FIPS 205 (SLH-DSA) finalized August 2024; NIST migration deadline for federal systems is 2030. Cross-links: [One-Time Signatures (OTS)](#one-time-signatures-ots) (WOTS+/FORS building blocks), [Stateful Hash-Based Signatures](#stateful-hash-based-signatures-xmss--lms) (XMSS/LMS), [PQC in the quantum-cryptography category](categories/15-quantum-cryptography.md#post-quantum-cryptography-pqc).

**Production readiness:** Production
**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, ML-DSA and SLH-DSA
- [PQClean](https://github.com/PQClean/PQClean) — C, clean reference implementations
- [pqcrypto](https://github.com/nicolo-ribaudo/ring-signature) — Rust, ML-DSA and SLH-DSA bindings
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, ML-DSA and SLH-DSA
**Security status:** Secure
**Community acceptance:** Standard

---

## DKLs23 & Next-Generation Threshold ECDSA

**Goal:** Efficient maliciously-secure threshold ECDSA. Achieve t-of-n ECDSA signing with UC-security against a dishonest majority in the minimum number of rounds, replacing the expensive Paillier-based arithmetic of GG18/GG20 with oblivious transfer (OT) extensions for a dramatically faster protocol.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GG18 (Gennaro-Goldfeder)** | 2018 | ECDSA + Paillier | First practical threshold ECDSA; MtA via Paillier HE; 6 rounds [[1]](https://eprint.iacr.org/2019/114) |
| **GG20 (Gennaro-Goldfeder)** | 2020 | ECDSA + Paillier + presign | Adds identifiable abort; presigning reduces online rounds; widely deployed [[1]](https://eprint.iacr.org/2020/540) |
| **CGGMP21 (Canetti-Gennaro-Goldfeder-Makriyannis-Peled)** | 2021 | ECDSA + Paillier | UC-secure, proactive, non-interactive presign, identifiable abort; production standard [[1]](https://eprint.iacr.org/2021/060) |
| **DKLs18 (Doerner-Kondi-Lee-Shelat)** | 2018 | ECDSA + OT | 2-of-n threshold ECDSA via OT; avoids Paillier; faster in practice [[1]](https://eprint.iacr.org/2018/499) |
| **DKLs23 (Doerner-Kondi-Lee-Shelat)** | 2023 | ECDSA + OT + UC | UC-secure t-of-n in 3 rounds; OT replaces MtA; information-theoretic interior [[1]](https://eprint.iacr.org/2023/765) |

The core challenge of threshold ECDSA is that the signing equation requires a product of secret shares (the nonce inverse times the key), which is not naturally linear. GG18/GG20/CGGMP21 solve this via multiplicative-to-additive (MtA) conversion using Paillier encryption — correct but expensive in bandwidth and computation. DKLs18/23 replace MtA with correlated OT extensions: two-party multiplication (2PC-Mul) built on OT is faster, avoids the Paillier key-generation overhead, and achieves UC-security with an information-theoretic commitment layer. DKLs23 achieves 3-round online signing (down from 6 in GG20) and is the current state of the art for maliciously-secure threshold ECDSA.

**State of the art:** CGGMP21 (production MPC wallets, e.g. Fireblocks, ZenGo); DKLs23 (leading academic construction; adoption growing, e.g. Vultisig). Extends [Threshold Signature Schemes](#threshold-signature-schemes-tss). For Schnorr threshold signing see [FROST](#threshold-signature-schemes-tss).

**Production readiness:** Production
**Implementations:**
- [multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) — Rust, GG18/GG20/CGGMP
- [tss-lib](https://github.com/bnb-chain/tss-lib) — Go, Binance threshold ECDSA
- [DKLs23 reference](https://github.com/nicolo-ribaudo/ring-signature) — academic prototype
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Schnorr Signatures (Original Scheme)

**Goal:** Efficient, provably secure discrete-log signatures. Sign a message using a short commitment-response protocol; security is provable in the random oracle model under the discrete logarithm assumption — the simplest signature scheme to achieve this.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schnorr (original)** | 1991 | DLP in prime-order group | Commitment R = g^k, challenge e = H(R ‖ m), response s = k − xe; sig is (R, s) [[1]](https://doi.org/10.1007/0-387-34805-0_22) |
| **Schnorr (patent-free, standardized)** | 2008 | DLP | ISO/IEC 14888-3 standardization after U.S. patent 4,995,082 expired Feb 2010 [[1]](https://www.iso.org/standard/43269.html) |
| **BIP 340 Schnorr (Bitcoin)** | 2020 | secp256k1 | x-only public keys; 64-byte signatures; batch-verifiable; Taproot [[1]](https://github.com/bitcoin/bips/blob/master/bip-0340.mediawiki) |
| **EdDSA (Schnorr on Edwards curves)** | 2011 | Twisted Edwards / Schnorr | Deterministic Schnorr variant; see [EdDSA](#eddsa-ed25519--ed448) below [[1]](https://eprint.iacr.org/2011/368) |

Schnorr signatures are strictly simpler than ECDSA: signing requires one scalar multiplication and one hash; verification requires two scalar multiplications. They are linearly homomorphic in the response value, which enables [MuSig2](#musig--musig2-schnorr-multi-signatures) key aggregation, [FROST](#threshold-signature-schemes-tss) threshold signing, and [adaptor signatures](#adaptor-signatures--scriptless-scripts) with no modification to verifiers. The original scheme was encumbered by a U.S. patent until 2010, which partly explains why DSA (and later ECDSA) became the dominant standard despite Schnorr's simpler security proof.

**State of the art:** BIP 340 Schnorr (Bitcoin Taproot); EdDSA (TLS 1.3, SSH, Signal). Foundation of [MuSig2](#musig--musig2-schnorr-multi-signatures), [FROST](#threshold-signature-schemes-tss), [Adaptor Signatures](#adaptor-signatures--scriptless-scripts), and [Ring VRF](#ring-vrf).

**Production readiness:** Production
**Implementations:**
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) — C, BIP 340 Schnorr for Bitcoin
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) — Rust, EdDSA (Schnorr variant)
- [noble-secp256k1](https://github.com/nicolo-ribaudo/ring-signature) — TypeScript, Schnorr signatures
**Security status:** Secure
**Community acceptance:** Standard

---

## EdDSA (Ed25519 & Ed448)

**Goal:** High-speed, misuse-resistant signatures. A deterministic Schnorr variant over twisted Edwards curves; the nonce is derived from the private key and message via a hash, eliminating the need for a secure random number generator during signing and preventing the catastrophic nonce-reuse vulnerability of ECDSA.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ed25519** | 2011 | edwards25519 (≅ Curve25519) + SHA-512 | 128-bit security; 32-byte public key; 64-byte signature; ~100k signs/sec [[1]](https://eprint.iacr.org/2011/368) |
| **Ed448 (Goldilocks)** | 2015 | edwards448 + SHAKE256 | 224-bit security; 57-byte public key; 114-byte signature; conservative curve [[1]](https://eprint.iacr.org/2015/625) |
| **RFC 8032** | 2017 | IETF standard | Standardizes Ed25519 and Ed448; specifies PureEdDSA and HashEdDSA variants [[1]](https://www.rfc-editor.org/rfc/rfc8032) |
| **FIPS 186-5** | 2023 | NIST standard | Approves Ed25519 and Ed448 for federal use alongside ECDSA and RSA [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf) |
| **FROST-Ed25519 / FROST-Ed448** | 2024 | RFC 9591 | Threshold EdDSA-compatible signing via FROST; 2-round protocol [[1]](https://www.rfc-editor.org/rfc/rfc9591) |

EdDSA improves on ECDSA in three concrete ways: (1) the nonce k is deterministic (derived as H(private\_key\_prefix ‖ message)), so no per-sign entropy is needed; (2) the curve arithmetic is complete (no special-case for the point at infinity), eliminating an entire class of implementation bugs; (3) signatures are not malleable. The determinism also means EdDSA is collision-resilient for PureEdDSA: a hash collision does not break unforgeability. Ed25519 is widely deployed in TLS 1.3, SSH, Signal, WireGuard, OpenPGP, and age. FROST (RFC 9591) provides threshold EdDSA-compatible signing.

**State of the art:** Ed25519 (de-facto standard for modern protocols); FROST-Ed25519 (RFC 9591, threshold). See [Schnorr Signatures](#schnorr-signatures-original-scheme) for the underlying primitive and [FROST](#threshold-signature-schemes-tss) for threshold context.

**Production readiness:** Production
**Implementations:**
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) — Rust, Ed25519
- [libsodium](https://github.com/jedisct1/libsodium) — C, Ed25519
- [golang/crypto](https://github.com/golang/crypto) — Go, Ed25519
- [BoringSSL](https://github.com/nicolo-ribaudo/ring-signature) — C, Ed25519 in TLS
**Security status:** Secure
**Community acceptance:** Standard

---

## ECDSA — Details, Vulnerabilities, and RFC 6979

**Goal:** Elliptic-curve digital signatures with standardized security. ECDSA is the dominant deployed signature scheme (Bitcoin, TLS certificates, code signing), but its security is highly sensitive to nonce quality — a single reused or biased nonce leaks the private key.

| Aspect | Year | Detail | Note |
|--------|------|--------|------|
| **ECDSA (original)** | 1992 | FIPS 186 / ANSI X9.62 | r = (k·G).x mod n; s = k⁻¹(H(m) + r·d) mod n; random nonce k per signature [[1]](https://doi.org/10.6028/NIST.FIPS.186-5) |
| **Nonce reuse attack** | 2010 | Algebraic | Two signatures with same k → private key recovery; Sony PS3 (2010) used constant k; key extracted publicly [[1]](https://www.schneier.com/blog/archives/2011/01/sony_ps3_securi.html) |
| **Biased-nonce attack (Minerva)** | 2020 | Lattice-based HNP | Even a few bits of nonce bias → private key via Hidden Number Problem; affects smart cards [[1]](https://eprint.iacr.org/2020/728) |
| **RFC 6979 (deterministic ECDSA)** | 2013 | HMAC-DRBG | Derives k deterministically from (private key ‖ message) via HMAC-DRBG; no RNG needed; standard-compatible [[1]](https://www.rfc-editor.org/rfc/rfc6979) |
| **ECDSA malleability** | — | Algebraic | (r, s) and (r, −s mod n) are both valid for same message; Bitcoin's BIP 62/146 address low-s restriction [[1]](https://github.com/bitcoin/bips/blob/master/bip-0062.mediawiki) |
| **Fault/DPA side-channel** | 2017 | Physical | Deterministic nonces (RFC 6979) are vulnerable to fault + power analysis (→ key extraction); countermeasure: add per-sign randomness (hedged signing) [[1]](https://eprint.iacr.org/2017/1014) |

ECDSA's malleability and nonce sensitivity stand in contrast to [Schnorr](#schnorr-signatures-original-scheme)/[EdDSA](#eddsa-ed25519--ed448), which are structurally non-malleable and deterministic by design. Threshold ECDSA is hard precisely because of the nonce inversion (k⁻¹) which creates a multiplicative dependency — see [DKLs23](#dkls23--next-generation-threshold-ecdsa). FIPS 186-5 (2023) continues to approve ECDSA and adds Ed25519/Ed448.

**State of the art:** RFC 6979 deterministic ECDSA widely deployed (libsecp256k1, BoringSSL); ECDSA being superseded by Ed25519 in new protocols. For threshold ECDSA see [DKLs23](#dkls23--next-generation-threshold-ecdsa).

**Production readiness:** Production
**Implementations:**
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) — C, ECDSA with RFC 6979
- [OpenSSL](https://github.com/openssl/openssl) — C, ECDSA for TLS
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, ECDSA with RFC 6979
- [ring](https://github.com/nicolo-ribaudo/ring-signature) — Rust, ECDSA
**Security status:** Caution
**Community acceptance:** Standard

---

## RSA-PSS vs. PKCS#1 v1.5 Signatures

**Goal:** Provably secure RSA-based signatures. RSA-PSS (Probabilistic Signature Scheme) was designed by Bellare and Rogaway (1996) to achieve tight security reductions to the RSA problem, replacing the ad-hoc PKCS#1 v1.5 padding whose security cannot be formally proved.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSASSA-PKCS1-v1_5** | 1993 | RSA + deterministic padding | DER-encode hash OID + digest; prepend 0x00 0x01 0xFF… 0x00; deterministic; widely deployed but no tight security proof [[1]](https://www.rfc-editor.org/rfc/rfc8017) |
| **Bleichenbacher's attack (PKCS#1 v1.5)** | 1998 | Padding oracle | Signature forgery via specially crafted padding; affects weak implementations; motivated PKCS#1 v2.0 [[1]](https://link.springer.com/chapter/10.1007/BFb0055716) |
| **RSA-PSS (RSASSA-PSS)** | 1996 | RSA + randomized MGF1 padding | Probabilistic; random salt r; tight ROM security proof under RSA assumption; PKCS#1 v2.1 [[1]](https://eprint.iacr.org/2023/274) |
| **FIPS 186-5 (2023)** | 2023 | NIST standard | Recommends RSA-PSS for new applications; retains PKCS#1 v1.5 for legacy; mandates approved hash functions [[1]](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf) |
| **PKCS#1 v1.5 security (Jager et al.)** | 2018 | Theoretical | Proves PKCS#1 v1.5 signatures are UF-CMA secure under "partial one-more RSA" assumption, but proof is non-tight [[1]](https://eprint.iacr.org/2018/855) |

RSA-PSS signing appends a random salt (typically 32–64 bytes) before applying the MGF1 mask-generation function; this randomization makes two signatures on the same message unlinkable and enables a clean security reduction. PKCS#1 v1.5 is deterministic (same key + message → same signature) and its security relies on the structural complexity of the padding being hard to invert — a property that has no clean formal proof and has historically produced exploitable implementation gaps (e.g., the 2006 Daniel Bleichenbacher RSA signature forgery against flawed PKCS#1 v1.5 verifiers). FIPS 186-5 and TLS 1.3 (RFC 8446) mandate RSA-PSS for new key usage.

**State of the art:** RSA-PSS mandated by TLS 1.3, FIPS 186-5, and X.509 code-signing CAs. PKCS#1 v1.5 retained for legacy TLS 1.2 server certificates. Both superseded by ECDSA/Ed25519 in new protocol designs.

**Production readiness:** Production
**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) — C, RSA-PSS and PKCS#1 v1.5
- [BoringSSL](https://github.com/nicolo-ribaudo/ring-signature) — C, RSA-PSS for TLS 1.3
- [ring](https://github.com/nicolo-ribaudo/ring-signature) — Rust, RSA-PSS
**Security status:** Caution
**Community acceptance:** Standard

---

## Falcon / FN-DSA (NTRU-Based Lattice Signatures)

**Goal:** Compact post-quantum signatures. Falcon uses NTRU lattices and Fast Fourier sampling to produce signatures significantly smaller than ML-DSA (Dilithium) while achieving the same security level — at the cost of a more complex implementation requiring careful handling of floating-point arithmetic.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Falcon-512** | 2017 | NTRU lattice + GPV hash-then-sign | Security level 1 (~128-bit); pk = 897 B; sig = 666 B average; fast FFT signing [[1]](https://falcon-sign.info/) |
| **Falcon-1024** | 2017 | NTRU lattice | Security level 5 (~256-bit); pk = 1793 B; sig = 1280 B average; most conservative choice [[1]](https://falcon-sign.info/) |
| **FN-DSA (FIPS 206)** | 2024 | NTRU lattice (standardized) | NIST standardization of Falcon as FN-DSA; FIPS 206 finalized August 2024; two parameter sets: FN-DSA-512 and FN-DSA-1024 [[1]](https://csrc.nist.gov/pubs/fips/206/final) |
| **Fast Fourier Sampling (GPV)** | 2008 | NTRU trapdoor | Gentry-Peikert-Vaikuntanathan framework; Falcon instantiates GPV over NTRU ring ℤ_q[X]/(Xⁿ+1) for compact trapdoor [[1]](https://eprint.iacr.org/2007/432) |

Falcon's signing algorithm samples a short lattice vector close to a target point derived from H(message). This requires sampling from a discrete Gaussian distribution over an NTRU lattice, which Falcon implements using the LDL-tree decomposition and FFT-based arithmetic. The main implementation challenge is that this FFT must be executed in constant time to prevent timing side-channels — non-trivial because floating-point units lack constant-time guarantees on most CPUs, requiring either careful fixed-point emulation or specialized hardware support. Falcon-512 signatures are roughly 3× smaller than ML-DSA-44 signatures (666 B vs 2420 B) at equivalent security, making Falcon attractive for bandwidth-constrained settings such as IoT certificate chains and TLS handshakes. FIPS 206 defines two instantiations (FN-DSA-512 and FN-DSA-1024) and mandates constant-time implementations.

**State of the art:** FIPS 206 (FN-DSA) finalized August 2024; implementations in liboqs, PQClean, and BouncyCastle. Preferred over ML-DSA where signature size dominates (e.g., embedded TLS). See [NIST PQC Signature Standards](#nist-pqc-signature-standards-ml-dsa--slh-dsa) for the broader NIST PQC context.

**Production readiness:** Mature
**Implementations:**
- [falcon-sign.info reference](https://falcon-sign.info/) — C, official Falcon reference implementation
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, Falcon/FN-DSA
- [PQClean](https://github.com/PQClean/PQClean) — C, clean Falcon implementation
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, Falcon support
**Security status:** Secure
**Community acceptance:** Standard

---

## SPHINCS & SPHINCS+ (Stateless Hash-Based Signatures)

**Goal:** Stateless post-quantum signatures from hash functions alone. Unlike XMSS/LMS, no per-signer state counter is needed — each signing operation selects a random leaf from a hypertree, making the scheme safe to deploy in any context where state management is impractical. The successor SPHINCS+ was standardized as SLH-DSA (FIPS 205).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SPHINCS (original)** | 2015 | Hash tree + WOTS + HORST | First practical stateless hash-based signature; hypertree over few-time HORST leaves; EUROCRYPT 2015 [[1]](https://eprint.iacr.org/2014/795) |
| **SPHINCS+ (submission)** | 2019 | Hash tree + WOTS+ + FORS | Redesign replacing HORST with FORS; tighter security; smaller signatures; NIST PQC Round 2/3 [[1]](https://sphincs.org/data/sphincs+-paper.pdf) |
| **SLH-DSA (FIPS 205)** | 2024 | SPHINCS+ | NIST standardization of SPHINCS+; three security levels; two variants per level: small (s) and fast (f) [[1]](https://csrc.nist.gov/pubs/fips/205/final) |
| **SPHINCS+-SHA2 / SPHINCS+-SHAKE** | 2022 | SHA-256 or SHAKE256 | Two instantiations; SHA2 variant faster on hardware with AES-NI; SHAKE variant for alignment with SHA-3 [[1]](https://sphincs.org/) |

SPHINCS achieves statelessness by using a two-level hypertree: the top levels are an XMSS-like Merkle tree authenticating subtree roots; the leaves use a few-time signature scheme (HORST in SPHINCS, FORS in SPHINCS+). Because the leaf index is derived from randomness included in the signing operation, two different signings of the same message produce different leaf paths — yielding unlinkable signatures with no state required. The price is large signatures (7–50 KB depending on variant and security-vs-speed trade-off). FORS (Forest Of Random Subsets) replaced HORST in SPHINCS+ after cryptanalysis showed improved forgery attacks against HORST's few-time property; FORS achieves a tighter security bound. SLH-DSA (FIPS 205) is the NIST-standardized instantiation with parameter sets SLHDSA-SHA2-128s/f through SLHDSA-SHA2-256s/f.

**State of the art:** SLH-DSA (FIPS 205, August 2024) is the production standard; SPHINCS+ reference code forms the basis of most library implementations (liboqs, PQClean). Preferred as a conservative backup to ML-DSA when algebraic assumptions are a concern. See [Stateful Hash-Based Signatures](#stateful-hash-based-signatures-xmss--lms) for the stateful XMSS/LMS family and [NIST PQC Signature Standards](#nist-pqc-signature-standards-ml-dsa--slh-dsa) for comparison.

**Production readiness:** Production
**Implementations:**
- [sphincsplus](https://github.com/sphincs/sphincsplus) — C, official SPHINCS+ reference
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, SLH-DSA / SPHINCS+
- [PQClean](https://github.com/PQClean/PQClean) — C, clean SPHINCS+ implementation
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, SPHINCS+ / SLH-DSA
**Security status:** Secure
**Community acceptance:** Standard

---

## Picnic (Signatures from ZK Proofs of Symmetric Primitives)

**Goal:** Post-quantum signatures with a minimal-assumption foundation. Prove in zero knowledge that you know a secret key sk such that a public symmetric function F(sk, nonce) = output, then use the ZK proof as a signature. Security reduces entirely to properties of the symmetric primitive (collision resistance + pseudorandomness) — no lattice, factoring, or discrete-log assumption needed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ZKBoo** | 2016 | MPC-in-the-head + SHA-256 | First practical ZKPoK-based signature; MPC-in-the-head (Ishai et al.) paradigm [[1]](https://eprint.iacr.org/2016/163) |
| **ZKB++ / Picnic1** | 2017 | MPC-in-the-head + LowMC | Optimized MPC-in-the-head; uses LowMC for efficient circuit; NIST PQC Round 1 [[1]](https://eprint.iacr.org/2017/279) |
| **Picnic2** | 2019 | KKW proof + LowMC | KKW (Katz-Kolesnikov-Wang) protocol; batched proofs; smaller signatures [[1]](https://eprint.iacr.org/2019/475) |
| **Picnic3** | 2020 | BBQ+/Limbo + LowMC | Further signature reduction via improved MPC protocol; NIST Round 3 alternate [[1]](https://eprint.iacr.org/2020/846) |
| **Banquet** | 2021 | MPC-in-the-head + AES | Replaces LowMC with AES for better understood security; competitive sizes [[1]](https://eprint.iacr.org/2021/068) |

The Picnic construction applies the Fiat-Shamir transform to a sigma protocol. The prover simulates a 3-party MPC computation of F(sk, nonce) using secret-sharing, then the Fiat-Shamir challenge selects which party's view to open. The soundness error per round is 1/3, so many rounds are needed (typically 219 for 128-bit security), resulting in large signatures (13–38 KB). LowMC was specifically designed as an MPC-friendly symmetric cipher with very few AND gates, minimizing the number of multiplication triples needed in the proof. The Picnic scheme was an alternate candidate in NIST PQC Round 3 (not selected for standardization) but remains the most concrete instantiation of the MPCitH paradigm for signatures. See also [MPCitH in ZK proof systems](categories/04-zero-knowledge-proof-systems.md#mpcith--voleith-proof-systems).

**State of the art:** Picnic3 (NIST Round 3 alternate, not standardized); Banquet for improved concrete security. Primarily of theoretical and benchmarking interest; signature sizes remain large compared to ML-DSA/Falcon. Foundation of the broader [MPCitH paradigm](categories/04-zero-knowledge-proof-systems.md#mpcith--voleith-proof-systems).

**Production readiness:** Experimental
**Implementations:**
- [microsoft/Picnic](https://github.com/microsoft/Picnic) — C, official Picnic reference implementation
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, Picnic integration
- [PQClean](https://github.com/PQClean/PQClean) — C, Picnic clean implementation
**Security status:** Secure
**Community acceptance:** Niche

---

## Rainbow & Multivariate Quadratic Signatures

**Goal:** Post-quantum signatures from the hardness of solving systems of multivariate quadratic (MQ) equations over finite fields. The MQ problem is NP-hard in general; multivariate schemes exploit structured trapdoors to make signing efficient while keeping the public map hard to invert.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **UOV (Unbalanced Oil and Vinegar)** | 1999 | MQ over GF(q) | Patarin's UOV trapdoor: oil-vinegar variable split; basis of most practical MQ sigs [[1]](https://www.minrank.org/uov.pdf) |
| **Rainbow (Ding-Schmidt)** | 2005 | Layered UOV | Multi-layer UOV; compact signatures; NIST PQC Round 1–3 finalist [[1]](https://eprint.iacr.org/2005/018) |
| **Rainbow break (Beullens)** | 2022 | Classical cryptanalysis | Ward Beullens' rectangular MinRank attack; broke all NIST Round 3 Rainbow parameters in a weekend on a laptop [[1]](https://eprint.iacr.org/2022/214) |
| **GeMSS** | 2017 | HFEv- (Hidden Field Equations) | Large public keys; small signatures (33 bytes); NIST Round 3 alternate; not selected [[1]](https://gemss.fr/) |
| **MAYO** | 2021 | Whipped UOV + oil-space embedding | New UOV variant; compact keys; NIST PQC on-ramp Round 1 candidate [[1]](https://eprint.iacr.org/2021/1144) |
| **UOV (NIST on-ramp)** | 2023 | UOV (revisited) | Plain UOV resubmitted for NIST additional signatures call; large public keys but very simple structure [[1]](https://csrc.nist.gov/projects/pqc-dig-sig/round-1-additional-signatures) |
| **SNOVA** | 2022 | Structured UOV over matrix algebra | Small keys and sigs via algebraic structure over non-commutative rings; NIST on-ramp candidate [[1]](https://eprint.iacr.org/2022/1679) |

Multivariate signatures work by publishing a map P: GF(q)^n → GF(q)^m composed of m degree-2 polynomials in n variables. The signer knows a trapdoor decomposition (a secret linear change of variables) that allows efficient inversion of P. Rainbow arranged variables in two layers (oil and vinegar at each layer) to achieve small signatures (~66 bytes at NIST Level 1) and fast signing. The 2022 break exploited the fact that the rectangular MinRank problem — finding a low-rank matrix in the Jacobian of Rainbow's central map — is much easier than previously estimated. Beullens solved it classically in ~53 bits of work for Rainbow-Ia (targeting 128-bit security), eliminating Rainbow as a viable scheme. GeMSS (Hidden Field Equations minus-variant) survived but was not selected due to enormous public keys (~352 KB). Post-break, MAYO and SNOVA represent the current generation of MQ signature research with improved structural choices.

**State of the art:** Rainbow broken (2022); GeMSS not selected. MAYO and UOV are current NIST additional signatures on-ramp candidates (as of 2024). MQ signatures offer the shortest signatures of any PQ family but have historically suffered from structural attacks.

**Production readiness:** Deprecated
**Implementations:**
- [pqcrypto-rainbow](https://github.com/nicolo-ribaudo/ring-signature) — C, Rainbow reference (broken)
- [MAYO](https://github.com/PQCMayo/MAYO-C) — C, MAYO reference implementation (NIST on-ramp)
- [UOV reference](https://github.com/nicolo-ribaudo/ring-signature) — C, UOV NIST submission
**Security status:** Broken
**Community acceptance:** Controversial

---

## Hedged Signatures

**Goal:** Side-channel-resistant deterministic signing. Pure deterministic schemes (EdDSA, RFC 6979) are vulnerable to fault attacks — an adversary who can induce a fault during signing can recover the private key even without knowing the internal state. Hedged signatures mix fresh per-sign randomness into the nonce derivation, preserving determinism's RNG-failure resilience while defeating fault attacks that exploit the deterministic structure.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hedged ECDSA (Aranha et al.)** | 2020 | ECDSA + HMAC-DRBG + fresh randomness | Adds a random blinding value r to RFC 6979 nonce derivation: k = HMAC-DRBG(sk ‖ m ‖ r); hardware fault-resistant [[1]](https://eprint.iacr.org/2019/956) |
| **Hedged EdDSA** | 2017 | EdDSA + extra randomness | Variant of Ed25519 mixing per-sign entropy into nonce hash; defeats rowhammer-style fault attacks [[1]](https://eprint.iacr.org/2017/985) |
| **Composite Schnorr / "draft-irtf-cfrg-det-sigs-with-noise"** | 2022 | Schnorr + deterministic + random | IRTF CFRG draft; k = H(sk ‖ m ‖ r) where r is small (32 bytes); degrades to RFC 6979 if RNG fails, degrades to random signing if determinism is probed [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-det-sigs-with-noise/) |
| **Libsodium / ristretto255 hedged** | 2022 | Ed25519 variant | libsodium's crypto_sign_ed25519 adds random noise internally in recent versions; transparent to applications [[1]](https://doc.libsodium.org/public-key_cryptography/public-key_signatures) |

The core tension is between two threat models: (a) RNG failure — the per-sign random source is weak or predictable, as occurred in several Android Bitcoin wallet incidents; and (b) fault/DPA attacks — the signing device is physically probed and the deterministic computation is perturbed (e.g., via voltage glitching or electromagnetic fault injection), allowing an attacker to solve for the private key from two faulty signatures with the same deterministic nonce. Hedged signing defeats both threats simultaneously: the nonce depends on both the private key+message (as in RFC 6979) and fresh randomness (as in randomized signing). A faulty-RNG attacker still cannot predict k because of the deterministic component; a fault attacker cannot exploit a known k because the randomness prevents nonce repetition. The IRTF CFRG draft formalizes this as the preferred approach for new Schnorr-based schemes.

**State of the art:** Hedged signing recommended by IRTF CFRG for all new Schnorr/ECDSA deployments; already default in several TLS stacks and hardware security modules. Extends [ECDSA — Details, Vulnerabilities, and RFC 6979](#ecdsa--details-vulnerabilities-and-rfc-6979) and [EdDSA](#eddsa-ed25519--ed448).

**Production readiness:** Production
**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) — C, hedged Ed25519 in recent versions
- [BoringSSL](https://github.com/nicolo-ribaudo/ring-signature) — C, hedged ECDSA
- [draft-irtf-cfrg-det-sigs-with-noise](https://datatracker.ietf.org/doc/draft-irtf-cfrg-det-sigs-with-noise/) — IETF draft specification
**Security status:** Secure
**Community acceptance:** Emerging

---

## BLISS & qTESLA (Early Lattice Signature Schemes)

**Goal:** Efficient lattice-based signatures preceding the NIST PQC process. BLISS (Bimodal Lattice Signature Scheme) achieved very compact signatures using a bimodal Gaussian distribution to cancel the error term; qTESLA was a Ring-LWE–based NIST PQC Round 1 candidate. Both illuminate the design space that led to ML-DSA (Dilithium) and Falcon.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BLISS (Ducas-Durmus-Lepoint-Lyubashevsky)** | 2013 | Ring-SIS + bimodal Gaussian | Bimodal distribution enables rejection-free signing; ~5600-bit sig at 128-bit security; CRYPTO 2013 [[1]](https://eprint.iacr.org/2013/383) |
| **BLISS-B** | 2015 | BLISS + Bernoulli rejection sampling | Improved constant-time variant; reference implementation for timing-side-channel studies [[1]](https://tches.iacr.org/index.php/TCHES/article/view/836) |
| **qTESLA (Round 1)** | 2017 | Ring-LWE (provably secure) | Conservative provable-security variant; NIST PQC Round 1; withdrawn before Round 2 due to parameter issues [[1]](https://eprint.iacr.org/2019/085) |
| **qTESLA-p (provably secure)** | 2019 | Ring-LWE + NTRU-free | Revised parameter sets with concrete security reductions; still larger signatures than BLISS [[1]](https://eprint.iacr.org/2019/085) |
| **Lyubashevsky's Fiat-Shamir with Aborts** | 2009 | Ring-SIS | Core signing technique behind BLISS, Dilithium, and Falcon: sign with a large key, reject if signature leaks too much information about the key [[1]](https://eprint.iacr.org/2011/537) |

BLISS introduced the bimodal trick: instead of sampling a standard Gaussian nonce, the signer samples from a distribution that is the mixture of two Gaussians centered at +σ and −σ. This cancels the error term algebraically during signing, enabling smaller rejection rates and more compact signatures. BLISS signatures (~5600 bits at Level 1) were the most compact lattice signatures of their era and influenced all subsequent Fiat-Shamir-with-aborts constructions. However, BLISS implementations were repeatedly shown to leak the private key through timing and cache side-channels (the Gaussian sampler is notoriously hard to implement in constant time), which contributed to NIST preferring Dilithium's simpler uniform-rejection-sampling design for ML-DSA. qTESLA was based on the provably secure Ring-LWE assumption (Regev-style reduction) rather than the heuristic Ring-SIS assumption used in BLISS; it was withdrawn from Round 2 after parameter analysis revealed insufficient security margins in the submitted parameter sets.

**State of the art:** Neither BLISS nor qTESLA was standardized; superseded by ML-DSA (FIPS 204) and Falcon/FN-DSA (FIPS 206). Historically important as the proof-of-concept lattice signature schemes that established the viability of the Fiat-Shamir-with-aborts paradigm. See [NIST PQC Signature Standards](#nist-pqc-signature-standards-ml-dsa--slh-dsa) and [Falcon / FN-DSA](#falcon--fn-dsa-ntru-based-lattice-signatures).

**Production readiness:** Deprecated
**Implementations:**
- [BLISS reference](https://github.com/nicolo-ribaudo/ring-signature) — C, original BLISS implementation (side-channel vulnerable)
- [qTESLA](https://github.com/nicolo-ribaudo/ring-signature) — C, NIST Round 1 submission (withdrawn)
- Superseded by [liboqs](https://github.com/open-quantum-safe/liboqs) — C, ML-DSA/Falcon
**Security status:** Superseded
**Community acceptance:** Niche

---

## Fiat-Shamir with Aborts (Lattice Signature Paradigm)

**Goal:** Efficient lattice signatures via controlled rejection sampling. Extend the classical Fiat-Shamir transform — which converts interactive identification schemes into signatures via a hash challenge — to lattice settings where nonce distributions must be carefully masked to prevent leakage of the secret key. The "abort" mechanism restarts signing when a sampled nonce is deemed too revealing, ensuring the output distribution is independent of the secret.

| Scheme / Concept | Year | Basis | Note |
|-----------------|------|-------|------|
| **Lyubashevsky's Identification Scheme** | 2008 | Ring-SIS | First lattice ID scheme via Fiat-Shamir; nonce y sampled large; response z = y + cs masked [[1]](https://eprint.iacr.org/2008/481) |
| **Fiat-Shamir with Aborts (Lyubashevsky)** | 2009 | Ring-SIS + rejection sampling | Formal framework: reject response z if it reveals information about secret s; abort probability controlled by Rényi divergence [[1]](https://eprint.iacr.org/2011/537) |
| **Dilithium (CRYSTALS)** | 2017 | Module-SIS + Module-LWE | Direct FSA instantiation over module lattices; uses uniform rejection (simpler than Gaussian); basis of ML-DSA (FIPS 204) [[1]](https://eprint.iacr.org/2017/633) |
| **Raccoon** | 2023 | Module-SIS + masking | FSA variant designed for side-channel masking; probabilistic rejection sampling compatible with masked arithmetic [[1]](https://eprint.iacr.org/2023/1943) |
| **Mitaka** | 2022 | NTRU + hybrid Gaussian sampling | Alternative to Falcon: FSA over NTRU lattice using simpler independent Gaussian sampler; slightly larger sigs than Falcon but easier to mask [[1]](https://eprint.iacr.org/2021/1486) |

The Fiat-Shamir with Aborts paradigm proceeds as follows: the signer samples a masking nonce y from a large domain, computes a commitment w = Ay mod q, derives a challenge c = H(w ‖ message), and computes a response z = y + cs. The abort condition checks whether the distribution of z reveals the secret s — concretely, if z is too large or falls outside a "good" region, the signer discards it and restarts. The abort probability is tuned so that the output distribution of z is statistically close to a fixed distribution independent of s, enabling a simulation-based security proof under the Short Integer Solution (SIS) assumption. Dilithium uses uniform rejection (reject if any coefficient of z exceeds a bound γ₁ − β), achieving a clean constant-time implementation with no Gaussian sampler. Raccoon extends the FSA framework to support masked implementations natively, addressing the side-channel weakness of unmasked Dilithium in hardware-constrained settings.

**State of the art:** Dilithium/ML-DSA (FIPS 204) is the primary standardized instantiation; Raccoon and Mitaka represent next-generation FSA designs prioritizing side-channel resistance. Foundational to [BLISS & qTESLA](#bliss--qtesla-early-lattice-signature-schemes), [ML-DSA & SLH-DSA](#nist-pqc-signature-standards-ml-dsa--slh-dsa), and [Falcon / FN-DSA](#falcon--fn-dsa-ntru-based-lattice-signatures).

**Production readiness:** Production
**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, ML-DSA (Dilithium) uses FSA
- [PQClean](https://github.com/PQClean/PQClean) — C, clean Dilithium implementation
- [pqm4](https://github.com/mupq/pqm4) — C, embedded ARM implementations of Dilithium/Falcon
**Security status:** Secure
**Community acceptance:** Standard

---

## Multi-Designated Verifier Signatures (MDVS)

**Goal:** Restricted verifiability for a defined set of recipients. Extend [Designated Verifier Signatures](#designated-verifier-signatures--proofs) from a single verifier to a set of k designated verifiers: any member of the set can verify, but no one outside the set can, and no member can transfer conviction to outsiders (since each verifier could have simulated the signature themselves).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Jakobsson-Sako-Impagliazzo MDVS** | 1996 | DLP | Conceptual extension of DVS to multiple designated verifiers; each verifier can simulate [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_13) |
| **Laguillaumie-Vergnaud MDVS** | 2004 | Pairings | First efficient pairing-based MDVS; constant-size signatures regardless of verifier count [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_22) |
| **Dent-Libert-Paterson MDVS** | 2006 | Pairings (standard model) | MDVS in the standard model (no random oracle); verifier anonymity as additional property [[1]](https://eprint.iacr.org/2006/236) |
| **Lattice MDVS (Zhang et al.)** | 2021 | Ring-LWE | Post-quantum MDVS from ring learning with errors [[1]](https://eprint.iacr.org/2021/829) |
| **Strong MDVS (Schuldt-Matsuura)** | 2009 | Pairings | Strong variant: even members of the designated set cannot transfer conviction to other members [[1]](https://link.springer.com/chapter/10.1007/978-3-642-10433-6_12) |

MDVS is motivated by scenarios where a message must be privately authenticated to a board or committee — each member can individually verify, but collective non-transferability means no subset can prove the signer's identity to outsiders. The simulatability condition requires that each designated verifier Di can produce transcripts (σ*, m) that are computationally indistinguishable from real signatures, without knowing the signer's key. Verifier anonymity (Dent-Libert-Paterson) adds the property that the signature does not reveal which verifiers were designated. Strong MDVS further prevents intra-set transfers: even if all k verifiers collude, they cannot convince an outsider — because any such coalition could have simulated the signature cooperatively.

**State of the art:** Pairing-based MDVS (Laguillaumie-Vergnaud style) in standard model; lattice MDVS for PQ settings. Extends [Designated Verifier Signatures / Proofs](#designated-verifier-signatures--proofs) to the multi-verifier case.

**Production readiness:** Research
**Implementations:**
- Academic reference implementations accompany published papers
- Pairing-based MDVS implementable via [MCL](https://github.com/herumi/mcl) — C++
**Security status:** Secure
**Community acceptance:** Niche

---

## Unforgeability Notions: EUF-CMA, SUF-CMA, and Beyond

**Goal:** Formal security definitions for digital signatures. Precisely characterize what it means for a signature scheme to be secure: which adversarial capabilities are modeled (chosen-message attacks), and what counts as a forgery (existential vs. strong vs. selective). These definitions underpin all provable security results in the signature literature.

| Notion | Year | Definition | Note |
|--------|------|-----------|------|
| **EUF-CMA (Existential Unforgeability under CMA)** | 1988 | Goldwasser-Micali-Rivest | Adversary wins if it outputs (m*, σ*) where m* was never queried; the standard security notion for signatures [[1]](https://doi.org/10.1137/0217017) |
| **SUF-CMA (Strong Unforgeability under CMA)** | 2005 | Boneh-Shen-Waters | Adversary wins if it outputs (m*, σ*) where the pair (m*, σ*) was never returned by the signing oracle; prevents new signatures on previously signed messages [[1]](https://eprint.iacr.org/2005/336) |
| **SEU-CMA (Selective Existential Unforgeability)** | 1988 | GMR | Adversary commits to the forgery message m* before seeing the public key; weaker than EUF-CMA; sufficient for some applications [[1]](https://doi.org/10.1137/0217017) |
| **UF-NMA (Unforgeability under No-Message Attack)** | — | Generic | Adversary gets no signing queries; models schemes where chosen-message attacks are not meaningful [[1]](https://eprint.iacr.org/2004/171) |
| **Online/Offline EUF-CMA** | 2001 | Even-Goldreich-Micali | Separates signing into offline precomputation + fast online phase; same security notion, different efficiency profile [[1]](https://doi.org/10.1007/BF02351741) |
| **Tight EUF-CMA reduction** | 2003 | Waters / Coron | A tight reduction loses no factor in the security reduction from assumption to EUF-CMA game; implies smaller key sizes for equivalent concrete security [[1]](https://eprint.iacr.org/2005/097) |

The gap between EUF-CMA and SUF-CMA is practically significant: ECDSA is EUF-CMA secure (standard notion) but not SUF-CMA because the algebraic malleability (r, s) → (r, −s mod n) produces a second valid signature on the same message. Bitcoin's BIP 62 low-s restriction and Schnorr/EdDSA's structural non-malleability both achieve SUF-CMA. In composable protocols (e.g., constructing authenticated encryption or anonymous credentials from signatures), SUF-CMA is often needed to prevent new-signature attacks, where an adversary reuses a signature in a modified message context. Tight reductions matter for concrete parameter selection: a non-tight reduction with a factor-q(n) security loss (where q is the number of signing queries) requires commensurately larger key sizes to maintain the same concrete bit-security level. Waters signatures and the PSS padding for RSA achieve tight reductions; plain BLS and ECDSA do not.

**State of the art:** EUF-CMA is the baseline standard; SUF-CMA required for composable and blockchain applications. Tight reductions (e.g., Waters signatures, RSA-PSS) justify smaller parameters. Cross-links: [ECDSA — Details, Vulnerabilities, and RFC 6979](#ecdsa--details-vulnerabilities-and-rfc-6979), [Boneh-Boyen (BB) Short Signatures](#boneh-boyen-bb-short-signatures), [RSA-PSS vs. PKCS#1 v1.5 Signatures](#rsa-pss-vs-pkcs1-v15-signatures).

**Production readiness:** Production
**Implementations:**
- Definitions implemented/tested in all major signature libraries:
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) — C, SUF-CMA for BIP 340 Schnorr
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) — Rust, SUF-CMA EdDSA
**Security status:** Secure
**Community acceptance:** Standard

---

## Batch Verification of Signatures

**Goal:** Amortize verification cost. Check the validity of n signatures simultaneously at a cost significantly less than n independent verifications. Critical for high-throughput systems such as blockchain nodes, certificate transparency logs, and TLS session resumption servers that must validate large volumes of signatures.

| Scheme / Technique | Year | Basis | Note |
|-------------------|------|-------|------|
| **RSA Batch Verification (Bellare-Garay-Rabin)** | 1998 | RSA | Combine n RSA signature equations into one using random linear combination; reduces n exponentiations to ~n/2 [[1]](https://link.springer.com/chapter/10.1007/BFb0054147) |
| **BLS Batch Verification** | 2001 | Pairings | Verify n BLS sigs with n+1 pairings (vs. 2n); multiply public keys with random coefficients; prevents forgery via rogue aggregation [[1]](https://eprint.iacr.org/2002/029) |
| **Schnorr / EdDSA Batch Verification** | 2020 | Schnorr / Edwards curve | BIP 340: verify n Schnorr sigs with one multi-scalar multiplication; ~2× speedup over n independent checks; used in Bitcoin full nodes [[1]](https://github.com/bitcoin/bips/blob/master/bip-0340.mediawiki) |
| **ML-DSA Batch Verification** | 2023 | Module lattice | Batching Dilithium/ML-DSA verifications via aggregated hint vectors; reduces polynomial NTT operations [[1]](https://eprint.iacr.org/2022/1548) |
| **ECDSA Batch Verification (Antipa et al.)** | 2005 | ECDSA + Shamir's trick | Simultaneous multi-scalar multiplication reduces per-sig EC operations; no security assumption change [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_2) |
| **Probabilistic Batch Verification** | 1998 | Random linear combination | Assign random scalars r₁,...,rₙ to each equation before combining; incorrect batch fails with overwhelming probability; applies to any linear-equation signature scheme [[1]](https://link.springer.com/chapter/10.1007/BFb0054147) |

Batch verification works by exploiting the linearity of most signature verification equations. For Schnorr signatures, verification requires checking Rᵢ = sᵢ·G − eᵢ·Pᵢ for each i; batching multiplies each equation by a random scalar λᵢ and sums: Σλᵢ·Rᵢ = (Σλᵢ·sᵢ)·G − Σ(λᵢ·eᵢ·Pᵢ), a single multi-scalar multiplication. The random scalars prevent an adversary from mixing valid and invalid signatures to make the batch check pass. For BLS, batching reduces the number of Miller loop evaluations (the expensive part of a pairing): n BLS verifications normally cost 2n pairings; batched verification checks one random linear combination of all n equations using n+1 pairings. For RSA, batching replaces n modular exponentiations with ~n/2 squarings via a product-check shortcut. Probabilistic batch verification introduces a negligible (2^{−128}) probability of accepting a batch containing one invalid signature, acceptable in most contexts. Deterministic batch verification (guaranteed soundness) is harder and scheme-specific.

**State of the art:** Schnorr batch verification (BIP 340, Bitcoin); BLS batch verification (Ethereum consensus); EdDSA batch (libsodium, BoringSSL). Foundational optimization for any high-throughput signature-using system. See [Aggregate Signatures (BLS Aggregate)](#aggregate-signatures-bls-aggregate) for a related (but distinct) concept.

**Production readiness:** Production
**Implementations:**
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) — C, Schnorr batch verification (BIP 340)
- [blst](https://github.com/supranational/blst) — C/Rust, BLS batch verification
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) — Rust, EdDSA batch verification
- [libsodium](https://github.com/jedisct1/libsodium) — C, Ed25519 batch verify
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Post-Quantum Signature Comparison: ML-DSA vs. SLH-DSA vs. FN-DSA

**Goal:** Practical comparison of the three NIST-standardized post-quantum signature algorithms. ML-DSA (FIPS 204), SLH-DSA (FIPS 205), and FN-DSA (FIPS 206) address different deployment scenarios — lattice speed, hash-only conservatism, and compact-size respectively — and choosing between them requires understanding their security assumptions, performance profiles, and implementation complexity trade-offs.

| Property | **ML-DSA** (FIPS 204) | **SLH-DSA** (FIPS 205) | **FN-DSA** (FIPS 206) |
|----------|-----------------------|-----------------------|-----------------------|
| **Underlying family** | Module lattices (MLWE/MSIS) | Hash functions only (WOTS+, FORS) | NTRU lattices + FFT |
| **Security assumption** | Module-LWE + Module-SIS | Hash preimage + collision resistance | NTRU-hardness + SIS |
| **Stateful?** | No | No | No |
| **Public key (Level 2)** | 1312 B | 32 B | 897 B |
| **Signature (Level 2)** | 2420 B | 7856 B (fast) / 17088 B (small) | ~666 B (average) |
| **Signing speed** | Fast (~ms) | Slow (100ms–1s) | Fast (~ms) |
| **Verification speed** | Fast | Moderate | Fast |
| **Implementation complexity** | Moderate (NTT, rejection sampling) | Low (only hash calls) | High (FFT, Gaussian sampler, constant-time float) |
| **Side-channel resistance** | Moderate (masking feasible) | High (hash-based, easy to mask) | Difficult (Gaussian sampler, floating-point) |
| **FIPS standard** | FIPS 204 (Aug 2024) [[1]](https://csrc.nist.gov/pubs/fips/204/final) | FIPS 205 (Aug 2024) [[1]](https://csrc.nist.gov/pubs/fips/205/final) | FIPS 206 (Aug 2024) [[1]](https://csrc.nist.gov/pubs/fips/206/final) |
| **NIST recommendation** | Primary standard | Conservative backup | Compact-size niche |

ML-DSA is NIST's primary recommendation for general-purpose post-quantum signing. Its module-lattice structure enables efficient NTT-based arithmetic, yielding fast signing and verification at the cost of 2–5 KB signatures. SLH-DSA is the conservative "hash-only" choice: its security reduces entirely to standard hash function properties with no algebraic assumptions, making it the right answer when distrust of lattice hardness is a concern. Its weakness is signature size (8–50 KB depending on variant) and slow signing. FN-DSA (Falcon) fills a niche where signature compactness dominates: at ~666 bytes for Level 1, it is 3.6× smaller than ML-DSA-44, making it attractive for IoT certificate chains, embedded TLS, and bandwidth-constrained settings. However, its constant-time implementation is difficult — the discrete Gaussian sampler over NTRU lattices requires careful fixed-point arithmetic or dedicated hardware, and several early implementations had timing side-channels. CNSA 2.0 (NSA's guidance for national security systems) mandates ML-DSA as the primary PQ signature algorithm and permits SLH-DSA as an alternative; FN-DSA is approved but not preferred due to implementation concerns. All three are stateless (unlike XMSS/LMS), require no per-signature state management, and can be used as drop-in replacements for ECDSA in most protocol roles.

**State of the art:** All three finalized August 2024. Migration deadline for US federal systems is 2030. NIST recommends ML-DSA as default; SLH-DSA when algebraic assumptions are unacceptable; FN-DSA when bandwidth is severely constrained. Cross-links: [NIST PQC Signature Standards (ML-DSA & SLH-DSA)](#nist-pqc-signature-standards-ml-dsa--slh-dsa), [Falcon / FN-DSA](#falcon--fn-dsa-ntru-based-lattice-signatures), [SPHINCS & SPHINCS+](#sphincs--sphincs-stateless-hash-based-signatures), [Stateful Hash-Based Signatures (XMSS & LMS)](#stateful-hash-based-signatures-xmss--lms), [Fiat-Shamir with Aborts](#fiat-shamir-with-aborts-lattice-signature-paradigm).

**Production readiness:** Production
**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, all three NIST PQ sig standards
- [PQClean](https://github.com/PQClean/PQClean) — C, clean reference implementations
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, ML-DSA, SLH-DSA, Falcon
- [oqs-provider](https://github.com/open-quantum-safe/oqs-provider) — C, OpenSSL 3 provider for PQ sigs
**Security status:** Secure
**Community acceptance:** Standard

---

## Verifiable Random Functions (ECVRF, RFC 9381)

**Goal:** Deterministic pseudorandomness with a proof. Given a private key sk and an input α, the VRF outputs a pseudorandom value β = VRF(sk, α) along with a proof π that anyone holding the public key can verify — confirming that β was computed correctly without revealing sk. Combines a signature's authentication with a PRF's pseudorandomness guarantee.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali-Rabin-Vadhan VRF** | 1999 | RSA | First VRF construction; pseudorandomness under RSA assumption; large output proofs [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_11) |
| **Dodis-Yampolskiy VRF** | 2005 | Pairings / q-DBDHI | Efficient pairing-based VRF; short proofs; pseudorandomness under q-DBDHI [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30576-7_26) |
| **ECVRF (Goldberg et al.)** | 2017 | ECDLP + hash-to-curve | Elliptic-curve VRF; proof is an EC Schnorr-like proof; hash-to-curve maps input to EC point [[1]](https://eprint.iacr.org/2017/099) |
| **RFC 9381 (ECVRF standard)** | 2023 | ECDLP / IETF standard | IETF standard for ECVRF; two cipher suites: P-256-SHA-256 and edwards25519-SHA-512; deployed in Algorand, Cardano, Chainlink VRF [[1]](https://www.rfc-editor.org/rfc/rfc9381) |
| **Lattice VRF (VXEDDSA / PQ)** | 2022 | Module-LWE | Post-quantum VRF from lattice assumptions; larger proofs than ECVRF [[1]](https://eprint.iacr.org/2022/1326) |

The ECVRF construction works by hashing the input α to an elliptic curve point H = hash_to_curve(pk ‖ α), then computing the VRF output point Γ = sk·H. The proof π is a Schnorr-like non-interactive proof that Γ was computed consistently with the public key pk = sk·G (same scalar sk multiplied by two different base points G and H). The pseudorandom output β = H₃(Γ) is derived by hashing the output point. Crucially, the proof is publicly verifiable — anyone with the public key can check π without learning sk — and the output is unique (no two valid proofs can produce different β for the same input). RFC 9381 standardizes two cipher suites: ECVRF-P256-SHA256-TAI and ECVRF-EDWARDS25519-SHA512-ELL2. VRFs are the core primitive for provably fair randomness in leader election (Algorand, Cardano Ouroboros), verifiable lottery systems, and Chainlink VRF for smart contract randomness. See [Ring VRF](#ring-vrf) for the anonymous variant, and [Verifiable Random Functions](categories/09-commitments-verifiability.md#verifiable-random-functions-vrf) for the commitment-side treatment.

**State of the art:** RFC 9381 ECVRF (2023, deployed in Algorand, Cardano, Chainlink VRF); lattice VRF for PQ settings. Cross-links: [Ring VRF](#ring-vrf), [VRF in commitments](categories/09-commitments-verifiability.md#verifiable-random-functions-vrf), [Secret Leader Election](categories/13-blockchain-distributed-ledger.md#secret-leader-election).

**Production readiness:** Production
**Implementations:**
- [algorand/libsodium](https://github.com/nicolo-ribaudo/ring-signature) — C, ECVRF for Algorand
- [cardano-crypto](https://github.com/nicolo-ribaudo/ring-signature) — Haskell, VRF for Cardano Ouroboros
- [chainlink/vrf](https://github.com/nicolo-ribaudo/ring-signature) — Solidity/Go, Chainlink VRF on-chain
- [vrf-rs](https://github.com/nicolo-ribaudo/ring-signature) — Rust, ECVRF RFC 9381 implementation
**Security status:** Secure
**Community acceptance:** Standard

---

## Schnorr Half-Aggregation (Signature Aggregation Beyond BLS)

**Goal:** Non-interactive Schnorr signature compression without pairings. Aggregate n independent Schnorr signatures — from n different signers on n different messages — into a single compact representation roughly half the size of the concatenated originals. Unlike BLS aggregation, no pairing-friendly curve is required; unlike MuSig2, the signers need not interact or coordinate.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Drijvers-Neven (BDN) Aggregation** | 2018 | Pairings / BLS | Interactive aggregate Schnorr-style sigs require pairings; non-interactive aggregation without pairings was an open problem [[1]](https://eprint.iacr.org/2018/483) |
| **Half-Aggregation of Schnorr Signatures** | 2021 | Schnorr / DLOG | Compress n Schnorr sigs (each R, s) to (R₁,…,Rₙ, s̃) where s̃ = Σcᵢsᵢ; half the size; non-interactive [[1]](https://eprint.iacr.org/2021/350) |
| **HALFAGG (Chalkias-Hall-Lewi-Lyubashevsky-Nikolaenko)** | 2021 | Schnorr on secp256k1 / edwards25519 | Concrete instantiation; reduces n Schnorr sigs from 2n·32 B to (n+1)·32 B; BIP proposal for Bitcoin [[1]](https://eprint.iacr.org/2021/350) |
| **Incremental Half-Aggregation** | 2023 | Schnorr | Aggregate signatures as they arrive without re-processing earlier ones; enables streaming aggregation for gossip protocols [[1]](https://eprint.iacr.org/2023/959) |
| **Half-Aggregation for Cross-Input Taproot** | 2023 | Schnorr / BIP 340 | Bitcoin cross-input signature aggregation (CISA) research; each transaction input could share one aggregate sig [[1]](https://github.com/bitcoin/bips/blob/master/bip-0340.mediawiki) |

Half-aggregation exploits the linear structure of Schnorr verification: given sigs (Rᵢ, sᵢ) for messages mᵢ under keys Pᵢ, each verification checks sᵢ·G = Rᵢ + cᵢ·Pᵢ where cᵢ = H(Rᵢ ‖ Pᵢ ‖ mᵢ). An aggregator computes a random linear combination s̃ = Σcᵢ'·sᵢ (for fresh binding coefficients cᵢ') and stores only the n commitment points Rᵢ alongside s̃. Verification recomputes the combined check in one multi-scalar multiplication. This is "half" aggregation because the n nonce points Rᵢ must still be stored individually — only the n scalar responses are compressed to a single scalar. The scheme is non-interactive: the aggregator needs no cooperation from signers and does not require a common message. Unlike BLS aggregation, it works on any Schnorr-compatible curve including secp256k1 and edwards25519. Incremental aggregation allows a node receiving signatures one by one to maintain a running aggregate without re-aggregating from scratch. Bitcoin cross-input signature aggregation (CISA) is a proposed soft fork that would use half-aggregation across inputs in a transaction, reducing transaction size by ~7.5% on average.

**State of the art:** Half-aggregation (HALFAGG, 2021) theoretically sound; incremental variant (2023) enables practical deployment. Bitcoin CISA remains a proposal. Contrasts with [BLS Aggregate Signatures](#aggregate-signatures-bls-aggregate) (requires pairings, non-interactive, full aggregation) and [MuSig2](#musig--musig2-schnorr-multi-signatures) (interactive, n-of-n only).

**Production readiness:** Experimental
**Implementations:**
- [half-aggregation](https://github.com/nicolo-ribaudo/ring-signature) — Rust, HALFAGG prototype
- [BlockstreamResearch/cross-input-aggregation](https://github.com/BlockstreamResearch/scriptless-scripts) — research docs
- No production-quality library yet; active BIP proposal for Bitcoin
**Security status:** Secure
**Community acceptance:** Emerging

---

## Code-Based Signatures (Wave, LESS, and Related)

**Goal:** Post-quantum signatures from coding theory. Exploit the hardness of decoding random linear codes (Syndrome Decoding Problem) or the equivalence of linear codes (Code Equivalence Problem) to build signatures with well-studied post-quantum security. An alternative PQ family to lattice- and hash-based schemes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CFS (Courtois-Finiasz-Sendrier)** | 2001 | Syndrome decoding (Goppa codes) | First practical code-based signature; signing finds a low-weight codeword; slow due to rejection sampling [[1]](https://link.springer.com/chapter/10.1007/3-540-45682-1_36) |
| **Wave (Debris-Alazard-Sendrier-Tillich)** | 2019 | Generalized (U,U+V) codes / SDP | First hash-and-sign code-based signature without trapdoor; provably secure under SDP and DOOM problem [[1]](https://eprint.iacr.org/2018/996) |
| **LESS (Barelli-Couvreur)** | 2020 | Linear Code Equivalence Problem | Fiat-Shamir signature from the hardness of deciding if two linear codes are permutation equivalent; compact [[1]](https://eprint.iacr.org/2020/1455) |
| **MEDS (Matrix Equivalence Digital Signature)** | 2022 | Matrix Code Equivalence | Extension of LESS to matrix codes; better parameter trade-offs; NIST additional signatures on-ramp candidate [[1]](https://eprint.iacr.org/2022/1528) |
| **CROSS** | 2023 | Restricted Syndrome Decoding (RSD) | Code-based sigma protocol via Fiat-Shamir; NIST on-ramp Round 2 candidate; competitive signature sizes [[1]](https://eprint.iacr.org/2023/028) |
| **SDitH (Syndrome Decoding in the Head)** | 2022 | MPC-in-the-head + SDP | Apply MPCitH paradigm to syndrome decoding; NIST on-ramp Round 2 candidate [[1]](https://eprint.iacr.org/2022/1512) |

Code-based cryptography is one of the oldest post-quantum families (McEliece 1978), with security reductions to the Syndrome Decoding Problem (SDP) — which is NP-hard in the worst case and widely believed hard on average for random linear codes. Wave is the first code-based hash-and-sign construction without relying on a structured code trapdoor: it uses generalized (U,U+V) codes to sign by finding a codeword near the hash of the message, with security provably reducible to SDP and the DOOM (Decoding One Of Many) problem. LESS and MEDS are based on the Code Equivalence Problem — determining whether two linear codes are related by a permutation (LESS) or matrix transformation (MEDS) of coordinates — which is not known to reduce to SDP, providing a diversity of assumptions. CROSS and SDitH apply the MPC-in-the-head paradigm to coding problems, achieving competitive signature sizes without the structured-code assumption. Wave key sizes are large (public keys ~3 MB), while CROSS and LESS achieve much more compact parameters. Both CROSS and MEDS are advancing through NIST's additional signatures process (2022 on-ramp).

**State of the art:** CROSS and MEDS are NIST additional signatures Round 2 candidates (as of 2024). Wave remains the strongest provably secure code-based hash-and-sign scheme but with impractical key sizes. Code-based signatures complement lattice-based schemes by relying on a completely different hardness assumption. See [Rainbow & Multivariate Quadratic Signatures](#rainbow--multivariate-quadratic-signatures) for the analogous MQ-based family and [Picnic (Signatures from ZK Proofs of Symmetric Primitives)](#picnic-signatures-from-zk-proofs-of-symmetric-primitives) for the MPCitH paradigm.

**Production readiness:** Experimental
**Implementations:**
- [CROSS reference](https://github.com/nicolo-ribaudo/ring-signature) — C, NIST on-ramp submission
- [MEDS reference](https://github.com/nicolo-ribaudo/ring-signature) — C, NIST on-ramp submission
- [SDitH](https://github.com/nicolo-ribaudo/ring-signature) — C, syndrome decoding in the head
**Security status:** Secure
**Community acceptance:** Emerging

---

## SQIsign (Isogeny-Based Signatures)

**Goal:** Ultra-compact post-quantum signatures from isogeny graphs. Construct a Fiat-Shamir signature scheme whose security rests on the hardness of finding an isogeny between two supersingular elliptic curves — a problem believed resistant to quantum computers, with no known sub-exponential quantum algorithm (unlike discrete-log or factoring).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SeaSign** | 2019 | Isogeny class group action (CSIDH) | Fiat-Shamir signature from CSIDH; compact keys but very slow signing (hours) [[1]](https://eprint.iacr.org/2018/824) |
| **CSI-FiSh** | 2019 | CSIDH + class group computation | Precomputed class group enables faster SeaSign-style signing; still minutes per signature [[1]](https://eprint.iacr.org/2019/498) |
| **SQIsign (De Feo-Kohel-Leroux-Petit-Wesolowski)** | 2020 | Supersingular isogeny / KLPT | Hash-then-sign from SIDH-style isogenies; tiny keys (64 B) and sigs (177 B) at NIST Level 1; slow signing (~1–10 s) [[1]](https://eprint.iacr.org/2020/1240) |
| **SQIsign2D (Leroux-Wesolowski)** | 2023 | 2D isogenies + KLPT | Uses 2D isogenies for faster signing; 5–10× speedup over SQIsign while maintaining key/sig sizes [[1]](https://eprint.iacr.org/2023/436) |
| **SQIsignHD (Dartois-Leroux-Robert-Wesolowski)** | 2023 | Higher-dimensional isogenies | Further speedup via dimension-4 isogenies; signing approaches practical range (~1 s on modern CPUs) [[1]](https://eprint.iacr.org/2023/436) |
| **NIST on-ramp submission** | 2023 | SQIsign2D-West variant | SQIsign submitted to NIST additional signatures call; security under active analysis [[1]](https://csrc.nist.gov/projects/pqc-dig-sig/round-1-additional-signatures) |

SQIsign achieves the smallest key and signature sizes of any known post-quantum scheme: at NIST Level 1 security, the public key is 64 bytes and the signature is 177 bytes — smaller than ECDSA and competitive with classical schemes. This compactness comes from the rich algebraic structure of supersingular elliptic curve isogeny graphs. Signing requires solving a hard problem related to the KLPT algorithm (finding an ideal of given norm in a quaternion algebra that corresponds to an isogeny), which is computationally intensive. The original SQIsign takes 1–10 seconds per signature on a modern CPU, making it impractical for most applications. SQIsign2D and SQIsignHD exploit higher-dimensional isogeny representations to dramatically accelerate signing while preserving the tiny output sizes. However, SIDH — a related isogeny scheme — was broken in 2022 by Castryck-Decru-Maino-Martindale-Petit attacks, raising concerns about the structural similarity. SQIsign's security rests on a different hard problem (the Deuring correspondence / endomorphism ring problem), which has survived these attacks, but active cryptanalysis continues.

**State of the art:** SQIsignHD (2023) achieves ~1 s signing on server hardware — approaching practical range for use cases tolerating slow signing (e.g., certificate issuance). Submitted to NIST additional signatures on-ramp (2023); security and performance actively improving. Cross-links: [Isogeny-based cryptography](categories/15-quantum-cryptography.md#isogeny-based-cryptography), [Post-Quantum Signature Comparison](#post-quantum-signature-comparison-ml-dsa-vs-slh-dsa-vs-fn-dsa).

**Production readiness:** Research
**Implementations:**
- [SQIsign reference](https://github.com/SQISign/sqisign2d-west) — C, SQIsign2D-West NIST submission
- [isogeny-crypto](https://github.com/nicolo-ribaudo/ring-signature) — Sage/C, research implementations
**Security status:** Caution
**Community acceptance:** Emerging

---

## STARK-Based Signatures

**Goal:** Signatures with transparent post-quantum security and succinctly verifiable proofs. Convert a STARK (Scalable Transparent ARgument of Knowledge) proof system into a signature scheme via Fiat-Shamir: the signer proves knowledge of a secret key that maps to a public commitment, producing a signature whose verification is fast even when the witness computation is complex. No trusted setup; security reduces to collision-resistant hashes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FRI-based Schnorr-style sigs** | 2018 | FRI polynomial commitment | Apply FRI (Fast Reed-Solomon IOP) to construct hash-based interactive proofs; Fiat-Shamir yields non-interactive sigs [[1]](https://eprint.iacr.org/2019/1020) |
| **Plonky2 / Plonky3 Signatures** | 2022 | STARK + Plonk arithmetization | Recursive STARK proof used as a signature; fast prover over Goldilocks field; verifier is ~200 KB proof [[1]](https://github.com/0xPolygonZero/plonky2) |
| **Whir (Signatures from Ring-Switching)** | 2024 | STARK + ring-switching IOP | Fast STARK-based universal signer; reduces proof size via correlated sumcheck; competitive with SLH-DSA for some parameter sets [[1]](https://eprint.iacr.org/2024/1586) |
| **Ethstark / StarkWare production STARK** | 2021 | AIR + FRI | STARK proof system deployed in StarkEx, StarkNet; not a signature scheme per se but the underlying IOP system used to build ZK-sigs [[1]](https://eprint.iacr.org/2021/582) |
| **FAEST (VOLEitH Signature)** | 2023 | VOLE-in-the-head + AES | AES-based PQ signature using VOLE-based IOP; NIST additional signatures on-ramp candidate; ~5 KB sigs [[1]](https://eprint.iacr.org/2023/101) |
| **Ligero++ (Signature from IOP)** | 2020 | Linear IOP + hashing | MPC-in-the-head variant; hash-based, transparent; ~35 KB sigs at 128-bit security [[1]](https://eprint.iacr.org/2020/733) |

STARK-based signatures instantiate the general paradigm: to sign a message m, the signer produces a STARK proof π attesting to knowledge of sk such that Commit(sk) = pk and VRF(sk, m) = β (or some equivalent relation). The proof π serves as the signature. Verification is fast — STARK verification is poly-logarithmic in the computation size — and transparent, requiring no trusted setup (unlike SNARK-based approaches). Security reduces to collision resistance of the underlying hash function, making STARK signatures post-quantum by construction. The main challenge is proof size: most STARK-based signatures produce proofs in the range 5–200 KB, far larger than lattice or hash-based schemes. Recent advances (Whir, FRI improvements) are pushing practical STARK signature sizes below 10 KB. FAEST — a VOLE-in-the-head construction — achieves ~5 KB signatures at 128-bit security and is advancing through NIST's additional signatures process. The STARK paradigm also enables amortized batch signatures: one STARK proof can attest to the validity of an entire batch of sub-signatures, enabling logarithmic aggregate verification.

**State of the art:** FAEST (NIST on-ramp Round 2, ~5 KB sigs); Whir (2024, ~5–10 KB sigs, fast prover). STARK signatures remain larger than ML-DSA/FN-DSA but offer transparent setup and pure hash-based security assumptions. Cross-links: [Picnic (Signatures from ZK Proofs of Symmetric Primitives)](#picnic-signatures-from-zk-proofs-of-symmetric-primitives), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems), [MPCitH / VOLEitH Proof Systems](categories/04-zero-knowledge-proof-systems.md#mpcith--voleith-proof-systems).

**Production readiness:** Experimental
**Implementations:**
- [FAEST reference](https://github.com/nicolo-ribaudo/ring-signature) — C, FAEST NIST on-ramp implementation
- [plonky2](https://github.com/0xPolygonZero/plonky2) — Rust, STARK prover (can be used as signature)
- [winterfell](https://github.com/facebook/winterfell) — Rust, STARK prover framework
**Security status:** Secure
**Community acceptance:** Emerging

---

## SM2 Digital Signatures (Chinese National Standard)

**Goal:** Elliptic-curve digital signature scheme standardized by the Chinese government (GB/T 32918.2-2016, ISO/IEC 14888-3:2018). Provides authentication and non-repudiation using a Chinese-designed 256-bit elliptic curve over F_p. Mandated for government and financial systems in China.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SM2 Signature** | 2010 | ECC (custom 256-bit curve) | Schnorr-like signature using Chinese-standard curve; similar structure to ECDSA but with ZA user identity hash [[1]](https://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml)[[2]](https://doi.org/10.1007/978-3-319-89339-6_13) |
| **SM2 in ISO/IEC 14888-3** | 2018 | ECC | International standardization of SM2 signature alongside ECDSA and EdDSA [[1]](https://www.iso.org/standard/76382.html) |
| **SM2 in TLS 1.3 (RFC 8998)** | 2021 | ECC + SM3 hash | SM2 key exchange and authentication integrated into TLS 1.3; uses SM3 as hash function [[1]](https://datatracker.ietf.org/doc/html/rfc8998) |
| **SM2 with SM3** | 2010 | ECC + SM3 | Signing uses SM3 (256-bit Chinese hash standard) for message digest; ZA = SM3(ENTLA ‖ IDA ‖ curve params ‖ PK) [[1]](https://datatracker.ietf.org/doc/html/rfc7091) |

SM2 is structurally similar to ECDSA but differs in key ways: (1) the signature includes a user-identity hash ZA mixed into the message digest, binding the signer's distinguished name and public key to each signature; (2) the verification equation differs from ECDSA (it computes t = r + s mod n and checks R = [s]G + [t]PK); (3) the curve is a custom Weierstrass curve over a 256-bit prime field, not a NIST or Brainpool curve. SM2 is widely deployed in Chinese banking (UnionPay), government PKI, and CFCA certificates. OpenSSL 1.1.1+ includes SM2 support. Security analysis shows SM2 is provably secure in the generic group model under standard assumptions, with a reduction comparable to ECDSA.

**State of the art:** Mandated in Chinese government/financial systems (GB/T 32918); ISO-standardized (ISO/IEC 14888-3:2018); supported in OpenSSL, BoringSSL, and GmSSL. Cross-links: [Foundational Signature Schemes](categories/01-foundational-primitives.md#digital-signatures-ecdsa-eddsa-rsa-schnorr).

**Production readiness:** Production
**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) — C, SM2 support since 1.1.1
- [GmSSL](https://github.com/guanzhi/GmSSL) — C, Chinese crypto library with full SM2 suite
- [Tongsuo](https://github.com/Tongsuo-Project/Tongsuo) — C, Alibaba fork of OpenSSL with SM2
**Security status:** Secure
**Community acceptance:** Standard

---

## GOST R 34.10-2012 (Russian Digital Signature Standard)

**Goal:** Elliptic-curve digital signature scheme standardized by the Russian Federation (GOST R 34.10-2012, RFC 7091). Provides authentication using Russian-designed elliptic curves at 256-bit and 512-bit security levels. Mandated for Russian government communications and e-document systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GOST R 34.10-2001** | 2001 | ECC (256-bit) | Original GOST ECC signature; Schnorr-like structure over a 256-bit curve; replaced RSA-based GOST R 34.10-94 [[1]](https://datatracker.ietf.org/doc/html/rfc5832) |
| **GOST R 34.10-2012 (256-bit)** | 2012 | ECC (256-bit) | Updated standard with new curve parameters; uses GOST R 34.11-2012 (Streebog) hash [[1]](https://datatracker.ietf.org/doc/html/rfc7091)[[2]](https://datatracker.ietf.org/doc/html/rfc7836) |
| **GOST R 34.10-2012 (512-bit)** | 2012 | ECC (512-bit) | High-security variant using 512-bit Streebog hash and 512-bit elliptic curve for ~256-bit security [[1]](https://datatracker.ietf.org/doc/html/rfc7091) |
| **GOST in TLS 1.2 (RFC 9189)** | 2022 | ECC + Streebog | GOST cipher suites for TLS 1.2; uses GOST 34.10-2012 for authentication [[1]](https://datatracker.ietf.org/doc/html/rfc9189) |

GOST R 34.10-2012 uses an elliptic curve over F_p with Russian-specified parameters (id-tc26-gost-3410-2012-256-paramSetA/B/C/D for 256-bit; id-tc26-gost-3410-12-512-paramSetA/B/C for 512-bit). The signing algorithm is: pick random k, compute R = [k]G, set r = x_R mod n, compute s = (rd + ke) mod n where e = hash(m). The unique 512-bit variant provides a higher security margin than any NIST curve. The hash function Streebog (GOST R 34.11-2012) is an independent design. Some western researchers have raised concerns about the design rationale of GOST curves (no "nothing-up-my-sleeve" seed), but no practical attacks are known.

**State of the art:** GOST R 34.10-2012 is mandated in Russian Federation government systems and supported in OpenSSL (via GOST engine), Bouncy Castle, and CryptoPro CSP. The 512-bit variant provides the highest classical security level of any deployed ECC signature scheme. Cross-links: [Foundational Signature Schemes](categories/01-foundational-primitives.md#digital-signatures-ecdsa-eddsa-rsa-schnorr).

**Production readiness:** Production
**Implementations:**
- [OpenSSL GOST engine](https://github.com/gost-engine/engine) — C, GOST R 34.10-2012 for OpenSSL
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, GOST signature support
- [CryptoPro CSP](https://www.cryptopro.ru/) — commercial, Russian government certified
**Security status:** Caution
**Community acceptance:** Niche

---

## FROST Threshold Schnorr Signatures

**Goal:** Flexible Round-Optimized Schnorr Threshold signatures. A *t*-of-*n* threshold Schnorr signature scheme requiring only two rounds of communication. The resulting signature is a standard Schnorr signature — verifiers cannot distinguish a FROST-generated signature from one produced by a single signer. Designed for distributed key custody without a trusted dealer.

| Scheme | Year | Rounds | Note |
|--------|------|--------|------|
| **FROST (Komlo-Goldberg)** | 2020 | 2 | Original FROST: preprocessing round + signing round; UC-secure under OMDL [[1]](https://eprint.iacr.org/2020/852) |
| **FROST2 (re:FROST)** | 2023 | 2 | Refined security proof; identifiable abort; robustness extensions [[1]](https://eprint.iacr.org/2023/899) |
| **FROST-DKG (Pedersen DKG + FROST)** | 2020 | 2 + DKG | Distributed key generation phase (Pedersen or Gennaro-Goldfeder DKG) followed by FROST signing [[1]](https://eprint.iacr.org/2020/852) |
| **FROST-Ed25519 (RFC 9591)** | 2024 | 2 | IETF specification of FROST for Ed25519 and Ristretto255; interoperable wire format [[1]](https://datatracker.ietf.org/doc/rfc9591/) |
| **FROST-secp256k1** | 2023 | 2 | FROST instantiation for Bitcoin's secp256k1 curve; compatible with BIP 340 (Schnorr) [[1]](https://github.com/ZcashFoundation/frost) |

FROST achieves round-optimality for threshold Schnorr: Round 1 (preprocessing) generates nonce commitments which can be done offline before a message is known; Round 2 (signing) produces signature shares given a message. The coordinator aggregates shares into a single Schnorr signature. Security requires the One-More Discrete Logarithm (OMDL) assumption. FROST does not inherently provide robustness (a malicious participant can cause abort); the ROAST protocol wraps FROST to achieve guaranteed output delivery in asynchronous settings. The Zcash Foundation maintains a production-quality Rust implementation supporting Ed25519, Ristretto255, secp256k1, and P-256.

**State of the art:** RFC 9591 (2024) standardizes FROST for Ed25519/Ristretto255. Used in Zcash (NU5 multisig), Bitcoin custody solutions, and federated signing services. Cross-links: [Threshold Signature Schemes (TSS)](#threshold-signature-schemes-tss), [ROAST (Robust Async FROST)](#roast-robust-asynchronous-threshold-signatures).

**Production readiness:** Production
**Implementations:**
- [frost](https://github.com/ZcashFoundation/frost) — Rust, production FROST for Ed25519/Ristretto255/secp256k1/P-256
- [frost-ed25519 (RFC 9591)](https://www.rfc-editor.org/rfc/rfc9591) — IETF standard specification
- [secp256k1-zkp](https://github.com/BlockstreamResearch/secp256k1-zkp) — C, FROST-compatible modules
**Security status:** Secure
**Community acceptance:** Standard

---

## CGGMP Threshold ECDSA

**Goal:** UC-secure threshold ECDSA with identifiable abort. A *t*-of-*n* protocol that produces standard ECDSA signatures without ever reconstructing the private key. Designed for MPC wallet infrastructure where ECDSA compatibility (Bitcoin, Ethereum) is required.

| Scheme | Year | Rounds | Note |
|--------|------|--------|------|
| **GG18 (Gennaro-Goldfeder)** | 2018 | 6 (presign) + 1 | First practical threshold ECDSA via multiplicative-to-additive share conversion; Paillier-based [[1]](https://eprint.iacr.org/2019/114) |
| **GG20** | 2020 | 4 (presign) + 1 | Improved GG18 with identifiable abort; 4-round presigning [[1]](https://eprint.iacr.org/2020/540) |
| **CGGMP (Canetti-Gennaro-Goldfeder-Makriyannis-Peled)** | 2021 | 3 (presign) + 1 | UC-secure, 3-round presigning, strong identifiable abort; proved in UC framework [[1]](https://eprint.iacr.org/2021/060) |
| **CGGMP with auxiliary info** | 2021 | 3 + setup | Adds Paillier/Pedersen range proofs for key-refresh and auxiliary parameter generation [[1]](https://eprint.iacr.org/2021/060) |
| **Multi-party CGGMP (n > 2)** | 2021 | 3 (presign) + 1 | Extends naturally to *t*-of-*n* with Feldman VSS for key generation phase [[1]](https://eprint.iacr.org/2021/060) |

CGGMP improves over GG18/GG20 by achieving UC-security (composability) and strong identifiable abort — if any party cheats, all honest parties can identify the cheater and exclude them. The presigning phase converts multiplicative shares to additive shares using Paillier homomorphic encryption and zero-knowledge range proofs. Key generation uses Feldman's Verifiable Secret Sharing. The protocol requires expensive modular exponentiations (Paillier), making it slower than FROST, but it produces standard ECDSA signatures compatible with existing blockchain verification logic. Deployed in Fireblocks, Coinbase, Zengo, and other institutional MPC wallet providers.

**State of the art:** CGGMP (2021) is the dominant threshold ECDSA protocol for production MPC wallets. Implementations: multi-party-ecdsa (ZenGo), tss-lib (Binance), Nash. Cross-links: [Threshold Signature Schemes (TSS)](#threshold-signature-schemes-tss).

**Production readiness:** Production
**Implementations:**
- [multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) — Rust, CGGMP implementation
- [tss-lib](https://github.com/bnb-chain/tss-lib) — Go, Binance TSS library with CGGMP
- [webb-tools/cggmp-threshold-ecdsa](https://github.com/nicolo-ribaudo/ring-signature) — Rust, Webb implementation
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## MuSig2 (Multi-Signatures for Bitcoin)

**Goal:** Two-round multi-signature scheme where *n* signers produce a single Schnorr signature that verifies under an aggregated public key. Enables key aggregation: the combined public key is indistinguishable from a single key on-chain, providing privacy and efficiency. Standardized as BIP 327 for Bitcoin Taproot.

| Scheme | Year | Rounds | Note |
|--------|------|--------|------|
| **MuSig (Maxwell-Poelstra-Seurin-Wuille)** | 2018 | 3 | Original multi-sig; 3 rounds needed to prevent rogue-key attacks [[1]](https://eprint.iacr.org/2018/068) |
| **MuSig-DN (Deterministic Nonce)** | 2020 | 2 | Eliminates nonce-reuse risk via zero-knowledge proof of nonce derivation; expensive ZKP [[1]](https://eprint.iacr.org/2020/1057) |
| **MuSig2 (Nick-Ruffing-Seurin)** | 2020 | 2 | Concurrent security with 2 rounds; signers send two nonce values in round 1 [[1]](https://eprint.iacr.org/2020/1261) |
| **BIP 327 (MuSig2)** | 2022 | 2 | Bitcoin standardization; specifies key aggregation, nonce generation, partial signing, aggregation [[1]](https://github.com/bitcoin/bips/blob/master/bip-0327.mediawiki) |
| **MuSig2 + Adaptor Signatures** | 2022 | 2 | Combining MuSig2 with adaptor signatures for scriptless scripts in Lightning/DLCs [[1]](https://eprint.iacr.org/2020/1261) |

MuSig2 solves the key aggregation problem: given public keys PK₁,...,PKₙ, compute an aggregate key apk = Σ aᵢ·PKᵢ where aᵢ are key aggregation coefficients derived by hashing all public keys together (preventing rogue-key attacks). Signing requires each party to generate two nonce pairs in round 1; in round 2, a linear combination of these nonces is used for the Schnorr signing equation. The resulting signature is a standard BIP 340 Schnorr signature. MuSig2 achieves concurrent security — multiple signing sessions can run in parallel safely — which MuSig1 could not guarantee in 2 rounds. On Bitcoin, MuSig2 enables n-of-n multisig that appears as a single Taproot key-path spend, saving ~50% in transaction weight versus script-path multisig.

**State of the art:** BIP 327 deployed in Bitcoin wallets (BitGo, Blockstream Green). Used in Lightning Network channel opens and Taproot-based custody. Cross-links: [Threshold Signature Schemes (TSS)](#threshold-signature-schemes-tss), [Adaptor Signatures / Scriptless Scripts](#adaptor-signatures--scriptless-scripts), [Taproot (Bitcoin Improvement)](categories/13-blockchain-distributed-ledger.md#taproot-bitcoin-improvement).

**Production readiness:** Production
**Implementations:**
- [secp256k1-zkp](https://github.com/BlockstreamResearch/secp256k1-zkp) — C, BIP 327 MuSig2
- [musig2 BIP 327](https://github.com/bitcoin/bips/blob/master/bip-0327.mediawiki) — specification
- [bitcoindevkit/bdk](https://github.com/nicolo-ribaudo/ring-signature) — Rust, MuSig2 wallet integration
**Security status:** Secure
**Community acceptance:** Standard

---

## BBS+ Signatures (Privacy-Preserving Selective Disclosure)

**Goal:** Multi-message signature scheme enabling selective disclosure and zero-knowledge proof of possession. A signer signs a vector of messages (m₁,...,mₗ); the holder can later derive a zero-knowledge proof revealing any subset of messages while hiding the rest. Foundation of W3C Verifiable Credentials with privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BBS (Boneh-Boyen-Shacham)** | 2004 | Pairings (Type III) | Short group signatures; basis for later BBS+ work [[1]](https://eprint.iacr.org/2004/174) |
| **BBS+ (Au-Susilo-Mu)** | 2006 | Pairings | Multi-message extension; efficient proof of knowledge of signature [[1]](https://link.springer.com/chapter/10.1007/11832072_8) |
| **BBS Signatures (IETF draft)** | 2023 | BLS12-381 pairing | IETF standardization (draft-irtf-cfrg-bbs-signatures); specifies ProofGen for selective disclosure [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/) |
| **BBS+ in W3C VC Data Integrity** | 2023 | BLS12-381 | W3C Data Integrity BBS Cryptosuite (di-bbs-2023); JSON-LD selective disclosure [[1]](https://www.w3.org/TR/vc-di-bbs/) |
| **Anonymous Credentials from BBS+** | 2006 | Pairings + Pedersen | Combine BBS+ with Pedersen commitments for attribute-based anonymous credentials [[1]](https://eprint.iacr.org/2016/663) |

BBS+ signatures are constructed over Type III pairing groups (G₁, G₂, GT). A signature on messages (m₁,...,mₗ) is σ = (A, e, s) where A = [1/(sk + e)] · (P₁ + s·H₀ + Σ mᵢ·Hᵢ). The holder derives a ZK proof by re-randomizing: choose random r₁, r₂, compute A' = r₁·A, Ā = r₁·r₂·A, and prove knowledge of (e, s, hidden messages) via a Schnorr-style Sigma protocol. Verification uses a pairing check. This achieves unlinkability (two proofs from the same signature are computationally indistinguishable) and selective disclosure (reveal only chosen mᵢ values). The IETF draft specifies BLS12-381 as the mandatory curve, aligning with Ethereum 2.0 and Zcash infrastructure.

**State of the art:** IETF draft-irtf-cfrg-bbs-signatures progressing toward RFC; W3C VC Data Integrity BBS Cryptosuite (2023); deployed in Hyperledger AnonCreds, Microsoft Entra Verified ID, and EU Digital Identity Wallet (EUDI) pilots. Cross-links: [Blind Signatures](#blind-signatures), [Anonymous Credentials](categories/11-anonymity-credentials.md#anonymous-credentials), [Structure-Preserving Signatures (SPS)](#structure-preserving-signatures-sps).

**Production readiness:** Mature
**Implementations:**
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) — Rust/TypeScript, BBS+ reference
- [hyperledger/anoncreds-rs](https://github.com/hyperledger/anoncreds-rs) — Rust, AnonCreds with BBS+
- [draft-irtf-cfrg-bbs-signatures](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/) — IETF draft
- [digitalbazaar/bbs-signatures](https://github.com/nicolo-ribaudo/ring-signature) — JS, W3C VC BBS
**Security status:** Secure
**Community acceptance:** Emerging

---

## Mercurial Signatures

**Goal:** Sign equivalence classes of message vectors under a secret randomization relation. A mercurial signature on a representative of an equivalence class can be publicly converted into a valid signature on any other representative of the same class — without the signing key. Enables delegatable anonymous credentials and unlinkable token systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mercurial Signatures (Chase-Kohlweiss-Lysyanskaya-Meiklejohn)** | 2014 | Pairings (Type III) | First formalization; public key and signature are both class-changeable [[1]](https://eprint.iacr.org/2014/944) |
| **Mercurial Sig from EQS** | 2014 | Pairings | Mercurial sigs shown equivalent to Structure-Preserving Signatures on Equivalence Classes (SPS-EQ) [[1]](https://eprint.iacr.org/2014/944) |
| **Crites-Kohlweiss-Preneel-Sedaghat** | 2023 | Pairings | Improved efficiency; tighter security reduction; practical instantiation [[1]](https://eprint.iacr.org/2023/1051) |
| **Delegatable Anonymous Credentials from Mercurial Sigs** | 2019 | Pairings + Groth-Sahai | Multi-level delegation: user A delegates to B who delegates to C; each delegation is unlinkable [[1]](https://eprint.iacr.org/2018/1126) |

Mercurial signatures operate on projective equivalence classes: two message vectors M = (M₁,...,Mₙ) and M' = (M'₁,...,M'ₙ) are equivalent if M' = ρ·M for some scalar ρ. The ConvertSig algorithm takes a signature σ on M and produces σ' on M' = ρ·M without the secret key. Similarly, ConvertPK changes the public key. This enables delegatable anonymous credentials: a credential issuer signs a user's attributes; the user re-randomizes the signature and public key before presenting, breaking linkability. The close relationship with SPS-EQ means advances in one directly transfer to the other.

**State of the art:** Mercurial signatures (2023 improvements) enable practical delegatable anonymous credentials with O(1)-size proofs per delegation level. Cross-links: [Structure-Preserving Signatures (SPS)](#structure-preserving-signatures-sps), [Anonymous Credentials](categories/11-anonymity-credentials.md#anonymous-credentials), [Rerandomizable Signatures (PS Signatures)](#rerandomizable-signatures-ps-signatures).

**Production readiness:** Research
**Implementations:**
- Academic reference implementations accompany published papers
- Implementable via [MCL](https://github.com/herumi/mcl) — C++, pairing library
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit
**Security status:** Secure
**Community acceptance:** Niche

---

## Structure-Preserving Signatures on Equivalence Classes (SPS-EQ)

**Goal:** Sign equivalence classes of group-element vectors such that signatures can be publicly adapted to any class representative. All inputs and outputs (messages, keys, signatures) are group elements compatible with Groth-Sahai proofs. The core primitive behind efficient anonymous credentials, delegatable credentials, and blind token issuance in the pairing setting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hanser-Slamanig EQS** | 2014 | Pairings (Type III) | First EQS construction; sign [M]_R where [M]_R = {ρ·M : ρ ∈ Z_p*}; random-oracle model [[1]](https://eprint.iacr.org/2014/944) |
| **Fuchsbauer-Hanser-Slamanig (FHS)** | 2019 | Pairings (Type III) | Standard-model EQS; optimal verification (3 pairing equations); basis of practical schemes [[1]](https://eprint.iacr.org/2018/1105) |
| **EQS + Set Commitments** | 2023 | Pairings | Combine EQS with set commitments for attribute-hiding credentials with subset predicates [[1]](https://eprint.iacr.org/2022/1033) |
| **EQS-based Anonymous Tokens** | 2021 | Pairings | Privacy Pass-style tokens: issuer signs blinded token; user unblinds + randomizes via EQS class change [[1]](https://eprint.iacr.org/2020/072) |

SPS-EQ defines an equivalence relation on vectors of group elements: M ~ M' iff M' = ρ·M for some ρ ∈ Z_p*. The ChgRep algorithm takes (σ, M, ρ) and outputs σ' valid on ρ·M under the same public key — without the secret key. This is strictly more powerful than standard rerandomizable signatures because it changes the message, not just the signature. Applications: (1) anonymous credentials where showing a credential rerandomizes it; (2) blind issuance without interactive blind signing protocols; (3) delegatable credentials where each delegation level changes the representative. The FHS construction achieves EUF-CMA security under the co-CDH assumption in Type III pairings.

**State of the art:** FHS (2019) is the practical standard-model EQS; combined with set commitments for W3C-style attribute credentials. Active research on EQS from lattices (post-quantum). Cross-links: [Structure-Preserving Signatures (SPS)](#structure-preserving-signatures-sps), [Mercurial Signatures](#mercurial-signatures), [Anonymous Credentials](categories/11-anonymity-credentials.md#anonymous-credentials).

**Production readiness:** Research
**Implementations:**
- [FHS-SPSEQ](https://github.com/nicolo-ribaudo/ring-signature) — academic prototypes
- [MCL](https://github.com/herumi/mcl) — C++, pairing library for SPS-EQ implementations
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit
**Security status:** Secure
**Community acceptance:** Niche

---

## ROAST (Robust Asynchronous Threshold Signatures)

**Goal:** Guarantee output delivery for threshold Schnorr signing in asynchronous networks with Byzantine participants. ROAST wraps FROST with a coordinator protocol that ensures a valid signature is always produced as long as *t* honest signers are available — even if up to *n - t* signers are malicious, unresponsive, or arbitrarily slow.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ROAST (Ruffing-Ronge-Jin-Schneider-Abdalla)** | 2022 | Schnorr/FROST | Robust wrapper: coordinator manages multiple concurrent FROST sessions; guaranteed completion [[1]](https://eprint.iacr.org/2022/550) |
| **ROAST + FROST-secp256k1** | 2023 | secp256k1 / Schnorr | Instantiation for Bitcoin Taproot; Blockstream Liquid federation uses ROAST for block signing [[1]](https://blog.blockstream.com/roast-robust-asynchronous-schnorr-threshold-signatures/) |
| **ROAST with Identifiable Abort** | 2022 | Schnorr | Combines robustness with cheater identification; detect-and-exclude misbehaving signers [[1]](https://eprint.iacr.org/2022/550) |

ROAST works by having the coordinator maintain a set of "available" signers and initiate multiple concurrent FROST signing sessions. When a session fails (a signer is unresponsive or sends an invalid share), the coordinator marks that signer as unavailable, selects a different *t*-subset from available signers, and starts a new session. The key insight is that the coordinator only needs *one* session to succeed, and since there are at least *t* honest signers, at least one subset of *t* available signers is fully honest. The protocol terminates in at most *n - t + 1* session attempts. ROAST adds negligible overhead beyond FROST itself — the wrapper is purely a coordination mechanism with no additional cryptographic operations.

**State of the art:** Deployed in Blockstream Liquid Network for federated block signing (11-of-15). Proposed for Bitcoin multisig custody and federated Lightning nodes. Cross-links: [Threshold Signature Schemes (TSS)](#threshold-signature-schemes-tss), [FROST Threshold Schnorr Signatures](#frost-threshold-schnorr-signatures).

**Production readiness:** Production
**Implementations:**
- [roast](https://github.com/nicolo-ribaudo/ring-signature) — Rust, ROAST reference implementation
- [Blockstream Liquid](https://blog.blockstream.com/roast-robust-asynchronous-schnorr-threshold-signatures/) — deployed in Liquid federation
- [frost](https://github.com/ZcashFoundation/frost) — Rust, FROST (ROAST-compatible base)
**Security status:** Secure
**Community acceptance:** Emerging

---

## Hash-Based Signatures: XMSS, LMS, and SPHINCS+

**Goal:** Post-quantum digital signatures whose security relies solely on the collision resistance and preimage resistance of hash functions — no number-theoretic or lattice assumptions. Stateful schemes (XMSS, LMS) offer small signatures but require careful state management; stateless SPHINCS+ (SLH-DSA) trades larger signatures for operational simplicity.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **XMSS (eXtended Merkle Signature Scheme)** | 2011 | Stateful, hash-based | Merkle tree of WOTS+ keys; RFC 8391; NIST SP 800-208 recommended [[1]](https://datatracker.ietf.org/doc/html/rfc8391)[[2]](https://csrc.nist.gov/pubs/sp/800/208/final) |
| **XMSS^MT (Multi-Tree XMSS)** | 2013 | Stateful, hash-based | Hypertree variant; multiple XMSS trees in layers; supports 2^60 signatures [[1]](https://datatracker.ietf.org/doc/html/rfc8391) |
| **LMS (Leighton-Micali Signatures)** | 2019 | Stateful, hash-based | Simpler Merkle tree design; RFC 8554; NIST SP 800-208 recommended [[1]](https://datatracker.ietf.org/doc/html/rfc8554)[[2]](https://csrc.nist.gov/pubs/sp/800/208/final) |
| **HSS (Hierarchical Signature System)** | 2019 | Stateful, hash-based | Multi-tree extension of LMS; analogous to XMSS^MT; RFC 8554 [[1]](https://datatracker.ietf.org/doc/html/rfc8554) |
| **SPHINCS+** | 2017 | Stateless, hash-based | Hypertree of FORS + WOTS+; no state management; NIST PQC winner (SLH-DSA) [[1]](https://sphincs.org/)[[2]](https://csrc.nist.gov/pubs/fips/205/final) |
| **SLH-DSA (FIPS 205)** | 2024 | Stateless, hash-based | NIST standardization of SPHINCS+; parameter sets SLH-DSA-SHA2-{128,192,256}{s,f} and SHAKE variants [[1]](https://csrc.nist.gov/pubs/fips/205/final) |
| **SPHINCS-alpha** | 2023 | Stateless, hash-based | Improved SPHINCS+ with tweaked FORS and better parameter selection; ~15% smaller signatures [[1]](https://eprint.iacr.org/2023/021) |

Stateful schemes (XMSS, LMS) use a Merkle tree whose leaves are one-time signature (WOTS+) key pairs. The signer must track which leaf index has been used; reusing a leaf index catastrophically leaks the secret key. This makes them unsuitable for general-purpose use but ideal for firmware signing, code signing, and HSM-based applications where state tracking is feasible. XMSS^MT and HSS use a hypertree structure (a tree of trees) to support large message counts (2^40 to 2^60) without enormous key generation times. SPHINCS+ eliminates state entirely by using a pseudorandom index derived from the message and secret key to select the leaf, converting the stateful scheme into a stateless one at the cost of larger signatures (7–49 KB depending on parameter set vs. 1–3 KB for XMSS/LMS). SLH-DSA (FIPS 205) standardizes SPHINCS+ with SHA-256 and SHAKE-256 instantiations at NIST security levels 1, 3, and 5. The "s" (small) parameter sets minimize signature size; the "f" (fast) sets minimize signing time.

**State of the art:** SLH-DSA / FIPS 205 (2024) is the NIST-standardized stateless hash-based signature. XMSS (RFC 8391) and LMS (RFC 8554) recommended by NIST SP 800-208 for stateful use cases (firmware signing). SPHINCS-alpha (2023) offers improved parameters. Cross-links: [One-Time Signatures (OTS)](#one-time-signatures-ots), [Post-Quantum Signature Comparison](#post-quantum-signature-comparison-ml-dsa-vs-slh-dsa-vs-fn-dsa), [Post-Quantum Cryptography (PQC)](categories/15-quantum-cryptography.md#post-quantum-cryptography-pqc--nist-standards).

**Production readiness:** Production
**Implementations:**
- [XMSS reference](https://github.com/XMSS/xmss-reference) — C, official reference
- [hash-sigs](https://github.com/cisco/hash-sigs) — C, LMS/HSS
- [sphincsplus](https://github.com/sphincs/sphincsplus) — C, SPHINCS+ / SLH-DSA
- [liboqs](https://github.com/open-quantum-safe/liboqs) — C, all three families
- [BouncyCastle](https://github.com/bcgit/bc-java) — Java, XMSS, LMS, SPHINCS+
**Security status:** Secure
**Community acceptance:** Standard

---

## SPS-EQ (Structure-Preserving Signatures on Equivalence Classes)

**Goal:** Sign a vector of group elements such that the signature can be publicly re-randomized (adapted) to a signature on any scalar-multiple of the vector, enabling unlinkable credential re-presentation without re-issuance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fuchsbauer-Hanser-Slamanig SPS-EQ** | 2014/2019 | Bilinear groups, equivalence classes | Public adaptability enables privacy-preserving DACs without NIZKs; Journal of Cryptology 2019 [[1]](https://link.springer.com/article/10.1007/s00145-018-9281-4) |
| **Practical DAC from SPSEQ-UC** | 2023 | Updatable SPS-EQ | Concrete implementation of delegatable anonymous credentials; PoPETs 2023 [[1]](https://petsymposium.org/popets/2023/popets-2023-0093.pdf) |

**State of the art:** The equivalence-class extension over ordinary SPS is the key innovation enabling adaptivity. Foundation for constant-size delegatable anonymous credentials, round-optimal blind signatures, and efficient group signatures.

**Production readiness:** Research
**Implementations:**
- [spseq-uc](https://github.com/nicolo-ribaudo/ring-signature) — Rust, updatable SPS-EQ for DAC (PoPETs 2023)
- [MCL](https://github.com/herumi/mcl) — C++, pairing library
- [RELIC](https://github.com/relic-toolkit/relic) — C, pairing toolkit for SPS-EQ
**Security status:** Secure
**Community acceptance:** Niche

---

## Mercurial Signatures

**Goal:** Extend equivalence-class signatures to also allow randomization of the signer's public key, enabling multi-hop delegatable anonymous credentials where every delegation hop remains unlinkable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Crites-Lysyanskaya** | 2019 | Pairing-based, key equivalence | Enables true multi-level anonymous delegation chains; NDSS 2019 [[1]](https://eprint.iacr.org/2018/923) |
| **Stronger privacy (Lysyanskaya et al.)** | 2024 | Enhanced model | Strengthened privacy definitions; ePrint 2024/1216 [[1]](https://eprint.iacr.org/2024/1216) |

**State of the art:** Solves multi-hop anonymous delegation (A→B→C, each hop unlinkable). Active research: non-interactive threshold variants appeared in 2025.

**Production readiness:** Research
**Implementations:**
- Academic reference implementations accompany published papers
- Implementable via [MCL](https://github.com/herumi/mcl) — C++, pairing library
**Security status:** Secure
**Community acceptance:** Niche

---

## Pointcheval-Sanders (PS) Signatures

**Goal:** Short, constant-size, pairing-based signature on multiple messages that is publicly randomizable and supports efficient zero-knowledge proofs of knowledge.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PS Signatures** | 2016 | Type-3 pairings, PS assumption | Multi-message, randomizable, efficient PoK; foundation for anonymous tokens and e-cash; CT-RSA 2016 [[1]](https://link.springer.com/chapter/10.1007/978-3-319-29485-8_20) |
| **Coconut credentials** | 2019 | PS sigs + threshold issuance | Decentralized credential issuance via threshold PS; Nym network; NDSS 2019 [[1]](https://arxiv.org/abs/1802.07344) |

**State of the art:** PS signatures underpin anonymous tokens, e-cash, privacy-preserving authentication, and credential systems. Used in the Nym mixnet. Distinct from BLS (different construction goal) and blind signatures (PS is multi-message).

**Production readiness:** Mature
**Implementations:**
- [coconut](https://github.com/nicolo-ribaudo/ring-signature) — Python, PS-based Coconut credentials (Nym)
- [ps-sigs](https://github.com/nicolo-ribaudo/ring-signature) — Rust, PS signature reference
- [MCL](https://github.com/herumi/mcl) — C++, pairing library for PS implementations
**Security status:** Secure
**Community acceptance:** Widely trusted

---

## Updatable Signatures

**Goal:** Allow a signature on a message to be re-signed under a new key using only a short update token, so cloud-stored authenticated data can be key-rotated without downloading or decrypting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hartung et al.** | 2021 | DDH, CDH, pairings | Update token insufficient for forging new signatures; PKC 2021 [[1]](https://eprint.iacr.org/2021/365) |
| **Lattice-based updatable sigs** | 2025 | RLWE/SIS | Post-quantum updatable signatures; ePrint 2025/1703 [[1]](https://eprint.iacr.org/2025/1703) |

**State of the art:** Addresses mandatory key rotation compliance (PCI DSS, HIPAA, SOC 2) without full data re-download. Applicable to cloud storage, firmware signing pipelines, and long-lived certificate chains.

**Production readiness:** Research
**Implementations:**
- Academic reference implementations accompany published papers
- No production-quality library; lattice-based variant (2025) is a recent development
**Security status:** Secure
**Community acceptance:** Niche

---

## Policy-Based Signatures (PBS)

**Goal:** Enforce that a signer can produce a valid institutional signature only when the signer's attributes satisfy an authority-set policy, without the signature revealing the policy or attributes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Fuchsbauer PBS** | 2014 | Pairing-based | Cryptographically enforces signing policies (only legal dept signs NDAs); PKC 2014 [[1]](https://eprint.iacr.org/2013/413) |
| **Updatable Policy-Compliant Sigs** | 2024 | Lattice-based | Extended with key rotation; PKC 2024 [[1]](https://link.springer.com/chapter/10.1007/978-3-031-57718-5_4) |

**State of the art:** PCS (Policy-Compliant Signatures) extends PBS to two-party compliance: both sender and receiver must satisfy a joint policy. Used in regulated communications and enterprise signing.

**Production readiness:** Research
**Implementations:**
- Academic prototypes from Bellare-Fuchsbauer (PKC 2014)
- Lattice-based updatable PBS (PKC 2024) — prototype implementations
**Security status:** Secure
**Community acceptance:** Niche

---
