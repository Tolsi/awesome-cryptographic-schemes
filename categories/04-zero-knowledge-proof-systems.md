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

**Production readiness:** Production
PLONK, Groth16, and STARKs are deployed in production blockchains (Zcash, Ethereum L2s, StarkNet) serving billions of dollars in value.

**Implementations:**
- [snarkjs](https://github.com/iden3/snarkjs) ⭐ 2.0k — JavaScript — Groth16/PLONK prover/verifier
- [bellman](https://github.com/zkcrypto/bellman) ⭐ 1.1k — Rust — Groth16 implementation (Zcash)
- [gnark](https://github.com/Consensys/gnark) ⭐ 1.7k — Go — Groth16/PLONK with optimized MSM
- [arkworks](https://github.com/arkworks-rs) — Rust — modular SNARK framework (Groth16, Marlin, PLONK)
- [halo2](https://github.com/zcash/halo2) ⭐ 895 — Rust — PLONK+IPA proving system (Zcash Orchard)

**Security status:** Secure
Groth16, PLONK, and STARKs have no known practical attacks at recommended parameters. Trusted setup ceremonies (for Groth16/PLONK) require careful execution.

**Community acceptance:** Standard
Groth16 and PLONK are peer-reviewed and deployed across major blockchain ecosystems. STARKs are endorsed by StarkWare and Ethereum Foundation researchers.

---

## SNARG (Succinct Non-Interactive Arguments without Zero-Knowledge)

**Goal:** Verifiable computation without privacy. Like a SNARK but the proof need not hide the witness — only succinctness and soundness matter. Useful when you want to verify computation but don't care about privacy (rollup state transitions, compliance proofs).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali CS Proofs** | 2000 | PCP + random oracle | First SNARG via PCP + Fiat-Shamir in ROM [[1]](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Proof%20Systems/Computationally_Sound_Proofs.pdf) |
| **Incrementally Verifiable Computation (Valiant)** | 2008 | Recursive SNARGs | Each step proves correctness of all prior steps; precursor to IVC/Nova [[1]](https://link.springer.com/chapter/10.1007/978-3-540-78524-8_18) |
| **Designated-Verifier SNARG (Kalai et al.)** | 2023 | LWE | SNARG from standard lattice assumptions; designated verifier [[1]](https://eprint.iacr.org/2023/1542) |

**State of the art:** zk-SNARKs subsume SNARGs in practice; designated-verifier SNARGs from LWE (theoretical breakthrough, 2023).

**Production readiness:** Research
Standalone SNARGs are primarily theoretical constructs; in practice, zk-SNARKs (which include zero-knowledge) are used instead.

**Implementations:**
- [arkworks (SNARG modes)](https://github.com/arkworks-rs/snark) ⭐ 898 — Rust — generic SNARG trait and implementations
- [libiop](https://github.com/scipr-lab/libiop) ⭐ 178 — C++ — IOP-based proof system library

**Security status:** Secure
Theoretical constructions are provably secure under standard assumptions (LWE for lattice-based SNARGs). Practical instantiations inherit security of underlying SNARKs.

**Community acceptance:** Niche
Primarily of theoretical interest in the cryptography research community. Practitioners use zk-SNARKs which subsume SNARGs with added privacy.

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

**Production readiness:** Mature
IOPs are a foundational abstraction compiled into production proof systems (STARKs, PLONK). The IOP framework itself is not deployed directly but underlies all modern ZK systems.

**Implementations:**
- [libiop](https://github.com/scipr-lab/libiop) ⭐ 178 — C++ — reference IOP implementations (Aurora, Ligero)
- [winterfell](https://github.com/facebook/winterfell) ⭐ 888 — Rust — STARK prover/verifier built on IOP/FRI
- [ethSTARK](https://github.com/starkware-libs/ethSTARK) ⭐ 236 — C++ — StarkWare's STARK reference implementation

**Security status:** Secure
IOPs and PCPs are information-theoretically secure. Compiled proof systems inherit security of the IOP plus the commitment scheme.

**Community acceptance:** Standard
The PCP theorem is a cornerstone of theoretical computer science. IOPs are the accepted foundation for modern proof system design, endorsed across academia and industry.

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

**Production readiness:** Production
Deployed in TLS 1.3, SSH, Tor, Bitcoin (Schnorr/Taproot), and virtually every DLP-based authentication system.

**Implementations:**
- [libsodium (crypto_sign)](https://github.com/jedisct1/libsodium) ⭐ 13k — C — Ed25519/Schnorr signatures
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k — Rust — Schnorr proofs and DLEQ
- [secp256k1 (Bitcoin)](https://github.com/bitcoin-core/secp256k1) ⭐ 2.4k — C — Schnorr signatures for Bitcoin Taproot

**Security status:** Secure
Sigma protocols are provably secure under the discrete logarithm assumption. Fiat-Shamir transform is secure in the random oracle model.

**Community acceptance:** Standard
NIST-standardized (EdDSA/Ed25519), IETF RFC 8032, BIP-340 (Bitcoin Schnorr). Universally accepted as the foundation of DLP-based ZK.

---

## Groth-Sahai Proofs

**Goal:** Non-interactive ZK for pairing equations. Prove satisfiability of equations over group elements and scalars in bilinear groups — without random oracles. The standard NIZK framework for pairing-based cryptography.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth-Sahai (GS) Proofs** | 2008 | Pairings (DLIN/SXDH) | NIZK for pairing-product equations; witness-indistinguishable or ZK [[1]](https://eprint.iacr.org/2007/155) |
| **GS Proofs for Linear Equations** | 2008 | Pairings | Special case: linear equations have constant-size proofs [[1]](https://eprint.iacr.org/2007/155) |
| **Extractable GS** | 2012 | Knowledge assumptions | Proofs of knowledge variant; extractable witnesses [[1]](https://eprint.iacr.org/2012/028) |

**State of the art:** Groth-Sahai (2008); the canonical NIZK for pairing-based constructions. Enables [SPS](#structure-preserving-signatures-sps), group signatures, and anonymous credentials without random oracles.

**Production readiness:** Mature
Well-studied with production-quality implementations, but limited large-scale deployment outside pairing-based credential and signature schemes.

**Implementations:**
- [relic-toolkit](https://github.com/relic-toolkit/relic) ⭐ 508 — C — pairing-based cryptography including GS proofs
- [charm-crypto](https://github.com/JHUISI/charm) ⭐ 633 — Python — prototyping library with GS proof support

**Security status:** Secure
Secure under DLIN or SXDH assumptions in bilinear groups. No known attacks at standard parameter sizes.

**Community acceptance:** Niche
Well-respected in the pairing-based cryptography community. Standard tool for academic constructions of group signatures, anonymous credentials, and SPS.

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

**Production readiness:** Experimental
Nova has working implementations and is used in zkVM prototypes (Nexus). HyperNova and ProtoStar are in active development. No large-scale production deployment yet.

**Implementations:**
- [Nova (Microsoft Research)](https://github.com/microsoft/Nova) ⭐ 837 — Rust — original Nova implementation
- [sonobe](https://github.com/privacy-scaling-explorations/sonobe) ⭐ 265 — Rust — modular folding library (Nova, HyperNova, ProtoGalaxy)
- [arecibo](https://github.com/argumentcomputer/arecibo) ⭐ 89 — Rust — SuperNova/Nova implementation
- [nexus-zkvm](https://github.com/nexus-xyz/nexus-zkvm) ⭐ 2.6k — Rust — Nova-based zkVM

**Security status:** Secure
Nova is provably secure under the discrete logarithm assumption. Newer schemes (HyperNova, ProtoStar) have formal security proofs but less implementation maturity.

**Community acceptance:** Emerging
Rapidly growing adoption in ZK research. Nova (Microsoft Research) is widely cited. Active standardization efforts in the Ethereum and zkVM communities.

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

**Production readiness:** Production
Plookup and LogUp are deployed in production zkEVMs (Polygon, Scroll) and zkVMs (SP1, RISC Zero). Core building block of all modern ZK systems.

**Implementations:**
- [halo2 (lookup gates)](https://github.com/zcash/halo2) ⭐ 895 — Rust — Plookup-style lookups in Halo2
- [Plonky3](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust — LogUp-GKR lookups
- [gnark](https://github.com/Consensys/gnark) ⭐ 1.7k — Go — lookup argument support in PLONK

**Security status:** Secure
Plookup, LogUp, and Lasso have formal security proofs. Caulk/Caulk+ are secure under knowledge-of-exponent assumptions.

**Community acceptance:** Widely trusted
Lookup arguments are universally adopted in the ZK community. Plookup and LogUp are de facto standards in zkEVM and zkVM implementations.

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

**Production readiness:** Production
Sumcheck is deployed in production via Jolt, Spartan, and Plonky3-based systems. Core protocol in SP1 and other zkVMs.

**Implementations:**
- [arkworks (sumcheck)](https://github.com/arkworks-rs/sumcheck) ⭐ 88 — Rust — sumcheck protocol implementation
- [Plonky3](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust — sumcheck-based proving
- [Jolt](https://github.com/a16z/jolt) ⭐ 966 — Rust — sumcheck+Lasso zkVM
- [microsoft/Spartan](https://github.com/microsoft/Spartan) ⭐ 849 — Rust — sumcheck-based transparent SNARK

**Security status:** Secure
The sumcheck protocol has information-theoretic soundness. No known attacks; security is unconditional given honest random challenges.

**Community acceptance:** Widely trusted
A cornerstone of interactive proof theory since 1992. Increasingly adopted in production proof systems. Endorsed by leading cryptographers (Setty, Thaler, Boneh).

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

**Production readiness:** Production
SP1 and RISC Zero are deployed in Ethereum L2 rollups and ZK coprocessors. Cairo VM powers StarkNet mainnet.

**Implementations:**
- [SP1](https://github.com/succinctlabs/sp1) ⭐ 1.6k — Rust — RISC-V zkVM (Succinct Labs)
- [risc0](https://github.com/risc0/risc0) ⭐ 2.1k — Rust — RISC-V zkVM (RISC Zero)
- [Jolt](https://github.com/a16z/jolt) ⭐ 966 — Rust — lookup-based RISC-V zkVM (a16z)
- [nexus-zkvm](https://github.com/nexus-xyz/nexus-zkvm) ⭐ 2.6k — Rust — Nova-based zkVM
- [cairo](https://github.com/starkware-libs/cairo) ⭐ 1.9k — Rust — Cairo VM and compiler (StarkWare)
- [valida](https://github.com/valida-xyz/valida) ⭐ 342 — Rust — custom-ISA zkVM

**Security status:** Caution
Underlying proof systems (STARKs, PLONK) are secure, but zkVM implementations are complex and still undergoing audits. Bugs in circuit constraints can compromise soundness.

**Community acceptance:** Emerging
Rapidly growing adoption in the Ethereum ecosystem. SP1 and RISC Zero are backed by major crypto VCs. No formal standardization yet but strong industry momentum.

---

## Proof-Carrying Data (PCD)

**Goal:** Distributed IVC. Extend incrementally verifiable computation to distributed settings: each node in a computation graph produces a proof that all prior computation was correct. Foundation of blockchain interoperability and recursive SNARKs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chiesa-Tromer (PCD)** | 2010 | Recursive SNARKs | First PCD construction; compliance proofs for distributed protocols [[1]](https://eprint.iacr.org/2010/174) |
| **Recursive SNARK composition** | 2014 | Cycles of curves | Practical PCD via SNARK verifier inside a SNARK (Ben-Sasson et al.) [[1]](https://eprint.iacr.org/2014/595) |
| **Nova-based PCD** | 2022 | Folding schemes | IVC + folding for lightweight distributed proof chains [[1]](https://eprint.iacr.org/2021/370) |

**State of the art:** Nova-based PCD (efficient), recursive SNARKs on cycles of elliptic curves (Mina, Pickles).

**Production readiness:** Production
Deployed in Mina Protocol (Pickles/Kimchi) which maintains a constant-size blockchain proof. Also used in recursive SNARK aggregation layers.

**Implementations:**
- [Pickles/Kimchi (Mina)](https://github.com/MinaProtocol/mina) ⭐ 2.1k — OCaml/Rust — PCD framework powering Mina blockchain
- [Nova (Microsoft)](https://github.com/microsoft/Nova) ⭐ 837 — Rust — IVC (sequential PCD)

**Security status:** Secure
Recursive SNARK composition on cycles of curves is provably secure. Pickles has been in production since Mina mainnet (2021) with no known attacks.

**Community acceptance:** Widely trusted
Established theoretical foundation (Chiesa-Tromer 2010). Production-validated by Mina Protocol. Endorsed by leading researchers in the ZK community.

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

**Production readiness:** Mature
Picnic was a NIST PQ signature candidate. Banquet and ZKBoo have working implementations. Used in post-quantum signature research.

**Implementations:**
- [Picnic](https://github.com/microsoft/Picnic) ⭐ 168 — C — NIST PQ signature candidate (Microsoft)

**Security status:** Secure
Security reduces to the underlying symmetric primitives (AES, LowMC). Post-quantum secure when using appropriate hash functions.

**Community acceptance:** Emerging
Picnic was a NIST Round 3 alternate candidate. The MPCitH paradigm is well-respected in the PQ signature community. Growing adoption alongside VOLEitH.

---

## VOLEitH (VOLE-in-the-Head)

**Goal:** Efficient ZK from VOLE. Generalize MPCitH by replacing the secret-sharing-based MPC with VOLE as the underlying subprotocol. Produces shorter proofs for large witness languages (e.g., AES circuits). Foundation of the FAEST post-quantum signature.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Baum-Braun-Delpech de Saint Guilhem et al. VOLEitH** | 2023 | VOLE + ZK | First VOLEitH; shorter proofs than MPCitH for arithmetic witnesses; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/996) |
| **FAEST Signature** | 2023 | VOLEitH + AES | PQ signature from VOLEitH on AES; security = AES key recovery; NIST Round 2 [[1]](https://faest.info/) |
| **Appenzeller-to-Brie (A2B)** | 2024 | VOLEitH optimization | Improved VOLEitH with batch verification and smaller proofs [[1]](https://eprint.iacr.org/2024/1075) |

**State of the art:** FAEST (NIST Additional Sigs Round 2); VOLEitH as paradigm alongside [MPCitH](#mpc-in-the-head-mpcith) and [Sigma Protocols](#sigma-protocols--schnorr-identification).

**Production readiness:** Experimental
FAEST is in NIST Additional Signatures Round 2. Research implementations exist but no large-scale production deployment yet.

**Implementations:**
- [FAEST](https://github.com/faest-sign/faest-ref) ⭐ 19 — C — FAEST reference implementation (NIST candidate)
- [VOLEitH reference](https://github.com/faest-sign/faest-avx) ⭐ 5 — C — AVX2-optimized FAEST implementation

**Security status:** Secure
FAEST security reduces to AES key recovery hardness. VOLEitH proofs have formal security proofs under standard assumptions.

**Community acceptance:** Emerging
FAEST is advancing through NIST standardization. VOLEitH is gaining recognition as a competitive PQ ZK paradigm alongside MPCitH.

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

**Production readiness:** Production
Circle STARKs + Stwo are in production at StarkWare. Plonky3 (with small-field support) powers SP1 and Polygon CDK.

**Implementations:**
- [Binius](https://github.com/IrreducibleOSS/binius) ⭐ 133 — Rust — binary tower field proof system (Irreducible)
- [Stwo](https://github.com/starkware-libs/stwo) ⭐ 481 — Rust — Circle STARK prover (StarkWare)
- [Plonky3](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust — modular prover framework (Goldilocks/M31/BabyBear)

**Security status:** Secure
Security relies on standard hash function assumptions (for FRI/STARK) or coding-theoretic assumptions. No known attacks at recommended parameters.

**Community acceptance:** Emerging
Rapidly gaining adoption. Stwo and Plonky3 are deployed in major L2 projects. Binius framework is endorsed by leading ZK researchers (Vitalik Buterin, Justin Drake).

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

**Production readiness:** Research
Academic prototypes and benchmarks exist. No dominant production implementation yet. TACEO and Pianist have proof-of-concept code.

**Implementations:**
- [TACEO co-SNARK](https://github.com/TaceoLabs/collaborative-circom) ⭐ 217 — Rust — collaborative Circom proving via MPC

**Security status:** Secure
Security inherits from underlying SNARK (Groth16, PLONK) plus MPC protocol security. Formal UC-security proofs exist for some constructions.

**Community acceptance:** Niche
Active research area with growing interest from privacy-focused blockchain projects. No standardization; papers are peer-reviewed at top venues (CRYPTO, CCS).

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

**Production readiness:** Experimental
EZKL has production-grade tooling for ONNX model verification. Other systems are research prototypes or early-stage products.

**Implementations:**
- [EZKL](https://github.com/zkonduit/ezkl) ⭐ 1.2k — Rust — prove ONNX model inference in ZK
- [Giza/Orion](https://github.com/gizatechxyz/orion) ⭐ 174 — Cairo — ONNX to STARK-provable execution

**Security status:** Caution
Underlying proof systems are secure, but fixed-point arithmetic approximations in ML circuits may introduce precision-related soundness gaps. Active area of security analysis.

**Community acceptance:** Emerging
High-profile research area backed by a16z, Modulus Labs, and Polyhedra. No standardization yet. Growing interest from AI safety and verifiable AI communities.

---

## Compressed Sigma Protocols

**Goal:** Logarithmic proof compression. Compress n parallel Sigma protocol executions into a proof of size O(log n) — using an inner-product-like recursive argument. Generalizes the Bulletproofs inner-product technique to arbitrary Sigma protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bulletproofs IPA** | 2018 | Pedersen + DLP | Inner-product argument: compress n multiplications to O(log n) proof [[1]](https://eprint.iacr.org/2017/1066) |
| **Compressed Σ-Protocols (Attema-Cramer)** | 2020 | Any Sigma + pivot | General framework: compress any Sigma protocol for homomorphic relations [[1]](https://eprint.iacr.org/2020/152) |
| **Compressed Σ for Lattices** | 2021 | SIS/LWE | Extension to lattice-based Sigma protocols; post-quantum compressed proofs [[1]](https://eprint.iacr.org/2021/307) |

**State of the art:** Attema-Cramer (2020) as general framework; Bulletproofs IPA as most deployed instance. Extends [Sigma Protocols](#sigma-protocols--schnorr-identification) and [Bulletproofs](#zero-knowledge-proofs-zk).

**Production readiness:** Mature
Bulletproofs IPA (the primary deployed instance) is in production. The general Attema-Cramer framework has reference implementations.

**Implementations:**
- [dalek-bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust — Bulletproofs IPA implementation
- [secp256k1-zkp (Bulletproofs)](https://github.com/ElementsProject/secp256k1-zkp) ⭐ 419 — C — Bulletproofs for Liquid Network

**Security status:** Secure
Secure under the discrete logarithm assumption. Lattice extensions are secure under SIS/LWE.

**Community acceptance:** Widely trusted
Bulletproofs IPA is deployed in Monero and Liquid Network. The Attema-Cramer framework is well-cited in academic literature.

---

## Zero-Knowledge Sets

**Goal:** Private set with membership/non-membership proofs. A prover commits to a set S without revealing it, then proves for any element x whether x ∈ S or x ∉ S — without leaking S's size or other elements. Stronger than accumulators.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Micali-Rabin-Kilian ZK Sets** | 2003 | Merkle + trapdoor hash | First ZK sets; prove membership AND non-membership without revealing set [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |
| **Chase-Healy-Lysyanskaya-Malkin-Reyzin** | 2005 | q-SDH | Efficient ZK sets from bilinear assumptions [[1]](https://eprint.iacr.org/2005/292) |
| **ZK Elementary Database (ZK-EDB)** | 2003 | Trapdoor commitments | Key-value database with ZK proofs for queries and non-existence [[1]](https://doi.org/10.1109/SFCS.2003.1238200) |

**State of the art:** ZK sets from Merkle trees + trapdoor hashing. Extends [Accumulators](#accumulators) with non-membership proofs and set hiding.

**Production readiness:** Research
Primarily theoretical constructions. No widely deployed production implementation; used in academic protocol designs.

**Implementations:**
- [libiop (set primitives)](https://github.com/scipr-lab/libiop) ⭐ 178 — C++ — IOP library with set-related proof primitives

**Security status:** Secure
Provably secure under standard assumptions (trapdoor hash functions, q-SDH). No known attacks.

**Community acceptance:** Niche
Well-studied in theoretical cryptography. Limited practical adoption; most applications use simpler accumulators or Merkle proofs instead.

---

## Witness PRF

**Goal:** NP-gated pseudorandom evaluation. A PRF where anyone holding a witness w for an NP statement x can compute PRF(x) — without a secret key. Combines properties of PRFs, witness encryption, and constrained PRFs into one powerful primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zhandry Witness PRF** | 2016 | Multilinear maps | First construction; evaluate PRF using NP witness instead of secret key [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF from iO** | 2016 | Indistinguishability obfuscation | Alternative construction from iO; more general [[1]](https://eprint.iacr.org/2016/597) |
| **Witness PRF Applications** | 2016 | — | Implies multi-party key exchange, secret sharing for NP, more [[1]](https://eprint.iacr.org/2016/597) |

**State of the art:** Theoretical; constructions require [iO](#indistinguishability-obfuscation-io) or [Multilinear Maps](#multilinear-maps). Implies [Witness Encryption](#witness-encryption), [Constrained PRFs](#puncturable--constrained-prf), and more.

**Production readiness:** Research
Purely theoretical constructions requiring iO or multilinear maps, neither of which has practical implementations.

**Implementations:**
- [No production implementations](https://eprint.iacr.org/2016/597) — Theoretical — constructions require iO or multilinear maps

**Security status:** Caution
Security relies on assumptions about iO or multilinear maps, which remain controversial and lack efficient instantiations.

**Community acceptance:** Niche
Important theoretical primitive studied in the foundations of cryptography. No practical deployment path exists with current technology.

---

## Malleable Proof Systems / Controlled-Malleable NIZK

**Goal:** Proof transformation without witness. Transform a valid NIZK proof π for statement x into a valid proof π' for a related statement x' — without knowing the witness for either. The transformation is "controlled": only specific, predefined relations between statements are allowed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Kohlweiss-Lysyanskaya-Meiklejohn** | 2012 | Groth-Sahai proofs | First controlled-malleable NIZK; define allowed transformations via relations [[1]](https://eprint.iacr.org/2012/345) |
| **Malleable Signatures (Chase et al.)** | 2012 | SPS + GS | Derive signatures on related messages; enables delegatable credentials [[1]](https://eprint.iacr.org/2012/345) |
| **cm-NIZK for Circuits** | 2014 | Pairings | Controlled malleability for general circuit satisfiability [[1]](https://eprint.iacr.org/2014/590) |

**State of the art:** cm-NIZK from [Groth-Sahai](#groth-sahai-proofs) proofs; enables delegatable [Anonymous Credentials](#anonymous-credentials) and proof-carrying data without interaction.

**Production readiness:** Research
Academic constructions built on Groth-Sahai proofs. Used in theoretical designs of delegatable credentials and proof systems.

**Implementations:**
- [relic-toolkit (GS proofs)](https://github.com/relic-toolkit/relic) ⭐ 508 — C — pairing library supporting GS-based constructions

**Security status:** Secure
Provably secure under DLIN/SXDH assumptions (inherited from Groth-Sahai). The controlled malleability property is formally defined and proven.

**Community acceptance:** Niche
Well-cited in academic cryptography. Primarily used as a building block in theoretical constructions of anonymous credentials and delegatable signatures.

---

## Witness Indistinguishability (WI) / Witness Hiding

**Goal:** Relaxed zero-knowledge. Witness indistinguishability: the verifier cannot distinguish which of multiple valid witnesses the prover used. Witness hiding: the verifier cannot compute any witness after the interaction. Weaker than ZK but sufficient for many applications and compositionally robust.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Feige-Shamir WI/WH** | 1990 | Any NP | Formal definitions; WI ⊂ ZK; WI composes under parallel composition (ZK does not) [[1]](https://doi.org/10.1145/100216.100272) |
| **WI from Sigma Protocols** | 1994 | DLP | Run two Sigma protocols in parallel; WI without ZK [[1]](https://doi.org/10.1007/BFb0053443) |
| **Resettable WI (Deng-Goyal-Sahai)** | 2009 | One-way functions | WI secure even if verifier can reset prover to initial state [[1]](https://doi.org/10.1109/FOCS.2009.12) |

**State of the art:** WI is the default security notion for many sub-protocols in [MPC](#multi-party-computation-mpc) and credential systems. Composes better than ZK — see [ZK Proofs](#zero-knowledge-proofs-zk), [Sigma Protocols](#sigma-protocols--schnorr-identification).

**Production readiness:** Mature
WI is a standard security notion used in production protocols (MPC, credential systems) rather than deployed as a standalone primitive.

**Implementations:**
- [libsnark](https://github.com/scipr-lab/libsnark) ⭐ 1.9k — C++ — SNARK library with WI proof modes

**Security status:** Secure
WI is a well-defined security property with formal proofs. Composes under parallel composition (unlike ZK), making it robust for concurrent protocols.

**Community acceptance:** Standard
Foundational security notion in theoretical cryptography since 1990. Universally accepted in the research community as a standard building block.

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

**Production readiness:** Research
Theoretical breakthrough constructions. Practical protocols use simpler timing-based or CRS-based approaches for concurrent composition.

**Implementations:**
- [No production implementations](https://eprint.iacr.org/2012/563) — Theoretical — constant-round concurrent ZK requires non-black-box techniques

**Security status:** Secure
Provably secure under standard cryptographic assumptions. Security proofs are rigorous but non-constructive (non-black-box simulation).

**Community acceptance:** Niche
Major theoretical breakthrough (Barak 2001). Essential for the foundations of ZK theory but rarely implemented directly in practice.

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

**Production readiness:** Research
MIPs are a complexity-theoretic concept. Practical systems derived from MIP techniques (GKR, sumcheck) are in production, but MIPs themselves are theoretical.

**Implementations:**
- [GKR implementations (via Spartan/Jolt)](https://github.com/microsoft/Spartan) ⭐ 849 — Rust — GKR-derived sumcheck proofs

**Security status:** Secure
MIPs have information-theoretic security (unconditional soundness given non-communicating provers). MIP* = RE is a landmark result.

**Community acceptance:** Standard
Foundational in computational complexity theory. MIP = NEXP (1991) and MIP* = RE (2020) are landmark results. The GKR protocol is widely used in practice.

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

**Production readiness:** Experimental
TLSNotary is open-source and actively used. DECO and Reclaim Protocol have working implementations. Main bottleneck is MPC overhead for TLS.

**Implementations:**
- [TLSNotary](https://github.com/tlsnotary/tlsn) ⭐ 407 — Rust — MPC-TLS prover/verifier
- [zk-email](https://github.com/zkemail/zk-email-verify) ⭐ 422 — TypeScript/Circom — DKIM-based email proofs
- [zkp2p](https://github.com/zkp2p/zk-p2p) ⭐ 335 — TypeScript/Circom — ZK proofs over TLS payment data

**Security status:** Caution
TLS session splitting introduces a trust assumption on the MPC co-signer/notary. Security proofs exist (DECO is UC-secure) but implementations are still maturing.

**Community acceptance:** Emerging
Growing adoption in DeFi and oracle protocols. TLSNotary is widely cited. Active development by multiple teams (Chainlink, Reclaim, Opacity).

---

## Sonic

**Goal:** Universal, updatable SNARK with a single global setup. Sonic was the first practical zk-SNARK to support a universal and continuously updatable structured reference string (SRS) that scales linearly in circuit size, eliminating per-circuit trusted setup ceremonies. It directly inspired PLONK and Marlin.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sonic** | 2019 | KZG + polynomial IOP | Universal updatable SRS; linear-size; helper-based batch verification; CCS 2019 [[1]](https://eprint.iacr.org/2019/099) |
| **Sonic with helpers** | 2019 | Sonic + advisory witnesses | Untrusted "helpers" supply advice enabling O(1) amortised verifier time in batch settings [[1]](https://eprint.iacr.org/2019/099) |

**Key contribution:** Prior universal SNARKs (e.g., Groth-Maller) required a quadratically growing SRS. Sonic achieved linear SRS size. The updatability property means any party can contribute randomness to the SRS at any time, providing perpetual security under a 1-of-N assumption.

**State of the art:** Superseded in practice by PLONK (2019) and Marlin (2019), which improved on Sonic's prover efficiency while retaining universality and updatability. Sonic remains important as the direct conceptual predecessor of the "universal SNARK" paradigm. See [[1]](https://eprint.iacr.org/2019/099).

**Production readiness:** Deprecated
Superseded by PLONK and Marlin (2019), which offer better prover efficiency. Sonic is no longer actively developed.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Provably secure under the algebraic group model + random oracle model. No known attacks, but superseded by more efficient systems.

**Community acceptance:** Niche
Important historically as the first practical universal SNARK. Recognized as the conceptual predecessor of PLONK and Marlin.

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

**Production readiness:** Mature
Aurora and Ligero have reference implementations. Their techniques are subsumed by STARKs and Brakedown/Orion in production.

**Implementations:**
- [libiop (Aurora/Ligero)](https://github.com/scipr-lab/libiop) ⭐ 178 — C++ — reference IOP implementations
- [winterfell (STARK-based successors)](https://github.com/facebook/winterfell) ⭐ 888 — Rust — STARK prover inheriting IOP ideas from Aurora

**Security status:** Secure
Transparent and plausibly post-quantum. Security relies only on collision-resistant hash functions. No known attacks.

**Community acceptance:** Niche
Academically well-regarded. Aurora and Ligero are foundational references for transparent SNARKs but have been superseded in production by STARKs.

---

## HyperPlonk

**Goal:** Linear-time prover SNARK on the boolean hypercube. HyperPlonk adapts the PLONK polynomial IOP to multilinear polynomials over the boolean hypercube, replacing FFTs with the sumcheck protocol. This gives an O(N) prover (vs. O(N log N) for PLONK) and supports high-degree custom gates without performance penalty.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HyperPlonk** | 2022 | Multilinear PLONK + sumcheck | O(N) prover; no FFT; high-degree custom gates; pluggable multilinear PCS; EUROCRYPT 2023 [[1]](https://eprint.iacr.org/2022/1355) |
| **HyperPlonk + Orion PCS** | 2022 | HyperPlonk with linear-time PCS | Using Orion as polynomial commitment gives fully linear prover end-to-end; opening proofs < 10 KB [[1]](https://eprint.iacr.org/2022/1355) |

**Key contribution:** Classical PLONK uses univariate polynomials over a multiplicative subgroup, requiring FFTs (O(N log N)) for the prover. HyperPlonk moves to the boolean hypercube where the sumcheck protocol handles all key sub-protocols. Custom gates of degree d cost O(dN) rather than O(N log N · d). Permutation checks are replaced by a novel multiset equality argument over the hypercube.

**State of the art:** HyperPlonk (2022) is the state-of-the-art Plonkish system for prover time; used as the IOP layer in several multilinear SNARK stacks. Closely related to [Spartan](#sumcheck-protocol), [Sumcheck](#sumcheck-protocol), and [Binius](#binary-field-proof-systems). See [[1]](https://eprint.iacr.org/2022/1355).

**Production readiness:** Experimental
Reference implementation exists. Used as the IOP layer in research SNARK stacks but not yet a standalone production system.

**Implementations:**
- [hyperplonk (reference)](https://github.com/EspressoSystems/hyperplonk) ⭐ 340 — Rust — HyperPlonk reference implementation (Espresso Systems)

**Security status:** Secure
Provably secure with formal proofs (EUROCRYPT 2023). No known attacks at recommended parameters.

**Community acceptance:** Emerging
Published at EUROCRYPT 2023. Recognized as the state-of-the-art Plonkish system for prover time. Gaining adoption in multilinear SNARK research.

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

**Production readiness:** Experimental
Working implementations exist with competitive benchmarks. Used as PCS components in research SNARK stacks. Orion+ (2024) fixes a soundness issue in the original.

**Implementations:**
- [Orion](https://github.com/sunblaze-ucb/orion) ⭐ 31 — Rust — linear-time SNARK prover

**Security status:** Caution
Brakedown (CRYPTO 2023) has clean security proofs. Original Orion had a soundness issue fixed in Orion+ (2024). Use the corrected version.

**Community acceptance:** Emerging
Published at top cryptography venues (CRYPTO 2022/2023). Recognized as theoretically optimal in prover time. Growing adoption as PCS in HyperPlonk-style systems.

---

## RedShift

**Goal:** Transparent SNARK via list polynomial commitments. RedShift (2019) gives the first efficient transformation of any KZG-based (trusted-setup) SNARK into a transparent counterpart by replacing KZG polynomial commitments with a new primitive called a list polynomial commitment, instantiated via FRI. This yields a transparent, plausibly post-quantum SNARK from any polynomial IOP.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RedShift** | 2019/2022 | List polynomial commitment + FRI | Transparent SNARKs from KZG-based IOPs; works over prime and binary fields; CCS 2022 [[1]](https://eprint.iacr.org/2019/1400) |

**Key contribution:** KZG-based SNARKs (PLONK, Marlin, Sonic) require a trusted setup (powers-of-tau SRS). RedShift defines a *list polynomial commitment* (LPC) — a polynomial commitment scheme that tolerates a list of valid openings rather than a unique one — and shows LPCs can be instantiated with FRI (no trusted setup). Plugging LPC into any polynomial IOP yields a transparent SNARK with no SRS ceremony.

**Relation to other schemes:** RedShift predates the explicit "PLONK + FRI = Plonky2" design but formalises the same core idea. Plonky2, Polygon's zkEVM STARK backend, and StarkWare's Cairo prover all implicitly instantiate similar list polynomial commitments.

**State of the art:** RedShift (Kattis-Panarin-Vlasov, CCS 2022); the LPC framework is the theoretical foundation of the PLONK-over-FRI approach used in Plonky2 and Polygon's prover stack. See [[1]](https://eprint.iacr.org/2019/1400).

**Production readiness:** Mature
The LPC framework is the theoretical basis of Plonky2 and Polygon's prover stack. RedShift itself has reference implementations.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Transparent; relies on FRI soundness and collision-resistant hashing. No known attacks.

**Community acceptance:** Niche
Published at CCS 2022. Recognized as the formal foundation of the PLONK-over-FRI approach. Ideas widely adopted but the scheme itself is not directly deployed.

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

**Production readiness:** Production
Deployed in Zcash Sapling, Tornado Cash, Filecoin, and Ethereum's zkSNARK precompile (EIP-197). The most widely deployed pairing-based SNARK.

**Implementations:**
- [snarkjs (Groth16)](https://github.com/iden3/snarkjs) ⭐ 2.0k — JavaScript — browser/Node.js Groth16 prover/verifier
- [bellman](https://github.com/zkcrypto/bellman) ⭐ 1.1k — Rust — Groth16 implementation (Zcash)
- [gnark (Groth16)](https://github.com/Consensys/gnark) ⭐ 1.7k — Go — optimized Groth16 with GPU MSM support
- [arkworks-groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 — Rust — Groth16 in the arkworks framework
- [circom + snarkjs](https://docs.circom.io/) — DSL + JS — most common Groth16 circuit development toolchain

**Security status:** Secure
Provably secure under the generic bilinear group model. Requires a per-circuit trusted setup ceremony; toxic waste must be destroyed. Simulation-extractable variant (2020) adds composability.

**Community acceptance:** Standard
Gold standard for smallest proof size. EUROCRYPT 2016. Universally adopted in the blockchain ZK ecosystem. Powers billions of dollars in Zcash and DeFi applications.

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

**Production readiness:** Production
Halo2 is deployed in Zcash Orchard (mainnet since 2022) and numerous zkEVM projects (Scroll, Polygon Hermez, PSE).

**Implementations:**
- [halo2 (ECC/Zcash)](https://github.com/zcash/halo2) ⭐ 895 — Rust — production Halo2 proving system
- [halo2 (PSE fork)](https://github.com/privacy-scaling-explorations/halo2) ⭐ 244 — Rust — PSE fork used in Scroll and other zkEVMs
- [halo2-lib](https://github.com/axiom-crypto/halo2-lib) ⭐ 309 — Rust — high-level Halo2 circuit development library (Axiom)

**Security status:** Secure
Secure under the discrete logarithm assumption over ordinary elliptic curves. No trusted setup required. Accumulation scheme has formal security proofs.

**Community acceptance:** Widely trusted
Deployed by Zcash (ECC) since 2022. PSE fork is the backend for multiple Ethereum zkEVM projects. Endorsed by the Ethereum Foundation and Zcash community.

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

**Production readiness:** Production
Deployed in Polygon Zero's ZK proving infrastructure. Plonky3 (successor) powers SP1 and Polygon CDK.

**Implementations:**
- [plonky2](https://github.com/0xPolygonZero/plonky2) ⭐ 856 — Rust — Polygon Zero's recursive SNARK
- [Plonky3](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust — modular successor framework (SP1, Polygon CDK)

**Security status:** Secure
Security relies on FRI soundness over the Goldilocks field and collision-resistant hashing. No trusted setup. No known attacks.

**Community acceptance:** Widely trusted
Developed by Polygon Zero. Plonky3 is the IOP backend for SP1 (Succinct) and Polygon CDK. Trusted by the Ethereum L2 ecosystem.

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

**Production readiness:** Production
DEEP-FRI is the soundness backbone of all production STARK provers (StarkWare, RISC Zero, SP1). Deployed at scale since StarkNet mainnet.

**Implementations:**
- [ethSTARK (DEEP-FRI)](https://github.com/starkware-libs/ethSTARK) ⭐ 236 — C++ — StarkWare's STARK prover with DEEP-FRI
- [winterfell](https://github.com/facebook/winterfell) ⭐ 888 — Rust — STARK library with DEEP-FRI
- [risc0 (DEEP-FRI)](https://github.com/risc0/risc0) ⭐ 2.1k — Rust — RISC Zero's STARK prover uses DEEP-FRI

**Security status:** Secure
Formal soundness proofs (ITCS 2020). DEEP sampling boosts security per round to nearly 1, reducing proof size. No known attacks.

**Community acceptance:** Standard
Universally adopted in the STARK ecosystem. Published at ITCS 2020 by the StarkWare research team. De facto standard for FRI-based proof systems.

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

**Production readiness:** Production
Scroll (Type 2), Polygon zkEVM (Type 2.5), and Taiko (Type 1) are on Ethereum mainnet. zkSync Era (Type 4) has been live since 2023.

**Implementations:**
- [scroll-zkevm](https://github.com/scroll-tech/scroll-zkevm) ⭐ 684 — Rust/Go — Scroll's Type 2 zkEVM circuits
- [polygon-zkevm](https://github.com/0xPolygonHermez/zkevm-prover) ⭐ 243 — C++ — Polygon zkEVM prover
- [zksync-era](https://github.com/matter-labs/zksync-era) ⭐ 3.2k — Rust — zkSync Era node and prover
- [taiko-mono](https://github.com/taikoxyz/taiko-mono) ⭐ 4.6k — TypeScript/Solidity — Taiko Type 1 zkEVM

**Security status:** Caution
Underlying proof systems are secure, but zkEVM implementations are complex (millions of constraints). Ongoing audits and bug bounties. EVM edge cases may cause soundness issues.

**Community acceptance:** Emerging
Vitalik Buterin's 2022 taxonomy is the accepted classification framework. Multiple mainnet deployments since 2023. Active Ethereum Foundation support and research.

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

**Production readiness:** Research
Published at CCS 2024. Reference implementation exists but no production deployment yet.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Transparent; relies on collision-resistant hashing. Formally proven secure at CCS 2024. No known attacks.

**Community acceptance:** Niche
Published at CCS 2024. First practically efficient small-field SNARK. Complements Binius in the binary-field proof system landscape.

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

**Production readiness:** Production
Deployed in Plonky3 and StarkWare's Stwo prover. Powers lookup arguments in SP1 and Polygon CDK v2.

**Implementations:**
- [Plonky3 (LogUp-GKR)](https://github.com/Plonky3/Plonky3) ⭐ 772 — Rust — LogUp-GKR lookup backend
- [Stwo (LogUp-GKR)](https://github.com/starkware-libs/stwo) ⭐ 481 — Rust — StarkWare's Circle STARK prover with LogUp-GKR

**Security status:** Secure
Security inherits from GKR sumcheck soundness and LogUp's logarithmic derivative reduction. No known attacks.

**Community acceptance:** Widely trusted
Adopted by StarkWare and Succinct Labs as the default lookup mechanism. Supersedes Plookup in modern small-field proof systems.

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

**Production readiness:** Production
The most widely deployed ZK toolchain. Powers Tornado Cash, Semaphore, Dark Forest, zk-Email, and hundreds of other applications.

**Implementations:**
- [circom](https://github.com/iden3/circom) ⭐ 1.6k — Rust — circuit compiler
- [snarkjs](https://github.com/iden3/snarkjs) ⭐ 2.0k — JavaScript — Groth16/PLONK/Fflonk prover/verifier
- [circomlib](https://github.com/iden3/circomlib) ⭐ 735 — Circom — standard circuit library (Poseidon, ECDSA, Merkle)

**Security status:** Caution
Underlying proof systems (Groth16, PLONK) are secure. However, Circom's low-level circuit writing is error-prone; underconstrained circuit bugs are a known class of vulnerabilities.

**Community acceptance:** Widely trusted
De facto standard for ZK application development since 2020. Maintained by iden3/Polygon. Massive ecosystem of templates and tools.

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

**Production readiness:** Production
Cairo 1.0 powers all StarkNet smart contracts (mainnet 2023). Leo is deployed on Aleo mainnet. Noir is in rapid development for Aztec.

**Implementations:**
- [Noir](https://github.com/noir-lang/noir) ⭐ 1.3k — Rust — ZK DSL with ACIR backend (Aztec)
- [Leo](https://github.com/ProvableHQ/leo) ⭐ 4.8k — Rust — ZK DSL for Aleo blockchain
- [Cairo](https://github.com/starkware-libs/cairo) ⭐ 1.9k — Rust — ZK DSL for StarkNet

**Security status:** Caution
Language-level security depends on compiler correctness. Cairo's Sierra IR provides provable safety guarantees. Noir and Leo are still maturing with ongoing audits.

**Community acceptance:** Emerging
Cairo is the standard for StarkNet. Leo is standard for Aleo. Noir is growing rapidly in the Aztec ecosystem. No cross-ecosystem standardization yet.

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

**Production readiness:** Research
Academic research compiler (USENIX Security 2022). Used for research and prototyping; production compilers adopt similar IR strategies.

**Implementations:**
- [CirC](https://github.com/circify/circ) ⭐ 313 — Rust — multi-backend ZK/MPC compiler
- [ZoKrates](https://github.com/Zokrates/ZoKrates) ⭐ 1.9k — Rust — high-level ZK language and toolbox

**Security status:** Caution
CirC research revealed underconstrained circuit bugs as a vulnerability class. The compiler itself is research-grade and not audited for production use.

**Community acceptance:** Niche
Published at USENIX Security 2022. Influential in ZK compiler research. ZoKrates has broader adoption but is being superseded by Noir and Circom.

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

**Production readiness:** Mature
Reference implementation by Microsoft Research with competitive benchmarks. Core ideas power HyperNova, Jolt, and other production systems.

**Implementations:**
- [Spartan (Microsoft)](https://github.com/microsoft/Spartan) ⭐ 849 — Rust — original Spartan implementation
- [Spartan2 (Microsoft)](https://github.com/microsoft/Spartan2) ⭐ 129 — Rust — updated Spartan with improved API

**Security status:** Secure
Transparent; no trusted setup. Provably secure under the discrete logarithm assumption (with Hyrax PCS) or hash-based assumptions (with Brakedown PCS).

**Community acceptance:** Widely trusted
CRYPTO 2020. Developed by Microsoft Research (Srinath Setty). Foundational reference for sumcheck-based SNARKs. Widely cited and extended.

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

**Production readiness:** Production
Marlin is deployed in the Aleo blockchain (mainnet). Leo language compiles to Marlin R1CS.

**Implementations:**
- [arkworks-marlin](https://github.com/arkworks-rs/marlin) ⭐ 323 — Rust — Marlin implementation in arkworks
- [Aleo (snarkVM)](https://github.com/ProvableHQ/snarkVM) ⭐ 1.2k — Rust — Marlin-based VM for Aleo blockchain

**Security status:** Secure
Universal updatable SRS under 1-of-N trust assumption. Provably secure under the algebraic group model. No known attacks.

**Community acceptance:** Standard
EUROCRYPT 2020. Deployed in Aleo. The AHP framework is a standard reference for universal SNARK design alongside PLONK.

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

**Production readiness:** Production
Deployed in Monero (2018 hard fork), Liquid Network, and Grin/MimbleWimble. Widely used for confidential transaction range proofs.

**Implementations:**
- [dalek-bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust — Bulletproofs library
- [secp256k1-zkp](https://github.com/ElementsProject/secp256k1-zkp) ⭐ 419 — C — Bulletproofs for Liquid Network/Elements
- [monero (Bulletproofs)](https://github.com/monero-project/monero) ⭐ 10k — C++ — Monero's Bulletproofs integration

**Security status:** Secure
Secure under the discrete logarithm assumption. No trusted setup. Bulletproofs+ (2020) improves prover efficiency. No known attacks.

**Community acceptance:** Standard
IEEE S&P 2018. Deployed in major privacy cryptocurrencies. Endorsed by leading cryptographers (Bunz, Boneh, Poelstra, Maxwell).

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

**Production readiness:** Production
AIR + FRI is the arithmetization powering StarkNet, RISC Zero, SP1, and all production STARK systems.

**Implementations:**
- [ethSTARK](https://github.com/starkware-libs/ethSTARK) ⭐ 236 — C++ — StarkWare STARK reference
- [winterfell](https://github.com/facebook/winterfell) ⭐ 888 — Rust — Meta/Polygon STARK library
- [Stwo](https://github.com/starkware-libs/stwo) ⭐ 481 — Rust — StarkWare's Circle STARK prover
- [risc0](https://github.com/risc0/risc0) ⭐ 2.1k — Rust — RISC Zero STARK prover
- [ministark](https://github.com/andrewmilson/ministark) ⭐ 377 — Rust — minimal educational STARK implementation

**Security status:** Secure
Transparent and plausibly post-quantum. Security relies on collision-resistant hashing. DEEP-FRI provides strong per-round soundness. No known attacks.

**Community acceptance:** Standard
IACR 2018. STARKs are the dominant transparent proof system. Endorsed by StarkWare, Ethereum Foundation, and the broader ZK research community.

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

**Production readiness:** Experimental
QuickSilver and Wolverine have working implementations with competitive benchmarks. Used in privacy-preserving computation research.

**Implementations:**
- [EMP-toolkit (VOLE-ZK)](https://github.com/emp-toolkit/emp-zk) ⭐ 106 — C++ — VOLE-based ZK proof library
- [swanky (Mac'n'Cheese)](https://github.com/GaloisInc/swanky) ⭐ 344 — Rust — Galois MPC toolkit including Mac'n'Cheese

**Security status:** Secure
Information-theoretically secure MAC-based approach. Amortized O(1) cost per gate with formal security proofs. No known attacks.

**Community acceptance:** Emerging
Published at CCS 2021 and CRYPTO 2021. Growing recognition as the most efficient interactive ZK paradigm. Endorsed by researchers at Virginia Tech, Aarhus, and Bar-Ilan.

---

## ZK Proofs for Regulatory Compliance (zkKYC / zkAML)

**Goal:** Satisfy regulatory obligations (Know-Your-Customer, Anti-Money-Laundering) without exposing raw personal data. A user proves to a verifier — an exchange, a regulator, or a smart contract — that they satisfy a compliance predicate (e.g., "I am not on a sanctions list", "my income is above threshold X") using a ZK proof over a credential issued by a trusted authority, without revealing the underlying personal information.

| Scheme / System | Year | Basis | Note |
|-----------------|------|-------|------|
| **zkKYC (Sealance / Polygon ID)** | 2022 | Groth16 + W3C VCs | Prove KYC status from a signed credential; on-chain verifier; no personal data on chain [[1]](https://polygon.technology/blog/polygon-id-privacy-first-on-chain-identity) |
| **KILT / SocialKYC** | 2022 | KILT credentials + ZK | Selective disclosure of attested credentials; privacy-preserving identity on Polkadot [[1]](https://www.kilt.io/) |
| **zkAML (Chainalysis / Elliptic proposals)** | 2023 | Set-membership proofs | Prove address is not in a sanctions/AML set without revealing the address; membership/non-membership via ZK accumulators [[1]](https://eprint.iacr.org/2023/1173) |
| **Semaphore (rate-limited nullifiers)** | 2021 | Groth16 + Merkle tree | Anonymous signaling: prove group membership without linking actions; used in zkKYC pipelines [[1]](https://semaphore.pse.dev/) |
| **Holonym** | 2023 | Groth16 / Halo2 | ZK proof of KYC attributes (country, uniqueness) from government-issued ID via MPC-TLS; on-chain verify [[1]](https://holonym.id/) |

**Protocol structure:** A trusted identity provider (government registry, KYC bureau) issues a signed credential attesting to personal attributes. The user generates a ZK proof that (a) the credential was signed by the trusted issuer, and (b) their attributes satisfy the compliance predicate — without revealing the credential or any other attribute. On-chain or off-chain verifiers accept the proof without seeing any personal data.

**Privacy properties:** Credential hiding (verifier learns only the predicate output), issuer unlinkability (multiple proofs from the same credential are unlinkable if nullifiers are used correctly), and regulatory auditability (issuer or regulator can optionally open a viewing key for enforcement).

**Open challenges:** Multi-jurisdiction compliance (different regulatory predicates per country), credential revocation (ZK proofs of non-revocation without leaking revocation status), and sybil resistance (preventing one person from generating many ZK identities).

**State of the art:** Polygon ID (2022) and Holonym (2023) are production systems; zkAML accumulator proposals are academic (2023). The field is converging on W3C Verifiable Credentials as the credential format and Groth16/PLONK as the proof backend. See [Anonymous Credentials](categories/11-anonymity-credentials.md#anonymous-credentials), [ZK Proofs for Identity](#zk-proofs-for-identity-proof-of-age--nationality).

**Production readiness:** Experimental
Polygon ID and Holonym are in production. zkAML accumulator schemes are academic. Active pilots with financial institutions.

**Implementations:**
- [Polygon ID](https://github.com/0xPolygonID) — Go/JS — privacy-preserving identity framework
- [Semaphore](https://github.com/semaphore-protocol/semaphore) ⭐ 1.1k — TypeScript/Circom — anonymous signaling for group membership
- [Holonym](https://github.com/holonym-foundation) — TypeScript/Circom — ZK identity proofs from government IDs

**Security status:** Caution
Underlying ZK proofs (Groth16/PLONK) are secure. Credential issuance and revocation introduce trust assumptions on identity providers. Privacy depends on correct nullifier usage.

**Community acceptance:** Emerging
Growing regulatory interest (EU eIDAS 2.0, MiCA). Polygon ID is the most deployed system. Active collaboration between crypto projects and compliance firms.

---

## ZK Proofs for Identity (Proof of Age / Nationality)

**Goal:** Selectively prove identity attributes — age, nationality, uniqueness — derived from government-issued documents (passports, national IDs, driver's licenses) without revealing the underlying document or any unneeded fields. Enables privacy-preserving access control: a bar proves a patron is over 18, a DeFi protocol proves a user is not a sanctioned national, a social platform proves uniqueness — all without a centralised identity database.

| Scheme / System | Year | Basis | Note |
|-----------------|------|-------|------|
| **zk-SNARK passport proofs (anon-aadhaar)** | 2023 | Groth16 / RSA | Prove attributes from Indian Aadhaar QR (RSA-signed); age, state, gender; on-chain verifiable; PSE project [[1]](https://github.com/privacy-scaling-explorations/anon-aadhaar) |
| **OpenPassport / zkPassport** | 2023 | Groth16 + ECDSA/RSA | Prove e-passport ICAO 9303 attributes (nationality, age, uniqueness) using the chip's active authentication signature [[1]](https://github.com/zk-passport/openpassport) |
| **World ID (Worldcoin)** | 2023 | Groth16 + Semaphore | Proof of personhood via iris biometric; ZK uniqueness proof; on-chain nullifiers [[1]](https://docs.world.org/world-id/concepts) |
| **Proof of Passport (0xPARC)** | 2023 | Circom + Groth16 | ICAO passport chip data → ZK circuit; discloses only derived attributes (age bracket, nationality code) [[1]](https://github.com/0xPARC/zk-email) |
| **zk-Email (DKIM-based identity)** | 2023 | Groth16 + DKIM RSA | Prove email domain ownership (and thus institutional affiliation) without revealing email body [[1]](https://prove.email/) |

**Technical foundation:** Modern e-passports (ICAO 9303) store personal data in a chip that signs its contents under an issuing-country key (Document Signer Certificate). The prover reads the chip via NFC, obtains the signed data structure, and generates a ZK circuit that (a) verifies the RSA/ECDSA signature against the known country certificate, and (b) evaluates the disclosure predicate on the plaintext fields. The proof attests to the predicate without revealing the raw passport data. The circuit must implement RSA-2048 or ECDSA verification in-circuit — typically 1–3 million R1CS constraints.

**Linkability and nullifiers:** A critical design issue is preventing the same passport from generating multiple "unique" proofs (sybil attack). Worldcoin uses iris biometrics; passport-based systems use commitment schemes keyed on the passport number (hashed under a nullifier scheme) to detect duplicates without revealing the number itself.

**State of the art:** OpenPassport / zkPassport (2023) and anon-aadhaar (2023) are open-source production systems. World ID (Worldcoin) is deployed at scale. Active research on reducing circuit size (RSA in-circuit is expensive) via precompile support in zkVMs (SP1, RISC Zero). See [zkKYC / zkAML](#zk-proofs-for-regulatory-compliance-zkkyc--zkaml), [zkTLS / MPC-TLS](#zktls--mpc-tls).

**Production readiness:** Experimental
OpenPassport, anon-aadhaar, and World ID are open-source and actively used. Passport verification circuits are complex (RSA in-circuit) but functional.

**Implementations:**
- [OpenPassport](https://github.com/zk-passport/openpassport) ⭐ 1.2k — TypeScript/Circom — e-passport attribute proofs
- [anon-aadhaar](https://github.com/privacy-scaling-explorations/anon-aadhaar) ⭐ 244 — TypeScript/Circom — Aadhaar identity proofs (PSE)
- [worldcoin](https://github.com/worldcoin/semaphore-rs) ⭐ 187 — Rust — World ID Semaphore implementation

**Security status:** Caution
ZK proofs are sound, but passport chip authentication has known limitations (cloned chips, expired certificates). Sybil resistance depends on nullifier design.

**Community acceptance:** Emerging
Growing adoption. World ID has millions of users. PSE (Ethereum Foundation) backs anon-aadhaar. Active research on reducing RSA in-circuit costs.

---

## ZK Proofs for Supply Chain (Proof of Origin / Provenance)

**Goal:** Prove properties of a product's supply chain — country of origin, certification compliance, ethical sourcing — without revealing commercially sensitive supplier relationships. A manufacturer proves to a retailer or regulator that its product satisfies a sourcing predicate (e.g., "all components are from GDPR-compliant jurisdictions", "no conflict minerals") without disclosing which specific suppliers were used.

| Scheme / System | Year | Basis | Note |
|-----------------|------|-------|------|
| **zkSC (ZK Supply Chain, MIT / BCG)** | 2022 | Groth16 + Merkle supply tree | Prove product properties from a Merkle tree of signed supplier attestations; verifier sees only the root + ZK proof [[1]](https://eprint.iacr.org/2022/1065) |
| **Healy-Rayo-Troncoso supply chain ZK** | 2023 | Polynomial commitments + set membership | Prove aggregate properties (sum, threshold) over a hidden supplier set; UC-secure [[1]](https://eprint.iacr.org/2023/1060) |
| **ZK for ESG / carbon footprint** | 2023 | PLONK + range proofs | Prove carbon emissions below a threshold without revealing production process details; Baseline Protocol extension [[1]](https://docs.baseline-protocol.org/) |
| **Trade finance ZK (ING / Commerzbank)** | 2022 | Bulletproofs | ZK range proofs for letter-of-credit conditions (price, quantity bounds) without revealing exact contract terms [[1]](https://github.com/ing-bank/zkrp) |

**Protocol structure:** Each supplier holds a digitally signed attestation from a certifying authority (e.g., a customs body, an auditor). Attestations are organised as a Merkle tree keyed by product serial numbers. A manufacturer holding paths through this tree generates a ZK proof that all attested attributes satisfy the required predicate — with the Merkle root as the only public information. Verifiers check the proof without seeing any supplier identity.

**Key challenges:** Multi-hop provenance (proving properties of components whose suppliers are themselves composed of sub-suppliers), revocation of certifications without leaking which supplier was revoked, and cross-border regulatory interoperability (different standards per jurisdiction).

**Relation to other primitives:** Proof-of-origin circuits rely on [ZK Sets](#zero-knowledge-sets) for hidden supplier membership, [Accumulators](categories/09-commitments-verifiability.md#accumulators) for revocation, and [Merkle-based ZK Proofs](#zero-knowledge-proofs-zk) for commitment to supply trees. Multi-party supply chains can use [Distributed SNARKs](#distributed--collaborative-snarks) to avoid any single party assembling all supplier data.

**State of the art:** Primarily academic and pilot deployments (2022–2024); no dominant production system yet. ING's zero-knowledge range proof library (Bulletproofs) is open-source. The EU's Digital Product Passport regulation (2024) is driving commercial interest. See [ZK Proofs for Regulatory Compliance](#zk-proofs-for-regulatory-compliance-zkkyc--zkaml).

**Production readiness:** Research
Primarily academic and pilot deployments. ING's zkrp library is open-source. No dominant production system yet.

**Implementations:**
- [Baseline Protocol](https://github.com/eea-oasis/baseline) ⭐ 574 — TypeScript — enterprise ZK coordination protocol

**Security status:** Secure
Underlying ZK proofs (Bulletproofs, PLONK) are secure. Supply chain attestation security depends on the trust model for certifying authorities.

**Community acceptance:** Niche
Academic research with growing enterprise interest. EU Digital Product Passport regulation (2024) is driving commercial development. ING and Commerzbank have published pilot results.

---

## IVC vs. PCD vs. Accumulation Schemes (Recursive Composition Taxonomy)

**Goal:** Understand the landscape of recursive proof composition. Three related but distinct paradigms — Incrementally Verifiable Computation (IVC), Proof-Carrying Data (PCD), and Accumulation Schemes — capture different flavors of "a proof about proofs". Each targets a different computational model (sequential, DAG-shaped, or deferred verification) and has a different efficiency profile.

| Paradigm | Model | Introduced | Key Property | Representative Systems |
|----------|-------|------------|--------------|------------------------|
| **IVC (Incrementally Verifiable Computation)** | Sequential chain | Valiant 2008 | Each step produces a proof that all prior steps were correct; chain of proofs | Nova, SuperNova, Nexus zkVM [[1]](https://eprint.iacr.org/2008/140) |
| **PCD (Proof-Carrying Data)** | DAG / distributed | Chiesa-Tromer 2010 | Any node in a computation DAG can verify all ancestor nodes; generalises IVC to branching | Halo/Pickles (Mina), recursive SNARKs on cycle of curves [[1]](https://eprint.iacr.org/2010/174) |
| **Accumulation Schemes** | Deferred batch check | Bünz-Chiesa-Mishra-Spooner 2020 | Instead of verifying a proof immediately, accumulate a sequence of proofs into one check deferred to the end; avoids nested recursion cost | Halo accumulation, ProtoStar, ProtoGalaxy [[1]](https://eprint.iacr.org/2020/499) |
| **Folding Schemes** | Sequential (IVC-style) | Kothapalli-Setty-Tzialla 2022 | Fold two instances of the same relation into one without a proof; cheaper than SNARK-in-SNARK recursion | Nova, HyperNova, Sangria, Arecibo [[1]](https://eprint.iacr.org/2021/370) |

**IVC in depth:** An IVC scheme for a function F produces, after n steps, a proof πₙ that F was applied correctly n times starting from z₀. The verifier checks only πₙ — not all intermediate proofs. IVC requires the proof system to recursively verify its own proofs. Nova achieves IVC via *folding* rather than proof-in-proof recursion: it folds two R1CS instances into one of the same size, deferring all IOP checks to the end.

**PCD in depth:** PCD generalises IVC to arbitrary directed acyclic graphs: each node v in the graph receives proofs from its predecessor nodes, verifies them, performs local computation, and outputs a new proof. This captures distributed protocols, blockchain light clients, and cross-chain bridges. Practical PCD requires either cycles of elliptic curves (Mina uses Pasta + Pickles) or folding-based IVC extended to branching structures (SuperNova).

**Accumulation in depth:** An accumulation scheme replaces the expensive verifier inside a recursive SNARK with an *accumulator update* step. Multiple proofs π₁, …, πₙ are accumulated into a single accumulator acc; only at the very end does the verifier "decide" the accumulator. This reduces the per-step recursion cost from O(verifier time) to O(accumulator update time), which can be sublinear. Halo's deferred IPA verification is the prototypical example.

**Comparison:**
- IVC: cheapest when computation is sequential; Nova/SuperNova dominate.
- PCD: needed for branching/distributed computation; higher overhead.
- Accumulation: best when many proofs must be aggregated offline before a single on-chain check.
- Folding: a technique used to implement IVC efficiently; not a separate end-user primitive.

**State of the art:** Nova (2022) for IVC; Pickles/Kimchi (Mina, 2021) for PCD; Halo/ProtoStar/ProtoGalaxy for accumulation. See [Folding Schemes](#folding-schemes), [Proof-Carrying Data](#proof-carrying-data-pcd), [Halo and Halo2](#halo-and-halo2).

**Production readiness:** Experimental
IVC (Nova) and PCD (Pickles/Mina) are in production. Accumulation schemes (ProtoStar, ProtoGalaxy) are in active research/development.

**Implementations:**
- [Nova (Microsoft)](https://github.com/microsoft/Nova) ⭐ 837 — Rust — IVC via folding
- [Mina/Pickles](https://github.com/MinaProtocol/mina) ⭐ 2.1k — OCaml — PCD for constant-size blockchain
- [sonobe](https://github.com/privacy-scaling-explorations/sonobe) ⭐ 265 — Rust — modular IVC/folding library

**Security status:** Secure
Each paradigm has formal security proofs. IVC (Nova) under DL assumption. PCD requires cycle-of-curves security. Accumulation under knowledge assumptions.

**Community acceptance:** Widely trusted
Foundational taxonomy established by Valiant (2008), Chiesa-Tromer (2010), and BCMS (2020). Universally accepted framework in the ZK research community.

---

## Sangria, Arecibo, and Sonobe (Folding Ecosystem)

**Goal:** Extend and implement the folding paradigm beyond Nova's original R1CS setting. Sangria adapts folding to PLONK-style (relaxed PLONK) constraint systems; Arecibo is an earlier multi-circuit IVC system exploring non-uniform computation before SuperNova; Sonobe is an open-source library providing modular folding backends (Nova, HyperNova, ProtoGalaxy) for application developers.

| Scheme / Library | Year | Basis | Note |
|-----------------|------|-------|------|
| **Sangria** | 2023 | Relaxed PLONK + folding | Adapts Nova's folding to PLONKish (custom gates) constraint systems via a "relaxed PLONK" relation; enables folding for PLONK-based circuits [[1]](https://github.com/geometryresearch/sangria/blob/main/docs/sangria_folding_plonk.pdf) |
| **Arecibo** | 2022 | Multi-circuit Nova variant | Non-uniform IVC before SuperNova; supports a fixed finite set of circuits at each step; prototype of the SuperNova idea [[1]](https://github.com/argumentcomputer/arecibo) |
| **Sonobe** | 2024 | Nova / HyperNova / ProtoGalaxy library | Modular Rust library for IVC; pluggable folding backends; integrates with Circom, Noir, and Halo2 frontends; open-source by 0xPARC / PSE [[1]](https://github.com/privacy-scaling-explorations/sonobe) |
| **CycleFold** | 2023 | Curve-cycle folding optimization | Reduces the scalar-multiplication verification in Nova to a single small secondary circuit on a second curve; used in Nexus, Sonobe, and SP1 aggregation [[1]](https://eprint.iacr.org/2023/1192) |
| **ProtoGalaxy** | 2023 | High-arity accumulation | Generalises ProtoStar to fold many instances at once (k-arity folding); logarithmic prover overhead in k; closer to Sangria in using PLONK-style relations [[1]](https://eprint.iacr.org/2023/1106) |

**Sangria:** Nova's relaxed R1CS relation (where the constraint Az ∘ Bz = u · Cz + E includes an error term E and a scaling factor u) does not directly accommodate PLONK's custom gate structure. Sangria defines a *relaxed PLONK* relation by adding analogous error terms to PLONK's gate and permutation polynomials, then derives folding equations for each. This makes folding-based IVC available to the large ecosystem of PLONK circuit tooling (Halo2, UltraPlonk).

**Arecibo:** Developed as a multi-circuit extension of Nova before SuperNova's publication, Arecibo demonstrated that different circuits could be executed at different IVC steps by selecting among a finite set of "augmented" circuits. The codebase later became the reference implementation for SuperNova's paper.

**Sonobe:** Provides a clean API: developers write circuits in Circom or Halo2, choose a folding scheme backend (Nova, HyperNova, ProtoGalaxy), and get IVC proofs with final SNARK compression (Groth16 or PLONK). Sonobe handles CycleFold integration and the decider SNARK automatically. It is the primary practical entry point for folding-based ZK development (2024).

**CycleFold:** A key optimization: in Nova, the folding verifier must compute a scalar multiplication on the primary curve. Encoding this check as a *secondary circuit* on a different curve (forming a two-curve cycle, e.g., BN254 / Grumpkin) keeps each primary circuit small. CycleFold formalizes this two-curve trick and reduces the secondary circuit to a minimal single multi-scalar multiplication, used in Nexus zkVM and Sonobe.

**State of the art:** Sangria (2023, geometry research), Sonobe (2024, PSE / 0xPARC), CycleFold (2023, Aztec). These tools form the practical infrastructure for the [Folding Schemes](#folding-schemes) research programme. See [IVC vs. PCD vs. Accumulation Schemes](#ivc-vs-pcd-vs-accumulation-schemes-recursive-composition-taxonomy), [General-Purpose zkVMs](#general-purpose-zkvms).

**Production readiness:** Experimental
Sonobe (2024) provides a practical entry point for folding-based ZK. CycleFold is used in Nexus zkVM. Sangria and Arecibo are research prototypes.

**Implementations:**
- [sonobe](https://github.com/privacy-scaling-explorations/sonobe) ⭐ 265 — Rust — modular folding library (Nova, HyperNova, ProtoGalaxy)
- [arecibo](https://github.com/argumentcomputer/arecibo) ⭐ 89 — Rust — SuperNova implementation
- [CycleFold](https://github.com/nexus-xyz/nexus-zkvm) ⭐ 2.6k — Rust — CycleFold integrated in Nexus zkVM

**Security status:** Secure
Folding schemes have formal security proofs under DL assumptions. CycleFold's two-curve trick is provably secure on curve cycles (Pallas/Vesta, BN254/Grumpkin).

**Community acceptance:** Emerging
Active development by PSE (Ethereum Foundation), 0xPARC, and Geometry Research. Sonobe is the primary practical tool for folding-based ZK development.

---

## Gemini (Elastic SNARKs)

**Goal:** Enable a single SNARK prover to operate in both time-efficient and space-efficient modes, allowing proof generation on resource-constrained devices or for extremely large circuits.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Gemini** | 2022 | Univariate PCS + R1CS | Elastic SNARK: linear-time prover (time mode) or log-memory prover (space mode); FFT-free; scales to tens of billions of constraints [[1]](https://eprint.iacr.org/2022/420) |

**State of the art:** Gemini (EUROCRYPT 2022) is the first elastic SNARK, demonstrating practical proof generation for circuits with 2^{34}+ constraints on a single machine. Its space-efficient mode enables proving on memory-limited hardware. See [Spartan](#spartan-transparent-r1cs-snark-via-sumcheck), [Orion and Brakedown](#orion-and-brakedown-linear-time-snarks).

**Production readiness:** Experimental
Reference implementation demonstrates proof generation for circuits with 2^34+ constraints. Not yet widely deployed in production.

**Implementations:**
- [arkworks-gemini](https://github.com/arkworks-rs/gemini) ⭐ 85 — Rust — Gemini elastic SNARK implementation

**Security status:** Secure
Provably secure; no trusted setup. FFT-free design. Formal proofs at EUROCRYPT 2022. No known attacks.

**Community acceptance:** Niche
EUROCRYPT 2022. Important for resource-constrained proving scenarios. Recognized by the arkworks community.

---

## Boojum (zkSync Era Proof System)

**Goal:** Production STARK-based proof system optimized for consumer-grade GPU hardware, enabling decentralized proving for zkEVM rollups.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Boojum** | 2023 | STARK + PLONK arithmetization | zkSync Era prover; runs on 16 GB GPU RAM (vs. prior 80 GB); STARK proofs wrapped into a pairing-based SNARK for on-chain verification [[1]](https://github.com/matter-labs/era-boojum) |
| **Boojum CUDA** | 2023 | GPU-accelerated backend | CUDA library for GPU-accelerated field arithmetic, NTT, and Poseidon hashing inside the Boojum prover [[1]](https://github.com/matter-labs/era-boojum-cuda) |

**State of the art:** Boojum (Matter Labs, 2023) powers zkSync Era mainnet. Its key innovation is reducing GPU memory requirements by ~5x compared to the prior SNARK-based system, enabling consumer hardware participation. See [zkEVM Taxonomy](#zkevm-taxonomy-and-ecosystem), [STARK Arithmetization](#stark-arithmetization-air-and-fri).

**Production readiness:** Production
Powers zkSync Era mainnet (live since 2023). Processes millions of transactions with STARK proofs wrapped in pairing-based SNARKs.

**Implementations:**
- [era-boojum](https://github.com/matter-labs/era-boojum) ⭐ 303 — Rust — Boojum proving system
- [era-boojum-cuda](https://github.com/matter-labs/era-boojum-cuda) ⭐ 25 — CUDA/Rust — GPU-accelerated Boojum backend

**Security status:** Caution
STARK backend is secure. Boojum wraps STARKs into pairing-based SNARKs for on-chain verification; the composition is sound but complex. Ongoing audits.

**Community acceptance:** Emerging
Developed by Matter Labs. Powers one of the largest Ethereum L2s (zkSync Era). Open-source but not independently audited to the level of Groth16/PLONK.

---

## LatticeFold (Post-Quantum Folding)

**Goal:** Bring folding-based IVC to post-quantum security by replacing discrete-log commitments with lattice-based commitments, enabling recursive SNARKs secure against quantum adversaries.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **LatticeFold** | 2024 | Module-SIS + sumcheck | First lattice-based folding scheme; supports R1CS and CCS; operates over 64-bit fields; performance comparable to HyperNova [[1]](https://eprint.iacr.org/2024/257) |
| **LatticeFold+** | 2025 | Module-SIS (improved) | Faster prover, simpler verification circuit, shorter folding proofs than LatticeFold [[1]](https://eprint.iacr.org/2025/247) |
| **Lova** | 2024 | Unstructured lattices | Folding from unstructured lattice assumptions (standard LWE/SIS); avoids module structure [[1]](https://link.springer.com/chapter/10.1007/978-981-96-0894-2_10) |

**State of the art:** LatticeFold (Boneh-Chen, 2024) is the first post-quantum folding scheme. LatticeFold+ (2025) improves all metrics. Lova (ASIACRYPT 2024) achieves folding from unstructured lattices. These are the only folding schemes plausibly secure against quantum computers. See [Folding Schemes](#folding-schemes), [Nova / SuperNova](#zero-knowledge-proofs-zk).

**Production readiness:** Research
Academic publications (2024-2025) with reference implementations. No production deployment yet. First post-quantum folding schemes.

**Implementations:**
- [latticefold (reference)](https://github.com/NethermindEth/latticefold) ⭐ 126 — Rust — LatticeFold reference implementation

**Security status:** Secure
Secure under Module-SIS (LatticeFold) and standard LWE/SIS (Lova) assumptions. Post-quantum secure. No known attacks.

**Community acceptance:** Emerging
Published by Dan Boneh and collaborators (2024). First post-quantum folding schemes. High interest from the PQ and ZK research communities.

---

## Expander (GKR-Based Proof System)

**Goal:** Fastest open-source ZK proof system combining the GKR interactive proof protocol with code-based polynomial commitments, targeting massively parallel computation.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Expander** | 2024 | GKR + expander-code PCS | Polyhedra Network; 4500 Keccak-f/s on M3 Max; 2.16M Poseidon hashes/s on Ryzen; no FFT; field-agnostic [[1]](https://github.com/PolyhedraZK/Expander) |
| **Expander-RS** | 2024 | Rust rewrite | Rust implementation; CUDA backend for GPU acceleration; used in zkBridge and zkPyTorch [[1]](https://blog.polyhedra.network/expander-rust-version-open-source/) |

**State of the art:** Expander (Polyhedra, 2024) claims the fastest single-machine ZK prover throughput, exceeding Stwo and Plonky3 on hash-function benchmarks. Powers zkBridge (cross-chain) and [zkML](#zkml-zero-knowledge-machine-learning) applications. Built on [Orion/Brakedown](#orion-and-brakedown-linear-time-snarks) PCS and the [GKR Protocol](#sumcheck-protocol).

**Production readiness:** Experimental
Open-source with competitive benchmarks. Powers zkBridge and zkPyTorch. Rapidly developing with CUDA support.

**Implementations:**
- [Expander](https://github.com/PolyhedraZK/Expander) ⭐ 145 — Rust — GKR-based proof system with CUDA support
- [ExpanderCompilerCollection](https://github.com/PolyhedraZK/ExpanderCompilerCollection) ⭐ 42 — Rust — compiler frontend for Expander

**Security status:** Secure
Based on GKR sumcheck (information-theoretically secure) and expander-code PCS. Transparent; no trusted setup. No known attacks.

**Community acceptance:** Emerging
Developed by Polyhedra Network. Claims fastest single-machine prover. Growing adoption in zkBridge and zkML applications.

---

## Libra and Virgo (GKR-Based Transparent SNARKs)

**Goal:** Turn the GKR interactive proof into a practical zero-knowledge SNARK with optimal (linear) prover time, no trusted setup, and post-quantum security.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Libra** | 2019 | GKR + zkVPD | First ZK argument with optimal O(C) prover time for layered circuits; one-time setup depends only on input size, not circuit [[1]](https://eprint.iacr.org/2019/317) |
| **Virgo** | 2020 | GKR + transparent PCS | Transparent (no trusted setup); O(C + n log n) prover; O(d log C + log^2 n) proof size; post-quantum via hash-based PCS [[1]](https://eprint.iacr.org/2019/1482) |
| **Virgo++** | 2021 | GKR + data-parallel circuits | Extends Virgo to data-parallel circuits; reduces prover cost for repeated sub-circuits [[1]](https://eprint.iacr.org/2020/1247) |

**State of the art:** Libra (CRYPTO 2019) and Virgo (S&P 2020) established GKR-based SNARKs as practical. Their ideas underpin [Expander](#expander-gkr-based-proof-system), [Ceno](#ceno-non-uniform-gkr-zkvm), and the GKR backend in [Plonky3](#binary-field-proof-systems). See [Sumcheck Protocol](#sumcheck-protocol), [Orion and Brakedown](#orion-and-brakedown-linear-time-snarks).

**Production readiness:** Mature
Reference implementations with academic benchmarks. Ideas underpin production systems (Expander, Ceno, Plonky3 GKR backend).

**Implementations:**
- [Virgo](https://github.com/sunblaze-ucb/Virgo) ⭐ 61 — C++ — transparent GKR-based SNARK
- [Libra](https://github.com/sunblaze-ucb/Libra) ⭐ 55 — C++ — optimal-prover GKR SNARK

**Security status:** Secure
Virgo is transparent and plausibly post-quantum (hash-based PCS). Libra uses a one-time trusted setup for the PCS. Both are formally proven secure.

**Community acceptance:** Widely trusted
Published at CRYPTO 2019 (Libra) and IEEE S&P 2020 (Virgo). Developed by Yupeng Zhang's group. Foundational references for GKR-based SNARK design.

---

## Ceno (Non-Uniform GKR zkVM)

**Goal:** Build a zkVM using the GKR protocol with non-uniform, segmented, and parallel proving, achieving faster prover times than Plonkish-based zkVMs by committing only to circuit inputs and outputs.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Ceno** | 2024 | GKR + segment-parallel proving | Scroll/Missouri S&T; segments execution trace, proves identical segments via data-parallel circuits; asymmetric GKR (non-uniform prover, uniform verifier) [[1]](https://eprint.iacr.org/2024/387) |

**State of the art:** Ceno (Journal of Cryptology, 2024) demonstrates that GKR-based zkVMs can significantly reduce commitment costs versus Plonkish approaches, since the prover commits only to inputs/outputs rather than all intermediate witnesses. Used by Scroll for next-generation proving. See [General-Purpose zkVMs](#general-purpose-zkvms), [Sumcheck Protocol](#sumcheck-protocol).

**Production readiness:** Experimental
Research prototype developed by Scroll and Missouri S&T. Used by Scroll for next-generation proving research.

**Implementations:**
- [ceno](https://github.com/scroll-tech/ceno) ⭐ 140 — Rust — GKR-based zkVM (Scroll)

**Security status:** Secure
Based on GKR sumcheck with formal security proofs. Segment-parallel proving preserves soundness. No known attacks.

**Community acceptance:** Emerging
Published in Journal of Cryptology 2024. Backed by Scroll (major Ethereum L2). Demonstrates GKR advantages over Plonkish for zkVM design.

---

## BaseFold (Field-Agnostic Polynomial Commitments)

**Goal:** Provide efficient multilinear polynomial commitment schemes that work over any sufficiently large finite field, removing the restriction to FFT-friendly fields required by FRI.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **BaseFold** | 2024 | Random foldable codes | Field-agnostic PCS for multilinear polynomials; O(n log n) prover, O(log^2 n) verifier; extends FRI's folding idea to non-FFT fields [[1]](https://eprint.iacr.org/2023/1705) |
| **DeepFold** | 2024 | Reed-Solomon + multilinear | Maintains BaseFold's prover efficiency while improving concrete proof size for Reed-Solomon instantiations [[1]](https://eprint.iacr.org/2024/1595) |

**State of the art:** BaseFold (CRYPTO 2024) enables STARK-like proofs over arbitrary fields (e.g., binary fields, small primes without FFT roots). Complements [Binius](#binary-field-proof-systems) and [Brakedown](#orion-and-brakedown-linear-time-snarks) as a field-agnostic PCS. DeepFold (2024) refines the Reed-Solomon instantiation.

**Production readiness:** Research
Published at CRYPTO 2024 with reference implementation. Not yet integrated into production proof systems.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Provably secure under standard coding-theoretic assumptions. Field-agnostic design removes FFT-friendly field restrictions. No known attacks.

**Community acceptance:** Emerging
CRYPTO 2024. Addresses a fundamental limitation of FRI (field restriction). Growing interest as a PCS for arbitrary-field proof systems.

---

## Zeromorph (Multilinear KZG Evaluation Proofs)

**Goal:** Efficiently prove evaluations of multilinear polynomials committed via univariate KZG, with minimal overhead to achieve zero-knowledge.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Zeromorph** | 2023 | KZG (univariate-to-multilinear) | ZK multilinear evaluation proof with only n+5 extra G1 ops for ZK (vs. 2^n in prior work); generic over any homomorphic univariate PCS [[1]](https://eprint.iacr.org/2023/917) |

**State of the art:** Zeromorph (Journal of Cryptology, 2024) bridges the gap between univariate KZG (widely deployed, efficient) and multilinear polynomials (used in sumcheck-based SNARKs). Enables multilinear proof systems to reuse existing KZG trusted setups. See [Sumcheck Protocol](#sumcheck-protocol), [PLONK](#zero-knowledge-proofs-zk).

**Production readiness:** Experimental
Reference implementation exists. Enables multilinear proof systems to reuse existing KZG trusted setups.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Provably secure under the same assumptions as KZG (algebraic group model). Adds only n+5 G1 operations for zero-knowledge. No known attacks.

**Community acceptance:** Emerging
Journal of Cryptology 2024. Bridges univariate KZG and multilinear proof systems. Growing interest for sumcheck-based SNARKs using existing trusted setups.

---

## Kimchi (Mina Protocol Proof System)

**Goal:** Recursive zero-knowledge proof system powering the Mina blockchain's constant-size (~22 KB) chain state, extending PLONK with custom gates, lookups, and recursive composition via the Pickles framework.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **Kimchi** | 2021 | PLONK variant + IPA | Mina/O1Labs; extends PLONK with 15 registers, custom gates, lookup tables; no trusted setup (IPA-based) [[1]](https://o1-labs.github.io/proof-systems/specs/kimchi.html) |
| **Pickles** | 2021 | Recursive composition layer | Wraps Kimchi proofs in a recursive proof-carrying-data (PCD) framework over Pasta curves (Pallas/Vesta); enables Mina's constant-size blockchain [[1]](https://minaprotocol.com/blog/kimchi-the-latest-update-to-minas-proof-system) |

**State of the art:** Kimchi + Pickles (Mina Berkeley upgrade, 2023) is the only production PCD-based blockchain, maintaining a ~22 KB chain proof regardless of history length. Recent work adds bn254 KZG proof output and optional folding support. See [Proof-Carrying Data](#proof-carrying-data-pcd), [Halo and Halo2](#halo-and-halo2).

**Production readiness:** Production
Deployed in Mina Protocol mainnet since the Berkeley upgrade (2023). Powers the only constant-size blockchain (~22 KB chain proof).

**Implementations:**
- [Kimchi](https://github.com/o1-labs/proof-systems) ⭐ 458 — Rust/OCaml — Kimchi proof system (O1 Labs)
- [Mina](https://github.com/MinaProtocol/mina) ⭐ 2.1k — OCaml — Mina Protocol with Pickles PCD framework

**Security status:** Secure
Based on PLONK with IPA (no trusted setup). Recursive composition via Pickles on Pasta curves is provably secure. No known attacks.

**Community acceptance:** Widely trusted
Production-validated since Mina mainnet (2021). Developed by O1 Labs. Endorsed by the Mina Foundation and ZK research community.

---

## SP1 Hypercube (Real-Time zkVM Proving)

**Goal:** Achieve real-time (sub-12-second) zero-knowledge proof generation for full Ethereum L1 blocks via GPU-parallelized STARK recursion, enabling practical ZK rollups without latency.

| Scheme | Year | Type/Basis | Note |
|--------|------|------------|------|
| **SP1 Hypercube** | 2025 | STARK + GPU cluster | Succinct Labs; proves 99.7% of L1 Ethereum blocks in <12s on 16x RTX 5090 GPUs; custom recursion VM; ~1000x faster than SP1 v1 [[1]](https://blog.succinct.xyz/real-time-proving-16-gpus/) |

**State of the art:** SP1 Hypercube (Succinct, 2025) crosses the real-time proving threshold for Ethereum blocks. Builds on [SP1](#general-purpose-zkvms) and [Plonky3](#plonky2) backend with massive GPU parallelism. Represents the current frontier of zkVM prover performance. See [General-Purpose zkVMs](#general-purpose-zkvms), [STARK Arithmetization](#stark-arithmetization-air-and-fri).

**Production readiness:** Experimental
Announced in 2025 with benchmark results (sub-12s for Ethereum L1 blocks). Requires 16x RTX 5090 GPUs. Not yet widely deployed.

**Implementations:**
- [SP1](https://github.com/succinctlabs/sp1) ⭐ 1.6k — Rust — SP1 zkVM (Hypercube builds on SP1 + Plonky3)

**Security status:** Secure
Inherits STARK/FRI security from Plonky3 backend. GPU parallelism does not affect cryptographic security. No known attacks on the proof system.

**Community acceptance:** Emerging
Developed by Succinct Labs (2025). Represents the frontier of zkVM prover performance. High interest from Ethereum L2 ecosystem for real-time proving.

---
