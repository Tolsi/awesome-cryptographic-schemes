# Secure Communication Protocols


<!-- TOC -->
## Contents (49 schemes)

- [Secure Channels / Protocol Constructions](#secure-channels--protocol-constructions)
- [Double Ratchet / Symmetric Ratchet](#double-ratchet--symmetric-ratchet)
- [Continuous Group Key Agreement (CGKA) / MLS](#continuous-group-key-agreement-cgka--mls)
- [X3DH / Extended Triple DH Key Agreement](#x3dh--extended-triple-dh-key-agreement)
- [DTLS / Datagram TLS](#dtls--datagram-tls)
- [IKEv2 / IPsec ESP](#ikev2--ipsec-esp)
- [OpenPGP (RFC 9580)](#openpgp-rfc-9580)
- [QUIC Packet Protection](#quic-packet-protection)
- [BIP 324 / Opportunistic P2P Encryption](#bip-324--opportunistic-p2p-encryption)
- [Apple PQ3 / Post-Quantum iMessage](#apple-pq3--post-quantum-imessage)
- [KEMTLS (Post-Quantum TLS)](#kemtls-post-quantum-tls)
- [Encrypted Client Hello (ECH)](#encrypted-client-hello-ech)
- [EAP-PWD / Password-Based Enterprise WiFi Auth](#eap-pwd--password-based-enterprise-wifi-auth)
- [Message Franking / Abuse Reporting in E2E](#message-franking--abuse-reporting-in-e2e)
- [Group Key Agreement](#group-key-agreement)
- [Token-Based Authentication (TOTP / FIDO2 / WebAuthn)](#token-based-authentication-totp--fido2--webauthn)
- [SSH Transport Layer / Secure Shell Cryptography](#ssh-transport-layer--secure-shell-cryptography)
- [SRTP / Secure Real-time Transport Protocol](#srtp--secure-real-time-transport-protocol)
- [S/MIME (Secure/Multipurpose Internet Mail Extensions)](#smime-securemultipurpose-internet-mail-extensions)
- [OMEMO (Signal Protocol for XMPP)](#omemo-signal-protocol-for-xmpp)
- [DKIM / DomainKeys Identified Mail](#dkim--domainkeys-identified-mail)
- [ZRTP / VoIP Media-Path Key Agreement](#zrtp--voip-media-path-key-agreement)
- [DNSCurve / Link-Level DNS Encryption](#dnscurve--link-level-dns-encryption)
- [Briar / Bramble P2P Encrypted Messaging](#briar--bramble-p2p-encrypted-messaging)
- [Tox Protocol / Serverless P2P E2E Encrypted Chat](#tox-protocol--serverless-p2p-e2e-encrypted-chat)
- [Olm / Matrix Pairwise Ratchet](#olm--matrix-pairwise-ratchet)
- [WireGuard Noise_IKpsk2 Handshake](#wireguard-noise_ikpsk2-handshake)
- [STARTTLS / Opportunistic vs. Mandatory TLS](#starttls--opportunistic-vs-mandatory-tls)
- [Oblivious HTTP (OHTTP)](#oblivious-http-ohttp)
- [ACME Protocol / Automated Certificate Management](#acme-protocol--automated-certificate-management)
- [WhatsApp Key Transparency / Auditable Key Directory (AKD)](#whatsapp-key-transparency--auditable-key-directory-akd)
- [TLS 1.3 0-RTT / Early Data Security Properties](#tls-13-0-rtt--early-data-security-properties)
- [QUIC Connection Migration and Security](#quic-connection-migration-and-security)
- [RPKI / BGPsec (Route Origin Authentication)](#rpki--bgpsec-route-origin-authentication)
- [MASQUE / HTTP/3-Based Tunneling Security](#masque--http3-based-tunneling-security)
- [DNS over HTTPS (DoH) and DNS over TLS (DoT)](#dns-over-https-doh-and-dns-over-tls-dot)
- [I2P — Garlic Routing and Tunnel-Based Anonymity](#i2p--garlic-routing-and-tunnel-based-anonymity)
- [Post-Quantum TLS Handshake — X25519Kyber768 Hybrid in Practice](#post-quantum-tls-handshake--x25519kyber768-hybrid-in-practice)
- [Nostr — Cryptographic Identity and Relay-Based Messaging](#nostr--cryptographic-identity-and-relay-based-messaging)
- [Cwtch and Session Protocol — Metadata-Resistant Group Messaging](#cwtch-and-session-protocol--metadata-resistant-group-messaging)
- [MIMI / More Instant Messaging Interoperability](#mimi--more-instant-messaging-interoperability)
- [SFrame / Secure Frame for Real-Time Media](#sframe--secure-frame-for-real-time-media)
- [Rosenpass / Post-Quantum Key Exchange for WireGuard](#rosenpass--post-quantum-key-exchange-for-wireguard)
- [age / Modern File Encryption Format](#age--modern-file-encryption-format)
- [Saltpack / NaCl-Based Authenticated Message Format](#saltpack--nacl-based-authenticated-message-format)
- [NTS / Network Time Security](#nts--network-time-security)
- [Roughtime / Authenticated Rough Time Synchronization](#roughtime--authenticated-rough-time-synchronization)
- [SCRAM / Salted Challenge Response Authentication Mechanism](#scram--salted-challenge-response-authentication-mechanism)
- [tcpcrypt / Opportunistic TCP Stream Encryption](#tcpcrypt--opportunistic-tcp-stream-encryption)
<!-- /TOC -->


## Secure Channels / Protocol Constructions

**Goal:** End-to-end security. Combine key exchange, encryption, authentication, and ratcheting into a complete secure communication protocol. These are where all the primitives come together.

| Protocol | Year | Components | Note |
|----------|------|------------|------|
| **TLS 1.3** | 2018 | ECDHE + AEAD + HKDF | Standard Internet security protocol; 1-RTT handshake; RFC 8446 [[1]](https://www.rfc-editor.org/rfc/rfc8446) |
| **Signal Protocol (Double Ratchet)** | 2013 | X3DH + AES-CBC + HMAC-SHA256 | Asynchronous E2E messaging; forward secrecy + post-compromise security [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **WireGuard** | 2017 | Noise IK + X25519 + ChaCha20-Poly1305 | Minimalist VPN; ~4000 lines of code [[1]](https://www.wireguard.com/papers/wireguard.pdf) |
| **MLS (Messaging Layer Security)** | 2023 | TreeKEM + HPKE + AEAD | Scalable group E2E messaging; RFC 9420 [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **Noise Framework** | 2018 | DH patterns + AEAD | Composable handshake patterns (XX, IK, NK, etc.) [[1]](https://noiseprotocol.org/noise.html) |
| **Encrypted Client Hello (ECH)** | 2024 | HPKE (RFC 9180) | **RFC 9849**; encrypts entire TLS ClientHello; hides SNI from observers; deployed in Chrome, Firefox [[1]](https://www.rfc-editor.org/rfc/rfc9849.html) |

**State of the art:** TLS 1.3 (web), Signal (messaging), MLS (group chat), WireGuard (VPN), ECH (SNI privacy).

**Production readiness:** Production
Deployed across billions of devices: TLS 1.3 in all major browsers, Signal Protocol in WhatsApp/Signal, WireGuard in Linux kernel, MLS in Cisco Webex.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; reference TLS 1.3 implementation
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift; Signal Protocol (Double Ratchet + X3DH)
- [WireGuard](https://git.zx2c4.com/wireguard-linux) — C; Linux kernel VPN module
- [OpenMLS](https://github.com/openmls/openmls) ⭐ 905 — Rust; MLS (RFC 9420) implementation

**Security status:** Secure
All listed protocols are considered secure at recommended parameters with no known practical attacks.

**Community acceptance:** Standard
TLS 1.3 (RFC 8446), MLS (RFC 9420), WireGuard (IETF RFC pending), ECH (RFC 9849) — all IETF-standardized or on the standards track.

---

## Double Ratchet / Symmetric Ratchet

**Goal:** Continuous key renewal. Each message uses a fresh encryption key derived from a ratcheting chain, providing forward secrecy (past messages stay safe if key leaks) and post-compromise security (future messages heal after compromise). Core of modern secure messaging.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OTR (Off-the-Record) Ratchet** | 2004 | DH | First ratcheting protocol; per-message DH for forward secrecy [[1]](https://otr.cypherpunks.ca/otr-wpes.pdf) |
| **Axolotl / Double Ratchet** | 2016 | DH + KDF chain | Signal's protocol: DH ratchet (asymmetric) + symmetric KDF chain [[1]](https://signal.org/docs/specifications/doubleratchet/) |
| **Sesame (Signal)** | 2017 | Double Ratchet + X3DH | Session management for multiple devices [[1]](https://signal.org/docs/specifications/sesame/) |
| **Matrix / Megolm** | 2016 | Symmetric ratchet | Group messaging ratchet; sender ratchet only (efficient for groups) [[1]](https://gitlab.matrix.org/matrix-org/olm/-/blob/master/docs/megolm.md) |

**State of the art:** Signal Double Ratchet (WhatsApp, Signal, Google Messages); Megolm for large groups. See also [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
Deployed in WhatsApp (~3B users), Signal, Google Messages, Facebook Messenger, and Matrix (Megolm).

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift; canonical Double Ratchet implementation
- [vodozemac](https://github.com/matrix-org/vodozemac) ⭐ 347 — Rust; Matrix Olm/Megolm implementation (formally verified via Hax)
- [olm](https://gitlab.matrix.org/matrix-org/olm) — C/C++; original Matrix Double Ratchet (deprecated in favour of vodozemac)

**Security status:** Secure
Provides forward secrecy and post-compromise security. Extensively analysed; no known practical attacks on the Double Ratchet construction.

**Community acceptance:** Standard
Widely trusted and peer-reviewed. Signal Protocol is the de facto standard for pairwise E2E messaging. Megolm is the standard group ratchet in the Matrix ecosystem.

---

## Continuous Group Key Agreement (CGKA) / MLS

**Goal:** Scalable group E2E encryption. Efficiently manage a shared group key as members join and leave — with forward secrecy and post-compromise security. Extension of the double ratchet to groups of thousands.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ART (Asynchronous Ratcheting Tree)** | 2018 | DH tree | First tree-based group ratchet; O(log n) update cost [[1]](https://eprint.iacr.org/2017/666) |
| **TreeKEM** | 2018 | KEM + binary tree | Core of MLS; each member holds a leaf; update = path of KEMs [[1]](https://inria.hal.science/hal-02425247) |
| **MLS (Messaging Layer Security)** | 2023 | TreeKEM + proposals | **IETF RFC 9420**; standard for group E2E messaging [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **CoCoA (Continuous Cooperative Key Agreement)** | 2022 | Server-aided CGKA | Relaxed model; server helps coordinate but learns nothing [[1]](https://eprint.iacr.org/2022/251) |

**State of the art:** MLS (RFC 9420); adopted by Cisco Webex, Wire, Matrix. Extends [Double Ratchet](#double-ratchet--symmetric-ratchet) to groups.

**Production readiness:** Production
RFC 9420 finalized in 2023; deployed in Cisco Webex, Wire, and under adoption in Matrix.

**Implementations:**
- [OpenMLS](https://github.com/openmls/openmls) ⭐ 905 — Rust; modular MLS implementation
- [mls-rs](https://github.com/awslabs/mls-rs) ⭐ 213 — Rust; AWS-backed MLS library
- [go-mls](https://github.com/cisco/go-mls) ⭐ 59 — Go; Cisco's MLS implementation
- [MLSpp](https://github.com/cisco/mlspp) ⭐ 138 — C++; Cisco reference implementation

**Security status:** Secure
Formally analysed; no known practical attacks at recommended parameters. TreeKEM provides efficient forward secrecy and post-compromise security for groups.

**Community acceptance:** Standard
IETF RFC 9420 (2023). Adopted by major messaging platforms; endorsed by the IETF MLS working group.

---

## X3DH / Extended Triple DH Key Agreement

**Goal:** Asynchronous key agreement for end-to-end encrypted messaging. Allows a sender to establish a shared secret with an offline recipient using only pre-uploaded public keys, without requiring simultaneous online presence. The foundation of the Signal Protocol and derivative messaging systems.

| Component | Role |
|-----------|------|
| **Identity key (IK)** | Long-term EC key pair; certified by the server |
| **Signed pre-key (SPK)** | Medium-term key; uploaded to server; signed by IK |
| **One-time pre-key (OPK)** | Single-use ephemeral key; consumed per session |
| **Ephemeral key (EK)** | Per-message key generated by sender |

**Protocol (sender → offline recipient):**
1. Fetch IK_B, SPK_B (+ signature), OPK_B from server
2. Generate ephemeral EK_A
3. Compute 4 DH values: DH(IK_A, SPK_B) ∥ DH(EK_A, IK_B) ∥ DH(EK_A, SPK_B) ∥ DH(EK_A, OPK_B)
4. Derive master secret via HKDF over all 4 DH outputs
5. Send (IK_A, EK_A, OPK_B identifier) + encrypted initial message

| Scheme | Year | Note |
|--------|------|------|
| **X3DH** | 2016 | Signal Foundation; used in Signal, WhatsApp (~3B users), Facebook Messenger [[1]](https://signal.org/docs/specifications/x3dh/) |
| **PQXDH** | 2023 | Post-quantum X3DH; replaces one DH with ML-KEM-1024; deployed in Signal [[1]](https://signal.org/docs/specifications/pqxdh/) |

**Security properties:** Forward secrecy (EK_A deleted after use), deniability (no long-term signatures on message content), break-in recovery (via [Double Ratchet](#double-ratchet--symmetric-ratchet)).

**State of the art:** PQXDH (2023) deployed in Signal for all new sessions — first production PQ upgrade in a major messaging app. Combines X25519 DH with ML-KEM-1024 in a hybrid fashion; keys derived from both.

**Production readiness:** Production
X3DH deployed in Signal, WhatsApp (~3B users), Facebook Messenger. PQXDH deployed in Signal since 2023.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift; canonical X3DH and PQXDH implementation
- [vodozemac](https://github.com/matrix-org/vodozemac) ⭐ 347 — Rust; X3DH for Matrix/Olm sessions

**Security status:** Secure
X3DH is well-analysed with formal proofs. PQXDH adds post-quantum resistance via ML-KEM-1024 hybrid; no known attacks.

**Community acceptance:** Widely trusted
Not an IETF RFC but universally adopted in the messaging industry. Peer-reviewed and formally analysed. PQXDH represents the cutting edge of PQ messaging deployment.

---

## DTLS / Datagram TLS

**Goal:** Provide TLS-equivalent security over unreliable, out-of-order, loss-prone UDP transport — without requiring reliable delivery. Used wherever UDP is preferred over TCP: real-time communication, IoT, gaming, DNS-over-UDP.

**Key differences from TLS:**

| Feature | TLS (over TCP) | DTLS (over UDP) |
|---------|---------------|----------------|
| Delivery guarantee | TCP handles it | Application must handle loss |
| Handshake | Sequential | With retransmission timers |
| Record layer | Stream | Datagram (epoch + sequence) |
| Replay protection | TCP seq. numbers | Sliding-window anti-replay |
| Connection migration | No | DTLS 1.3 Connection ID (CID) |

**DTLS 1.3 (RFC 9147, 2022) crypto:**
- Handshake mirrors TLS 1.3: ECDHE (X25519) + signature for auth
- Record protection: AES-128-GCM / AES-256-GCM / ChaCha20-Poly1305
- Epoch numbers prevent cross-epoch decryption: `nonce = epoch || seq`
- **Connection ID (CID)**: persistent identifier survives NAT rebinding (critical for mobile IoT)
- **Cookie exchange**: HelloVerifyRequest proves client IP before allocating state (DoS mitigation)

| Version | RFC | Note |
|---------|-----|------|
| **DTLS 1.0** | RFC 4347 (2006) | Based on TLS 1.1; largely obsolete |
| **DTLS 1.2** | RFC 6347 (2012) | Based on TLS 1.2; widely deployed |
| **DTLS 1.3** | RFC 9147 (2022) | Based on TLS 1.3; unified record format, CID |

**Deployments:** WebRTC (browser A/V), COAP/IoT (RFC 7252), gaming (Valve/Steam), enterprise VPN (DTLS-based), DNS-over-DTLS (RFC 8094).

**State of the art:** DTLS 1.3 (RFC 9147, 2022). All major TLS libraries support DTLS 1.3 (OpenSSL 3.2+, wolfSSL, mbedTLS). Connection ID (RFC 9146) is the key innovation — enables session continuity across IP changes without re-handshake.

**Production readiness:** Production
DTLS 1.2 widely deployed in WebRTC, IoT (CoAP), and enterprise VPN. DTLS 1.3 supported in major TLS libraries since 2024.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; DTLS 1.2 and 1.3 support (3.2+)
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C; embedded-focused DTLS
- [mbedTLS](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C; ARM-backed; DTLS for constrained devices
- [tinydtls](https://github.com/eclipse/tinydtls) ⭐ 118 — C; minimal DTLS for IoT

**Security status:** Secure
DTLS 1.3 mirrors TLS 1.3 security properties. DTLS 1.2 is secure at recommended parameters; DTLS 1.0 is deprecated.

**Community acceptance:** Standard
IETF RFC 9147 (DTLS 1.3), RFC 6347 (DTLS 1.2). Mandated by WebRTC (RFC 8827) for media key exchange.

---

## IKEv2 / IPsec ESP

**Goal:** Secure network-layer IP traffic between two endpoints (hosts or gateways). IKEv2 establishes cryptographic keying material; ESP (Encapsulating Security Payload) applies per-packet authenticated encryption. The dominant VPN and site-to-site tunnel protocol in enterprise and carrier networks.

**Architecture — two protocols:**

```
[IKEv2] — control plane (UDP port 500/4500)
  Phase 1 (IKE_SA): authenticate peers + establish IKE SA
  Phase 2 (CREATE_CHILD_SA): derive Child SA keys for ESP

[ESP] — data plane (IP protocol 50)
  Per-packet: AEAD(SPI + seqno + payload)
```

**IKEv2 handshake crypto:**

| Step | Operation |
|------|-----------|
| IKE_SA_INIT | ECDH (Curve25519 / P-256 / P-384) or FFDH key exchange |
| IKE_AUTH | Peer authentication: RSA/ECDSA cert, PSK, or EAP |
| PRF | HMAC-SHA-256 / HMAC-SHA-384 / AES-XCBC |
| Key derivation | SKEYSEED → 7 keys via PRF+ (RFC 7296 §2.14) |
| Child SA | PFS re-key via new Diffie-Hellman exchange |

**ESP encryption:**

| Cipher | Status |
|--------|--------|
| AES-256-GCM | Recommended (AEAD, no separate MAC) |
| AES-256-CBC + HMAC-SHA-256 | Legacy (separate encryption + integrity) |
| ChaCha20-Poly1305 | RFC 8750 (2020); for software-only environments |

**Deployment scale:** Every enterprise VPN (Cisco, Juniper, Palo Alto, strongSwan), carrier-grade NAT traversal, smartphone VPN (iOS/Android native IPsec), AWS Site-to-Site VPN. RFC 7296 (IKEv2), RFC 4303 (ESP).

**State of the art:** IKEv2 with AES-256-GCM and ECDH P-384 or X25519; PFS mandatory. PQ extensions: ML-KEM in IKEv2 via RFC 9370 (Additional Diffie-Hellman Groups). strongSwan (open-source) and libreswan are production-grade open implementations.

**Production readiness:** Production
Deployed in every major enterprise VPN appliance, carrier-grade infrastructure, and built into iOS/Android native VPN stacks.

**Implementations:**
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C; full IKEv2/IPsec; Linux, Android, macOS, Windows
- [Libreswan](https://github.com/libreswan/libreswan) ⭐ 935 — C; IKEv2 implementation for Linux; FIPS-certified builds available
- [isakmpd/iked](https://github.com/openbsd/src/tree/master/sbin/iked) ⭐ 3.7k — C; OpenBSD native IKEv2 daemon

**Security status:** Secure
IKEv2 with AEAD (AES-256-GCM) and PFS (ECDH) is considered secure. Legacy configurations (IKEv1, 3DES, DH group 1) are deprecated.

**Community acceptance:** Standard
IETF RFC 7296 (IKEv2), RFC 4303 (ESP). Universally deployed in enterprise and carrier networks. PQ extensions in progress via RFC 9370.

---

## OpenPGP (RFC 9580)

**Goal:** End-to-end encrypted and signed email and file encryption using a decentralized web of trust — no CA hierarchy required. The de facto standard for developer and activist email privacy since 1991.

**RFC 9580 (2024) — what changed from RFC 4880:**

| Feature | RFC 4880 (old) | RFC 9580 (new) |
|---------|---------------|---------------|
| Symmetric encryption | AES-128-CBC | AES-256-GCM (AEAD) |
| AEAD modes | None | OCB, EAX, GCM |
| Public-key algo | RSA, DSA, ElGamal | + Ed25519, X25519, Ed448, X448 |
| Hash | SHA-1 (allowed) | SHA-1 deprecated; SHA-256/512 |
| Key fingerprint | SHA-1 of key bytes | SHA-256 of key bytes (v6) |
| Padding | Unpadded | Message padding for metadata leakage |

**Core cryptographic operations:**

1. **Session key encryption:** Recipient's public key (ECDH X25519 or RSA-OAEP) encrypts a random session key
2. **Payload encryption:** Session key → AES-256-OCB (RFC 9580) or legacy CFB
3. **Signature:** Sender's private key (Ed25519 or RSA-PSS) signs message hash
4. **Key certification:** Other keys sign ("certify") a key's User ID → web of trust

**Web of Trust vs. CA:** No central authority. Trust is transitive: if Alice signs Bob's key and Bob signs Carol's, Alice may transitionally trust Carol. Decentralized but complex UX.

**Deployments:** Thunderbird (built-in OpenPGP since 78), GPG 2.4+ (RFC 9580 support), Proton Mail (OpenPGP E2E), Sequoia-PGP (Rust, modern implementation), Keybase (retired but influential).

**State of the art:** RFC 9580 (2024) with v6 keys (Ed25519 + X25519), AEAD (OCB mode), SHA-256 fingerprints. Major implementations migrating from RFC 4880. SHA-1 fingerprint collision (2019 SHAttered attack) made RFC 4880 fingerprints unsafe — RFC 9580 is the fix.

**Production readiness:** Production
Deployed for decades in email encryption, software signing, and developer workflows. RFC 9580 migration ongoing.

**Implementations:**
- [GnuPG](https://gnupg.org/) — C; the dominant OpenPGP implementation; v2.4+ supports RFC 9580
- [Sequoia-PGP](https://gitlab.com/sequoia-pgp/sequoia) — Rust; modern, memory-safe OpenPGP library
- [OpenPGP.js](https://github.com/openpgpjs/openpgpjs) ⭐ 5.9k — JavaScript; used by Proton Mail
- [GopenPGP](https://github.com/ProtonMail/gopenpgp) ⭐ 1.2k — Go; Proton Mail's Go OpenPGP wrapper

**Security status:** Caution
RFC 9580 with v6 keys (Ed25519, AEAD) is secure. Legacy RFC 4880 configurations using SHA-1 fingerprints and CFB mode without AEAD require migration. SHA-1 collision attacks make old fingerprints unsafe.

**Community acceptance:** Standard
IETF RFC 9580 (2024). Long-established standard for encrypted email and file signing, though web-of-trust UX limits mainstream adoption.

---

## QUIC Packet Protection

**Goal:** Adapt TLS 1.3's record layer for an unreliable, out-of-order UDP transport — protecting packet contents, headers (partially), and preventing injection/replay attacks at the network layer. Used in HTTP/3; carries ~30% of global web traffic (2024).

**Architecture — two layers of crypto:**

| Layer | Scope | Cipher |
|-------|-------|--------|
| **Header Protection** | Packet number + first byte flags | AES-ECB or ChaCha20 keystream (mask, not AEAD) |
| **Payload Protection** | Full packet body | AES-128-GCM / AES-256-GCM / ChaCha20-Poly1305 |

**Key schedule (RFC 9001):**

1. QUIC extracts TLS 1.3 secrets from TLS handshake (HKDF-based)
2. Derives separate write keys for client/server in each direction
3. `QUIC-initial-salt` + client random → initial secrets (unencrypted phase)
4. After handshake: TLS 1.3 handshake secrets → QUIC 1-RTT keys
5. Key updates: triggered explicitly via `KEY_PHASE` bit flip; new keys derived without new handshake

**Why QUIC differs from TLS-over-TCP:**
- Nonce = packet number (must not repeat); packet numbers can be implicit (1 byte)
- Header protection prevents observers from seeing packet number changes (linkability attack mitigation)
- 0-RTT replay protection: server tracks `NEW_TOKEN` bindings to prevent replay across connections

| Standard | Description |
|----------|-------------|
| **RFC 9000** | QUIC transport |
| **RFC 9001** | Using TLS 1.3 with QUIC (crypto layer) |
| **RFC 9002** | QUIC loss detection and congestion control |

**State of the art:** RFC 9001 (2021) is the cryptographic specification. HTTP/3 mandates QUIC. All major browsers and CDNs (Cloudflare, Google, Fastly) deploy QUIC. See [Secure Channels](#secure-channels--protocol-constructions) and [Authenticated Encryption](02-authenticated-structured-encryption.md#authenticated-encryption-aead).

**Production readiness:** Production
Carries ~30% of global web traffic (2024). Deployed in all major browsers and CDNs.

**Implementations:**
- [quiche](https://github.com/cloudflare/quiche) ⭐ 11k — Rust; Cloudflare's QUIC + HTTP/3 implementation
- [ngtcp2](https://github.com/ngtcp2/ngtcp2) ⭐ 1.4k — C; QUIC library used in curl
- [MsQuic](https://github.com/microsoft/msquic) ⭐ 4.7k — C; Microsoft's cross-platform QUIC
- [quic-go](https://github.com/quic-go/quic-go) ⭐ 11k — Go; used in Caddy and other Go projects

**Security status:** Secure
Inherits TLS 1.3 security properties. Header protection and AEAD payload protection are well-analysed.

**Community acceptance:** Standard
IETF RFC 9000 (transport), RFC 9001 (crypto), RFC 9002 (congestion). HTTP/3 mandates QUIC. Universally deployed.

---

## BIP 324 / Opportunistic P2P Encryption

**Goal:** Encrypt all Bitcoin peer-to-peer traffic so it is indistinguishable from random bytes, preventing ISP-level traffic analysis, injection attacks, and network-level censorship — without requiring authentication (opportunistic encryption).

| Property | Detail |
|----------|--------|
| **Cipher** | ChaCha20-Poly1305 (AEAD) |
| **Key exchange** | X25519 ECDH (ephemeral, per-connection) |
| **Handshake** | Elligator-encoded public keys → output appears random |
| **Forward secrecy** | Yes — ephemeral keys per session |
| **Authentication** | Optional manual verification via session ID (MITM resistant if verified) |
| **Deployed** | Bitcoin Core 26.0+ (2023); majority of Bitcoin nodes by 2025 |

**Wire format:** Each side sends a random-looking 64-byte EC point as its ephemeral public key. After X25519, both sides derive session keys via HKDF. All subsequent messages are AEAD-encrypted with a 3-byte length prefix (also encrypted, to prevent traffic fingerprinting).

**Key insight — Elligator encoding:** Unencoded X25519 public keys have a detectable bit pattern. BIP 324 uses Elligator2 to encode keys as uniformly random 32-byte strings, making the handshake indistinguishable from random noise.

**State of the art:** BIP 324 (2024) is the cryptographic foundation for Bitcoin's V2 P2P protocol; deployed in Bitcoin Core 27.0. Motivates similar opportunistic encryption for other P2P networks. See [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
Deployed in Bitcoin Core 26.0+ (2023); majority of Bitcoin nodes running V2 transport by 2025.

**Implementations:**
- [Bitcoin Core](https://github.com/bitcoin/bitcoin) ⭐ 88k — C++; reference implementation of BIP 324 V2 P2P transport
- [rust-bitcoin (bip324)](https://github.com/rust-bitcoin/bip324) ⭐ 29 — Rust; BIP 324 library for Rust Bitcoin ecosystem

**Security status:** Secure
Uses well-studied primitives (X25519 + ChaCha20-Poly1305 + Elligator2). Opportunistic encryption without authentication; MITM possible without manual SAS verification.

**Community acceptance:** Standard
Bitcoin BIP 324; adopted by Bitcoin Core. Well-received by the Bitcoin developer community. Peer-reviewed.

---

## Apple PQ3 / Post-Quantum iMessage

**Goal:** Upgrade iMessage to post-quantum security while maintaining strong forward secrecy and break-in recovery properties — without requiring both parties to be online simultaneously. Deployed to ~2 billion devices in iOS 17.4 (2024).

**Security level classification (Apple's own scale):**
- Level 1: Classical E2E encryption (e.g., Signal pre-PQXDH)
- Level 2: PQ key establishment only (e.g., Signal PQXDH)
- **Level 3 (PQ3):** PQ key establishment + ongoing PQ rekeying after compromise

**Protocol design:**

| Component | Mechanism |
|-----------|-----------|
| Initial key exchange | ML-KEM-768 + P-256 (hybrid) |
| Rekeying | Every ~50 message "epochs": new ML-KEM keys uploaded to APN server |
| Message encryption | AES-256-CTR + HMAC-SHA256 derived from ratchet state |
| Authentication | ECDSA P-256 device certificate chain (to Apple ID) |
| Forward secrecy | Per-epoch ratcheted keys; old keys deleted |
| Break-in recovery | New ML-KEM public keys fetched → fresh PQ entropy injected |

**Key innovation vs. Signal PQXDH:** Signal injects PQ entropy only at session start. PQ3 re-injects it continuously via server-stored pre-keys, so even if a device is compromised for a period, future messages recover PQ security once new keys are fetched.

**Formal analysis:** Linker et al. (USENIX Security 2025) verified PQ3 with Tamarin prover under standard symbolic model.

**State of the art:** PQ3 (2024) is the first large-scale deployment of ongoing PQ rekeying in a consumer messaging app. Sets a new bar beyond [PQXDH](#x3dh--extended-triple-dh-key-agreement). See [Key Exchange](#group-key-agreement), [Double Ratchet](#double-ratchet--symmetric-ratchet).

**Production readiness:** Production
Deployed to ~2 billion devices in iOS 17.4+ (2024). All new iMessage conversations use PQ3.

**Implementations:**
- Apple iMessage (closed-source) — the only implementation; built into iOS, macOS, iPadOS, watchOS

**Security status:** Secure
Formally verified with Tamarin prover (Linker et al., USENIX Security 2025). Hybrid ML-KEM-768 + P-256 with continuous PQ rekeying. No known attacks.

**Community acceptance:** Widely trusted
Proprietary Apple protocol; not an open standard. Formally analysed and well-received by cryptographers. Sets a new benchmark for PQ messaging security.

---

## KEMTLS (Post-Quantum TLS)

**Goal:** A post-quantum variant of TLS 1.3 that eliminates the handshake signature entirely — replacing server authentication with the server's KEM public key in its certificate. Reduces PQ migration cost by needing only one PQ primitive (KEM) instead of both a PQ KEM and a PQ signature.

| Property | KEMTLS | TLS 1.3 |
|----------|--------|---------|
| Server auth | KEM encapsulation (implicit auth) | Signature (explicit auth) |
| Client auth | KEM-based (no sig needed) | Certificate + signature |
| Forward secrecy | Yes (ephemeral KEM) | Yes (ephemeral DH) |
| PQ primitives needed | KEM only | KEM + signature |
| Round trips (full) | 2 RTT (+ 0-RTT variant) | 1 RTT |

| Variant | Year | Note |
|---------|------|------|
| **KEMTLS** | 2020 | Original; Schwabe-Stebila-Wiggers; with ML-KEM [[1]](https://eprint.iacr.org/2020/534) |
| **KEMTLS-PDK** | 2021 | Pre-distributed key variant; 0-RTT server auth [[1]](https://eprint.iacr.org/2021/779) |
| **KEMTLS with Kyber** | 2022 | Concrete instantiation with ML-KEM-768 + Dilithium for CA chain; experimental [[1]](https://eprint.iacr.org/2022/1086) |

**State of the art:** KEMTLS (2020) is not yet deployed but is the leading proposal for PQ TLS without PQ signatures. Current TLS deployments use hybrid X25519+ML-KEM (see [PQ Key Exchange](#rosenpass--post-quantum-key-exchange-for-wireguard)) for the key exchange, still relying on classical signatures for authentication. KEMTLS targets the next migration step.

**Production readiness:** Research
Academic proposal with experimental implementations; not deployed in production. Targets the next phase of PQ TLS migration.

**Implementations:**
- [Open Quantum Safe (liboqs)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C; PQ KEM library used in KEMTLS prototypes
- [KEMTLS experiment (rustls fork)](https://github.com/thomwiggers/kemtls-experiment) ⭐ 34 — Rust; experimental KEMTLS in rustls

**Security status:** Secure
Formally analysed (Schwabe-Stebila-Wiggers 2020). No known attacks; relies on the security of ML-KEM and the KEMTLS proof.

**Community acceptance:** Emerging
Active academic research and IETF discussion. Not yet standardized. Endorsed by leading PQ cryptographers as the path forward for PQ server authentication.

---

## Encrypted Client Hello (ECH)

**Goal:** Hide website identity from network observers in TLS. Standard TLS exposes the Server Name Indication (SNI) in plaintext — revealing which website you're connecting to. ECH encrypts the entire ClientHello using HPKE, so even the domain name is hidden from passive observers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ESNI (Encrypted SNI)** | 2018 | AES + DH | First attempt; encrypted only SNI field; deployed by Cloudflare [[1]](https://blog.cloudflare.com/encrypted-sni/) |
| **ECH (Encrypted Client Hello)** | 2024 | HPKE (RFC 9180) | **RFC 9849**; encrypts entire ClientHello; deployed in Chrome, Firefox, Cloudflare [[1]](https://www.rfc-editor.org/rfc/rfc9849.html) |

**State of the art:** ECH (RFC 9849, 2024); deployed in major browsers. Complements [ODoH](#oblivious-http-ohttp) and [TLS in Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
Deployed in Chrome, Firefox, and Cloudflare since 2024. RFC 9849 finalized.

**Implementations:**
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C; Google's TLS library; ECH support in Chrome
- [Cloudflare ECH](https://blog.cloudflare.com/encrypted-client-hello/) — deployed on Cloudflare edge
- [NSS](https://github.com/nss-dev/nss) ⭐ 178 — C; Mozilla's TLS library; ECH support in Firefox

**Security status:** Secure
Based on HPKE (RFC 9180). Encrypts entire ClientHello including SNI. No known attacks at recommended parameters.

**Community acceptance:** Standard
IETF RFC 9849 (2024). Endorsed by major browser vendors and CDN providers. Key component of TLS privacy improvements.

---

## EAP-PWD / Password-Based Enterprise WiFi Auth

**Goal:** Mutual password authentication for enterprise WiFi (WPA-Enterprise / 802.1X) with forward secrecy and offline dictionary attack resistance — without client certificates or server-side password hashes.

**Protocol (RFC 5931, based on Dragonfly):**

1. **Hash-to-curve**: Both sides independently map password+IDs onto an elliptic curve point P — without sending P
2. **Commit**: Each sends a blinded ephemeral contribution `(s·P + m·G, m·G)`
3. **Confirm**: Compute shared session key; exchange MACs to confirm agreement
4. **Forward secrecy**: Fresh ephemeral scalars per session

| Property | EAP-MD5 | EAP-PEAP | EAP-PWD |
|----------|---------|---------|---------|
| Mutual auth | No | Yes | Yes |
| Forward secrecy | No | No | Yes |
| Dictionary attack resistance | No | Partial | Yes |
| Client certificate | No | No | No |

**WPA3 SAE:** Simultaneous Authentication of Equals — same Dragonfly construction (RFC 7664) applied to WPA3 personal mode without RADIUS. Mandatory on all WiFi 6 devices (~5B devices by 2025).

**State of the art:** RFC 5931 (EAP-PWD), Wi-Fi Alliance WPA3 SAE (2018). EAP-PWD for enterprise (with RADIUS); SAE for home/small office. See [Password-Based KDF / PAKE](#eap-pwd--password-based-enterprise-wifi-auth), [DTLS](#dtls--datagram-tls).

**Production readiness:** Production
WPA3 SAE is mandatory on all Wi-Fi 6 devices (~5B devices by 2025). EAP-PWD deployed in enterprise RADIUS environments.

**Implementations:**
- [hostapd / wpa_supplicant](https://w1.fi/cgit/) — C; reference Wi-Fi authentication; SAE and EAP-PWD support
- [FreeRADIUS](https://github.com/FreeRADIUS/freeradius-server) ⭐ 2.5k — C; enterprise RADIUS server; EAP-PWD module

**Security status:** Caution
Dragonfly (RFC 7664) is secure at recommended parameters. Side-channel attacks on SAE (Dragonblood, 2019) required patches; all major implementations patched.

**Community acceptance:** Standard
IETF RFC 5931 (EAP-PWD), RFC 7664 (Dragonfly/SAE). Wi-Fi Alliance WPA3 certification mandates SAE.

---

## Message Franking / Abuse Reporting in E2E

**Goal:** Accountable encryption. In E2E encrypted messaging, allow a recipient to report an abusive message to the platform in a way that proves the message content and sender — without giving the platform a decryption backdoor.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Facebook Message Franking** | 2017 | HMAC commitment + AEAD | Sender commits to plaintext via HMAC; platform can verify if reported [[1]](https://eprint.iacr.org/2017/664) |
| **Asymmetric Message Franking (Grubbs et al.)** | 2017 | Compactly committing AEAD | Stronger: works even if sender is malicious [[1]](https://eprint.iacr.org/2017/664) |
| **Traceback for E2E (Hecate)** | 2022 | Threshold tracing + ZK | Trace source of viral content without breaking E2E [[1]](https://eprint.iacr.org/2021/1548) |

**State of the art:** Facebook/Meta message franking (deployed at scale), Hecate (academic, for viral content tracing).

**Production readiness:** Production
Meta's message franking is deployed at scale in Facebook Messenger. Hecate is research-stage.

**Implementations:**
- Meta Messenger (closed-source) — production message franking system
- [Hecate reference](https://eprint.iacr.org/2021/1548) — academic prototype; no public production implementation

**Security status:** Secure
Compactly committing AEAD construction is well-analysed. No known attacks on the franking mechanism itself.

**Community acceptance:** Niche
Deployed by Meta but not an open standard. Academic interest in abuse-reporting-compatible E2E encryption is growing. Not standardized by IETF.

---

## Group Key Agreement

**Goal:** Multi-party key establishment. Extend 2-party Diffie-Hellman to *n* parties who jointly establish a shared group key. Used in group messaging, conferencing, multicast.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Burmester-Desmedt** | 1994 | DH / DLP | 2-round group DH; all parties contribute [[1]](https://link.springer.com/chapter/10.1007/BFb0053443) |
| **Tree-DH (Kim-Perrig-Tsudik)** | 2004 | DH binary tree | Logarithmic rounds; efficient join/leave [[1]](https://dl.acm.org/doi/10.1145/1030083.1030088) |
| **TreeKEM (MLS)** | 2018 | DH + ratchet tree | Used in MLS (RFC 9420); efficient group ratcheting [[1]](https://www.rfc-editor.org/rfc/rfc9420) |
| **Continuous Group Key Agreement (CGKA)** | 2020 | Formal model | Security model for TreeKEM and MLS [[1]](https://eprint.iacr.org/2019/1189) |

**State of the art:** TreeKEM/MLS (messaging), Burmester-Desmedt (classic group DH).

**Production readiness:** Production
TreeKEM/MLS deployed in Cisco Webex, Wire. Burmester-Desmedt is classical; mostly of academic interest.

**Implementations:**
- [OpenMLS](https://github.com/openmls/openmls) ⭐ 905 — Rust; TreeKEM/MLS group key agreement
- [mls-rs](https://github.com/awslabs/mls-rs) ⭐ 213 — Rust; AWS MLS implementation
- [MLSpp](https://github.com/cisco/mlspp) ⭐ 138 — C++; Cisco MLS implementation

**Security status:** Secure
MLS/TreeKEM formally analysed; no known practical attacks. Burmester-Desmedt is secure under DDH assumption.

**Community acceptance:** Standard
MLS is IETF RFC 9420. Burmester-Desmedt is a classic textbook protocol. TreeKEM is the standard group key agreement mechanism.

---

## Token-Based Authentication (TOTP / FIDO2 / WebAuthn)

**Goal:** Practical user authentication. Protocols for proving identity using time-based codes, hardware tokens, or biometric-gated cryptographic keys — replacing or supplementing passwords.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **HOTP** | 2005 | HMAC-SHA1 + counter | Event-based OTP; RFC 4226 [[1]](https://www.rfc-editor.org/rfc/rfc4226) |
| **TOTP** | 2011 | HMAC-SHA1 + time | Time-based OTP; 30-second codes; Google Authenticator; RFC 6238 [[1]](https://www.rfc-editor.org/rfc/rfc6238) |
| **FIDO2 / WebAuthn** | 2019 | ECDSA / Ed25519 + challenge-response | Passwordless auth; hardware keys (YubiKey) or platform biometrics; W3C standard [[1]](https://www.w3.org/TR/webauthn-2/) |
| **Passkeys** | 2022 | FIDO2 + cloud sync | Cross-device FIDO2 credentials; Apple/Google/Microsoft [[1]](https://fidoalliance.org/passkeys/) |

**State of the art:** FIDO2/Passkeys (passwordless, phishing-resistant), TOTP (legacy 2FA).

**Production readiness:** Production
TOTP supported by virtually all major services. FIDO2/WebAuthn supported by Apple, Google, Microsoft. Passkeys deployed across platforms.

**Implementations:**
- [libfido2](https://github.com/Yubico/libfido2) ⭐ 697 — C; FIDO2/CTAP library by Yubico
- [py_webauthn](https://github.com/duo-labs/py_webauthn) ⭐ 1.0k — Python; WebAuthn server library
- [java-webauthn-server](https://github.com/Yubico/java-webauthn-server) ⭐ 544 — Java; Yubico's WebAuthn server
- [Google Authenticator (TOTP)](https://github.com/google/google-authenticator-libpam) ⭐ 2.0k — C; PAM module for TOTP

**Security status:** Secure
FIDO2/WebAuthn is phishing-resistant by design. TOTP is secure but susceptible to real-time phishing (code relay). FIDO2 is the recommended upgrade path.

**Community acceptance:** Standard
FIDO2/WebAuthn is a W3C standard and FIDO Alliance specification. TOTP is IETF RFC 6238. Passkeys endorsed by Apple, Google, Microsoft.

---

## SSH Transport Layer / Secure Shell Cryptography

**Goal:** Provide authenticated, encrypted, integrity-protected remote login and general-purpose secure tunneling over an insecure network — with mutual host authentication and per-session forward secrecy. The dominant protocol for remote server administration.

**Protocol layers (RFC 4251–4254):**

```
[SSH Connection Protocol]   — channels, port forwarding, exec, sftp
[SSH User Authentication]   — password, public-key, GSSAPI
[SSH Transport Layer]       — key exchange, encryption, MAC, compression
```

**Transport layer key exchange (RFC 4253 + updates):**

| Step | Operation |
|------|-----------|
| Algorithm negotiation | Client and server exchange `SSH_MSG_KEXINIT`; agree on KEX, host-key, cipher, MAC |
| Key exchange | DH / ECDH / X25519 generates a shared secret K + exchange hash H |
| Host authentication | Server signs H with its host key (Ed25519, ECDSA P-256, or RSA) |
| Key derivation | 6 keys derived via `HASH(K ∥ H ∥ letter ∥ session_id)` for each direction |

**Supported algorithms (current recommendations, RFC 9142):**

| Category | Algorithms | Status |
|----------|-----------|--------|
| Key exchange | `curve25519-sha256`, `ecdh-sha2-nistp256` | Preferred |
| Key exchange (PQ) | `mlkem768x25519-sha256` (default in OpenSSH 10.0) | State of the art |
| Host key | `ssh-ed25519`, `ecdsa-sha2-nistp256`, `rsa-sha2-256` | Preferred |
| Encryption | `chacha20-poly1305@openssh.com`, `aes128-gcm`, `aes256-gcm` | AEAD preferred |
| MAC | Implicit (AEAD) or `hmac-sha2-256-etm` | ETM preferred |

**`chacha20-poly1305@openssh.com` cipher detail:**
- Requires 512 bits of key material from the KEX output (two 256-bit keys K₁, K₂)
- K₁ encrypts the 4-byte packet length field (length obfuscation)
- K₂ used with Poly1305 for AEAD over the entire packet
- No separate MAC step; no padding oracle; length field also authenticated
- Note: vulnerable to the Terrapin attack (CVE-2023-48795) if `ext-info-c` is not used; fixed by strict KEX

**Post-quantum (OpenSSH 10.0, 2025):** `mlkem768x25519-sha256` is the new default KEX — a hybrid of ML-KEM-768 and X25519, providing both classical and post-quantum forward secrecy.

**State of the art:** OpenSSH 10.0 (2025) defaults to ML-KEM-768 + X25519 hybrid KEX and Ed25519 host keys. RFC 9142 (2022) deprecates weak algorithms (DH group1, hmac-md5). Terrapin patch (strict KEX) in OpenSSH 9.6. See [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
OpenSSH is the dominant SSH implementation; installed on virtually every Linux/macOS/BSD server.

**Implementations:**
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C; reference SSH implementation; PQ hybrid KEX in 10.0
- [libssh](https://www.libssh.org/) — C; SSH client/server library
- [libssh2](https://github.com/libssh2/libssh2) ⭐ 1.5k — C; client-side SSH library (used by curl)
- [Paramiko](https://github.com/paramiko/paramiko) ⭐ 9.7k — Python; SSH2 protocol library
- [russh](https://github.com/warp-tech/russh) ⭐ 1.6k — Rust; async SSH client/server library

**Security status:** Secure
With recommended algorithms (Ed25519, X25519, ChaCha20-Poly1305, AEAD). Terrapin attack (CVE-2023-48795) patched via strict KEX in OpenSSH 9.6+. Legacy algorithms (DH group1, hmac-md5) deprecated.

**Community acceptance:** Standard
IETF RFCs 4251-4254, RFC 9142. Universally deployed for remote server administration. OpenSSH is the de facto standard.

---

## SRTP / Secure Real-time Transport Protocol

**Goal:** Authenticated encryption for real-time audio/video streams over UDP. SRTP adds per-packet confidentiality, integrity, and replay protection to RTP media flows without imposing TCP-style reliability — preserving the low-latency characteristics essential for live communication.

**Architecture — two protocols:**

```
[SRTP]  — secures RTP media packets  (audio, video payloads)
[SRTCP] — secures RTCP control packets (statistics, sender reports)
```

**Cryptographic design (RFC 3711, 2004):**

| Property | Detail |
|----------|--------|
| Encryption | AES-128-CTR (counter mode, default) |
| Integrity | HMAC-SHA1, 80-bit truncated tag appended per packet |
| Replay protection | Sliding window over RTP sequence numbers |
| Key structure | Master key + master salt → session keys via AES-128 PRF |
| Session key derivation | `KDF(master_key, master_salt, index, label)` using AES-128-CM |
| IV construction | `IV = (k_s XOR (SSRC ∥ packet_index)) << 16` |

**Key management — DTLS-SRTP (RFC 5764):**

SRTP does not specify its own key management; instead DTLS-SRTP is the mandatory mechanism in WebRTC:

1. SDP `a=fingerprint:` attribute exchanges DTLS certificate fingerprints out-of-band
2. Peers run a DTLS handshake on the same UDP 5-tuple as the media stream
3. DTLS master secret is fed into SRTP key derivation (RFC 5764 §4.2)
4. After derivation, DTLS record protection is discarded; SRTP takes over for RTP packets
5. Each SSRC uses an independent derived key pair (one per media stream direction)

| Key management method | Standard | Note |
|----------------------|----------|------|
| **DTLS-SRTP** | RFC 5764 (2010) | Mandatory in WebRTC (RFC 8827); in-band, authenticates via certs |
| **SDES (SDP key exchange)** | RFC 4568 | Key in SDP; requires secure signalling; deprecated in WebRTC |
| **MIKEY** | RFC 3830 | IETF alternative; used in SIP/IMS networks |

**Deployments:** All WebRTC implementations (Chrome, Firefox, Safari), SIP-based VoIP (Asterisk, FreeSWITCH), video conferencing (Zoom, Teams use SRTP internally), IPTV multicast.

**State of the art:** RFC 3711 (2004) for SRTP; RFC 5764 (2010) for DTLS-SRTP. WebRTC mandates DTLS-SRTP (RFC 8827, 2021). AES-256-GCM as an SRTP cipher is specified in RFC 7714 (2016) — modernizes SRTP to use AEAD and eliminate the separate HMAC-SHA1. See [DTLS](#dtls--datagram-tls).

**Production readiness:** Production
Deployed in all WebRTC implementations, SIP VoIP systems, and video conferencing platforms.

**Implementations:**
- [libsrtp](https://github.com/cisco/libsrtp) ⭐ 1.4k — C; Cisco's reference SRTP library; used in Chrome and Firefox WebRTC
- [oRTP](https://gitlab.linphone.org/BC/public/ortp) — C; Belledonne Communications; used in Linphone

**Security status:** Secure
RFC 3711 with AES-GCM (RFC 7714) is secure. Original AES-128-CTR + HMAC-SHA1-80 is adequate but AEAD is preferred for new deployments.

**Community acceptance:** Standard
IETF RFC 3711, RFC 5764 (DTLS-SRTP), RFC 7714 (AES-GCM for SRTP), RFC 8827 (WebRTC). Universally deployed in real-time communications.

---

## S/MIME (Secure/Multipurpose Internet Mail Extensions)

**Goal:** End-to-end encrypted and digitally signed email using a PKI (CA-issued certificates) rather than a web of trust — the enterprise and government counterpart to OpenPGP, embedded in every major email client.

**Core operations (RFC 8551, S/MIME v4.0):**

| Operation | Mechanism |
|-----------|-----------|
| Encryption | Recipient's public key (ECDH-P256 or RSA-OAEP) encrypts a random session key; session key encrypts message body |
| Content encryption | AES-128-CBC (legacy), AES-256-CBC, or AES-256-GCM (v4.0) via CMS EnvelopedData |
| Digital signature | Sender's Ed25519 or ECDSA-P256 or RSA-PSS private key signs a hash of the message |
| Signature format | CMS SignedData object; detached or opaque; carried in `multipart/signed` MIME part |
| Key distribution | X.509 certificates from commercial CAs (DigiCert, Sectigo) or enterprise PKI |

**CMS (Cryptographic Message Syntax) structure (RFC 5652):**

```
ContentInfo
  └─ EnvelopedData
       ├─ RecipientInfo (ECDH ephemeral-static or RSA encrypted session key per recipient)
       └─ EncryptedContentInfo (AES-GCM encrypted body)
```

**S/MIME v4.0 improvements over v3.2 (RFC 8551 vs. RFC 5751):**

| Feature | v3.2 (RFC 5751) | v4.0 (RFC 8551) |
|---------|----------------|----------------|
| Signature algorithms | RSA, DSA | + Ed25519, ECDSA |
| Encryption KEM | RSA, ECDH-P256 | + X25519 with HKDF-256 |
| Hash | SHA-1 (allowed) | SHA-1 historic; SHA-256/512 |
| AEAD | None | AES-256-GCM added |

**S/MIME vs. OpenPGP:**

| Property | S/MIME | OpenPGP |
|----------|--------|---------|
| Trust model | CA hierarchy (X.509) | Web of trust (keyservers) |
| Certificate cost | Paid (or enterprise CA) | Free (self-generated) |
| Client support | Native (Outlook, Apple Mail, iOS) | Requires plugin |
| Revocation | CRL / OCSP | Keyserver-based |
| Standardization | IETF (RFC 8551) | IETF (RFC 9580) |

**Deployments:** Microsoft Outlook (built-in), Apple Mail (built-in), iOS/macOS (native), government/military (DoD PKI), healthcare (HIPAA-compliant email), banking.

**State of the art:** RFC 8551 (S/MIME v4.0, 2019) with Ed25519 signatures, X25519 key agreement, and AES-256-GCM. Post-quantum S/MIME is being standardized via IETF draft-ietf-lamps-pq-smime. See [OpenPGP](#openpgp-rfc-9580), [Applied Infrastructure PKI](14-applied-infrastructure-pki.md).

**Production readiness:** Production
Built into Microsoft Outlook, Apple Mail, iOS, Thunderbird. Widely deployed in government and enterprise email.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; CMS/PKCS#7 and S/MIME operations
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java; comprehensive CMS/S/MIME support
- [Thunderbird](https://hg.mozilla.org/comm-central/) — built-in S/MIME support via NSS

**Security status:** Secure
S/MIME v4.0 with Ed25519 and AES-256-GCM is secure. Legacy v3.2 configurations using SHA-1 or RSA-PKCS#1 v1.5 should be upgraded.

**Community acceptance:** Standard
IETF RFC 8551 (S/MIME v4.0). The enterprise and government standard for encrypted email. CA-based trust model with wide client support.

---

## OMEMO (Signal Protocol for XMPP)

**Goal:** End-to-end encryption for XMPP instant messaging that supports multi-device delivery and offline messages — bringing the Signal Protocol's Double Ratchet and X3DH to the federated XMPP ecosystem without requiring a centralized server.

**Protocol design (XEP-0384):**

OMEMO adapts the Signal Protocol for XMPP's publish-subscribe (PubSub) architecture: pre-keys and identity keys are published to the sender's XMPP server; receivers fetch them on-demand.

| Component | Mechanism |
|-----------|-----------|
| Key agreement | X3DH (Extended Triple DH) for session initiation |
| Session encryption | Double Ratchet (AES-256-CBC + HMAC-SHA-256 per message) |
| Key exchange curves | Curve25519 (X3DH DH steps), Ed25519 (identity key signatures) |
| Multi-device delivery | Message encrypted separately to each recipient device key |
| Pre-key distribution | Identity key + signed pre-key + one-time pre-keys via XMPP PubSub |
| Message encoding | OMEMOKeyExchange + ciphertext carried in XMPP `<message>` stanzas |

**Multi-device architecture:**

```
Alice (2 devices) → Bob (3 devices)
  Per message: 5 separate OMEMO key encryptions (one per device key)
  Each device independently decrypts using its own ratchet state
  Message body encrypted once; only the session key is per-device encrypted
```

**OMEMO 2 (XEP-0384 v0.8+, namespace `urn:xmpp:omemo:2`):**
- Switches from Signal's libsignal-protocol to direct Curve25519/Ed25519 primitives
- Adds support for file attachments and arbitrary XMPP stanza encryption (not just `<message>`)
- Clearer specification of double ratchet state serialization
- Version 0.9.0 released April 2025

**Deployments:** Conversations (Android), Gajim (desktop), Dino (Linux), Monal (iOS/macOS), Profanity (CLI). Supported by all major XMPP servers (ejabberd, Prosody, MongooseIM).

**State of the art:** OMEMO 2 (XEP-0384 v0.9.0, 2025); widely deployed in the XMPP ecosystem. Provides the same cryptographic guarantees as Signal (forward secrecy, post-compromise security, deniability) within XMPP's federated model. See [Double Ratchet](#double-ratchet--symmetric-ratchet), [X3DH](#x3dh--extended-triple-dh-key-agreement).

**Production readiness:** Production
Deployed in all major XMPP clients; OMEMO 2 is the current version in active use.

**Implementations:**
- [libomemo-c](https://github.com/dino/libomemo-c) ⭐ 13 — C; OMEMO library for Dino XMPP client
- [Smack OMEMO](https://github.com/igniterealtime/Smack) ⭐ 2.4k — Java; XMPP library with OMEMO support
- [Conversations](https://codeberg.org/iNPUTmice/Conversations) — Java/Android; popular XMPP client with OMEMO built-in
- [python-omemo](https://github.com/Syndace/python-omemo) ⭐ 45 — Python; OMEMO library for Python XMPP clients

**Security status:** Secure
Inherits Signal Protocol's security properties (forward secrecy, post-compromise security). Well-analysed Double Ratchet + X3DH construction.

**Community acceptance:** Widely trusted
XSF XEP-0384. The standard E2E encryption mechanism for XMPP. Widely adopted across clients and servers in the federated XMPP ecosystem.

---

## DKIM / DomainKeys Identified Mail

**Goal:** Cryptographically prove that an email was authorized by the owner of the sending domain — enabling receivers to reject spoofed mail. The signature survives SMTP relay hops and is verified against a public key published in DNS.

**How it works (RFC 6376):**

1. Sending MTA canonicalizes headers + body, computes SHA-256 hash
2. Signs with RSA-SHA256 or Ed25519 over `h=` header list (From, Subject, Date, To, …)
3. Appends `DKIM-Signature:` header with `b=` (base64 signature), `bh=` (body hash), `d=` (domain), `s=` (selector)
4. Receiver fetches `{selector}._domainkey.{domain}` TXT record → RSA/Ed25519 public key
5. Verifier recomputes hash; accepts or rejects

**Signature structure:**
```
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=example.com; s=2024;
  h=from:to:subject:date:message-id;
  bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
  b=Base64(RSA_Sign(SHA256(canonicalized_headers)))
```

**Canonicalization algorithms:**
- `simple` — only allows whitespace at end of header value; body must be unchanged
- `relaxed` — folds whitespace, lowercases header names; handles SMTP relay rewriting

**Key algorithms:**
| Algorithm | Status | Key size | Notes |
|-----------|--------|----------|-------|
| `rsa-sha256` | Current standard | 1024–4096 bit | Widely deployed; 1024-bit keys deprecated |
| `ed25519-sha256` | RFC 8463 (2019) | 256-bit | Smaller DNS records; growing adoption |

**DKIM + DMARC + SPF:**
- **SPF** validates the sending IP against `_spf.` DNS records (envelope sender)
- **DKIM** validates message content against `_domainkey.` DNS records
- **DMARC** (RFC 7489) specifies policy for failures: `none`, `quarantine`, `reject`; requires From: header alignment

**Deployment:** ~95% of major email providers (Gmail, Outlook, Yahoo, FastMail, ProtonMail). Required by Google/Yahoo bulk sender requirements (Feb 2024). DMARC enforces policy; ARC (Authenticated Received Chain, RFC 8617) allows mailing lists to re-sign.

**Limitations:** DKIM does not prevent replay attacks (signature valid indefinitely). Body hash only covers the declared `l=` length (length tag attack). No sender identity beyond domain — internal spoofing (joe@evil.example.com) not addressed by DKIM alone.

**ZK applications:** ZK Email (prove.email) builds ZK proofs over DKIM signatures to prove email contents without revealing the full message. See [zkTLS / MPC-TLS](#kemtls-post-quantum-tls).

**State of the art:** RFC 6376 (2011), updated by RFC 8301, 8463 (Ed25519). DMARC enforcement by major providers 2024 makes DKIM effectively mandatory for deliverability.

**Production readiness:** Production
Deployed by ~95% of major email providers. Required by Google/Yahoo bulk sender requirements (Feb 2024).

**Implementations:**
- [OpenDKIM](https://github.com/trusteddomainproject/OpenDKIM) ⭐ 111 — C; milter-based DKIM signing/verification
- [rspamd](https://github.com/rspamd/rspamd) ⭐ 2.4k — C; spam filter with DKIM/DMARC/ARC support
- [dkimpy](https://launchpad.net/dkimpy) — Python; DKIM signing and verification library

**Security status:** Secure
RSA-SHA256 (2048+ bit keys) and Ed25519 signatures are secure. 1024-bit RSA keys are deprecated. DKIM does not prevent replay (signature valid indefinitely).

**Community acceptance:** Standard
IETF RFC 6376, RFC 8463 (Ed25519). Effectively mandatory for email deliverability. Universally deployed alongside SPF and DMARC.

---

## ZRTP / VoIP Media-Path Key Agreement

**Goal:** In-band, server-free key agreement for encrypted VoIP calls. ZRTP negotiates SRTP session keys directly in the RTP media stream — with no reliance on SIP signalling, PKI, or pre-shared secrets — and protects against man-in-the-middle attacks via a voice-read Short Authentication String (SAS).

**Protocol design (RFC 6189, Phil Zimmermann, 2011):**

| Phase | Mechanism |
|-------|-----------|
| Discovery | Hello / HelloACK messages exchanged over RTP port; both sides advertise supported algorithms |
| Key exchange | Ephemeral DH (FFDH-3072 or ECDH P-256/P-384) generates shared secret `s0` |
| Commit / Confirm | Two-message commitment scheme prevents hash-commitment attacks |
| SRTP key derivation | `s0` → `srtpKeySalt` via HMAC-SHA256; both sides derive same SRTP master keys |
| SAS anti-MitM | Both endpoints display a 4-character string (base32 of hash of DH transcript); users read aloud to verify |
| Key continuity | `rs1` and `rs2` cached shared secrets mixed into next session's `s0`; provides SSH-style continuity |

**SAS mechanism — why it works:** If a MITM intercepts the DH exchange, both parties' SAS values will differ; users who verbally compare them detect the attack. Key continuity additionally means a MitM must sustain the attack across every call — it cannot silently insert itself after the first authenticated session.

**Supported cipher suites (RFC 6189 §5.1):**

| Component | Options |
|-----------|---------|
| Key exchange | DH-3072, DH-4096, ECDH P-256, ECDH P-384 |
| Cipher | AES-128-CFB, AES-256-CFB |
| Hash | SHA-256, SHA-384 |
| SRTP auth | HMAC-SHA1-32, HMAC-SHA1-80 |
| SAS encoding | B32 (4 chars), B256 (2 words) |

**Deployments:** Signal/RedPhone (Android, until 2017; replaced by Signal Protocol channel for auth), Jitsi Desktop (GNU ZRTP4J), Linphone (bZRTP, actively maintained through 2025), Twinkle, Zfone (Zimmermann's reference implementation).

**State of the art:** RFC 6189 (2011). Signal deprecated ZRTP in 2017 in favour of using its own Signal Protocol session for call authentication; DTLS-SRTP is now the WebRTC standard for browser calls. ZRTP remains relevant for SIP/softphone deployments (Linphone, Jitsi). A post-quantum ZRTP extension (replacing DH with a hybrid KEM) is in early draft. See [SRTP](#srtp--secure-real-time-transport-protocol), [DTLS](#dtls--datagram-tls).

**Production readiness:** Mature
Deployed in Linphone and Jitsi Desktop. Largely superseded by DTLS-SRTP for WebRTC. Still relevant for SIP/softphone use cases.

**Implementations:**
- [oRTP / oZRTP (bZRTP)](https://gitlab.linphone.org/BC/public/bzrtp) — C; Linphone's ZRTP implementation; actively maintained
- [GNU ZRTP4J](https://github.com/wernerd/ZRTP4J) ⭐ 27 — Java; used in Jitsi Desktop

**Security status:** Secure
Secure at recommended parameters (ECDH P-256+, AES-256). SAS-based MITM detection is effective when users perform voice verification. No known practical attacks.

**Community acceptance:** Niche
IETF Informational RFC 6189. Superseded by DTLS-SRTP in WebRTC contexts. Remains used in the SIP/softphone ecosystem.

---

## DNSCurve / Link-Level DNS Encryption

**Goal:** Encrypt and authenticate every DNS query and response between a recursive resolver and an authoritative nameserver — using fast elliptic-curve authenticated encryption — so that DNS traffic is confidential and unforgeable at each hop, without requiring DNSSEC's complex chain-of-trust signature validation.

**Design (D. J. Bernstein, 2008; IETF draft-dempsky-dnscurve-01):**

| Property | Detail |
|----------|--------|
| Key exchange | X25519 (Curve25519 ECDH); server's 255-bit public key encoded in its NS hostname |
| Authenticated encryption | `crypto_box` = XSalsa20-Poly1305 (NaCl); 256-bit key, 192-bit nonce |
| Key encoding | NS record hostname prefixed with `uz5` + 51-byte Base32 of server public key |
| Nonce | 96 bits random per query + 96-bit extension field; prevents replay |
| Overhead | ~68 bytes per query (key + nonce + Poly1305 tag); fits within UDP with EDNS0 |
| Server discovery | Standard DNS NS lookup; backwards-compatible (non-DNSCurve resolvers ignore `uz5` prefix) |

**DNSCurve vs. DNSSEC:**

| Property | DNSCurve | DNSSEC |
|----------|----------|--------|
| Confidentiality | Yes — queries and responses encrypted | No — signatures visible; queries plaintext |
| Authentication | Per-hop (resolver ↔ server) | End-to-end chain of trust from root |
| Performance | Fast (Curve25519 ~10× faster than RSA-1024) | Slow (RSA/ECDSA per zone; large UDP responses) |
| Deployment complexity | Simple — key in NS hostname | High — zone signing, key rollovers, DS records |
| Standardization | IETF draft only; not an RFC | RFC 4033–4035; widely mandated |

**Implementations:** djbdns/dnscache (Bernstein's reference resolver), CurveDNS (authoritative proxy by Jan Mojžíš), dqcache.
No notable open-source implementations available.

**State of the art:** DNSCurve was never standardized as an IETF RFC. DNS-over-TLS (RFC 7858) and DNS-over-HTTPS (RFC 8484) have since addressed the confidentiality gap on the stub-resolver-to-recursive-resolver leg, while DNSSEC covers end-to-end integrity. DNSCurve's Curve25519 + NaCl design was influential — it popularized `crypto_box` for link-layer encryption and prefigured WireGuard's approach. See [Secure Channels](#secure-channels--protocol-constructions), [Applied Infrastructure PKI](14-applied-infrastructure-pki.md#dnssec--dns-security-extensions).

**Production readiness:** Deprecated
Never standardized as an RFC. Superseded by DoT (RFC 7858) and DoH (RFC 8484) for DNS confidentiality.

**Implementations:**
- [CurveDNS](https://github.com/curvedns/curvedns) ⭐ 58 — C; authoritative DNSCurve proxy
- [dqcache](https://mojzis.com/software/dqcache/) — C; DNSCurve-enabled caching resolver

**Security status:** Superseded
Cryptographic primitives (X25519 + XSalsa20-Poly1305) are secure. Protocol never underwent full IETF review. Superseded by DoT/DoH for the confidentiality use case.

**Community acceptance:** Niche
IETF draft only; never progressed to RFC. Historically influential (popularized NaCl crypto_box) but not adopted at scale.

---

## Briar / Bramble P2P Encrypted Messaging

**Goal:** Censorship-resistant, infrastructure-independent secure messaging. Briar synchronizes encrypted messages directly between devices via Tor hidden services, local Wi-Fi, or Bluetooth — with no central server — so that communication survives internet shutdowns, network surveillance, or server seizure.

**Protocol stack (Bramble suite, open specification):**

| Layer | Protocol | Purpose |
|-------|----------|---------|
| Contact pairing | BHP (Bramble Handshake Protocol) | Curve25519 ECDH over QR code or link; derives shared secret |
| Transport | BTP (Bramble Transport Protocol v4) | Encrypted, authenticated byte streams; BLAKE2b-based PRF; forward-secret session key rotation |
| Synchronization | BSP (Bramble Synchronisation Protocol) | Delay-tolerant message sync; works over any ordered byte stream |
| Rendezvous | BRP (Bramble Rendezvous Protocol) | Finds peers over Tor rendezvous points without revealing contact graph |
| Application | Briar messaging / blogs / forums | High-level objects carried as BSP messages |

**Transport security (BTP v4):**

- Session keys derived from BHP-established master key via BLAKE2b PRF
- Keys rotated periodically to provide forward secrecy within a session
- Each transport stream is independent; compromise of one session key does not expose past or future sessions

**Threat model and transport options:**

| Transport | When used | Privacy |
|-----------|-----------|---------|
| Tor hidden services | Internet available | Full metadata privacy (IP hidden) |
| Local Wi-Fi / LAN | Internet unavailable | Peer-to-peer; IP visible on local net |
| Bluetooth | No network | Direct; short range |

**Security note:** CVE-2023-33982 (fixed in Briar 1.5.3) — BHP was not fully forward-secure in the contact-pairing step; compromise of both long-term keys post-handshake could expose the pairing secret. Fixed by adding ephemeral keys to BHP.

**State of the art:** Briar 1.5+ (2023+); open specification at `code.briarproject.org/briar/briar-spec`. Designed for journalists and activists. The Bramble suite is the most complete open specification for delay-tolerant, infrastructure-free E2E encrypted messaging. See [Anonymity / Onion Routing](11-anonymity-credentials.md), [Double Ratchet](#double-ratchet--symmetric-ratchet).

**Production readiness:** Mature
Deployed for journalists and activists. Production Android app; desktop beta. Infrastructure-independent design limits mainstream adoption.

**Implementations:**
- [Briar](https://code.briarproject.org/briar/briar) — Java/Android; reference implementation of the Bramble protocol suite
- [Briar Desktop](https://code.briarproject.org/briar/briar-desktop) — Kotlin; desktop client (beta)

**Security status:** Secure
Uses well-studied primitives (Curve25519, BLAKE2b, ChaCha20-Poly1305). CVE-2023-33982 (BHP forward secrecy weakness) fixed in Briar 1.5.3. Security audit by Cure53 (2017).

**Community acceptance:** Niche
Open specification; well-regarded in the privacy/activist community. Not standardized by IETF or other bodies. Audited by Cure53.

---

## Tox Protocol / Serverless P2P E2E Encrypted Chat

**Goal:** Fully decentralized, server-free instant messaging, voice, video, and file transfer — with end-to-end encryption and no account registration — using a DHT for peer discovery and NaCl `crypto_box` for all communications.

**Cryptographic architecture (Tox spec, TokTok project):**

| Component | Mechanism |
|-----------|-----------|
| Identity | Curve25519 key pair; 64-hex public key is the user's permanent ToxID |
| Peer discovery | Kademlia-style DHT over UDP; bootstrap nodes seed initial connections |
| Authenticated encryption | `crypto_box` = X25519 key agreement + XSalsa20-Poly1305 (via libsodium) |
| Message encryption | Ephemeral DH per session; session keys never transmitted |
| Packet nonce | 24-byte random nonce per packet; prevents replay |
| Friend requests | Encrypted with recipient's long-term public key + sender's ephemeral key |
| Group chats | Symmetric session key; distributed via `crypto_box` to each member |
| Audio/video | Encoded with Opus/VP8; encrypted with session `crypto_box` |

**Forward secrecy:** Each call / session generates fresh ephemeral X25519 keys. Long-term ToxID key is used only for initial `crypto_box` of the session key exchange — ongoing messages use per-session ephemeral keys.

**Security posture:** Tox uses well-audited NaCl primitives (Bernstein et al.) but the Tox protocol itself has not received a formal third-party cryptographic audit. The DHT design leaks metadata about who is online and reachable — a structural limitation of open P2P networks.

| Client | Platform | Note |
|--------|----------|------|
| **qTox** | Desktop (C++) | Reference client |
| **µTox** | Desktop | Lightweight |
| **Antox** | Android | Maintained fork |
| **Toxic** | CLI | Terminal client |

**State of the art:** Tox protocol specification maintained by the TokTok project (`toktok.ltd/spec`). No formal audit; not recommended for high-threat-model use without independent review. The NaCl/libsodium cryptographic primitives (Curve25519 + XSalsa20-Poly1305) are state-of-the-art; the protocol layering and metadata exposure are the open research questions. Compare [Briar](#briar--bramble-p2p-encrypted-messaging) for a more threat-modelled P2P alternative. See [[1]](https://toktok.ltd/spec.html).

**Production readiness:** Experimental
Multiple working clients exist but no formal security audit of the protocol. Not recommended for high-threat-model use.

**Implementations:**
- [c-toxcore](https://github.com/TokTok/c-toxcore) ⭐ 2.6k — C; reference Tox protocol implementation
- [qTox](https://github.com/qTox/qTox) ⭐ 5.0k [archived] — C++; desktop Tox client
- [Toxic](https://github.com/JFreegman/toxic) ⭐ 1.3k — C; CLI Tox client

**Security status:** Caution
NaCl/libsodium primitives (X25519 + XSalsa20-Poly1305) are secure. Protocol itself lacks formal audit; DHT design leaks metadata about online status. Not recommended without independent review.

**Community acceptance:** Niche
Community-developed; no formal standardization. Protocol specification maintained by TokTok project. No formal security audit to date.

---

## Olm / Matrix Pairwise Ratchet

**Goal:** Provide Signal-like pairwise end-to-end encryption for Matrix (Element) direct messages using Double Ratchet and X3DH, adapted for Matrix's decentralized, server-federated homeserver model where keys are published via the Matrix key API rather than Signal's centralized key server.

**Protocol design (Matrix.org spec, `olm` C library):**

Olm is a pairwise Double Ratchet protocol. Each pair of Matrix devices establishes an independent Olm session; there is one session per (sender device, recipient device) pair.

| Component | Mechanism |
|-----------|-----------|
| Initial key agreement | Curve25519 X3DH with identity key, signed pre-key, one-time pre-keys |
| Session encryption | Double Ratchet (AES-256-CBC + HMAC-SHA-256, Curve25519 DH ratchet) |
| Key distribution | `/keys/upload` and `/keys/query` Matrix client-server API endpoints |
| One-time pre-keys | Uploaded to homeserver; consumed per new session initiation |
| Device verification | Short Authentication String (emoji / decimal) or QR-code cross-signing |

**Olm vs. Signal Double Ratchet differences:**

| Property | Signal Double Ratchet | Olm |
|----------|-----------------------|-----|
| Transport | Signal server (centralized) | Matrix homeserver (federated) |
| Key store | Signal key server | User's homeserver (untrusted for key content) |
| Multi-device | Sesame session manager | One Olm session per device pair |
| Group chat | Multi-recipient Double Ratchet | Megolm (separate group ratchet) |
| Message ordering | Strict | Out-of-order tolerant (ratchet key caching) |

**Cross-signing (Matrix E2E device verification):**
- Each user has a master signing key, self-signing key, and user-signing key
- Device keys cross-signed by the user's own master key → verified identity across all devices
- Verification ceremony (SAS emoji) compares a 7-emoji sequence derived from both devices' keys

**Deployments:** Element (Web, Desktop, iOS, Android), FluffyChat, Nheko, Cinny — all major Matrix clients. Used by German government (Bundeswehr), French government (Tchap), NATO-aligned agencies.

**State of the art:** vodozemac (2023) — a formally verified Rust reimplementation via the Hax framework — replaces libolm as the reference implementation in Element Web/X. See [Double Ratchet](#double-ratchet--symmetric-ratchet), [X3DH](#x3dh--extended-triple-dh-key-agreement).

**Production readiness:** Production
Deployed in all major Matrix clients (Element, FluffyChat, Nheko, Cinny). Used by German and French governments.

**Implementations:**
- [vodozemac](https://github.com/matrix-org/vodozemac) ⭐ 347 — Rust; formally verified via Hax; current reference implementation
- [libolm](https://gitlab.matrix.org/matrix-org/olm) — C/C++; original Olm/Megolm library (deprecated in favour of vodozemac)
- [matrix-rust-sdk](https://github.com/matrix-org/matrix-rust-sdk) ⭐ 2.0k — Rust; full Matrix SDK with Olm/Megolm via vodozemac

**Security status:** Secure
Double Ratchet + X3DH construction is well-analysed. vodozemac is formally verified. Cross-signing provides strong device verification.

**Community acceptance:** Widely trusted
Matrix.org specification. Adopted by government agencies (Bundeswehr, French government). Widely deployed in the federated messaging ecosystem.

---

## WireGuard Noise_IKpsk2 Handshake

**Goal:** Provide a cryptographically minimal, formally verified VPN tunnel using a single fixed Noise protocol handshake pattern — eliminating cipher negotiation, version fields, and algorithm agility entirely. WireGuard's entire cryptographic design fits in ~4 000 lines of code.

**Noise protocol pattern: `IKpsk2`**

```
Initiator knows: static key pair (s_i), responder's static public key (s_r)
Responder knows: static key pair (s_r)

→ e                      (initiator sends ephemeral public key e_i)
← e, ee, se             (responder sends ephemeral e_r; mixes DH(e_i,e_r) and DH(e_r,s_i))
→ s, se, psk            (initiator sends encrypted static key; mixes DH(s_i,e_r) and PSK)
```

| Primitive | Choice | Rationale |
|-----------|--------|-----------|
| DH | X25519 (Curve25519) | Fast, constant-time, no cofactor issues |
| AEAD | ChaCha20-Poly1305 | Software-speed; avoids AES-NI hardware dependence |
| Hash / KDF | BLAKE2s + HKDF | Fast on 32-bit/embedded; collision-resistant |
| Handshake state | `h`, `ck`, `k`, `n` — 4 scalars | Minimal mutable state |

**Key derivation in detail (WireGuard paper §5):**

1. Both sides maintain a chaining key `ck` and hash `h` updated via `HKDF-Extract(ck, input)`
2. Each DH output is mixed into `ck` via `(ck, k) = HKDF(ck, DH_output, 2 outputs)`
3. After the 3-way handshake, `(T_send, T_recv) = HKDF(ck, ε, 2 outputs)` — transport keys
4. Pre-shared key (PSK) adds post-quantum resistance: `(ck, τ, k) = HKDF(ck, psk, 3 outputs)`

**Cookie mechanism (DoS mitigation):**
- Under load, the responder issues a MAC-protected cookie (24-byte random nonce encrypted under the requester's IP)
- The initiator must echo the cookie in the first message before the responder allocates state
- Prevents resource exhaustion from spoofed-IP handshake floods

**Formal verification:** Donenfeld & Milner (2017), Lipp–Blanchet–Bhargavan (2019) verified with ProVerif and Tamarin; full secrecy and authentication properties proven under the symbolic model. [[1]](https://eprint.iacr.org/2019/1347)

**State of the art:** WireGuard in Linux kernel 5.6+ (2020). Static codebase; no version negotiation. PSK layer provides optional symmetric post-quantum resistance (256-bit pre-shared key must be exchanged out-of-band). A full PQ WireGuard (`mlkem768x25519` replacing X25519 DH) is under active development. See [Secure Channels](#secure-channels--protocol-constructions), [IKEv2 / IPsec](#ikev2--ipsec-esp).

**Production readiness:** Production
In Linux kernel since 5.6 (2020). Deployed on Windows, macOS, iOS, Android, FreeBSD, OpenBSD. Used by major VPN providers.

**Implementations:**
- [wireguard-linux](https://git.zx2c4.com/wireguard-linux) — C; Linux kernel module
- [wireguard-go](https://git.zx2c4.com/wireguard-go) — Go; userspace implementation for all platforms
- [boringtun](https://github.com/cloudflare/boringtun) ⭐ 7.0k — Rust; Cloudflare's userspace WireGuard
- [wireguard-nt](https://git.zx2c4.com/wireguard-nt) — C; native Windows kernel driver

**Security status:** Secure
Formally verified (ProVerif, Tamarin). ~4000 lines of code; minimal attack surface. No known practical attacks. PSK slot provides optional PQ resistance.

**Community acceptance:** Widely trusted
Formally verified. In Linux kernel mainline. Endorsed by leading cryptographers. Widely deployed by VPN providers (Mullvad, Tailscale, Cloudflare WARP).

---

## STARTTLS / Opportunistic vs. Mandatory TLS

**Goal:** Upgrade a plaintext protocol connection to TLS in-band — without requiring a separate port — enabling backward-compatible encryption for email (SMTP, IMAP, POP3), LDAP, and other protocols. The key security distinction is between *opportunistic* TLS (encrypt if possible, fall back to plaintext) and *mandatory* TLS (fail hard if TLS is unavailable).

**How STARTTLS works (SMTP example, RFC 3207):**

```
Client → Server: EHLO mail.example.com
Server → Client: 250-STARTTLS                    ← advertises capability
Client → Server: STARTTLS                         ← requests upgrade
Server → Client: 220 Ready to start TLS
--- TLS ClientHello begins on the same TCP connection ---
Client → Server: MAIL FROM:<alice@example.com>   ← now inside TLS
```

**Opportunistic vs. mandatory TLS:**

| Mode | Behavior | Threat model |
|------|----------|-------------|
| **Opportunistic TLS** (unauthenticated) | Encrypt if server offers STARTTLS; accept any certificate; fall back to plaintext | Passive eavesdroppers only; MITM or downgrade not prevented |
| **Opportunistic TLS + DANE** | Encrypt and verify cert against TLSA DNS record | Adds MITM resistance; requires DNSSEC |
| **MTA-STS** (RFC 8461) | Policy published at HTTPS well-known URL; recipient domain declares mandatory TLS | Prevents downgrade; no DNSSEC required |
| **SMTP DANE** (RFC 7672) | TLSA record specifies cert or SPKI hash; DNSSEC-validated | Strongest: MITM requires DNS compromise |
| **Mandatory TLS** (STARTTLS + cert verification) | TLS required; cert must validate against trust store | Prevents both passive and active MITM |

**STARTTLS stripping attack:**
An active MITM can delete the `250-STARTTLS` capability line before the client sees it, causing the client to proceed in plaintext. Countermeasures:
- **MTA-STS**: client caches policy; will not fall back even if the capability is stripped
- **DANE TLSA**: client checks the DNSSEC-signed record; strip attempts are detectable

**Implicit TLS (port 465 / SMTPS):**
A simpler alternative: TLS wraps the entire connection from the first byte (no STARTTLS negotiation). RFC 8314 (2018) recommends implicit TLS on port 465 for mail submission and discourages STARTTLS on port 587 for new deployments.

| Protocol | Plaintext port | STARTTLS port | Implicit TLS port |
|----------|---------------|---------------|------------------|
| SMTP relay | 25 | 25 (RFC 3207) | — |
| SMTP submission | 587 | 587 | 465 (preferred, RFC 8314) |
| IMAP | 143 | 143 (RFC 2595) | 993 |
| POP3 | 110 | 110 (RFC 2595) | 995 |
| LDAP | 389 | 389 (RFC 2830) | 636 |

**State of the art:** Google and Microsoft enforce MTA-STS for outbound mail to major domains. DANE + DNSSEC is more secure but requires DNSSEC deployment at both ends. RFC 8314 (2018) recommends implicit TLS for mail clients. STARTTLS remains necessary for inter-server SMTP relay (port 25). See [Secure Channels](#secure-channels--protocol-constructions), [Applied Infrastructure PKI](14-applied-infrastructure-pki.md#dane--dns-based-authentication-of-named-entities).

**Production readiness:** Production
Universally deployed in SMTP, IMAP, POP3, LDAP. MTA-STS and DANE harden the security model.

**Implementations:**
- [Postfix](https://github.com/vdukhovni/postfix) ⭐ 530 — C; MTA with STARTTLS, DANE, MTA-STS support
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; TLS library underlying most STARTTLS implementations
- [Exim](https://github.com/Exim/exim) ⭐ 780 [archived] — C; MTA with STARTTLS and DANE support
- [Dovecot](https://github.com/dovecot/core) ⭐ 1.2k — C; IMAP/POP3 server with STARTTLS

**Security status:** Caution
Opportunistic STARTTLS is vulnerable to stripping attacks (active MITM can remove the STARTTLS capability). MTA-STS and DANE mitigate this. Implicit TLS (port 465) preferred for new deployments.

**Community acceptance:** Standard
IETF RFC 3207 (SMTP STARTTLS), RFC 8314 (implicit TLS), RFC 8461 (MTA-STS), RFC 7672 (SMTP DANE). Universally deployed.

---

## Oblivious HTTP (OHTTP)

**Goal:** Separate the identity of an HTTP client from the content of its requests by routing them through a relay — so that the target server never learns the client's IP address, and the relay never learns the request content. Provides metadata privacy for DNS queries, telemetry, and privacy-sensitive API calls.

**Architecture (RFC 9458, 2023):**

```
Client ──(HPKE-encrypted request)──► Relay ──(unwrapped request)──► Gateway ──► Target

Client knows:  Gateway's HPKE public key (fetched out-of-band)
Relay knows:   Client IP + opaque ciphertext blob (learns nothing about content)
Gateway knows: Request content + Relay IP (never learns Client IP)
```

**Encapsulation (HPKE, RFC 9180):**

| Step | Operation |
|------|-----------|
| Client | Encapsulate HTTP request under Gateway's HPKE public key; send to Relay |
| Relay | Forward to Gateway (strips client IP; substitutes its own) |
| Gateway | HPKE decapsulate; forward inner HTTP request to target resource |
| Gateway response | HPKE-encrypt response; send back via Relay |
| Relay | Forward opaque response to Client |

**Cryptographic instantiation (RFC 9458 §3):**

| Primitive | Value |
|-----------|-------|
| KEM | DHKEM(X25519, HKDF-SHA256) |
| KDF | HKDF-SHA256 |
| AEAD | AES-128-GCM or ChaCha20-Poly1305 |
| Encapsulated request | `HPKE-Seal(gateway_pk, request_bytes, aad="")` |
| Key ID | 1-byte selector; allows gateway key rotation |

**Privacy properties:**

| Property | Guarantee |
|----------|-----------|
| Request unlinkability | Relay cannot link two requests from the same client (stateless relay) |
| Content confidentiality | Relay sees only HPKE ciphertext |
| IP unlinkability | Gateway never sees client IP address |
| Forward secrecy | HPKE uses a fresh ephemeral encapsulation key per request |
| Limitation | Client and Relay must not collude; Relay observes timing metadata |

**Deployments:** Apple iCloud Private Relay (OHTTP variant), Cloudflare DNS-over-OHTTP, Google SafeBrowsing v5 (OHTTP for URL lookups), Meta (Threads telemetry), Fastly OHTTP relay service.

**State of the art:** RFC 9458 (2023). Deployed at scale for DNS and telemetry. Complements [Oblivious DoH (ODoH)](10-privacy-preserving-computation.md#oblivious-dns-odoh) — ODoH is an earlier DNS-specific predecessor; OHTTP generalizes to arbitrary HTTP. See [Secure Channels](#secure-channels--protocol-constructions), [ECH](#encrypted-client-hello-ech).

**Production readiness:** Production
Deployed at scale by Apple (iCloud Private Relay), Cloudflare, Google, and Meta.

**Implementations:**
- [Fastly OHTTP relay](https://www.fastly.com/documentation/reference/api/) — production relay service
- [ohttp (Cloudflare)](https://github.com/martinthomson/ohttp) ⭐ 53 — Rust; Cloudflare OHTTP client/relay/gateway

**Security status:** Secure
Based on HPKE (RFC 9180). Provides request unlinkability and content confidentiality. Forward secrecy via ephemeral HPKE encapsulation.

**Community acceptance:** Standard
IETF RFC 9458 (2023). Deployed by Apple, Cloudflare, Google, Meta. Endorsed by the IETF OHAI working group.

---

## ACME Protocol / Automated Certificate Management

**Goal:** Automate the issuance, renewal, and revocation of TLS certificates by formalizing the challenge-response domain validation workflow as a machine-readable protocol — eliminating the manual steps that caused certificate expiry outages and enabling zero-touch 90-day certificate rotation at scale.

**Protocol design (RFC 8555, 2019):**

ACME is a REST/JSON protocol between an ACME client (e.g., Certbot, acme.sh) and a CA's ACME server (e.g., Let's Encrypt).

```
Client                               CA (ACME Server)
  │                                       │
  ├─ POST /new-account (JWK, ToS agree) ─►│  ← create account (Ed25519 or RSA key)
  ├─ POST /new-order (domain list) ──────►│  ← request certificate
  │◄── order URL + authorization URLs ────┤
  ├─ GET  authorization URL ─────────────►│  ← fetch challenge options
  │◄── challenges: HTTP-01 / DNS-01 / TLS-ALPN-01 ──┤
  ├─ complete challenge ─────────────────►│  ← provision token
  ├─ POST /challenge (ready) ────────────►│
  │◄── CA validates challenge ────────────┤
  ├─ POST /finalize (CSR) ───────────────►│  ← submit CSR
  │◄── certificate URL ───────────────────┤
  ├─ GET  certificate URL ───────────────►│
  │◄── signed X.509 certificate ──────────┤
```

**Challenge types:**

| Challenge | Mechanism | Use case |
|-----------|-----------|---------|
| **HTTP-01** | CA fetches `http://domain/.well-known/acme-challenge/{token}` | Web servers with port 80 access |
| **DNS-01** | CA queries `_acme-challenge.domain` TXT = `Base64(SHA-256(keyAuthorization))` | Wildcard certs; no HTTP port access needed |
| **TLS-ALPN-01** | CA connects TLS with ALPN `acme-tls/1`; cert must contain challenge token in SAN | TLS-only environments |

**Cryptographic components:**

| Component | Detail |
|-----------|--------|
| Account key | Ed25519 or RSA-2048 key pair; identifies the ACME account |
| JWS | All ACME requests are signed with the account key; replay-protected via `nonce` |
| CSR | Standard PKCS#10 certificate signing request |
| keyAuthorization | `token || "." || Base64url(SHA-256(accountKey))` — binds challenge to account |

**ARI — ACME Renewal Information (RFC 9730, 2024):**
Allows the CA to signal the optimal renewal window to clients, enabling mass-renewal coordination and graceful handling of CA-side key compromise events without client-side polling.

**Deployments:** Let's Encrypt (~380 million active certificates, 2024), ZeroSSL, Google Trust Services, Cloudflare, Buypass. Clients: Certbot, acme.sh, Caddy (built-in), Traefik, nginx `ngx_http_acme_module`.

**State of the art:** RFC 8555 (2019) is universally adopted; Let's Encrypt issues ~6 million certificates per day (2024). Short-lived certificates (6-day) under `draft-ietf-acme-shortlived` would replace revocation with expiry. ARI (RFC 9730) is the latest extension. See [Applied Infrastructure PKI](14-applied-infrastructure-pki.md), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
Let's Encrypt issues ~6 million certificates per day. Used by all major hosting providers and CDNs.

**Implementations:**
- [Certbot](https://github.com/certbot/certbot) ⭐ 32k — Python; EFF's ACME client; the most widely used
- [acme.sh](https://github.com/acmesh-official/acme.sh) ⭐ 46k — Shell; pure POSIX shell ACME client
- [Caddy](https://github.com/caddyserver/caddy) ⭐ 71k — Go; web server with built-in ACME
- [Lego](https://github.com/go-acme/lego) ⭐ 9.4k — Go; ACME client library and CLI
- [Boulder](https://github.com/letsencrypt/boulder) ⭐ 5.7k — Go; Let's Encrypt's ACME CA server

**Security status:** Secure
Domain validation via HTTP-01/DNS-01/TLS-ALPN-01 is well-studied. JWS-signed requests prevent unauthorized issuance. Channel binding via nonces prevents replay.

**Community acceptance:** Standard
IETF RFC 8555 (2019), RFC 9730 (ARI, 2024). Let's Encrypt has issued billions of certificates. The de facto standard for automated TLS certificate management.

---

## WhatsApp Key Transparency / Auditable Key Directory (AKD)

**Goal:** Let users verify that the public keys their messaging app uses for end-to-end encryption are the same keys that all other users see — preventing a server from silently substituting a backdoor key for a targeted user without being detected.

**Problem context:** In systems like WhatsApp and Signal, the server distributes each user's X3DH identity keys and pre-keys to other participants. A malicious or compromised server could swap these keys for attacker-controlled ones, silently enabling MITM on specific users. Key transparency makes the key directory auditable without requiring every user to manually verify fingerprints.

**Auditable Key Directory (AKD) design (Keyless et al., USENIX Security 2022; Meta deployment 2023):**

| Component | Mechanism |
|-----------|-----------|
| **Append-only log** | All key insertions and updates logged in a Merkle tree; every entry is timestamped and sequenced |
| **Verifiable Random Function (VRF)** | Maps username → a deterministic, unpredictable position in the tree; prevents enumeration of user list |
| **Inclusion proofs** | Any client can request a Merkle proof that its own key is in the tree as published |
| **Consistency proofs** | Between two tree epochs, a client can verify the tree only grew (no deletions or retroactive changes) |
| **Audit log** | An independent auditor (or any client) can verify the log is consistent over time |

**VRF-based lookup — privacy property:** Unlike Certificate Transparency (which exposes all domain names), AKD's VRF maps usernames to opaque leaf positions. A third party cannot enumerate the directory to harvest usernames, but any client can prove its own key is correctly listed.

**WhatsApp deployment (2023):**
- Meta deployed AKD for WhatsApp in 2023; key directory is publicly verifiable
- Each client periodically fetches a consistency proof for its own key
- Users can manually compare safety numbers (derived from the key log epoch) out-of-band
- The AKD backend is `transparency.whatsapp.com`; inclusion proofs can be independently fetched

| Scheme | Year | Note |
|--------|------|------|
| **AKD (Auditable Key Directory)** | 2022 | Koh–Tyagi et al.; Merkle tree + VRF; open-source Rust library [[1]](https://eprint.iacr.org/2021/1263) |
| **WhatsApp Key Transparency** | 2023 | Production deployment of AKD for ~2 billion users [[1]](https://engineering.fb.com/2023/04/13/security/whatsapp-key-transparency/) |
| **CONIKS** | 2015 | Earlier key transparency scheme; per-user Merkle prefix trees; influenced AKD [[1]](https://www.usenix.org/system/files/conference/usenixsecurity15/sec15-paper-melara.pdf) |
| **Key Transparency (Google)** | 2017 | Similar design for Google end-to-end encrypted services [[1]](https://security.googleblog.com/2017/01/security-through-transparency.html) |

**Comparison with Certificate Transparency (CT):**

| Property | Certificate Transparency | AKD |
|----------|------------------------|-----|
| Scope | TLS certificates (domain → cert) | Messaging keys (user → X3DH keys) |
| Privacy | All domains exposed | VRF hides user list |
| Monitor | Any party can watch all certs | Only user can prove their own key |
| Audit | CT logs publicly enumerable | Log consistency verifiable without enumeration |

**State of the art:** AKD (2022) is the leading design; deployed by WhatsApp (2023). See [Key Transparency](03-key-exchange-key-management.md#key-transparency--coniks), [X3DH](#x3dh--extended-triple-dh-key-agreement), [Certificate Transparency](14-applied-infrastructure-pki.md).

**Production readiness:** Production
Deployed by WhatsApp (2023) for ~2 billion users. Google Key Transparency operational for internal services.

**Implementations:**
- [akd (Meta)](https://github.com/facebook/akd) ⭐ 314 — Rust; Auditable Key Directory library (open-source)
- [key-transparency (Google)](https://github.com/google/keytransparency) ⭐ 1.6k — Go; Google's key transparency server

**Security status:** Secure
Merkle tree + VRF construction is well-analysed. Provides verifiable key consistency without revealing the user directory.

**Community acceptance:** Emerging
Deployed by Meta; academic publication at USENIX Security 2022. Not yet an IETF standard but active work in the IETF KT working group.

---

## TLS 1.3 0-RTT / Early Data Security Properties

**Goal:** Eliminate the latency cost of TLS handshake round-trips for returning clients by allowing encrypted application data to be sent in the very first flight — before the handshake completes — at the cost of weakened security properties that applications must explicitly account for.

**How 0-RTT works (RFC 8446 §2.3):**

```
Client (has session ticket)          Server
  │                                    │
  ├─ ClientHello + early_data ────────►│   ← 0-RTT: encrypted under resumption key
  ├─ (early data: GET /index.html) ───►│   ← sent before server responds
  │◄── ServerHello + ... ─────────────┤
  │◄── EncryptedExtensions ────────────┤
  │◄── Finished ───────────────────────┤
  ├─ Finished ────────────────────────►│
```

**Session ticket key derivation:**

| Key | Derivation | Purpose |
|-----|-----------|---------|
| `resumption_master_secret` | From TLS 1.3 key schedule (HKDF) after full handshake | Source of 0-RTT key material |
| `early_secret` | `HKDF-Extract(0, PSK)` where PSK = ticket key | Used to derive `client_early_traffic_secret` |
| `client_early_traffic_secret` | `HKDF-Expand-Label(early_secret, "c e traffic", CH, HashLen)` | Actual 0-RTT encryption key |

**Security properties — what 0-RTT loses:**

| Property | 1-RTT (standard TLS 1.3) | 0-RTT |
|----------|--------------------------|-------|
| Forward secrecy | Yes (ephemeral DH) | **No** — 0-RTT key derived from static ticket |
| Replay protection | Yes (ephemeral key uniqueness) | **No** — server cannot distinguish replayed early data |
| Downgrade protection | Yes | Yes (same ClientHello authentication) |
| Server authentication before data sent | Yes | **No** — data sent before server Finished |

**Replay attack on 0-RTT:**

A network adversary who captures a client's 0-RTT flight can replay it to a different server instance (e.g., a different CDN node) that holds the same session ticket key. The replayed data will decrypt and be processed by the server.

**Countermeasures (RFC 8446 §8):**

| Countermeasure | Mechanism | Limitation |
|---------------|-----------|-----------|
| Single-use tickets | Server marks ticket consumed; rejects replays | Requires shared state across all server instances |
| Client Hello recording | Server stores hash of each 0-RTT ClientHello | Scales poorly in distributed deployments |
| Time-window restriction | Accept 0-RTT only within a short window (e.g., 5 seconds) | Reduces but does not eliminate replay window |
| Application-layer idempotency | Only allow 0-RTT for idempotent requests (HTTP GET, not POST) | Application must enforce; not automatic |

**Deployment reality (RFC 8446 §2.3, §8.2):**
- Cloudflare, Google, and major CDNs enable 0-RTT for HTTP GET requests only
- TLS stacks (OpenSSL 1.1.1+, BoringSSL, NSS) support 0-RTT but require explicit opt-in
- HTTP/3 (QUIC) also supports 0-RTT with the same replay caveats (RFC 9001 §9.2)
- gRPC over HTTP/2 generally disables 0-RTT due to non-idempotent RPC semantics

**State of the art:** RFC 8446 (TLS 1.3, 2018) specifies 0-RTT. The consensus recommendation is to use 0-RTT only for idempotent, replay-safe operations and to treat 0-RTT data as unauthenticated until the handshake completes. See [Secure Channels](#secure-channels--protocol-constructions), [QUIC Packet Protection](#quic-packet-protection).

**Production readiness:** Production
Enabled by major CDNs (Cloudflare, Google, Fastly) for HTTP GET requests. Supported in OpenSSL 1.1.1+, BoringSSL, NSS.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; TLS 1.3 with 0-RTT support (1.1.1+)
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C; Google's TLS library with 0-RTT in Chrome
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust; TLS library with 0-RTT support

**Security status:** Caution
0-RTT data lacks forward secrecy and is replayable. Safe only for idempotent operations (HTTP GET). Applications must explicitly opt in and handle replay risk. 1-RTT TLS 1.3 is fully secure.

**Community acceptance:** Standard
Part of IETF RFC 8446 (TLS 1.3). Widely deployed but with caveats documented in RFC 8446 section 8. Consensus recommendation is careful use for idempotent requests only.

---

## QUIC Connection Migration and Security

**Goal:** Allow a QUIC connection to survive changes in the client's IP address or port — such as switching from Wi-Fi to cellular — without a new handshake, while preventing attackers from hijacking connections or launching amplification attacks via forged migration.

**Connection ID (CID) design (RFC 9000 §5):**

Unlike TCP (identified by 4-tuple: src IP, src port, dst IP, dst port), QUIC connections are identified by Connection IDs chosen by each endpoint. When the client's network path changes, it can continue the connection by sending packets with the same CID from a new IP/port.

```
Client (Wi-Fi: 192.168.1.5:4321) ──────────────► Server
  │  [CID = 0xAB1234]                              │
  │  switches to LTE: 10.0.0.7:5555               │
  │                                                │
Client (LTE: 10.0.0.7:5555) ───────────────────► Server
  │  [CID = 0xAB1234]  ← same CID, new path       │
```

**Security challenges in connection migration:**

| Attack | Description | Mitigation |
|--------|-------------|-----------|
| **Path hijacking** | Attacker sends packets with victim's CID from new IP | Path validation: server sends `PATH_CHALLENGE`; client must echo `PATH_RESPONSE` |
| **Amplification via forged migration** | Attacker forges a migration to a victim IP; server sends large responses to victim | Server limits data to 3× unvalidated bytes until `PATH_RESPONSE` received |
| **Linkability across paths** | Observing same CID on two paths links them to same connection | CID rotation: each endpoint provides multiple CIDs via `NEW_CONNECTION_ID`; client uses fresh CID after migration |
| **Stateless reset replay** | Attacker uses a stolen stateless reset token to tear down a connection | Tokens are AEAD-encrypted under a server secret and bound to the CID |

**CID rotation for privacy (RFC 9000 §9.5):**

```
Server issues: NEW_CONNECTION_ID frames (each with a unique CID + stateless_reset_token)
Client on migration: retires old CID via RETIRE_CONNECTION_ID; begins using a fresh CID
Result: observers on the new path see a different CID → cannot correlate with old path
```

**Path validation protocol:**

1. Server receives a packet from a new 4-tuple claiming the same CID
2. Server sends `PATH_CHALLENGE(random_data_8_bytes)` on the new path
3. Client sends `PATH_RESPONSE(same_random_data)` — proves it controls the new address
4. Server begins accepting the new path; anti-amplification limit lifted

**Multi-path QUIC (RFC 9000 extension draft):**
- A single QUIC connection can use multiple active paths simultaneously (e.g., Wi-Fi + LTE)
- Each path has independent packet number space and loss recovery
- Allows bandwidth aggregation or seamless failover

**Deployments:** All QUIC implementations support connection migration (Chrome, Firefox, curl/quiche, QUIC-Go, MsQuic). Apple uses QUIC connection migration in the FaceTime and iMessage stacks on iOS. HTTP/3 connections over QUIC automatically migrate when the device switches networks.

**State of the art:** RFC 9000 (2021) specifies connection migration; CID rotation is required for migration privacy. Multi-path QUIC is in active IETF standardization (`draft-ietf-quic-multipath`). See [QUIC Packet Protection](#quic-packet-protection), [DTLS](#dtls--datagram-tls).

**Production readiness:** Production
Supported by all major QUIC implementations. Used in production by Chrome, Safari, curl, and Apple's FaceTime/iMessage stacks.

**Implementations:**
- [quiche](https://github.com/cloudflare/quiche) ⭐ 11k — Rust; Cloudflare QUIC with connection migration
- [MsQuic](https://github.com/microsoft/msquic) ⭐ 4.7k — C; Microsoft QUIC with migration support
- [quic-go](https://github.com/quic-go/quic-go) ⭐ 11k — Go; QUIC with connection migration

**Security status:** Secure
Path validation (PATH_CHALLENGE/PATH_RESPONSE) prevents hijacking. CID rotation prevents linkability. Anti-amplification limits mitigate forged migration attacks.

**Community acceptance:** Standard
IETF RFC 9000 (2021). Multi-path QUIC extension in active standardization. CID rotation is a required privacy feature.

---

## RPKI / BGPsec (Route Origin Authentication)

**Goal:** Cryptographically bind IP address prefixes to the Autonomous Systems (ASes) authorized to originate them in BGP — preventing route hijacks (where an AS fraudulently announces ownership of another's prefixes) and route leaks that can redirect internet traffic through unintended paths.

**BGP hijacking threat:** Without RPKI, any AS can announce any prefix. High-profile incidents: Pakistan Telecom hijacking YouTube (2008), Rostelecom hijacking AWS/Google prefixes (2020), China Telecom routing misconfigurations affecting major cloud providers.

**RPKI architecture (RFC 6480):**

```
IANA ──► Regional Internet Registries (ARIN, RIPE, APNIC, LACNIC, AFRINIC)
            └─ LIRs / ISPs ── Hosted RPKI or Delegated RPKI
                   └─ Route Origin Authorizations (ROAs)
                            └─ Signed with X.509 resource certificates
```

**Route Origin Authorization (ROA, RFC 6482):**

| Field | Content |
|-------|---------|
| **AS Number** | The AS authorized to announce the prefix |
| **IP Prefix** | The prefix (e.g., `198.51.100.0/24`) |
| **maxLength** | Maximum prefix length allowed (prevents deaggregation attacks) |
| **Validity** | NotBefore / NotAfter (X.509 validity period) |
| **Signature** | CMS/PKCS7 over ROA content, signed by the address holder's resource certificate |

**Validation states (RFC 6811):**

| State | Meaning |
|-------|---------|
| **Valid** | A ROA exists covering this prefix + origin AS pair |
| **Invalid** | A ROA exists but the origin AS or prefix length does not match |
| **Not Found** | No ROA covers this prefix (unknown; cannot assert authorization) |

**BGPsec (RFC 8205) — path authentication:**

RPKI secures route *origin*; BGPsec extends this to the entire AS path:

| Feature | RPKI | BGPsec |
|---------|------|--------|
| What is signed | Prefix → origin AS binding (ROA) | Each AS-path hop; entire path authenticated |
| Deployment | Widely deployed (~50% of prefixes, 2024) | Very limited deployment (complex, performance overhead) |
| Protection | Route origin hijacks | Both hijacks and path manipulation |

**Cryptographic primitives:**

| Component | Algorithm |
|-----------|-----------|
| Resource certificates | X.509v3 with IP Address and AS Number extensions (RFC 3779) |
| ROA signature | CMS SignedData, ECDSA P-256 (RFC 8608) |
| BGPsec path signature | ECDSA P-256 per AS hop; each AS signs the path segment it received + its own ASN |
| Trust anchor | Five RIR trust anchors (self-signed certificates) |

**Deployment (2024):**
- ~50% of global BGP prefixes have valid ROAs (RIPE NCC data)
- Major ISPs (AT&T, Comcast, Verizon, Deutsche Telekom) drop RPKI-invalid routes
- Cloudflare, AWS, Google all publish ROAs and perform origin validation
- BGPsec: fewer than 1% of ASes; practical deployment blocked by performance and chicken-and-egg problems

**State of the art:** RPKI origin validation (RFC 6480/6482/6811) is the deployed standard; reaching ~50% global prefix coverage. BGPsec (RFC 8205) is standardized but minimally deployed. ASPA (Autonomous System Provider Authorization, `draft-ietf-sidrops-aspa-profile`) is the next step — encodes customer-provider relationships to detect route leaks without full BGPsec. See [Applied Infrastructure PKI](14-applied-infrastructure-pki.md#dnssec--dns-security-extensions), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
RPKI origin validation at ~50% global prefix coverage (2024). BGPsec standardized but <1% deployed.

**Implementations:**
- [Routinator](https://github.com/NLnetLabs/routinator) ⭐ 556 — Rust; RPKI relying party software by NLnet Labs
- [Fort Validator](https://github.com/NICMx/FORT-validator) ⭐ 60 — C; RPKI validator
- [rpki-client](https://www.rpki-client.org/) — C; OpenBSD RPKI validator
- [Krill](https://github.com/NLnetLabs/krill) ⭐ 357 — Rust; RPKI CA/publication server by NLnet Labs

**Security status:** Secure
RPKI origin validation is well-designed. ROA signature verification via X.509 and ECDSA P-256. BGPsec adds path authentication but with high deployment overhead.

**Community acceptance:** Standard
IETF RFC 6480/6482/6811 (RPKI), RFC 8205 (BGPsec). Mandated by NIST SP 1800-14 for US federal networks. Major ISPs and cloud providers deploy RPKI.

---

## MASQUE / HTTP/3-Based Tunneling Security

**Goal:** Enable general-purpose IP and UDP tunneling over HTTP/3 (QUIC) — allowing VPN-like connectivity, proxying, and network traversal through HTTP infrastructure — with the same security properties as QUIC/TLS 1.3 and without the protocol fingerprinting problems of traditional VPN protocols.

**MASQUE (Multiplexed Application Substrate over QUIC Encryption) — RFC 9484 / RFC 9298:**

MASQUE uses HTTP/3's CONNECT method extended with `connect-udp` and `connect-ip` to tunnel UDP datagrams and IP packets over an HTTP/3 connection, using QUIC streams and datagrams.

**Protocol variants:**

| Variant | RFC | Transport | Use case |
|---------|-----|-----------|---------|
| **CONNECT-UDP** (H3 CONNECT) | RFC 9298 (2022) | UDP datagrams over HTTP/3 | Proxying QUIC connections; UDP tunneling |
| **CONNECT-IP** | RFC 9484 (2023) | IP packets over HTTP/3 | Full IP-layer VPN over HTTP/3 |
| **IP Proxying in HTTP** | RFC 9484 | Both TCP + UDP | General-purpose IP tunnel |

**Architecture:**

```
Client ──(QUIC/TLS 1.3)──► MASQUE Proxy ──(native QUIC)──► Target
  │                              │
  │  HTTP/3 CONNECT-UDP          │  UDP packet forwarding
  │  to proxy.example.com        │
  │                              │
  └── Capsule protocol (RFC 9297): encapsulates UDP/IP payloads in HTTP/3 DATA frames
```

**Capsule protocol (RFC 9297):**

UDP payloads are carried as HTTP/3 DATA frames in `Capsule` format:

```
Capsule Type (varint) | Capsule Length (varint) | Capsule Data
  └─ DATAGRAM_CAPSULE: contains a UDP payload or IP packet
```

**Security properties:**

| Property | Detail |
|----------|--------|
| Encryption | TLS 1.3 (via QUIC); all tunneled data encrypted |
| Authentication | Proxy authenticates client via HTTP authentication (Bearer token, mTLS, etc.) |
| Confidentiality of tunneled protocol | Observer sees HTTP/3 traffic; cannot distinguish MASQUE tunneling from normal CONNECT |
| Metadata exposure | Proxy IP and SNI of proxy host visible; target server IP hidden from network observer |
| Forward secrecy | Inherited from QUIC/TLS 1.3 handshake |

**MASQUE vs. traditional VPN:**

| Property | WireGuard / IPsec | MASQUE over HTTP/3 |
|----------|-------------------|--------------------|
| Protocol fingerprint | Distinct WireGuard/ESP UDP fingerprint | Indistinguishable from HTTPS traffic |
| Firewall traversal | Blocked by UDP-blocking firewalls | Traverses any HTTPS-allowing firewall |
| Latency overhead | Minimal | HTTP/3 framing overhead; QUIC stream per flow |
| Key management | WireGuard: static keys; IPsec: IKEv2 | TLS 1.3 certificate / token auth |
| Multi-hop | Not native | HTTP CONNECT chains naturally |

**Deployments:**
- Apple iCloud Private Relay uses a MASQUE-based architecture (two-hop CONNECT tunneling)
- Cloudflare WARP (2024) uses CONNECT-UDP for QUIC proxying
- Google's QUIC proxying infrastructure uses HTTP/3 CONNECT
- IETF MASQUE working group actively standardizing extensions (ECH + MASQUE, authenticated CONNECT)

**State of the art:** RFC 9298 (CONNECT-UDP, 2022) and RFC 9484 (CONNECT-IP, 2023) are the current standards. The IETF MASQUE working group is extending to multipath, happy eyeballs, and authenticated IP proxying. Primary use cases are privacy proxies (iCloud Private Relay), CDN edge proxying, and WebRTC NAT traversal. See [QUIC Packet Protection](#quic-packet-protection), [QUIC Connection Migration](#quic-connection-migration-and-security), [Oblivious HTTP](#oblivious-http-ohttp), [IKEv2 / IPsec](#ikev2--ipsec-esp).

**Production readiness:** Production
Deployed by Apple (iCloud Private Relay), Cloudflare WARP, and Google QUIC proxying infrastructure.

**Implementations:**
- [quiche](https://github.com/cloudflare/quiche) ⭐ 11k — Rust; Cloudflare QUIC/HTTP3 with MASQUE CONNECT-UDP support
- [MsQuic](https://github.com/microsoft/msquic) ⭐ 4.7k — C; Microsoft QUIC with CONNECT-UDP
- [Apple Network.framework](https://developer.apple.com/documentation/network) — Swift/ObjC; iCloud Private Relay uses MASQUE internally

**Security status:** Secure
Inherits TLS 1.3/QUIC security properties. HTTP/3 framing provides strong encryption and authentication. Traffic indistinguishable from normal HTTPS.

**Community acceptance:** Standard
IETF RFC 9298 (CONNECT-UDP), RFC 9484 (CONNECT-IP), RFC 9297 (Capsule Protocol). Active MASQUE working group extending the standards.

---

## DNS over HTTPS (DoH) and DNS over TLS (DoT)

**Goal:** Encrypt DNS stub-resolver queries so that ISPs, network operators, and passive observers cannot read or tamper with the domain names a client resolves. DoT (RFC 7858) wraps DNS in TLS on a dedicated port; DoH (RFC 8484) carries DNS inside HTTPS, making it indistinguishable from ordinary web traffic.

**Protocol comparison:**

| Property | DNS over TLS (DoT) | DNS over HTTPS (DoH) |
|----------|--------------------|----------------------|
| RFC | RFC 7858 (2016) | RFC 8484 (2018) |
| Transport | TLS 1.2+ over TCP port 853 | HTTP/2 or HTTP/3 over TCP/QUIC port 443 |
| Wire format | Standard DNS binary (RFC 1035) length-prefixed | `application/dns-message` (same binary, HTTP body) |
| Discoverability | Port 853 detectable by network | Indistinguishable from HTTPS traffic |
| Firewall traversal | Blocked by port-853 filters | Traverses any HTTPS-allowing firewall |
| Authentication | TLS certificate of the resolver | HTTPS certificate of the resolver URL |
| Padding | RFC 8467 (EDNS0 Padding option) | HTTP response body padding |

**DoT handshake (RFC 7858):**

1. Client opens TCP to resolver port 853; performs TLS handshake (TLS 1.3 preferred)
2. Authenticates resolver via its certificate (PKIX) or SPKI pin (RFC 7858 §9)
3. Sends DNS queries as 2-byte length-prefixed binary messages over the TLS stream
4. Responses arrive on the same persistent connection; no per-query RTT after first query

**DoH wire format (RFC 8484):**

```
POST /dns-query HTTP/2
Host: dns.example.com
Content-Type: application/dns-message
Accept: application/dns-message

<binary DNS query>
```

GET is also defined (query Base64url-encoded in URL parameter `?dns=`); POST is preferred to avoid caching by intermediaries.

**Oblivious DoH (ODoH, RFC 9230):** Extends DoH with HPKE to separate the resolver that sees the query content from the relay that sees the client IP. See [Oblivious DNS](10-privacy-preserving-computation.md#oblivious-dns-odoh).

**Privacy limitations of DoT/DoH:**

| Residual leak | Details |
|---------------|---------|
| Resolver IP | The resolver still learns client IP and all queries |
| TLS SNI (DoT) | SNI of the resolver's hostname visible (mitigated by ECH) |
| Query timing | Traffic analysis over encrypted channel can infer query rate |
| QNAME minimisation | RFC 7816 reduces data sent to authoritative servers; orthogonal to DoT/DoH |

**Deployments:** Cloudflare (1.1.1.1), Google (8.8.8.8), Quad9 (9.9.9.9) all support both DoT and DoH. Firefox defaults to DoH via Cloudflare (US) since 2020. Android 9+ supports DoT as "Private DNS". Windows 11 supports DoH natively. iOS 14+ supports DoH and DoT via configuration profiles.

**State of the art:** RFC 7858 (DoT, 2016), RFC 8484 (DoH, 2018). DoH over HTTP/3 (DoH3) is in active deployment at Cloudflare and Google. RFC 9230 (ODoH, 2022) is the privacy-maximizing successor. See [DNSCurve](#dnscurve--link-level-dns-encryption), [Oblivious HTTP](#oblivious-http-ohttp), [Encrypted Client Hello](#encrypted-client-hello-ech).

**Production readiness:** Production
Deployed by all major DNS resolvers (Cloudflare, Google, Quad9). Firefox defaults to DoH. Android 9+ supports DoT natively. Windows 11 supports DoH.

**Implementations:**
- [Unbound](https://github.com/NLnetLabs/unbound) ⭐ 4.4k — C; recursive resolver with DoT and DoH support
- [CoreDNS](https://github.com/coredns/coredns) ⭐ 13k — Go; DNS server with DoT and DoH plugins
- [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) ⭐ 13k — Go; DNS proxy supporting DoH, DoT, DNSCrypt, ODoH
- [dns-over-https (Facebook)](https://github.com/facebookarchive/doh-proxy) ⭐ 462 — Python/Go; DoH proxy implementations

**Security status:** Secure
Encrypts DNS queries via TLS 1.3. DoH is indistinguishable from HTTPS traffic. Resolver still learns all queries; ODoH (RFC 9230) addresses this.

**Community acceptance:** Standard
IETF RFC 7858 (DoT), RFC 8484 (DoH), RFC 9230 (ODoH). Deployed by major DNS providers and operating systems.

---

## I2P — Garlic Routing and Tunnel-Based Anonymity

**Goal:** Provide a network-layer anonymity overlay where participants communicate through a series of encrypted, unidirectional tunnels — hiding both sender and receiver identities and traffic patterns from any single node or outside observer. Unlike Tor's onion routing, I2P uses *garlic routing*: multiple messages are bundled together ("cloves") and encrypted in a single layered packet, improving efficiency and resisting traffic correlation.

**Architecture — core concepts:**

| Concept | Description |
|---------|-------------|
| **Router** | Each I2P participant runs a router that forwards encrypted tunnel traffic for others |
| **Tunnel** | Unidirectional chain of routers; each router knows only its predecessor and successor |
| **Lease Set** | Signed advertisement of a destination's current inbound tunnels, published to the NetDB |
| **NetDB** | Distributed hash table of router infos and lease sets; stored across all I2P routers |
| **Garlic message** | Multiple encrypted "cloves" (sub-messages) bundled and layered like an onion |
| **Destination** | A cryptographic identifier (public key) for a service; analogous to a Tor .onion address |

**Tunnel construction (I2P spec):**

```
Sender ──► Gateway ──► Hop 1 ──► Hop 2 ──► Endpoint   (outbound tunnel)
                                                   │
                                                   ▼
Recipient's Gateway ◄── Hop A ◄── Hop B ◄── (recipient's inbound tunnel)
```

Each router in the tunnel holds only one layer of encryption; it decrypts its layer and passes the remainder to the next hop. A full circuit requires combining the sender's outbound tunnel with the recipient's inbound tunnel (obtained from their lease set).

**Cryptographic primitives (I2P ECIES-X25519-AEAD-Ratchet, 2020):**

| Layer | Primitive | Note |
|-------|-----------|------|
| Tunnel layer encryption | ChaCha20-Poly1305 | Per-hop AEAD; replaces older ElGamal/AES-CBC |
| End-to-end session (ECIES Ratchet) | X25519 + HKDF + ChaCha20-Poly1305 | Forward-secret; double-ratchet-like session |
| Router identity | Ed25519 + X25519 key pair | Signed router info; X25519 for DH |
| Lease set signature | Ed25519 | Destination authenticates its tunnel endpoints |
| NetDB transport | NTCP2 (Noise `XK` + ChaCha20-Poly1305) | Encrypted router-to-router transport |

**ECIES-X25519-AEAD-Ratchet (2020 upgrade):**

The modern I2P session layer replaces the legacy ElGamal+AES-256-CBC+SessionTag scheme with a double-ratchet-inspired protocol:
- New Session: sender uses recipient's static X25519 public key (from lease set) + ephemeral key → HKDF-derived session keys
- Existing Session: ratchet advances via a "next key" field in messages; provides forward secrecy without a full new handshake
- Garlic cloves: up to ~255 sub-messages bundled in a single encrypted garlic message, reducing per-message overhead and traffic analysis correlation

**I2P vs. Tor:**

| Property | I2P | Tor |
|----------|-----|-----|
| Routing model | Garlic (bundle multiple messages) | Onion (single message per circuit) |
| Tunnel direction | Unidirectional (separate in/out tunnels) | Bidirectional (single circuit) |
| Hidden services | I2P eepsites (.i2p) — first-class design | Tor .onion — added later |
| External internet | Outproxies (optional, not core design) | Exit nodes (core design) |
| Network size | ~50 000 routers (2024) | ~7 000 relays (2024) |
| Standardization | Community spec at geti2p.net | Tor Project specs at spec.torproject.org |

**State of the art:** I2P 2.x with ECIES-X25519-AEAD-Ratchet (2020+) and NTCP2 transport. Java I2P and i2pd (C++) are the main router implementations. Deployed for privacy-sensitive file sharing (I2PSnark BitTorrent), eepsite hosting, and anonymous IRC. See [Anonymity / Onion Routing](11-anonymity-credentials.md#onion-routing), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Mature
~50,000 active routers (2024). Stable for file sharing, eepsite hosting, and anonymous IRC. Niche user base compared to Tor.

**Implementations:**
- [i2pd](https://github.com/PurpleI2P/i2pd) ⭐ 4.0k — C++; lightweight I2P router; actively maintained
- [I2P (Java)](https://github.com/i2p/i2p.i2p) ⭐ 2.5k — Java; original reference router implementation

**Security status:** Secure
ECIES-X25519-AEAD-Ratchet (2020) provides forward secrecy with modern primitives. NTCP2 uses Noise XK + ChaCha20-Poly1305. Legacy ElGamal/AES-CBC deprecated.

**Community acceptance:** Niche
Community-developed specification; not IETF-standardized. Smaller network than Tor (~50K vs ~7K relays, but different architectures). Well-regarded in the privacy community.

---

## Post-Quantum TLS Handshake — X25519Kyber768 Hybrid in Practice

**Goal:** Protect TLS key exchange against future quantum computers by combining a classical X25519 ECDH with an ML-KEM-768 (Kyber768) KEM in a single hybrid key exchange — so that session keys remain secret even if one of the two algorithms is later broken, without waiting for a full PQ migration of certificates and signatures.

**Hybrid key exchange construction (X25519Kyber768, RFC 9497 / draft-ietf-tls-hybrid-design):**

The hybrid group is defined as: the concatenation of an X25519 key share and an ML-KEM-768 key share, both sent in the TLS `key_share` extension. Key material is derived by concatenating both shared secrets before HKDF:

```
TLS 1.3 key schedule input = X25519_shared_secret ∥ ML-KEM-768_shared_secret

Final session key = HKDF(X25519_SS ∥ Kyber_SS, ...)
```

Breaking the session requires breaking *both* X25519 (classical hardness) and ML-KEM-768 (lattice hardness).

**Wire format (TLS 1.3 ClientHello `key_share` extension):**

| Field | Size | Content |
|-------|------|---------|
| X25519 public key | 32 bytes | Classical ECDH share |
| ML-KEM-768 public key | 1 184 bytes | Kyber encapsulation key |
| Named group ID | `0x11EC` (`X25519Kyber768Draft00`) or `0x6399` (IANA assigned) | Identifies the hybrid group |

Server responds with:
- X25519 share (32 bytes) + ML-KEM-768 ciphertext (1 088 bytes) in `key_share` ServerHello

**IANA registration and naming history:**

| Identifier | Name | Status |
|------------|------|--------|
| `0x11EC` | `X25519Kyber768Draft00` | Experimental; used in Chrome/Cloudflare deployment 2023 |
| `0x6399` | `X25519MLKEM768` | IANA-assigned (2024); in OpenSSL 3.5+, BoringSSL |

**Deployment timeline:**

| Date | Event |
|------|-------|
| Aug 2023 | Chrome 116 enables `X25519Kyber768Draft00` by default |
| Sep 2023 | Cloudflare enables hybrid KEM on all TLS termination points |
| Oct 2023 | Firefox 119 enables by default |
| Jul 2024 | NIST finalizes ML-KEM (FIPS 203); identifier updated to `X25519MLKEM768` |
| Jan 2025 | OpenSSL 3.5 adds `X25519MLKEM768`; BoringSSL tracks IANA name |
| Mar 2025 | ~20% of global TLS 1.3 handshakes use hybrid KEM (Cloudflare radar) |

**What is NOT yet post-quantum:** TLS certificates still use ECDSA P-256 or RSA signatures for server authentication. A quantum adversary who can break ECDSA could forge server certificates at handshake time. The hybrid KEM protects the *session key* (forward secrecy against future quantum decryption of recorded traffic), not the authentication chain. Full PQ TLS authentication requires PQ signatures in certificates — still in progress (see [KEMTLS](#kemtls-post-quantum-tls), NIST ML-DSA/SLH-DSA).

**State of the art:** `X25519MLKEM768` is the current standard name (IANA, 2024); deployed by default in Chrome, Firefox, Cloudflare, Google, AWS CloudFront. OpenSSH 10.0 defaults to the same hybrid for SSH (as `mlkem768x25519-sha256`). See [KEMTLS](#kemtls-post-quantum-tls), [X3DH / PQXDH](#x3dh--extended-triple-dh-key-agreement), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
~20% of global TLS 1.3 handshakes use hybrid KEM (2025). Deployed by default in Chrome, Firefox, Cloudflare, AWS CloudFront.

**Implementations:**
- [BoringSSL](https://boringssl.googlesource.com/boringssl/) — C; X25519MLKEM768 in Chrome and Google services
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C; X25519MLKEM768 support in 3.5+
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust; hybrid PQ key exchange via aws-lc-rs
- [liboqs](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C; Open Quantum Safe ML-KEM library

**Security status:** Secure
Hybrid construction: breaking the session requires breaking both X25519 (ECDH) and ML-KEM-768 (lattice). NIST-standardized (FIPS 203). No known attacks.

**Community acceptance:** Standard
IANA-assigned named group (0x6399). Deployed by default in major browsers. NIST FIPS 203 (ML-KEM). The standard PQ migration path for TLS.

---

## Nostr — Cryptographic Identity and Relay-Based Messaging

**Goal:** A minimal, censorship-resistant social messaging protocol where identity is a secp256k1 key pair — not an account on a server — and messages are signed events broadcast to a network of relays. Any relay can be added or dropped; clients hold their own keys and are the sole identity authority.

**Protocol design (NIP-01 core specification):**

Every Nostr interaction is a signed JSON *event*:

```json
{
  "id":      "<SHA-256 of canonical event content>",
  "pubkey":  "<32-byte hex secp256k1 public key>",
  "created_at": 1700000000,
  "kind":    1,
  "tags":    [["p", "<hex pubkey>"], ["e", "<event id>"]],
  "content": "Hello Nostr",
  "sig":     "<64-byte Schnorr signature over id>"
}
```

**Cryptographic primitives:**

| Primitive | Detail |
|-----------|--------|
| Identity key pair | secp256k1 (same curve as Bitcoin); private key is 32-byte random scalar |
| Event ID | `SHA-256(canonical_JSON_of_[0, pubkey, created_at, kind, tags, content])` |
| Signature | Schnorr (BIP-340) over the event ID; 64-byte `(R, s)` |
| Key encoding | Public key as 32-byte x-only point (BIP-340 convention) |
| Human-readable key | `npub1…` / `nsec1…` — bech32 encoding (NIP-19) |

**Direct encrypted messages (NIP-04 and NIP-44):**

| Version | Encryption | Status |
|---------|------------|--------|
| NIP-04 | ECDH (secp256k1) → AES-256-CBC + HMAC-SHA-256; base64 ciphertext in `content` | Deprecated; lacks padding, MAC-then-encrypt |
| NIP-44 | ECDH → HKDF-SHA-256 → ChaCha20-Poly1305; message padding (power-of-2 length) | Current standard (2024) |

**NIP-44 key derivation (detail):**

```
shared_secret = secp256k1_ECDH(sender_sk, recipient_pk)   # x-coordinate only
conversation_key = HKDF-SHA-256(shared_secret, salt="nip44-v2", output=32)
(chacha_key, chacha_nonce, hmac_key) = HKDF-Expand(conversation_key, ...)
ciphertext = ChaCha20-Poly1305(chacha_key, chacha_nonce, padded_plaintext)
```

**Relay protocol:** Clients connect to relays via WebSocket; publish events with `["EVENT", event]`; subscribe with filters via `["REQ", subid, {kinds:[1], authors:[...]}]`. Relays are interchangeable — clients connect to multiple simultaneously for redundancy. No relay has exclusive control of a user's identity.

**Trust model:** Events are self-authenticating — any client can verify a signature without trusting any relay. A relay cannot forge events (secp256k1 Schnorr is unforgeable). A relay can censor (refuse to store) events, but clients can bypass by publishing to additional relays.

**Deployments:** Damus (iOS), Amethyst (Android), Snort (web), Primal (web/mobile). ~1 500 public relays (2024). Bitcoin Lightning payments integrated via NIP-57 (Zaps). NIP-46 (Nostr Connect) and NIP-96 (file storage) extend the base protocol.

**State of the art:** NIP-44 (2024) for encrypted DMs; NIP-01 core spec stable. Nostr does not provide forward secrecy or post-compromise security in its DM model — a leaked private key exposes all past DMs. This is a known limitation; NIP-104 (group chats with MLS) is under active discussion. See [Signatures — Advanced](08-signatures-advanced.md), [Double Ratchet](#double-ratchet--symmetric-ratchet).

**Production readiness:** Experimental
Multiple clients deployed; ~1500 public relays (2024). Protocol is stable but DM encryption lacks forward secrecy.

**Implementations:**
- [nostr-tools](https://github.com/nbd-wtf/nostr-tools) ⭐ 839 — TypeScript; reference client library
- [rust-nostr](https://github.com/rust-nostr/nostr) ⭐ 616 — Rust; Nostr protocol library and SDK
- [Damus](https://github.com/damus-io/damus) ⭐ 2.1k — Swift; iOS Nostr client
- [Amethyst](https://github.com/vitorpamplona/amethyst) ⭐ 1.5k — Kotlin; Android Nostr client

**Security status:** Caution
Events are self-authenticating via secp256k1 Schnorr signatures (BIP-340). NIP-44 DMs use ChaCha20-Poly1305 (secure primitives) but lack forward secrecy — a leaked key exposes all past DMs. No post-compromise security.

**Community acceptance:** Emerging
Community-developed; growing adoption in Bitcoin-adjacent communities. Not standardized by any formal body. NIP process is open and decentralized.

---

## Cwtch and Session Protocol — Metadata-Resistant Group Messaging

**Goal:** Provide group messaging where not only message content but also *who is talking to whom* is hidden from servers and network observers — using onion routing or decentralized routing so that no single party learns the social graph.

### Cwtch (Tor Onion Service Group Chat)

**Design (Open Privacy Research Society; spec at cwtch.im):**

Cwtch uses Tor v3 onion services as the transport layer. Each user is identified by their onion address (an Ed25519 public key), which is both their network address and their cryptographic identity. Group conversations are hosted as onion services; membership is enforced by the group server holding a pre-shared group key.

| Component | Mechanism |
|-----------|-----------|
| Identity | Ed25519 key pair; onion address = `base32(pubkey).onion` |
| Transport | Tor v3 onion services (6-hop circuits); server and client IPs hidden from each other |
| Group key | Pre-shared symmetric key for group; distributed out-of-band or via pairwise channels |
| Message encryption | Group messages encrypted with group key (AES-256-GCM); also wrapped in Tor's onion encryption |
| Metadata resistance | Group server sees only ciphertext and onion-layer traffic; cannot identify participants |
| Profile storage | Encrypted local SQLite database; key derived from user passphrase via Argon2 |

**Threat model:** A Cwtch group server learns: that some onion addresses connected at some times. It does not learn participant identities (unless onion addresses are linked elsewhere), message contents, or social graph beyond "connected to this server." Tor provides network-layer anonymity.

### Session Protocol (Signal Fork with Onion Routing)

**Design (Session Messenger; OXEN blockchain-backed relay network):**

Session is a fork of the Signal Protocol that removes phone-number registration (identity = Ed25519 key pair) and routes messages through a decentralized onion routing network of ~2 000 volunteer nodes (the OXEN Service Node network), rather than Signal's centralized servers.

| Component | Mechanism |
|-----------|-----------|
| Identity | Ed25519 key pair; Session ID = hex-encoded public key (no phone number) |
| Message encryption | Signal Protocol Double Ratchet (modified; no X3DH server pre-key upload) |
| Transport | 3-hop onion routing over OXEN Service Nodes; Sphinx-like packet format |
| Onion encryption | Each hop: X25519 ECDH + AES-256-GCM; layered for 3 hops |
| Group chats | Closed groups: Double Ratchet per member pair; Open groups: server-side plaintext (not E2E) |
| Account registration | None — generate key pair locally; no phone or email required |
| Pre-key distribution | Session nodes store sealed-sender pre-keys; no central key server |

**Session onion routing packet (Sphinx-inspired):**

```
Client builds 3-layer packet:
  Outer layer: encrypted for Node 1 (X25519 + AES-GCM)
    Middle layer: encrypted for Node 2
      Inner layer: encrypted for Node 3 (final delivery)
```

Each node decrypts its layer, learns only next-hop, and forwards. The destination (recipient's swarm of nodes) learns only that a packet arrived, not the sender's IP.

**Comparison:**

| Property | Cwtch | Session |
|----------|-------|---------|
| Anonymity network | Tor (mature, audited) | OXEN onion routing (smaller, newer) |
| Message crypto | Group PSK + Tor onion | Double Ratchet + onion |
| Identity | Ed25519 onion address | Ed25519 Session ID |
| Registration | None | None |
| Group forward secrecy | No (PSK) | Partial (per-member DR) |
| Audits | Limited | Independent audits 2021, 2023 |

**State of the art:** Cwtch 1.12+ (2024); Session 1.18+ (2024). Both provide metadata resistance that Signal does not (Signal's servers see sender/recipient identifiers). Session's onion routing is not as battle-tested as Tor; Cwtch's Tor dependency makes it robust but subject to Tor blocking. See [Anonymity / Onion Routing](11-anonymity-credentials.md#onion-routing), [Double Ratchet](#double-ratchet--symmetric-ratchet), [Briar](#briar--bramble-p2p-encrypted-messaging).

**Production readiness:** Experimental
Both are deployed with active user bases but smaller scale than mainstream messengers. Session has had independent audits (2021, 2023).

**Implementations:**
- [Cwtch](https://git.openprivacy.ca/cwtch.im/cwtch) — Go; reference Cwtch protocol library
- [Session Android](https://github.com/oxen-io/session-android) ⭐ 1.9k — Kotlin; Session messenger for Android
- [Session Desktop](https://github.com/oxen-io/session-desktop) ⭐ 1.6k — TypeScript; Session desktop client
- [Session iOS](https://github.com/oxen-io/session-ios) ⭐ 429 — Swift; Session messenger for iOS

**Security status:** Caution
Cwtch leverages Tor's mature anonymity network; crypto primitives are sound. Session uses well-audited Double Ratchet but its OXEN onion routing network is smaller and less battle-tested than Tor. Both provide stronger metadata resistance than Signal.

**Community acceptance:** Niche
Privacy-focused communities. Cwtch developed by Open Privacy Research Society. Session backed by the OXEN Foundation. Neither is IETF-standardized.

---

## MIMI / More Instant Messaging Interoperability

**Goal:** Enable end-to-end encrypted messaging interoperability across different providers (e.g., WhatsApp, Signal, iMessage) without undermining E2E security guarantees, as mandated by the EU Digital Markets Act.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **MIMI Protocol** | 2023 | MLS + HTTPS | IETF draft; hub-based room model; each room hosted by one provider, federated membership [[1]](https://datatracker.ietf.org/doc/draft-ietf-mimi-protocol/) |
| **MIMI Architecture** | 2023 | MLS + X.509/VCs | Defines identity, key discovery, and policy across providers [[1]](https://datatracker.ietf.org/doc/html/draft-ietf-mimi-arch-01) |
| **MIMI Content Format** | 2023 | MLS application data | Standardized message semantics (text, media, reactions, threads) for cross-provider rooms [[1]](https://datatracker.ietf.org/doc/draft-ietf-mimi-content/) |

**State of the art:** IETF MIMI working group active (draft-ietf-mimi-protocol-05, Oct 2025). Built on top of [MLS (RFC 9420)](#continuous-group-key-agreement-cgka--mls) for E2E encryption. Driven by EU DMA interoperability requirements for gatekeepers. Matrix proposed as a transport framework candidate. See [MLS](#continuous-group-key-agreement-cgka--mls), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Research
IETF draft stage; no production deployments yet. Driven by EU DMA regulatory requirements.

**Implementations:**
- No production implementations yet; IETF drafts reference [OpenMLS](https://github.com/openmls/openmls) ⭐ 905 and [mls-rs](https://github.com/awslabs/mls-rs) for the underlying MLS layer

**Security status:** Secure
Built on MLS (RFC 9420); E2E encryption properties are inherited. Interoperability-specific security challenges (cross-provider key discovery, identity federation) are under active analysis.

**Community acceptance:** Emerging
Active IETF MIMI working group (draft-05, 2025). Driven by EU DMA mandate. Major messaging providers are participating. Not yet an RFC.

---

## SFrame / Secure Frame for Real-Time Media

**Goal:** Lightweight end-to-end encryption for audio and video in multiparty conference calls, allowing Selective Forwarding Units (SFUs) to route media by metadata without accessing plaintext content. Designed to be transport-agnostic (works with or without RTP).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SFrame** | 2024 | AEAD + per-sender keys | **RFC 9605**; encrypts whole media frames or per-packet; KID field selects key, CTR constructs nonce [[1]](https://www.rfc-editor.org/rfc/rfc9605.html) |

**Cipher suites:** AES_128_CTR_HMAC_SHA256_80, AES_128_GCM_SHA256_128, AES_256_GCM_SHA512_128.

**Key differences from [SRTP](#srtp--secure-real-time-transport-protocol):**
- Transport-agnostic (not tied to RTP)
- Encrypts entire media frames (not individual RTP packets), reducing per-packet overhead
- Designed for E2E encryption through SFUs; SRTP typically terminates at the SFU
- Key management is out-of-band (e.g., via [MLS](#continuous-group-key-agreement-cgka--mls))

**State of the art:** RFC 9605 (Sep 2024); widely deployed in group video platforms (Cisco Webex, others). Cisco provides an open-source C++ implementation [[1]](https://github.com/cisco/sframe). See [SRTP](#srtp--secure-real-time-transport-protocol), [MLS](#continuous-group-key-agreement-cgka--mls).

**Production readiness:** Production
Deployed in Cisco Webex for E2E encrypted group video. RFC 9605 finalized September 2024.

**Implementations:**
- [sframe (Cisco)](https://github.com/cisco/sframe) ⭐ 8 — C++; reference SFrame implementation

**Security status:** Secure
Uses standard AEAD cipher suites (AES-GCM, AES-CTR + HMAC). Per-sender keys with counter-based nonces. Well-analysed in the IETF process.

**Community acceptance:** Standard
IETF RFC 9605 (2024). Designed for E2E encrypted conferencing. Complements MLS (RFC 9420) for key management.

---

## Rosenpass / Post-Quantum Key Exchange for WireGuard

**Goal:** Add post-quantum security to [WireGuard](#wireguard-noise_ikpsk2-handshake) without modifying the kernel module, by running a separate post-quantum key exchange daemon that injects fresh symmetric keys into WireGuard's pre-shared key (PSK) slot every two minutes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rosenpass** | 2023 | Classic McEliece + ML-KEM (Kyber) | Formally verified (ProVerif); Noise-inspired handshake; Classic McEliece for auth, Kyber for forward secrecy [[1]](https://rosenpass.eu/) |

**Protocol design:**
- Two post-quantum KEMs in a hybrid: **Classic McEliece** (code-based, conservative) for authentication/confidentiality and **ML-KEM-512** (lattice-based) for forward secrecy
- Runs as a userspace Rust daemon alongside WireGuard; injects a new PSK every 2 minutes via WireGuard's existing PSK interface
- Cookie-based DoS resistance (addresses WireGuard CVE-2021-46873)
- Formally verified using ProVerif symbolic analysis

**State of the art:** Rosenpass v0.2+ (2024); packaged for Arch Linux, NixOS; integrated into NetBird mesh VPN [[1]](https://github.com/rosenpass/rosenpass). Funded by NLnet/NGI [[1]](https://nlnet.nl/project/Rosenpass/). See [WireGuard Noise_IKpsk2](#wireguard-noise_ikpsk2-handshake), [Post-Quantum TLS](#post-quantum-tls-handshake--x25519kyber768-hybrid-in-practice).

**Production readiness:** Experimental
Working daemon packaged for Arch Linux and NixOS; integrated into NetBird mesh VPN. Not yet widely deployed.

**Implementations:**
- [Rosenpass](https://github.com/rosenpass/rosenpass) ⭐ 1.3k — Rust; PQ key exchange daemon for WireGuard

**Security status:** Secure
Formally verified with ProVerif. Uses Classic McEliece (conservative code-based KEM) + ML-KEM-512 (lattice). Both KEMs are well-studied.

**Community acceptance:** Emerging
Funded by NLnet/NGI. Formally verified. Growing interest in the WireGuard/VPN community. Not yet an IETF standard.

---

## age / Modern File Encryption Format

**Goal:** Provide a simple, composable, UNIX-style file encryption tool and format with small explicit keys, no configuration knobs, and no PGP legacy — as a modern replacement for GPG file encryption.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **age** | 2019 | X25519 + ChaCha20-Poly1305 | Designed by Filippo Valsorda (Go team); 64 KiB chunks; AEAD per chunk [[1]](https://github.com/FiloSottile/age) |
| **age (passphrase mode)** | 2019 | scrypt + ChaCha20-Poly1305 | Symmetric encryption with scrypt KDF (r=8, P=1); tunable work factor [[1]](https://github.com/C2SP/C2SP/blob/main/age.md) |

**Format structure:**
- **Header:** plaintext; contains one or more "stanzas" — each wraps the file key for one recipient (X25519 public key or scrypt passphrase)
- **Payload:** file key encrypts payload via HKDF-SHA-256 -> ChaCha20-Poly1305; split into 64 KiB chunks, each independently authenticated; final chunk flagged to detect truncation

**Implementations:** Go (reference, `filippo.io/age`), Rust (`rage` by str4d), TypeScript (`typage`), Java (`jagged`). Plugin system for hardware tokens (age-plugin-yubikey).
- [typage](https://github.com/FiloSottile/typage) ⭐ 411 — TypeScript; age in the browser

**State of the art:** age v1.2+ (2024); specification maintained at C2SP [[1]](https://github.com/C2SP/C2SP/blob/main/age.md). Adopted by SOPS, chezmoi, and infrastructure tooling. Not a protocol for interactive communication — strictly offline file encryption. See [OpenPGP](#openpgp-rfc-9580).

**Production readiness:** Mature
Widely adopted in DevOps and infrastructure tooling (SOPS, chezmoi). Stable specification with multiple interoperable implementations.

**Implementations:**
- [age](https://github.com/FiloSottile/age) ⭐ 21k — Go; reference implementation by Filippo Valsorda
- [rage](https://github.com/str4d/rage) ⭐ 3.4k — Rust; compatible age implementation
- [age-plugin-yubikey](https://github.com/str4d/age-plugin-yubikey) ⭐ 860 — Rust; YubiKey hardware token plugin

**Security status:** Secure
Uses X25519 + HKDF-SHA-256 + ChaCha20-Poly1305. Per-chunk AEAD with truncation detection. Minimal, well-studied design with no configuration knobs.

**Community acceptance:** Widely trusted
C2SP specification. Designed by Filippo Valsorda (Go team). Widely adopted in infrastructure tooling. Not an IETF RFC but well-regarded by cryptographers.

---

## Saltpack / NaCl-Based Authenticated Message Format

**Goal:** Modern replacement for PGP message format, built as a thin wrapper around NaCl (Networking and Cryptography Library). Provides encryption, signing, and signcryption with repudiable authentication, recipient anonymity, and chunk-based streaming.

| Mode | Year | Basis | Note |
|------|------|-------|------|
| **Saltpack Encryption v2** | 2017 | X25519 + XSalsa20-Poly1305 | Multi-recipient; ephemeral sender key; repudiable auth; 1 MiB chunks [[1]](https://saltpack.org/encryption-format-v2) |
| **Saltpack Signing v2** | 2017 | Ed25519 | Attached or detached signatures; chunk-based streaming [[1]](https://saltpack.org/signing-format-v2) |
| **Saltpack Signcryption v2** | 2017 | Ed25519 + X25519 + XSalsa20-Poly1305 | Combined encrypt + sign; non-repudiable (sender signs each chunk) [[1]](https://saltpack.org/signcryption-format) |

**Design properties:**
- Only authenticated data is ever output (no unauthenticated plaintext release)
- Recipient list is hidden (each recipient key slot is encrypted)
- Chunks cannot be reordered or spliced across messages (sequential nonce)
- Truncation is detectable (final chunk flag)
- Binary format uses MessagePack; ASCII armor available for copy-paste

**State of the art:** Developed by Keybase; used in Keybase Chat and Keybase filesystem. Keybase was acquired by Zoom (2020); Saltpack spec remains open [[1]](https://github.com/keybase/saltpack). See [OpenPGP](#openpgp-rfc-9580), [age](#age--modern-file-encryption-format).

**Production readiness:** Mature
Deployed in Keybase Chat and Keybase filesystem. Spec is open but Keybase product is in maintenance mode (Zoom acquisition, 2020).

**Implementations:**
- [saltpack (Go)](https://github.com/keybase/saltpack) ⭐ 1.0k — Go; Keybase reference implementation
- [keys.pub saltpack](https://github.com/keys-pub/keys-ext) ⭐ 65 — Go; alternative Saltpack client

**Security status:** Secure
Built on NaCl primitives (X25519 + XSalsa20-Poly1305 + Ed25519). Chunk-based streaming with truncation detection and splice prevention. Well-designed.

**Community acceptance:** Niche
Open specification. Developed by Keybase. Not standardized by IETF. Limited adoption outside the Keybase ecosystem since the Zoom acquisition.

---

## NTS / Network Time Security

**Goal:** Provide cryptographic authentication and integrity for NTP (Network Time Protocol) time synchronization, preventing man-in-the-middle attacks that could shift a client's clock — which would break TLS certificate validation, TOTP codes, and other time-dependent security mechanisms.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **NTS** | 2020 | TLS 1.3 + AEAD cookies | **RFC 8915**; two-phase: NTS-KE (key establishment over TLS) + NTS extension fields (per-packet AEAD auth) [[1]](https://www.rfc-editor.org/rfc/rfc8915) |

**Protocol phases:**
1. **NTS Key Establishment (NTS-KE):** Client connects to NTS-KE server on TCP port 4460; TLS 1.3 handshake authenticates server via X.509; negotiates AEAD algorithm (AES-SIV); TLS key export provides symmetric keys; server sends opaque cookies; connection closes (server retains no per-client state)
2. **NTS Extension Fields:** Client sends NTP request with cookie + AEAD-authenticated extension fields; server validates cookie, reconstructs keys, sends authenticated NTP response with fresh cookies

**Security properties:** Server authentication (X.509 via TLS), packet integrity (AEAD), replay resistance (unique cookies), no server-side state (cookies are opaque, self-encrypted by server), forward secrecy (from TLS 1.3 handshake).

**State of the art:** Deployed by Cloudflare (time.cloudflare.com) [[1]](https://blog.cloudflare.com/nts-is-now-rfc/), Netnod, and others. Supported by Chrony, NTPsec, ntpd-rs. See [DTLS](#dtls--datagram-tls), [Secure Channels](#secure-channels--protocol-constructions).

**Production readiness:** Production
Deployed by Cloudflare, Netnod, and other time service providers. Supported in major NTP implementations.

**Implementations:**
- [Chrony](https://gitlab.com/chrony/chrony) — C; NTP client/server with NTS support
- [NTPsec](https://github.com/ntpsec/ntpsec) ⭐ 277 — C; hardened NTP with NTS
- [ntpd-rs](https://github.com/pendulum-project/ntpd-rs) ⭐ 1.0k — Rust; NTP daemon with NTS support

**Security status:** Secure
TLS 1.3 for key establishment; AES-SIV for per-packet authentication. Stateless server design via opaque cookies. Forward secrecy from TLS handshake.

**Community acceptance:** Standard
IETF RFC 8915 (2020). Deployed by major time service providers. Growing adoption as NTP security becomes more important.

---

## Roughtime / Authenticated Rough Time Synchronization

**Goal:** Provide cryptographically authenticated wall-clock time to clients that may have no prior idea of the current time — using public-key signatures (not symmetric keys) so any client can verify responses without pre-shared secrets. Designed for "rough" accuracy (~10 seconds), sufficient to validate TLS certificates and prevent clock-based attacks.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Roughtime** | 2016 | Ed25519 signatures | Google-designed; every response is signed; supports ecosystem auditing via chained proofs [[1]](https://roughtime.googlesource.com/roughtime/+/HEAD/PROTOCOL.md) |

**Protocol design:**
- Server holds a long-term Ed25519 key and publishes a delegation certificate to a short-term online signing key
- Client sends a 64-byte random nonce; server replies with: `{timestamp, radius, nonce-hash, signature}`
- Responses include a Merkle tree of client nonces — one signature covers many clients (batch efficiency)
- **Ecosystem auditing:** Client can chain responses from multiple servers; if any server lies, the signed timestamps form a cryptographic proof of misbehavior

**State of the art:** IETF draft-ietf-ntp-roughtime (draft-19, 2025) [[1]](https://datatracker.ietf.org/doc/draft-ietf-ntp-roughtime/). Public servers operated by Google and Cloudflare [[1]](https://developers.cloudflare.com/time-services/roughtime/). Implementations in Go, Rust (roughenough), C. Complements [NTS](#nts--network-time-security) (which provides precise authenticated time but requires initial clock accuracy for TLS).

**Production readiness:** Experimental
Public servers operated by Google and Cloudflare. IETF draft (not yet RFC). Limited client integration.

**Implementations:**
- [roughenough](https://github.com/int08h/roughenough) ⭐ 142 — Rust; Roughtime server and client
- [roughtime (Google)](https://roughtime.googlesource.com/roughtime/) — Go/C++; Google's reference implementation
- [cloudflare-roughtime](https://github.com/cloudflare/roughtime) ⭐ 169 — Go; Cloudflare Roughtime server

**Security status:** Secure
Ed25519 signatures on time responses. Merkle tree batching for efficiency. Ecosystem auditing enables detection of misbehaving servers.

**Community acceptance:** Emerging
IETF draft-19 (2025); not yet an RFC. Operated by Google and Cloudflare. Designed by Google's Adam Langley. Growing interest as a complement to NTS.

---

## SCRAM / Salted Challenge Response Authentication Mechanism

**Goal:** Password-based mutual authentication that never transmits the plaintext password, stores only salted/hashed credentials on the server, and binds to the TLS channel to prevent credential forwarding — replacing legacy PLAIN and CRAM-MD5 SASL mechanisms.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SCRAM-SHA-1** | 2010 | PBKDF2 + HMAC-SHA-1 | **RFC 5802**; SASL/GSS-API mechanism; salted storage; mutual auth [[1]](https://www.rfc-editor.org/rfc/rfc5802) |
| **SCRAM-SHA-256** | 2016 | PBKDF2 + HMAC-SHA-256 | **RFC 7677**; upgrade to SHA-256; recommended for new deployments [[1]](https://www.rfc-editor.org/rfc/rfc7677.html) |
| **SCRAM-SHA-256-PLUS** | 2016 | PBKDF2 + HMAC-SHA-256 + channel binding | RFC 7677; binds to TLS channel via `tls-server-end-point` or `tls-unique`; prevents credential relay [[1]](https://datatracker.ietf.org/doc/html/rfc7677) |

**Protocol flow (4 messages):**
1. **Client-first:** username + client nonce
2. **Server-first:** server nonce + salt + iteration count
3. **Client-final:** client proof = `HMAC(StoredKey, AuthMessage) XOR ClientKey`; channel binding data
4. **Server-final:** server signature = `HMAC(ServerKey, AuthMessage)` — proves server knows the password hash

**Security properties:** Server stores `StoredKey = H(ClientKey)` and `ServerKey` — neither is sufficient to impersonate the client. PBKDF2 with configurable iteration count resists offline brute-force. Channel binding (`-PLUS` variants) prevents MITM relay attacks.

**State of the art:** Default auth in PostgreSQL 10+ (scram-sha-256), MongoDB 4.0+, CockroachDB. Supported in XMPP (XEP-0474), IMAP, SMTP. See [EAP-PWD](#eap-pwd--password-based-enterprise-wifi-auth), [TOTP/FIDO2/WebAuthn](#token-based-authentication-totp--fido2--webauthn).

**Production readiness:** Production
Default authentication in PostgreSQL 10+, MongoDB 4.0+, CockroachDB. Supported in XMPP, IMAP, SMTP.

**Implementations:**
- [PostgreSQL](https://github.com/postgres/postgres) ⭐ 20k — C; SCRAM-SHA-256 as default authentication
- [Cyrus SASL](https://github.com/cyrusimap/cyrus-sasl) ⭐ 155 — C; SASL library with SCRAM support
- [GNU SASL (gsasl)](https://www.gnu.org/software/gsasl/) — C; SCRAM-SHA-256 and -PLUS variants

**Security status:** Secure
SCRAM-SHA-256 with channel binding (-PLUS) is secure against offline dictionary attacks and credential relay. PBKDF2 with configurable iterations. SCRAM-SHA-1 should be upgraded to SHA-256.

**Community acceptance:** Standard
IETF RFC 5802 (SCRAM-SHA-1), RFC 7677 (SCRAM-SHA-256). Default in major databases. Widely adopted in SASL-capable protocols.

---

## tcpcrypt / Opportunistic TCP Stream Encryption

**Goal:** Encrypt all TCP traffic by default at the transport layer, with zero configuration and graceful fallback — providing opportunistic encryption that protects against passive eavesdroppers without requiring certificates, PKI, or application changes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **tcpcrypt** | 2019 | TCP-ENO + ECDHE | **RFC 8548** (Experimental); negotiated via TCP options; kernel-level; transparent to applications [[1]](https://www.rfc-editor.org/rfc/rfc8548.html) |
| **TCP-ENO** | 2019 | TCP option negotiation | **RFC 8547**; generic framework for negotiating TCP encryption; tcpcrypt is the first instantiation [[1]](https://datatracker.ietf.org/doc/html/rfc8547) |

**Design properties:**
- Negotiated entirely within TCP SYN/SYN-ACK options (no extra round trips)
- Falls back to unencrypted TCP if either side does not support it (or middleboxes strip options)
- Tolerates NATs, resegmentation, and other middlebox behavior
- Provides a **session ID** that applications can use for higher-level authentication (e.g., binding to application-layer credentials)
- Does not authenticate peers by itself — prevents passive eavesdropping but not active MITM without additional application-layer binding

**State of the art:** RFC 8548 (Experimental, May 2019). Linux kernel prototype exists. Adoption limited by middlebox interference with TCP options and competition from TLS-everywhere and [QUIC](#quic-packet-protection). Conceptually related to [BIP 324](#bip-324--opportunistic-p2p-encryption) (opportunistic encryption for Bitcoin P2P). See [Secure Channels](#secure-channels--protocol-constructions), [STARTTLS](#starttls--opportunistic-vs-mandatory-tls).

**Production readiness:** Experimental
Linux kernel prototype exists. Limited adoption due to middlebox interference and competition from TLS-everywhere.

**Implementations:**
- [tcpcrypt (reference)](https://github.com/scslab/tcpcrypt) ⭐ 214 — C; Linux kernel module and userspace prototype
- [TCP-ENO spec](https://datatracker.ietf.org/doc/html/rfc8547) — framework specification (implementations integrated into tcpcrypt)

**Security status:** Caution
Cryptographic design (ECDHE + AEAD) is sound. Opportunistic mode does not prevent active MITM without application-layer binding. Session ID enables optional authentication.

**Community acceptance:** Niche
IETF Experimental RFC 8548. Limited deployment. Conceptually influential but practically superseded by TLS-everywhere and QUIC.

---
