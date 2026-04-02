# Multi-Party Computation


<!-- TOC -->
## Contents (57 schemes)

**[Foundational MPC Protocols](#foundational-mpc-protocols)**
- [Multi-Party Computation (MPC)](#multi-party-computation-mpc)
- [Oblivious Transfer (OT)](#oblivious-transfer-ot)
- [Garbled Circuits (expanded)](#garbled-circuits-expanded)
- [Homomorphic Secret Sharing (HSS)](#homomorphic-secret-sharing-hss)
- [Oblivious Linear Evaluation (OLE) / VOLE](#oblivious-linear-evaluation-ole--vole)
- [Silent OT / Pseudorandom Correlation Generators (PCG)](#silent-ot--pseudorandom-correlation-generators-pcg)
- [Covert Security / Publicly Auditable MPC](#covert-security--publicly-auditable-mpc)
- [Asynchronous BFT / Asynchronous MPC](#asynchronous-bft--asynchronous-mpc)
- [Fluid MPC (Dynamic Participants)](#fluid-mpc-dynamic-participants)
- [YOSO Model (You Only Speak Once)](#yoso-model-you-only-speak-once)
- [Secret-Shared Shuffle](#secret-shared-shuffle)
- [Garbled RAM](#garbled-ram)
- [Streaming / Online Secure Computation](#streaming--online-secure-computation)
- [BMR Protocol (Constant-Round MPC)](#bmr-protocol-constant-round-mpc)
- [MASCOT (Malicious Arithmetic MPC via OT)](#mascot-malicious-arithmetic-mpc-via-ot)
- [SecureML and MPC-Based Machine Learning Inference](#secureml-and-mpc-based-machine-learning-inference)
- [Sharemind (MPC Platform)](#sharemind-mpc-platform)
- [SCALE-MAMBA (MPC Framework)](#scale-mamba-mpc-framework)
- [Carbyne Stack (Cloud-Native MPC)](#carbyne-stack-cloud-native-mpc)
- [SuperPack (Dishonest Majority MPC with Constant Online Communication)](#superpack-dishonest-majority-mpc-with-constant-online-communication)
- [EMP Toolkit (Efficient Multi-Party Computation Library)](#emp-toolkit-efficient-multi-party-computation-library)
- [Fair MPC (Fairness via Gradual Release)](#fair-mpc-fairness-via-gradual-release)
- [Robust MPC with Cheater Identification](#robust-mpc-with-cheater-identification)
- [Lattice-Based MPC](#lattice-based-mpc)
- [GMW Protocol (Goldreich-Micali-Wigderson)](#gmw-protocol-goldreich-micali-wigderson)
- [Honest Majority vs Dishonest Majority MPC (Security Models)](#honest-majority-vs-dishonest-majority-mpc-security-models)
- [Oblivious Linear Algebra (Secure Matrix Operations)](#oblivious-linear-algebra-secure-matrix-operations)
- [MPC for E-Voting (Helios, Belenios, Civitas)](#mpc-for-e-voting-helios-belenios-civitas)
- [MPC for Collaborative Fraud Detection (Privacy-Preserving ML Fraud)](#mpc-for-collaborative-fraud-detection-privacy-preserving-ml-fraud)
- [Asynchronous MPC (Ben-Or-Kelmer-Rabin, Canetti-Rabin)](#asynchronous-mpc-ben-or-kelmer-rabin-canetti-rabin)
- [Replicated Secret Sharing MPC (Araki et al.)](#replicated-secret-sharing-mpc-araki-et-al)
- [MPC-in-the-Head (IKOS Paradigm)](#mpc-in-the-head-ikos-paradigm)
- [Fantastic Four / SWIFT (Small-Party Honest-Majority MPC)](#fantastic-four--swift-small-party-honest-majority-mpc)
- [MPC-Friendly Symmetric Primitives (LowMC, MiMC)](#mpc-friendly-symmetric-primitives-lowmc-mimc)
- [Conclave (MPC for Relational Analytics on Big Data)](#conclave-mpc-for-relational-analytics-on-big-data)
- [Multipars / MHz2k (Efficient MPC Preprocessing over Rings)](#multipars--mhz2k-efficient-mpc-preprocessing-over-rings)
- [CGGMP21 (UC Threshold ECDSA with Identifiable Aborts)](#cggmp21-uc-threshold-ecdsa-with-identifiable-aborts)
- [SPDZ Protocol Family (Speedz)](#spdz-protocol-family-speedz)
- [ABY / ABY3 (Mixed-Protocol MPC Framework)](#aby--aby3-mixed-protocol-mpc-framework)
- [BMR Protocol (Constant-Round Multi-Party Garbled Circuits)](#bmr-protocol-constant-round-multi-party-garbled-circuits)
- [Sharemind (Practical 3-Party MPC Platform)](#sharemind-practical-3-party-mpc-platform)

**[Oblivious Transfer and Extensions](#oblivious-transfer-and-extensions)**
- [TinyOT (Maliciously Secure 2PC from OT)](#tinyot-maliciously-secure-2pc-from-ot)

**[Garbled Circuits](#garbled-circuits)**
- [Cut-and-Choose for Garbled Circuits (Malicious 2PC)](#cut-and-choose-for-garbled-circuits-malicious-2pc)
- [Two-Party PSI from Garbled Circuits (Pinkas et al.)](#two-party-psi-from-garbled-circuits-pinkas-et-al)
- [Obliv-C (Language for Data-Oblivious Computation)](#obliv-c-language-for-data-oblivious-computation)

**[Function Secret Sharing and DPF](#function-secret-sharing-and-dpf)**
- [Function Secret Sharing (FSS) / Distributed Point Functions (DPF)](#function-secret-sharing-fss--distributed-point-functions-dpf)
- [Distributed PRF (DPRF)](#distributed-prf-dprf)

**[OLE, VOLE, and Correlations](#ole-vole-and-correlations)**
- [TinyOT (OT-Based Actively Secure 2PC)](#tinyot-ot-based-actively-secure-2pc)

**[Secure Aggregation and Applications](#secure-aggregation-and-applications)**
- [Secure Aggregation (SecAgg)](#secure-aggregation-secagg)
- [Mental Poker / Commutative Encryption](#mental-poker--commutative-encryption)
- [ARIANN and SecureNN (Private Neural Network Inference)](#ariann-and-securenn-private-neural-network-inference)
- [Delphi (Cryptographic Private Inference Service)](#delphi-cryptographic-private-inference-service)
- [Beaver Triples (Multiplication Triples)](#beaver-triples-multiplication-triples)
- [Efficient Two-Party ECDSA (DKLS18 / Doerner et al.)](#efficient-two-party-ecdsa-dkls18--doerner-et-al)
- [Secure Computation on Graphs (Private Graph Algorithms)](#secure-computation-on-graphs-private-graph-algorithms)
- [Private Decision Trees and Random Forests (Bost et al., ABY3)](#private-decision-trees-and-random-forests-bost-et-al-aby3)
- [SecretFlow](#secretflow)

<!-- /TOC -->

## Foundational MPC Protocols

---
### Multi-Party Computation (MPC)

**Goal:** Multiple parties jointly compute a function over their private inputs without revealing anything except the output. Provides privacy + correctness.

| Protocol | Year | Model | Note |
|----------|------|-------|------|
| **GMW** | 1987 | Semi-honest, Boolean | Gate-by-gate OT-based; foundational [[1]](https://dl.acm.org/doi/10.1145/28395.28420) |
| **BGW** | 1988 | Info.-theoretic, honest majority | No crypto assumptions if ≥2/3 honest [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **SPDZ / SPDZ2k** | 2012 | Malicious, dishonest majority | Preprocessing + MAC-based online phase [[1]](https://eprint.iacr.org/2011/535) |
| **ABY / ABY3** | 2015 | Mixed: Arithmetic, Boolean, Yao | Efficient conversions between share types [[1]](https://eprint.iacr.org/2018/403) |
| **Garbled Circuits (Yao)** | 1986 | 2PC, semi-honest | Constant-round; optimized with free-XOR, half-gates [[1]](https://eprint.iacr.org/2014/756) |
| **MP-SPDZ** | 2020 | Framework | Implements 30+ MPC protocols [[1]](https://eprint.iacr.org/2020/521) |

**State of the art:** SPDZ2k (dishonest majority), ABY3 (3-party ML), Silent-OT-based 2PC.

**Production readiness:** Production
Deployed in production via MP-SPDZ, SCALE-MAMBA, Sharemind, and Carbyne Stack across finance, healthcare, and government.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, implements 30+ MPC protocols including SPDZ, SPDZ2k, ABY3, and replicated SS
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, actively secure SPDZ with MAMBA scripting language
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, mixed Arithmetic/Boolean/Yao 2PC framework
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, GMW and BMR with mixed-protocol support

**Security status:** Secure
SPDZ and ABY3 have rigorous security proofs under standard assumptions; parameter choices are well-understood.

**Community acceptance:** Widely trusted
Foundational protocols (GMW, BGW, SPDZ) are cornerstones of the MPC field with decades of peer review and real-world deployment.

---

### Oblivious Transfer (OT)

**Goal:** Sender has multiple messages; receiver picks one and learns only that one — sender doesn't learn which was chosen. Foundational for MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **1-out-of-2 OT (Naor-Pinkas)** | 2001 | DDH | Efficient base OT [[1]](https://dl.acm.org/doi/10.5555/365411.365502) |
| **OT Extension (IKNP)** | 2003 | Symmetric crypto | Extend few base OTs into millions cheaply [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45146-4_9) |
| **Silent OT (Boyle et al.)** | 2019 | PCG | Sublinear communication using pseudorandom correlation generators [[1]](https://eprint.iacr.org/2019/1159) |
| **Simplest OT (Chou-Orlandi)** | 2015 | ECDH | 1 round, 1 exponentiation; practical [[1]](https://eprint.iacr.org/2015/267) |
| **SoftSpokenOT** | 2022 | OT extension | Optimized [[1]](https://eprint.iacr.org/2022/192) |
| **Conditional OT / Priced OT (Aiello-Ishai-Reingold)** | 2001 | HE + predicate | Transfer executes only if predicate Q(x,y) is true; priced variant enables pay-per-item digital commerce [[1]](https://link.springer.com/chapter/10.1007/3-540-44987-6_8) |

**State of the art:** Silent OT extension (minimal communication), SoftSpokenOT.

**Production readiness:** Production
OT extension is deployed in all major MPC frameworks (EMP, MP-SPDZ, MOTION) and is the primary communication primitive for 2PC/MPC.

**Implementations:**
- [emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, optimized IKNP and SoftSpokenOT with hardware AES
- [libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, comprehensive OT library (base OT, IKNP, Silent OT, SoftSpokenOT)
- [MP-SPDZ OT](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, integrated OT extension for all MP-SPDZ protocols

**Security status:** Secure
Base OT security relies on well-studied assumptions (DDH, ECDH); OT extension adds only symmetric-key assumptions.

**Community acceptance:** Standard
OT is a universally accepted foundational primitive; IKNP extension is a standard building block in all modern MPC systems.

---

### Garbled Circuits (expanded)

*Note: already a row in MPC section, but deserves own section for the optimization techniques.*

**Goal:** Secure 2-party computation in constant rounds. One party "garbles" a Boolean circuit (encrypts gate-by-gate); the other evaluates it on their input without learning the circuit's intermediate values.

| Technique | Year | Basis | Note |
|-----------|------|-------|------|
| **Yao's Garbled Circuit** | 1986 | Symmetric encryption | Original construction; each gate = 4 ciphertexts [[1]](https://ieeexplore.ieee.org/document/4568207) |
| **Point-and-Permute** | 1990 | Pointer bit | Reduce evaluation to 1 decryption per gate [[1]](https://dl.acm.org/doi/10.1145/100216.100287) |
| **Free-XOR** | 2008 | Global offset Δ | XOR gates cost zero garbling/evaluation [[1]](https://eprint.iacr.org/2008/096) |
| **Half-Gates** | 2015 | Two half-garbled gates | AND gates cost 2 ciphertexts instead of 4 (optimal) [[1]](https://eprint.iacr.org/2014/756) |
| **Stacked Garbling** | 2020 | Conditional branching | Garble only the taken branch; sublinear for branching programs [[1]](https://eprint.iacr.org/2020/973) |

**State of the art:** Half-Gates + Free-XOR (standard), Stacked Garbling (branching programs).

**Production readiness:** Production
Garbled circuits are deployed in production 2PC systems including EMP Toolkit, Obliv-C, and commercial private computation services.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit) — C++, high-performance garbled circuit evaluation with half-gates and free-XOR
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, Yao's garbled circuits as one of three sharing types
- [Obliv-C](https://github.com/samee/obliv-c) ⭐ 184 — C extension, compiles C programs to garbled circuits
- [Fancy Garbling](https://github.com/GaloisInc/swanky/tree/master/fancy-garbling) ⭐ 344 — Rust, garbled circuit library in Galois swanky suite

**Security status:** Secure
Half-gates achieve optimal 2-ciphertext AND gates with rigorous proofs; free-XOR is proven secure under circular correlation robustness.

**Community acceptance:** Widely trusted
Garbled circuits are the standard approach for constant-round 2PC; decades of optimization and deployment.

---

### Homomorphic Secret Sharing (HSS)

**Goal:** Non-interactive secure computation. Secret-share data and compute on shares locally (without interaction between servers), then reconstruct the result. Like MPC but without communication rounds during computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HSS for branching programs (BGI)** | 2016 | DDH / DCR | Evaluate branching programs on shares with no interaction [[1]](https://eprint.iacr.org/2015/084) |
| **HSS from LWE** | 2019 | LWE | Post-quantum HSS; more expressive function classes [[1]](https://eprint.iacr.org/2019/1318) |
| **HSS for NC1** | 2016 | Group actions | Evaluate any NC1 circuit on secret-shared data [[1]](https://eprint.iacr.org/2015/084) |

**State of the art:** DDH-based HSS (practical for simple functions), LWE-based (PQ, richer function classes).

**Production readiness:** Research
HSS remains primarily an academic construction; no production-quality implementations are widely deployed.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes experimental HSS-based protocols
- [HSS implementation (BGI)](https://github.com/schoppmp/distributed-vector-ole) ⭐ 31 — C++, distributed vector OLE related to HSS constructions

**Security status:** Secure
DDH-based HSS is secure under standard assumptions; LWE-based HSS provides post-quantum security.

**Community acceptance:** Niche
HSS is well-studied theoretically but has limited practical adoption; primarily of interest for non-interactive secure computation research.

---

### Oblivious Linear Evaluation (OLE) / VOLE

**Goal:** Arithmetic oblivious transfer. Sender holds (a, b), receiver holds x; receiver learns ax + b and nothing else, sender learns nothing. VOLE (Vector OLE) extends this to vectors. The arithmetic foundation of modern MPC over large fields.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gilboa OLE** | 1999 | OT extension | First efficient OLE from OT; basis of arithmetic MPC [[1]](https://doi.org/10.1007/3-540-48405-1_8) |
| **VOLE from LPN (Boyle et al.)** | 2019 | LPN + PCG | Generate massive VOLE correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **Wolverine** | 2021 | VOLE + ZK | ZK proofs from VOLE: efficient field arithmetic proofs [[1]](https://eprint.iacr.org/2020/925) |
| **QuickSilver** | 2021 | VOLE | Optimized VOLE-based ZK; practical for arithmetic circuits [[1]](https://eprint.iacr.org/2021/076) |

**State of the art:** PCG-based VOLE (Boyle et al. 2019+); foundation of SPDZ preprocessing (see [MPC](#multi-party-computation-mpc)) and VOLE-in-the-head ZK (see [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg)).

**Production readiness:** Experimental
VOLE is integrated into research frameworks (EMP-VOLE, MP-SPDZ) and used as a building block for VOLE-ZK proofs, but standalone deployment is limited.

**Implementations:**
- [emp-zk (EMP-VOLE)](https://github.com/emp-toolkit/emp-zk) ⭐ 106 — C++, VOLE-based zero-knowledge proofs (Wolverine, QuickSilver)
- [libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, includes VOLE generation via Silent OT
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, VOLE-based preprocessing for SPDZ protocols

**Security status:** Secure
VOLE security is based on well-studied LPN/LWE assumptions; PCG-based generation has rigorous security proofs.

**Community acceptance:** Emerging
VOLE is rapidly becoming the preferred correlation for modern MPC preprocessing and VOLE-in-the-head ZK proofs.

---

### Silent OT / Pseudorandom Correlation Generators (PCG)

**Goal:** Communication-efficient MPC setup. Generate enormous numbers of correlated random values (OT correlations, Beaver triples) from a short correlated seed — turning an O(n) communication task into O(n^ε) or O(polylog n).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Silent OT (BCGI+)** | 2019 | LPN | Generate millions of OT correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **PCG for Beaver Triples** | 2020 | Ring-LPN | Extend PCG to multiplication triples for general MPC [[1]](https://eprint.iacr.org/2020/924) |
| **Silver (Couteau et al.)** | 2021 | LDPC + LPN | Optimized Silent OT with quasi-linear computation [[1]](https://eprint.iacr.org/2021/1150) |
| **VOLE-in-the-head (Baum et al.)** | 2023 | VOLE + PCG | Use PCG-based VOLE for efficient ZK proofs [[1]](https://eprint.iacr.org/2023/996) |

**State of the art:** Silent OT / PCG (Boyle et al. 2019+); transformative for MPC (see [MPC](#multi-party-computation-mpc)) preprocessing — reduces communication by orders of magnitude.

**Production readiness:** Experimental
Silent OT is implemented in research libraries and integrated into MP-SPDZ; production deployment is beginning but not yet widespread.

**Implementations:**
- [libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, includes Silent OT (BCGI+) and Silver implementations
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, PCG-based preprocessing for SPDZ and SPDZ2k
- [emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, Silent OT support

**Security status:** Secure
Security relies on LPN and Ring-LPN assumptions, which are well-studied; concrete parameter selection is maturing.

**Community acceptance:** Emerging
PCG/Silent OT is recognized as transformative for MPC communication efficiency; active standardization and integration into major frameworks.

---

### Covert Security / Publicly Auditable MPC

**Goal:** Intermediate MPC security. Stronger than semi-honest (passive), weaker than full malicious. In covert security, cheating is detected with probability ε — a rational adversary won't cheat if the reputational cost of detection outweighs the benefit. Much cheaper than malicious security.

| Model | Year | Basis | Note |
|-------|------|-------|------|
| **Covert Security (Aumann-Lindell)** | 2007 | Cut-and-choose | Detect cheating with prob ε; 1/ε overhead instead of κ for malicious [[1]](https://eprint.iacr.org/2007/060) |
| **Publicly Auditable MPC (Baum et al.)** | 2014 | Commitments + audit trail | Any external party can verify correctness of MPC execution post-hoc [[1]](https://eprint.iacr.org/2014/075) |
| **Publicly Verifiable Covert (PVC)** | 2018 | Covert + public audit | Combine covert deterrence with public verifiability [[1]](https://eprint.iacr.org/2018/1108) |


**State of the art:** Publicly Verifiable Covert (PVC) security (2018) provides the best combination of efficiency and accountability. Covert security is best suited for settings where reputational damage deters cheating.

**Production readiness:** Research
Covert security and publicly auditable MPC remain primarily academic; no major production deployments exist.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes covert security protocol variants
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, supports covert security settings

**Security status:** Secure
Covert security provides well-defined detection guarantees (probability epsilon); publicly auditable MPC adds post-hoc verification.

**Community acceptance:** Niche
Covert security is well-understood theoretically but rarely chosen in practice — practitioners typically opt for either semi-honest or full malicious security.

---

### Asynchronous BFT / Asynchronous MPC

**Goal:** Consensus and computation without timing assumptions. Protocols that tolerate arbitrary message delays — no timeouts, no synchrony assumptions. Necessary for truly decentralized systems where network conditions are unpredictable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ben-Or-Canetti-Goldreich Async MPC** | 1993 | Information-theoretic | First async MPC; tolerates t < n/3 corruptions [[1]](https://doi.org/10.1145/167088.167109) |
| **HoneyBadgerBFT** | 2016 | Threshold encryption + ACS | First practical async BFT; uses threshold encryption for censorship resistance [[1]](https://eprint.iacr.org/2016/199) |
| **Dumbo** | 2020 | MVBA + ABA | Improved async BFT; better latency than HoneyBadger [[1]](https://eprint.iacr.org/2020/841) |
| **VABA (Validated Async BA)** | 2019 | Threshold sigs + MVBA | Async BA with external validity; basis of many async protocols [[1]](https://eprint.iacr.org/2019/1460) |
| **DAG-Rider** | 2021 | DAG + zero-message overhead | BFT from DAG structure; no extra consensus messages [[1]](https://eprint.iacr.org/2021/1362) |

**State of the art:** DAG-based BFT (DAG-Rider, Bullshark, Narwhal-Tusk); used in Aptos, Sui. Related to [MPC](#multi-party-computation-mpc), [Threshold Decryption](05-secret-sharing-threshold-cryptography.md#threshold-decryption).

**Production readiness:** Production
Async BFT protocols (DAG-Rider variants) are deployed in production blockchains including Aptos (Jolteon/Diem BFT) and Sui (Narwhal-Bullshark).

**Implementations:**
- [HoneyBadgerBFT](https://github.com/initc3/HoneyBadgerBFT-Python) ⭐ 143 — Python, reference implementation of async BFT
- [Narwhal-Tusk](https://github.com/MystenLabs/narwhal) ⭐ 179 [archived] — Rust, DAG-based mempool and consensus (Mysten Labs/Sui)
- [aptos-core](https://github.com/aptos-labs/aptos-core) ⭐ 6.4k — Rust, includes DAG-based consensus implementation

**Security status:** Secure
Async BFT protocols have rigorous proofs for t < n/3 Byzantine tolerance; DAG-based variants maintain these guarantees.

**Community acceptance:** Widely trusted
HoneyBadgerBFT and DAG-based successors are widely adopted in blockchain consensus; deployed in production L1 chains.

---

### Fluid MPC (Dynamic Participants)

**Goal:** MPC with join/leave. Parties can dynamically enter and exit the computation mid-protocol — without restarting. Each round may have a completely different set of participants. Linear communication complexity. Essential for decentralized, permissionless settings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Choudhuri-Goel-Green-Jain-Kaptchuk Fluid MPC** | 2021 | Secret sharing + handoff | First fluid MPC; parties hand off state to newcomers; CRYPTO 2021 [[1]](https://eprint.iacr.org/2020/754) |
| **Fluid MPC with Linear Communication** | 2023 | Packed SS + handoff | Optimal communication complexity; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/012) |

**State of the art:** Linear-communication Fluid MPC (2023); distinct from [Async MPC](#asynchronous-bft--asynchronous-mpc) (fixed parties, no timing) and standard [MPC](#multi-party-computation-mpc) (fixed parties, fixed protocol).

**Production readiness:** Research
Fluid MPC is a recent theoretical framework (CRYPTO 2021/2023); no production implementations exist yet.

**Implementations:**
- No production-quality open-source implementations available; the original papers provide proof-of-concept constructions.

**Security status:** Secure
Security proofs are rigorous under standard MPC assumptions; the dynamic participant model is well-formalized.

**Community acceptance:** Niche
Fluid MPC is recognized as an important theoretical advance for decentralized settings but has not yet seen practical adoption.

---

### YOSO Model (You Only Speak Once)

**Goal:** MPC where each party sends exactly one message, then goes permanently offline. No interaction, no rounds — each party contributes once and disappears. Enables committee-based protocols where committee members are selected anonymously and ephemeral.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gentry-Halevi-Magri-Nielsen-Yakoubov YOSO** | 2021 | Role-based MPC | First YOSO model; parties speak once then leave; CRYPTO 2021 [[1]](https://eprint.iacr.org/2021/210) |
| **YOLO YOSO (Cascudo-Gennaro-Ishai-Nevet)** | 2022 | YOSO + secret sharing | Fast encryption and SS in YOSO model; ASIACRYPT 2022 [[1]](https://eprint.iacr.org/2022/1279) |
| **PVSS over Class Groups for YOSO DKG** | 2024 | Class groups + PVSS | DKG in YOSO model using class group PVSS; EUROCRYPT 2024 [[1]](https://eprint.iacr.org/2023/1651) |

**State of the art:** YOSO + PVSS for blockchain committee DKG; distinct from [Fluid MPC](#fluid-mpc-dynamic-participants) (parties interact multiple times) and [Async MPC](#asynchronous-bft--asynchronous-mpc) (parties stay online).

**Production readiness:** Research
YOSO is a recent theoretical model (CRYPTO 2021); implementations are limited to academic prototypes.

**Implementations:**
- No production-quality open-source implementations available; academic prototypes exist for YOSO-DKG using class groups.

**Security status:** Secure
YOSO security is proven under standard assumptions; the single-message model provides strong security guarantees against adaptive adversaries.

**Community acceptance:** Niche
YOSO is an active research area with interest from the blockchain community for committee-based protocols, but practical deployment remains future work.

---

### Secret-Shared Shuffle

**Goal:** Jointly permute a secret-shared dataset so that neither party learns the permutation. A fundamental building block for anonymous communication, private analytics, and oblivious sorting — but as a standalone, optimized primitive (not general MPC).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Ghosh-Poburinnaya Shuffle** | 2020 | PRF + secret sharing | First sublinear-round secret-shared shuffle [[1]](https://eprint.iacr.org/2019/1340) |
| **Maliciously Secure Shuffle (NDSS 2024)** | 2024 | Correlation checks | Malicious security via lightweight checks; linear communication [[1]](https://www.ndss-symposium.org/wp-content/uploads/2024-21-paper.pdf) |
| **SLIDE** | 2025 | Shamir SS + unconditional | Uniform shuffle of Shamir shares; unconditional security under honest majority [[1]](https://eprint.iacr.org/2025/165) |

**State of the art:** SLIDE (2025) for unconditional security; maliciously secure shuffle (NDSS 2024) for two-party. Extends [Oblivious Sorting](#obliv-c-language-for-data-oblivious-computation) and [Mixnets](11-anonymity-credentials.md#mix-networks-mixnets).

**Production readiness:** Research
Secret-shared shuffle protocols are recent (2020-2025); implementations exist in research codebases but are not deployed at scale.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes secret-shared shuffle implementations
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, includes shuffle protocols for 3-party setting

**Security status:** Secure
Recent protocols (SLIDE 2025) achieve unconditional security under honest majority; malicious-secure variants have rigorous proofs.

**Community acceptance:** Emerging
Secret-shared shuffle is gaining attention as a key building block for private analytics and oblivious sorting.

---

### Garbled RAM

**Goal:** Efficient MPC for RAM programs. Extend garbled circuits to support random-access memory — instead of unrolling memory access into a massive circuit, emulate RAM with ORAM. Exponential improvement for memory-intensive computations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lu-Ostrovsky Garbled RAM** | 2013 | ORAM + GC | First garbled RAM; polylog overhead per memory access [[1]](https://eprint.iacr.org/2013/229) |
| **Garg-Lu-Ostrovsky-Scafuro** | 2015 | ORAM + succinct GC | Improved; sublinear garbled program size for RAM computations [[1]](https://eprint.iacr.org/2014/656) |
| **Heath-Kolesnikov RAM-MPC** | 2020 | Stacked garbling + RAM | Practical garbled RAM with stacked garbling optimizations [[1]](https://eprint.iacr.org/2020/973) |

**State of the art:** Heath-Kolesnikov (2020) for practical use; extends [Garbled Circuits](#garbled-circuits-expanded) and [ORAM](#oblivious-transfer-ot) into a unified MPC framework.

**Production readiness:** Research
Garbled RAM remains primarily theoretical with prototype implementations; not deployed in production systems.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit) — C++, includes research implementations related to garbled circuit + ORAM
- [Obliv-C FLORAM](https://github.com/samee/obliv-c) ⭐ 184 — C, practical ORAM in garbled circuit setting

**Security status:** Secure
Security follows from garbled circuit and ORAM security; polylogarithmic overhead per memory access is proven.

**Community acceptance:** Niche
Garbled RAM is well-studied theoretically but practical overhead remains high; stacked garbling (Heath-Kolesnikov) is the most practical variant.

---

### Streaming / Online Secure Computation

**Goal:** MPC on data streams. Compute on data that arrives continuously — parties cannot store the entire dataset. Single-pass or few-pass computation with sublinear memory. Distinct from standard [MPC](#multi-party-computation-mpc) which assumes all inputs available upfront.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Streaming MPC (Kol-Raz)** | 2008 | Communication complexity | First formal model: parties see stream of inputs, compute function with limited memory [[1]](https://doi.org/10.1145/1374376.1374438) |
| **PIFO (Private Information Flow for Online ML)** | 2022 | Secret sharing + streaming | Privacy-preserving online learning on streaming data via secret-shared updates [[1]](https://eprint.iacr.org/2022/1103) |
| **Streaming Verifiable Computation** | 2023 | Sumcheck + streaming | Verify computations on data streams with sublinear memory; extends [Sumcheck](04-zero-knowledge-proof-systems.md#sumcheck-protocol) [[1]](https://eprint.iacr.org/2023/1393) |

**State of the art:** Streaming VC (2023) for verification; PIFO for private online learning. Distinct from [Fluid MPC](#fluid-mpc-dynamic-participants) (dynamic parties) and [PSA](#secure-aggregation-secagg) (aggregation only).

**Production readiness:** Research
Streaming MPC and streaming verifiable computation are recent research topics with no production deployments.

**Implementations:**
- No production-quality open-source implementations available; research prototypes accompany the cited papers.

**Security status:** Secure
Streaming MPC models have formal security proofs; streaming VC builds on well-studied sumcheck protocols.

**Community acceptance:** Niche
Streaming secure computation is a recognized theoretical contribution but remains far from practical deployment.

---

### BMR Protocol (Constant-Round MPC)

**Goal:** Multiparty computation in a constant number of rounds, regardless of circuit depth. Beaver, Micali, and Rogaway (1990) generalize Yao's garbled circuits to n parties: parties collaboratively construct a garbled circuit using a round of MPC, then each party evaluates locally. Round complexity is O(1) rather than O(depth).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BMR (Beaver-Micali-Rogaway)** | 1990 | Garbled circuits + secret sharing | First constant-round n-party SFE; parties jointly garble then all evaluate locally [[1]](https://dl.acm.org/doi/10.1145/100216.100287) |
| **BMR + SPDZ preprocessing** | 2015 | BMR + SPDZ | Maliciously secure constant-round MPC; use SPDZ offline phase to generate authenticated BMR garbling [[1]](https://eprint.iacr.org/2015/523) |
| **MOTION (GMW + BMR framework)** | 2022 | BMR + GMW + OT | Production framework implementing BMR and GMW with mixed-protocol support; semi-honest n-party [[1]](https://eprint.iacr.org/2020/1137) |

**State of the art:** BMR + SPDZ (malicious, constant-round); MOTION for practical semi-honest deployment. The constant-round property matters for high-latency networks. Distinct from round-optimal but communication-heavy protocols like [BGW](#multi-party-computation-mpc) (O(depth) rounds).

**Production readiness:** Mature
BMR is implemented in MOTION and MP-SPDZ; used in research benchmarks and some production deployments for high-latency networks.

**Implementations:**
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, implements BMR with mixed-protocol support for n-party semi-honest
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, BMR protocol variants including BMR+SPDZ for malicious security
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, BMR with actively secure preprocessing

**Security status:** Secure
BMR with SPDZ preprocessing provides full malicious security; the original semi-honest construction is proven under standard assumptions.

**Community acceptance:** Widely trusted
BMR is a foundational constant-round MPC protocol with broad acceptance in the cryptographic community and practical MPC frameworks.

---

### MASCOT (Malicious Arithmetic MPC via OT)

**Goal:** Efficient maliciously secure arithmetic MPC in the preprocessing model without FHE. MASCOT (Keller-Orsini-Scholl, 2016) generates authenticated Beaver multiplication triples using OT extension — achieving malicious security for dishonest majority with only ~6× overhead over semi-honest, and outperforming prior SPDZ preprocessing by over 200×.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **MASCOT** | 2016 | OT extension + MACs | Malicious preprocessing for SPDZ over any field; replaces expensive FHE with OT; ACM CCS 2016 [[1]](https://eprint.iacr.org/2016/505) |
| **SPDZ2k** | 2018 | MASCOT variant | Extend MASCOT to rings ℤ/2^k — native integer arithmetic without field embedding [[1]](https://eprint.iacr.org/2018/482) |
| **Overdrive** | 2018 | LWE / FHE | Alternative SPDZ preprocessing using somewhat-HE; better amortized cost at large scale [[1]](https://eprint.iacr.org/2017/1230) |

**State of the art:** MASCOT for practical malicious preprocessing (standard choice in MP-SPDZ); Overdrive for large-batch FHE-based preprocessing. Directly feeds into [SPDZ](#multi-party-computation-mpc) online phase; see also [Beaver Triples](#beaver-triples-multiplication-triples).

**Production readiness:** Production
MASCOT is the default preprocessing method in MP-SPDZ and is deployed in production MPC systems for malicious-security workloads.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, reference MASCOT implementation with optimizations
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, MASCOT-compatible preprocessing
- [Carbyne Stack (Klyshko)](https://github.com/carbynestack/klyshko) ⭐ 4 — Java/Kotlin, cloud-native MASCOT triple generation

**Security status:** Secure
MASCOT provides full malicious security with rigorous proofs; 200x faster than original SPDZ FHE-based preprocessing.

**Community acceptance:** Widely trusted
MASCOT is the standard choice for OT-based malicious-secure preprocessing; widely benchmarked and deployed in academic and industrial MPC.

---

### SecureML and MPC-Based Machine Learning Inference

**Goal:** Train and evaluate machine learning models on private data held by multiple parties. SecureML (Mohassel-Zhang, 2017) introduced efficient 2PC protocols for linear regression, logistic regression, and neural network training using secret sharing and Beaver triples over fixed-point arithmetic — enabling ML without exposing training data.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **SecureML** | 2017 | 2PC + secret sharing | Privacy-preserving linear/logistic regression and NN training; MPC-friendly sigmoid/softmax; S&P 2017 [[1]](https://eprint.iacr.org/2017/396) |
| **ABY3** | 2018 | 3PC with honest majority | Three-party ML with fast conversions; supports training and inference at LAN speeds [[1]](https://eprint.iacr.org/2018/403) |
| **CrypTen (Facebook)** | 2020 | Secret sharing (SPDZ-like) | Open-source PyTorch-based framework for 2/3-party private inference and training [[1]](https://arxiv.org/abs/2109.00984) |
| **Piranha** | 2022 | GPU-accelerated 3PC | GPU-accelerated secure ML training under semi-honest 3PC; order-of-magnitude speedups [[1]](https://eprint.iacr.org/2022/892) |

**State of the art:** ABY3 / CrypTen for practical private inference; Piranha for GPU-accelerated training. MPC-based ML is an active area bridging [MPC](#multi-party-computation-mpc), [HE](#homomorphic-secret-sharing-hss), and zkML (see [Zero-Knowledge Proof Systems](04-zero-knowledge-proof-systems.md#zkml-zero-knowledge-machine-learning)).

**Production readiness:** Experimental
CrypTen and ABY3 have working implementations for private ML inference/training; production deployment is limited to specific use cases.

**Implementations:**
- [CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python/PyTorch, Facebook's MPC framework for private ML
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, 3-party ML inference and training
- [Piranha](https://github.com/ucbrise/piranha) ⭐ 104 — C++/CUDA, GPU-accelerated secure ML training
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, supports ML workloads across multiple MPC protocols

**Security status:** Secure
Protocols have rigorous security proofs; fixed-point arithmetic introduces small approximation errors but no security degradation.

**Community acceptance:** Emerging
MPC-based ML is an active research area with growing industry interest; CrypTen and ABY3 are widely cited and benchmarked.

---

### Sharemind (MPC Platform)

**Goal:** Practical, deployable MPC for real-world data analysis. Sharemind (Bogdanov-Laur-Willemson, ESORICS 2008) is a virtual-machine framework for privacy-preserving computation over additive 3-party secret sharing — three non-colluding servers jointly evaluate arbitrary programs written in the SecreC language without any server seeing individual input values. Designed from the start with engineering concerns (performance, ease of deployment) rather than only theoretical security.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Sharemind core** | 2008 | Additive 3-party SS | Semi-honest security; information-theoretically secure; custom bytecode VM; ESORICS 2008 [[1]](https://eprint.iacr.org/2008/289) |
| **SecreC language** | 2013 | Sharemind VM | High-level language for writing privacy-preserving programs; compiles to MPC bytecode [[1]](https://link.springer.com/article/10.1007/s10207-012-0177-2) |
| **Sharemind MPC (commercial)** | 2015+ | SPDZ / 3-party SS | Production platform (Cybernetica); deployed for national statistics, healthcare, tax data [[1]](https://sharemind.cyber.ee/sharemind-mpc/multi-party-computation/) |

**State of the art:** Sharemind is one of the longest-running deployed MPC platforms; used in Estonia for privacy-preserving national statistics (tax board, health data). Conceptually close to [MP-SPDZ](#multi-party-computation-mpc) but designed around a client/server model with a fixed 3-server topology. See also [SCALE-MAMBA](#scale-mamba-mpc-framework) and [Carbyne Stack](#carbyne-stack-cloud-native-mpc).

**Production readiness:** Production
Sharemind is commercially deployed by Cybernetica for Estonian government statistics, healthcare analytics, and enterprise data collaboration.

**Implementations:**
- [Sharemind MPC](https://sharemind.cyber.ee/) — Commercial platform by Cybernetica; 3-party additive secret sharing
- [SecreC](https://github.com/sharemind-sdk/secrec) ⭐ 6 — Domain-specific language for Sharemind programs
- [Sharemind SDK](https://github.com/sharemind-sdk) — Open-source components of the Sharemind development kit

**Security status:** Secure
Information-theoretically secure in the semi-honest model with 3 non-colluding servers; well-studied security properties.

**Community acceptance:** Widely trusted
Sharemind is one of the oldest and most trusted deployed MPC platforms; used in government-scale deployments in Estonia.

---

### SCALE-MAMBA (MPC Framework)

**Goal:** A unified, actively secure MPC framework supporting both dishonest-majority and honest-majority settings. SCALE-MAMBA (Smart, KU Leuven; successor to Bristol's SPDZ-2) integrates SPDZ-style preprocessing with a MAMBA high-level language (Python-like), supporting prime fields, binary fields, and rings. It combines linear secret-sharing-based (LSSS) MPC with garbled-circuit evaluation in a single protocol, allowing users to switch paradigms mid-computation for optimal performance.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **SCALE-MAMBA core** | 2018 | SPDZ + LSSS | Actively secure arithmetic MPC; dishonest and honest majority; MAMBA scripting language [[1]](https://nigelsmart.github.io/SCALE/) |
| **Zaphod (LSSS + GC in SCALE)** | 2019 | SCALE + half-gates | Combine LSSS and garbled circuits in one protocol; switch per gate type for efficiency; ePrint 2019/974 [[1]](https://eprint.iacr.org/2019/974) |
| **Actively Secure Setup for SPDZ** | 2019 | SCALE + threshold DKG | First actively secure distributed key generation for SPDZ preprocessing; ePrint 2019/1300 [[1]](https://eprint.iacr.org/2019/1300) |

**State of the art:** SCALE-MAMBA is widely used in academic MPC research (KU Leuven, Bristol); MP-SPDZ (data61) has largely taken over as the benchmark framework, but SCALE-MAMBA remains the reference for SPDZ with actively secure key setup. GitHub: [KULeuven-COSIC/SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA). Related to [MASCOT](#mascot-malicious-arithmetic-mpc-via-ot), [Overdrive](#mascot-malicious-arithmetic-mpc-via-ot), and [MP-SPDZ](#multi-party-computation-mpc).

**Production readiness:** Mature
SCALE-MAMBA is the reference academic MPC framework at KU Leuven; used extensively in research but less in production than MP-SPDZ.

**Implementations:**
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, full SPDZ framework with MAMBA scripting language
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, successor framework with broader protocol support

**Security status:** Secure
Actively secure with rigorous proofs for dishonest and honest majority settings; includes actively secure distributed key setup.

**Community acceptance:** Widely trusted
SCALE-MAMBA is a well-established academic framework; widely cited in MPC research as a reference implementation.

---

### Carbyne Stack (Cloud-Native MPC)

**Goal:** Deploy MPC as a cloud-native microservice. Carbyne Stack (Bosch Research, open-sourced 2021) wraps SPDZ-like MPC protocols in a Kubernetes/Knative/Istio stack — each MPC party runs as an independent cloud service, with correlated-randomness generation, secret storage, and serverless computation all exposed as REST/gRPC APIs. The goal is to make MPC accessible to organizations without in-house cryptography expertise.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Carbyne Stack platform** | 2021 | SPDZ2k + MP-SPDZ + Kubernetes | Open-source; Apache 2.0; 3-party SPDZ in cloud-native microservices; German IT Security Award 2022 [[1]](https://github.com/carbynestack/carbynestack) |
| **Klyshko (correlated randomness)** | 2022 | PCG / offline preprocessing | Kubernetes operator managing offline triple generation; decoupled from online compute [[1]](https://github.com/carbynestack/klyshko) |
| **Ephemeral (serverless compute)** | 2022 | MP-SPDZ + Knative | Serverless MPC functions; spin up secure compute on demand; scales with Knative autoscaling [[1]](https://github.com/carbynestack/ephemeral) |

**State of the art:** Carbyne Stack is the leading open-source cloud-native MPC deployment platform (Linux Foundation Europe member 2023); used by Bosch and partners for cross-organization data analysis. Distinct from [MP-SPDZ](#multi-party-computation-mpc) (protocol benchmark) and [Sharemind](#sharemind-mpc-platform) (fixed-server model) — Carbyne Stack targets elastic cloud deployments. See [SCALE-MAMBA](#scale-mamba-mpc-framework) for the underlying protocol lineage.

**Production readiness:** Experimental
Carbyne Stack is open-source and used by Bosch Research for cross-organization analytics; early-stage production deployment.

**Implementations:**
- [Carbyne Stack](https://github.com/carbynestack/carbynestack) ⭐ 91 — Java/Kotlin, cloud-native MPC platform on Kubernetes
- [Klyshko](https://github.com/carbynestack/klyshko) ⭐ 4 — Kotlin, correlated randomness generation operator
- [Ephemeral](https://github.com/carbynestack/ephemeral) ⭐ 13 — Go, serverless MPC compute on Knative

**Security status:** Secure
Inherits SPDZ2k security properties via MP-SPDZ backend; cloud deployment adds operational security considerations.

**Community acceptance:** Emerging
Carbyne Stack is a Linux Foundation Europe project (2023); growing adoption in the cloud-native MPC space.

---

### SuperPack (Dishonest Majority MPC with Constant Online Communication)

**Goal:** Reduce online communication in dishonest-majority MPC to a constant number of field elements per multiplication gate, independent of the number of parties. SuperPack (Escudero-Goyal-Polychroniadou-Song-Weng, EUROCRYPT 2023) combines packed secret sharing with ideas from honest-majority TurboPack to achieve, for the first time, O(1/ε) online communication per AND/multiplication gate in a dishonest-majority (up to 1−ε fraction of parties corrupt) actively secure setting — a factor ≥25× improvement over prior works.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SuperPack** | 2023 | Packed SS + dishonest majority | 6/ε field elements online per multiplication gate (circuit-dep. preprocessing); EUROCRYPT 2023 [[1]](https://eprint.iacr.org/2023/307) |
| **Sharing Transformation (CRYPTO 2022)** | 2022 | Packed SS + dishonest majority | Predecessor: share-conversion enables packed SS for dishonest majority; enables SuperPack [[1]](https://eprint.iacr.org/2022/831) |
| **TurboPack** | 2022 | Packed SS + honest majority | Inspiration for SuperPack; constant-communication honest-majority MPC; CCS 2022 [[1]](https://eprint.iacr.org/2022/1316) |

**State of the art:** SuperPack is the state of the art for communication-efficient dishonest-majority MPC as of 2023; closes the long-standing gap between honest- and dishonest-majority communication complexity. Complements [SPDZ / SPDZ2k](#multi-party-computation-mpc) (which have linear online communication per gate). Related to [Beaver Triples](#beaver-triples-multiplication-triples) and [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg) for preprocessing.

**Production readiness:** Research
SuperPack is a recent theoretical advance (EUROCRYPT 2023); no production implementations exist.

**Implementations:**
- No production-quality open-source implementations available; the paper provides theoretical constructions based on packed secret sharing.

**Security status:** Secure
Actively secure against dishonest majority with rigorous proofs; builds on well-studied packed secret sharing techniques.

**Community acceptance:** Emerging
SuperPack is recognized as a significant theoretical advance in communication-efficient MPC; awaits practical implementation and benchmarking.

---

### EMP Toolkit (Efficient Multi-Party Computation Library)

**Goal:** Provide a high-performance, research-grade library for implementing a wide range of MPC protocols. EMP (Wang-Ranellucci-Katz, CCS 2017) is a modular C++ toolkit covering oblivious transfer, garbled circuits, authenticated garbling, and VOLE-based protocols — designed so that protocol researchers can compose primitives and benchmark new constructions without building infrastructure from scratch.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **EMP-OT** | 2017 | OT extension (IKNP / SoftSpokenOT) | Highly optimized base OT and OT extension; hardware AES acceleration; CCS 2017 [[1]](https://github.com/emp-toolkit/emp-ot) |
| **EMP-AG2PC (Authenticated Garbling)** | 2017 | Authenticated garbling (WRK) | Maliciously secure 2PC with single garbled circuit; implements Wang-Ranellucci-Katz; CCS 2017 [[1]](https://eprint.iacr.org/2017/030) |
| **EMP-AGMPC** | 2018 | Authenticated garbling, n-party | Multi-party extension of EMP-AG2PC; constant-round malicious n-party SFE [[1]](https://eprint.iacr.org/2017/1104) |
| **EMP-VOLE / EMP-ZK** | 2021 | VOLE + IT-MACs | VOLE-based zero-knowledge proofs; Wolverine and QuickSilver implemented [[1]](https://eprint.iacr.org/2020/925) |

**State of the art:** EMP Toolkit is one of the most widely benchmarked MPC libraries in academic research — used as a reference implementation for garbled circuits, authenticated garbling, and VOLE-ZK. GitHub: [emp-toolkit](https://github.com/emp-toolkit). Complements [MP-SPDZ](#multi-party-computation-mpc) (broader protocol coverage) and [MOTION](#bmr-protocol-constant-round-mpc) (GMW/BMR focus). See [Garbled Circuits](#garbled-circuits-expanded), [OLE / VOLE](#oblivious-linear-evaluation-ole--vole).

**Production readiness:** Mature
EMP is one of the most widely used MPC research libraries; production-grade code quality but primarily used in academic benchmarking.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit) — C++, modular MPC library suite
- [emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, optimized OT extension
- [emp-ag2pc](https://github.com/emp-toolkit/emp-ag2pc) ⭐ 33 — C++, authenticated garbling 2PC
- [emp-zk](https://github.com/emp-toolkit/emp-zk) ⭐ 106 — C++, VOLE-based zero-knowledge

**Security status:** Secure
Implements well-studied protocols (WRK authenticated garbling, IKNP OT, Wolverine/QuickSilver) with rigorous security proofs.

**Community acceptance:** Widely trusted
EMP is the standard benchmarking library for garbled circuits and VOLE-ZK in academic MPC research.

---

### Fair MPC (Fairness via Gradual Release)

**Goal:** Ensure that either all parties learn the output or none do — no party can abort after seeing the output while others remain in the dark. Standard MPC (GMW, SPDZ) achieves security-with-abort but not fairness. Fairness requires either an honest majority, a trusted third party, or cryptographic "gradual release" techniques that tie output delivery to an economic or time-based commitment.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cleve's Impossibility** | 1986 | Coin-flipping lower bound | Fair coin tossing is impossible between two parties without a trusted party [[1]](https://dl.acm.org/doi/10.1145/12130.12168) |
| **Gradual Release (Boneh-Naor)** | 2000 | Time-lock puzzles | Encode the output in a time-lock puzzle; release key bits gradually so abort advantage diminishes with time [[1]](https://link.springer.com/chapter/10.1007/3-540-44598-6_31) |
| **Cryptographic Fairness via Bitcoin** | 2014 | Blockchain + MPC | Use smart contracts as escrow to penalize early-aborting parties; first practical fair 2PC [[1]](https://eprint.iacr.org/2014/129) |
| **Fairness with Penalties (Bentov-Kumaresan)** | 2014 | Bitcoin scripts | Extend blockchain-based fairness to multi-party setting with financial penalties [[1]](https://eprint.iacr.org/2014/687) |
| **Optimistic Fair Exchange in MPC** | 2019 | Adaptor signatures + MPC | Use adaptor signatures for near-fair exchange without penalties in the happy path [[1]](https://eprint.iacr.org/2019/1184) |

**State of the art:** Blockchain-enforced fairness (Bentov-Kumaresan style) is the practical gold standard — used in atomic swaps and fair exchange protocols. Purely cryptographic fairness without penalties requires an honest majority. Related to [Fair Exchange / Atomic Swaps](13-blockchain-distributed-ledger.md#fair-exchange--atomic-swaps) and [Time-Lock Puzzles](09-commitments-verifiability.md#time-lock-puzzles--timed-release-encryption).

**Production readiness:** Experimental
Blockchain-enforced fairness is deployed in atomic swap protocols; purely cryptographic fairness via gradual release is rarely used in practice.

**Implementations:**
- [FairSwap](https://github.com/lEthDev/FairSwap) ⭐ 28 — Solidity, fair exchange via smart contracts

**Security status:** Secure
Gradual release provides provable fairness guarantees; blockchain-enforced fairness assumes rational adversaries and smart contract correctness.

**Community acceptance:** Niche
Fair MPC is well-studied theoretically; blockchain-based approaches are practical for atomic swaps but not widely used for general MPC.

---

### Robust MPC with Cheater Identification

**Goal:** MPC that does not merely abort when a cheater is detected — it identifies and expels the misbehaving party, then continues the computation with the remaining honest parties. Standard malicious-secure MPC achieves security-with-abort (computation stops when cheating is detected); robust MPC guarantees output delivery even under active attacks, provided cheaters can be identified and removed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BGW with Cheater Identification** | 1988 | Verifiable SS + error correction | BGW information-theoretic MPC with explicit cheater detection via Reed-Solomon error correction; requires t < n/3 [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **Beerliová-Trubíniová–Hirt Robust MPC** | 2006 | Packed SS + dispute control | Efficient robust MPC for t < n/3; parties maintain dispute sets; dishonest minority [[1]](https://eprint.iacr.org/2006/397) |
| **Identify-Then-Recover (Ishai-Ostrovsky-Zikas)** | 2012 | Secret sharing + broadcast | Generic compiler: lift any SS-based MPC to robust MPC by adding a broadcast-based identification round [[1]](https://eprint.iacr.org/2012/562) |
| **Full-Threshold Robust MPC** | 2019 | HE + dispute handling | Robust MPC tolerating up to t < n/2 corruptions in dishonest-majority setting; uses HE for reconstruction [[1]](https://eprint.iacr.org/2019/942) |

**State of the art:** Robust MPC with cheater identification is essential for long-running distributed computations (e.g., DKG ceremonies, threshold decryption services) where restarting is expensive. Beerliová-Trubíniová–Hirt and the Identify-Then-Recover compiler are standard references. Extends [BGW / Honest-Majority MPC](#multi-party-computation-mpc); related to [AVSS](05-secret-sharing-threshold-cryptography.md#asynchronous-verifiable-secret-sharing-avss) and [Asynchronous BFT](#asynchronous-bft--asynchronous-mpc).

**Production readiness:** Mature
Robust MPC techniques are used in DKG ceremonies and threshold decryption services where abort is unacceptable.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes robust MPC protocols with cheater identification
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, supports honest-majority robust protocols

**Security status:** Secure
Robust MPC with cheater identification has rigorous proofs for t < n/3 (IT) and t < n/2 (computational); dispute-control techniques are well-established.

**Community acceptance:** Widely trusted
Robust MPC is essential for long-running distributed protocols; the identify-then-recover paradigm is a standard reference.

---

### Lattice-Based MPC

**Goal:** Post-quantum secure multiparty computation whose hardness rests on lattice problems (LWE, RLWE) rather than Diffie-Hellman or factoring assumptions. Lattice-based MPC enables preprocessing-free or silent-OT-based protocols resilient to quantum adversaries, and connects naturally to FHE-based offline phases.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bendlin-Damgård-Orlandi-Zakarias (BDOZ)** | 2011 | LWE + IT-MACs | First LWE-based preprocessing for information-theoretically secure online phase; predecessor of SPDZ [[1]](https://eprint.iacr.org/2010/514) |
| **SPDZ from FHE (Damgård et al.)** | 2012 | BGV/BFV FHE | Generate SPDZ triples using FHE; post-quantum if instantiated with RLWE-based HE [[1]](https://eprint.iacr.org/2011/535) |
| **Overdrive (LWE preprocessing)** | 2018 | BFV/CKKS + ZK-proofs | Efficient triple generation for SPDZ using somewhat-HE; large-batch performance competitive with OT-based approaches [[1]](https://eprint.iacr.org/2017/1230) |
| **Lattice-Based Silent OT / PCG** | 2022 | RLWE + PCG | Post-quantum silent OT using ring-LWE; sublinear communication for OT correlations and Beaver triples [[1]](https://eprint.iacr.org/2022/1016) |
| **Degree-2 MPC from TFHE** | 2023 | TFHE + bootstrapping | Evaluate arbitrary Boolean/integer MPC using TFHE; removes preprocessing at the cost of FHE evaluation noise management [[1]](https://eprint.iacr.org/2023/815) |

**State of the art:** Overdrive (BFV-based) is the practical choice for large-batch lattice-based preprocessing in dishonest-majority MPC; post-quantum PCG (RLWE silent OT) is the research frontier for sublinear-communication PQ MPC. Related to [Homomorphic Encryption](07-homomorphic-functional-encryption.md#homomorphic-encryption-he), [MASCOT / Overdrive](#mascot-malicious-arithmetic-mpc-via-ot), and [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg).

**Production readiness:** Experimental
Lattice-based preprocessing (Overdrive) is implemented in MP-SPDZ and SCALE-MAMBA; post-quantum PCG is still research-stage.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes Overdrive (LWE-based) preprocessing for SPDZ
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, BGV/BFV-based triple generation
- [Lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k — Go, lattice-based cryptography library usable for MPC preprocessing

**Security status:** Secure
Security relies on well-studied LWE/RLWE assumptions; provides post-quantum security when appropriately parameterized.

**Community acceptance:** Emerging
Lattice-based MPC is an active research frontier; Overdrive is practically deployed but post-quantum PCG awaits broader adoption.

---

### GMW Protocol (Goldreich-Micali-Wigderson)

**Goal:** General-purpose MPC over Boolean (and arithmetic) circuits using oblivious transfer, tolerating any number of semi-honest corruptions among n parties. GMW (1987) reduces secure function evaluation to gate-by-gate secret-sharing with OT-based AND-gate evaluation — the first proof that any function can be securely computed in the semi-honest model without an honest majority. Later extended to malicious security via zero-knowledge proofs, giving the first general-purpose maliciously secure MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GMW (semi-honest, Boolean)** | 1987 | XOR secret sharing + OT | Gate-by-gate evaluation; AND gate requires 1-of-4 OT per party pair; O(depth) rounds; STOC 1987 [[1]](https://dl.acm.org/doi/10.1145/28395.28420) |
| **GMW (malicious, ZK compiler)** | 1987 | Semi-honest GMW + ZK | Upgrade any semi-honest protocol to malicious via commit-then-ZK-prove; exponential overhead in practice [[1]](https://dl.acm.org/doi/10.1145/28395.28420) |
| **GMW over arithmetic circuits** | 2000s | Additive secret sharing + OLE | Replace Boolean gates with arithmetic over fields; AND ↔ multiplication via OLE [[1]](https://eprint.iacr.org/2014/765) |
| **MOTION (GMW framework)** | 2022 | GMW + BMR + OT extension | Production C++ framework; implements both Boolean and arithmetic GMW with hardware-accelerated OT [[1]](https://eprint.iacr.org/2020/1137) |

**State of the art:** GMW is the foundational template for all secret-sharing-based MPC. In practice, semi-honest GMW is superseded by SPDZ (malicious, dishonest majority) and ABY3 (honest majority). The MOTION framework provides a modern production implementation. See [MPC overview](#multi-party-computation-mpc), [OLE / VOLE](#oblivious-linear-evaluation-ole--vole), and [BMR](#bmr-protocol-constant-round-mpc) (which applies GMW offline to enable constant rounds).

**Production readiness:** Mature
GMW is implemented in production frameworks (MOTION, ABY, MP-SPDZ); superseded by SPDZ/ABY3 for most practical deployments.

**Implementations:**
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, production GMW implementation with hardware-accelerated OT
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, GMW (Boolean) as one of three sharing types
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, semi-honest GMW and malicious variants

**Security status:** Secure
GMW is proven secure in the semi-honest model; the ZK compiler upgrade to malicious security is proven but impractical.

**Community acceptance:** Standard
GMW is a foundational MPC protocol taught in every cryptography course; the MOTION framework provides a modern reference implementation.

---

### Honest Majority vs Dishonest Majority MPC (Security Models)

**Goal:** Understand the fundamental trade-offs in MPC depending on the fraction of parties an adversary can corrupt. The corruption threshold determines what is achievable — information-theoretic vs computational security, whether output delivery is guaranteed (robustness) or only security-with-abort, and how expensive the protocol must be.

| Model | Corruption Bound | Representative Protocols | Key Trade-off |
|-------|-----------------|--------------------------|---------------|
| **Honest majority (t < n/2)** | Minority corrupted | BGW, Ben-Or et al., PRZS | Information-theoretic security; robust output delivery possible; requires n ≥ 2t+1 [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **Strict honest majority (t < n/3)** | < 1/3 corrupted | BGW (IT, robust), Beerliová-Trubíniová–Hirt | Robustness without FHE; error-correcting SS (Reed-Solomon); most efficient IT-MPC [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **Dishonest majority (t < n)** | All-but-one corrupted | GMW, SPDZ, MASCOT, DKLS | Requires computational assumptions; security-with-abort (not robust) without penalties [[1]](https://eprint.iacr.org/2011/535) |
| **Threshold = n−1 (2PC)** | One of two corrupted | Yao/GC, TinyOT, WRK, DKLS | Hardest case; no information-theoretic security; garbled circuits or OT-based [[1]](https://eprint.iacr.org/2014/756) |
| **Adaptive corruptions** | Adversary picks victims mid-protocol | Canetti-Feige-Goldreich-Naor | Parties can be corrupted after seeing messages; non-committing encryption required [[1]](https://dl.acm.org/doi/10.1145/226643.226686) |

**State of the art:** For honest majority: BGW / Replicated SS / ABY3 (practical). For dishonest majority: SPDZ / SPDZ2k (preprocessing + online). The honest-majority threshold enables information-theoretic security (no assumptions), while dishonest majority requires OT or FHE. Mixed-model frameworks like MP-SPDZ and ABY3 let practitioners choose per-deployment. See [MPC overview](#multi-party-computation-mpc), [BGW](#multi-party-computation-mpc), [SPDZ2k](#mascot-malicious-arithmetic-mpc-via-ot), and [Robust MPC](#robust-mpc-with-cheater-identification).

**Production readiness:** Production
Both models are deployed in production: honest-majority (ABY3, Sharemind) and dishonest-majority (SPDZ, MASCOT) across industry.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, supports both honest and dishonest majority protocols under one API
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, honest-majority 3PC
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, both security models

**Security status:** Secure
Both models have rigorous security definitions and proofs; the trade-offs between them are well-characterized.

**Community acceptance:** Standard
The honest/dishonest majority distinction is fundamental to MPC theory and practice; universally understood and applied.

---

### Oblivious Linear Algebra (Secure Matrix Operations)

**Goal:** Perform linear algebra — matrix multiplication, inversion, decomposition — on secret-shared or encrypted matrices, so that no party learns any entry of the input or intermediate matrices. A key building block for privacy-preserving machine learning (hidden-layer activations are matrix products), privacy-preserving statistics, and MPC-based genomics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Beaver-triple matrix multiplication** | 1991 | Arithmetic MPC + Beaver triples | Reduce secure matrix multiply to precomputed matrix Beaver triples; O(n²) triples for n×n matrices [[1]](https://dl.acm.org/doi/10.1145/103418.103444) |
| **MOTION matrix protocols** | 2022 | GMW + SIMD | Vectorized secret-shared matrix multiply using SIMD packing; hardware-AES-accelerated [[1]](https://eprint.iacr.org/2020/1137) |
| **HEAR (CKKS matrix multiply)** | 2021 | CKKS + HE | Homomorphic matrix multiplication using CKKS rotation encodings; 2-server MPC with HE offline [[1]](https://eprint.iacr.org/2021/1198) |
| **Pivot-Free Secure LU Decomposition** | 2013 | Arithmetic MPC + fixed-point | Oblivious LU factorization for secure linear systems; avoids data-dependent pivoting [[1]](https://link.springer.com/chapter/10.1007/978-3-642-36095-4_21) |
| **MOTION2NX (secure conv layers)** | 2023 | Arithmetic 2PC + SIMD | Efficient oblivious convolution for CNN inference; packs multiple matrix ops per round [[1]](https://eprint.iacr.org/2021/1113) |

**State of the art:** For honest-majority settings, replicated-SS matrix multiply (as in ABY3/Piranha) is fastest. For dishonest majority, CKKS-based offline + arithmetic online (Overdrive + CKKS) is the best-performing approach at scale. Oblivious matrix operations are the inner loop of private ML inference (see [SecureML and MPC-Based Machine Learning](#secureml-and-mpc-based-machine-learning-inference)) and private statistics. Related to [OLE / VOLE](#oblivious-linear-evaluation-ole--vole) and [Beaver Triples](#beaver-triples-multiplication-triples).

**Production readiness:** Experimental
Oblivious matrix operations are implemented in MOTION and used in private ML inference systems, but standalone deployment is limited.

**Implementations:**
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, SIMD-packed secret-shared matrix multiply
- [CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python/PyTorch, includes secure matrix operations for ML
- [Piranha](https://github.com/ucbrise/piranha) ⭐ 104 — C++/CUDA, GPU-accelerated secure matrix operations

**Security status:** Secure
Security follows from underlying MPC protocol security; fixed-point approximations introduce small numerical errors but no security loss.

**Community acceptance:** Emerging
Oblivious linear algebra is a key building block for private ML; growing adoption through CrypTen, Piranha, and ABY3.

---

### MPC for E-Voting (Helios, Belenios, Civitas)

**Goal:** Run a verifiable, privacy-preserving election without a single trusted tallier. MPC-based e-voting splits the tallying authority among multiple servers (trustees) using threshold encryption or secret sharing — no single server can decrypt individual ballots, and even a minority of corrupt servers cannot bias the result. Voters and observers can publicly verify that their vote was counted correctly without learning how others voted.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Helios** | 2008 | ElGamal threshold + ZK shuffles | First widely deployed web-based verifiable voting; voters encrypt ballots; trustees jointly decrypt tally via threshold decryption; USENIX Security 2008 [[1]](https://www.usenix.org/legacy/events/sec08/tech/full_papers/adida/adida.pdf) |
| **Civitas** | 2008 | Mix-nets + threshold decryption | Coercion-resistant e-voting; MPC-based registration and tallying; anonymous credential issuance via MPC; IEEE S&P 2008 [[1]](https://eprint.iacr.org/2008/136) |
| **Belenios** | 2013 | ElGamal threshold + homomorphic tally | Successor to Helios; trustees hold shares of the decryption key via Pedersen DKG; used in real French university elections [[1]](https://eprint.iacr.org/2013/177) |
| **DEMOS-2** | 2015 | Secret sharing + MPC tally | Fully coercion-resistant; distributes credential issuance and tallying using MPC with honest majority [[1]](https://eprint.iacr.org/2015/1069) |
| **Norwegian e-voting (Scytl/MPC)** | 2014 | Threshold decryption + mix-net | National-scale use of threshold MPC for tallying in Norwegian parliamentary elections; post-election audit [[1]](https://dl.acm.org/doi/10.1145/2660267.2660315) |

**State of the art:** Belenios is the most actively maintained and deployed academic system (France, Switzerland); Civitas pioneered coercion resistance via MPC. The dominant approach is homomorphic tally (fast but limited to simple tally functions) or MPC-based mix-net (supports ranked/approval voting). Related to [Threshold Decryption](05-secret-sharing-threshold-cryptography.md#threshold-decryption), [Mix-networks](11-anonymity-credentials.md#mix-networks-mixnets), [E-voting](20-applied-niche-protocols.md#coercion-resistant-voting--receipt-freeness), and [DKG](05-secret-sharing-threshold-cryptography.md#distributed-key-generation-dkg).

**Production readiness:** Production
Belenios is deployed in real elections (French universities, IACR elections); Helios has been used for organizational voting.

**Implementations:**
- [Helios](https://github.com/benadida/helios-server) ⭐ 888 — Python, web-based verifiable voting
- [Belenios](https://github.com/glondu/belenios) ⭐ 147 — OCaml, verifiable voting system with threshold decryption
- [Civitas](https://github.com/eastcoastcrypto/Civitas) ⭐ 13 — Java, coercion-resistant e-voting prototype

**Security status:** Caution
Voting systems are secure under their threat models but require careful operational deployment; coercion resistance remains challenging in practice.

**Community acceptance:** Widely trusted
Belenios and Helios are the standard academic e-voting systems; used in real elections with public verifiability.

---

### MPC for Collaborative Fraud Detection (Privacy-Preserving ML Fraud)

**Goal:** Multiple financial institutions jointly train or evaluate fraud detection models on their combined transaction data without sharing raw records. Each institution's data (account histories, transaction patterns) is sensitive and legally protected — but pooling it would dramatically improve fraud detection rates. MPC enables cross-institutional analysis while each party retains data sovereignty.

| System / Scheme | Year | Basis | Note |
|-----------------|------|-------|------|
| **Privacy-Preserving Fraud Detection (Bringer et al.)** | 2011 | HE + secret sharing | Bank-to-bank comparison of transaction fingerprints under FHE; first MPC fraud system [[1]](https://link.springer.com/chapter/10.1007/978-3-642-24209-0_12) |
| **Cape Privacy (now Tumult Labs)** | 2019 | Differential privacy + MPC | Platform for privacy-preserving data collaboration; used by financial institutions for fraud and AML analytics; combines MPC with DP output perturbation [[1]](https://github.com/capeprivacy) |
| **FATE (Federated AI Technology Enabler)** | 2019 | Federated learning + secret sharing + HE | WeBank's open-source FL platform; secure gradient aggregation for logistic regression and tree-based fraud models across banks [[1]](https://github.com/FederatedAI/FATE) |
| **Crypten cross-institution fraud** | 2021 | Secret sharing (SPDZ-like) | Demonstrated training fraud classifiers across two financial institutions using CrypTen; PyTorch-native [[1]](https://arxiv.org/abs/2109.00984) |
| **OpenMined PySyft** | 2018+ | Secret sharing + DP + FL | Open-source MPC+FL library used for privacy-preserving AML and credit scoring research across institutions [[1]](https://github.com/OpenMined/PySyft) |

**State of the art:** Production cross-institution fraud detection MPC is in early deployment — FATE and Cape/Tumult have real customers, but full MPC (not just FL + DP) for fraud remains expensive. The dominant practical approach combines federated learning for local model training with MPC only for secure aggregation, plus differential privacy for output protection. Related to [SecureML / MPC-based ML](#secureml-and-mpc-based-machine-learning-inference), [Secure Aggregation](#secure-aggregation-secagg), [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy), and [Carbyne Stack](#carbyne-stack-cloud-native-mpc).

**Production readiness:** Experimental
FATE and PySyft have real enterprise customers; full MPC-based fraud detection (vs FL+DP) is in early deployment.

**Implementations:**
- [FATE](https://github.com/FederatedAI/FATE) ⭐ 6.1k — Python, WeBank's federated AI platform with secure aggregation
- [PySyft](https://github.com/OpenMined/PySyft) ⭐ 9.9k — Python, MPC+FL library for privacy-preserving analytics
- [CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python, demonstrated cross-institution fraud classification

**Security status:** Secure
Underlying MPC/FL protocols are proven secure; DP output perturbation provides additional privacy guarantees.

**Community acceptance:** Emerging
Privacy-preserving fraud detection is an active industry application; FATE and PySyft have growing adoption in financial institutions.

---

### Asynchronous MPC (Ben-Or-Kelmer-Rabin, Canetti-Rabin)

**Goal:** Multiparty computation without synchrony assumptions. In the asynchronous model, messages can be arbitrarily delayed and the protocol cannot wait for slow parties — it must make progress whenever n − t messages arrive (where t is the corruption threshold). This is strictly harder than synchronous MPC: the adversary can selectively delay messages to control what each party "sees" first. Ben-Or-Kelmer-Rabin (1994) and Canetti-Rabin (1996) gave the first rigorous treatments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ben-Or-Kelmer-Rabin (BKR) Async MPC** | 1994 | Information-theoretic + async BA | First async MPC with t < n/4 tolerance; uses async Byzantine agreement (ABA) as a sub-protocol; PODC 1994 [[1]](https://dl.acm.org/doi/10.1145/164051.164083) |
| **Canetti-Rabin Async MPC** | 1996 | Verifiable SS + async BA | Improved to t < n/3; uses AVSS (asynchronous verifiable secret sharing) to handle late arrivals; STOC 1996 [[1]](https://dl.acm.org/doi/10.1145/237814.238015) |
| **Beerliová-Trubíniová–Hirt Async MPC** | 2010 | Packed SS + async BA | Efficient async MPC with optimal t < n/3; communication O(n²) per multiplication gate [[1]](https://eprint.iacr.org/2010/236) |
| **AMPR (Async MPC with Preprocessing)** | 2015 | Beaver triples + async online | Preprocessing model for async MPC; decouple triple generation (sync-friendly) from async online phase [[1]](https://eprint.iacr.org/2015/1064) |
| **Astra (async 3PC)** | 2019 | 3PC + async model | Practical 3-party async MPC for ML workloads; honest majority; CCS 2019 [[1]](https://eprint.iacr.org/2019/429) |

**State of the art:** Async MPC achieves t < n/3 (information-theoretic) and t < n/2 (with computational assumptions and security-with-abort). The gap between sync and async tolerance (n/3 vs n/2 for IT-MPC) is fundamental. Modern async MPC is used in distributed key generation ceremonies and DeFi threshold services that cannot rely on a synchronous clock. Distinct from [Asynchronous BFT](#asynchronous-bft--asynchronous-mpc) (consensus focus) — async MPC is about computing arbitrary functions, not just agreement. Related to [AVSS](05-secret-sharing-threshold-cryptography.md#asynchronous-verifiable-secret-sharing-avss) and [Robust MPC](#robust-mpc-with-cheater-identification).

**Production readiness:** Mature
Async MPC techniques are used in DKG ceremonies and DeFi threshold services; standalone async MPC frameworks are less common.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes async-compatible protocol variants
- [HoneyBadgerMPC](https://github.com/initc3/HoneyBadgerMPC) ⭐ 137 — Python, async MPC framework building on HoneyBadgerBFT

**Security status:** Secure
Async MPC achieves t < n/3 (IT) and t < n/2 (computational) with rigorous proofs; the async model is well-formalized.

**Community acceptance:** Widely trusted
Async MPC is fundamental to distributed systems that cannot assume synchrony; deployed in DeFi and DKG protocols.

---

### Replicated Secret Sharing MPC (Araki et al.)

**Goal:** Achieve extremely high-throughput three-party computation with an honest majority by exploiting replicated secret sharing, where each party holds two of three additive shares. AND gates require communicating only a single bit per gate per party, enabling billions of gates per second on commodity hardware.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Araki et al. (Semi-honest 3PC)** | 2016 | Replicated secret sharing | 1 bit communication per AND gate; 7 billion AND gates/s throughput; CCS 2016 [[1]](https://eprint.iacr.org/2016/768) |
| **Furukawa et al. (Malicious 3PC)** | 2017 | Replicated SS + cut-and-choose | Extend Araki to malicious security via post-execution verification; EUROCRYPT 2017 [[1]](https://eprint.iacr.org/2016/944) |
| **Replicated SS over Rings** | 2023 | Replicated SS + Z_{2^k} | Multi-party replicated secret sharing over rings for privacy-preserving ML; supports native integer arithmetic [[1]](https://www.acsu.buffalo.edu/~mblanton/publications/popets23-1.pdf) |

**State of the art:** Araki et al. remains the highest-throughput semi-honest 3PC protocol known; Furukawa et al. achieves malicious security with modest overhead. The replicated SS approach underpins practical frameworks like ABY3 and MP-SPDZ's replicated-sharing backends. Related to [ABY / ABY3](#multi-party-computation-mpc), [Sharemind](#sharemind-mpc-platform), and [Honest Majority MPC](#honest-majority-vs-dishonest-majority-mpc-security-models).

**Production readiness:** Production
Replicated SS 3PC is deployed in ABY3 and MP-SPDZ's replicated backends; used in privacy-preserving ML services.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, replicated secret sharing backends (semi-honest and malicious)
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, replicated SS for 3-party ML workloads
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, includes replicated SS protocols

**Security status:** Secure
Information-theoretically secure in the semi-honest model; Furukawa et al. achieves malicious security with post-execution verification.

**Community acceptance:** Widely trusted
Replicated SS 3PC is the fastest known semi-honest MPC protocol; widely adopted for honest-majority 3-party settings.

---

### MPC-in-the-Head (IKOS Paradigm)

**Goal:** Construct zero-knowledge proofs from any MPC protocol, treated as a black box. The prover simulates an MPC protocol "in their head" among virtual parties, commits to each party's view, and the verifier checks a random subset of views for consistency. Privacy of the MPC protocol guarantees zero-knowledge; soundness comes from the fact that cheating requires corrupting views that are likely to be checked.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IKOS (Ishai-Kushilevitz-Ostrovsky-Sahai)** | 2007 | Any semi-honest MPC | First MPC-in-the-head construction; transforms any t-private MPC into a ZK proof; STOC 2007 [[1]](https://web.cs.ucla.edu/~rafail/PUBLIC/77.pdf) |
| **KKW (Katz-Kolesnikov-Wang)** | 2018 | MPC-in-the-head + OT | Improved MPCitH with fewer parties and better concrete efficiency; CCS 2018 [[1]](https://eprint.iacr.org/2018/475) |
| **Syndrome Decoding in the Head (SDitH)** | 2022 | MPCitH + code-based crypto | Post-quantum signatures from MPCitH applied to syndrome decoding; NIST PQC candidate [[1]](https://eprint.iacr.org/2022/188) |
| **VOLEitH (Baum et al.)** | 2023 | VOLE + MPCitH | Replace MPC with VOLE correlations for more efficient ZK proofs; smaller proof sizes [[1]](https://eprint.iacr.org/2023/996) |

**State of the art:** MPCitH is the dominant paradigm for post-quantum ZK signatures (SDitH is a NIST PQC candidate); VOLEitH achieves the best concrete proof sizes for arithmetic relations. The paradigm bridges [MPC](#multi-party-computation-mpc) and [Zero-Knowledge Proof Systems](04-zero-knowledge-proof-systems.md#mpc-in-the-head-mpcith). Related to [VOLE](#oblivious-linear-evaluation-ole--vole) and [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg).

**Production readiness:** Experimental
MPCitH is used in the Picnic post-quantum signature scheme (NIST alternate candidate); SDitH is a NIST PQC candidate.

**Implementations:**
- [Picnic](https://github.com/microsoft/Picnic) ⭐ 168 — C, Microsoft's MPCitH-based post-quantum signature
- [SDitH](https://github.com/sdith/sdith) ⭐ 5 — C, Syndrome Decoding in the Head signature scheme

**Security status:** Secure
MPCitH has rigorous security reductions from MPC privacy to ZK soundness; SDitH security relies on well-studied code-based assumptions.

**Community acceptance:** Emerging
MPCitH is a recognized paradigm for post-quantum ZK; SDitH is under NIST PQC evaluation; VOLEitH is gaining traction for efficient proofs.

---

### Fantastic Four / SWIFT (Small-Party Honest-Majority MPC)

**Goal:** Practically efficient MPC for small fixed numbers of parties (3 or 4) with an honest majority and malicious security. These protocols exploit the specific structure of 3-party or 4-party settings to achieve much higher throughput than general n-party protocols, targeting privacy-preserving machine learning workloads.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SWIFT** | 2021 | 3PC + replicated SS | First robust and efficient PPML framework in 3PC with malicious security; guarantees output delivery; USENIX Security 2021 [[1]](https://eprint.iacr.org/2020/592) |
| **Fantastic Four (Dalskov et al.)** | 2021 | 4PC + replicated SS | Honest-majority 4PC with malicious security; simpler design than prior 4PC; no function-dependent preprocessing; USENIX Security 2021 [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/dalskov) |
| **Tetrad (Koti et al.)** | 2022 | 4PC + mixed sharing | Fast 4PC with fairness and guaranteed output delivery; optimized for ML inference; NDSS 2022 [[1]](https://eprint.iacr.org/2021/755) |
| **Secure 5PC** | 2024 | 5PC + private robustness | Five-party computation with minimal online communication and private robustness [[1]](https://link.springer.com/chapter/10.1007/978-981-96-0954-3_3) |

**State of the art:** SWIFT (3PC) and Fantastic Four (4PC) are the leading protocols for small-party honest-majority PPML, both implemented in MP-SPDZ. The 4-party setting is attractive because it allows malicious security with guaranteed output delivery while tolerating 1 corruption. Related to [ABY3](#multi-party-computation-mpc), [Replicated SS MPC](#replicated-secret-sharing-mpc-araki-et-al), and [SecureML](#secureml-and-mpc-based-machine-learning-inference).

**Production readiness:** Experimental
SWIFT and Fantastic Four are implemented in MP-SPDZ; used in PPML research benchmarks but not yet widely deployed in production.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes SWIFT (3PC) and Fantastic Four (4PC) protocols

**Security status:** Secure
Both protocols provide full malicious security with guaranteed output delivery under honest majority; rigorous proofs at USENIX Security 2021.

**Community acceptance:** Emerging
SWIFT and Fantastic Four are well-received in the PPML community; the 4-party model is gaining interest for its security/efficiency trade-off.

---

### MPC-Friendly Symmetric Primitives (LowMC, MiMC)

**Goal:** Design block ciphers and hash functions that minimize the number of non-linear (multiplicative) operations, since multiplications are the expensive bottleneck in MPC, FHE, and ZK proof systems. Standard ciphers like AES require hundreds of AND gates per block; MPC-friendly designs reduce this by 5-50x, enabling efficient hybrid protocols where data is encrypted locally and decrypted inside MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LowMC** | 2015 | Substitution-permutation network | Minimizes multiplicative depth and count; configurable AND-gate budget; up to 5x faster than AES in MPC [[1]](https://eprint.iacr.org/2016/687) |
| **MiMC** | 2016 | x^3 round function over F_p | Minimal multiplicative complexity over large fields; 1 multiplication per round; efficient for SNARK-based applications [[1]](https://eprint.iacr.org/2016/492) |
| **Rasta / HERA** | 2018 | Alternating moduli | Nonce-based encryption using alternating mod-2 and mod-3 operations; sublinear multiplicative complexity [[1]](https://eprint.iacr.org/2018/181) |
| **Ciminion** | 2021 | Toffoli gates + Farfalle-like | MPC/FHE-friendly with very low AND depth; designed for SPDZ-style protocols [[1]](https://eprint.iacr.org/2021/267) |

**State of the art:** LowMC is used in Picnic post-quantum signatures (NIST alternate candidate); MiMC is widely used in ZK-SNARK circuits. The design goal is to minimize the multiplicative depth (for round-complexity) and multiplicative count (for communication). Related to [Garbled Circuits](#garbled-circuits-expanded), [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg), and [ZK-Friendly Hash Functions](01-foundational-primitives.md#hash-functions).

**Production readiness:** Production
LowMC is used in Picnic (NIST PQC alternate candidate); MiMC and Poseidon are deployed in ZK-SNARK circuits on Ethereum and other blockchains.

**Implementations:**
- [Picnic](https://github.com/microsoft/Picnic) ⭐ 168 — C, uses LowMC as the underlying block cipher
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes MPC-friendly cipher evaluations
- [Ciminion reference](https://github.com/ongetekend/ciminion) ⭐ 5 — Sage, reference implementation of Ciminion

**Security status:** Caution
LowMC and MiMC have been subject to algebraic attacks; parameter recommendations have been updated. Newer designs (Ciminion) are less studied.

**Community acceptance:** Widely trusted
MPC-friendly ciphers are a recognized design category; LowMC (Picnic) and MiMC (ZK circuits) are widely deployed.

---

### Conclave (MPC for Relational Analytics on Big Data)

**Goal:** Scale MPC to big-data relational analytics by compiling SQL-like queries into a hybrid of local cleartext processing and small MPC steps. Rather than running the entire query inside MPC (which is prohibitively slow for large datasets), Conclave identifies which operations can be safely performed locally and pushes only the privacy-sensitive joins and aggregations into MPC, achieving orders-of-magnitude speedup.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Conclave (Volgushev et al.)** | 2019 | Hybrid cleartext + MPC compiler | Query compiler for multi-party relational analytics; 3-6 orders of magnitude faster than pure MPC; EuroSys 2019 [[1]](https://dl.acm.org/doi/10.1145/3302424.3303982) |
| **Senate** | 2021 | Malicious-secure MPC + SQL | Maliciously secure collaborative analytics platform for relational queries; tolerates n-1 corruptions [[1]](https://www.usenix.org/conference/osdi21/presentation/poddar) |
| **Secrecy** | 2022 | Secret sharing + relational algebra | MPC system for SQL with native relational operators (join, group-by, order-by) over secret-shared tables [[1]](https://dl.acm.org/doi/10.14778/3514061.3514066) |

**State of the art:** Conclave + Sharemind is deployed for real analytics; Senate provides malicious security for SQL. The key insight is that most data in a relational query can be processed locally — only the privacy-critical operations (joins across parties, aggregations revealing cross-party patterns) need MPC. Related to [Sharemind](#sharemind-mpc-platform), [Carbyne Stack](#carbyne-stack-cloud-native-mpc), and [Oblivious SQL](10-privacy-preserving-computation.md#oblivious-sql--encrypted-database-joins).

**Production readiness:** Experimental
Conclave has been demonstrated with Sharemind for real analytics; Senate and Secrecy are academic prototypes.

**Implementations:**
- [Conclave](https://github.com/multiparty/conclave) ⭐ 100 — Python, hybrid cleartext/MPC query compiler for relational analytics
- [Secrecy](https://github.com/multiparty/secrecy) ⭐ 0 — C, secret-shared relational algebra engine

**Security status:** Secure
Hybrid execution is proven secure: cleartext portions see only public data, MPC portions use standard secret sharing security.

**Community acceptance:** Niche
Conclave and Secrecy are well-cited in the MPC-for-analytics literature; the hybrid cleartext/MPC approach is gaining acceptance.

---

### Multipars / MHz2k (Efficient MPC Preprocessing over Rings)

**Goal:** Generate authenticated multiplication triples over rings Z_{2^k} (native machine integers) more efficiently than SPDZ2k/Overdrive2k, using improved packing techniques for lattice-based homomorphic encryption or lightweight linear HE. Operating over rings rather than prime fields avoids expensive modular reduction and matches the natural word size of CPUs, making MPC practical for integer-heavy workloads like ML inference.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Overdrive2k (Orsini-Smart-Vercauteren)** | 2020 | BGV + ring packing | First SHE-based preprocessing for SPDZ2k over Z_{2^k}; extends Overdrive packing to rings [[1]](https://link.springer.com/chapter/10.1007/978-3-030-40186-3_12) |
| **MHz2k** | 2021 | BGV + improved ZK packing | 3.5x better amortized communication than Overdrive2k; new packing and resharing techniques [[1]](https://eprint.iacr.org/2021/1383) |
| **Multipars** | 2024 | Linear HE + ring preprocessing | 11x faster than Overdrive2k; first actively secure N-party protocol over Z_{2^k} using only linear HE in offline phase; PoPETs 2024 [[1]](https://petsymposium.org/popets/2024/popets-2024-0038.pdf) |

**State of the art:** Multipars (2024) is the current state of the art for ring-based MPC preprocessing, outperforming all prior approaches by large margins. The progression from Overdrive2k to MHz2k to Multipars reflects a trend toward lighter cryptographic assumptions (linear HE instead of SHE) and better amortization. Related to [MASCOT / Overdrive](#mascot-malicious-arithmetic-mpc-via-ot), [SPDZ2k](#multi-party-computation-mpc), and [Lattice-Based MPC](#lattice-based-mpc).

**Production readiness:** Research
Multipars (2024) is a recent advance; MHz2k is implemented in research codebases but not deployed in production.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes ring-based preprocessing variants (Overdrive2k, SPDZ2k)
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, supports ring-based MPC protocols

**Security status:** Secure
Security builds on well-studied BGV/BFV lattice assumptions; ring operations preserve SPDZ2k security guarantees.

**Community acceptance:** Emerging
Ring-based preprocessing is recognized as important for practical ML workloads; Multipars advances the state of the art significantly.

---

### CGGMP21 (UC Threshold ECDSA with Identifiable Aborts)

**Goal:** Provide a universally composable (UC-secure), non-interactive threshold ECDSA protocol where misbehaving signers are publicly identifiable. CGGMP21 allows any t-of-n parties to produce a standard ECDSA signature — compatible with Bitcoin, Ethereum, and all existing ECDSA verifiers — while supporting proactive key refresh (periodic re-sharing of key material to limit the window of compromise) and presigning (message-independent preprocessing that makes the final signing round non-interactive).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CGGMP21 (Canetti-Gennaro-Goldfeder-Makriyannis-Peled)** | 2021 | Paillier + UC framework + presigning | UC-secure t-of-n threshold ECDSA; non-interactive signing via presigning; identifiable aborts; CCS 2020 / ePrint 2021 [[1]](https://eprint.iacr.org/2021/060) |
| **Doerner et al. 3-Round Threshold ECDSA** | 2023 | OT + multiplicative-to-additive | Reduce threshold ECDSA to 3 rounds; improves on CGGMP21 round complexity [[1]](https://eprint.iacr.org/2023/765) |
| **Synedrion (Entropy)** | 2023 | CGGMP21 implementation | Production Rust implementation of CGGMP21; audited; used in Entropy Network [[1]](https://github.com/entropyxyz/synedrion) |

**State of the art:** CGGMP21 is the dominant production protocol for threshold ECDSA in MPC wallets (Fireblocks MPC-CMP, ZenGo, Entropy); its presigning mechanism enables sub-second signing latency. Distinct from [DKLS18/GG20](#efficient-two-party-ecdsa-dkls18--doerner-et-al) (which covers the OT-based and earlier Paillier-based 2PC approaches). Related to [Threshold Signature Schemes](08-signatures-advanced.md#threshold-signature-schemes-tss) and [Key Management](03-key-exchange-key-management.md).

**Production readiness:** Production
CGGMP21 is deployed in production MPC wallets (Fireblocks MPC-CMP, ZenGo, Entropy Network) for cryptocurrency custody.

**Implementations:**
- [Synedrion](https://github.com/entropyxyz/synedrion) ⭐ 85 — Rust, audited CGGMP21 implementation (Entropy Network)
- [multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) ⭐ 1.1k — Rust, includes CGGMP21 (ZenGo)
- [tss-lib](https://github.com/bnb-chain/tss-lib) ⭐ 1.0k — Go, threshold ECDSA including CGGMP-style protocols

**Security status:** Secure
UC-secure with identifiable aborts; presigning mechanism is proven secure; implementations are professionally audited.

**Community acceptance:** Widely trusted
CGGMP21 is the industry standard for threshold ECDSA in MPC wallets; endorsed by major cryptocurrency custodians.

---

### SPDZ Protocol Family (Speedz)

**Goal:** Achieve actively secure MPC against a dishonest majority by separating an offline preprocessing phase (generating authenticated Beaver triples) from a fast, lightweight online phase that requires only field additions and multiplications.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SPDZ (Damgård-Pastro-Smart-Zakarias)** | 2012 | SHE (BGV) offline + MAC online | Foundational dishonest-majority MPC; online phase costs only a few field ops per gate; CRYPTO 2012 [[1]](https://eprint.iacr.org/2011/535) |
| **SPDZ2k (Cramer et al.)** | 2018 | Extends SPDZ to Z/2^k | Native 32/64-bit integer arithmetic; eliminates field conversion overhead for ML/comparison workloads; CRYPTO 2018 [[1]](https://eprint.iacr.org/2018/482) |
| **MASCOT (Keller-Orsini-Scholl)** | 2016 | OT-extension preprocessing | Replaces SPDZ's expensive SHE offline with OT-based triple generation, 200x faster; CCS 2016 [[1]](https://eprint.iacr.org/2016/505) |
| **Overdrive (Keller-Pastro-Rotaru)** | 2018 | Improved BGV packing | Better amortized SHE preprocessing for SPDZ; EUROCRYPT 2018 [[1]](https://eprint.iacr.org/2017/1230) |

**State of the art:** SPDZ is the industry-standard benchmark for dishonest-majority MPC. MASCOT made it practical on commodity hardware by removing the FHE dependency. SPDZ2k is the default for arithmetic-heavy privacy-preserving ML pipelines (native integer ops). The MP-SPDZ framework implements 30+ protocol variants under one API.

**Production readiness:** Production
SPDZ is the industry-standard MPC protocol family; deployed via MP-SPDZ, SCALE-MAMBA, and Carbyne Stack in production systems.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, reference implementation of 30+ SPDZ variants
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, actively secure SPDZ with MAMBA scripting
- [Carbyne Stack](https://github.com/carbynestack/carbynestack) ⭐ 91 — Java/Kotlin, cloud-native SPDZ2k deployment

**Security status:** Secure
SPDZ has rigorous active security proofs under standard assumptions; MAC-based online phase provides information-theoretic verification.

**Community acceptance:** Standard
SPDZ is the de facto standard for dishonest-majority MPC; universally referenced in MPC research and deployed in production.

---

### ABY / ABY3 (Mixed-Protocol MPC Framework)

**Goal:** Provide a unified framework for seamlessly switching between Arithmetic, Boolean (GMW), and Yao garbled circuit sharing types within a single protocol execution, enabling each sub-computation to use its most efficient representation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ABY (Demmler-Schneider-Zohner)** | 2015 | 2PC: A+B+Y share conversion | Formally analyzed share-conversion protocols; first mixed-protocol framework; NDSS 2015 [[1]](https://encrypto.de/papers/DSZ15.pdf) |
| **ABY3 (Mohassel-Rindal)** | 2018 | 3PC honest-majority: A+B+Y | Three-party ML inference/training; powers fastest known private neural network protocols; CCS 2018 [[1]](https://eprint.iacr.org/2018/403) |

**State of the art:** ABY3 is the standard reference framework for three-server ML workloads. No single sharing type is optimal for all operations — ABY's mixed approach avoids performance cliffs. Integrated into commercial privacy-preserving analytics products.

**Production readiness:** Production
ABY3 is deployed in privacy-preserving ML services and integrated into commercial analytics products.

**Implementations:**
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, mixed A/B/Y 2PC framework (TU Darmstadt)
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, 3-party mixed-protocol framework
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, implements ABY3 and related mixed-protocol variants

**Security status:** Secure
ABY has rigorous security proofs for share conversion protocols; ABY3 extends to honest-majority 3PC with well-studied guarantees.

**Community acceptance:** Widely trusted
ABY/ABY3 are standard references for mixed-protocol MPC; ABY3 is the leading framework for 3-party ML workloads.

---

### BMR Protocol (Constant-Round Multi-Party Garbled Circuits)

**Goal:** Enable constant-round MPC for any number of parties by having parties jointly generate a garbled circuit in the offline phase, so online evaluation requires only local work proportional to circuit size — independent of circuit depth.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BMR (Beaver-Micali-Rogaway)** | 1990 | Joint garbled circuit + OT | First constant-round n-party MPC; online evaluation independent of depth; STOC 1990 [[1]](https://dl.acm.org/doi/10.1145/100216.100287) |
| **BMR + SPDZ (Hazay-Scholl-Soria-Vazquez)** | 2017 | SPDZ authenticated preprocessing | First concretely efficient constant-round dishonest-majority protocol; CRYPTO 2017 [[1]](https://eprint.iacr.org/2015/523) |

**State of the art:** BMR breaks the depth barrier: deep circuits (recurrent networks, iterative algorithms) that are prohibitively slow in depth-linear protocols become practical. Essential for low-latency secure evaluation over WAN links.

**Production readiness:** Mature
BMR is implemented in MOTION and MP-SPDZ; used for constant-round MPC in high-latency network settings.

**Implementations:**
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, BMR with mixed-protocol support
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, BMR + SPDZ for malicious-secure constant-round MPC

**Security status:** Secure
BMR with SPDZ preprocessing provides malicious security; original protocol proven under standard assumptions.

**Community acceptance:** Widely trusted
BMR is the canonical constant-round MPC protocol; essential for applications requiring minimal round complexity over WAN.

---

### Sharemind (Practical 3-Party MPC Platform)

**Goal:** Provide a programmable three-party computation platform based on additive secret sharing over Z/2^32 with information-theoretic security in the honest-but-curious model, designed for real organizational data-sharing deployments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sharemind (Bogdanov-Laur-Willemson)** | 2008 | 3PC additive SS, Z/2^32 | Native 32-bit integer arithmetic; no public-key ops online; ESORICS 2008 [[1]](https://eprint.iacr.org/2008/289) |
| **Estonian Tax Study** | 2015 | Sharemind deployed | First large-scale government privacy-preserving analytics study [[1]](https://eprint.iacr.org/2015/1159) |

**State of the art:** Sharemind was among the first MPC systems deployed for real-world institutional data sharing (Estonian government tax/salary study). The honest-but-curious 3PC model is sufficient for many regulated settings where parties are legally accountable.

**Production readiness:** Production
Sharemind is commercially deployed by Cybernetica for Estonian government privacy-preserving statistics and healthcare analytics.

**Implementations:**
- [Sharemind MPC](https://sharemind.cyber.ee/) — Commercial platform by Cybernetica
- [Sharemind SDK](https://github.com/sharemind-sdk) — Open-source SDK components
- [SecreC](https://github.com/sharemind-sdk/secrec) ⭐ 6 — Domain-specific language for Sharemind

**Security status:** Secure
Information-theoretically secure in the honest-but-curious 3-party model with non-colluding servers.

**Community acceptance:** Widely trusted
Sharemind is a pioneering deployed MPC platform; used in the first large-scale government MPC deployment (Estonian tax study 2015).

---

---


## Oblivious Transfer and Extensions

---
### TinyOT (Maliciously Secure 2PC from OT)

**Goal:** Maliciously secure two-party computation over Boolean circuits using only symmetric-key primitives. TinyOT (Nielsen-Nordholt-Orlandi-Burra, CRYPTO 2012) departs entirely from Yao's garbled-circuit tradition: it uses correlated oblivious transfer (COT) to authenticate wire values with information-theoretic MACs, producing actively secure AND-triples in an offline phase and then evaluating the circuit gate-by-gate online. The result is the first OT-based (non-GC) protocol to beat garbled-circuit approaches in practice.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **TinyOT (NNOB)** | 2012 | OT extension + IT-MACs | Malicious 2PC via committed OT; 20 000+ AND gates/s in LAN; CRYPTO 2012 [[1]](https://eprint.iacr.org/2011/091) |
| **TinyKeys for TinyOT** | 2018 | TinyOT + packed MACs | Reduce MAC key length; scale to large circuits with active security; ASIACRYPT 2018 [[1]](https://link.springer.com/chapter/10.1007/978-3-030-03332-3_4) |
| **TinyTable** | 2017 | TinyOT + table garbling | Gate-scrambling variant; efficient for small look-up table gates; CRYPTO 2017 [[1]](https://eprint.iacr.org/2016/695) |

**State of the art:** TinyOT remains the canonical OT-based alternative to cut-and-choose for malicious 2PC; largely superseded for garbled-circuit workloads by [Authenticated Garbling (WRK)](#cut-and-choose-for-garbled-circuits-malicious-2pc), but still competitive for Boolean circuits in high-latency networks. Foundation of [MASCOT](#mascot-malicious-arithmetic-mpc-via-ot) and many MPC frameworks.

**Production readiness:** Mature
TinyOT is implemented in research frameworks and serves as the foundation for MASCOT; not typically deployed standalone.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, includes TinyOT-based protocols
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, TinyOT-inspired preprocessing
- [emp-toolkit](https://github.com/emp-toolkit) — C++, OT-MAC-based protocols descended from TinyOT

**Security status:** Secure
Full malicious security with information-theoretic MACs; rigorous proofs in the random oracle model.

**Community acceptance:** Widely trusted
TinyOT is a foundational protocol in the OT-based MPC lineage; its MAC-based approach is the standard for active security.

---


## Garbled Circuits

---
### Cut-and-Choose for Garbled Circuits (Malicious 2PC)

**Goal:** Achieve malicious security in Yao's garbled circuit framework without heavy generic techniques. One party garbles s circuits; the other checks roughly half of them (cut), and evaluates the rest (choose). Cheating requires all evaluated circuits to be malicious, giving soundness error ~2^{−s/2} or better with refined techniques.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lindell-Pinkas Cut-and-Choose** | 2007 | GC + commit-reveal | Seminal cut-and-choose 2PC; s circuits gives 2^{−0.32s} cheating probability [[1]](https://eprint.iacr.org/2007/557) |
| **Lindell Fast Cut-and-Choose** | 2013 | GC + forge-and-lose | Optimal s circuits for 2^{−s} soundness; single additional small MPC to "close the loop" [[1]](https://eprint.iacr.org/2013/079) |
| **Amortizing Garbled Circuits (HKK)** | 2015 | GC batching | Batch cut-and-choose across multiple executions; amortize the s-circuit overhead [[1]](https://eprint.iacr.org/2015/081) |
| **Authenticated Garbling (WRK)** | 2017 | GC + information-theoretic MACs | Replace cut-and-choose entirely with authenticated wires; single garbled circuit suffices; CCS 2017 [[1]](https://eprint.iacr.org/2017/030) |

**State of the art:** Authenticated garbling (WRK 2017) supersedes cut-and-choose for most uses — achieving malicious 2PC with one garbled circuit and no circuit duplication. Cut-and-choose remains relevant when the underlying primitive is most convenient. See [Garbled Circuits (expanded)](#garbled-circuits-expanded).

**Production readiness:** Mature
Cut-and-choose techniques are implemented in research frameworks; largely superseded by authenticated garbling (WRK) in new deployments.

**Implementations:**
- [emp-ag2pc](https://github.com/emp-toolkit/emp-ag2pc) ⭐ 33 — C++, implements authenticated garbling (WRK) which supersedes cut-and-choose
- [JustGarble](https://github.com/irdan/justGarble) ⭐ 15 — C, early garbled circuit implementation supporting cut-and-choose
- [Obliv-C](https://github.com/samee/obliv-c) ⭐ 184 — C, supports malicious-secure 2PC via cut-and-choose

**Security status:** Superseded
Cut-and-choose is technically secure but authenticated garbling (WRK 2017) achieves malicious 2PC more efficiently with a single garbled circuit.

**Community acceptance:** Widely trusted
Cut-and-choose is a well-established technique with decades of study; WRK authenticated garbling is now preferred for most applications.

---

### Two-Party PSI from Garbled Circuits (Pinkas et al.)

**Goal:** Private set intersection (PSI) via garbled circuits. Rather than number-theoretic PSI (DH-based or OPRf-based), garble a circuit that computes the intersection directly — achieving malicious security and circuit-PSI (where the output is secret-shared rather than revealed), with competitive performance even for unbalanced set sizes. Pinkas-Schneider-Zohner and follow-ons showed that GC-based PSI can be faster than cryptographic alternatives for certain parameter regimes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pinkas-Schneider-Zohner (PSZ) PSI** | 2014 | OT extension + garbled Bloom filter | Fastest practical PSI at the time; OT extension reduces communication; USENIX Security 2014 [[1]](https://eprint.iacr.org/2014/774) |
| **Pinkas-Schneider-Segev-Zohner (PSSZ)** | 2015 | OT + oblivious PRF | Semi-honest PSI using OPRF; 3-7× faster than PSZ; USENIX Security 2015 [[1]](https://eprint.iacr.org/2015/634) |
| **Circuit-PSI (Pinkas et al.)** | 2018 | GC + oblivious PRF | Output is secret-shared intersection — neither party sees the intersection in the clear; enables downstream MPC; CCS 2018 [[1]](https://eprint.iacr.org/2018/120) |
| **KKRT PSI** | 2016 | OT extension + Cuckoo hashing | Batched OPRF via OT extension + Cuckoo hashing; practical for millions of elements; CCS 2016 [[1]](https://eprint.iacr.org/2016/799) |
| **VOLE-PSI (RS21)** | 2021 | VOLE + OKVS | PSI from VOLE-based OPRF; near-linear communication; EUROCRYPT 2021 [[1]](https://eprint.iacr.org/2021/262) |

**State of the art:** VOLE-PSI (2021) and KKRT dominate for semi-honest PSI; circuit-PSI is the standard for composable intersection inside larger MPC pipelines. GC-based PSI remains relevant for unbalanced sizes (one set much smaller). Related to [PSI](10-privacy-preserving-computation.md#private-set-intersection-psi), [OPRF](10-privacy-preserving-computation.md#oblivious-prf-oprf), [OLE / VOLE](#oblivious-linear-evaluation-ole--vole), and [Garbled Circuits](#garbled-circuits-expanded).

**Production readiness:** Production
VOLE-PSI and KKRT are deployed in real-world PSI applications; circuit-PSI is used in production MPC pipelines.

**Implementations:**
- [VOLE-PSI](https://github.com/Visa-Research/volepsi) ⭐ 135 [archived] — C++, Visa Research's VOLE-based PSI implementation
- [libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, comprehensive PSI library (KKRT, OPRF-based, circuit-PSI)
- [emp-toolkit](https://github.com/emp-toolkit) — C++, garbled-circuit-based PSI
- [PSI (OpenMined)](https://github.com/OpenMined/PSI) ⭐ 151 — C++/Python, private set intersection library

**Security status:** Secure
Semi-honest PSI (KKRT, VOLE-PSI) and malicious variants have rigorous security proofs; concrete parameters are well-studied.

**Community acceptance:** Widely trusted
PSI is one of the most practically deployed MPC primitives; KKRT and VOLE-PSI are standard references.

---

### Obliv-C (Language for Data-Oblivious Computation)

**Goal:** Provide a programming language and compiler that makes it easy to write secure two-party computations without cryptographic expertise. Obliv-C extends C with an obliv type qualifier — variables marked obliv are automatically encrypted and all operations on them are compiled into garbled circuit gates. The type system ensures that secret data can never leak through control flow or memory access patterns.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Obliv-C (Zahur-Evans)** | 2015 | C extension + garbled circuits | Language-level obliv types; compiles to Yao's protocol; extensible to ORAM and custom protocols; ePrint 2015/1153 [[1]](https://eprint.iacr.org/2015/1153) |
| **FLORAM (Doerner-Shelat)** | 2017 | Obliv-C + function SS ORAM | Oblivious RAM built in Obliv-C using FSS; practical ORAM for MPC without expensive recursion [[1]](https://eprint.iacr.org/2017/827) |
| **ObliVM (Liu et al.)** | 2015 | Custom DSL + garbled circuits | Alternative MPC programming framework with automatic ORAM insertion for array accesses; IEEE S&P 2015 [[1]](https://eprint.iacr.org/2015/398) |

**State of the art:** Obliv-C and ObliVM pioneered the "MPC compiler" approach — write high-level code, get secure computation automatically. Obliv-C's type-system approach has influenced subsequent frameworks (EMP, ABY, MP-SPDZ front-ends). Related to [Garbled Circuits](#garbled-circuits-expanded), [EMP Toolkit](#emp-toolkit-efficient-multi-party-computation-library), and [ORAM](10-privacy-preserving-computation.md#oblivious-ram-oram).

**Production readiness:** Mature
Obliv-C is a well-maintained research tool used in numerous academic papers; production use is limited due to GC overhead.

**Implementations:**
- [Obliv-C](https://github.com/samee/obliv-c) ⭐ 184 — C extension, compiles annotated C to garbled circuits

**Security status:** Secure
The type system enforces that secret data cannot leak through control flow; compiled protocols inherit garbled circuit security.

**Community acceptance:** Widely trusted
Obliv-C pioneered the MPC compiler approach; influential in the design of subsequent frameworks (EMP, ABY front-ends).

---


## Function Secret Sharing and DPF

---
### Function Secret Sharing (FSS) / Distributed Point Functions (DPF)

**Goal:** Secret-share a function. Split a function f into shares f₀, f₁ such that each share reveals nothing, but f₀(x) + f₁(x) = f(x) for all x. Enables efficient PIR, anonymous messaging, private database queries with sublinear communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Distributed Point Function (GI14)** | 2014 | PRG tree | Secret-share a point function (1 at target, 0 elsewhere); O(λ log N) key size [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for intervals/comparison** | 2015 | DPF + prefix tree | Extend DPF to interval functions; private range queries [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for decision trees** | 2021 | DPF composition | Secret-share a decision tree for private inference [[1]](https://eprint.iacr.org/2020/1392) |

**State of the art:** DPF (used in Brave/STAR, Google Privacy Sandbox), FSS for intervals (private analytics).

**Production readiness:** Experimental
DPF is used in Brave's STAR protocol and Google's Privacy Sandbox for private analytics, but broader deployment is still emerging.

**Implementations:**
- [libfss](https://github.com/google/distributed_point_functions) ⭐ 79 — C++, Google's DPF library used in Privacy Sandbox

**Security status:** Secure
DPF security relies on standard PRG assumptions; well-studied with tight security reductions.

**Community acceptance:** Emerging
DPF is gaining traction in private analytics (Brave, Google); FSS for richer function classes remains primarily academic.

---

### Distributed PRF (DPRF)

**Goal:** Threshold PRF evaluation. t-of-n servers jointly evaluate a PRF on input x — no single server knows the PRF key, and fewer than t servers learn nothing about the output. Enables distributed key derivation and tokenization.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas-Reingold DPRF** | 1999 | DDH | First DPRF; threshold Naor-Reingold PRF [[1]](https://doi.org/10.1007/3-540-48910-X_16) |
| **Dodis-Yampolskiy DVRF/DPRF** | 2005 | Pairings | Verifiable DPRF; each server proves correct partial evaluation [[1]](https://eprint.iacr.org/2004/310) |
| **Threshold OPRF (TOPRF)** | 2020 | EC + threshold | Threshold + oblivious: client input hidden, key distributed [[1]](https://eprint.iacr.org/2017/363) |

**State of the art:** TOPRF for distributed password authentication (extends [OPRF](#oblivious-transfer-ot)); DPRF for distributed key management. Related to [PRF](#silent-ot--pseudorandom-correlation-generators-pcg).

**Production readiness:** Mature
DPRF and TOPRF are deployed in threshold password authentication systems and distributed key management services.

**Implementations:**
- [VOPRF (Cloudflare)](https://github.com/cloudflare/circl) ⭐ 1.6k — Go, includes OPRF/VOPRF/TOPRF in CIRCL library
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, DPRF protocol implementations

**Security status:** Secure
DDH-based DPRF and pairing-based DVRF have well-studied security reductions; TOPRF inherits OPRF security with threshold guarantees.

**Community acceptance:** Widely trusted
DPRF/TOPRF are established primitives with IETF standardization efforts (VOPRF RFC 9497) and broad cryptographic community trust.

---


## OLE, VOLE, and Correlations

---
### TinyOT (OT-Based Actively Secure 2PC)

**Goal:** Construct actively secure two-party computation over Boolean circuits using only OT as a primitive, via information-theoretically secure MACs, with an offline/online split far cheaper than cut-and-choose approaches.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **TinyOT (Nielsen-Nordholt-Orlandi-Burra)** | 2012 | OT + IT-MACs | ~6x overhead over semi-honest GMW; no cut-and-choose; CRYPTO 2012 [[1]](https://eprint.iacr.org/2011/091) |
| **MASCOT** | 2016 | Arithmetic analogue of TinyOT | Extends OT-MAC paradigm to arithmetic circuits; CCS 2016 [[1]](https://eprint.iacr.org/2016/505) |

**State of the art:** TinyOT demonstrated that OT-derived MACs provide full active security with manageable overhead, directly inspiring MASCOT and the entire OT-based MPC lineage. Go-to protocol for Boolean circuit tasks like private pattern matching and biometric comparison.

**Production readiness:** Mature
TinyOT is implemented in MP-SPDZ and forms the basis of MASCOT; not typically deployed standalone but underpins production systems.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, TinyOT protocol and MASCOT (arithmetic extension)
- [emp-toolkit](https://github.com/emp-toolkit) — C++, OT-MAC protocols inspired by TinyOT

**Security status:** Secure
Full active security via OT-derived information-theoretic MACs; ~6x overhead over semi-honest with rigorous proofs.

**Community acceptance:** Widely trusted
TinyOT is a foundational protocol in the OT-based active-security lineage; directly inspired MASCOT and modern OT-based MPC.

---


## Secure Aggregation and Applications

---
### Secure Aggregation (SecAgg)

**Goal:** Privacy-preserving summation. Multiple clients send encrypted inputs to a server, which learns only the aggregate (sum/average) — not individual contributions. Core primitive for federated learning.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bonawitz et al. (Google SecAgg)** | 2017 | Secret sharing + DH masking | Tolerates dropouts; used in Gboard federated learning [[1]](https://eprint.iacr.org/2017/281) |
| **Bell et al. (SecAgg+)** | 2020 | Sparse secret sharing | O(n log n) communication; improved scalability [[1]](https://eprint.iacr.org/2020/704) |
| **FLAME (LWE-based)** | 2023 | LWE | Post-quantum secure aggregation [[1]](https://eprint.iacr.org/2023/224) |
| **PAgIoT** | 2016 | Paillier + attributes | Privacy-preserving multi-attribute aggregation for IoT; lightweight for constrained devices [[1]](https://lgmanzan.github.io/docs/PagIoT.pdf) |

**State of the art:** SecAgg+ (Google/Apple production), FLAME (PQ setting), PAgIoT (IoT-optimized).

**Production readiness:** Production
SecAgg is deployed in Google's Gboard federated learning and Apple's on-device learning pipelines at scale serving billions of users.

**Implementations:**
- [TensorFlow Federated](https://github.com/google-parfait/tensorflow-federated) ⭐ 2.4k — Python, includes SecAgg and SecAgg+ implementations
- [PySyft](https://github.com/OpenMined/PySyft) ⭐ 9.9k — Python, secure aggregation for federated learning
- [FATE](https://github.com/FederatedAI/FATE) ⭐ 6.1k — Python, federated AI platform with secure aggregation

**Security status:** Secure
SecAgg+ is proven secure against semi-honest adversaries with dropout tolerance; LWE-based FLAME provides post-quantum security.

**Community acceptance:** Widely trusted
SecAgg is the de facto standard for privacy-preserving federated learning; deployed by Google, Apple, and adopted in academic FL research.

---

### Mental Poker / Commutative Encryption

**Goal:** Fair card games without a trusted dealer. Two or more players deal, shuffle, and draw cards from a virtual deck — no player can cheat (see others' cards, stack the deck), and no trusted third party is needed. Uses commutative encryption: E_A(E_B(x)) = E_B(E_A(x)), so encryption order doesn't matter.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir-Rivest-Adleman Mental Poker** | 1981 | Commutative RSA | First protocol; players encrypt cards with commutative cipher; shuffle by re-encrypting [[1]](https://people.csail.mit.edu/rivest/pubs/SRA81.pdf) |
| **Barnett-Smart Mental Poker** | 2003 | ElGamal + ZK | Efficient protocol using ElGamal rerandomization + zero-knowledge proofs of shuffle [[1]](https://doi.org/10.1007/978-3-540-40061-5_23) |
| **Blockchain Mental Poker** | 2018 | Smart contracts + commit-reveal | Trustless poker on Ethereum; disputes resolved on-chain [[1]](https://doi.org/10.1007/978-3-030-01177-2_28) |

**State of the art:** Barnett-Smart (efficient, ZK-based); blockchain variants for trustless online play. The first example of [Secure Computation](#multi-party-computation-mpc) — historically predates general MPC.

**Production readiness:** Experimental
Mental poker protocols are implemented in blockchain-based card game platforms; traditional (non-blockchain) implementations are rare.

**Implementations:**
- [mental-poker](https://github.com/geometryxyz/mental-poker) ⭐ 117 — JavaScript, implementation of Barnett-Smart mental poker
- [zkPoker](https://github.com/ottodevs/zkpoker) ⭐ 4 — Rust, zero-knowledge poker using ZK proofs

**Security status:** Secure
Barnett-Smart protocol is proven secure under DDH; blockchain variants inherit smart contract security assumptions.

**Community acceptance:** Niche
Mental poker is historically significant but has limited deployment; blockchain poker games use the techniques in niche applications.

---

### ARIANN and SecureNN (Private Neural Network Inference)

**Goal:** Perform neural network inference (forward pass) on private inputs without revealing the input to the model holder, and without revealing the model weights to the input holder. Targets the two-party "ML-as-a-service" setting: a client has a private query; a server has a private model; only the inference result is revealed.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **SecureNN (Wagh-Gupta-Chandran)** | 2019 | 3PC + secret sharing | Private inference for ReLU-based networks; novel secure comparison for non-linear layers; CCS 2019 [[1]](https://eprint.iacr.org/2018/442) |
| **ARIANN (Ryffel et al.)** | 2020 | 2PC + additive SS + function secret sharing | Sublinear communication for private inference using FSS for ReLU and comparison; PPML 2020 [[1]](https://arxiv.org/abs/2006.04593) |
| **Cheetah** | 2022 | 2PC: CKKS (linear) + OT/GC (nonlinear) | Fast 2-party private inference by combining CKKS for matrix multiply with GC for ReLU; USENIX Security 2022 [[1]](https://eprint.iacr.org/2022/207) |
| **Iron** | 2022 | 2PC + transformer attention | Private transformer inference (BERT, GPT-2); handles attention heads and softmax securely; NeurIPS 2022 [[1]](https://arxiv.org/abs/2207.05836) |
| **BOLT** | 2023 | 2PC + lookup table garbling | Efficient non-linear activation via garbled lookup tables; replaces expensive GC sigmoid with table-based approach [[1]](https://eprint.iacr.org/2023/806) |

**State of the art:** Cheetah and BOLT represent the current performance frontier for 2-party private inference. The key challenge remains non-linear layers (ReLU, softmax, GeLU) — linear layers are well-handled by CKKS, but activations require expensive garbled circuits or FSS-based techniques. Distinct from [SecureML / MPC-based ML training](#secureml-and-mpc-based-machine-learning-inference) (covers training); related to [FSS / DPF](#function-secret-sharing-fss--distributed-point-functions-dpf), [Garbled Circuits](#garbled-circuits-expanded), and [HE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he).

**Production readiness:** Experimental
Cheetah, BOLT, and SecureNN have working implementations; deployed in research settings but not yet at production scale.

**Implementations:**
- [SecureNN](https://github.com/snwagh/securenn-public) ⭐ 131 — C++, 3-party private neural network inference
- [Cheetah](https://github.com/Alibaba-Gemini-Lab/OpenCheetah) ⭐ 215 — C++, fast 2-party private inference (Alibaba)
- [CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python, private inference and training framework

**Security status:** Secure
Protocols have rigorous security proofs; non-linear layer approximations introduce accuracy loss but no security degradation.

**Community acceptance:** Emerging
Private neural network inference is a rapidly growing field; Cheetah and BOLT represent the performance frontier.

---

### Delphi (Cryptographic Private Inference Service)

**Goal:** Co-design cryptography and machine learning to achieve fast private neural network inference. Delphi shifts expensive homomorphic encryption operations to an offline preprocessing phase and uses lightweight additive secret sharing online, while a planner automatically selects network architectures that balance accuracy against cryptographic cost — replacing expensive non-linear activations (ReLU) with cheaper alternatives where accuracy loss is minimal.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Delphi (Mishra et al.)** | 2020 | 2PC: HE (offline) + additive SS (online) | 22x faster online latency than Gazelle; planner co-optimizes architecture and crypto; USENIX Security 2020 [[1]](https://eprint.iacr.org/2020/050) |
| **Gazelle (Juvekar-Vaikuntanathan-Chandrakasan)** | 2018 | RLWE-HE + garbled circuits | First practical HE+GC hybrid for private inference; lattice-based linear layers + GC for ReLU; USENIX Security 2018 [[1]](https://eprint.iacr.org/2018/073) |
| **CrypTFlow2** | 2020 | 2PC: OT + HE | End-to-end private inference with automatic TensorFlow-to-MPC compilation; CCS 2020 [[1]](https://eprint.iacr.org/2020/1002) |

**State of the art:** Delphi and CrypTFlow2 represent the preprocessing-model approach to private inference — heavy HE offline, fast SS online. Delphi's architecture co-design (replacing some ReLUs with polynomials) is a key practical insight adopted by subsequent systems. Distinct from [ARIANN / SecureNN](#ariann-and-securenn-private-neural-network-inference) (which focus on FSS-based or 3PC approaches) and [Cheetah / BOLT](#ariann-and-securenn-private-neural-network-inference) (which further optimize the non-linear layers). Related to [Garbled Circuits](#garbled-circuits-expanded) and [HE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he).

**Production readiness:** Experimental
Delphi and CrypTFlow2 are academic prototypes with working implementations; not deployed at production scale.

**Implementations:**
- [Delphi](https://github.com/mc2-project/delphi) ⭐ 132 — Rust, preprocessing-model private inference with architecture co-design
- [CrypTFlow2](https://github.com/mpc-msri/EzPC) ⭐ 444 — C++, end-to-end TensorFlow-to-MPC compiler (Microsoft Research)

**Security status:** Secure
Protocols have rigorous 2PC security proofs; the ReLU-to-polynomial approximation affects accuracy but not security.

**Community acceptance:** Emerging
Delphi and CrypTFlow2 are well-cited in the PPML literature; the preprocessing-model approach to private inference is widely adopted.

---

### Beaver Triples (Multiplication Triples)

**Goal:** Amortize the cost of secure multiplications. A Beaver triple is a secret-shared tuple (⟨a⟩, ⟨b⟩, ⟨c⟩) with c = a·b, where a and b are uniformly random. Given a precomputed triple, two parties can evaluate any multiplication gate with a single round of communication and no cryptography — all expensive work is pushed to an offline preprocessing phase.

| Technique | Year | Basis | Note |
|-----------|------|-------|------|
| **Beaver's Circuit Randomization** | 1991 | Information-theoretic | Original preprocessing model; reduce online MPC to XOR + broadcast using precomputed triples [[1]](https://dl.acm.org/doi/10.1145/103418.103444) |
| **Triple generation via MASCOT** | 2016 | OT extension | Generate authenticated triples under malicious security using OT; basis of SPDZ preprocessing [[1]](https://eprint.iacr.org/2016/505) |
| **Triple generation via PCG/Silent OT** | 2020 | Ring-LPN | Generate triples from short correlated seeds; sublinear communication [[1]](https://eprint.iacr.org/2020/924) |
| **Masked Triples** | 2021 | Secret sharing | Amortize triples across conditional branches; reduce waste from unused branch triples [[1]](https://eprint.iacr.org/2021/604) |

**State of the art:** PCG-based triple generation (2020) for minimal communication; MASCOT for concretely practical malicious-secure generation. Beaver triples are the universal currency of the preprocessing model — used in SPDZ, ABY, MOTION, and virtually every practical arithmetic MPC protocol. See [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg) and [OLE / VOLE](#oblivious-linear-evaluation-ole--vole).

**Production readiness:** Production
Beaver triples are the core preprocessing primitive in virtually every deployed arithmetic MPC system (SPDZ, ABY, MOTION, MP-SPDZ).

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, multiple triple generation methods (MASCOT, Overdrive, PCG)
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 — C++, authenticated triple generation for SPDZ
- [MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, Beaver triple-based multiplication for GMW/BMR

**Security status:** Secure
Beaver's technique is information-theoretically secure given correct triple generation; authenticated variants (SPDZ MACs) provide malicious security.

**Community acceptance:** Standard
Beaver triples are universally accepted as the standard technique for secure multiplication in the preprocessing model.

---

### Efficient Two-Party ECDSA (DKLS18 / Doerner et al.)

**Goal:** Compute a standard ECDSA signature between two parties where neither party holds the full signing key — the key is additively split, and both must cooperate to sign. Produces a signature verifiable under the ordinary (single-party) ECDSA algorithm. Practical for threshold custody of Bitcoin/Ethereum keys without changing the on-chain verification logic.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lindell 2PC-ECDSA** | 2017 | Paillier + ZK | First concretely efficient 2PC ECDSA; uses Paillier encryption; CCS 2017 [[1]](https://eprint.iacr.org/2017/552) |
| **DKLS18 (Doerner-Kondi-Lee-Shelat)** | 2018 | OT extension + multiplicative-to-additive | Replace Paillier with OT extension; 2× faster, smaller proofs; CCS 2018 [[1]](https://eprint.iacr.org/2018/499) |
| **DKLS19 (2-of-2 + threshold extension)** | 2019 | OT + ECDSA nonce sharing | Generalize to t-of-n threshold; used as basis of many production HSMs [[1]](https://eprint.iacr.org/2019/523) |
| **Canetti et al. UC 2PC-ECDSA** | 2020 | Paillier + UC framework | UC-secure 2PC ECDSA; tight security proofs; CCS 2020 [[1]](https://eprint.iacr.org/2019/503) |
| **GG20 (Gennaro-Goldfeder)** | 2020 | Feldman VSS + OT | t-of-n threshold ECDSA used in production MPC wallets (e.g., Fireblocks, ZenGo) [[1]](https://eprint.iacr.org/2020/540) |

**State of the art:** DKLS19 and GG20 are the dominant production protocols for threshold ECDSA; both are deployed in cryptocurrency custody, hardware security modules, and MPC wallets. Related to [Threshold Signature Schemes](08-signatures-advanced.md#threshold-signature-schemes-tss) and [Key Management](03-key-exchange-key-management.md).

**Production readiness:** Production
DKLS19 and GG20 are deployed in production MPC wallets (Fireblocks, ZenGo, Coinbase) and hardware security modules for cryptocurrency custody.

**Implementations:**
- [multi-party-ecdsa](https://github.com/ZenGo-X/multi-party-ecdsa) ⭐ 1.1k — Rust, GG18/GG20 threshold ECDSA (ZenGo)
- [tss-lib](https://github.com/bnb-chain/tss-lib) ⭐ 1.0k — Go, threshold ECDSA/EdDSA library (Binance)
- [DKLS](https://github.com/ArnaudBrousseau/dkls) ⭐ 1 — Rust, DKLS18/19 2PC ECDSA implementation

**Security status:** Secure
GG20 and DKLS19 have UC-secure proofs; deployed implementations are audited by professional security firms.

**Community acceptance:** Widely trusted
Threshold ECDSA (GG20, DKLS) is the industry standard for MPC-based cryptocurrency custody; deployed across major exchanges and wallet providers.

---

### Secure Computation on Graphs (Private Graph Algorithms)

**Goal:** Evaluate graph algorithms — shortest paths, connectivity, PageRank, triangle counting, subgraph matching — on a graph whose structure is secret-shared among parties. Neither the edge set nor intermediate results are revealed. Applications include private contact-tracing, private social-network analysis, fraud detection across institutions, and private knowledge-graph queries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Oblivious Graph Algorithms (Feigenbaum et al.)** | 2006 | Circuit MPC + ORAM | First systematic treatment; BFS, shortest path, connectivity on secret graphs; O(n² log n) gates [[1]](https://doi.org/10.1145/1132516.1132573) |
| **GEM (Graph Encryption for Matching)** | 2016 | Graph encryption + SSE | Encrypted graph supporting private bipartite matching queries; sublinear search [[1]](https://eprint.iacr.org/2016/1247) |
| **PrivGraph (Private PageRank)** | 2021 | Secret sharing + fixed-point | Secure PageRank for 2/3-party settings; convergence within privacy budget [[1]](https://eprint.iacr.org/2021/1234) |
| **Private Triangle Counting** | 2020 | Arithmetic MPC + matrix ops | Secure triangle counting via private matrix trace; practical for graphs with thousands of nodes [[1]](https://eprint.iacr.org/2020/472) |
| **SCALE-Graph (oblivious subgraph)** | 2023 | ORAM + garbled circuits | Oblivious subgraph isomorphism; hides which subgraph pattern matches [[1]](https://eprint.iacr.org/2023/1741) |

**State of the art:** Private graph algorithms remain expensive — graph problems have complex data-dependent access patterns that require ORAM or oblivious data structures to hide. Practical systems restrict to specific graph properties (trees, planar graphs) or use approximate methods with differential privacy. Related to [ORAM](10-privacy-preserving-computation.md#oblivious-ram-oram), [Graph Encryption](10-privacy-preserving-computation.md#graph-encryption), and [Oblivious Sorting](10-privacy-preserving-computation.md#oblivious-sorting--oblivious-data-structures).

**Production readiness:** Research
Private graph algorithms remain expensive and are limited to academic prototypes; no production deployments exist.

**Implementations:**
- [Obliv-C](https://github.com/samee/obliv-c) ⭐ 184 — C, can express graph algorithms as 2PC programs

**Security status:** Secure
Security follows from underlying MPC/ORAM security; data-dependent access patterns are hidden by ORAM at significant cost.

**Community acceptance:** Niche
Private graph algorithms are theoretically well-studied but practical overhead limits adoption; active research area.

---

### Private Decision Trees and Random Forests (Bost et al., ABY3)

**Goal:** Evaluate a decision tree or random forest on a private input without revealing the model structure or the input values. The client holds a sensitive query (e.g., a medical record); the model owner holds a trained classifier. Only the classification label is revealed — not the branching conditions, thresholds, or individual tree predictions. Applications include private medical diagnosis, private credit scoring, and private fraud classification.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bost-Popa-Tu-Goldwasser** | 2015 | HE (Paillier) + GC | First practical private classification: decision trees, naive Bayes, and hyperplane classifiers; IEEE S&P 2015 [[1]](https://eprint.iacr.org/2014/331) |
| **Kissner-Song private classifiers** | 2005 | Secret sharing | Early MPC-based private decision tree evaluation; information-theoretic in honest-majority model [[1]](https://dl.acm.org/doi/10.1145/1102120.1102169) |
| **Efficient Private Decision Tree (Joye-Salehi)** | 2018 | HE + oblivious RAM | Decision tree evaluation using FHE for tree traversal; avoids circuit blowup from branch unrolling [[1]](https://eprint.iacr.org/2018/1099) |
| **ABY3 Random Forest** | 2018 | 3PC secret sharing (honest majority) | Secret-shared random forest evaluation over replicated shares; fast LAN performance; CCS 2018 [[1]](https://eprint.iacr.org/2018/403) |
| **Wen-Dong-Li (Crypten private forest)** | 2022 | 2PC + FSS | Private random forest using FSS for comparison gates; sublinear communication per tree node [[1]](https://arxiv.org/abs/2201.12218) |

**State of the art:** ABY3-based approaches are fastest for semi-honest 3-party settings; FSS-based comparison (ARIANN-style) is best for 2-party. The central challenge is the data-dependent branching of tree traversal — standard solutions either unroll all paths (circuit blowup) or use ORAM (large overhead). Related to [FSS / DPF](#function-secret-sharing-fss--distributed-point-functions-dpf), [SecureML / MPC-based ML](#secureml-and-mpc-based-machine-learning-inference), and [ARIANN / SecureNN](#ariann-and-securenn-private-neural-network-inference).

**Production readiness:** Experimental
Private decision tree evaluation is implemented in research frameworks; production deployment is limited to specific healthcare/finance use cases.

**Implementations:**
- [ABY3](https://github.com/ladnir/aby3) ⭐ 212 — C++, includes private random forest evaluation
- [CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python, supports decision tree inference
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, can express decision tree evaluation

**Security status:** Secure
Protocols are proven secure; the main challenge is efficiency of data-dependent tree traversal, not security.

**Community acceptance:** Niche
Private decision trees are well-studied in the PPML literature; practical for specific domains (medical diagnosis, credit scoring).

---

### SecretFlow

**Goal:** Provide a unified, open-source framework for privacy-preserving computation — supporting MPC, federated learning, TEE-based computation, and differential privacy in a single platform. Developed by Ant Group for large-scale privacy-preserving data analytics and machine learning across organizational boundaries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SecretFlow** | 2022 | SEMI2K, ABY3, Cheetah, TEE | Unified framework; MPC protocols (SEMI2K for semi-honest 2PC, ABY3 for 3PC, Cheetah for fast 2PC); federated learning; TEE integration [[1]](https://github.com/secretflow/secretflow) |
| **SPU (Secret Processing Unit)** | 2022 | MPC VM | Virtual device abstracting MPC protocols; JIT compilation of computation graphs to MPC; part of SecretFlow [[1]](https://github.com/secretflow/spu) |

**State of the art:** SecretFlow (2022-) is one of the most comprehensive open-source privacy-preserving computation frameworks. SPU provides a "virtual MPC device" that compiles NumPy/JAX computation graphs into MPC protocols (SEMI2K, ABY3, Cheetah). Also includes SCQL (Secure Collaborative Query Language) for SQL-like queries over secret-shared data. Used in financial and healthcare settings in China. Related to [SPDZ Protocol Family](#spdz-protocol-family-speedz), [ABY / ABY3](#aby--aby3-mixed-protocol-mpc-framework), and [Secure Aggregation (SecAgg)](#secure-aggregation-secagg).

**Production readiness:** Mature
Deployed in financial data collaboration scenarios (Ant Group, Chinese banks). Active open-source community with regular releases. Supports production-grade MPC, FL, and TEE workloads.

**Implementations:**
- [secretflow/secretflow](https://github.com/secretflow/secretflow) ⭐ 2.3k — Python — unified privacy-preserving computation framework
- [secretflow/spu](https://github.com/secretflow/spu) ⭐ 800 — C++/Python — MPC virtual device (Secret Processing Unit)
- [secretflow/scql](https://github.com/secretflow/scql) ⭐ 250 — Go/C++ — secure collaborative SQL query engine

**Security status:** Caution
Underlying MPC protocols (SEMI2K, ABY3, Cheetah) are well-studied and proven secure in their respective threat models. Framework composition and TEE integration introduce additional trust assumptions that require careful configuration.

**Community acceptance:** Emerging
Largest open-source MPC/FL framework by star count; backed by Ant Group; used in Chinese financial sector regulatory sandbox. Growing international adoption; academic publications at USENIX, VLDB.

---
