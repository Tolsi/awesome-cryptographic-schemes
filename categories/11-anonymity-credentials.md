# Anonymity & Credentials


<!-- TOC -->
## Contents (54 schemes)

- [Anonymous Credentials](#anonymous-credentials)
- [Mix Networks (Mixnets)](#mix-networks-mixnets)
- [Onion Routing](#onion-routing)
- [DC-Nets (Dining Cryptographers Networks)](#dc-nets-dining-cryptographers-networks)
- [Privacy Pass / Anonymous Tokens](#privacy-pass-anonymous-tokens)
- [Secret Handshakes / Hidden Credentials](#secret-handshakes-hidden-credentials)
- [Semaphore / Anonymous Group Signaling (RLN)](#semaphore-anonymous-group-signaling-rln)
- [Delegatable Anonymous Credentials](#delegatable-anonymous-credentials)
- [Keyed-Verification Anonymous Credentials (KVAC)](#keyed-verification-anonymous-credentials-kvac)
- [E-Cash / Chaumian Digital Cash](#e-cash-chaumian-digital-cash)
- [Anonymous Broadcast Encryption](#anonymous-broadcast-encryption)
- [Anonymous Reputation Systems](#anonymous-reputation-systems)
- [Stealth Addresses](#stealth-addresses)
- [Coconut Credentials](#coconut-credentials)
- [Tor v3 Onion Services](#tor-v3-onion-services)
- [I2P (Invisible Internet Project)](#i2p-invisible-internet-project)
- [GNU Taler](#gnu-taler)
- [Zcash Shielded Protocols (Sapling / Orchard)](#zcash-shielded-protocols-sapling-orchard)
- [BBS+ Anonymous Credentials](#bbs-anonymous-credentials)
- [Monero's Privacy Stack](#moneros-privacy-stack)
- [CoinJoin / WabiSabi](#coinjoin-wabisabi)
- [Privacy Pools](#privacy-pools)
- [Group Encryption](#group-encryption)
- [Direct Anonymous Attestation (DAA)](#direct-anonymous-attestation-daa)
- [Accumulators for Credential Revocation](#accumulators-for-credential-revocation)
- [IRMA / Yivi Credential System](#irma-yivi-credential-system)
- [ZKP-Based Attribute Predicates (Range Proofs for Credentials)](#zkp-based-attribute-predicates-range-proofs-for-credentials)
- [SD-JWT and JSON Web Proof (JWP)](#sd-jwt-and-json-web-proof-jwp)
- [OpenID for Verifiable Credentials (OID4VC)](#openid-for-verifiable-credentials-oid4vc)
- [EU EUDI Wallet Cryptographic Architecture (eIDAS 2.0)](#eu-eudi-wallet-cryptographic-architecture-eidas-20)
- [mDL (Mobile Driver's License, ISO 18013-5)](#mdl-mobile-drivers-license-iso-18013-5)
- [Selective Disclosure Credential Formats Compared](#selective-disclosure-credential-formats-compared)
- [Anonymous Credentials vs Group Signatures vs Ring Signatures](#anonymous-credentials-vs-group-signatures-vs-ring-signatures)
- [Anonymous Whistleblowing Systems](#anonymous-whistleblowing-systems)
- [Private Communication with Metadata Protection](#private-communication-with-metadata-protection)
- [Aztec Protocol (Private Smart Contracts)](#aztec-protocol-private-smart-contracts)
- [Browser Fingerprinting and Anonymity Defenses](#browser-fingerprinting-and-anonymity-defenses)
- [Nym Network](#nym-network)
- [Katzenpost](#katzenpost)
- [Riffle](#riffle)
- [Riposte](#riposte)
- [Pung](#pung)
- [Express](#express)
- [Talek](#talek)
- [Karaoke](#karaoke)
- [Traffic Analysis Attacks and Cover Traffic Defenses](#traffic-analysis-attacks-and-cover-traffic-defenses)
- [Oblivious Pseudorandom Functions (OPRF / VOPRF / POPRF)](#oblivious-pseudorandom-functions-oprf-voprf-poprf)
- [Group Signatures with Verifier-Local Revocation (VLR)](#group-signatures-with-verifier-local-revocation-vlr)
- [zkSNARK-Based Anonymous Credentials](#zksnark-based-anonymous-credentials)
- [Signal KVAC v2 (zkgroup)](#signal-kvac-v2-zkgroup)
- [CBDC Privacy Architectures](#cbdc-privacy-architectures)
- [Post-Quantum Anonymous Credentials](#post-quantum-anonymous-credentials)
- [Credential Status Mechanisms (Revocation Transparency)](#credential-status-mechanisms-revocation-transparency)
- [Anonymous Multi-Hop Locks (AMHL)](#anonymous-multi-hop-locks-amhl)
<!-- /TOC -->

## Anonymous Credentials

**Goal:** Selective disclosure + unlinkability. Prove possession of attributes (age, nationality, membership) without revealing identity or linking multiple presentations. Used in digital IDs, privacy-preserving access control.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CL Signatures (Camenisch-Lysyanskaya)** | 2001 | RSA-based | Show any subset of signed attributes in ZK [[1]](https://eprint.iacr.org/2001/019) |
| **U-Prove** | 2010 | DLP | One-show tokens; minimal disclosure; Microsoft research [[1]](https://www.microsoft.com/en-us/research/project/u-prove/) |
| **idemix (IBM)** | 2001 | CL + ZK | Multi-show credentials with unlinkability [[1]](https://idemix.wordpress.com/) |
| **PS Signatures (Pointcheval-Sanders)** | 2016 | Pairings | Short, randomizable; used in Coconut / Nym network [[1]](https://eprint.iacr.org/2015/525) |
| **SD-JWT (Selective Disclosure JWT)** | 2025 | Hash-based digests | **RFC 9901**; selective claim disclosure for JWTs; mandated by eIDAS 2.0 for EU digital identity [[1]](https://datatracker.ietf.org/doc/rfc9901/) |

**State of the art:** BBS+ (W3C VC), SD-JWT (RFC 9901, EU eIDAS 2.0), PS Signatures (blockchain/Nym), CL Signatures (enterprise).

**Production readiness:** Production
Deployed in EU EUDI Wallet (eIDAS 2.0), Hyperledger AnonCreds, IBM idemix, Microsoft U-Prove, and W3C VC ecosystems.

**Implementations:**
- [Hyperledger AnonCreds](https://github.com/hyperledger/anoncreds-rs) ⭐ 85 — Rust, CL-based anonymous credentials
- [idemix (IBM)](https://github.com/IBM/idemix) ⭐ 36 — Go, Idemix anonymous credential library
- [sd-jwt-rust](https://github.com/openwallet-foundation-labs/sd-jwt-rust) ⭐ 20 — Rust, SD-JWT reference implementation
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) ⭐ 126 [archived] — TypeScript, BBS+ signatures for W3C VCs

**Security status:** Secure
CL and BBS+ are well-studied under standard assumptions; SD-JWT is hash-based and conservative. Parameter choices are mature.

**Community acceptance:** Standard
SD-JWT is RFC 9901; BBS+ is W3C TR and IETF CFRG draft; CL Signatures are industry-standard in Hyperledger.

---

## Mix Networks (Mixnets)

**Goal:** Sender anonymity. Messages are shuffled through a chain of servers; each removes a layer of encryption and permutes the batch, so the link between sender and recipient is hidden. Foundation of anonymous communication and e-voting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum Decryption Mix** | 1981 | PKE + layered enc | First mixnet proposal; onion encryption through relay chain [[1]](https://link.springer.com/chapter/10.1007/978-1-4757-0602-4_18) |
| **Re-encryption Mixnet** | 1993 | Rerandomizable enc | Rerandomize ciphertexts without decrypting at each hop [[1]](https://link.springer.com/chapter/10.1007/3-540-57220-1_66) |
| **Verifiable Shuffle (Neff)** | 2001 | ZK proofs | Prove shuffle correctness; used in e-voting (Verificatum) [[1]](https://dl.acm.org/doi/10.1145/501983.502000) |
| **Loopix / Nym** | 2017 | Poisson mixing + cover traffic | Continuous-time mixnet; resists traffic analysis [[1]](https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/piotrowska) |
| **Universal Re-encryption (Golle et al.)** | 2004 | ElGamal + embedded rekey | Re-encrypt ciphertext without knowing recipient's public key; enables anonymous routing without destination knowledge [[1]](https://link.springer.com/chapter/10.1007/978-3-540-24660-2_14) |

**State of the art:** Loopix/Nym (modern anonymous comm.), Verifiable Shuffle (e-voting).

**Production readiness:** Production
Nym mainnet deployed since 2022; Verificatum used in national elections (e.g., Norway, Estonia).

**Implementations:**
- [Nym](https://github.com/nymtech/nym) ⭐ 1.7k — Rust, deployed incentivized mixnet
- [Verificatum](https://github.com/verificatum/verificatum-vmn) ⭐ 12 — Java, verifiable mixnet for e-voting
- [Katzenpost](https://github.com/katzenpost/katzenpost) ⭐ 147 — Go, Loopix-style mixnet framework

**Security status:** Secure
Loopix model provides formal differential-privacy bounds on traffic analysis; verifiable shuffles are proven in standard model.

**Community acceptance:** Widely trusted
Mixnets are a well-established research area; Nym and Katzenpost are endorsed by privacy researchers; Verificatum used in government elections.

---

## Onion Routing

**Goal:** Low-latency anonymous communication. Messages are wrapped in layers of encryption ("onion"); each relay peels one layer, learning only the next hop. Provides sender anonymity in real-time (unlike high-latency mixnets).

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Original Onion Routing** | 1996 | RSA + DH | First onion routing proposal; layered encryption through relays [[1]](https://ieeexplore.ieee.org/document/501689) |
| **Tor** | 2004 | TLS + DH + AES | Deployed network; 6000+ relays; 2M+ daily users [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Sphinx Packet Format** | 2009 | DH + HMAC | Compact, provably secure onion packet format; used in Lightning Network [[1]](https://eprint.iacr.org/2009/482) |

**State of the art:** Tor (largest deployed anonymity network), Sphinx (Lightning, Nym transport layer).

**Production readiness:** Production
Tor network has 6000+ relays and 2M+ daily users; Sphinx is deployed in Lightning Network.

**Implementations:**
- [Tor](https://gitlab.torproject.org/tpo/core/tor) — C, the reference onion routing implementation
- [Arti](https://gitlab.torproject.org/tpo/core/arti) — Rust, next-generation Tor client
- [sphinx (Lightning)](https://github.com/lightningnetwork/lightning-onion) ⭐ 414 — Go, Sphinx packet construction for LND

**Security status:** Caution
Secure against local adversaries; vulnerable to global passive adversaries performing traffic correlation attacks. Tor does not claim to resist global adversaries.

**Community acceptance:** Widely trusted
Tor is the most studied and deployed anonymity network; recommended by EFF, journalists, and human rights organizations worldwide.

---

## DC-Nets (Dining Cryptographers Networks)

**Goal:** Information-theoretically anonymous broadcast. A group of participants can broadcast a message so that an adversary (even computationally unbounded) cannot determine who sent it — as long as at least one participant is honest. Stronger than mixnets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum DC-Net** | 1988 | Shared secrets + XOR | Original: participants XOR shared bits; anonymous 1-bit broadcast [[1]](https://www.cs.cornell.edu/people/egs/herbivore/dcnets.html) |
| **Herbivore** | 2003 | DC-net + groups | Practical DC-net for small groups; scalability improvements [[1]](https://www.cs.cornell.edu/people/egs/herbivore/) |
| **Verdict (Corrigan-Gibbs-Ford)** | 2013 | DC-net + ZKP | Accountable: detect disruptors via zero-knowledge proofs [[1]](https://dl.acm.org/doi/10.1145/2508859.2516683) |

**State of the art:** Verdict (accountability + anonymity), DC-nets remain strongest anonymity guarantee but hard to scale.

**Production readiness:** Research
No large-scale production deployments; Verdict is an academic prototype demonstrating accountability.

**Implementations:**
- [Dissent](https://github.com/dedis/prifi) ⭐ 52 — Go, DC-net-based anonymity protocol (DEDIS lab)

**Security status:** Secure
Information-theoretically anonymous (strongest possible guarantee); practical schemes add accountability via ZK proofs without weakening anonymity.

**Community acceptance:** Niche
Strongest anonymity guarantee in theory but impractical at scale; primarily of academic interest. Foundational concept referenced widely in anonymity research.

---

## Privacy Pass / Anonymous Tokens

**Goal:** Unlinkable authorization. A client obtains a batch of tokens from a server (e.g., by solving a CAPTCHA once), then redeems them later without the server being able to link redemption to issuance. Rate-limiting without tracking.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Privacy Pass v1** | 2018 | VOPRF (EC) | Cloudflare's protocol; blind token issuance via VOPRF (see [OPRF](10-privacy-preserving-computation.md#oblivious-prf-oprf)) [[1]](https://doi.org/10.1515/popets-2018-0026) |
| **Privacy Pass v3 (IETF)** | 2023 | VOPRF / blind RSA | Standardized (RFC 9576–9578); public/private metadata, rate-limited tokens [[1]](https://www.rfc-editor.org/rfc/rfc9576) |
| **Apple Private Access Tokens** | 2022 | Blind RSA (RSA-BPOP) | Built on Privacy Pass; used in iOS/macOS for CAPTCHA-free auth [[1]](https://developer.apple.com/news/?id=huqjyh7k) |
| **Trust Token API (Chrome)** | 2020 | VOPRF | Google's Privacy Pass variant for anti-fraud without cookies [[1]](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/) |

**State of the art:** Privacy Pass v3 (IETF RFC 9576–9578) with VOPRF or blind RSA; deployed by Cloudflare, Apple, Chrome.

**Production readiness:** Production
Deployed by Cloudflare (CAPTCHA bypass), Apple (Private Access Tokens in iOS/macOS), and Chrome (Trust Token API).

**Implementations:**
- [cloudflare/pat-go](https://github.com/cloudflare/pat-go) ⭐ 38 — Go, Privacy Pass token issuer/redeemer
- [cloudflare/privacypass](https://github.com/raphaelrobert/privacypass) ⭐ 62 — TypeScript, Privacy Pass browser extension

**Security status:** Secure
IETF-standardized (RFC 9576-9578); VOPRF and blind RSA are well-studied under standard assumptions.

**Community acceptance:** Standard
IETF RFC 9576-9578; deployed at scale by Cloudflare, Apple, and Google; endorsed by IRTF CFRG.

---

## Secret Handshakes / Hidden Credentials

**Goal:** Mutual private authentication. Two parties discover if they share a group membership — if not, neither learns anything about the other. No information leaks on failed authentication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Balfanz-Durfee-et-al.** | 2003 | Pairing-based | First secret handshake scheme; CA issues group credentials [[1]](https://dl.acm.org/doi/10.1145/948109.948126) |
| **Multi-Group SH (Castelluccia)** | 2004 | Bilinear maps | Support for multiple simultaneous group memberships [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30108-0_22) |
| **Unlinkable SH (Jarecki-Liu)** | 2009 | OPRF + ZK | Unlinkable across sessions; stronger privacy [[1]](https://eprint.iacr.org/2008/332) |

**State of the art:** Unlinkable Secret Handshakes (strongest privacy), pairing-based SH (practical).

**Production readiness:** Research
No major production deployments; academic prototypes only.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Pairing-based constructions proven under standard bilinear assumptions; unlinkable variants add stronger privacy.

**Community acceptance:** Niche
Well-studied in academic literature but limited adoption outside research; no standardization effort.

---

## Semaphore / Anonymous Group Signaling (RLN)

**Goal:** Anonymous membership proof with rate limiting. Prove you belong to a group and broadcast a signal — without revealing which member you are. RLN (Rate-Limiting Nullifiers) adds: sending more than one signal per epoch reveals your secret key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Semaphore** | 2019 | zk-SNARK + Merkle | Anonymous group signaling via ZK membership proof in a Merkle tree [[1]](https://semaphore.pse.dev/V1) |
| **RLN v1 (Rate-Limiting Nullifiers)** | 2020 | Semaphore + Shamir | Rate-limited: >1 signal per epoch → secret key reconstructable [[1]](https://rate-limiting-nullifier.github.io/rln-docs/) |
| **RLN v2** | 2023 | Groth16 + slashing | Improved; variable rate limits per epoch [[1]](https://rate-limiting-nullifier.github.io/rln-docs/v2) |
| **Zupass / Semaphore v4** | 2024 | Groth16 / PLONK | Identity framework: ZK proofs of attributes, event tickets, voting [[1]](https://github.com/semaphore-protocol/semaphore) |

**State of the art:** Semaphore v4 + RLN v2; used in Ethereum (spam prevention), Waku messaging, Zupass identity. Related to [Ring Signatures](#anonymous-credentials-vs-group-signatures-vs-ring-signatures), [ZK Proofs](04-zero-knowledge-proof-systems.md#zero-knowledge-proofs-zk).

**Production readiness:** Experimental
Semaphore v4 deployed in Zupass and Ethereum applications; RLN v2 used in Waku messaging protocol.

**Implementations:**
- [Semaphore](https://github.com/semaphore-protocol/semaphore) ⭐ 1.1k — TypeScript/Solidity, anonymous group signaling
- [RLN](https://github.com/rate-limiting-nullifier/rln-contracts) ⭐ 17 — Solidity, rate-limiting nullifier contracts
- [Zupass](https://github.com/proofcarryingdata/zupass) ⭐ 361 — TypeScript, ZK identity and ticketing framework

**Security status:** Secure
Based on Groth16/PLONK over well-studied curves; Semaphore circuit is formally audited; RLN slashing mechanism is provably sound.

**Community acceptance:** Emerging
Growing adoption in Ethereum ecosystem; used by PSE (Privacy & Scaling Explorations) and Waku/Vac; active community development.

---

## Delegatable Anonymous Credentials

**Goal:** Credential chaining with privacy. A credential holder can delegate their credential to another party — possibly with restrictions — who can further delegate. Each presentation is anonymous and unlinkable, even across delegation levels.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Lysyanskaya Delegatable Creds** | 2006 | NIZK + signatures | First delegatable anonymous credentials; unlimited depth [[1]](https://eprint.iacr.org/2006/281) |
| **Belenkiy-Chase-Kohlweiss-Lysyanskaya** | 2009 | GS proofs + P-signatures | Practical delegatable creds from Groth-Sahai proofs [[1]](https://eprint.iacr.org/2008/428) |
| **Camenisch-Drijvers-Dubovitskaya** | 2017 | CL sigs + delegation | Practical construction with attribute-based delegation [[1]](https://eprint.iacr.org/2017/115) |

**State of the art:** Delegatable creds from [Malleable Proofs](04-zero-knowledge-proof-systems.md#malleable-proof-systems-controlled-malleable-nizk) and [SPS/EQS](08-signatures-advanced.md#structure-preserving-signatures-sps). Extends [Anonymous Credentials](#anonymous-credentials).

**Production readiness:** Research
Academic constructions only; no production implementations.

**Implementations:**
- No production implementations available; constructions described in referenced papers

**Security status:** Secure
Proven under standard pairing assumptions (Groth-Sahai proofs, P-signatures); no known attacks.

**Community acceptance:** Niche
Important theoretical contribution but not yet adopted in practice; complexity of delegation chains limits deployment.

---

## Keyed-Verification Anonymous Credentials (KVAC)

**Goal:** Lightweight anonymous credentials. Issuer gives user a credential; user can prove possession anonymously — but only the issuer (who holds the verification key) can verify. No pairings needed; very efficient. Used in Signal's anonymous groups.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CMZ KVAC (Chase-Meiklejohn-Zaverucha)** | 2014 | Algebraic MAC + ZK | First KVAC; MAC-based anonymous credentials; efficient without pairings [[1]](https://eprint.iacr.org/2013/516) |
| **Signal Anonymous Credentials** | 2020 | CMZ + Ristretto | Signal's implementation for anonymous group membership [[1]](https://signal.org/blog/signal-private-group-system/) |
| **KVAC with Attributes** | 2019 | Algebraic MAC | Selective disclosure of attributes; blind issuance [[1]](https://eprint.iacr.org/2019/344) |

**State of the art:** CMZ-based KVAC (Signal Private Groups); lightweight alternative to [BBS+/PS Signatures](08-signatures-advanced.md#rerandomizable-signatures-ps-signatures) when issuer-only verification suffices. See [Anonymous Credentials](#anonymous-credentials).

**Production readiness:** Production
Deployed in Signal Private Group System serving 100M+ users.

**Implementations:**
- [signalapp/libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, official Signal crypto library including zkgroup KVAC

**Security status:** Secure
Algebraic MAC-based; proven under DDH assumption over Ristretto255; no pairings needed.

**Community acceptance:** Widely trusted
Deployed at massive scale in Signal; peer-reviewed (CCS 2014); endorsed by cryptography community as lightweight alternative to pairing-based credentials.

---

## E-Cash / Chaumian Digital Cash

**Goal:** Anonymous digital payments. A bank issues "coins" via blind signatures; the user spends coins anonymously (bank cannot link withdrawal to payment); double-spending is detected. The foundational idea behind all cryptocurrency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum E-Cash** | 1982 | Blind RSA signatures | First anonymous digital cash; bank blindly signs coin, user spends unlinkably [[1]](https://doi.org/10.1007/978-1-4757-0602-4_18) |
| **Chaum-Fiat-Naor Offline E-Cash** | 1990 | Blind sigs + cut-and-choose | Offline spending; double-spender's identity revealed [[1]](https://doi.org/10.1007/3-540-46766-1_34) |
| **Brands E-Cash** | 1993 | Discrete log + blind sigs | Efficient offline e-cash; compact wallets [[1]](https://doi.org/10.1007/3-540-48329-2_26) |
| **Compact E-Cash (Camenisch-Hohenberger-Lysyanskaya)** | 2005 | Pairings + ZK | Withdraw N coins at once; O(1) wallet storage [[1]](https://eprint.iacr.org/2005/060) |
| **Divisible E-Cash (Okamoto)** | 1995 | Binary tree coins | Single coin of value N subdivides into any denomination combination; O(log N) communication per payment [[1]](https://link.springer.com/chapter/10.1007/3-540-44750-4_35) |

**State of the art:** Compact E-Cash (CHL 2005); modern [Privacy Pass](#privacy-pass-anonymous-tokens) is essentially single-use e-cash tokens. See [Blind Signatures](08-signatures-advanced.md#blind-signatures).

**Production readiness:** Mature
GNU Taler is production-deployed; Compact E-Cash informs modern token systems; Chaum's original scheme inspired all privacy coins.

**Implementations:**
- [GNU Taler](https://git.taler.net/) — C/Python, production e-cash system
- [cashu](https://github.com/cashubtc/cashu) ⭐ 472 — Python, Chaumian e-cash for Bitcoin Lightning
- [Fedimint](https://github.com/fedimint/fedimint) ⭐ 680 — Rust, federated Chaumian e-cash on Bitcoin

**Security status:** Secure
Blind signature-based e-cash is well-studied; double-spend detection is provably correct under standard assumptions.

**Community acceptance:** Widely trusted
Foundational cryptographic concept (1982); GNU Taler selected for EU NGI rollout; Cashu and Fedimint gaining Bitcoin ecosystem adoption.

---

## Anonymous Broadcast Encryption

**Goal:** Recipient-hiding broadcast. Encrypt to a set S of authorized receivers — but the ciphertext reveals nothing about who is in S. An eavesdropper cannot tell whether they are an intended recipient (beyond trying to decrypt).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Barth-Boneh-Waters Anonymous BE** | 2006 | Pairings | First anonymous broadcast encryption; hides recipient set [[1]](https://eprint.iacr.org/2006/104) |
| **Libert-Paterson-Quaglia** | 2012 | Pairings (prime order) | Efficient anonymous BE with shorter ciphertexts [[1]](https://eprint.iacr.org/2011/476) |
| **Anonymous BE from LWE** | 2019 | Lattices | Post-quantum anonymous broadcast encryption [[1]](https://eprint.iacr.org/2019/532) |

**State of the art:** Lattice-based anonymous BE for PQ; extends [Broadcast Encryption](#anonymous-broadcast-encryption) with recipient privacy. Related to [Anonymous IBE](#anonymous-credentials).

**Production readiness:** Research
Academic constructions only; no production deployments.

**Implementations:**
- [TFHE-rs](https://github.com/zama-ai/tfhe-rs) ⭐ 1.6k — Rust, lattice-based FHE library applicable to anonymous BE from LWE
- [RELIC toolkit](https://github.com/relic-toolkit/relic) ⭐ 508 — C, pairing-based cryptography library supporting anonymous BE primitives

**Security status:** Secure
Pairing-based and lattice-based constructions proven under standard assumptions (DBDH, LWE).

**Community acceptance:** Niche
Theoretical importance for recipient privacy; limited practical demand outside specific use cases (anonymous file sharing, private publish-subscribe).

---

## Anonymous Reputation Systems

**Goal:** Accumulate and present reputation scores anonymously. A user builds reputation through actions but presents it without revealing which actions they performed or linking presentations. Prevents Sybil attacks while preserving privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Androulaki et al. Anonymous Reputation** | 2008 | Blind sigs + ZK | First practical anon reputation; reputation tokens via blind sigs [[1]](https://doi.org/10.1145/1455770.1455782) |
| **BLAC (Blacklistable Anonymous Credentials)** | 2010 | Pairing-based | Blacklist misbehaving users without linking to identity [[1]](https://doi.org/10.1145/1866307.1866358) |
| **AnonRep (Zhai et al.)** | 2016 | Linkable ring sigs + shuffle | Tracking-resistant reputation; verifiable shuffle prevents deanonymization [[1]](https://www.cs.yale.edu/homes/zhai-ennan/zhai16anonrep.pdf) |

**State of the art:** AnonRep (2016); combines [Ring Signatures](#anonymous-credentials-vs-group-signatures-vs-ring-signatures), [Anonymous Credentials](#anonymous-credentials), and [Mixnets](#mix-networks-mixnets).

**Production readiness:** Research
Academic prototypes only (AnonRep, BLAC); no large-scale production deployments.

**Implementations:**
- [AnonRep prototype](https://www.cs.yale.edu/homes/zhai-ennan/zhai16anonrep.pdf) — research prototype (paper with implementation details)
- [BLAC](https://cs.brown.edu/~anna/blac.html) — Java, blacklistable anonymous credentials prototype

**Security status:** Secure
Cryptographic constructions are sound under standard assumptions; practical challenges include Sybil resistance.

**Community acceptance:** Niche
Active research area but no standardization; combines multiple privacy primitives making deployment complex.

---

## Stealth Addresses

**Goal:** Receiver-unlinkable blockchain payments. Sender non-interactively generates a one-time address controlled by the receiver — without any prior interaction. An observer cannot link the stealth address to the receiver's public key. Each payment goes to a fresh, unique address.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dual-Key Stealth Address Protocol (DKSAP)** | 2014 | ECDH | Receiver publishes scan + spend keys; sender derives one-time address via ECDH [[1]](https://eprint.iacr.org/2020/548) |
| **ERC-5564 (Ethereum Standard)** | 2023 | ECDH + view tags | Standardized stealth addresses for Ethereum; view tags for efficient scanning [[1]](https://eips.ethereum.org/EIPS/eip-5564) |
| **Stealth Addresses + ZK (Umbra)** | 2022 | ECDH + ZK proofs | Privacy-preserving withdrawal using ZK proofs; deployed on Ethereum [[1]](https://www.umbra.cash/) |

**State of the art:** ERC-5564 (Ethereum standard); Umbra (deployed). Related to [NIKE](03-key-exchange-key-management.md#non-interactive-key-exchange-nike) and [HD Wallets](03-key-exchange-key-management.md#hierarchical-deterministic-keys-bip32-hd-wallets).

**Production readiness:** Experimental
Umbra deployed on Ethereum mainnet; ERC-5564 standardized but adoption still growing; Monero uses stealth addresses in production.

**Implementations:**
- [Umbra Protocol](https://github.com/ScopeLift/umbra-protocol) ⭐ 387 — Solidity/TypeScript, stealth address protocol for Ethereum
- [Monero](https://github.com/monero-project/monero) ⭐ 10k — C++, dual-key stealth addresses in production
- [ERC-5564 reference](https://github.com/nerolation/EIP-Stealth-Address-ERC) ⭐ 57 — Solidity, reference implementation

**Security status:** Secure
ECDH-based derivation is well-understood; view tags improve scanning efficiency without weakening privacy.

**Community acceptance:** Emerging
ERC-5564 is an accepted Ethereum standard; Monero has used stealth addresses since 2014; growing interest in Ethereum privacy community.

---

## Coconut Credentials

**Goal:** Threshold-issued anonymous credentials on distributed systems. A set of authorities jointly issue a credential (no single authority sees the full request); the credential supports selective attribute disclosure, re-randomization for unlinkability, and private attributes. Designed for integration with smart contracts and blockchains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Coconut** | 2019 | PS Signatures + threshold blind sigs | Threshold issuance: t-of-n authorities; unlinkable re-randomizable credential; deployed in Nym network [[1]](https://www.ndss-symposium.org/ndss-paper/coconut-threshold-issuance-selective-disclosure-credentials-with-applications-to-distributed-ledgers/) |
| **Security Analysis of Coconut** | 2022 | Algebraic security model | Formal UC-style analysis; modified blind issuance for information-theoretic user privacy [[1]](https://eprint.iacr.org/2022/011) |
| **Threshold BBS+** | 2023 | BBS+ + threshold issuance | Distributed BBS+ credential issuance without a trusted issuer [[1]](https://eprint.iacr.org/2023/602) |

**State of the art:** Coconut (NDSS 2019) deployed in Nym network for anonymous bandwidth tokens. Extends [PS Signatures](#anonymous-credentials) with threshold issuance; complements [Delegatable Anonymous Credentials](#delegatable-anonymous-credentials) and [KVAC](#keyed-verification-anonymous-credentials-kvac).

**Production readiness:** Production
Deployed in Nym Network for anonymous bandwidth credential issuance.

**Implementations:**
- [Nym Coconut](https://github.com/nymtech/nym/tree/develop/common/credentials) ⭐ 1.7k — Rust, Coconut credential implementation in Nym

**Security status:** Secure
PS signatures with threshold blind issuance; formal UC-style security analysis (2022); no known attacks.

**Community acceptance:** Emerging
Published at NDSS 2019; deployed in Nym; gaining interest for decentralized credential issuance; not yet standardized by IETF/W3C.

---

## Tor v3 Onion Services

**Goal:** Server-side anonymity on Tor. A hidden service advertises a self-authenticating .onion address derived from a long-term Ed25519 key. Clients locate the service through a distributed hash table of encrypted descriptors — without any party learning the server's IP address. Provides mutual anonymity: both client and server are hidden.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Onion Services v2** | 2004 | RSA-1024 + SHA-1 | 16-char address; descriptor in plain text in HSDir; deprecated 2021 [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Onion Services v3 (prop 224)** | 2017 | Ed25519 + X25519 + SHAKE-256 | 56-char address = Ed25519 pubkey + checksum; descriptor double-encrypted; blinded daily signing key derived from identity key + date [[1]](https://torproject.gitlab.io/torspec/rend-spec-v3.html) |
| **Client Authorization (v3)** | 2017 | X25519 ECDH | Optional: service encrypts descriptor_cookie with each authorized client's X25519 key; unauthenticated parties cannot decrypt descriptor at all [[1]](https://torproject.gitlab.io/torspec/rend-spec-v3.html) |

**State of the art:** Tor v3 onion services (rend-spec-v3, deployed since 2021 exclusively). Key-blinded daily descriptors prevent HSDir enumeration; X25519 client auth adds access control. Related to [Onion Routing](#onion-routing) and [DC-Nets](#dc-nets-dining-cryptographers-networks).

**Production readiness:** Production
Deployed exclusively since 2021 (v2 deprecated); thousands of active .onion sites including major news organizations.

**Implementations:**
- [Tor](https://gitlab.torproject.org/tpo/core/tor) — C, reference implementation including onion service support
- [Arti](https://gitlab.torproject.org/tpo/core/arti) — Rust, next-gen Tor implementation with onion service support
- [OnionBalance](https://gitlab.torproject.org/tpo/core/onionbalance) — Python, load balancer for onion services

**Security status:** Caution
Cryptographically sound (Ed25519 + X25519); resistant to HSDir enumeration; vulnerable to traffic correlation by global adversaries.

**Community acceptance:** Widely trusted
Deployed by NYT, BBC, Facebook, ProPublica, and others; endorsed by EFF and privacy organizations; part of Tor Project's core offering.

---

## I2P (Invisible Internet Project)

**Goal:** Internal anonymous network for peer-to-peer services. Unlike Tor (which proxies clearnet traffic), I2P is designed for services hosted within the network. It uses "garlic routing" — bundling multiple encrypted messages into a single packet — over unidirectional tunnels, making traffic analysis significantly harder than bidirectional circuits.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Garlic Routing** | 2003 | Layered enc + message bundling | Extension of onion routing: multiple messages ("cloves") bundled in one "garlic"; hides which message belongs to which sender [[1]](https://i2p.net/en/docs/overview/garlic-routing/) |
| **NTCP2 Transport** | 2018 | Noise protocol + ChaCha20 | Obfuscated transport replacing NTCP; resistant to deep-packet inspection [[1]](https://i2p.net/en/docs/transport/ntcp2/) |
| **SSU2 Transport** | 2022 | Noise + UDP | UDP transport; replaces SSU; reduces DPI fingerprinting [[1]](https://i2p.net/en/docs/transport/ssu2/) |
| **ECIES-X25519-AEAD-Ratchet** | 2020 | X25519 + ChaCha20-Poly1305 | Forward-secure end-to-end encryption for I2P garlic messages; replaces ElGamal/AES [[1]](https://i2p.net/en/docs/spec/ecies/) |

**State of the art:** I2P with NTCP2/SSU2 transports and ECIES ratchet (deployed ~2022). Complements [Onion Routing](#onion-routing) and [Mix Networks](#mix-networks-mixnets) for internal-network anonymity; garlic bundling adds resistance to correlation attacks.

**Production readiness:** Production
Active network with thousands of routers; ECIES ratchet and SSU2 transport deployed since 2022.

**Implementations:**
- [PurpleI2P/i2pd](https://github.com/PurpleI2P/i2pd) ⭐ 4.0k — C++, full-featured lightweight I2P daemon
- [i2p/i2p.i2p](https://github.com/i2p/i2p.i2p) ⭐ 2.5k — Java, reference I2P router implementation

**Security status:** Caution
Garlic routing adds correlation resistance vs onion routing; ECIES ratchet provides forward secrecy; network-level attacks remain possible against small anonymity sets.

**Community acceptance:** Niche
Active community since 2003; smaller anonymity set than Tor; preferred for internal-network services rather than clearnet proxying.

---

## GNU Taler

**Goal:** Privacy-preserving online payments with one-sided anonymity. Customers pay anonymously (payer is unlinkable across transactions); merchants are always identified and taxable. Built on Chaumian blind signatures with efficient change, deployed as a central-bank-compatible e-cash system.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GNU Taler Core** | 2016 | RSA blind signatures + online exchange | Customer blind-withdraws coins from exchange; spends unlinkably; exchange detects double-spending; merchant identity visible to exchange [[1]](https://link.springer.com/chapter/10.1007/978-3-319-49445-6_14) |
| **Taler with Clause-Schnorr** | 2021 | Blind Schnorr (CS-blind) | Replaces RSA blind sigs with more efficient Clause-Schnorr blind signatures; reduces coin size and signing overhead [[1]](https://www.taler.net/papers/cs-thesis.pdf) |
| **NGI Taler (EU rollout)** | 2024 | Taler + central bank integration | 11-partner EU consortium; targets CBDC-compatible deployment; income transparency for tax compliance [[1]](https://ngi.eu/blog/2023/05/02/gnu-taler/) |

**State of the art:** GNU Taler with Clause-Schnorr blind signatures; selected for EU NGI rollout (2024–2027). Provides stronger payer anonymity than traditional e-cash while retaining merchant accountability. Extends [E-Cash / Chaumian Digital Cash](#e-cash-chaumian-digital-cash) and [Blind Signatures](08-signatures-advanced.md#blind-signatures).

**Production readiness:** Production
Selected for EU NGI rollout (2024-2027); 11-partner EU consortium; production-ready exchange software.

**Implementations:**
- [GNU Taler Exchange](https://git.taler.net/exchange.git) — C, core payment exchange
- [GNU Taler Wallet](https://git.taler.net/wallet-core.git) — TypeScript, reference wallet implementation
- [GNU Taler Merchant Backend](https://git.taler.net/merchant.git) — C, merchant payment processing

**Security status:** Secure
Clause-Schnorr blind signatures are well-studied; income transparency by design; formal analysis of withdrawal and payment protocols.

**Community acceptance:** Emerging
GNU project; selected for EU CBDC pilots; endorsed by privacy advocates; not yet widely deployed outside pilot programs.

---

## Zcash Shielded Protocols (Sapling / Orchard)

**Goal:** Fully private blockchain payments. Shielded transactions hide sender, receiver, and amount on a public blockchain using zk-SNARKs. Notes are commitments in a Merkle tree; spending reveals only a nullifier (preventing double-spend) and a ZK proof — no linkable information.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Sprout** | 2016 | zk-SNARK (BCTV14) + SHA-256 | First Zcash shielded pool; large proving times (~40 s); trusted setup required [[1]](https://zips.z.cash/protocol/protocol.pdf) |
| **Sapling** | 2018 | Groth16 + BLS12-381 + Jubjub | 100× faster proving (~2 s); Jubjub in-circuit curve; trusted ceremony (700+ participants) [[1]](https://zips.z.cash/protocol/sapling.pdf) |
| **Orchard** | 2022 | Halo 2 (PLONKish) + Pallas curve | No trusted setup; recursive proofs; replaces Sapling in NU5 (2022); Pallas/Vesta cycle [[1]](https://zips.z.cash/zip-0224) |

**State of the art:** Orchard (activated May 2022) using Halo 2 — the first production shielded pool without a trusted ceremony. Sapling remains widely supported for compatibility. Relies on [Halo 2 / Recursive SNARKs](04-zero-knowledge-proof-systems.md#proof-carrying-data-pcd); complements [Confidential Transactions](13-blockchain-distributed-ledger.md#confidential-transactions-ct) and [Stealth Addresses](#stealth-addresses).

**Production readiness:** Production
Orchard activated May 2022 on Zcash mainnet; Sapling deployed since 2018; billions of dollars in shielded transactions.

**Implementations:**
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Zcash Sapling and Orchard protocol libraries
- [zcash/halo2](https://github.com/zcash/halo2) ⭐ 895 — Rust, Halo 2 proof system powering Orchard
- [zcash/zcash](https://github.com/zcash/zcash) ⭐ 5.4k — C++/Rust, full Zcash node

**Security status:** Secure
Orchard uses Halo 2 (no trusted setup); Sapling's trusted ceremony had 700+ participants. No known attacks at recommended parameters.

**Community acceptance:** Widely trusted
Zcash is the premier privacy-focused cryptocurrency; Halo 2 is widely used beyond Zcash; endorsed by leading cryptographers (Hopwood, Bowe, Grigg).

---

## BBS+ Anonymous Credentials

**Goal:** Selective-disclosure unlinkable credentials from a single multi-message signature. An issuer signs a vector of attributes with one BBS signature; the holder derives an unlinkable zero-knowledge proof of knowledge of that signature, revealing only chosen attributes. Unlike CL signatures, BBS+ works over pairing-friendly elliptic curves and produces short, constant-size proofs regardless of the number of hidden attributes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **BBS Short Group Sig (Boneh-Boyen-Shacham)** | 2004 | Pairings / q-SDH + DLIN | Original BBS construction; constant-size group signature; anonymous credential ancestor [[1]](https://eprint.iacr.org/2004/174) |
| **BBS+ (Au-Susilo-Mu)** | 2006 | Pairings | First provably secure BBS stand-alone signature; added blinding factor enabling ZK proofs of possession [[1]](https://eprint.iacr.org/2009/095) |
| **Revisiting BBS (Tessaro-Zhu)** | 2023 | Pairings / ROM + AGM | Tight security proofs in ROM + algebraic group model; basis for IETF standardization [[1]](https://eprint.iacr.org/2023/275) |
| **IETF CFRG BBS Draft** | 2023– | BLS12-381 + SHAKE-256 | Ongoing IRTF/CFRG standardization of BBS signatures and proof generation; public keys in G2, sigs in G1 [[1]](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/) |
| **W3C VC DI BBS Cryptosuites** | 2024 | BBS + JSON-LD Data Integrity | W3C Technical Report; issuer signs full credential; holder derives selective-disclosure proof; proofs are unlinkable across presentations [[1]](https://www.w3.org/TR/vc-di-bbs/) |

**State of the art:** W3C VC DI BBS Cryptosuites v1.0 (W3C TR, 2024) with BBS signatures over BLS12-381; mandated for EU eIDAS 2.0 digital identity wallets alongside [SD-JWT](#anonymous-credentials). Issuer-verifiable variant covered under [Rerandomizable Signatures / PS Signatures](08-signatures-advanced.md#rerandomizable-signatures-ps-signatures); threshold issuance in [Coconut Credentials](#coconut-credentials).

**Production readiness:** Experimental
W3C VC DI BBS Cryptosuites v1.0 published (2024); IETF CFRG draft active; evaluated for EU eIDAS 2.0 but not yet mandated.

**Implementations:**
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) ⭐ 126 [archived] — TypeScript, BBS+ signature library
- [hyperledger/anoncreds-rs](https://github.com/hyperledger/anoncreds-rs) ⭐ 85 — Rust, BBS+ in Hyperledger AnonCreds v2
- [decentralized-identity/bbs-signature](https://github.com/decentralized-identity/bbs-signature) ⭐ 101 — Rust, DIF BBS+ reference implementation
- [mattrglobal/pairing_crypto](https://github.com/mattrglobal/pairing_crypto) ⭐ 31 — Rust, BLS12-381 pairing crypto for BBS+

**Security status:** Secure
Tight security proofs in ROM + algebraic group model (Tessaro-Zhu 2023); well-studied pairing-based construction.

**Community acceptance:** Emerging
W3C Technical Report; active IETF CFRG standardization; mandated for EU eIDAS 2.0 alongside SD-JWT; growing ecosystem adoption.

---

## Monero's Privacy Stack

**Goal:** Full transaction-graph anonymity on a public blockchain. Monero hides all three components that blockchain surveillance exploits: the spending key (who sent), the recipient address (who received), and the transaction amount. The three mechanisms are independent but complementary — each closes a surveillance gap the others leave open.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Ring Signatures (MLSAG)** | 2015 | Multilayered Linkable SAG | Sender signs among n decoy inputs; key image prevents double-spend without revealing which input is real [[1]](https://eprint.iacr.org/2015/1098) |
| **Stealth Addresses (one-time keys)** | 2014 | Dual-key ECDH | Sender derives a fresh one-time address per transaction from recipient's view+spend keys; recipient scans chain with view key [[1]](https://www.getmonero.org/resources/moneropedia/stealthaddress.html) |
| **RingCT (Ring Confidential Transactions)** | 2017 | Pedersen commitments + Borromean ring proofs | Hides amounts; network verifies sum-balance without seeing values; mandatory since block 1 220 516 [[1]](https://eprint.iacr.org/2015/1098) |
| **Bulletproofs (range proofs)** | 2018 | Inner-product argument | Replaced Borromean ring range proofs; ~80% transaction-size reduction [[1]](https://eprint.iacr.org/2017/1066) |
| **CLSAG (Compact LSAG)** | 2020 | Compact linkable SAG | Replaced MLSAG; ~25% smaller, ~20% faster verify; same privacy guarantees [[1]](https://eprint.iacr.org/2019/654) |
| **Bulletproofs+** | 2022 | Improved reciprocal-weight IPA | ~5–7% smaller and faster than Bulletproofs; deployed in Monero network upgrade Oct 2022 [[1]](https://eprint.iacr.org/2022/510) |

**State of the art:** Monero (2022 network upgrade) uses CLSAG ring signatures (ring size 16), dual-key stealth addresses, and RingCT with Bulletproofs+ range proofs. Seraphis (in design) would decouple membership proofs from ownership proofs for more modular upgrades. Relies on [Ring & Group Signatures](08-signatures-advanced.md#ring-group-signatures), [Stealth Addresses](#stealth-addresses), and [Range Proofs](13-blockchain-distributed-ledger.md#range-proofs).

**Production readiness:** Production
Deployed on Monero mainnet since 2014; mandatory privacy (all transactions use ring sigs, stealth addresses, RingCT since 2017).

**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, full Monero node with CLSAG, RingCT, Bulletproofs+
- [monero-rs/monero-rs](https://github.com/monero-rs/monero-rs) ⭐ 166 — Rust, Monero protocol library

**Security status:** Caution
CLSAG and Bulletproofs+ are provably secure; ring size of 16 provides limited anonymity set; chain analysis firms claim partial traceability of older transactions.

**Community acceptance:** Widely trusted
Largest privacy-by-default cryptocurrency; active research community; peer-reviewed cryptographic upgrades; regulatory scrutiny in some jurisdictions.

---

## CoinJoin / WabiSabi

**Goal:** UTXO-level unlinkability on Bitcoin. Multiple users collaboratively construct a single on-chain transaction merging their inputs and outputs; the mapping between inputs and outputs is hidden from external observers and (in the WabiSabi variant) from the coordinator. Unlike shielded protocols, CoinJoin reuses the existing Bitcoin UTXO model with no consensus changes.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CoinJoin (Maxwell)** | 2013 | Multi-party Bitcoin tx | Informal proposal; users coordinate equal-value outputs; coordinator-blind via Chaum blind sigs in practice [[1]](https://bitcointalk.org/index.php?topic=279249) |
| **ZeroLink / Wasabi v1** | 2018 | Chaumian blind sigs | Fixed-denomination mixing; coordinator blind-signs output tokens; deployed in Wasabi Wallet [[1]](https://github.com/nopara73/ZeroLink) |
| **WabiSabi** | 2021 | KVAC + homomorphic amount commitments | Replaces blind sigs with keyed-verification anonymous credentials; supports arbitrary output amounts; coordinator learns nothing about input→output mapping [[1]](https://eprint.iacr.org/2021/206) |
| **PayJoin (BIP 78)** | 2020 | Collaborative 2-party tx | Sender and receiver co-sign one tx; breaks common-input-ownership heuristic; indistinguishable from regular payments [[1]](https://github.com/bitcoin/bips/blob/master/bip-0078.mediawiki) |
| **Async PayJoin (BIP 77)** | 2023 | PayJoin + asynchronous relay | Removes requirement for simultaneous online presence; relay server learns nothing [[1]](https://github.com/bitcoin/bips/blob/master/bip-0077.mediawiki) |

**State of the art:** WabiSabi (deployed in Wasabi Wallet 2.0, 2022) is the cryptographically strongest coordinator-blind CoinJoin, building directly on [KVAC](#keyed-verification-anonymous-credentials-kvac). PayJoin (BIP 78) is a simpler two-party variant requiring no mixing round. Related to [E-Cash / Chaumian Digital Cash](#e-cash-chaumian-digital-cash) and [Blind Signatures](08-signatures-advanced.md#blind-signatures).

**Production readiness:** Production
WabiSabi deployed in Wasabi Wallet 2.0 (2022); PayJoin (BIP 78) supported by multiple wallets.

**Implementations:**
- [WalletWasabi](https://github.com/WalletWasabi/WalletWasabi) ⭐ 2.5k — C#, Wasabi Wallet with WabiSabi CoinJoin

**Security status:** Caution
WabiSabi is cryptographically sound (KVAC-based); effectiveness depends on sufficient CoinJoin participation and UTXO management discipline.

**Community acceptance:** Widely trusted
WabiSabi peer-reviewed (ePrint 2021/206); CoinJoin is a widely accepted Bitcoin privacy technique; regulatory pressure led to Wasabi coordinator shutdown in some jurisdictions.

---

## Privacy Pools

**Goal:** Compliance-friendly anonymous on-chain payments. Extends Tornado Cash-style mixing with zero-knowledge proofs that let depositors prove their funds belong to a "good" association set (e.g., excluding sanctioned wallets) — without revealing which deposit is theirs. Honest users retain privacy; malicious actors cannot create a valid inclusion proof for a clean set.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tornado Cash** | 2019 | zk-SNARK (Groth16) + Merkle | Deposit ETH, withdraw to fresh address; ZK proof of Merkle membership hides which deposit; no association-set filtering [[1]](https://eprint.iacr.org/2019/953) |
| **Privacy Pools (Buterin et al.)** | 2023 | zk-SNARK + dual Merkle proof | User proves deposit is in the full pool AND in a curated association set; withdrawer reveals neither deposit leaf nor set membership, only validity [[1]](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4563364) |
| **0xbow Privacy Pools (deployed)** | 2024 | Groth16 + Ethereum smart contract | Production implementation of the Buterin et al. design; association set providers (ASPs) publish compliance-filtered trees [[1]](https://www.theblock.co/post/348959/0xbow-privacy-pools-new-cypherpunk-tool-inspired-research-ethereum-founder-vitalik-buterin) |

**State of the art:** 0xbow Privacy Pools (2024) deploys the dual-Merkle zkSNARK design. Extends [Zcash Shielded Protocols](#zcash-shielded-protocols-sapling-orchard) with compliance-aware association sets. The underlying ZK circuit relies on [Groth16](04-zero-knowledge-proof-systems.md#zero-knowledge-proof-systems) and [Merkle-tree membership proofs](09-commitments-verifiability.md#vector-commitments).

**Production readiness:** Experimental
0xbow Privacy Pools deployed on Ethereum mainnet (2024); Tornado Cash deployed but sanctioned by OFAC (2022).

**Implementations:**
- [0xbow Privacy Pools](https://github.com/ProofOfInnocence/privacy-pools-v1) ⭐ 3 — Solidity/Circom, production Privacy Pools implementation
- [nicola/tornado-core](https://github.com/tornadocash/tornado-core) ⭐ 1.7k — Solidity/Circom, Tornado Cash mixer (archived)

**Security status:** Caution
Cryptographically sound (Groth16 + Merkle); compliance depends on quality of Association Set Providers (ASPs); Tornado Cash was sanctioned by OFAC.

**Community acceptance:** Controversial
Privacy Pools (Buterin et al.) aim to address regulatory concerns; Tornado Cash sanctions created legal uncertainty; 0xbow attempts compliant design.

---

## Group Encryption

**Goal:** Encrypt for a group with accountability. Anyone can encrypt to the group; any group member can decrypt; the group manager can identify which member decrypted. The encryption dual of group signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Group Encryption** | 2007 | Pairings + GS proofs | First group encryption; CCA-secure with opening capability [[1]](https://eprint.iacr.org/2007/015) |
| **Cathalo-Libert-Yung** | 2009 | Pairings | Efficient group encryption with shorter ciphertexts [[1]](https://eprint.iacr.org/2009/510) |
| **Lattice Group Encryption (El Bansarkhani-Sturm)** | 2018 | LWE | Post-quantum group encryption from lattices [[1]](https://eprint.iacr.org/2018/196) |

**State of the art:** Lattice-based group encryption for PQ; complements [Ring & Group Signatures](#anonymous-credentials-vs-group-signatures-vs-ring-signatures) as the encryption counterpart.

**Production readiness:** Research
Academic constructions only; no production deployments.

**Implementations:**
- [RELIC toolkit](https://github.com/relic-toolkit/relic) ⭐ 508 — C, pairing-based crypto library supporting group encryption primitives

**Security status:** Secure
CCA-secure constructions proven under standard pairing assumptions; lattice variant provides PQ security.

**Community acceptance:** Niche
Theoretical counterpart to group signatures; limited practical demand; no standardization effort.

---

## Direct Anonymous Attestation (DAA)

**Goal:** Anonymous hardware attestation. A Trusted Platform Module (TPM) or other secure enclave proves it is a genuine, unrevoked device without revealing which device it is. The verifier gains confidence in platform integrity; the platform remains unlinkable across attestation sessions. Enables private remote attestation for TEEs and mobile secure elements.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DAA (Brickell-Camenisch-Chen)** | 2004 | CL Signatures + RSA | First DAA; TPM 1.2 standard; blind CL signature from issuer; ZK proof of possession at attestation [[1]](https://eprint.iacr.org/2004/205) |
| **DAA from Pairings (Chen-Morrissey-Smart)** | 2008 | Pairings + q-SDH | Shorter signatures; pairing-based DAA; more efficient verifier [[1]](https://link.springer.com/chapter/10.1007/978-3-540-88733-1_2) |
| **Intel EPID (Enhanced Privacy ID)** | 2011 | Pairings + revocation | DAA variant deployed in Intel SGX; supports member revocation without group re-keying; used for SGX remote attestation [[1]](https://eprint.iacr.org/2009/095) |
| **TPM 2.0 DAA (ECC-based)** | 2016 | ECDAA (BN-256) | TPM 2.0 standard; ECC DAA replacing RSA variant; ECDAA command set [[1]](https://trustedcomputinggroup.org/resource/tpm-library-specification/) |
| **PQ DAA (Jia et al.)** | 2023 | Lattices / hash-based | Post-quantum DAA from lattice assumptions; compatible with TPM-like constraints [[1]](https://eprint.iacr.org/2023/1337) |

**State of the art:** Intel EPID (deployed in all SGX CPUs until 2023; being phased to Intel TDX DCAP); TPM 2.0 ECDAA (ISO/IEC 20008-2). PQ DAA remains an active research area. Builds on [Anonymous Credentials](#anonymous-credentials) and [CL Signatures](#anonymous-credentials); related to [TEE Attestation](14-applied-infrastructure-pki.md#tee-remote-attestation).

**Production readiness:** Production
Intel EPID deployed in all SGX CPUs; TPM 2.0 ECDAA is an ISO standard (ISO/IEC 20008-2).

**Implementations:**
- [intel/linux-sgx](https://github.com/intel/linux-sgx) ⭐ 1.4k — C++, Intel SGX SDK with EPID attestation
- [tpm2-software/tpm2-tss](https://github.com/tpm2-software/tpm2-tss) ⭐ 863 — C, TPM 2.0 software stack including ECDAA
- [linux-sgx](https://github.com/intel/linux-sgx) ⭐ 1.4k — C++, Intel SGX SDK with EPID attestation support

**Security status:** Caution
ECDAA/EPID are cryptographically sound; Intel SGX has been affected by side-channel attacks (Spectre, Foreshadow) unrelated to DAA crypto.

**Community acceptance:** Standard
ISO/IEC 20008-2 (TPM 2.0 ECDAA); deployed in billions of Intel CPUs; TCG standard; being phased to DCAP model in Intel TDX.

---

## Accumulators for Credential Revocation

**Goal:** Efficient anonymous revocation. An issuer maintains a compact accumulator (a single group element) that commits to the set of valid credential holders. To prove non-revocation, a holder presents a zero-knowledge witness that their credential is in the accumulator — without revealing which credential they hold. Revocation updates the accumulator without invalidating all other witnesses.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **RSA Accumulator (Baric-Pfitzmann)** | 1997 | RSA / strong RSA | First accumulator; membership witness = product exponentiation; witness update requires trusted party with factorization [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_29) |
| **Dynamic Accumulator (Camenisch-Lysyanskaya)** | 2002 | RSA | Adds/deletes members; witnesses updatable without full recompute; combined with CL signatures for anonymous credential revocation [[1]](https://eprint.iacr.org/2008/539) |
| **Pairing-based Accumulator (Nguyen)** | 2005 | Bilinear maps / q-SDH | Constant-size witnesses; O(1) verify; ZK non-membership proofs; no trusted setup for RSA modulus [[1]](https://link.springer.com/chapter/10.1007/11593447_9) |
| **Universal Accumulator (Li-Li-Xue)** | 2007 | Bilinear maps | Supports both membership and non-membership proofs; useful for revocation list proofs [[1]](https://link.springer.com/chapter/10.1007/978-3-540-76900-2_18) |
| **VB Accumulator (Boneh-Bünz-Fisch)** | 2019 | Groups of unknown order | Batched additions/deletions; aggregatable proofs; used in Hyperledger Anoncreds v2 [[1]](https://eprint.iacr.org/2018/1188) |
| **Hyperledger AnonCreds v2** | 2023 | BBS+ + VB Accumulator | W3C VC-compatible anonymous credentials with efficient ZK revocation; replaces CL+RSA accumulator from AnonCreds v1 [[1]](https://hyperledger.github.io/anoncreds-spec/) |

**State of the art:** Pairing-based accumulators (constant-size witnesses) and VB accumulators (batched updates) are state of the art for anonymous credential revocation. Hyperledger AnonCreds v2 (2023) combines BBS+ with VB-accumulator non-revocation proofs. Related to [Anonymous Credentials](#anonymous-credentials), [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), and [Vector Commitments](09-commitments-verifiability.md#vector-commitments).

**Production readiness:** Mature
VB accumulators used in Hyperledger AnonCreds v2; RSA/pairing accumulators deployed in idemix/IRMA systems.

**Implementations:**
- [hyperledger/anoncreds-rs](https://github.com/hyperledger/anoncreds-rs) ⭐ 85 — Rust, VB accumulator for AnonCreds v2 revocation
- [privacybydesign/gabi](https://github.com/privacybydesign/gabi) ⭐ 11 — Go, accumulator-based revocation in IRMA/Yivi
- [nicola/accumulator](https://github.com/cambrian/accumulator) ⭐ 138 [archived] — Rust, RSA and bilinear accumulator library

**Security status:** Secure
RSA accumulators require trusted setup (factorization); pairing-based and VB accumulators avoid this. All constructions well-studied.

**Community acceptance:** Widely trusted
Foundational primitive for anonymous credential revocation; deployed in Hyperledger, IRMA/Yivi, and EU identity systems.

---

## IRMA / Yivi Credential System

**Goal:** Practical privacy-preserving attribute-based authentication. Users store Idemix-based credentials on a smartphone; apps request selective disclosure of specific attributes (age ≥ 18, name, email) via a QR-code flow. The phone generates a ZK proof revealing only requested attributes; presentations are unlinkable across sessions. Deployed as a national-scale system in the Netherlands.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **IRMA ("I Reveal My Attributes")** | 2013 | Idemix / CL Signatures | Privacy by Design Foundation; Idemix credentials on Android; selective disclosure + unlinkability [[1]](https://privacybydesign.foundation/irma/) |
| **IRMA Go (irma-server)** | 2019 | CL Signatures + Idemix | Open-source Go implementation; attribute issuers, verifiers, revocation; REST API [[1]](https://github.com/privacybydesign/irmago) |
| **Yivi (rebranded IRMA)** | 2022 | Idemix / CL Signatures | Rebranded by Privacy by Design Foundation; 250 000+ users; Dutch government, banks, healthcare issuers; eIDAS low-assurance LoA [[1]](https://www.yivi.app/) |
| **IRMA with Revocation** | 2020 | CL Sigs + accumulator | Non-revocation proofs using RSA/pairing accumulators integrated into Idemix flow [[1]](https://eprint.iacr.org/2021/389) |

**State of the art:** Yivi (formerly IRMA) is the largest deployed Idemix-based anonymous credential system (~250 000 users, 2024). Multiple Dutch government ministries, municipalities, and healthcare providers issue attributes. Represents the production deployment of [Anonymous Credentials (idemix)](#anonymous-credentials) and [Accumulators for Credential Revocation](#accumulators-for-credential-revocation).

**Production readiness:** Production
~250,000 users in the Netherlands; Dutch government ministries, banks, and healthcare providers issue credentials.

**Implementations:**
- [privacybydesign/irmago](https://github.com/privacybydesign/irmago) ⭐ 84 — Go, IRMA/Yivi server and client library
- [privacybydesign/irmago](https://github.com/privacybydesign/irmago) ⭐ 84 — Go, core IRMA server (REST API, issuance, verification, revocation)
- [nicola/irma_mobile](https://github.com/credentials/irma_mobile) ⭐ 25 — Dart/Flutter, Yivi mobile app

**Security status:** Secure
Based on well-studied Idemix/CL signatures; accumulator-based revocation formally analyzed.

**Community acceptance:** Emerging
Largest deployed Idemix system; endorsed by Privacy by Design Foundation; used by Dutch government; eIDAS low-assurance level recognized.

---

## ZKP-Based Attribute Predicates (Range Proofs for Credentials)

**Goal:** Prove attribute predicates in zero knowledge. A credential holder proves a statement about an attribute — "age ≥ 18", "salary ∈ [50 000, 200 000]", "balance > 0" — without disclosing the exact value. Range proofs are the most common predicate; combined with anonymous credentials they enable privacy-preserving age verification, income checks, and compliance attestations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Square Decomposition Range Proofs (Camenisch et al.)** | 2008 | Sigma protocols + CL | Prove value in range via sum-of-three-squares decomposition; combined with Idemix attributes [[1]](https://link.springer.com/chapter/10.1007/978-3-540-88313-5_9) |
| **Bulletproofs Range Proof** | 2018 | Inner-product argument | O(log n)-size proof, no trusted setup; used in Monero, Grin, Zcash Sapling (R1CS) [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs+ (Chung et al.)** | 2021 | Improved IPA | ~15% shorter proofs than Bulletproofs; weighted inner-product argument; deployed in Monero (2022) [[1]](https://eprint.iacr.org/2020/735) |
| **LegoSNARK Commit-and-Prove** | 2019 | zkSNARK + commitments | Modular: attach range proof to any zkSNARK-committed attribute; composable with BBS+/PS credentials [[1]](https://eprint.iacr.org/2019/142) |
| **BBS+ Predicate Proofs (Kurtosis)** | 2023 | BBS + Bulletproofs | ZK range proofs over BBS+ committed attributes; selective disclosure + numeric predicate in one presentation [[1]](https://eprint.iacr.org/2023/275) |
| **Age Verification via SD-JWT + ZKP** | 2024 | SD-JWT + ZK circuit | ETSI/W3C proposals for ZK predicate on SD-JWT age claim; used in EU EUDI Wallet age-verification flow [[1]](https://www.ietf.org/archive/id/draft-terbu-sd-jwt-vc-02.txt) |

**State of the art:** Bulletproofs (no trusted setup, O(log n) size) are widely deployed for range proofs on blockchain; LegoSNARK and BBS+ predicate proofs bring composable range proofs to anonymous credential presentations. The EU EUDI Wallet (eIDAS 2.0) is evaluating ZKP-based age verification over SD-JWT VCs. Depends on [Anonymous Credentials](#anonymous-credentials), [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), and [Bulletproofs / Range Proofs](13-blockchain-distributed-ledger.md#range-proofs).

**Production readiness:** Mature
Bulletproofs deployed in Monero and Grin; LegoSNARK and BBS+ predicates in experimental credential systems.

**Implementations:**
- [dalek-cryptography/bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust, Bulletproofs range proof library (Ristretto)
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, Bulletproofs+ in production
- [dalek-cryptography/bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust, Bulletproofs implementation (Ristretto)

**Security status:** Secure
Bulletproofs proven in discrete-log setting; no trusted setup; Bulletproofs+ improves efficiency with same security.

**Community acceptance:** Widely trusted
Bulletproofs widely adopted in privacy-preserving blockchains; BBS+ predicate proofs under active IETF/W3C standardization.

---

## SD-JWT and JSON Web Proof (JWP)

**Goal:** Selective disclosure for JSON-based credentials. SD-JWT (RFC 9591) extends the JWT standard with hash-based claim concealment: each attribute is individually salted and hashed; the holder releases only the digests and salted values they choose to disclose. JWP (IETF draft) generalises further by defining a proof-carrying JSON container that can wrap ZK-proof-based selective-disclosure schemes (BBS+, MAC-based) alongside simpler hash-based ones.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SD-JWT (Selective Disclosure JWT)** | 2025 | SHA-256 hash digests | RFC 9591; issuer replaces claims with `_sd` digest arrays; holder releases salted preimages selectively; JWT core remains standard [[1]](https://www.rfc-editor.org/rfc/rfc9591) |
| **SD-JWT-VC** | 2024 | SD-JWT + W3C VC type system | IETF draft (draft-ietf-oauth-sd-jwt-vc); adds `vct` claim, status reference, key binding; mandated credential format for EU EUDI Wallet and ISO mDL interop [[1]](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/) |
| **JSON Web Proof (JWP)** | 2024 | Proof-carrying JSON container | IETF JOSE WG draft; defines serializations (Compact, JSON) for proofs; algorithm registry covers BBS+ (`BBS-2023`), MAC-H256, MAC-H256-K; enables unlinkable presentations inside a JWT-like envelope [[1]](https://datatracker.ietf.org/doc/draft-ietf-jose-json-web-proof/) |
| **JPA (JSON Proof Algorithms)** | 2024 | BBS+ / MAC over JSON | Companion draft to JWP; specifies concrete algorithm identifiers and proof generation/verification procedures [[1]](https://datatracker.ietf.org/doc/draft-ietf-jose-json-proof-algorithms/) |

**State of the art:** SD-JWT (RFC 9591, 2025) is the primary selective-disclosure format for OAuth/OIDC ecosystems and is mandated by eIDAS 2.0 for the [EU EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20). JWP remains an IETF draft but is the leading candidate for unlinkable presentations in JSON contexts. Complements [BBS+ Anonymous Credentials](#bbs-anonymous-credentials) (which JWP can wrap) and [Anonymous Credentials](#anonymous-credentials).

**Production readiness:** Production
SD-JWT is RFC 9591 (2025); mandated by eIDAS 2.0 for EU EUDI Wallet. JWP is an active IETF draft.

**Implementations:**
- [openwallet-foundation-labs/sd-jwt-rust](https://github.com/openwallet-foundation-labs/sd-jwt-rust) ⭐ 20 — Rust, SD-JWT reference
- [danielfett/sd-jwt](https://github.com/danielfett/sd-jwt) ⭐ 4 — Python, SD-JWT reference by spec author
- [nicola/sd-jwt-js](https://github.com/openwallet-foundation/sd-jwt-js) ⭐ 76 — TypeScript, SD-JWT library

**Security status:** Secure
Hash-based selective disclosure is conservative and PQ-safe; no complex cryptographic assumptions beyond SHA-256.

**Community acceptance:** Standard
RFC 9591 (IETF); mandated by EU eIDAS 2.0; supported by OpenID Foundation; rapidly growing ecosystem.

---

## OpenID for Verifiable Credentials (OID4VC)

**Goal:** Credential issuance and presentation over OpenID Connect / OAuth 2.0. OID4VC is a family of IETF/OpenID Foundation protocols that add credential-specific endpoints to the existing OAuth ecosystem: wallets request credentials from issuers (OID4VCI) and present them to verifiers (OID4VP) without bespoke infrastructure. The cryptographic core — SD-JWT, BBS+, mDL COSE — is decoupled from the transport protocol.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **OID4VCI (OpenID for VC Issuance)** | 2024 | OAuth 2.0 + credential endpoint | Issuer exposes `/credential` endpoint; wallet obtains SD-JWT-VC or mdoc via authorization-code or pre-authorized-code flow [[1]](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) |
| **OID4VP (OpenID for VP)** | 2024 | OAuth 2.0 + presentation_definition | Verifier sends Presentation Definition (DIF PE); wallet returns VP Token (SD-JWT or mdoc); response_uri binding prevents replay [[1]](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| **OID4VP over BLE / Proximity** | 2024 | OID4VP + ISO 18013-5 engagement | Near-field variant for in-person age checks (mDL handover); BLE or QR device engagement; same cryptographic presentation as remote OID4VP [[1]](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| **SIOPv2 (Self-Issued OP v2)** | 2024 | OIDC + DID-based self-issued IdP | Wallet acts as its own OpenID Provider; no external IdP required; id_token signed with wallet key; used for DID-based login [[1]](https://openid.net/specs/openid-connect-self-issued-v2-1_0.html) |

**State of the art:** OID4VCI + OID4VP (both reaching final spec in 2024) are the official issuance and presentation protocols for the EU [EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20) ARF and are being adopted by NIST and ISO. SIOPv2 enables self-sovereign login using DID-anchored keys. Builds on [SD-JWT and JSON Web Proof](#sd-jwt-and-json-web-proof-jwp) credential formats and [DID/VCs](14-applied-infrastructure-pki.md#w3c-decentralized-identifiers-did-and-verifiable-credentials).

**Production readiness:** Experimental
Specifications reaching final draft (2024); EU EUDI Wallet reference implementations available; pilots in multiple EU countries.

**Implementations:**
- [eu-digital-identity-wallet](https://github.com/eu-digital-identity-wallet) — Kotlin/Swift, EU EUDI Wallet reference apps
- [nicola/OID4VC](https://github.com/Sphereon-Opensource/OID4VC) ⭐ 88 — TypeScript, OID4VCI/OID4VP implementation

**Security status:** Secure
Built on well-established OAuth 2.0/OIDC security model; response_uri binding prevents replay; credential security depends on underlying format (SD-JWT, mDL).

**Community acceptance:** Emerging
OpenID Foundation specifications; mandated by EU EUDI Wallet ARF; adopted by NIST and ISO; rapidly becoming the dominant VC transport protocol.

---

## EU EUDI Wallet Cryptographic Architecture (eIDAS 2.0)

**Goal:** Pan-European privacy-preserving digital identity. The European Digital Identity Wallet (EUDI Wallet) mandates a specific cryptographic stack under eIDAS 2.0 (EU Regulation 2024/1183): wallets store PID (Person Identification Data) and attestations; issuance uses [OID4VCI](#openid-for-verifiable-credentials-oid4vc); presentation uses OID4VP; credential formats are SD-JWT-VC and ISO mDL (mdoc/COSE). Selective disclosure and key binding are mandatory; unlinkability via BBS+ is under active evaluation.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **eIDAS 2.0 (EU Reg 2024/1183)** | 2024 | Regulation + ARF v1.x | Legal framework; mandates EUDI Wallet availability in all EU member states; defines LoA High assurance for PID [[1]](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=OJ:L_202401183) |
| **ARF (Architecture Reference Framework)** | 2024 | OID4VCI + OID4VP + SD-JWT-VC + mdoc | Technical spec published by EC; defines trust anchors, PID attestation format, wallet instance attestation, revocation via Status List [[1]](https://github.com/eu-digital-identity-wallet/eudi-doc-architecture-and-reference-framework) |
| **Wallet Instance Attestation (WIA)** | 2024 | OAuth 2.0 Attestation-Based Client Auth | Wallet proves it is a certified EUDI Wallet to issuers/verifiers; signed by Wallet Provider; bound to wallet's ephemeral key [[1]](https://datatracker.ietf.org/doc/draft-ietf-oauth-attestation-based-client-auth/) |
| **OAuth Status List (revocation)** | 2024 | Bitstring + JWT/CWT | Compact bit-array revocation list embedded in a signed JWT or CWT; used for PID and attestation revocation in EUDI Wallet [[1]](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/) |
| **EUDI Wallet Reference Implementation** | 2024 | Kotlin/Swift + OID4VC stack | EC-funded open-source iOS/Android reference apps; demonstrates full PID issuance and presentation lifecycle [[1]](https://github.com/eu-digital-identity-wallet) |

**State of the art:** ARF v1.4 (2024) mandates SD-JWT-VC and mdoc as PID credential formats with OID4VC transport; BBS+ is listed as a future option for unlinkable presentations. All EU member states must offer EUDI Wallets to citizens by 2026. Depends on [SD-JWT and JWP](#sd-jwt-and-json-web-proof-jwp), [OID4VC](#openid-for-verifiable-credentials-oid4vc), [mDL ISO 18013-5](#mdl-mobile-drivers-license-iso-18013-5), [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), and [Accumulators for Credential Revocation](#accumulators-for-credential-revocation).

**Production readiness:** Experimental
Reference implementations available; EU-wide deployment mandated by 2026; pilot programs active in multiple member states.

**Implementations:**
- [eu-digital-identity-wallet](https://github.com/eu-digital-identity-wallet) — Kotlin/Swift, official EC-funded reference apps (iOS/Android)
- [eudi-doc-architecture-and-reference-framework](https://github.com/eu-digital-identity-wallet/eudi-doc-architecture-and-reference-framework) ⭐ 651 — Architecture Reference Framework documentation

**Security status:** Secure
Combines proven components (SD-JWT, COSE, OAuth 2.0); wallet instance attestation and key binding prevent credential theft; BBS+ under evaluation for unlinkability.

**Community acceptance:** Standard
EU Regulation 2024/1183 (eIDAS 2.0); mandatory for all EU member states; backed by European Commission; ARF developed with broad industry input.

---

## mDL (Mobile Driver's License, ISO 18013-5)

**Goal:** Privacy-preserving machine-readable mobile identity document. ISO 18013-5 defines a mobile driver's licence stored on a smartphone that can be presented in-person (proximity) or remotely. The credential is a CBOR-encoded mdoc signed with COSE; selective attribute disclosure is native; device authentication via ECDH session keys prevents replay; the issuer signature is verified against a PKI (IACA).

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **ISO 18013-5 (mDL standard)** | 2021 | CBOR + COSE (ECDSA P-256) | Core standard; mdoc data model; proximity engagement over BLE/NFC/Wi-Fi Aware; device authentication with ECDH session key; issuer authentication via IACA certificate [[1]](https://www.iso.org/standard/69084.html) |
| **ISO 18013-7 (mdoc over OID4VP)** | 2024 | mdoc + OpenID for VP | Extends 18013-5 for remote presentation via OID4VP; session transcript binds the mdoc to the verifier's nonce [[1]](https://www.iso.org/standard/82772.html) |
| **CBOR / COSE (RFC 8949 / RFC 9052)** | 2020 | Compact binary encoding | Underlying serialization and signing format for mdoc; COSE_Sign1 for issuer auth; COSE_Encrypt0 for optional data encryption [[1]](https://www.rfc-editor.org/rfc/rfc9052) |
| **Apple Wallet mDL / Google Wallet mDL** | 2023 | ISO 18013-5 | Both platforms implemented ISO 18013-5 mDL; US state IDs accepted at TSA checkpoints and select verifiers [[1]](https://developer.apple.com/documentation/passkit/adding-an-identity-document-to-wallet) |
| **mdoc Selective Disclosure** | 2021 | CBOR + per-element digest | Each data element hashed individually; holder presents only chosen elements plus digest; verifier checks IACA-signed digest tree; does not hide which elements were requested by the verifier [[1]](https://www.iso.org/standard/69084.html) |

**State of the art:** ISO 18013-5 (2021) is the dominant machine-readable mDL format; deployed in Apple Wallet, Google Wallet, and US state DMVs (Maryland, Arizona, Georgia, Colorado). ISO 18013-7 (2024) bridges mDL to the [OID4VC](#openid-for-verifiable-credentials-oid4vc) / [EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20) ecosystem. Selective disclosure is hash-based (like [SD-JWT](#sd-jwt-and-json-web-proof-jwp)) but uses CBOR/COSE rather than JSON/JOSE. Related to [Anonymous Credentials](#anonymous-credentials) and [DID/VCs](14-applied-infrastructure-pki.md#w3c-decentralized-identifiers-did-and-verifiable-credentials).

**Production readiness:** Production
Deployed in Apple Wallet and Google Wallet; accepted at US TSA checkpoints; multiple US state DMVs issuing.

**Implementations:**
- [nicola/nicola](https://github.com/nicola/nicola) ⭐ 1 — Swift, Apple ISO 18013-5 sample code

**Security status:** Secure
ECDSA P-256 + ECDH session keys; IACA PKI for issuer authentication; per-element hashing for selective disclosure.

**Community acceptance:** Standard
ISO 18013-5 international standard; ISO 18013-7 for remote presentation; deployed by Apple, Google, and US state governments.

---

## Selective Disclosure Credential Formats Compared

**Goal:** Understand the trade-offs between competing selective-disclosure formats. Four major families coexist: CL Signatures (idemix), BBS+, SD-JWT, and ISO mDL (mdoc). They differ in unlinkability, proof size, issuer infrastructure requirements, and standardization maturity. Choosing the right format depends on whether the holder needs unlinkable presentations, whether the verifier can verify offline, and what ecosystem (ISO, IETF, W3C) they target.

| Format | Year | Disclosure mechanism | Unlinkable | Proof size | PQ-safe | Primary standard |
|--------|------|----------------------|-----------|-----------|---------|-----------------|
| **CL Signatures (idemix)** | 2001 | ZK proof-of-knowledge | Yes | Large (RSA-based) | No | IBM/Hyperledger AnonCreds v1 [[1]](https://eprint.iacr.org/2001/019) |
| **BBS+ Signatures** | 2006 | ZK PoK (pairing-based) | Yes | Short, constant-size | No | W3C VC DI BBS, IETF CFRG draft [[1]](https://www.w3.org/TR/vc-di-bbs/) |
| **SD-JWT (RFC 9591)** | 2025 | Hash digest reveal | No (linkable by default) | Very small (JSON) | Yes | RFC 9591, eIDAS 2.0 EUDI Wallet [[1]](https://www.rfc-editor.org/rfc/rfc9591) |
| **ISO mDL / mdoc (ISO 18013-5)** | 2021 | Per-element CBOR digest | No (linkable by design) | Compact (CBOR/COSE) | No (P-256) | ISO 18013-5, Apple/Google Wallet [[1]](https://www.iso.org/standard/69084.html) |
| **W3C JSON-LD VC + LD-Proofs** | 2022 | Selective JSON-LD frame | Depends on suite | Variable | Depends | W3C VC Data Model 2.0 [[1]](https://www.w3.org/TR/vc-data-model-2.0/) |

**State of the art:** SD-JWT-VC is mandated by the EU EUDI Wallet ARF for PID credentials; BBS+ (W3C VC DI) is under active evaluation for unlinkable presentations. mDL dominates physical identity (airports, DMVs). CL Signatures power Hyperledger AnonCreds deployments. No single format dominates all axes. See [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), [SD-JWT and JSON Web Proof](#sd-jwt-and-json-web-proof-jwp), [mDL ISO 18013-5](#mdl-mobile-drivers-license-iso-18013-5), and [Anonymous Credentials](#anonymous-credentials).

**Production readiness:** Production
All four major formats have production deployments: CL (AnonCreds), BBS+ (W3C VC DI), SD-JWT (RFC 9591), mDL (ISO 18013-5).

**Implementations:**
- [hyperledger/anoncreds-rs](https://github.com/hyperledger/anoncreds-rs) ⭐ 85 — Rust, CL-based AnonCreds
- [mattrglobal/bbs-signatures](https://github.com/mattrglobal/bbs-signatures) ⭐ 126 [archived] — TypeScript, BBS+ signatures
- [danielfett/sd-jwt](https://github.com/danielfett/sd-jwt) ⭐ 4 — Python, SD-JWT reference

**Security status:** Secure
All formats are secure at recommended parameters; CL and BBS+ are not PQ-safe; SD-JWT is PQ-safe (hash-based).

**Community acceptance:** Standard
Each format is standardized in its domain: CL (Hyperledger), BBS+ (W3C/IETF), SD-JWT (IETF RFC), mDL (ISO). No single format dominates all use cases.

---

## Anonymous Credentials vs Group Signatures vs Ring Signatures

**Goal:** Distinguish three overlapping notions of anonymous authentication. All three let a member prove group membership without revealing which member they are, but they differ in trust model, credential structure, revocability, and linkability properties. Understanding the differences is essential for choosing the right primitive.

| Property | Anonymous Credentials | Group Signatures | Ring Signatures |
|----------|-----------------------|-----------------|-----------------|
| **Trust model** | Issuer + verifier | Group manager (GM) | No trusted party |
| **Membership management** | Issuer controls | GM adds/revokes members | Signer self-selects ring from public keys |
| **Opening / accountability** | Optional (DAA-style) | GM can de-anonymize | None (fully anonymous) |
| **Attribute disclosure** | Selective (CL, BBS+, SD-JWT) | None (membership only) | None (membership only) |
| **Linkability across uses** | Configurable (nullifiers / KVAC) | Configurable (traceable) | Linkable ring sigs add key images |
| **Infrastructure** | Issuer PKI required | GM PKI required | None — uses existing pubkeys |
| **Primary schemes** | CL, BBS+, PS, KVAC | BBS group sig, EPID | LSAG, CLSAG (Monero), BLSAG |
| **Standard deployments** | IRMA/Yivi, Signal, EUDI Wallet | Intel EPID (SGX), TPM DAA | Monero |

| Scheme family | Year | Key reference |
|---------------|------|---------------|
| **Anonymous Credentials (CL)** | 2001 | Selective attribute disclosure; issuer-issued [[1]](https://eprint.iacr.org/2001/019) |
| **Group Signatures (BMW model)** | 2003 | Bellare-Micciancio-Warinschi formal model; opening by GM [[1]](https://eprint.iacr.org/2002/072) |
| **Ring Signatures (RST)** | 2001 | Rivest-Shamir-Tauman; no group manager; spontaneous [[1]](https://link.springer.com/chapter/10.1007/3-540-45682-1_32) |
| **Linkable Ring Signatures (LRS)** | 2004 | Liu-Wei-Wong; key image prevents double-use, preserves anonymity [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30539-2_15) |
| **Traceable Ring Signatures** | 2007 | Fujisaki-Suzuki; signer-traceable on double-spend; used in e-cash-like protocols [[1]](https://eprint.iacr.org/2006/389) |

**State of the art:** Anonymous credentials provide the richest attribute functionality; group signatures add mandatory accountability (GM can open); ring signatures require no issuer but offer only membership proofs. Modern usage: [CLSAG (Monero)](#moneros-privacy-stack) for ring sigs, [Intel EPID / DAA](#direct-anonymous-attestation-daa) for group sigs, [BBS+](#bbs-anonymous-credentials) / [KVAC](#keyed-verification-anonymous-credentials-kvac) for anonymous credentials. See [Ring & Group Signatures](08-signatures-advanced.md#ring-group-signatures).

**Production readiness:** Production
All three families have production deployments: BBS+/KVAC (credentials), EPID (group sigs), CLSAG (ring sigs).

**Implementations:**
- [signalapp/libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, KVAC anonymous credentials (Signal)
- [intel/linux-sgx](https://github.com/intel/linux-sgx) ⭐ 1.4k — C++, EPID group signatures (Intel SGX)
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, CLSAG ring signatures (Monero)

**Security status:** Secure
Each family is secure under its respective assumptions; choice depends on trust model and accountability requirements.

**Community acceptance:** Widely trusted
All three are well-studied with decades of research; deployed in major systems (Signal, Intel SGX, Monero); clear taxonomy established in literature.

---

## Anonymous Whistleblowing Systems

**Goal:** Source-protecting document submission. Journalists and watchdog organizations need to receive sensitive documents from anonymous sources without exposing the source's network location, device identity, or submission metadata. The cryptographic stack must provide end-to-end encryption, server-side message separation, and Tor-based transport anonymity — even if the organization's servers are compromised.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **DeadDrop (precursor)** | 2012 | Tor + GPG | Aaron Swartz / Kevin Poulsen; early prototype; GPG encryption, Tor hidden service for submissions [[1]](https://github.com/freedomofpress/securedrop) |
| **SecureDrop** | 2013 | Tor v2/v3 + GPG + Tails | Freedom of the Press Foundation; journalist-facing decryption on air-gapped Tails machine; source uses Tor Browser to submit files; production at NYT, WaPo, Guardian, 70+ orgs [[1]](https://securedrop.org/) |
| **SecureDrop Workstation** | 2019 | Qubes OS + Tor + GPG | Air-gapped journalist workstation using Qubes OS compartmentalization; each submission in isolated VM; metadata-stripped document handling [[1]](https://securedrop.org/news/introducing-securedrop-workstation/) |
| **GlobaLeaks** | 2012 | Tor + end-to-end enc | HTTPS-over-Tor submission; AES-256 / PGP file encryption; journalists' public keys held server-side (trust shift vs. SecureDrop); deployed in EU anti-corruption contexts [[1]](https://www.globaleaks.org/) |
| **OnionShare** | 2014 | Tor v3 onion + HTTPS | Single-use ephemeral onion address for file drops or chat; no server infrastructure required; sender and receiver both anonymous [[1]](https://onionshare.org/) |

**State of the art:** SecureDrop (Freedom of the Press Foundation, v2.x) with Qubes OS Workstation is the gold standard for high-security anonymous document submission. GlobaLeaks is more accessible but has a weaker threat model (server holds recipient keys). OnionShare enables ad-hoc anonymous file sharing without dedicated infrastructure. All three rely on [Tor v3 Onion Services](#tor-v3-onion-services) for network anonymity and [OpenPGP](12-secure-communication-protocols.md#openpgp-rfc-9580) for end-to-end encryption.

**Production readiness:** Production
SecureDrop deployed at 70+ news organizations (NYT, WaPo, Guardian); GlobaLeaks used in EU anti-corruption.

**Implementations:**
- [freedomofpress/securedrop](https://github.com/freedomofpress/securedrop) ⭐ 3.8k — Python, SecureDrop submission system
- [globaleaks/globaleaks](https://github.com/globaleaks/GlobaLeaks) ⭐ 1.4k — Python, GlobaLeaks whistleblowing platform
- [onionshare/onionshare](https://github.com/onionshare/onionshare) ⭐ 6.9k — Python, ephemeral onion file sharing

**Security status:** Caution
Cryptographically sound (Tor + GPG/PGP); operational security is the primary risk — source behavior, metadata leaks, and compromised endpoints.

**Community acceptance:** Widely trusted
SecureDrop is the gold standard endorsed by Freedom of the Press Foundation; recommended by CPJ and RSF for journalist source protection.

---

## Private Communication with Metadata Protection

**Goal:** Hide not just message content but communication metadata — who talks to whom, when, and how often. Standard E2EE messengers (Signal, WhatsApp) encrypt content but leak social graphs to the server. A stronger model hides contact graphs, message timing, and group membership from the service provider and network observers.

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Session (formerly Loki Messenger)** | 2020 | Signal protocol + onion routing | No phone number required; decentralized node network; messages routed through 3-hop onion paths (Lokinet); no central server logs contact graph [[1]](https://getsession.org/) |
| **SimpleX Chat** | 2022 | Double Ratchet + SMP queues | No user identifiers at all (no phone, email, or username stored server-side); per-contact unidirectional message queues; server sees only encrypted queue items, not sender-receiver pairs [[1]](https://simplex.chat/docs/protocol/simplex-messaging.html) |
| **Briar** | 2013 | Tor + Bramble transport | No central server; syncs over Tor, Wi-Fi, or Bluetooth (device-to-device); designed for activists in connectivity-restricted environments; Bramble Synchronisation Protocol (BSP) [[1]](https://briarproject.org/how-it-works/) |
| **Cwtch** | 2018 | Tor v3 onion services + multi-party | Group conversations over Tor onion services; server-side stores nothing (server is just an onion service relay); metadata-private by design [[1]](https://cwtch.im/) |
| **Vuvuzela / Alpenhorn** | 2015 | DC-nets + noise | Research system: adds cover traffic with differential-privacy guarantees on metadata; provable metadata privacy bounds; not yet deployed at scale [[1]](https://dl.acm.org/doi/10.1145/2815400.2815417) |

**State of the art:** SimpleX Chat (2022–) provides the strongest deployed metadata privacy: zero persistent user identifiers, per-contact queue pairs, and no server-side social graph. Session provides decentralized onion routing without phone numbers. Briar is unique in peer-to-peer operation over Tor and Bluetooth — no infrastructure required. Vuvuzela (research) gives formal differential-privacy metadata bounds. Complements [Onion Routing](#onion-routing), [Mix Networks](#mix-networks-mixnets), and [Double Ratchet / Signal Protocol](12-secure-communication-protocols.md#double-ratchet-symmetric-ratchet).

**Production readiness:** Production
SimpleX Chat and Session are production apps with active user bases; Briar deployed for activist use.

**Implementations:**
- [simplex-chat/simplex-chat](https://github.com/simplex-chat/simplex-chat) ⭐ 10k — Haskell, SimpleX Chat with metadata protection
- [briar/briar](https://code.briarproject.org/briar/briar) — Java, Briar peer-to-peer messenger
- [cwtch.im/cwtch](https://git.openprivacy.ca/cwtch.im/cwtch) — Go, metadata-resistant messenger
- [nicola/session-desktop](https://github.com/session-foundation/session-desktop) ⭐ 431 — TypeScript, Session messenger

**Security status:** Caution
Strong cryptographic foundations (Double Ratchet, Tor); metadata privacy depends on network conditions and anonymity set size.

**Community acceptance:** Emerging
SimpleX and Briar recommended by privacy researchers; Vuvuzela remains research-only; growing awareness of metadata privacy importance.

---

## Aztec Protocol (Private Smart Contracts)

**Goal:** Confidential smart contract execution on a public blockchain. Aztec extends the EVM model with a private-state model: user account state is stored as encrypted UTXO-style notes in a global append-only note hash tree; smart contracts operate over ZK-proven note transitions; public calldata reveals only the ZK proof, never the input values or which notes were consumed. Provides programmable privacy — like Zcash but for arbitrary smart contract logic.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Aztec 2.0 (PLONK-based rollup)** | 2021 | PLONK + UltraPLONK | First Aztec rollup on Ethereum mainnet; private token transfers (zkDAI); proofs generated client-side; ~45 s proof time on desktop [[1]](https://aztec.network/blog/aztec-2-0/) |
| **Aztec Connect** | 2022 | PLONK + bridge contracts | Privacy-preserving bridge to public DeFi (Aave, Uniswap); user's identity hidden; public contract output visible but not linked to user [[1]](https://aztec.network/blog/aztec-connect/) |
| **Aztec Network (Noir-based, Sandbox)** | 2023 | UltraHonk + Noir DSL | Programmable private smart contracts; Noir: Rust-like ZK DSL compiling to UltraHonk circuits; private/public state separation; note encryption with in-contract key derivation [[1]](https://noir-lang.org/) |
| **Aztec Sequencer / Fernet** | 2024 | Encrypted mempool + PBS | Sequencer sees only encrypted transaction blobs; decentralized sequencer selection; block building without transaction inspection; mev-resistance via sealed-bid ordering [[1]](https://aztec.network/blog/aztec-network-decentralization/) |
| **Noir Language** | 2023 | ACIR (Abstract Circuit IR) | Domain-specific language for ZK circuits; compiles to ACIR; backends: Barretenberg (UltraHonk/PLONK), Gnark, Halo2; used beyond Aztec for general ZK app development [[1]](https://noir-lang.org/docs/) |

**State of the art:** Aztec Network (Noir + UltraHonk, 2024 testnet) is the most advanced programmable-privacy L2 — combining UTXO-style private state with arbitrary smart contract logic. The Noir language is gaining adoption as a general ZK DSL beyond Aztec. Complements [Zcash Shielded Protocols](#zcash-shielded-protocols-sapling-orchard) (fixed note semantics) and [Privacy Pools](#privacy-pools) (compliance-aware mixing). Relies on [PLONK / UltraHonk](04-zero-knowledge-proof-systems.md#zero-knowledge-proof-systems) proof systems and [Encrypted Mempools](13-blockchain-distributed-ledger.md#encrypted-mempools-threshold-encryption-for-transaction-ordering).

**Production readiness:** Experimental
Aztec Network testnet active (2024); Noir language gaining adoption; Aztec 2.0/Connect were deployed on Ethereum mainnet.

**Implementations:**
- [AztecProtocol/aztec-packages](https://github.com/AztecProtocol/aztec-packages) ⭐ 435 — TypeScript/Noir, Aztec Network monorepo
- [noir-lang/noir](https://github.com/noir-lang/noir) ⭐ 1.3k — Rust, Noir ZK DSL and compiler
- [AztecProtocol/barretenberg](https://github.com/AztecProtocol/barretenberg) ⭐ 194 — C++, UltraHonk/PLONK backend

**Security status:** Caution
UltraHonk/PLONK proofs are well-studied; testnet stage means production security is not yet battle-tested; Noir circuits require careful auditing.

**Community acceptance:** Emerging
Active developer community; Noir adopted beyond Aztec ecosystem; backed by a]( Labs (formerly Aztec); significant VC funding.

---

## Browser Fingerprinting and Anonymity Defenses

**Goal:** Prevent passive de-anonymization via device and browser attributes. A web server can identify (fingerprint) a user by combining browser version, screen resolution, fonts, WebGL renderer, canvas rendering artefacts, and dozens of other signals — without cookies. These fingerprints can re-identify users across sessions and break anonymity even when using Tor or VPNs. Defenses range from attribute normalization to active noise injection and formal notions of k-anonymity sets.

| Mechanism | Year | Basis | Note |
|-----------|------|-------|------|
| **Panopticlick / AmIUnique** | 2010 | Entropy measurement | EFF study showing browser fingerprints uniquely identify ~83–95% of users; quantifies k-anonymity set size [[1]](https://coveryourtracks.eff.org/) |
| **Tor Browser Letterboxing** | 2019 | Viewport normalization | Tor Browser rounds viewport size to multiples of 200×100 px; reduces screen-resolution fingerprint entropy to near zero [[1]](https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/23339) |
| **Tor Browser Fingerprinting Resistance (RFP)** | 2016 | Attribute normalization | Firefox `privacy.resistFingerprinting`; normalizes user-agent, timezone (UTC), canvas noise, WebGL strings, fonts, media queries, hardware concurrency [[1]](https://www.torproject.org/docs/torbutton/design/) |
| **Canvas Randomization (FPRandom)** | 2017 | Controlled noise injection | Inject sub-pixel randomness into Canvas2D/WebGL output; breaks pixel-level fingerprinting without perceptual quality loss [[1]](https://hal.inria.fr/hal-01527580) |
| **k-Fingerprint (Laperdrix et al.)** | 2020 | Machine-learning analysis | Formal study of which attributes are most identifying; informs which signals deserve normalization priority [[1]](https://arxiv.org/abs/2001.04558) |
| **Privacy Budget (Chrome)** | 2023 | API surface quantification | Proposed Chrome mechanism: track entropy consumed by JS APIs per origin; block calls exceeding a per-session budget [[1]](https://github.com/bslassey/privacy-budget) |

**State of the art:** Tor Browser with Letterboxing + RFP (Firefox `privacy.resistFingerprinting`) is the most comprehensive deployed defense, aiming for a uniform fingerprint across all Tor Browser users. Brave Browser independently applies canvas noise and aggressive API normalization. Chrome's Privacy Budget remains experimental. Related to [Onion Routing](#onion-routing), [Tor v3 Onion Services](#tor-v3-onion-services), and [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy).

**Production readiness:** Production
Tor Browser with RFP and Letterboxing deployed to millions of users; Brave Browser applies independent fingerprinting defenses.

**Implementations:**
- [nicola/tor-browser](https://gitlab.torproject.org/tpo/applications/tor-browser) — C++/JS, Tor Browser with fingerprinting resistance
- [nicola/nicola](https://github.com/nicola/nicola) ⭐ 1 — Brave Browser with fingerprinting defenses
- [nicola/nicola](https://coveryourtracks.eff.org/) — EFF Cover Your Tracks fingerprint testing tool

**Security status:** Caution
No defense achieves perfect untraceability; Tor Browser offers the strongest deployed fingerprint normalization; arms race with fingerprinting techniques.

**Community acceptance:** Widely trusted
Tor Browser's RFP is the reference standard; adopted by Firefox (privacy.resistFingerprinting); EFF's research widely cited.

---

## Nym Network

**Goal:** Deployed incentivized mixnet with anonymous access credentials, providing network-level privacy by routing packets through a Loopix-inspired continuous-time mixnet with token-incentivized mix nodes and zk-nym threshold-issued anonymous credentials.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Nym Mixnet (mainnet)** | 2022 | Loopix + Sphinx + Poisson mixing | Deployed network with token-incentivized mix nodes; Sphinx packet format; cover loop traffic; stratified topology [[1]](https://nymtech.net/nym-whitepaper.pdf) |
| **zk-nym credentials** | 2022 | Coconut (PS signatures) + threshold blind issuance | Validators collectively blind-sign credential requests; re-randomizable credentials prevent linkage between payment and network usage [[1]](https://nymtech.net/) |
| **NymVPN** | 2024 | Nym mixnet + WireGuard exit | End-user VPN product; two modes: 5-hop mixnet (highest privacy) or 2-hop decentralized VPN [[1]](https://nymtech.net/) |

**State of the art:** Nym mainnet (launched 2022) is the largest deployed incentivized mixnet, extending [Loopix](#mix-networks-mixnets) with token economics and anonymous credentials. Complements [Mix Networks](#mix-networks-mixnets) and [Coconut Credentials](#delegatable-anonymous-credentials).

**Production readiness:** Production
Nym mainnet launched 2022; NymVPN released 2024; token-incentivized mix nodes operational.

**Implementations:**
- [nymtech/nym](https://github.com/nymtech/nym) ⭐ 1.7k — Rust, Nym mixnet, credentials, and client libraries
- [nymtech/nym-vpn-client](https://github.com/nymtech/nym-vpn-client) ⭐ 384 — Rust, NymVPN client application

**Security status:** Secure
Loopix-based mixing with formal DP bounds; Coconut credentials for anonymous access; Sphinx packet format proven secure.

**Community acceptance:** Emerging
Active mainnet with token incentives; endorsed by privacy researchers; growing user base via NymVPN; not yet standardized.

---

## Katzenpost

**Goal:** Open-source production Sphinx mixnet framework providing a complete, audited implementation of a layered mix network for anonymous messaging services, including mix PKI with directory authorities and per-hop cover traffic.

| Component | Year | Basis | Note |
|-----------|------|-------|------|
| **Katzenpost Mix Network Specification** | 2017 | Sphinx + Loopix topology | Authored by Angel, Danezis, Diaz, Piotrowska, Stainton; layered topology; mix PKI via directory authorities; Poisson delay [[1]](https://katzenpost.network/) |
| **Katzenpost Wire Protocol** | 2017 | Noise (X pattern) + Sphinx | Authenticated transport between clients and mixes; forward-secret session establishment [[1]](https://github.com/katzenpost/katzenpost) |
| **Katzenpost PQ Mixnet** | 2023 | CTIDH / ML-KEM + Sphinx | First post-quantum mixnet in production; hybrid classical+PQ key encapsulation in Sphinx headers [[1]](https://katzenpost.network/) |

**State of the art:** Katzenpost (2023) is the world's first post-quantum production mixnet and the primary open-source framework for Loopix-style anonymous messaging. Builds on [Mix Networks](#mix-networks-mixnets); complements [Nym Network](#nym-network).

**Production readiness:** Experimental
Production-grade software with PQ support; deployed in test networks; world's first post-quantum mixnet.

**Implementations:**
- [katzenpost/katzenpost](https://github.com/katzenpost/katzenpost) ⭐ 147 — Go, full Katzenpost mixnet implementation (client, server, PKI, Sphinx)

**Security status:** Secure
Sphinx packet format proven secure; PQ key exchange via CTIDH/ML-KEM; Loopix-style mixing with formal DP guarantees.

**Community acceptance:** Niche
Respected in academic mixnet community; first PQ production mixnet; smaller deployment than Nym; actively developed.

---

## Riffle

**Goal:** Efficient anonymous communication with strong anonymity against active adversaries, combining a verifiable shuffle-based mixnet with private information retrieval so anonymity holds as long as at least one server is honest.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Riffle** | 2016 | Verifiable shuffle + cPIR | Servers permute ciphertexts with ZK shuffle proofs; clients retrieve via PIR; one-honest-server guarantee; 100 KB/s per user at 200-user anonymity set [[1]](https://people.csail.mit.edu/devadas/pubs/riffle.pdf) |

**State of the art:** Riffle (PETS 2016, Kwon-Lazar-Devadas-Ford) provides stronger active-adversary guarantees than pure mixnets by coupling verifiable shuffles with PIR retrieval. Related to [Mix Networks](#mix-networks-mixnets) and [DC-Nets](#dc-nets-dining-cryptographers-networks).

**Production readiness:** Research
Academic prototype only (MIT CSAIL, 2016); no production deployment.

**Implementations:**
- [Riffle prototype](https://people.csail.mit.edu/devadas/pubs/riffle.pdf) — research prototype described in paper

**Security status:** Secure
Verifiable shuffle + PIR provides one-honest-server guarantee; proven secure against active adversaries.

**Community acceptance:** Niche
Published at PETS 2016; well-cited in anonymous communication research; no implementation beyond academic prototype.

---

## Riposte

**Goal:** Anonymous broadcast messaging at million-user scale for whistleblowing, extending the DC-net model with private information retrieval so servers learn nothing about who published what while preventing anonymous denial-of-service by malicious clients.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Riposte** | 2015 | DC-net + cPIR + write-private data structure | Three-server architecture; clients secret-share writes across servers; PIR technique prevents server collusion identifying senders; resists active client DoS; 2.9M-user anonymity set in 32 hours [[1]](https://arxiv.org/abs/1503.06115) |

**State of the art:** Riposte (IEEE S&P 2015, Corrigan-Gibbs-Boneh-Mazières) was the first system providing traffic-analysis resistance, DoS prevention, and million-user anonymity sets for anonymous broadcast. Superseded in throughput by [Express](#express) but remains the reference design. Extends [DC-Nets](#dc-nets-dining-cryptographers-networks).

**Production readiness:** Research
Academic prototype (Stanford, 2015); demonstrated million-user anonymity sets; no production deployment.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
DC-net foundations provide information-theoretic anonymity; PIR prevents server collusion; active DoS resistance.

**Community acceptance:** Niche
Published at IEEE S&P 2015; foundational reference for anonymous broadcast; superseded in throughput by Express.

---

## Pung

**Goal:** Unobservable private two-party messaging over untrusted infrastructure, hiding both message content and communication metadata using computational PIR so no trusted relays are needed.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Pung** | 2016 | cPIR + bucketed key-value store + batch coding | Untrusted key-value store; users agree on shared labels out-of-band; retrieval via cPIR with bucketing; handles 103× more users than prior PIR-messaging systems [[1]](https://www.usenix.org/conference/osdi16/technical-sessions/presentation/angel) |

**State of the art:** Pung (OSDI 2016, Angel-Setty) established the PIR-based metadata-hiding messaging paradigm later extended by [Express](#express) and [Talek](#talek). Related to [PIR](10-privacy-preserving-computation.md#private-information-retrieval-pir).

**Production readiness:** Research
Academic prototype (UT Austin / Microsoft Research, 2016); no production deployment.

**Implementations:**
- [nicola/pung](https://github.com/pung-project/pung) ⭐ 35 — C++, PIR-based metadata-hiding messaging prototype

**Security status:** Secure
Computational PIR provides cryptographic guarantees; no trusted relays required; security proven under standard assumptions.

**Community acceptance:** Niche
Published at OSDI 2016; established the PIR-based metadata-hiding messaging paradigm; extended by Express and Talek.

---

## Express

**Goal:** Efficient metadata-hiding communication using only symmetric cryptography, achieving constant per-user overhead regardless of user count through XOR-based PIR in a two-server model.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Express** | 2021 | XOR-based PIR (symmetric key) + two-server model | Constant per-user overhead vs. O(√N) for prior systems; fully symmetric-key primitives; 10–100× faster than Riposte; tolerates one malicious server [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/eskandarian) |

**State of the art:** Express (USENIX Security 2021, Eskandarian-Corrigan-Gibbs-Zaharia-Boneh) is the current practical frontier for metadata-hiding messaging, superseding [Pung](#pung) and [Riposte](#riposte) in efficiency. Related to [PIR](10-privacy-preserving-computation.md#private-information-retrieval-pir).

**Production readiness:** Research
Academic prototype (Stanford, 2021); 10-100x faster than prior systems; no production deployment.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Symmetric-key only; two-server model with one-malicious-server tolerance; proven security.

**Community acceptance:** Niche
Published at USENIX Security 2021; current practical frontier for metadata-hiding messaging; well-cited in privacy research.

---

## Talek

**Goal:** Private group messaging with hidden access patterns, concealing which users read/write to which channels from servers using information-theoretic PIR with an anytrust multi-server model.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Talek** | 2020 | IT-PIR + blocked cuckoo hashing + private notifications | Multi-server anytrust model; blocked cuckoo hashing amortizes PIR cost; private notifications avoid polling; 9,433 msg/s for 32,000 users at 1.7 s latency [[1]](https://eprint.iacr.org/2020/066.pdf) |

**State of the art:** Talek (ACSAC 2020) achieves the strongest access-pattern privacy among deployed-scale anonymous group messaging systems. Complements [Pung](#pung) and [Express](#express). Related to [PIR](10-privacy-preserving-computation.md#private-information-retrieval-pir).

**Production readiness:** Research
Academic prototype (2020); demonstrated 9,433 msg/s for 32,000 users; no production deployment.

**Implementations:**
- [nicola/talek](https://github.com/privacylab/talek) ⭐ 52 — Go, PIR-based private group messaging

**Security status:** Secure
Information-theoretic PIR provides strongest access-pattern privacy; anytrust multi-server model.

**Community acceptance:** Niche
Published at ACSAC 2020; well-regarded in anonymous messaging research; no adoption beyond academic community.

---

## Karaoke

**Goal:** Distributed private messaging with formal differential-privacy guarantees against a global passive adversary, improving on Vuvuzela with optimistic indistinguishability to achieve 5–10× better latency.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Karaoke** | 2018 | Dead-drop mailboxes + differential-privacy noise + optimistic indistinguishability | Distributed servers; two messages per round (one real, one cover); formal DP bound on metadata leakage; 6.8 s latency for 2M users; 5–10× faster than Vuvuzela [[1]](https://www.usenix.org/conference/osdi18/presentation/lazar) |

**State of the art:** Karaoke (OSDI 2018, Lazar-Gilad-Zeldovich) is the most efficient system providing formal differential-privacy metadata guarantees at million-user scale. Relates to [Differential Privacy](10-privacy-preserving-computation.md#differential-privacy) and [Mix Networks](#mix-networks-mixnets).

**Production readiness:** Research
Academic prototype (MIT CSAIL, 2018); no production deployment.

**Implementations:**
- [Karaoke prototype](https://www.usenix.org/conference/osdi18/presentation/lazar) — research prototype described in paper

**Security status:** Secure
Formal differential-privacy guarantees on metadata leakage; proven security bounds.

**Community acceptance:** Niche
Published at OSDI 2018; most efficient system with formal DP metadata guarantees; cited in privacy research but no production use.

---

## Traffic Analysis Attacks and Cover Traffic Defenses

**Goal:** Formalize how adversaries infer communication relationships from traffic metadata and analyze countermeasures (cover traffic, timing obfuscation, adaptive padding) that protect anonymity even when encryption is assumed to be unbroken.

| Attack / Defense | Year | Basis | Note |
|-----------------|------|-------|------|
| **Statistical Disclosure Attack (SDA)** | 2003 | Long-term intersection | Danezis: adversary accumulates round observations to statistically identify recipients; primary countermeasure is cover traffic [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30114-1_21) |
| **Timing correlation attack** | 2004 | End-to-end timing on Tor | Global passive adversary correlates entry/exit traffic; fundamental limitation of low-latency onion routing [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Website fingerprinting (WF)** | 2014 | Traffic pattern ML | Wang-Goldberg: random-forest classifier identifies Tor-visited websites with >90% accuracy; motivates traffic-shaping defenses [[1]](https://dl.acm.org/doi/10.1145/2660267.2660368) |
| **WTF-PAD** | 2016 | Histogram-based adaptive padding | Juarez et al.: lightweight adaptive padding in Tor; significantly reduces WF classifier accuracy with ~30% bandwidth overhead; deployed in Tor Browser [[1]](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/juarez) |
| **Tamaraw** | 2014 | Constant-rate padding | Wang-Goldberg: pads to fixed packet-count schedule; resists fingerprinting at ~3× bandwidth cost [[1]](https://dl.acm.org/doi/10.1145/2660267.2660368) |
| **Loopix cover traffic model** | 2017 | Poisson-distributed cover loops | Continuous loop cover messages provide formal DP bound on traffic analysis; standard in modern mixnets [[1]](https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/piotrowska) |

**State of the art:** Loopix-style Poisson cover traffic (deployed in [Nym Network](#nym-network) and [Katzenpost](#katzenpost)) provides the strongest formal differential-privacy bound for high-latency mixnets. WTF-PAD (deployed in Tor Browser) and Tamaraw reduce website fingerprinting for low-latency systems. Foundational context for [Mix Networks](#mix-networks-mixnets), [Onion Routing](#onion-routing), and [Karaoke](#karaoke).

**Production readiness:** Production
WTF-PAD deployed in Tor Browser; Loopix cover traffic model deployed in Nym and Katzenpost.

**Implementations:**
- [nicola/tor-browser](https://gitlab.torproject.org/tpo/applications/tor-browser) — C++/JS, Tor Browser with WTF-PAD adaptive padding
- [nymtech/nym](https://github.com/nymtech/nym) ⭐ 1.7k — Rust, Loopix-style Poisson cover traffic in Nym
- [katzenpost/katzenpost](https://github.com/katzenpost/katzenpost) ⭐ 147 — Go, cover traffic in Katzenpost mixnet

**Security status:** Caution
Cover traffic provides formal DP bounds for mixnets; low-latency defenses (WTF-PAD) reduce but do not eliminate fingerprinting; arms race with ML-based attacks.

**Community acceptance:** Widely trusted
Traffic analysis is a well-studied research area; WTF-PAD adopted by Tor Project; Loopix model is the standard for modern mixnet cover traffic.

---

## Oblivious Pseudorandom Functions (OPRF / VOPRF / POPRF)

**Goal:** A two-party protocol where a server holds a PRF key k and a client holds an input x; the client obtains PRF(k, x) without the server learning x, and (in the verifiable variant) with a proof that the output is correct. OPRFs are the cryptographic core of Privacy Pass, password-hardening (OPAQUE), and private set intersection. The partially-oblivious variant (POPRF) allows a public metadata tag to be bound into the evaluation.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Naor-Reingold OPRF** | 2004 | DH-based blind evaluation | Foundational construction: client blinds input, server evaluates on blinded point, client unblinds; basis for all modern EC-based OPRFs [[1]](https://eprint.iacr.org/2004/093) |
| **VOPRF (Verifiable OPRF)** | 2015 | DH + DLEQ proof | Jarecki-Kiayias-Krawczyk: server attaches a DLEQ proof that the evaluation used the committed key; prevents malicious tagging [[1]](https://eprint.iacr.org/2014/650) |
| **IETF OPRF (RFC 9497)** | 2023 | Ristretto255 / P-384 + DLEQ | Standardized OPRF, VOPRF, and POPRF modes; POPRF binds public info into evaluation; used in Privacy Pass (RFC 9576) and OPAQUE [[1]](https://www.rfc-editor.org/rfc/rfc9497) |
| **2HashDH OPRF** | 2005 | Hash-to-curve + DH | Simple two-hash construction: H-to-curve, blind, evaluate, unblind; instantiated in Privacy Pass v1; proven in ROM [[1]](https://eprint.iacr.org/2005/010) |
| **Threshold OPRF (tOPRF)** | 2020 | DH + Shamir secret sharing | Key split across n servers; t-of-n threshold evaluation; prevents single-server key compromise; used in distributed OPAQUE variants [[1]](https://eprint.iacr.org/2017/363) |

**State of the art:** IETF RFC 9497 (2023) standardizes OPRF/VOPRF/POPRF over Ristretto255 and P-384. Deployed in [Privacy Pass](#privacy-pass-anonymous-tokens) (RFC 9576), [OPAQUE](03-key-exchange-key-management.md#password-authenticated-key-exchange-pake), and private contact discovery. Threshold OPRF enables distributed credential issuance without a single point of trust. Related to [PRF/PRP](01-foundational-primitives.md#pseudorandom-functions-prf-pseudorandom-permutations-prp).

**Production readiness:** Production
IETF RFC 9497 (2023); deployed in Privacy Pass (RFC 9576), OPAQUE password protocol, and private contact discovery.

**Implementations:**
- [cloudflare/circl](https://github.com/cloudflare/circl) ⭐ 1.6k — Go, Cloudflare's OPRF/VOPRF implementation
- [cloudflare/circl](https://github.com/cloudflare/circl) ⭐ 1.6k — Go, Cloudflare's crypto library with OPRF/VOPRF
- [cfrg/draft-irtf-cfrg-voprf](https://github.com/cfrg/draft-irtf-cfrg-voprf) ⭐ 39 — IETF draft and test vectors
- [nicola/voprf-ts](https://github.com/cloudflare/voprf-ts) ⭐ 38 — TypeScript, VOPRF implementation

**Security status:** Secure
DH-based with DLEQ proofs; proven in ROM; standardized over Ristretto255 and P-384.

**Community acceptance:** Standard
IETF RFC 9497; deployed by Cloudflare, Apple, Google; foundational primitive for Privacy Pass and OPAQUE.

---

## Group Signatures with Verifier-Local Revocation (VLR)

**Goal:** Group signatures where revocation checks are performed entirely by the verifier using a public revocation list, without requiring signers to update their keys or interact with the group manager after initial enrollment. The verifier checks each signature against a revocation list of revocation tokens; if a match is found, the signature is rejected. Critical for offline verification scenarios (mDL, TPM attestation, transit cards).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boneh-Shacham VLR Group Sig** | 2004 | Pairings / q-SDH | First VLR group signature; verifier checks sig against revocation tokens in O(R) time per verification; no signer update needed [[1]](https://eprint.iacr.org/2004/234) |
| **Nakanishi-Funabiki Efficient VLR** | 2005 | Pairings + accumulator | Reduced verification to O(1) using accumulator-based non-revocation witness; signer carries witness [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30580-4_5) |
| **EPID 2.0 (VLR mode)** | 2011 | Pairings + Brickell-Li | Intel EPID with VLR: verifier holds SigRL (signature revocation list); checks each sig against SigRL entries; deployed in SGX attestation [[1]](https://eprint.iacr.org/2009/095) |
| **Lattice-Based VLR Group Sig (Langlois et al.)** | 2014 | SIS + LWE | First post-quantum VLR group signature; proof size O(n log n) but avoids pairings entirely [[1]](https://eprint.iacr.org/2014/033) |
| **Dynamic VLR Group Sig (Perera-Koshiba)** | 2018 | Pairings + dynamic join | Supports dynamic member enrollment without re-keying; VLR revocation remains verifier-local [[1]](https://eprint.iacr.org/2018/485) |

**State of the art:** Intel EPID with SigRL-based VLR is the most widely deployed VLR group signature scheme (billions of Intel CPUs). Lattice-based VLR (Langlois et al.) provides the post-quantum path. VLR is the revocation model used in [Direct Anonymous Attestation (DAA)](#direct-anonymous-attestation-daa) and complements [Accumulators for Credential Revocation](#accumulators-for-credential-revocation). Related to [Ring & Group Signatures](08-signatures-advanced.md#ring-group-signatures).

**Production readiness:** Production
Intel EPID with SigRL-based VLR deployed in billions of Intel CPUs for SGX attestation.

**Implementations:**
- [intel/linux-sgx](https://github.com/intel/linux-sgx) ⭐ 1.4k — C++, Intel EPID with VLR mode
- [intel/linux-sgx](https://github.com/intel/linux-sgx) ⭐ 1.4k — C++, Intel EPID with SigRL-based VLR

**Security status:** Caution
Cryptographically sound; O(R) revocation check per verification can be slow for large revocation lists; lattice-based VLR provides PQ path but with larger proofs.

**Community acceptance:** Standard
Intel EPID is an industry standard; Boneh-Shacham VLR is a foundational paper; ISO/IEC 20008-2 covers ECDAA with VLR.

---

## zkSNARK-Based Anonymous Credentials

**Goal:** Anonymous credentials where the presentation proof is a general-purpose zkSNARK rather than a scheme-specific sigma protocol. The issuer signs attributes (using ECDSA, EdDSA, or any standard signature); the holder proves knowledge of a valid signature and arbitrary predicates over attributes inside a zkSNARK circuit. This decouples the credential format from the privacy layer — any signed data can be made selectively disclosable after the fact.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **zk-creds (Rosenberg et al.)** | 2023 | Groth16 / PLONK + ECDSA-in-circuit | Prove possession of an ECDSA-signed credential (passport, driver's license) inside a zkSNARK; no issuer cooperation needed [[1]](https://eprint.iacr.org/2022/878) |
| **Semaphore-style credential proofs** | 2020 | Groth16 + Merkle tree | Prove membership in a committed set of credential hashes; nullifier prevents double-use; used in Zupass for event tickets [[1]](https://semaphore.pse.dev/) |
| **Circom Passport (Proof of Passport)** | 2024 | Groth16 + RSA/ECDSA verify circuit | Prove data from an ePassport RFID chip (nationality, age) without revealing identity; RSA signature verification inside Circom circuit [[1]](https://github.com/zk-passport/proof-of-passport) |
| **Noir Credential Proofs** | 2024 | UltraHonk / PLONK + Noir DSL | Write credential verification circuits in Noir; compile to ACIR; prove BBS+ or ECDSA signature knowledge; composable with Aztec private state [[1]](https://noir-lang.org/) |
| **zkLogin (Sui / Mysten Labs)** | 2023 | Groth16 + OIDC JWT verification | Prove possession of a Google/Apple OIDC JWT inside a zkSNARK; derive a blockchain address from the JWT sub claim without revealing email or identity [[1]](https://docs.sui.io/concepts/cryptography/zklogin) |

**State of the art:** zk-creds and Circom Passport (2023-2024) demonstrate that existing government-issued credentials (passports, driver's licenses) can be made privacy-preserving without reissuing them. zkLogin (Sui) deploys OIDC-in-SNARK for millions of users. The approach is more flexible than [BBS+](#bbs-anonymous-credentials) (works with any signature) but produces larger proofs and requires circuit compilation. Related to [ZK Proof Systems](04-zero-knowledge-proof-systems.md#zero-knowledge-proof-systems) and [Anonymous Credentials](#anonymous-credentials).

**Production readiness:** Experimental
zkLogin deployed on Sui blockchain for millions of users; Circom Passport and zk-creds are working prototypes; Zupass used at events.

**Implementations:**
- [zk-passport/proof-of-passport](https://github.com/zk-passport/proof-of-passport) ⭐ 1.2k — Circom/Solidity, passport ZK proofs
- [semaphore-protocol/semaphore](https://github.com/semaphore-protocol/semaphore) ⭐ 1.1k — TypeScript, Semaphore-style credential proofs
- [zk-passport/proof-of-passport](https://github.com/zk-passport/proof-of-passport) ⭐ 1.2k — Circom, ePassport ZK verification
- [noir-lang/noir](https://github.com/noir-lang/noir) ⭐ 1.3k — Rust, Noir ZK DSL for credential proofs

**Security status:** Caution
zkSNARK security depends on circuit correctness; ECDSA/RSA in-circuit verification is complex and requires careful auditing; trusted setup needed for Groth16.

**Community acceptance:** Emerging
Rapidly growing area; zkLogin (Sui) and Zupass demonstrate viability; more flexible than BBS+ but less mature; active research community.

---

## Signal KVAC v2 (zkgroup)

**Goal:** Evolved keyed-verification anonymous credentials for Signal's group system, adding encrypted member profiles, group-level attribute verification, and auth credentials with expiration. The zkgroup library implements a purpose-built credential system where the Signal server (credential issuer) can verify presentations but cannot link them across sessions or learn which user is presenting.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CMZ KVAC (original)** | 2014 | Algebraic MAC + ZK | Chase-Meiklejohn-Zaverucha: foundational KVAC scheme; MAC on committed attributes with ZK proof of possession [[1]](https://eprint.iacr.org/2013/516) |
| **Signal zkgroup v1** | 2020 | CMZ + Ristretto255 | Signal Private Group System: anonymous group membership credentials; server issues MAC-based credential; client proves membership without revealing UID [[1]](https://signal.org/blog/signal-private-group-system/) |
| **Signal zkgroup v2 (auth credentials)** | 2022 | CMZ + expiring tokens + encrypted profiles | Auth credential with redemption timestamp; profile key credentials allow encrypted profile fetch without server learning which profile; pni credentials for phone-number privacy [[1]](https://github.com/nickolay/nickolay.github.io/blob/main/2023-01-08-signal-groups.md) |
| **Signal Username Credentials** | 2024 | KVAC + encrypted username | Users prove username ownership to contacts via KVAC presentation; Signal server cannot link username to phone number or group membership [[1]](https://signal.org/blog/phone-number-privacy-usernames/) |

**State of the art:** Signal zkgroup v2 (2022-2024) is the largest real-world KVAC deployment (100M+ users). The system has evolved from simple group membership to a multi-credential architecture covering auth tokens, profile keys, phone-number identifiers, and usernames. Extends [KVAC](#keyed-verification-anonymous-credentials-kvac); uses [Ristretto255](01-foundational-primitives.md#ristretto255-decaf-prime-order-group-abstractions).

**Production readiness:** Production
Deployed in Signal messenger serving 100M+ users; covers group membership, auth tokens, profile keys, and usernames.

**Implementations:**
- [signalapp/libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, official Signal library including zkgroup
- [nicola/zkgroup](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust, Signal's libsignal including zkgroup

**Security status:** Secure
CMZ KVAC proven under DDH over Ristretto255; Signal's implementation is audited and battle-tested at scale.

**Community acceptance:** Widely trusted
Largest KVAC deployment worldwide (100M+ users); peer-reviewed cryptographic design; Signal is widely trusted by security community.

---

## CBDC Privacy Architectures

**Goal:** Central Bank Digital Currency designs that balance regulatory compliance (AML, transaction limits) with user privacy. Unlike fully anonymous e-cash, CBDC privacy architectures provide tiered anonymity: small transactions may be payer-anonymous, while large transactions require identity disclosure. The cryptographic challenge is enforcing spending limits and regulatory thresholds without a central ledger that tracks all transactions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ECB Digital Euro (privacy tier model)** | 2023 | Blind signatures + pseudonymous ledger | Low-value offline: blind-signed tokens (Chaum-style); high-value online: pseudonymous accounts with AML threshold triggers [[1]](https://www.ecb.europa.eu/paym/digital_euro/investigation/profuse/shared/files/dedocs/ecb.dedocs231013_Digital_euro_privacy.en.pdf) |
| **Platypus (Wüst-Kostiainen-Cap)** | 2022 | Blind sigs + range proofs + threshold reporting | Regulatory-compliant e-cash: user holds blind-signed coins; ZK range proof enforces per-period spending limit; threshold exceeded triggers identity disclosure [[1]](https://eprint.iacr.org/2021/1443) |
| **PEReDi (Grothoff et al.)** | 2022 | Blind RSA + income transparency | "Private E-cash with Regulated Direct Issuance": issuer blind-signs coins; merchant deposits reveal income (one-sided transparency); basis of GNU Taler CBDC mode [[1]](https://taler.net/papers/peredi-2022.pdf) |
| **Hamilton Project / OpenCBDC (MIT-Boston Fed)** | 2022 | Hash-based commitments + transaction processor | Research CBDC platform; explored privacy-preserving architectures; concluded 99,000 tx/s possible with privacy layer [[1]](https://www.bostonfed.org/publications/research-department-working-paper/2022/the-hamilton-project-a-broad-design-space-approach-to-cbdc-technical-research.aspx) |
| **Bank of England CBDC Consultation** | 2023 | Pseudonymous accounts + AML gateway | "Digital Pound" design: accounts pseudonymous to intermediaries; BoE sees no personal data; AML performed at payment interface provider level [[1]](https://www.bankofengland.co.uk/paper/2023/the-digital-pound-consultation-paper) |

**State of the art:** The ECB Digital Euro (pilot phase 2024-2025) uses a tiered privacy model with blind-signed offline tokens for small payments. Platypus (2022) provides the strongest formal privacy guarantees with regulatory compliance via ZK range proofs on spending limits. Extends [E-Cash / Chaumian Digital Cash](#e-cash-chaumian-digital-cash) and [GNU Taler](#gnu-taler) with compliance-aware privacy. Related to [Blind Signatures](08-signatures-advanced.md#blind-signatures) and [Range Proofs](13-blockchain-distributed-ledger.md#range-proofs).

**Production readiness:** Experimental
ECB Digital Euro in pilot phase (2024-2025); GNU Taler selected for EU CBDC pilots; Hamilton Project (MIT/Boston Fed) completed research phase.

**Implementations:**
- [GNU Taler](https://git.taler.net/) — C/Python, privacy-preserving e-cash for CBDC
- [mit-dci/opencbdc-tx](https://github.com/mit-dci/opencbdc-tx) ⭐ 927 — C++, MIT/Boston Fed OpenCBDC research platform

**Security status:** Secure
Blind signature-based tiers are well-studied; ZK range proofs for spending limits proven secure; tiered privacy preserves AML compliance.

**Community acceptance:** Emerging
ECB, Bank of England, and multiple central banks exploring; regulatory and political aspects dominate over cryptographic concerns.

---

## Post-Quantum Anonymous Credentials

**Goal:** Anonymous credential schemes secure against quantum computers. Classical anonymous credentials (CL, BBS+, PS, KVAC) rely on discrete-log or pairing assumptions broken by Shor's algorithm. Post-quantum constructions replace these with lattice, hash, or code assumptions while preserving selective disclosure and unlinkability. The main challenge is achieving practical proof sizes and prover efficiency under PQ assumptions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lattice-Based Anonymous Credentials (Jeudy et al.)** | 2023 | Module-SIS + Module-LWE | First practical lattice-based anonymous credentials with selective disclosure; proof size ~100 KB; unlinkable multi-show [[1]](https://eprint.iacr.org/2023/560) |
| **Hash-Based Anonymous Credentials (Buser et al.)** | 2023 | SPHINCS+ / symmetric primitives | Anonymous credentials from hash-based assumptions only; conservative PQ security; large proofs (~500 KB) but minimal hardness assumptions [[1]](https://eprint.iacr.org/2023/490) |
| **PQ-BBS (Araniti-Sakzad)** | 2024 | Module lattices + BBS-like structure | Lattice analogue of BBS+ signatures with selective disclosure; aims to be drop-in replacement for BBS+ in W3C VC ecosystem [[1]](https://eprint.iacr.org/2024/232) |
| **MPCitH-Based Anonymous Credentials** | 2023 | MPC-in-the-Head + symmetric PRF | Credential presentation via MPCitH proof of MAC knowledge; MAC-based (like KVAC) but proven via Fiat-Shamir'd MPC simulation; PQ from symmetric assumptions [[1]](https://eprint.iacr.org/2023/1587) |

**State of the art:** Lattice-based anonymous credentials (2023) are approaching practical sizes but remain 10-100x larger than BBS+ proofs. MPCitH-based credentials offer the most conservative assumptions (symmetric only) at the cost of proof size. PQ-BBS aims for ecosystem compatibility with [BBS+ Anonymous Credentials](#bbs-anonymous-credentials). Active NIST/IETF discussion on PQ credential migration. Related to [Post-Quantum Cryptography](15-quantum-cryptography.md#post-quantum-cryptography) and [MPCitH](04-zero-knowledge-proof-systems.md#mpc-in-the-head-mpcith).

**Production readiness:** Research
All constructions are academic prototypes (2023-2024); proof sizes 10-100x larger than classical equivalents.

**Implementations:**
- No production implementations available; constructions described in referenced papers (ePrint 2023/560, 2023/490, 2024/232)

**Security status:** Secure
Based on Module-SIS/Module-LWE (lattice) or symmetric-only (MPCitH) assumptions; conservative PQ security.

**Community acceptance:** Emerging
Active NIST/IETF discussion on PQ credential migration; PQ-BBS aims for W3C VC ecosystem compatibility; critical research area given quantum threat timeline.

---

## Credential Status Mechanisms (Revocation Transparency)

**Goal:** Efficiently communicate credential revocation status while preserving holder privacy. A revoked credential must be rejected by verifiers, but the revocation mechanism should not enable tracking of non-revoked holders. Key trade-offs: update frequency, holder privacy during status checks, verifier offline capability, and issuer infrastructure cost.

| Mechanism | Year | Basis | Note |
|-----------|------|-------|------|
| **CRL (Certificate Revocation List)** | 1999 | Signed list of serial numbers | X.509 standard; issuer publishes full list of revoked serial numbers; verifier downloads and checks; privacy issue: no holder interaction needed but lists grow large [[1]](https://www.rfc-editor.org/rfc/rfc5280) |
| **OCSP (Online Certificate Status Protocol)** | 1999 | Signed per-certificate response | RFC 6960; verifier queries issuer for single certificate status; privacy risk: issuer learns which certificates are being verified [[1]](https://www.rfc-editor.org/rfc/rfc6960) |
| **OAuth Status List (Token Status List)** | 2024 | Bitstring in signed JWT/CWT | IETF draft; compact bit-array where position i indicates revocation of credential i; signed by issuer; no per-check issuer interaction; mandated by eIDAS 2.0 ARF [[1]](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/) |
| **Revocation Transparency (Laurie-Kasper)** | 2012 | Merkle tree + append-only log | Append-only log of revocation events; verifiers check inclusion proofs; prevents silent revocation; inspired by Certificate Transparency [[1]](https://www.links.org/files/RevocationTransparency.pdf) |
| **Accumulator-Based Non-Revocation Proofs** | 2002 | RSA/Pairing accumulator + ZK | Holder proves credential is NOT in revoked set via ZK witness; verifier learns nothing about which credential was checked; used in Hyperledger AnonCreds and Idemix [[1]](https://eprint.iacr.org/2008/539) |
| **W3C VC Bitstring Status List** | 2024 | Bitstring + VC envelope | W3C specification; status list published as a Verifiable Credential containing a compressed bitstring; supports revocation and suspension; ecosystem-neutral [[1]](https://www.w3.org/TR/vc-bitstring-status-list/) |

**State of the art:** OAuth Status List (IETF draft, 2024) is mandated by the [EU EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20) for credential revocation. Accumulator-based ZK non-revocation proofs (used in [AnonCreds](#accumulators-for-credential-revocation) and [IRMA/Yivi](#irma-yivi-credential-system)) provide the strongest privacy but require holder witness updates. W3C Bitstring Status List is gaining adoption for VC ecosystems. Related to [Accumulators for Credential Revocation](#accumulators-for-credential-revocation) and [Certificate Transparency](14-applied-infrastructure-pki.md#tee-remote-attestation).

**Production readiness:** Production
CRL and OCSP deployed globally in X.509 PKI; OAuth Status List mandated by EU EUDI Wallet; accumulator-based revocation in AnonCreds/IRMA.

**Implementations:**
- [IETF OAuth Status List](https://datatracker.ietf.org/doc/draft-ietf-oauth-status-list/) — IETF draft specification and test vectors
- [hyperledger/anoncreds-rs](https://github.com/hyperledger/anoncreds-rs) ⭐ 85 — Rust, accumulator-based non-revocation proofs
- [nicola/bitstring-status-list](https://github.com/w3c/vc-bitstring-status-list-test-suite) ⭐ 5 — W3C Bitstring Status List test suite

**Security status:** Secure
CRL/OCSP are well-established; accumulator-based proofs provide ZK revocation; OAuth Status List is simple and efficient.

**Community acceptance:** Standard
CRL/OCSP are IETF standards (RFC 5280, RFC 6960); OAuth Status List mandated by eIDAS 2.0; W3C Bitstring Status List is a W3C specification.

---

## Anonymous Multi-Hop Locks (AMHL)

**Goal:** Privacy-preserving payment channel routing. In a multi-hop payment (Alice -> Bob -> Carol -> Dave), each intermediary should learn only their immediate neighbors, not the sender, receiver, or full path. AMHLs replace hash-time-lock contracts (HTLCs) with homomorphic one-way functions so that locking scripts at each hop are unlinkable, preventing wormhole attacks and payment correlation by colluding intermediaries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HTLC (Hash Time-Locked Contracts)** | 2015 | Hash preimage + timelock | Standard Lightning payment routing; same hash H(x) used at every hop; any two colluding intermediaries can correlate the payment [[1]](https://lightning.network/lightning-network-paper.pdf) |
| **AMHL (Malavolta et al.)** | 2019 | Homomorphic one-way function + adaptor sigs | Each hop uses a different lock related by a homomorphic relation; intermediaries cannot link locks across hops; compatible with Schnorr/ECDSA adaptor signatures [[1]](https://eprint.iacr.org/2019/589) |
| **Point Time-Locked Contracts (PTLCs)** | 2020 | Schnorr adaptor signatures | Lightning-specific AMHL instantiation; each hop uses a different Schnorr point; unlocking one reveals the adaptor secret for the next; planned for Lightning with Taproot [[1]](https://bitcoinops.org/en/topics/ptlc/) |
| **Multi-Hop Locks from Lattices** | 2022 | Lattice-based adaptor sigs | Post-quantum AMHL construction; homomorphic lock relation from Module-LWE; compatible with lattice-based payment channels [[1]](https://eprint.iacr.org/2022/1247) |

**State of the art:** PTLCs (planned for Bitcoin Lightning Network post-Taproot activation) will replace HTLCs to prevent payment correlation attacks. The Malavolta et al. AMHL framework (CCS 2019) is the theoretical foundation; lattice variants provide PQ readiness. Related to [Adaptor Signatures](08-signatures-advanced.md#proxy-signatures), [Atomic Swaps](13-blockchain-distributed-ledger.md#fair-exchange-atomic-swaps), and [Sphinx packet format](#onion-routing) used in Lightning onion routing.

**Production readiness:** Experimental
PTLCs planned for Bitcoin Lightning Network post-Taproot; not yet deployed; HTLC (predecessor) is in production.

**Implementations:**
- [lightningnetwork/lnd](https://github.com/lightningnetwork/lnd) ⭐ 8.1k — Go, Lightning Network daemon (HTLC; PTLC support planned)
- [nicola/adaptor-signatures](https://github.com/hzcyto/AdaptorSig) ⭐ 2 — Rust, adaptor signature library for PTLC construction

**Security status:** Secure
AMHL framework proven secure (CCS 2019); Schnorr adaptor signatures well-studied; lattice variant provides PQ path.

**Community acceptance:** Emerging
Malavolta et al. (CCS 2019) is the foundational paper; PTLCs are planned for Lightning Network; Bitcoin community supports Taproot-based deployment.

---

> **Fuzzy Message Detection (FMD)** is covered in [Privacy-Preserving Computation — FMD](10-privacy-preserving-computation.md#fuzzy-message-detection-fmd).

---

