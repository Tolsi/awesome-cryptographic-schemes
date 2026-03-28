# Authenticated & Structured Encryption

## Authenticated Encryption (AEAD)

**Goal:** Confidentiality + Integrity + Authentication in a single primitive. Encrypt and authenticate data so tampering is detectable.

| Algorithm | Year | Note |
|-----------|------|------|
| **AES-256-GCM** | 2004 | NIST standard; hardware-accelerated; nonce-misuse vulnerable [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **ChaCha20-Poly1305** | 2013 | Software-fast; TLS 1.3, WireGuard; IETF RFC 8439 [[1]](https://cr.yp.to/chacha/chacha-20080128.pdf)[[2]](https://cr.yp.to/mac/poly1305-20050329.pdf) |
| **AES-GCM-SIV** | 2019 | Nonce-misuse resistant; RFC 8452 [[1]](https://www.rfc-editor.org/rfc/rfc8452) |
| **AES-OCB3** | 2011 | Very fast (single-pass); patent-free since 2021 [[1]](https://link.springer.com/article/10.1007/s00145-011-9107-9) |
| **AEGIS-128L / AEGIS-256** | 2014 | AES-round-based stream; fastest AEAD on AES-NI hardware [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-aegis-aead/) |
| **Ascon** | 2023 | Lightweight AEAD; NIST LWC winner (2023) [[1]](https://ascon.iaik.tugraz.at/) |

**State of the art:** AES-256-GCM (standard), AEGIS (speed record on AES-NI), Ascon (constrained devices).

---

## Key-Committing AEAD

**Goal:** Prevent "invisible salamander" attacks and other multi-key attacks on AEAD schemes. Standard AEAD (AES-GCM, ChaCha20-Poly1305) is *not* key-committing: a single ciphertext can decrypt validly under two different keys, enabling attacks on systems that branch on decryption success before checking the key.

| Scheme | Year | Approach | Note |
|--------|------|----------|------|
| **AES-GCM-SIV** | 2017 | Nonce-misuse resistant | Deterministic; does not fully commit to key [[1]](https://eprint.iacr.org/2017/168) |
| **HtE (Hash-then-Encrypt)** | 2022 | Commit key + data to hash before encrypt | Transform any AEAD into key-committing; +1 hash call overhead [[1]](https://eprint.iacr.org/2022/1260) |
| **AEAD-CMT-4** | 2022 | Key+nonce+associated-data committing | Strongest notion: commits to key, nonce, and AD simultaneously [[1]](https://eprint.iacr.org/2022/1260) |
| **UtC / MtE transforms** | 2022 | Generic transforms | Any AEAD → key-committing via MAC-then-encrypt or unverified-then-commit wrapper [[1]](https://eprint.iacr.org/2022/1260) |
| **Encode-then-Encipher** | 2000 | Padding + block cipher | Classical approach used in disk encryption (XTS) [[1]](https://eprint.iacr.org/2000/049) |

**Context:** "Invisible salamander" attack (2020) showed AES-GCM and CCM are not key-committing — a ciphertext can decrypt as two different plaintexts under two different keys. Facebook Messenger's per-attachment key derivation was vulnerable. Required for: backup encryption, file storage with auditing, E2E protocols where ciphertexts are shared.

**State of the art:** AEAD-CMT-4 (2022) for strongest binding; HtE as simple transform over existing AEAD. Being adopted in new messaging protocols and cloud backup encryption.

---

## Key Encapsulation Mechanism (KEM) / DEM Paradigm

**Goal:** Modular encryption design. Split public-key encryption into two clean steps: (1) KEM produces a shared symmetric key from public key, (2) DEM encrypts data with that key. Enables clean security proofs and mix-and-match of components.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Shoup KEM/DEM** | 2001 | Any PKE | Formal paradigm definition; cleaner than direct PKE proofs [[1]](https://shoup.net/papers/kem-dem.pdf) |
| **RSA-KEM** | 2003 | RSA | Random RSA encapsulation; NIST SP 800-56B [[1]](https://csrc.nist.gov/publications/detail/sp/800/56/b/rev-2/final) |
| **DHKEM (X25519)** | 2022 | ECDH | DH-based KEM used in HPKE (RFC 9180) [[1]](https://www.rfc-editor.org/rfc/rfc9180) |
| **ML-KEM (Kyber)** | 2024 | MLWE lattice | NIST PQ standard KEM (FIPS 203) [[1]](https://csrc.nist.gov/pubs/fips/203/final) |

**State of the art:** all modern encryption standards use KEM/DEM (HPKE, ML-KEM, ECIES). The paradigm is the default design pattern.

---

## Format-Preserving Encryption (FPE)

**Goal:** Confidentiality with structural compatibility. Ciphertext has the exact same format as plaintext — a 16-digit credit card number encrypts to another 16-digit number. Required for PCI-DSS tokenization and legacy systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FF1** | 2016 | Feistel + AES | NIST SP 800-38G standard; variable-radix alphabet [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/final) |
| **FF3-1** | 2019 | Feistel + AES tweaked | NIST SP 800-38G Rev.1; replaces broken FF3 [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/rev-1/final) |
| **BPS (Bellare-Pian-Shi)** | 2010 | Feistel | Theoretical foundation for FPE security [[1]](https://eprint.iacr.org/2009/251) |

**State of the art:** FF1 (general), FF3-1 (tweakable, NIST standard).

---

## Disk Encryption / Tweakable Block Ciphers

**Goal:** At-rest confidentiality. Encrypt each disk sector independently with a sector-number-dependent tweak, so sectors can be read/written randomly without decrypting the whole disk. Used in BitLocker, FileVault, LUKS, Android FBE.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **XTS-AES** | 2007 | Tweakable AES | IEEE 1619; sector-level encryption; tweak = sector number [[1]](https://ieeexplore.ieee.org/document/4493450) |
| **XEX (Rogaway)** | 2004 | Tweakable block cipher | Foundation: xor-encrypt-xor; XTS is a variant [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30539-2_2) |
| **Adiantum** | 2019 | ChaCha + NH + Poly1305 | Google; for devices without AES-NI (low-end Android) [[1]](https://eprint.iacr.org/2018/720) |
| **AES-HCTR2** | 2021 | AES + universal hash | Wide-block tweakable cipher; successor to Adiantum on AES-NI devices [[1]](https://eprint.iacr.org/2021/1441) |

**State of the art:** XTS-AES (BitLocker, FileVault, LUKS), Adiantum (low-end Android), AES-HCTR2 (modern Android).

---

## Order-Preserving / Order-Revealing Encryption (OPE / ORE)

**Goal:** Encrypted range queries. Ciphertext preserves or reveals the numerical order of plaintexts, enabling range queries on encrypted databases without decrypting. **Warning:** inherent leakage; weaker than standard encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boldyreva OPE** | 2009 | Hypergeometric sampling | First provably secure OPE; leaks order + approximate distance [[1]](https://eprint.iacr.org/2009/197) |
| **Chenette-Lewi-Wu ORE** | 2016 | PRF + block cipher | Reveals only order, not distance; "best-possible" ORE [[1]](https://eprint.iacr.org/2016/612) |
| **Lewi-Wu Practical ORE** | 2016 | PRF | Efficient; used in CryptDB-like systems [[1]](https://eprint.iacr.org/2016/612) |

**State of the art:** Lewi-Wu ORE (practical), but SSE/FHE approaches preferred when leakage is unacceptable.

---

## Deterministic Encryption / Convergent Encryption

**Goal:** Encrypted deduplication & lookup. Same plaintext always produces the same ciphertext, enabling equality checks without decryption. Leaks plaintext equality — not suitable where this matters.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SIV Mode (Rogaway-Shrimpton)** | 2006 | AES + CMAC | Deterministic AEAD; misuse-resistant; IV = MAC(header, plaintext) [[1]](https://eprint.iacr.org/2006/221) |
| **Convergent Encryption** | 2002 | Hash-as-key | Key = H(plaintext); enables cloud dedup of encrypted data [[1]](https://dl.acm.org/doi/10.5555/514236.514238) |
| **MLE (Message-Locked Encryption)** | 2013 | Various | Formalization of convergent encryption with security definitions [[1]](https://eprint.iacr.org/2012/631) |

**State of the art:** AES-SIV (misuse-resistant AEAD, RFC 5297), MLE (cloud deduplication).

---

## Updatable Encryption

**Goal:** Key rotation without re-download. Server applies a short re-encryption token to update all ciphertexts from an old key to a new key — without decrypting or downloading data. Used in cloud storage key rotation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BLMR (Boneh et al.)** | 2013 | ElGamal / AES | Formal model for ciphertext-independent updates [[1]](https://eprint.iacr.org/2012/021) |
| **Lehmann-Tackmann** | 2018 | Hybrid (KEM + DEM) | CCA-secure updatable encryption [[1]](https://eprint.iacr.org/2018/794) |
| **Klooß-Lehmann-Rupp** | 2019 | Forward-secure enc | Forward + post-compromise security [[1]](https://eprint.iacr.org/2019/043) |

**State of the art:** Klooß-Lehmann-Rupp (strongest security guarantees), BLMR (foundational).

---

## Rerandomizable Encryption

**Goal:** Unlinkable ciphertexts. Anyone can publicly transform a ciphertext into a fresh-looking encryption of the same plaintext — unlinkable to the original. Foundation of mixnets and anonymous credentials.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ElGamal (rerandomizable)** | 1985 | DDH | Naturally rerandomizable: multiply by Enc(1) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **Groth RCCA** | 2004 | Pairings | CCA-secure under rerandomization (RCCA model) [[1]](https://eprint.iacr.org/2003/174) |
| **Prabhakaran-Rosulek RCCA** | 2007 | DDH | Efficient RCCA without pairings [[1]](https://eprint.iacr.org/2007/064) |

**State of the art:** Groth RCCA (provable security), ElGamal (practical in mixnets/voting).

---

## Signcryption

**Goal:** Confidentiality + Authentication + Non-repudiation in a single pass. More efficient than sequential sign-then-encrypt; security is proven jointly (IND-CCA2 + EUF-CMA).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zheng Signcryption** | 1997 | DLP / EC | First scheme; ~50% cost reduction vs. sign+encrypt [[1]](https://link.springer.com/chapter/10.1007/BFb0052234) |
| **ECSC (Bao-Deng)** | 1998 | ECDLP | Elliptic curve variant; formal security proof [[1]](https://link.springer.com/chapter/10.1007/BFb0052237) |
| **Signcryption KEM/DEM** | 2004 | Hybrid | Modular: KEM provides authenticated key + DEM encrypts [[1]](https://eprint.iacr.org/2004/075) |

**State of the art:** Hybrid signcryption KEM/DEM (provable security), used in secure messaging design.

---

## Non-Committing Encryption

**Goal:** Simulation security for encryption. After generating a ciphertext, the simulator can "explain" it as an encryption of any message — by revealing fake randomness. Required for UC-secure (universally composable) protocols, where standard CPA/CCA encryption is insufficient.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Feige-Goldreich-Naor NCE** | 1996 | OT | First NCE; based on oblivious transfer [[1]](https://doi.org/10.1145/237814.237866) |
| **Nielsen NCE** | 2002 | Trapdoor permutations | Efficient NCE from any trapdoor permutation [[1]](https://doi.org/10.1007/3-540-45539-6_14) |
| **Adaptively Secure NCE (Choi et al.)** | 2009 | DDH | Non-committing encryption secure against adaptive corruption [[1]](https://eprint.iacr.org/2009/035) |
| **Non-Committing Authenticated Enc** | 2017 | AEAD + NCE | Combine authenticity with non-committing property for UC channels [[1]](https://eprint.iacr.org/2017/332) |

**State of the art:** DDH-based NCE (Choi et al.); essential for UC-secure [Secure Channels](#secure-channels--protocol-constructions) and [MPC](#multi-party-computation-mpc) in the adaptive corruption model.

---

## Honey Encryption

**Goal:** Brute-force resistance. Decrypting with any wrong key produces a plausible-looking plaintext, so an attacker cannot tell when they found the correct key. Protects low-entropy secrets (passwords, PINs, credit card numbers).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Honey Encryption (HE)** | 2014 | DTE (distribution-transforming encoder) | Foundational; each wrong key yields valid-looking plaintext [[1]](https://eprint.iacr.org/2014/155) |
| **Natural Language HE** | 2015 | NLP + DTE | Honey encryption for natural language messages; GPT-based DTEs [[1]](https://eprint.iacr.org/2015/032) |
| **Honey Encryption for Genomic Data** | 2016 | Genomic DTE | Domain-specific for protecting genome sequences [[1]](https://doi.org/10.1145/2976749.2978370) |

**State of the art:** Juels-Ristenpart HE (2014) with domain-specific DTEs; adopted in password vault research. Key challenge: designing accurate DTEs for arbitrary domains.

---

## Property-Preserving Encryption (PPE)

**Goal:** Unifying framework for structured leakage. Encryption that intentionally preserves a specific property of the plaintext — enabling server-side computation without decryption. Formalizes the tradeoff between functionality and leakage for encrypted databases.

| Property | Scheme | Note |
|----------|--------|------|
| **Equality** | [Deterministic Encryption](#deterministic-encryption--convergent-encryption) | Same plaintext → same ciphertext; enables dedup and equality search |
| **Order** | [OPE / ORE](#order-preserving--order-revealing-encryption-ope--ore) | Ciphertext preserves numerical order; enables range queries |
| **Orthogonality** | [Inner-Product FE](#attribute-based--functional-encryption) | Decrypt iff inner product = 0; enables subset queries |
| **Pattern match** | [HVE](#hidden-vector-encryption-hve) | Decrypt iff attributes match pattern with wildcards |
| **Keyword** | [Searchable Encryption](#searchable-encryption-sse--peks) | Search encrypted data by keyword |

**General framework:** Pandey-Rouselakis (2012) [[1]](https://eprint.iacr.org/2012/141) formalized PPE; Boldyreva-Chenette-O'Neill (2011) [[1]](https://eprint.iacr.org/2011/005) analyzed leakage. **Warning:** all PPE inherently leaks — weaker than semantic security. Use only when the leakage-functionality tradeoff is acceptable.

---

## Puncturable Encryption

**Goal:** Forward-secure decryption. A recipient can "puncture" their secret key on specific ciphertexts they've already decrypted — the punctured key can decrypt everything *except* those messages. Provides forward secrecy without sender-side changes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Green-Miers Puncturable Enc** | 2015 | Puncturable PRF + IBE | Puncture decryption key at tags; based on HIBE [[1]](https://eprint.iacr.org/2014/984) |
| **Bloom Filter Encryption** | 2018 | BF + puncturable PRF | Efficiently puncture on a Bloom filter of processed messages [[1]](https://eprint.iacr.org/2018/199) |
| **0-RTT with Puncturable Enc** | 2017 | TLS + puncturable enc | Replay-resistant 0-RTT key exchange without server state [[1]](https://eprint.iacr.org/2017/004) |

**State of the art:** Bloom Filter Encryption (practical), 0-RTT puncturable (TLS optimization).

---

## Secure Deduplication

**Goal:** Encrypted storage with duplicate elimination. Cloud server detects and removes duplicate files among encrypted uploads — without decrypting. Saves storage while preserving confidentiality. Formalizes security of convergent encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Douceur et al. Convergent Encryption** | 2002 | H(plaintext) as key | Deterministic encryption for dedup; see [Deterministic Encryption](#deterministic-encryption--convergent-encryption) [[1]](https://doi.org/10.1145/514236.514243) |
| **Bellare-Keelveedhi-Ristenpart (DupLESS)** | 2013 | Server-aided MLE | Server-aided message-locked encryption; key from OPRF prevents offline brute-force [[1]](https://eprint.iacr.org/2013/429) |
| **Secure Dedup with PoW (Halevi et al.)** | 2011 | Proof of ownership | Client proves it owns file before server deduplicates [[1]](https://eprint.iacr.org/2011/277) |

**State of the art:** DupLESS (server-aided OPRF-based dedup); extends [Deterministic Encryption](#deterministic-encryption--convergent-encryption) with formal security and [OPRF](#oblivious-prf-oprf).

---

## White-Box Cryptography

**Goal:** Key hiding in hostile environments. Implement cryptographic algorithms so that the secret key cannot be extracted even by an adversary who has full access to the running software and execution environment. Used in DRM, mobile payments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chow et al. WB-AES** | 2002 | Lookup tables + mixing bijections | First white-box AES; series of table lookups encoding key [[1]](https://link.springer.com/chapter/10.1007/3-540-36492-7_17) |
| **Billet et al. (cryptanalysis)** | 2004 | Algebraic attack | Broke Chow WB-AES; showed key extraction is possible [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_16) |
| **WBC Challenge (CHES)** | 2017 | Competition | Ongoing competitions show no WBC scheme survives long-term attack [[1]](https://www.whiteboxcrypto.com/) |

**State of the art:** no provably secure WBC exists; practical deployments rely on obfuscation + tamper-detection layers. Active research area.

---
