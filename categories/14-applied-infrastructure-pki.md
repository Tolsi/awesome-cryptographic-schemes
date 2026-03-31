# Applied Cryptography & Infrastructure / PKI

## W3C Decentralized Identifiers (DID) and Verifiable Credentials

**Goal:** Enable self-sovereign digital identity — cryptographically verifiable identifiers and credentials that are not controlled by any single authority. Anyone can create a DID, prove ownership of it, and issue or present signed credential claims.

**DID Document structure:**
```json
{
  "id": "did:key:z6Mk...",
  "verificationMethod": [{
    "id": "did:key:z6Mk...#keys-1",
    "type": "Ed25519VerificationKey2020",
    "publicKeyMultibase": "z6Mk..."
  }],
  "authentication": ["did:key:z6Mk...#keys-1"]
}
```

**DID Methods (how the DID is resolved):**

| Method | Anchor | Note |
|--------|--------|------|
| `did:key` | Self-describing (key material in DID) | No ledger; offline; ephemeral |
| `did:web` | HTTPS well-known URL | Simple; relies on DNS/TLS |
| `did:ion` | Bitcoin (Sidetree) | Censorship-resistant; slow |
| `did:ethr` | Ethereum | Smart contract registry |
| `did:peer` | None (pairwise) | Private peer relationships |

**Verifiable Credentials (VC) crypto:**

| Format | Signature | Selective disclosure |
|--------|-----------|---------------------|
| **JWT VC** | RS256 / ES256 / EdDSA | No (full JWT) |
| **SD-JWT VC** | ES256 | Yes — hash-based digests (RFC 9901) |
| **VC with BBS+** | BBS+ pairing sigs | Yes — ZK selective disclosure |
| **JSON-LD + Data Integrity** | Ed25519 / BBS+ | Depends on proof type |

**Deployed at scale:**
- EU Digital Identity Wallet (eIDAS 2.0) — mandated for 450M citizens
- Apple/Google Wallet (mDL ISO 18013-5 over OpenID4VP)
- IATA Travel Pass (airline boarding credentials)
- Academic credentials (MIT, many universities)

