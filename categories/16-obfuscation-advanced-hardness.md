# Obfuscation & Advanced Hardness Assumptions

## Indistinguishability Obfuscation (iO)

**Goal:** Maximum software protection. Make a program "unintelligible" while preserving its input/output behavior. Theoretical "crypto-complete" primitive: iO + one-way functions → almost any cryptographic primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH+SW13 (first candidate)** | 2013 | Multilinear maps | First iO candidate construction; broken/patched repeatedly [[1]](https://eprint.iacr.org/2013/451) |
| **Jain-Lin-Sahai** | 2021 | LWE + LPN + PRG assumptions | First iO from well-studied assumptions; breakthrough [[1]](https://eprint.iacr.org/2020/1003) |
| **Witness Encryption (GGSW)** | 2013 | Multilinear maps / iO | Encrypt to an NP statement; decrypt with witness [[1]](https://eprint.iacr.org/2013/258) |

**State of the art:** Jain-Lin-Sahai (2021) — theoretical milestone; iO remains impractical but is the "holy grail" of crypto.

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

## Batch Arguments (BARG) / Accumulation Schemes

**Goal:** Efficient batch verification. Prove many statements simultaneously with a proof shorter than proving each individually. Used in blockchain rollups and recursive proof composition.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BARG (Choudhuri et al.)** | 2021 | LWE + RAM SNARKs | Batch NP statements with poly-size proof [[1]](https://eprint.iacr.org/2021/1423) |
| **Accumulation Schemes (Bünz et al.)** | 2020 | IPA / polynomial commitment | Accumulate proofs incrementally; used in Halo 2 [[1]](https://eprint.iacr.org/2020/499) |
| **ProtoStar** | 2023 | IVC + accumulation | Generic accumulation for PLONK-like systems [[1]](https://eprint.iacr.org/2023/620) |

**State of the art:** ProtoStar (modern folding/accumulation), BARG from LWE (theoretical breakthrough).

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

## Dual-Mode Cryptosystems

**Goal:** UC-secure encryption. A cryptosystem with two indistinguishable CRS modes: *messy mode* (statistically hiding — encryption hides bit perfectly) and *decryption mode* (statistically binding — only one decryption). Enables UC-secure OT, commitments, and ZK.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Peikert-Vaikuntanathan-Waters Dual-Mode** | 2008 | DDH / QR / LWE | First dual-mode encryption; implies UC-secure OT in CRS model [[1]](https://eprint.iacr.org/2008/009) |
| **Dual-Mode from LWE** | 2008 | LWE | Lattice instantiation; post-quantum UC-secure OT [[1]](https://eprint.iacr.org/2008/009) |
| **Dual-Mode Commitments** | 2011 | DDH / LWE | Extension to commitments: perfectly hiding or perfectly binding modes [[1]](https://eprint.iacr.org/2011/010) |

**State of the art:** LWE-based dual-mode (PQ-secure); foundation of UC-secure [OT](#oblivious-transfer-ot) and [Non-Committing Encryption](#non-committing-encryption).

---

## Spooky Encryption

**Goal:** Non-interactive homomorphic computation across independent ciphertexts. Two parties independently encrypt messages m₁, m₂ under separate keys. A third party (without decryption keys) transforms the ciphertexts so that decryption yields shares of f(m₁, m₂) — without any interaction between the parties.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Halevi-Rothblum-Wichs Spooky Enc** | 2016 | LWE | First spooky encryption; entangle independent ciphertexts; yields 2PC without interaction [[1]](https://eprint.iacr.org/2016/272) |
| **Spooky Enc for General Functions** | 2016 | LWE + circular security | Extend to any efficiently computable function f [[1]](https://eprint.iacr.org/2016/272) |

**State of the art:** LWE-based spooky encryption (2016); implies non-interactive MPC in a new model. Related to [Multi-Key FHE](#multi-key--threshold-fhe) and [MPC](#multi-party-computation-mpc).

---

## Point Function Obfuscation / Digital Locker

**Goal:** Obfuscate a "password check." Create a program that outputs a secret s when given input x, and outputs ⊥ on all other inputs — but the program reveals nothing about x or s. The one case where VBB (virtual black-box) obfuscation is achievable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti Point Obfuscation** | 1997 | Random oracle | First point obfuscation; VBB-secure in ROM [[1]](https://doi.org/10.1145/258533.258553) |
| **Wee Point Obfuscation (std model)** | 2005 | Strong DDH variant | Point obfuscation under strong assumptions without RO [[1]](https://doi.org/10.1145/1060590.1060669) |
| **Lockable Obfuscation (Goyal et al.)** | 2017 | LWE | Obfuscate program that outputs message iff input matches "lock"; from lattices [[1]](https://eprint.iacr.org/2017/274) |
| **Compute-and-Compare Obfuscation** | 2017 | LWE | Generalize point obfuscation: output s iff f(x) = target; from LWE [[1]](https://eprint.iacr.org/2017/276) |

**State of the art:** Lockable obfuscation from LWE (2017); implies point obfuscation, lockable encryption, and more. Relates to [iO](#indistinguishability-obfuscation-io) as the achievable fragment of program obfuscation.

---

## VBB Obfuscation Impossibility

**Goal:** Establish limits of program obfuscation. Virtual Black-Box (VBB) obfuscation would turn any program into an "unintelligible" equivalent that reveals only what oracle access to the original would reveal. The seminal Barak et al. (2001) result proves that general-purpose VBB obfuscation is impossible, motivating the shift to weaker (but useful) notions such as iO.

| Result | Year | Authors | Note |
|--------|------|---------|------|
| **VBB Impossibility (BGI+)** | 2001 | Barak, Goldreich, Impagliazzo, Rudich, Sahai, Vadhan, Yang | Constructs an unobfuscatable circuit family; no efficient obfuscator can hide all properties [[1]](https://eprint.iacr.org/2001/069) |
| **VBB Impossibility extended** | 2001 | Same | Extends to approximate obfuscators, non-uniform, and TC⁰ circuits; positive result: point functions and simple pseudo-random functions can be VBB-obfuscated [[1]](https://eprint.iacr.org/2001/069) |
| **VBB Impossibility in idealized models** | 2016 | Asharov, Segev | Extends impossibility to random oracle and generic group models, ruling out black-box proofs of VBB obfuscation [[1]](https://eprint.iacr.org/2015/632.pdf) |
| **VBB Impossibility with graded encodings** | 2016 | Garg, Gentry, Halevi, Wichs | Shows VBB obfuscation impossible even using ideal constant-degree graded encoding schemes [[1]](https://link.springer.com/chapter/10.1007/978-3-662-49096-9_1) |

**State of the art:** Definitively impossible in general (2001); the impossibility proof is constructive and extends broadly. The field pivoted to [iO](#indistinguishability-obfuscation-io) (indistinguishability obfuscation) and [point function obfuscation](#point-function-obfuscation--digital-locker) as the achievable cases.

---

## Differing-Inputs Obfuscation (diO)

**Goal:** Stronger obfuscation than iO but weaker than VBB. A differing-inputs obfuscator (diO) guarantees that obfuscations of two circuits are indistinguishable not only when the circuits are functionally equivalent, but also when it is computationally hard to find any input on which their outputs differ. This gives stronger security for applications such as succinct functional encryption and Turing machine obfuscation — but the general notion (with auxiliary input) was shown implausible.

| Scheme / Result | Year | Note |
|-----------------|------|------|
| **diO definition and applications (ABGSZ)** | 2013 | Introduced by Ananth, Boneh, Garg, Sahai, Zhandry; applications to succinct iO and FE for Turing machines [[1]](https://ntt-research.com/wp-content/uploads/2022/08/Differing-inputs-obfuscation-and-applications.pdf) |
| **Implausibility of diO with aux input (Boyle-Pass)** | 2013 | Boyle and Pass show general-purpose diO with arbitrary auxiliary input implies the obfuscation of a specific circuit family, which is itself implausible [[1]](https://eprint.iacr.org/2013/860) |
| **Implausibility via extractable WE (GGHW)** | 2014 | Garg, Gentry, Halevi, Wichs show diO with aux input also implies implausible extractable witness encryption [[1]](https://link.springer.com/chapter/10.1007/978-3-662-44371-2_29) |
| **Public-coin diO (BCP)** | 2015 | Retreats to a restricted variant where aux input is a public random string; retains useful applications while avoiding known impossibilities [[1]](https://eprint.iacr.org/2014/942.pdf) |
| **Candidate diO from iO + aux-input point obfuscation** | 2018 | Construct candidate diO for the restricted case; relies on iO and auxiliary-input point obfuscation [[1]](https://eprint.iacr.org/2018/1055) |

**State of the art:** General diO (with aux input) is considered implausible; public-coin diO remains viable for restricted applications. The gap between [iO](#indistinguishability-obfuscation-io) and [VBB obfuscation](#vbb-obfuscation-impossibility) is large, and diO occupies an important — if fragile — middle ground.

---

## Evasive LWE & Tensor LWE

**Goal:** Post-quantum hardness for advanced primitives. Evasive LWE and tensor LWE are new lattice-based hardness assumptions introduced to sidestep the limitations of standard LWE for constructing optimal broadcast encryption, ciphertext-policy ABE, witness encryption, and null-iO — without relying on multilinear maps or iO. They assert that certain structured LWE samples remain hard to distinguish even when the adversary receives additional trapdoor-related information.

| Assumption / Scheme | Year | Note |
|---------------------|------|------|
| **Evasive LWE — Wee (Eurocrypt 2022)** | 2022 | Introduced for optimal broadcast encryption and CP-ABE for bounded-depth circuits with parameter sizes poly(log N); first plausibly post-quantum optimal broadcast encryption [[1]](https://eprint.iacr.org/2023/906) |
| **Tensor LWE — Wee / Tsabary (2022)** | 2022 | Companion assumption introduced simultaneously; used for constant-input ABE and predicate encryption from lattices [[1]](https://eprint.iacr.org/2023/941) |
| **Witness Encryption and null-iO from Evasive LWE** | 2022 | Vaikuntanathan et al. show evasive LWE implies witness encryption and null-iO, strengthening the connection to obfuscation [[1]](https://eprint.iacr.org/2022/1140) |
| **Counterexamples to private-coin variants** | 2024 | Definitions, classes, and counterexamples established; several private-coin formulations shown false via "zeroizing"-style attacks, narrowing the valid assumption landscape [[1]](https://eprint.iacr.org/2024/2000) |

**State of the art:** Public-coin evasive LWE remains a leading assumption for post-quantum advanced primitives (2022–2024); private-coin variants face counterexamples. Closely related to [multilinear maps](#multilinear-maps) (which it aims to replace) and [witness encryption](#witness-encryption).

---

## Average-Case Hardness & Planted Problems

**Goal:** Cryptography from statistical hardness. Standard worst-case hardness assumptions (LWE, SIS, DDH) guarantee hardness on some instances. Average-case assumptions assert hardness on *most* instances from an explicit distribution — a stronger requirement needed when the cryptographic scheme itself must generate hard instances. The planted clique problem and planted random graph problems are the canonical examples and underpin constructions of public-key encryption and secret sharing from fine-grained complexity.

| Problem / Scheme | Year | Note |
|-----------------|------|------|
| **Planted Clique conjecture** | 1992 | Karp conjectured that finding a planted clique of size k = O(√n) in G(n, 1/2) is hard; widely used as a hardness assumption in statistics and algorithms [[1]](https://en.wikipedia.org/wiki/Planted_clique) |
| **Cryptography from planted clique (Juels-Peinado)** | 1997 | Early use of planted clique hardness for cryptographic constructions [[1]](https://eprint.iacr.org/2025/1501.pdf) |
| **Cryptography from Planted Graphs (Abram et al.)** | 2023 | Constructs PKE and secret sharing from the planted clique conjecture with logarithmic-size messages; first clean PKE from a graph-theoretic average-case assumption [[1]](https://eprint.iacr.org/2023/1929.pdf) |
| **PKE from Planted Clique and Noisy k-LIN (STOC 2025)** | 2025 | New construction of PKE from the planted clique conjecture combined with noisy k-linearity over expanders; strengthens the case for planted clique as a crypto hardness base [[1]](https://dl.acm.org/doi/10.1145/3717823.3718306) |

**State of the art:** Planted clique is a clean average-case assumption with growing cryptographic applications; hardness is supported by failure of spectral, SDP, and statistical-query algorithms up to clique size O(√n). Complements [theoretical foundations](categories/19-theoretical-foundations.md) on leakage-resilient and circular-security assumptions.

---

## Bootstrapping iO: Functional Encryption → iO

**Goal:** Establish the foundational equivalence between indistinguishability obfuscation and functional encryption. A single-key, compact functional encryption (FE) scheme — one where the encryption circuit runs in time polynomial in the input length, independent of the function's description size — is sufficient to generically bootstrap full iO for all circuits. This 2015 equivalence (proved independently by two groups) revealed FE as the minimal assumption needed for iO and anchored subsequent "from well-founded assumptions" constructions.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Bitansky-Vaikuntanathan FE → iO** | 2015 | Sub-exp single-key compact FE | Independently show sub-exp secure compact FE implies iO; establishes equivalence up to sub-exponential security loss [[1]](https://eprint.iacr.org/2015/163) |
| **Ananth-Jain FE → iO (CRYPTO 2015)** | 2015 | Single-key compact FE for NC¹ | Construct iO for all circuits from any single-key FE for NC¹ that is selectively secure against sub-exp adversaries and has compact encryption [[1]](https://eprint.iacr.org/2015/173) |
| **FE → iO via garbling (Ananth et al.)** | 2016 | Single-key FE + garbled circuits | Simplify the reduction by combining FE with Yao garbling; FE for NC¹ suffices rather than FE for all circuits [[1]](https://eprint.iacr.org/2015/730) |
| **When does FE imply iO? (Agrikola et al.)** | 2017 | FE compactness characterizations | Characterize exactly which compactness conditions on FE are necessary and sufficient to bootstrap iO [[1]](https://eprint.iacr.org/2017/943) |

**State of the art:** The FE ↔ iO equivalence is now a cornerstone result: building FE from well-studied assumptions (e.g., LWE, bilinear maps) is the main route to iO, exploited by Jain-Lin-Sahai (2021). Relates to [iO](#indistinguishability-obfuscation-io), [multilinear maps](#multilinear-maps), and [functional encryption](categories/07-homomorphic-functional-encryption.md#attribute-based--functional-encryption-abe--fe).

---

## Hyperplane Membership Obfuscation

**Goal:** VBB obfuscation for algebraic membership tests. Obfuscate a program that, given an input vector **v**, tests whether **v** lies on a fixed secret hyperplane (or affine subspace) over a finite field — and outputs only a single bit. Unlike point functions (single secret input), hyperplane membership is a richer algebraic predicate, and achieving VBB security requires stronger assumptions. This is one of the few families of non-trivial programs for which virtual black-box obfuscation is achievable.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Canetti-Rothblum-Varia hyperplane obfuscation** | 2010 | Strong DDH variant | First VBB obfuscation for hyperplane membership of constant dimension over a finite field; application to signatures [[1]](https://link.springer.com/chapter/10.1007/978-3-642-11799-2_5) |
| **Barak et al. hypersurface obfuscation** | 2014 | Multilinear maps | Extends VBB obfuscation from hyperplanes to bounded-degree algebraic hypersurfaces using graded encoding schemes [[1]](https://eprint.iacr.org/2013/451) |
| **Obfuscation of evasive algebraic set membership** | 2024 | Pairing-based / DDH | Further generalizes to obfuscating membership in evasive algebraic sets; provides updated constructions and security analysis [[1]](https://www.aimsciences.org//article/doi/10.3934/amc.2024014) |

**State of the art:** Canetti-Rothblum-Varia (2010) remains the canonical VBB construction for hyperplane membership; security relies on a strong DDH variant rather than multilinear maps. Complements [point function obfuscation](#point-function-obfuscation--digital-locker) as the next step in the hierarchy of achievable VBB obfuscation.

---

## Null iO (Obfuscation for Always-Zero Circuits)

**Goal:** A weakening of iO applicable to circuits that always output 0. Null iO guarantees that any two circuits computing the constant-zero function have computationally indistinguishable obfuscations — even if the circuits have very different structure. Null iO is weaker than full iO but already implies non-trivial witness encryption and compute-and-compare obfuscation, and it can be constructed from LWE without multilinear maps.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Non-trivial WE and null-iO from standard assumptions** | 2017 | LWE + evasive assumptions | Show that compute-and-compare obfuscation (Wichs-Zirdelis) implies non-trivial WE and null-iO; first null-iO candidate from standard-like lattice assumptions [[1]](https://eprint.iacr.org/2017/874) |
| **Null-iO from LWE via compute-and-compare (Wichs-Zirdelis)** | 2017 | LWE | Obfuscate compute-and-compare programs under LWE using a restricted use of GGH15 graph-induced maps provably secure under LWE; implies null-iO [[1]](https://eprint.iacr.org/2017/276) |
| **Null-iO from evasive LWE (Vaikuntanathan et al.)** | 2022 | Evasive LWE | Show that evasive LWE directly implies null-iO and non-trivial witness encryption; cleaner construction than GGH15-based approaches [[1]](https://eprint.iacr.org/2022/1140) |
| **Quantum null-iO** | 2021 | Quantum iO assumptions | Extends null-iO to quantum circuits; implies WE for QMA, NIZK for QMA, and ABE for BQP [[1]](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2022.15) |

**State of the art:** Null-iO is achievable from LWE-based assumptions (evasive LWE, 2022) and from compute-and-compare obfuscation (2017). It serves as a stepping stone between [witness encryption](#witness-encryption) and full [iO](#indistinguishability-obfuscation-io), and is closely linked to [evasive LWE](#evasive-lwe--tensor-lwe) and [point function obfuscation](#point-function-obfuscation--digital-locker).

---

## Zeroizing Attacks on Multilinear Maps

**Goal:** Document the systematic cryptanalysis of all known multilinear map candidates. Zeroizing attacks exploit the ability to obtain encodings of zero at the target level: from such zero-encodings, attackers can perform algebraic manipulations that recover secret parameters or break semantic security. All three major candidates — GGH13, CLT13, and GGH15 — have been broken in various settings by zeroizing and annihilation attacks, motivating the move to assumption-based iO (Jain-Lin-Sahai 2021) that avoids multilinear maps entirely.

| Attack / Result | Year | Target | Note |
|-----------------|------|--------|------|
| **Hu-Jia zeroizing attack on GGH13** | 2016 | GGH13 | Break the natural one-round k-partite key agreement built on GGH13; exploits low-level encodings of zero [[1]](https://eprint.iacr.org/2015/546) |
| **Cheon et al. attack on CLT13** | 2015 | CLT13 | Total break of CLT13: all secret parameters are efficiently recoverable via zeroizing; the integer-based construction provides no resistance [[1]](https://link.springer.com/chapter/10.1007/978-3-662-46800-5_1) |
| **Miles-Sahai-Zhandry annihilation attacks** | 2016 | GGH13 iO | Extend beyond zeroizing to non-linear annihilation attacks; break iO candidates built on GGH13 even without encodings of zero [[1]](https://eprint.iacr.org/2016/147) |
| **Cryptanalysis of GGH15** | 2016 | GGH15 | Zeroizing attacks on GGH15-based iO and multilinear maps; graph-induced structure does not prevent leakage [[1]](https://link.springer.com/chapter/10.1007/978-3-662-53008-5_21) |
| **Return of GGH15 (provable security)** | 2018 | GGH15 | Restricted re-use of GGH15 with provable security against zeroizing attacks under LWE; enables compute-and-compare obfuscation [[1]](https://eprint.iacr.org/2018/511) |
| **New CLT multilinear map (CLT15)** | 2015 | CLT follow-up | Coron-Lepoint-Tibouchi propose a revised integer-based construction at CRYPTO 2015; also broken by subsequent zeroizing attacks [[1]](https://eprint.iacr.org/2015/975) |

**State of the art:** No multilinear map candidate is considered secure for general use as of 2024; restricted usage (e.g., GGH15 for compute-and-compare under LWE) remains viable. The failure of all candidates directly motivated the [Jain-Lin-Sahai iO](#indistinguishability-obfuscation-io) construction, which avoids graded encodings entirely. See also [multilinear maps](#multilinear-maps) and [evasive LWE](#evasive-lwe--tensor-lwe).

---

## Constrained Pseudorandom Functions (CPRF)

**Goal:** Delegation of PRF evaluation on a subset of inputs. A constrained PRF allows a master key holder to derive a *constrained key* that evaluates the PRF only on inputs satisfying a predicate C (e.g., a prefix, a range, or an arbitrary circuit), while revealing nothing about PRF values on other inputs. CPRFs generalise punctured PRFs (single-point constraint) and are the key tool for building attribute-based encryption, non-interactive key exchange, and verifiable random functions for structured input spaces.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BW13 CPRF (prefix constraints)** | 2013 | PRF + GGH multilinear maps | Boneh-Waters introduce CPRFs and construct them for bit-fixing, prefix, and NC¹ predicates; first general CPRF definition [[1]](https://eprint.iacr.org/2013/352) |
| **KPTZ13 CPRF (punctured PRFs)** | 2013 | GGM tree + OWF | Kiayias-Papadopoulos-Triandopoulos-Zacharias independently define and build punctured PRFs (single-point CPRFs) for use in e-cash [[1]](https://eprint.iacr.org/2013/379) |
| **SW14 puncturable PRF** | 2014 | GGM + PRG | Sahai-Waters give a clean puncturable PRF construction used to prove security of iO-based PKE; single-point constraint from OWF only [[1]](https://eprint.iacr.org/2014/539) |
| **CPRF for circuits from iO (BW13)** | 2013 | iO + injective OWF | Constrain on arbitrary circuit predicates using iO; implies ABE, NIKE for bounded parties [[1]](https://eprint.iacr.org/2013/352) |
| **Lattice CPRF for inner-product (BTVW17)** | 2017 | LWE | Banerjee-Fuchsbauer-Peikert-Pietrzak-Wolf construct CPRFs for inner-product predicates from LWE without iO; first post-quantum CPRF for non-trivial class [[1]](https://eprint.iacr.org/2017/004) |
| **Constrained VRF (BCKL2023)** | 2023 | Bilinear maps | Constrained verifiable random functions: delegatable PRF with public verifiability of constrained outputs [[1]](https://eprint.iacr.org/2023/119) |

**State of the art:** Punctured PRFs (single-point CPRFs) are constructible from any OWF via GGM; general-circuit CPRFs require iO or are built from LWE for specific function classes (inner product, NC¹). CPRFs underpin [iO](#indistinguishability-obfuscation-io)-based PKE constructions (Sahai-Waters 2014) and puncturable PRF-based proofs throughout [functional encryption](categories/07-homomorphic-functional-encryption.md#attribute-based--functional-encryption-abe--fe).

---

## Functional Encryption from iO

**Goal:** Derive the full power of functional encryption from indistinguishability obfuscation. A functional encryption scheme for a function class F allows, given a ciphertext of x and a function key sk_f, to compute f(x) — but nothing more about x. Using iO, one can construct FE for all polynomial-time computable functions from minimal primitives (iO + OWF), establishing iO as a "crypto-complete" primitive. The converse — bootstrapping iO from compact FE — completes the equivalence.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **FE for all circuits from iO (Garg et al.)** | 2013 | iO + OWF | First construction of FE for all polynomial-time functions from iO and injective OWF; multi-input variant also shown [[1]](https://eprint.iacr.org/2013/763) |
| **Sahai-Waters PKE/FE from iO** | 2014 | iO + puncturable PRF | Show iO + punctured PRFs (OWF) → public-key encryption and bounded-collusion FE; the "5-line PKE from iO" proof [[1]](https://eprint.iacr.org/2014/539) |
| **Multi-input FE from iO (Goldwasser et al.)** | 2014 | iO + OWF | Functional encryption where a single key covers multiple ciphertexts encrypted by different parties; constructed from iO [[1]](https://eprint.iacr.org/2013/727) |
| **FE → iO equivalence (Bitansky-Vaikuntanathan / Ananth-Jain)** | 2015 | Single-key compact FE | Sub-exp secure single-key compact FE ↔ iO; see [Bootstrapping iO](#bootstrapping-io-functional-encryption--io) [[1]](https://eprint.iacr.org/2015/163) |
| **Unbounded FE from iO (Ananth-Sahai)** | 2016 | iO + LWE | Functional encryption for unbounded-length inputs from iO and LWE; extends prior constructions beyond fixed-size inputs [[1]](https://eprint.iacr.org/2015/163) |

**State of the art:** iO is sufficient for FE for all circuits (2013); the equivalence with compact FE (2015) is now a cornerstone. Practical FE remains limited to specific function classes (inner product, quadratic) from bilinear maps or LWE without iO. See [bootstrapping iO](#bootstrapping-io-functional-encryption--io) and [ABE/FE](categories/07-homomorphic-functional-encryption.md#attribute-based--functional-encryption-abe--fe).

---

## Learning Parity with Noise (LPN) Assumption

**Goal:** Hardness of decoding random linear codes over GF(2). Given a matrix A and a vector b = As + e where s is a secret and e is a sparse noise vector, recover s. LPN is believed hard even for quantum computers and lies at the foundation of symmetric-key primitives (HB authentication, LPN-based MACs), efficient MPC, and the Jain-Lin-Sahai iO construction. It is the binary analogue of LWE and admits extremely fast implementations.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **HB protocol (Hopper-Blum)** | 2001 | LPN | First authentication protocol from LPN; O(n) computation, provably secure against passive adversaries [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_18) |
| **HB+ (Juels-Weis)** | 2005 | LPN | Extends HB to active security; vulnerable to man-in-the-middle; launched line of LPN-based lightweight auth [[1]](https://eprint.iacr.org/2005/093) |
| **Cryptography from Learning Parity with Noise (Lyubashevsky)** | 2005 | LPN | Formal study of LPN over GF(2) and GF(q); relationship to random linear codes; quantum hardness evidence [[1]](https://link.springer.com/chapter/10.1007/11538462_6) |
| **LPN-based PRG / PRF** | 2012 | LPN | Pseudorandom generators and PRFs based on LPN; more efficient than lattice-based alternatives for constrained hardware [[1]](https://eprint.iacr.org/2011/494) |
| **Alekhnovich encryption** | 2003 | LPN | Public-key encryption whose security reduces to LPN; first LPN-based PKE; ciphertexts are linear-size but message expansion is large [[1]](https://ieeexplore.ieee.org/document/1238197) |
| **LPN in Jain-Lin-Sahai iO** | 2021 | LPN + LWE + PRG | LPN is one of the three well-studied assumptions underlying the first iO construction from standard-like assumptions [[1]](https://eprint.iacr.org/2020/1003) |

**State of the art:** LPN is a widely trusted assumption with no known sub-exponential classical or quantum algorithms beyond the decoding bound; best attacks (BKW, Blum-Kalai-Wasserman) run in time 2^(n/log n). It is a core building block of lightweight cryptography and iO. Related to [LWE](categories/01-foundational-primitives.md) and [symmetric primitives](categories/01-foundational-primitives.md).

---

## Decisional Composite Residuosity (DCR) Assumption

**Goal:** Hardness of distinguishing n-th power residues from random elements in Z*_{n²}. The DCR assumption, introduced by Paillier (1999), asserts that, given a composite n = pq, it is computationally hard to decide whether a random element of Z*_{n²} is an n-th power residue. DCR is the hardness foundation of the Paillier cryptosystem — the canonical additively homomorphic encryption scheme — and underlies efficient threshold decryption, range proofs, and voting protocols.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Paillier cryptosystem** | 1999 | DCR | First additively homomorphic PKE from DCR; ciphertext is an element of Z*_{n²}; decryption via Carmichael function [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |
| **Damgård-Jurik generalization** | 2001 | DCR | Extends Paillier to plaintext space Z_{n^s} for arbitrary s; enables larger message spaces and batch encryption [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_28) |
| **Threshold Paillier (Fouque-Poupard-Stern)** | 2000 | DCR + secret sharing | Threshold variant: decryption requires t-of-n shares; no trusted dealer; used in e-voting and threshold ECDSA [[1]](https://link.springer.com/chapter/10.1007/10722028_9) |
| **Subgroup Decision Problem (Boneh-Shacham)** | 2002 | Composite-order groups | Generalises DCR to subgroup indistinguishability in composite-order bilinear groups; used in early ABE and broadcast encryption [[1]](https://eprint.iacr.org/2002/139) |
| **DCR-based range proofs (Boudot)** | 2000 | DCR + Paillier | Efficient range proofs using Paillier commitments; widely used in financial privacy protocols [[1]](https://link.springer.com/chapter/10.1007/3-540-45539-6_31) |
| **TFHE bootstrapping acceleration via DCR** | 2022 | DCR + CKKS | Use Paillier-style arithmetic to speed up certain FHE bootstrapping operations in levelled schemes [[1]](https://eprint.iacr.org/2022/704) |

**State of the art:** DCR is a well-established assumption with security reducing to factoring (under strong forms); Paillier remains the practical standard for additive HE in e-voting (Helios), threshold ECDSA (GG18/20), and privacy-preserving statistics. Related to [PHE / FHE](categories/07-homomorphic-functional-encryption.md) and [threshold cryptography](categories/05-secret-sharing-threshold-cryptography.md).

---

## Pseudorandom Generators from One-Way Functions

**Goal:** Establish PRGs on minimal cryptographic assumptions. One-way functions (OWFs) — functions easy to compute but hard to invert — are the minimal assumption for symmetric-key cryptography. The Håstad-Impagliazzo-Levin-Luby (HILL) theorem (1999) shows that OWFs imply pseudorandom generators, and hence pseudorandom functions, MACs, and secret-key encryption. This tight equivalence (OWF ↔ PRG ↔ symmetric crypto) is a cornerstone of theoretical cryptography.

| Result / Scheme | Year | Note |
|-----------------|------|------|
| **Blum-Micali PRG** | 1984 | First provably secure PRG from the discrete logarithm assumption; expands seed by one bit per step [[1]](https://epubs.siam.org/doi/10.1137/0213053) |
| **Yao PRG (BBS)** | 1982 | Blum-Blum-Shub generator from quadratic residuosity; each step outputs one hard-core bit; proves PRG from factoring [[1]](https://dl.acm.org/doi/10.1145/800070.802212) |
| **Goldreich-Levin hard-core bit** | 1989 | Any OWF has a hard-core predicate (the inner product bit); foundational for converting OWFs to PRGs [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **HILL theorem (Håstad-Impagliazzo-Levin-Luby)** | 1999 | OWF → PRG via iterative construction; establishes equivalence of OWFs and PRGs; computationally secure PRG from any OWF [[1]](https://epubs.siam.org/doi/10.1137/S0097539793244708) |
| **GGM PRF from PRG** | 1986 | Goldreich-Goldwasser-Micali show any length-doubling PRG yields a PRF via a binary tree construction; PRF from OWF by composition with HILL [[1]](https://dl.acm.org/doi/10.1145/6490.6503) |
| **Inaccessible entropy framework (Haitner et al.)** | 2009 | Simplified and modular reproofs of HILL using the inaccessible entropy technique; tighter parameters [[1]](https://eprint.iacr.org/2009/052) |

**State of the art:** OWF → PRG (HILL 1999) is the central result of complexity-based cryptography; the construction is not practical (many rounds of the GL hard-core bit extractor) but the equivalence is foundational. Practical PRGs (AES-CTR, ChaCha20) are built directly from block ciphers. Related to [PRF/PRP and PRG](categories/01-foundational-primitives.md) and [theoretical foundations](categories/19-theoretical-foundations.md).

---
