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

---
