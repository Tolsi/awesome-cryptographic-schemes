# Key Exchange & Key Management

## Key Exchange / Key Agreement

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

---

## Password-Based Key Derivation (KDF / PAKE)

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

---

## Hierarchical Deterministic Keys (BIP32 / HD Wallets)

**Goal:** Structured key derivation. From a single master seed, deterministically derive an entire tree of key pairs. Each branch can be delegated (extended public key) without exposing the master. Standard in every cryptocurrency wallet.

| Standard | Year | Basis | Note |
|----------|------|-------|------|
| **BIP32 (HD Wallets)** | 2012 | HMAC-SHA512 + secp256k1 | Master seed → child key tree; supports extended public keys for watch-only [[1]](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) |
| **BIP44 (Multi-Account)** | 2014 | BIP32 + derivation paths | Standard paths: m/purpose'/coin'/account'/change/index [[1]](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) |
| **SLIP-10** | 2016 | BIP32 for Ed25519/NIST | Extend HD derivation to non-secp256k1 curves [[1]](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) |

**State of the art:** BIP32/44 (every Bitcoin/Ethereum wallet), SLIP-10 (Solana, Cardano, multi-curve wallets).

---

## Key Wrapping / Envelope Encryption

**Goal:** Protect keys with keys. Encrypt a secret key (DEK) under a key-encryption key (KEK), providing confidentiality + integrity for key material. Standard pattern in HSMs, cloud KMS, and key hierarchies.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **AES-KW (Key Wrap)** | 2001 | AES + Feistel | NIST SP 800-38F; RFC 3394; 64-bit integrity check [[1]](https://www.rfc-editor.org/rfc/rfc3394) |
| **AES-KWP (Key Wrap with Padding)** | 2001 | AES-KW + padding | For non-aligned key sizes; RFC 5649 [[1]](https://www.rfc-editor.org/rfc/rfc5649) |
| **Envelope Encryption** | 2006 | KEM + DEK pattern | AWS KMS / GCP CMEK pattern: wrap DEK with KEK; store wrapped DEK alongside data [[1]](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#enveloping) |
| **SIV for Key Wrapping** | 2006 | AES-SIV | Misuse-resistant alternative; see [Deterministic Encryption](#deterministic-encryption--convergent-encryption) [[1]](https://www.rfc-editor.org/rfc/rfc5297) |

**State of the art:** AES-KW (NIST/HSMs), Envelope Encryption (all major cloud KMS).

---

## Non-Interactive Key Exchange (NIKE)

**Goal:** Implicit key agreement. Two parties compute a shared secret from each other's public keys alone — no message exchange at all. Stronger than DH which requires ephemeral exchange.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Static Diffie-Hellman** | 1976 | DLP | g^(ab) from static keys; simplest NIKE but no forward secrecy [[1]](https://ieeexplore.ieee.org/document/1055638) |
| **Freire-Hofheinz-Kiltz-Paterson NIKE** | 2013 | DDH + trapdoor | First NIKE with CKS-heavy security from standard assumptions [[1]](https://eprint.iacr.org/2012/732) |
| **CSIDH** | 2018 | Isogenies | Post-quantum NIKE from supersingular isogeny group actions [[1]](https://eprint.iacr.org/2018/383) |

**State of the art:** CSIDH for PQ-NIKE (but slow); static-DH widely used in practice (see [Key Exchange](#key-exchange--key-agreement)). True NIKE is rare — most protocols prefer ephemeral key exchange for forward secrecy.

---

## Certificateless Cryptography

**Goal:** No certificates, no key escrow. Eliminates the heavy PKI of traditional public-key crypto AND the key-escrow problem of IBE. A KGC (Key Generation Center) provides partial keys, but the user adds their own secret — KGC alone cannot decrypt.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Al-Riyami-Paterson CL-PKE** | 2003 | Pairings | First certificateless PKE; KGC partial key + user secret [[1]](https://eprint.iacr.org/2003/126) |
| **CL-PKS (Certificateless Signatures)** | 2005 | Pairings | Certificateless signature scheme [[1]](https://eprint.iacr.org/2005/220) |
| **Self-Certified Keys (Girault)** | 1991 | RSA | Precursor: public key implicitly certified by its structure [[1]](https://doi.org/10.1007/3-540-46416-6_42) |

**State of the art:** Pairing-based CL-PKE; fills the gap between IBE (see [IBE](#identity-based-encryption-ibe)) and traditional PKI. Popular in IoT research where certificate management is expensive.

---

## Certificate Transparency (CT)

**Goal:** Public auditability of certificates. Append-only Merkle-tree log of all TLS certificates issued by CAs, so misissued certificates are publicly detectable. Not a cryptographic primitive per se, but a critical cryptographic protocol.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Certificate Transparency (RFC 6962)** | 2013 | Merkle tree + signatures | Google initiative; all major CAs participate [[1]](https://www.rfc-editor.org/rfc/rfc6962) |
| **Signed Certificate Timestamps (SCT)** | 2013 | Ed25519 / ECDSA | Proof of log inclusion; embedded in TLS certificates [[1]](https://www.rfc-editor.org/rfc/rfc6962) |
| **Verifiable Data Structures** | 2015 | Merkle / append-only | General framework: key transparency, binary transparency (Google) [[1]](https://transparency.dev/) |

**State of the art:** CT v2 (mandatory for Chrome), Key Transparency (Google/Apple for E2E messaging).

---

## ACME Protocol / Automated Certificate Management

**Goal:** Cryptographically automate the issuance and renewal of X.509 TLS certificates by proving domain control via challenge-response protocols — eliminating manual certificate management. The foundation of Let's Encrypt (600M+ certificates issued).

**Core cryptographic operations:**

| Step | Mechanism |
|------|-----------|
| **Account key** | ECDSA P-256 or RSA-2048 JWK |
| **Request signing** | JWS (JSON Web Signature) with account key over all requests |
| **Domain validation (HTTP-01)** | Server places `token.keyAuthorization` at `/.well-known/acme-challenge/`; keyAuthorization = `token || '.' || SHA-256(accountKey)` |
| **Domain validation (DNS-01)** | Server places `Base64url(SHA-256(keyAuthorization))` in `_acme-challenge.` TXT DNS record |
| **CSR submission** | Standard PKCS#10 CSR signed with domain private key |
| **Certificate issuance** | CA verifies challenge, signs cert; server fetches via ACME order |

**Nonce replay prevention:** Every ACME request requires a fresh `Replay-Nonce` header (JWS protected). Server rejects replays.

**Key authorization binding:** `SHA-256(accountKey)` binds the domain proof to the specific ACME account — prevents a different ACME account from stealing a challenge response.

| Implementation | Usage |
|----------------|-------|
| **Let's Encrypt** | 600M+ certs; largest CA globally [[1]](https://letsencrypt.org/) |
| **ZeroSSL / Buypass** | Alternative free CAs using ACME |
| **certbot / acme.sh** | Reference clients; automates renewal |
| **Caddy** | Web server with ACME built-in |

**State of the art:** RFC 8555 (2019); universally adopted. ACME for email (S/MIME, RFC 8823) is emerging. See [Certificate Transparency](#certificate-transparency-ct) for log-based revocation transparency.

---

## JOSE / JWS / JWE / JWT

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

---

## Key Transparency / CONIKS

**Goal:** Verifiable key directory. A public, append-only log that maps usernames to public keys — anyone can audit that the server hasn't secretly swapped someone's key. Prevents misbinding attacks where a server substitutes a malicious key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CONIKS** | 2015 | Merkle prefix tree | First key transparency system; users verify their own key bindings [[1]](https://eprint.iacr.org/2014/1004) |
| **Google Key Transparency** | 2017 | Sparse Merkle + VRF | Production system; verifiable log of key-to-account bindings [[1]](https://github.com/google/keytransparency) |
| **SEEMless (Meta)** | 2023 | Verifiable log | WhatsApp key transparency; Auditable Key Directory [[1]](https://engineering.fb.com/2023/04/13/security/whatsapp-key-transparency/) |
| **Signal Key Transparency** | 2024 | Merkle + monitoring | Detects key substitution in Signal's server [[1]](https://signal.org/blog/key-transparency/) |

**State of the art:** SEEMless (WhatsApp), Signal Key Transparency (2024). Closely related to [Certificate Transparency](#certificate-transparency-ct).

---

## Updatable CRS / Powers of Tau

**Goal:** Perpetually strengthened trusted setup. A common reference string (CRS) for SNARKs that can be continuously updated by new participants — each adds their own randomness. The CRS is secure as long as at least one participant was honest, ever.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bowe-Gabizon-Miers (Powers of Tau)** | 2017 | Pairings + KZG | Universal SRS ceremony; sequential contributions; used by Zcash [[1]](https://eprint.iacr.org/2017/1050) |
| **Zcash Powers of Tau Ceremony** | 2018 | BGM protocol | 87 participants; produced SRS for Sapling [[1]](https://z.cash/technology/paramgen/) |
| **Ethereum KZG Ceremony** | 2023 | KZG SRS | 141,416 contributors; SRS for EIP-4844 (proto-danksharding) [[1]](https://ceremony.ethereum.org/) |
| **Universal SRS (SONIC/Marlin/PLONK)** | 2019 | Updatable + universal | One SRS for all circuits up to a size bound [[1]](https://eprint.iacr.org/2019/953) |

**State of the art:** Ethereum KZG ceremony (141k participants); universal updatable SRS for [PLONK-family](#zero-knowledge-proofs-zk) SNARKs.

---

## Password Hardened Encryption (PHE)

**Goal:** Two-factor encryption. Decryption requires both the user's password and a server-side key. A server breach alone is useless (no password); a password brute-force alone is useless (no server key). The server never sees plaintext.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lai-Tlejben-Abel-Polyakov PHE** | 2018 | OPRF + AE | PHE from oblivious PRF; server evaluates OPRF on password [[1]](https://eprint.iacr.org/2018/003) |
| **Pythia PRF** | 2015 | Partially-oblivious PRF | Server-side key-rotation without re-encrypting; verifiable [[1]](https://eprint.iacr.org/2015/644) |
| **OPAQUE (as PHE)** | 2018 | aPAKE | Can serve as PHE base: server stores password file, client derives key [[1]](https://eprint.iacr.org/2018/163) |

**State of the art:** PHE (Lai et al. 2018); deployed by Virgil Security. Related to [OPRF](#oblivious-prf-oprf) and [PAKE](#password-based-key-derivation-kdf--pake).

---

## SLIP-39 / Shamir Backup for Hardware Wallets

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

**State of the art:** SLIP-39 (SatoshiLabs 2019). Trezor-native; not widely supported elsewhere. Complements BIP-85 (derive child seeds from recovered master). See [Secret Sharing Schemes](#secret-sharing-schemes-sss), [HD Wallets](#hierarchical-deterministic-keys-bip32--hd-wallets).

---

## SIGMA Protocol (SIGn-and-MAc)

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

**State of the art:** Cite as [[1]](https://iacr.org/archive/crypto2003/27290399/27290399.pdf). Security proof in the BR model; formalised by Canetti-Krawczyk in the UC model. Related to [IKEv2 / IPsec ESP](categories/12-secure-communication-protocols.md#ikev2--ipsec-esp) and [Key Exchange / Key Agreement](#key-exchange--key-agreement).

---

## Triple Diffie-Hellman (3DH) / X3DH

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

**State of the art:** X3DH (Signal 2016). Feeds directly into the [Double Ratchet](categories/12-secure-communication-protocols.md#double-ratchet--signal-protocol). 3DH without the one-time prekey is the core also used in SIGMA-family proofs. See [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [X3DH](categories/12-secure-communication-protocols.md#x3dh--extended-triple-diffie-hellman).

---

## Noise Protocol Framework

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

**State of the art:** Noise revision 34 (2018); formally verified in ProVerif and Tamarin. The framework unifies dozens of bespoke protocols into a single analysable family. See [Key Exchange / Key Agreement](#key-exchange--key-agreement) and [Secure Channels](categories/12-secure-communication-protocols.md#secure-channels--transport-layer-security).

---

## Dragonfly Handshake / SAE (Simultaneous Authentication of Equals)

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

---

## OCSP / Certificate Revocation

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

**State of the art:** OCSP stapling + CRLite/CRLSets is the current industry direction. Google Chrome no longer does live OCSP for DV certs. Short-lived certificates (6–90 day) are the emerging solution — revocation becomes unnecessary when certs expire before the attacker can exploit them. See [Certificate Transparency](#certificate-transparency-ct) and [ACME Protocol](#acme-protocol--automated-certificate-management).

---

## J-PAKE (Password-Authenticated Key Exchange by Juggling)

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

---

## SPEKE (Simple Password Exponential Key Exchange)

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

---

## ECMQV (Elliptic Curve Menezes-Qu-Vanstone)

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

---

## TLS 1.3 Key Schedule

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

---

## FFDHE — Named Finite-Field DH Groups (RFC 7919)

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

---

## WireGuard Cryptographic Protocol

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

---

## PKIX / X.509 v3 Certificate Profile (RFC 5280)

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

**State of the art:** RFC 5280 (2008) [[1]](https://www.rfc-editor.org/rfc/rfc5280); updated by RFC 8398 (internationalized email in SANs) and RFC 9549 (algorithm agility). Baseline Requirements (CA/Browser Forum) [[2]](https://cabforum.org/baseline-requirements/) constrain what WebPKI CAs may issue. Related to [ACME Protocol](#acme-protocol--automated-certificate-management), [Certificate Transparency](#certificate-transparency-ct), and [DANE](categories/14-applied-infrastructure-pki.md#dane--dns-based-authentication-of-named-entities).

---

## Station-to-Station (STS) Protocol

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

---

## IKEv1 vs IKEv2 (Internet Key Exchange)

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

---

## SCEP (Simple Certificate Enrollment Protocol, RFC 8894)

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
- No renewal automation — contrast with [ACME](#acme-protocol--automated-certificate-management)

| Deployment | Usage |
|------------|-------|
| **Cisco IOS / ASA** | Network device cert enrollment |
| **Microsoft NDES** | Network Device Enrollment Service (Windows Server) |
| **Apple MDM** | iOS/macOS device certificate provisioning via MDM payload |
| **strongSwan** | Linux IPsec gateway auto-enrollment |

**State of the art:** RFC 8894 (2020) [[1]](https://www.rfc-editor.org/rfc/rfc8894). Widely deployed in MDM and network device PKI; simpler than [CMP](#cmp-certificate-management-protocol-rfc-42109483) but less feature-rich. Being supplemented by [EST](#est-enrollment-over-secure-transport-rfc-7030) in newer deployments. Related to [ACME Protocol](#acme-protocol--automated-certificate-management) and [PKIX / X.509 v3](#pkix--x509-v3-certificate-profile-rfc-5280).

---

## EST (Enrollment over Secure Transport, RFC 7030)

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

**State of the art:** RFC 7030 (2013) [[1]](https://www.rfc-editor.org/rfc/rfc7030); updated by RFC 8295 (additional attrs). Widely adopted in industrial IoT (IEC 62351-8), automotive (AUTOSAR), and enterprise MDM. Cisco, Microsoft, and DigiCert all support EST. Related to [SCEP](#scep-simple-certificate-enrollment-protocol-rfc-8894), [CMP](#cmp-certificate-management-protocol-rfc-42109483), and [ACME Protocol](#acme-protocol--automated-certificate-management).

---

## CMP (Certificate Management Protocol, RFC 4210/9483)

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

---

## PKCS#12 / PFX (Private Key + Certificate Bundle)

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

**State of the art:** RFC 7292 (2014) [[1]](https://www.rfc-editor.org/rfc/rfc7292); PBES2 migration tracked in RFC 9579 (2024) which updates PKCS#12 to mandate PBKDF2 and AES. Supported natively by Windows (CertMgr), macOS Keychain, iOS, Android, Firefox, and all major TLS servers. Related to [PKIX / X.509 v3](#pkix--x509-v3-certificate-profile-rfc-5280), [ACME Protocol](#acme-protocol--automated-certificate-management), and [Key Wrapping / Envelope Encryption](#key-wrapping--envelope-encryption).

---
