# Commitments & Verifiability

## Commitment Schemes

**Goal:** Commit to a value (hiding) so it can be revealed later (binding). Like a sealed envelope. Used as a building block in many protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen Commitment** | 1991 | DLP | Perfectly hiding, computationally binding; additively homomorphic [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Hash Commitment** | 2002 | Hash function | `C = H(m ‖ r)`; simple, practical [[1]](https://csrc.nist.gov/publications/detail/fips/180/4/final) |
| **KZG (Kate) Commitment** | 2010 | Pairings + polynomial | Commit to polynomials; constant-size proofs; trusted setup [[1]](https://eprint.iacr.org/2010/274) |
| **FRI** | 2017 | Hash + RS codes | Polynomial commitment; transparent (no setup); used in STARKs [[1]](https://eprint.iacr.org/2018/046) |
| **Bulletproofs IPA** | 2017 | Inner-product argument | Logarithmic-size polynomial commitment [[1]](https://eprint.iacr.org/2017/1066) |
| **Vector Commitments** | 2013 | Pairings / RSA | Commit to a vector; open any single position with constant-size proof; used in Verkle trees [[1]](https://eprint.iacr.org/2011/495) |
| **Ajtai Commitment** | 1996 | Lattices (SIS) | Lattice-based, post-quantum; collision-resistance from hardness of SIS [[1]](https://dl.acm.org/doi/10.1145/237814.237838) |

**State of the art:** KZG (SNARKs, Ethereum danksharding), FRI (STARKs, PQ-friendly).

---

## Verifiable Random Functions (VRF)

**Goal:** Produce a pseudorandom output from a secret key and input so that the output is deterministic, unpredictable, and publicly verifiable. Used in lotteries, leader election, DNS (NSEC5).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ECVRF** | 2023 | Elliptic curves | IETF standard (RFC 9381); based on Elligator [[1]](https://www.rfc-editor.org/rfc/rfc9381) |
| **RSA-FDH VRF** | 1999 | RSA | Full-domain hash approach; larger proofs [[1]](https://people.csail.mit.edu/silvio/Selected%20Scientific%20Papers/Pseudo%20Randomness/Verifiable_Random_Functions.pdf) |
| **BLS-based VRF** | 2001 | Pairings | Short proofs; naturally threshold-friendly [[1]](https://eprint.iacr.org/2001/002) |
| **Threshold VRF (DVRF)** | 2020 | DKG + VRF | Distributed: t-of-n nodes produce VRF jointly [[1]](https://eprint.iacr.org/2020/096) |

**State of the art:** ECVRF (RFC 9381), BLS-VRF (threshold-friendly for blockchain).

---

## Verifiable Delay Functions (VDF)

**Goal:** Unpredictability + public verifiability. Compute a function that requires at least T sequential steps, but whose output can be verified quickly. Used in unbiasable randomness beacons and blockchain leader election.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pietrzak VDF** | 2019 | RSA groups | Recursive halving proof; O(√T) proof size [[1]](https://eprint.iacr.org/2018/627) |
| **Wesolowski VDF** | 2019 | RSA / class groups | Single group element proof; O(1) size [[1]](https://eprint.iacr.org/2018/623) |
| **MinRoot VDF** | 2022 | Prime field | SNARK-friendly; low multiplicative depth [[1]](https://eprint.iacr.org/2022/1626) |

**State of the art:** Wesolowski VDF (Ethereum randomness, Chia), MinRoot (ZK-provable VDF).

---

## Verifiable Computation (VC)

**Goal:** Delegated integrity. Outsource computation to an untrusted server and verify correctness of the result efficiently — faster than re-executing. Foundation of rollups, cloud computing, and proof-carrying data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Interactive Proofs (GMR)** | 1985 | Information-theoretic | Foundational: prover convinces verifier of statement truth [[1]](https://dl.acm.org/doi/10.1145/22145.22178) |
| **Pinocchio** | 2013 | QAPs + pairings | First practical VC; basis of many zkSNARKs [[1]](https://eprint.iacr.org/2013/279) |
| **GGP (FHE-based VC)** | 2010 | FHE | Verify any computation via bootstrapping [[1]](https://eprint.iacr.org/2009/547) |
| **vnTinyRAM / TinyRAM** | 2013 | SNARK for RAM | VC for arbitrary programs (not just circuits) [[1]](https://eprint.iacr.org/2013/507) |

**State of the art:** modern zkSNARKs/STARKs subsume VC; Pinocchio historically foundational.

---

## Non-Malleable Encryption / Commitments

**Goal:** Integrity against related-message attacks. An adversary who sees a ciphertext/commitment cannot produce a valid ciphertext/commitment for a *related* message. Stronger than CCA2 in certain settings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dolev-Dwork-Naor** | 1991 | Simulation-based | First definition + construction of non-malleable encryption [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **Non-Malleable Commitments** | 1991 | Complexity-theoretic | Cannot produce related commitment from seeing one; used in MPC [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **CCA2 as NM** | 1998 | Various | CCA2 security implies non-malleability for encryption (Bellare et al.) [[1]](https://eprint.iacr.org/1998/006) |

**State of the art:** CCA2-secure encryption (standard), explicit non-malleability needed for commitments in MPC protocols.

---

## Chameleon Hash (Trapdoor Hash)

**Goal:** Controlled collision resistance. A hash function that appears collision-resistant to everyone except the holder of a secret trapdoor key, who can find arbitrary collisions. Enables redactable signatures and updatable blockchain transactions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Krawczyk-Rabin Chameleon Hash** | 1997 | DLP | First scheme; trapdoor = discrete log [[1]](https://link.springer.com/chapter/10.1007/3-540-49677-7_17) |
| **EC Chameleon Hash** | 2004 | ECDLP | Elliptic curve variant; compact keys [[1]](https://link.springer.com/chapter/10.1007/978-3-540-28632-5_2) |
| **Chameleon-Hash with Ephemeral Trapdoors** | 2017 | Pairings | Per-message trapdoor; used in sanitizable signatures [[1]](https://eprint.iacr.org/2017/018) |
| **Tagged Chameleon Hash from Lattices** | 2024 | LWE | PQ chameleon hash with tags for redactable blockchains; PKC 2024 [[1]](https://link.springer.com/chapter/10.1007/978-3-031-57725-3_10) |
| **Decentralized Chameleon Hash (IDCH)** | 2024 | Identity-based | Redactable blockchain with traceable on-chain edits; no single trapdoor holder [[1]](https://www.sciencedirect.com/science/article/pii/S235286482400141X) |

**State of the art:** EC Chameleon Hash (redactable blockchain, GDPR-compliant chains), Sanitizable Signatures (document workflows), Lattice-based variants (PQ-secure).

---

## Vector Commitments

**Goal:** Position binding. Commit to an ordered sequence of values and later open any individual position with a short proof — without revealing other positions. Generalizes Merkle trees with constant-size proofs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Catalano-Fiore VC** | 2013 | RSA / CDH | First formal definition; constant-size openings from RSA assumption [[1]](https://eprint.iacr.org/2011/495) |
| **Lai-Malavolta VC** | 2019 | Groups of unknown order | Subvector openings; aggregatable proofs [[1]](https://eprint.iacr.org/2018/1188) |
| **Verkle Trees (Kuszmaul)** | 2019 | Polynomial commitments | Logarithmic branching with constant proofs; proposed for Ethereum state [[1]](https://math.mit.edu/research/highschool/primes/materials/2018/Kuszmaul.pdf) |
| **Pointproofs (Gorbunov et al.)** | 2020 | Pairings | Cross-commitment aggregation; efficient for blockchain [[1]](https://eprint.iacr.org/2020/419) |

**State of the art:** Verkle trees for Ethereum state migration; Pointproofs for blockchain validation. Closely related to [Commitment Schemes](#commitment-schemes) and [Accumulators](#accumulators).

---

## Functional Commitments

**Goal:** Committed function evaluation. Commit to a function f, then later open f(x) for any input x with a short proof — without revealing f itself. Generalizes polynomial commitments and vector commitments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Libert-Ramanna-Yung FC** | 2016 | Pairings | First functional commitment for linear functions [[1]](https://eprint.iacr.org/2015/1017) |
| **Peikert-Pepin-Sharp FC** | 2021 | Lattices | Functional commitments from lattice assumptions [[1]](https://eprint.iacr.org/2021/1443) |
| **de Castro-Peikert FC** | 2023 | Lattices (SIS) | Succinct FC for polynomial-size circuits; from standard assumptions [[1]](https://eprint.iacr.org/2022/1368) |

**State of the art:** Lattice-based FC (de Castro-Peikert 2023); subsumes [Vector Commitments](#vector-commitments) and [Polynomial Commitments (KZG)](#commitment-schemes) as special cases.

---

## KZG Polynomial Commitments

**Goal:** Succinct, binding commitment to a polynomial with constant-size evaluation proofs. A prover commits to a polynomial f ∈ Fₚ[X] of degree d, then later proves f(z) = y for any challenge point z with a single group element — regardless of d. Foundational in SNARKs, Ethereum's data availability sampling (EIP-4844 / danksharding), and proof systems like PLONK.

| Property | Value |
|----------|-------|
| **Commitment size** | 1 group element (48 bytes on BLS12-381) |
| **Evaluation proof size** | 1 group element — constant, independent of degree |
| **Verification cost** | 1 pairing check: e(C − [y]₁, [1]₂) = e(π, [τ − z]₂) |
| **Setup** | Structured Reference String (SRS): (g, g^τ, g^τ², …, g^τ^d) — toxic waste τ must be destroyed |
| **Security assumption** | d-Strong Diffie-Hellman (d-SDH) in the generic group model |
| **Homomorphism** | Additively homomorphic: commit(f + g) = commit(f) · commit(g) |

| Variant | Year | Note |
|---------|------|------|
| **KZG (Kate-Zaverucha-Goldberg)** | 2010 | Original univariate scheme; O(1) proof, trusted setup [[1]](https://eprint.iacr.org/2010/274) |
| **KZG multi-point opening** | 2020 | Open multiple points simultaneously with one proof via quotient polynomials [[1]](https://dankradfeist.de/ethereum/2020/06/16/kate-polynomial-commitments.html) |
| **KZG with amortized batching** | 2021 | Feist-Khovratovich: O(n log n) to compute all n single-point proofs in batch [[1]](https://eprint.iacr.org/2023/033) |
| **EIP-4844 / Danksharding blob commitments** | 2024 | Ethereum uses KZG over BLS12-381 to commit 128 KB data blobs; trusted setup via Powers of Tau MPC [[1]](https://eips.ethereum.org/EIPS/eip-4844) |

**State of the art:** KZG is the dominant polynomial commitment in production SNARKs (PLONK, Groth16-style systems) and Ethereum's data availability layer. The Powers of Tau ceremony (participated in by thousands) provides a reusable SRS. The main limitation — the trusted setup — is addressed by transparent alternatives ([FRI](#commitment-schemes), [IPA](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment), [Dory](#multilinear-polynomial-commitments)). See [[1]](https://eprint.iacr.org/2010/274).

---

## Inner Product Arguments (IPA) / Bulletproofs Polynomial Commitment

**Goal:** Logarithmic-size, transparent polynomial commitment with no trusted setup. A prover holds a polynomial f of degree d (encoded as its d+1 coefficient vector) and a Pedersen-style commitment. An interactive protocol (made non-interactive via Fiat-Shamir) proves evaluation f(z) = y using only O(log d) communication and no toxic waste.

| Property | Value |
|----------|-------|
| **Commitment size** | 1 group element |
| **Proof size** | O(log d) group elements (2 log d + 3 in Bulletproofs) |
| **Verifier cost** | O(d) scalar multiplications (no sub-linear verification without preprocessing) |
| **Setup** | Transparent: only public random group generators needed |
| **Security assumption** | Discrete logarithm (DLOG) in the random oracle model |
| **Homomorphism** | Additively homomorphic commitments |

| Variant | Year | Note |
|---------|------|------|
| **Bootle et al. IPA** | 2016 | First O(log n) inner-product argument [[1]](https://eprint.iacr.org/2016/263) |
| **Bulletproofs (Bünz et al.)** | 2018 | Refinement to 2 log n group elements; transparent; also produces range proofs [[1]](https://eprint.iacr.org/2017/1066) |
| **IPA-PCS (BCMS20)** | 2020 | Specialises the IPA to a polynomial commitment scheme; used in Halo/Halo2 [[1]](https://eprint.iacr.org/2019/1021) |
| **Halo2 / IPA-based PLONK** | 2021 | Zcash / ECC's PLONK system uses IPA-PCS over Pasta curves; no trusted setup [[1]](https://zcash.github.io/halo2/) |
| **Dory** | 2021 | Transparent, pairing-based inner-product argument; O(log n) verifier (improvement over basic IPA); multilinear polynomials [[1]](https://eprint.iacr.org/2020/1274) |

**State of the art:** IPA-PCS underpins Halo2 (Zcash, Scroll, Taiko). Dory (Lee, TCC 2021) achieves O(log n) verification via pairings, reducing the main weakness of the basic IPA (linear verifier). Compared to KZG, IPA avoids trusted setup at the cost of larger proofs and slower verification. See also [Commitment Schemes](#commitment-schemes) and [Multilinear Polynomial Commitments](#multilinear-polynomial-commitments).

---

## Range Proofs

**Goal:** Prove that a committed secret value v lies within an interval [a, b] — in zero knowledge. Used in confidential transactions (Monero, MimbleWimble), anonymous credentials (age ≥ 18), auctions, and compliance checks — all without revealing v.

| Scheme | Year | Basis | Proof size (k-bit range) | Note |
|--------|------|-------|--------------------------|------|
| **Square-decomposition (Boudot)** | 2000 | DLP + commitments | O(k) group elements | Early practical scheme [[1]](https://link.springer.com/chapter/10.1007/3-540-45539-6_31) |
| **Bulletproofs range proof** | 2018 | IPA + Pedersen | O(log k) group elements | Transparent; most deployed; used in Monero, Grin, MimbleWimble [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs+** | 2021 | IPA variant | O(log k) — ~15% smaller | Reduces prover group elements [[1]](https://eprint.iacr.org/2020/735) |
| **Bulletproofs++** | 2024 | Reciprocal set-membership | O(log k) — 3× fewer multiplications | Drop-in BP replacement; faster prover; CRYPTO 2024 [[1]](https://eprint.iacr.org/2022/510) |
| **BFGW + KZG range proof** | 2021 | Lookup argument + KZG | O(1) group elements | Constant-size; trusted setup required [[1]](https://eprint.iacr.org/2020/1351) |
| **Caulk** | 2022 | Lookup in sublinear time | O(1) | Sub-linear prover via lookup in committed table; CCS 2022 [[1]](https://eprint.iacr.org/2022/621) |

**State of the art:** Bulletproofs range proofs (transparent, aggregatable, log-size) dominate in production — Monero v0.14+, Grin, and others. Bulletproofs++ (CRYPTO 2024) is the strongest transparent drop-in replacement. KZG-based lookup range proofs (BFGW, Caulk) achieve O(1) proofs with trusted setup, preferred inside SNARKs. A 2024 SoK paper systematises the full landscape [[1]](https://eprint.iacr.org/2024/430). See also [Commitment Schemes](#commitment-schemes) and [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment).

---

## Multilinear Polynomial Commitments

**Goal:** Commit to multilinear polynomials (polynomials with degree ≤ 1 in each variable) and prove evaluations at arbitrary points. Multilinear polynomials over the boolean hypercube {0,1}ⁿ are the natural representation for computations in modern zkVMs (Nova, HyperPlonk, Spartan) — enabling faster proof generation via the sumcheck protocol instead of FFT-heavy univariate techniques.

| Scheme | Year | Basis | Proof size | Note |
|--------|------|-------|-----------|------|
| **Hyrax** | 2018 | Pedersen matrix commitment | O(√n) | First efficient ML-PCS; transparent [[1]](https://eprint.iacr.org/2017/1132) |
| **Dory** | 2021 | Pairings (inner-pairing product) | O(log n) | Transparent; O(log n) verifier; TCC 2021 [[1]](https://eprint.iacr.org/2020/1274) |
| **Zeromorph** | 2023 | KZG + degree-bound proofs | O(n) prover, O(1) proof | Reduces ML commitment to univariate KZG; ZK-friendly; Journal of Cryptology 2024 [[1]](https://eprint.iacr.org/2023/917) |
| **HyperPlonk + ML-PCS** | 2023 | Sumcheck + ML commitment | Depends on underlying PCS | Adapts PLONK to boolean hypercube; avoids FFT; used in high-degree custom gates [[1]](https://eprint.iacr.org/2022/1355) |
| **DeepFold** | 2024 | Reed-Solomon + ML folding | O(log² n) | Efficient ML-PCS from RS codes; transparent; USENIX Security 2025 [[1]](https://eprint.iacr.org/2024/1595) |
| **Lattice-based ML-PCS** | 2024 | Module-SIS (NTRU-like) | O(√n) | Post-quantum; transparent; CRYPTO 2024 [[1]](https://eprint.iacr.org/2024/281) |

**State of the art:** ML-PCS schemes are the foundation of modern zkVM proof systems. Dory (transparent) and Zeromorph (KZG-based, constant proofs) are widely studied. DeepFold (2024) achieves the best asymptotic performance among hash/RS-based transparent schemes. The lattice-based variant (CRYPTO 2024) provides the first practical post-quantum ML-PCS. A comprehensive comparison of ML-PCS schemes is maintained at [[1]](https://pcs.zkpunk.pro/). See also [Commitment Schemes](#commitment-schemes) and [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment).

---

## BDLOP Lattice Commitments

**Goal:** Efficient, post-quantum additively homomorphic commitments from structured lattice assumptions. The BDLOP (Baum-Damgård-Lyubashevsky-Oechsner-Peikert) scheme is the workhorse lattice commitment used in virtually all recent lattice-based zero-knowledge proofs — for range proofs, shuffle arguments, electronic voting, and anonymous transactions — filling the role that Pedersen commitments play in the DLP world.

| Property | Value |
|----------|-------|
| **Security basis** | Module-SIS / Module-LWE (structured lattice, ring variants) |
| **Hiding** | Computational (or statistical, at cost of efficiency) |
| **Binding** | Computational |
| **Homomorphism** | Additively homomorphic: com(m₁) + com(m₂) = com(m₁ + m₂) |
| **ZK proof of opening** | Efficient; used in lattice ZK protocols |
| **Quantum security** | Yes — based on worst-case lattice hardness |

| Variant | Year | Note |
|---------|------|------|
| **Ajtai commitment** | 1996 | Collision-resistant hash from SIS; early lattice commitment; statistically binding [[1]](https://dl.acm.org/doi/10.1145/237814.237838) |
| **Benhamouda et al.** | 2015 | First practical lattice commitment with ZK proof of opening [[1]](https://eprint.iacr.org/2014/890) |
| **BDLOP** | 2018 | Factor 4–6× more efficient than predecessor; base for lattice-ZK ecosystem; SCN 2018 [[1]](https://eprint.iacr.org/2016/997) |
| **Lattice-based PoK** | 2020 | Short ZK proofs of knowledge for BDLOP commitments; enables lattice-based credentials and e-voting [[1]](https://link.springer.com/chapter/10.1007/978-3-030-44223-1_15) |
| **Lattice-based polynomial commitment (CRYPTO 2024)** | 2024 | Extends BDLOP-style commitments to a full polynomial commitment; transparent setup; 70× smaller than prior lattice PCS [[1]](https://eprint.iacr.org/2024/281) |

**State of the art:** BDLOP is the de-facto standard lattice commitment for lattice-based ZK protocols (2018–present). Nearly all recent lattice ZK proofs — for confidential transactions, voting, range proofs — build on BDLOP or its ring variant. The 2024 lattice polynomial commitment [[1]](https://eprint.iacr.org/2024/281) extends this to a full polynomial commitment scheme competitive with FRI, marking a milestone for post-quantum verifiable computation. Related to [Ajtai Commitment](#commitment-schemes) and [Functional Commitments](#functional-commitments).

---

## Verifiable Timed Commitments

**Goal:** Forced opening after delay. A commitment that the committer can open instantly, but anyone can force-open after time T by performing sequential computation. Guarantees fairness in exchange protocols — no party can withhold forever.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Naor Timed Commitments** | 2000 | RSA + sequential squaring | First construction; forced opening via repeated squaring mod N [[1]](https://doi.org/10.1007/3-540-44598-6_15) |
| **Homomorphic Timed Commitments** | 2020 | Class groups | Compute on timed commitments before opening; enables timed auctions [[1]](https://eprint.iacr.org/2019/635) |
| **Efficient Timed Commitments (Thyagarajan et al.)** | 2021 | Pairings + TLP | Batch verification; more efficient than RSA-based [[1]](https://eprint.iacr.org/2021/1272) |
| **VT-Dilithium (PQ Timed Signature)** | 2024 | Lattice + TLP | First post-quantum verifiable timed signature; combines Dilithium with lattice time-lock puzzles [[1]](https://eprint.iacr.org/2024/1262) |

**State of the art:** Homomorphic timed commitments for auction/voting applications, VT-Dilithium (PQ-secure). Combines [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption) with [Commitment Schemes](#commitment-schemes).

---

## Commit-Reveal Schemes

**Goal:** Fairness and ordering. A two-phase protocol: first commit a hidden value (binding), then reveal it later (hiding until reveal). Prevents front-running, enables fair coin-toss, sealed-bid auctions, and MEV protection in blockchains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hash-Based Commit-Reveal** | 1991 | H(value ‖ nonce) | Simplest: commit = hash; reveal = value + nonce. Used in ENS, NFT mints [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Pedersen Commit-Reveal** | 1991 | DLP | Perfectly hiding, computationally binding; see [Commitment Schemes](#commitment-schemes) [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Submarine Sends** | 2018 | Smart contract + hash | MEV-resistant: commit tx hash on-chain, reveal later [[1]](https://eprint.iacr.org/2018/985) |
| **Commit-Chain (RANDAO)** | 2015 | Sequential commit-reveal | Validators commit randomness; sequential reveal; see [Randomness Beacons](#randomness-beacons--coin-tossing) |

**State of the art:** hash commit-reveal (ubiquitous), Submarine Sends (DeFi MEV protection).

---

## Homomorphic Hashing

**Goal:** A hash function where H(a + b) = H(a) · H(b) (or similar homomorphism). Enables verifying computations on data without seeing the data, integrity checks on distributed storage, and secure multicast authentication — all without recomputing the full hash.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LtHash (Bellare-Micciancio)** | 1997 | Lattice-based | First homomorphic hash; H(a⊕b) = H(a) + H(b); used in Meta's encrypted database integrity [[1]](https://cseweb.ucsd.edu/~daniele/papers/LtHash.pdf) |
| **MuHash (Bellare-Micciancio)** | 1997 | Multiplication in group | Multiplicative homomorphic hash; H(a∥b) = H(a) · H(b); used in Bitcoin UTXO set hashing [[1]](https://cseweb.ucsd.edu/~daniele/papers/MuHash.pdf) |
| **ECMH (Elliptic Curve Multiset Hash)** | 2003 | EC points | Hash set to EC point; additive homomorphism; set equality testing [[1]](https://arxiv.org/abs/1601.06502) |

**State of the art:** LtHash (Meta Diem), MuHash (Bitcoin Core); related to [Universal Hash](#universal-hash-functions-carter-wegman) and [Homomorphic Signatures](#homomorphic-signatures).

---

## Somewhere Statistically Binding (SSB) Hash

**Goal:** Positional binding in hashed vectors. A hash of a vector v is *statistically binding* at a hidden position i — the value v[i] is uniquely determined by the hash, but which position i is binding is computationally hidden. Enables efficient SNARGs without random oracles.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hubáček-Wichs SSB Hash** | 2015 | DDH / LWE | First SSB hash; used to build designated-verifier SNARGs [[1]](https://eprint.iacr.org/2015/1026) |
| **SSB from LWE (Peikert-Shiehian)** | 2019 | LWE | SSB hash enabling SNARGs from standard lattice assumptions [[1]](https://eprint.iacr.org/2018/1004) |
| **Batch SSB (Waters-Wu)** | 2023 | Pairings / LWE | SSB hash binding at multiple positions simultaneously; batch SNARGs [[1]](https://eprint.iacr.org/2022/1500) |

**State of the art:** LWE-based SSB hash (2019+); key building block for [SNARGs](#snarg-succinct-non-interactive-arguments-without-zero-knowledge) and [BARG](#batch-arguments-barg--accumulation-schemes) from standard assumptions.

---

## Proofs of Retrievability (PoR) / Provable Data Possession

**Goal:** Remote storage verification. A client can efficiently verify that a cloud server actually stores their data — without downloading it. The server produces a compact proof from a random challenge.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PDP (Ateniese et al.)** | 2007 | RSA | Provable Data Possession; spot-check random blocks via homomorphic tags [[1]](https://eprint.iacr.org/2007/432) |
| **PoR (Juels-Kaliski)** | 2007 | Error codes + MAC | Proof of Retrievability; sentinel-based, bounded verifications [[1]](https://doi.org/10.1145/1315245.1315317) |
| **Compact PoR (Shacham-Waters)** | 2008 | BLS / Homomorphic tags | Publicly verifiable, compact proofs; unlimited verifications [[1]](https://eprint.iacr.org/2008/073) |
| **Filecoin PoRep** | 2017 | zk-SNARK + PoS | Proof of Replication: prove unique physical copy is stored [[1]](https://filecoin.io/proof-of-replication.pdf) |

**State of the art:** Compact PoR (Shacham-Waters) for traditional cloud; Filecoin PoRep for decentralized storage. Related to [PoW/PoSpace](#proof-of-work-pow--proof-of-space).

---

## Accumulators

**Goal:** Compactly represent a set and prove (non-)membership of elements. Used for revocation lists, stateless blockchain validation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Accumulator** | 1993 | Strong RSA | Constant-size; add/delete + membership proofs [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_24) |
| **Bilinear Accumulator** | 2005 | Pairings | Efficient non-membership proofs [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30580-4_14) |
| **Merkle Tree** | 1979 | Hash | Simple; membership proof is O(log n); used everywhere [[1]](https://link.springer.com/chapter/10.1007/3-540-48184-2_32) |
| **Verkle Tree** | 2018 | KZG + Merkle | Smaller proofs than Merkle; proposed for Ethereum [[1]](https://eprint.iacr.org/2010/274) |
| **Bloom Filter** | 1970 | Hash-based | Probabilistic set membership test; false positives, no false negatives; ubiquitous [[1]](https://dl.acm.org/doi/10.1145/362686.362692) |
| **Garbled Bloom Filter** | 2014 | Symmetric | Privacy-preserving set membership; used in PSI protocols [[1]](https://eprint.iacr.org/2013/620) |

**State of the art:** Verkle Trees (blockchain), RSA Accumulators + batching [[1]](https://eprint.iacr.org/2018/1188).

---

## Randomness Beacons / Coin Tossing

**Goal:** Public unpredictability. Generate random values that are publicly verifiable, unpredictable before publication, and unbiasable by any party. Used in lotteries, parameter generation, leader election.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blum Coin Tossing** | 1981 | Commitment | First 2-party fair coin toss protocol [[1]](https://dl.acm.org/doi/10.1145/800076.802493) |
| **NIST Randomness Beacon** | 2013 | Hardware RNG | Centralized public beacon; 512-bit values every 60s [[1]](https://csrc.nist.gov/projects/interoperable-randomness-beacons) |
| **drand (League of Entropy)** | 2020 | Threshold BLS | Decentralized beacon; Cloudflare, Protocol Labs, etc. [[1]](https://eprint.iacr.org/2023/728) |
| **RANDAO + VDF** | 2022 | Commit-reveal + VDF | Ethereum Beacon Chain; bias-resistant via VDF [[1]](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/attestations/) |

**State of the art:** drand (decentralized, production-grade), RANDAO+VDF (Ethereum consensus).

---

## Merkle Mountain Ranges (MMR)

**Goal:** An append-only authenticated data structure — a variant of a Merkle tree that supports efficient appending, inclusion proofs, and peak merging without rebalancing. Unlike a standard Merkle tree, MMR stores elements as a sequence of perfect binary sub-trees (peaks) whose sizes form a binary decomposition of the element count.

| Aspect | Detail |
|--------|--------|
| **Append** | O(log n) — merge peaks as new elements arrive |
| **Inclusion proof size** | O(log n) hashes (sibling path + bag of peaks) |
| **Root ("bagging peaks")** | Single hash of all peaks; compact commitment to entire history |
| **No rebalancing** | Elements are never moved; historical proofs remain valid |

| Implementation | Context |
|----------------|---------|
| **Grin** | First major MMR user; UTXO commitment in MimbleWimble [[1]](https://github.com/mimblewimble/grin/blob/master/doc/mmr.md) |
| **Herodotus / StarkNet** | Historical Ethereum block hash proofs; MMR over L1 headers [[1]](https://docs.herodotus.dev/) |
| **Bitcoin (BIP 157 / Utreexo)** | Compact client-side filtering / UTXO accumulator research [[1]](https://eprint.iacr.org/2019/611) |
| **Polkadot** | Header chain commitments in BEEFY protocol [[1]](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/frame/mmr) |

**State of the art:** MMRs are the standard append-only authenticated structure in blockchain contexts where the set grows monotonically. Herodotus (2023) demonstrated production-grade cross-chain historical proofs using MMR commitments. See [Certificate Transparency](#certificate-transparency-ct) for the log-based variant.

---

## Verifiable Encryption

**Goal:** Encrypt a value and prove (in zero-knowledge) that the ciphertext contains a plaintext satisfying a given relation — without revealing it. Used in fair exchange, escrow, and group signatures.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Camenisch-Shoup** | 2003 | CCA2 enc + ZKP | General framework; widely cited [[1]](https://eprint.iacr.org/2002/161) |
| **Asokan-Shoup-Waidner** | 1998 | RSA-based | Optimistic fair exchange via TTP [[1]](https://link.springer.com/chapter/10.1007/BFb0054144) |
| **Verifiable Enc. of DL** | 2003 | ElGamal + Sigma | Prove enc. of discrete log; simple and efficient [[1]](https://eprint.iacr.org/2002/161) |
| **ZK + Hybrid Enc.** | 2016 | SNARK/STARK + Enc. | Modern: prove anything about ciphertext contents [[1]](https://eprint.iacr.org/2016/260) |
| **VECK (Verifiable Enc. under Committed Key)** | 2024 | Symmetric key + commitment | Generalizes VE to symmetric keys; enables fair data exchange via blockchain; a16z research [[1]](https://a16zcrypto.com/posts/article/new-paper-alert-fair-data-exchange/) |

**State of the art:** Camenisch-Shoup framework + modern SNARKs; VECK (2024) for symmetric-key fair exchange.

---

## Time-Lock Puzzles / Timed-Release Encryption

**Goal:** Temporal confidentiality. Force a minimum sequential computation time *T* before a secret can be recovered — even with unlimited parallelism. "Encrypt to the future."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest-Shamir-Wagner TLP** | 1996 | Repeated squaring (RSA group) | First time-lock puzzle; foundational [[1]](https://people.csail.mit.edu/rivest/pubs/RSW96.pdf) |
| **Malavolta-Thyagarajan TLP** | 2019 | Generic (any sequential function) | TLP without RSA assumption [[1]](https://eprint.iacr.org/2019/635) |
| **Homomorphic TLP** | 2020 | RSA + HE | Compute on time-locked data without unlocking [[1]](https://eprint.iacr.org/2019/635) |

**State of the art:** RSW TLP (practical, used with VDFs), Homomorphic TLP (privacy-preserving auctions).

---

## Proof of Solvency / Proof of Reserves

**Goal:** Financial auditability with privacy. A custodian (e.g., crypto exchange) proves that total assets ≥ total liabilities — without revealing individual account balances or the full asset breakdown. Builds trust without full transparency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maxwell Proof of Reserves** | 2014 | Merkle sum tree | Merkle tree of (hash, balance) pairs; users verify inclusion [[1]](https://web.archive.org/web/20170927023529/https://iwilcox.me.uk/2014/proving-bitcoin-reserves) |
| **Provisions** | 2015 | Pedersen + ZK range proofs | Privacy-preserving PoR; hides individual balances, proves solvency in ZK [[1]](https://eprint.iacr.org/2015/1008) |
| **Summa** | 2023 | KZG + Merkle | Modern PoR with polynomial commitments; efficient for millions of accounts [[1]](https://github.com/summa-dev/summa-solvency) |

**State of the art:** Summa / KZG-based (2023); post-FTX industry standard push. Combines [Commitment Schemes](#commitment-schemes), [ZK Proofs](#zero-knowledge-proofs-zk), and [Accumulators](#accumulators).

---

## Delay Encryption

**Goal:** Time-based decryption without trusted setup. Like IBE where the "identity" is a future time slot; anyone can encrypt to time T, but decryption requires solving a VDF (sequential computation) until time T. No PKG or trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burdges-De Feo Delay Encryption** | 2021 | Isogeny + VDF | First formal construction; VDF-based time-release without trusted setup [[1]](https://eprint.iacr.org/2021/118) |
| **Practical Delay Enc (Chvojka et al.)** | 2023 | Pairings + TLP | More efficient; combines time-lock puzzles with IBE techniques [[1]](https://eprint.iacr.org/2023/1060) |

**State of the art:** Burdges-De Feo (2021); closely related to [VDFs](#verifiable-delay-functions-vdf) and [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption). Active research area for fair blockchain protocols.

---
