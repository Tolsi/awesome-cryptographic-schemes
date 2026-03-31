# Repository Structure

## Overview

This is a curated reference for cryptographic schemes, protocols, and primitives. Content is organized into 21 thematic category files under `categories/`, with a flat alphabetical index in `INDEX.md` and a categorized table of contents in `README.md`.

## File Layout

```
README.md                          — Entry point: categorized TOC + contributing/license
INDEX.md                           — Alphabetical index of all ~243 sections
CLAUDE.md                          — This file
categories/
  01-foundational-primitives.md
  02-authenticated-structured-encryption.md
  03-key-exchange-key-management.md
  04-zero-knowledge-proof-systems.md
  05-secret-sharing-threshold-cryptography.md
  06-multi-party-computation.md
  07-homomorphic-functional-encryption.md
  08-signatures-advanced.md
  09-commitments-verifiability.md
  10-privacy-preserving-computation.md
  11-anonymity-credentials.md
  12-secure-communication-protocols.md
  13-blockchain-distributed-ledger.md
  14-applied-infrastructure-pki.md
  15-quantum-cryptography.md
  16-obfuscation-advanced-hardness.md
  17-ai-hardware-physical-security.md
  18-covert-channels-steganography.md
  19-theoretical-foundations.md
  20-applied-niche-protocols.md
  21-regional-national-cryptography.md
```

## Scheme Entry Format

Each scheme/protocol appears as a `##` section inside exactly one category file. The format is:

```markdown
## Scheme Name

**Goal:** One-sentence plain-language purpose.

| Column1 | Column2 | ... |
|---------|---------|-----|
| **Scheme** | Year | Description [[1]](url) |

**State of the art:** Brief description of what is deployed/best today. Cross-links to related sections.

---
```

### Column conventions

- **Foundational / symmetric schemes:** `| Algorithm | Year | Type/Basis | Note |`
- **Protocol schemes:** `| Scheme | Year | Basis | Note |`
- Use `**bold**` for scheme/algorithm name in the first column.
- Citations use inline footnote style: `[[1]](url)` — numbered per row, restarting at 1 per row (not globally).
- Year is the publication/standardization year (use `—` if not applicable).

### Mandatory assessment fields

Every `##` section MUST include the following fields after the table and "State of the art" line:

```markdown
**Production readiness:** <One of: Production / Mature / Experimental / Research / Deprecated>
<Brief explanation — e.g. "Deployed in TLS 1.3 on all major browsers" or "Academic prototype only, no production use">

**Implementations:** <List of notable open-source implementations with URLs>
- [Library/tool name](url) ⭐ <star count> — language, brief note
- [Library/tool name](url) ⭐ <star count> [archived] — language, brief note  *(if repo is archived on GitHub)*

**Security status:** <One of: Secure / Caution / Broken / Superseded>
<Brief explanation — known attacks, parameter recommendations, or reason for deprecation>

**Community acceptance:** <One of: Standard / Widely trusted / Emerging / Niche / Controversial>
<Brief explanation — standardization body endorsement, peer review status, adoption by major organizations, notable endorsements or criticisms from cryptographers>
```

### Star counts in implementations

Every GitHub repository link in the **Implementations:** section MUST include a star count badge in the format `⭐ <count>` placed between the link and the em-dash description:

```markdown
- [Library](https://github.com/owner/repo) ⭐ 29k — language, note
```

Star count formatting:
- `< 1000`: show exact number (e.g. `⭐ 843`)
- `1000–9999`: one decimal (e.g. `⭐ 2.1k`)
- `≥ 10000`: no decimal (e.g. `⭐ 29k`)

Non-GitHub links (GitLab, Bitbucket, official sites, etc.) do not require star counts. Star counts should be periodically updated using the script in `scripts/update_stars.sh`.

### Archived repository marker

If a GitHub repository is archived (read-only), add `[archived]` between the star count and the em-dash:

```markdown
- [Library](https://github.com/owner/repo) ⭐ 126 [archived] — language, note
```

This signals that the code is no longer maintained. Check archive status via the GitHub API (`isArchived` field) or the repository page.

Field value definitions:

**Production readiness** levels:
- `Production` — deployed at scale in real-world systems (TLS, Signal, Ethereum, etc.)
- `Mature` — well-studied, production-quality implementations exist, but limited large-scale deployment
- `Experimental` — working implementations but not yet battle-tested or standardized
- `Research` — academic/prototype stage, no production-quality implementations
- `Deprecated` — was once used but now superseded or discouraged

