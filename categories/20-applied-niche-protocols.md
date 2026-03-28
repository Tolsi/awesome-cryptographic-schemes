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

## MarkPledge: Cast-as-Intended Verifiable Voting

**Goal:** Give a voter immediate, human-verifiable assurance that the voting terminal encrypted the intended candidate — without requiring the voter to trust any software or hardware and without leaving a usable receipt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **MarkPledge (Neff)** | 2004 | ZK proof + voter challenge | Voter issues a random challenge; terminal produces a short "pledge string" (4–5 chars) proving correct encryption; voter compares strings [[1]](https://www.usenix.org/legacy/events/evt06/tech/full_papers/adida/adida.pdf) |
| **MarkPledge2 / Ballot Casting Assurance (Adida-Neff)** | 2006 | ZK + simulated proofs | All candidates get a proof transcript — one real, rest simulated; coercer cannot tell which was genuine; first covert-channel-resistant, receipt-free cast-as-intended scheme usable without trusted hardware [[1]](https://eprint.iacr.org/2008/207) |
| **MarkPledge3 (MP3)** | 2009 | Optimized ZK | Most efficient MarkPledge variant; shorter ballot; statistical soundness of 1 − 2⁻²⁰ to 1 − 2⁻³⁰ [[1]](https://www.usenix.org/legacy/events/evtwote09/tech/full_papers/adida-casting.pdf) |

The key insight is that the terminal can prove correct encryption by running a ZK proof where the voter supplies the challenge (so the terminal cannot pre-compute a cheating response). Because all candidates receive a proof transcript — one genuinely verified, the rest simulated — a coercer holding the voter's receipt cannot determine which candidate was actually chosen, eliminating the covert channel problem that plagued earlier cast-as-intended schemes. The voter performs only short-string comparison; no cryptographic computation is needed on the voter's side.

**State of the art:** MarkPledge2/MP3 remain the reference design for cast-as-intended verifiability in polling-place systems. The technique is orthogonal to the counted-as-cast layer provided by mixnets or homomorphic tallying; both layers must be combined for full E2E verifiability. Compare [Scantegrity II](#scantegrity-ii) (invisible-ink confirmation codes) and [STAR-Vote](#star-vote) (Benaloh challenge for the same cast-as-intended property).

---

## Wombat Voting System

**Goal:** End-to-end verifiable voting that retains a physical paper trail. Voters mark a paper ballot that is scanned and encrypted on-site; a verifiable mixnet proves that the published encrypted ballots correctly decrypt to the announced tally, while the paper originals allow a conventional hand-recount as an independent check.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Wombat v1** | 2011 | Verificatum re-encryption mixnet | First deployment; student council election at IDC Herzliya (~2 000 voters); dual paper + cryptographic audit [[1]](https://wombat.factcenter.org/) |
| **Wombat v2 / Ben-Nun et al.** | 2012 | Verificatum (Wikström TW mixnet) + paper ballot | Full academic description; Israeli Meretz party primary; paper ballots scanned, encrypted, shuffled via Verificatum; shuffle proven with Wikström's universally verifiable mixnet [[1]](https://dl.gi.de/items/2a8596f9-3105-487b-8336-67fab31d6f53) |

The system's design principle is "dual-mode auditability": the paper ballots allow a traditional recount, while the cryptographic layer independently proves the electronic tally is correct. The underlying mixnet is Verificatum, which produces a zero-knowledge proof of correct shuffle verifiable by any third party. A voter who suspects their ballot was mis-scanned can demand a manual check of the paper original without undermining the cryptographic audit of all other ballots.

**State of the art:** Wombat is one of the few E2E verifiable systems actually deployed in binding political elections (Meretz primary, Israel, 2012). Its "paper + cryptographic" dual-channel design influenced subsequent hybrid systems. The Verificatum mixnet it relies on is also used in the Swiss Post system. Compare [Prêt à Voter](#prêt-à-voter) (randomized candidate order on paper) and [Scantegrity II](#scantegrity-ii) (invisible-ink codes on optical scan).

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

**State of the art:** HE-based sealed-bid auctions (deployed in procurement and spectrum auctions); MPC-based VCG for settings requiring no trusted auctioneer. Related to [Sealed-Bid Auctions (ORAM/PIR based)](categories/10-privacy-preserving-computation.md#sealed-bid-auctions) and [MPC](#multi-party-computation).

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

**State of the art:** UWB-based distance bounding (Apple CarKey, IEEE 802.15.4z) for automotive and access control; ISO/IEC 23741 for standardization. See [FIDO2/WebAuthn](categories/12-secure-communication-protocols.md#totpfido2webauthn) for proximity authentication and [TEE Attestation](categories/14-applied-infrastructure-pki.md#tee-remote-attestation) for hardware-backed presence claims.

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

**State of the art:** v3 hidden services (mandatory since 2021); SecureDrop, Facebook's facebookwkhpilnemxj.onion, and numerous whistleblowing platforms use v3 .onion addresses. See [Onion Routing / Tor](categories/11-anonymity-credentials.md#mixnets--onion-routing) for the underlying anonymity layer.

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

**State of the art:** Signal Sealed Sender v2 (production, ~2022); OMR (research, 2022–present). Related to [PIR](categories/10-privacy-preserving-computation.md#private-information-retrieval-pir), [Double Ratchet](categories/12-secure-communication-protocols.md#double-ratchet--signal-protocol), and [Oblivious Message Retrieval](categories/10-privacy-preserving-computation.md#oblivious-message-retrieval-omr).

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

**State of the art:** Argon2id (RFC 9106, recommended by OWASP); yescrypt (Linux default); Equihash (Zcash). Extends [Client Puzzles / Proof of Effort](#client-puzzles--proof-of-effort) and [PoW/PoSpace](categories/13-blockchain-distributed-ledger.md#proof-of-work-pow--proof-of-space).

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

**State of the art:** Sigstore/cosign (default for Kubernetes/CNCF ecosystem); npm provenance (default for new npm publishes); TUF (PyPI, Rust crates). See [Sigstore / Certificate Transparency](categories/14-applied-infrastructure-pki.md#sigstore-rekor--software-signing-transparency) and [C2PA/SLSA](categories/14-applied-infrastructure-pki.md#c2pacai-content-provenance--slsa) for related entries in category 14.

---
