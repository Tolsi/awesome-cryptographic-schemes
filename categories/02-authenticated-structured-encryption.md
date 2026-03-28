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
