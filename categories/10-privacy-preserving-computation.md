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

## Frequency-Smoothing Oblivious Datastores (PANCAKE / Waffle)

**Goal:** Hide access patterns for key-value stores with practical overhead. Full ORAM protects against arbitrary adversaries but incurs high bandwidth overhead. When the adversary is a passive persistent observer (no query injection), frequency smoothing transforms skewed plaintext access distributions into uniform encrypted access distributions — achieving orders-of-magnitude better throughput than Path ORAM. PANCAKE requires a known access distribution; Waffle extends this to unknown, adaptive distributions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PANCAKE (Grubbs et al.)** | 2020 | Frequency smoothing + encrypted key-value store | First system for passive-persistent-adversary access-pattern hiding; 229× better throughput than non-recursive Path ORAM; within 3–6× of insecure baselines; USENIX Security 2020 Distinguished Paper [[1]](https://eprint.iacr.org/2020/1501) |
| **Waffle (Maiyya et al.)** | 2024 | Online frequency smoothing + adaptive batching | Extends PANCAKE to unknown/changing access distributions; no prior knowledge of query distribution needed; 45–57% faster than PANCAKE; 102× faster than TaoStore ORAM; SIGMOD 2024 [[1]](https://eprint.iacr.org/2023/1285) |

**State of the art:** Waffle (SIGMOD 2024) for adaptive settings; PANCAKE (USENIX Sec 2020) when the access distribution is known. Both sit between insecure key-value stores and full [ORAM](#oblivious-ram-oram) in the security/performance tradeoff space. The weaker threat model (no query-injection adversary) is appropriate for many cloud storage deployments.

---

## Private Information Retrieval (PIR)

**Goal:** Query privacy. A client retrieves an element from a database without the server learning which element was fetched.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IT-PIR (Chor et al.)** | 1995 | Information-theoretic | Requires 2+ non-colluding servers; optimal communication [[1]](https://dl.acm.org/doi/10.1145/293347.293350) |
| **Kushilevitz-Ostrovsky PIR** | 1997 | Quadratic residues | First single-server computational PIR [[1]](https://dl.acm.org/doi/10.1145/258533.258559) |
| **SealPIR** | 2018 | RLWE / BFV | Practical single-server PIR; ~1 ms/query [[1]](https://eprint.iacr.org/2017/1142) |
| **SimplePIR / DoublePIR** | 2023 | LWE | Fastest practical PIR; near-optimal [[1]](https://eprint.iacr.org/2022/949) |
| **FrodoPIR** | 2023 | Plain LWE | Single-server; client-independent offline phase; ~1 s per query on 1M×1KB DB; ePrint 2022/981; PoPETS 2023 [[1]](https://eprint.iacr.org/2022/981) |
| **Checklist** | 2021 | 2-server; offline/online hints | Sublinear server time per query via client-stored hints; first system for private Safe-Browsing lookups; 6.7× faster than prior 2-server PIR; USENIX Sec 2021 [[1]](https://eprint.iacr.org/2021/345) |

**State of the art:** SimplePIR/DoublePIR (speed), Spiral (throughput, see [Advanced Single-Server PIR](#advanced-single-server-pir-onionpir--spiral)), FrodoPIR (scalable single-server with offline preprocessing), Checklist (sublinear server time with client hints), IT-PIR (information-theoretic setting).

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

## Labeled PSI and Private Intersection-Sum (PSI-Sum)

**Goal:** PSI with associated payloads. Beyond finding matching elements, the receiver also learns a value (label) associated with each matched element, or only the sum of those values — all without the sender learning which elements matched. Used in ad-conversion measurement, fraud detection, and medical record linkage.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Private Intersection-Sum (Ion et al.)** | 2020 | Commutative encryption + additively HE | Each sender element carries an integer value; receiver learns intersection cardinality and sum of values but not individual matches; deployed in Google ad measurement [[1]](https://eprint.iacr.org/2019/723) |
| **Two-Sided Malicious PSI-Sum (Ghosh-Lepoint)** | 2021 | Homomorphic encryption + ZK | Maliciously secure PSI-Sum without semi-honest assumptions [[1]](https://eprint.iacr.org/2020/385) |
| **Labeled PSI from FHE (Chen et al.)** | 2021 | BFV FHE + OPRF | Unbalanced labeled PSI: client with small set retrieves values associated with matching elements from large server set; O(√|X|) HE multiplications; 85% communication reduction vs. prior work; CCS 2021 [[1]](https://eprint.iacr.org/2021/1116) |
| **Circuit-PSI with Linear Complexity (Chandran et al.)** | 2022 | OPPRF + garbled circuits | Compute arbitrary function over intersection items in MPC; linear communication via relaxed batch OPPRF [[1]](https://eprint.iacr.org/2021/034) |

**State of the art:** Labeled PSI from FHE (CCS 2021) for unbalanced settings; PSI-Sum (2020) deployed in privacy-preserving ad attribution. Extends [PSI](#private-set-intersection-psi) and [OKVS](#oblivious-key-value-store-okvs); complements [Prio/VDAF](#prio--vdaf-privacy-preserving-aggregation).

---

## Volume-Hiding Searchable Encryption (Encrypted Multi-Maps)

**Goal:** Suppress volume leakage in SSE. Standard SSE reveals the number of documents matching each query keyword (the "volume"), enabling leakage-abuse attacks that reconstruct the dataset. Volume-hiding encrypted multi-maps (EMMs) pad or obfuscate response sizes so the server learns nothing beyond the fact that a query was made.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kamara-Moataz Volume-Hiding EMM** | 2019 | PRF + padding | Introduced volume-hiding EMMs; pads each response to maximum volume ℓ; O(ℓ) query overhead [[1]](https://eprint.iacr.org/2019/1292) |
| **Dynamic Volume-Hiding EMM (Patel et al.)** | 2021 | Dense Subgraph Transform | Supports updates with forward and backward privacy while hiding volume; O(ℓ log n) overhead [[1]](https://eprint.iacr.org/2021/765) |
| **XorMM (Patel-Persiano-Yeo-Yung)** | 2022 | XOR-based EMM | Optimal query communication: client receives exactly ℓ results, zero data loss; 1.23n storage, 76% storage savings vs. prior work; CCS 2022 [[1]](https://dl.acm.org/doi/10.1145/3548606.3559345) |

**State of the art:** XorMM (CCS 2022) for optimal overhead; Dynamic VH-EMM (2021) for updatable datasets. Addresses the primary practical attack surface against deployed [Searchable Encryption](#searchable-encryption-sse--peks).

---

## Shuffle Model of Differential Privacy

**Goal:** A middle ground between central and local DP. In the local model, each user randomizes their own data locally (strong privacy, poor accuracy). In the central model, a trusted curator adds noise to aggregate results (best accuracy, requires trust). The shuffle model uses an anonymous shuffler to break linkability, allowing local randomizers with small ε to achieve central-DP-level accuracy — without any trusted server.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Prochlo / ESA (Bittau et al.)** | 2017 | SGX-based oblivious shuffler + local DP | First Encode-Shuffle-Analyze system; uses Intel SGX for the shuffler; SOSP 2017 [[1]](https://dl.acm.org/doi/10.1145/3132747.3132769) |
| **Cheu-Smith-Ullman-Zeber-Zhilyaev** | 2019 | Shuffle model formalization | First rigorous definition; shows single-message protocols in shuffle model can achieve ε = O(1/√n) from locally ε-DP data; EUROCRYPT 2019 [[1]](https://eprint.iacr.org/2018/1282) |
| **Privacy Blanket (Balle-Bell-Gascón-Nissim)** | 2019 | Amplification by shuffling | Quantifies the privacy amplification: local ε₀-DP + shuffling → (ε, δ)-DP with ε = O(ε₀√(log(1/δ)/n)); CRYPTO 2019 [[1]](https://arxiv.org/abs/1903.02837) |
| **Feldman-McMillan-Talwar Hiding Among Clones** | 2021 | Poisson-subsampling analysis | Near-optimal amplification analysis; nearly tight bounds for practical parameters [[1]](https://arxiv.org/abs/2012.12803) |

**State of the art:** Privacy Blanket / Feldman et al. amplification bounds underpin all shuffle-model deployments; Prochlo in production at Google. Positioned between [Differential Privacy](#differential-privacy) (local DP row) and central DP; complements [Private Heavy Hitters](#private-heavy-hitters--frequency-estimation) and [Prio/VDAF](#prio--vdaf-privacy-preserving-aggregation).

---

## Differentially Private Machine Learning (DP-SGD / PATE)

**Goal:** Train ML models on private data with formal privacy guarantees. The trained model's parameters should not reveal sensitive details about individual training examples. Two main paradigms: DP-SGD (inject noise during gradient updates) and PATE (use private teacher ensembles with noisy voting to train a public student). Widely deployed in on-device learning and privacy-preserving analytics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DP-SGD (Abadi et al.)** | 2016 | Gradient clipping + Gaussian noise + Moments Accountant | Clip per-sample gradients to bound sensitivity; add Gaussian noise; track composition with the moments accountant; CCS 2016 [[1]](https://dl.acm.org/doi/10.1145/2976749.2978318) |
| **PATE (Papernot et al.)** | 2017 | Private teacher ensemble + noisy aggregation | Train N teacher models on disjoint private shards; student queries teachers via noisy vote; privacy cost only incurred on labeled queries; ICLR 2017 [[1]](https://arxiv.org/abs/1610.05755) |
| **Scalable PATE (Papernot et al.)** | 2018 | Rényi DP + data-dependent analysis | Tighter privacy accounting using Rényi DP when teacher consensus is strong; enables large-vocabulary models; ICLR 2018 [[1]](https://arxiv.org/abs/1802.08908) |
| **Opacus (Meta / PyTorch)** | 2020 | DP-SGD library | Production-grade DP-SGD implementation for PyTorch; per-sample gradient engine; widely used in industry [[1]](https://arxiv.org/abs/2109.12298) |

**State of the art:** DP-SGD (via Opacus/TF Privacy) is the standard for differentially private deep learning; PATE preferred when unlabeled public data is available. Relies on [Differential Privacy](#differential-privacy) mechanisms (Gaussian, Rényi/zCDP) and tightly integrates with the [Shuffle Model](#shuffle-model-of-differential-privacy) in federated settings.

---

## Advanced Single-Server PIR (OnionPIR / Spiral)

**Goal:** Practical single-server PIR with near-optimal communication and high server throughput. Goes beyond SealPIR's BFV-only approach by composing multiple lattice-based schemes (Regev + GSW) to simultaneously shrink query size, response size, and computation — making single-server PIR viable for real deployments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OnionPIR (Mughees-Chen-Ren)** | 2021 | BFV + RGSW; copy-network oblivious evaluation | Response overhead 4.2× over insecure baseline vs. ~100× for prior schemes; CCS 2021 [[1]](https://eprint.iacr.org/2021/1081) |
| **Spiral (Menon-Wu)** | 2022 | Regev + GSW FHE composition | 4.5× smaller queries, 1.5× smaller responses, 2× higher server throughput than OnionPIR; SpiralStream variant achieves 1.5 GB/s throughput and 0.49 rate; IEEE S&P 2022 [[1]](https://eprint.iacr.org/2022/368) |
| **OnionPIRv2 (Mughees et al.)** | 2025 | Improved BFV+RGSW composition | Further reduces response overhead; closes gap with Spiral in communication [[1]](https://eprint.iacr.org/2025/1142) |

**State of the art:** Spiral (2022) is the current throughput leader for single-server PIR; SimplePIR/DoublePIR (covered in [PIR](#private-information-retrieval-pir)) leads on latency with LWE. OnionPIR/Spiral are preferred when response size is the bottleneck (streaming applications).

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

## Privacy-Preserving Contact Tracing (GAEN / DP-3T)

**Goal:** Notify users of COVID-19 (or similar) exposure without revealing identities or location histories. Devices broadcast rotating pseudonymous Bluetooth beacons; a user who tests positive uploads their beacon keys to a server; all devices independently check for matches locally — the server never sees who met whom.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DP-3T (Decentralized Privacy-Preserving Proximity Tracing)** | 2020 | Ephemeral Bluetooth IDs + daily key rotation | Decentralized design: positive keys uploaded; each device downloads and checks locally; no central contact graph; EPFL/ETH Zurich [[1]](https://eprint.iacr.org/2020/399) |
| **GAEN (Google/Apple Exposure Notifications)** | 2020 | DP-3T-inspired; TEP keys + RPI derivation | Rolling Proximity Identifiers derived from Temporary Exposure Keys via HKDF; deployed on 3B+ devices in 60+ countries; OS-level BLE integration [[1]](https://covid19.apple.com/contacttracing) |
| **DESIRE (Dual-mode Exposure Notification)** | 2020 | GAEN + server-side PSI | Hybrid: supports both decentralized (GAEN) and server-side PSI matching; protects against false-positive injection attacks [[1]](https://eprint.iacr.org/2020/1072) |
| **Private Automated Contact Tracing (PACT)** | 2020 | Chirp-based identifiers + local matching | MIT/CMU variant; uses audible chirps in addition to BLE; same local-check model as DP-3T [[1]](https://pact.mit.edu/wp-content/uploads/2020/04/The-PACT-protocol-specification-working-paper-2020-04-10-1.pdf) |

**State of the art:** GAEN (Apple/Google production deployment) is the dominant system; DP-3T is the academic blueprint. Both avoid centralized contact graphs, unlike server-side tracing. Related to [Private Proximity Testing](#private-proximity-testing) and [Differential Privacy](#differential-privacy).

---

## Laconic OT and Laconic Cryptography

**Goal:** Sublinear-communication oblivious transfer and related protocols. In standard OT, communication scales with the sender's database size. Laconic OT compresses the receiver's input (a large set or database) into a short digest; the sender then sends a single short message per OT instance, achieving communication independent of the receiver's input size. Enables private database queries with server-optimal communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Laconic OT (Cho-Döttling-Garg-Gupta-Miao-Mukherjee)** | 2017 | CDH + hash-and-garble | First laconic OT; receiver compresses n-bit string into O(λ) digest; sender sends O(1) per bit; bootstraps from 2-round PIR [[1]](https://eprint.iacr.org/2017/1155) |
| **Laconic OT from CDH (Döttling-Garg)** | 2017 | CDH | Simpler construction; O(1) rounds; enables 2-round MPC with CDH [[1]](https://eprint.iacr.org/2017/585) |
| **Laconic Private Set Intersection (Döttling et al.)** | 2020 | Laconic OT + OKVS | PSI where sender's message size is independent of receiver's set; enables cloud-optimal PSI [[1]](https://eprint.iacr.org/2019/1256) |
| **Laconic Function Evaluation (LFE)** | 2022 | Laconic OT + garbling | Generalization: evaluate any circuit C on sender's input x where the digest encodes C; communication O(|x|) independent of |C| [[1]](https://eprint.iacr.org/2022/1614) |

**State of the art:** Laconic OT (2017) is the foundational primitive; LFE (2022) is the most general form. Laconic cryptography is related to [Oblivious Transfer](#oblivious-transfer-ot) (in `06-multi-party-computation.md`) and complements [PIR](#private-information-retrieval-pir) by reversing which party has the large input. See also [Laconic Cryptography](categories/16-obfuscation-advanced-hardness.md#laconic-cryptography) in the obfuscation category.

---

## Keyword PIR

**Goal:** Retrieve a database record by keyword (arbitrary string key) rather than by numeric index. Standard PIR hides which row index is fetched; Keyword PIR hides which key is queried from a key-value database. Removes the requirement for the client to know the database layout or item positions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Keyword PIR from OKVS (Chou-Lepoint)** | 2022 | OKVS + SealPIR | Encode key-value map with OKVS; run standard PIR on the encoded structure; first efficient keyword PIR [[1]](https://eprint.iacr.org/2022/875) |
| **Labeled PSI as Keyword PIR (Chen et al.)** | 2021 | BFV FHE + OPRF | Unbalanced labeled PSI doubles as keyword PIR for small-client-set against large server; CCS 2021 [[1]](https://eprint.iacr.org/2021/1116) |
| **Piano (Liu-Yanai)** | 2024 | LWE + offline hints | Sublinear-time keyword PIR; client downloads O(√n) hints offline; O(√n) online server work; practical for DNS/PKI lookups; IEEE S&P 2024 [[1]](https://eprint.iacr.org/2023/452) |
| **MulPIR / Batch Keyword PIR** | 2021 | BFV vectorization | Amortize multiple keyword queries in a single FHE ciphertext; throughput-optimized [[1]](https://eprint.iacr.org/2019/1503) |

**State of the art:** Piano (2024) for sublinear-time keyword PIR; OKVS-based keyword PIR for single queries. Directly extends [PIR](#private-information-retrieval-pir) and relies on [OKVS](#oblivious-key-value-store-okvs); used for private DNS resolution and private certificate transparency lookups.

---

## Unbalanced PSI (Client-Server PSI at Scale)

**Goal:** Private set intersection when one set (the server's) is orders of magnitude larger than the other (the client's). Standard PSI communication scales with both set sizes; unbalanced PSI achieves communication proportional only to the smaller client set, making it practical for contact discovery against billion-item databases.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Unbalanced PSI via Cuckoo Hashing + OT (Pinkas et al.)** | 2019 | OT + cuckoo hashing | Client set drives cuckoo table; server set encoded in simple hash table; linear in client set size; CCS 2019 [[1]](https://eprint.iacr.org/2019/723) |
| **Unbalanced PSI from FHE (Chen et al.)** | 2021 | BFV + OPRF batching | Server encodes its set with OPRF; client sends encrypted queries; server homomorphically matches; O(|client|·√|server|) communication; CCS 2021 [[1]](https://eprint.iacr.org/2021/1116) |
| **SpOT-Light (Pinkas-Rosulek-Trieu-Yanai)** | 2019 | OT + polynomial hashing | Compact PSI; O(|client| log |server|) communication; suited for mobile clients [[1]](https://eprint.iacr.org/2019/548) |
| **Private Contact Discovery (Signal)** | 2023 | Unbalanced PSI + SGX | Production system; client checks ~1024 contacts against billion-user database in ~2 sec using hardware-assisted unbalanced PSI [[1]](https://eprint.iacr.org/2023/758) |

**State of the art:** Signal's contact discovery (SGX-assisted, 2023) is the deployed benchmark; FHE-based unbalanced PSI (Chen et al.) is the leading software-only approach. Builds on [PSI](#private-set-intersection-psi) and [OKVS](#oblivious-key-value-store-okvs); see also [Labeled PSI and Private Intersection-Sum](#labeled-psi-and-private-intersection-sum-psi-sum) for payload-bearing variants.

---

## Homomorphic Encryption for ML Inference (CryptoNets)

**Goal:** Run neural network inference on encrypted client data. The server holds a trained model; the client encrypts their input and sends it; the server evaluates the network homomorphically and returns an encrypted prediction. The server never sees the raw input; the client never sees the model weights (optionally). Used for private medical diagnostics, biometric matching, and financial scoring.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CryptoNets (Gilad-Bachrach et al.)** | 2016 | YASHE (RLWE) | First deep neural network inference on RLWE-encrypted data; MNIST 99% accuracy; ~250 s/query; ICML 2016 [[1]](https://www.microsoft.com/en-us/research/publication/cryptonets-applying-neural-networks-to-encrypted-data-with-high-throughput-and-accuracy/) |
| **LoLa (Brutzkus et al.)** | 2019 | CKKS + packing | Low-latency CryptoNets variant; ~2.2 s/image on CIFAR-10; exploits SIMD packing; ICML 2019 [[1]](https://arxiv.org/abs/1812.10659) |
| **GAZELLE (Juvekar et al.)** | 2018 | HE + garbled circuits hybrid | HE for linear layers, garbled circuits for non-linear (ReLU) layers; 1000× speedup over pure HE for ReLU [[1]](https://eprint.iacr.org/2018/073) |
| **PEGASUS (Lu et al.)** | 2021 | CKKS ↔ FHEW switching | Fast ReLU evaluation via scheme-switching between CKKS and FHEW; 50–100× faster non-linear evaluation vs. prior work; CCS 2021 [[1]](https://eprint.iacr.org/2020/1606) |
| **HELiKs / Iron (Hao et al.)** | 2022 | CKKS + optimized packing | Transformer inference on encrypted data; enables private LLM queries; CCS 2022 [[1]](https://eprint.iacr.org/2022/1396) |

**State of the art:** PEGASUS (2021) for fast ReLU via scheme switching; GAZELLE hybrid approach for practical CNNs; Iron/HELiKs for transformer models. Complements [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd--pate) (privacy during training) by providing privacy during inference. Relies on [Homomorphic Encryption](categories/07-homomorphic-functional-encryption.md#homomorphic-encryption-he) and [zkML](categories/04-zero-knowledge-proof-systems.md#zkml--verifiable-ml-inference) (for verifiable inference).

---

## Differentially Private Synthetic Data Generation (DP-GAN / DP-VAE)

**Goal:** Generate synthetic datasets that are statistically similar to private training data but provide formal differential privacy guarantees. The synthetic dataset can be shared publicly or used for downstream ML without leaking information about any individual record. Used in healthcare, finance, and census data release.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DPGAN (Xie et al.)** | 2018 | GAN + DP-SGD | Train GAN with differentially private discriminator updates; first DP generative adversarial network for synthetic tabular data [[1]](https://arxiv.org/abs/1801.01594) |
| **DP-VAE / DP-CVAE** | 2020 | VAE + Gaussian mechanism | Variational autoencoder trained with DP-SGD; supports conditional generation; better mode coverage than DP-GANs for structured data [[1]](https://arxiv.org/abs/2001.00490) |
| **DP-MERF (Harder et al.)** | 2021 | Maximum mean discrepancy + DP | Fit a generative model to DP-noised kernel mean embeddings; avoids adversarial training instability; AISTATS 2021 [[1]](https://arxiv.org/abs/2002.11603) |
| **AIM (McKenna et al.)** | 2022 | Adaptive marginal selection + DP | Iteratively select and measure marginals; synthesize via graphical models; winner of NIST DP Synthetic Data Competition [[1]](https://arxiv.org/abs/2201.12677) |
| **PATE-GAN (Jordon et al.)** | 2019 | PATE + GAN discriminator | Use PATE teacher ensemble to label GAN-generated samples; avoids DP-SGD on generator; ICLR 2019 [[1]](https://openreview.net/forum?id=S1zk9iRqF7) |

**State of the art:** AIM (McKenna et al., 2022) leads for tabular/statistical data; DP-MERF avoids GAN instability; PATE-GAN for image-like data. All rely on [Differential Privacy](#differential-privacy) mechanisms and extend [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd--pate) to generative models.

---

## Privacy-Preserving Federated Learning

**Goal:** Train machine learning models collaboratively across many clients (devices or organizations) without centralizing raw data. Each client trains locally on private data and shares only model updates (gradients or weights); a central aggregator combines them. Privacy is strengthened by combining with differential privacy, secure aggregation, or MPC.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FedAvg (McMahan et al.)** | 2017 | Local SGD + averaging | Foundational federated learning algorithm; clients train multiple local steps, server averages weights; Google Keyboard [[1]](https://arxiv.org/abs/1602.05629) |
| **DP-FedAvg (McMahan et al.)** | 2018 | FedAvg + DP-SGD + SecAgg | Add user-level DP to FedAvg; clip and noise updates before aggregation; formal (ε,δ)-DP guarantee for the central model [[1]](https://arxiv.org/abs/1710.06963) |
| **PySyft (OpenMined)** | 2018 | MPC + FHE + SecAgg | Open-source library for privacy-preserving federated learning with MPC and HE backends; supports SMPC-based aggregation [[1]](https://arxiv.org/abs/1811.04017) |
| **TensorFlow Federated (TFF)** | 2019 | FedAvg + DP + SecAgg | Google's production framework; integrates SecAgg and DP mechanisms; used in Gboard on-device language models [[1]](https://arxiv.org/abs/1902.01046) |
| **Flower (flwr)** | 2020 | Framework-agnostic FL | Open-source FL framework supporting PyTorch, TF, JAX; heterogeneous clients; pluggable aggregation strategies; widely adopted in research [[1]](https://arxiv.org/abs/2007.14390) |

**State of the art:** TensorFlow Federated (production at Google), Flower (research standard); both support DP and SecAgg. Privacy relies on [Differential Privacy](#differential-privacy), [Secure Aggregation](categories/06-multi-party-computation.md#secure-aggregation-secagg), and [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd--pate).

---

## Secure Multi-Party Machine Learning (CrypTen / MOTION2NX)

**Goal:** Train or run inference on ML models where multiple parties jointly compute over their private datasets using MPC — without any party seeing another's raw data. Stronger than federated learning (no gradient leakage) but more expensive; targets settings where parties distrust each other's infrastructure entirely.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CrypTen (Knott et al. / Meta)** | 2021 | Secret sharing (SPDZ-like) | PyTorch-compatible framework for secret-shared ML; supports training and inference; ArithmeticSharedTensor API mirrors PyTorch tensors; open-sourced by Meta [[1]](https://arxiv.org/abs/2109.00016) |
| **MOTION2NX (Braun et al.)** | 2022 | GMW + BMR + CKKS hybrid | High-performance MPC framework targeting neural network inference; combines arithmetic (GMW), boolean, and CKKS protocols; used in MOTION4ML [[1]](https://eprint.iacr.org/2020/1137) |
| **Crypten+SMPC Training (Ryffel et al.)** | 2020 | SPDZ + DP | Combine MPC-based training with DP noise injection; privacy-by-design ML pipeline [[1]](https://arxiv.org/abs/1811.04017) |
| **Piranha (Watson et al.)** | 2022 | GPU-accelerated 3-party MPC | GPU-friendly secret-sharing for ML; 16–48× speedup over CPU MPC for ResNet inference; USENIX Security 2022 [[1]](https://eprint.iacr.org/2022/892) |
| **ELSA (Rathee et al.)** | 2023 | Linear secret sharing + OT | Efficient 2-party DNN inference; 2.5× less communication than prior work; IEEE S&P 2023 [[1]](https://eprint.iacr.org/2023/013) |

**State of the art:** CrypTen (Meta, production-oriented 2-party/N-party); Piranha (GPU-accelerated 3PC); ELSA (communication-efficient 2PC inference). Builds on [MPC](categories/06-multi-party-computation.md#multi-party-computation-mpc), [Garbled Circuits](categories/06-multi-party-computation.md#garbled-circuits-expanded), and [OLE/VOLE](categories/06-multi-party-computation.md#oblivious-linear-evaluation-ole--vole). Complements [HE for ML Inference](#homomorphic-encryption-for-ml-inference-cryptonets) (HE-only path) and [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd--pate) (DP path).

---

## Private Nearest-Neighbor Search (Private Embedding Retrieval)

**Goal:** Retrieve the nearest neighbor to a query vector from a private database without revealing the query or which item was fetched. Increasingly critical as ML systems embed data into high-dimensional vector spaces (semantic search, face recognition, recommendation). Combines PIR/ORAM techniques with approximate nearest-neighbor (ANN) data structures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **NN-PIR (Aggarwal et al.)** | 2022 | PIR + locality-sensitive hashing | Apply LSH to partition the embedding database; run PIR on each bucket; first sublinear-communication private ANN [[1]](https://eprint.iacr.org/2022/1041) |
| **FrodoPIR for Embeddings** | 2023 | Plain LWE PIR + quantized embeddings | Adapt FrodoPIR offline-preprocessing model to vector databases; client computes ANN candidate set privately; ePrint 2022/981 extension [[1]](https://eprint.iacr.org/2022/981) |
| **SPiral-ANN (Menon-Wu style)** | 2023 | Spiral PIR + HNSW index | Use Spiral's lattice-based PIR on HNSW graph indices; hides both query vector and graph traversal path [[1]](https://eprint.iacr.org/2023/296) |
| **HADES (Private Vector Search)** | 2024 | Hybrid ORAM + ANN | Full oblivious ANN search: hides query, result, and access pattern; uses Path ORAM over ANN index; CCS 2024 [[1]](https://dl.acm.org/doi/10.1145/3658644.3690268) |

**State of the art:** HADES (CCS 2024) for full obliviousness; NN-PIR for query-only privacy with sublinear communication. Active area driven by private retrieval-augmented generation (RAG) and biometric matching. Extends [PIR](#private-information-retrieval-pir), [Keyword PIR](#keyword-pir), and [ORAM](#oblivious-ram-oram) to vector/embedding databases.

---

## Private Equality Testing (PET)

**Goal:** Two parties each hold a private value; they want to learn whether their values are equal — and nothing else. Stronger than PSI (which reveals the matching element): PET reveals only a single bit (equal or not). Used in threshold signature coordination, duplicate detection, and identity verification without exposing the value itself.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DH-Based PET (Meadows)** | 1986 | DDH | Commit-and-compare using Diffie-Hellman; O(1) rounds; semi-honest [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_16) |
| **Maliciously Secure PET (Jarecki-Liu)** | 2009 | OPRF + ZK proofs | UC-secure PET; uses OPRF so neither party learns the other's value on inequality; ACM CCS 2009 [[1]](https://eprint.iacr.org/2009/600) |
| **Batch PET from VOLE (Rindal et al.)** | 2021 | VOLE + hashing | Amortize many equality tests using VOLE; O(n) communication for n tests; building block for multi-query PSI [[1]](https://eprint.iacr.org/2021/026) |
| **PET for Threshold Signatures (SPRINT)** | 2023 | PET + threshold ECDSA | Use private equality testing to check shares match without reconstruction; applied in asynchronous threshold signing; ACM CCS 2023 [[1]](https://eprint.iacr.org/2023/427) |

**State of the art:** Batch PET from VOLE (2021) for high-throughput equality testing; UC-secure PET (Jarecki-Liu) when malicious security is required. Closely related to [PSI](#private-set-intersection-psi) (equality at scale) and [OPRF](#oblivious-prf-oprf) (the key building block); useful in [Threshold Signatures](categories/08-signatures-advanced.md#threshold-signatures-tss) and [Secret Sharing](categories/05-secret-sharing-threshold-cryptography.md#secret-sharing-shamir-ss).

---
