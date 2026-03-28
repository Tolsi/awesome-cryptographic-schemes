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

## NTRU Prime / Streamlined NTRU Prime

**Goal:** Lattice-based KEM without cyclotomic ring structure. NTRU Prime deliberately avoids the ring Z[x]/(xⁿ−1) used by NTRU and NTTFriendly lattices, replacing it with Z[x]/Φ(x) for a prime-degree irreducible polynomial. This eliminates potential algebraic attack surfaces (e.g., sub-group attacks) present in cyclotomic rings while retaining NTRU's speed and compactness. Streamlined NTRU Prime (sntrup) is the IND-CCA2–secure KEM variant; NTRU LPRime (ntrulpr) is an LPR-style variant.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **NTRU Prime** | 2017 | Non-cyclotomic NTRU lattice | Bernstein–Chuengsatiansup–Lange–van Vredendaal; avoids cyclotomic structure [[1]](https://ntruprime.cr.yp.to/ntruprime-20170816.pdf) |
| **sntrup761 (Streamlined NTRU Prime)** | 2019 | Non-cyclotomic NTRU | Default key-exchange in OpenSSH since 2022; IETF draft for hybrid sntrup761x25519-sha512 [[1]](https://datatracker.ietf.org/doc/draft-ietf-sshm-ntruprime-ssh/) |
| **ntrulpr761 (NTRU LPRime)** | 2019 | Non-cyclotomic LPR | LPR-style variant; slightly larger keys but simpler decapsulation [[1]](https://ntruprime.cr.yp.to/) |

**Why non-cyclotomic matters:** Classical NTRU operates in Z[x]/(xⁿ−1), a ring with non-trivial ideal structure. NTRU Prime uses a degree-761 irreducible prime polynomial; the quotient ring is a field, closing off information-leakage paths that arise from unit factorizations in cyclotomic rings. No concrete attack exploiting cyclotomic structure in NTRU is known, but NTRU Prime provides a cleaner security argument. It was a NIST Round 3 alternate (not selected for FIPS standards).

**Deployment:** sntrup761 is the default PQ algorithm in OpenSSH (as of 8.5, 2021), where it is combined with X25519 in a hybrid handshake — the largest real-world deployment of any NTRU-family scheme.

**State of the art:** sntrup761 deployed in OpenSSH; IETF draft for SSH hybrid key exchange. Not a NIST FIPS standard, but the most widely deployed non-ML-KEM PQ KEM in practice. Complements [Post-Quantum Cryptography](#post-quantum-cryptography) and [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange).

---

## Classic McEliece (Code-Based KEM)

**Goal:** Maximally conservative post-quantum KEM from coding theory. Classic McEliece is a key encapsulation mechanism built on the McEliece (1978) and Niederreiter (1986) frameworks using binary Goppa codes — the same hard problem that has resisted attack for nearly 50 years. Security is based solely on the hardness of decoding random linear codes and the indistinguishability of Goppa codes from random codes, with no algebraic structure exploitable by quantum algorithms including Shor's or Grover's.

| Parameter Set | Public Key | Ciphertext | Security Level | Note |
|---------------|-----------|-----------|---------------|------|
| **mceliece348864** | 261 KB | 128 B | ~128-bit classical | Smallest; NIST Round 4 |
| **mceliece460896** | 524 KB | 188 B | ~192-bit classical | Mid-range |
| **mceliece6688128** | 1.04 MB | 240 B | ~256-bit classical | Recommended for long-term security [[1]](https://classic.mceliece.org/) |
| **mceliece6960119** | 1.05 MB | 226 B | ~256-bit classical | Alternative 256-bit; slightly smaller ciphertext [[1]](https://classic.mceliece.org/) |
| **mceliece8192128** | 1.36 MB | 240 B | >256-bit classical | Highest security; largest keys [[1]](https://classic.mceliece.org/) |

**Security properties:** Known attacks on Classic McEliece cost substantially more than attacks on ML-KEM at equivalent ciphertext size — it sits farther from lattice attacks. The 50-year track record of Goppa-code–based hardness makes it the most conservative PQ KEM available. Ciphertexts are tiny (~128–240 bytes); public keys are very large (~261 KB–1.36 MB), making it impractical for constrained channels but ideal for long-lived key storage.

**NIST status:** Classic McEliece was a Round 4 alternate KEM candidate. Not selected in the initial 2024 FIPS batch (FIPS 203/204/205/206) primarily due to key size. NIST has indicated it may standardize it as a specialized long-term option alongside ML-KEM.

**State of the art:** No FIPS standard yet; reference implementation at classic.mceliece.org. Best suited for scenarios where ciphertext bandwidth is abundant but key rotation is infrequent, e.g., long-lived IoT provisioning or archival encryption [[1]](https://csrc.nist.gov/csrc/media/Projects/post-quantum-cryptography/documents/pqc-seminars/presentations/18-classic-mceliece-09172024.pdf). See also [Post-Quantum Cryptography](#post-quantum-cryptography) for BIKE and HQC.

---

## HQC (Hamming Quasi-Cyclic) — FIPS 207

**Goal:** Code-based KEM backup to ML-KEM. HQC (Hamming Quasi-Cyclic) is a key encapsulation mechanism whose security rests on the hardness of decoding random quasi-cyclic codes in the Hamming metric — a different mathematical foundation from the module-lattice problem underlying ML-KEM (FIPS 203). NIST selected HQC as a fifth PQC standard (March 2025) precisely to provide a code-based fallback: if a structural weakness in ML-KEM were found, HQC would remain secure.

| Parameter Set | Public Key | Ciphertext | Security Level | Note |
|---------------|-----------|-----------|---------------|------|
| **HQC-128** | 2.2 KB | 4.4 KB | NIST Level 1 (~128-bit) | Smallest; fast [[1]](https://pqc-hqc.org/) |
| **HQC-192** | 4.5 KB | 9.0 KB | NIST Level 3 (~192-bit) | Mid-range [[1]](https://pqc-hqc.org/) |
| **HQC-256** | 7.2 KB | 14.4 KB | NIST Level 5 (~256-bit) | Highest security [[1]](https://pqc-hqc.org/) |

**Design:** HQC encodes a message using a Reed-Solomon–Reed-Muller concatenated code and adds quasi-cyclic noise. The public key is a noisy codeword; decapsulation decodes using the underlying error-correcting code. Quasi-cyclic structure enables compact representation (public keys ~2–7 KB) compared to Classic McEliece (~261 KB–1 MB), at the cost of a less conservative algebraic assumption.

**NIST standardization:** Selected March 2025 as the fifth NIST PQC algorithm. Will be standardized as **FIPS 207** (draft expected ~2026, final ~2027). Positioned as a code-based alternative KEM, not a replacement for ML-KEM. BIKE and Classic McEliece remain Round 4 alternates without a FIPS track currently [[1]](https://www.nist.gov/news-events/news/2025/03/nist-selects-hqc-fifth-algorithm-post-quantum-encryption).

**State of the art:** FIPS 207 forthcoming (~2027). Recommended alongside ML-KEM for defense-in-depth (dual-algorithm key exchange). See [Post-Quantum Cryptography](#post-quantum-cryptography) for ML-KEM and [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange).

---

## Twin-Field QKD (TF-QKD)

**Goal:** Break the repeater-less QKD distance bound. Conventional QKD protocols (BB84, MDI-QKD) have secret-key rates that scale linearly with channel transmittance η, imposing a fundamental rate-distance limit called the PLOB bound. Twin-Field QKD (2018) achieves key rates scaling as √η — the square root of transmittance — by exploiting single-photon interference at an untrusted relay, enabling secure key distribution over record distances without a trusted quantum repeater.

| Protocol Variant | Year | Encoding | Note |
|-----------------|------|----------|------|
| **TF-QKD (Lucamarini et al.)** | 2018 | Phase-encoded weak coherent pulses | Original proposal; breaks PLOB bound [[1]](https://www.nature.com/articles/s41586-018-0066-6) |
| **Phase-Matching QKD (PM-QKD)** | 2018 | Phase-locked coherent pulses | Removes need for global phase post-selection [[1]](https://arxiv.org/abs/1805.09629) |
| **Sending-or-Not-Sending (SNS)** | 2018 | Asymmetric basis choice | Highest key rate in practice; composable finite-key proof [[1]](https://arxiv.org/abs/1805.01778) |
| **No-Phase-Post-Selection (NPP-TF-QKD)** | 2019 | Simplified phase encoding | Eliminates phase-slice reconciliation; more efficient [[1]](https://arxiv.org/abs/1910.06050) |
| **High-Dimensional TF-QKD** | 2025 | Multi-time-bin encoding | Further rate improvement beyond √η scaling [[1]](https://quantum-journal.org/papers/q-2025-10-01-1869/) |

**Distance records:** TF-QKD has repeatedly pushed the secure-transmission distance record, now standing at approximately 833 km over standard optical fiber — roughly double the practical range of MDI-QKD and more than triple that of BB84. This is achieved without trusted intermediate nodes.

**Implementation challenges:** All TF-QKD variants require precise phase synchronization between the two distant transmitters. Current systems use optical frequency combs or phase-locked loops over dedicated reference fibers. A 2025 plug-and-play architecture demonstrated stable operation over 50 km with 87% single-photon detection efficiency, significantly reducing deployment complexity [[1]](https://quantumzeitgeist.com/87-percent-quantum-efficiency-plug-play-twin-field-key-distribution-achieves-bit/).

**State of the art:** SNS-TF-QKD holds the distance record (~833 km); security proofs cover composable finite-key regimes against general attacks. TF-QKD is the primary candidate for metropolitan-to-intercity fiber QKD in the pre-repeater era. Extends [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd); complements [quantum repeater](#quantum-repeaters--quantum-networks) research for the full-network future.

---

## Hybrid PQ/Classical Key Exchange

**Goal:** Cryptographic agility during the post-quantum transition. A hybrid key exchange combines a classical algorithm (e.g., X25519, P-256) with a post-quantum KEM (e.g., ML-KEM) in a single handshake. The shared secret is derived from both; security holds if either component is unbroken. This provides "harvest-now, decrypt-later" protection immediately while preserving classical security if a PQ scheme is later found weak.

| Construction | Year | Classical | PQ | Deployed In |
|-------------|------|-----------|-----|-------------|
| **X25519MLKEM768** | 2024 | X25519 | ML-KEM-768 | Chrome, Firefox, Cloudflare, Signal [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-ecdhe-mlkem/) |
| **SecP256r1MLKEM768** | 2024 | ECDHE P-256 | ML-KEM-768 | TLS 1.3 IETF draft; enterprise CA compatibility [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-ecdhe-mlkem/) |
| **SecP384r1MLKEM1024** | 2024 | ECDHE P-384 | ML-KEM-1024 | High-security TLS; government use [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-ecdhe-mlkem/) |
| **sntrup761x25519-sha512** | 2021 | X25519 | sntrup761 | OpenSSH default since 8.5 [[1]](https://datatracker.ietf.org/doc/draft-ietf-sshm-ntruprime-ssh/) |
| **PQ IKEv2 (RFC 9370)** | 2023 | IKE DH group | Any PQ KEM | IPsec/IKEv2 additional key exchanges [[1]](https://www.rfc-editor.org/rfc/rfc9370) |
| **Hybrid HPKE** | 2025 | ECDH | ML-KEM variants | IETF draft-ietf-hpke-pq; HPKE extension [[1]](https://datatracker.ietf.org/doc/draft-ietf-hpke-pq/) |

**Combiner security:** Naive XOR or concatenation of secrets is insecure if one KEM is adversarially controlled. The standard combiner is a dual-PRF: `SS = KDF(SS_classical ‖ SS_pq ‖ context)`. RFC 9794 (June 2025) standardizes terminology for PQ/T hybrid schemes and the combiner properties required for IND-CCA2 security [[1]](https://www.rfc-editor.org/rfc/rfc9794).

**Threat model addressed:** "Harvest now, decrypt later" — an adversary recording TLS traffic today can retroactively decrypt it once a cryptographically relevant quantum computer (CRQC) exists. Hybrid key exchange provides forward secrecy against both classical and future quantum adversaries without requiring full trust in any single new algorithm.

**State of the art:** X25519MLKEM768 is deployed in Chrome, Firefox, and Cloudflare (2024); OpenSSH uses sntrup761x25519 by default. RFC 9794 standardizes hybrid terminology. IETF draft-ietf-tls-hybrid-design governs TLS 1.3 hybrid design. The NSA and NCSC recommend hybrid as the preferred near-term deployment strategy [[1]](https://www.ncsc.gov.uk/blog-post/new-standard-for-post-quantum-terminology). Closely related to [Post-Quantum Cryptography](#post-quantum-cryptography) and [NTRU Prime](#ntru-prime--streamlined-ntru-prime).

---

## Continuous-Variable QKD (CV-QKD)

**Goal:** Distribute secret keys using the amplitude and phase quadratures of coherent laser light, measured with standard telecom homodyne/heterodyne detectors — no single-photon detectors required. CV-QKD protocols achieve information-theoretic security from the uncertainty principle and are directly compatible with existing fiber-optic telecommunications infrastructure and photonic integrated circuits.

All protocols in the table above (BB84, E91, MDI-QKD) are discrete-variable (DV) schemes that encode bits in single-photon states and require single-photon detectors (SPDs), which are expensive and cryogenic. CV-QKD encodes information in the continuous quadratures (x̂, p̂) of coherent or squeezed light pulses and detects them with shot-noise-limited homodyne/heterodyne receivers — the same hardware used in classical coherent optical communications.

| Protocol | Year | Encoding | Detection | Note |
|----------|------|----------|-----------|------|
| **GG02** | 2002 | Gaussian-modulated coherent states | Homodyne | Foundational CV-QKD protocol; security proven against collective and coherent attacks [[1]](https://pubs.aip.org/aip/apr/article/11/1/011318/3279669/Continuous-variable-quantum-key-distribution) |
| **No-Switching (NS) Protocol** | 2006 | Coherent states | Heterodyne | Simultaneously measures both quadratures; higher symbol rate than GG02 [[1]](https://arxiv.org/pdf/1703.09278) |
| **Discrete-Modulated CV-QKD (DM-CV-QKD)** | 2009 | QPSK/4-state coherent | Heterodyne | Finite constellation; simpler reconciliation; composable key proven 2025 [[1]](https://www.nature.com/articles/s41377-025-01924-9) |
| **CV-MDI-QKD** | 2013 | Gaussian states | Untrusted relay homodyne | Measurement-device-independent variant; removes detector side-channels [[1]](https://www.nature.com/articles/s41598-023-37699-5) |
| **Squeezed-State CV-QKD** | 2019 | Squeezed vacuum states | Homodyne | Higher key rates and noise resilience than coherent-state variants; demonstrated 2025 [[1]](https://arxiv.org/abs/2506.19438) |
| **Free-Space CV-QKD** | 2025 | Coherent states, 1550 nm | Heterodyne | First daytime free-space demonstration over 860 m in rain; toward satellite CV-QKD [[1]](https://www.nature.com/articles/s41534-025-01009-w) |

**Security framework:** GG02 security was first proven in the asymptotic limit using Gaussian optimality; composable finite-size security proofs against general coherent attacks were established by 2022 (Pirandola et al., Nature Communications). A 2025 improvement [[1]](https://arxiv.org/html/2301.10270) tightens finite-size key rates substantially. The composable framework accounts for all post-processing (reconciliation, privacy amplification) and is the accepted standard for practical deployment analysis.

**Advantages over DV-QKD:** CV-QKD detectors operate at room temperature (vs. ≥80 K for SPDs), have GHz-range bandwidth, and are integrable on photonic chips. The 2025 adaptive-filter protocol (Nature Communications Physics) demonstrates 3× key-rate improvement over prior CV-QKD and up to 400× in satellite channel simulations [[1]](https://www.nature.com/articles/s42005-025-02317-5).

**State of the art:** Composable security proofs are mature (2022–2025); DM-CV-QKD has demonstrated composable key generation over 20 km fiber (2025). Commercial CV-QKD systems are available (e.g., Toshiba, ID Quantique); photonic-integrated-circuit implementations are emerging. Extends [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd); complements [Twin-Field QKD](#twin-field-qkd-tf-qkd) for distance scaling [[1]](https://arxiv.org/abs/2512.01758).

---

## Quantum Repeaters and Quantum Networks

**Goal:** Extend quantum key distribution and entanglement distribution to continental and global scales. Direct QKD over optical fiber is limited to ~500–600 km by photon loss, and amplifiers cannot clone quantum states (no-cloning theorem). Quantum repeaters overcome this by dividing long links into elementary segments, generating entanglement locally, and extending it via entanglement swapping — without ever measuring the secret quantum state.

**Why classical repeaters do not work:** A classical optical amplifier copies signal power; copying a quantum state is forbidden. Quantum repeaters instead generate entanglement between neighboring nodes, then teleport entanglement across nodes using Bell measurements and classical communication, consuming local entanglement without revealing the key.

| Protocol / Generation | Year | Memory | Error Correction | Note |
|----------------------|------|--------|-----------------|------|
| **DLCZ (1st-gen)** | 2001 | Atomic ensembles | None (probabilistic) | Duan-Lukin-Cirac-Zoller; entanglement via Stokes photon interference; no QEC [[1]](https://arxiv.org/pdf/0906.2699) |
| **2nd-gen repeaters** | ~2010 | Single atoms / NV centers | Encoded logical qubits | Add quantum error detection; reduce memory time requirements; fault-tolerant swapping [[1]](https://arxiv.org/pdf/0906.2699) |
| **3rd-gen repeaters** | ~2015 | Fast quantum memories | Full QEC, fault-tolerant | Rate scales polynomially with distance; Bell-state measurement + QEC at every node [[1]](https://arxiv.org/pdf/0906.2699) |
| **Multiplexed repeaters** | 2024 | Multimode atomic memory | Temporal + wavelength MUX | 12 km heralded atom-photon entanglement with 50× rate improvement via multiplexing [[1]](https://www.nature.com/articles/s41467-024-54691-3) |
| **18-user quantum network** | 2025 | Entanglement swapping | Multi-user MUX | Two independent networks fused via active temporal/wavelength MUX; fidelities >84% [[1]](https://phys.org/news/2025-11-independent-quantum-networks-successfully-fused.html) |
| **NV-center teleportation** | 2025 | Nitrogen-vacancy (diamond) | Absorption-emission | Quantum teleportation over 10 km fiber via NV emission; robust to phase/intensity errors [[1]](https://www.nature.com/articles/s41534-025-01169-9) |

**Entanglement swapping:** At each repeater node, two entangled pairs (one from each neighboring segment) undergo a Bell-state measurement. The measurement result is sent classically to the endpoints, which apply a Pauli correction. The endpoints are now entangled, despite having no direct quantum channel — this is entanglement swapping (quantum teleportation without a pre-existing channel).

**Quantum internet vision:** The full quantum internet stack (analogous to TCP/IP) is under active design by IETF and ITU-T (SG-13). The ITU-T standardized quantum network reference architecture in 2025 [[1]](https://www.ietf.org/lib/dt/documents/LIAISON/liaison-2025-09-03-itu-t-sg-13-ops-work-progress-on-quantum-key-distribution-qkd-network-in-itu-t-sg13-as-of-july-2025-attachment-18.pdf). Near-term "quantum-classical hybrid" networks relay QKD keys through trusted relay nodes; full repeater-based networks require third-generation hardware not yet available at scale.

**State of the art:** Lab-scale quantum network fusion demonstrated (2025, 18 users); 10 km NV-center teleportation (2025); multiplexed atom-photon entanglement over 12 km (2024). No field-deployed quantum repeater exists yet — the dominant bottleneck is quantum memory coherence time vs. entanglement generation rate. Extends [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd) and [Twin-Field QKD](#twin-field-qkd-tf-qkd) to the network scale.

---

## Multivariate PQ Signatures (UOV / MAYO)

**Goal:** Post-quantum digital signatures from the hardness of solving multivariate quadratic (MQ) systems. The MQ problem — find x such that a system of m quadratic equations over a finite field F_q evaluates to zero — is NP-hard in general and conjectured to resist quantum attacks. Multivariate schemes offer fast signing, very short signatures, and simple constant-time implementations, making them attractive for constrained devices and high-throughput applications.

**Background:** The Oil and Vinegar (OV) scheme (Patarin 1997) introduced a trapdoor structure: variables are partitioned into "oil" (o) and "vinegar" (v) sets. Signing is easy knowing the partition; verification is evaluating the public map. Balanced OV was broken immediately; Unbalanced OV (UOV, Kipnis-Patarin-Goubin 1999) survived by making the vinegar set larger. Rainbow (Ding-Schmidt 2005) layered UOV stages for smaller keys — but was broken by Beullens' 2022 rectangular MinRank attack. MAYO (2022) revives UOV with a "whipping" technique that dramatically shrinks public keys.

| Scheme | Year | Problem | Sig size | PK size | Note |
|--------|------|---------|----------|---------|------|
| **UOV** | 1999 | Multivariate quadratic (OV) | ~96 B | ~66 KB | Classical scheme; NIST Additional Sigs Round 2 (2025) [[1]](https://csrc.nist.gov/projects/pqc-dig-sig/round-2-additional-signatures) |
| **Rainbow** | 2005 | Layered OV (MQ) | ~66 B | ~58 KB | *Broken* (2022, Beullens rectangular MinRank); withdrawn from NIST [[1]](https://eprint.iacr.org/2022/214) |
| **MAYO** | 2022 | Whipped OV (MQ) | ~321 B | ~1.3 KB | "Whipping" maps OV to a larger space; NIST Additional Sigs Round 2 [[1]](https://csrc.nist.gov/csrc/media/Projects/pqc-dig-sig/documents/round-2/spec-files/mayo-spec-round2-web.pdf) |
| **SNOVA** | 2022 | Structured OV (module) | ~187 B | ~1.1 KB | Module structure over small field; NIST Additional Sigs Round 2 [[1]](https://csrc.nist.gov/projects/pqc-dig-sig/round-2-additional-signatures) |
| **QR-UOV** | 2022 | Quotient ring OV | ~109 B | ~10 KB | UOV over quotient ring for smaller public keys [[1]](https://csrc.nist.gov/projects/pqc-dig-sig/round-2-additional-signatures) |

**MAYO vs. UOV trade-offs:** Standard UOV has public keys ~66 KB at NIST Level 1 — impractical for many applications. MAYO's "whipping" lifts the map to a higher-dimensional ambient space, then slices back down; the public key collapses to ~1.3 KB while signature sizes remain small (~320 B). A 2025 exterior-algebra analysis found that MAYO₂ and UOV-Ip lose 4–11 bits of security under a new attack; the Round 2 parameter sets account for this [[1]](https://eprint.iacr.org/2025/1143).

**Why multivariate matters:** ML-DSA and Falcon are both lattice-based — a structural breakthrough in lattice cryptanalysis would break both simultaneously. MAYO and UOV rest on the MQ hardness assumption, which is algebraically unrelated to lattices or hash functions, providing genuine cryptographic diversity. Signing and verification are extremely fast (µs range) with no floating-point arithmetic.

**State of the art:** MAYO and UOV are NIST Additional Signatures Round 2 (2025); Rainbow broken and withdrawn. No multivariate scheme is yet standardized. Complements [Post-Quantum Cryptography](#post-quantum-cryptography) (lattice-based FIPS 204/206) and [Equivalence-Based PQ Signatures](#equivalence-based-pq-signatures) as a third independent assumption class for PQ signatures [[1]](https://blog.cloudflare.com/another-look-at-pq-signatures/).

---

## FAEST / VOLE-in-the-Head (Symmetric-Key PQ Signatures)

**Goal:** Post-quantum digital signatures whose unforgeability rests solely on the security of a standard block cipher (AES) — no lattice, code, or isogeny assumption required. FAEST (2023) uses a new paradigm called VOLE-in-the-Head (VOLEitH) to construct a zero-knowledge proof that "I know the AES key K such that AES_K(nonce) = ciphertext," then converts it into a signature via the Fiat-Shamir transform. If AES is secure, FAEST is unforgeable.

The Picnic signature scheme (2017, predecessor) used MPC-in-the-Head to prove knowledge of a block cipher preimage. FAEST replaces the MPC subprotocol with a more efficient Vector Oblivious Linear Evaluation (VOLE) argument — reducing signature sizes by ~30% and improving speed. Unlike MPC-in-the-Head, VOLEitH does not simulate multi-party computation; it generates a consistency proof via VOLE correlations, a structurally different primitive.

| Scheme | Year | Primitive | Sig size (L1) | Security basis | Note |
|--------|------|-----------|--------------|---------------|------|
| **Picnic** | 2017 | LowMC + MPCitH | ~12 KB | MPC security + block cipher | First MPCitH signature; NIST Round 3 alternate; withdrawn [[1]](https://eprint.iacr.org/2017/279) |
| **FAEST** | 2023 | AES + VOLEitH | ~5.6 KB | AES security only | NIST Additional Sigs Round 2; 2× smaller than Picnic [[1]](https://csrc.nist.gov/csrc/media/Projects/pqc-dig-sig/documents/round-2/spec-files/faest-spec-round2-web.pdf) |
| **FAEST-EM** | 2023 | AES-EM + VOLEitH | ~6.1 KB | AES Even-Mansour security | Even-Mansour variant; slightly larger but simpler security reduction [[1]](https://csrc.nist.gov/csrc/media/Projects/pqc-dig-sig/documents/round-2/spec-files/faest-spec-round2-web.pdf) |
| **FAEST v2** | 2024 | AES + VOLEitH (optimized) | ~4.5 KB | AES security only | NIST Round 2 submission; shorter/tighter QROM analysis [[1]](https://csrc.nist.gov/csrc/media/Projects/pqc-dig-sig/documents/round-2/spec-files/faest-spec-round2-web.pdf) |

**Security argument:** FAEST reduces signature unforgeability to two assumptions: (1) the AES circuit is collision-resistant (standard assumption), and (2) the VOLE correlation is computationally hiding (from LPN or random-oracle model). There is no lattice assumption, no code assumption, and no isogeny assumption — making FAEST the most assumption-conservative PQ signature available if one is willing to pay the ~4–6 KB signature overhead.

**Comparison with hash-based schemes:** SLH-DSA (FIPS 205) also avoids algebraic assumptions, but relies only on hash-function properties. SLH-DSA signatures are ~8–50 KB depending on variant. FAEST at ~4.5 KB (Level 1) is smaller than SLH-DSA-fast but larger than ML-DSA (~2.4 KB) or Falcon (~0.7 KB). FAEST signing is slower than ML-DSA but faster than SPHINCS+.

**State of the art:** FAEST v2 is a NIST Additional Signatures Round 2 candidate (2024–2025). No standardization decision yet; final selection expected ~2026–2027. The NIST PQC seminar (June 2024) highlighted VOLEitH as a technically distinct and promising paradigm [[1]](https://csrc.nist.gov/csrc/media/Projects/post-quantum-cryptography/documents/pqc-seminars/presentations/15-vole-in-the-head-06182024.pdf). Complements [Post-Quantum Cryptography](#post-quantum-cryptography) with a purely symmetric-key security foundation alongside [Equivalence-Based PQ Signatures](#equivalence-based-pq-signatures) and [Multivariate PQ Signatures](#multivariate-pq-signatures-uov--mayo).

---

## Shor's Algorithm and Quantum Threats to Public-Key Cryptography

**Goal:** Understand which classical public-key schemes are broken by quantum computers, and why. Shor's algorithm (1994) runs in polynomial time on a quantum computer and solves two problems that underlie essentially all deployed asymmetric cryptography: integer factorization (breaking RSA) and the discrete logarithm problem (breaking DH, DSA, and ECDH/ECDSA). A cryptographically relevant quantum computer (CRQC) running Shor's algorithm would retroactively compromise any ciphertext or signature produced with these schemes.

| Problem Broken | Classical Scheme(s) | Quantum Attack | Cost (qubits) | Note |
|----------------|--------------------|--------------|--------------|----|
| **Integer factorization** | RSA (all key sizes) | Shor's factoring | ~2n logical qubits for n-bit modulus | RSA-2048 needs ~4,000 logical / ~20M physical qubits [[1]](https://arxiv.org/abs/2203.08823) |
| **Discrete log mod p** | DH, DSA, ElGamal | Shor's DLP | ~2n qubits | Same circuit structure as factoring [[1]](https://arxiv.org/abs/quant-ph/9508027) |
| **Elliptic curve DLP** | ECDH, ECDSA, Ed25519 | Shor's ECDLP variant | ~3n qubits for n-bit curve | Roetteler et al. 2017; P-256 needs ~2,330 logical qubits [[1]](https://eprint.iacr.org/2017/598) |
| **Pairing-based DLP** | BLS, IBE, pairings | Shor's DLP in extension fields | Similar to DLP mod p | Targets the GT group in the pairing target field [[1]](https://eprint.iacr.org/2017/598) |

**Why ECDLP differs from factoring for Shor's:** RSA moduli are composites in Z/nZ; ECC curves are cyclic groups of prime order. The Shor ECDLP circuit requires arithmetic over the curve's field and group law in superposition, consuming roughly 3n logical qubits for an n-bit curve — but because n = 256 for P-256 vs. n = 2048 for RSA, the absolute qubit count is lower even though the per-bit coefficient is higher.

**Physical qubit overhead:** Logical qubits require quantum error correction. Realistic estimates (surface code, 10⁻³ physical error rate) place RSA-2048 at approximately 20 million physical qubits and ~8 hours of runtime. As of 2025, the largest processors have ~1,000–2,000 physical qubits; a CRQC capable of running Shor's at useful scale is estimated 10–20 years away. NIST standardized ML-KEM, ML-DSA, and SLH-DSA in 2024 precisely because they are immune to Shor's algorithm.

**What Shor's does NOT break:** Symmetric ciphers (AES, ChaCha20), hash functions (SHA-3), and lattice/code/multivariate/hash-based PQC schemes. Those are addressed by [Grover's algorithm](#grovers-algorithm-and-symmetric-key-security).

**State of the art:** No CRQC exists as of 2025. NIST FIPS 203/204/205 are the recommended replacements for RSA/ECDH/ECDSA. "Harvest-now, decrypt-later" attacks make [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange) urgent for long-lived secrets. See also [Post-Quantum Cryptography](#post-quantum-cryptography).

---

## Grover's Algorithm and Symmetric-Key Security

**Goal:** Quantify how quantum computing affects symmetric cryptography and hash functions. Grover's algorithm (1996) provides a quadratic speedup for unstructured search on a quantum computer — searching N items in O(√N) quantum queries vs. O(N) classical queries. This effectively halves the security of symmetric keys and hash outputs against exhaustive search, but does not break them: a 256-bit key remains computationally infeasible under Grover's attack.

| Primitive | Classical Security | Quantum Security (Grover) | Recommended Mitigation |
|-----------|------------------|--------------------------|----------------------|
| **AES-128** | 128-bit | ~64-bit (insecure for PQ) | Upgrade to AES-256 [[1]](https://csrc.nist.gov/pubs/sp/800/131/a/r2/final) |
| **AES-256** | 256-bit | ~128-bit (NIST Level 1) | No change needed [[1]](https://csrc.nist.gov/pubs/fips/197/final) |
| **ChaCha20-256** | 256-bit | ~128-bit | No change needed |
| **SHA-256 (collision)** | 128-bit | ~85-bit (BHT algorithm) | Use SHA-3-384+ for collision resistance [[1]](https://eprint.iacr.org/2004/264) |
| **SHA-3-256 (preimage)** | 256-bit | ~128-bit | Acceptable for preimage; SHA-3-384+ for collision [[1]](https://csrc.nist.gov/pubs/fips/202/final) |
| **SHA-3-512** | 512-bit | ~256-bit (preimage) / ~170-bit (collision) | Highest PQ security margin |

**Grover's algorithm mechanics:** Grover uses amplitude amplification on a quantum oracle that marks valid solutions. For a keyspace of size 2ⁿ, it requires O(2^{n/2}) oracle calls and O(n) qubits. Each oracle call involves evaluating the full cipher (e.g., AES) in superposition, which incurs a substantial constant-factor overhead in gate count. A 2020 NIST analysis estimated that quantum search on AES-128 costs ~2^86 gates after accounting for this overhead — still far fewer than classical 2^128, making AES-128 inadequate for long-term PQ security.

**Collision search (BHT algorithm):** The Brassard-Høyer-Tapp algorithm finds hash collisions in O(2^{n/3}) quantum queries using quantum random walks — stronger than Grover's O(2^{n/2}) preimage search. SHA-256 drops from 128-bit classical collision resistance to ~85-bit quantum. This is why NIST recommends SHA-384 (192-bit collision resistance classically, ~128-bit quantum) for PQ-critical applications requiring strong collision security.

**Impact on PQ schemes:** All NIST PQC standards are designed with Grover's in mind. ML-KEM-768 targets NIST Level 3 (~192-bit security), defined so that a Grover-based attack costs more than exhaustive AES-192 key search. SLH-DSA hash-chain parameters are sized to ensure that even Grover's application to the hash chains does not drop security below the required threshold.

**State of the art:** NIST SP 800-131A Rev. 2 recommends AES-256 and SHA-384/512 for quantum-safe symmetric primitives. No quantum computer today can meaningfully accelerate Grover's search against 128-bit keys. See [Post-Quantum Cryptography](#post-quantum-cryptography) and [Shor's Algorithm](#shors-algorithm-and-quantum-threats-to-public-key-cryptography) for the full quantum threat landscape.

---

## ML-KEM (Kyber) Internals — Module LWE, NTT, and Noise Parameters

**Goal:** Expose the mathematical core of the primary NIST PQC KEM standard. ML-KEM (FIPS 203, standardized from CRYSTALS-Kyber) is built on the Module Learning With Errors (MLWE) problem: distinguishing noisy linear equations over polynomial rings from random. This problem is believed to be hard against both classical and quantum adversaries, including Shor's algorithm.

**Ring and module structure:** ML-KEM operates in the ring R_q = Z_q[x]/(x^256+1) where q = 3329. A module of rank k (k = 2, 3, or 4 for ML-KEM-512/768/1024) yields vectors of polynomials in R_q^k. The MLWE assumption: given a random matrix A ∈ R_q^{k×k}, secret s ∈ R_q^k with small coefficients, and error e ∈ R_q^k with small coefficients, distinguish (A, As + e) from (A, uniform).

| Parameter Set | k | q | η₁ | η₂ | Security Level | PK size | CT size |
|--------------|---|---|----|----|---------------|---------|---------|
| **ML-KEM-512** | 2 | 3329 | 3 | 2 | NIST Level 1 (~128-bit) | 800 B | 768 B |
| **ML-KEM-768** | 3 | 3329 | 2 | 2 | NIST Level 3 (~192-bit) | 1184 B | 1088 B |
| **ML-KEM-1024** | 4 | 3329 | 2 | 2 | NIST Level 5 (~256-bit) | 1568 B | 1568 B |

Noise parameters η₁ and η₂ define the centered binomial distribution for secret and error polynomials: each coefficient is the difference of two sums of η independent Bernoulli(1/2) variables, giving values in {−η, ..., +η}.

**Number Theoretic Transform (NTT):** Polynomial multiplication in R_q dominates the computational cost. Because q = 3329 ≡ 1 (mod 512), a 256-point NTT exists over Z_q, converting polynomials to evaluation form in 7 butterfly layers (128 butterflies per layer). In NTT domain, multiplication reduces from O(n²) to O(n) pointwise multiplications. All of matrix-vector multiplication in key generation, encapsulation, and decapsulation executes in NTT domain.

**Key generation, encapsulation, decapsulation:** Key generation samples A ∈ R_q^{k×k} from a seed (expand with SHAKE-128), draws s, e from the binomial distribution, and outputs public key (A, t = As + e). Encapsulation draws r, e₁, e₂ from the same distribution and outputs ciphertext (u = A^T·r + e₁, v = t^T·r + e₂ + encode(m)). Decapsulation recovers m ≈ v − s^T·u and applies the Fujisaki-Okamoto (FO) transform: re-derive randomness from m, re-encrypt, and compare to detect tampering — achieving IND-CCA2 security.

**State of the art:** ML-KEM is the primary NIST PQC KEM (FIPS 203, August 2024). Deployed as X25519MLKEM768 in Chrome, Firefox, Cloudflare, and Signal. Hardware NTT accelerators have been integrated into RISC-V and ARM Cortex-M cores. See [Post-Quantum Cryptography](#post-quantum-cryptography), [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange), and [Lattice Sieving and BKZ Complexity](#lattice-sieving-and-bkz-complexity) for the security analysis underpinning parameter selection.

---

## Lattice Sieving and BKZ Complexity

**Goal:** Establish the concrete security foundations for lattice-based PQC standards. The security of ML-KEM, ML-DSA, FrodoKEM, and related schemes is bounded by the cost of solving the Shortest Vector Problem (SVP) in high-dimensional lattices. The dominant attack framework is the Block Korkine-Zolotarev (BKZ) algorithm, which iteratively solves SVP in β-dimensional projected sublattices using sieving algorithms as a subroutine. Understanding BKZ complexity is essential for reading NIST PQC parameter rationales.

| Algorithm | Year | Time Complexity | Space | Note |
|-----------|------|----------------|-------|------|
| **LLL** | 1982 | Polynomial | Polynomial | 2^{O(n)} approximation; too weak for PQC attacks [[1]](https://doi.org/10.1007/BF01457454) |
| **BKZ 1.0** | 1987 | 2^{O(β log β)} per call | Polynomial | Blockwise reduction; quality controlled by block size β [[1]](https://eprint.iacr.org/2019/1398) |
| **BKZ 2.0** | 2011 | Substantially faster in practice | Polynomial | Extreme pruning + preprocessing; dominant practical tool [[1]](https://eprint.iacr.org/2011/537) |
| **GaussSieve** | 2010 | 2^{0.415n + o(n)} | 2^{0.208n} | First practical lattice sieve; used inside BKZ-β to solve SVP in dim β [[1]](https://arxiv.org/abs/1001.3489) |
| **BDGL Sieve** | 2016 | 2^{0.292n + o(n)} | 2^{0.208n} | Locality-sensitive hashing; best known classical SVP algorithm [[1]](https://eprint.iacr.org/2015/1113) |
| **Quantum QWALK Sieve** | 2015 | 2^{0.265n + o(n)} | 2^{0.208n} | Quantum walk on near-neighbor graph; best known quantum SVP algorithm [[1]](https://arxiv.org/abs/1312.4027) |

**BKZ and security estimates:** BKZ-β outputs a reduced basis whose shortest vector approximation improves with β. The root-Hermite factor δ_β governs output quality; for ML-KEM-768 (module rank 3, polynomial degree 256, dimension n ≈ 768), recovering the secret key requires BKZ with β ≈ 400–450. Each BKZ-β step calls a sieve in dimension β, costing ~2^{0.292β} ≈ 2^{130} classical operations under the BDGL estimate — establishing the claimed security level.

**Primal and dual attacks:** The two main attack strategies are the primal attack (find the secret vector directly via BKZ) and the dual attack (find a short dual vector and use it to distinguish). Recent work (Ducas-Pulles 2023) showed that dual attacks have limited advantage over primal attacks for ML-KEM parameters, but the analysis refined NIST security estimates by ~5–10 bits in some cases [[1]](https://eprint.iacr.org/2023/1454).

**Lattice Estimator:** The Albrecht et al. Lattice Estimator is the community-standard tool for computing concrete security levels, combining BKZ simulation with the best attack models. All NIST PQC lattice submissions used it for security arguments [[1]](https://github.com/malb/lattice-estimator).

**Quantum speedup for sieving:** QWALK reduces the sieving exponent from 0.292n to 0.265n — a modest speedup of ~2^{0.027n}. For n = 450 (BKZ block size for ML-KEM-768), this is a factor of ~2^{12}, reducing effective security from ~130 to ~118 bits — still well above the NIST Level 3 threshold of ~128 bits quantum security. Unlike Grover's quadratic speedup for symmetric keys, the quantum speedup for lattice sieving is sub-quadratic.

**State of the art:** BDGL sieve (classical) and QWALK sieve (quantum) set the benchmarks. The Lattice Estimator is the standard parameter selection tool. Space requirements for sieving (~2^{0.2n}) are often a practical bottleneck. See [Post-Quantum Cryptography](#post-quantum-cryptography) and [ML-KEM Internals](#ml-kem-kyber-internals--module-lwe-ntt-and-noise-parameters).

---

## Quantum Secret Sharing

**Goal:** Distribute an unknown quantum state (a qubit) among n parties such that any authorized subset can reconstruct it, but unauthorized subsets learn nothing — even quantumly. Classical secret sharing (Shamir, 1979) distributes classical bits; quantum secret sharing (QSS) extends this to quantum states. Security is guaranteed by the laws of quantum mechanics (no-cloning theorem, entanglement monogamy) rather than computational hardness, and applies even against computationally unbounded adversaries.

| Scheme | Year | Basis | Threshold | Note |
|--------|------|-------|-----------|------|
| **Hillery-Bužek-Berthiaume (HBB)** | 1999 | GHZ entanglement | (n, n) | First QSS scheme; uses n-party GHZ states; any strict subset is maximally mixed [[1]](https://arxiv.org/abs/quant-ph/9806063) |
| **Cleve-Gottesman-Lo (CGL)** | 1999 | Quantum error-correcting codes | (k, n) | (k, n)-threshold QSS from quantum codes that correct n-k erasures; fully general [[1]](https://arxiv.org/abs/quant-ph/9901025) |
| **Karlsson-Koashi-Imoto** | 1999 | Bell pairs + classical shares | (2, 3) | Players hold classical shares plus shared entanglement; reconstruction via LOCC [[1]](https://link.aps.org/doi/10.1103/PhysRevA.59.162) |
| **Graph-State QSS** | 2006 | Graph states / stabilizer codes | Arbitrary access structure | Access structure determined by graph connectivity; efficient multiparty implementation [[1]](https://arxiv.org/abs/quant-ph/0602226) |
| **Continuous-Variable QSS** | 2001 | Squeezed / coherent optical modes | (k, n) | QSS using optical quadratures; compatible with CV-QKD infrastructure [[1]](https://arxiv.org/abs/quant-ph/0009026) |
| **Verifiable QSS** | 2019 | Quantum authentication codes | (k, n) | Handles dishonest dealer; quantum analog of classical VSS [[1]](https://arxiv.org/abs/1907.06564) |

**HBB protocol:** The dealer prepares an n-party GHZ state |ψ⟩ = (|0⟩^⊗n + |1⟩^⊗n)/√2, encodes the secret qubit into the joint state, and distributes one qubit per party. Reconstruction requires all n players to measure and broadcast classical results; the last player applies a Pauli correction to recover the secret. Any strict subset of n-1 parties holds a maximally mixed state — completely uninformative about the secret state, even with unlimited computation.

**CGL threshold construction:** Cleve-Gottesman-Lo proved that (k, n)-threshold QSS is equivalent to quantum error-correcting codes that correct n-k erasures. A [[n, 1, d]] quantum code with d = n−k+1 encodes 1 logical qubit into n physical qubits such that any k shares suffice for reconstruction while any k-1 shares are quantum-mechanically uninformative. For example, the [[5, 1, 3]] perfect code gives (3, 5)-threshold QSS.

**Relation to classical secret sharing:** Classical (k, n)-threshold schemes achieve information-theoretic security against all adversaries holding fewer than k shares. QSS provides the same guarantee for quantum secrets, with the additional property that quantum shares cannot be classically copied — the no-cloning theorem prevents any share-amplification attack that has no classical analog.

**State of the art:** Laboratory demonstrations exist with 3–5 photons or trapped ions. Graph-state and CV-QSS are the most hardware-feasible variants for current technology. Verifiable QSS (2019) handles active adversaries including a dishonest dealer, analogous to [PVSS](categories/05-secret-sharing-threshold-cryptography.md#publicly-verifiable-secret-sharing-pvss) in the classical setting. See [Secret Sharing and Threshold Cryptography](categories/05-secret-sharing-threshold-cryptography.md) for classical counterparts and [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd) for related quantum multiparty primitives.

---

---
