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

## AES-CCM (Counter with CBC-MAC)

**Goal:** AEAD for constrained and wireless environments. Combine CTR-mode confidentiality with CBC-MAC authentication in a single pass over the message using only the AES encrypt operation — making it hardware-efficient and suitable for smart cards, 802.11 Wi-Fi, and Bluetooth.

| Algorithm | Year | Standard | Note |
|-----------|------|----------|------|
| **AES-CCM** | 2004 | NIST SP 800-38C | Authenticate-then-encrypt; CBC-MAC over message, then CTR encryption of message + tag [[1]](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-38c.pdf) |
| **CCMP (802.11i)** | 2004 | IEEE 802.11i / WPA2 | CCM instantiated for Wi-Fi frame protection; mandatory in WPA2 [[1]](https://en.wikipedia.org/wiki/CCMP_(cryptography)) |
| **BLE CCM** | 2010 | Bluetooth 4.0+ | CCM used for Bluetooth Low Energy link-layer encryption [[1]](https://www.bluetooth.com/specifications/) |
| **AES-CCM in TLS** | 2012 | RFC 6655 | AES-128-CCM and AES-256-CCM cipher suites for TLS 1.2 [[1]](https://datatracker.ietf.org/doc/html/rfc6655) |

CCM design tradeoffs versus GCM:
- **Advantages:** requires only the AES encryption direction (saves code/silicon), minimal ciphertext expansion, nonce can be 7–13 bytes.
- **Disadvantages:** two-pass (must know message length before starting), not parallelisable, no hardware CLMUL acceleration.
- **Nonce misuse:** not misuse-resistant — nonce reuse breaks both confidentiality and authenticity.

**State of the art:** AES-CCM remains the mandatory AEAD in WPA2 (CCMP) and Bluetooth LE, and is available in TLS 1.2/1.3 for IoT stacks. Superseded by AES-GCM for general-purpose use but irreplaceable in constrained hardware where only AES-encrypt logic fits.

---

## EAX Mode

**Goal:** A two-pass, patent-free AEAD with no restrictions on message length, nonce length, or block-cipher primitive — designed as a clean, provably-secure alternative to the complex CCM mode and the then-patented OCB mode.

| Property | Value |
|----------|-------|
| **Authors** | Bellare, Rogaway, Wagner (2004) |
| **Publication** | FSE 2004 [[1]](https://www.cs.ucdavis.edu/~rogaway/papers/eax.pdf) |
| **Underlying primitive** | Any block cipher (typically AES-128/256) |
| **Internal MAC** | OMAC (CMAC) |
| **Encryption** | CTR mode |
| **Patent status** | Public domain |
| **Online** | Yes — streaming encryption without knowing message length in advance |

**Construction:** EAX uses three OMAC calls under distinct domain-separation tags — one over the nonce, one over the associated data (header), and one over the ciphertext — then XORs the three tags together to form the authentication tag. Encryption is standard CTR mode keyed from the nonce OMAC.

```
Tag_N  = OMAC_K(0 || N)
Tag_H  = OMAC_K(1 || H)
CTR_K(Tag_N, M) → C
Tag_C  = OMAC_K(2 || C)
Tag    = Tag_N ⊕ Tag_H ⊕ Tag_C
```

**Variant:** EAX′ (EAXprime) is used in the ANSI C12.22 standard for smart meter data transport [[1]](https://en.wikipedia.org/wiki/EAX_mode).

**State of the art:** EAX is not a NIST standard but is widely implemented (OpenSSL, Bouncy Castle, Crypto++). It filled an important role before OCB patents expired (2021) and GCM became ubiquitous. Still preferred in some IoT/embedded stacks for its simplicity and online property.

---

## Hybrid Public Key Encryption (HPKE)

**Goal:** A single, modular, well-specified standard for public-key encryption of arbitrary messages. HPKE composes a KEM, a KDF, and an AEAD into one clean API with four operating modes (base, pre-shared key, authenticated sender, and combined), replacing ad-hoc ECIES constructions.

| Component | Options |
|-----------|---------|
| **KEM** | DHKEM(X25519, HKDF-SHA256), DHKEM(P-256, HKDF-SHA256), DHKEM(X448, HKDF-SHA512), ML-KEM (draft) |
| **KDF** | HKDF-SHA256, HKDF-SHA384, HKDF-SHA512 |
| **AEAD** | AES-128-GCM, AES-256-GCM, ChaCha20-Poly1305, Export-only |

**Modes:**

| Mode | Authentication | Use case |
|------|---------------|----------|
| `Base` | None | Encrypt to recipient public key |
| `PSK` | Pre-shared key | Endpoint authentication via shared secret |
| `Auth` | Sender KEM key | Authenticate sender identity |
| `AuthPSK` | Both | Strongest mutual authentication |

**Key schedule:** `ExtractAndExpand` uses the KEM shared secret, the KDF, and a suite-specific context string to derive independent keys for the AEAD and an exporter interface, preventing cross-protocol confusion.

**Deployed in:** TLS Encrypted Client Hello (ECH) [[1]](https://datatracker.ietf.org/doc/html/draft-ietf-tls-esni), Oblivious HTTP (RFC 9458) [[1]](https://datatracker.ietf.org/doc/html/rfc9458), Oblivious DoH, Message Layer Security (MLS/RFC 9420), Privacy Preserving Measurement (PPM).

**State of the art:** RFC 9180 (2022) [[1]](https://www.rfc-editor.org/rfc/rfc9180). The default public-key encryption primitive for new IETF protocols. Post-quantum variants with ML-KEM are being standardized in draft-irtf-cfrg-hpke-pq.

---

## SpongeWrap / Duplex-Based AEAD

**Goal:** Single-pass authenticated encryption from a cryptographic permutation, without needing a block cipher. The duplex construction alternates absorbing input and squeezing output through a single permutation call per block, providing confidentiality, integrity, and an optional per-block authentication tag in one traversal.

| Scheme | Year | Permutation | Note |
|--------|------|-------------|------|
| **SpongeWrap** | 2011 | Any (Keccak-f) | First duplex-based AEAD; by Bertoni, Daemen, Peeters, Van Assche [[1]](https://eprint.iacr.org/2011/499) |
| **Keyak** | 2014 | Keccak-p | CAESAR submission; river/lake/ocean/sea/lunar variants for different parallelism levels [[1]](https://keccak.team/keyak.html) |
| **Ketje** | 2014 | Keccak-p (small) | Lightweight CAESAR submission; targets constrained devices [[1]](https://keccak.team/ketje.html) |
| **Ascon** | 2023 | Ascon-p (320-bit) | NIST LWC winner; duplex-based design; NIST SP 800-232 (2025) [[1]](https://ascon.iaik.tugraz.at/) |

**Duplex construction:**

```
State S = IV || key || capacity-bits
For each input block M_i:
    S ← P(S ⊕ (M_i || domain-sep))   // absorb
    Z_i ← S[0..rate]                  // squeeze keystream / tag
```

The capacity portion (not XOR'd with input) acts as the secret state providing authentication. Rate + capacity = full permutation width (e.g., 1600 bits for Keccak-f[1600]).

**Security:** Security bound is 2^(capacity/2) against generic attacks. Nonce-respecting security; nonce reuse breaks confidentiality but authentication holds if the same (nonce, key) pair is not reused with different messages.

**State of the art:** Ascon (NIST LWC standard, 2025) is the primary deployment target for constrained devices. Keccak-based SpongeWrap variants appear in Keyak. The duplex paradigm underlies the majority of sponge-based CAESAR and NIST LWC competition submissions.

---

## MRAE and Online Authenticated Encryption (OAE)

**Goal:** Formal treatment of nonce-misuse resistance and online/streaming AEAD. MRAE (Misuse-Resistant AE) guarantees that nonce reuse causes only confidentiality loss for repeated (nonce, AD, plaintext) triples — authenticity is never broken. Online AE (OAE) further requires that encryption is streaming (output begins before the full message is known) while retaining some misuse robustness.

**Security hierarchy:**

| Notion | Nonce reuse | Online | Representative scheme |
|--------|-------------|--------|-----------------------|
| Standard AEAD (IND-CPA + INT-CTXT) | Catastrophic | Optional | AES-GCM, ChaCha20-Poly1305 |
| **MRAE** | Only leaks plaintext equality | No (SIV is offline) | AES-SIV (RFC 5297) [[1]](https://www.rfc-editor.org/rfc/rfc5297), AES-GCM-SIV (RFC 8452) [[1]](https://www.rfc-editor.org/rfc/rfc8452) |
| **OAE1 / OAE2** | Reasonable degradation | Yes | McOE-G, COBC, IOAE |
| **Robust AE** | Auth holds; confidentiality degrades gracefully | Variant-dependent | CAESAR robustness category |

**Key schemes in the MRAE / OAE family:**

| Scheme | Year | Property | Note |
|--------|------|----------|------|
| **SIV (Rogaway-Shrimpton)** | 2006 | MRAE, offline | Synthetic IV = PRF(header ‖ msg); deterministic [[1]](https://eprint.iacr.org/2006/221) |
| **AES-GCM-SIV** | 2017/2019 | MRAE, offline | Efficient GCM variant; uses POLYVAL; RFC 8452 [[1]](https://www.rfc-editor.org/rfc/rfc8452) |
| **McOE-G / McOE-X** | 2012 | OAE1, online | First online AE with misuse robustness; Fleischmann-Forler-Lucks [[1]](https://eprint.iacr.org/2011/644) |
| **COBRA / POET** | 2014–2015 | OAE2, online | Stronger online misuse-resistant AE; parallelisable [[1]](https://eprint.iacr.org/2015/189) |
| **MRAE lower bound** | 2017 | Theory | Any MRAE scheme must be two-pass or offline; Poe-Shrimpton [[1]](https://eprint.iacr.org/2017/462) |

**Why MRAE matters:** standard AEAD with a repeated nonce leaks the plaintext XOR (GCM) or allows tag forgery (GCM-style). MRAE schemes degrade gracefully: a reused (nonce, AD, plaintext) triple produces the same ciphertext (leaking equality), but authentication is unaffected. Essential in high-availability systems, distributed systems where nonce coordination is hard, and backup/dedup contexts.

**State of the art:** AES-SIV (RFC 5297) and AES-GCM-SIV (RFC 8452) are the deployed MRAE standards. AES-GCM-SIV is preferred for its efficiency (single-key, hardware-friendly). McOE-G remains a research reference for online misuse-resistant AE; no online MRAE scheme has been standardized as of 2026.

---

## OCB Mode (Offset Codebook Mode)

**Goal:** Single-pass, parallelisable AEAD at the cost of one block-cipher call per plaintext block — roughly the same work as bare encryption, with no separate MAC pass. Designed to be the fastest possible provably-secure authenticated encryption from a block cipher.

| Version | Year | Note |
|---------|------|------|
| **OCB1 (Rogaway-Bellare-Black-Krovetz)** | 2001 | Original; one AES call per block; CPA + integrity [[1]](https://dl.acm.org/doi/10.1145/501983.502011) |
| **OCB2** | 2004 | Extended associated-data handling; later found **insecure** (2019 forgery attack) [[1]](https://link.springer.com/article/10.1007/s00145-011-9107-9) |
| **OCB3 (RFC 7253)** | 2011 | Revised offset schedule; faster on most platforms; current standard; CAESAR finalist [[1]](https://www.rfc-editor.org/rfc/rfc7253) |

**Construction:** OCB uses a nonce-derived sequence of offsets (Δ₁, Δ₂, …) computed via a Gray-code-like recurrence over a single block-cipher call. Each plaintext block Mᵢ is XOR'd with Δᵢ, encrypted, and XOR'd with Δᵢ again. A final "checksum" block (XOR of all plaintext blocks) is processed to produce the authentication tag. Associated data is handled via a parallel HASH sub-function using the same offset technique.

```
Δᵢ = L[ntz(i)] ⊕ Δᵢ₋₁        // ntz = number of trailing zeros
Cᵢ = E_K(Mᵢ ⊕ Δᵢ) ⊕ Δᵢ
Tag = E_K(Checksum ⊕ Δ_final ⊕ L_$) ⊕ HASH_K(AD)
```

**Patent history:** Rogaway patented OCB to prevent military use; grants were royalty-free for open-source and non-military use. In 2021, Rogaway formally abandoned all OCB patents, making OCB3 fully patent-free and unencumbered. This resolved the main adoption barrier that had driven the creation of patent-free alternatives (EAX, GCM).

**Performance:** OCB3 achieves ~1.0 cpb on AES-NI hardware — roughly 2× faster than AES-GCM (which requires GHASH in addition to AES). Supports parallelism: blocks are independent given the offset sequence.

**State of the art:** OCB3 (RFC 7253, 2013) [[1]](https://www.rfc-editor.org/rfc/rfc7253). Patent-free since 2021. Implemented in OpenSSL, libsodium, Botan. Fastest standardized AEAD from AES alone (without CLMUL). Not a NIST standard (NIST standardized GCM instead), but widely available. OCB2 must not be used — a practical forgery attack was published in 2019.

---

## AEGIS (A Fast Authenticated Encryption Algorithm)

**Goal:** Achieve the highest possible AEAD throughput on processors with AES-NI instructions by using multiple AES round functions per step in a dedicated state machine — not as a mode of an existing cipher, but as a purpose-built authenticated encryption algorithm.

| Variant | Key | Nonce | State | Block/step | Performance (AES-NI) |
|---------|-----|-------|-------|------------|----------------------|
| **AEGIS-128** | 128-bit | 128-bit | 5×128-bit | 128-bit | ~0.66 cpb |
| **AEGIS-128L** | 128-bit | 128-bit | 8×128-bit | 256-bit | ~0.48 cpb (fastest) |
| **AEGIS-256** | 256-bit | 256-bit | 6×128-bit | 128-bit | ~0.70 cpb |
| **AEGIS-128X / AEGIS-256X** | 128/256-bit | 128/256-bit | Multi-lane | 256/512-bit | Further parallelism via VAES |

**Designers:** Hongjun Wu and Bart Preneel (2013). CAESAR competition finalist (high-performance use case).

**Construction:** AEGIS maintains a state of 5 or 8 AES 128-bit words. Each encryption step absorbs a plaintext block and updates all state words using AES round functions with data-dependent mixing, then squeezes out a keystream block. Initialization, encryption, and finalization phases are clearly separated. The tag is a function of all state words after processing is complete.

```
// AEGIS-128L state update (one 256-bit block)
S0, S1, ..., S7 updated via 8 AES round calls mixing M_i
Ciphertext block = M_i ⊕ (S1 ⊕ S4 ⊕ (S2 & S3))
```

**Security:** 128-bit security (AEGIS-128L, AEGIS-128); 256-bit security (AEGIS-256). Nonce-misuse catastrophic (same nonce+key breaks confidentiality and authentication). A 2018 paper (Minaud) found linear biases in the keystream — they do not break the scheme but reduce the security margin slightly.

**Standardization:** IETF draft `draft-irtf-cfrg-aegis-aead` (CFRG) [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-aegis-aead/). AEGIS-128 was a CAESAR winner in the high-performance category. The X variants (AEGIS-128X, AEGIS-256X) exploit AVX-512/VAES for even higher throughput.

**State of the art:** AEGIS-128L is the fastest software AEAD on AES-NI hardware, at approximately 0.48 cycles/byte for 4 KB messages — roughly 3× faster than AES-GCM. IETF CFRG is progressing toward RFC. Being adopted in high-throughput TLS implementations and storage encryption where raw speed on modern CPUs is the primary constraint.

---

## SNOW-V and SNOW-V-GCM

**Goal:** Ultra-high-throughput stream cipher and AEAD for 5G virtualized network functions. Reach 100+ Gbps in software on commodity server CPUs by redesigning the SNOW 3G (4G standard) architecture to exploit SIMD/AES-NI instructions, providing 256-bit security for next-generation cellular encryption.

| Scheme | Year | Type | Performance | Note |
|--------|------|------|-------------|------|
| **SNOW 3G** | 2006 | Stream cipher | ~10 Gbps | 4G/LTE standard (3GPP UEA2/UIA2); 128-bit security [[1]](https://www.gsma.com/security/wp-content/uploads/2019/05/3gpp-snow-v10r2.pdf) |
| **SNOW-V** | 2019 | Stream cipher | ~64 Gbps | 5G candidate; 256-bit security; LFSR over GF(2¹²⁸) [[1]](https://eprint.iacr.org/2018/1143) |
| **SNOW-V-GCM** | 2019 | AEAD | ~42 Gbps | SNOW-V keystream + GCM-style GHASH authentication [[1]](https://eprint.iacr.org/2018/1143) |

**Designers:** Patrik Ekdahl, Thomas Johansson, Alexander Maximov, Jing Yang (Ericsson Research / Lund University), 2018–2019.

**Design:** SNOW-V retains the LFSR + FSM (Finite State Machine) structure of SNOW 3G but makes the following key changes to enable vectorization:
- LFSR operates over GF(2¹²⁸) instead of GF(2³²), producing 128-bit output per clock
- FSM uses AES round functions (exploiting AES-NI) instead of 32-bit operations
- The LFSR runs 8× faster than the FSM, enabling pipelining and producing 128 bits of keystream per step

**SNOW-V-GCM** uses SNOW-V as the keystream generator and GCM's GHASH (via CLMUL) for authentication. A key advantage over AES-GCM: in SNOW-V-GCM the authentication subkey H is derived fresh from the keystream per (Key, IV) pair, eliminating the fixed-H weakness of AES-GCM under nonce reuse.

**Context:** 5G networks process hundreds of Gbps of user-plane traffic per base station. Software-defined networking (SDN) and network function virtualization (NFV) require high-speed encryption on standard server hardware rather than dedicated ASICs. SNOW-V was presented at IETF SAAG (2019) as a candidate for 5G encryption standardization.

**State of the art:** SNOW-V remains a research proposal; no formal IETF or 3GPP standardization has occurred as of 2026. Hardware implementations exceed 100 Gbps. 3GPP for 5G standardized 128-EEA3/128-EIA3 (based on ZUC, not SNOW-V) for radio-layer encryption, but SNOW-V targets the transport/virtualization layer.

---

## Rocca-S (Beyond-5G / 6G AEAD)

**Goal:** Exceed 100 Gbps encryption throughput in software for 6G network infrastructure, with 256-bit security and a 256-bit authentication tag, by designing a dedicated AES-NI-based permutation that maximally exploits SIMD parallelism and Intel VAES extensions.

| Version | Year | Key | Tag | Software speed | Hardware speed | Note |
|---------|------|-----|-----|---------------|----------------|------|
| **Rocca** | 2021 | 256-bit | 128-bit | >100 Gbps | — | Original KDDI/NTT design; IACR ToSC [[1]](https://tosc.iacr.org/index.php/ToSC/article/view/8904) |
| **Rocca-S** | 2023 | 256-bit | 256-bit | >200 Gbps | >2 Tbps | Strengthened successor; IETF draft [[1]](https://datatracker.ietf.org/doc/draft-nakano-rocca-s/) |

**Designers:** Kosei Sakamoto, Fukang Liu, Yuto Nakano, Shinsaku Kiyomoto, Takanori Isobe (KDDI Research / University of Hyogo), 2021–2023.

**Construction:** Rocca-S maintains a state of seven 128-bit AES words (S0–S6) plus a 256-bit counter block. Each encryption step processes a 256-bit plaintext block through a round function built from AES round calls with SIMD-friendly data flow:

```
// Rocca-S round function (simplified)
(S0,...,S6) ← Update(S0,...,S6, M_i, Z_i)   // 6 AES calls per step
Ciphertext ← M_i ⊕ (S1 ⊕ S4)
Tag ← finalization over full state (256-bit output)
```

The design targets VAES (vectorized AES-NI on AVX-512) for 4-lane parallel AES execution, achieving throughput far beyond what GCM or OCB can reach.

**Security:** 256-bit security level; 256-bit authentication tag. **Warning:** practical key-committing attacks against Rocca-S have been demonstrated (2025) [[1]](https://www.sciencedirect.com/science/article/pii/S0020019025000547) — Rocca-S is not key-committing. A fault attack analysis was published in 2024. The scheme is not yet peer-reviewed to the depth of AES-GCM.

**Standardization:** IETF Internet-Draft `draft-nakano-rocca-s` (informational) [[1]](https://datatracker.ietf.org/doc/draft-nakano-rocca-s/). No 3GPP or NIST standardization as of 2026.

**State of the art:** Rocca-S is the highest-throughput AEAD in software (>200 Gbps on AVX-512 VAES) and hardware (>2 Tbps). It is a research candidate for 6G infrastructure encryption. Deployment is premature pending deeper cryptanalysis and resolution of the key-commitment vulnerability. For comparison: AES-256-GCM reaches ~4–10 Gbps in software; AEGIS-128L reaches ~30–50 Gbps; Rocca-S targets a different performance tier entirely.

---

## ECIES (Elliptic Curve Integrated Encryption Scheme)

**Goal:** Public-key encryption of arbitrary-length messages using elliptic-curve Diffie-Hellman for key agreement. ECIES combines ECDH key agreement, a key-derivation function, a symmetric cipher, and a MAC into a single encryption primitive — the practical EC equivalent of DHIES and the predecessor to the cleaner HPKE standard.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DHIES (Abdalla-Bellare-Rogaway)** | 2001 | DH | Formal security foundation; IND-CCA2 under CDH; template for ECIES [[1]](https://eprint.iacr.org/1999/007) |
| **ECIES (ANSI X9.63)** | 2001 | ECDH | ANSI standard; KDF = X9.63-KDF (ECDH output ‖ counter ‖ SharedInfo hashed with SHA-2) [[1]](https://www.secg.org/sec1-v2.pdf) |
| **ECIES (IEEE 1363a)** | 2004 | ECDH | IEEE variant; flexible KDF and MAC choices [[1]](https://standards.ieee.org/ieee/1363a/1282/) |
| **ECIES (ISO/IEC 18033-2)** | 2006 | ECDH | ISO variant used in smart-card and PKI toolkits [[1]](https://www.iso.org/standard/37971.html) |
| **HPKE (RFC 9180)** | 2022 | DHKEM | Clean successor to ECIES; see [Hybrid Public Key Encryption](#hybrid-public-key-encryption-hpke) [[1]](https://www.rfc-editor.org/rfc/rfc9180) |

**Construction:** The sender generates an ephemeral ECDH key pair, derives a shared secret via ECDH with the recipient's static public key, feeds the shared secret through a KDF (typically ANSI X9.63-KDF or HKDF) to obtain an encryption key and a MAC key, encrypts the message with a symmetric cipher (AES-CBC or AES-CTR), and appends a MAC tag. The ephemeral public key is sent alongside the ciphertext. The recipient reverses the process using their static private key.

**ANSI X9.63-KDF:** `KDF(Z, keydatalen, SharedInfo) = H(Z ‖ Counter ‖ SharedInfo)` where Z is the ECDH shared secret, Counter starts at 0x00000001, and H is SHA-256 or SHA-512. Multiple hash iterations are concatenated if more key material is needed.

**Interoperability issues:** ECIES has no single canonical form — ANSI X9.63, IEEE 1363a, and ISO 18033-2 differ in KDF, MAC placement, and point encoding, causing library incompatibilities. HPKE (RFC 9180) was designed partly to eliminate this fragmentation.

**State of the art:** ECIES remains widely deployed in TLS 1.2 handshakes, S/MIME, OpenPGP, and hardware security modules. New protocols should prefer HPKE (RFC 9180), which has a cleaner security proof, explicit mode separation, and IETF standardization. ECIES is still the default in many HSM and PKI vendor APIs as of 2026.

---

## XSalsa20 and XChaCha20 (Extended-Nonce Stream Ciphers)

**Goal:** Extend the nonce of Salsa20 and ChaCha20 from 64 bits to 192 bits so that nonces can be safely chosen uniformly at random without birthday-bound collision risk — enabling long-lived symmetric keys to encrypt large numbers of messages without nonce management infrastructure.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Salsa20** | 2005 | ARX stream cipher | 64-bit nonce; birthday collision expected after ~2³² messages [[1]](https://cr.yp.to/snuffle/spec.pdf) |
| **HSalsa20** | 2008 | Salsa20 core | Key derivation subroutine: `(key, 128-bit input) → 256-bit subkey`; no nonce output [[1]](https://cr.yp.to/snuffle/xsalsa20-20110204.pdf) |
| **XSalsa20** | 2011 | HSalsa20 + Salsa20 | 192-bit nonce; `subkey = HSalsa20(key, nonce[0:16])`; stream from `Salsa20(subkey, nonce[16:24])` [[1]](https://cr.yp.to/snuffle/xsalsa20-20110204.pdf) |
| **HChaCha20** | 2015 | ChaCha20 core | ChaCha20 analogue of HSalsa20; maps `(key, 128-bit input) → 256-bit subkey` [[1]](https://datatracker.ietf.org/doc/html/draft-irtf-cfrg-xchacha) |
| **XChaCha20** | 2015 | HChaCha20 + ChaCha20 | 192-bit nonce; same two-level construction applied to ChaCha20 [[1]](https://datatracker.ietf.org/doc/html/draft-irtf-cfrg-xchacha) |
| **XChaCha20-Poly1305** | 2015 | XChaCha20 + Poly1305 | Full AEAD; 192-bit nonce; default in libsodium `crypto_secretbox` [[1]](https://datatracker.ietf.org/doc/html/draft-irtf-cfrg-xchacha) |

**Construction:** XSalsa20 uses a two-level derivation. The first 16 bytes of the 24-byte nonce are fed into HSalsa20 together with the 256-bit key to produce a 256-bit subkey. The remaining 8 bytes serve as the nonce for a standard Salsa20 call with the subkey. Because the subkey is pseudorandom over a 256-bit space for each distinct 16-byte nonce prefix, the effective key is freshly derived per message and the nonce collision problem is eliminated.

**Why it matters:** Standard Salsa20/ChaCha20 have 64-bit nonces. A birthday collision is expected after 2³² ≈ 4 billion messages with random nonce selection — feasible in large-scale messaging or bulk file encryption. XSalsa20/XChaCha20 push this boundary to 2⁹⁶ random nonces before a collision is expected, making random nonce selection safe for any realistic deployment lifetime.

**State of the art:** XSalsa20 is the stream cipher underlying libsodium's `crypto_secretbox_xsalsa20poly1305`. XChaCha20-Poly1305 is the preferred modern variant, supported in libsodium, OpenSSL 3.x, and Tink. An IRTF CFRG Internet-Draft for XChaCha20 exists but has not been published as an RFC as of 2026.

---

## AES-CCM* (IEEE 802.15.4 / ZigBee)

**Goal:** A parameterized variant of AES-CCM for IEEE 802.15.4 low-power wireless networks (ZigBee, Thread, Matter) that supports encryption-only, authentication-only, and combined enc+auth modes via a single security-level field — using only AES-128 and targeting 8-bit microcontrollers and sub-GHz radio chips.

| Scheme | Year | Standard | Note |
|--------|------|----------|------|
| **AES-CCM** | 2004 | NIST SP 800-38C | Base CCM: always provides both confidentiality and authentication [[1]](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-38c.pdf) |
| **AES-CCM*** | 2006 | IEEE 802.15.4-2006 Annex B | Extends CCM to support three security modes via a 3-bit security level field in the MAC header [[1]](https://standards.ieee.org/ieee/802.15.4/5226/) |
| **ZigBee Security** | 2012 | ZigBee specification §4 | ZigBee network and application layers use CCM* with AES-128 and 64-bit nonces [[1]](https://zigbeealliance.org/) |
| **Thread / Matter** | 2015/2022 | Thread 1.x, Matter 1.x | Thread link-layer security uses 802.15.4 CCM*; Matter applies AES-CCM at the network layer [[1]](https://www.threadgroup.org/) |

**CCM* vs CCM:** CCM* generalizes standard CCM by allowing the authentication tag length `M` to be set to 0 (encryption only, no authentication). A 3-bit security level field in the 802.15.4 MAC frame header selects among eight modes combining AES-CTR encryption and a 0-, 4-, 8-, or 16-byte MIC. Security level 4 (encryption without authentication) exists but must never be used in practice — it provides no integrity protection and is vulnerable to chosen-ciphertext attacks.

**Nonce construction:** The 13-byte CCM* nonce is constructed from the source IEEE 802.15.4 address (8 bytes) concatenated with the frame counter (4 bytes) and the security level (1 byte), preventing nonce reuse across devices and security modes.

**State of the art:** AES-CCM* remains the mandatory link-layer cipher in IEEE 802.15.4 and all its derived stacks (ZigBee, Thread, Matter, 6LoWPAN). Hardware AES-128 accelerators in 802.15.4 radio chips (TI CC26xx, Nordic nRF52/nRF53, Silicon Labs EFR32) implement CCM* natively in the radio MAC hardware. Not suitable for general-purpose use — prefer [AES-CCM](#aes-ccm-counter-with-cbc-mac) (NIST) or AES-GCM for non-constrained environments.

---

## CAESAR Lightweight Winners (ACORN, GIFT-COFB)

**Goal:** Authenticated encryption for extremely constrained hardware — RFID tags, sensor nodes, 8-bit microcontrollers — where gate count, power, and per-bit latency dominate over throughput. The CAESAR competition (2014–2019) lightweight-use-case category produced co-winners ACORN and GIFT-COFB, each demonstrating a distinct minimal-area design strategy.

| Scheme | Year | Design strategy | State | Area | Note |
|--------|------|----------------|-------|------|------|
| **ACORN-128** | 2019 | 6-LFSR stream cipher | 293 bits | ~1 600 GE | CAESAR lightweight winner; 1 bit/cycle; 128-bit security [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |
| **GIFT-COFB** | 2019 | GIFT-128 block cipher + COFB mode | 128 bits | ~1 733 GE | CAESAR lightweight co-winner; NIST LWC finalist [[1]](https://giftcipher.github.io/gift/) |
| **Grain-128AEAD** | 2019 | NFSR+LFSR stream cipher | 256 bits | ~2 000 GE | CAESAR lightweight candidate; hardware-oriented [[1]](https://grain-128aead.github.io/) |
| **Ascon-128** | 2023 | Duplex sponge | 320 bits | ~2 006 GE | NIST LWC winner; supersedes CAESAR lightweight winners for new designs [[1]](https://ascon.iaik.tugraz.at/) |

**ACORN-128:** Uses six feedback shift registers totalling 293 bits with non-linear mixing and conditional feedback. Processes one bit per clock cycle; fits in approximately 1 600 gate equivalents — among the smallest AEAD implementations ever standardized. Nonce-respecting; nonce reuse reveals the keystream. Selected as a CAESAR co-winner in the lightweight category.

**GIFT-COFB:** Built on GIFT-128, a 128-bit block cipher derived from PRESENT with a simplified key schedule optimized for hardware. COFB (Combined Feedback) is a single-pass AEAD mode that processes one 128-bit block per cipher call using a half-block feedback mechanism for authentication, requiring no second pass. GIFT-128 achieves approximately 1 733 GE in ASIC. GIFT-COFB was a CAESAR lightweight co-winner and also a NIST LWC finalist (2023), ultimately losing to Ascon.

**CAESAR competition context:** The CAESAR competition (Competition for Authenticated Encryption: Security, Applicability, and Robustness) ran from 2014 to 2019, receiving 57 first-round submissions. The final portfolio named winners in three use cases: high-performance (AEGIS-128, OCB), lightweight (ACORN-128, GIFT-COFB), and defense-in-depth (Deoxys-II). The lightweight results directly seeded the NIST Lightweight Cryptography competition (2019–2023).

**State of the art:** ACORN and GIFT-COFB are deployed in academic hardware prototypes and some IoT security chips. For new constrained-device designs, Ascon-128 (NIST SP 800-232, 2025) is now the preferred target — it has broader tooling, more implementation variants, and active standardization. GIFT-128 (the underlying block cipher) continues as a building block in other lightweight constructions.

---

## Camellia-GCM and ARIA-GCM

**Goal:** GCM-mode AEAD using non-AES 128-bit block ciphers — Camellia (Japanese national standard) and ARIA (Korean national standard) — providing cryptographic diversity, regulatory compliance in Japan and South Korea, and an alternative cipher path in environments where reliance on a single cipher is undesirable.

| Scheme | Year | Basis | Standard | Note |
|--------|------|-------|----------|------|
| **Camellia** | 2000 | 128-bit Feistel, 128/192/256-bit keys | ISO/IEC 18033-3, RFC 3713 | Joint NTT/Mitsubishi design; equivalent security margin to AES [[1]](https://info.isl.ntt.co.jp/crypt/camellia/) |
| **Camellia-GCM (TLS)** | 2012 | Camellia + GHASH | RFC 6367 | TLS 1.2 cipher suites for Camellia-128-GCM and Camellia-256-GCM [[1]](https://www.rfc-editor.org/rfc/rfc6367) |
| **ARIA** | 2003 | 128-bit SPN, 128/192/256-bit keys | Korean KCMVP, RFC 5794 | Korean national block cipher; AES-like SPN structure [[1]](https://www.rfc-editor.org/rfc/rfc5794) |
| **ARIA-GCM (TLS)** | 2013 | ARIA + GHASH | RFC 6209 | TLS 1.2 cipher suites for ARIA-128-GCM and ARIA-256-GCM [[1]](https://www.rfc-editor.org/rfc/rfc6209) |
| **ARIA-CCM (TLS)** | 2013 | ARIA + CBC-MAC | RFC 6209 | ARIA-CCM TLS suites for constrained Korean embedded stacks [[1]](https://www.rfc-editor.org/rfc/rfc6209) |

**Why cipher diversity matters:** A single-cipher ecosystem concentrates cryptanalytic risk: a practical break in AES would compromise virtually all encrypted internet traffic. Camellia and ARIA provide drop-in alternatives with equivalent security margins and independent design lineages, allowing diverse deployment in critical infrastructure. Both are government-approved for national security use in Japan and South Korea respectively.

**GCM compatibility:** GCM's authentication component (GHASH) is cipher-agnostic — it requires only a 128-bit block cipher to derive the authentication subkey H. Camellia-GCM and ARIA-GCM therefore inherit all of GCM's properties (parallelisable CTR encryption, single-pass, associated data support) with an identical API to AES-GCM. All nonce-misuse vulnerabilities of GCM apply equally.

**State of the art:** Camellia-GCM and ARIA-GCM are deployed in TLS 1.2 stacks within Japanese and Korean government, financial, and defense networks. TLS 1.3 did not include Camellia or ARIA cipher suites in its mandatory set (only AES-GCM and ChaCha20-Poly1305), limiting these ciphers to TLS 1.2 and proprietary protocol stacks. OpenSSL ships Camellia support; ARIA is available in NSS and Korean-market TLS libraries.

---
