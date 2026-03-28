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
