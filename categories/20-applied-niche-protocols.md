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

**Production readiness:** Experimental
Helios and Belenios used in organizational elections (IACR, universities); no deployment in national-scale binding governmental elections with full E2E verifiability.

**Implementations:**
- [Helios](https://github.com/benadida/helios-server) ⭐ 888 — Python, open-source web-based voting server
- [Belenios](https://gitlab.inria.fr/belenios/belenios) — OCaml, INRIA-maintained, used in French academic elections
- [Verificatum](https://www.verificatum.org/) — Java, universal verifiable mixnet used in Swiss Post and other systems

**Security status:** Caution
Cryptographic foundations are sound, but real-world deployments must address coercion, voter authentication, and usability; no system has achieved all properties simultaneously at scale.

**Community acceptance:** Emerging
Active academic community (USENIX EVT/WOTE, E-Vote-ID conferences); no IETF/NIST standard; adoption limited to organizational and pilot elections.

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

**State of the art:** (k,n) visual SS with meaningful shares; applications in physical document security. Pure information-theoretic security — see [OTP](01-foundational-primitives.md#one-time-pad-information-theoretic-security).

**Production readiness:** Research
Academic demonstrations and physical document security prototypes; no widely deployed commercial product.

**Implementations:**
- [libvcs](https://github.com/Shree987/Visual-Cryptography) ⭐ 26 — Python, reference implementation of Naor-Shamir (2,2) visual secret sharing
- [VisualCrypto](https://github.com/Shree987/Visual-Cryptography) ⭐ 26 — Java, (k,n) visual secret sharing with meaningful shares

**Security status:** Secure
Information-theoretic security; no cryptographic assumptions required. Pixel expansion reduces image quality but does not affect secrecy.

**Community acceptance:** Niche
Well-studied in academic literature since 1994; limited practical adoption due to pixel expansion and the requirement for physical transparency overlays.

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

**Production readiness:** Production
Guardtime KSI deployed in Estonian e-government since 2007; RFC 3161 TSAs operated by DigiStamp, FreeTSA, and others; widely used in legal and compliance contexts.

**Implementations:**
- [Guardtime KSI](https://github.com/guardtime) — C/Java, production KSI SDK
- [OpenTSA](https://github.com/opentsa) — C, RFC 3161-compliant timestamp authority
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, includes RFC 3161 TSP implementation

**Security status:** Secure
Hash-chain and Merkle-tree based; security reduces to collision resistance of the hash function. KSI avoids PKI trust issues by using hash calendars.

**Community acceptance:** Standard
RFC 3161 is an IETF standard; Guardtime KSI adopted by NATO, Estonian government, and multiple EU institutions. Blockchain timestamping is a de facto industry standard.

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

**Production readiness:** Research
Civitas has a research prototype; Selene demonstrated in pilot elections; no production deployment in binding governmental elections.

**Implementations:**
- [Civitas](https://www.cs.cornell.edu/projects/civitas/) — Java, Cornell research prototype of JCJ-based coercion-resistant voting

**Security status:** Caution
Cryptographic guarantees are strong under stated assumptions (untappable channels, honest authorities); real-world deployment requires careful trust model validation.

**Community acceptance:** Niche
Active research area in the voting security community; JCJ model is the reference formalization for coercion resistance; no standardization effort.

---

## Proof of Secure Erasure (PoSE)

**Goal:** Prove data was deleted. A device proves to a remote verifier that specific data has been erased from its memory — by filling the entire memory with challenge-derived data, leaving no room for the secret. Enables GDPR "right to be forgotten" verification and remote attestation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Perito-Tsudik PoSE** | 2010 | Memory-filling challenge | First PoSE; verifier sends challenge that fills all RAM; device responds with hash [[1]](https://doi.org/10.1007/978-3-642-15497-3_2) |
| **Dziembowski et al. Proofs of Space** | 2015 | Graph pebbling | Formal model connecting erasure proofs to space complexity [[1]](https://eprint.iacr.org/2013/796) |
| **PoSE for SGX Enclaves** | 2018 | TEE + attestation | Prove enclave data erased using hardware attestation [[1]](https://doi.org/10.1145/3243734.3243745) |

**State of the art:** Memory-filling PoSE for embedded/IoT; SGX-based for cloud. Related to [PoW/PoSpace](#proof-of-unique-human-worldcoin-proof-of-personhood).

**Production readiness:** Research
Academic prototypes only; SGX-based PoSE demonstrated in lab settings; no commercial deployment for GDPR compliance verification.

**Implementations:**
- No widely maintained open-source PoSE implementation exists; research code available from individual papers.
- [SWATT](https://github.com/kevinb6e/swatt) ⭐ 5 — C, software-based attestation for embedded devices (related memory-filling approach)

**Security status:** Caution
Memory-filling PoSE assumes the prover has no hidden storage; SGX-based variants depend on Intel SGX security, which has known side-channel vulnerabilities (Foreshadow, Plundervolt).

**Community acceptance:** Niche
Academic interest in IoT attestation and GDPR compliance; no standardization; limited adoption outside research prototypes.

---

## Key-Insulated Cryptography

**Goal:** Temporal key isolation. Compromise of the current secret key does not reveal past or future keys — even without secure erasure. A physically secure "helper" device updates the user's key each time period, but the helper alone cannot sign or decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dodis-Katz-Xu-Yung Key-Insulated Sigs** | 2002 | DLP / RSA | First key-insulated scheme; helper updates user key per period [[1]](https://eprint.iacr.org/2002/064) |
| **Strong Key-Insulation** | 2003 | DLP | Even compromising helper + one period doesn't break other periods [[1]](https://doi.org/10.1007/3-540-39200-9_8) |
| **Intrusion-Resilient Sigs (Itkis-Reyzin)** | 2002 | DLP | Combines forward security + key-insulation [[1]](https://doi.org/10.1007/3-540-36178-2_33) |

**State of the art:** Key-insulated schemes fill the gap between [Forward-Secure Crypto](08-signatures-advanced.md#forward-secure-signatures-encryption) (no helper needed) and [Proactive SS](05-secret-sharing-threshold-cryptography.md#proactive-secret-sharing) (distributed). Used in smart card + host scenarios.

**Production readiness:** Research
Academic constructions with no widely deployed production systems; smart card + host model has seen limited commercial prototyping.

**Implementations:**
- No widely maintained open-source implementations; reference code available from original papers (Dodis-Katz-Xu-Yung).

**Security status:** Secure
Provably secure under standard assumptions (DLP, RSA); strong key-insulation provides security even against combined helper + single-period compromise.

**Community acceptance:** Niche
Well-studied in academic cryptography; fills a specific gap between forward security and proactive secret sharing; limited industry adoption.

---

## Client Puzzles / Proof of Effort

**Goal:** DoS resistance. A server issues a computational puzzle to a client before committing resources — legitimate clients solve easily, but an attacker must spend proportional effort per request. Adjustable difficulty without centralized rate limiting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Juels-Brainard Client Puzzles** | 1999 | Hash inversion | First formal client puzzle; find partial hash preimage [[1]](https://doi.org/10.1007/978-1-4471-0641-2_11) |
| **Merkle Puzzles** | 1978 | Symmetric encryption | Original "puzzle" construction for key exchange; O(n²) vs O(n) gap [[1]](https://doi.org/10.1007/978-1-4684-3386-7_5) |
| **TLS Client Puzzles (RFC draft)** | 2019 | Hash | Extension to TLS handshake; server issues puzzle during ClientHello [[1]](https://datatracker.ietf.org/doc/draft-nir-tls-puzzles/) |
| **VDF-based Puzzles** | 2018 | Sequential squaring | Non-parallelizable puzzles; fair regardless of hardware [[1]](https://eprint.iacr.org/2018/601) |

**State of the art:** VDF-based puzzles for fairness; hash-based puzzles for simplicity. Precursor to [PoW](#proof-of-unique-human-worldcoin-proof-of-personhood). See also [Time-Lock Puzzles](#time-release-cryptography-timed-commitments).

**Production readiness:** Mature
Hash-based client puzzles deployed in TLS extensions (experimental), anti-spam systems, and Bitcoin PoW; VDF-based puzzles in blockchain research prototypes.

**Implementations:**
- [HashCash](https://github.com/hashcash-org/hashcash) ⭐ 6 — C, original hash-based proof-of-work implementation

**Security status:** Secure
Hash-based puzzles are secure under random oracle assumptions; VDF-based puzzles provide non-parallelizability guarantees under sequential squaring assumptions.

**Community acceptance:** Widely trusted
HashCash concept underlies Bitcoin PoW; client puzzles well-studied since 1999; TLS client puzzle drafts at IETF; VDF puzzles endorsed by Ethereum research.

---

## Incremental Cryptography

**Goal:** Efficient updates. When data is modified (insert, delete, edit), update the hash, MAC, or signature incrementally — without recomputing from scratch. Critical for large files, streaming data, and version-controlled content.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Incremental Hashing (BGG)** | 1994 | Universal hash | First formalization; update hash after data modification in O(change size) [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Incremental MAC (Bellare et al.)** | 1995 | XOR-based MAC | Update MAC without rehashing entire message [[1]](https://doi.org/10.1007/BFb0015744) |
| **Incremental Signatures (Bellare et al.)** | 1994 | Tree-based | Update signature when document changes; logarithmic cost [[1]](https://doi.org/10.1007/3-540-48329-2_22) |
| **Authenticated Data Structures (Tamassia)** | 2003 | Merkle + skip lists | Generalized framework: any data structure with authenticated incremental updates [[1]](https://doi.org/10.1007/3-540-39658-0_2) |

**State of the art:** Merkle-based authenticated data structures (widely deployed); incremental hashing in rsync, IPFS, git. See [Accumulators](09-commitments-verifiability.md#accumulators), [Hash Functions](01-foundational-primitives.md#hash-functions).

**Production readiness:** Production
Merkle-based authenticated data structures deployed in git, IPFS, Certificate Transparency, and blockchain systems; incremental hashing used in rsync.

**Implementations:**
- [git](https://github.com/git/git) ⭐ 60k — C, uses Merkle-tree content-addressable storage with incremental updates
- [IPFS / go-merkledag](https://github.com/ipfs/go-merkledag) ⭐ 84 — Go, Merkle DAG with incremental updates
- [Google Trillian](https://github.com/google/trillian) ⭐ 3.7k — Go, verifiable data structures (Merkle log + map)

**Security status:** Secure
Security reduces to collision resistance of the underlying hash function; well-understood constructions with decades of deployment.

**Community acceptance:** Widely trusted
Merkle-tree authenticated data structures are foundational in version control, content distribution, and transparency logs; incremental hashing is a standard technique.

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

**Production readiness:** Experimental
Successfully deployed in one binding governmental election (Takoma Park 2009); no subsequent deployments or active development.

**Implementations:**
- [Scantegrity](https://github.com/rcarback/scantegrity) ⭐ 1 — Java, reference implementation from the Scantegrity project team

**Security status:** Secure
E2E verifiability proven under standard assumptions; physical invisible-ink layer adds a unique assurance channel; no known cryptographic weaknesses.

**Community acceptance:** Niche
Historically significant as the first E2E system in a binding governmental election; not actively developed or deployed since 2009; cited as a reference in voting security literature.

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

**Production readiness:** Experimental
vVote deployed in the 2014 Victorian state election (Australia) for assisted voting; academic prototypes exist but no ongoing large-scale deployment.

**Implementations:**
- [vVote](https://github.com/vVote) — Java, implementation used in the Victorian 2014 election
- [Verificatum](https://www.verificatum.org/) — Java, the mixnet backend used by vVote and other Pret a Voter variants

**Security status:** Secure
Cryptographic design is sound under standard assumptions (ElGamal, Paillier, verifiable mixnet); physical ballot destruction enforces receipt-freeness.

**Community acceptance:** Niche
Influential in the E2E voting research community; vVote is a notable real-world deployment; not standardized or widely adopted beyond pilot elections.

---

## STAR-Vote

**Goal:** Combine the auditability of paper ballots with cryptographic end-to-end verifiability in a polling place setting. Voters cast ballots on a touchscreen terminal, receive a paper record, and can later verify their encrypted ballot is included in the tally — without a trusted election software stack.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **STAR-Vote system** | 2013 | Threshold ElGamal + homomorphic tally + ZK | Touchscreen DRE produces paper record; ballot encrypted with additive homomorphic threshold scheme; tally computed without decrypting individual ballots [[1]](https://www.usenix.org/system/files/conference/evtwote13/jets-0101-bell.pdf) |
| **Benaloh challenge** | 2006 | Commit-then-reveal | Voter can challenge the machine to prove it encrypted correctly by revealing randomness; ballot then voided and a new one cast [[1]](https://eprint.iacr.org/2006/038) |

STAR-Vote was designed in collaboration between Travis County (Austin, TX) election officials, Rice University, and Microsoft Research. The electronic record of all ballots is maintained in an encrypted form under a threshold public key; no individual ballot is decrypted. The homomorphic property allows aggregating all encrypted ballots into an encrypted tally, which is then decrypted once. Individual ballot verifiability is achieved via the Benaloh challenge: voters may ask the terminal to prove its encryption is honest, sacrificing that ballot.

**State of the art:** STAR-Vote was not ultimately deployed in Travis County due to procurement constraints, but its design is widely cited as the state-of-the-art blueprint for in-person E2E verifiable voting. Extends [E2E E-Voting](#end-to-end-verifiable-e-voting) and [Coercion-Resistant Voting](#coercion-resistant-voting-receipt-freeness).

**Production readiness:** Research
Design completed but never deployed due to procurement constraints in Travis County; remains a reference architecture for in-person E2E voting.

**Implementations:**
- [STAR-Vote prototype](https://www.usenix.org/system/files/conference/evtwote13/jets-0101-bell.pdf) — design specification only; no publicly available production implementation

**Security status:** Secure
Cryptographic design is sound (threshold ElGamal, homomorphic tally, Benaloh challenge); peer-reviewed by leading voting security researchers.

**Community acceptance:** Niche
Widely cited as the gold-standard blueprint for polling-place E2E voting; endorsed by election security experts; blocked by non-technical procurement barriers.

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

**Production readiness:** Production
Deployed by the Internet Archive, Italian Post Office, and numerous law firms; free public calendar servers operational since 2016.

**Implementations:**
- [opentimestamps-client](https://github.com/opentimestamps/opentimestamps-client) ⭐ 387 — Python, CLI client for creating and verifying timestamps
- [opentimestamps-server](https://github.com/opentimestamps/opentimestamps-server) ⭐ 251 — Python, calendar server aggregating timestamps into Bitcoin
- [javascript-opentimestamps](https://github.com/opentimestamps/javascript-opentimestamps) ⭐ 147 — JavaScript, browser/Node.js client library

**Security status:** Secure
Security reduces to Bitcoin's proof-of-work consensus and SHA-256 collision resistance; no trusted third party beyond the Bitcoin network.

**Community acceptance:** Niche
Well-regarded in the timestamping and archival communities; not an IETF or ISO standard; adoption concentrated in legal, journalistic, and blockchain-adjacent domains.

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

**State of the art:** VRF-based lotteries (used in Cardano, Algorand, Ethereum RANDAO) for blockchain leader election; Bitcoin-collateral protocols for fully trustless settings. See [VRF](#verifiable-delay-functions-vdfs) and [Randomness Beacons](01-foundational-primitives.md#randomness-extractors).

**Production readiness:** Production
VRF-based leader election deployed in Cardano (Ouroboros), Algorand, and Ethereum (RANDAO); commit-reveal lotteries used in various smart contract platforms.

**Implementations:**
- [Cardano Ouroboros VRF](https://github.com/input-output-hk/cardano-base) ⭐ 105 — Haskell, VRF-based leader election in production
- [Algorand VRF](https://github.com/algorand/go-algorand) ⭐ 1.4k — Go, VRF for sortition-based consensus
- [RANDAO](https://github.com/randao/randao) ⭐ 851 — Solidity, commit-reveal randomness beacon on Ethereum

**Security status:** Secure
VRF-based lotteries provably secure under DDH; commit-reveal schemes vulnerable to last-revealer abort without financial penalties or VDF enforcement.

**Community acceptance:** Widely trusted
VRF-based leader election is standard in proof-of-stake blockchains; commit-reveal is a foundational MPC primitive; active IETF VRF standardization (RFC 9381).

---

## MarkPledge: Cast-as-Intended Verifiable Voting

**Goal:** Give a voter immediate, human-verifiable assurance that the voting terminal encrypted the intended candidate — without requiring the voter to trust any software or hardware and without leaving a usable receipt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **MarkPledge (Neff)** | 2004 | ZK proof + voter challenge | Voter issues a random challenge; terminal produces a short "pledge string" (4–5 chars) proving correct encryption; voter compares strings [[1]](https://www.usenix.org/legacy/events/evt06/tech/full_papers/adida/adida.pdf) |
| **MarkPledge2 / Ballot Casting Assurance (Adida-Neff)** | 2006 | ZK + simulated proofs | All candidates get a proof transcript — one real, rest simulated; coercer cannot tell which was genuine; first covert-channel-resistant, receipt-free cast-as-intended scheme usable without trusted hardware [[1]](https://eprint.iacr.org/2008/207) |
| **MarkPledge3 (MP3)** | 2009 | Optimized ZK | Most efficient MarkPledge variant; shorter ballot; statistical soundness of 1 − 2⁻²⁰ to 1 − 2⁻³⁰ [[1]](https://www.usenix.org/legacy/events/evtwote09/tech/full_papers/adida-casting.pdf) |

The key insight is that the terminal can prove correct encryption by running a ZK proof where the voter supplies the challenge (so the terminal cannot pre-compute a cheating response). Because all candidates receive a proof transcript — one genuinely verified, the rest simulated — a coercer holding the voter's receipt cannot determine which candidate was actually chosen, eliminating the covert channel problem that plagued earlier cast-as-intended schemes. The voter performs only short-string comparison; no cryptographic computation is needed on the voter's side.

**State of the art:** MarkPledge2/MP3 remain the reference design for cast-as-intended verifiability in polling-place systems. The technique is orthogonal to the counted-as-cast layer provided by mixnets or homomorphic tallying; both layers must be combined for full E2E verifiability. Compare [Scantegrity II](#scantegrity-ii) (invisible-ink confirmation codes) and [STAR-Vote](#star-vote) (Benaloh challenge for the same cast-as-intended property).

**Production readiness:** Research
Academic prototypes (MP2, MP3) demonstrated in lab and pilot settings; no deployment in a binding election.

**Implementations:**
- No widely maintained open-source implementation; reference code accompanies the original USENIX papers by Adida and Neff.

**Security status:** Secure
ZK-based cast-as-intended verification is sound; simulated proofs for non-chosen candidates eliminate the covert channel; statistical soundness parameters are configurable.

**Community acceptance:** Niche
Reference design in the voting security literature for cast-as-intended verifiability; well-cited but not deployed or standardized.

---

## Wombat Voting System

**Goal:** End-to-end verifiable voting that retains a physical paper trail. Voters mark a paper ballot that is scanned and encrypted on-site; a verifiable mixnet proves that the published encrypted ballots correctly decrypt to the announced tally, while the paper originals allow a conventional hand-recount as an independent check.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wombat v1** | 2011 | Verificatum re-encryption mixnet | First deployment; student council election at IDC Herzliya (~2 000 voters); dual paper + cryptographic audit [[1]](https://wombat.factcenter.org/) |
| **Wombat v2 / Ben-Nun et al.** | 2012 | Verificatum (Wikström TW mixnet) + paper ballot | Full academic description; Israeli Meretz party primary; paper ballots scanned, encrypted, shuffled via Verificatum; shuffle proven with Wikström's universally verifiable mixnet [[1]](https://dl.gi.de/items/2a8596f9-3105-487b-8336-67fab31d6f53) |

The system's design principle is "dual-mode auditability": the paper ballots allow a traditional recount, while the cryptographic layer independently proves the electronic tally is correct. The underlying mixnet is Verificatum, which produces a zero-knowledge proof of correct shuffle verifiable by any third party. A voter who suspects their ballot was mis-scanned can demand a manual check of the paper original without undermining the cryptographic audit of all other ballots.

**State of the art:** Wombat is one of the few E2E verifiable systems actually deployed in binding political elections (Meretz primary, Israel, 2012). Its "paper + cryptographic" dual-channel design influenced subsequent hybrid systems. The Verificatum mixnet it relies on is also used in the Swiss Post system. Compare [Prêt à Voter](#prêt-à-voter) (randomized candidate order on paper) and [Scantegrity II](#scantegrity-ii) (invisible-ink codes on optical scan).

**Production readiness:** Experimental
Deployed in binding political elections (Meretz primary 2012, IDC Herzliya student council); limited to small-scale elections.

**Implementations:**
- [Wombat Voting](https://wombat.factcenter.org/) — Java, open-source E2E verifiable voting system
- [Verificatum](https://www.verificatum.org/) — Java, the universally verifiable mixnet used by Wombat

**Security status:** Secure
Dual paper + cryptographic audit provides independent verification channels; Verificatum mixnet is provably secure; no known cryptographic weaknesses.

**Community acceptance:** Niche
Notable as one of few E2E systems used in binding political elections; academic community recognition; no standardization or wide adoption.

---

## Cryptographic Sealed-Bid Auctions

**Goal:** Conduct a sealed-bid auction — including Vickrey (second-price) and VCG (Vickrey-Clarke-Groves) multi-item auctions — so that no party learns any bid other than the minimum information implied by the outcome, while the winning price and allocation are publicly verifiable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Franklin-Reiter Secure Auction Service** | 1996 | Threshold secret sharing + distributed servers | First cryptographic sealed-bid auction; bids secret-shared across servers; winner determined by threshold decryption only after bidding closes [[1]](https://ieeexplore.ieee.org/document/502223/) |
| **Naor-Pinkas-Sumner Privacy-Preserving Auctions** | 1999 | Oblivious transfer + Yao's GC | First general MPC auction; any auction type computable as a circuit; auctioneer + issuer model; no bid revealed even to auctioneer if servers do not collude [[1]](https://doi.org/10.1145/336992.337028) |
| **Kikuchi (M+1)-st Price Auction** | 2001 | Polynomial secret sharing | Bidding prices encoded as polynomials shared among auctioneers; winner found without revealing any losing bid [[1]](https://link.springer.com/chapter/10.1007/3-540-45664-3_8) |
| **Abe-Suzuki M+1-st Price with HE** | 2002 | Homomorphic encryption | Comparison circuit replaced by additive HE; more efficient than OT-based approaches for multi-unit auctions [[1]](https://link.springer.com/chapter/10.1007/3-540-45664-3_8) |
| **Brandt Fully Private Auctions** | 2006 | MPC with no TTP | First protocol with no auctioneer at all; all bidders jointly run MPC; unconditional privacy against minority coalitions [[1]](https://link.springer.com/article/10.1007/s10207-005-0078-5) |
| **Secure Generalized VCG (Suzuki-Yokoo)** | 2003 | HE + combinatorial optimization | Extends HE-based Vickrey to multi-item VCG; bidders compute Clarke payments without revealing valuations [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45126-6_17) |

The core challenge is that the winner determination and payment rules in Vickrey/VCG auctions require comparing all bids — but revealing bids to a central auctioneer allows bid manipulation. MPC-based solutions remove the trusted auctioneer entirely. HE-based solutions let an auctioneer compute the winner and price on encrypted bids without learning individual values. In the VCG case the Clarke payment for each winner equals the externality they impose on others — computing this requires evaluating the social welfare optimization on all bids, which maps naturally to an MPC circuit or an FHE evaluation.

**State of the art:** HE-based sealed-bid auctions (deployed in procurement and spectrum auctions); MPC-based VCG for settings requiring no trusted auctioneer. Related to [Sealed-Bid Auctions (ORAM/PIR based)](10-privacy-preserving-computation.md#sealed-bid-auction-protocols) and [MPC](06-multi-party-computation.md#multi-party-computation).

**Production readiness:** Mature
HE-based sealed-bid auctions used in government procurement and spectrum auctions; MPC-based VCG demonstrated in research prototypes; Brandt's fully private auction has working implementations.

**Implementations:**
- [MP-SPDZ](https://github.com/data61/MP-SPDZ) ⭐ 1.1k — C++/Python, general MPC framework usable for sealed-bid auction protocols
- [SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, Microsoft HE library for homomorphic bid evaluation
- [ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, mixed-protocol MPC framework for auction circuits

**Security status:** Secure
Provably secure under standard HE/MPC assumptions; practical security depends on non-collusion of auction servers in MPC-based designs.

**Community acceptance:** Niche
Well-studied in algorithmic game theory and cryptography; deployed in specialized procurement contexts; no general standard for cryptographic auctions.

---

## Blockchain-Based Voting: Deployments and Controversies

**Goal:** Use a public blockchain as an immutable, publicly auditable ballot ledger — combining the transparency and tamper-resistance of distributed consensus with cryptographic vote privacy. In practice, deployed systems have exposed fundamental tensions between auditability, coercion-resistance, and software security.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Agora** | 2018 | Permissioned blockchain + secret sharing | Deployed as parallel count in Sierra Leone presidential election; claimed tamper-proof audit trail; election commission did not officially recognize the parallel tally [[1]](https://cryptopapers.info/assets/pdf/agora.pdf) |
| **Voatz** | 2018 | Permissioned blockchain + biometrics + mixnet | First blockchain voting app used in U.S. federal elections (West Virginia 2018 midterms, overseas military voters); reverse-engineered by MIT researchers in 2020 [[1]](https://www.usenix.org/conference/usenixsecurity20/presentation/specter) |
| **MIT/Specter-Koppel-Weitzner Analysis of Voatz** | 2020 | Reverse engineering + threat model | Found passive network adversaries could recover secret ballots via side-channel; server could alter or drop votes; 79 findings (one-third high-severity); West Virginia dropped Voatz for 2020 primaries [[1]](https://www.usenix.org/system/files/sec20-specter.pdf) |
| **Trail of Bits Voatz Audit** | 2020 | Code audit | Confirmed MIT findings; identified improper use of cryptographic algorithms and ad hoc cryptographic protocols; high-severity cryptographic flaws [[1]](https://blog.trailofbits.com/2020/03/13/our-full-report-on-the-voatz-mobile-voting-platform/) |

The Voatz case is the most thoroughly analyzed failure in blockchain voting. Despite claiming security via blockchain immutability, biometric authentication, and a mixnet, the system's actual cryptographic implementation was ad hoc: a passive network observer could recover a voter's ballot via traffic analysis before the ballot reached any blockchain. The blockchain layer provided auditability of what the server recorded — not of what the voter intended. This illustrates a general problem: a blockchain guarantees that recorded votes are not altered after the fact, but provides no protection against a malicious app that records the wrong vote in the first place.

Agora's Sierra Leone deployment was later clarified to be an independent parallel tally, not integrated into the official count — raising questions about what "blockchain-secured election" claims actually mean in practice.

**State of the art:** Academic consensus (USENIX Security 2020, multiple National Academies reports) holds that internet voting — blockchain-based or otherwise — cannot currently meet the security requirements of public elections. The correct application of cryptographic techniques in voting is the approach of systems like [Helios](#end-to-end-verifiable-e-voting), [Belenios](#end-to-end-verifiable-e-voting), [STAR-Vote](#star-vote), and [Prêt à Voter](#prêt-à-voter), which use ZK proofs and verifiable mixnets rather than blockchain immutability as their security foundation.

**Production readiness:** Deprecated
Voatz dropped by West Virginia after security audits; Agora was only a parallel tally; academic consensus advises against blockchain-based internet voting for public elections.

**Implementations:**
- [Voatz](https://voatz.com/) — proprietary, closed-source mobile voting app (not recommended)
- [Agora](https://www.agora.vote/) — proprietary, permissioned blockchain voting

**Security status:** Broken
MIT/Trail of Bits audits found high-severity cryptographic flaws in Voatz; passive network adversaries could recover ballots; blockchain immutability does not protect against malicious client apps.

**Community acceptance:** Controversial
Academic consensus (USENIX Security 2020, National Academies) opposes internet/blockchain voting for public elections; Voatz audits are widely cited as a cautionary example.

---

## Distance-Bounding Protocols

**Goal:** Prove physical proximity. A verifier challenges a prover with rapid-fire nonces and measures the round-trip time of each response — the speed of light bounds the maximum distance at which a prover could be located. Prevents relay attacks (mafia fraud) and terrorist fraud, where an attacker convinces a verifier that a remote credential is physically present.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brands-Chaum Distance Bounding** | 1993 | Challenge-response + timing | First formal distance-bounding protocol; n-bit rapid challenge phase; prover must answer each bit within one round-trip time [[1]](https://doi.org/10.1007/3-540-48285-7_30) |
| **Hancke-Kuhn DB Protocol** | 2005 | PRNG + XOR | First practical DB protocol for RFID/NFC; prover pre-commits two pseudorandom strings; answers each challenge bit by selecting one string bit [[1]](https://doi.org/10.1109/PERCOM.2005.52) |
| **Bussard-Bagga DBPK** | 2004 | Public-key + timing | Distance bounding with public-key authentication; prevents both mafia and terrorist fraud [[1]](https://link.springer.com/chapter/10.1007/11836810_5) |
| **Kim-Avoine (KA) Protocol** | 2009 | Randomized response + commitment | Adds noise tolerance; prover may send wrong bits with controlled probability; first to formally treat noisy channels [[1]](https://eprint.iacr.org/2009/219) |
| **Swiss-Knife Protocol** | 2010 | Pre-commitment + masking | Provably secure against mafia and terrorist fraud simultaneously; efficient for resource-constrained devices [[1]](https://link.springer.com/chapter/10.1007/978-3-642-14081-5_11) |
| **ISO/IEC 23741:2023 DB standard** | 2023 | Standardized framework | First international standard for distance-bounding protocols; formalizes security definitions and protocol structure [[1]](https://www.iso.org/standard/77193.html) |

The two core threat models are: (1) **mafia fraud** — an active relay attack where an adversary in the middle relays messages between a distant prover and verifier without either party's awareness (defeated by timing); (2) **terrorist fraud** — where a colluding prover helps an attacker pass distance checks from a distance (requires the prover cannot give the attacker a reusable token). Applications include contactless payment terminals (Visa/Mastercard relay-attack resistance), building access control, and secure ranging in Ultra-Wideband (UWB) as deployed in iPhone U1/Apple CarKey.

**State of the art:** UWB-based distance bounding (Apple CarKey, IEEE 802.15.4z) for automotive and access control; ISO/IEC 23741 for standardization. See [FIDO2/WebAuthn](12-secure-communication-protocols.md#token-based-authentication-totp-fido2-webauthn) for proximity authentication and [TEE Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation) for hardware-backed presence claims.

**Production readiness:** Production
UWB distance bounding deployed in Apple CarKey, Samsung SmartThings, and automotive keyless entry; IEEE 802.15.4z standardized; Visa/Mastercard relay-attack countermeasures in EMV contactless.

**Implementations:**
- [Apple U1 / CarKey](https://developer.apple.com/carkey/) — proprietary, UWB-based distance bounding in iOS
- [Android UWB](https://source.android.com/docs/core/connect/uwb) — Android UWB stack with IEEE 802.15.4z support
- [NXP Trimension](https://www.nxp.com/products/wireless-connectivity/uwb) — hardware + firmware, UWB secure ranging chips

**Security status:** Secure
Speed-of-light timing bounds are physically unforgeable; ISO/IEC 23741 formalizes security against mafia and terrorist fraud; UWB implementations well-tested.

**Community acceptance:** Standard
ISO/IEC 23741:2023 published; IEEE 802.15.4z standardized; deployed by Apple, Samsung, BMW, and major payment networks.

---

## Tor Hidden Services (.onion v3 Cryptography)

**Goal:** Host a server whose IP address is permanently concealed from clients, the network, and even Tor relays — while clients can still authenticate that they are reaching the intended service. A .onion address is not a name assigned by any authority: it is a cryptographic commitment to the service's long-term public key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hidden Services v1/v2** | 2004 | RSA-1024 + DH | Original design; .onion address = first 10 bytes of SHA-1(RSA pubkey); 16-char Base32 hostname; deprecated 2021 due to RSA-1024 weakness and enumeration attacks [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Hidden Services v3 (Prop 224)** | 2017 | Ed25519 + X25519 + SHA3 | Full 256-bit security; 56-char .onion address = Base32(Ed25519 pubkey ∥ checksum ∥ version); introduction and rendezvous circuit negotiated over X25519 DH; descriptor encrypted with client authorization keys [[1]](https://spec.torproject.org/rend-spec-v3) |
| **Client Authorization (v3)** | 2020 | X25519 per-client keys | Service encrypts its descriptor (location on HSDir) with per-client X25519 keys; only authorized clients can even discover the introduction points [[1]](https://community.torproject.org/onion-services/advanced/client-auth/) |
| **Onion Balance (load balancing)** | 2021 | Blinded key derivation | Single .onion address backed by multiple instances; each backend derives a blinded signing key from the master key; clients cannot distinguish instances [[1]](https://onionbalance.readthedocs.io/en/latest/design.html) |

A v3 .onion address encodes the Ed25519 public key directly — there is no certificate authority, no DNS, and no registrar. The 56-character hostname is the public key. To reach a service, a client asks an HSDir (hash ring of Tor relays) for the encrypted descriptor; the descriptor reveals the service's introduction points; the client builds a circuit to a rendezvous point and passes it to the service via an introduction point; the service completes the circuit, and an end-to-end authenticated Tor circuit is established. The entire scheme relies on Ed25519 signatures, X25519 key agreement, SHA3-256 hashing, and the Tor onion routing layer — no centralized component ever learns both the client and server identity simultaneously.

**State of the art:** v3 hidden services (mandatory since 2021); SecureDrop, Facebook's facebookwkhpilnemxj.onion, and numerous whistleblowing platforms use v3 .onion addresses. See [Onion Routing / Tor](11-anonymity-credentials.md#onion-routing) for the underlying anonymity layer.

**Production readiness:** Production
v3 onion services mandatory since October 2021; thousands of production services including SecureDrop, Facebook, DuckDuckGo, ProtonMail, and the New York Times.

**Implementations:**
- [Tor](https://github.com/torproject/tor) ⭐ 4.9k — C, reference implementation of Tor including v3 onion services
- [Arti](https://gitlab.torproject.org/tpo/core/arti) — Rust, next-generation Tor implementation with onion service support
- [OnionBalance](https://github.com/DonnchaC/onionbalance) ⭐ 275 [archived] — Python, load balancing for onion services

**Security status:** Secure
Ed25519 + X25519 + SHA3 provide 256-bit security; v3 addresses are not enumerable (unlike v2); client authorization adds per-client encryption. Traffic analysis remains an open research problem.

**Community acceptance:** Widely trusted
Tor onion services are the de facto standard for anonymous hosting; used by major news organizations, whistleblowing platforms, and privacy-focused services worldwide.

---

## Signal Sealed Sender & PIR-Based Metadata Privacy

**Goal:** Prevent the messaging server from learning who is sending a message to whom — metadata privacy beyond end-to-end encryption. Even if the server is honest-but-curious or subpoenaed, it cannot determine the sender of a received message without the recipient's cooperation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Signal Sealed Sender** | 2018 | HKDF + AES-GCM + sender certificate | Sender encrypts their own identity (certificate) inside the ciphertext; server sees only recipient and ciphertext size; recipient decrypts sender cert as part of message decryption [[1]](https://signal.org/blog/sealed-sender/) |
| **Sealed Sender v2 (SealedSenderMultiRecipientMessage)** | 2022 | Sender key + sealed cert | Extension for group sends; single server round-trip delivers to all recipients without revealing sender to server even for group messages [[1]](https://github.com/signalapp/libsignal/blob/main/rust/protocol/src/sealed_sender.rs) |
| **Herd (PIR-based metadata hiding)** | 2016 | Express / computational PIR | Full PIR for message retrieval; server cannot determine which message a client is fetching; O(√n) bandwidth [[1]](https://doi.org/10.1145/2976749.2978351) |
| **Express (XPIR / batch codes)** | 2021 | Batch codes + lightweight crypto | Practical PIR for private message retrieval; deployed in research prototype; 1–2× bandwidth of unprotected fetch [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/eskandarian) |
| **Oblivious Message Retrieval (OMR)** | 2022 | FHE + pertinence detection | Server obliviously scans all messages and returns only those for the recipient; server learns neither sender nor which messages matched [[1]](https://eprint.iacr.org/2021/1256) |

Sealed Sender addresses the "to" metadata but not the "from" metadata: Signal's server always knows which device to deliver to (the recipient), but with Sealed Sender it does not know who sent it. The scheme uses a sender certificate (signed by Signal's server, proving the sender is a registered user without revealing their ID to the server at send time) that is encrypted inside the Double Ratchet ciphertext. The limitation is that the recipient's server still learns message timing and size. Full metadata hiding requires PIR-based approaches like Herd or OMR, which remain expensive but are the active research frontier.

**State of the art:** Signal Sealed Sender v2 (production, ~2022); OMR (research, 2022–present). Related to [PIR](10-privacy-preserving-computation.md#private-information-retrieval-pir), [Double Ratchet](12-secure-communication-protocols.md#double-ratchet-symmetric-ratchet), and [Oblivious Message Retrieval](10-privacy-preserving-computation.md#oblivious-message-retrieval-omr).

**Production readiness:** Production
Signal Sealed Sender deployed to all Signal users (~2018); Sealed Sender v2 for groups (~2022); PIR-based metadata hiding (Herd, OMR) remains research-stage.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, Signal's production sealed sender implementation
- [Signal-Android](https://github.com/signalapp/Signal-Android) ⭐ 28k — Java/Kotlin, Android client with sealed sender support
- [SealPIR](https://github.com/microsoft/SealPIR) ⭐ 156 — C++, Microsoft Research PIR library (research prototype for metadata hiding)

**Security status:** Caution
Sealed Sender hides sender identity from the server but does not hide message timing, size, or recipient; full metadata privacy requires PIR (expensive) or OMR (research-stage).

**Community acceptance:** Widely trusted
Signal Sealed Sender is the state of the art for production metadata privacy; endorsed by cryptographers; PIR-based approaches are active IETF/academic research.

---

## Memory-Hard Proof of Work (Argon2, scrypt, Equihash)

**Goal:** Make brute-force attacks proportionally expensive in memory, not just computation — so that an attacker with a GPU farm or ASIC enjoys little advantage over a legitimate user on a commodity machine. The primary applications are password hashing (PoW against crackers) and ASIC-resistant cryptocurrency mining.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **scrypt (Colin Percival)** | 2009 | Sequential memory-hard function | Fill a large buffer with pseudorandom data then read it in a pseudorandom order; memory and time are coupled parameters (N, r, p); used in Litecoin PoW and passphrase KDFs [[1]](https://www.tarsnap.com/scrypt/scrypt.pdf) |
| **Argon2 (PHC winner)** | 2015 | Data-independent (Argon2i) / data-dependent (Argon2d) / hybrid (Argon2id) | Password Hashing Competition winner; three modes trade off side-channel resistance vs. GPU resistance; Argon2id recommended for password hashing; configurable memory, time, and parallelism [[1]](https://www.rfc-editor.org/rfc/rfc9106) |
| **Equihash** | 2016 | Generalized birthday problem in large memory | Memory-hard PoW via k-XOR on n-bit strings over a large random table; used in Zcash mining; provably requires Ω(2^{n/(k+1)}) memory [[1]](https://eprint.iacr.org/2015/946) |
| **Balloon Hashing** | 2016 | Space-hard with simple analysis | Three-pass memory-hard construction with a simple security proof; provably space-hard in the random-oracle model [[1]](https://eprint.iacr.org/2016/027) |
| **Egalitarian Mining / MTP** | 2017 | Merkle Tree Proof of Work | Memory-hard PoW with short proofs; verifier checks a small Merkle path rather than re-running the full computation; reduces blockchain storage [[1]](https://eprint.iacr.org/2017/203) |
| **yescrypt** | 2014 | Extended scrypt + password scrambling | Extends scrypt with additional hardening; adopted by Fedora, Debian, and Ubuntu as default password hash (replacing bcrypt/SHA-512) [[1]](https://www.openwall.com/yescrypt/) |

The key distinction between memory-hard functions and conventional hash-based PoW (SHA-256) is **memory hardness**: the computation requires accessing a large, essentially random memory region, which cannot be easily parallelized without proportional memory per parallel unit. This collapses the advantage of custom hardware. Argon2id (RFC 9106) is the current IETF recommendation for password hashing; scrypt is used in PKCS#8 encrypted private keys and in Litecoin; Equihash is the cryptographic core of Zcash's proof-of-work consensus.

**State of the art:** Argon2id (RFC 9106, recommended by OWASP); yescrypt (Linux default); Equihash (Zcash). Extends [Client Puzzles / Proof of Effort](#client-puzzles-proof-of-effort) and [PoW/PoSpace](13-blockchain-distributed-ledger.md#proof-of-work-pow-proof-of-space).

**Production readiness:** Production
Argon2id is RFC 9106 and OWASP-recommended; yescrypt is the default password hash in Fedora, Debian, and Ubuntu; scrypt used in Litecoin and PKCS#8; Equihash powers Zcash.

**Implementations:**
- [libsodium (Argon2)](https://github.com/jedisct1/libsodium) ⭐ 13k — C, includes Argon2id; widely deployed
- [argon2](https://github.com/P-H-C/phc-winner-argon2) ⭐ 5.2k — C, reference implementation from the PHC winners
- [scrypt](https://github.com/Tarsnap/scrypt) ⭐ 509 — C, Colin Percival's reference implementation
- [yescrypt](https://github.com/openwall/yescrypt) ⭐ 189 — C, Openwall's extended scrypt for Linux
- [equihash](https://github.com/tromp/equihash) ⭐ 157 — C++, reference implementation by John Tromp

**Security status:** Secure
Argon2id (RFC 9106) provably memory-hard; scrypt well-analyzed; Equihash proven to require large memory. All withstand current GPU/ASIC attacks at recommended parameters.

**Community acceptance:** Standard
Argon2id is IETF RFC 9106 and OWASP-recommended; yescrypt adopted by major Linux distributions; Equihash standardized within Zcash; Password Hashing Competition (2013-2015) provided community validation.

---

## Supply Chain Cryptography: in-toto, SLSA, and TUF

**Goal:** Cryptographically bind every step of a software build pipeline — from source commit to final artifact — so that a consumer can verify not just that an artifact was signed, but that it was produced by the expected sequence of trusted steps, using the expected tools, from the expected source.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **The Update Framework (TUF)** | 2010 | Threshold signatures + Merkle-style delegation + role separation | Compromising any single key (including the package maintainer) does not allow arbitrary malicious updates; four-role trust hierarchy (Root, Timestamp, Snapshot, Targets); adopted by PyPI, Rust crates, Docker Content Trust [[1]](https://theupdateframework.io/papers/protecting-community-repositories-jssop2016.pdf) |
| **in-toto** | 2019 | Link metadata + supply chain layout | Maintainer defines a signed layout of all pipeline steps; each step produces a signed link attestation; final product is verified against the layout; first formal supply chain integrity framework [[1]](https://in-toto.io/in-toto-dissertation.pdf) |
| **SLSA (Supply-chain Levels for Software Artifacts)** | 2021 | Build provenance attestations + hermetic builds | Google-originated four-level framework; SLSA 3 requires hermetic, reproducible builds with signed provenance; SLSA 4 adds two-person review and build isolation [[1]](https://slsa.dev/spec/v1.0/) |
| **Sigstore (Rekor + Fulcio + cosign)** | 2021 | Ephemeral OIDC-bound keys + transparency log | Fulcio issues a short-lived certificate binding a signing key to an OIDC identity (GitHub Actions, Google, etc.); Rekor is an append-only Merkle log of all signatures; cosign signs and verifies container images and blobs [[1]](https://www.usenix.org/system/files/usenixsecurity22-newman.pdf) |
| **npm Provenance (2023)** | 2023 | SLSA + Sigstore + GitHub Actions OIDC | npm packages can carry signed SLSA provenance linking the published package to its exact source commit and CI workflow; verified by `npm audit signatures` [[1]](https://github.blog/security/supply-chain-security/introducing-npm-package-provenance/) |
| **DSSE / in-toto Attestation Framework** | 2022 | Dead Simple Signing Envelope | Standard envelope format for supply chain attestations; replaces ad-hoc JSON; used by SLSA, in-toto, and cosign [[1]](https://github.com/secure-systems-lab/dsse) |

The central insight unifying these systems is that **a signature on a final artifact is insufficient** — a malicious build system could produce a correctly-signed artifact from tampered source or with a backdoored compiler (a Thompson-attack variant). in-toto closes this gap by requiring signed attestations at each pipeline step and a maintainer-signed layout that defines what steps are required and in what order. SLSA operationalizes this into audit levels that organizations can target incrementally. Sigstore solves the key distribution problem (how does a consumer verify a developer's signing key?) by anchoring signing keys to OIDC identities and recording every signing event in a public transparency log.

**State of the art:** Sigstore/cosign (default for Kubernetes/CNCF ecosystem); npm provenance (default for new npm publishes); TUF (PyPI, Rust crates). See [Sigstore / Certificate Transparency](14-applied-infrastructure-pki.md#sigstore-keyless-code-signing) and [C2PA/SLSA](14-applied-infrastructure-pki.md#cryptographic-provenance-attestation-c2pa-slsa) for related entries in category 14.

**Production readiness:** Production
TUF deployed in PyPI, Docker Content Trust, and Rust crates; Sigstore is default for Kubernetes/CNCF; SLSA adopted by Google, npm, GitHub Actions; in-toto integrated into major CI/CD pipelines.

**Implementations:**
- [python-tuf](https://github.com/theupdateframework/python-tuf) ⭐ 1.7k — Python, reference TUF implementation
- [go-tuf](https://github.com/theupdateframework/go-tuf) ⭐ 698 — Go, TUF client/server library
- [in-toto](https://github.com/in-toto/in-toto) ⭐ 987 — Python, supply chain integrity framework
- [cosign](https://github.com/sigstore/cosign) ⭐ 5.8k — Go, container image signing/verification via Sigstore
- [Rekor](https://github.com/sigstore/rekor) ⭐ 1.1k — Go, Sigstore transparency log
- [Fulcio](https://github.com/sigstore/fulcio) ⭐ 816 — Go, Sigstore ephemeral certificate authority

**Security status:** Secure
TUF's role-separated threshold key model survives compromise of any single key; Sigstore's transparency log provides public auditability; SLSA levels provide incremental supply chain guarantees.

**Community acceptance:** Standard
TUF is a CNCF graduated project; Sigstore is a CNCF project; SLSA is backed by Google and the OpenSSF; npm provenance is on by default; broad industry adoption.

---

## Blind Signature-Based E-Cash (Chaum DigiCash)

**Goal:** Achieve electronic cash with bank-grade anonymity. A bank signs a denomination token blindly — it cannot link the coin it issued to the coin presented for redemption — while still being able to detect double-spending via a serial number database. The combination gives information-theoretic unlinkability between withdrawal and payment.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum Blind Signature E-Cash** | 1982 | RSA blind signatures | First e-cash; bank signs blinded serial number; unblinding gives a valid coin the bank cannot link to the withdrawal session [[1]](https://doi.org/10.1007/978-1-4757-0602-4_18) |
| **DigiCash / eCash** | 1994 | Chaum blind sigs + double-spend DB | Commercial deployment; payer withdraws coins, spends with merchant, merchant deposits; bank checks serial number for double-spend; folded 1998 [[1]](https://groups.csail.mit.edu/mac/classes/6.805/articles/money/nsamint/nsamint.htm) |
| **Compact E-Cash (Camenisch-Lysyanskaya)** | 2005 | CL signatures + ZK | Withdraw 2ᵏ coins in O(k) communication; serial numbers derived from a pseudorandom function over a secret; first efficient offline e-cash [[1]](https://eprint.iacr.org/2005/060) |
| **Brands Offline E-Cash** | 1994 | DLP-based restrictive blind sigs | Double-spending reveals the payer's identity via algebraic trap; no online double-spend check needed [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_5) |
| **Anonymous Credential E-Cash (Fuchsbauer et al.)** | 2009 | Structure-preserving sigs + GS proofs | Efficient offline e-cash with transferability and anonymity revocation [[1]](https://eprint.iacr.org/2009/620) |

The blind signature trick: the user picks a random serial number s, blinds it as b = s · rᵉ mod n (for RSA with exponent e), sends b to the bank, bank signs bᵈ mod n = (s · rᵉ)ᵈ = sᵈ · r mod n, user divides by r to get sᵈ mod n — a valid RSA signature on s the bank has never seen. The practical failure of DigiCash (bankruptcy 1998) was commercial, not cryptographic: merchants were reluctant to adopt, banks delayed integration, and the internet payment landscape moved to credit cards. The double-spend database creates a central bottleneck and a privacy risk if the bank retains serial numbers. Brands' scheme eliminates the online check but requires trust that the identity-revealing mechanism deters cheating.

**State of the art:** Blind-signature e-cash is the cryptographic foundation of [Privacy Pass](11-anonymity-credentials.md#privacy-pass-anonymous-tokens) (anonymous rate-limiting tokens) and underlies [GNU Taler](#gnu-taler-practical-e-cash-with-income-transparency). See also [Anonymous Credentials](11-anonymity-credentials.md#anonymous-credentials) and [E-Cash](11-anonymity-credentials.md#e-cash-chaumian-digital-cash).

**Production readiness:** Mature
DigiCash was commercially deployed (1994-1998) but folded; blind signature primitives underlie Privacy Pass (production) and GNU Taler (pilot); Compact E-Cash and Brands schemes are research prototypes.

**Implementations:**
- [GNU Taler](https://git.taler.net/) — C, production-grade e-cash system based on Chaum blind signatures

**Security status:** Secure
RSA blind signatures are provably secure under the RSA assumption; Brands' double-spend detection is algebraically sound; the DigiCash failure was commercial, not cryptographic.

**Community acceptance:** Widely trusted
Chaum's blind signature e-cash is a foundational contribution (1982); Privacy Pass is an IETF standard (RFC 9576/9577); blind signatures are the basis of modern anonymous token systems.

---

## GNU Taler: Practical E-Cash with Income Transparency

**Goal:** Electronic payments that are anonymous for payers but transparent for merchants — so tax evasion is impossible while payer privacy is preserved. Designed as a practically deployable e-cash system with regulatory compliance built in rather than bolted on.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GNU Taler Protocol** | 2016 | Chaum blind sigs + RSA / EdDSA | Mint (exchange) issues blind-signed coins; payer spends anonymously; merchant deposit is publicly logged; merchant income is auditable [[1]](https://taler.net/papers/taler2017.pdf) |
| **Taler Refresh Protocol** | 2016 | Cut-and-choose + blind sigs | Allows change: partially spent coins are refreshed into new coins without the exchange linking old to new; protects payer privacy even for partial payments [[1]](https://taler.net/papers/taler-fc17.pdf) |
| **Taler Auditor** | 2019 | Merkle log + signatures | Third-party auditor verifies exchange's coin issuance and redemption logs without learning individual transactions; detects coin forging or double-spend concealment [[1]](https://docs.taler.net/design-documents/auditor.html) |
| **Taler KYC Integration** | 2022 | Threshold reveal | Optional KYC: payer identity can be cryptographically revealed to a regulator under a threshold of authorities, without revealing to the exchange in normal operation [[1]](https://taler.net/papers/) |

The key design asymmetry: payer anonymity is information-theoretic (the exchange signed a blinded coin and cannot link it to redemption), but merchant income transparency is mandatory (the merchant must deposit with their real identity to receive payment). The Refresh protocol solves the "change" problem: in Chaum's original scheme, returning change to the payer would allow the exchange to link the original and refreshed coins. GNU Taler's refresh uses a cut-and-choose protocol where the exchange signs k candidate refresh requests and the payer reveals k−1, forcing honest behavior. The system was piloted by the Swiss canton of Zurich in 2022 as a government digital currency experiment.

**State of the art:** GNU Taler v0.9+ (production-capable); Swiss cantonal pilot (2022). Compare [Chaum DigiCash](#blind-signature-based-e-cash-chaum-digicash) (full payer and payee anonymity) and [Monero / Confidential Transactions](13-blockchain-distributed-ledger.md#confidential-transactions-ct) (blockchain-based full anonymity with no income transparency).

**Production readiness:** Experimental
Swiss canton of Zurich pilot (2022); production-capable software (v0.9+) but no large-scale commercial deployment yet; EU digital euro discussions reference Taler's design.

**Implementations:**
- [GNU Taler Exchange](https://git.taler.net/exchange.git) — C, the core mint/exchange server
- [GNU Taler Wallet](https://git.taler.net/wallet-core.git) — TypeScript, cross-platform wallet (web, Android, iOS)
- [GNU Taler Merchant Backend](https://git.taler.net/merchant.git) — C, merchant payment processing

**Security status:** Secure
Payer anonymity is information-theoretic (blind signatures); refresh protocol proven secure via cut-and-choose; auditor detects coin forging without learning transaction details.

**Community acceptance:** Emerging
GNU project; Swiss government pilot; referenced in EU CBDC discussions; growing academic and policy interest; not yet an IETF or ISO standard.

---

## Cryptographic Audit Logs and Append-Only Integrity

**Goal:** Produce a tamper-evident, append-only log such that any deletion, reordering, or modification of log entries is detectable — even by a compromised log server — while allowing efficient verification of individual entries and the log's completeness. Deployed in security audit trails, certificate transparency, and distributed databases.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Haber-Stornetta Hash Chain** | 1991 | SHA hash chain | Each log entry includes the hash of the previous entry; any modification breaks the chain; the direct precursor to all later schemes [[1]](https://doi.org/10.1007/BF00196791) |
| **Crosby-Wallach Efficient Data Structures for Tamper-Evident Logging** | 2009 | Skip list + hash tree | O(log n) proof that entry i is in a log of size n; O(log n) proof of log consistency between two sizes; first practical audit-log data structure [[1]](https://www.usenix.org/legacy/event/sec09/tech/full_papers/crosby.pdf) |
| **Certificate Transparency (RFC 6962 / RFC 9162)** | 2013 | Merkle hash tree + STH | Append-only Merkle tree of TLS certificates; any CA-issued cert must appear before browsers accept it; signed tree heads (STHs) committed to by multiple witnesses [[1]](https://www.rfc-editor.org/rfc/rfc9162) |
| **CONIKS** | 2015 | Merkle prefix tree (Patricia trie) + signed tree roots | Append-only key directory for end-to-end messaging; per-user history trees; consistency proofs between consecutive epochs [[1]](https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-melara.pdf) |
| **Verifiable Data Structures (Google Trillian)** | 2015 | Merkle log + Merkle map | Open-source infrastructure backing Certificate Transparency logs; supports both append-only logs and verifiable maps [[1]](https://github.com/google/trillian) |
| **Transparent Logs (Russ Cox / Go Checksum DB)** | 2019 | Tile-based Merkle log | Go module checksum database; efficient client verification using fixed-size tiles; 128-byte tree nodes for cache-friendly proofs [[1]](https://research.swtch.com/tlog) |

The core primitive is a **Merkle hash tree** over ordered log entries, with a **signed tree head (STH)** committing to the tree's root hash and size at each epoch. Consistency proofs between two sizes (n₁ < n₂) demonstrate that the new log is a strict extension of the old one — no entries were removed or reordered. Inclusion proofs (O(log n) hashes) demonstrate that a specific entry is in the log. The key security property — that a server cannot present different log views to different observers — is enforced by **gossip protocols** or **witnesses** that compare STHs. Crosby-Wallach's skip-list design enables efficient queries by time range; Merkle-tree designs (CT, Trillian) prioritize verifiable inclusion proofs.

**State of the art:** Certificate Transparency (mandatory for Chrome/Safari TLS since 2018); Go checksum database (default for `go get`); Sigstore Rekor (software signing). Related to [Linked Timestamping](#linked-timestamping), [OpenTimestamps](#opentimestamps), [Key Transparency](03-key-exchange-key-management.md#key-transparency-coniks).

**Production readiness:** Production
Certificate Transparency mandatory for Chrome/Safari since 2018; Go checksum database default since Go 1.13; Sigstore Rekor in production for CNCF ecosystem.

**Implementations:**
- [Google Trillian](https://github.com/google/trillian) ⭐ 3.7k — Go, general-purpose verifiable data structures backing CT logs
- [ctfe](https://github.com/google/certificate-transparency-go) ⭐ 1.1k — Go, Certificate Transparency frontend and monitor
- [Rekor](https://github.com/sigstore/rekor) ⭐ 1.1k — Go, Sigstore transparency log
- [Go sumdb](https://github.com/golang/mod) ⭐ 207 — Go, Go module checksum database client

**Security status:** Secure
Merkle-tree consistency and inclusion proofs are well-understood; security reduces to hash collision resistance; gossip/witness protocols prevent split-view attacks.

**Community acceptance:** Standard
RFC 6962/9162 (CT) is an IETF standard; mandatory in Chrome and Safari; Go checksum database is default; Trillian is open-source infrastructure used by multiple CT log operators.

---

## Privacy-Preserving Analytics (PAAPI, ITP, VDAF/Prio)

**Goal:** Enable measurement of advertising effectiveness, user behavior, and aggregate statistics without revealing any individual's browsing history, conversion events, or behavioral profile to advertisers, publishers, or browsers — replacing cookie-based tracking with cryptographically private alternatives.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Apple Intelligent Tracking Prevention (ITP)** | 2017 | Partitioned cookies + first-party classification | ML classifier partitions cross-site cookies; storage access API for explicit consent; no cryptography but sets the policy baseline [[1]](https://webkit.org/blog/7675/intelligent-tracking-prevention/) |
| **Google Privacy Sandbox / PAAPI** | 2023 | Local interest groups + on-device auction | Protected Audience API (formerly FLEDGE); interest groups stored on-device; auction runs in a Trusted Execution Environment; advertiser learns only the winning bid, not the user's other interest groups [[1]](https://developer.chrome.com/docs/privacy-sandbox/protected-audience/) |
| **Private Click Measurement (PCM)** | 2019 | Blind HTTP redirect + delayed, noisy reporting | Apple's approach for click-through attribution; 6-bit campaign ID + 4-bit conversion value; 24–48 h delay + noise defeats timing correlation; no cross-site identity [[1]](https://webkit.org/blog/11529/introducing-private-click-measurement-pcm/) |
| **Attribution Reporting API** | 2021 | Differential privacy + aggregation service | Google's click attribution API; event-level reports with ε-DP noise; summary reports computed inside a TEE by an aggregation service; no individual-level data leaves the browser [[1]](https://developer.chrome.com/docs/privacy-sandbox/attribution-reporting/) |
| **Prio (VDAF)** | 2017 | Additive secret sharing + ZK validity proofs | Each client secret-shares its metric value across two non-colluding servers; servers compute aggregate without learning individual values; ZK proof prevents malformed inputs [[1]](https://www.usenix.org/system/files/conference/nsdi17/nsdi17-corrigan-gibbs.pdf) |
| **Poplar (VDAF for heavy hitters)** | 2021 | Incremental DPF + aggregation | Privately find the most common URL prefixes / search terms across clients without any server learning individual values; IETF VDAF standard [[1]](https://eprint.iacr.org/2021/017) |

The ecosystem divides into two design philosophies. **On-device computation** (PAAPI, PCM) moves the sensitive logic — interest group matching, auction, attribution — into the browser or a TEE, so no server ever sees raw behavioral data. **Cryptographic aggregation** (Prio, Poplar) sends only secret-shared or differentially private contributions to servers, which compute only aggregate statistics. The IETF VDAF (Verifiable Distributed Aggregation Function) standard formalizes the Prio approach: clients produce a pair of secret shares, each with a ZK validity proof (using a VOLE-based or Fiat-Shamir argument), sent to two aggregation servers; servers check validity and sum shares; no individual value is ever reconstructed. Firefox Telemetry, ISRG (Let's Encrypt's parent), and the DAP (Distributed Aggregation Protocol) working group deploy Prio3 for privacy-preserving telemetry.

**State of the art:** Chrome PAAPI (GA 2023); Apple PCM (Safari production); DAP/Prio3 (IETF draft, Firefox/ISRG deployment). Related to [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy), [VDAF/Prio](10-privacy-preserving-computation.md#prio-vdaf-privacy-preserving-aggregation), and [TEE Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation).

**Production readiness:** Production
Chrome PAAPI generally available (2023); Apple PCM/ITP in Safari production; Prio3/DAP deployed by Firefox Telemetry and ISRG (Let's Encrypt).

**Implementations:**
- [Divvi Up](https://github.com/divviup) — Rust, ISRG's privacy-preserving telemetry service built on Prio3/DAP
- [libprio-rs](https://github.com/divviup/libprio-rs) ⭐ 117 — Rust, Prio3 VDAF implementation used in production by ISRG

**Security status:** Caution
Cryptographic aggregation (Prio) is provably secure under non-collusion of aggregation servers; on-device approaches (PAAPI) depend on TEE integrity; differential privacy guarantees depend on correct noise calibration.

**Community acceptance:** Emerging
IETF DAP and VDAF drafts in active standardization; Chrome Privacy Sandbox mandated by Google's third-party cookie deprecation; Apple ITP/PCM is Safari default; strong industry momentum but ongoing policy debates.

---

## Mental Poker Protocols

**Goal:** Play a fair card game over a network with no trusted dealer. All players can verify that the deck was randomly shuffled, each card is dealt to exactly one player, no player can see another's hand, and the game's outcome is publicly verifiable — using only cryptographic operations with no trusted third party.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shamir-Rivest-Adleman Mental Poker** | 1981 | Commutative encryption (SRA) | First mental poker protocol; commutative encryption allows players to jointly shuffle; O(n²) operations per card deal [[1]](https://doi.org/10.1007/PL00003816) |
| **Crépeau Verifiable Shuffle** | 1986 | Cut-and-choose + commitment | First protocol with verifiable shuffle; each player proves shuffle correctness without revealing permutation [[1]](https://doi.org/10.1007/3-540-39799-X_10) |
| **Barnett-Smart Mental Poker** | 2003 | ElGamal + ZK shuffle proofs | Efficient mental poker using re-encryption mixnets; O(n log n) shuffle proof; first practical protocol for >2 players [[1]](https://eprint.iacr.org/2003/043) |
| **Castagnos et al. (class group-based)** | 2020 | Class group encryption + ZK | Uses linearly homomorphic encryption from class groups; avoids the pairing-based overhead; efficient for real-time play [[1]](https://eprint.iacr.org/2020/376) |
| **Kaleidoscope (ZK-based card games)** | 2018 | SNARKs + commit-reveal | Generalizes mental poker to arbitrary card games; each player proves move legality via SNARK without revealing hand [[1]](https://eprint.iacr.org/2017/899) |

The fundamental challenge is implementing a "shared deck" where no single party controls the card ordering, yet each card can be privately revealed to exactly one player. Commutative encryption (where Enc_A(Enc_B(m)) = Enc_B(Enc_A(m))) enables this: all players jointly encrypt the deck, shuffle it, and then selectively decrypt individual cards. Modern approaches replace commutative ciphers with re-encryption shuffles and ZK shuffle proofs, which are more efficient and have well-understood security.

**State of the art:** Barnett-Smart (practical implementations for online poker); Kaleidoscope (general card games via SNARKs). See [MPC](06-multi-party-computation.md#multi-party-computation-mpc) and [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Experimental
Barnett-Smart has working implementations for online poker; Kaleidoscope demonstrated for general card games; no major commercial deployment.

**Implementations:**
- [libTMCG](https://www.nongnu.org/libtmcg/) — C++, Toolbox for Mental Card Games implementing Barnett-Smart and other protocols
- [mental-poker](https://github.com/geometryxyz/mental-poker) ⭐ 117 — Rust/JavaScript, Barnett-Smart protocol implementation

**Security status:** Secure
Re-encryption shuffle + ZK proofs provide provable security under DDH; commutative encryption schemes (SRA) are secure but less efficient; Kaleidoscope inherits SNARK soundness.

**Community acceptance:** Niche
Active research area since 1981; libTMCG is the most mature implementation; blockchain gaming community shows renewed interest; no standardization.

---

## OPAQUE: Password-Authenticated Key Exchange

**Goal:** Establish a shared key from a password without the server ever learning or storing the password in any recoverable form — not even a salted hash. The server stores only a cryptographic envelope that it cannot open without the client's password, and the protocol is immune to pre-computation and offline dictionary attacks by the server.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OPAQUE (Jarecki-Krawczyk-Xu)** | 2018 | OPRF + AKE + envelope | Client registers an envelope of keys encrypted under a password-derived key; server stores envelope + OPRF key; login runs OPRF to recover keys then AKE; server never sees password [[1]](https://eprint.iacr.org/2018/163) |
| **IETF draft-irtf-cfrg-opaque** | 2023 | OPRF (ristretto255/P-256) + 3DH AKE | Standardization effort; OPRF via VOPRF; AKE via triple-DH (like Signal X3DH); envelope stores client private key encrypted under OPRF output [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-opaque/) |
| **Strong aPAKE (Bourdrez et al.)** | 2021 | OPAQUE + key stretching | Adds server-side key stretching (Argon2) inside the OPRF evaluation; resists server compromise + offline attack combination [[1]](https://eprint.iacr.org/2021/864) |

Unlike traditional password hashing (bcrypt, Argon2), where the server stores a hash and can mount offline dictionary attacks on its own database, OPAQUE uses an oblivious PRF so the server never processes the raw password. The client evaluates OPRF(password) with the server's OPRF key, receiving a high-entropy key that decrypts the stored envelope containing the client's AKE private key. Even a fully compromised server database is useless without performing an online attack against the OPRF. This makes OPAQUE the strongest known form of password-based authentication.

**State of the art:** IETF CFRG standardization in progress (draft-irtf-cfrg-opaque); implemented in Cloudflare, WhatsApp key backup, and Facebook credential storage. Related to [PAKE](03-key-exchange-key-management.md#password-authenticated-key-exchange-pake) and [OPRF](10-privacy-preserving-computation.md#oblivious-prf-oprf).

**Production readiness:** Production
Deployed in Cloudflare (password authentication), WhatsApp (key backup), and Facebook (credential storage); IETF CFRG standardization in progress.

**Implementations:**
- [opaque-ke](https://github.com/facebook/opaque-ke) ⭐ 386 — Rust, Facebook's OPAQUE implementation (used in production)
- [cloudflare/opaque](https://github.com/cloudflare/opaque-ts) ⭐ 106 — TypeScript/Go, Cloudflare's OPAQUE implementation

**Security status:** Secure
Provably secure aPAKE; server never processes raw password; even full server database compromise requires online attack against OPRF; strongest known form of password authentication.

**Community acceptance:** Emerging
IETF CFRG draft in active standardization; deployed by Cloudflare, Meta, and WhatsApp; endorsed by leading cryptographers (Krawczyk, Jarecki); expected to become an RFC.

---

## Verifiable Delay Functions (VDFs)

**Goal:** Compute a function that provably requires a specified number of sequential steps — even with massive parallelism — and produces an output that anyone can verify quickly. Enables trustless randomness generation, fair leader election, and time-release encryption without a trusted timekeeper.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wesolowski VDF** | 2019 | Repeated squaring in hidden-order group | Compute y = x^(2^T) mod N; verification via a single group exponentiation with a Fiat-Shamir-derived challenge; proof is a single group element [[1]](https://eprint.iacr.org/2018/623) |
| **Pietrzak VDF** | 2019 | Repeated squaring + recursive halving | Compute y = x^(2^T) mod N; proof is O(log T) group elements via recursive halving argument; weaker assumptions than Wesolowski [[1]](https://eprint.iacr.org/2018/627) |
| **Chia VDF (class group)** | 2019 | Class group of imaginary quadratic field | No trusted setup: class groups provide a hidden-order group without RSA modulus generation; deployed in Chia blockchain for timelord proofs [[1]](https://docs.chia.net/timelord-algorithm/) |
| **MinRoot VDF** | 2022 | Iterated permutation in prime field | VDF from iterated cube-root in F_p; SNARK-friendly (algebraic circuit); designed for Ethereum [[1]](https://eprint.iacr.org/2022/1626) |
| **Ethereum VDF Research** | 2023 | ASIC-accelerated Wesolowski | Ethereum Foundation funds ASIC design to ensure VDF evaluation speed is bounded; public VDF ASIC prevents private speedup advantage [[1]](https://vdfresearch.org/) |

The key property is **sequential hardness**: T sequential squarings cannot be parallelized below T steps (under the repeated-squaring assumption), yet verification takes O(log T) or O(1) exponentiations. Wesolowski's proof is a single group element but relies on the adaptive root assumption; Pietrzak's proof is larger (O(log T) elements) but relies only on the standard sequential squaring assumption. Both require a group of unknown order — either an RSA modulus (trusted setup) or a class group (no setup). The Ethereum research program addresses the "ASIC gap" problem: if one party has a 10x faster squaring chip, they can evaluate the VDF early and gain an unfair advantage.

**State of the art:** Chia Network (class-group VDF in production); Ethereum VDF research ongoing; Wesolowski/Pietrzak are the two standard constructions. Related to [Time-Lock Puzzles](09-commitments-verifiability.md#time-lock-puzzles-timed-release-encryption), [Randomness Beacons](09-commitments-verifiability.md#randomness-beacons-coin-tossing), and [Client Puzzles](#client-puzzles-proof-of-effort).

**Production readiness:** Production
Chia Network uses class-group VDFs in production for timelord proofs; Ethereum VDF research ongoing with ASIC design; Wesolowski/Pietrzak constructions well-implemented.

**Implementations:**
- [chiavdf](https://github.com/Chia-Network/chiavdf) ⭐ 65 — C++/Python, Chia's class-group VDF implementation (production)
- [drand](https://github.com/drand/drand) ⭐ 813 — Go, distributed randomness beacon (uses VDF concepts for timelock encryption)
- [vdf-competition](https://github.com/Chia-Network/vdf-competition) ⭐ 26 — C++, optimized repeated-squaring implementations from the VDF Alliance competition

**Security status:** Secure
Sequential squaring assumption is well-studied; Wesolowski requires adaptive root assumption; Pietrzak relies on standard sequential squaring; class groups avoid trusted setup. ASIC advantage is the main practical concern.

**Community acceptance:** Emerging
Active research community (VDF Alliance, Ethereum Foundation); Chia deployed in production; no IETF/NIST standard but growing blockchain ecosystem adoption.

---

## Proof of Storage (Filecoin PoRep / PoSt)

**Goal:** Prove that a storage provider is physically dedicating unique disk space to store a client's data — not just pretending by re-deriving it on demand, deduplicating it, or storing it only once across multiple claimed replicas. Enables decentralized storage markets where payment is tied to verifiable, ongoing storage.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Proof of Retrievability (PoR) — Juels-Kaliski** | 2007 | Sentinel insertion + MAC | Server stores file + random sentinels; verifier checks sentinel positions; first formal PoR [[1]](https://doi.org/10.1145/1315245.1315317) |
| **Compact PoR (Shacham-Waters)** | 2008 | BLS signatures + homomorphic tags | Verifier checks random linear combination of file blocks; O(1) proof size regardless of file size [[1]](https://eprint.iacr.org/2008/073) |
| **Proof of Replication (PoRep) — Filecoin** | 2017 | Depth-robust graph labeling + Poseidon hash | Miner encodes data via a sequential graph labeling process; unique replica per miner; encoding is slow (ensures physical storage), verification is fast via SNARK [[1]](https://filecoin.io/proof-of-replication.pdf) |
| **Proof of Spacetime (PoSt) — Filecoin** | 2017 | Repeated PoRep challenges over time | Miner proves continuous storage by responding to periodic random challenges; missed challenges slash collateral; WindowPoSt (every 24h) + WinningPoSt (per block) [[1]](https://spec.filecoin.io/algorithms/pos/) |
| **Chia Proof of Space** | 2019 | Beyond Hellman + graph pebbling | Miner pre-computes and stores large lookup tables from a random function; lookup proofs demonstrate committed disk space; combined with VDF for consensus [[1]](https://www.chia.net/wp-content/uploads/2022/09/Chia_Proof_of_Space_Construction_v1.1.pdf) |

The core challenge is preventing "outsourcing attacks" (miner stores data on someone else's disk), "generation attacks" (miner re-derives data from a short seed instead of storing it), and "sybil storage" (claiming N copies but storing only 1). Filecoin's PoRep addresses this by requiring an encoding step that is inherently sequential and miner-specific — each replica is a unique transformation of the original data through a depth-robust graph, meaning the miner must have physically performed the slow encoding. PoSt extends this guarantee over time: the miner must respond to random challenges that require reading specific positions of the encoded replica, proving the data remains stored.

**State of the art:** Filecoin (production since 2020; >20 EiB stored); Chia (proof of space + VDF consensus). Related to [PoW / Proof of Space](13-blockchain-distributed-ledger.md#proof-of-work-pow-proof-of-space) and [Proof of Data Possession / PoR](09-commitments-verifiability.md#proofs-of-retrievability-por-provable-data-possession).

**Production readiness:** Production
Filecoin in production since 2020 with >20 EiB of verified storage; Chia mainnet since 2021; Compact PoR (Shacham-Waters) widely implemented.

**Implementations:**
- [lotus](https://github.com/filecoin-project/lotus) ⭐ 3.0k — Go, Filecoin node implementation with PoRep/PoSt
- [rust-fil-proofs](https://github.com/filecoin-project/rust-fil-proofs) ⭐ 503 — Rust, Filecoin's proof-of-replication and proof-of-spacetime library
- [chiapos](https://github.com/Chia-Network/chiapos) ⭐ 270 — C++, Chia's proof-of-space plotting and verification

**Security status:** Secure
PoRep's depth-robust graph labeling provably prevents outsourcing and generation attacks; PoSt's periodic challenges enforce continuous storage; Chia's Beyond Hellman proofs are well-analyzed.

**Community acceptance:** Emerging
Filecoin and Chia are major blockchain projects with significant adoption; academic community active (CCS, CRYPTO publications); no IETF standard but growing decentralized storage ecosystem.

---

## Cryptographic Reverse Firewalls

**Goal:** Protect a cryptographic protocol participant even when their own machine is compromised or backdoored — by routing all communication through an external "reverse firewall" that re-randomizes messages to strip any subliminal channels, without needing to know the participant's secret keys or trust the participant's implementation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Mironov-Stephens-Brito CRF** | 2015 | Re-randomizable encryption + signatures | First formalization of cryptographic reverse firewalls; defines security: firewall preserves functionality + eliminates subliminal channels; constructions for OT, key exchange, and signatures [[1]](https://eprint.iacr.org/2014/758) |
| **CRF for Key Exchange (Dodis et al.)** | 2016 | Rerandomizable DH | Reverse firewall for Diffie-Hellman: firewall re-randomizes DH messages so that even a kleptographic implementation cannot exfiltrate the secret key [[1]](https://eprint.iacr.org/2016/424) |
| **CRF for Signatures (Ateniese et al.)** | 2016 | Rerandomizable Schnorr | Reverse firewall re-randomizes Schnorr signature nonces; prevents nonce-covert-channel attacks (cf. NIST Dual_EC_DRBG-style backdoors) [[1]](https://eprint.iacr.org/2015/1189) |
| **CRF for MPC** | 2020 | Rerandomizable garbled circuits | Extends CRFs to general MPC protocols; firewall rerandomizes garbled circuit messages without knowing the circuit inputs [[1]](https://eprint.iacr.org/2020/594) |

The motivating threat is **algorithm substitution attacks (ASA)**: a compromised implementation uses subliminal channels in its random-looking outputs (nonces, ciphertexts) to leak secret keys to a passive eavesdropper. The NSA's Dual_EC_DRBG backdoor is the canonical example. A cryptographic reverse firewall sits between the user's compromised machine and the network, re-randomizing every outgoing message. The key property is that the firewall does not need the user's secret key — it only needs the protocol to be algebraically rerandomizable. The firewall maintains functionality (the protocol still works correctly) while destroying any covert channel. The limitation is that the protocol must be designed with rerandomizability in mind.

**State of the art:** Theoretical framework (2015+); practical constructions exist for DH, Schnorr, ElGamal, and OT. Closely related to [Kleptography / ASA](18-covert-channels-steganography.md#kleptography-algorithm-substitution-attacks-asa) (the attack CRFs defend against) and [Cryptographic Reverse Firewalls](19-theoretical-foundations.md#cryptographic-reverse-firewalls) in category 19.

**Production readiness:** Research
Theoretical framework with constructions for DH, Schnorr, ElGamal, and OT; no production deployment or commercial product.

**Implementations:**
- No widely maintained open-source implementations; research code accompanies individual papers (Mironov-Stephens-Brito, Dodis et al.).

**Security status:** Secure
Provably eliminates subliminal channels under stated algebraic rerandomizability assumptions; limited to protocols designed with rerandomizability in mind.

**Community acceptance:** Niche
Well-cited in the academic kleptography/ASA defense literature; motivated by the Dual_EC_DRBG backdoor; no standardization or industry adoption.

---

## Leakage-Resilient Protocols

**Goal:** Maintain security even when the adversary obtains partial information about secret keys via side-channel attacks (power analysis, electromagnetic emanations, cache timing, cold-boot attacks). The secret key leaks bounded bits per invocation, but the protocol remains secure as long as total leakage stays below a threshold.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dziembowski-Pietrzak Leakage-Resilient Stream Cipher** | 2008 | Alternating extraction | First leakage-resilient stream cipher; key updated each round via alternating extractors; tolerates λ bits of leakage per round [[1]](https://eprint.iacr.org/2008/491) |
| **Kiltz-Pietrzak Leakage-Resilient ElGamal** | 2010 | Hash proof systems | CCA-secure PKE tolerating leakage; based on smooth projective hash functions; first leakage-resilient CCA encryption [[1]](https://eprint.iacr.org/2009/429) |
| **Faust-Kiltz-Pietrzak-Rothblum Leakage-Resilient Sigs** | 2010 | One-time sigs + tree-based refreshing | Signature scheme secure under continual leakage; key refreshed after each signature via a binary tree of one-time keys [[1]](https://eprint.iacr.org/2009/282) |
| **Dodis-Haralambiev-Lopez-Alt-Wichs Efficient PKE** | 2010 | Lattice-based + leakage | Efficient LWE-based encryption tolerating key leakage up to (1-o(1)) fraction of the key length [[1]](https://eprint.iacr.org/2010/163) |
| **Continual Leakage Model (Brakerski et al.)** | 2010 | Key-update + bounded leakage per epoch | Security under unbounded total leakage, as long as per-epoch leakage is bounded; key refreshed between epochs; captures real-world side-channel settings [[1]](https://eprint.iacr.org/2010/278) |

The model captures real-world attacks where an adversary cannot extract the full key but obtains partial information each time the key is used (e.g., differential power analysis on a smart card). The "bounded leakage model" allows up to λ bits of arbitrary leakage of the secret key; the "continual leakage model" allows λ bits per time period with key updates between periods. Constructions typically rely on secret sharing the key internally and refreshing shares, or on algebraic structures (hash proof systems, lattices) where partial key leakage does not break the underlying hardness assumption.

**State of the art:** Continual-leakage model with key refresh (theoretical); lattice-based constructions are most efficient. Related to [Leakage-Resilient Cryptography](19-theoretical-foundations.md#leakage-resilient-cryptography) (foundations) and [Key-Insulated Cryptography](#key-insulated-cryptography) (complementary approach).

**Production readiness:** Research
Theoretical constructions with proofs of security under leakage; no production-deployed leakage-resilient protocol; smart card countermeasures use related principles informally.

**Implementations:**
- No widely maintained open-source implementations of leakage-resilient protocols; research code accompanies individual papers (Dziembowski-Pietrzak, Kiltz-Pietrzak).

**Security status:** Secure
Provably secure under bounded or continual leakage models; lattice-based constructions tolerate leakage up to (1-o(1)) fraction of key length; key refresh ensures long-term security.

**Community acceptance:** Niche
Active academic research area (CRYPTO, EUROCRYPT publications); informs practical side-channel countermeasures in smart cards and HSMs; no formal standard.

---

## Time-Release Cryptography / Timed Commitments

**Goal:** Encrypt a message so that it cannot be decrypted until a specified future time — without relying on a trusted third party to release a key. The recipient (or anyone) can force-open the ciphertext by performing a predetermined amount of sequential computation, or wait for a time-server to release a decryption token.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest-Shamir-Wagner Time-Lock Puzzles** | 1996 | Repeated squaring mod N | Encrypt message under key derivable only by computing x^(2^T) mod N; T sequential squarings enforce minimum wall-clock time; original "send a message to the future" construction [[1]](https://people.csail.mit.edu/rivest/pubs/RSW96.pdf) |
| **Boneh-Naor Timed Commitments** | 2000 | Time-lock puzzle + ZK proof of correctness | Committer proves the timed commitment contains the correct value via a ZK proof; prevents malicious commitments that are unsolvable or contain garbage [[1]](https://doi.org/10.1007/3-540-44598-6_15) |
| **Thyagarajan et al. Verifiable Timed Signatures** | 2020 | Time-lock puzzle + adaptor sigs | Signer produces a "timed signature" that becomes valid after T sequential squarings; enables fair exchange without simultaneous participation [[1]](https://eprint.iacr.org/2020/1563) |
| **drand + Timelock Encryption** | 2023 | Threshold BLS + identity-based encryption | Message encrypted under a future round number of the drand randomness beacon; beacon nodes collectively produce BLS signature each round, which serves as the decryption key; no computation required by recipient [[1]](https://eprint.iacr.org/2023/189) |
| **Delay Encryption (Burdges-De Feo)** | 2021 | VDF + identity-based encryption | Encryption keyed to a future identity; decryption key computable only after VDF evaluation; combines VDF and IBE into a single primitive [[1]](https://eprint.iacr.org/2020/638) |

Two paradigms exist. **Computational time-release** (Rivest-Shamir-Wagner) forces the recipient to perform T sequential squarings — no parallelism helps, but the sender must estimate the recipient's hardware speed. **Beacon-based time-release** (drand) encrypts to a future beacon round; when the beacon fires, the decryption key is publicly available — no computation needed, but the beacon must be trusted (or threshold-distributed). Timed commitments add verifiability: the committer proves the puzzle is well-formed, preventing denial-of-service via unsolvable puzzles. Applications include sealed-bid auctions (bids auto-open at deadline), cryptocurrency fair exchange, and digital wills.

**State of the art:** drand timelock encryption (production, used by Filecoin and Protocol Labs); VDF-based delay encryption (research). Related to [Time-Lock Puzzles](09-commitments-verifiability.md#time-lock-puzzles-timed-release-encryption), [VDFs](#verifiable-delay-functions-vdfs), and [Delay Encryption](09-commitments-verifiability.md#delay-encryption).

**Production readiness:** Mature
drand timelock encryption used in production by Filecoin and Protocol Labs; RSW time-lock puzzles well-implemented; delay encryption is research-stage.

**Implementations:**
- [drand](https://github.com/drand/drand) ⭐ 813 — Go, distributed randomness beacon with timelock encryption support
- [tlock](https://github.com/drand/tlock) ⭐ 634 — Go, timelock encryption library built on drand beacon
- [timelock-puzzle](https://github.com/EtherDream/timelock) ⭐ 31 — various, implementations of RSW time-lock puzzles

**Security status:** Secure
RSW time-lock puzzles secure under sequential squaring assumption; drand beacon-based timelock secure under threshold BLS assumption and beacon liveness; timed commitments with ZK prevent malicious puzzles.

**Community acceptance:** Emerging
drand is a production service with multiple operators (Cloudflare, Protocol Labs, EPFL); time-lock puzzles well-studied since 1996; delay encryption is an active research frontier.

---

## Secure Location Verification

**Goal:** Cryptographically verify that a prover is physically located at a claimed position in space — using the speed of light as an unforgeable physical constraint — without trusting the prover's hardware or software. Multiple verifiers at known positions challenge the prover and measure response times to triangulate and bound the prover's location.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chandran-Goyal-Moriarty-Ostrovsky Secure Positioning** | 2009 | Multi-verifier timing + commitment | First formal model for secure positioning; proves impossibility of position verification with a bounded number of colluding adversaries; possible in the bounded-storage model [[1]](https://eprint.iacr.org/2009/364) |
| **Buhrman et al. Position-Based Quantum Crypto** | 2011 | Quantum no-cloning + EPR pairs | Position verification using quantum channels; no-cloning theorem prevents adversaries from duplicating quantum challenges; secure against non-entangled adversaries [[1]](https://doi.org/10.1007/978-3-642-22792-9_26) |
| **Brands-Chaum Distance Bounding (applied)** | 1993 | Challenge-response + speed-of-light timing | Multi-verifier extension of distance bounding; prover must respond within time consistent with claimed position relative to all verifiers [[1]](https://doi.org/10.1007/3-540-48285-7_30) |
| **GPS Authentication (Tippenhauer et al.)** | 2011 | Signal authentication + anomaly detection | Demonstrated GPS spoofing attacks; proposed authenticated navigation signals using symmetric MAC (TESLA-like) over civilian GPS [[1]](https://doi.org/10.1145/2046707.2046729) |
| **Galileo OSNMA** | 2023 | TESLA MAC + ECDSA over navigation signal | First deployed authenticated GNSS; navigation message carries TESLA MACs and ECDSA signatures; receivers verify signal authenticity; operational since 2023 [[1]](https://www.gsc-europa.eu/sites/default/files/sites/all/files/Galileo_OSNMA_User_ICD_for_Test_Phase_v1.1.pdf) |

A fundamental impossibility result (Chandran et al., 2009) shows that classical secure positioning is impossible against multiple colluding adversaries who can relay messages at the speed of light. Quantum position verification circumvents this using the no-cloning theorem: adversaries cannot copy a quantum challenge to relay it to multiple positions. In practice, GPS/GNSS authentication (Galileo OSNMA) provides "good enough" location verification for civilian use by authenticating navigation signals, preventing spoofing rather than proving exact position.

**State of the art:** Galileo OSNMA (production 2023, first authenticated GNSS); quantum position verification (theoretical); classical schemes require physical assumptions. Related to [Distance-Bounding Protocols](#distance-bounding-protocols) and [Proof of Location](17-ai-hardware-physical-security.md#proof-of-location-spatial-proofs).

**Production readiness:** Production
Galileo OSNMA operational since 2023 (first authenticated GNSS); classical secure positioning requires physical assumptions; quantum position verification is theoretical.

**Implementations:**
- [Galileo OSNMA](https://www.gsc-europa.eu/osnma) — operational EU GNSS service with TESLA-based signal authentication
- No open-source quantum position verification implementations exist.

**Security status:** Caution
Classical secure positioning proven impossible against multiple colluding adversaries (Chandran et al. 2009); Galileo OSNMA authenticates signals but does not prove position; quantum schemes secure against non-entangled adversaries only.

**Community acceptance:** Emerging
Galileo OSNMA is the first standardized authenticated GNSS (operational 2023); GPS Chimera follows similar principles; quantum position verification is an active research area with no practical deployment.

---

## Cryptography for Genomic Privacy

**Goal:** Enable genomic analyses — disease risk scoring, pharmacogenomics, GWAS (genome-wide association studies), and ancestry queries — on encrypted or secret-shared genomic data, so that neither the analyst, the cloud, nor other study participants learn an individual's raw genome. Combines multi-key HE, MPC, and differential privacy to protect the most sensitive and immutable personal data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HEGP (Lauter-Lopez-Alt-Naehrig)** | 2014 | BGV HE + SIMD packing | First practical HE-based GWAS; SNP-level chi-squared statistics computed on encrypted genotypes; demonstrated on 400+ samples [[1]](https://doi.org/10.1186/1471-2105-15-S7-S3) |
| **PLINK-HE (Kim-Lauter)** | 2015 | CKKS approximate HE | Encrypted logistic regression for genome-wide association; supports real-valued phenotype covariates; practical for ~10K SNPs [[1]](https://doi.org/10.1186/s12920-015-0077-5) |
| **iDASH Genomic Privacy Competition** | 2014+ | Various (HE, MPC, DP) | Annual competition benchmarking genomic privacy solutions; tasks include encrypted GWAS, secure genotype imputation, and private federated learning on genomic data [[1]](http://www.humangenomeprivacy.org/) |
| **Multi-Key HE for Genomics (Chen et al.)** | 2019 | Multi-key CKKS | Multiple hospitals encrypt genomes under their own keys; joint computation without combining keys; threshold decryption of aggregate results only [[1]](https://eprint.iacr.org/2019/524) |
| **Secure Genome Sequence Comparison (Atallah et al.)** | 2003 | Edit distance via GC | First secure edit distance computation on genomic sequences via Yao's garbled circuits; enables private similarity testing [[1]](https://doi.org/10.1145/882082.882100) |

Genomic data is uniquely sensitive: it is immutable (cannot be revoked or changed like a password), identifies relatives, reveals disease predispositions, and is increasingly required for precision medicine. The iDASH competition has driven practical progress since 2014, benchmarking encrypted GWAS, secure genotype imputation, and private machine learning on genomic data. Multi-key HE is particularly natural for genomics: each hospital encrypts under its own key, a cloud computes on the joint ciphertext, and only a threshold of hospitals can decrypt the aggregate result — no party ever sees raw genomes from another institution.

**State of the art:** Multi-key CKKS for multi-institutional GWAS (research prototypes); iDASH competition drives annual benchmarks; Microsoft SEAL and HEAAN used in genomic HE implementations. Related to [FHE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he) and [Multi-Key / Threshold FHE](07-homomorphic-functional-encryption.md#multi-key-threshold-fhe).

**Production readiness:** Experimental
iDASH competition prototypes demonstrate feasibility; Microsoft SEAL and HEAAN used in genomic HE research; no production clinical deployment of encrypted GWAS.

**Implementations:**
- [Microsoft SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, HE library used in genomic privacy research (BFV, CKKS)
- [HElib](https://github.com/homenc/HElib) ⭐ 3.2k — C++, IBM's HE library with BGV support for GWAS
- [EMP-toolkit](https://github.com/emp-toolkit/emp-tool) ⭐ 241 — C++, MPC framework for garbled circuit-based genome comparison
- [HEAAN](https://github.com/kimandrik/HEAAN) ⭐ 66 — C++, approximate HE (CKKS) used in genomic computations

**Security status:** Caution
HE and MPC computations are cryptographically secure; however, membership inference attacks on aggregate genomic statistics (Homer et al. 2008) require differential privacy for output protection.

**Community acceptance:** Emerging
iDASH competition (annual since 2014) drives community progress; growing regulatory interest (GDPR, HIPAA); active research but no clinical standard for encrypted genomics.

---

## Satellite Communication Cryptography

**Goal:** Secure communication links between ground stations and satellites — including LEO, GEO, and deep-space — against eavesdropping, jamming, and spoofing, under constraints of extreme latency, limited computational power onboard, and long mission lifetimes that may outlast cryptographic algorithms.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CCSDS Space Data Link Security (SDLS)** | 2015 | AES-GCM + key management | CCSDS standard for authenticated encryption of telecommand and telemetry; AES-256-GCM for GEO/LEO links; handles frame-level encryption with anti-replay [[1]](https://public.ccsds.org/Pubs/355x0b2.pdf) |
| **CCSDS Key Management (SDLS-KM)** | 2020 | ECDH + X.509 adapted for space | Key agreement for satellite links; adapts ECDH to high-latency channels; pre-positioned keys for emergency; group key for broadcast [[1]](https://public.ccsds.org/Pubs/357x0b1.pdf) |
| **QKD via Satellite (Micius)** | 2017 | BB84 + decoy state | First satellite-to-ground QKD; Chinese Micius satellite demonstrated 1200 km QKD link; key rates ~1 kbit/s [[1]](https://doi.org/10.1038/nature23655) |
| **Blockstream Satellite (Bitcoin broadcast)** | 2017 | AES + ECDSA | Broadcasts Bitcoin blockchain and encrypted messages via GEO satellites; receivers verify ECDSA signatures on blocks; provides censorship-resistant access [[1]](https://blockstream.com/satellite/) |
| **NIST IR 8270 (Crypto for Space)** | 2023 | Lightweight + PQC recommendations | NIST guidelines for cryptographic algorithm selection for space missions; addresses 15+ year mission lifetimes requiring PQC readiness [[1]](https://csrc.nist.gov/publications/detail/nistir/8270/draft) |

Space links face unique constraints: GEO round-trip latency is ~600ms (making interactive key exchange expensive), onboard processors are radiation-hardened but computationally limited, mission lifetimes of 15-30 years require crypto-agility, and the broadcast nature of satellite signals makes eavesdropping trivial. CCSDS SDLS addresses these with pre-positioned keys and frame-level AES-GCM. Satellite QKD (Micius) extends quantum key distribution to intercontinental distances by using free-space optical channels through the atmosphere, avoiding fiber-optic losses over long distances. Post-quantum readiness is critical because satellites launched today may operate beyond the expected timeline for large-scale quantum computers.

**State of the art:** CCSDS SDLS (deployed on ESA/NASA missions); Micius QKD (Chinese Academy of Sciences, 2017+); NIST PQC recommendations for long-lived space missions. Related to [QKD](15-quantum-cryptography.md#quantum-key-distribution-qkd) and [Lightweight Cryptography](01-foundational-primitives.md#lightweight-cryptography-ascon).

**Production readiness:** Production
CCSDS SDLS deployed on ESA and NASA missions; Micius satellite QKD operational since 2017; Blockstream Satellite broadcasts Bitcoin blockchain via GEO satellites.

**Implementations:**
- [CCSDS SDLS reference](https://public.ccsds.org/) — C, reference implementations provided by CCSDS member agencies
- [Blockstream Satellite](https://github.com/Blockstream/satellite) ⭐ 1.0k — C/Python, open-source satellite receiver software
- [SatNOGS](https://satnogs.org/) — Python, open-source ground station network (not crypto-specific but used for satellite communication research)

**Security status:** Caution
CCSDS SDLS uses AES-256-GCM (secure); satellite QKD limited by key rates (~1 kbit/s) and atmospheric conditions; long mission lifetimes (15-30 years) require PQC readiness for launches today.

**Community acceptance:** Standard
CCSDS standards are mandatory for ESA/NASA missions; NIST IR 8270 provides PQC guidance for space; satellite QKD is an active research program (Chinese Academy of Sciences, ESA SAGA).

---

## ISO 20022 / SWIFT MX Financial Message Signing

**Goal:** Authenticate and integrity-protect high-value interbank payment messages (ISO 20022 / SWIFT MX format) so that a message cannot be forged, replayed, or tampered with in transit — while preserving the structured XML payload that downstream systems parse for compliance screening and settlement.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SWIFT PKI + X.509 message signing** | 2001 | RSA-2048 + SHA-256 + X.509v3 | SWIFT-operated CA issues certificates to member institutions; MX messages signed with institution's private key; signature carried in `<AppHdr>` Business Application Header [[1]](https://www.swift.com/our-solutions/global-financial-messaging/swiftnets-infrastructure/swiftnet-pki) |
| **ISO 20022 Business Application Header (BAH)** | 2013 | ASN.1 / XML Digital Signature | Standardized header for all MX message types (pacs, camt, pain…); digital signature field based on W3C XML-DSig; canonicalization via Exclusive XML Canonicalization (C14N) [[1]](https://www.iso20022.org/sites/default/files/documents/D7/ISO20022_BAH_v2.pdf) |
| **W3C XML-DSig (RFC 3275)** | 2002 | Enveloped / enveloping / detached | Signing algorithm negotiated per message; RSA-SHA256 most common in SWIFT context; XPath transforms allow signing specific XML subtrees (e.g., only the payment instruction block) [[1]](https://www.w3.org/TR/xmldsig-core/) |
| **SWIFT gpi Tracker + HMAC integrity** | 2017 | HMAC-SHA256 per leg | Global Payments Innovation tracker assigns a Unique End-to-End Transaction Reference (UETR); each correspondent bank appends an HMAC-chained status update; chain-of-custody visible to originator and beneficiary [[1]](https://www.swift.com/our-solutions/global-financial-messaging/swift-gpi) |
| **ISO 20022 + JWS (emerging)** | 2023 | JSON Web Signature (RFC 7515) | Migration path for REST-based payment APIs; message body hashed and signed as a JWS detached payload; JSON-native alternative to XML-DSig [[1]](https://www.swift.com/standards/iso-20022/iso-20022-api-standards) |

The central cryptographic challenge in interbank messaging is **non-repudiation under structured transformation**: a payment message passes through multiple correspondent banks, each of which may add, translate, or truncate fields. XML-DSig's enveloped signature over the full document would break on any modification. The BAH solves this by separating the header (signed, immutable) from the payload (which may be transformed). SWIFT's gpi HMAC chain provides a weaker but transit-compatible integrity guarantee: each processing bank extends the chain, so the originator can verify the full processing path. The Bangladesh Bank heist (2016, $81 M stolen via fraudulent SWIFT messages) drove the industry to mandate two-factor authentication for SWIFT terminals and accelerated gpi adoption.

**State of the art:** SWIFT MX + BAH v2 (mandatory for all high-value cross-border payments from 2025 under SWIFT's migration timeline); gpi Tracker deployed by 4 000+ banks. Related to [DKIM](12-secure-communication-protocols.md#rpki-bgpsec-route-origin-authentication) (similar "sign the header, allow body transformation" pattern) and [PKI](14-applied-infrastructure-pki.md#x509-certificate-path-validation-rfc-5280).

**Production readiness:** Production
SWIFT MX + BAH v2 mandatory for cross-border payments from 2025; gpi Tracker deployed by 4,000+ banks; ISO 20022 migration underway globally.

**Implementations:**
- [SWIFT SDK](https://developer.swift.com/) — proprietary, SWIFT-provided libraries for MX message creation and signing
- [prowide-iso20022](https://github.com/prowide/prowide-iso20022) ⭐ 209 — Java, open-source ISO 20022 message library (parsing, not signing)
- [Apache Santuario](https://santuario.apache.org/) — Java/C++, XML Digital Signature (XML-DSig) implementation used in SWIFT BAH signing

**Security status:** Secure
RSA-2048 + SHA-256 signing with SWIFT-operated PKI; gpi HMAC chain provides transit integrity; Bangladesh Bank heist (2016) drove mandatory two-factor authentication for SWIFT terminals.

**Community acceptance:** Standard
ISO 20022 is an international standard; SWIFT PKI is the de facto standard for interbank message authentication; mandatory migration timeline ensures universal adoption by 2025.

---

## Privacy-Preserving Credit Scoring

**Goal:** Allow a lender to determine whether an applicant meets a creditworthiness threshold without learning the applicant's raw financial data, and allow the applicant to prove their score exceeds the threshold without revealing the underlying records or the exact score.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ZK Range Proof for Credit Score** | 2017 | Bulletproofs / Pedersen commitments | Applicant commits to a score s; proves in ZK that s ≥ threshold T without revealing s; lender checks the range proof; O(log n) proof size with Bulletproofs [[1]](https://eprint.iacr.org/2017/1066) |
| **MPC-based Joint Credit Scoring** | 2019 | Yao's GC + OT | Multiple data sources (bank, telco, utility) jointly evaluate a scoring function over their private records without any party seeing another's data; lender receives only the output bit [[1]](https://eprint.iacr.org/2019/518) |
| **zkKYC (Zero-Knowledge Know-Your-Customer)** | 2021 | Groth16 / PLONK + identity commitments | Applicant proves identity attributes (residency, sanctions check, income band) to a lender using ZK proofs over signed attestations from KYC providers; no raw PII transferred [[1]](https://eprint.iacr.org/2021/907) |
| **Federated Credit Scoring (SecureBoost)** | 2019 | Federated learning + additive HE | Each bank trains a local gradient-boosted tree; gradients encrypted with Paillier HE before sharing; aggregated model works across all parties' data without raw data leaving any party [[1]](https://arxiv.org/abs/1901.08755) |
| **FICO Score via FHE (pilot)** | 2022 | TFHE / BFV | Proof-of-concept: credit bureau evaluates a scoring function homomorphically on lender-encrypted applicant record; bureau never sees plaintext data; score returned encrypted [[1]](https://homomorphicencryption.org/wp-content/uploads/2020/12/HAW20.pdf) |

The core tension is between **credit bureau data monopoly** and **borrower privacy**. Traditional credit scoring requires the bureau to see all raw tradeline data. ZK range proofs let an applicant prove score ≥ T using a bureau-signed commitment to their score — the lender never contacts the bureau. MPC-based approaches eliminate the central bureau entirely: lenders jointly compute a score across distributed data. FHE pilots show feasibility but remain 100–1 000× slower than plaintext evaluation for realistic scoring models. The zkKYC pattern (ZK proofs over signed identity attestations) is seeing regulatory attention in the EU under eIDAS 2.0.

**State of the art:** ZK range proofs (research/pilots, e.g., Sygnum Bank zkKYC); federated scoring (Ant Group, WeBank production); FHE credit scoring (IBM/FICO research 2022). Related to [Bulletproofs](04-zero-knowledge-proof-systems.md#bulletproofs-inner-product-argument), [ZK SNARKs](04-zero-knowledge-proof-systems.md#circom-and-snarkjs), and [MPC](06-multi-party-computation.md#multi-party-computation-mpc).

**Production readiness:** Experimental
Federated credit scoring deployed by Ant Group and WeBank; ZK range proofs and zkKYC in pilot (Sygnum Bank); FHE credit scoring is research-stage (100-1000x overhead).

**Implementations:**
- [FATE](https://github.com/FederatedAI/FATE) ⭐ 6.1k — Python, WeBank's federated learning framework including SecureBoost for credit scoring
- [Bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust, range proof library usable for credit score ZK proofs
- [Microsoft SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, FHE library used in FICO credit scoring research
- [circom](https://github.com/iden3/circom) ⭐ 1.6k — Rust, ZK circuit compiler used in zkKYC implementations

**Security status:** Caution
Cryptographic primitives (ZK, HE, MPC) are provably secure; practical security depends on correct deployment, non-collusion of data holders, and proper output privacy (DP for aggregates).

**Community acceptance:** Emerging
EU eIDAS 2.0 references zkKYC patterns; WeBank/Ant Group deploy federated scoring at scale in China; Western financial regulators evaluating; no formal standard for privacy-preserving credit scoring.

---

## Privacy-Preserving Healthcare Data Sharing

**Goal:** Enable clinical research, genomic studies, and cross-institution analytics over sensitive patient data without exposing individual records — combining record linkage, genomic privacy, and aggregate query mechanisms so that researchers get statistically valid results while patients retain meaningful privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Privacy-Preserving Record Linkage (PPRL)** | 2009 | Bloom filter encoding + two-party PSI | Match patient records across hospital databases without revealing records or identifiers to either party; Bloom filter of name/DOB/address encoded, hashed, and compared via PSI [[1]](https://doi.org/10.1145/1557019.1557099) |
| **Sharemind / MPC for Medical Statistics** | 2013 | Secret sharing (3-party) | Sharemind system: patient records secret-shared across three non-colluding servers; aggregate statistics (mean, regression, chi-squared) computed without any server learning individual records; deployed for national statistics in Estonia [[1]](https://link.springer.com/chapter/10.1007/978-3-540-85174-5_14) |
| **Beacon Protocol (GA4GH)** | 2016 | Allele presence query | Genomic data sharing API: answer yes/no queries on allele presence across a consortium without revealing which patient carries the allele; no encryption but rate-limiting + differential privacy mitigate membership inference [[1]](https://www.ga4gh.org/product/beacon-api/) |
| **LDP Genomics (Erlingsson et al. / RAPPOR applied)** | 2017 | Local differential privacy | Each patient locally randomizes their genomic variant before contributing; aggregator learns allele frequencies with ε-DP guarantee; individual genotypes never leave the device [[1]](https://arxiv.org/abs/1407.6981) |
| **Secure GWAS (genome-wide association studies)** | 2019 | HE (BFV/CKKS) + MPC | Participants encrypt their genotype vectors; joint linear regression or logistic regression evaluated homomorphically across institutions; no raw genotype leaves the contributing institution [[1]](https://eprint.iacr.org/2019/1422) |
| **Federated Learning for Clinical NLP (OwkinFL)** | 2021 | Federated learning + SecAgg | Hospitals train local ML models on patient records; only model gradients (aggregated with SecAgg) shared; Owkin platform deployed across 20+ cancer research centers [[1]](https://www.owkin.com/federated-learning) |
| **Synthetic Patient Data (CTGAN + DP)** | 2020 | GAN + DP-SGD | Train a generative model with differential privacy; release synthetic patient records that preserve statistical distributions but do not correspond to real individuals; used in MIMIC-III synthetic releases [[1]](https://arxiv.org/abs/2001.09756) |

The genomic privacy problem is qualitatively harder than general data privacy: a genome is permanent, familially correlated, and re-identifiable even from aggregate statistics. Membership inference attacks on genomic beacons (Homer et al. 2008) showed that with ~1 000 SNPs an attacker can determine whether a target individual is in a GWAS cohort from only summary statistics. PPRL closes the record linkage gap without exposing identifiers; MPC and FHE allow joint computation without a trusted data custodian; DP provides formal bounds on information leakage from aggregate outputs.

**State of the art:** PPRL (deployed in UK Biobank, Australian AIHW); Sharemind MPC (Estonian national health statistics); federated GWAS (UK Biobank + Finngen consortium); DP synthetic data (MIMIC-IV). Related to [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy), [PSI](10-privacy-preserving-computation.md#private-set-intersection-psi), and [PPRL](10-privacy-preserving-computation.md#privacy-preserving-record-linkage-pprl).

**Production readiness:** Production
PPRL deployed in UK Biobank and Australian AIHW; Sharemind MPC used for Estonian national health statistics; Owkin federated learning deployed across 20+ cancer research centers.

**Implementations:**
- [Sharemind](https://sharemind.cyber.ee/) — C++, 3-party MPC platform deployed for Estonian health statistics
- [Owkin](https://github.com/owkin) — Python, federated learning platform for clinical research
- [Synthea](https://github.com/synthetichealth/synthea) ⭐ 3.1k — Java, synthetic patient data generator (not DP but related)
- [DataSHIELD](https://github.com/datashield) — R, federated analysis of sensitive health data without sharing individual records
- [RAPPOR](https://github.com/google/rappor) ⭐ 870 — Python, Google's local differential privacy framework applicable to health data

**Security status:** Caution
MPC and HE components are cryptographically secure; membership inference attacks on aggregate genomic data (Homer et al. 2008) require differential privacy on outputs; PPRL Bloom filters may leak information under certain attack models.

**Community acceptance:** Emerging
GA4GH Beacon protocol adopted by major genomic consortia; Sharemind deployed by Estonian government; growing regulatory support (GDPR, HIPAA); active standardization in health data interoperability.

---

## Secure Time Synchronization (NTPsec, Roughtime)

**Goal:** Ensure that a client's clock is set to the correct time by a trustworthy server — and that a network attacker cannot cause the client to accept a false time, which would invalidate TLS certificates, TOTP tokens, Kerberos tickets, and audit logs. Ranges from authenticated NTP to cryptographically verifiable multi-server time protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **NTPv4 (RFC 5905)** | 2010 | Symmetric-key MAC | Standard network time protocol; optional MD5-HMAC authentication between trusted peers; no public-key infrastructure; widely deployed but unauthenticated by default [[1]](https://www.rfc-editor.org/rfc/rfc5905) |
| **NTS (Network Time Security, RFC 8915)** | 2020 | TLS 1.3 key exchange + AES-SIV-CMAC per packet | NTS-KE phase establishes keys over TLS; subsequent NTP packets authenticated with AES-128-SIV-CMAC; stateless server cookies prevent replay; first cryptographically sound NTP security layer [[1]](https://www.rfc-editor.org/rfc/rfc8915) |
| **NTPsec** | 2017 | NTPv4 + NTS + hardened implementation | Reference implementation of NTPv4 with NTS support; reduced attack surface (removed 70% of legacy NTPv4 code); NTPD replacement maintained by the NTPsec Project [[1]](https://www.ntpsec.org/) |
| **Roughtime (RFC 9714)** | 2024 | Ed25519 + Merkle tree + multi-server chaining | Each response signed with Ed25519 over (nonce ∥ timestamp ∥ radius); client can prove the server misbehaved using a signed timestamp as evidence; multi-server chaining detects inconsistent time across providers [[1]](https://www.rfc-editor.org/rfc/rfc9714) |
| **TrueTime (Google Spanner)** | 2012 | GPS + atomic clocks + interval arithmetic | Each datacenter has GPS receivers and atomic clocks; TrueTime API returns [earliest, latest] time interval; Spanner waits out the uncertainty interval before committing to ensure global consistency [[1]](https://research.google/pubs/pub39966/) |
| **Ticktock (Amazon Time Sync Service)** | 2017 | NTP + GPS disciplined oscillators | AWS fleet synchronizes to GPS-derived stratum-1 servers in each region; sub-microsecond accuracy within a region; public endpoint at 169.254.169.123 [[1]](https://aws.amazon.com/blogs/aws/keeping-time-with-amazon-time-sync-service/) |

The primary attack vector against NTP is the **off-path time injection**: an attacker who can send spoofed UDP packets causes a client to accept a false timestamp, backdating the client's clock into a window where an expired TLS certificate is still valid (or a not-yet-valid certificate is rejected). RFC 8915 (NTS) eliminates this by deriving per-session keys over TLS and authenticating every packet with a MAC, making replay and injection impossible without the session key. Roughtime (RFC 9714) adds a stronger property: if a server lies about the time, the client obtains a signed proof of the lie that can be published — servers are **accountable**. The multi-server chaining protocol detects inconsistency across Roughtime providers, so an attacker must compromise all servers simultaneously to deceive a client.

**State of the art:** NTS/NTPsec (Cloudflare time.cloudflare.com, deployed 2020; major Linux distributions adopting); Roughtime (Google Roughtime, Cloudflare Roughtime, RFC 9714 published 2024). Related to [TOTP/FIDO2](12-secure-communication-protocols.md#token-based-authentication-totp-fido2-webauthn) (time-sensitive authentication), [Linked Timestamping](#linked-timestamping), and [VDF](#verifiable-delay-functions-vdfs).

**Production readiness:** Production
NTPv4 universally deployed; NTS/NTPsec in production at Cloudflare (time.cloudflare.com) and adopted by major Linux distributions; Roughtime RFC 9714 published 2024; TrueTime powers Google Spanner.

**Implementations:**
- [NTPsec](https://github.com/ntpsec/ntpsec) ⭐ 277 — C, hardened NTPv4 implementation with NTS support
- [chrony](https://github.com/mlichvar/chrony) ⭐ 198 — C, NTP implementation with NTS support (default in RHEL/Fedora)
- [roughenough](https://github.com/int08h/roughenough) ⭐ 142 — Rust, Roughtime server implementation
- [roughtime](https://github.com/cloudflare/roughtime) ⭐ 169 — Go, Google's Roughtime implementation

**Security status:** Secure
NTS (RFC 8915) provides authenticated NTP via TLS 1.3 + AES-SIV-CMAC; Roughtime (RFC 9714) adds server accountability via Ed25519 signatures; unauthenticated NTP remains vulnerable to off-path time injection.

**Community acceptance:** Standard
NTPv4 (RFC 5905) is universal; NTS (RFC 8915) is an IETF standard adopted by Cloudflare and major Linux distributions; Roughtime (RFC 9714) published 2024; TrueTime is proprietary but influential.

---

## Oblivious DNS (ODoH) and Encrypted DNS Comparison

**Goal:** Prevent DNS resolvers from learning which domain names a client is looking up — hiding browsing intent from the recursive resolver — while also preventing eavesdropping by on-path network observers. Combines DNS-over-HTTPS/TLS transport encryption with oblivious relay architectures and cryptographic query/response padding.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DNS-over-TLS (DoT, RFC 7858)** | 2016 | TLS 1.2/1.3 | Encrypts DNS traffic from client to resolver; prevents on-path eavesdropping; resolver still learns client IP [[1]](https://www.rfc-editor.org/rfc/rfc7858) |
| **DNS-over-HTTPS (DoH, RFC 8484)** | 2018 | HTTPS / HTTP2 | DNS queries as HTTPS GET/POST; blends with HTTPS traffic on port 443; resolver learns client IP; deployed by Cloudflare 1.1.1.1, Google 8.8.8.8, Mozilla/Firefox [[1]](https://www.rfc-editor.org/rfc/rfc8484) |
| **Oblivious DNS-over-HTTPS (ODoH, RFC 9230)** | 2021 | HPKE + double-layer encryption | Client encrypts query with target resolver's public key using HPKE; sends to an oblivious proxy; proxy forwards to resolver without seeing plaintext query; resolver sees query but not client IP; proxy sees client IP but not query [[1]](https://www.rfc-editor.org/rfc/rfc9230) |
| **DNS-over-QUIC (DoQ, RFC 9250)** | 2022 | QUIC (TLS 1.3) | DNS over QUIC transport; 0-RTT for repeat resolvers; lower latency than DoT on lossy networks; resolver still learns client IP [[1]](https://www.rfc-editor.org/rfc/rfc9250) |
| **Oblivious DNS (ODNS, Schmitt et al.)** | 2019 | Symmetric + RSA hybrid | Client encrypts the queried name with a session key; encrypts session key with authoritative server's public key; stub resolver sees only encrypted name; first ODoH precursor [[1]](https://petsymposium.org/2019/files/papers/issue2/popets-2019-0028.pdf) |
| **Encrypted Client Hello (ECH) + DoH** | 2023 | HPKE + TLS 1.3 | Combines ODoH for name resolution privacy with ECH for SNI privacy in the subsequent TLS connection; end-to-end privacy for both the DNS lookup and the TLS handshake SNI [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-esni/) |

The privacy hierarchy from weakest to strongest: unencrypted DNS (on-path attacker and resolver both see everything) → DoT/DoH (on-path attacker sees encrypted traffic, resolver sees client IP and query) → ODoH (resolver sees query but not client IP; proxy sees client IP but not query — neither has both) → ODNS (resolver sees only encrypted query; stub resolver acts as semi-trusted proxy). ODoH's security rests on the assumption that the proxy and resolver do not collude — Cloudflare operates the resolver while Apple, Fastly, or third parties operate the proxy, enforcing organizational separation. The HPKE encryption (RFC 9180) of the query means the proxy is cryptographically prevented from learning the queried name, not merely policy-prevented. ECH addresses the complementary problem: even with ODoH, the TLS Server Name Indication (SNI) in the subsequent connection reveals the destination. ECH + ODoH together provide name privacy at both the DNS and TLS layers.

**State of the art:** DoH (default in Firefox, Chrome, Windows 11 / macOS 13+); ODoH (Cloudflare + Apple production deployment 2021); DoQ (AdGuard, Pi-hole support); ECH (Chrome 117+, Cloudflare production). Related to [Oblivious HTTP (OHTTP)](10-privacy-preserving-computation.md#oblivious-dns-odoh), [ECH](12-secure-communication-protocols.md#encrypted-client-hello-ech), and [HPKE](02-authenticated-structured-encryption.md#key-encapsulation-mechanism-kem-dem-paradigm).

**Production readiness:** Production
DoH default in Firefox, Chrome, Windows 11, macOS 13+; ODoH deployed by Cloudflare + Apple (2021); DoQ supported by AdGuard; ECH in Chrome 117+ and Cloudflare production.

**Implementations:**
- [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) ⭐ 13k — Go, supports DoH, DoT, ODoH, and DNSCrypt
- [cloudflare/odoh-go](https://github.com/cloudflare/odoh-go) ⭐ 146 — Go, Cloudflare's ODoH implementation
- [Unbound](https://github.com/NLnetLabs/unbound) ⭐ 4.4k — C, recursive DNS resolver with DoT and DoH support
- [coredns](https://github.com/coredns/coredns) ⭐ 13k — Go, DNS server with DoH/DoT plugins
- [AdGuard DNS](https://github.com/AdguardTeam/AdGuardDNS) ⭐ 918 — Go, DNS server with DoQ support

**Security status:** Secure
DoH/DoT/DoQ encrypt DNS traffic (TLS 1.3); ODoH (RFC 9230) provides HPKE-based query encryption + relay separation; ECH completes the privacy chain by hiding SNI. ODoH security requires non-collusion of proxy and resolver.

**Community acceptance:** Standard
DoT (RFC 7858), DoH (RFC 8484), ODoH (RFC 9230), DoQ (RFC 9250) are all IETF standards; deployed by Cloudflare, Google, Apple, Mozilla, and Microsoft; ECH standardization in progress.

---

## Proof of Unique Human (Worldcoin, Proof of Personhood)

**Goal:** Prove that a credential belongs to a unique biological human — without revealing the holder's identity. Prevents Sybil attacks (one person claiming many identities) in settings where per-person fairness matters: UBI distribution, one-person-one-vote, airdrop eligibility, rate-limiting AI services.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Worldcoin / World ID** | 2023 | Iris biometric + ZK semaphore | Custom IR camera ("Orb") captures iris codes; iris code stored on-device as a ZK commitment; semaphore ZK proof proves membership in the set of registered humans without revealing which one [[1]](https://whitepaper.worldcoin.org/) |
| **Proof of Humanity (PoH)** | 2021 | Video + social vouching + Kleros dispute | On-chain registry; applicant submits video + existing member vouches; disputes resolved by Kleros decentralized jury; no biometrics, Sybil resistance relies on social graph [[1]](https://proofofhumanity.id/) |
| **BrightID** | 2020 | Social graph analysis | Sybil resistance via graph algorithms on a social connection graph; no biometrics; estimates "unique human" by detecting community structure [[1]](https://brightid.org/) |
| **Idena (Flip-based PoP)** | 2019 | Turing test (image puzzle) | Simultaneous CAPTCHA-like flip ceremonies; solving requires human cognition; Sybil attack requires proportional human labor [[1]](https://idena.io/wp.pdf) |
| **ZK-biometric credentials (general)** | 2022 | Biometric commitment + SNARK | Biometric hash (face/iris) committed on-device; ZK proof that commitment is in the registry; selective disclosure of age/nationality without revealing identity [[1]](https://eprint.iacr.org/2022/1677) |

The core tension is **privacy vs. Sybil-resistance**: strong biometric-based systems (Worldcoin) provide high Sybil resistance but require collecting sensitive biometric data and trusting the hardware manufacturer's attestation that the Orb did not retain iris images. Social vouching systems (PoH, BrightID) avoid biometrics but are vulnerable to collusion. Idena's flip ceremonies require synchronized global participation. The Worldcoin approach uses **semaphore** — a ZK membership proof where the user proves knowledge of a secret that hashes to one of the registered iris commitments, without revealing which commitment. The iris code itself is never sent to any server after the Orb ceremony; only a commitment is recorded on-chain. The system provides **nullifier-based anonymity**: the same secret produces the same nullifier for a given context (preventing double-voting) but different nullifiers across contexts (preventing linkage).

**State of the art:** Worldcoin World ID v2 (2024, deployed in 35+ countries); PoH v2 (on Gnosis Chain). Related to [Semaphore / RLN](11-anonymity-credentials.md#semaphore-anonymous-group-signaling-rln), [Anonymous Credentials](11-anonymity-credentials.md#anonymous-credentials), and [ZK Proof Systems](04-zero-knowledge-proof-systems.md).

**Production readiness:** Experimental
Worldcoin World ID v2 deployed in 35+ countries (2024) but with ongoing regulatory scrutiny; PoH v2 on Gnosis Chain; BrightID and Idena operational but small-scale.

**Implementations:**
- [worldcoin/semaphore](https://github.com/worldcoin/semaphore-rs) ⭐ 187 — Rust, Worldcoin's ZK membership proof implementation
- [Proof of Humanity](https://github.com/Proof-Of-Humanity/proof-of-humanity-web) ⭐ 83 — JavaScript/Solidity, social vouching + Kleros dispute resolution
- [BrightID](https://github.com/BrightID/BrightID) ⭐ 244 — JavaScript, social graph-based Sybil resistance
- [Idena](https://github.com/idena-network/idena-go) ⭐ 153 — Go, flip-ceremony-based proof of personhood

**Security status:** Caution
ZK proofs (Semaphore) are cryptographically sound; biometric approaches (Worldcoin) require trusting Orb hardware attestation and raise privacy concerns; social vouching (PoH) is vulnerable to coordinated collusion.

**Community acceptance:** Controversial
Worldcoin faces regulatory investigations (Kenya ban, EU GDPR concerns); biometric data collection is contentious; PoH/BrightID have smaller but less controversial communities; fundamental tension between Sybil resistance and privacy remains unresolved.

---

## AUTOSAR SecOC — Secure Onboard Communication

**Goal:** Authenticate CAN/Ethernet messages between automotive ECUs using truncated CMAC plus a freshness counter, protecting in-vehicle networks against spoofing and replay without asymmetric crypto latency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SecOC (AUTOSAR R4.3+)** | 2015 | AES-128 CMAC, truncated | Fits CAN frame size budgets; mandatory under UNECE WP.29 R155 [[1]](https://www.autosar.org/fileadmin/standards/R24-11/FO/AUTOSAR_FO_PRS_SecOcProtocol.pdf) |

**State of the art:** Mandatory for new EU vehicle type approvals. Modern vehicles have 70-150 ECUs exchanging safety-critical signals over originally unauthenticated CAN buses. SecOC is the industry's standardized answer.

**Production readiness:** Production
Mandatory under UNECE WP.29 R155 for new EU vehicle type approvals; deployed by all major OEMs (BMW, Mercedes, VW, Toyota) in production vehicles since ~2020.

**Implementations:**
- [AUTOSAR Classic/Adaptive Platform](https://www.autosar.org/) — C/C++, reference platform specifications (proprietary implementations by Vector, ETAS, Elektrobit)

**Security status:** Caution
AES-128 CMAC is cryptographically secure; truncated MACs (due to CAN frame size constraints) reduce forgery resistance; freshness counter management is critical to prevent replay attacks.

**Community acceptance:** Standard
AUTOSAR is the de facto automotive software standard; UNECE WP.29 R155 makes cybersecurity (including SecOC) a regulatory requirement; adopted industry-wide.

---

## LKH — Logical Key Hierarchy for Secure Multicast

**Goal:** Manage session keys for large dynamic multicast groups by arranging members as leaves in a key tree, so adding/removing one member requires rekeying only O(log N) members.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LKH (Wong-Gouda-Lam)** | 1998 | Binary key tree | Optimal O(log N) rekeying; SIGCOMM 1998; underpins IETF MSEC and GDOI (RFC 3547) [[1]](https://dl.acm.org/doi/10.1145/285237.285261) |

**State of the art:** Underpins pay-TV, satellite content distribution, enterprise multicast (IPsec group VPN), and IPTV systems. Foundation for IoT group key management proposals.

**Production readiness:** Production
Deployed in pay-TV conditional access systems, satellite content distribution, enterprise IPsec group VPN (GDOI, RFC 3547), and IPTV systems.

**Implementations:**
- [Cisco GDOI (GET VPN)](https://www.cisco.com/c/en/us/products/security/group-encrypted-transport-vpn/index.html) — proprietary, LKH-based group key management for enterprise VPN
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C, IPsec implementation with group key management support
- Research implementations of LKH available in academic codebases.

**Security status:** Secure
O(log N) rekeying is information-theoretically optimal for binary key trees; security relies on the underlying symmetric cipher; forward and backward secrecy achieved via key tree updates on member join/leave.

**Community acceptance:** Standard
IETF MSEC working group standardized group key management (RFC 3547 GDOI, RFC 4046 GSAKMP); LKH is the foundational construction; deployed at scale in pay-TV and enterprise networks.

---

## IETF SUIT — Secure Firmware Update for IoT

**Goal:** Standardized CBOR-encoded signed manifest allowing constrained IoT devices to verify firmware update authenticity, integrity, and applicability before applying, using COSE as the crypto layer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SUIT Architecture (RFC 9019)** | 2022 | CBOR + COSE | Targets Class-1 devices (10 KiB RAM); anti-rollback counters; version checks [[1]](https://www.rfc-editor.org/rfc/rfc9019.html) |
| **SUIT Manifest (RFC 9124)** | 2022 | Signed manifest format | Incorporated into ARM TF, Zephyr RTOS; EU Cyber Resilience Act compliant [[1]](https://datatracker.ietf.org/doc/rfc9124/) |

**State of the art:** Before SUIT, every IoT vendor had a proprietary ad-hoc update scheme (most with poor crypto). Insecure OTA firmware is among the most exploited IoT attack vectors (Mirai botnet).

**Production readiness:** Production
Incorporated into ARM TF-M, Zephyr RTOS, and Nordic Semiconductor SDK; EU Cyber Resilience Act compliance pathway; IETF RFCs published (2022).

**Implementations:**
- [MCUboot](https://github.com/mcu-tools/mcuboot) ⭐ 1.8k — C, secure bootloader with SUIT manifest support for Zephyr and Mynewt
- [RIOT-OS SUIT](https://github.com/RIOT-OS/RIOT) ⭐ 5.7k — C, SUIT update support in RIOT IoT operating system
- [libcsuit](https://github.com/yuichitk/libcsuit) ⭐ 7 — C, SUIT manifest parser and COSE verification library

**Security status:** Secure
COSE-based signing provides strong authenticity and integrity; anti-rollback counters prevent version downgrade; manifest format allows pre-flight applicability checks before flashing.

**Community acceptance:** Standard
IETF RFCs 9019 and 9124 published; adopted by ARM, Nordic Semiconductor, and Zephyr; EU Cyber Resilience Act references standardized firmware update mechanisms.

---

## TESLA — Timed Efficient Stream Loss-Tolerant Authentication

**Goal:** Authenticate broadcast/multicast streams to many receivers using only symmetric crypto, by exploiting loose time synchronization to create a delayed key disclosure channel.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **TESLA (RFC 4082)** | 2002 | MAC + delayed key disclosure | Single transmitter authenticates to thousands of receivers with no per-receiver state [[1]](https://www.rfc-editor.org/rfc/rfc4082) |
| **Galileo OSNMA** | 2023 | TESLA for GNSS | European GNSS signal authentication; GPS Chimera follows same pattern [[1]](https://www.gsc-europa.eu/osnma) |

**State of the art:** Protocol of record for one-to-many authentication. Deployed in GNSS (Galileo OSNMA), vehicular V2X broadcast, and drone Remote-ID authentication.

**Production readiness:** Production
Deployed in Galileo OSNMA (2023), vehicular V2X broadcast authentication, and drone Remote-ID; RFC 4082 published 2005.

**Implementations:**
- [Galileo OSNMA receiver](https://www.gsc-europa.eu/osnma) — operational EU GNSS authentication using TESLA

**Security status:** Secure
Security relies on loose time synchronization and MAC integrity; delayed key disclosure is information-theoretically sound; requires receivers to buffer packets until key disclosure.

**Community acceptance:** Standard
IETF RFC 4082; deployed in Galileo OSNMA (EU standard); used in ETSI ITS (V2X) and drone Remote-ID; well-established protocol for broadcast authentication.

---

## Updatable Encryption (Key Rotation Protocols)

**Goal:** Allow a cloud server to re-encrypt stored ciphertexts from an old key to a new key using only a short update token, without ever decrypting the data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lehmann-Tackmann** | 2018 | CPA-secure UE | First formal model; EUROCRYPT 2018 [[1]](https://link.springer.com/chapter/10.1007/978-3-319-78372-7_22) |
| **Klooß-Lehmann-Rupp** | 2019 | CCA-secure, ciphertext-independent | First practically deployable UE with strong integrity; EUROCRYPT 2019 [[1]](https://link.springer.com/chapter/10.1007/978-3-030-17653-2_3) |

**State of the art:** Cryptographic basis for key rotation in cloud KMS (Google Cloud, AWS). Compliance requirement for PCI DSS, HIPAA, SOC 2 — avoids full data re-download for key rotation.

**Production readiness:** Mature
Cryptographic basis for key rotation in Google Cloud KMS, AWS KMS, and Azure Key Vault; formal models published at EUROCRYPT 2018-2019; production systems use related (but not identical) constructions.

**Implementations:**
- [Google Cloud KMS](https://cloud.google.com/kms/docs/key-rotation) — proprietary, key rotation with update tokens (inspired by UE)
- [AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html) — proprietary, automatic key rotation
- No widely maintained open-source UE library; research implementations accompany EUROCRYPT papers.

**Security status:** Secure
CCA-secure, ciphertext-independent UE (Kloos-Lehmann-Rupp 2019) provides strong integrity and confidentiality under key compromise; update tokens are short and do not reveal old or new keys.

**Community acceptance:** Emerging
Active research area (EUROCRYPT 2018-2019); cloud KMS providers implement related key rotation mechanisms; formal UE models gaining traction; no IETF/NIST standard for UE specifically.

---
