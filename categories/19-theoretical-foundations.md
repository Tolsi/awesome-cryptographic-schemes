# Theoretical Foundations


<!-- TOC -->
## Contents (55 schemes)

- [Leakage-Resilient Cryptography](#leakage-resilient-cryptography)
- [Circular / KDM Security](#circular-kdm-security)
- [Non-Malleable Codes](#non-malleable-codes)
- [Witness Indistinguishability (WI) / Witness Hiding](#witness-indistinguishability-wi-witness-hiding)
- [Non-Black-Box Zero-Knowledge / Concurrent ZK](#non-black-box-zero-knowledge-concurrent-zk)
- [Rational Cryptography](#rational-cryptography)
- [Human-Computable Cryptography](#human-computable-cryptography)
- [Cryptographic Reverse Firewalls](#cryptographic-reverse-firewalls)
- [Lossy Encryption / Lossy Trapdoor Functions](#lossy-encryption-lossy-trapdoor-functions)
- [Random Oracle Model (ROM) vs. Standard Model](#random-oracle-model-rom-vs-standard-model)
- [Semantic Security and IND-CPA / IND-CCA Security](#semantic-security-and-ind-cpa-ind-cca-security)
- [Universal Composability (UC) Framework](#universal-composability-uc-framework)
- [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds)
- [Black-Box Separations](#black-box-separations)
- [Hardcore Predicates and the Goldreich-Levin Theorem](#hardcore-predicates-and-the-goldreich-levin-theorem)
- [Pseudoentropy and Computational Entropy](#pseudoentropy-and-computational-entropy)
- [NIZK: Definitions, Simulation Soundness, and Extractability](#nizk-definitions-simulation-soundness-and-extractability)
- [Knowledge-of-Exponent Assumption (KEA) and Falsifiability](#knowledge-of-exponent-assumption-kea-and-falsifiability)
- [Generic Group Model (GGM) and Algebraic Group Model (AGM)](#generic-group-model-ggm-and-algebraic-group-model-agm)
- [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness)
- [Perfect Forward Secrecy (PFS)](#perfect-forward-secrecy-pfs)
- [Leftover Hash Lemma and Randomness Extraction](#leftover-hash-lemma-and-randomness-extraction)
- [Hybrid Argument Technique](#hybrid-argument-technique)
- [Random Self-Reducibility](#random-self-reducibility)
- [Security Amplification](#security-amplification)
- [Simulation-Based Security (SIM) vs. Indistinguishability-Based Security (IND)](#simulation-based-security-sim-vs-indistinguishability-based-security-ind)
- [Adaptive vs. Static Corruptions in Multi-Party Protocols](#adaptive-vs-static-corruptions-in-multi-party-protocols)
- [Indifferentiability Framework](#indifferentiability-framework)
- [Symbolic Model (Dolev-Yao) vs. Computational Model](#symbolic-model-dolev-yao-vs-computational-model)
- [Automated Protocol Verification (ProVerif, Tamarin, EasyCrypt)](#automated-protocol-verification-proverif-tamarin-easycrypt)
- [Knowledge-Soundness, Extractability, and Simulation-Extractability](#knowledge-soundness-extractability-and-simulation-extractability)
- [Entropy Source Models](#entropy-source-models)
- [Bit Security and Its Definition](#bit-security-and-its-definition)
- [Composability Beyond UC: GNUC, SPS, and IITM](#composability-beyond-uc-gnuc-sps-and-iitm)
- [Abstract Cryptography (Constructive Cryptography)](#abstract-cryptography-constructive-cryptography)
- [Programmable vs. Non-Programmable Random Oracles](#programmable-vs-non-programmable-random-oracles)
- [Wegman-Carter-Shoup Authentication and Information-Theoretic MACs](#wegman-carter-shoup-authentication-and-information-theoretic-macs)
- [Related-Key Security](#related-key-security)
- [Multi-User and Multi-Instance Security](#multi-user-and-multi-instance-security)
- [Selective vs. Full Security in IBE and ABE](#selective-vs-full-security-in-ibe-and-abe)
- [Meta-Reduction Technique](#meta-reduction-technique)
- [Beyond-Birthday-Bound (BBB) Security](#beyond-birthday-bound-bbb-security)
- [ORAM Complexity and Lower Bounds](#oram-complexity-and-lower-bounds)
- [Worst-Case to Average-Case Reductions for Lattices](#worst-case-to-average-case-reductions-for-lattices)
- [Forking Lemma and Rewinding Techniques](#forking-lemma-and-rewinding-techniques)
- [Code-Based Game-Playing Proofs](#code-based-game-playing-proofs)
- [Quantum Random Oracle Model (QROM)](#quantum-random-oracle-model-qrom)
- [Fine-Grained Cryptography](#fine-grained-cryptography)
- [One-Way Functions and Kolmogorov Complexity](#one-way-functions-and-kolmogorov-complexity)
- [Pseudorandom Correlation Generators (PCGs)](#pseudorandom-correlation-generators-pcgs)
- [Gentry-Wichs Barrier (Non-Falsifiability of SNARGs)](#gentry-wichs-barrier-non-falsifiability-of-snargs)
- [Communication Complexity of Secure Computation](#communication-complexity-of-secure-computation)
- [Game-Based vs. Simulation-Based Security Paradigms](#game-based-vs-simulation-based-security-paradigms)
- [Algebraic Group Model (AGM)](#algebraic-group-model-agm)
- [Memory-Hard Functions (MHF) — Formal Theory](#memory-hard-functions-mhf-formal-theory)
<!-- /TOC -->

## Leakage-Resilient Cryptography

**Goal:** Side-channel resistance in theory. Schemes that remain secure even when an adversary obtains partial information about the secret key (via power analysis, timing, EM emanation, cold boot attacks).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dziembowski-Pietrzak (LR stream cipher)** | 2008 | PRG + alternating extraction | First leakage-resilient stream cipher [[1]](https://eprint.iacr.org/2008/135) |
| **Faust-Kiltz-Pietrzak-Rothblum** | 2010 | Any LR-PRG | Leakage-resilient signatures from any LR-secure PRG [[1]](https://eprint.iacr.org/2009/282) |
| **Prouff-Rivain (masking)** | 2013 | Boolean masking | Practical higher-order masking for AES; provable security [[1]](https://eprint.iacr.org/2013/468) |

**State of the art:** Prouff-Rivain masking (industry standard for smart cards), theoretical LR frameworks (complementary).

**Production readiness:** Mature
Prouff-Rivain masking is deployed in commercial smart cards (NXP, Infineon); theoretical LR frameworks inform design but are not standalone deployments.

**Implementations:**
- [jasmin-lang/jasmin](https://github.com/jasmin-lang/jasmin) ⭐ 337 — assembly-level verified implementations with masking support
- [Coron's higher-order masking](https://github.com/coron/htable) ⭐ 24 — C, reference implementation of higher-order Boolean masking

**Security status:** Secure
No known attacks at recommended masking orders (≥2); practical side-channel security depends on correct implementation and sufficient noise assumptions.

**Community acceptance:** Widely trusted
Masking is mandated by Common Criteria (ISO 15408) for smart card certifications; LR frameworks are standard in academic cryptography.

---

## Circular / KDM Security

**Goal:** Security when encrypting the key itself. An encryption scheme is KDM-secure (Key-Dependent Message) if it remains secure even when the plaintext is a function of the secret key. Critical for FHE bootstrapping and disk encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Halevi-Hamburg-Ostrovsky** | 2008 | DDH | First KDM-CPA secure encryption from standard assumptions [[1]](https://eprint.iacr.org/2008/140) |
| **Applebaum-Cash-Peikert-Sahai** | 2009 | LWE | KDM-secure for affine functions of the key [[1]](https://eprint.iacr.org/2009/070) |
| **Barak-Haitner-Hofheinz-Ishai** | 2010 | Any CPA enc (bounded) | KDM security for bounded polynomial cycles [[1]](https://eprint.iacr.org/2010/198) |

**State of the art:** LWE-based KDM (used in FHE bootstrapping security proofs), DDH-based (practical).

**Production readiness:** Research
KDM security is a proof-level property used in FHE security arguments; no standalone deployed KDM-secure encryption product exists.

**Implementations:**
- [Microsoft SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, FHE library whose bootstrapping security relies on KDM arguments
- [OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, FHE library with KDM-relevant security proofs

**Security status:** Secure
No known attacks on the underlying LWE/DDH-based KDM constructions at recommended parameters.

**Community acceptance:** Niche
KDM security is a specialized theoretical notion; well-studied in the academic community but not a standalone standardization target.

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

**Production readiness:** Research
Non-malleable codes are primarily a theoretical tool; no widely deployed standalone NMC product exists, though the concepts inform tamper-resilient hardware design.

**Implementations:**
- [libotr](https://github.com/off-the-record/libotr) ⭐ 64 — C, uses NMC-related techniques in tamper-resilient key storage

**Security status:** Secure
Information-theoretic security in the split-state model; computational variants secure under standard assumptions.

**Community acceptance:** Niche
Well-established in TCC/CRYPTO/EUROCRYPT theory community; limited awareness outside academic cryptography and hardware security.

---

## Witness Indistinguishability (WI) / Witness Hiding

**Goal:** Relaxed zero-knowledge. Witness indistinguishability: the verifier cannot distinguish which of multiple valid witnesses the prover used. Witness hiding: the verifier cannot compute any witness after the interaction. Weaker than ZK but sufficient for many applications and compositionally robust.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Feige-Shamir WI/WH** | 1990 | Any NP | Formal definitions; WI ⊂ ZK; WI composes under parallel composition (ZK does not) [[1]](https://doi.org/10.1145/100216.100272) |
| **WI from Sigma Protocols** | 1994 | DLP | Run two Sigma protocols in parallel; WI without ZK [[1]](https://doi.org/10.1007/BFb0053443) |
| **Resettable WI (Deng-Goyal-Sahai)** | 2009 | One-way functions | WI secure even if verifier can reset prover to initial state [[1]](https://doi.org/10.1109/FOCS.2009.12) |

**State of the art:** WI is the default security notion for many sub-protocols in [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and credential systems. Composes better than ZK — see [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk), [Sigma Protocols](04-zero-knowledge-proof-systems.md#sigma-protocols-schnorr-identification).

**Production readiness:** Mature
WI is used as a building block inside deployed protocols (e.g., parallel Sigma protocols in credential systems) rather than as a standalone primitive.

**Implementations:**
- [arkworks-rs/crypto-primitives](https://github.com/arkworks-rs/crypto-primitives) ⭐ 241 — Rust, includes Sigma protocol implementations usable in WI mode

**Security status:** Secure
WI is a well-founded security notion; no attacks on the paradigm itself. Security of instantiations depends on the underlying hard problem.

**Community acceptance:** Widely trusted
Standard security notion in cryptographic protocol design since Feige-Shamir (1990); used pervasively in academic literature and protocol specifications.

---

## Non-Black-Box Zero-Knowledge / Concurrent ZK

**Goal:** ZK under concurrent composition. Standard black-box ZK is impossible when many proof sessions run simultaneously (verifier can interleave sessions to cheat). Barak's breakthrough: the simulator reads the verifier's code directly (non-black-box), enabling ZK even under concurrent execution.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Barak Non-Black-Box ZK** | 2001 | Universal arguments | First non-black-box simulator; concurrent ZK for NP in plain model [[1]](https://doi.org/10.1109/SFCS.2001.959902) |
| **Concurrent ZK (Canetti et al.)** | 2002 | Timing assumptions | Concurrent ZK under timing assumptions (bounded delay) [[1]](https://eprint.iacr.org/2001/055) |
| **Resettable ZK (Canetti et al.)** | 2000 | Non-black-box | ZK secure even if verifier can rewind/reset prover [[1]](https://doi.org/10.1145/335305.335311) |
| **Constant-Round Concurrent ZK (Goyal)** | 2013 | Non-black-box + commitments | O(1) rounds concurrent ZK; improved Barak's technique [[1]](https://eprint.iacr.org/2012/563) |

**State of the art:** Constant-round concurrent ZK (Goyal 2013); essential for real-world protocols with parallel sessions. Extends [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Research
Concurrent ZK techniques are primarily theoretical; practical protocols avoid the problem via the Fiat-Shamir heuristic or UC-secure designs rather than deploying non-black-box simulators directly.

**Implementations:**
- No production implementations of non-black-box concurrent ZK exist; the techniques are used in security proofs rather than deployed code.

**Security status:** Secure
Theoretical constructions are proven secure; Barak's non-black-box technique is sound under standard assumptions.

**Community acceptance:** Niche
Foundational in complexity-theoretic cryptography; Barak's 2001 result is a landmark. Practical protocols sidestep the issue via different design choices.

---

## Rational Cryptography

**Goal:** Crypto protocols secure against rational (game-theoretic) adversaries — not just honest/malicious but self-interested agents who deviate only when it benefits them. Uses mechanism design: make cheating economically irrational. Bridges cryptography and game theory.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Halpern-Teague Rational Secret Sharing** | 2004 | Game theory + SS | First rational SS; players cooperate because deviating yields worse outcome [[1]](https://doi.org/10.1145/1007352.1007427) |
| **Abraham-Dolev-Gonen-Halpern** | 2006 | Rational MPC | Distributed computing with rational players; equilibrium-based security [[1]](https://doi.org/10.1007/11818175_1) |
| **Groce-Katz Rational Protocol Design** | 2012 | Mechanism design + MPC | Fair MPC via utility alignment; punishment strategies enforce cooperation [[1]](https://eprint.iacr.org/2012/029) |

**State of the art:** Rational protocol design (2012); active in blockchain mechanism design. Bridges [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and economic incentive theory.

**Production readiness:** Research
Rational cryptography concepts influence blockchain mechanism design (staking penalties, slashing) but no standalone rational crypto protocol is deployed as a product.

**Implementations:**
- No dedicated open-source libraries; concepts are embedded in blockchain protocol implementations such as [Ethereum consensus specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k (slashing/incentive logic).

**Security status:** Secure
Game-theoretic security guarantees hold under the assumed rationality model; security degrades if adversaries are irrational (willing to lose money to attack).

**Community acceptance:** Niche
Active research area at the intersection of cryptography and game theory; influential in blockchain economics but not a mainstream cryptographic standard.

---

## Human-Computable Cryptography

**Goal:** Authentication without devices. Cryptographic protocols that a human can execute mentally — no computer, no smartphone. A person memorizes a secret mapping and can authenticate by answering challenges in their head, even against an adversary who observed all prior sessions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum-Vempala Human Hash** | 2015 | Random mapping memorization | Human memorizes small mapping; computes f(challenge) mentally; usable but limited security [[1]](https://doi.org/10.4230/LIPIcs.ITCS.2017.10) |
| **Blocki-Blum-Datta-Vempala** | 2017 | Cognitive model | Formal model of human computation; proves security bounds against polynomial adversary [[1]](https://doi.org/10.4230/LIPIcs.ITCS.2017.10) |
| **CAPTCHA-Based Crypto (Canetti-Halevi-Steiner)** | 2013 | Human-solvable puzzles | CAPTCHA as cryptographic primitive; human interaction as security assumption [[1]](https://doi.org/10.1007/978-3-642-36362-7_30) |

**State of the art:** Blum-Vempala (ITCS 2017); limited practical deployment but theoretically novel — security from cognitive limitations.

**Production readiness:** Research
Purely theoretical; no practical authentication system deploys human-computable cryptography at scale.

**Implementations:**
- No production implementations; academic prototypes described in papers only.

**Security status:** Caution
Security bounds are weak compared to standard cryptography; schemes tolerate only a small number of observed sessions before the secret is recoverable.

**Community acceptance:** Niche
Intellectually interesting and published at top venues (ITCS); not considered viable for real-world deployment by the broader cryptographic community.

---

## Cryptographic Reverse Firewalls

**Goal:** Subversion resistance. A middlebox ("reverse firewall") re-randomizes a party's protocol messages so that even if the party's implementation is subverted (backdoored), no information leaks — without the firewall knowing any secrets. The motivating threat is algorithm substitution attacks (ASA): a compromised implementation uses subliminal channels in its random-looking outputs (nonces, ciphertexts) to leak secret keys to a passive eavesdropper. The NSA's Dual_EC_DRBG backdoor is the canonical example.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mironov-Stephens-Davidowitz CRF** | 2015 | Rerandomization | Formal model; CRFs for key exchange, signatures, ZK proofs [[1]](https://eprint.iacr.org/2014/758) |
| **CRF for Key Exchange (Dodis et al.)** | 2016 | Rerandomizable DH | Reverse firewall for Diffie-Hellman: firewall re-randomizes DH messages so that even a kleptographic implementation cannot exfiltrate the secret key [[1]](https://eprint.iacr.org/2016/424) |
| **CRF for Signatures (Ateniese et al.)** | 2016 | Rerandomizable Schnorr | Reverse firewall re-randomizes Schnorr signature nonces; prevents nonce-covert-channel attacks [[1]](https://eprint.iacr.org/2015/1189) |
| **CRF for OT (Chakraborty et al.)** | 2020 | UC framework | Reverse firewalls for oblivious transfer protocols [[1]](https://eprint.iacr.org/2020/156) |
| **CRF for MPC** | 2020 | Rerandomizable garbled circuits | Extends CRFs to general MPC protocols; firewall rerandomizes garbled circuit messages without knowing the circuit inputs [[1]](https://eprint.iacr.org/2020/594) |
| **CRF for 2PC (Chen-Haeberlen-Hicks-Tzialla)** | 2022 | Garbled circuits | Subversion-resistant two-party computation [[1]](https://eprint.iacr.org/2022/849) |

**State of the art:** Theoretical framework (Mironov-Stephens-Davidowitz 2015); practical constructions exist for DH, Schnorr, ElGamal, and OT. Active research area post-Snowden. Closely related to [Kleptography / ASA](18-covert-channels-steganography.md#kleptography-algorithm-substitution-attacks-asa).

**Production readiness:** Research
Theoretical framework with academic prototypes; no production deployment of a standalone cryptographic reverse firewall exists.

**Implementations:**
- No production-quality open-source implementations; proof-of-concept code accompanies individual papers.

**Security status:** Secure
Provably eliminates subliminal channels under stated algebraic rerandomizability assumptions; limited to protocols designed with rerandomizability in mind.

**Community acceptance:** Niche
Well-regarded in the post-Snowden subversion-resistance research community; published at EUROCRYPT/CRYPTO. Limited practical adoption due to performance and protocol compatibility constraints.

---

## Lossy Encryption / Lossy Trapdoor Functions

**Goal:** Proof technique as primitive. A public key can operate in two computationally indistinguishable modes: *injective* (normal encryption, decryptable) and *lossy* (ciphertext is statistically independent of the message). Enables elegant CCA security proofs and new constructions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Peikert-Waters Lossy TDF** | 2008 | DDH / LWE | First lossy TDFs; injective and lossy modes; implies CCA-secure PKE [[1]](https://eprint.iacr.org/2007/279) |
| **Bellare-Hofheinz-Yilek Lossy Encryption** | 2009 | DDH / LWE | Lossy encryption formalization; key-dependent message security [[1]](https://eprint.iacr.org/2009/079) |
| **Lossy TDF from Lattices** | 2008 | LWE | Peikert-Waters LWE instantiation; post-quantum lossy TDF [[1]](https://eprint.iacr.org/2007/279) |
| **All-But-One TDF** | 2008 | DDH / LWE | Lossy on one branch, injective on all others; CCA from CHF [[1]](https://eprint.iacr.org/2007/279) |

**State of the art:** Lossy TDFs from LWE (PQ-secure); foundational for [KEM/DEM](#game-based-vs-simulation-based-security-paradigms) security proofs and [Dual-Mode Cryptosystems](16-obfuscation-advanced-hardness.md#dual-mode-cryptosystems).

**Production readiness:** Research
Lossy TDFs are a proof technique and theoretical primitive; they are not deployed as standalone products but underlie security proofs of deployed schemes.

**Implementations:**
- [lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k — Go, lattice-based crypto library whose security arguments use lossy-mode techniques
- [OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, FHE library with LWE-based constructions whose proofs leverage lossy TDFs

**Security status:** Secure
Secure under DDH or LWE assumptions; the lossy/injective mode indistinguishability is the core security property.

**Community acceptance:** Widely trusted
Peikert-Waters lossy TDFs are a standard tool in provable security; cited in hundreds of papers and used in security proofs of NIST PQC candidates.

---

## Random Oracle Model (ROM) vs. Standard Model

**Goal:** Formalize when hash functions can be treated as ideal. The random oracle model (ROM), introduced by Bellare and Rogaway (1993), replaces cryptographic hash functions with a perfectly random function accessible only as an oracle. Proofs in the ROM are often simpler and tighter; the standard model avoids this idealization but demands stronger hardness assumptions or more complex constructions. A central open question is whether ROM security implies real-world security after instantiating the oracle with a concrete hash.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **ROM introduction** | 1993 | Bellare–Rogaway | Formalized the ROM paradigm; used to prove RSA-OAEP and FDH secure; advocates ROM as a practical design heuristic [[1]](https://cseweb.ucsd.edu/~mihir/papers/ro.pdf) |
| **ROM separation (CGH)** | 1998 | Canetti–Goldreich–Halevi | Constructed schemes secure in ROM but insecure under any hash instantiation; ROM proofs do not imply standard-model security [[1]](https://eprint.iacr.org/1998/011) |
| **Standard-model NIZK** | 2008 | Groth–Sahai | Pairing-based NIZK without any random oracle; canonical standard-model alternative [[1]](https://eprint.iacr.org/2007/155) |
| **Ideal cipher ≡ ROM** | 2008 | Holenstein–Künzler–Tessaro | Proved the ideal cipher model and the random oracle model are equivalent [[1]](https://eprint.iacr.org/2008/246) |
| **Instantiation impossibility for PSS** | 2011 | Dodis–Oliveira–Pietrzak | Black-box impossibility of instantiating PSS in the standard model even assuming ideal trapdoor permutations [[1]](https://link.springer.com/chapter/10.1007/978-3-642-19379-8_22) |

**State of the art:** The ROM remains the dominant proof model for deployed protocols (TLS, OAEP, Fiat-Shamir heuristic). Standard-model alternatives exist but are less efficient. The CGH separation is the canonical impossibility reference; programmability of the random oracle is an active area of research.

**Production readiness:** Production
The ROM is the dominant proof model for virtually all deployed cryptographic protocols (TLS 1.3, RSA-OAEP, Schnorr signatures, Fiat-Shamir transforms).

**Implementations:**
- Every cryptographic library implicitly relies on ROM proofs; the model itself is a proof framework, not a software artifact.
- [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/) — OCaml, automated game-based proof tool supporting ROM arguments
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, formal verification framework with ROM proof support

**Security status:** Caution
ROM proofs do not unconditionally imply real-world security (CGH 1998 separation); however, no deployed ROM-proven scheme has been broken due to oracle instantiation failure.

**Community acceptance:** Standard
The ROM is universally accepted in applied cryptography and NIST/IETF standardization; the CGH separation is acknowledged but considered a theoretical concern.

---

## Semantic Security and IND-CPA / IND-CCA Security

**Goal:** Formally define what it means for an encryption scheme to be "secure." Goldwasser and Micali (1984) introduced semantic security — no partial information about the plaintext leaks to a polynomial-time adversary — and proved it equivalent to indistinguishability under chosen-plaintext attack (IND-CPA). Naor and Yung (1990) then defined IND-CCA1, and Rackoff and Simon (1991) defined IND-CCA2 — the adaptive chosen-ciphertext attack notion that is the accepted gold standard today.

| Notion | Year | Authors | Note |
|--------|------|---------|------|
| **Semantic security / IND-CPA** | 1984 | Goldwasser–Micali | Probabilistic encryption; semantic security ≡ IND-CPA; instantiated from quadratic residuosity [[1]](https://mit6875.github.io/PAPERS/probabilistic_encryption.pdf) |
| **IND-CCA1 (non-adaptive CCA)** | 1990 | Naor–Yung | Dual-encryption + simulation yields CCA1-secure PKE; introduced the "lunchtime attack" model [[1]](https://doi.org/10.1145/100216.100221) |
| **IND-CCA2 (adaptive CCA)** | 1991 | Rackoff–Simon | Adversary may query decryption oracle after seeing the challenge ciphertext; defines the accepted PKE security target [[1]](https://doi.org/10.1007/3-540-46766-1_34) |
| **Hierarchy of PKE notions** | 1998 | Bellare–Desai–Jokipii–Rogaway | Formal taxonomy: OW-CPA ⊂ IND-CPA ⊂ IND-CCA1 ⊂ IND-CCA2; exhaustive separation examples [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/relations.pdf) |
| **Cramer-Shoup (standard-model CCA2)** | 1998 | Cramer–Shoup | First practical IND-CCA2-secure PKE in the standard model under DDH, no random oracle needed [[1]](https://eprint.iacr.org/1998/008) |

**State of the art:** IND-CCA2 is mandatory for any deployed PKE or KEM. All current standards — ML-KEM, RSA-OAEP, ECIES — target IND-CCA2. These notions underpin every encryption section in this repository.

**Production readiness:** Production
IND-CPA/IND-CCA2 are the mandatory security targets for all deployed encryption standards (TLS, ML-KEM, RSA-OAEP, ECIES).

**Implementations:**
- These are definitional frameworks, not implementations. Every compliant encryption library targets these notions.

**Security status:** Secure
The definitional hierarchy (OW-CPA through IND-CCA2) is well-established and universally accepted.

**Community acceptance:** Standard
IND-CCA2 is mandated by NIST, IETF, and ISO for all public-key encryption and KEM standards. The Bellare-Rogaway taxonomy is taught in every graduate cryptography course.

---

## Universal Composability (UC) Framework

**Goal:** Guarantee protocol security under arbitrary concurrent composition. The UC framework (Canetti 2001/2020) defines security by requiring that a real protocol is computationally indistinguishable from an *ideal functionality* — a trusted party that computes the desired function perfectly — even when the protocol runs concurrently alongside arbitrarily many other protocols. Unlike standalone game-based definitions, UC security composes freely and is the appropriate model for multi-session, internet-scale deployments.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **UC framework** | 2001 | Canetti | Foundational definition; universal composition theorem; ideal functionalities for OT, commitment, CRS [[1]](https://eprint.iacr.org/2000/067) |
| **UC commitments impossibility** | 2001 | Canetti–Fischlin | UC-secure commitments are impossible in the plain model; require a setup assumption (CRS or global ROM) [[1]](https://eprint.iacr.org/2001/055) |
| **Simplified UC (CC-UC)** | 2015 | Canetti–Cohen–Lindell | Cleaner formalization for standard MPC settings; easier to use for protocol designers [[1]](https://eprint.iacr.org/2014/553) |
| **UC journal version** | 2020 | Canetti | Definitive JACM version; consolidates all prior revisions; introduces global subroutines and global functionalities [[1]](https://dl.acm.org/doi/10.1145/3402457) |
| **EasyUC** | 2019 | Canetti–Stoughton–Varia | Machine-checked UC proofs using the EasyCrypt proof assistant [[1]](https://eprint.iacr.org/2019/582) |

**State of the art:** UC is the canonical composition framework for [MPC](06-multi-party-computation.md#multi-party-computation-mpc), [CGKA/MLS](12-secure-communication-protocols.md#continuous-group-key-agreement-cgka-mls), and [OT](06-multi-party-computation.md#oblivious-transfer-ot). Simulation-based security is the language of the UC model; game-based definitions (IND-CPA, etc.) remain preferred for standalone primitives.

**Production readiness:** Mature
UC is the standard security framework for MPC, MLS, and threshold protocols; all serious protocol designs invoke UC security. EasyUC provides machine-checked proofs.

**Implementations:**
- [EasyUC](https://github.com/easyuc/EasyUC) ⭐ 45 — OCaml/EasyCrypt, machine-checked UC proofs
- [GNUC](https://eprint.iacr.org/2011/471) — formal model (no standalone software; used in paper proofs)
- UC is a proof framework; every UC-secure MPC library (MP-SPDZ, libsignal, openmls) implicitly relies on it.

**Security status:** Secure
The UC framework itself is a definitional tool; its soundness is well-established. UC-secure protocols are secure under arbitrary composition by definition.

**Community acceptance:** Standard
UC is the gold standard for composable protocol security; required by IETF MLS, used in all major MPC frameworks, and referenced in NIST PQC evaluations.

---

## One-Way Functions and Impagliazzo's Five Worlds

**Goal:** Map the landscape of what cryptography is possible. One-way functions (OWFs) — functions easy to compute but hard to invert on a random input — are the minimal assumption underlying all of private-key cryptography. Whether OWFs exist is equivalent to asking whether P ≠ NP in the average-case sense. Impagliazzo (1995) organized five possible worlds according to which hardness assumptions hold, clarifying precisely which cryptographic primitives are achievable in each.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **OWF → PRG (HILL theorem)** | 1993 | Håstad–Impagliazzo–Levin–Luby | Any OWF implies a pseudorandom generator; stretched via Goldreich-Levin hard-core bits; foundational [[1]](https://doi.org/10.1137/S0097539793244708) |
| **OWF → PRF (GGM)** | 1986 | Goldreich–Goldwasser–Micali | PRFs from any PRG (hence any OWF) via the GGM tree construction [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **Impagliazzo's five worlds** | 1995 | Impagliazzo | Algorithmica / Heuristica / Pessiland / Minicrypt / Cryptomania; taxonomizes cryptographic possibility based on worst-case vs. average-case hardness and OWF/PKE existence [[1]](https://doi.org/10.1109/CCC.1995.514587) |
| **OWF ↛ key agreement (oracle)** | 1989 | Impagliazzo–Rudich | Relativizing separation: OWFs alone do not imply key exchange via black-box reductions; Minicrypt ≠ Cryptomania [[1]](https://doi.org/10.1145/73007.73012) |
| **OWF existence ↔ bounded KT complexity** | 2023 | Liu–Pass | OWFs exist if and only if there are problems with bounded Kolmogorov-time complexity; links OWF existence to meta-complexity [[1]](https://eprint.iacr.org/2020/1333) |

**State of the art:** We almost certainly live in Cryptomania, but no proof exists. The HILL theorem (OWF → PRG) is the deepest structural result in symmetric cryptography. Liu-Pass (2023) gives the sharpest known characterization of when OWFs exist.

**Production readiness:** Production
OWFs are the minimal assumption underlying all deployed symmetric cryptography (AES, SHA-2, HMAC). The HILL/GGM chain (OWF → PRG → PRF) is the theoretical backbone of every deployed symmetric primitive.

**Implementations:**
- Every symmetric cryptographic library (OpenSSL, libsodium, etc.) implicitly instantiates OWF-based constructions.
- The theoretical results are frameworks, not standalone software.

**Security status:** Secure
The existence of OWFs is a universally held assumption; no polynomial-time inversion algorithm is known for any candidate OWF.

**Community acceptance:** Standard
Impagliazzo's five worlds and the HILL theorem are cornerstones of cryptographic theory, taught in every graduate course and assumed in every security proof.

---

## Black-Box Separations

**Goal:** Prove that certain cryptographic primitives cannot be constructed from weaker ones via black-box reductions. A black-box separation shows — typically via a relativizing oracle argument — that no efficient algorithm can build primitive B from primitive A using only A's input/output interface, regardless of which specific A is chosen. These results delineate the "cryptographic primitive hierarchy" and prevent futile proof attempts.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **OWF ↛ key agreement** | 1989 | Impagliazzo–Rudich | Oracle world where OWFs exist but no key exchange protocol is secure; foundational separation result [[1]](https://doi.org/10.1145/73007.73012) |
| **OWP ↛ collision-resistant hash** | 1998 | Simon | One-way permutations do not black-box imply collision-resistant hash functions [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_23) |
| **RTV framework** | 2004 | Reingold–Trevisan–Vadhan | Unified framework classifying black-box reductions: fully / semi / non-black-box; systematic catalogue of separations [[1]](https://eprint.iacr.org/2004/049) |
| **Non-black-box techniques** | 2001 | Barak | Non-black-box simulation circumvents some separations for ZK; demonstrates limits of oracle-based lower bounds (see [Non-Black-Box ZK](#non-black-box-zero-knowledge-concurrent-zk)) [[1]](https://doi.org/10.1109/SFCS.2001.959902) |
| **BB-uselessness composability** | 2021 | Couteau–Hartmann | Black-box uselessness composes: two BB-useless primitives cannot be combined to yield a useful one [[1]](https://eprint.iacr.org/2021/016) |

**State of the art:** The Impagliazzo-Rudich oracle argument and the RTV taxonomy (2004) remain the standard tools. Non-black-box constructions (Barak, Bitansky-Paneth) partially circumvent these barriers for specific tasks (ZK, SNARGs) but not for key exchange or OT. Active area: non-black-box separations for PKE from OWF.

**Production readiness:** Research
Black-box separations are impossibility results; they guide protocol design but are not deployed as software.

**Implementations:**
- No software implementations; these are proof techniques and oracle-based impossibility arguments.

**Security status:** Secure
The separation results themselves are mathematically proven; they constrain what constructions are possible via black-box reductions.

**Community acceptance:** Standard
The Impagliazzo-Rudich separation and RTV taxonomy are standard references in theoretical cryptography; cited in virtually all papers on cryptographic reductions.

---

## Hardcore Predicates and the Goldreich-Levin Theorem

**Goal:** Extract hard-to-predict bits from one-way functions. A hardcore predicate of a function f is a single bit b(x) that is computationally unpredictable given f(x), even though f itself is easy to compute. Goldreich and Levin (1989) proved that the inner product ⟨x, r⟩ mod 2 is a universal hardcore predicate for any one-way function — padded with a random string r, it is hard to predict given (f(x), r). This result is the key step in constructing pseudorandom generators from arbitrary OWFs.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Goldreich-Levin hardcore predicate** | 1989 | Goldreich–Levin | Inner product ⟨x,r⟩ is a hardcore bit for any OWF f padded as g(x,r)=(f(x),r); enables PRG from any OWF [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **OWF → PRG via GL** | 1993 | Håstad–Impagliazzo–Levin–Luby | Full HILL theorem: PRG from any OWF by iterating Goldreich-Levin bit extraction; polynomial stretch [[1]](https://doi.org/10.1137/S0097539793244708) |
| **List-decoding interpretation** | 1999 | Goldreich–Levin (Bellare exposition) | GL theorem recast as list-decoding of Hadamard codes; simplifies proof and generalises to other error-correcting codes [[1]](https://cseweb.ucsd.edu/~mihir/papers/gl.pdf) |
| **Quantum GL** | 2001 | Adcock–Cleve | Quantum analogue of the GL theorem; hardcore bits remain hard against quantum adversaries with oracle access [[1]](https://link.springer.com/chapter/10.1007/3-540-45841-7_26) |

**State of the art:** The Goldreich-Levin theorem is a cornerstone of theoretical cryptography — every treatment of OWF-to-PRG builds on it. The HILL theorem (Håstad–Impagliazzo–Levin–Luby 1993) extends it to full PRG construction. See [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds) and [Pseudoentropy and Computational Entropy](#pseudoentropy-and-computational-entropy).

**Production readiness:** Research
The GL theorem is a proof technique; it is not implemented as standalone software but underlies the security arguments of all OWF-based constructions.

**Implementations:**
- No standalone implementations; the theorem is a reduction technique used in security proofs.
- Textbook implementations exist in teaching materials (e.g., [Katz-Lindell companion code](https://github.com/joyofcryptography/joy-of-cryptography)).

**Security status:** Secure
The Goldreich-Levin theorem is unconditionally proven; the hardcore predicate is computationally hard to predict given any OWF.

**Community acceptance:** Standard
One of the most fundamental results in cryptographic theory; cited in thousands of papers and taught in every introductory cryptography course.

---

## Pseudoentropy and Computational Entropy

**Goal:** Formalise what it means for a distribution to "look like" it has more randomness than it really does. A distribution X has pseudoentropy at least k if it is computationally indistinguishable from some distribution Y with Shannon entropy ≥ k. This generalises pseudorandomness (a special case where k = |X|) and is the key bridge between one-way functions and pseudorandom generators via the HILL theorem. Yao's next-bit predictor characterisation (1982) gives an equivalent operational definition: a distribution is pseudorandom if and only if no efficient algorithm can predict the next bit better than chance given all previous bits.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Next-bit predictor / Yao's theorem** | 1982 | Yao | A distribution is pseudorandom iff no efficient next-bit predictor has non-negligible advantage; equivalence between statistical tests and next-bit tests [[1]](https://doi.org/10.1109/SFCS.1982.45) |
| **HILL pseudoentropy** | 1993/1999 | Håstad–Impagliazzo–Levin–Luby | Computational entropy definition: X has HILL pseudoentropy k if indistinguishable from a distribution of Shannon entropy k; used to prove OWF → PRG [[1]](https://doi.org/10.1137/S0097539793244708) |
| **Metric pseudoentropy** | 2003 | Barak–Shaltiel–Wigderson | Computational analogues of entropy; metric entropy is weaker than HILL and easier to work with in hybrid arguments [[1]](https://www.boazbarak.org/Papers/compent.pdf) |
| **Conditional computational entropy** | 2007 | Reyzin | Separates HILL pseudoentropy from compressibility; conditional variants needed for leakage-resilience and extraction [[1]](https://link.springer.com/chapter/10.1007/978-3-540-72540-4_10) |

**State of the art:** HILL pseudoentropy remains the standard definition; the metric entropy variant is used in leakage-resilient cryptography and randomness extraction. See [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds) and [Hardcore Predicates and the Goldreich-Levin Theorem](#hardcore-predicates-and-the-goldreich-levin-theorem).

**Production readiness:** Research
Pseudoentropy is a theoretical framework for security proofs; it is not deployed as standalone software.

**Implementations:**
- No standalone implementations; the concepts are proof tools used in security reductions.

**Security status:** Secure
HILL and metric pseudoentropy are well-defined mathematical concepts; their correctness is proven.

**Community acceptance:** Widely trusted
HILL pseudoentropy is the standard computational entropy notion; Yao's next-bit predictor theorem is universally accepted. Both are standard textbook material.

---

## NIZK: Definitions, Simulation Soundness, and Extractability

**Goal:** Formalise non-interactive zero-knowledge proofs and their security variants. A NIZK proof system in the common reference string (CRS) model allows a prover to convince a verifier of an NP statement without interaction and without revealing any witness, using a shared CRS. Beyond basic zero-knowledge and soundness, the literature has developed stronger variants: *simulation soundness* (an adversary cannot prove false statements even after seeing simulated proofs) and *extractability* (a knowledge extractor can recover the witness from any valid proof given trapdoor information about the CRS). These properties are essential for CCA-secure encryption, signature schemes, and UC-secure protocols.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **NIZK in the CRS model** | 1990/1999 | Feige–Lapidot–Shamir | First NIZK for all NP from any trapdoor permutation; adaptive soundness and ZK with shared random string [[1]](https://doi.org/10.1137/S0097539798334998) |
| **Non-malleable / simulation-sound NIZK** | 1999 | Sahai | Non-malleable NIZK: adversary cannot derive related proofs; introduced simulation soundness — prover cannot prove false statements after seeing simulated proofs [[1]](https://doi.org/10.1109/SFFCS.1999.814584) |
| **Unbounded simulation soundness** | 2006 | Groth–Ostrovsky–Sahai | First pairing-based NIZK achieving unbounded simulation soundness (after polynomially many simulated proofs); used to construct CCA2-secure PKE in the standard model [[1]](https://eprint.iacr.org/2006/107) |
| **Groth-Sahai NIZK** | 2008 | Groth–Sahai | Efficient pairing-based NIZK for algebraic statements; witness-indistinguishable and simulation-sound; canonical standard-model NIZK [[1]](https://eprint.iacr.org/2007/155) |
| **NIZK of knowledge / extractability** | 2012 | Groth | Extractable NIZK: knowledge extractor recovers witness from any valid proof; foundational for SNARKs and UC-secure protocols [[1]](https://dl.acm.org/doi/10.1145/2220357.2220358) |

**State of the art:** Groth-Sahai proofs (2008) are the canonical standard-model NIZK for pairing-based languages. Simulation soundness and extractability are required by virtually every UC-secure construction. See [Universal Composability](#universal-composability-uc-framework), [Random Oracle Model](#random-oracle-model-rom-vs-standard-model), and [Knowledge-of-Exponent Assumption](#knowledge-of-exponent-assumption-kea-and-falsifiability).

**Production readiness:** Mature
Groth-Sahai proofs are implemented in research-grade libraries; simulation-sound NIZK is a building block in deployed SNARK systems.

**Implementations:**
- [arkworks-rs/groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 — Rust, production-quality Groth16 (which achieves simulation-extractability)
- [zkcrypto/bellman](https://github.com/zkcrypto/bellman) ⭐ 1.1k — Rust, Zcash's Groth16 implementation with extractability
- [Groth-Sahai reference](https://github.com/gijsvl/groth-sahai) ⭐ 13 — Python, academic reference for Groth-Sahai pairing-based NIZK

**Security status:** Secure
Groth-Sahai proofs are proven secure under DLIN/SXDH assumptions; simulation-extractable SNARKs secure under q-PKE/AGM.

**Community acceptance:** Widely trusted
Groth-Sahai is the standard reference for standard-model pairing-based NIZK; simulation-extractability is the accepted security target for SNARK-based protocols.

---

## Knowledge-of-Exponent Assumption (KEA) and Falsifiability

**Goal:** Enable extraction of witnesses from adversarial group elements. The Knowledge-of-Exponent Assumption (KEA), introduced by Damgård (1991), asserts that if an adversary outputs a pair (C, Y) with Y = C^a given (g, g^a), it must "know" an exponent c such that C = g^c — formalised by requiring an efficient extractor that outputs c. KEA and its generalisations (KEA2, KEA3, Power KEA) underlie many SNARK constructions. However, KEA is *non-falsifiable*: no polynomial-time algorithm can verify that the extractor fails, distinguishing it from standard computational assumptions. This tension between proof power and falsifiability is a central theme in foundations.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **KEA1 (original)** | 1991 | Damgård | Given (g, g^a), any adversary outputting (C, Y=C^a) must know c s.t. C=g^c; introduced to build CCA-secure PKE [[1]](https://link.springer.com/chapter/10.1007/3-540-46877-3_8) |
| **KEA and 3-round ZK** | 2004 | Bellare–Palacio | Formalised KEA1/KEA2/KEA3 hierarchy; linked KEA to 3-round ZK arguments and to extractable commitments [[1]](https://eprint.iacr.org/2004/008) |
| **Non-falsifiability of KEA** | 2011 | Naor | Classified KEA as non-falsifiable ("knowledge assumption"); distinguished from falsifiable assumptions (DDH, CDH); meta-theorem on which assumptions are "testable" [[1]](https://link.springer.com/chapter/10.1007/978-3-642-22792-9_16) |
| **KEA inherent to SNARKs** | 2012 | Gentry–Wichs | Non-falsifiable assumptions are *necessary* for succinct non-interactive arguments (SNARGs) in the standard model; KEA-type assumptions cannot be avoided [[1]](https://eprint.iacr.org/2011/095) |
| **Power KEA / q-PKE** | 2013 | Groth | q-Power Knowledge of Exponent used in Groth16 SNARK; adversary knowing (g, g^α, …, g^{α^q}) must extract a polynomial representation [[1]](https://eprint.iacr.org/2016/260) |

**State of the art:** KEA and its variants are the standard assumptions behind Groth16 and other pairing-based SNARKs deployed in blockchains (Zcash, Ethereum). Their non-falsifiability remains a theoretical concern; the Algebraic Group Model (see [Generic Group Model and Algebraic Group Model](#generic-group-model-ggm-and-algebraic-group-model-agm)) provides a partial substitute with better-understood security properties.

**Production readiness:** Production
KEA assumptions underlie Groth16, which is deployed in Zcash, Tornado Cash, and numerous Ethereum L2 systems.

**Implementations:**
- KEA is an assumption, not a software artifact. Implementations of Groth16 rely on KEA:
- [zkcrypto/bellman](https://github.com/zkcrypto/bellman) ⭐ 1.1k — Rust, Zcash's Groth16 (security depends on q-PKE/KEA)
- [arkworks-rs/groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 — Rust, general-purpose Groth16

**Security status:** Caution
KEA is non-falsifiable (Naor 2011; Gentry-Wichs 2011 shows this is inherent for SNARGs). No known attacks, but the assumption cannot be tested or refuted efficiently.

**Community acceptance:** Controversial
Widely used in practice (Zcash, Ethereum) but theoretically controversial due to non-falsifiability. The AGM provides a partial alternative with better-understood properties.

---

## Generic Group Model (GGM) and Algebraic Group Model (AGM)

**Goal:** Prove security of discrete-log-based schemes by restricting how adversaries interact with group elements. In the Generic Group Model (Shoup 1997), the adversary receives only opaque handles to group elements and can only combine them via the group operation — it cannot exploit the bit-representation of elements. This allows information-theoretic lower bounds (e.g., Ω(p^{1/2}) queries to solve DLog in a group of prime order p). The Algebraic Group Model (Fuchsbauer-Kiltz-Loss 2018) is a weaker idealization: the adversary may use the group encoding, but must always output explicit linear combinations of its input group elements alongside each output, enabling tight reductions from DLog-style assumptions while avoiding the GGM's full idealization.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Generic Group Model (GGM)** | 1997 | Shoup | Lower bound Ω(p^{1/2}) for DLog/CDH in a generic group of order p; formalised the "generic algorithm" as one that only uses the group operation oracle [[1]](https://www.shoup.net/papers/dlbounds1.pdf) |
| **Baby-step giant-step as GGM optimal** | 1997 | Shoup | Pohlig-Hellman and BSGS meet the GGM lower bound; DLog is provably hard in the GGM [[1]](https://www.shoup.net/papers/dlbounds1.pdf) |
| **Algebraic Group Model (AGM)** | 2018 | Fuchsbauer–Kiltz–Loss | AGM sits between GGM and standard model; adversary must supply linear representation of output elements; CDH, SDH, LRSW all reduce tightly to DLog in AGM; tight reductions for BLS and Groth16 [[1]](https://eprint.iacr.org/2017/620) |
| **AGM analysis and limitations** | 2022 | Auerbach–Hoffmann–Pascual-Perez | Formal analysis of AGM's assumptions; identifies classes of schemes where AGM proofs do and do not transfer to standard model [[1]](https://link.springer.com/chapter/10.1007/978-3-031-22972-5_11) |
| **AGM proofs transfer to GGM** | 2024 | Bauer–Fischlin–Konrath | Generic and algebraic computation models: conditions under which AGM security proofs imply GGM security [[1]](https://link.springer.com/chapter/10.1007/978-3-031-68388-6_2) |

**State of the art:** The GGM lower bounds (Shoup 1997) are the canonical justification for DLog-based security parameters. The AGM (Fuchsbauer-Kiltz-Loss 2018) is now widely used for tight security proofs of pairing-based schemes; it underlies proofs of Groth16, BLS, and numerous other constructions. See [Knowledge-of-Exponent Assumption](#knowledge-of-exponent-assumption-kea-and-falsifiability) and [Black-Box Separations](#black-box-separations).

**Production readiness:** Production
GGM lower bounds justify DLog parameter sizes used in all deployed elliptic curve cryptography. AGM proofs validate BLS signatures (Ethereum 2.0) and Groth16 (Zcash).

**Implementations:**
- GGM/AGM are proof models, not software. Libraries whose security relies on GGM/AGM analysis:
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/assembly, BLS12-381 (AGM-proven tight security)
- [arkworks-rs](https://github.com/arkworks-rs) — Rust, pairing-based crypto with AGM-validated parameters

**Security status:** Secure
GGM lower bounds are information-theoretic (proven). AGM is an intermediate model between standard model and GGM; its assumptions are stronger than standard model but weaker than GGM.

**Community acceptance:** Widely trusted
GGM (Shoup 1997) is universally cited for DLog parameter justification. AGM (2018) is rapidly becoming the standard for pairing-based security proofs.

---

## Concrete Security and Reduction Tightness

**Goal:** Quantify exactly how much security a construction provides at a specific parameter size. Asymptotic security theory says a scheme is "secure" if no polynomial-time adversary wins with non-negligible probability — but this hides constants and polynomial factors critical to practice. Concrete security (Bellare-Rogaway 1993/1997) replaces asymptotic language with explicit bounds: a scheme is (t, ε)-secure if no adversary running in time t wins with probability greater than ε. A reduction is *tight* if an adversary breaking the scheme yields another adversary breaking the underlying hardness problem with essentially the same (t, ε); a loose reduction with loss factor L means parameters must be inflated to compensate, sometimes by hundreds of bits.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Concrete security framework** | 1993 | Bellare–Rogaway | Introduced (t,ε)-security for protocol analysis; argued that asymptotic security theory obscures practical parameter choices [[1]](https://cseweb.ucsd.edu/~mihir/papers/ro.pdf) |
| **Exact security of digital signatures** | 1996 | Bellare–Rogaway | Tight security proof for Full Domain Hash (FDH) signatures in ROM; showed Schnorr/RSA-FDH have different tightness profiles [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/exact.pdf) |
| **Concrete security of symmetric enc** | 1997 | Bellare–Desai–Jokipii–Rogaway | Tight concrete-security hierarchy for IND-CPA, IND-CCA1, IND-CCA2 for symmetric encryption; upper and lower bounds on reduction loss [[1]](https://cseweb.ucsd.edu/~mihir/papers/sym-enc.pdf) |
| **Impossibility of tight reductions** | 2015 | Bader–Jager–Li–Schäge | For certain signature schemes with tight security, proved tight black-box reductions from standard assumptions are impossible; separation between tight and loose security [[1]](https://eprint.iacr.org/2015/374) |
| **Almost-tight security** | 2014 | Chen–Wee | "Almost-tight" reductions (loss at most linear in security parameter) for IBE and PKE; achieves near-optimal concrete security in the standard model [[1]](https://eprint.iacr.org/2013/134) |

**State of the art:** Concrete security analysis is mandatory for standards work — NIST PQC submissions were evaluated in part on tightness of their security reductions. Almost-tight reductions are the practical goal when perfectly tight ones are impossible. See [Semantic Security and IND-CPA / IND-CCA Security](#semantic-security-and-ind-cpa-ind-cca-security) and [Random Oracle Model](#random-oracle-model-rom-vs-standard-model).

**Production readiness:** Production
Concrete security analysis directly determines parameter sizes in all deployed standards (AES key lengths, NIST PQC parameters, TLS cipher suite recommendations).

**Implementations:**
- Concrete security is an analysis framework, not standalone software. Tools that support concrete security analysis:
- [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/) — OCaml, automated tool producing concrete security bounds
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, formal verification with concrete bound tracking

**Security status:** Secure
The concrete security framework itself is sound; its outputs directly determine whether deployed parameters provide the claimed security level.

**Community acceptance:** Standard
Concrete security analysis is mandatory in NIST, IETF, and ISO standardization processes. Bellare-Rogaway's framework is the universally accepted methodology.

---

## Perfect Forward Secrecy (PFS)

**Goal:** Bound the damage of long-term key compromise. A protocol achieves perfect (more precisely, *forward*) secrecy if compromise of a party's long-term secret key does not retroactively expose session keys established in prior sessions. Each session key is derived from fresh ephemeral randomness and is deleted immediately after use, so a future adversary who steals the long-term key obtains no information about past communications. PFS is now a hard requirement for modern TLS, Signal, and other secure-channel protocols.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Diffie-Hellman ephemeral key exchange (DHE)** | 1976 | CDH | Use fresh DH exponents per session; first construction providing forward secrecy; session key derivable from ephemeral secrets only [[1]](https://doi.org/10.1109/TIT.1976.1055638) |
| **Formal PFS definition (Günther)** | 1990 | Protocol analysis | First formal definition: past session keys remain secret after long-term key disclosure; distinguishes PFS from key freshness [[1]](https://link.springer.com/chapter/10.1007/3-540-46885-4_35) |
| **TLS 1.3 with mandatory DHE/ECDHE** | 2018 | ECDH / X25519 | TLS 1.3 removes all static RSA key exchange modes; ephemeral (EC)DHE is the only handshake mode; PFS mandatory for all connections [[1]](https://www.rfc-editor.org/rfc/rfc8446) |
| **Signal / Double Ratchet PFS** | 2016 | Diffie-Hellman ratchet | Per-message ephemeral DH updates provide forward secrecy and break-in recovery; strongest deployed PFS [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **Puncturable encryption / fine-grained PFS** | 2015 | Green–Miers | Receiver can "puncture" a secret key so it no longer decrypts a specific ciphertext; enables message-level PFS without re-keying the full session [[1]](https://eprint.iacr.org/2015/1189) |

**State of the art:** ECDHE in TLS 1.3 (X25519 / P-256) is the universal deployment standard. The Double Ratchet's per-message PFS goes further — see [Secure Channels](12-secure-communication-protocols.md#double-ratchet-symmetric-ratchet) and [Key Exchange](03-key-exchange-key-management.md#triple-diffie-hellman-3dh-x3dh). Puncturable encryption generalises PFS to the ciphertext level.

**Production readiness:** Production
PFS via ECDHE is mandatory in TLS 1.3 (RFC 8446) and deployed on every major browser and server. The Signal Double Ratchet provides per-message PFS for billions of users.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, TLS 1.3 with mandatory ECDHE PFS
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, Double Ratchet with per-message PFS
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust, TLS 1.3 with ECDHE-only handshake

**Security status:** Secure
PFS is a proven property of ephemeral key exchange; no attacks on the PFS guarantee itself at recommended parameters.

**Community acceptance:** Standard
PFS is mandated by TLS 1.3 (IETF RFC 8446), required by NIST SP 800-52r2, and universally deployed. Removal of static RSA key exchange in TLS 1.3 made PFS non-optional.

---

## Leftover Hash Lemma and Randomness Extraction

**Goal:** Convert weak, biased randomness into uniform bits. The Leftover Hash Lemma (LHL), due to Impagliazzo, Levin, and Luby (1989), states that applying a pairwise-independent hash function to a source with min-entropy k produces output that is statistically close to uniform in length up to k − 2 log(1/ε). This is the foundational tool in *randomness extraction* — producing near-uniform bits from any high-entropy source — and underlies key derivation, privacy amplification in QKD, leakage-resilient cryptography, and the security of randomness beacons.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Leftover Hash Lemma** | 1989 | Impagliazzo–Levin–Luby | Universal hashing extracts near-uniform bits from any source with sufficient min-entropy; tight statistical bound ε = 2^{−(k−m)/2} where m is output length [[1]](https://doi.org/10.1145/73007.73009) |
| **Strong extractors and seeded extraction** | 1999 | Nisan–Zuckerman | Seeded extractors produce near-uniform output using a short public seed; explicit constructions from expander graphs and hashing [[1]](https://doi.org/10.1016/S0022-0000(96)90009-X) |
| **Privacy amplification via hashing** | 1995 | Bennett–Brassard–Crépeau–Maurer | LHL applied to QKD: two parties sharing a weakly secret string extract a shorter, fully secret key in the presence of an eavesdropper [[1]](https://doi.org/10.1109/18.382009) |
| **Rényi entropy and LHL** | 2009 | Renner | Smooth min-entropy replaces min-entropy for one-shot settings; smooth min-entropy determines the optimal extraction rate; central to QKD security proofs [[1]](https://link.springer.com/article/10.1007/s00145-012-9140-5) |
| **LHL in leakage-resilient crypto** | 2009 | Dodis–Reyzin–Smith | Strong extractors + LHL underlie all leakage-resilient schemes: remaining entropy after leakage is extracted into a pseudorandom key [[1]](https://eprint.iacr.org/2003/198) |

**State of the art:** The LHL and strong extractors are indispensable in QKD (privacy amplification), key derivation functions (HKDF uses a hash-based extractor step), and leakage-resilient cryptography. Smooth min-entropy (Renner) is the canonical entropy measure for one-shot and quantum settings. See [Leakage-Resilient Cryptography](#leakage-resilient-cryptography) and [Pseudoentropy and Computational Entropy](#pseudoentropy-and-computational-entropy).

**Production readiness:** Production
The LHL underlies HKDF (RFC 5869), used in TLS 1.3, Signal, and WireGuard. Privacy amplification via the LHL is deployed in commercial QKD systems.

**Implementations:**
- [HKDF in libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, HKDF-based key derivation using hash-based extraction
- [rust-hkdf](https://github.com/RustCrypto/KDFs/tree/master/hkdf) ⭐ 91 — Rust, HKDF implementation
- QKD systems (ID Quantique, Toshiba) implement LHL-based privacy amplification internally.

**Security status:** Secure
The LHL is an information-theoretic result with tight bounds; its security does not depend on computational assumptions.

**Community acceptance:** Standard
The LHL is universally accepted and cited in thousands of papers. HKDF (its practical instantiation) is standardized in RFC 5869 and used in all major protocol suites.

---

## Hybrid Argument Technique

**Goal:** Prove indistinguishability of complex distributions by chaining small steps. The hybrid argument decomposes a security proof into a sequence of intermediate distributions — hybrids — that differ in only one position from their neighbors. If each adjacent pair is computationally indistinguishable, then by a triangle-inequality argument the endpoints are also indistinguishable, with a security loss of at most a factor equal to the number of hybrids. This is the single most widely used proof technique in computational cryptography.

| Result / Application | Year | Authors | Note |
|----------------------|------|---------|------|
| **Hybrid argument for PRG security** | 1982 | Yao | First systematic use: show that a length-doubling PRG is pseudorandom by a hybrid over output bits; reduction loses a factor of n (output length) [[1]](https://doi.org/10.1109/SFCS.1982.45) |
| **Hybrid argument for semantic security** | 1984 | Goldwasser–Micali | Semantic security of probabilistic encryption proven via a one-step hybrid (real vs. random ciphertext); foundational example [[1]](https://mit6875.github.io/PAPERS/probabilistic_encryption.pdf) |
| **Sequence-of-games proof methodology** | 2004 | Shoup | Systematic "game-hopping" formalization of hybrid arguments; each hop is a clearly justified syntactic or semantic change; now the standard style for provable security write-ups [[1]](https://eprint.iacr.org/2004/332) |
| **Hybrid argument for encryption of many messages** | 1997 | Bellare–Desai–Jokipii–Rogaway | Security under multiple encryptions via a hybrid over q challenge ciphertexts; shows IND-CPA implies IND-CPA-q with loss factor q [[1]](https://cseweb.ucsd.edu/~mihir/papers/sym-enc.pdf) |
| **Tight hybrids via reprogramming** | 2012 | Fischlin–Lehmann–Ristenpart–Shrimpton–Stam–Tessaro | Reprogramming random oracles in a single hybrid step; used to avoid a loss factor in ROM-based signatures [[1]](https://eprint.iacr.org/2010/540) |

**State of the art:** The hybrid argument is ubiquitous and appears in virtually every security proof in this repository. Shoup's game-hopping formalism (2004) is the standard proof style. Minimising the number of hybrid steps, or eliminating the resulting tightness loss, is an active goal — see [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness).

**Production readiness:** Production
The hybrid argument is a proof technique used in the security analysis of every deployed cryptographic scheme; it is not a software artifact.

**Implementations:**
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, formal verification tool that mechanizes hybrid arguments
- [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/) — OCaml, automated game-hopping proofs

**Security status:** Secure
The hybrid argument is a mathematical proof technique; its validity is unconditional.

**Community acceptance:** Standard
The single most widely used proof technique in cryptography; Shoup's game-hopping formalization (2004) is the accepted standard for writing security proofs.

---

## Random Self-Reducibility

**Goal:** Show that solving the average-case problem is as hard as the worst case. A problem is *random self-reducible* if any instance can be reduced, in polynomial time, to a *uniformly random* instance of the same problem. Consequently, if an adversary can solve the problem on a noticeable fraction of inputs, one can solve *every* instance by random self-reduction, collapsing average-case and worst-case hardness. This property is crucial to cryptographic hardness: it justifies using a fixed public key (a specific problem instance) rather than a fresh random instance per use, and it underpins the security of Rabin's OWF, DDH-based schemes, and LWE.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Random self-reducibility of quadratic residuosity** | 1985 | Blum–Micali | Deciding QR is random self-reducible: any instance is uniformly random up to the Legendre symbol; security of Blum-Micali PRG relies on this [[1]](https://doi.org/10.1137/0214033) |
| **Discrete log is random self-reducible** | 1985 | Blum–Micali | DLog on a group of prime order is random self-reducible: reduce DLog(g^x) to DLog(g^{x+r}) for random r; justifies reuse of group parameters [[1]](https://doi.org/10.1137/0214033) |
| **LWE worst-case to average-case** | 2005 | Regev | LWE is random self-reducible via quantum reduction from worst-case lattice problems (SIVP, GapSVP); hardness of a specific LWE instance implies hardness on average [[1]](https://doi.org/10.1145/1060590.1060603) |
| **RSA is NOT random self-reducible** | 1998 | Paillier | Standard RSA (fixed modulus N) lacks random self-reducibility; partial information attacks do not immediately generalize; motivated design of OAEP and RSA-KEM [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |
| **Worst-case/average-case for lattices (classical)** | 2007 | Peikert–Rosen | Classical worst-case to average-case reductions for Ring-LWE and SIS; removes the quantum requirement in restricted settings [[1]](https://eprint.iacr.org/2006/468) |

**State of the art:** Random self-reducibility is one of the key reasons lattice-based cryptography (LWE, SIS, NTRU) has strong theoretical foundations: hardness of average-case instances follows from worst-case lattice complexity. It also explains why Schnorr and other DLog-based schemes are secure against adaptive attacks using a fixed group. See [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds).

**Production readiness:** Production
Random self-reducibility justifies the security of all LWE/SIS-based NIST PQC standards (ML-KEM, ML-DSA) and all DLog-based schemes (Schnorr, ECDSA, ECDH).

**Implementations:**
- This is a hardness property, not a software artifact. All lattice and DLog-based cryptographic libraries rely on it implicitly.

**Security status:** Secure
Random self-reducibility is a proven mathematical property of specific problems (DLog, QR, LWE); it provides the strongest form of average-case hardness guarantee.

**Community acceptance:** Standard
Universally accepted as a fundamental property; Regev's LWE reduction (2005) and Blum-Micali's DLog self-reducibility are standard textbook results.

---

## Security Amplification

**Goal:** Boost a scheme that is weakly secure (succeeds with constant probability) into one that is overwhelmingly secure (success probability exponentially small). Many natural constructions achieve only a weak form of security — for example, a one-way function that is hard to invert on only a 1/poly(n) fraction of inputs, or a commitment scheme that hides with probability 3/4. Security amplification via repetition turns weak OWFs into strong OWFs, weak PRGs into strong PRGs, and weak cryptographic protocols into fully secure ones, at the cost of polynomial blowup in computation or communication.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Weak OWF → strong OWF (Yao)** | 1982 | Yao | n-fold parallel repetition of a weak OWF (hard to invert on ≥ 1/poly fraction) yields a function hard to invert on all but negligible fraction; first amplification for OWFs [[1]](https://doi.org/10.1109/SFCS.1982.45) |
| **Hardness amplification via XOR lemma** | 1994 | Yao; Levin | XOR of n independent copies of a hard predicate boosts hardness: if f is 1/2 + ε hard, f⊕n is 1/2 + ε^n hard; foundational for list-decodable codes and PRGs [[1]](https://doi.org/10.1109/SFCS.1994.365738) |
| **Parallel repetition theorem** | 1998 | Raz | For two-prover interactive proofs and coin-tossing protocols, n-fold parallel repetition decreases the soundness error exponentially; resolves longstanding open question [[1]](https://doi.org/10.1137/S0097539795280895) |
| **Direct product theorems for cryptography** | 2008 | Bellare–Impagliazzo | Direct product theorems: if breaking one instance has success p, breaking k independent instances simultaneously has success ≤ p^k; used for amplifying OT, commitment, and MAC security [[1]](https://link.springer.com/chapter/10.1007/978-3-540-78524-8_17) |
| **Weak to strong OWF (Goldreich-Levin based)** | 1993 | Goldreich–Levin (HILL amplification) | Amplification via Goldreich-Levin extraction: a function that is weak-OWF for any noticeable fraction can be amplified to strong OWF by chaining GL bits; integral to HILL PRG construction [[1]](https://doi.org/10.1137/S0097539793244708) |

**State of the art:** Security amplification is a fundamental meta-theorem of cryptography. Raz's parallel repetition theorem is the canonical tool for amplifying interactive proofs and MPC protocols. Direct product theorems underlie multi-instance security arguments used in batching and aggregate signatures. See [Hardcore Predicates and the Goldreich-Levin Theorem](#hardcore-predicates-and-the-goldreich-levin-theorem) and [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness).

**Production readiness:** Production
Security amplification is implicit in all deployed systems that use repeated trials, parallel repetition, or multi-instance security (e.g., repeated Sigma protocols, batch verification).

**Implementations:**
- Security amplification is a proof technique; no standalone software. It is implicit in:
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) ⭐ 2.4k — C, batch verification uses direct product theorem arguments
- Protocol implementations using parallel Sigma protocols for soundness amplification

**Security status:** Secure
Raz's parallel repetition theorem and Yao's XOR lemma are proven mathematical results.

**Community acceptance:** Standard
Universally accepted; Raz's parallel repetition theorem (1998) is one of the most celebrated results in theoretical computer science.

---

## Simulation-Based Security (SIM) vs. Indistinguishability-Based Security (IND)

**Goal:** Understand two fundamental paradigms for defining cryptographic security. Indistinguishability-based definitions (IND) specify security via a game in which an adversary cannot distinguish between two explicitly chosen distributions — for example, encryptions of two messages of its choice. Simulation-based definitions (SIM) instead compare a real protocol execution to an ideal execution with a trusted party: a protocol is secure if any real-world adversary can be "simulated" by an ideal-world adversary that talks only to the ideal functionality, obtaining no more information. SIM-security is strictly stronger and composes modularly (the basis of UC); IND-based security is game-specific and may not compose, but is often easier to work with and sufficient for standalone primitives.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **IND-CPA / semantic security** | 1984 | Goldwasser–Micali | Canonical IND definition: adversary cannot distinguish encryptions of chosen plaintexts; equivalent to semantic security [[1]](https://mit6875.github.io/PAPERS/probabilistic_encryption.pdf) |
| **SIM-security for OT** | 1987 | Goldreich–Micali–Wigderson | Ideal-world / real-world paradigm for oblivious transfer; adversary's view in the real protocol is simulatable given only the ideal output [[1]](https://doi.org/10.1145/28395.28420) |
| **SIM vs. IND for encryption (non-equivalence)** | 2000 | Canetti–Dwork–Naor–Ostrovsky | SIM-secure (non-committing) encryption requires communication overhead; IND-CCA2 encryption does not achieve SIM-security against adaptive corruptions [[1]](https://eprint.iacr.org/1996/058) |
| **Ideal functionality paradigm (UC)** | 2001 | Canetti | Formalised real/ideal world comparison as universal composition; every UC-secure protocol is SIM-secure in the strongest sense [[1]](https://eprint.iacr.org/2000/067) |
| **IND ↛ SIM for PKE under adaptive corruptions** | 2011 | Nielsen–Wichs | Separation: IND-CCA2-secure PKE does not achieve SIM-based security when the receiver can be adaptively corrupted; non-committing encryption is necessary [[1]](https://eprint.iacr.org/2011/215) |

**State of the art:** IND-CPA/IND-CCA2 remain the standard for standalone primitives (PKE, KEM, signatures). SIM-based / UC security is required for protocols that must compose — [MPC](06-multi-party-computation.md#multi-party-computation-mpc), [CGKA/MLS](12-secure-communication-protocols.md#continuous-group-key-agreement-cgka-mls), [OT](06-multi-party-computation.md#oblivious-transfer-ot). Non-committing encryption bridges the gap when adaptive corruptions are needed under SIM. See [Universal Composability (UC) Framework](#universal-composability-uc-framework) and [Semantic Security and IND-CPA / IND-CCA Security](#semantic-security-and-ind-cpa-ind-cca-security).

**Production readiness:** Production
Both paradigms are used in the security analysis of all deployed protocols: IND for standalone primitives, SIM for composed protocols (MPC, MLS, OT).

**Implementations:**
- These are definitional frameworks, not software. Tools for formalizing proofs in both paradigms:
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, supports both game-based (IND) and simulation-based proofs

**Security status:** Secure
Both paradigms are mathematically well-defined; their relationship (IND does not imply SIM under adaptive corruptions) is precisely characterized.

**Community acceptance:** Standard
Both paradigms are universally accepted; IND-CCA2 dominates for standalone primitives, SIM/UC for composable protocols. The Canetti-Dwork-Naor-Ostrovsky separation is a standard reference.

---

## Adaptive vs. Static Corruptions in Multi-Party Protocols

**Goal:** Model how an adversary may choose which parties to corrupt. A *static* adversary fixes the set of corrupted parties before the protocol begins; an *adaptive* adversary may corrupt parties during execution, choosing whom to corrupt based on messages it has observed so far. Adaptive corruption is far more realistic — a real attacker can target a party after seeing its public messages — but is much harder to achieve: it typically requires non-committing encryption or erasure assumptions, because the simulator must be able to explain honestly generated messages after the fact, having not yet fixed the corrupted party's internal state.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Adaptive security definition** | 1996 | Canetti–Feige–Goldreich–Naor | Formal separation between static and adaptive adversaries in MPC; showed that standard garbled-circuit constructions are only statically secure [[1]](https://eprint.iacr.org/1996/058) |
| **Non-committing encryption (NCE)** | 1996 | Canetti–Feige–Goldreich–Naor | NCE enables adaptively secure MPC: the simulator can equivocate on ciphertexts after a party is corrupted; implies log-factor communication overhead [[1]](https://eprint.iacr.org/1996/058) |
| **Adaptive security from erasures** | 2007 | Goldwasser–Lindell | If parties can securely erase their randomness, adaptive security is achievable without NCE; erasure model simplifies protocol design [[1]](https://eprint.iacr.org/2002/012) |
| **Adaptive OT** | 2009 | Green–Hohenberger | Oblivious transfer adaptively secure under DDH; first practical adaptive OT; underlying tool for adaptively secure two-party computation [[1]](https://eprint.iacr.org/2009/190) |
| **Adaptively secure garbled circuits** | 2014 | Lindell–Oxman–Pinkas | Garbled circuits achieving adaptive security without erasures via re-garbling techniques; O(1)-round adaptively secure 2PC [[1]](https://eprint.iacr.org/2013/167) |
| **YOSO model (adaptive roles)** | 2021 | Gentry–Halevi–Krawczyk–Rabin–Simon–Srinivasan–Woodruff | You Only Speak Once: adversary adaptively corrupts parties only after they have broadcast; avoids NCE at the cost of one-shot communication [[1]](https://eprint.iacr.org/2021/210) |

**State of the art:** Adaptive security is the correct model for internet-scale protocols. Non-committing encryption (NCE) is unavoidable in the no-erasure setting; practical NCE constructions from lattices (Döttling et al. 2020) are now available. The YOSO model offers an alternative architectural approach used in blockchain leader election. See [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and [Universal Composability (UC) Framework](#universal-composability-uc-framework).

**Production readiness:** Mature
Adaptive security is the target for MLS (IETF RFC 9420), Signal, and advanced MPC frameworks. YOSO is deployed in blockchain secret leader election research.

**Implementations:**
- [openmls](https://github.com/openmls/openmls) ⭐ 905 — Rust, MLS implementation targeting adaptive security
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, MPC framework with adaptive security options
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, achieves adaptive security via secure erasure of ephemeral keys

**Security status:** Secure
Adaptive security is achievable via NCE (without erasures) or secure erasure; both approaches are proven sound.

**Community acceptance:** Widely trusted
Adaptive security is recognized as the correct real-world model; IETF MLS and academic MPC literature require it. The YOSO model is an active area of blockchain research.

---

## Indifferentiability Framework

**Goal:** Prove that a construction using a simpler ideal primitive is as secure as if a stronger ideal primitive were used directly. Maurer, Renner, and Holenstein (2004) introduced indifferentiability to capture when a hash construction built from an ideal compression function (or block cipher) is "as good as" a random oracle. A construction C[P] (using primitive P) is indifferentiable from an ideal primitive Q if there is a simulator S such that (C[P], P) is computationally indistinguishable from (Q, S^Q) — meaning any system that uses C[P] behaves as if it used Q directly. This justifies plugging hash constructions into random-oracle proofs without invalidating them.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Indifferentiability framework** | 2004 | Maurer–Renner–Holenstein | Foundational definition; indifferentiability implies security in any single-stage cryptographic game that uses the ideal primitive as a subroutine [[1]](https://link.springer.com/chapter/10.1007/978-3-540-24638-1_2) |
| **Merkle-Damgård is NOT indifferentiable** | 2004 | Coron–Dodis–Malinaud–Puniya | MD construction leaks structure: length extension attacks mean MD[π] is not indifferentiable from a RO; motivates sponge and prefix-free MD variants [[1]](https://eprint.iacr.org/2005/210) |
| **Sponge construction is indifferentiable** | 2008 | Bertoni–Daemen–Peeters–Van Assche | Sponge functions built from a random permutation are indifferentiable from a random oracle; theoretical foundation for SHA-3/Keccak [[1]](https://keccak.team/files/SpongeFunctions.pdf) |
| **HMAC indifferentiability** | 2012 | Gazi–Maurer | HMAC built from an ideal compression function is indifferentiable from a PRF; justifies HMAC's security proofs in the random oracle model [[1]](https://link.springer.com/chapter/10.1007/978-3-642-32009-5_21) |
| **Multi-stage security and indifferentiability limits** | 2011 | Ristenpart–Shacham–Shrimpton | Indifferentiability does not imply security for multi-stage games (e.g., RKA, related-key attacks); delineates the boundary of what indifferentiability guarantees [[1]](https://eprint.iacr.org/2011/005) |

**State of the art:** Indifferentiability is the standard tool for justifying hash-construction security in the ROM. SHA-3's sponge design was chosen partly because it achieves indifferentiability from a random oracle (given a random permutation), unlike Merkle-Damgård. The Ristenpart-Shacham-Shrimpton limitation is important: indifferentiability does not cover all security properties. See [Random Oracle Model (ROM) vs. Standard Model](#random-oracle-model-rom-vs-standard-model).

**Production readiness:** Production
Indifferentiability proofs justify SHA-3 (Keccak), HMAC, and all sponge-based constructions deployed in TLS, SSH, and NIST standards.

**Implementations:**
- Indifferentiability is a proof framework, not standalone software. Constructions validated by indifferentiability analysis:
- [XKCP (Keccak Code Package)](https://github.com/XKCP/XKCP) ⭐ 643 — C/assembly, reference SHA-3/Keccak implementation (sponge indifferentiability)
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, HMAC implementation whose security relies on indifferentiability arguments

**Security status:** Secure
Indifferentiability proofs are mathematically rigorous; the sponge construction's indifferentiability from a random oracle is proven under the random permutation model.

**Community acceptance:** Standard
Indifferentiability is the accepted methodology for justifying hash construction security; it influenced NIST's selection of SHA-3 and is cited in all modern hash function analyses.

---

## Symbolic Model (Dolev-Yao) vs. Computational Model

**Goal:** Understand two complementary paradigms for reasoning about protocol security. The *symbolic model* (Dolev-Yao, 1983) treats cryptographic operations as perfect black-box functions defined by algebraic term rewriting: an adversary can intercept, forward, and compose messages but cannot break the underlying primitives. This enables automated analysis via model checking and theorem proving. The *computational model* treats messages as bit strings, adversaries as probabilistic polynomial-time algorithms, and security as indistinguishability of probability distributions — the setting of provable security. Bridging the two models — showing that symbolic security implies computational security — is a central research challenge.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Dolev-Yao adversary model** | 1983 | Dolev–Yao | Formalised symbolic Dolev-Yao attacker: controls the network, can compose and decompose messages, cannot break encryption; enables decidability of security properties for finite protocols [[1]](https://doi.org/10.1109/TIT.1983.1056650) |
| **Abadi-Rogaway computational soundness** | 2002 | Abadi–Rogaway | Formal languages (symbolic expressions) are *computationally sound*: if a property holds symbolically, it holds computationally under CPA-secure encryption; first rigorous bridge [[1]](https://doi.org/10.1145/503387.503389) |
| **Computational soundness for active adversaries** | 2005 | Cortier–Warinschi | Extended Abadi-Rogaway to CCA2 and active (Dolev-Yao) adversaries; symbolic security implies computational security for a richer class of protocols [[1]](https://link.springer.com/chapter/10.1007/11691372_17) |
| **Computationally complete symbolic attacker** | 2012 | Bana–Comon-Lundh | Axiomatic approach: add computational axioms to the symbolic model on the fly to make symbolic proofs complete for the computational model; used in CCSA logic [[1]](https://link.springer.com/chapter/10.1007/978-3-642-35289-8_22) |
| **Limitation: symbolic ↛ computational for all primitives** | 2006 | Backes–Pfitzmann | Symbolic soundness fails for hash functions and digital signatures without additional conditions; gap between Dolev-Yao and computational hash models [[1]](https://link.springer.com/chapter/10.1007/11681878_26) |

**State of the art:** The symbolic model remains the foundation for automated protocol verification tools (ProVerif, Tamarin — see [Automated Protocol Verification](#automated-protocol-verification-proverif-tamarin-easycrypt)). Computational soundness results make symbolic proofs rigorous for specific primitives (CCA2 encryption, MACs). A fully general bridge does not yet exist. The two models are complementary: symbolic for finding attacks efficiently, computational for rigorous security guarantees.

**Production readiness:** Production
The Dolev-Yao symbolic model is the basis for all automated protocol verification tools (ProVerif, Tamarin) used in IETF standardization of TLS 1.3, MLS, and WireGuard.

**Implementations:**
- [ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/) — OCaml, automated symbolic protocol verifier
- [Tamarin](https://tamarin-prover.com) — Haskell, symbolic model checker for security protocols
- [DY*](https://github.com/reprosec/dolev-yao-star) ⭐ 19 — F*, verified protocol implementation in the Dolev-Yao model

**Security status:** Caution
Symbolic proofs are computationally sound only for specific primitives (CCA2 encryption, MACs); the gap between symbolic and computational models remains open for hash functions and signatures.

**Community acceptance:** Standard
The Dolev-Yao model is universally used in protocol verification; Abadi-Rogaway computational soundness (2002) is a standard reference. ProVerif and Tamarin are required tools for IETF protocol analysis.

---

## Automated Protocol Verification (ProVerif, Tamarin, EasyCrypt)

**Goal:** Machine-check cryptographic protocol security. As protocols grow more complex — multi-round, multi-party, concurrent — manual proofs become error-prone and hard to verify. Automated tools offer two complementary approaches: *symbolic model checkers* (ProVerif, Tamarin) that reason about Dolev-Yao-style adversaries and can verify secrecy, authentication, and equivalence properties automatically for unbounded sessions; and *proof assistants / game-based frameworks* (EasyCrypt, CryptHOL) that formalise computational security proofs with machine-checked arithmetic, enabling verification of complex reduction arguments.

| Tool / Result | Year | Authors | Note |
|---------------|------|---------|------|
| **ProVerif** | 2001 | Blanchet | Horn-clause-based symbolic verifier; automatically decides secrecy and authentication for unbounded sessions; applied protocols: TLS, SSH, Signal [[1]](https://bblanche.gitlabpages.inria.fr/proverif/) |
| **Tamarin prover** | 2012 | Meier–Schmidt–Cremers–Basin | Constraint-solving symbolic verifier; handles stateful protocols, exclusive-or, Diffie-Hellman; used to find attack on PKCS#11 and verify TLS 1.3 [[1]](https://tamarin-prover.com) |
| **TLS 1.3 formal verification** | 2017 | Cremers–Horvat–Hoyland–Scott–van der Merwe | Tamarin-verified TLS 1.3: proved key secrecy and mutual authentication for all handshake modes before RFC publication; influenced final design [[1]](https://eprint.iacr.org/2016/081) |
| **EasyCrypt** | 2011 | Barthe–Grégoire–Heraud–Zanella Béguelin | Probabilistic relational Hoare logic for computational proofs; machine-checked ROM proofs of OAEP, HMAC, Merkle-Damgård; used for Signal's X3DH [[1]](https://eprint.iacr.org/2011/091) |
| **CryptHOL** | 2018 | Basin–Lochbihler–Sefidgar | Game-based security proofs in Isabelle/HOL; formal proof of CPA-secure ElGamal, PRF-PRG security; foundational for large-scale verified cryptography [[1]](https://eprint.iacr.org/2017/753) |
| **DY* (Dolev-Yao star)** | 2021 | Bhargavan–Bichhawat–Do–Höfner–Kohlweiss–Sasse–Veronese | F*-based verified protocol implementation: symbolic security proof and executable code in the same language; applied to TLS 1.3 record layer [[1]](https://eprint.iacr.org/2021/097) |

**State of the art:** ProVerif and Tamarin are the dominant symbolic tools and are routinely used to analyse IETF protocol drafts (TLS 1.3, MLS, WireGuard). EasyCrypt is the leading computational proof assistant; it has been used to verify ML-KEM components. DY* and CryptHOL push toward verified implementations. See [Symbolic Model (Dolev-Yao) vs. Computational Model](#symbolic-model-dolev-yao-vs-computational-model) and [Universal Composability (UC) Framework](#universal-composability-uc-framework).

**Production readiness:** Production
ProVerif and Tamarin are routinely used by IETF working groups and influenced the final design of TLS 1.3 and MLS. EasyCrypt has verified ML-KEM components.

**Implementations:**
- [ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/) — OCaml, automated symbolic protocol verifier
- [Tamarin](https://tamarin-prover.com) — Haskell, stateful symbolic model checker
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, computational proof assistant
- [DY*](https://github.com/reprosec/dolev-yao-star) ⭐ 19 — F*, verified protocol implementation

**Security status:** Secure
The tools themselves are sound within their respective models; Tamarin and ProVerif have been extensively validated against known protocol attacks.

**Community acceptance:** Standard
ProVerif and Tamarin are the de facto standard for IETF protocol analysis. EasyCrypt is the leading computational verification tool. All are widely cited and used in standardization processes.

---

## Knowledge-Soundness, Extractability, and Simulation-Extractability

**Goal:** Distinguish three increasingly strong notions of what it means for a proof system to "guarantee the prover knows a witness." *Proof of knowledge (PoK)* / *knowledge-soundness*: an efficient knowledge extractor can recover a witness from any prover that produces a valid proof with non-negligible probability, via rewinding or black-box extraction. *Extractability* (or *straight-line extraction*): the extractor recovers the witness from a single proof transcript, without rewinding — essential in the random oracle model and for composing with UC. *Simulation-extractability* (SE): the extractor succeeds even when the adversary has seen an arbitrary number of simulated proofs; the adversary cannot produce a new valid proof without knowing a witness, even after observing a polynomial number of proofs for other statements. SE is strictly stronger than both and is required whenever proofs are used in a setting where signatures or commitments can be forged using proof malleability.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Proof of knowledge / knowledge-soundness** | 1988 | Feige–Fiat–Shamir | Introduced the notion that a protocol is a "proof of knowledge" if a black-box extractor recovers the witness by rewinding the prover; formalised in Schnorr identification [[1]](https://doi.org/10.1007/3-540-47721-7_11) |
| **Simulation-sound NIZK** | 1999 | Sahai | NIZK that remains sound even after an adversary sees simulated proofs; prevents a malicious prover from using simulated proofs as templates for forging new ones [[1]](https://doi.org/10.1109/SFFCS.1999.814584) |
| **Simulation-extractability definition** | 2004 | Groth–Ostrovsky–Sahai | Formal definition of simulation-extractability for NIZK: after seeing simulated proofs, an adversary cannot produce a new valid proof without the extractor recovering a witness [[1]](https://eprint.iacr.org/2006/107) |
| **SE-SNARKs** | 2012 | Groth | Groth16 SNARK achieves simulation-extractability under q-PKE; extractability is straight-line in the AGM/GGM; no rewinding needed in the algebraic setting [[1]](https://eprint.iacr.org/2016/260) |
| **UC-extractability vs. SE** | 2017 | Abdolmaleki–Baghery–Lipmaa–Zając | Clarified hierarchy: UC-extractable NIZKs (straight-line, simulation-sound) are strictly stronger than SE; construction from pairing assumptions [[1]](https://eprint.iacr.org/2017/121) |
| **Fiat-Shamir and simulation-extractability in ROM** | 2019 | Fischlin–Günther | Fiat-Shamir transforms produce simulation-extractable NIZKs in the ROM without rewinding; tight proof using straight-line extraction from the hash transcript [[1]](https://eprint.iacr.org/2020/1184) |

**State of the art:** Simulation-extractability is the standard target for NIZKs used as building blocks in signature schemes, CCA-secure PKE, and UC-secure protocols. Groth16 achieves SE under algebraic assumptions; transparent SNARKs (STARK, Plonk) achieve knowledge-soundness in the ROM. See [NIZK: Definitions, Simulation Soundness, and Extractability](#nizk-definitions-simulation-soundness-and-extractability), [Knowledge-of-Exponent Assumption (KEA) and Falsifiability](#knowledge-of-exponent-assumption-kea-and-falsifiability), and [Universal Composability (UC) Framework](#universal-composability-uc-framework).

**Production readiness:** Production
Knowledge-soundness and simulation-extractability underlie all deployed SNARK systems (Groth16 in Zcash, Plonk in Ethereum L2s) and Fiat-Shamir-based signature schemes.

**Implementations:**
- [arkworks-rs/groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 — Rust, simulation-extractable SNARK
- [zkcrypto/bellman](https://github.com/zkcrypto/bellman) ⭐ 1.1k — Rust, Zcash's Groth16 with extractability
- [halo2](https://github.com/zcash/halo2) ⭐ 895 — Rust, Plonk-based proving system with knowledge-soundness in ROM

**Security status:** Secure
The hierarchy (knowledge-soundness ⊂ extractability ⊂ simulation-extractability) is well-established; each level is proven sound under its respective assumptions.

**Community acceptance:** Standard
Simulation-extractability is the accepted security target for SNARK-based protocols; knowledge-soundness is the minimum for all deployed proof systems.

---

## Entropy Source Models

**Goal:** Formalise the structure of imperfect randomness sources. Real-world entropy sources — hardware RNGs, user keystrokes, network jitter — are not uniformly random. The cryptographic treatment distinguishes several models of partial randomness: *min-entropy* (worst-case unpredictability over all outcomes), *Santha-Vazirani sources* (each bit is slightly biased but individually partially unpredictable), *block sources* (each successive block has min-entropy k conditioned on all prior blocks), and *non-oblivious / computational sources* (sources whose distributions are computationally indistinguishable from high-entropy ones). Understanding which source model applies determines whether and how much randomness can be extracted, and whether extraction requires a public seed.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Santha-Vazirani (SV) sources** | 1986 | Santha–Vazirani | Each bit i satisfies 1/2 − δ ≤ Pr[b_i = 1 | b_{<i}] ≤ 1/2 + δ; proved no deterministic extractor exists for SV sources; two independent SV sources suffice [[1]](https://doi.org/10.1109/SFCS.1986.51) |
| **Block sources** | 1991 | Chor–Goldreich | Block source model: each block has min-entropy k conditioned on previous blocks; deterministic two-source extractors exist for block sources [[1]](https://doi.org/10.1137/0220009) |
| **Min-entropy and the leftover hash lemma** | 1989 | Impagliazzo–Levin–Luby | Min-entropy H∞(X) = −log max_x Pr[X=x] is the correct entropy measure for extraction; LHL extracts near-uniform bits from any source with H∞(X) ≥ k using a short seed [[1]](https://doi.org/10.1145/73007.73009) |
| **Computational entropy / HILL entropy** | 1999 | Håstad–Impagliazzo–Levin–Luby | Computational sources: a distribution has computational entropy k if it is indistinguishable from a distribution of Shannon entropy k; the relevant notion for PRG constructions [[1]](https://doi.org/10.1137/S0097539793244708) |
| **Non-malleable extractors** | 2009 | Dodis–Wichs | Extractor secure against an adversary who can adaptively tamper with the seed; used to build privacy amplification protocols against active adversaries [[1]](https://eprint.iacr.org/2009/430) |
| **Condensers and lossless extractors** | 2011 | Guruswami–Umans–Vadhan | Condensers map a source to a shorter distribution with higher min-entropy per bit; enable extraction from sources with sub-logarithmic entropy per bit [[1]](https://doi.org/10.1145/2077216.2077220) |

**State of the art:** Min-entropy is the standard entropy measure for applied cryptography (NIST SP 800-90B uses it for entropy assessment). The LHL and seeded strong extractors cover most practical key derivation scenarios (HKDF). Non-malleable extractors underlie information-theoretic two-party protocols against tampering adversaries. See [Leftover Hash Lemma and Randomness Extraction](#leftover-hash-lemma-and-randomness-extraction) and [Pseudoentropy and Computational Entropy](#pseudoentropy-and-computational-entropy).

**Production readiness:** Production
Min-entropy assessment is mandated by NIST SP 800-90B for all hardware RNG certifications; entropy source models directly determine DRBG seeding requirements.

**Implementations:**
- [NIST SP 800-90B test suite](https://github.com/usnistgov/SP800-90B_EntropyAssessment) ⭐ 244 — Python/C++, official min-entropy estimation tools
- [jitterentropy-library](https://github.com/smuellerDD/jitterentropy-library) ⭐ 141 — C, CPU jitter entropy source with min-entropy justification

**Security status:** Secure
Entropy source models are information-theoretic; their correctness depends on accurate modeling of the physical source, not computational assumptions.

**Community acceptance:** Standard
Min-entropy is mandated by NIST SP 800-90B and used in all RNG certifications. The Santha-Vazirani and block source models are standard in randomness extraction theory.

---

## Bit Security and Its Definition

**Goal:** Give a clean, meaningful measure of a cryptographic scheme's security level in bits. Informally, a scheme has "k-bit security" if breaking it requires about 2^k work. But formalising this precisely is subtle: different games, different success probability thresholds, and different resource measures (time, queries, distinguishing advantage) all affect the count. Micciancio and Walter (2018) identified and corrected a systematic error in the classical definition — schemes were often credited with more bits of security than they actually provide — by re-centering the advantage around 1/2 rather than 0, and requiring the attacker to do genuine prediction rather than mere distinguishing.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Classical bit-security definition** | 1993 | Bellare–Rogaway | Informal notion: scheme is (t, ε)-secure if no adversary with runtime t succeeds with probability > ε; "k bits" means t/ε ≈ 2^k [[1]](https://cseweb.ucsd.edu/~mihir/papers/ro.pdf) |
| **Goldreich-Levin bit security** | 1989 | Goldreich–Levin | Hardcore bit achieves 1-bit security in the sense that predicting it is as hard as inverting the OWF; formalism anticipates later clean definitions [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **Micciancio-Walter bit security** | 2018 | Micciancio–Walter | Corrected definition: security level is −log₂(AdvantageNorm / Cost) where advantage is normalised to the [0,1] range relative to a trivial strategy; shows many lattice parameters are overclaimed by ≥8 bits [[1]](https://eprint.iacr.org/2018/077) |
| **Multi-user bit security** | 2019 | Bellare–Tessaro | Extended Micciancio-Walter framework to multi-user settings (many keys); bit-security degrades logarithmically in the number of users, consistent with known multi-user attacks [[1]](https://eprint.iacr.org/2019/145) |
| **Bit security in the AGM** | 2022 | Kiltz–Loss–Pan | Tight bit-security analysis of Schnorr, BLS, and Groth16 in the Algebraic Group Model; shows tighter concrete bounds than prior estimates using Micciancio-Walter normalisation [[1]](https://eprint.iacr.org/2022/438) |

**State of the art:** The Micciancio-Walter (2018) definition is the current standard for rigorous bit-security analysis; it has influenced NIST PQC parameter selection. Multi-user security (Bellare-Tessaro) is now routinely considered in protocol specifications. See [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness) and [Generic Group Model (GGM) and Algebraic Group Model (AGM)](#generic-group-model-ggm-and-algebraic-group-model-agm).

**Production readiness:** Production
Bit-security definitions directly determine parameter sizes for all NIST PQC standards (ML-KEM, ML-DSA) and deployed elliptic curve schemes.

**Implementations:**
- Bit security is a definitional framework; no standalone software. Parameter estimation tools:
- [lattice-estimator](https://github.com/malb/lattice-estimator) ⭐ 351 — Python, estimates bit-security of lattice-based schemes using Micciancio-Walter normalization
- [keylength.com](https://www.keylength.com) — web tool, compares bit-security recommendations across standards bodies

**Security status:** Secure
The Micciancio-Walter definition corrects prior overcounting; bit-security estimates under this framework are conservative and reliable.

**Community acceptance:** Standard
Micciancio-Walter (2018) is now the accepted standard for rigorous bit-security claims; used in NIST PQC evaluations and academic parameter analyses.

---

## Composability Beyond UC: GNUC, SPS, and IITM

**Goal:** Address limitations of the UC framework with alternative or complementary composition models. While UC is the dominant composability framework, it has known limitations: the UC composition theorem requires the environment to be a single interactive Turing machine; it handles subroutine composition but not, e.g., joint-state composition or global ciphersuites without careful extensions. Several alternatives have been proposed: *GNUC* (Hofheinz-Shoup, 2011) restructures the execution model to avoid subtle issues with UC's environment/protocol interfaces; *Symbolic Protocol System (SPS)* applies to formal-model composability; and the *Inexhaustible Interactive Turing Machine (IITM)* model (Küsters-Tuengerthal-Rausch, 2013) gives the most general and rigorously founded execution model, resolving well-formedness issues in UC while supporting global state, joint sessions, and arbitrary protocol structures.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **UC framework** | 2001/2020 | Canetti | Foundational real/ideal composability; composition theorem; basis for all subsequent models; see [Universal Composability (UC) Framework](#universal-composability-uc-framework) [[1]](https://eprint.iacr.org/2000/067) |
| **GNUC (General Non-malleable UC)** | 2011 | Hofheinz–Shoup | Revised execution model resolving interface and well-formedness issues in UC; cleaner polynomial-time execution semantics; proves equivalence to UC for most protocols [[1]](https://eprint.iacr.org/2011/471) |
| **IITM model** | 2013 | Küsters–Tuengerthal–Rausch | Inexhaustible Interactive Turing Machine: fully rigorous general model; handles global state, joint sessions, unbounded sessions without assumptions on environment structure; subsumes UC and GNUC [[1]](https://eprint.iacr.org/2013/025) |
| **Global UC (GUC)** | 2007 | Canetti–Dodis–Pass–Walfish | Extends UC to global functionalities shared across all sessions (e.g., a global CRS or global random oracle); allows modular composition even when sub-protocols share global state [[1]](https://eprint.iacr.org/2006/432) |
| **Reactive simulatability (BRSIM)** | 2004 | Backes–Pfitzmann–Waidner | Concurrent composition framework for reactive systems; closer to process algebra; equivalent to UC for a broad class of protocols; used for symbolic soundness proofs [[1]](https://link.springer.com/chapter/10.1007/978-3-540-24638-1_3) |

**State of the art:** UC (including GUC) remains dominant in applied cryptography. The IITM model is the most mathematically rigorous alternative and is preferred in foundational work where UC's definitional subtleties matter. GNUC has been used in formal analysis of multi-party protocols. All models agree on the same set of "reasonable" protocols; differences appear in edge cases involving global state and concurrent joint sessions. See [Universal Composability (UC) Framework](#universal-composability-uc-framework), [Simulation-Based Security (SIM) vs. Indistinguishability-Based Security (IND)](#simulation-based-security-sim-vs-indistinguishability-based-security-ind), and [Adaptive vs. Static Corruptions in Multi-Party Protocols](#adaptive-vs-static-corruptions-in-multi-party-protocols).

**Production readiness:** Mature
GNUC, IITM, and GUC are used in rigorous academic protocol analyses; the IITM model is preferred for foundational correctness in MPC and threshold protocol proofs.

**Implementations:**
- [EasyUC](https://github.com/easyuc/EasyUC) ⭐ 45 — OCaml/EasyCrypt, machine-checked UC/GNUC proofs
- No standalone IITM or GNUC software; the models are used in paper proofs and formalized in proof assistants.

**Security status:** Secure
All composition frameworks (UC, GNUC, IITM, GUC) are mathematically sound; they agree on the security of all standard protocols and differ only in edge cases.

**Community acceptance:** Niche
UC remains dominant in practice; GNUC, IITM, and GUC are used by specialists in foundational protocol theory. The IITM model is gaining traction for its rigor.

---

## Abstract Cryptography (Constructive Cryptography)

**Goal:** Provide a top-down, composable framework for defining and proving cryptographic security. Maurer and Renner's Abstract Cryptography (2011) defines resources and constructions abstractly; security is the distance between a real construction and an ideal resource. The framework subsumes UC, information-theoretic security, and Shannon secrecy as special cases, giving a clean categorical treatment of composition.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Abstract Cryptography** | 2011 | Maurer–Renner | Top-down framework; resources as objects, constructions as converters; security = distance between real and ideal resource; subsumes UC and Shannon secrecy [[1]](https://crypto.ethz.ch/publications/files/MauRen11.pdf) |
| **Constructive Cryptography** | 2012 | Maurer | Companion paper; composable proofs by resource construction; security statements are resource equivalences [[1]](https://link.springer.com/chapter/10.1007/978-3-642-27375-9_3) |
| **Indifferentiability as AC instance** | 2016 | Maurer–Renner | The indifferentiability framework (2004) is a special case of abstract cryptography; unifies ROM hash justification with composable security [[1]](https://eprint.iacr.org/2016/903) |

**State of the art:** Abstract Cryptography is the most general composability framework, especially influential in the information-theoretic and quantum communities. For most applied protocol design, UC remains dominant. See [Universal Composability (UC) Framework](#universal-composability-uc-framework).

**Production readiness:** Research
Abstract Cryptography is a theoretical framework; it is used in academic proofs but has no standalone deployment or implementation.

**Implementations:**
- No standalone implementations; the framework is used in paper proofs and informs the design of formal verification tools.

**Security status:** Secure
The framework is mathematically sound and subsumes UC, Shannon secrecy, and information-theoretic security as special cases.

**Community acceptance:** Niche
Influential in the ETH Zurich school (Maurer, Renner) and in quantum cryptography; less widely adopted than UC in applied protocol design.

---

## Programmable vs. Non-Programmable Random Oracles

**Goal:** Identify which security proofs genuinely require the ability to "program" the random oracle — adaptively setting its outputs during the reduction. In the standard ROM, the reduction can program the oracle; in the non-programmable ROM (NPROM), the hash function is fixed before the reduction runs. Fischlin et al. (2010) showed that FDH signatures and many Fiat-Shamir transforms cannot be proven secure in the NPROM, clarifying which proofs rely on this artificial feature.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Random oracles with(out) programmability** | 2010 | Fischlin–Lehmann–Ristenpart–Shrimpton–Stam–Tessaro | FDH signatures cannot be proven secure in the NPROM via black-box reduction; programmability is essential; ASIACRYPT 2010 [[1]](https://link.springer.com/chapter/10.1007/978-3-642-17373-8_18) |
| **Impossibility for Fiat-Shamir in NPROM** | 2016 | Fukumitsu–Hasegawa | Fiat-Shamir signatures cannot be proven secure in the NPROM under any standard hardness assumption [[1]](https://link.springer.com/chapter/10.1007/978-3-319-45871-7_23) |

**State of the art:** NPROM separation results show that many ROM proofs rely on the artificial programmability feature. Constructions with NPROM proofs provide stronger real-world security evidence. See [Random Oracle Model (ROM) vs. Standard Model](#random-oracle-model-rom-vs-standard-model).

**Production readiness:** Research
NPROM separations are impossibility results; they guide protocol design but are not deployed as software.

**Implementations:**
- No standalone implementations; these are proof-theoretic results about the limitations of ROM proofs.

**Security status:** Secure
The separation results are mathematically proven; they clarify which ROM proofs are robust and which rely on artificial features.

**Community acceptance:** Niche
Well-known in the provable security community; Fischlin et al. (2010) and Fukumitsu-Hasegawa (2016) are standard references for ROM proof methodology.

---

## Wegman-Carter-Shoup Authentication and Information-Theoretic MACs

**Goal:** Achieve provably secure message authentication from information-theoretic assumptions using universal hash families. Wegman-Carter (1981) showed that combining a universal hash with a one-time pad on the tag produces an unconditionally secure MAC. Shoup (1996) extended this to the computational setting via a PRF (WCS construction), achieving security beyond the birthday bound for nonce-based MACs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wegman-Carter MAC** | 1981 | Universal hashing + OTP | Information-theoretically secure MAC; tag = H_k(m) ⊕ pad; forgery probability ≤ ε for ε-AU hash [[1]](https://www.sciencedirect.com/science/article/pii/0022000081900337) |
| **Wegman-Carter-Shoup (WCS)** | 1996 | Universal hash + PRF | Replaces OTP with PRF on a nonce; computationally secure for fresh nonces; information-theoretically MAC-secure per nonce [[1]](https://doi.org/10.1007/3-540-68697-5_24) |
| **Poly1305-AES** | 2005 | Polynomial universal hash + AES | Bernstein's WCS instantiation with strong concrete security; used in ChaCha20-Poly1305 [[1]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **GHASH / GCM** | 2005 | GF(2^128) polynomial hash + AES-CTR | GCM instantiates WCS with GHASH; dominant in TLS 1.3; birthday-bound limited [[1]](https://csrc.nist.gov/publications/detail/sp/800-38d/final) |

**State of the art:** Poly1305-AES / ChaCha20-Poly1305 is the dominant high-performance MAC in modern protocols (TLS 1.3, WireGuard). Both Poly1305 and GHASH/GCM are WCS instantiations. See [Foundational Primitives](01-foundational-primitives.md).

**Production readiness:** Production
ChaCha20-Poly1305 and AES-GCM (both WCS instantiations) are deployed in TLS 1.3, WireGuard, SSH, and IPsec on billions of devices.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ChaCha20-Poly1305 (WCS instantiation)
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-GCM with GHASH (WCS instantiation)
- [ring](https://github.com/briansmith/ring) ⭐ 4.1k — Rust, ChaCha20-Poly1305 and AES-GCM

**Security status:** Secure
Information-theoretically secure per-nonce (Wegman-Carter); computationally secure under PRF assumption (WCS). Nonce reuse breaks security — nonce-misuse resistance requires SIV modes.

**Community acceptance:** Standard
WCS is the basis of all modern AEAD MACs; Poly1305 and GHASH are standardized by IETF (RFC 8439, NIST SP 800-38D) and universally deployed.

---

## Related-Key Security

**Goal:** Maintain security when the adversary can observe cipher behavior under keys related to the target key. In a related-key attack (RKA), the adversary queries a cipher under keys φ(K) for adversarially chosen derivation functions φ from some class Φ. Critical for block ciphers used in hash-function modes and for key schedules: AES-256 has RKA vulnerabilities, and several historical attacks on DES were related-key attacks.

| Result | Year | Basis | Note |
|--------|------|-------|------|
| **RKA-PRF / RKA-PRP definitions** | 2003 | Bellare–Kohno | First formal model for RKA security; defines the relevant class Φ (XOR, affine); EUROCRYPT 2003 [[1]](https://link.springer.com/chapter/10.1007/3-540-39200-9_31) |
| **AES-256 RKA analysis** | 2010 | Biryukov–Khovratovich | RKA distinguishers on AES-256 (9 rounds) with 2^39 related keys; ASIACRYPT 2010 [[1]](https://link.springer.com/chapter/10.1007/978-3-642-10366-7_1) |
| **RKA-secure PRFs beyond linear** | 2014 | Bellare–Cash–Miller | PRFs secure against polynomial-degree related-key derivation from DDH; CRYPTO 2014 [[1]](https://link.springer.com/chapter/10.1007/978-3-662-44371-2_5) |

**State of the art:** Formal RKA definitions (Bellare-Kohno 2003) are standard when analyzing block ciphers and AEAD modes. RKA-secure PRFs from DDH give theoretical constructions; practical AEAD designs address RKA via key schedule diversification. See [Leakage-Resilient Cryptography](#leakage-resilient-cryptography) and [Non-Malleable Codes](#non-malleable-codes).

**Production readiness:** Mature
RKA analysis is standard in block cipher evaluation (AES, NIST Lightweight Crypto); practical AEAD designs incorporate RKA resistance via key schedule diversification.

**Implementations:**
- RKA security is an analysis property, not standalone software. Ciphers evaluated for RKA resistance:
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES implementation (AES-128 is RKA-resistant; AES-256 has known RKA weaknesses at reduced rounds)
- [tiny-AES-c](https://github.com/kokke/tiny-AES-c) ⭐ 4.9k — C, compact AES for embedded systems (key schedule is RKA-relevant)

**Security status:** Caution
AES-128 resists known RKA attacks; AES-256 has related-key distinguishers at 9 of 14 rounds (Biryukov-Khovratovich 2010). Practical impact is limited when keys are properly derived.

**Community acceptance:** Widely trusted
Bellare-Kohno (2003) RKA definitions are standard in block cipher analysis; RKA resistance is evaluated in NIST competitions and Common Criteria certifications.

---

## Multi-User and Multi-Instance Security

**Goal:** Accurately quantify security when many independent instances share the same design but use independent keys. Multi-user security bounds how much the adversary gains by attacking any of n independently keyed instances simultaneously — degrading by at most log n bits compared to single-user security. This matters at scale: attacking 2^30 TLS sessions costs only 30 fewer bits of security than attacking one.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Multi-user PKE security** | 2000 | Bellare–Boldyreva–Micali | First formal multi-user PKE model; single-user IND-CPA implies multi-user IND-CPA with n-factor loss [[1]](https://cseweb.ucsd.edu/~mihir/papers/musu.pdf) |
| **Multi-instance security for password hashing** | 2012 | Bellare–Ristenpart–Tessaro–Shrimpton | Multi-instance model for password hashing: adversary cracks any one of n hashes; evaluates bcrypt vs Argon2 [[1]](https://eprint.iacr.org/2012/196) |
| **Multi-user AES-GCM / TLS** | 2019 | Bellare–Tessaro | 2^30 degradation in 128-bit security at TLS scale; motivates 192-bit AES for high-volume deployments [[1]](https://eprint.iacr.org/2019/145) |
| **Tight multi-user ML-KEM** | 2023 | Hövelmanns–Hülsing–Majenz | Tight multi-user/multi-challenge reduction for ML-KEM in QROM; confirms 128-bit security holds at deployment scale [[1]](https://eprint.iacr.org/2022/1089) |

**State of the art:** Multi-user security analysis is now standard in NIST PQC evaluations and TLS cipher suite analysis. See [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness) and [Bit Security](#bit-security-and-its-definition).

**Production readiness:** Production
Multi-user security bounds directly influence TLS cipher suite parameters, NIST PQC security levels, and password hashing recommendations (bcrypt/Argon2).

**Implementations:**
- Multi-user security is an analysis framework, not standalone software. It affects parameter choices in:
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, TLS implementation where multi-user AES-GCM bounds apply
- [pqcrypto](https://github.com/pqclean/pqclean) ⭐ 893 — C, PQC implementations with multi-user/multi-challenge security analyses

**Security status:** Secure
Multi-user security degradation is well-characterized (logarithmic in the number of users); tight multi-user analyses exist for ML-KEM and BLS.

**Community acceptance:** Standard
Multi-user security is a mandatory consideration in NIST PQC evaluations and is routinely analyzed in TLS cipher suite recommendations.

---

## Selective vs. Full Security in IBE and ABE

**Goal:** Distinguish two levels of IBE/ABE security based on when the adversary commits to the challenge identity. In the selective model, the adversary declares the challenge identity before seeing public parameters — an artificial restriction enabling the first standard-model IBE constructions. Full (adaptive) security, where the adversary chooses the challenge after seeing public parameters, is the correct real-world notion. Achieving full security in the standard model required dual-system encryption (Waters 2009).

| Result | Year | Basis | Note |
|--------|------|-------|------|
| **Selective-ID IBE (Boneh-Boyen)** | 2004 | Bilinear maps | First standard-model IBE; only selective-ID security; tight DBDH reduction; CRYPTO 2004 [[1]](https://eprint.iacr.org/2004/172) |
| **Full IBE in standard model (Waters)** | 2005 | Bilinear maps | First fully secure (adaptive-ID) IBE without random oracles; artificial abort technique in proof [[1]](https://eprint.iacr.org/2004/180) |
| **Dual-system encryption** | 2009 | Waters | Proof technique: ciphertexts/keys exist in normal or semi-functional forms; enables fully secure IBE, HIBE, ABE; standard tool for all modern ABE constructions [[1]](https://eprint.iacr.org/2009/385) |
| **Selective-to-full via complexity leveraging** | 2007 | Boneh–Waters | Generic compiler from selective to full security at sub-exponential loss [[1]](https://eprint.iacr.org/2007/033) |
| **Fully secure ABE (Lewko-Waters)** | 2011 | Bilinear maps | First fully secure large-universe ABE using dual-system techniques [[1]](https://eprint.iacr.org/2010/351) |

**State of the art:** Dual-system encryption (Waters 2009) is the canonical technique for full IBE/ABE security in the standard model. See [Homomorphic and Functional Encryption](07-homomorphic-functional-encryption.md) and [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness).

**Production readiness:** Mature
Dual-system encryption is the standard proof technique for all modern ABE/IBE constructions; fully secure ABE libraries exist in research-grade implementations.

**Implementations:**
- [CHARM](https://github.com/JHUISI/charm) ⭐ 633 — Python, pairing-based crypto library with selective and fully secure IBE/ABE schemes
- [OpenABE](https://github.com/zeutro/openabe) ⭐ 274 — C++, ABE library implementing Waters' fully secure constructions
- [rabe](https://github.com/Fraunhofer-AISEC/rabe) ⭐ 93 — Rust, ABE library with dual-system-based schemes

**Security status:** Secure
Dual-system encryption proofs are sound under DLIN/SXDH assumptions; selective-to-full compilers via complexity leveraging require sub-exponential hardness.

**Community acceptance:** Widely trusted
Dual-system encryption (Waters 2009) is the canonical technique for full IBE/ABE security; universally cited in all modern ABE constructions.

---

## Meta-Reduction Technique

**Goal:** Prove that tight security reductions cannot exist for certain schemes. A meta-reduction is a second-level reduction: given any assumed reduction R from breaking scheme S to solving hard problem P, construct a meta-reducer that uses R as a black box to solve P directly — contradicting P's hardness if R is too efficient. Coron (2002) introduced the approach for RSA-FDH signatures.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Meta-reduction for RSA-FDH** | 2002 | Coron | Any black-box reduction from RSA-FDH to RSA inversion must lose factor ≥ q_s; tight reductions are impossible; first meta-reduction in cryptography; EUROCRYPT 2002 [[1]](https://link.springer.com/chapter/10.1007/3-540-46035-7_22) |
| **Corrected meta-reduction (Kakvi-Kiltz)** | 2012 | Kakvi–Kiltz | Fixed flaw in Coron's argument; proved tight impossibility for unique signature schemes; optimal FDH bound is q_s/e; Journal of Cryptology 2020 [[1]](https://link.springer.com/article/10.1007/s00145-019-09311-5) |
| **Impossibility of tight reductions (Bader et al.)** | 2015 | Bader–Jager–Li–Schäge | Meta-reduction framework for PKE and signatures; quantifies unavoidable security loss for a broad class of schemes; EUROCRYPT 2015 [[1]](https://eprint.iacr.org/2015/374) |
| **Meta-reduction for Schnorr** | 2016 | Fischlin–Fleischhacker | Any black-box reduction from Schnorr to DLog must lose factor q_h; Schnorr's reduction is essentially optimal [[1]](https://eprint.iacr.org/2013/418) |

**State of the art:** Kakvi-Kiltz (2012) and Bader-Jager-Li-Schäge (2015) are the canonical references. Meta-reductions guide parameter choices for deployed signature schemes. See [Concrete Security and Reduction Tightness](#concrete-security-and-reduction-tightness) and [Black-Box Separations](#black-box-separations).

**Production readiness:** Research
Meta-reductions are impossibility proof techniques; they guide parameter selection but are not deployed as software.

**Implementations:**
- No standalone implementations; meta-reductions are proof techniques used in security analyses of signature schemes and PKE.

**Security status:** Secure
Meta-reduction results are mathematically proven; they provide tight lower bounds on reduction loss for specific scheme classes.

**Community acceptance:** Widely trusted
Coron's meta-reduction (2002) and Kakvi-Kiltz's correction (2012) are standard references; meta-reductions are a routine tool in provable security research.

---

## Beyond-Birthday-Bound (BBB) Security

**Goal:** Achieve symmetric-key security beyond the 2^{n/2} birthday bound inherent to n-bit primitives. A standard n-bit block cipher is only guaranteed secure up to 2^{n/2} queries. BBB constructions achieve security up to nearly 2^n queries by using algebraic structure that prevents birthday collisions from being exploitable. Critical for AES-128 at cloud scale where 2^64 blocks are reachable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **XOR of two PRPs (XORP / Patarin H-coeff)** | 1995/2008 | Two independent PRP evaluations | XOR achieves 2^n tight security via H-coefficient/mirror-theory; Lucks (1995) proposed; Patarin proved tightness (2008) [[1]](https://eprint.iacr.org/2008/356) |
| **Sum of PRPs (SoP)** | 2001 | Bellare–Impagliazzo | Sum of two PRP outputs achieves BBB MAC security; O(2^{2n/3}) security [[1]](https://eprint.iacr.org/1999/024) |
| **EWCDM BBB MAC** | 2017 | Cogliati–Seurin | Encrypted Wegman-Carter with Davies-Meyer; nonce-based MAC with BBB security from AES [[1]](https://eprint.iacr.org/2015/975) |
| **AES-GCM-SIV** | 2017 | Gueron–Langley–Lindell | Nonce-misuse resistant AEAD with BBB-like multi-key security; deployed in BoringSSL / TLS [[1]](https://eprint.iacr.org/2017/168) |

**State of the art:** BBB security is a design criterion for AEAD modes at cloud scale. Patarin's H-coefficient / mirror-theory technique is the dominant proof method. AES-GCM-SIV is the primary deployed BBB-aware AEAD. See [Wegman-Carter-Shoup Authentication](#wegman-carter-shoup-authentication-and-information-theoretic-macs).

**Production readiness:** Production
AES-GCM-SIV is deployed in BoringSSL and Chrome; BBB MAC constructions are used in high-throughput TLS deployments where 2^64 block limits are reachable.

**Implementations:**
- [ring](https://github.com/briansmith/ring) ⭐ 4.1k — Rust, AES-GCM implementation (birthday-bound limited; motivates BBB alternatives)
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-GCM (users must respect birthday-bound query limits)
- [BoringSSL](https://github.com/Shay-Gueron/AES-GCM-SIV) ⭐ 120 — C, AES-GCM-SIV with BBB multi-key security

**Security status:** Secure
BBB constructions (XORP, SoP, EWCDM) are proven secure up to nearly 2^n queries; AES-GCM-SIV achieves nonce-misuse resistance with BBB-like multi-key bounds.

**Community acceptance:** Widely trusted
BBB security is an active design criterion in NIST and IETF; AES-GCM-SIV is standardized (RFC 8452). Patarin's H-coefficient technique is the standard proof method.

---

## ORAM Complexity and Lower Bounds

**Goal:** Characterise the fundamental communication overhead required to hide memory access patterns in oblivious RAM. Goldreich-Ostrovsky (1996) proved an Ω(log n) bandwidth lower bound for hiding access patterns on n-word memories. This bound was tight but only proven in restricted models; Larsen-Nielsen (2021) extended it to all ORAM schemes. The matching O(log n) construction (OptORAMa, 2021) resolved a 25-year open problem.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **ORAM definition + Ω(log n) lower bound** | 1996 | Goldreich–Ostrovsky | Introduced ORAM; balls-and-bins Ω(log n) lower bound; O(log^3 n) construction via hierarchical hashing [[1]](https://doi.org/10.1145/233551.233553) |
| **PathORAM** | 2013 | Stefanov–van Dijk–Shi et al. | Practical O(log n) amortized ORAM using a binary tree; dominant in implementations; CCS 2013 [[1]](https://eprint.iacr.org/2013/280) |
| **Ω(log n) lower bound (all models)** | 2021 | Larsen–Nielsen | Tight Ω(log n) lower bound for all ORAM schemes (not only balls-and-bins); closes the model gap [[1]](https://eprint.iacr.org/2020/1132) |
| **OptORAMa (optimal ORAM)** | 2021 | Asharov–Komargodski–Lin et al. | First O(log n) worst-case ORAM; matches the lower bound; uses AKS sorting network [[1]](https://dl.acm.org/doi/10.1145/3566049) |

**State of the art:** PathORAM (O(log n) amortized) is the standard practical ORAM used in SGX-based systems and MPC frameworks. OptORAMa (2021) is theoretically optimal but has large constants. See [Oblivious RAM](10-privacy-preserving-computation.md#oblivious-ram-oram).

**Production readiness:** Mature
PathORAM is implemented in SGX-based systems and MPC frameworks; OptORAMa is theoretically optimal but not yet practical due to large constants.

**Implementations:**
- [ZeroTrace](https://github.com/sshsshy/ZeroTrace) ⭐ 50 — C++, PathORAM for Intel SGX
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, MPC framework using ORAM for RAM-model computation
- [PathORAM](https://github.com/obliviousram/PathORAM) ⭐ 35 — Python, reference PathORAM implementation

**Security status:** Secure
Goldreich-Ostrovsky Omega(log n) lower bound is proven; PathORAM and OptORAMa meet it (amortized and worst-case respectively). No attacks below the proven bounds.

**Community acceptance:** Standard
PathORAM is the de facto standard ORAM in implementations; the Larsen-Nielsen (2021) tight lower bound and OptORAMa (2021) optimal construction resolved the major open problems.

---

## Worst-Case to Average-Case Reductions for Lattices

**Goal:** Prove that breaking a randomly generated lattice instance is as hard as solving lattice problems on every possible lattice. This unique property — absent from number-theoretic assumptions like factoring — gives lattice-based cryptography its distinctive security foundation: an attacker who breaks one random instance can solve the hardest instances.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Ajtai's SIS reduction** | 1996 | Ajtai | First worst-case/average-case link: breaking random SIS implies solving GapSVP on every lattice [[1]](https://doi.org/10.1145/237814.237838) |
| **LWE reduction (quantum)** | 2005 | Regev | Learning With Errors is as hard as worst-case SIVP/GapSVP via a quantum reduction [[1]](https://doi.org/10.1145/1060590.1060603) |
| **Classical LWE reduction** | 2009 | Peikert | Removes quantum from the LWE reduction for certain parameter ranges [[1]](https://doi.org/10.1145/1536414.1536461) |
| **Ring-LWE reduction** | 2010 | Lyubashevsky–Peikert–Regev | Worst-case hardness on ideal lattices; enables efficient Ring-LWE crypto [[1]](https://eprint.iacr.org/2012/230) |
| **Module-LWE reduction** | 2012 | Langlois–Stehlé | Generalises SIS/LWE to module lattices; underpins ML-KEM (Kyber) [[1]](https://eprint.iacr.org/2012/090) |

**State of the art:** Module-LWE/SIS reductions (Langlois-Stehlé 2012) underpin NIST PQC standards ML-KEM and ML-DSA. Ring-LWE remains efficient but with narrower worst-case guarantees. See [Foundational Primitives](01-foundational-primitives.md), [Quantum Cryptography](15-quantum-cryptography.md).

**Production readiness:** Production
Worst-case/average-case reductions are the theoretical foundation of ML-KEM (FIPS 203) and ML-DSA (FIPS 204), deployed in TLS, Chrome, and Signal.

**Implementations:**
- These are proof techniques, not standalone software. Schemes whose security relies on these reductions:
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM and ML-DSA (security from Module-LWE/SIS reductions)
- [pq-crystals](https://github.com/pq-crystals) — C, reference Kyber/Dilithium implementations

**Security status:** Secure
Worst-case to average-case reductions for LWE/SIS/Module-LWE are proven (quantum for LWE, classical for restricted parameters). No attacks violate the reduction-based security guarantees.

**Community acceptance:** Standard
These reductions are the primary reason NIST selected lattice-based schemes for PQC standardization; Regev's LWE reduction (2005) is one of the most influential results in modern cryptography.

---

## Forking Lemma and Rewinding Techniques

**Goal:** Extract secret keys from forged signatures by "rewinding" an adversary. The forking lemma shows that if an adversary forges a signature in the random oracle model with non-negligible probability, replaying it with a different random oracle yields a second forgery from which the secret can be recovered. This is the core proof technique for Schnorr, ECDSA, and many Fiat-Shamir-based schemes.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Pointcheval-Stern forking lemma** | 1996 | Pointcheval–Stern | Original lemma; proves security of ElGamal-type and Schnorr signatures in ROM [[1]](https://doi.org/10.1007/3-540-68339-9_34) |
| **General forking lemma** | 2006 | Bellare–Neven | Generalises to multi-signatures and arbitrary interactive proofs; tighter bounds [[1]](https://doi.org/10.1145/1180405.1180453) |
| **High-moment forking lemma** | 2023 | Diemert–Gellert–Jager–Lyu | Explicit high-moment bounds; tight multi-signature security for Schnorr [[1]](https://cic.iacr.org/p/1/2/2) |

**State of the art:** The general forking lemma (Bellare-Neven 2006) is the standard tool for ROM security proofs of discrete-log-based signatures. High-moment variants (2023) close tightness gaps for multi-signatures. See [Signatures (Advanced)](08-signatures-advanced.md).

**Production readiness:** Production
The forking lemma is the proof technique behind the security of Schnorr, ECDSA, EdDSA, and all Fiat-Shamir-based signature schemes deployed in TLS, SSH, and blockchains.

**Implementations:**
- The forking lemma is a proof technique, not standalone software. Signature schemes whose security proofs rely on it:
- [libsecp256k1](https://github.com/bitcoin-core/secp256k1) ⭐ 2.4k — C, ECDSA/Schnorr (security via forking lemma)
- [ed25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust, EdDSA (security via forking lemma)

**Security status:** Secure
The forking lemma is a proven mathematical result; its tightness bounds are well-characterized (Bellare-Neven 2006, Diemert et al. 2023).

**Community acceptance:** Standard
The Pointcheval-Stern (1996) and Bellare-Neven (2006) forking lemmas are universally cited in ROM security proofs of DLog-based signatures.

---

## Code-Based Game-Playing Proofs

**Goal:** Systematise cryptographic security proofs as disciplined transformations of pseudocode games. Each "hop" between games changes one small aspect; the sum of distinguishing advantages across hops bounds the adversary's total advantage. Eliminates the error-prone narrative style of earlier proofs.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Game-playing framework** | 2004 | Bellare–Rogaway | Foundational treatment: games as code, bad-event bounding, concrete applications (triple-DES, CBC-MAC) [[1]](https://eprint.iacr.org/2004/331) |
| **Sequence of Games (Shoup)** | 2004 | Shoup | Independent formalisation of game sequences; widely adopted notation [[1]](https://eprint.iacr.org/2004/332) |
| **CryptoVerif** | 2006 | Blanchet | Automated tool that mechanises game-based proofs in the computational model [[1]](https://doi.org/10.1007/11967668_14) |
| **EasyCrypt** | 2011 | Barthe et al. | Machine-checked game-based proofs using relational Hoare logic [[1]](https://doi.org/10.1007/978-3-642-22792-9_23) |

**State of the art:** Game-playing is the dominant proof methodology in symmetric and public-key cryptography. EasyCrypt and CryptoVerif provide machine-checked assurance. See [Automated Protocol Verification](19-theoretical-foundations.md#automated-protocol-verification-proverif-tamarin-easycrypt).

**Production readiness:** Production
Game-playing proofs are the standard methodology for all deployed cryptographic schemes; EasyCrypt and CryptoVerif provide machine-checked verification.

**Implementations:**
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, machine-checked game-based proofs
- [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/) — OCaml, automated game-hopping proofs

**Security status:** Secure
Game-playing is a proof methodology; its validity is unconditional. The Bellare-Rogaway and Shoup formalizations are mathematically rigorous.

**Community acceptance:** Standard
Game-playing is the dominant proof style in applied cryptography; Shoup's sequence-of-games (2004) and Bellare-Rogaway's code-based games (2004) are universally adopted.

---

## Quantum Random Oracle Model (QROM)

**Goal:** Extend the Random Oracle Model to quantum adversaries who can query the oracle in superposition. Classical ROM proofs often break when the adversary makes quantum queries (e.g., Grover search over the oracle), so new proof techniques are needed for post-quantum security.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Random Oracles in a Quantum World** | 2011 | Boneh–Dagdelen–Fischlin–Lehmann–Schaffner–Zhandry | Defines QROM; shows classical ROM proofs can fail; gives QROM-secure signatures [[1]](https://eprint.iacr.org/2010/428) |
| **Quantum-accessible ROM separation** | 2019 | Yamakawa–Zhandry | Constructs schemes secure in ROM but broken in QROM under standard assumptions [[1]](https://eprint.iacr.org/2020/1270) |
| **Measure-and-reprogram** | 2019 | Don–Fehr–Majenz–Schaffner | General QROM proof technique: measure one query, reprogram oracle; proves Fiat-Shamir secure in QROM [[1]](https://eprint.iacr.org/2019/498) |
| **Compressed oracle technique** | 2019 | Zhandry | Models quantum oracle access via compressed databases; simplifies QROM proofs [[1]](https://eprint.iacr.org/2018/544) |

**State of the art:** QROM proofs are now required for post-quantum confidence; NIST PQC standards (ML-KEM, ML-DSA) have QROM analyses. Measure-and-reprogram and compressed oracles are the main techniques. See [Random Oracle Model vs. Standard Model](#random-oracle-model-rom-vs-standard-model), [Quantum Cryptography](15-quantum-cryptography.md).

**Production readiness:** Production
QROM proofs are required for all NIST PQC standards (ML-KEM, ML-DSA, SLH-DSA); the Fujisaki-Okamoto transform's QROM analysis directly determines deployed key sizes.

**Implementations:**
- QROM is a proof model, not software. Schemes with QROM security analyses:
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM/ML-DSA with QROM-validated parameters
- [pq-crystals](https://github.com/pq-crystals) — C, Kyber/Dilithium reference implementations with QROM proofs

**Security status:** Caution
QROM proofs are strictly stronger than classical ROM proofs for post-quantum security; however, some classical ROM results do not transfer to QROM, and QROM tightness gaps affect parameter selection.

**Community acceptance:** Standard
QROM analysis is an explicit requirement in NIST's PQC evaluation criteria; all finalists provided QROM security arguments.

---

## Fine-Grained Cryptography

**Goal:** Build cryptographic primitives secure against adversaries bounded to a specific polynomial resource (e.g., NC1 circuits, AC0 circuits), where honest computation uses strictly fewer resources. Achieves unconditional or complexity-theoretic security without assuming one-way functions exist — useful in worlds where standard assumptions might fail.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Fine-Grained Cryptography** | 2016 | Degwekar–Vaikuntanathan–Vasudevan | OWFs, PRGs, CRHFs, PKE in NC1 secure against all poly-time; weak PRFs unconditionally secure vs AC0 [[1]](https://eprint.iacr.org/2016/580) |
| **Fine-Grained Crypto Revisited** | 2019 | Egashira–Wang–Tanaka | Adds OWPs, hash proof systems, trapdoor OWFs in the fine-grained setting [[1]](https://eprint.iacr.org/2019/1488) |
| **Fine-Grained Complexity Without Crypto** | 2025 | Ball–Dachman-Soled–Kulkarni | Studies what fine-grained hardness survives when OWFs do not exist (Pessiland) [[1]](https://eprint.iacr.org/2025/324) |

**State of the art:** Fine-grained crypto provides unconditional primitives (weak PRF vs AC0) and circuit-class-based PKE. Practically niche but theoretically important for understanding the minimal assumptions needed for cryptography. See [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds).

**Production readiness:** Research
Fine-grained cryptography is purely theoretical; no practical deployment exists due to the restricted adversary models and high overhead.

**Implementations:**
- No production implementations; academic constructions described in papers only.

**Security status:** Secure
Unconditional security against restricted adversary classes (AC0, NC1); security guarantees do not extend to general polynomial-time adversaries.

**Community acceptance:** Niche
Published at top venues (ITCS, CRYPTO); theoretically important for understanding minimal assumptions but not considered viable for deployment.

---

## One-Way Functions and Kolmogorov Complexity

**Goal:** Characterise the existence of one-way functions — the minimal assumption for almost all of cryptography — via the average-case hardness of a single natural problem: time-bounded Kolmogorov complexity (Kt). This identifies a "master problem" for cryptography: OWFs exist if and only if Kt is mildly hard on average.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **OWF ⟺ average-case Kt hardness** | 2020 | Liu–Pass | For every t(n) ≥ (1+ε)n, OWFs exist iff Kt is mildly hard on average [[1]](https://eprint.iacr.org/2020/423) |
| **Kt hardness and auxiliary input OWF** | 2021 | Liu–Pass | Extends characterisation to auxiliary-input OWFs via conditional Kt complexity [[1]](https://arxiv.org/abs/2009.11514) |
| **Interactive Kolmogorov and key agreement** | 2024 | Berman–Degwekar–Rothblum–Vasudevan | Worst-case hardness of interactive Kolmogorov complexity characterises key agreement [[1]](https://eprint.iacr.org/2024/425) |

**State of the art:** Liu-Pass (2020) is a landmark equivalence connecting Impagliazzo's five worlds to a single concrete problem. The interactive extension (2024) reaches into Cryptomania (public-key crypto). See [One-Way Functions and Impagliazzo's Five Worlds](#one-way-functions-and-impagliazzos-five-worlds).

**Production readiness:** Research
These are foundational complexity-theoretic results; they characterize when OWFs exist but are not deployed as software.

**Implementations:**
- No standalone implementations; these are theoretical equivalences between OWF existence and meta-complexity.

**Security status:** Secure
The Liu-Pass equivalence is a proven mathematical result; it provides the sharpest known characterization of OWF existence.

**Community acceptance:** Widely trusted
Liu-Pass (2020) is a landmark result in theoretical cryptography, published at FOCS and widely cited; it connects the foundations of cryptography to Kolmogorov complexity.

---

## Pseudorandom Correlation Generators (PCGs)

**Goal:** Allow two (or more) parties to locally expand short correlated seeds into long streams of correlated randomness (OT correlations, Beaver triples, VOLE) with no further interaction. Replaces the expensive online generation of MPC preprocessing material with a one-time short seed exchange followed by silent local computation.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **PCG for OT correlations** | 2019 | Boyle–Couteau–Gilboa–Ishai–Kohl–Scholl | First concretely efficient PCG; silent OT extension from LPN variants [[1]](https://eprint.iacr.org/2019/448) |
| **PCG from Ring-LPN** | 2020 | Boyle–Couteau–Gilboa–Ishai–Kohl–Scholl | Extends to VOLE and Beaver triples over large fields via Ring-LPN [[1]](https://eprint.iacr.org/2022/1035) |
| **PCG for any finite field** | 2025 | Bombar–Couteau–Ducros–Servan-Schreiber | PCGs for Beaver triples over arbitrary finite fields including F2 [[1]](https://eprint.iacr.org/2025/169) |

**State of the art:** PCGs based on Ring-LPN are the leading approach to silent MPC preprocessing. Actively deployed in VOLE-based ZK and MPC frameworks. See [Silent OT / PCG](06-multi-party-computation.md#silent-ot-pseudorandom-correlation-generators-pcg), [OLE / VOLE](06-multi-party-computation.md#oblivious-linear-evaluation-ole-vole).

**Production readiness:** Experimental
PCGs are implemented in research MPC frameworks (libOTe, MP-SPDZ); actively transitioning from research to production use in VOLE-based ZK systems.

**Implementations:**
- [libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, silent OT extension via PCGs from LPN
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, MPC framework with PCG-based preprocessing
- [EMP-toolkit](https://github.com/emp-toolkit) — C++, MPC toolkit with silent OT support

**Security status:** Secure
PCG security relies on LPN/Ring-LPN assumptions, which are well-studied; no known attacks at recommended parameters.

**Community acceptance:** Emerging
PCGs are a rapidly growing area with strong adoption in the MPC research community; Boyle-Couteau-Gilboa-Ishai-Kohl-Scholl (2019) is already a standard reference.

---

## Gentry-Wichs Barrier (Non-Falsifiability of SNARGs)

**Goal:** Prove a fundamental impossibility: adaptively sound succinct non-interactive arguments (SNARGs) for hard-on-average NP languages cannot be proven secure via black-box reduction to any falsifiable assumption. This explains why all known SNARK constructions rely on knowledge-type (non-falsifiable) assumptions or idealised models like the random oracle.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Gentry-Wichs impossibility** | 2011 | Gentry–Wichs | SNARGs for hard NP languages require non-falsifiable assumptions [[1]](https://eprint.iacr.org/2010/610) |
| **Gentry-Wichs is tight** | 2021 | Waters–Wu | Constructs a non-adaptively sound SNARG from falsifiable assumptions, showing the barrier is tight [[1]](https://eprint.iacr.org/2019/1386) |
| **Impossibility with preprocessing** | 2022 | Campanelli–Fiore–Querol | Extends impossibility to the preprocessing model; black-box extraction also impossible for adaptive SNARGs [[1]](https://eprint.iacr.org/2022/638) |

**State of the art:** The Gentry-Wichs barrier (2011) remains the central theoretical explanation for why practical SNARKs (Groth16, Plonk, etc.) rely on knowledge assumptions or the ROM. Waters-Wu (2021) shows the bound is essentially tight. See [Knowledge-Soundness, Extractability](19-theoretical-foundations.md#knowledge-soundness-extractability-and-simulation-extractability), [ZK Proof Systems](04-zero-knowledge-proof-systems.md).

**Production readiness:** Research
The Gentry-Wichs barrier is an impossibility result; it explains why deployed SNARKs must use non-falsifiable assumptions or the ROM but is not itself deployed.

**Implementations:**
- No standalone implementations; the barrier is a proof-theoretic impossibility result.

**Security status:** Secure
The impossibility result is mathematically proven; it is a fundamental constraint on SNARG constructions, not an attack.

**Community acceptance:** Standard
Gentry-Wichs (2011) is universally cited when justifying the use of knowledge assumptions in SNARKs; it is a landmark result in the foundations of zero-knowledge.

---

## Communication Complexity of Secure Computation

**Goal:** Determine the minimum bits that must be exchanged to securely evaluate a function, even with unlimited computation. These lower bounds are information-theoretic and show that secure computation inherently costs more communication than insecure computation for many functions.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **Franklin-Yung communication bounds** | 1992 | Franklin–Yung | First communication complexity study of secure computation; shows overhead is inherent [[1]](https://doi.org/10.1145/129712.129780) |
| **Data-processing for residual information** | 2014 | Data–Prabhakaran–Prabhakaran | New information-theoretic tools; tight bounds for specific functions using residual information [[1]](https://eprint.iacr.org/2015/391) |
| **Randomness and communication lower bounds** | 2016 | Data–Prabhakaran–Prabhakaran | Unified framework: joint lower bounds on communication and correlated randomness for IT-secure MPC [[1]](https://ieeexplore.ieee.org/document/7469867/) |
| **OT complexity of MPC** | 2017 | Agrawal–Prabhakaran–Prabhakaran | Connects OT-hybrid communication cost to combinatorial properties of the function [[1]](https://link.springer.com/chapter/10.1007/978-3-319-63688-7_14) |

**State of the art:** Information-theoretic lower bounds (2014-2017) using residual information and distribution switching provide the tightest known results. Active area connecting information theory and MPC. See [Multi-Party Computation](06-multi-party-computation.md).

**Production readiness:** Research
Communication complexity lower bounds are theoretical results; they guide MPC protocol design but are not deployed as software.

**Implementations:**
- No standalone implementations; these are information-theoretic lower bounds used in the analysis of MPC protocols.

**Security status:** Secure
The lower bounds are information-theoretic and unconditionally proven; they constrain what is achievable regardless of computational assumptions.

**Community acceptance:** Niche
Well-established in the information-theoretic MPC community; Data-Prabhakaran-Prabhakaran (2014-2016) are standard references for communication complexity of secure computation.

---

## Game-Based vs. Simulation-Based Security Paradigms

**Goal:** Establish two complementary frameworks — game-based (winning a probabilistic challenge) and simulation-based (real/ideal indistinguishability) — for formally proving what cryptographic schemes guarantee.

| Concept | Year | Basis | Note |
|---------|------|-------|------|
| **Game-based (Bellare-Rogaway)** | 1990s | IND-CPA, EUF-CMA, etc. | Concrete, engineer-friendly; standard in NIST/IETF [[1]](http://bristolcrypto.blogspot.com/2015/05/52-things-number-32-difference-between.html) |
| **Simulation-based (Goldreich et al.)** | 1990s | Real/ideal paradigm | Richer composition guarantees but harder to apply [[1]](https://www.wisdom.weizmann.ac.il/~oded/PSBookFrag/SimProof.pdf) |

**State of the art:** Every deployed cryptographic security proof uses one or both paradigms. Understanding where they diverge is critical: a game-based secure scheme can leak in a compositional setting.

**Production readiness:** Production
Both paradigms are used in the security analysis of all deployed protocols: game-based for standalone primitives (AES, RSA, ECDSA), simulation-based for composed protocols (MPC, MLS, OT).

**Implementations:**
- These are definitional frameworks, not software. Tools supporting both paradigms:
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, supports both game-based and simulation-based proofs

**Security status:** Secure
Both paradigms are mathematically well-defined; their relationship is precisely characterized (IND does not imply SIM under adaptive corruptions).

**Community acceptance:** Standard
Both paradigms are universally accepted; game-based dominates for standalone primitives, simulation-based for composable protocols.

---

## Algebraic Group Model (AGM)

**Goal:** Restrict adversaries to algebraic operations on group elements, yielding a model intermediate between standard model and Generic Group Model that produces tighter and more credible security reductions.

| Concept | Year | Basis | Note |
|---------|------|-------|------|
| **AGM (Fuchsbauer-Kiltz-Loss)** | 2018 | Algebraic adversary restriction | CDH → DL tight reduction; validates BLS signature parameters; CRYPTO 2018 [[1]](https://eprint.iacr.org/2017/620) |

**State of the art:** Directly impacts key size decisions for BLS (Ethereum 2.0, Zcash), VDFs, and SNARKs. Fills the gap between too-idealized GGM and too-restrictive standard model.

**Production readiness:** Production
AGM proofs validate BLS signatures (Ethereum 2.0) and Groth16 (Zcash); AGM-derived tight reductions directly determine deployed key sizes.

**Implementations:**
- AGM is a proof model, not software. Libraries whose security relies on AGM analysis:
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/assembly, BLS12-381 (AGM-proven tight security)
- [arkworks-rs](https://github.com/arkworks-rs) — Rust, pairing-based crypto with AGM-validated parameters

**Security status:** Secure
AGM is an intermediate model between standard model and GGM; its assumptions are well-understood and no inconsistencies have been found.

**Community acceptance:** Widely trusted
AGM (Fuchsbauer-Kiltz-Loss 2018) is rapidly becoming the standard for pairing-based security proofs; widely cited and used in Ethereum and Zcash parameter justification.

---

## Memory-Hard Functions (MHF) — Formal Theory

**Goal:** Define and construct functions whose time-space product for evaluation is provably large regardless of attacker strategy, guaranteeing hardware-optimized brute-force costs proportionally more.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **scrypt (Percival)** | 2009 | Sequential memory-hard | First practical MHF; targets password hashing [[1]](https://www.tarsnap.com/scrypt.html) |
| **Argon2 (RFC 9106)** | 2015/2021 | Data-dependent/independent modes | NIST-recommended; Argon2id with 2 GiB for side-channel + brute-force resistance [[1]](https://datatracker.ietf.org/doc/rfc9106/) |
| **Pebbling model formalization** | 2015+ | Alwen-Serbinenko | Provable sequential space-hardness; enables meaningful parameter selection [[1]](https://eprint.iacr.org/2016/115) |

**State of the art:** Argon2id is the recommended password hashing standard. MHF theory also underlies PoW schemes (Equihash in Zcash, Ethash). bcrypt/PBKDF2 lack provable memory-hardness.

**Production readiness:** Production
Argon2id (RFC 9106) is the NIST-recommended password hashing standard; scrypt is deployed in cryptocurrency (Litecoin) and backup systems (Tarsnap).

**Implementations:**
- [argon2](https://github.com/P-H-C/phc-winner-argon2) ⭐ 5.2k — C, reference Argon2 implementation (PHC winner)
- [scrypt](https://github.com/Tarsnap/scrypt) ⭐ 509 — C, reference scrypt implementation
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, includes Argon2id for password hashing

**Security status:** Secure
Argon2id is provably memory-hard under the pebbling model (Alwen-Serbinenko); no known attacks below the proven time-space bounds at recommended parameters.

**Community acceptance:** Standard
Argon2 won the Password Hashing Competition (2015) and is recommended by NIST, OWASP, and IETF (RFC 9106). MHF theory is well-established in the pebbling complexity community.

---
