# AI, Hardware & Physical Security


<!-- TOC -->
## Contents (47 schemes)

- [zkLLM / Verifiable AI Inference](#zkllm-verifiable-ai-inference)
- [Cryptographic Watermarking for AI / Pseudorandom Codes](#cryptographic-watermarking-for-ai-pseudorandom-codes)
- [In-Sensor Cryptography](#in-sensor-cryptography)
- [Physical Unclonable Functions (PUF)](#physical-unclonable-functions-puf)
- [Encrypted Control Systems](#encrypted-control-systems)
- [Wiretap Channel / Physical-Layer Security](#wiretap-channel-physical-layer-security)
- [Proof of Location / Spatial Proofs](#proof-of-location-spatial-proofs)
- [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures)
- [Fault Injection Attacks & Countermeasures](#fault-injection-attacks-countermeasures)
- [Speculative Execution & Cache-Timing Side-Channel Attacks](#speculative-execution-cache-timing-side-channel-attacks)
- [Hardware True Random Number Generators (TRNGs)](#hardware-true-random-number-generators-trngs)
- [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference)
- [Electromagnetic Side-Channel Analysis (EMCA)](#electromagnetic-side-channel-analysis-emca)
- [Side-Channel Resistant AES Implementations](#side-channel-resistant-aes-implementations)
- [Secure MPC / HE for Private ML Inference](#secure-mpc-he-for-private-ml-inference)
- [Federated Learning Security: Poisoning & Byzantine Robustness](#federated-learning-security-poisoning-byzantine-robustness)
- [Model Extraction Attacks & Defenses](#model-extraction-attacks-defenses)
- [Differential Privacy in ML (DP-SGD)](#differential-privacy-in-ml-dp-sgd)
- [Acoustic Cryptanalysis](#acoustic-cryptanalysis)
- [Cold Boot Attacks on DRAM](#cold-boot-attacks-on-dram)
- [Rowhammer Attacks on DRAM](#rowhammer-attacks-on-dram)
- [Hardware Security Modules (HSM) & FIPS 140-3](#hardware-security-modules-hsm-fips-140-3)
- [ML Modeling Attacks on Strong PUFs & ML-Based Privacy Attacks](#ml-modeling-attacks-on-strong-pufs-ml-based-privacy-attacks)
- [White-Box Cryptography (WBC)](#white-box-cryptography-wbc)
- [Smart Card & Secure Element Cryptography](#smart-card-secure-element-cryptography)
- [Cryptographic Hardware Accelerators (AES-NI, SHA-NI, AVX-512 VAES)](#cryptographic-hardware-accelerators-aes-ni-sha-ni-avx-512-vaes)
- [Anti-Tamper Mechanisms & Cryptographic Zeroization](#anti-tamper-mechanisms-cryptographic-zeroization)
- [GPU-Based Cryptographic Acceleration (CUDA AES, GPU FHE)](#gpu-based-cryptographic-acceleration-cuda-aes-gpu-fhe)
- [AI Hardware Trojans (Backdoor Attacks on Neural Accelerators)](#ai-hardware-trojans-backdoor-attacks-on-neural-accelerators)
- [Supply Chain Attacks on Cryptographic Hardware](#supply-chain-attacks-on-cryptographic-hardware)
- [Formal Verification of Cryptographic Hardware](#formal-verification-of-cryptographic-hardware)
- [Confidential GPU Computing (NVIDIA H100 CC, Azure Confidential GPU)](#confidential-gpu-computing-nvidia-h100-cc-azure-confidential-gpu)
- [Federated Learning Secure Aggregation (SecAgg)](#federated-learning-secure-aggregation-secagg)
- [Encrypted ML Frameworks (CrypTen, TF Encrypted, PySyft)](#encrypted-ml-frameworks-crypten-tf-encrypted-pysyft)
- [Model Watermarking & Fingerprinting for IP Protection](#model-watermarking-fingerprinting-for-ip-protection)
- [SRAM PUF Key Generation & Fuzzy Extractors](#sram-puf-key-generation-fuzzy-extractors)
- [Arbiter PUF Protocols & Advanced Compositions](#arbiter-puf-protocols-advanced-compositions)
- [RISC-V Cryptography Extensions (Zbk*, Zkn*, Zks*, Zvk*)](#risc-v-cryptography-extensions-zbk-zkn-zks-zvk)
- [ARM Confidential Compute Architecture (CCA)](#arm-confidential-compute-architecture-cca)
- [Intel Trust Domain Extensions (TDX)](#intel-trust-domain-extensions-tdx)
- [CKKS-Based Homomorphic Encryption for ML Training](#ckks-based-homomorphic-encryption-for-ml-training)
- [Caliptra — Open-Source Silicon Root of Trust](#caliptra-open-source-silicon-root-of-trust)
- [Zero-Knowledge Proofs of Training (zkPoT / zkDL)](#zero-knowledge-proofs-of-training-zkpot-zkdl)
- [Cryptographic Fairness Auditing / Fairness-as-a-Service](#cryptographic-fairness-auditing-fairness-as-a-service)
- [Verifiable Machine Unlearning (FHorgEt)](#verifiable-machine-unlearning-fhorget)
- [Dataset Watermarking for Training Data Provenance](#dataset-watermarking-for-training-data-provenance)
- [Post-Quantum FIDO2 / Passkey Attestation](#post-quantum-fido2-passkey-attestation)
<!-- /TOC -->

## zkLLM / Verifiable AI Inference

**Goal:** Cryptographically prove that an AI model produced a specific output on a specific input — without revealing model weights or input data. Enables trustless AI-as-a-service: the provider proves correct inference, the client verifies without re-running the model.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **zkLLM (Sun-Li-Zhang)** | 2024 | tlookup + zkAttn | First ZK proof for LLM attention; proves 13B-param inference in <15 min; CCS 2024 [[1]](https://arxiv.org/abs/2404.16109) |
| **zkPyTorch** | 2025 | Expander proof engine | Auto-generate ZK proofs for standard PyTorch inference workloads [[1]](https://eprint.iacr.org/2025/535) |
| **Lightweight Proof of Inference** | 2026 | Sampling + Merkle | Statistical sampling of inference trace; millisecond proving time [[1]](https://eprint.iacr.org/2026/541) |

**State of the art:** zkLLM (CCS 2024) for full LLM proofs; lightweight sampling (2026) for practical deployment. Extends [zkML](#zkml-zero-knowledge-machine-learning) to production-scale models.

**Production readiness:** Research
Academic prototypes only; zkLLM proving time (~15 min for 13B params) precludes production use

**Implementations:**
- [zkLLM (official)](https://github.com/jvhs0706/zkllm-ccs2024) ⭐ 58 [archived] — Python/Rust, reference implementation from CCS 2024 paper
- [zkPyTorch (PolyhedraZK)](https://github.com/PolyhedraZK/ExpanderCompilerCollection) ⭐ 42 — Rust, Expander proof engine for PyTorch inference

**Security status:** Caution
Proof systems are sound under stated assumptions but have not undergone large-scale adversarial audit; parameter choices are evolving

**Community acceptance:** Emerging
Active academic interest (CCS 2024); no standardization effort yet; growing blockchain community adoption via zkML tooling

---

## Cryptographic Watermarking for AI / Pseudorandom Codes

**Goal:** Embed a cryptographically verifiable, statistically undetectable watermark in AI-generated text. The watermark is invisible to users but detectable with a secret key — proving content was generated by a specific model. Based on a new primitive: pseudorandom error-correcting codes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kirchenbauer et al. LLM Watermark** | 2023 | Token-level PRF bias | Bias token selection using PRF keyed by preceding tokens; first practical LLM watermark [[1]](https://arxiv.org/abs/2301.10226) |
| **Christ-Gunn Undetectable Watermarks** | 2024 | Pseudorandom codes | First cryptographically undetectable watermark; new primitive: error-correcting codes indistinguishable from random [[1]](https://eprint.iacr.org/2024/1056) |
| **Google SynthID-Text** | 2024 | Tournament sampling | Production watermark in Gemini; quality-preserving via speculative sampling [[1]](https://www.nature.com/articles/s41586-024-08025-4) |

**State of the art:** Christ-Gunn pseudorandom codes (CRYPTO 2024); SynthID deployed in production. Emerging primitive at intersection of [PRF](01-foundational-primitives.md#pseudorandom-functions-prf-pseudorandom-permutations-prp) and coding theory.

**Production readiness:** Experimental
Google SynthID-Text deployed in Gemini production; academic schemes (Christ-Gunn) are prototype-only

**Implementations:**
- [SynthID-Text (Google DeepMind)](https://github.com/google-deepmind/synthid-text) ⭐ 813 — Python, production watermarking library used in Gemini
- [KGW Watermark (Kirchenbauer et al.)](https://github.com/jwkirchenbauer/lm-watermarking) ⭐ 663 — Python/PyTorch, reference implementation of token-level watermarking

**Security status:** Caution
Watermarks can be removed or weakened by paraphrasing; undetectability proofs hold under idealized models but practical robustness varies

**Community acceptance:** Emerging
CRYPTO 2024 best paper (Christ-Gunn); active policy interest (EU AI Act); no formal standard yet

---

## In-Sensor Cryptography

**Goal:** Sign data at the point of physical measurement. The sensor hardware (camera, accelerometer, thermometer) cryptographically signs readings at capture time — before any software can modify them. Guarantees authenticity of physical measurements; combats deepfakes and scientific data fraud.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Qualcomm Snapdragon Secure Camera** | 2022 | Hardware signing | SoC signs image frames at ISP level; tamper-evident metadata [[1]](https://www.qualcomm.com/news/onq/2022/11/new-snapdragon-8-gen-2-sets-a-new-standard-for-premium-smartphones) |
| **Nikon Z9 C2PA** | 2024 | C2PA + hardware | Camera signs photos at capture; verifiable provenance chain [[1]](https://www.nikon.com/company/technology/c2pa/) |
| **Chandrasekaran et al. In-Sensor Crypto** | 2025 | PUF + physical | Physical crypto directly in sensor hardware; binds measurement to device identity [[1]](https://www.nature.com/articles/s41928-026-01593-5) |

**State of the art:** C2PA-integrated cameras (Nikon, Leica, Sony); PUF-based sensor crypto (2025). Extends [PUF](#physical-unclonable-functions-puf) and [Provenance Attestation](#gpu-based-cryptographic-acceleration-cuda-aes-gpu-fhe).

**Production readiness:** Experimental
Nikon Z9 and Leica M11-P ship with C2PA signing; general in-sensor PUF crypto remains lab-stage

**Implementations:**
- [C2PA Rust SDK](https://github.com/contentauth/c2pa-rs) ⭐ 311 — Rust, Content Authenticity Initiative reference implementation
- [c2patool CLI](https://github.com/contentauth/c2patool) ⭐ 126 — Rust CLI, create and verify C2PA manifests

**Security status:** Caution
C2PA signing is cryptographically sound but does not prevent capture of a fake scene; PUF-based sensor binding is unaudited at scale

**Community acceptance:** Emerging
C2PA is a published standard (Coalition for Content Provenance and Authenticity); adopted by Adobe, Microsoft, Nikon, Leica; broader sensor-level crypto is niche

---

## Physical Unclonable Functions (PUF)

**Goal:** Hardware-based authentication. A PUF exploits manufacturing variations in a chip to produce unique, unpredictable challenge-response pairs. Acts as a physical "fingerprint" for devices. Cannot be cloned, even by the manufacturer.

| Type | Year | Basis | Note |
|------|------|-------|------|
| **Arbiter PUF** | 2002 | Race condition | Two signal paths compete; winner depends on manufacturing variations [[1]](https://ieeexplore.ieee.org/document/1003580) |
| **SRAM PUF** | 2007 | Power-up state | Each SRAM cell powers up to 0 or 1 deterministically per device [[1]](https://ieeexplore.ieee.org/document/4261993) |
| **Ring Oscillator PUF** | 2003 | Frequency differences | Compare oscillation frequencies of identically-designed rings [[1]](https://dl.acm.org/doi/10.1145/611892.611996) |

**State of the art:** SRAM PUF (commercial: NXP, Intrinsic ID), combined with fuzzy extractors for stable key derivation.

**Production readiness:** Production
SRAM PUFs deployed in hundreds of millions of MCUs (NXP, Microchip, Renesas) via Intrinsic ID BroadKey

**Implementations:**
- [Intrinsic ID BroadKey](https://www.intrinsic-id.com/broadkey/) — Commercial IP core for SRAM PUF key generation
- [PUFlib (TU Darmstadt)](https://github.com/nils-wisiol/pypuf) ⭐ 92 — Python, PUF simulation and ML attack framework for research

**Security status:** Caution
SRAM PUFs are secure for key storage; Arbiter PUFs broken by ML modeling attacks (see ML Modeling Attacks section); requires fuzzy extractors for reliability

**Community acceptance:** Widely trusted
Commercial deployment by NXP, Infineon, Microchip; NIST-validated entropy sources; well-studied in academic literature

---

## Encrypted Control Systems

**Goal:** Secure cyber-physical control without decryption. A cloud controller receives FHE-encrypted sensor data, computes the control law homomorphically, and sends encrypted actuator commands — the controller never sees plaintext measurements or commands. Protects industrial control systems and smart grids from cloud compromise.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kogiso-Fujita Encrypted Control** | 2015 | ElGamal HE | First encrypted controller; homomorphic linear feedback on encrypted plant state [[1]](https://doi.org/10.1109/CDC.2015.7402918) |
| **Kim-Shim-Wu et al. Encrypted LQG** | 2020 | CKKS (approx HE) | Encrypted linear-quadratic-Gaussian control; CKKS for real-valued computations [[1]](https://arxiv.org/abs/2010.00268) |
| **Encrypted MPC (Schlüter et al.)** | 2023 | TFHE + model predictive | Encrypted model predictive control with bootstrapping; real-time feasible [[1]](https://doi.org/10.1016/j.ifacol.2023.10.1285) |
| **Privacy-Preserving Power Flow (SMPC)** | 2024 | MPC + Newton's method | SMPC-based power flow analysis for smart grids without revealing grid state [[1]](https://arxiv.org/abs/2411.14557) |

**State of the art:** CKKS-based encrypted LQG (2020); TFHE for nonlinear control (2023); MPC for power flow (2024). Bridges [HE](#ckks-based-homomorphic-encryption-for-ml-training), [MPC](06-multi-party-computation.md#multi-party-computation-mpc), and control theory.

**Production readiness:** Research
Academic demonstrations on small-scale control loops; no production-grade encrypted controller deployed

**Implementations:**
- [OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, general-purpose FHE library used for encrypted control research
- [SEAL (Microsoft)](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, BFV/CKKS HE library applicable to encrypted control

**Security status:** Caution
Underlying HE schemes are secure; real-time control constraints may force parameter choices that weaken security margins

**Community acceptance:** Niche
Active academic community (IFAC, CDC conferences); no standardization; limited industry adoption

---

## Wiretap Channel / Physical-Layer Security

**Goal:** Information-theoretic secrecy from physics. Extract secret keys from a noisy communication channel — if the eavesdropper's channel is noisier than the legitimate receiver's, perfect secrecy is achievable without any computational assumptions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wyner Wiretap Channel** | 1975 | Information theory | First model: sender→receiver channel better than sender→eavesdropper [[1]](https://doi.org/10.1002/j.1538-7305.1975.tb02040.x) |
| **Csiszár-Körner Broadcast Channel** | 1978 | Information theory | Generalized wiretap to broadcast channels; secrecy capacity formula [[1]](https://doi.org/10.1109/TIT.1978.1055892) |
| **Maurer Secret Key Agreement** | 1993 | Public discussion + noisy channel | Two parties extract shared key using public discussion over noisy channel [[1]](https://doi.org/10.1109/18.256484) |
| **Ahlswede-Csiszár Common Randomness** | 1993 | Source model | Secret key from correlated random sources [[1]](https://doi.org/10.1109/18.256485) |

**State of the art:** Physical-layer security in 5G/wireless; theoretically beautiful but hard to guarantee channel advantage in practice. Complements [QKD](15-quantum-cryptography.md#quantum-key-distribution-qkd) and [OTP](01-foundational-primitives.md#one-time-pad-information-theoretic-security).

**Production readiness:** Research
Foundational information-theoretic results; practical deployment limited to niche wireless scenarios

**Implementations:**
- [GNU Radio](https://github.com/gnuradio/gnuradio) ⭐ 6.0k — C++/Python, SDR framework used for physical-layer security research

**Security status:** Caution
Information-theoretically secure when channel advantage holds; guaranteeing channel advantage in practice is the fundamental challenge

**Community acceptance:** Niche
Well-established in information theory (Shannon tradition); 5G standards include some physical-layer security features; not a replacement for computational crypto

---

## Proof of Location / Spatial Proofs

**Goal:** Cryptographically prove physical presence at a specific location and time. A user proves they were at coordinates (x, y) at time t — without revealing exact position (ZK variant) or with public verification. Enables logistics, insurance, check-ins.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **APPLAUS (Anonymous Proof of Location)** | 2010 | Bluetooth beacons + blind sigs | First decentralized proof of location; witnesses co-sign via Bluetooth [[1]](https://doi.org/10.1109/TDSC.2011.10) |
| **Brambilla et al. Blockchain PoL** | 2023 | ZK + GPS + blockchain | ZK proof of location on blockchain; prove region without exact coords [[1]](https://doi.org/10.1038/s41598-025-04566-4) |
| **Girish-Gluch-Goldwasser Private Proofs of When and Where** | 2025 | ZK proofs | Formal ZK proofs for spatiotemporal claims; composable with other ZK [[1]](https://arxiv.org/abs/2601.18961) |

**State of the art:** ZK spatial proofs (Girish et al. 2025); combines [ZK Proofs](#zero-knowledge-proofs-of-training-zkpot-zkdl) with location verification.

**Production readiness:** Research
Academic prototypes; no production ZK proof-of-location system deployed at scale

**Implementations:**
- [Astral Protocol](https://github.com/AstralProtocol) — TypeScript/Solidity, decentralized location proof framework
- [FOAM Proof of Location](https://github.com/f-o-a-m) — Solidity/Haskell, blockchain-based location proof protocol

**Security status:** Caution
ZK proofs are sound but location verification depends on trusted hardware (GPS) or witness infrastructure; spoofing attacks remain a concern

**Community acceptance:** Emerging
Growing blockchain and logistics interest; no formal standard; active academic research (CRYPTO, Eurocrypt workshops)

---

## Power Analysis Attacks & Masking Countermeasures

**Goal:** Prevent secret-key extraction from physical power measurements. A cryptographic device leaks information through its power consumption; masking splits every sensitive intermediate value into random shares so that no single observable quantity correlates with the secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SPA/DPA (Kocher-Jaffe-Jun)** | 1999 | Power trace statistics | Introduced Simple and Differential Power Analysis; extract AES/DES keys from a few hundred traces [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_25) |
| **Boolean Masking (Chari et al.)** | 1999 | Secret sharing | Split each variable into d+1 shares; provably secure against d-th order DPA [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_26) |
| **Threshold Implementation (TI)** | 2006 | Multiparty sharing | Glitch-resistant masking via secret sharing; provably first-order secure even with combinational glitches; Nikova-Rechberger-Rijmen [[1]](https://link.springer.com/chapter/10.1007/11935308_38) |
| **Domain-Oriented Masking (DOM)** | 2016 | Registered sharing | More area-efficient than TI; separates domain crossings with register stages; Gross-Mangard-Stoffelen [[1]](https://dlnext.acm.org/doi/abs/10.1145/2996366.2996426) |
| **SILVER / Probe-Isolating NI** | 2021 | Formal leakage model | Automated verification of masked implementations under the probing model [[1]](https://eprint.iacr.org/2020/1555) |

**State of the art:** DOM and higher-order TI are the current design standards for masked hardware; SILVER and similar tools verify implementations formally. Extending masking to PQC (ML-KEM, ML-DSA) is an active research frontier. Closely related to [Side-Channel Attacks](#speculative-execution-cache-timing-side-channel-attacks) and [PUF](#physical-unclonable-functions-puf).

**Production readiness:** Production
Masking is mandatory in Common Criteria EAL 4+ certified hardware; DOM and TI deployed in commercial payment and identity chips

**Implementations:**
- [SILVER](https://github.com/Chair-for-Security-Engineering/SILVER) ⭐ 15 — Python, automated verification of masked hardware implementations
- [ChipWhisperer](https://github.com/newaetech/chipwhisperer) ⭐ 1.4k — Python/C, open-source side-channel analysis platform for DPA/SPA

**Security status:** Secure
Higher-order masking is provably secure in the d-probing model; practical security depends on implementation quality and glitch behavior

**Community acceptance:** Standard
Required by Common Criteria (AVA_VAN.5), FIPS 140-3 Level 4, and EMVCo security evaluation; well-studied with decades of peer review

---

## Fault Injection Attacks & Countermeasures

**Goal:** Detect or prevent adversarial faults injected into cryptographic hardware. An attacker induces computation errors (via voltage glitches, clock glitches, laser pulses, or EM) and uses the faulty outputs to recover secret keys through differential analysis.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellcore / Boneh-DeMillo-Lipton Attack** | 1997 | Algebraic fault | First published fault attack; single fault in RSA-CRT exposes the private key via GCD [[1]](https://link.springer.com/chapter/10.1007/3-540-69053-0_4) |
| **Differential Fault Analysis (DFA)** | 1997 | Differential + fault | Biham-Shamir; generalised to secret-key ciphers (DES); compare correct/faulty outputs [[1]](https://link.springer.com/chapter/10.1007/BFb0052259) |
| **Infective Computation** | 2012 | Fault spreading | Spread any injected fault throughout the result so faulty outputs carry no exploitable information [[1]](https://link.springer.com/chapter/10.1007/978-3-642-33027-8_19) |
| **CRAFT / Fault-Resistant Block Ciphers** | 2019 | Tweakable cipher | Block cipher designed from scratch with built-in protection against differential fault attacks [[1]](https://eprint.iacr.org/2019/210) |
| **MDPL / Dual-Rail Precharge Logic** | 2005 | Balanced hardware | Dual-rail circuits balance switching activity and detect faults by checking complementary rails [[1]](https://ieeexplore.ieee.org/document/1490438) |

**State of the art:** Combined countermeasures (redundancy + infective computation + error detection codes) are standard in certified cryptographic hardware (Common Criteria EAL 5+). Fault attacks on lattice-based PQC signatures are an active research area (2024–2025). Complements [Masking](#power-analysis-attacks-masking-countermeasures) and [PUF](#physical-unclonable-functions-puf).

**Production readiness:** Production
Redundancy, infective computation, and error detection are standard in certified cryptographic hardware (EAL 5+)

**Implementations:**
- [ChipWhisperer](https://github.com/newaetech/chipwhisperer) ⭐ 1.4k — Python/C, open-source fault injection and side-channel analysis platform
- [Riscure FiPy (commercial)](https://www.riscure.com/security-tools/inspector-fi/) — Commercial fault injection analysis toolsuite

**Security status:** Caution
Combined countermeasures are effective against known attacks; new fault vectors (laser, EM) continue to emerge; PQC fault resistance is an open area

**Community acceptance:** Standard
Fault resistance is mandated by Common Criteria, EMVCo, and FIPS 140-3 Level 4 evaluations; extensive peer review at CHES and FDTC workshops

---

## Speculative Execution & Cache-Timing Side-Channel Attacks

**Goal:** Prevent microarchitectural attacks that leak cryptographic secrets through CPU caches, branch predictors, or speculative execution. Defenses span hardware mitigations, constant-time programming disciplines, and cryptographic library hardening.

| Attack / Defense | Year | Basis | Note |
|-----------------|------|-------|------|
| **Bernstein Cache-Timing Attack on AES** | 2005 | Cache sets | First public cache-timing key recovery on OpenSSL AES; motivates constant-time AES [[1]](https://cr.yp.to/antiforgery/cachetiming-20050414.pdf) |
| **Spectre (Kocher et al.)** | 2018 | Speculative execution + cache | Branch-predictor mis-speculation leaks cross-process secrets; breaks OS isolation; affects all major CPUs [[1]](https://spectreattack.com/spectre.pdf) |
| **Meltdown (Lipp et al.)** | 2018 | Out-of-order + cache | Transient reads bypass page-table permissions; leaks kernel memory to user space [[1]](https://meltdownattack.com/meltdown.pdf) |
| **Constant-Time Programming (ctgrind / TIMECOP)** | 2010+ | Valgrind-based verification | Discipline: branches and memory indices must not depend on secrets; automated checkers verify compliance [[1]](https://github.com/agl/ctgrind) |
| **DIFT / Hardware Performance Counter Detection** | 2022 | HW performance counters | Detect side-channel attacks at runtime using CPU PMU events; no software modification required [[1]](https://dl.acm.org/doi/10.1145/3519601) |

**State of the art:** Hardware mitigations (IBRS, STIBP, page-table isolation) are deployed in all major OS kernels; constant-time coding is mandatory in modern crypto libraries (OpenSSL, BoringSSL, libsodium). Spectre-class variants continue to emerge; microcode updates remain the primary defense. Related to [Masking](#power-analysis-attacks-masking-countermeasures).

**Production readiness:** Production
Hardware mitigations (IBRS, STIBP, KPTI) deployed in all major OS kernels; constant-time coding enforced in production crypto libraries

**Implementations:**
- [ctgrind](https://github.com/agl/ctgrind) ⭐ 200 — C, Valgrind-based constant-time verification tool
- [TIMECOP](https://post-quantum-cryptography.org/timecop/) — C, automated constant-time testing for crypto implementations
- [spectector](https://github.com/spectector/spectector) ⭐ 75 — OCaml, symbolic executor for detecting Spectre vulnerabilities

**Security status:** Caution
Known Spectre/Meltdown variants are mitigated; new transient-execution variants continue to be discovered; microcode updates are ongoing

**Community acceptance:** Standard
CVE-assigned vulnerabilities with vendor coordination; mitigations shipped by Intel, AMD, ARM, and all major OS vendors; constant-time coding is an industry norm

---

## Hardware True Random Number Generators (TRNGs)

**Goal:** Generate cryptographically unpredictable bits from a physical entropy source. A TRNG harvests entropy from irreducible physical randomness (thermal noise, oscillator jitter, quantum shot noise) and conditions it into a stream that passes statistical and min-entropy tests. Underpins every cryptographic key-generation operation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ring Oscillator TRNG** | 1999 | Clock jitter | Free-running oscillators with different frequencies; jitter accumulates as entropy; simple, widely deployed [[1]](https://ieeexplore.ieee.org/document/803927) |
| **Intel RDRAND / RDSEED (Bull Mountain)** | 2012 | Thermal noise + DRBG | First mainstream CPU TRNG; on-die thermal noise conditioned through AES-CBC-MAC; NIST SP 800-90 compliant [[1]](https://www.intel.com/content/www/us/en/developer/articles/guide/intel-digital-random-number-generator-drng-software-implementation-guide.html) |
| **NIST SP 800-90B Entropy Source Standard** | 2018 | Min-entropy estimation | Defines validation methodology for physical entropy sources; requires health tests and min-entropy ≥ 0.999 per bit [[1]](https://csrc.nist.gov/pubs/sp/800/90/b/final) |
| **Cryptoristor TRNG (Science Advances)** | 2024 | Transistor stochasticity | Single cryptographic transistor as entropy source; ultra-low power; passes NIST SP 800-22 and AIS-31 [[1]](https://www.science.org/doi/10.1126/sciadv.adk6042) |
| **Keccak-Conditioned FPGA TRNG** | 2025 | Ring oscillators + Keccak | Open-source FPGA TRNG with Keccak conditioning; min-entropy 0.9998 bit/bit; validated to BSI AIS-31 [[1]](https://pmc.ncbi.nlm.nih.gov/articles/PMC11946209/) |

**State of the art:** Intel RDRAND/RDSEED in every modern x86 CPU; ARM TrustZone includes dedicated TRNG hardware; NIST SP 800-90B defines the certification baseline. Feeds into [DRBG / PRNG](01-foundational-primitives.md#drbg-deterministic-random-bit-generators) and all key generation. See also [PUF](#physical-unclonable-functions-puf) for device-unique entropy.

**Production readiness:** Production
Intel RDRAND/RDSEED, ARM TRNG, and dedicated TRNG IP cores deployed in billions of devices

**Implementations:**
- [jitterentropy-library](https://github.com/smuellerDD/jitterentropy-library) ⭐ 141 — C, CPU jitter-based entropy source used in Linux kernel
- [NIST SP 800-90B Entropy Assessment](https://github.com/usnistgov/SP800-90B_EntropyAssessment) ⭐ 244 — Python/C++, NIST tool for validating entropy sources

**Security status:** Secure
Hardware entropy sources pass NIST SP 800-90B and BSI AIS-31 validation; RDRAND includes online health testing

**Community acceptance:** Standard
NIST SP 800-90B and BSI AIS-31 define certification baselines; Intel, ARM, and FPGA vendors ship certified implementations

---

## Confidential ML / TEE-Based Inference

**Goal:** Run ML model inference inside a hardware-isolated trusted execution environment so that neither the model weights nor the user's input are visible to the cloud operator, OS, or hypervisor. Combines TEE attestation with privacy-preserving ML deployment.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Intel SGX + Gramine / Occlum** | 2016+ | Enclave + LibOS | Library OSes (Gramine, SCONE, Occlum) lift-and-shift ML workloads into SGX enclaves without code changes [[1]](https://arxiv.org/abs/2208.10134) |
| **Trusted Yet Flexible: ML Runtimes in TEEs** | 2025 | TEE + high-level runtime | Systematization of high-level ML runtimes (TensorFlow, PyTorch) running inside SGX/TDX; benchmark overhead analysis [[1]](https://www.mdpi.com/2624-800X/6/1/23) |
| **Confidential LLM Inference (CPU + GPU TEEs)** | 2025 | Intel TDX + NVIDIA H100 CC | First study of LLM inference on both CPU (TDX) and GPU (H100 Confidential Computing) TEEs; performance/cost tradeoffs [[1]](https://arxiv.org/abs/2509.18886) |
| **Gramine-TDX (CCS 2024)** | 2024 | Intel TDX + LibOS | Lightweight OS kernel for confidential VMs; lower TCB than SGX LibOS; CCS 2024 [[1]](https://dl.acm.org/doi/10.1145/3658644.3690323) |
| **AMD SEV-SNP / Intel TDX VM Isolation** | 2022+ | Full-VM memory encryption | Encrypts VM memory from hypervisor; supports confidential ML at VM granularity; benchmarked in 2024 [[1]](https://arxiv.org/abs/2408.00443) |

**State of the art:** Intel TDX and AMD SEV-SNP offer VM-level isolation deployable on major cloud providers (Azure, GCP, AWS); GPU TEEs (NVIDIA H100 CC) extend coverage to accelerator workloads. Interacts with [TEE Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation), [zkLLM](#zkllm-verifiable-ai-inference), and [FHE-based encrypted inference](07-homomorphic-functional-encryption.md#homomorphic-encryption-he).

**Production readiness:** Production
Intel TDX and AMD SEV-SNP deployed on Azure, GCP, and AWS; NVIDIA H100 CC available for GPU workloads

**Implementations:**
- [Gramine (LibOS for SGX/TDX)](https://github.com/gramineproject/gramine) ⭐ 755 — C, library OS for running unmodified Linux applications in enclaves
- [Occlum](https://github.com/occlum/occlum) ⭐ 1.5k — Rust/C, memory-safe LibOS for Intel SGX enclaves
- [Confidential Containers](https://github.com/confidential-containers) — Go/Rust, cloud-native framework for confidential VMs

**Security status:** Caution
TEE isolation is hardware-enforced; known side-channel attacks exist against SGX (but mitigated in TDX); TCB size varies by platform

**Community acceptance:** Widely trusted
Supported by Intel, AMD, ARM, NVIDIA, and all major cloud providers; active standardization via Confidential Computing Consortium (Linux Foundation)

---

## Electromagnetic Side-Channel Analysis (EMCA)

**Goal:** Extract secret keys by capturing and analysing the electromagnetic radiation emitted by a cryptographic device during computation. EM emanations carry the same (and sometimes richer) data-dependent signal as power consumption but can be measured non-invasively at a distance, making them a potent physical attack vector.

EM side-channel attacks were first formalised by Gandolfi, Mourtel, and Olivier (CHES 2001), who demonstrated full key recovery against DES, COMP128, and RSA on smart-card chips by correlating near-field EM traces with hypothetical intermediate values — the same principle as Differential Power Analysis (DPA) but applied to EM probes. The technique was later generalised into Differential EM Analysis (DEMA) and Correlation EM Analysis (CEMA). Because EM probes can be placed over a specific functional block of an IC, EMCA is often more selective than power analysis and can bypass many power-rail countermeasures. The STELLAR countermeasure (TCHES 2018) routes sensitive computations through lower metal layers to suppress near-field radiation. Modern EM attacks have been demonstrated on microcontrollers, FPGAs, and complex System-on-Chip devices executing AES, RSA, and ECC.

| Scheme / Tool | Year | Basis | Note |
|--------------|------|-------|------|
| **Gandolfi-Mourtel-Olivier DEMA** | 2001 | Near-field EM probing | First concrete EM key extraction on DES/RSA smart cards; introduced SEMA and DEMA [[1]](https://link.springer.com/chapter/10.1007/3-540-44709-1_21) |
| **CEMA on AES (Agrawal et al.)** | 2002 | Correlation EM | Extended CPA methodology to EM; shows EM leaks from distinct chip regions independently [[1]](https://link.springer.com/chapter/10.1007/3-540-36400-5_11) |
| **SoC EM Analysis (Longo et al.)** | 2015 | CEMA on ARM SoC | Key recovery from a full ARM Cortex-A system-on-chip via EM; highlights difficulty of SoC-level countermeasures [[1]](https://link.springer.com/chapter/10.1007/978-3-662-48324-4_31) |
| **STELLAR Countermeasure** | 2018 | Metal-layer routing | Suppresses EM leakage by routing cryptographic logic through lower (shielded) metal layers; evaluated on AES [[1]](https://eprint.iacr.org/2018/620) |

**State of the art:** CEMA is a standard evaluation methodology in Common Criteria and FIPS 140-3 lab testing; shielded packaging and balanced logic styles (from [Masking / TI](#power-analysis-attacks-masking-countermeasures)) also reduce EM leakage. Closely related to [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures) and [Fault Injection Attacks](#fault-injection-attacks-countermeasures).

**Production readiness:** Production
CEMA is a standard evaluation methodology in Common Criteria and FIPS 140-3 security labs worldwide

**Implementations:**
- [ChipWhisperer](https://github.com/newaetech/chipwhisperer) ⭐ 1.4k — Python/C, open-source side-channel analysis platform with EM probe support
- [Riscure Inspector (commercial)](https://www.riscure.com/security-tools/inspector-sca/) — Commercial EM side-channel analysis toolsuite

**Security status:** Caution
EM attacks are a proven threat; countermeasures (shielding, masking) are effective but must be validated per implementation

**Community acceptance:** Standard
Required evaluation methodology in Common Criteria (AVA_VAN.5) and FIPS 140-3 lab testing; decades of academic and industry validation at CHES

---

## Side-Channel Resistant AES Implementations

**Goal:** Implement AES in software or hardware without creating exploitable data-dependent timing or power variation. Naive AES uses lookup tables (T-tables) whose memory-access patterns depend on the secret key; resistant implementations eliminate this leakage through bitslicing, operand shuffling, or masking each table lookup.

| Technique | Year | Basis | Note |
|-----------|------|-------|------|
| **T-table AES (OpenSSL legacy)** | 2002 | 4 KB lookup tables | Fastest naive implementation; four 1 KB tables collapse SubBytes + MixColumns; completely vulnerable to cache-timing attacks [[1]](https://cr.yp.to/antiforgery/cachetiming-20050414.pdf) |
| **Bitsliced AES (Matsui-Nakajima)** | 2007 | SIMD bitslicing | Represent 128 AES instances in bit-parallel form using SSE registers; inherently constant-time; no table lookups [[1]](https://link.springer.com/chapter/10.1007/978-3-540-74619-5_23) |
| **Shuffled T-table / Scatter-Gather** | 2008 | Table reordering + masking | Randomise table access order or use Boolean-masked table lookups; reduces DPA order at cost of speed [[1]](https://link.springer.com/chapter/10.1007/978-3-540-85053-3_27) |
| **Compact Masked S-box (Canright-Batina)** | 2008 | Tower field arithmetic | Compute AES S-box in GF(2^4)^2 tower; amenable to low-cost masking without tables; area-efficient hardware [[1]](https://link.springer.com/chapter/10.1007/978-3-540-85053-3_22) |
| **AES-NI + Constant-Time (libsodium/BoringSSL)** | 2010+ | Hardware AES instructions | x86 AES-NI instructions are inherently constant-time and table-free; universally adopted in crypto libraries as the preferred resistant implementation [[1]](https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-encryption-standard-instructions-aes-ni.html) |

**State of the art:** AES-NI (available on all modern x86 and ARM cores) is the recommended constant-time implementation; bitslicing is used where hardware AES is absent. Masking techniques from [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures) are layered on top when DPA resistance is also required. Resistant AES implementations underpin [AEAD](02-authenticated-structured-encryption.md#authenticated-encryption-aead) and [Disk Encryption](02-authenticated-structured-encryption.md#deterministic-encryption-convergent-encryption).

**Production readiness:** Production
AES-NI and ARM Crypto Extensions are universally deployed; bitsliced and masked implementations used in embedded contexts

**Implementations:**
- [OpenSSL AES-NI](https://github.com/openssl/openssl) ⭐ 29k — C/ASM, constant-time AES-NI dispatch in production TLS library
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, uses AES-NI when available; portable constant-time fallback
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C/ASM, Google's TLS library with constant-time AES
- [fixslicing AES (Alexandre Adomnicai)](https://github.com/aadomn/aes) ⭐ 71 — C/ASM, bitsliced AES for ARM Cortex-M

**Security status:** Secure
AES-NI implementations are inherently constant-time; software bitsliced implementations require careful validation but are provably side-channel free

**Community acceptance:** Standard
AES-NI is the universal standard for resistant AES; mandated in FIPS-validated modules; adopted by every major crypto library

---

## Secure MPC / HE for Private ML Inference

**Goal:** Run ML model inference on a user's private input against a provider's private model — without either party learning the other's data. Combines garbled circuits, secret sharing, or homomorphic encryption to produce the correct prediction while keeping both input and model weights confidential.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SecureML (Mohassel-Zhang)** | 2017 | 2-party MPC + OT | Secure 2PC for linear layers using OT-based multiplication; first practical MPC training on real datasets [[1]](https://ieeexplore.ieee.org/document/7958569) |
| **GAZELLE (Juvekar et al.)** | 2018 | HE + garbled circuits | Hybrid: BFV for linear layers, garbled circuits for ReLU; first sub-second private inference on a CNN [[1]](https://www.usenix.org/conference/usenixsecurity18/presentation/juvekar) |
| **CrypTen (Facebook AI)** | 2021 | 3-party secret sharing | Open-source framework; secret-shared arithmetic and Boolean MPC for PyTorch models; practical benchmarks [[1]](https://arxiv.org/abs/2109.00984) |
| **Cheetah (Huang et al.)** | 2022 | HE + correlated OT | Efficient homomorphic convolution with low-communication correlated-OT-based nonlinear layers; ~3× faster than GAZELLE [[1]](https://www.usenix.org/conference/usenixsecurity22/presentation/huang-zhicong) |
| **Iron (Hao et al.)** | 2022 | HE (CKKS) | Transformer inference using CKKS; first practical private GPT-2 inference end-to-end [[1]](https://proceedings.neurips.cc/paper_files/paper/2022/hash/0a4729f16e04f59a3f37b3ab1b4c2fcf-Abstract-Conference.html) |
| **BumbleBee / BOLT** | 2023 | HE + MPC hybrid | Efficient private inference for BERT-scale transformers; reduces communication by ~10× vs Iron [[1]](https://eprint.iacr.org/2023/1678) |

**State of the art:** Hybrid HE+MPC frameworks (Cheetah, BOLT) achieve practical latency for image classification; transformer-scale private inference (Iron, BumbleBee) remains expensive but feasible. Active area bridging [HE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he), [MPC](06-multi-party-computation.md#multi-party-computation-mpc), and [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference).

**Production readiness:** Experimental
Working implementations exist (CrypTen, Cheetah) but latency and communication overhead limit production use to small models

**Implementations:**
- [CrypTen (Meta AI)](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python/C++, PyTorch-based MPC framework for private ML
- [Cheetah (Alibaba)](https://github.com/Alibaba-Gemini-Lab/OpenCheetah) ⭐ 215 — C++, efficient HE+OT private inference
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, versatile MPC framework supporting multiple protocols

**Security status:** Secure
Underlying MPC and HE protocols have formal security proofs; practical security depends on correct implementation and parameter choices

**Community acceptance:** Emerging
Active academic research (USENIX, NeurIPS, CCS); industry prototypes from Meta, Alibaba, Microsoft; no formal standard for private ML inference

---

## Federated Learning Security: Poisoning & Byzantine Robustness

**Goal:** Train a global model across untrusted participants without a central data repository — while defending against malicious clients who submit poisoned gradients to corrupt the model or infer others' private training data. Security properties include Byzantine robustness, backdoor resistance, and gradient-inversion defenses.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FedAvg (McMahan et al.)** | 2017 | Gradient averaging | Baseline federated learning algorithm; insecure against Byzantine clients by construction [[1]](https://arxiv.org/abs/1602.05629) |
| **Krum (Blanchard et al.)** | 2017 | Robust aggregation | First Byzantine-robust aggregation rule; selects the update closest to its n−f−2 neighbors; provably tolerates f Byzantine clients [[1]](https://proceedings.neurips.cc/paper/2017/hash/f4b9ec30ad9f68f89b29639786cb62ef-Abstract.html) |
| **Gradient Inversion / DLG (Zhu et al.)** | 2019 | Optimization-based attack | Reconstruct training images pixel-accurately from shared gradients; motivates gradient noise and compression defenses [[1]](https://proceedings.neurips.cc/paper/2019/hash/60a6c4002cc7b29142def8871531281a-Abstract.html) |
| **Flame (Nguyen et al.)** | 2022 | Clustering + noise | Cluster client updates, prune outliers, add DP noise; robust to both model-poisoning and backdoor attacks [[1]](https://www.usenix.org/conference/usenixsecurity22/presentation/nguyen) |
| **FLTrust (Cao et al.)** | 2022 | Server-side trust scores | Server computes a trusted reference gradient on a small clean dataset; down-weights client updates by cosine similarity [[1]](https://arxiv.org/abs/2012.13995) |
| **FLGUARD / Secure Aggregation + DP** | 2023 | MPC + DP | Combines cryptographic secure aggregation (Bonawitz et al.) with DP noise; hides individual updates and provides poisoning resistance [[1]](https://arxiv.org/abs/2101.02281) |

**State of the art:** Byzantine-robust aggregation (Krum, FLTrust) and secure aggregation with DP are the main defenses; no single scheme handles all attack vectors simultaneously. Gradient inversion remains an open problem without DP or compression. Interacts with [Differential Privacy in ML](#differential-privacy-in-ml-dp-sgd) and [Secure Aggregation](06-multi-party-computation.md#multi-party-computation-mpc).

**Production readiness:** Experimental
FedAvg deployed at scale (Google Gboard); robust aggregation rules (Krum, FLTrust) are research prototypes

**Implementations:**
- [Flower (FL framework)](https://github.com/adap/flower) ⭐ 6.8k — Python, production FL framework with pluggable aggregation strategies
- [FedML](https://github.com/FedML-AI/FedML) ⭐ 4.0k — Python, open-source FL platform supporting robust aggregation
- [IBM FL](https://github.com/IBM/federated-learning-lib) ⭐ 531 — Python, IBM's federated learning library

**Security status:** Caution
No single defense handles all attack vectors (poisoning, backdoor, gradient inversion) simultaneously; DP + robust aggregation provides partial coverage

**Community acceptance:** Emerging
Active research area (NeurIPS, ICML, USENIX Security); Google deploys FedAvg+SecAgg in production; IEEE P3652.1 FL standard in development

---

## Model Extraction Attacks & Defenses

**Goal:** Prevent an adversary from reconstructing a proprietary ML model by querying its inference API. A model extraction attack adaptively queries the model to build a surrogate with equivalent accuracy and decision boundaries — stealing intellectual property without accessing weights directly. Defenses use rate limiting, output perturbation, watermarking, or cryptographic query auditing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tramer et al. Stealing ML Models** | 2016 | Equation-solving queries | First systematic study; polynomial-query exact extraction of logistic regression, SVMs, and shallow neural nets via API [[1]](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/tramer) |
| **Knockoff Nets (Orekondy et al.)** | 2019 | Active learning queries | Transfer-learning based extraction of deep CNNs using adaptive query selection; matches victim accuracy with ≤20 K queries [[1]](https://openaccess.thecvf.com/content_CVPR_2019/html/Orekondy_Knockoff_Nets_Stealing_Functionality_of_Black-Box_Models_CVPR_2019_paper.html) |
| **PRADA (Juuti et al.)** | 2019 | Query pattern detection | Detect extraction attacks by monitoring the distribution of incoming queries; flags abnormal query sequences [[1]](https://ieeexplore.ieee.org/document/8806737) |
| **Prediction Poisoning (Orekondy et al.)** | 2020 | Adversarial perturbation of outputs | Minimally perturb API outputs to maximize surrogate model degradation without harming legitimate users [[1]](https://arxiv.org/abs/1906.10908) |
| **Cryptographic Model Fingerprinting (Cao et al.)** | 2021 | Backdoor + ZK proof | Embed a verifiable fingerprint (secret backdoor pattern) in the model; owner proves ownership via ZK without revealing the trigger [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/cao) |
| **SEAT (Li et al.)** | 2023 | Watermark-based ownership | Dataset watermarking that survives extraction; verify ownership of a stolen surrogate using statistical hypothesis test [[1]](https://arxiv.org/abs/2301.10205) |

**State of the art:** No defense simultaneously prevents extraction and maintains full utility; watermarking-based ownership verification (SEAT, fingerprinting) is the pragmatic approach. Cryptographic ZK-based model ownership proofs remain nascent. Related to [Cryptographic Watermarking for AI / Pseudorandom Codes](#cryptographic-watermarking-for-ai-pseudorandom-codes) and [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference).

**Production readiness:** Research
Attack tools are research prototypes; defenses (watermarking, rate limiting) are partially deployed in commercial ML APIs

**Implementations:**
- [Knockoff Nets](https://github.com/tribhuvanesh/knockoffnets) ⭐ 115 — Python/PyTorch, model extraction attack implementation
- [ModelGuard (query detection)](https://github.com/Yoruko-Tang/ModelGuard) ⭐ 23 — Python, framework for detecting model extraction queries

**Security status:** Caution
No defense simultaneously prevents extraction and maintains full API utility; watermarking provides post-hoc attribution rather than prevention

**Community acceptance:** Emerging
Active research at top security venues (USENIX, IEEE S&P, CVPR); growing industry concern but no standard defense methodology

---

## Differential Privacy in ML (DP-SGD)

**Goal:** Train machine learning models with a formal, mathematically provable privacy guarantee. Differentially private stochastic gradient descent (DP-SGD) clips per-sample gradients and adds calibrated Gaussian noise each iteration, so the trained model's parameters reveal no individual training record with probability bounded by (ε, δ).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dwork et al. Differential Privacy** | 2006 | Randomized response + composition | Foundational definition: changing one record changes output distribution by at most e^ε; composition and post-processing theorems [[1]](https://link.springer.com/chapter/10.1007/11681878_14) |
| **DP-SGD (Abadi et al.)** | 2016 | Gradient clipping + Gaussian noise | Clip per-sample gradients to L2 norm C, add N(0, σ²C²I) noise; moments accountant tracks privacy loss across iterations; CCS 2016 [[1]](https://dl.acm.org/doi/10.1145/2976749.2978318) |
| **Rényi DP / RDP Accountant (Mironov)** | 2017 | Rényi divergence | Tighter privacy accounting via Rényi divergence; composes better than (ε, δ)-DP under subsampling [[1]](https://ieeexplore.ieee.org/document/8049725) |
| **Privacy Amplification by Subsampling** | 2019 | Poisson subsampling | Randomly subsampling a fraction q of data amplifies privacy from ε to O(qε); fundamental to practical DP-SGD [[1]](https://proceedings.mlr.press/v97/zhu19c.html) |
| **Opacus (Meta)** | 2021 | DP-SGD library | Production DP training library for PyTorch; per-sample gradient computation via functorch; used in production ML systems [[1]](https://arxiv.org/abs/2109.12298) |
| **Handcrafted Backdoors in DP Models (Bagdasaryan et al.)** | 2022 | DP does not prevent poisoning | Shows DP-SGD does not prevent model poisoning; privacy and robustness are orthogonal properties [[1]](https://arxiv.org/abs/2204.00032) |

**State of the art:** DP-SGD with RDP accounting and privacy amplification by subsampling is the standard approach; Opacus and TensorFlow Privacy are the main libraries. Typical deployments target ε ∈ [1, 10] with meaningful utility. DP and robustness are orthogonal — see [Federated Learning Security](#federated-learning-security-poisoning-byzantine-robustness). Foundational to [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy) in the broader privacy-preserving computation context.

**Production readiness:** Production
Deployed at Apple (iOS), Google (RAPPOR, FL), and Meta (internal ML systems); Opacus and TensorFlow Privacy are production-grade

**Implementations:**
- [Opacus (Meta)](https://github.com/pytorch/opacus) ⭐ 1.9k — Python/PyTorch, production DP-SGD training library
- [TensorFlow Privacy](https://github.com/tensorflow/privacy) ⭐ 2.0k — Python/TensorFlow, DP training library with RDP accounting
- [Google DP Library](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, Google's differential privacy building blocks
- [OpenDP](https://github.com/opendp/opendp) ⭐ 412 — Rust/Python, open-source DP framework with formal verification

**Security status:** Secure
Differential privacy provides mathematically proven privacy guarantees; security depends on correct epsilon accounting and noise calibration

**Community acceptance:** Standard
NIST SP 800-226 (draft); US Census Bureau deployment; endorsed by major tech companies; foundational privacy primitive with broad peer review

---

## Acoustic Cryptanalysis

**Goal:** Recover cryptographic secret keys by analysing the high-frequency sound emitted by a computer's electronic components (capacitors, coils) during cryptographic computation — a completely passive, software-free side channel exploitable with commodity microphones.

Genkin, Shamir, and Tromer (CRYPTO 2014) demonstrated that a laptop performing RSA decryption with GnuPG emits distinct acoustic signatures for different key bits, caused by CPU power-draw fluctuations that excite mechanical vibration in the voltage-regulator circuitry. By recording ~1 hour of acoustic signal from a plain mobile phone placed next to the machine — or a sensitive microphone 10 m away — they recovered full 4096-bit RSA keys via adaptive chosen-ciphertext queries. The attack was extended to low-bandwidth electrical (chassis-ground) and EM variants. Countermeasures include RSA blinding (already standard in GnuPG after CVE-2013-4576), constant-power scheduling, and acoustic isolation. A follow-up (Journal of Cryptology, 2016) widened the attack to additional algorithms and platforms.

| Scheme / Attack | Year | Basis | Note |
|----------------|------|-------|------|
| **Acoustic RSA Key Extraction (Genkin-Shamir-Tromer)** | 2014 | Acoustic + chosen-ciphertext | Full 4096-bit RSA key from GnuPG via ~1 h of acoustic recording; mobile phone microphone sufficient; CRYPTO 2014 [[1]](https://link.springer.com/chapter/10.1007/978-3-662-44371-2_25) |
| **Acoustic Cryptanalysis (extended, J. Cryptology)** | 2016 | Acoustic + electrical + EM | Generalised to additional platforms; electrical (chassis) and low-frequency EM variants also demonstrated [[1]](https://link.springer.com/article/10.1007/s00145-015-9224-2) |
| **RSA Blinding Countermeasure (GnuPG CVE-2013-4576)** | 2014 | Algorithmic blinding | Randomise intermediate values so power (and hence acoustic) signal is key-independent; now mandatory in constant-time RSA [[1]](https://eprint.iacr.org/2013/857) |

**State of the art:** Acoustic cryptanalysis motivated the hardening of GnuPG and libgcrypt; constant-time, blinded implementations now dominate. Acoustic attacks remain relevant against legacy or embedded systems where blinding is absent. Related to [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures) and [Electromagnetic Side-Channel Analysis](#electromagnetic-side-channel-analysis-emca).

**Production readiness:** Research
Academic demonstration of novel side channel; motivated hardening of GnuPG/libgcrypt but no standalone acoustic defense products

**Implementations:**
- [GnuPG (hardened)](https://github.com/gpg/gnupg) ⭐ 906 — C, includes RSA blinding countermeasure motivated by acoustic attack
- [libgcrypt](https://github.com/gpg/libgcrypt) ⭐ 263 — C, constant-time and blinded implementations addressing acoustic/power side channels

**Security status:** Caution
Acoustic attacks are demonstrated on legacy software; modern blinded and constant-time implementations are resistant; threat remains for unpatched systems

**Community acceptance:** Niche
Landmark research (CRYPTO 2014, Shamir et al.); motivates constant-time coding discipline; not a primary evaluation criterion in Common Criteria

---

## Cold Boot Attacks on DRAM

**Goal:** Recover cryptographic keys from a powered-off (or rebooted) computer by exploiting the data remanence of DRAM — memory cells retain their contents for seconds to minutes after power loss, long enough for an attacker to cold-boot into a forensic environment and image the entire RAM.

Halderman et al. (USENIX Security 2008) showed that DRAM chips retain data with high fidelity for several seconds at room temperature, and for minutes when cooled with canned air (to ~−50 °C). They recovered AES and RSA keys from running instances of BitLocker, FileVault, dm-crypt, and TrueCrypt by imaging RAM after a cold reboot. Key-reconstruction algorithms correct for the bit-decay noise using algebraic structure in standard key schedules (e.g., AES expanded key redundancy, RSA CRT parameters). Follow-on work extended attacks to elliptic-curve keys (eprint 2015) and post-quantum lattice-based keys (eprint 2018). Countermeasures include full-memory encryption (Intel TME, AMD SME), key erasure on suspend, and scrubbing key material from RAM before power-down.

| Attack / Defense | Year | Basis | Note |
|-----------------|------|-------|------|
| **Halderman et al. Cold Boot** | 2008 | DRAM remanence | First systematic study; recover AES/RSA keys from BitLocker, FileVault, TrueCrypt after cold reboot; USENIX Sec 2008 [[1]](https://www.usenix.org/conference/17th-usenix-security-symposium/lest-we-remember-cold-boot-attacks-encryption-keys) |
| **Cold Boot on ECC Keys** | 2015 | DL / ECC key structure | Adapts attack to elliptic-curve discrete-log keys; solves noisy polynomial systems [[1]](https://eprint.iacr.org/2015/057) |
| **Cold Boot on Lattice / NTT Keys** | 2018 | LWE / Ring-LWE | Demonstrates key recovery from Ring-LWE (NTRU, NewHope) private keys under bit-flip noise model [[1]](https://eprint.iacr.org/2018/672) |
| **Intel Total Memory Encryption (TME)** | 2019+ | AES-XTS memory bus | Encrypts all DRAM traffic on-the-fly at the memory controller; renders cold-boot images ciphertext [[1]](https://www.intel.com/content/www/us/en/developer/articles/news/runtime-encryption-of-memory-with-intel-tme-mktme.html) |

**State of the art:** Intel TME/MKTME and AMD SME/SEV encrypt DRAM contents, substantially mitigating cold-boot threats; full adoption in cloud and mobile platforms is ongoing. Interaction with [Confidential ML / TEE](#confidential-ml-tee-based-inference) and [Fault Injection Attacks](#fault-injection-attacks-countermeasures).

**Production readiness:** Production
Intel TME and AMD SME are deployed in current server and client CPUs; software mitigations in all major OS kernels

**Implementations:**
- [aeskeyfind](https://github.com/makomk/aeskeyfind) ⭐ 69 — C, tool for finding AES keys in memory dumps (cold boot forensics)

**Security status:** Caution
Full-memory encryption (TME/SME) effectively mitigates cold-boot attacks; legacy systems without memory encryption remain vulnerable

**Community acceptance:** Widely trusted
Seminal USENIX Security 2008 paper; TME/SME/SEV adopted by Intel, AMD; Microsoft BitLocker and Apple FileVault include cold-boot mitigations

---

## Rowhammer Attacks on DRAM

**Goal:** Induce targeted bit flips in DRAM rows adjacent to repeatedly accessed rows — without direct memory access — to corrupt data, escalate privileges, or extract cryptographic keys; and design architectural and software countermeasures to prevent the disturbance.

Kim et al. (ISCA 2014) discovered that hammering a DRAM row (accessing it tens of thousands of times per refresh interval) causes capacitive coupling that flips bits in physically adjacent rows. Google Project Zero (2015) turned this into a privilege-escalation exploit on Linux; subsequent work showed cross-VM attacks in cloud settings, bypass of ECC DRAM, and bit flips in cryptographic keys. "Curious Case of Rowhammer" (CHES 2016) targeted an RSA private exponent stored in memory, combining Prime+Probe cache timing to locate the key and rowhammer to flip specific bits, yielding full key recovery. Later work (Fault+Probe, 2024) recovered 256-bit ECDSA keys from wolfSSL with 100% success. Defenses include Target Row Refresh (TRR), doubled DRAM refresh rates, PARA probabilistic adjacent-row activation, and memory isolation in hypervisors.

| Attack / Defense | Year | Basis | Note |
|-----------------|------|-------|------|
| **Kim et al. DRAM Disturbance Errors** | 2014 | DRAM capacitive coupling | First systematic characterisation of rowhammer bit flips; 110/129 DRAM modules vulnerable; ISCA 2014 [[1]](https://users.ece.cmu.edu/~yoonguk/papers/kim-isca14.pdf) |
| **Rowhammer Privilege Escalation (Seaborn-Dullien)** | 2015 | Bit flip + page table | First exploit achieving kernel privilege escalation via page-table bit flip; demonstrated on Linux x86 [[1]](https://blackhat.com/docs/us-15/materials/us-15-Seaborn-Exploiting-The-DRAM-Rowhammer-Bug-To-Gain-Kernel-Privileges.pdf) |
| **Curious Case of Rowhammer (RSA key flip)** | 2016 | Prime+Probe + rowhammer | Combines cache-timing to locate RSA exponent in memory then flips a secret-exponent bit; CHES 2016 [[1]](https://eprint.iacr.org/2016/618) |
| **Fault+Probe (ECDSA recovery)** | 2024 | Rowhammer + lattice reduction | Recovers 256-bit ECDSA private key from wolfSSL via controlled bit flips; 100% success rate [[1]](https://arxiv.org/abs/2406.06943) |
| **Target Row Refresh (TRR) / PARA** | 2014+ | DRAM controller | Proactively refresh neighbours of frequently-accessed rows; PARA adds probabilistic refresh; standard in DDR4/5 [[1]](https://arxiv.org/abs/1904.09724) |

**State of the art:** DDR4/5 mandates TRR; ECC DRAM reduces but does not eliminate risk (multi-bit flips bypass single-bit ECC). Rowhammer on PQC keys (lattice schemes) is an open research frontier. Related to [Cold Boot Attacks](#cold-boot-attacks-on-dram) and [Fault Injection Attacks](#fault-injection-attacks-countermeasures).

**Production readiness:** Experimental
DDR4/5 TRR is deployed but bypassable; comprehensive software defenses remain experimental

**Implementations:**
- [TRRespass (rowhammer test)](https://github.com/vusec/trrespass) ⭐ 128 — C, tool for testing DRAM modules for TRR-bypassing rowhammer
- [Blacksmith (rowhammer fuzzer)](https://github.com/comsec-group/blacksmith) ⭐ 250 — C++, rowhammer pattern fuzzer for DDR4
- [DRAMA (reverse engineering DRAM)](https://github.com/IAIK/drama) ⭐ 194 — C, DRAM address mapping reverse engineering tool

**Security status:** Caution
TRR reduces but does not eliminate risk; multi-sided rowhammer bypasses TRR in many DDR4 modules; ECC DRAM can be bypassed with multi-bit flips

**Community acceptance:** Widely trusted
ISCA 2014 landmark paper; active research at top venues (IEEE S&P, USENIX, CCS); JEDEC DDR5 includes improved mitigations

---

## Hardware Security Modules (HSM) & FIPS 140-3

**Goal:** Provide a tamper-resistant, auditable boundary for all cryptographic key operations. An HSM performs key generation, storage, signing, decryption, and key wrapping entirely inside a physically and logically protected module — secret key material never leaves the hardware boundary in plaintext. FIPS 140-3 (ISO/IEC 19790) defines four security levels for validation by NIST's Cryptographic Module Validation Program (CMVP).

| Scheme / Standard | Year | Basis | Note |
|------------------|------|-------|------|
| **FIPS 140-1** | 1994 | NIST standard | Original US federal standard for cryptographic modules; four levels (physical, logical, role-based access, key management) [[1]](https://csrc.nist.gov/pubs/fips/140-1/final) |
| **FIPS 140-2** | 2001 | NIST + ISO/IEC 19790:2006 | Revised standard; dominant HSM certification baseline until 2026 transition deadline; Level 3/4 require tamper-evidence and response [[1]](https://csrc.nist.gov/pubs/fips/140-2/final) |
| **FIPS 140-3 / ISO 19790:2012** | 2019 | ISO/IEC 19790 + 24759 | Third edition aligned with international standard; adds software/firmware testing (ISO 10007); CMVP accepts new submissions from 2022 [[1]](https://csrc.nist.gov/pubs/fips/140-3/final) |
| **Thales Luna Network HSM** | 2020+ | FIPS 140-2 Level 3 | Widely deployed network HSM; hardware-enforced key custody, M-of-N quorum activation, and key ceremony support [[1]](https://cpl.thalesgroup.com/encryption/hardware-security-modules/network-hsms) |
| **AWS CloudHSM / Azure Dedicated HSM** | 2018+ | FIPS 140-2 Level 3 | Cloud-hosted, customer-owned HSM partitions; no cloud-provider key access; supports PKCS#11, JCE, CNG APIs [[1]](https://aws.amazon.com/cloudhsm/) |

**State of the art:** FIPS 140-3 is the current validation target; all new CMVP certificates are issued under it. Cloud HSM-as-a-service (AWS, Azure, GCP) makes FIPS 140-3 Level 3 hardware accessible without on-premises deployment. Post-quantum algorithm support in HSMs (ML-KEM, ML-DSA) is an active 2024–2025 integration effort. Complements [Anti-Tamper & Zeroization](#anti-tamper-mechanisms-cryptographic-zeroization) and [Hardware TRNGs](#hardware-true-random-number-generators-trngs).

**Production readiness:** Production
HSMs are mandatory infrastructure for banking, PKI, and cloud key management; FIPS 140-3 is the current certification standard

**Implementations:**
- [SoftHSM](https://github.com/opendnssec/SoftHSMv2) ⭐ 993 — C++, software PKCS#11 HSM for development and testing
- [pkcs11-tool (OpenSC)](https://github.com/OpenSC/OpenSC) ⭐ 3.0k — C, PKCS#11 command-line tool for HSM interaction
- [Nitrokey HSM](https://github.com/OpenSC/OpenSC/wiki/Nitrokey-HSM) ⭐ 3.0k — Open-source smart card HSM with PKCS#11 interface

**Security status:** Secure
FIPS 140-3 Level 3/4 certified HSMs undergo rigorous CMVP evaluation; tamper-evidence and zeroization provide strong physical security

**Community acceptance:** Standard
NIST FIPS 140-3 / ISO 19790 is the global certification standard; mandated for US federal systems; adopted by banking (PCI DSS) and PKI globally

---

## ML Modeling Attacks on Strong PUFs & ML-Based Privacy Attacks

**Goal:** (a) Break Strong PUF authentication by training a machine-learning model on a polynomial number of challenge-response pairs (CRPs) to clone the PUF's input-output behaviour without physical access to the device; and (b) attack ML models themselves through model extraction (IP theft via query APIs) and membership inference (determine whether a record was in the training set).

**Strong PUF modeling attacks.** Rührmair et al. (CCS 2010) showed that Arbiter PUFs, XOR Arbiter PUFs, and Lightweight Secure PUFs can be broken with logistic regression and evolution strategies using as few as 10 000 CRPs — rendering them unsuitable for unprotected authentication. Deep-learning attacks (eprint 2019) further reduced the CRP budget for complex XOR Arbiter PUF compositions by orders of magnitude. This has driven a shift from Strong PUFs toward Weak PUFs (limited CRP space, e.g., SRAM PUF) for key storage, or PUF constructions specifically designed to resist ML (e.g., IPUF, XORPUF with obfuscated responses).

**Model extraction.** Tramèr et al. (USENIX Security 2016) formalised model extraction attacks, where an adversary with black-box prediction-API access reconstructs a functionally equivalent copy of a proprietary ML model using structured queries. Near-perfect extraction of logistic regression, neural network, and decision tree models was demonstrated against Amazon and BigML services with modest query budgets. Cryptographic defences include model watermarking (see [AI Watermarking](#cryptographic-watermarking-for-ai-pseudorandom-codes)), output perturbation, and rate limiting.

**Membership inference.** Shokri et al. (IEEE S&P 2017) showed that shadow-model training allows an adversary to determine, given black-box access to a trained model, whether a specific data record was in its training set — leaking private information about individuals. Differential privacy during training is the principal cryptographic mitigation.

| Attack / Defense | Year | Basis | Note |
|-----------------|------|-------|------|
| **Rührmair et al. PUF Modeling (CCS 2010)** | 2010 | Logistic regression / ES | First systematic ML attack on Arbiter, XOR-Arbiter, and FF-Arbiter PUFs; CCS 2010 [[1]](https://dl.acm.org/doi/10.1145/1866307.1866335) |
| **Deep Learning PUF Attacks (eprint 2019)** | 2019 | Deep neural networks | DNN attacks on XOR-Arbiter and Interpose PUF compositions; order-of-magnitude fewer CRPs needed [[1]](https://eprint.iacr.org/2019/566) |
| **Tramèr et al. Model Extraction** | 2016 | Query-based model inversion | Steal logistic-regression / NN / DT models via prediction API; near-perfect fidelity; USENIX Sec 2016 [[1]](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/tramer) |
| **Shokri et al. Membership Inference** | 2017 | Shadow-model training | Determine training-set membership from black-box model predictions; IEEE S&P 2017 [[1]](https://ieeexplore.ieee.org/document/7958568/) |
| **Differential Privacy (Abadi et al. DP-SGD)** | 2016 | DP training | Adds calibrated noise during SGD to bound per-record gradient influence; principal mitigation for membership inference; CCS 2016 [[1]](https://dl.acm.org/doi/10.1145/2976749.2978318) |

**State of the art:** ML modeling attacks have rendered classic Strong PUFs cryptographically broken for most authentication use cases; SRAM PUF with fuzzy extractors and helper-data schemes (see [PUF](#physical-unclonable-functions-puf)) are the current standard. For ML model privacy, DP-SGD is the de-facto training-time defence; model watermarking addresses post-theft attribution. Intersects [PUF](#physical-unclonable-functions-puf), [AI Watermarking](#cryptographic-watermarking-for-ai-pseudorandom-codes), and [Speculative Execution Side-Channel Attacks](#speculative-execution-cache-timing-side-channel-attacks).

**Production readiness:** Research
Attack tools and defenses are academic research prototypes; Strong PUF authentication is largely abandoned in practice due to these attacks

**Implementations:**
- [pypuf](https://github.com/nils-wisiol/pypuf) ⭐ 92 — Python, PUF simulation and ML attack library (LR, DNN attacks)
- [ART (Adversarial Robustness Toolbox)](https://github.com/Trusted-AI/adversarial-robustness-toolbox) ⭐ 5.9k — Python, includes membership inference and model extraction attacks

**Security status:** Broken
Classic Strong PUFs (Arbiter, XOR-Arbiter) are broken by ML modeling attacks; membership inference is a proven privacy threat against undefended models

**Community acceptance:** Widely trusted
CCS 2010 and USENIX Security 2016 landmark papers; well-established threat models; results drove shift to SRAM PUFs and DP-SGD

---

## White-Box Cryptography (WBC)

**Goal:** Implement a cryptographic algorithm such that the secret key cannot be extracted even when the attacker has full control of the execution environment — arbitrary code inspection, memory dumps, and dynamic tracing. Used to protect keys embedded in software running on untrusted host platforms (DRM, mobile payments).

White-box cryptography was introduced by Chow, Eisen, Johnson, and van Oorschot (SAC 2002), who proposed "white-box AES": a network of precomputed, key-dependent lookup tables that evaluates AES correctly but obscures the key within the composition. The construction was broken by Billet, Gilbert, and Ech-Chatbi (SAC 2004) using an algebraic attack requiring ~2^30 work. A sequence of ever-stronger proposals and breaks continued over two decades; the BGE-style affine-equivalence attack framework and the CHES 2016 differential computation analysis (DCA) attack showed that all table-based white-box AES constructions are vulnerable to side-channel-style statistical analysis of intermediate lookup values. Rigorous theoretical WBC based on program obfuscation (iO) is possible but practically unusable. Practical deployments (e.g., Apple FairPlay, Widevine L3) rely on security-by-obscurity combined with diversity and renewability rather than provable security.

| Scheme / Attack | Year | Basis | Note |
|----------------|------|-------|------|
| **Chow et al. White-Box AES** | 2002 | Key-dependent lookup tables | First WBC construction; encodes AES key into T-boxes and mixing bijections; SAC 2002 [[1]](https://link.springer.com/chapter/10.1007/3-540-36492-7_17) |
| **BGE Attack (Billet-Gilbert-Ech-Chatbi)** | 2004 | Affine equivalence | Breaks Chow WB-AES in ~2^30 operations via algebraic analysis of table structure; SAC 2004 [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_16) |
| **Differential Computation Analysis (DCA)** | 2016 | Statistical analysis | Applies DPA methodology to computation traces (memory accesses, intermediate values) of white-box implementations; breaks all published WB-AES variants; CHES 2016 [[1]](https://eprint.iacr.org/2015/753) |
| **SPACE / Incompressible WBC** | 2017 | Provable hardness | WBC scheme provably hard under random oracle and one-wayness assumptions; first scheme with formal security reduction [[1]](https://eprint.iacr.org/2017/876) |
| **iO-Based White-Box Crypto** | 2021 | Indistinguishability obfuscation | WBC with provable security from iO and PRF; theoretically optimal but iO is not practically efficient [[1]](https://eprint.iacr.org/2021/1332) |

**State of the art:** No practically efficient WBC construction with a concrete security proof against all known attacks exists; the CHES 2016 DCA attack broke the entire table-based paradigm. Industry deployments rely on renewability (frequent key updates), code diversity, and LLVM-level obfuscation passes. Provably secure WBC from iO remains a theoretical landmark. Related to [Obfuscation / iO](16-obfuscation-advanced-hardness.md#indistinguishability-obfuscation-io) and [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures).

**Production readiness:** Experimental
Deployed in DRM (Apple FairPlay, Widevine L3) via security-by-obscurity; no provably secure practical construction exists

**Implementations:**
- [SideChannelMarvels WB tools](https://github.com/SideChannelMarvels/Deadpool) ⭐ 677 — Python/C, DCA and DFA attack tools for white-box implementations
- [CHES 2016 WB challenge solutions](https://github.com/SideChannelMarvels/JeanGrey) ⭐ 362 — Python, automated DCA attack on white-box AES

**Security status:** Broken
All published table-based WB-AES constructions are broken by DCA (CHES 2016); practical deployments rely on obscurity and renewability, not cryptographic proofs

**Community acceptance:** Controversial
No construction with both practical efficiency and concrete security proof; CHES WB challenges consistently broken; industry uses it despite lack of provable security

---

## Smart Card & Secure Element Cryptography

**Goal:** Execute cryptographic operations and store secret keys within a tamper-resistant microcontroller whose physical and logical defenses prevent key extraction even under invasive attack. Smart cards and secure elements (SE) are the ubiquitous form factor for EMV payment, SIM/eSIM, passports, PIV/CAC identity cards, and mobile NFC payments.

| Scheme / Standard | Year | Basis | Note |
|------------------|------|-------|------|
| **ISO/IEC 7816 Smart Card Standard** | 1987+ | Contact interface + APDU | Defines electrical interface, file system, and APDU command set; foundation for all contact smart cards [[1]](https://www.iso.org/standard/54550.html) |
| **EMV (Europay-Mastercard-Visa)** | 1994+ | RSA / ECC + symmetric | Chip-and-PIN payment standard; card generates a dynamic authentication cryptogram using a DES/AES session key; see also [EMV](20-applied-niche-protocols.md#incremental-cryptography) [[1]](https://www.emvco.com/emv-technologies/contact/) |
| **GlobalPlatform Secure Element API** | 2003+ | Java Card + SCP02/03 | Industry standard for SE OS, applet lifecycle management, and secure channel protocol (AES-based SCP03) [[1]](https://globalplatform.org/specs-library/) |
| **ARM TrustZone-M for IoT SE** | 2016+ | Hardware isolation | Cortex-M33 TrustZone separates Normal and Secure world on microcontrollers; used as lightweight SE in IoT devices; PSA Certified Level 2 [[1]](https://developer.arm.com/ip-products/security-ip/trustzone) |
| **Apple Secure Enclave Processor (SEP)** | 2013+ | Dedicated security core | On-SoC AES engine + UID key fused at manufacture; Face/Touch ID templates and payment keys isolated from application processor; never exposed via software API [[1]](https://support.apple.com/guide/security/secure-enclave-sec59b0b31ff/web) |

**State of the art:** Common Criteria EAL 5+ (with AVA_VAN.5 attack potential) is the standard certification target for payment and passport SEs; the NXP P71 and Infineon SLx 9xxx families are representative. eSIM (GSMA SGP.02/22) extends SE concepts to remotely provisioned SIM profiles. Complements [HSM & FIPS 140-3](#hardware-security-modules-hsm-fips-140-3), [PUF](#physical-unclonable-functions-puf), and [Anti-Tamper & Zeroization](#anti-tamper-mechanisms-cryptographic-zeroization).

**Production readiness:** Production
Billions of smart cards deployed for EMV payments, SIM/eSIM, passports, and government ID worldwide

**Implementations:**
- [GlobalPlatformPro](https://github.com/martinpaljak/GlobalPlatformPro) ⭐ 873 — Java, command-line tool for managing GlobalPlatform smart cards
- [OpenSC](https://github.com/OpenSC/OpenSC) ⭐ 3.0k — C, PKCS#11/15 tool for smart card and secure element access
- [JavaCard SDK](https://github.com/ph4r05/javacard-gradle-template) ⭐ 64 — Java, JavaCard applet development framework

**Security status:** Secure
Common Criteria EAL 5+ with AVA_VAN.5 provides strong assurance; decades of real-world deployment with few successful attacks on certified products

**Community acceptance:** Standard
ISO 7816, EMVCo, GlobalPlatform, and Common Criteria define the ecosystem; universal deployment in banking, telecom, and government identity

---

## Cryptographic Hardware Accelerators (AES-NI, SHA-NI, AVX-512 VAES)

**Goal:** Offload symmetric cryptographic primitives from general-purpose integer units to dedicated silicon, achieving throughput many times faster than software implementations while also closing timing side channels by executing in data-independent, constant-time hardware.

| Instruction Set / Accelerator | Year | Basis | Note |
|------------------------------|------|-------|------|
| **Intel AES-NI (Westmere)** | 2010 | x86 ISA extension | Six instructions (AESENC, AESENCLAST, AESDEC, AESDECLAST, AESKEYGENASSIST, AESIMC); single AES round in one clock; ~0.8 cycles/byte in AES-GCM; eliminates cache-timing vulnerability [[1]](https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-encryption-standard-instructions-aes-ni.html) |
| **Intel SHA Extensions (Goldmont)** | 2016 | x86 ISA extension | SHA-1 and SHA-256 message schedule + compression round instructions; 3–4× speedup over software; AMD Ryzen support from 2017 [[1]](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sha-extensions.html) |
| **AVX-512 VAES / VPCLMULQDQ** | 2019 | AVX-512 width | Vectorised AES-NI operating on 512-bit (four AES blocks simultaneously); enables >100 Gbps AES-GCM on a single core; Icelake+ and Zen 4 [[1]](https://eprint.iacr.org/2020/1333) |
| **ARM Cryptography Extensions (ARMv8-A)** | 2011+ | AArch64 ISA | AES and SHA-1/256/512 instructions; present in all Cortex-A53/A72+; enables constant-time crypto on mobile and server ARM [[1]](https://developer.arm.com/documentation/ddi0596/2021-12/SIMD-FP-Instructions) |
| **NIST PQC Accelerators (NTT / Keccak)** | 2023+ | FPGA / ASIC | Dedicated NTT and Keccak-f hardware for ML-KEM/ML-DSA acceleration; academic and commercial designs achieving microsecond-latency PQC operations [[1]](https://eprint.iacr.org/2023/062) |

**State of the art:** AES-NI is universal in x86 and ARM server/mobile CPUs; AVX-512 VAES achieves line-rate encryption on 100 GbE NICs. OpenSSL, BoringSSL, and libsodium automatically dispatch to hardware paths. NTT accelerators for ML-KEM are entering commercial silicon (2024–2025). Closely related to [Speculative Execution & Cache-Timing Side-Channel Attacks](#speculative-execution-cache-timing-side-channel-attacks) (hardware acceleration eliminates the table-lookup timing channel) and [Hardware TRNGs](#hardware-true-random-number-generators-trngs).

**Production readiness:** Production
AES-NI and ARM Crypto Extensions present in every modern x86 and ARM CPU; AVX-512 VAES in server processors since 2019

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C/ASM, automatic AES-NI/SHA-NI dispatch
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C/ASM, hardware-accelerated AES/SHA/GHASH
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, AES-256-GCM via AES-NI
- [Intel IPP Cryptography](https://github.com/intel/ipp-crypto) ⭐ 376 — C/ASM, optimized crypto for Intel platforms including AVX-512 VAES

**Security status:** Secure
Hardware instructions are constant-time by design; eliminates table-lookup timing channel; formally verified execution for AES-NI

**Community acceptance:** Standard
Intel, AMD, and ARM ship hardware crypto in all current CPUs; NIST SP 800-175B recommends hardware acceleration; universal adoption in crypto libraries

---

## Anti-Tamper Mechanisms & Cryptographic Zeroization

**Goal:** Detect physical intrusion into a cryptographic module and immediately destroy all secret key material before an attacker can extract it — eliminating the threat of key recovery from a captured device. Zeroization must be faster than the fastest plausible attack and operate even under power removal, extreme temperature, or partial circuit damage.

| Mechanism / Standard | Year | Basis | Note |
|--------------------|------|-------|------|
| **FIPS 140-2 Level 4 Zeroization Requirements** | 2001 | NIST standard | Mandates complete destruction of all plaintext key material upon detection of any environmental attack; defines envelope monitoring and zeroization circuits [[1]](https://csrc.nist.gov/pubs/fips/140-2/final) |
| **Mesh-and-Detect Security Enclosures** | 1990s+ | Conductive mesh | A fine conductive mesh woven around the PCB; any drill or probe attempt breaks a trace and triggers immediate zeroization of battery-backed key RAM [[1]](https://ieeexplore.ieee.org/document/8474192) |
| **Battery-Backed SRAM Key Storage (Zeroization)** | 2000s+ | Volatile SRAM + supercap | Keys held in battery-backed SRAM; tamper detection kills power and the volatile RAM self-destructs; used in HSMs (e.g., IBM 4758) [[1]](https://ieeexplore.ieee.org/document/910325) |
| **Voltage / Temperature Glitch Zeroization** | 2010s+ | Environmental monitors | On-die sensors detect supply voltage and temperature excursions indicative of fault injection; triggers instant zeroization before fault takes effect [[1]](https://link.springer.com/chapter/10.1007/978-3-319-66787-4_14) |
| **NSA Type 1 Fill Device Zeroization (KYK-13 / DTD)** | 1980s+ | Classified hardware | U.S. classified key-fill devices implement multi-layer zeroization; button-triggered and automatic on tamper; destroys keying material in < 1 ms [[1]](https://www.cryptomuseum.com/crypto/usa/kyk13/) |

**State of the art:** Modern FIPS 140-3 Level 3/4 HSMs combine mesh sensing, voltage/temperature monitoring, and cryptographic erasure of key RAM in under 1 ms. The IBM 4765 and Thales payShield 10K are representative certified platforms. Zeroization is complementary to [Fault Injection Countermeasures](#fault-injection-attacks-countermeasures) and [HSM & FIPS 140-3](#hardware-security-modules-hsm-fips-140-3); both address the physical attack surface of deployed cryptographic hardware.

**Production readiness:** Production
Mandatory in FIPS 140-3 Level 3/4 certified HSMs; deployed in banking, military, and government hardware

**Implementations:**
- [IBM 4769 Crypto Coprocessor](https://www.ibm.com/products/pcie-cryptographic-coprocessor) — Hardware, FIPS 140-2 Level 4 certified with zeroization
- [Zymbit HSM6](https://www.zymbit.com/hsm6/) — Hardware, tamper-detect + zeroization module for embedded Linux

**Security status:** Secure
Zeroization in < 1 ms on tamper detection is effective against known physical attacks; validated under FIPS 140-3 and Common Criteria

**Community acceptance:** Standard
FIPS 140-3 Level 3/4 mandates zeroization; Common Criteria EAL 4+ requires tamper evidence; universal requirement for payment and government crypto modules

---

## GPU-Based Cryptographic Acceleration (CUDA AES, GPU FHE)

**Goal:** Exploit the massive parallelism of modern graphics processing units to accelerate cryptographic workloads — especially fully homomorphic encryption (FHE), large-number arithmetic, and bulk symmetric encryption — achieving throughputs and latencies impossible on CPU alone. GPUs execute thousands of threads simultaneously, mapping well onto the embarrassingly parallel structure of NTT, CKKS, and AES-CTR.

| Scheme / Implementation | Year | Basis | Note |
|------------------------|------|-------|------|
| **GPU-AES (Manavski)** | 2007 | CUDA + AES-128 ECB | First CUDA AES implementation; 8× speedup over CPU for independent block encryption; established GPU as viable crypto accelerator [[1]](https://link.springer.com/chapter/10.1007/978-3-540-79353-2_10) |
| **cuHE (Dai-Sunar)** | 2015 | CUDA + HE NTT | GPU-accelerated HE library; custom NTT on CUDA; first GPU library enabling practical BGV/BFV-style operations [[1]](https://eprint.iacr.org/2015/818) |
| **TFHE-rs GPU Backend** | 2023 | CUDA + TFHE bootstrapping | GPU-accelerated bootstrapping for TFHE; ~30× speedup over CPU single-core; enables sub-100 ms gate bootstrapping on RTX 3090 [[1]](https://eprint.iacr.org/2023/522) |
| **GPU-CKKS (100 Gbps FHE)** | 2024 | CUDA + CKKS NTT | NTT-centric CKKS implementation on NVIDIA H100; achieves 100× speedup over CPU for CKKS multiplication; enables near-practical FHE-ML inference [[1]](https://eprint.iacr.org/2024/548) |
| **cuBLAS-Lattice / NTT on H100** | 2025 | Tensor Core repurposing | Repurposes H100 Tensor Cores for NTT-based lattice arithmetic; orders-of-magnitude speedup for ML-KEM/ML-DSA key generation in cloud settings [[1]](https://eprint.iacr.org/2025/131) |

**State of the art:** NVIDIA H100 GPUs with custom CUDA NTT kernels currently deliver the fastest FHE throughputs available; TFHE-rs and OpenFHE both ship GPU backends. GPU FHE acceleration is central to making [HE-based private ML inference](#secure-mpc-he-for-private-ml-inference) practical. Complements [Cryptographic Hardware Accelerators](#cryptographic-hardware-accelerators-aes-ni-sha-ni-avx-512-vaes) (CPU-centric) and [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference).

**Production readiness:** Experimental
GPU FHE backends (TFHE-rs, OpenFHE) are functional; GPU AES is niche due to CPU AES-NI sufficiency; H100-based CKKS is cutting-edge

**Implementations:**
- [TFHE-rs (Zama)](https://github.com/zama-ai/tfhe-rs) ⭐ 1.6k — Rust/CUDA, TFHE library with GPU-accelerated bootstrapping
- [OpenFHE GPU](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++/CUDA, OpenFHE with optional GPU backend for NTT
- [cuFHE](https://github.com/vernamlab/cuFHE) ⭐ 239 — CUDA, GPU-accelerated TFHE gate bootstrapping

**Security status:** Secure
Underlying cryptographic operations are identical to CPU versions; GPU memory isolation (H100 CC) addresses GPU-specific attack surface

**Community acceptance:** Emerging
Active research area; NVIDIA and Zama driving GPU FHE; no formal standard for GPU crypto; growing adoption in private AI inference

---

## AI Hardware Trojans (Backdoor Attacks on Neural Accelerators)

**Goal:** Detect and prevent malicious logic secretly inserted into AI accelerator chips during design or manufacturing. A hardware trojan is a stealthy modification — added gates, altered weights in fixed-function neural networks, or backdoored training pipelines embedded in ASIC/FPGA bitstreams — that causes the hardware to misbehave under rare, attacker-chosen conditions while appearing correct in standard testing.

| Attack / Defense | Year | Basis | Note |
|----------------|------|-------|------|
| **Wang et al. Hardware Trojan Survey** | 2008 | Taxonomy | First systematic taxonomy of hardware trojans by location (RTL, gate, layout) and activation trigger; standard reference for the threat model [[1]](https://ieeexplore.ieee.org/document/4559489) |
| **BadNets (Gu et al.)** | 2019 | Training-time backdoor | Supply-chain attack on the ML training pipeline; inject trigger pattern into training data so the trained DNN misclassifies trigger-present inputs [[1]](https://arxiv.org/abs/1708.06733) |
| **TrojanNN (Liu et al.)** | 2018 | Weight modification | Insert trojan by directly modifying a subset of neural network weights after training; no training-data access required [[1]](https://arxiv.org/abs/1712.05526) |
| **DeepInspect (Chen et al.)** | 2019 | Generative model detection | Detect trojaned models by inverting the suspected trigger using a generative model; model-agnostic; IEEE S&P 2019 [[1]](https://ieeexplore.ieee.org/document/8835365) |
| **Hardware Trojan Detection via Side-Channel (Jin-Makris)** | 2008 | Power fingerprinting | Detect inserted trojan gates by comparing power trace fingerprints against golden reference at test time [[1]](https://ieeexplore.ieee.org/document/4561401) |
| **AICAS Trojan-Resistant Training** | 2023 | Certified training | Adversarial certified training with formal bounds on trojan-trigger success rate; extends certified robustness to hardware supply-chain threats [[1]](https://arxiv.org/abs/2210.03386) |

**State of the art:** BadNets-style training-time trojans remain a potent supply-chain threat; detection methods (STRIP, Neural Cleanse, DeepInspect) achieve good detection rates but no universal defense exists. Hardware-level trojan detection for AI accelerator ASICs (NPUs, TPUs) via side-channel fingerprinting is an active research area (2024–2025). Related to [Supply Chain Attacks on Cryptographic Hardware](#supply-chain-attacks-on-cryptographic-hardware) and [Federated Learning Security](#federated-learning-security-poisoning-byzantine-robustness).

**Production readiness:** Research
Attack demonstrations and detection tools are academic prototypes; no production-grade trojan detection for AI accelerators exists

**Implementations:**
- [TrojAI (IARPA/NIST)](https://github.com/usnistgov/trojai) ⭐ 14 — Python, NIST trojan detection evaluation framework
- [Neural Cleanse](https://github.com/bolunwang/backdoor) ⭐ 314 — Python/PyTorch, backdoor detection via trigger reverse-engineering
- [ABS (Artificial Brain Stimulation)](https://github.com/naiyeleo/ABS) ⭐ 51 — Python, trojan detection by neuron stimulation analysis

**Security status:** Caution
No universal trojan detection method exists; detection tools achieve good rates on known trigger types but adversarial evasion is possible

**Community acceptance:** Emerging
IARPA TrojAI program and NIST evaluation track; active IEEE S&P and USENIX research; growing supply-chain security concern

---

## Supply Chain Attacks on Cryptographic Hardware

**Goal:** Understand and defend against adversarial modifications or substitutions introduced at any stage of a cryptographic hardware device's life cycle — design, fabrication, packaging, distribution, or firmware update — that subvert the device's cryptographic properties without visible physical alteration.

| Attack / Defense | Year | Basis | Note |
|----------------|------|-------|------|
| **NSA/GCHQ Cisco Router Interdiction (Snowden)** | 2014 | Physical implant in transit | Intelligence agencies intercepted Cisco routers during shipping, installed hardware implants, resealed packaging; disclosed via Snowden documents [[1]](https://www.theguardian.com/books/2014/may/12/glenn-greenwald-no-place-to-hide-edward-snowden-nsa-review) |
| **Bloomberg Supermicro Claim** | 2018 | Alleged PCB implant | Alleged implant chips added to Supermicro server motherboards during manufacturing; disputed but galvanised supply-chain security research and policy [[1]](https://www.bloomberg.com/news/articles/2018-10-04/the-big-hack-how-china-used-a-tiny-chip-to-infiltrate-america-s-top-companies) |
| **Kleptographic TRNG Backdoor Threat (Bernstein et al.)** | 2022 | Kleptography | Formalises the threat of a subverted HSM or TRNG deliberately weakening key generation; extends kleptography to post-quantum settings [[1]](https://eprint.iacr.org/2022/1168) |
| **NIST SP 800-161r1 (C-SCRM)** | 2022 | Risk management framework | U.S. federal framework for cybersecurity supply chain risk management; defines controls for hardware acquisition, inspection, and provenance [[1]](https://csrc.nist.gov/pubs/sp/800/161/r1/final) |
| **DICE / RIoT Device Identity** | 2021 | HW attestation + PKI | Devices carry manufacturer-provisioned identity certificates enabling cryptographic verification of device provenance before deployment; embedded in TPM 2.0 and Azure IoT supply chains [[1]](https://www.microsoft.com/en-us/research/project/dice-device-identifier-composition-engine/) |

**State of the art:** NIST SP 800-161r1 and CISA Supply Chain Risk Management guidelines are the operative U.S. standards; DICE/RIoT attestation chains are now embedded in TPM 2.0 and Azure Sphere. Hardware-rooted identity (see [TEE Remote Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation)) is the primary cryptographic defense. Intersects [Anti-Tamper & Zeroization](#anti-tamper-mechanisms-cryptographic-zeroization), [HSM & FIPS 140-3](#hardware-security-modules-hsm-fips-140-3), and [AI Hardware Trojans](#ai-hardware-trojans-backdoor-attacks-on-neural-accelerators).

**Production readiness:** Mature
NIST SP 800-161r1 and DICE/RIoT attestation are operational frameworks; hardware-rooted identity deployed in TPM 2.0 and Azure Sphere

**Implementations:**
- [OpenTitan (open-source RoT)](https://github.com/lowRISC/opentitan) ⭐ 3.3k — SystemVerilog/C, open-source silicon root of trust with supply-chain integrity features
- [in-toto](https://github.com/in-toto/in-toto) ⭐ 987 — Python, software supply-chain integrity framework applicable to firmware
- [DICE Engine (TCG spec)](https://trustedcomputinggroup.org/work-groups/dice-architectures/) — Specification, TCG Device Identifier Composition Engine

**Security status:** Caution
Hardware-rooted attestation is effective when available; physical supply-chain attacks (interdiction, implants) remain difficult to detect post-deployment

**Community acceptance:** Standard
NIST SP 800-161r1 is the US federal standard; CISA Supply Chain Risk Management; TCG DICE standardized; growing international adoption

---

## Formal Verification of Cryptographic Hardware

**Goal:** Mathematically prove that a hardware implementation of a cryptographic algorithm is functionally correct, timing-side-channel free, and fault-resistant — without relying solely on simulation or testing. Formal methods (model checking, theorem proving, symbolic execution) exhaustively explore all reachable states of the RTL or gate-level netlist against a formal specification.

| Tool / Result | Year | Basis | Note |
|--------------|------|-------|------|
| **Bounded Model Checking of AES RTL (Currie et al.)** | 2004 | SAT-based BMC | First bounded model-checking verification of AES hardware; proves functional equivalence of RTL to spec within bounded computation depth [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30494-4_22) |
| **SILVER (Barthe et al.)** | 2021 | Masking + formal probing | Automated verification framework for masked hardware under the probing model; proves d-th order side-channel security of synthesised netlists; USENIX Sec 2021 [[1]](https://eprint.iacr.org/2020/1555) |
| **EasyCrypt / CoqCrypt** | 2009+ | Coq theorem prover | Machine-checked proofs of cryptographic protocol and implementation security; formally verified AES and ChaCha implementations in EasyCrypt [[1]](https://www.easycrypt.info/) |
| **Jasmin + Formosa Crypto** | 2022 | Verified assembly + Coq | End-to-end verified implementations: Jasmin compiles constant-time assembly proved correct and secret-independent; covers AES, ChaCha20, Kyber [[1]](https://formosa-crypto.org/) |
| **UPEC (Fadiheh et al.)** | 2022 | Symbolic execution + SMT | Unique-Program-Execution Checking; verifies absence of microarchitectural information-flow leakage (Spectre, Meltdown classes) in RTL using symbolic execution [[1]](https://ieeexplore.ieee.org/document/9218571) |
| **Formal Verification of Fault-Tolerant AES (Seuschek et al.)** | 2023 | Formal property verification | Property checking proves correctness of infective computation and duplication countermeasures in AES hardware under formal fault injection models [[1]](https://tches.iacr.org/index.php/TCHES/article/view/10282) |

**State of the art:** Jasmin/Formosa gives end-to-end verified, constant-time software crypto; SILVER verifies masked hardware netlists against the d-probing model. Formal verification of complete cryptographic ASICs remains computationally challenging — bounded methods cover large designs but cannot rule out bugs beyond the bounded depth. Interaction with [Power Analysis Attacks & Masking Countermeasures](#power-analysis-attacks-masking-countermeasures), [Fault Injection Attacks & Countermeasures](#fault-injection-attacks-countermeasures), and [Speculative Execution & Cache-Timing Side-Channel Attacks](#speculative-execution-cache-timing-side-channel-attacks).

**Production readiness:** Mature
Jasmin/Formosa and EasyCrypt produce verified crypto code; SILVER verifies masked hardware; full ASIC verification remains bounded

**Implementations:**
- [Jasmin compiler](https://github.com/jasmin-lang/jasmin) ⭐ 337 — OCaml, verified compiler for constant-time cryptographic assembly
- [Formosa Crypto](https://github.com/formosa-crypto) — Coq/Jasmin, machine-checked verified crypto implementations
- [EasyCrypt](https://github.com/EasyCrypt/easycrypt) ⭐ 384 — OCaml, computer-aided cryptographic proof framework
- [SILVER](https://github.com/Chair-for-Security-Engineering/SILVER) ⭐ 15 — Python, automated verification of masked hardware

**Security status:** Secure
Formally verified implementations have machine-checked correctness and side-channel freedom proofs; verification is sound under the formal model used

**Community acceptance:** Widely trusted
Published at top venues (USENIX, CCS, S&P); Formosa Crypto endorsed for PQC verification; growing adoption in NIST PQC reference implementations

---

## Confidential GPU Computing (NVIDIA H100 CC, Azure Confidential GPU)

**Goal:** Extend hardware-enforced confidential computing from CPU enclaves to GPU accelerators, so that AI inference and training workloads on GPUs are isolated from the host OS, hypervisor, and cloud operator. The GPU firmware authenticates itself and establishes an encrypted PCIe channel to the CPU TEE, making GPU memory and model weights invisible to the host even during computation.

| Scheme / Platform | Year | Basis | Note |
|-----------------|------|-------|------|
| **NVIDIA H100 Confidential Computing (CC mode)** | 2023 | On-die AES + attestation | First production GPU with hardware memory encryption and remote attestation; PCIe traffic encrypted between CPU TEE and GPU; protects model weights and activations from host [[1]](https://developer.nvidia.com/blog/confidential-computing-on-h100-gpus-for-secure-and-trustworthy-ai/) |
| **Azure NCC H100 v5 Confidential GPU VMs** | 2023 | AMD SEV-SNP + H100 CC | First cloud offering combining AMD SEV-SNP CPU isolation with H100 CC GPUs; end-to-end CPU+GPU confidential AI; generally available on Azure [[1]](https://techcommunity.microsoft.com/t5/azure-confidential-computing/introducing-azure-confidential-vms-with-nvidia-h100-gpus/ba-p/3835761) |
| **HETEE (Hua et al.)** | 2022 | PCIe + SGX + GPU | Research enclave architecture extending SGX trust to GPU via PCIe integrity and encryption; first formal design for GPU-TEE trust chains; CCS 2022 [[1]](https://dl.acm.org/doi/10.1145/3548606.3560640) |
| **NVIDIA OCSP GPU Attestation** | 2023 | ECDSA + OCSP chain | NVIDIA attestation infrastructure lets clients verify H100 CC mode is active before transmitting sensitive data; interoperates with RATS attestation and [TEE Remote Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation) [[1]](https://docs.nvidia.com/deploy/nvtrust/latest/attestation.html) |
| **Google Confidential GKE + A3 GPUs** | 2024 | GCP Confidential VMs + H100 | Google Kubernetes Engine confidential node pools with H100 GPUs; hardware-attested GPU isolation for GenAI workloads [[1]](https://cloud.google.com/blog/products/identity-security/confidential-computing-with-nvidia-gpus) |

**State of the art:** NVIDIA H100 in Confidential Computing mode is the current production standard; ~2–5% performance overhead from memory encryption is the cost of GPU-level isolation. Azure, Google, and AWS all offer confidential GPU VMs as of 2024. Interaction with [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference), [GPU-Based Cryptographic Acceleration](#gpu-based-cryptographic-acceleration-cuda-aes-gpu-fhe), and [TEE Remote Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation).

**Production readiness:** Production
NVIDIA H100 CC mode generally available on Azure, GCP, and AWS; 2-5% performance overhead

**Implementations:**
- [NVIDIA Confidential Computing docs](https://github.com/NVIDIA/gpu-operator) ⭐ 2.6k — Go/Python, NVIDIA GPU Operator with CC mode support for Kubernetes
- [Azure Confidential GPU VMs](https://github.com/Azure/confidential-computing-cvm-guest-attestation) ⭐ 81 — C++, guest attestation library for Azure confidential VMs including GPU
- [Veraison attestation verifier](https://github.com/veraison/veraison) ⭐ 53 — Go, CNCF attestation verifier supporting NVIDIA GPU attestation

**Security status:** Caution
Memory encryption and attestation are hardware-enforced; GPU TEE is a newer technology than CPU TEEs with less adversarial evaluation history

**Community acceptance:** Emerging
NVIDIA, Microsoft, Google backing; Confidential Computing Consortium includes GPU workloads; still maturing compared to CPU TEEs

---

## Federated Learning Secure Aggregation (SecAgg)

**Goal:** Allow a central server to compute the sum (or average) of model updates from many clients without learning any individual client's update. Cryptographic secure aggregation ensures that only the aggregate gradient is revealed — even if the server and a threshold of clients collude — using secret sharing, pairwise masking, or threshold homomorphic encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bonawitz et al. Practical SecAgg** | 2017 | Pairwise masking + Shamir SS | First practical secure aggregation for FL; each pair of clients shares a PRG seed; masks cancel in summation; tolerates up to 1/3 dropouts; CCS 2017 [[1]](https://dl.acm.org/doi/10.1145/3133956.3133982) |
| **Bell et al. SecAgg+** | 2020 | Sparse graph masking | Reduces per-client communication from O(n) to O(sqrt(n)) by replacing complete pairwise graph with sparse random graph; Google [[1]](https://dl.acm.org/doi/10.1145/3372297.3417885) |
| **FLAME SecAgg (Flamingo)** | 2023 | Single-server + decentralized | Single-server SecAgg with decentralised trust; removes need for trusted setup server; S&P 2023 [[1]](https://eprint.iacr.org/2023/486) |
| **LightSecAgg (Kadhe et al.)** | 2022 | One-shot masking | Each client generates a single mask independent of other clients; avoids pairwise seed agreement; communication-optimal [[1]](https://arxiv.org/abs/2109.14236) |
| **SecAgg with Verifiable Aggregation** | 2024 | MPC + SNARK | Adds ZK proof that the server computed the aggregate correctly; prevents server-side result manipulation [[1]](https://eprint.iacr.org/2024/831) |

**State of the art:** Bonawitz SecAgg is deployed in Google's production FL system (Gboard, Android); SecAgg+ reduces communication overhead for large federations. Verifiable variants (2024) add integrity guarantees. Bridges [Secret Sharing](05-secret-sharing-threshold-cryptography.md#secret-sharing-schemes-sss) and [Federated Learning Security](#federated-learning-security-poisoning-byzantine-robustness).

**Production readiness:** Production
Bonawitz SecAgg deployed in Google's production FL system (Gboard keyboard, Android); SecAgg+ reduces overhead

**Implementations:**
- [Flower SecAgg](https://github.com/adap/flower) ⭐ 6.8k — Python, FL framework with built-in SecAgg protocol support
- [TensorFlow Federated](https://github.com/google-parfait/tensorflow-federated) ⭐ 2.4k — Python, Google's FL framework with SecAgg integration
- [FedML SecAgg](https://github.com/FedML-AI/FedML) ⭐ 4.0k — Python, federated learning with secure aggregation support

**Security status:** Secure
Cryptographic SecAgg protocols have formal security proofs (CCS 2017); tolerates up to 1/3 dropout; pairwise masking ensures individual update privacy

**Community acceptance:** Widely trusted
CCS 2017 landmark paper; deployed at Google scale; implemented in major FL frameworks; growing standardization (IEEE P3652.1)

---

## Encrypted ML Frameworks (CrypTen, TF Encrypted, PySyft)

**Goal:** Provide developer-friendly frameworks that let ML engineers run training or inference on encrypted data using familiar APIs (PyTorch, TensorFlow, NumPy) while the framework transparently handles the underlying MPC, HE, or secret-sharing protocols. Lowers the barrier from cryptographic expertise to a single import.

| Framework | Year | Basis | Note |
|-----------|------|-------|------|
| **TF Encrypted** | 2018 | TensorFlow + 3-party MPC | Encrypted ML as a TensorFlow graph; uses ABY3-style 3-party secret sharing; supports linear and CNN layers [[1]](https://arxiv.org/abs/1810.08130) |
| **PySyft (OpenMined)** | 2018 | PyTorch + SMPC + DP | Open-source library for privacy-preserving ML; supports remote execution, MPC, and DP over PyTorch tensors [[1]](https://arxiv.org/abs/1811.04017) |
| **CrypTen (Meta AI)** | 2021 | PyTorch + 3-party SS | Secret-shared tensor operations with PyTorch-like API; supports training and inference; CrypTen autograd for backpropagation over encrypted values [[1]](https://arxiv.org/abs/2109.00984) |
| **Concrete ML (Zama)** | 2022 | TFHE + scikit-learn/PyTorch | Compile scikit-learn and PyTorch models to run entirely under TFHE encryption; quantization-aware training for FHE compatibility [[1]](https://github.com/zama-ai/concrete-ml) |
| **HELayers (IBM)** | 2023 | HElib + CKKS | Production-grade HE inference library; tile-tensor abstraction maps neural-network layers to CKKS ciphertext packing; supports CNNs and transformers [[1]](https://github.com/IBM/helayers) |

**State of the art:** CrypTen and Concrete ML are the most actively maintained frameworks (2024); Concrete ML uniquely compiles standard ML models to pure FHE without MPC. HELayers targets enterprise HE inference. All build on [HE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he) and [MPC](06-multi-party-computation.md#multi-party-computation-mpc).

**Production readiness:** Experimental
CrypTen and Concrete ML actively maintained; PySyft and TF Encrypted less active; none widely deployed in production ML pipelines

**Implementations:**
- [CrypTen (Meta AI)](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python/C++, PyTorch-based encrypted ML framework
- [PySyft (OpenMined)](https://github.com/OpenMined/PySyft) ⭐ 9.9k — Python, privacy-preserving ML with MPC and DP
- [Concrete ML (Zama)](https://github.com/zama-ai/concrete-ml) ⭐ 1.4k — Python, compile ML models to FHE
- [TF Encrypted](https://github.com/tf-encrypted/tf-encrypted) ⭐ 1.2k — Python, encrypted ML on TensorFlow
- [HELayers (IBM)](https://github.com/IBM/helayers) ⭐ 45 — C++/Python, HE inference library

**Security status:** Secure
Underlying MPC/HE/SS protocols have formal security proofs; framework-level bugs are possible but protocols are sound

**Community acceptance:** Emerging
Active open-source communities (Meta, OpenMined, Zama, IBM); no formal standard for encrypted ML APIs; growing adoption in healthcare and finance research

---

> **zkML (Zero-Knowledge Machine Learning)** is covered in [Zero-Knowledge Proof Systems — zkML](04-zero-knowledge-proof-systems.md#zkml-zero-knowledge-machine-learning).

---

## Model Watermarking & Fingerprinting for IP Protection

**Goal:** Embed a persistent, verifiable identifier into a trained ML model's weights or behaviour so that the model's owner can later prove ownership — even after the model has been fine-tuned, pruned, distilled, or extracted. Distinct from output watermarking (marking generated text/images): this watermarks the model itself.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Uchida et al. DNN Watermarking** | 2017 | Weight regularization | First DNN watermarking; embed a bit string into weight statistics via a regularization loss term; survives fine-tuning [[1]](https://dl.acm.org/doi/10.1145/3078971.3078974) |
| **Adi et al. Backdoor Watermark** | 2018 | Backdoor trigger | Embed a secret trigger set; the watermarked model classifies trigger inputs to a specific label; verifiable without model access (black-box) [[1]](https://www.usenix.org/conference/usenixsecurity18/presentation/adi) |
| **Conferrable / Dataset Inference (Maini et al.)** | 2021 | Dataset membership | Prove that a suspect model was trained on proprietary data by testing dataset-specific generalization patterns; no modification to model required [[1]](https://arxiv.org/abs/2104.10706) |
| **DNN Fingerprinting (Lukas et al.)** | 2021 | Adversarial examples as fingerprints | Generate model-specific adversarial examples that transfer to stolen copies but not independently trained models; USENIX Sec 2021 [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/lukas) |
| **Proof-of-Learning (Jia et al.)** | 2021 | Training transcript | Record cryptographic snapshots during training; prover demonstrates they performed the actual computation; S&P 2021 [[1]](https://ieeexplore.ieee.org/document/9519402) |

**State of the art:** Backdoor-based watermarking (Adi et al.) is the most robust to model modification; fingerprinting (Lukas et al.) requires no model modification at all. Proof-of-Learning addresses the complementary problem of proving training provenance. Related to [Cryptographic Watermarking for AI / Pseudorandom Codes](#cryptographic-watermarking-for-ai-pseudorandom-codes) and [Model Extraction Attacks & Defenses](#model-extraction-attacks-defenses).

**Production readiness:** Research
Academic prototypes; some commercial deployments (e.g., IBM AI watermarking); no universal standard or widely deployed system

**Implementations:**
- [Adi et al. backdoor watermark](https://github.com/adiyoss/WatermarkNN) ⭐ 99 — Python/PyTorch, backdoor-based DNN watermarking

**Security status:** Caution
Watermarks can be removed by fine-tuning, pruning, or distillation; fingerprints are more robust but require careful adversarial example generation

**Community acceptance:** Emerging
Active research at USENIX, IEEE S&P, NeurIPS; industry interest growing due to model theft concerns; no formal standard

---

## SRAM PUF Key Generation & Fuzzy Extractors

**Goal:** Derive stable, reproducible cryptographic keys from the inherently noisy power-up state of SRAM cells. Each SRAM cell has a preferred power-up value (0 or 1) determined by manufacturing variation, but ~5–15% of cells are unstable across reads. Fuzzy extractors and helper-data algorithms correct these noisy bits into a reliable key without leaking information about the key through the public helper data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Guajardo et al. SRAM PUF Key Storage** | 2007 | SRAM + fuzzy extractor | First demonstration of stable key generation from SRAM PUF using BCH code-based fuzzy extractor; 128-bit keys from 4 KB SRAM [[1]](https://ieeexplore.ieee.org/document/4261993) |
| **Dodis et al. Fuzzy Extractors** | 2008 | Information theory + ECC | Formal definition of fuzzy extractors (Gen, Rep); secure sketch + strong extractor; foundational theory for all PUF key derivation [[1]](https://link.springer.com/article/10.1007/s00145-006-0264-y) |
| **Intrinsic ID SRAM PUF (BroadKey)** | 2012+ | Commercial SRAM PUF IP | Commercial PUF IP core deployed in NXP, Microchip, Renesas MCUs; derives device-unique 256-bit AES keys; NIST-validated entropy [[1]](https://www.intrinsic-id.com/broadkey/) |
| **Reverse Fuzzy Extractor (van der Leest et al.)** | 2012 | Server-side enrollment | Enrollment done on secure server; device only runs reproduction (Rep); reduces on-device complexity for IoT [[1]](https://link.springer.com/chapter/10.1007/978-3-642-31912-9_6) |
| **Lattice PUF (Jin et al.)** | 2023 | LWE + PUF | Combines PUF noise tolerance with lattice-based hardness; helper data is an LWE instance; resists ML modeling attacks on the PUF [[1]](https://ieeexplore.ieee.org/document/9896757) |

**State of the art:** Intrinsic ID BroadKey is the dominant commercial SRAM PUF solution, deployed in hundreds of millions of MCUs. Lattice PUF (2023) adds post-quantum security to the helper-data scheme. Extends [Physical Unclonable Functions (PUF)](#physical-unclonable-functions-puf) and uses [Fuzzy Extractors](01-foundational-primitives.md#randomness-extractors).

**Production readiness:** Production
Intrinsic ID BroadKey deployed in hundreds of millions of MCUs; commercial IP core from Intrinsic ID, Synopsys

**Implementations:**
- [Intrinsic ID BroadKey](https://www.intrinsic-id.com/broadkey/) — Commercial, SRAM PUF IP core for MCU key generation
- [pypuf (fuzzy extractor research)](https://github.com/nils-wisiol/pypuf) ⭐ 92 — Python, PUF simulation including fuzzy extractor helpers

**Security status:** Secure
SRAM PUFs with fuzzy extractors provide reliable, unique keys; helper data is provably information-theoretically secure; NIST-validated entropy

**Community acceptance:** Widely trusted
Deployed by NXP, Microchip, Renesas; Intrinsic ID is market leader; well-studied theory (Dodis et al. fuzzy extractors); NIST-validated

---

## Arbiter PUF Protocols & Advanced Compositions

**Goal:** Build challenge-response authentication protocols from Arbiter PUFs and their compositions (XOR Arbiter PUF, Feed-Forward Arbiter PUF, Interpose PUF) that resist machine-learning modeling attacks. The core Arbiter PUF exploits race conditions between two signal paths on a chip, but its linear structure makes it vulnerable to logistic-regression cloning — motivating increasingly complex compositions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Arbiter PUF (Lim et al.)** | 2005 | Delay-based race | Two parallel delay paths; final arbiter measures which signal arrives first; exponential CRP space from linear hardware; MIT [[1]](https://ieeexplore.ieee.org/document/1407935) |
| **XOR Arbiter PUF (Suh-Devadas)** | 2007 | XOR of k Arbiter PUFs | XOR k independent Arbiter PUF responses; exponentially increases modeling complexity (from linear to k-th order) [[1]](https://dl.acm.org/doi/10.1145/1278480.1278484) |
| **Feed-Forward Arbiter PUF** | 2007 | Internal feedback loop | Route intermediate arbiter outputs back as challenge bits to later stages; breaks the simple linear model [[1]](https://ieeexplore.ieee.org/document/4261993) |
| **Interpose PUF (Nguyen et al.)** | 2019 | Interposed challenge bit | Insert the response of one Arbiter PUF as a challenge bit into a second; provably resists known reliability-based ML attacks [[1]](https://eprint.iacr.org/2019/1210) |
| **Lockdown Protocol (Yu et al.)** | 2016 | Rate limiting + CRP refresh | Protocol-level defense: limit the number of CRPs exposed per session and refresh CRP space; makes modeling infeasible within CRP budget [[1]](https://ieeexplore.ieee.org/document/7495542) |

**State of the art:** Interpose PUF (2019) and Lockdown Protocol (2016) represent the best combined hardware-protocol defense against ML attacks on Arbiter PUFs. Pure Arbiter PUFs without protocol-level protection are considered broken. Related to [Physical Unclonable Functions (PUF)](#physical-unclonable-functions-puf) and [ML Modeling Attacks on Strong PUFs](#ml-modeling-attacks-on-strong-pufs-ml-based-privacy-attacks).

**Production readiness:** Research
Academic research into ML-resistant compositions; basic Arbiter PUFs are broken; Interpose PUF and protocol-level defenses are prototypes

**Implementations:**
- [pypuf](https://github.com/nils-wisiol/pypuf) ⭐ 92 — Python, Arbiter PUF simulation and ML attack library
- [Interpose PUF (reference)](https://github.com/nils-wisiol/pypuf) ⭐ 92 — Python, includes Interpose PUF simulation

**Security status:** Broken
Basic Arbiter PUFs and simple XOR compositions are broken by ML attacks; Interpose PUF resists known attacks but unproven against future ML methods

**Community acceptance:** Niche
Active academic niche at CCS, CHES, and ACM CCS; PUF authentication largely shifted to SRAM PUFs for practical deployments

---

## RISC-V Cryptography Extensions (Zbk*, Zkn*, Zks*, Zvk*)

**Goal:** Add dedicated cryptographic instructions to the open RISC-V ISA so that embedded, IoT, and server-class RISC-V cores can execute AES, SHA-2, SM3/SM4, and carry-less multiplication in constant time and at hardware speed — without proprietary silicon IP. The extensions are ratified as part of the RISC-V standard and freely implementable by any vendor.

| Extension | Year | Basis | Note |
|-----------|------|-------|------|
| **Zbkb / Zbkc / Zbkx (Bitmanip for Crypto)** | 2021 | Bit manipulation | Carry-less multiply, byte-reverse, bit-rotate, crossbar permutation; building blocks shared across AES, SHA, SM4 [[1]](https://github.com/riscv/riscv-crypto/releases) |
| **Zkne / Zknd (AES Encrypt / Decrypt)** | 2021 | AES round instructions | AES-32 and AES-64 instructions for SubBytes + MixColumns in a single cycle; constant-time by design; ratified 2021 [[1]](https://github.com/riscv/riscv-crypto/releases) |
| **Zknh (SHA-256 / SHA-512)** | 2021 | SHA-2 compression | Dedicated SHA-256 and SHA-512 Sigma and Sum instructions; 3-5x speedup over software; ratified 2021 [[1]](https://github.com/riscv/riscv-crypto/releases) |
| **Zksed / Zksh (SM4 / SM3)** | 2021 | Chinese national algorithms | SM4 block cipher and SM3 hash instructions for Chinese cryptographic compliance; ratified alongside Zkn [[1]](https://github.com/riscv/riscv-crypto/releases) |
| **Zvkned / Zvkg / Zvksh (Vector Crypto)** | 2023 | RISC-V Vector + crypto | Vectorised cryptographic instructions operating on RISC-V V-extension registers; AES, GCM-GHASH, SHA-2, SM3/SM4 on vector widths; ratified 2023 [[1]](https://github.com/riscv/riscv-crypto/releases) |

**State of the art:** Scalar crypto extensions (Zkn, Zks) are ratified and shipping in SiFive, T-Head, and Andes cores (2023+). Vector crypto (Zvk*) was ratified in 2023 and enables throughputs competitive with ARM Crypto Extensions and Intel AES-NI. The open specification model allows any foundry to implement without licensing. Complements [Cryptographic Hardware Accelerators](#cryptographic-hardware-accelerators-aes-ni-sha-ni-avx-512-vaes) and [Side-Channel Resistant AES](#side-channel-resistant-aes-implementations).

**Production readiness:** Production
Scalar crypto extensions ratified and shipping in SiFive, T-Head, and Andes cores; vector crypto ratified in 2023

**Implementations:**
- [riscv-crypto (official spec + tests)](https://github.com/riscv/riscv-crypto) ⭐ 408 — C/ASM, RISC-V crypto extension specification and test vectors
- [OpenSSL RISC-V crypto](https://github.com/openssl/openssl) ⭐ 29k — C/ASM, OpenSSL with RISC-V Zkn/Zvk dispatch (upstream since 3.1)
- [SAIL RISC-V model](https://github.com/riscv/sail-riscv) ⭐ 684 — Sail, formal ISA model including crypto extensions

**Security status:** Secure
Hardware instructions are constant-time by specification; eliminates software timing channels; equivalent security to AES-NI and ARM Crypto Extensions

**Community acceptance:** Standard
Ratified RISC-V ISA extensions; open specification freely implementable; adopted by SiFive, Andes, T-Head; growing Linux and OpenSSL support

---

## ARM Confidential Compute Architecture (CCA)

**Goal:** Provide hardware-enforced isolation for security-sensitive workloads on ARM processors — called Realms — that are protected from the hypervisor, host OS, and other VMs. ARM CCA introduces a new execution context (Realm world) managed by a small, formally verified Realm Management Monitor (RMM), distinct from both the Normal and Secure worlds of TrustZone.

| Component / Scheme | Year | Basis | Note |
|-------------------|------|-------|------|
| **ARM CCA Architecture (ARMv9-A)** | 2021 | Realm world + GPT | Introduces Realm world as fourth exception level context; Granule Protection Tables (GPT) enforce memory isolation in hardware; announced with ARMv9 [[1]](https://www.arm.com/architecture/security-features/arm-confidential-compute-architecture) |
| **Realm Management Monitor (RMM)** | 2022 | Minimal firmware | Small firmware component managing Realm lifecycle; target for formal verification; reference implementation open-sourced by ARM [[1]](https://developer.arm.com/documentation/den0137/latest/) |
| **ARM CCA Attestation** | 2022 | CCA token + RATS | Hardware-rooted attestation tokens prove Realm identity and measurement to remote verifiers; follows IETF RATS architecture [[1]](https://developer.arm.com/documentation/den0096/latest) |
| **Certus (Li et al.)** | 2024 | Formal verification of RMM | Machine-checked functional correctness proof of the ARM RMM using Coq/Hol; guarantees memory isolation properties [[1]](https://arxiv.org/abs/2404.00476) |
| **Veraison Attestation Verifier** | 2023 | Open-source verifier | CNCF project for verifying CCA (and other TEE) attestation tokens; interoperates with Azure, GCP, and ARM reference implementations [[1]](https://github.com/veraison/veraison) |

**State of the art:** ARM CCA is shipping in ARMv9.2-A silicon (Cortex-X4, Neoverse V2) and supported in Linux 6.x kernels; cloud deployment expected 2025-2026 on ARM-based instances. The RMM's small TCB and formal verification effort (Certus) distinguish CCA from Intel TDX's larger firmware base. Interacts with [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference) and [TEE Remote Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation).

**Production readiness:** Experimental
Shipping in ARMv9.2-A silicon (Cortex-X4, Neoverse V2); cloud deployment expected 2025-2026; Linux 6.x kernel support

**Implementations:**
- [Veraison (CCA attestation verifier)](https://github.com/veraison/veraison) ⭐ 53 — Go, CNCF project for verifying ARM CCA attestation tokens
- [ARM CCA documentation](https://www.arm.com/architecture/security-features/arm-confidential-compute-architecture) — ARM's official CCA architecture specification and resources

**Security status:** Caution
Hardware isolation via Granule Protection Tables is architecturally strong; RMM formal verification (Certus) in progress; less adversarial testing than SGX/TDX

**Community acceptance:** Emerging
ARM-backed with silicon shipping; Linux upstream support; Confidential Computing Consortium member; expected to rival TDX for ARM cloud

---

## Intel Trust Domain Extensions (TDX)

**Goal:** Provide VM-level confidential computing on Intel processors by creating hardware-isolated Trust Domains (TDs) whose memory is encrypted and integrity-protected from the hypervisor, BIOS, SMM, and other VMs. TDX extends Intel's TME-MK (Total Memory Encryption - Multi-Key) with per-TD encryption keys managed entirely in hardware, plus a minimal TDX Module firmware for TD lifecycle management.

| Component / Scheme | Year | Basis | Note |
|-------------------|------|-------|------|
| **Intel TDX 1.0 (Sapphire Rapids)** | 2023 | SEAM + TME-MK | First production TDX; TDX Module runs in a new SEAM (Secure Arbitration Mode) VMX root; per-TD AES-XTS memory encryption; Sapphire Rapids Xeon [[1]](https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/overview.html) |
| **TDX Module (Intel firmware)** | 2023 | Minimal TCB | ~100 KLOC firmware managing TD creation, memory assignment, and attestation; smaller TCB than full hypervisor; source code published for audit [[1]](https://github.com/intel/tdx-module) |
| **TDX Attestation (Intel Trust Authority)** | 2023 | ECDSA quote + remote verifier | TD generates a hardware-signed attestation quote; Intel Trust Authority or third-party verifier validates TD identity and measurements [[1]](https://www.intel.com/content/www/us/en/security/trust-authority.html) |
| **TDX Connect (Device TDX)** | 2024 | PCIe IDE + TDX | Extends TD trust boundary to PCIe devices (GPUs, NICs, accelerators) via PCIe Integrity and Data Encryption; enables confidential GPU and DMA [[1]](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions-confidential-computing.html) |
| **Gramine-TDX (CCS 2024)** | 2024 | LibOS for TDX | Lightweight library OS enabling unmodified Linux applications inside TDX TDs with minimal TCB; CCS 2024 [[1]](https://dl.acm.org/doi/10.1145/3658644.3690323) |

**State of the art:** TDX 1.0 is generally available on 4th/5th Gen Xeon (Sapphire/Emerald Rapids) and deployed on Azure, GCP, and AWS. TDX Connect (2024) extends confidential computing to accelerators. Linux 6.2+ includes upstream TDX guest support. Complements [ARM CCA](#arm-confidential-compute-architecture-cca), [Confidential GPU Computing](#confidential-gpu-computing-nvidia-h100-cc-azure-confidential-gpu), and [Confidential ML / TEE-Based Inference](#confidential-ml-tee-based-inference).

**Production readiness:** Production
Generally available on 4th/5th Gen Xeon; deployed on Azure, GCP, and AWS; Linux 6.2+ upstream support

**Implementations:**
- [Intel TDX Module (source)](https://github.com/intel/tdx-module) ⭐ 100 — C, published TDX Module firmware source for audit
- [Gramine-TDX](https://github.com/gramineproject/gramine) ⭐ 755 — C, LibOS enabling unmodified applications in TDX TDs
- [Confidential Containers](https://github.com/confidential-containers) — Go/Rust, cloud-native framework supporting TDX
- [Intel Trust Authority](https://github.com/intel/trustauthority-client-for-go) ⭐ 32 — Go, client for Intel Trust Authority attestation

**Security status:** Caution
Per-TD AES-XTS memory encryption and hardware-signed attestation; TDX Module TCB (~100 KLOC) is larger than ARM RMM; ongoing security research

**Community acceptance:** Widely trusted
Intel-backed; deployed by Azure, GCP, AWS; Confidential Computing Consortium; Linux upstream; active NIST and industry engagement

---

## CKKS-Based Homomorphic Encryption for ML Training

**Goal:** Train machine learning models on encrypted data using the CKKS (Cheon-Kim-Kim-Song) approximate homomorphic encryption scheme, which natively supports fixed-point arithmetic on encrypted real numbers. CKKS enables encrypted gradient computation, aggregation, and model updates without ever decrypting the training data — providing cryptographic privacy throughout the entire training pipeline, not just inference.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CKKS (Cheon-Kim-Kim-Song)** | 2017 | Approximate HE over RLWE | First HE scheme supporting approximate fixed-point arithmetic; encode real vectors into polynomial plaintext slots; rescaling manages noise growth; ASIACRYPT 2017 [[1]](https://link.springer.com/chapter/10.1007/978-3-319-70694-8_15) |
| **Nandakumar et al. Encrypted SGD** | 2019 | CKKS + gradient descent | First encrypted logistic regression and NN training using CKKS; demonstrates convergence on MNIST with accuracy within 1% of plaintext [[1]](https://arxiv.org/abs/1811.00778) |
| **CryptoNets (Gilad-Bachrach et al.)** | 2016 | SEAL (BFV) | First HE-based neural network inference; polynomial activation functions replace ReLU for HE compatibility; Microsoft Research [[1]](https://proceedings.mlr.press/v48/gilad-bachrach16.html) |
| **Lee et al. Privacy-Preserving ML Training (CKKS)** | 2022 | CKKS bootstrapping + mini-batch SGD | Encrypted CNN training with CKKS bootstrapping for deep circuits; trains on CIFAR-10 under encryption; ICML 2022 [[1]](https://proceedings.mlr.press/v162/lee22e.html) |
| **OpenFHE CKKS (Polyakov et al.)** | 2022 | Open-source HE library | Production-grade CKKS implementation with bootstrapping, multi-party, and proxy re-encryption support; successor to PALISADE; used in ML-HE research [[1]](https://github.com/openfheorg/openfhe-development) |
| **HE-Transformer (Intel)** | 2023 | CKKS + ONNX | Compile ONNX model graphs to CKKS homomorphic operations; enables encrypted inference on standard model formats [[1]](https://github.com/IntelAI/he-transformer) |

**State of the art:** CKKS with bootstrapping enables encrypted training on small-to-medium models (logistic regression, shallow CNNs); encrypted training of deep networks remains 10,000-100,000x slower than plaintext. GPU acceleration of CKKS (see [GPU-Based Cryptographic Acceleration](#gpu-based-cryptographic-acceleration-cuda-aes-gpu-fhe)) is narrowing the gap. Extends [Homomorphic Encryption](07-homomorphic-functional-encryption.md#homomorphic-encryption-he) and complements [Secure MPC / HE for Private ML Inference](#secure-mpc-he-for-private-ml-inference).

**Production readiness:** Experimental
Encrypted training demonstrated on small models (logistic regression, shallow CNNs); 10,000-100,000x slower than plaintext for deep networks

**Implementations:**
- [OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, production-grade CKKS with bootstrapping support
- [SEAL (Microsoft)](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, BFV/CKKS HE library
- [HE-Transformer (Intel)](https://github.com/IntelAI/he-transformer) ⭐ 176 [archived] — C++, compile ONNX graphs to CKKS operations
- [Lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k — Go, CKKS/BFV HE library with bootstrapping

**Security status:** Caution
CKKS approximate arithmetic introduces a known ciphertext-dependent noise pattern (Li-Micciancio 2021); IND-CPA-D security model addresses this; parameter selection requires care

**Community acceptance:** Emerging
ISO/IEC 18033-6 HE standard in development; HomomorphicEncryption.org community standard; active research at CRYPTO, Eurocrypt, ASIACRYPT

---

## Caliptra — Open-Source Silicon Root of Trust

**Goal:** Embed a standardized, open-source, auditable cryptographic root-of-trust block inside every datacenter SoC, giving each chip a verifiable cryptographic identity from wafer to decommission.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Caliptra v1.0** | 2022 | DICE + measured boot | Open Compute Project spec; immutable identity + firmware integrity attestation [[1]](https://caliptra.io/) |
| **Caliptra 2.0 + Adams Bridge** | 2024 | Post-quantum accelerator | First open-source RoT with hardened PQC (ML-KEM, ML-DSA) [[1]](https://techcommunity.microsoft.com/blog/azureinfrastructureblog/caliptra-2-1-an-open-source-silicon-root-of-trust-with-enhanced-protection-of-da/4460758) |

**State of the art:** Microsoft and Google committed Caliptra as mandatory for first-party cloud silicon. Addresses hardware supply chain threat — all software-layer security depends on firmware integrity.

**Production readiness:** Experimental
Caliptra 1.0 spec published by OCP; 2.0 with PQC in development; Microsoft and Google committed for first-party cloud silicon

**Implementations:**
- [Caliptra RTL](https://github.com/chipsalliance/caliptra-rtl) ⭐ 133 — SystemVerilog, open-source hardware root of trust RTL
- [Caliptra Software](https://github.com/chipsalliance/caliptra-sw) ⭐ 146 — Rust, firmware for Caliptra RoT
- [Adams Bridge PQC accelerator](https://github.com/chipsalliance/adams-bridge) ⭐ 49 — SystemVerilog, open-source ML-DSA/ML-KEM accelerator for Caliptra 2.0

**Security status:** Caution
Open-source design enables broad audit; DICE-based identity is cryptographically sound; silicon-level validation still ongoing

**Community acceptance:** Emerging
Open Compute Project specification; backed by Microsoft, Google, AMD, NVIDIA; CHIPS Alliance stewardship; expected to become datacenter standard

---

## Zero-Knowledge Proofs of Training (zkPoT / zkDL)

**Goal:** Allow an ML trainer to prove in zero-knowledge that a specific model was trained by honest SGD on a committed dataset, without revealing weights or data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **zkDL** | 2023 | GPU-accelerated ZK proofs | Under 1 second per batch for 10M-parameter networks; 1000-10000x over naive zkML; ePrint 2023/1174 [[1]](https://eprint.iacr.org/2023/1174) |
| **zkPoT (CCS 2024)** | 2024 | Formal training verification | Proves training procedure was followed; ACM CCS 2024 [[1]](https://dl.acm.org/doi/10.1145/3658644.3670316) |

**State of the art:** Only known route to trustless third-party audits of proprietary AI training. Addresses AI regulatory compliance (EU AI Act) — vendor can prove model wasn't trained on prohibited data.

**Production readiness:** Research
Academic prototypes (zkDL, zkPoT); proving time is practical for small networks but not yet for production-scale training

**Implementations:**
- [zkDL (reference)](https://github.com/jvhs0706/zkdl-train) ⭐ 8 [archived] — Python/Rust, GPU-accelerated ZK proofs for training verification

**Security status:** Caution
ZK proof systems are sound under stated assumptions; training verification is a new application with limited adversarial evaluation

**Community acceptance:** Emerging
CCS 2024 paper; growing interest for EU AI Act compliance; no formal standard; niche but potentially high-impact for AI governance

---

## Cryptographic Fairness Auditing / Fairness-as-a-Service

**Goal:** Allow a third-party auditor to verify ML model fairness metrics (demographic parity, equalized odds) on private data using ZK proofs and commitments, without seeing model weights or data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FaaS (Springer IJIS)** | 2023 | ZK proofs + commitments | Model-agnostic; no trusted third party; cryptographically attested compliance [[1]](https://link.springer.com/article/10.1007/s10207-023-00774-z) |

**State of the art:** Bridges "trust our internal audit" to cryptographically verifiable compliance. Required for high-risk AI under EU AI Act and US Executive Orders.

**Production readiness:** Research
Academic prototype; no production deployment of cryptographic fairness auditing

**Implementations:**
- [IBM AI Fairness 360](https://github.com/Trusted-AI/AIF360) ⭐ 2.8k — Python, fairness metrics toolkit (non-cryptographic but related)
- [Fairlearn (Microsoft)](https://github.com/fairlearn/fairlearn) ⭐ 2.2k — Python, fairness assessment and mitigation (non-cryptographic but related)

**Security status:** Caution
Underlying ZK proofs are sound; fairness metrics themselves are debated (demographic parity vs equalized odds); cryptographic layer adds complexity

**Community acceptance:** Niche
Single publication; aligns with EU AI Act requirements; no standardization; intersection of cryptography and AI ethics is very new

---

## Verifiable Machine Unlearning (FHorgEt)

**Goal:** Give data subjects cryptographic proof that their training data has been removed from a model, using FHE+MPC so neither the model nor data is ever in plaintext at any single server.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FHorgEt** | 2026 | FHE + multi-server MPC | Server cryptographically cannot retain original model post-unlearning; ePrint 2026/510 [[1]](https://eprint.iacr.org/2026/510) |

**State of the art:** Turns GDPR Article 17 (right to erasure) from a legal obligation into an enforceable cryptographic guarantee. Essential for enterprise AI in regulated sectors.

**Production readiness:** Research
Single academic paper (ePrint 2026); no implementation available; purely theoretical at this stage

**Implementations:**
- [OpenFHE](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, FHE library that could serve as basis for implementation
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++, MPC framework applicable to multi-server unlearning protocol

**Security status:** Caution
Theoretical construction is sound under FHE+MPC assumptions; no implementation exists to evaluate practical security

**Community acceptance:** Niche
Single ePrint 2026 paper; addresses GDPR Article 17 but no peer review beyond preprint; very early stage

---

## Dataset Watermarking for Training Data Provenance

**Goal:** Embed imperceptible signals in training data so that any model trained on it inherits detectable traces, enabling copyright holders to prove dataset usage without access to model weights.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Radioactive Data (Facebook AI)** | 2020 | Feature-space perturbation | Detectable traces inherited by any trained model [[1]](https://arxiv.org/abs/2002.11497) |
| **STAMP (paraphrase-based)** | 2025 | LLM training data watermark | Watermarks text data via paraphrase; survives training pipeline [[1]](https://arxiv.org/abs/2504.13416) |

**State of the art:** Only viable path for proving training data usage when model weights are opaque (API-only). Addresses NYT v. OpenAI, Getty v. Stability AI type disputes. Categorically distinct from output watermarking.

**Production readiness:** Research
Academic prototypes (Radioactive Data, STAMP); no production dataset watermarking system deployed at scale

**Implementations:**
- [Radioactive Data (Facebook AI)](https://github.com/facebookresearch/radioactive_data) ⭐ 44 — Python/PyTorch, feature-space dataset watermarking

**Security status:** Caution
Watermark survival through training is demonstrated empirically; adversarial robustness against deliberate removal is limited; active research

**Community acceptance:** Emerging
Growing legal relevance (NYT v. OpenAI); active research at NeurIPS, ICML; no formal standard; distinct from output watermarking

---

## Post-Quantum FIDO2 / Passkey Attestation

**Goal:** Replace ECDSA in FIDO2 hardware security keys with NIST PQ algorithms (ML-DSA) so device-bound authentication remains secure against quantum adversaries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PQ-FIDO2 (Google/Yubico prototype)** | 2023–2024 | ML-DSA on security key | Only ~10ms overhead; IANA COSE PQC algorithm registration April 2025 [[1]](https://cryptographycaffe.sandboxaq.com/posts/pq-fido/) |

**State of the art:** FIDO2/passkeys are the dominant phishing-resistant auth standard. All existing deployments rely on ECC broken by Shor's algorithm. PQ-FIDO2 is the physical-device-authentication migration path.

**Production readiness:** Experimental
Google/Yubico prototype demonstrated; IANA COSE PQC algorithm registration in progress (April 2025); not yet in shipping security keys

**Implementations:**
- [libfido2 (Yubico)](https://github.com/Yubico/libfido2) ⭐ 697 — C, FIDO2 client library (PQ integration planned)
- [OpenSK (Google)](https://github.com/google/OpenSK) ⭐ 3.3k — Rust, open-source FIDO2 security key firmware on Nordic nRF52840

**Security status:** Caution
ML-DSA is NIST-standardized and quantum-resistant; integration into constrained security key hardware is new and needs validation

**Community acceptance:** Emerging
FIDO Alliance engaged on PQ migration; IANA COSE registration in progress; Google and Yubico prototyping; expected to become standard within 2-3 years

---
