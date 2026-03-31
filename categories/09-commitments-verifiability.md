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


**Production readiness:** Production
Pedersen and KZG commitments are deployed at massive scale in Ethereum, Zcash, Monero, and virtually all modern ZK systems.

**Implementations:**
- [arkworks-rs/algebra](https://github.com/arkworks-rs/algebra) ⭐ 854 -- Rust, Pedersen and KZG over BLS12-381/BN254
- [blst](https://github.com/supranational/blst) ⭐ 554 -- C/Rust, BLS12-381 KZG used in Ethereum consensus clients
- [go-kzg-4844](https://github.com/crate-crypto/go-kzg-4844) ⭐ 12 -- Go, KZG for Ethereum EIP-4844
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k -- Rust, Pedersen commitments over Ristretto255

**Security status:** Secure
Pedersen commitments are information-theoretically hiding and computationally binding under DLP. KZG is secure under d-SDH in the generic group model. FRI is conjectured secure under collision-resistant hashing.

**Community acceptance:** Standard
Pedersen commitments are a textbook primitive. KZG is standardised in Ethereum EIP-4844. FRI is the foundation of the STARK ecosystem endorsed by StarkWare and Polygon.

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


**Production readiness:** Production
ECVRF is an IETF standard (RFC 9381) deployed in Chainlink VRF, Algorand, and Cardano. BLS-based VRF powers drand and ICP.

**Implementations:**
- [vrf-rs (Witnet)](https://github.com/witnet/vrf-rs) ⭐ 95 -- Rust, ECVRF per RFC 9381
- [libsodium VRF](https://doc.libsodium.org/) -- C, ECVRF implementation
- [Chainlink VRF](https://github.com/smartcontractkit/chainlink) ⭐ 8.2k -- Solidity/Go, on-chain verifiable randomness

**Security status:** Secure
ECVRF security proven under DDH in the random oracle model. BLS-VRF security under co-CDH. No known attacks at recommended parameters.

**Community acceptance:** Standard
ECVRF standardised as IETF RFC 9381. Widely adopted in blockchain consensus and verifiable randomness systems.

---

## Verifiable Delay Functions (VDF)

**Goal:** Unpredictability + public verifiability. Compute a function that requires at least T sequential steps, but whose output can be verified quickly. Used in unbiasable randomness beacons and blockchain leader election.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pietrzak VDF** | 2019 | RSA groups | Recursive halving proof; O(√T) proof size [[1]](https://eprint.iacr.org/2018/627) |
| **Wesolowski VDF** | 2019 | RSA / class groups | Single group element proof; O(1) size [[1]](https://eprint.iacr.org/2018/623) |
| **MinRoot VDF** | 2022 | Prime field | SNARK-friendly; low multiplicative depth [[1]](https://eprint.iacr.org/2022/1626) |

**State of the art:** Wesolowski VDF (Ethereum randomness, Chia), MinRoot (ZK-provable VDF).


**Production readiness:** Experimental
Deployed in Chia Network; proposed for Ethereum consensus. Hardware acceleration (ASICs) under active development by Supranational and others.

**Implementations:**
- [chiavdf](https://github.com/Chia-Network/chiavdf) ⭐ 65 -- C++/Python, Wesolowski VDF over class groups, used in Chia
- [vdf-fpga (VDF Alliance)](https://github.com/supranational/vdf-fpga) ⭐ 49 -- Verilog/C, FPGA-accelerated VDF for repeated squaring
- [chia-vdf (Rust)](https://github.com/poanetwork/vdf) ⭐ 190 -- Rust, Wesolowski/Pietrzak VDF implementations

**Security status:** Caution
Security relies on the sequential squaring assumption in groups of unknown order. Hardness is well-studied but not proven; ASIC speedups may reduce effective delay parameters.

**Community acceptance:** Emerging
Active research area with strong interest from Ethereum Foundation and Chia. No IETF/NIST standardisation yet. Endorsed by Boneh, Bunz, and leading cryptographers.

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


**Production readiness:** Mature
The VC concept is subsumed by modern SNARK/STARK systems deployed at scale. Pinocchio was foundational but is no longer directly deployed.

**Implementations:**
- [libsnark](https://github.com/scipr-lab/libsnark) ⭐ 1.9k -- C++, includes Pinocchio/BCTV14 VC; historically influential
- [Pepper/Ginger/Zaatar](https://github.com/pepper-project) -- C++, academic VC systems from UT Austin

**Security status:** Secure
Interactive proofs are information-theoretically sound. SNARK-based VC security depends on knowledge assumptions (d-SDH, KEA). No practical attacks known.

**Community acceptance:** Widely trusted
Foundational concept in theoretical CS (IP = PSPACE). Pinocchio launched the practical VC/SNARK field. Modern VC is delivered via SNARK/STARK systems with broad adoption.

---

## Non-Malleable Encryption / Commitments

**Goal:** Integrity against related-message attacks. An adversary who sees a ciphertext/commitment cannot produce a valid ciphertext/commitment for a *related* message. Stronger than CCA2 in certain settings.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dolev-Dwork-Naor** | 1991 | Simulation-based | First definition + construction of non-malleable encryption [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **Non-Malleable Commitments** | 1991 | Complexity-theoretic | Cannot produce related commitment from seeing one; used in MPC [[1]](https://dl.acm.org/doi/10.1145/103418.103474) |
| **CCA2 as NM** | 1998 | Various | CCA2 security implies non-malleability for encryption (Bellare et al.) [[1]](https://eprint.iacr.org/1998/006) |

**State of the art:** CCA2-secure encryption (standard), explicit non-malleability needed for commitments in MPC protocols.


**Production readiness:** Mature
CCA2-secure encryption (providing non-malleability) is deployed universally in TLS, SSH, and all modern encryption. Explicit non-malleable commitments are used in MPC protocol implementations.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k -- C, CCA2-secure encryption modes providing non-malleability
- [emp-toolkit](https://github.com/emp-toolkit/emp-tool) ⭐ 241 -- C++, MPC library using non-malleable commitments

**Security status:** Secure
CCA2 security implies non-malleability (Bellare et al. 1998). Well-established equivalence with no known weaknesses.

**Community acceptance:** Widely trusted
Non-malleability via CCA2 is a standard security notion in every modern cryptography textbook. Explicit non-malleable commitments are well-studied with decades of peer review.

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


**Production readiness:** Experimental
Deployed in research prototypes for redactable blockchains and sanitizable signatures. Limited production deployment outside academic systems.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
EC Chameleon Hash security reduces to ECDLP hardness. Lattice-based variants (PKC 2024) are post-quantum secure under LWE. No known attacks at recommended parameters.

**Community acceptance:** Niche
Well-studied in the academic literature with strong peer review. Adoption limited to specific use cases (GDPR-compliant blockchains, redactable signatures). No standardisation effort.

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


**Production readiness:** Experimental
Verkle trees proposed for Ethereum state migration but not yet deployed on mainnet. Pointproofs used in blockchain research prototypes.

**Implementations:**
- [go-ipa (Ethereum)](https://github.com/crate-crypto/go-ipa) ⭐ 37 -- Go, IPA-based vector commitments for Verkle trees
- [rust-verkle](https://github.com/crate-crypto/rust-verkle) ⭐ 134 -- Rust, Verkle tree implementation for Ethereum

**Security status:** Secure
Security proven under standard assumptions (RSA, CDH, d-SDH depending on variant). No known attacks.

**Community acceptance:** Emerging
Strong academic pedigree (Catalano-Fiore 2013, Boneh-Bunz-Fisch 2019). Verkle trees actively pursued by Ethereum Foundation. Growing adoption in blockchain infrastructure.

---

## Functional Commitments

**Goal:** Committed function evaluation. Commit to a function f, then later open f(x) for any input x with a short proof — without revealing f itself. Generalizes polynomial commitments and vector commitments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Libert-Ramanna-Yung FC** | 2016 | Pairings | First functional commitment for linear functions [[1]](https://eprint.iacr.org/2015/1017) |
| **Peikert-Pepin-Sharp FC** | 2021 | Lattices | Functional commitments from lattice assumptions [[1]](https://eprint.iacr.org/2021/1443) |
| **de Castro-Peikert FC** | 2023 | Lattices (SIS) | Succinct FC for polynomial-size circuits; from standard assumptions [[1]](https://eprint.iacr.org/2022/1368) |

**State of the art:** Lattice-based FC (de Castro-Peikert 2023); subsumes [Vector Commitments](#vector-commitments) and [Polynomial Commitments (KZG)](#commitment-schemes) as special cases.


**Production readiness:** Research
Academic constructions only. No production-quality implementations or real-world deployments exist.

**Implementations:**
- [de Castro-Peikert FC prototype](https://eprint.iacr.org/2022/1368) -- Reference implementation accompanying the paper; research-grade

**Security status:** Secure
Security proven under standard lattice assumptions (SIS, LWE). No known attacks. Relatively new constructions with limited cryptanalysis.

**Community acceptance:** Niche
Published at top venues (EUROCRYPT, CRYPTO). Recognized as theoretically important but practical deployment remains distant.

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


**Production readiness:** Production
Deployed in Ethereum EIP-4844 (danksharding blob commitments), PLONK-based proof systems (Aztec, Scroll, Polygon zkEVM), and Filecoin. The Powers of Tau ceremony provides a reusable SRS trusted by thousands of participants.

**Implementations:**
- [blst](https://github.com/supranational/blst) ⭐ 554 -- C/Rust, high-performance BLS12-381 for KZG; used by Ethereum consensus clients
- [c-kzg-4844](https://github.com/ethereum/c-kzg-4844) ⭐ 167 -- C, Ethereum's reference KZG library for EIP-4844
- [go-kzg-4844](https://github.com/crate-crypto/go-kzg-4844) ⭐ 12 -- Go, KZG for Ethereum clients
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 -- Rust, generic PCS including KZG
- [halo2 (PSE)](https://github.com/privacy-scaling-explorations/halo2) ⭐ 244 -- Rust, KZG backend for PLONK

**Security status:** Secure
Security proven under d-Strong Diffie-Hellman (d-SDH) in the generic group model. Trusted setup requires toxic waste destruction; mitigated by large-scale MPC ceremonies (Powers of Tau with 100,000+ contributors).

**Community acceptance:** Widely trusted
De-facto standard polynomial commitment in production SNARKs. Endorsed by Ethereum Foundation, adopted by all major ZK-rollup teams. Extensive peer review since 2010.

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


**Production readiness:** Production
Deployed in Zcash Orchard (Halo2), Monero (Bulletproofs range proofs), Grin (MimbleWimble), and multiple ZK-rollups.

**Implementations:**
- [halo2 (zcash)](https://github.com/zcash/halo2) ⭐ 895 -- Rust, IPA-based PLONK for Zcash Orchard
- [bulletproofs (dalek)](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k -- Rust, Bulletproofs over Ristretto255
- [Monero Bulletproofs](https://github.com/monero-project/monero) ⭐ 10k -- C++, integrated Bulletproofs for confidential transactions
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 -- Rust, IPA polynomial commitment

**Security status:** Secure
Security proven under the discrete logarithm assumption in the random oracle model. No known attacks. Transparent setup eliminates trusted setup risks.

**Community acceptance:** Widely trusted
Bulletproofs (2018) is one of the most cited and deployed ZK constructions. Adopted by Zcash, Monero, and numerous privacy-preserving systems. Strong peer review at IEEE S&P.

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


**Production readiness:** Production
Bulletproofs range proofs are deployed in Monero (v0.14+), Grin, and MimbleWimble-based chains for confidential transactions at scale.

**Implementations:**
- [bulletproofs (dalek)](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k -- Rust, Bulletproofs range proofs over Ristretto255
- [Monero Bulletproofs+](https://github.com/monero-project/monero) ⭐ 10k -- C++, Bulletproofs+ range proofs in production
- [secp256k1-zkp](https://github.com/BlockstreamResearch/secp256k1-zkp) ⭐ 419 -- C, Bulletproofs range proofs for Liquid/Elements sidechain

**Security status:** Secure
Bulletproofs range proofs are secure under DLOG in the random oracle model. Bulletproofs++ (CRYPTO 2024) provides improved efficiency with the same security.

**Community acceptance:** Widely trusted
Deployed in multiple production cryptocurrencies. Bulletproofs paper is heavily cited. Bulletproofs++ accepted at CRYPTO 2024.

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


**Production readiness:** Experimental
Zeromorph and Dory are used in research prototypes and emerging zkVM backends (HyperPlonk, Spartan). DeepFold accepted at USENIX Security 2025.

**Implementations:**
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 -- Rust, multilinear PCS implementations including Hyrax
- [microsoft/Spartan](https://github.com/microsoft/Spartan) ⭐ 849 -- Rust, multilinear PCS for Spartan proof system
- [Espresso HyperPlonk](https://github.com/EspressoSystems/hyperplonk) ⭐ 340 -- Rust, ML-PCS for HyperPlonk

**Security status:** Secure
Security varies by construction: Dory under SXDH, Zeromorph under d-SDH (KZG), DeepFold under collision-resistant hashing. No known attacks on any variant.

**Community acceptance:** Emerging
Active research area with strong publications at CRYPTO and TCC. Increasingly adopted in zkVM design. PCS comparison maintained at pcs.zkpunk.pro.

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


**Production readiness:** Experimental
Used in lattice-based ZK protocol research prototypes for voting, credentials, and confidential transactions. No large-scale production deployment yet.

**Implementations:**
- [latticefold](https://github.com/NethermindEth/latticefold) ⭐ 126 -- Rust, lattice-based folding scheme using BDLOP-style commitments
- [Lattigo](https://github.com/tuneinsight/lattigo) ⭐ 1.4k -- Go, lattice cryptography library with commitment building blocks

**Security status:** Secure
Security reduces to Module-SIS and Module-LWE hardness, which are well-studied structured lattice problems with worst-case to average-case reductions. Post-quantum secure.

**Community acceptance:** Emerging
Published at SCN 2018 and subsequent top venues. Recognised as the lattice analogue of Pedersen commitments. Growing adoption in post-quantum ZK research.

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


**Production readiness:** Experimental
Research prototypes for timed auctions and fair exchange. No large-scale production deployment.

**Implementations:**
- [tlock (drand)](https://github.com/drand/tlock) ⭐ 634 -- Go, timelock encryption using drand beacons

**Security status:** Caution
Security relies on the sequential squaring assumption (same as VDFs). Well-studied but not proven; hardware speedups could reduce effective time guarantees.

**Community acceptance:** Niche
Published at CRYPTO 2000 and subsequent venues. Recognised as important for fair protocols but limited practical adoption. VT-Dilithium (2024) is recent and not yet widely reviewed.

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


**Production readiness:** Production
Hash-based commit-reveal is ubiquitous in Ethereum smart contracts (ENS, NFT mints, on-chain auctions) and blockchain protocols (RANDAO).

**Implementations:**
- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) ⭐ 27k -- Solidity, commit-reveal patterns in audited contract library
- [ENS (Ethereum Name Service)](https://github.com/ensdomains/ens-contracts) ⭐ 714 -- Solidity, commit-reveal for domain registration

**Security status:** Secure
Hash-based commit-reveal is secure under collision resistance and preimage resistance of the hash function. Simple and well-understood.

**Community acceptance:** Widely trusted
Textbook construction used universally in blockchain and cryptographic protocols. No controversy or standardisation needed due to simplicity.

---

## Homomorphic Hashing

**Goal:** A hash function where H(a + b) = H(a) · H(b) (or similar homomorphism). Enables verifying computations on data without seeing the data, integrity checks on distributed storage, and secure multicast authentication — all without recomputing the full hash.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LtHash (Bellare-Micciancio)** | 1997 | Lattice-based | First homomorphic hash; H(a⊕b) = H(a) + H(b); used in Meta's encrypted database integrity [[1]](https://cseweb.ucsd.edu/~daniele/papers/LtHash.pdf) |
| **MuHash (Bellare-Micciancio)** | 1997 | Multiplication in group | Multiplicative homomorphic hash; H(a∥b) = H(a) · H(b); used in Bitcoin UTXO set hashing [[1]](https://cseweb.ucsd.edu/~daniele/papers/MuHash.pdf) |
| **ECMH (Elliptic Curve Multiset Hash)** | 2003 | EC points | Hash set to EC point; additive homomorphism; set equality testing [[1]](https://arxiv.org/abs/1601.06502) |

**State of the art:** LtHash (Meta Diem), MuHash (Bitcoin Core); related to [Universal Hash](#universal-hash-functions-carter-wegman) and [Homomorphic Signatures](#homomorphic-signatures).


**Production readiness:** Production
LtHash deployed in Meta's Diem/Libra for database integrity. MuHash integrated in Bitcoin Core for UTXO set hashing (muhash module).

**Implementations:**
- [Bitcoin Core muhash](https://github.com/bitcoin/bitcoin) ⭐ 88k -- C++, MuHash for UTXO set commitment

**Security status:** Secure
LtHash and MuHash security reduces to collision resistance of the underlying group/lattice operations. ECMH is secure under ECDLP. No known attacks.

**Community acceptance:** Niche
Well-studied (Bellare-Micciancio 1997) but adoption limited to specific infrastructure use cases. MuHash acceptance in Bitcoin Core is a strong endorsement.

---

## Somewhere Statistically Binding (SSB) Hash

**Goal:** Positional binding in hashed vectors. A hash of a vector v is *statistically binding* at a hidden position i — the value v[i] is uniquely determined by the hash, but which position i is binding is computationally hidden. Enables efficient SNARGs without random oracles.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hubáček-Wichs SSB Hash** | 2015 | DDH / LWE | First SSB hash; used to build designated-verifier SNARGs [[1]](https://eprint.iacr.org/2015/1026) |
| **SSB from LWE (Peikert-Shiehian)** | 2019 | LWE | SSB hash enabling SNARGs from standard lattice assumptions [[1]](https://eprint.iacr.org/2018/1004) |
| **Batch SSB (Waters-Wu)** | 2023 | Pairings / LWE | SSB hash binding at multiple positions simultaneously; batch SNARGs [[1]](https://eprint.iacr.org/2022/1500) |

**State of the art:** LWE-based SSB hash (2019+); key building block for [SNARGs](#snarg-succinct-non-interactive-arguments-without-zero-knowledge) and [BARG](#batch-arguments-barg--accumulation-schemes) from standard assumptions.


**Production readiness:** Research
Purely theoretical construction used as a building block in SNARG proofs. No standalone production implementations.

**Implementations:**
- [Reference implementations in SNARG papers](https://eprint.iacr.org/2018/1004) -- Academic prototypes accompanying papers

**Security status:** Secure
Security proven under standard assumptions (DDH, LWE). Well-analysed in the theoretical cryptography literature.

**Community acceptance:** Niche
Important theoretical primitive published at TCC and FOCS. Used internally in SNARG/BARG constructions. Not independently standardised or widely deployed.

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


**Production readiness:** Production
Filecoin PoRep is deployed at scale in the Filecoin decentralised storage network. Compact PoR (Shacham-Waters) is used in cloud auditing research and products.

**Implementations:**
- [rust-fil-proofs (Filecoin)](https://github.com/filecoin-project/rust-fil-proofs) ⭐ 503 -- Rust, Filecoin's proof-of-replication and proof-of-spacetime
- [Compact PoR (Shacham-Waters)](https://eprint.iacr.org/2008/073) -- Reference implementation; various academic re-implementations

**Security status:** Secure
Compact PoR security proven under BLS/CDH assumptions. Filecoin PoRep security depends on zk-SNARK soundness and proof-of-space assumptions. No known practical attacks.

**Community acceptance:** Widely trusted
PoR/PDP are well-established in the cloud security literature. Filecoin PoRep has undergone extensive audits and formal analysis. Shacham-Waters is widely cited.

---

## Accumulators

**Goal:** Compactly represent a set and prove (non-)membership of elements. Used for revocation lists, stateless blockchain validation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Benaloh-de Mare RSA Accumulator** | 1993 | Quasi-commutative RSA | First accumulator; constant-size digest; membership witnesses via modular exponentiation; rigid-integer modulus [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_24) |
| **Barić-Pfitzmann Collision-Free Accumulator** | 1997 | Strong RSA | Strengthens Benaloh-de Mare to collision-freeness; enables fail-stop signatures with constant-size public keys and no Merkle tree [[1]](https://link.springer.com/chapter/10.1007/3-540-69053-0_33) |
| **Camenisch-Lysyanskaya Dynamic Accumulator** | 2002 | Strong RSA | Supports dynamic add/delete with witness updates independent of set size; efficient ZK proof of membership; basis for anonymous credential revocation [[1]](https://link.springer.com/chapter/10.1007/3-540-45708-9_5) |
| **Nguyen Bilinear Accumulator** | 2005 | Pairings (q-SDH) | First pairing-based accumulator; enables constant-size non-membership witnesses; used for group membership revocation and ID-based ring signatures [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30574-3_19) |
| **Universal Accumulator (Li-Li-Xue)** | 2007 | Strong RSA | Adds efficient non-membership witnesses to the Camenisch-Lysyanskaya construction; supports both membership and non-membership in ZK [[1]](https://link.springer.com/chapter/10.1007/978-3-540-72738-5_17) |
| **Boneh-Bünz-Fisch Batching** | 2019 | Groups of unknown order | Batch/aggregate arbitrarily many membership proofs into a single constant-size proof; enables stateless blockchain validation; also yields first constant-parameter vector commitment [[1]](https://eprint.iacr.org/2018/1188) |
| **Merkle Tree** | 1979 | Hash | Simple; membership proof is O(log n); used everywhere [[1]](https://link.springer.com/chapter/10.1007/3-540-48184-2_32) |
| **Verkle Tree** | 2018 | KZG + Merkle | Smaller proofs than Merkle; proposed for Ethereum [[1]](https://eprint.iacr.org/2010/274) |
| **Bloom Filter** | 1970 | Hash-based | Probabilistic set membership test; false positives, no false negatives; ubiquitous [[1]](https://dl.acm.org/doi/10.1145/362686.362692) |
| **Garbled Bloom Filter** | 2014 | Symmetric | Privacy-preserving set membership; used in PSI protocols [[1]](https://eprint.iacr.org/2013/620) |

**State of the art:** RSA accumulators with Boneh-Bünz-Fisch batching (CRYPTO 2019) are the state of the art for stateless blockchains — Utreexo (Bitcoin), Verkle Trees (Ethereum). Universal accumulators (Li et al. 2007) are used in anonymous credential systems requiring non-membership proofs. See [[1]](https://eprint.iacr.org/2018/1188).


**Production readiness:** Production
Merkle trees are deployed universally in blockchains, certificate transparency, and file systems. RSA accumulators with batching used in Utreexo (Bitcoin) research. Bloom filters deployed in virtually all networked systems.

**Implementations:**
- [utreexo](https://github.com/utreexo/utreexo) ⭐ 66 -- Go, RSA accumulator for Bitcoin UTXO set
- [accumulator](https://github.com/cambrian/accumulator) ⭐ 138 -- Rust, RSA accumulator with Boneh-Bunz-Fisch batching
- [bloom (Go)](https://github.com/bits-and-blooms/bloom) ⭐ 2.8k -- Go, production Bloom filter library

**Security status:** Secure
Merkle trees are secure under collision-resistant hashing. RSA accumulators secure under Strong RSA assumption. Bloom filters have probabilistic guarantees (false positives). No known attacks on any standard construction.

**Community acceptance:** Standard
Merkle trees are a foundational data structure used since 1979. RSA accumulators published at CRYPTO. Bloom filters are a standard CS primitive. All widely taught and deployed.

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


**Production readiness:** Production
drand (League of Entropy) is production-grade, run by Cloudflare, Protocol Labs, and others. NIST Randomness Beacon operational since 2013. RANDAO deployed in Ethereum Beacon Chain.

**Implementations:**
- [drand](https://github.com/drand/drand) ⭐ 813 -- Go, decentralised randomness beacon
- [NIST Beacon](https://beacon.nist.gov/) -- Hardware-based, centralized public beacon
- [RANDAO (Ethereum)](https://github.com/ethereum/consensus-specs) ⭐ 3.9k -- Python/Go, commit-reveal randomness in Ethereum consensus

**Security status:** Secure
drand security relies on threshold BLS (t-of-n honest nodes sufficient). RANDAO may have last-revealer bias, mitigated by VDF proposals. Blum coin toss is information-theoretically fair.

**Community acceptance:** Widely trusted
drand endorsed by Cloudflare, Protocol Labs, Ethereum Foundation. NIST Beacon is a federal standard. RANDAO is part of Ethereum's consensus specification.

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


**Production readiness:** Production
Deployed in Grin (MimbleWimble UTXO commitment), Polkadot (BEEFY protocol), and Herodotus (StarkNet cross-chain proofs).

**Implementations:**
- [grin MMR](https://github.com/mimblewimble/grin/tree/master/store/src) ⭐ 5.1k -- Rust, production MMR in Grin
- [substrate-mmr (Polkadot)](https://github.com/paritytech/polkadot-sdk/tree/master/substrate/frame/mmr) ⭐ 2.7k -- Rust, MMR pallet for Substrate/Polkadot
- [herodotus-mmr](https://github.com/HerodotusDev/cairo-mmr) ⭐ 37 -- Cairo, MMR for StarkNet cross-chain proofs

**Security status:** Secure
MMR security reduces to collision resistance of the hash function. Append-only structure prevents retroactive modification. Well-understood security properties.

**Community acceptance:** Widely trusted
Standard append-only authenticated data structure in blockchain engineering. Adopted by multiple production blockchain projects. Simple and well-analysed.

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


**Production readiness:** Mature
Camenisch-Shoup framework widely implemented in academic and industrial prototypes. VECK (2024) is recent with initial adoption in fair data exchange.

**Implementations:**
- [Camenisch-Shoup (IBM Zurich)](https://eprint.iacr.org/2002/161) -- Java/C++, reference implementations accompanying the paper
- [circom/snarkjs](https://github.com/iden3/snarkjs) ⭐ 2.0k -- JavaScript, SNARK-based verifiable encryption via general ZK circuits

**Security status:** Secure
Camenisch-Shoup is CCA2-secure with ZK proofs of plaintext properties. SNARK-based variants inherit SNARK soundness. No known attacks.

**Community acceptance:** Niche
Well-cited in the academic literature (Camenisch-Shoup 2003). Used in group signature and fair exchange protocols. Limited standalone standardisation.

---

## Time-Lock Puzzles / Timed-Release Encryption

**Goal:** Temporal confidentiality. Force a minimum sequential computation time *T* before a secret can be recovered — even with unlimited parallelism. "Encrypt to the future."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest-Shamir-Wagner TLP** | 1996 | Repeated squaring (RSA group) | First time-lock puzzle; foundational [[1]](https://people.csail.mit.edu/rivest/pubs/RSW96.pdf) |
| **Malavolta-Thyagarajan TLP** | 2019 | Generic (any sequential function) | TLP without RSA assumption [[1]](https://eprint.iacr.org/2019/635) |
| **Homomorphic TLP** | 2020 | RSA + HE | Compute on time-locked data without unlocking [[1]](https://eprint.iacr.org/2019/635) |

**State of the art:** RSW TLP (practical, used with VDFs), Homomorphic TLP (privacy-preserving auctions).


**Production readiness:** Experimental
RSW TLP is used in VDF constructions (Chia, Ethereum research). Homomorphic TLP exists in research prototypes only.

**Implementations:**
- [chiavdf](https://github.com/Chia-Network/chiavdf) ⭐ 65 -- C++, includes TLP implementation via repeated squaring
- [tlock (drand)](https://github.com/drand/tlock) ⭐ 634 -- Go, timelock encryption built on drand beacons

**Security status:** Caution
Security relies on the assumption that repeated squaring cannot be parallelised. Well-studied since Rivest-Shamir-Wagner (1996) but unproven. Hardware acceleration is a concern.

**Community acceptance:** Niche
Foundational paper by Rivest, Shamir, and Wagner (1996) is widely cited. Used as a building block in VDFs and fair protocols. No standardisation effort.

---

## Proof of Solvency / Proof of Reserves

**Goal:** Financial auditability with privacy. A custodian (e.g., crypto exchange) proves that total assets ≥ total liabilities — without revealing individual account balances or the full asset breakdown. Builds trust without full transparency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maxwell Proof of Reserves** | 2014 | Merkle sum tree | Merkle tree of (hash, balance) pairs; users verify inclusion [[1]](https://web.archive.org/web/20170927023529/https://iwilcox.me.uk/2014/proving-bitcoin-reserves) |
| **Provisions** | 2015 | Pedersen + ZK range proofs | Privacy-preserving PoR; hides individual balances, proves solvency in ZK [[1]](https://eprint.iacr.org/2015/1008) |
| **Summa** | 2023 | KZG + Merkle | Modern PoR with polynomial commitments; efficient for millions of accounts [[1]](https://github.com/summa-dev/summa-solvency) |

**State of the art:** Summa / KZG-based (2023); post-FTX industry standard push. Combines [Commitment Schemes](#commitment-schemes), [ZK Proofs](#zero-knowledge-proofs-zk), and [Accumulators](#accumulators).


**Production readiness:** Experimental
Maxwell proof of reserves is used by some exchanges post-FTX. Summa (2023) is in early adoption. Industry push for standards is ongoing.

**Implementations:**
- [summa-solvency](https://github.com/summa-dev/summa-solvency) ⭐ 99 -- Rust/Solidity, KZG-based proof of solvency
- [provisions](https://eprint.iacr.org/2015/1008) -- Reference implementation; academic prototype

**Security status:** Caution
Cryptographic proofs are sound, but proof of solvency also requires non-cryptographic assumptions (no hidden liabilities, accurate asset reporting). The cryptographic component alone is insufficient for full auditability.

**Community acceptance:** Emerging
Strong post-FTX industry interest. Published at IEEE S&P and CCS. No formal standard yet, but regulatory pressure is driving adoption.

---

## Delay Encryption

**Goal:** Time-based decryption without trusted setup. Like IBE where the "identity" is a future time slot; anyone can encrypt to time T, but decryption requires solving a VDF (sequential computation) until time T. No PKG or trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burdges-De Feo Delay Encryption** | 2021 | Isogeny + VDF | First formal construction; VDF-based time-release without trusted setup [[1]](https://eprint.iacr.org/2021/118) |
| **Practical Delay Enc (Chvojka et al.)** | 2023 | Pairings + TLP | More efficient; combines time-lock puzzles with IBE techniques [[1]](https://eprint.iacr.org/2023/1060) |

**State of the art:** Burdges-De Feo (2021); closely related to [VDFs](#verifiable-delay-functions-vdf) and [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption). Active research area for fair blockchain protocols.


**Production readiness:** Research
Academic constructions only. No production-quality implementations or real-world deployments exist.

**Implementations:**
- [Burdges-De Feo reference](https://eprint.iacr.org/2021/118) -- Academic prototype accompanying the paper
- [tlock (drand)](https://github.com/drand/tlock) ⭐ 634 -- Go, practical timelock encryption (related but distinct)

**Security status:** Caution
Security depends on VDF assumptions and (for the isogeny variant) SIDH-like assumptions, some of which were broken in 2022. Active area of research.

**Community acceptance:** Niche
Published at PKC and eprint. Interesting theoretical concept but limited peer review and no standardisation effort.

---

## Brakedown Polynomial Commitments

**Goal:** Linear-time, transparent polynomial commitment with no trusted setup and minimal cryptographic assumptions. Brakedown commits to a polynomial (represented as a matrix of coefficients) using only a collision-resistant hash function and a linear code, achieving O(n) prover time — a significant improvement over FFT-based schemes — at the cost of larger proof sizes. Designed for settings where proof generation speed dominates.

| Property | Value |
|----------|-------|
| **Commitment size** | O(√n) field elements |
| **Proof size** | O(√n) field elements |
| **Prover time** | O(n) — linear in the number of coefficients |
| **Verifier time** | O(n) (linear; no sub-linear verifier without additional techniques) |
| **Setup** | Transparent: public random linear code, no toxic waste |
| **Security assumption** | Collision-resistant hash functions (random oracle); proximity gap for linear codes |

| Variant | Year | Note |
|---------|------|------|
| **Brakedown (Golovnev et al.)** | 2023 | First linear-time polynomial commitment; hash-based; O(√n) proof; CRYPTO 2023 [[1]](https://eprint.iacr.org/2021/1043) |
| **Orion** | 2022 | Independent linear-time PCS construction; similar asymptotic profile; CCS 2022 [[1]](https://eprint.iacr.org/2022/1010) |
| **Binius** | 2024 | Extends Brakedown-style techniques to binary tower fields; native boolean arithmetic; dramatically faster for binary circuits; used in SP1 zkVM [[1]](https://eprint.iacr.org/2023/1784) |

**State of the art:** Brakedown and Orion (2022–2023) established linear-time polynomial commitments as a practical category. Binius (2024) extends this to binary tower fields, achieving the fastest known prover times for boolean circuits. The main trade-off is O(√n) proof size (larger than KZG's O(1) or FRI's O(log² n)). Linear-time PCS schemes are increasingly favoured in zkVM backends where prover throughput is the bottleneck. See also [KZG Polynomial Commitments](#kzg-polynomial-commitments), [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment), and [Multilinear Polynomial Commitments](#multilinear-polynomial-commitments).


**Production readiness:** Experimental
Binius (extending Brakedown techniques) is used in SP1 zkVM. Brakedown and Orion are implemented in research prototypes and emerging proof systems.

**Implementations:**
- [binius](https://github.com/IrreducibleOSS/binius) ⭐ 133 -- Rust, binary-field polynomial commitment used in SP1
- [Orion](https://github.com/sunblaze-ucb/orion) ⭐ 31 -- Rust, linear-time PCS prototype

**Security status:** Secure
Security relies on collision-resistant hash functions and proximity gaps for linear codes. Conservative assumptions with well-understood security margins.

**Community acceptance:** Emerging
Published at CRYPTO 2023 (Brakedown) and CCS 2022 (Orion). Binius gaining traction in zkVM community. Active adoption curve.

---

## Bandersnatch and In-Circuit VRF

**Goal:** Efficient VRF evaluation inside a SNARK circuit. Standard VRF constructions (ECVRF, BLS-VRF) operate over curves whose field arithmetic is expensive to prove inside ZK circuits. Bandersnatch is a twisted Edwards curve defined over the BLS12-381 scalar field, enabling efficient in-circuit VRF computation — the core operation of ring VRFs and anonymous leader election schemes where the VRF proof itself must be verified inside a SNARK.

| Scheme / Curve | Year | Basis | Note |
|----------------|------|-------|------|
| **Bandersnatch curve** | 2021 | Twisted Edwards over BLS12-381 scalar field | Designed by Ethereum Foundation; GLV endomorphism for fast scalar multiplication; 2-isogenous to Bandersnatch-Jubjub [[1]](https://eprint.iacr.org/2021/1152) |
| **Ring VRF (Sassafras)** | 2023 | Bandersnatch + SNARK | Proposed Ethereum validator shuffle; anonymous VRF: prove membership in validator ring and produce VRF output without revealing identity [[1]](https://eprint.iacr.org/2023/002) |
| **Jubjub curve** | 2017 | Twisted Edwards over BLS12-381 scalar field | Predecessor; used in Zcash Sapling; slower than Bandersnatch [[1]](https://zips.z.cash/protocol/protocol.pdf) |
| **Grumpkin curve** | 2022 | Short Weierstrass over BN254 scalar field | Analogous trick for BN254 ecosystem; 2-cycle with BN254 [[1]](https://hackmd.io/@aztec-network/ByzgNxBfd) |

**State of the art:** Bandersnatch is the recommended curve for in-circuit VRF operations over BLS12-381 (Ethereum, Polkadot). The Ring VRF / Sassafras protocol (2023) uses Bandersnatch to achieve anonymous, publicly verifiable leader election — a critical primitive for privacy-preserving consensus. See also [Verifiable Random Functions (VRF)](#verifiable-random-functions-vrf) and [Ring VRF](categories/08-signatures-advanced.md#ring-vrf).


**Production readiness:** Experimental
Bandersnatch curve designed by Ethereum Foundation. Ring VRF (Sassafras) proposed for Ethereum but not yet deployed on mainnet.

**Implementations:**
- [bandersnatch (Ethereum Foundation)](https://github.com/zhenfeizhang/bandersnatch) ⭐ 14 -- Rust, Bandersnatch curve implementation
- [ark-bandersnatch](https://github.com/arkworks-rs/curves) ⭐ 311 -- Rust, Bandersnatch in arkworks ecosystem
- [ring-vrf (w3f)](https://github.com/w3f/ring-vrf) ⭐ 41 -- Rust, ring VRF for Polkadot/Ethereum

**Security status:** Secure
Bandersnatch provides ~128-bit security (same as BLS12-381 scalar field). Standard elliptic curve assumptions (DLOG). No known attacks.

**Community acceptance:** Emerging
Designed and endorsed by Ethereum Foundation researchers. Proposed for Ethereum (Sassafras) and Polkadot. Active development and peer review.

---

## GKR Protocol (Doubly-Efficient Interactive Proofs)

**Goal:** Efficient interactive proof for layered arithmetic circuits. The Goldwasser-Kalai-Rothblum (GKR) protocol lets a prover convince a verifier that a layered circuit C was evaluated correctly on a given input, with verifier cost O(n + d log n) and prover cost O(|C|) — strictly sub-linear in the circuit size for the verifier. GKR is the theoretical backbone of Libra, Virgo, and other sumcheck-based transparent proof systems.

The protocol proceeds layer by layer, reducing a claim about one circuit layer to a claim about the layer below via the sumcheck protocol. Each layer produces a multilinear extension (MLE) of its wiring predicate, and the prover sends O(d) field elements where d is the circuit depth.

| Property | Value |
|----------|-------|
| **Verifier cost** | O(d · log |C|) field operations — sub-linear for log-depth circuits |
| **Prover cost** | O(|C| log |C|) |
| **Round complexity** | O(d · log n) rounds of sumcheck |
| **Setup** | Transparent (no trusted setup); based on sumcheck + MLE |
| **Security** | Information-theoretic soundness (IP = PSPACE) |

| Variant | Year | Note |
|---------|------|------|
| **GKR (original)** | 2008 | Doubly-efficient IP for log-space uniform circuits; STOC 2008 [[1]](https://dl.acm.org/doi/10.1145/1374376.1374396) |
| **Thaler's linear-time prover** | 2013 | O(|C|) prover via bookkeeping table; STOC 2013 [[1]](https://eprint.iacr.org/2013/351) |
| **Libra** | 2019 | Combines GKR with polynomial commitments (KZG/IPA) for a non-interactive zkSNARK; O(|C|) prover; CCS 2019 [[1]](https://eprint.iacr.org/2019/317) |
| **Virgo** | 2020 | Transparent GKR-based zkSNARK using FRI polynomial commitment; IEEE S&P 2020 [[1]](https://eprint.iacr.org/2019/1482) |
| **Spartan + GKR** | 2021 | Combines GKR-style sumcheck with multilinear PCS to yield zkSNARK with no trusted setup [[1]](https://eprint.iacr.org/2019/550) |

**State of the art:** GKR underpins the sumcheck-based zkSNARK family (Libra, Virgo, Spartan, HyperPlonk). Thaler's 2013 linear-time prover made the approach practical. Modern deployments combine GKR's efficient sumcheck reduction with multilinear polynomial commitments ([Dory](#multilinear-polynomial-commitments), [Zeromorph](#multilinear-polynomial-commitments)) to obtain fully non-interactive proofs. See also [Sumcheck Protocol](categories/04-zero-knowledge-proof-systems.md#sumcheck-protocol) and [Verifiable Computation (VC)](#verifiable-computation-vc).


**Production readiness:** Mature
GKR underpins production proof systems Libra, Virgo, and Spartan. Thaler's linear-time prover (2013) made the approach practical.

**Implementations:**
- [microsoft/Spartan](https://github.com/microsoft/Spartan) ⭐ 849 -- Rust, GKR-based zkSNARK
- [Virgo (sunblaze-ucb)](https://github.com/sunblaze-ucb/Virgo) ⭐ 61 -- C++, transparent GKR-based zkSNARK
- [libra (sunblaze-ucb)](https://github.com/sunblaze-ucb/Libra) ⭐ 55 -- C++, GKR + polynomial commitment zkSNARK

**Security status:** Secure
GKR has information-theoretic soundness (interactive proof). Non-interactive variants inherit security of the underlying polynomial commitment. Well-studied since 2008.

**Community acceptance:** Widely trusted
Published at STOC 2008 (Goldwasser, Kalai, Rothblum). Thaler's improvement at STOC 2013. Underpins the sumcheck-based proof system family endorsed by leading cryptographers.

---

## Ligero / Ligero++ (MPC-in-the-Head Commitments)

**Goal:** Transparent, hash-based polynomial commitment and zero-knowledge proof system with no trusted setup and minimal assumptions — only collision-resistant hash functions. Ligero encodes the witness as a Reed-Solomon codeword and commits using a Merkle tree; the verifier checks random positions. Ligero++ extends this with improved soundness and smaller proofs via stronger code-based techniques. Both serve as the commitment layer for MPC-in-the-head proof systems.

| Property | Value |
|----------|-------|
| **Commitment basis** | Reed-Solomon / linear codes + Merkle tree |
| **Setup** | Transparent — hash functions only |
| **Proof size** | O(√|C| · λ) — sub-linear in circuit size; larger than KZG/FRI |
| **Prover time** | O(|C| log |C|) |
| **Verifier time** | O(√|C| · λ) |
| **Security assumption** | Collision-resistant hash functions (ROM) |
| **Post-quantum** | Yes — hash-based |

| Variant | Year | Note |
|---------|------|------|
| **Ligero (Ames et al.)** | 2017 | First sublinear zkSNARK from symmetric primitives only; encodes witness as RS codeword; proof ≈ O(√|C|) field elements; CCS 2017 [[1]](https://eprint.iacr.org/2022/1608) |
| **Ligero++** | 2020 | Improves soundness via proximity testing; 4–10× smaller proofs than Ligero; CCS 2020 [[1]](https://eprint.iacr.org/2020/1439) |
| **Aurora** | 2019 | Extends Ligero's ideas to R1CS circuits with univariate encodings; more general; EUROCRYPT 2019 [[1]](https://eprint.iacr.org/2018/828) |
| **Shockwave** | 2022 | Linear-time Ligero-style prover; builds on Brakedown codes; CRYPTO 2022 [[1]](https://eprint.iacr.org/2022/445) |

**State of the art:** Ligero and Ligero++ are important proof systems for settings requiring post-quantum security with no trusted setup and minimal assumptions. While proof sizes are larger than FRI-based STARKs, they require only hash functions and are simpler to analyse. Aurora generalises Ligero to arbitrary R1CS. See also [MPC-in-the-Head (MPCitH)](categories/04-zero-knowledge-proof-systems.md#mpc-in-the-head-mpcith--vole-in-the-head-voleith) and [Brakedown Polynomial Commitments](#brakedown-polynomial-commitments).


**Production readiness:** Experimental
Ligero and Aurora are implemented in academic prototypes. Shockwave demonstrates linear-time proving. No large-scale production deployment.

**Implementations:**
- [libiop (Aurora/Ligero)](https://github.com/scipr-lab/libiop) ⭐ 178 -- C++, IOP-based proof systems including Aurora and Ligero
- [Shockwave prototype](https://eprint.iacr.org/2022/445) -- Research prototype accompanying the paper

**Security status:** Secure
Security relies only on collision-resistant hash functions (random oracle model). Post-quantum secure. Conservative security assumptions.

**Community acceptance:** Niche
Published at CCS 2017 (Ligero), EUROCRYPT 2019 (Aurora), CCS 2020 (Ligero++). Well-cited in the proof systems literature. Superseded in practice by FRI-based STARKs.

---

## Trapdoor Commitments (Equivocable Commitments)

**Goal:** Controlled equivocability. A commitment scheme that is perfectly binding for everyone, but the holder of a secret trapdoor key can open any commitment to an arbitrary message — "equivocating" after the fact. Trapdoor commitments are a fundamental building block in simulation-based proofs of security: the simulator equivocates commitments to extract witnesses or rewind adversaries without statistical difference.

| Property | Trapdoor Commitment | Standard Commitment |
|----------|--------------------|--------------------|
| **Hiding** | Perfectly hiding (statistical) | Computationally hiding |
| **Binding** | Computationally binding (without trapdoor) | Computationally binding |
| **Equivocability** | Trapdoor holder can open to any value | No party can open to two values |
| **Use in proofs** | Enables simulation: simulator equivocates | Not directly usable in simulation |

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen Trapdoor Commitment** | 1991 | DLP | Trapdoor = discrete log of h w.r.t. g; perfectly hiding, computationally binding; equivocable by trapdoor holder [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Brassard-Chaum-Crépeau** | 1988 | One-way functions | First construction explicitly used for simulation in interactive proofs [[1]](https://dl.acm.org/doi/10.1145/62212.62222) |
| **Trapdoor Hash from Pairings** | 2006 | Bilinear maps | Trapdoor hash enabling homomorphic properties; used in structure-preserving commitments [[1]](https://eprint.iacr.org/2008/453) |
| **Lattice-based Trapdoor Commitment** | 2017 | LWE / SIS | Post-quantum equivocable commitments; trapdoor = short lattice basis [[1]](https://eprint.iacr.org/2017/550) |
| **Structure-Preserving Commitments (SPC)** | 2015 | Pairings | Commitments to group elements verifiable by pairing equations; equivocable; used in anonymous credentials [[1]](https://eprint.iacr.org/2015/684) |

**State of the art:** Pedersen commitments remain the canonical equivocable commitment in the DLP setting — deployed in virtually all simulation-based security proofs for ZK protocols, MPC, and threshold cryptography. Lattice-based trapdoor commitments (2017+) provide post-quantum alternatives. Structure-preserving variants (Abe et al. 2015) enable trapdoor commitments that compose cleanly with pairing-based proof systems. See also [Commitment Schemes](#commitment-schemes) and [Chameleon Hash (Trapdoor Hash)](#chameleon-hash-trapdoor-hash).


**Production readiness:** Production
Pedersen trapdoor commitments are used in virtually all simulation-based security proofs for ZK protocols, MPC, and threshold cryptography deployed in production systems.

**Implementations:**
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k -- Rust, Pedersen commitments (inherently equivocable)
- [arkworks-rs/algebra](https://github.com/arkworks-rs/algebra) ⭐ 854 -- Rust, Pedersen and structure-preserving commitments

**Security status:** Secure
Pedersen trapdoor commitments are computationally binding under DLP, perfectly hiding. Lattice-based variants secure under LWE/SIS. Well-established security properties.

**Community acceptance:** Widely trusted
Foundational primitive used since 1988 (Brassard-Chaum-Crepeau). Pedersen commitments are a textbook construction. Universally accepted in the cryptography community.

---

## Feige-Fiat-Shamir Identification Scheme

**Goal:** Zero-knowledge proof of identity. A prover convinces a verifier that they know a secret (square roots modulo a composite N) without revealing the secret itself or any useful information. Seminal construction bridging commitment-based protocols and practical authentication.

The protocol runs in parallel rounds: the prover commits to random values, the verifier issues a binary challenge vector, and the prover responds with values computed from the secret and the random commitments. The verifier checks consistency using the public key (squares of the secret). Soundness error is 2⁻ᵏ after k rounds; the scheme is honest-verifier zero-knowledge and can be made non-interactive via the [Fiat-Shamir transform](#commitment-schemes).

| Variant | Year | Basis | Note |
|---------|------|-------|------|
| **Fiat-Shamir Identification** | 1986 | RSA / quadratic residues | Two-move simplified version; single-bit challenge per round; CRYPTO 1986 [[1]](https://link.springer.com/article/10.1007/BF02351717) |
| **Feige-Fiat-Shamir (FFS)** | 1988 | RSA / quadratic residues | Multi-secret parallel variant; k-bit challenge per round; reduces rounds needed; CRYPTO 1987 / JoC 1988 [[1]](https://link.springer.com/article/10.1007/BF02351717) |
| **Guillou-Quisquater (GQ)** | 1988 | RSA | Single-round variant using high-exponent RSA; more efficient in communication [[1]](https://link.springer.com/chapter/10.1007/0-387-34799-2_16) |
| **Schnorr Identification** | 1989 | Discrete logarithm | DLP-based alternative; basis of EdDSA and Sigma protocols; see [Sigma Protocols](categories/04-zero-knowledge-proof-systems.md#sigma-protocols) [[1]](https://link.springer.com/article/10.1007/BF00196725) |

**State of the art:** FFS and GQ are of historical importance — superseded in practice by Schnorr-based identification (EdDSA, passkeys) and general-purpose [Sigma Protocols](categories/04-zero-knowledge-proof-systems.md#sigma-protocols). The Fiat-Shamir transform derived from these works remains ubiquitous for making interactive proofs non-interactive. See [[1]](https://link.springer.com/article/10.1007/BF02351717).


**Production readiness:** Deprecated
Historically important but superseded in practice by Schnorr-based identification (EdDSA, FIDO2). The Fiat-Shamir transform derived from this work remains ubiquitous.

**Implementations:**
- [Schnorr identification (libsodium)](https://github.com/jedisct1/libsodium) ⭐ 13k -- C, Schnorr-based identification (successor)

**Security status:** Superseded
FFS and GQ are technically secure under RSA assumptions. However, Schnorr-based schemes offer better efficiency and smaller parameters. The Fiat-Shamir heuristic itself is secure in ROM.

**Community acceptance:** Widely trusted
Seminal work (CRYPTO 1986/1988). The Fiat-Shamir transform is one of the most important techniques in cryptography. FFS itself is of historical importance, superseded by Schnorr.

---

## Polynomial Commitment Scheme Comparison

**Goal:** Structured selection guide. Polynomial commitment schemes (PCS) are the cryptographic core of modern SNARKs — choosing the right one determines proof size, prover speed, verification cost, trusted-setup requirements, and post-quantum safety. This section systematises the main families and their trade-offs.

| Scheme | Basis | Proof size | Verifier cost | Trusted setup | Post-quantum | Representative use |
|--------|-------|-----------|---------------|---------------|--------------|--------------------|
| **KZG** | Pairings (BLS12-381) | O(1) — 1 group element | 1 pairing check | Yes (per-degree SRS) | No | PLONK, Ethereum EIP-4844 [[1]](https://eprint.iacr.org/2010/274) |
| **FRI** | Hash + Reed-Solomon codes | O(log² n) | O(log² n) hash checks | No (transparent) | Yes | STARKs, Plonky2, Polygon zkEVM [[1]](https://eprint.iacr.org/2018/046) |
| **IPA (Bulletproofs)** | Discrete log (Pedersen) | O(log n) group elements | O(n) scalar mults | No (transparent) | No | Halo2, Zcash Orchard [[1]](https://eprint.iacr.org/2017/1066) |
| **Dory** | Pairings (inner-pairing product) | O(log n) | O(log n) pairing ops | No (transparent) | No | Multilinear PCS research [[1]](https://eprint.iacr.org/2020/1274) |
| **Brakedown / Orion** | Hash + linear codes | O(√n) | O(√n) | No (transparent) | Yes | Binius, linear-time zkVM backends [[1]](https://eprint.iacr.org/2021/1043) |
| **Zeromorph** | KZG (univariate reduction) | O(1) | O(log n) + 1 pairing | Yes (reuses KZG SRS) | No | HyperPlonk, multilinear SNARKs [[1]](https://eprint.iacr.org/2023/917) |

Key trade-off axes:

- **Proof size vs. verifier cost:** KZG achieves the smallest proofs (O(1)) but requires a pairing. FRI avoids pairings at the cost of O(log² n) proofs.
- **Trusted setup:** KZG and Zeromorph require a structured reference string (SRS) with toxic waste; all hash-based schemes (FRI, Brakedown) and DL-based IPA are transparent.
- **Post-quantum safety:** Only hash-based schemes (FRI, Brakedown, Ligero) are conjectured post-quantum secure; pairing- and DL-based schemes are broken by Shor's algorithm.
- **Multilinear vs. univariate:** IPA, Dory, Zeromorph, and Brakedown naturally support multilinear polynomials; KZG and FRI are natively univariate (multilinear extensions require extra work).

**State of the art:** KZG dominates production SNARKs (PLONK, Groth16-derived systems) and Ethereum's data availability layer. FRI underpins the STARK ecosystem (StarkWare, Polygon). IPA-based Halo2 serves Zcash and EVM-compatible chains without a trusted setup. Dory and Zeromorph are the leading transparent and KZG-reusing multilinear PCS respectively. See [KZG Polynomial Commitments](#kzg-polynomial-commitments), [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment), [Multilinear Polynomial Commitments](#multilinear-polynomial-commitments), and [Brakedown Polynomial Commitments](#brakedown-polynomial-commitments).


**Production readiness:** Production
This is a comparison section; the individual PCS schemes (KZG, FRI, IPA, etc.) are each deployed in production systems as described in their respective sections.

**Implementations:**
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 -- Rust, unified PCS interface with KZG, IPA, and multilinear implementations
- [blst](https://github.com/supranational/blst) ⭐ 554 -- C/Rust, KZG backend
- [plonky2](https://github.com/0xPolygonZero/plonky2) ⭐ 856 -- Rust, FRI-based PCS for recursive proofs
- [halo2](https://github.com/zcash/halo2) ⭐ 895 -- Rust, IPA-based PCS for PLONK

**Security status:** Secure
Each PCS family is secure under its respective assumptions (d-SDH for KZG, DLOG for IPA, CRH for FRI/Brakedown). Trade-offs are in setup trust, proof size, and post-quantum safety.

**Community acceptance:** Widely trusted
All listed PCS families are published at top venues and deployed in production. The comparison reflects established community consensus on trade-offs.

---

## Threshold VRF and Distributed Randomness

**Goal:** Unbiasable, publicly verifiable randomness from a threshold of signers. A single VRF signer can abort or bias output by choosing whether to publish. Threshold VRF (DVRF / PVRF) requires t-of-n nodes to cooperate; no single node can predict or withhold the output, and the result is verifiable by anyone. The canonical application is a decentralised randomness beacon for blockchain consensus, leader election, and on-chain lotteries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DVRF (Galindo et al.)** | 2020 | DKG + BLS | First formal threshold VRF; t-of-n BLS signature as VRF; unpredictable until threshold reached [[1]](https://eprint.iacr.org/2020/096) |
| **GLOW-DVRF** | 2020 | Pairing-based DKG | Non-interactive DVRF; avoids interactive DKG; assumes DKG public key known [[1]](https://eprint.iacr.org/2020/096) |
| **Dfinity / BLS Threshold Signature Beacon** | 2018 | Threshold BLS over BLS12-381 | ICP / Dfinity random beacon; threshold BLS signature on round number; O(1) proof [[1]](https://eprint.iacr.org/2018/601) |
| **Pedersen DKG + ECVRF** | 2023 | DKG (Pedersen) + ECVRF (RFC 9381) | Threshold ECVRF; RFC 9381-compatible; used in research prototypes [[1]](https://eprint.iacr.org/2023/1682) |
| **CHURP** | 2019 | Proactive secret sharing + VRF | Resharing-friendly threshold VRF; tolerates churn in the committee [[1]](https://eprint.iacr.org/2019/017) |

Construction blueprint: (1) Run a [DKG](categories/05-secret-sharing-threshold-cryptography.md#distributed-key-generation-dkg) to establish a shared public key; (2) each node applies its key share to the round input (a beacon epoch number or block hash); (3) shares are combined with Lagrange interpolation to yield the VRF output; (4) anyone verifies using the shared public key.

**State of the art:** BLS threshold signatures (Dfinity/ICP, drand) are the dominant production approach — short proofs, efficient aggregation, and well-studied DKG protocols. GLOW-DVRF and CHURP address the resharing and committee-churn problem. Related to [Verifiable Random Functions (VRF)](#verifiable-random-functions-vrf), [DKG](categories/05-secret-sharing-threshold-cryptography.md#distributed-key-generation-dkg), and [drand / League of Entropy](#drand--league-of-entropy-randomness-beacon).


**Production readiness:** Production
BLS threshold VRF deployed in ICP (Dfinity) and drand (League of Entropy). CHURP used in research prototypes for committee resharing.

**Implementations:**
- [drand](https://github.com/drand/drand) ⭐ 813 -- Go, threshold BLS randomness beacon
- [CHURP prototype](https://eprint.iacr.org/2019/017) -- Research prototype for proactive resharing VRF

**Security status:** Secure
Threshold BLS VRF security proven under co-CDH in the random oracle model with t-of-n threshold. Unbiasable as long as fewer than t nodes are compromised.

**Community acceptance:** Widely trusted
Deployed by major organisations (Cloudflare, DFINITY, Protocol Labs). Strong peer review. DVRF formalised at eprint 2020/096.

---

## drand / League of Entropy Randomness Beacon

**Goal:** Production-grade decentralised public randomness. drand (Distributed Randomness) is an open network of independent nodes that jointly produce bias-resistant, publicly verifiable random values at regular intervals using threshold BLS signatures. The League of Entropy is the consortium of organisations (Cloudflare, Protocol Labs, Ethereum Foundation, EPFL, University of Chile, and others) operating the drand network since 2020.

| Property | Value |
|----------|-------|
| **Protocol** | Threshold BLS (t-of-n) over BLS12-381 |
| **Beacon period** | 3 seconds (default chain); 30 seconds (unchained mode) |
| **Proof size** | 1 BLS group element (48 bytes) — constant |
| **Verification** | Single pairing check against group public key |
| **Bias resistance** | t honest nodes sufficient to produce unbiased output |
| **Unpredictability** | Output for round r unpredictable until threshold nodes contribute |
| **Unchained mode** | Each beacon independently verifiable without prior chain (2022+) |

| Component | Detail |
|-----------|--------|
| **DKG phase** | Pedersen DKG (or resharing) establishes shared BLS key across nodes [[1]](https://eprint.iacr.org/2023/728) |
| **Randomness generation** | Each node signs round number; t partial sigs aggregated to full BLS sig [[1]](https://eprint.iacr.org/2023/728) |
| **Public API** | `https://drand.cloudflare.com/` — JSON endpoint returning (round, randomness, signature) [[1]](https://drand.love/) |
| **Filecoin integration** | Filecoin uses drand beacons as the chain's randomness source for leader election [[1]](https://spec.filecoin.io/#section-libraries.drand) |
| **Timelock encryption** | tlock scheme (2023): encrypt to future drand round; decrypt only when beacon is published [[1]](https://eprint.iacr.org/2023/189) |

**State of the art:** drand is the most widely deployed decentralised randomness beacon in production — integrated into Filecoin, used by Ethereum research, and publicly accessible. The 2023 unchained mode makes each beacon epoch independently verifiable, improving resilience. The tlock timelock encryption scheme (CRYPTO 2023) demonstrates that drand's BLS structure enables identity-based encryption to future beacon values. Related to [Threshold VRF and Distributed Randomness](#threshold-vrf-and-distributed-randomness), [Randomness Beacons / Coin Tossing](#randomness-beacons--coin-tossing), and [Delay Encryption](#delay-encryption).


**Production readiness:** Production
Production-grade decentralised randomness beacon operated by Cloudflare, Protocol Labs, EPFL, and others since 2020. Public API at drand.cloudflare.com. Integrated into Filecoin.

**Implementations:**
- [drand](https://github.com/drand/drand) ⭐ 813 -- Go, production beacon software
- [drand-client](https://github.com/drand/drand-client) ⭐ 63 -- JavaScript/Go, client libraries for consuming drand beacons
- [tlock](https://github.com/drand/tlock) ⭐ 634 -- Go, timelock encryption using drand

**Security status:** Secure
Threshold BLS over BLS12-381 with Pedersen DKG. Unbiasable with t honest nodes. Unchained mode (2022) eliminates chain dependency. Audited by third parties.

**Community acceptance:** Widely trusted
Operated by consortium of major organisations. Peer-reviewed protocol (eprint 2023/728). Integrated into Filecoin consensus. Public and freely accessible.

---

## Aurora and Fractal (Recursive IOP-Based Proof Systems)

**Goal:** Transparent, succinct proof systems for general arithmetic circuits with recursive proof composition. Aurora is a zkSNARK built on algebraic IOPs (AIPs) and Reed-Solomon codes — achieving O(log² |C|) proof size for R1CS circuits with no trusted setup. Fractal extends Aurora with a holographic preprocessing technique enabling efficient recursive proof composition: a proof system that can efficiently verify its own proofs, enabling proof-carrying data (PCD) and incrementally verifiable computation (IVC) without pairing-based SNARKs.

| Property | Aurora | Fractal |
|----------|--------|---------|
| **Circuit representation** | R1CS | R1CS (holographic) |
| **Proof size** | O(log² |C|) field elements | O(log² |C|) field elements |
| **Verifier cost** | O(log² |C|) | O(log² |C|) |
| **Trusted setup** | None (transparent) | None (transparent) |
| **Post-quantum** | Yes (hash-based) | Yes (hash-based) |
| **Recursive composition** | Not directly | Yes — verifier circuit is small; enables PCD |
| **Underlying technique** | Univariate sumcheck + RS code proximity | Holographic IOP + RS codes |

| Scheme | Year | Note |
|--------|------|------|
| **Aurora (Ben-Sasson et al.)** | 2019 | O(log² n) transparent zkSNARK for R1CS; uses RS-encoded witness + univariate sumcheck; EUROCRYPT 2019 [[1]](https://eprint.iacr.org/2018/828) |
| **Fractal (Chiesa et al.)** | 2020 | Holographic IOP enabling recursive SNARKs without pairings; verifier is O(log² n) and can itself be proved; EUROCRYPT 2020 [[1]](https://eprint.iacr.org/2019/1076) |
| **Ligero (predecessor)** | 2017 | Earlier RS-based transparent proof system; see [Ligero / Ligero++](#ligero--ligero-mpc-in-the-head-commitments) [[1]](https://eprint.iacr.org/2022/1608) |

**State of the art:** Aurora established that transparent, polylogarithmic-communication SNARKs for R1CS are achievable purely from algebraic coding theory and hash functions — without the trusted setups of Groth16/PLONK or the large proofs of Ligero. Fractal's holographic IOP was the first to enable efficient recursive composition in the transparent/post-quantum setting, predating Nova's folding-scheme approach. Both are primarily of theoretical and research importance today — practical recursive SNARKs have moved toward folding schemes (Nova, HyperNova) for prover efficiency. See [Ligero / Ligero++](#ligero--ligero-mpc-in-the-head-commitments), [Verifiable Computation (VC)](#verifiable-computation-vc), and [Proof-Carrying Data / IVC](categories/04-zero-knowledge-proof-systems.md#proof-carrying-data-pcd--incrementally-verifiable-computation-ivc).


**Production readiness:** Research
Primarily of theoretical importance. Aurora and Fractal established foundational results but have been superseded in practice by folding schemes (Nova, HyperNova) and FRI-based STARKs.

**Implementations:**
- [libiop (scipr-lab)](https://github.com/scipr-lab/libiop) ⭐ 178 -- C++, reference implementation of Aurora and related IOP-based proof systems

**Security status:** Secure
Security relies on collision-resistant hash functions and Reed-Solomon proximity testing. Post-quantum secure. Information-theoretic soundness for the IOP component.

**Community acceptance:** Niche
Published at EUROCRYPT 2019 (Aurora) and EUROCRYPT 2020 (Fractal). Well-cited in the proof systems literature. Superseded in practice by more efficient constructions.

---

## Commit-and-Prove SNARKs (LegoSNARK)

**Goal:** Composable proof systems with shared committed witnesses. A commit-and-prove (CP) SNARK allows a prover to (1) commit to a witness w using a standard commitment scheme, then (2) prove arbitrary statements about w in zero knowledge — with the commitment serving as the interface between independently designed proof components. LegoSNARK (Campanelli et al., 2019) is the first formal framework for composing CP-SNARKs, enabling modular proof system design: different sub-proofs share witnesses via commitments without recomputing the entire relation.

| Property | Value |
|----------|-------|
| **Core idea** | Decouple commitment from proof; commitment is the "glue" between proof modules |
| **Composability** | Proofs for sub-relations sharing committed witness can be combined without trusted setup per combination |
| **Commitment scheme** | Any extractable commitment (Pedersen, KZG, etc.) |
| **Link soundness** | Extractability of the commitment ensures the same witness underlies all proofs |
| **Applications** | Privacy-preserving credentials, anonymous payments, range proofs over committed values |

| Scheme | Year | Note |
|--------|------|------|
| **LegoSNARK (Campanelli et al.)** | 2019 | Formal framework for CP-SNARKs; defines link soundness; toolkit of composable CP proof components; CCS 2019 [[1]](https://eprint.iacr.org/2019/142) |
| **LegoGro16** | 2019 | Groth16-based CP-SNARK component in LegoSNARK; prover-efficient; constant-size proof [[1]](https://eprint.iacr.org/2019/142) |
| **CP-SNARK from Pedersen** | 2019 | Transparent CP component; uses Pedersen commitments; compatible with range proofs and set membership [[1]](https://eprint.iacr.org/2019/142) |
| **Snarky Ceremonies (Straka et al.)** | 2021 | Applies CP-SNARK ideas to ceremony transcripts; prove properties of MPC outputs without revealing secrets [[1]](https://eprint.iacr.org/2021/219) |
| **Darlin** | 2022 | CP-SNARK for recursive proof composition using Marlin; enables IVC with commit-and-prove interface; used in Horizen research [[1]](https://eprint.iacr.org/2021/930) |

**State of the art:** LegoSNARK (CCS 2019) is the canonical framework for modular CP-SNARK design. The core abstraction — commit once, prove many statements — is now standard practice in privacy-preserving credential and payment systems. Practical deployments combine Pedersen commitments (for homomorphic range checks) with Groth16 or Plonk sub-proofs for application logic. The Darlin system (2022) demonstrates recursive proof composition via CP-SNARKs without pairings. See also [Commitment Schemes](#commitment-schemes), [Verifiable Computation (VC)](#verifiable-computation-vc), and [Trapdoor Commitments](#trapdoor-commitments-equivocable-commitments).


**Production readiness:** Experimental
LegoSNARK framework implemented in research prototypes. The commit-and-prove paradigm is now standard practice in privacy systems, though often without explicit LegoSNARK tooling.

**Implementations:**
- [LegoSNARK (Campanelli et al.)](https://github.com/imdea-software/legosnark) ⭐ 43 -- Rust/C++, original LegoSNARK framework implementation

**Security status:** Secure
Link soundness proven under extractability of the underlying commitment scheme. Inherits security of component SNARKs (Groth16, Marlin). No known attacks.

**Community acceptance:** Emerging
Published at CCS 2019. The commit-and-prove abstraction is widely adopted in principle. Explicit LegoSNARK usage is growing in privacy-preserving credential and payment systems.

---

## Greyhound / Labrador (Lattice-Based Polynomial Commitments)

**Goal:** Efficient, post-quantum polynomial commitments from standard lattice assumptions. Labrador (2023) and its successor Greyhound (2024) provide the first practical lattice-based polynomial commitment schemes competitive with pairing- and hash-based alternatives — enabling ZK proofs for large arithmetic circuits without pairings, with security reducible to Module-SIS and Module-LWE.

| Property | Value |
|----------|-------|
| **Security basis** | Module-SIS / Module-LWE (structured lattices, ring variants) |
| **Setup** | Transparent — no trusted setup, no toxic waste |
| **Post-quantum** | Yes — based on worst-case lattice hardness |
| **Homomorphism** | Additively homomorphic commitments to polynomial vectors |
| **Proof size** | Labrador: O(√n) — Greyhound: logarithmic (amortized) |
| **Applications** | Lattice-based SNARKs, ZK proofs for NTRU/Dilithium statements |

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Labrador (Beullens et al.)** | 2023 | Module-SIS | First practical lattice-based polynomial commitment; O(√n) proofs; amortised over many openings; CRYPTO 2023 [[1]](https://eprint.iacr.org/2022/1341) |
| **Greyhound (Fenzi et al.)** | 2024 | Module-SIS + folding | Extends Labrador with a folding-style reduction; logarithmic-size proofs; CRYPTO 2024 [[1]](https://eprint.iacr.org/2024/1396) |
| **SLAP (Esgin et al.)** | 2024 | Module-LWE + ajtai | Scales to large witness sets; suitable for lattice-based credential systems [[1]](https://eprint.iacr.org/2024/1287) |

**State of the art:** Greyhound (CRYPTO 2024) is the state-of-the-art lattice polynomial commitment, achieving logarithmic proof sizes from standard Module-SIS — a milestone for post-quantum verifiable computation. Labrador underpins real-world lattice ZK proofs for statements about NTRU and Dilithium keys. Both are transparent and require no structured reference string, distinguishing them from pairing-based KZG. See also [BDLOP Lattice Commitments](#bdlop-lattice-commitments), [Multilinear Polynomial Commitments](#multilinear-polynomial-commitments), and [Functional Commitments](#functional-commitments).


**Production readiness:** Research
Academic constructions with reference prototypes. Greyhound (CRYPTO 2024) is the state of the art but not yet deployed in production systems.

**Implementations:**
- [Labrador prototype](https://eprint.iacr.org/2022/1341) -- Research prototype; Rust/C++, lattice polynomial commitment
- [latticefold](https://github.com/NethermindEth/latticefold) ⭐ 126 -- Rust, lattice-based folding using Labrador-style commitments

**Security status:** Secure
Security reduces to Module-SIS (standard lattice assumption with worst-case hardness). Post-quantum secure. Conservative security parameters.

**Community acceptance:** Emerging
Published at CRYPTO 2023 (Labrador) and CRYPTO 2024 (Greyhound). Endorsed by leading lattice cryptographers (Beullens, Fenzi). Milestone for post-quantum verifiable computation.

---

## Updatable Trusted Setup Ceremonies (Sonic / Marlin)

**Goal:** Reduce trust in universal SNARK setups. A universal structured reference string (SRS) can be used across many circuits, but still requires at least one honest participant during generation. Updatable setups (Sonic, Marlin, PLONK) allow anyone to contribute randomness and update the SRS at any time — so the setup is secure as long as any single contributor was honest, even if all others collude. This turns a one-time trusted setup into an ongoing public ceremony.

| Property | Standard SRS | Updatable SRS |
|----------|-------------|---------------|
| **Security requirement** | One honest participant among original set | One honest participant among *all* contributors, past or future |
| **Transparency** | Fixed set of participants | Anyone can contribute at any time |
| **Trust model** | Trust the MPC ceremony | Trust any single historical contributor |
| **Example** | Groth16 per-circuit setup | Sonic, Marlin, PLONK universal SRS |

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Sonic (Maller et al.)** | 2019 | Pairings + updatable SRS | First universal, updatable SNARK; polylogarithmic proofs; CRYPTO 2019 [[1]](https://eprint.iacr.org/2019/099) |
| **Marlin (Chiesa et al.)** | 2020 | Algebraic holographic proofs + KZG | Universal and updatable; linear-time prover; basis of many production systems; EUROCRYPT 2020 [[1]](https://eprint.iacr.org/2019/1047) |
| **PLONK (Gabizon et al.)** | 2019 | KZG + permutation argument | Universal and updatable SRS; one setup for all circuits of bounded size; widely adopted [[1]](https://eprint.iacr.org/2019/953) |
| **Powers of Tau (Bowe et al.)** | 2017 | Multi-party computation | Practical MPC ceremony producing a KZG SRS; used in Zcash, Ethereum EIP-4844 [[1]](https://eprint.iacr.org/2017/1050) |
| **Perpetual Powers of Tau** | 2019 | Ongoing Powers of Tau | Open ceremony; 100+ contributors; reusable across many projects [[1]](https://github.com/weijiekoh/perpetualpowersoftau) |

**State of the art:** PLONK and Marlin are the dominant universal, updatable SNARKs in production — deployed in Aztec, Scroll, Polygon zkEVM, and Aleo. The Ethereum community's Powers of Tau ceremony (thousands of contributors) provides the most widely trusted KZG SRS available. Updatability eliminates the "single ceremony" trust bottleneck of Groth16, at the cost of larger proof sizes. See also [KZG Polynomial Commitments](#kzg-polynomial-commitments) and [Verifiable Computation (VC)](#verifiable-computation-vc).


**Production readiness:** Production
PLONK and Marlin are deployed at scale in Aztec, Scroll, Polygon zkEVM, and Aleo. Powers of Tau ceremony used by Zcash, Ethereum EIP-4844, and many ZK projects.

**Implementations:**
- [snarkjs (iden3)](https://github.com/iden3/snarkjs) ⭐ 2.0k -- JavaScript, PLONK with universal setup
- [arkworks-rs/marlin](https://github.com/arkworks-rs/marlin) ⭐ 323 -- Rust, Marlin universal SNARK
- [aztec-packages](https://github.com/AztecProtocol/aztec-packages) ⭐ 435 -- C++/TypeScript, PLONK with updatable SRS
- [perpetualpowersoftau](https://github.com/weijiekoh/perpetualpowersoftau) ⭐ 135 -- Ongoing open ceremony for KZG SRS generation

**Security status:** Secure
Security requires at least one honest participant across all ceremony contributors (past and future). Ethereum's Powers of Tau had thousands of independent contributors, providing strong security guarantees.

**Community acceptance:** Standard
PLONK and Marlin published at EUROCRYPT 2020. Universally adopted by ZK-rollup teams. Powers of Tau is the most widely trusted MPC ceremony in blockchain cryptography.

---

## MiMC and GMiMC (Minimal Multiplicative Complexity Hashes)

**Goal:** Arithmetic-friendly hash functions with the fewest possible multiplicative operations. Standard hash functions (SHA-256, Keccak) require thousands of multiplications when verified inside an arithmetic circuit — making ZK proofs expensive. MiMC (Albrecht et al., 2016) minimises the number of field multiplications by using a simple cube map x³ as the round function, resulting in a hash that is dramatically cheaper to prove in SNARKs and STARKs. GMiMC generalises this to larger Feistel networks for improved throughput.

| Property | Value |
|----------|-------|
| **Round function** | x³ (or xᵉ for gcd(e, p−1) = 1) over a prime field |
| **Multiplicative complexity** | O(log p) multiplications (vs. O(p) for SHA-256 in circuits) |
| **Field** | Prime fields Fₚ; also binary fields for MiMC-2n/n |
| **Security** | Algebraic attacks; requires ≥ ⌈log₃ p⌉ rounds for security |
| **Applications** | Commitment hashing inside SNARKs, ZK-friendly Merkle trees |

| Variant | Year | Note |
|---------|------|------|
| **MiMC (Albrecht et al.)** | 2016 | First minimal-multiplicative-complexity block cipher / hash; cube map rounds; ASIACRYPT 2016 [[1]](https://eprint.iacr.org/2016/492) |
| **GMiMC (Albrecht et al.)** | 2019 | Generalised MiMC using Feistel structure; higher throughput; more efficient for large input sizes [[1]](https://eprint.iacr.org/2019/397) |
| **MiMC-Feistel / MiMCHash** | 2016 | Sponge construction using MiMC as the permutation; direct hash function [[1]](https://eprint.iacr.org/2016/492) |
| **HadesMiMC / Poseidon (successor)** | 2019 | Replaces uniform cube-map rounds with partial-full round structure; see [Poseidon](#snark-friendly-hash-functions-poseidon--rescue) [[1]](https://eprint.iacr.org/2019/458) |

**State of the art:** MiMC and GMiMC are foundational ZK-friendly hash functions — widely used in 2018–2021 for SNARK Merkle trees. They have been largely superseded by Poseidon (which offers better performance and security margins) and Rescue (which offers stronger security proofs). MiMC remains relevant as the simplest possible algebraic hash and as a reference design for algebraic cryptanalysis. Related to [SNARK-Friendly Hash Functions](#snark-friendly-hash-functions-poseidon--rescue) and [Commitment Schemes](#commitment-schemes).


**Production readiness:** Mature
Deployed in early ZK systems (2018-2021) for SNARK Merkle trees. Largely superseded by Poseidon in new deployments but still operational in existing systems.

**Implementations:**
- [circomlib MiMC](https://github.com/iden3/circomlib) ⭐ 735 -- Circom, MiMC hash circuits for SNARKs
- [ethsnarks MiMC](https://github.com/HarryR/ethsnarks) ⭐ 241 -- Python/Solidity, MiMC for Ethereum ZK applications

**Security status:** Caution
Requires careful parameter selection (sufficient rounds for algebraic attack resistance). Several algebraic attacks studied (Grobner basis, interpolation). Poseidon and Rescue offer better security margins.

**Community acceptance:** Widely trusted
Published at ASIACRYPT 2016. Widely cited and well-analysed. Superseded by Poseidon but historically important and still accepted for legacy deployments.

---

## SNARK-Friendly Hash Functions (Poseidon / Rescue)

**Goal:** Hash functions optimised for evaluation inside arithmetic circuits. When hashing is performed inside a SNARK or STARK, the number of field multiplications dominates proving cost. Poseidon and Rescue replace conventional bitwise operations (XOR, AND) with algebraic operations over prime fields, achieving 50–100× fewer constraints than SHA-256 inside a circuit — while maintaining 128-bit security. They are the standard commitment hashes in modern zkVM and zk-rollup systems.

| Property | Poseidon | Rescue |
|----------|----------|--------|
| **Round function** | S-box: xᵅ (partial-full round structure, HadesMiMC) | S-box: xᵅ and x^(1/α) alternating |
| **Security proof** | Statistical (wide-pipe) + algebraic bounds | Provable security in the ideal permutation model |
| **Constraint count** | ~200–300 R1CS constraints for 254-bit field | ~250–400 constraints |
| **Field** | Prime fields (Fₚ); binary-field variant Poseidon2 | Prime fields Fₚ |
| **Main use** | zkSNARK Merkle trees, ZK-friendly commitments | Provable-security ZK hashing |

| Scheme | Year | Note |
|--------|------|------|
| **Poseidon (Grassi et al.)** | 2021 | Partial-full round S-box; fewest constraints per output bit of any secure hash; adopted by Zcash Orchard, StarkNet, Filecoin, Miden [[1]](https://eprint.iacr.org/2019/458) |
| **Poseidon2 (Grassi et al.)** | 2023 | Optimised for binary/hybrid field circuits; ~2× faster than Poseidon in Plonky3 / SP1 [[1]](https://eprint.iacr.org/2023/323) |
| **Rescue (Aly et al.)** | 2020 | Alternating forward/inverse S-box; provable security in the random permutation model; used in Polygon Miden, AirScript [[1]](https://eprint.iacr.org/2020/1143) |
| **Rescue-Prime (Starkad variant)** | 2020 | Simplified Rescue with security proofs; used in Winterfell / STARK systems [[1]](https://eprint.iacr.org/2020/1143) |
| **Tip5 / Griffin** | 2022 | Newer algebraic hashes exploring lookup-friendly round functions; used in Plonky2 research [[1]](https://eprint.iacr.org/2022/1155) |

**State of the art:** Poseidon is the dominant ZK-friendly hash function in production — used in Zcash Orchard, StarkNet Pedersen/Poseidon Merkle trees, Filecoin, Miden VM, and many rollups. Poseidon2 (2023) improves throughput for binary-field circuit backends (SP1, Plonky3). Rescue provides stronger provable-security guarantees and is preferred in formal-verification contexts. Both families are orders of magnitude more circuit-efficient than SHA-256 or Keccak for ZK applications. Related to [MiMC and GMiMC](#mimc-and-gmimc-minimal-multiplicative-complexity-hashes) and [Commitment Schemes](#commitment-schemes).


**Production readiness:** Production
Poseidon deployed in Zcash Orchard, StarkNet, Filecoin, Miden VM, and numerous ZK-rollups. Rescue used in Polygon Miden and Winterfell STARK prover.

**Implementations:**
- [circomlib Poseidon](https://github.com/iden3/circomlib) ⭐ 735 -- Circom, Poseidon circuits
- [rescue-prime (Winterfell)](https://github.com/facebook/winterfell) ⭐ 888 -- Rust, Rescue-Prime in STARK prover

**Security status:** Secure
Poseidon designed with wide security margins (partial-full round structure). Rescue has provable security in the ideal permutation model. Active cryptanalysis community; no practical attacks found.

**Community acceptance:** Widely trusted
Poseidon published at USENIX Security 2021. Adopted by all major ZK ecosystems. Rescue published at eprint with formal security analysis. Both endorsed by leading ZK researchers.

---

## Pedersen Commitments in Ristretto255 and the Dalek Library

**Goal:** Constant-time, cofactor-free elliptic curve commitments for production cryptographic libraries. Pedersen commitments require a prime-order group to maintain binding security — but Curve25519 (used in X25519 and Ed25519) has cofactor 8, complicating group operations. Ristretto255 is a prime-order group constructed from Curve25519 by quotienting out the cofactor, exposing a clean prime-order interface. The `curve25519-dalek` Rust library implements Ristretto255, Pedersen commitments, and Bulletproofs in constant time, providing the canonical production implementation for privacy-preserving protocols.

| Property | Value |
|----------|-------|
| **Curve** | Ristretto255 — prime-order quotient of Curve25519 |
| **Group order** | ℓ ≈ 2²⁵² + 27742317777372353535851937790883648493 |
| **Cofactor** | 1 (prime-order: no cofactor issues) |
| **Constant-time** | Yes — all scalar multiplications use fixed-time algorithms |
| **Commitment** | C = m·G + r·H where G, H are independent generators |
| **Binding assumption** | Discrete logarithm (DLOG) in Ristretto255 |
| **Hiding** | Perfectly hiding (uniform blinding factor r) |

| Component | Year | Note |
|-----------|------|-------|
| **Ristretto255 (Hamburg)** | 2015 | Prime-order abstraction over Curve25519 / Ed448-Goldilocks; eliminates cofactor attack surface; IETF draft [[1]](https://ristretto.group/) |
| **curve25519-dalek (Lovecruft / de Valence)** | 2017 | Rust library; constant-time Ed25519 / Ristretto255 / Pedersen / Bulletproofs; used in Signal, Zcash, Grin [[1]](https://github.com/dalek-cryptography/curve25519-dalek) |
| **bulletproofs crate (dalek)** | 2018 | Bulletproofs range proofs and R1CS proofs over Ristretto255; used in Grin, Interledger, and research [[1]](https://github.com/dalek-cryptography/bulletproofs) |
| **Merlin transcript** | 2018 | Fiat-Shamir transcript abstraction used by dalek Bulletproofs; domain-separated, sponge-based; composable [[1]](https://merlin.cool/) |

**State of the art:** Ristretto255 is the recommended prime-order group for new Curve25519-based protocols — adopted in IETF drafts, Tor's onion service v3 cryptography, and Signal research. The `curve25519-dalek` crate (audited, constant-time) is the reference implementation for Pedersen commitments and Bulletproofs in the Rust ecosystem. Grin (MimbleWimble) and several academic prototypes use the dalek Bulletproofs crate directly for confidential transaction range proofs. See also [Commitment Schemes](#commitment-schemes), [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment), and [Range Proofs](#range-proofs).


**Production readiness:** Production
curve25519-dalek is used in production by Grin, Signal (research), Zcash libraries, and numerous Rust cryptographic projects. Ristretto255 adopted in IETF drafts and Tor.

**Implementations:**
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k -- Rust, constant-time Ristretto255 and Pedersen commitments; audited
- [bulletproofs (dalek)](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k -- Rust, Bulletproofs over Ristretto255
- [Merlin](https://github.com/dalek-cryptography/merlin) ⭐ 131 -- Rust, Fiat-Shamir transcript framework

**Security status:** Secure
Ristretto255 provides prime-order group semantics over Curve25519, eliminating cofactor attacks. Constant-time implementation prevents side-channel attacks. DLOG security at ~128-bit level.

**Community acceptance:** Standard
Ristretto255 is an IETF draft standard. curve25519-dalek is the de-facto Rust cryptographic library for Curve25519 operations. Audited and widely trusted.

---

## FRI-Based Polynomial Commitments

**Goal:** Transparent, post-quantum polynomial commitment from Reed-Solomon proximity testing. FRI (Fast Reed-Solomon IOP of Proximity) is the commitment engine inside STARKs: a prover encodes a polynomial as a Reed-Solomon codeword, then proves it is close to a low-degree polynomial via a logarithmic folding protocol — with no trusted setup, only collision-resistant hash functions.

| Variant | Year | Note |
|---------|------|------|
| **FRI (Ben-Sasson, Bentov, Horesh, Riabzev)** | 2018 | Original FRI protocol; O(log N) prover/verifier; basis of STARKs; ICALP 2018 [[1]](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ICALP.2018.14) |
| **STARK polynomial commitment** | 2018 | Applies FRI as PCS inside a transparent SNARK; eprint 2018/046 [[1]](https://eprint.iacr.org/2018/046) |
| **DEEP-FRI** | 2020 | Improves soundness via domain extension and purification; used in production STARK provers [[1]](https://eprint.iacr.org/2019/336) |
| **Proximity Gaps (Ben-Sasson et al.)** | 2020 | Tight soundness analysis for FRI via proximity gaps for RS codes [[1]](https://eccc.weizmann.ac.il/report/2020/083/) |
| **Plonky2 / FRI over Goldilocks** | 2022 | FRI over 64-bit Goldilocks field for fast recursive proofs; Polygon Zero [[1]](https://github.com/0xPolygonZero/plonky2) |

**State of the art:** FRI underlies all STARK-based proof systems (StarkWare, Polygon zkEVM, RISC Zero, Plonky2). Transparent (no trusted setup) and post-quantum (hash-only). Proof size is O(log² d) — larger than KZG's O(1) but with no toxic waste. DEEP-FRI is the standard in production. See [KZG Polynomial Commitments](#kzg-polynomial-commitments) and [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment).


**Production readiness:** Production
FRI is deployed in all STARK-based proof systems: StarkWare (StarkEx, StarkNet), Polygon zkEVM, RISC Zero, and Plonky2. Billions of dollars secured by FRI-based proofs.

**Implementations:**
- [stone-prover (StarkWare)](https://github.com/starkware-libs/stone-prover) ⭐ 268 -- C++, production STARK prover with DEEP-FRI
- [plonky2](https://github.com/0xPolygonZero/plonky2) ⭐ 856 -- Rust, FRI over Goldilocks field for recursive proofs
- [risc0](https://github.com/risc0/risc0) ⭐ 2.1k -- Rust, RISC-V zkVM using FRI-based STARKs
- [winterfell](https://github.com/facebook/winterfell) ⭐ 888 -- Rust, STARK prover/verifier with FRI

**Security status:** Secure
Security relies on collision-resistant hash functions and Reed-Solomon proximity gaps. Post-quantum secure. DEEP-FRI (2020) provides tight soundness analysis. Conservative assumptions.

**Community acceptance:** Widely trusted
Published at ICALP 2018. Foundation of the STARK ecosystem endorsed by StarkWare, Polygon, and RISC Zero. Extensive peer review and production track record.

---

## Verkle Trees

**Goal:** Stateless-client-friendly authenticated data structure replacing Merkle trees with vector commitments (IPA/Pedersen), enabling a wide 256-ary branching factor with constant-size proofs per level — reducing Ethereum state witnesses from ~1 KB to ~150 bytes.

| Variant | Year | Note |
|---------|------|------|
| **Verkle Trees (Kuszmaul)** | 2018 | First proposal using polynomial commitments as tree nodes; MIT PRIMES 2018 [[1]](https://math.mit.edu/research/highschool/primes/materials/2018/Kuszmaul.pdf) |
| **Ethereum Verkle Tree** | 2021 | Vitalik Buterin design; IPA over Bandersnatch curve; 256-ary branching; "The Verge" roadmap [[1]](https://vitalik.eth.limo/general/2021/06/18/verkle.html) |
| **Ethereum Verkle trie structure** | 2021 | EF Blog formalisation of the trie structure [[1]](https://blog.ethereum.org/2021/12/02/verkle-tree-structure) |

**State of the art:** Verkle trees are the centrepiece of Ethereum's "The Verge" upgrade. Production design uses IPA over Bandersnatch curve (transparent, no trusted setup). Cross-path proof aggregation yields a single compact proof for an entire block's state witness. Related to [Vector Commitments](#vector-commitments), [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment), and [Accumulators](#accumulators).


**Production readiness:** Experimental
Centrepiece of Ethereum's 'The Verge' upgrade roadmap. Active development by Ethereum Foundation and client teams. Not yet deployed on mainnet.

**Implementations:**
- [go-ipa (Ethereum)](https://github.com/crate-crypto/go-ipa) ⭐ 37 -- Go, IPA-based vector commitment for Verkle trees
- [rust-verkle](https://github.com/crate-crypto/rust-verkle) ⭐ 134 -- Rust, Verkle tree library

**Security status:** Secure
Security reduces to DLOG over Bandersnatch curve (~128-bit security). IPA-based commitments are transparent (no trusted setup). Well-analysed construction.

**Community acceptance:** Emerging
Proposed by Vitalik Buterin and Ethereum Foundation researchers. Active EIP process. Strong support from Ethereum client teams. Not yet formally standardised.

---

## Perfectly Binding vs Perfectly Hiding Commitments

**Goal:** Characterise the fundamental security trade-off in commitment schemes. No scheme can be simultaneously perfectly binding and perfectly hiding — a computationally unbounded adversary can always break one property — which drives the design of every practical commitment scheme.

| Scheme | Year | Type | Basis | Note |
|--------|------|------|-------|------|
| **Hash Commitment** | — | Perfectly binding (ROM), comp. hiding | Hash / OWF | C = H(m ‖ r); simple; perfectly binding in ROM [[1]](https://csrc.nist.gov/publications/detail/fips/180/4/final) |
| **Pedersen Commitment** | 1991 | Comp. binding, perfectly hiding | DLP | Perfectly hiding; equivocable; additively homomorphic [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Naor Bit Commitment** | 1991 | Perfectly binding, comp. hiding | PRG (OWF) | Bit commitment from any one-way function [[1]](https://link.springer.com/article/10.1007/BF00196774) |
| **Dual-mode commitments** | 2008 | Both modes under one key | DDH / LWE | Key can be set to either mode; enables simulation proofs [[1]](https://eprint.iacr.org/2008/028) |

**State of the art:** Perfectly hiding commitments (Pedersen) are standard in ZK protocols where the simulator must equivocate. Perfectly binding (hash-based) are used when receiver-side integrity is paramount. Dual-mode commitments (Peikert-Waters 2008) allow the same scheme to realise either mode under a CRS. See [Commitment Schemes](#commitment-schemes).


**Production readiness:** Production
This is a conceptual/comparison section. Both Pedersen (perfectly hiding) and hash-based (perfectly binding) commitments are deployed universally in production systems.

**Implementations:**
- [curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek) ⭐ 1.1k -- Rust, Pedersen (perfectly hiding) commitments
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k -- C, hash-based (perfectly binding) commitments via SHA-256

**Security status:** Secure
Fundamental impossibility result: no scheme can be both perfectly binding and perfectly hiding simultaneously. Each variant is secure under its respective assumptions (DLP, OWF).

**Community acceptance:** Standard
Textbook material in every cryptography course. The binding-hiding trade-off is a foundational concept. Dual-mode commitments (Peikert-Waters 2008) published at CRYPTO.

---

## UC-Secure Commitments

**Goal:** Composition-safe commitment behaving as an ideal "sealed envelope" even when running concurrently with arbitrary protocols. UC security implies non-malleability, selective-decommitment security, and resilience to concurrent composition — far stronger than standalone security. Impossible in the plain model; requires a CRS.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Fischlin UC Commitment** | 2001 | DDH + CRS | First UC commitment; non-interactive; CRYPTO 2001 [[1]](https://eprint.iacr.org/2001/055) |
| **Camenisch-Shoup UC Commitment** | 2002 | Strong RSA / Paillier | Efficient UC commitment supporting ZK proofs of opening [[1]](https://eprint.iacr.org/2002/161) |
| **Lindell UC Commitment** | 2011 | DDH | Efficient UC commitment with compact CRS [[1]](https://eprint.iacr.org/2011/228) |
| **UC Commitment from LWE** | 2020 | LWE + CRS | Post-quantum UC commitment [[1]](https://eprint.iacr.org/2020/1398) |

**State of the art:** UC commitment is the gold standard for multi-session concurrent protocols — MPC, anonymous credentials, e-cash. Two-party UC commitments are impossible in the plain model (Canetti-Fischlin impossibility); a CRS is required. LWE-based variant (2020) provides post-quantum UC security. See [Non-Malleable Encryption / Commitments](#non-malleable-encryption--commitments).


**Production readiness:** Mature
UC commitments are used in formally verified MPC protocols and anonymous credential systems. Production MPC frameworks (e.g., SPDZ) rely on UC-secure commitment abstractions.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit/emp-tool) ⭐ 241 -- C++, UC-secure MPC with commitment primitives
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k -- C++/Python, MPC framework using UC-secure commitments

**Security status:** Secure
UC security provides the strongest composition guarantees. Requires CRS (impossible in plain model per Canetti-Fischlin). LWE-based variant (2020) is post-quantum secure.

**Community acceptance:** Widely trusted
UC framework by Canetti is one of the most cited works in cryptography. UC commitments published at CRYPTO 2001. Gold standard for concurrent protocol security.

---

## Concurrent Non-Malleable Commitments

**Goal:** Non-malleability under concurrent execution — an adversary cannot produce a commitment to a related value even while participating in polynomially many simultaneous commitment sessions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pass-Rosen CNM** | 2005 | OWF | First formal CNM commitment; O(log n) rounds [[1]](https://www.cs.cornell.edu/~rafael/papers/concnmc-journal.pdf) |
| **Lin-Pass-Venkitasubramaniam CNM** | 2008 | OWF (black-box) | CNM from any OWF via black-box techniques; TCC 2008 [[1]](https://eprint.iacr.org/2008/235) |
| **Constant-Round CNM (Goyal)** | 2011 | OWF | Constant-round CNM; STOC 2011 [[1]](https://web.cs.ucla.edu/~rafail/PUBLIC/124.pdf) |
| **Non-Interactive CNM** | 2017 | Non-standard assumptions | Non-interactive CNM in the CRS model [[1]](https://eprint.iacr.org/2017/273) |

**State of the art:** Concurrent NM commitments are needed in any multi-session protocol (MPC, ZK). OWFs suffice with O(log n) rounds using black-box techniques (lower bound: Ω(log n) in the black-box setting). Practical systems often use UC commitments in the CRS model. Related to [Non-Malleable Encryption / Commitments](#non-malleable-encryption--commitments) and [UC-Secure Commitments](#uc-secure-commitments).


**Production readiness:** Research
Theoretical constructions used in round-complexity proofs for MPC. Practical systems typically use UC commitments in the CRS model instead.

**Implementations:**
- [Reference implementations](https://www.cs.cornell.edu/~rafael/papers/concnmc-journal.pdf) -- Academic prototypes accompanying theoretical papers

**Security status:** Secure
Proven secure from one-way functions (minimal assumption). O(log n) rounds optimal in the black-box setting. Well-established theoretical results.

**Community acceptance:** Niche
Published at STOC, TCC, and FOCS. Important for round-complexity theory. Practical impact is indirect -- most systems use UC commitments in the CRS model.

---

## Fischlin Transform

**Goal:** Online-extractable non-interactive zero-knowledge proofs with a straight-line (non-rewinding) extractor — an alternative to the Fiat-Shamir transform enabling UC-secure NIZKs and concurrent composition without rewinding.

| Scheme | Year | Note |
|--------|------|------|
| **Fischlin Transform** | 2005 | Original construction; straight-line extractor; larger proofs than Fiat-Shamir (multiple hash evaluations); CRYPTO 2005 [[1]](https://crypto.ethz.ch/publications/files/Fischl05b.pdf) |
| **Efficient Fischlin for UC-ZK** | 2024 | Optimised implementation for UC-secure ZK from sigma protocols; eprint 2024/526 [[1]](https://eprint.iacr.org/2024/526) |

**State of the art:** The Fischlin transform is the standard technique for UC-secure NIZKs from sigma protocols when straight-line extraction is required. Less efficient than Fiat-Shamir (larger proofs) but provides online extractability — critical for concurrent protocols and quantum-secure proofs. Related to [Sigma Protocols](categories/04-zero-knowledge-proof-systems.md#sigma-protocols) and [UC-Secure Commitments](#uc-secure-commitments).


**Production readiness:** Mature
Standard technique in cryptographic protocol design. Used in UC-secure ZK constructions and formal verification frameworks.

**Implementations:**
- [Fischlin transform implementations](https://eprint.iacr.org/2024/526) -- Research prototypes for efficient Fischlin-based UC-ZK

**Security status:** Secure
Provides straight-line (non-rewinding) extraction in the random oracle model. Proven secure at CRYPTO 2005. Larger proofs than Fiat-Shamir but with online extractability.

**Community acceptance:** Widely trusted
Published at CRYPTO 2005. Standard reference in the UC-ZK literature. Widely cited and well-understood. Complementary to the Fiat-Shamir transform.

---

## Witness-Extended Emulation

**Goal:** Strong knowledge soundness requiring an emulator to produce both an accepting transcript and a valid witness simultaneously — without rewinding. Strictly stronger than special soundness and cleaner to compose, this is the preferred knowledge-soundness definition for Bulletproofs, IPA-based SNARKs, and modern interactive argument systems.

| Reference | Year | Note |
|-----------|------|------|
| **Lindell — Parallel Composition of Sigma Protocols** | 2003 | Introduces WEE as a cleaner extraction notion for sigma protocols; proves DLOG sigma has WEE [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45146-4_32) |
| **Bootle et al. IPA** | 2016 | Uses WEE argument for knowledge soundness of inner-product arguments; EUROCRYPT 2016 [[1]](https://eprint.iacr.org/2016/263) |
| **Bulletproofs** | 2018 | Extends WEE to range proofs and R1CS; USENIX S&P 2018 [[1]](https://eprint.iacr.org/2017/1066) |

**State of the art:** Witness-extended emulation is the preferred knowledge-soundness definition in modern ZK literature — used in security proofs for Bulletproofs and IPA-based SNARKs. Cleaner than special soundness for composed protocols. Related to [Inner Product Arguments (IPA)](#inner-product-arguments-ipa--bulletproofs-polynomial-commitment) and [Extractable Commitments](#extractable-commitments).


**Production readiness:** Mature
Standard knowledge-soundness definition used in security proofs of Bulletproofs, IPA-based SNARKs, and modern interactive argument systems. Not a standalone deployed system.

**Implementations:**
- [Bulletproofs security proofs](https://eprint.iacr.org/2017/1066) -- Formal security analysis using WEE
- [dalek-bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k -- Rust, security proof uses WEE

**Security status:** Secure
WEE is a security definition (not a scheme). Provides stronger knowledge soundness than special soundness, enabling cleaner composition of interactive arguments.

**Community acceptance:** Widely trusted
Introduced by Lindell (2003). Adopted as the standard knowledge-soundness notion for IPA and Bulletproofs. Published at TCC and IEEE S&P.

---

## Extractable Commitments

**Goal:** Knowledge-binding commitment from which an efficient extractor can recover the committed plaintext from any successful committer — upgrading binding from "hard to equivocate" to "must know the opening." Essential for UC-secure commitments, simulation-extractable SNARKs, and commit-and-prove systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Equivocable and Extractable Commitments** | 2002 | OWF | First formal definition; simultaneously equivocable and extractable under different keys [[1]](https://dl.acm.org/doi/abs/10.5555/1766811.1766820) |
| **Simulation-Extractable SNARKs (Groth-Maller)** | 2017 | Pairings | SNARK proofs are extractable commitments to the witness; CRYPTO 2017 [[1]](https://eprint.iacr.org/2017/540) |
| **LegoSNARK CP framework** | 2019 | Extractable commitments | Extractability is "link soundness" enabling commit-and-prove composition; CCS 2019 [[1]](https://eprint.iacr.org/2019/142) |

**State of the art:** Extractable commitments underpin UC-secure MPC, simulation-extractable SNARKs, and commit-and-prove systems (LegoSNARK). In the SNARK context, simulation extractability makes a proof a binding commitment to the witness — critical for non-malleability of proof systems. See [UC-Secure Commitments](#uc-secure-commitments) and [Fischlin Transform](#fischlin-transform).


**Production readiness:** Production
Extractable commitments are implicit in every simulation-extractable SNARK (Groth16, PLONK). LegoSNARK's CP framework makes extractability explicit for modular proof composition.

**Implementations:**
- [snarkjs (Groth16)](https://github.com/iden3/snarkjs) ⭐ 2.0k -- JavaScript, simulation-extractable SNARK proofs
- [arkworks-rs/groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 -- Rust, Groth16 with extractable commitments
- [LegoSNARK](https://github.com/imdea-software/legosnark) ⭐ 43 -- Rust/C++, explicit extractable commitment framework

**Security status:** Secure
Extractability typically relies on knowledge assumptions (KEA) or algebraic group model. Simulation extractability of Groth16 proven by Groth-Maller (CRYPTO 2017).

**Community acceptance:** Widely trusted
Extractable commitments are a core concept in SNARK security. Groth-Maller (2017) and LegoSNARK (CCS 2019) are highly cited. Standard notion in the ZK community.

---

## Cross-Commitment Equality Proofs

**Goal:** Prove that two commitments under different keys or in different groups commit to the same secret value — without revealing it. Necessary for cross-system interoperability (e.g., proving the same amount appears in a Pedersen commitment over BN254 and an ElGamal ciphertext over secp256k1).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DLEQ (Chaum-Pedersen)** | 1992 | DLP | Prove discrete log equality in the same group; O(1) proof; deployed in ECVRF, verifiable ElGamal [[1]](https://link.springer.com/chapter/10.1007/3-540-48071-4_7) |
| **Cross-Group DL Equality (Chase et al.)** | 2022 | Sigma + aborts | First practical sigma protocol for proving equal committed values across different groups; eprint 2022/1593 [[1]](https://eprint.iacr.org/2022/1593) |
| **AND-composition of sigma protocols** | 1994 | Sigma | Prove equality of openings in same group via AND-composition; Cramer-Damgård-Schoenmakers [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_19) |

**State of the art:** Within the same group, DLEQ (Chaum-Pedersen 1992) is a textbook tool deployed in VRFs and Privacy Pass. Across different groups, Chase et al. (2022) provide the first practical cross-group sigma protocol via Lyubashevsky's "Fiat-Shamir with aborts." Related to [Verifiable Random Functions (VRF)](#verifiable-random-functions-vrf) and [Sigma Protocols](categories/04-zero-knowledge-proof-systems.md#sigma-protocols).


**Production readiness:** Production
DLEQ (Chaum-Pedersen) is deployed in ECVRF (RFC 9381), Privacy Pass, and verifiable ElGamal. Cross-group equality proofs (Chase et al. 2022) are in early adoption.

**Implementations:**
- [vrf-rs (DLEQ)](https://github.com/witnet/vrf-rs) ⭐ 95 -- Rust, DLEQ proof in ECVRF implementation

**Security status:** Secure
DLEQ is a textbook sigma protocol secure under DLOG. Cross-group equality (Chase et al. 2022) uses Fiat-Shamir with aborts; secure in ROM under DLOG in both groups.

**Community acceptance:** Standard
DLEQ (Chaum-Pedersen 1992) is a textbook protocol. Used in IETF RFC 9381 (ECVRF). Cross-group variant published at eprint 2022 with growing adoption.

---

## Algebraic Vector Commitments

**Goal:** Compact, algebraically structured vector commitments with constant-size subvector openings that support incremental aggregation and efficient updates — enabling verifiable decentralised storage and stateless blockchain validation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Catalano-Fiore VC** | 2013 | RSA / CDH | First formal construction with constant-size openings; position-binding and hiding [[1]](https://eprint.iacr.org/2011/495) |
| **Lai-Malavolta VC** | 2019 | Groups of unknown order | Subvector openings; aggregatable multi-position proofs; batch updates [[1]](https://eprint.iacr.org/2018/1188) |
| **Incrementally Aggregatable VC (Campanelli et al.)** | 2020 | Pairings + RSA | Verifiable decentralised storage (VDS); unbounded proof merging; ASIACRYPT 2020 [[1]](https://eprint.iacr.org/2020/149) |
| **Impossibility in pairing-free groups** | 2022 | Meta-reduction | Algebraic VC with constant-size proofs impossible without pairings; TCC 2022 [[1]](https://eprint.iacr.org/2022/696) |

**State of the art:** Algebraic VCs (Campanelli et al. 2020) are the foundation of verifiable decentralised storage — any subvector of chunks can be verified against one commitment, with proofs merged across nodes. The 2022 impossibility result confirms pairings are necessary for constant-size algebraic VCs. Related to [Vector Commitments](#vector-commitments), [Functional Commitments](#functional-commitments), and [Verkle Trees](#verkle-trees).


**Production readiness:** Experimental
Research prototypes for verifiable decentralised storage. Campanelli et al. (2020) demonstrated proof-of-concept. No large-scale production deployment.

**Implementations:**
- [incrementally-aggregatable-vc](https://eprint.iacr.org/2020/149) -- Research prototype; Rust, incrementally aggregatable vector commitments

**Security status:** Secure
Security proven under standard pairing and RSA assumptions. The 2022 impossibility result (constant-size algebraic VCs require pairings) is well-established.

**Community acceptance:** Niche
Published at ASIACRYPT 2020 and TCC 2022. Important theoretical contributions. Limited practical deployment beyond research prototypes.

---

## Statistically-Hiding Commitments from LWE

**Goal:** Commitment schemes where hiding holds against computationally unbounded adversaries, constructed from the Learning With Errors (LWE) assumption — providing post-quantum security with statistical hiding. Unlike Pedersen commitments (which rely on DLP), LWE-based statistically-hiding commitments survive quantum attacks while preserving the strong hiding guarantee needed for simulation-based security proofs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kawachi-Tanaka-Xagawa** | 2009 | LWE | First statistically-hiding commitment from LWE; uses lossy encryption paradigm; TCC 2009 [[1]](https://link.springer.com/chapter/10.1007/978-3-642-00457-5_23) |
| **Peikert-Vaikuntanathan-Waters** | 2008 | LWE (lossy TDFs) | Statistically-hiding commitment via lossy trapdoor functions from LWE; STOC 2008 [[1]](https://eprint.iacr.org/2007/279) |
| **Benhamouda-Blazy-Ducas-Quach** | 2020 | Module-LWE | Hash-then-commit paradigm yielding efficient statistically-hiding commitments from structured lattices; ASIACRYPT 2020 [[1]](https://eprint.iacr.org/2020/1547) |
| **Jain-Kalai-Khurana-Ron-Zewi** | 2021 | LWE | Constant-round statistically-hiding commitments with extractability; used in round-optimal MPC from LWE; STOC 2021 [[1]](https://eprint.iacr.org/2020/1434) |

**State of the art:** LWE-based statistically-hiding commitments are the post-quantum replacement for Pedersen commitments in simulation-based proofs. The structured-lattice variant (Module-LWE, 2020) offers practical efficiency. Round-optimal constructions (Jain et al. 2021) enable constant-round MPC from LWE alone. See [BDLOP Lattice Commitments](#bdlop-lattice-commitments) and [Perfectly Binding vs Perfectly Hiding Commitments](#perfectly-binding-vs-perfectly-hiding-commitments).


**Production readiness:** Research
Theoretical constructions used in round-optimal MPC proofs and post-quantum protocol design. No standalone production implementations.

**Implementations:**
- [Lattigo (lattice primitives)](https://github.com/tuneinsight/lattigo) ⭐ 1.4k -- Go, lattice cryptography library with building blocks
- [SEAL (lattice operations)](https://github.com/microsoft/SEAL) ⭐ 4.0k -- C++, Microsoft's lattice library (FHE-focused but includes commitment building blocks)

**Security status:** Secure
Security proven under standard LWE assumption with worst-case to average-case reductions. Post-quantum secure. Well-analysed in the theoretical literature.

**Community acceptance:** Niche
Published at STOC 2008 (Peikert-Vaikuntanathan-Waters), TCC 2009, and STOC 2021. Important for post-quantum protocol theory. Limited practical deployment.

---

## Merkle Patricia Tries as Commitment Schemes

**Goal:** An authenticated key-value store combining a radix trie (prefix tree) with Merkle hashing, enabling compact proofs of inclusion, exclusion, and state transitions over arbitrary key-value maps. The Merkle Patricia Trie (MPT) is Ethereum's state commitment structure: every account balance, contract storage slot, and transaction receipt is committed via a single 32-byte root hash, with O(log n) membership and non-membership proofs.

| Property | Value |
|----------|-------|
| **Structure** | Radix-16 (hex) trie with branch, extension, and leaf nodes |
| **Root** | Single Keccak-256 hash — commits to entire key-value map |
| **Inclusion proof** | O(log₁₆ n) hash nodes along the key path |
| **Non-membership proof** | Path terminates at divergent prefix; verifiable against root |
| **Update** | O(log₁₆ n) re-hashing along affected path |

| Variant | Year | Note |
|---------|------|------|
| **Ethereum Modified Merkle Patricia Trie** | 2014 | Hex-prefix encoding with RLP serialisation; Ethereum Yellow Paper [[1]](https://ethereum.github.io/yellowpaper/paper.pdf) |
| **Compact Merkle Multiproof** | 2019 | EIP-1186: prove multiple storage slots in one multi-proof against MPT root [[1]](https://eips.ethereum.org/EIPS/eip-1186) |
| **Sparse Merkle Tree (SMT)** | 2016 | Binary trie over 2²⁵⁶ keyspace; explicit non-membership proofs; used in ZK-rollups [[1]](https://eprint.iacr.org/2016/683) |
| **Binary Merkle Patricia Trie** | 2020 | Binary variant (branching factor 2) proposed for Ethereum 2.0 for SNARK-friendliness [[1]](https://ethresear.ch/t/binary-trie-format/7621) |

**State of the art:** The MPT is Ethereum's current state commitment (mainnet since 2015) and the most widely deployed authenticated dictionary in production. Sparse Merkle Trees are preferred in ZK-rollups (StarkNet, zkSync) for their SNARK-friendliness. Ethereum's roadmap replaces MPT with [Verkle Trees](#verkle-trees) ("The Verge") for smaller state witnesses. Related to [Accumulators](#accumulators) and [Vector Commitments](#vector-commitments).


**Production readiness:** Production
Ethereum's state commitment since mainnet launch (2015). The most widely deployed authenticated dictionary in production, securing hundreds of billions of dollars.

**Implementations:**
- [go-ethereum (geth)](https://github.com/ethereum/go-ethereum) ⭐ 50k -- Go, production MPT implementation
- [reth](https://github.com/paradigmxyz/reth) ⭐ 5.5k -- Rust, high-performance Ethereum client with MPT
- [ethereumjs-mpt](https://github.com/ethereumjs/ethereumjs-monorepo) ⭐ 2.7k -- TypeScript, MPT reference implementation

**Security status:** Secure
Security reduces to collision resistance of Keccak-256. Well-understood authenticated data structure. Sparse Merkle Trees provide explicit non-membership proofs.

**Community acceptance:** Standard
Defined in Ethereum Yellow Paper. Deployed since 2015 on Ethereum mainnet. De-facto standard for blockchain state commitment. Being succeeded by Verkle Trees.

---

## Selective-Opening Security for Commitments

**Goal:** Security under adaptive partial opening. An adversary sees n commitments, then adaptively selects a subset to be opened, and must still learn nothing about the unopened values. Standard hiding only guarantees security for a single commitment; selective-opening (SO) security extends this to the multi-commitment setting — critical for protocols where an adversary can force selective decommitment (e.g., MPC, e-voting, oblivious transfer).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bellare-Hofheinz-Yilek (BHY)** | 2009 | Lossy encryption | First formalisation of sender SO security (simulation and indistinguishability variants); EUROCRYPT 2009 [[1]](https://eprint.iacr.org/2009/101) |
| **Hofheinz (receiver SO)** | 2011 | DDH / DLIN | First receiver selective-opening secure commitment; PKC 2011 [[1]](https://eprint.iacr.org/2011/066) |
| **Fehr-Hofheinz-Kiltz-Schaffner** | 2017 | LWE | SO-secure commitments from lattice assumptions; post-quantum; TCC 2017 [[1]](https://eprint.iacr.org/2016/678) |
| **Hazay-Patra-Warinschi** | 2015 | DDH | Efficient adaptively SO-secure commitments in the UC model [[1]](https://eprint.iacr.org/2014/965) |

**State of the art:** SO security is required in any protocol where the adversary adaptively chooses which commitments to open (MPC, parallel OT, e-voting). LWE-based SO-secure commitments (2017) provide post-quantum guarantees. Standard Pedersen commitments are NOT SO-secure in general. See [UC-Secure Commitments](#uc-secure-commitments) and [Commitment Schemes](#commitment-schemes).


**Production readiness:** Research
Theoretical security notion used in protocol security proofs. Standard Pedersen commitments are NOT SO-secure; explicit SO-secure constructions are research-grade.

**Implementations:**
- [SO-secure commitment prototypes](https://eprint.iacr.org/2016/678) -- Research implementations accompanying theoretical papers

**Security status:** Secure
SO-secure commitments from LWE (2017) are post-quantum secure. Well-analysed in the theoretical literature. Careful: standard Pedersen is NOT SO-secure.

**Community acceptance:** Niche
Published at EUROCRYPT 2009, PKC 2011, and TCC 2017. Important for MPC and e-voting security proofs. Specialised notion not widely deployed standalone.

---

## Rate-1 Commitments

**Goal:** Commitments with optimal communication efficiency — the commitment string is only negligibly longer than the committed message itself (rate approaching 1). Standard commitments (Pedersen, hash-based) have rate < 1 because the commitment includes randomness overhead. Rate-1 constructions minimise bandwidth, enabling efficient commitments to large data (databases, machine learning models, blockchain states).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hemenway-Ostrovsky-Rosen** | 2012 | LWE (lossy modes) | First rate-1 commitment from LWE; uses lossy encryption; CRYPTO 2012 [[1]](https://eprint.iacr.org/2012/474) |
| **Gentry-Halevi-Vaikuntanathan** | 2015 | LWE (GSW-FHE) | Rate-1 commitment via FHE bootstrapping; ITCS 2015 [[1]](https://eprint.iacr.org/2014/714) |
| **Brakerski-Vaikuntanathan** | 2018 | LWE | Rate-1 OT and commitments from standard LWE; avoids FHE; FOCS 2018 [[1]](https://eprint.iacr.org/2018/895) |
| **Devadas-Quach-Vaikuntanathan-Wee** | 2023 | LWE | Rate-1 extractable commitments; enables rate-1 MPC and SNARG; EUROCRYPT 2023 [[1]](https://eprint.iacr.org/2022/1648) |

**State of the art:** Rate-1 commitments from LWE (Brakerski-Vaikuntanathan 2018) achieve near-optimal bandwidth. Rate-1 extractable variants (2023) enable communication-efficient MPC and compact SNARGs from standard assumptions. Related to [Statistically-Hiding Commitments from LWE](#statistically-hiding-commitments-from-lwe) and [Commitment Schemes](#commitment-schemes).


**Production readiness:** Research
Theoretical constructions for communication-efficient protocols. No standalone production implementations.

**Implementations:**
- [Rate-1 commitment prototypes](https://eprint.iacr.org/2022/1648) -- Research prototypes accompanying theoretical papers

**Security status:** Secure
Security proven under standard LWE assumption. Rate-1 extractable variants (2023) are secure under standard assumptions. Well-analysed.

**Community acceptance:** Niche
Published at CRYPTO 2012, FOCS 2018, and EUROCRYPT 2023. Important for communication complexity theory. Limited practical deployment.

---

## Batch Commitments and Amortised Opening

**Goal:** Commit to many values simultaneously and open subsets efficiently — with amortised cost per opening much lower than individual commitments. Essential for scaling commitment-heavy protocols (ZK proofs, blockchain state, verifiable databases) where thousands or millions of values must be committed and selectively opened.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Feist-Khovratovich (FK) Technique** | 2023 | KZG + FFT | Amortised KZG: compute all n single-point proofs in O(n log n) via FFT; used in Ethereum EIP-4844 [[1]](https://eprint.iacr.org/2023/033) |
| **Pointproofs Batch Aggregation** | 2020 | Pairings | Aggregate proofs across multiple vector commitments into one; cross-commitment batching; CCS 2020 [[1]](https://eprint.iacr.org/2020/419) |
| **Hyperproofs** | 2022 | KZG + tree structure | Efficient batch update and opening for vector commitments; O(log n) update, O(1) amortised proof; IEEE S&P 2022 [[1]](https://eprint.iacr.org/2021/599) |
| **Multi-opening KZG (Boneh-Drake-Fisch-Gabizon)** | 2020 | KZG + vanishing polynomials | Open f at multiple points with a single proof via quotient by vanishing polynomial [[1]](https://dankradfeist.de/ethereum/2021/06/18/pcs-multiproofs.html) |

**State of the art:** The FK technique (2023) is deployed in Ethereum's EIP-4844 for computing blob KZG proofs at scale. Pointproofs and Hyperproofs enable efficient batch operations on vector commitments for blockchain state validation. Multi-opening KZG is standard in PLONK-based proof systems. Related to [KZG Polynomial Commitments](#kzg-polynomial-commitments) and [Vector Commitments](#vector-commitments).


**Production readiness:** Production
FK technique deployed in Ethereum EIP-4844 for blob KZG proof computation. Multi-opening KZG is standard in PLONK-based proof systems.

**Implementations:**
- [c-kzg-4844](https://github.com/ethereum/c-kzg-4844) ⭐ 167 -- C, FK-based batch KZG for Ethereum EIP-4844
- [Hyperproofs](https://github.com/hyperproofs/hyperproofs) ⭐ 3 -- Rust, efficient batch vector commitment opening
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 -- Rust, multi-opening KZG

**Security status:** Secure
FK technique inherits KZG security (d-SDH). Pointproofs security proven under pairing assumptions. Multi-opening KZG is a straightforward extension of standard KZG.

**Community acceptance:** Widely trusted
FK technique deployed in Ethereum's EIP-4844. Pointproofs published at CCS 2020. Hyperproofs at IEEE S&P 2022. All well-cited and peer-reviewed.

---

## Round-Optimal Commitment Protocols

**Goal:** Achieve commitment functionality (hiding + binding) in the minimum number of communication rounds. In the plain model, perfectly-hiding commitments require at least 2 rounds (1 round for commit, 1 for decommit), but achieving additional properties (extractability, equivocability, non-malleability) simultaneously may require more. Round complexity directly impacts latency in interactive protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor Bit Commitment** | 1991 | PRG (any OWF) | 2-round perfectly-binding bit commitment from any OWF; optimal [[1]](https://link.springer.com/article/10.1007/BF00196774) |
| **Haitner-Reingold** | 2007 | OWF | 2-round statistically-hiding commitment from any OWF; matches Naor in round count [[1]](https://eprint.iacr.org/2006/337) |
| **Pass-Wee** | 2009 | OWF | 1-round (non-interactive) commitment in the CRS model with both hiding and extractability [[1]](https://eprint.iacr.org/2009/080) |
| **Khurana-Sahai** | 2017 | LWE / DDH | 2-round MPC from 2-round commitments with simultaneous extractability and equivocability [[1]](https://eprint.iacr.org/2017/316) |

**State of the art:** 2 rounds are necessary and sufficient for statistically-hiding commitments in the plain model (Haitner-Reingold 2007). In the CRS model, non-interactive (1-round) schemes achieve extractability and equivocability simultaneously. Round-optimal commitments are a key building block for round-optimal MPC. See [Commitment Schemes](#commitment-schemes) and [UC-Secure Commitments](#uc-secure-commitments).


**Production readiness:** Mature
Naor bit commitment (2-round) is a textbook construction. Round-optimal techniques are used as building blocks in MPC protocol implementations.

**Implementations:**
- [emp-toolkit](https://github.com/emp-toolkit/emp-tool) ⭐ 241 -- C++, uses round-optimal commitments in MPC protocols
- [Naor commitment (textbook)](https://link.springer.com/article/10.1007/BF00196774) -- Various textbook implementations

**Security status:** Secure
Naor bit commitment is secure from any PRG (minimal assumption). 2 rounds are necessary and sufficient for statistically-hiding commitments in the plain model. Tight lower bounds proven.

**Community acceptance:** Standard
Naor (1991) and Haitner-Reingold (2007) are textbook results. Round complexity of commitments is a foundational topic in cryptography. Well-established consensus.

---

## Homomorphic Commitments for MPC

**Goal:** Commitments that support addition and (limited) multiplication on committed values, enabling verifiable computation within MPC protocols. Parties commit to their inputs, then jointly compute on the commitments without opening them — with the homomorphic structure ensuring correctness at every step. The workhorse of SPDZ-style actively secure MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen (additive homomorphism)** | 1991 | DLP | com(a) + com(b) = com(a + b); basis of SPDZ MAC checking [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **SPDZ Commitment MAC** | 2012 | Pedersen + MAC | Commit-and-MAC on secret-shared values; information-theoretic active security via linear homomorphism [[1]](https://eprint.iacr.org/2011/535) |
| **BGW + Verifiable SS** | 1988 | Shamir SS + commitments | Commitments on polynomial shares enable active security in BGW MPC [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **BDLOP for Lattice MPC** | 2018 | Module-SIS / Module-LWE | Additively homomorphic lattice commitment enabling post-quantum actively secure MPC [[1]](https://eprint.iacr.org/2016/997) |

**State of the art:** Pedersen commitments with information-theoretic MACs (SPDZ, 2012+) are the standard for actively secure MPC over arithmetic circuits. BDLOP provides the post-quantum analogue. Multiplicative homomorphism requires additional zero-knowledge proofs (e.g., multiplication triples). See [Commitment Schemes](#commitment-schemes), [BDLOP Lattice Commitments](#bdlop-lattice-commitments), and [Multi-Party Computation](categories/06-multi-party-computation.md#secure-multi-party-computation-mpc).


**Production readiness:** Production
Pedersen commitments with SPDZ MACs are the standard for actively secure MPC, deployed in SPDZ, MP-SPDZ, and commercial MPC platforms.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k -- C++/Python, SPDZ-style MPC with Pedersen commitment MACs
- [SCALE-MAMBA](https://github.com/KULeuven-COSIC/SCALE-MAMBA) ⭐ 266 -- C++, actively secure MPC using homomorphic commitments
- [emp-toolkit](https://github.com/emp-toolkit/emp-tool) ⭐ 241 -- C++, MPC with commitment-based active security

**Security status:** Secure
SPDZ commitment MAC provides information-theoretic active security given secure preprocessing. Pedersen commitments secure under DLP. BDLOP variant secure under Module-SIS/LWE.

**Community acceptance:** Widely trusted
SPDZ (2012) is the most influential actively secure MPC protocol. Pedersen commitments in MPC are a textbook technique. Adopted by both academia and industry.

---

## Succinct Mercurial Commitments

**Goal:** Commitments that can be opened to either a "hard" value (standard binding opening) or a "soft" opening (reveals that the commitment is to *some* value, without specifying which). Mercurial commitments enable zero-knowledge sets and authenticated dictionaries where a committer can prove both membership and non-membership without revealing the set size or contents.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Healy-Lysyanskaya-Malkin-Reyzin** | 2005 | DDH | First mercurial commitment; enables ZK sets; CRYPTO 2005 [[1]](https://eprint.iacr.org/2005/060) |
| **Catalano-Dodis-Visconti** | 2006 | Trapdoor commitments | Mercurial commitments from any trapdoor commitment; TCC 2006 [[1]](https://eprint.iacr.org/2005/438) |
| **Libert-Yung Concise Mercurial VC** | 2010 | Pairings (q-SDH) | First concise (constant-size) mercurial vector commitment; enables efficient ZK authenticated dictionaries [[1]](https://eprint.iacr.org/2010/099) |

**State of the art:** Mercurial commitments are the foundation of zero-knowledge sets — proving set (non-)membership while hiding the set itself. Libert-Yung (2010) achieves constant-size proofs via pairings. Applications include privacy-preserving revocation lists and anonymous credential blacklists. Related to [Vector Commitments](#vector-commitments) and [Accumulators](#accumulators).


**Production readiness:** Research
Academic constructions for zero-knowledge sets. No large-scale production deployments. Used in privacy-preserving revocation research prototypes.

**Implementations:**
- [ZK-sets prototype](https://eprint.iacr.org/2005/060) -- Research prototype; C++, zero-knowledge set implementation

**Security status:** Secure
Security proven under DDH and q-SDH assumptions. Libert-Yung (2010) achieves constant-size proofs from pairings. No known attacks.

**Community acceptance:** Niche
Published at CRYPTO 2005 and subsequent venues. Important for zero-knowledge set theory. Limited practical deployment outside research.

---

## Verifiable Computation Delegation (Succinct Arguments for Delegated Computation)

**Goal:** A computationally weak client delegates a computation f(x) to a powerful server, receiving a result y and a succinct proof that y = f(x) — verifiable in time much less than computing f. Unlike general-purpose SNARKs, delegation schemes are optimised for the asymmetric client-server setting: the verifier (client) has limited resources, while the prover (server) has abundant computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GGP (Gennaro-Gentry-Parno)** | 2010 | FHE + Yao's garbled circuits | First general-purpose VC from FHE; amortised verification cheaper than re-execution [[1]](https://eprint.iacr.org/2009/547) |
| **Pinocchio (Parno-Howell-Gentry-Raykova)** | 2013 | QAPs + pairings | First practical VC; quadratic arithmetic programs; verifier runs in O(|input|) time [[1]](https://eprint.iacr.org/2013/279) |
| **Hyrax (Wahby et al.)** | 2018 | Sumcheck + Pedersen | Doubly-efficient, transparent VC; no trusted setup; IEEE S&P 2018 [[1]](https://eprint.iacr.org/2017/1132) |
| **VOLE-based VC (Weng et al.)** | 2021 | VOLE + IT-MAC | Constant-round delegated computation with information-theoretic verification via VOLE; CCS 2021 [[1]](https://eprint.iacr.org/2021/740) |

**State of the art:** Modern SNARK/STARK systems (PLONK, Groth16, STARKs) subsume VC for most use cases. Specialised delegation schemes remain relevant for settings requiring minimal verifier hardware (IoT, mobile) or information-theoretic security (VOLE-based). Related to [Verifiable Computation (VC)](#verifiable-computation-vc) and [GKR Protocol](#gkr-protocol-doubly-efficient-interactive-proofs).


**Production readiness:** Mature
The delegation concept is subsumed by modern SNARK/STARK systems. Specialised delegation schemes (Hyrax, VOLE-based) are used in research and IoT contexts.

**Implementations:**
- [Pepper project](https://github.com/pepper-project) -- C++, academic VC delegation systems
- [microsoft/Spartan](https://github.com/microsoft/Spartan) ⭐ 849 -- Rust, transparent VC based on sumcheck

**Security status:** Secure
Interactive proof variants have information-theoretic soundness. SNARK-based VC depends on knowledge assumptions. VOLE-based VC has information-theoretic verification. No known attacks.

**Community acceptance:** Widely trusted
Foundational papers (GGP 2010, Pinocchio 2013) are among the most cited in applied cryptography. Modern VC is delivered through the SNARK/STARK ecosystem with broad community trust.

---

## Compact Proofs of Exponentiation (PoE) and Knowledge of Exponent (KEA)

**Goal:** Prove knowledge of, or correctness of, a large exponentiation without revealing the exponent. PoE proves that y = gˣ for a claimed x without the verifier re-computing the exponentiation — critical for VDF verification and accumulator updates. KEA (Knowledge of Exponent Assumption) assumes that any party producing a valid DH pair (g, gᵃ, h, hᵃ) must "know" a, enabling extractable commitments and SNARKs.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wesolowski PoE** | 2019 | Groups of unknown order | O(1)-size proof that y = g^(2^T); single group element; used in VDF verification [[1]](https://eprint.iacr.org/2018/623) |
| **Pietrzak PoE** | 2019 | Groups of unknown order | O(log T)-size proof via recursive halving; no generic group model needed [[1]](https://eprint.iacr.org/2018/627) |
| **KEA1 (Damgard)** | 1991 | DLP | Knowledge of Exponent Assumption: producing (g, gᵃ, h, hᵃ) implies knowing a; used in SNARK extractors [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_36) |
| **Bitansky-Canetti-Chiesa-Tromer** | 2013 | KEA + pairings | KEA over bilinear groups enables succinct extractable commitments underpinning preprocessing SNARKs [[1]](https://eprint.iacr.org/2011/443) |

**State of the art:** Wesolowski PoE is deployed in VDF verification (Chia, Ethereum research) and Boneh-Bunz-Fisch accumulator batching. KEA over pairing groups is the extractability backbone of Groth16 and other preprocessing SNARKs. Related to [Verifiable Delay Functions (VDF)](#verifiable-delay-functions-vdf), [Accumulators](#accumulators), and [Extractable Commitments](#extractable-commitments).


**Production readiness:** Production
Wesolowski PoE deployed in Chia VDF verification and accumulator batching. KEA is a core assumption in Groth16 and all preprocessing SNARKs deployed at scale.

**Implementations:**
- [chiavdf](https://github.com/Chia-Network/chiavdf) ⭐ 65 -- C++, Wesolowski PoE for VDF verification
- [accumulator](https://github.com/cambrian/accumulator) ⭐ 138 -- Rust, PoE in RSA accumulator batching
- [snarkjs (Groth16)](https://github.com/iden3/snarkjs) ⭐ 2.0k -- JavaScript, SNARK relying on KEA assumption

**Security status:** Caution
Wesolowski PoE is secure in the generic group model. KEA is a non-falsifiable knowledge assumption -- widely used but not reducible to standard computational assumptions. Active debate on KEA's theoretical status.

**Community acceptance:** Widely trusted
Wesolowski PoE published at EUROCRYPT 2019. KEA introduced by Damgard (1991), formalised for SNARKs by Bitansky et al. (2013). Both are well-cited and integral to deployed systems.

---
