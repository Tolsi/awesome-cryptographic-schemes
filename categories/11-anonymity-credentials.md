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

## Group Encryption

**Goal:** Encrypt for a group with accountability. Anyone can encrypt to the group; any group member can decrypt; the group manager can identify which member decrypted. The encryption dual of group signatures.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Kiayias-Tsiounis-Yung Group Encryption** | 2007 | Pairings + GS proofs | First group encryption; CCA-secure with opening capability [[1]](https://eprint.iacr.org/2007/015) |
| **Cathalo-Libert-Yung** | 2009 | Pairings | Efficient group encryption with shorter ciphertexts [[1]](https://eprint.iacr.org/2009/510) |
| **Lattice Group Encryption (El Bansarkhani-Sturm)** | 2018 | LWE | Post-quantum group encryption from lattices [[1]](https://eprint.iacr.org/2018/196) |

**State of the art:** Lattice-based group encryption for PQ; complements [Ring & Group Signatures](#ring--group-signatures) as the encryption counterpart.

---
