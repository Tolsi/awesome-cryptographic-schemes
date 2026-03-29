# Anonymity & Credentials

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

---

## Onion Routing

**Goal:** Low-latency anonymous communication. Messages are wrapped in layers of encryption ("onion"); each relay peels one layer, learning only the next hop. Provides sender anonymity in real-time (unlike high-latency mixnets).

| System | Year | Basis | Note |
|--------|------|-------|------|
| **Original Onion Routing** | 1996 | RSA + DH | First onion routing proposal; layered encryption through relays [[1]](https://ieeexplore.ieee.org/document/501689) |
| **Tor** | 2004 | TLS + DH + AES | Deployed network; 6000+ relays; 2M+ daily users [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Sphinx Packet Format** | 2009 | DH + HMAC | Compact, provably secure onion packet format; used in Lightning Network [[1]](https://eprint.iacr.org/2009/482) |

**State of the art:** Tor (largest deployed anonymity network), Sphinx (Lightning, Nym transport layer).

---

## DC-Nets (Dining Cryptographers Networks)

**Goal:** Information-theoretically anonymous broadcast. A group of participants can broadcast a message so that an adversary (even computationally unbounded) cannot determine who sent it — as long as at least one participant is honest. Stronger than mixnets.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chaum DC-Net** | 1988 | Shared secrets + XOR | Original: participants XOR shared bits; anonymous 1-bit broadcast [[1]](https://www.cs.cornell.edu/people/egs/herbivore/dcnets.html) |
| **Herbivore** | 2003 | DC-net + groups | Practical DC-net for small groups; scalability improvements [[1]](https://www.cs.cornell.edu/people/egs/herbivore/) |
| **Verdict (Corrigan-Gibbs-Ford)** | 2013 | DC-net + ZKP | Accountable: detect disruptors via zero-knowledge proofs [[1]](https://dl.acm.org/doi/10.1145/2508859.2516683) |

**State of the art:** Verdict (accountability + anonymity), DC-nets remain strongest anonymity guarantee but hard to scale.

---

## Privacy Pass / Anonymous Tokens

**Goal:** Unlinkable authorization. A client obtains a batch of tokens from a server (e.g., by solving a CAPTCHA once), then redeems them later without the server being able to link redemption to issuance. Rate-limiting without tracking.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Privacy Pass v1** | 2018 | VOPRF (EC) | Cloudflare's protocol; blind token issuance via VOPRF (see [OPRF](#oblivious-prf-oprf)) [[1]](https://doi.org/10.1515/popets-2018-0026) |
| **Privacy Pass v3 (IETF)** | 2023 | VOPRF / blind RSA | Standardized (RFC 9576–9578); public/private metadata, rate-limited tokens [[1]](https://www.rfc-editor.org/rfc/rfc9576) |
| **Apple Private Access Tokens** | 2022 | Blind RSA (RSA-BPOP) | Built on Privacy Pass; used in iOS/macOS for CAPTCHA-free auth [[1]](https://developer.apple.com/news/?id=huqjyh7k) |
| **Trust Token API (Chrome)** | 2020 | VOPRF | Google's Privacy Pass variant for anti-fraud without cookies [[1]](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/) |

**State of the art:** Privacy Pass v3 (IETF RFC 9576–9578) with VOPRF or blind RSA; deployed by Cloudflare, Apple, Chrome.

---

## Secret Handshakes / Hidden Credentials

**Goal:** Mutual private authentication. Two parties discover if they share a group membership — if not, neither learns anything about the other. No information leaks on failed authentication.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Balfanz-Durfee-et-al.** | 2003 | Pairing-based | First secret handshake scheme; CA issues group credentials [[1]](https://dl.acm.org/doi/10.1145/948109.948126) |
| **Multi-Group SH (Castelluccia)** | 2004 | Bilinear maps | Support for multiple simultaneous group memberships [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30108-0_22) |
| **Unlinkable SH (Jarecki-Liu)** | 2009 | OPRF + ZK | Unlinkable across sessions; stronger privacy [[1]](https://eprint.iacr.org/2008/332) |

**State of the art:** Unlinkable Secret Handshakes (strongest privacy), pairing-based SH (practical).

---

## Semaphore / Anonymous Group Signaling (RLN)

**Goal:** Anonymous membership proof with rate limiting. Prove you belong to a group and broadcast a signal — without revealing which member you are. RLN (Rate-Limiting Nullifiers) adds: sending more than one signal per epoch reveals your secret key.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Semaphore** | 2019 | zk-SNARK + Merkle | Anonymous group signaling via ZK membership proof in a Merkle tree [[1]](https://semaphore.pse.dev/V1) |
| **RLN v1 (Rate-Limiting Nullifiers)** | 2020 | Semaphore + Shamir | Rate-limited: >1 signal per epoch → secret key reconstructable [[1]](https://rate-limiting-nullifier.github.io/rln-docs/) |
| **RLN v2** | 2023 | Groth16 + slashing | Improved; variable rate limits per epoch [[1]](https://rate-limiting-nullifier.github.io/rln-docs/v2) |
| **Zupass / Semaphore v4** | 2024 | Groth16 / PLONK | Identity framework: ZK proofs of attributes, event tickets, voting [[1]](https://github.com/semaphore-protocol/semaphore) |

**State of the art:** Semaphore v4 + RLN v2; used in Ethereum (spam prevention), Waku messaging, Zupass identity. Related to [Ring Signatures](#ring--group-signatures), [ZK Proofs](#zero-knowledge-proofs-zk).

---

## Delegatable Anonymous Credentials

**Goal:** Credential chaining with privacy. A credential holder can delegate their credential to another party — possibly with restrictions — who can further delegate. Each presentation is anonymous and unlinkable, even across delegation levels.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chase-Lysyanskaya Delegatable Creds** | 2006 | NIZK + signatures | First delegatable anonymous credentials; unlimited depth [[1]](https://eprint.iacr.org/2006/281) |
| **Belenkiy-Chase-Kohlweiss-Lysyanskaya** | 2009 | GS proofs + P-signatures | Practical delegatable creds from Groth-Sahai proofs [[1]](https://eprint.iacr.org/2008/428) |
| **Camenisch-Drijvers-Dubovitskaya** | 2017 | CL sigs + delegation | Practical construction with attribute-based delegation [[1]](https://eprint.iacr.org/2017/115) |

**State of the art:** Delegatable creds from [Malleable Proofs](#malleable-proof-systems--controlled-malleable-nizk) and [SPS/EQS](#structure-preserving-signatures-sps). Extends [Anonymous Credentials](#anonymous-credentials).

---

## Keyed-Verification Anonymous Credentials (KVAC)

**Goal:** Lightweight anonymous credentials. Issuer gives user a credential; user can prove possession anonymously — but only the issuer (who holds the verification key) can verify. No pairings needed; very efficient. Used in Signal's anonymous groups.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CMZ KVAC (Chase-Meiklejohn-Zaverucha)** | 2014 | Algebraic MAC + ZK | First KVAC; MAC-based anonymous credentials; efficient without pairings [[1]](https://eprint.iacr.org/2013/516) |
| **Signal Anonymous Credentials** | 2020 | CMZ + Ristretto | Signal's implementation for anonymous group membership [[1]](https://signal.org/blog/signal-private-group-system/) |
| **KVAC with Attributes** | 2019 | Algebraic MAC | Selective disclosure of attributes; blind issuance [[1]](https://eprint.iacr.org/2019/344) |

**State of the art:** CMZ-based KVAC (Signal Private Groups); lightweight alternative to [BBS+/PS Signatures](#rerandomizable-signatures-ps-signatures) when issuer-only verification suffices. See [Anonymous Credentials](#anonymous-credentials).

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

**State of the art:** Compact E-Cash (CHL 2005); modern [Privacy Pass](#privacy-pass--anonymous-tokens) is essentially single-use e-cash tokens. See [Blind Signatures](#blind-signatures).

---

## Anonymous Broadcast Encryption

**Goal:** Recipient-hiding broadcast. Encrypt to a set S of authorized receivers — but the ciphertext reveals nothing about who is in S. An eavesdropper cannot tell whether they are an intended recipient (beyond trying to decrypt).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Barth-Boneh-Waters Anonymous BE** | 2006 | Pairings | First anonymous broadcast encryption; hides recipient set [[1]](https://eprint.iacr.org/2006/104) |
| **Libert-Paterson-Quaglia** | 2012 | Pairings (prime order) | Efficient anonymous BE with shorter ciphertexts [[1]](https://eprint.iacr.org/2011/476) |
| **Anonymous BE from LWE** | 2019 | Lattices | Post-quantum anonymous broadcast encryption [[1]](https://eprint.iacr.org/2019/532) |

**State of the art:** Lattice-based anonymous BE for PQ; extends [Broadcast Encryption](#broadcast-encryption) with recipient privacy. Related to [Anonymous IBE](#anonymous-ibe).

---

## Anonymous Reputation Systems

**Goal:** Accumulate and present reputation scores anonymously. A user builds reputation through actions but presents it without revealing which actions they performed or linking presentations. Prevents Sybil attacks while preserving privacy.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Androulaki et al. Anonymous Reputation** | 2008 | Blind sigs + ZK | First practical anon reputation; reputation tokens via blind sigs [[1]](https://doi.org/10.1145/1455770.1455782) |
| **BLAC (Blacklistable Anonymous Credentials)** | 2010 | Pairing-based | Blacklist misbehaving users without linking to identity [[1]](https://doi.org/10.1145/1866307.1866358) |
| **AnonRep (Zhai et al.)** | 2016 | Linkable ring sigs + shuffle | Tracking-resistant reputation; verifiable shuffle prevents deanonymization [[1]](https://www.cs.yale.edu/homes/zhai-ennan/zhai16anonrep.pdf) |

**State of the art:** AnonRep (2016); combines [Ring Signatures](#ring--group-signatures), [Anonymous Credentials](#anonymous-credentials), and [Mixnets](#mix-networks-mixnets).

---

## Stealth Addresses

**Goal:** Receiver-unlinkable blockchain payments. Sender non-interactively generates a one-time address controlled by the receiver — without any prior interaction. An observer cannot link the stealth address to the receiver's public key. Each payment goes to a fresh, unique address.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dual-Key Stealth Address Protocol (DKSAP)** | 2014 | ECDH | Receiver publishes scan + spend keys; sender derives one-time address via ECDH [[1]](https://eprint.iacr.org/2020/548) |
| **ERC-5564 (Ethereum Standard)** | 2023 | ECDH + view tags | Standardized stealth addresses for Ethereum; view tags for efficient scanning [[1]](https://eips.ethereum.org/EIPS/eip-5564) |
| **Stealth Addresses + ZK (Umbra)** | 2022 | ECDH + ZK proofs | Privacy-preserving withdrawal using ZK proofs; deployed on Ethereum [[1]](https://www.umbra.cash/) |

**State of the art:** ERC-5564 (Ethereum standard); Umbra (deployed). Related to [NIKE](#non-interactive-key-exchange-nike) and [HD Wallets](#hierarchical-deterministic-keys-bip32--hd-wallets).

---

## Coconut Credentials

**Goal:** Threshold-issued anonymous credentials on distributed systems. A set of authorities jointly issue a credential (no single authority sees the full request); the credential supports selective attribute disclosure, re-randomization for unlinkability, and private attributes. Designed for integration with smart contracts and blockchains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Coconut** | 2019 | PS Signatures + threshold blind sigs | Threshold issuance: t-of-n authorities; unlinkable re-randomizable credential; deployed in Nym network [[1]](https://www.ndss-symposium.org/ndss-paper/coconut-threshold-issuance-selective-disclosure-credentials-with-applications-to-distributed-ledgers/) |
| **Security Analysis of Coconut** | 2022 | Algebraic security model | Formal UC-style analysis; modified blind issuance for information-theoretic user privacy [[1]](https://eprint.iacr.org/2022/011) |
| **Threshold BBS+** | 2023 | BBS+ + threshold issuance | Distributed BBS+ credential issuance without a trusted issuer [[1]](https://eprint.iacr.org/2023/602) |

**State of the art:** Coconut (NDSS 2019) deployed in Nym network for anonymous bandwidth tokens. Extends [PS Signatures](#anonymous-credentials) with threshold issuance; complements [Delegatable Anonymous Credentials](#delegatable-anonymous-credentials) and [KVAC](#keyed-verification-anonymous-credentials-kvac).

---

## Tor v3 Onion Services

**Goal:** Server-side anonymity on Tor. A hidden service advertises a self-authenticating .onion address derived from a long-term Ed25519 key. Clients locate the service through a distributed hash table of encrypted descriptors — without any party learning the server's IP address. Provides mutual anonymity: both client and server are hidden.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Onion Services v2** | 2004 | RSA-1024 + SHA-1 | 16-char address; descriptor in plain text in HSDir; deprecated 2021 [[1]](https://svn.torproject.org/svn/projects/design-paper/tor-design.pdf) |
| **Onion Services v3 (prop 224)** | 2017 | Ed25519 + X25519 + SHAKE-256 | 56-char address = Ed25519 pubkey + checksum; descriptor double-encrypted; blinded daily signing key derived from identity key + date [[1]](https://torproject.gitlab.io/torspec/rend-spec-v3.html) |
| **Client Authorization (v3)** | 2017 | X25519 ECDH | Optional: service encrypts descriptor_cookie with each authorized client's X25519 key; unauthenticated parties cannot decrypt descriptor at all [[1]](https://torproject.gitlab.io/torspec/rend-spec-v3.html) |

**State of the art:** Tor v3 onion services (rend-spec-v3, deployed since 2021 exclusively). Key-blinded daily descriptors prevent HSDir enumeration; X25519 client auth adds access control. Related to [Onion Routing](#onion-routing) and [DC-Nets](#dc-nets-dining-cryptographers-networks).

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

---

## GNU Taler

**Goal:** Privacy-preserving online payments with one-sided anonymity. Customers pay anonymously (payer is unlinkable across transactions); merchants are always identified and taxable. Built on Chaumian blind signatures with efficient change, deployed as a central-bank-compatible e-cash system.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **GNU Taler Core** | 2016 | RSA blind signatures + online exchange | Customer blind-withdraws coins from exchange; spends unlinkably; exchange detects double-spending; merchant identity visible to exchange [[1]](https://link.springer.com/chapter/10.1007/978-3-319-49445-6_14) |
| **Taler with Clause-Schnorr** | 2021 | Blind Schnorr (CS-blind) | Replaces RSA blind sigs with more efficient Clause-Schnorr blind signatures; reduces coin size and signing overhead [[1]](https://www.taler.net/papers/cs-thesis.pdf) |
| **NGI Taler (EU rollout)** | 2024 | Taler + central bank integration | 11-partner EU consortium; targets CBDC-compatible deployment; income transparency for tax compliance [[1]](https://ngi.eu/blog/2023/05/02/gnu-taler/) |

**State of the art:** GNU Taler with Clause-Schnorr blind signatures; selected for EU NGI rollout (2024–2027). Provides stronger payer anonymity than traditional e-cash while retaining merchant accountability. Extends [E-Cash / Chaumian Digital Cash](#e-cash--chaumian-digital-cash) and [Blind Signatures](categories/08-signatures-advanced.md#blind-signatures).

---

## Zcash Shielded Protocols (Sapling / Orchard)

**Goal:** Fully private blockchain payments. Shielded transactions hide sender, receiver, and amount on a public blockchain using zk-SNARKs. Notes are commitments in a Merkle tree; spending reveals only a nullifier (preventing double-spend) and a ZK proof — no linkable information.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **Sprout** | 2016 | zk-SNARK (BCTV14) + SHA-256 | First Zcash shielded pool; large proving times (~40 s); trusted setup required [[1]](https://zips.z.cash/protocol/protocol.pdf) |
| **Sapling** | 2018 | Groth16 + BLS12-381 + Jubjub | 100× faster proving (~2 s); Jubjub in-circuit curve; trusted ceremony (700+ participants) [[1]](https://zips.z.cash/protocol/sapling.pdf) |
| **Orchard** | 2022 | Halo 2 (PLONKish) + Pallas curve | No trusted setup; recursive proofs; replaces Sapling in NU5 (2022); Pallas/Vesta cycle [[1]](https://zips.z.cash/zip-0224) |

**State of the art:** Orchard (activated May 2022) using Halo 2 — the first production shielded pool without a trusted ceremony. Sapling remains widely supported for compatibility. Relies on [Halo 2 / Recursive SNARKs](categories/04-zero-knowledge-proof-systems.md#recursive-snarks--proof-carrying-data-pcd); complements [Confidential Transactions](categories/13-blockchain-distributed-ledger.md#confidential-transactions--range-proofs) and [Stealth Addresses](#stealth-addresses).

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

**State of the art:** W3C VC DI BBS Cryptosuites v1.0 (W3C TR, 2024) with BBS signatures over BLS12-381; mandated for EU eIDAS 2.0 digital identity wallets alongside [SD-JWT](#anonymous-credentials). Issuer-verifiable variant covered under [Rerandomizable Signatures / PS Signatures](categories/08-signatures-advanced.md#rerandomizable-signatures-ps-signatures); threshold issuance in [Coconut Credentials](#coconut-credentials).

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

**State of the art:** Monero (2022 network upgrade) uses CLSAG ring signatures (ring size 16), dual-key stealth addresses, and RingCT with Bulletproofs+ range proofs. Seraphis (in design) would decouple membership proofs from ownership proofs for more modular upgrades. Relies on [Ring & Group Signatures](categories/08-signatures-advanced.md#ring--group-signatures), [Stealth Addresses](#stealth-addresses), and [Range Proofs](categories/13-blockchain-distributed-ledger.md#range-proofs).

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

**State of the art:** WabiSabi (deployed in Wasabi Wallet 2.0, 2022) is the cryptographically strongest coordinator-blind CoinJoin, building directly on [KVAC](#keyed-verification-anonymous-credentials-kvac). PayJoin (BIP 78) is a simpler two-party variant requiring no mixing round. Related to [E-Cash / Chaumian Digital Cash](#e-cash--chaumian-digital-cash) and [Blind Signatures](categories/08-signatures-advanced.md#blind-signatures).

---

## Privacy Pools

**Goal:** Compliance-friendly anonymous on-chain payments. Extends Tornado Cash-style mixing with zero-knowledge proofs that let depositors prove their funds belong to a "good" association set (e.g., excluding sanctioned wallets) — without revealing which deposit is theirs. Honest users retain privacy; malicious actors cannot create a valid inclusion proof for a clean set.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tornado Cash** | 2019 | zk-SNARK (Groth16) + Merkle | Deposit ETH, withdraw to fresh address; ZK proof of Merkle membership hides which deposit; no association-set filtering [[1]](https://eprint.iacr.org/2019/953) |
| **Privacy Pools (Buterin et al.)** | 2023 | zk-SNARK + dual Merkle proof | User proves deposit is in the full pool AND in a curated association set; withdrawer reveals neither deposit leaf nor set membership, only validity [[1]](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4563364) |
| **0xbow Privacy Pools (deployed)** | 2024 | Groth16 + Ethereum smart contract | Production implementation of the Buterin et al. design; association set providers (ASPs) publish compliance-filtered trees [[1]](https://www.theblock.co/post/348959/0xbow-privacy-pools-new-cypherpunk-tool-inspired-research-ethereum-founder-vitalik-buterin) |

**State of the art:** 0xbow Privacy Pools (2024) deploys the dual-Merkle zkSNARK design. Extends [Zcash Shielded Protocols](#zcash-shielded-protocols-sapling--orchard) with compliance-aware association sets. The underlying ZK circuit relies on [Groth16](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview) and [Merkle-tree membership proofs](categories/09-commitments-verifiability.md#vector-commitments).

---

## Group Encryption

**Goal:** Encrypt for a group with accountability. Anyone can encrypt to the group; any group member can decrypt; the group manager can identify which member decrypted. The encryption dual of group signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Group Encryption** | 2007 | Pairings + GS proofs | First group encryption; CCA-secure with opening capability [[1]](https://eprint.iacr.org/2007/015) |
| **Cathalo-Libert-Yung** | 2009 | Pairings | Efficient group encryption with shorter ciphertexts [[1]](https://eprint.iacr.org/2009/510) |
| **Lattice Group Encryption (El Bansarkhani-Sturm)** | 2018 | LWE | Post-quantum group encryption from lattices [[1]](https://eprint.iacr.org/2018/196) |

**State of the art:** Lattice-based group encryption for PQ; complements [Ring & Group Signatures](#ring--group-signatures) as the encryption counterpart.

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

**State of the art:** Intel EPID (deployed in all SGX CPUs until 2023; being phased to Intel TDX DCAP); TPM 2.0 ECDAA (ISO/IEC 20008-2). PQ DAA remains an active research area. Builds on [Anonymous Credentials](#anonymous-credentials) and [CL Signatures](#anonymous-credentials); related to [TEE Attestation](categories/14-applied-infrastructure-pki.md#tee-remote-attestation).

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

**State of the art:** Pairing-based accumulators (constant-size witnesses) and VB accumulators (batched updates) are state of the art for anonymous credential revocation. Hyperledger AnonCreds v2 (2023) combines BBS+ with VB-accumulator non-revocation proofs. Related to [Anonymous Credentials](#anonymous-credentials), [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), and [Vector Commitments](categories/09-commitments-verifiability.md#vector-commitments).

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

**State of the art:** Bulletproofs (no trusted setup, O(log n) size) are widely deployed for range proofs on blockchain; LegoSNARK and BBS+ predicate proofs bring composable range proofs to anonymous credential presentations. The EU EUDI Wallet (eIDAS 2.0) is evaluating ZKP-based age verification over SD-JWT VCs. Depends on [Anonymous Credentials](#anonymous-credentials), [BBS+ Anonymous Credentials](#bbs-anonymous-credentials), and [Bulletproofs / Range Proofs](categories/13-blockchain-distributed-ledger.md#range-proofs).

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

---

## OpenID for Verifiable Credentials (OID4VC)

**Goal:** Credential issuance and presentation over OpenID Connect / OAuth 2.0. OID4VC is a family of IETF/OpenID Foundation protocols that add credential-specific endpoints to the existing OAuth ecosystem: wallets request credentials from issuers (OID4VCI) and present them to verifiers (OID4VP) without bespoke infrastructure. The cryptographic core — SD-JWT, BBS+, mDL COSE — is decoupled from the transport protocol.

| Protocol | Year | Basis | Note |
|----------|------|-------|------|
| **OID4VCI (OpenID for VC Issuance)** | 2024 | OAuth 2.0 + credential endpoint | Issuer exposes `/credential` endpoint; wallet obtains SD-JWT-VC or mdoc via authorization-code or pre-authorized-code flow [[1]](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) |
| **OID4VP (OpenID for VP)** | 2024 | OAuth 2.0 + presentation_definition | Verifier sends Presentation Definition (DIF PE); wallet returns VP Token (SD-JWT or mdoc); response_uri binding prevents replay [[1]](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| **OID4VP over BLE / Proximity** | 2024 | OID4VP + ISO 18013-5 engagement | Near-field variant for in-person age checks (mDL handover); BLE or QR device engagement; same cryptographic presentation as remote OID4VP [[1]](https://openid.net/specs/openid-4-verifiable-presentations-1_0.html) |
| **SIOPv2 (Self-Issued OP v2)** | 2024 | OIDC + DID-based self-issued IdP | Wallet acts as its own OpenID Provider; no external IdP required; id_token signed with wallet key; used for DID-based login [[1]](https://openid.net/specs/openid-connect-self-issued-v2-1_0.html) |

**State of the art:** OID4VCI + OID4VP (both reaching final spec in 2024) are the official issuance and presentation protocols for the EU [EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20) ARF and are being adopted by NIST and ISO. SIOPv2 enables self-sovereign login using DID-anchored keys. Builds on [SD-JWT and JSON Web Proof](#sd-jwt-and-json-web-proof-jwp) credential formats and [DID/VCs](categories/14-applied-infrastructure-pki.md#decentralized-identifiers-dids--verifiable-credentials-vcs).

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

**State of the art:** ISO 18013-5 (2021) is the dominant machine-readable mDL format; deployed in Apple Wallet, Google Wallet, and US state DMVs (Maryland, Arizona, Georgia, Colorado). ISO 18013-7 (2024) bridges mDL to the [OID4VC](#openid-for-verifiable-credentials-oid4vc) / [EUDI Wallet](#eu-eudi-wallet-cryptographic-architecture-eidas-20) ecosystem. Selective disclosure is hash-based (like [SD-JWT](#sd-jwt-and-json-web-proof-jwp)) but uses CBOR/COSE rather than JSON/JOSE. Related to [Anonymous Credentials](#anonymous-credentials) and [DID/VCs](categories/14-applied-infrastructure-pki.md#decentralized-identifiers-dids--verifiable-credentials-vcs).

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

**State of the art:** Anonymous credentials provide the richest attribute functionality; group signatures add mandatory accountability (GM can open); ring signatures require no issuer but offer only membership proofs. Modern usage: [CLSAG (Monero)](#moneros-privacy-stack) for ring sigs, [Intel EPID / DAA](#direct-anonymous-attestation-daa) for group sigs, [BBS+](#bbs-anonymous-credentials) / [KVAC](#keyed-verification-anonymous-credentials-kvac) for anonymous credentials. See [Ring & Group Signatures](categories/08-signatures-advanced.md#ring--group-signatures).

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

**State of the art:** SecureDrop (Freedom of the Press Foundation, v2.x) with Qubes OS Workstation is the gold standard for high-security anonymous document submission. GlobaLeaks is more accessible but has a weaker threat model (server holds recipient keys). OnionShare enables ad-hoc anonymous file sharing without dedicated infrastructure. All three rely on [Tor v3 Onion Services](#tor-v3-onion-services) for network anonymity and [OpenPGP](categories/12-secure-communication-protocols.md#openpgp--gpg) for end-to-end encryption.

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

**State of the art:** SimpleX Chat (2022–) provides the strongest deployed metadata privacy: zero persistent user identifiers, per-contact queue pairs, and no server-side social graph. Session provides decentralized onion routing without phone numbers. Briar is unique in peer-to-peer operation over Tor and Bluetooth — no infrastructure required. Vuvuzela (research) gives formal differential-privacy metadata bounds. Complements [Onion Routing](#onion-routing), [Mix Networks](#mix-networks-mixnets), and [Double Ratchet / Signal Protocol](categories/12-secure-communication-protocols.md#double-ratchet--signal-protocol).

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

**State of the art:** Aztec Network (Noir + UltraHonk, 2024 testnet) is the most advanced programmable-privacy L2 — combining UTXO-style private state with arbitrary smart contract logic. The Noir language is gaining adoption as a general ZK DSL beyond Aztec. Complements [Zcash Shielded Protocols](#zcash-shielded-protocols-sapling--orchard) (fixed note semantics) and [Privacy Pools](#privacy-pools) (compliance-aware mixing). Relies on [PLONK / UltraHonk](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview) proof systems and [Encrypted Mempools](categories/13-blockchain-distributed-ledger.md#encrypted-mempools--order-fair-protocols).

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

**State of the art:** Tor Browser with Letterboxing + RFP (Firefox `privacy.resistFingerprinting`) is the most comprehensive deployed defense, aiming for a uniform fingerprint across all Tor Browser users. Brave Browser independently applies canvas noise and aggressive API normalization. Chrome's Privacy Budget remains experimental. Related to [Onion Routing](#onion-routing), [Tor v3 Onion Services](#tor-v3-onion-services), and [Differential Privacy](categories/10-privacy-preserving-computation.md#differential-privacy).

---
