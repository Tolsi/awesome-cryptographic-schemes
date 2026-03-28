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

## Groth16

**Goal:** Smallest possible pairing-based zk-SNARK proofs. Achieve a proof of arithmetic circuit satisfiability consisting of exactly 3 group elements — the theoretical minimum for a pairing-based SNARK — with fast verification requiring only 3 pairing computations. Circuit-specific trusted setup required.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth16** | 2016 | Pairing-based (BN254/BLS12-381) + QAP | 3-element proofs; 3-pairing verification; circuit-specific SRS; ~192 bytes on BN254; EUROCRYPT 2016 [[1]](https://eprint.iacr.org/2016/260) |
| **Simulation-extractable Groth16** | 2020 | Groth16 + non-malleability | Extends Groth16 with simulation-extractability for composability; modest overhead [[1]](https://eprint.iacr.org/2020/1306) |
| **Extending Groth16 for disjunctions** | 2025 | Groth16 + OR composition | Compose Groth16 proofs under OR relations without re-proving from scratch [[1]](https://eprint.iacr.org/2025/028) |

**Key contribution:** Groth's construction reduces SNARK proof generation to two multi-scalar multiplications (MSMs) and proof verification to three pairing product equations. The circuit-specific structured reference string (SRS) encodes all constraint-system polynomials evaluated at a secret toxic waste point; this enables the minimal 3-element proof but means each new circuit requires a fresh ceremony.

**Arithmetic:** The constraint system is R1CS (Rank-1 Constraint System), compiled to a Quadratic Arithmetic Program (QAP) via the transformation of Gennaro-Gentry-Parno-Raykova (2013). Groth16 is the canonical endpoint of the Linear Interactive Proof → pairing-SNARK pipeline.

**Deployed in:** Zcash Sapling, Tornado Cash, Filecoin's Proof-of-Replication, Ethereum's zkSNARK precompile (EIP-197), and most early ZK applications. Still the gold standard where smallest proof size is paramount.

**State of the art:** Groth16 (EUROCRYPT 2016) remains the smallest and fastest-to-verify pairing-based SNARK. Superseded for new applications by universal-setup systems (PLONK, Marlin) that eliminate per-circuit ceremonies. See [[1]](https://eprint.iacr.org/2016/260).

---

## Halo and Halo2

**Goal:** Recursive proof composition without a trusted setup. Halo (2019) achieves the first practical recursive SNARK using only the discrete logarithm assumption over ordinary (non-pairing-friendly) elliptic curves. Halo2 (2020–2021) extends this into a production-grade proving system combining a PLONK-style polynomial IOP with an inner product argument (IPA) commitment scheme and an efficient accumulation-based recursion mechanism.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Halo** | 2019 | IPA over Pasta cycle + accumulation | First recursive SNARK without trusted setup or pairing-friendly curves; deferred verification [[1]](https://eprint.iacr.org/2019/1021) |
| **Recursive Proof Composition from Accumulation Schemes** | 2020 | Halo + formal framework | Formalises "accumulation scheme" abstraction; generalises Halo's technique; TCC 2020 [[1]](https://eprint.iacr.org/2020/499) |
| **Halo2** | 2021 | PLONK + IPA + Pasta curves | Production system by ECC/Zcash; used in Zcash Orchard; custom gates, lookup tables (Plookup), recursive accumulation [[1]](https://zcash.github.io/halo2/) |

**Key insight:** Standard recursive SNARKs embed a pairing-based verifier inside another circuit, requiring expensive pairing-friendly curve arithmetic. Halo avoids pairings entirely by using an inner product argument (IPA) over a cycle of ordinary curves (Pallas/Vesta). The IPA verification is "deferred" — accumulated across many recursive steps — so that only the final accumulated check needs to be computed. This makes each recursive step extremely cheap.

**Halo2 in practice:** Halo2 adds PLONK-style custom gates, lookup arguments (Plookup), and permutation arguments on top of Halo's IPA commitment scheme. It removes the need for any structured reference string or trusted setup ceremony. The PSE fork of Halo2 is the backend for many zkEVM projects (Scroll, Polygon Hermez, Privacy and Scaling Explorations).

**State of the art:** Halo2 (ECC, 2021) is deployed in Zcash Orchard and numerous ZK rollups. The accumulation-scheme framework (BCMS 2020) is the theoretical foundation for [Nova](#folding-schemes), [ProtoStar](#folding-schemes), and related folding schemes. See [[1]](https://eprint.iacr.org/2019/1021).

---

## Plonky2

**Goal:** Fast recursive SNARK with no trusted setup by combining PLONK's polynomial IOP with FRI over a small 64-bit field. Plonky2 (Polygon Zero / Mir Protocol, 2022) achieves recursive proof composition in under 170 ms on a laptop — roughly 100× faster than prior approaches — by operating over the Goldilocks field (p = 2⁶⁴ − 2³² + 1) rather than a large 254-bit prime field.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Plonky2** | 2022 | PLONK + FRI + Goldilocks field | No trusted setup; recursive in ~170 ms; 43 KB constant-size proofs after recursion; Polygon Zero [[1]](https://github.com/0xPolygonZero/plonky2/blob/main/plonky2/plonky2.pdf) |
| **Plonky3** | 2023 | Plonky2 successor; modular framework | Replaces Plonky2 internals; supports BabyBear, Goldilocks, Mersenne31; backend for SP1, Polygon CDK [[1]](https://github.com/Plonky3/Plonky3) |

**Key contributions:**
- **Goldilocks field:** The modulus p = 2⁶⁴ − 2³² + 1 has a special form enabling fast Montgomery reduction using only 64-bit hardware arithmetic, giving ~10× faster field operations than BN254.
- **PLONK over FRI:** Replaces KZG polynomial commitments with FRI, eliminating the trusted setup. FRI works natively over Goldilocks because the field has a large 2-adic subgroup (2³² elements), enabling efficient FFTs.
- **Custom gates:** Plonky2 supports arbitrary-degree custom gates without extra FFT overhead, inheriting PLONK's custom gate mechanism.
- **Recursion:** A Plonky2 proof can verify another Plonky2 proof inside itself; recursing ~10 layers shrinks an arbitrarily large computation to a constant ~43 KB proof.

**Relation to other systems:** Plonky2 is conceptually a PLONK polynomial IOP compiled with FRI (as formalised by [RedShift](#redshift)), running over a small prime field rather than a pairing-friendly field. Plonky3 is its modular successor (2023), used as the IOP backend in SP1 and Polygon's CDK prover stack.

**State of the art:** Plonky2 (Polygon Zero, 2022) was the fastest recursive SNARK at release; Plonky3 (2023) supersedes it with a cleaner architecture and broader field support. See [[1]](https://github.com/0xPolygonZero/plonky2/blob/main/plonky2/plonky2.pdf).

---

## DEEP-FRI

**Goal:** Improve the soundness of the FRI low-degree test by querying the prover at points outside the evaluation domain. DEEP (Domain Extending for Eliminating Pretenders) extends the standard FRI protocol with an out-of-domain sampling step that boosts soundness from roughly 1/|field| to nearly 1 per query, enabling the same security level with far fewer query repetitions and thus smaller STARK proofs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DEEP-FRI** | 2019/2020 | FRI + out-of-domain sampling | Soundness ≈ 1 per round vs. ρ⁻¹ for plain FRI; reduces repetitions; ITCS 2020 [[1]](https://eprint.iacr.org/2019/336) |
| **DEEP-ALI** | 2019 | DEEP + Algebraic Linking IOP | Applies DEEP technique to the ALI (Algebraic Linking IOP) inside ZK-STARKs; soundness close to 1 [[1]](https://eprint.iacr.org/2019/336) |

**Key insight:** In standard FRI, the prover commits to a polynomial f and the verifier checks consistency at random in-domain positions x drawn from the evaluation domain D. A malicious prover can pass with probability proportional to the rate ρ = |D|/N per query. DEEP asks the prover to also reveal f(z) for a random z chosen *outside* D ("out-of-domain" or DEEP query). The polynomial g(x) = (f(x) − f(z)) / (x − z) must be low-degree; the verifier checks this via a subsequent FRI invocation. Because z is outside D, forging a consistent answer is computationally equivalent to finding f exactly, boosting soundness to nearly 1 per round. The same technique applied to the ALI intermediate polynomial (which links execution trace columns to boundary constraints) gives DEEP-ALI.

**Impact:** DEEP-FRI is the soundness backbone of StarkWare's production STARK prover (Cairo, StarkNet). It is used in RISC Zero's STARK backend and most FRI-based proof systems. The improved soundness directly translates to shorter proofs: with DEEP-FRI, fewer FRI query rounds are needed to achieve 128-bit security, reducing proof size by 2–4×.

**State of the art:** DEEP-FRI (Ben-Sasson, Goldberg, Kopparty, Saraf; ITCS 2020) is the standard soundness enhancement for all production FRI-based STARKs. See [[1]](https://eprint.iacr.org/2019/336).

---

## zkEVM Taxonomy and Ecosystem

**Goal:** Prove EVM execution in zero knowledge at various levels of Ethereum compatibility. The zkEVM design space is characterised by a fundamental tradeoff: closer equivalence to Ethereum's bytecode semantics means higher ZK proving overhead, while looser compatibility enables faster proofs but breaks tooling compatibility. Vitalik Buterin's 2022 classification defines four types spanning this tradeoff.

| Type | Compatibility | Proof time | Representative systems |
|------|---------------|------------|------------------------|
| **Type 1** (fully Ethereum-equivalent) | Identical to Ethereum at bytecode and state-trie level | Slowest (weeks→hours) | Taiko, PSE zkEVM [[1]](https://vitalik.ca/general/2022/08/04/zkevm.html) |
| **Type 2** (EVM-equivalent) | Same bytecode semantics; may swap hash functions (Keccak→Poseidon in tries) | Hours→minutes | Scroll [[1]](https://scroll.mirror.xyz/N7cAie4ul0PdSxNdv2FTqgMV2JEkhOJocsxfeqe4SFE) |
| **Type 2.5** | Type 2 but with different gas costs for ZK-unfriendly opcodes | Minutes | Polygon zkEVM [[1]](https://polygon.technology/blog/polygon-zkevm-within-vitaliks-framework-gaining-clarity-and-looking-ahead) |
| **Type 3** (mostly EVM-equivalent) | Minor EVM differences; transitional stage | Minutes | Most teams in transit to Type 2 |
| **Type 4** (high-level language equivalent) | Compiles Solidity/Vyper to a custom ZK-friendly VM | Fastest | zkSync Era (LLVM), StarkNet (Cairo) [[1]](https://vitalik.ca/general/2022/08/04/zkevm.html) |

**Key projects:**

- **Polygon zkEVM** — Type 2.5; PLONKish arithmetization with custom gates; uses Plonky2/Plonky3 as recursive aggregation layer; proves EVM execution via a PIL (Polynomial Identity Language) specification of each opcode [[1]](https://eprint.iacr.org/2022/1692).
- **Scroll** — Type 2; bytecode-equivalent; developed with PSE; uses Halo2 circuits per EVM opcode; tight integration of lookup arguments for EVM state and memory [[1]](https://scroll.mirror.xyz/N7cAie4ul0PdSxNdv2FTqgMV2JEkhOJocsxfeqe4SFE).
- **Taiko** — Type 1; aims for full Ethereum equivalence including the Keccak-based Merkle Patricia Tree; uses a based rollup design for decentralized sequencing [[1]](https://taiko.mirror.xyz/w7NSKDeKfJoEy0p89I9feixKfdK-20JgWF9HZzxfeBo).
- **zkSync Era** — Type 4; compiles via LLVM to a custom VM (zkEVM bytecode); fastest proving but lowest tooling compatibility.
- **Linea** — Type 2; developed by ConsenSys; Gnark-based prover; PLONKish circuits.

**Arithmetization choices:** All deployed zkEVMs use PLONKish arithmetization (custom gates, lookup arguments, permutation arguments). The key differentiator is which EVM operations are proved natively vs. approximated. ZK-unfriendly operations (Keccak-256, ECDSA, modular exponentiation) require dedicated precompile circuits and account for the majority of proving cost.

**State of the art:** Scroll (Type 2, mainnet 2023), Polygon zkEVM (Type 2.5, mainnet 2023), Taiko (Type 1, mainnet 2024). Proving times have dropped from weeks to seconds (2022–2026) via hardware acceleration and recursive aggregation. See [General-Purpose zkVMs](#general-purpose-zkvms) for ISA-level (non-EVM) approaches.

---

## Ligerito (Small-Field Polynomial Commitments and SNARKs)

**Goal:** Practical SNARKs over small fields with linear prover time and concrete efficiency. Ligerito (2024) is a polynomial commitment scheme and SNARK designed for small finite fields (e.g., GF(2^8), GF(2^16)), combining the Reed-Solomon-based IOP structure of Ligero with binary-tower-field arithmetic to achieve fast committed inner-product proofs with no trusted setup.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ligerito** | 2024 | Small-field Reed-Solomon IOP | Linear prover time over small fields; polylogarithmic proof size; no trusted setup; transparent; CCS 2024 [[1]](https://eprint.iacr.org/2024/1762) |
| **Ligerito PCS** | 2024 | Committed inner-product argument | Polynomial commitment derived from Ligerito's inner-product argument; pluggable into any polynomial IOP [[1]](https://eprint.iacr.org/2024/1762) |

**Key contribution:** Classical SNARKs over small fields suffer because standard polynomial commitment schemes (KZG, FRI) require fields with large smooth multiplicative subgroups. Ligerito circumvents this by encoding the witness as a codeword of a small-field Reed-Solomon code and applying an interactive proximity test. The result is an O(N) prover (in field operations) that works natively over GF(2^k) for small k, making it highly compatible with [Binius](#binary-field-proof-systems)-style binary-tower arithmetic.

**Relation to other schemes:** Ligerito extends [Ligero and Aurora](#ligero-and-aurora) to the small-field regime; it is complementary to [Binius](#binary-field-proof-systems) (which uses binary fields but different commitment machinery) and can be used as the PCS inside [HyperPlonk](#hyperplonk)-style systems over small fields.

**State of the art:** Ligerito (Ngoc Khanh Nguyen, Pratyush Ranjan Tiwari; CCS 2024); the first practically efficient SNARK natively operating over GF(2^k) with sub-quadratic prover. See [[1]](https://eprint.iacr.org/2024/1762).

---

## LogUp-GKR (Logarithmic Derivative Lookups via GKR)

**Goal:** Efficiently verify large lookup tables inside ZK proofs using the GKR sumcheck protocol. LogUp-GKR (2023) applies the GKR interactive proof protocol to evaluate the logarithmic-derivative sum underlying the [LogUp](#lookup-arguments) argument, reducing the prover's cost for large-multiplicity lookups from O(N log N) to O(N) and enabling lookups across multiple interconnected tables in a single sumcheck invocation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LogUp** | 2022 | Logarithmic derivatives | Reduces lookup argument to sum of 1/(X − tᵢ) terms; efficient for large tables [[1]](https://eprint.iacr.org/2022/1530) |
| **LogUp-GKR** | 2023 | LogUp + GKR sumcheck | Applies GKR to evaluate the LogUp fractional sum over a layered circuit; O(N) prover for table sizes up to 2²⁶; IACR 2023 [[1]](https://eprint.iacr.org/2023/1284) |
| **LogUp-GKR in Plonky3** | 2024 | Plonky3 backend | LogUp-GKR is the lookup mechanism in the Plonky3 framework (SP1, Polygon CDK v2); replaces Plookup in small-field settings [[1]](https://github.com/Plonky3/Plonky3) |

**Key insight:** [LogUp](#lookup-arguments) expresses a lookup argument as a rational sum ∑ mᵢ / (X − tᵢ), where mᵢ are multiplicities and tᵢ are table entries. Evaluating this sum requires the prover to compute N fractional field inversions. LogUp-GKR instead embeds this rational sum into a layered arithmetic circuit and applies the GKR protocol: the verifier issues a single challenge, and the prover responds with a sumcheck proof over the circuit's layers. This reframes the bottleneck from N inversions to a single O(N) sumcheck, with a verifier cost of O(log N).

**Applications:** Multi-table lookups in zkVMs (e.g., range tables, XOR tables, opcode dispatch tables). LogUp-GKR is used in Plonky3 and is the recommended lookup mechanism for [Circle STARKs](#binary-field-proof-systems).

**State of the art:** LogUp-GKR (Papini-Haböck; 2023); deployed in Plonky3 and StarkWare's Stwo prover. Supersedes Plookup/LogUp for multi-table lookup scenarios. See [Lookup Arguments](#lookup-arguments), [Sumcheck Protocol](#sumcheck-protocol).

---

## Circom and SnarkJS

**Goal:** Accessible toolchain for writing and deploying ZK circuits. Circom (2020) is a domain-specific language that compiles high-level circuit descriptions into R1CS constraint systems. SnarkJS (2020) is a JavaScript/WebAssembly library that generates and verifies proofs (Groth16, PLONK, Fflonk) from Circom-compiled circuits entirely in the browser or Node.js — enabling ZK in web applications with no native dependencies.

| Component | Year | Role | Note |
|-----------|------|------|------|
| **Circom** | 2020 | Circuit DSL + compiler | Compiles `.circom` source to R1CS + witness generation code (WASM/C++); templates + components; iden3/0xPolygon [[1]](https://docs.circom.io/) |
| **SnarkJS** | 2020 | JS/WASM prover + verifier | Groth16, PLONK, Fflonk prover/verifier in pure JS; powers the majority of in-browser ZK applications [[1]](https://github.com/iden3/snarkjs) |
| **Circomlib** | 2020 | Standard circuit library | Reusable Circom templates: Poseidon hash, ECDSA, Pedersen, MiMC, Merkle proofs [[1]](https://github.com/iden3/circomlib) |
| **Noir → R1CS** | 2023 | Cross-compilation | Noir programs can target Circom-compatible R1CS backends; interoperability layer [[1]](https://noir-lang.org/) |

**Workflow:** Circom source → `circom compile` → `R1CS + WASM witness generator` → SnarkJS powers-of-tau setup → Groth16/PLONK proving key → proof generation → Solidity verifier export for on-chain verification.

**Ecosystem impact:** Circom + SnarkJS is the most widely deployed ZK toolchain in practice (Tornado Cash, Semaphore, Dark Forest, zk-Email). Its main limitation is that Circom circuits are written at a low level of abstraction: developers must manually express computation as arithmetic constraints, making complex programs error-prone.

**State of the art:** Circom 2 (2022) with improved type system; SnarkJS supporting Groth16, PLONK, and Fflonk backends. Higher-level alternatives (Noir, Leo, Cairo) are gradually displacing Circom for new projects, but its ecosystem remains dominant. See [ZK Circuit DSLs](#zk-circuit-dsls-noir-leo-cairo).

---

## ZK Circuit DSLs: Noir, Leo, Cairo

**Goal:** High-level domain-specific languages for writing ZK programs. While [Circom](#circom-and-snarkjs) requires manual R1CS constraint writing, Noir, Leo, and Cairo provide Rust/C-like syntax with automatic arithmetization — the compiler generates the ZK constraint system from familiar imperative or functional programs. Each targets a different backend and ecosystem.

| Language | Year | Target Backend | Note |
|----------|------|----------------|------|
| **Noir** | 2022 | Barretenberg (UltraPlonk) / ACIR | Aztec Network; Rust-like syntax; ACIR IR targets multiple backends (Groth16, Halo2, UltraPlonk); standard library for ZK idioms [[1]](https://noir-lang.org/) |
| **Leo** | 2021 | Aleo (Marlin / AleoBFT) | Aleo Network; statically typed functional language; first-class ZK types; compiles to Aleo bytecode + R1CS; designed for private smart contracts [[1]](https://leo-lang.org/) |
| **Cairo** | 2020 | STARK / Cairo VM | StarkWare; Rust-like syntax; compiles to Cairo assembly for the Cairo VM (an algebraic RISC); powers StarkNet smart contracts; Cairo 1.0 (2023) adds a Sierra IR layer [[1]](https://eprint.iacr.org/2021/1063) |
| **Cairo 1.0 / Sierra** | 2023 | Cairo VM + Sierra IR | Adds memory safety and provable panics via a Safe Intermediate Representation (Sierra); standard language for StarkNet contracts [[1]](https://github.com/starkware-libs/cairo) |

**Design philosophy:**
- **Noir** uses an ACIR (Abstract Circuit Intermediate Representation) that decouples the language from any specific proof system, enabling multi-backend support. Programs look like Rust but all values are field elements or arrays thereof.
- **Leo** takes a functional approach: programs are deterministic functions from inputs to outputs, with the compiler synthesising the constraint system. The Aleo blockchain uses Leo for private application development.
- **Cairo** is the most production-deployed: all StarkNet contracts are written in Cairo 1.0. Sierra ensures that every Cairo program is provable — no stuck states, no unprovable panics.

**State of the art:** Cairo 1.0 (production, StarkNet 2023); Noir v0.x (rapid development, Aztec, 2024); Leo 1.x (Aleo mainnet). These DSLs represent the convergence of ZK proof systems and smart contract languages. See [Circom and SnarkJS](#circom-and-snarkjs), [General-Purpose zkVMs](#general-purpose-zkvms), [zkEVM Taxonomy](#zkevm-taxonomy-and-ecosystem).

---

## CirC (Compiler Infrastructure for ZK and MPC)

**Goal:** A unified compiler framework for cryptographic verification languages. CirC (2021) is a research compiler that takes programs written in high-level languages (C, ZoKrates, Circom) and compiles them into cryptographic constraint systems (R1CS for ZK-SNARKs, boolean/arithmetic circuits for MPC, SMT formulas for verification). It provides a common intermediate representation (IR) — a term-level constraint system — shared across all backends.

| Component | Year | Role | Note |
|-----------|------|------|------|
| **CirC compiler** | 2021 | Multi-backend circuit compiler | Compiles C / ZoKrates / Circom → R1CS (ZK) + arithmetic circuits (MPC) + SMT (verification); USENIX Security 2022 [[1]](https://eprint.iacr.org/2020/1586) |
| **CirC IR** | 2021 | Shared term-level IR | Intermediate representation: typed terms over field/boolean/array sorts; backend-agnostic constraint generation [[1]](https://eprint.iacr.org/2020/1586) |
| **ZoKrates** | 2018 | High-level ZK language | Python-inspired DSL compiling to R1CS + Groth16/PLONK; predates CirC but shares goals; BIU 2018 [[1]](https://eprint.iacr.org/2018/IBM_Research-ZoKrates.pdf) |

**Key contribution:** Prior ZK toolchains (Circom, ZoKrates) are single-backend: each language targets one proof system. CirC introduces a *term-level IR* that represents computations as typed constraint terms independent of any specific cryptographic system. Backend code generators then lower this IR to R1CS (for SNARKs), arithmetic/Boolean circuits (for MPC via ABY/SCALE-MAMBA), or SMT constraints (for formal verification). This enables a single program to be simultaneously compiled for ZK proving AND MPC evaluation.

**Research impact:** CirC (Ozdemir, Brown, Pearce, Ezueh, Sturton; USENIX Security 2022) demonstrated that ZK and MPC can share a compiler infrastructure, enabling cross-protocol optimisations. It also surfaced a class of *underconstrained circuit bugs* — R1CS constraints that are satisfiable by unintended witnesses — now studied as a security problem in ZK compilers.

**State of the art:** CirC (USENIX Security 2022) remains the primary academic reference for multi-backend ZK/MPC compilation. Production compilers (Noir, Leo) adopt similar IR strategies. See [Circom and SnarkJS](#circom-and-snarkjs), [ZK Circuit DSLs](#zk-circuit-dsls-noir-leo-cairo), [MPC](#multi-party-computation-mpc).

---

## Spartan (Transparent R1CS SNARK via Sumcheck)

**Goal:** Zero-knowledge proofs for R1CS with no trusted setup and no FFTs. Spartan (Setty, CRYPTO 2020) reduces R1CS satisfiability directly to multilinear polynomial evaluations using the sumcheck protocol, producing a transparent SNARK whose prover cost is dominated by two multi-scalar multiplications and one sumcheck execution — with no structured reference string required.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Spartan** | 2020 | Sumcheck + multilinear PCS | Transparent zkSNARK for R1CS; no trusted setup; no FFTs; fastest prover among transparent SNARKs at release; CRYPTO 2020 [[1]](https://eprint.iacr.org/2019/550) |
| **Spartan with Hyrax PCS** | 2020 | Pedersen + multilinear | Instantiated with Hyrax polynomial commitment; O(√N) proof size; DL-based [[1]](https://eprint.iacr.org/2019/550) |
| **Spartan with Brakedown/Orion PCS** | 2022 | Expander-code PCS | Plug in linear-time PCS ([Brakedown](#orion-and-brakedown-linear-time-snarks)) for fully linear prover end-to-end [[1]](https://eprint.iacr.org/2021/1043) |

**Key contribution:** Prior transparent SNARKs (STARKs, Ligero) use FFTs or Reed-Solomon encoding. Spartan avoids both by encoding R1CS as a multilinear extension: given an R1CS instance with matrices A, B, C, Spartan reduces the relation Az ∘ Bz = Cz (where ∘ is componentwise multiplication) to a single sumcheck over the boolean hypercube. The sumcheck reduces to a single multilinear polynomial evaluation, which any polynomial commitment scheme can open. This separation — sumcheck IOP + pluggable PCS — makes Spartan the canonical example of the "polynomial IOP + PCS" paradigm later formalized for PLONK and Marlin.

**Arithmetic details:** The prover computes multilinear extensions of A, B, C over GF(p), then runs sumcheck to reduce the R1CS check to point evaluations at a random point r. Committing to the witness polynomial W and opening at r gives the complete proof. Verification is O(log N) field operations plus one PCS opening check.

**State of the art:** Spartan (CRYPTO 2020) is the foundational transparent R1CS SNARK and the theoretical core of [HyperNova](#folding-schemes), [Jolt](#sumcheck-protocol), and recent multilinear proof systems. See [[1]](https://eprint.iacr.org/2019/550).

---

## Marlin and Lunar (Universal SNARKs for R1CS)

**Goal:** Universal and updatable SNARKs for R1CS with a single structured reference string (SRS) that works for all circuits up to a size bound. Marlin (Chiesa-Hu-Maller-Sasson, EUROCRYPT 2020) and its generalization Lunar (Campanelli-Faonio-Fiore-Querol, ASIACRYPT 2021) give efficient polynomial IOPs for R1CS that, when compiled with KZG commitments, achieve O(1) proof size and O(1) verifier time — with an updatable universal setup.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Marlin** | 2020 | Polynomial IOP + KZG | Universal updatable SRS; O(1) proof (3 elements + 13 field elements); O(N log N) prover; EUROCRYPT 2020 [[1]](https://eprint.iacr.org/2019/1047) |
| **AHP (Algebraic Holographic Proof)** | 2020 | Holographic polynomial IOP | Marlin's underlying IOP; holographic = index-dependent oracle; enables universal setup [[1]](https://eprint.iacr.org/2019/1047) |
| **Lunar** | 2021 | Marlin + commit-and-prove | Generalises Marlin with commit-and-prove extensions; modular; supports lookups and custom gates; ASIACRYPT 2021 [[1]](https://eprint.iacr.org/2020/1069) |
| **Aleo / Leo backend** | 2021 | Marlin on BLS12-377 | Production deployment of Marlin in the Aleo blockchain; Leo language compiles to Marlin R1CS [[1]](https://aleo.org/) |

**Key contribution:** Groth16 requires a per-circuit SRS (O(N) elements, circuit-specific toxic waste). Marlin achieves universality by moving to a *holographic* polynomial IOP: the verifier's oracle queries depend on the circuit index (the matrices A, B, C) rather than on the witness, so a single SRS can be shared across all R1CS instances. The SRS consists of the KZG commitment key evaluated at a secret point, plus an additional "index polynomial" commitment for each circuit (computed once per circuit, not per proof). This gives an O(3N) universal SRS and O(1)-size proofs.

**Relation to PLONK:** Both Marlin and PLONK are polynomial IOPs compiled with KZG commitments. PLONK uses a "gate polynomial" approach over a multiplicative subgroup; Marlin uses a holographic algebraic IOP for R1CS directly. Marlin proofs are slightly larger (13 group elements + scalars) but have a cleaner R1CS interface. Lunar generalises both into a commit-and-prove framework that subsumes PLONK, Marlin, and Sonic.

**State of the art:** Marlin (EUROCRYPT 2020) is deployed in Aleo and is the theoretical basis for [HyperPlonk](#hyperplonk) and Lunar. The AHP framework is a key reference for universal SNARK design. See [[1]](https://eprint.iacr.org/2019/1047).

---

## Bulletproofs Inner-Product Argument

**Goal:** Compact range proofs and inner-product arguments without a trusted setup. Bulletproofs (Bünz-Bootle-Boneh-Poelstra-Wuille-Maxwell, S&P 2018) achieves O(log N) proof size for proving knowledge of vectors satisfying an inner product relation, using only the discrete logarithm assumption over ordinary elliptic curves — no trusted setup, no pairings. The primary application is confidential transaction range proofs (Monero, Liquid Network).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bulletproofs IPA** | 2018 | Pedersen commitments + DLP | O(log N) inner-product argument; no trusted setup; range proof in 600 bytes for 64-bit value; S&P 2018 [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs range proof** | 2018 | IPA over Pedersen | Aggregate m range proofs in O(log(m · n)) size; Monero uses single-output variant [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs+** | 2020 | Improved IPA | Halved prover computation via weighted inner products; same proof size [[1]](https://eprint.iacr.org/2020/735) |
| **Generalized Bulletproofs** | 2022 | IPA + arithmetic circuits | Extend Bulletproofs to arbitrary arithmetic circuit satisfiability [[1]](https://eprint.iacr.org/2022/510) |
| **Monero RingCT** | 2017 | Confidential transactions | Bulletproofs adopted in Monero (2018 hard fork) for range proofs in Ring Confidential Transactions [[1]](https://web.getmonero.org/resources/moneropedia/ringCT.html) |

**Key insight:** A standard range proof using bit decomposition and Sigma protocols requires O(N) communication for an N-bit range. Bulletproofs reduce this to O(log N) via a recursive inner-product argument: the prover halves the problem at each step by folding two N/2-element vectors into one, sending only 2 group elements per round. After log N rounds the prover sends a single scalar, giving total proof size of 2 log N + 3 group elements.

**Verification:** Bulletproofs verification requires O(N) scalar multiplications (the verifier must "unfold" the recursive argument), making it slower to verify than SNARK-based range proofs. Multi-scalar multiplication (MSM) can batch-verify m proofs in O(m · log N) group operations using a random linear combination trick.

**Deployed in:** Monero (2018, range proofs in RingCT), Liquid Network (confidential assets), Grin/MimbleWimble, Zcash research. In ZK proof systems, the IPA technique is the commitment scheme underlying [Halo and Halo2](#halo-and-halo2) and the [Compressed Sigma Protocols](#compressed-sigma-protocols) framework.

**State of the art:** Bulletproofs (S&P 2018) remains the gold standard for transparent range proofs under DL assumption. Superseded for general circuit ZK by [Halo2](#halo-and-halo2) (which uses IPA for polynomial commitments) and by STARKs (which are faster to verify). See [[1]](https://eprint.iacr.org/2017/1066).

---

## STARK Arithmetization: AIR and FRI

**Goal:** Understand the internal structure of a STARK proof. STARKs (Ben-Sasson-Bentov-Horesh-Riabzev, IACR 2018) compile a computation into an Algebraic Intermediate Representation (AIR) — a set of polynomial constraints over an execution trace — then prove proximity of the trace polynomial to a low-degree polynomial using the FRI (Fast Reed-Solomon IOP of Proximity) protocol. No trusted setup; plausibly post-quantum.

| Component | Year | Role | Note |
|-----------|------|------|------|
| **AIR (Algebraic Intermediate Representation)** | 2018 | Arithmetization | Encode computation as a matrix of field elements (execution trace) + polynomial constraints between adjacent rows [[1]](https://eprint.iacr.org/2018/046) |
| **RAP (Randomized AIR with Preprocessing)** | 2022 | Extended AIR | Adds verifier-provided randomness between AIR columns; supports permutation/lookup arguments inside STARKs (used in Plonky3, Stwo) [[1]](https://eprint.iacr.org/2022/1530) |
| **FRI (Fast Reed-Solomon IOPP)** | 2018 | Proximity test | Interactive Oracle Proof of Proximity for Reed-Solomon codes; O(log² N) query complexity; backbone of all STARK proof systems [[1]](https://eccc.weizmann.ac.il/report/2017/134/) |
| **DEEP-FRI** | 2020 | FRI soundness boost | Out-of-domain sampling raises soundness from ρ⁻¹ to ≈1 per round; reduces query count; ITCS 2020 [[1]](https://eprint.iacr.org/2019/336) |
| **ALI (Algebraic Linking IOP)** | 2018 | AIR + FRI glue | Connects AIR boundary/transition constraints to FRI via a linking polynomial; the "glue" of a STARK [[1]](https://eprint.iacr.org/2018/046) |

**AIR construction:** Given a computation of T steps, the prover writes an execution trace — a T × w matrix where each row is the machine state at one step. Transition constraints are degree-d multivariate polynomials that must vanish on every adjacent pair of rows. Boundary constraints fix the initial and final state. The prover commits to the trace polynomial (column-by-column) using a Merkle tree over a Reed-Solomon codeword, then runs FRI to prove the trace polynomial is close to degree < T.

**FRI protocol:** FRI folds a polynomial f of degree < N into one of degree < N/2 using a random challenge, repeating log N times. Each folding round sends one Merkle root; the verifier queries ≈ 40 positions total (with DEEP-FRI). The final polynomial is sent explicitly and checked directly. Soundness: a polynomial far from the RS code fails with probability ≈ 1 per round after DEEP sampling.

**Concrete proof structure:**
1. Prover commits to execution trace columns via Merkle trees.
2. Verifier sends AIR composition randomness; prover forms composition polynomial.
3. Prover runs FRI on composition polynomial; verifier queries a small set of positions.
4. Proof = Merkle openings + FRI folding hashes. Size ≈ 45–200 KB for 128-bit security.

**Production systems:** StarkWare's Cairo prover (AIR + DEEP-ALI + FRI), RISC Zero (AIR over BabyBear + FRI), SP1 (Plonky3 + AIR + FRI), Stwo (Circle STARKs over Mersenne31 with AIR). See [General-Purpose zkVMs](#general-purpose-zkvms) and [DEEP-FRI](#deep-fri).

**State of the art:** STARK arithmetization (2018); RAP extensions (2022) for lookup/permutation arguments; DEEP-FRI (2020) for production soundness. STARKs are the dominant transparent proof system in deployment. See [[1]](https://eprint.iacr.org/2018/046).

---

## VOLE-Based Zero-Knowledge Proofs

**Goal:** Efficient interactive ZK proofs for large Boolean/arithmetic circuits using Vector Oblivious Linear Evaluation (VOLE) as a black-box subprotocol. VOLE-based ZK (Weng-Yang-Katz-Wang, CCS 2021; Baum et al., CRYPTO 2021) achieves amortized prover cost of O(1) field operations per gate — the information-theoretic optimum — by replacing commitment-based witness encoding with VOLE correlations that the prover and verifier set up in a preprocessing phase.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **QuickSilver** | 2021 | VOLE over F₂/Fp | ZK proof for Boolean and arithmetic circuits; O(1) amortised cost per gate; prover sends O(|C|) field elements; CCS 2021 [[1]](https://eprint.iacr.org/2021/076) |
| **Wolverine** | 2021 | Silent VOLE + ZK | ZK for arithmetic circuits from silent VOLE (PCG-based); fast preprocessing; CRYPTO 2021 [[1]](https://eprint.iacr.org/2020/925) |
| **Mac'n'Cheese** | 2021 | VOLE + Beaver triples | ZK for Boolean/arithmetic with streaming; prover-efficient; S&P 2022 [[1]](https://eprint.iacr.org/2020/1410) |
| **Limbo (MPC-in-VOLE)** | 2021 | VOLE + MPCitH | Hybrid of VOLE and MPCitH for shorter proofs in public-coin setting [[1]](https://eprint.iacr.org/2021/215) |
| **VOLEitH / FAEST** | 2023 | VOLE-in-the-Head | Non-interactive VOLE-ZK via "in-the-head" simulation; yields PQ signatures; see [VOLEitH](#voleitH-vole-in-the-head) [[1]](https://eprint.iacr.org/2023/996) |

**Core idea:** A VOLE correlation gives the verifier a pair (Δ, K) and the prover a pair (x, M) satisfying M = K + x · Δ over a field. This acts as an information-theoretic MAC on the prover's wire value x: the verifier can check authenticity of x at proof time by comparing M − x · Δ = K. The prover encodes each circuit wire as a VOLE-authenticated value, then proves gate satisfiability by sending small "proof polynomials" whose coefficients are linear combinations of VOLE-authenticated wires. The amortized cost is O(1) field multiplications per gate because all MAC checks can be batched into a single polynomial evaluation.

**Preprocessing vs. online phase:** VOLE setup can be done offline (the "preprocessing" or "offline phase") using either OT-extension-based protocols (Wolverine, Mac'n'Cheese) or silent VOLE from PCGs (Pseudorandom Correlation Generators), making the online proving phase very fast. The total communication for QuickSilver over an N-gate circuit is ≈ 2N field elements for the prover — compared to ≈ 44N for Groth16 (in terms of MSM operations) or ≈ 10N for PLONK.

**Relation to VOLEitH:** [VOLEitH](#voleitH-vole-in-the-head) makes VOLE-based ZK non-interactive by simulating the VOLE setup "in the head" (like MPCitH), at the cost of larger proof sizes. Interactive VOLE-ZK (QuickSilver, Wolverine, Mac'n'Cheese) is preferred when interaction is acceptable and proof size matters less than prover speed.

**State of the art:** QuickSilver and Wolverine (2021) are the canonical interactive VOLE-ZK systems; Mac'n'Cheese for streaming/low-memory settings. Silent VOLE from PCGs (see [OLE/VOLE](categories/06-multi-party-computation.md#ole--vole)) gives practical offline setup. VOLEitH (2023) extends the paradigm to non-interactive proofs. See [[1]](https://eprint.iacr.org/2021/076).

---
