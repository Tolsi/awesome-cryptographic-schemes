# Homomorphic & Functional Encryption

## Homomorphic Encryption (HE)

**Goal:** Compute on encrypted data without decrypting it. The result, when decrypted, matches computation on plaintext. Provides confidentiality during processing.

| Scheme | Year | Type | Supported Operations | Note |
|--------|------|------|---------------------|------|
| **BFV** | 2012 | Leveled HE (integer arith.) | add, mul (leveled), SIMD batching | Batch integer computation via SIMD [[1]](https://eprint.iacr.org/2012/144) |
| **BGV** | 2011 | Leveled HE (integer arith.) | add, mul (leveled), mod switching | Modulus switching for noise control [[1]](https://eprint.iacr.org/2011/277) |
| **CKKS** | 2017 | Approximate HE (real/complex) | add, mul (approx. real/complex), SIMD | ML-friendly; approximate fixed-point [[1]](https://eprint.iacr.org/2016/421) |
| **TFHE** | 2016 | Fully HE (Boolean/small int) | any Boolean gate, small int add/mul, fast bootstrapping | Fast bootstrapping (~10 ms); gate-by-gate [[1]](https://eprint.iacr.org/2018/421) |
| **OpenFHE** | 2022 | Library | all of above (library) | Implements BFV, BGV, CKKS, TFHE (successor to PALISADE, HElib, HEAAN) [[1]](https://eprint.iacr.org/2022/915) |
| **Paillier** | 1999 | Additive HE only | add only, scalar mul | Simple; used in e-voting, MPC, federated learning [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |
| **TFHE-rs** | 2022 | TFHE (Rust) | Production FHE library | Programmable bootstrapping; used in Zama's fhEVM for encrypted smart contracts [[1]](https://github.com/zama-ai/tfhe-rs) |

**State of the art:** TFHE (fast bootstrapping), CKKS (ML on encrypted data), OpenFHE (reference library), TFHE-rs (production Rust impl.).

---

## Microsoft SEAL

**Goal:** Production-grade homomorphic encryption library for integer and approximate-real arithmetic, enabling developers to build encrypted-data services without deep cryptographic expertise.

Microsoft SEAL is an open-source (MIT-licensed) C++ library developed by the Cryptography and Privacy Research Group at Microsoft. It implements three schemes: **BFV** and **BGV** for exact integer arithmetic modulo a plaintext prime, and **CKKS** for approximate fixed-point arithmetic over real and complex numbers. All three schemes operate over polynomial rings ℤ_q[X]/(X^n + 1) using RLWE security.

Key engineering contributions: an RNS (Residue Number System) decomposition allowing 64-bit native arithmetic without big integers; a clean C++ API with automatic parameter validation; and a **SEAL-Embedded** variant targeting IoT / Azure Sphere microcontrollers. Version 4.x (2022–) added support for the BGV scheme and streamlined the API. SEAL is also accessible through Python (TenSEAL), .NET (Microsoft.SEAL NuGet), and Java wrappers.

| Component | Detail |
|-----------|--------|
| **Schemes** | BFV, BGV (integer arithmetic), CKKS (approx. real) |
| **Bootstrapping** | None natively — leveled use; depth determined by parameter choice |
| **SIMD batching** | BFV/BGV: up to n integer slots; CKKS: n/2 complex slots |
| **Hardware** | Pure C++17; optional Intel HEXL for AVX-512 acceleration |
| **License** | MIT open source |

**State of the art:** SEAL v4.x [[1]](https://github.com/microsoft/SEAL); original SEAL v2.1 paper [[2]](https://eprint.iacr.org/2017/224). Benchmark studies (2025) consistently rank SEAL as the fastest library for CKKS and BFV on single-node deployments. Compare with [OpenFHE](#homomorphic-encryption-he) (broader scheme support) and [HElib](#helib) (Smart-Vercauteren packing optimizations).

---

## HElib

**Goal:** Open-source BGV and CKKS homomorphic encryption library with state-of-the-art ciphertext packing and bootstrapping, designed for high-throughput encrypted computation.

HElib is a C++ library initiated by Shai Halevi and Victor Shoup (originally at IBM Research) that implements the **BGV** scheme with bootstrapping and the **CKKS** approximate-number scheme. It was the first publicly available FHE implementation (2011 prototype; production-grade 2.0 release in 2020) and remains a primary reference for the Smart-Vercauteren (SV) ciphertext packing technique and the Gentry-Halevi-Smart (GHS) bootstrapping optimizations.

Two central technical contributions: (1) **Thin bootstrapping** for BGV, which uses the Frobenius map and a carefully chosen thin recryption circuit to reduce the bootstrapping overhead; (2) **SV SIMD slots** — encoding N/2 plaintext elements into a single BGV or CKKS ciphertext and rotating/permuting them via automorphisms of the cyclotomic ring, enabling amortized cost per-slot that approaches that of unencrypted computation. HElib also implements **multi-threading** via OpenMP and **NTL/GMP** for large-integer arithmetic.

| Feature | Detail |
|---------|--------|
| **Schemes** | BGV (with full bootstrapping), CKKS (approx. arithmetic) |
| **Packing** | Smart-Vercauteren (SV) SIMD via cyclotomic-ring automorphisms |
| **Bootstrapping** | Thin bootstrapping (BGV); GHS optimizations |
| **Noise management** | Automatic modulus switching; noise budget tracking |
| **License** | Apache 2.0 |

**State of the art:** HElib v2.x [[1]](https://github.com/homenc/HElib); design paper by Halevi and Shoup [[2]](https://eprint.iacr.org/2020/1481). Widely used in academic research; the packing and bootstrapping techniques it pioneered are now standard across all modern FHE libraries.

---

## HEIR (Homomorphic Encryption Intermediate Representation)

**Goal:** Unified MLIR-based compiler infrastructure for fully homomorphic encryption, lowering high-level programs to optimized FHE circuits targeting multiple back-end libraries and hardware accelerators.

HEIR is an open-source compiler toolchain developed by Google, built on the **MLIR** (Multi-Level Intermediate Representation) framework. Where scheme-specific libraries (SEAL, OpenFHE, TFHE-rs) expose low-level APIs, HEIR provides *compiler abstractions* at multiple IR levels — from high-level program descriptions down to scheme-specific polynomial operations — enabling automated noise analysis, scheme selection, batching layout, and code generation targeting SEAL, OpenFHE, TFHE-rs, or custom hardware accelerators.

HEIR introduces a family of MLIR *dialects* for HE: a high-level `secret` dialect expressing computation over encrypted values, intermediate `bgv`/`ckks`/`lwe` dialects, and low-level polynomial dialects. This multi-level design lets researchers implement new optimization passes (rotation scheduling, ciphertext layout transformations, level assignment) without touching back-end code, and lets hardware designers plug in accelerator targets without changing the front-end. Zama's **Concrete** compiler also uses MLIR internally, and both projects are co-ordinating on standardizing shared HE dialects.

| Layer | Purpose |
|-------|---------|
| `secret` dialect | Front-end: mark values as encrypted; scheme-agnostic |
| `bgv` / `ckks` / `lwe` dialects | Mid-level: scheme-specific operations, noise tracking |
| Polynomial dialect | Low-level: NTT, basis conversion, key-switch ops |
| Back-ends | SEAL, OpenFHE, TFHE-rs, Verilog (HW) |

**State of the art:** HEIR project [[1]](https://github.com/google/heir); WAHC 2024 workshop paper [[2]](https://homomorphicencryption.org/wp-content/uploads/2024/10/WAHC-HEIR_-A-Unified-Compiler-for-Fully-Homomorphic-Encryption.pdf). Recognized as the emerging standard compiler infrastructure for FHE research, analogous to LLVM for conventional compilers.

---

## Concrete & Concrete ML (Zama)

**Goal:** End-to-end FHE compiler and privacy-preserving ML framework that automatically translates Python programs and scikit-learn / PyTorch models into TFHE-based encrypted equivalents, hiding all cryptographic complexity from developers.

Zama's **Concrete** compiler is an MLIR-based toolchain that takes an annotated Python function, performs integer quantization, table-lookup decomposition, and parameter selection, then emits TFHE circuits executed by **TFHE-rs** (Zama's production Rust library). The key challenge solved is *programmable bootstrapping*: any univariate function on small integers can be evaluated during a single TFHE bootstrap, so Concrete decomposes arbitrary Python functions into a DAG of table lookups executable on encrypted integers.

**Concrete ML** sits on top of Concrete and provides drop-in replacements for scikit-learn classifiers (logistic regression, decision trees, random forests, gradient boosted trees) and a PyTorch conversion path. Models are *quantization-aware trained* (QAT) or post-training quantized to 3–8 bits, then compiled to FHE circuits. Inference runs on encrypted data with no plaintext touching the server.

| Layer | Tool | Role |
|-------|------|------|
| Crypto back-end | **TFHE-rs** (Rust) | Fast programmable bootstrapping |
| Compiler | **Concrete** (MLIR/Python) | Python → TFHE circuit |
| ML framework | **Concrete ML** (Python) | scikit-learn / PyTorch → FHE model |

| Application | Capability |
|-------------|-----------|
| Classification (tree models) | Decision trees, random forests, XGBoost on encrypted data |
| Neural networks | Quantized PyTorch models with encrypted inference |
| Smart contracts | fhEVM — encrypted EVM state via TFHE-rs |

**State of the art:** Concrete compiler [[1]](https://github.com/zama-ai/concrete); Concrete ML [[2]](https://github.com/zama-ai/concrete-ml); tree-based FHE inference paper [[3]](https://eprint.iacr.org/2023/258). Part of Zama's open-source FHE stack alongside [TFHE-rs](#homomorphic-encryption-he).

---

## Gentry's Original FHE (Ideal Lattices)

**Goal:** Compute arbitrary functions on ciphertext without decrypting. Craig Gentry's 2009 construction was the first scheme ever proven to support unbounded homomorphic computation, resolving a 30-year open problem.

The scheme proceeds in three steps. First, a *somewhat homomorphic* encryption (SHE) is built from ideal lattices: a polynomial ring modded by a secret ideal, supporting a bounded number of additions and multiplications before noise overwhelms the ciphertext. Second, the SHE is made *bootstrappable* by *squashing the decryption circuit* — the encrypter hints at the secret key so that decryption can be expressed as a low-depth (NC¹) circuit, which the SHE can evaluate homomorphically. Third, by homomorphically evaluating the decryption function on a noisy ciphertext, the noise is "refreshed" and computation can continue indefinitely — this is *bootstrapping*. The security of the squashing step relies on the sparse subset-sum (SSSP) assumption in addition to the underlying lattice hardness. The scheme is exponentially slower than later generations but remains the theoretical blueprint that all subsequent FHE builds on.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gentry FHE (ideal lattices)** | 2009 | Ideal lattices | First FHE; bootstrapping via homomorphic decryption [[1]](https://dl.acm.org/doi/10.1145/1536414.1536440) |
| **Gentry-Halevi HElib (STOC impl.)** | 2011 | Ideal lattices | First implementation; ~6 min per bootstrap gate [[1]](https://eprint.iacr.org/2010/520) |
| **FHE over the Integers (vDGHV)** | 2010 | Integers / hidden subgroup | Conceptually simpler variant of Gentry's idea over integers [[1]](https://eprint.iacr.org/2009/616) |

**State of the art:** Gentry's original construction is superseded in practice by BGV/BFV/CKKS/TFHE, but bootstrapping (noise refresh by homomorphic decryption) remains the conceptual core of all fully homomorphic schemes.

---

## GSW (Gentry-Sahai-Waters) FHE

**Goal:** Leveled and fully homomorphic encryption from LWE with an asymptotically faster, conceptually simpler design based on the *approximate eigenvector* method.

Published at CRYPTO 2013, GSW encodes a bit µ as a matrix **C** ∈ ℤ_q^{N×N} such that **C** · **v** ≈ µ · **v** for a secret vector **v** (the approximate eigenvector). Homomorphic addition is matrix addition; homomorphic multiplication is matrix multiplication. The key insight is that the noise growth during multiplication is *asymmetric*: the noise from the right operand grows linearly while the left operand's noise stays bounded, enabling a noise analysis much simpler than key-switching or modulus-switching. When combined with a gadget decomposition (bit-decomposition of matrices), the scheme achieves polynomial noise growth per level, making it leveled FHE without bootstrapping, or fully homomorphic when bootstrapping is applied.

GSW is the direct precursor of the fast-bootstrapping FHEW and TFHE families. It also natively supports attribute-based encryption constructions because the homomorphic evaluation of predicates follows directly from matrix multiplication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GSW** | 2013 | LWE | Approximate eigenvector method; matrix add/mul; clean noise analysis [[1]](https://eprint.iacr.org/2013/340) |
| **Ring-GSW (RGSW)** | 2014 | RLWE | Ring variant used inside FHEW/TFHE bootstrapping as external-product ciphertexts [[1]](https://eprint.iacr.org/2014/816) |

**State of the art:** GSW/RGSW are not used directly in production but underpin FHEW and TFHE bootstrapping (the blind-rotation step is an RGSW external product). They also inform constructions of [ABE/FE](#attribute-based--functional-encryption) from LWE.

---

## FHEW Bootstrapping

**Goal:** Reduce the bootstrapping bottleneck of FHE to sub-second latency. FHEW (2015) broke the barrier from minutes to under one second per gate by combining a homomorphic NAND gate evaluation with a fast ring-based refresh procedure.

Published at EUROCRYPT 2015 by Ducas and Micciancio, FHEW works over LWE ciphertexts encrypting single bits. Refreshing a noisy bit-ciphertext is recast as evaluating a *lookup table* (specifically the NAND truth table) homomorphically using an RGSW accumulator over a ring ℤ[X]/(Xⁿ+1). The accumulator is initialized to the plaintext polynomial and rotated by each key-bit via an RGSW external product — the so-called *blind rotation*. The final coefficient extracted from the accumulator is the refreshed ciphertext, with noise independent of circuit depth. The implementation ran in ~0.5 s per bootstrap on commodity hardware — compared to ~6 minutes for the prior HElib. The TFHE library (2016/2020) further optimised the same blind-rotation approach to ~10 ms per gate and extended it to *programmable bootstrapping* (evaluate any univariate function during the bootstrap, not just NAND).

| Scheme | Year | Latency | Note |
|--------|------|---------|------|
| **FHEW** | 2015 | ~0.5 s/gate | First sub-second bootstrapping; blind rotation over RLWE [[1]](https://link.springer.com/chapter/10.1007/978-3-662-46800-5_24) |
| **TFHE (Chillotti et al.)** | 2016/2020 | ~10 ms/gate | Torus variant; programmable bootstrapping; evaluates arbitrary LUT during refresh [[1]](https://eprint.iacr.org/2018/421) |
| **FINAL** | 2022 | ~1 ms/gate | Further FHEW-family optimization; improved key sizes [[1]](https://eprint.iacr.org/2021/317) |

**State of the art:** TFHE-rs (Zama) is the production-grade implementation used in encrypted smart contracts and privacy-preserving ML inference. Programmable bootstrapping makes FHEW-family schemes uniquely suited to non-polynomial operations (comparisons, ReLU, integer divisions) without circuit depth overhead.

---

## CKKS Approximate Arithmetic & Rescaling

**Goal:** Homomorphic computation over real and complex numbers with controlled approximation error. CKKS (2017) introduces a *rescaling* operation that manages ciphertext magnitude without expensive exact-integer techniques, making FHE practical for ML and scientific workloads.

Published at ASIACRYPT 2017 by Cheon, Kim, Kim, and Song (hence CKKS), the scheme encodes a vector of real (or complex) numbers into the coefficient slots of a cyclotomic polynomial ring using RLWE. Unlike BGV/BFV which require exact integer plaintext spaces, CKKS deliberately accepts a small additive error after each multiplication and uses *rescaling* — dividing by a factor of the ciphertext modulus — to keep the magnitude of plaintexts bounded. This mirrors floating-point rounding: computations are approximate but with predictable precision loss.

SIMD batching packs ⌊n/2⌋ complex values into one ciphertext (n = ring degree), enabling highly parallelized matrix-vector products, polynomial approximations, and neural-network layer evaluations on encrypted data. The RNS (Residue Number System) representation enables efficient modular arithmetic on commodity 64-bit hardware.

Bootstrapping for CKKS (approximate bootstrapping) is more subtle than for BGV/BFV: the refresh must handle real-valued precision loss. The CKKS bootstrapping approach (Cheon et al. 2018; Han and Ki 2020) homomorphically evaluates the modular reduction as a trigonometric polynomial approximation, recovering sufficient precision levels at the cost of ~10–20 levels of multiplicative depth.

| Feature | Detail |
|---------|--------|
| **Plaintext space** | ℝⁿ/² or ℂⁿ/² (SIMD packed) |
| **Core operation** | Approximate add/mul + rescale (divide-by-Δ after mul) |
| **Bootstrapping** | Approximate mod-reduction via cosine approximation; ~10–20 levels consumed |
| **Primary use** | Privacy-preserving ML inference and training; genome analysis; statistics |

| Scheme / Work | Year | Note |
|---------------|------|------|
| **CKKS original** | 2017 | Approximate HE with rescaling [[1]](https://eprint.iacr.org/2016/421) |
| **CKKS bootstrapping (CHKKS)** | 2018 | Homomorphic mod-reduction via polynomial approx [[1]](https://eprint.iacr.org/2018/153) |
| **RNS-CKKS (Cheon et al.)** | 2019 | RNS-friendly CKKS enabling efficient 64-bit implementation [[1]](https://eprint.iacr.org/2018/931) |
| **HE for ML (SHE-ML)** | 2019 | Systematic study of CKKS for neural network inference [[1]](https://eprint.iacr.org/2018/1056) |

**State of the art:** CKKS (implemented in OpenFHE, HEAAN, Microsoft SEAL) is the dominant scheme for privacy-preserving machine learning. CKKS bootstrapping allows unbounded depth at the cost of precision, which is sufficient for most ML workloads.

---

## Quadratic / Degree-2 Functional Encryption

**Goal:** Decrypt a *quadratic function* of the plaintext — i.e., a bilinear map of the form f(x) = xᵀ · M · y for encrypted vectors — without revealing the vectors themselves. Goes beyond linear inner-product FE to support quadratic features useful in ML and statistics.

Baltico, Catalano, Fiore, and Gay (CRYPTO 2017) gave the first practically efficient FE for the class of bilinear maps on encrypted vectors: given an encryption of vector **x**, a secret key for matrix **M** (or, in the two-input variant, encryptions of both **x** and **y**) allows computing **xᵀM y** mod p. Their constructions over asymmetric bilinear groups are *linear in n* in ciphertext and key size — a public key of 2n+1 group elements, keys of 2 group elements — and are proven selectively secure under Matrix-DDH or adaptively secure in the generic group model.

Degree-2 FE captures a rich class of statistics: Euclidean norms, dot products, chi-squared statistics, second-order features, and polynomial classifiers. The work also yields efficient predicate encryption for degree-2 polynomial predicates.

| Scheme | Year | Security | Note |
|--------|------|----------|------|
| **IPFE (Abdalla et al.)** | 2015 | Selective, DDH/LWE | Inner-product FE (degree 1); practical; used in privacy-preserving data analysis [[1]](https://eprint.iacr.org/2015/017) |
| **Quadratic FE (Baltico-Catalano-Fiore-Gay)** | 2017 | Selective (Matrix-DDH) / adaptive (GGM) | Bilinear map FE; ciphertext size O(n); pairings [[1]](https://eprint.iacr.org/2017/151) |
| **FE for Quadratic Functions from k-Lin (Gay)** | 2020 | Adaptive, standard assumptions | Fully adaptive security from k-Lin without generic group model [[1]](https://eprint.iacr.org/2019/728) |
| **Multi-Client IPFE** | 2019 | Selective, DDH | Multiple encryptors; joint inner product; no interaction [[1]](https://eprint.iacr.org/2017/972) |

**State of the art:** Quadratic FE from pairings (Baltico et al.) is the most practical for single-input second-order functions. Adaptive security from k-Lin (Gay 2020) provides stronger guarantees. These schemes bridge [Inner-Product FE](#attribute-based--functional-encryption) and [Multi-Input FE](#attribute-based--functional-encryption) in the functional encryption hierarchy.

---

## Function-Hiding Inner-Product Functional Encryption (FH-IPFE)

**Goal:** Compute the inner product ⟨**x**, **y**⟩ between an encrypted vector **x** and a key vector **y** while hiding *both* vectors — the decryptor learns only the inner product, nothing about either input individually.

Standard [Inner-Product FE (IPFE)](#quadratic--degree-2-functional-encryption) hides the plaintext vector **x** but reveals the key vector **y** (which is in the functional decryption key). Bishop, Jain, and Kowalczyk (ASIACRYPT 2015) introduced **function-hiding** IPFE: the decryption key for **y** is itself a *ciphertext* under a secret-key IPFE scheme, so **y** is computationally hidden from any party that cannot decrypt. The construction uses bilinear groups under the Symmetric External Diffie-Hellman (SXDH) assumption.

Applications are numerous wherever the *query vector* is also sensitive: biometric authentication (template vector must stay private), nearest-neighbour search (query embedding must stay private), private neural-network inference (weight vectors are the model owner's intellectual property). The practical follow-up by Bishop, Jain, and Kowalczyk (SCN 2018, ePrint 2016/440) halved parameter sizes and demonstrated real-world performance.

| Scheme | Year | Security | Note |
|--------|------|----------|------|
| **Bishop-Jain-Kowalczyk FH-IPFE** | 2015 | Selective, SXDH | First function-hiding IPFE; secret-key scheme; bilinear groups [[1]](https://eprint.iacr.org/2015/672) |
| **FH-IPFE is Practical (Bishop et al.)** | 2018 | Selective, SXDH | Halved parameters; biometric auth and NN inference demo [[1]](https://eprint.iacr.org/2016/440) |
| **Tightly Secure Multi-Input FH-IPFE (Tomida)** | 2019 | Tight, k-Lin | Tight security reduction; multi-input extension [[1]](https://link.springer.com/chapter/10.1007/978-3-030-34618-8_16) |

**State of the art:** Bishop et al. (2018) for practical single-key FH-IPFE; Tomida (2019) for tight multi-input security. Extends [IPFE](#quadratic--degree-2-functional-encryption) to protect the function key as well as the data, enabling private ML model inference on encrypted inputs.

---

## Decentralized Multi-Client Functional Encryption (DMCFE)

**Goal:** Compute a joint function (e.g., an inner product) over data contributed by multiple independent parties without any central trusted authority — neither a master-key holder nor a single encryptor.

Standard [Multi-Input FE](#attribute-based--functional-encryption) requires a central authority to issue all functional keys. Multi-Client FE (MCFE) allows multiple senders but still requires a central key authority. **Decentralized MCFE (DMCFE)**, introduced by Chotard, Dufour-Sans, Gay, Phan, and Pointcheval (ASIACRYPT 2018), removes the central authority entirely: each client independently holds a share of the master secret, and functional decryption keys are generated *non-interactively* (only setup requires interaction) by the clients themselves using a distributed key-generation protocol.

The practical DMCFE construction for inner products operates as follows. Each client *i* holds a local secret key `sk_i`. To encrypt input `x_i`, client *i* produces a ciphertext `ct_i`. To generate a functional decryption key for weight vector **y** = (y₁, …, yₙ), each client *i* independently computes a key share `dk_i^y` from `sk_i` and `y_i` (no interaction). The aggregator combines `{dk_i^y}` and `{ct_i}` to recover ⟨**x**, **y**⟩ = Σ xᵢ · yᵢ without learning any individual `x_i`. Security relies on the DDH assumption over prime-order groups (the 2018/1021 improvement) or pairings (the original 2017/989 version).

| Scheme | Year | Assumption | Note |
|--------|------|------------|------|
| **DMCFE-IP (Chotard et al.)** | 2018 | MDDH / pairings | First DMCFE; inner product; setup interaction only [[1]](https://eprint.iacr.org/2017/989) |
| **DMCFE-IP from DDH (Chotard et al.)** | 2018 | DDH | Pairing-free variant; practical over standard groups [[1]](https://eprint.iacr.org/2018/1021) |
| **Decentralizing IPFE (Chotard-Dufour-Sans-Gay-Pointcheval)** | 2019 | DDH / MDDH | Framework with stronger security notions; PKC 2019 [[1]](https://link.springer.com/chapter/10.1007/978-3-030-17259-6_5) |
| **Verifiable DMCFE (ASIACRYPT 2023)** | 2023 | MDDH | Adds output verifiability; malicious-client resilience [[1]](https://eprint.iacr.org/2023/268) |

**State of the art:** DDH-based DMCFE (Chotard et al. 2018) for practical deployments; verifiable DMCFE (2023) for settings with potentially malicious clients. Combines [Multi-Input FE](#attribute-based--functional-encryption) and [Multi-Authority ABE](#multi-authority-abe) ideas to achieve fully decentralized fine-grained computation on encrypted data.

---

## Multi-Key / Threshold FHE

**Goal:** Joint computation on data encrypted under different keys. Multiple parties each encrypt their data under their own key; a computation is performed on all ciphertexts jointly without any party decrypting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Multi-Key FHE (López-Alt et al.)** | 2012 | NTRU lattice | First MKFHE; N parties, joint decryption [[1]](https://eprint.iacr.org/2011/613) |
| **Threshold BFV/BGV** | 2012 | Shamir + HE | Secret-share FHE key among N parties; joint bootstrapping [[1]](https://eprint.iacr.org/2011/535) |
| **Multi-Party CKKS** | 2020 | RLWE + SS | Privacy-preserving ML on distributed encrypted data [[1]](https://eprint.iacr.org/2020/304) |

**State of the art:** Multi-Party CKKS (federated ML), Threshold BFV (joint computation with no single key holder).

---

## Verifiable FHE

**Goal:** Trustworthy outsourced computation on encrypted data. The server performs FHE computation and provides a proof that the computation was done correctly — the client verifies the proof without re-executing. Without this, FHE outsourcing requires trusting the server's correctness.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fiore-Gennaro Verifiable Computation on Enc Data** | 2012 | FHE + homomorphic MAC | Verify FHE computation via homomorphic MAC on plaintexts [[1]](https://eprint.iacr.org/2012/202) |
| **Ganesh-Nitulescu-Soria-Vazquez** | 2021 | SNARK + FHE | Prove correct FHE evaluation with a SNARK; general circuits [[1]](https://eprint.iacr.org/2021/1530) |
| **Rinocchio** | 2021 | SNARK over rings | Adapt Pinocchio/Groth16 to work over polynomial rings (FHE-native) [[1]](https://eprint.iacr.org/2021/322) |

**State of the art:** SNARK-based verifiable FHE (Ganesh et al. 2021); combines [ZK Proofs](#zero-knowledge-proofs-zk) and [HE](#homomorphic-encryption-he). Active research area for trustworthy cloud computation.

---

## Attribute-Based & Functional Encryption

**Goal:** Fine-grained access control embedded in ciphertext. Decrypt only if your attributes/key satisfy a policy. Provides access control + confidentiality.

| Scheme | Year | Type | Note |
|--------|------|------|------|
| **CP-ABE (Bethencourt-Sahai-Waters)** | 2007 | Ciphertext-Policy ABE | Policy in ciphertext; key has attributes [[1]](https://eprint.iacr.org/2006/309) |
| **KP-ABE (Goyal-Pandey-Sahai-Waters)** | 2006 | Key-Policy ABE | Policy in key; ciphertext has attributes [[1]](https://eprint.iacr.org/2006/309) |
| **FAME** | 2017 | CP-ABE (prime-order) | Fast, prime-order groups; practical [[1]](https://eprint.iacr.org/2017/807) |
| **Inner-Product FE (Abdalla et al.)** | 2015 | Functional Encryption | Decrypt inner product of attribute vectors [[1]](https://eprint.iacr.org/2015/017) |
| **Multi-Input FE** | 2014 | Functional Encryption | Multiple encryptors, joint function [[1]](https://eprint.iacr.org/2013/774) |
| **Predicate Encryption (KSW)** | 2008 | Pairings | Generalization of ABE: decrypt iff predicate(key attrs, ct attrs) = true [[1]](https://eprint.iacr.org/2008/290) |

**State of the art:** FAME (practical ABE), Inner-Product FE (ML applications).

---

## Identity-Based Encryption (IBE)

**Goal:** Confidentiality without PKI. Encrypt to an arbitrary identity string (email address, phone number, domain) — the recipient obtains a private key from a trusted authority and decrypts.

**Architecture:** A trusted **Private Key Generator (PKG)** holds a master secret key (msk) and publishes a master public key (mpk). Anyone can encrypt to an identity string using mpk. The recipient contacts the PKG, authenticates, and receives their identity-specific secret key via `Extract(msk, id) → sk_id`. **Key escrow problem:** the PKG can decrypt all messages — motivating [Registration-Based Encryption](#registration-based-encryption-rbe) which removes this trust assumption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Franklin IBE** | 2001 | Bilinear pairings | First practical IBE; Weil pairing on elliptic curves [[1]](https://eprint.iacr.org/2001/090) |
| **Waters IBE** | 2005 | Pairings | Selective-ID secure without random oracles [[1]](https://eprint.iacr.org/2004/180) |
| **HIBE (Gentry-Silverberg)** | 2002 | Pairings | Hierarchical IBE; delegatable to sub-authorities [[1]](https://eprint.iacr.org/2002/107) |
| **Lattice IBE (Gentry-Peikert-Vaikuntanathan)** | 2008 | LWE | Post-quantum IBE [[1]](https://eprint.iacr.org/2007/432) |
| **Revocable IBE (Boldyreva-Goyal-Kumar)** | 2008 | Pairings + binary tree | Efficient revocation: PKG publishes periodic updates; revoked users can't decrypt new ciphertexts [[1]](https://eprint.iacr.org/2008/013) |

**State of the art:** Boneh-Franklin (widely taught), lattice IBE (PQ setting), revocable IBE for deployments requiring key revocation.

---

## Multi-Authority ABE

**Goal:** Decentralized access control. Multiple independent attribute authorities each manage a subset of attributes — no single authority can decrypt alone. Eliminates single point of trust in ABE systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase Multi-Authority ABE** | 2007 | Pairings | First multi-authority CP-ABE; central authority + attribute authorities [[1]](https://eprint.iacr.org/2007/010) |
| **Chase-Chow (no central authority)** | 2009 | Pairings | Removes central authority; fully decentralized [[1]](https://eprint.iacr.org/2009/094) |
| **Lewko-Waters Decentralized ABE** | 2011 | Pairings (dual system) | Any party can become an authority; no global setup [[1]](https://eprint.iacr.org/2011/414) |
| **MAABE for Large Universe (Rouselakis-Waters)** | 2015 | Pairings | Large attribute universe; efficient multi-authority [[1]](https://eprint.iacr.org/2015/016) |

**State of the art:** Lewko-Waters (2011) for fully decentralized; Rouselakis-Waters for large universes. Extends [ABE/FE](#attribute-based--functional-encryption) to remove single trust assumptions.

---

## Registration-Based Encryption (RBE)

**Goal:** IBE without trusted authority. Like [IBE](#identity-based-encryption-ibe) but replaces the trusted PKG with a transparent public bulletin board. Users register their own public keys; anyone can encrypt to an identity; no single party holds a master secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garg-Hajiabadi-Mahmoody-Rahimi** | 2018 | Lattices / iO | First RBE construction; removes key escrow [[1]](https://eprint.iacr.org/2018/040) |
| **Efficient RBE (Glaeser et al.)** | 2022 | Pairings + accumulators | Practical: O(log N) ciphertext from accumulator-based approach [[1]](https://eprint.iacr.org/2022/1505) |

**State of the art:** pairing + accumulator RBE (practical); resolves IBE's key escrow problem.

---

## Anonymous IBE

**Goal:** Recipient privacy in IBE. The ciphertext hides not just the message but also the identity of the intended recipient. An eavesdropper cannot determine who can decrypt — even given the master public key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boyen-Waters Anonymous IBE** | 2006 | Pairings | First efficient anonymous IBE; ciphertext hides recipient identity [[1]](https://eprint.iacr.org/2005/029) |
| **Gentry Anonymous IBE** | 2006 | Pairings | Anonymous + CCA-secure; tight reduction [[1]](https://eprint.iacr.org/2006/077) |
| **Lattice Anonymous IBE (Agrawal et al.)** | 2010 | LWE | Post-quantum anonymous IBE from lattices [[1]](https://eprint.iacr.org/2010/383) |
| **Anonymous HIBE (Ducas-Lyubashevsky)** | 2018 | LWE | Hierarchical + anonymous + post-quantum [[1]](https://eprint.iacr.org/2018/088) |

**State of the art:** Lattice-based anonymous IBE (PQ-secure); extends [IBE](#identity-based-encryption-ibe) with recipient anonymity. Useful for anonymous broadcast and PIR-like scenarios.

---

## Broadcast Encryption

**Goal:** Selective confidentiality. Encrypt to an arbitrary subset of *N* registered users so only authorized members can decrypt. Efficient revocation without re-keying all users. Used in DRM (Blu-ray AACS), pay-TV, multicast.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fiat-Naor BE** | 1993 | Combinatorial | First formal broadcast encryption scheme [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_40) |
| **NNL (Subset-Difference)** | 2001 | Key trees | Used in AACS (Blu-ray); O(r log(N/r)) header size [[1]](https://link.springer.com/chapter/10.1007/3-540-44647-8_4) |
| **Boneh-Gentry-Waters** | 2005 | Bilinear pairings | O(1) ciphertext header; short keys [[1]](https://eprint.iacr.org/2005/018) |
| **Traitor Tracing (BSW)** | 2006 | Pairings | Identify leakers of decryption keys; combines with BE [[1]](https://eprint.iacr.org/2006/056) |

**State of the art:** NNL (industry standard in AACS/CPPM), Boneh-Gentry-Waters (short ciphertexts).

---

## Access Control Encryption (ACE)

**Goal:** Enforced communication policy. A sanitizer mediates all communication — it enforces who can send messages to whom according to a policy, without learning message contents. Neither sender nor receiver can bypass the policy. Unlike ABE (controls who reads), ACE controls who communicates.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Damgård-Haagh-Orlandi ACE** | 2016 | iO / witness encryption | First ACE; sanitizer enforces access graph without learning content [[1]](https://eprint.iacr.org/2016/106) |
| **ACE from Pairings (Fuchsbauer et al.)** | 2017 | Pairings + NIZK | Practical ACE without iO; disjunctive normal form policies [[1]](https://eprint.iacr.org/2017/457) |
| **ACE with Accountability** | 2019 | ACE + tracing | Identify policy violators; accountable sanitizer [[1]](https://eprint.iacr.org/2019/904) |

**State of the art:** Pairing-based ACE (2017); combines ideas from [ABE](#attribute-based--functional-encryption), [Proxy Re-Encryption](#proxy-re-encryption-pre), and network access control.

---

## Matchmaking Encryption

**Goal:** Dual-policy encryption. Message is decryptable only when BOTH the sender's attributes match the receiver's policy AND the receiver's attributes match the sender's policy. Neither party learns if decryption failed due to the other's policy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ateniese et al. ME** | 2019 | ABE + ZK | First matchmaking encryption; bilateral access control [[1]](https://eprint.iacr.org/2018/1094) |
| **Efficient ME (Chen et al.)** | 2021 | Pairings | Practical construction with shorter ciphertexts [[1]](https://eprint.iacr.org/2021/680) |

**State of the art:** pairing-based ME; applications in dating platforms, classified communication, bilateral credential matching.

---

## Key-Aggregate Encryption

**Goal:** Compact delegation for cloud storage. Encrypt N files under N different keys; delegate access to any chosen subset S with a single short aggregate key — regardless of |S|. The aggregate key is constant-size (one group element), not proportional to the number of shared files.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chu-Chow-Tzeng-Zhou KAE** | 2014 | Pairings | First KAE; constant-size aggregate key for any subset of ciphertexts [[1]](https://eprint.iacr.org/2013/679) |
| **KAE with Authentication** | 2016 | Pairings + signatures | Authenticated KAE; detect tampering of delegated ciphertexts [[1]](https://doi.org/10.1016/j.jisa.2016.09.001) |
| **Lattice KAE** | 2019 | LWE | Post-quantum key-aggregate encryption [[1]](https://eprint.iacr.org/2019/494) |

**State of the art:** Pairing-based KAE (Chu et al. 2014); lattice KAE for PQ. Useful for cloud access control; related to [Broadcast Encryption](#broadcast-encryption) and [ABE](#attribute-based--functional-encryption).

---

## Proxy Re-Encryption (PRE)

**Goal:** Delegated confidentiality. A semi-trusted proxy can re-encrypt Alice's ciphertext so Bob can decrypt it — without the proxy ever seeing the plaintext. Used in cloud storage access delegation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blaze-Bleumer-Strauss PRE** | 1998 | ElGamal | First scheme; bidirectional re-encryption [[1]](https://link.springer.com/chapter/10.1007/BFb0054122) |
| **AFGH PRE** | 2006 | Pairings | Unidirectional, non-interactive; CPA-secure [[1]](https://eprint.iacr.org/2005/028) |
| **Umbral (NuCypher)** | 2018 | EC + AFGH | Threshold PRE: *t-of-n* proxies needed [[1]](https://eprint.iacr.org/2017/206) |
| **CCA-secure PRE (Libert-Vergnaud)** | 2008 | Pairings | CCA2-secure unidirectional PRE; needed for real-world deployment [[1]](https://eprint.iacr.org/2008/286) |

**State of the art:** AFGH (single-hop, CPA), CCA-secure PRE (Libert-Vergnaud), Umbral (threshold, deployed in NuCypher/Threshold network).

---

## Transciphering / FHE-friendly Ciphers

**Goal:** Efficient client-to-FHE bridge. Client encrypts data with a lightweight symmetric cipher; the server homomorphically evaluates the cipher's decryption circuit to switch into the FHE domain. Avoids sending massive FHE ciphertexts over the network.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kreyvium** | 2016 | Stream cipher (Trivium variant) | Low multiplicative depth (12); optimized for FHE transciphering [[1]](https://eprint.iacr.org/2015/113) |
| **HERA** | 2022 | AES-like (MPC/FHE-friendly) | Designed for transciphering; low ANDdepth; competitive throughput [[1]](https://eprint.iacr.org/2021/731) |
| **Pasta** | 2022 | Feistel (FHE-optimized) | Designed for TFHE/BFV transciphering; affine layers + Sbox [[1]](https://eprint.iacr.org/2021/731) |
| **Elisabeth** | 2022 | Stream cipher (FHE-native) | Designed specifically for TFHE; minimal bootstrapping cost [[1]](https://eprint.iacr.org/2022/099) |

**State of the art:** HERA/Pasta for BFV/BGV transciphering; Elisabeth for TFHE. Bridges [Symmetric Encryption](#symmetric-encryption) and [Homomorphic Encryption](#homomorphic-encryption-he).

---

## Hidden Vector Encryption (HVE)

**Goal:** Conjunctive search on encrypted attributes. Encrypt a vector of attributes (a₁, ..., aₙ); a key for pattern (p₁, ..., pₙ) with wildcards (*) decrypts iff aᵢ = pᵢ for all non-wildcard positions. Enables expressive encrypted search without revealing the query pattern.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Waters HVE** | 2007 | Pairings (composite order) | First HVE; conjunctive, subset, and range queries on encrypted data [[1]](https://eprint.iacr.org/2007/013) |
| **Park-Lee-Lee HVE** | 2011 | Pairings (prime order) | Efficient HVE in prime-order groups; shorter ciphertexts [[1]](https://doi.org/10.1007/978-3-642-21554-4_4) |
| **Lattice HVE (Agrawal-Freeman)** | 2013 | LWE | Post-quantum HVE from lattice assumptions [[1]](https://eprint.iacr.org/2013/328) |

**State of the art:** Lattice HVE for PQ; prime-order pairing HVE for efficiency. Generalizes [Searchable Encryption](#searchable-encryption-sse--peks) and specializes [Predicate Encryption](#attribute-based--functional-encryption).

---

## FHE over the Integers (DGHV)

**Goal:** Fully homomorphic encryption whose security reduces to arithmetic over the integers — conceptually simpler than lattice-based schemes — using the approximate GCD problem as the hardness assumption.

Van Dijk, Gentry, Halevi, and Vaikuntanathan (EUROCRYPT 2010) proposed an FHE scheme entirely over the integers: the secret key is a large odd integer *p*; a ciphertext encrypting bit µ is an integer *c* = *p*·*q* + 2*r* + µ, where *q* is a large random integer and *r* is a small random noise term. Decryption is (*c* mod *p*) mod 2 = µ, provided |2*r*| < *p*/2. Homomorphic addition and multiplication are just integer addition and multiplication modulo a public bound; multiplication doubles the noise and roughly doubles the ciphertext bit-length. The key insight is that the computational problem of recovering *p* given many approximate multiples of *p* (approximate GCD) is believed to be hard.

The public-key variant (Coron, Mandal, Naccache, Tibouchi — CRYPTO 2011) eliminates the need to transmit *p* by publishing a set of near-multiples. The scheme was made fully homomorphic via Gentry's squashing/bootstrapping paradigm (the decryption circuit is low-degree over the integers). While asymptotically less efficient than RLWE-based schemes, DGHV provided a concrete arithmetic interpretation of FHE that inspired subsequent analysis and the SIDH/isogeny-like design intuition.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DGHV** | 2010 | Approximate GCD | FHE over integers; conceptually simple; SHE + bootstrapping [[1]](https://eprint.iacr.org/2009/616) |
| **DGHV public-key variant (CMNT)** | 2011 | Approximate GCD | Public-key; near-multiples as public parameters; practical for small λ [[1]](https://eprint.iacr.org/2011/159) |
| **Batch DGHV (Coron et al.)** | 2013 | Approx. GCD + CRT | CRT packing to encrypt multiple bits per ciphertext; amortized cost improvement [[1]](https://eprint.iacr.org/2013/036) |

**State of the art:** DGHV is superseded in performance by BFV/CKKS/TFHE but remains theoretically important as the first FHE construction without lattices. Its hardness reduction to approximate GCD is well-studied. Compare with [Gentry's Original FHE](#gentrys-original-fhe-ideal-lattices) (ideal lattices) and [GSW FHE](#gsw-gentry-sahai-waters-fhe) (LWE).

---

## NTRU-Based Encryption

**Goal:** Lattice-based public-key encryption with practical performance, predating modern LWE/RLWE schemes. NTRU operates over polynomial rings and achieves small key sizes and fast arithmetic, motivating much of modern lattice cryptography.

Proposed by Hoffstein, Pipher, and Silverman (NTRU Cryptosystems Inc., 1996; published ANTS 1998), NTRU is a polynomial-ring encryption scheme. The public key is **h** = *p* · **g** · **f**⁻¹ mod *q* in the ring ℤ[X]/(Xⁿ − 1); the secret key is the short polynomial **f** (with **f**⁻¹ mod *p* and **f**⁻¹ mod *q* precomputed). Encryption pads the message **m** with a random blinding polynomial **r** as **e** = **r** · **h** + **m** mod *q*; decryption multiplies by **f** and reduces mod *p*. Security relies on the *NTRU problem* — recovering short (**f**, **g**) from **h** — which is related to the shortest vector problem on NTRU lattices.

NTRU influenced the design of RLWE-based schemes (BFV, CKKS) and multi-key FHE (López-Alt et al. 2012 used NTRU as the underlying ring problem). NTRUEncrypt was submitted to the NIST PQC standardization process (NIST Round 3 finalist, not selected for standardization in 2022 due to conservative security analysis concerns). NTRU Prime variants (Bernstein et al.) use the ring ℤ[X]/(Xⁿ − X − 1) to avoid the algebraic structure exploits that affect power-of-two cyclotomics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **NTRU (HPS)** | 1998 | Polynomial ring, short vectors | Original NTRU encryption; small keys (700 B at λ=128) [[1]](https://link.springer.com/chapter/10.1007/BFb0054868) |
| **NTRUSign** | 2001 | NTRU lattice | Signature scheme (later broken; full transcript attack) [[1]](https://eprint.iacr.org/2001/014) |
| **NTRU Prime (Bernstein et al.)** | 2017 | Non-cyclotomic ring | Resists subfield and algebraic attacks; NIST PQC finalist [[1]](https://ntruprime.cr.yp.to/) |
| **Multi-Key FHE from NTRU (López-Alt et al.)** | 2012 | NTRU lattice | First multi-key FHE; joint decryption by N parties [[1]](https://eprint.iacr.org/2011/613) |

**State of the art:** NTRU Prime (Bernstein et al.) is actively maintained; NTRUEncrypt was a NIST PQC Round 3 finalist (not standardized). Modern lattice PQC (ML-KEM/Kyber) favors module-LWE, but NTRU's short-key design and ring structure remain influential. Related to [Multi-Key / Threshold FHE](#multi-key--threshold-fhe) and lattice schemes in [Post-Quantum Cryptography](categories/15-quantum-cryptography.md#post-quantum-cryptography-pqc).

---

## FHE Amortization & Batching (SIMD Packing)

**Goal:** Reduce the per-element cost of homomorphic computation by encoding many independent plaintexts into a single ciphertext and operating on all of them in parallel — analogous to SIMD vectorization for conventional arithmetic.

Modern FHE schemes operate over polynomial rings ℤ_q[X]/(Φ_n(X)) of degree *n* (typically 2¹⁰–2¹⁶). The Chinese Remainder Theorem (CRT) decomposition of the quotient ring identifies *n* (or *n*/2) independent "slots", each holding a separate plaintext value. A single ciphertext then encrypts a *vector* of plaintexts; a homomorphic operation on the ciphertext applies to all slots simultaneously. This SIMD batching technique, introduced by Smart and Vercauteren (2011) for BGV and adapted to BFV (Fan-Vercauteren 2012) and CKKS (Cheon et al. 2017), is the primary mechanism making FHE practical for machine learning and database workloads.

Slot rotations — cyclic shifts of the plaintext vector within a ciphertext — are performed via Galois/Frobenius automorphisms of the ring; each rotation consumes one key-switching operation. Optimal rotation scheduling and linear-transformation decomposition (the "baby-step giant-step" (BSGS) technique, Halevi-Shoup 2014) minimizes rotation cost for matrix-vector products and is critical for neural-network inference layers.

| Technique | Year | Scheme | Note |
|-----------|------|--------|------|
| **Smart-Vercauteren SIMD batching** | 2011 | BGV | CRT slots in cyclotomic ring; n plaintext values per ciphertext [[1]](https://eprint.iacr.org/2011/133) |
| **CKKS SIMD (Cheon et al.)** | 2017 | CKKS | n/2 complex slots; canonical embedding of ℝⁿ/² [[1]](https://eprint.iacr.org/2016/421) |
| **BSGS rotation scheduling (Halevi-Shoup)** | 2014 | BGV/BFV | Baby-step giant-step for low-rotation matrix-vector products [[1]](https://eprint.iacr.org/2014/106) |
| **Diagonal matrix encoding (Halevi-Shoup)** | 2018 | CKKS/BGV | Diagonally encoded matmul for neural network layers [[1]](https://eprint.iacr.org/2018/244) |
| **Efficient Bootstrapping via Amortization (Liu-Wang)** | 2023 | CKKS | Amortized CKKS bootstrapping: bootstrap n/2 slots at bulk cost [[1]](https://eprint.iacr.org/2023/014) |

**State of the art:** SIMD batching is standard in all practical FHE deployments. BSGS rotation and diagonal matrix encoding (Halevi-Shoup) are implemented in OpenFHE, SEAL, and HElib. Amortized bootstrapping (2023) further reduces per-slot bootstrapping cost for CKKS. Closely related to [CKKS Approximate Arithmetic & Rescaling](#ckks-approximate-arithmetic--rescaling) and [HElib](#helib).

---

## Homomorphic Signatures

**Goal:** Authenticate data while allowing untrusted parties to compute on it. A homomorphic signature scheme lets anyone aggregate or transform signed data — producing a valid signature on the function output — without access to the signing key. Enables verifiable delegation of computation on signed datasets.

In a homomorphic signature scheme, a signer produces signatures σᵢ on dataset elements {mᵢ}. Given the signatures, any party can compute a signature σ_f on *f*(m₁, …, mₙ) for a supported function class *f* — without interacting with the signer. The verifier, given the public key and a description of *f*, accepts σ_f as authentic. Security requires that an adversary cannot produce a valid σ on any output outside the range of honest computations.

Key constructions: Boneh and Freeman (2011) gave the first lattice-based homomorphic signature for linear functions (inner products over ℤ_p), built on the SIS problem. Catalano and Fiore (2013) extended to multilinear maps and arithmetic circuits. Gorbunov, Vaikuntanathan, and Wichs (2015) constructed fully homomorphic signatures for arbitrary polynomial-size circuits from standard lattice assumptions. Homomorphic signatures are related to [Homomorphic MACs](categories/09-commitments-verifiability.md#verifiable-computation-vc) (which require a secret verification key) and are used in verifiable computation and authenticated data structures.

| Scheme | Year | Class | Note |
|--------|------|-------|------|
| **Boneh-Freeman Lattice HS** | 2011 | Linear functions | SIS-based; first lattice homomorphic signature [[1]](https://eprint.iacr.org/2010/543) |
| **Catalano-Fiore HS** | 2013 | Arithmetic circuits (pairings) | Multilinear-map HS; extended to degree-d polynomials [[1]](https://eprint.iacr.org/2012/527) |
| **Gorbunov-Vaikuntanathan-Wichs Leveled HS** | 2015 | Polynomial-size circuits | Fully homomorphic sig from lattices; circuit privacy; standard LWE [[1]](https://eprint.iacr.org/2014/463) |
| **Context-Hiding HS (Fleischhacker et al.)** | 2016 | Linear / circuits | Hides intermediate computation path; output σ_f reveals nothing about σᵢ [[1]](https://eprint.iacr.org/2016/457) |

**State of the art:** Lattice-based leveled homomorphic signatures (Gorbunov et al. 2015) support arbitrary circuits and achieve context-hiding. Applications include verifiable outsourced ML (model training on signed data), authenticated stream processing, and [Verifiable FHE](#verifiable-fhe). See also [Sanitizable Signatures](categories/08-signatures-advanced.md#sanitizable-signatures) for a related but weaker primitive.

---

## Single-Key vs. Multi-Key FHE

**Goal:** Understand the design space between standard FHE (one key pair, one data owner) and multi-key FHE (data encrypted under independent keys can be jointly computed on). The choice determines deployment model, decryption trust assumptions, and performance.

In *single-key FHE*, all ciphertexts are encrypted under a single public key controlled by one party (or a single key authority). This covers the standard BFV/BGV/CKKS/TFHE setting and is the deployment model for cloud analytics and ML-as-a-service where a single data owner outsources computation. In *multi-key FHE (MKFHE)*, ciphertexts encrypted under *different, independently generated* public keys can be combined into a joint ciphertext supporting homomorphic evaluation; decryption requires all key holders to participate (typically via a threshold or joint decryption protocol).

The key trade-off: single-key FHE is more efficient (no key-extension overhead) but requires a shared key — impractical when data comes from mutually distrusting parties. MKFHE allows truly independent key generation but introduces *key extension* (converting a single-key ciphertext to a multi-key ciphertext online, after seeing all participating parties) and *noise growth* proportional to the number of parties N. Threshold FHE is a middle ground: keys are generated via a distributed key generation (DKG) protocol upfront, sharing a joint public key while distributing the secret; joint decryption requires a threshold of parties.

| Model | Decryption | Key setup | Cost overhead | Reference construction |
|-------|-----------|-----------|---------------|----------------------|
| **Single-key FHE** | One party | None | Baseline | BFV/BGV/CKKS/TFHE [[1]](https://eprint.iacr.org/2011/277) |
| **Multi-Key FHE** | All N parties (interactive) | Independent | O(N) noise growth; online key extension | López-Alt et al. 2012 NTRU-MKFHE [[1]](https://eprint.iacr.org/2011/613) |
| **Multi-Key CKKS** | All N parties | Independent | Online expansion; practical for small N | Chen-Chillotti-Song 2019 [[1]](https://eprint.iacr.org/2019/524) |
| **Threshold FHE (t-of-N)** | t parties | DKG upfront | Shamir share decryption; no online expansion | Boneh et al. 2018 [[1]](https://eprint.iacr.org/2017/257) |
| **Universal Thresholdizer** | t-of-N | CRS-based | Convert any FHE to threshold post-hoc | Boneh-Garg-Gentry et al. 2018 [[1]](https://eprint.iacr.org/2017/257) |

**State of the art:** Single-key CKKS/BFV/TFHE for cloud use cases; multi-key CKKS (Chen-Chillotti-Song) for federated settings; threshold BFV/CKKS via the Universal Thresholdizer (Boneh et al. 2018) for blockchain and MPC-in-the-head applications. See also [Multi-Key / Threshold FHE](#multi-key--threshold-fhe) and [Multi-Party Computation](categories/06-multi-party-computation.md#multi-party-computation-mpc).

---

## Paillier Additively Homomorphic Encryption

**Goal:** Compute encrypted sums without decryption. Paillier (1999) is a public-key scheme supporting unbounded additions and scalar multiplications on ciphertexts, with security based on the Decisional Composite Residuosity (DCR) assumption. It remains one of the most widely deployed partially homomorphic schemes due to its simplicity, provable security, and efficient aggregation properties.

Pascal Paillier's scheme operates in ℤ_n² where n = pq is an RSA modulus. The public key is n (and generator g = n+1); the secret key is the Carmichael function λ(n). Encrypting a plaintext m ∈ ℤ_n: choose random r ∈ ℤ_n*, output c = gᵐ · rⁿ mod n². Decryption uses the discrete logarithm in the subgroup generated by g (easily computed given λ). The homomorphic properties follow from the group structure: c₁ · c₂ mod n² decrypts to m₁ + m₂ mod n, and c₁ᵏ mod n² decrypts to k·m₁ mod n (scalar multiplication). The scheme is *additively homomorphic* — arbitrary additions and free scalar multiplications, but no multiplication of two ciphertexts.

The IND-CPA security of Paillier is tightly equivalent to the DCR assumption: the difficulty of distinguishing n-th power residues mod n² from non-residues. The scheme is CPA-secure and can be made CCA2-secure via standard transforms.

Paillier's additive homomorphism is ideal for privacy-preserving aggregation: secure summation in federated learning, e-voting tallying (each ballot is an encryption of 0 or 1; votes are multiplied homomorphically, then decrypted to obtain the sum), and input-aggregating MPC subprotocols. The Damgård-Jurik generalization (2001) lifts the scheme to ℤ_nˢ for larger plaintext spaces with the same DCR security.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Paillier** | 1999 | DCR (ℤ_n²) | Additive HE; unbounded additions; widely deployed [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_16) |
| **Damgård-Jurik generalization** | 2001 | DCR (ℤ_nˢ) | Larger plaintext space; same DCR security; batch decryption [[1]](https://eprint.iacr.org/2000/072) |
| **Threshold Paillier (Fouque-Poupard-Stern)** | 2000 | DCR + Shamir | Distributed decryption; no single key holder; used in MPC [[1]](https://link.springer.com/chapter/10.1007/3-540-46035-7_20) |
| **Paillier in Federated Learning** | 2017 | DCR | Additive aggregation of encrypted model updates; practical FL [[1]](https://arxiv.org/abs/1702.07476) |

**State of the art:** Paillier and Threshold Paillier (Fouque-Poupard-Stern) are production-grade and deployed in e-voting systems, privacy-preserving analytics, and federated learning pipelines. For richer computation (multiplications) see [BGV/BFV](#homomorphic-encryption-he); for the multiplicative analogue see [ElGamal & Multiplicatively Homomorphic Encryption](#elgamal--multiplicatively-homomorphic-encryption).

---

## ElGamal & Multiplicatively Homomorphic Encryption

**Goal:** Compute encrypted products without decryption. Several classical schemes — ElGamal (1985), RSA textbook encryption, and Goldwasser-Micali (1982) — each support exactly one type of homomorphic operation, providing historically important partially homomorphic building blocks used in mix-nets, e-voting, and blind computation.

**ElGamal (multiplicative HE).** In a prime-order group G of order q with generator g, a public key is h = gˢ (secret key s). Encryption of m: choose random r, output (gʳ, mhʳ). The product of two ciphertexts (gʳ¹, m₁hʳ¹) · (gʳ², m₂hʳ²) = (gʳ¹⁺ʳ², m₁m₂ · hʳ¹⁺ʳ²) decrypts to m₁m₂ — unbounded homomorphic multiplication over the plaintext group. Decryption requires solving a discrete log if m is large, so ElGamal HE is typically used with small plaintexts or via lookup tables. Security relies on the Decisional Diffie-Hellman (DDH) assumption. Elliptic-curve variants (ElGamal over E(𝔽_p)) are standard in mix-net re-encryption schemes (Wikström, Bayer-Groth shuffles).

**Textbook RSA (multiplicative HE).** RSA ciphertexts satisfy c₁ · c₂ mod n = (m₁m₂)ᵉ mod n — encrypting the product. This is purely educational: textbook RSA is deterministic, not semantically secure, and subject to many attacks. It demonstrates that RSA's group structure implies multiplicative homomorphism, but is never used directly for computation.

**Goldwasser-Micali (XOR / bit-level HE).** Proposed at STOC 1982 and the first provably secure public-key encryption scheme, Goldwasser-Micali (GM) is probabilistic and bit-by-bit. The public key includes n = pq and a quadratic non-residue x mod n. Encrypting a bit b: choose random r, output c = xᵇ r² mod n. The product of two ciphertexts encrypts b₁ ⊕ b₂ (XOR) because quadratic residues form a subgroup — multiplying two encryptions of bits is equivalent to XOR of plaintexts. GM is semantically secure under the Quadratic Residuosity (QR) assumption. It is *XOR-homomorphic*: supports unbounded additions mod 2 (XOR), but no AND. Historically, GM was the first IND-CPA scheme; it is superseded in efficiency by Paillier (larger plaintexts) and modern FHE, but remains a textbook reference for semantic security.

| Scheme | Year | Basis | Homomorphism | Note |
|--------|------|-------|-------------|------|
| **Goldwasser-Micali** | 1982 | QR (quadratic residuosity) | XOR (bit-level) | First IND-CPA scheme; bit-by-bit; large ciphertext expansion [[1]](https://dl.acm.org/doi/10.1145/800070.802212) |
| **ElGamal** | 1985 | DDH | Multiplicative (group) | Re-randomizable; used in mix-nets and e-voting [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_31) |
| **EC-ElGamal** | 1987 | ECDLP / DDH on curves | Multiplicative | Shorter keys; used in Bayer-Groth mix-nets and PVSS [[1]](https://eprint.iacr.org/2012/377) |
| **Textbook RSA** | 1977 | RSA / factoring | Multiplicative | Educational only; not IND-CPA; illustrates mod-n structure [[1]](https://dl.acm.org/doi/10.1145/359340.359342) |
| **Benaloh** | 1994 | Higher residuosity | Additive (mod r) | Generalizes GM to larger plaintext space; basis of some e-voting schemes [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_29) |

**State of the art:** ElGamal (EC variant) is deployed in mix-nets (Verificatum, Bayer-Groth shuffles) and threshold decryption systems. Goldwasser-Micali is foundational but not practical (1-bit ciphertexts). For additive HE with larger plaintexts see [Paillier](#paillier-additively-homomorphic-encryption); for fully homomorphic computation see [HE (FHE/SHE)](#homomorphic-encryption-he).

---

## Inner-Product Functional Encryption (IPFE)

**Goal:** Reveal only the inner product ⟨**x**, **y**⟩ of an encrypted vector **x** with a key vector **y**, nothing more. A decryptor holding a functional key for **y** learns the linear combination Σ xᵢyᵢ from the ciphertext encrypting **x** — but cannot recover individual components of **x** or evaluate any other function.

Abdalla, Bourse, De Caro, and Pointcheval (PKC 2015) gave the first practical constructions of secret-key and public-key IPFE for integer vectors over ℤ. Their DDH-based public-key scheme is straightforward: the master public key includes group elements {gˢⁱ} for a secret vector **s**; encrypting **x** produces a ciphertext encoding {gˣⁱ} with DDH-blinding; a functional key for **y** is dk_y = g^{⟨**s**,**y**⟩}; decryption computes g^{⟨**x**,**y**⟩} via the pairing structure, then recovers ⟨**x**,**y**⟩ by discrete-log lookup (feasible for small output range). LWE-based IPFE (same paper) supports larger plaintext spaces without discrete-log extraction.

IPFE sits at the base of the functional encryption hierarchy: it is *degree-1* FE (linear functions), efficiently instantiated from standard assumptions (DDH, LWE, DCR), selectively or adaptively secure, and has tight reductions in several constructions. It is the building block for [Quadratic FE](#quadratic--degree-2-functional-encryption), [Function-Hiding IPFE](#function-hiding-inner-product-functional-encryption-fh-ipfe), [DMCFE](#decentralized-multi-client-functional-encryption-dmcfe), and structured output ML (secure dot-product computation).

The Agrawal-Libert-Stehlé (CRYPTO 2016) construction achieved adaptive security under the LWE assumption, closing the selective-vs-adaptive gap. Kim and Lewi (2018) gave tight constructions under DDH. The multi-input variant (Goldwasser et al. 2014; Abdalla et al. 2019) allows separate encrypting parties whose ciphertexts combine to reveal joint inner products.

| Scheme | Year | Assumption | Security | Note |
|--------|------|------------|----------|------|
| **Abdalla-Bourse-De Caro-Pointcheval IPFE** | 2015 | DDH, LWE, DCR | Selective | First practical IPFE; secret-key and public-key variants [[1]](https://eprint.iacr.org/2015/017) |
| **Agrawal-Libert-Stehlé IPFE** | 2016 | LWE | Adaptive | Adaptively secure IPFE from LWE; tight reduction [[1]](https://eprint.iacr.org/2015/608) |
| **Tight DDH IPFE (Kim-Lewi)** | 2018 | DDH | Tight adaptive | Tight adaptive security from DDH; no LWE required [[1]](https://eprint.iacr.org/2018/943) |
| **Multi-Input IPFE (Abdalla et al.)** | 2019 | DDH / LWE | Selective | Multiple encryptors; joint inner product; practical [[1]](https://eprint.iacr.org/2017/972) |
| **IPFE with Function Privacy (FH-IPFE)** | 2015 | SXDH | Selective | Hides key vector y as well; see [FH-IPFE](#function-hiding-inner-product-functional-encryption-fh-ipfe) [[1]](https://eprint.iacr.org/2015/672) |

**State of the art:** DDH-based IPFE (Abdalla et al. 2015) for practical deployments; LWE-based IPFE (Agrawal et al. 2016) for post-quantum. Deployed in privacy-preserving statistics, biometric authentication, and encrypted ML inference pipelines. See [FH-IPFE](#function-hiding-inner-product-functional-encryption-fh-ipfe) when the key vector must also be hidden, and [Quadratic FE](#quadratic--degree-2-functional-encryption) for degree-2 generalization.

---

## FHE Benchmarks & Performance

**Goal:** Quantify practical costs of FHE operations across schemes and libraries so practitioners can select the right scheme for a workload. Benchmarks measure latency, throughput, and memory for representative operations: ciphertext multiplication, bootstrapping, linear transforms, and end-to-end ML inference.

FHE performance has improved by roughly 10⁶× from Gentry's 2009 construction (hours per gate) to TFHE-rs 2024 (microseconds per gate with GPU). The gap between FHE and plaintext computation closed from ~10⁹× to ~10³–10⁵× depending on the operation and scheme. Key performance axes: (1) *latency per gate* (TFHE/FHEW-family); (2) *throughput per slot* (CKKS/BFV with SIMD); (3) *bootstrapping cost* (dominant in unbounded-depth circuits).

Representative 2024 benchmarks on commodity hardware (single CPU core, 128-bit security):

| Operation | Scheme / Library | Latency | Throughput |
|-----------|-----------------|---------|-----------|
| **Boolean NAND gate** | TFHE-rs 0.7 | ~7 µs | ~140K gates/s |
| **Programmable bootstrap (8-bit LUT)** | TFHE-rs 0.7 | ~15 µs | — |
| **CKKS mul + rescale (n=2¹⁶)** | OpenFHE 1.2 | ~30 ms | ~35K slots/s |
| **CKKS bootstrapping (n=2¹⁶)** | OpenFHE 1.2 | ~5 s | ~6K slots bootstrap/s |
| **BFV mul (n=2¹⁴)** | Microsoft SEAL 4.1 | ~10 ms | — |
| **GPU CKKS mul** | HEAAN-GPU / CuFHE | ~1 ms | ~500K slots/s |
| **AES-128 eval in TFHE** | TFHE-rs | ~10 s | — |

Comparative library evaluation (2023–2025 academic studies):

| Library | Schemes | Best Use Case | Note |
|---------|---------|--------------|------|
| **OpenFHE** | BFV, BGV, CKKS, TFHE | Research; all schemes; GPU support | [[1]](https://eprint.iacr.org/2022/915) |
| **Microsoft SEAL** | BFV, BGV, CKKS | Production CKKS/BFV; AVX-512 via HEXL | [[1]](https://github.com/microsoft/SEAL) |
| **TFHE-rs (Zama)** | TFHE | Boolean/integer FHE; Rust; production | [[1]](https://github.com/zama-ai/tfhe-rs) |
| **HElib** | BGV, CKKS | Research; advanced packing; bootstrapping | [[1]](https://github.com/homenc/HElib) |
| **Concrete (Zama)** | TFHE | Python-to-FHE compiler; Concrete ML | [[1]](https://github.com/zama-ai/concrete) |
| **HEIR (Google)** | BFV/BGV/CKKS/TFHE | Compiler IR; multi-backend code gen | [[1]](https://github.com/google/heir) |

**State of the art:** TFHE-rs achieves ~7 µs/gate on CPU for Boolean FHE and ~2× speedup on GPU; GPU-accelerated CKKS (OpenFHE GPU, HEAAN-GPU) reaches ~1 ms per ciphertext multiplication with n=2¹⁶. End-to-end encrypted ResNet-20 inference takes ~400 s on CPU (CKKS) vs. ~10 s with GPU acceleration (2024). The HE.org community benchmark suite [[1]](https://homomorphicencryption.org/standard/) provides standardized parameter sets and reproducible measurements. Related: [HEIR](#heir-homomorphic-encryption-intermediate-representation), [Concrete & Concrete ML](#concrete--concrete-ml-zama), [FHE Amortization & Batching](#fhe-amortization--batching-simd-packing).

---

## Obfuscation-Based & General-Circuit Functional Encryption

**Goal:** Support functional decryption for arbitrary polynomial-size circuits — the most general class of functional encryption. Given a ciphertext encrypting **x** and a functional key for any circuit C, a decryptor recovers C(**x**) without learning anything else. General-circuit FE is the apex of the FE hierarchy and is closely tied to indistinguishability obfuscation (iO).

Boneh, Sahai, and Waters (TCC 2011) formalized the functional encryption framework and proved that FE for general circuits implies iO — i.e., general-circuit FE is essentially equivalent to iO in power. Constructive implications run the other direction: iO together with one-way functions yields general-circuit FE (Garg, Gentry, Halevi, Raykova, Sahai, Waters — FOCS 2013). The resulting FE schemes are *compact* (ciphertext size independent of circuit size) but rely on multilinear maps or iO candidates whose concrete security is still debated.

A parallel line of work builds FE for *bounded-depth circuits* (NC¹ or polynomial depth) from falsifiable assumptions. Garg et al. (2013) and Ananth-Jain (2015) gave constructions from LWE + iO; Ananth-Sahai (2016) built compact FE for NC¹ from LWE alone. For the full class P/poly, the current state requires either (a) iO (which in turn requires new multilinear map or sum-of-squares hardness assumptions) or (b) strong variants of LWE plus additional structure.

*Obfuscation-based FE for specific classes* avoids full iO: Wee (2017) built FE for regular languages from pairings; Brakerski-Cole-Döttling (2021) gave compact FE for bounded-width branching programs from LWE + oblivious RAM techniques. These achieve selective or adaptive security with essentially optimal ciphertext sizes.

| Scheme | Year | Circuit Class | Assumption | Note |
|--------|------|-------------|------------|------|
| **Boneh-Sahai-Waters FE framework** | 2011 | General circuits (theoretical) | — | Formalized FE; proved FE ↔ iO equivalence [[1]](https://eprint.iacr.org/2010/543) |
| **Garg-Gentry-Halevi-Raykova-Sahai-Waters FE** | 2013 | General circuits | Multilinear maps + LWE | First general-circuit FE from iO; FOCS 2013 [[1]](https://eprint.iacr.org/2012/323) |
| **Ananth-Sahai compact FE** | 2016 | NC¹ | LWE (sub-exp) | Compact FE for NC¹ without iO; polynomial-size ciphertexts [[1]](https://eprint.iacr.org/2015/1017) |
| **Wee FE for Regular Languages** | 2017 | DFAs / regular languages | Pairings (DLIN) | FE for DFAs; ciphertext encodes string; key encodes DFA [[1]](https://eprint.iacr.org/2017/972) |
| **Brakerski et al. compact FE** | 2021 | Bounded-width BPs | LWE + ORAM | Compact FE for NC¹-equivalent branching programs [[1]](https://eprint.iacr.org/2020/1304) |

**State of the art:** General-circuit FE remains a theoretical frontier, with concrete instantiations depending on iO candidates (see [Obfuscation & iO](categories/16-obfuscation-advanced-hardness.md#indistinguishability-obfuscation-io)). FE for bounded function classes (inner products, quadratics, regular languages, NC¹) from standard assumptions is an active research area. Practical deployments use [IPFE](#inner-product-functional-encryption-ipfe) or [ABE](#attribute-based--functional-encryption); general-circuit FE is not yet deployed. See also [Quadratic FE](#quadratic--degree-2-functional-encryption) and [FH-IPFE](#function-hiding-inner-product-functional-encryption-fh-ipfe).

---

## Number Theoretic Transform (NTT) in FHE

**Goal:** Accelerate polynomial multiplication — the bottleneck operation in all RLWE-based FHE schemes — from O(n²) naive multiplication to O(n log n) using the Number Theoretic Transform, the finite-field analogue of the Fast Fourier Transform.

All modern FHE schemes (BFV, BGV, CKKS, TFHE) perform arithmetic over quotient rings ℤ_q[X]/(Xⁿ + 1) where n is a power of two. The dominant cost is polynomial multiplication: computing the product of two degree-(n−1) polynomials mod (Xⁿ + 1) mod q. Naively this is O(n²) coefficient multiplications. The NTT replaces this with three steps: NTT-forward on both inputs (O(n log n)), pointwise multiplication (O(n)), and NTT-inverse (O(n log n)). This requires choosing q such that q ≡ 1 (mod 2n) — guaranteeing a primitive 2n-th root of unity ω in ℤ_q — and precomputing twiddle factors ωᵢ. The negacyclic NTT (for the ring ℤ_q[X]/(Xⁿ + 1) rather than ℤ_q[X]/(Xⁿ − 1)) uses a twisted variant where inputs are pre-multiplied by powers of √ω before the transform.

In practice, FHE parameters use the Residue Number System (RNS): the modulus Q is a product of small 60-bit primes q₁ · q₂ · … · qₗ, each satisfying qᵢ ≡ 1 (mod 2n). Each coefficient of the ciphertext polynomial is represented modulo each qᵢ independently, so all NTT operations use 64-bit arithmetic without big integers. Hardware accelerators (GPUs, FPGAs, ASICs) exploit the data-parallelism of the butterfly network and the RNS decomposition to achieve 10–100× speedups over CPU implementations.

| Component | Detail |
|-----------|--------|
| **Transform size** | n = 2¹⁰ to 2¹⁶ (ring degree); NTT of length 2n (negacyclic) |
| **Modulus constraint** | Each RNS prime q ≡ 1 (mod 2n); enables primitive 2n-th root of unity |
| **Butterfly network** | Cooley-Tukey (DIT) or Gentleman-Sande (DIF); log₂(n) stages, n/2 butterflies each |
| **RNS decomposition** | Q = q₁ · … · qₗ; independent NTT per prime; no big-integer arithmetic |
| **Key-switching NTT** | Relinearization and rotation each require additional NTT calls; dominant latency contributor |

| Implementation | Platform | Note |
|----------------|----------|------|
| **Intel HEXL** | CPU (AVX-512) | Vectorized NTT/RNS for SEAL and OpenFHE; 2–4× speedup over scalar C++ [[1]](https://eprint.iacr.org/2021/420) |
| **cuFHE / nuFHE** | GPU (CUDA) | GPU-accelerated TFHE; batched NTT over LWE ciphertexts [[1]](https://github.com/vernamlab/cuFHE) |
| **F1 FPGA accelerator** | FPGA | MIT/Draper F1; dedicated NTT datapath for BFV/BGV [[1]](https://dl.acm.org/doi/10.1145/3470496.3527404) |
| **BASALISC** | ASIC | Google FHE ASIC; on-chip NTT engines; 1000× CPU throughput [[1]](https://eprint.iacr.org/2022/657) |

**State of the art:** Intel HEXL provides production-grade AVX-512 NTT integrated into SEAL and OpenFHE. GPU NTT (TFHE-rs GPU backend) enables batched bootstrapping. ASIC accelerators (F1, BASALISC) achieve orders-of-magnitude speedups but require custom hardware. NTT is also the core primitive inside [FHEW Bootstrapping](#fhew-bootstrapping) (blind rotation over a ring) and [CKKS Approximate Arithmetic & Rescaling](#ckks-approximate-arithmetic--rescaling).

---

## Parameter Selection for BFV / BGV / CKKS

**Goal:** Choose cryptographic parameters (ring degree n, ciphertext modulus Q, plaintext modulus t, scaling factor Δ) that simultaneously achieve a target security level, a sufficient noise budget or arithmetic precision, and acceptable performance — without overprovisioning resources.

Parameter selection is a multi-objective optimization problem. Security is measured by the hardness of the underlying RLWE problem: for a given (n, Q), the root Hermite factor δ or the required BKZ blocksize determines the bit-security against lattice attacks. The Homomorphic Encryption Standard (HES, 2021) tabulates (n, log Q) pairs achieving λ = 128, 192, and 256 bits of classical security, derived from the LWE estimator. Noise management is scheme-specific:

**BFV/BGV (exact integer arithmetic):** The noise budget decreases by roughly log(t) bits per multiplication (BGV) or grows multiplicatively (BFV). Setting L multiplication levels requires log Q ≈ L · log(q_i) + log(q_0), where q_0 holds the final decryption noise floor. The plaintext modulus t must be chosen so that noise stays strictly below t/2 throughout the computation.

**CKKS (approximate arithmetic):** A scaling factor Δ (typically 2⁴⁰–2⁶⁰) maps real numbers to integers; each multiplication consumes one level via rescaling. The ring dimension n must satisfy n ≥ 2 × (number of SIMD slots needed). Bootstrapping for CKKS consumes 10–20 additional levels and requires careful tuning of the cosine-approximation polynomial degree against precision requirements.

The HES parameter standard, OpenFHE's parameter generator, and the `lattice-estimator` tool (Albrecht et al.) automate selection. Parameter choices directly affect ciphertext size: a ring of degree n = 2¹⁶ with log Q = 1740 bits (supporting ~29 levels at λ = 128) yields ciphertexts of approximately 430 KB — critical for network-constrained deployments.

| Parameter | BFV/BGV | CKKS | Impact |
|-----------|---------|------|--------|
| Ring degree n | 2¹²–2¹⁶ | 2¹²–2¹⁶ | Security, slot count, NTT cost |
| log Q (total modulus) | 60–1800 bits | 60–1800 bits | Circuit depth, security level |
| Plaintext modulus t | prime, t < q | — (scaling Δ used) | Message space, noise budget (BGV) |
| Scaling factor Δ | — | 2⁴⁰–2⁶⁰ | Fixed-point precision, noise growth |
| Multiplicative levels L | ≈ log Q / log q_i | ≈ log Q / log Δ | Supported circuit depth |

| Resource / Tool | Description |
|-----------------|-------------|
| **HES Parameter Standard (2021)** | Tabulates (n, log Q) pairs for λ = 128, 192, 256 bits [[1]](https://homomorphicencryption.org/wp-content/uploads/2018/11/HomomorphicEncryptionStandardv1.1.pdf) |
| **lattice-estimator (Albrecht et al.)** | Python tool estimating LWE hardness from (n, q, σ, secret distribution) [[1]](https://github.com/malb/lattice-estimator) |
| **OpenFHE parameter generator** | Automated CKKS/BFV parameter generation given depth and security target [[1]](https://github.com/openfheorg/openfhe-development) |
| **CKKS parameter selection guide (Cheon et al.)** | Systematic analysis of precision-depth-security tradeoffs in CKKS [[1]](https://eprint.iacr.org/2020/1118) |

**State of the art:** The HES standard and `lattice-estimator` are the authoritative references. OpenFHE and SEAL validate parameters against these tables at key-generation time. CKKS parameter selection remains the most nuanced (precision vs. depth vs. bootstrapping overhead tradeoff) and is an active area of tooling development. Related to [NTT in FHE](#number-theoretic-transform-ntt-in-fhe) (performance impact) and [FHEW Bootstrapping](#fhew-bootstrapping) (level consumption during refresh).

---

## HE for Healthcare & Genomics

**Goal:** Enable computation on sensitive biomedical data — patient records, genomic sequences, clinical statistics — while the data remains encrypted, so research institutions and cloud services never see individual plaintext health information.

Healthcare and genomics are high-value FHE application domains because the data is both highly sensitive (HIPAA/GDPR-regulated) and statistically rich. Key workflows include:

**Genome-Wide Association Studies (GWAS):** Statistical tests (chi-squared, logistic regression) over millions of SNP markers against a phenotype. Kim, Song, Kim, Lee, and Cheon (iDASH 2018 winner) showed that CKKS can evaluate regularized logistic regression on an encrypted genomic dataset in minutes by encoding cohort-level statistics as CKKS vectors and evaluating the score test homomorphically. The iDASH competition (annual) benchmarks encrypted GWAS, secure genotype imputation, and encrypted DNA string matching.

**Encrypted genotype imputation:** Predicting missing SNP values from a reference panel. Blatt, Gusev, Polyak, and Goldwasser (2020) demonstrated CKKS-based imputation using a linear regression model evaluated homomorphically on encrypted target genotypes, matching plaintext accuracy.

**Privacy-preserving patient record matching:** Identifying records belonging to the same patient across independent hospital databases without revealing patient identity. FHE-based approaches encode patient identifiers (name tokens, date of birth) as polynomial representations and find encrypted intersections without exposing the underlying data.

**Encrypted EHR analytics:** Running aggregate statistics (means, covariances, logistic regression) on encrypted electronic health records for multi-site federated research. The HELR scheme (Kim et al. 2018) demonstrated practical CKKS-based logistic regression over encrypted datasets with thousands of patients.

| Work / System | Year | Scheme | Task | Note |
|---------------|------|--------|------|------|
| **iDASH GWAS (Kim et al.)** | 2018 | CKKS | Encrypted logistic regression on SNP data | iDASH competition winner; practical runtime [[1]](https://eprint.iacr.org/2018/254) |
| **HELR (Kim et al.)** | 2018 | CKKS | Logistic regression on encrypted EHR | Mini-batch gradient descent on CKKS-encrypted cohort data [[1]](https://eprint.iacr.org/2018/657) |
| **Encrypted genotype imputation (Blatt et al.)** | 2020 | CKKS | Impute missing SNPs from reference panel | Homomorphic linear model; matches plaintext accuracy [[1]](https://www.pnas.org/doi/10.1073/pnas.1918257117) |
| **THEMIS (patient record linkage)** | 2022 | BFV + PSI | Privacy-preserving record linkage across hospitals | Combines FHE with PSI for cross-institution patient matching [[1]](https://eprint.iacr.org/2022/1464) |
| **CryptoNets** | 2016 | BFV | Neural network inference on encrypted clinical data | First demonstration of FHE-based clinical ML inference [[1]](https://proceedings.mlr.press/v48/gilad-bachrach16.html) |
| **POSEIDON (federated genomics)** | 2021 | CKKS | Federated GWAS across institutions | Multi-party CKKS; privacy-preserving federated genome analysis [[1]](https://www.nature.com/articles/s41467-021-25972-y) |

**State of the art:** CKKS-based logistic regression (Kim et al.) is the benchmark for encrypted GWAS. The iDASH competition annually tracks performance improvements. Patient record linkage combines [PSI](categories/10-privacy-preserving-computation.md#private-set-intersection-psi) and FHE. [Concrete ML](#concrete--concrete-ml-zama) and OpenFHE provide accessible libraries for healthcare researchers.

---

## FHE Applications in Cloud Computing

**Goal:** Allow cloud providers to perform useful computation — database queries, search, analytics, and ML serving — on customer data that remains encrypted end-to-end, so even a compromised or untrusted cloud sees only ciphertexts throughout.

Cloud FHE is the original motivation for fully homomorphic encryption. Practical deployments span several categories:

**Encrypted search / searchable FHE:** A client uploads an encrypted database; queries arrive as encrypted keywords; the server evaluates a search predicate homomorphically and returns encrypted matching records. Unlike [Searchable Symmetric Encryption (SSE)](categories/10-privacy-preserving-computation.md#searchable-encryption-sse--peks) (which leaks access patterns), FHE-based search reveals only the encrypted result. CKKS or BFV can encode inverted indexes as packed ciphertext vectors and evaluate inner products (keyword match scores) homomorphically.

**Encrypted SQL and oblivious databases:** Evaluating SQL-like queries (SELECT, GROUP BY, SUM, AVG) over encrypted relational tables. Systems like CryptDB (Popa et al. 2011) used layered partially homomorphic encryption with onion decryption at the server; more recent works push toward full FHE with CKKS aggregates and BFV exact predicates combined with ORAM for oblivious access patterns.

**Private information retrieval (PIR) via FHE:** A client retrieves a database record by index without revealing which record it accessed. SealPIR (Angel et al. 2018) uses BFV to encode the database as a polynomial and evaluate the selection predicate homomorphically, achieving sub-second single-server PIR for databases of millions of records.

**FHE for encrypted cloud ML serving:** A cloud ML provider runs model inference on client-encrypted inputs. The client submits an FHE ciphertext; the server evaluates the neural network homomorphically and returns an encrypted prediction. Zama's fhEVM extends this concept to Ethereum smart contracts: contract state is encrypted under TFHE, and transactions trigger FHE evaluation on-chain.

| System / Work | Year | Scheme | Application | Note |
|---------------|------|--------|-------------|------|
| **CryptDB** | 2011 | OPE / Paillier (partial) | Encrypted SQL with layered encryption | Practical but not FHE; leaks order/equality via onion decryption [[1]](https://dl.acm.org/doi/10.1145/2043556.2043566) |
| **SealPIR** | 2018 | BFV | Sub-second single-server PIR | FHE-based PIR; O(√n) communication; practical for large DBs [[1]](https://eprint.iacr.org/2017/1142) |
| **SimplePIR (Henzinger et al.)** | 2023 | LWE | Fast PIR with amortized offline phase | Near-bandwidth-optimal single-server PIR; 10 GB/s throughput [[1]](https://eprint.iacr.org/2022/949) |
| **Pegasus (encrypted ML serving)** | 2021 | CKKS + TFHE | Hybrid FHE inference (CNN) | Switches between CKKS (linear layers) and TFHE (non-linear activations) [[1]](https://eprint.iacr.org/2020/1219) |
| **fhEVM (Zama)** | 2023 | TFHE-rs | Encrypted Ethereum smart contracts | EVM state encrypted; FHE evaluation triggered on-chain [[1]](https://github.com/zama-ai/fhevm) |
| **HEAR (encrypted SQL aggregates)** | 2022 | BFV + CKKS | Homomorphic SUM/AVG/COUNT on encrypted tables | SQL aggregates on encrypted relational data with formal query privacy [[1]](https://eprint.iacr.org/2022/1410) |

**State of the art:** FHE-based PIR (SealPIR, SimplePIR) is practically deployable today. Hybrid CKKS+TFHE inference (Pegasus) is the leading approach for encrypted cloud ML serving. fhEVM (Zama) is deployed on the Fhenix testnet. Full encrypted SQL at scale remains an open challenge due to FHE's overhead on comparison and sorting; [ORAM](categories/10-privacy-preserving-computation.md#oblivious-ram-oram) and [PIR](categories/10-privacy-preserving-computation.md#private-information-retrieval-pir) are complementary building blocks.

---

## FHE for Private Neural Network Training

**Goal:** Train a machine learning model on private data without the training server ever seeing plaintext inputs, labels, or intermediate gradients — enabling cross-institution model training where data cannot be legally or contractually shared.

Private neural network training is harder than inference: training requires many rounds of gradient computation via backpropagation, which involves non-polynomial activations (ReLU, softmax), high-precision floating-point arithmetic, and iterative parameter updates — all of which are expensive under FHE. Three main approaches have emerged:

**Pure FHE training:** Evaluate the full forward and backward pass homomorphically. Activation functions are approximated by low-degree polynomials (e.g., ReLU ≈ x²/4 + x/2; sigmoid ≈ a degree-3 or degree-5 Chebyshev approximation). CKKS supports the approximate arithmetic required for gradient descent. Kim and colleagues (2018, 2020) demonstrated CKKS-based training of logistic regression and shallow networks on encrypted datasets; deep networks remain computationally prohibitive without bootstrapping support.

**Hybrid FHE and MPC training:** Use FHE for the data-owner-to-server interface (encrypted input upload) and secure MPC among computation nodes for gradient aggregation. Systems like CrypTen (Meta's PyTorch extension for MPC-based ML) use this architecture without full FHE, providing a complementary privacy-preserving training path.

**Federated learning with FHE gradient aggregation:** Each data-holding client trains locally and sends encrypted gradient updates; the server aggregates gradients homomorphically under FHE (typically Paillier or CKKS) without seeing individual gradients. The FATE platform, PySyft, and OpenMined support Paillier/CKKS-encrypted federated aggregation, making this the most widely deployed approach.

| System / Work | Year | Scheme | Task | Note |
|---------------|------|--------|------|------|
| **HELR training (Kim et al.)** | 2018 | CKKS | Encrypted logistic regression training | Mini-batch gradient descent on CKKS-encrypted data; matches plaintext convergence [[1]](https://eprint.iacr.org/2018/657) |
| **HEAR deep training (Han-Ki)** | 2020 | CKKS + bootstrapping | CNN training on encrypted data | Uses CKKS bootstrapping to sustain multi-layer backpropagation [[1]](https://eprint.iacr.org/2020/050) |
| **FATE (Federated AI Technology Enabler)** | 2019 | Paillier | Federated learning with encrypted gradient aggregation | Production FL platform; Paillier aggregation; deployed at WeBank [[1]](https://arxiv.org/abs/1902.04885) |
| **CrypTen (Meta)** | 2021 | SPDZ-based MPC | Privacy-preserving PyTorch training | MPC rather than FHE; complementary approach; open-source [[1]](https://arxiv.org/abs/2109.00548) |
| **Pegasus hybrid (CNN with non-linear layers)** | 2021 | CKKS + TFHE | Inference and lightweight fine-tuning | Hybrid scheme handles ReLU via TFHE programmable bootstrap during training [[1]](https://eprint.iacr.org/2020/1219) |
| **AutoFHE (NAS for FHE-friendly models)** | 2023 | CKKS | Architecture search for FHE-trainable networks | Neural architecture search targeting low-degree polynomial activations [[1]](https://eprint.iacr.org/2023/1016) |

**State of the art:** Encrypted federated learning with Paillier/CKKS aggregation (FATE, PySyft) is production-deployed at scale. Pure FHE training (Kim, Han-Ki) is feasible for logistic regression and shallow networks but not yet for large models. The dominant bottleneck is non-polynomial activations: [TFHE programmable bootstrapping](#fhew-bootstrapping) handles ReLU exactly via LUT but is slower than CKKS polynomial approximation for deep networks. [Concrete ML](#concrete--concrete-ml-zama) provides user-friendly access to FHE-trained quantized models. Related to [HE for Healthcare & Genomics](#he-for-healthcare--genomics) and [FHE Applications in Cloud Computing](#fhe-applications-in-cloud-computing).

---

## Lattigo (Multiparty HE in Go)

**Goal:** Provide a pure-Go library for lattice-based homomorphic encryption with native support for multiparty (threshold) protocols, targeting distributed systems and microservice architectures.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Lattigo v5** | 2020 | RLWE (BFV, BGV, CKKS) | Full-RNS implementation with multiparty key generation, threshold decryption, and interactive bootstrapping [[1]](https://github.com/tuneinsight/lattigo) |
| **Multiparty CKKS bootstrapping** | 2022 | Threshold CKKS | Distributed bootstrapping with secret-shared keys; enables multi-party approximate-arithmetic FHE [[1]](https://homomorphicencryption.org/wp-content/uploads/2020/12/wahc20_demo_christian.pdf) |

**State of the art:** Lattigo v5 is the leading Go-native HE library, actively maintained by Tune Insight (EPFL spin-off). Its pure-Go implementation enables cross-platform builds including WASM for browser clients. Performance is competitive with C++ libraries for single-threaded workloads. Complements [OpenFHE](#homomorphic-encryption-he) (C++) and [Microsoft SEAL](#microsoft-seal) (C++) by serving the Go/distributed-systems ecosystem.

---

## TenSEAL (Encrypted Tensor Operations)

**Goal:** Provide a Python-first library for homomorphic encryption on tensors, enabling privacy-preserving machine learning with minimal cryptographic expertise by wrapping Microsoft SEAL in a NumPy-like API.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **TenSEAL** | 2021 | CKKS, BFV (via SEAL) | Python/C++ library; encrypted CNN inference on MNIST in under 1 second [[1]](https://arxiv.org/abs/2104.03152) |
| **CKKSVector / BFVVector** | 2021 | RLWE tensors | Supports encrypted dot products, matrix multiplication, and convolutions for ML workloads [[1]](https://github.com/OpenMined/TenSEAL) |

**State of the art:** TenSEAL (OpenMined) is the most widely used Python HE library for ML prototyping, presented at ICLR 2021 DPML Workshop [[1]](https://dp-ml.github.io/2021-workshop-ICLR/files/18.pdf). Integrates with PySyft for federated learning. Limited to leveled HE (no bootstrapping). For production deployment, see [Concrete ML](#concrete--concrete-ml-zama) (which includes a compiler) or [Microsoft SEAL](#microsoft-seal) (C++ back-end).

---

## PhantomFHE (GPU-Accelerated HE)

**Goal:** Accelerate word-wise homomorphic encryption (BFV, BGV, CKKS) on NVIDIA GPUs using CUDA, achieving order-of-magnitude speedups over CPU-only libraries for large-scale encrypted computation.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Phantom** | 2023 | CUDA / RLWE (BFV, BGV, CKKS) | 7x speedup over prior GPU HE for CKKS multiplication; enhanced hybrid key-switching reduces memory overhead [[1]](https://eprint.iacr.org/2023/049) |
| **Phantom bootstrapping** | 2024 | CUDA / CKKS | Amortized bootstrapping at 0.423 us per bit — 257x over single-threaded CPU [[1]](https://dl.acm.org/doi/abs/10.1109/TDSC.2024.3363900) |

**State of the art:** PhantomFHE is published in IEEE TDSC 2024 and available under GPLv3 [[1]](https://github.com/encryptorion-lab/phantom-fhe). It is among the fastest GPU HE implementations, alongside [HEonGPU](#heongpu-gpu-fhe-library) and Cheddar. Does not yet support bootstrapping for all schemes. Compare with [Intel HEXL](#intel-hexl-he-hardware-acceleration) for CPU-side acceleration.

---

## HEonGPU (GPU FHE Library)

**Goal:** Provide a high-performance, multi-stream CUDA library for fully homomorphic encryption (BFV, CKKS, TFHE) that minimizes CPU-GPU data transfer overhead and supports collective bootstrapping.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **HEonGPU** | 2024 | CUDA / BFV, CKKS, TFHE | Multi-stream architecture eliminates host-device transfer bottleneck; supports collective bootstrapping for BFV and CKKS [[1]](https://eprint.iacr.org/2024/1543) |
| **HEonGPU serializer** | 2025 | Compression | Zlib-compressed serialization of HE objects; up to 60% reduction in storage and bandwidth [[1]](https://github.com/Alisah-Ozcan/HEonGPU) |

**State of the art:** HEonGPU (Sabanci University) is one of the few GPU libraries supporting TFHE alongside BFV/CKKS on GPU, enabling gate-level FHE acceleration. Complements [PhantomFHE](#phantomfhe-gpu-accelerated-he) (word-wise focus) and [TFHE-rs](#homomorphic-encryption-he) (CPU Rust). Related to [NTT in FHE](#number-theoretic-transform-ntt-in-fhe) for the polynomial arithmetic kernel.

---

## Apple Swift Homomorphic Encryption

**Goal:** Production-grade, open-source Swift library for BFV homomorphic encryption, designed for Apple ecosystem deployment including iOS 18 Live Caller ID Lookup via private information retrieval (PIR).

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **swift-homomorphic-encryption** | 2024 | BFV (RLWE) | Apple's open-source Swift package; post-quantum 128-bit security parameters; used in iOS 18 Live Caller ID [[1]](https://www.swift.org/blog/announcing-swift-homomorphic-encryption/) |
| **HomomorphicEncryptionProtobuf** | 2024 | Serialization | Protobuf-based ciphertext serialization for client-server PIR queries [[1]](https://github.com/apple/swift-homomorphic-encryption) |

**State of the art:** First major deployment of HE in a consumer operating system (iOS 18, 2024). The Live Caller ID Lookup feature uses keyword PIR over BFV-encrypted queries so the server never learns the queried phone number. Released under Apache 2.0 license. Compared with [Microsoft SEAL](#microsoft-seal) (C++/general-purpose) and [Concrete](#concrete--concrete-ml-zama) (TFHE/compiler-based), Apple's library is narrowly scoped to BFV-PIR but production-hardened for mobile deployment.

---

## Covercrypt (Quantum-Safe ABE KEM)

**Goal:** Efficient attribute-based key encapsulation mechanism (KEM) with hidden access policies, post-quantum security via DDH+LWE hybridization, and user traceability — enabling fine-grained encrypted access control without revealing who the intended recipients are.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Covercrypt** | 2023 | DDH + LWE hybrid | Early-abort KEM for hidden CP-ABE policies with traceability; hundreds of microseconds per encapsulation [[1]](https://eprint.iacr.org/2023/836) |
| **ETSI TS 104 015** | 2025 | Standardization | ETSI standard for quantum-safe hybrid KEMAC; formal security analysis with ECDH + ML-KEM instantiation [[1]](https://eprint.iacr.org/2025/544) |

**State of the art:** Covercrypt is developed by Cosmian and standardized by ETSI as TS 104 015 [[1]](https://link.springer.com/chapter/10.1007/978-3-032-07891-9_5). It is the first attribute-based encryption scheme to achieve an ETSI standard with explicit post-quantum guarantees. Open-source Rust implementation available [[2]](https://github.com/Cosmian/cover_crypt). Related to [Attribute-Based & Functional Encryption](#attribute-based--functional-encryption) and [Multi-Authority ABE](#multi-authority-abe).

---

## Sunscreen (Rust FHE Compiler)

**Goal:** Developer-friendly Rust compiler that automatically transforms annotated Rust functions into optimized FHE circuits, lowering the barrier to building privacy-preserving applications without deep cryptographic knowledge.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Sunscreen FHE compiler** | 2022 | BFV (via SEAL back-end) | Rust procedural macros annotate functions; compiler handles encoding, encryption, noise budget, and parameter selection [[1]](https://github.com/Sunscreen-tech/Sunscreen) |
| **Sunscreen ZKP compiler** | 2023 | Bulletproofs | Companion ZKP compiler for proving statements about encrypted data; shares the Rust annotation framework [[1]](https://docs.sunscreen.tech/) |

**State of the art:** Sunscreen demonstrates the "FHE compiler" approach where developers write ordinary Rust and the compiler handles cryptographic complexity — similar in philosophy to [Concrete](#concrete--concrete-ml-zama) (Python/MLIR) and [HEIR](#heir-homomorphic-encryption-intermediate-representation) (MLIR). Experimental status; not externally audited. The project has explored transitioning from BFV to TFHE for its back-end.

---

## Intel HEXL (HE Hardware Acceleration)

**Goal:** Accelerate the low-level modular polynomial arithmetic at the core of all RLWE-based HE schemes by exploiting Intel AVX-512 and IFMA52 instructions, providing a drop-in acceleration layer for HE libraries.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Intel HEXL** | 2021 | AVX-512 / IFMA52 | Up to 7.2x NTT speedup and 6.0x modular multiplication speedup over native C++ on Ice Lake Xeon [[1]](https://eprint.iacr.org/2021/420) |
| **HEXL integration** | 2021 | Library plugin | Adopted by Microsoft SEAL, PALISADE (now OpenFHE), and HElib as optional acceleration back-end [[1]](https://github.com/IntelLabs/hexl) |

**State of the art:** Intel HEXL is the standard CPU-side acceleration layer for RLWE-based HE, available under Apache 2.0. It targets 3rd-generation Intel Xeon Scalable Processors and later. Best performance requires AVX-512-IFMA52 support. Complements GPU acceleration approaches like [PhantomFHE](#phantomfhe-gpu-accelerated-he) and [HEonGPU](#heongpu-gpu-fhe-library). Related to [NTT in FHE](#number-theoretic-transform-ntt-in-fhe) and [Parameter Selection for BFV/BGV/CKKS](#parameter-selection-for-bfv--bgv--ckks).

---

## FHERMA (FHE Components Platform)

**Goal:** Open challenge platform and reusable component library for fully homomorphic encryption, fostering practical FHE development by crowd-sourcing optimized implementations of common FHE building blocks.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **FHERMA platform** | 2024 | OpenFHE-based | Black-box and white-box FHE challenges with automated evaluation; winning solutions become open-source components [[1]](https://eprint.iacr.org/2024/612) |
| **FHERMA Cookbook** | 2025 | Component library | Curated library of optimized FHE components (matrix multiply, comparison, sorting) under Apache 2.0 [[1]](https://eprint.iacr.org/2025/1302) |

**State of the art:** FHERMA is a joint effort by Fair Math and the OpenFHE team, with IBM researchers publishing challenges on the platform [[1]](https://www.ibm.com/blog/ibm-researchers-to-publish-fhe-challenges-on-the-fherma-platform/). The platform provides rapid automated evaluation and a public leaderboard. Winning solutions are integrated into an open-source Apache 2.0 component library, directly usable with [OpenFHE](#homomorphic-encryption-he). Related to [FHE Benchmarks & Performance](#fhe-benchmarks--performance).

---

## Multi-Input Quadratic Functional Encryption (MIQFE)

**Goal:** Enable computation of quadratic functions (degree-2 polynomials) over encrypted inputs from multiple independent data sources, supporting applications such as differentially private encrypted analytics and biometric matching.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **MIQFE from pairings (Agrawal et al.)** | 2021 | Bilinear maps | First multi-input FE for quadratic functions from pairings; simulation-secure in fine-grained corruption model [[1]](https://link.springer.com/chapter/10.1007/978-3-030-84259-8_8) |
| **Stronger MIQFE (Agrawal et al.)** | 2022 | Bilinear maps | Extended functionality and stronger security model for multi-input quadratic FE [[1]](https://eprint.iacr.org/2022/1168.pdf) |
| **Simulation-secure MIQFE (SAC 2024)** | 2024 | Bilinear maps + IPFE | First simulation-secure secret-key MIQFE; application to differentially private quadratic queries on encrypted databases [[1]](https://eprint.iacr.org/2024/2050) |

**State of the art:** Multi-input quadratic FE extends [Quadratic / Degree-2 Functional Encryption](#quadratic--degree-2-functional-encryption) to the multi-client setting, enabling each data owner to encrypt independently while an analyst computes cross-client quadratic statistics. The SAC 2024 simulation-secure construction is the strongest security result to date. Practical implementations exist for small input dimensions. Related to [DMCFE](#decentralized-multi-client-functional-encryption-dmcfe) and [Inner-Product Functional Encryption](#inner-product-functional-encryption-ipfe).
