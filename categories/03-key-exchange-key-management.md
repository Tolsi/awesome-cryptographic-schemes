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
