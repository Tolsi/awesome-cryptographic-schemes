# Quantum Cryptography & Post-Quantum

## Quantum Key Distribution (QKD)

**Goal:** Information-theoretic key establishment. Distribute a shared secret key using quantum mechanics — any eavesdropping attempt disturbs the quantum state and is detectable. Unlike PQ crypto (software), QKD requires quantum hardware.

| Protocol | Year | Encoding | Note |
|----------|------|----------|------|
| **BB84** | 1984 | Photon polarization | First QKD protocol; 4 polarization states [[1]](https://www.sciencedirect.com/science/article/pii/S0304397514004241) |
| **E91** | 1991 | Entangled pairs | Bell inequality violation as security test [[1]](https://link.springer.com/chapter/10.1007/978-3-319-53412-1_2) |
| **B92** | 1992 | 2 non-orthogonal states | Simpler than BB84; less efficient [[1]](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.68.3121) |
| **MDI-QKD** | 2012 | Measurement-device-independent | Removes detector side-channels; more practical [[1]](https://eprint.iacr.org/2012/003) |
| **Microsatellite QKD (Jinan-1)** | 2025 | Satellite + BB84 | 23kg quantum microsatellite; space-to-ground QKD over 12,900km; 1.07M secure bits/pass; Nature 2025 [[1]](https://www.nature.com/articles/s41586-025-08739-z) |

**State of the art:** BB84 (deployed in commercial QKD, China's Micius satellite), MDI-QKD (practical lab deployments), Jinan-1 (2025, microsatellite QKD).

---

## Quantum Money / Quantum Tokens

**Goal:** Unclonable currency. Banknotes are quantum states — the no-cloning theorem prevents counterfeiting. Impossible to achieve classically (any digital data can be copied). A foundational quantum cryptographic primitive beyond QKD.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wiesner's Quantum Money** | 1983 | Conjugate coding | First proposal; bank verifies; uses BB84-like states [[1]](https://doi.org/10.1145/1008908.1008920) |
| **Aaronson-Christiano Public Quantum Money** | 2012 | Hidden subspaces | Public verification; anyone can verify without the bank [[1]](https://doi.org/10.1145/2213977.2213983) |
| **Zhandry Quantum Lightning** | 2019 | Cryptographic assumptions | Strongest form: even the minter cannot create two identical bolts [[1]](https://eprint.iacr.org/2018/1105) |

**State of the art:** Quantum lightning (Zhandry 2019); theoretical — requires quantum computers for creation/verification. See [QKD](#quantum-key-distribution-qkd).

---

## Quantum Copy-Protection / Uncloneable Encryption

**Goal:** Software anti-piracy from quantum mechanics. Encode a program or decryption key as a quantum state — the no-cloning theorem prevents making copies. A user can run the program but cannot duplicate it for others. Classically impossible; quantumly achievable for certain function classes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Aaronson Quantum Copy-Protection** | 2009 | Quantum oracles | First formal definition; copy-protect point functions in oracle model [[1]](https://doi.org/10.1109/CCC.2009.42) |
| **Broadbent-Lord Uncloneable Encryption** | 2020 | BB84 states | Ciphertext is a quantum state; cannot be copied even by key holder [[1]](https://eprint.iacr.org/2019/1146) |
| **Coladangelo-Liu-Liu-Zhandry Copy-Protection** | 2021 | Quantum FHE | Copy-protect compute-and-compare programs from standard assumptions [[1]](https://eprint.iacr.org/2020/1005) |
| **Ananth-Kaleoglu-Li-Liu-Zhandry** | 2023 | iO + quantum | Copy-protect all unlearnable functions (general result) [[1]](https://eprint.iacr.org/2023/356) |

**State of the art:** Copy-protection for all unlearnable functions (2023); uncloneable encryption deployed-ready. Extends [Quantum Money](#quantum-money--quantum-tokens) and [QKD](#quantum-key-distribution-qkd).

---

## Position-Based Quantum Cryptography

**Goal:** Location as sole credential. Cryptographic protocols where your geographic position is the only authentication factor — you can decrypt or participate only if you are physically at a specific location. Classically impossible against colluding adversaries; quantumly achievable via no-cloning.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Buhrman-Chandran-Fehr-Gelles-Goyal-Ostrovsky-Schaffner** | 2011 | Quantum + relativistic | First position-based QKD; secure against bounded quantum storage [[1]](https://doi.org/10.1007/978-3-642-22792-9_27) |
| **Position Verification with Single-Qubit** | 2014 | BB84-like | Simplified protocol using single-qubit messages [[1]](https://doi.org/10.1007/978-3-662-44381-1_8) |
| **Uncloneable Position Verification** | 2023 | No-cloning + relativity | Composable security from no-cloning + speed of light [[1]](https://eprint.iacr.org/2023/1643) |

**State of the art:** Theoretical; requires relativistic constraints (speed of light). Extends [QKD](#quantum-key-distribution-qkd) to spatial authentication.

---

## Certified Quantum Randomness / Proof of Quantumness

**Goal:** Generate provably random bits using a quantum device — even if you don't trust the device. A classical client sends challenge circuits to an untrusted quantum processor; the client verifies outputs classically, certifying genuine entropy. No Bell test or device trust required.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brakerski-Christiano-Mahadev-Vazirani** | 2018 | LWE + quantum | First proof of quantumness protocol; classical verifier certifies quantum computation [[1]](https://arxiv.org/abs/1804.00640) |
| **Aaronson-Hung Certified Randomness** | 2023 | Random circuit sampling | Certify randomness from quantum processor via random circuit challenges [[1]](https://arxiv.org/abs/2303.01625) |
| **Quantinuum Certified Randomness (Nature)** | 2025 | 56-qubit trapped-ion | First experimental demonstration: 71,313 certified random bits from untrusted quantum processor [[1]](https://www.nature.com/articles/s41586-025-08737-1) |

**State of the art:** Quantinuum H2-1 demonstration (Nature 2025); a new primitive class at intersection of [QKD](#quantum-key-distribution-qkd), [Randomness Beacons](#randomness-beacons--coin-tossing), and computational complexity.

---

## Post-Quantum Cryptography

Schemes designed to resist attacks from quantum computers (Shor's algorithm breaks RSA, DH, ECC; Grover halves symmetric key security).

### PQ Key Encapsulation (KEM) / Encryption

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ML-KEM (Kyber)** | 2024 | Module lattices (MLWE) | **NIST standard (FIPS 203)**; used in Chrome, Signal [[1]](https://csrc.nist.gov/pubs/fips/203/final) |
| **FrodoKEM** | 2016 | Standard lattices (LWE) | More conservative; no ring structure [[1]](https://frodokem.org/files/FrodoKEM-specification-20210604.pdf) |
| **Classic McEliece** | 2017 | Code-based (Goppa) | Very large keys (~1 MB), very small ciphertexts; NIST round 4 [[1]](https://classic.mceliece.org/) |
| **BIKE** | 2017 | Code-based (QC-MDPC) | Moderate key sizes; NIST round 4 [[1]](https://bikesuite.org/) |
| **HQC** | 2017 | Code-based (Hamming QC) | NIST round 4 alternate [[1]](https://pqc-hqc.org/) |
| **NTRU** | 1996 | Lattice (NTRU) | One of the oldest PQ schemes (1996); patents expired [[1]](https://eprint.iacr.org/1996/002) |

### PQ Digital Signatures

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ML-DSA (Dilithium)** | 2024 | Module lattices (MLWE) | **NIST standard (FIPS 204)**; general-purpose PQ sig [[1]](https://csrc.nist.gov/pubs/fips/204/final) |
| **SLH-DSA (SPHINCS+)** | 2024 | Hash-based (stateless) | **NIST standard (FIPS 205)**; conservative, no lattice assumption [[1]](https://csrc.nist.gov/pubs/fips/205/final) |
| **FN-DSA (Falcon)** | 2024 | NTRU lattices | NIST standard (FIPS 206); compact signatures, complex signing [[1]](https://csrc.nist.gov/pubs/fips/206/final) |
| **XMSS** | 2011 | Hash-based (stateful) | RFC 8391; stateful — must track index [[1]](https://www.rfc-editor.org/rfc/rfc8391) |
| **LMS / HSS** | 2019 | Hash-based (stateful) | RFC 8554; NIST SP 800-208; simple stateful scheme [[1]](https://www.rfc-editor.org/rfc/rfc8554) |
| **SQIsign** | 2020 | Supersingular isogenies | Shortest PQ signatures (~200 B); very new [[1]](https://eprint.iacr.org/2020/1240) |

### PQ Zero-Knowledge

| Approach | Year | Note |
|----------|------|------|
| **STARKs** | 2018 | Hash-based; inherently post-quantum [[1]](https://eprint.iacr.org/2018/046) |
| **Lattice-based ZK** | 2011 | Emerging; based on SIS/LWE [[1]](https://eprint.iacr.org/2011/537) |

### PQ Key Exchange / Hybrid

| Protocol | Year | Note |
|----------|------|------|
| **X25519Kyber768** | 2024 | Hybrid: classical X25519 + ML-KEM-768; deployed in Chrome, Signal, Cloudflare [[1]](https://eprint.iacr.org/2016/1017) |
| **PQ Noise** | 2016 | Noise Framework patterns with PQ KEMs [[1]](https://noiseprotocol.org/noise.html) |

**State of the art:** ML-KEM (FIPS 203) for encryption, ML-DSA (FIPS 204) for signatures, SLH-DSA for conservative hash-based sigs, hybrid X25519+ML-KEM for transition period.

---

## Isogeny-Based Cryptography

**Goal:** Post-quantum cryptography based on the computational hardness of finding isogenies (structure-preserving maps) between elliptic curves. Isogeny problems appear to resist quantum algorithms, including Shor's algorithm, offering a foundation for PQ signatures and key exchange distinct from lattice assumptions.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **SIDH/SIKE** | 2011 | Key exchange | *Broken* (2022) — Castryck-Decru attack recovered key in <1h; now fully insecure [[1]](https://eprint.iacr.org/2022/975) |
| **CSIDH** | 2018 | PQ-NIKE / key exchange | Group action on supersingular curves over Fp; quantum-safe (sub-exponential quantum attack) [[1]](https://eprint.iacr.org/2018/383) |
| **SQIsign** | 2020 | Digital signature | Shortest PQ signatures: ~200 B (vs. Dilithium ~2.4 KB); slow key gen and signing [[1]](https://sqisign.org/) |
| **SQIsign2D** | 2024 | Digital signature | 2× faster signing than SQIsign; NIST PQC Round 2 (onramp) alternate [[1]](https://eprint.iacr.org/2023/436) |
| **FESTA** | 2023 | Key exchange | Based on SIDH with trapdoor; partially addresses SIDH attacks [[1]](https://eprint.iacr.org/2023/660) |
| **PEGASIS** | 2024 | Signature | Group-action-based signature from CSIDH; compact; NIST onramp [[1]](https://eprint.iacr.org/2024/344) |

**Security landscape after SIDH break (2022):** CSIDH and SQIsign remain secure — they use different isogeny structures (commutative group actions vs. non-commutative KLPT walks). SIDH's auxiliary torsion point information was the attack surface; CSIDH does not expose it.

**Trade-offs vs. lattices (ML-KEM/ML-DSA):**
- Smaller signatures (SQIsign ~200 B vs. Falcon ~1.3 KB) but 10–100× slower
- Conservative security assumption (group action DLP vs. MLWE)
- No NIST standard yet; SQIsign2D in Round 2 additional signatures

**State of the art:** SQIsign2D (2024) is the leading candidate for ultra-compact PQ signatures; submission in NIST PQC additional signatures Round 2. CSIDH for research-grade PQ-NIKE. No production deployments yet.

---

## Lattice Isomorphism Problem (LIP) / HAWK

**Goal:** PQ crypto from a new hard problem. The Lattice Isomorphism Problem: given two lattices, determine if they are isomorphic (related by an orthogonal transformation). A fundamentally different hardness assumption from LWE/SIS — no floating-point arithmetic, no rejection sampling.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HAWK** | 2022 | Module LIP | PQ signature from LIP; 4x faster signing than Falcon; no floating-point; NIST Additional Sigs Round 2 [[1]](https://eprint.iacr.org/2022/1155) |
| **LIP Public-Key Encryption** | 2024 | LIP | First PKE from LIP; distinct from LWE-based PKE [[1]](https://eprint.iacr.org/2023/1093) |
| **Ducas-Postlethwaite-Pulles-van Woerden** | 2022 | LIP analysis | Security analysis; LIP is NP-hard in general; ASIACRYPT 2022 [[1]](https://eprint.iacr.org/2022/1155) |

**State of the art:** HAWK (NIST Round 2); LIP as a new assumption class alongside LWE/SIS in [Post-Quantum Cryptography](#post-quantum-cryptography).

---

## Equivalence-Based PQ Signatures

**Goal:** PQ signatures from code/form equivalence problems. A new family of hardness assumptions: is code C₁ equivalent to code C₂ under some transformation? Fundamentally different from lattice, hash, or multivariate assumptions. Multiple NIST Round 2 candidates.

| Scheme | Year | Problem | Note |
|--------|------|---------|------|
| **LESS** | 2020 | Linear code equivalence | Monomial equivalence of linear codes; Fiat-Shamir on permutation identification [[1]](https://less-project.github.io/) |
| **MEDS** | 2022 | Matrix code equivalence | Row+column operations on matrix codes; distinct algebraic structure [[1]](https://meds-pqc.org/) |
| **ALTEQ** | 2022 | Alternating trilinear form eq. | Equivalence of multilinear algebraic objects [[1]](https://doi.org/10.1007/978-3-031-22966-4_11) |
| **CROSS** | 2023 | Restricted syndrome decoding | MPCitH on restricted error sets; NIST Round 2 [[1]](https://cross-crypto.com/) |

**State of the art:** LESS, MEDS, CROSS (all NIST Additional Sigs Round 2). A genuinely new problem class for [Post-Quantum](#post-quantum-cryptography) signatures.

---
