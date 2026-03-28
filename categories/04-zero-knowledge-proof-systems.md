# Zero-Knowledge Proof Systems

## Zero-Knowledge Proofs (ZK)

**Goal:** Prove that a statement is true without revealing any information beyond the truth of the statement. Provides privacy + verifiability.

### General-Purpose ZK (for arbitrary circuits)

| System | Year | Type | Note |
|--------|------|------|------|
| **Groth16** | 2016 | zk-SNARK (pairing) | Shortest proofs (~192 B), trusted setup per circuit [[1]](https://eprint.iacr.org/2016/260) |
| **PLONK** | 2019 | zk-SNARK (pairing) | Universal trusted setup (powers of tau); widely used [[1]](https://eprint.iacr.org/2019/953) |
| **Marlin** | 2019 | zk-SNARK (pairing) | Universal & updatable setup [[1]](https://eprint.iacr.org/2019/1047) |
| **Halo 2** | 2019 | zk-SNARK (no trusted setup) | Recursive; IPA-based; used in Zcash Orchard [[1]](https://eprint.iacr.org/2019/1021) |
| **STARKs** | 2018 | Transparent (hash-based) | No trusted setup, post-quantum friendly; larger proofs [[1]](https://eprint.iacr.org/2018/046) |
| **Bulletproofs** | 2017 | IPA-based | No trusted setup; compact range proofs [[1]](https://eprint.iacr.org/2017/1066) |
| **Nova / SuperNova** | 2021 | IVC / folding | Incremental Verifiable Computation; minimal per-step cost [[1]](https://eprint.iacr.org/2021/370) |
| **Spartan** | 2019 | Sum-check protocol | No trusted setup, no FFTs; very fast prover [[1]](https://eprint.iacr.org/2019/550) |
| **Brakedown / Binius** | 2021 | Code-based | Hardware-friendly, binary-field proofs [[1]](https://eprint.iacr.org/2021/1043) |

### Specialized ZK Protocols

| Protocol | Year | Purpose |
|----------|------|---------|
| **Sigma protocols (Schnorr)** | 1989 | DL knowledge proof; basis for many schemes [[1]](https://link.springer.com/article/10.1007/BF00196725) |
| **Pedersen + range proof** | 1991 | Confidential transactions (Monero, Mimblewimble) [[1]](https://eprint.iacr.org/2017/1066) |
| **zk-EVM (Polygon, Scroll, zkSync)** | 2022 | Prove EVM execution in ZK [[1]](https://eprint.iacr.org/2022/1692) |
| **Fiat-Shamir Transform** | 1987 | Hash-based | Convert interactive Sigma protocol → non-interactive; foundation of all SNARKs and many signature schemes [[1]](https://link.springer.com/chapter/10.1007/3-540-47721-7_12) |
| **Groth-Sahai Proofs** | 2008 | Pairings | NIZK for pairing-based equations; no trusted setup [[1]](https://eprint.iacr.org/2007/155) |
| **Lookup Arguments (Plookup / Lasso)** | 2020 | Polynomial IOP | Prove table lookups inside ZK circuits; used in all modern ZK-EVMs [[1]](https://eprint.iacr.org/2020/315)[[2]](https://eprint.iacr.org/2023/1216) |

**State of the art:** PLONK/KZG variants (practical SNARKs), STARKs (transparency + PQ), Nova (IVC/folding for recursion).

---

## SNARG (Succinct Non-Interactive Arguments without Zero-Knowledge)

**Goal:** Verifiable computation without privacy. Like a SNARK but the proof need not hide the witness — only succinctness and soundness matter. Useful when you want to verify computation but don't care about privacy (rollup state transitions, compliance proofs).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali CS Proofs** | 2000 | PCP + random oracle | First SNARG via PCP + Fiat-Shamir in ROM [[1]](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Proof%20Systems/Computationally_Sound_Proofs.pdf) |
| **Incrementally Verifiable Computation (Valiant)** | 2008 | Recursive SNARGs | Each step proves correctness of all prior steps; precursor to IVC/Nova [[1]](https://link.springer.com/chapter/10.1007/978-3-540-78524-8_18) |
| **Designated-Verifier SNARG (Kalai et al.)** | 2023 | LWE | SNARG from standard lattice assumptions; designated verifier [[1]](https://eprint.iacr.org/2023/1542) |

**State of the art:** zk-SNARKs subsume SNARGs in practice; designated-verifier SNARGs from LWE (theoretical breakthrough, 2023).

---

## Interactive Oracle Proofs (IOP) / PCP

**Goal:** Foundation of modern proof systems. An IOP combines an interactive proof with oracle access to the prover's messages. The PCP Theorem shows any NP statement has a proof checkable by reading only O(1) bits. STARKs, Plonky2, and most modern ZK systems are built on IOPs.

| Concept | Year | Basis | Note |
|---------|------|-------|------|
| **PCP Theorem** | 1992 | Complexity theory | NP = PCP(O(log n), O(1)); any NP proof can be checked by reading ~3 bits [[1]](https://dl.acm.org/doi/10.1145/273865.273901) |
| **Interactive Oracle Proofs (BCS)** | 2016 | IOP framework | Generalization of IP + PCP; prover sends oracles, verifier queries. Foundation of STARKs [[1]](https://eprint.iacr.org/2016/116) |
| **Polynomial IOP** | 2019 | Polynomial commitments + IOP | Prover sends polynomial oracles; PLONK, Marlin, etc. are polynomial IOPs compiled with KZG/FRI [[1]](https://eprint.iacr.org/2019/953) |
| **Linear PCP** | 2012 | Linear algebra | Prover's oracle is a linear function; basis of Pinocchio and Groth16 [[1]](https://eprint.iacr.org/2012/215) |

**State of the art:** Polynomial IOPs (PLONK, Marlin) compiled with KZG or FRI; IOP + Fiat-Shamir = STARK.

---

## Sigma Protocols / Schnorr Identification

**Goal:** Foundation of efficient ZK proofs. A 3-move interactive protocol (commit → challenge → response) where the prover demonstrates knowledge of a secret without revealing it. The universal building block for discrete-log-based ZK and digital signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Schnorr Identification** | 1989 | DLP | Prove knowledge of discrete log; basis of Schnorr signatures via Fiat-Shamir [[1]](https://doi.org/10.1007/0-387-34805-0_22) |
| **Guillou-Quisquater (GQ)** | 1988 | RSA | Sigma protocol for RSA-based identification [[1]](https://doi.org/10.1007/0-387-34799-2_16) |
| **Chaum-Pedersen** | 1992 | DLP | Prove equality of discrete logarithms (DLEQ); core of VOPRF, VRF [[1]](https://link.springer.com/chapter/10.1007/3-540-48071-4_7) |
| **AND/OR Composition (CDS)** | 1994 | Any sigma | Compose sigma protocols with AND/OR logic; prove compound statements [[1]](https://link.springer.com/chapter/10.1007/BFb0053443) |
| **Damgård's Techniques** | 2000 | Any sigma | Formal framework: special soundness + HVZK → Fiat-Shamir secure [[1]](https://www.cs.au.dk/~ivan/Sigma.pdf) |

**State of the art:** Sigma protocols + Fiat-Shamir transform = foundation of Schnorr signatures, DLEQ proofs, and most discrete-log ZK. See [ZK Proofs](#zero-knowledge-proofs-zk), [Digital Signatures](#digital-signatures).

---

## Groth-Sahai Proofs

**Goal:** Non-interactive ZK for pairing equations. Prove satisfiability of equations over group elements and scalars in bilinear groups — without random oracles. The standard NIZK framework for pairing-based cryptography.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth-Sahai (GS) Proofs** | 2008 | Pairings (DLIN/SXDH) | NIZK for pairing-product equations; witness-indistinguishable or ZK [[1]](https://eprint.iacr.org/2007/155) |
| **GS Proofs for Linear Equations** | 2008 | Pairings | Special case: linear equations have constant-size proofs [[1]](https://eprint.iacr.org/2007/155) |
| **Extractable GS** | 2012 | Knowledge assumptions | Proofs of knowledge variant; extractable witnesses [[1]](https://eprint.iacr.org/2012/028) |

**State of the art:** Groth-Sahai (2008); the canonical NIZK for pairing-based constructions. Enables [SPS](#structure-preserving-signatures-sps), group signatures, and anonymous credentials without random oracles.

---

## Folding Schemes

**Goal:** Efficient recursion. Instead of verifying a proof inside another proof (expensive), "fold" two instances into one of the same size. Enables incremental verifiable computation (IVC) with minimal per-step overhead. Hottest topic in ZK research (2022–).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Nova** | 2022 | R1CS + Pedersen | First folding scheme; fold two R1CS instances into one; see [ZK Proofs](#zero-knowledge-proofs-zk) [[1]](https://eprint.iacr.org/2021/370) |
| **SuperNova** | 2022 | Nova + multiple circuits | Non-uniform IVC: different circuits at each step [[1]](https://eprint.iacr.org/2022/1758) |
| **HyperNova** | 2023 | CCS + multilinear | Fold customizable constraint systems (generalizes R1CS, Plonkish) [[1]](https://eprint.iacr.org/2023/573) |
| **ProtoStar** | 2023 | Plonkish + accumulation | Non-uniform IVC for PLONK-like systems; see [BARG](#batch-arguments-barg--accumulation-schemes) [[1]](https://eprint.iacr.org/2023/620) |
| **Protostar/Protogalaxy** | 2023 | Lattice folding | Fold with logarithmic verifier [[1]](https://eprint.iacr.org/2023/1106) |
| **Symphony** | 2025 | Lattice + high-arity folding | First PQ folding SNARK; avoids hash embedding in circuits; polylog proof size [[1]](https://eprint.iacr.org/2025/1905) |

**State of the art:** HyperNova (most general), Nova (simplest), ProtoStar (PLONK-compatible), Symphony (first PQ-secure folding). Active area with new schemes monthly.

---

## Lookup Arguments

**Goal:** Efficient ZK table lookups. Prove that a value belongs to a precomputed table without expressing the lookup as arithmetic constraints — dramatically reduces circuit size for operations like range checks, bitwise ops, and hash functions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Plookup** | 2020 | Polynomial IOP | First practical lookup argument; sorted-concatenation technique [[1]](https://eprint.iacr.org/2020/315) |
| **LogUp** | 2022 | Logarithmic derivatives | Reduces lookup to logarithmic derivative sum; better for large tables [[1]](https://eprint.iacr.org/2022/1530) |
| **Lasso** | 2023 | Sumcheck + sparse polynomials | Lookup from structured tables without committing to full table; sublinear prover [[1]](https://eprint.iacr.org/2023/1216) |
| **Baloo** | 2022 | KZG + lookup | Lookup argument with logarithmic proof size [[1]](https://eprint.iacr.org/2022/1565) |
| **cq (Cached Quotients)** | 2022 | KZG | Table-independent preprocessing; efficient for shared tables [[1]](https://eprint.iacr.org/2022/1763) |
| **Caulk** | 2022 | KZG + position-hiding linkability | Sublinear prover: O(m² + m log N) for m lookups in table of size N; CCS 2022 [[1]](https://eprint.iacr.org/2022/621) |
| **Caulk+** | 2022 | Polynomial divisibility check | Simplifies Caulk; O(m²) prover; removes dependence on table size N in proving cost [[1]](https://eprint.iacr.org/2022/957) |

**State of the art:** Lasso (2023) for structured tables; LogUp for general use; Caulk/Caulk+ for sublinear-in-table-size proving. Lookups are now a core building block in zkVMs (see [ZK Proofs](#zero-knowledge-proofs-zk), [Folding Schemes](#folding-schemes)).

---

## Sumcheck Protocol

**Goal:** Verifiable summation. An interactive proof where the prover convinces the verifier of the value of a sum of a multivariate polynomial over the Boolean hypercube — in logarithmic rounds. Foundation of most modern interactive proof systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LFKN Sumcheck** | 1992 | Multivariate polynomials | Original sumcheck protocol; #P verifiable in IP [[1]](https://doi.org/10.1016/S0022-0000(05)80005-0) |
| **GKR Protocol** | 2008 | Layered circuits + sumcheck | Efficient interactive proof for layered arithmetic circuits [[1]](https://doi.org/10.1145/2699436) |
| **Spartan** | 2020 | Sumcheck + multilinear PCS | Transparent zkSNARK built entirely on sumcheck; no trusted setup [[1]](https://eprint.iacr.org/2019/550) |
| **Jolt** | 2024 | Sumcheck + Lasso | zkVM using sumcheck + lookup arguments; no custom circuits [[1]](https://eprint.iacr.org/2023/1217) |

**State of the art:** Sumcheck-based SNARKs (Spartan, Jolt, HyperNova) are increasingly dominant due to simplicity and transparency. Closely related to [IOP/PCP](#interactive-oracle-proofs-iop--pcp).

---

## General-Purpose zkVMs

**Goal:** Execute arbitrary programs and produce a ZK proof that the computation was performed correctly, without trusted setup per program. ZkVMs abstract over ZK circuit design: developers write programs in Rust/C (compiled to RISC-V, MIPS, or a custom ISA) and get proofs automatically.

| System | Year | ISA | Backend | Note |
|--------|------|-----|---------|------|
| **RISC Zero** | 2022 | RISC-V | STARK + FRI | First production RISC-V zkVM; Continuations for unbounded computation [[1]](https://dev.risczero.com/proof-system/proof-system-sequence-diagram) |
| **SP1** | 2024 | RISC-V | Plonky3 + STARK | Succinct Labs; precompiles for SHA-256, ECDSA; used in Ethereum L2s [[1]](https://github.com/succinctlabs/sp1) |
| **Jolt** | 2024 | RISC-V | Sumcheck + Lasso | Lookup-based; no custom circuits; fastest prover for RISC-V [[1]](https://eprint.iacr.org/2023/1217) |
| **Nexus** | 2024 | RISC-V | Nova/CycleFold | IVC-based; targets 1 ms/cycle proving [[1]](https://github.com/nexus-xyz/nexus-zkvm) |
| **Valida** | 2024 | Custom (minimal) | STARK | Designed for provability; no legacy ISA baggage [[1]](https://github.com/valida-xyz/valida) |
| **ZKM** | 2023 | MIPS | STARK | MIPS-based; targets general smart contracts [[1]](https://www.zkm.io/) |
| **Cairo VM** | 2020 | Cairo ISA | STARK | StarkWare; powers StarkNet; Algebraic RISC [[1]](https://eprint.iacr.org/2021/1063) |

**Architecture:** zkVM = ISA + arithmetization + polynomial IOP + polynomial commitment scheme. Key challenges: proving overhead (10³–10⁶× slowdown), precompile costs for hash/EC operations, recursion for proof aggregation.

**State of the art:** SP1 and RISC Zero dominate production use (Ethereum zkEVMs, ZK coprocessors). Jolt's lookup-based approach (2024) achieves fastest prover times. All systems rely on [STARKs](#zero-knowledge-proofs-zk) or [PLONK](#zero-knowledge-proofs-zk)-family backends.

---

## Proof-Carrying Data (PCD)

**Goal:** Distributed IVC. Extend incrementally verifiable computation to distributed settings: each node in a computation graph produces a proof that all prior computation was correct. Foundation of blockchain interoperability and recursive SNARKs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chiesa-Tromer (PCD)** | 2010 | Recursive SNARKs | First PCD construction; compliance proofs for distributed protocols [[1]](https://eprint.iacr.org/2010/174) |
| **Recursive SNARK composition** | 2014 | Cycles of curves | Practical PCD via SNARK verifier inside a SNARK (Ben-Sasson et al.) [[1]](https://eprint.iacr.org/2014/595) |
| **Nova-based PCD** | 2022 | Folding schemes | IVC + folding for lightweight distributed proof chains [[1]](https://eprint.iacr.org/2021/370) |

**State of the art:** Nova-based PCD (efficient), recursive SNARKs on cycles of elliptic curves (Mina, Pickles).

---

## MPC-in-the-Head (MPCitH)

**Goal:** ZK proofs from MPC. The prover mentally simulates an MPC protocol between virtual parties, commits to their views, and opens a random subset. The verifier checks consistency — if the "MPC" was honest, the statement must be true. Enables ZK from symmetric-key primitives.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IKOS (Ishai-Kushilevitz-Ostrovsky-Sahai)** | 2007 | Any MPC protocol | Foundational transformation: MPC protocol → ZK proof [[1]](https://doi.org/10.1145/1250790.1250794) |
| **ZKBoo** | 2016 | 3-party MPC | Practical MPCitH; 3 virtual parties, efficient for Boolean circuits [[1]](https://eprint.iacr.org/2016/163) |
| **ZKB++ / Picnic** | 2017 | ZKBoo + Fiat-Shamir | NIST PQ signature candidate; ZK from AES/LowMC circuits [[1]](https://eprint.iacr.org/2017/279) |
| **Limbo** | 2021 | N-party MPCitH | Generalized to N parties; tradeoff: more parties → shorter proofs [[1]](https://eprint.iacr.org/2021/215) |
| **Banquet** | 2021 | MPCitH + algebraic | Optimized for algebraic hash functions; shorter signatures [[1]](https://eprint.iacr.org/2021/068) |

**State of the art:** Picnic/Banquet for PQ signatures (see [Post-Quantum](#post-quantum-cryptography)); MPCitH is a general ZK paradigm alongside [IOPs](#interactive-oracle-proofs-iop--pcp) and [Sigma Protocols](#sigma-protocols--schnorr-identification).

---

## VOLEitH (VOLE-in-the-Head)

**Goal:** Efficient ZK from VOLE. Generalize MPCitH by replacing the secret-sharing-based MPC with VOLE as the underlying subprotocol. Produces shorter proofs for large witness languages (e.g., AES circuits). Foundation of the FAEST post-quantum signature.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Baum-Braun-Delpech de Saint Guilhem et al. VOLEitH** | 2023 | VOLE + ZK | First VOLEitH; shorter proofs than MPCitH for arithmetic witnesses; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/996) |
| **FAEST Signature** | 2023 | VOLEitH + AES | PQ signature from VOLEitH on AES; security = AES key recovery; NIST Round 2 [[1]](https://faest.info/) |
| **Appenzeller-to-Brie (A2B)** | 2024 | VOLEitH optimization | Improved VOLEitH with batch verification and smaller proofs [[1]](https://eprint.iacr.org/2024/1075) |

**State of the art:** FAEST (NIST Additional Sigs Round 2); VOLEitH as paradigm alongside [MPCitH](#mpc-in-the-head-mpcith) and [Sigma Protocols](#sigma-protocols--schnorr-identification).

---

## Binary-Field Proof Systems

**Goal:** Proof systems operating natively over GF(2^k) (binary fields) rather than large prime fields. Binary-field arithmetic maps directly to hardware (XOR = addition, AND = multiplication), enabling order-of-magnitude speedups for the prover without specialized hardware.

| System | Year | Field | Note |
|--------|------|-------|------|
| **Binius** | 2023 | GF(2^128) tower | Binary tower fields; 30–100× faster field ops than BN254; IACR 2023/1004 [[1]](https://eprint.iacr.org/2023/1004) |
| **Circle STARKs** | 2024 | Mersenne31 (M31) | StarkWare; operates on circle curve over M31; compatible with Stwo prover [[1]](https://eprint.iacr.org/2024/278) |
| **Plonky3** | 2023 | Goldilocks / M31 / BabyBear | Modular framework; backend for SP1, Polygon zkEVM v2 [[1]](https://github.com/Plonky3/Plonky3) |
| **Stwo** | 2024 | M31 | Circle STARK prover; >1M hashes/s on laptop [[1]](https://github.com/starkware-libs/stwo) |

**Key insight:** Classic SNARKs use prime fields like BN254 (~254-bit) because pairing-friendly curves live there. For hash-heavy workloads (SHA-256, Keccak), binary fields or small-prime fields let the prover work with native 32/64-bit arithmetic, eliminating expensive modular reductions.

**State of the art:** Binius (2023) for theoretical framework; Circle STARKs + Stwo (2024) in production at StarkWare; Plonky3 powers SP1 and Polygon. Binary-field systems are projected to replace prime-field STARKs for most applications by 2026.

---

## Distributed / Collaborative SNARKs

**Goal:** Generate a single ZK proof collaboratively across multiple untrusted parties, where no single party sees the full witness. Enables privacy-preserving delegation of proof generation (outsource to untrusted cloud) and cross-party ZK statements ("I know inputs from both Alice and Bob that satisfy this circuit").

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Pianist** | 2023 | PLONK + linear secret sharing | Distributed PLONK with O(log n) communication; optimal for large circuits [[1]](https://eprint.iacr.org/2023/1271) |
| **TACEO co-SNARK** | 2023 | 2PC/MPC over PLONK wires | MPC gates embedded in PLONK; general-purpose co-SNARK framework [[1]](https://eprint.iacr.org/2023/909) |
| **Collaborative Groth16** | 2022 | Secret-shared Groth16 | Each party holds shares of witness; MSM computed collaboratively [[1]](https://eprint.iacr.org/2021/1530) |
| **zkSaaS** | 2023 | SNARK-as-a-service | Cloud provers with input privacy; secret-shared witness computation [[1]](https://eprint.iacr.org/2023/905) |
| **Atlas** | 2024 | Folding + MPC | Distributed Nova/SuperNova; IVC with multiple provers [[1]](https://eprint.iacr.org/2024/286) |

**Applications:** Privacy-preserving ML inference proof (witness = model weights, inputs private); cross-institutional compliance proof; outsourced proof generation without revealing inputs to cloud provider.

**State of the art:** Pianist (2023) for large-circuit distribution; TACEO co-SNARKs for general MPC-ZK fusion. Active research area; no single dominant production implementation yet. See [MPC](#multi-party-computation-mpc) and [ZK Proofs](#zero-knowledge-proofs-zk).

---

## zkML (Zero-Knowledge Machine Learning)

**Goal:** Verifiable AI inference. Prove that an ML model was evaluated correctly on an input without revealing the model weights, the input, or both. Enables trustless AI-as-a-service, on-chain ML verification, and private inference.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **EZKL** | 2023 | Halo2 / KZG | Prove ONNX model inference in ZK; production-grade [[1]](https://github.com/zkonduit/ezkl) |
| **Modulus Labs (Remainder)** | 2023 | Custom arithmetic circuits | ZK inference for transformers; on-chain verification [[1]](https://eprint.iacr.org/2023/1584) |
| **Daniel Kang et al. (zkCNN)** | 2022 | GKR + sumcheck | Prove CNN inference; interactive → Fiat-Shamir [[1]](https://eprint.iacr.org/2021/673) |
| **Giza (ONNX→Cairo)** | 2023 | STARKs | Compile ONNX to Cairo (STARK-provable) [[1]](https://github.com/gizatechxyz/orion) |
| **zkPyTorch** | 2025 | Expander proof engine | Auto-generate ZK proofs for standard PyTorch inference; no custom circuits [[1]](https://eprint.iacr.org/2025/535) |
| **SecFormer** | 2024 | SMPC + segmented polynomials | Privacy-preserving transformer inference via SMPC; Goldschmidt's method for nonlinear ops; ACL 2024 [[1]](https://aclanthology.org/2024.findings-acl.790/) |

**State of the art:** EZKL (practical), zkPyTorch (2025, PyTorch-native), SecFormer (2024, SMPC-based), active race between SNARK/STARK/SMPC approaches.

---

## Compressed Sigma Protocols

**Goal:** Logarithmic proof compression. Compress n parallel Sigma protocol executions into a proof of size O(log n) — using an inner-product-like recursive argument. Generalizes the Bulletproofs inner-product technique to arbitrary Sigma protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bulletproofs IPA** | 2018 | Pedersen + DLP | Inner-product argument: compress n multiplications to O(log n) proof [[1]](https://eprint.iacr.org/2017/1066) |
| **Compressed Σ-Protocols (Attema-Cramer)** | 2020 | Any Sigma + pivot | General framework: compress any Sigma protocol for homomorphic relations [[1]](https://eprint.iacr.org/2020/152) |
| **Compressed Σ for Lattices** | 2021 | SIS/LWE | Extension to lattice-based Sigma protocols; post-quantum compressed proofs [[1]](https://eprint.iacr.org/2021/307) |

**State of the art:** Attema-Cramer (2020) as general framework; Bulletproofs IPA as most deployed instance. Extends [Sigma Protocols](#sigma-protocols--schnorr-identification) and [Bulletproofs](#zero-knowledge-proofs-zk).

---

## Zero-Knowledge Sets

**Goal:** Private set with membership/non-membership proofs. A prover commits to a set S without revealing it, then proves for any element x whether x ∈ S or x ∉ S — without leaking S's size or other elements. Stronger than accumulators.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali-Rabin-Kilian ZK Sets** | 2003 | Merkle + trapdoor hash | First ZK sets; prove membership AND non-membership without revealing set [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |
| **Chase-Healy-Lysyanskaya-Malkin-Reyzin** | 2005 | q-SDH | Efficient ZK sets from bilinear assumptions [[1]](https://eprint.iacr.org/2005/292) |
| **ZK Elementary Database (ZK-EDB)** | 2003 | Trapdoor commitments | Key-value database with ZK proofs for queries and non-existence [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |

**State of the art:** ZK sets from Merkle trees + trapdoor hashing. Extends [Accumulators](#accumulators) with non-membership proofs and set hiding.

---

## Witness PRF

**Goal:** NP-gated pseudorandom evaluation. A PRF where anyone holding a witness w for an NP statement x can compute PRF(x) — without a secret key. Combines properties of PRFs, witness encryption, and constrained PRFs into one powerful primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zhandry Witness PRF** | 2016 | Multilinear maps | First construction; evaluate PRF using NP witness instead of secret key [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF from iO** | 2016 | Indistinguishability obfuscation | Alternative construction from iO; more general [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF Applications** | 2016 | — | Implies multi-party key exchange, secret sharing for NP, more [[1]](https://eprint.iacr.org/2016/597) |

**State of the art:** Theoretical; constructions require [iO](#indistinguishability-obfuscation-io) or [Multilinear Maps](#multilinear-maps). Implies [Witness Encryption](#witness-encryption), [Constrained PRFs](#puncturable--constrained-prf), and more.

---

## Malleable Proof Systems / Controlled-Malleable NIZK

**Goal:** Proof transformation without witness. Transform a valid NIZK proof π for statement x into a valid proof π' for a related statement x' — without knowing the witness for either. The transformation is "controlled": only specific, predefined relations between statements are allowed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Kohlweiss-Lysyanskaya-Meiklejohn** | 2012 | Groth-Sahai proofs | First controlled-malleable NIZK; define allowed transformations via relations [[1]](https://eprint.iacr.org/2012/345) |
| **Malleable Signatures (Chase et al.)** | 2012 | SPS + GS | Derive signatures on related messages; enables delegatable credentials [[1]](https://eprint.iacr.org/2012/345) |
| **cm-NIZK for Circuits** | 2014 | Pairings | Controlled malleability for general circuit satisfiability [[1]](https://eprint.iacr.org/2014/590) |

**State of the art:** cm-NIZK from [Groth-Sahai](#groth-sahai-proofs) proofs; enables delegatable [Anonymous Credentials](#anonymous-credentials) and proof-carrying data without interaction.

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

## Multi-Prover Interactive Proofs (MIP)

**Goal:** Proofs from non-communicating provers. Multiple provers who cannot communicate with each other jointly convince a verifier. Vastly more powerful than single-prover proofs: MIP = NEXP. With entangled provers: MIP* = RE (every recursively enumerable language!).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ben-Or-Goldwasser-Kilian-Wigderson** | 1988 | Two provers | First MIP; two provers are enough for NEXP [[1]](https://doi.org/10.1145/62212.62223) |
| **Babai-Fortnow-Lund MIP = NEXP** | 1991 | Algebraic | Proved MIP = NEXP; multi-prover as powerful as exponential computation [[1]](https://doi.org/10.1007/BF01200056) |
| **MIP* = RE (Ji et al.)** | 2020 | Quantum entanglement | With entangled provers, all RE languages provable; resolved Connes embedding [[1]](https://arxiv.org/abs/2001.04383) |
| **Interactive Proofs for Muggles (GKR)** | 2008 | Sumcheck | Practical: verifier delegates computation to untrusted prover [[1]](https://doi.org/10.1145/2699436) |

**State of the art:** MIP* = RE (2020, breakthrough); practical MIP-derived systems via [Sumcheck](#sumcheck-protocol) and [IOP](#interactive-oracle-proofs-iop--pcp). Foundational for proof complexity.

---

## zkTLS / MPC-TLS

**Goal:** Privacy-preserving web proofs. Allow a party to prove to a third party that a specific HTTPS response was returned by a server — without revealing the full session or requiring the server's cooperation. Enables bringing off-chain data (prices, identity, balances) into smart contracts with cryptographic provenance.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **DECO** | 2020 | 3-party TLS + ZK | Server unaware; prover generates ZK proof over TLS record data; UC-secure [[1]](https://eprint.iacr.org/2019/1229) |
| **TLSNotary** | 2022 | MPC-TLS (2PC) | TLS session split between prover + verifier using garbled circuits; open-source [[1]](https://tlsnotary.org/) |
| **Reclaim Protocol** | 2023 | DECO-style ZK | Selective disclosure of HTTPS data; used in DeFi identity [[1]](https://reclaimprotocol.org/) |
| **Opacity / zkp2p** | 2024 | Regex + ZK circuits | Prove pattern match on TLS plaintext (e.g. payment amount) without revealing full body [[1]](https://github.com/zkp2p/zk-p2p) |
| **ZK Email** | 2023 | DKIM signatures + ZK | Prove contents of signed email without revealing full message; Circom/Halo2 [[1]](https://prove.email/) |

**State of the art:** TLSNotary (production, open-source 2PC), DECO (academic gold standard). Used in oracle protocols, on-chain identity, and DeFi undercollateralised lending. Main bottleneck is 2PC overhead for TLS-1.3 AES-GCM.

---

## Sonic

**Goal:** Universal, updatable SNARK with a single global setup. Sonic was the first practical zk-SNARK to support a universal and continuously updatable structured reference string (SRS) that scales linearly in circuit size, eliminating per-circuit trusted setup ceremonies. It directly inspired PLONK and Marlin.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sonic** | 2019 | KZG + polynomial IOP | Universal updatable SRS; linear-size; helper-based batch verification; CCS 2019 [[1]](https://eprint.iacr.org/2019/099) |
| **Sonic with helpers** | 2019 | Sonic + advisory witnesses | Untrusted "helpers" supply advice enabling O(1) amortised verifier time in batch settings [[1]](https://eprint.iacr.org/2019/099) |

**Key contribution:** Prior universal SNARKs (e.g., Groth-Maller) required a quadratically growing SRS. Sonic achieved linear SRS size. The updatability property means any party can contribute randomness to the SRS at any time, providing perpetual security under a 1-of-N assumption.

**State of the art:** Superseded in practice by PLONK (2019) and Marlin (2019), which improved on Sonic's prover efficiency while retaining universality and updatability. Sonic remains important as the direct conceptual predecessor of the "universal SNARK" paradigm. See [[1]](https://eprint.iacr.org/2019/099).

---

## Ligero and Aurora

**Goal:** Transparent, hash-based SNARKs from linear codes and IOPs. Ligero (2017) achieves sublinear proof size using interleaved Reed-Solomon codes over Boolean circuits — no trusted setup, no public-key crypto required. Aurora (2018) improves proof size to O(log² N) using a linear-length IOP for R1CS.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ligero** | 2017 | Reed-Solomon IOP + MPC-in-the-head | Proof size O(√N); based solely on collision-resistant hash functions; no trusted setup [[1]](https://eprint.iacr.org/2022/1608) |
| **Ligero++** | 2020 | Improved interleaved codes | Optimised Ligero; better constants; O(√N) but tighter analysis; CCS 2020 [[1]](https://dl.acm.org/doi/10.1145/3372297.3417893) |
| **Aurora** | 2018 | Linear-length IOP for R1CS | Proof size O(log² N) via a univariate sumcheck IOP; transparent; post-quantum plausible [[1]](https://eprint.iacr.org/2018/828) |
| **Fractal** | 2020 | Aurora + holographic IOP | First transparent recursive SNARK; holographic preprocessing enables indexer-prover separation [[1]](https://eprint.iacr.org/2019/1076) |

**Key insight:** Ligero encodes the witness as rows of a Reed-Solomon codeword matrix and uses interleaved tests to verify linear constraints. This gives a zero-knowledge argument whose communication depends on √N field elements rather than N. Aurora replaces the matrix approach with a univariate-sumcheck-based IOP, shrinking proofs to polylogarithmic.

**State of the art:** Aurora and Fractal (2020) are the academic benchmarks; in production, their ideas are subsumed by STARKs and [Orion](#orion-and-brakedown-linear-time-snarks). Ligero's MPC-in-the-head viewpoint connects to [VOLEitH](#voleitH-vole-in-the-head). See [[1]](https://eprint.iacr.org/2018/828).

---

## HyperPlonk

**Goal:** Linear-time prover SNARK on the boolean hypercube. HyperPlonk adapts the PLONK polynomial IOP to multilinear polynomials over the boolean hypercube, replacing FFTs with the sumcheck protocol. This gives an O(N) prover (vs. O(N log N) for PLONK) and supports high-degree custom gates without performance penalty.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HyperPlonk** | 2022 | Multilinear PLONK + sumcheck | O(N) prover; no FFT; high-degree custom gates; pluggable multilinear PCS; EUROCRYPT 2023 [[1]](https://eprint.iacr.org/2022/1355) |
| **HyperPlonk + Orion PCS** | 2022 | HyperPlonk with linear-time PCS | Using Orion as polynomial commitment gives fully linear prover end-to-end; opening proofs < 10 KB [[1]](https://eprint.iacr.org/2022/1355) |

**Key contribution:** Classical PLONK uses univariate polynomials over a multiplicative subgroup, requiring FFTs (O(N log N)) for the prover. HyperPlonk moves to the boolean hypercube where the sumcheck protocol handles all key sub-protocols. Custom gates of degree d cost O(dN) rather than O(N log N · d). Permutation checks are replaced by a novel multiset equality argument over the hypercube.

**State of the art:** HyperPlonk (2022) is the state-of-the-art Plonkish system for prover time; used as the IOP layer in several multilinear SNARK stacks. Closely related to [Spartan](#sumcheck-protocol), [Sumcheck](#sumcheck-protocol), and [Binius](#binary-field-proof-systems). See [[1]](https://eprint.iacr.org/2022/1355).

---

## Orion and Brakedown (Linear-Time SNARKs)

**Goal:** SNARKs with provably O(N) prover time. Both Brakedown (2021/2023) and Orion (2022) achieve linear prover time — the information-theoretic optimum — using expander codes and linear-time encodable error-correcting codes. No FFTs, no trusted setup, plausibly post-quantum.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brakedown** | 2021/2023 | Expander codes + R1CS | First implemented linear-time SNARK; field-agnostic (any finite field); transparent; post-quantum plausible; CRYPTO 2023 [[1]](https://eprint.iacr.org/2021/1043) |
| **Orion** | 2022 | Expander graphs + code switching | O(N) prover (field ops + hashes); O(log² N) proof; fastest concrete prover at 2²⁰ gates (3.09 s); CRYPTO 2022 [[1]](https://eprint.iacr.org/2022/1010) |
| **Orion+ (soundness fix)** | 2024 | Revised Orion | Fixes a soundness issue in original Orion; restores security under clean assumptions [[1]](https://link.springer.com/chapter/10.1007/978-981-95-5116-3_13) |

**Key insight:** Both systems build on the insight that linear-time encodable codes (e.g., expander-based codes due to Spielman) give a multilinear polynomial commitment scheme with O(N) commitment time and polylogarithmic proof size. Brakedown uses a direct tensor-product structure; Orion adds a "code-switching" technique to compress sqrt-size proofs to polylogarithmic.

**Relation to Binius:** Binius (2023) also achieves linear prover time but operates over binary tower fields — see [Binary-Field Proof Systems](#binary-field-proof-systems). Brakedown and Orion work over arbitrary finite fields.

**State of the art:** Orion (2022) for fastest concrete prover; Brakedown (CRYPTO 2023) for clean theoretical guarantees. Both are used as the PCS layer in [HyperPlonk](#hyperplonk). See [[1]](https://eprint.iacr.org/2021/1043)[[2]](https://eprint.iacr.org/2022/1010).

---

## RedShift

**Goal:** Transparent SNARK via list polynomial commitments. RedShift (2019) gives the first efficient transformation of any KZG-based (trusted-setup) SNARK into a transparent counterpart by replacing KZG polynomial commitments with a new primitive called a list polynomial commitment, instantiated via FRI. This yields a transparent, plausibly post-quantum SNARK from any polynomial IOP.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RedShift** | 2019/2022 | List polynomial commitment + FRI | Transparent SNARKs from KZG-based IOPs; works over prime and binary fields; CCS 2022 [[1]](https://eprint.iacr.org/2019/1400) |

**Key contribution:** KZG-based SNARKs (PLONK, Marlin, Sonic) require a trusted setup (powers-of-tau SRS). RedShift defines a *list polynomial commitment* (LPC) — a polynomial commitment scheme that tolerates a list of valid openings rather than a unique one — and shows LPCs can be instantiated with FRI (no trusted setup). Plugging LPC into any polynomial IOP yields a transparent SNARK with no SRS ceremony.

**Relation to other schemes:** RedShift predates the explicit "PLONK + FRI = Plonky2" design but formalises the same core idea. Plonky2, Polygon's zkEVM STARK backend, and StarkWare's Cairo prover all implicitly instantiate similar list polynomial commitments.

**State of the art:** RedShift (Kattis-Panarin-Vlasov, CCS 2022); the LPC framework is the theoretical foundation of the PLONK-over-FRI approach used in Plonky2 and Polygon's prover stack. See [[1]](https://eprint.iacr.org/2019/1400).

---
