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

## Scantegrity II

**Goal:** End-to-end verifiable optical scan voting. Voters mark a paper ballot with a special pen that reveals invisible-ink confirmation codes, which they note and later look up online to verify their vote was recorded — without revealing how they voted.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Scantegrity I** | 2008 | Invisible ink + hash chain | First optical scan system with E2E verifiability; confirmation codes on ballot revealed by special pen [[1]](https://www.usenix.org/legacy/events/evt08/tech/full_papers/chaum/chaum.pdf) |
| **Scantegrity II** | 2008 | Invisible ink + mixnet | Per-selection invisible-ink codes; voters verify via public bulletin board; mixnet decryption proves tally correctness [[1]](https://www.usenix.org/legacy/event/evt08/tech/full_papers/chaum/chaum_html/index.html) |
| **Takoma Park deployment** | 2009 | Scantegrity II | First governmental binding election using an E2E verifiable system; mayor and city council election [[1]](https://www.semanticscholar.org/paper/Scantegrity-II:-End-to-End-Verifiability-by-Voters-Chaum-Carback/62316a281a81ec21d9ed73458b22f1798d31464c) |

The key insight is that confirmation codes are pre-printed in invisible ink under each candidate bubble. Marking a selection reveals that candidate's code and nothing else. The voter retains the code, and later auditors can verify that the multiset of posted confirmation codes matches a correct encryption of the tally via a publicly verifiable mixnet shuffle. The physical ballot retains its conventional look and feel.

**State of the art:** Scantegrity II remains the only E2E verifiable system deployed in a binding governmental election (2009). Its approach is orthogonal to purely electronic systems like [Helios](#end-to-end-verifiable-e-voting) — it augments paper optical scan without replacing it.

---

## Prêt à Voter

**Goal:** Voter-verifiable paper ballot voting with privacy via randomized candidate ordering. Each ballot has a unique random permutation of candidates; the permutation is committed and later destroyed, while only the marked position is published — preserving verifiability without leaking the vote.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Prêt à Voter (Chaum original)** | 2004 | Onion encryption + mixnet | Candidate list encrypted in onion; ballot right side retained as receipt; left side (permutation) destroyed [[1]](https://doi.org/10.1007/11967514_2) |
| **Prêt à Voter with Re-encryption Mixes** | 2006 | ElGamal + re-encryption mixnet | Ryan & Schneider; distributed ballot construction; re-encryption mixnet replaces decryption mix [[1]](https://link.springer.com/chapter/10.1007/11863908_20) |
| **Prêt à Voter with Paillier Encryption** | 2008 | Paillier HE + ZK | Xia et al.; additive homomorphic tallying; ZK proofs of shuffle correctness [[1]](https://www.usenix.org/legacy/event/evt08/tech/full_papers/xia/xia_html/) |
| **vVote** | 2015 | Prêt à Voter + mixnet | Full implementation deployed in Victorian state election, Australia (2014) [[1]](https://doi.org/10.1145/2746338) |

The voter tears the ballot along a perforation: the left strip (candidate names in permuted order) is surrendered, the right strip (position marks only) is retained as a receipt. The voter later checks their serial number on the bulletin board to verify the encrypted record matches their retained strip. A verifiable mixnet shuffle over all encrypted strips proves the tally.

**State of the art:** vVote deployed in Victoria, Australia (2014) for voters with disabilities. Prêt à Voter's "destroy the permutation" model is the template for many physical E2E systems. Compare [Scantegrity II](#scantegrity-ii) (invisible ink on optical scan) and [E2E E-Voting](#end-to-end-verifiable-e-voting) (electronic ballots).

---

## STAR-Vote

**Goal:** Combine the auditability of paper ballots with cryptographic end-to-end verifiability in a polling place setting. Voters cast ballots on a touchscreen terminal, receive a paper record, and can later verify their encrypted ballot is included in the tally — without a trusted election software stack.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **STAR-Vote system** | 2013 | Threshold ElGamal + homomorphic tally + ZK | Touchscreen DRE produces paper record; ballot encrypted with additive homomorphic threshold scheme; tally computed without decrypting individual ballots [[1]](https://www.usenix.org/system/files/conference/evtwote13/jets-0101-bell.pdf) |
| **Benaloh challenge** | 2006 | Commit-then-reveal | Voter can challenge the machine to prove it encrypted correctly by revealing randomness; ballot then voided and a new one cast [[1]](https://eprint.iacr.org/2006/038) |

STAR-Vote was designed in collaboration between Travis County (Austin, TX) election officials, Rice University, and Microsoft Research. The electronic record of all ballots is maintained in an encrypted form under a threshold public key; no individual ballot is decrypted. The homomorphic property allows aggregating all encrypted ballots into an encrypted tally, which is then decrypted once. Individual ballot verifiability is achieved via the Benaloh challenge: voters may ask the terminal to prove its encryption is honest, sacrificing that ballot.

**State of the art:** STAR-Vote was not ultimately deployed in Travis County due to procurement constraints, but its design is widely cited as the state-of-the-art blueprint for in-person E2E verifiable voting. Extends [E2E E-Voting](#end-to-end-verifiable-e-voting) and [Coercion-Resistant Voting](#coercion-resistant-voting--receipt-freeness).

---

## OpenTimestamps

**Goal:** Trust-minimized, scalable blockchain timestamping. Aggregate an arbitrary number of document hashes into a single Merkle tree and anchor the root in one Bitcoin transaction — providing timestamping proofs that anyone can verify with a Bitcoin full node, with no trusted third party beyond the Bitcoin network itself.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OpenTimestamps protocol** | 2016 | Merkle tree + Bitcoin OP_RETURN | Peter Todd; calendar servers aggregate hashes into Merkle tree; root committed via OP_RETURN; proofs stored in binary `.ots` files [[1]](https://petertodd.org/2016/opentimestamps-announcement) |
| **Merkle Mountain Range (MMR)** | 2016 | Append-only Merkle structure | Calendar server internal structure; O(log n) proof size; used to batch unlimited documents per transaction [[1]](https://github.com/opentimestamps/opentimestamps-server/blob/master/doc/merkle-mountain-range.md) |
| **Internet Archive Carbon Dating** | 2017 | OpenTimestamps + crawl data | Timestamped snapshots of 450 billion web pages with a single Bitcoin transaction [[1]](https://petertodd.org/2017/carbon-dating-the-internet-archive-with-opentimestamps) |

Unlike [RFC 3161](#linked-timestamping) (which requires trusting a TSA and its PKI), an OpenTimestamps proof is self-contained: the verifier checks a Merkle path from the document hash to a Bitcoin block header, which is publicly and independently auditable. Calendar servers (e.g., `alice.btc.calendar.opentimestamps.org`) provide this service for free. The `.ots` proof file encodes a sequence of hash operations and the final Bitcoin attestation.

**State of the art:** Deployed in production for legal, journalistic, and archival use. The Internet Archive, multiple law firms, and the Italian Post Office use OpenTimestamps. Extends [Linked Timestamping](#linked-timestamping) by replacing the trusted TSA with the Bitcoin blockchain.

---

## Cryptographic Lotteries & Fairness Protocols

**Goal:** Conduct a fair, publicly verifiable lottery or random draw with no trusted dealer — any party can verify the draw was unbiased, and no coalition can predict or bias the outcome before the draw closes. Combines commit-reveal with financial penalties or VRFs to deter abort.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Commit-Reveal Lottery** | 1988 | Hash commitment | Each participant commits to a secret; all secrets revealed; XOR/hash of all secrets is the random outcome; abort-prone without penalties [[1]](https://doi.org/10.1145/62212.62220) |
| **Blum Coin Flipping over Telephone** | 1983 | Quadratic residuosity | First cryptographic coin-flip protocol; commitment based on factoring hardness [[1]](https://doi.org/10.1145/1008908.1008911) |
| **Bentov-Kumaresan Bitcoin Fair Protocols** | 2014 | Bitcoin script + MPC | Parties deposit collateral; aborting forfeits deposit; achieves fairness with financial incentives; multiparty lottery in O(n) Bitcoin transactions [[1]](https://eprint.iacr.org/2014/129) |
| **TYCHE: Coalition-Resistant Lotteries** | 2024 | Commit-reveal + ZK | Collateral-free multiparty lottery; ZK proofs prevent last-revealer advantage without requiring deposits [[1]](https://arxiv.org/abs/2409.03464) |
| **VRF-based Lottery** | 2017 | Verifiable Random Function | Each party computes a VRF on a common seed; minimum output wins; verifiable and non-interactive after seed is fixed [[1]](https://eprint.iacr.org/2017/099) |

The core challenge is the "last-revealer problem": in a commit-reveal protocol the last party to reveal can abort if the outcome is unfavorable, biasing the distribution. Solutions include: financial penalties via smart contracts (Bentov-Kumaresan), threshold randomness beacons (no single party controls the outcome), or VRFs combined with a pre-committed seed. Applications include blockchain leader election, provably fair games, and government lotteries.

**State of the art:** VRF-based lotteries (used in Cardano, Algorand, Ethereum RANDAO) for blockchain leader election; Bitcoin-collateral protocols for fully trustless settings. See [VRF](#verifiable-random-function-vrf) and [Randomness Beacons](#randomness-beacons).

---
