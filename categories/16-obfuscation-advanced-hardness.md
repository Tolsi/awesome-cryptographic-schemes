# Obfuscation & Advanced Hardness Assumptions


<!-- TOC -->
## Contents (40 schemes)

- [Indistinguishability Obfuscation (iO)](#indistinguishability-obfuscation-io)
- [Multilinear Maps](#multilinear-maps)
- [Laconic Cryptography](#laconic-cryptography)
- [Batch Arguments (BARG) / Accumulation Schemes](#batch-arguments-barg--accumulation-schemes)
- [Witness Encryption](#witness-encryption)
- [Dual-Mode Cryptosystems](#dual-mode-cryptosystems)
- [Spooky Encryption](#spooky-encryption)
- [Point Function Obfuscation / Digital Locker](#point-function-obfuscation--digital-locker)
- [VBB Obfuscation Impossibility](#vbb-obfuscation-impossibility)
- [Differing-Inputs Obfuscation (diO)](#differing-inputs-obfuscation-dio)
- [Evasive LWE & Tensor LWE](#evasive-lwe--tensor-lwe)
- [Average-Case Hardness & Planted Problems](#average-case-hardness--planted-problems)
- [Bootstrapping iO: Functional Encryption → iO](#bootstrapping-io-functional-encryption--io)
- [Hyperplane Membership Obfuscation](#hyperplane-membership-obfuscation)
- [Null iO (Obfuscation for Always-Zero Circuits)](#null-io-obfuscation-for-always-zero-circuits)
- [Zeroizing Attacks on Multilinear Maps](#zeroizing-attacks-on-multilinear-maps)
- [Constrained Pseudorandom Functions (CPRF)](#constrained-pseudorandom-functions-cprf)
- [Functional Encryption from iO](#functional-encryption-from-io)
- [Learning Parity with Noise (LPN) Assumption](#learning-parity-with-noise-lpn-assumption)
- [Decisional Composite Residuosity (DCR) Assumption](#decisional-composite-residuosity-dcr-assumption)
- [Pseudorandom Generators from One-Way Functions](#pseudorandom-generators-from-one-way-functions)
- [MPC from Minimal Assumptions (MPC from OWF)](#mpc-from-minimal-assumptions-mpc-from-owf)
- [Succinct Functional Encryption for Turing Machines](#succinct-functional-encryption-for-turing-machines)
- [Approximate Indistinguishability Obfuscation (aiO)](#approximate-indistinguishability-obfuscation-aio)
- [Predicate Encryption and Attribute Hiding](#predicate-encryption-and-attribute-hiding)
- [Software Copy-Protection from iO](#software-copy-protection-from-io)
- [Diffie-Hellman Assumption Variants (CDH, DDH, GDH, q-DH, co-CDH)](#diffie-hellman-assumption-variants-cdh-ddh-gdh-q-dh-co-cdh)
- [Bilinear Map Assumptions (DBDH, DLIN, SXDH, q-SDH, q-DBDHI)](#bilinear-map-assumptions-dbdh-dlin-sxdh-q-sdh-q-dbdhi)
- [RSA Assumption Variants (RSA, Strong RSA, Flexible RSA)](#rsa-assumption-variants-rsa-strong-rsa-flexible-rsa)
- [Randomized Encodings for Garbling and iO](#randomized-encodings-for-garbling-and-io)
- [Monotone Span Programs and Cryptographic Access Structures](#monotone-span-programs-and-cryptographic-access-structures)
- [Compute-and-Compare Obfuscation](#compute-and-compare-obfuscation)
- [Lockable Obfuscation](#lockable-obfuscation)
- [Lattice-Based iO (Jain-Lin-Sahai Construction)](#lattice-based-io-jain-lin-sahai-construction)
- [Program Obfuscation for RAM Programs](#program-obfuscation-for-ram-programs)
- [Multi-Input Functional Encryption](#multi-input-functional-encryption)
- [Attribute-Hiding Predicate Encryption](#attribute-hiding-predicate-encryption)
- [Obfuscation of Point Functions with Multi-Bit Output](#obfuscation-of-point-functions-with-multi-bit-output)
- [Predicate Encryption from Lattices](#predicate-encryption-from-lattices)
- [Evasive LWE and the iO Landscape](#evasive-lwe-and-the-io-landscape)
<!-- /TOC -->


## Indistinguishability Obfuscation (iO)

**Goal:** Maximum software protection. Make a program "unintelligible" while preserving its input/output behavior. Theoretical "crypto-complete" primitive: iO + one-way functions → almost any cryptographic primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH+SW13 (first candidate)** | 2013 | Multilinear maps | First iO candidate construction; broken/patched repeatedly [[1]](https://eprint.iacr.org/2013/451) |
| **Jain-Lin-Sahai** | 2021 | LWE + LPN + PRG assumptions | First iO from well-studied assumptions; breakthrough [[1]](https://eprint.iacr.org/2020/1003) |
| **Witness Encryption (GGSW)** | 2013 | Multilinear maps / iO | Encrypt to an NP statement; decrypt with witness [[1]](https://eprint.iacr.org/2013/258) |

**State of the art:** Jain-Lin-Sahai (2021) — theoretical milestone; iO remains impractical but is the "holy grail" of crypto.

**Production readiness:** Research
Theoretical milestone only; no practical implementation exists due to enormous computational overhead.

**Implementations:**
- [5GenCrypto](https://github.com/5GenCrypto) — C++, academic prototype of multilinear-map-based iO (broken candidates)
**Security status:** Caution
Early multilinear-map-based candidates repeatedly broken; well-founded-assumption construction (JLS 2021) not yet validated at implementation level.

**Community acceptance:** Emerging
Widely recognized as the "holy grail" of crypto; active research but no standardization effort yet.


---

## Multilinear Maps

**Goal:** Generalized pairings. A *k*-linear map takes elements from *k* groups and outputs an element in a target group, enabling richer algebraic operations than bilinear pairings. Theoretical foundation for early iO and multi-party non-interactive key exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGH13** | 2013 | Ideal lattices | First candidate multilinear map; zeroizing attacks found [[1]](https://eprint.iacr.org/2012/610) |
| **CLT13** | 2013 | CRT over integers | Alternative construction; also broken in many settings [[1]](https://eprint.iacr.org/2013/183) |
| **GGH15 (Graph-Induced)** | 2015 | Lattice | More structured; partial resistance to zeroizing attacks [[1]](https://eprint.iacr.org/2014/645) |

**State of the art:** no fully secure multilinear map candidate exists; research continues. Modern iO (Jain-Lin-Sahai 2021) avoids multilinear maps.

**Production readiness:** Research
Academic prototypes only; all known candidates have been broken in general settings.

**Implementations:**
- [5GenCrypto/mmap](https://github.com/5GenCrypto) — C, reference implementations of GGH13 and CLT13 (research only, broken)
**Security status:** Broken
All major candidates (GGH13, CLT13, GGH15) broken by zeroizing and annihilation attacks.

**Community acceptance:** Niche
Studied primarily as a cautionary example; modern iO avoids multilinear maps entirely.


---

## Laconic Cryptography

**Goal:** Minimal interaction. Two-message protocols where the first message is a short hash (digest) of a potentially huge input — the second message depends on this digest. Enables receiver-efficient OT, FE, and more from simple hash assumptions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Laconic OT (CDG+)** | 2017 | Hash + garbled circuits | Two-message OT where receiver sends short hash of selection bits [[1]](https://eprint.iacr.org/2017/799) |
| **Laconic FE (Quach-Wee-Wichs)** | 2018 | LWE | Functional encryption with succinct ciphertexts from laconic techniques [[1]](https://eprint.iacr.org/2018/325) |
| **Laconic PSI** | 2022 | Laconic OT | Private set intersection where one party sends only a short digest [[1]](https://eprint.iacr.org/2022/094) |
| **Registered FE (Laconic approach)** | 2023 | Laconic + pairings | Connect laconic techniques to registration-based crypto [[1]](https://eprint.iacr.org/2023/398) |

**State of the art:** Laconic OT from hash functions (CDG+ 2017); emerging paradigm connecting to [RBE](07-homomorphic-functional-encryption.md#registration-based-encryption-rbe), [PSI](10-privacy-preserving-computation.md#private-set-intersection-psi).

**Production readiness:** Research
Academic constructions only; no production-quality implementations available.

**Implementations:**
No notable open-source implementations available.
**Security status:** Secure
No known attacks on the hash-based constructions at recommended parameters.

**Community acceptance:** Emerging
Growing paradigm with connections to RBE and PSI; gaining traction since 2017.


---

## Batch Arguments (BARG) / Accumulation Schemes

**Goal:** Efficient batch verification. Prove many statements simultaneously with a proof shorter than proving each individually. Used in blockchain rollups and recursive proof composition.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BARG (Choudhuri et al.)** | 2021 | LWE + RAM SNARKs | Batch NP statements with poly-size proof [[1]](https://eprint.iacr.org/2021/1423) |
| **Accumulation Schemes (Bünz et al.)** | 2020 | IPA / polynomial commitment | Accumulate proofs incrementally; used in Halo 2 [[1]](https://eprint.iacr.org/2020/499) |
| **ProtoStar** | 2023 | IVC + accumulation | Generic accumulation for PLONK-like systems [[1]](https://eprint.iacr.org/2023/620) |

**State of the art:** ProtoStar (modern folding/accumulation), BARG from LWE (theoretical breakthrough).

**Production readiness:** Experimental
Working implementations in Halo 2 and Nova but not yet deployed at production scale outside Zcash.

**Implementations:**
- [halo2](https://github.com/zcash/halo2) ⭐ 895 — Rust, Zcash's accumulation/IPA-based proving system
- [nova](https://github.com/microsoft/Nova) ⭐ 837 — Rust, Microsoft Research folding/accumulation scheme
- [protostar (Lurk Lab)](https://github.com/lurk-lab/Nova) ⭐ 1 — Rust, IVC and accumulation experiments
**Security status:** Secure
No known attacks on accumulation/folding schemes at recommended parameters.

**Community acceptance:** Emerging
Rapidly growing adoption in blockchain proof systems; active standardization in the ZK community.


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

**Production readiness:** Research
General WE remains theoretical; timelock-based variants (tlock) are the only practical deployments.

**Implementations:**
- [tlock](https://github.com/drand/tlock) ⭐ 634 — Go, timelock encryption via drand threshold BLS (practical WE-like variant)
**Security status:** Caution
Original multilinear-map-based constructions rely on broken primitives; timelock variants depend on sequential squaring assumptions.

**Community acceptance:** Niche
Theoretically important but practical constructions remain limited to timelock variants.


---

## Dual-Mode Cryptosystems

**Goal:** UC-secure encryption. A cryptosystem with two indistinguishable CRS modes: *messy mode* (statistically hiding — encryption hides bit perfectly) and *decryption mode* (statistically binding — only one decryption). Enables UC-secure OT, commitments, and ZK.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Peikert-Vaikuntanathan-Waters Dual-Mode** | 2008 | DDH / QR / LWE | First dual-mode encryption; implies UC-secure OT in CRS model [[1]](https://eprint.iacr.org/2008/009) |
| **Dual-Mode from LWE** | 2008 | LWE | Lattice instantiation; post-quantum UC-secure OT [[1]](https://eprint.iacr.org/2008/009) |
| **Dual-Mode Commitments** | 2011 | DDH / LWE | Extension to commitments: perfectly hiding or perfectly binding modes [[1]](https://eprint.iacr.org/2011/010) |

**State of the art:** LWE-based dual-mode (PQ-secure); foundation of UC-secure [OT](06-multi-party-computation.md#oblivious-transfer-ot) and [Non-Committing Encryption](#witness-encryption).

**Production readiness:** Mature
Well-studied with production-quality implementations in emp-ot and lattigo; used as building block in UC-secure OT.

**Implementations:**
- [emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, includes UC-secure OT built on dual-mode techniques
- [lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k — Go, lattice-based crypto library with LWE primitives
**Security status:** Secure
No known attacks; security proven under DDH, QR, or LWE assumptions.

**Community acceptance:** Widely trusted
Foundational technique for UC-secure protocols; endorsed by the cryptographic community since 2008.


---

## Spooky Encryption

**Goal:** Non-interactive homomorphic computation across independent ciphertexts. Two parties independently encrypt messages m₁, m₂ under separate keys. A third party (without decryption keys) transforms the ciphertexts so that decryption yields shares of f(m₁, m₂) — without any interaction between the parties.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Halevi-Rothblum-Wichs Spooky Enc** | 2016 | LWE | First spooky encryption; entangle independent ciphertexts; yields 2PC without interaction [[1]](https://eprint.iacr.org/2016/272) |
| **Spooky Enc for General Functions** | 2016 | LWE + circular security | Extend to any efficiently computable function f [[1]](https://eprint.iacr.org/2016/272) |

**State of the art:** LWE-based spooky encryption (2016); implies non-interactive MPC in a new model. Related to [Multi-Key FHE](07-homomorphic-functional-encryption.md#multi-key--threshold-fhe) and [MPC](06-multi-party-computation.md#multi-party-computation-mpc).

**Production readiness:** Research
Purely theoretical; no public implementation exists beyond the paper description.

**Implementations:**
- No public open-source implementation available; described in [DHRW16 paper](https://eprint.iacr.org/2016/272)
**Security status:** Secure
No known attacks; security reduces to LWE (with circular security for general functions).

**Community acceptance:** Niche
Novel theoretical concept; limited adoption due to the lack of practical need beyond existing MPC/FHE approaches.


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

**Production readiness:** Mature
Password hashing and sealed-box patterns implementing digital-locker functionality are deployed at scale in OpenSSL and libsodium.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, password hashing/verification implements point-function-like checks
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, `crypto_pwhash` and sealed-box primitives implement digital-locker patterns
**Security status:** Secure
No known attacks; VBB security proven in the ROM, and lockable obfuscation proven under LWE.

**Community acceptance:** Widely trusted
The achievable fragment of VBB obfuscation; widely deployed in password verification and sealed-box encryption.


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

**Production readiness:** Research
Impossibility result with no implementation; the proof shows general VBB obfuscation cannot exist.

**Implementations:**
- N/A — impossibility result; no implementations (the result proves VBB obfuscation cannot exist in general)
**Security status:** Broken
The impossibility itself is a proven result; the constructed unobfuscatable family is definitive.

**Community acceptance:** Standard
Seminal result (Barak et al. 2001) universally accepted; motivated the entire field's shift to iO.


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

**Production readiness:** Research
Purely theoretical; general diO with auxiliary input shown implausible, and no implementations exist.

**Implementations:**
- No public open-source implementation available; general diO with auxiliary input is considered implausible
**Security status:** Caution
General diO with auxiliary input is considered implausible (Boyle-Pass 2013); public-coin variants remain unbroken.

**Community acceptance:** Controversial
Debated due to implausibility results; useful as a theoretical tool but not relied upon for practical constructions.


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

**Production readiness:** Research
Assumption-level research with no standalone implementations or deployable constructions.

**Implementations:**
- No public open-source implementation available; assumption-level research with no standalone library
**Security status:** Caution
Public-coin variants appear sound; private-coin formulations have known counterexamples (2024).

**Community acceptance:** Emerging
Rapidly growing interest since 2022; considered the most promising post-quantum path to advanced primitives.


---

## Average-Case Hardness & Planted Problems

**Goal:** Cryptography from statistical hardness. Standard worst-case hardness assumptions (LWE, SIS, DDH) guarantee hardness on some instances. Average-case assumptions assert hardness on *most* instances from an explicit distribution — a stronger requirement needed when the cryptographic scheme itself must generate hard instances. The planted clique problem and planted random graph problems are the canonical examples and underpin constructions of public-key encryption and secret sharing from fine-grained complexity.

| Problem / Scheme | Year | Note |
|-----------------|------|------|
| **Planted Clique conjecture** | 1992 | Karp conjectured that finding a planted clique of size k = O(√n) in G(n, 1/2) is hard; widely used as a hardness assumption in statistics and algorithms [[1]](https://en.wikipedia.org/wiki/Planted_clique) |
| **Cryptography from planted clique (Juels-Peinado)** | 1997 | Early use of planted clique hardness for cryptographic constructions [[1]](https://eprint.iacr.org/2025/1501.pdf) |
| **Cryptography from Planted Graphs (Abram et al.)** | 2023 | Constructs PKE and secret sharing from the planted clique conjecture with logarithmic-size messages; first clean PKE from a graph-theoretic average-case assumption [[1]](https://eprint.iacr.org/2023/1929.pdf) |
| **PKE from Planted Clique and Noisy k-LIN (STOC 2025)** | 2025 | New construction of PKE from the planted clique conjecture combined with noisy k-linearity over expanders; strengthens the case for planted clique as a crypto hardness base [[1]](https://dl.acm.org/doi/10.1145/3717823.3718306) |

**State of the art:** Planted clique is a clean average-case assumption with growing cryptographic applications; hardness is supported by failure of spectral, SDP, and statistical-query algorithms up to clique size O(√n). Complements [theoretical foundations](19-theoretical-foundations.md) on leakage-resilient and circular-security assumptions.

**Production readiness:** Research
Cryptographic constructions are purely theoretical; planted clique is studied algorithmically but not deployed in crypto systems.

**Implementations:**
- No public open-source cryptographic implementation; planted clique is studied algorithmically in [NetworkX](https://github.com/networkx/networkx) — Python, graph library with planted partition generators
**Security status:** Caution
Planted clique conjecture supported by failure of all known algorithmic approaches up to clique size O(sqrt(n)), but not yet as battle-tested as LWE/DDH.

**Community acceptance:** Niche
Well-studied in algorithms and statistics; growing but still limited use as a cryptographic hardness assumption.


---

## Bootstrapping iO: Functional Encryption → iO

**Goal:** Establish the foundational equivalence between indistinguishability obfuscation and functional encryption. A single-key, compact functional encryption (FE) scheme — one where the encryption circuit runs in time polynomial in the input length, independent of the function's description size — is sufficient to generically bootstrap full iO for all circuits. This 2015 equivalence (proved independently by two groups) revealed FE as the minimal assumption needed for iO and anchored subsequent "from well-founded assumptions" constructions.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Bitansky-Vaikuntanathan FE → iO** | 2015 | Sub-exp single-key compact FE | Independently show sub-exp secure compact FE implies iO; establishes equivalence up to sub-exponential security loss [[1]](https://eprint.iacr.org/2015/163) |
| **Ananth-Jain FE → iO (CRYPTO 2015)** | 2015 | Single-key compact FE for NC¹ | Construct iO for all circuits from any single-key FE for NC¹ that is selectively secure against sub-exp adversaries and has compact encryption [[1]](https://eprint.iacr.org/2015/173) |
| **FE → iO via garbling (Ananth et al.)** | 2016 | Single-key FE + garbled circuits | Simplify the reduction by combining FE with Yao garbling; FE for NC¹ suffices rather than FE for all circuits [[1]](https://eprint.iacr.org/2015/730) |
| **When does FE imply iO? (Agrikola et al.)** | 2017 | FE compactness characterizations | Characterize exactly which compactness conditions on FE are necessary and sufficient to bootstrap iO [[1]](https://eprint.iacr.org/2017/943) |

**State of the art:** The FE ↔ iO equivalence is now a cornerstone result: building FE from well-studied assumptions (e.g., LWE, bilinear maps) is the main route to iO, exploited by Jain-Lin-Sahai (2021). Relates to [iO](#indistinguishability-obfuscation-io), [multilinear maps](#multilinear-maps), and [functional encryption](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Research
Purely theoretical equivalence result; existing FE libraries implement only inner-product FE, not the full iO bootstrapping chain.

**Implementations:**
- [CiFEr](https://github.com/fentec-project/CiFEr) ⭐ 89 — C, functional encryption library (inner-product FE, not full iO bootstrapping)
- [GoFE](https://github.com/fentec-project/gofe) ⭐ 195 — Go, functional encryption library from FENTEC project
**Security status:** Secure
Reduction is proven correct; security inherits from the underlying FE scheme's assumptions.

**Community acceptance:** Niche
Cornerstone theoretical result (2015) widely accepted; exploited by Jain-Lin-Sahai 2021 to construct iO.


---

## Hyperplane Membership Obfuscation

**Goal:** VBB obfuscation for algebraic membership tests. Obfuscate a program that, given an input vector **v**, tests whether **v** lies on a fixed secret hyperplane (or affine subspace) over a finite field — and outputs only a single bit. Unlike point functions (single secret input), hyperplane membership is a richer algebraic predicate, and achieving VBB security requires stronger assumptions. This is one of the few families of non-trivial programs for which virtual black-box obfuscation is achievable.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Canetti-Rothblum-Varia hyperplane obfuscation** | 2010 | Strong DDH variant | First VBB obfuscation for hyperplane membership of constant dimension over a finite field; application to signatures [[1]](https://link.springer.com/chapter/10.1007/978-3-642-11799-2_5) |
| **Barak et al. hypersurface obfuscation** | 2014 | Multilinear maps | Extends VBB obfuscation from hyperplanes to bounded-degree algebraic hypersurfaces using graded encoding schemes [[1]](https://eprint.iacr.org/2013/451) |
| **Obfuscation of evasive algebraic set membership** | 2024 | Pairing-based / DDH | Further generalizes to obfuscating membership in evasive algebraic sets; provides updated constructions and security analysis [[1]](https://www.aimsciences.org//article/doi/10.3934/amc.2024014) |

**State of the art:** Canetti-Rothblum-Varia (2010) remains the canonical VBB construction for hyperplane membership; security relies on a strong DDH variant rather than multilinear maps. Complements [point function obfuscation](#point-function-obfuscation--digital-locker) as the next step in the hierarchy of achievable VBB obfuscation.

**Production readiness:** Research
Theoretical construction only; no implementations beyond paper descriptions.

**Implementations:**
- No public open-source implementation available; theoretical construction with no standalone library
**Security status:** Caution
Security relies on a strong DDH variant; no known attacks but the assumption is non-standard.

**Community acceptance:** Niche
One of the few non-trivial VBB-achievable function families; studied but with limited practical interest.


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

**Production readiness:** Research
Purely theoretical; serves as a stepping stone toward full iO with no standalone implementations.

**Implementations:**
- No public open-source implementation available; theoretical stepping stone toward full iO
**Security status:** Secure
No known attacks; constructions proven secure under LWE-based assumptions (evasive LWE, compute-and-compare).

**Community acceptance:** Niche
Important theoretical intermediate between witness encryption and full iO; recognized but narrowly studied.


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

**Production readiness:** Research
Cryptanalysis results; reference implementations of broken maps exist only for research validation.

**Implementations:**
- [5GenCrypto](https://github.com/5GenCrypto) — C, includes implementations of GGH13, CLT13, GGH15 maps (all broken in general settings)
**Security status:** Broken
All major multilinear map candidates broken in general settings; restricted GGH15 usage under LWE remains viable.

**Community acceptance:** Niche
Cryptanalysis widely accepted; directly motivated the shift from multilinear-map-based to assumption-based iO.


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

**State of the art:** Punctured PRFs (single-point CPRFs) are constructible from any OWF via GGM; general-circuit CPRFs require iO or are built from LWE for specific function classes (inner product, NC¹). CPRFs underpin [iO](#indistinguishability-obfuscation-io)-based PKE constructions (Sahai-Waters 2014) and puncturable PRF-based proofs throughout [functional encryption](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Research
Punctured PRFs are used implicitly in protocol proofs; general-circuit CPRFs from iO remain theoretical.

**Implementations:**
- [VOPRF (Cloudflare)](https://github.com/cloudflare/circl) ⭐ 1.6k — Go, CIRCL includes OPRF/VOPRF constructions related to constrained PRF ideas
- [lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k — Go, lattice crypto library with LWE-based primitives applicable to CPRF research
**Security status:** Secure
No known attacks on punctured PRF or LWE-based inner-product CPRF constructions at recommended parameters.

**Community acceptance:** Niche
Well-studied theoretical tool; punctured PRFs widely used in cryptographic proofs but full CPRFs remain a research topic.


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

**State of the art:** iO is sufficient for FE for all circuits (2013); the equivalence with compact FE (2015) is now a cornerstone. Practical FE remains limited to specific function classes (inner product, quadratic) from bilinear maps or LWE without iO. See [bootstrapping iO](#bootstrapping-io-functional-encryption--io) and [ABE/FE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Research
General FE from iO is purely theoretical; practical FE libraries support only inner-product and quadratic function classes.

**Implementations:**
- [CiFEr](https://github.com/fentec-project/CiFEr) ⭐ 89 — C, inner-product and quadratic FE (practical subset, not full iO-based FE)
- [GoFE](https://github.com/fentec-project/gofe) ⭐ 195 — Go, functional encryption library from FENTEC EU project
**Security status:** Secure
No known attacks; security reduces to iO and OWF assumptions.

**Community acceptance:** Niche
Foundational theoretical result (2013); practical FE limited to specific function classes from pairings or LWE.


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

**State of the art:** LPN is a widely trusted assumption with no known sub-exponential classical or quantum algorithms beyond the decoding bound; best attacks (BKW, Blum-Kalai-Wasserman) run in time 2^(n/log n). It is a core building block of lightweight cryptography and iO. Related to [LWE](01-foundational-primitives.md) and [symmetric primitives](01-foundational-primitives.md).

**Production readiness:** Mature
LPN-based schemes (HQC, BIKE) have production-quality implementations in liboqs; LPN-based silent OT is deployed in MPC frameworks.

**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, includes code-based schemes related to LPN hardness (e.g., HQC, BIKE)
- [swanky (GaloisInc)](https://github.com/GaloisInc/swanky) ⭐ 344 — Rust, MPC library using LPN-based silent OT extension
**Security status:** Secure
No known sub-exponential classical or quantum attacks; best algorithms (BKW) run in time 2^(n/log n).

**Community acceptance:** Widely trusted
Well-studied assumption for over two decades; used in NIST PQC candidates and as a core assumption in iO (JLS 2021).


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

**State of the art:** DCR is a well-established assumption with security reducing to factoring (under strong forms); Paillier remains the practical standard for additive HE in e-voting (Helios), threshold ECDSA (GG18/20), and privacy-preserving statistics. Related to [PHE / FHE](07-homomorphic-functional-encryption.md) and [threshold cryptography](05-secret-sharing-threshold-cryptography.md).

**Production readiness:** Production
Paillier encryption is deployed in e-voting (Helios), threshold ECDSA (GG18/20), and privacy-preserving statistics.

**Implementations:**
- [python-paillier](https://github.com/data61/python-paillier) ⭐ 634 — Python, CSIRO Data61 Paillier library
- [rust-paillier](https://github.com/kzen-networks/rust-paillier) ⭐ 37 — Rust, Paillier encryption with threshold support
**Security status:** Secure
No known practical attacks; security reduces to factoring under strong forms of the assumption.

**Community acceptance:** Widely trusted
Well-established since 1999; Paillier is the standard for additive homomorphic encryption in deployed systems.


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

**State of the art:** OWF → PRG (HILL 1999) is the central result of complexity-based cryptography; the construction is not practical (many rounds of the GL hard-core bit extractor) but the equivalence is foundational. Practical PRGs (AES-CTR, ChaCha20) are built directly from block ciphers. Related to [PRF/PRP and PRG](01-foundational-primitives.md) and [theoretical foundations](19-theoretical-foundations.md).

**Production readiness:** Production
Theoretical OWF-to-PRG construction (HILL) is impractical; deployed PRGs (AES-CTR, ChaCha20) are built directly from block ciphers.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, DRBG/PRG implementations (AES-CTR-DRBG, practical PRGs)
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ChaCha20-based CSPRNG
- [ring](https://github.com/briansmith/ring) ⭐ 4.1k — Rust, SystemRandom and ChaCha20 PRG
**Security status:** Secure
No known attacks on deployed PRG constructions (AES-CTR-DRBG, ChaCha20) at recommended parameters.

**Community acceptance:** Standard
HILL theorem is a universally accepted cornerstone of theoretical cryptography; NIST standardized DRBG mechanisms.


---

## MPC from Minimal Assumptions (MPC from OWF)

**Goal:** Secure multi-party computation on the weakest possible assumption. It has long been known that OT — and hence general MPC — requires one-way functions. The converse direction, that OWFs suffice, was open for decades. A sequence of results culminating in Applebaum-Ishai-Kushilevitz (2006) and Ishai-Kushilevitz-Ostrovsky-Prabhakaran-Sahai-Wullschleger (2013) established that semi-honest and then malicious-secure MPC for all functionalities can be built from OWFs alone, confirming OWF as the exact threshold for MPC.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **OT from OWF is impossible classically** | 1994 | Impagliazzo-Rudich | OT (and hence MPC) cannot be black-box reduced to OWFs alone without further structure; formal black-box separation [[1]](https://dl.acm.org/doi/10.1145/195058.195134) |
| **OT from enhanced TDF (Bellare-Micali)** | 1989 | Trapdoor functions (TDF) | Oblivious transfer from any enhanced trapdoor permutation; trapdoor permutations follow from factoring or DDH [[1]](https://dl.acm.org/doi/10.1145/73007.73010) |
| **Garbled circuits + OT → MPC (Yao / GMW)** | 1986–87 | OWF + OT | Yao garbling + Goldreich-Micali-Wigderson compiler: semi-honest then malicious-secure MPC for any polynomial-time function from OT [[1]](https://dl.acm.org/doi/10.1145/3335741.3335756) |
| **MPC from OWF (Ishai et al.)** | 2013 | OWF + NC¹ garbling | Constructs constant-round semi-honest MPC protocols whose communication complexity is polynomial in the OWF security parameter; OWF is sufficient for MPC [[1]](https://eprint.iacr.org/2013/267) |
| **Malicious MPC from OWF (Goyal-Jain-Jin-Srinivasan)** | 2022 | OWF | Constant-round maliciously-secure MPC from OWFs in the plain model; completes the equivalence for malicious adversaries [[1]](https://eprint.iacr.org/2022/1194) |
| **Round-optimal MPC from OWF** | 2020 | OWF + NIZK | Two-round MPC for general functions from OWF (via NIZK in the CRS model); optimal interaction [[1]](https://eprint.iacr.org/2020/1204) |

**State of the art:** OWF ↔ MPC (semi-honest 2013, malicious 2022); the equivalence is now complete. In practice, MPC protocols use OT from DDH or LWE for efficiency. Foundationally related to [OWF → PRG](#pseudorandom-generators-from-one-way-functions), [garbled circuits](06-multi-party-computation.md#garbled-circuits-expanded), and [oblivious transfer](06-multi-party-computation.md#oblivious-transfer-ot).

**Production readiness:** Research
Theoretical equivalence result; practical MPC frameworks use OT from DDH or LWE rather than raw OWF constructions.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit) — C++, garbled circuits and OT protocols (practical MPC, not from OWF alone)
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, comprehensive MPC framework implementing multiple protocol families
**Security status:** Secure
No known attacks; proofs reduce to OWF security which is the minimal assumption for symmetric crypto.

**Community acceptance:** Widely trusted
Foundational result (semi-honest 2013, malicious 2022) universally accepted; practical MPC uses stronger but more efficient assumptions.


---

## Succinct Functional Encryption for Turing Machines

**Goal:** Functional encryption (FE) where ciphertext size is independent of the computation time. Standard FE for circuits requires ciphertext size to grow with circuit depth. Succinct FE for Turing machines (or RAM programs) allows encrypting an input x with |ct| = poly(|x|, λ) such that a function key sk_M for a Turing machine M evaluates M(x) in time T(|x|) — with decryption cost poly(|x|, λ), independent of T. This achieves fully succinct FE and is closely tied to iO and diO.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **FE for Turing machines (ABSV)** | 2013 | diO + OWF | Ananth-Boneh-Sahai-Vaikuntanathan construct the first FE for Turing machines from differing-inputs obfuscation; ciphertexts are succinct in the input length [[1]](https://ntt-research.com/wp-content/uploads/2022/08/Differing-inputs-obfuscation-and-applications.pdf) |
| **Succinct FE from sub-exp iO** | 2016 | Sub-exp iO + OWF | Ananth-Jain-Kiyoshima-Sahai remove diO; replace with sub-exponentially secure iO; yields semi-adaptive succinct FE for Turing machines [[1]](https://eprint.iacr.org/2015/163) |
| **FE for RAM programs (Cho-Döttling-Garg-Gupta-Miao-Srinivasan)** | 2020 | iO + ORAM | Construct FE for RAM programs where decryption time matches RAM running time, not circuit depth; uses ORAM to handle memory [[1]](https://eprint.iacr.org/2020/501) |
| **Laconic FE for Turing machines** | 2023 | Laconic OT + LWE | Succinct ciphertext FE for Turing machines from laconic cryptography and LWE; avoids iO entirely for bounded computation time [[1]](https://eprint.iacr.org/2023/398) |
| **Succinct FE implies diO (Garg-Gentry-Halevi-Wichs)** | 2014 | Reverse direction | Fully succinct single-key FE for Turing machines implies differing-inputs obfuscation; establishes tight equivalence between the two [[1]](https://link.springer.com/chapter/10.1007/978-3-662-44371-2_29) |

**State of the art:** Succinct FE for Turing machines is achievable from iO (2016); the equivalence with diO (2014) is foundational but diO itself is fragile (see [diO](#differing-inputs-obfuscation-dio)). Practical deployment awaits efficient iO. Relates to [Functional Encryption from iO](#functional-encryption-from-io), [Bootstrapping iO](#bootstrapping-io-functional-encryption--io), [Garbled RAM](06-multi-party-computation.md#garbled-ram), and [Laconic Cryptography](#laconic-cryptography).

**Production readiness:** Research
Purely theoretical; requires efficient iO which does not yet exist in practice.

**Implementations:**
- No public open-source implementation available; requires efficient iO which does not yet exist
**Security status:** Secure
No known attacks on the theoretical construction; security reduces to iO and OWF.

**Community acceptance:** Niche
Important theoretical result establishing the equivalence with diO; practical deployment awaits efficient iO.


---

## Approximate Indistinguishability Obfuscation (aiO)

**Goal:** A relaxed obfuscation guarantee sufficient for many applications. Full iO requires that obfuscations of any two equivalent circuits are computationally indistinguishable. Approximate iO (aiO) weakens this to allow a small statistical distance between the obfuscated circuit's output distribution and the original, or to allow indistinguishability to hold only against a restricted class of adversaries. This relaxation enables constructions from weaker assumptions — and in some formulations from falsifiable assumptions — while retaining enough security for applications such as witness encryption and software watermarking.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Approximate obfuscation (Bitansky-Canetti-Cohn-Goldwasser-Kalai-Paneth-Rosen)** | 2014 | Sub-exp LWE | Introduce aiO as a relaxation of iO; construct an approximate obfuscator for NC¹ circuits with a polynomially small approximation error under LWE [[1]](https://eprint.iacr.org/2014/264) |
| **aiO for all circuits from LWE** | 2016 | Sub-exp LWE + PRG | Extend aiO to polynomial-size circuits; error is negligible for most inputs; basis for practical applications without full iO [[1]](https://eprint.iacr.org/2016/014) |
| **Weak iO (Brzuska-Mittelbach)** | 2014 | Complexity assumptions | Formalize "weak" iO where indistinguishability holds only for programs with a hard-to-find differing input; strictly weaker than diO and stronger than iO [[1]](https://eprint.iacr.org/2014/304) |
| **Functional encryption → aiO (Ananth-La Placa)** | 2021 | Compact FE | Show that single-key compact FE with a mild approximation in security implies aiO for all circuits; broadens the FE-to-iO bootstrapping landscape [[1]](https://eprint.iacr.org/2020/1003) |
| **Obfustopia (Brakerski-Döttling-Garg-Malavolta)** | 2020 | LWE + PRG in NC¹ | Construct aiO-style primitives sufficient for witness encryption and ABE from LWE + PRG in NC¹, without assuming full iO; important step toward iO from standard assumptions [[1]](https://eprint.iacr.org/2020/1003) |

**State of the art:** aiO from LWE (with sub-exponential security) is achievable (2016) and implies many iO applications; it is a leading intermediate milestone on the path from LWE to full iO. Relates to [iO](#indistinguishability-obfuscation-io), [VBB Impossibility](#vbb-obfuscation-impossibility), [Differing-Inputs Obfuscation](#differing-inputs-obfuscation-dio), and [Evasive LWE](#evasive-lwe--tensor-lwe).

**Production readiness:** Research
Purely theoretical relaxation of iO; no implementations exist.

**Implementations:**
- No public open-source implementation available; theoretical relaxation of iO
**Security status:** Caution
Weaker guarantee than full iO; security depends on sub-exponential LWE which requires careful parameter selection.

**Community acceptance:** Niche
Recognized as a useful intermediate notion; less studied than full iO but gaining attention as a stepping stone.


---

## Predicate Encryption and Attribute Hiding

**Goal:** Fine-grained access control where the access policy itself is hidden. In standard attribute-based encryption (ABE), the ciphertext attributes are visible to all parties. Predicate encryption (PE) hides both the plaintext and the ciphertext attributes, revealing only whether the key predicate matches — and nothing else. This attribute-hiding property is essential for privacy-preserving encrypted search, anonymous credential systems, and oblivious access control. Achieving PE for rich predicates (beyond equality or inner product) requires techniques closely related to obfuscation.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Predicate Encryption (Katz-Sahai-Waters)** | 2008 | Bilinear pairings | First formal PE definition; constructs inner-product PE (IP-PE) over composite-order groups; attributes and predicate mutually hidden [[1]](https://eprint.iacr.org/2008/290) |
| **Hidden Vector Encryption (Boneh-Waters)** | 2007 | Bilinear pairings | PE for conjunctive equality, subset, and range queries with wildcard support; decrypt iff ciphertext vector matches key pattern [[1]](https://eprint.iacr.org/2007/013) |
| **PE for CNF/DNF (Shi-Waters)** | 2008 | Bilinear pairings | Predicate encryption for boolean formulas; attribute-hiding guarantees; security under DBDH [[1]](https://eprint.iacr.org/2008/290) |
| **Lattice PE for inner product (Agrawal-Freeman-Vaikuntanathan)** | 2011 | LWE | Post-quantum inner-product PE from LWE; attribute hiding under LWE; compact ciphertexts [[1]](https://eprint.iacr.org/2011/457) |
| **PE for all circuits from iO (Waters)** | 2015 | iO + OWF | Full-attribute-hiding PE for any circuit predicate constructed from iO and OWF; establishes iO as the sufficient assumption for the strongest PE notion [[1]](https://eprint.iacr.org/2012/315) |
| **PE from evasive LWE (Wee)** | 2022 | Evasive LWE | Attribute-hiding CP-ABE and PE for NC¹ from evasive LWE without iO; post-quantum and with near-optimal parameter sizes [[1]](https://eprint.iacr.org/2023/906) |

**State of the art:** Attribute-hiding PE for NC¹ from evasive LWE (Wee 2022) is the leading post-quantum construction; full-circuit PE requires iO (2015). The distinction from standard ABE is the hiding of ciphertext attributes, which fundamentally raises the hardness requirements. Cross-references: [Functional Encryption from iO](#functional-encryption-from-io), [Evasive LWE](#evasive-lwe--tensor-lwe), [HVE and ABE/FE](07-homomorphic-functional-encryption.md#hidden-vector-encryption-hve), [Laconic Cryptography](#laconic-cryptography).

**Production readiness:** Experimental
Inner-product PE has working implementations in Charm-Crypto and OpenABE; full-circuit PE remains theoretical.

**Implementations:**
- [Charm-Crypto](https://github.com/JHUISI/charm) ⭐ 633 — Python, pairing-based crypto framework with predicate encryption schemes
- [OpenABE](https://github.com/zeutro/openabe) ⭐ 274 — C++, ABE library (payload-hiding; partial attribute-hiding support)
**Security status:** Secure
No known attacks on inner-product PE under standard pairing or LWE assumptions at recommended parameters.

**Community acceptance:** Emerging
Active research area; inner-product PE is well-studied, while full-circuit PE for rich predicates is emerging.


---

## Software Copy-Protection from iO

**Goal:** Distribute a software program so that any user who receives a copy can run it but cannot produce a second working copy. Copy-protection is a classical software-security goal that, informally, requires programs to be "unclonable" — a property impossible to achieve with classical software alone since code is copyable data. Using iO, one can construct cryptographic copy-protection schemes for specific function classes (such as point functions and compute-and-compare programs), where any successful copy of the obfuscated program would violate a computational hardness assumption.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Copy-protection from iO (Ananth-La Placa)** | 2021 | iO + quantum random oracle | First formal copy-protection for unlearnable function classes using iO; adversary that clones the program implicitly solves a hard problem [[1]](https://eprint.iacr.org/2020/1212) |
| **Copy-protection for point functions (classical)** | 2021 | iO + LWE | Classical (non-quantum) copy-protection for point functions: distribute an iO-obfuscated program tied to a hardware token or licensing mechanism [[1]](https://eprint.iacr.org/2020/1212) |
| **Watermarking from iO (Cohen-Holmgren-Nishimaki-Vaikuntanathan-Wichs)** | 2016 | iO + PRF | Unremovable software watermarking: embed a detectable mark in a PRF that cannot be removed without destroying functionality; first from iO [[1]](https://eprint.iacr.org/2015/1096) |
| **Watermarking PRFs from LWE (Kim-Wu)** | 2017 | LWE | Construct watermarkable PRFs from LWE without iO; minimal assumption for watermarking structured programs [[1]](https://eprint.iacr.org/2017/641) |
| **Traceable secret sharing for copy detection** | 2024 | Bilinear maps | Use tracing techniques to identify which copy of a program was used to produce unauthorized decryptions; copyright enforcement for FE keys [[1]](https://eprint.iacr.org/2024/081) |

**State of the art:** Classical (non-quantum) copy-protection requires iO or hardware assumptions; quantum copy-protection (see [Quantum Copy-Protection](15-quantum-cryptography.md#quantum-copy-protection--uncloneable-encryption)) achieves it from the no-cloning theorem. Software watermarking from LWE (2017) is the most practical deployed-oriented construction. Relates to [iO](#indistinguishability-obfuscation-io), [Constrained PRFs](#constrained-pseudorandom-functions-cprf), [Functional Encryption from iO](#functional-encryption-from-io), and [Quantum Copy-Protection](15-quantum-cryptography.md#quantum-copy-protection--uncloneable-encryption).

**Production readiness:** Research
Purely theoretical; classical copy-protection requires iO or hardware assumptions not yet practical.

**Implementations:**
- No public open-source implementation of cryptographic copy-protection; software watermarking prototypes exist in academic codebases
**Security status:** Caution
Security proofs depend on iO and quantum random oracle assumptions; no implementation-level validation.

**Community acceptance:** Niche
Theoretically important goal; practical interest centers on software watermarking (achievable from LWE) rather than full copy-protection.


---

## Diffie-Hellman Assumption Variants (CDH, DDH, GDH, q-DH, co-CDH)

**Goal:** Establish a spectrum of hardness assumptions over cyclic groups. The Computational Diffie-Hellman (CDH) family underpins nearly all discrete-log-based cryptography: public-key encryption, key agreement, signatures, IBE, and bilinear-map protocols. Each variant captures a different hardness property — computing vs. distinguishing vs. deciding — and different structural constraints (one-more, co-CDH, q-type), giving a rich ladder of assumptions from weakest (CDH) to strongest (DDH).

| Assumption | Year | Group Setting | Note |
|-----------|------|---------------|------|
| **CDH (Computational Diffie-Hellman)** | 1976 | Generic group / prime-order | Given (g, g^a, g^b), compute g^{ab}; hardness is equivalent to discrete log in generic groups [[1]](https://doi.org/10.1109/TIT.1976.1055638) |
| **DDH (Decisional Diffie-Hellman)** | 1994 | Prime-order group | Distinguish (g^a, g^b, g^{ab}) from (g^a, g^b, g^c) for random c; implies CDH; fails in groups with efficient pairings [[1]](https://eprint.iacr.org/1994/100) |
| **GDH (Gap Diffie-Hellman)** | 2001 | Pairing-friendly group | CDH is hard even given a DDH oracle; arises naturally in pairing groups; basis of BLS signatures [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_13) |
| **q-DH (q-Diffie-Hellman)** | 2004 | Bilinear group | Given (g, g^x, …, g^{x^q}), compute g^{x^{q+1}}; non-falsifiable q-type assumption underlying short signatures [[1]](https://eprint.iacr.org/2004/171) |
| **co-CDH (Cross-group CDH)** | 2001 | Two groups with pairing | Given g_1^a ∈ G_1 and g_2 ∈ G_2, compute g_2^a; hardness assumption in asymmetric pairing settings; used in HMQV and pairing-based IBE [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_13) |
| **One-More CDH** | 2001 | Prime-order group | Given n+1 challenges and n CDH oracle calls, compute all n+1 Diffie-Hellman values; underlies blind Schnorr security [[1]](https://eprint.iacr.org/2001/002) |

**State of the art:** DDH is the most versatile falsifiable assumption; q-type assumptions (q-DH, q-SDH) enable shorter proofs at the cost of falsifiability. GDH is the natural assumption in pairing groups (e.g., BN254, BLS12-381). All DH variants are broken by quantum computers (Shor). Related to [bilinear map assumptions](#bilinear-map-assumptions-dbdh-dlin-sxdh-q-sdh-q-dbdhi), [dual-mode cryptosystems](#dual-mode-cryptosystems), and [predicate encryption](#predicate-encryption-and-attribute-hiding).

**Production readiness:** Production
Deployed at massive scale in TLS (ECDH/X25519), Signal, and all major pairing-based protocols.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, ECDH/DH implementations used in TLS worldwide
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, X25519 Diffie-Hellman
- [gnark-crypto](https://github.com/Consensys/gnark-crypto) ⭐ 590 — Go, pairing-based crypto (BN254, BLS12-381, BLS24-315)
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/Rust, high-performance BLS12-381 library
**Security status:** Secure
No known classical attacks at recommended parameters; all variants broken by quantum computers (Shor's algorithm).

**Community acceptance:** Standard
NIST and IETF standardized (ECDH in TLS 1.3, X25519 in RFC 7748); foundational to modern cryptography.


---

## Bilinear Map Assumptions (DBDH, DLIN, SXDH, q-SDH, q-DBDHI)

**Goal:** Hardness foundations for pairing-based cryptography. Bilinear maps e: G_1 × G_2 → G_T enable new algebraic relations not possible with plain groups — but they also break DDH in G_1. A separate family of assumptions governs what remains hard in the pairing setting. These range from falsifiable (DBDH, DLIN, SXDH) to non-falsifiable q-type variants (q-SDH, q-DBDHI), and underpin IBE, short signatures, anonymous credentials, and ABE.

| Assumption | Year | Setting | Note |
|-----------|------|---------|------|
| **DBDH (Decisional Bilinear Diffie-Hellman)** | 2001 | Symmetric pairing e: G × G → G_T | Distinguish e(g,g)^{abc} from e(g,g)^r given (g^a, g^b, g^c); basis of Boneh-Franklin IBE [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_13) |
| **DLIN (Decisional Linear)** | 2004 | Prime-order group | Distinguish g^{a+b} from random given (g^{1/s}, g^{1/t}, g^{a/s}, g^{b/t}); falsifiable, holds even when DDH fails; used in Waters IBE [[1]](https://eprint.iacr.org/2004/172) |
| **SXDH (Symmetric External DH)** | 2006 | Asymmetric pairing G_1 ≠ G_2 | DDH hard in both G_1 and G_2 independently; strongest natural pairing assumption; used in Groth-Sahai proofs [[1]](https://eprint.iacr.org/2005/187) |
| **q-SDH (q-Strong Diffie-Hellman)** | 2004 | Bilinear group | Given (g, g^x, …, g^{x^q}), output (c, g^{1/(x+c)}) for chosen c; underlies Boneh-Boyen short signatures and BBS+ credentials [[1]](https://eprint.iacr.org/2004/171) |
| **q-DBDHI (q-Decision Bilinear DH Inversion)** | 2004 | Bilinear group | Distinguish e(g,g)^{1/x} from random given (g, g^x, …, g^{x^q}); basis of Boneh-Boyen IBE and short group signatures [[1]](https://eprint.iacr.org/2004/171) |
| **Subgroup Decision (Boneh-Shacham)** | 2002 | Composite-order bilinear group | Distinguish elements of subgroups in composite-order groups; alternative to DLIN in dual-system encryption [[1]](https://eprint.iacr.org/2002/139) |

**State of the art:** SXDH and DLIN are the leading falsifiable assumptions for pairing-based crypto; q-SDH and q-DBDHI enable tight reductions and shortest known constructions. Dual-system encryption (Waters 2009) achieved fully secure IBE/ABE under DLIN/subgroup decision. All pairing assumptions are broken by quantum computers. Cross-references: [DH assumption variants](#diffie-hellman-assumption-variants-cdh-ddh-gdh-q-dh-co-cdh), [predicate encryption](#predicate-encryption-and-attribute-hiding), [functional encryption](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Production
Deployed in Ethereum (BLS signatures), Zcash, and anonymous credential systems using BLS12-381 and BN254 curves.

**Implementations:**
- [blst](https://github.com/supranational/blst) ⭐ 554 — C/Rust, optimized BLS12-381 pairing library used in Ethereum
- [gnark-crypto](https://github.com/Consensys/gnark-crypto) ⭐ 590 — Go, BN254/BLS12-381 pairing implementations
- [mcl](https://github.com/herumi/mcl) ⭐ 520 — C++, high-speed pairing library supporting BN/BLS curves
- [Charm-Crypto](https://github.com/JHUISI/charm) ⭐ 633 — Python, pairing-based crypto framework (Groth-Sahai, IBE, ABE)
**Security status:** Secure
No known classical attacks at recommended parameters; all pairing assumptions broken by quantum computers.

**Community acceptance:** Standard
IETF standardized (BLS signatures); SXDH and DLIN are the leading falsifiable assumptions for pairing-based crypto.


---

## RSA Assumption Variants (RSA, Strong RSA, Flexible RSA)

**Goal:** Hardness of computing with RSA moduli. The RSA problem — computing eth roots modulo N = pq without knowing the factorization — underlies the oldest public-key cryptosystem. Stronger variants (Strong RSA, Flexible RSA) assert hardness even when the adversary can choose the exponent, enabling statistically hiding commitments, accumulators, and group signatures without random oracles. These assumptions sit between standard RSA and factoring in terms of strength.

| Assumption / Scheme | Year | Basis | Note |
|--------------------|------|-------|------|
| **RSA assumption** | 1977 | Factoring (conjectured) | Given (N, e, y), compute x with x^e ≡ y (mod N); exactly the hardness underlying RSA encryption and PKCS signatures [[1]](https://doi.org/10.1145/359340.359342) |
| **Strong RSA assumption** | 1998 | Factoring | Given (N, y), find any (e > 1, x) with x^e ≡ y (mod N); strictly stronger than RSA; implied by factoring; used in Cramer-Shoup signatures [[1]](https://eprint.iacr.org/1998/027) |
| **Flexible RSA (phi-hiding)** | 1999 | Factoring | Distinguishing whether a prime e divides phi(N) is hard; weaker than factoring; basis of the Cachin-Micali-Stadler PIR and some ring signature schemes [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_9) |
| **Cramer-Shoup signature (Strong RSA)** | 1999 | Strong RSA | First practical signature scheme with security proof under Strong RSA in the standard model (no random oracle); uses statistically hiding commitments as a building block [[1]](https://eprint.iacr.org/1998/027) |
| **Dynamic accumulator (Camenisch-Lysyanskaya)** | 2002 | Strong RSA | Cryptographic accumulator from Strong RSA: add/delete members and produce constant-size membership witnesses; basis of many anonymous credential systems [[1]](https://eprint.iacr.org/2002/007) |
| **RSA Full Domain Hash (RSA-FDH)** | 1993 | RSA + random oracle | Hash-then-sign in the random oracle model; tight reduction to RSA; standardized in PKCS#1 and forms the basis of RSASSA-PSS [[1]](https://eprint.iacr.org/1993/001) |

**State of the art:** Strong RSA is the standard-model hardness assumption for practical RSA-based signatures (Cramer-Shoup, Gennaro-Halevi-Rabin) and accumulators; standard RSA underlies deployed PKCS#1/PSS. phi-hiding is used for advanced PIR and niche protocols. All RSA assumptions are broken by quantum computers (Shor). Related to [DCR assumption](#decisional-composite-residuosity-dcr-assumption), [accumulators](09-commitments-verifiability.md#accumulators), and [VRF](09-commitments-verifiability.md#verifiable-random-functions-vrf).

**Production readiness:** Production
RSA is deployed ubiquitously in TLS, PKCS#1, code signing, and certificate infrastructure worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA encryption and PKCS#1/PSS signatures deployed everywhere
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive RSA implementation
- [ring](https://github.com/briansmith/ring) ⭐ 4.1k — Rust, RSA signature verification
- [GMP](https://gmplib.org/) — C, arbitrary-precision arithmetic underpinning RSA implementations
**Security status:** Secure
No known classical attacks at recommended key sizes (2048+ bits); broken by quantum computers (Shor's algorithm).

**Community acceptance:** Standard
NIST, IETF, and ISO standardized; RSA-PSS and PKCS#1 v2.2 are the recommended signature modes.


---

## Randomized Encodings for Garbling and iO

**Goal:** Replace a complex computation with a simpler one that reveals only the output. A randomized encoding (RE) of a function f on input x is a randomized string f̂(x; r) from which f(x) can be decoded but nothing else about x is learned. RE is the conceptual foundation of garbled circuits (Yao 1986), where each gate is encoded so that only the correct output wire label is revealed. RE also provides a clean framework for constructing iO: if the encoding function class is rich enough and the encoding is computable in NC¹, one can bootstrap iO from it.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Garbled circuits as RE (Yao)** | 1986 | Symmetric-key PRF / AES | Yao's garbling scheme is a randomized encoding of a Boolean circuit; the garbler encodes each gate with four ciphertexts; evaluator learns only the output [[1]](https://dl.acm.org/doi/10.1145/3335741.3335756) |
| **RE in NC¹ (Applebaum-Ishai-Kushilevitz)** | 2004 | OWF | Any poly-time function f has an RE computable in NC¹; implies parallel garbling and efficient secure computation in constant rounds [[1]](https://eprint.iacr.org/2004/141) |
| **Efficient garbling / half-gates (Zahur-Rosulek-Evans)** | 2015 | AES / fixed-key PRF | Half-gates scheme reduces the per-AND-gate cost from 4 to 2 ciphertexts; remains the practical standard for garbled circuit garbling [[1]](https://eprint.iacr.org/2014/756) |
| **RE-based iO bootstrapping (Ananth-Jain)** | 2015 | Single-key FE for NC¹ | Use RE in NC¹ to bootstrap iO from single-key FE for NC¹; RE is the key tool enabling compression of the encoding [[1]](https://eprint.iacr.org/2015/173) |
| **Arithmetic garbling (Applebaum-Ishai-Kushilevitz)** | 2011 | LWE | Extend garbling to arithmetic circuits over rings; garble additions and multiplications; enables efficient MPC over integers without bit decomposition [[1]](https://eprint.iacr.org/2012/097) |
| **Free XOR garbling (Kolesnikov-Schneider)** | 2008 | Correlation-robust hash | XOR gates require zero ciphertexts by fixing a global offset delta; reduces total garbling cost by ~40% for typical circuits [[1]](https://link.springer.com/chapter/10.1007/978-3-540-70583-3_40) |

**State of the art:** Half-gates + Free XOR (2015) is the practical gold standard for garbling; AES-NI-accelerated implementations achieve gigabit/second garbling rates. Theoretically, RE in NC¹ from OWF (AIK 2004) is foundational for iO bootstrapping. Related to [iO](#indistinguishability-obfuscation-io), [bootstrapping iO](#bootstrapping-io-functional-encryption--io), [MPC from minimal assumptions](#mpc-from-minimal-assumptions-mpc-from-owf), and [garbled circuits](06-multi-party-computation.md#garbled-circuits-expanded).

**Production readiness:** Production
Half-gates garbling with AES-NI acceleration is deployed in production MPC systems (emp-toolkit, ABY).

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit) — C++, half-gates garbling with AES-NI acceleration
- [swanky (GaloisInc)](https://github.com/GaloisInc/swanky) ⭐ 344 — Rust, garbled circuit library with half-gates and Free XOR
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, mixed-protocol framework including garbled circuits
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, next-gen MPC framework with garbling support
**Security status:** Secure
No known attacks on half-gates/Free XOR garbling under standard symmetric-key assumptions.

**Community acceptance:** Widely trusted
Garbled circuits are a standard MPC technique endorsed by the community; RE in NC1 is a foundational theoretical result.


---

## Monotone Span Programs and Cryptographic Access Structures

**Goal:** Represent and realize arbitrary access policies in secret sharing and ABE. A monotone span program (MSP) is a linear-algebraic model for computing monotone Boolean functions: a matrix M over a field and a labeling of rows to parties such that a set S can reconstruct a secret iff the rows labeled by S span a target vector. MSPs are strictly more powerful than Boolean formulas and capture all monotone circuits in a linear-algebraic form amenable to pairing-based cryptography. They are the representation of choice for access structures in ciphertext-policy ABE and linear secret sharing.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Monotone span programs (Karchmer-Wigderson)** | 1993 | Linear algebra / complexity | Introduce MSPs as a model for secret sharing complexity; show MSP size captures the monotone span of the access structure [[1]](https://doi.org/10.1016/0020-0190(93)90197-E) |
| **Linear secret sharing from MSPs (Brickell)** | 1989 | Linear algebra | Any MSP gives a linear secret sharing scheme (LSSS); reconstruction is a linear combination of shares; foundation for all pairing-based ABE [[1]](https://doi.org/10.1007/BF02341132) |
| **CP-ABE for MSP policies (Waters)** | 2011 | Bilinear pairings + DLIN | Ciphertext-policy ABE with access structures described by any MSP (equivalently, any monotone formula); first practical fully secure CP-ABE from DLIN [[1]](https://eprint.iacr.org/2008/290) |
| **KP-ABE from MSPs (Goyal-Pandey-Sahai-Waters)** | 2006 | Bilinear pairings | Key-policy ABE where the decryption key encodes an MSP policy and the attribute set is in the ciphertext; first selectively secure construction [[1]](https://eprint.iacr.org/2006/309) |
| **Arithmetic secret sharing from MSPs (Cramer-Damgård-Maurer)** | 2000 | Finite fields | Use MSPs over finite fields to define linear secret sharing schemes for MPC; share sizes match field elements; basis of CDM arithmetic MPC [[1]](https://link.springer.com/chapter/10.1007/3-540-45539-6_30) |
| **Optimal broadcast encryption from MSP (Wee)** | 2022 | Evasive LWE | Use structured MSPs over lattices to achieve optimal broadcast encryption and CP-ABE parameter sizes; replaces multilinear maps [[1]](https://eprint.iacr.org/2023/906) |

**State of the art:** MSPs are the standard representation of access policies in practical ABE (e.g., Charm-Crypto, OpenABE). Waters' CP-ABE (2011) from DLIN handles any MSP policy with prime-order groups. Post-quantum MSP-based ABE is an active research direction via evasive LWE (Wee 2022). Related to [predicate encryption](#predicate-encryption-and-attribute-hiding), [functional encryption from iO](#functional-encryption-from-io), [secret sharing](05-secret-sharing-threshold-cryptography.md), and [ABE/FE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Mature
MSP-based ABE is implemented in production-quality libraries (Charm-Crypto, OpenABE) and used in access control research systems.

**Implementations:**
- [Charm-Crypto](https://github.com/JHUISI/charm) ⭐ 633 — Python, MSP-based CP-ABE and KP-ABE schemes (Waters, BSW)
- [OpenABE](https://github.com/zeutro/openabe) ⭐ 274 — C++, ABE library with LSSS/MSP access structures
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, arithmetic MPC using LSSS from MSPs
**Security status:** Secure
No known attacks on MSP-based LSSS or ABE at recommended parameters under DLIN or LWE.

**Community acceptance:** Widely trusted
Standard representation for access policies in ABE; used in every major pairing-based ABE construction since 2006.


---

## Compute-and-Compare Obfuscation

**Goal:** Obfuscate programs of the form "compute f(x), then check if the result equals a target value t, and if so output a message s." This is a natural generalization of point function obfuscation: instead of checking x = t directly, one first applies a function f and then compares. Compute-and-compare (CaC) programs capture a rich class of access-control predicates (including lockable obfuscation and digital lockers) and can be securely obfuscated from LWE without requiring full iO.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Wichs-Zirdelis CaC obfuscation** | 2017 | LWE (via GGH15) | First construction of compute-and-compare obfuscation from LWE; obfuscate programs that output s iff f(x) = t for a public f; implies null-iO [[1]](https://eprint.iacr.org/2017/276) |
| **Goyal-Koppula-Waters CaC obfuscation** | 2017 | LWE | Independent construction of CaC obfuscation with different techniques; applications to lockable encryption and traitor tracing [[1]](https://eprint.iacr.org/2017/274) |
| **CaC for distributional indistinguishability** | 2018 | LWE | Strengthen CaC security to distributional indistinguishability: obfuscations of two CaC programs with high-entropy targets are indistinguishable [[1]](https://eprint.iacr.org/2018/511) |
| **CaC from evasive LWE** | 2022 | Evasive LWE | Cleaner CaC obfuscation from the evasive LWE assumption; avoids GGH15 graph-induced encodings [[1]](https://eprint.iacr.org/2022/1140) |

**State of the art:** CaC obfuscation from LWE (2017) is the strongest achievable program obfuscation from standard lattice assumptions. It implies [null-iO](#null-io-obfuscation-for-always-zero-circuits), [lockable obfuscation](#lockable-obfuscation), and non-trivial [witness encryption](#witness-encryption). The class of CaC programs captures many practical access-control scenarios without requiring full [iO](#indistinguishability-obfuscation-io).

**Production readiness:** Research
Purely theoretical; no public implementations of CaC obfuscation from LWE exist.

**Implementations:**
- No public open-source implementation available; theoretical construction from LWE
**Security status:** Secure
No known attacks; proven secure under LWE, with evasive LWE providing cleaner constructions.

**Community acceptance:** Emerging
Recognized as the strongest achievable obfuscation from standard lattice assumptions; growing research interest.


---

## Lockable Obfuscation

**Goal:** Obfuscate a program that outputs a message m only when the input matches a secret "lock" value, and outputs nothing otherwise. Lockable obfuscation is a special case of compute-and-compare obfuscation where f is the identity function, but it is powerful enough to imply point function obfuscation with multi-bit output, lockable encryption, and traitor tracing. Achievable from LWE, it is one of the strongest forms of program obfuscation known from standard assumptions.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Goyal-Koppula-Waters lockable obfuscation** | 2017 | LWE | First lockable obfuscation from LWE; program outputs m iff input = lock; implies point obfuscation with multi-bit output [[1]](https://eprint.iacr.org/2017/274) |
| **Wichs-Zirdelis lockable obfuscation** | 2017 | LWE | Independent construction; derive lockable obfuscation as a corollary of compute-and-compare obfuscation [[1]](https://eprint.iacr.org/2017/276) |
| **Lockable encryption from lockable obfuscation** | 2017 | LWE | Construct an encryption scheme where decryption requires both a key and a "lock" input; applications to traitor tracing and functional encryption [[1]](https://eprint.iacr.org/2017/274) |
| **Lockable obfuscation for ABE (Brakerski et al.)** | 2020 | LWE | Use lockable obfuscation as a building block toward ABE and witness encryption from LWE without multilinear maps [[1]](https://eprint.iacr.org/2020/1003) |

**State of the art:** Lockable obfuscation from LWE (2017) is well-established and practically the strongest obfuscation primitive achievable from standard assumptions. It is a key building block for [compute-and-compare obfuscation](#compute-and-compare-obfuscation), [point function obfuscation](#point-function-obfuscation--digital-locker), traitor tracing, and the path from LWE to [witness encryption](#witness-encryption).

**Production readiness:** Research
Purely theoretical primitive; no standalone implementations beyond proof-of-concept.

**Implementations:**
- No public open-source implementation available; theoretical primitive from LWE
**Security status:** Secure
No known attacks; proven secure under LWE assumptions.

**Community acceptance:** Emerging
Well-established building block for compute-and-compare obfuscation and point function obfuscation from LWE.


---

## Lattice-Based iO (Jain-Lin-Sahai Construction)

**Goal:** Construct indistinguishability obfuscation from well-studied lattice and coding-theoretic assumptions, avoiding multilinear maps entirely. The Jain-Lin-Sahai (JLS) construction (2021) is the first iO scheme based on (sub-exponentially secure) LWE, LPN, and a Boolean PRG assumption in NC0 — three assumptions that have been studied for decades. This resolved the long-standing open problem of basing iO on standard-like assumptions.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Jain-Lin-Sahai iO** | 2021 | LWE + LPN + PRG in NC0 | First iO from well-studied assumptions; uses structured seed PRG, LWE for FE bootstrapping, and LPN for noise flooding; STOC 2021 Best Paper [[1]](https://eprint.iacr.org/2020/1003) |
| **JLS simplified exposition (Gay-Pass)** | 2021 | Same as JLS | Simplified presentation of the JLS construction; clarifies the role of each assumption and the bootstrapping chain [[1]](https://eprint.iacr.org/2021/1397) |
| **Hopkins-Jain-Lin optimal PRG in NC0** | 2021 | Goldreich PRG | Study the specific Boolean PRG assumption needed by JLS; relate it to Goldreich's PRG and local PRG literature; establish parameters [[1]](https://eprint.iacr.org/2021/1437) |
| **Devadas-Quach-Wee-Wichs iO from circular security** | 2023 | LWE + circular security | Alternative iO construction replacing the PRG-in-NC0 assumption with circular security of LWE; reduces assumption count [[1]](https://eprint.iacr.org/2023/075) |

**State of the art:** JLS (2021) is the landmark result establishing iO from well-studied assumptions. The construction remains far from practical due to enormous polynomial blowups. Follow-up work aims to simplify assumptions (circular LWE, 2023) and improve efficiency. Foundational for all [iO](#indistinguishability-obfuscation-io)-based constructions including [FE from iO](#functional-encryption-from-io) and [software copy-protection](#software-copy-protection-from-io).

**Production readiness:** Research
Purely theoretical; enormous polynomial blowups make any implementation impractical with current technology.

**Implementations:**
- No public open-source implementation available; the construction has enormous polynomial blowups making implementation impractical
**Security status:** Secure
No known attacks; security reduces to LWE, LPN, and Boolean PRG in NC0, all well-studied assumptions.

**Community acceptance:** Widely trusted
Landmark result (STOC 2021 Best Paper) universally recognized as resolving the main open problem in obfuscation.


---

## Program Obfuscation for RAM Programs

**Goal:** Obfuscate programs that access memory via random access, rather than as Boolean circuits. Circuit-based iO requires "unrolling" a RAM program into a (potentially exponentially larger) circuit, destroying efficiency. RAM obfuscation aims to produce an obfuscated program whose running time is proportional to the RAM execution time, not the circuit size. This requires combining obfuscation with ORAM techniques to hide memory access patterns.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **iO for RAM programs (Canetti-Holmgren-Jain-Vaikuntanathan)** | 2015 | iO + ORAM | First iO for RAM programs; obfuscated program runs in time poly(T, lambda) where T is the RAM execution time; uses ORAM to hide access patterns [[1]](https://eprint.iacr.org/2015/057) |
| **FE for RAM programs (Cho-Döttling-Garg-Gupta-Miao-Srinivasan)** | 2020 | iO + ORAM | Functional encryption for RAM: decryption time matches RAM running time, not circuit depth; extends CHJV to the FE setting [[1]](https://eprint.iacr.org/2020/501) |
| **Succinct garbling for RAM (Gentry-Halevi-Rabin-Vaikuntanathan)** | 2014 | LWE | Garbled RAM: garble a RAM program so evaluation time is proportional to the RAM running time; does not require iO [[1]](https://eprint.iacr.org/2014/179) |
| **RAM obfuscation with poly overhead (Ananth-Lombardi)** | 2022 | Sub-exp iO + ORAM | Achieve RAM obfuscation with polynomial (rather than super-polynomial) overhead in the security parameter; tightens efficiency bounds [[1]](https://eprint.iacr.org/2022/1003) |

**State of the art:** RAM obfuscation from iO + ORAM (2015) is the foundational result; efficiency improvements (2022) reduce overhead to polynomial. Practical deployment awaits efficient iO. Relates to [iO](#indistinguishability-obfuscation-io), [garbled RAM](06-multi-party-computation.md#garbled-ram), [ORAM](10-privacy-preserving-computation.md#oblivious-ram-oram), and [succinct FE for Turing machines](#succinct-functional-encryption-for-turing-machines).

**Production readiness:** Research
Purely theoretical; requires efficient iO which does not yet exist, though ORAM components are available.

**Implementations:**
- No public open-source implementation of RAM obfuscation; ORAM components available in [PathORAM](https://github.com/nicola/oram) and [obliv-c](https://github.com/samee/obliv-c)
**Security status:** Secure
No known attacks; security reduces to iO and ORAM correctness assumptions.

**Community acceptance:** Niche
Important theoretical extension of circuit-based iO; studied in conjunction with garbled RAM and ORAM research.


---

## Multi-Input Functional Encryption

**Goal:** Functional encryption where a single function key can operate on ciphertexts from multiple, independent encryptors. In standard (single-input) FE, a function key sk_f decrypts a single ciphertext ct(x) to produce f(x). Multi-input FE (MIFE) allows sk_f to take ciphertexts ct_1(x_1), ..., ct_n(x_n) from n different parties and compute f(x_1, ..., x_n) — enabling non-interactive multi-party computation where parties encrypt independently and a key holder learns only the function output.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Multi-input FE from iO (Goldwasser-Gordon-Goyal-Jain-Koppula-Sahai)** | 2014 | iO + OWF | First MIFE for general functions; any number of inputs; constructed from iO and one-way functions [[1]](https://eprint.iacr.org/2013/727) |
| **MIFE for inner products (Abdalla-Catalano-Fiore-Gay-Ursu)** | 2018 | DDH / LWE / Paillier | Practical MIFE for multi-input inner products from DDH, LWE, or DCR; first efficient MIFE without iO [[1]](https://eprint.iacr.org/2017/972) |
| **Decentralized MIFE (Chotard-Dufour-Gay-Phan-Pointcheval)** | 2018 | DDH | MIFE where encryptors do not share a common setup beyond public parameters; decentralized key generation; practical for inner products [[1]](https://eprint.iacr.org/2017/989) |
| **MIFE for quadratic functions (Agrawal-Goyal-Tomida)** | 2021 | Bilinear maps | Extend MIFE beyond inner products to degree-2 polynomials from bilinear maps; first MIFE for non-linear functions without iO [[1]](https://eprint.iacr.org/2021/080) |
| **Unbounded MIFE from iO (Ananth-Jain-Sahai)** | 2015 | iO + OWF | MIFE for unbounded number of inputs; ciphertext size independent of the number of inputs [[1]](https://eprint.iacr.org/2015/163) |

**State of the art:** MIFE for inner products from DDH/LWE (2018) is practical and deployed in privacy-preserving analytics. General MIFE requires [iO](#indistinguishability-obfuscation-io) (2014). MIFE for quadratic functions from pairings (2021) is the frontier without iO. Relates to [FE from iO](#functional-encryption-from-io), [ABE/FE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption), and [spooky encryption](#spooky-encryption).

**Production readiness:** Experimental
Inner-product MIFE has working implementations in CiFEr and GoFE; general MIFE requires iO.

**Implementations:**
- [CiFEr](https://github.com/fentec-project/CiFEr) ⭐ 89 — C, multi-input inner-product FE from DDH and LWE
- [GoFE](https://github.com/fentec-project/gofe) ⭐ 195 — Go, multi-input FE for inner products and quadratic functions
**Security status:** Secure
No known attacks on inner-product MIFE under DDH or LWE at recommended parameters.

**Community acceptance:** Emerging
Inner-product MIFE gaining adoption in privacy-preserving analytics; general MIFE remains a research topic.


---

## Attribute-Hiding Predicate Encryption

**Goal:** Predicate encryption with the strongest privacy guarantee: the ciphertext hides both the plaintext and the attributes used for access control. In standard ABE, attributes are public metadata; in attribute-hiding PE, even the attributes are concealed. The decryptor learns only whether their key predicate is satisfied — and nothing else. Full attribute hiding for expressive predicates (beyond inner products) is closely tied to obfuscation-level hardness.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Full-hiding inner-product PE (Okamoto-Takashima)** | 2009 | DPVS + DLIN | First fully attribute-hiding PE for inner-product predicates using dual pairing vector spaces; both key and ciphertext attributes hidden [[1]](https://eprint.iacr.org/2009/457) |
| **Adaptively secure attribute-hiding PE (Okamoto-Takashima)** | 2012 | DPVS + DLIN | Upgrade to adaptive security via dual-system encryption in DPVS framework; fully secure attribute-hiding for inner products [[1]](https://eprint.iacr.org/2011/481) |
| **Attribute-hiding PE for CNF/DNF (Shi-Waters)** | 2008 | Composite-order pairings | Attribute-hiding PE for Boolean formulas over attributes; security under subgroup decision assumption [[1]](https://eprint.iacr.org/2008/290) |
| **Attribute-hiding PE from lattices (Agrawal-Freeman-Vaikuntanathan)** | 2011 | LWE | Post-quantum attribute-hiding inner-product PE from LWE; compact keys and ciphertexts [[1]](https://eprint.iacr.org/2011/457) |
| **Attribute-hiding for all circuits from iO (Waters)** | 2015 | iO + OWF | Full attribute-hiding PE for any polynomial-size circuit predicate; strongest known notion requires iO [[1]](https://eprint.iacr.org/2012/315) |

**State of the art:** Inner-product attribute-hiding PE is achievable from LWE (post-quantum, 2011) or DLIN (pairing-based, 2012). Full-circuit attribute hiding requires [iO](#indistinguishability-obfuscation-io) (2015). This is the privacy-maximizing variant of [predicate encryption](#predicate-encryption-and-attribute-hiding); relates to [evasive LWE](#evasive-lwe--tensor-lwe) and [HVE](07-homomorphic-functional-encryption.md#hidden-vector-encryption-hve).

**Production readiness:** Research
Inner-product attribute-hiding PE has prototype implementations; full-circuit attribute-hiding PE from iO remains theoretical.

**Implementations:**
- [CiFEr](https://github.com/fentec-project/CiFEr) ⭐ 89 — C, includes inner-product predicate encryption
- [GoFE](https://github.com/fentec-project/gofe) ⭐ 195 — Go, functional encryption library with inner-product PE support

**Security status:** Secure
Inner-product constructions proven secure under standard assumptions (LWE, DLIN); full-circuit constructions inherit iO assumptions.

**Community acceptance:** Niche
Well-studied in the cryptographic theory community; inner-product variants have standard security proofs but limited adoption outside academia.

---

## Obfuscation of Point Functions with Multi-Bit Output

**Goal:** Obfuscate a "digital locker" that stores an arbitrary-length secret. A point function with multi-bit output (MBPF) is a program P_{x,s} that outputs a string s on input x and outputs nothing on all other inputs. Unlike single-bit point functions (which output 1 or 0), MBPFs must hide a potentially long secret s. VBB obfuscation of MBPFs is achievable and is the foundation of password-based encryption, digital lockers, and honey encryption schemes.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Multi-bit point obfuscation in ROM (Canetti)** | 1997 | Random oracle | VBB obfuscation of MBPFs in the random oracle model; hash the input x and encrypt s under H(x); foundational construction [[1]](https://doi.org/10.1145/258533.258553) |
| **Multi-bit point obfuscation (Lynn-Prabhakaran-Sahai)** | 2004 | Strong DDH variant | First standard-model MBPF obfuscation under a strong one-more-DH assumption; output s on input x, nothing otherwise [[1]](https://eprint.iacr.org/2004/091) |
| **Multi-bit from lockable obfuscation (Goyal-Koppula-Waters)** | 2017 | LWE | Lockable obfuscation from LWE directly implies VBB-secure MBPF obfuscation; the lock is x and the message is s [[1]](https://eprint.iacr.org/2017/274) |
| **Composable MBPF obfuscation (Bitansky-Canetti)** | 2010 | Strong assumptions | Composable obfuscation of MBPFs: security holds even when multiple obfuscated MBPFs are combined; needed for complex applications [[1]](https://eprint.iacr.org/2010/248) |

**State of the art:** MBPF obfuscation from LWE via lockable obfuscation (2017) is the strongest standard-assumption construction. The ROM-based approach (hash-and-encrypt) remains the practical standard for password-derived encryption. Relates to [point function obfuscation](#point-function-obfuscation--digital-locker), [lockable obfuscation](#lockable-obfuscation), and [honey encryption](02-authenticated-structured-encryption.md).

**Production readiness:** Research
ROM-based hash-and-encrypt digital lockers are used in practice; standard-model MBPF constructions remain academic prototypes.

**Implementations:**
- No dedicated open-source MBPF obfuscation libraries; ROM-based constructions are trivially implemented via hash-then-encrypt patterns in any cryptographic library.

**Security status:** Secure
ROM-based constructions are secure under random oracle assumption; standard-model constructions proven under LWE via lockable obfuscation (2017).

**Community acceptance:** Niche
Theoretically well-understood; the ROM variant is implicitly used in password-based encryption but rarely referenced as "MBPF obfuscation" in practice.

---

## Predicate Encryption from Lattices

**Goal:** Construct predicate encryption — where both the access policy and ciphertext attributes are hidden — from lattice assumptions alone, enabling post-quantum attribute-hiding access control. Lattice-based PE avoids bilinear pairings entirely and inherits the conjectured quantum resistance of LWE/SIS. The main challenge is achieving expressive predicates (beyond inner products) while maintaining attribute hiding and compact parameters.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Inner-product PE from LWE (Agrawal-Freeman-Vaikuntanathan)** | 2011 | LWE | First lattice PE; attribute-hiding for inner-product predicates; ciphertext and key sizes polynomial in dimension [[1]](https://eprint.iacr.org/2011/457) |
| **PE for bounded-depth circuits from LWE (Gorbunov-Vaikuntanathan-Wee)** | 2015 | LWE | Extend lattice PE to bounded-depth Boolean circuits; payload-hiding (weaker than full attribute hiding) from standard LWE [[1]](https://eprint.iacr.org/2014/944) |
| **Attribute-hiding PE from evasive LWE (Wee)** | 2022 | Evasive LWE | Full attribute-hiding CP-ABE and PE for NC1 from evasive LWE; near-optimal parameters without pairings or iO [[1]](https://eprint.iacr.org/2023/906) |
| **PE from tensor LWE (Tsabary)** | 2022 | Tensor LWE | Predicate encryption for constant-arity predicates from tensor LWE; new lattice assumption tailored to PE [[1]](https://eprint.iacr.org/2023/941) |
| **Lattice ABE for all circuits (Boneh-Gentry-Gorbunov-Halevi-Nikolaenko-Segev-Vaikuntanathan-Vinayagamurthy)** | 2014 | LWE | Key-policy ABE for all circuits from LWE; payload-hiding but not attribute-hiding; foundational for lattice-based access control [[1]](https://eprint.iacr.org/2013/340) |

**State of the art:** Inner-product attribute-hiding PE from LWE (2011) is well-established; attribute-hiding PE for NC1 from evasive LWE (Wee 2022) is the frontier. Full-circuit attribute-hiding PE from lattices alone remains open without evasive/tensor LWE. Relates to [predicate encryption](#predicate-encryption-and-attribute-hiding), [evasive LWE](#evasive-lwe--tensor-lwe), [ABE/FE](07-homomorphic-functional-encryption.md#attribute-based--functional-encryption).

**Production readiness:** Research
Inner-product lattice PE has prototype implementations; more expressive lattice PE from evasive/tensor LWE remains purely theoretical.

**Implementations:**
- [CiFEr](https://github.com/fentec-project/CiFEr) ⭐ 89 — C, inner-product functional/predicate encryption from LWE
- [FHEW/OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, lattice cryptography library with ABE building blocks

**Security status:** Secure
Proven secure under LWE for inner-product predicates; evasive LWE and tensor LWE assumptions are newer and less battle-tested.

**Community acceptance:** Emerging
Active research area with growing interest due to post-quantum properties; evasive LWE constructions receiving significant attention since 2022.

---

## Evasive LWE and the iO Landscape

**Goal:** Map the role of evasive LWE in bridging the gap between standard LWE and full iO. Evasive LWE (introduced by Wee, 2022) asserts that certain structured LWE samples remain pseudorandom even when the adversary receives auxiliary trapdoor information — but only for "evasive" distributions where the auxiliary information is hard to use. This assumption is weaker than iO yet powerful enough to yield witness encryption, null-iO, optimal broadcast encryption, and attribute-hiding ABE — serving as a crucial intermediate assumption in the post-quantum obfuscation landscape.

| Scheme / Result | Year | Basis | Note |
|-----------------|------|-------|------|
| **Optimal broadcast encryption from evasive LWE (Wee)** | 2022 | Evasive LWE | First post-quantum broadcast encryption with poly(log N) parameter sizes; key application of evasive LWE [[1]](https://eprint.iacr.org/2023/906) |
| **Witness encryption from evasive LWE (Vaikuntanathan-Wee-Wichs)** | 2022 | Evasive LWE | Construct non-trivial witness encryption and null-iO from evasive LWE; avoids multilinear maps and full iO [[1]](https://eprint.iacr.org/2022/1140) |
| **Counterexamples to private-coin evasive LWE** | 2024 | Attacks | Several private-coin formulations of evasive LWE shown false via algebraic attacks; narrows the viable assumption space [[1]](https://eprint.iacr.org/2024/2000) |
| **Evasive LWE vs. tensor LWE landscape** | 2023 | Comparison | Study relationships between evasive LWE and tensor LWE; show separations and implications for ABE, PE, and broadcast encryption [[1]](https://eprint.iacr.org/2023/941) |
| **CP-ABE for NC1 from evasive LWE** | 2022 | Evasive LWE | First post-quantum ciphertext-policy ABE for NC1 circuits with attribute hiding and near-optimal parameters [[1]](https://eprint.iacr.org/2023/906) |

**State of the art:** Public-coin evasive LWE (2022) is the leading post-quantum assumption for advanced primitives between standard LWE and full iO. Private-coin variants face counterexamples (2024). The assumption enables a rich landscape of constructions previously requiring multilinear maps or iO. Relates to [evasive LWE & tensor LWE](#evasive-lwe--tensor-lwe), [null-iO](#null-io-obfuscation-for-always-zero-circuits), [witness encryption](#witness-encryption), and [lattice-based iO](#lattice-based-io-jain-lin-sahai-construction).

**Production readiness:** Research
All constructions from evasive LWE remain at the academic/prototype stage; no production implementations exist.

**Implementations:**
- No dedicated open-source implementations; constructions are described in papers and verified in proof-of-concept code only.

**Security status:** Caution
Public-coin evasive LWE appears sound but is a relatively new assumption (2022); private-coin variants have known counterexamples (2024). Requires further cryptanalytic scrutiny.

**Community acceptance:** Emerging
Rapidly growing interest since Wee's 2022 introduction; major results at top venues (CRYPTO, EUROCRYPT); considered the most promising post-quantum path to advanced obfuscation primitives.

---
