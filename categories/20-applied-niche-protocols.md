# Applied & Niche Protocols

## End-to-End Verifiable E-Voting

**Goal:** Voter-verifiable elections. Anyone can verify that votes were correctly counted, each voter can verify their vote was included, and ballot secrecy is maintained. Combines mixnets, HE, ZK, and blind signatures.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Helios** | 2008 | ElGamal HE + ZK | First practical web-based verifiable voting; used in IACR elections [[1]](https://www.usenix.org/legacy/events/sec08/tech/full_papers/adida/adida.pdf) |
| **Belenios** | 2015 | Helios + mixnet | Adds stronger ballot privacy via mixnet decryption; French academic elections [[1]](https://hal.inria.fr/hal-02066930/document) |
| **Civitas** | 2008 | Blind sig + credential | Coercion-resistant; voter gets real + fake credentials [[1]](https://ieeexplore.ieee.org/document/4531145) |
| **Swiss Post / Scytl** | 2019 | Mixnet + ZK shuffle | National-scale; verifiable shuffle of encrypted ballots [[1]](https://eprint.iacr.org/2019/838) |

**State of the art:** Belenios (academic/organization elections), mixnet-based (national scale). E-voting remains one of the hardest applied crypto problems.

---

## Visual Cryptography

**Goal:** Information-theoretic image sharing. Split an image into N shares printed on transparencies — overlaying any t shares reveals the image, fewer than t shares reveal nothing. No computation, no cryptographic assumptions — purely visual.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Shamir Visual SS** | 1994 | Pixel expansion | First (2,2) visual scheme; each pixel → 2×2 subpixels per share [[1]](https://doi.org/10.1007/BFb0053419) |
| **(k,n) Visual SS** | 1996 | Combinatorial | General threshold; Ateniese-Blundo-De Santis-Stinson [[1]](https://doi.org/10.1016/S0020-0190(96)00127-4) |
| **Extended Visual Crypto (EVC)** | 1996 | Meaningful shares | Each share looks like a valid image (not noise); shares reveal secret when overlaid [[1]](https://doi.org/10.1007/BFb0052995) |
| **Colored Visual Crypto** | 1997 | Color mixing | Extension to color images [[1]](https://doi.org/10.1007/BFb0028175) |
| **Progressive Visual SS (Jin et al.)** | 2004 | Multi-resolution | Image sharpens progressively as more shares added beyond threshold; partial trust = partial information [[1]](https://www.researchgate.net/publication/332575738) |

**State of the art:** (k,n) visual SS with meaningful shares; applications in physical document security. Pure information-theoretic security — see [OTP](#one-time-pad--information-theoretic-security).

---

## Linked Timestamping

**Goal:** Prove a document existed at a specific time. Chain documents together using cryptographic hashes — each timestamp depends on all previous ones, creating a tamper-evident timeline. The direct precursor to blockchain.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Haber-Stornetta Linked Timestamping** | 1991 | Hash chain | First secure timestamping; documents linked in hash chain [[1]](https://doi.org/10.1007/BF00196791) |
| **Bayer-Haber-Stornetta (Merkle tree TS)** | 1993 | Merkle tree | Batch timestamps into Merkle tree; O(log n) proof size [[1]](https://doi.org/10.1007/978-1-4613-9323-8_24) |
| **RFC 3161 Timestamp Protocol** | 2001 | PKI + hash | Internet standard; trusted timestamp authority signs hash + time [[1]](https://www.rfc-editor.org/rfc/rfc3161) |
| **Guardtime KSI** | 2007 | Hash calendar | Keyless Signatures Infrastructure; hash-based, no PKI dependency [[1]](https://guardtime.com/technology) |

**State of the art:** Guardtime KSI (deployed in Estonian e-government); blockchain-based timestamping inherits Haber-Stornetta's design. Three of their papers are cited in the [Bitcoin whitepaper](https://bitcoin.org/bitcoin.pdf).

---

## Coercion-Resistant Voting / Receipt-Freeness

**Goal:** Prevent vote buying and coercion. A voter cannot prove to a coercer how they voted — even if they want to. Stronger than ballot secrecy: the voter actively cannot produce a receipt. Essential for real elections beyond [basic e-voting](#end-to-end-verifiable-e-voting).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Benaloh-Tuinstra Receipt-Free Voting** | 1994 | Physical assumptions | First receipt-free protocol; requires untappable channel [[1]](https://doi.org/10.1145/191177.191209) |
| **Juels-Catalano-Jakobsson (JCJ)** | 2005 | Credential-based | First coercion-resistant internet voting; fake credentials for coerced voters [[1]](https://dl.acm.org/doi/10.5555/1102199.1102213) |
| **Civitas** | 2008 | JCJ + implementation | First practical coercion-resistant system; distributed trust [[1]](https://doi.org/10.1109/SP.2008.32) |
| **Selene** | 2015 | Tracking numbers | Voters verify their vote via personal tracker; coercer cannot link tracker to voter [[1]](https://eprint.iacr.org/2015/1105) |

**State of the art:** Selene (2015) for usability; JCJ model for formal guarantees. Extends [E-Voting](#end-to-end-verifiable-e-voting).

---

## Proof of Secure Erasure (PoSE)

**Goal:** Prove data was deleted. A device proves to a remote verifier that specific data has been erased from its memory — by filling the entire memory with challenge-derived data, leaving no room for the secret. Enables GDPR "right to be forgotten" verification and remote attestation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Perito-Tsudik PoSE** | 2010 | Memory-filling challenge | First PoSE; verifier sends challenge that fills all RAM; device responds with hash [[1]](https://doi.org/10.1007/978-3-642-15497-3_2) |
| **Dziembowski et al. Proofs of Space** | 2015 | Graph pebbling | Formal model connecting erasure proofs to space complexity [[1]](https://eprint.iacr.org/2013/796) |
| **PoSE for SGX Enclaves** | 2018 | TEE + attestation | Prove enclave data erased using hardware attestation [[1]](https://doi.org/10.1145/3243734.3243745) |

**State of the art:** Memory-filling PoSE for embedded/IoT; SGX-based for cloud. Related to [PoW/PoSpace](#proof-of-work-pow--proof-of-space).

---

## Key-Insulated Cryptography

**Goal:** Temporal key isolation. Compromise of the current secret key does not reveal past or future keys — even without secure erasure. A physically secure "helper" device updates the user's key each time period, but the helper alone cannot sign or decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Katz-Xu-Yung Key-Insulated Sigs** | 2002 | DLP / RSA | First key-insulated scheme; helper updates user key per period [[1]](https://eprint.iacr.org/2002/064) |
| **Strong Key-Insulation** | 2003 | DLP | Even compromising helper + one period doesn't break other periods [[1]](https://doi.org/10.1007/3-540-39200-9_8) |
| **Intrusion-Resilient Sigs (Itkis-Reyzin)** | 2002 | DLP | Combines forward security + key-insulation [[1]](https://doi.org/10.1007/3-540-36178-2_33) |

**State of the art:** Key-insulated schemes fill the gap between [Forward-Secure Crypto](#forward-secure-signatures--encryption) (no helper needed) and [Proactive SS](#proactive-secret-sharing) (distributed). Used in smart card + host scenarios.

---

## Client Puzzles / Proof of Effort

**Goal:** DoS resistance. A server issues a computational puzzle to a client before committing resources — legitimate clients solve easily, but an attacker must spend proportional effort per request. Adjustable difficulty without centralized rate limiting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Juels-Brainard Client Puzzles** | 1999 | Hash inversion | First formal client puzzle; find partial hash preimage [[1]](https://doi.org/10.1007/978-1-4471-0641-2_11) |
| **Merkle Puzzles** | 1978 | Symmetric encryption | Original "puzzle" construction for key exchange; O(n²) vs O(n) gap [[1]](https://doi.org/10.1007/978-1-4684-3386-7_5) |
| **TLS Client Puzzles (RFC draft)** | 2019 | Hash | Extension to TLS handshake; server issues puzzle during ClientHello [[1]](https://datatracker.ietf.org/doc/draft-nir-tls-puzzles/) |
| **VDF-based Puzzles** | 2018 | Sequential squaring | Non-parallelizable puzzles; fair regardless of hardware [[1]](https://eprint.iacr.org/2018/601) |

**State of the art:** VDF-based puzzles for fairness; hash-based puzzles for simplicity. Precursor to [PoW](#proof-of-work-pow--proof-of-space). See also [Time-Lock Puzzles](#time-lock-puzzles--timed-release-encryption).

---

## Incremental Cryptography

**Goal:** Efficient updates. When data is modified (insert, delete, edit), update the hash, MAC, or signature incrementally — without recomputing from scratch. Critical for large files, streaming data, and version-controlled content.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Incremental Hashing (BGG)** | 1994 | Universal hash | First formalization; update hash after data modification in O(change size) [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Incremental MAC (Bellare et al.)** | 1995 | XOR-based MAC | Update MAC without rehashing entire message [[1]](https://doi.org/10.1007/BFb0015744) |
| **Incremental Signatures (Bellare et al.)** | 1994 | Tree-based | Update signature when document changes; logarithmic cost [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Authenticated Data Structures (Tamassia)** | 2003 | Merkle + skip lists | Generalized framework: any data structure with authenticated incremental updates [[1]](https://doi.org/10.1007/3-540-39658-0_2) |

**State of the art:** Merkle-based authenticated data structures (widely deployed); incremental hashing in rsync, IPFS, git. See [Accumulators](#accumulators), [Hash Functions](#hash-functions).

---
