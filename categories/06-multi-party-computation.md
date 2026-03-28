# Multi-Party Computation

## Multi-Party Computation (MPC)

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

---

## Oblivious Transfer (OT)

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

---

## Garbled Circuits (expanded)

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

---

## Secure Aggregation (SecAgg)

**Goal:** Privacy-preserving summation. Multiple clients send encrypted inputs to a server, which learns only the aggregate (sum/average) — not individual contributions. Core primitive for federated learning.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bonawitz et al. (Google SecAgg)** | 2017 | Secret sharing + DH masking | Tolerates dropouts; used in Gboard federated learning [[1]](https://eprint.iacr.org/2017/281) |
| **Bell et al. (SecAgg+)** | 2020 | Sparse secret sharing | O(n log n) communication; improved scalability [[1]](https://eprint.iacr.org/2020/704) |
| **FLAME (LWE-based)** | 2023 | LWE | Post-quantum secure aggregation [[1]](https://eprint.iacr.org/2023/224) |
| **PAgIoT** | 2016 | Paillier + attributes | Privacy-preserving multi-attribute aggregation for IoT; lightweight for constrained devices [[1]](https://lgmanzan.github.io/docs/PagIoT.pdf) |

**State of the art:** SecAgg+ (Google/Apple production), FLAME (PQ setting), PAgIoT (IoT-optimized).

---

## Function Secret Sharing (FSS) / Distributed Point Functions (DPF)

**Goal:** Secret-share a function. Split a function f into shares f₀, f₁ such that each share reveals nothing, but f₀(x) + f₁(x) = f(x) for all x. Enables efficient PIR, anonymous messaging, private database queries with sublinear communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Distributed Point Function (GI14)** | 2014 | PRG tree | Secret-share a point function (1 at target, 0 elsewhere); O(λ log N) key size [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for intervals/comparison** | 2015 | DPF + prefix tree | Extend DPF to interval functions; private range queries [[1]](https://eprint.iacr.org/2018/707) |
| **FSS for decision trees** | 2021 | DPF composition | Secret-share a decision tree for private inference [[1]](https://eprint.iacr.org/2020/1392) |

**State of the art:** DPF (used in Brave/STAR, Google Privacy Sandbox), FSS for intervals (private analytics).

---

## Homomorphic Secret Sharing (HSS)

**Goal:** Non-interactive secure computation. Secret-share data and compute on shares locally (without interaction between servers), then reconstruct the result. Like MPC but without communication rounds during computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HSS for branching programs (BGI)** | 2016 | DDH / DCR | Evaluate branching programs on shares with no interaction [[1]](https://eprint.iacr.org/2015/084) |
| **HSS from LWE** | 2019 | LWE | Post-quantum HSS; more expressive function classes [[1]](https://eprint.iacr.org/2019/1318) |
| **HSS for NC1** | 2016 | Group actions | Evaluate any NC1 circuit on secret-shared data [[1]](https://eprint.iacr.org/2015/084) |

**State of the art:** DDH-based HSS (practical for simple functions), LWE-based (PQ, richer function classes).

---

## Oblivious Linear Evaluation (OLE) / VOLE

**Goal:** Arithmetic oblivious transfer. Sender holds (a, b), receiver holds x; receiver learns ax + b and nothing else, sender learns nothing. VOLE (Vector OLE) extends this to vectors. The arithmetic foundation of modern MPC over large fields.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gilboa OLE** | 1999 | OT extension | First efficient OLE from OT; basis of arithmetic MPC [[1]](https://doi.org/10.1007/3-540-48405-1_8) |
| **VOLE from LPN (Boyle et al.)** | 2019 | LPN + PCG | Generate massive VOLE correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **Wolverine** | 2021 | VOLE + ZK | ZK proofs from VOLE: efficient field arithmetic proofs [[1]](https://eprint.iacr.org/2020/925) |
| **QuickSilver** | 2021 | VOLE | Optimized VOLE-based ZK; practical for arithmetic circuits [[1]](https://eprint.iacr.org/2021/076) |

**State of the art:** PCG-based VOLE (Boyle et al. 2019+); foundation of SPDZ preprocessing (see [MPC](#multi-party-computation-mpc)) and VOLE-in-the-head ZK (see [Silent OT / PCG](#silent-ot--pseudorandom-correlation-generators-pcg)).

---

## Silent OT / Pseudorandom Correlation Generators (PCG)

**Goal:** Communication-efficient MPC setup. Generate enormous numbers of correlated random values (OT correlations, Beaver triples) from a short correlated seed — turning an O(n) communication task into O(n^ε) or O(polylog n).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Silent OT (BCGI+)** | 2019 | LPN | Generate millions of OT correlations from short seeds; sublinear communication [[1]](https://eprint.iacr.org/2019/1159) |
| **PCG for Beaver Triples** | 2020 | Ring-LPN | Extend PCG to multiplication triples for general MPC [[1]](https://eprint.iacr.org/2020/924) |
| **Silver (Couteau et al.)** | 2021 | LDPC + LPN | Optimized Silent OT with quasi-linear computation [[1]](https://eprint.iacr.org/2021/1150) |
| **VOLE-in-the-head (Baum et al.)** | 2023 | VOLE + PCG | Use PCG-based VOLE for efficient ZK proofs [[1]](https://eprint.iacr.org/2023/996) |

**State of the art:** Silent OT / PCG (Boyle et al. 2019+); transformative for MPC (see [MPC](#multi-party-computation-mpc)) preprocessing — reduces communication by orders of magnitude.

---

## Covert Security / Publicly Auditable MPC

**Goal:** Intermediate MPC security. Stronger than semi-honest (passive), weaker than full malicious. In covert security, cheating is detected with probability ε — a rational adversary won't cheat if the reputational cost of detection outweighs the benefit. Much cheaper than malicious security.

| Model | Year | Basis | Note |
|-------|------|-------|------|
| **Covert Security (Aumann-Lindell)** | 2007 | Cut-and-choose | Detect cheating with prob ε; 1/ε overhead instead of κ for malicious [[1]](https://eprint.iacr.org/2007/060) |
| **Publicly Auditable MPC (Baum et al.)** | 2014 | Commitments + audit trail | Any external party can verify correctness of MPC execution post-hoc [[1]](https://eprint.iacr.org/2014/075) |
| **Publicly Verifiable Covert (PVC)** | 2018 | Covert + public audit | Combine covert deterrence with public verifiability [[1]](https://eprint.iacr.org/2018/1108) |

---

## Asynchronous BFT / Asynchronous MPC

**Goal:** Consensus and computation without timing assumptions. Protocols that tolerate arbitrary message delays — no timeouts, no synchrony assumptions. Necessary for truly decentralized systems where network conditions are unpredictable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ben-Or-Canetti-Goldreich Async MPC** | 1993 | Information-theoretic | First async MPC; tolerates t < n/3 corruptions [[1]](https://doi.org/10.1145/167088.167109) |
| **HoneyBadgerBFT** | 2016 | Threshold encryption + ACS | First practical async BFT; uses threshold encryption for censorship resistance [[1]](https://eprint.iacr.org/2016/199) |
| **Dumbo** | 2020 | MVBA + ABA | Improved async BFT; better latency than HoneyBadger [[1]](https://eprint.iacr.org/2020/841) |
| **VABA (Validated Async BA)** | 2019 | Threshold sigs + MVBA | Async BA with external validity; basis of many async protocols [[1]](https://eprint.iacr.org/2019/1460) |
| **DAG-Rider** | 2021 | DAG + zero-message overhead | BFT from DAG structure; no extra consensus messages [[1]](https://eprint.iacr.org/2021/1362) |

**State of the art:** DAG-based BFT (DAG-Rider, Bullshark, Narwhal-Tusk); used in Aptos, Sui. Related to [MPC](#multi-party-computation-mpc), [Threshold Decryption](#threshold-decryption).

---

## Fluid MPC (Dynamic Participants)

**Goal:** MPC with join/leave. Parties can dynamically enter and exit the computation mid-protocol — without restarting. Each round may have a completely different set of participants. Linear communication complexity. Essential for decentralized, permissionless settings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Choudhuri-Goel-Green-Jain-Kaptchuk Fluid MPC** | 2021 | Secret sharing + handoff | First fluid MPC; parties hand off state to newcomers; CRYPTO 2021 [[1]](https://eprint.iacr.org/2020/754) |
| **Fluid MPC with Linear Communication** | 2023 | Packed SS + handoff | Optimal communication complexity; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/012) |

**State of the art:** Linear-communication Fluid MPC (2023); distinct from [Async MPC](#asynchronous-bft--asynchronous-mpc) (fixed parties, no timing) and standard [MPC](#multi-party-computation-mpc) (fixed parties, fixed protocol).

---

## YOSO Model (You Only Speak Once)

**Goal:** MPC where each party sends exactly one message, then goes permanently offline. No interaction, no rounds — each party contributes once and disappears. Enables committee-based protocols where committee members are selected anonymously and ephemeral.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gentry-Halevi-Magri-Nielsen-Yakoubov YOSO** | 2021 | Role-based MPC | First YOSO model; parties speak once then leave; CRYPTO 2021 [[1]](https://eprint.iacr.org/2021/210) |
| **YOLO YOSO (Cascudo-Gennaro-Ishai-Nevet)** | 2022 | YOSO + secret sharing | Fast encryption and SS in YOSO model; ASIACRYPT 2022 [[1]](https://eprint.iacr.org/2022/1279) |
| **PVSS over Class Groups for YOSO DKG** | 2024 | Class groups + PVSS | DKG in YOSO model using class group PVSS; EUROCRYPT 2024 [[1]](https://eprint.iacr.org/2023/1651) |

**State of the art:** YOSO + PVSS for blockchain committee DKG; distinct from [Fluid MPC](#fluid-mpc-dynamic-participants) (parties interact multiple times) and [Async MPC](#asynchronous-bft--asynchronous-mpc) (parties stay online).

---

## Secret-Shared Shuffle

**Goal:** Jointly permute a secret-shared dataset so that neither party learns the permutation. A fundamental building block for anonymous communication, private analytics, and oblivious sorting — but as a standalone, optimized primitive (not general MPC).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Ghosh-Poburinnaya Shuffle** | 2020 | PRF + secret sharing | First sublinear-round secret-shared shuffle [[1]](https://eprint.iacr.org/2019/1340) |
| **Maliciously Secure Shuffle (NDSS 2024)** | 2024 | Correlation checks | Malicious security via lightweight checks; linear communication [[1]](https://www.ndss-symposium.org/wp-content/uploads/2024-21-paper.pdf) |
| **SLIDE** | 2025 | Shamir SS + unconditional | Uniform shuffle of Shamir shares; unconditional security under honest majority [[1]](https://eprint.iacr.org/2025/165) |

**State of the art:** SLIDE (2025) for unconditional security; maliciously secure shuffle (NDSS 2024) for two-party. Extends [Oblivious Sorting](#oblivious-sorting--oblivious-data-structures) and [Mixnets](#mix-networks-mixnets).

---

## Garbled RAM

**Goal:** Efficient MPC for RAM programs. Extend garbled circuits to support random-access memory — instead of unrolling memory access into a massive circuit, emulate RAM with ORAM. Exponential improvement for memory-intensive computations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lu-Ostrovsky Garbled RAM** | 2013 | ORAM + GC | First garbled RAM; polylog overhead per memory access [[1]](https://eprint.iacr.org/2013/229) |
| **Garg-Lu-Ostrovsky-Scafuro** | 2015 | ORAM + succinct GC | Improved; sublinear garbled program size for RAM computations [[1]](https://eprint.iacr.org/2014/656) |
| **Heath-Kolesnikov RAM-MPC** | 2020 | Stacked garbling + RAM | Practical garbled RAM with stacked garbling optimizations [[1]](https://eprint.iacr.org/2020/973) |

**State of the art:** Heath-Kolesnikov (2020) for practical use; extends [Garbled Circuits](#garbled-circuits-expanded) and [ORAM](#oblivious-ram-oram) into a unified MPC framework.

---

## Distributed PRF (DPRF)

**Goal:** Threshold PRF evaluation. t-of-n servers jointly evaluate a PRF on input x — no single server knows the PRF key, and fewer than t servers learn nothing about the output. Enables distributed key derivation and tokenization.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas-Reingold DPRF** | 1999 | DDH | First DPRF; threshold Naor-Reingold PRF [[1]](https://doi.org/10.1007/3-540-48910-X_16) |
| **Dodis-Yampolskiy DVRF/DPRF** | 2005 | Pairings | Verifiable DPRF; each server proves correct partial evaluation [[1]](https://eprint.iacr.org/2004/310) |
| **Threshold OPRF (TOPRF)** | 2020 | EC + threshold | Threshold + oblivious: client input hidden, key distributed [[1]](https://eprint.iacr.org/2017/363) |

**State of the art:** TOPRF for distributed password authentication (extends [OPRF](#oblivious-prf-oprf)); DPRF for distributed key management. Related to [PRF](#pseudorandom-functions-prf--pseudorandom-permutations-prp).

---

## Streaming / Online Secure Computation

**Goal:** MPC on data streams. Compute on data that arrives continuously — parties cannot store the entire dataset. Single-pass or few-pass computation with sublinear memory. Distinct from standard [MPC](#multi-party-computation-mpc) which assumes all inputs available upfront.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Streaming MPC (Kol-Raz)** | 2008 | Communication complexity | First formal model: parties see stream of inputs, compute function with limited memory [[1]](https://doi.org/10.1145/1374376.1374438) |
| **PIFO (Private Information Flow for Online ML)** | 2022 | Secret sharing + streaming | Privacy-preserving online learning on streaming data via secret-shared updates [[1]](https://eprint.iacr.org/2022/1103) |
| **Streaming Verifiable Computation** | 2023 | Sumcheck + streaming | Verify computations on data streams with sublinear memory; extends [Sumcheck](#sumcheck-protocol) [[1]](https://eprint.iacr.org/2023/1393) |

**State of the art:** Streaming VC (2023) for verification; PIFO for private online learning. Distinct from [Fluid MPC](#fluid-mpc-dynamic-participants) (dynamic parties) and [PSA](#private-stream-aggregation-psa) (aggregation only).

---

## Mental Poker / Commutative Encryption

**Goal:** Fair card games without a trusted dealer. Two or more players deal, shuffle, and draw cards from a virtual deck — no player can cheat (see others' cards, stack the deck), and no trusted third party is needed. Uses commutative encryption: E_A(E_B(x)) = E_B(E_A(x)), so encryption order doesn't matter.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir-Rivest-Adleman Mental Poker** | 1981 | Commutative RSA | First protocol; players encrypt cards with commutative cipher; shuffle by re-encrypting [[1]](https://people.csail.mit.edu/rivest/pubs/SRA81.pdf) |
| **Barnett-Smart Mental Poker** | 2003 | ElGamal + ZK | Efficient protocol using ElGamal rerandomization + zero-knowledge proofs of shuffle [[1]](https://doi.org/10.1007/978-3-540-40061-5_23) |
| **Blockchain Mental Poker** | 2018 | Smart contracts + commit-reveal | Trustless poker on Ethereum; disputes resolved on-chain [[1]](https://doi.org/10.1007/978-3-030-01177-2_28) |

**State of the art:** Barnett-Smart (efficient, ZK-based); blockchain variants for trustless online play. The first example of [Secure Computation](#multi-party-computation-mpc) — historically predates general MPC.

---
