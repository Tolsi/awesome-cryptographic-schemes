# Attacks & Cryptanalysis

<!-- TOC -->
## Contents (8 schemes)

**[Elliptic Curve & Discrete Log Attacks](#elliptic-curve--discrete-log-attacks)**
- [Pohlig-Hellman Algorithm](#pohlig-hellman-algorithm)
- [MOV Attack (Menezes-Okamoto-Vanstone)](#mov-attack-menezes-okamoto-vanstone)
- [Xedni Calculus Attack](#xedni-calculus-attack)

**[Symmetric Cipher Cryptanalysis](#symmetric-cipher-cryptanalysis)**
- [Differential Cryptanalysis (Biham-Shamir)](#differential-cryptanalysis-biham-shamir)
- [Linear Cryptanalysis (Matsui's Attack)](#linear-cryptanalysis-matsuiss-attack)
- [Refined Linear Approximations for ARX Ciphers](#refined-linear-approximations-for-arx-ciphers)

**[Protocol-Level Attacks](#protocol-level-attacks)**
- [Bleichenbacher's Attack / ROBOT](#bleichenbachers-attack--robot)
- [DROWN Attack (CVE-2016-0800)](#drown-attack-cve-2016-0800)

**[Implementation & Side-Channel Attacks](#implementation--side-channel-attacks)**
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

## Implementation & Side-Channel Attacks

Side-channel attacks (timing, power analysis, electromagnetic, cache, fault injection) and countermeasures including acoustic cryptanalysis, rowhammer, and hardware trojans are covered in [AI, Hardware & Physical Security](17-ai-hardware-physical-security.md).

Relevant sections in that category:
- [Acoustic Cryptanalysis](17-ai-hardware-physical-security.md#acoustic-cryptanalysis)
- [Physical Unclonable Functions (PUF)](17-ai-hardware-physical-security.md#physical-unclonable-functions-puf)
- [AI Hardware Trojans](17-ai-hardware-physical-security.md#ai-hardware-trojans-backdoor-attacks-on-neural-accelerators)