**State of the art:** W3C DID Core v1.0 (2022 W3C Recommendation); VC Data Model 2.0 (2024). EU eIDAS 2.0 mandates DID + SD-JWT + BBS+ for EU digital identity. See [Anonymous Credentials](#anonymous-credentials), [SD-JWT](#anonymous-credentials).

**Production readiness:** Production
Deployed at scale in EU Digital Identity Wallet (eIDAS 2.0, 450M citizens), Apple/Google Wallet mDL, IATA Travel Pass, and academic credentialing systems worldwide.

**Implementations:**
- [SpruceID DIDKit](https://github.com/spruceid/didkit) ⭐ 318 — Rust, cross-platform DID/VC toolkit
- [Walt.id SSI Kit](https://github.com/walt-id/waltid-ssikit) ⭐ 112 — Kotlin, enterprise SSI library
- [Veramo](https://github.com/decentralized-identity/veramo) ⭐ 533 — TypeScript, DIF-maintained DID framework
- [Hyperledger Aries](https://github.com/hyperledger/aries-framework-go) ⭐ 240 — Go, enterprise agent framework

**Security status:** Caution
Core cryptography is sound (Ed25519, BBS+, ECDSA), but security depends heavily on the DID method chosen; `did:web` inherits DNS/TLS risks, and BBS+ implementations are still maturing.

**Community acceptance:** Standard
W3C Recommendation (DID Core v1.0, VC Data Model 2.0); EU eIDAS 2.0 regulation mandates adoption; IETF SD-JWT (RFC 9449); broad multi-stakeholder governance.

---

## DANE / DNS-Based Authentication of Named Entities

**Goal:** Bind TLS certificates to domain names using DNSSEC-signed DNS records (TLSA records) — without relying on the public CA ecosystem. Prevents BGP hijacking + rogue CA attacks: even if a CA is compromised, the attacker cannot present a valid certificate that passes DANE validation.

**TLSA record structure:**

```
_443._tcp.example.com. IN TLSA <usage> <selector> <matching-type> <cert-data>
```

| Field | Options | Meaning |
|-------|---------|---------|
| Usage | 0 (PKIX-TA) | CA constraint — PKIX + DNSSEC check |
| | 1 (PKIX-EE) | EE constraint — specific cert must match |
| | 2 (DANE-TA) | Trust anchor — like pinning a root CA |
| | **3 (DANE-EE)** | EE only — bypass PKIX entirely; most secure |
| Selector | 0 (Full cert) | Match full DER-encoded cert |
| | 1 (SPKI) | Match SubjectPublicKeyInfo only |
| Matching | 1 (SHA-256) | SHA-256 hash of selected data |
| | 2 (SHA-512) | SHA-512 hash |

**DANE-EE (usage 3) with DNSSEC:**
- Server cert verified by SHA-256 hash in TLSA record
- TLSA record integrity guaranteed by DNSSEC (RRSIG chain)
- No CA involvement: effectively "your DNS zone IS your CA"
- Supports self-signed certs with full security

**Deployments:** Postfix/Exim (SMTP DANE — RFC 7672); SMTPS to major providers (Fastmail, ProtonMail); HTTPS DANE (niche, requires DNSSEC resolver); XMPP (RFC 7673).

**DANE for email (RFC 7672):** Publishing TLSA records allows receiving SMTP servers to pin the sending server's certificate. Google, Microsoft, and most major providers support DANE for inbound SMTP.

**Limitation:** Requires DNSSEC deployment — only ~35% of domains are DNSSEC-signed. Limited browser support (no DANE for HTTPS in Chrome/Firefox without extension).

**State of the art:** RFC 6698 (DANE), RFC 7671 (DANE operational), RFC 7672 (SMTP DANE). Production-grade for email; emerging for HTTPS. Complement to [Certificate Transparency](#certificate-transparency-ct).

**Production readiness:** Mature
Production-grade for SMTP (Postfix, Exim, major email providers); limited browser support for HTTPS DANE due to low DNSSEC deployment (~35% of domains).

**Implementations:**
- [Unbound](https://github.com/NLnetLabs/unbound) ⭐ 4.4k — C, DNSSEC-validating resolver with DANE support
- [Postfix](https://github.com/vdukhovni/postfix) ⭐ 530 — C, SMTP server with built-in DANE-TLS (RFC 7672)
- [LDNS](https://github.com/NLnetLabs/ldns) ⭐ 348 — C, DNS library with DANE/TLSA utilities
- [GnuTLS](https://gitlab.com/gnutls/gnutls) — C, TLS library with DANE verification API

**Security status:** Secure
Cryptographically sound when backed by DNSSEC; DANE-EE (usage 3) bypasses CA ecosystem entirely. Without DNSSEC, TLSA records are spoofable.

**Community acceptance:** Standard
IETF RFCs 6698, 7671, 7672; mandated by several European email providers; widely adopted in SMTP ecosystem; HTTPS adoption limited by DNSSEC dependency.

---

## TEE Remote Attestation

**Goal:** Cryptographically prove to a remote verifier that a specific piece of code is running inside a genuine Trusted Execution Environment (TEE) — and that the code has not been tampered with. Enables trustless confidential computing: a client can send secrets to cloud code only after verifying the enclave.

**Generic attestation flow:**

1. **Quote generation:** TEE hardware signs a measurement (hash of loaded code) with a platform-specific key
2. **Quote structure:** Contains `[measurement | TEE type | nonce | user data]` — signed by hardware
3. **Verification:** Relying party verifies the signature chain up to the vendor's root certificate
4. **Policy check:** Verify measurement matches expected code hash; check security version numbers

**Platform-specific implementations:**

| Platform | Attestation type | Root of trust | Measurement |
|----------|-----------------|---------------|-------------|
| **Intel SGX** | EPID / DCAP | Intel's IAS or PCCS | MRENCLAVE (code) + MRSIGNER (key) |
| **Intel TDX** | TD Quote (DCAP-based) | Intel PCK cert | MRTD (TD image) |
| **AMD SEV-SNP** | Attestation Report | AMD VCEK cert | Guest measurement |
| **AWS Nitro Enclaves** | Nitro attestation document | AWS NitroTPM | PCR0 (enclave image hash) |
| **ARM TrustZone** | No standardized protocol | OEM-specific | TA UUID + hash |
| **TPM 2.0 (general)** | TPM Quote / PCR attestation | EK cert chain | PCR bank values |

**Cryptographic primitives used:**
- Measurement: SHA-256 or SHA-384 of loaded pages
- Quote signature: ECDSA P-256 (DCAP, Nitro) or RSA-3072 (EPID)
- Freshness: user-supplied nonce embedded in quote to prevent replay

**Challenge for remote attestation:** Certificate revocation for compromised platform keys; Intel and AMD publish PCCS/VCEK revocation lists. Attestation freshness (nonce binding) prevents replay of old quotes.

**Key standards:**
- Intel DCAP (Data Center Attestation Primitives) — RFC-like spec
- RATS (Remote ATtestation procedureS) — IETF RFC 9334 (2023): architecture framework
- DICE (Device Identifier Composition Engine) — IETF RFC 9360

**State of the art:** IETF RFC 9334 (2023) defines the RATS architecture. AWS Nitro Attestation and Intel DCAP are production-grade. Widely used in: confidential ML inference, threshold key management (AWS KMS), cross-chain bridges, and TEE-based wallets. See [TEE Signer Architecture](#tee-signer-architecture) and [Proof of Secure Erasure](#proof-of-secure-erasure-pose).

**Production readiness:** Production
Intel DCAP and AWS Nitro Attestation are deployed at scale in cloud confidential computing; Azure Attestation Service and Google Confidential VMs in production.

**Implementations:**
- [Intel SGX DCAP](https://github.com/intel/SGXDataCenterAttestationPrimitives) ⭐ 321 — C/C++, data center attestation primitives
- [aws-nitro-enclaves-sdk](https://github.com/aws/aws-nitro-enclaves-sdk-c) ⭐ 113 — C, AWS Nitro Enclaves attestation SDK
- [Keylime](https://github.com/keylime/keylime) ⭐ 522 — Python, CNCF remote attestation framework for TPM/TEE
- [virtee/sev](https://github.com/virtee/sev) ⭐ 138 — Rust, AMD SEV-SNP attestation library

**Security status:** Caution
Attestation protocols are cryptographically sound, but TEE vulnerabilities (SGX side-channels, microcode bugs) require continuous patching; security depends on vendor TCB update discipline.

**Community acceptance:** Standard
IETF RFC 9334 (RATS architecture); Intel DCAP and AMD SEV-SNP specifications; broad adoption by all major cloud providers (AWS, Azure, GCP).

---

## EMV Cryptographic Authentication

**Goal:** Authenticate payment cards (debit/credit) at point-of-sale terminals — with or without network connectivity — using asymmetric cryptography embedded in the chip. ~10 billion EMV cards globally; every chip-and-PIN and contactless payment.

**Authentication generations:**

| Type | Year | Crypto | Online req. | Note |
|------|------|--------|------------|------|
| **SDA** | 2000 | RSA static signature | No | Broken: replay attacks |
| **DDA** | 2003 | RSA + dynamic nonce | No | Card signs terminal nonce |
| **CDA** | 2004 | RSA + transaction data | No | Binds auth to transaction |
| **fDDA** | 2014 | RSA | No | Optimized for contactless |

**DDA cryptographic flow:**
```
Card holds: ICC Private Key (RSA 2048)
            Issuer PK Certificate (signed by Visa/MC root CA)

1. Terminal → Card: Random nonce (8 bytes)
2. Card → Terminal: Sign(ICC_PrivKey, nonce || tx_data || timestamp)
3. Terminal: verify ICC cert chain → Visa/MC root → verify signature
```

**Key hierarchy:** Visa/MC Root CA → Issuing Bank CA → Individual Card Key (RSA 2048)

**Contactless (Apple Pay, Google Pay):** Uses EMV fDDA within 500ms NFC window; secure element in phone emulates card; DH-based session key for NFC channel encryption (ISO 14443).

**Known attacks:** "Yes cards" (Cambridge 2010) — exploited offline PIN; "No-PIN" contactless (ETH Zurich 2020). EMV v4.3+ mitigates.

**State of the art:** EMV v4.3; transitioning to ECDSA for smaller keys. EMV 3DS v2 (2019) for card-not-present (e-commerce). See [Digital Signatures](#digital-signatures), [ACME/PKI](#acme-protocol--automated-certificate-management).

**Production readiness:** Production
Deployed on ~10 billion payment cards globally; every chip-and-PIN and contactless (NFC) transaction uses EMV authentication.

**Implementations:**
- [EMVCo specifications](https://www.emvco.com/emv-technologies/contact/) — official specifications (proprietary)
- [GlobalPlatformPro](https://github.com/martinpaljak/GlobalPlatformPro) ⭐ 873 — Java, smart card management tool with EMV support
- [Cardpeek](https://github.com/L1L1/cardpeek) ⭐ 512 — C, smart card analysis tool supporting EMV

**Security status:** Caution
DDA/CDA are cryptographically sound (RSA-2048); legacy SDA is broken (replay attacks). Known attack classes ("Yes card," contactless relay) mitigated in EMV v4.3+; transitioning to ECDSA.

**Community acceptance:** Standard
EMVCo consortium (Visa, Mastercard, JCB, Amex, UnionPay, Discover); mandatory for chip payments in all major markets; PCI DSS compliance framework.

---

## Kerberos v5

**Goal:** Provide single sign-on (SSO) for network services using a trusted third party (Key Distribution Center, KDC) — without sending passwords over the network and without each service needing to store user credentials. The dominant enterprise authentication protocol: every Active Directory domain uses Kerberos.

**Principal roles:**
- **Client (C)** — user or service requesting access
- **KDC** — split into Authentication Server (AS) and Ticket-Granting Server (TGS)
- **Service (S)** — target application server (file share, web app, database)

**Protocol flow (RFC 4120):**

```
1. C → AS:  KRB_AS_REQ  (client principal, requested TGT, nonce, PA-ENC-TIMESTAMP)
2. AS → C:  KRB_AS_REP  (TGT encrypted with KDC key, session key K_ct encrypted with user's key)
3. C → TGS: KRB_TGS_REQ (TGT + Authenticator{timestamp, seqno} encrypted with K_ct)
4. TGS → C: KRB_TGS_REP (service ticket encrypted with service key, session key K_cs)
5. C → S:   KRB_AP_REQ  (service ticket + Authenticator encrypted with K_cs)
6. S → C:   KRB_AP_REP  (mutual auth: server proves knowledge of K_cs)
```

**Cryptographic primitives:**
| Element | Modern (RFC 4120 + 8009) | Legacy |
|---------|--------------------------|--------|
| Long-term keys | AES-256-CTS-HMAC-SHA384-192 (etype 20) | DES3-CBC-SHA1 (deprecated) |
| Session keys | AES-128/256-CTS-HMAC-SHA256/384 | RC4-HMAC (deprecated, CVE-2022-37967) |
| Checksum | HMAC-SHA256-128 / HMAC-SHA384-192 | MD5 (deprecated) |
| Pre-auth | PA-ENC-TIMESTAMP (AES) or PKINIT (PKI) | Plain password (deprecated) |

**Ticket structure (simplified):**
```
Ticket = {
  realm, service_name,
  enc_part = AES256(K_service) {
    session_key K_cs, client_name, valid_from, valid_until,
    addresses, flags (FORWARDABLE | RENEWABLE | PROXIABLE)
  }
}
```

**Extensions:**
- **PKINIT (RFC 4556)** — smart card / certificate pre-authentication (X.509 replaces password)
- **GSSAPI / SSPI** — wraps Kerberos for transparent SSO in applications
- **S4U2Self / S4U2Proxy** — service impersonation (constrained delegation)
- **FAST (RFC 6113)** — Flexible Authentication Secure Tunneling; protects pre-auth exchange

**Known attacks:**
- **AS-REP Roasting** — for accounts with pre-auth disabled, crack offline
- **Kerberoasting** — request service ticket for any SPN, crack service account password offline
- **Pass-the-Ticket** — inject stolen TGT/service ticket into LSASS
- **Golden Ticket** — forge TGTs with stolen krbtgt key (full domain compromise)
- **Silver Ticket** — forge service tickets with stolen service key (lateral movement)
- **Bronze Bit (CVE-2020-17049)** — bypass delegation restrictions

**Deployment:** Windows Active Directory (every enterprise), MIT Kerberos (Linux/macOS SSO), Heimdal (BSD/macOS). Supported in Hadoop (YARN/HDFS), PostgreSQL, NFS v4, SSH (GSSAPI), and most SAML IdPs as backend.

**State of the art:** RFC 4120 (2005) base; RFC 8009 (2017) — AES-256-CTS-HMAC-SHA384-192 as current recommended etype; RFC 6113 FAST pre-auth; RFC 4556 PKINIT with smart cards.

**Production readiness:** Production
Core enterprise authentication protocol; every Windows Active Directory domain uses Kerberos; deployed across Hadoop, PostgreSQL, NFS v4, SSH (GSSAPI), and SAML backends.

**Implementations:**
- [MIT Kerberos](https://github.com/krb5/krb5) ⭐ 592 — C, reference implementation for Linux/macOS
- [Heimdal](https://github.com/heimdal/heimdal) ⭐ 364 — C, alternative implementation used in BSD/macOS
- [Apache Kerby](https://github.com/apache/directory-kerby) ⭐ 116 — Java, Apache Directory Kerberos implementation
- [Samba](https://github.com/samba-team/samba) ⭐ 1.1k — C, includes Kerberos KDC for Active Directory emulation

**Security status:** Caution
Secure with modern etypes (AES-256-CTS-HMAC-SHA384-192, RFC 8009); legacy RC4-HMAC and DES are broken. Operational attacks (Kerberoasting, Golden Ticket, AS-REP Roasting) exploit weak passwords and stolen keys, not protocol flaws.

**Community acceptance:** Standard
IETF RFCs 4120, 8009, 6113, 4556; ubiquitous in enterprise environments; Microsoft, MIT, and Heimdal maintain independent implementations.

---

## DNSSEC / DNS Security Extensions

**Goal:** Add cryptographic authentication to DNS — every record set (RRset) is signed by the zone owner; resolvers verify the signature chain from the root to the queried name. Prevents cache poisoning (Kaminsky attack), BGP hijacking, and on-path MITM for DNS.

**Trust chain (RFC 4033-4035):**

```
Root zone (.) → key signed by ICANN DNSKEY → DS records
  ↓ DS hash matches child DNSKEY
.com zone → DNSKEY → signs all .com RRsets
  ↓ DS hash matches child DNSKEY
example.com zone → DNSKEY → signs A, MX, TXT, etc.
```

**Record types:**
| Type | Purpose |
|------|---------|
| `DNSKEY` | Zone signing key (ZSK) or key signing key (KSK) |
| `RRSIG` | Signature over one RRset; includes validity window |
| `NSEC` / `NSEC3` | Authenticated denial of existence |
| `DS` | Delegation signer — hash of child KSK in parent zone |
| `CDS` / `CDNSKEY` | Child-side DS update (RFC 7344) |

**Signature algorithm:**
- ECDSA P-256 / SHA-256 (algorithm 13) — recommended (compact keys/sigs)
- ECDSA P-384 / SHA-384 (algorithm 14)
- Ed25519 (algorithm 15) — RFC 8080; smallest signatures (64 bytes)
- RSA/SHA-256 (algorithm 8) — legacy, large keys

**Key rollover (RFC 6781):**
- KSK rollover: add new KSK, update DS at parent, wait TTL, remove old KSK
- ZSK rollover: pre-publish new ZSK, switch signing, remove old ZSK
- Automated via CDS/CDNSKEY (RFC 7344) or ACME DNSSEC challenges

**NSEC3 vs NSEC:**
- `NSEC` leaks all zone names (zone walking)
- `NSEC3` hashes names with a salt (opt-out flag skips unsigned delegations); prevents trivial enumeration

**Deployment:** ~35% of TLDs and second-level domains signed (2024). Required by all gTLDs under ICANN. Used as trust anchor by DANE, TLSA, and SSHFP records. All major recursive resolvers (Unbound, BIND, Knot) validate by default.

**Limitations:** Amplification attack vector (DNSSEC responses are larger); NSEC3 does not prevent offline dictionary attacks on hashed names. No encryption of DNS traffic (use DoT / DoH for confidentiality).

**State of the art:** RFCs 4033-4035 (2005), updated through RFC 9364 (2023). Ed25519 (algorithm 15) is the modern choice. BIND, PowerDNS, and Knot DNS all support automated key management.

**Production readiness:** Production
~35% of TLDs and second-level domains DNSSEC-signed; required by all gTLDs under ICANN; all major recursive resolvers validate by default.

**Implementations:**
- [BIND 9](https://github.com/isc-projects/bind9) ⭐ 737 — C, ISC reference DNS server with full DNSSEC support
- [Knot DNS](https://github.com/CZ-NIC/knot) ⭐ 293 — C, authoritative DNS with automated DNSSEC key management
- [PowerDNS](https://github.com/PowerDNS/pdns) ⭐ 4.3k — C++, authoritative DNS with DNSSEC signing
- [Unbound](https://github.com/NLnetLabs/unbound) ⭐ 4.4k — C, validating recursive resolver
- [dnspython](https://github.com/rthalley/dnspython) ⭐ 2.6k — Python, DNS toolkit with DNSSEC validation

**Security status:** Secure
Cryptographically sound with modern algorithms (ECDSA P-256, Ed25519); amplification attack vector exists due to larger response sizes; NSEC3 mitigates zone enumeration but not offline dictionary attacks.

**Community acceptance:** Standard
IETF RFCs 4033-4035, RFC 9364; ICANN requires DNSSEC for gTLDs; root zone signed by ICANN since 2010; foundation for DANE, SSHFP, and TLSA.

---

## DNSSEC-Based Key Infrastructure: SSHFP, TLSA, SMIMEA

**Goal:** Use DNSSEC-signed DNS records as a cryptographic binding between domain names and public keys/certificates — eliminating reliance on the CA ecosystem for specific protocols.

| Record type | RFC | Binds | Used by |
|-------------|-----|-------|---------|
| `TLSA` | RFC 6698 | TLS certificate or key to domain+port | SMTP DANE, HTTPS DANE, XMPP |
| `SSHFP` | RFC 4255 | SSH host key fingerprint | OpenSSH (VerifyHostKeyDNS) |
| `SMIMEA` | RFC 8162 | S/MIME certificate to email address | Email encryption key discovery |
| `OPENPGPKEY` | RFC 7929 | OpenPGP key to email address | GPG key auto-discovery |

**SSHFP flow:**
```
1. Client resolves SSHFP RR via DNSSEC-validating resolver
   SSHFP 4 2 <SHA-256 of Ed25519 host key>
2. SSH client compares fingerprint against server's presented host key
3. If match + DNSSEC validated → auto-accept (no "unknown host" prompt)
```

**State of the art:** DANE with DNSSEC is production-grade for SMTP (Postfix, Exim support DANE-enabled SMTP since 2014). SSHFP supported by OpenSSH `VerifyHostKeyDNS=yes`. Adoption limited by DNSSEC deployment (~35% of domains).

**Production readiness:** Mature
Production-grade for SMTP DANE (Postfix, Exim); SSHFP supported by OpenSSH; SMIMEA and OPENPGPKEY have limited deployment due to DNSSEC adoption gaps.

**Implementations:**
- [OpenSSH](https://github.com/openssh/openssh-portable) ⭐ 3.8k — C, native SSHFP verification via `VerifyHostKeyDNS`
- [Postfix](https://github.com/vdukhovni/postfix) ⭐ 530 — C, SMTP with DANE TLSA support
- [hash-slinger](https://github.com/letoams/hash-slinger) ⭐ 55 — Python, tools for generating SSHFP, TLSA, and OPENPGPKEY records
- [Unbound](https://github.com/NLnetLabs/unbound) ⭐ 4.4k — C, DNSSEC-validating resolver underpinning all DANE lookups

**Security status:** Secure
Inherits DNSSEC security guarantees; cryptographically binds keys to DNS names. Dependent on DNSSEC deployment and correct zone signing.

**Community acceptance:** Standard
IETF RFCs 4255 (SSHFP), 6698 (TLSA), 8162 (SMIMEA), 7929 (OPENPGPKEY); widely supported in SMTP ecosystem; SSH integration mature.

---

## Sigstore / Keyless Code Signing

**Goal:** Enable developers to sign software artifacts (container images, packages, binaries) without managing long-lived private keys. Identity is bound to a short-lived certificate issued via OIDC (GitHub Actions, Google Accounts, etc.); the signing event is recorded in an append-only, publicly auditable transparency log.

**Components:**
| Component | Role |
|-----------|------|
| **Fulcio** | OIDC-backed certificate authority — issues short-lived (<10 min) code-signing certificates |
| **Rekor** | Append-only transparency log (Merkle tree) — records all signing events |
| **cosign** | CLI/library — signs, verifies, attaches signatures to OCI artifacts |
| **policy-controller** | Kubernetes admission controller — enforces signature policies |

**Keyless signing flow:**
```
1. Developer authenticates with OIDC provider (GitHub Actions, Google, Microsoft)
2. OIDC token sent to Fulcio
3. Fulcio issues leaf certificate binding: OIDC subject + ephemeral public key
4. Developer signs artifact digest with ephemeral key
5. Certificate + signature + artifact digest recorded in Rekor
6. Ephemeral private key discarded (short-lived certificate expires in ~10 min)
```

**Verification:**
```
cosign verify --certificate-identity-regexp=".*"
             --certificate-oidc-issuer="https://token.actions.githubusercontent.com"
             <image>
```
Fetches signed entry from Rekor, verifies Merkle inclusion proof, checks certificate validity, verifies signature.

**Transparency log (Rekor):**
- Signed tree head (STH) over SHA-256 Merkle tree of log entries
- Supports RFC 9162 (Certificate Transparency v2) log format
- Witnesses co-sign the STH; clients can verify inclusion proofs offline

**Deployment:** Linux Foundation project (CNCF). npm (npmjs.com provenance), PyPI (PEP 740 — attestations), Kubernetes release signing, GitHub `gh attestation verify`, Red Hat RPM signing. Used by millions of container images.

**State of the art:** Sigstore Stable (2023). OpenSSF Scorecard integrates Sigstore checks. SLSA level 2+ requires build provenance signed via Sigstore.

**Production readiness:** Production
Used by npm (provenance), PyPI (PEP 740 attestations), Kubernetes release signing, GitHub attestation verification, and millions of container images.

**Implementations:**
- [cosign](https://github.com/sigstore/cosign) ⭐ 5.8k — Go, CLI for signing and verifying OCI container images
- [Fulcio](https://github.com/sigstore/fulcio) ⭐ 816 — Go, OIDC-backed code-signing certificate authority
- [Rekor](https://github.com/sigstore/rekor) ⭐ 1.1k — Go, append-only transparency log for signing events
- [sigstore-python](https://github.com/sigstore/sigstore-python) ⭐ 316 — Python, Sigstore client library
- [sigstore-js](https://github.com/sigstore/sigstore-js) ⭐ 178 — TypeScript, Sigstore client for npm ecosystem

**Security status:** Secure
Cryptographically sound design: ephemeral keys eliminate long-lived key compromise risk; Merkle-tree transparency log provides public auditability; OIDC identity binding is well-understood.

**Community acceptance:** Widely trusted
CNCF/Linux Foundation project; adopted by npm, PyPI, Kubernetes, GitHub; OpenSSF Scorecard integration; broad open-source ecosystem trust.

---

## TUF / The Update Framework

**Goal:** Secure software update delivery against a compromised update server, a compromised signing key, or a network MITM. Even if the repository is fully compromised, clients that have seen a recent valid root cannot be tricked into installing malicious or rolled-back packages.

**Threat model addressed:**
| Attack | TUF defense |
|--------|------------|
| Arbitrary package substitution | Target files listed with SHA-256 hash + length in signed metadata |
| Rollback attack | `version` field in every metadata file; clients reject downgrades |
| Freeze attack | `expires` field in metadata; clients reject stale metadata |
| Compromised signing key | Role separation + threshold signatures; key rotation without re-trusting clients |
| Endless data attack | `length` field limits download size |

**Metadata roles:**
```
root.json ─── delegates to ──► targets.json ─── delegates to ──► delegated roles
                              └────────────────────────────────► snapshot.json
                                                                  └──► timestamp.json
```

| Role | Signs | Key storage |
|------|-------|-------------|
| `root` | Trust anchors for all other roles | Offline (HSM) |
| `targets` | Target file hashes + lengths | Online or offline |
| `snapshot` | Consistent view of all metadata files | Online |
| `timestamp` | Freshness of snapshot (updated every N minutes) | Online |

**Update protocol (RFC-draft TUF spec):**
1. Download timestamp → check expiry + version
2. Download snapshot (if timestamp changed) → verify consistency
3. Download targets metadata → list files with hashes
4. Download target file → verify SHA-256 + length

**Ngclient / go-tuf:** Reference implementations. Supports delegations for fine-grained package ownership.

**Deployment:** PyPA (pip/PyPI since 2023 via PEP 458), Docker Content Trust (Notary v1 wraps TUF), Ruby Gems, Rust crates.io (proposed), CNCF (Harbor). Used to secure Kubernetes release artifacts.

**Relationship to Sigstore:** TUF secures the distribution of metadata; Sigstore secures the build provenance of individual artifacts. Complementary — npm uses both.

**State of the art:** TUF specification v1.0.31 (2023). PEP 458 / PEP 480 bring TUF to PyPI. go-tuf and python-tuf are reference implementations. Notary v2 (CNCF) replaces Notary v1 with OCI-native TUF.

**Production readiness:** Production
Deployed in PyPI (PEP 458), Docker Content Trust (Notary v1), Kubernetes release artifacts, and CNCF Harbor registry.

**Implementations:**
- [python-tuf](https://github.com/theupdateframework/python-tuf) ⭐ 1.7k — Python, reference TUF implementation
- [go-tuf](https://github.com/theupdateframework/go-tuf) ⭐ 698 — Go, TUF client and repository library
- [Notary v2 (notation)](https://github.com/notaryproject/notation) ⭐ 472 — Go, OCI-native signing with TUF-style metadata
- [rust-tuf](https://github.com/heartsucker/rust-tuf) ⭐ 188 — Rust, TUF client library
- [Uptane](https://github.com/uptane/uptane-standard) ⭐ 43 — TUF variant for automotive OTA updates

**Security status:** Secure
Designed to be secure even against a fully compromised repository server; role separation and threshold signatures prevent single-key compromise; formal security analysis published.

**Community acceptance:** Standard
CNCF graduated project; adopted by PyPI, Docker, Kubernetes, and automotive (Uptane); specification maintained by academic-industry collaboration (NYU Tandon).

---

## Cryptographic Provenance Attestation (C2PA / SLSA)

**Goal:** Prove the origin, integrity, and chain of custody of digital artifacts. Cryptographically signed metadata binds content to its creator, creation tool, and transformation history — combating deepfakes, supply chain attacks, and misinformation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **C2PA (Coalition for Content Provenance)** | 2021 | X.509 + COSE signatures | Sign image/video/audio metadata at creation; camera → edit → publish chain [[1]](https://c2pa.org/specifications/specifications/2.1/specs/C2PA_Specification.html) |
| **SLSA (Supply-chain Levels for Software Artifacts)** | 2021 | Sigstore + attestation | Cryptographic provenance for software builds: source → build → deploy [[1]](https://slsa.dev/) |
| **Content Credentials (Adobe/Leica)** | 2023 | C2PA + hardware signing | Camera signs image at capture time; edit chain preserved through Adobe tools [[1]](https://contentcredentials.org/) |

**State of the art:** C2PA v2.1 (media), SLSA v1.0 (software); deployed by Adobe, Leica, Google, Microsoft. Related to [Linked Timestamping](#linked-timestamping) and [Digital Signatures](#digital-signatures).

**Production readiness:** Production
C2PA deployed by Adobe (Photoshop, Lightroom), Leica cameras, Microsoft, Google; SLSA adopted by GitHub Actions, Google Cloud Build, and npm.

**Implementations:**
- [c2pa-rs](https://github.com/contentauth/c2pa-rs) ⭐ 311 — Rust, C2PA reference implementation by Adobe CAI
- [c2pa-js](https://github.com/contentauth/c2pa-js) ⭐ 16 — JavaScript, C2PA verification for web
- [slsa-verifier](https://github.com/slsa-framework/slsa-verifier) ⭐ 318 — Go, SLSA provenance verification tool
- [slsa-github-generator](https://github.com/slsa-framework/slsa-github-generator) ⭐ 558 — Go, GitHub Actions SLSA provenance generator

**Security status:** Secure
Based on standard X.509/COSE signatures with well-understood cryptography; provenance chain integrity depends on correct implementation of manifest embedding and signature verification.

**Community acceptance:** Emerging
C2PA consortium (Adobe, Microsoft, Intel, BBC, others); SLSA by OpenSSF; growing adoption in media and software supply chain; standards still evolving (C2PA v2.1, SLSA v1.0).

---

## RPKI / Resource Public Key Infrastructure

**Goal:** Cryptographically authorize which Autonomous Systems (ASes) are permitted to originate specific IP address prefixes in BGP — preventing route hijacking and accidental route leaks that would otherwise redirect internet traffic through malicious or misconfigured routers.

**Trust hierarchy:**

```
IANA (root)
  └── RIRs (ARIN, RIPE, APNIC, LACNIC, AFRINIC) — issue resource certs for their IP/ASN space
        └── LIRs / ISPs — receive resource certs covering their allocated prefixes
              └── ROA (Route Origin Authorization) — signed object: "AS 64496 may announce 203.0.113.0/24"
```

**Cryptographic objects:**

| Object | Format | Signing | Purpose |
|--------|--------|---------|---------|
| **Resource Certificate** | X.509 + RFC 3779 extensions | RSA-2048/4096 | Binds IP blocks and ASNs to subject |
| **ROA (Route Origin Auth)** | CMS (RFC 3852) signed | RSA (resource cert key) | Authorizes AS to originate prefix up to maxLength |
| **Manifest** | CMS signed | RSA | Lists all current RPKI objects for a repository |
| **CRL** | X.509 CRL | RSA | Revokes resource certificates |
| **BGPsec Path Attr** | RPKI router cert | ECDSA P-256 | Signs individual BGP path segments (RFC 8205) |

**ROA structure:**
```
ROA ::= SEQUENCE {
  version    [0] INTEGER DEFAULT 0,
  asID           ASID,            -- the authorized AS number
  ipAddrBlocks   SEQUENCE OF ROAIPAddressFamily
}
-- Each ROAIPAddress: prefix + optional maxLength
-- Wrapped in CMS SignedData; signed with the holder's resource cert private key
```

**Route Origin Validation (ROV) at routers:**
```
For each received BGP prefix announcement:
  1. Fetch all ROAs covering the announced prefix from RPKI cache (RTR protocol)
  2. If no ROA exists → state: NotFound (router policy decides; typically accept)
  3. If ROA exists and AS + prefix length match → state: Valid (accept)
  4. If ROA exists but AS or maxLength mismatch → state: Invalid (drop/depref)
```

**RTR protocol (RFC 8210):** Routers fetch validated ROA payloads from a local RPKI cache (Routinator, OctoRPKI, rpki-client) over an incremental protocol; routers do not do crypto — the cache does.

**BGPsec (RFC 8205):** Extends RPKI to sign path attributes hop-by-hop; requires all ASes on path to participate — deployment remains very limited due to operational overhead.

**Deployment (2024):** >50% of global IPv4 routes and >60% of IPv6 routes covered by ROAs (NIST RPKI Monitor). Major networks deploying ROV: Cloudflare, AT&T, Deutsche Telekom, Amazon, NTT. MANRS initiative tracks ROV deployment.

**State of the art:** RFC 6480 (RPKI architecture), RFC 6482 (ROA format), RFC 6487 (resource certificates), RFC 8210 (RTR v2), RFC 8205 (BGPsec). As of 2024, majority of global routing table is ROA-covered [[1]](https://manrs.org/2024/05/rpki-rov-deployment-reaches-major-milestone/). See [DNSSEC](#dnssec--dns-security-extensions).

**Production readiness:** Production
>50% of global IPv4 routes and >60% of IPv6 routes covered by ROAs; ROV enforced by Cloudflare, AT&T, Deutsche Telekom, Amazon, NTT.

**Implementations:**
- [Routinator](https://github.com/NLnetLabs/routinator) ⭐ 556 — Rust, RPKI relying party software (NLnet Labs)
- [rpki-client](https://github.com/rpki-client/rpki-client-portable) ⭐ 67 — C, OpenBSD RPKI validator (portable)
- [OctoRPKI](https://github.com/cloudflare/cfrpki) ⭐ 178 — Go, Cloudflare RPKI validator
- [Krill](https://github.com/NLnetLabs/krill) ⭐ 357 — Rust, RPKI Certificate Authority daemon
- [FORT Validator](https://github.com/NICMx/FORT-validator) ⭐ 60 — C, RPKI relying party by LACNIC/NIC Mexico

**Security status:** Secure
X.509-based resource certificates with CMS-signed ROAs; cryptographically sound. Trust anchor distribution via TALs (Trust Anchor Locators) from five RIRs.

**Community acceptance:** Standard
IETF RFCs 6480-6487, RFC 8210; MANRS initiative tracks deployment; endorsed by NIST, RIPE, ARIN; majority of global routing table covered.

---

## CAA / Certification Authority Authorization

**Goal:** Allow domain owners to publish a DNS policy restricting which Certificate Authorities are permitted to issue TLS certificates for their domain — providing a pre-issuance control that complements post-issuance Certificate Transparency logs.

**CAA record syntax (RFC 8659):**
```
example.com.  IN  CAA  0  issue    "letsencrypt.org"
example.com.  IN  CAA  0  issue    "digicert.com"
example.com.  IN  CAA  0  issuewild ";"              ; no wildcard certs from anyone
example.com.  IN  CAA  0  iodef    "mailto:security@example.com"
```

**Property tags:**

| Tag | Meaning |
|-----|---------|
| `issue` | Names one CA authorized to issue DV/OV/EV certs for this domain |
| `issuewild` | Names one CA authorized to issue wildcard (`*.example.com`) certs; overrides `issue` for wildcards |
| `iodef` | URL or mailto for the CA to report policy violations |
| `accounturi` (RFC 8657) | Restricts issuance to a specific ACME account at the named CA |
| `validationmethods` (RFC 8657) | Restricts which ACME challenge methods (`dns-01`, `http-01`) the CA may use |

**CA enforcement:** Since CA/Browser Forum Ballot 187 (2017), all CAs in the WebPKI are **required** to check CAA before issuance. Absence of CAA records → unrestricted issuance permitted. Any CAA record → CA must be named or refuse.

**Security model:**
- Without CAA: any of ~200 trusted root CAs can issue for any domain
- With CAA: reduces that to the named subset; dramatically narrows the mis-issuance blast radius
- Does not require DNSSEC, but CAA records are trivially spoofable without DNSSEC validation by the CA

**Limitations:** CAA is checked at issuance time only; it is not verified by browsers or TLS clients at connection time. It is a CA-side process control, not a client-side enforcement. Adoption remains low (~15% of popular sites as of 2024).

**State of the art:** RFC 8659 (2019, replaces RFC 6844), RFC 8657 (2019, ACME extensions). CA/B Forum mandated CA checking since 2017. Complement to [Certificate Transparency](#certificate-transparency-ct) and [ACME Protocol](#acme-protocol--automated-certificate-management). Best used together with CAA + CT + DANE.

**Production readiness:** Production
Mandatory CA checking since 2017 (CA/Browser Forum Ballot 187); all WebPKI CAs must honor CAA records before issuance.

**Implementations:**
- [BIND 9](https://github.com/isc-projects/bind9) ⭐ 737 — C, DNS server supporting CAA record types
- [Knot DNS](https://github.com/CZ-NIC/knot) ⭐ 293 — C, authoritative DNS with CAA support
- [PowerDNS](https://github.com/PowerDNS/pdns) ⭐ 4.3k — C++, DNS server with CAA record handling
- [certbot](https://github.com/certbot/certbot) ⭐ 32k — Python, Let's Encrypt client that respects CAA policies

**Security status:** Caution
Effective as a pre-issuance control but not verified by browsers at connection time; spoofable without DNSSEC; adoption remains low (~15% of popular sites).

**Community acceptance:** Standard
IETF RFC 8659; CA/Browser Forum mandated; supported by all major CAs; simple DNS-based deployment.

---

## OCSP Stapling and Certificate Revocation

**Goal:** Allow a TLS server to prove to connecting clients that its certificate has not been revoked — without each client needing to make a live network request to the Certificate Authority's OCSP responder, which leaks browsing history to the CA and adds latency.

**Certificate revocation mechanisms:**

| Mechanism | How | Client network req. | Soft-fail risk | Deployment |
|-----------|-----|--------------------|----|------------|
| **CRL** | Download full revocation list | Yes (large) | Yes | Legacy; still used for intermediates |
| **OCSP** (RFC 6960) | Query CA per-cert | Yes (privacy leak) | Yes | Common |
| **OCSP Stapling** (RFC 6066 §8) | Server staples signed CA response in TLS handshake | No | Depends on Must-Staple | Widely deployed |
| **OCSP Must-Staple** (RFC 7633) | X.509 extension: browser hard-fails if no staple | No | No | Limited |
| **Short-lived certs** | Cert expires before next update needed | No | N/A | Emerging (Let's Encrypt 6-day) |
| **CRLite / CRL Sets** | Browser pre-fetches compressed revocation set | No | No | Chrome (CRL Sets), Firefox (CRLite) |

**OCSP stapling flow:**
```
1. Server periodically fetches signed OCSP response from CA responder
   Response: {certStatus: good, thisUpdate, nextUpdate} signed by CA OCSP key
2. During TLS handshake (Certificate message), server appends the cached OCSP response
3. Client verifies: (a) OCSP response signature valid for issuing CA,
                    (b) serial number matches cert, (c) not expired
4. No client→CA contact needed
```

**OCSP Must-Staple (RFC 7633):**
- X.509v3 extension OID `1.3.6.1.5.5.7.1.24` embedded in the leaf certificate
- Signals to compliant clients: "reject this connection if no valid OCSP staple is present"
- Changes soft-fail (ignore missing staple) to hard-fail
- Largely superseded in practice by short-lived certificate strategies

**Short-lived certificates:** Let's Encrypt announced 6-day certificates (2024) as an alternative to revocation checking — a compromised certificate expires before the revocation machinery matters. No OCSP check needed if the cert lifetime is shorter than the CRL/OCSP check window.

**Privacy problem with OCSP:** Each client→CA OCSP request reveals which websites the client visits; OCSP stapling eliminates this. Google Chrome removed OCSP checking entirely (2012), relying on CRL Sets instead.

**State of the art:** RFC 6960 (OCSP), RFC 6066 §8 (stapling in TLS), RFC 7633 (Must-Staple), RFC 6961 (multiple stapling). Supported by Apache (2.3.3+), nginx (1.3.7+), IIS (Windows Server 2008+). Short-lived certificates (6-day) are the forward direction for WebPKI revocation. See [DANE](#dane--dns-based-authentication-of-named-entities).

**Production readiness:** Production
OCSP stapling widely deployed in Apache, nginx, IIS; CRLite shipped in Firefox; Chrome uses CRL Sets; short-lived certificates emerging via Let's Encrypt.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, full OCSP client/responder and stapling support
- [mod_ssl (Apache)](https://github.com/apache/httpd) ⭐ 3.9k — C, OCSP stapling in Apache HTTP Server
- [nginx](https://github.com/nginx/nginx) ⭐ 29k — C, built-in OCSP stapling support
- [CRLite (Mozilla)](https://github.com/mozilla/crlite) ⭐ 150 — Rust/Python, compressed certificate revocation for Firefox
- [Boulder](https://github.com/letsencrypt/boulder) ⭐ 5.7k — Go, Let's Encrypt CA software with OCSP responder

**Security status:** Caution
OCSP stapling is cryptographically sound; plain OCSP has privacy concerns (CA sees client requests); soft-fail OCSP checking allows bypass; short-lived certificates eliminate revocation concerns entirely.

**Community acceptance:** Standard
IETF RFCs 6960, 6066, 7633; universally supported in TLS servers and browsers; industry trend toward short-lived certificates as replacement for traditional revocation.

---

## TPM 2.0 / Trusted Platform Module

**Goal:** Provide an isolated, tamper-resistant hardware security engine embedded in a platform (PC, server, phone) that: (1) measures software loaded during boot into sealed Platform Configuration Registers, (2) generates hardware-bound keys that cannot be exported, and (3) produces cryptographically signed attestation quotes proving the platform's measured boot state to remote verifiers.

**Key hierarchies (TCG TPM 2.0 specification, ISO/IEC 11889:2015):**

| Hierarchy | Seed | Purpose | Owner |
|-----------|------|---------|-------|
| **Endorsement (EH)** | Manufacturer-burned EPS seed | Platform identity; EK cert issued by OEM | Platform privacy admin |
| **Storage (SH)** | Owner-controlled SPS seed | General-purpose key storage; SRK root | Platform owner |
| **Platform (PH)** | Firmware-controlled PPS seed | Firmware-only keys | Firmware (not OS) |
| **Null** | Ephemeral per-boot | Session keys, ephemeral use | None |

**Key types:**
- **EK (Endorsement Key)** — RSA-2048 or ECC P-256; burned by manufacturer with EK certificate; used only to decrypt (not sign); proves TPM identity
- **AK (Attestation Key)** — derived from EH or SH; restricted signing key; used to sign quotes (PCR values); replaces legacy AIK from TPM 1.2
- **SRK (Storage Root Key)** — root of the storage hierarchy key tree; wraps user keys
- **User keys** — arbitrary asymmetric/symmetric keys; stored encrypted ("key blobs") under SRK or parent key; TPM2_Load re-imports them

**PCR (Platform Configuration Register) measurement:**
```
Boot sequence (UEFI Secure Boot path):
  PCR0:  UEFI firmware code
  PCR1:  UEFI firmware config
  PCR2:  UEFI option ROMs
  PCR4:  Boot loader code (e.g. GRUB)
  PCR7:  Secure Boot state (db/dbx/PK)
  PCR8-15: OS kernel, initrd, kernel command line (measured by bootloader)

Extension operation (all PCRs):
  PCR[i] := SHA256(PCR[i] || new_measurement)
```

**Attestation quote (TPM2_Quote):**
```
Input:  AK handle, nonce, PCR selection
Output: TPMS_ATTEST {
          magic, type, qualifiedSigner (AK name),
          extraData (nonce), clockInfo,
          attested: TPMS_QUOTE_INFO {
            pcrSelect, pcrDigest (hash of selected PCR values)
          }
        }
        Signature: ECDSA-P256 or RSASSA under AK
```

**Credential activation (MakeCredential / ActivateCredential):**
Used to prove an AK is co-resident with a known EK on the same TPM. A CA encrypts a secret under the EK public key, binds it to the AK name; the TPM decrypts only if AK and EK are on the same device. This is the enrollment protocol for remote attestation.

**Applications:**
- **BitLocker / dm-crypt:** Seals disk encryption key to TPM; released only if PCRs match (correct boot state)
- **Windows 11 requirement:** TPM 2.0 mandatory for Secure Boot + credential protection
- **Remote attestation:** Keylime, TPM2-TSS stack, Google Asylo, Microsoft Azure Attestation
- **FIDO2 authenticators:** Platform authenticators (Windows Hello, TouchID) use TPM 2.0 or Secure Enclave to protect resident passkey private keys

**State of the art:** TCG TPM Library 2.0 rev 01.59 (2019); ISO/IEC 11889:2015. Mandatory in Windows 11. tpm2-tools and tpm2-tss are the reference open-source stack. IETF RFC 9334 (RATS architecture) defines how TPM quotes fit into remote attestation. See [TEE Remote Attestation](#tee-remote-attestation).

**Production readiness:** Production
Mandatory in Windows 11; present in virtually all modern PCs, servers, and enterprise devices; used for BitLocker, Secure Boot, FIDO2 platform authenticators, and remote attestation.

**Implementations:**
- [tpm2-tss](https://github.com/tpm2-software/tpm2-tss) ⭐ 863 — C, TCG TPM2 Software Stack reference implementation
- [tpm2-tools](https://github.com/tpm2-software/tpm2-tools) ⭐ 844 — C, command-line TPM 2.0 utilities
- [go-tpm](https://github.com/google/go-tpm) ⭐ 646 — Go, Google TPM 2.0 client library
- [wolfTPM](https://github.com/wolfSSL/wolfTPM) ⭐ 311 — C, portable TPM 2.0 library for embedded systems
- [swtpm](https://github.com/stefanberger/swtpm) ⭐ 772 — C, software TPM 2.0 emulator for testing

**Security status:** Secure
Hardware-isolated key storage with tamper resistance; ECDSA P-256 and RSA-2048 attestation keys; credential activation protocol prevents AK forgery. Side-channel attacks on some discrete TPMs documented but impractical at scale.

**Community acceptance:** Standard
TCG TPM 2.0 specification; ISO/IEC 11889:2015; mandatory for Windows 11; IETF RFC 9334 (RATS); endorsed by NIST, Microsoft, Google.

---

## FIDO2 / WebAuthn / Passkeys

**Goal:** Replace passwords with hardware-bound public-key credentials — a private key generated and stored in a secure element or TPM never leaves the device, and authentication is a cryptographic challenge-response. The credential is scoped to a specific origin (website domain), making phishing structurally impossible.

**Component stack:**

| Layer | Standard | Role |
|-------|----------|------|
| **WebAuthn** | W3C Recommendation (Level 2, 2021) | Browser JS API; defines registration and authentication ceremonies; CBOR/COSE encoding |
| **CTAP2** | FIDO Alliance CTAP 2.1 (2021) | Client-to-Authenticator Protocol; USB HID / NFC / BLE transport between browser and roaming authenticator |
| **FIDO2** | Umbrella term | WebAuthn + CTAP2 together |
| **Passkey** | FIDO Alliance / Apple/Google/Microsoft 2022 | Synced FIDO2 credential stored in platform keychain (iCloud, Google Password Manager, Windows Hello) |

**Registration (credential creation) ceremony:**
```
1. RP server → browser: challenge (32 bytes random), rpId (domain), pubKeyCredParams
2. Browser → authenticator (CTAP2 or platform API):
     authenticatorMakeCredential(clientDataHash, rpId, user, pubKeyCredParams)
3. Authenticator:
     - Generates key pair (ECDSA P-256 by default)
     - Private key stored in secure element / TPM (never exported)
     - Produces attestedCredentialData:
         credentialId (random, 16-1023 bytes)
         credentialPublicKey (CBOR-encoded COSE key: {1:2, 3:-7, -1:1, -2:x, -3:y})
     - Signs authenticatorData || clientDataHash with attestation key
4. Browser → RP: attestationObject (CBOR) + clientDataJSON
5. RP stores: credentialId → (publicKey, signCount, userHandle)
```

**Authentication ceremony:**
```
1. RP → browser: challenge, rpId, allowCredentials list
2. Authenticator: user verifies (biometric / PIN)
3. Authenticator signs:  authenticatorData || SHA-256(clientDataJSON)
     authenticatorData includes: rpIdHash, UP+UV flags, signCount, extensions
     Signature: ECDSA-P256 (ES256, COSE alg -7) or Ed25519 / RS256
4. RP verifies: signature over (authData || clientDataHash) with stored public key
                checks: rpIdHash, origin binding, signCount (replay prevention)
```

**Key algorithms (COSE):**

| COSE alg | Value | Curve / Key | Notes |
|----------|-------|-------------|-------|
| ES256 | -7 | ECDSA P-256 | Default; required by spec |
| ES384 | -35 | ECDSA P-384 | Optional |
| EdDSA | -8 | Ed25519 | YubiKey 5.2+, passkeys |
| RS256 | -257 | RSA-2048 PKCS1 | Windows Hello legacy |
| RS1 | -65535 | RSA SHA-1 | Deprecated |

**Attestation formats:** Authenticators may prove their model to the RP.

| Format | Signer | Use case |
|--------|--------|---------|
| `packed` | Authenticator attestation key | Common roaming keys (YubiKey) |
| `tpm` | TPM AK | Windows Hello platform authenticator |
| `android-key` | Android Keystore key | Android platform authenticator |
| `apple` | Apple anonymous CA | Touch ID / Face ID |
| `none` | — | Passkeys (privacy: no device model disclosed) |

**Passkeys (synced credentials):** Extend FIDO2 by syncing the private key (encrypted) across a user's devices via the platform cloud keychain. Private key leaves the secure enclave in encrypted form for backup only; authentication still uses local hardware. Apple, Google, and Microsoft passkey ecosystems use different key sync architectures.

**Anti-phishing:** `rpIdHash = SHA-256(origin's effective domain)` is embedded in `authenticatorData` and signed. A fake site on `evil.bank.com` cannot produce a valid signature for `bank.com`'s rpId — origin binding is enforced in hardware.

**Deployment:** Google, Apple, Microsoft all support passkeys (2022–2023). GitHub, PayPal, Amazon, WhatsApp, 1Password, Dashlane deployed passkeys. FIDO Alliance reports >13 billion FIDO-enabled accounts (2024).

**State of the art:** W3C WebAuthn Level 2 (2021); CTAP 2.1 (2021); passkeys specification (FIDO Alliance, 2022). WebAuthn Level 3 draft (2024) adds hybrid transport, credential management. See [TOTP/FIDO2/WebAuthn](categories/12-secure-communication-protocols.md#totpfido2webauthn) and [TPM 2.0](#tpm-20--trusted-platform-module).

**Production readiness:** Production
>13 billion FIDO-enabled accounts (2024); passkeys deployed by Google, Apple, Microsoft, GitHub, PayPal, Amazon, WhatsApp; all major browsers and OSes support WebAuthn.

**Implementations:**
- [libfido2](https://github.com/Yubico/libfido2) ⭐ 697 — C, Yubico FIDO2 client library (USB/NFC/BLE)
- [py_webauthn](https://github.com/duo-labs/py_webauthn) ⭐ 1.0k — Python, WebAuthn server-side library
- [java-webauthn-server](https://github.com/Yubico/java-webauthn-server) ⭐ 544 — Java, Yubico WebAuthn server library
- [SimpleWebAuthn](https://github.com/MasterKale/SimpleWebAuthn) ⭐ 2.2k — TypeScript, WebAuthn server + browser library
- [webauthn-rs](https://github.com/kanidm/webauthn-rs) ⭐ 642 — Rust, WebAuthn server implementation

**Security status:** Secure
Phishing-resistant by design (origin binding via rpIdHash signed by hardware); private keys never leave secure element/TPM; synced passkeys introduce cloud backup risk but remain strong against credential theft.

**Community acceptance:** Standard
W3C Recommendation (WebAuthn Level 2); FIDO Alliance CTAP 2.1; supported by Apple, Google, Microsoft; endorsed by NIST and CISA as phishing-resistant MFA.

---

## PKCS#11 / Cryptoki — HSM C API

**Goal:** Provide a vendor-neutral C API (called "Cryptoki") for applications to perform cryptographic operations and manage key material inside a Hardware Security Module (HSM), smart card, or other cryptographic token — without any key material ever leaving the secure boundary of the device.

Originally published by RSA Security (PKCS #11 v2.20, 2004), now maintained by OASIS; currently at version 3.1 (2023).

**Object model:**

| Object class | Examples | Attribute flags |
|---|---|---|
| **Secret key** | AES-256, 3DES, HMAC | `CKA_SENSITIVE`, `CKA_EXTRACTABLE`, `CKA_TOKEN` |
| **Private key** | RSA, ECDSA, Ed25519 | `CKA_SENSITIVE=TRUE`, `CKA_EXTRACTABLE=FALSE` |
| **Public key** | RSA pub, EC pub | Exportable by default |
| **Certificate** | X.509 DER | Stored for lookup |
| **Data** | Arbitrary blobs | Application-defined |

Setting `CKA_SENSITIVE=TRUE` and `CKA_EXTRACTABLE=FALSE` prevents a key from ever leaving the token in plaintext — the fundamental HSM guarantee.

**Session model:**
```
C_OpenSession(slot, CKF_SERIAL_SESSION, ...) → session handle
C_Login(session, CKU_USER, pin, pinLen)
  // perform operations within session
C_Sign(session, &mechanism, key, data, dataLen, sig, &sigLen)
C_CloseSession(session)
```

**Mechanisms (selected):**

| Mechanism | CKM constant | Operation |
|---|---|---|
| RSA PKCS#1 v1.5 | `CKM_RSA_PKCS` | Sign / decrypt |
| RSA-OAEP | `CKM_RSA_PKCS_OAEP` | Encrypt / wrap |
| ECDSA | `CKM_ECDSA` | Sign |
| ECDH derive | `CKM_ECDH1_DERIVE` | Key agreement |
| AES-GCM | `CKM_AES_GCM` | Encrypt |
| AES key wrap | `CKM_AES_KEY_WRAP` | Wrap another key |
| HMAC-SHA256 | `CKM_SHA256_HMAC` | MAC |

**Key wrapping (inter-HSM key transfer):**
```
C_WrapKey(session, &wrapMech, wrappingKey, targetKey, wrappedKeyBuf, &wrappedLen)
// wrappedKeyBuf: encrypted blob; targetKey never leaves HSM in plaintext
C_UnwrapKey(session, &wrapMech, wrappingKey, wrappedKeyBuf, ...)
```
This is how keys migrate between HSMs — always in encrypted form, never as plaintext.

**PKCS#11 v3.x additions (over v2.40):**
- Message-based API: incremental `C_MessageEncryptInit` / `C_EncryptMessage` for streaming GCM
- EdDSA (Ed25519, Ed448) mechanisms
- Extended TLS 1.3 PRF / HKDF mechanisms
- Improved provider/profile model to describe token capability subsets

**Major HSM vendors and their PKCS#11 libraries:**

| Vendor | Product | Library |
|---|---|---|
| Thales (Gemalto) | Luna Network HSM | `libCryptoki2_64.so` |
| Thales | nShield Connect/Solo | `libcknfast.so` |
| Entrust | nShield (post-acquisition) | `libcknfast.so` |
| AWS | CloudHSM | `libcloudhsm_pkcs11.so` |
| Utimaco | SecurityServer | `libcs_pkcs11_R3.so` |
| SoftHSMv2 | Software emulation | `libsofthsm2.so` |

**Common consumers:** OpenSSL (via engine/provider), Java (PKCS#11 JCE provider), NSS (Firefox/Chrome TLS), NGINX (hardware offload), HashiCorp Vault (PKCS#11 seal), Kubernetes (KMS plugin), code signing pipelines.

**State of the art:** OASIS PKCS #11 Specification v3.1 (July 2023) [[1]](https://docs.oasis-open.org/pkcs11/pkcs11-spec/v3.1/os/pkcs11-spec-v3.1-os.html); v3.2 draft in progress. Widely used as the integration layer between PKI software and physical HSMs. See [HSM Key Ceremony](#hsm-key-ceremony--split-knowledge--dual-control) and [TUF / The Update Framework](#tuf--the-update-framework).

**Production readiness:** Production
Universal HSM integration standard; used by OpenSSL, Java JCE, NSS (Firefox/Chrome), NGINX, HashiCorp Vault, and all major HSM vendors.

**Implementations:**
- [SoftHSMv2](https://github.com/opendnssec/SoftHSMv2) ⭐ 993 — C++, software-only PKCS#11 HSM for development/testing
- [OpenSC](https://github.com/OpenSC/OpenSC) ⭐ 3.0k — C, PKCS#11 middleware for smart cards and tokens
- [p11-kit](https://github.com/p11-glue/p11-kit) ⭐ 184 — C, PKCS#11 module management and trust policy framework
- [pkcs11-provider (OpenSSL 3.x)](https://github.com/latchset/pkcs11-provider) ⭐ 115 — C, OpenSSL 3.x provider for PKCS#11 tokens
- [Yubico PIV tool](https://github.com/Yubico/yubico-piv-tool) ⭐ 344 — C, PKCS#11 module for YubiKey PIV

**Security status:** Secure
API design enforces non-exportable key semantics (CKA_SENSITIVE + CKA_EXTRACTABLE=FALSE); security depends on the underlying HSM hardware achieving FIPS 140-3 certification.

**Community acceptance:** Standard
OASIS PKCS #11 v3.1 (2023); originally RSA Security standard; universal adoption across all HSM vendors, cloud KMS, and PKI software.

---

## HSM Key Ceremony / Split Knowledge / Dual Control

**Goal:** Ensure that no single person ever has sole access to a high-value cryptographic key — in particular an HSM master key, a CA root key, or a DNSSEC KSK. The key ceremony is a formal, witnessed procedure that uses _split knowledge_ (Shamir/XOR shares across multiple custodians) and _dual control_ (two persons required for each sensitive operation) to provide both confidentiality and integrity guarantees rooted in human-enforced access policy.

**Definitions:**

| Concept | Meaning | FIPS 140 reference |
|---|---|---|
| **Split knowledge** | A secret is divided into _k_ shares such that any single share reveals nothing; only a threshold of _m-of-k_ shares reconstruct the secret | SP 800-57 Part 1, §8.2.2 |
| **Dual control** | Two authorized persons must be simultaneously present and acting to perform a sensitive operation; neither can act alone | FIPS 140-3 §TE.07.09 |
| **Key custodian** | An individual entrusted with one share (e.g., on a smart card or paper) | — |
| **Crypto officer (CO)** | Role authorized to operate the HSM; logs every action | FIPS 140-3 §4.4 |

**Key ceremony lifecycle:**

```
1. Preparation
   - Conduct in a physically secured room; video recorded; witnesses sign script
   - All participants' identities verified against pre-issued credentials
   - Brand-new HSM brought in sealed packaging; serial number verified

2. HSM initialization
   - HSM factory reset; firmware version logged
   - Generate or load master key (MK) using m-of-k smart cards (e.g., 3-of-5)
   - Each card holder sees only their own share; never the full key

3. Root / CA key generation
   - HSM generates key pair; private key never leaves HSM
   - Public key exported and recorded in ceremony log
   - Key wrapped under MK; backup written to N smartcards or HSM clones

4. Key signing (for DNSSEC KSK or CA root cert)
   - Signing performed inside HSM via PKCS#11 or vendor API
   - m-of-k COs present simultaneously to authorize the operation

5. Close and seal
   - HSM returned to secure facility
   - Smart cards distributed to geographically separated custodians
   - Full ceremony log signed by all participants; hash published
```

**Real-world example — ICANN DNS Root KSK ceremony:**
- Held quarterly at two geographically separate KMFs (Los Angeles and Culpeper, VA)
- 7 Crypto Officers per facility; any 3 can operate the HSM (3-of-7 threshold)
- 7 Recovery Key Share Holders (RKSHs) hold shares of the emergency storage key; 5-of-7 required for disaster recovery
- Ceremony is live-streamed and fully auditable [[1]](https://www.iana.org/dnssec/ceremonies)

**Cryptographic underpinning of share distribution:**
- **Shamir's Secret Sharing (SSS):** Secret is the constant term of a random polynomial of degree _m−1_ over GF(p); each custodian receives one point on the polynomial. Any _m_ points reconstruct the polynomial via Lagrange interpolation; fewer than _m_ reveal nothing. See [Secret Sharing](#shamir-secret-sharing-sss).
- **XOR split (2-of-2):** simpler but only works for exactly 2 parties; share₁ = random, share₂ = secret XOR share₁.
- **Smart card–based schemes:** Each smart card is a PKCS#11 token holding one share as a non-exportable key.

**FIPS 140-3 requirements:** Level 3+ HSMs must enforce dual control for critical security parameters (CSPs); roles and services must be documented; all operations logged to tamper-evident audit log.

**State of the art:** NIST SP 800-57 Part 1 Rev. 5 (2020) [[1]](https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-5/final) defines key management lifecycle including split knowledge. FIPS 140-3 (2019, ISO/IEC 19790) governs HSM security levels. See [PKCS#11 / Cryptoki](#pkcs11--cryptoki--hsm-c-api), [DNSSEC](#dnssec--dns-security-extensions), and [Secret Sharing](categories/05-secret-sharing-threshold-cryptography.md#shamir-secret-sharing-sss).

**Production readiness:** Production
Standard operational procedure for all root CA ceremonies (ICANN DNS Root KSK, WebPKI root CAs), DNSSEC key ceremonies, and enterprise HSM deployments.

**Implementations:**
- [ICANN KSK Ceremony scripts](https://github.com/iana-org/dnssec-keytools) ⭐ 4 — Python/Shell, ICANN DNS root KSK ceremony tools
- [OpenDNSSEC](https://github.com/opendnssec/opendnssec) ⭐ 118 — C, automated DNSSEC key management with HSM support
- [HashiCorp Vault](https://github.com/hashicorp/vault) ⭐ 35k — Go, secrets management with Shamir unseal and HSM auto-unseal
- [SoftHSMv2](https://github.com/opendnssec/SoftHSMv2) ⭐ 993 — C++, software HSM for ceremony testing

**Security status:** Secure
Based on well-established Shamir Secret Sharing and physically witnessed procedures; FIPS 140-3 Level 3+ HSMs enforce dual control; auditable and tamper-evident.

**Community acceptance:** Standard
NIST SP 800-57; FIPS 140-3 (ISO/IEC 19790); mandatory for WebPKI root CAs, DNSSEC root KSK, and regulated industries (finance, government).

---

## DICE — Device Identifier Composition Engine

**Goal:** Provide IoT and embedded devices — where a TPM is infeasible — with a hardware root of trust that generates a cryptographically unique per-device, per-firmware identity at every boot, without requiring a factory-provisioned secret per device. Each firmware layer receives a Compound Device Identifier (CDI) that binds the device's unique secret to the _exact measurement_ of the next layer, enabling remote attestation and a PKI-like certificate chain from bare metal through application firmware.

Originally proposed by Microsoft Research (RIoT, 2016); standardized by TCG as the DICE Architecture; referenced in IETF RFC 9360 (CBOR/COSE certificate transport).

**Boot-time key derivation:**

```
UDS  (Unique Device Secret — fused into hardware, never readable by software)
  │
  ▼  CDI_0 = KDF(UDS, H(Layer_0_code || Layer_0_config))
Layer 0 (immutable ROM boot code)
  │
  ▼  CDI_1 = KDF(CDI_0, H(Layer_1_code || Layer_1_config))
Layer 1 (first-stage bootloader / UEFI)
  │
  ▼  CDI_n = KDF(CDI_{n-1}, H(Layer_n_code || config))
Application firmware
```

KDF is typically HMAC-SHA256 or HKDF. Each CDI is derived from the parent CDI and the SHA-256 measurement of the next layer's code; it is only accessible inside that layer.

**Alias Key and certificate chain:**

Each DICE layer generates an _Alias Key Pair_ derived from its CDI:
```
AliasSeed  = KDF(CDI, "Alias key")
AliasPriv  = deterministic ECDSA P-256 key from AliasSeed (RFC 6979)
AliasCert  = X.509 cert, issued by previous layer's Alias Key,
             SubjectAltName carries the CDI hash (layer measurement)
```
This produces a certificate chain: Root CA → Layer0 cert → Layer1 cert → Application cert. The chain proves the exact firmware stack running on the device to any remote verifier.

**TCG DICE layers:**

| Layer | Name | Contents signed into next CDI |
|---|---|---|
| L0 | Hardware DICE | UDS (never exported), fused in silicon |
| L1 | ROM / immutable code | Hash of L1 bootloader |
| L2 | Mutable bootloader | Hash of OS / firmware image |
| L3+ | OS / application | Hash of application binary + config |

**Open DICE (Google/Pigweed):** Google's open-source implementation of the DICE specification; used in Android (android.googlesource.com/open-dice), ChromeOS, Zephyr RTOS, and Tock OS. Provides CBOR-encoded CDI certificates for constrained devices.

**DICE in Android:** Android 13+ uses DICE for the Remote Key Provisioning (RKP) stack — device attestation certificates are DICE-chained from hardware all the way to the application key, enabling provable firmware-bound attestation without factory per-device key provisioning.

**Security properties:**
- Changing any firmware layer produces a different CDI/Alias Key → stale or modified firmware cannot impersonate the expected identity
- UDS never exposed to software → no firmware exploit can exfiltrate the root secret
- Works on microcontrollers with as little as 2 kB of ROM

**State of the art:** TCG DICE Architecture v1.0 (2020) [[1]](https://trustedcomputinggroup.org/wp-content/uploads/Device-Identifier-Composition-Engine-Rev69_Public-Review.pdf); TCG Hardware Requirements for DICE v1.0 rev. 0.91 (2024). Open DICE specification [[2]](https://pigweed.googlesource.com/open-dice/+/HEAD/docs/specification.md). Deployed in Android 13+, ChromeOS, Zephyr, Tock. See [TEE Remote Attestation](#tee-remote-attestation) and [TPM 2.0](#tpm-20--trusted-platform-module).

**Production readiness:** Production
Deployed in Android 13+ (Remote Key Provisioning), ChromeOS, Zephyr RTOS, and Tock OS; used by Google for hardware attestation at scale.

**Implementations:**
- [Open DICE (Google/Pigweed)](https://pigweed.googlesource.com/open-dice/) — C, Google's open-source DICE implementation
- [Android Open DICE](https://android.googlesource.com/platform/external/open-dice/) — C, DICE in Android platform
- [Tock DICE](https://github.com/tock/tock) ⭐ 6.3k — Rust, DICE support in Tock embedded OS
- [Zephyr RTOS DICE](https://github.com/zephyrproject-rtos/zephyr) ⭐ 14k — C, DICE integration in Zephyr

**Security status:** Secure
UDS never exposed to software; any firmware change produces a different CDI; works on microcontrollers with as little as 2 kB ROM. Security analysis by Microsoft Research and TCG.

**Community acceptance:** Widely trusted
TCG DICE Architecture v1.0; IETF RFC 9360; adopted by Google (Android, ChromeOS), Microsoft, and major embedded platforms; complementary to TPM for constrained devices.

---

## GSMA eSIM / Remote SIM Provisioning (RSP)

**Goal:** Enable cellular network profiles (IMSI, Ki, operator keys) to be downloaded, installed, and switched over-the-air onto an embedded Universal Integrated Circuit Card (eUICC / eSIM) soldered into a device — without physical SIM card swapping — using a mutually authenticated, end-to-end encrypted channel from the operator's servers to the tamper-resistant eUICC secure element.

**Specification family:**

| Spec | Scope | Latest version |
|---|---|---|
| **SGP.21** | RSP Architecture (M2M) | v4.2 |
| **SGP.22** | RSP Technical Specification — Consumer devices | v3.1 (Dec 2023) |
| **SGP.02** | M2M RSP (industrial/automotive) | v4.2 |
| **SGP.32** | RSP for IoT (headless devices, no LPA UI) | v1.0 (2023) |

**PKI and trust anchor hierarchy:**

```
GSMA Root CI (Certificate Issuer)
  ├── Operator Sub-CI
  │     └── SM-DP+ certificate (ECDSA P-256 / brainpoolP256r1)
  └── eUICC Manufacturer Sub-CI
        └── eUICC CI certificate (per device; burned at manufacture)
```

The GSMA operates a GSMA Certificate Issuer (CI) and issues Sub-CI certificates to SM-DP+ operators and eUICC manufacturers. Trust is rooted in the GSMA CI public key, which is pre-loaded into every eUICC at manufacture.

**Cryptographic profile download flow (SGP.22):**

```
1. Common Mutual Authentication (CMA)
   LPA (device) ←→ SM-DP+: ECDH key agreement (prime256v1 or brainpoolP256r1)
   Both sides present X.509 certs; mutual TLS-like auth over HTTP/S
   Session keys derived: K_S_enc, K_S_mac, K_S_mac_r via HKDF-SHA-256

2. Profile Package download
   SM-DP+ encrypts Profile Package using SCP03t (AES-128-CBC + CMAC):
     - Command data encrypted with K_S_enc (AES-128-CBC)
     - Integrity protected with K_S_mac (AES-128 CMAC)
   Profile Package TLV-encoded, ASN.1 structure per SGP.22 §3.1

3. Profile installation (inside eUICC secure element)
   eUICC decrypts and installs profile into isolated slot
   Profile binding key KB derived: KB = HMAC-SHA256(ISD-P key, profile_binding_data)
   Profile contains: IMSI, Ki (AKA root key), OPc, transport keys

4. Profile activation
   LPA sends ES10b.EnableProfile; eUICC authenticates command via CMAC
```

**Key cryptographic mechanisms:**

| Operation | Algorithm |
|---|---|
| Mutual authentication | ECDSA P-256 / brainpoolP256r1 on X.509 certs |
| Session key agreement | ECKA-DH (ECDH with cofactor) → HKDF-SHA-256 |
| Profile encryption | SCP03t: AES-128-CBC + CMAC (NIST SP 800-38B) |
| Profile binding | HMAC-SHA-256 keyed to ISD-P |
| eUICC attestation | eUICC signs EID + nonce with eUICC private key |
| Certificate chain | GSMA CI → Sub-CI → device/server cert |

**eUICC (embedded UICC) hardware:**
- Separate secure element chip (or iSIM integrated into SoC) meeting ETSI TS 102 221 (UICC spec)
- Common Criteria EAL4+ or higher certification required
- Stores multiple profiles in isolated ISD-P (Issuer Security Domain Profile) containers
- EID (eUICC Identifier): 32-digit globally unique identity burned in at manufacture

**iSIM:** An integrated SIM where the eUICC secure element is merged into the application SoC die (e.g., Qualcomm 5G modems, Apple M-series chips). Functionally identical to eUICC for RSP; smaller, lower power. Used in Apple Watch (Series 3+), iPhone (Series 14+, US models).

**Deployment:** All modern flagship smartphones (2022+) support eSIM. Over 2.5 billion eSIM-capable devices shipped by 2024 (GSMA). Apple removed physical SIM entirely in US iPhone 14 (2022). SGP.32 (IoT) deployed in connected cars, smart meters, industrial M2M.

**State of the art:** GSMA SGP.22 v3.1 (2023) [[1]](https://www.gsma.com/solutions-and-impact/technologies/esim/gsma_resources/sgp-22-v3-1/); SGP.32 v1.0 (2023) for IoT [[2]](https://www.gsma.com/solutions-and-impact/technologies/esim/esim-specification/). Post-quantum secure channel research active [[3]](https://eprint.iacr.org/2024/2005.pdf). See [EMV Cryptographic Authentication](#emv-cryptographic-authentication) and [TEE Remote Attestation](#tee-remote-attestation).

**Production readiness:** Production
Over 2.5 billion eSIM-capable devices shipped by 2024; Apple removed physical SIM in US iPhone 14; deployed in smartphones, connected cars, smart meters, and industrial M2M.

**Implementations:**
- [lpac](https://github.com/estkme-group/lpac) ⭐ 599 — C, open-source local profile assistant for eSIM management
- [OpenEUICC](https://gitea.angry.im/PeterCxy/OpenEUICC) — Kotlin, open-source eSIM management app for Android
- [GlobalPlatformPro](https://github.com/martinpaljak/GlobalPlatformPro) ⭐ 873 — Java, smart card management with SCP03 support
- [pySIM](https://github.com/osmocom/pysim) ⭐ 514 — Python, SIM/USIM/ISIM card provisioning tool

**Security status:** Secure
ECDSA P-256/brainpoolP256r1 mutual authentication; SCP03t (AES-128-CBC + CMAC) profile encryption; Common Criteria EAL4+ certified eUICC hardware. Post-quantum migration research active.

**Community acceptance:** Standard
GSMA SGP.21/SGP.22/SGP.32 specifications; mandatory for all major mobile operators; adopted by Apple, Samsung, Google, and automotive OEMs.

---

## PKCS#7 / CMS — Cryptographic Message Syntax

**Goal:** Provide a general-purpose, ASN.1-encoded container format for cryptographically protected messages — supporting digital signatures, encryption, and authenticated envelopes over arbitrary content. CMS is the foundation of S/MIME, code signing (Authenticode), PKCS#12 key stores, RPKI signed objects, and many PKI protocols.

Originally PKCS#7 (RSA Security, 1993); superseded and extended by CMS (RFC 5652, 2009) as an IETF standard.

**Top-level content types:**

| CMS ContentType OID | Purpose | Typical use |
|---|---|---|
| `id-data` (1.2.840.113549.1.7.1) | Raw octet string | Plaintext payload |
| `id-signedData` (1.2.840.113549.1.7.2) | One or more signatures over content | S/MIME signed mail, code signing, RPKI |
| `id-envelopedData` (1.2.840.113549.1.7.3) | Encrypted for one or more recipients | S/MIME encrypted mail |
| `id-digestedData` (1.2.840.113549.1.7.5) | Content + digest only (no signature) | Integrity without authentication |
| `id-encryptedData` (1.2.840.113549.1.7.6) | Symmetrically encrypted; key managed externally | Password-protected archives |
| `id-authEnvelopedData` (RFC 5083) | AEAD encryption (AES-GCM, AES-CCM) | Authenticated encryption for messages |

**SignedData structure (most common):**
```
SignedData ::= SEQUENCE {
  version          CMSVersion,
  digestAlgorithms DigestAlgorithmIdentifiers,   -- e.g., SHA-256
  encapContentInfo EncapsulatedContentInfo,       -- the signed content (or detached)
  certificates     [0] IMPLICIT CertificateSet OPTIONAL,
  crls             [1] IMPLICIT RevocationInfoChoices OPTIONAL,
  signerInfos      SET OF SignerInfo
}

SignerInfo ::= SEQUENCE {
  version            CMSVersion,
  sid                SignerIdentifier,     -- issuerAndSerialNumber or subjectKeyIdentifier
  digestAlgorithm    AlgorithmIdentifier, -- SHA-256
  signedAttrs        [0] IMPLICIT Attributes OPTIONAL,
  signatureAlgorithm AlgorithmIdentifier, -- e.g., id-RSASSA-PSS or ecdsa-with-SHA256
  signature          OCTET STRING,
  unsignedAttrs      [1] IMPLICIT Attributes OPTIONAL
}
```

**Signed attributes (authenticated metadata in SignerInfo):**

| Attribute OID | Content | Required |
|---|---|---|
| `id-contentType` | OID of the encapsulated content | Yes |
| `id-signingTime` | UTCTime / GeneralizedTime of signing | Common |
| `id-messageDigest` | SHA-256 of the encapsulated content | Yes |
| `id-countersignature` | Unsigned: timestamping co-signer | Optional |
| `id-aa-signingCertificateV2` (RFC 5035) | Hash of the signing certificate; prevents cert substitution attacks | Recommended |

**EnvelopedData (encryption to recipients):**
```
EnvelopedData ::= SEQUENCE {
  version          CMSVersion,
  recipientInfos   RecipientInfos,    -- one entry per recipient; each contains encrypted CEK
  encryptedContent EncryptedContentInfo
}
-- CEK (Content Encryption Key) encrypted per recipient via:
--   KeyTransRecipientInfo: RSA-OAEP wraps CEK (for RSA recipients)
--   KeyAgreeRecipientInfo: ECDH + AES-KeyWrap (for EC recipients)
--   KEKRecipientInfo: pre-shared symmetric KEK wraps CEK
```

**Content encryption algorithms (RFC 3565, RFC 5084):**
- AES-128/192/256-CBC (legacy) — `id-aes256-CBC`
- AES-128/256-GCM (RFC 5084) — `id-aes256-GCM`; provides authenticated encryption; preferred in modern CMS

**CMS and PKCS#12:** PKCS#12 (PFX) files — the `.p12`/`.pfx` format used to export private key + cert chain — use nested CMS `EncryptedData` and `SafeBag` structures internally.

**State of the art:** RFC 5652 (CMS, 2009); RFC 5083 (AuthEnvelopedData with AEAD); RFC 8933 (2020, updates CMS for SHA-3 and modern algorithms). Implemented in OpenSSL (`openssl cms`), Bouncy Castle, and Microsoft's `System.Security.Cryptography.Pkcs`. Foundation for [S/MIME](#smime--securemultipurpose-internet-mail-extensions), [Code Signing](#code-signing--authenticode-apple-notarization-android-signing), and [RPKI](#rpki--resource-public-key-infrastructure).

**Production readiness:** Production
Foundation of S/MIME, Authenticode, RPKI, PKCS#12; implemented in OpenSSL, Bouncy Castle, Microsoft CryptoAPI, and virtually all PKI software.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, `openssl cms` command and libcrypto CMS API
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive CMS/PKCS#7 implementation
- [pyca/cryptography](https://github.com/pyca/cryptography) ⭐ 7.5k — Python, CMS parsing and generation
- [cms (Go)](https://github.com/github/smimesign) ⭐ 646 — Go, GitHub S/MIME signing tool using CMS

**Security status:** Secure
Modern CMS uses AES-GCM (RFC 5084) for authenticated encryption and SHA-256+ digests; legacy CBC modes remain available but superseded. RSA-OAEP and ECDH key transport are well-studied.

**Community acceptance:** Standard
IETF RFC 5652; foundation for multiple IETF standards (S/MIME, RPKI, CMP, EST); universal PKI building block.

---

## S/MIME — Secure/Multipurpose Internet Mail Extensions

**Goal:** Apply CMS-based digital signatures and encryption to MIME-formatted email, enabling end-to-end authentication of sender identity and confidentiality of message content — using each party's X.509 certificate as the basis of trust.

**S/MIME versions and RFCs:**

| Version | RFC | Year | Notes |
|---|---|---|---|
| S/MIME v2 | RFC 2311–2315 | 1998 | RC2/RC5; deprecated |
| **S/MIME v3.2** | RFC 5751 | 2010 | RSA + AES; current baseline |
| **S/MIME v4.0** | RFC 8551 | 2019 | AES-GCM AuthEnvelopedData; EdDSA; deprecates weak algs |

**Message types (MIME content types):**

| Operation | MIME type | CMS type inside |
|---|---|---|
| Signed (opaque) | `application/pkcs7-mime; smime-type=signed-data` | `SignedData` |
| Signed (clear-sign) | `multipart/signed; protocol="application/pkcs7-signature"` | Detached `SignedData` |
| Encrypted | `application/pkcs7-mime; smime-type=enveloped-data` | `EnvelopedData` |
| Signed + Encrypted | Nested: sign first, then encrypt | `EnvelopedData` wrapping `SignedData` |
| Cert-only | `application/pkcs7-mime; smime-type=certs-only` | Degenerate `SignedData` |

**Signing flow (clear-sign multipart):**
```
From: alice@example.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
              micalg="sha-256"; boundary="boundary"

--boundary
Content-Type: text/plain
Hello, Bob.

--boundary
Content-Type: application/pkcs7-signature
<DER-encoded detached SignedData: SignerInfo with Alice's cert + ECDSA sig over message>
--boundary--
```
- Clear-signed messages remain readable in non-S/MIME clients
- Opaque signed messages wrap the body inside the CMS object (not human-readable without S/MIME support)

**Encryption flow:**
1. Sender fetches recipient's X.509 certificate (from LDAP, SMIMEA DNS record, or prior signed email)
2. Generates random CEK (AES-256)
3. Encrypts CEK with recipient's RSA-OAEP or ECDH public key → `KeyTransRecipientInfo`
4. Encrypts message body with CEK under AES-256-GCM (S/MIME v4) or AES-256-CBC (v3.2)
5. Sends `EnvelopedData` MIME part; only the recipient's private key can decrypt

**Certificate trust in S/MIME:**
- Certificates issued by commercial CAs (DigiCert, Sectigo, GlobalSign) under the S/MIME Baseline Requirements (CA/B Forum, adopted 2022)
- S/MIME BR defines four certificate profiles: Mailbox-Validated, Organization-Validated, Sponsor-Validated, Individual-Validated
- CA/B Forum mandates S/MIME certificates be logged to Certificate Transparency logs (2024 requirement)

**Key discovery via SMIMEA (RFC 8162):** Publishing `_smimecert._tcp.user.example.com` TLSA-like records in DNSSEC-signed DNS allows senders to automatically discover a recipient's certificate. Eliminates manual cert exchange.

**Deployment:** Outlook (Windows/Mac), Apple Mail, Thunderbird (with add-ons), iOS Mail all support S/MIME. Enterprise deployments via Microsoft Exchange / Purview (formerly IRM), Symantec/Broadcom Email Security. Declining in consumer use relative to Signal/WhatsApp; dominant in regulated industries (healthcare, finance, government) where non-repudiation and legal admissibility matter.

**Comparison to PGP/OpenPGP:** S/MIME uses X.509 certificates with CA-based trust; OpenPGP uses a web-of-trust model with self-signed keys. S/MIME is better for enterprise (centralized CA); OpenPGP is better for decentralized trust. Both are end-to-end encrypted.

**State of the art:** RFC 8551 (S/MIME v4.0, 2019); CA/B Forum S/MIME Baseline Requirements v1.0 (2022). AES-256-GCM and EdDSA are the recommended algorithms in v4.0. See [PKCS#7 / CMS](#pkcs7--cms--cryptographic-message-syntax), [DNSSEC-Based Key Infrastructure](#dnssec-based-key-infrastructure-sshfp-tlsa-smimea), and [Certificate Transparency](#certificate-transparency-ct).

**Production readiness:** Production
Supported by Outlook, Apple Mail, Thunderbird, iOS Mail; deployed in enterprise environments (healthcare, finance, government) for legally admissible signed email.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, S/MIME signing and encryption via `openssl smime`/`openssl cms`
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, full S/MIME support
- [python-gnupg](https://github.com/vsajip/python-gnupg) ⭐ 144 — Python, GPG/S/MIME email operations
- [smimesign](https://github.com/github/smimesign) ⭐ 646 — Go, GitHub S/MIME signing tool for Git commits

**Security status:** Secure
S/MIME v4.0 mandates AES-256-GCM and modern digests; cryptographically sound with proper certificate management. Key distribution remains a challenge (requires prior certificate exchange or SMIMEA/LDAP lookup).

**Community acceptance:** Standard
IETF RFC 8551; CA/B Forum S/MIME Baseline Requirements (2022); dominant in regulated industries; declining in consumer use relative to end-to-end encrypted messengers.

---

## Code Signing — Authenticode, Apple Notarization, Android Signing

**Goal:** Cryptographically bind an executable, installer, or app package to its publisher's identity — so that an operating system, app store, or end user can verify that the software was produced by a known entity and has not been modified since signing. Prevents supply-chain tampering and enables OS-level execution policy (e.g., only run signed code).

**Platform comparison:**

| Platform | Scheme | Certificate source | OS enforcement |
|---|---|---|---|
| **Windows (Authenticode)** | CMS/PKCS#7 SignedData over PE hash | EV Code Signing cert from CA/B Forum CA | SmartScreen, Driver signing (WHQL), WDAC |
| **macOS (Apple code signing)** | Apple-internal CMS; Mach-O signature embedded | Apple Developer ID certificate (Apple CA) | Gatekeeper, SIP; mandatory for distribution |
| **macOS notarization** | Additional Apple online approval after signing | Same Developer ID cert | Gatekeeper ticket stapled to bundle |
| **iOS / iPadOS** | Apple-internal; embedded in IPA | Apple distribution certificate | App Store mandatory; sideload restricted |
| **Android (APK signing)** | JAR signing (v1), APKv2, APKv3, APKv4 | Self-signed developer key (no CA) | Play Protect; install-time verification |
| **Linux (Secure Boot)** | PE/COFF with PKCS#7 sig (shim/UEFI db) | Distribution key or OEM key | UEFI db allowlist |
| **NuGet / npm / PyPI** | Sigstore keyless signing (OIDC + cosign) | Ephemeral cert from Fulcio | Package manager verification |

**Windows Authenticode (PE signing):**
```
1. Compute Authenticode hash:
   - Parse PE headers; skip the checksum field, security directory, and certificate table
   - Hash remaining PE content with SHA-256
2. Build PKCS#7 SpcIndirectDataContent:
   SpcIndirectDataContent ::= SEQUENCE {
     data     SpcAttributeTypeAndOptionalValue,  -- PE image digest
     messageDigest DigestInfo                    -- SHA-256 of the above
   }
3. Wrap in CMS SignedData; include publisher's EV Code Signing cert + chain
4. Embed resulting DER blob in PE Security Directory (offset 0x98 in optional header)
```

**Dual signatures (SHA-1 + SHA-256):** Windows supports co-signatures — a single PE file can carry both a SHA-1 signature (for legacy Windows XP/Vista) and a SHA-256 signature (for Windows 7+) simultaneously using the `2.16.840.1.114421.1.7.23.2` (`szOID_NESTED_SIGNATURE`) unsigned attribute.

**Timestamping (RFC 3161):** Code signing certs expire; a countersignature from a TSA (Timestamp Authority) embeds a signed timestamp in the CMS `unsignedAttrs`. The OS accepts signatures where `timestamp.signingTime < cert.notAfter` even after the signing cert expires. Symantec, DigiCert, Sectigo all operate TSAs.

**macOS Notarization flow (2023):**
```
1. Developer signs app with Developer ID Application cert (hardened runtime required)
2. xcrun notarytool submit app.zip --apple-id ... --password ...
   -> Uploads to Apple notarization service (online)
3. Apple scans for malware; checks entitlements; verifies code signature
4. Apple issues notarization ticket (signed staple)
5. xcrun stapler staple app.app
   -> Ticket embedded in app bundle; Gatekeeper verifies offline
```
Without notarization, macOS Gatekeeper blocks unsigned apps with "cannot be opened" dialogs.

**Android APK signing scheme evolution:**

| Version | Introduced | Scope | Key feature |
|---|---|---|---|
| **v1 (JAR signing)** | Android 1.0 | Per-file ZIP entries | Based on PKCS#7; slow; ZIP alignment issues |
| **v2** | Android 7.0 (API 24) | Entire APK bytes | Covers APK as a whole; faster verification |
| **v3** | Android 9.0 (API 28) | APK + key rotation | Adds signing certificate lineage for key rotation |
| **v3.1** | Android 13 (API 33) | v3 + SDK targeting | Per-SDK platform version signing |
| **v4** | Android 11 (API 30) | Incremental FS | fs-verity-based; streaming verification |

Android signing uses developer-held self-signed certs (no CA); the same certificate must sign all updates to an app. Play App Signing (optional) lets Google hold the upload key, providing key recovery for lost developer keys.

**Driver signing (Windows KMCS):** Kernel-mode code requires Microsoft cross-signature (pre-2015) or attestation signing via the Windows Hardware Dev Center (WHQL portal). Since Windows 10 1607 (Anniversary Update), new third-party kernel modules must be signed by Microsoft's WHQL attestation service — not just by the developer.

**State of the art:** Authenticode defined in Microsoft PE/COFF specification + RFC 5652; RFC 3161 (TSA). Apple notarization requirements tightened annually (hardened runtime mandatory since 2019). Android APKv3.1 current. Sigstore keyless signing increasingly used for open-source packages (PyPI PEP 740, npm provenance). See [PKCS#7 / CMS](#pkcs7--cms--cryptographic-message-syntax) and [Sigstore / Keyless Code Signing](#sigstore--keyless-code-signing).

**Production readiness:** Production
Authenticode, Apple code signing, and Android APK signing are deployed on billions of devices; every Windows driver, macOS app, and Android APK is code-signed in production.

**Implementations:**
- [osslsigncode](https://github.com/mtrojnar/osslsigncode) ⭐ 1.0k — C, open-source Authenticode signing/verification tool
- [apksigner](https://developer.android.com/tools/apksigner) — Java, official Android APK signing tool (part of Android SDK)
- [sigstore/cosign](https://github.com/sigstore/cosign) ⭐ 5.8k — Go, keyless code signing for containers and artifacts
- [Apple codesign (rcodesign)](https://github.com/indygreg/apple-platform-rs) ⭐ 788 — Rust, open-source Apple code signing
- [SignTool](https://learn.microsoft.com/en-us/windows/win32/seccrypto/signtool) — C++, Microsoft SDK Authenticode signing tool

**Security status:** Secure
Cryptography is sound (RSA-2048/ECDSA + SHA-256 signatures with RFC 3161 timestamps); security depends on private key protection and CA trust model.

**Community acceptance:** Standard
Microsoft Authenticode, Apple notarization, and Android APK signing are mandatory platform requirements; CA/B Forum governs code signing certificates; Sigstore adopted by OpenSSF and major package registries.

---

## Certificate Transparency (CT)

**Goal:** Make TLS certificate issuance publicly auditable by requiring all WebPKI certificates to be submitted to publicly accessible, append-only, cryptographically verifiable logs before browsers accept them. Detects rogue or mis-issued certificates within hours of issuance rather than months or years.

**Core cryptographic structure — Merkle Hash Tree:**
```
Tree over all log entries (each entry = one certificate + metadata):

                [Root Hash]
               /            \
        [Hash(L,R)]        [Hash(L,R)]
        /       \           /       \
  [H(cert0)] [H(cert1)] [H(cert2)] [H(cert3)]
```
- Each leaf: `SHA-256(0x00 || leaf_input)` where leaf_input encodes the certificate and timestamp
- Each internal node: `SHA-256(0x01 || left_child || right_child)`
- The Signed Tree Head (STH) = `{tree_size, timestamp, root_hash}` signed by the log's ECDSA key

**Signed Certificate Timestamp (SCT):**
```
SCT structure (TLS extension, OCSP, or embedded X.509 extension):
  {
    version:    1,
    log_id:     SHA-256(log's public key),   -- identifies which log
    timestamp:  milliseconds since epoch,
    extensions: (empty or domain name hint),
    signature:  ECDSA-P256 over (version || signature_type || timestamp || entry_type || cert_data)
  }
```
The SCT is a promise from the log operator: "This certificate will be included in our append-only log within the Maximum Merge Delay (MMD), typically 24 hours."

**CT delivery mechanisms:**

| Method | Where SCT travels | Notes |
|---|---|---|
| **TLS extension** (RFC 6962) | In TLS handshake `signed_certificate_timestamp` extension | Server sends without cert modification |
| **OCSP stapling** | Embedded in stapled OCSP response | Server fetches from log; staples to handshake |
| **X.509 extension** | In leaf certificate OID `1.3.6.1.4.1.11129.2.4.2` | CA embeds at issuance time; most common for WebPKI |

**CT v2 (RFC 9162, 2022):** Replaces RFC 6962; introduces:
- Structured leaf data (SctVersion + LogID as structured fields)
- Improved inclusion/consistency proofs
- `tile`-based log retrieval (more efficient for mirrors and monitors)
- Support for pre-certificates and final certificates both

**Browser CT policy:**
- **Chrome:** Requires 2 SCTs from distinct CT logs for certificates with lifetime ≤180 days; 3 SCTs for lifetime >15 months; enforced since April 2018
- **Safari (Apple):** Requires 2 SCTs for certs ≤180 days, 3 for longer; enforced since October 2018
- **Firefox:** Currently relies on Chrome/Apple's CT logs list; CT hard-fail enforcement planned

**Merkle inclusion proof:**
```
To prove cert[i] is in a tree of size n, the log provides:
  - The leaf hash for cert[i]
  - O(log n) sibling hashes (the audit path)
Client verifies: recompute root from leaf + audit path == published root hash
```
This allows any party to verify inclusion without downloading the full log.

**CT monitoring and transparency ecosystem:**
- **crt.sh** (Sectigo) — public search over all CT logs; monitors for unexpected issuance
- **Google Trillian** — open-source Merkle log framework powering many CT logs
- **Certificate Transparency Policy (CA/B Forum)** — CAs must submit to qualified CT logs
- **CT log list** — Chrome and Apple each maintain lists of qualified logs; certificates must have SCTs from logs on these lists

**Limitation:** CT detects but does not prevent mis-issuance. A rogue CA can issue a certificate and it will appear in logs — but only after the fact. Domain owners must actively monitor CT logs (via crt.sh, Facebook CT monitor, etc.) to discover unauthorized certificates.

**State of the art:** RFC 9162 (CT v2, 2022); Chrome and Safari enforce CT for all public certificates. Over 10 billion certificates logged (2024). Sigstore Rekor uses a CT-compatible Merkle log for software artifact signatures. See [CAA / Certification Authority Authorization](#caa--certification-authority-authorization), [OCSP Stapling and Certificate Revocation](#ocsp-stapling-and-certificate-revocation), and [Sigstore / Keyless Code Signing](#sigstore--keyless-code-signing).

**Production readiness:** Production
Enforced by Chrome and Safari for all public WebPKI certificates since 2018; over 10 billion certificates logged across production CT logs operated by Google, Cloudflare, DigiCert, and others.

**Implementations:**
- [Google Trillian](https://github.com/google/trillian) ⭐ 3.7k — Go, general-purpose Merkle log framework powering CT logs
- [certificate-transparency-go](https://github.com/google/certificate-transparency-go) ⭐ 1.1k — Go, CT log server and client libraries
- [certspotter](https://github.com/SSLMate/certspotter) ⭐ 1.1k — Go, CT log monitor for detecting mis-issued certificates
- [crt.sh](https://crt.sh/) — PostgreSQL/Web, Sectigo-operated public CT search engine
- [Sigstore Rekor](https://github.com/sigstore/rekor) ⭐ 1.1k — Go, CT-compatible transparency log for software artifacts

**Security status:** Secure
Merkle tree construction with SHA-256 and ECDSA-signed tree heads is cryptographically sound; CT detects but does not prevent mis-issuance — domain owners must actively monitor logs.

**Community acceptance:** Standard
IETF RFC 9162 (CT v2); mandatory for all public WebPKI certificates per Chrome and Apple CT policies; CA/Browser Forum requires CA submission to qualified logs.

---

## COSE / CWT — CBOR Object Signing and Encryption

**Goal:** Provide a compact, binary encoding for signed and encrypted messages — analogous to JOSE/JWT but using CBOR (Concise Binary Object Representation) instead of JSON. Designed for constrained IoT devices, mobile credentials (ISO 18013-5 mDL), and protocols where JSON is too verbose.

**Relationship to JOSE:**

| Concept | JOSE (JSON-based) | COSE (CBOR-based) | RFC |
|---|---|---|---|
| Signed message | JWS (JSON Web Signature) | COSE_Sign / COSE_Sign1 | RFC 7515 / RFC 9052 |
| Encrypted message | JWE (JSON Web Encryption) | COSE_Encrypt / COSE_Encrypt0 | RFC 7516 / RFC 9052 |
| Key format | JWK | COSE_Key | RFC 7517 / RFC 9052 |
| Token | JWT | CWT (CBOR Web Token) | RFC 7519 / RFC 8392 |
| MAC | JWS with HMAC | COSE_Mac / COSE_Mac0 | RFC 7515 / RFC 9052 |

**COSE message types (CBOR tag):**

| Tag | Name | Use |
|---|---|---|
| 18 | `COSE_Sign1` | Single-signer; most common |
| 98 | `COSE_Sign` | Multi-signer |
| 16 | `COSE_Encrypt0` | Single-recipient symmetric encryption |
| 96 | `COSE_Encrypt` | Multi-recipient |
| 17 | `COSE_Mac0` | Single-key MAC |
| 97 | `COSE_Mac` | Multi-key MAC |

**COSE_Sign1 structure (CBOR diagnostic notation):**
```
/ COSE_Sign1 / 18(
  [
    / protected /   h'a10126',       -- {1: -7} = alg: ES256 (ECDSA P-256)
    / unprotected / {4: h'...'},     -- {4: kid} key ID
    / payload /     h'...',          -- the data being signed (or nil if detached)
    / signature /   h'...'           -- 64-byte ECDSA P-256 signature
  ]
)
```
The protected header is serialized to bytes and included in the signature computation as a CBOR bstr; this prevents header stripping attacks.

**COSE algorithm identifiers (selected):**

| COSE alg ID | Algorithm | Notes |
|---|---|---|
| -7 | ES256 (ECDSA P-256 + SHA-256) | Most common; WebAuthn default |
| -8 | EdDSA (Ed25519 or Ed448) | Compact; efficient verification |
| -35 | ES384 (ECDSA P-384 + SHA-384) | Higher security level |
| -37 | PS256 (RSASSA-PSS + SHA-256) | RSA; larger signatures |
| 1 | AES-GCM-128 | Encryption |
| 3 | AES-GCM-256 | Encryption |
| -6 | HMAC-SHA256/64 (truncated) | MAC |
| -16 | SHA-256 | Digest |

**CBOR Web Token (CWT, RFC 8392):**

CWT is to COSE as JWT is to JWS — a COSE_Sign1 (or COSE_Mac0) wrapping a CBOR map of standard claims:

```
/ CWT / COSE_Sign1([
  protected:   {1: -7},            -- alg: ES256
  unprotected: {},
  payload: {
    1:  "issuer.example.com",      -- iss
    2:  "subject@example.com",     -- sub
    4:  1735689600,                -- exp (UNIX timestamp)
    5:  1704067200,                -- nbf
    8:  h'...',                    -- cnf: proof-of-possession key
  },
  signature: h'...'
])
```

**Major deployments:**

| Application | Uses COSE/CWT because |
|---|---|
| **ISO 18013-5 mDL** (mobile driver's license) | Device-signed COSE_Sign1 over CBOR-encoded credential; NFC/BLE offline verification |
| **EU EUDI Wallet** (eIDAS 2.0) | SD-JWT and mdoc both support COSE; mdoc format uses COSE_Sign1 |
| **FIDO2 / WebAuthn** | `authenticatorData` and attestation objects CBOR-encoded; algorithms identified by COSE alg IDs |
| **IETF RATS / EAT** | Entity Attestation Token (RFC 9528) is a CWT carrying hardware attestation claims |
| **W3C Verifiable Credentials** | VC-JOSE-COSE profile uses COSE_Sign1 as alternative to JWT |
| **CoAP / OSCORE** | OSCORE (RFC 8613) uses COSE_Encrypt0 to protect CoAP messages end-to-end |

**EAT (Entity Attestation Token, RFC 9528):** A CWT profile for device attestation — carries claims like `UEID` (unique device identifier), `boot-seed`, `sw-components` (measured firmware layers), and `nonce`. Used by IETF RATS to express TEE / DICE attestation evidence as a standard token.

**COSE vs JOSE size (ES256 signed 100-byte payload):**
- JWS compact serialization: ~400 bytes (Base64url overhead)
- COSE_Sign1: ~200 bytes (binary CBOR; no Base64 encoding)

**State of the art:** RFC 9052 (COSE, 2022, replaces RFC 8152); RFC 8392 (CWT, 2018); RFC 9528 (EAT, 2024). Implementations: python-cwt, go-cose, cose-js, Bouncy Castle. Mandatory in ISO 18013-5 (mDL) and EU EUDI Wallet. See [W3C DID and Verifiable Credentials](#w3c-decentralized-identifiers-did-and-verifiable-credentials), [TEE Remote Attestation](#tee-remote-attestation), and [FIDO2 / WebAuthn / Passkeys](#fido2--webauthn--passkeys).

**Production readiness:** Production
Mandatory in ISO 18013-5 (mobile driver's license), EU EUDI Wallet, FIDO2/WebAuthn, and CoAP/OSCORE IoT protocols; deployed on billions of devices.

**Implementations:**
- [go-cose](https://github.com/veraison/go-cose) ⭐ 62 — Go, IETF COSE implementation
- [python-cwt](https://github.com/dajiaji/python-cwt) ⭐ 29 — Python, CWT/COSE library
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive crypto library with COSE/CWT support
- [COSE-C](https://github.com/cose-wg/COSE-C) ⭐ 31 — C, reference COSE implementation from the IETF working group

**Security status:** Secure
Built on well-established algorithms (ECDSA P-256, EdDSA, AES-GCM, HMAC-SHA-256); binary CBOR encoding avoids JSON canonicalization vulnerabilities present in JOSE.

**Community acceptance:** Standard
IETF RFC 9052 (COSE), RFC 8392 (CWT), RFC 9528 (EAT); mandated by ISO 18013-5, W3C WebAuthn, and EU eIDAS 2.0; adopted by all major platform vendors.

---

## AMD SEV-SNP — Attestation Report Structure

**Goal:** Enable a confidential virtual machine (CVM) running under AMD Secure Encrypted Virtualization with Secure Nested Paging (SEV-SNP) to prove to a remote verifier — cryptographically and without trusting the hypervisor — that it is a genuine AMD SEV-SNP VM running an unmodified guest image, and to bind arbitrary user data (such as a public key or nonce) to that attestation.

AMD SEV-SNP (2021) extends earlier AMD SEV (memory encryption) and SEV-ES (register state encryption) by adding memory integrity protection via a Reverse Map Table (RMP), preventing the hypervisor from remapping, aliasing, or replaying guest memory pages.

**Attestation report structure (AMD SEV-SNP ABI specification §7.3):**

```
struct snp_attestation_report {
  uint8_t  version;            // Report version (current: 2)
  uint8_t  guest_svn;          // Guest security version number
  uint64_t policy;             // Guest policy: SMT allowed, min ABI version, debug, migrate-MA
  uint8_t  family_id[16];      // Family UUID (set by hypervisor)
  uint8_t  image_id[16];       // Image UUID (set by hypervisor)
  uint32_t vmpl;               // VMPL level (0–3) at which report was requested
  uint32_t signature_algo;     // 1 = ECDSA P-384 with SHA-384
  struct tcb_version platform_version;  // Current TCB version (microcode, SNP FW, etc.)
  uint64_t platform_info;      // SMT enabled, TSME enabled flags
  uint8_t  measurement[48];    // SHA-384 of the initial guest memory (OVMF / kernel)
  uint8_t  host_data[32];      // Hypervisor-provided opaque blob (e.g., policy hash)
  uint8_t  id_key_digest[48];  // SHA-384 of the ID key used to sign the launch
  uint8_t  author_key_digest[48];
  uint8_t  report_id[32];      // Random report ID; fresh per attestation
  uint8_t  report_id_ma[32];   // Migration agent report ID
  struct tcb_version reported_tcb;
  uint8_t  chip_id[64];        // SHA-384(VCEK public key) — unique per chip
  uint8_t  report_data[64];    // User-supplied data (nonce, public key hash, etc.)
  // ... signature covers all fields above
  struct ecdsa_sig signature;  // ECDSA P-384 signature by VCEK or VLEK
};
```

**Signing key hierarchy:**

| Key | Full name | Scope | Certified by |
|-----|-----------|-------|-------------|
| **ARK** | AMD Root Key | AMD global root | Self-signed |
| **ASK** | AMD SEV Key | Per-product family | ARK |
| **VCEK** | Versioned Chip Endorsement Key | Per-chip + TCB version | ASK |
| **VLEK** | Versioned Loaded Endorsement Key | Per-cloud-provider | ASK (via AMD KDS) |

The VCEK is unique to each physical CPU chip and the currently installed TCB version (microcode + SNP firmware). The AMD Key Distribution Service (KDS) issues VCEK certificates at `kds.amd.com/vcek/{product}/{chip_id}?blSPL=...&teeSPL=...&snpSPL=...&ucodeSPL=...`. A relying party downloads the VCEK certificate from KDS and verifies the attestation report signature against it.

**Attestation flow:**

```
1. Guest calls sev-guest driver: ioctl(SNP_GET_REPORT, {user_data: nonce || pub_key_hash})
2. PSP (Platform Security Processor) generates attestation report; signs with VCEK (ECDSA P-384)
3. Guest forwards report + VCEK cert chain to verifier
4. Verifier:
   a. Downloads ARK + ASK from AMD; verifies cert chain to VCEK
   b. Verifies ECDSA P-384 signature over the report
   c. Checks measurement == expected(OVMF + kernel cmdline)
   d. Checks guest policy: no debug mode, correct minimum TCB
   e. Checks report_data == committed nonce / public key
5. If all checks pass: verifier trusts the guest and provisions secrets
```

**Measurement (initial guest state):** The `measurement` field is a SHA-384 digest of the initial guest memory pages as loaded by the firmware (OVMF), the kernel, and initrd — computed by the AMD PSP before any guest code executes. Any modification to the boot image changes the measurement and invalidates the attestation.

**Guest policy field (64-bit bitmask):**
- `SMT_ALLOWED` — whether simultaneous multithreading is permitted
- `DEBUG_ALLOWED` — if set, guest memory can be inspected (report is untrusted for production)
- `MIGRATE_MA` — migration agent policy
- `ABI_MAJOR/MINOR` — minimum SNP firmware version required

**Deployment:** Azure Confidential VMs (DCasv5/ECasv5), Google Cloud Confidential VMs (N2D/C2D), AWS (on AMD Epyc via SEV-SNP preview). Used for confidential ML inference (NVIDIA H100 integrates with SEV-SNP attestation via NVIDIA HOPPER Confidential Computing), key release policies in Azure mHSM, and cryptographic protocol binding for confidential enclaves.

**State of the art:** AMD SEV-SNP ABI specification v1.55 (2023) [[1]](https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf); IETF draft-ietf-rats-sev-snp (2024). See [TEE Remote Attestation](#tee-remote-attestation) and [Azure Confidential Computing](#azure-confidential-computing--sgx--tdx-attestation).

**Production readiness:** Production
Deployed in Azure Confidential VMs (DCasv5/ECasv5), Google Cloud Confidential VMs, and AWS SEV-SNP preview; used for confidential ML inference with NVIDIA H100 Hopper.

**Implementations:**
- [virtee/sev](https://github.com/virtee/sev) ⭐ 138 — Rust, AMD SEV-SNP attestation and guest management library
- [AMD SEV Tool](https://github.com/AMDESE/sev-tool) ⭐ 87 — C++, AMD SEV platform management utilities
- [sev-snp-measure](https://github.com/virtee/sev-snp-measure) ⭐ 74 — Python, pre-compute expected SEV-SNP guest measurements
- [coconut-svsm](https://github.com/coconut-svsm/svsm) ⭐ 210 — Rust, Secure VM Service Module for SEV-SNP guests

**Security status:** Caution
ECDSA P-384 attestation cryptography is sound; security depends on AMD PSP firmware integrity and timely TCB updates; side-channel attacks on earlier SEV generations (CacheWarp, 2023) have been mitigated in SNP but require vigilance.

**Community acceptance:** Standard
AMD SEV-SNP ABI specification; IETF draft-ietf-rats-sev-snp; adopted by all major cloud providers; NIST SP 800-233 (draft) references SEV-SNP for confidential computing.

---

## Azure Confidential Computing — SGX and TDX Attestation

**Goal:** Allow workloads running in Azure confidential VMs and confidential containers to obtain cryptographic proof — verifiable by any external party — that they are executing inside a genuine Intel SGX enclave or Intel TDX Trust Domain, on hardware whose TCB is current, and that their code has not been modified. Azure acts as a coordinating platform but is explicitly excluded from the trust boundary.

**Attestation infrastructure components:**

| Component | Role |
|-----------|------|
| **Microsoft Azure Attestation (MAA)** | Cloud attestation service; validates SGX/TDX/AMD SEV-SNP evidence; issues signed JWT attestation tokens |
| **Intel PCCS** (Provisioning Certificate Caching Service) | Fetches and caches SGX/TDX platform certificates (PCK certs) from Intel PCS |
| **Intel PCS** (Provisioning Certification Service) | Intel's online service issuing PCK certificates and TCB info |
| **DCAP** (Data Center Attestation Primitives) | Intel's SDK for generating quotes without calling Intel directly; used in Azure |
| **Azure vTPM** | Virtual TPM backed by SEV-SNP or TDX; issues TPM quotes for confidential VMs |

**Intel TDX attestation flow in Azure (CVM path):**

```
1. TD Guest generates a TDREPORT:
   TD call: TDG.MR.REPORT(report_data=nonce)
   -> TDREPORT_STRUCT {
        attributes, xfam,
        MRTD      (TD measurement — hash of initial TD image),
        MRCONFIGID, MROWNER, MROWNERCONFIG,
        RTMR[0..3] (runtime measurements, extended by TD),
        report_data (64 bytes user data — nonce or pub key hash)
      }
   Signed by TD-specific signing key inside TDX module (not exportable)

2. TDREPORT converted to TDX Quote by Quoting Enclave (QE):
   QE runs in a separate SGX enclave on the same host;
   QE wraps TDREPORT in a TDX Quote, signs with QE's ECDSA P-256 Attestation Key
   Quote header includes: QE identity, PCK cert hash, TCB level

3. Quote submitted to MAA (or verified locally with DCAP):
   MAA fetches PCK cert + TCB info from Intel PCCS
   Verifies ECDSA signature on Quote
   Checks PCK cert chain: Intel Root CA → Intel Platform CA → PCK Cert
   Checks TCB level against Intel's published TCB info (is the platform patched?)
   Issues signed JWT attestation token:
     { x-ms-attestation-type: "tdxvm",
       x-ms-tdx-td-attributes: {...},
       x-ms-tdx-mrtd: "<base64-measurement>",
       x-ms-tdx-rtmrs: [...],
       x-ms-tdx-report-data: "<nonce>",
       exp, nbf, iss: "https://sharedneu.neu.attest.azure.net" }
```

**Intel SGX DCAP attestation (used for confidential containers / AKS CoCo):**

```
Measurement registers:
  MRENCLAVE — SHA-256 of enclave pages (code + data loaded at initialization)
  MRSIGNER  — SHA-256 of the enclave signing key (developer identity)
  ISVSVN    — ISV Security Version Number (monotonic; prevents rollback)
  ISVPRODID — product ID distinguishes multiple enclaves per signer

ECDSA Quote structure:
  ISV Report (REPORT): 432 bytes signed by CPU Report Key (hardware)
  QE Report: signed by QE Attestation Key (ECDSA P-256)
  QE Certification Data: PCK cert chain (DER)
  ISV Signature: ECDSA P-256 over ISV Report by QE Attestation Key
```

**Confidential Containers (Azure AKS CoCo):** Kata Containers + TDX/SNP; each pod runs in its own TD; hardware attestation gates secret injection via Azure Key Vault managed HSM. Policy expressed as Rego (OPA) rules evaluated inside the TD.

**Attestation token (MAA JWT claims):**

| Claim | Meaning |
|-------|---------|
| `x-ms-attestation-type` | `"sgxvm"`, `"tdxvm"`, or `"sevsnpvm"` |
| `x-ms-sgx-mrenclave` | SHA-256 of enclave code |
| `x-ms-sgx-mrsigner` | SHA-256 of signer key |
| `x-ms-sgx-is-debuggable` | Must be `false` in production |
| `x-ms-tdx-mrtd` | TD image measurement |
| `x-ms-compliance-status` | `"azure-compliant-cvm"` — Azure policy check result |

**Key release via mHSM:** Azure Managed HSM supports secure key release (SKR) — an HSM policy rule specifying an MAA attestation claim predicate. Only an attested CVM that presents a valid MAA token matching the policy can receive the unwrapped key; the HSM verifies the MAA JWT's signature (using MAA's JWKS endpoint) and evaluates the Rego policy.

**State of the art:** Azure Confidential Computing GA (2022); TDX support (2023, DCesv5 VMs); AKS Confidential Containers preview (2024). Intel TDX Module 1.5 specification [[1]](https://cdrdv2.intel.com/v1/dl/getContent/733577). IETF draft-ietf-rats-intel-tee-appraisal (2024). See [TEE Remote Attestation](#tee-remote-attestation) and [AMD SEV-SNP](#amd-sev-snp--attestation-report-structure).

**Production readiness:** Production
Azure Confidential Computing GA since 2022; SGX enclaves (DCsv3), TDX VMs (DCesv5), and AKS Confidential Containers deployed in production; MAA attestation service publicly available.

**Implementations:**
- [Intel SGX DCAP](https://github.com/intel/SGXDataCenterAttestationPrimitives) ⭐ 321 — C/C++, data center attestation primitives
- [Open Enclave SDK](https://github.com/openenclave/openenclave) ⭐ 1.2k — C/C++, cross-platform TEE SDK (SGX + TrustZone)
- [Gramine](https://github.com/gramineproject/gramine) ⭐ 755 — C, library OS for running unmodified Linux apps in SGX enclaves
- [Confidential Containers](https://github.com/confidential-containers) — Go/Rust, CNCF project for Kata + TDX/SNP container isolation

**Security status:** Caution
Attestation protocols are cryptographically sound (ECDSA P-256 quotes, Intel PCK cert chains); security depends on Intel microcode patching cadence and SGX side-channel mitigations (LVI, MMIO stale data).

**Community acceptance:** Standard
Intel DCAP and TDX specifications; IETF RATS architecture (RFC 9334); Microsoft Azure Attestation service; adopted by major enterprises for confidential computing workloads.

---

## Post-Quantum PKI Transition — Hybrid Certificates

**Goal:** Migrate the global PKI from classical asymmetric algorithms (RSA, ECDSA, ECDH) to post-quantum algorithms (ML-DSA / ML-KEM, SLH-DSA, FN-DSA) in a way that maintains backward compatibility during the multi-year transition period. Hybrid certificates carry both a classical and a post-quantum key and signature simultaneously, ensuring security against both classical adversaries (now) and quantum adversaries (later), without breaking existing relying parties.

**Why a hybrid period is necessary:** A "harvest now, decrypt later" (HNDL) adversary can record TLS traffic today and decrypt it once a sufficiently powerful quantum computer exists. For long-lived certificates (CA roots, code signing, device identity), the classical algorithms may still be active when quantum computers arrive. Hybrid schemes provide defense in depth.

**Hybrid certificate approaches (IETF LAMPS WG, 2024):**

| Approach | Draft | Mechanism | Note |
|----------|-------|-----------|------|
| **Composite signatures** | draft-ietf-lamps-pq-composite-sigs | Single X.509 cert; `subjectPublicKeyInfo` holds a CompositePublicKey encoding both keys; `signature` is a CompositeSignature (SEQUENCE of two signatures) | Both classical + PQ sig must verify; backward incompatible |
| **Composite KEM** | draft-ietf-lamps-pq-composite-kem | `subjectPublicKeyInfo` encodes both KEM keys; combined shared secret = KDF(ss_classical \|\| ss_pq) | Used for TLS hybrid key exchange |
| **SubjectAltPublicKeyInfo** (SAPKI) | draft-ietf-lamps-cert-binding-for-multi-key | Classical cert + X.509 extension carrying the PQ public key; separate PQ signature in another extension | Backward compatible: old clients ignore the extension |
| **Dual certificates** | Operational approach | Issue two parallel certs per entity (one classical, one PQ); server presents both in TLS | No cert format changes; requires dual-chain support |

**CompositeSignature OID structure:**

```
-- Composite ML-DSA-44 with ECDSA-P256 (example)
id-MLDSA44-ECDSA-P256-SHA256 OBJECT IDENTIFIER ::= { ... }

CompositePublicKey ::= SEQUENCE SIZE (2) OF BIT STRING
-- [0] ML-DSA-44 public key (1312 bytes)
-- [1] ECDSA P-256 public key (65 bytes uncompressed)

CompositeSignature ::= SEQUENCE SIZE (2) OF BIT STRING
-- [0] ML-DSA-44 signature (2420 bytes)
-- [1] ECDSA P-256 signature (72 bytes DER)

-- Both signatures computed over the same message (with domain separation)
-- Verification: BOTH must be valid; failure of either = rejection
```

**Hybrid TLS 1.3 key exchange (deployed today):**

| Hybrid KEM | Classical | PQ | Status |
|---|---|---|---|
| `X25519Kyber768Draft00` | X25519 | Kyber-768 (pre-standard) | Deployed by Chrome, Cloudflare (2023) |
| `x25519_ml_kem_768` (RFC 8446 NamedGroup) | X25519 | ML-KEM-768 | IANA registered; replacing draft Kyber |
| `SecP256r1MLKEM768` | P-256 ECDH | ML-KEM-768 | NIST SP 800-227 recommendation |

The combined shared secret is `HKDF(ss_X25519 || ss_ML-KEM)`; a passive quantum adversary must break ML-KEM to decrypt; an active classical adversary must break X25519. Security is the stronger of the two.

**NIST PQC algorithm standardization (2024):**

| Algorithm | NIST Standard | Role | Key/Sig sizes |
|-----------|--------------|------|---------------|
| **ML-KEM** (Kyber) | FIPS 203 | KEM | PK: 1184 B, CT: 1088 B (level 3) |
| **ML-DSA** (Dilithium) | FIPS 204 | Signature | PK: 1952 B, Sig: 3293 B (level 3) |
| **SLH-DSA** (SPHINCS+) | FIPS 205 | Signature (hash-based) | PK: 32 B, Sig: 17 kB (small-sig variant) |
| **FN-DSA** (FALCON) | FIPS 206 | Signature (lattice) | PK: 897 B, Sig: 666 B (level 1) |

**CA/Browser Forum and WebPKI transition timeline:** CA/B Forum Ballot SC-081 (2024 draft) addresses PQ algorithm agility in the Baseline Requirements. NIST IR 8547 (2024) recommends deprecating RSA and ECDSA by 2035. CNSA 2.0 (NSA, 2022) mandates PQ algorithms for national security systems by 2030–2033.

**Certificate size impact:** A composite ML-DSA-44 + ECDSA-P256 leaf certificate is approximately 4–5 kB vs ~1 kB for a classical ECDSA cert. Intermediate and root certificates are similarly enlarged. TLS handshake fragmentation and DTLS/QUIC implications are active research areas.

**State of the art:** FIPS 203/204/205 (2024) finalized; FIPS 206 (FN-DSA) in final draft (2024). draft-ietf-lamps-pq-composite-sigs-02 (2024); draft-ietf-lamps-cert-binding-for-multi-key-07 (2024). Chrome deployed X25519+ML-KEM hybrid for TLS 1.3 by default (2024). See [Digital Signatures](categories/08-signatures-advanced.md#digital-signatures), [TEE Remote Attestation](#tee-remote-attestation), and [COSE / CWT](#cose--cwt--cbor-object-signing-and-encryption).

**Production readiness:** Experimental
Hybrid TLS key exchange (X25519+ML-KEM) deployed in Chrome and Cloudflare; hybrid X.509 certificates are in IETF draft stage with no production WebPKI deployment yet.

**Implementations:**
- [Open Quantum Safe (liboqs)](https://github.com/open-quantum-safe/liboqs) ⭐ 2.8k — C, PQ algorithm library with hybrid certificate support
- [oqs-provider](https://github.com/open-quantum-safe/oqs-provider) ⭐ 460 — C, OpenSSL 3 provider for PQ/hybrid algorithms
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, ML-KEM/ML-DSA and composite certificate support
- [rustls](https://github.com/rustls/rustls) ⭐ 7.3k — Rust, TLS library with X25519+ML-KEM hybrid key exchange
- [wolfSSL](https://github.com/wolfSSL/wolfssl) ⭐ 2.8k — C, embedded TLS with FIPS 203/204/205 support

**Security status:** Caution
Underlying PQ algorithms (ML-KEM, ML-DSA) are NIST-standardized and considered secure; hybrid schemes provide defense-in-depth, but composite certificate formats are not yet finalized and interoperability is limited.

**Community acceptance:** Emerging
NIST FIPS 203/204/205 finalized; IETF LAMPS WG actively drafting composite certificate standards; CNSA 2.0 mandates PQ by 2030-2033; broad industry momentum but no production WebPKI deployment of hybrid certificates yet.

---

## CMC Protocol / Certificate Lifecycle Management

**Goal:** Automate the full lifecycle of X.509 certificates — enrollment, renewal, revocation, and key archival — in enterprise and large-scale PKI deployments, using standardized protocols that allow certificate management clients (devices, servers, applications) to communicate with CAs without manual intervention.

**Certificate lifecycle stages:**

```
Key generation → Enrollment / CSR → Issuance → Deployment →
  Monitoring (expiry, CT logs) → Renewal → Revocation → Archival
```

**Certificate management protocols:**

| Protocol | RFC | Transport | Use case | Key feature |
|----------|-----|-----------|----------|-------------|
| **CMC** (Certificate Management over CMS) | RFC 5272, 5273, 5274 | HTTP, HTTPS, email | Enterprise PKI; DoD PKI | Full lifecycle; signed CMS-wrapped requests; RA support |
| **SCEP** (Simple Certificate Enrollment Protocol) | RFC 8894 | HTTP | Network devices (Cisco, Juniper) | Simple; widely deployed; uses PKCS#7 |
| **EST** (Enrollment over Secure Transport) | RFC 7030 | HTTPS | IoT; enterprise | TLS client auth; simpler than CMC; RESTful |
| **ACME** (Automatic Certificate Management) | RFC 8555 | HTTPS | WebPKI; Let's Encrypt | Domain validation challenges; JSON/JWS |
| **CMP** (Certificate Management Protocol) | RFC 4210, 9480 | HTTP, CoAP | Telecom; automotive (AUTOSAR) | Full PKI management messages; ASN.1 |
| **PKCS#15** | PKCS#15 | Smart card | Smart card key/cert storage | On-card file layout standard |

**CMC (RFC 5272) architecture:**

```
CMC Full PKI Request (CMS SignedData wrapping):
  PKIData ::= SEQUENCE {
    controlSequence   SEQUENCE OF TaggedAttribute,   -- CMC controls
    reqSequence       SEQUENCE OF TaggedRequest,     -- PKCS#10 CSRs or CRMF
    cmsSequence       SEQUENCE OF TaggedContentInfo, -- nested CMS objects
    otherMsgSequence  SEQUENCE OF OtherMsg
  }

Key CMC controls:
  id-cmc-regInfo          -- registration info (device identity)
  id-cmc-responseInfo     -- CA response data
  id-cmc-statusInfoV2     -- per-request status codes
  id-cmc-revokeRequest    -- revocation request
  id-cmc-decryptedPOP     -- proof of possession for encryption keys
  id-cmc-lraPOPWitness    -- RA witnesses proof of possession
```

**EST (RFC 7030) endpoints (RESTful, simpler than CMC):**

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/.well-known/est/cacerts` | GET | Fetch current CA certificate(s) |
| `/.well-known/est/simpleenroll` | POST | Enroll with PKCS#10 CSR (Base64 DER) |
| `/.well-known/est/simplereenroll` | POST | Renew existing certificate |
| `/.well-known/est/fullcmc` | POST | Full CMC request |
| `/.well-known/est/serverkeygen` | POST | Request server-side key generation + cert |

Authentication: TLS client certificate (for re-enrollment) or HTTP Basic (initial enrollment); TLS mandatory.

**NIST CSWP 25 (Automation of Certificate Management in Enterprise Environments, 2023):**
NIST Cybersecurity White Paper 25 documents the operational framework for enterprise certificate lifecycle automation:
- Certificate discovery (passive TLS scan, CT log monitoring, asset inventory)
- Certificate inventory and expiry alerting
- Automated renewal triggers (e.g., 30 days before expiry)
- Integration with CMDBs, SIEM, and secrets managers
- Revocation workflows (HR offboarding triggers OCSP revocation)

**Enterprise CLM platforms:** Venafi Trust Protection Platform, DigiCert CertCentral, AppViewX CERT+, Sectigo Certificate Manager, HashiCorp Vault PKI secrets engine. Cloud-native: AWS ACM (auto-renews ACM-issued certs), GCP Certificate Authority Service, Azure Key Vault certificates.

**Key archival (CMC):** For encryption certificates (S/MIME, document encryption), the private key must be escrowed with the CA or a Key Archival Authority (KAA) so that encrypted data can be recovered if the key is lost. CMC supports `id-cmc-decryptedPOP` and key archival request/response to transfer the private key securely (wrapped under the CA's encryption key) at enrollment time. FIPS 140-level HSMs at the CA decrypt and re-wrap under the archival key.

**Automotive / IoT (CMP v3, RFC 9480):** CMP version 3 (2023) adds lightweight HTTP transport, CoAP support (for constrained devices), and asymmetric key wrapping improvements — targeting automotive ECUs, industrial controllers, and IoT gateways following UNECE WP.29 R155/R156 (vehicle cybersecurity regulations).

**State of the art:** RFC 5272/5273/5274 (CMC); RFC 7030 (EST); RFC 9480 (CMP v3, 2023); RFC 8894 (SCEP, 2020); NIST CSWP 25 (2023) [[1]](https://csrc.nist.gov/pubs/cswp/25/automating-certificate-management-in-enterprise/final). See [ACME Protocol](categories/03-key-exchange-key-management.md#acme-protocol--automated-certificate-management), [OCSP Stapling and Certificate Revocation](#ocsp-stapling-and-certificate-revocation), and [PKCS#7 / CMS](#pkcs7--cms--cryptographic-message-syntax).

**Production readiness:** Production
EST and SCEP widely deployed in enterprise PKI; CMP v3 mandated for automotive (UNECE WP.29); ACME powers Let's Encrypt (400M+ certificates); CMC used in US DoD PKI infrastructure.

**Implementations:**
- [EJBCA](https://github.com/Keyfactor/ejbca-ce) ⭐ 896 — Java, enterprise CA with CMC/EST/CMP/SCEP support
- [Dogtag PKI](https://github.com/dogtagpki/pki) ⭐ 483 — Java, Red Hat PKI server with CMC support
- [libest](https://github.com/cisco/libest) ⭐ 106 — C, Cisco EST client/server library
- [HashiCorp Vault PKI](https://github.com/hashicorp/vault) ⭐ 35k — Go, PKI secrets engine with auto-renewal
- [openxpki](https://github.com/openxpki/openxpki) ⭐ 672 — Perl, enterprise PKI with SCEP and EST

**Security status:** Secure
Protocols use CMS/PKCS#7 signed requests over TLS; security depends on proper CA configuration and authentication method (certificate-based mutual TLS preferred over HTTP Basic).

**Community acceptance:** Standard
IETF RFCs 5272 (CMC), 7030 (EST), 9480 (CMP v3), 8894 (SCEP), 8555 (ACME); NIST CSWP 25 provides enterprise guidance; broad vendor adoption across all major PKI platforms.

---

## Hardware Attestation in Mobile — Android Keystore and Apple Secure Enclave

**Goal:** Allow mobile applications and remote services to verify that a cryptographic key was generated inside a hardware-backed secure environment (Secure Element / TEE) on a specific device, and that the device meets a minimum security posture — enabling use cases like FIDO2 attestation, mobile banking, enterprise MDM compliance checking, and DRM without trusting application-layer software.

**Platform comparison:**

| Aspect | Android Keystore (StrongBox) | Apple Secure Enclave |
|--------|------------------------------|---------------------|
| Hardware isolation | Dedicated security chip (StrongBox HAL) or ARM TrustZone (TEE) | Dedicated Apple-designed SoC coprocessor |
| Key generation | Generated inside secure element; private key never exported | Generated inside SE; private key never leaves SE |
| Attestation | Android Key Attestation (X.509 cert chain from Google root) | Device Attestation (CBOR/COSE from Apple) |
| Supported algorithms | ECDSA P-256, RSA 2048/4096, AES-GCM, HMAC | ECDSA P-256, ECDH P-256, Curve25519 (iOS 17+) |
| Biometric binding | `setUserAuthenticationRequired()` + BiometricPrompt | SecAccessControl with biometry / Passcode |

**Android Key Attestation (X.509 extension OID `1.3.6.1.4.1.11129.2.1.17`):**

```
Key attestation certificate chain:
  Google Hardware Attestation Root CA (offline, pinned)
    └── Google Intermediate CA (device batch)
          └── Attestation Certificate (per device, per key pair)
                 └── Application Certificate (the actual key)

KeyDescription ::= SEQUENCE {
  attestationVersion     INTEGER,    -- 300 for KeyMint 3.0
  attestationSecurityLevel  SecurityLevel,  -- TrustedEnvironment or StrongBox
  keyMintVersion            INTEGER,
  keyMintSecurityLevel      SecurityLevel,
  attestationChallenge      OCTET STRING,   -- nonce from relying party
  uniqueId                  OCTET STRING,   -- rotatable device fingerprint
  softwareEnforced          AuthorizationList,
  hardwareEnforced          AuthorizationList   -- properties enforced by secure HW
}

AuthorizationList (hardware-enforced) key properties:
  purpose:       SIGN | VERIFY | ENCRYPT | DECRYPT | WRAP_KEY
  algorithm:     EC | RSA | AES | HMAC
  keySize:       256 | 2048 | ...
  digest:        SHA_2_256 | ...
  ecCurve:       P_256
  userAuthType:  FINGERPRINT | STRONG_BOX_SPECIFIC_PIN
  noAuthRequired / authTimeout
  bootPatchLevel, osPatchLevel, osVersion  -- device security posture
  rollbackResistance  -- key survives factory reset only if this is set
```

The `hardwareEnforced` authorization list is signed by the attestation key inside the secure element; its contents cannot be forged by a compromised OS. A remote verifier checks: (1) cert chain to Google root, (2) `attestationChallenge` matches the nonce, (3) `attestationSecurityLevel == StrongBox`, (4) security patch level is current.

**StrongBox vs TEE-backed keys:**
- **TEE (Trusted Execution Environment):** ARM TrustZone; isolated from Android OS but shares the main SoC. `attestationSecurityLevel = TrustedEnvironment`.
- **StrongBox:** Separate tamper-resistant security chip (e.g., Titan M2 on Google Pixel, Samsung SE050); physically isolated from the main SoC. `attestationSecurityLevel = StrongBox`. More resistant to hardware attacks.

**Apple Secure Enclave attestation (DCAttestation, iOS 14+):**

```
// App-level attestation (AppAttest, using DCAppAttestService)
let challenge = Data(/* nonce from server */)
DCAppAttestService.shared.generateKey { keyId, error in
    DCAppAttestService.shared.attestKey(keyId, clientDataHash: SHA256(challenge)) { attestation, error in
        // attestation: CBOR object containing:
        //   fmt: "apple-appattest"
        //   attStmt: { x5c: [cert, intermediate, root], receipt: Data }
        //   authData: { rpIdHash, flags, counter, AAGUID, credentialId, credentialPublicKey }
        // cert is signed by Apple App Attestation CA
        // SubjectPublicKeyInfo of attestation cert == generated P-256 key
        // Server verifies: chain to Apple root, nonce in cert extension, bundle ID
    }
}
```

Apple's Device Attestation (DeviceCheck) additionally provides a server-API-based device signal (two per-device bits persisted by Apple). The App Attest API provides hardware-level key attestation where the private key is generated and stored in the Secure Enclave, and the attestation certificate chain roots in Apple's private CA.

**FIDO2 / WebAuthn integration:**
- Android: `android-key` attestation format — the FIDO2 attestation statement contains the Android Keystore attestation certificate chain; relying parties verify the StrongBox or TEE backing.
- Apple: `apple` attestation format — Apple-specific anonymous attestation CA; device model not disclosed, but SE backing is guaranteed.
- Both integrate with platform FIDO2 authenticators (passkeys), where the ECDSA P-256 resident key is SE/StrongBox-resident.

**Remote Key Provisioning (RKP, Android 12+):** Replaces factory-burned attestation root certs with an online provisioning system. Devices generate an ephemeral ECDH key pair in StrongBox, perform a remote key provisioning protocol with Google's backend (using hybrid encryption + CBOR/COSE), and receive fresh attestation certificates signed by Google. This enables certificate rotation without firmware updates and eliminates the need to burn per-device certs at the factory — using DICE-based identity as the provisioning root.

**State of the art:** Android KeyMint 3.0 (Android 14, 2023); StrongBox HAL v4 (Android 14); Google Titan M2 security chip. Apple Secure Enclave Processor (all devices since iPhone 5s, 2013); App Attest API (iOS 14+, 2020); FIDO2 platform authenticator (iOS 16+). See [FIDO2 / WebAuthn / Passkeys](#fido2--webauthn--passkeys), [DICE — Device Identifier Composition Engine](#dice--device-identifier-composition-engine), and [TEE Remote Attestation](#tee-remote-attestation).

**Production readiness:** Production
Deployed on billions of Android and iOS devices; Android Key Attestation and Apple App Attest are production APIs used by banking, enterprise MDM, and FIDO2 authenticator applications.

**Implementations:**
- [Android Keystore API](https://developer.android.com/training/articles/keystore) — Java/Kotlin, Android platform key management and attestation
- [Apple CryptoKit / Security framework](https://developer.apple.com/documentation/cryptokit) — Swift, Secure Enclave key operations and App Attest
- [Google Titan M2](https://security.googleblog.com/2022/10/google-pixel-7-titan-m2.html) — Hardware, Google's discrete security chip for StrongBox

**Security status:** Secure
Keys generated and stored in dedicated secure hardware (StrongBox / Secure Enclave); attestation chains root in Google and Apple CAs; ECDSA P-256 cryptography is sound.

**Community acceptance:** Standard
Google and Apple platform standards; Android CDD mandates KeyMint for all devices; FIDO2 attestation formats standardized by FIDO Alliance; used by financial regulators for mobile banking compliance.

---

## MACsec / IEEE 802.1AE — Link-Layer Encryption

**Goal:** Provide hop-by-hop confidentiality, integrity, and replay protection at Layer 2 (Ethernet frames) between directly connected network devices. Every frame on the wire is authenticated and optionally encrypted, preventing eavesdropping and injection on LAN segments — including by physically tapping the cable.

| Component | Standard | Function |
|-----------|----------|----------|
| **MACsec (802.1AE)** | IEEE 802.1AE-2018 | Frame encapsulation: SecTAG header + ICV (GCM-AES-128 or GCM-AES-256) [[1]](https://standards.ieee.org/ieee/802.1AE/7203/) |
| **MKA (MACsec Key Agreement)** | IEEE 802.1X-2020 (clause 12) | Key agreement protocol: derives SAK (Secure Association Key) from CAK (Connectivity Association Key) [[2]](https://standards.ieee.org/ieee/802.1X/7345/) |
| **SecTAG** | 802.1AE sec. 9 | 8-16 byte tag inserted after src MAC: SCI (Secure Channel Identifier) + PN (Packet Number, 32 or 64 bit) |
| **Cipher suites** | 802.1AE-2018 | `GCM-AES-128` (default), `GCM-AES-256`, `GCM-AES-XPN-128/256` (extended PN for 100G+ links) [[3]](https://www.rfc-editor.org/rfc/rfc8439) |

**MKA key hierarchy:**
```
CAK (Connectivity Association Key, 128/256 bit)
  └─ via KDF ──► ICK (ICV Key) — authenticates MKA PDUs
  └─ via KDF ──► KEK (Key Encrypting Key) — wraps SAK distribution
  └─ generates ──► SAK (Secure Association Key) — used by GCM-AES for frame crypto
```

**Frame format (encrypted):**
```
[Dst MAC | Src MAC | SecTAG (8-16B) | Encrypted payload | ICV (8-16B) | FCS]
```

**Deployments:** Data center east-west traffic (Cisco TrustSec, Juniper MACsec); financial trading floors (mandated by PCI DSS for LAN segments); WAN MACsec over MPLS/dark fiber; cloud provider backbone links (Google, AWS). Linux kernel supports MACsec via `ip macsec` (since kernel 4.6).

**State of the art:** IEEE 802.1AE-2018 (revision with XPN for high-speed links); MKA defined in IEEE 802.1X-2020. Hardware offload in all modern enterprise NICs and switches (Intel E810, Broadcom Memory, Cisco Catalyst, Arista). See [AEAD — Authenticated Encryption](categories/02-authenticated-structured-encryption.md#aead--authenticated-encryption-with-associated-data).

**Production readiness:** Production
Deployed in data center east-west traffic, financial trading floors, and cloud provider backbone links; hardware offload in all modern enterprise NICs and switches; Linux kernel support since 4.6.

**Implementations:**
- [Linux MACsec (ip macsec)](https://man7.org/linux/man-pages/man8/ip-macsec.8.html) — C, Linux kernel MACsec subsystem (since kernel 4.6)
- [Open vSwitch](https://github.com/openvswitch/ovs) ⭐ 3.9k — C, software switch with MACsec offload support
- [Cisco TrustSec](https://www.cisco.com/c/en/us/solutions/enterprise-networks/trustsec/index.html) — Proprietary, Cisco MACsec implementation across Catalyst/Nexus
- [strongSwan](https://github.com/strongswan/strongswan) ⭐ 2.8k — C, IPsec/IKEv2 with MACsec integration capabilities

**Security status:** Secure
GCM-AES-128/256 with replay protection is cryptographically sound; XPN extension prevents packet number exhaustion on high-speed (100G+) links; security requires physical control of endpoints.

**Community acceptance:** Standard
IEEE 802.1AE-2018 and IEEE 802.1X-2020; mandated by PCI DSS for LAN segment protection; deployed by all major network equipment vendors (Cisco, Juniper, Arista, HPE).

---

## UEFI Secure Boot / Measured Boot / dm-verity

**Goal:** Establish a cryptographic chain of trust from platform firmware through bootloader to OS kernel, ensuring that only authorized code executes at each stage. Prevent bootkits, rootkits, and unauthorized OS modifications from persisting across reboots.

| Mechanism | Layer | Crypto | Standard |
|-----------|-------|--------|----------|
| **UEFI Secure Boot** | Firmware → bootloader → kernel | RSA-2048/SHA-256 signature verification against key databases (db/dbx/KEK/PK) | UEFI Specification 2.10 [[1]](https://uefi.org/specifications) |
| **Measured Boot (TCG)** | Firmware → PCRs | SHA-256 extend into TPM PCRs; remote attestation via TPM2_Quote | TCG PC Client Spec [[2]](https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/) |
| **dm-verity** | Block device → filesystem | Merkle tree of SHA-256 hashes over 4K blocks; root hash signed | Linux kernel (Chrome OS, Android) [[3]](https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html) |
| **IMA (Integrity Measurement Architecture)** | File-level | Per-file SHA-256 digest extended into TPM PCR 10; appraisal against signed policy | Linux kernel [[4]](https://sourceforge.net/p/linux-ima/wiki/Home/) |
| **Apple Secure Boot** | iBoot chain | IMG4 format: DER-encoded manifest signed by Apple root CA (RSA-4096/SHA-384) | Apple Platform Security Guide [[5]](https://support.apple.com/guide/security/secure-boot-sec4cb250c11/web) |

**UEFI Secure Boot key hierarchy:**
```
PK (Platform Key) — OEM root; signs KEK updates
  └─ KEK (Key Exchange Key) — signs db/dbx updates (Microsoft, OEM)
       └─ db (Allowed Signatures Database) — contains trusted signing certs
       └─ dbx (Forbidden Signatures Database) — revoked hashes/certs
```

**dm-verity Merkle tree:**
```
Signed root hash (RSA/ECDSA)
  └─ Level 0: hash of (block[0] hash || block[1] hash || ...)
       └─ Level 1: hash of each 4K data block
```
Android Verified Boot (AVB) uses dm-verity for system/vendor partitions; root hash stored in vbmeta signed by OEM key (RSA-4096 or ECDSA P-256). Chrome OS uses dm-verity for the root filesystem with kernel command-line root hash.

**State of the art:** UEFI 2.10 (2022); Microsoft requires Secure Boot for Windows 11; Linux shim bootloader (signed by Microsoft UEFI CA) enables distro chains. Android Verified Boot 2.0 (AVB, AOSP). See [TPM 2.0](#tpm-20--trusted-platform-module), [DICE](#dice--device-identifier-composition-engine).

**Production readiness:** Production
UEFI Secure Boot mandatory for Windows 11; deployed on virtually all x86 PCs and servers; Android Verified Boot on all Android devices; dm-verity in Chrome OS and Android.

**Implementations:**
- [shim](https://github.com/rhboot/shim) ⭐ 1.1k — C, UEFI first-stage bootloader signed by Microsoft CA for Linux distros
- [systemd-boot](https://github.com/systemd/systemd) ⭐ 16k — C, UEFI boot manager with Secure Boot support
- [GRUB2](https://git.savannah.gnu.org/cgit/grub.git) — C, bootloader with UEFI Secure Boot chain verification
- [Android Verified Boot (AVB)](https://android.googlesource.com/platform/external/avb/) — C, Android dm-verity and vbmeta signing
- [dm-verity (Linux kernel)](https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html) — C, kernel block-level integrity verification via Merkle trees

**Security status:** Caution
Cryptography (RSA-2048/SHA-256 signatures) is sound; security depends on proper key management (PK/KEK/db); historical bypass vulnerabilities (e.g., BlackLotus bootkit, 2023) exploited dbx gaps — requires timely revocation list updates.

**Community acceptance:** Standard
UEFI Specification 2.10; TCG Measured Boot specification; Microsoft Windows Hardware Compatibility Program; AOSP Android Verified Boot; universally deployed on modern computing platforms.

---

## GlobalPlatform SCP03 — Smart Card Secure Channel Protocol

**Goal:** Establish an authenticated and encrypted command channel between an off-card entity (host application / card management system) and an on-card security domain (JavaCard applet / secure element), ensuring confidentiality and integrity of APDU commands and responses.

| Protocol | Year | Crypto | Note |
|----------|------|--------|------|
| **SCP01** | 2003 | 3DES-CBC + single MAC | Legacy; broken by CBC padding oracles |
| **SCP02** | 2006 | 3DES-CBC + C-MAC/R-MAC | Widely deployed; 112-bit effective security |
| **SCP03** | 2014 | AES-128/192/256-CBC + CMAC | Current standard; mandatory for GP 2.3+ [[1]](https://globalplatform.org/specs-library/globalplatform-card-specification-v2-3-1/) |
| **SCP11** | 2018 | ECDH (P-256) + AES + CMAC | Certificate-based mutual auth; TLS-like [[2]](https://globalplatform.org/specs-library/globalplatform-card-specification-v2-3-1/) |

**SCP03 key set (per security domain):**

| Key | Length | Purpose |
|-----|--------|---------|
| S-ENC | 16/24/32 bytes | Derives session encryption key (AES-CBC) |
| S-MAC | 16/24/32 bytes | Derives session C-MAC key (AES-CMAC) |
| S-RMAC | 16/24/32 bytes | Derives session R-MAC key (response MAC) |
| DEK (Key Encryption Key) | 16/24/32 bytes | Wraps sensitive data (e.g., new keys during PUT KEY) |

**SCP03 mutual authentication flow:**
```
Host → Card: INITIALIZE UPDATE (host challenge, 8 bytes)
Card → Host: card challenge (8 bytes) + card cryptogram (AES-CMAC)
  Session keys derived: KDF(static_key, host_challenge || card_challenge || counter)
Host → Card: EXTERNAL AUTHENTICATE (host cryptogram + C-MAC)
  // Now secure channel is established: all subsequent APDUs are C-MAC'd and optionally encrypted
```

**Security levels (OR'd bit flags):**
- `0x01` — C-MAC on commands
- `0x03` — C-MAC + C-DECRYPTION (encrypted command data)
- `0x33` — C-MAC + C-DECRYPTION + R-MAC + R-ENCRYPTION (full duplex encryption)

**Deployments:** SIM cards (GSMA SCP03 mandated for OTA), banking smart cards (EMV GP), government eID cards, eSE in smartphones (Google Titan M, Apple SE), secure elements for NFC payments, FIDO2 security keys (YubiKey uses SCP03 for management).

**State of the art:** GlobalPlatform Card Specification v2.3.1 (2018); SCP03 mandatory. SCP11 (ECDH-based) gaining traction for IoT provisioning. See [eSIM / Remote SIM Provisioning](#gsma-esim--remote-sim-provisioning-rsp), [PKCS#11 / Cryptoki](#pkcs11--cryptoki--hsm-c-api).

**Production readiness:** Production
SCP03 is mandatory for all GlobalPlatform 2.3+ compliant cards; deployed on billions of SIM cards, banking smart cards, government eID cards, and secure elements in smartphones.

**Implementations:**
- [OpenSC](https://github.com/OpenSC/OpenSC) ⭐ 3.0k — C, smart card middleware with GlobalPlatform support
- [YubiKey Manager](https://github.com/Yubico/yubikey-manager) ⭐ 1.1k — Python, YubiKey configuration (uses SCP03 for management)
- [pyscard](https://github.com/LudovicRousseau/pyscard) ⭐ 458 — Python, PC/SC smart card library for SCP03 communication

**Security status:** Secure
AES-128/256-CBC + CMAC is cryptographically sound; mutual authentication prevents unauthorized card management; SCP03 replaces legacy SCP02 (3DES) with modern symmetric primitives.

**Community acceptance:** Standard
GlobalPlatform Card Specification v2.3.1; mandated by GSMA for SIM card OTA management; deployed across banking, telecom, and government smart card ecosystems worldwide.

---

## Matter / Thread IoT Device Security (CASE/PASE)

**Goal:** Provide standardized, interoperable device authentication, commissioning, and secure messaging for smart home IoT devices — without relying on vendor-proprietary cloud services. Jointly developed by Apple, Google, Amazon, Samsung under the Connectivity Standards Alliance (CSA).

| Protocol | Phase | Crypto | Purpose |
|----------|-------|--------|---------|
| **PASE** (Passcode-Authenticated Session Establishment) | Commissioning | SPAKE2+ (NIST P-256) + HKDF-SHA-256 | First-touch pairing using 8-digit setup code (from QR/NFC) [[1]](https://csa-iot.org/developer-resource/specifications-download-request/) |
| **CASE** (Certificate-Authenticated Session Establishment) | Operational | Sigma-I protocol: ECDH (P-256) + ECDSA + HKDF + AES-CCM | Mutual auth using device attestation certificates (DAC) [[2]](https://csa-iot.org/developer-resource/specifications-download-request/) |
| **Group messaging** | Multicast | AES-128-CCM with epoch keys | Efficient group commands (e.g., "all lights off") [[3]](https://csa-iot.org/developer-resource/specifications-download-request/) |

**Matter PKI hierarchy:**
```
PAA (Product Attestation Authority) — root CA (CSA or vendor)
  └─ PAI (Product Attestation Intermediate) — per-vendor intermediate
       └─ DAC (Device Attestation Certificate) — per-device ECDSA P-256 cert
            └─ CD (Certification Declaration) — signed by CSA, binds vendor+product to certified firmware
```

**CASE (Sigma-I variant) handshake:**
```
Initiator → Responder: ephemeral ECDH pubkey, initiator random
Responder → Initiator: ephemeral ECDH pubkey, ECDSA sig over transcript, responder NOC cert
Initiator → Responder: ECDSA sig over transcript, initiator NOC cert
  Session keys: HKDF-SHA-256(ECDH_shared_secret, salts)
  Subsequent messages: AES-128-CCM encrypted
```

**NOC (Node Operational Certificate):** Issued by the fabric's root CA (e.g., Apple Home, Google Home). Contains fabric ID + node ID. Allows multi-admin: a device can hold NOCs from multiple fabrics simultaneously.

**Thread network layer:** IEEE 802.15.4 with AES-128-CCM at link layer; Thread 1.3 uses MLE (Mesh Link Establishment) with ECDH key exchange. Matter runs over Thread, Wi-Fi, or Ethernet — transport-agnostic.

**State of the art:** Matter 1.4 (2024); 3,000+ certified devices. Thread 1.3 (2023). PASE uses SPAKE2+ per NIST submission. See [SPAKE2 / PAKE](categories/03-key-exchange-key-management.md#pake--password-authenticated-key-exchange), [DICE](#dice--device-identifier-composition-engine).

**Production readiness:** Production
3,000+ Matter-certified devices from Apple, Google, Amazon, Samsung, and others; Thread 1.3 deployed in commercial smart home products; Matter 1.4 specification released 2024.

**Implementations:**
- [connectedhomeip](https://github.com/project-chip/connectedhomeip) ⭐ 8.7k — C++, official Matter SDK (Connectivity Standards Alliance)
- [OpenThread](https://github.com/openthread/openthread) ⭐ 3.9k — C, open-source Thread networking stack (Google)
- [ESP-IDF Matter](https://github.com/espressif/esp-matter) ⭐ 979 — C, Espressif Matter SDK for ESP32 microcontrollers
- [matter.js](https://github.com/project-chip/matter.js) ⭐ 762 — TypeScript, Matter protocol implementation for Node.js
- [Apple Home](https://developer.apple.com/homekit/) — Swift, Apple's Matter controller implementation

**Security status:** Secure
SPAKE2+ (NIST-approved PAKE), ECDSA P-256, ECDH, and AES-128-CCM are well-established primitives; Sigma-I-based CASE provides strong mutual authentication with forward secrecy.

**Community acceptance:** Standard
Connectivity Standards Alliance (CSA) specification; jointly developed by Apple, Google, Amazon, Samsung; Thread Group specification; 3,000+ certified devices; broad industry adoption.

---

## IEEE 802.1X / EAP-TLS — Port-Based Network Access Control

**Goal:** Authenticate devices before granting them access to a wired or wireless network. The switch/access point (authenticator) blocks all traffic from a port until the device (supplicant) proves its identity to a backend RADIUS/Diameter server using an EAP method — most commonly EAP-TLS with mutual X.509 certificate authentication.

| EAP Method | RFC | Crypto | Note |
|------------|-----|--------|------|
| **EAP-TLS** | RFC 5216 / RFC 9190 | Mutual TLS 1.2/1.3 with X.509 certs | Gold standard; no passwords; requires client cert PKI [[1]](https://www.rfc-editor.org/rfc/rfc9190) |
| **EAP-TTLS** | RFC 5281 | TLS tunnel + inner method (PAP/MSCHAPv2) | Server cert only; inner password auth [[2]](https://www.rfc-editor.org/rfc/rfc5281) |
| **PEAP** | Microsoft/Cisco | TLS tunnel + MSCHAPv2 | Similar to EAP-TTLS; widely deployed in enterprise Wi-Fi |
| **EAP-TLS 1.3** | RFC 9190 (2022) | TLS 1.3 (ECDHE + ECDSA/EdDSA) | Reduced round trips; encrypted client cert identity |
| **TEAP** | RFC 7170 | TLS tunnel + multiple inner EAPs | Successor to PEAP; supports chaining and provisioning |

**802.1X protocol flow:**
```
Supplicant ←── EAPOL ──► Authenticator (switch/AP) ←── RADIUS ──► Auth Server
   │                            │                              │
   ├─ EAP-Request/Identity ────►│                              │
   │◄─ EAP-Response/Identity ──┤──── Access-Request ──────────►│
   │   EAP-TLS handshake ◄─────┼───────────────────────────────┤
   │   (TLS ClientHello,       │   (RADIUS carries EAP)        │
   │    ServerHello, certs,    │                                │
   │    Finished)              │                                │
   │◄── EAP-Success ───────────┤◄── Access-Accept + MSK ───────┤
   │                            │                                │
   Port transitions: Unauthorized → Authorized
```

**Key derivation:** EAP-TLS exports a Master Session Key (MSK, 64 bytes) to the authenticator via RADIUS. For Wi-Fi (WPA2/3-Enterprise), the MSK becomes the PMK (Pairwise Master Key), feeding the 4-way handshake for per-session PTK derivation.

**Deployments:** Enterprise Wi-Fi (WPA2/WPA3-Enterprise); wired NAC in corporate/government networks; eduroam (global academic roaming uses EAP-TLS/EAP-TTLS + RADIUS federation); 5G (EAP-AKA' for SIM auth, RFC 9048).

**State of the art:** EAP-TLS 1.3 (RFC 9190, 2022) brings TLS 1.3 benefits (encrypted client identity, 0-RTT). WPA3-Enterprise 192-bit mode mandates EAP-TLS with Suite B (CNSA) ciphers. See [DANE](#dane--dns-based-authentication-of-named-entities), [FIDO2 / WebAuthn / Passkeys](#fido2--webauthn--passkeys).

**Production readiness:** Production
Deployed universally in enterprise wired/wireless networks; eduroam serves 100+ countries; WPA2/WPA3-Enterprise with EAP-TLS is the standard for corporate Wi-Fi; 5G uses EAP-AKA' for SIM authentication.

**Implementations:**
- [wpa_supplicant](https://w1.fi/wpa_supplicant/) — C, reference 802.1X supplicant for Linux/BSD/Windows
- [FreeRADIUS](https://github.com/FreeRADIUS/freeradius-server) ⭐ 2.5k — C, most widely deployed RADIUS server with full EAP support
- [hostapd](https://w1.fi/hostapd/) — C, IEEE 802.1X authenticator for access points
- [Radiator](https://www.open.com.au/radiator/) — Perl, commercial RADIUS server with EAP-TLS/TTLS/PEAP
- [NetworkManager](https://github.com/NetworkManager/NetworkManager) ⭐ 484 — C, Linux network manager with 802.1X/EAP configuration

**Security status:** Secure
EAP-TLS 1.3 provides mutual certificate authentication with forward secrecy; encrypted client identity prevents tracking; EAP-TTLS/PEAP with inner password methods are less secure but adequate with strong passwords.

**Community acceptance:** Standard
IETF RFCs 5216, 9190 (EAP-TLS), 5281 (EAP-TTLS); IEEE 802.1X-2020; Wi-Fi Alliance WPA3-Enterprise; eduroam global federation; universally deployed in enterprise networking.

---

## KMIP — Key Management Interoperability Protocol

**Goal:** Provide a standardized client-server protocol for managing cryptographic keys and associated objects (certificates, secrets, opaque data) across heterogeneous key management systems (KMS), HSMs, and consuming applications — eliminating vendor lock-in for key lifecycle operations.

| Version | Year | Organization | Key additions |
|---------|------|-------------|---------------|
| **KMIP 1.0** | 2010 | OASIS | Core object model, create/get/destroy operations [[1]](https://docs.oasis-open.org/kmip/kmip-spec/v2.1/os/kmip-spec-v2.1-os.html) |
| **KMIP 1.4** | 2014 | OASIS | Sensitive/extractable attributes, streaming, re-key |
| **KMIP 2.0** | 2019 | OASIS | JSON/XML encoding (in addition to TTLV), simplified profiles [[2]](https://docs.oasis-open.org/kmip/kmip-spec/v2.1/os/kmip-spec-v2.1-os.html) |
| **KMIP 2.1** | 2020 | OASIS | Log operations, enhanced query, quantum-safe readiness |
| **KMIP 3.0** | 2023 | OASIS | JOSE/JWT integration, PQC key types, improved access control [[3]](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=kmip) |

**Object types managed:**

| Object | Description |
|--------|-------------|
| Symmetric Key | AES, 3DES, HMAC keys |
| Public/Private Key | RSA, EC, Ed25519 |
| Certificate | X.509, PGP |
| Secret Data | Passwords, seeds |
| Opaque Data | Arbitrary blobs |
| PGP Key | OpenPGP key bundles |

**Key lifecycle operations:**
```
Create → Register → Get → Activate → [Re-key / Re-key Pair] → Deactivate → Destroy
                                  ↕
                           Locate / Check / GetAttributes
```

**Wire encoding (TTLV):** Default binary format: Tag (3 bytes, big-endian enum), Type (1 byte), Length (4 bytes), Value (padded to 8-byte boundary). Compact and deterministic — designed for HSM firmware parsers.

**Deployments:** Enterprise KMS (Thales CipherTrust, IBM SKLM, Fortanix, Entrust KeyControl); cloud KMS (IBM Cloud Key Protect, Dell PowerProtect); database TDE (Oracle, MongoDB); tape encryption (IBM TS7700); storage encryption (NetApp, Pure Storage). Mandated by FIPS 140-3 CMVP for KMS interop testing.

**State of the art:** KMIP 3.0 (2023) adds PQC key types (ML-KEM, ML-DSA) and JOSE interoperability. OASIS KMIP Profiles define compliance levels (Basic, Symmetric, Asymmetric, Storage). See [PKCS#11 / Cryptoki](#pkcs11--cryptoki--hsm-c-api), [HSM Key Ceremony](#hsm-key-ceremony--split-knowledge--dual-control).

**Production readiness:** Production
Deployed in enterprise KMS (Thales CipherTrust, IBM SKLM, Fortanix), cloud KMS, database TDE, and storage encryption systems; mandated by FIPS 140-3 CMVP for KMS interoperability.

**Implementations:**
- [PyKMIP](https://github.com/OpenKMIP/PyKMIP) ⭐ 299 — Python, reference KMIP client/server library
- [Barbican](https://github.com/openstack/barbican) ⭐ 248 — Python, OpenStack key management service with KMIP backend
- [HashiCorp Vault KMIP](https://www.vaultproject.io/docs/secrets/kmip) — Go, Vault secrets engine exposing KMIP interface
- [Thales CipherTrust Manager](https://cpl.thalesgroup.com/encryption/ciphertrust-manager) — Commercial, enterprise KMS with KMIP 2.1 compliance
- [libkmip](https://github.com/OpenKMIP/libkmip) ⭐ 44 — C, lightweight KMIP encoding library

**Security status:** Secure
KMIP itself is a management protocol; security depends on the underlying KMS/HSM implementation and TLS transport; KMIP 3.0 adds PQC key types for quantum readiness.

**Community acceptance:** Standard
OASIS KMIP specification (v1.0-3.0); KMIP Profiles define compliance testing; adopted by all major HSM and KMS vendors; FIPS 140-3 CMVP references KMIP for interoperability.

---

## X.509 Certificate Path Validation (RFC 5280)

**Goal:** Define a deterministic algorithm for validating a chain of X.509 certificates from a leaf (end-entity) certificate up to a trust anchor — checking signatures, validity periods, revocation status, name constraints, policy constraints, and key usage at each step. This algorithm is the foundation of all TLS, code signing, and S/MIME trust decisions.

| Validation check | RFC section | Failure mode prevented |
|-----------------|-------------|----------------------|
| **Signature verification** | 6.1.3 | Forged or tampered certificate [[1]](https://www.rfc-editor.org/rfc/rfc5280) |
| **Validity period** | 6.1.3(a)(2) | Expired or not-yet-valid cert |
| **Name Constraints** | 6.1.4(b-c) | Sub-CA issuing certs for unauthorized domains [[2]](https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.10) |
| **Key Usage / Extended Key Usage** | 6.1.4(b) | Cert used for wrong purpose (e.g., signing CA used as TLS server) |
| **Policy Constraints** | 6.1.4(e) | Disallowed certificate policy OIDs |
| **Basic Constraints (cA flag)** | 6.1.4(k) | Leaf cert misused as CA |
| **CRL / OCSP revocation** | 6.1.3(a)(3) | Revoked cert still trusted [[3]](https://www.rfc-editor.org/rfc/rfc6960) |
| **Authority Key Identifier** | 4.2.1.1 | Ambiguous issuer resolution |

**Name Constraints (critical extension):**
```
X509v3 Name Constraints: critical
    Permitted:
        DNS: .example.com          -- this CA may only issue for *.example.com
        RFC822: .example.com       -- and email addresses @example.com
    Excluded:
        DNS: .evil.example.com     -- but NOT this subdomain
        IP: 0.0.0.0/0              -- no IP SANs permitted
```

Name Constraints are the primary mechanism for technically scoping intermediate CAs. Enterprises issuing from a publicly trusted root can be constrained to only their domains.

**Path building vs. path validation:** RFC 5280 defines validation (given a chain, verify it). Path *building* — finding a valid chain from the leaf to a trust anchor when multiple chains are possible — is implementation-specific (OpenSSL, NSS, Go `x509`, Rust `rustls`). AIA (Authority Information Access) enables chain discovery via HTTP.

**Common implementation pitfalls:** Hostname mismatch (Subject CN vs. SAN); missing intermediate certificates; improper revocation checking (soft-fail vs. hard-fail OCSP); cross-signed roots causing loop or ambiguous paths.

**State of the art:** RFC 5280 (2008, Internet Standard); RFC 6818 (2013, updates). CA/Browser Forum Baseline Requirements v2.0 (2023) add stricter profile. Google Chrome implements "Chrome Root Program" with independent path validation. See [DANE](#dane--dns-based-authentication-of-named-entities), [Certificate Transparency](#certificate-transparency-ct), [OCSP Stapling](#ocsp-stapling-and-certificate-revocation).

**Production readiness:** Production
Foundation of all TLS, code signing, S/MIME, and VPN trust decisions; implemented in every browser, operating system, and TLS library; billions of certificate validations per day.

**Implementations:**
- [OpenSSL](https://github.com/openssl/openssl) ⭐ 29k — C, X.509 path validation in `X509_verify_cert()`
- [rustls/webpki](https://github.com/rustls/webpki) ⭐ 142 — Rust, memory-safe X.509 path validation library
- [Go x509](https://pkg.go.dev/crypto/x509) — Go, standard library X.509 certificate verification
- [Bouncy Castle](https://github.com/bcgit/bc-java) ⭐ 2.6k — Java, comprehensive X.509 path building and validation

**Security status:** Caution
Algorithm is well-defined (Internet Standard since 2008); security depends on correct implementation — common pitfalls include hostname mismatch, soft-fail OCSP, and missing intermediate certificates.

**Community acceptance:** Standard
IETF RFC 5280 (Internet Standard); CA/Browser Forum Baseline Requirements; implemented by every major TLS library and browser; foundational to the global WebPKI trust model.

---

## SPIFFE / SPIRE — Workload Identity Framework

**Goal:** Assign cryptographically verifiable identities to software workloads (containers, VMs, processes) without relying on network location, IP addresses, or application-level secrets. Enables mutual TLS between microservices with automatic certificate issuance and rotation — no manual PKI management.

| Component | Function | Standard |
|-----------|----------|----------|
| **SPIFFE** (Secure Production Identity Framework for Everyone) | Identity specification: URI-based identity (SPIFFE ID) + document formats (SVID) | SPIFFE Spec v1.0 (CNCF) [[1]](https://spiffe.io/docs/latest/spiffe-about/overview/) |
| **SPIRE** (SPIFFE Runtime Environment) | Reference implementation: server (CA + registration API) + agent (node attestor + workload API) | CNCF Graduated project [[2]](https://github.com/spiffe/spire) |
| **X509-SVID** | X.509 certificate with SPIFFE ID in SAN URI | Primary SVID format [[3]](https://github.com/spiffe/spiffe/blob/main/standards/X509-SVID.md) |
| **JWT-SVID** | Signed JWT with `sub` = SPIFFE ID | For non-TLS contexts (HTTP headers, gRPC metadata) |

**SPIFFE ID format:**
```
spiffe://trust-domain/path
spiffe://production.example.com/payment-service/backend
spiffe://cluster.local/ns/default/sa/web-frontend
```

**SPIRE attestation chain:**
```
SPIRE Server (CA)
  └─ Node Attestation: verify platform identity
       AWS: instance identity document (PKCS#7 signed by AWS)
       K8s: projected service account token (bound to pod)
       Azure: MSI token; GCP: instance metadata
  └─ Workload Attestation: verify process identity
       K8s: pod labels, service account, namespace
       Unix: PID, UID, GID, binary path/hash
       Docker: container ID, image hash
  └─ Issue X509-SVID (short-lived: 1h default, auto-rotated)
```

**mTLS with SPIFFE:**
```
Service A (X509-SVID: spiffe://prod/svc-a) ◄─── mTLS ───► Service B (X509-SVID: spiffe://prod/svc-b)
  Both sides validate: (1) cert signature chains to SPIRE CA, (2) SAN URI matches authorized SPIFFE ID
```

**Deployments:** Kubernetes service meshes (Istio uses SPIFFE IDs natively); HashiCorp Consul Connect; Pinterest, Uber, Bloomberg, ByteDance (production workload identity); CNCF graduated project (2022). Integrates with Envoy Proxy (SDS API serves SVIDs).

**State of the art:** SPIFFE v1.0 (2024 CNCF standard). SPIRE v1.9 (2024); supports nested SPIRE topologies for multi-cluster. Federation allows cross-trust-domain authentication. See [PKCS#11 / Cryptoki](#pkcs11--cryptoki--hsm-c-api), [ACME Protocol](categories/03-key-exchange-key-management.md#acme-protocol--automated-certificate-management).

**Production readiness:** Production
CNCF Graduated project (2022); deployed in production at Pinterest, Uber, Bloomberg, ByteDance; Istio uses SPIFFE IDs natively for service mesh mTLS.

**Implementations:**
- [SPIRE](https://github.com/spiffe/spire) ⭐ 2.3k — Go, reference SPIFFE runtime environment (CNCF Graduated)
- [spiffe-helper](https://github.com/spiffe/spiffe-helper) ⭐ 71 — Go, sidecar for fetching and rotating SVIDs
- [go-spiffe](https://github.com/spiffe/go-spiffe) ⭐ 189 — Go, SPIFFE client library for workload API
- [java-spiffe](https://github.com/spiffe/java-spiffe) ⭐ 43 — Java, SPIFFE workload API client library
- [Istio](https://github.com/istio/istio) ⭐ 38k — Go, service mesh with native SPIFFE identity integration

**Security status:** Secure
X509-SVIDs use standard ECDSA P-256 certificates with short lifetimes (1h default, auto-rotated); node and workload attestation provide defense-in-depth; no known cryptographic weaknesses.

**Community acceptance:** Standard
CNCF Graduated project; SPIFFE specification v1.0; adopted by Istio, Consul Connect, and Envoy Proxy; deployed by major technology companies in production.

---

## Arm PSA Certified / Platform Security Architecture

**Goal:** Define a standardized security architecture for Arm-based microcontrollers (Cortex-M) and application processors — specifying a hardware Root of Trust (RoT), secure boot, cryptographic services API, attestation, and secure storage. Enables IoT device manufacturers to build on a certified security foundation without designing custom trusted firmware from scratch.

| Component | Layer | Function |
|-----------|-------|----------|
| **PSA-RoT (Root of Trust)** | Hardware + immutable firmware | Secure boot anchor, entropy source, isolation boundary [[1]](https://www.psacertified.org/getting-certified/silicon/) |
| **PSA Crypto API** | Firmware | Portable C API for symmetric/asymmetric crypto, key management, hash, MAC, AEAD, key derivation [[2]](https://arm-software.github.io/psa-api/crypto/1.2/) |
| **PSA Attestation** | Firmware service | Entity Attestation Token (EAT, CBOR/COSE-signed) reporting device identity, firmware version, security lifecycle [[3]](https://arm-software.github.io/psa-api/attestation/1.0/) |
| **PSA Secure Storage** | Firmware service | Encrypted + authenticated storage with rollback protection (Internal Trusted Storage + Protected Storage) |
| **TF-M (Trusted Firmware-M)** | Reference implementation | Open-source secure partition manager for Cortex-M (ARMv8-M TrustZone) [[4]](https://www.trustedfirmware.org/projects/tf-m/) |

**PSA Crypto API (key operations):**
```c
psa_key_attributes_t attr = PSA_KEY_ATTRIBUTES_INIT;
psa_set_key_type(&attr, PSA_KEY_TYPE_ECC_KEY_PAIR(PSA_ECC_FAMILY_SECP_R1));
psa_set_key_bits(&attr, 256);
psa_set_key_usage_flags(&attr, PSA_KEY_USAGE_SIGN_HASH | PSA_KEY_USAGE_VERIFY_HASH);
psa_set_key_algorithm(&attr, PSA_ALG_ECDSA(PSA_ALG_SHA_256));

psa_key_id_t key_id;
psa_generate_key(&attr, &key_id);   // key never leaves RoT
psa_sign_hash(key_id, PSA_ALG_ECDSA(PSA_ALG_SHA_256), hash, 32, sig, sizeof(sig), &sig_len);
```

**PSA Attestation Token (IAT):**

| Claim | Content |
|-------|---------|
| Instance ID | SHA-256 of attestation public key (unique per device) |
| Implementation ID | Identifies firmware implementation |
| Security Lifecycle | Assembly / PSA-RoT provisioning / Secured / Non-PSA-RoT debug / Recoverable / Decommissioned |
| Boot Seed | Random value per boot cycle |
| Software Components | Array of: measurement (hash), signer ID, version |

Token is COSE_Sign1 (ECDSA P-256 or P-384), verifiable by a remote attestation service.

**PSA Certified levels:**

| Level | Assurance | Evaluation |
|-------|-----------|------------|
| Level 1 | Security questionnaire + PSA-RoT design review | Self-assessed |
| Level 2 | Lab evaluation: software attack resistance | Third-party lab |
| Level 3 | Lab evaluation: hardware attack resistance (side-channel, fault injection) | Third-party lab |

**Deployments:** Nordic Semiconductor (nRF9160, nRF5340), STMicroelectronics (STM32L5, STM32U5), NXP (LPC55S69), Infineon (PSoC 64), Raspberry Pi Pico (RP2350 with Arm TrustZone). Mbed TLS implements the PSA Crypto API. Over 200 PSA Certified products.

**State of the art:** PSA Crypto API 1.2 (2024); PSA Attestation API 1.0; TF-M v2.1 (2024). PSA Certified scheme recognized by ETSI EN 303 645 (European IoT cybersecurity standard). See [DICE](#dice--device-identifier-composition-engine), [TEE Remote Attestation](#tee-remote-attestation), [TPM 2.0](#tpm-20--trusted-platform-module).

**Production readiness:** Production
Over 200 PSA Certified products; deployed on Nordic Semiconductor, STMicroelectronics, NXP, Infineon, and Raspberry Pi platforms; TF-M is the reference implementation for Cortex-M TrustZone.

**Implementations:**
- [Mbed TLS](https://github.com/Mbed-TLS/mbedtls) ⭐ 6.6k — C, implements PSA Crypto API as primary interface
- [Zephyr RTOS](https://github.com/zephyrproject-rtos/zephyr) ⭐ 14k — C, RTOS with PSA Crypto API and TF-M integration

**Security status:** Secure
PSA Crypto API wraps well-established algorithms (ECDSA P-256, AES-GCM, SHA-256) with hardware-backed key isolation; PSA Certified Level 3 requires resistance to hardware side-channel and fault injection attacks.

**Community acceptance:** Standard
Arm PSA Certified scheme; recognized by ETSI EN 303 645 (EU IoT cybersecurity standard); PSA Crypto API implemented by Mbed TLS; over 200 certified products from major silicon vendors.

---

## Merkle Tree Certificates (MTC)

**Goal:** Replace per-site X.509 certificates with cryptographic inclusion proofs in a batch-issued Merkle tree, enabling certificates under 1,000 bytes while natively integrating Certificate Transparency and accommodating post-quantum signature sizes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **MTC (David Benjamin, Google)** | 2023 | Merkle tree inclusion proofs | Amortizes CA signature across millions of certificates; IETF PLANTS WG [[1]](https://datatracker.ietf.org/doc/draft-ietf-plants-merkle-tree-certs/) |
| **Cloudflare experimental deployment** | 2025 | MTC + Chrome | First production test of Merkle Tree Certificates [[1]](https://blog.cloudflare.com/bootstrap-mtc/) |

**State of the art:** PQ signatures (ML-DSA ~2.4 KB) would balloon TLS handshakes. MTC amortizes that cost. Short-lived certificates (hours) eliminate OCSP/CRL. Could replace the WebPKI certificate format unchanged since the 1990s.

**Production readiness:** Experimental
Cloudflare published first experimental deployment with Chrome (2025); IETF PLANTS WG actively drafting specification; no production WebPKI deployment yet.

**Implementations:**
- [Cloudflare MTC experimental](https://blog.cloudflare.com/bootstrap-mtc/) — Go, first experimental MTC deployment
- [IETF PLANTS WG draft](https://datatracker.ietf.org/doc/draft-ietf-plants-merkle-tree-certs/) — Specification, active IETF working group draft

**Security status:** Caution
Merkle tree cryptography (SHA-256) is sound; the scheme is designed to accommodate PQ signatures efficiently, but the specification is not finalized and has not undergone extensive production security review.

**Community acceptance:** Emerging
IETF PLANTS WG active draft; Google (original proposal by David Benjamin) and Cloudflare leading experimental deployment; strong interest from WebPKI community for PQ transition.

---

## RPKI — Resource Public Key Infrastructure

**Goal:** Cryptographically bind IP address blocks and AS numbers to their legitimate holders using X.509 certificates anchored at Regional Internet Registries, enabling BGP routers to reject route hijacks via Route Origin Validation (ROV).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RPKI (RFC 6480)** | 2012 | X.509 hierarchy, RIR trust anchors | Five RIRs serve as trust anchors for IP address resource certification [[1]](https://rpki.readthedocs.io/en/latest/rpki/securing-bgp.html) |
| **ROV enforcement** | 2018+ | BGP + RPKI validation | Cloudflare, AT&T, European ISPs enforce invalid-route rejection [[1]](https://blog.cloudflare.com/rpki/) |

**State of the art:** Only deployed Internet-scale defense against BGP route hijacking. Distinct from WebPKI — purpose-built PKI for Internet routing infrastructure.

**Production readiness:** Production
Majority of global routing table is ROA-covered; enforced by Cloudflare, AT&T, and European ISPs; all five Regional Internet Registries operate RPKI trust anchors.

**Implementations:**
- [Routinator](https://github.com/NLnetLabs/routinator) ⭐ 556 — Rust, RPKI relying party software (NLnet Labs)
- [Fort Validator](https://github.com/NICMx/FORT-validator) ⭐ 60 — C, RPKI validation tool (LACNIC)
- [rpki-client](https://github.com/rpki-client/rpki-client-portable) ⭐ 67 — C, OpenBSD RPKI validator
- [Krill](https://github.com/NLnetLabs/krill) ⭐ 357 — Rust, RPKI Certificate Authority daemon
- [RIPE NCC RPKI Dashboard](https://rpki.ripe.net/) — Web, RPKI monitoring and ROA management

**Security status:** Secure
X.509 certificate hierarchy anchored at RIRs with RSA-2048/SHA-256 signatures is cryptographically sound; ROV enforcement prevents BGP route hijacking when widely deployed.

**Community acceptance:** Standard
IETF RFCs 6480, 6482, 6487, 8210, 8205; MANRS (Mutually Agreed Norms for Routing Security) promotes RPKI adoption; mandated by several national network operators and IXPs.

---

## CMP — Certificate Management Protocol (with Lightweight CMP)

**Goal:** Full-featured PKI management protocol for enrolling, updating, and revoking X.509 certificates in industrial, automotive, and IoT environments where ACME's HTTPS model is unsuitable.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CMP (RFC 4210 / RFC 9480)** | 2005/2023 | Full PKI lifecycle | Enrollment, renewal, revocation for OT/automotive environments [[1]](https://www.rfc-editor.org/rfc/rfc9480.html) |
| **Lightweight CMP (RFC 9483)** | 2023 | CoAP transport | Targets constrained IoT over CoAP; mandated by UNECE WP.29 for automotive [[1]](https://www.rfc-editor.org/rfc/rfc9483.html) |
| **CMP with PQ KEM (RFC 9810)** | 2025 | Post-quantum support | First PKI enrollment protocol with PQ key support [[1]](https://www.rfc-editor.org/rfc/rfc9810.html) |

**State of the art:** CMP is the dominant protocol for PKI in operational technology, automotive, and telecom. ACME is for web; CMP is for everything else.

**Production readiness:** Production
CMP v3 (RFC 9480) deployed in automotive (UNECE WP.29), telecom, and industrial PKI; Lightweight CMP (RFC 9483) targets constrained IoT devices; PQ support via RFC 9810.

**Implementations:**
- [EJBCA](https://github.com/Keyfactor/ejbca-ce) ⭐ 896 — Java, enterprise CA with full CMP v3 support
- [openxpki](https://github.com/openxpki/openxpki) ⭐ 672 — Perl, enterprise PKI with CMP enrollment
- [CMPforOpenSSL](https://github.com/mpeylo/cmpossl) ⭐ 38 — C, CMP client/server implementation for OpenSSL
- [Siemens LightweightCMP](https://github.com/siemens/LightweightCmpRa) ⭐ 11 — Java, Lightweight CMP Registration Authority
- [cryptlib](https://www.cs.auckland.ac.nz/~pgut001/cryptlib/) — C, portable crypto library with CMP support

**Security status:** Secure
CMP uses CMS-signed ASN.1 messages with certificate-based or MAC-based protection; security depends on transport security (TLS/CoAP-DTLS) and proper CA configuration.

**Community acceptance:** Standard
IETF RFCs 4210, 9480 (CMP v3), 9483 (Lightweight CMP), 9810 (PQ KEM); mandated by UNECE WP.29 for automotive cybersecurity; adopted by telecom and industrial PKI vendors.

---
