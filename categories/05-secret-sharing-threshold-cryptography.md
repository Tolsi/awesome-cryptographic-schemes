# Secret Sharing & Threshold Cryptography

## Secret Sharing Schemes (SSS)

**Goal:** Split a secret into *n* shares so that any *t* shares reconstruct it, but fewer than *t* reveal nothing. Provides confidentiality + availability.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **Shamir's Secret Sharing** | 1979 | Polynomial interpolation | Information-theoretically secure; *(t,n)* threshold [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Blakley's Scheme** | 1979 | Hyperplane geometry | Alternative geometric approach [[1]](https://doi.org/10.1109/AFIPS.1979.98) |
| **Verifiable SS (VSS) — Feldman** | 1987 | Commitments on polynomial coeff. | Detects cheating dealer [[1]](https://doi.org/10.1109/SFCS.1987.4) |
| **Verifiable SS — Pedersen** | 1991 | Double commitments | Information-theoretically hiding [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **Packed Secret Sharing** | 1992 | Multi-secret polynomial | Amortized: share multiple secrets at once [[1]](https://dl.acm.org/doi/10.1145/129712.129780) |
| **Proactive SS** | 1995 | Periodic share refresh | Tolerates mobile adversary over time [[1]](https://link.springer.com/chapter/10.1007/3-540-44750-4_27) |
| **Verifiable Weighted SS** | 2025 | Bulletproofs + Shamir | First efficient verifiable weighted SS; stake-aware party weights [[1]](https://arxiv.org/abs/2505.24289) |

**State of the art:** Shamir + Feldman VSS (practical), Packed SS (MPC optimization), Weighted SS (2025).

---

## Threshold Decryption

**Goal:** Distributed confidentiality. *t-of-n* parties jointly decrypt a ciphertext without any single party reconstructing the full private key. Complement to Threshold Signatures for the encryption side.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold ElGamal** | 1994 | DDH + Shamir SSS | Classic; partial decryptions combined [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_3) |
| **Threshold RSA (Shoup)** | 2000 | RSA + VSS | Secure threshold RSA decryption [[1]](https://eprint.iacr.org/1999/011) |
| **PVSS-based Threshold Dec.** | 2001 | PVSS + ElGamal | Publicly verifiable shares; no trusted dealer [[1]](https://eprint.iacr.org/1999/041) |
| **TPKE (Threshold BLS Enc.)** | 2020 | Pairings + Shamir | Non-interactive; used in Ethereum DVT, Dusk Network [[1]](https://eprint.iacr.org/2021/339) |
| **Pilvi (Lattice Threshold PKE)** | 2025 | LWE | Post-quantum threshold PKE with small decryption shares; simulation-based security; ASIACRYPT 2025 [[1]](https://eprint.iacr.org/2025/1691) |

**State of the art:** Threshold ElGamal (general), TPKE (blockchain applications, DVT), Pilvi (PQ-secure, 2025).

---

## Publicly Verifiable Secret Sharing (PVSS)

**Goal:** Transparency + integrity. A verifiable secret sharing scheme where *anyone* (not just participants) can verify that shares are correctly computed — even without a trusted dealer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Stadler PVSS** | 1996 | DLP + ZK | First practical PVSS [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_6) |
| **Schoenmakers PVSS** | 1999 | DLP | Simpler, more efficient; widely deployed [[1]](https://eprint.iacr.org/1999/011) |
| **Aggregatable PVSS** | 2021 | KZG + pairings | O(1) verification; scalable for blockchain randomness [[1]](https://eprint.iacr.org/2021/339) |

**State of the art:** Aggregatable PVSS (randomness beacons, DKG), Schoenmakers (classic deployments).

---

## Distributed Key Generation (DKG)

**Goal:** Availability + distributed trust. Generate a threshold public/private keypair among *n* parties so that no single party — nor any coalition below threshold *t* — ever knows the full private key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pedersen DKG** | 1991 | VSS + commitments | Simple, widely deployed; not robust against rushing [[1]](https://link.springer.com/chapter/10.1007/3-540-46766-1_9) |
| **GJKR DKG** | 1999 | VSS + ZK | Provably secure; handles malicious parties [[1]](https://link.springer.com/chapter/10.1007/3-540-48405-1_10) |
| **Aggregatable DKG** | 2020 | KZG + pairings | O(n log n) communication; scalable to thousands of nodes [[1]](https://eprint.iacr.org/2021/005) |
| **FROST DKG** | 2020 | Schnorr + VSS | Designed to pair with FROST threshold signing [[1]](https://eprint.iacr.org/2020/852) |

**State of the art:** Aggregatable DKG (large-scale blockchains), GJKR (security-critical threshold systems).

---

## Proactive Secret Sharing

**Goal:** Long-term threshold security. Periodically refresh secret shares without changing the secret — so an adversary who compromises different parties in different time periods never accumulates enough shares. Defends against "mobile adversaries."

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Herzberg-Jarecki-Krawczyk-Yung (HJKY)** | 1995 | Shamir + rerandomization | First proactive SS; parties jointly rerandomize shares each epoch [[1]](https://doi.org/10.1007/3-540-44750-4_27) |
| **Proactive RSA (Frankel et al.)** | 1997 | RSA threshold | Proactive threshold RSA signatures; share refresh without new key [[1]](https://doi.org/10.1007/BFb0052253) |
| **CHURP** | 2019 | Bivariate polynomials | Proactive SS with dynamic committee changes; Byzantine-tolerant [[1]](https://eprint.iacr.org/2019/017) |
| **Proactive Refresh for BLS** | 2022 | BLS threshold | Refresh threshold BLS shares; used in Ethereum validator key management [[1]](https://eprint.iacr.org/2022/898) |

**State of the art:** CHURP (2019) for dynamic committees; proactive BLS for blockchain validators. Extends [Secret Sharing](#secret-sharing-schemes-sss) and [DKG](#distributed-key-generation-dkg).

---

## Packed Secret Sharing

**Goal:** Amortized secret sharing. Share k secrets simultaneously using a single polynomial of degree t + k − 1, instead of k separate Shamir sharings. Reduces communication in MPC by a factor of k — crucial for large-scale secure computation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Franklin-Yung Packed SS** | 1992 | Polynomial | First packed SS; k secrets in one degree-(t+k−1) polynomial [[1]](https://doi.org/10.1007/3-540-48071-4_12) |
| **Packed SS for MPC (Damgård et al.)** | 2006 | Packed Shamir | Amortized MPC: evaluate k gates in one round via packed shares [[1]](https://eprint.iacr.org/2005/264) |
| **Turbopack** | 2022 | Packed SS + batch | Further optimize MPC with packed SS; near-optimal communication [[1]](https://eprint.iacr.org/2022/1316) |

**State of the art:** Turbopack (2022) for high-throughput MPC; packed SS is a core optimization in [MPC](#multi-party-computation-mpc) and [Secret Sharing](#secret-sharing-schemes-sss).

---

## Robust Secret Sharing

**Goal:** Error-tolerant reconstruction. Reconstruct the secret correctly even when up to t_c shares are adversarially corrupted (not just missing). Standard Shamir fails with even one corrupted share — robust SS detects and corrects errors during reconstruction.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rabin-Ben-Or Robust SS** | 1989 | Error-correcting + Shamir | First robust SS; detects corrupted shares via error-correcting codes [[1]](https://doi.org/10.1145/73007.73014) |
| **Cramer-Damgård-Fehr Robust SS** | 2006 | Algebraic + MAC | Optimal corruption tolerance: t_c < n/3 for information-theoretic [[1]](https://eprint.iacr.org/2006/109) |
| **Cevallos-Fehr-Ostrovsky Robust SS** | 2012 | Short shares | Asymptotically optimal share size + robust reconstruction [[1]](https://eprint.iacr.org/2012/372) |

**State of the art:** Optimal robust SS (Cevallos et al. 2012); essential for [MPC](#multi-party-computation-mpc) and [DKG](#distributed-key-generation-dkg) with malicious parties. Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Ramp Secret Sharing

**Goal:** Efficiency vs. privacy tradeoff. In (t, t+g, n)-ramp SS, fewer than t shares reveal nothing, t+g or more shares reconstruct the secret, and between t and t+g shares may leak partial information. Shares are g times shorter than in Shamir — critical for large secrets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Blakley-Meadows Ramp SS** | 1985 | Linear algebra | First ramp scheme; shares = secret_size / g instead of secret_size [[1]](https://doi.org/10.1007/3-540-39757-4_20) |
| **Franklin-Yung (packed as ramp)** | 1992 | Polynomial | Packed secret sharing is a ramp scheme; share k secrets in one poly [[1]](https://doi.org/10.1007/3-540-48071-4_12) |
| **Ramp SS for MPC** | 2006 | Packed Shamir | Amortized MPC communication using ramp shares [[1]](https://eprint.iacr.org/2005/264) |

**State of the art:** Ramp SS for large-secret sharing and amortized [MPC](#multi-party-computation-mpc); closely related to [Packed Secret Sharing](#packed-secret-sharing). Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## General Access Structure Secret Sharing

**Goal:** Beyond threshold. Share a secret so that any authorized subset of participants (defined by an arbitrary monotone access structure) can reconstruct, while unauthorized subsets learn nothing. Generalizes (t,n)-threshold to any collection of qualified sets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ito-Saito-Nishizeki** | 1989 | Monotone formulae | First general construction; any monotone access structure; exponential share size [[1]](https://doi.org/10.1007/0-387-34805-0_43) |
| **Benaloh-Leichter** | 1990 | Monotone formulae | Simpler construction; shares from formula decomposition [[1]](https://doi.org/10.1007/0-387-34805-0_27) |
| **Linear Secret Sharing (LSSS)** | 1996 | Monotone span programs | Shares are linear in secret; basis of ABE access policies [[1]](https://doi.org/10.1007/3-540-68339-9_22) |
| **Multi-Linear SS (Beimel)** | 2011 | General | Survey of constructions; share size lower bounds [[1]](https://doi.org/10.1007/978-3-642-20901-7_2) |

**State of the art:** LSSS for efficient schemes (used in [ABE](#attribute-based--functional-encryption)); general access structures remain exponential in worst case — a major open problem. Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Asynchronous Verifiable Secret Sharing (AVSS)

**Goal:** VSS without timing assumptions. The dealer shares a secret so that (1) all honest parties eventually receive valid shares, (2) a unique secret is determined even if the dealer is malicious, (3) no synchrony assumptions — messages can be arbitrarily delayed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Rabin AVSS** | 1993 | Bivariate polynomials | First AVSS; information-theoretic; t < n/3 [[1]](https://doi.org/10.1145/167088.167109) |
| **Cachin-Kursawe-Petzold-Shoup (CKPS)** | 2002 | Pedersen + pairings | Practical AVSS; O(n²) messages; used in async DKG [[1]](https://eprint.iacr.org/2002/134) |
| **Abraham-Chow-Goldfeder-Hazay AVSS** | 2021 | KZG commitments | O(n log n) communication; optimal async VSS [[1]](https://eprint.iacr.org/2021/118) |
| **Haven (Das et al.)** | 2023 | Polynomial eval + async | High-throughput AVSS for async DKG and MPC [[1]](https://eprint.iacr.org/2023/1762) |

**State of the art:** KZG-based AVSS (2021+) for optimal communication; essential for [Async BFT](#asynchronous-bft--asynchronous-mpc) and [DKG](#distributed-key-generation-dkg).

---

## Non-Interactive DKG (NIDKG)

**Goal:** One-round distributed key generation. Generate a shared public key and individual secret key shares in a single broadcast round — no back-and-forth communication. Critical for blockchain protocols where interactive rounds are expensive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Groth NIDKG** | 2021 | Pairings + NIZK | Non-interactive; publicly verifiable; O(n) transcript size [[1]](https://eprint.iacr.org/2021/339) |
| **Gurkan et al. NIDKG** | 2021 | KZG + gossip | Aggregatable DKG; used in Celo blockchain [[1]](https://eprint.iacr.org/2021/005) |
| **Groth-Shoup NIDKG** | 2022 | Forward-secure enc | Used in Internet Computer (DFINITY); asynchronous, robust [[1]](https://eprint.iacr.org/2022/087) |

**State of the art:** Groth-Shoup NIDKG (DFINITY/Internet Computer); Gurkan et al. (Celo). Extends [DKG](#distributed-key-generation-dkg) to non-interactive setting.

---

## Universal Thresholdizer

**Goal:** Generic threshold compiler. Take any cryptographic scheme (encryption, signatures, PRF, VRF, etc.) and automatically convert it into a threshold version — without designing a bespoke threshold protocol for each primitive.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Komlo Universal Thresholdizer** | 2023 | FHE + threshold decryption | Threshold any scheme: parties jointly FHE-evaluate the scheme, then threshold-decrypt [[1]](https://eprint.iacr.org/2023/636) |
| **Shoup-Smart Threshold Paradigm** | 2000 | Threshold decryption | Template: each party applies its key share, combine partial results [[1]](https://eprint.iacr.org/2000/016) |
| **Damgård-Koprowski Threshold RSA** | 2001 | RSA shares | Generic threshold RSA from any RSA-based scheme [[1]](https://eprint.iacr.org/2001/044) |

**State of the art:** Boneh-Komlo (2023) via FHE: truly universal but expensive; practical threshold schemes remain bespoke (see [TSS](#threshold-signature-schemes-tss), [Threshold Decryption](#threshold-decryption)).

---

## Leakage-Resilient Secret Sharing

**Goal:** Side-channel resistant shares. Secret sharing remains secure even if an adversary learns bounded leakage (e.g., a few bits) from each share. Standard Shamir is completely broken by 1-bit leakage from each share; LRSS withstands it.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Benhamouda-Degwekar-Ishai-Rabin LRSS** | 2018 | Inner product + Shamir | First LRSS for general leakage; local leakage model [[1]](https://eprint.iacr.org/2018/294) |
| **Goyal-Kumar LRSS** | 2018 | Extractors + SS | Optimal rate LRSS; leakage up to (1-ε) fraction of share size [[1]](https://eprint.iacr.org/2018/099) |
| **Nielsen-Simkin Non-Malleable + LR SS** | 2020 | Combined model | Both leakage-resilient and non-malleable secret sharing [[1]](https://eprint.iacr.org/2020/209) |

**State of the art:** Combined NM + LR secret sharing (2020); extends [Secret Sharing](#secret-sharing-schemes-sss) and relates to [Leakage-Resilient Crypto](#leakage-resilient-cryptography).

---

## Traceable Secret Sharing

**Goal:** Leak deterrence for secret shares. If shareholders sell or leak their shares, a tracing algorithm can identify which shares were leaked — even when up to t shareholders collude. A new security property beyond [cheater detection](#secret-sharing-with-cheater-detection) or [robust SS](#robust-secret-sharing).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Partap-Rotem Traceable SS** | 2024 | Fingerprinting + Shamir | First traceable SS; tracing key identifies leaked shares; CRYPTO 2024 [[1]](https://eprint.iacr.org/2024/405) |
| **Traceable SS for General Access** | 2024 | LSSS + tracing | Extension to general access structures (beyond threshold) [[1]](https://eprint.iacr.org/2024/405) |
| **Bottom-Up Traceable SS** | 2025 | Social key recovery | Users self-assign shares; tracing in community key recovery model [[1]](https://eprint.iacr.org/2025/2089) |
| **TVSS (Traceable Verifiable SS)** | 2025 | Feldman/Pedersen + tracing | Combines traceability with verifiability against malicious dealers [[1]](https://eprint.iacr.org/2025/318) |
| **TSS-PV (Public Verifiability)** | 2025 | Indistinguishable dummy shares | First publicly verifiable traceable SS; resolves "Provenance Paradox" [[1]](https://eprint.iacr.org/2025/2261) |

**State of the art:** Boneh-Partap-Rotem (CRYPTO 2024), TVSS (2025), TSS-PV (2025); new security dimension for [Secret Sharing](#secret-sharing-schemes-sss). Analogous to [traitor tracing](#broadcast-encryption) but for secret sharing.

---

## Unclonable Secret Sharing

**Goal:** Secret sharing where quantum shares cannot be cloned. If a shareholder tries to duplicate their quantum share, at least one copy becomes useless for reconstruction. Prevents share proliferation — a new quantum security property for [Secret Sharing](#secret-sharing-schemes-sss).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Unclonable Secret Sharing** | 2024 | Quantum no-cloning | First USS; quantum shares; even t colluding shareholders cannot produce extra working copies [[1]](https://eprint.iacr.org/2024/716) |
| **Unclonable Encryption** | 2023 | Quantum (plain model) | Related: ciphertext can only be decrypted once; constructed without quantum RO [[1]](https://eprint.iacr.org/2023/1825) |

**State of the art:** USS (2024); extends [Quantum Copy-Protection](#quantum-copy-protection--uncloneable-encryption) to the secret sharing domain.

---

## Evolving Secret Sharing

**Goal:** Unbounded participants. Share a secret so that new participants can be added indefinitely — without reissuing existing shares and without knowing the total number of participants in advance. Share sizes grow slowly (polylog) with the participant index.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Komargodski-Naor-Yogev Evolving SS** | 2016 | Binary tree + prefix codes | First evolving SS; t-threshold with polylog share size growth [[1]](https://eprint.iacr.org/2016/194) |
| **Evolving SS with Small Shares** | 2017 | Improved construction | Optimized share sizes; O(t · log² i) bits for i-th participant [[1]](https://eprint.iacr.org/2017/510) |
| **Dynamic Evolving SS** | 2020 | Tree-based | Add participants AND update threshold over time [[1]](https://eprint.iacr.org/2020/789) |

**State of the art:** Evolving SS (Komargodski et al. 2016+); useful for long-lived systems where participant set is unknown at setup. Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Secret Sharing with Cheater Detection

**Goal:** Tamper detection during reconstruction. If a participant submits a forged or modified share, the reconstruction algorithm detects the fraud (cheater detection) or identifies the cheater (cheater identification) — rather than silently outputting a wrong secret.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tompa-Woll Cheater Detection** | 1988 | Redundant shares | First cheater-detectable SS; honest majority can detect forged shares [[1]](https://doi.org/10.1007/0-387-34799-2_20) |
| **McEliece-Sarwate (error-correcting)** | 1981 | Reed-Solomon | Shamir SS as Reed-Solomon code; detect/correct errors via decoding [[1]](https://doi.org/10.1145/360363.360369) |
| **Cheater Identifiable SS (Ishai-Sahai)** | 2006 | MAC-based | Identify exactly which participants cheated; optimal cheater tolerance [[1]](https://eprint.iacr.org/2006/140) |
| **Unconditionally Secure Cheater Detection (Ogata et al.)** | 2005 | Information-theoretic | Optimal share size with information-theoretic cheater detection [[1]](https://doi.org/10.1007/978-3-540-30576-7_5) |

**State of the art:** MAC-based cheater identification (Ishai-Sahai 2006); used in malicious-secure [MPC](#multi-party-computation-mpc). Extends [Secret Sharing](#secret-sharing-schemes-sss), complements [Robust SS](#robust-secret-sharing).

---

## Verifiable Information Dispersal (VID)

**Goal:** Reliable data distribution with verification. A dealer encodes data into N shares using erasure coding; each recipient can verify they received a valid share without reconstructing the full data. Foundation of blockchain data availability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cachin-Tessaro VID** | 2005 | Reed-Solomon + hash | Original VID; Byzantine-tolerant dispersal with verification [[1]](https://doi.org/10.1109/RELDIS.2005.5) |
| **AVID (Async VID, Hendricks et al.)** | 2007 | Erasure codes + Merkle | Asynchronous protocol; O(n|M|) total communication [[1]](https://doi.org/10.1145/1281100.1281131) |
| **DispersedLedger** | 2022 | VID + BFT consensus | VID integrated into BFT; separate data from consensus [[1]](https://eprint.iacr.org/2021/868) |
| **EigenDA VID** | 2024 | KZG + RS codes | KZG-committed VID for Ethereum rollup data availability [[1]](https://docs.eigenlayer.xyz/eigenda/overview) |

**State of the art:** KZG-based VID (EigenDA, Ethereum danksharding); closely related to [DAS](#data-availability-sampling-das) and [Commitment Schemes](#commitment-schemes).

---

## Accountable Decryption

**Goal:** Auditable use of decryption keys. Every decryption act produces a publicly verifiable log entry proving the decryption was legitimate. A verifier can identify malicious decryptors who abuse their keys. Distinct from [message franking](#message-franking--abuse-reporting-in-e2e) (which audits message content, not key usage).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tang Accountable Decryption** | 2023 | Signatures + log | Formal model: decryptor must produce verifiable log entry for every decryption; identifies rogue decryptors [[1]](https://eprint.iacr.org/2023/1519) |
| **Practical Accountable Decryption (IEEE TIFS)** | 2024 | TEE + verifiable logs | Production system: identifies malicious decryptors among 300K log entries in 69 ms [[1]](https://ieeexplore.ieee.org/document/10798458/) |

**State of the art:** TEE-enforced accountable decryption (2024); formal model (2023). Complements [Key Transparency](#key-transparency--coniks) (audits key bindings) and [Traceable Signatures](#traceable-signatures) (audits signing).

---

## CRT-based Secret Sharing (Mignotte / Asmuth-Bloom)

**Goal:** Threshold sharing via modular arithmetic. Split a secret into *n* shares using the Chinese Remainder Theorem (CRT) so that any *t* shares reconstruct it by CRT combination, without polynomial interpolation. An integer-arithmetic alternative to Shamir — shares are residues modulo pairwise coprime integers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mignotte's Scheme** | 1983 | CRT + Mignotte sequences | Uses special (t,n)-sequences where the product of the t smallest moduli exceeds that of the t−1 largest; *not* perfect — fewer than t shares can leak partial information [[1]](https://doi.org/10.1007/3-540-39466-4_27) |
| **Asmuth-Bloom Scheme** | 1983 | CRT + randomization | Adds a random multiple of the secret modulus before reduction; achieves *perfect* secrecy — fewer than t shares reveal nothing [[1]](https://doi.org/10.1109/TIT.1983.1056651) |
| **Ideal CRT-based SS** | 2018 | CRT over cyclotomic fields | Constructs ideal (optimal share size) CRT-based schemes for any threshold [[1]](https://eprint.iacr.org/2018/837) |
| **Homomorphic CRT-SS** | 2020 | CRT + homomorphic ext. | Extends Asmuth-Bloom with homomorphic operations on shares; enables CRT-based MPC [[1]](https://www.sciencedirect.com/science/article/pii/S0166218X20303012) |

**State of the art:** Asmuth-Bloom is the standard perfect CRT-based scheme; Mignotte is historically important but imperfect. CRT-based SS is preferred when modular arithmetic is more natural than field arithmetic (e.g., hardware, RSA-based systems). Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Computational Secret Sharing

**Goal:** Shares shorter than the secret. In information-theoretic (t,n)-SS each share must be at least as long as the secret. Under computational security assumptions (bounded adversary), shares can be compressed to |secret|/t plus a small key-dependent overhead — giving dramatic savings for large secrets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Krawczyk SSMS ("Secret Sharing Made Short")** | 1993 | IDA + symmetric enc | Share = encrypt secret with random key k, then Shamir-share k; total share size |S|/t + O(κ); computationally secure [[1]](https://link.springer.com/chapter/10.1007/3-540-48329-2_12) |
| **Rogaway-Bellare RCSS** | 2007 | PRF + commitment | Robust computational SS with unified treatment of all classical SS goals; handles share tampering [[1]](https://dl.acm.org/doi/10.1145/1315245.1315268) |
| **Optimal Computational SS** | 2025 | Information theory + PRF | Tight bounds on share size in the computational model; matches Krawczyk for threshold but extends to general access structures [[1]](https://arxiv.org/abs/2502.02774) |

**State of the art:** Krawczyk's SSMS (1993) remains the standard construction; widely used in practice wherever large files must be split. Key insight: information-theoretic share-size lower bounds do not apply against computationally bounded adversaries. Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Multi-Secret Sharing

**Goal:** Share multiple independent secrets simultaneously. Each secret may have its own access structure (qualified sets). Unlike [Packed Secret Sharing](#packed-secret-sharing), the secrets are not required to share a single threshold; the scheme must hide each secret from unauthorized parties even when some other secrets are revealed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ideal Multi-Secret Sharing (Blundo et al.)** | 1993 | Polynomial | First formal treatment; share k secrets with (possibly distinct) access structures using a single sharing; characterizes when ideal schemes exist [[1]](https://link.springer.com/article/10.1007/BF00189262) |
| **Blundo-De Santis Multi-SS** | 1994 | Polynomial + info theory | CRYPTO '94; information-theoretic lower bounds on share sizes for multi-secret SS [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_17) |
| **Verifiable Multi-SS (Yang-Chang-Hwang)** | 2004 | One-way functions + Shamir | Efficient reusable shares; one polynomial encodes multiple secrets; verification via public commitments [[1]](https://www.sciencedirect.com/science/article/abs/pii/S0140366498001911) |
| **Space-Efficient Computational Multi-SS** | 2018 | PRF + polynomial | Computational multi-SS with share sizes independent of the number of secrets; supports arbitrary access structures [[1]](https://eprint.iacr.org/2018/1010) |

**State of the art:** Computational multi-SS (2018) achieves near-optimal share sizes; widely used in key management, password managers, and threshold wallets where multiple independent secrets must be distributed. Distinct from [Packed SS](#packed-secret-sharing) (which amortizes a single threshold over many secrets) and extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## Regenerating Codes for Distributed Storage

**Goal:** Repair-efficient secret sharing. In a standard (t,n)-SS, repairing a lost share requires downloading the entire secret and re-sharing. Regenerating codes allow a failed node to be repaired by contacting d helper nodes and downloading only a fraction of their data — trading off storage overhead against repair bandwidth, with strong connections to secret sharing and MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dimakis et al. Regenerating Codes** | 2010 | Network coding + cut-set bounds | Foundational paper; identifies MSR (min storage) and MBR (min bandwidth) tradeoff points; file is recoverable from any k of n nodes [[1]](https://doi.org/10.1109/TIT.2010.2054295) |
| **Product-Matrix MSR/MBR** | 2011 | Linear algebra | Explicit optimal exact-regenerating codes at MSR and MBR points; simple product-matrix construction [[1]](https://arxiv.org/abs/1005.4178) |
| **Secure Regenerating Codes** | 2012 | RS codes + secret sharing | Information-theoretic security against eavesdroppers during repair; combines regenerating codes with Shamir sharing [[1]](https://arxiv.org/abs/1210.3664) |
| **Regenerating Codes ↔ Proactive SS** | 2022 | Formal equivalence | Shows formal connections and implications between regenerating codes and proactive secret sharing; unified framework [[1]](https://eprint.iacr.org/2022/096) |

**State of the art:** Regenerating codes are deployed in distributed storage systems (e.g., Azure LRC, Facebook f4) and increasingly connected to [Proactive SS](#proactive-secret-sharing) and [Robust SS](#robust-secret-sharing). Key open problem: efficient exact-repair regenerating codes with strong cryptographic security.

---

## Multiplicative Secret Sharing

**Goal:** Threshold sharing compatible with multiplication. A secret sharing scheme is *multiplicative* if parties can locally multiply their shares of two secrets [a] and [b] to obtain shares of the product a·b, enabling secure multiplication in MPC without interaction. The foundational mechanism behind [BGW](#multi-party-computation-mpc)-style perfectly secure MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir Multiplicative SS (BGW)** | 1988 | Polynomial evaluation | Shamir shares are multiplicative: product of shares lies on degree-2t polynomial; requires degree-reduction sub-protocol [[1]](https://dl.acm.org/doi/10.1145/62212.62213) |
| **d-Multiplicative SS (Ishai-Kushilevitz)** | 2000 | Combinatorics | Characterizes when a sharing scheme supports multiplication of d secrets; tight bounds on adversary threshold [[1]](https://link.springer.com/content/pdf/10.1007/s00145-010-9056-z.pdf) |
| **Multiplicative SS over Z_m** | 2000 | Rings | Extends multiplicative SS to composite moduli (rings); needed for arithmetic over Z_{2^k} in MPC [[1]](https://link.springer.com/chapter/10.1007/3-540-45708-9_18) |
| **Packed Multiplicative SS** | 2022 | Packed Shamir | Combines multiplicative and packed sharing; sharing transformation enables dishonest-majority MPC with amortized communication [[1]](https://eprint.iacr.org/2022/831) |

**State of the art:** Shamir sharing remains the standard multiplicative SS; degree-reduction (via Beaver triples or BGW resharing) is the bottleneck of information-theoretically secure MPC. Packed multiplicative SS (2022) amortizes costs. Central to [MPC](#multi-party-computation-mpc), [Packed SS](#packed-secret-sharing), and [Robust SS](#robust-secret-sharing).

---

## FROST: Flexible Round-Optimized Schnorr Threshold Signatures

**Goal:** Two-round threshold Schnorr signing. Any t-of-n signers collaboratively produce a single valid Schnorr signature in two communication rounds, with the signing key never reconstructed — removing the single point of failure from traditional multisig and threshold schemes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FROST (Komlo-Goldberg)** | 2020 | Schnorr + Shamir VSS | Original protocol; 2-round signing or 1-round with preprocessing; concurrent sessions secure under DL; SAC 2020 [[1]](https://eprint.iacr.org/2020/852) |
| **FROST3 (Security proof)** | 2023 | Schnorr, no AGM | First proof without the Algebraic Group Model; tighter reduction; CRYPTO 2023 [[1]](https://eprint.iacr.org/2023/899) |
| **FROST RFC 9591** | 2024 | Schnorr | IETF/CFRG standardization (June 2024); specifies multiple ciphersuites (secp256k1, Ed25519, Ed448, P-256, Ristretto255) [[1]](https://www.rfc-editor.org/rfc/rfc9591.html) |
| **Re-Randomized FROST** | 2024 | Schnorr + rerandomization | Preserves unlinkability of RedDSA spend-auth signatures in Zcash; production deployment via ZIP 312 [[1]](https://eprint.iacr.org/2024/436) |
| **Dynamic-FROST** | 2024 | FROST + committee changes | Supports adding/removing signers and resharing without a full key ceremony [[1]](https://eprint.iacr.org/2024/896) |

**State of the art:** FROST RFC 9591 (2024) is the IETF standard; deployed in production by the Zcash Foundation (ZIP 312, NU6 2024) and integrated into Safe smart accounts on Ethereum. The FROST DKG companion protocol lives in [DKG](#distributed-key-generation-dkg). Related to [Threshold Signature Schemes](categories/08-signatures-advanced.md#threshold-signature-schemes-tss) in the signatures category.

---

## XOR-Based / Binary-Field Secret Sharing

**Goal:** Hardware-efficient threshold sharing. Replace Shamir's polynomial arithmetic over large prime fields with XOR (exclusive-OR) operations over GF(2) or byte-oriented GF(2^8) — achieving an ideal (t,n)-threshold scheme hundreds of times faster in software and trivially implementable in hardware, at the same information-theoretic security level.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir over GF(2^8) (byte-wise)** | 1979 | GF(2^8) | Standard Shamir applied byte-by-byte; all arithmetic is bitwise; used in practically every modern implementation (libgfshare, SSSS, HashiCorp Vault) [[1]](https://dl.acm.org/doi/10.1145/359168.359176) |
| **Kurihara et al. XOR-SS** | 2008 | XOR only, GF(2^n) | First ideal (t,n)-XOR-only scheme; 900× faster than GF(2^64) Shamir for large secrets; perfect secrecy proven; ISC 2008 / ISITA 2010 [[1]](https://eprint.iacr.org/2008/409) |
| **Efficient XOR-Based (t,n) (Pasalic et al.)** | 2016 | Bent functions + XOR | Reduces share generation cost further; suitable for constrained devices [[1]](https://link.springer.com/chapter/10.1007/978-3-319-48965-0_28) |
| **Secret Sharing with Binary Shares** | 2018 | Linear codes over GF(2) | Information-theoretic bounds for binary-share SS; characterizes achievable rates [[1]](https://eprint.iacr.org/2018/746) |

**State of the art:** GF(2^8) Shamir is the industry default (used in HashiCorp Vault, age-plugin-threshold, SLIP-39). Kurihara's pure-XOR scheme is preferred for high-throughput or hardware contexts. All variants are information-theoretically perfect. Extends [Secret Sharing](#secret-sharing-schemes-sss).

---

## DKLS23: Threshold ECDSA in Three Rounds

**Goal:** Practical t-of-n threshold ECDSA. Any t signers from a group of n jointly produce a standard ECDSA signature in three communication rounds, with security against malicious adversaries — without homomorphic encryption, achieving the lowest round complexity known for threshold ECDSA.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DKLs18 (2-party ECDSA)** | 2018 | OT + MtA | First OT-based 2-of-2 ECDSA; avoids Paillier HE; CCS 2018 [[1]](https://eprint.iacr.org/2018/499) |
| **DKLS23 (t-of-n, 3 rounds)** | 2023 | OT + ZK proofs | Generalizes to arbitrary (t,n); 3-round signing; full malicious security proof; CRYPTO 2023; closed-form cost analysis [[1]](https://eprint.iacr.org/2023/765) |

**State of the art:** DKLS23 (2023) is the state-of-the-art threshold ECDSA protocol: 3 rounds, OT-based (no HE), malicious security, supports key resharing and dynamic sets. Deployed in Vultisig, Silence Laboratories (audited by Trail of Bits 2025), and other MPC wallet stacks. Complements [FROST](#frost-flexible-round-optimized-schnorr-threshold-signatures) (Schnorr) and relates to [Threshold Signature Schemes](categories/08-signatures-advanced.md#threshold-signature-schemes-tss).

---

## Threshold Raccoon: Post-Quantum Lattice Threshold Signatures

**Goal:** Post-quantum threshold signing. Any t-of-n parties collaboratively produce a lattice-based Schnorr-like signature secure under MLWE/MSIS — the first efficient lattice threshold signature that does not require threshold FHE or homomorphic trapdoor commitments, and is compatible with NIST-standardized ML-DSA (Dilithium).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold Raccoon** | 2024 | MLWE + MSIS + OTM | Pairwise one-time additive masks (OTM) hide partial responses; 13 KiB signatures; up to 1024 signers; EUROCRYPT 2024 [[1]](https://eprint.iacr.org/2024/184) |
| **ML-DSA Threshold (del Pino et al.)** | 2025 | ML-DSA (FIPS 204) | Directly adapts Raccoon technique to standardized ML-DSA; supports up to 6 signers; CRYPTO 2025 [[1]](https://eprint.iacr.org/2025/1166) |
| **Olingo** | 2025 | Lattice + DKG + IA | Adds integrated DKG and identifiable abort to lattice threshold signing; first full-stack PQ threshold signature [[1]](https://eprint.iacr.org/2025/1789) |

**State of the art:** Threshold Raccoon (EUROCRYPT 2024) is the first practical post-quantum threshold signature; its ML-DSA variant (2025) enables drop-in PQ threshold signing against FIPS 204. Open problem: reduce communication cost and achieve one-round signing. Complements [FROST](#frost-flexible-round-optimized-schnorr-threshold-signatures) (classical) and relates to [Post-Quantum Cryptography](categories/15-quantum-cryptography.md#post-quantum-cryptography-pqc).

---
