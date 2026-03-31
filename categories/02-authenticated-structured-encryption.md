# Authenticated & Structured Encryption


<!-- TOC -->
## Contents (57 schemes)

- [Authenticated Encryption (AEAD)](#authenticated-encryption-aead)
- [Key-Committing AEAD](#key-committing-aead)
- [Key Encapsulation Mechanism (KEM) / DEM Paradigm](#key-encapsulation-mechanism-kem--dem-paradigm)
- [Format-Preserving Encryption (FPE)](#format-preserving-encryption-fpe)
- [Disk Encryption / Tweakable Block Ciphers](#disk-encryption--tweakable-block-ciphers)
- [Order-Preserving / Order-Revealing Encryption (OPE / ORE)](#order-preserving--order-revealing-encryption-ope--ore)
- [Deterministic Encryption / Convergent Encryption](#deterministic-encryption--convergent-encryption)
- [Updatable Encryption](#updatable-encryption)
- [Rerandomizable Encryption](#rerandomizable-encryption)
- [Signcryption](#signcryption)
- [Non-Committing Encryption](#non-committing-encryption)
- [Honey Encryption](#honey-encryption)
- [Property-Preserving Encryption (PPE)](#property-preserving-encryption-ppe)
- [Puncturable Encryption](#puncturable-encryption)
- [Secure Deduplication](#secure-deduplication)
- [White-Box Cryptography](#white-box-cryptography)
- [AES-CCM (Counter with CBC-MAC)](#aes-ccm-counter-with-cbc-mac)
- [EAX Mode](#eax-mode)
- [Hybrid Public Key Encryption (HPKE)](#hybrid-public-key-encryption-hpke)
- [SpongeWrap / Duplex-Based AEAD](#spongewrap--duplex-based-aead)
- [MRAE and Online Authenticated Encryption (OAE)](#mrae-and-online-authenticated-encryption-oae)
- [OCB Mode (Offset Codebook Mode)](#ocb-mode-offset-codebook-mode)
- [AEGIS (A Fast Authenticated Encryption Algorithm)](#aegis-a-fast-authenticated-encryption-algorithm)
- [SNOW-V and SNOW-V-GCM](#snow-v-and-snow-v-gcm)
- [Rocca-S (Beyond-5G / 6G AEAD)](#rocca-s-beyond-5g--6g-aead)
- [ECIES (Elliptic Curve Integrated Encryption Scheme)](#ecies-elliptic-curve-integrated-encryption-scheme)
- [XSalsa20 and XChaCha20 (Extended-Nonce Stream Ciphers)](#xsalsa20-and-xchacha20-extended-nonce-stream-ciphers)
- [AES-CCM* (IEEE 802.15.4 / ZigBee)](#aes-ccm-ieee-802154--zigbee)
- [CAESAR Lightweight Winners (ACORN, GIFT-COFB)](#caesar-lightweight-winners-acorn-gift-cofb)
- [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard)
- [CWC Mode (Carter-Wegman + CTR)](#cwc-mode-carter-wegman--ctr)
- [AES Key Wrap (KW / KWP, RFC 5649 / NIST SP 800-38F)](#aes-key-wrap-kw--kwp-rfc-5649--nist-sp-800-38f)
- [Ciphertext Stealing (CTS)](#ciphertext-stealing-cts)
- [CBC Mode Padding and Padding Oracle Attacks](#cbc-mode-padding-and-padding-oracle-attacks)
- [Romulus AEAD (NIST LWC Finalist)](#romulus-aead-nist-lwc-finalist)
- [Xoodyak (NIST LWC Finalist)](#xoodyak-nist-lwc-finalist)
- [ISAP (NIST LWC Finalist, Side-Channel Resistant)](#isap-nist-lwc-finalist-side-channel-resistant)
- [Photon-Beetle (NIST LWC Finalist)](#photon-beetle-nist-lwc-finalist)
- [Combined AEAD Constructions: Encrypt-then-MAC, MAC-then-Encrypt, Encrypt-and-MAC](#combined-aead-constructions-encrypt-then-mac-mac-then-encrypt-encrypt-and-mac)
- [STREAM: Online Authenticated Encryption with Segmented Ciphertexts](#stream-online-authenticated-encryption-with-segmented-ciphertexts)
- [Forkcipher (ForkAES, ForkSkinny)](#forkcipher-forkaes-forkskinny)
- [Deterministic AEAD with Any Nonce (DAEAD / ANYDAE)](#deterministic-aead-with-any-nonce-daead--anydae)
- [Encode-then-Encipher and Feistel-Based Wide-Block Ciphers (EME, XCB, HCH, TET)](#encode-then-encipher-and-feistel-based-wide-block-ciphers-eme-xcb-hch-tet)
- [Robust KEM + DEM (REACT, OAEP+)](#robust-kem--dem-react-oaep)
- [Leakage-Resilient AEAD (LRAE)](#leakage-resilient-aead-lrae)
- [GCM-SST (Galois/Counter Mode with Secure Short Tags)](#gcm-sst-galoiscounter-mode-with-secure-short-tags)
- [Robust Authenticated Encryption (RAE / Beyond INT-CTXT)](#robust-authenticated-encryption-rae--beyond-int-ctxt)
- [COLM (COPA + ELmD Merge)](#colm-copa--elmd-merge)
- [MORUS (CAESAR High-Speed Finalist)](#morus-caesar-high-speed-finalist)
- [NORX (Parallel Sponge-Based AEAD)](#norx-parallel-sponge-based-aead)
- [Elephant (NIST LWC Finalist)](#elephant-nist-lwc-finalist)
- [TinyJAMBU (NIST LWC Finalist)](#tinyjambu-nist-lwc-finalist)
- [Schwaemm / SPARKLE (NIST LWC Finalist)](#schwaemm--sparkle-nist-lwc-finalist)
- [Pyjamask (Masking-Optimized AEAD)](#pyjamask-masking-optimized-aead)
- [Spook (Leakage-Resilient Sponge-Based AEAD)](#spook-leakage-resilient-sponge-based-aead)
- [ESTATE (Energy-Efficient Short-Tweak TBC-Based AEAD)](#estate-energy-efficient-short-tweak-tbc-based-aead)
- [Partitioning Oracle Attacks and Committing AEAD Landscape](#partitioning-oracle-attacks-and-committing-aead-landscape)
<!-- /TOC -->


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

**Production readiness:** Production
Deployed at scale in TLS 1.3, WireGuard, IPsec, disk encryption, and virtually all modern encrypted communications.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-GCM and ChaCha20-Poly1305 with hardware acceleration
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, XChaCha20-Poly1305 and AES-256-GCM
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C, Google's OpenSSL fork with AES-GCM-SIV
- [liboqs-ascon](https://github.com/ascon/ascon-c) ⭐ 276 — C, reference Ascon implementation

**Security status:** Secure
All listed schemes are secure at recommended parameters; AES-GCM requires unique nonces (nonce reuse is catastrophic).

**Community acceptance:** Standard
AES-GCM and ChaCha20-Poly1305 are NIST/IETF standards; AES-GCM-SIV is RFC 8452; Ascon is NIST SP 800-232.

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

**Production readiness:** Experimental
Active adoption in messaging protocols (Signal, Matrix) and cloud backup; no standalone NIST standard yet.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, key-committing AEAD in Signal protocol
- [miscreant](https://github.com/miscreant/miscreant.rb) ⭐ 22 [archived] — Ruby/JS/Rust, AES-SIV (partially committing)

**Security status:** Secure
Provably secure transforms; HtE and CMT-4 add minimal overhead to base AEAD with formal proofs.

**Community acceptance:** Emerging
Active standardization discussion at NIST Block Cipher Modes Workshop (2023); adopted by Signal and cloud backup systems.

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

**Production readiness:** Production
KEM/DEM is the foundation of HPKE (RFC 9180), ML-KEM (FIPS 203), and all modern hybrid encryption deployed in TLS, MLS, and QUIC.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA-KEM, DHKEM, ML-KEM support
- [hpke](https://github.com/cisco/go-hpke) ⭐ 30 — Go, HPKE implementation with DHKEM
- [aws-lc](https://github.com/aws/aws-lc) ⭐ 731 — C, ML-KEM (Kyber) in production at AWS

**Security status:** Secure
The KEM/DEM paradigm has clean, well-understood security reductions; IND-CCA2 KEM + IND-CPA DEM = IND-CCA2 hybrid.

**Community acceptance:** Standard
NIST FIPS 203 (ML-KEM), IETF RFC 9180 (HPKE), ISO 18033-2; the universal paradigm for public-key encryption.

---

## Format-Preserving Encryption (FPE)

**Goal:** Confidentiality with structural compatibility. Ciphertext has the exact same format as plaintext — a 16-digit credit card number encrypts to another 16-digit number. Required for PCI-DSS tokenization and legacy systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FF1** | 2016 | Feistel + AES | NIST SP 800-38G standard; variable-radix alphabet [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/final) |
| **FF3-1** | 2019 | Feistel + AES tweaked | NIST SP 800-38G Rev.1; replaces broken FF3 [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/g/rev-1/final) |
| **BPS (Bellare-Pian-Shi)** | 2010 | Feistel | Theoretical foundation for FPE security [[1]](https://eprint.iacr.org/2009/251) |

**State of the art:** FF1 (general), FF3-1 (tweakable, NIST standard).

**Production readiness:** Production
Deployed in PCI-DSS tokenization systems, payment processing, and legacy database encryption at major enterprises.

**Implementations:**
- [pyffx](https://github.com/emulbreh/pyffx) ⭐ 55 — Python, FF1 implementation
- [format-preserving-encryption](https://github.com/capitalone/fpe) ⭐ 208 [archived] — Go, FF1 implementation by Capital One
- [Mysto FPE](https://github.com/mysto/java-fpe) ⭐ 75 — Java, FF1 and FF3-1 implementations
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, FF1 support (via EVP API)

**Security status:** Caution
FF1 and FF3-1 are secure for sufficiently large domains; small-domain FPE has inherent leakage. FF3 (original) is broken and must not be used.

**Community acceptance:** Standard
NIST SP 800-38G (FF1) and SP 800-38G Rev.1 (FF3-1); widely adopted in PCI-DSS tokenization.

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

**Production readiness:** Production
XTS-AES is deployed in BitLocker, FileVault, LUKS, and Android FBE on billions of devices.

**Implementations:**
- [Linux kernel dm-crypt](https://gitlab.com/cryptsetup/cryptsetup) — C, XTS-AES, Adiantum, AES-HCTR2 in kernel
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, XTS-AES mode
- [Adiantum (Android)](https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/crypto/adiantum.c) — C, kernel implementation by Google

**Security status:** Secure
XTS-AES provides sector-level confidentiality but not authentication; Adiantum and HCTR2 are secure wide-block alternatives.

**Community acceptance:** Standard
IEEE 1619 (XTS-AES); NIST approved for storage encryption; Adiantum and HCTR2 deployed by Google in Android.

---

## Order-Preserving / Order-Revealing Encryption (OPE / ORE)

**Goal:** Encrypted range queries. Ciphertext preserves or reveals the numerical order of plaintexts, enabling range queries on encrypted databases without decrypting. **Warning:** inherent leakage; weaker than standard encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boldyreva OPE** | 2009 | Hypergeometric sampling | First provably secure OPE; leaks order + approximate distance [[1]](https://eprint.iacr.org/2009/197) |
| **Chenette-Lewi-Wu ORE** | 2016 | PRF + block cipher | Reveals only order, not distance; "best-possible" ORE [[1]](https://eprint.iacr.org/2016/612) |
| **Lewi-Wu Practical ORE** | 2016 | PRF | Efficient; used in CryptDB-like systems [[1]](https://eprint.iacr.org/2016/612) |

**State of the art:** Lewi-Wu ORE (practical), but SSE/FHE approaches preferred when leakage is unacceptable.

**Production readiness:** Experimental
Used in encrypted database research (CryptDB-like systems); limited real-world deployment due to inherent leakage.

**Implementations:**
- [CryptDB](https://github.com/CryptDB/CryptDB) ⭐ 521 — C++, OPE used in encrypted database queries
- [pyope](https://github.com/tonyo/pyope) ⭐ 103 — Python, Boldyreva OPE implementation

**Security status:** Caution
All OPE/ORE inherently leaks order (and sometimes distance); inference attacks can reconstruct plaintext distributions from ciphertext order.

**Community acceptance:** Niche
No standardization; used in academic encrypted database research. Widely criticized for leakage in practice.

---

## Deterministic Encryption / Convergent Encryption

**Goal:** Encrypted deduplication & lookup. Same plaintext always produces the same ciphertext, enabling equality checks without decryption. Leaks plaintext equality — not suitable where this matters.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SIV Mode (Rogaway-Shrimpton)** | 2006 | AES + CMAC | Deterministic AEAD; misuse-resistant; IV = MAC(header, plaintext) [[1]](https://eprint.iacr.org/2006/221) |
| **Convergent Encryption** | 2002 | Hash-as-key | Key = H(plaintext); enables cloud dedup of encrypted data [[1]](https://dl.acm.org/doi/10.5555/514236.514238) |
| **MLE (Message-Locked Encryption)** | 2013 | Various | Formalization of convergent encryption with security definitions [[1]](https://eprint.iacr.org/2012/631) |

**State of the art:** AES-SIV (misuse-resistant AEAD, RFC 5297), MLE (cloud deduplication).

**Production readiness:** Production
AES-SIV is deployed in cloud storage, key wrapping, and encrypted databases; convergent encryption is used in deduplication systems.

**Implementations:**
- [miscreant](https://github.com/miscreant/miscreant.rb) ⭐ 22 [archived] — Ruby/JS/Rust/Go, AES-SIV (RFC 5297)
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++/Python, AES-SIV (deterministic AEAD)
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-SIV support

**Security status:** Caution
AES-SIV is secure but deterministic (leaks plaintext equality). Convergent encryption is vulnerable to offline brute-force on low-entropy data.

**Community acceptance:** Standard
AES-SIV is IETF RFC 5297; MLE is a well-studied framework. Convergent encryption is deployed but with known limitations.

---

## Updatable Encryption

**Goal:** Key rotation without re-download. Server applies a short re-encryption token to update all ciphertexts from an old key to a new key — without decrypting or downloading data. Used in cloud storage key rotation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BLMR (Boneh et al.)** | 2013 | ElGamal / AES | Formal model for ciphertext-independent updates [[1]](https://eprint.iacr.org/2012/021) |
| **Lehmann-Tackmann** | 2018 | Hybrid (KEM + DEM) | CCA-secure updatable encryption [[1]](https://eprint.iacr.org/2018/794) |
| **Klooß-Lehmann-Rupp** | 2019 | Forward-secure enc | Forward + post-compromise security [[1]](https://eprint.iacr.org/2019/043) |

**State of the art:** Klooß-Lehmann-Rupp (strongest security guarantees), BLMR (foundational).

**Production readiness:** Research
Academic constructions; no widely deployed production system uses formal updatable encryption schemes.

**Implementations:**
- [Recrypt](https://github.com/IronCoreLabs/recrypt-rs) ⭐ 166 — Rust, proxy re-encryption (related primitive)

**Security status:** Secure
Klooß-Lehmann-Rupp provides forward and post-compromise security; formal proofs in standard model.

**Community acceptance:** Niche
Active academic research; no NIST or IETF standardization. Cloud key rotation typically uses simpler re-encryption approaches.

---

## Rerandomizable Encryption

**Goal:** Unlinkable ciphertexts. Anyone can publicly transform a ciphertext into a fresh-looking encryption of the same plaintext — unlinkable to the original. Foundation of mixnets and anonymous credentials.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ElGamal (rerandomizable)** | 1985 | DDH | Naturally rerandomizable: multiply by Enc(1) [[1]](https://link.springer.com/chapter/10.1007/3-540-39568-7_2) |
| **Groth RCCA** | 2004 | Pairings | CCA-secure under rerandomization (RCCA model) [[1]](https://eprint.iacr.org/2003/174) |
| **Prabhakaran-Rosulek RCCA** | 2007 | DDH | Efficient RCCA without pairings [[1]](https://eprint.iacr.org/2007/064) |

**State of the art:** Groth RCCA (provable security), ElGamal (practical in mixnets/voting).

**Production readiness:** Mature
ElGamal rerandomization is deployed in mixnets and e-voting systems; RCCA schemes remain research constructions.

**Implementations:**
- [Verificatum](https://www.verificatum.org/) — Java, ElGamal-based mixnet for e-voting
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, ElGamal primitives (via Ristretto255)
- [Helios](https://github.com/benadida/helios-server) ⭐ 888 — Python, rerandomizable ElGamal in e-voting

**Security status:** Secure
ElGamal rerandomization is secure under DDH; Groth RCCA has formal proofs under pairing assumptions.

**Community acceptance:** Niche
ElGamal rerandomization is well-established in e-voting and mixnet communities; RCCA is a specialized academic notion.

---

## Signcryption

**Goal:** Confidentiality + Authentication + Non-repudiation in a single pass. More efficient than sequential sign-then-encrypt; security is proven jointly (IND-CCA2 + EUF-CMA).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Zheng Signcryption** | 1997 | DLP / EC | First scheme; ~50% cost reduction vs. sign+encrypt [[1]](https://link.springer.com/chapter/10.1007/BFb0052234) |
| **ECSC (Bao-Deng)** | 1998 | ECDLP | Elliptic curve variant; formal security proof [[1]](https://link.springer.com/chapter/10.1007/BFb0052237) |
| **Signcryption KEM/DEM** | 2004 | Hybrid | Modular: KEM provides authenticated key + DEM encrypts [[1]](https://eprint.iacr.org/2004/075) |

**State of the art:** Hybrid signcryption KEM/DEM (provable security), used in secure messaging design.

**Production readiness:** Mature
Signcryption concepts are used in secure messaging and CMS; standalone signcryption schemes have limited direct deployment.

**Implementations:**
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, signcryption primitives
- [IEEE 1363-2000](https://standards.ieee.org/ieee/1363/835/) — Standard, includes ECSC signcryption

**Security status:** Secure
Provably secure (IND-CCA2 + EUF-CMA) in the hybrid KEM/DEM model; EC-based schemes are well-studied.

**Community acceptance:** Niche
IEEE 1363 includes signcryption; not widely adopted as a standalone primitive — most systems use separate sign-then-encrypt.

---

## Non-Committing Encryption

**Goal:** Simulation security for encryption. After generating a ciphertext, the simulator can "explain" it as an encryption of any message — by revealing fake randomness. Required for UC-secure (universally composable) protocols, where standard CPA/CCA encryption is insufficient.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Canetti-Feige-Goldreich-Naor NCE** | 1996 | OT | First NCE; based on oblivious transfer [[1]](https://doi.org/10.1145/237814.237866) |
| **Nielsen NCE** | 2002 | Trapdoor permutations | Efficient NCE from any trapdoor permutation [[1]](https://doi.org/10.1007/3-540-45539-6_14) |
| **Adaptively Secure NCE (Choi et al.)** | 2009 | DDH | Non-committing encryption secure against adaptive corruption [[1]](https://eprint.iacr.org/2009/035) |
| **Non-Committing Authenticated Enc** | 2017 | AEAD + NCE | Combine authenticity with non-committing property for UC channels [[1]](https://eprint.iacr.org/2017/332) |

**State of the art:** DDH-based NCE (Choi et al.); essential for UC-secure [Secure Channels](12-secure-communication-protocols.md#secure-channels--protocol-constructions) and [MPC](06-multi-party-computation.md#multi-party-computation-mpc) in the adaptive corruption model.

**Production readiness:** Research
Academic primitive; used as a building block in UC-secure protocol proofs but not deployed as a standalone scheme.

**Implementations:**
- No widely available standalone open-source implementations; NCE appears as a component in UC-secure MPC frameworks.

**Security status:** Secure
DDH-based NCE (Choi et al.) is provably secure under standard assumptions; constructions are well-studied.

**Community acceptance:** Niche
Essential in UC-security theory; understood by the MPC/secure-channels research community but not standardized.

---

## Honey Encryption

**Goal:** Brute-force resistance. Decrypting with any wrong key produces a plausible-looking plaintext, so an attacker cannot tell when they found the correct key. Protects low-entropy secrets (passwords, PINs, credit card numbers).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Honey Encryption (HE)** | 2014 | DTE (distribution-transforming encoder) | Foundational; each wrong key yields valid-looking plaintext [[1]](https://eprint.iacr.org/2014/155) |
| **Natural Language HE** | 2015 | NLP + DTE | Honey encryption for natural language messages; GPT-based DTEs [[1]](https://eprint.iacr.org/2015/032) |
| **Honey Encryption for Genomic Data** | 2016 | Genomic DTE | Domain-specific for protecting genome sequences [[1]](https://doi.org/10.1145/2976749.2978370) |

**State of the art:** Juels-Ristenpart HE (2014) with domain-specific DTEs; adopted in password vault research. Key challenge: designing accurate DTEs for arbitrary domains.

**Production readiness:** Research
Academic proposals and prototypes; no mainstream production deployment beyond research password vault experiments.

**Implementations:**
- [honey-encryption](https://github.com/victornguyen75/honey-encryption) ⭐ 12 — Python, research implementation of Juels-Ristenpart HE
- [honeywords](https://github.com/maheshmb13/Honeywords) ⭐ 3 — Python, related honeyword generation for password databases

**Security status:** Caution
Security depends entirely on the quality of the DTE (distribution-transforming encoder); poor DTEs provide no meaningful protection.

**Community acceptance:** Niche
Well-regarded academic concept; limited practical adoption due to difficulty of constructing accurate DTEs for real-world data.

---

## Property-Preserving Encryption (PPE)

**Goal:** Unifying framework for structured leakage. Encryption that intentionally preserves a specific property of the plaintext — enabling server-side computation without decryption. Formalizes the tradeoff between functionality and leakage for encrypted databases.

| Property | Scheme | Note |
|----------|--------|------|
| **Equality** | [Deterministic Encryption](#deterministic-encryption--convergent-encryption) | Same plaintext → same ciphertext; enables dedup and equality search |
| **Order** | [OPE / ORE](#order-preserving--order-revealing-encryption-ope--ore) | Ciphertext preserves numerical order; enables range queries |
| **Orthogonality** | [Inner-Product FE](#puncturable-encryption) | Decrypt iff inner product = 0; enables subset queries |
| **Pattern match** | [HVE](#puncturable-encryption) | Decrypt iff attributes match pattern with wildcards |
| **Keyword** | [Searchable Encryption](#updatable-encryption) | Search encrypted data by keyword |

**General framework:** Pandey-Rouselakis (2012) [[1]](https://eprint.iacr.org/2012/141) formalized PPE; Boldyreva-Chenette-O'Neill (2011) [[1]](https://eprint.iacr.org/2011/005) analyzed leakage. **Warning:** all PPE inherently leaks — weaker than semantic security. Use only when the leakage-functionality tradeoff is acceptable.

**State of the art:** PPE is the theoretical umbrella for OPE, deterministic encryption, and HVE. CryptDB (2011) demonstrated practical encrypted SQL using multiple PPE layers. Subsequent inference attacks (Naveed-Kamara-Wright 2015, Grubbs et al. 2017) showed real-world leakage exploitation, tempering enthusiasm for PPE-based encrypted databases.

**Production readiness:** Experimental
Individual PPE schemes (OPE, deterministic encryption) are deployed in encrypted databases; the unifying PPE framework is academic.

**Implementations:**
- [CryptDB](https://github.com/CryptDB/CryptDB) ⭐ 521 — C++, uses multiple PPE schemes for encrypted SQL queries
- [Arx](https://github.com/ArkDB) — research encrypted database using PPE primitives

**Security status:** Caution
All PPE inherently leaks the preserved property; inference attacks have been demonstrated against deployed encrypted databases.

**Community acceptance:** Niche
Academic framework; individual PPE schemes are used in encrypted database research but criticized for practical leakage.

---

## Puncturable Encryption

**Goal:** Forward-secure decryption. A recipient can "puncture" their secret key on specific ciphertexts they've already decrypted — the punctured key can decrypt everything *except* those messages. Provides forward secrecy without sender-side changes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Green-Miers Puncturable Enc** | 2015 | Puncturable PRF + IBE | Puncture decryption key at tags; based on HIBE [[1]](https://eprint.iacr.org/2014/984) |
| **Bloom Filter Encryption** | 2018 | BF + puncturable PRF | Efficiently puncture on a Bloom filter of processed messages [[1]](https://eprint.iacr.org/2018/199) |
| **0-RTT with Puncturable Enc** | 2017 | TLS + puncturable enc | Replay-resistant 0-RTT key exchange without server state [[1]](https://eprint.iacr.org/2017/004) |

**State of the art:** Bloom Filter Encryption (practical), 0-RTT puncturable (TLS optimization).

**Production readiness:** Research
Academic constructions; 0-RTT puncturable encryption concepts influence TLS design but no standalone deployment.

**Implementations:**
- No production-quality standalone libraries; concepts integrated into TLS 1.3 anti-replay research.

**Security status:** Secure
Provably secure under IBE/HIBE assumptions; Bloom Filter Encryption provides efficient puncturing with well-understood false-positive rates.

**Community acceptance:** Niche
Active research area; influences TLS 0-RTT anti-replay design but no IETF or NIST standardization of puncturable encryption itself.

---

## Secure Deduplication

**Goal:** Encrypted storage with duplicate elimination. Cloud server detects and removes duplicate files among encrypted uploads — without decrypting. Saves storage while preserving confidentiality. Formalizes security of convergent encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Douceur et al. Convergent Encryption** | 2002 | H(plaintext) as key | Deterministic encryption for dedup; see [Deterministic Encryption](#deterministic-encryption--convergent-encryption) [[1]](https://doi.org/10.1145/514236.514243) |
| **Bellare-Keelveedhi-Ristenpart (DupLESS)** | 2013 | Server-aided MLE | Server-aided message-locked encryption; key from OPRF prevents offline brute-force [[1]](https://eprint.iacr.org/2013/429) |
| **Secure Dedup with PoW (Halevi et al.)** | 2011 | Proof of ownership | Client proves it owns file before server deduplicates [[1]](https://eprint.iacr.org/2011/277) |

**State of the art:** DupLESS (server-aided OPRF-based dedup); extends [Deterministic Encryption](#deterministic-encryption--convergent-encryption) with formal security and [OPRF](10-privacy-preserving-computation.md#oblivious-prf-oprf).

**Production readiness:** Experimental
DupLESS is a research prototype; convergent encryption concepts are used in production cloud storage (e.g., Tahoe-LAFS) but without formal security guarantees.

**Implementations:**
- [Tahoe-LAFS](https://github.com/tahoe-lafs/tahoe-lafs) ⭐ 1.4k — Python, convergent encryption for distributed storage
- [DupLESS](https://github.com/FadyMohareb/dupless) ⭐ 2 — research prototype

**Security status:** Caution
Convergent encryption is vulnerable to offline brute-force on predictable files; DupLESS mitigates this via server-aided OPRF.

**Community acceptance:** Niche
Academic research; convergent encryption is deployed in some cloud storage but secure deduplication with formal guarantees remains research-stage.

---

## White-Box Cryptography

**Goal:** Key hiding in hostile environments. Implement cryptographic algorithms so that the secret key cannot be extracted even by an adversary who has full access to the running software and execution environment. Used in DRM, mobile payments.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chow et al. WB-AES** | 2002 | Lookup tables + mixing bijections | First white-box AES; series of table lookups encoding key [[1]](https://link.springer.com/chapter/10.1007/3-540-36492-7_17) |
| **Billet et al. (cryptanalysis)** | 2004 | Algebraic attack | Broke Chow WB-AES; showed key extraction is possible [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30564-4_16) |
| **WBC Challenge (CHES)** | 2017 | Competition | Ongoing competitions show no WBC scheme survives long-term attack [[1]](https://www.whiteboxcrypto.com/) |

**State of the art:** no provably secure WBC exists; practical deployments rely on obfuscation + tamper-detection layers. Active research area.

**Production readiness:** Experimental
Deployed in commercial DRM and mobile payment SDKs (e.g., Apple Pay, content protection) despite lack of provable security.

**Implementations:**
- [SideChannelMarvels/Deadpool](https://github.com/SideChannelMarvels/Deadpool) ⭐ 677 — C/Python, white-box AES attack tools and challenge implementations
- [WhibOx](https://www.whiteboxcrypto.com/) — competition platform with reference white-box implementations

**Security status:** Broken
No published white-box AES scheme has survived sustained cryptanalysis; all CHES competition entries broken within weeks to months.

**Community acceptance:** Controversial
Widely used commercially (DRM, payments) despite academic consensus that provable white-box security is currently unachievable.

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

**Production readiness:** Production
Mandatory in WPA2, Bluetooth LE, and available in TLS 1.2/1.3; deployed on billions of wireless devices.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-CCM cipher suites
- [mbedTLS](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C, AES-CCM for embedded/IoT
- [wpa_supplicant](https://w1.fi/wpa_supplicant/) — C, CCMP implementation for Wi-Fi
- [Linux kernel](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) — C, AES-CCM in wireless and Bluetooth subsystems

**Security status:** Secure
Provably secure (IND-CPA + INT-CTXT) under PRP assumption for AES; nonce reuse is catastrophic (same as GCM).

**Community acceptance:** Standard
NIST SP 800-38C; IEEE 802.11i (WPA2); Bluetooth Core Specification; RFC 6655 (TLS).

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

**Production readiness:** Mature
Widely implemented in cryptographic libraries; used in some IoT and embedded stacks but not a primary NIST standard.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-EAX (via EVP)
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, EAX mode
- [Crypto++](https://github.com/weidai11/cryptopp) ⭐ 5.4k — C++, EAX mode implementation

**Security status:** Secure
Provably secure (IND-CCA2 + INT-CTXT) under standard block-cipher assumptions; patent-free.

**Community acceptance:** Widely trusted
Not a NIST standard but well-studied, patent-free, and implemented in all major cryptographic libraries.

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

**Production readiness:** Production
Deployed in TLS Encrypted Client Hello (ECH), Oblivious HTTP, MLS, and Privacy Preserving Measurement protocols.

**Implementations:**
- [hpke (Cloudflare)](https://github.com/cloudflare/circl) ⭐ 1.6k — Go, HPKE in CIRCL library
- [rust-hpke](https://github.com/rozbb/rust-hpke) ⭐ 86 — Rust, HPKE RFC 9180 implementation
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C, HPKE for ECH in Chrome
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, HPKE support (3.2+)

**Security status:** Secure
Formally verified security proofs; modular composition of well-studied KEM, KDF, and AEAD components.

**Community acceptance:** Standard
IETF RFC 9180; mandated for ECH (draft-ietf-tls-esni), MLS (RFC 9420), and Oblivious HTTP (RFC 9458).

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

**Production readiness:** Production
Ascon (the primary duplex AEAD) is NIST-standardized; Keccak sponge construction underlies SHA-3 deployed everywhere.

**Implementations:**
- [ascon-c](https://github.com/ascon/ascon-c) ⭐ 276 — C, reference Ascon implementation
- [Keccak Team XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C/assembly, extended Keccak code package including SpongeWrap
- [Keyak](https://keccak.team/keyak.html) — reference implementation by Keccak team

**Security status:** Secure
Security bound is 2^(capacity/2) against generic attacks; Ascon has no known shortcut attacks on full rounds.

**Community acceptance:** Standard
Ascon is NIST SP 800-232 (2025); SpongeWrap/duplex paradigm is the foundation of SHA-3 and NIST LWC.

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

**Production readiness:** Production
AES-SIV and AES-GCM-SIV are deployed in Google infrastructure, TLS, and cloud key management; OAE schemes are research-only.

**Implementations:**
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C, AES-GCM-SIV (used in Google production)
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++, AES-GCM-SIV and AES-SIV
- [miscreant](https://github.com/miscreant/miscreant.rb) ⭐ 22 [archived] — Ruby/JS/Rust, AES-SIV

**Security status:** Secure
AES-SIV and AES-GCM-SIV are provably MRAE-secure; nonce reuse leaks only plaintext equality, not authenticity.

**Community acceptance:** Standard
AES-SIV is IETF RFC 5297; AES-GCM-SIV is RFC 8452. OAE remains an academic security model without standardization.

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

**Production readiness:** Mature
Patent-free since 2021; implemented in major libraries but limited deployment compared to AES-GCM due to late patent resolution.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, OCB mode (EVP_aes_*_ocb)
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, AES-256-OCB
- [Botan](https://github.com/randombit/botan) ⭐ 3.2k — C++, OCB mode
- [ocb-ref](https://www.cs.ucdavis.edu/~rogaway/ocb/code.htm) — C, reference implementation by Rogaway

**Security status:** Caution
OCB3 is secure; OCB2 is broken (practical forgery attack, 2019). Must use OCB3 only.

**Community acceptance:** Widely trusted
RFC 7253; CAESAR finalist; well-studied but not NIST-standardized. Patent-free since 2021 removes adoption barrier.

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

**Production readiness:** Mature
CAESAR winner; IETF CFRG draft in progress; adopted in high-throughput TLS and storage systems but not yet an RFC.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, AEGIS-128L and AEGIS-256
- [libaegis](https://github.com/jedisct1/libaegis) ⭐ 129 — C, dedicated AEGIS library with AVX-512/VAES support
- [rust-aegis](https://github.com/jedisct1/rust-aegis) ⭐ 40 — Rust, AEGIS bindings

**Security status:** Secure
128/256-bit security; minor linear biases found (Minaud, 2018) do not break the scheme. Nonce misuse is catastrophic.

**Community acceptance:** Emerging
CAESAR high-performance winner; IETF CFRG draft progressing toward RFC; endorsed by libsodium maintainer.

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

**Production readiness:** Experimental
Research proposal from Ericsson/Lund University; hardware prototypes exist but no formal standardization or production deployment.

**Implementations:**
- [Ericsson SNOW-V](https://eprint.iacr.org/2018/1143) — paper includes reference code

**Security status:** Secure
256-bit security; extensive cryptanalysis by Ericsson and academic community; no practical attacks on full SNOW-V.

**Community acceptance:** Niche
Presented at IETF SAAG (2019); 3GPP chose ZUC for 5G radio layer instead. SNOW-V targets virtualized transport layer.

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

**Production readiness:** Research
IETF informational Internet-Draft; no standardization or production deployment. Premature for use pending deeper cryptanalysis.

**Implementations:**
- [Rocca-S reference](https://datatracker.ietf.org/doc/draft-nakano-rocca-s/) — IETF draft includes reference code
- No standalone open-source library as of 2026.

**Security status:** Caution
256-bit security target but practical key-committing attacks demonstrated (2025); not yet peer-reviewed to the depth of AES-GCM.

**Community acceptance:** Niche
IETF informational draft; research candidate for 6G. No 3GPP or NIST standardization; limited independent cryptanalysis.

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

**Production readiness:** Production
Deployed in TLS 1.2, S/MIME, OpenPGP, Ethereum (eciesjs), Apple/Google payment systems, and HSMs worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, ECIES via EVP_PKEY_derive
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, ECIES (ANSI X9.63 and ISO 18033-2)

**Security status:** Superseded
Technically secure (IND-CCA2 under CDH) but fragmented across incompatible variants. HPKE (RFC 9180) is the recommended successor.

**Community acceptance:** Standard
ANSI X9.63, IEEE 1363a, ISO 18033-2; widely standardized but superseded by HPKE for new protocol designs.

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

**Production readiness:** Production
XChaCha20-Poly1305 is the default AEAD in libsodium (used by Signal, Wireguard-related tools, age encryption); XSalsa20 in NaCl.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, XChaCha20-Poly1305 (crypto_aead) and XSalsa20-Poly1305 (crypto_secretbox)
- [NaCl](https://nacl.cr.yp.to/) — C, original XSalsa20-Poly1305 by Bernstein
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, XChaCha20-Poly1305 (3.x)
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++, XChaCha20-Poly1305

**Security status:** Secure
256-bit key, 192-bit nonce eliminates birthday-bound nonce collision risk; secure under standard PRF assumptions.

**Community acceptance:** Widely trusted
IRTF CFRG draft (not yet RFC); de facto standard via libsodium adoption; endorsed by Bernstein and the NaCl community.

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

**Production readiness:** Production
Mandatory in IEEE 802.15.4, ZigBee, Thread, and Matter; implemented in hardware on billions of IoT radio chips.

**Implementations:**
- [Zephyr RTOS](https://github.com/zephyrproject-rtos/zephyr) ⭐ 14k — C, AES-CCM* in IEEE 802.15.4 subsystem
- [RIOT-OS](https://github.com/RIOT-OS/RIOT) ⭐ 5.7k — C, AES-CCM* for 802.15.4
- [Nordic nRF SDK](https://github.com/nrfconnect/sdk-nrf) ⭐ 1.3k — C, hardware-accelerated CCM* on nRF52/nRF53

**Security status:** Caution
Secure when used with authentication (security levels 5-7); encryption-only mode (level 4) provides no integrity and must not be used.

**Community acceptance:** Standard
IEEE 802.15.4-2006 Annex B; mandated in ZigBee, Thread, and Matter specifications.

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

**Production readiness:** Experimental
CAESAR winners with academic hardware prototypes; superseded by Ascon (NIST LWC) for new designs.

**Implementations:**
- [GIFT-COFB reference](https://giftcipher.github.io/gift/) — C, reference implementation
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, ACORN and GIFT-COFB benchmarking implementations
- [NIST LWC submissions](https://csrc.nist.gov/projects/lightweight-cryptography) — reference code for all candidates

**Security status:** Secure
Both ACORN and GIFT-COFB are secure at design parameters; nonce reuse breaks ACORN confidentiality.

**Community acceptance:** Niche
CAESAR lightweight winners (2019); superseded by Ascon (NIST SP 800-232) for standardized lightweight AEAD.

---

## Ascon-128 / Ascon-128a (NIST LWC Standard)

**Goal:** The NIST Lightweight Cryptography (LWC) standard AEAD for constrained devices — microcontrollers, RFID tags, IoT sensors — providing 128-bit security with a minimal footprint, a single hardware-friendly permutation, and a clean duplex-sponge design that covers both AEAD and hashing under one primitive family.

| Variant | Rate | Capacity | Rounds (p^a / p^b) | Tag | Throughput (SW) | Note |
|---------|------|----------|---------------------|-----|-----------------|------|
| **Ascon-128** | 64-bit | 256-bit | 12 / 6 | 128-bit | ~7 cpb (ARM Cortex-M) | Default; conservative; 64-bit rate [[1]](https://ascon.iaik.tugraz.at/) |
| **Ascon-128a** | 128-bit | 192-bit | 12 / 8 | 128-bit | ~4 cpb (ARM Cortex-M) | Faster; 128-bit rate; fewer capacity bits — acceptable for most IoT threat models [[1]](https://ascon.iaik.tugraz.at/) |
| **Ascon-80pq** | 64-bit | 256-bit | 12 / 6 | 128-bit | ~7 cpb | 160-bit key; post-quantum conservative variant against Grover [[1]](https://ascon.iaik.tugraz.at/) |
| **Ascon-Hash / Ascon-Hasha** | — | — | 12 / 12 or 8 | — | — | Companion hash functions from the same permutation family [[1]](https://ascon.iaik.tugraz.at/) |

**Designers:** Christoph Dobraunig, Maria Eichlseder, Florian Mendel, Martin Schläffer (Graz University of Technology / Infineon), 2015. Selected as NIST LWC standard in February 2023; published as NIST SP 800-232 (2025).

**Permutation (Ascon-p):** The state is 320 bits (5 × 64-bit words). Each round applies three layers:
1. **pC** — constant addition: a round constant XOR'd into word 2, differing each round.
2. **pS** — non-linear substitution: a 5-bit S-box applied bit-sliced across all 64 columns of the 5-word state.
3. **pL** — linear diffusion: two rotations XOR'd into each word (e.g., word 0: `x0 ⊕= (x0 >>> 19) ⊕ (x0 >>> 28)`).

Initialization: state ← Ascon-p^12(IV ‖ Key ‖ Nonce). Processing: each 64-bit (Ascon-128) or 128-bit (Ascon-128a) block of associated data or plaintext is XOR'd into the rate portion and followed by Ascon-p^6 (or p^8). Finalization: Key is XOR'd into the capacity, then Ascon-p^12 is applied, and the 128-bit tag is extracted.

**Security:** 128-bit security under nonce-respecting conditions. Capacity bits (256 for Ascon-128, 192 for Ascon-128a) are never exposed, providing the security buffer. Nonce reuse leaks plaintext XOR but does not break authentication (unlike GCM). Best-known attack is a differential distinguisher on 6-round reduced Ascon-p; full 12-round initialization has no known shortcut.

**Hardware footprint:** ~1 400–2 006 gate equivalents for ASIC depending on implementation style; 320-bit state fits in a compact SRAM cell array. On 64-bit CPUs, the five 64-bit word state maps naturally to registers, giving good software performance.

**Deployments:** Nordic Semiconductor nRF9160 SDK; RIOT-OS; Zephyr RTOS; ARM Cortex-M reference implementation in NIST SP 800-232. See also [SpongeWrap / Duplex-Based AEAD](#spongewrap--duplex-based-aead) and [CAESAR Lightweight Winners](#caesar-lightweight-winners-acorn-gift-cofb).

**State of the art:** NIST SP 800-232 (2025) designates Ascon-128 as the primary AEAD for constrained devices, with Ascon-128a as an approved faster alternative. Ascon-80pq is recommended where 128-bit post-quantum key security is required. The Ascon family supersedes ad-hoc lightweight AEAD constructions for new IoT designs.

**Production readiness:** Production
NIST SP 800-232 (2025); deployed in Nordic nRF9160, RIOT-OS, Zephyr RTOS, and ARM Cortex-M reference implementations.

**Implementations:**
- [ascon-c](https://github.com/ascon/ascon-c) ⭐ 276 — C, official reference implementation
- [ascon-python](https://github.com/meichlseder/pyascon) ⭐ 84 — Python, reference implementation by designers
- [RIOT-OS](https://github.com/RIOT-OS/RIOT) ⭐ 5.7k — C, Ascon in constrained-device RTOS
- [Zephyr RTOS](https://github.com/zephyrproject-rtos/zephyr) ⭐ 14k — C, Ascon crypto subsystem

**Security status:** Secure
128-bit security; no known shortcut attacks on full 12-round initialization; extensive NIST LWC competition cryptanalysis.

**Community acceptance:** Standard
NIST SP 800-232 (2025); NIST LWC winner (2023); endorsed by NIST, Graz University of Technology, and Infineon.

---

## CWC Mode (Carter-Wegman + CTR)

**Goal:** Provide an authenticated encryption with associated data (AEAD) mode that achieves ~128-bit authentication security by combining CTR-mode encryption with a Carter-Wegman MAC built on a 96-bit prime-field universal hash function — offering a provably-secure, patent-free alternative to GCM at the cost of heavier (but parallelisable) authentication arithmetic.

| Property | Value |
|----------|-------|
| **Authors** | Kohno, Viega, Whiting (2004) |
| **Publication** | FSE 2004 [[1]](https://csrc.nist.gov/groups/ST/toolkit/BCM/documents/proposedmodes/cwc/cwc-spec.pdf) |
| **Block cipher** | AES-128 (or any 128-bit cipher) |
| **MAC basis** | Universal hash over GF(2^127 − 1) (96-bit prime-field arithmetic) |
| **Nonce length** | 96 bits |
| **Tag length** | 128 bits |
| **Parallelism** | Yes — authentication blocks are independent |
| **Patent status** | Unencumbered |

**Construction:** CWC separates authentication and encryption into two explicitly independent components:
1. **Encryption:** standard CTR mode using the block cipher.
2. **Authentication:** a Carter-Wegman MAC using a key-derived authentication subkey `H` and a polynomial hash over the associated data and ciphertext in the field GF(2^127 − 1). The polynomial is evaluated using 96-bit arithmetic (multiplications modulo the prime 2^127 − 1) rather than GF(2^128) binary-field arithmetic.

**CWC vs GCM:** Both are Carter-Wegman AEADs. GCM uses binary-field GHASH (GF(2^128)), which maps cleanly to hardware carry-less multiply (CLMUL/PMULL) instructions. CWC uses prime-field arithmetic, favored in 2004 because the security analysis is simpler (prime-field polynomial hashing has a classical universal-hash proof without the subtleties of binary-field near-collisions), but slower in software without dedicated prime-field hardware. GCM's adoption of CLMUL made it dramatically faster than CWC on modern CPUs, and NIST standardized GCM (SP 800-38D, 2007) rather than CWC.

**Security:** Provably secure (IND-CCA2 + INT-CTXT) under standard block-cipher assumptions. The prime-field MAC has a tight 128-bit authentication bound. Nonce misuse is catastrophic (same as GCM — nonce reuse leaks plaintext XOR and breaks authentication).

**State of the art:** CWC is not deployed in any current standard or widely-used library. It is historically important as one of three patent-free AEAD modes (with EAX and GCM) submitted to NIST consideration in 2004 and directly influenced GCM's design. For deployed alternatives see [Authenticated Encryption (AEAD)](#authenticated-encryption-aead).

**Production readiness:** Deprecated
Historically proposed alongside GCM and EAX; no current deployment or library support. Superseded by AES-GCM.

**Implementations:**
- No actively maintained implementations; original reference code in the FSE 2004 paper appendix.

**Security status:** Superseded
Provably secure (IND-CCA2 + INT-CTXT) but superseded by AES-GCM, which benefits from hardware CLMUL acceleration.

**Community acceptance:** Niche
Historical significance as a patent-free AEAD proposal; never standardized by NIST or IETF. Superseded by GCM (SP 800-38D).

---

## AES Key Wrap (KW / KWP, RFC 5649 / NIST SP 800-38F)

**Goal:** Integrity-protected transport of cryptographic key material using only a block cipher — no separate MAC or IV randomness required. Key wrap produces a deterministic ciphertext from which any single-bit modification is detected with overwhelming probability, making it suitable for storing or transmitting keys in environments that must use only a block cipher primitive.

| Scheme | Year | Standard | Input constraint | Output expansion | Note |
|--------|------|----------|-----------------|-----------------|------|
| **AES-KW** | 2001 | RFC 3394 / NIST SP 800-38F [[1]](https://www.rfc-editor.org/rfc/rfc3394) | Multiple of 8 bytes, ≥ 16 bytes | +8 bytes | Schaad-Housley; 6n AES-ECB calls for n 8-byte blocks |
| **AES-KWP** | 2009 | RFC 5649 / NIST SP 800-38F [[1]](https://www.rfc-editor.org/rfc/rfc5649) | Any length ≥ 1 byte | +8 to +15 bytes | Adds length-encoding padding; supersedes RFC 3394 for variable-length keys |
| **NIST SP 800-38F** | 2012 | NIST [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/f/final) | Both | Both | Authoritative NIST formalization; mandates AES-256 for wrapping keys ≥ 128 bits |
| **JWE AES Key Wrap** | 2015 | RFC 7516 [[1]](https://www.rfc-editor.org/rfc/rfc7516) | Content encryption key | Wrapped CEK | `A128KW`, `A192KW`, `A256KW` algorithm identifiers in JSON Web Encryption |

**AES-KW construction (RFC 3394):** Input is n 64-bit semi-blocks (n ≥ 2). The algorithm runs 6n iterations of an AES-ECB encryption of the concatenation `(A ‖ R_i)` where A is a 64-bit "integrity check register" initialized to `0xA6A6A6A6A6A6A6A6` and R_1..R_{n-1} are the data semi-blocks. Each iteration updates A and one R_i. The output is the final A prepended to R_1..R_{n-1}. No randomness is used — output is deterministic for identical inputs under the same key.

**AES-KWP construction (RFC 5649):** Extends KW by prepending an 8-byte alternative IV `0xA65959A6 ‖ len(plaintext)` to the padded input. For plaintexts of 1–8 bytes, a single AES-ECB call on the 16-byte block suffices, producing 24 bytes of output.

**Security:** KW is proven IND-CPA and INT-CTXT under the PRP assumption for AES. Determinism means it is not IND-CCA2 — an adversary who queries the same key twice gets identical wrapped output, leaking equality. This is acceptable for key material, which is sampled uniformly at random and never reused under the same wrapping key in correct usage.

**Deployments:** PKCS #7 / CMS EnvelopedData key transport; XML Encryption; JWE; KMIP (Key Management Interoperability Protocol); ANSI X9.73; every PKCS#11-compliant HSM (`C_WrapKey` / `C_UnwrapKey` mechanisms). OpenSSL implements KW as `AES_wrap_key` / `AES_unwrap_key`.

**State of the art:** AES-KWP (RFC 5649) is the current standard for symmetric key transport. AES-KW (RFC 3394) is deprecated for inputs not a multiple of 8 bytes — use KWP. For public-key key transport see [Key Encapsulation Mechanism (KEM) / DEM Paradigm](#key-encapsulation-mechanism-kem--dem-paradigm) and [Hybrid Public Key Encryption (HPKE)](#hybrid-public-key-encryption-hpke).

**Production readiness:** Production
Deployed in PKCS#11 HSMs, CMS/PKCS#7, XML Encryption, JWE, and KMIP key management systems worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES_wrap_key / AES_unwrap_key
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, AES Key Wrap (RFC 3394 and RFC 5649)
- [Go stdlib](https://pkg.go.dev/crypto/cipher) — Go, AES Key Wrap support

**Security status:** Secure
Proven IND-CPA and INT-CTXT under PRP assumption for AES; deterministic output is acceptable for uniformly random key material.

**Community acceptance:** Standard
NIST SP 800-38F; IETF RFC 3394 (KW) and RFC 5649 (KWP); mandated in PKCS#11, KMIP, and JWE.

---

## Ciphertext Stealing (CTS)

**Goal:** Encrypt a plaintext of arbitrary byte length using a block cipher in CBC (or ECB) mode without ciphertext expansion — output length exactly equals input length — by rearranging the last two output blocks to absorb the final short plaintext block without adding padding bytes.

| Variant | Last-block handling | Standard | Primary use |
|---------|---------------------|----------|-------------|
| **CBC-CS1** | Swap last two ciphertext blocks unconditionally | — | Rare; last block always shorter than full block |
| **CBC-CS2** | Swap if last block is partial; no swap if full | — | Conditional swap; uncommon |
| **CBC-CS3** | No swap; last full block precedes short final block | NIST SP 800-38A Addendum (2010) [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/a/addendum/final) | NIST preferred variant |
| **Kerberos CBC-CTS** | CS3 variant with Kerberos IV | RFC 3962, RFC 8009 [[1]](https://www.rfc-editor.org/rfc/rfc3962) | AES-CTS-HMAC-SHA1-96 Kerberos encryption type |
| **XTS-AES with CTS** | XEX-based stealing for partial final sector | IEEE Std 1619-2007 [[1]](https://ieeexplore.ieee.org/document/4493450) | Disk encryption of sectors not a multiple of 16 bytes |

**CS3 mechanics:** Given plaintext P of length L = n·B + r where B = block size and 0 < r ≤ B:
1. Encrypt blocks P_1 … P_{n−1} in standard CBC, producing C_1 … C_{n−1}.
2. Encrypt C_{n−1} with the block cipher to obtain intermediate value T.
3. XOR T with P_n (zero-padded to B bytes) to produce C_n (the penultimate output block, full length B).
4. Truncate T to r bytes; this becomes C_{n+1-like} (the final output block, length r).

Decryption reverses the process: the receiver reconstructs the zero-padded P_n from C_n and T, then strips the r-byte fragment. Total output length = n·B − (B − r) = L. No padding bytes are transmitted.

**Constraint:** The plaintext must be at least one full block (B bytes) long for CTS to be applicable. For very short inputs (< B bytes), PKCS#7 padding or a stream cipher must be used instead.

**CTS does not provide authentication.** Like all raw CBC variants, CTS is confidentiality-only. It must always be combined with an external MAC or used inside an authenticated mode. See [Authenticated Encryption (AEAD)](#authenticated-encryption-aead) and [CBC Mode Padding and Padding Oracle Attacks](#cbc-mode-padding-and-padding-oracle-attacks).

**State of the art:** CTS is deployed in Kerberos (RFC 3962, RFC 8009) for AES-encrypted tickets and in XTS-AES for partial-sector disk encryption. For new designs, AEAD modes are strongly preferred. CTS remains useful only when ciphertext expansion is structurally prohibited (e.g., fixed-size Kerberos ticket fields or fixed-sector-size storage media).

**Production readiness:** Production
Deployed in Kerberos (RFC 3962, RFC 8009) and XTS-AES disk encryption on all major operating systems.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-CBC-CTS via EVP API
- [Linux kernel](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) — C, CTS in dm-crypt and fscrypt subsystems
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, CBC-CTS mode

**Security status:** Caution
Confidentiality-only; provides no authentication. Must be combined with a MAC or used inside an authenticated mode.

**Community acceptance:** Standard
NIST SP 800-38A Addendum (CS3); RFC 3962 and RFC 8009 (Kerberos); IEEE 1619 (XTS-AES with CTS).

---

## CBC Mode Padding and Padding Oracle Attacks

**Goal:** Understanding the PKCS#7 padding convention used with CBC mode and the padding oracle attack family that makes any encryption-without-authentication under CBC catastrophically vulnerable to chosen-ciphertext decryption — motivating the universal adoption of AEAD modes for all new designs.

| Scheme / Attack | Year | Reference | Note |
|----------------|------|-----------|------|
| **PKCS#7 Padding** | 1993 | RFC 5652 §6.3 [[1]](https://www.rfc-editor.org/rfc/rfc5652) | Append n bytes of value n to reach a block boundary; n ∈ {1, …, 16} for AES |
| **CBC-MAC (Encrypt-then-MAC)** | 1994 | Bellare-Kilian-Rogaway [[1]](https://link.springer.com/chapter/10.1007/3-540-68697-5_32) | Correct composition: MAC over ciphertext; verify before decryption |
| **Vaudenay Padding Oracle** | 2002 | Eurocrypt 2002 [[1]](https://link.springer.com/chapter/10.1007/3-540-46035-7_35) | Seminal: any padding-distinguishing oracle decrypts any CBC ciphertext, ≤ 256 queries/byte |
| **BEAST (TLS 1.0)** | 2011 | Duong-Rizzo [[1]](https://vnhacker.blogspot.com/2011/09/beast.html) | Predictable IV in TLS 1.0 CBC; chosen-plaintext attack on streaming connections |
| **Lucky Thirteen** | 2013 | AlFardan-Paterson, IEEE S&P 2013 [[1]](https://ieeexplore.ieee.org/document/6547131) | Timing oracle in TLS HMAC-then-decrypt; 13-byte MAC header creates measurable timing signal |
| **POODLE (SSL 3.0)** | 2014 | Möller-Duong-Kotowicz, CVE-2014-3566 [[1]](https://www.openssl.org/~bodo/ssl-poodle.pdf) | Practical padding oracle on SSL 3.0 CBC; triggered protocol downgrade attack |
| **POODLE-TLS** | 2014 | CVE-2014-8730 [[1]](https://drownattack.com/) | Several TLS 1.x implementations incorrectly accepted SSL 3.0-style padding; same oracle |

**PKCS#7 padding rule:** For a B-byte block cipher, the last block of plaintext is padded by appending n bytes of value n, where n = B − (len(plaintext) mod B), with n = B if the plaintext is already a multiple of B. For AES (B = 16): `...03 03 03` for 3 bytes padding, `...10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10` (16 bytes of 0x10) for a full padding block.

**Vaudenay attack:** In AES-CBC decryption, plaintext block P_i = BlockCipherDecrypt(C_i) ⊕ C_{i−1}. An attacker who controls C_{i−1} and has an oracle that reports "valid padding" vs. "invalid padding" can recover P_i one byte at a time. To find the last byte of P_i: iterate C_{i−1}[-1] from 0x00 to 0xFF until the oracle returns "valid 0x01 padding". The correct value of BlockCipherDecrypt(C_i)[-1] is then C_{i−1}[-1] ⊕ 0x01. Extend to full block: adjust found bytes to target padding 0x02, 0x03, etc. Worst case: 256 queries per byte × 16 bytes = 4096 queries per 16-byte block.

**Why Encrypt-then-MAC (EtM) eliminates the attack:** If a MAC over the ciphertext is verified before any decryption attempt, the attacker cannot obtain padding oracle responses — any modified ciphertext fails MAC verification before the block cipher is invoked. TLS 1.3 (RFC 8446) removed all CBC cipher suites. RFC 7366 (Encrypt-then-MAC) provides EtM for TLS 1.2 CBC suites as a mitigation.

**Implementation pitfalls:** Constant-time padding validation is required even with EtM (to avoid timing oracles in the MAC-then-decrypt path). OpenSSL's pre-2013 TLS implementation had non-constant-time padding checks exploited by Lucky Thirteen. The correct fix is to always process the MAC over a fully zero-padded block and use `CRYPTO_memcmp`.

**State of the art:** PKCS#7 + CBC is strictly legacy. TLS 1.3 (deployed everywhere), modern AEAD APIs (AES-GCM, ChaCha20-Poly1305, Ascon-128), and all recommended cryptographic libraries eliminate CBC padding entirely. See [Authenticated Encryption (AEAD)](#authenticated-encryption-aead) and [Ciphertext Stealing (CTS)](#ciphertext-stealing-cts) for alternatives that avoid padding.

**Production readiness:** Deprecated
CBC + PKCS#7 padding is legacy; TLS 1.3 removed all CBC cipher suites. Remains in TLS 1.2 legacy deployments.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-CBC with PKCS#7 padding (legacy support)
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, CBC padding modes

**Security status:** Broken
Padding oracle attacks (Vaudenay, BEAST, Lucky Thirteen, POODLE) make CBC + MAC-then-Encrypt practically vulnerable without extreme care.

**Community acceptance:** Standard
PKCS#7 is RFC 5652; CBC is NIST SP 800-38A. Universally understood but deprecated for new designs in favor of AEAD.

---

## Romulus AEAD (NIST LWC Finalist)

**Goal:** Lightweight authenticated encryption with a clean, modular design for constrained devices (IoT, embedded MCUs) by instantiating a tweakable block cipher (TBC) mode on top of the SKINNY-128 lightweight cipher — providing strong side-channel resistance through a minimal, regular datapath and provable security in the standard model.

| Variant | Year | TBC / Mode | Tag | Key | Nonce | Note |
|---------|------|-----------|-----|-----|-------|------|
| **Romulus-N** | 2019 | SKINNY-128-384+ / LOCUS-AEAD | 128-bit | 128-bit | 128-bit | Nonce-based; primary submission; NIST LWC finalist [[1]](https://romulusae.github.io/romulus/) |
| **Romulus-M** | 2019 | SKINNY-128-384+ / LOTUS-AEAD | 128-bit | 128-bit | 128-bit | Misuse-resistant (nonce-reuse → plaintext equality only) [[1]](https://romulusae.github.io/romulus/) |
| **Romulus-H** | 2019 | SKINNY-128-384+ | 256-bit | — | — | Hash-only variant; companion to N/M [[1]](https://romulusae.github.io/romulus/) |
| **Romulus-T** | 2021 | SKINNY-128-384+ | 128-bit | 128-bit | 128-bit | Leakage-resilient variant; provably secure in the leakage model [[1]](https://romulusae.github.io/romulus/) |

**Designers:** Iwata, Khairallah, Minematsu, Peyrin (NTT / Nanyang Technological University), 2019.

**Underlying cipher — SKINNY-128-384+:** SKINNY is a family of tweakable block ciphers (Beierle et al., 2016) [[1]](https://eprint.iacr.org/2016/660) designed as a lightweight, analyzable alternative to SIMON/SPECK. SKINNY-128-384+ uses a 128-bit block, a 384-bit tweakey (key + tweak combined), and 40 rounds of a simple SPN structure: a 4-bit S-box, ShiftRows, MixColumns over GF(2^4), and a linear tweakey schedule. The minimal S-box and regular structure make it naturally resistant to side-channel leakage and easy to implement in 8-bit hardware.

**LOCUS-AEAD / LOTUS-AEAD modes:** Romulus-N uses LOCUS (Leveled-Optimized Chosen-ciphertext Unified Scheme), a TBC-based AEAD mode that processes associated data and plaintext in a single pass by embedding a 56-bit block counter into the tweak. Authentication is folded into the encryption datapath — no separate MAC pass is required. Romulus-M substitutes LOTUS (a two-pass variant) for misuse resistance.

**Security:**
- Romulus-N: IND-CPA + INT-CTXT under nonce-respecting conditions; nonce reuse leaks plaintext XOR.
- Romulus-M: MRAE — nonce reuse leaks only plaintext equality for repeated (nonce, AD, message) triples; authentication remains intact.
- Romulus-T: Extends Romulus-N with provable leakage resilience in the "leveled implementation" model — suitable for implementations where power/EM side channels are a threat.

**NIST LWC competition:** Romulus was one of ten finalists in the NIST Lightweight Cryptography competition (2019–2023). It was not selected as the winner (Ascon was chosen); however, NIST noted Romulus-M's unique combination of misuse resistance and formal leakage security as a distinguishing strength. See [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard).

**State of the art:** Romulus implementations are available in the NIST LWC test framework and supercop. Romulus-T remains the most formally rigorous leakage-resilient lightweight AEAD as of 2026. For new constrained-device designs without side-channel requirements, Ascon-128 (NIST SP 800-232) is the standardized choice; Romulus-T is the research reference when leakage resilience is required.

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Romulus-T is a research reference for leakage resilience.

**Implementations:**
- [Romulus reference](https://romulusae.github.io/romulus/) — C, official reference implementations of Romulus-N, -M, -T
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Romulus benchmarking implementations

**Security status:** Secure
Provably secure under SKINNY-128-384+ assumptions; Romulus-T provides formal leakage resilience. No known attacks on full construction.

**Community acceptance:** Niche
NIST LWC finalist (2023); well-regarded for leakage resilience but not standardized. Superseded by Ascon for general lightweight AEAD.

---

## Xoodyak (NIST LWC Finalist)

**Goal:** A unified, permutation-based cryptographic primitive for lightweight authenticated encryption and hashing — built on the 384-bit Xoodoo permutation — providing Ascon-comparable security with a simpler, more hardware-efficient permutation and a single API (the "Cyclist" mode) covering AEAD, hashing, PRF, and session key exchange.

| Variant | Year | Permutation | Rate | Tag | Note |
|---------|------|------------|------|-----|------|
| **Xoodyak AEAD** | 2019 | Xoodoo[12] | 192-bit | 128-bit | Cyclist Encrypt mode; NIST LWC finalist [[1]](https://keccak.team/xoodyak.html) |
| **Xoodyak Hash** | 2019 | Xoodoo[12] | 128-bit | — | Cyclist Hash mode; companion to AEAD [[1]](https://keccak.team/xoodyak.html) |
| **Xoofff** | 2018 | Xoodoo | Variable | — | Farfalle-based PRF/MAC/stream cipher using Xoodoo [[1]](https://keccak.team/xoofff.html) |

**Designers:** Joan Daemen, Seth Hoffert, Gilles Van Assche, Ronny Van Keer (STMicroelectronics / Radboud University), 2019.

**Xoodoo permutation:** Xoodoo operates on a 384-bit state arranged as a 3 × 4 × 32-bit array (3 planes of 4 columns of 32-bit lanes). Each of the 12 rounds applies five steps:
1. **θ (Theta):** column parity mixing — each column's XOR propagates to all planes.
2. **ρ_west:** row rotation applied to the west plane (shift by 1 position + bitwise rotation).
3. **ι (Iota):** round constant added to one lane.
4. **χ (Chi):** non-linear: 3-bit S-box applied column-wise across the 3 planes.
5. **ρ_east:** row rotation applied to the east plane (shift by 2 positions + rotation by 8 bits).

The 3-plane structure maps naturally to SIMD registers (3 × 128-bit lanes) on ARM NEON and Intel SSE/AVX, giving efficient vectorized implementations. The 32-bit word size suits 32-bit microcontrollers better than Keccak-f's 64-bit words.

**Cyclist mode:** Unlike most AEAD schemes, Xoodyak exposes a single unified "Cyclist" API with primitive operations `Absorb`, `Squeeze`, `Encrypt`, and `Decrypt`. All use cases — AEAD, hashing, session key derivation — are expressed as sequences of these calls with domain-separation flags embedded in the permutation input. This simplifies implementation verification: one permutation, one mode, multiple use cases.

```
// Xoodyak AEAD encryption
Absorb(Key)          // initialize keyed mode
Absorb(Nonce)
Absorb(AD)           // associated data (any length)
Encrypt(Plaintext)   // produces Ciphertext
Squeeze(128 bits)    // authentication tag
```

**Hardware advantage over Keccak:** Xoodoo's 384-bit state is 4× smaller than Keccak-f[1600]'s 1600-bit state, and its 32-bit lane structure fits on 32-bit MCUs without the 64-bit register overhead Keccak incurs. Gate count for Xoodyak is approximately 2 400–3 000 GE — competitive with Ascon-128.

**NIST LWC context:** Xoodyak was a NIST LWC finalist (2019–2023), ultimately losing to Ascon. It is designed by overlapping authorship with Keccak/SHA-3 (Daemen, Van Assche, Van Keer), lending it strong design heritage and cryptanalytic credibility. See [SpongeWrap / Duplex-Based AEAD](#spongewrap--duplex-based-aead).

**State of the art:** Xoodyak is not standardized. Reference implementations are in the NIST LWC repository and the Keccak team's GitHub. Xoofff (the Farfalle construction over Xoodoo) provides high-throughput modes for non-constrained settings. For standardized use, Ascon-128 is preferred; Xoodyak remains a clean research reference and is well-suited to hardware co-design studies.

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Research reference for unified permutation-based crypto.

**Implementations:**
- [XKCP](https://github.com/XKCP/XKCP) ⭐ 643 — C/assembly, Xoodoo permutation and Xoodyak by the Keccak team
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Xoodyak benchmarking implementations

**Security status:** Secure
No known attacks on full 12-round Xoodoo; strong design heritage from Keccak/SHA-3 team. Well-analyzed during NIST LWC competition.

**Community acceptance:** Niche
NIST LWC finalist (2023); designed by Keccak/SHA-3 authors. Not standardized; superseded by Ascon for NIST-compliant deployments.

---

## ISAP (NIST LWC Finalist, Side-Channel Resistant)

**Goal:** Authenticated encryption with *inherent* side-channel protection — without masking or shuffling countermeasures — by structuring the algorithm so that the key-dependent and decryption-critical computations involve only a tiny, fixed number of permutation calls that are easy to protect in hardware, while bulk encryption uses a keystream that tolerates leakage.

| Variant | Year | Permutation | Key | Tag | SCA strategy | Note |
|---------|------|------------|-----|-----|-------------|------|
| **ISAP-A-128** | 2019 | Ascon-p | 128-bit | 128-bit | Ascon permutation; 1-bit rekeying | NIST LWC finalist; primary variant [[1]](https://isap.iaik.tugraz.at/) |
| **ISAP-A-128A** | 2019 | Ascon-p | 128-bit | 128-bit | Faster; fewer rounds in rekeying | Secondary variant [[1]](https://isap.iaik.tugraz.at/) |
| **ISAP-K-128** | 2019 | Keccak-p[400] | 128-bit | 128-bit | Keccak-based; smaller state (400-bit) | Keccak permutation variant [[1]](https://isap.iaik.tugraz.at/) |

**Designers:** Christoph Dobraunig, Maria Eichlseder, Stefan Mangard, Florian Mendel, Bart Mennink, Robert Primas, Thomas Unterluggauer (Graz University of Technology / Radboud University / Infineon), 2019.

**Key insight — leakage separation:** Standard AEAD schemes (including Ascon) require the decryption key to be present during both decryption and tag verification — any power or EM leakage during these operations directly threatens key recovery. ISAP separates the computation into three layers:

1. **Rekey (key-dependent, few calls):** A session encryption key `Ke` and MAC key `Km` are derived from the master key `K` and nonce by iterating the permutation one bit of the nonce at a time in a mode called `isap_rk`. This makes key-dependent computation consist of exactly 256 (or 128) permutation calls with *1 bit of nonce* input each — a quantity small enough to protect with simple threshold implementations or one share per call.

2. **Encrypt (leakage-tolerant, bulk):** Bulk keystream for encrypting plaintext is generated from `Ke`. Even if `Ke` leaks completely during encryption, the master key `K` is not exposed.

3. **Authenticate (key-dependent, protected):** The MAC tag is computed using `Km` via the same rekeying structure. Leakage during MAC computation is bounded by the same single-bit argument.

```
isap_rk(K, Y):
    S ← permute_high_rounds(K || Y[0..127])    // 128 calls, 1 bit of Y each
    return S[0..127]                             // session key

Ke = isap_rk(K, Nonce)
Km = isap_rk(K, Tag_candidate)
```

**Side-channel protection model:** ISAP achieves *leveled leakage resilience* — masking the full key is not required. Only the `isap_rk` function (a small, fixed computation) needs protection; the bulk encryption requires only leakage-tolerant (not leakage-free) implementation. This is practical for hardware where protecting a long bulk cipher is expensive.

**Cost:** The rekeying process imposes significant overhead versus Ascon alone: for a 128-byte message, ISAP-A-128 requires approximately 10× more permutation calls than Ascon-128. This makes ISAP unsuitable for throughput-sensitive applications but appropriate for environments where side-channel protection is mandatory (smart cards, secure elements, automotive HSMs).

**NIST LWC context:** ISAP was a NIST LWC finalist. NIST ultimately selected Ascon, which does not have ISAP's built-in side-channel resistance, recommending that implementers apply standard masking countermeasures. ISAP remains the reference design for leakage-resilient lightweight AEAD without masking.

**State of the art:** ISAP is not standardized. Reference implementations (including masked hardware implementations) are published by the designers. For applications requiring side-channel resistance in constrained hardware — e.g., payment terminals, TPM-adjacent logic — ISAP-A-128 is the most rigorous published design as of 2026.

**Production readiness:** Experimental
NIST LWC finalist with reference and masked hardware implementations; not selected as the standard. Research reference for side-channel-resistant AEAD.

**Implementations:**
- [ISAP reference](https://isap.iaik.tugraz.at/) — C, official reference implementations of ISAP-A-128 and ISAP-K-128
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, ISAP benchmarking implementations

**Security status:** Secure
Provably secure with formal leakage resilience; designed to tolerate side-channel leakage without masking. No known attacks on full construction.

**Community acceptance:** Niche
NIST LWC finalist (2023); reference design for inherent side-channel resistance. Not standardized; Ascon selected with recommendation to apply masking.

---

## Photon-Beetle (NIST LWC Finalist)

**Goal:** Ultra-low area authenticated encryption for hardware-constrained devices — targeting sub-1000 gate equivalent implementations — by combining the PHOTON sponge hash permutation with the Beetle duplex-based AEAD mode, achieving one of the smallest silicon footprints among NIST LWC finalists.

| Variant | Year | Permutation | Rate | Tag | Area | Note |
|---------|------|------------|------|-----|------|------|
| **Photon-Beetle-AEAD[32]** | 2019 | PHOTON-256 | 32-bit | 128-bit | ~865 GE | Ultra-compact; primary hardware variant [[1]](https://photon-beetle.github.io/) |
| **Photon-Beetle-AEAD[128]** | 2019 | PHOTON-256 | 128-bit | 128-bit | ~1 750 GE | Higher throughput; software-preferred variant [[1]](https://photon-beetle.github.io/) |
| **Photon-Beetle-Hash[32]** | 2019 | PHOTON-256 | 32-bit | 256-bit | ~865 GE | Companion hash function [[1]](https://photon-beetle.github.io/) |

**Designers:** Zhenzhen Bao, Avik Chakraborti, Nilanjan Datta, Jian Guo, Mridul Nandi, Thomas Peyrin, Kan Yasuda (Nanyang Technological University / ISI Kolkata / NTT), 2019.

**PHOTON permutation:** PHOTON (Guo-Peyrin-Poschmann, 2011) [[1]](https://eprint.iacr.org/2011/609) is a sponge-based lightweight hash family. PHOTON-256 uses a 256-bit state arranged as an 8 × 8 matrix of 4-bit nibbles, with 12 AES-inspired rounds: AddConstants, SubCells (4-bit S-box), ShiftRows, and MixColumnsSerial. MixColumnsSerial uses a serial matrix multiplication over GF(2^4) — implementable as a shift register in hardware, eliminating the need for a parallel multiplier array and dramatically reducing gate count. The 256-bit state absorbs a 32-bit rate, protecting a 224-bit capacity for 112-bit security.

**Beetle mode:** The Beetle duplex mode (Chakraborti et al., 2018) [[1]](https://tosc.iacr.org/index.php/ToSC/article/view/836) is an optimized duplex AEAD construction that absorbs associated data and plaintext through the permutation with a hash-then-permute structure:

```
// Beetle absorb phase (simplified)
For each r-bit block M_i of (AD ‖ Plaintext):
    S ← Permutation(S ⊕ (M_i || 0...))    // absorb
    C_i ← S[0..r] ⊕ M_i                    // squeeze keystream
Tag ← S[0..128]                              // final tag
```

The key insight of Beetle is a *ratchet* at the AD/message boundary: the state is XOR'd with a domain-separation constant when transitioning from AD to message blocks, providing security against multi-key and related-key attacks without additional permutation calls.

**Why sub-1000 GE matters:** Many IoT sensor nodes, passive RFID tags, and medical implant devices operate below 2 000 GE total logic budget — leaving fewer than 1 000 GE for cryptography after control logic and memory. Photon-Beetle-AEAD[32] at ~865 GE fits within this budget, making authenticated encryption feasible on devices where Ascon-128 (~2 006 GE) or AES-CCM (~3 500 GE) would not fit.

**Throughput tradeoff:** The 32-bit rate means 8 permutation calls per 32 bytes of plaintext — significantly slower than Ascon-128a (128-bit rate, 1 call per 16 bytes). The [128] variant closes this gap at the cost of a larger area footprint. For applications where latency matters more than area, Ascon-128 is preferred.

**NIST LWC context:** Photon-Beetle was a NIST LWC finalist (2019–2023). NIST noted its extremely compact hardware footprint as its primary distinguishing feature. It was not selected (Ascon won), but its hardware area record is referenced in NIST's post-competition analysis. See [SpongeWrap / Duplex-Based AEAD](#spongewrap--duplex-based-aead) and [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard).

**State of the art:** Photon-Beetle is not standardized. It is the reference design for sub-1000 GE authenticated encryption as of 2026. For standard compliance, Ascon-128 is mandated by NIST SP 800-232; Photon-Beetle remains relevant for ultra-constrained custom silicon designs.

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Reference for sub-1000 GE AEAD in custom silicon.

**Implementations:**
- [Photon-Beetle reference](https://photon-beetle.github.io/) — C, official reference implementations
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Photon-Beetle benchmarking implementations

**Security status:** Secure
Based on well-analyzed PHOTON permutation (2011); no known attacks on full construction. Extensively analyzed during NIST LWC competition.

**Community acceptance:** Niche
NIST LWC finalist (2023); recognized for smallest hardware footprint. Not standardized; superseded by Ascon for NIST-compliant deployments.

---

## Combined AEAD Constructions: Encrypt-then-MAC, MAC-then-Encrypt, Encrypt-and-MAC

**Goal:** Understand the three classical ways to compose a symmetric cipher and a MAC into an authenticated encryption scheme, their relative security properties, and why only one (Encrypt-then-MAC) is provably secure — motivating the replacement of all ad-hoc combinations with purpose-built AEAD modes.

| Composition | Abbreviation | Construction | Confidentiality | Integrity | CCA secure | Deployed in |
|-------------|-------------|-------------|-----------------|-----------|------------|-------------|
| **Encrypt-then-MAC** | EtM | `C = Enc(K_e, M); T = MAC(K_m, C)` | IND-CPA | INT-CTXT | Yes | TLS 1.2 (RFC 7366), IPsec ESP, SSH |
| **MAC-then-Encrypt** | MtE | `T = MAC(K_m, M); C = Enc(K_e, M ‖ T)` | IND-CPA | Conditional | No (in general) | SSL 3.0 / TLS 1.0–1.2 (pre-RFC 7366), early S/MIME |
| **Encrypt-and-MAC** | E&M | `C = Enc(K_e, M); T = MAC(K_m, M)` | IND-CPA | Conditional | No | SSH (binary packet protocol, pre-EtM) |

**Formal security analysis (Bellare-Namprempre, 2000)** [[1]](https://eprint.iacr.org/2000/025):
- **EtM is the only composition that achieves IND-CCA2 + INT-CTXT** generically, given a CPA-secure cipher and an SUF-CMA-secure MAC with independent keys. Proof: any modification to the ciphertext fails MAC verification before decryption is attempted, eliminating all chosen-ciphertext attack surfaces.
- **MtE does not generically achieve IND-CCA2.** A ciphertext-modifying attacker can cause decryption to proceed on modified plaintext, and a padding oracle over the resulting decryption error leaks the MAC tag or plaintext bytes. This is the root cause of BEAST, Lucky Thirteen, and POODLE (see [CBC Mode Padding and Padding Oracle Attacks](#cbc-mode-padding-and-padding-oracle-attacks)).
- **E&M does not generically achieve IND-CCA2 or even confidentiality of the MAC.** Because `T = MAC(K_m, M)` is computed over the plaintext, the tag can leak information about M. In SSH, the MAC tag was historically transmitted in plaintext alongside the ciphertext — a partial plaintext leak.

**Why MtE survived in TLS 1.0–1.2:** The TLS record protocol was designed before the Bellare-Namprempre analysis (2000) and the Vaudenay padding oracle (2002). MtE was inherited from SSL and difficult to change without a major version increment. RFC 7366 (2014) added EtM as an optional TLS 1.2 extension; TLS 1.3 eliminated all CBC + MtE cipher suites entirely, mandating AEAD modes exclusively.

**Key independence requirement:** Even EtM requires *independent* encryption and MAC keys. Deriving `K_e = PRF(K, 0)` and `K_m = PRF(K, 1)` from a single master key `K` is acceptable and standard (done in TLS PRF). Using the *same* key for both cipher and MAC risks key-reuse attacks and violates the security proof assumptions.

**Modern replacement:** Purpose-built AEAD modes (AES-GCM, ChaCha20-Poly1305, AES-OCB3, Ascon-128) eliminate the composition question entirely — authentication is fused with encryption in a single, jointly analyzed primitive. They are universally preferred over any EtM / MtE / E&M construction. See [Authenticated Encryption (AEAD)](#authenticated-encryption-aead) and [Key-Committing AEAD](#key-committing-aead).

**State of the art:** EtM is the correct composition if a legacy MAC + cipher must be combined, but all new protocols should use an integrated AEAD primitive. TLS 1.3 (deployed universally), SSH with EtM cipher suites (RFC 6668), and IPsec ESP (RFC 4303) with AES-GCM represent the current state. MtE and E&M are considered deprecated.

**Production readiness:** Deprecated
EtM is deployed in TLS 1.2 (RFC 7366), SSH, and IPsec but superseded by integrated AEAD modes. MtE and E&M are deprecated.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, EtM cipher suites for TLS 1.2
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, EtM MAC modes (RFC 6668)

**Security status:** Caution
Only EtM is provably IND-CCA2 + INT-CTXT; MtE and E&M are generically insecure. All compositions are superseded by integrated AEAD.

**Community acceptance:** Standard
EtM is well-established (RFC 7366, IPsec ESP); MtE/E&M are understood as insecure. All are superseded by AEAD for new designs.

---

## STREAM: Online Authenticated Encryption with Segmented Ciphertexts

**Goal:** Authenticated encryption of arbitrarily long byte streams that must begin output before the complete message is known, while maintaining strong per-segment security guarantees. The STREAM construction by Hoang, Reyhanitabar, Rogaway, and Vizár (2015) formalizes how to compose a standard AEAD into a secure online/streaming scheme using ciphertext segmentation, header commitment, and last-block signaling.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **STREAM[AEAD]** | 2015 | Any AEAD | Generic online AE from any nonce-based AEAD; segments carry sequence numbers and a "last" flag [[1]](https://eprint.iacr.org/2015/189) |
| **STREAM[AES-GCM]** | 2015 | AES-GCM | Concrete instantiation with sequential per-segment nonces; streaming TLS-like record protocol [[1]](https://eprint.iacr.org/2015/189) |
| **OAE2 (Hoang et al.)** | 2015 | Block cipher | Security model for online AE; STREAM achieves OAE2 when base AEAD is nonce-based secure [[1]](https://eprint.iacr.org/2015/189) |

**Construction:** A long message M is split into fixed-size segments M₁, M₂, …, Mₙ. Each segment Mᵢ is encrypted with the underlying AEAD using a derived nonce `N_i = (nonce_base || i)` and associated data that encodes the segment index and a boolean "last-segment" flag. The "last" flag on segment Mₙ prevents truncation attacks — an adversary cannot drop trailing segments and present a shorter ciphertext as valid. The per-segment nonces prevent cross-segment swapping or reordering attacks.

**Security properties:**
- **Online:** Decryption of segment i can begin as soon as segment i is received, without buffering the entire ciphertext.
- **No truncation:** Dropping the final segment causes decryption to fail at the missing "last" marker.
- **No reordering:** Per-segment nonces and indices prevent splicing or reordering of segments across distinct sessions.
- **Compositional:** Inherits confidentiality and integrity of the underlying AEAD.

**Practical relevance:** STREAM formalizes the record-layer design pattern used in TLS (where each TLS record is independently AEAD-encrypted with an incrementing sequence number). The formal treatment distinguishes STREAM from earlier ad-hoc segmented-encryption approaches and was influential in the design of the QUIC and MLS record layers.

**State of the art:** The STREAM framework (2015) [[1]](https://eprint.iacr.org/2015/189) is the academic reference for online AEAD composition. Its pattern is deployed in TLS 1.3, QUIC (RFC 9001), and MLS (RFC 9420) record-layer constructions. See also [MRAE and Online Authenticated Encryption (OAE)](#mrae-and-online-authenticated-encryption-oae).

**Production readiness:** Production
The STREAM segmentation pattern is deployed in TLS 1.3, QUIC, and MLS record layers, though not as a standalone named primitive.

**Implementations:**
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++, streaming AEAD API implementing STREAM-like segmentation
- TLS 1.3, QUIC, and MLS implementations embed STREAM-style record-layer segmentation internally.

**Security status:** Secure
Provably secure (OAE2) when instantiated with a nonce-based AEAD; formal proofs by Hoang et al. (2015).

**Community acceptance:** Widely trusted
The STREAM pattern underlies TLS 1.3, QUIC, and MLS record layers; well-studied academic framework adopted implicitly in major protocols.

---

## Forkcipher (ForkAES, ForkSkinny)

**Goal:** A tweakable block cipher that produces two independent output blocks from one input block and one key in approximately 1.5× the cost of a single encryption — enabling parallelism-friendly authenticated encryption and hash construction where two separate outputs (e.g., ciphertext block and authentication block) are needed per message block without doubling cipher calls.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ForkAES** | 2018 | AES-128 | First forkcipher; splits AES at round 4 → two 128-bit outputs from one 128-bit input [[1]](https://eprint.iacr.org/2018/1088) |
| **ForkSkinny** | 2019 | SKINNY-128-256 | Lightweight forkcipher; tweakable; used in Forkskinny-based AEAD (NIST LWC candidate) [[1]](https://eprint.iacr.org/2019/427) |
| **ForkFish** | 2019 | Twofish structure | Alternative forkcipher construction for software-oriented platforms [[1]](https://eprint.iacr.org/2019/427) |

**Construction:** A forkcipher `FC_K(p, t) → (c₀, c₁)` applies a shared prefix of cipher rounds to the plaintext `p` (with tweak `t`), then forks into two independent suffixes producing outputs `c₀` and `c₁`. In ForkAES, the first 4 rounds of AES are shared; rounds 5–10 produce `c₀` and a parallel path produces `c₁`. The cost savings come from amortizing the shared prefix: two outputs for ~1.3–1.5× the cost of one AES encryption rather than 2×.

**Use in AEAD:** Forkciphers enable single-pass AEAD constructions that simultaneously produce a ciphertext block and an authentication contribution without a separate MAC pass. The ForkSkinny-based AEAD family (Peyrin, Song, 2019) was submitted to the NIST Lightweight Cryptography competition and achieves competitive performance on hardware with strong side-channel resistance properties from the SKINNY structure.

**Security model:** Forkciphers are analyzed as tweakable block ciphers with two outputs; the standard security notion requires that `c₀` and `c₁` are pseudorandom and independent given the key, with the tweak providing domain separation. Attacks on reduced-round ForkAES (differential/linear) have been published but do not threaten the full-round construction [[1]](https://eprint.iacr.org/2019/1099).

**State of the art:** Forkciphers remain a research primitive; no forkcipher-based AEAD has been standardized as of 2026. ForkSkinny-based submissions were NIST LWC candidates but did not reach the finalist round. The forkcipher concept continues to influence lightweight AEAD design by showing that dedicated two-output primitives can outperform generic AEAD composition in hardware throughput.

**Production readiness:** Research
Academic primitive; NIST LWC candidate (did not reach finalist round). No production deployment or standardization.

**Implementations:**
- [ForkAE reference](https://www.esat.kuleuven.be/cosic/forkae/) — C, reference implementations of ForkAES and ForkSkinny-based AEAD
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, ForkAE benchmarking implementations

**Security status:** Secure
Provably secure as a tweakable block cipher with two outputs; no attacks on full-round ForkAES or ForkSkinny constructions.

**Community acceptance:** Niche
Research primitive; NIST LWC candidate. Influential concept but no standardization or significant adoption beyond academia.

---

## Deterministic AEAD with Any Nonce (DAEAD / ANYDAE)

**Goal:** A deterministic authenticated encryption scheme that accepts a nonce of any length (including zero-length) and guarantees misuse-resistance: security degrades only to plaintext equality leakage when the same (key, nonce, associated-data, plaintext) tuple is reused, regardless of how the nonce is chosen. Removes the requirement for unique nonces entirely in exchange for deterministic (non-randomized) ciphertext.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ANYDAE (Peyrin-Seurin)** | 2016 | Tweakable block cipher | Nonce of any length including 0; deterministic; SIV-like security [[1]](https://eprint.iacr.org/2016/174) |
| **AES-SIV (RFC 5297)** | 2006 | AES + CMAC | Fixed-length nonce (optional); foundational DAEAD; misuse-resistant [[1]](https://www.rfc-editor.org/rfc/rfc5297) |
| **HS1-SIV / HS1-Hash** | 2015 | Poly1305 + ChaCha | Software-fast SIV variant; faster than AES-SIV on non-AES-NI platforms [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |
| **Deoxys-II** | 2019 | SKINNY-style TBC | CAESAR defense-in-depth winner; provides authenticated encryption with or without nonce [[1]](https://sites.google.com/view/deoxyscipher) |

**Security model (ANYDAE):** Peyrin and Seurin formalize the notion of a Deterministic Authenticated Encryption scheme with Any nonce. The key insight is that nonce uniqueness is *not required*: the scheme's security is parameterized by the maximum number of messages encrypted with the same (key, nonce) pair. When this count is 1, full semantic security holds; for repeated (key, nonce, AD, plaintext) tuples, only ciphertext equality is leaked. This is strictly stronger than standard DAEAD, which requires a unique nonce input.

**Comparison to SIV:** AES-SIV achieves the same leakage profile but assumes the nonce is provided (possibly empty); ANYDAE generalizes this to variable-length nonces and provides a unified theoretical treatment. Both are two-pass (offline) — the full message must be processed before any ciphertext output, precluding streaming use.

**Applications:** Backup encryption (where nonce management is impractical), encrypted key-value stores, deterministic database encryption, and any context where the sender cannot guarantee nonce freshness but must limit ciphertext expansion.

**State of the art:** AES-SIV (RFC 5297) is the deployed DAEAD standard. Deoxys-II (CAESAR defense-in-depth winner, 2019) [[1]](https://sites.google.com/view/deoxyscipher) provides a tweakable-block-cipher-based alternative with strong security margins. ANYDAE remains a theoretical framework; no ANYDAE-specific IETF standard exists as of 2026. See [MRAE and Online Authenticated Encryption (OAE)](#mrae-and-online-authenticated-encryption-oae).

**Production readiness:** Mature
AES-SIV (RFC 5297) is deployed in production; Deoxys-II is a CAESAR winner with implementations. ANYDAE is a theoretical framework.

**Implementations:**
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++, AES-SIV (deterministic AEAD)
- [miscreant](https://github.com/miscreant/miscreant.rb) ⭐ 22 [archived] — Ruby/JS/Rust, AES-SIV
- [Deoxys reference](https://sites.google.com/view/deoxyscipher) — C, Deoxys-II reference implementation

**Security status:** Secure
AES-SIV and Deoxys-II are provably MRAE-secure; nonce reuse leaks only plaintext equality, not authenticity.

**Community acceptance:** Standard
AES-SIV is IETF RFC 5297; Deoxys-II is a CAESAR defense-in-depth winner. ANYDAE is an academic framework without separate standardization.

---

## Encode-then-Encipher and Feistel-Based Wide-Block Ciphers (EME, XCB, HCH, TET)

**Goal:** Encrypt a block of data (a disk sector, a database record, a network packet) of arbitrary length as a single unit — so that any change to even one bit of plaintext randomizes the entire ciphertext — using only a block cipher and no authentication tag, providing length-preserving, all-or-nothing encryption. Used where ciphertext expansion is structurally prohibited and authentication is handled at a higher layer.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **EME (Halevi-Rogaway)** | 2004 | AES + ECB | Tweakable wide-block cipher; 2n AES calls for an n-block input; EME* fixes a security flaw in EME [[1]](https://eprint.iacr.org/2004/125) |
| **XCB (McGrew-Fluhrer)** | 2004 | AES + universal hash (GF(2¹²⁸)) | XEX-based construction; near-linear cost [[1]](https://eprint.iacr.org/2004/278) |
| **HCH (Sarkar)** | 2007 | AES + Carter-Wegman hash | Hash-Counter-Hash; provably secure; software-fast [[1]](https://eprint.iacr.org/2007/013) |
| **TET (Halevi)** | 2007 | AES + universal hash | Tweakable EME variant; hash-XEX-hash structure; efficient for variable-length sectors [[1]](https://eprint.iacr.org/2007/014) |
| **HEH (Sarkar)** | 2009 | Universal hash + block cipher | Hash-Encrypt-Hash; simpler than TET; full security proof [[1]](https://eprint.iacr.org/2009/314) |

**Encode-then-Encipher (Bellare-Rogaway, 2000):** The general paradigm for building length-preserving encryption: encode the plaintext (e.g., append a redundancy string), then encipher the encoded value with a wide-block cipher. The decryptor deciphers and checks the redundancy — if absent, decryption fails. This converts a (weaker) pseudorandom permutation into an authenticated encryption scheme without ciphertext expansion [[1]](https://eprint.iacr.org/2000/049).

**Wide-block cipher vs. AEAD:** Wide-block ciphers are *not* authenticated encryption — they provide no authentication tag. They are pseudorandom permutations over a large domain (a sector, a record). Their security guarantee is that they behave like a random permutation on the entire input block, meaning single-bit plaintext changes affect the entire ciphertext. Combined with encode-then-encipher (redundancy checking), they can provide implicit authentication.

**Relation to disk encryption:** XTS-AES (the NIST standard for disk encryption, see [Disk Encryption / Tweakable Block Ciphers](#disk-encryption--tweakable-block-ciphers)) is *not* a wide-block cipher — it processes each 16-byte AES block independently within a sector. EME/XCB/HCH/TET treat the entire sector as a single block, providing stronger diffusion across sector boundaries. The tradeoff is complexity and cost.

**State of the art:** No wide-block cipher has been standardized by NIST or IETF; all remain research proposals. AES-HCTR2 (deployed in Android for file-based encryption) is the closest to a practical wide-block-inspired mode in production, though it is based on a hash-counter structure rather than a full Feistel or EME construction. See [Disk Encryption / Tweakable Block Ciphers](#disk-encryption--tweakable-block-ciphers).

**Production readiness:** Research
No wide-block cipher has been standardized; EME/XCB/HCH/TET remain academic proposals. AES-HCTR2 (deployed in Android) is the closest practical descendant.

**Implementations:**
- [AES-HCTR2 (Android)](https://android.googlesource.com/kernel/common/) — C, wide-block-inspired mode deployed in Android kernel
- No standalone open-source implementations of EME, XCB, HCH, or TET in production libraries.

**Security status:** Secure
EME, XCB, HCH, TET are provably secure as pseudorandom permutations under standard block-cipher assumptions. No practical attacks.

**Community acceptance:** Niche
Academic research; no NIST or IETF standardization. AES-HCTR2 (Google) is the closest to deployed use in the wide-block paradigm.

---

## Robust KEM + DEM (REACT, OAEP+)

**Goal:** Public-key encryption that is provably secure against adaptive chosen-ciphertext attacks (IND-CCA2) in the standard model or with tight reductions, beyond what naive KEM/DEM composition achieves. REACT and OAEP+ are transforms that convert IND-CPA public-key encryption into full IND-CCA2 encryption using minimal additional structure, with formal security proofs tighter than OAEP.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OAEP+ (Shoup)** | 2001 | RSA + hash | Strengthened OAEP; tight IND-CCA2 proof from RSA in ROM; fixes OAEP gap [[1]](https://shoup.net/papers/oaep.pdf) |
| **REACT (Okamoto-Pointcheval)** | 2001 | Any IND-CPA PKE + MAC | Generic transform; IND-CCA2 from IND-CPA with a one-time MAC; tight reduction in ROM [[1]](https://eprint.iacr.org/2000/013) |
| **OAEP (Bellare-Rogaway)** | 1994 | RSA + hash | Original optimal asymmetric encryption padding; ROM proof with a gap later identified [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_14) |
| **SAEP+ (Boneh)** | 2001 | RSA + single hash | Simplified OAEP+; one hash call; tight IND-CCA2 from RSA in ROM [[1]](https://crypto.stanford.edu/~dabo/papers/saep.pdf) |
| **Fujisaki-Okamoto (FO) transform** | 1999 | Any IND-CPA + hash | Generic ROM transform; canonical path to KEM IND-CCA2; used in PQ KEMs (Kyber, NTRU) [[1]](https://eprint.iacr.org/1999/033) |

**Why "robust KEM+DEM":** The Shoup KEM/DEM paradigm (see [Key Encapsulation Mechanism (KEM) / DEM Paradigm](#key-encapsulation-mechanism-kem--dem-paradigm)) achieves IND-CCA2 if the KEM is IND-CCA2. REACT provides a clean path from any IND-CPA PKE to an IND-CCA2 hybrid encryption scheme using a message authentication code: the session key is authenticated along with the ciphertext so that any ciphertext modification fails MAC verification before decryption. The security reduction is tight — no quadratic loss — unlike OAEP's original proof.

**OAEP vs. OAEP+:** Bellare and Rogaway's original OAEP proof had a gap identified by Shoup (2001): the reduction was not tight for partial-domain one-wayness of RSA. OAEP+ repairs this with an additional hash application, achieving a tight reduction from the RSA assumption. In practice, RSA-OAEP (PKCS#1 v2.1, RFC 8017) remains the deployed standard; OAEP+ is the theoretically preferred variant.

**Fujisaki-Okamoto:** The FO transform is the canonical generic method and underpins all NIST PQC KEM standards (ML-KEM/Kyber, HQC, BIKE) — it converts a CPA-secure lattice KEM into a CCA2-secure one by hashing both the random coins and the message together and re-encrypting to verify. REACT and OAEP+ address the same problem for classical (RSA/ElGamal) PKE.

**State of the art:** RSA-OAEP (RFC 8017) is the deployed standard for RSA-based hybrid encryption. ML-KEM (FIPS 203) applies a variant of the FO transform to Kyber. REACT remains a research reference for clean IND-CCA2 construction proofs. For new systems, HPKE (RFC 9180) provides a standardized, modular public-key encryption framework on top of modern KEMs. See [Hybrid Public Key Encryption (HPKE)](#hybrid-public-key-encryption-hpke).

**Production readiness:** Production
RSA-OAEP (RFC 8017) is deployed everywhere; the FO transform underpins ML-KEM (FIPS 203). REACT and OAEP+ are theoretical references.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RSA-OAEP (PKCS#1 v2.1)
- [Bouncy Castle](https://www.bouncycastle.org/) — Java/C#, RSA-OAEP and OAEP+
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM (FO transform applied to Kyber)

**Security status:** Secure
RSA-OAEP is provably IND-CCA2 in ROM; OAEP+ has a tight reduction. FO transform is provably CCA2-secure from CPA-secure KEMs.

**Community acceptance:** Standard
RSA-OAEP is PKCS#1 v2.1 (RFC 8017); FO transform is implicit in NIST FIPS 203 (ML-KEM). REACT/OAEP+ are well-studied academic constructions.

---

## Leakage-Resilient AEAD (LRAE)

**Goal:** Authenticated encryption that remains secure even when an adversary observes bounded amounts of physical side-channel information (power traces, EM emissions, timing) from the encryption and decryption operations — without requiring masking or hardware countermeasures at every step. Formalizes which algorithmic designs tolerate implementation leakage and which do not.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LRAE (Fischlin-Günther)** | 2014 | PRF + leakage-resilient PRG | First formal LRAE construction with standard model security; separates key refresh from bulk encryption [[1]](https://eprint.iacr.org/2014/953) |
| **Leveled LRAE (Dziembowski-Faust)** | 2012 | Leakage-resilient stream cipher | "Leveled" model: low-leakage key operations + high-leakage bulk data; formal bounds [[1]](https://eprint.iacr.org/2012/160) |
| **Romulus-T** | 2021 | SKINNY-128 TBC | Practical leakage-resilient lightweight AEAD; NIST LWC finalist; leveled implementation model [[1]](https://romulusae.github.io/romulus/) |
| **TEDT (Berti et al.)** | 2019 | Tweakable block cipher | Leakage-resilient AEAD with unbounded leakage on bulk encryption; bounded leakage only on tag generation [[1]](https://eprint.iacr.org/2019/137) |
| **TEDT2** | 2022 | TBC | Improved TEDT; tighter bounds; NIST LWC influence [[1]](https://eprint.iacr.org/2022/272) |

**Leakage model:** Standard AEAD security proofs assume a black-box adversary who sees only inputs and outputs. LRAE relaxes this: the adversary additionally receives `leak(state)` — a bounded-length function of the internal state during each operation. Two primary models are used:
- **Bounded leakage:** total bits leaked across all operations is bounded by a parameter `λ`.
- **Leveled leakage:** bulk operations (stream generation) may leak arbitrarily; only key derivation/tag operations require leakage resistance (achievable with a small hardware-protected module).

**Fischlin-Günther LRAE construction:** The scheme separates long-term key storage from per-message key derivation. A leakage-resilient PRG refreshes the session key after each message. Encryption uses a standard symmetric cipher on the session key. The critical invariant is that the long-term key is involved in at most one operation per message, limiting leakage exposure. Security is proven under the assumption that the adversary obtains at most `λ` bits of leakage per cryptographic operation.

**Relation to ISAP:** The ISAP AEAD (see [ISAP (NIST LWC Finalist, Side-Channel Resistant)](#isap-nist-lwc-finalist-side-channel-resistant)) achieves a similar separation in the lightweight hardware context using the rekeying construction. ISAP is the practical engineering realization of principles from the LRAE / leveled leakage literature.

**State of the art:** LRAE is an active research area; no dedicated LRAE scheme has been standardized. TEDT/TEDT2 and Romulus-T are the most concrete recent constructions. For deployed leakage-resistant AEAD in constrained hardware, ISAP-A-128 remains the reference. In high-security environments (HSMs, smartcards), masking is still the primary countermeasure, but LRAE theory informs which algorithm structures are inherently more leakage-tolerant. See [Romulus AEAD (NIST LWC Finalist)](#romulus-aead-nist-lwc-finalist).

**Production readiness:** Research
Academic constructions; no standardization or production deployment. ISAP and Romulus-T are the closest to practical leakage-resilient AEAD.

**Implementations:**
- [ISAP reference](https://isap.iaik.tugraz.at/) — C, practical leakage-resilient AEAD (related primitive)
- [Romulus-T reference](https://romulusae.github.io/romulus/) — C, leakage-resilient lightweight AEAD
- No standalone LRAE library; constructions appear in academic prototype code.

**Security status:** Secure
Formal proofs under bounded or leveled leakage models; TEDT/TEDT2 and Romulus-T have well-studied security reductions.

**Community acceptance:** Niche
Active academic research area; influences side-channel-resistant design but no NIST or IETF standardization of LRAE as a category.

---

## GCM-SST (Galois/Counter Mode with Secure Short Tags)

**Goal:** Authenticated encryption with short authentication tags (e.g., 32-bit or 64-bit) that achieves security guarantees equivalent to full-length GCM tags — unlike standard GCM where truncating the tag degrades forgery resistance proportionally. Designed for constrained-bandwidth protocols (sensor networks, industrial control, automotive CAN bus) where a 128-bit GCM tag is too expensive to transmit.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GCM-SST** | 2022 | AES-GCM + extra mask block | Adds one AES call to generate a per-message mask applied to the truncated tag; IEEE P1619.1 input [[1]](https://eprint.iacr.org/2022/1441) |
| **AES-GCM (truncated tag)** | 2007 | GCM | NIST SP 800-38D permits tags as short as 32 bits; forgery probability = 2^(−tag_len); **insecure for short tags** [[1]](https://csrc.nist.gov/publications/detail/sp/800/38/d/final) |
| **SIV with short tag** | 2006 | AES-SIV | Truncation of a 256-bit SIV output gives a short-tag MRAE; misuse-resistant [[1]](https://www.rfc-editor.org/rfc/rfc5297) |

**The short-tag problem in GCM:** In standard AES-GCM, the authentication tag is a polynomial hash (GHASH) over the ciphertext, evaluated at an AES-encrypted nonce point `H = AES_K(0^128)`. If the tag is truncated to `t` bits, the forgery probability per query is `2^(−t)` — a 32-bit tag gives a 1-in-4-billion forgery chance per message. For protocols that accept millions of messages per day, this is exploitable within hours. Moreover, because GHASH is a polynomial over GF(2¹²⁸), multiple queries can allow an attacker to recover `H` and forge tags at will.

**GCM-SST construction:** GCM-SST (Peyrin, Sasaki, Wang, 2022) adds one extra AES block encryption to generate a per-message random-looking mask `T_mask = AES_K(nonce || counter)`, which is XOR'd into the final GHASH output before truncation. The mask binds the tag to the specific (key, nonce, message) triple, preventing GHASH key recovery from multiple tag observations and achieving short-tag security comparable to an ideal MAC with the same tag length.

**Deployment context:** IEEE P1619.1 (the standard for authenticated encryption of storage media) includes GCM-SST as an option for block storage devices with bandwidth constraints. Industrial protocols (IEC 62351 for power systems, ISO 21434 for automotive) have considered short-tag AE for CAN bus and low-power sensor networks where 16-byte tags are a significant overhead on 8–64 byte payloads.

**State of the art:** GCM-SST is specified in IEEE P1619.1 (draft, 2022–2024) [[1]](https://eprint.iacr.org/2022/1441). It is the recommended approach when short authentication tags are operationally required. For applications where full 128-bit tags are feasible, standard AES-GCM or AES-GCM-SIV remains preferable. NIST has not issued a separate standard for GCM-SST as of 2026.

**Production readiness:** Experimental
IEEE P1619.1 draft (2022-2024); no finalized standard or widespread production deployment as of 2026.

**Implementations:**
- No widely available standalone open-source implementations; reference code in the ePrint paper (2022/1441).

**Security status:** Secure
Provably secure short-tag AEAD; per-message mask prevents GHASH key recovery from truncated tags. Nonce misuse remains catastrophic.

**Community acceptance:** Emerging
IEEE P1619.1 draft inclusion; recommended for constrained-bandwidth protocols. No NIST standard; limited adoption outside storage and IoT research.

---

## Robust Authenticated Encryption (RAE / Beyond INT-CTXT)

**Goal:** Authenticated encryption that remains secure even when the adversary can observe whether decryption attempts succeed or fail — closing the gap between INT-CTXT (ciphertext unforgeability) and robustness (no information leakage from invalid ciphertexts). Robust AE prevents chosen-ciphertext attacks that exploit decryption error oracles, partial-decryption leakage, and tag-verification side channels beyond what standard INT-CTXT guarantees.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Robust AE (Abdalla-Bellare-Neven)** | 2010 | Generic AEAD + commitment | Formalization of robustness beyond INT-CTXT; committed AEAD achieves RAE [[1]](https://eprint.iacr.org/2010/295) |
| **Key-Committing AEAD** | 2022 | HtE / AEAD-CMT-4 | Strongest notion: robust against multi-key and multi-ciphertext attacks; see [Key-Committing AEAD](#key-committing-aead) [[1]](https://eprint.iacr.org/2022/1260) |
| **Nonce-Hiding AEAD** | 2019 | Any AEAD | Hides the nonce from the ciphertext; prevents nonce-based timing attacks; used in TLS 1.3 record nonce masking [[1]](https://eprint.iacr.org/2019/624) |
| **sAEAD (Structured AEAD)** | 2021 | AEAD + structure | Robustness against adversaries who observe structure (tag length, timing) of invalid ciphertexts [[1]](https://eprint.iacr.org/2021/1441) |

**What INT-CTXT does not cover:** Standard INT-CTXT security says the adversary cannot produce a *valid* ciphertext. But it does not prevent:
- **Multi-key attacks:** A single ciphertext that decrypts validly under two different keys (invisible salamander; see [Key-Committing AEAD](#key-committing-aead)).
- **Partial decryption leakage:** Systems that begin processing a plaintext before finishing tag verification (TLS 1.0 record layer).
- **Tag-length oracles:** Adversaries who learn the valid tag length by timing decryption failures.
- **Decryption error distinguishing:** Adversaries who observe different error codes for "bad tag" vs. "bad ciphertext structure".

**Robust AE definition (Abdalla et al.):** A RAE scheme is one where even an adversary who can submit arbitrary ciphertexts to a decryption oracle and observe the *output* (including failed decryption output) cannot distinguish the scheme from an ideal cipher. This strictly implies INT-CTXT and is equivalent to requiring that invalid ciphertexts produce *identical* decryption failure behavior — no oracle information is available.

**Practical impact:** Most real-world decryption APIs violate robustness by returning different error codes or partial output for different failure modes. Robust AE is achieved in practice by: (1) using constant-time tag verification, (2) using key-committing AEAD to prevent multi-key attacks, (3) never releasing partial plaintext before full tag verification, and (4) masking TLS 1.3 record layer sequence numbers (nonce-hiding).

**State of the art:** Robust AE is a design principle rather than a single standardized scheme. Key-committing AEAD (AEAD-CMT-4, 2022) addresses the multi-key dimension. TLS 1.3 (RFC 8446) addresses partial decryption leakage by mandating that no plaintext is released until the tag is verified. The nonce-masking in TLS 1.3 record layer addresses nonce-hiding. See [Key-Committing AEAD](#key-committing-aead) and [MRAE and Online Authenticated Encryption (OAE)](#mrae-and-online-authenticated-encryption-oae).

**Production readiness:** Experimental
Robustness principles are adopted in TLS 1.3 and key-committing AEAD; no standalone "Robust AE" scheme is deployed as a named primitive.

**Implementations:**
- Robust AE principles are embedded in TLS 1.3 implementations (constant-time verification, no partial plaintext release).

**Security status:** Secure
Formal robustness definitions are well-established; achieving robustness requires constant-time verification, key commitment, and nonce hiding.

**Community acceptance:** Emerging
Robustness is a design principle adopted in TLS 1.3 and discussed at NIST Block Cipher Modes Workshop (2023); no standalone standard.

---

## COLM (COPA + ELmD Merge)

**Goal:** Nonce-misuse-resistant authenticated encryption built from two parallelizable AES encryption layers connected by a linear mixing function, providing both confidentiality and authenticity even when nonces are repeated — selected as a CAESAR competition defense-in-depth co-winner alongside Deoxys-II.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **COLM0** | 2016 | AES-128 dual-layer | Primary variant for general-purpose AEAD; single-pass parallelizable; CAESAR defense-in-depth winner [[1]](https://link.springer.com/article/10.1007/s00145-024-09492-8) |
| **COLMt** | 2016 | AES-128 dual-layer + intermediate tags | Variant with periodic intermediate tag verification for constrained devices and streaming applications [[1]](https://link.springer.com/article/10.1007/s00145-024-09492-8) |

**State of the art:** COLM was selected as one of the two defense-in-depth winners of the CAESAR competition (2019) alongside Deoxys-II. Its nonce-misuse resistance makes it suitable for environments where nonce uniqueness cannot be guaranteed. For new deployments, AES-GCM-SIV (RFC 8452) or Deoxys-II are more commonly adopted, but COLM remains a strong academic reference for dual-layer AEAD design. See [Deterministic AEAD with Any Nonce (DAEAD / ANYDAE)](#deterministic-aead-with-any-nonce-daead--anydae).

**Production readiness:** Experimental
CAESAR defense-in-depth winner with reference implementations; no standardization or significant production deployment.

**Implementations:**
- [COLM reference](https://competitions.cr.yp.to/caesar-submissions.html) — C, reference implementation from CAESAR submission
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, COLM benchmarking implementations

**Security status:** Secure
Provably nonce-misuse resistant; nonce reuse leaks only plaintext equality. Well-analyzed during CAESAR competition.

**Community acceptance:** Niche
CAESAR defense-in-depth co-winner (2019); well-regarded but no NIST or IETF standardization. AES-GCM-SIV is more widely adopted.

---

## MORUS (CAESAR High-Speed Finalist)

**Goal:** Extremely high-speed authenticated encryption optimized for modern 64-bit and SIMD-capable processors, achieving sub-cycle-per-byte throughput — a CAESAR competition finalist in the high-performance use case alongside AEGIS and OCB.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **MORUS-640-128** | 2014 | State-update AEAD, 128-bit key | 640-bit state; ~0.7 cpb on Haswell; CAESAR third-round finalist [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |
| **MORUS-1280-128** | 2014 | State-update AEAD, 128-bit key | 1280-bit state; higher throughput on AVX2 [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |
| **MORUS-1280-256** | 2014 | State-update AEAD, 256-bit key | 256-bit security variant; same 1280-bit state [[1]](https://competitions.cr.yp.to/caesar-submissions.html) |

**State of the art:** MORUS was not selected for the final CAESAR portfolio due to the discovery of a linear correlation in the full keystream by Kales et al. (Asiacrypt 2018), which enables distinguishing attacks and partial plaintext recovery in broadcast settings [[1]](https://eprint.iacr.org/2018/464). Despite this, the attack requires extremely large data volumes and MORUS remains of academic interest for its state-update design paradigm. AEGIS-128L (which was selected) offers similar throughput with stronger security margins. See [AEGIS (A Fast Authenticated Encryption Algorithm)](#aegis-a-fast-authenticated-encryption-algorithm).

**Production readiness:** Deprecated
CAESAR finalist but not selected due to keystream linear correlation attack; superseded by AEGIS-128L for high-speed AEAD.

**Implementations:**
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, MORUS benchmarking implementations
- [MORUS reference](https://competitions.cr.yp.to/caesar-submissions.html) — C, reference implementation from CAESAR submission

**Security status:** Broken
Linear correlation attack (Kales et al., Asiacrypt 2018) enables distinguishing and partial plaintext recovery in broadcast settings.

**Community acceptance:** Niche
CAESAR third-round finalist; not selected due to cryptanalytic weakness. Academic interest only; superseded by AEGIS.

---

## NORX (Parallel Sponge-Based AEAD)

**Goal:** Parallel and scalable authenticated encryption based on a sponge-like construction using only bitwise operations (no modular additions), enabling efficient constant-time implementations resistant to timing side channels — a CAESAR competition third-round candidate.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **NORX v3.0** | 2014 | Parallel monkeyDuplex sponge | Configurable parallelism degree D; 2.51 cpb serial on Haswell; CAESAR Round 3 [[1]](https://link.springer.com/chapter/10.1007/978-3-319-11212-1_2) |
| **NORX-8 / NORX-16** | 2015 | 8/16-bit word NORX | Lightweight variants targeting 8-bit and 16-bit microcontrollers [[1]](https://eprint.iacr.org/2015/1154) |

**State of the art:** NORX was eliminated after CAESAR Round 3 following a state-recovery attack on NORX v2.0 by Chaigneau and Gilbert (Journal of Cryptology, 2019) [[1]](https://link.springer.com/article/10.1007/s00145-018-9297-9). The v3.0 specification addressed this attack, but the design was not selected for the final portfolio. NORX's parallel sponge approach influenced later permutation-based AEAD designs. See [SpongeWrap / Duplex-Based AEAD](#spongewrap--duplex-based-aead).

**Production readiness:** Deprecated
CAESAR Round 3 candidate; eliminated after state-recovery attack on v2.0. Not selected for final portfolio; no production use.

**Implementations:**
- [NORX reference](https://norx.io/) — C, reference implementation of NORX v3.0
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, NORX benchmarking implementations

**Security status:** Broken
State-recovery attack on NORX v2.0 (Chaigneau-Gilbert, 2019); v3.0 addressed this but was not selected. Should not be used.

**Community acceptance:** Niche
CAESAR Round 3 candidate; eliminated due to cryptanalysis. Historical interest for parallel sponge design; no standardization.

---

## Elephant (NIST LWC Finalist)

**Goal:** Lightweight parallelizable authenticated encryption using an encrypt-then-MAC construction with small permutations and LFSR-based masking, targeting constrained hardware with minimal overhead beyond the underlying permutation circuit — a NIST Lightweight Cryptography competition finalist.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Dumbo** | 2019 | Spongent-pi[160] + LFSR mask | 160-bit permutation; smallest variant; ~2 900 GE in ASIC [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/elephant-spec-final.pdf) |
| **Jumbo** | 2019 | Spongent-pi[176] + LFSR mask | 176-bit permutation; slightly larger state for better throughput [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/elephant-spec-final.pdf) |
| **Delirium** | 2019 | Keccak-f[200] + LFSR mask | 200-bit Keccak permutation; fastest Elephant variant in software [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/elephant-spec-final.pdf) |

**State of the art:** Elephant was one of ten NIST LWC finalists (2021) but was not selected as the winner — Ascon was chosen instead (2023). Elephant's key distinguishing feature is its parallelizable mode of operation (the only finalist offering this), making it attractive for high-throughput hardware implementations. Dumbo and Jumbo use the well-analyzed Spongent permutation family, while Delirium leverages the Keccak permutation. See [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard).

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Research reference for parallelizable lightweight AEAD.

**Implementations:**
- [Elephant reference](https://csrc.nist.gov/projects/lightweight-cryptography) — C, NIST LWC submission reference code
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Elephant benchmarking implementations

**Security status:** Secure
No known attacks on full Dumbo/Jumbo/Delirium constructions; based on well-analyzed Spongent and Keccak permutations.

**Community acceptance:** Niche
NIST LWC finalist (2023); recognized for parallelizable mode. Not standardized; superseded by Ascon for NIST-compliant deployments.

---

## TinyJAMBU (NIST LWC Finalist)

**Goal:** Ultra-compact authenticated encryption built on a lightweight 128-bit keyed permutation using a simple feedback shift register structure, achieving one of the smallest RAM and flash memory footprints among all NIST LWC candidates — designed for the most constrained IoT devices.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **TinyJAMBU-128** | 2019 | 128-bit keyed permutation, 128-bit key | 96-bit nonce, 64-bit tag; extremely small footprint; NIST LWC finalist [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/tinyjambu-spec-final.pdf) |
| **TinyJAMBU-192** | 2019 | 128-bit keyed permutation, 192-bit key | Same structure with 192-bit key for higher security margin [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/tinyjambu-spec-final.pdf) |
| **TinyJAMBU-256** | 2019 | 128-bit keyed permutation, 256-bit key | 256-bit key variant; highest security margin [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/finalist-round/updated-spec-doc/tinyjambu-spec-final.pdf) |

**State of the art:** TinyJAMBU was a NIST LWC finalist but was not selected as the winner. Its keyed-permutation approach (as opposed to unkeyed permutation + sponge) gives it an unusually small state, but the 64-bit tag limits forgery resistance compared to Ascon's 128-bit tag. Post-competition analysis revealed beyond-full-round integral distinguishers [[1]](https://eprint.iacr.org/2023/960), though these do not directly break the full cipher. See [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard).

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Ultra-compact design for most constrained IoT devices.

**Implementations:**
- [TinyJAMBU reference](https://csrc.nist.gov/projects/lightweight-cryptography) — C, NIST LWC submission reference code
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, TinyJAMBU benchmarking implementations

**Security status:** Caution
64-bit tag limits forgery resistance; post-competition integral distinguishers on beyond-full-round variants. Full cipher not broken.

**Community acceptance:** Niche
NIST LWC finalist (2023); smallest state among finalists. Not standardized; superseded by Ascon for NIST-compliant deployments.

---

## Schwaemm / SPARKLE (NIST LWC Finalist)

**Goal:** Lightweight authenticated encryption using ARX-based (Addition-Rotation-XOR) permutations in a Beetle sponge mode, achieving very high throughput on microcontrollers without requiring hardware AES or bit-slicing — a NIST Lightweight Cryptography competition finalist.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Schwaemm256-128** | 2019 | Sparkle384 permutation + Beetle mode | Primary AEAD; 128-bit key/tag; 5x faster than AES-GCM on ARM Cortex-M [[1]](https://sparkle-lwc.github.io/) |
| **Schwaemm192-192** | 2019 | Sparkle384 permutation + Beetle mode | 192-bit key and tag variant [[1]](https://sparkle-lwc.github.io/) |
| **Schwaemm128-128** | 2019 | Sparkle256 permutation + Beetle mode | Smallest variant; 128-bit key/tag; minimal state [[1]](https://sparkle-lwc.github.io/) |
| **Schwaemm256-256** | 2019 | Sparkle512 permutation + Beetle mode | Highest security; 256-bit key and tag [[1]](https://sparkle-lwc.github.io/) |

**State of the art:** Schwaemm was a NIST LWC finalist (2021) but lost to Ascon. On ARM Cortex-M3/M4 microcontrollers, Schwaemm256-128 is roughly 5x faster than AES-GCM and 2x faster than Ascon, making it the fastest software AEAD among the finalists on these platforms. The underlying Sparkle permutation family uses only ARX operations, enabling efficient constant-time software implementations without needing lookup tables or hardware accelerators. See [Ascon-128 / Ascon-128a (NIST LWC Standard)](#ascon-128--ascon-128a-nist-lwc-standard).

**Production readiness:** Experimental
NIST LWC finalist with reference implementations; not selected as the standard. Fastest software AEAD on ARM Cortex-M among finalists.

**Implementations:**
- [Sparkle reference](https://sparkle-lwc.github.io/) — C, official reference implementations of Schwaemm and Esch
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Schwaemm benchmarking implementations

**Security status:** Secure
No known attacks on full Sparkle permutation; ARX design enables constant-time implementations. Well-analyzed during NIST LWC competition.

**Community acceptance:** Niche
NIST LWC finalist (2023); fastest software lightweight AEAD on ARM Cortex-M. Not standardized; superseded by Ascon for NIST compliance.

---

## Pyjamask (Masking-Optimized AEAD)

**Goal:** Authenticated encryption specifically designed for efficient high-order side-channel masking in software, minimizing the number of nonlinear (AND) gates to reduce the cost of masked implementations — targeting secure embedded systems where side-channel resistance is a primary requirement.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Pyjamask-128-AEAD** | 2019 | Pyjamask-128 block cipher + OCB mode | 128-bit block; bitslice design; lowest AND-depth among NIST LWC candidates [[1]](https://tosc.iacr.org/index.php/ToSC/article/view/8617) |
| **Pyjamask-96-AEAD** | 2019 | Pyjamask-96 block cipher + OCB mode | 96-bit block; even fewer AND gates; hardware-oriented [[1]](https://tosc.iacr.org/index.php/ToSC/article/view/8617) |

**State of the art:** Pyjamask was a NIST LWC Round 2 candidate (not advanced to the finalist round). Its primary contribution is demonstrating that a block cipher can be designed from the ground up for efficient masking — achieving high-order masked implementations at a fraction of the cost of masking AES or GIFT. The bitslice construction evaluates all nonlinear gates in parallel, enabling efficient masking up to order 128 in software. Pyjamask's design principles have influenced subsequent masking-friendly cipher research. See [Leakage-Resilient AEAD (LRAE)](#leakage-resilient-aead-lrae).

**Production readiness:** Research
NIST LWC Round 2 candidate (not advanced to finalist round); academic demonstration of masking-optimized cipher design.

**Implementations:**
- [Pyjamask reference](https://csrc.nist.gov/projects/lightweight-cryptography) — C, NIST LWC submission reference code
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Pyjamask benchmarking implementations

**Security status:** Secure
No known attacks on full Pyjamask; bitslice design with lowest AND-depth enables efficient high-order masking.

**Community acceptance:** Niche
NIST LWC Round 2 candidate; influential for masking-friendly cipher design principles. Not advanced to finalist round.

---

## Spook (Leakage-Resilient Sponge-Based AEAD)

**Goal:** Authenticated encryption with state-of-the-art leakage resilience — maintaining security even when side-channel measurements (power traces, electromagnetic emanations) leak information about intermediate computations — by combining a dedicated key-derivation step with bitslice tweakable block ciphers and a duplex sponge mode.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Spook** | 2019 | Clyde-128 TBC + Shadow-512 permutation | Leakage-resilient duplex mode; nonce-misuse resilient; NIST LWC Round 2 [[1]](https://www.spook.dev/) |
| **Clyde-128** | 2019 | 128-bit tweakable block cipher (LS-design) | Internal TBC; bitslice structure for efficient masking [[1]](https://www.spook.dev/) |
| **Shadow-512 / Shadow-384** | 2019 | 512/384-bit permutation (LS-design) | Internal permutation for the sponge duplex layer [[1]](https://www.spook.dev/) |

**State of the art:** Spook was a NIST LWC Round 2 candidate (not advanced to the finalist round). Its distinguishing contribution is the formalization of leakage resilience in the duplex sponge setting: a fresh key derivation at the start of each message ensures that side-channel leakage from one message cannot be used to attack another. Spook also provides nonce-misuse resilience and beyond-birthday-bound security relative to the TBC block size. See [Leakage-Resilient AEAD (LRAE)](#leakage-resilient-aead-lrae) and [ISAP (NIST LWC Finalist, Side-Channel Resistant)](#isap-nist-lwc-finalist-side-channel-resistant).

**Production readiness:** Research
NIST LWC Round 2 candidate (not advanced to finalist round); academic demonstration of leakage-resilient sponge-based AEAD.

**Implementations:**
- [Spook reference](https://www.spook.dev/) — C, official reference implementation of Spook, Clyde-128, and Shadow
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, Spook benchmarking implementations

**Security status:** Secure
Provably leakage-resilient and nonce-misuse resistant; fresh key derivation per message limits side-channel exposure.

**Community acceptance:** Niche
NIST LWC Round 2 candidate; well-regarded for leakage resilience formalization. Not advanced to finalist round; ISAP is the closer-to-practice alternative.

---

## ESTATE (Energy-Efficient Short-Tweak TBC-Based AEAD)

**Goal:** Lightweight authenticated encryption optimized for short messages and minimal hardware area, using a tweakable block cipher with a very short (4-bit) tweak in a MAC-then-Encrypt paradigm — providing nonce-misuse resistance with minimal circuit overhead beyond the underlying block cipher.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **ESTATE[TweGIFT]** | 2019 | TweGIFT-128 (4-bit tweak) + MAC-then-Encrypt | Ultra-lightweight; 128-bit key/nonce/tag; nonce-misuse resistant; NIST LWC Round 2 [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/estate-spec-round2.pdf) |
| **ESTATE[TweAES]** | 2019 | TweAES-128 (4-bit tweak) + MAC-then-Encrypt | AES-based variant for platforms with AES hardware [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/estate-spec-round2.pdf) |
| **sESTATE[TweAES-6]** | 2019 | Reduced-round TweAES-6 + MAC-then-Encrypt | Aggressive performance variant with 6-round AES [[1]](https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/estate-spec-round2.pdf) |

**State of the art:** ESTATE was a NIST LWC Round 2 candidate (not advanced to the finalist round). Its primary innovation is demonstrating that a 4-bit tweak is sufficient to build a provably secure AEAD mode — enabling extremely compact TBC instantiations. ESTATE improves upon the earlier SUNDAE design by reducing the number of block cipher calls by one and eliminating the need for a multiplication circuit, reducing both hardware area and energy consumption. The TweGIFT instantiation achieves nonce-misuse resistance at a circuit size competitive with the smallest AEAD implementations. See [CAESAR Lightweight Winners (ACORN, GIFT-COFB)](#caesar-lightweight-winners-acorn-gift-cofb).

**Production readiness:** Research
NIST LWC Round 2 candidate (not advanced to finalist round); academic demonstration of short-tweak TBC-based AEAD.

**Implementations:**
- [ESTATE reference](https://csrc.nist.gov/projects/lightweight-cryptography) — C, NIST LWC submission reference code
- [SUPERCOP](https://bench.cr.yp.to/supercop.html) — C, ESTATE benchmarking implementations

**Security status:** Secure
Provably secure nonce-misuse resistant AEAD; 4-bit tweak suffices for security. No known attacks on full TweGIFT or TweAES instantiations.

**Community acceptance:** Niche
NIST LWC Round 2 candidate; innovative short-tweak design. Not advanced to finalist round; limited adoption beyond academia.

---

## Partitioning Oracle Attacks and Committing AEAD Landscape

**Goal:** Defend against partitioning oracle attacks — a class of chosen-ciphertext attacks that exploit the fact that standard AEAD schemes (AES-GCM, ChaCha20-Poly1305, XSalsa20-Poly1305) allow efficient multi-key collisions, enabling an adversary to craft a single ciphertext that decrypts validly under many different keys and use a decryption oracle to efficiently identify which key is correct.

| Scheme | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Partitioning Oracle Attack** | 2021 | Attack on non-committing AEAD | Efficient key-recovery via multi-key ciphertext collisions against AES-GCM, ChaCha20-Poly1305 [[1]](https://eprint.iacr.org/2020/1491) |
| **CTX (Committing AEAD via context)** | 2022 | Generic transform | Efficient committing AEAD from any AEAD + collision-resistant hash; Bellare-Hoang Eurocrypt 2022 [[1]](https://link.springer.com/chapter/10.1007/978-3-031-07085-3_29) |
| **CCX / HFC** | 2022 | Generic transform | Succinctly-committing: commitment fits in the existing tag (no ciphertext expansion) [[1]](https://csrc.nist.gov/csrc/media/Events/2023/third-workshop-on-block-cipher-modes-of-operation/documents/accepted-papers/The%20Landscape%20of%20Committing%20Authenticated%20Encryption.pdf) |
| **Flexible PBE** | 2023 | Password-based encryption | Provably resists partitioning oracle attacks in cloud storage setting [[1]](https://www.researchgate.net/publication/370120732_Flexible_Password-Based_Encryption_Securing_Cloud_Storage_and_Provably_Resisting_Partitioning-Oracle_Attacks) |

**State of the art:** Partitioning oracle attacks (Len, Grubbs, Ristenpart; USENIX Security 2021) demonstrated that non-committing AEAD is a practical vulnerability, not just a theoretical concern — particularly in password-based encryption and anonymous messaging. The Bellare-Hoang line of work (Eurocrypt 2022, Crypto 2024) provides efficient generic transforms (CTX, CCX) that add key commitment to any AEAD with minimal overhead. The NIST Block Cipher Modes Workshop (2023) discussed standardizing committing AEAD modes. See [Key-Committing AEAD](#key-committing-aead) and [Robust Authenticated Encryption (RAE / Beyond INT-CTXT)](#robust-authenticated-encryption-rae--beyond-int-ctxt).

**Production readiness:** Experimental
CTX and CCX transforms are implementable over any AEAD; adoption in Signal and cloud backup systems is underway. No standalone NIST standard yet.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, key-committing AEAD adopted in Signal protocol (related)

**Security status:** Secure
CTX and CCX transforms are provably secure with minimal overhead; partitioning oracle attacks are fully mitigated by key-committing AEAD.

**Community acceptance:** Emerging
NIST Block Cipher Modes Workshop (2023) discussed standardization; adopted by Signal and cloud backup systems. Active standardization trajectory.

---
