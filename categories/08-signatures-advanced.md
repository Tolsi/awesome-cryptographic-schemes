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
| **Dynamic Group Signatures (Bellare-Shi-Zhang)** | 2005 | Group (dynamic) | Efficient join/revoke of members without re-keying; practical for real deployments [[1]](https://eprint.iacr.org/2005/385) |

**State of the art:** CLSAG (privacy coins), dynamic group sigs (enterprise with member management), Raptor (PQ ring sig).

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

## Attribute-Based Signatures (ABS)

**Goal:** Policy-based authentication. Sign a message with a set of attributes; the signature verifies if the signer's attributes satisfy a policy — without revealing which attributes or the signer's identity. Dual of ABE for signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maji-Prabhakaran-Rosulek ABS** | 2011 | Pairings | First ABS with expressive policies (monotone span programs) [[1]](https://eprint.iacr.org/2010/595) |
| **Sakai-Attrapadung ABS** | 2016 | Pairings | Efficient constant-size signatures for AND policies [[1]](https://eprint.iacr.org/2016/246) |
| **Lattice ABS** | 2014 | SIS / LWE | Post-quantum attribute-based signatures [[1]](https://eprint.iacr.org/2014/279) |

**State of the art:** Pairing-based ABS (practical), Lattice ABS (PQ setting).

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

## Homomorphic Signatures

**Goal:** Compute on authenticated data. Given signatures on messages m₁,...,mₙ, anyone can derive a valid signature on f(m₁,...,mₙ) without the signing key. Enables verifiable delegation of computation on signed datasets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Linearly Homomorphic Sig (Boneh-Freeman)** | 2011 | Pairings | Sign vectors; derive sig on any linear combination [[1]](https://eprint.iacr.org/2009/025) |
| **Fully Homomorphic Sig (Gennaro-Wichs)** | 2013 | FHE + SNARK | Sign data; derive sig on ANY computable function [[1]](https://eprint.iacr.org/2012/023) |
| **Homomorphic Sig for Polynomials (Catalano-Fiore)** | 2013 | Pairings | Evaluate multivariate polynomials on signed data [[1]](https://eprint.iacr.org/2013/433) |

**State of the art:** Linear homomorphic sigs (practical, used in network coding), fully homomorphic sigs (theoretical).

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

## Sequential Aggregate Signatures

**Goal:** Chain-ordered aggregation. Each signer in sequence adds their signature to the aggregate — the final result is one compact signature validating all signers in order. Used in BGP route attestation, certificate chains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lysyanskaya-Micali-Reyzin-Shacham (LMRS)** | 2004 | RSA + certified trapdoor | First sequential aggregate sig; signer-by-signer aggregation [[1]](https://eprint.iacr.org/2003/197) |
| **Boneh-Gentry-Lynn-Shacham (BGLS)** | 2003 | BLS + pairings | Non-sequential aggregate: any order; see [Digital Signatures](#digital-signatures) for BLS [[1]](https://eprint.iacr.org/2002/175) |
| **History-Free Sequential Aggregate (HSA)** | 2012 | RSA-based | No need to see previous messages; only aggregate sig passed along [[1]](https://eprint.iacr.org/2012/486) |

**State of the art:** BGLS (general aggregation), LMRS (sequential/routing), HSA (bandwidth-optimized).

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

## Threshold Blind Signatures

**Goal:** Distributed blind signing. A threshold t-of-n signers jointly produce a blind signature — no individual signer sees the message, and no fewer than t signers can produce a valid signature. Combines the anonymity of [Blind Signatures](#blind-signatures) with the distributed trust of [Threshold Signatures](#threshold-signature-schemes-tss).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boldyreva Threshold Blind Sig** | 2003 | Gap-DH | First efficient threshold blind signature; based on BLS [[1]](https://eprint.iacr.org/2002/118) |
| **Threshold Blind BLS (Tomescu et al.)** | 2022 | BLS + DKG | Practical threshold blind BLS for anonymous token issuance [[1]](https://eprint.iacr.org/2022/1095) |
| **Lattice Threshold Blind Sig** | 2025 | SIS | First post-quantum threshold blind signature from lattices [[1]](https://eprint.iacr.org/2025/1566) |

**State of the art:** Lattice-based (PQ, 2025); BLS-based for production use. Combines [Blind Signatures](#blind-signatures), [Threshold Signatures](#threshold-signature-schemes-tss), and [Privacy Pass](#privacy-pass--anonymous-tokens).

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

## Fail-Stop Signatures

**Goal:** Provable forgery detection. If an adversary with unbounded computational power forges a signature, the legitimate signer can produce an unconditional proof of forgery — the system "fails and stops" rather than silently accepting. Signers have information-theoretic protection; verifiers have computational protection. Strictly stronger than standard signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pfitzmann-Waidner Fail-Stop Sigs** | 1990 | Factoring + prekey | First fail-stop signature; signer proves forgery unconditionally [[1]](https://epubs.siam.org/doi/10.1137/S009753979324557X) |
| **Pedersen-Pfitzmann FSS** | 1997 | DLP | Efficient fail-stop from discrete log; SIAM J. Computing [[1]](https://epubs.siam.org/doi/10.1137/S009753979324557X) |
| **PQ Fail-Stop Sigs** | 2024 | Lattice | "That's Not My Signature!" — fail-stop for post-quantum world; CRYPTO 2024 [[1]](https://link.springer.com/chapter/10.1007/978-3-031-68376-3_4) |

**State of the art:** PQ fail-stop signatures (CRYPTO 2024); revived interest for post-quantum contexts. Extends [Digital Signatures](#digital-signatures).

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

## Traceable Signatures

**Goal:** Accountability in group signatures. A group member can sign anonymously, but if they exceed a signing quota (e.g., sign more than k times in an epoch), the group manager can trace and identify them. Stronger than linkability — full identity recovery.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Traceable Sigs** | 2004 | DLP + pairings | First traceable sigs; manager traces over-signers; CCA-anonymous [[1]](https://eprint.iacr.org/2004/007) |
| **Traceable Sigs with Stepping Capabilities** | 2008 | Pairings | Incremental tracing: trace after threshold violations [[1]](https://doi.org/10.1007/978-3-540-78967-3_7) |
| **Lattice Traceable Sigs** | 2019 | LWE / SIS | Post-quantum traceable group signatures [[1]](https://eprint.iacr.org/2019/1158) |

**State of the art:** Lattice-based traceable sigs for PQ; extends [Ring & Group Signatures](#ring--group-signatures) and [Linkable Ring Signatures](#linkable-ring-signatures) with full traceability.

---

## Ring VRF

**Goal:** Anonymous pseudorandom identity. Combine ring signature anonymity with VRF pseudorandomness: prove membership in a ring and output a unique, deterministic, unlinkable pseudonym per context — without revealing which ring member you are.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burdges-de Valence-Hopwood-Patak Ring VRF** | 2023 | Schnorr + ring + VRF | First Ring VRF; unlinkable pseudonymous identity across contexts [[1]](https://eprint.iacr.org/2023/002) |
| **ZK Continuations for Ring VRF** | 2023 | Groth16 + recursion | Efficient Ring VRF via recursive ZK proofs [[1]](https://eprint.iacr.org/2023/002) |

**State of the art:** Ring VRF (2023); enables anonymous rate-limiting, anonymous login, and credential systems. Combines [VRF](#verifiable-random-functions-vrf) and [Ring Signatures](#ring--group-signatures).

---

## Threshold Ring Signatures

**Goal:** Anonymous threshold signing. At least t members of a ring must cooperate to produce a valid signature, but the ring hides which members signed. Combines the anonymity of ring signatures with the distributed trust of threshold signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bresson-Stern-Szydlo TRS** | 2002 | DLP | First threshold ring signature; t-of-n from a ring of N [[1]](https://doi.org/10.1007/3-540-36178-2_20) |
| **Tsang-Wei TRS** | 2005 | Pairings | Short threshold ring sigs; separable threshold from ring [[1]](https://doi.org/10.1007/978-3-540-30580-4_27) |
| **Lattice TRS (Cayrel et al.)** | 2010 | Lattice (SIS) | Post-quantum threshold ring signatures [[1]](https://doi.org/10.1007/978-3-642-14423-3_18) |

**State of the art:** Lattice-based TRS for PQ. Combines [Ring & Group Signatures](#ring--group-signatures) and [Threshold Signatures](#threshold-signature-schemes-tss).

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

---
