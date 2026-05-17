# Attacks & Cryptanalysis

<!-- TOC -->
## Contents (42 schemes)

**[Elliptic Curve & Discrete Log Attacks](#elliptic-curve--discrete-log-attacks)**
- [Pohlig-Hellman Algorithm](#pohlig-hellman-algorithm)
- [Pollard's Rho and Lambda (Kangaroo) Algorithms](#pollards-rho-and-lambda-kangaroo-algorithms)
- [MOV Attack (Menezes-Okamoto-Vanstone)](#mov-attack-menezes-okamoto-vanstone)
- [Xedni Calculus Attack](#xedni-calculus-attack)
- [Index Calculus Method (Finite Field DLP)](#index-calculus-method-finite-field-dlp)
- [Smart Attack & Weil Descent (Anomalous and Composite-Degree Curves)](#smart-attack--weil-descent-anomalous-and-composite-degree-curves)

**[Symmetric Cipher Cryptanalysis](#symmetric-cipher-cryptanalysis)**
- [Differential Cryptanalysis (Biham-Shamir)](#differential-cryptanalysis-biham-shamir)
- [Linear Cryptanalysis (Matsui's Attack)](#linear-cryptanalysis-matsuiss-attack)
- [Refined Linear Approximations for ARX Ciphers](#refined-linear-approximations-for-arx-ciphers)
- [Boomerang and Rectangle Attacks](#boomerang-and-rectangle-attacks)
- [Slide Attack and Related-Key Attacks](#slide-attack-and-related-key-attacks)
- [Integral / Square / Multiset Cryptanalysis](#integral--square--multiset-cryptanalysis)
- [Meet-in-the-Middle and Biclique Attacks](#meet-in-the-middle-and-biclique-attacks)
- [Algebraic Cryptanalysis (XL, XSL, Gröbner Basis)](#algebraic-cryptanalysis-xl-xsl-gröbner-basis)
- [Cube Attack and Higher-Order Differential Cryptanalysis](#cube-attack-and-higher-order-differential-cryptanalysis)

**[Stream Cipher Cryptanalysis](#stream-cipher-cryptanalysis)**
- [FMS Attack and RC4 Biases](#fms-attack-and-rc4-biases)
- [Correlation Attacks on LFSR-Based Stream Ciphers](#correlation-attacks-on-lfsr-based-stream-ciphers)
- [Time-Memory-Data Trade-Off Attacks (Hellman, BSW)](#time-memory-data-trade-off-attacks-hellman-bsw)

**[Hash Function Cryptanalysis](#hash-function-cryptanalysis)**
- [Wang's Differential Attacks on MD5 and SHA-1](#wangs-differential-attacks-on-md5-and-sha-1)
- [Length-Extension, Multi-Collision, and Herding Attacks](#length-extension-multi-collision-and-herding-attacks)
- [Rebound Attack on Hash Functions](#rebound-attack-on-hash-functions)

**[Factoring and RSA-Specific Attacks](#factoring-and-rsa-specific-attacks)**
- [Number Field Sieve and Quadratic Sieve (Factoring)](#number-field-sieve-and-quadratic-sieve-factoring)
- [Pollard p−1, Williams p+1, and Lenstra ECM (Special Factoring)](#pollard-p1-williams-p1-and-lenstra-ecm-special-factoring)
- [Wiener's Attack, Boneh-Durfee, and Coppersmith's Method](#wieners-attack-boneh-durfee-and-coppersmiths-method)
- [ROCA Attack (Infineon RSA Library)](#roca-attack-infineon-rsa-library)

**[Lattice-Based Cryptanalysis](#lattice-based-cryptanalysis)**
- [LLL and BKZ Lattice Reduction](#lll-and-bkz-lattice-reduction)
- [Hidden Number Problem and ECDSA Nonce Bias Attacks](#hidden-number-problem-and-ecdsa-nonce-bias-attacks)

**[Quantum Cryptanalysis](#quantum-cryptanalysis)**
- [Shor's Algorithm (Quantum Factoring and Discrete Log)](#shors-algorithm-quantum-factoring-and-discrete-log)
- [Grover's Algorithm (Quantum Search)](#grovers-algorithm-quantum-search)
- [Simon's, Kuperberg's, and Other Quantum Subroutine Attacks](#simons-kuperbergs-and-other-quantum-subroutine-attacks)

**[Protocol-Level Attacks](#protocol-level-attacks)**
- [Bleichenbacher's Attack / ROBOT](#bleichenbachers-attack--robot)
- [DROWN Attack (CVE-2016-0800)](#drown-attack-cve-2016-0800)
- [Padding Oracle Attacks (Vaudenay) and CBC-Mode TLS Attacks (BEAST, POODLE, Lucky 13)](#padding-oracle-attacks-vaudenay-and-cbc-mode-tls-attacks-beast-poodle-lucky-13)
- [Compression-Side-Channel Attacks (CRIME, BREACH, TIME, HEIST)](#compression-side-channel-attacks-crime-breach-time-heist)
- [Sweet32 Birthday-Bound Attack](#sweet32-birthday-bound-attack)
- [FREAK and Logjam (Export-Grade Cryptography Downgrade Attacks)](#freak-and-logjam-export-grade-cryptography-downgrade-attacks)
- [GCM Nonce Reuse / Forbidden Attack (Joux)](#gcm-nonce-reuse--forbidden-attack-joux)
- [TLS Renegotiation, Triple-Handshake, and Selfie Attacks](#tls-renegotiation-triple-handshake-and-selfie-attacks)

**[Implementation & Side-Channel Attacks](#implementation--side-channel-attacks)**
- [Power Analysis Attacks (SPA, DPA, CPA, Template)](#power-analysis-attacks-spa-dpa-cpa-template)
- [Cache-Timing Attacks (Flush+Reload, Prime+Probe, Spectre, MDS)](#cache-timing-attacks-flushreload-primeprobe-spectre-mds)
- [Fault Injection Attacks (Bellcore, Glitching, Rowhammer, LaserFI)](#fault-injection-attacks-bellcore-glitching-rowhammer-laserfi)
- [Cold Boot Attack and DRAM Remanence](#cold-boot-attack-and-dram-remanence)
<!-- /TOC -->

## Elliptic Curve & Discrete Log Attacks

---

### Pohlig-Hellman Algorithm

**Goal:** Compute discrete logarithms in groups of smooth (highly composite) order. Reduces the DLOG problem to smaller DLOGs in each prime-power subgroup via the Chinese Remainder Theorem, so the hardest prime-order subgroup determines effective security. Explains why cryptographic groups must have large prime-order subgroups.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Pohlig-Hellman** | 1978 | DLP in any cyclic group | Decomposes DLOG into subgroup DLOGs; complexity O(Σ eᵢ(log n + √pᵢ)) where pᵢ^eᵢ are prime-power factors of group order [[1]](https://ieeexplore.ieee.org/document/1055817) |

The attack works by computing the discrete log modulo each prime-power factor of the group order, then recovering the full solution using CRT. For a group of order n = ∏ pᵢ^eᵢ, complexity is dominated by the largest prime factor of n. If n has only small prime factors, the attack is polynomial. This forces practitioners to require prime-order (or near-prime-order) groups — e.g., prime-order subgroups of Z_p* used in classic DH, or prime-order elliptic curves. The subgroup-confinement attack on DH (sending a point in a small subgroup) exploits the same structure.

**State of the art:** Standard reference attack. Every deployed cyclic-group DLP system (DH, ECDH, DSA, ECDSA) uses prime-order groups specifically to defeat Pohlig-Hellman. Related: [Diffie-Hellman Assumption Variants](16-obfuscation-advanced-hardness.md#diffie-hellman-assumption-variants-cdh-ddh-gdh-q-dh-co-cdh).

**Production readiness:** N/A (Attack)
Well-known classical attack; directly informs the group-order requirements of all DLP-based cryptography.

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, includes discrete_log() using Pohlig-Hellman + Baby-step giant-step

**Security status:** Broken
Any group with smooth order is broken by Pohlig-Hellman. Use prime-order groups (or cofactor clearing) to defeat this attack.

**Community acceptance:** Standard
Textbook attack; universally accepted. Required reading for understanding DLP group requirements.

---

### Pollard's Rho and Lambda (Kangaroo) Algorithms

**Goal:** Compute discrete logarithms in a generic cyclic group of order n with O(√n) group operations and O(1) memory (Rho) or O(√n) operations in a bounded interval (Lambda / Kangaroo). Generic attacks — assume no algebraic structure beyond group operations — so apply to ECDLP on any prime-order curve. Establish the √n square-root barrier matched by the GGM lower bound; force EC key sizes to ≥ 2× target security level.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Pollard's Rho** | 1978 | DLP / ECDLP, generic | Pseudo-random walk on group elements; cycle detection (Floyd / Brent) finds collision → DLP; complexity O(√(πn/2)) [[1]](https://www.ams.org/journals/mcom/1978-32-143/S0025-5718-1978-0491431-9/) |
| **Pollard's Lambda (Kangaroo)** | 1978 | DLP in a known interval [a,b] | Two "kangaroos" (tame + wild) take random jumps; collision when paths meet at a distinguished point; complexity O(√(b−a)) [[1]](https://www.ams.org/journals/mcom/1978-32-143/S0025-5718-1978-0491431-9/) |
| **Parallel Rho (van Oorschot-Wiener)** | 1999 | Distributed ECDLP | Distinguished-point method: m machines achieve √n/m speedup with low communication; standard for ECDLP records [[1]](https://link.springer.com/article/10.1007/PL00003816) |
| **Negation / endomorphism speedup** | 1999– | ECDLP on curves with efficient endomorphisms | √2 speedup from P ↔ −P automorphism; further gains on GLV/GLS curves; used in Certicom challenge breaks [[1]](https://eprint.iacr.org/2002/138) |

Pollard Rho iterates a function f: G → G that mixes group operations with known scalar coefficients; by the birthday bound, after ~√(πn/2) steps the walk revisits a previous element, and matching the coefficient sums solves for the discrete log. Floyd's "tortoise and hare" or Brent's cycle detection finds the collision in O(1) memory. Pollard Lambda targets DLP restricted to an interval [a,b] (e.g., recovering a key known to lie in a small range, or solving the DLP in elliptic-curve voting tallies where the result is bounded by the number of voters) and is the standard tool for "small-interval DLP." Parallel Rho with distinguished points (van Oorschot-Wiener 1999) is the actual algorithm used in every public ECDLP record (Certicom ECC2K-130, secp112r1, secp160r1 breaks). The √n barrier from these generic attacks is why prime-order curves used in production are sized at twice the target security level (e.g., 256-bit curves for 128-bit security).

**State of the art:** Pollard Rho with distinguished-point parallelism + endomorphism / negation speedups is the best known generic ECDLP algorithm. Recent records: secp112r1 broken in 2009 (PlayStation 3 cluster), Curve25519-style DLP records run on GPUs. Forms the practical DLP-solving step inside applied protocols — small-interval Kangaroo is used in additive ElGamal e-voting tallying (Helios/Belenios) and confidential transaction range-proof construction; see [E-Voting (Helios, Belenios, Civitas)](06-multi-party-computation.md#mpc-for-e-voting-helios-belenios-civitas) and [Bulletproofs](04-zero-knowledge-proof-systems.md#bulletproofs--range-proofs--inner-product-arguments). Related lower bound: [Baby-step giant-step as GGM optimal](19-theoretical-foundations.md#generic-group-model-ggm-and-algebraic-group-model-agm).

**Production readiness:** N/A (Attack / Algorithm)
Used both as a cryptanalysis benchmark (Certicom ECC challenges, ECDLP records) and as a working algorithm inside protocols where bounded DLP must be solved (e-voting tally extraction, range proof prover internals).

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, `discrete_log_rho` and `discrete_log_lambda` for generic groups and elliptic curves
- [Pari/GP](https://pari.math.u-bordeaux.fr/) — C, generic Pollard-Rho DLP
- [ecdlp-pollard-rho](https://github.com/jbalakrishnan/ecdlp_pollard_rho) ⭐ 8 — SageMath, parallel ECDLP Pollard Rho with distinguished points
- [Pollard-kangaroo](https://github.com/Telariust/pollard-kangaroo) ⭐ 261 — Python/C++, multi-threaded Pollard Lambda for secp256k1 (Bitcoin puzzle solvers)

**Security status:** Broken (for small groups)
Curves under ~110-bit group order are broken in practice (Certicom records). Standard curves (P-256, secp256k1, Curve25519, P-384) are safe — √n attack costs exceed 2^128 operations.

**Community acceptance:** Standard
Textbook generic DLP algorithm; basis of all ECDLP record breaks. Defines the practical security level of every elliptic-curve scheme. Matches the GGM lower bound (Shoup 1997).

---

### MOV Attack (Menezes-Okamoto-Vanstone)

**Goal:** Reduce the elliptic curve discrete logarithm problem (ECDLP) to a discrete logarithm in a finite field extension, where index calculus applies. Uses the Weil or Tate pairing to move the problem from the curve into F_{p^k}* for some embedding degree k; if k is small, the resulting DLOG is tractable.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **MOV Attack (Menezes-Okamoto-Vanstone)** | 1993 | ECDLP on supersingular curves | Maps ECDLP to F_{p^k}* via Weil pairing; index calculus then applies; breaks k ≤ 6 in practice [[1]](https://link.springer.com/article/10.1007/BF01993558) |
| **FR Attack (Frey-Rück)** | 1994 | ECDLP via Tate pairing | Generalization using Tate pairing; same embedding degree criterion [[1]](https://ieeexplore.ieee.org/document/560551) |

For ordinary (non-supersingular) curves over large prime fields, the embedding degree k is typically on the order of p, making the reduced DLOG infeasible. Supersingular curves have k ≤ 6 and are broken by the MOV attack. This forced early elliptic curve standards (NIST, SEC2) to explicitly exclude supersingular curves. The same pairing machinery that makes MOV an attack enables pairing-based cryptography (BLS signatures, IBE, zkSNARKs) on curves with known but large embedding degrees.

**State of the art:** Supersingular curves fully broken for cryptographic use; excluded from all standards. Ordinary curves over prime fields with k ≈ p are safe. Cross-reference: [BLS Aggregate Signatures](08-signatures-advanced.md#aggregate-signatures-bls-aggregate) (beneficial use of pairings).

**Production readiness:** N/A (Attack)
Eliminated from practice: all NIST/SEC/ANSI-approved curves use non-supersingular curves with astronomically large embedding degree.

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, implements Weil and Tate pairings for research use

**Security status:** Broken
All supersingular elliptic curves are broken for ECDLP use. Standard curves (P-256, secp256k1, Curve25519) are immune.

**Community acceptance:** Standard
Textbook result; changed curve selection criteria for all subsequent EC standards.

---

### Xedni Calculus Attack

**Goal:** Proposed attack on ECDLP by lifting points on an elliptic curve over F_p to a curve over Q (the "xedni" direction — index calculus run in reverse), then using rational arithmetic to recover the discrete log. Proposed by Silverman (1998); shown computationally infeasible by Jacobson, Menezes, and Stein (2000).

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Xedni Calculus (Silverman)** | 1998 | ECDLP via lifting | Proposed Q-lifting approach; theoretical framework for breaking ECDLP [[1]](https://cr.yp.to/bib/1998/silverman-xedni.pdf) |
| **Refutation (Jacobson-Menezes-Stein)** | 2000 | — | Showed xedni lifting is computationally harder than the original ECDLP; attack infeasible [[1]](https://link.springer.com/article/10.1007/s00145-000-0009-3) |
| **Revisited Analysis** | 2024 | ECDLP hardness | Analysis placing xedni in modern hardness landscape [[1]](https://eprint.iacr.org/2024/555) |

The xedni approach inverts index calculus: instead of mapping elements to a structured set and solving, it lifts F_p points to rational points on a curve over Q, hoping to reduce to a simpler structure. Silverman observed that if enough rational points of bounded height could be found, the ECDLP might be solvable. The fatal flaw is that finding rational points of bounded height is itself computationally harder than brute-force ECDLP — the lifting does not simplify the problem. The attack is historically significant as the most serious theoretical challenge to ECDLP hardness before it was refuted.

**State of the art:** Refuted and abandoned. ECDLP remains hard on standard curves; no practical attack from xedni. Modern hardness analysis (ePrint 2024/555) confirms no tractable variant.

**Production readiness:** N/A (Attack)
Historical attack proposal; refuted in 2000. No threat to deployed elliptic curve systems.

**Implementations:**
- No known implementations; attack was shown infeasible before any practical variant was built.

**Security status:** Broken
The attack itself is broken (not ECDLP): the lifting step is computationally infeasible. Standard elliptic curve systems (ECDH, ECDSA, Ed25519) are unaffected.

**Community acceptance:** Niche
Historically significant but now a cautionary example. Cited in ECDLP hardness surveys.

---

### Index Calculus Method (Finite Field DLP)

**Goal:** Solve the discrete logarithm problem in F_p* and F_{p^n}* in subexponential time by finding multiplicative relations among elements of a "factor base." Index calculus is to DLP what the Number Field Sieve is to factoring — both rely on smoothness over a factor base. Determines the practical key sizes for classical DH and DSA in F_p*.

| Algorithm | Year | Target | Complexity |
|-----------|------|--------|------------|
| **Index Calculus (Adleman)** | 1979 | DLP in F_p* | L_p[1/2, c] subexponential [[1]](https://dl.acm.org/doi/10.1145/800135.804470) |
| **Coppersmith Algorithm** | 1984 | DLP in F_{2^n} | L_{2^n}[1/3, c]; first L[1/3] algorithm [[1]](https://ieeexplore.ieee.org/document/1056741) |
| **Number Field Sieve for DLP (NFS-DLP)** | 1993 | DLP in F_p* (large p) | L_p[1/3, (64/9)^{1/3}]; same asymptotic as factoring [[1]](https://link.springer.com/article/10.1007/BF02351719) |
| **Joux Quasi-Polynomial DLP** | 2013 | DLP in F_{p^n} small char | L[1/4 + o(1)]; near-polynomial for small-characteristic fields [[1]](https://eprint.iacr.org/2013/095) |
| **Logjam (Adrian et al.)** | 2015 | TLS DHE with 512/1024-bit primes | Practical NFS-DLP precomputation against widely-shared DH groups [[1]](https://weakdh.org/) |

Index calculus reduces DLP to linear algebra: find many smooth representations g^{e_i} ≡ ∏ p_j^{a_{ij}} (mod p) over a factor base of small primes, then solve the resulting matrix system for the logarithms of factor-base elements. To compute log_g(h), find a single smooth h·g^k and back out the answer. The Joux 2013 breakthrough showed that small-characteristic finite fields (e.g., F_{2^n}) are dramatically weaker than F_p* of comparable size — eliminating all "pairing-friendly" curves over small-characteristic fields from production use. For F_p* (classic DH), NFS-DLP has the same asymptotic complexity as factoring p, so 1024-bit DH is now considered broken at nation-state level (Logjam precomputation).

**State of the art:** F_p* with p ≥ 2048 bits is currently safe; 1024-bit is broken at state-actor scale (Logjam). Small-characteristic F_{p^n} (e.g., F_{2^n}) is broken by Joux 2013 — all pairing-friendly curves now use prime-field characteristic. ECDLP on prime-order curves is immune (no index calculus structure). See [MOV Attack](#mov-attack-menezes-okamoto-vanstone) for pairing reduction and [Pollard's Rho](#pollards-rho-and-lambda-kangaroo-algorithms) for generic √n attacks.

**Production readiness:** N/A (Attack / Algorithm)
Defines practical DH/DSA key sizes; mandated 2048+ bit primes in TLS 1.2 (RFC 7919 named groups) and FIPS 186-4.

**Implementations:**
- [CADO-NFS](https://cado-nfs.gitlabpages.inria.fr/) — C, state-of-the-art NFS implementation for factoring and DLP
- [SageMath](https://www.sagemath.org/) — Python/C, index calculus for small fields

**Security status:** Broken (for 1024-bit DH)
1024-bit DH broken at state-actor cost (~$100M precomputation). 2048-bit DH safe at current cost. Small-characteristic F_{2^n} DLP broken outright.

**Community acceptance:** Standard
Foundational subexponential DLP attack; basis of all classical-DH key-size recommendations. Joux 2013 won EUROCRYPT Best Paper.

---

### Smart Attack & Weil Descent (Anomalous and Composite-Degree Curves)

**Goal:** Specialized polynomial-time attacks on elliptic curves with specific algebraic structure: Smart's attack on anomalous curves (where #E(F_p) = p) and Weil/GHS descent on curves over composite-degree extension fields. These force the disqualification of structurally-weak curves from cryptographic use.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Smart's Attack** | 1999 | Anomalous curves #E(F_p) = p | Polynomial-time ECDLP via p-adic logarithm; equivalent to Semaev (1998) and Satoh-Araki (1998) [[1]](https://link.springer.com/article/10.1007/PL00003816) |
| **Weil Descent (Frey)** | 1998 | Curves over F_{q^n}, composite n | Reduces ECDLP on E(F_{q^n}) to higher-genus Jacobian DLP on smaller field; sometimes faster than Pollard rho [[1]](https://link.springer.com/chapter/10.1007/3-540-58691-1_55) |
| **GHS Attack (Gaudry-Hess-Smart)** | 2002 | Binary curves F_{2^{cn}} | Weil descent + index calculus on hyperelliptic Jacobian; breaks many binary curves over composite fields [[1]](https://link.springer.com/article/10.1007/s00145-001-0011-x) |
| **Generalized GHS (Diem)** | 2003 | F_{q^n} curves, gcd-pattern | Extends GHS coverage; identifies large families of weak curves [[1]](https://link.springer.com/chapter/10.1007/3-540-39200-9_2) |

Smart's attack runs in polynomial time when the curve order equals the field characteristic (anomalous curves) — a structural coincidence that makes the formal logarithm well-defined. Such curves are easy to detect (count points; reject if #E(F_p) = p) and are universally excluded from standards. Weil descent re-expresses an EC over F_{q^n} as a higher-genus algebraic curve over F_q, where index calculus on the Jacobian may be faster than Pollard rho on the original. GHS gives the practical instantiation for binary curves F_{2^{cn}} with small c. The attack is why NIST B-curves over composite-degree binary fields were retired in favor of prime-field curves.

**State of the art:** Anomalous curves universally excluded. Binary composite-degree curves retired from new standards. Prime-field curves (P-256, secp256k1, Curve25519) immune. Pairing-friendly curves carefully analyzed for descent-resistance.

**Production readiness:** N/A (Attack)
Drives curve selection criteria; structurally weak curves excluded from all standards (NIST FIPS 186-5, SECG SEC2, RFC 7748).

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, Smart's attack via p-adic methods; Weil descent constructions
- [MAGMA](http://magma.maths.usyd.edu.au/magma/) — proprietary, reference implementation for advanced curve cryptanalysis

**Security status:** Broken (for structurally-weak curves only)
Anomalous and certain composite-degree curves broken in polynomial time. Standard prime-order curves immune.

**Community acceptance:** Standard
Required curve-selection criterion since 1999. All deployed curves are anomalous-free and descent-resistant.

---

## Symmetric Cipher Cryptanalysis

---

### Differential Cryptanalysis (Biham-Shamir)

**Goal:** Analyze how chosen-plaintext pairs with a fixed XOR difference propagate through cipher rounds, exploiting non-uniform differential probabilities of S-boxes to deduce subkey bytes. The foundational statistical attack on iterated block ciphers; motivated wide-differential-resistance design criteria now standard in all AES-era ciphers.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Differential Cryptanalysis (Biham-Shamir)** | 1990 | DES (and variants) | Recovers 48 of 56 DES key bits with 2^47 chosen plaintexts; first published differential attack [[1]](https://link.springer.com/article/10.1007/BF00630563) |
| **Truncated Differentials (Knudsen)** | 1994 | Block ciphers | Propagates partial differences; extends DC to ciphers resistant to full differentials [[1]](https://link.springer.com/chapter/10.1007/3-540-48630-X_1) |
| **Impossible Differential Cryptanalysis** | 1998 | Block ciphers | Exploits differential pairs with probability 0; eliminates wrong keys [[1]](https://link.springer.com/chapter/10.1007/3-540-69710-1_14) |
| **Boomerang/Rectangle Attack (Wagner)** | 1999 | Block ciphers | Combines two short differentials via adaptive chosen plaintext/ciphertext; extends reach to more rounds [[1]](https://link.springer.com/chapter/10.1007/3-540-48519-8_22) |

Differential cryptanalysis exploits the non-uniformity of XOR differences through S-boxes: for a given input difference ΔX, some output differences ΔY occur with much higher probability than 2^{-n}. Connecting such high-probability differentials across rounds builds a "differential characteristic." Given a characteristic with probability p, approximately 1/p chosen-plaintext pairs are needed to recover subkey information from the last round. IBM had independently discovered differential cryptanalysis during DES design (1974) and classified it; NSA's design of DES's S-boxes was specifically hardened against it. AES (Rijndael) achieves provable resistance via the wide-trail strategy: the minimum number of active S-boxes across any 4-round differential is 25, giving differential probability ≤ 2^{-150}.

**State of the art:** AES and all post-2000 standards are designed with differential resistance as a primary criterion. The attack is mostly of historical importance for modern ciphers, but remains relevant for: lightweight ciphers with reduced rounds, custom designs, and as a component in higher-order attacks. See [AES (Advanced Encryption Standard)](01-foundational-primitives.md#block-ciphers--aes-chacha20--salsa20) for resistance properties.

**Production readiness:** N/A (Attack)
Practical against DES and weakly-designed ciphers. Does not threaten AES, ChaCha20, or any post-2000 standard at recommended parameters.

**Implementations:**
- [CryptoSMT](https://github.com/kste/cryptosmt) ⭐ 152 — Python, SMT-based tool for differential/linear cryptanalysis of ARX and SPN ciphers

**Security status:** Broken
DES is broken via differential cryptanalysis (and exhaustive search). AES, ChaCha20, and all post-2000 standards are immune at design level.

**Community acceptance:** Standard
Foundational attack; every symmetric cipher design paper must address differential resistance. IACR 2024 Test of Time Award.

---

### Linear Cryptanalysis (Matsui's Attack)

**Goal:** Use linear approximations of the cipher — XOR-based linear equations relating plaintext bits, ciphertext bits, and key bits that hold with probability ½ + ε — to recover key bits using known-plaintext attack. Matsui's 1993 attack on DES requires 2^43 known plaintexts to recover the full key.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Linear Cryptanalysis (Matsui)** | 1993 | DES | 2^43 known plaintexts; recovers full 56-bit DES key; first experimental break of DES in academic literature [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_33) |
| **Multiple Linear Cryptanalysis (Biryukov-Cannière-Quisquater)** | 2004 | Block ciphers | Uses multiple simultaneous linear approximations; reduces data/time complexity [[1]](https://link.springer.com/chapter/10.1007/978-3-540-28628-8_6) |
| **Linear Hull Effect (Nyberg)** | 1994 | Block ciphers | S-box linear bias propagates as a hull of many paths; total bias is sum of all paths, harder to bound [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_19) |

Linear cryptanalysis builds linear approximations of individual S-boxes (with bias ε_i from ½), then connects them across rounds using Piling-Up Lemma: the combined bias ε over r rounds with individual biases ε_i satisfies ε ≈ 2^{r-1} ∏ εᵢ. The number of known plaintexts needed scales as ε^{-2}. AES S-box has maximum linear bias 2^{-3}, and the wide-trail strategy guarantees at least 20 active S-boxes over any 4-round linear approximation, giving combined bias ≤ 2^{-60} — making linear attacks on full AES computationally infeasible. For ARX ciphers (ChaCha20, Salsa20), the linear bias analysis is more complex because modular addition does not distribute evenly over XOR.

**State of the art:** AES and all post-2000 SPN ciphers have provable resistance via wide-trail. For ARX ciphers, linear approximation analysis remains active (see [Refined Linear Approximations for ARX Ciphers](#refined-linear-approximations-for-arx-ciphers)). DES is broken. See [Lightweight Cryptography / ASCON](01-foundational-primitives.md#lightweight-cryptography--ascon) for lightweight cipher resistance.

**Production readiness:** N/A (Attack)
Practical only against DES and reduced-round variants of modern ciphers. No practical threat to AES, ChaCha20, or AES-GCM at standard parameters.

**Implementations:**
- [CryptoSMT](https://github.com/kste/cryptosmt) ⭐ 152 — Python, SMT-based differential and linear trail search

**Security status:** Broken
DES broken with 2^43 known plaintexts. AES, ChaCha20, and post-2000 standards designed to resist; no practical linear attack exists on full-round versions.

**Community acceptance:** Standard
Foundational attack alongside differential cryptanalysis; required for cipher evaluation. Motivated modern S-box design criteria and wide-trail strategy.

---

### Refined Linear Approximations for ARX Ciphers

**Goal:** Build more accurate linear approximations for ARX (addition-rotation-XOR) ciphers like ChaCha20 and Salsa20 by better modeling modular addition's XOR-bias. Improved approximations yield stronger distinguishers; ePrint 2025/2128 (INDOCRYPT 2025) achieves the best known 7-round ChaCha distinguisher at complexity 2^214.

| Work | Year | Target | Note |
|------|------|--------|------|
| **Aumasson-Fischer-Khazaei-Meier-Rechberger** | 2008 | Salsa20/7 | First successful attack on reduced Salsa20; probabilistic distinguisher [[1]](https://eprint.iacr.org/2007/472) |
| **Choudhuri-Maitra** | 2016 | ChaCha | Improved differential-linear attacks on reduced-round ChaCha [[1]](https://eprint.iacr.org/2016/377) |
| **Refined Linear Approx. (ePrint 2025/2128)** | 2025 | ChaCha20/7 | INDOCRYPT 2025; refines linear bias modeling for ARX addition; best 7-round ChaCha distinguisher at 2^214 [[1]](https://eprint.iacr.org/2025/2128) |

ARX ciphers resist classical differential/linear cryptanalysis because they have no explicit S-boxes — non-linearity comes entirely from modular addition (⊞). The XOR-bias of (a ⊞ b) ⊕ c is harder to characterize than an S-box table lookup. Existing approximations model ⊞ using carry-bit heuristics; ePrint 2025/2128 refines this by tracking higher-order carry correlations and using SAT/MILP solvers to find optimal multi-round linear hulls. The resulting 7-round ChaCha distinguisher at 2^214 remains far from threatening full 20-round ChaCha20 (security level 2^256), but narrows the security margin analysis for reduced-round variants used in formal proofs.

**State of the art:** Full 20-round ChaCha20 is not threatened. Best academic attacks reach 7–8 rounds. Security margin is approximately 12 unattacked rounds. Related: [Linear Cryptanalysis (Matsui's Attack)](#linear-cryptanalysis-matsuiss-attack).

**Production readiness:** N/A (Attack — research)
Academic distinguisher on 7-round ChaCha; no impact on full ChaCha20 deployments in TLS 1.3, WireGuard, or OpenSSH.

**Implementations:**
- No public general-purpose ARX linear cryptanalysis toolkit; attacks are ad-hoc per paper.

**Security status:** Caution
7-round ChaCha can be distinguished below brute force. Full 20-round ChaCha20 secure; security margin is healthy but not unlimited.

**Community acceptance:** Emerging
Active research area; INDOCRYPT 2025 accepted. Not yet peer-reviewed in top-tier venue. ChaCha20 remains the dominant non-AES symmetric cipher.

---

### Boomerang and Rectangle Attacks

**Goal:** Combine two short high-probability differential characteristics into a longer "quartet" attack using adaptive chosen plaintext/ciphertext queries (boomerang) or chosen plaintexts only (rectangle/amplified boomerang). Extends differential cryptanalysis reach by ~2× rounds.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Boomerang (Wagner)** | 1999 | Block ciphers with short trails | Adaptive CCA; quartet probability p²q² where p, q are two trail probabilities [[1]](https://link.springer.com/chapter/10.1007/3-540-48519-8_22) |
| **Amplified Boomerang (Kelsey-Kohno-Schneier)** | 2000 | Block ciphers | Chosen-plaintext variant; lower data complexity but more queries [[1]](https://link.springer.com/chapter/10.1007/3-540-44706-7_6) |
| **Rectangle (Biham-Dunkelman-Keller)** | 2001 | Block ciphers | Optimized amplified boomerang; standard form used today [[1]](https://link.springer.com/chapter/10.1007/3-540-44987-6_21) |
| **Sandwich Attack** | 2010 | KASUMI/A5/3 | Related-key boomerang with middle "join" step; broke KASUMI in 2^32 data [[1]](https://eprint.iacr.org/2010/013) |
| **Retracing Boomerang** | 2020 | AES, etc. | Refines boomerang switching probability; improves several attacks [[1]](https://eprint.iacr.org/2019/1154) |

The boomerang switches a long differential into two shorter trails E = E_1 ∘ E_0 where each half has a useful differential characteristic. Quartet (P, P', C, C') is constructed by encrypting two pairs through E_0 with input difference α, then modifying ciphertexts by β before decryption — if α and β propagate correctly through E_1 in opposite directions, the structure "boomerangs back." Best results when single-trail differentials don't span the whole cipher but two halves do. Dunkelman-Keller-Shamir 2010 sandwich attack broke KASUMI's reduced-round security to practical levels via related-key boomerang.

**State of the art:** Active research; "boomerang switch effect" (Murphy 2011) refined probability calculation; retracing variant (Dunkelman et al. 2020) gives strongest current results. Used to attack reduced-round AES, lattice-based MACs.

**Production readiness:** N/A (Attack)
Cryptanalysis technique only; no production impact at standard parameters.

**Implementations:**
- [CryptoSMT](https://github.com/kste/cryptosmt) ⭐ 152 — Python, SMT-based boomerang trail search

**Security status:** Caution
Threatens reduced-round versions of many ciphers; full-round AES, ChaCha20 safe.

**Community acceptance:** Standard
Required tool in cipher evaluation. CRYPTO/EUROCRYPT regulars.

---

### Slide Attack and Related-Key Attacks

**Goal:** Exploit self-similarity in cipher round structure (slide) or weakness in key schedules (related-key) to bypass round-count-based security arguments. Slide attacks work independently of round count; related-key attacks assume an adversary obtains encryptions under related (but unknown) keys.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Related-Key Attack (Biham)** | 1993 | DES, GOST | Adversary queries cipher under unknown related keys (XOR-fixed difference); recovers full key in many ciphers [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_34) |
| **Slide Attack (Biryukov-Wagner)** | 1999 | Self-similar round functions | Independent of round count; finds slid pair (P_i, P_{i+1}) revealing round function [[1]](https://link.springer.com/chapter/10.1007/3-540-48519-8_18) |
| **Slide with a Twist** | 2000 | Modified Feistel/IDEA | Generalizes original slide to non-uniform round functions [[1]](https://link.springer.com/chapter/10.1007/3-540-44598-6_8) |
| **Related-Key Boomerang on AES-192/256** | 2009 | AES-192, AES-256 | Biryukov-Khovratovich; 2^131 / 2^99 attack on AES-256 / AES-192 with related-key model [[1]](https://link.springer.com/chapter/10.1007/978-3-642-10366-7_1) |
| **Reflection / Slide Variants** | 2007– | GOST, KeeLoq | Reflection attack on GOST (Isobe 2011); KeeLoq broken by slide+meet-in-middle (Indesteege et al. 2008) [[1]](https://eprint.iacr.org/2011/284) |

Slide attacks find a pair of plaintexts (P, P′) such that one round of P maps to P′; then a long-trail attack reduces to a one-round attack regardless of the cipher's total rounds. The cipher's vulnerability is the self-similarity, not the round count. Related-key attacks assume adversary can request encryptions under E_K, E_{K′} with K′ = f(K) for some adversary-chosen relation f (typically XOR with a constant). Most production protocols never expose related keys, but several wireless protocols (WEP, Bluetooth E0, KASUMI in 3G) did, leading to practical breaks. AES-256's related-key vulnerability (2^99 work) is academically significant — it's why AES-256 is rated at 128-bit related-key security, not 256-bit.

**State of the art:** Related-key model treated as a design requirement; modern ciphers (ChaCha20, AES-GCM-SIV) prove resistance. Slide attacks defeated by non-uniform round functions or round counters in key schedule.

**Production readiness:** N/A (Attack)
Threatens protocols that allow related-key queries (WEP RC4, KeeLoq remote entry). No threat to standard AES/ChaCha20 deployments.

**Implementations:**
- No standardized tool; attacks are ad-hoc per target.

**Security status:** Broken (for vulnerable targets)
WEP, KeeLoq, GOST 28147, KASUMI broken via related-key/slide. AES-256 has academic 2^99 related-key attack but no practical impact.

**Community acceptance:** Standard
Required modeling in any new cipher proposal; ChaCha20, AES variants explicitly proven RK-secure.

---

### Integral / Square / Multiset Cryptanalysis

**Goal:** Track propagation of structured plaintext sets (Λ-sets with one varying byte and constants elsewhere) through cipher rounds. If the cipher does not sufficiently mix, after some rounds the XOR-sum of the output set is predictable, giving a distinguisher and key-recovery handle. Devised originally as the "Square attack" against the Square cipher (AES predecessor).

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Square Attack (Daemen-Knudsen-Rijmen)** | 1997 | Square cipher, then AES | 4-round Λ-set distinguisher; XOR of all 256 ciphertexts in active byte = 0 [[1]](https://link.springer.com/chapter/10.1007/BFb0052343) |
| **Integral Cryptanalysis (Knudsen-Wagner)** | 2002 | Block ciphers (general) | Generalization of Square; tracks integrals over structured sets [[1]](https://link.springer.com/chapter/10.1007/3-540-45661-9_9) |
| **Higher-Order Integral (Z'aba et al.)** | 2008 | SPN ciphers | Combines integral with higher-order differentials [[1]](https://link.springer.com/chapter/10.1007/978-3-540-79263-5_16) |
| **Division Property (Todo)** | 2015 | Block ciphers | Generalization tracking byte-level integral properties via algebraic degree; extends to bit-level division property (Todo-Morii 2016) [[1]](https://eprint.iacr.org/2015/090) |

The Square attack works as follows: choose 2^8 plaintexts varying one byte through all 256 values while keeping the other 15 bytes fixed (Λ-set). After 4 AES rounds, the XOR of all 256 ciphertexts in any byte position equals zero. This gives a 4-round distinguisher; with one more round of analysis, partial round-7 subkeys can be recovered. Currently the best academic attack on 7-round AES-128 uses integral cryptanalysis with biclique speed-up. Todo's division property (FSE 2015) generalized integral attacks dramatically: it propagates "algebraic-degree" information, enabling automatic trail search via MILP for many ciphers. Division property has improved attacks on reduced-round SIMON, SPECK, and Trivium.

**State of the art:** Division property + MILP/SAT solvers is the standard modern automated tool for integral-style analysis. Full-round AES, ChaCha20 immune. Reduced-round attacks on AES reach 7 rounds (AES-128) with integral methods.

**Production readiness:** N/A (Attack)
Standard tool in academic cipher analysis. No production threat to AES, ChaCha20.

**Implementations:**
- [CryptoSMT](https://github.com/kste/cryptosmt) ⭐ 152 — Python, integral trail search via SMT
- [Div-Property-MILP](https://github.com/CYU-LXF/Division-Property) ⭐ 12 — Python, division property + MILP for trail search

**Security status:** Caution
Threatens reduced-round versions; full AES, ChaCha20 secure.

**Community acceptance:** Standard
Required tool in cipher evaluation; division property won FSE 2015 best paper. Used in NIST lightweight cipher analysis.

---

### Meet-in-the-Middle and Biclique Attacks

**Goal:** Time-memory trade-off attacks that split the cipher into two halves and meet in the middle to reduce brute-force search from 2^k to 2^{k/2} with 2^{k/2} memory. Foundational for breaking double-encryption (2DES) and gives best-known academic attacks on full AES.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **MITM on Double Encryption (Diffie-Hellman)** | 1977 | 2DES | Forward-encrypt with all 2^56 K_1; backward-decrypt with all 2^56 K_2; meet on intermediate; 2^57 total vs 2^112 brute force [[1]](https://ieeexplore.ieee.org/document/1454886) |
| **3-Subset MITM** | 2010 | KTANTAN | Three-key splits; useful for ciphers with strongly key-dependent rounds [[1]](https://link.springer.com/chapter/10.1007/978-3-642-13858-4_16) |
| **Biclique Attack on AES (Bogdanov-Khovratovich-Rechberger)** | 2011 | AES-128/192/256 | Splits AES into rounds + bicliques; reduces brute force by factor ~4; first sub-2^128 academic attack on AES-128 (2^126.1) [[1]](https://link.springer.com/chapter/10.1007/978-3-642-25385-0_19) |
| **Demirci-Selçuk MITM** | 2008 | AES, Twofish | Multiset preserving distinguishers + MITM; current best 7-round AES-128 attack [[1]](https://link.springer.com/chapter/10.1007/978-3-540-71039-4_7) |
| **3SHAKE-style MITM** | various | Hash functions | MITM preimage attack on reduced-round SHA-2, MD5, Whirlpool [[1]](https://eprint.iacr.org/2014/239) |

Original MITM (Diffie-Hellman 1977) shows that double-encryption with two independent k-bit keys provides only 2^{k+1} effective security, not 2^{2k}. This is why 2DES was never standardized; 3DES with three independent keys gives ~112-bit security (Lucks 1998 analysis). Biclique attacks generalize MITM by using a structure (biclique) that links input-output pairs of partial rounds; Bogdanov-Khovratovich-Rechberger (ASIACRYPT 2011) gave the first non-trivial attack on full AES with complexity 2^126.1 (vs 2^128 brute force) — a factor-4 speedup that has no practical impact but is academically notable as it surpasses the brute-force bound. NIST and IETF stated this does not affect AES's security claim because the speedup is far below any practical threshold.

**State of the art:** Biclique-AES (2^126.1) is the best known non-trivial attack on full AES — no practical impact. MITM is fundamental for all double-encryption analysis. 3DES officially deprecated by NIST in 2023 (SP 800-131A Rev 2) due to small block size (SWEET32) and inefficiency.

**Production readiness:** N/A (Attack)
Drives key-size and round-count selection. Biclique result formally confirms AES security margin.

**Implementations:**
- No production tool; attacks are ad-hoc per target.

**Security status:** Caution (academic)
2^126.1 attack on AES-128 is below brute-force bound but far above any practical compute. AES remains secure for all production purposes.

**Community acceptance:** Standard
ASIACRYPT 2011 best paper. Required in cipher analysis. NIST/IETF have publicly addressed whether biclique-AES affects AES standardization (it does not).

---

### Algebraic Cryptanalysis (XL, XSL, Gröbner Basis)

**Goal:** Express the cipher's encryption equation as a system of multivariate polynomial equations over F_2, then solve via specialized algebraic techniques (XL, XSL, F_4/F_5 Gröbner basis, SAT solvers). Theoretical concern in cipher design — if a cipher has too algebraic a description, it may admit better-than-brute-force attacks.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **XL Algorithm (Courtois-Klimov-Patarin-Shamir)** | 2000 | Overdefined polynomial systems | Linearization-based; extends Gröbner basis ideas to overdetermined systems [[1]](https://link.springer.com/chapter/10.1007/3-540-45539-6_27) |
| **XSL Attack (Courtois-Pieprzyk)** | 2002 | AES, Serpent | Sparse multiplication variant of XL; controversial claim that AES might be broken in 2^102 [[1]](https://link.springer.com/chapter/10.1007/3-540-36178-2_17) |
| **F_4 / F_5 (Faugère)** | 1999/2002 | Gröbner basis computation | Standard Gröbner basis algorithm; benchmark for system-solving [[1]](https://www-polsys.lip6.fr/~jcf/Papers/F99a.pdf) |
| **MQ Problem Cryptanalysis** | 1996– | Multivariate PKE (HFE, UOV) | Reduces multivariate PKE to MQ; Kipnis-Patarin-Goubin broke HFE Challenge 1 [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_15) |
| **MiMC / Poseidon Algebraic Attacks** | 2020+ | ZK-friendly hashes | Grassi et al. attacks on low-multiplicative-complexity hashes; force higher round counts [[1]](https://eprint.iacr.org/2020/179) |

The Courtois-Pieprzyk 2002 claim that AES could be broken in 2^102 work via XSL ignited a long debate; subsequent analysis (Cid-Leurent 2005, Murphy-Robshaw 2002) showed the XSL complexity estimates were optimistic and the attack does not improve on brute force in practice. Algebraic attacks have, however, been effective against ZK-friendly hashes (MiMC, Poseidon, Rescue) that intentionally use low-degree round functions to keep arithmetization cheap. The Grassi et al. (2020+) line of work on Poseidon and related hashes has forced parameter increases in practical SNARK systems.

**State of the art:** No practical algebraic break on AES, ChaCha20, or standard block ciphers. Major impact on ZK-friendly hash design (Poseidon v1 → v2, Rescue-Prime, Anemoi). MQ-based PKE schemes (Rainbow, GeMSS) eliminated from NIST PQC standardization due to algebraic vulnerabilities (Beullens 2022 broke Rainbow in 53 hours on a laptop).

**Production readiness:** N/A (Attack)
Forces parameter selection in MQ-based PQC and ZK-friendly hashes. No impact on standard symmetric ciphers.

**Implementations:**
- [Magma](http://magma.maths.usyd.edu.au/magma/) — proprietary, fastest Gröbner basis (F_4)
- [FGb](https://www-polsys.lip6.fr/~jcf/FGb/) — C, Faugère's F_4/F_5
- [PolyBoRi](https://polybori.sourceforge.net/) — C++/Python, Boolean polynomial Gröbner basis

**Security status:** Broken (for some MQ-PKE and reduced ZK-friendly hashes)
Rainbow, GeMSS broken. Standard symmetric ciphers (AES, ChaCha20) unaffected. ZK-friendly hash parameters periodically increased.

**Community acceptance:** Standard
Required analysis for MQ-PKE and ZK-friendly hash designs. XSL controversy is historically notable; consensus is XSL does not break AES.

---

### Cube Attack and Higher-Order Differential Cryptanalysis

**Goal:** Treat the cipher as a multivariate Boolean polynomial in plaintext and key bits, then sum the output over a subcube of plaintext variables ("cube") to extract a linear or low-degree relation in key bits. Effective against stream ciphers and reduced-round block ciphers with low algebraic degree.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Higher-Order Differential (Lai)** | 1994 | Block ciphers, low-degree | Iterated d-th differences cancel low-degree terms; recovers high-degree behavior [[1]](https://link.springer.com/chapter/10.1007/3-540-58108-1_15) |
| **Cube Attack (Dinur-Shamir)** | 2009 | Trivium, Grain | Sums over subcube of public variables; extracts linear superpolys in key; broke 767-round Trivium [[1]](https://eprint.iacr.org/2008/385) |
| **Cube Tester** | 2009 | Stream ciphers | Distinguisher version: test if cube sum is "structured" [[1]](https://eprint.iacr.org/2009/127) |
| **Dynamic Cube Attack** | 2011 | Grain-128 | Chooses cube variables adaptively; near-practical break of Grain-128 [[1]](https://eprint.iacr.org/2011/570) |
| **Conditional Differential / Cube** | 2010– | NLFSR-based ciphers | Combines cube with conditional differential trails; current best attacks on Trivium and Grain variants [[1]](https://eprint.iacr.org/2012/595) |

Cube attacks exploit that any Boolean function f(x_1,...,x_n) summed over all 2^d assignments of d of its variables yields the coefficient of the degree-d monomial in those variables. If this coefficient turns out to be a low-degree (often linear) function of the remaining variables (including the key), the attacker has a key-recovery handle. Dinur-Shamir's original 2009 paper broke reduced Trivium (767 of 1152 rounds) and Grain-128 in practical time. Cube attacks remain among the best academic attacks on Trivium and Grain family.

**State of the art:** Cube + dynamic cube + conditional differential is the current frontier for NLFSR-based stream ciphers. Full Trivium and Grain-128a remain secure with healthy margins (best attack reaches ~830/1152 Trivium rounds). Higher-order differential is foundational and used in division-property-based analyses.

**Production readiness:** N/A (Attack)
Drives round-count selection in stream ciphers and ZK-friendly hashes. No practical break of standardized full-round designs.

**Implementations:**
- [Cube-Attack-Toolkit](https://github.com/cube-attack-toolkit) — Python (research), automated superpoly recovery
- [SageMath](https://www.sagemath.org/) — Python/C, generic cube attack support

**Security status:** Caution
Effective against reduced-round NLFSR ciphers. Full-round Trivium, Grain-128a, ChaCha20 secure.

**Community acceptance:** Standard
EUROCRYPT 2009 best paper. Required tool in stream cipher evaluation.

---

## Stream Cipher Cryptanalysis

---

### FMS Attack and RC4 Biases

**Goal:** Exploit non-uniform output biases in the RC4 keystream — particularly the Fluhrer-Mantin-Shamir (FMS) attack against the WEP key schedule and AlFardan-Bernstein-Paterson plaintext-recovery against RC4 in TLS — to recover the encryption key or partial plaintext.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **FMS Attack (Fluhrer-Mantin-Shamir)** | 2001 | WEP / RC4 with weak IVs | Specific IV patterns leak K_2 byte via known first keystream byte; broke WEP in ~minutes [[1]](https://link.springer.com/chapter/10.1007/3-540-45537-X_1) |
| **Klein's Attack** | 2005 | RC4 / Aircrack-NG | Improvement on FMS; uses second-byte bias; basis of aircrack-ng PTW attack [[1]](https://eprint.iacr.org/2005/007) |
| **PTW Attack (Pyshkin-Tews-Weinmann)** | 2007 | WEP | Reduced WEP recovery to ~40k packets; standard WEP break in aircrack-ng [[1]](https://eprint.iacr.org/2007/120) |
| **Mantin's ABSAB Bias** | 2005 | RC4 keystream | Long-range keystream biases; foundation for later TLS attacks [[1]](https://link.springer.com/chapter/10.1007/11502760_22) |
| **AlFardan-Bernstein-Paterson** | 2013 | RC4-TLS | Plaintext recovery via 2^32 ciphertext samples of repeated plaintext; led to RFC 7465 RC4 removal [[1]](https://www.isg.rhul.ac.uk/tls/RC4biases.pdf) |
| **NOMORE / Bar-Mitzvah Attacks** | 2015 | RC4-TLS | Vanhoef-Piessens: 75 hours to recover HTTPS cookie; killed RC4 in production [[1]](https://www.rc4nomore.com/) |

RC4's key schedule (KSA) does not adequately mix weak IVs into the state, leading to predictable first-byte outputs given known IV bytes — the FMS attack core. Long-range keystream biases (ABSAB and related) allow plaintext recovery if the same plaintext is encrypted under many keys (typical for HTTPS cookies). The cumulative impact: RFC 7465 (2015) prohibits RC4 in TLS; all major browsers removed RC4 support by 2016. RC4 remains a textbook example for why stream ciphers must have well-mixed key schedules. See also [RC4 Stream Cipher (Historical)](01-foundational-primitives.md#rc4-stream-cipher-historical) and [Legacy Stream Ciphers (Pre-eSTREAM Historical)](01-foundational-primitives.md#legacy-stream-ciphers-pre-estream-historical).

**State of the art:** RC4 deprecated; ChaCha20 / AES-GCM dominant. Bias-based plaintext recovery attacks formalized the requirement that stream ciphers be IND-CPA secure under multi-key plaintext repetition.

**Production readiness:** N/A (Attack)
Removed RC4 from TLS. Drives security requirements for new stream ciphers.

**Implementations:**
- [aircrack-ng](https://github.com/aircrack-ng/aircrack-ng) ⭐ 2.4k — C, FMS/PTW WEP-cracking
- [RC4-NOMORE PoC](https://www.rc4nomore.com/) — C, HTTPS cookie recovery exploit

**Security status:** Broken
RC4 thoroughly broken in both KSA (FMS, PTW) and output bias (NOMORE) directions. WEP completely broken.

**Community acceptance:** Standard
USENIX Security best papers; required reading for stream cipher design. RC4 removal from TLS by IETF consensus.

---

### Correlation Attacks on LFSR-Based Stream Ciphers

**Goal:** Exploit correlations between an LFSR-based stream cipher's output and individual LFSR outputs to recover initial states one LFSR at a time. The classic divide-and-conquer attack on combiner-based stream ciphers; motivated correlation-immune Boolean function design.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Siegenthaler's Correlation Attack** | 1985 | LFSR combiners | First systematic attack; exploits non-zero correlation between output and LFSR bits; complexity ~2^{n_i} per LFSR [[1]](https://ieeexplore.ieee.org/document/1057024) |
| **Fast Correlation Attack (Meier-Staffelbach)** | 1989 | LFSR combiners | Decoding the keystream as a noisy codeword from the LFSR's code; subexponential complexity [[1]](https://link.springer.com/article/10.1007/BF00188922) |
| **Iterative Decoding Variants** | 1999– | Modern LFSR ciphers | Johansson-Jönsson, Mihaljević-Imai use turbo/iterative decoding for FCA [[1]](https://link.springer.com/chapter/10.1007/3-540-48519-8_19) |
| **Algebraic Correlation Attack (Courtois)** | 2003 | Stream ciphers | Combines correlation with low-degree algebraic relations [[1]](https://link.springer.com/chapter/10.1007/978-3-540-39887-5_27) |
| **Real-Time A5/1 (Biryukov-Shamir-Wagner)** | 2000 | GSM A5/1 | Time-memory-data trade-off; 1 minute attack with 73 GB precomputed tables [[1]](https://link.springer.com/chapter/10.1007/3-540-44706-7_1) |

Siegenthaler showed that if a combining function f(x_1, ..., x_n) has correlation ε with input x_i, then with O(ε^{-2}) keystream bits one can recover the initial state of the corresponding LFSR by exhaustive search over its 2^{n_i} states (faster than the full 2^{Σ n_i} state). The defense — designing f to be correlation-immune — was Siegenthaler's other key result. Modern LFSR-based ciphers use NLFSRs and irregular clocking to defeat the attack, but the cryptanalytic principle (decode keystream as noisy codeword) is general and underlies many modern stream cipher attacks.

**State of the art:** Foundational technique. Modern designs (Grain, Trivium, ZUC) use NLFSR + irregular state updates to defeat direct correlation attacks. Fast correlation attacks improved via belief propagation, LDPC decoding.

**Production readiness:** N/A (Attack)
Defines correlation-immunity requirements for stream cipher design.

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, LFSR analysis and correlation testing
- [Cryptanalib](https://github.com/nccgroup/cryptanalib) ⭐ 305 — Python, includes correlation attack utilities

**Security status:** Broken (for naive LFSR combiners)
Foundational attack against any combiner without correlation immunity. Modern designs immune.

**Community acceptance:** Standard
Required design criterion. Siegenthaler's correlation immunity is in every stream cipher textbook.

---

### Time-Memory-Data Trade-Off Attacks (Hellman, BSW)

**Goal:** Trade precomputation memory for online attack time, breaking ciphers with effective key space below ~2^80 in practice. Hellman's 1980 paper introduced the TMTO concept; Biryukov-Shamir-Wagner extended it to stream ciphers; rainbow tables (Oechslin 2003) operationalized it for password cracking.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Hellman TMTO** | 1980 | Block ciphers | Precompute chains of f(K); recover K from given ciphertext via T·M² = N² where N = 2^k [[1]](https://ieeexplore.ieee.org/document/1056220) |
| **Rivest's Distinguished-Point Refinement** | 1982 | Hellman tables | Chain stopping points reduce hash chain merging; standard refinement [[1]](https://people.csail.mit.edu/rivest/pubs/Riv82a.pdf) |
| **Biryukov-Shamir-Wagner (BSW)** | 2000 | A5/1, stream ciphers | TMD trade-off: T·M²·D² = N²; exploits multiple available data points [[1]](https://link.springer.com/chapter/10.1007/3-540-44706-7_1) |
| **Rainbow Tables (Oechslin)** | 2003 | Password hashes | Variable-color reduction functions reduce false alarms; standard for unsalted password cracking [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45146-4_36) |
| **A5/1 Karsten Nohl Tables (Kraken)** | 2009 | GSM A5/1 | 2 TB precomputed tables; real-time A5/1 decryption on commodity hardware [[1]](https://srlabs.de/research/a5-cracking) |

Hellman's TMTO inverts a one-way function f: build chains x_0 → f(x_0) → f²(x_0) → ... → f^t(x_0); store only chain endpoints. To invert y, compute y, f(y), f²(y)... and check each against stored endpoints; if found, walk the chain to recover x. Trade-off: T·M² = N² where N is keyspace, T is time, M is memory. Stream cipher TMD variant (BSW 2000) further trades against available data D (multiple keystreams). Modern key sizes (≥128 bits) put N = 2^128 out of TMTO reach (N² = 2^256 storage); 64-bit keys (DES-equivalent) are still tractable, and 54-bit effective keys (A5/1) are very tractable. Salting password hashes defeats rainbow tables.

**State of the art:** TMTO defines effective security for ≤80-bit keys. Modern symmetric ciphers (128-bit+) immune. Rainbow-table-resistant password hashing requires salting; memory-hard KDFs (Argon2, scrypt) additionally resist TMTO. See [Password Hashing & Memory-Hard KDFs](01-foundational-primitives.md#password-hashing--memory-hard-kdfs).

**Production readiness:** N/A (Attack)
Drives password salting requirements (NIST SP 800-63B) and minimum effective key sizes.

**Implementations:**
- [Kraken (A5/1 cracker)](https://opensource.srlabs.de/projects/a51-decrypt) — C, real-time A5/1 decryption
- [RainbowCrack](http://project-rainbowcrack.com/) — C++, classic rainbow table tool
- [Hashcat](https://github.com/hashcat/hashcat) ⭐ 22k — C, GPU password cracking (rainbow tables, brute force, dictionary)

**Security status:** Broken (≤64-bit keys)
A5/1, 56-bit DES, unsalted password hashes broken. 128-bit ciphers safe.

**Community acceptance:** Standard
Hellman's TMTO is foundational. Rainbow tables transformed password cracking practice.

---

## Hash Function Cryptanalysis

---

### Wang's Differential Attacks on MD5 and SHA-1

**Goal:** Find collisions in widely-deployed Merkle-Damgård hash functions (MD5, SHA-1) via custom differential paths. Wang's 2004 attack on MD5 reduced collision finding from 2^64 (birthday bound) to 2^39 operations; SHA-1 collisions followed in 2017 (SHAttered) and 2020 (Shambles) with chosen-prefix variants.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **MD5 Pseudocollision (den Boer-Bosselaers)** | 1993 | MD5 compression | First attack on MD5 compression function; not a full collision [[1]](https://link.springer.com/chapter/10.1007/3-540-48285-7_26) |
| **Dobbertin's MD4 Collision** | 1996 | MD4 | First MD4 collision; 2^20 work [[1]](https://link.springer.com/chapter/10.1007/3-540-68697-5_18) |
| **Wang's MD5 Collision Attack** | 2004 | MD5 | 2^39 operations to find MD5 collisions; rendered MD5 broken for digital signatures [[1]](https://eprint.iacr.org/2004/199) |
| **Chosen-Prefix Collision (Stevens-Lenstra-de Weger)** | 2007 | MD5 | Collision with attacker-chosen distinct prefixes; used to forge Flame malware Microsoft Update certificate [[1]](https://eprint.iacr.org/2009/111) |
| **Wang's SHA-1 Attack** | 2005 | SHA-1 | 2^69 (later 2^63) operations for SHA-1 collision; theoretical at announcement [[1]](https://link.springer.com/chapter/10.1007/11535218_2) |
| **SHAttered (Stevens-Bursztein et al.)** | 2017 | SHA-1 | First practical SHA-1 collision; 6500 CPU-years + 100 GPU-years; two PDFs with same SHA-1 [[1]](https://shattered.io/) |
| **Shambles (Leurent-Peyrin)** | 2020 | SHA-1 chosen-prefix | First chosen-prefix SHA-1 collision; $45k cost; broke GnuPG WoT, Git collision-resistance claims [[1]](https://sha-mbles.github.io/) |
| **Marc Stevens' Counter-Cryptanalysis** | 2013 | MD5/SHA-1 | Detects whether a given input is part of a collision attack; deployed in Git, GnuPG [[1]](https://marc-stevens.nl/research/papers/EC13-S.pdf) |

Wang's breakthrough was a hand-crafted differential trail through the MD5 compression function that exploits the 4-step rotation structure to produce collisions far below the birthday bound. The path uses precise bit-level conditions on the intermediate state that hold with high probability after applying specific message modifications. Chosen-prefix variants (Stevens et al.) allow the attacker to fix two different prefixes and find a suffix making the hashes equal — the model relevant for X.509 certificate forgery. The Flame malware (2012) used a chosen-prefix MD5 collision to forge a Microsoft code-signing certificate. SHA-1 followed the same path: Wang 2005 theoretical attack, SHAttered 2017 first practical collision, Shambles 2020 chosen-prefix. After Shambles, all major Git hosting platforms (GitHub, GitLab) deployed Stevens' counter-cryptanalysis to detect colliding inputs.

**State of the art:** MD5 and SHA-1 broken for collision resistance. Use SHA-2/SHA-3/BLAKE3 for new designs. HMAC-MD5 and HMAC-SHA-1 are still secure (collision resistance not required for HMAC). NIST deprecated SHA-1 for signatures December 2030; CA/Browser Forum required SHA-1 sunset for certificates by 2017.

**Production readiness:** N/A (Attack)
MD5/SHA-1 deprecated everywhere except HMAC and legacy compatibility.

**Implementations:**
- [hashclash](https://github.com/cr-marcstevens/hashclash) ⭐ 832 — C++, MD5/SHA-1 collision generation framework
- [sha1collisiondetection](https://github.com/cr-marcstevens/sha1collisiondetection) ⭐ 1.4k — C, deployed in Git, GnuPG to flag colliding inputs

**Security status:** Broken
MD5 collisions in milliseconds on laptop. SHA-1 collisions feasible at $45k–$100k cost (chosen-prefix). HMAC-MD5/HMAC-SHA-1 remain secure (collision-resistance not required).

**Community acceptance:** Standard
Wang 2005 paper is most-cited hash cryptanalysis work. SHAttered/Shambles forced industry-wide SHA-1 migration.

---

### Length-Extension, Multi-Collision, and Herding Attacks

**Goal:** Three structural attacks on Merkle-Damgård hash functions that hold regardless of compression-function security: length extension (forge H(m∥pad∥m') given only H(m) and |m|), Joux multi-collisions (build 2^k collisions for cost k×birthday), and Kelsey-Kohno herding/Nostradamus (commit to a hash then later choose message). Motivated SHA-3's sponge structure and HMAC's nested design.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Length Extension** | known since Merkle-Damgård | MD5, SHA-1, SHA-2 | H(m∥pad∥m') computable from H(m) and |m| without knowing m; breaks naive MAC = H(K∥m); motivated HMAC design [[1]](https://en.wikipedia.org/wiki/Length_extension_attack) |
| **Joux Multi-Collisions** | 2004 | Any Merkle-Damgård | 2^k collisions for ~k·2^{n/2} work; breaks "concatenated hash" assumption H_1(m)∥H_2(m) [[1]](https://link.springer.com/chapter/10.1007/978-3-540-28628-8_19) |
| **Kelsey-Schneier Long-Message Second-Preimage** | 2005 | Any Merkle-Damgård | Second preimage for length-2^k message in 2^{n-k} work, not 2^n; motivates "wide-pipe" hashes [[1]](https://link.springer.com/chapter/10.1007/11426639_28) |
| **Kelsey-Kohno Herding (Nostradamus)** | 2006 | Any Merkle-Damgård | Commit to hash h, later find message ending with h; ~2^{2n/3} precomputation [[1]](https://link.springer.com/chapter/10.1007/11761679_12) |
| **Diamond Structures (Andreeva et al.)** | 2009 | Merkle-Damgård | Improves herding precomputation; generalizes Joux multi-collisions [[1]](https://link.springer.com/chapter/10.1007/978-3-642-01001-9_15) |

These attacks are structural: they don't break the compression function, but exploit Merkle-Damgård's iterative concatenation. Length extension is the most famous: if a system uses MAC = H(K∥m), an attacker can append message data and compute the correct MAC without knowing K. HMAC's nested structure (H((K⊕opad)∥H((K⊕ipad)∥m))) defeats length extension. Joux multi-collisions show that combining two independent hash functions does NOT double security (counter to folklore): H_1∥H_2 of n+n bits has only ~2^{n/2}·n collision resistance, not 2^n. Herding shows that a Merkle-Damgård hash function permits "predicting" a hash before knowing the message — relevant for timestamping and commit schemes. SHA-3 (Keccak) sponge construction is structurally immune to length extension; HMAC is required for SHA-1/SHA-2 MAC use.

**State of the art:** SHA-3, BLAKE3, and any "wide-pipe" hash structurally immune. SHA-2 vulnerable to length extension (use HMAC). HMAC-SHA-256 is the gold-standard MAC. See [Merkle-Damgård Construction](01-foundational-primitives.md#merkle-damgård-construction) and [Sponge Construction / Duplex](01-foundational-primitives.md#sponge-construction--duplex).

**Production readiness:** N/A (Attack)
Drives MAC construction requirements; mandated HMAC over naive H(K∥m).

**Implementations:**
- [hash_extender](https://github.com/iagox86/hash_extender) ⭐ 1.4k — C, length-extension exploit tool for MD5/SHA-1/SHA-2
- [SageMath](https://www.sagemath.org/) — Python/C, supports Joux multi-collision experiments

**Security status:** Broken (for naive Merkle-Damgård constructions)
H(K∥m) MAC is broken (use HMAC). Concatenated hash false-doubling is broken. SHA-3 immune.

**Community acceptance:** Standard
Joux multi-collision result is foundational; FSE/EUROCRYPT regulars. HMAC standardization (RFC 2104, NIST FIPS 198-1) was the direct response.

---

### Rebound Attack on Hash Functions

**Goal:** Find collisions or distinguishers in AES-like hash functions by relaxing the differential trail in the middle (where it's hardest) and matching forward/backward computation in two halves. The dominant technique against SHA-3 finalists (Grøstl, Whirlpool, ECHO, JH) and PHOTON.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Rebound Attack (Mendel-Rechberger-Schläffer-Thomsen)** | 2009 | Whirlpool, Grøstl | Finds high-probability differential trails in AES-like compression by "rebounding" in the middle [[1]](https://link.springer.com/chapter/10.1007/978-3-642-03317-9_16) |
| **Super-Sbox Cryptanalysis** | 2010 | AES-like compression | Treats two consecutive AES-like rounds as one larger S-box; tighter trail bounds [[1]](https://link.springer.com/chapter/10.1007/978-3-642-13858-4_3) |
| **Triangulation Attack** | 2011 | SHA-3 candidates | Combines rebound with multi-collision search [[1]](https://eprint.iacr.org/2011/098) |
| **Internal-Differential (Peyrin)** | 2010 | Grøstl, ECHO | Differentials between two parallel pipes inside the compression function [[1]](https://link.springer.com/chapter/10.1007/978-3-642-13858-4_22) |

Rebound: take a differential trail that has high probability on input and output but a problematic middle round where the trail probability is low. Instead of fixing input difference and propagating forward, choose middle-state differences satisfying the inbound part deterministically, then propagate forward and backward — the outbound trails are high-probability by design. Net effect is a near-collision or distinguisher attack significantly below brute force. Used to attack reduced-round Whirlpool, Grøstl, and ECHO during the SHA-3 competition.

**State of the art:** Standard tool for AES-like hash analysis. Full Whirlpool (10 rounds) still secure; reduced rounds attacked. SHA-3 Keccak is not AES-like — sponge structure is analyzed by other methods.

**Production readiness:** N/A (Attack)
Cryptanalysis technique; no production threat to full-round hashes.

**Implementations:**
- No standardized tool; attacks are paper-specific implementations.

**Security status:** Caution
Threatens reduced-round AES-like hash functions; full Whirlpool, full Grøstl secure.

**Community acceptance:** Standard
ASIACRYPT/EUROCRYPT regulars; required tool in AES-like hash analysis.

---

## Factoring and RSA-Specific Attacks

---

### Number Field Sieve and Quadratic Sieve (Factoring)

**Goal:** Factor large composite integers in subexponential time via algebraic number theory. The General Number Field Sieve (GNFS) is the asymptotically fastest known classical factoring algorithm; defines RSA key-size recommendations. The Quadratic Sieve (QS) is simpler and best for ~100-digit numbers.

| Algorithm | Year | Complexity | Note |
|-----------|------|------------|------|
| **Pollard's Rho (factoring)** | 1975 | O(N^{1/4}) expected | First subexponential probabilistic factoring; finds small factors quickly [[1]](https://link.springer.com/article/10.1007/BF01933667) |
| **Quadratic Sieve (Pomerance)** | 1981 | L_N[1/2, 1] | Best for ~80–120 digit numbers; sieves x² ≡ y² (mod N) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_18) |
| **Number Field Sieve (Pollard-Lenstra-Lenstra)** | 1990 | L_N[1/3, (64/9)^{1/3}] | Best known for general numbers; asymptotic improvement over QS [[1]](https://link.springer.com/article/10.1007/BF02351719) |
| **Special NFS (SNFS)** | 1993 | L_N[1/3, (32/9)^{1/3}] | When N has special form (e.g., Mersenne, Fermat); faster than GNFS [[1]](https://link.springer.com/chapter/10.1007/BFb0091537) |
| **RSA-768 Factoring** | 2009 | NFS practical record | 2 years × 80 cores; ~2^67 operations; broke 768-bit RSA [[1]](https://eprint.iacr.org/2010/006) |
| **RSA-829 Factoring** | 2020 | NFS state-of-art | 1024-bit boundary still safe; predicted at 2030 [[1]](https://lists.gforge.inria.fr/pipermail/cado-nfs-discuss/2019-December/001139.html) |

NFS represents N as the resultant of two polynomials f(x), g(x) over a number field; finds smooth norms in each, then combines via algebraic identities to construct x² ≡ y² (mod N) and thus a non-trivial factor via gcd(x − y, N). Linear algebra step (block Wiedemann or block Lanczos) dominates time; sieving is parallelizable. Quantum: Shor's algorithm factors in polynomial time (see [Quantum Cryptanalysis](#quantum-cryptanalysis)). Classical projections: 2048-bit RSA secure until ~2030 (NIST SP 800-57); 3072-bit recommended for new deployments; 4096-bit safe through 2040.

**State of the art:** RSA-2048 currently secure classically. NIST SP 800-57 recommends 3072-bit RSA for 128-bit security. Move to PQC (ML-KEM) for long-term protection against quantum attacks. See [NIST PQC Signature Standards](08-signatures-advanced.md#nist-pqc-signature-standards-ml-dsa--slh-dsa).

**Production readiness:** N/A (Attack / Algorithm)
Defines RSA key-size requirements. CADO-NFS is the production NFS code.

**Implementations:**
- [CADO-NFS](https://cado-nfs.gitlabpages.inria.fr/) — C, state-of-the-art NFS for factoring and DLP records
- [Msieve](https://github.com/radii/msieve) ⭐ 169 — C, GNFS + QS for general integer factoring
- [YAFU](https://sourceforge.net/projects/yafu/) — C, integrated factoring driver using QS/NFS/ECM

**Security status:** Broken (for ≤768-bit RSA)
RSA-768 broken (2009). RSA-1024 considered broken at state-actor scale. RSA-2048+ secure classically.

**Community acceptance:** Standard
Defines all RSA key-size recommendations. NIST/IETF reference algorithm for asymmetric security level.

---

### Pollard p−1, Williams p+1, and Lenstra ECM (Special Factoring)

**Goal:** Probabilistic factoring algorithms targeting integers with specific structure: composites with one factor p such that p−1 or p+1 is smooth (Pollard p−1, Williams p+1), or any composite with a moderate factor (Lenstra ECM uses elliptic curves to randomize per-attempt). These run faster than GNFS for finding moderate factors and motivate the "strong prime" criterion in RSA key generation.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Pollard's p−1** | 1974 | N with p−1 B-smooth | a^{B!} mod N gives gcd factor when p−1 is B-smooth; motivates strong primes [[1]](https://link.springer.com/article/10.1007/BF01933667) |
| **Williams' p+1** | 1982 | N with p+1 B-smooth | Lucas sequence analog of Pollard p−1; targets opposite primes [[1]](https://www.ams.org/journals/mcom/1982-39-159/S0025-5718-1982-0658219-0/) |
| **Lenstra Elliptic Curve Method (ECM)** | 1987 | N with factor < ~50 digits | Randomized via random EC; finds factors of size up to 80 digits in practice [[1]](https://www.ams.org/journals/mcom/1987-49-180/S0025-5718-1987-0905017-X/) |
| **Stage 2 with Brent-Suyama** | 1990 | All three | Birthday-paradox extension finds factors with non-smooth p±1 but smooth p±1 in extended range [[1]](https://link.springer.com/chapter/10.1007/3-540-44706-7_17) |

These special-purpose attacks exploit non-uniform prime distribution: if you've chosen p such that p−1 has only small factors, Pollard p−1 finds p in time O(B log B). The defense — choosing p such that (p−1)/2 is also prime (Sophie Germain prime, "strong prime") — was a standard RSA requirement until ECM made it less important (random-looking primes resist ECM equally well). Modern FIPS 186-5 still recommends strong primes for RSA but considers them not strictly necessary at 2048+ bits.

**State of the art:** Used to find factors below ~50–80 digits inside random composites; integral part of GNFS preprocessing pipeline. ECM record: 83-digit prime factor (2020). No threat to properly generated RSA-2048+ keys.

**Production readiness:** N/A (Attack)
Drives RSA key generation requirements (strong prime selection in some standards).

**Implementations:**
- [GMP-ECM](https://gitlab.inria.fr/zimmerma/ecm) — C, reference ECM/p−1/p+1 implementation
- [SymPy / Sage](https://www.sympy.org/) — Python, includes ECM, p−1
- [YAFU](https://sourceforge.net/projects/yafu/) — C, drives ECM/p−1/p+1 for general factoring

**Security status:** Broken (for weak-structure composites)
Easily breaks composites with smooth p−1 or p+1, or small factors. Properly generated RSA-2048 immune.

**Community acceptance:** Standard
Foundational algorithms; in every factoring textbook. CADO-NFS and other production tools use them as preprocessing.

---

### Wiener's Attack, Boneh-Durfee, and Coppersmith's Method

**Goal:** Recover RSA secret key d or partial plaintext when public exponent e is small, secret exponent d is small, or partial bit information is leaked. Wiener (1990): if d < N^{1/4}, d is recovered from continued fraction expansion of e/N. Boneh-Durfee (1999): improves to d < N^{0.292}. Coppersmith's method (1996): finds small roots of low-degree polynomials mod N, enabling many partial-information attacks.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Wiener's Attack** | 1990 | RSA with d < N^{1/4} | Continued fraction expansion of e/N reveals d; basis for "small d" warnings [[1]](https://ieeexplore.ieee.org/document/54902) |
| **Boneh-Durfee Attack** | 1999 | RSA with d < N^{0.292} | Lattice-based extension via Coppersmith; tightens Wiener bound [[1]](https://link.springer.com/chapter/10.1007/3-540-48910-X_1) |
| **Coppersmith's Method (Small Roots)** | 1996 | Low-degree polynomials mod N | Finds roots ≤ N^{1/d} of degree-d polynomial mod N using LLL lattice reduction [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_15) |
| **Hastad's Broadcast Attack** | 1988 | RSA-3, multiple recipients | Same m encrypted under e=3 with 3 different (N_i, 3); CRT + cube root recovers m [[1]](https://epubs.siam.org/doi/10.1137/0217019) |
| **Common Modulus Attack** | 1983 | RSA with shared N | Two users sharing modulus N with coprime e_1, e_2 leak each other's plaintexts [[1]](https://link.springer.com/chapter/10.1007/3-540-48184-2_32) |
| **Bleichenbacher e=3 Signature Forgery** | 2006 | RSA-PKCS#1v1.5 with e=3 | Signature parsing bug allowed e=3 forgeries trivially; affected OpenSSL, GnuTLS, NSS [[1]](https://mailarchive.ietf.org/arch/msg/openpgp/5rnE9ZRN1AokBVj3VqblGlP63QE/) |
| **Howgrave-Graham Refinement** | 1997 | Coppersmith's method | Improved lattice construction; standard implementation [[1]](https://link.springer.com/chapter/10.1007/BFb0024458) |

Wiener's elegant continued-fraction attack works because d satisfies ed ≡ 1 (mod φ(N)) and for small d, e/N is a good rational approximation to d^{-1}/φ(N). Coppersmith's method is more general and underlies dozens of attacks: small e RSA stereotyped plaintexts (e.g., known half of message), partial private key exposure, factoring N with high-bit p known, RSA-CRT fault attacks. Boneh's 1999 survey "Twenty Years of Attacks on the RSA Cryptosystem" is the standard reference. Bleichenbacher's e=3 forgery exploited buggy PKCS#1v1.5 padding-check code (not the algorithm itself); was independently rediscovered multiple times.

**State of the art:** Wiener / Boneh-Durfee mostly historical: RSA implementations always use large d (typically d ≈ N). Coppersmith's method remains active — ROCA (2017) used a Coppersmith variant against Infineon RSALib keys. Bleichenbacher e=3 signature forgery has surfaced periodically in implementation bugs (most recently in Apple iOS 2024).

**Production readiness:** N/A (Attack)
Drives RSA standard parameter recommendations: large d, e ≥ 65537, careful padding parsing.

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, Wiener's attack and Coppersmith's method (`small_roots()`)
- [RsaCtfTool](https://github.com/RsaCtfTool/RsaCtfTool) ⭐ 6k — Python, includes Wiener, Boneh-Durfee, Hastad, Coppersmith CTF attacks

**Security status:** Broken (for bad parameters)
Small-d RSA, small-e with stereotyped plaintexts, shared-modulus RSA all broken. Standard RSA (e=65537, d ≈ N, unique N) immune.

**Community acceptance:** Standard
Boneh's "Twenty Years of Attacks on RSA" is the standard reference. Coppersmith's method is foundational; every cryptanalysis textbook covers it.

---

### ROCA Attack (Infineon RSA Library)

**Goal:** Factor RSA public keys generated by Infineon's RSALib (used in TPM chips, Estonian e-ID cards, Yubikey 4, smart cards). The library used a flawed RSA prime generation algorithm — primes have a specific structure that Coppersmith's method can exploit, factoring 2048-bit keys in ~140 CPU-years (feasible at state-actor cost).

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **ROCA (Nemec-Sýs-Svenda-Klinec-Matyas)** | 2017 | Infineon RSALib keys | CVE-2017-15361; fingerprintable public keys; 1024-bit factored in 97 days, 2048-bit in ~140 CPU-years [[1]](https://crocs.fi.muni.cz/public/papers/rsa_ccs17) |
| **Coppersmith-Based Factorization** | 2017 | Structured RSA primes | Uses Howgrave-Graham implementation of Coppersmith on ROCA-fingerprinted primes [[1]](https://crocs.fi.muni.cz/public/papers/rsa_ccs17) |

Infineon's RSALib generated primes of the form p = k·M + (65537^a mod M) where M is a fixed primorial product (product of small primes). This structure makes the prime fingerprintable from the public key alone (no factoring needed to detect), and Coppersmith's method finds the factor k in polynomial time once the structure is known. Estonian government revoked 750,000 e-ID cards using ROCA-vulnerable Infineon chips. Yubikey 4 firmware was patched. The attack is a case study in how supply-chain library bugs propagate across the smartcard ecosystem.

**State of the art:** Patched in firmware updates for affected products; vulnerable cards revoked. ROCA-test is standard in modern key-validation tools.

**Production readiness:** N/A (Attack)
Forced revocation of large national-ID deployments; reshaped industry expectations for cryptographic library auditing.

**Implementations:**
- [roca-detect](https://github.com/crocs-muni/roca) ⭐ 460 — Python, fingerprint detection for ROCA-vulnerable keys
- [roca-attack](https://github.com/FlorianPicca/ROCA-Attack) ⭐ 50 — Python, full ROCA factoring exploit (Coppersmith-based)

**Security status:** Broken
Any Infineon RSALib key generated pre-patch is broken. ROCA-fingerprinted keys must be revoked.

**Community acceptance:** Standard
ACM CCS 2017 best paper. Industry-wide migration; informed FIPS 140-3 prime-generation requirements.

---

## Lattice-Based Cryptanalysis

---

### LLL and BKZ Lattice Reduction

**Goal:** Find short vectors in integer lattices in polynomial time (LLL) or with adjustable trade-off between time and approximation factor (BKZ). The foundational tools of lattice cryptanalysis — used to attack knapsack PKE, low-d RSA (Wiener-like), partial-key recovery in ECDSA, and to estimate concrete security of lattice-based PQC.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **LLL Algorithm (Lenstra-Lenstra-Lovász)** | 1982 | SVP approximation | Polynomial-time, 2^{n/2}-approximation; foundational lattice basis reduction [[1]](https://link.springer.com/article/10.1007/BF01457454) |
| **L²/L³/L^∞ LLL variants** | 1986–2007 | LLL refinements | Improved numerical stability and asymptotic complexity [[1]](https://link.springer.com/article/10.1007/BF01200970) |
| **BKZ (Block Korkin-Zolotarev)** | 1994 | Tighter SVP approximation | Trade time for tighter shortness; BKZ-β with block size β; standard tool for hardness estimation [[1]](https://link.springer.com/article/10.1007/BF01581144) |
| **BKZ 2.0 (Chen-Nguyen)** | 2011 | Practical BKZ | Pruning + extreme pruning; basis of modern BKZ-based concrete security analysis [[1]](https://link.springer.com/chapter/10.1007/978-3-642-25385-0_1) |
| **G6K / Sieving (Becker-Ducas-Gama-Laarhoven)** | 2016 | SVP exact / approximate | Lattice sieving using locality-sensitive hashing; current SVP record holders [[1]](https://eprint.iacr.org/2015/1128) |

LLL is the most-cited algorithm in computational number theory: given a lattice basis B, output a reduced basis where the first vector is at most 2^{n/2}-times the shortest. Even this loose approximation is enough for Coppersmith's method, knapsack cryptanalysis, finding rational reconstructions in cryptanalysis. BKZ generalizes: with block size β, it computes a 2^O(β)-approximation of SVP in time exponential in β. Modern PQC parameter selection (Kyber, Dilithium) is calibrated by estimating BKZ-β work to break LWE — the "core-SVP hardness" model. Lattice sieving (G6K, BDGL) is asymptotically faster than enumeration for large β and has set SVP records (β > 180 as of 2025).

**State of the art:** LLL universal in computer algebra. BKZ + G6K is the state-of-the-art concrete attack on lattice problems; informs Kyber/Dilithium parameter choices. See [NIST PQC Signature Standards](08-signatures-advanced.md#nist-pqc-signature-standards-ml-dsa--slh-dsa) and [Falcon / FN-DSA](08-signatures-advanced.md#falcon--fn-dsa-ntru-based-lattice-signatures).

**Production readiness:** N/A (Attack / Algorithm)
Defines concrete security level of all lattice-based PQC.

**Implementations:**
- [fplll](https://github.com/fplll/fplll) ⭐ 462 — C++, reference LLL/BKZ/G6K implementation; standard cryptanalysis benchmark
- [G6K](https://github.com/fplll/g6k) ⭐ 138 — C++/Python, advanced lattice sieving
- [NTL](https://libntl.org/) — C++, alternative LLL implementation (Shoup)
- [SageMath](https://www.sagemath.org/) — Python/C, calls fplll/NTL backends

**Security status:** Broken (for small lattices) / Defines hardness (for cryptographic lattices)
LLL/BKZ are tools, not attacks per se. They define the practical hardness of all lattice-based PQC.

**Community acceptance:** Standard
LLL won IBM Information Award. BKZ is the universal benchmark for lattice-based cryptography hardness estimation. Annual SVP/LWE challenge records track progress.

---

### Hidden Number Problem and ECDSA Nonce Bias Attacks

**Goal:** Recover an ECDSA/DSA private key when partial information about per-signature nonces leaks (e.g., a few bits, biased distribution). The Hidden Number Problem (HNP) framework reduces nonce-bias key recovery to lattice short-vector search, solvable via LLL/BKZ. Many real-world ECDSA breaks (PlayStation 3, TLS implementations, Bitcoin wallets) result from nonce bias.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Hidden Number Problem (Boneh-Venkatesan)** | 1996 | Diffie-Hellman MSB | First formalization: recover x from partial MSBs of t_i x mod p; LLL-based [[1]](https://link.springer.com/chapter/10.1007/3-540-68697-5_11) |
| **Nguyen-Shparlinski (HNP-DSA)** | 2002 | DSA with biased nonces | Few-bit nonce leaks → lattice attack recovers signing key [[1]](https://link.springer.com/article/10.1007/s00145-002-0021-3) |
| **Lattice Attack on PS3 ECDSA** | 2010 | PlayStation 3 firmware signing | Sony used fixed nonce; trivial key recovery [[1]](https://events.ccc.de/congress/2010/Fahrplan/events/4087.en.html) |
| **Minerva (Jančar et al.)** | 2020 | ECDSA timing leaks | Cache/timing side-channels reveal nonce MSBs; affected Athena IDProtect, NXP cards [[1]](https://minerva.crocs.fi.muni.cz/) |
| **TPM-FAIL (Moghimi et al.)** | 2020 | Intel fTPM, STMicro TPM | Side-channel leak of nonce MSBs from TPM ECDSA [[1]](https://tpm.fail/) |
| **LadderLeak (Aranha et al.)** | 2020 | OpenSSL ECDSA | Single-bit nonce leak enables practical attack [[1]](https://eprint.iacr.org/2020/615) |
| **Polynonce (Stoneberg)** | 2022 | Bitcoin transactions | Heuristic recovery from polynomial-nonce reuse across blockchain transactions [[1]](https://research.kudelskisecurity.com/2023/03/06/polynonce-a-tale-of-a-novel-ecdsa-attack-and-bitcoin-tears/) |

The framework: collect N ECDSA signatures with known message hashes h_i. Each gives equation k_i = h_i + x·r_i / s_i mod q. If each k_i has known bits (e.g., top k bits = 0), we get an HNP instance: find x given partial MSBs of (a_i x + b_i) mod q. This becomes a lattice problem (find a short vector encoding x); LLL/BKZ solves it for as few as 2–4 leaked bits per signature with ~100 signatures. Mitigation: deterministic ECDSA (RFC 6979) eliminates per-signature randomness, replacing it with HMAC-based deterministic nonces; Ed25519 by construction has no nonce-bias risk.

**State of the art:** Deterministic ECDSA (RFC 6979) standard in modern stacks; Ed25519 preferred. Side-channel-protected implementations critical for TPM/HSM/smartcard ECDSA. Bitcoin libraries use RFC 6979. See [ECDSA — Details, Vulnerabilities, and RFC 6979](08-signatures-advanced.md#ecdsa--details-vulnerabilities-and-rfc-6979).

**Production readiness:** N/A (Attack)
Drives deterministic ECDSA adoption and side-channel hardening.

**Implementations:**
- [HNP-LLL solvers in SageMath](https://www.sagemath.org/) — Python/C, generic HNP via LLL
- [ecdsa-key-recovery](https://github.com/bitlogik/lattice-attack) ⭐ 220 — Python, ECDSA lattice attack from biased nonces

**Security status:** Broken (when nonces are biased)
Any ECDSA/DSA implementation with biased nonces leaks the private key. Standard RFC 6979 and side-channel-protected implementations safe.

**Community acceptance:** Standard
Real-world breakages (PS3, TPM-FAIL, Minerva, LadderLeak, Polynonce) have made HNP-nonce-bias the canonical example of side-channel cryptanalysis. Every TPM/HSM evaluation includes nonce-bias testing.

---

## Quantum Cryptanalysis

---

### Shor's Algorithm (Quantum Factoring and Discrete Log)

**Goal:** Solve integer factoring and discrete logarithm in polynomial time on a sufficiently large quantum computer. Shor's algorithm (1994) breaks all classical public-key cryptography based on integer factorization (RSA), discrete log in F_p* (DH, DSA), and elliptic curve discrete log (ECDH, ECDSA, Ed25519). The driving force behind the global PQC migration.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Shor's Algorithm** | 1994 | Integer factoring, DLP, ECDLP | Quantum period finding via QFT; O((log N)^3) gates for factoring [[1]](https://ieeexplore.ieee.org/document/365700) |
| **Proos-Zalka ECDLP** | 2003 | ECDLP | Adaptation to elliptic curves; ~2300 logical qubits for 256-bit ECC [[1]](https://arxiv.org/abs/quant-ph/0301141) |
| **Gidney-Ekerå 2019** | 2019 | RSA-2048 | Concrete resource estimate: ~20M noisy physical qubits, 8 hours; current state-of-the-art [[1]](https://arxiv.org/abs/1905.09749) |
| **Litinski Surface Code 2023** | 2023 | RSA-2048 | Improved compilation: ~1M physical qubits, days runtime; still beyond current hardware [[1]](https://arxiv.org/abs/2306.08585) |

Shor's core insight: factoring N reduces to finding the period r of f(x) = a^x mod N for random a; once r is known, gcd(a^{r/2} ± 1, N) yields factors of N with high probability. Quantum period finding (via Quantum Fourier Transform) runs in polynomial time, vs. subexponential GNFS classically. The same period-finding solves discrete log in any cyclic group, including elliptic curve groups (Proos-Zalka 2003). Current quantum hardware (~1000 physical qubits, error rate ~10^{-3}) is many orders of magnitude below RSA-2048 requirements (~10M–20M physical qubits with surface-code error correction). Best estimates place RSA-2048 break ~15–30 years out under standard NIST timelines.

**State of the art:** Theoretically catastrophic; practically not yet feasible. NIST PQC standardization (Aug 2024: ML-KEM, ML-DSA, SLH-DSA) is the global response. "Harvest now, decrypt later" attacks on stored ciphertexts drive urgency. See [NIST PQC Signature Standards](08-signatures-advanced.md#nist-pqc-signature-standards-ml-dsa--slh-dsa).

**Production readiness:** N/A (Future Attack)
No current quantum computer can run Shor against any cryptographically meaningful key. Drives PQC migration policy (CNSA 2.0, EU EUCC, NIST IR 8547 mandates).

**Implementations:**
- [Qiskit Shor demo](https://github.com/Qiskit/qiskit-textbook) ⭐ 2.4k — Python, simulated Shor for small N (≤21)
- [Google Cirq](https://github.com/quantumlib/Cirq) ⭐ 4.4k — Python, programmable quantum simulators
- [QECC simulators](https://github.com/quantumlib/Stim) ⭐ 481 — C++, surface-code fault-tolerant simulation

**Security status:** Broken (post-quantum)
All classical PKE/signatures based on factoring or discrete log are broken under sufficiently large fault-tolerant quantum computer. Migration to PQC required.

**Community acceptance:** Standard
Universally accepted; basis of NIST PQC standardization. ACM Turing Award 2024 went to Avi Wigderson partly for related complexity work.

---

### Grover's Algorithm (Quantum Search)

**Goal:** Search an unstructured space of size N in O(√N) quantum queries, providing quadratic speedup over classical brute force. Reduces effective symmetric-key security from k bits to k/2 bits — motivating AES-256 over AES-128 for long-term post-quantum security.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Grover's Algorithm** | 1996 | Unstructured search | O(√N) quantum queries to find marked item; provably optimal [[1]](https://dl.acm.org/doi/10.1145/237814.237866) |
| **Amplitude Amplification (Brassard-Høyer-Mosca-Tapp)** | 2002 | Generic search | Generalizes Grover; gives √N speedup for many problems beyond pure search [[1]](https://arxiv.org/abs/quant-ph/0005055) |
| **Quantum Collision Search (BHT)** | 1997 | Hash collisions | Quantum collision finding in O(N^{1/3}) vs classical N^{1/2}; reduces hash output requirements [[1]](https://link.springer.com/chapter/10.1007/BFb0054319) |

Grover's algorithm finds a target x with f(x) = 1 in unstructured search space of size N using O(√N) queries — a quadratic speedup, provably optimal. For AES-128 brute-force key search: classical 2^128, quantum ~2^64. NIST PQC security categories: Category 1 = AES-128 equivalent post-quantum (effectively requiring symmetric keys ≥ 256 bits or quantum-resistant 128-bit security under Grover). Quantum collision search (BHT) gives O(N^{1/3}) collision finding vs classical O(N^{1/2}), reducing the security level of n-bit hashes from n/2 to n/3 under quantum attack — motivating SHA-256+ for post-quantum collision resistance. Importantly, Grover speedups are quadratic, not exponential like Shor — doubling key size fully restores classical security against Grover.

**State of the art:** Post-quantum symmetric security requires doubled key sizes. AES-256 provides 128-bit post-quantum security (Grover-resistant). SHA-256 provides ~85-bit collision security under BHT — SHA-384 / SHA-512 preferred for post-quantum collision resistance. NIST PQC Categories 5 = AES-256 Grover-equivalent.

**Production readiness:** N/A (Future Attack)
Drives "double the key size" recommendation for symmetric crypto in PQC migration. CNSA 2.0 mandates AES-256 and SHA-384 for top-secret data.

**Implementations:**
- [Qiskit / Cirq Grover demos](https://github.com/Qiskit/qiskit-textbook) ⭐ 2.4k — Python, small-N Grover simulations
- [BHT collision search demos](https://github.com/quantumlib/Cirq) ⭐ 4.4k — Python, hash collision quantum simulators

**Security status:** Reduced (post-quantum)
AES-128 effectively 64-bit; AES-256 effectively 128-bit post-quantum. SHA-256 collision resistance ~85 bits under BHT.

**Community acceptance:** Standard
Foundational quantum algorithm. NIST PQC Categories explicitly defined relative to AES-128/192/256 Grover-equivalent levels.

---

### Simon's, Kuperberg's, and Other Quantum Subroutine Attacks

**Goal:** Specialized quantum algorithms beyond Shor and Grover that target specific cryptographic structures: Simon's algorithm (1994) breaks symmetric constructions with hidden-period structure (e.g., CBC-MAC with chosen-plaintext queries); Kuperberg's algorithm (2003) breaks hidden-subgroup problems including some isogeny-based PKE; quantum random walks attack lattice problems and graph isomorphism.

| Algorithm | Year | Target | Note |
|-----------|------|--------|------|
| **Simon's Algorithm** | 1994 | Hidden XOR period | Polynomial-time on quantum; broke Even-Mansour and several MAC constructions under quantum CPA model [[1]](https://epubs.siam.org/doi/10.1137/S0097539796298637) |
| **Kuperberg's Algorithm** | 2003 | Dihedral hidden subgroup | Subexponential 2^O(√log N); attacks CSIDH and similar isogeny PKE [[1]](https://arxiv.org/abs/quant-ph/0302112) |
| **Kaplan-Leurent-Leverrier-Naya-Plasencia 2016** | 2016 | Symmetric MACs (quantum) | Quantum CPA model breaks CBC-MAC, GCM, OCB in polynomial time via Simon's [[1]](https://eprint.iacr.org/2016/197) |
| **Regev's Quantum Reduction** | 2009 | LWE worst-case to average-case | Connects worst-case lattice problems to LWE; classical analogue followed in 2013 [[1]](https://arxiv.org/abs/0810.4351) |
| **Childs-Jordan-Soeken Walking** | 2010+ | Lattice problems | Quantum random walks improve some lattice approximation algorithms [[1]](https://arxiv.org/abs/1004.4528) |

Simon's algorithm finds a hidden XOR period s such that f(x) = f(x⊕s) using O(n) quantum queries (vs O(2^{n/2}) classically). In the quantum chosen-plaintext model where attackers can superposition-query the encryption oracle, Simon's breaks many block-cipher modes — but the "quantum CPA" model is not realistic for most deployments since attackers don't have physical access to quantum query interfaces. Kuperberg's algorithm has more practical relevance: it solves the dihedral hidden subgroup problem and applies directly to CSIDH-style isogeny PKE, giving subexponential 2^O(√log N) attack. This is why NIST PQC isogeny submissions (SIKE) were ruled out — and even though SIKE was broken classically (Castryck-Decru 2022), Kuperberg's algorithm independently weakens the broader isogeny-PKE family. See [SQIsign](08-signatures-advanced.md#sqisign-isogeny-based-signatures).

**State of the art:** Simon's attacks on symmetric crypto remain theoretical (quantum CPA model unrealistic). Kuperberg's attack constrains isogeny PKE parameter sizes (CSIDH-512 currently considered ~80-bit secure under Kuperberg, not the 256-bit claim). PQC NIST process explicitly avoided isogeny-PKE.

**Production readiness:** N/A (Future Attack)
Influences PQC scheme selection — isogeny-PKE under Kuperberg pressure; symmetric crypto less affected.

**Implementations:**
- [SageMath](https://www.sagemath.org/) — Python/C, Simon's algorithm simulation for small instances
- [Q# simulators](https://github.com/microsoft/Quantum) ⭐ 4.6k — Q#, Microsoft Quantum Development Kit

**Security status:** Reduced (in specific models)
Symmetric: Q-CPA attacks via Simon's are non-realistic but theoretically valid. Isogeny PKE: Kuperberg's reduces effective security significantly.

**Community acceptance:** Standard
Active research area; CRYPTO/EUROCRYPT regulars. Kaplan-Leurent-Leverrier-Naya-Plasencia is the canonical reference for quantum symmetric cryptanalysis.

---

## Protocol-Level Attacks

---

### Bleichenbacher's Attack / ROBOT

**Goal:** Exploit RSA PKCS#1 v1.5 padding structure as a chosen-ciphertext oracle to decrypt RSA ciphertexts or sign arbitrary messages. The 1998 attack uses adaptive queries to a TLS server; the 2017 ROBOT re-discovery found the same vulnerability in 27 top-1M HTTPS hosts, including Facebook, PayPal, and Citrix.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Bleichenbacher's Attack** | 1998 | RSA-PKCS#1v1.5 / SSL | Adaptive CCA2 using padding oracle; 1M queries decrypts session key or forges signatures [[1]](https://link.springer.com/chapter/10.1007/BFb0055716) |
| **ROBOT (Böck-Somorovsky-Young)** | 2017 | TLS 1.2 RSA key exchange | Re-discovery; 27 of top-100 HTTPS sites vulnerable; CVE-2017-13099 et al. [[1]](https://robotattack.org/) |
| **Marvin Attack (Huber et al.)** | 2023 | RSA-PKCS#1v1.5 / TLS | Timing-only oracle variant; exploits RSA implementation timing even without explicit error messages [[1]](https://people.redhat.com/~hkario/marvin/) |

RSA PKCS#1 v1.5 padding requires ciphertexts to decrypt to bytes of the form 0x00 0x02 [nonzero bytes] 0x00 [message]. If the decryption server returns a different error for padding-malformed vs. length-malformed outputs, it acts as an oracle. Bleichenbacher's adaptive attack exploits this: multiply the ciphertext by a random factor, submit to oracle, and use the oracle's yes/no to binary-search for the message. With ~10^6 queries, a 1024-bit RSA session key is recovered. The correct fix is RSA-OAEP (RFC 8017) or ECDHE key exchange; RSA-PKCS#1v1.5 in TLS key exchange should not be used. TLS 1.3 removed RSA key transport entirely, eliminating the attack surface.

**State of the art:** TLS 1.3 eliminates RSA key transport; OAEP is safe for RSA encryption. Bleichenbacher-style attacks remain relevant wherever PKCS#1 v1.5 RSA is deployed (legacy TLS 1.2, S/MIME, custom protocols). The Marvin timing variant (2023) shows that even "constant-time" RSA implementations may leak timing side-channels.

**Production readiness:** N/A (Attack)
Practical against any RSA-PKCS#1v1.5 oracle. Mitigated by TLS 1.3, RSA-OAEP, or ECDHE key exchange.

**Implementations:**
- [ROBOT Attack PoC](https://github.com/robotattack/robot-detect) ⭐ 418 — Python, scanner + exploit PoC for ROBOT

**Security status:** Broken
RSA-PKCS#1v1.5 in key transport contexts is broken. RSA-OAEP and ephemeral ECDHE are the correct replacements. TLS 1.3 is immune by design.

**Community acceptance:** Standard
Classic attack; required reading for TLS security. ROBOT won USENIX Security 2018 Distinguished Paper. Marvin (2023) extends the threat to timing-only scenarios.

---

### DROWN Attack (CVE-2016-0800)

**Goal:** Decrypt modern TLS 1.2 RSA-encrypted sessions by using SSLv2 (sharing the same server private key) as a cross-protocol Bleichenbacher oracle. An SSLv2 export-grade cipher suite allows adaptive chosen-ciphertext queries at low cost; recovered premaster secrets decrypt the TLS session.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **DROWN (Decrypting RSA with Obsolete and Weakened eNcryption)** | 2016 | TLS 1.2 + SSLv2 | Cross-protocol attack; 40-bit export RSA in SSLv2 enables Bleichenbacher oracle; ~$440 AWS compute per session [[1]](https://drownattack.com/) |
| **Special DROWN** | 2016 | OpenSSL SSLv2 | Exploits additional OpenSSL SSLv2 bug; reduces query count from 40k to ~250; 1 minute attack time [[1]](https://drownattack.com/) |

DROWN requires a server that: (1) uses RSA key exchange in TLS 1.2, and (2) shares the same private key with any SSLv2-enabled server. At disclosure, 33% of HTTPS servers were vulnerable. The attack uses the SSLv2 export-grade 40-bit RSA to execute Bleichenbacher-style queries — the weak cipher drastically reduces query count and cost. The result decrypts the TLS 1.2 RSA premaster secret, compromising the session. The fix is to disable SSLv2 completely and to not share RSA keys across protocols. TLS 1.3 (forward-secret ECDHE only, no RSA key transport) is immune. Related: [Bleichenbacher's Attack / ROBOT](#bleichenbachers-attack--robot).

**State of the art:** Patched in all major TLS stacks (OpenSSL 1.0.2g, 2016). TLS 1.3 structurally eliminates the attack. Legacy TLS 1.2 deployments sharing RSA keys with any SSLv2-capable server remain vulnerable.

**Production readiness:** N/A (Attack)
Patched. TLS 1.3 eliminates attack surface. Historical significance: forced mass retirement of SSLv2 and export-grade cipher suites.

**Implementations:**
- [DROWN Attack tools](https://github.com/nimia/public_drown_scanner) ⭐ 126 — Python, original DROWN scanner

**Security status:** Broken
SSLv2 + RSA key sharing is broken. All modern TLS stacks with SSLv2 disabled are safe. TLS 1.3 immune.

**Community acceptance:** Standard
USENIX Security 2016. Accelerated global retirement of SSLv2 and export cipher suites. Required reading for TLS security history.

---

### Padding Oracle Attacks (Vaudenay) and CBC-Mode TLS Attacks (BEAST, POODLE, Lucky 13)

**Goal:** Recover plaintext from CBC-mode ciphertexts by abusing decryption error responses (padding-oracle), predictable IVs (BEAST), protocol downgrade to vulnerable CBC modes (POODLE), or timing side-channels in MAC verification (Lucky 13). Forced the deprecation of TLS CBC-mode ciphersuites in favor of AEAD (GCM, ChaCha20-Poly1305).

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Padding Oracle (Vaudenay)** | 2002 | CBC + PKCS#7 padding | Server returns distinct error for bad padding vs bad MAC; byte-by-byte plaintext recovery in O(256·blocks) queries [[1]](https://link.springer.com/chapter/10.1007/3-540-46035-7_35) |
| **BEAST (Duong-Rizzo)** | 2011 | TLS 1.0 CBC | Predictable IVs (last ciphertext block) + adaptive chosen plaintext; recovers session cookies byte-by-byte; CVE-2011-3389 [[1]](https://vnhacker.blogspot.com/2011/09/beast.html) |
| **POODLE (Möller-Duong-Kotowicz)** | 2014 | SSLv3 CBC | Padding oracle in SSLv3 (no precise MAC-then-encrypt verification); forced SSLv3 retirement; CVE-2014-3566 [[1]](https://www.openssl.org/~bodo/ssl-poodle.pdf) |
| **POODLE-TLS** | 2014 | TLS 1.0–1.2 (vulnerable impls) | Same attack on TLS implementations that did not strictly validate padding (F5, A10) [[1]](https://www.imperialviolet.org/2014/12/08/poodleagain.html) |
| **Lucky 13 (AlFardan-Paterson)** | 2013 | TLS CBC-mode HMAC verification | Timing side-channel in MAC verification reveals plaintext via padding-oracle-like recovery; CVE-2013-0169 [[1]](http://www.isg.rhul.ac.uk/tls/Lucky13.html) |
| **Lucky 13 ECB Variant (PWG)** | 2013 | DTLS, AES-CBC-SHA | Variant attacks on DTLS implementations; affected GnuTLS, NSS, MatrixSSL [[1]](http://www.isg.rhul.ac.uk/tls/Lucky13.html) |

Vaudenay's padding oracle is foundational: if a CBC decryptor distinguishes "bad padding" from "bad MAC" (via error code, timing, or behavior), the attacker recovers plaintext byte-by-byte. The standard fix is constant-time validation that always returns the same error regardless of padding validity (achieved via MAC-then-encrypt order — encrypt-then-MAC is structurally immune). BEAST exploits CBC's chained-IV: in TLS 1.0, ciphertext block C_n is the IV for the next record, and the attacker can adaptively prepend chosen plaintext to recover a target byte. Mitigations: 1/n-1 record splitting (kludge); upgrade to TLS 1.1+ (explicit per-record IV). POODLE exploits SSLv3's loose padding spec, where the last byte indicates pad length but the other bytes are ignored — server can't detect bit flips in padding. Lucky 13 (Lucky Number 13 attack) exploits HMAC timing for TLS records: the number of SHA-1 compression steps depends on the message length after padding removal; this timing leak gives a padding-validity oracle indirectly. All these motivated AEAD-only TLS 1.3.

**State of the art:** TLS 1.3 structurally immune (AEAD only, no CBC). TLS 1.2 with AES-GCM or ChaCha20-Poly1305 is safe. CBC ciphersuites should be disabled. SSLv3 was fully retired (RFC 7568, 2015) following POODLE.

**Production readiness:** N/A (Attack)
Forced wholesale TLS migration to AEAD ciphersuites; SSLv3 retired; CBC ciphersuites deprecated in TLS 1.3.

**Implementations:**
- [TLS-Attacker](https://github.com/tls-attacker/TLS-Attacker) ⭐ 904 — Java, framework for TLS attack testing (BEAST, POODLE, Lucky 13)
- [PadBuster](https://github.com/AonCyberLabs/PadBuster) ⭐ 760 — Perl, automated padding oracle exploitation tool
- [poodleScan](https://github.com/thomaspatzke/POODLE-PoC) — Python, SSLv3 POODLE proof-of-concept

**Security status:** Broken (for vulnerable configurations)
SSLv3, TLS 1.0 CBC, and any padding-oracle-vulnerable implementation broken. TLS 1.2 AES-GCM and TLS 1.3 immune.

**Community acceptance:** Standard
USENIX Security best papers for Lucky 13 and POODLE. Vaudenay's padding oracle is in every applied crypto textbook.

---

### Compression-Side-Channel Attacks (CRIME, BREACH, TIME, HEIST)

**Goal:** Extract secrets (session cookies, CSRF tokens) by observing the size of compressed-then-encrypted HTTPS responses. Compression aggregates repeated strings; if the attacker's chosen plaintext shares a prefix with the secret, the compressed output is shorter — leaking secret bytes via response size. Forced disabling of TLS-level compression and HTTP-level compression of sensitive responses.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **CRIME (Rizzo-Duong)** | 2012 | TLS compression | TLS 1.0/1.1 deflate compression + chosen-plaintext recovers session cookies; CVE-2012-4929 [[1]](https://docs.google.com/presentation/d/11eBmGiHbYcHR9gL5nDyZChu_-lCa2GizeuOfaLU2HOU/edit) |
| **TIME (Be'ery-Shulman)** | 2013 | HTTP compression timing | Same idea but via TCP timing instead of payload size; works through any TLS [[1]](https://www.imperva.com/docs/HII_A_Perfect_CRIME_Only_TIME_Will_Tell.pdf) |
| **BREACH (Prado-Harris-Gluck)** | 2013 | HTTP-level compression (gzip) | CRIME-style attack via HTTP gzip; affects any HTTPS site echoing user input + secret; CVE-2013-3587 [[1]](http://breachattack.com/) |
| **HEIST (Vanhoef-Van Goethem)** | 2016 | TCP window + HTTP gzip | Pure-browser variant; no MitM needed; uses JavaScript timing of cross-origin response size [[1]](https://www.blackhat.com/docs/us-16/materials/us-16-VanGoethem-HEIST-HTTP-Encrypted-Information-Can-Be-Stolen-Through-TCP-Windows.pdf) |
| **CRIME-style on HPACK** | 2017 | HTTP/2 HPACK compression | HPACK header compression in HTTP/2 is similarly vulnerable; fix is to mark sensitive headers as never-indexed [[1]](https://datatracker.ietf.org/doc/html/rfc7541) |

CRIME: attacker injects chosen plaintext into a TLS session that also includes the target secret cookie; if the chosen plaintext matches the cookie prefix, deflate compression saves bytes and the encrypted record is shorter by 1–2 bytes; binary search reveals the cookie character-by-character. TLS compression was disabled in all major browsers and servers within weeks (TLS 1.3 removed it from the protocol entirely). BREACH adapts to HTTP-level gzip: any HTTPS endpoint that echoes user input plus a CSRF token in the same gzip-compressed response leaks the token. Mitigations are application-level: rotate tokens per request, separate compression contexts, or add random padding to responses (length-hiding). HEIST shows that even without a man-in-the-middle, JavaScript can measure response size via TCP window probing — extending the attack surface to any user with malicious-page access.

**State of the art:** TLS compression removed in TLS 1.3. HTTP compression still ubiquitous; BREACH-class attacks remain a concern for any HTTPS application that compresses responses containing both user input and secrets. Mitigations: per-request token rotation, X-XSS-Protection headers, padding, or disabling compression on sensitive endpoints.

**Production readiness:** N/A (Attack)
Disabled TLS-level compression globally. BREACH mitigation still an active web-application concern.

**Implementations:**
- [BREACH PoC](https://github.com/nealharris/BREACH) ⭐ 218 — Python, BREACH attack demonstration
- [HEIST exploit code](https://github.com/Bench-Lab/heist-attack) — JavaScript/Python, HEIST research code

**Security status:** Broken (when secret + attacker input compressed together)
CRIME defeated by disabling TLS compression. BREACH still exploitable on vulnerable HTTPS applications.

**Community acceptance:** Standard
USENIX/Black Hat presentations. CRIME forced rapid TLS compression removal; BREACH driver of CSRF token rotation best practices.

---

### Sweet32 Birthday-Bound Attack

**Goal:** Recover plaintext from 64-bit-block ciphers (3DES, Blowfish) in long-lived TLS / OpenVPN sessions by exploiting the birthday bound. After ~2^32 blocks (~32 GB), CBC-mode collisions reveal XOR of plaintexts, enabling cookie extraction.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Sweet32 (Bhargavan-Leurent)** | 2016 | 3DES / Blowfish CBC | After ~2^32 blocks, birthday-bound CBC collision leaks plaintext XOR; CVE-2016-2183 [[1]](https://sweet32.info/) |
| **OpenVPN Sweet32** | 2016 | OpenVPN Blowfish | Same attack; ~785 GB capture decrypts cookie [[1]](https://sweet32.info/) |

64-bit block ciphers in CBC mode have a birthday-paradox vulnerability: after encrypting B blocks with the same key, the probability of two blocks colliding is ~B²/2^65. For B = 2^32 (32 GB of data), the probability is ~50%. A collision C_i = C_j implies P_i ⊕ P_{i-1} = P_j ⊕ P_{j-1} (XOR of plaintexts revealed). If the attacker knows one plaintext, the other is leaked. Bhargavan-Leurent demonstrated practical extraction of authenticated HTTP cookies through long-lived HTTPS sessions using 3DES-CBC. Fix: ban 64-bit block ciphers in TLS (RFC 8429, 2018) and OpenVPN. NIST deprecated 3DES in SP 800-131A Rev 2 (2023).

**State of the art:** 3DES retired (NIST 2023). Blowfish-CBC retired in OpenVPN. All modern TLS uses AES (128-bit blocks) or ChaCha20 (stream); birthday bound now ~2^64 blocks per key = 2.4×10^11 GB, unreachable in any session.

**Production readiness:** N/A (Attack)
Forced retirement of 3DES across TLS, OpenVPN, IPsec.

**Implementations:**
- [Sweet32 PoC](https://github.com/coreyball/Sweet32) — Python, demonstration of birthday-bound attack

**Security status:** Broken (for 64-bit block ciphers in long sessions)
3DES and Blowfish broken in TLS/OpenVPN context. AES (128-bit blocks) safe.

**Community acceptance:** Standard
ACM CCS 2016. Drove RFC 8429 ban on 3DES in TLS and NIST SP 800-131A Rev 2 deprecation.

---

### FREAK and Logjam (Export-Grade Cryptography Downgrade Attacks)

**Goal:** Force a TLS connection to downgrade to weakened "export-grade" cryptography (40/512-bit), then break the resulting key offline. Caused by 1990s US export controls — vulnerable export ciphersuites remained in TLS for decades. FREAK targets export RSA; Logjam targets export DH.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **FREAK (Beurdouche et al.)** | 2015 | TLS RSA_EXPORT (512-bit RSA) | OpenSSL state-machine bug + 512-bit RSA factorization; ~7 hours / $100 to factor 512-bit RSA; CVE-2015-0204 [[1]](https://www.smacktls.com/) |
| **Logjam (Adrian et al.)** | 2015 | TLS DHE_EXPORT (512-bit DH) | TLS allows DH parameter downgrade to 512-bit; NFS-DLP precomputation on common DH primes; CVE-2015-4000 [[1]](https://weakdh.org/) |
| **DROWN export angle** | 2016 | SSLv2 40-bit RSA | SSLv2 export grades enable Bleichenbacher oracle; covered at [DROWN Attack](#drown-attack-cve-2016-0800) |
| **FREAK on Apple TLS** | 2015 | Apple iOS/macOS TLS | Implementation bug allowed RSA downgrade despite server not advertising export; CVE-2015-1067 [[1]](https://www.smacktls.com/) |

US export controls (1992–2000) limited cryptographic strength of exported software to 40 or 512 bits. To allow international users, TLS included "export-grade" ciphersuites with weakened parameters. The export-grade suites were kept in TLS for backward compatibility long after export controls were lifted; FREAK and Logjam showed that implementation bugs and protocol state-machine flaws allow attackers to force these weak suites even when neither client nor server intends them. FREAK exploits a state-machine bug in OpenSSL (and Apple's SecureTransport) that incorrectly accepted a 512-bit ephemeral RSA key during a non-export handshake — 512-bit RSA is factorizable in ~7 hours on commodity hardware. Logjam exploits the same idea against 512-bit DH; the attack precomputes NFS-DLP for the most common 512-bit DH primes (since servers often share these), then decrypts in milliseconds. Logjam estimates that 512-bit DH had a feasible state-actor break in 2015; 1024-bit DH precomputation was feasible at ~$100M.

**State of the art:** Export ciphersuites removed from all major TLS implementations (2015). Modern TLS uses 2048+ bit DH or ECDHE. TLS 1.3 forbids DH < 2048 bits and removes RSA key transport entirely.

**Production readiness:** N/A (Attack)
Drove industry-wide removal of export ciphersuites and DH parameter size enforcement.

**Implementations:**
- [FREAK scanner](https://github.com/jvehent/freak-scanner) ⭐ 21 — Python, FREAK vulnerability detection
- [TLS-Attacker](https://github.com/tls-attacker/TLS-Attacker) ⭐ 904 — Java, supports FREAK, Logjam testing

**Security status:** Broken
512-bit RSA and 512-bit DH broken. Mitigated by removing export ciphersuites.

**Community acceptance:** Standard
ACM CCS 2015 best paper (Logjam). Forced TLS implementation hardening and parameter-validation requirements.

---

### GCM Nonce Reuse / Forbidden Attack (Joux)

**Goal:** Exploit nonce reuse in AES-GCM (or any polynomial MAC over GF(2^128)) to recover the GHASH authentication key, enabling arbitrary message forgery. Even a single accidental nonce reuse compromises authentication for the entire key lifetime.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Forbidden Attack (Joux)** | 2006 | AES-GCM nonce reuse | Two messages with same key and nonce → solve quadratic in GHASH key over GF(2^128); recovers H = E_K(0) [[1]](https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/cwc-gcm/ferguson2.pdf) |
| **Böck-Zauner-Devlin GCM Survey** | 2016 | Real-world GCM implementations | Found nonce-reuse bugs in 70k+ HTTPS hosts (mostly broken random nonces in IIS / older devices) [[1]](https://eprint.iacr.org/2016/475) |
| **GCM Short-Tag Forgery (Ferguson)** | 2005 | AES-GCM with truncated tag | Truncated GCM tags (<96 bits) admit higher forgery probability than nominal [[1]](https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/cwc-gcm/ferguson2.pdf) |
| **AES-GCM-SIV (Gueron-Lindell)** | 2017 | Nonce-misuse resistance | RFC 8452: SIV mode immune to nonce reuse (deterministic authenticated encryption) [[1]](https://eprint.iacr.org/2017/168) |

GCM authentication is based on GHASH, a polynomial MAC over GF(2^128) with key H = E_K(0). When two messages share key + nonce, the GHASH equations become a system the attacker can solve for H. Once H is known, the attacker can forge any message under the compromised nonce. The attack does not break confidentiality of the underlying CTR-mode encryption (each block still has unique counter), but completely breaks authenticity. Mitigations: (1) random 96-bit nonces with rate-limited rotation, (2) deterministic AES-GCM-SIV (RFC 8452) which is misuse-resistant by design, (3) ChaCha20-Poly1305 (RFC 8439) which also relies on unique nonces but tolerates wider nonce space (192-bit XChaCha20-Poly1305 in libsodium). Böck et al. (2016) found GCM nonce reuse in many real-world HTTPS endpoints — particularly IIS with custom RNG bugs.

**State of the art:** AES-GCM-SIV deployed in QUIC, BoringSSL, libsodium for misuse-resistant authenticated encryption. Random 96-bit nonces are safe for ≤2^32 messages per key (birthday-bound on nonces). For unbounded use, deterministic SIV or counter-based unique nonces are required. See [AEAD](02-authenticated-structured-encryption.md#aead-authenticated-encryption-with-associated-data) and [GCM-SIV](02-authenticated-structured-encryption.md#aes-gcm-siv-misuse-resistant-aead).

**Production readiness:** N/A (Attack)
Drove deployment of AES-GCM-SIV and ChaCha20-Poly1305 in misuse-resistant contexts (TLS 1.3 0-RTT, QUIC, libsodium).

**Implementations:**
- [GCM Nonce Reuse PoC](https://github.com/nonce-disrespect/nonce-disrespect) ⭐ 161 — Python, GHASH key recovery from real-world IIS captures
- [GCM Misuse Tester](https://github.com/golang/go/blob/master/src/crypto/cipher/gcm_test.go) — Go, nonce-reuse test vectors

**Security status:** Broken (under nonce reuse)
Any GCM nonce reuse breaks authentication completely. AES-GCM-SIV and XChaCha20-Poly1305 mitigate via misuse resistance.

**Community acceptance:** Standard
Required design knowledge for AEAD selection; mandated in TLS 1.3 0-RTT design rationale and RFC 8446.

---

### TLS Renegotiation, Triple-Handshake, and Selfie Attacks

**Goal:** Exploit TLS state-machine confusion across renegotiation or session-resumption boundaries to inject attacker data into the authenticated context, or to authenticate as a different identity than intended.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **TLS Renegotiation Attack (Ray-Dispensa)** | 2009 | TLS 1.0–1.2 renegotiation | Attacker prepends data to authenticated session; CVE-2009-3555; fixed by RFC 5746 secure renegotiation extension [[1]](https://kb.cert.org/vuls/id/120541) |
| **Triple-Handshake (3SHAKE) (Bhargavan et al.)** | 2014 | TLS resumption + renegotiation | Cross-session credential injection; affected TLS-based VPN, OAuth; CVE-2014-1295 [[1]](https://www.mitls.org/pages/attacks/3SHAKE) |
| **SLOTH (Bhargavan-Leurent)** | 2016 | TLS / IKE / SSH with MD5/SHA-1 | Transcript-collision attacks on hash-truncated handshake signatures; CVE-2015-7575 [[1]](https://www.mitls.org/pages/attacks/SLOTH) |
| **Selfie Attack (Drucker-Gueron)** | 2019 | TLS 1.3 PSK | Symmetric PSK confusion in TLS 1.3 reveals server-side identity to attacker [[1]](https://eprint.iacr.org/2019/347) |
| **Raccoon Attack (Merget et al.)** | 2020 | TLS-DH with static keys | Side-channel + lattice attack on TLS pre-master secret leading zeros; affected legacy DH cipher suites [[1]](https://raccoon-attack.com/) |

The original renegotiation attack (Ray 2009): TLS renegotiation re-keys an existing connection. The attacker can MitM the initial handshake, send arbitrary data, then let the legitimate client perform a renegotiation handshake — the arbitrary attacker data is now in the authenticated stream as if the legitimate client sent it. RFC 5746 fixes this by cryptographically binding the previous handshake's verify_data into the renegotiation. Triple-Handshake (2014) is a more subtle TLS state-machine attack involving three handshakes (initial, resumed, renegotiated) that allows cross-session attribute injection. SLOTH demonstrates that even when MD5 is used "only" for handshake signatures (not encryption), transcript collisions allow impersonation. Selfie shows that TLS 1.3 PSK identities require careful binding to prevent role confusion. All these attacks motivated TLS 1.3's strict transcript binding and removal of renegotiation entirely.

**State of the art:** TLS 1.3 structurally immune (no renegotiation, strict transcript hash). TLS 1.2 requires RFC 5746 extension (secure renegotiation) and SHA-256+ for handshake signatures. PSK mode in TLS 1.3 has identity-binding requirements per RFC 8446 §4.2.11.

**Production readiness:** N/A (Attack)
Forced TLS 1.3 design decisions: no renegotiation, strict transcript hash, explicit PSK identity binding.

**Implementations:**
- [TLS-Attacker](https://github.com/tls-attacker/TLS-Attacker) ⭐ 904 — Java, supports 3SHAKE, renegotiation, Selfie testing
- [miTLS](https://github.com/mitls/mitls-fstar) ⭐ 257 — F*, formally-verified TLS 1.3; reference for attack analysis

**Security status:** Broken (for TLS 1.0–1.2 without RFC 5746)
Pre-RFC-5746 TLS renegotiation broken. 3SHAKE/SLOTH/Raccoon broken in their specific configurations. TLS 1.3 immune.

**Community acceptance:** Standard
S&P/USENIX best papers. Forced TLS 1.3 design constraints and renegotiation removal.

---

## Implementation & Side-Channel Attacks

---

### Power Analysis Attacks (SPA, DPA, CPA, Template)

**Goal:** Recover cryptographic keys by measuring power consumption of a chip while it performs encryption. Simple Power Analysis (SPA) reads keys directly from power traces; Differential Power Analysis (DPA) uses statistical correlation; Correlation Power Analysis (CPA) refines DPA with intermediate-value modeling; Template Attacks (TA) precompute Gaussian models for the strongest possible attack.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Simple Power Analysis (SPA)** | 1996 | Square-and-multiply RSA/EC | Direct visual key recovery from power trace; "high spike = multiplication" reveals exponent bits [[1]](https://www.paulkocher.com/doc/TimingAttacks.pdf) |
| **Differential Power Analysis (DPA) (Kocher-Jaffe-Jun)** | 1999 | Symmetric crypto on smartcards | Statistical correlation of hypothesis-vs-trace; recovers DES/AES key with hundreds of traces [[1]](https://www.paulkocher.com/doc/DifferentialPowerAnalysis.pdf) |
| **Correlation Power Analysis (CPA) (Brier-Clavier-Olivier)** | 2004 | AES, DES | Pearson correlation with Hamming-weight/distance models; gold standard for unprotected implementations [[1]](https://link.springer.com/chapter/10.1007/978-3-540-28632-5_2) |
| **Template Attacks (Chari-Rao-Rohatgi)** | 2002 | Smart cards, embedded | Profile-based: multivariate Gaussian template per intermediate; strongest known attack [[1]](https://link.springer.com/chapter/10.1007/3-540-36400-5_3) |
| **Mutual Information Analysis (Gierlichs et al.)** | 2008 | Generic | Information-theoretic generalization of DPA; works without leakage model [[1]](https://link.springer.com/chapter/10.1007/978-3-540-85053-3_27) |
| **Deep-Learning Power Analysis** | 2016– | AES, ECC | CNN/MLP models replace template Gaussian; often outperforms classical attacks with fewer traces [[1]](https://eprint.iacr.org/2018/053) |

Power consumption of a digital chip depends on switching activity, which depends on processed values — leak is intrinsic. Kocher's 1999 DPA paper showed that even noisy power traces, when statistically combined, reveal AES/DES keys from any unprotected implementation. Countermeasures include: masking (split each secret into n shares processed independently, only correlated at the output), hiding (constant-time + constant-power circuit design), randomization (random delays, dummy operations), shuffling (random execution order). Modern smart cards and HSMs use first-order or higher-order masking certified to Common Criteria EAL4+ levels. Side-channel evaluation (TVLA test, Test Vector Leakage Assessment) is mandatory in FIPS 140-3 (2020+) and CMVP certifications.

**State of the art:** First-order DPA is trivially defeated by masking; higher-order DPA requires deeper masking. Deep-learning attacks have shifted the threat model: trained models break protected implementations with fewer traces than classical statistical attacks. Active research in formal verification of side-channel countermeasures (Bordes-Daemen NIST 2022, masking compilers).

**Production readiness:** N/A (Attack)
Defines smart card / HSM evaluation criteria (FIPS 140-3, Common Criteria EAL4+/AVA_VAN.5).

**Implementations:**
- [ChipWhisperer (NewAE)](https://github.com/newaetech/chipwhisperer) ⭐ 2.4k — Python/HW, open-source SCA platform with FPGA-based capture
- [Riscure Inspector / Pico](https://www.riscure.com/) — commercial, industry-standard SCA platform
- [SCAlib](https://github.com/simple-crypto/SCAlib) ⭐ 60 — Python/Rust, modern SCA library with statistical/ML attacks
- [scared](https://gitlab.com/eshard/scared) — Python, scriptable side-channel analysis framework

**Security status:** Broken (unprotected implementations)
Any unprotected AES/RSA/ECC implementation broken in seconds–minutes. Masked implementations require higher-order or DL attacks.

**Community acceptance:** Standard
DPA 1999 paper is most-cited side-channel reference. CHES (now TCHES) is the dedicated venue. Mandatory in HSM/smart card certification.

---

### Cache-Timing Attacks (Flush+Reload, Prime+Probe, Spectre, MDS)

**Goal:** Extract secrets from a victim process running on the same physical CPU by observing micro-architectural timing differences in shared caches, branch predictors, or store buffers. Cache attacks broke many cryptographic libraries (OpenSSL AES T-table, libgcrypt RSA, GnuPG/libgcrypt ECDSA); transient-execution attacks (Spectre, Meltdown, MDS) generalized the threat to arbitrary cross-process secret leakage.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Cache-Timing AES (Bernstein, Tromer-Osvik-Shamir)** | 2005 | OpenSSL AES T-table | Lookup-table access leaks via L1 cache; remote network attack feasible [[1]](https://cr.yp.to/antiforgery/cachetiming-20050414.pdf) |
| **Prime+Probe (Osvik-Shamir-Tromer)** | 2006 | AES, RSA | Fill cache, run victim, measure evicted lines; portable across CPUs [[1]](https://link.springer.com/chapter/10.1007/11605805_1) |
| **Flush+Reload (Yarom-Falkner)** | 2014 | GnuPG RSA, ECDSA | Shared library page; clflush + measure reload time; works across VMs sharing dedup'd pages [[1]](https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-yarom.pdf) |
| **Flush+Flush (Gruss-Maurice-Wagner-Mangard)** | 2016 | Generic cache covert | Single instruction (clflush) timing; lower noise than Flush+Reload [[1]](https://link.springer.com/chapter/10.1007/978-3-319-40667-1_14) |
| **Meltdown (Lipp-Schwarz-Gruss et al.)** | 2018 | Intel CPUs | Out-of-order kernel-memory read; CVE-2017-5754; KAISER/KPTI mitigation [[1]](https://meltdownattack.com/) |
| **Spectre v1/v2 (Kocher et al.)** | 2018 | Modern speculative CPUs | Speculative execution + cache side-channel; CVE-2017-5753/5715; mitigations cause perf regression [[1]](https://spectreattack.com/) |
| **MDS (Microarchitectural Data Sampling)** | 2019 | Intel CPUs | RIDL, Fallout, ZombieLoad: leak from store buffers, line-fill buffers; CVE-2018-12126 et al. [[1]](https://mdsattacks.com/) |
| **Hertzbleed (Wang et al.)** | 2022 | DVFS-enabled CPUs | CPU frequency scaling leaks data-dependent power; remote timing reveals SIKE keys; CVE-2022-23823 [[1]](https://www.hertzbleed.com/) |
| **GoFetch (Chen et al.)** | 2024 | Apple M1/M2/M3 | Data Memory-Dependent Prefetcher leaks constant-time crypto keys; affected ML-KEM, RSA implementations [[1]](https://gofetch.fail/) |

The classic cache-timing taxonomy: (1) Prime+Probe — attacker fills cache, victim runs, attacker measures which cache lines were evicted; (2) Flush+Reload — attacker shares pages with victim (e.g., libcrypto.so), flushes then reloads to detect access patterns; (3) Evict+Reload — variant without clflush. Cryptographic implementations are vulnerable when secret-dependent memory accesses (S-box lookups, ECC scalar multiplication branches, RSA modular reduction tables) leak via cache. Mitigations: bitsliced AES (no table lookups), constant-time Curve25519 / Ed25519 (no secret-dependent branches or memory access), formal constant-time verification tools (ct-verif, Binsec/Rel, Jasmin). Transient-execution attacks (Spectre, Meltdown, MDS) bypass software defenses because secret data is speculatively loaded into microarchitectural state. Hertzbleed (2022) extended the threat: even strictly constant-time code can leak via CPU frequency changes triggered by data-dependent power consumption. GoFetch (2024) exploited an Apple-specific prefetcher to break constant-time M1/M2/M3 cryptography.

**State of the art:** Constant-time crypto is mandatory: Curve25519, Ed25519, ChaCha20 designed for it. AES on Intel uses AES-NI hardware (no cache leak); fallbacks must use bitsliced AES. RSA implementations switched to Montgomery ladder with branchless modular arithmetic. Microarchitectural attacks ongoing — Hertzbleed and GoFetch show even constant-time code isn't fully safe against new side channels. Hardware enclaves (SGX, TDX, SEV) have been broken multiple times via cache+speculative attacks.

**Production readiness:** N/A (Attack)
Drives constant-time cryptography requirements (NIST FIPS 140-3, RFC 7748). All major TLS libraries (BoringSSL, OpenSSL 3.x, rustls) ship constant-time implementations.

**Implementations:**
- [Mastik (Yarom)](https://github.com/0xADE1A1DE/Mastik) ⭐ 75 — C, micro-architectural side-channel toolkit (Flush+Reload, Prime+Probe)
- [Flush+Reload PoC](https://github.com/defuse/flush-reload-attacks) ⭐ 198 — C, original Flush+Reload demonstration
- [Spectre PoC](https://github.com/crozone/SpectrePoC) ⭐ 1.4k — C, Spectre v1 demonstration
- [Hertzbleed PoC](https://github.com/FPSG-UIUC/hertzbleed) ⭐ 71 — Python/C, remote DVFS-timing attack
- [ct-verif](https://github.com/imdea-software/verifying-constant-time) ⭐ 35 — formal constant-time verification

**Security status:** Broken (for non-constant-time implementations)
Any timing-leaking implementation broken. Constant-time implementations safe against classical cache attacks but vulnerable to Hertzbleed, GoFetch, future microarchitectural attacks.

**Community acceptance:** Standard
S&P, USENIX Security regulars. Meltdown/Spectre announcement (Jan 2018) coordinated industry-wide; mitigation required CPU firmware + OS kernel + compiler changes. Hertzbleed / GoFetch are recent and influence both crypto and CPU design.

---

### Fault Injection Attacks (Bellcore, Glitching, Rowhammer, LaserFI)

**Goal:** Induce computational errors in a cryptographic device via voltage/clock glitching, laser pulse, electromagnetic pulse, or memory-disturbance (Rowhammer). The faulted computation often leaks the secret key directly — most famously the Bellcore attack: a single faulted RSA-CRT signature reveals the full factorization of N.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Bellcore Attack (Boneh-DeMillo-Lipton)** | 1997 | RSA-CRT signing | A single fault in CRT branch + correct signature → gcd recovers prime factor; CVE-2008-2148 (Intel) [[1]](https://link.springer.com/chapter/10.1007/3-540-69053-0_4) |
| **Differential Fault Analysis (Biham-Shamir DFA)** | 1997 | DES | Compare correct/faulty ciphertexts to recover round key [[1]](https://link.springer.com/chapter/10.1007/BFb0052259) |
| **AES DFA (Piret-Quisquater)** | 2003 | AES | 2 faulted ciphertexts at penultimate round recover full key [[1]](https://link.springer.com/chapter/10.1007/978-3-540-45238-6_8) |
| **Voltage / Clock Glitching** | 2008+ | Smart cards, secure elements | Skip CPU instructions or corrupt memory; defeats secure boot, PIN verification [[1]](https://www.usenix.org/legacy/event/woot10/tech/full_papers/Loken.pdf) |
| **Laser Fault Injection** | 2002+ | Hardware crypto | Targeted laser pulse flips specific transistor; bypasses software countermeasures [[1]](https://link.springer.com/chapter/10.1007/3-540-36400-5_2) |
| **Rowhammer (Kim et al.)** | 2014 | DRAM | Repeated row activations flip bits in adjacent rows; used to flip page-table entries and crypto keys; CVE-2015-0565 [[1]](https://users.ece.cmu.edu/~yoonguk/papers/kim-isca14.pdf) |
| **PlunderVolt (Murdock et al.)** | 2019 | Intel SGX | Software undervolting flips bits in SGX enclave; CVE-2019-11157; broke constant-time crypto in enclaves [[1]](https://plundervolt.com/) |
| **VoltJockey (Qiu et al.)** | 2019 | Intel SGX | Independent voltage glitch on SGX; extracts AES keys [[1]](https://dl.acm.org/doi/10.1145/3319535.3354201) |
| **NMI-FI / Crowbar Glitching** | 2020+ | Secure boot bypass | Voltage rail interruption with controlled timing; bypassed Trezor, Coldcard, Pixel boot ROMs [[1]](https://labs.f-secure.com/blog/glitching-and-fault-injection-attacks/) |

The Bellcore attack remains the canonical fault attack: RSA-CRT signing computes signatures modulo p and q separately, then combines via CRT. If one branch is faulted (e.g., random bit flip during exponentiation mod p), the resulting "signature" S' satisfies S^e ≡ m (mod q) but S^e ≢ m (mod p). Then gcd(S'^e − m, N) reveals p. Countermeasures: verify before output (compute S^e and check against m), redundant computation, randomized blinding. Modern smart cards implement multiple layers: shielded clock, voltage sensors, instruction redundancy, integrity-checked memory. Rowhammer extends the threat to commodity DRAM: attackers can flip bits in nearby rows by hammering one row millions of times, allowing privilege escalation and key corruption attacks even from JavaScript (NetHammer, Throwhammer).

**State of the art:** Crypto-specific countermeasures (CRT-verification, redundant computation) standard in HSMs and smart cards. ECC point validation, range checks in modular arithmetic. Rowhammer mitigations in hardware: DDR4 Target Row Refresh (TRR), DDR5 on-die ECC and refresh management. Embedded device security boundary depends on tamper-resistance class (FIPS 140-3 Level 3+, Common Criteria AVA_VAN.4/5).

**Production readiness:** N/A (Attack)
Drives FIPS 140-3 / Common Criteria tamper-resistance requirements for HSMs, secure elements, SIM cards, TPMs.

**Implementations:**
- [ChipWhisperer (NewAE)](https://github.com/newaetech/chipwhisperer) ⭐ 2.4k — Python/HW, integrated SCA+FI platform with crowbar glitching
- [PicoEMP (LimitedResults)](https://github.com/newaetech/chipshouter-picoemp) ⭐ 480 — open-source EMFI pulser
- [Rowhammer.js (Gruss-Maurice-Mangard)](https://github.com/IAIK/rowhammerjs) ⭐ 1.2k — JavaScript, remote Rowhammer
- [TRRespass (Frigo et al.)](https://github.com/vusec/trrespass) ⭐ 296 — C, bypasses DDR4 TRR
- [Riscure VC Glitcher](https://www.riscure.com/) — commercial, professional voltage glitching platform

**Security status:** Broken (unprotected implementations)
Bellcore-vulnerable RSA-CRT broken with single fault. Unprotected DRAM vulnerable to Rowhammer. SGX broken multiple times by voltage/temperature attacks.

**Community acceptance:** Standard
ACM CCS, S&P, FDTC (dedicated conference). Mandatory threat in HSM/smart card certification.

---

### Cold Boot Attack and DRAM Remanence

**Goal:** Recover cryptographic keys from a powered-off or recently-rebooted computer by cooling DRAM modules (slowing decay) and dumping memory before keys decay. Defeats full-disk encryption (BitLocker, FileVault, LUKS) when attacker has physical access to a sleeping or briefly-powered-off device.

| Attack | Year | Target | Note |
|--------|------|--------|------|
| **Cold Boot Attack (Halderman et al.)** | 2008 | FDE keys in DRAM | Cool DRAM with canned air to −50°C, reboot to USB attacker OS, dump memory; recovers AES keys 70%+ of trials [[1]](https://citp.princeton.edu/our-work/memory/) |
| **AES Key Recovery from Decay (Halderman)** | 2008 | AES schedule in DRAM | Even partially-decayed key schedule reveals master key via algebraic redundancy [[1]](https://www.usenix.org/legacy/event/sec08/tech/full_papers/halderman/halderman.pdf) |
| **TRESOR (Müller-Freiling-Dewald)** | 2011 | Defense | Store AES key only in CPU registers (debug regs), never DRAM; immune to cold boot [[1]](https://www.usenix.org/legacy/event/sec11/tech/full_papers/Muller.pdf) |
| **Cold Boot on Modern DDR3/DDR4 (F-Secure 2018)** | 2018 | Sleep-mode laptops | Defeated BIOS-based memory clear; Apple, Lenovo, Dell laptops vulnerable [[1]](https://labs.f-secure.com/blog/cold-boot-attacks-on-modern-laptops/) |
| **Bitlocker Recovery via DMA + Cold Boot** | 2018 | Windows Bitlocker | Combined attack chain; led to Microsoft pre-boot PIN requirement [[1]](https://labs.f-secure.com/blog/cold-boot-attacks-on-modern-laptops/) |

DRAM does not lose its contents instantly when powered off — at room temperature, bits persist for several seconds; at −50°C, for several minutes. Halderman et al. (2008) exploited this: cool DRAM with inverted canned air, briefly cut power, transfer chips to an attacker machine (or boot a minimal OS from USB), dump physical memory, scan for AES key schedules (recognizable by their algebraic structure). The original paper showed practical recovery of BitLocker, FileVault, LUKS, and dm-crypt keys. Mitigations: (1) clear keys from memory aggressively on sleep/shutdown, (2) keep keys only in CPU registers (TRESOR uses x86 debug registers; Linux mainline supports similar via vmalloc clearing), (3) require pre-boot authentication (BitLocker TPM+PIN, FileVault EFI password), (4) tamper-evident enclosures. Modern UEFI specs require memory scrubbing on reset, but many laptops still vulnerable in 2018+.

**State of the art:** Mitigated by TPM+PIN requirements (BitLocker) and FDE policy + suspend-to-disk (encrypted swap). TRESOR-style register-only keys deployed in some hardened Linux distros. Physical-access threat models in FIPS 140-3 / Common Criteria assume cold boot is feasible.

**Production readiness:** N/A (Attack)
Drives pre-boot PIN requirements, memory-scrubbing UEFI specs, and TPM-bound key sealing.

**Implementations:**
- [msramdmp (Halderman et al.)](https://citp.princeton.edu/our-work/memory/code/) — C, original cold boot memory dumping
- [aeskeyfind](https://citp.princeton.edu/our-work/memory/code/) — C, scan memory dump for AES key schedules
- [TRESOR Linux patch](https://www1.cs.fau.de/research/tresor/) — Linux kernel patch, AES via x86 debug registers

**Security status:** Broken (without TPM+PIN)
Any FDE without pre-boot auth + memory scrubbing is broken on physical access. TPM+PIN + TRESOR-style mitigations recover security.

**Community acceptance:** Standard
USENIX Security 2008 best paper. Forced industry adoption of pre-boot authentication and memory scrubbing.

---

### Cross-References: Side-Channel Attacks in Other Categories

Additional side-channel attacks and physical-security topics covered in [AI, Hardware & Physical Security](17-ai-hardware-physical-security.md):
- [Acoustic Cryptanalysis](17-ai-hardware-physical-security.md#acoustic-cryptanalysis) — extract keys from CPU acoustic emanations (Genkin-Shamir-Tromer 2013)
- [Physical Unclonable Functions (PUF)](17-ai-hardware-physical-security.md#physical-unclonable-functions-puf) — ML modeling attacks on PUFs
- [AI Hardware Trojans](17-ai-hardware-physical-security.md#ai-hardware-trojans-backdoor-attacks-on-neural-accelerators) — hardware backdoor attacks on neural accelerators
- [TEMPEST / EM Side-Channel](17-ai-hardware-physical-security.md#tempest--em-side-channel) — electromagnetic emanation attacks

Cryptanalysis of specific schemes covered in their respective sections:
- [ECDSA — Details, Vulnerabilities, and RFC 6979](08-signatures-advanced.md#ecdsa--details-vulnerabilities-and-rfc-6979) — comprehensive ECDSA pitfalls (nonce reuse, side channels, signature malleability)
- [Padding-Oracle / CCA2 on RSA-OAEP and RSA-PKCS#1v1.5](07-homomorphic-functional-encryption.md) — RSA encryption padding attacks beyond Bleichenbacher
- [WireGuard Cryptography](12-secure-communication-protocols.md) — analysis of WireGuard handshake under enhanced threat models

External research venues for ongoing cryptanalysis:
- **CRYPTO / EUROCRYPT / ASIACRYPT** — top-tier theoretical cryptanalysis (IACR)
- **CHES (TCHES)** — side-channel and implementation attacks
- **USENIX Security / IEEE S&P / ACM CCS** — applied cryptography and real-world attacks
- **FSE / ToSC** — symmetric cryptanalysis
- **PQCrypto / NIST PQC Forum** — post-quantum cryptanalysis
