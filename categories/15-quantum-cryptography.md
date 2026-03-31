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

**Production readiness:** Production
Deployed in China's Micius satellite network, commercial QKD systems by ID Quantique and Toshiba, and Jinan-1 microsatellite (2025).

**Implementations:**
- [ID Quantique Clavis](https://www.idquantique.com/quantum-safe-security/products/clavis-xg/) — commercial DV-QKD system
- [Toshiba QKD](https://www.toshiba.eu/quantum/products/quantum-key-distribution/) — commercial QKD platform
- [Open QKD (AIT)](https://openqkd.eu/) — EU open QKD testbed

**Security status:** Secure
Information-theoretically secure under quantum mechanics; implementation side-channel attacks (detector blinding) must be mitigated with MDI-QKD or device-independent protocols.

**Community acceptance:** Standard
ITU-T Y.3800 series, ETSI QKD ISG standards. Widely deployed in China and Europe; NSA does not endorse QKD for NSS (prefers PQC).

---

## Quantum Money / Quantum Tokens

**Goal:** Unclonable currency. Banknotes are quantum states — the no-cloning theorem prevents counterfeiting. Impossible to achieve classically (any digital data can be copied). A foundational quantum cryptographic primitive beyond QKD.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wiesner's Quantum Money** | 1983 | Conjugate coding | First proposal; bank verifies; uses BB84-like states [[1]](https://doi.org/10.1145/1008908.1008920) |
| **Aaronson-Christiano Public Quantum Money** | 2012 | Hidden subspaces | Public verification; anyone can verify without the bank [[1]](https://doi.org/10.1145/2213977.2213983) |
| **Zhandry Quantum Lightning** | 2019 | Cryptographic assumptions | Strongest form: even the minter cannot create two identical bolts [[1]](https://eprint.iacr.org/2018/1105) |

**State of the art:** Quantum lightning (Zhandry 2019); theoretical — requires quantum computers for creation/verification. See [QKD](#quantum-key-distribution-qkd).

**Production readiness:** Research
Purely theoretical; requires quantum computers for creation and verification. No prototype implementations exist.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, can simulate Wiesner's scheme on quantum simulators

**Security status:** Secure
Security rests on the no-cloning theorem (information-theoretic). Public quantum money security depends on computational assumptions not yet fully validated.

**Community acceptance:** Niche
Foundational theoretical primitive studied in quantum information; no standardization effort. Active academic interest but no path to near-term deployment.

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

**Production readiness:** Research
Academic/theoretical stage; proofs of concept only. No production-quality implementations.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, quantum simulation framework for prototyping

**Security status:** Secure
Security from no-cloning theorem and computational assumptions (iO, quantum FHE). Theoretical guarantees are strong; no practical attacks known on the constructions.

**Community acceptance:** Niche
Active research area at top cryptography venues (STOC, CRYPTO, EUROCRYPT). No standardization; purely academic at present.

---

## Position-Based Quantum Cryptography

**Goal:** Location as sole credential. Cryptographic protocols where your geographic position is the only authentication factor — you can decrypt or participate only if you are physically at a specific location. Classically impossible against colluding adversaries; quantumly achievable via no-cloning.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Buhrman-Chandran-Fehr-Gelles-Goyal-Ostrovsky-Schaffner** | 2011 | Quantum + relativistic | First position-based QKD; secure against bounded quantum storage [[1]](https://doi.org/10.1007/978-3-642-22792-9_27) |
| **Position Verification with Single-Qubit** | 2014 | BB84-like | Simplified protocol using single-qubit messages [[1]](https://doi.org/10.1007/978-3-662-44381-1_8) |
| **Uncloneable Position Verification** | 2023 | No-cloning + relativity | Composable security from no-cloning + speed of light [[1]](https://eprint.iacr.org/2023/1643) |

**State of the art:** Theoretical; requires relativistic constraints (speed of light). Extends [QKD](#quantum-key-distribution-qkd) to spatial authentication.

**Production readiness:** Research
Purely theoretical; requires relativistic constraints and quantum communication. No experimental demonstrations.

**Implementations:**
- [SimulaQron](https://github.com/SoftwareQuTech/SimulaQron) ⭐ 130 — Python, quantum network simulator for position-based protocols

**Security status:** Caution
Secure against bounded quantum storage adversaries; general security requires relativistic constraints (speed of light). Unbounded entanglement attacks can break some variants.

**Community acceptance:** Niche
Specialized research topic within quantum cryptography. No standardization effort; limited to academic exploration.

---

## Certified Quantum Randomness / Proof of Quantumness

**Goal:** Generate provably random bits using a quantum device — even if you don't trust the device. A classical client sends challenge circuits to an untrusted quantum processor; the client verifies outputs classically, certifying genuine entropy. No Bell test or device trust required.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brakerski-Christiano-Mahadev-Vazirani** | 2018 | LWE + quantum | First proof of quantumness protocol; classical verifier certifies quantum computation [[1]](https://arxiv.org/abs/1804.00640) |
| **Aaronson-Hung Certified Randomness** | 2023 | Random circuit sampling | Certify randomness from quantum processor via random circuit challenges [[1]](https://arxiv.org/abs/2303.01625) |
| **Quantinuum Certified Randomness (Nature)** | 2025 | 56-qubit trapped-ion | First experimental demonstration: 71,313 certified random bits from untrusted quantum processor [[1]](https://www.nature.com/articles/s41586-025-08737-1) |

**State of the art:** Quantinuum H2-1 demonstration (Nature 2025); a new primitive class at intersection of [QKD](#quantum-key-distribution-qkd), [Randomness Beacons](#randomness-beacons--coin-tossing), and computational complexity.

**Production readiness:** Experimental
First experimental demonstration on Quantinuum H2-1 (Nature 2025, 71,313 certified bits). Not yet a commercial product.

**Implementations:**
- [Quantinuum Quantum Origin](https://www.quantinuum.com/products/quantum-origin) — commercial quantum random number generation platform
- [Cirq (Google)](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, open-source framework used for random circuit sampling experiments

**Security status:** Secure
Cryptographic certification under standard computational assumptions (LWE). The Quantinuum demonstration provides a formal proof of genuine quantum randomness.

**Community acceptance:** Emerging
Nature 2025 publication; first classically verifiable quantum advantage. Growing interest from NIST randomness beacon community and commercial quantum computing vendors.

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

**Production readiness:** Production
ML-KEM (FIPS 203), ML-DSA (FIPS 204), SLH-DSA (FIPS 205), FN-DSA (FIPS 206) are NIST standards deployed in Chrome, Signal, Cloudflare, and OpenSSH.

**Implementations:**
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, comprehensive PQC library with ML-KEM, ML-DSA, SLH-DSA, and more
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, includes ML-KEM, ML-DSA, SLH-DSA implementations
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, production TLS library with PQC support
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, clean portable implementations of PQC schemes

**Security status:** Secure
NIST-standardized algorithms reviewed extensively during multi-year standardization process. No known practical attacks at recommended parameters. SIDH/SIKE broken (2022) but was not standardized.

**Community acceptance:** Standard
NIST FIPS 203/204/205/206 standards. Mandated by CNSA 2.0 for US national security systems. Endorsed by NCSC (UK), BSI (Germany), and ANSSI (France).

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

**Production readiness:** Experimental
SQIsign and CSIDH have reference implementations but no production deployments. SIDH/SIKE broken (2022). SQIsign2D in NIST Round 2.

**Implementations:**
- [SQIsign reference](https://github.com/SQIsign/sqisign) ⭐ 27 — C, reference implementation of SQIsign
- [CSIDH reference (Castryck-Lange-Martindale-Panny-Renes)](https://csidh.isogeny.org/) — C, CSIDH key exchange
- [Sagemath isogeny tools](https://www.sagemath.org/) — Python, extensive isogeny computation support

**Security status:** Caution
SIDH/SIKE completely broken (Castryck-Decru 2022). CSIDH and SQIsign remain secure under different assumptions. Active cryptanalysis ongoing; parameters may need adjustment.

**Community acceptance:** Emerging
SQIsign2D is a NIST Additional Signatures Round 2 candidate. Active research community. Not yet standardized; viewed as a promising but less mature alternative to lattice-based PQC.

---

## Lattice Isomorphism Problem (LIP) / HAWK

**Goal:** PQ crypto from a new hard problem. The Lattice Isomorphism Problem: given two lattices, determine if they are isomorphic (related by an orthogonal transformation). A fundamentally different hardness assumption from LWE/SIS — no floating-point arithmetic, no rejection sampling.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HAWK** | 2022 | Module LIP | PQ signature from LIP; 4x faster signing than Falcon; no floating-point; NIST Additional Sigs Round 2 [[1]](https://eprint.iacr.org/2022/1155) |
| **LIP Public-Key Encryption** | 2024 | LIP | First PKE from LIP; distinct from LWE-based PKE [[1]](https://eprint.iacr.org/2023/1093) |
| **Ducas-Postlethwaite-Pulles-van Woerden** | 2022 | LIP analysis | Security analysis; LIP is NP-hard in general; ASIACRYPT 2022 [[1]](https://eprint.iacr.org/2022/1155) |

**State of the art:** HAWK (NIST Round 2); LIP as a new assumption class alongside LWE/SIS in [Post-Quantum Cryptography](#post-quantum-cryptography).

**Production readiness:** Experimental
HAWK has a reference implementation and is in NIST Additional Signatures Round 2. No production deployments.

**Implementations:**
- [HAWK reference implementation](https://hawk-sign.info/) — C, NIST submission package

**Security status:** Caution
LIP is a relatively new hardness assumption; NP-hard in general but structured variants used in HAWK require further cryptanalysis. No known attacks at proposed parameters.

**Community acceptance:** Emerging
HAWK is in NIST Additional Signatures Round 2. Recognized as a novel approach distinct from LWE/SIS. Under active peer review.

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

**Production readiness:** Experimental
LESS, MEDS, and CROSS have reference implementations and are in NIST Additional Signatures Round 2. No production use.

**Implementations:**
- [LESS reference](https://less-project.github.io/) — C, NIST submission
- [MEDS reference](https://meds-pqc.org/) — C, NIST submission
- [CROSS reference](https://cross-crypto.com/) — C, NIST submission

**Security status:** Caution
New hardness assumptions (code equivalence, matrix code equivalence); under active cryptanalysis. No breaks at proposed parameters but assumptions are less studied than LWE or MQ.

**Community acceptance:** Emerging
All three are NIST Additional Signatures Round 2 candidates (2025). Recognized as a genuinely new assumption class. Under active peer review at top venues.

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

**Production readiness:** Production
sntrup761 is the default PQ key exchange algorithm in OpenSSH since version 8.5 (2021) — the largest real-world deployment of any non-ML-KEM PQ KEM.

**Implementations:**
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, includes sntrup761x25519 hybrid key exchange by default
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, includes sntrup761 KEM
- [NTRU Prime reference](https://ntruprime.cr.yp.to/software.html) — C, reference implementation by Bernstein et al.

**Security status:** Secure
No known attacks exploiting the non-cyclotomic structure. Conservative security argument compared to cyclotomic NTRU. Was a NIST Round 3 alternate but not selected for FIPS.

**Community acceptance:** Widely trusted
Deployed by default in OpenSSH (billions of connections). Backed by Bernstein, Lange, and collaborators. Not a NIST FIPS standard, but the most deployed non-ML-KEM PQ KEM.

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

**Production readiness:** Mature
Reference implementation available; well-studied for 50 years. Not yet standardized (NIST Round 4 alternate). Very large public keys limit practical deployment.

**Implementations:**
- [Classic McEliece reference](https://classic.mceliece.org/software.html) — C, reference and optimized implementations
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, includes Classic McEliece
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, Classic McEliece support
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, portable Classic McEliece implementation

**Security status:** Secure
50-year track record of Goppa code hardness. Most conservative PQC KEM available. No known attacks approach proposed security levels.

**Community acceptance:** Widely trusted
NIST Round 4 alternate; endorsed by conservative cryptographers (Bernstein, Lange). Not yet a FIPS standard due to key size. May be standardized as a specialized long-term option.

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

**Production readiness:** Experimental
Selected by NIST (March 2025) as fifth PQC algorithm. FIPS 207 draft expected ~2026. No production deployments yet.

**Implementations:**
- [HQC reference](https://pqc-hqc.org/) — C, NIST submission reference implementation
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, includes HQC
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, portable HQC implementation

**Security status:** Secure
No known attacks at proposed parameters. Based on quasi-cyclic code decoding hardness (less conservative than Classic McEliece but well-studied). NIST selected as code-based fallback for ML-KEM.

**Community acceptance:** Standard
Selected by NIST for FIPS 207 standardization (March 2025). Positioned as a code-based alternative KEM alongside ML-KEM for defense-in-depth.

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

**Production readiness:** Experimental
Laboratory demonstrations over 833 km fiber; plug-and-play architectures demonstrated (2025). No commercial products yet.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Composable finite-key security proofs against general attacks for SNS-TF-QKD and variants. Information-theoretically secure. Phase synchronization requirements introduce implementation challenges.

**Community acceptance:** Emerging
Active research with publications in Nature and Physical Review Letters. Recognized as the primary candidate for pre-repeater long-distance QKD. No standardization yet.

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

**Production readiness:** Production
X25519MLKEM768 deployed in Chrome, Firefox, Cloudflare, and Signal (2024). sntrup761x25519 default in OpenSSH. RFC 9794 standardizes terminology.

**Implementations:**
- [BoringSSL (Google)](https://boringssl.googlesource.com/boringssl/) — C, X25519MLKEM768 in Chrome/Android
- [s2n-tls (AWS)](https://github.com/aws/s2n-tls) ⭐ 4.7k — C, hybrid PQ key exchange support
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, sntrup761x25519 hybrid by default
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, hybrid PQ TLS support
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, hybrid KEM constructions

**Security status:** Secure
Security holds if either the classical or PQ component remains unbroken. Dual-PRF combiner provides IND-CCA2 security. RFC 9794 formalizes combiner requirements.

**Community acceptance:** Standard
RFC 9794 (2025), IETF draft-ietf-tls-ecdhe-mlkem. Recommended by NSA (CNSA 2.0) and NCSC as the preferred near-term deployment strategy.

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

**Production readiness:** Mature
Commercial CV-QKD systems available from Toshiba and ID Quantique. Composable security proofs mature (2022-2025). Photonic integrated circuit implementations emerging.

**Implementations:**
- [ID Quantique Cerberis](https://www.idquantique.com/) — commercial CV-QKD system

**Security status:** Secure
Composable security proven against general coherent attacks (2022). Information-theoretically secure. Implementation requires careful calibration of shot noise and excess noise.

**Community acceptance:** Emerging
ETSI QKD ISG includes CV-QKD specifications. Growing commercial deployment. Academic community considers it complementary to DV-QKD for telecom-integrated systems.

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

**Production readiness:** Research
Lab-scale demonstrations (18-user network fusion, 10 km NV-center teleportation). No field-deployed quantum repeater exists. Third-generation hardware not available at scale.

**Implementations:**
- [SimulaQron (QuTech)](https://github.com/SoftwareQuTech/SimulaQron) ⭐ 130 — Python, quantum network simulator
- [NetSquid (QuTech)](https://netsquid.org/) — Python, discrete-event quantum network simulator
- [SeQUeNCe](https://github.com/sequence-toolbox/SeQUeNCe) ⭐ 151 — Python, quantum network simulator for repeater architectures

**Security status:** Secure
Entanglement-based security is information-theoretic. Current bottleneck is engineering (quantum memory coherence time), not security assumptions.

**Community acceptance:** Emerging
IETF QIRG and ITU-T SG-13 developing quantum network standards (2025). Active research worldwide. Recognized as essential for global-scale quantum-secure communication.

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

**Production readiness:** Experimental
MAYO and UOV are NIST Additional Signatures Round 2 candidates (2025). Reference implementations available; no production deployments. Rainbow broken and withdrawn.

**Implementations:**
- [MAYO reference](https://pqmayo.org/) — C, NIST submission reference implementation
- [UOV reference](https://www.uovsig.org/) — C, NIST submission reference implementation
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, portable implementations of multivariate schemes

**Security status:** Caution
UOV has survived 25+ years of cryptanalysis. MAYO is newer (2022); a 2025 exterior-algebra attack reduced MAYO2 security by 4-11 bits (Round 2 parameters account for this). Rainbow is broken.

**Community acceptance:** Emerging
MAYO and UOV in NIST Additional Signatures Round 2. Valued as a third independent assumption class (MQ) alongside lattices and codes. Active peer review ongoing.

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

**Production readiness:** Experimental
FAEST v2 is a NIST Additional Signatures Round 2 candidate (2024-2025). Reference implementation available; no production use.

**Implementations:**
- [FAEST reference](https://faest.info/) — C, NIST submission reference implementation
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, includes FAEST

**Security status:** Secure
Security reduces to AES security only (no lattice, code, or isogeny assumption). The most assumption-conservative PQ signature if AES is secure.

**Community acceptance:** Emerging
NIST Additional Signatures Round 2 candidate. NIST PQC seminar (2024) highlighted VOLEitH as a technically distinct paradigm. Standardization decision expected ~2026-2027.

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

**Production readiness:** Research
No cryptographically relevant quantum computer (CRQC) exists. Shor's algorithm is well-understood theoretically but requires millions of physical qubits to attack RSA-2048.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, Shor's algorithm implementations for small instances
- [Cirq (Google)](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, quantum circuit framework with Shor's demos
- [ProjectQ](https://github.com/ProjectQ-Framework/ProjectQ) ⭐ 966 — Python, includes Shor's algorithm module

**Security status:** Secure
Shor's algorithm itself is correct and well-proven. The threat is to RSA/DH/ECC, not to PQC schemes. NIST PQC standards are immune to Shor's.

**Community acceptance:** Standard
Universally accepted in the cryptographic and quantum computing communities. Shor's algorithm is the primary motivation for the entire PQC migration effort.

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

**Production readiness:** Research
No quantum computer can meaningfully accelerate Grover's search against 128-bit keys today. Theoretical impact is well-understood and mitigated by doubling key sizes.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, Grover's algorithm implementations and tutorials
- [Cirq (Google)](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, Grover search circuit implementations

**Security status:** Secure
Grover's provides quadratic speedup only; AES-256 retains 128-bit quantum security. SHA-384/512 provide adequate collision resistance under BHT algorithm.

**Community acceptance:** Standard
Universally accepted. NIST SP 800-131A Rev. 2 incorporates Grover's impact into symmetric key recommendations. AES-256 and SHA-384+ are the consensus mitigation.

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

**Production readiness:** Production
ML-KEM is FIPS 203 (August 2024). Deployed as X25519MLKEM768 in Chrome, Firefox, Cloudflare, and Signal. Hardware NTT accelerators integrated into RISC-V and ARM cores.

**Implementations:**
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, reference and optimized ML-KEM
- [CRYSTALS-Kyber reference](https://github.com/pq-crystals/kyber) ⭐ 1.2k — C, official reference implementation
- [pqcrypto-kyber (Rust)](https://crates.io/crates/pqcrypto-kyber) — Rust, ML-KEM bindings
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, ML-KEM-512/768/1024 support

**Security status:** Secure
Extensively analyzed during NIST multi-year process. Security based on Module-LWE hardness. No known attacks at recommended parameters. Lattice Estimator used for parameter validation.

**Community acceptance:** Standard
NIST FIPS 203. Mandated by CNSA 2.0. Deployed by Google, Cloudflare, Signal, and Apple. The primary PQC KEM worldwide.

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

**Production readiness:** Research
Cryptanalytic research tools; not a deployable cryptographic scheme. Used for PQC parameter selection and security estimation.

**Implementations:**
- [Lattice Estimator](https://github.com/malb/lattice-estimator) ⭐ 351 — Python (SageMath), standard tool for estimating lattice problem hardness
- [fplll](https://github.com/fplll/fplll) ⭐ 399 — C++, lattice reduction library (BKZ, LLL)
- [G6K (General Sieving Kernel)](https://github.com/fplll/g6k) ⭐ 144 — Python/C++, state-of-the-art lattice sieving implementation

**Security status:** Secure
BDGL sieve and QWALK sieve define the best-known attack costs. Space requirements (~2^{0.2n}) are a practical bottleneck. Current parameters for ML-KEM/ML-DSA incorporate sieving cost estimates.

**Community acceptance:** Standard
Lattice Estimator is the accepted community standard for PQC parameter selection. Used by NIST during the PQC standardization process.

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

**Production readiness:** Research
Laboratory demonstrations with 3-5 photons or trapped ions. No production-quality implementations or commercial products.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, quantum secret sharing circuit implementations
- [Cirq (Google)](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, quantum circuit framework for QSS prototyping

**Security status:** Secure
Information-theoretic security from quantum no-cloning for quantum shares. Verifiable QSS (2019) handles active adversaries. Security proofs are rigorous.

**Community acceptance:** Niche
Active research area; publications at QIP and quantum information conferences. No standardization effort. Viewed as a quantum extension of classical secret sharing.

---

## BIKE (Bit-Flipping Key Encapsulation)

**Goal:** Code-based KEM with moderate key sizes from quasi-cyclic codes. BIKE (Bit-Flipping Key Encapsulation) is a key encapsulation mechanism whose security rests on the hardness of decoding quasi-cyclic moderate-density parity-check (QC-MDPC) codes and the indistinguishability of its public key from a random quasi-cyclic code. Unlike Classic McEliece (megabyte-scale public keys) and HQC (Hamming-metric noise), BIKE uses a parity-check matrix as the public key and a bit-flipping decoder as the decapsulation algorithm — achieving public keys of 1.5–6 KB at security levels 1–5.

| Parameter Set | Public Key | Ciphertext | Security Level | Note |
|---------------|-----------|-----------|---------------|------|
| **BIKE-L1** | 1.54 KB | 1.57 KB | NIST Level 1 (~128-bit) | Smallest; fastest [[1]](https://bikesuite.org/files/v5.0/BIKE_Spec.2023.03.31.pdf) |
| **BIKE-L3** | 3.10 KB | 3.12 KB | NIST Level 3 (~192-bit) | Mid-range [[1]](https://bikesuite.org/files/v5.0/BIKE_Spec.2023.03.31.pdf) |
| **BIKE-L5** | 5.64 KB | 5.67 KB | NIST Level 5 (~256-bit) | Largest; highest security [[1]](https://bikesuite.org/files/v5.0/BIKE_Spec.2023.03.31.pdf) |

**Design:** The public key is a quasi-cyclic parity-check matrix H = [H₀ | H₁] where H₀ and H₁ are circulant blocks with sparse (weight-w) rows. Encapsulation draws a random error vector e of weight t and computes the syndrome s = H·e^T as the ciphertext, together with a hash of the error for key derivation. Decapsulation runs the Black-Gray-Flip (BGF) bit-flipping algorithm — a variant of Gallager's iterative decoder — to recover e from s and H, then recomputes the shared key.

**Security note — decoding failure and CCA:** Early BIKE variants suffered from non-negligible decapsulation failure rates, which can leak information about the secret key in a chosen-ciphertext attack. The BIKE v5 specification (2023) adopts a conservative parameter choice targeting decoding failure rate ≤ 2^{−128} and applies the Fujisaki-Okamoto (FO) transform to achieve IND-CCA2 security in the random oracle model, treating any decapsulation failure as a rejection [[1]](https://bikesuite.org/).

**Key size vs. security trade-off:** BIKE-L1 public keys (~1.54 KB) and ciphertexts (~1.57 KB) are far smaller than Classic McEliece (~261 KB) and moderately smaller than HQC-128 (~2.2 KB / 4.4 KB). BIKE does not require a full public generator matrix — only the compact quasi-cyclic representation. However, BIKE's security assumption (QC-MDPC indistinguishability) is newer and less studied than Goppa-code assumptions underlying Classic McEliece.

**NIST status:** BIKE is a NIST Round 4 alternate KEM — it was not selected in the initial 2024 FIPS batch (alongside ML-KEM / FIPS 203) and does not currently have a FIPS standardization track, but NIST has not ruled out future standardization [[1]](https://csrc.nist.gov/Projects/post-quantum-cryptography/post-quantum-cryptography-standardization/round-4-submissions).

**State of the art:** BIKE v5 with BGF decoder and FO transform; constant-time implementations available for x86-64 and ARM. No FIPS standard; production use not yet recommended outside research contexts. Complements [Classic McEliece (Code-Based KEM)](#classic-mceliece-code-based-kem), [HQC](#hqc-hamming-quasi-cyclic--fips-207), and [Code-Based Cryptography Overview](#code-based-cryptography-overview) as the three primary code-based PQC families.

**Production readiness:** Experimental
BIKE v5 with constant-time implementations for x86-64 and ARM. NIST Round 4 alternate; no FIPS standard. Not recommended for production outside research.

**Implementations:**
- [BIKE reference](https://bikesuite.org/) — C, official NIST submission implementation
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, includes BIKE
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, portable BIKE implementation

**Security status:** Caution
Based on QC-MDPC code decoding hardness; newer assumption than Goppa codes. Decoding failure rate must be controlled carefully to prevent GJS reaction attacks. Constant-time BGF decoder mitigates this.

**Community acceptance:** Emerging
NIST Round 4 alternate. Active research community. Less conservative than Classic McEliece but more compact. No FIPS track currently.

---

## Code-Based Cryptography Overview

**Goal:** Provide a unified map of the code-based PQC family — the oldest post-quantum approach, predating lattice-based cryptography by two decades. All code-based schemes share a common hardness assumption: decoding a random linear code (the Syndrome Decoding Problem, SDP) is NP-hard in the worst case and conjectured hard on average. This hardness has resisted attack for nearly 50 years, making it the most battle-tested PQ assumption.

**Foundational problems:**

- **Syndrome Decoding Problem (SDP):** Given a random parity-check matrix H ∈ F_2^{m×n} and syndrome s ∈ F_2^m, find a low-weight vector e ∈ F_2^n such that He^T = s. NP-hard in general; conjectured hard for random instances at appropriate parameters.
- **Goppa Code Indistinguishability:** A random-looking Goppa code is hard to distinguish from a random linear code (McEliece assumption). Key to Classic McEliece's tight reduction.
- **QC-MDPC Indistinguishability:** A quasi-cyclic parity-check matrix with low-weight rows is hard to distinguish from random quasi-cyclic (BIKE assumption). Less studied than Goppa; quasi-cyclic structure may introduce algebraic structure risks.
- **Hamming Quasi-Cyclic (HQC assumption):** Adding quasi-cyclic noise vectors is hard to invert without the trapdoor (HQC hardness). Related to SDP in the Hamming metric.

| Scheme | Year | Code Family | KEM/Sign | Hard Problem | Note |
|--------|------|-------------|----------|-------------|------|
| **McEliece PKE** | 1978 | Binary Goppa codes | PKE | Goppa indistinguishability | Original; 50-year track record [[1]](https://ipnpr.jpl.nasa.gov/progress_report2/42-44/44N.PDF) |
| **Niederreiter PKE** | 1986 | Goppa codes (dual) | PKE | SDP + Goppa | Equivalent security; smaller ciphertexts [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_20) |
| **Classic McEliece KEM** | 2017 | Binary Goppa (IND-CCA2) | KEM | Goppa indistinguishability + SDP | FO-transform from Niederreiter; NIST Round 4 [[1]](https://classic.mceliece.org/) |
| **BIKE** | 2017 | QC-MDPC codes | KEM | QC-MDPC indistinguishability + SDP | Bit-flipping decoder; NIST Round 4 [[1]](https://bikesuite.org/) |
| **HQC** | 2017 | Hamming quasi-cyclic | KEM | Hamming QC + SDP | Reed-Solomon concatenated; FIPS 207 forthcoming [[1]](https://pqc-hqc.org/) |
| **LESS** | 2020 | Linear code equivalence | Signature | Code equivalence (not SDP) | Equivalence-problem-based; NIST Additional Sigs Round 2 [[1]](https://less-project.github.io/) |
| **Wave** | 2018 | Ternary quasi-cyclic codes | Signature | SDP (ternary) | Code-based signatures from SDP directly; not in NIST process [[1]](https://eprint.iacr.org/2018/996) |

**Why code-based provides diversity:** All NIST-standardized lattice schemes (ML-KEM, ML-DSA, Falcon) rest on Module LWE / NTRU lattice hardness. A structural attack on module lattice structure would break all three simultaneously. Code-based schemes — Classic McEliece, BIKE, HQC — rest on SDP and Goppa/quasi-cyclic indistinguishability, algebraically unrelated to lattice problems. This is the rationale for HQC's inclusion as FIPS 207: a code-based fallback if MLWE is structurally attacked.

**Attack landscape:** The best attacks on SDP are information-set decoding (ISD) algorithms. Prange (1962) was the first; subsequent work (Stern 1989, Dumer 1991, BJMM 2012, MO 2015) reduced the exponent. The current best classical algorithm (May-Ozerov 2015) runs in 2^{0.054n} for SDP on n-bit codes — far higher than AES-128 equivalent. Quantum speedups (via Grover applied to ISD) yield roughly a quadratic improvement in the exponent, still leaving SDP hard at NIST Level 1 parameters [[1]](https://eprint.iacr.org/2011/516).

**State of the art:** Three NIST-process code-based KEMs: Classic McEliece (most conservative, largest keys), HQC (FIPS 207 forthcoming, balanced), BIKE (smallest keys, newest assumption). See [Classic McEliece (Code-Based KEM)](#classic-mceliece-code-based-kem), [HQC (Hamming Quasi-Cyclic)](#hqc-hamming-quasi-cyclic--fips-207), [BIKE](#bike-bit-flipping-key-encapsulation), and [Equivalence-Based PQ Signatures](#equivalence-based-pq-signatures) for code-equivalence-based schemes.

**Production readiness:** Experimental
Classic McEliece is mature (50 years); HQC selected for FIPS 207; BIKE is Round 4 alternate. Production readiness varies by scheme.

**Implementations:**
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, all three NIST code-based KEMs
- [Classic McEliece reference](https://classic.mceliece.org/software.html) — C, reference implementation
- [PQClean](https://github.com/PQClean/PQClean) ⭐ 893 — C, portable implementations of code-based schemes

**Security status:** Secure
Code-based hardness (random linear code decoding) is well-studied for 50+ years. No quantum algorithm provides better than square-root speedup over classical attacks.

**Community acceptance:** Emerging
HQC selected for NIST FIPS 207 (2025). Classic McEliece and BIKE remain Round 4 alternates. Code-based crypto is recognized as a critical alternative assumption class to lattices.

---

## CSIDH and CTIDH — Isogeny Group Actions

**Goal:** Post-quantum non-interactive key exchange (NIKE) and group-action-based cryptography. CSIDH (Commutative Supersingular Isogeny Diffie-Hellman, 2018) constructs a group action of an ideal class group on a set of supersingular elliptic curves over a prime field F_p. Unlike SIDH/SIKE (broken in 2022), CSIDH does not reveal auxiliary torsion point information — the attack surface exploited by Castryck-Decru does not apply. CSIDH enables Diffie-Hellman-style key exchange with a commutative group action, supporting non-interactive key exchange (NIKE): two parties can independently compute the same shared curve without an interactive protocol round.

**Mathematical structure:** Let p be a prime such that p ≡ 3 (mod 4). The set S of supersingular elliptic curves over F_p with the same number of F_p-points forms a principal homogeneous space (torsor) under the class group Cl(Z[√−p]). Each ideal class [a] in Cl(Z[√−p]) maps a curve E to a new curve [a]⋆E via a chain of isogenies with kernels corresponding to ideal generators. Key exchange: Alice's public key is [a]⋆E₀; Bob's is [b]⋆E₀; the shared key is [a]⋆([b]⋆E₀) = [b]⋆([a]⋆E₀) by commutativity.

| Scheme | Year | Hard Problem | Key Size | Timing | Note |
|--------|------|-------------|---------|--------|------|
| **CSIDH-512** | 2018 | CSIDH action (class group DLP) | 64 B (pub + priv) | ~80 ms (non-CT) | Original; not constant-time; vulnerable to timing [[1]](https://eprint.iacr.org/2018/383) |
| **CTIDH-512** | 2021 | CSIDH action (class group DLP) | 64 B | ~20 ms (CT) | Constant-Time Isogeny DH; uses batched dummy isogenies; first practical CT-CSIDH [[1]](https://eprint.iacr.org/2021/633) |
| **CTIDH-1024** | 2021 | CSIDH action | 128 B | ~80 ms (CT) | Higher security; side-channel safe [[1]](https://eprint.iacr.org/2021/633) |
| **CTIDH-2048** | 2021 | CSIDH action | 256 B | ~330 ms (CT) | Conservative security margin [[1]](https://eprint.iacr.org/2021/633) |
| **CSURF-512** | 2020 | CSIDH on the surface | 64 B | — | Eliminates cofactor issues; cleaner key validation [[1]](https://eprint.iacr.org/2020/1404) |
| **PEGASIS** | 2024 | CSIDH group action | ~100 B | — | Group-action-based signature; NIST Additional Sigs Round 2 [[1]](https://eprint.iacr.org/2024/344) |

**Timing attacks on CSIDH:** The original CSIDH uses variable-time isogeny chains — the number of isogeny steps in each small-degree component depends on the secret exponent vector. This leaks the Hamming weight and structure of the private key via cache timing or EM side channels. CTIDH (2021) achieves constant-time evaluation by re-parameterizing the class group action using a product of fixed-length isogeny batches and inserting dummy isogenies in constant-time branches, with performance improvements from a combined push-pull representation [[1]](https://ctidh.isogeny.org/).

**Quantum security:** The class group action underlies a subexponential quantum algorithm (Kuperberg's algorithm, 2005) that solves the dihedral hidden subgroup problem in time 2^{O(√log p)} using quantum random access memory. For CSIDH-512, Kuperberg's algorithm with QRAM runs in approximately 2^{33} quantum gates — below NIST Level 1 — making CSIDH-512 insufficient for high-security applications post-quantum. CSIDH-1024 and CSIDH-2048 (and CTIDH-1024/2048) target approximately 96- and 128-bit quantum security respectively, accounting for Kuperberg's attack [[1]](https://eprint.iacr.org/2020/329).

**Comparison to SIDH:** SIDH used non-commutative isogenies between supersingular curves over F_{p²} and required revealing auxiliary torsion-point information, enabling the Castryck-Decru 2022 key recovery attack. CSIDH operates entirely over F_p with no auxiliary torsion data — the attack does not apply. However, CSIDH suffers from subexponential quantum attacks that SIDH (before its break) was thought to resist, and constant-time CSIDH implementations (CTIDH) are 10–100× slower than ML-KEM.

**State of the art:** CTIDH-512/1024 are the practical constant-time realizations (2021); PEGASIS leverages the group action for signatures (NIST 2024). CSIDH remains the leading candidate for post-quantum NIKE — non-interactive key exchange without a PKI — a primitive not directly achievable from lattices without interaction. No NIST standard currently; active research. See [Isogeny-Based Cryptography](#isogeny-based-cryptography) for SQIsign and SIDH break context.

**Production readiness:** Experimental
CTIDH-512/1024 provide constant-time implementations. Research-grade; no production deployments. PEGASIS leverages CSIDH for signatures (NIST 2024).

**Implementations:**
- [CTIDH reference](https://ctidh.isogeny.org/) — C, constant-time CSIDH implementation
- [SageMath](https://www.sagemath.org/) — Python, extensive isogeny computation support

**Security status:** Caution
CSIDH faces sub-exponential quantum attacks (Kuperberg's algorithm). Security parameter debate ongoing (CSIDH-512 vs. CSIDH-1024). Distinct from broken SIDH — CSIDH does not expose torsion points.

**Community acceptance:** Niche
Active research community. PEGASIS submitted to NIST (2024). No NIST standard; viewed as the leading PQ-NIKE candidate but with ongoing parameter security debate.

---

## QKD Information Reconciliation — CASCADE and LDPC

**Goal:** Correct errors in the raw key material after a QKD protocol run without revealing enough information to help an eavesdropper. After quantum transmission (BB84, CV-QKD, TF-QKD) and sifting, Alice and Bob hold correlated but not identical raw key strings — mismatches arise from channel noise and detector imperfections, not necessarily eavesdropping. Information reconciliation is the classical post-processing step that corrects these errors while quantifying (and bounding) how much information leaked to the environment. The final shared secret comes after subsequent privacy amplification.

**Why reconciliation matters for security:** Every parity bit exchanged during error correction leaks information about the key to an eavesdropper who monitors the classical channel. The leaked information f·H(Q) bits (where Q is the quantum bit error rate, H is the binary entropy function, and f ≥ 1 is the reconciliation efficiency factor) must be subtracted from the raw key in privacy amplification. Inefficient reconciliation (large f) reduces the secure key rate to zero at lower QBER thresholds.

| Algorithm | Year | Type | Efficiency f | QBER Tolerance | Note |
|-----------|------|------|-------------|----------------|------|
| **Winnow** | 2003 | Hamming-code-based interactive | ~1.16 | ≤11% | Low communication rounds; simple; moderate efficiency [[1]](https://arxiv.org/abs/quant-ph/0203096) |
| **CASCADE** | 1994 | Bidirectional binary parity | ~1.16 | ≤11% | Brassard-Salvail; iterative binary bisection; the historical standard [[1]](https://www.semanticscholar.org/paper/Secret-Key-Reconciliation-by-Public-Discussion-Brassard-Salvail/9e96f36ee32f9ca61e62e4e8fd76cc27e7b87e45) |
| **LDPC (Low-Density Parity-Check)** | 2003 | Belief-propagation decoding | ~1.03–1.1 | ≤11% | Near-Shannon-limit; one-pass; parallelizable; dominant in CV-QKD [[1]](https://arxiv.org/abs/0901.2140) |
| **Polar codes** | 2009 | Successive cancellation / list decoding | ~1.01–1.05 | ≤15% | Approaching Shannon limit; capacity-achieving for large blocks [[1]](https://arxiv.org/abs/0902.4803) |
| **Raptor codes (rateless LDPC)** | 2010 | LT + LDPC codes | ~1.04 | Variable QBER | Adaptive rate; useful when QBER fluctuates [[1]](https://arxiv.org/abs/1006.0500) |
| **LDPC for CV-QKD (multi-edge)** | 2015 | Multi-edge LDPC, Gaussian channel | ~1.02 | High QBER (CV) | Multi-edge type LDPC codes optimized for Gaussian channels [[1]](https://arxiv.org/abs/1601.01654) |

**CASCADE protocol:** Brassard and Salvail (1994) introduced CASCADE as the first practical reconciliation algorithm. Alice and Bob shuffle their bit strings with a random (but shared) permutation, then exchange parities of blocks of size k₁ = ⌈0.73/(2Q)⌉. Any block with a parity mismatch is bisected recursively (binary search) until the error is located. After one pass, a new shuffle is applied and the process repeats. Each located error leaks ~log₂n bits. CASCADE is highly interactive (many rounds of classical communication) and inefficient (f ≈ 1.16 near the Shannon limit), but is provably correct and easy to analyze. It remains widely used in DV-QKD systems where latency is acceptable.

**LDPC-based reconciliation:** Modern systems (especially CV-QKD and high-rate DV-QKD) replace CASCADE with LDPC codes operating in a one-pass (non-interactive) mode. Alice encodes her key bits using a rate-R LDPC code and sends the syndrome to Bob (n(1−R) bits). Bob runs belief-propagation decoding to recover Alice's codeword. At optimal rate R ≈ 1 − H(Q), the syndrome size matches the entropy deficit — but practical LDPC efficiency reaches f ≈ 1.02–1.05 of the Shannon limit. For CV-QKD over long distances with QBER ≈ 10–15%, multi-edge type LDPC codes are the only practical option given the high error rates.

**Privacy amplification:** After reconciliation, Alice and Bob compress the corrected key by a factor equal to the conditional entropy minus leaked information, using a universal hash function (e.g., Toeplitz matrices). The output is a shorter key about which an eavesdropper holds negligible information. Together, reconciliation + privacy amplification constitute the classical post-processing pipeline that converts raw quantum correlations into a secure key.

**State of the art:** LDPC codes with belief-propagation decoding at f ≈ 1.02–1.05 are the current best practice for high-rate QKD systems. Polar codes are emerging for future systems. CASCADE remains deployed in legacy DV-QKD hardware. See [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd) and [Continuous-Variable QKD (CV-QKD)](#continuous-variable-qkd-cv-qkd) for context.

**Production readiness:** Production
CASCADE deployed in commercial QKD systems. LDPC reconciliation is the current best practice for high-rate QKD systems.

**Implementations:**
- [Cascade-CPP](https://github.com/brunorijsman/cascade-cpp) ⭐ 22 — C++, open-source CASCADE implementation

**Security status:** Secure
Information reconciliation is a classical post-processing step; security depends on the underlying QKD protocol. Reconciliation efficiency directly affects secret key rate.

**Community acceptance:** Standard
CASCADE is the established baseline. LDPC at f=1.02-1.05 is the accepted best practice. Integrated into ETSI QKD specifications.

---

## Commercial QKD Systems and Quantum Network Deployments

**Goal:** Survey the practical landscape of deployed quantum key distribution hardware and network infrastructure. QKD is unique among the schemes in this repository in requiring specialized quantum hardware — photon sources, single-photon detectors, quantum channels — rather than software running on classical processors. Several companies and government programs have moved beyond the lab to field-deployed systems.

| System / Organization | Protocol | Distance | Key Rate | Deployment | Note |
|-----------------------|----------|---------|---------|-----------|------|
| **Toshiba QKD** | BB84 / CV-QKD | up to 600 km (TF-QKD) | 13.7 Mbps (short), 10 kbps (100 km) | Cambridge, Tokyo, BT fiber trials | Longest-range commercial TF-QKD; chip-scale implementations [[1]](https://www.toshiba.eu/pages/europe/tech/quantum-information/quantum-key-distribution/) |
| **ID Quantique (IDQ) Clavis XG** | BB84 | up to 100 km | ~10 kbps at 40 km | Switzerland banks, Gov. of Geneva, Korea KTMF | First commercial QKD product (2004); ETSI-compliant API; widely deployed [[1]](https://www.idquantique.com/quantum-safe-security/products/quantum-key-distribution/) |
| **MagiQ Technologies QPN** | BB84 | up to 100 km | ~1–10 kbps | US financial sector, government labs | Early commercial deployment; now primarily government research [[1]](https://www.magiqtech.com/) |
| **China Micius satellite QKD** | BB84 (satellite) | 7,600 km (ground-to-ground via satellite) | kbps over satellite link | Beijing–Vienna secure call (2017); Beijing–Shanghai backbone | Largest operational QKD network (>2,000 km Beijing-Shanghai fiber + satellite) [[1]](https://www.nature.com/articles/nature23655) |
| **Jinan-1 microsatellite** | BB84 | 12,900 km ground-to-ground relay | 1.07 M bits/pass | 23 kg microsatellite; LEO orbit; 2025 | Smallest quantum satellite; Nature 2025; proof of miniaturized space QKD [[1]](https://www.nature.com/articles/s41586-025-08739-z) |
| **SK Telecom / Samsung QKD** | BB84 | Metropolitan network | — | Seoul 5G core network integration | First QKD integration into commercial 5G core infrastructure [[1]](https://www.sktelecom.com/en/press/press_detail.do?idx=1532) |
| **BT / Toshiba UK QKD trial** | BB84 / TF-QKD | 40 km (London metro) | — | BT OpenReach fiber; 2022–2024 | First UK commercial-grade QKD trial on production telecom fiber [[1]](https://www.bt.com/about/bt/policy-and-regulation/technology/quantum) |

**IETF QIRG (Quantum Internet Research Group):** The IETF Quantum Internet Research Group (QIRG) is developing the architectural framework for a future quantum internet. Key documents include draft-irtf-qirg-quantum-internet-use-cases (use cases) and draft-irtf-qirg-principles (architectural principles). QIRG defines a layered quantum network stack: physical layer (photon sources, detectors, fiber), link layer (entanglement generation + heralding), network layer (entanglement routing and swapping), and application layer (QKD key delivery, distributed quantum computation). This mirrors the classical Internet's OSI model but with fundamentally different constraints (no-cloning, quantum memory decoherence) [[1]](https://datatracker.ietf.org/rg/qirg/about/).

**ITU-T standardization:** The ITU-T Study Group 13 (SG-13) standardized quantum network reference architecture in 2025 (Y.3800 series). These define functional architecture, interface specifications, and security requirements for QKD networks integrated into classical telecommunications. ETSI (European Telecommunications Standards Institute) has produced the QKD API standard (GS QKD 004) specifying the interface between QKD hardware and the key management system that delivers keys to applications [[1]](https://www.etsi.org/technologies/quantum-key-distribution).

**Key management integration:** Deployed QKD systems do not deliver keys directly to applications — they feed into a Quantum Key Management System (QKMS) that stores, routes, and provisions QKD-derived keys to classical applications (TLS, IPsec, storage encryption). The ETSI QKD API standardizes the interface between QKD hardware and the QKMS. NIST SP 1800-38 provides guidance on integrating QKD with classical network infrastructure [[1]](https://www.nist.gov/publications/migration-post-quantum-cryptography).

**Trusted node networks:** Current metropolitan QKD deployments (Beijing-Shanghai backbone, Geneva network, Tokyo QKD network) use "trusted relay" nodes where the QKD key is decrypted and re-encrypted at each intermediate node — classical security is required at every relay. True end-to-end information-theoretic security requires quantum repeaters (not yet available at field scale). Trusted-node networks are QKD + classical security, not purely quantum-secure end-to-end.

**State of the art:** ID Quantique and Toshiba are the leading commercial DV-QKD vendors; SK Telecom has the first 5G-integrated deployment; China operates the largest network (2,000+ km). IETF QIRG and ITU-T SG-13 are developing the standards layer. Full quantum-secure long-distance networking awaits third-generation quantum repeaters. See [Quantum Key Distribution (QKD)](#quantum-key-distribution-qkd), [Twin-Field QKD (TF-QKD)](#twin-field-qkd-tf-qkd), [Continuous-Variable QKD (CV-QKD)](#continuous-variable-qkd-cv-qkd), and [Quantum Repeaters and Quantum Networks](#quantum-repeaters-and-quantum-networks).

**Production readiness:** Production
Commercial systems deployed by ID Quantique, Toshiba, and QuantumCTek. China operates 2,000+ km QKD backbone. SK Telecom has 5G-integrated QKD.

**Implementations:**
- [ID Quantique Cerberis](https://www.idquantique.com/quantum-safe-security/products/) — commercial QKD platform
- [Toshiba QKD](https://www.toshiba.eu/quantum/products/quantum-key-distribution/) — commercial QKD system
- [Open QKD (EU)](https://openqkd.eu/) — EU-funded open QKD testbed and reference implementations

**Security status:** Caution
Information-theoretically secure in theory. Practical systems face side-channel risks (detector blinding, Trojan horse attacks). Implementation security auditing is essential.

**Community acceptance:** Emerging
ETSI QKD ISG and ITU-T SG-13 standards. Widely deployed in China and growing in Europe. NSA does not endorse QKD for NSS, preferring PQC. Dual QKD+PQC approach gaining traction.

---

## CNSA 2.0 and PQC Migration Policy

**Goal:** Provide the authoritative US government timeline and algorithm requirements for migrating national security systems to post-quantum cryptography. The NSA's Commercial National Security Algorithm Suite 2.0 (CNSA 2.0, September 2022) specifies the PQC algorithms that must replace classical public-key cryptography in National Security Systems (NSS), with hard deadlines through 2035. It is the most influential policy driver for enterprise PQC adoption globally.

| Requirement | Algorithm | Timeline | Note |
|-------------|-----------|----------|------|
| **Key establishment** | ML-KEM (FIPS 203) | Exclusively by 2033 | Replaces RSA/ECDH in all NSS key exchange |
| **Digital signatures** | ML-DSA (FIPS 204) | Exclusively by 2033 | Replaces RSA/ECDSA for NSS signing |
| **Software/firmware signing** | SLH-DSA (FIPS 205) or ML-DSA | Available now; exclusively by 2033 | Hash-based or lattice-based; no classical sigs |
| **Key exchange (transition)** | Hybrid PQ+classical (X25519+ML-KEM) | Now–2033 | Hybrid permitted during transition period |
| **Symmetric** | AES-256 | Required now | Grover halves AES-128; AES-256 sufficient |
| **Hashing** | SHA-384 or SHA-512 | Required now | BHT algorithm reduces SHA-256 collision resistance |

**CNSA 2.0 vs. CNSA 1.0:** CNSA 1.0 (2015) specified classical algorithms (RSA-3072+, ECDH P-384, AES-256, SHA-384). CNSA 2.0 replaces all asymmetric algorithms with their NIST PQC counterparts. Notably, CNSA 2.0 does not endorse QKD as a replacement for PQC — the NSA explicitly states that QKD does not meet NSS requirements due to the need for specialized hardware, trusted relay infrastructure, and lack of authentication [[1]](https://media.defense.gov/2022/Sep/07/2003071836/-1/-1/0/CSI_CNSA_2.0_FAQ_.PDF).

**Deadlines by system type:**
- **COTS software and cloud services:** PQC-ready products required by 2025; exclusively PQC by 2030
- **Networking equipment (VPN, TLS):** Exclusively PQC by 2030
- **Custom applications (firmware, PKI):** Exclusively PQC by 2033
- **Long-lead systems (satellites, HSMs):** Exclusively PQC by 2035 (extended timeline)

**UK NCSC guidance:** The UK National Cyber Security Centre issued equivalent guidance recommending ML-KEM-768/1024, ML-DSA-65/87, and SLH-DSA for government systems, with hybrid PQ+classical deployment during the transition period [[1]](https://www.ncsc.gov.uk/collection/post-quantum-cryptography).

**NIST NCCoE Migration Project:** NIST's National Cybersecurity Center of Excellence is developing practice guides (NIST SP 1800-38) for PQC migration, covering cryptographic discovery, hybrid deployment, and testing. The project focuses on TLS, SSH, S/MIME, and code signing as the highest-priority migration targets [[1]](https://www.nccoe.nist.gov/crypto-agility-considerations-migrating-post-quantum-cryptographic-standards).

**State of the art:** CNSA 2.0 is the current US NSS requirement (effective 2022). FIPS 203/204/205/206 are the mandated algorithms. "Harvest-now, decrypt-later" threats make immediate hybrid deployment urgent even before 2030 deadlines. See [Post-Quantum Cryptography](#post-quantum-cryptography) for algorithm details and [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange) for transition-period deployments.

**Production readiness:** Production
CNSA 2.0 is the active US NSS policy (effective 2022). FIPS 203/204/205/206 are the mandated algorithms with hard deadlines through 2035.

**Implementations:**
- [NIST NCCoE PQC Migration Guides](https://www.nccoe.nist.gov/crypto-agility-considerations-migrating-post-quantum-cryptographic-standards) — NIST SP 1800-38 practice guides
- [Cryptographic Discovery tools](https://github.com/IBM/sonar-cryptography) ⭐ 59 — Java, IBM Sonar Cryptography plugin for PQC migration discovery

**Security status:** Secure
Policy framework; security depends on the underlying NIST-standardized algorithms (ML-KEM, ML-DSA, SLH-DSA). AES-256 and SHA-384+ for symmetric.

**Community acceptance:** Standard
NSA-mandated for US NSS. UK NCSC, German BSI, and French ANSSI have issued equivalent guidance. The most influential PQC migration policy globally.

---

## Post-Quantum Composite Signatures and Certificates

**Goal:** Represent both a classical and a post-quantum signature in a single X.509 certificate or CMS SignedData structure, enabling simultaneous verification by legacy classical verifiers and new PQ-aware verifiers. Composite cryptography (draft-ietf-lamps-pq-composite-sigs) packages two algorithm–key–signature tuples into a single ASN.1 structure, ensuring that a forger must break both the classical scheme and the PQ scheme to produce a valid forgery — providing cryptographic agility during the transition without changing PKI infrastructure.

| Construction | Classical Alg | PQ Alg | Signature Size | Note |
|-------------|--------------|--------|---------------|------|
| **id-MLDSA44-RSA2048-PSS-SHA256** | RSA-2048 PSS | ML-DSA-44 | ~2.4 KB + RSA | Smallest composite; NIST Level 1 [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/) |
| **id-MLDSA44-Ed25519-SHA512** | Ed25519 | ML-DSA-44 | ~2.5 KB | Compact classical; IETF draft [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/) |
| **id-MLDSA65-ECDSA-P256-SHA512** | ECDSA P-256 | ML-DSA-65 | ~3.3 KB | NIST Level 3; enterprise PKI target [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/) |
| **id-MLDSA87-ECDSA-P384-SHA512** | ECDSA P-384 | ML-DSA-87 | ~4.6 KB | NIST Level 5; highest security [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/) |
| **id-SLH-DSA-ECDSA-P256** | ECDSA P-256 | SLH-DSA-SHA2-128s | ~8 KB | Hash-based PQ + classical [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/) |

**IETF draft-ietf-lamps-pq-composite-sigs:** The LAMPS (Limited Additional Mechanisms for PKIX and SMIME) working group is developing the composite signature standard. A composite signature value is the DER encoding of a SEQUENCE of two SignatureValue BIT STRINGs; a composite public key is a SEQUENCE of two SubjectPublicKeyInfo structures. Both must verify for the composite signature to be accepted — the security is the AND of both individual securities. The draft reached IETF Last Call in 2025 [[1]](https://datatracker.ietf.org/doc/draft-ietf-lamps-pq-composite-sigs/).

**Companion drafts:**
- **draft-ietf-lamps-pq-composite-kem** — Composite KEM (ML-KEM + ECDH) for certificate key exchange
- **draft-ietf-lamps-cert-binding-for-multi-auth** — Binding multiple certificates for dual-algorithm PKI
- **draft-ietf-tls-hybrid-design** — TLS 1.3 hybrid key exchange design principles (combiners, negotiation)

**X.509 composite certificates:** A CA issues a certificate containing a composite public key. The TBS (To-Be-Signed) certificate is signed with a composite signature — both the CA's classical and PQ private keys sign the same TBS. A legacy verifier extracts only the classical subkey and subsignature; a PQ-aware verifier validates both. No change to the certificate chain model is required — only new OIDs.

**KEMTLS and composite CAs:** Composite certificates enable a phased migration: existing CAs can issue composite certificates that work in both classical TLS 1.3 and new KEMTLS deployments. This allows hardware security modules (HSMs) and root CA infrastructure to remain operational while adding PQ attestation. See [KEMTLS](categories/12-secure-communication-protocols.md#kemtls) for the related PQ TLS handshake design.

**State of the art:** draft-ietf-lamps-pq-composite-sigs is a primary IETF deliverable for the PQC PKI transition (2024–2025). Open Quantum Safe (OQS) provides composite certificate generation in liboqs; Let's Encrypt has announced plans to issue composite PQ certificates for testing. Closely related to [Post-Quantum Cryptography](#post-quantum-cryptography), [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange), and [CNSA 2.0 and PQC Migration Policy](#cnsa-20-and-pqc-migration-policy).

**Production readiness:** Experimental
IETF draft-ietf-lamps-pq-composite-sigs reached Last Call (2025). OQS provides composite certificate generation. Let's Encrypt planning test issuance.

**Implementations:**
- [liboqs (Open Quantum Safe)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, composite certificate generation support
- [OQS-OpenSSL provider](https://github.com/open-quantum-safe/oqs-provider) ⭐ 460 — C, OpenSSL 3.x provider with composite PQ certificates
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, composite signature and certificate support

**Security status:** Secure
Security is the AND of both classical and PQ components — forger must break both. No known weaknesses in the composite construction itself.

**Community acceptance:** Emerging
IETF LAMPS working group primary deliverable (2024-2025). Supported by major PKI vendors. X.509 composite certificates are the leading approach for PQC PKI migration.

---

## Post-Quantum TLS Performance Benchmarks

**Goal:** Quantify the latency, bandwidth, and handshake overhead of post-quantum KEMs and signatures in TLS 1.3, SSH, and HTTPS deployments — providing practitioners with the data needed to select PQ algorithms for production deployments. PQC algorithm performance differs substantially from classical counterparts in ciphertext size, signature size, and CPU time; these differences affect connection latency, server memory, certificate chain bandwidth, and CDN caching.

| Algorithm Pair (KEM + Sig) | HS Latency (LAN) | HS Latency (100 ms RTT) | Server Cert Size | Note |
|---------------------------|-----------------|------------------------|-----------------|------|
| **X25519 + ECDSA P-256** (classical baseline) | ~0.3 ms | ~110 ms | ~1.1 KB | Baseline; TLS 1.3 classical [[1]](https://pq.cloudflare.com/) |
| **X25519MLKEM768 + ECDSA P-256** (hybrid KEM) | ~0.4 ms | ~111 ms | ~2.2 KB | +1 KB ciphertext; minimal latency impact [[1]](https://blog.cloudflare.com/pq-2024/) |
| **ML-KEM-768 + ML-DSA-65** (full PQ) | ~0.6 ms | ~112 ms | ~3.8 KB | Full PQ; larger cert chain [[1]](https://openquantumsafe.org/benchmarks/) |
| **ML-KEM-768 + SLH-DSA-128s** (PQ hash sig) | ~15 ms | ~125 ms | ~8.1 KB | SLH-DSA signing is slow; not suitable for high-TPS servers [[1]](https://openquantumsafe.org/benchmarks/) |
| **ML-KEM-768 + Falcon-512** (NTRU lattice) | ~0.5 ms | ~112 ms | ~1.8 KB | Compact; fast; floating-point signing risk [[1]](https://openquantumsafe.org/benchmarks/) |
| **Classic McEliece + ML-DSA-65** | ~0.7 ms | ~113 ms | ~1.05 MB | Public key dominates; impractical for web TLS [[1]](https://openquantumsafe.org/benchmarks/) |

**Key findings from Cloudflare and Google experiments (2023–2024):**
- Hybrid X25519+ML-KEM-768 adds ~1.1 KB to the ClientHello/ServerHello but negligible latency on well-connected links; this was deployed to 100% of Cloudflare TLS traffic in 2024 [[1]](https://blog.cloudflare.com/pq-2024/).
- On high-latency satellite or mobile links (RTT ≥ 200 ms), larger PQ ciphertexts that cause TCP fragmentation add one full RTT — approximately 200 ms extra. Minimizing ciphertext size is critical for mobile TLS.
- Signature performance is dominated by signature size, not CPU time: ML-DSA-65 certificates (~3.3 KB signature) fit in one TLS record; SLH-DSA-128f (~17 KB) spans multiple records and increases TLS handshake round trips by one on standard MSS (1460 bytes).
- Certificate chain overhead compounds: a three-certificate chain (leaf + intermediate + root) multiplies per-cert overhead. Falcon-512's 666-byte signature makes it attractive for certificate chains; SLH-DSA is unsuitable for chains requiring multiple signatures.

**OQS-OpenSSL benchmarks:** The Open Quantum Safe project maintains continuous integration benchmarks of liboqs algorithms in OpenSSL and nginx, covering key generation, encapsulation/decapsulation, signing, and verification throughput on AWS c5.xlarge instances. ML-KEM-768 encapsulation runs at >1 million operations/second; ML-DSA-65 signing runs at ~20,000 ops/second — both fast enough for high-volume TLS termination [[1]](https://openquantumsafe.org/benchmarks/).

**DNS and DNSSEC overhead:** PQ signatures in DNSSEC responses are a distinct problem from TLS — DNS UDP responses are limited to 512 bytes (or 4096 with EDNS0). ML-DSA-65 (3.3 KB signature) and SLH-DSA (8–49 KB) make DNSSEC responses incompatible with UDP; TCP fallback is required. Falcon-512 (666 B) and ML-DSA-44 (2.4 KB) are the most viable PQ options for DNSSEC [[1]](https://www.ietf.org/archive/id/draft-ietf-dnsop-dnssec-pqc-00.txt).

**State of the art:** X25519MLKEM768 is deployed in production at Cloudflare, Google, and Fastly (2024); full PQ TLS (ML-KEM + ML-DSA) is available in OQS-nginx and wolfSSL. The main bottleneck for full PQ transition is certificate chain size with PQ signatures, not KEM performance. See [Hybrid PQ/Classical Key Exchange](#hybrid-pqclassical-key-exchange), [Post-Quantum Cryptography](#post-quantum-cryptography), and [Post-Quantum Composite Signatures and Certificates](#post-quantum-composite-signatures-and-certificates).

**Production readiness:** Production
X25519MLKEM768 deployed in production at Cloudflare, Google, and Fastly (2024). Full PQ TLS available in OQS-nginx and wolfSSL.

**Implementations:**
- [OQS-OpenSSL](https://github.com/open-quantum-safe/oqs-provider) ⭐ 460 — C, PQ TLS benchmarking with OpenSSL
- [Cloudflare PQ dashboard](https://pq.cloudflare.com/) — live PQ deployment statistics and benchmarks
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, production TLS with PQ benchmarks

**Security status:** Secure
Benchmarks reflect NIST-standardized algorithms. Performance characteristics are well-documented. Certificate chain size (not KEM performance) is the main deployment bottleneck.

**Community acceptance:** Standard
Cloudflare, Google, and OQS benchmarks are widely cited. IETF drafts reference these measurements. Industry consensus on hybrid KEM as the near-term approach.

---

## Quantum Error Correction — Surface Codes and Logical Qubits

**Goal:** Protect quantum information from decoherence and gate errors using redundancy, enabling the fault-tolerant quantum computers that would run Shor's algorithm at cryptographically relevant scale. Physical qubits have error rates of 10⁻³ to 10⁻² per operation — far too high for useful computation. Quantum error correction (QEC) encodes one logical qubit into many physical qubits so that errors can be detected and corrected without measuring (and collapsing) the logical state. Understanding QEC overhead is essential for estimating when a cryptographically relevant quantum computer (CRQC) might exist.

| Code / Architecture | Physical Qubits per Logical | Threshold Error Rate | Note |
|--------------------|---------------------------|---------------------|------|
| **Surface code (distance d)** | ~2d² physical per logical | ~1% (high threshold) | Dominant approach; nearest-neighbor gates; d=7 gives ~10⁻¹⁰ logical error rate at p=10⁻³ [[1]](https://arxiv.org/abs/1208.0928) |
| **Rotated planar code** | ~d² + (d−1)² | ~1% | Slightly fewer qubits than standard surface code; same threshold [[1]](https://arxiv.org/abs/1202.5395) |
| **Color codes** | ~3d² | ~0.1% | Lower threshold; transversal T-gate without magic state distillation [[1]](https://arxiv.org/abs/quant-ph/0605134) |
| **Topological qubits (Majorana)** | ~10× fewer (projected) | ~1% (projected) | Microsoft Station Q; non-Abelian anyons encode qubits topologically; 2025 hardware demonstration [[1]](https://arxiv.org/abs/2503.05679) |
| **Concatenated codes** | ~7^k for k levels | ~10⁻⁴ | First QEC proposal; superseded by surface codes for 2D hardware [[1]](https://arxiv.org/abs/quant-ph/9602019) |

**Surface code mechanics:** A surface code of distance d on a d×d qubit grid detects any Pauli error (X, Y, Z) on up to ⌊(d−1)/2⌋ physical qubits. Syndrome extraction measures 4-qubit stabilizers (XX and ZZ around each face/vertex) without measuring the encoded logical qubit. A classical decoder (minimum-weight perfect matching, MWPM, or neural network decoder) processes syndrome measurements to infer and correct errors. The logical error rate scales as p_L ≈ C·(p/p_th)^{⌈d/2⌉} where p is the physical error rate and p_th ≈ 1% is the threshold.

**Physical qubit overhead for Shor's algorithm:** Running Shor's algorithm on RSA-2048 requires approximately 4,000 logical qubits with error rates ≤ 10⁻¹⁵. At physical error rate p = 10⁻³ (current superconducting qubit state of the art), achieving p_L = 10⁻¹⁵ requires surface code distance d ≈ 27, giving ~2×27² ≈ 1,500 physical qubits per logical qubit. Total: 4,000 × 1,500 ≈ **6 million physical qubits** (Litinski 2019 estimate) [[1]](https://quantum-journal.org/papers/q-2019-03-05-128/). With magic state distillation overhead included, estimates rise to 10–20 million physical qubits [[1]](https://arxiv.org/abs/2203.08823).

**2025 hardware milestones:**
- **Google Willow (2024):** 105-qubit superconducting chip; demonstrated below-threshold error correction with surface code distance d=5 and d=7, achieving logical error rates that decrease exponentially with d — the first unambiguous demonstration of scalable QEC [[1]](https://www.nature.com/articles/s41586-024-08449-y).
- **Microsoft topological qubits (2025):** Demonstrated 8 topological qubits encoded in Majorana zero modes on InAs/Al nanowires; error rates measured at ~10⁻³; if scaling confirms lower overhead than surface codes, the physical qubit count for a CRQC could drop by ~10× [[1]](https://arxiv.org/abs/2503.05679).
- **IBM roadmap:** IBM Heron (133 qubits, 2023) and Flamingo (1386 qubits modular, 2024) target 100,000-qubit systems by 2033, approximately matching the physical qubit count for a CRQC.

**Implication for PQC timelines:** Current hardware has 1,000–2,000 physical qubits with error rates 10⁻³. A CRQC requires ~10–20 million physical qubits at 10⁻³ error rate (or fewer at lower error rates). The Google Willow demonstration validates that scaling surface codes reduces logical error rates — the key open question is whether 10⁶+ qubit systems can maintain per-gate error rates below 10⁻³. Most cryptographic risk analyses place a CRQC at 10–20 years away (2035–2045), justifying the CNSA 2.0 migration deadlines. See [Shor's Algorithm](#shors-algorithm-and-quantum-threats-to-public-key-cryptography) and [CNSA 2.0 and PQC Migration Policy](#cnsa-20-and-pqc-migration-policy).

**State of the art:** Surface codes are the leading QEC architecture; Google Willow (2024) confirmed below-threshold exponential suppression. Microsoft's topological qubit approach (2025) may dramatically reduce physical overhead if it scales. No CRQC capable of attacking RSA-2048 or P-256 is expected before 2035. See [Quantum Advantage Experiments](#quantum-advantage-experiments) for quantum supremacy demonstrations on non-cryptographic tasks.

**Production readiness:** Experimental
Google Willow (2024) demonstrated below-threshold QEC scaling. Microsoft topological qubits (2025) demonstrated 8 encoded qubits. No fault-tolerant quantum computer yet.

**Implementations:**
- [Stim (Google)](https://github.com/quantumlib/Stim) ⭐ 683 — C++/Python, fast stabilizer circuit simulator for surface codes
- [PyMatching](https://github.com/oscarhiggott/PyMatching) ⭐ 305 — Python, MWPM decoder for surface codes
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QEC modules and surface code simulation

**Security status:** Secure
QEC is a defensive technology (protects quantum information). Its progress determines when a CRQC might threaten classical cryptography. Current hardware is far from CRQC scale.

**Community acceptance:** Standard
Surface codes are the consensus leading QEC architecture. Google Willow results published in Nature (2024). Microsoft topological approach is the main alternative. IBM, Google, and academic groups actively pursuing QEC milestones.

---

## Quantum Advantage Experiments

**Goal:** Document experimental demonstrations where quantum hardware outperforms classical computers on specific tasks — establishing empirical evidence that quantum advantage is achievable, even on non-cryptographic problems. These experiments are not attacks on cryptography (they use random circuit sampling, boson sampling, or Gaussian boson sampling, not Shor's algorithm), but they define the frontier of quantum hardware capability and inform estimates of when a cryptographically relevant quantum computer (CRQC) might be built.

| Experiment | Year | Hardware | Qubits / Modes | Classical Cost (claimed) | Verified? | Note |
|------------|------|----------|---------------|--------------------------|-----------|------|
| **Google Sycamore** | 2019 | Superconducting | 53 qubits | 10,000 years (Summit) | Disputed | Random circuit sampling; IBM showed ~2.5 days classical [[1]](https://www.nature.com/articles/s41586-019-1666-5) |
| **USTC Jiuzhang 1.0** | 2020 | Photonic (boson sampling) | 76 modes | ~600 million years (classical) | Partially | Gaussian boson sampling; classical spoofing found 2022 [[1]](https://www.science.org/doi/10.1126/science.abe8770) |
| **USTC Jiuzhang 2.0** | 2021 | Photonic | 113 modes | 10^24 years | Partially | Improved GBS; classical spoofing attack not yet defeated [[1]](https://arxiv.org/abs/2106.15534) |
| **USTC Zuchongzhi 2.1** | 2021 | Superconducting | 60 qubits (56 used) | ~8 years (classical) | Partially | Random circuit sampling; better than Sycamore [[1]](https://arxiv.org/abs/2109.03494) |
| **Quantinuum H2 Certified Randomness** | 2023 | Trapped-ion | 56 qubits | Classically infeasible (certified) | Yes | First classically verifiable quantum advantage; 71,313 certified random bits; Nature 2025 [[1]](https://www.nature.com/articles/s41586-025-08737-1) |
| **Google Willow Surface Code** | 2024 | Superconducting | 105 qubits | Below-threshold QEC scaling | Yes (QEC) | Demonstrated exponential logical error suppression; not supremacy per se [[1]](https://www.nature.com/articles/s41586-024-08449-y) |
| **IonQ Forte** | 2024 | Trapped-ion | 36 AQ (algorithmic qubits) | — | Application-specific | 36 algorithmic qubits; demonstrated quantum chemistry advantage for small molecules [[1]](https://ionq.com/news/ionq-forte-enterprise) |

**What "quantum advantage" means:** A device demonstrates quantum advantage if it solves a specific problem faster than any classical computer. The Sycamore experiment used random circuit sampling (RCS) — sampling from the output distribution of a random 53-qubit circuit. The problem has no known practical application; it was chosen because it is easy for quantum hardware and (allegedly) hard to simulate classically.

**Classical counter-challenges:** Google claimed Sycamore would take 10,000 years on Summit; IBM demonstrated it could be done in 2.5 days with better classical tensor-network contraction. USTC's Jiuzhang GBS experiments face similar classical spoofing challenges — Villalonga et al. (2022) showed that approximate classical simulation can match GBS output statistics for commercially relevant fidelities. The "quantum advantage" boundary for these sampling tasks continues to shift as classical algorithms improve.

**Certified randomness — the first verifiable advantage:** The Quantinuum H2 experiment (Nature 2025) is qualitatively different from sampling experiments: it produces classical output (random bits) that can be classically verified as genuinely quantum-generated, with a formal cryptographic proof under standard computational assumptions. This is the first experiment where quantum advantage is not merely claimed but cryptographically certified and practically useful (for randomness generation). See [Certified Quantum Randomness / Proof of Quantumness](#certified-quantum-randomness--proof-of-quantumness).

**Relevance to cryptographic timelines:** None of these experiments demonstrate capabilities relevant to Shor's algorithm — they use dozens of noisy physical qubits for sampling tasks, not thousands of error-corrected logical qubits for period-finding. The gap between current hardware and a CRQC (cryptographically relevant quantum computer) remains enormous. However, these experiments validate that quantum hardware is progressing and that error rates are decreasing — accelerating the case for immediate PQC migration. See [Quantum Error Correction](#quantum-error-correction--surface-codes-and-logical-qubits) and [Shor's Algorithm](#shors-algorithm-and-quantum-threats-to-public-key-cryptography).

**State of the art:** Quantinuum H2 certified randomness (Nature 2025) is the most rigorous quantum advantage demonstration. Google Willow (2024) confirmed below-threshold QEC scaling — a milestone for fault-tolerant quantum computing. Classical simulation of random circuit sampling remains competitive for current depth; the quantum advantage frontier continues to evolve. No hardware yet approaches the scale needed for cryptographically relevant computation.

**Production readiness:** Experimental
Quantinuum H2 certified randomness (2025) is the first practically useful demonstration. Other experiments (Sycamore, Jiuzhang) are benchmarks, not deployable products.

**Implementations:**
- [Cirq (Google)](https://github.com/quantumlib/Cirq) ⭐ 4.9k — Python, framework used for Sycamore random circuit sampling
- [Strawberry Fields (Xanadu)](https://github.com/XanaduAI/strawberryfields) ⭐ 842 — Python, photonic quantum computing for boson sampling
- [Quantinuum Quantum Origin](https://www.quantinuum.com/products/quantum-origin) — commercial certified randomness product

**Security status:** Secure
These experiments do not threaten cryptographic security. They demonstrate quantum hardware capability on non-cryptographic tasks. Certified randomness provides provably random bits.

**Community acceptance:** Widely trusted
Published in Nature and Science. Quantinuum H2 certified randomness is the most rigorous demonstration. Google Willow QEC milestone widely recognized. Classical counter-challenges are part of healthy scientific process.

---

## Device-Independent Quantum Key Distribution (DI-QKD)

**Goal:** Gold-standard quantum key exchange that makes zero assumptions about the internal workings of the devices — security is certified solely by observed Bell inequality violations between distant parties.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Ekert E91 (DI framing)** | 1991 | Bell inequality + entanglement | Original proposal to derive key security from Bell violation [[1]](https://link.springer.com/chapter/10.1007/978-3-319-53412-1_2) |
| **Vazirani-Vidick DI-QKD** | 2014 | Loophole-free Bell test | First full security proof for DI-QKD against quantum adversaries [[1]](https://doi.org/10.1103/PhysRevLett.113.140501) |
| **Nadlinger et al. (Oxford)** | 2022 | Trapped Sr-88 ions, 400 m | First complete DI-QKD experiment between distant nodes; loophole-free Bell test [[1]](https://www.nature.com/articles/s41586-022-04941-5) |
| **Zhang et al. (USTC)** | 2022 | Trapped ions, finite-key | Parallel DI-QKD demonstration with finite-key security analysis [[1]](https://www.nature.com/articles/s41586-022-04891-y) |
| **Routed Bell DI-QKD** | 2025 | Photonic routing | DI-QKD based on routed Bell tests; improved rate scaling [[1]](https://link.aps.org/doi/10.1103/PRXQuantum.6.020311) |

**State of the art:** First experimental demonstrations achieved in 2022 (Oxford, USTC) over laboratory distances using trapped ions. Rates remain extremely low (~0.07 bits per heralded event). Practical deployment requires major improvements in entanglement distribution rates and detector efficiency. Extends [QKD](#quantum-key-distribution-qkd) to the strongest possible trust model.

**Production readiness:** Research
First experimental demonstrations in 2022 (Oxford, USTC) over laboratory distances. Rates extremely low (~0.07 bits per heralded event). No commercial systems.

**Implementations:**
- [NetSquid (QuTech)](https://netsquid.org/) — Python, quantum network simulation including DI-QKD scenarios

**Security status:** Secure
Strongest possible security model — zero assumptions about device internals. Security certified solely by Bell inequality violations. Information-theoretic security.

**Community acceptance:** Niche
Published in Nature (2022). Recognized as the gold standard for QKD security. Practical deployment requires major hardware improvements (entanglement rates, detector efficiency).

---

## Quantum Secure Direct Communication (QSDC)

**Goal:** Transmit secret messages directly over a quantum channel without first establishing a shared key — unlike QKD, the message itself travels as quantum states, with built-in eavesdropping detection.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Long-Liu Two-Step** | 2002 | EPR pairs | First QSDC protocol; transmit messages using entangled pairs with block checking [[1]](https://doi.org/10.1103/PhysRevA.65.032302) |
| **DL04** | 2004 | Single photons | Practical single-photon QSDC; simpler than entanglement-based schemes [[1]](https://doi.org/10.1103/PhysRevA.69.052319) |
| **Hu et al. (100 km fiber)** | 2022 | Time-bin + phase encoding | First intercity QSDC demonstration over 100 km fiber [[1]](https://www.nature.com/articles/lsa2016144) |
| **15-User QSDC Network** | 2021 | DL04 + wavelength multiplexing | First multi-user QSDC network with 15 users; star topology [[1]](https://www.nature.com/articles/s41377-021-00634-2) |
| **Chip-Integrated QDS+QSDC** | 2025 | Silicon photonics | Chip-integrated quantum signature network over 200 km fiber [[1]](https://www.nature.com/articles/s41377-025-01775-4) |

**State of the art:** Demonstrated over 100 km fiber (2022) and in 15-user networks (2021). Active research in China with plans for metropolitan deployment. Unlike [QKD](#quantum-key-distribution-qkd), QSDC eliminates the key distribution step entirely, but requires quantum memory or block transmission for security checking.

**Production readiness:** Experimental
Demonstrated over 100 km fiber (2022) and in 15-user networks (2021). Active Chinese research with plans for metropolitan deployment. No commercial products outside China.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QSDC protocol simulation

**Security status:** Secure
Information-theoretically secure; eavesdropping detection is built in. Requires quantum memory or block transmission for security checking, which introduces practical constraints.

**Community acceptance:** Niche
Primarily developed in Chinese research institutions. Published in Nature Light: Science & Applications. Less adoption outside China; complements QKD research.

---

## Quantum Digital Signatures (QDS)

**Goal:** Information-theoretically secure digital signatures using quantum mechanics — guarantee non-repudiation, unforgeability, and transferability based on quantum no-cloning rather than computational hardness assumptions.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Gottesman-Chuang QDS** | 2001 | Quantum one-way functions | First QDS proposal; requires quantum memory and swap test [[1]](https://arxiv.org/abs/quant-ph/0105032) |
| **Dunjko-Wallden-Kent QDS** | 2014 | Phase-encoded coherent states | First experimentally feasible QDS; no quantum memory needed [[1]](https://www.nature.com/articles/ncomms2172) |
| **OTUH-QDS (One-Time Universal Hashing)** | 2018 | Universal hashing + QKD | Efficient multi-bit signing; 10^8x improvement for long messages [[1]](https://dl.acm.org/doi/10.1007/s11128-018-2116-2) |
| **Experimental QDS Network (Nanjing)** | 2023 | BB84 + QDS | Quantum secure network with integrated digital signatures and encryption [[1]](https://academic.oup.com/nsr/article/10/4/nwac228/6769862) |
| **High-Rate QDS (250 km)** | 2025 | Twin-field + QDS | 5186 signatures/sec over 75 km; QDS over 250 km fiber [[1]](https://arxiv.org/html/2603.16764) |

**State of the art:** Practical QDS demonstrated in multi-user networks (2023) and over 250 km fiber (2025). Signature rates now exceed thousands per second. Complements [QKD](#quantum-key-distribution-qkd) by adding authentication and non-repudiation to quantum-secured channels.

**Production readiness:** Experimental
Demonstrated in multi-user networks (2023, Nanjing) and over 250 km fiber (2025). Signature rates exceed thousands per second. No commercial products.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QDS protocol simulation

**Security status:** Secure
Information-theoretically secure non-repudiation from quantum no-cloning. OTUH-QDS provides efficient multi-bit signing.

**Community acceptance:** Niche
Active research community, primarily in China and UK. Published in National Science Review and Physical Review journals. No standardization effort yet.

---

## Blind Quantum Computation (BQC)

**Goal:** Delegate arbitrary quantum computations to an untrusted quantum server while keeping inputs, outputs, and the computation itself perfectly private — the server learns nothing about what it is computing.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Childs (Circuit BQC)** | 2005 | Quantum circuit + OTP | First BQC protocol; requires quantum communication for each gate [[1]](https://doi.org/10.5555/2011637.2011639) |
| **BFK (Broadbent-Fitzsimons-Kashefi)** | 2009 | Measurement-based QC | Universal BQC; client only prepares single qubits; server is computationally blind [[1]](https://arxiv.org/abs/0807.4154) |
| **Morimae-Fujii** | 2013 | Topological codes + BQC | Fault-tolerant BQC using topological error correction [[1]](https://doi.org/10.1038/ncomms2043) |
| **Verifiable BQC (Fitzsimons-Kashefi)** | 2017 | Trap qubits | Unconditionally verifiable BQC; client detects cheating server [[1]](https://hal.science/hal-02164540) |
| **Mahadev Classical Verification** | 2018 | LWE + quantum | First protocol for a purely classical client to verify quantum computation [[1]](https://arxiv.org/abs/1804.01082) |

**State of the art:** BFK protocol (2009) remains the standard for quantum-client BQC. Mahadev (2018, FOCS best paper) showed even a classical client can verify quantum computation under LWE. Experimental demonstrations exist for small circuits. Extends [Quantum Homomorphic Encryption](#quantum-homomorphic-encryption) to the interactive setting.

**Production readiness:** Research
Experimental demonstrations exist for small circuits. BFK protocol (2009) is the standard. Mahadev classical verification (2018) is theoretical breakthrough. No production systems.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, BQC protocol simulation
- [SimulaQron (QuTech)](https://github.com/SoftwareQuTech/SimulaQron) ⭐ 130 — Python, quantum network simulator for BQC protocols

**Security status:** Secure
BFK provides perfect privacy (information-theoretic). Mahadev classical verification relies on LWE assumption. Verifiable BQC detects cheating servers unconditionally.

**Community acceptance:** Niche
Mahadev (2018) won FOCS best paper. Active research at QIP and STOC/FOCS. Important for quantum cloud computing vision but no near-term commercial deployment.

---

## Quantum Homomorphic Encryption (QHE)

**Goal:** Compute on encrypted quantum data without decrypting it — a quantum server evaluates a quantum circuit on ciphertexts, returning encrypted results that only the key holder can decrypt. The quantum analogue of classical FHE.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Liang (QFHE from QOTPs)** | 2013 | Quantum one-time pad | First quantum FHE scheme for polynomial-size circuits; exponential overhead [[1]](https://arxiv.org/abs/1312.0877) |
| **Broadbent-Jeffery (Leveled QFHE)** | 2015 | Pauli OTP + classical HE | Classical-key QHE for quantum circuits; leveled (bounded depth) [[1]](https://doi.org/10.1007/978-3-662-48000-7_29) |
| **Mahadev (Classical-Key QFHE)** | 2018 | LWE + quantum gadgets | First compact classical-key QHE for all polynomial-time circuits [[1]](https://arxiv.org/abs/1708.02130) |
| **Experimental QHE** | 2020 | Photonic qubits | First experimental demonstration of QHE on photonic platform [[1]](https://www.nature.com/articles/s41534-020-00340-8) |

**State of the art:** Mahadev (2018) achieved compact classical-key QFHE under LWE. A no-go theorem shows that perfect information-theoretic QHE with non-exponential overhead is impossible. Practical implementations demonstrated on photonic platforms (2020). Related to [Blind Quantum Computation](#blind-quantum-computation-bqc) (interactive analogue) and classical [FHE](categories/07-homomorphic-functional-encryption.md#fully-homomorphic-encryption-fhe).

**Production readiness:** Research
First experimental demonstration on photonic platform (2020). Mahadev compact QFHE (2018) is a theoretical breakthrough. No production systems.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QHE protocol simulation and prototyping

**Security status:** Secure
Mahadev QFHE security reduces to LWE. A no-go theorem proves perfect information-theoretic QHE with non-exponential overhead is impossible.

**Community acceptance:** Niche
Active theoretical research at STOC/FOCS/CRYPTO. Experimental demonstration (2020) in Nature Communications. Quantum analogue of classical FHE; important for future quantum cloud computing.

---

## Quantum Oblivious Transfer (QOT)

**Goal:** Two-party cryptographic primitive where a sender transfers information to a receiver such that the sender does not know which piece was received — leveraging quantum mechanics to strengthen security guarantees beyond what is classically possible with computational assumptions alone.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **BBCS (Bennett-Brassard-Crepeau-Skubiszewska)** | 1991 | Conjugate coding | First QOT protocol; builds on BB84 techniques [[1]](https://doi.org/10.1007/3-540-46766-1_37) |
| **Lo (No-Go for Unconditional QOT)** | 1997 | Impossibility result | Proved unconditionally secure QOT is impossible (like quantum bit commitment) [[1]](https://doi.org/10.1103/PhysRevA.56.1154) |
| **Bounded/Noisy Quantum Storage QOT** | 2008 | Noisy storage model | Secure QOT if adversary's quantum memory is bounded or noisy [[1]](https://doi.org/10.1103/PhysRevLett.100.220502) |
| **Bartusek-Coladangelo-Khurana-Salvail** | 2021 | Extractable commitments | QOT from one-way functions (weaker assumption than classically needed) [[1]](https://eprint.iacr.org/2020/1500) |
| **Experimental Secure MPC from QOT** | 2026 | Photonic + bit commitment | First experimental quantum-secure multiparty computation via QOT [[1]](https://www.nature.com/articles/s41534-026-01219-w) |

**State of the art:** QOT from one-way functions (2021) is a landmark result — classically, OT requires public-key assumptions. The noisy quantum storage model provides practical security. First experimental QMPC from QOT demonstrated in 2026. Foundational for [Quantum MPC](#quantum-multi-party-computation-qmpc) and extends classical [Oblivious Transfer](categories/06-multi-party-computation.md#oblivious-transfer-ot--ot-extension).

**Production readiness:** Research
First experimental quantum-secure MPC from QOT demonstrated (2026). Noisy quantum storage model provides practical framework. No commercial systems.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QOT protocol simulation

**Security status:** Secure
Unconditionally secure QOT is impossible (Lo 1997 no-go). Bounded/noisy quantum storage model provides practical security. QOT from one-way functions (2021) is a landmark result.

**Community acceptance:** Niche
QOT from one-way functions (2021) is a major theoretical achievement (weaker assumption than classically needed). Published in Nature Communications (2026 experiment). Active academic research.

---

## Quantum Byzantine Agreement (QBA)

**Goal:** Achieve consensus among distributed parties in the presence of malicious actors, using quantum resources to break the classical 1/3 fault-tolerance bound — quantum entanglement or quantum digital signatures enable agreement tolerating up to (nearly) 1/2 faulty parties instead of the classical limit of 1/3.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Fitzi-Gisin-Maurer** | 2001 | Entangled qubits | First quantum protocol breaking 1/3 bound for 3 parties [[1]](https://doi.org/10.1103/PhysRevLett.87.217901) |
| **Ben-Or-Hassidim** | 2005 | Quantum verifiable SS | Fast quantum BA in O(1) expected rounds with honest majority [[1]](https://doi.org/10.1145/1060590.1060662) |
| **Luo-Feng-Zheng-Xu (QDS-based QBA)** | 2022 | Quantum digital signatures | Breaks 1/3 bound without entanglement; ~1/2 fault tolerance via QDS [[1]](https://spj.science.org/doi/10.34133/research.0272) |
| **Experimental QBA (3-user photonic)** | 2024 | Integrated photonics | First experimental QBA on a 3-user quantum network [[1]](https://www.science.org/doi/10.1126/sciadv.adp2877) |
| **Circular QBA (Scalable)** | 2025 | Semi-decentralized + QDS | Quadratic communication complexity; scalable to many parties [[1]](https://arxiv.org/abs/2602.11592) |

**State of the art:** Classical BA requires n >= 3f+1 parties to tolerate f faults; quantum BA achieves nearly n >= 2f+1. Experimentally demonstrated on 3-user photonic network (2024). Relevant to quantum-secured blockchain and [consensus protocols](categories/13-blockchain-distributed-ledger.md#hotstuff--tendermint-bft).

**Production readiness:** Research
Experimentally demonstrated on 3-user photonic network (2024). Theoretical protocols achieve near-1/2 fault tolerance. No production systems.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QBA protocol simulation
- [NetSquid (QuTech)](https://netsquid.org/) — Python, quantum network simulator for multi-party protocols

**Security status:** Secure
Breaks classical 1/3 fault tolerance bound using quantum resources. QDS-based QBA (2022) achieves near-1/2 tolerance without entanglement.

**Community acceptance:** Niche
Published in Science Advances (2024 experiment). Active research at quantum information conferences. Relevant to future quantum-secured blockchain and distributed systems.

---

## Quantum Zero-Knowledge Proofs

**Goal:** Prove statements without revealing any information beyond their truth — where security holds even against adversaries equipped with quantum computers. Extends classical zero-knowledge to the quantum setting, addressing the challenge that quantum adversaries cannot be "rewound" in the standard way.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Watrous (ZK against Quantum Attacks)** | 2006 | Quantum rewinding | First proof that classical ZK for NP survives quantum verifiers; novel partial-rewind technique [[1]](https://arxiv.org/abs/quant-ph/0511020) |
| **QSZK = QSZK_HV** | 2006 | Quantum statistical ZK | Honest-verifier and general quantum statistical ZK are equivalent [[1]](https://arxiv.org/abs/quant-ph/0202111) |
| **Broadbent-Grilo (QMA-complete QZK)** | 2020 | Quantum commitments | Zero-knowledge for QMA (quantum NP); first computational QZK proof system for all QMA [[1]](https://doi.org/10.1109/FOCS46700.2020.00030) |
| **Ananth-Gulati-Qian-Yuen (Concurrent QZK)** | 2022 | Post-quantum OWFs | Concurrent ZK against quantum attacks from post-quantum one-way functions [[1]](https://eprint.iacr.org/2020/1528) |
| **Bartusek-Brakarski-Lombardi (Non-Interactive QZK)** | 2024 | LWE + quantum | Non-interactive zero-knowledge arguments for QMA in the CRS model [[1]](https://eprint.iacr.org/2024/032) |

**State of the art:** ZK for NP against quantum adversaries established (Watrous 2006). ZK for QMA (quantum NP) achieved (Broadbent-Grilo 2020). Non-interactive quantum ZK from LWE (2024). Extends classical [Zero-Knowledge Proof Systems](categories/04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-overview) to the quantum threat model.

**Production readiness:** Research
Purely theoretical. ZK for NP against quantum adversaries established (Watrous 2006). Non-interactive quantum ZK from LWE (2024). No implementations.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, quantum circuit framework for ZK protocol simulation

**Security status:** Secure
Rigorous security proofs using quantum rewinding techniques. ZK for QMA (quantum NP) achieved under standard assumptions. Non-interactive QZK from LWE (2024).

**Community acceptance:** Niche
Published at FOCS, STOC, CRYPTO. Watrous quantum rewinding (2006) is a foundational technique. Active theoretical research extending classical ZK to quantum settings.

---

## Quantum Key Recycling (QKR)

**Goal:** Encrypt classical messages using quantum ciphertexts such that the encryption key can be securely reused if no eavesdropping is detected — achieving information-theoretic security with key amortization. Classically impossible because a classical eavesdropper leaves no detectable trace.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bennett-Brassard-Breidbart** | 1982 | BB84-like encoding | Original idea predating QKD; encrypt a message, detect eavesdropping, reuse key [[1]](https://doi.org/10.1016/0304-3975(84)90083-3) |
| **Damgard-Pedersen-Salvail** | 2005 | Quantum computer required | Rigorous security analysis; requires full quantum computation for users [[1]](https://doi.org/10.1007/11681878_1) |
| **Fehr-Salvail QKR** | 2017 | BB84 qubits only | Practical QKR: prepare/measure single qubits; full key reuse if no attack detected [[1]](https://arxiv.org/abs/1610.05614) |
| **Leermakers-Skoric (8-state QKR)** | 2018 | 8-state encoding | Optimal key recycling rate; robust against noise [[1]](https://eprint.iacr.org/2016/1122) |

**State of the art:** Fehr-Salvail (2017) provides practical QKR using only BB84 preparation/measurement — no quantum computer needed. Offers better key efficiency than standard [QKD](#quantum-key-distribution-qkd) when messages are long, since the key is recycled rather than consumed. Security is information-theoretic.

**Production readiness:** Research
Theoretical with practical protocol design (Fehr-Salvail 2017 uses only BB84 preparation/measurement). No experimental demonstrations or products.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, QKR protocol simulation

**Security status:** Secure
Information-theoretically secure. Key is recycled (not consumed) when no eavesdropping detected. Better key efficiency than standard QKD for long messages.

**Community acceptance:** Niche
Specialized topic within quantum cryptography. Published in CRYPTO and QIP. Offers efficiency improvement over standard QKD but limited adoption interest.

---

## Quantum Fingerprinting

**Goal:** Determine whether two large classical inputs held by separate parties are equal, using exponentially less quantum communication than any classical protocol — an established quantum communication complexity advantage with practical applications in data deduplication and equality testing.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Buhrman-Cleve-Watrous-de Wolf** | 2001 | Quantum SMP + swap test | First quantum fingerprinting; O(log n) qubits vs. classical Omega(sqrt(n)) bits [[1]](https://arxiv.org/abs/quant-ph/0102001) |
| **Arrazola-Lutkenhaus (Coherent-State)** | 2014 | Coherent laser pulses | Practical protocol using coherent states; no single-photon sources needed [[1]](https://doi.org/10.1103/PhysRevA.89.062305) |
| **Xu et al. (Experimental)** | 2015 | Coherent states, 2 Gbits | First experiment beating classical limit; tested on 2-gigabit inputs [[1]](https://doi.org/10.1103/PhysRevLett.112.040502) |
| **Guan et al. (Channel Multiplexing)** | 2021 | WDM + simultaneous detection | Efficient experimental QF with channel multiplexing; improved practical rates [[1]](https://www.nature.com/articles/s41467-021-24745-x) |
| **Kumar-Sidhu (One-Way Advantage)** | 2019 | Single-photon | Experimental demonstration surpassing best classical one-way protocol [[1]](https://www.nature.com/articles/s41467-019-12139-z) |

**State of the art:** Experimentally demonstrated with exponential advantage over classical protocols on multi-gigabit inputs. Coherent-state implementations (Arrazola-Lutkenhaus 2014) make the protocol practical with standard telecom equipment. One of the clearest demonstrations of quantum advantage in communication complexity.

**Production readiness:** Experimental
Experimentally demonstrated with exponential advantage on multi-gigabit inputs (2015, 2021). Coherent-state implementations use standard telecom equipment. No commercial products.

**Implementations:**
- [Qiskit (IBM)](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, quantum fingerprinting protocol simulation

**Security status:** Secure
Provable exponential quantum advantage in communication complexity. No security vulnerabilities; the advantage is information-theoretic.

**Community acceptance:** Niche
Published in Physical Review Letters and Nature Communications. One of the clearest demonstrations of quantum communication advantage. Limited commercial interest due to specialized use case.

---
