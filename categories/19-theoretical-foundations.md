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

**State of the art:** UC is the canonical composition framework for [MPC](categories/06-multi-party-computation.md#multi-party-computation-mpc), [CGKA/MLS](categories/12-secure-communication-protocols.md#cgkamls), and [OT](categories/06-multi-party-computation.md#oblivious-transfer-ot). Simulation-based security is the language of the UC model; game-based definitions (IND-CPA, etc.) remain preferred for standalone primitives.

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

---

## Black-Box Separations

**Goal:** Prove that certain cryptographic primitives cannot be constructed from weaker ones via black-box reductions. A black-box separation shows — typically via a relativizing oracle argument — that no efficient algorithm can build primitive B from primitive A using only A's input/output interface, regardless of which specific A is chosen. These results delineate the "cryptographic primitive hierarchy" and prevent futile proof attempts.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **OWF ↛ key agreement** | 1989 | Impagliazzo–Rudich | Oracle world where OWFs exist but no key exchange protocol is secure; foundational separation result [[1]](https://doi.org/10.1145/73007.73012) |
| **OWP ↛ collision-resistant hash** | 1998 | Simon | One-way permutations do not black-box imply collision-resistant hash functions [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_23) |
| **RTV framework** | 2004 | Reingold–Trevisan–Vadhan | Unified framework classifying black-box reductions: fully / semi / non-black-box; systematic catalogue of separations [[1]](https://eprint.iacr.org/2004/049) |
| **Non-black-box techniques** | 2001 | Barak | Non-black-box simulation circumvents some separations for ZK; demonstrates limits of oracle-based lower bounds (see [Non-Black-Box ZK](#non-black-box-zero-knowledge--concurrent-zk)) [[1]](https://doi.org/10.1109/SFCS.2001.959902) |
| **BB-uselessness composability** | 2021 | Couteau–Hartmann | Black-box uselessness composes: two BB-useless primitives cannot be combined to yield a useful one [[1]](https://eprint.iacr.org/2021/016) |

**State of the art:** The Impagliazzo-Rudich oracle argument and the RTV taxonomy (2004) remain the standard tools. Non-black-box constructions (Barak, Bitansky-Paneth) partially circumvent these barriers for specific tasks (ZK, SNARGs) but not for key exchange or OT. Active area: non-black-box separations for PKE from OWF.

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

**State of the art:** Concrete security analysis is mandatory for standards work — NIST PQC submissions were evaluated in part on tightness of their security reductions. Almost-tight reductions are the practical goal when perfectly tight ones are impossible. See [Semantic Security and IND-CPA / IND-CCA Security](#semantic-security-and-ind-cpa--ind-cca-security) and [Random Oracle Model](#random-oracle-model-rom-vs-standard-model).
