# Theoretical Foundations

## Leakage-Resilient Cryptography

**Goal:** Side-channel resistance in theory. Schemes that remain secure even when an adversary obtains partial information about the secret key (via power analysis, timing, EM emanation, cold boot attacks).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dziembowski-Pietrzak (LR stream cipher)** | 2008 | PRG + alternating extraction | First leakage-resilient stream cipher [[1]](https://eprint.iacr.org/2008/135) |
| **Faust-Kiltz-Pietrzak-Rothblum** | 2010 | Any LR-PRG | Leakage-resilient signatures from any LR-secure PRG [[1]](https://eprint.iacr.org/2009/282) |
| **Prouff-Rivain (masking)** | 2013 | Boolean masking | Practical higher-order masking for AES; provable security [[1]](https://eprint.iacr.org/2013/468) |

**State of the art:** Prouff-Rivain masking (industry standard for smart cards), theoretical LR frameworks (complementary).

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

## Witness Indistinguishability (WI) / Witness Hiding

**Goal:** Relaxed zero-knowledge. Witness indistinguishability: the verifier cannot distinguish which of multiple valid witnesses the prover used. Witness hiding: the verifier cannot compute any witness after the interaction. Weaker than ZK but sufficient for many applications and compositionally robust.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Feige-Shamir WI/WH** | 1990 | Any NP | Formal definitions; WI ⊂ ZK; WI composes under parallel composition (ZK does not) [[1]](https://doi.org/10.1145/100216.100272) |
| **WI from Sigma Protocols** | 1994 | DLP | Run two Sigma protocols in parallel; WI without ZK [[1]](https://doi.org/10.1007/BFb0053443) |
| **Resettable WI (Deng-Goyal-Sahai)** | 2009 | One-way functions | WI secure even if verifier can reset prover to initial state [[1]](https://doi.org/10.1109/FOCS.2009.12) |

**State of the art:** WI is the default security notion for many sub-protocols in [MPC](#multi-party-computation-mpc) and credential systems. Composes better than ZK — see [ZK Proofs](#zero-knowledge-proofs-zk), [Sigma Protocols](#sigma-protocols--schnorr-identification).

---

## Non-Black-Box Zero-Knowledge / Concurrent ZK

**Goal:** ZK under concurrent composition. Standard black-box ZK is impossible when many proof sessions run simultaneously (verifier can interleave sessions to cheat). Barak's breakthrough: the simulator reads the verifier's code directly (non-black-box), enabling ZK even under concurrent execution.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Barak Non-Black-Box ZK** | 2001 | Universal arguments | First non-black-box simulator; concurrent ZK for NP in plain model [[1]](https://doi.org/10.1109/SFCS.2001.959902) |
| **Concurrent ZK (Canetti et al.)** | 2002 | Timing assumptions | Concurrent ZK under timing assumptions (bounded delay) [[1]](https://eprint.iacr.org/2001/055) |
| **Resettable ZK (Canetti et al.)** | 2000 | Non-black-box | ZK secure even if verifier can rewind/reset prover [[1]](https://doi.org/10.1145/335305.335311) |
| **Constant-Round Concurrent ZK (Goyal)** | 2013 | Non-black-box + commitments | O(1) rounds concurrent ZK; improved Barak's technique [[1]](https://eprint.iacr.org/2012/563) |

**State of the art:** Constant-round concurrent ZK (Goyal 2013); essential for real-world protocols with parallel sessions. Extends [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Rational Cryptography

**Goal:** Crypto protocols secure against rational (game-theoretic) adversaries — not just honest/malicious but self-interested agents who deviate only when it benefits them. Uses mechanism design: make cheating economically irrational. Bridges cryptography and game theory.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Halpern-Teague Rational Secret Sharing** | 2004 | Game theory + SS | First rational SS; players cooperate because deviating yields worse outcome [[1]](https://doi.org/10.1145/1007352.1007427) |
| **Abraham-Dolev-Gonen-Halpern** | 2006 | Rational MPC | Distributed computing with rational players; equilibrium-based security [[1]](https://doi.org/10.1007/11818175_1) |
| **Groce-Katz Rational Protocol Design** | 2012 | Mechanism design + MPC | Fair MPC via utility alignment; punishment strategies enforce cooperation [[1]](https://eprint.iacr.org/2012/029) |

**State of the art:** Rational protocol design (2012); active in blockchain mechanism design. Bridges [MPC](#multi-party-computation-mpc) and economic incentive theory.

---

## Human-Computable Cryptography

**Goal:** Authentication without devices. Cryptographic protocols that a human can execute mentally — no computer, no smartphone. A person memorizes a secret mapping and can authenticate by answering challenges in their head, even against an adversary who observed all prior sessions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum-Vempala Human Hash** | 2015 | Random mapping memorization | Human memorizes small mapping; computes f(challenge) mentally; usable but limited security [[1]](https://doi.org/10.4230/LIPIcs.ITCS.2017.10) |
| **Blocki-Blum-Datta-Vempala** | 2017 | Cognitive model | Formal model of human computation; proves security bounds against polynomial adversary [[1]](https://doi.org/10.4230/LIPIcs.ITCS.2017.10) |
| **CAPTCHA-Based Crypto (Canetti-Halevi-Steiner)** | 2013 | Human-solvable puzzles | CAPTCHA as cryptographic primitive; human interaction as security assumption [[1]](https://doi.org/10.1007/978-3-642-36362-7_30) |

**State of the art:** Blum-Vempala (ITCS 2017); limited practical deployment but theoretically novel — security from cognitive limitations.

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

## Lossy Encryption / Lossy Trapdoor Functions

**Goal:** Proof technique as primitive. A public key can operate in two computationally indistinguishable modes: *injective* (normal encryption, decryptable) and *lossy* (ciphertext is statistically independent of the message). Enables elegant CCA security proofs and new constructions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Peikert-Waters Lossy TDF** | 2008 | DDH / LWE | First lossy TDFs; injective and lossy modes; implies CCA-secure PKE [[1]](https://eprint.iacr.org/2007/279) |
| **Bellare-Hofheinz-Yilek Lossy Encryption** | 2009 | DDH / LWE | Lossy encryption formalization; key-dependent message security [[1]](https://eprint.iacr.org/2009/079) |
| **Lossy TDF from Lattices** | 2008 | LWE | Peikert-Waters LWE instantiation; post-quantum lossy TDF [[1]](https://eprint.iacr.org/2007/279) |
| **All-But-One TDF** | 2008 | DDH / LWE | Lossy on one branch, injective on all others; CCA from CHF [[1]](https://eprint.iacr.org/2007/279) |

**State of the art:** Lossy TDFs from LWE (PQ-secure); foundational for [KEM/DEM](#key-encapsulation-mechanism-kem--dem-paradigm) security proofs and [Dual-Mode Cryptosystems](#dual-mode-cryptosystems).

---
