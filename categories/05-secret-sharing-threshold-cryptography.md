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
