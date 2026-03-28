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
