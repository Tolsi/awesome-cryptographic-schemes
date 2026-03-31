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

**Production readiness:** Production
Deployed in Signal private contact discovery, Google Private Join and Compute, Apple iMessage contact suggestions

**Implementations:**
- [microsoft/APSI](https://github.com/microsoft/APSI) ⭐ 208 — C++, asymmetric/unbalanced PSI from Microsoft Research
- [osu-crypto/libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, comprehensive PSI library (KKRT, RR17, OPRF-based)
- [OpenMined/PSI](https://github.com/OpenMined/PSI) ⭐ 151 — C++/Python, OPRF-based PSI by OpenMined

**Security status:** Secure
OPRF-based and OT-based protocols proven secure under standard assumptions (DDH, ROM); malicious-security variants available

**Community acceptance:** Widely trusted
Extensive peer review; deployed by Signal, Google, Apple; active standardization discussions in IETF

---

## Private Set Union (PSU)

**Goal:** Compute the union of private sets without revealing which elements belong to which party. Dual of [PSI](#private-set-intersection-psi) (intersection) — PSU reveals A ∪ B while hiding individual membership. Harder than PSI because the output is larger.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kolesnikov-Kumaresan-Rosulek-Trieu PSU** | 2019 | OPRF + OT | First efficient PSU with linear communication [[1]](https://eprint.iacr.org/2019/776) |
| **Jia-Sun-Zhou-Gu Scalable PSU** | 2024 | Additively HE | Stronger security; avoids OT-based leakage; scales to millions of items [[1]](https://eprint.iacr.org/2024/922) |

**State of the art:** AHE-based PSU (2024) for stronger security; OPRF-based for efficiency. Related to [PSI](#private-set-intersection-psi) and [OKVS](#oblivious-key-value-store-okvs).

**Production readiness:** Research
Academic prototypes only; no known large-scale production deployments

**Implementations:**
- [osu-crypto/libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, includes PSU building blocks
- [dujiajun/PSU](https://github.com/dujiajun/PSU) ⭐ 15 — C++, AHE-based PSU implementation

**Security status:** Secure
Proven secure under standard assumptions (DDH, Paillier); less studied than PSI but no known attacks

**Community acceptance:** Niche
Well-studied in academic literature but limited adoption; fewer implementations and deployments than PSI

---

## Private Set Difference / Set Operations

**Goal:** Compute set difference and symmetric difference privately. Beyond [PSI](#private-set-intersection-psi) (intersection) and [PSU](#private-set-union-psu) (union): compute A \ B (in A not B) or A △ B (in exactly one) without revealing other elements. Applications: deduplication, anomaly detection, auditing.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kissner-Song Set Operations** | 2005 | Paillier + polynomials | First composable framework for union, intersection, difference, symmetric difference; CRYPTO 2005 [[1]](https://link.springer.com/chapter/10.1007/11535218_15) |
| **Multi-Party Set Difference** | 2005 | Threshold Paillier | Extension to N parties with malicious security [[1]](https://www.cs.cmu.edu/~leak/papers/set-tech-full.pdf) |

**State of the art:** Kissner-Song (CRYPTO 2005); set-difference components most overlooked. Complements [PSI](#private-set-intersection-psi) and [PSU](#private-set-union-psu).

**Production readiness:** Research
Academic constructions only; no production deployments known

**Implementations:**
- [encryptogroup/ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, general MPC framework supporting set operations

**Security status:** Secure
Based on Paillier encryption; provably secure under standard assumptions

**Community acceptance:** Niche
Foundational academic work (CRYPTO 2005) but limited follow-up; most practitioners use PSI or PSU instead

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

**Production readiness:** Mature
Path ORAM widely implemented; used as building block in Signal SGX contact discovery and research systems

**Implementations:**
- [osu-crypto/libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, includes ORAM primitives for MPC
- [emp-toolkit/emp-ag2pc](https://github.com/emp-toolkit/emp-ag2pc) ⭐ 33 — C++, Circuit ORAM integration for 2PC
- [ObliVM](https://oblivm.com/) — Java, oblivious computation framework with ORAM support

**Security status:** Secure
Path ORAM proven secure in standard model; access pattern hiding guaranteed with correct implementation

**Community acceptance:** Widely trusted
Extensively studied since 1996; Path ORAM widely cited (3000+ citations); foundational primitive in MPC and encrypted databases

---

## Frequency-Smoothing Oblivious Datastores (PANCAKE / Waffle)

**Goal:** Hide access patterns for key-value stores with practical overhead. Full ORAM protects against arbitrary adversaries but incurs high bandwidth overhead. When the adversary is a passive persistent observer (no query injection), frequency smoothing transforms skewed plaintext access distributions into uniform encrypted access distributions — achieving orders-of-magnitude better throughput than Path ORAM. PANCAKE requires a known access distribution; Waffle extends this to unknown, adaptive distributions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PANCAKE (Grubbs et al.)** | 2020 | Frequency smoothing + encrypted key-value store | First system for passive-persistent-adversary access-pattern hiding; 229× better throughput than non-recursive Path ORAM; within 3–6× of insecure baselines; USENIX Security 2020 Distinguished Paper [[1]](https://eprint.iacr.org/2020/1501) |
| **Waffle (Maiyya et al.)** | 2024 | Online frequency smoothing + adaptive batching | Extends PANCAKE to unknown/changing access distributions; no prior knowledge of query distribution needed; 45–57% faster than PANCAKE; 102× faster than TaoStore ORAM; SIGMOD 2024 [[1]](https://eprint.iacr.org/2023/1285) |

**State of the art:** Waffle (SIGMOD 2024) for adaptive settings; PANCAKE (USENIX Sec 2020) when the access distribution is known. Both sit between insecure key-value stores and full [ORAM](#oblivious-ram-oram) in the security/performance tradeoff space. The weaker threat model (no query-injection adversary) is appropriate for many cloud storage deployments.

**Production readiness:** Experimental
Research prototypes with benchmarks on real workloads; not yet deployed in production

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
Weaker threat model than full ORAM (passive persistent adversary only); secure within stated assumptions but not against active query injection

**Community acceptance:** Emerging
USENIX Security Distinguished Paper (PANCAKE); growing interest as practical alternative to full ORAM for cloud storage

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

**State of the art:** SimplePIR/DoublePIR (speed), Spiral (throughput, see [Advanced Single-Server PIR](#advanced-single-server-pir-onionpir-spiral)), FrodoPIR (scalable single-server with offline preprocessing), Checklist (sublinear server time with client hints), IT-PIR (information-theoretic setting).

**Production readiness:** Mature
SimplePIR/DoublePIR and Spiral have working implementations; Checklist deployed for private Safe Browsing research

**Implementations:**
- [menonsamir/spiral-rs](https://github.com/menonsamir/spiral-rs) ⭐ 15 — Rust, Spiral PIR implementation
- [microsoft/SealPIR](https://github.com/microsoft/SealPIR) ⭐ 156 — C++, BFV-based single-server PIR
- [ahenzinger/simplepir](https://github.com/ahenzinger/simplepir) ⭐ 100 — Go, SimplePIR/DoublePIR implementation
- [dimakogan/checklist](https://github.com/dimakogan/checklist) ⭐ 23 — Go, 2-server PIR with client hints

**Security status:** Secure
Computational PIR based on LWE/RLWE; information-theoretic PIR unconditionally secure with non-colluding servers

**Community acceptance:** Widely trusted
Active research area since 1995; SimplePIR/Spiral represent breakthrough practical improvements; Google and Apple exploring for production

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

**Production readiness:** Mature
CryptDB deployed in academic and research settings; commercial encrypted database products incorporate SSE ideas

**Implementations:**
- [OpenSSE/opensse-schemes](https://github.com/OpenSSE/opensse-schemes) ⭐ 99 — C++, reference SSE implementations (Diana, Janus, Sophos)
- [CryptDB/CryptDB](https://github.com/CryptDB/CryptDB) ⭐ 521 — C++, encrypted SQL proxy with SSE

**Security status:** Caution
Inherent leakage profiles (access pattern, volume) exploitable via IKK/Count attacks; forward/backward privacy mitigates but does not eliminate risk

**Community acceptance:** Widely trusted
Extensive peer review since 2000; well-understood leakage tradeoffs; MongoDB and other vendors adopting SSE-inspired designs

---

## Oblivious PRF (OPRF)

**Goal:** Privacy. A client and server jointly evaluate a PRF on the client's input using the server's key — the client learns only the output, the server learns nothing. Provides input confidentiality + unlinkability.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **2HashDH OPRF** | 2009 | DLEQ / EC | Simple DH-based; basis of most deployed OPRFs [[1]](https://eprint.iacr.org/2014/650) |
| **VOPRF** | 2021 | EC + DLEQ proof | Verifiable: client can check server evaluated correctly [[1]](https://www.rfc-editor.org/rfc/rfc9497) |
| **POPRF** | 2021 | EC + tweak | Partially-oblivious: server adds a public tweak to evaluation [[1]](https://www.rfc-editor.org/rfc/rfc9497) |

**State of the art:** VOPRF (RFC 9497) with Ristretto255 — used in Privacy Pass, OPAQUE password protocol, PSI.

**Production readiness:** Production
VOPRF standardized as RFC 9497; deployed in Privacy Pass (Cloudflare), OPAQUE password protocol, and PSI systems

**Implementations:**
- [cloudflare/voprf-ts](https://github.com/cloudflare/voprf-ts) ⭐ 38 — TypeScript, Cloudflare VOPRF implementation
- [cfrg/draft-irtf-cfrg-voprf](https://github.com/cfrg/draft-irtf-cfrg-voprf) ⭐ 39 — Reference implementation for RFC 9497
- [facebook/opaque-ke](https://github.com/facebook/opaque-ke) ⭐ 386 — Rust, OPRF as part of OPAQUE protocol

**Security status:** Secure
VOPRF proven secure under DDH/Ristretto255; verifiability via DLEQ proofs; RFC 9497 specifies secure parameters

**Community acceptance:** Standard
IETF RFC 9497 (CFRG); used in RFC 9578 (Privacy Pass); endorsed by Cloudflare, Apple, Google

---

## Oblivious Key-Value Store (OKVS)

**Goal:** Efficient private encoding of key-value maps. Encode a set of (key, value) pairs into a compact structure where querying a key returns the value, but querying any other key returns random noise. Core data structure behind state-of-the-art PSI and circuit-PSI protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garbled Bloom Filter (GBF)** | 2014 | XOR-based | Encode key-value pairs in Bloom filter structure; see [Accumulators](09-commitments-verifiability.md#accumulators) [[1]](https://doi.org/10.1145/2660267.2660323) |
| **PaXoS (Probe-and-XOR of Strings)** | 2020 | Linear system | Solve linear system over GF(2); compact encoding, fast decode [[1]](https://eprint.iacr.org/2020/193) |
| **OKVS (Garimella et al.)** | 2021 | Banded matrix | Near-optimal rate (encoding ≈ n items); backbone of fast PSI [[1]](https://eprint.iacr.org/2021/883) |
| **RB-OKVS (Random Band)** | 2022 | Banded linear algebra | Improved; O(n) encode/decode; used in fastest PSI implementations [[1]](https://eprint.iacr.org/2022/320) |

**State of the art:** RB-OKVS (2022); enables PSI on millions of items in seconds. Key building block for [PSI](#private-set-intersection-psi) and [Silent OT](06-multi-party-computation.md#silent-ot-pseudorandom-correlation-generators-pcg).

**Production readiness:** Experimental
Used as internal building block in PSI research implementations; no standalone production deployment

**Implementations:**
- [osu-crypto/libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, includes RB-OKVS implementation for PSI
- [Visa-Research/volepsi](https://github.com/Visa-Research/volepsi) ⭐ 135 [archived] — C++, VOLE-based PSI using OKVS

**Security status:** Secure
Provably secure encoding; queries on non-programmed keys return random noise; security reduces to underlying PRF

**Community acceptance:** Emerging
Rapidly adopted in PSI research; RB-OKVS (2022) is the de facto data structure for efficient PSI; growing recognition in the MPC community

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

**Production readiness:** Mature
Bitonic sort widely implemented in MPC frameworks; oblivious bucket sort used in research systems

**Implementations:**
- [emp-toolkit/emp-sh2pc](https://github.com/emp-toolkit/emp-sh2pc) ⭐ 81 — C++, includes oblivious sorting for 2PC
- [samee/obliv-c](https://github.com/samee/obliv-c) ⭐ 184 — C, oblivious C compiler with sorting primitives
- [encryptogroup/MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, MPC framework with oblivious sorting support

**Security status:** Secure
Bitonic sort data-independent by construction; bucket sort proven oblivious with negligible failure probability

**Community acceptance:** Widely trusted
Bitonic sort used since 1968; foundational building block in all major MPC frameworks; FSS-based sorting (2024) represents cutting-edge advancement

---

## Private Function Evaluation (PFE)

**Goal:** Hide the function. In standard MPC, the computed function is public. In PFE, even the function is private — one party's input is the circuit/program itself. Used when the algorithm is proprietary (trade secret evaluation, private credit scoring).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Universal Circuits (Valiant)** | 1976 | Circuit topology | Simulate any circuit of size n with O(n log n) universal circuit [[1]](https://dl.acm.org/doi/10.1145/800113.803649) |
| **PFE via Universal Circuit + GC** | 2008 | Garbled universal circuit | Embed function into UC, then garble; see [Garbled Circuits](06-multi-party-computation.md#garbled-circuits-expanded) [[1]](https://eprint.iacr.org/2008/491) |
| **PFE from OT (Mohassel-Sadeghian)** | 2013 | OT + permutation network | More efficient: use extended OT to evaluate switching network [[1]](https://eprint.iacr.org/2013/239) |

**State of the art:** OT-based PFE (practical), Universal Circuits (theoretical foundation).

**Production readiness:** Research
Academic prototypes only; no known production deployments due to high overhead of universal circuits

**Implementations:**
- [encryptogroup/ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, general MPC framework usable for PFE

**Security status:** Secure
Provably secure under standard MPC assumptions; security of universal circuit approach well-established

**Community acceptance:** Niche
Well-studied theoretical area; practical deployments limited by O(n log n) overhead of universal circuits

---

## Oblivious Message Retrieval (OMR)

**Goal:** Private message delivery. Messages are posted to a public bulletin board; a recipient can detect and download their messages without the server learning which messages belong to whom. Like PIR but optimized for the "mailbox" setting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Liu-Tromer OMR** | 2021 | FHE (BFV) | First OMR; server runs FHE detection on behalf of recipient [[1]](https://eprint.iacr.org/2021/1256) |
| **Cohn-Gordon et al. OMR** | 2023 | PIR + FHE | Improved; practical for millions of messages, ~5 sec server time [[1]](https://eprint.iacr.org/2022/1528) |
| **FrodoPIR-based OMR** | 2023 | Lattice PIR | Lightweight variant using offline preprocessing [[1]](https://eprint.iacr.org/2022/981) |

**State of the art:** FHE-based OMR (Liu-Tromer 2021+); enables private messaging without metadata leakage. Extends [PIR](#private-information-retrieval-pir) to the messaging domain.

**Production readiness:** Research
Academic prototypes; proposed for private messaging systems but no production deployment yet

**Implementations:**
- [microsoft/SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, BFV FHE library used as backend for OMR constructions

**Security status:** Secure
Based on BFV FHE; security inherits from underlying lattice assumptions (RLWE)

**Community acceptance:** Emerging
Active research area since 2021; strong interest from private messaging community; proposed for Zcash and similar systems

---

## Oblivious DNS (ODoH)

**Goal:** DNS privacy without trusting any single party. Client encrypts DNS query with HPKE to the resolver; a proxy forwards it without decrypting. The proxy sees the client but not the query; the resolver sees the query but not the client. Cryptographic separation of identity from intent.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Oblivious DoH (ODoH)** | 2021 | HPKE + proxy | IETF RFC 9230; deployed by Cloudflare + Apple; proxy-based privacy [[1]](https://www.rfc-editor.org/rfc/rfc9230) |
| **μODNS (Mutualized Oblivious DNS)** | 2021 | Multi-relay | Multiple randomly selected relays; defeats single-relay collusion [[1]](https://arxiv.org/abs/2104.13785) |
| **OHTTP (Oblivious HTTP)** | 2024 | HPKE + relay | **RFC 9458**; generalizes ODoH to arbitrary HTTP requests; client identity hidden from server [[1]](https://www.ietf.org/rfc/rfc9458.html) |

**State of the art:** ODoH (RFC 9230) for DNS; OHTTP (RFC 9458) for general HTTP; deployed in Apple iCloud Private Relay, Cloudflare. Related to [Onion Routing](11-anonymity-credentials.md#onion-routing).

**Production readiness:** Production
Deployed by Cloudflare (1.1.1.1 ODoH), Apple iCloud Private Relay, and Firefox; OHTTP generalized to arbitrary HTTP

**Implementations:**
- [cloudflare/odoh-rs](https://github.com/cloudflare/odoh-rs) ⭐ 188 — Rust, ODoH implementation
- [nicholaspai/odoh-client-go](https://github.com/cloudflare/odoh-client-go) ⭐ 82 — Go, ODoH client

**Security status:** Secure
Based on HPKE (RFC 9180); security relies on non-collusion between proxy and resolver; formally analyzed

**Community acceptance:** Standard
IETF RFC 9230 (ODoH), RFC 9458 (OHTTP); deployed by Cloudflare, Apple, Google; industry consensus on relay-based DNS privacy

---

## Fuzzy Private Set Intersection (FPSI)

**Goal:** Find approximate matches between private sets. Standard PSI finds exact matches; FPSI finds elements that are "close" (edit distance, Hamming distance, Euclidean distance). Enables privacy-preserving record linkage, biometric matching, and DNA comparison without exact identifiers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fuzzy PSI from OT (Freedman et al.)** | 2016 | OT + locality-sensitive hash | First FPSI; LSH reduces fuzzy matching to multiple exact PSI instances [[1]](https://eprint.iacr.org/2016/799) |
| **FPSI from VOLE** | 2025 | VOLE + fuzzy matching | Efficient FPSI using vector OLE; sublinear communication for approximate matches [[1]](https://eprint.iacr.org/2025/911) |

**State of the art:** VOLE-based FPSI (2025); combines [PSI](#private-set-intersection-psi), [OLE/VOLE](#oblivious-polynomial-evaluation-ope), and [PPRL](#privacy-preserving-record-linkage-pprl).

**Production readiness:** Research
Academic prototypes; no production deployments yet

**Implementations:**
- [osu-crypto/libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, PSI library with fuzzy matching extensions

**Security status:** Secure
Reduces to standard PSI and VOLE security; LSH-based approaches proven in the random oracle model

**Community acceptance:** Emerging
Growing interest driven by PPRL and biometric matching applications; VOLE-based FPSI (2025) represents latest advancement

---

## Private Proximity Testing

**Goal:** Check if two users are near each other without revealing their exact locations. Alice and Bob learn only whether they are within distance d — nothing else about each other's position. Enables contact tracing, friend-finding, dating apps.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Narayanan-Thiagarajan-Lakhani-Hamburg-Boneh** | 2011 | HE + grid quantization | Location quantized to grid cells; encrypted comparison reveals only "same cell" [[1]](https://crypto.stanford.edu/~dabo/pubs/papers/locpriv.pdf) |
| **Proximity Testing via DH** | 2014 | DDH | Two-party protocol: shared-grid approach with DH-based equality test [[1]](https://eprint.iacr.org/2014/078) |
| **Rogue-Resistant Proximity Testing** | 2020 | ZK + commitments | Resist malicious users lying about location [[1]](https://eprint.iacr.org/2020/857) |

**State of the art:** Grid-based DH proximity testing; used in COVID exposure notification research. Combines [HE](#graph-encryption) or [PSI](#private-set-intersection-psi) techniques.

**Production readiness:** Experimental
Used in COVID-19 exposure notification research; no standalone commercial deployment

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
Grid-based approaches leak coarse location information; rogue-resistant variants needed for malicious settings

**Community acceptance:** Niche
Academic interest primarily driven by COVID-19; limited adoption outside contact tracing research

---

## Private Heavy Hitters / Frequency Estimation

**Goal:** Discover popular items from distributed private data. Many clients each hold a private value; the server wants to find the most frequent values (heavy hitters) or estimate value frequencies — without learning any individual client's data. Core primitive for telemetry, analytics, and spam detection.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RAPPOR (Google)** | 2014 | Local DP + Bloom filters | First deployed private frequency estimation; Chrome telemetry [[1]](https://doi.org/10.1145/2660267.2660348) |
| **Poplar (Boneh et al.)** | 2021 | Incremental DPF | Private heavy hitters via distributed point functions; no public-key crypto needed [[1]](https://arxiv.org/abs/2012.14884) |
| **Prio3 + VDAF (IETF)** | 2023 | Secret sharing + ZK | Standardized (draft-irtf-cfrg-vdaf); used in Mozilla/Apple telemetry; extends [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation) [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-vdaf/) |
| **Mastic** | 2024 | IDPF + attribute filtering | Extends Poplar to weighted, attribute-filtered metrics under two-server MPC; PoPETS 2025 [[1]](https://eprint.iacr.org/2024/221) |

**State of the art:** Poplar/Prio3 for heavy hitters, Mastic (2025, weighted heavy hitters); RAPPOR for local DP. Related to [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation) and [Differential Privacy](#differential-privacy).

**Production readiness:** Production
RAPPOR deployed in Chrome; Poplar/Prio3 in Firefox and Apple telemetry; Mastic in development

**Implementations:**
- [nicholaspai/rappor](https://github.com/google/rappor) ⭐ 870 — Python, Google RAPPOR reference implementation
- [nicholaspai/libprio-rs](https://github.com/divviup/libprio-rs) ⭐ 117 — Rust, Prio3/VDAF with Poplar support

**Security status:** Secure
Formal differential privacy guarantees; Prio3/VDAF provides verifiable aggregation preventing malicious client input

**Community acceptance:** Standard
IETF VDAF standard (draft-irtf-cfrg-vdaf); deployed by Google, Mozilla, Apple; strong industry consensus

---

## Private Stream Aggregation (PSA)

**Goal:** Aggregate time-series data from many users without seeing individual values. Each user encrypts their data point; the aggregator computes the sum (or polynomial function) of all values without decrypting any individual contribution. Lighter than FHE/MPC — designed for smart metering, federated analytics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shi-Chan-Rieffel-Chow-Song PSA** | 2011 | DLP + noise | First PSA; aggregator learns only noisy sum; differential privacy built in [[1]](https://eprint.iacr.org/2010/612) |
| **DIPSAUCE (Trusted-Setup-Free PSA)** | 2023 | LWE | No trusted authority for key generation; fully decentralized setup [[1]](https://eprint.iacr.org/2023/214) |
| **PPSA (Polynomial PSA)** | 2024 | Lattice + DP | Extends PSA to arbitrary polynomial functions over streams; 138x speedup over prior work [[1]](https://eprint.iacr.org/2024/1460) |

**State of the art:** PPSA (2024) for polynomial aggregation; DIPSAUCE for trustless setup. Distinct from [SecAgg](#private-stream-aggregation-psa) (one-shot) and [HE](#graph-encryption) (general computation) by focusing on lightweight streaming aggregation.

**Production readiness:** Research
Academic prototypes; no known production deployments

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
DIPSAUCE based on LWE; PPSA on lattice assumptions; both include differential privacy noise

**Community acceptance:** Niche
Specialized area between SecAgg and FHE; limited but growing interest for IoT and smart metering applications

---

## Privacy-Preserving Record Linkage (PPRL)

**Goal:** Link records across databases (hospitals, registries) referring to the same person — without revealing any personal data to the other party. Match on fuzzy identifiers (name variants, typos) using MPC/PSI techniques. Critical for medical research and census.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bloom Filter PPRL (Schnell et al.)** | 2009 | Bloom filters + Dice coeff. | First practical PPRL; encode n-grams of names in Bloom filters; compare similarity [[1]](https://doi.org/10.1186/1472-6947-9-41) |
| **MainSEL** | 2022 | ABY MPC + Bloom filters | Production MPC system; links against 10K records in <4 sec; deployed in German hospitals [[1]](https://academic.oup.com/bioinformatics/article/38/6/1657/5900257) |
| **Fuzzy PSI for PPRL** | 2025 | VOLE + fuzzy matching | Extension of [PSI](#private-set-intersection-psi) to approximate/fuzzy matching for record linkage [[1]](https://eprint.iacr.org/2025/911) |

**State of the art:** MainSEL (deployed); Fuzzy PSI from VOLE (2025). Combines [PSI](#private-set-intersection-psi), [MPC](06-multi-party-computation.md#multi-party-computation-mpc), and approximate matching.

**Production readiness:** Production
MainSEL deployed in German hospitals; Bloom filter PPRL used in medical research linkage projects

**Implementations:**
- [medicalinformatics/SecureEpilinker](https://github.com/medicalinformatics/SecureEpilinker) ⭐ 11 — C++, production MPC-based record linkage (MainSEL)

**Security status:** Caution
Bloom filter PPRL vulnerable to frequency attacks on common names; MPC-based variants (MainSEL) stronger but costlier

**Community acceptance:** Niche
Well-established in medical informatics; used by national health registries; less known outside healthcare domain

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

**Production readiness:** Production
Deployed by Apple (iOS/macOS telemetry), Google (RAPPOR, Chrome), US Census Bureau (2020 Census), Microsoft, and Meta

**Implementations:**
- [google/differential-privacy](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, Google DP library
- [opendp/opendp](https://github.com/opendp/opendp) ⭐ 412 — Rust/Python, OpenDP framework from Harvard
- [pytorch/opacus](https://github.com/pytorch/opacus) ⭐ 1.9k — Python, DP-SGD for PyTorch by Meta
- [tumult-labs/tumult-analytics](https://gitlab.com/tumult-labs/analytics) — Python, DP analytics platform

**Security status:** Secure
Mathematically proven privacy guarantees; composable via Renyi DP / zCDP; requires correct noise calibration

**Community acceptance:** Standard
NIST guidelines reference DP; adopted by US Census Bureau, Apple, Google; de facto standard for statistical privacy

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

**Production readiness:** Production
Prio deployed by ISRG (Divvi Up) for Firefox and Android telemetry; Prio3/VDAF standardized by IETF

**Implementations:**
- [divviup/janus](https://github.com/divviup/janus) ⭐ 65 — Rust, DAP aggregator by Divvi Up/Cloudflare
- [divviup/libprio-rs](https://github.com/divviup/libprio-rs) ⭐ 117 — Rust, ISRG Prio3/VDAF implementation

**Security status:** Secure
Secret-sharing-based; security requires non-collusion of aggregation servers; client input validation via SNIPs/FLP

**Community acceptance:** Standard
IETF RFC 9746 (DAP); draft-irtf-cfrg-vdaf; deployed by ISRG, Mozilla, Google, Apple

---

## Sealed-Bid Auction Protocols

**Goal:** Private bidding. Bidders submit encrypted bids; the protocol determines the winner (and optionally the clearing price) without revealing losing bids. Prevents bid sniping, collusion, and underbidding.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Brandt Sealed-Bid Auction** | 2002 | Homomorphic enc + ZK | First practical sealed-bid auction; Vickrey (second-price) via MPC [[1]](https://doi.org/10.1007/3-540-36563-X_5) |
| **Lipmaa-Asokan-Niemi** | 2002 | Paillier + range proofs | Efficient first-price sealed-bid auction; additive homomorphic [[1]](https://doi.org/10.1007/3-540-36563-X_4) |
| **Bogetoft et al. (Danish Sugar Beet Auction)** | 2009 | MPC (Shamir SS) | First real-world MPC auction; 1200+ farmers, Danish sugar beet contracts [[1]](https://doi.org/10.1007/978-3-642-03549-4_19) |
| **MEV Auction / Fair Ordering** | 2023 | Threshold encryption | Transaction ordering auctions to prevent MEV extraction; see [Encrypted Mempools](13-blockchain-distributed-ledger.md#encrypted-mempools-threshold-encryption-for-transaction-ordering) [[1]](https://eprint.iacr.org/2023/1063) |

**State of the art:** MPC-based auctions for high-value settings; threshold encryption auctions for blockchain MEV. Combines [MPC](06-multi-party-computation.md#multi-party-computation-mpc), [HE](#graph-encryption), and [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Mature
Danish sugar beet auction (2009) is the landmark real-world MPC deployment; MEV auctions actively explored in blockchain

**Implementations:**
- [aicis/fresco](https://github.com/aicis/fresco) ⭐ 141 — Java, MPC framework used in the Danish auction
- [partisia](https://partisia.com/) — Commercial MPC platform for auctions (Partisia Blockchain)

**Security status:** Secure
MPC-based protocols provably secure under standard assumptions; threshold encryption auctions secure if threshold uncompromised

**Community acceptance:** Niche
Danish sugar beet auction is the most cited real-world MPC success; MEV auction protocols gaining traction in Ethereum research

---

## Oblivious Polynomial Evaluation (OPE)

**Goal:** Private function evaluation for polynomials. Sender holds a polynomial P(x) of degree d; receiver holds a point x₀. Receiver learns P(x₀) and nothing else; sender learns nothing about x₀. Not to be confused with order-preserving encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Pinkas OPE** | 1999 | OT + polynomial | First efficient OPE from OT; sender's polynomial stays hidden [[1]](https://doi.org/10.1007/3-540-48405-1_8) |
| **OPE from Homomorphic Encryption** | 2006 | Paillier | Evaluate encrypted polynomial; additive HE suffices for poly eval [[1]](https://doi.org/10.1007/11681878_14) |
| **Batch OPE (Ghosh-Nilges)** | 2021 | VOLE | Batch evaluation of many points; amortized from VOLE [[1]](https://eprint.iacr.org/2021/1254) |

**State of the art:** VOLE-based batch OPE (2021); building block for [PSI](#private-set-intersection-psi), [OPRF](#oblivious-prf-oprf) constructions, and private equality testing. See [OLE/VOLE](#oblivious-polynomial-evaluation-ope).

**Production readiness:** Research
Used as building block in PSI and OPRF constructions; no standalone deployment

**Implementations:**
- [osu-crypto/libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, includes VOLE-based batch OPE

**Security status:** Secure
Provably secure under OT and homomorphic encryption assumptions

**Community acceptance:** Niche
Important building block but rarely deployed independently; academic focus on efficiency improvements

---

## Fuzzy Message Detection (FMD)

**Goal:** Detect your messages with tunable false positives. A server tests encrypted messages against your detection key — matches include your messages plus a controlled rate of false positives (cover traffic). Privacy degrades gracefully: more false positives = more privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Beck-Len-Miers-Green FMD** | 2021 | DDH / pairings | First FMD; tunable false-positive rate p via multi-key detection [[1]](https://eprint.iacr.org/2021/089) |
| **Multi-Server FMD** | 2025 | Distributed detection | Multiple servers hold detection key shares; threshold detection [[1]](https://eprint.iacr.org/2025/2072) |

**State of the art:** FMD (2021) for privacy-preserving message routing; extends [OMR](#oblivious-message-retrieval-omr) and [PIR](#private-information-retrieval-pir) with tunable privacy/bandwidth tradeoff. Proposed for Zcash.

**Production readiness:** Research
Proposed for Zcash but not yet deployed; academic prototypes only

**Implementations:**
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Zcash library exploring FMD integration

**Security status:** Secure
Based on DDH/pairings; privacy degrades gracefully with tunable false-positive rate

**Community acceptance:** Emerging
Active interest from Zcash and privacy-coin communities; novel privacy/bandwidth tradeoff space

---

## Graph Encryption

**Goal:** Outsource a graph database to an untrusted server and query it privately. The server evaluates encrypted graph queries (shortest path, subgraph matching, neighbor queries) without seeing the graph structure or query. Extends [Searchable Encryption](#searchable-encryption-sse-peks) to graph-structured data.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Kamara Structured Encryption** | 2010 | Symmetric encryption | General framework for encrypting data structures (graphs, matrices) with controlled leakage [[1]](https://eprint.iacr.org/2010/351) |
| **Ghosh-Kamara-Tamassia GES** | 2021 | Graph encryption | Graph encryption for shortest path queries; sublinear query time [[1]](https://eprint.iacr.org/2021/865) |
| **PathGES** | 2024 | GES + optimization | Efficient single-pair shortest path on encrypted graphs; logarithmic storage overhead [[1]](https://eprint.iacr.org/2024/845) |

**State of the art:** PathGES (2024); extends [SSE](#searchable-encryption-sse-peks) to relational/graph queries. Active area for encrypted databases.

**Production readiness:** Research
Academic prototypes; no production encrypted graph database deployments

**Implementations:**
- [OpenSSE/opensse-schemes](https://github.com/OpenSSE/opensse-schemes) ⭐ 99 — C++, includes structured encryption primitives for graphs

**Security status:** Caution
Inherits SSE leakage concerns; graph structure leakage possible through query patterns

**Community acceptance:** Niche
Active research area; extends SSE to graph-structured data; limited practical adoption

---

## Oblivious Automata / Branching Program Evaluation

**Goal:** Private pattern matching on private data. One party holds a private automaton (DFA, regex, decision tree); the other holds a private input string. They jointly evaluate whether the input is accepted — without revealing the automaton's structure or the input content. Applications: private virus scanning, DNA matching, regulatory compliance.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Troncoso-Pastoriza et al. Oblivious DFA** | 2007 | Garbled circuits | First practical oblivious DFA evaluation; private DNA searching; CCS 2007 [[1]](https://dl.acm.org/doi/10.1145/1315245.1315309) |
| **Ishai-Paskin Oblivious Branching Programs** | 2007 | HE + branching programs | Evaluate branching programs on encrypted data; output independent of program width; TCC 2007 [[1]](https://link.springer.com/chapter/10.1007/978-3-540-70936-7_31) |
| **Mohassel et al. Efficient Oblivious DFA** | 2012 | OT + garbled circuits | Optimized; O(n·|Q|) communication for DFA with |Q| states on length-n string [[1]](https://eprint.iacr.org/2011/434) |

**State of the art:** Mohassel et al. (2012) for practical DFA; Ishai-Paskin for branching programs. Related to [Garbled Circuits](06-multi-party-computation.md#garbled-circuits-expanded) and [PFE](#private-function-evaluation-pfe).

**Production readiness:** Research
Academic prototypes for private pattern matching; no commercial deployment

**Implementations:**
- [emp-toolkit/emp-sh2pc](https://github.com/emp-toolkit/emp-sh2pc) ⭐ 81 — C++, garbled circuit framework supporting DFA evaluation
- [samee/obliv-c](https://github.com/samee/obliv-c) ⭐ 184 — C, oblivious C compiler supporting branching programs

**Security status:** Secure
Based on garbled circuits and HE; provably secure under standard assumptions

**Community acceptance:** Niche
Limited to specialized applications (private DNA search, virus scanning); well-studied but narrow adoption

---

## Oblivious SQL / Encrypted Database Joins

**Goal:** Execute SQL operations on encrypted data without revealing queries or data to the server. Beyond keyword [SSE](#searchable-encryption-sse-peks): support joins, aggregations, GROUP BY, and range queries on fully encrypted relational databases while hiding access patterns.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CryptDB (Popa et al.)** | 2011 | Onion encryption layers | Layered encryption (RND→DET→OPE→HOM); peel layers as needed for SQL ops; SOSP 2011 [[1]](https://dl.acm.org/doi/10.1145/2043556.2043566) |
| **ObliDB (Eskandarian-Boneh)** | 2019 | ORAM + oblivious ops | Full oblivious query processing hiding access patterns for arbitrary SQL; VLDB [[1]](https://dl.acm.org/doi/10.14778/3364324.3364331) |
| **Opaque (Zheng-Dave-Beekman-Popa-Gonzalez-Stoica)** | 2017 | SGX + oblivious operators | Hardware-assisted encrypted SQL with oblivious operators; Spark integration [[1]](https://people.eecs.berkeley.edu/~wzheng/opaque.pdf) |

**State of the art:** ObliDB (2019) for full obliviousness; CryptDB for practical deployment; Opaque for hardware-assisted. Extends [ORAM](#oblivious-ram-oram), [SSE](#searchable-encryption-sse-peks), and [Graph Encryption](#graph-encryption).

**Production readiness:** Experimental
CryptDB deployed in research settings; Opaque demonstrated with Spark; ObliDB is a research prototype

**Implementations:**
- [CryptDB/CryptDB](https://github.com/CryptDB/CryptDB) ⭐ 521 — C++, encrypted SQL proxy
- [mc2-project/opaque](https://github.com/mc2-project/opaque) ⭐ 189 — Scala/C++, SGX-based encrypted SQL on Spark

**Security status:** Caution
CryptDB layered encryption leaks equality and order; ObliDB full obliviousness is stronger but slower; OPE layer deprecated

**Community acceptance:** Widely trusted
CryptDB highly cited (3000+ citations); influenced MongoDB Queryable Encryption; leakage tradeoffs well-understood

---

## Labeled PSI and Private Intersection-Sum (PSI-Sum)

**Goal:** PSI with associated payloads. Beyond finding matching elements, the receiver also learns a value (label) associated with each matched element, or only the sum of those values — all without the sender learning which elements matched. Used in ad-conversion measurement, fraud detection, and medical record linkage.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Private Intersection-Sum (Ion et al.)** | 2020 | Commutative encryption + additively HE | Each sender element carries an integer value; receiver learns intersection cardinality and sum of values but not individual matches; deployed in Google ad measurement [[1]](https://eprint.iacr.org/2019/723) |
| **Two-Sided Malicious PSI-Sum (Ghosh-Lepoint)** | 2021 | Homomorphic encryption + ZK | Maliciously secure PSI-Sum without semi-honest assumptions [[1]](https://eprint.iacr.org/2020/385) |
| **Labeled PSI from FHE (Chen et al.)** | 2021 | BFV FHE + OPRF | Unbalanced labeled PSI: client with small set retrieves values associated with matching elements from large server set; O(√|X|) HE multiplications; 85% communication reduction vs. prior work; CCS 2021 [[1]](https://eprint.iacr.org/2021/1116) |
| **Circuit-PSI with Linear Complexity (Chandran et al.)** | 2022 | OPPRF + garbled circuits | Compute arbitrary function over intersection items in MPC; linear communication via relaxed batch OPPRF [[1]](https://eprint.iacr.org/2021/034) |

**State of the art:** Labeled PSI from FHE (CCS 2021) for unbalanced settings; PSI-Sum (2020) deployed in privacy-preserving ad attribution. Extends [PSI](#private-set-intersection-psi) and [OKVS](#oblivious-key-value-store-okvs); complements [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation).

**Production readiness:** Production
PSI-Sum deployed in Google ad measurement; Labeled PSI prototypes available

**Implementations:**
- [google/private-join-and-compute](https://github.com/google/private-join-and-compute) ⭐ 850 — C++, Google PSI-Sum implementation
- [microsoft/APSI](https://github.com/microsoft/APSI) ⭐ 208 — C++, labeled PSI from Microsoft Research

**Security status:** Secure
Proven secure under standard assumptions (Paillier, BFV); malicious-security variants available (Ghosh-Lepoint 2021)

**Community acceptance:** Widely trusted
Deployed by Google for ad attribution; Microsoft APSI actively maintained; strong peer review at CCS and EUROCRYPT

---

## Volume-Hiding Searchable Encryption (Encrypted Multi-Maps)

**Goal:** Suppress volume leakage in SSE. Standard SSE reveals the number of documents matching each query keyword (the "volume"), enabling leakage-abuse attacks that reconstruct the dataset. Volume-hiding encrypted multi-maps (EMMs) pad or obfuscate response sizes so the server learns nothing beyond the fact that a query was made.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kamara-Moataz Volume-Hiding EMM** | 2019 | PRF + padding | Introduced volume-hiding EMMs; pads each response to maximum volume ℓ; O(ℓ) query overhead [[1]](https://eprint.iacr.org/2019/1292) |
| **Dynamic Volume-Hiding EMM (Patel et al.)** | 2021 | Dense Subgraph Transform | Supports updates with forward and backward privacy while hiding volume; O(ℓ log n) overhead [[1]](https://eprint.iacr.org/2021/765) |
| **XorMM (Patel-Persiano-Yeo-Yung)** | 2022 | XOR-based EMM | Optimal query communication: client receives exactly ℓ results, zero data loss; 1.23n storage, 76% storage savings vs. prior work; CCS 2022 [[1]](https://dl.acm.org/doi/10.1145/3548606.3559345) |

**State of the art:** XorMM (CCS 2022) for optimal overhead; Dynamic VH-EMM (2021) for updatable datasets. Addresses the primary practical attack surface against deployed [Searchable Encryption](#searchable-encryption-sse-peks).

**Production readiness:** Research
Academic prototypes; not yet integrated into production encrypted database systems

**Implementations:**
- [OpenSSE/opensse-schemes](https://github.com/OpenSSE/opensse-schemes) ⭐ 99 — C++, SSE research implementations

**Security status:** Secure
XorMM provably hides volume leakage; security reduces to PRF assumptions

**Community acceptance:** Emerging
CCS 2022 (XorMM); addresses critical leakage-abuse attack surface; expected to influence next-generation encrypted databases

---

## Shuffle Model of Differential Privacy

**Goal:** A middle ground between central and local DP. In the local model, each user randomizes their own data locally (strong privacy, poor accuracy). In the central model, a trusted curator adds noise to aggregate results (best accuracy, requires trust). The shuffle model uses an anonymous shuffler to break linkability, allowing local randomizers with small ε to achieve central-DP-level accuracy — without any trusted server.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Prochlo / ESA (Bittau et al.)** | 2017 | SGX-based oblivious shuffler + local DP | First Encode-Shuffle-Analyze system; uses Intel SGX for the shuffler; SOSP 2017 [[1]](https://dl.acm.org/doi/10.1145/3132747.3132769) |
| **Cheu-Smith-Ullman-Zeber-Zhilyaev** | 2019 | Shuffle model formalization | First rigorous definition; shows single-message protocols in shuffle model can achieve ε = O(1/√n) from locally ε-DP data; EUROCRYPT 2019 [[1]](https://eprint.iacr.org/2018/1282) |
| **Privacy Blanket (Balle-Bell-Gascón-Nissim)** | 2019 | Amplification by shuffling | Quantifies the privacy amplification: local ε₀-DP + shuffling → (ε, δ)-DP with ε = O(ε₀√(log(1/δ)/n)); CRYPTO 2019 [[1]](https://arxiv.org/abs/1903.02837) |
| **Feldman-McMillan-Talwar Hiding Among Clones** | 2021 | Poisson-subsampling analysis | Near-optimal amplification analysis; nearly tight bounds for practical parameters [[1]](https://arxiv.org/abs/2012.12803) |

**State of the art:** Privacy Blanket / Feldman et al. amplification bounds underpin all shuffle-model deployments; Prochlo in production at Google. Positioned between [Differential Privacy](#differential-privacy) (local DP row) and central DP; complements [Private Heavy Hitters](#private-heavy-hitters-frequency-estimation) and [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation).

**Production readiness:** Production
Prochlo deployed at Google; shuffle-model amplification used in Apple and Google telemetry pipelines

**Implementations:**
- [google/differential-privacy](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, includes shuffle-model utilities

**Security status:** Secure
Rigorous amplification bounds (Privacy Blanket, Feldman et al.); security requires honest-but-curious shuffler

**Community acceptance:** Widely trusted
EUROCRYPT/CRYPTO publications; adopted by Google and Apple; bridges local and central DP with formal guarantees

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

**Production readiness:** Production
DP-SGD via Opacus (Meta) and TF-Privacy (Google) widely used in industry; Gboard on-device models trained with DP-SGD

**Implementations:**
- [pytorch/opacus](https://github.com/pytorch/opacus) ⭐ 1.9k — Python, Meta production DP-SGD for PyTorch
- [tensorflow/privacy](https://github.com/tensorflow/privacy) ⭐ 2.0k — Python, Google DP-SGD for TensorFlow
- [lxuechen/private-transformers](https://github.com/lxuechen/private-transformers) ⭐ 185 — Python, DP fine-tuning for transformers

**Security status:** Secure
Formal (epsilon, delta)-DP guarantees via moments/Renyi accountant; requires correct gradient clipping and noise calibration

**Community acceptance:** Widely trusted
CCS 2016 (DP-SGD), ICLR 2017 (PATE); Opacus and TF-Privacy are industry standards; Apple and Google deploy at scale

---

## Advanced Single-Server PIR (OnionPIR / Spiral)

**Goal:** Practical single-server PIR with near-optimal communication and high server throughput. Goes beyond SealPIR's BFV-only approach by composing multiple lattice-based schemes (Regev + GSW) to simultaneously shrink query size, response size, and computation — making single-server PIR viable for real deployments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OnionPIR (Mughees-Chen-Ren)** | 2021 | BFV + RGSW; copy-network oblivious evaluation | Response overhead 4.2× over insecure baseline vs. ~100× for prior schemes; CCS 2021 [[1]](https://eprint.iacr.org/2021/1081) |
| **Spiral (Menon-Wu)** | 2022 | Regev + GSW FHE composition | 4.5× smaller queries, 1.5× smaller responses, 2× higher server throughput than OnionPIR; SpiralStream variant achieves 1.5 GB/s throughput and 0.49 rate; IEEE S&P 2022 [[1]](https://eprint.iacr.org/2022/368) |
| **OnionPIRv2 (Mughees et al.)** | 2025 | Improved BFV+RGSW composition | Further reduces response overhead; closes gap with Spiral in communication [[1]](https://eprint.iacr.org/2025/1142) |

**State of the art:** Spiral (2022) is the current throughput leader for single-server PIR; SimplePIR/DoublePIR (covered in [PIR](#private-information-retrieval-pir)) leads on latency with LWE. OnionPIR/Spiral are preferred when response size is the bottleneck (streaming applications).

**Production readiness:** Experimental
Spiral has a live demo (spiralwiki.com); research implementations available; not yet in production systems

**Implementations:**
- [menonsamir/spiral-rs](https://github.com/menonsamir/spiral-rs) ⭐ 15 — Rust, Spiral PIR implementation

**Security status:** Secure
Based on RLWE/GSW lattice assumptions; same security foundation as standard FHE

**Community acceptance:** Emerging
IEEE S&P 2022 (Spiral), CCS 2021 (OnionPIR); represents the practical frontier of single-server PIR

---

## Conditional Disclosure of Secrets (CDS)

**Goal:** Predicate-gated secret release. Two parties each hold an input (x, y) and a referee holds a secret s. The secret s is revealed if and only if f(x, y) = 1 — with minimal communication. A fundamental building block for more complex protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gertner-Ishai-Kushilevitz-Malkin CDS** | 2000 | Secret sharing | First CDS formalization; connections to secret sharing and OT [[1]](https://doi.org/10.1007/3-540-44598-6_3) |
| **CDS for General Predicates** | 2014 | Branching programs | CDS for any predicate computable by branching programs [[1]](https://eprint.iacr.org/2014/213) |
| **Attribute-Based CDS** | 2017 | LWE / pairings | CDS with policies on attributes; connects to ABE [[1]](https://eprint.iacr.org/2017/614) |
| **CDS with Reusable Setup** | 2020 | DDH | Amortized: one setup, many CDS instances [[1]](https://eprint.iacr.org/2020/431) |

**State of the art:** CDS from standard assumptions (DDH/LWE); building block for [PSI](#private-set-intersection-psi), [OT extension](#oblivious-ram-oram), and [Garbled Circuits](06-multi-party-computation.md#garbled-circuits-expanded).

**Production readiness:** Research
Theoretical building block; no standalone deployment

**Implementations:**
- [emp-toolkit/emp-sh2pc](https://github.com/emp-toolkit/emp-sh2pc) ⭐ 81 — C++, MPC framework that can implement CDS protocols

**Security status:** Secure
Provably secure under DDH and LWE; well-established theoretical foundations

**Community acceptance:** Niche
Important theoretical primitive; connections to secret sharing and OT well-studied; limited direct practical use

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

**Production readiness:** Production
GAEN deployed on 3B+ devices in 60+ countries; DP-3T implemented in multiple national apps

**Implementations:**
- [google/exposure-notifications-android](https://github.com/google/exposure-notifications-android) ⭐ 529 — Java, Google Exposure Notifications reference
- [DP-3T/dp3t-sdk-android](https://github.com/DP-3T/dp3t-sdk-android) ⭐ 239 — Kotlin, DP-3T Android SDK
- [DP-3T/dp3t-sdk-ios](https://github.com/DP-3T/dp3t-sdk-ios) ⭐ 150 — Swift, DP-3T iOS SDK

**Security status:** Secure
Rolling Proximity Identifiers derived via HKDF; relay attacks mitigated by time windows; no central contact graph

**Community acceptance:** Standard
Apple/Google OS-level integration; EPFL/ETH Zurich design; largest privacy-preserving public health deployment ever

---

## Laconic OT and Laconic Cryptography

**Goal:** Sublinear-communication oblivious transfer and related protocols. In standard OT, communication scales with the sender's database size. Laconic OT compresses the receiver's input (a large set or database) into a short digest; the sender then sends a single short message per OT instance, achieving communication independent of the receiver's input size. Enables private database queries with server-optimal communication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Laconic OT (Cho-Döttling-Garg-Gupta-Miao-Mukherjee)** | 2017 | CDH + hash-and-garble | First laconic OT; receiver compresses n-bit string into O(λ) digest; sender sends O(1) per bit; bootstraps from 2-round PIR [[1]](https://eprint.iacr.org/2017/1155) |
| **Laconic OT from CDH (Döttling-Garg)** | 2017 | CDH | Simpler construction; O(1) rounds; enables 2-round MPC with CDH [[1]](https://eprint.iacr.org/2017/585) |
| **Laconic Private Set Intersection (Döttling et al.)** | 2020 | Laconic OT + OKVS | PSI where sender's message size is independent of receiver's set; enables cloud-optimal PSI [[1]](https://eprint.iacr.org/2019/1256) |
| **Laconic Function Evaluation (LFE)** | 2022 | Laconic OT + garbling | Generalization: evaluate any circuit C on sender's input x where the digest encodes C; communication O(|x|) independent of |C| [[1]](https://eprint.iacr.org/2022/1614) |

**State of the art:** Laconic OT (2017) is the foundational primitive; LFE (2022) is the most general form. Laconic cryptography is related to [Oblivious Transfer](#oblivious-ram-oram) (in `06-multi-party-computation.md`) and complements [PIR](#private-information-retrieval-pir) by reversing which party has the large input. See also [Laconic Cryptography](16-obfuscation-advanced-hardness.md#laconic-cryptography) in the obfuscation category.

**Production readiness:** Research
Theoretical constructions; no production implementations

**Implementations:**
- [emp-toolkit/emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, OT framework (standard OT; laconic OT not yet in major libraries)

**Security status:** Secure
Proven secure under CDH in the random oracle model; well-established theoretical foundations

**Community acceptance:** Niche
Important theoretical contribution (CRYPTO 2017); enables 2-round MPC; limited practical implementations

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

**Production readiness:** Experimental
Piano has research implementation; OKVS-based keyword PIR demonstrated; exploring use for private DNS

**Implementations:**
- [microsoft/SealPIR](https://github.com/microsoft/SealPIR) ⭐ 156 — C++, base PIR used in keyword PIR constructions

**Security status:** Secure
Security reduces to underlying PIR and OKVS schemes; LWE-based (Piano)

**Community acceptance:** Emerging
IEEE S&P 2024 (Piano); active research for private DNS resolution and PKI lookups

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

**Production readiness:** Production
Signal private contact discovery deployed at scale; Apple PSI for iMessage in production

**Implementations:**
- [microsoft/APSI](https://github.com/microsoft/APSI) ⭐ 208 — C++, asymmetric/unbalanced PSI from Microsoft
- [signalapp/ContactDiscoveryService](https://github.com/signalapp/ContactDiscoveryService) ⭐ 282 [archived] — Java, Signal SGX-based contact discovery

**Security status:** Secure
FHE-based variants proven under RLWE; SGX-based variants rely on hardware trust assumptions

**Community acceptance:** Widely trusted
Signal deployment is the gold standard; Microsoft APSI actively maintained; CCS 2021 peer review

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

**State of the art:** PEGASUS (2021) for fast ReLU via scheme switching; GAZELLE hybrid approach for practical CNNs; Iron/HELiKs for transformer models. Complements [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd-pate) (privacy during training) by providing privacy during inference. Relies on [Homomorphic Encryption](07-homomorphic-functional-encryption.md#homomorphic-encryption-he) and [zkML](17-ai-hardware-physical-security.md#zkllm-verifiable-ai-inference) (for verifiable inference).

**Production readiness:** Experimental
Research implementations with practical benchmarks; Microsoft SEAL powers CryptoNets; no mass consumer deployment

**Implementations:**
- [microsoft/SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, Microsoft SEAL HE library (BFV/CKKS)
- [openfheorg/openfhe-development](https://github.com/openfheorg/openfhe-development) ⭐ 1.1k — C++, OpenFHE with CKKS/FHEW for ML
- [zama-ai/concrete-ml](https://github.com/zama-ai/concrete-ml) ⭐ 1.4k — Python, ML on encrypted data using Zama FHE compiler

**Security status:** Secure
Based on RLWE/LWE (CKKS, BFV, FHEW); security inherits from well-studied lattice assumptions

**Community acceptance:** Emerging
Active research area; ICML/CCS/IEEE S&P publications; Microsoft, Zama, Intel investing heavily; not yet standardized

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

**State of the art:** AIM (McKenna et al., 2022) leads for tabular/statistical data; DP-MERF avoids GAN instability; PATE-GAN for image-like data. All rely on [Differential Privacy](#differential-privacy) mechanisms and extend [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd-pate) to generative models.

**Production readiness:** Experimental
AIM won NIST DP Synthetic Data Competition; Tumult and NIST actively exploring; limited production deployments

**Implementations:**
- [ryan112358/private-pgm](https://github.com/ryan112358/private-pgm) ⭐ 113 — Python, AIM/Private-PGM for DP synthetic data
- [opendp/smartnoise-sdk](https://github.com/opendp/smartnoise-sdk) ⭐ 296 — Python, SmartNoise SDK including DP synthetic data

**Security status:** Secure
Formal (epsilon, delta)-DP guarantees; privacy depends on correct noise calibration and accounting

**Community acceptance:** Emerging
NIST DP Synthetic Data Competition driving standardization; growing regulatory interest; AIM is current benchmark

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

**State of the art:** TensorFlow Federated (production at Google), Flower (research standard); both support DP and SecAgg. Privacy relies on [Differential Privacy](#differential-privacy), [Secure Aggregation](06-multi-party-computation.md#secure-aggregation-secagg), and [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd-pate).

**Production readiness:** Production
TensorFlow Federated deployed for Google Keyboard (Gboard); Flower widely used in research; PySyft for enterprise

**Implementations:**
- [tensorflow/federated](https://github.com/tensorflow/federated) ⭐ 2.4k — Python, Google TensorFlow Federated
- [adap/flower](https://github.com/adap/flower) ⭐ 6.8k — Python, framework-agnostic federated learning
- [OpenMined/PySyft](https://github.com/OpenMined/PySyft) ⭐ 9.9k — Python, privacy-preserving ML with MPC/HE

**Security status:** Caution
Gradient inversion attacks possible without DP/SecAgg; secure when combined with DP-SGD and secure aggregation

**Community acceptance:** Widely trusted
Deployed by Google, Apple; Flower and TFF are community standards; active PPML workshop series at NeurIPS/ICML

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

**State of the art:** CrypTen (Meta, production-oriented 2-party/N-party); Piranha (GPU-accelerated 3PC); ELSA (communication-efficient 2PC inference). Builds on [MPC](06-multi-party-computation.md#multi-party-computation-mpc), [Garbled Circuits](06-multi-party-computation.md#garbled-circuits-expanded), and [OLE/VOLE](06-multi-party-computation.md#oblivious-linear-evaluation-ole-vole). Complements [HE for ML Inference](#homomorphic-encryption-for-ml-inference-cryptonets) (HE-only path) and [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd-pate) (DP path).

**Production readiness:** Experimental
CrypTen open-sourced by Meta; Piranha and ELSA are research prototypes with practical benchmarks

**Implementations:**
- [facebookresearch/CrypTen](https://github.com/facebookresearch/CrypTen) ⭐ 1.6k — Python, Meta MPC framework for ML
- [encryptogroup/MOTION](https://github.com/encryptogroup/MOTION) ⭐ 90 — C++, MOTION2NX MPC framework

**Security status:** Secure
Based on secret sharing (SPDZ) and garbled circuits; provably secure under standard MPC assumptions

**Community acceptance:** Emerging
Meta (CrypTen), USENIX Security (Piranha), IEEE S&P (ELSA); growing adoption but not yet mainstream

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

**Production readiness:** Research
Academic prototypes; driven by demand for private RAG and biometric matching but no production deployments

**Implementations:**
- [menonsamir/spiral-rs](https://github.com/menonsamir/spiral-rs) ⭐ 15 — Rust, Spiral PIR used as building block for ANN-PIR

**Security status:** Secure
HADES provides full obliviousness via ORAM; NN-PIR provides query privacy only; security depends on chosen primitive

**Community acceptance:** Emerging
CCS 2024 (HADES); driven by private retrieval-augmented generation (RAG) demand; rapidly growing research area

---

## Private Equality Testing (PET)

**Goal:** Two parties each hold a private value; they want to learn whether their values are equal — and nothing else. Stronger than PSI (which reveals the matching element): PET reveals only a single bit (equal or not). Used in threshold signature coordination, duplicate detection, and identity verification without exposing the value itself.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DH-Based PET (Meadows)** | 1986 | DDH | Commit-and-compare using Diffie-Hellman; O(1) rounds; semi-honest [[1]](https://link.springer.com/chapter/10.1007/3-540-39799-X_16) |
| **Maliciously Secure PET (Jarecki-Liu)** | 2009 | OPRF + ZK proofs | UC-secure PET; uses OPRF so neither party learns the other's value on inequality; ACM CCS 2009 [[1]](https://eprint.iacr.org/2009/600) |
| **Batch PET from VOLE (Rindal et al.)** | 2021 | VOLE + hashing | Amortize many equality tests using VOLE; O(n) communication for n tests; building block for multi-query PSI [[1]](https://eprint.iacr.org/2021/026) |
| **PET for Threshold Signatures (SPRINT)** | 2023 | PET + threshold ECDSA | Use private equality testing to check shares match without reconstruction; applied in asynchronous threshold signing; ACM CCS 2023 [[1]](https://eprint.iacr.org/2023/427) |

**State of the art:** Batch PET from VOLE (2021) for high-throughput equality testing; UC-secure PET (Jarecki-Liu) when malicious security is required. Closely related to [PSI](#private-set-intersection-psi) (equality at scale) and [OPRF](#oblivious-prf-oprf) (the key building block); useful in [Threshold Signatures](08-signatures-advanced.md#threshold-signature-schemes-tss) and [Secret Sharing](05-secret-sharing-threshold-cryptography.md#secret-sharing-schemes-sss).

**Production readiness:** Mature
Used as building block in threshold signature protocols (SPRINT) and PSI; batch PET from VOLE in research systems

**Implementations:**
- [osu-crypto/libOTe](https://github.com/osu-crypto/libOTe) ⭐ 492 — C++, VOLE framework supporting batch PET
- [emp-toolkit/emp-ot](https://github.com/emp-toolkit/emp-ot) ⭐ 183 — C++, OT-based equality testing primitives

**Security status:** Secure
DH-based PET secure under DDH; UC-secure PET (Jarecki-Liu) in the universal composability framework

**Community acceptance:** Widely trusted
Foundational primitive since 1986; used in CCS 2023 (SPRINT threshold ECDSA); well-understood security properties

---

## OT-Extension-Based PSI (KKRT16 / RR21)

**Goal:** High-throughput PSI using OT extension rather than public-key OPRF. The Kolesnikov-Kumaresan-Rosulek-Trieu (KKRT16) and Rindal-Rosulek (RR21) protocols replace expensive elliptic-curve OPRF evaluations with cheap symmetric-key OT-extension operations, achieving 10–100× higher throughput on large sets. The core idea is to encode each set element as a pseudorandom correlation obtained via OT extension, then match correlations using a hash table — all with only symmetric crypto after a small base-OT phase.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **KKRT16 (Kolesnikov-Kumaresan-Rosulek-Trieu)** | 2016 | OT extension + cuckoo hashing | First OT-based PSI competitive with DH; 3-party-hash cuckoo table; ~2 million items/second semi-honest; CCS 2016 [[1]](https://eprint.iacr.org/2016/799) |
| **Phasing PSI (Pinkas-Schneider-Tkachenko-Yanai)** | 2019 | OT extension + phased hashing | Batched OPRF via OT extension; reduces communication to 1.3 bits/item for billion-scale sets; USENIX Sec 2019 [[1]](https://eprint.iacr.org/2019/241) |
| **RR21 (Rindal-Rosulek)** | 2021 | OT extension + OKVS | Replace hash tables with OKVS; achieves optimal linear communication; 30% fewer OTs than KKRT16; IEEE S&P 2021 [[1]](https://eprint.iacr.org/2021/034) |
| **Blazing Fast PSI from VOLE (Rindal-Schoppmann)** | 2021 | VOLE + hashing | Reduce base OT count using VOLE correlations; sublinear setup for large N; ACM CCS 2021 [[1]](https://eprint.iacr.org/2021/262) |

**State of the art:** RR21 (optimal linear communication) and Phasing PSI (billion-scale deployments); both supersede DH-based and pure public-key OPRF approaches on throughput. Relies on [OT Extension](06-multi-party-computation.md#oblivious-transfer-ot) and [OKVS](#oblivious-key-value-store-okvs); semi-honest security — combine with IKNP/ALSZ for malicious setting. Complements [Unbalanced PSI](#unbalanced-psi-client-server-psi-at-scale) and [Labeled PSI](#labeled-psi-and-private-intersection-sum-psi-sum).

**Production readiness:** Mature
Implemented in major PSI libraries; used for billion-scale PSI in research and industry benchmarks

**Implementations:**
- [osu-crypto/libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, includes KKRT16 and RR21 implementations
- [Visa-Research/volepsi](https://github.com/Visa-Research/volepsi) ⭐ 135 [archived] — C++, VOLE-based PSI (builds on RR21)

**Security status:** Secure
Semi-honest security; provably secure under random oracle model; combine with IKNP/ALSZ for malicious security

**Community acceptance:** Widely trusted
CCS 2016, IEEE S&P 2021; de facto standard for high-throughput PSI; implemented in all major PSI libraries

---

## Privacy-Preserving Disease Surveillance (DP Epidemiology)

**Goal:** Aggregate epidemiological signals — infection counts, contact rates, symptom prevalence — from sensitive health records without exposing individual health status. Formal differential privacy guarantees allow publishing aggregate statistics for public health response while bounding re-identification risk. Complements [Privacy-Preserving Contact Tracing](#privacy-preserving-contact-tracing-gaen-dp-3t) (individual exposure notifications) by operating at the population level.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DP Surveillance (Dwork-Kohli-Mulligan)** | 2019 | Gaussian + Laplace DP | Framework for DP disease reporting: daily incidence, prevalence, mortality with (ε,δ)-DP; theoretical analysis of utility-privacy tradeoffs for CDC-style reporting [[1]](https://arxiv.org/abs/1909.01524) |
| **RAPPOR Epidemiology (Apple / Google)** | 2020 | Local DP + shuffle model | Aggregate symptom frequencies from iOS/Android devices for COVID-19 surveillance; local DP at device, shuffle amplification in transit; deployed at scale [[1]](https://arxiv.org/abs/2005.11521) |
| **Tumult Analytics (Tumult Labs)** | 2022 | zCDP + sensitivity analysis | Open-source DP pipeline for public health agencies; automatic sensitivity calibration for SQL-like queries; used by several US state health departments [[1]](https://arxiv.org/abs/2212.04133) |
| **PGM + DP for Syndromic Surveillance** | 2022 | Graphical models + Laplace | Privately fit probabilistic graphical models to weekly syndromic surveillance data; enables DP release of joint symptom distributions [[1]](https://eprint.iacr.org/2022/1508) |
| **SMCQL / Shrinkwrap** | 2017/2019 | MPC + oblivious ops | Multi-party SQL over federated clinical databases; Shrinkwrap (2019) adds DP noise in the MPC to suppress cardinality leakage; used in distributed hospital networks [[1]](https://dl.acm.org/doi/10.14778/3137628.3137715) [[2]](https://dl.acm.org/doi/10.14778/3311880.3311883) |

**State of the art:** Tumult Analytics (production DP pipeline) and Shrinkwrap (MPC + DP for federated queries) are the deployed solutions; RAPPOR-based mobile aggregation at population scale. Combines [Differential Privacy](#differential-privacy), [Shuffle Model](#shuffle-model-of-differential-privacy), and [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation) for verifiable aggregation.

**Production readiness:** Production
Tumult Analytics deployed by US state health departments; Apple/Google RAPPOR-based surveillance at population scale

**Implementations:**
- [tumult-labs/tumult-analytics](https://gitlab.com/tumult-labs/analytics) — Python, production DP analytics for public health
- [smcql/smcql](https://github.com/smcql/smcql) ⭐ 57 — Java, multi-party SQL for federated clinical databases
- [google/differential-privacy](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, general DP library used in surveillance

**Security status:** Secure
Formal (epsilon, delta)-DP guarantees; MPC-based variants (Shrinkwrap) add access-pattern protection

**Community acceptance:** Emerging
COVID-19 accelerated adoption; Tumult used by government agencies; growing regulatory mandate for privacy in public health data

---

## Continual-Release Differential Privacy (Private Streaming Algorithms)

**Goal:** Answer statistical queries over a data stream while releasing up to-date differentially private results at each time step. Unlike one-shot DP (a single query on a static dataset), the continual release model allows an adversary to observe all published outputs over time — making naive repeated application of DP mechanisms fail due to composition. Core challenge: achieve DP over T time steps with error growing as O(log² T) rather than O(T).

| Mechanism | Year | Basis | Note |
|-----------|------|-------|------|
| **Dwork-Naor-Pitassi-Rothblum Continual DP** | 2010 | Binary tree mechanism | Foundational: partition the stream into a binary tree of partial sums; add Laplace noise at each node; error O(log² T); STOC 2010 [[1]](https://dl.acm.org/doi/10.1145/1806689.1806787) |
| **Chan-Shi-Song Streaming DP** | 2011 | Smooth sensitivity + binary tree | Independent concurrent work; near-identical error bounds; extended to event-level and user-level DP; ITCS 2011 [[1]](https://arxiv.org/abs/1010.3463) |
| **Honaker Streaming Mechanism** | 2015 | Matrix factorization + DP | Optimal noise allocation for streaming counting queries via matrix mechanism; reduces error by 64% over binary tree [[1]](https://arxiv.org/abs/1405.0823) |
| **Private Heavy Hitters over Streams (PrivKVM)** | 2019 | LDP + key-value stream | Locally differentially private heavy-hitter detection over event streams with memoization; used in Apple iOS analytics [[1]](https://www.usenix.org/conference/usenixsecurity19/presentation/ding) |
| **DP Histograms over Sliding Windows** | 2022 | Exponential mechanism + streaming | DP frequency estimates over the most-recent w items without storing the full window; Polylog(w) error; DP-FOCS 2022 [[1]](https://arxiv.org/abs/2206.08397) |

**State of the art:** Binary tree / Honaker mechanism for counting queries; PrivKVM (Apple production) for streaming heavy hitters. Distinct from [Private Stream Aggregation](#private-stream-aggregation-psa) (multi-party one-shot) and [Private Heavy Hitters](#private-heavy-hitters-frequency-estimation) (static dataset). Extends [Differential Privacy](#differential-privacy) to the streaming/continual-observation setting fundamental to telemetry and sensor data.

**Production readiness:** Production
PrivKVM deployed in Apple iOS analytics; binary tree mechanism implemented in DP libraries

**Implementations:**
- [google/differential-privacy](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, includes streaming DP mechanisms
- [opendp/opendp](https://github.com/opendp/opendp) ⭐ 412 — Rust/Python, OpenDP framework with streaming support

**Security status:** Secure
Formal DP guarantees over T time steps; error O(log^2 T) via binary tree mechanism

**Community acceptance:** Widely trusted
STOC 2010 foundational; Apple production deployment (PrivKVM); well-studied composition bounds

---

## Privacy-Preserving Location Services (Geo-Fencing / Trajectory Privacy)

**Goal:** Enable location-based services — geo-fencing, Points-of-Interest queries, ride-matching, proximity alerts — without revealing users' precise coordinates to the service provider. Goes beyond [Private Proximity Testing](#private-proximity-testing) (two-party, single check) to server-side databases of locations, trajectories, and regions with continuous or repeated queries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Casper (Mokbel et al.)** | 2006 | k-anonymity + spatial cloaking | Cloak user location into a k-anonymous region before querying a Location-Based Service; VLDB 2006 [[1]](https://dl.acm.org/doi/10.1145/1182635.1164153) |
| **GeoIndistinguishability (Andres et al.)** | 2013 | Planar Laplace mechanism (DP on metric spaces) | Formal DP for location: add calibrated planar noise so nearby locations are indistinguishable; privacy radius r at cost ε; CCS 2013 [[1]](https://dl.acm.org/doi/10.1145/2508859.2516735) |
| **Private Geo-Fence (Chow-Mokbel)** | 2011 | HE + spatial hashing | Client checks whether its location falls inside a private fence polygon without learning the fence or revealing coordinates; VLDB 2011 [[1]](https://dl.acm.org/doi/10.14778/2095686.2095693) |
| **DP Trajectory Publishing (NGRAM)** | 2016 | Differential privacy + Markov chain | Publish synthetic GPS trajectory datasets with (ε,δ)-DP; models transition probabilities with DP-noised n-grams; SIGMOD 2016 [[1]](https://dl.acm.org/doi/10.1145/2882903.2882934) |
| **Ride-Matching via PSI (Koi et al.)** | 2021 | Unbalanced PSI + location encoding | Match riders and drivers on encrypted grid cells using PSI; neither party reveals precise location unless match found [[1]](https://eprint.iacr.org/2021/790) |
| **LPPM + DP for Mobility (Shokri et al.)** | 2017 | Location Privacy Protection Mechanism | Optimal location obfuscation under DP constraints using linear programming; end-to-end pipeline for mobile apps; IEEE S&P 2017 [[1]](https://ieeexplore.ieee.org/document/7958595) |

**State of the art:** GeoIndistinguishability (principled DP for location, widely adopted in literature and production); DP trajectory publishing for dataset release; PSI-based ride-matching for server-side geo-fencing. Extends [Differential Privacy](#differential-privacy) and [Private Proximity Testing](#private-proximity-testing) to continuous and server-side location query settings. Relevant to [ODoH](#oblivious-dns-odoh) for DNS-based location inference.

**Production readiness:** Mature
GeoIndistinguishability implemented in research and mobile apps; DP trajectory publishing used in urban planning

**Implementations:**
- [google/differential-privacy](https://github.com/google/differential-privacy) ⭐ 3.3k — C++/Java/Go, general DP library applicable to location

**Security status:** Caution
GeoIndistinguishability provides formal DP for location; k-anonymity (Casper) alone insufficient; trajectory correlation attacks possible

**Community acceptance:** Widely trusted
CCS 2013 (GeoIndistinguishability) widely cited; adopted in location privacy literature; regulatory interest (GDPR location data)

---

## Differential Privacy Auditing and Verification

**Goal:** Verify that a claimed differentially private mechanism actually satisfies its stated (ε, δ) guarantee — either by statistical black-box testing, formal analysis, or hybrid methods. Critical for catching implementation bugs (insufficient gradient clipping, incorrect sensitivity calculations) and for regulatory compliance. Complements DP theory by providing empirical and formal correctness assurance.

| Tool / Method | Year | Basis | Note |
|---------------|------|-------|------|
| **DP Finder (Bichsel et al.)** | 2018 | Optimization-based testing | Black-box: search for adjacent-input pairs maximizing empirical privacy loss; PLDI 2018 [[1]](https://dl.acm.org/doi/10.1145/3192366.3192411) |
| **StatDP (Ding-Wang-Wang)** | 2019 | Hypothesis testing | Statistical audit: run the mechanism many times on adjacent inputs; detect DP violations via Neyman-Pearson tests; IEEE S&P 2019 [[1]](https://ieeexplore.ieee.org/document/8835364) |
| **DP Opt (Barthe et al.)** | 2020 | Program analysis + coupling | Formal: use probabilistic couplings and relational logic to prove (ε,δ)-DP for programs; extension of RelativeEpsilonDP [[1]](https://arxiv.org/abs/2001.11481) |
| **Autodp (Wang et al.)** | 2019 | Rényi DP + moment accounting | Automated composition accounting: compute tight (ε,δ) from a sequence of mechanisms via Rényi DP moments; Python library [[1]](https://github.com/yuxiangw/autodp) |
| **PRV Accountant (Gopi et al.)** | 2021 | Privacy Random Variables | Numeric Fourier accountant: compute tight (ε,δ) via characteristic functions of privacy-loss RVs; 1000× tighter than moments accountant for large ε; ICML 2021 [[1]](https://arxiv.org/abs/2106.08567) |
| **DP-Sniper (Bichsel et al.)** | 2021 | Neural classifier + likelihood ratio | ML-assisted black-box DP audit: train classifier to distinguish adjacent-input outputs; reports lower bound on ε; USENIX Sec 2021 [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/bichsel) |

**State of the art:** PRV Accountant (tightest composition, adopted in Opacus/TF-Privacy); DP-Sniper for black-box empirical auditing; StatDP for statistical violation detection. Underpins trust in [DP-SGD/PATE](#differentially-private-machine-learning-dp-sgd-pate), [Shuffle Model DP](#shuffle-model-of-differential-privacy), and all deployed [Differential Privacy](#differential-privacy) systems.

**Production readiness:** Mature
Autodp and PRV Accountant integrated into Opacus/TF-Privacy; StatDP and DP-Sniper used for empirical testing

**Implementations:**
- [yuxiangw/autodp](https://github.com/yuxiangw/autodp) ⭐ 279 — Python, automated DP composition accounting
- [microsoft/prv_accountant](https://github.com/microsoft/prv_accountant) ⭐ 76 — Python, PRV Accountant for tight (epsilon, delta) bounds
- [eth-sri/dp-sniper](https://github.com/eth-sri/dp-sniper) ⭐ 23 — Python, ML-based black-box DP auditing
- [cmla/statdp](https://github.com/cmla-psu/statdp) ⭐ 28 — Python, statistical DP violation detection

**Security status:** Secure
Auditing tools are verification aids; PRV Accountant provides provably tight composition bounds

**Community acceptance:** Widely trusted
PRV Accountant adopted in Opacus/TF-Privacy; USENIX Sec 2021 (DP-Sniper); essential for DP deployment correctness

---

## DPF-Based Private Information Retrieval

**Goal:** Build efficient 2-server PIR from distributed point functions (DPFs). A DPF lets a client split a point function (f(x*)=1, f(x)=0 elsewhere) into two keys such that neither key reveals x*. For PIR, the client generates DPF keys encoding the desired index; each server evaluates the DPF over the database and returns the result. Communication is sublinear, and computation is simple XOR and PRG operations -- no public-key crypto needed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Gilboa-Ishai DPF** | 2014 | PRG-based | Foundational DPF construction; O(lambda) key size for point functions over {0,1}^n; enables 2-server PIR with log(n) communication [[1]](https://dl.acm.org/doi/10.1007/978-3-662-46800-5_26) |
| **Boyle-Gilboa-Ishai Function Secret Sharing** | 2015 | PRG tree | Generalized DPF to function secret sharing (FSS); supports intervals, decision trees; enables richer 2-server computations beyond point queries [[1]](https://eprint.iacr.org/2015/879) |
| **Incremental DPF (Boneh-Boyle-Corrigan-Gibbs-Gilboa-Ishai)** | 2021 | Prefix tree DPF | DPF that reveals all prefixes of the secret index; key building block for Poplar heavy hitters and prefix-based PIR; S&P 2021 [[1]](https://arxiv.org/abs/2012.14884) |
| **Express (Eskandarian-Corrigan-Gibbs)** | 2021 | DPF + write-only ORAM | Private anonymous messaging via DPF-based PIR writes; each client writes to a bulletin board using DPF keys; 16x faster than Riposte; USENIX Sec 2021 [[1]](https://eprint.iacr.org/2021/013) |
| **Duoram (Vadapalli-Storrier-Henry)** | 2023 | DPF + secret-shared memory | 2-server ORAM using DPF for address-private reads and writes; O(sqrt(n)) amortized communication; USENIX Sec 2023 [[1]](https://eprint.iacr.org/2022/1747) |

**State of the art:** Gilboa-Ishai DPF (foundational), Duoram (2023, DPF-based ORAM), Express (DPF for anonymous messaging). DPFs underpin [Private Heavy Hitters](#private-heavy-hitters-frequency-estimation) (Poplar), 2-server [PIR](#private-information-retrieval-pir), and are a core primitive in [Function Secret Sharing](06-multi-party-computation.md#function-secret-sharing-fss-distributed-point-functions-dpf).

**Production readiness:** Experimental
Express and Duoram have research implementations; DPF primitives used in Poplar/VDAF production systems

**Implementations:**
- [sachaservan/vdpf](https://github.com/sachaservan/vdpf) ⭐ 3 — Go, verifiable DPF implementation
- [dimakogan/checklist](https://github.com/dimakogan/checklist) ⭐ 23 — Go, 2-server PIR using DPF

**Security status:** Secure
DPF security based on PRG; 2-server PIR secure if servers do not collude; well-established theoretical foundations

**Community acceptance:** Widely trusted
Foundational work (Gilboa-Ishai 2014); DPFs underpin IETF VDAF standard (Poplar); USENIX Sec 2021/2023 publications

---

## Forward-and-Backward-Private Dynamic Searchable Encryption

**Goal:** Support insertions and deletions on encrypted databases while minimizing information leakage about past queries and deleted documents. Standard SSE leaks the update pattern; forward privacy ensures new insertions cannot be linked to prior search queries, and backward privacy ensures that deleted documents do not appear in future search results. Critical for practical encrypted database deployments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bost Forward-Private SSE (Sigma-ophis)** | 2016 | Trapdoor permutation + PRF chain | First formal definition and construction of forward-private SSE; prevents file-injection attacks; CCS 2016 [[1]](https://eprint.iacr.org/2016/728) |
| **Bost-Minaud-Ohrimenko (Backward-Private SSE)** | 2017 | ORAM + constrained PRF | First backward-private SSE taxonomy (Type-I/II/III); Type-I reveals nothing about deleted entries; CCS 2017 [[1]](https://eprint.iacr.org/2017/126) |
| **AURA (Sun-Yuan-Wang-Chen-Liu)** | 2021 | Symmetric encryption + bitmap | Practical forward-and-backward-private SSE with near-optimal search time; O(n_w) for keyword w with n_w results; NDSS 2021 [[1]](https://eprint.iacr.org/2020/1239) |
| **Mitra/Orion (Ghareh Chamani et al.)** | 2018 | Red-black tree + ORAM | Dynamic SSE with Type-II backward privacy; sublinear search via encrypted B-tree; NDSS 2018 [[1]](https://eprint.iacr.org/2017/1238) |
| **SEAL (Demertzis-Papadopoulos-Papamanthou)** | 2020 | Locality-preserving allocation | SSE optimized for I/O efficiency on disk; forward-private with O(1) disk seeks per result; SIGMOD 2020 [[1]](https://dl.acm.org/doi/10.1145/3318464.3380579) |

**State of the art:** AURA (2021) for practical forward+backward privacy; SEAL for disk-optimized SSE. Addresses the primary attack surface (file-injection attacks) of deployed [Searchable Encryption](#searchable-encryption-sse-peks). Complements [Volume-Hiding EMM](#volume-hiding-searchable-encryption-encrypted-multi-maps) for volume leakage suppression.

**Production readiness:** Experimental
AURA and SEAL have research implementations; forward privacy concepts influencing commercial encrypted databases

**Implementations:**
- [OpenSSE/opensse-schemes](https://github.com/OpenSSE/opensse-schemes) ⭐ 99 — C++, includes Sophos (forward-private SSE) and Diana

**Security status:** Secure
Forward privacy prevents file-injection attacks; backward privacy (Type-I) reveals nothing about deleted entries

**Community acceptance:** Emerging
CCS 2016/2017 (Bost et al.) defined the field; NDSS 2021 (AURA); influencing commercial encrypted database design

---

## Optimal Oblivious RAM (OptORAMa / PanORAMa)

**Goal:** Close the gap between ORAM upper and lower bounds. Path ORAM achieves O(log n) bandwidth overhead but requires O(n) client storage or O(log^2 n) overhead with O(1) client storage. OptORAMa achieves the theoretically optimal O(log n) overhead with O(1) client storage -- matching the Goldreich-Ostrovsky lower bound. PanORAMa extends this to the parallel/concurrent setting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Circuit ORAM (Wang et al.)** | 2015 | Tree-based + circuit-friendly eviction | Optimized for MPC: eviction via oblivious metadata scan; O(log n) bandwidth with smallest constant for MPC use; CCS 2015 [[1]](https://eprint.iacr.org/2014/672) |
| **OptORAMa (Asharov-Chan-Nayak-Pass-Ren-Shi)** | 2020 | Hierarchical + hashing | First O(log n) bandwidth ORAM with O(1) client storage; matches Goldreich-Ostrovsky lower bound; EUROCRYPT 2020 [[1]](https://eprint.iacr.org/2018/892) |
| **PanORAMa (Patel-Persiano-Yeo)** | 2021 | Parallel oblivious sort | Concurrent/parallel ORAM with O(log n) overhead per operation; supports batch access patterns; TCC 2021 [[1]](https://eprint.iacr.org/2021/1413) |
| **ConcORAMa (Chakraborti-Canetti)** | 2023 | Tree ORAM + concurrency control | Concurrent ORAM with linearizable operations; enables multi-client access without serialization; USENIX Sec 2023 [[1]](https://eprint.iacr.org/2023/257) |

**State of the art:** OptORAMa (2020) is theoretically optimal; Circuit ORAM remains dominant in MPC contexts; ConcORAMa for concurrent multi-client settings. Extends the foundational [ORAM](#oblivious-ram-oram) constructions (Path ORAM) and improves the building block used in [Oblivious SQL](#oblivious-sql-encrypted-database-joins) and [Private Nearest-Neighbor Search](#private-nearest-neighbor-search-private-embedding-retrieval).

**Production readiness:** Research
Theoretical breakthrough; Path ORAM remains preferred for practical use

**Implementations:**
- [ObliVM](https://oblivm.com/) — Java, oblivious computation framework with ORAM variants

**Security status:** Secure
OptORAMa achieves optimal O(log n) bandwidth matching Goldreich-Ostrovsky lower bound; provably secure

**Community acceptance:** Niche
EUROCRYPT 2020 (OptORAMa); important theoretical result but practical deployment still uses Path ORAM / Circuit ORAM

---

## Private Contact Discovery Protocols

**Goal:** Determine which of a user's phone contacts are registered on a messaging service -- without revealing the user's contact list to the server or leaking the server's full user database to the client. An extreme case of unbalanced PSI: a small client set (hundreds of contacts) against a massive server set (billions of users), with strict latency and bandwidth constraints for mobile devices.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Signal SGX-Based Contact Discovery** | 2017 | Intel SGX enclave | Server loads encrypted user database into SGX enclave; client sends encrypted contacts; intersection computed inside enclave; first production private contact discovery [[1]](https://signal.org/blog/private-contact-discovery/) |
| **Signal CDS v2 (OHTTP + SGX)** | 2023 | OHTTP relay + SGX + rate limiting | Adds OHTTP proxy to hide client IP from SGX service; cryptographic rate limiting prevents enumeration; processes 1024 contacts in ~2 sec [[1]](https://eprint.iacr.org/2023/758) |
| **Mobile Private Contact Discovery (Kales et al.)** | 2019 | Circuit-PSI + OT | Pure-crypto alternative to SGX; uses circuit-based PSI with O(client-set) communication; practical for mobile but slower than hardware-assisted [[1]](https://eprint.iacr.org/2019/517) |
| **Apple PSI for iMessage** | 2021 | DH-based PSI + differential privacy | Combines commutative-hash PSI with DP noise injection to limit server-side inference; integrated into iOS contact suggestions [[1]](https://www.apple.com/privacy/docs/Differential_Privacy_Overview.pdf) |

**State of the art:** Signal CDS v2 (2023, production with SGX + OHTTP) is the deployed benchmark; Kales et al. for TEE-free alternative. Specialization of [Unbalanced PSI](#unbalanced-psi-client-server-psi-at-scale) for the contact discovery use case; related to [OPRF](#oblivious-prf-oprf) and [ODoH](#oblivious-dns-odoh) for metadata protection.

**Production readiness:** Production
Signal CDS v2 deployed at scale serving hundreds of millions of users; Apple PSI for iMessage in production

**Implementations:**
- [signalapp/ContactDiscoveryService](https://github.com/signalapp/ContactDiscoveryService) ⭐ 282 [archived] — Java, Signal SGX-based contact discovery

**Security status:** Caution
SGX-based variants depend on hardware trust (vulnerable to side-channel attacks); pure-crypto alternatives slower but stronger

**Community acceptance:** Widely trusted
Signal deployment is the industry benchmark; Apple integration in iOS; active research on TEE-free alternatives

---

## Distributed Aggregation Protocol (DAP / Divvi Up)

**Goal:** Standardized, deployable infrastructure for privacy-preserving telemetry aggregation. DAP (IETF RFC 9746) operationalizes Prio/VDAF theory into a concrete client-aggregator-collector architecture: clients secret-share measurements across two non-colluding aggregators, which jointly verify and aggregate without seeing individual values. Deployed by ISRG (Divvi Up) for real-world browser and OS telemetry.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IETF DAP (Distributed Aggregation Protocol)** | 2024 | VDAF + HTTPS | RFC 9746; defines roles (client, leader, helper, collector), task configuration, and batch semantics for Prio3/Poplar VDAFs [[1]](https://datatracker.ietf.org/doc/rfc9746/) |
| **Divvi Up (ISRG)** | 2023 | DAP implementation | Production DAP service by Internet Security Research Group (Let's Encrypt); processes millions of measurements for Firefox, Android telemetry [[1]](https://divviup.org/) |
| **Janus (Cloudflare + Divvi Up)** | 2023 | Rust DAP implementation | Open-source DAP aggregator; serves as both leader and helper; integrates with Daphne (helper) [[1]](https://github.com/divviup/janus) |
| **Chrome Private Aggregation API** | 2023 | DAP + Attribution Reporting | Chrome integrates DAP for Privacy Sandbox ad measurement; clients send Prio3/Poplar shares to DAP aggregators [[1]](https://developers.google.com/privacy-sandbox/relevance/private-aggregation) |

**State of the art:** DAP (RFC 9746) is the IETF standard; Divvi Up (ISRG) is the largest production deployment. Operationalizes [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation) theory; complements [Private Heavy Hitters](#private-heavy-hitters-frequency-estimation) (Poplar VDAF) and [Differential Privacy](#differential-privacy) (DP can be added at collector).

**Production readiness:** Production
Divvi Up (ISRG) processes millions of measurements for Firefox and Android; Janus deployed as DAP aggregator

**Implementations:**
- [divviup/janus](https://github.com/divviup/janus) ⭐ 65 — Rust, production DAP aggregator by ISRG/Cloudflare
- [cloudflare/daphne](https://github.com/cloudflare/daphne) ⭐ 143 — Rust, Cloudflare DAP helper implementation

**Security status:** Secure
Secret-sharing-based; requires non-collusion of leader and helper aggregators; client inputs verified via VDAF proofs

**Community acceptance:** Standard
IETF RFC 9746; ISRG (Let's Encrypt organization) operates Divvi Up; Chrome and Firefox integration

---

## Privacy-Preserving Biometric Authentication

**Goal:** Authenticate users via biometrics (fingerprints, face, iris) without storing or revealing raw biometric templates. The server holds encrypted or secret-shared templates; the client's fresh biometric sample is compared in a privacy-preserving manner using fuzzy matching, HE, or MPC. Prevents template theft and cross-service tracking.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Fuzzy Vault (Juels-Sudan)** | 2002 | Polynomial interpolation + chaff points | Lock a secret with a biometric set; unlock only with a sufficiently similar set; information-theoretic security [[1]](https://doi.org/10.1109/ISIT.2002.1023680) |
| **BioHashing (Jin et al.)** | 2004 | Random projection + binarization | Project biometric feature vectors with user-specific random matrix; cancelable biometrics -- revocable templates [[1]](https://doi.org/10.1016/j.patcog.2004.03.013) |
| **Secure Fingerprint Matching via GC (Barni et al.)** | 2010 | Garbled circuits | FingerCode matching inside garbled circuits; server and client each contribute encrypted templates; IEEE T-IFS 2010 [[1]](https://ieeexplore.ieee.org/document/5416758) |
| **CryptoFace (Sadeghi-Schneider-Wehrenberg)** | 2009 | HE + garbled circuits | Privacy-preserving face recognition: Eigenface distance computed under homomorphic encryption; ICISC 2009 [[1]](https://doi.org/10.1007/978-3-642-14423-3_16) |
| **HE-Based Iris Matching (Gomez-Barrero et al.)** | 2017 | BFV + Hamming distance | Iris template comparison under FHE; 256-bit IrisCodes compared in ~50 ms; IEEE T-IFS 2017 [[1]](https://ieeexplore.ieee.org/document/7893698) |

**State of the art:** HE-based iris/face matching for server-side privacy; garbled circuits for two-party fingerprint verification; Fuzzy Vault for template protection. Relies on [Fuzzy PSI](#fuzzy-private-set-intersection-fpsi) for approximate matching, [HE](07-homomorphic-functional-encryption.md#homomorphic-encryption-he), and [Garbled Circuits](06-multi-party-computation.md#garbled-circuits-expanded). Related to [PPRL](#privacy-preserving-record-linkage-pprl) for identity resolution.

**Production readiness:** Mature
Fuzzy Vault and BioHashing studied for biometric passports; HE-based iris matching demonstrated at practical speeds

**Implementations:**
- [encryptogroup/ABY](https://github.com/encryptogroup/ABY) ⭐ 493 — C++, MPC framework for privacy-preserving biometric matching
- [microsoft/SEAL](https://github.com/microsoft/SEAL) ⭐ 4.0k — C++, HE library for encrypted biometric comparison

**Security status:** Caution
BioHashing requires secrecy of random projection matrix; Fuzzy Vault vulnerable to correlation attacks if not properly parameterized

**Community acceptance:** Niche
IEEE T-IFS publications; ISO/IEC 24745 (biometric template protection); limited commercial adoption of privacy-preserving variants

---

## Leakage-Abuse Attacks and Countermeasures for Encrypted Search

**Goal:** Quantify and mitigate the real-world damage from leakage profiles in deployed searchable encryption. SSE and OPE schemes intentionally reveal certain patterns (access pattern, volume, equality) for efficiency; leakage-abuse attacks exploit these patterns to reconstruct plaintext queries or database contents. Countermeasures include padding, ORAM integration, and differential privacy injection.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IKK Attack (Islam-Kuzu-Kantarcioglu)** | 2012 | Co-occurrence analysis | First practical leakage-abuse attack on SSE; recovers query keywords from access-pattern leakage using known document frequency distribution; NDSS 2012 [[1]](https://personal.utdallas.edu/~mxk055100/publications/ndss2012.pdf) |
| **Count Attack (Cash et al.)** | 2015 | Volume + frequency leakage | Passive attack recovering queries from result-size leakage alone; CCS 2015 [[1]](https://eprint.iacr.org/2016/718) |
| **File-Injection Attack (Zhang et al.)** | 2016 | Chosen-document attack | Active attacker injects known documents; correlates search tokens with injected files to recover all queries; USENIX Sec 2016 [[1]](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/zhang) |
| **SEAL (Demertzis et al.)** | 2020 | I/O-efficient + padding | Locality-preserving SSE with tunable padding to resist volume attacks; SIGMOD 2020 [[1]](https://dl.acm.org/doi/10.1145/3318464.3380579) |
| **Pancake/Waffle (Frequency Smoothing)** | 2020/2024 | Distribution flattening | Transform access distribution to uniform; defeats frequency analysis; see [Frequency-Smoothing Oblivious Datastores](#frequency-smoothing-oblivious-datastores-pancake-waffle) [[1]](https://eprint.iacr.org/2020/1501) |

**State of the art:** IKK/Count/File-Injection attacks demonstrate that minimal leakage is exploitable in practice; SEAL and Pancake/Waffle are the leading countermeasures. Motivates [Volume-Hiding EMM](#volume-hiding-searchable-encryption-encrypted-multi-maps), [Forward-and-Backward-Private SSE](#forward-and-backward-private-dynamic-searchable-encryption), and full [ORAM](#oblivious-ram-oram) for settings requiring zero leakage.

**Production readiness:** Mature
Attacks well-documented; SEAL and PANCAKE/Waffle countermeasures implemented; informing production encrypted database design

**Implementations:**
- [OpenSSE/opensse-schemes](https://github.com/OpenSSE/opensse-schemes) ⭐ 99 — C++, SSE implementations with leakage analysis

**Security status:** Caution
Attacks demonstrate that minimal leakage is exploitable; countermeasures mitigate but full protection requires ORAM-level overhead

**Community acceptance:** Widely trusted
NDSS 2012 (IKK), CCS 2015 (Count), USENIX Sec 2016 (file injection); these attacks shaped the SSE research agenda

---

## Private Set Membership Testing (Batch PIR / Private Membership Test)

**Goal:** Test whether a client's item belongs to a server's set without revealing the item or the set. Unlike full PSI (which processes two sets and outputs their intersection), private membership testing handles a single query against a large server-side set. Enables private Safe Browsing, private certificate revocation checking, and private blocklist lookups.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bloom Filter PIR (Nojima-Kadobayashi)** | 2009 | PIR over Bloom filter | Encode server set in Bloom filter; client queries k positions via PIR; positive if all k bits are 1 [[1]](https://doi.org/10.1007/978-3-642-04474-8_20) |
| **Checklist (Patel et al.)** | 2021 | 2-server PIR + client hints | Private Safe Browsing: client checks URLs against Google's phishing list; sublinear server work via offline hints; USENIX Sec 2021 [[1]](https://eprint.iacr.org/2021/345) |
| **Cuckoo-Hashing Batch PIR (Angel et al.)** | 2018 | Cuckoo hashing + SealPIR | Batch multiple membership queries into one PIR round using cuckoo hashing; amortize cost across queries; IEEE S&P 2018 [[1]](https://eprint.iacr.org/2017/1142) |
| **Private Membership Test from OPRF (Davidson et al.)** | 2023 | VOPRF + Bloom filter | Client evaluates VOPRF on query item; checks result against server-published Bloom filter of OPRF outputs; Privacy Pass-style; single round [[1]](https://www.rfc-editor.org/rfc/rfc9578) |

**State of the art:** Checklist (2021) for private Safe Browsing; OPRF-based membership for lightweight single-query settings. Bridges [PIR](#private-information-retrieval-pir) and [PSI](#private-set-intersection-psi); used in [Keyword PIR](#keyword-pir) for private DNS/CRL lookups.

**Production readiness:** Experimental
Checklist demonstrated for private Safe Browsing; OPRF-based membership used in Privacy Pass ecosystem

**Implementations:**
- [dimakogan/checklist](https://github.com/dimakogan/checklist) ⭐ 23 — Go, 2-server PIR for private Safe Browsing
- [microsoft/SealPIR](https://github.com/microsoft/SealPIR) ⭐ 156 — C++, base PIR for batch membership queries

**Security status:** Secure
PIR-based approaches inherit LWE/RLWE security; OPRF-based approaches secure under DDH; 2-server requires non-collusion

**Community acceptance:** Emerging
USENIX Sec 2021 (Checklist); IETF RFC 9578 (Privacy Pass); Google exploring for Safe Browsing

---

## Privacy-Preserving Ad Measurement (IPA / ARA)

**Goal:** Measure ad conversion (did a user who saw an ad later purchase the product?) without tracking users across sites or revealing individual browsing behavior. Multiple parties (browser, ad-tech, publisher) collaborate using MPC or aggregation protocols to compute aggregate conversion statistics while providing formal differential privacy guarantees per user.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IPA (Interoperable Private Attribution)** | 2023 | 3-party MPC + DP | W3C PATCG protocol; browser secret-shares conversion events across three helper servers; helpers compute aggregate attribution via MPC; per-user DP noise; Meta/Mozilla co-designed [[1]](https://eprint.iacr.org/2023/437) |
| **ARA (Attribution Reporting API)** | 2023 | On-device + aggregation service | Chrome Privacy Sandbox; browser adds local DP noise to event-level reports; aggregate reports processed via TEE-based aggregation service [[1]](https://developers.google.com/privacy-sandbox/relevance/attribution-reporting) |
| **Private Click Measurement (Apple)** | 2021 | Blinded tokens + unlinkability | Safari's ad attribution: 8-bit campaign ID, 4-bit conversion value; relay-based unlinkability; no cross-site tracking [[1]](https://webkit.org/blog/11529/introducing-private-click-measurement-pcm/) |
| **Aggregatable Reports (Chrome)** | 2023 | Secret sharing + DAP | Conversion data secret-shared and sent to DAP aggregators; combined with Attribution Reporting for cross-site measurement [[1]](https://developers.google.com/privacy-sandbox/relevance/private-aggregation) |

**State of the art:** IPA (W3C standard track, 3-party MPC) and ARA (Chrome production) are the leading approaches; Apple PCM for minimal-leakage attribution. Relies on [Prio/VDAF](#prio-vdaf-privacy-preserving-aggregation), [DAP](#distributed-aggregation-protocol-dap-divvi-up), and [Differential Privacy](#differential-privacy). Extends [Labeled PSI / PSI-Sum](#labeled-psi-and-private-intersection-sum-psi-sum) for join-and-aggregate patterns.

**Production readiness:** Production
ARA deployed in Chrome Privacy Sandbox; Apple Private Click Measurement in Safari; IPA under W3C standardization

**Implementations:**
- [nicholaspai/ARA](https://developer.chrome.com/docs/privacy-sandbox/attribution-reporting/) — Chrome Attribution Reporting API (built into Chromium)
- [nicholaspai/PCM](https://webkit.org/blog/11529/introducing-private-click-measurement-pcm/) — Apple Private Click Measurement (built into WebKit)

**Security status:** Secure
IPA provides formal per-user DP; ARA uses local DP noise + TEE aggregation; Apple PCM uses unlinkability via relays

**Community acceptance:** Standard
W3C PATCG (IPA); Chrome Privacy Sandbox (ARA); Apple WebKit (PCM); industry consensus on replacing third-party cookies

---

## Oblivious DNS over HTTPS Deployments (Encrypted Metadata Protocols)

**Goal:** Prevent network observers and service providers from jointly learning both a user's identity and their queries. Beyond the base ODoH protocol (RFC 9230), a family of relay-based encrypted metadata protocols has emerged -- separating the "who" from the "what" across DNS, HTTP, and token issuance. Each uses HPKE-encrypted inner requests forwarded through an oblivious relay.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **iCloud Private Relay (Apple)** | 2021 | OHTTP + dual-hop relay | Two-relay architecture: Apple ingress relay (knows client IP) + third-party egress relay (knows destination); neither sees both; deployed on iOS 15+ [[1]](https://www.apple.com/privacy/docs/iCloud_Private_Relay_Overview_Dec2021.pdf) |
| **Oblivious DNS over HTTPS (ODoH)** | 2022 | HPKE + proxy | RFC 9230; Cloudflare + Apple production deployment; client HPKE-encrypts DNS query to resolver; proxy strips identity metadata [[1]](https://www.rfc-editor.org/rfc/rfc9230) |
| **OHTTP (Oblivious HTTP)** | 2024 | HPKE + relay | RFC 9458; generalizes ODoH to any HTTP resource; relay sees client but not request content; gateway sees request but not client [[1]](https://www.ietf.org/rfc/rfc9458.html) |
| **Privacy Pass with OHTTP** | 2024 | VOPRF + OHTTP | RFC 9576/9577/9578; token issuance via OHTTP relay to prevent linkability between issuance and redemption; deployed in Cloudflare challenge bypass [[1]](https://www.rfc-editor.org/rfc/rfc9576) |
| **Geolocated OHTTP (Google)** | 2024 | OHTTP + geo-bucketing | Google's IP Protection in Chrome: route third-party requests through OHTTP relays; geo-bucket egress IPs to preserve coarse location for CDNs [[1]](https://developers.google.com/privacy-sandbox/protections/ip-protection) |

**State of the art:** iCloud Private Relay (billions of queries/day), Cloudflare ODoH, and Chrome IP Protection are the major deployments. Extends [Oblivious DNS (ODoH)](#oblivious-dns-odoh) to a broader encrypted-metadata ecosystem; related to [Onion Routing](11-anonymity-credentials.md#onion-routing) and [Privacy Pass](11-anonymity-credentials.md#privacy-pass-anonymous-tokens).

**Production readiness:** Production
iCloud Private Relay handles billions of queries/day; Cloudflare ODoH and Chrome IP Protection in production

**Implementations:**
- [nicholaspai/odoh-go](https://github.com/cloudflare/odoh-go) ⭐ 146 — Go, ODoH implementation

**Security status:** Secure
HPKE (RFC 9180) provides encryption; privacy requires non-collusion between relay and gateway; formally analyzed

**Community acceptance:** Standard
IETF RFC 9230 (ODoH), RFC 9458 (OHTTP), RFC 9576-9578 (Privacy Pass); deployed by Apple, Cloudflare, Google

---

## Spiral PIR / SimplePIR / DoublePIR

**Goal:** Achieve practical single-server PIR at near-memory-bandwidth throughput by composing lattice-based HE schemes (Regev + GSW), breaking the long-standing performance barrier.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Spiral (Menon-Wu)** | 2022 | FHE ciphertext translation | First practically usable single-server PIR (spiralwiki.com live demo); IEEE S&P 2022 [[1]](https://eprint.iacr.org/2022/368) |
| **SimplePIR / DoublePIR** | 2023 | LWE hint-then-query | 10 GB/s/core throughput, approaching raw memory bandwidth; USENIX Security 2023 [[1]](https://eprint.iacr.org/2022/949) |

**State of the art:** Enables private CT log lookup, private DNS, private search over Wikipedia-scale databases. Google has explored for private ad-attribution lookup. Open-source implementations available.

**Production readiness:** Experimental
Spiral live demo at spiralwiki.com; SimplePIR/DoublePIR achieve near-memory-bandwidth throughput; Google exploring for private lookups

**Implementations:**
- [menonsamir/spiral-rs](https://github.com/menonsamir/spiral-rs) ⭐ 15 — Rust, Spiral PIR implementation
- [ahenzinger/simplepir](https://github.com/ahenzinger/simplepir) ⭐ 100 — Go, SimplePIR/DoublePIR implementation

**Security status:** Secure
Based on LWE (SimplePIR/DoublePIR) and RLWE+GSW (Spiral); well-studied lattice assumptions

**Community acceptance:** Widely trusted
IEEE S&P 2022 (Spiral), USENIX Security 2023 (SimplePIR); breakthrough practical results; actively explored by Google

---

## Circuit-PSI (PSI with Secret-Shared Output)

**Goal:** Allow two parties to obtain additive secret shares of an indicator vector over their intersection — without either party learning which elements matched — enabling downstream MPC over intersection elements.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **PSTY Circuit-PSI** | 2019 | OPPRF + secret shares | Neither party learns the intersection; output feeds into further MPC; EUROCRYPT 2019 [[1]](https://eprint.iacr.org/2019/241) |
| **Linear Circuit-PSI** | 2022 | Relaxed Batch OPPRF | O(n) complexity; PoPETs 2022 [[1]](https://petsymposium.org/popets/2022/popets-2022-0018.pdf) |

**State of the art:** Used in ad-conversion measurement (match user IDs without revealing matches), cross-institution fraud detection, and federated ML over joint data. Fundamentally different output semantics from standard PSI.

**Production readiness:** Experimental
Research implementations available; explored for ad conversion measurement and federated ML

**Implementations:**
- [osu-crypto/libPSI](https://github.com/osu-crypto/libPSI) ⭐ 186 — C++, includes circuit-PSI implementations
- [Visa-Research/volepsi](https://github.com/Visa-Research/volepsi) ⭐ 135 [archived] — C++, VOLE-based PSI with secret-shared output

**Security status:** Secure
Provably secure under standard assumptions; semi-honest security; output reveals nothing about intersection to either party

**Community acceptance:** Emerging
EUROCRYPT 2019, PoPETS 2022; key enabler for downstream MPC on intersection data; growing adoption in privacy-preserving analytics

---

## Private Intersection-Sum (PSI-Sum / Private Join and Compute)

**Goal:** Two parties learn only the sum and cardinality of values associated with their common identifiers, without revealing which identifiers are in common.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ion-Kreuter-Nergiz** | 2017 | Additively HE + PSI | Scalar aggregate output only; ePrint 2017/738 [[1]](https://eprint.iacr.org/2017/738) |
| **Google Private Join and Compute** | 2019 | Deployed at Google | Open-source; ad attribution (retailer learns conversion revenue without revealing customer lists) [[1]](https://github.com/google/private-join-and-compute) |

**State of the art:** Deployed in production at Google for online-to-offline ad attribution. Also applicable to privacy-preserving medical record linkage and cross-organizational surveys where only aggregates are needed.

**Production readiness:** Production
Google Private Join and Compute deployed for online-to-offline ad attribution

**Implementations:**
- [google/private-join-and-compute](https://github.com/google/private-join-and-compute) ⭐ 850 — C++, Google open-source PSI-Sum

**Security status:** Secure
Based on additively homomorphic encryption + commutative encryption; provably secure under standard assumptions

**Community acceptance:** Widely trusted
Deployed at Google; open-sourced; peer-reviewed; used as reference for privacy-preserving ad measurement

---

## STAR — Secret Sharing for Private Threshold Aggregation Reporting

**Goal:** Let a single server collect client measurements and reveal only values reported by at least k clients, providing cryptographically enforced k-anonymity.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **STAR (CCS 2022)** | 2022 | OPRF + threshold key recovery | Single-server; 1773x less overhead than Poplar; Distinguished Paper CCS 2022 [[1]](https://brave.com/research/files/star-ccs-2022.pdf) |

**State of the art:** Deployed by Brave browser (100M+ downloads) for privacy-preserving telemetry. Distinct from Prio/VDAF (which requires two non-colluding servers). IETF Internet Draft submitted.

**Production readiness:** Production
Deployed by Brave browser serving 100M+ downloads for privacy-preserving telemetry

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
OPRF-based threshold key recovery; cryptographically enforced k-anonymity; single-server (no non-collusion assumption)

**Community acceptance:** Emerging
CCS 2022 Distinguished Paper; IETF Internet Draft submitted; deployed by Brave; alternative to Prio/VDAF for single-server settings

---

## DP-3T / GAEN (Decentralized Privacy-Preserving Proximity Tracing)

**Goal:** Enable contact notification by broadcasting rotating pseudorandom Bluetooth identifiers derived from a daily secret seed, with exposure verification done entirely on-device.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DP-3T** | 2020 | PRF rolling IDs + local matching | Server sees only positive test keys, not queries; arXiv 2020 [[1]](https://arxiv.org/abs/2005.12273) |
| **Google/Apple GAEN** | 2020 | Based on DP-3T | Deployed in 40+ national apps serving hundreds of millions of users [[1]](https://en.wikipedia.org/wiki/Exposure_Notification) |

**State of the art:** Largest real-world deployment of a cryptographically privacy-preserving public health protocol. Distinct from "private proximity" (which is a generic theoretical primitive) — DP-3T uses broadcasting + retrospective matching.

**Production readiness:** Production
GAEN deployed on 3B+ devices across 40+ national apps; largest privacy-preserving public health deployment

**Implementations:**
- [google/exposure-notifications-android](https://github.com/google/exposure-notifications-android) ⭐ 529 — Java, Google GAEN reference implementation
- [DP-3T/dp3t-sdk-android](https://github.com/DP-3T/dp3t-sdk-android) ⭐ 239 — Kotlin, DP-3T Android SDK
- [DP-3T/dp3t-sdk-ios](https://github.com/DP-3T/dp3t-sdk-ios) ⭐ 150 — Swift, DP-3T iOS SDK

**Security status:** Secure
PRF-based rolling IDs; local matching prevents server from learning contact graph; relay attacks mitigated by time windows

**Community acceptance:** Standard
Apple/Google OS-level API; EPFL/ETH Zurich design; adopted by 40+ countries; peer-reviewed protocol

---

## Private Information Delivery (PID)

**Goal:** Enable a server to deliver exactly one chosen message to a user without the user learning which message index was selected — the information-theoretic dual of PIR (server privacy instead of client privacy).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hua Sun PID** | 2018 | Information-theoretic | Server-push dual of client-pull PIR; capacity fully characterized; IEEE Trans. IT 2020 [[1]](https://arxiv.org/abs/1806.05601) |

**State of the art:** Provides the correct formal framework for privacy in push-notification and recommendation systems where the delivery decision itself is sensitive. Privacy regulations increasingly scrutinize server-side delivery logic.

**Production readiness:** Research
Theoretical framework; no production implementations; capacity characterized but not deployed

**Implementations:**
- [information-theory research](https://arxiv.org/abs/1806.05601) — No major open-source implementations; theoretical results only

**Security status:** Secure
Information-theoretic security; dual of PIR with well-characterized capacity bounds

**Community acceptance:** Niche
IEEE Transactions on Information Theory 2020; theoretical contribution to privacy in push/recommendation systems

---
