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