**Security status** levels:
- `Secure` — no known practical attacks at recommended parameters
- `Caution` — secure at recommended parameters but requires careful implementation or has known edge cases
- `Broken` — practical attacks exist; should not be used
- `Superseded` — technically secure but replaced by better alternatives

**Community acceptance** levels:
- `Standard` — NIST, IETF RFC, ISO, or equivalent standardization
- `Widely trusted` — strong peer review, broad adoption, endorsed by major cryptographers
- `Emerging` — active standardization or growing adoption, positive expert reception
- `Niche` — well-studied but limited to specific domains or communities
- `Controversial` — disputed security claims, patent issues, or community disagreement

## Cross-References

Sections cross-reference each other using Markdown anchor links of the form:

```markdown
[Section Name](#scheme-name)
```

GitHub slugifies anchors by: lowercasing, replacing spaces with hyphens, dropping characters that are not alphanumeric, hyphens, or underscores. Parentheses and slashes are removed (not replaced with hyphens), so `## Foo (Bar) / Baz` becomes `#foo-bar-baz` (single hyphens, not double). For links across files:

```markdown
[Section Name](NN-filename.md#section-name-slug)
```

Note: files inside `categories/` link to sibling files using just the filename (e.g. `07-homomorphic-functional-encryption.md#section`), NOT `categories/07-...`. Files at the repo root (README.md, INDEX.md) use the full path `categories/NN-filename.md#section`.

### Link validation

All internal cross-reference links MUST point to valid anchors in existing files. Before committing changes that add, move, or rename `##` sections:

1. Verify that all links pointing TO the changed section are updated.
2. Verify that all links FROM the changed section still resolve.
3. When moving a section to another file, update all cross-references across the repo.

A validation script can be run with: `python3 scripts/validate_links.py` (if available).

## Adding a New Scheme

1. Identify the most appropriate category file (or propose a new one if none fits).
2. **Check for duplicates:** search all category files for the scheme name before adding. Each scheme MUST appear in exactly ONE category file. If a related section exists elsewhere, add a cross-reference instead of duplicating.
3. Add a new `##` section following the entry format above.
4. Add a corresponding row to `INDEX.md` in alphabetical order.
5. Add a cross-reference from related sections where useful.
6. If creating a new category file, add it to `README.md`'s Contents list and update `CLAUDE.md`.

### No duplicates rule

Every `##` scheme section MUST exist in exactly one category file. **Never duplicate a section across files.** If a scheme is relevant to multiple categories, place it in the most specific one and add a cross-reference from the other:

```markdown
> **Scheme Name** is covered in [Category — Scheme Name](NN-filename.md#scheme-name-slug).
```

## Category Summaries

