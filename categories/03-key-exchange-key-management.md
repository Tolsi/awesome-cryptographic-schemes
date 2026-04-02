# Key Exchange & Key Management


<!-- TOC -->
## Contents (52 schemes)

**[Diffie-Hellman and ECDH](#diffie-hellman-and-ecdh)**
- [Non-Interactive Key Exchange (NIKE)](#non-interactive-key-exchange-nike)
- [SIGMA Protocol (SIGn-and-MAc)](#sigma-protocol-sign-and-mac)
- [Triple Diffie-Hellman (3DH) / X3DH](#triple-diffie-hellman-3dh--x3dh)
- [Noise Protocol Framework](#noise-protocol-framework)
- [J-PAKE (Password-Authenticated Key Exchange by Juggling)](#j-pake-password-authenticated-key-exchange-by-juggling)
- [SPEKE (Simple Password Exponential Key Exchange)](#speke-simple-password-exponential-key-exchange)
- [TLS 1.3 Key Schedule](#tls-13-key-schedule)
- [FFDHE — Named Finite-Field DH Groups (RFC 7919)](#ffdhe--named-finite-field-dh-groups-rfc-7919)
- [Station-to-Station (STS) Protocol](#station-to-station-sts-protocol)
- [Post-Quantum Key Exchange in Practice (Hybrid KEM)](#post-quantum-key-exchange-in-practice-hybrid-kem)
- [One-Pass Diffie-Hellman (NIST SP 800-56A)](#one-pass-diffie-hellman-nist-sp-800-56a)
- [MTI Protocols (Matsumoto-Takashima-Imai)](#mti-protocols-matsumoto-takashima-imai)
- [Encrypted Key Exchange (EKE) — Bellovin-Merritt](#encrypted-key-exchange-eke--bellovin-merritt)
- [Group Key Agreement (Burmester-Desmedt)](#group-key-agreement-burmester-desmedt)
- [KEM Combiner Constructions](#kem-combiner-constructions)
- [Double Ratchet and KDF Chain Key Management](#double-ratchet-and-kdf-chain-key-management)
- [ML-KEM (CRYSTALS-Kyber) Internals](#ml-kem-crystals-kyber-internals)
- [ZRTP (Media Path Key Agreement for Secure RTP)](#zrtp-media-path-key-agreement-for-secure-rtp)
- [EDHOC (Ephemeral Diffie-Hellman Over COSE, RFC 9528)](#edhoc-ephemeral-diffie-hellman-over-cose-rfc-9528)
- [SIDH / SIKE (Broken Isogeny-Based Key Exchange)](#sidh--sike-broken-isogeny-based-key-exchange)

**[Password-Based Key Exchange (PAKE)](#password-based-key-exchange-pake)**
- [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake)
- [Password Hardened Encryption (PHE)](#password-hardened-encryption-phe)
- [Dragonfly Handshake / SAE (Simultaneous Authentication of Equals)](#dragonfly-handshake--sae-simultaneous-authentication-of-equals)
- [SCEP (Simple Certificate Enrollment Protocol, RFC 8894)](#scep-simple-certificate-enrollment-protocol-rfc-8894)
- [PKCS#12 / PFX (Private Key + Certificate Bundle)](#pkcs12--pfx-private-key--certificate-bundle)
- [PBKDF2 / Password-Based Cryptography (PKCS#5 / RFC 8018)](#pbkdf2--password-based-cryptography-pkcs5--rfc-8018)
- [KDF Comparison: PBKDF2 vs bcrypt vs scrypt vs Argon2id](#kdf-comparison-pbkdf2-vs-bcrypt-vs-scrypt-vs-argon2id)

**[Key Derivation and Wrapping](#key-derivation-and-wrapping)**
- [Hierarchical Deterministic Keys (BIP32 / HD Wallets)](#hierarchical-deterministic-keys-bip32--hd-wallets)
- [Key Wrapping / Envelope Encryption](#key-wrapping--envelope-encryption)
- [HPKE (Hybrid Public Key Encryption, RFC 9180)](#hpke-hybrid-public-key-encryption-rfc-9180)

**[Key Management Infrastructure](#key-management-infrastructure)**
- [Certificateless Cryptography](#certificateless-cryptography)
- [Key Transparency / CONIKS](#key-transparency--coniks)
- [Updatable CRS / Powers of Tau](#updatable-crs--powers-of-tau)
- [ECMQV (Elliptic Curve Menezes-Qu-Vanstone)](#ecmqv-elliptic-curve-menezes-qu-vanstone)
- [WireGuard Cryptographic Protocol](#wireguard-cryptographic-protocol)
- [Auditable Key Directory (AKD) / Key Transparency v2](#auditable-key-directory-akd--key-transparency-v2)
- [FrodoKEM (Conservative Lattice-Based KEM)](#frodokem-conservative-lattice-based-kem)
- [Delegated Credentials (RFC 9345)](#delegated-credentials-rfc-9345)

**[HD Keys and Wallet Key Management](#hd-keys-and-wallet-key-management)**
- [SLIP-39 / Shamir Backup for Hardware Wallets](#slip-39--shamir-backup-for-hardware-wallets)

**[Web Standards (JOSE / JWT / COSE)](#web-standards-jose--jwt--cose)**
- [JOSE / JWS / JWE / JWT](#jose--jws--jwe--jwt)
- [OAuth 2.0 / OpenID Connect Cryptographic Components](#oauth-20--openid-connect-cryptographic-components)
- [Key Exchange / Key Agreement](#key-exchange--key-agreement)
- [OCSP / Certificate Revocation](#ocsp--certificate-revocation)
- [PKIX / X.509 v3 Certificate Profile (RFC 5280)](#pkix--x509-v3-certificate-profile-rfc-5280)
- [IKEv1 vs IKEv2 (Internet Key Exchange)](#ikev1-vs-ikev2-internet-key-exchange)
- [EST (Enrollment over Secure Transport, RFC 7030)](#est-enrollment-over-secure-transport-rfc-7030)
- [CMP (Certificate Management Protocol, RFC 4210/9483)](#cmp-certificate-management-protocol-rfc-42109483)
- [ISO/IEC 11770 Key Establishment Mechanisms](#isoiec-11770-key-establishment-mechanisms)
- [HQC (Hamming Quasi-Cyclic KEM)](#hqc-hamming-quasi-cyclic-kem)
- [Age Encryption Format](#age-encryption-format)
- [SFrame (Secure Frame for Real-Time Media, RFC 9605)](#sframe-secure-frame-for-real-time-media-rfc-9605)
- [Oblivious HTTP (OHTTP, RFC 9458)](#oblivious-http-ohttp-rfc-9458)

<!-- /TOC -->

## Diffie-Hellman and ECDH

---
### Non-Interactive Key Exchange (NIKE)

**Goal:** Implicit key agreement. Two parties compute a shared secret from each other's public keys alone — no message exchange at all. Stronger than DH which requires ephemeral exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Static Diffie-Hellman** | 1976 | DLP | g^(ab) from static keys; simplest NIKE but no forward secrecy [[1]](https://ieeexplore.ieee.org/document/1055638) |
| **Freire-Hofheinz-Kiltz-Paterson NIKE** | 2013 | DDH + trapdoor | First NIKE with CKS-heavy security from standard assumptions [[1]](https://eprint.iacr.org/2012/732) |
| **CSIDH** | 2018 | Isogenies | Post-quantum NIKE from supersingular isogeny group actions [[1]](https://eprint.iacr.org/2018/383) |

**State of the art:** CSIDH for PQ-NIKE (but slow); static-DH widely used in practice (see [Key Exchange](#key-exchange--key-agreement)). True NIKE is rare — most protocols prefer ephemeral key exchange for forward secrecy.

**Production readiness:** Research
Static DH is production, but true NIKE protocols (FHKP, CSIDH) remain academic; CSIDH performance is impractical for most use cases.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, static ECDH
- [libcsidh](https://github.com/JJChiDguez/csidh) ⭐ 21 — C, reference CSIDH implementation
- [sibc](https://github.com/JJChiDguez/sibc) ⭐ 52 — Python, CSIDH and isogeny-based crypto

**Security status:** Caution
Static DH is secure but lacks forward secrecy; CSIDH security is still actively studied with ongoing cryptanalytic improvements.

**Community acceptance:** Niche
Static DH is standard; CSIDH and formal NIKE constructions are of primarily academic interest with no IETF or NIST standardization.

---

### SIGMA Protocol (SIGn-and-MAc)

**Goal:** Provide a provably secure framework for authenticated Diffie-Hellman key exchange that simultaneously achieves identity protection, mutual authentication, and forward secrecy — and serves as the cryptographic core of IKEv1/v2 and TLS 1.3.

The SIGMA family, introduced by Hugo Krawczyk at CRYPTO 2003, fixes a subtle flaw in the earlier Station-to-Station (STS) protocol. STS signs the DH transcript but does not MAC-protect the peer identity, leaving an identity misbinding attack open. SIGMA resolves this by requiring each party to both sign the DH exchange and MAC their own identity under the derived session key — hence "SIGn-and-MAc."

**Core SIGMA-I handshake (identity-protecting variant):**

```
Alice → Bob:  g^x
Bob → Alice:  g^y, CERT_B, SIG_B(g^x, g^y), MAC_K(Bob)
Alice → Bob:  CERT_A, SIG_A(g^y, g^x), MAC_K(Alice)
```

where K = KDF(g^xy). Bob's certificate and signature arrive encrypted; Alice's identity is fully hidden from passive adversaries.

**SIGMA variants:**

| Variant | Rounds | Identity protection |
|---------|--------|---------------------|
| SIGMA-I | 3 messages | Initiator identity hidden |
| SIGMA-R | 3 messages | Responder identity hidden |
| SIGMA-0 | 2 messages | No identity protection; minimal overhead |

**Why SIGMA matters:** IKEv1 (1998) adopted SIGMA-style signing. IKEv2 (RFC 7296, 2014) formalised it. TLS 1.3 (RFC 8446, 2018) uses a SIGMA-inspired construction — the Finished MAC plays the role of MAC_K(identity) — making SIGMA the conceptual ancestor of every secure TLS 1.3 connection.

| Deployment | Role |
|------------|------|
| IKEv1 / IKEv2 | Signature-based authentication mode |
| TLS 1.3 | Finished MAC mirrors SIGMA's identity MAC |
| QUIC | Inherits TLS 1.3 handshake |

**State of the art:** Cite as [[1]](https://iacr.org/archive/crypto2003/27290399/27290399.pdf). Security proof in the BR model; formalised by Canetti-Krawczyk in the UC model. Related to [IKEv2 / IPsec ESP](12-secure-communication-protocols.md#ikev2--ipsec-esp) and [Key Exchange / Key Agreement](#key-exchange--key-agreement).

**Production readiness:** Production
SIGMA is the cryptographic core of IKEv2 and conceptual ancestor of TLS 1.3; deployed in every IPsec VPN and TLS connection.

**Implementations:**
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C, IKEv2 implementation using SIGMA-I
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, TLS 1.3 handshake (SIGMA-inspired)
- [isakmpd (OpenBSD)](https://github.com/openbsd/src/tree/master/sbin/isakmpd) ⭐ 3.7k — C, IKEv1 SIGMA-based auth

**Security status:** Secure
Provably secure in the BR and UC models; no known attacks on the construction.

**Community acceptance:** Standard
SIGMA-I is the basis of IKEv2 (RFC 7296) and TLS 1.3 (RFC 8446); universally deployed.

---

### Triple Diffie-Hellman (3DH) / X3DH

**Goal:** Combine three Diffie-Hellman exchanges to achieve both mutual authentication and forward secrecy in an asynchronous setting — allowing one party to establish a shared secret even when the other is offline. The cryptographic core of the Signal Protocol's session-initiation handshake.

The Extended Triple Diffie-Hellman (X3DH) protocol, specified by Marlinspike and Perrin (2016), generalises 3DH by adding a one-time prekey, yielding four DH operations. It solves the "offline key agreement" problem that plain ephemeral DH cannot handle.

**Key material per user (Signal server stores):**

| Key | Type | Purpose |
|-----|------|---------|
| IK — Identity Key | Static EC key pair | Long-term identity; used in DH1, DH2 |
| SPK — Signed Prekey | Rotating EC key pair | Medium-term; signed by IK |
| OPK — One-Time Prekey | Ephemeral EC key (pool) | Used once; prevents replay |

**X3DH sender computation (Alice → Bob offline):**

```
EK  = Alice's ephemeral key pair
DH1 = DH(IK_A, SPK_B)
DH2 = DH(EK_A, IK_B)
DH3 = DH(EK_A, SPK_B)
DH4 = DH(EK_A, OPK_B)   (if OPK available)
SK  = KDF(DH1 || DH2 || DH3 || DH4)
```

DH1 + DH2 give mutual authentication; DH3 gives forward secrecy on the SPK rotation; DH4 gives one-time forward secrecy.

**Security properties:**

| Property | Mechanism |
|----------|-----------|
| Mutual authentication | IK appears in DH1 (Alice) and DH2 (Bob) |
| Forward secrecy | EK and OPK are ephemeral; SPK rotates |
| Deniability | DH outputs are symmetric — no unforgeable signature on transcript |
| Asynchronous operation | Bob need not be online; prekeys fetched from server |

| Deployment | Usage |
|------------|-------|
| **Signal** | Original X3DH specification [[1]](https://signal.org/docs/specifications/x3dh/) |
| **WhatsApp** | Uses X3DH for session initiation [[1]](https://scontent.whatsapp.net/v/t39.8562-34/271921190_1410954292692988_8222789712547536776_n.pdf) |
| **MLS (RFC 9420)** | Inspired by X3DH; uses HPKE-based key packages [[1]](https://www.rfc-editor.org/rfc/rfc9420) |

**State of the art:** X3DH (Signal 2016). Feeds directly into the [Double Ratchet](12-secure-communication-protocols.md#double-ratchet--symmetric-ratchet). 3DH without the one-time prekey is the core also used in SIGMA-family proofs. See [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [X3DH](12-secure-communication-protocols.md#x3dh--extended-triple-dh-key-agreement).

**Production readiness:** Production
X3DH is the session initiation protocol for Signal, WhatsApp, and Facebook Messenger; billions of users.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, Signal Protocol including X3DH
- [libsignal-protocol-java](https://github.com/signalapp/libsignal-protocol-java) ⭐ 1.9k [archived] — Java, Signal X3DH + Double Ratchet
- [vodozemac](https://github.com/matrix-org/vodozemac) ⭐ 347 — Rust, Matrix Olm/Megolm (X3DH-inspired)

**Security status:** Secure
Provably secure under DDH; no known practical attacks; provides forward secrecy and deniability.

**Community acceptance:** Widely trusted
Signal specification is the de facto standard for asynchronous key agreement; adopted by WhatsApp, Meta, and Google; MLS (RFC 9420) builds on X3DH concepts.

---

### Noise Protocol Framework

**Goal:** A composable framework of DH-based handshake patterns that produce a shared secret and two cipher states for subsequent encrypted transport — covering every combination of static/ephemeral keys, zero-RTT, mutual/one-sided authentication, and identity hiding, all with a single unified security proof.

Noise, designed by Trevor Perrin (2016), defines a small algebra of handshake *patterns*. Each pattern is a sequence of tokens (`e`, `s`, `ee`, `es`, `se`, `ss`) describing which DH operations are mixed into a running hash and key-derivation chain. Any two parties that agree on a pattern name, DH function, cipher, and hash function share a fully specified protocol.

**Pattern token semantics:**

| Token | Meaning |
|-------|---------|
| `e` | Send ephemeral public key; mix into handshake hash |
| `s` | Send static public key (possibly encrypted) |
| `ee` | DH(eA, eB) — mix into chaining key |
| `es` | DH(eA, sB) or DH(sA, eB) |
| `se` | Symmetric counterpart of es |
| `ss` | DH(sA, sB) — static-static |

**Common named patterns:**

| Pattern | Messages | Authentication | Use case |
|---------|----------|----------------|----------|
| **NN** | `→e / ←e,ee` | None | Anonymous channel (like ephemeral DH) |
| **NK** | `→e,es / ←e,ee` | Responder only | Client knows server's static key; e.g., anonymous client to known server |
| **XX** | `→e / ←e,ee,s,es / →s,se` | Mutual | General mutual-auth; WireGuard-like bootstrap [[1]](https://noiseprotocol.org/noise.html) |
| **IK** | `→e,es,s,ss / ←e,ee,se` | Mutual | 0-RTT; initiator knows responder's static key [[1]](https://noiseprotocol.org/noise.html) |
| **IX** | `→e,s / ←e,ee,se,s,es` | Mutual | Both send static keys immediately |

**Handshake state machine:** Three symmetric-state objects — `CipherState`, `SymmetricState`, `HandshakeState` — with a single `MixKey`/`MixHash`/`EncryptAndHash` API. After the final handshake message, `Split()` produces two `CipherState` objects for transport.

**Noise extensions:**

| Extension | Purpose |
|-----------|---------|
| **Noise Pipes** | Retry fallback from IK to XX if static key unknown |
| **Noise_XK + PSK** | Add pre-shared key layer (psk0…psk3 modifiers) |
| **NoiseSocket** | Length-prefixed framing for TCP streams |
| **NoiseLinux** | Kernel-space WireGuard variant |

| Deployment | Pattern used |
|------------|-------------|
| **WireGuard VPN** | Noise_IKpsk2 [[1]](https://www.wireguard.com/papers/wireguard.pdf) |
| **Lightning Network** | Noise_XK (BOLT #8) [[1]](https://github.com/lightning/bolts/blob/master/08-transport.md) |
| **WhatsApp media** | Noise_XX |

**State of the art:** Noise revision 34 (2018); formally verified in ProVerif and Tamarin. The framework unifies dozens of bespoke protocols into a single analysable family. See [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [Secure Channels](12-secure-communication-protocols.md#ssh-transport-layer--secure-shell-cryptography).

**Production readiness:** Production
Deployed in WireGuard, Lightning Network, WhatsApp media transport, and many other systems.

**Implementations:**
- [snow](https://github.com/mcginty/snow) ⭐ 1.1k — Rust, Noise Protocol Framework implementation
- [noise-java](https://github.com/rweather/noise-java) ⭐ 143 — Java, Noise protocol library
- [wireguard-go](https://github.com/WireGuard/wireguard-go) ⭐ 4.1k — Go, Noise_IKpsk2 in WireGuard
- [noise-c](https://github.com/rweather/noise-c) ⭐ 364 — C, portable Noise implementation
- [NoiseSocket](https://github.com/go-noisesocket/noisesocket) ⭐ 63 — Go, length-prefixed Noise over TCP

**Security status:** Secure
Formally verified in ProVerif and Tamarin; no known attacks on the framework at recommended parameters.

**Community acceptance:** Widely trusted
Broadly peer-reviewed; adopted by WireGuard (Linux kernel), Lightning Network (BOLT #8), and WhatsApp; no IETF RFC but widely recognized.

---

### J-PAKE (Password-Authenticated Key Exchange by Juggling)

**Goal:** Enable two parties to establish an authenticated session key using only a shared low-entropy password, with no PKI and with provable resistance to both on-line and off-line dictionary attacks, using only standard discrete-log primitives.

J-PAKE, designed by Feng Hao and Peter Ryan (2008) and standardised as RFC 8236, authenticates a Diffie-Hellman exchange through a pair of Schnorr non-interactive zero-knowledge (NIZK) proofs that "juggle" both parties' password contributions into the final key. Unlike SRP, J-PAKE provides a published security proof under the DDH assumption.

**Two-round protocol sketch (over a prime-order group):**

| Round | Alice sends | Bob sends |
|-------|-------------|-----------|
| 1 | g^x1, g^x2, ZKP(x1), ZKP(x2) | g^x3, g^x4, ZKP(x3), ZKP(x4) |
| 2 | A = g^(x1+x3+x4)·x2·s, ZKP(x2·s) | B = g^(x1+x2+x3)·x4·s, ZKP(x4·s) |
| Key | K = (B/g^(x2·x4·s))^x2 | K = (A/g^(x2·x4·s))^x4 |

where s is a hash of the password. Both sides must then confirm K with a key-confirmation step (two extra messages, or folded into the application layer).

**Security properties:**
- Off-line dictionary attack resistance — no password verifier is leaked to a passive adversary
- Forward secrecy — session key remains secret even if password is later disclosed
- On-line attack limited to one password guess per protocol run

**Deployments:** Firefox Sync (early); Google Nest / Thread (IoT key agreement); OpenSSL, NSS, Bouncy Castle; IEEE 802.15.4 (Thread group).

**State of the art:** Cite as [[1]](https://www.rfc-editor.org/rfc/rfc8236). EC-J-PAKE (elliptic-curve variant) specified in RFC 8235. CPace (see [Password-Based Key Derivation](#password-based-key-derivation-kdf--pake)) is a cleaner modern alternative. Related to [SPEKE](#speke-simple-password-exponential-key-exchange) and [SPAKE2 / OPAQUE](#key-exchange--key-agreement).

**Production readiness:** Mature
Deployed in Firefox Sync (early versions), Google Nest/Thread IoT devices; available in major crypto libraries.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, J-PAKE support (contrib)
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, J-PAKE implementation
- [mbed TLS](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C, EC-J-PAKE for IoT

**Security status:** Secure
Provably secure under DDH assumption (RFC 8236); no known practical attacks.

**Community acceptance:** Standard
RFC 8236 (J-PAKE) and RFC 8235 (EC-J-PAKE); adopted in Thread/IoT; being superseded by CPace and SPAKE2 in new designs.

---

### SPEKE (Simple Password Exponential Key Exchange)

**Goal:** Derive the Diffie-Hellman generator from the shared password, turning a standard DH exchange into a password-authenticated one with a minimal footprint — no zero-knowledge proofs required.

SPEKE was introduced by David Jablon in 1996. Instead of using a fixed generator g, both parties independently compute g = H(π)² mod p (squaring ensures g generates the prime-order subgroup), then run a standard DH exchange g^a, g^b. An attacker who does not know π cannot compute the correct generator and therefore cannot impersonate either party without making a password guess per protocol run.

**Protocol flow:**

```
Shared input: password π, safe prime p (order q = (p-1)/2)
g ← H(π)² mod p          (both parties compute independently)
Alice: picks a, sends A = g^a mod p
Bob:   picks b, sends B = g^b mod p
Shared secret: K = B^a = A^b = g^(ab) mod p
Key confirmation: optional MAC exchange
```

**Comparison with J-PAKE:**

| Property | SPEKE | J-PAKE |
|----------|-------|--------|
| Zero-knowledge proofs | None required | Schnorr NIZKs |
| Round complexity | 2 messages | 4+ messages |
| Security proof | Informal (1996); formal 2015+ | Proven under DDH (RFC 8236) |
| Known vulnerabilities | 2014 impersonation & KCI attacks | None published |

**Known issues (2014):** Two attacks were identified — an unknown key-share (UKS) attack via parallel sessions and a key-compromise impersonation (KCI) attack. Mitigations require adding session IDs and explicit key confirmation.

**Standards:** IEEE P1363.2 (2008); ISO/IEC 11770-4. EC-SPEKE extends the construction to elliptic curve groups.

**State of the art:** Cite as [[1]](https://dl.acm.org/doi/10.1145/242896.242897). Superseded in practice by SPAKE2 and CPace, which have cleaner security proofs, but SPEKE remains relevant in standards contexts (IEEE P1363.2). Related to [Password-Based Key Derivation](#password-based-key-derivation-kdf--pake) and [J-PAKE](#j-pake-password-authenticated-key-exchange-by-juggling).

**Production readiness:** Deprecated
Superseded by SPAKE2 and CPace in new designs; retained in IEEE P1363.2 and ISO/IEC 11770-4 for legacy interoperability.

**Implementations:**
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, SPEKE variants
- [OpenSSL (contrib)](https://github.com/openssl/openssl) ⭐ 29k — C, experimental SPEKE support

**Security status:** Caution
2014 impersonation and KCI attacks identified; mitigations require session IDs and explicit key confirmation; informal security proof only until 2015.

**Community acceptance:** Niche
IEEE P1363.2 and ISO/IEC 11770-4 standardization; largely superseded by SPAKE2 (RFC 9382) and CPace in new deployments.

---

### TLS 1.3 Key Schedule

**Goal:** Multi-stage, labeled HKDF derivation that transforms a single Diffie-Hellman output into a complete hierarchy of independent, context-bound keys — early data, handshake, and application traffic secrets — with cryptographic separation between stages and between client/server directions.

The TLS 1.3 key schedule (RFC 8446 §7.1) is a stand-alone KDF construction of independent cryptographic interest. It uses HKDF-Extract and HKDF-Expand with transcript hashes as context, creating a sequence of salted extractions that "chain" secrets across the handshake phases.

**Derivation graph:**

```
0 (zero)
│
├─ HKDF-Extract(PSK or 0) → Early Secret
│     ├─ Derive-Secret("c e traffic", CH)    → client_early_traffic_secret
│     └─ Derive-Secret("e exp master", CH)   → early_exporter_master_secret
│
├─ HKDF-Extract(DHE or 0) → Handshake Secret
│     ├─ Derive-Secret("c hs traffic", CH+SH) → client_handshake_traffic_secret
│     └─ Derive-Secret("s hs traffic", CH+SH) → server_handshake_traffic_secret
│
└─ HKDF-Extract(0) → Master Secret
      ├─ Derive-Secret("c ap traffic", CH…SF)  → client_application_traffic_secret_0
      ├─ Derive-Secret("s ap traffic", CH…SF)  → server_application_traffic_secret_0
      ├─ Derive-Secret("exp master",   CH…SF)  → exporter_master_secret
      └─ Derive-Secret("res master",   CH…CF)  → resumption_master_secret
```

where `Derive-Secret(label, msgs) = HKDF-Expand-Label(Secret, label, Transcript-Hash(msgs), L)`.

**HKDF-Expand-Label encoding:**
```
HKDF-Expand(Secret, HkdfLabel, L)
HkdfLabel = length(2B) || "tls13 " || label || context
```

The "tls13 " prefix domain-separates TLS 1.3 outputs from any other HKDF use of the same key material.

**Security properties (proven in [[1]](https://eprint.iacr.org/2020/1044.pdf)):**
- Each stage's traffic keys are independent: compromise of application keys does not reveal handshake keys
- PSK-only mode, PSK + DHE, and DHE-only all provably achieve their respective security levels
- 0-RTT early data keys are bound to the client hello transcript, preventing cross-session replay at the key level (though application-layer replay protection is still required)

**State of the art:** RFC 8446 (2018) [[1]](https://www.rfc-editor.org/rfc/rfc8446); full security proof by Dowling, Fischlin, Günther, and Stebila (Journal of Cryptology 2021) [[2]](https://eprint.iacr.org/2020/1044.pdf). Key-schedule-only security analysis: [[3]](https://eprint.iacr.org/2021/467.pdf). Related to [Password-Based Key Derivation (KDF)](#password-based-key-derivation-kdf--pake) and [SIGMA Protocol](#sigma-protocol-sign-and-mac).

**Production readiness:** Production
Deployed in every major TLS 1.3 implementation; handles the majority of HTTPS traffic globally.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, full TLS 1.3 key schedule
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, TLS 1.3 key schedule (Chrome, Android)
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust, TLS 1.3 key schedule
- [s2n-tls](https://github.com/aws/s2n-tls) ⭐ 4.7k — C, AWS TLS 1.3 implementation
- [Go crypto/tls](https://github.com/golang/go/tree/master/src/crypto/tls) ⭐ 133k — Go, standard library TLS 1.3

**Security status:** Secure
Full security proof in the multi-stage key exchange model; no known attacks on the key schedule construction.

**Community acceptance:** Standard
IETF RFC 8446; the key schedule is integral to TLS 1.3, the dominant secure transport protocol.

---

### FFDHE — Named Finite-Field DH Groups (RFC 7919)

**Goal:** Standardize a fixed set of auditable, safe-prime Diffie-Hellman groups for TLS, eliminating the Logjam vulnerability caused by weak or server-chosen custom groups — replacing ad-hoc DHE parameter negotiation with IANA-registered named groups analogous to named elliptic curves.

The Logjam attack (2015) demonstrated that 512-bit and 768-bit DH groups used in TLS were broken by state-level precomputation, and that even 1024-bit groups were within reach. The root cause was that TLS allowed the server to supply arbitrary DH parameters with no proof of provenance or minimum strength. RFC 7919 (2016) resolves this by defining five named FFDHE groups with "nothing-up-my-sleeve" moduli derived from the leading digits of e, and registering them as TLS `NamedGroup` codepoints alongside ECDH curves.

**Named groups defined by RFC 7919:**

| Group | Modulus size | Security (bits) | TLS codepoint |
|-------|-------------|-----------------|---------------|
| **ffdhe2048** | 2048 bits | ~112 | 256 |
| **ffdhe3072** | 3072 bits | ~128 | 257 |
| **ffdhe4096** | 4096 bits | ~140 | 258 |
| **ffdhe6144** | 6144 bits | ~150 | 259 |
| **ffdhe8192** | 8192 bits | ~160 | 260 |

**Group construction:** All moduli are safe primes p = 2q+1 (order-q subgroup). The middle bits of p are determined by the decimal expansion of e (base of natural logarithm), providing a verifiable "random" structure that rules out trapdoored primes. The high and low 64 bits are all 1s for efficient Montgomery/Barrett reduction.

**Key exchange flow (TLS 1.2 DHE with ffdhe):**
1. Client advertises `ffdhe2048` (or higher) in `supported_groups` extension
2. Server selects a group from the intersection; sends `ServerKeyExchange` with DH public value g^y mod p
3. Client sends g^x mod p; both compute shared secret g^(xy) mod p
4. Shared secret is passed to the PRF to derive session keys

**Why not ECDH instead?** ECDH (X25519) is preferred for new deployments due to smaller keys and faster computation. FFDHE serves legacy stacks and regulatory requirements (e.g., some government profiles mandate finite-field DH), and remains the only DHE option for TLS 1.2 code paths that do not support ECDH.

**TLS 1.3 note:** RFC 8446 extends the `NamedGroup` registry to include ffdhe groups alongside secp* and x25519/x448. TLS 1.3 mandates ephemeral key exchange, so FFDHE in TLS 1.3 is always forward-secret.

**State of the art:** RFC 7919 (2016) [[1]](https://www.rfc-editor.org/rfc/rfc7919). NIST SP 800-77 Rev 1 recommends 2048-bit minimum. Logjam paper [[2]](https://weakdh.org/imperfect-forward-secrecy-ccs15.pdf). Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [TLS 1.3 Key Schedule](#tls-13-key-schedule).

**Production readiness:** Production
Registered as IANA TLS NamedGroup codepoints; supported in all major TLS libraries for legacy DHE use.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, RFC 7919 named FFDHE groups
- [GnuTLS](https://gitlab.com/gnutls/gnutls) — C, FFDHE group support
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, FFDHE support in TLS
- [NSS](https://github.com/nss-dev/nss) ⭐ 178 — C, Mozilla's TLS library with FFDHE

**Security status:** Secure
Nothing-up-my-sleeve primes derived from digits of e; 2048-bit minimum provides 112-bit security; eliminates Logjam-style weak-group attacks.

**Community acceptance:** Standard
IETF RFC 7919; IANA-registered NamedGroup codepoints; NIST SP 800-77 Rev 1 endorsed.

---

### Station-to-Station (STS) Protocol

**Goal:** The first practical authenticated Diffie-Hellman key exchange — augment the original 1976 DH protocol with digital signatures to provide mutual authentication and forward secrecy, blocking both passive eavesdroppers and active man-in-the-middle attackers.

STS was proposed by Diffie, van Oorschot, and Wiener (1992) as a response to the man-in-the-middle vulnerability of unauthenticated DH. Each party signs the concatenation of the two DH public values under their long-term key, and encrypts the signature under the derived session key to hide identities from passive observers. STS is the direct precursor to SIGMA; it was widely deployed in early SSH and influenced IKEv1.

**Three-message protocol:**

```
Shared params: prime p, generator g

Alice → Bob:  g^x mod p
Bob → Alice:  g^y mod p,  E_K(SIG_B(g^y, g^x),  CERT_B)
Alice → Bob:              E_K(SIG_A(g^x, g^y),  CERT_A)

where K = KDF(g^(xy))
```

Each signature covers both DH values in order, binding the key exchange to the authenticated identities.

**Security properties:**
- Mutual authentication — both parties prove knowledge of their private signing key
- Forward secrecy — compromise of long-term signing keys does not expose past session keys (ephemeral x, y discarded)
- Identity protection — signatures and certificates encrypted under K; passive observers see only DH values

**Known flaw (identity misbinding):** STS does not MAC the *peer's* identity under K — only signs DH values. A subtle attack by Krawczyk (2003) shows a misbinding attack where a legitimate participant can be made to share a key with an unintended peer. This is exactly the flaw that [SIGMA](#sigma-protocol-sign-and-mac) was designed to fix by adding MAC_K(own_identity).

**Deployments and influence:**

| System | Relationship to STS |
|--------|---------------------|
| SSH-1 | Direct STS descendant (signature over DH values) |
| IKEv1 (Main Mode) | STS-inspired with certificates |
| IKEv2 | Replaced by SIGMA-I construction |
| TLS 1.2 (DHE_RSA) | Signature over ServerKeyExchange (partial STS) |

**State of the art:** Original paper [[1]](https://link.springer.com/article/10.1007/BF00124891) (Diffie, van Oorschot, Wiener, 1992). Superseded by [SIGMA](#sigma-protocol-sign-and-mac) in all modern designs. Still historically important as the root of authenticated key exchange. Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [SIGMA Protocol](#sigma-protocol-sign-and-mac).

**Production readiness:** Deprecated
Superseded by SIGMA in IKEv2 and TLS 1.3; historically used in SSH-1 and IKEv1.

**Implementations:**
- [OpenSSH (legacy)](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, STS-derived authentication in SSH-1 (deprecated)
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C, IKEv1 main mode (STS-inspired)

**Security status:** Superseded
Identity misbinding attack identified by Krawczyk (2003); fixed by SIGMA's MAC_K(identity) addition.

**Community acceptance:** Niche
Historically important as the first authenticated DH protocol; superseded by SIGMA in all modern standards.

---

### Post-Quantum Key Exchange in Practice (Hybrid KEM)

**Goal:** Achieve post-quantum security in deployed protocols without abandoning classical security guarantees — by combining a classical KEM (X25519 or P-256) with a post-quantum KEM (ML-KEM / Kyber) so that the shared secret is secure as long as *either* the classical or the PQ component is unbroken.

A hybrid KEM combines two independent KEMs: `SS = KDF(SS_classical || SS_pq || context)`. An adversary must break *both* components to recover `SS`. This is the NIST-recommended transition strategy (SP 800-227) and is already deployed in TLS 1.3, Signal, and Chrome.

**Deployed hybrid constructions:**

| Scheme | Composition | Status |
|--------|-------------|--------|
| **X25519Kyber768** | X25519 + Kyber-768 (pre-standardization) | Chrome 116+ (TLS), Google [[1]](https://blog.chromium.org/2023/08/protecting-chrome-traffic-with-hybrid.html) |
| **X-Wing** | X25519 + ML-KEM-768; single-hash combiner | IETF draft [[1]](https://datatracker.ietf.org/doc/draft-connolly-cfrg-xwing-kem/) |
| **MLKEM768X25519** | ML-KEM-768 + X25519; TLS named group | TLS 1.3 RFC 8446 extension; IANA codepoint 0x11EC [[1]](https://www.iana.org/assignments/tls-parameters/) |
| **P256Kyber768Draft00** | P-256 + Kyber-768 | AWS-LC, BoringSSL (transitional) |
| **X25519MLKEM768** | X25519 + ML-KEM-768 (post-NIST-finalization) | TLS WG preferred designation post-FIPS 203 |

**X-Wing construction (IETF draft):**

X-Wing is a tightly specified combiner that avoids the subtleties of generic hybrid KEM composition:

```
Encapsulate(pk_xw, randomness):
  (ss_m, ct_m) ← ML-KEM-768.Encaps(pk_m)
  (ss_x, ct_x) ← X25519(ek_x, pk_x)   — ephemeral key ek_x
  ss = SHA3-256("\.//^\\", ss_m, ct_m, ss_x, ct_x, pk_x)
  return (ss, ct_m || ct_x)
```

The combiner uses a domain-separated SHA3-256 over both ciphertexts and both shared secrets, preventing cross-protocol attacks between components.

**TLS 1.3 hybrid key exchange:**

In TLS 1.3, a hybrid KEM is negotiated as a `NamedGroup` in the `supported_groups` extension. The `KeyShareEntry` carries the concatenation of both KEM public keys / encapsulations. The final shared secret is derived via HKDF as part of the [TLS 1.3 Key Schedule](#tls-13-key-schedule).

```
ClientHello:
  supported_groups: [x25519_ml_kem_768, x25519, secp256r1]
  key_share: [x25519_ml_kem_768: ek_x25519 || ek_mlkem]

ServerHello:
  key_share: x25519_ml_kem_768: ct_x25519 || ct_mlkem
```

**Signal Protocol (PQXDH):**

Signal's PQXDH (2023) replaces X3DH's initial DH with a hybrid: X25519 + Kyber-1024 in the key establishment phase, adding a post-quantum Signed PreKey (SPQK). The session key includes `KDF(DH1 || DH2 || DH3 || DH4 || KEM_ss)`.

**Security levels:**

| Component | Classical security | PQ security |
|-----------|-------------------|------------|
| X25519 | 128-bit (ECDLP) | 0-bit (Shor's algorithm) |
| ML-KEM-768 | 108-bit (LWE) | 178-bit (best known PQ attack) |
| X-Wing hybrid | 128-bit classical | 178-bit PQ |

**State of the art:** MLKEM768X25519 (IANA codepoint 0x11EC) is the emerging TLS standard. X-Wing is the IETF CFRG recommendation for a clean single-algorithm hybrid. NIST SP 800-227 (2024 draft) mandates hybrid KEMs during the transition period. Related to [Non-Interactive Key Exchange (NIKE)](#non-interactive-key-exchange-nike), [Key Exchange / Key Agreement](#key-exchange--key-agreement), and [Post-Quantum Cryptography](15-quantum-cryptography.md#quantum-cryptography--post-quantum).

**Production readiness:** Production
X25519Kyber768 deployed in Chrome 116+ and Cloudflare; Signal uses PQXDH with Kyber-1024 in production.

**Implementations:**
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, X25519Kyber768 hybrid in TLS 1.3
- [AWS-LC](https://github.com/aws/aws-lc) ⭐ 731 — C, hybrid KEM support for TLS
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust, hybrid key exchange support
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, PQXDH with Kyber-1024
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM and hybrid KEM implementations

**Security status:** Secure
Hybrid construction ensures security if either classical or PQ component holds; no known attacks on deployed combinations.

**Community acceptance:** Emerging
IANA-registered TLS codepoints; NIST SP 800-227 draft endorses hybrid approach; Chrome, Signal, and Cloudflare in production; IETF drafts in progress.

---

### One-Pass Diffie-Hellman (NIST SP 800-56A)

**Goal:** Reduce a key-establishment round-trip to a single message — the initiator sends one ephemeral public key; the responder uses their static key to compute the shared secret without sending anything — enabling asynchronous key agreement where the responder is offline or bandwidth is constrained.

One-pass DH is one of the key-establishment schemes approved in NIST SP 800-56A Rev 3 (2018). In its elliptic-curve form (One-Pass ECMQV or One-Pass ECDH), the initiator generates an ephemeral key pair and encrypts or authenticates a message that the responder can later open using only their static private key. The scheme sacrifices forward secrecy for the initiator's contribution but retains it from the responder's side.

**One-Pass ECDH (from SP 800-56A, Section 6.2.2):**

```
Initiator (Alice):  ephemeral key pair (d_e, Q_e)
Responder (Bob):    static key pair   (d_s, Q_s)   [public key known to Alice]

Alice computes: Z = ECDH(d_e, Q_s)   — one scalar multiplication
                 (sends Q_e and ciphertext bound to Z)

Bob computes:   Z = ECDH(d_s, Q_e)   — one scalar multiplication, no reply needed
```

The shared secret `Z` is passed through a key-derivation function together with `Q_e`, `Q_s`, and a shared info string; the result is the keying material.

**One-Pass ECMQV (SP 800-56A, Section 6.3):**

Replaces the single ECDH with the two-key implicit-authentication structure of MQV, allowing Bob's static key to provide authentication of his end — Alice learns she is talking to the owner of `Q_s` — while still requiring only one message from Alice.

```
Alice ephemeral: (d_e, Q_e)
Shared secret:   Z = h · cofactor · d_e · (Q_s + ē(Q_s) · d_s)
                   = Bob's equivalent MQV contribution
```

**NIST SP 800-56A scheme catalogue:**

| Scheme | Passes | Auth | Forward secrecy |
|--------|--------|------|-----------------|
| **Ephemeral Unified Model** | 2 | None | Full (both sides ephemeral) |
| **Static Unified Model** | 2 | Both sides | None (no ephemeral) |
| **One-Pass DH** | 1 | Responder only | Responder side only |
| **One-Pass MQV** | 1 | Responder only | Partial |
| **Full MQV / HMQV** | 2 | Both (implicit) | Full |

**Deployments:** CMS (RFC 5652) EnvelopedData with ECDH key agreement; S/MIME key agreement (RFC 5753); IKEv2 optional one-pass mode; email encryption scenarios where the sender encrypts to a recipient's static public key from a certificate.

**State of the art:** NIST SP 800-56A Rev 3 (2018) [[1]](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Ar3.pdf); SP 800-56A is the foundational NIST reference for all approved DH-based key establishment. One-pass DH underlies CMS ECDH key agreement (RFC 5753) [[2]](https://www.rfc-editor.org/rfc/rfc5753). Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [ECMQV](#ecmqv-elliptic-curve-menezes-qu-vanstone).

**Production readiness:** Production
Deployed in CMS/S/MIME key agreement (RFC 5753) and NIST-approved key establishment in federal systems.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, one-pass ECDH for CMS EnvelopedData
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, SP 800-56A key agreement schemes
- [NSS](https://github.com/nss-dev/nss) ⭐ 178 — C, CMS ECDH key agreement

**Security status:** Caution
Secure for its intended use cases but provides only responder-side authentication; no forward secrecy from the initiator's side.

**Community acceptance:** Standard
NIST SP 800-56A Rev 3; RFC 5753 (CMS ECDH key agreement); widely used in S/MIME and federal PKI.

---

### MTI Protocols (Matsumoto-Takashima-Imai)

**Goal:** A family of two-pass unauthenticated and implicitly authenticated key-agreement protocols that generalize Diffie-Hellman by mixing ephemeral and static keys in structured algebraic combinations — allowing a tradeoff between message count, authentication level, and resistance to known-key and key-compromise attacks.

MTI protocols were introduced by Matsumoto, Takashima, and Imai (1986) as a systematic analysis of key agreement protocols built over finite fields. The family is parameterized by an integer pair (a, b) controlling how each party's static and ephemeral keys contribute to the shared secret, revealing that DH is just one member of a broader design space.

**General MTI construction (over a prime-order group, generator g):**

Each party holds a long-term key pair `(x, g^x)` and generates an ephemeral `(r, g^r)`. The shared secret is:

```
Alice → Bob:  g^r_A
Bob → Alice:  g^r_B

Z_A = (g^(x_B))^r_A · (g^r_B)^(x_A)    — Alice's computation
Z_B = (g^(x_A))^r_B · (g^r_A)^(x_B)    — Bob's computation
```

Both sides compute `Z_A = Z_B = g^(x_A·r_B + x_B·r_A)` — a cross-term combining both parties' static and ephemeral contributions symmetrically.

**MTI family instances (varying exponent structure):**

| Protocol | Shared secret exponent | Notes |
|----------|----------------------|-------|
| **MTI/A0** | `g^(x_A·r_B + x_B·r_A)` | Original; two-pass; static keys needed at both ends |
| **MTI/B0** | `g^(x_A·r_B) · g^(x_B·r_A)` | Equivalent to A0 in prime-order groups |
| **MTI/C0** | `g^(r_A·r_B + x_A·x_B)` | Cross-term on ephemeral and static separately |
| **Classic DH** | `g^(r_A·r_B)` | Special case: static keys unused |
| **Static DH** | `g^(x_A·x_B)` | Special case: ephemeral keys unused; no forward secrecy |

**Security properties:**

The MTI family separates known-key security (past sessions remain secret after long-term key compromise) from key-compromise impersonation (KCI) resistance. MTI/A0 provides known-key security but is vulnerable to KCI: if Alice's long-term key `x_A` is compromised, an attacker can impersonate Bob to Alice. This weakness motivated the HMQV design (which uses implicit signatures to close the KCI gap).

**Historical significance:** MTI protocols were the first systematic taxonomy of authenticated key exchange protocols; they directly motivated the subsequent analysis of STS, MQV, and SIGMA. Blake-Wilson, Johnson, and Menezes (1997) formalized their security model, influencing the Bellare-Rogaway (BR) model used for TLS analysis today.

**State of the art:** Original paper [[1]](https://doi.org/10.1109/18.21253) (Matsumoto, Takashima, Imai, 1986/IEEE Trans. Inf. Theory 1988); security analysis [[2]](https://link.springer.com/chapter/10.1007/3-540-68339-9_36) (Blake-Wilson et al., 1997). MTI protocols are primarily of historical and theoretical interest; HMQV and SIGMA are preferred for new designs. Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement), [ECMQV](#ecmqv-elliptic-curve-menezes-qu-vanstone), and [SIGMA Protocol](#sigma-protocol-sign-and-mac).

**Production readiness:** Research
Historically important but not directly deployed; MTI analysis influenced MQV, HMQV, and SIGMA which are the deployed descendants.

**Implementations:**
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, MQV/HMQV implementations (MTI descendants)
- No standalone MTI implementations in production use

**Security status:** Superseded
MTI/A0 is vulnerable to KCI attacks; the family is superseded by HMQV and SIGMA which close these gaps.

**Community acceptance:** Niche
Historically significant as the first systematic AKE taxonomy; cited in security models (BR, CK) but not standardized or deployed directly.

---

### Encrypted Key Exchange (EKE) — Bellovin-Merritt

**Goal:** Enable two parties to establish a cryptographically strong session key using only a shared low-entropy password — by encrypting a public key or key-exchange message under the password, so that dictionary attacks against the public-key transcript are computationally infeasible without a live interaction.

EKE (Encrypted Key Exchange) was introduced by Bellovin and Merritt (1992) and is the original PAKE protocol. The core insight is deceptively simple: if DH public values or RSA public keys are encrypted under the password, an eavesdropper cannot run an offline dictionary attack because they cannot distinguish valid encrypted keys from random noise without decrypting each candidate — and decryption succeeds only for the correct password.

**Basic EKE protocol (DH variant):**

```
Shared:  password P, prime p, generator g

Alice → Bob:  E_P(g^x mod p)          — DH value encrypted under P
Bob → Alice:  E_P(g^y mod p),  E_K(R_B)   — K = g^(xy), R_B = random challenge
Alice → Bob:  E_K(R_B, R_A)           — confirms K; sends own challenge
Bob → Alice:  E_K(R_A)                — confirms K to Alice
```

The password encryption `E_P` is a symmetric cipher (original paper uses DES); the session key `K = g^(xy)` is derived from the DH shared secret. The final two confirmation messages are mutual key confirmation.

**RSA-EKE variant:**

Alice generates a random RSA public key `(e, n)` and sends `E_P(e, n)` to Bob. Bob replies with `E_P(E_e(R))` — an RSA encryption of a random secret under Alice's ephemeral public key, itself encrypted under the password. Both sides derive `K` from `R`. This variant requires care: `n` must be generated as a proper RSA modulus to avoid leaking password bits through modular arithmetic structure.

**Augmented EKE (A-EKE):** Bob stores a password *verifier* (not the password itself), preventing server compromise from revealing the password for offline use. This idea prefigures OPAQUE.

**Known limitations:**
- Original DES-EKE uses block ciphers in a non-standard way; Boyko et al. (1999) identified subtle issues requiring a random oracle
- RSA-EKE leaks whether the modulus is composite via Jacobi symbol; patched in subsequent work
- Motivated cleaner designs: SPEKE (1996), SRP (2000), SPAKE2 (2005), OPAQUE (2018)

| Scheme | Year | Notes |
|--------|------|-------|
| **EKE (DH variant)** | 1992 | Original PAKE; DH value encrypted under password [[1]](https://dl.acm.org/doi/10.1145/168588.168618) |
| **EKE (RSA variant)** | 1992 | Ephemeral RSA key encrypted under password; subtle issues with modulus structure [[1]](https://dl.acm.org/doi/10.1145/168588.168618) |
| **Augmented EKE** | 1993 | Server stores verifier; precursor to SRP and OPAQUE [[1]](https://www.cs.columbia.edu/~smb/papers/neke.pdf) |

**State of the art:** EKE is the conceptual root of the entire PAKE family. Modern replacements are SPAKE2 (RFC 9382), CPace, and OPAQUE (all in [Password-Based Key Derivation](#password-based-key-derivation-kdf--pake)). EKE itself is no longer recommended for new designs due to subtleties in the password-encryption step, but it remains essential reading for understanding PAKE evolution. Related to [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake) and [J-PAKE](#j-pake-password-authenticated-key-exchange-by-juggling).

**Production readiness:** Deprecated
The original PAKE; superseded by SPAKE2, CPace, and OPAQUE in all new designs due to subtleties in password-encryption.

**Implementations:**
- No maintained standalone EKE implementations; the protocol is studied via academic prototypes
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, implements modern PAKE descendants (SPAKE2)

**Security status:** Superseded
Subtle issues in the password-encryption step (Boyko et al., 1999); RSA-EKE leaks via Jacobi symbol; replaced by provably secure PAKEs.

**Community acceptance:** Niche
Historically foundational (Bellovin-Merritt, 1992); not standardized; superseded by SPAKE2 (RFC 9382), CPace, and OPAQUE.

---

### Group Key Agreement (Burmester-Desmedt)

**Goal:** Establish a single shared secret key among n ≥ 2 parties in a single broadcast round, so that any subset of colluding non-members learns nothing about the key — extending two-party Diffie-Hellman to conference and group settings without a trusted key distribution center.

Two-party DH does not generalize naively to n parties: a naive chain of pairwise DH operations leaks the intermediate values and requires n−1 sequential rounds. The Burmester-Desmedt (BD) protocol (1994) achieves a one-round broadcast group key agreement for n parties using only n−1 modular exponentiations per party.

**Burmester-Desmedt protocol (1-round, n parties in a ring):**

Parties are numbered 1 … n (cyclically). Each party i holds a random ephemeral `r_i`.

```
Round 1 (broadcast):
  Each party i broadcasts:  X_i = g^(r_i) mod p

Round 2 (broadcast):
  Each party i broadcasts:  Y_i = (X_{i+1} / X_{i-1})^(r_i) mod p
                                 = g^(r_i · (r_{i+1} - r_{i-1}))

Key derivation (each party i):
  K = X_{i-1}^(n·r_i) · Y_{i-1}^((n-1)·r_i) · ... · Y_{i+n-2}^(r_i)
    = g^(r_1·r_2 + r_2·r_3 + ... + r_n·r_1)     [sum of adjacent pairs, cyclically]
```

All parties compute the same key K, which is the product of all adjacent DH pairs around the ring. An eavesdropper who sees all `X_i` and `Y_i` values must solve a DDH problem to recover K.

**Properties:**

| Property | BD Protocol |
|----------|-------------|
| Rounds | 2 broadcast rounds |
| Messages per party | 2 broadcasts |
| Computation per party | O(n) multiplications, O(1) exponentiations |
| Security | Passive security under DDH |
| Authenticated variant | Requires signatures on each broadcast (BD + signatures) |
| Forward secrecy | Yes (ephemeral r_i values) |

**Extensions and limitations:**

- **Authenticated BD:** Adding signatures over the broadcast values provides active security against man-in-the-middle but requires a PKI; this is how BD is used in practice.
- **Joux's tripartite DH (2000):** Uses bilinear pairings to achieve one-round, one-message group key agreement for exactly 3 parties — constant complexity but pairing-dependent [[1]](https://link.springer.com/chapter/10.1007/10722028_28).
- **Tree-based group DH (TGDH):** Organizes parties in a binary tree; rekeying after join/leave requires O(log n) operations rather than O(n), making it suitable for dynamic groups [[1]](https://dl.acm.org/doi/10.1145/586110.586114).
- **MLS / CGKA (RFC 9420):** The modern answer to dynamic group key agreement; uses HPKE-based ratchet trees achieving O(log n) join/leave complexity (see [CGKA/MLS](12-secure-communication-protocols.md#mimi--more-instant-messaging-interoperability)).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burmester-Desmedt (BD)** | 1994 | DDH | One-round broadcast; O(n) computation per party [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_33) |
| **Joux Tripartite DH** | 2000 | Bilinear pairings | One-round for n=3; pioneered pairing-based crypto [[1]](https://link.springer.com/chapter/10.1007/10722028_28) |
| **Tree-based Group DH (TGDH)** | 2004 | Binary tree + DH | O(log n) rekeying for dynamic groups [[1]](https://dl.acm.org/doi/10.1145/586110.586114) |
| **MLS (RFC 9420)** | 2023 | HPKE + ratchet tree | Production group key agreement for messaging [[1]](https://www.rfc-editor.org/rfc/rfc9420) |

**State of the art:** BD (1994) is the foundational reference for static group key agreement. Dynamic groups are solved by CGKA/MLS (RFC 9420, 2023), which achieves O(log n) rekeying with forward secrecy and post-compromise security. Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [CGKA / MLS](12-secure-communication-protocols.md#mimi--more-instant-messaging-interoperability).

**Production readiness:** Research
BD and TGDH are foundational but largely superseded by MLS (RFC 9420) for production group key agreement.

**Implementations:**
- [openmls](https://github.com/openmls/openmls) ⭐ 905 — Rust, MLS group key agreement (modern successor)
- No maintained standalone BD implementations; academic prototypes only
- [mls-rs](https://github.com/awslabs/mls-rs) ⭐ 213 — Rust, MLS protocol library

**Security status:** Secure
BD is passively secure under DDH; authenticated BD requires signatures; MLS provides active security with forward secrecy and post-compromise security.

**Community acceptance:** Niche
BD is a foundational academic protocol (1994); MLS (RFC 9420, 2023) is the modern standard for group key agreement in messaging.

---

### KEM Combiner Constructions

**Goal:** Formally combine two or more Key Encapsulation Mechanisms (KEMs) into a single hybrid KEM that is secure as long as at least one component KEM is secure — with a cryptographically rigorous combiner that does not weaken either component and achieves IND-CCA2 security of the combination from the IND-CCA2 security of either part.

As post-quantum KEMs (ML-KEM, Classic McEliece, BIKE, HQC) are deployed alongside classical KEMs (X25519, P-256), the question of *how* to combine them becomes security-critical. A naive XOR of shared secrets is insecure if one KEM is broken; a simple concatenation combiner is stronger but requires additional care to achieve CCA2 security.

**Formal definition:**

A KEM combiner `C = Combine(KEM_1, KEM_2)` takes two KEMs and produces a hybrid KEM:

```
KeyGen:    (pk_1, sk_1) ← KEM_1.KeyGen();  (pk_2, sk_2) ← KEM_2.KeyGen()
           pk = (pk_1, pk_2);  sk = (sk_1, sk_2)

Encaps(pk): (ss_1, ct_1) ← KEM_1.Encaps(pk_1)
            (ss_2, ct_2) ← KEM_2.Encaps(pk_2)
            ss = Combiner(ss_1, ct_1, ss_2, ct_2)
            return (ss, ct_1 || ct_2)

Decaps(sk, ct_1 || ct_2):
            ss_1 = KEM_1.Decaps(sk_1, ct_1)
            ss_2 = KEM_2.Decaps(sk_2, ct_2)
            return Combiner(ss_1, ct_1, ss_2, ct_2)
```

**Key combiner functions:**

| Combiner | Formula | Security requirement |
|----------|---------|---------------------|
| **XOR** | `ss_1 XOR ss_2` | Insecure if either KEM is breakable [[1]](https://eprint.iacr.org/2018/024) |
| **Concatenation KEM (naive)** | `H(ss_1 \|\| ss_2)` | Secure if either ss is uniformly random (PRF assumption) |
| **Dual-PRF combiner** | `H(ss_1 \|\| ct_1 \|\| ss_2 \|\| ct_2)` | IND-CCA2 if either KEM is IND-CCA2; ciphertexts bound to their shared secrets [[1]](https://eprint.iacr.org/2018/024) |
| **X-Wing combiner** | `SHA3-256(label \|\| ss_m \|\| ct_m \|\| ss_x \|\| ct_x \|\| pk_x)` | Tight IND-CCA2 for ML-KEM + X25519 specifically [[1]](https://eprint.iacr.org/2024/039) |

**Why ciphertext binding matters:**

The dual-PRF combiner `H(ss_1 || ct_1 || ss_2 || ct_2)` — which includes the ciphertexts in the hash input — is strictly stronger than `H(ss_1 || ss_2)`. If an adversary can reuse a ciphertext `ct_1` from one session in a different context, the ciphertext-binding prevents key reuse across sessions. This is the construction recommended by the IETF CFRG for all new hybrid KEM deployments.

**NIST guidance:**

NIST SP 800-227 (Initial Public Draft, 2024) endorses the dual-PRF approach: the combined shared secret must be derived as `KDF(Z_1 || Z_2 || ct_1 || ct_2 || context)` using an approved KDF (HKDF-SHA-256 or KMAC256), ensuring domain separation between components.

**Deployed combiners:**

| Scheme | Combiner used | Reference |
|--------|---------------|-----------|
| **X-Wing** | Single SHA3-256 with label, both ss and ct | IETF draft-connolly-cfrg-xwing-kem [[1]](https://datatracker.ietf.org/doc/draft-connolly-cfrg-xwing-kem/) |
| **TLS hybrid (IETF draft)** | HKDF over concatenated secrets | draft-ietf-tls-hybrid-design [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-hybrid-design/) |
| **HPKE hybrid (RFC 9180)** | Suite-level combiner; no ciphertext binding needed (HPKE provides it) | [[1]](https://www.rfc-editor.org/rfc/rfc9180) |

**State of the art:** Giacon-Heuer-Poettering (2018) [[1]](https://eprint.iacr.org/2018/024) formally proved that the dual-PRF (ciphertext-binding) combiner achieves IND-CCA2 from either component. X-Wing (2024) [[2]](https://eprint.iacr.org/2024/039) provides a tighter, single-primitive combiner for the ML-KEM + X25519 case. NIST SP 800-227 draft [[3]](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-227.ipd.pdf) standardizes combiner requirements. Related to [Post-Quantum Key Exchange (Hybrid KEM)](#post-quantum-key-exchange-in-practice-hybrid-kem) and [Key Exchange / Key Agreement](#key-exchange--key-agreement).

**Production readiness:** Experimental
X-Wing and dual-PRF combiners are deployed in Chrome and BoringSSL hybrid KEMs; formal combiner theory is mature but standardization is in progress.

**Implementations:**
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, X25519Kyber768 with dual-PRF combiner
- [AWS-LC](https://github.com/aws/aws-lc) ⭐ 731 — C, hybrid KEM combiner implementations
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, hybrid KEM support with configurable combiners

**Security status:** Secure
Dual-PRF combiner is provably IND-CCA2 if either component KEM is IND-CCA2; X-Wing has a tight security proof.

**Community acceptance:** Emerging
NIST SP 800-227 draft endorses dual-PRF approach; IETF CFRG X-Wing draft in progress; deployed in Chrome and AWS but not yet finalized as an RFC.

---

### Double Ratchet and KDF Chain Key Management

**Goal:** Maintain continuous forward secrecy and break-in recovery (post-compromise security) in long-running messaging sessions — by advancing a KDF chain with every message so that the compromise of any single message key does not expose past or future messages, and by periodically injecting new Diffie-Hellman entropy to "heal" from state compromise.

The Double Ratchet algorithm (Marlinspike and Perrin, 2016) is the key-management heart of the Signal Protocol and, through Signal's influence, of WhatsApp, Facebook Messenger (secret conversations), and Google Messages (RCS E2E). It manages keys through two interlocked ratchets: a symmetric-key KDF ratchet (fast, per-message) and a Diffie-Hellman ratchet (slower, triggered by each new message from the remote party).

**KDF chain ratchet (symmetric):**

```
State:  Chain Key CK_i,  Message Key MK_i

Advance:
  MK_i   = HMAC-SHA256(CK_i,  0x01)   — used to encrypt message i
  CK_{i+1} = HMAC-SHA256(CK_i, 0x02)   — new chain key for next message
```

Each `MK_i` is derived once and then discarded after use. An adversary who captures `CK_i` (or any later state) cannot recover `CK_{i-1}` (forward secrecy). An adversary who captures `MK_i` learns only that one message.

**DH ratchet (asymmetric):**

Each message carries the sender's current ephemeral DH public key. When the recipient receives a new DH public key from the remote party, they compute a new root key using DH output mixed into the root chain:

```
On receipt of remote DH public key rk_remote:
  DH_out = DH(dh_private_local, rk_remote)
  (RK_new, CK_recv) = KDF_RK(RK_old, DH_out)
  Discard dh_private_local; generate new dh_private_local
  (RK_new2, CK_send) = KDF_RK(RK_new, DH(dh_private_local_new, rk_remote))
```

This "healing" step means that after a state compromise, once both parties exchange new DH keys, the session is cryptographically recovered — break-in recovery or post-compromise security.

**Security properties:**

| Property | Mechanism |
|----------|-----------|
| Forward secrecy (per message) | KDF chain: deleted MK_i cannot be recovered |
| Forward secrecy (per session epoch) | DH ratchet: deleted DH private keys cannot be recovered |
| Break-in recovery (post-compromise security) | DH ratchet: new DH step heals from state exposure |
| Out-of-order messages | Message keys can be skipped and stored; bounded look-ahead |
| Deniability | DH outputs are symmetric; no signatures on messages |

**Beyond Signal — ratchet variants:**

| Protocol | Ratchet mechanism | Notes |
|----------|------------------|-------|
| **Signal Double Ratchet** | KDF chain + DH ratchet | Original; per-message DH key advertisement [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **PQXDH + Double Ratchet** | Kyber-1024 at session init, then classical DH ratchet | PQ session establishment; ratchet remains classical [[1]](https://signal.org/docs/specifications/pqxdh/) |
| **MLS (RFC 9420) TreeKEM** | HPKE-based tree ratchet for n-party groups | O(log n) rekeying; different ratchet design for groups [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **IETF Messaging Layer Security** | Continuous group key agreement (CGKA) | Formally separates key management from messaging |

**Key deletion discipline:** The Double Ratchet's security depends on securely deleting message keys and old DH private keys immediately after use. Implementations must zero memory and — on systems with swap or hibernation — use locked memory pages.

**State of the art:** Signal Double Ratchet specification [[1]](https://signal.org/docs/specifications/doubleratchet/); formal analysis by Alwen, Coretti, and Dodis (2019) [[2]](https://eprint.iacr.org/2018/1037); Cohn-Gordon et al. (2016) security proof [[3]](https://eprint.iacr.org/2016/221). Related to [X3DH / Extended Triple Diffie-Hellman](#triple-diffie-hellman-3dh--x3dh), [CGKA / MLS](12-secure-communication-protocols.md#mimi--more-instant-messaging-interoperability), and [Password-Based Key Derivation (KDF)](#password-based-key-derivation-kdf--pake).

**Production readiness:** Production
Deployed in Signal, WhatsApp, Facebook Messenger, and Google Messages; billions of users.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, Signal Protocol Double Ratchet
- [libsignal-protocol-java](https://github.com/signalapp/libsignal-protocol-java) ⭐ 1.9k [archived] — Java, Signal Double Ratchet
- [vodozemac](https://github.com/matrix-org/vodozemac) ⭐ 347 — Rust, Matrix Olm/Megolm ratchet (Double Ratchet-inspired)

**Security status:** Secure
Provably secure with forward secrecy and post-compromise security; formally analyzed by multiple independent teams; no known attacks.

**Community acceptance:** Widely trusted
Signal specification is the de facto standard for message-level key management; adopted by WhatsApp, Meta, Google; MLS (RFC 9420) builds on ratchet concepts.

---

### ML-KEM (CRYSTALS-Kyber) Internals

**Goal:** A post-quantum key encapsulation mechanism based on the hardness of the Module Learning With Errors (MLWE) problem — providing IND-CCA2 security against quantum adversaries, standardized by NIST as FIPS 203 (2024) for use in key exchange and hybrid key establishment.

ML-KEM (formerly CRYSTALS-Kyber) is NIST's primary post-quantum KEM standard. Unlike the Hybrid KEM section (which covers how ML-KEM is *combined* with X25519), this section describes ML-KEM's internal structure: how it generates keys, encapsulates, and decapsulates, and what makes its security rely on MLWE.

**Module Learning With Errors (MLWE):**

MLWE is a structured variant of LWE. Work over the polynomial ring `R_q = Z_q[X]/(X^n + 1)` where `n = 256` and `q = 3329` (for Kyber-768). A module of rank `k` means working with `k×k` matrices of ring elements:

```
MLWE problem: Given A ∈ R_q^(k×k) and b = A·s + e (mod q),
              find s,  where s, e ← small distribution (centered binomial η)
```

Solving MLWE is believed to require quantum time `2^Ω(n)` even for a quantum computer — unlike the ECDLP which Shor's algorithm solves in polynomial time.

**Key generation (ML-KEM-768, k=3):**

```
ρ, σ ← random seeds (32 bytes each)
A ← Sam(ρ)           — deterministic k×k matrix from ρ via SHAKE-128
s ← CBD(σ, 0..k-1)  — secret vector: k small polynomials from centered binomial
e ← CBD(σ, k..2k-1) — error vector
t = A·s + e          — public key component (mod q, NTT domain)

Public key:  pk = (t, ρ)      [800 bytes for k=3]
Secret key:  sk = (s, pk, H(pk), z)   [2400 bytes for k=3]
```

The public key encodes the "noisy" linear relation; `H(pk)` and `z` are used in the CCA2 transform.

**Encapsulation:**

```
m ← random 32-byte message
(K̄, r) = G(m || H(pk))     — G = SHA3-512; r is the encapsulation randomness
(u, v) = Kyber.CPA.Enc(pk, m; r)   — ciphertext components
K = KDF(K̄ || H(u || v))   — final shared secret
return (K, ct = u || v)
```

Encapsulation is deterministic given `m` and `pk`; the random `m` is generated by the encapsulator and bound to the ciphertext via `H(pk)`.

**Decapsulation (CCA2-secure via implicit rejection):**

```
m' = Kyber.CPA.Dec(sk, ct)
(K̄', r') = G(m' || H(pk))
ct' = Kyber.CPA.Enc(pk, m'; r')
if ct' == ct:  K = KDF(K̄' || H(ct))
else:          K = KDF(z || H(ct))   — implicit rejection: random-looking key
```

The implicit rejection (`z` is a random value in the secret key) ensures that a wrong ciphertext produces a pseudorandom output indistinguishable from a real shared secret — preventing chosen-ciphertext attacks that test decapsulation outcomes.

**Security levels and parameters (FIPS 203):**

| Parameter set | k | Security level | pk size | ct size | ss size |
|---------------|---|----------------|---------|---------|---------|
| **ML-KEM-512** | 2 | Category 1 (AES-128 equivalent) | 800 B | 768 B | 32 B |
| **ML-KEM-768** | 3 | Category 3 (AES-192 equivalent) | 1184 B | 1088 B | 32 B |
| **ML-KEM-1024** | 4 | Category 5 (AES-256 equivalent) | 1568 B | 1568 B | 32 B |

**NTT optimization:** All polynomial multiplications use the Number Theoretic Transform (NTT) over `Z_3329`, reducing convolution from `O(n²)` to `O(n log n)`. The choice of `q = 3329` and `n = 256` is carefully selected so that the NTT factors exist in `Z_q`.

**State of the art:** FIPS 203 (NIST, August 2024) [[1]](https://doi.org/10.6028/NIST.FIPS.203); Kyber specification paper [[2]](https://pq-crystals.org/kyber/data/kyber-specification-round3-20210804.pdf); security analysis [[3]](https://eprint.iacr.org/2017/634). Deployed in: OpenSSL 3.x (via OQS), BoringSSL, AWS-LC, libsodium (planned), Go 1.23+ (`crypto/mlkem`). Related to [Post-Quantum Key Exchange (Hybrid KEM)](#post-quantum-key-exchange-in-practice-hybrid-kem), [KEM Combiner Constructions](#kem-combiner-constructions), and [Post-Quantum Cryptography](15-quantum-cryptography.md#quantum-cryptography--post-quantum).

**Production readiness:** Production
FIPS 203 standardized (August 2024); deployed in Chrome (BoringSSL), AWS-LC, Go 1.23+, and Signal (via Kyber-1024).

**Implementations:**
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, ML-KEM in TLS 1.3
- [AWS-LC](https://github.com/aws/aws-lc) ⭐ 731 — C, FIPS 203 ML-KEM
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, ML-KEM-512/768/1024
- [Go crypto/mlkem](https://github.com/golang/go/tree/master/src/crypto/mlkem) ⭐ 133k — Go, standard library ML-KEM (Go 1.23+)
- [pqcrypto](https://github.com/rustpq/pqcrypto) ⭐ 390 — Rust, ML-KEM implementations

**Security status:** Secure
NIST-standardized (FIPS 203); extensive cryptanalysis over 7+ years; no known practical attacks on MLWE at recommended parameters.

**Community acceptance:** Standard
NIST FIPS 203 (August 2024); IANA-registered TLS codepoints; deployed by Google, AWS, Cloudflare, and Signal.

---

### ZRTP (Media Path Key Agreement for Secure RTP)

**Goal:** Negotiate encryption keys for VoIP calls directly in the media path, without relying on PKI or signaling-layer trust, using ephemeral Diffie-Hellman with verbal Short Authentication String (SAS) verification.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ZRTP** | 2011 | Ephemeral DH + SAS | RFC 6189; media-path key agreement for SRTP; no PKI required [[1]](https://www.rfc-editor.org/rfc/rfc6189.html) |
| **ZRTP SAS verification** | 2011 | Human-readable hash | Users verbally compare a short string to detect MitM; continuity via cached shared secrets [[1]](https://www.rfc-editor.org/rfc/rfc6189.html) |
| **ZRTP Multistream** | 2011 | Derived keys | Additional media streams derive keys from the initial ZRTP session [[1]](https://www.rfc-editor.org/rfc/rfc6189.html) |

**State of the art:** RFC 6189 (April 2011); designed by Phil Zimmermann (PGP creator) [[1]](https://www.rfc-editor.org/rfc/rfc6189.html). Provides perfect forward secrecy by destroying ephemeral keys after each call. Used in Signal (legacy), Ozone, Ozone, and various secure VoIP clients. Zimmermann blog post [[2]](https://blog.cryptographyengineering.com/2012/11/24/lets-talk-about-zrtp/). Related to [Key Exchange](#key-exchange--key-agreement) and [Noise Protocol Framework](#noise-protocol-framework).

**Production readiness:** Mature
Deployed in Ozone and various secure VoIP clients; Signal used ZRTP in early versions before migrating to its own protocol.

**Implementations:**
- [bzrtp](https://gitlab.linphone.org/BC/public/bzrtp) — C, ZRTP library used by Linphone
- [ozone-ozone SDK](https://ozone.org/) — C/Java, secure VoIP SDK with built-in ZRTP support

**Security status:** Secure
Ephemeral DH with forward secrecy; SAS verification detects MitM; no known cryptographic attacks on the protocol.

**Community acceptance:** Niche
IETF RFC 6189 (Informational); used in niche secure VoIP applications; largely superseded by Signal Protocol and WebRTC DTLS-SRTP for new deployments.

---

### EDHOC (Ephemeral Diffie-Hellman Over COSE, RFC 9528)

**Goal:** Provide a lightweight authenticated key exchange optimized for constrained IoT devices, using CBOR encoding and COSE cryptography to minimize message sizes and code footprint.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **EDHOC Method 0** | 2024 | Signature + Signature | Both parties authenticate with signatures; most general [[1]](https://www.rfc-editor.org/rfc/rfc9528.html) |
| **EDHOC Method 1** | 2024 | Signature + Static DH | Initiator signs, responder uses static DH key; reduces responder cost [[1]](https://www.rfc-editor.org/rfc/rfc9528.html) |
| **EDHOC Method 2** | 2024 | Static DH + Signature | Initiator uses static DH, responder signs [[1]](https://www.rfc-editor.org/rfc/rfc9528.html) |
| **EDHOC Method 3** | 2024 | Static DH + Static DH | Both parties use static DH keys; smallest messages, no signatures [[1]](https://www.rfc-editor.org/rfc/rfc9528.html) |

**State of the art:** RFC 9528 (IETF LAKE WG, March 2024) [[1]](https://datatracker.ietf.org/doc/rfc9528/). Designed for networks like 6TiSCH, LoRaWAN, and Cellular IoT where bandwidth is extremely constrained. Establishes OSCORE security contexts in as few as 101 bytes total exchange. Implementations in Rust (lakers), C (libedhoc), and Java [[2]](https://github.com/lake-rs/lakers). IETF blog post [[3]](https://www.ietf.org/blog/edhoc/). Related to [Key Exchange](#key-exchange--key-agreement) and [SIGMA Protocol](#sigma-protocol-sign-and-mac).

**Production readiness:** Experimental
RFC 9528 published March 2024; implementations exist but large-scale production deployment is nascent in IoT networks.

**Implementations:**
- [lakers](https://github.com/lake-rs/lakers) ⭐ 31 — Rust, EDHOC implementation for constrained devices
- [libedhoc](https://github.com/eriptic/uoscore-uedhoc) ⭐ 26 — C, EDHOC + OSCORE for embedded systems
- [californium-edhoc](https://github.com/rikard-sics/californium) ⭐ 5 — Java, EDHOC for CoAP

**Security status:** Secure
Formal analysis by IETF LAKE WG; SIGMA-inspired construction with mutual authentication and forward secrecy; no known attacks.

**Community acceptance:** Emerging
IETF RFC 9528 (2024); designed for 6TiSCH, LoRaWAN, and constrained IoT; gaining adoption as the lightweight alternative to DTLS 1.3.

---

### SIDH / SIKE (Broken Isogeny-Based Key Exchange)

**Goal:** Provide a post-quantum key exchange based on supersingular isogeny graphs -- broken in 2022 by the Castryck-Decru attack and included here as a cautionary historical reference.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SIDH** | 2011 | Supersingular isogenies | Original isogeny-based DH analog; auxiliary torsion points shared [[1]](https://eprint.iacr.org/2011/506) |
| **SIKE** | 2017 | SIDH + FO transform | IND-CCA2 KEM built on SIDH; NIST Round 4 candidate [[1]](https://sike.org/) |
| **Castryck-Decru attack** | 2022 | Kani's glue-and-split | Recovers secret isogeny in polynomial time using auxiliary point info; breaks all SIKE parameters [[1]](https://eprint.iacr.org/2022/975) |

**State of the art:** SIKE and SIDH are broken and must not be used [[1]](https://www.schneier.com/blog/archives/2022/08/sike-broken.html). The Castryck-Decru attack (July 2022) breaks SIKEp434 in ~1 hour on a single core by exploiting the auxiliary torsion point information inherent to the SIDH protocol structure. NIST immediately withdrew SIKE from consideration. The attack does not affect other isogeny schemes (CSIDH, SQISign) that do not reveal auxiliary points [[2]](https://eprint.iacr.org/2022/975.pdf). Related to [Non-Interactive Key Exchange (NIKE)](#non-interactive-key-exchange-nike) and [Post-Quantum Cryptography](15-quantum-cryptography.md#quantum-cryptography--post-quantum).

**Production readiness:** Deprecated
Broken by Castryck-Decru attack (July 2022); NIST withdrew SIKE; must not be used.

**Implementations:**
- [sike.org](https://sike.org/) — C, reference SIKE implementation (archived, broken)
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, SIKE removed after break

**Security status:** Broken
Castryck-Decru attack (2022) recovers the secret isogeny in polynomial time; all SIKE/SIDH parameters are broken.

**Community acceptance:** Niche
Withdrawn from NIST PQ competition; retained as a cautionary historical reference; does not affect CSIDH or SQISign.

---


## Password-Based Key Exchange (PAKE)

---
### Password-Based Key Derivation (KDF / PAKE)

**Goal:** Derive strong cryptographic keys from weak passwords, or authenticate over a password without exposing it to the server.

### Key Derivation Functions (KDF)

| Algorithm | Year | Note |
|-----------|------|------|
| **Argon2id** | 2015 | PHC winner (2015); memory-hard; recommended default [[1]](https://github.com/P-H-C/phc-winner-argon2/blob/master/argon2-specs.pdf) |
| **scrypt** | 2009 | Memory-hard; used in Litecoin, Tarsnap [[1]](https://www.tarsnap.com/scrypt/scrypt.pdf) |
| **bcrypt** | 1999 | Classic; Blowfish-based; still widely deployed [[1]](https://www.usenix.org/legacy/publications/library/proceedings/usenix99/provos/provos.pdf) |
| **HKDF** | 2010 | Extract-then-expand; not for passwords; RFC 5869 [[1]](https://www.rfc-editor.org/rfc/rfc5869) |
| **Balloon Hashing** | 2016 | Provably memory-hard; NIST candidate [[1]](https://eprint.iacr.org/2016/027) |

### Password-Authenticated Key Exchange (PAKE)

| Protocol | Year | Note |
|----------|------|------|
| **OPAQUE** | 2018 | Asymmetric PAKE; server never sees password; IETF draft [[1]](https://eprint.iacr.org/2018/163) |
| **SPAKE2** | 2005 | Symmetric PAKE; simple, round-efficient; RFC 9382 [[1]](https://eprint.iacr.org/2005/096) |
| **SRP** | 2000 | Legacy PAKE; TLS-SRP; widely deployed [[1]](https://www.rfc-editor.org/rfc/rfc2945) |
| **CPace** | 2018 | Balanced PAKE; IETF draft; provably secure in UC model [[1]](https://eprint.iacr.org/2018/286) |
| **Threshold PAKE (TPAKE)** | 2006 | Distributed: t-of-n servers jointly authenticate; no single server holds password file [[1]](https://eprint.iacr.org/2006/440) |

**State of the art:** Argon2id (password hashing), OPAQUE (asymmetric PAKE), TPAKE for distributed password authentication.

**Production readiness:** Production
Argon2id is the PHC winner and default in most modern frameworks; OPAQUE is nearing IETF standardization with production implementations.

**Implementations:**
- [argon2](https://github.com/P-H-C/phc-winner-argon2) ⭐ 5.2k — C, reference Argon2 implementation
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Argon2id built-in
- [bcrypt (OpenBSD)](https://github.com/openbsd/src/blob/master/lib/libc/crypt/bcrypt.c) ⭐ 3.7k — C, original bcrypt
- [opaque-ke](https://github.com/facebook/opaque-ke) ⭐ 386 — Rust, OPAQUE protocol
- [scrypt (tarsnap)](https://github.com/Tarsnap/scrypt) ⭐ 509 — C, reference scrypt

**Security status:** Secure
Argon2id and OPAQUE are secure at recommended parameters; bcrypt and scrypt remain safe with adequate cost factors.

**Community acceptance:** Standard
Argon2id is RFC 9106; HKDF is RFC 5869; scrypt is RFC 7914; OPAQUE is an IETF CFRG draft; SPAKE2 is RFC 9382.

---

### Password Hardened Encryption (PHE)

**Goal:** Two-factor encryption. Decryption requires both the user's password and a server-side key. A server breach alone is useless (no password); a password brute-force alone is useless (no server key). The server never sees plaintext.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lai-Tlejben-Abel-Polyakov PHE** | 2018 | OPRF + AE | PHE from oblivious PRF; server evaluates OPRF on password [[1]](https://eprint.iacr.org/2018/003) |
| **Pythia PRF** | 2015 | Partially-oblivious PRF | Server-side key-rotation without re-encrypting; verifiable [[1]](https://eprint.iacr.org/2015/644) |
| **OPAQUE (as PHE)** | 2018 | aPAKE | Can serve as PHE base: server stores password file, client derives key [[1]](https://eprint.iacr.org/2018/163) |

**State of the art:** PHE (Lai et al. 2018); deployed by Virgil Security. Related to [OPRF](10-privacy-preserving-computation.md#oblivious-prf-oprf) and [PAKE](#password-based-key-derivation-kdf--pake).

**Production readiness:** Experimental
Deployed by Virgil Security in their PHE service; limited adoption beyond that.

**Implementations:**
- [virgil-phe-go](https://github.com/VirgilSecurity/virgil-phe-go) ⭐ 16 — Go, Virgil Security PHE implementation

**Security status:** Secure
Based on OPRF with standard elliptic-curve assumptions; no known practical attacks at recommended parameters.

**Community acceptance:** Niche
Published at academic venues; Virgil Security is the primary commercial backer; no IETF or NIST standardization.

---

### Dragonfly Handshake / SAE (Simultaneous Authentication of Equals)

**Goal:** A zero-knowledge password-authenticated key exchange for peer-to-peer settings where neither party holds a password verifier — both parties hold the password directly — providing mutual authentication and forward secrecy with resistance to offline dictionary attacks and active impersonation.

The Dragonfly handshake, designed by Dan Harkins, is the cryptographic protocol underlying IEEE 802.11-2016 SAE (Simultaneous Authentication of Equals), which replaced the vulnerable WPA2-PSK 4-way handshake in WPA3. SAE eliminates the KRACK and PMKID offline dictionary attack vulnerabilities of WPA2.

**Protocol sketch (over a prime-order group or elliptic curve):**

```
Both parties: PE = map_password_to_element(password, MAC_A, MAC_B)
  — deterministic but requires knowing password; resists offline attack

Commit phase:
  Alice: r, mask ←$ Zq,  scalar = (r+mask) mod q,  element = PE^(-mask)
         sends (scalar_A, element_A)
  Bob:   same computation with r_B, mask_B
         sends (scalar_B, element_B)

Confirm phase:
  Both compute: K = KDF(PE^(r_A·scalar_B + r_B·scalar_A), ...)
  Alice sends:  token_A = MAC_K(scalar_A, element_A, scalar_B, element_B)
  Bob verifies token_A; sends token_B; Alice verifies
```

**Security properties:**

| Property | Mechanism |
|----------|-----------|
| Offline dictionary attack resistance | PE derivation is slow (hash-to-curve); no offline test |
| Forward secrecy | Ephemeral r values; session key not derivable from password alone |
| Mutual authentication | Both parties verify MAC tokens under K |
| Denial-of-service resistance | Anti-clogging token (ACT) for stateless cookie |

| Deployment | Specification |
|------------|--------------|
| **WPA3-Personal** | IEEE 802.11-2016 SAE; mandatory in Wi-Fi 6 [[1]](https://standards.ieee.org/ieee/802.11/7028/) |
| **EAP-pwd (RFC 5931)** | Dragonfly over EAP for enterprise Wi-Fi [[1]](https://www.rfc-editor.org/rfc/rfc5931) |
| **RFC 7664** | IETF informational specification of Dragonfly [[1]](https://www.rfc-editor.org/rfc/rfc7664) |

**WPA2 vs WPA3 comparison:**

| | WPA2-PSK | WPA3-SAE |
|-|----------|----------|
| Handshake | 4-way (EAPOL) | SAE commit/confirm |
| Offline dictionary attack | Vulnerable (PMKID) | Resistant |
| Forward secrecy | No | Yes |
| KRACK vulnerable | Yes | No |

**State of the art:** WPA3 certification mandatory for Wi-Fi 6/6E devices (Wi-Fi Alliance 2020). Dragonfly is also used in EAP-pwd (RFC 5931) for RADIUS-based enterprise authentication. See [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake) and [SPEKE](#speke-simple-password-exponential-key-exchange).

**Production readiness:** Production
Mandatory in all Wi-Fi 6/6E certified devices; deployed in billions of consumer routers and devices.

**Implementations:**
- [hostapd](https://w1.fi/cgit/hostap/tree/src/common/sae.c) — C, SAE/Dragonfly in hostapd/wpa_supplicant
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, EAP-pwd/Dragonfly support

**Security status:** Caution
Dragonfly is secure against offline dictionary attacks but side-channel attacks (Dragonblood, 2019) demonstrated timing leaks in hash-to-curve; mitigations applied in updated implementations.

**Community acceptance:** Standard
IEEE 802.11-2016 SAE; RFC 7664; Wi-Fi Alliance WPA3 mandatory certification; RFC 5931 (EAP-pwd).

---

### SCEP (Simple Certificate Enrollment Protocol, RFC 8894)

**Goal:** Allow network devices (routers, printers, mobile clients) to automatically request and obtain X.509 certificates from a CA using only symmetric-key primitives available before a certificate exists — bootstrapping PKI enrollment with nothing more than a pre-shared challenge password.

SCEP was originally a Cisco proprietary protocol (draft-nourse-scep) widely deployed in network device enrollment. RFC 8894 (2020) standardized and updated it. SCEP is intentionally simple: it wraps PKCS#7 (CMS) messages over HTTP, requiring only an OTP (challenge password) to prove identity during initial enrollment.

**Protocol flow:**

```
1. Device generates RSA or EC key pair locally
2. Device fetches CA certificate:
      GET /cgi-bin/pkiclient.exe?operation=GetCACert
      ← CA cert (DER) or chain (PKCS#7)

3. Device sends CSR (PKCS#10) wrapped in PKCS#7 SignedData:
      PKCSReq message:
        - Outer SignedData: signed with self-signed cert (proves key possession)
        - Inner EnvelopedData: encrypted to CA's public key
        - challengePassword attribute: OTP issued out-of-band

4. CA responds:
      CertRep: SUCCESS → issued cert in SignedData
               PENDING → enrollment queued (manual approval)
               FAILURE → error code
```

**Message types (SCEP OIDs):**

| Message | OID | Purpose |
|---------|-----|---------|
| **PKCSReq** | 3 | Initial enrollment CSR |
| **CertRep** | 3 | CA's response (cert or error) |
| **GetCertInitial** | 20 | Poll when PENDING |
| **GetCert** | 21 | Fetch cert by issuer+serial |
| **GetCRL** | 22 | Fetch CRL |

**Cryptographic structure:**

Each SCEP message is a CMS SignedData wrapping a CMS EnvelopedData (for requests) or vice versa. The outer SignedData authenticates the sender; the inner EnvelopedData encrypts the payload to the recipient's certificate.

**Security considerations:**
- Challenge password transmitted inside EnvelopedData (encrypted to CA key) — not in the clear
- Self-signed cert used for initial request signature; CA verifies challenge password instead of cert chain
- RFC 8894 mandates TLS for transport (earlier deployments used plain HTTP)
- No renewal automation — contrast with [ACME](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management)

| Deployment | Usage |
|------------|-------|
| **Cisco IOS / ASA** | Network device cert enrollment |
| **Microsoft NDES** | Network Device Enrollment Service (Windows Server) |
| **Apple MDM** | iOS/macOS device certificate provisioning via MDM payload |
| **strongSwan** | Linux IPsec gateway auto-enrollment |

**State of the art:** RFC 8894 (2020) [[1]](https://www.rfc-editor.org/rfc/rfc8894). Widely deployed in MDM and network device PKI; simpler than [CMP](#cmp-certificate-management-protocol-rfc-42109483) but less feature-rich. Being supplemented by [EST](#est-enrollment-over-secure-transport-rfc-7030) in newer deployments. Related to [ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management) and [PKIX / X.509 v3](#pkix--x509-v3-certificate-profile-rfc-5280).

**Production readiness:** Production
Deployed in Cisco IOS, Microsoft NDES, Apple MDM, and strongSwan for network device certificate enrollment.

**Implementations:**
- [sscep](https://github.com/certnanny/sscep) ⭐ 196 — C, open-source SCEP client
- [micromdm/scep](https://github.com/micromdm/scep) ⭐ 373 — Go, SCEP server and client library
- [jscep](https://github.com/jscep/jscep) ⭐ 130 — Java, SCEP client library

**Security status:** Caution
Challenge passwords must be protected; early deployments used plain HTTP (now RFC 8894 mandates TLS); no automated renewal.

**Community acceptance:** Standard
IETF RFC 8894; widely deployed in enterprise MDM (Apple, Microsoft) and network device PKI (Cisco).

---

### PKCS#12 / PFX (Private Key + Certificate Bundle)

**Goal:** A portable, password-encrypted container format that packages a private key, its corresponding certificate, and any intermediate CA certificates into a single binary file — enabling one-click import/export of a complete cryptographic identity across browsers, servers, and operating systems.

PKCS#12 (originally PFX — Personal inFormation eXchange) was developed by Microsoft and standardized by RSA Security; it is now maintained as RFC 7292 (2014). Despite being notoriously complex (layered ASN.1 with multiple encryption and integrity mechanisms), it remains the universal interchange format: every web server, browser, HSM, and mobile OS can read and write `.p12` / `.pfx` files.

**File structure (nested ASN.1):**

```
PFX ::= SEQUENCE {
  version    INTEGER (v3 = 3),
  authSafe   ContentInfo,       -- PKCS#7 Data or EncryptedData
  macData    MacData OPTIONAL   -- HMAC-SHA1/256 over authSafe
}

authSafe contains a SEQUENCE OF SafeContents, each a PKCS#7 wrapper:
  SafeBag types:
    keyBag          — unencrypted PKCS#8 PrivateKeyInfo
    pkcs8ShroudedKeyBag — password-encrypted PKCS#8 (PBES2 recommended)
    certBag         — DER certificate (X.509 or SDSI)
    crlBag          — DER CRL
    safeContentsBag — nested SafeContents (recursive)
```

**Encryption layers:**

| Layer | Algorithm (legacy) | Algorithm (modern) |
|-------|-------------------|-------------------|
| Key encryption | PBEWithSHAAnd3-KeyTripleDES-CBC | PBES2: PBKDF2-SHA256 + AES-256-CBC |
| Cert encryption | PBEWithSHAAnd40BitRC2-CBC (export-grade!) | PBES2: PBKDF2-SHA256 + AES-256-CBC |
| MAC integrity | HMAC-SHA1 | HMAC-SHA256 |
| KDF | PKCS#12-KDF (proprietary, fragile) | PBKDF2 (RFC 8018) |

**PKCS#12-KDF flaw:** The legacy key-derivation function (Appendix B of RFC 7292) is a SHA-1-based construction designed for export-grade restrictions; it is not PBKDF2-compatible and produces weak key material. Modern tools (OpenSSL 3.x with `-legacy` removed, macOS Keychain, iOS 16+) default to PBES2/PBKDF2-SHA256.

**Friendly name and local key ID (PKCS#9 attributes):**

Each SafeBag carries optional attributes linking keys to certificates:
- `friendlyName` (UTF8String): human-readable label, e.g., `"My TLS Certificate"`
- `localKeyId` (OCTET STRING): matching key and cert bags by shared byte string

**Common operations:**

```bash
# Export cert + key from PEM to PKCS#12
openssl pkcs12 -export -out bundle.p12 \
  -inkey private.key -in cert.pem -certfile chain.pem

# Import PKCS#12; extract PEM
openssl pkcs12 -in bundle.p12 -nodes -out combined.pem
```

**Security considerations:**
- Weak legacy KDF + short passwords make offline brute-force feasible; use long random passwords
- Some implementations accept PKCS#12 without verifying the MAC — allowing cert substitution
- JKS (Java KeyStore) is a Java-specific alternative; P12 is now preferred (Java 9+)
- PKCS#8 (RFC 5958) + PEM is a simpler format for key-only storage without bundling

| Format | Contents | Use case |
|--------|----------|----------|
| **.p12 / .pfx** | Key + cert + chain | Full identity transport |
| **.pem** | Any (base64 DER) | Server config; human-readable |
| **.der** | Single object (binary) | Cert-only; embedded devices |
| **JKS / PKCS#11** | Key store (Java / HSM) | Java apps; hardware tokens |

**State of the art:** RFC 7292 (2014) [[1]](https://www.rfc-editor.org/rfc/rfc7292); PBES2 migration tracked in RFC 9579 (2024) which updates PKCS#12 to mandate PBKDF2 and AES. Supported natively by Windows (CertMgr), macOS Keychain, iOS, Android, Firefox, and all major TLS servers. Related to [PKIX / X.509 v3](#pkix--x509-v3-certificate-profile-rfc-5280), [ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management), and [Key Wrapping / Envelope Encryption](#key-wrapping--envelope-encryption).

**Production readiness:** Production
Universal interchange format supported by every OS, browser, and TLS server; the standard for key+certificate bundling.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, PKCS#12 creation and parsing
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive PKCS#12 support
- [Go x/crypto/pkcs12](https://github.com/golang/crypto) ⭐ 3.3k — Go, PKCS#12 parsing
- [NSS](https://github.com/nss-dev/nss) ⭐ 178 — C, Mozilla's PKCS#12 handling

**Security status:** Caution
Legacy PKCS#12-KDF and RC2/3DES encryption are weak; RFC 9579 mandates PBES2 with PBKDF2-SHA256 + AES-256; use long random passwords.

**Community acceptance:** Standard
RFC 7292; RFC 9579 (modern update); universally supported across all platforms and crypto libraries.

---

### PBKDF2 / Password-Based Cryptography (PKCS#5 / RFC 8018)

**Goal:** Derive a cryptographic key of arbitrary length from a password by repeatedly applying a pseudorandom function (PRF) with a salt and an iteration count — making brute-force and dictionary attacks computationally expensive while remaining deterministic for legitimate use.

PBKDF2 (Password-Based Key Derivation Function 2) was specified by RSA Security in PKCS#5 v2.0 (1999), later republished as RFC 2898 and updated by RFC 8018 (2017). It is the NIST-recommended password KDF (SP 800-132) and underlies LUKS disk encryption, WPA2-PSK Wi-Fi, iOS data protection, PKCS#12 (see [PKCS#12 / PFX](#pkcs12--pfx-private-key--certificate-bundle)), and SLIP-39.

**Algorithm (PBKDF2-HMAC-SHA256):**

```
DK = T1 || T2 || ... || Tdklen/hlen⌉

Ti = U1 XOR U2 XOR ... XOR Uc

U1 = PRF(Password, Salt || INT(i))
U2 = PRF(Password, U1)
...
Uc = PRF(Password, Uc-1)
```

where `PRF = HMAC-SHA256`, `c` = iteration count, `Salt` is a random 16-byte value, and `i` is the block index. The output `DK` can be any length by concatenating blocks.

**Parameters (NIST SP 800-132 recommendations):**

| Parameter | Minimum | Recommended (2024) |
|-----------|---------|-------------------|
| Salt length | 128 bits | 128–256 bits |
| Iteration count (c) | 1,000 | 600,000 (SHA-256); 100,000 (SHA-512) |
| Output length | PRF output size | Match target key size |
| PRF | HMAC-SHA-1 (legacy) | HMAC-SHA-256 or HMAC-SHA-512 |

**Key derivation example (OpenSSL / Python):**

```python
import hashlib, os
salt = os.urandom(16)
dk = hashlib.pbkdf2_hmac('sha256', b'password', salt, iterations=600_000, dklen=32)
```

**PBKDF2 weaknesses:** Unlike Argon2id or scrypt, PBKDF2 is not memory-hard — it can be parallelized cheaply on GPUs and ASICs. At 600k iterations, a modern GPU achieves ~10⁶ guesses/second against PBKDF2-SHA256 versus ~10³/second against Argon2id. PBKDF2 is therefore appropriate only where memory-hard KDFs are unavailable (e.g., FIPS-constrained environments, hardware tokens).

**Deployments:**

| System | PBKDF2 usage |
|--------|-------------|
| WPA2-PSK | PBKDF2-HMAC-SHA1 (4096 iterations) over SSID+passphrase → PMK [[1]](https://www.rfc-editor.org/rfc/rfc4764) |
| iOS Data Protection | PBKDF2-SHA256 (tens of millions of iterations, hardware-assisted) |
| PKCS#12 / PBES2 | PBKDF2-SHA256 + AES-256-CBC for key bags (RFC 9579) [[1]](https://www.rfc-editor.org/rfc/rfc9579) |
| SLIP-39 | PBKDF2-HMAC-SHA256 (10,000 iterations) for passphrase encryption of master secret |
| Django / Spring | Default password hasher (PBKDF2-SHA256, 600k+ iterations) |

**State of the art:** RFC 8018 (2017) [[1]](https://www.rfc-editor.org/rfc/rfc8018); NIST SP 800-132 [[2]](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-132.pdf). For new password storage, prefer Argon2id. PBKDF2 remains the correct choice for FIPS 140-3 environments and hardware tokens where memory-hard KDFs are infeasible. See [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake) and the [KDF Comparison](#kdf-comparison-pbkdf2-vs-bcrypt-vs-scrypt-vs-argon2id) section below.

**Production readiness:** Production
PBKDF2 is deployed in WPA2-PSK, iOS Data Protection, PKCS#12/PBES2, Django, Spring, and FIPS 140-3 environments globally.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, PBKDF2 with HMAC-SHA-256/512
- [Python hashlib](https://docs.python.org/3/library/hashlib.html) — Python, built-in `pbkdf2_hmac`
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, PBKDF2 implementation
- [Go x/crypto/pbkdf2](https://github.com/golang/crypto) ⭐ 3.3k — Go, PBKDF2 package
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, PBKDF2 support (Argon2id preferred)

**Security status:** Caution
Secure at high iteration counts (600k+) but not memory-hard; vulnerable to GPU/ASIC parallelization; prefer Argon2id for new designs.

**Community acceptance:** Standard
NIST SP 800-132; IETF RFC 8018; FIPS 140-3 approved; universally deployed but being supplemented by memory-hard KDFs.

---

### KDF Comparison: PBKDF2 vs bcrypt vs scrypt vs Argon2id

**Goal:** Select the right password-hashing KDF by understanding the security/compatibility tradeoffs — memory-hardness, FPGA/ASIC resistance, parallelism limits, FIPS compliance, and practical throughput — so that legitimate authentication remains fast while offline cracking remains expensive.

All four functions deliberately introduce work to slow brute-force attacks, but they differ in *which* resource they tax. The fundamental insight of memory-hard KDFs (scrypt, Argon2) is that memory is orders of magnitude more expensive than compute on custom silicon, so making a KDF require gigabytes of RAM equalises the cost between defenders (commodity servers) and attackers (ASIC farms).

**Comparison table:**

| Property | PBKDF2 | bcrypt | scrypt | Argon2id |
|----------|--------|--------|--------|----------|
| Year | 1999 | 1999 | 2009 | 2015 (PHC winner) |
| Memory-hard | No | No (64 B state) | Yes (N·128·r bytes) | Yes (m kibibytes) |
| ASIC/GPU resistance | Low | Moderate | High | Very high |
| Parameters | iterations c, PRF | cost factor 2^n | N, r, p | m, t, p |
| Max output length | Arbitrary | 60-char string | Arbitrary | Arbitrary |
| FIPS 140-3 compliant | Yes (HMAC-SHA-256) | No | No | No |
| Password length limit | None | 72 bytes (Blowfish) | None | None |
| Parallelism | Easy (GPU) | Difficult (sequential) | Configurable (p param) | Configurable (p param) |
| Side-channel risks | Low | Timing via Blowfish | Cache-timing (s-boxes) | Low (Argon2id mixes data/key) |
| RFC/Standard | RFC 8018 | — | RFC 7914 | RFC 9106 |

**When to use each:**

| Use case | Recommended KDF |
|----------|----------------|
| New password storage (general) | Argon2id (m=64 MiB, t=3, p=4) |
| FIPS 140-3 / government | PBKDF2-SHA256 (≥600k iterations) |
| Legacy systems / interop | bcrypt (cost=12) |
| High-value secrets, hardware wallets | scrypt (N=2²⁰, r=8, p=1) |
| Disk encryption (interactive) | Argon2id or scrypt |

**Argon2 variants:**

| Variant | Defense |
|---------|---------|
| Argon2d | Data-dependent memory access; best ASIC resistance; vulnerable to side-channel |
| Argon2i | Data-independent; side-channel safe; weaker ASIC resistance |
| **Argon2id** | First half Argon2i, second half Argon2d; best of both; recommended default |

**OWASP minimum parameters (2024):**
- Argon2id: m=19 MiB, t=2, p=1 (minimum); m=64 MiB, t=3 preferred
- bcrypt: cost factor ≥ 10 (12 preferred)
- scrypt: N=2¹⁴ minimum; N=2²⁰ for high-value secrets
- PBKDF2-SHA256: ≥ 600,000 iterations

**State of the art:** Argon2id (RFC 9106, 2021) [[1]](https://www.rfc-editor.org/rfc/rfc9106) is the recommended default for all new systems. PHC (Password Hashing Competition) final report [[2]](https://github.com/P-H-C/phc-winner-argon2). OWASP Password Storage Cheat Sheet [[3]](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html). Related to [PBKDF2 / Password-Based Cryptography](#pbkdf2--password-based-cryptography-pkcs5--rfc-8018) and [Password-Based Key Derivation (KDF / PAKE)](#password-based-key-derivation-kdf--pake).

**Production readiness:** Production
All four KDFs are deployed at scale; Argon2id is the PHC winner and modern default; PBKDF2 dominates FIPS environments; bcrypt is ubiquitous in web frameworks.

**Implementations:**
- [argon2](https://github.com/P-H-C/phc-winner-argon2) ⭐ 5.2k — C, reference Argon2 implementation
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, Argon2id built-in
- [bcrypt (OpenBSD)](https://github.com/openbsd/src/blob/master/lib/libc/crypt/bcrypt.c) ⭐ 3.7k — C, original bcrypt
- [scrypt (tarsnap)](https://github.com/Tarsnap/scrypt) ⭐ 509 — C, reference scrypt
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, PBKDF2 with HMAC-SHA-256/512

**Security status:** Secure
Argon2id is the strongest general-purpose password KDF; all four are secure at OWASP-recommended parameters; PBKDF2 lacks memory-hardness.

**Community acceptance:** Standard
Argon2id is RFC 9106 and PHC winner; PBKDF2 is NIST SP 800-132 / RFC 8018; scrypt is RFC 7914; bcrypt is a de facto standard; OWASP endorses all four with appropriate parameters.

---


## Key Derivation and Wrapping

---
### Hierarchical Deterministic Keys (BIP32 / HD Wallets)

**Goal:** Structured key derivation. From a single master seed, deterministically derive an entire tree of key pairs. Each branch can be delegated (extended public key) without exposing the master. Standard in every cryptocurrency wallet.

| Standard | Year | Basis | Note |
|----------|------|-------|------|
| **BIP32 (HD Wallets)** | 2012 | HMAC-SHA512 + secp256k1 | Master seed → child key tree; supports extended public keys for watch-only [[1]](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) |
| **BIP44 (Multi-Account)** | 2014 | BIP32 + derivation paths | Standard paths: m/purpose'/coin'/account'/change/index [[1]](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) |
| **SLIP-10** | 2016 | BIP32 for Ed25519/NIST | Extend HD derivation to non-secp256k1 curves [[1]](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) |

**State of the art:** BIP32/44 (every Bitcoin/Ethereum wallet), SLIP-10 (Solana, Cardano, multi-curve wallets).

**Production readiness:** Production
BIP32/44 is deployed in every major cryptocurrency wallet; billions of dollars secured.

**Implementations:**
- [bitcoinjs-lib](https://github.com/bitcoinjs/bitcoinjs-lib) ⭐ 6.0k — JavaScript, BIP32/44 HD wallet derivation
- [python-bip32](https://github.com/darosior/python-bip32) ⭐ 51 — Python, BIP32 key derivation
- [rust-bitcoin](https://github.com/rust-bitcoin/rust-bitcoin) ⭐ 2.6k — Rust, BIP32 support
- [go-hdwallet](https://github.com/btcsuite/btcutil/tree/master/hdkeychain) ⭐ 483 — Go, BIP32 HD key chains
- [slip10](https://github.com/wusyong/slip10) ⭐ 9 — JavaScript, SLIP-10 key derivation

**Security status:** Secure
No known attacks on the HD derivation scheme; hardened derivation prevents child key compromise from revealing parent keys.

**Community acceptance:** Standard
BIP32/44 are Bitcoin Improvement Proposals adopted universally; SLIP-10 is a SatoshiLabs standard widely used across blockchains.

---

### Key Wrapping / Envelope Encryption

**Goal:** Protect keys with keys. Encrypt a secret key (DEK) under a key-encryption key (KEK), providing confidentiality + integrity for key material. Standard pattern in HSMs, cloud KMS, and key hierarchies.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **AES-KW (Key Wrap)** | 2001 | AES + Feistel | NIST SP 800-38F; RFC 3394; 64-bit integrity check [[1]](https://www.rfc-editor.org/rfc/rfc3394) |
| **AES-KWP (Key Wrap with Padding)** | 2001 | AES-KW + padding | For non-aligned key sizes; RFC 5649 [[1]](https://www.rfc-editor.org/rfc/rfc5649) |
| **Envelope Encryption** | 2006 | KEM + DEK pattern | AWS KMS / GCP CMEK pattern: wrap DEK with KEK; store wrapped DEK alongside data [[1]](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#enveloping) |
| **SIV for Key Wrapping** | 2006 | AES-SIV | Misuse-resistant alternative; see [Deterministic Encryption](02-authenticated-structured-encryption.md#deterministic-encryption--convergent-encryption) [[1]](https://www.rfc-editor.org/rfc/rfc5297) |

**State of the art:** AES-KW (NIST/HSMs), Envelope Encryption (all major cloud KMS).

**Production readiness:** Production
AES-KW is deployed in every major HSM and cloud KMS; envelope encryption is the standard pattern in AWS KMS, GCP CMEK, and Azure Key Vault.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, AES-KW and AES-KWP support
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, AES key wrap
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, AES-KW/KWP and SIV
- [AWS Encryption SDK](https://github.com/aws/aws-encryption-sdk-java) ⭐ 237 — Java/Python, envelope encryption
- [Tink](https://github.com/tink-crypto/tink) ⭐ 13k — Java/Go/C++/Python, key wrapping primitives

**Security status:** Secure
AES-KW is NIST-approved (SP 800-38F) with no known practical attacks; AES-SIV provides misuse resistance.

**Community acceptance:** Standard
AES-KW is NIST SP 800-38F and RFC 3394/5649; envelope encryption is an industry-standard cloud pattern.

---

### HPKE (Hybrid Public Key Encryption, RFC 9180)

**Goal:** Provide a standardized, composable public-key encryption scheme that combines a KEM, KDF, and AEAD into a single abstraction usable across many protocols.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HPKE Base mode** | 2022 | KEM + KDF + AEAD | Sender encapsulates to recipient public key; no sender auth [[1]](https://www.rfc-editor.org/rfc/rfc9180.html) |
| **HPKE Auth mode** | 2022 | KEM + static sender key | Sender authenticates via KEM private key; no certificates needed [[1]](https://www.rfc-editor.org/rfc/rfc9180.html) |
| **HPKE PSK mode** | 2022 | KEM + pre-shared key | Authentication from high-entropy PSK; binds PSK into key schedule [[1]](https://www.rfc-editor.org/rfc/rfc9180.html) |
| **HPKE AuthPSK mode** | 2022 | KEM + sender key + PSK | Strongest mode: both sender-key and PSK authentication [[1]](https://www.rfc-editor.org/rfc/rfc9180.html) |

**State of the art:** RFC 9180 (IRTF CFRG, February 2022) [[1]](https://datatracker.ietf.org/doc/rfc9180/). HPKE is the encryption substrate for TLS Encrypted Client Hello (ECH), Oblivious DNS-over-HTTPS (ODoH), Oblivious HTTP (RFC 9458), and MLS (RFC 9420). Default instantiation: X25519 + HKDF-SHA256 + AES-128-GCM or ChaCha20-Poly1305. Cloudflare explainer [[2]](https://blog.cloudflare.com/hybrid-public-key-encryption/). Related to [KEM Combiner Constructions](#kem-combiner-constructions) and [Key Exchange](#key-exchange--key-agreement).

**Production readiness:** Production
HPKE is deployed in TLS ECH (Chrome, Firefox), Oblivious HTTP (RFC 9458), MLS (RFC 9420), and ODoH.

**Implementations:**
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, HPKE for TLS ECH
- [hpke (Rust)](https://github.com/rozbb/rust-hpke) ⭐ 86 — Rust, full HPKE implementation
- [hpke (Go)](https://github.com/cisco/go-hpke) ⭐ 30 — Go, Cisco's HPKE library
- [OpenSSL 3.x](https://github.com/openssl/openssl) ⭐ 29k — C, HPKE support
- [MLS libraries](https://github.com/openmls/openmls) ⭐ 905 — Rust, HPKE as MLS substrate

**Security status:** Secure
RFC 9180 with formal security analysis; no known attacks on the construction at recommended parameters.

**Community acceptance:** Standard
IRTF RFC 9180; used as building block in TLS ECH, MLS (RFC 9420), OHTTP (RFC 9458), and ODoH; widely adopted.

---


## Key Management Infrastructure

---
### Certificateless Cryptography

**Goal:** No certificates, no key escrow. Eliminates the heavy PKI of traditional public-key crypto AND the key-escrow problem of IBE. A KGC (Key Generation Center) provides partial keys, but the user adds their own secret — KGC alone cannot decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Al-Riyami-Paterson CL-PKE** | 2003 | Pairings | First certificateless PKE; KGC partial key + user secret [[1]](https://eprint.iacr.org/2003/126) |
| **CL-PKS (Certificateless Signatures)** | 2005 | Pairings | Certificateless signature scheme [[1]](https://eprint.iacr.org/2005/220) |
| **Self-Certified Keys (Girault)** | 1991 | RSA | Precursor: public key implicitly certified by its structure [[1]](https://doi.org/10.1007/3-540-46416-6_42) |

**State of the art:** Pairing-based CL-PKE; fills the gap between IBE (see [IBE](07-homomorphic-functional-encryption.md#identity-based-encryption-ibe)) and traditional PKI. Popular in IoT research where certificate management is expensive.

**Production readiness:** Research
Primarily academic; no large-scale production deployments outside IoT research prototypes.

**Implementations:**
- [RELIC](https://github.com/relic-toolkit/relic) ⭐ 508 — C, pairing-based crypto toolkit supporting CL-PKE building blocks
- [Charm](https://github.com/JHUISI/charm) ⭐ 633 — Python, prototyping framework for pairing-based schemes

**Security status:** Caution
Pairing-based CL-PKE schemes are provably secure under standard assumptions, but implementations require careful pairing parameter selection; not post-quantum secure.

**Community acceptance:** Niche
Active research area for IoT/sensor networks; no IETF or NIST standardization.

---

> **Certificate Transparency (CT)** is covered in [Applied Infrastructure PKI — Certificate Transparency](14-applied-infrastructure-pki.md#certificate-transparency-ct).

---

> **ACME Protocol / Automated Certificate Management** is covered in [Secure Communication Protocols — ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management).

---

### Key Transparency / CONIKS

**Goal:** Verifiable key directory. A public, append-only log that maps usernames to public keys — anyone can audit that the server hasn't secretly swapped someone's key. Prevents misbinding attacks where a server substitutes a malicious key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CONIKS** | 2015 | Merkle prefix tree | First key transparency system; users verify their own key bindings [[1]](https://eprint.iacr.org/2014/1004) |
| **Google Key Transparency** | 2017 | Sparse Merkle + VRF | Production system; verifiable log of key-to-account bindings [[1]](https://github.com/google/keytransparency) |
| **SEEMless (Meta)** | 2023 | Verifiable log | WhatsApp key transparency; Auditable Key Directory [[1]](https://engineering.fb.com/2023/04/13/security/whatsapp-key-transparency/) |
| **Signal Key Transparency** | 2024 | Merkle + monitoring | Detects key substitution in Signal's server [[1]](https://signal.org/blog/key-transparency/) |

**State of the art:** SEEMless (WhatsApp), Signal Key Transparency (2024). Closely related to [Certificate Transparency](14-applied-infrastructure-pki.md#certificate-transparency-ct).

**Production readiness:** Production
Deployed at scale by WhatsApp (SEEMless), Signal, and Apple iMessage for key verification.

**Implementations:**
- [google/keytransparency](https://github.com/google/keytransparency) ⭐ 1.6k — Go, Google's open-source key transparency server
- [facebook/akd](https://github.com/facebook/akd) ⭐ 314 — Rust, Auditable Key Directory (WhatsApp backend)

**Security status:** Secure
VRF-based sparse Merkle trees with append-only consistency proofs; no known attacks on the cryptographic primitives.

**Community acceptance:** Emerging
Google, Meta, Signal, and Apple have independent deployments; IETF Key Transparency drafts are in progress.

---

### Updatable CRS / Powers of Tau

**Goal:** Perpetually strengthened trusted setup. A common reference string (CRS) for SNARKs that can be continuously updated by new participants — each adds their own randomness. The CRS is secure as long as at least one participant was honest, ever.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bowe-Gabizon-Miers (Powers of Tau)** | 2017 | Pairings + KZG | Universal SRS ceremony; sequential contributions; used by Zcash [[1]](https://eprint.iacr.org/2017/1050) |
| **Zcash Powers of Tau Ceremony** | 2018 | BGM protocol | 87 participants; produced SRS for Sapling [[1]](https://z.cash/technology/paramgen/) |
| **Ethereum KZG Ceremony** | 2023 | KZG SRS | 141,416 contributors; SRS for EIP-4844 (proto-danksharding) [[1]](https://ceremony.ethereum.org/) |
| **Universal SRS (SONIC/Marlin/PLONK)** | 2019 | Updatable + universal | One SRS for all circuits up to a size bound [[1]](https://eprint.iacr.org/2019/953) |

**State of the art:** Ethereum KZG ceremony (141k participants); universal updatable SRS for [PLONK-family](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk) SNARKs.

**Production readiness:** Production
Ethereum KZG ceremony (141k participants) is used in production for EIP-4844 proto-danksharding; Zcash Sapling ceremony is live.

**Implementations:**
- [ethereum/kzg-ceremony](https://github.com/ethereum/kzg-ceremony) ⭐ 829 — TypeScript/Rust, Ethereum KZG trusted setup
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Powers of Tau for Zcash Sapling
- [arkworks-rs/poly-commit](https://github.com/arkworks-rs/poly-commit) ⭐ 424 — Rust, KZG polynomial commitment with SRS support

**Security status:** Secure
Security holds as long as at least one ceremony participant was honest and destroyed their toxic waste; no known breaks.

**Community acceptance:** Widely trusted
Ethereum and Zcash ceremonies are community-driven with public participation; KZG SRS is the standard for PLONK/Groth16-family SNARKs.

---

### ECMQV (Elliptic Curve Menezes-Qu-Vanstone)

**Goal:** Implicit authentication in two passes — each party holds a static key pair and an ephemeral key pair; combining both produces a shared secret that is mutually authenticated without an explicit signature or MAC, in exactly two messages.

MQV was proposed by Menezes, Qu, and Vanstone in 1995 and extended to elliptic curves (ECMQV) in joint work with Law and Solinas. HMQV (Krawczyk, 2005) gave the first rigorous security proof and is included in the Key Exchange table above. ECMQV is the elliptic-curve realisation standardised by NIST and used in SSH.

**Two-pass ECMQV handshake:**

```
Static keys:  (dA, QA), (dB, QB)     — long-term
Ephemeral:    (rA, RA), (rB, RB)     — per-session

Alice → Bob: RA
Bob → Alice: RB

Implicit sig scalar (Alice): sA = rA + ē(RA)·dA  mod n
Implicit sig scalar (Bob):   sB = rB + ē(RB)·dB  mod n

Shared secret: K = h·sA·(RB + ē(RB)·QB)
                 = h·sB·(RA + ē(RA)·QA)
```

where ē(R) = (x_R mod 2^⌈log₂n/2⌉) + 2^⌈log₂n/2⌉ (the "implicit" contribution of R).

**Properties:**
- Mutual implicit authentication — no certificates verified in-band
- Two passes, two scalar multiplications per party (comparable to ECDH)
- Forward secrecy from ephemeral keys
- Key compromise impersonation (KCI) resistance requires HMQV variant

| Standard | Role |
|----------|------|
| NIST SP 800-56A Rev 3 | Approved for US federal key establishment |
| IEEE P1363 | Included alongside ECDH |
| RFC 5656 | ECMQV optional in SSH Transport Layer |

**Note:** NSA removed ECMQV from Suite B (2010) citing patent concerns (Certicom). HMQV is the academically preferred variant with a full proof.

**State of the art:** Cite as [[1]](https://eprint.iacr.org/2005/176). NIST SP 800-56A Rev 3 (2018) still approves ECMQV; HMQV preferred in new designs. Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [Non-Interactive Key Exchange (NIKE)](#non-interactive-key-exchange-nike).

**Production readiness:** Mature
NIST-approved in SP 800-56A Rev 3; available in SSH (RFC 5656); removed from NSA Suite B due to patent concerns.

**Implementations:**
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, ECMQV and HMQV implementations
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, ECMQV support via EC key agreement
- [libgcrypt](https://dev.gnupg.org/source/libgcrypt.git/) — C, ECMQV primitives

**Security status:** Caution
ECMQV is secure but susceptible to KCI attacks without the HMQV variant; HMQV provides full proof and is preferred.

**Community acceptance:** Standard
NIST SP 800-56A Rev 3; IEEE P1363; RFC 5656 (SSH); patent concerns (Certicom/BlackBerry) limit adoption in some contexts.

---

### WireGuard Cryptographic Protocol

**Goal:** A modern, minimal VPN tunnel with a fixed, non-negotiable cryptographic suite and a 1-RTT handshake — achieving mutual authentication, forward secrecy, and post-compromise security in roughly 4,000 lines of auditable kernel code, orders of magnitude smaller than IPsec or OpenVPN.

WireGuard (Donenfeld, NDSS 2017) instantiates Trevor Perrin's Noise Protocol Framework with the `Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s` construction. Unlike TLS or IKEv2, there is no cipher-suite negotiation — the entire cryptographic stack is fixed, eliminating downgrade attacks entirely.

**Fixed cryptographic suite:**

| Function | Algorithm | Role |
|----------|-----------|------|
| DH | X25519 (Curve25519) | Ephemeral and static key exchange |
| AEAD | ChaCha20-Poly1305 | Authenticated encryption of handshake and data |
| Hash | BLAKE2s | Chaining and key derivation |
| KDF | HKDF (via BLAKE2s HMAC) | Deriving session keys from DH outputs |
| PSK | Optional 256-bit pre-shared key | Post-quantum layer (psk2 modifier) |

**Noise_IKpsk2 handshake (simplified):**

```
Static keys:    (s_I, S_I) for initiator; (s_R, S_R) for responder (known to initiator)
Ephemeral keys: (e_I, E_I) per-handshake for initiator; (e_R, E_R) for responder

Message 1 (Initiation):
  E_I, AEAD(h, DH(e_I, S_R), S_I), AEAD(h, DH(s_I, S_R), timestamp)

Message 2 (Response):
  E_R, AEAD(h, DH(e_R, E_I) || DH(e_R, S_I) || psk, "")

→ Both derive symmetric session keys: (send_key, recv_key) from the chaining state
```

The handshake chaining state h absorbs every message field; the final HKDF output is bound to the full transcript, providing identity protection for the initiator and mutual authentication.

**Security properties (formally verified):**
- Mutual authentication — impersonation requires breaking X25519
- Forward secrecy — ephemeral E_I, E_R discarded after handshake
- Post-compromise security — new ephemeral keys per session limit exposure
- Initiator identity hidden from passive observers (S_I encrypted under S_R)
- Optional PSK provides a post-quantum hedge against future CRQC

**Cookie mechanism:** WireGuard's DoS resistance relies on a MAC1/MAC2 cookie system — unauthenticated clients receive a cookie derived from their IP address that must be echoed back, preventing amplification attacks without a full handshake.

**Transport data:** After handshake, each IP packet is wrapped in: `{receiver_index (4B) | counter (8B) | AEAD(session_key, counter, packet)}`. The 8-byte counter provides replay protection; nonces are never reused.

**State of the art:** Original paper [[1]](https://www.wireguard.com/papers/wireguard.pdf) (Donenfeld, NDSS 2017); formal mechanized proof in ProVerif/Tamarin [[2]](https://www.wireguard.com/papers/wireguard-formal-verification.pdf); merged into Linux kernel 5.6 (2020). PQ-WireGuard extension (Hülsing et al.) adds Kyber for hybrid PQ key exchange [[3]](https://eprint.iacr.org/2020/379). Related to [Noise Framework](#key-exchange--key-agreement) and [Key Exchange / Key Agreement](#key-exchange--key-agreement).

**Production readiness:** Production
Merged into Linux kernel 5.6 (2020); available on Windows, macOS, iOS, Android; widely deployed in commercial VPN services.

**Implementations:**
- [wireguard-linux](https://github.com/WireGuard/wireguard-linux) ⭐ 1.8k — C, Linux kernel module
- [wireguard-go](https://github.com/WireGuard/wireguard-go) ⭐ 4.1k — Go, userspace WireGuard implementation
- [wireguard-windows](https://github.com/WireGuard/wireguard-windows) ⭐ 2.4k — Go/C, Windows WireGuard client
- [boringtun](https://github.com/cloudflare/boringtun) ⭐ 7.0k — Rust, Cloudflare's userspace WireGuard

**Security status:** Secure
Formally verified in ProVerif and Tamarin; fixed cipher suite eliminates downgrade attacks; no known practical vulnerabilities.

**Community acceptance:** Widely trusted
Endorsed by Linus Torvalds; in-tree Linux kernel; formally verified; adopted by major VPN providers (Mullvad, IVPN, Cloudflare WARP).

---

### Auditable Key Directory (AKD) / Key Transparency v2

**Goal:** A cryptographically auditable, append-only directory that maps usernames or identifiers to public keys — providing a publicly verifiable proof that the server has not silently swapped a user's key, while supporting efficient per-user lookup proofs, consistency proofs, and third-party monitoring without revealing the full directory.

AKD (Auditable Key Directory) is the formal cryptographic protocol underlying modern key transparency deployments, including WhatsApp's SEEMless and Apple's iMessage Key Transparency. It supersedes the original CONIKS design (covered in [Key Transparency / CONIKS](#key-transparency--coniks)) by providing stronger consistency guarantees and a clean separation between the directory's append-only log and the key-value map proofs.

**Core data structures:**

AKD is built on a **Verifiable Random Function (VRF)**-keyed sparse Merkle tree whose epochs are chained in an append-only log:

```
Epoch e:
  Label_u = VRF_prove(sk_server, username)   — unlinkable pseudonym
  Leaf     = H(Label_u, version, public_key, expiry)
  Root_e   = SparseMerkleTree.update(Root_{e-1}, Label_u, Leaf)
  Epoch commitment: SignedTreeHead_e = SIG_server(Root_e || e || timestamp)
```

The VRF maps each username to a pseudonymous label, hiding the username set from observers while allowing any user to prove their own lookup.

**Proofs provided by AKD:**

| Proof type | What it proves | Size |
|------------|---------------|------|
| Lookup proof | Key binding for username at epoch e | O(log N) |
| History proof | Full key history for a username across epochs | O(V · log N) |
| Non-membership proof | Username has no entry at epoch e | O(log N) |
| Consistency proof | Root_e was derived honestly from Root_{e-1} | O(log N) |

**Audit model:**

Third-party auditors fetch `SignedTreeHead` values from the server and verify:
1. Each epoch root is consistent with the previous (append-only property)
2. User-reported lookup proofs are valid against the published root
3. The VRF outputs are well-formed (server cannot selectively lie about individual users)

**Deployed systems:**

| System | Protocol | Notes |
|--------|----------|-------|
| **WhatsApp Key Transparency** | SEEMless (Meta, 2023) | AKD-based; client audits own key history on each session [[1]](https://engineering.fb.com/2023/04/13/security/whatsapp-key-transparency/) |
| **Apple iMessage KT** | Apple Key Transparency (2024) | VRF + Merkle map; third-party audited [[1]](https://www.apple.com/child-safety/pdf/Apple_Key_Transparency_Security_Assessment.pdf) |
| **Signal Key Transparency** | Signal KT (2024) | Publicly monitorable; transparency log + contact key verification [[1]](https://signal.org/blog/key-transparency/) |
| **Google Key Transparency** | KT v2 (2017–) | Open-source reference; CONIKS successor [[1]](https://github.com/google/keytransparency) |

**Relation to Certificate Transparency:**

CT (see [Certificate Transparency (CT)](14-applied-infrastructure-pki.md#certificate-transparency-ct)) is an append-only log for X.509 certificates; AKD is an append-only, updatable *map* for user-to-key bindings. CT provides inclusion proofs; AKD additionally provides non-membership proofs and full history proofs for individual users.

**State of the art:** AKD specification (Kaptchuk et al., 2021) [[1]](https://eprint.iacr.org/2020/1488); open-source Rust implementation by Meta [[2]](https://github.com/facebook/akd). Apple and Signal deployments (2024) mark the first mass-scale key transparency for end-to-end encrypted messaging. Related to [Key Transparency / CONIKS](#key-transparency--coniks), [Certificate Transparency (CT)](14-applied-infrastructure-pki.md#certificate-transparency-ct), and [VRF](09-commitments-verifiability.md#verifiable-random-functions-vrf).

**Production readiness:** Production
Deployed at scale by WhatsApp (SEEMless), Apple iMessage, and Signal for key verification of billions of users.

**Implementations:**
- [facebook/akd](https://github.com/facebook/akd) ⭐ 314 — Rust, Auditable Key Directory (WhatsApp backend)
- [google/keytransparency](https://github.com/google/keytransparency) ⭐ 1.6k — Go, Google's key transparency server

**Security status:** Secure
VRF-based sparse Merkle trees with append-only consistency proofs; no known attacks on the cryptographic primitives.

**Community acceptance:** Emerging
Deployed by Meta, Apple, and Signal; IETF Key Transparency drafts in progress; no finalized RFC yet.

---

### FrodoKEM (Conservative Lattice-Based KEM)

**Goal:** Provide a post-quantum KEM whose security relies on plain, unstructured Learning With Errors (LWE) -- avoiding the algebraic structure of Module-LWE used by ML-KEM -- at the cost of larger keys and ciphertexts.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FrodoKEM-640** | 2016 | Plain LWE | NIST Level 1; pk 9,616 B, ct 9,720 B, ss 16 B [[1]](https://frodokem.org/) |
| **FrodoKEM-976** | 2016 | Plain LWE | NIST Level 3; pk 15,632 B, ct 15,744 B, ss 24 B [[1]](https://frodokem.org/) |
| **FrodoKEM-1344** | 2016 | Plain LWE | NIST Level 5; pk 21,520 B, ct 21,632 B, ss 32 B [[1]](https://frodokem.org/) |

**State of the art:** NIST Round 3 alternate candidate (not selected for NIST standardization) but endorsed by European agencies (BSI, ANSSI, NLNCSA/AIVD) as a conservative fallback [[1]](https://frodokem.org/). Undergoing ISO standardization. Full protocol runs in ~1 ms on server hardware [[2]](https://www.microsoft.com/en-us/research/blog/frodokem-a-conservative-quantum-safe-cryptographic-algorithm/). Specification paper [[3]](https://eprint.iacr.org/2016/659). Related to [ML-KEM (CRYSTALS-Kyber) Internals](#ml-kem-crystals-kyber-internals) and [KEM Combiner Constructions](#kem-combiner-constructions).

**Production readiness:** Experimental
Not NIST-standardized but endorsed by BSI, ANSSI, and NLNCSA/AIVD; undergoing ISO standardization; Microsoft research implementation.

**Implementations:**
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, FrodoKEM-640/976/1344
- [frodo-kem-rs](https://crates.io/crates/frodo-kem) — Rust, FrodoKEM implementation
- [PQCrypto-LWEKE](https://github.com/microsoft/PQCrypto-LWEKE) ⭐ 160 — C, FrodoKEM reference implementation (Microsoft)

**Security status:** Secure
Based on unstructured LWE (most conservative lattice assumption); no known attacks; European agencies endorse as a fallback to ML-KEM.

**Community acceptance:** Niche
Not NIST-standardized; endorsed by European agencies (BSI, ANSSI); undergoing ISO standardization; serves as a conservative alternative to ML-KEM.

---

> **Classic McEliece (Code-Based KEM)** is covered in [Quantum Cryptography — Classic McEliece](15-quantum-cryptography.md#classic-mceliece-code-based-kem).

---

### Delegated Credentials (RFC 9345)

**Goal:** Allow TLS server operators to issue short-lived sub-credentials (delegated credentials) signed by their long-lived CA-issued certificate — enabling ephemeral key rotation without involving the CA. The server generates a new signing key (e.g., daily), signs a delegated credential binding it to the CA cert, and presents both in the TLS handshake. Clients verify the chain: CA cert → delegated credential → TLS handshake signature.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Delegated Credentials for TLS (RFC 9345)** | 2023 | X.509 + TLS 1.3 extension | Short-lived (hours/days) sub-credentials; signed by leaf cert; no CA involvement for rotation [[1]](https://www.rfc-editor.org/rfc/rfc9345) |

**State of the art:** RFC 9345 (2023) standardizes delegated credentials as a TLS 1.3 extension. Deployed by Cloudflare (all edge servers since 2021) and Meta/Facebook (global deployment). Key benefit: if an ephemeral key is compromised, the delegated credential expires within hours — no need for CRL/OCSP revocation. Also enables operators to use different key types (e.g., ECDSA P-256 delegated credential from an RSA CA cert). Related to [Certificate Transparency (CT)](14-applied-infrastructure-pki.md#certificate-transparency-ct) and [TLS 1.3 Key Schedule](#tls-13-key-schedule).

**Production readiness:** Production
Deployed at scale by Cloudflare and Meta/Facebook. RFC 9345 published 2023. Supported in BoringSSL, rustls, and Firefox (experimental).

**Implementations:**
- [cloudflare/go](https://github.com/cloudflare/go) ⭐ 150 — Go — Cloudflare's Go fork with delegated credentials support
- [rustls](https://github.com/rustls/rustls) ⭐ 6.3k — Rust — TLS library with delegated credentials support
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C++ — Google's OpenSSL fork, delegated credentials implemented

**Security status:** Secure
Cryptographic construction is straightforward (signature delegation with short expiry). Security relies on the leaf certificate's signing key; delegated credential compromise is time-bounded by expiry. No known attacks.

**Community acceptance:** Standard
IETF RFC 9345 (2023); deployed by Cloudflare and Meta at global scale; supported in major TLS libraries. Growing adoption among CDN and cloud providers.

---


## HD Keys and Wallet Key Management

---
### SLIP-39 / Shamir Backup for Hardware Wallets

**Goal:** Standardized backup format for cryptocurrency seeds using Shamir's Secret Sharing — splitting a BIP-32 master seed into multiple physical mnemonic shares that require a threshold to recover. Designed for hardware wallets (Trezor).

**Protocol (SLIP-39):**

1. Master secret M (16 or 32 bytes) → split with Shamir SSS over GF(256) into N shares
2. Each share encoded as a mnemonic wordlist (1024 words, 20-33 words per share)
3. **Groups**: multi-level threshold — e.g., 2-of-3 groups where each group has internal threshold
4. **Identifier**: 15-bit random value shared across all shares (allows matching without revealing secret)
5. **Encryption**: M encrypted with passphrase using PBKDF2-HMAC-SHA256 (10000 iterations) before splitting
6. **Checksum**: RS1024 Reed-Solomon over GF(1024) for error detection

**Group threshold example:**
```
Group 1 (2-of-3): three family members
Group 2 (1-of-1): bank safe
Recovery: 2 shares from Group 1 + Group 2's share
```

**Security:** K−1 shares reveal zero information about M (information-theoretic). Passphrase protects against physical theft of share set.

| | BIP-39 | SLIP-39 |
|-|--------|---------|
| Format | 12/24 words | Multiple mnemonic sets |
| Threshold | No | Yes (K-of-N + groups) |
| Hardware support | Universal | Trezor Model T/Safe 3/5 |

**State of the art:** SLIP-39 (SatoshiLabs 2019). Trezor-native; not widely supported elsewhere. Complements BIP-85 (derive child seeds from recovered master). See [Secret Sharing Schemes](05-secret-sharing-threshold-cryptography.md#secret-sharing-schemes-sss), [HD Wallets](#hierarchical-deterministic-keys-bip32--hd-wallets).

**Production readiness:** Mature
Deployed on Trezor hardware wallets (Model T, Safe 3, Safe 5); limited support in other wallet ecosystems.

**Implementations:**
- [python-shamir-mnemonic](https://github.com/trezor/python-shamir-mnemonic) ⭐ 198 — Python, SatoshiLabs SLIP-39 reference implementation
- [trezor-firmware](https://github.com/trezor/trezor-firmware) ⭐ 1.7k — C/Python, SLIP-39 in Trezor firmware
- [slip39-js](https://github.com/ilap/slip39-js) ⭐ 81 — JavaScript, SLIP-39 library

**Security status:** Secure
Information-theoretic security from Shamir SSS; passphrase protection via PBKDF2; no known attacks.

**Community acceptance:** Niche
SatoshiLabs standard adopted by Trezor; limited support in other wallets; not an IETF or NIST standard.

---


## Web Standards (JOSE / JWT / COSE)

---
### JOSE / JWS / JWE / JWT

**Goal:** Standardize JSON-based signing and encryption for web APIs, OAuth 2.0, OIDC, and ACME. Define wire formats so any implementation can parse tokens, signatures, and encrypted payloads across language and platform boundaries.

**Core standards (IETF RFC 7515–7519):**

| RFC | Name | Purpose |
|-----|------|---------|
| RFC 7515 | JWS — JSON Web Signature | Sign arbitrary payloads |
| RFC 7516 | JWE — JSON Web Encryption | Encrypt arbitrary payloads |
| RFC 7517 | JWK — JSON Web Key | Key representation |
| RFC 7518 | JWA — JSON Web Algorithms | Algorithm identifiers |
| RFC 7519 | JWT — JSON Web Token | Claims-based token on top of JWS/JWE |

**JWS compact serialization:**
```
BASE64URL(header) . BASE64URL(payload) . BASE64URL(signature)
```
Header: `{"alg":"ES256","typ":"JWT"}` — algorithm + type.
Payload: JSON claims or arbitrary bytes.
Signature: over `BASE64URL(header) || "." || BASE64URL(payload)`.

**JWE compact serialization (5 parts):**
```
BASE64URL(header) . BASE64URL(encryptedKey) . BASE64URL(iv) . BASE64URL(ciphertext) . BASE64URL(tag)
```

**Algorithm choices (JWA):**

| Category | Recommended | Deprecated |
|----------|------------|-----------|
| Signing | ES256 (ECDSA P-256), EdDSA (Ed25519), RS256 | RS384 (large keys) |
| Key wrap | ECDH-ES+A256KW, RSA-OAEP-256 | RSA1_5 (PKCS#1 v1.5) |
| Content enc | A256GCM, A128CBC-HS256 | none (unsecured JWT) |

**JWT claims (RFC 7519):**
```json
{
  "iss": "https://auth.example.com",
  "sub": "user:1234",
  "aud": "api.example.com",
  "exp": 1735689600,
  "iat": 1735603200,
  "jti": "unique-token-id"
}
```

**Security pitfalls:**
- `alg: none` attack — accept unsigned tokens if `none` not explicitly rejected
- Algorithm confusion — RS256 vs HS256 (public key used as HMAC secret)
- JWT expiry not checked — `exp` must be verified
- JWK set injection — accept attacker-controlled `jku`/`jwks` header

**Deployment:** OAuth 2.0 (RFC 6749), OpenID Connect (OIDC 1.0), ACME (RFC 8555), SCIM 2.0, WebAuthn, FIDO2, SAML-to-JWT bridges. Every modern cloud API uses JWTs.

**State of the art:** JOSE RFCs maintained by IETF JOSE WG. RFC 8037 (Ed25519/X25519 in JOSE), RFC 9278 (JWK Thumbprint URI). Libraries: jose4j, nimbus-jose-jwt, python-jose, go-jose.

**Production readiness:** Production
JOSE/JWT is the foundation of OAuth 2.0, OIDC, and ACME; used by every major cloud API and identity provider.

**Implementations:**
- [jose4j](https://bitbucket.org/b_c/jose4j) — Java, full JOSE implementation
- [nimbus-jose-jwt](https://connect2id.com/products/nimbus-jose-jwt) — Java, comprehensive JOSE/JWT library
- [go-jose](https://github.com/go-jose/go-jose) ⭐ 492 — Go, JOSE implementation (formerly Square)
- [python-jose](https://github.com/mpdavis/python-jose) ⭐ 1.7k — Python, JWS/JWE/JWT
- [jose (Node.js)](https://github.com/panva/jose) ⭐ 7.5k — JavaScript/TypeScript, universal JOSE implementation

**Security status:** Caution
Cryptographically sound when using recommended algorithms (ES256, EdDSA), but `alg:none`, algorithm confusion, and JWK injection attacks are common implementation pitfalls.

**Community acceptance:** Standard
IETF RFCs 7515-7519; universally adopted in web authentication, OAuth 2.0, and OpenID Connect ecosystems.

---

### OAuth 2.0 / OpenID Connect Cryptographic Components

**Goal:** Secure delegated authorization (OAuth 2.0) and federated identity (OpenID Connect) using standard cryptographic building blocks — JWS-signed ID tokens, JWE-encrypted tokens, PKCE for code interception protection, mTLS or DPoP for sender-constrained access tokens, and JWKS for public key distribution.

OAuth 2.0 (RFC 6749) delegates authorization without sharing credentials; OpenID Connect 1.0 layers identity assertions on top. Both rely on [JOSE / JWS / JWE / JWT](#jose--jws--jwe--jwt) as their wire format, but add higher-level cryptographic protocols for binding tokens to clients and preventing replay.

**Core cryptographic flows:**

```
Authorization Code Flow (with PKCE):
  Client:   code_verifier ← random(32 bytes)
            code_challenge = BASE64URL(SHA-256(code_verifier))
  → Authorization endpoint: response_type=code, code_challenge, code_challenge_method=S256
  ← Authorization code (short-lived, single-use)
  → Token endpoint: code + code_verifier (proves same client)
  ← access_token (JWT), id_token (JWT), refresh_token
```

PKCE (RFC 7636) prevents authorization code interception by binding the code to a secret only the legitimate client knows — the `code_verifier` — without requiring client authentication at the redirect URI.

**OpenID Connect ID Token (JWT claims):**

```json
{
  "iss": "https://accounts.example.com",
  "sub": "user:abc123",
  "aud": "client_id_xyz",
  "exp": 1735689600,
  "iat": 1735603200,
  "nonce": "n-0S6_WzA2Mj",
  "at_hash": "77QmUPtjPfzWtF2AnpK9RQ"
}
```

`at_hash` (access token hash) cryptographically binds the ID token to the access token: `LEFT128(SHA-256(access_token))` encoded in base64url.

**DPoP (Demonstrating Proof of Possession, RFC 9449):**

DPoP binds an access token to a client's ephemeral key pair, preventing token theft replay:

```
Client generates: (dpop_priv, dpop_pub) per-session EC key pair

DPoP proof JWT header: {"typ":"dpop+jwt","alg":"ES256","jwk": dpop_pub}
DPoP proof JWT claims: {"htm":"POST","htu":"https://api.example.com/resource",
                        "iat":..., "jti":"unique-id", "ath": SHA256(access_token)}

→ Resource server: Authorization: DPoP <access_token>
                   DPoP: <dpop_proof_jwt>
Server verifies: dpop_pub matches token binding, jti not replayed, ath matches token
```

**mTLS sender-constraining (RFC 8705):**

An alternative to DPoP — the client's TLS client certificate thumbprint is embedded in the access token during issuance; the resource server verifies the TLS client cert matches.

| Mechanism | Cryptographic binding |
|-----------|----------------------|
| Bearer token (plain) | None — token theft = full compromise |
| PKCE | Code verifier binds auth code to client |
| DPoP | Ephemeral EC key pair binds access token to client |
| mTLS | TLS client cert thumbprint binds access token to cert |

**JWKS (JSON Web Key Set) endpoint:**

Authorization servers publish public keys at `/.well-known/jwks.json`; resource servers fetch them to verify JWS signatures on access tokens. Key rotation requires `kid` (key ID) matching; clients MUST NOT cache JWKS indefinitely.

| Standard | Role |
|----------|------|
| **OAuth 2.0 (RFC 6749)** | Authorization framework [[1]](https://www.rfc-editor.org/rfc/rfc6749) |
| **PKCE (RFC 7636)** | Code interception protection [[1]](https://www.rfc-editor.org/rfc/rfc7636) |
| **OpenID Connect 1.0** | Identity layer on OAuth 2.0 [[1]](https://openid.net/specs/openid-connect-core-1_0.html) |
| **DPoP (RFC 9449)** | Sender-constrained tokens via ephemeral key proof [[1]](https://www.rfc-editor.org/rfc/rfc9449) |
| **mTLS OAuth (RFC 8705)** | Certificate-bound access tokens [[1]](https://www.rfc-editor.org/rfc/rfc8705) |

**State of the art:** DPoP (RFC 9449, 2023) is the recommended token-binding mechanism for public clients. PKCE is mandatory for all OAuth 2.1 flows (draft). JAR (JWT-Secured Authorization Requests, RFC 9101) and JARM (JWT-Secured Authorization Response Mode) extend signing to the authorization request/response itself. Related to [JOSE / JWS / JWE / JWT](#jose--jws--jwe--jwt) and [Key Transparency / CONIKS](#key-transparency--coniks).

**Production readiness:** Production
OAuth 2.0 and OpenID Connect are deployed by every major cloud provider, identity platform, and web application globally.

**Implementations:**
- [IdentityServer](https://github.com/DuendeSoftware/IdentityServer) ⭐ 1.6k — C#, OpenID Connect and OAuth 2.0 framework
- [Keycloak](https://github.com/keycloak/keycloak) ⭐ 33k — Java, open-source identity and access management with OAuth 2.0/OIDC
- [node-oidc-provider](https://github.com/panva/node-oidc-provider) ⭐ 3.7k — JavaScript, certified OpenID Connect provider
- [authlib](https://github.com/lepture/authlib) ⭐ 5.3k — Python, OAuth 2.0 / OIDC client and server
- [fosite](https://github.com/ory/fosite) ⭐ 2.5k — Go, extensible OAuth 2.0 / OIDC SDK

**Security status:** Caution
Cryptographically sound when using PKCE, DPoP, and recommended JWT algorithms; bearer tokens without sender-constraining remain vulnerable to theft and replay.

**Community acceptance:** Standard
IETF RFCs 6749 (OAuth 2.0), 7636 (PKCE), 9449 (DPoP), 8705 (mTLS); OpenID Foundation certified; universally adopted.

---

### Key Exchange / Key Agreement

**Goal:** Establish a shared secret over an insecure channel, providing confidentiality for subsequent communication.

| Algorithm | Year | Basis | Note |
|-----------|------|-------|------|
| **ECDH (X25519)** | 2006 | Elliptic curves | Curve25519; default in TLS 1.3, Signal, WireGuard [[1]](https://cr.yp.to/ecdh/curve25519-20060209.pdf) |
| **X448** | 2015 | Goldilocks curve | 224-bit security; RFC 7748 [[1]](https://eprint.iacr.org/2015/625) |
| **Classic DH** | 1976 | Discrete logarithm | Original key exchange; use 2048+ bit groups [[1]](https://ee.stanford.edu/~hellman/publications/24.pdf) |
| **SPAKE2 / OPAQUE** | 2005 | PAKE | Password-authenticated; no PKI needed [[1]](https://eprint.iacr.org/2005/096)[[2]](https://eprint.iacr.org/2018/163) |
| **MQV / HMQV** | 1995 | DL + static keys | Implicitly authenticated 2-pass protocol [[1]](https://eprint.iacr.org/2005/176) |
| **Noise Framework** | 2016 | Composable patterns | Modular handshakes: XX, IK, NK, etc. [[1]](https://noiseprotocol.org/noise.html) |

**State of the art:** X25519 (ephemeral DH), OPAQUE (PAKE without exposing password to server), Noise XX (modern protocol design).

**Production readiness:** Production
Deployed in TLS 1.3, Signal, WireGuard, and all major browsers and VPNs.

**Implementations:**
- [libsodium](https://github.com/jedisct1/libsodium) ⭐ 13k — C, X25519 and key exchange primitives
- [BoringSSL](https://github.com/google/boringssl) ⭐ 2.1k — C++, X25519/X448 in TLS
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, full DH/ECDH/X25519/X448 support
- [opaque-ke](https://github.com/facebook/opaque-ke) ⭐ 386 — Rust, OPAQUE implementation
- [noise-protocol](https://github.com/mcginty/snow) ⭐ 1.1k — Rust, Noise framework implementation

**Security status:** Secure
No known practical attacks on X25519, X448, or OPAQUE at recommended parameters.

**Community acceptance:** Standard
X25519 standardized in RFC 7748; ECDH in NIST SP 800-56A; OPAQUE in IETF draft (CFRG); Noise widely peer-reviewed.

---

### OCSP / Certificate Revocation

**Goal:** Determine in real time whether a certificate has been revoked before it expires — preventing use of compromised or mis-issued certificates in live TLS sessions.

Certificate revocation is a fundamental but operationally difficult problem in PKI. Two classical mechanisms exist — Certificate Revocation Lists (CRLs) and the Online Certificate Status Protocol (OCSP) — along with newer stapling and short-lived-certificate approaches.

### Certificate Revocation Lists (CRL)

A CRL is a signed, time-stamped list of serial numbers of revoked certificates, published by the issuing CA at a fixed URL (CDP — CRL Distribution Point).

| Property | Detail |
|----------|--------|
| Format | DER-encoded X.509 CRL (RFC 5280) [[1]](https://www.rfc-editor.org/rfc/rfc5280) |
| Signed by | CA's private key (same key that signed the leaf cert) |
| Update frequency | Typically 24 h – 7 days; `nextUpdate` field |
| Size | Can reach MB for large CAs; Delta CRLs reduce bandwidth |
| Latency | Revocation effective only at next CRL fetch |

### Online Certificate Status Protocol (OCSP)

OCSP (RFC 6960) provides per-certificate real-time status queries. A client sends the certificate's serial number to an OCSP responder; the responder replies `good`, `revoked`, or `unknown`.

**OCSP request/response structure:**

```
Request: issuerNameHash, issuerKeyHash, serialNumber
         (all SHA-1 or SHA-256 hashes per RFC 6960)
Response: certStatus, thisUpdate, nextUpdate, signature
```

| Scheme | Year | Note |
|--------|------|------|
| **OCSP (RFC 6960)** | 2013 | Real-time per-cert status; privacy issue: CA learns which certs client checks [[1]](https://www.rfc-editor.org/rfc/rfc6960) |
| **OCSP Stapling (RFC 6066/TLS)** | 2012 | Server fetches and caches OCSP response; staples to TLS handshake; eliminates privacy leak [[1]](https://www.rfc-editor.org/rfc/rfc6066) |
| **OCSP Must-Staple (RFC 7633)** | 2015 | Certificate extension requiring stapled OCSP; soft/hard-fail semantics [[1]](https://www.rfc-editor.org/rfc/rfc7633) |
| **CRLite / CRLSets** | 2017 | Bloom-filter cascade (Mozilla) or curated CRL subset (Chrome) pushed to browser; eliminates live OCSP queries [[1]](https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-certificate-revocation-is-broken/) |
| **Short-lived certificates** | 2023 | Let's Encrypt proposes 6-day certs; expiry replaces revocation entirely [[1]](https://letsencrypt.org/2023/06/01/short-lived-certificates.html) |

**Revocation checking in practice:**

| Mechanism | Chrome | Firefox | Safari |
|-----------|--------|---------|--------|
| CRL | No (too large) | Delta CRL | Partial |
| OCSP live | Soft-fail | Hard-fail (EV only) | Soft-fail |
| OCSP Stapling | Yes (required for EV) | Yes | Yes |
| CRLSets/CRLite | CRLSets (curated) | CRLite (all certs) | — |

**State of the art:** OCSP stapling + CRLite/CRLSets is the current industry direction. Google Chrome no longer does live OCSP for DV certs. Short-lived certificates (6–90 day) are the emerging solution — revocation becomes unnecessary when certs expire before the attacker can exploit them. See [Certificate Transparency](14-applied-infrastructure-pki.md#certificate-transparency-ct) and [ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management).

**Production readiness:** Production
OCSP and CRLs are deployed across the entire WebPKI; every browser implements some form of revocation checking.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, OCSP client/responder and CRL support
- [cfssl](https://github.com/cloudflare/cfssl) ⭐ 9.4k — Go, Cloudflare's PKI toolkit with OCSP responder
- [Boulder](https://github.com/letsencrypt/boulder) ⭐ 5.7k — Go, Let's Encrypt CA with OCSP responder
- [crlite](https://github.com/mozilla/crlite) ⭐ 150 — Rust/Python, Mozilla's CRLite filter generation

**Security status:** Caution
OCSP soft-fail in most browsers means a network attacker can suppress revocation responses; OCSP Must-Staple and CRLite mitigate this.

**Community acceptance:** Standard
RFC 6960 (OCSP), RFC 6066 (OCSP stapling), RFC 7633 (Must-Staple); universally deployed in WebPKI.

---

### PKIX / X.509 v3 Certificate Profile (RFC 5280)

**Goal:** Define the precise wire format, extension semantics, and validation algorithm for X.509 v3 certificates and v2 Certificate Revocation Lists (CRLs) used in Internet PKI — the structural specification that every TLS connection, S/MIME message, and code-signing system relies upon.

The ITU-T X.509 standard defines the abstract ASN.1 structure of certificates. RFC 5280 (PKIX WG, 2008) profiles X.509 for Internet use: it mandates a subset of extensions, specifies Internet name forms (SAN, subjectAltName), and defines the path validation algorithm that browsers and TLS stacks implement.

**X.509 v3 certificate structure (DER-encoded ASN.1):**

```
Certificate ::= SEQUENCE {
  tbsCertificate   TBSCertificate,    -- to-be-signed portion
  signatureAlgorithm AlgorithmIdentifier,
  signatureValue   BIT STRING         -- CA's signature over tbsCertificate
}

TBSCertificate ::= SEQUENCE {
  version         [0] INTEGER (v3 = 2),
  serialNumber    INTEGER,
  signature       AlgorithmIdentifier,
  issuer          Name,               -- CA's distinguished name
  validity        Validity,           -- notBefore, notAfter
  subject         Name,               -- cert subject DN
  subjectPublicKeyInfo SubjectPublicKeyInfo,
  extensions      [3] SEQUENCE OF Extension   -- v3 only
}
```

**Mandatory extensions (PKIX profile):**

| Extension | OID | Purpose |
|-----------|-----|---------|
| **Subject Alternative Name (SAN)** | 2.5.29.17 | DNS names, IPs, email; replaces CN for hostname binding |
| **Basic Constraints** | 2.5.29.19 | `cA: TRUE/FALSE`; `pathLenConstraint` caps chain depth |
| **Key Usage** | 2.5.29.15 | `digitalSignature`, `keyEncipherment`, `keyCertSign`, etc. |
| **Extended Key Usage** | 2.5.29.37 | `serverAuth`, `clientAuth`, `codeSigning`, `emailProtection` |
| **Authority Key Identifier** | 2.5.29.35 | Links cert to issuer's public key |
| **CRL Distribution Points** | 2.5.29.31 | URL(s) to fetch CRL for revocation |
| **Authority Info Access** | 1.3.6.1.5.5.7.1.1 | OCSP responder URL + CA issuer URL |

**Path validation algorithm (RFC 5280 §6):**

1. Build a chain from leaf → intermediates → trust anchor (root CA in trust store)
2. For each certificate in chain: verify signature, check validity period, check `basicConstraints.cA`, enforce `pathLenConstraint`
3. Check name constraints — issuer can restrict subtrees of names subordinate CAs may certify
4. Check key usage and extended key usage for the leaf cert
5. Check revocation (CRL or OCSP) for each non-root cert

**Name forms (SAN, RFC 5280 §4.2.1.6):**

| Type | Example | Use |
|------|---------|-----|
| `dNSName` | `example.com` | TLS server authentication |
| `iPAddress` | `192.0.2.1` | IP SAN for server certs |
| `rfc822Name` | `user@example.com` | S/MIME email certs |
| `uniformResourceIdentifier` | `https://…` | Code signing, LDAP |

**Wildcard certificates:** A single `*.example.com` SAN matches one label deep — `foo.example.com` but not `foo.bar.example.com`. Multi-SAN certs list explicit names.

**State of the art:** RFC 5280 (2008) [[1]](https://www.rfc-editor.org/rfc/rfc5280); updated by RFC 8398 (internationalized email in SANs) and RFC 9549 (algorithm agility). Baseline Requirements (CA/Browser Forum) [[2]](https://cabforum.org/baseline-requirements/) constrain what WebPKI CAs may issue. Related to [ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management), [Certificate Transparency](14-applied-infrastructure-pki.md#certificate-transparency-ct), and [DANE](14-applied-infrastructure-pki.md#dane--dns-based-authentication-of-named-entities).

**Production readiness:** Production
X.509 v3 is the foundation of all TLS, S/MIME, code signing, and PKI infrastructure globally.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, X.509 parsing, validation, and path building
- [GnuTLS](https://gitlab.com/gnutls/gnutls) — C, X.509 certificate handling
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive X.509 support
- [x509-parser (Rust)](https://github.com/rusticata/x509-parser) ⭐ 265 — Rust, X.509 certificate parsing
- [cfssl](https://github.com/cloudflare/cfssl) ⭐ 9.4k — Go, Cloudflare PKI toolkit

**Security status:** Caution
The format itself is secure, but complex ASN.1 parsing has historically led to implementation vulnerabilities; path validation edge cases require careful implementation.

**Community acceptance:** Standard
IETF RFC 5280; ITU-T X.509; CA/Browser Forum Baseline Requirements; the universal certificate format for the Internet.

---

### IKEv1 vs IKEv2 (Internet Key Exchange)

**Goal:** Negotiate and authenticate IPsec security associations (SAs) — agree on cryptographic algorithms, exchange keys, and establish the ISAKMP/IKE SA that protects all subsequent ESP/AH traffic. IKEv2 (RFC 7296) redesigns the baroque IKEv1 (RFC 2409) into a clean, minimal four-message exchange with built-in EAP and mobility support.

### IKEv1 (RFC 2409, 1998)

IKEv1 runs in two phases. Phase 1 establishes the ISAKMP SA that protects Phase 2; Phase 2 negotiates the actual IPsec SAs. Phase 1 has six modes offering different trade-offs between flexibility and identity protection.

**Phase 1 modes:**

| Mode | Messages | Identity protection | Use case |
|------|----------|---------------------|----------|
| **Main Mode** | 6 | Yes (identity encrypted) | Site-to-site; standard |
| **Aggressive Mode** | 3 | No (identity in cleartext) | Fast; required for PSK + dynamic IPs |
| **Base Mode** | 4 | Partial | Rarely used |

**Phase 1 authentication methods:**

| Method | Mechanism |
|--------|-----------|
| **Pre-Shared Key (PSK)** | HMAC over negotiated values using PSK; susceptible to offline dictionary attacks in Aggressive Mode |
| **RSA Digital Signatures** | SIGMA-style; sign the DH exchange; certificates optional |
| **RSA Public Key Encryption** | Encrypt nonces under peer's RSA key; identity protection without certificates |
| **Revised RSA Encryption** | Hybrid of above; reduced messages |

**Phase 1 (Main Mode, PSK) message sequence:**

```
→ SA proposal (algorithms)
← SA selected
→ g^x (initiator DH)
← g^y (responder DH)
  [both derive SKEYID = prf(PSK, Ni || Nr)]
→ {ID_I, HASH_I} encrypted under Ke
← {ID_R, HASH_R} encrypted under Ke
```

**Phase 2 (Quick Mode):** Three messages protected under Phase 1 SA; negotiates ESP/AH algorithms, SPI, and derives per-SA keys from SKEYID_d.

### IKEv2 (RFC 7296, 2014)

IKEv2 collapses the six-mode IKEv1 Phase 1 into exactly four messages (two round-trips), embedding child SA negotiation into the initial exchange. The cryptographic core is a [SIGMA-I](#sigma-protocol-sign-and-mac) construction.

**IKEv2 initial exchange:**

```
IKE_SA_INIT:
  → SAi1, KEi (g^x), Ni
  ← SAr1, KEr (g^y), Nr, [CERTREQ]

IKE_AUTH:
  → {IDi, [CERT], [CERTREQ], [IDr], AUTH, SAi2, TSi, TSr}
  ← {IDr, [CERT], AUTH, SAr2, TSi, TSr}
```

AUTH payload = signature or MAC over `(RealMessage1, NonceR, prf(SK_pi, IDi))`, binding identity to the DH exchange in SIGMA fashion.

**Key differences IKEv1 → IKEv2:**

| Feature | IKEv1 | IKEv2 |
|---------|-------|-------|
| Message count (initial) | 6 (Main) or 3 (Aggressive) | 4 |
| Phases | 2 (ISAKMP + IPsec) | 1 (unified exchange) |
| EAP support | No | Yes (IKE_AUTH can carry EAP) |
| Mobility (MOBIKE) | No | RFC 4555 |
| Dead peer detection | Vendor-specific | Built-in (IKE_INFORMATIONAL) |
| XAUTH (legacy auth) | Vendor extension | Replaced by EAP |
| DoS resilience | None | Cookie challenge |
| Traffic selector | Phase 2 ID payloads | TSi/TSr in IKE_AUTH |
| Cryptographic agility | Yes (ISAKMP transforms) | Yes (SAi1/SAr1) |

**IKEv2 key derivation:**

```
SKEYSEED = prf(Ni || Nr, g^(xy))
{SK_d | SK_ai | SK_ar | SK_ei | SK_er | SK_pi | SK_pr}
    = prf+(SKEYSEED, Ni || Nr || SPIi || SPIr)
```

SK_e* = encryption, SK_a* = integrity (MAC), SK_d = child SA derivation, SK_p* = AUTH computation.

**State of the art:** IKEv2 RFC 7296 (2014) [[1]](https://www.rfc-editor.org/rfc/rfc7296); IKEv1 deprecated. Extensions: RFC 7427 (signature authentication), RFC 8784 (post-quantum PSK mixing), RFC 9370 (multiple key exchanges for PQ). Deployed in every enterprise VPN, StrongSwan, Cisco IOS, Windows IKEv2. Related to [SIGMA Protocol](#sigma-protocol-sign-and-mac) and [WireGuard Cryptographic Protocol](#wireguard-cryptographic-protocol).

**Production readiness:** Production
IKEv2 is deployed in every enterprise IPsec VPN; IKEv1 is legacy but still operational in older equipment.

**Implementations:**
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C, full IKEv1/IKEv2 implementation
- [Libreswan](https://github.com/libreswan/libreswan) ⭐ 935 — C, IKEv1/IKEv2 for Linux
- [isakmpd (OpenBSD)](https://github.com/openbsd/src/tree/master/sbin/isakmpd) ⭐ 3.7k — C, IKEv1
- [charon (strongSwan)](https://github.com/strongswan/strongswan/tree/master/src/libcharon) ⭐ 2.8k — C, modern IKEv2 daemon

**Security status:** Secure
IKEv2 uses SIGMA-I construction with full security proof; IKEv1 Aggressive Mode PSK is vulnerable to offline dictionary attacks.

**Community acceptance:** Standard
IKEv2 is IETF RFC 7296; IKEv1 is RFC 2409 (deprecated); deployed by Cisco, Microsoft, Juniper, and all major VPN vendors.

---

### EST (Enrollment over Secure Transport, RFC 7030)

**Goal:** A modern, TLS-native certificate enrollment and renewal protocol that replaces SCEP's HTTP+PKCS#7 stack with a clean HTTPS REST API — supporting automatic re-enrollment, CA certificate distribution, and server-side key generation over mutually authenticated TLS.

EST (RFC 7030, 2013) was designed by the IETF PKIX WG as a simpler, more secure successor to SCEP. It runs entirely over HTTPS (port 443 or 8443), uses the existing TLS certificate for renewal authentication, and expresses all operations as RESTful endpoints under `/.well-known/est/`.

**EST endpoint structure:**

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/.well-known/est/cacerts` | GET | Fetch current CA certificate(s) |
| `/.well-known/est/simpleenroll` | POST | Initial enrollment (CSR → cert) |
| `/.well-known/est/simplereenroll` | POST | Renew using existing client cert |
| `/.well-known/est/serverkeygen` | POST | Request server-side key generation |
| `/.well-known/est/csrattrs` | GET | Fetch required CSR attributes |

**Enrollment flow (initial):**

```
1. Client fetches /cacerts → verifies CA cert fingerprint (out-of-band trust anchor)
2. Client generates key pair, creates PKCS#10 CSR
3. Client POSTs CSR to /simpleenroll:
     - TLS client auth: HTTP Basic (username+OTP) or existing certificate
     - Body: base64(DER(CSR)), Content-Type: application/pkcs10
4. EST server responds:
     200 OK: base64(DER(cert)), Content-Type: application/pkcs7-mime
     202 Accepted: enrollment pending (retry-after header)
```

**Re-enrollment (renewal):**

```
Client POSTs to /simplereenroll authenticated by the existing client certificate
(mutual TLS). No OTP required — cert proves identity. New cert can be fetched
before expiry, enabling seamless rotation.
```

**Comparison with SCEP and CMP:**

| Feature | SCEP (RFC 8894) | EST (RFC 7030) | CMP (RFC 4210) |
|---------|-----------------|----------------|----------------|
| Transport | HTTP + CMS | HTTPS REST | HTTP / TCP |
| Crypto wrapping | PKCS#7 / CMS | PKCS#10 + PKCS#7 | CMP ASN.1 |
| Auto-renewal | No | Yes (simplereenroll) | Yes |
| Server key gen | No | Yes | Yes |
| Complexity | Low | Medium | High |
| RFC status | 8894 (2020) | 7030 (2013) | 9483 (2023) |

**State of the art:** RFC 7030 (2013) [[1]](https://www.rfc-editor.org/rfc/rfc7030); updated by RFC 8295 (additional attrs). Widely adopted in industrial IoT (IEC 62351-8), automotive (AUTOSAR), and enterprise MDM. Cisco, Microsoft, and DigiCert all support EST. Related to [SCEP](#scep-simple-certificate-enrollment-protocol-rfc-8894), [CMP](#cmp-certificate-management-protocol-rfc-42109483), and [ACME Protocol](12-secure-communication-protocols.md#acme-protocol--automated-certificate-management).

**Production readiness:** Production
Adopted in industrial IoT, automotive (AUTOSAR), and enterprise PKI; supported by Cisco, Microsoft, and DigiCert.

**Implementations:**
- [libest](https://github.com/cisco/libest) ⭐ 106 — C, Cisco's EST client/server library
- [est (Go)](https://github.com/globalsign/est) ⭐ 65 — Go, GlobalSign EST client/server
- [EJBCA](https://github.com/Keyfactor/ejbca-ce) ⭐ 896 — Java, open-source CA with EST support

**Security status:** Secure
Runs over TLS with mutual authentication; automatic re-enrollment eliminates manual certificate handling risks.

**Community acceptance:** Standard
IETF RFC 7030; adopted in IEC 62351-8, AUTOSAR, and enterprise MDM; modern successor to SCEP.

---

### CMP (Certificate Management Protocol, RFC 4210/9483)

**Goal:** A comprehensive ASN.1-based protocol for the full lifecycle of X.509 certificates — initialization, certification, key update, revocation, cross-certification, and CA key rollover — supporting both online and store-and-forward (offline) operation via any transport.

CMP (Certificate Management Protocol) has its roots in PKIX WG work from 1999 (RFC 2510, updated to RFC 4210 in 2005). RFC 9483 (2023) produced a modern "lightweight" profile for constrained environments (IoT, automotive). CMP is more powerful than SCEP or EST but significantly more complex, making it the choice for high-assurance and industrial PKI.

**PKIMessage structure (ASN.1):**

```
PKIMessage ::= SEQUENCE {
  header        PKIHeader,       -- sender, recipient, messageTime, nonce, transactionID
  body          PKIBody,         -- request or response (one of 28 message types)
  protection    [0] PKIProtection OPTIONAL,   -- signature or MAC
  extraCerts    [1] SEQUENCE OF Certificate OPTIONAL
}
```

**Core message types:**

| Type | Tag | Purpose |
|------|-----|---------|
| **ir** | 0 | Initialization Request — first cert from a new entity |
| **ip** | 1 | Initialization Response |
| **cr** | 2 | Certification Request — subsequent certs |
| **cp** | 3 | Certification Response |
| **kur** | 7 | Key Update Request — renew before expiry |
| **kup** | 8 | Key Update Response |
| **rr** | 11 | Revocation Request |
| **rp** | 12 | Revocation Response |
| **certConf** | 24 | Certificate Confirmation — client acknowledges receipt |
| **pkiconf** | 19 | PKI Confirmation — CA acknowledges certConf |

**Three-pass enrollment (ir → ip → certConf → pkiconf):**

```
Client → CA:  ir   (CSR + proof-of-possession + protection)
CA → Client:  ip   (issued cert or waitingIndication)
Client → CA:  certConf  (confirm cert accepted; HMAC over cert hash)
CA → Client:  pkiconf   (finalize transaction)
```

Proof-of-possession (POP) is cryptographic: for signing keys, the CSR itself is signed; for encryption keys, the CA encrypts a challenge that the client must decrypt.

**Protection mechanisms:**

| Method | When used |
|--------|-----------|
| Signature (existing cert) | Renewal/key-update when entity already has a cert |
| MAC (shared secret) | Initial enrollment with out-of-band reference value |
| Null (no protection) | Trusted network; CA verifies via TLS client auth |

**RFC 9483 lightweight CMP profile (2023):** Restricts the full CMP to a practical subset for constrained IoT devices — HTTP transport, single-pass where possible, mandatory nonces, and a defined set of message types and algorithms.

| Standard / Deployment | Usage |
|----------------------|-------|
| **RFC 4210** (2005) | Full CMP; enterprise PKI [[1]](https://www.rfc-editor.org/rfc/rfc4210) |
| **RFC 9483** (2023) | Lightweight CMP profile for IoT/automotive [[1]](https://www.rfc-editor.org/rfc/rfc9483) |
| **Siemens / BMW** | Automotive PKI (V2X, OTA updates) |
| **openssl-cmp** | Reference implementation in OpenSSL 3.x |
| **EJBCA** | Open-source CA with full CMP support |

**State of the art:** RFC 9483 (lightweight CMP, 2023) is the current focus, driven by AUTOSAR and IEC 62351 for industrial/automotive. Full RFC 4210 remains the standard for high-assurance government and enterprise PKI. Related to [EST](#est-enrollment-over-secure-transport-rfc-7030), [SCEP](#scep-simple-certificate-enrollment-protocol-rfc-8894), and [PKIX / X.509 v3](#pkix--x509-v3-certificate-profile-rfc-5280).

**Production readiness:** Production
Deployed in high-assurance government PKI, automotive (Siemens, BMW V2X), and industrial control systems.

**Implementations:**
- [OpenSSL 3.x (openssl-cmp)](https://github.com/openssl/openssl) ⭐ 29k — C, CMP client built into OpenSSL 3.x
- [EJBCA](https://github.com/Keyfactor/ejbca-ce) ⭐ 896 — Java, open-source CA with full CMP support
- [cryptlib](https://github.com/cryptlib/cryptlib) ⭐ 51 — C, CMP implementation by Peter Gutmann

**Security status:** Secure
Supports signature-based and MAC-based protection; proof-of-possession for all key types; comprehensive lifecycle management.

**Community acceptance:** Standard
IETF RFC 4210 and RFC 9483 (lightweight profile); ISO-referenced; deployed in automotive and government PKI.

---

### ISO/IEC 11770 Key Establishment Mechanisms

**Goal:** A normative international standard family that catalogues and defines a complete set of key establishment mechanisms — symmetric and asymmetric, authenticated and unauthenticated, key transport and key agreement — providing a common reference taxonomy used by national standards bodies, regulatory frameworks, and product certifications worldwide.

ISO/IEC 11770 is the international counterpart to NIST SP 800-56A/B. It is maintained by ISO/IEC JTC 1/SC 27 and is the normative reference in Common Criteria evaluations, BSI (Germany), ANSSI (France), and many procurement standards. The standard is divided into multiple parts, each covering a specific class of mechanism.

**Standard parts:**

| Part | Title | Content |
|------|-------|---------|
| **ISO/IEC 11770-1** | Framework | Definitions, requirements, security goals for key establishment |
| **ISO/IEC 11770-2** | Symmetric techniques | Key transport and key agreement using symmetric ciphers and MACs; 6 mechanisms |
| **ISO/IEC 11770-3** | Asymmetric techniques | DH, RSA, and EC-based key agreement; includes EC-GDHE, EC-MQV, ECIES-KEM |
| **ISO/IEC 11770-4** | Mechanisms based on weak secrets | PAKE and password-based mechanisms; SPEKE, SRP, EC-SRP variants |
| **ISO/IEC 11770-5** | Group key establishment | Burmester-Desmedt and related group key agreement protocols |
| **ISO/IEC 11770-6** | Key derivation | Formal specification of KDFs used within other parts |

**Part 2 — Symmetric key transport mechanisms (selected):**

| Mechanism | Rounds | Description |
|-----------|--------|-------------|
| **Mechanism 1** | 1 | Key transport: sender encrypts key under shared symmetric key |
| **Mechanism 5** | 2 | Mutual authentication + key transport using a KDC (Key Distribution Center) |
| **Mechanism 6** | 3 | Three-party KDC-based key establishment (Kerberos-style) |

**Part 3 — Asymmetric mechanisms (selected):**

| Mechanism | Basis | Notes |
|-----------|-------|-------|
| **EC-GDHE** | ECDH | Ephemeral unified model; two-pass |
| **EC-MQV** | ECMQV | Two-pass with implicit authentication |
| **ECIES-KEM** | ECDH + KEM/DEM | Encrypt-then-MAC; basis for HPKE |

**Relationship to other standards:**

ISO/IEC 11770-3 mechanisms overlap with NIST SP 800-56A schemes, but use slightly different key-derivation and encoding conventions. FIPS-validated implementations typically address both. IEEE P1363 (key agreement) and ANS X9.63 (key derivation for EC) are normative references within 11770-3.

**State of the art:** ISO/IEC 11770-3:2021 [[1]](https://www.iso.org/standard/80186.html); ISO/IEC 11770-4:2017 [[2]](https://www.iso.org/standard/67933.html). The standard family is actively maintained; a post-quantum amendment is under development by SC 27/WG 2. Related to [Key Exchange / Key Agreement](#key-exchange--key-agreement), [One-Pass Diffie-Hellman](#one-pass-diffie-hellman-nist-sp-800-56a), and [ECMQV](#ecmqv-elliptic-curve-menezes-qu-vanstone).

**Production readiness:** Production
ISO/IEC 11770 is the normative reference in Common Criteria evaluations, BSI, ANSSI, and government procurement standards worldwide.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, implements mechanisms covered by ISO/IEC 11770-3 (ECDH, ECMQV)
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, key agreement schemes aligned with ISO/IEC 11770-3
- [cryptlib](https://github.com/cryptlib/cryptlib) ⭐ 51 — C, ISO-referenced key establishment mechanisms

**Security status:** Secure
Normative standard covering well-analyzed mechanisms (ECDH, ECMQV, PAKE); security depends on correct parameter selection per each part.

**Community acceptance:** Standard
ISO/IEC JTC 1/SC 27; normative in Common Criteria, BSI, and ANSSI evaluations; international counterpart to NIST SP 800-56A/B.

---

### HQC (Hamming Quasi-Cyclic KEM)

**Goal:** Provide a post-quantum key encapsulation mechanism based on the hardness of decoding quasi-cyclic codes over the Hamming metric, serving as a code-based backup to lattice-based ML-KEM.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HQC-128** | 2017 | QCSD problem | NIST Level 1; pk 2,249 B, ct 4,497 B [[1]](https://pqc-hqc.org/) |
| **HQC-192** | 2017 | QCSD problem | NIST Level 3; pk 4,522 B, ct 9,042 B [[1]](https://pqc-hqc.org/) |
| **HQC-256** | 2017 | QCSD problem | NIST Level 5; pk 7,245 B, ct 14,485 B [[1]](https://pqc-hqc.org/) |

**State of the art:** Selected by NIST as the fifth post-quantum standard (March 2025), providing algorithmic diversity as a code-based alternative to lattice-based ML-KEM [[1]](https://www.nist.gov/news-events/news/2025/03/nist-selects-hqc-fifth-algorithm-post-quantum-encryption). Draft standard expected ~2027. Security based on the Quasi-Cyclic Syndrome Decoding (QCSD) problem, with decades of cryptanalysis on the underlying coding-theory hardness. Larger keys/ciphertexts than ML-KEM but built on a fundamentally different mathematical assumption. Related to [ML-KEM (CRYSTALS-Kyber) Internals](#ml-kem-crystals-kyber-internals) and [Post-Quantum Key Exchange (Hybrid KEM)](#post-quantum-key-exchange-in-practice-hybrid-kem).

**Production readiness:** Experimental
Selected by NIST (March 2025) but draft standard expected ~2027; reference implementations available but no production deployment yet.

**Implementations:**
- [pqc-hqc](https://github.com/pqc-hqc/hqc) ⭐ 0 — C, reference HQC implementation
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, HQC-128/192/256 implementations

**Security status:** Secure
Based on the QCSD problem with decades of cryptanalysis; no known practical attacks; selected by NIST for standardization.

**Community acceptance:** Emerging
Selected by NIST as the fifth PQ standard (March 2025); provides algorithmic diversity as a code-based backup to lattice-based ML-KEM.

---

### Age Encryption Format

**Goal:** Provide a simple, modern file encryption format with explicit key management -- small copy-pastable keys, no configuration, and composable UNIX-style operation -- as a practical replacement for GPG/PGP file encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **age X25519 recipient** | 2019 | X25519 + HKDF + ChaCha20-Poly1305 | Asymmetric encryption to an `age1...` public key; ephemeral X25519 key agreement [[1]](https://github.com/FiloSottile/age) |
| **age scrypt recipient** | 2019 | scrypt + ChaCha20-Poly1305 | Password-based encryption; scrypt KDF with configurable work factor [[1]](https://github.com/FiloSottile/age) |
| **age SSH recipient** | 2019 | ssh-rsa / ssh-ed25519 | Encrypt to existing SSH keys; no new key management needed [[1]](https://github.com/FiloSottile/age) |
| **age plugin system** | 2021 | Extensible | Plugins for YubiKey (PIV), cloud KMS, passkeys, etc. [[1]](https://words.filippo.io/age-plugins/) |

**State of the art:** Format specification v1 [[1]](https://age-encryption.org/v1); reference implementation by Filippo Valsorda [[2]](https://github.com/FiloSottile/age). Implementations in Go, Rust (rage), Java (jagged), Python, and others. Used in SOPS, chezmoi, and infrastructure automation. Post-quantum recipient support added in age v1.3.0+ via ML-KEM-768 plugin. No algorithm negotiation by design -- single fixed cipher suite per recipient type. Related to [Key Wrapping / Envelope Encryption](#key-wrapping--envelope-encryption) and [Password-Based Key Derivation](#password-based-key-derivation-kdf--pake).

**Production readiness:** Mature
Used in SOPS, chezmoi, and infrastructure automation; audited implementations in Go and Rust; growing adoption as GPG replacement.

**Implementations:**
- [age](https://github.com/FiloSottile/age) ⭐ 21k — Go, reference implementation by Filippo Valsorda
- [rage](https://github.com/str4d/rage) ⭐ 3.4k — Rust, age-compatible implementation
- [pyage](https://github.com/jojonas/pyage) ⭐ 34 — Python, age implementation

**Security status:** Secure
X25519 + HKDF + ChaCha20-Poly1305; no algorithm negotiation eliminates downgrade attacks; no known vulnerabilities.

**Community acceptance:** Emerging
Growing adoption in DevOps and infrastructure tooling; no IETF RFC but well-specified format; endorsed by security engineers as a modern GPG alternative.

---

### SFrame (Secure Frame for Real-Time Media, RFC 9605)

**Goal:** Provide end-to-end encryption for real-time media frames in multiparty video/audio calls, decoupling media encryption from key management so that Selective Forwarding Units (SFUs) can route encrypted media without access to plaintext.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SFrame per-sender keys** | 2024 | AEAD (AES-GCM / AES-CTR+HMAC) | Each sender holds a unique symmetric key; SFU sees only encrypted frames [[1]](https://www.rfc-editor.org/rfc/rfc9605.html) |
| **SFrame key derivation** | 2024 | HKDF-based ratchet | Keys derived from a base secret; ratcheting supports forward secrecy within a session [[1]](https://www.rfc-editor.org/rfc/rfc9605.html) |
| **SFrame + MLS integration** | 2024 | MLS epoch secrets | MLS provides group key agreement; SFrame consumes per-sender media keys from MLS epochs [[1]](https://www.rfc-editor.org/rfc/rfc9605.html)[[2]](https://www.rfc-editor.org/rfc/rfc9420.html) |

**State of the art:** RFC 9605 (IETF, August 2024) [[1]](https://datatracker.ietf.org/doc/rfc9605/). Deployed in Ozone, Cisco Webex, and other WebRTC-based conferencing platforms. Independent of RTP (works with any media transport). Designed to pair with MLS (RFC 9420) for group key management while SFrame handles per-frame authenticated encryption. Cisco reference implementation [[2]](https://github.com/cisco/sframe). Related to [Double Ratchet and KDF Chain Key Management](#double-ratchet-and-kdf-chain-key-management) and [TLS 1.3 Key Schedule](#tls-13-key-schedule).

**Production readiness:** Production
Deployed in Cisco Webex and WebRTC-based conferencing platforms for end-to-end encrypted group video calls.

**Implementations:**
- [sframe (Cisco)](https://github.com/cisco/sframe) ⭐ 8 — C++, Cisco reference SFrame implementation
- [sframe-rs](https://github.com/TobTheRock/sframe-rs) ⭐ 6 — Rust, SFrame implementation

**Security status:** Secure
AEAD-based per-frame encryption with HKDF-derived keys; no known attacks; forward secrecy when combined with MLS ratcheting.

**Community acceptance:** Emerging
IETF RFC 9605 (August 2024); designed to pair with MLS (RFC 9420); deployed in Cisco Webex; adoption growing in WebRTC ecosystem.

---

### Oblivious HTTP (OHTTP, RFC 9458)

**Goal:** Enable a client to send HTTP requests to a target server such that no single entity learns both the client's identity (IP address) and the request content, using HPKE-based encapsulation through a relay-gateway architecture.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OHTTP encapsulation** | 2024 | HPKE (RFC 9180) | Client encrypts request to gateway's public key; relay forwards without decrypting [[1]](https://www.rfc-editor.org/rfc/rfc9458.html) |
| **OHTTP key configuration** | 2024 | KEM + KDF + AEAD IDs | Gateway publishes key config (KEM ID, KDF ID, AEAD ID, public key); client fetches via DNS SVCB [[1]](https://www.rfc-editor.org/rfc/rfc9458.html)[[2]](https://datatracker.ietf.org/doc/html/rfc9540) |
| **OHTTP response encapsulation** | 2024 | HPKE export context | Response encrypted with key derived from request's HPKE context; binds response to request [[1]](https://www.rfc-editor.org/rfc/rfc9458.html) |

**State of the art:** RFC 9458 (IETF OHAI WG, January 2024) [[1]](https://www.rfc-editor.org/rfc/rfc9458.html). Deployed by Google Safe Browsing (via Fastly relay), Apple Private Relay, and Mozilla Firefox. Service discovery via RFC 9540 DNS SVCB records [[2]](https://datatracker.ietf.org/doc/html/rfc9540). Cloudflare formal privacy analysis [[3]](https://blog.cloudflare.com/stronger-than-a-promise-proving-oblivious-http-privacy-properties/). Related to [HPKE](#hpke-hybrid-public-key-encryption-rfc-9180) and [Key Exchange](#key-exchange--key-agreement).

**Production readiness:** Production
Deployed by Google Safe Browsing, Apple Private Relay, and Mozilla Firefox in production.

**Implementations:**
- [ohttp (Cloudflare)](https://github.com/martinthomson/ohttp) ⭐ 53 — Rust, OHTTP relay and gateway
- [ohttp-go](https://github.com/chris-wood/ohttp-go) ⭐ 32 — Go, OHTTP implementation
- [Firefox NSS](https://github.com/nss-dev/nss) ⭐ 178 — C, OHTTP support in Firefox

**Security status:** Secure
HPKE-based encapsulation with relay-gateway separation; no known attacks; formal privacy analysis by Cloudflare.

**Community acceptance:** Standard
IETF RFC 9458 (January 2024); deployed by Google, Apple, and Mozilla; RFC 9540 for service discovery.

---
