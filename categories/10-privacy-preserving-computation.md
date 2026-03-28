# Privacy-Preserving Computation

## Private Set Intersection (PSI)

**Goal:** Privacy-preserving intersection. Two parties compute the intersection of their private sets, learning only the intersection — nothing about non-matching elements. Used in contact discovery (Signal, Apple), private advertising measurement.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DH-based PSI** | 1986 | DDH | Simple commutative hash approach; not maliciously secure [[1]](https://link.springer.com/chapter/10.1007/978-3-662-10199-5_5) |
| **OPRF-based PSI** | 2019 | OPRF + hashing | State of the art; near-optimal communication [[1]](https://eprint.iacr.org/2016/799) |
| **Circuit PSI** | 2018 | Garbled circuits | Maliciously secure; outputs secret-shared intersection [[1]](https://eprint.iacr.org/2018/120) |
| **PSI-CA** | 2012 | Various | Cardinality only: learn size of intersection, not elements [[1]](https://eprint.iacr.org/2011/141) |
| **Multi-Party PSI (Kolesnikov et al.)** | 2017 | OPRF + OT | PSI for N>2 parties; star topology or circuit-based; used in Google Private Join and Compute [[1]](https://eprint.iacr.org/2017/799) |
| **Private Contact Discovery (Signal)** | 2023 | Unbalanced PSI + SGX | Find which phone contacts use Signal without revealing contacts; ~2 sec for 1024 contacts against billions [[1]](https://eprint.iacr.org/2023/758) |

**State of the art:** OPRF-based PSI (semi-honest), circuit PSI (malicious), multi-party PSI (N parties), private contact discovery (Signal production).

---

## Private Set Union (PSU)

**Goal:** Compute the union of private sets without revealing which elements belong to which party. Dual of [PSI](#private-set-intersection-psi) (intersection) — PSU reveals A ∪ B while hiding individual membership. Harder than PSI because the output is larger.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kolesnikov-Kumaresan-Rosulek-Trieu PSU** | 2019 | OPRF + OT | First efficient PSU with linear communication [[1]](https://eprint.iacr.org/2019/776) |
| **Jia-Sun-Zhou-Gu Scalable PSU** | 2024 | Additively HE | Stronger security; avoids OT-based leakage; scales to millions of items [[1]](https://eprint.iacr.org/2024/922) |

**State of the art:** AHE-based PSU (2024) for stronger security; OPRF-based for efficiency. Related to [PSI](#private-set-intersection-psi) and [OKVS](#oblivious-key-value-store-okvs).

---

## Private Set Difference / Set Operations

**Goal:** Compute set difference and symmetric difference privately. Beyond [PSI](#private-set-intersection-psi) (intersection) and [PSU](#private-set-union-psu) (union): compute A \ B (in A not B) or A △ B (in exactly one) without revealing other elements. Applications: deduplication, anomaly detection, auditing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kissner-Song Set Operations** | 2005 | Paillier + polynomials | First composable framework for union, intersection, difference, symmetric difference; CRYPTO 2005 [[1]](https://link.springer.com/chapter/10.1007/11535218_15) |
| **Multi-Party Set Difference** | 2005 | Threshold Paillier | Extension to N parties with malicious security [[1]](https://www.cs.cmu.edu/~leak/papers/set-tech-full.pdf) |

**State of the art:** Kissner-Song (CRYPTO 2005); set-difference components most overlooked. Complements [PSI](#private-set-intersection-psi) and [PSU](#private-set-union-psu).

---

## Oblivious RAM (ORAM)

**Goal:** Access pattern hiding. Access a remote encrypted store so that the server cannot tell which locations are being read or written — even across many accesses.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Goldreich-Ostrovsky ORAM** | 1996 | Hierarchical hash tables | Foundational; O(log³ n) overhead [[1]](https://dl.acm.org/doi/10.1145/233551.233553) |
| **Path ORAM** | 2013 | Binary tree | Simple, practical; O(log n) bandwidth [[1]](https://eprint.iacr.org/2013/280) |
| **Circuit ORAM** | 2015 | Circuit-friendly | Optimized for MPC; minimal circuit size [[1]](https://eprint.iacr.org/2014/672) |
| **Onion ORAM** | 2016 | Layered encryption | Constant bandwidth in amortized setting [[1]](https://eprint.iacr.org/2015/005) |

**State of the art:** Path ORAM (practical deployments), Circuit ORAM (MPC context).

---

## Private Information Retrieval (PIR)

**Goal:** Query privacy. A client retrieves an element from a database without the server learning which element was fetched.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IT-PIR (Chor et al.)** | 1995 | Information-theoretic | Requires 2+ non-colluding servers; optimal communication [[1]](https://dl.acm.org/doi/10.1145/293347.293350) |
| **Kushilevitz-Ostrovsky PIR** | 1997 | Quadratic residues | First single-server computational PIR [[1]](https://dl.acm.org/doi/10.1145/258533.258559) |
| **SealPIR** | 2018 | RLWE / BFV | Practical single-server PIR; ~1 ms/query [[1]](https://eprint.iacr.org/2017/1142) |
| **SimplePIR / DoublePIR** | 2023 | LWE | Fastest practical PIR; near-optimal [[1]](https://eprint.iacr.org/2022/949) |

**State of the art:** SimplePIR/DoublePIR (speed), IT-PIR (information-theoretic setting).

---

## Searchable Encryption (SSE / PEKS)

**Goal:** Confidential search. Search over encrypted data without decrypting it. A server executes keyword queries on ciphertexts and returns matching documents.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SSE (Song-Wagner-Perrig)** | 2000 | Symmetric, stream cipher | First practical SSE; sequential scan [[1]](https://ieeexplore.ieee.org/document/848445) |
| **PEKS (Boneh et al.)** | 2004 | Pairings | Public-key keyword search; anyone can generate trapdoors [[1]](https://eprint.iacr.org/2003/195) |
| **OXT** | 2013 | Symmetric + OT | Conjunctive queries; sublinear search time [[1]](https://eprint.iacr.org/2013/169) |
| **Dynamic SSE (Kamara-Papamanthou)** | 2013 | PRF + inverted index | Supports updates; leakage-optimal [[1]](https://eprint.iacr.org/2012/563) |
| **GraphSE² (Encrypted Graph Search)** | 2019 | SSE + graph | SSE for social graph pattern matching; Facebook-scale queries on million-user encrypted graphs [[1]](https://arxiv.org/abs/1905.04501) |

**State of the art:** Dynamic SSE (updatable datasets), GraphSE² (encrypted graph queries).

---

## Oblivious PRF (OPRF)

**Goal:** Privacy. A client and server jointly evaluate a PRF on the client's input using the server's key — the client learns only the output, the server learns nothing. Provides input confidentiality + unlinkability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **2HashDH OPRF** | 2009 | DLEQ / EC | Simple DH-based; basis of most deployed OPRFs [[1]](https://eprint.iacr.org/2014/650) |
| **VOPRF** | 2021 | EC + DLEQ proof | Verifiable: client can check server evaluated correctly [[1]](https://www.rfc-editor.org/rfc/rfc9497) |
| **POPRF** | 2021 | EC + tweak | Partially-oblivious: server adds a public tweak to evaluation [[1]](https://www.rfc-editor.org/rfc/rfc9497) |

**State of the art:** VOPRF (RFC 9497) with Ristretto255 — used in Privacy Pass, OPAQUE password protocol, PSI.

---

## Oblivious Key-Value Store (OKVS)

**Goal:** Efficient private encoding of key-value maps. Encode a set of (key, value) pairs into a compact structure where querying a key returns the value, but querying any other key returns random noise. Core data structure behind state-of-the-art PSI and circuit-PSI protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garbled Bloom Filter (GBF)** | 2014 | XOR-based | Encode key-value pairs in Bloom filter structure; see [Accumulators](#accumulators) [[1]](https://doi.org/10.1145/2660267.2660323) |
| **PaXoS (Probe-and-XOR of Strings)** | 2020 | Linear system | Solve linear system over GF(2); compact encoding, fast decode [[1]](https://eprint.iacr.org/2020/193) |
| **OKVS (Garimella et al.)** | 2021 | Banded matrix | Near-optimal rate (encoding ≈ n items); backbone of fast PSI [[1]](https://eprint.iacr.org/2021/883) |
| **RB-OKVS (Random Band)** | 2022 | Banded linear algebra | Improved; O(n) encode/decode; used in fastest PSI implementations [[1]](https://eprint.iacr.org/2022/320) |

**State of the art:** RB-OKVS (2022); enables PSI on millions of items in seconds. Key building block for [PSI](#private-set-intersection-psi) and [Silent OT](#silent-ot--pseudorandom-correlation-generators-pcg).

---

## Oblivious Sorting / Oblivious Data Structures

**Goal:** Sort or access data structures without revealing access patterns. Even the sorted order or query pattern is hidden. Critical building block for ORAM, private databases, and MPC on large datasets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bitonic Sort (Batcher)** | 1968 | Comparison network | O(n log² n) oblivious sort; data-independent comparison pattern [[1]](https://dl.acm.org/doi/10.1145/1468075.1468121) |
| **AKS Sorting Network** | 1983 | Expander graphs | O(n log n) optimal oblivious sort; impractical constants [[1]](https://dl.acm.org/doi/10.1145/800061.808726) |
| **Oblivious Bucket Sort (Asharov et al.)** | 2022 | Hashing + padding | Practical O(n log n) with small constants; MPC-friendly [[1]](https://eprint.iacr.org/2022/1243) |
| **Oblivious Priority Queue** | 2014 | Path ORAM + PQ | Oblivious insertions and extract-min; for graph algorithms on encrypted data [[1]](https://eprint.iacr.org/2014/344) |
| **Secure Sorting via FSS (Agarwal et al.)** | 2024 | Function secret sharing | 2PC/3PC sorting/selection (top-k, median) with optimal online communication; CCS 2024 [[1]](https://dl.acm.org/doi/10.1145/3658644.3690359) |

**State of the art:** Oblivious Bucket Sort (practical MPC), Bitonic Sort (simplest, widely implemented), FSS-based sorting (2024, information-theoretic).

---

## Private Function Evaluation (PFE)

**Goal:** Hide the function. In standard MPC, the computed function is public. In PFE, even the function is private — one party's input is the circuit/program itself. Used when the algorithm is proprietary (trade secret evaluation, private credit scoring).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Universal Circuits (Valiant)** | 1976 | Circuit topology | Simulate any circuit of size n with O(n log n) universal circuit [[1]](https://dl.acm.org/doi/10.1145/800113.803649) |
| **PFE via Universal Circuit + GC** | 2008 | Garbled universal circuit | Embed function into UC, then garble; see [Garbled Circuits](#garbled-circuits-expanded) [[1]](https://eprint.iacr.org/2008/491) |
| **PFE from OT (Mohassel-Sadeghian)** | 2013 | OT + permutation network | More efficient: use extended OT to evaluate switching network [[1]](https://eprint.iacr.org/2013/239) |

**State of the art:** OT-based PFE (practical), Universal Circuits (theoretical foundation).

---

## Oblivious Message Retrieval (OMR)

**Goal:** Private message delivery. Messages are posted to a public bulletin board; a recipient can detect and download their messages without the server learning which messages belong to whom. Like PIR but optimized for the "mailbox" setting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Liu-Tromer OMR** | 2021 | FHE (BFV) | First OMR; server runs FHE detection on behalf of recipient [[1]](https://eprint.iacr.org/2021/1256) |
| **Cohn-Gordon et al. OMR** | 2023 | PIR + FHE | Improved; practical for millions of messages, ~5 sec server time [[1]](https://eprint.iacr.org/2022/1528) |
| **FrodoPIR-based OMR** | 2023 | Lattice PIR | Lightweight variant using offline preprocessing [[1]](https://eprint.iacr.org/2022/981) |

**State of the art:** FHE-based OMR (Liu-Tromer 2021+); enables private messaging without metadata leakage. Extends [PIR](#private-information-retrieval-pir) to the messaging domain.

---

## Oblivious DNS (ODoH)

**Goal:** DNS privacy without trusting any single party. Client encrypts DNS query with HPKE to the resolver; a proxy forwards it without decrypting. The proxy sees the client but not the query; the resolver sees the query but not the client. Cryptographic separation of identity from intent.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Oblivious DoH (ODoH)** | 2021 | HPKE + proxy | IETF RFC 9230; deployed by Cloudflare + Apple; proxy-based privacy [[1]](https://www.rfc-editor.org/rfc/rfc9230) |
| **μODNS (Mutualized Oblivious DNS)** | 2021 | Multi-relay | Multiple randomly selected relays; defeats single-relay collusion [[1]](https://arxiv.org/abs/2104.13785) |
| **OHTTP (Oblivious HTTP)** | 2024 | HPKE + relay | **RFC 9458**; generalizes ODoH to arbitrary HTTP requests; client identity hidden from server [[1]](https://www.ietf.org/rfc/rfc9458.html) |

**State of the art:** ODoH (RFC 9230) for DNS; OHTTP (RFC 9458) for general HTTP; deployed in Apple iCloud Private Relay, Cloudflare. Related to [Onion Routing](#onion-routing).

---

## Fuzzy Private Set Intersection (FPSI)

**Goal:** Find approximate matches between private sets. Standard PSI finds exact matches; FPSI finds elements that are "close" (edit distance, Hamming distance, Euclidean distance). Enables privacy-preserving record linkage, biometric matching, and DNA comparison without exact identifiers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fuzzy PSI from OT (Freedman et al.)** | 2016 | OT + locality-sensitive hash | First FPSI; LSH reduces fuzzy matching to multiple exact PSI instances [[1]](https://eprint.iacr.org/2016/799) |
| **FPSI from VOLE** | 2025 | VOLE + fuzzy matching | Efficient FPSI using vector OLE; sublinear communication for approximate matches [[1]](https://eprint.iacr.org/2025/911) |

**State of the art:** VOLE-based FPSI (2025); combines [PSI](#private-set-intersection-psi), [OLE/VOLE](#oblivious-linear-evaluation-ole--vole), and [PPRL](#privacy-preserving-record-linkage-pprl).

---

## Private Proximity Testing

**Goal:** Check if two users are near each other without revealing their exact locations. Alice and Bob learn only whether they are within distance d — nothing else about each other's position. Enables contact tracing, friend-finding, dating apps.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Narayanan-Thiagarajan-Lakhani-Hamburg-Boneh** | 2011 | HE + grid quantization | Location quantized to grid cells; encrypted comparison reveals only "same cell" [[1]](https://crypto.stanford.edu/~dabo/pubs/papers/locpriv.pdf) |
| **Proximity Testing via DH** | 2014 | DDH | Two-party protocol: shared-grid approach with DH-based equality test [[1]](https://eprint.iacr.org/2014/078) |
| **Rogue-Resistant Proximity Testing** | 2020 | ZK + commitments | Resist malicious users lying about location [[1]](https://eprint.iacr.org/2020/857) |

**State of the art:** Grid-based DH proximity testing; used in COVID exposure notification research. Combines [HE](#homomorphic-encryption-he) or [PSI](#private-set-intersection-psi) techniques.

---

## Private Heavy Hitters / Frequency Estimation

**Goal:** Discover popular items from distributed private data. Many clients each hold a private value; the server wants to find the most frequent values (heavy hitters) or estimate value frequencies — without learning any individual client's data. Core primitive for telemetry, analytics, and spam detection.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RAPPOR (Google)** | 2014 | Local DP + Bloom filters | First deployed private frequency estimation; Chrome telemetry [[1]](https://doi.org/10.1145/2660267.2660348) |
| **Poplar (Boneh et al.)** | 2021 | Incremental DPF | Private heavy hitters via distributed point functions; no public-key crypto needed [[1]](https://arxiv.org/abs/2012.14884) |
| **Prio3 + VDAF (IETF)** | 2023 | Secret sharing + ZK | Standardized (draft-irtf-cfrg-vdaf); used in Mozilla/Apple telemetry; extends [Prio/VDAF](#prio--vdaf-privacy-preserving-aggregation) [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-vdaf/) |
| **Mastic** | 2024 | IDPF + attribute filtering | Extends Poplar to weighted, attribute-filtered metrics under two-server MPC; PoPETS 2025 [[1]](https://eprint.iacr.org/2024/221) |

**State of the art:** Poplar/Prio3 for heavy hitters, Mastic (2025, weighted heavy hitters); RAPPOR for local DP. Related to [Prio/VDAF](#prio--vdaf-privacy-preserving-aggregation) and [Differential Privacy](#differential-privacy).

---

## Private Stream Aggregation (PSA)

**Goal:** Aggregate time-series data from many users without seeing individual values. Each user encrypts their data point; the aggregator computes the sum (or polynomial function) of all values without decrypting any individual contribution. Lighter than FHE/MPC — designed for smart metering, federated analytics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shi-Chan-Rieffel-Chow-Song PSA** | 2011 | DLP + noise | First PSA; aggregator learns only noisy sum; differential privacy built in [[1]](https://eprint.iacr.org/2010/612) |
| **DIPSAUCE (Trusted-Setup-Free PSA)** | 2023 | LWE | No trusted authority for key generation; fully decentralized setup [[1]](https://eprint.iacr.org/2023/214) |
| **PPSA (Polynomial PSA)** | 2024 | Lattice + DP | Extends PSA to arbitrary polynomial functions over streams; 138x speedup over prior work [[1]](https://eprint.iacr.org/2024/1460) |

**State of the art:** PPSA (2024) for polynomial aggregation; DIPSAUCE for trustless setup. Distinct from [SecAgg](#secure-aggregation-secagg) (one-shot) and [HE](#homomorphic-encryption-he) (general computation) by focusing on lightweight streaming aggregation.

---

## Privacy-Preserving Record Linkage (PPRL)

**Goal:** Link records across databases (hospitals, registries) referring to the same person — without revealing any personal data to the other party. Match on fuzzy identifiers (name variants, typos) using MPC/PSI techniques. Critical for medical research and census.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bloom Filter PPRL (Schnell et al.)** | 2009 | Bloom filters + Dice coeff. | First practical PPRL; encode n-grams of names in Bloom filters; compare similarity [[1]](https://doi.org/10.1186/1472-6947-9-41) |
| **MainSEL** | 2022 | ABY MPC + Bloom filters | Production MPC system; links against 10K records in <4 sec; deployed in German hospitals [[1]](https://academic.oup.com/bioinformatics/article/38/6/1657/5900257) |
| **Fuzzy PSI for PPRL** | 2025 | VOLE + fuzzy matching | Extension of [PSI](#private-set-intersection-psi) to approximate/fuzzy matching for record linkage [[1]](https://eprint.iacr.org/2025/911) |

**State of the art:** MainSEL (deployed); Fuzzy PSI from VOLE (2025). Combines [PSI](#private-set-intersection-psi), [MPC](#multi-party-computation-mpc), and approximate matching.

---

## Differential Privacy

**Goal:** Quantifiable privacy. Add calibrated noise to query results so that the presence or absence of any single individual's data cannot be distinguished. Mathematical guarantee, composable. Used in census data, Apple/Google telemetry.

| Mechanism | Year | Basis | Note |
|-----------|------|-------|------|
| **Laplace Mechanism** | 2006 | Calibrated Laplace noise | First DP mechanism; ε-differential privacy [[1]](https://link.springer.com/chapter/10.1007/11681878_14) |
| **Gaussian Mechanism** | 2006 | Gaussian noise | (ε,δ)-DP; better for high-dimensional data [[1]](https://link.springer.com/chapter/10.1007/11681878_14) |
| **Local DP (RAPPOR)** | 2014 | Randomized response | Each client randomizes locally; no trusted server needed; Google Chrome [[1]](https://arxiv.org/abs/1407.6981) |
| **Rényi / zCDP** | 2016 | Rényi divergence | Tighter composition; concentrated DP [[1]](https://arxiv.org/abs/1605.02065) |

**State of the art:** zCDP (tight composition), Local DP (Apple, Google deployment), DP-SGD (federated ML).

---

## Prio / VDAF (Privacy-Preserving Aggregation)

**Goal:** Verifiable private aggregation. Clients secret-share their data across multiple servers; servers jointly compute the aggregate and can verify that each client's input is well-formed — without learning individual inputs. Used in privacy-preserving telemetry.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Prio** | 2017 | Secret sharing + SNIPs | First practical system; used in Firefox, ISRG [[1]](https://crypto.stanford.edu/prio/paper.pdf) |
| **Prio3 / VDAF** | 2023 | IETF DAP protocol | Standardized VDAF (RFC 9709-area); FLP + secret sharing [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-vdaf/) |
| **Poplar / Prio+** | 2021 | Heavy hitters + IDPF | Find popular strings privately; Mozilla/Apple telemetry [[1]](https://eprint.iacr.org/2021/017) |
| **IPA (Interoperable Private Attribution)** | 2023 | 3-party MPC + blinding | W3C PATCG protocol for privacy-preserving ad attribution measurement without user tracking [[1]](https://eprint.iacr.org/2023/437) |

**State of the art:** Prio3/VDAF (IETF standard), Poplar (heavy-hitter queries in Chrome, Firefox), IPA (W3C ad measurement).

---

## Sealed-Bid Auction Protocols

**Goal:** Private bidding. Bidders submit encrypted bids; the protocol determines the winner (and optionally the clearing price) without revealing losing bids. Prevents bid sniping, collusion, and underbidding.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brandt Sealed-Bid Auction** | 2002 | Homomorphic enc + ZK | First practical sealed-bid auction; Vickrey (second-price) via MPC [[1]](https://doi.org/10.1007/3-540-36563-X_5) |
| **Lipmaa-Asokan-Niemi** | 2002 | Paillier + range proofs | Efficient first-price sealed-bid auction; additive homomorphic [[1]](https://doi.org/10.1007/3-540-36563-X_4) |
| **Bogetoft et al. (Danish Sugar Beet Auction)** | 2009 | MPC (Shamir SS) | First real-world MPC auction; 1200+ farmers, Danish sugar beet contracts [[1]](https://doi.org/10.1007/978-3-642-03549-4_19) |
| **MEV Auction / Fair Ordering** | 2023 | Threshold encryption | Transaction ordering auctions to prevent MEV extraction; see [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering) [[1]](https://eprint.iacr.org/2023/1063) |

**State of the art:** MPC-based auctions for high-value settings; threshold encryption auctions for blockchain MEV. Combines [MPC](#multi-party-computation-mpc), [HE](#homomorphic-encryption-he), and [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Oblivious Polynomial Evaluation (OPE)

**Goal:** Private function evaluation for polynomials. Sender holds a polynomial P(x) of degree d; receiver holds a point x₀. Receiver learns P(x₀) and nothing else; sender learns nothing about x₀. Not to be confused with order-preserving encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas OPE** | 1999 | OT + polynomial | First efficient OPE from OT; sender's polynomial stays hidden [[1]](https://doi.org/10.1007/3-540-48405-1_8) |
| **OPE from Homomorphic Encryption** | 2006 | Paillier | Evaluate encrypted polynomial; additive HE suffices for poly eval [[1]](https://doi.org/10.1007/11681878_14) |
| **Batch OPE (Ghosh-Nilges)** | 2021 | VOLE | Batch evaluation of many points; amortized from VOLE [[1]](https://eprint.iacr.org/2021/1254) |

**State of the art:** VOLE-based batch OPE (2021); building block for [PSI](#private-set-intersection-psi), [OPRF](#oblivious-prf-oprf) constructions, and private equality testing. See [OLE/VOLE](#oblivious-linear-evaluation-ole--vole).

---

## Fuzzy Message Detection (FMD)

**Goal:** Detect your messages with tunable false positives. A server tests encrypted messages against your detection key — matches include your messages plus a controlled rate of false positives (cover traffic). Privacy degrades gracefully: more false positives = more privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Beck-Len-Miers-Green FMD** | 2021 | DDH / pairings | First FMD; tunable false-positive rate p via multi-key detection [[1]](https://eprint.iacr.org/2021/089) |
| **Multi-Server FMD** | 2025 | Distributed detection | Multiple servers hold detection key shares; threshold detection [[1]](https://eprint.iacr.org/2025/2072) |

**State of the art:** FMD (2021) for privacy-preserving message routing; extends [OMR](#oblivious-message-retrieval-omr) and [PIR](#private-information-retrieval-pir) with tunable privacy/bandwidth tradeoff. Proposed for Zcash.

---

## Graph Encryption

**Goal:** Outsource a graph database to an untrusted server and query it privately. The server evaluates encrypted graph queries (shortest path, subgraph matching, neighbor queries) without seeing the graph structure or query. Extends [Searchable Encryption](#searchable-encryption-sse--peks) to graph-structured data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Kamara Structured Encryption** | 2010 | Symmetric encryption | General framework for encrypting data structures (graphs, matrices) with controlled leakage [[1]](https://eprint.iacr.org/2010/351) |
| **Ghosh-Kamara-Tamassia GES** | 2021 | Graph encryption | Graph encryption for shortest path queries; sublinear query time [[1]](https://eprint.iacr.org/2021/865) |
| **PathGES** | 2024 | GES + optimization | Efficient single-pair shortest path on encrypted graphs; logarithmic storage overhead [[1]](https://eprint.iacr.org/2024/845) |

**State of the art:** PathGES (2024); extends [SSE](#searchable-encryption-sse--peks) to relational/graph queries. Active area for encrypted databases.

---

## Oblivious Automata / Branching Program Evaluation

**Goal:** Private pattern matching on private data. One party holds a private automaton (DFA, regex, decision tree); the other holds a private input string. They jointly evaluate whether the input is accepted — without revealing the automaton's structure or the input content. Applications: private virus scanning, DNA matching, regulatory compliance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Troncoso-Pastoriza et al. Oblivious DFA** | 2007 | Garbled circuits | First practical oblivious DFA evaluation; private DNA searching; CCS 2007 [[1]](https://dl.acm.org/doi/10.1145/1315245.1315309) |
| **Ishai-Paskin Oblivious Branching Programs** | 2007 | HE + branching programs | Evaluate branching programs on encrypted data; output independent of program width; TCC 2007 [[1]](https://link.springer.com/chapter/10.1007/978-3-540-70936-7_31) |
| **Mohassel et al. Efficient Oblivious DFA** | 2012 | OT + garbled circuits | Optimized; O(n·|Q|) communication for DFA with |Q| states on length-n string [[1]](https://eprint.iacr.org/2011/434) |

**State of the art:** Mohassel et al. (2012) for practical DFA; Ishai-Paskin for branching programs. Related to [Garbled Circuits](#garbled-circuits-expanded) and [PFE](#private-function-evaluation-pfe).

---

## Oblivious SQL / Encrypted Database Joins

**Goal:** Execute SQL operations on encrypted data without revealing queries or data to the server. Beyond keyword [SSE](#searchable-encryption-sse--peks): support joins, aggregations, GROUP BY, and range queries on fully encrypted relational databases while hiding access patterns.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CryptDB (Popa et al.)** | 2011 | Onion encryption layers | Layered encryption (RND→DET→OPE→HOM); peel layers as needed for SQL ops; SOSP 2011 [[1]](https://dl.acm.org/doi/10.1145/2043556.2043566) |
| **ObliDB (Eskandarian-Boneh)** | 2019 | ORAM + oblivious ops | Full oblivious query processing hiding access patterns for arbitrary SQL; VLDB [[1]](https://dl.acm.org/doi/10.14778/3364324.3364331) |
| **Opaque (Zheng-Dave-Beekman-Popa-Gonzalez-Stoica)** | 2017 | SGX + oblivious operators | Hardware-assisted encrypted SQL with oblivious operators; Spark integration [[1]](https://people.eecs.berkeley.edu/~wzheng/opaque.pdf) |

**State of the art:** ObliDB (2019) for full obliviousness; CryptDB for practical deployment; Opaque for hardware-assisted. Extends [ORAM](#oblivious-ram-oram), [SSE](#searchable-encryption-sse--peks), and [Graph Encryption](#graph-encryption).

---

## Conditional Disclosure of Secrets (CDS)

**Goal:** Predicate-gated secret release. Two parties each hold an input (x, y) and a referee holds a secret s. The secret s is revealed if and only if f(x, y) = 1 — with minimal communication. A fundamental building block for more complex protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gertner-Ishai-Kushilevitz-Malkin CDS** | 2000 | Secret sharing | First CDS formalization; connections to secret sharing and OT [[1]](https://doi.org/10.1007/3-540-44598-6_3) |
| **CDS for General Predicates** | 2014 | Branching programs | CDS for any predicate computable by branching programs [[1]](https://eprint.iacr.org/2014/213) |
| **Attribute-Based CDS** | 2017 | LWE / pairings | CDS with policies on attributes; connects to ABE [[1]](https://eprint.iacr.org/2017/614) |
| **CDS with Reusable Setup** | 2020 | DDH | Amortized: one setup, many CDS instances [[1]](https://eprint.iacr.org/2020/431) |

**State of the art:** CDS from standard assumptions (DDH/LWE); building block for [PSI](#private-set-intersection-psi), [OT extension](#oblivious-transfer-ot), and [Garbled Circuits](#garbled-circuits-expanded).

---