| # | File | Contents |
|---|------|----------|
| 01 | foundational-primitives | Symmetric enc, PKE, hash, MAC, sigs, PRF/PRP, PRG, extractors, fuzzy extractors, OTP, trapdoor functions, UHF, CI-hash, UOWHF, sponge, lightweight crypto, ZK-friendly hash, FO transform, puncturable PRF, KH-PRF, Ristretto255, DRBG, batch verification |
| 02 | authenticated-structured-encryption | AEAD, key-committing AEAD, KEM/DEM, FPE, disk encryption, OPE/ORE, deterministic enc, updatable enc, rerandomizable enc, signcryption, non-committing enc, honey enc, PPE, puncturable enc, secure dedup, white-box crypto |
| 03 | key-exchange-key-management | DH/ECDH/X25519, PAKE/KDF, HD keys (BIP32), key wrapping, NIKE, certificateless, CT, ACME, JOSE/JWT, key transparency, updatable CRS, PHE, SLIP-39 |
| 04 | zero-knowledge-proof-systems | ZK proofs, SNARGs, IOP/PCP, Sigma protocols, Groth-Sahai, folding, lookup arguments, sumcheck, zkVMs, PCD, MPCitH, VOLEitH, binary-field, distributed SNARKs, zkML, compressed Sigma, ZK sets, witness PRF, malleable NIZK, WI/witness hiding, concurrent ZK, MIP, zkTLS |
| 05 | secret-sharing-threshold-cryptography | SSS, threshold decryption, PVSS, DKG, proactive SS, packed SS, robust SS, ramp SS, general access structure, AVSS, NIDKG, universal thresholdizer, leakage-resilient SS, traceable SS, unclonable SS, evolving SS, cheater detection, VID, accountable decryption |
| 06 | multi-party-computation | MPC, OT, garbled circuits, SecAgg, FSS/DPF, HSS, OLE/VOLE, silent OT/PCG, covert MPC, async BFT/MPC, fluid MPC, YOSO, secret-shared shuffle, garbled RAM, DPRF, streaming MPC, mental poker |
| 07 | homomorphic-functional-encryption | HE (FHE/SHE/PHE), multi-key/threshold FHE, verifiable FHE, ABE/FE, IBE, multi-authority ABE, RBE, anonymous IBE, broadcast enc, ACE, matchmaking enc, key-aggregate enc, PRE, transciphering, HVE |
| 08 | signatures-advanced | TSS, blind sigs, ring/group sigs, adaptor sigs, OTS, ABS, sanitizable, homomorphic, SPS, rerandomizable, forward-secure, sequential aggregate, accountable multi-sig, partially blind, BLS aggregate, linkable ring, threshold blind, constrained, designated verifier, undeniable, fail-stop, proxy, traceable, ring VRF, threshold ring, TESLA, IBS |
| 09 | commitments-verifiability | Commitment schemes, VRF, VDF, VC, non-malleable enc/commitments, chameleon hash, vector commitments, functional commitments, verifiable timed commitments, commit-reveal, homomorphic hashing, SSB hash, PoR/PDP, accumulators, randomness beacons, MMR, verifiable encryption, time-lock puzzles, proof of solvency, delay encryption |
| 10 | privacy-preserving-computation | PSI, PSU, set difference, ORAM, PIR, SSE/PEKS, OPRF, OKVS, oblivious sorting, PFE, OMR, ODoH, FPSI, private proximity, heavy hitters, PSA, PPRL, differential privacy, Prio/VDAF, sealed-bid auctions, OPE, FMD, graph encryption, oblivious automata, oblivious SQL, CDS |
| 11 | anonymity-credentials | Anonymous credentials, mixnets, onion routing, DC-nets, Privacy Pass, secret handshakes, Semaphore/RLN, delegatable creds, KVAC, e-cash, anonymous broadcast enc, anonymous reputation, stealth addresses, group encryption |
| 12 | secure-communication-protocols | Secure channels, Double Ratchet, CGKA/MLS, X3DH, DTLS, IKEv2/IPsec, OpenPGP, QUIC, BIP 324, Apple PQ3, KEMTLS, ECH, EAP-PWD, message franking, group key agreement, TOTP/FIDO2/WebAuthn, DKIM |
| 13 | blockchain-distributed-ledger | PoW/PoSpace, DAS, encrypted mempools, Casper FFG, Taproot, MimbleWimble, confidential transactions, range proofs, fair exchange/atomic swaps, IBC, EIP-712, HotStuff/Tendermint, secret leader election, order-fair consensus |
| 14 | applied-infrastructure-pki | DID/VCs, DANE, TEE attestation, EMV, Kerberos, DNSSEC, SSHFP/TLSA/SMIMEA, Sigstore, TUF, C2PA/SLSA |
| 15 | quantum-cryptography | QKD, quantum money/tokens, quantum copy-protection, position-based QC, certified quantum randomness, PQC (ML-KEM, ML-DSA, SLH-DSA, PQ-ZK, hybrid KEM), isogeny-based crypto, LIP/HAWK, equivalence-based PQ sigs |
| 16 | obfuscation-advanced-hardness | iO, multilinear maps, laconic crypto, BARG/accumulation, witness encryption, dual-mode cryptosystems, spooky encryption, point function obfuscation |
| 17 | ai-hardware-physical-security | zkLLM/verifiable AI inference, AI watermarking/pseudorandom codes, in-sensor crypto, PUF, encrypted control systems, wiretap channel, proof of location |
| 18 | covert-channels-steganography | Steganography, digital watermarking/fingerprinting, kleptography/ASA, deniable encryption, deniable authentication |
| 19 | theoretical-foundations | Leakage-resilient crypto, circular/KDM security, non-malleable codes, WI/witness hiding, non-black-box ZK/concurrent ZK, rational cryptography, human-computable crypto, cryptographic reverse firewalls, lossy encryption/TDF |
| 20 | applied-niche-protocols | E-voting, visual cryptography, linked timestamping, coercion-resistant voting, PoSE, key-insulated crypto, client puzzles, incremental cryptography |
| 21 | regional-national-cryptography | SM4/SM3/SM2 (China), GOST R 34.12/34.11/34.10 (Russia), ARIA/SEED/LSH (South Korea), Camellia-GCM/ARIA-GCM, CLEFIA/MISTY1 (Japan) |
