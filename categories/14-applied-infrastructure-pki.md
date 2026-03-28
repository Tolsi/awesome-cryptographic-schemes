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

---

## Cryptographic Provenance Attestation (C2PA / SLSA)

**Goal:** Prove the origin, integrity, and chain of custody of digital artifacts. Cryptographically signed metadata binds content to its creator, creation tool, and transformation history — combating deepfakes, supply chain attacks, and misinformation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **C2PA (Coalition for Content Provenance)** | 2021 | X.509 + COSE signatures | Sign image/video/audio metadata at creation; camera → edit → publish chain [[1]](https://c2pa.org/specifications/specifications/2.1/specs/C2PA_Specification.html) |
| **SLSA (Supply-chain Levels for Software Artifacts)** | 2021 | Sigstore + attestation | Cryptographic provenance for software builds: source → build → deploy [[1]](https://slsa.dev/) |
| **Content Credentials (Adobe/Leica)** | 2023 | C2PA + hardware signing | Camera signs image at capture time; edit chain preserved through Adobe tools [[1]](https://contentcredentials.org/) |

**State of the art:** C2PA v2.1 (media), SLSA v1.0 (software); deployed by Adobe, Leica, Google, Microsoft. Related to [Linked Timestamping](#linked-timestamping) and [Digital Signatures](#digital-signatures).

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

---
