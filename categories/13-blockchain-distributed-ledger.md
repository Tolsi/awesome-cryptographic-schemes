# Blockchain & Distributed Ledger

## Proof of Work (PoW) / Proof of Space

**Goal:** Sybil resistance. Prove that computational or storage resources were expended. Unforgeable and adjustable in difficulty. Foundation of permissionless consensus (Bitcoin, Zcash, Chia).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hashcash** | 1997 | SHA-1 / hash | First practical PoW; anti-spam email [[1]](http://www.hashcash.org/papers/hashcash.pdf) |
| **Bitcoin PoW** | 2008 | Double-SHA256 | Difficulty-adjustable PoW; Nakamoto consensus [[1]](https://bitcoin.org/bitcoin.pdf) |
| **Equihash** | 2016 | Generalized birthday | Memory-hard PoW; ASIC-resistant; used in Zcash [[1]](https://eprint.iacr.org/2015/946) |
| **Proof of Space (Dziembowski)** | 2015 | Graph pebbling | Store data instead of compute; used in Chia Network [[1]](https://eprint.iacr.org/2013/796) |

**State of the art:** Bitcoin PoW (deployed, highest hashrate), Proof of Space (energy-efficient alternative).

**Production readiness:** Production
Bitcoin PoW secures >$1T in assets; Chia Proof of Space mainnet since 2021

**Implementations:**
- [Bitcoin Core](https://github.com/bitcoin/bitcoin) ⭐ 88k — C++, reference Bitcoin PoW implementation
- [Chia Blockchain](https://github.com/Chia-Network/chia-blockchain) ⭐ 10k — Python, Proof of Space and Time implementation
- [zcashd](https://github.com/zcash/zcash) ⭐ 5.4k — C++, Equihash PoW for Zcash

**Security status:** Secure
SHA-256 PoW is secure at current difficulty; Equihash memory-hardness limits ASIC advantage

**Community acceptance:** Standard
Bitcoin PoW is the longest-running and most battle-tested consensus mechanism; Proof of Space adopted by Chia as energy-efficient alternative

---

## Data Availability Sampling (DAS)

**Goal:** Verify data exists without downloading it. Light clients randomly sample small chunks of erasure-coded data; if enough samples succeed, the full data is available with high probability. Core to blockchain scalability (Ethereum danksharding).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **KZG-based DAS** | 2020 | KZG + Reed-Solomon | Commit to data with KZG polynomial; sample random evaluations; see [Commitment Schemes](#commitment-schemes) [[1]](https://eprint.iacr.org/2019/1205) |
| **2D KZG DAS (Danksharding)** | 2022 | KZG over 2D grid | Ethereum's approach: rows + columns of KZG commitments [[1]](https://eprint.iacr.org/2022/1592) |
| **FRI-based DAS** | 2023 | FRI + RS codes | No trusted setup (unlike KZG); used in Celestia, Avail [[1]](https://eprint.iacr.org/2023/1172) |

**State of the art:** KZG-based (Ethereum EIP-4844), FRI-based (Celestia). Critical for modular blockchain scalability.

**Production readiness:** Experimental
EIP-4844 (proto-danksharding with KZG) is live on Ethereum; full DAS with 2D sampling is under development

**Implementations:**
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, Ethereum DAS specification
- [celestia-node](https://github.com/celestiaorg/celestia-node) ⭐ 996 — Go, FRI-based DAS for Celestia
- [availproject/avail](https://github.com/availproject/avail) ⭐ 796 — Rust, KZG-based DAS for Avail

**Security status:** Secure
Information-theoretic guarantees from Reed-Solomon erasure coding; KZG requires trusted setup (performed for Ethereum); FRI is transparent

**Community acceptance:** Emerging
Core component of Ethereum's scaling roadmap (Danksharding); Celestia and Avail are production DAS-native chains

---

## Encrypted Mempools / Threshold Encryption for Transaction Ordering

**Goal:** MEV prevention. Transactions are encrypted before submission to the mempool; a threshold committee decrypts them only after ordering is finalized. Prevents front-running, sandwich attacks, and censorship.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Threshold BLS Encryption for Mempools** | 2022 | TPKE + threshold BLS | Validators jointly decrypt after block ordering; Shutter Network, Penumbra [[1]](https://eprint.iacr.org/2022/898) |
| **Commit-Reveal Mempool** | 2019 | Hash commitment + reveal | Simpler: commit hash, reveal after inclusion; see [Commit-Reveal](#commit-reveal-schemes) |
| **Delay Encryption** | 2021 | VDF + encryption | Decrypt only after a time delay; combines VDF with encryption; see [VDF](#verifiable-delay-functions-vdf) [[1]](https://eprint.iacr.org/2021/1490) |
| **BEAT-MEV** | 2024 | Epochless batched TE | Batched threshold enc for mempools; communication independent of batch size; USENIX Security 2025 [[1]](https://eprint.iacr.org/2024/1533) |

**State of the art:** Threshold encryption (Shutter, Penumbra), BEAT-MEV (2025, batch-optimized), commit-reveal (simplest deployed).

**Production readiness:** Experimental
Shutter Network deployed on Gnosis Chain; Penumbra mainnet launched 2024; most systems are in testnet or early production

**Implementations:**
- [shutter-network/shutter](https://github.com/shutter-network/shutter) ⭐ 69 — Go, threshold encryption for MEV prevention
- [anoma/ferveo](https://github.com/anoma/ferveo) ⭐ 84 — Rust, threshold DKG for Penumbra flow encryption
- [penumbra-zone/penumbra](https://github.com/penumbra-zone/penumbra) ⭐ 476 — Rust, private DEX with threshold-encrypted mempools

**Security status:** Caution
Security depends on threshold committee liveness and honest majority; timing side-channels may leak ordering information

**Community acceptance:** Emerging
Active area of research and development; endorsed by Ethereum researchers; Shutter and Penumbra are first movers

---

## Casper FFG / Ethereum Proof-of-Stake Finality

**Goal:** Provide cryptographic finality — irreversible confirmation — on top of a block tree via a BFT gadget based on threshold BLS signatures. Once a block is "finalized" by Casper FFG, reversing it requires burning ≥ 1/3 of all staked ETH ($15B+), making attacks economically infeasible.

**Protocol overview (Vitalik Buterin, 2017 / Ethereum Gasper, 2020):**

1. **Epochs** = 32 slots × 12 seconds = 6.4 minutes. Each epoch has a checkpoint.
2. **Attestation:** Each of ~500,000 validators signs a vote: `(source checkpoint, target checkpoint)` using BLS12-381.
3. **Supermajority link:** A checkpoint pair is "justified" when ≥ 2/3 of total staked ETH has attested it.
4. **Finalization:** A checkpoint is "finalized" when it is justified and its child is also justified in the next epoch.

**Cryptographic core:**

| Component | Mechanism |
|-----------|-----------|
| Validator signature | BLS12-381 signature (individual) |
| Attestation aggregation | BLS aggregate: n signatures → 1 aggregate sig |
| Slashing condition | Equivocation proof: two signed contradictory votes |
| Slashing penalty | Quadratic slashing: up to 100% of stake |

**Slashing as crypto incentive:** If a validator signs two conflicting attestations (equivocation), anyone can submit both on-chain as a "slashing proof." The validator loses stake proportional to how many others were slashed in the same epoch — punishes coordinated attacks most severely.

**Sync committee (Altair, 2021):** A rotating subset of 512 validators sign each block header with BLS. Light clients verify only the sync committee aggregate signature (~100 bytes) instead of all ~500K attestations. Enables mobile/browser light clients.

**Deployed at:** Ethereum mainnet (merged September 2022); ~$40B staked ETH secured by Casper FFG. Gasper = Casper FFG + LMD-GHOST fork choice. See [Aggregate Signatures (BLS)](#aggregate-signatures-bls-aggregate), [Threshold Signatures](#threshold-signature-schemes-tss).

**Production readiness:** Production
Live on Ethereum mainnet since September 2022 (The Merge); secures ~$40B+ staked ETH

**Implementations:**
- [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) ⭐ 3.7k — Go, Ethereum consensus client implementing Casper FFG
- [sigp/lighthouse](https://github.com/sigp/lighthouse) ⭐ 3.4k — Rust, Ethereum consensus client
- [ChainSafe/lodestar](https://github.com/ChainSafe/lodestar) ⭐ 1.4k — TypeScript, Ethereum consensus client
- [status-im/nimbus-eth2](https://github.com/status-im/nimbus-eth2) ⭐ 648 — Nim, Ethereum consensus client

**Security status:** Secure
Reverting a finalized block requires burning >= 1/3 of staked ETH (~$15B+); quadratic slashing punishes coordinated attacks

**Community acceptance:** Standard
Core Ethereum consensus protocol; reviewed by hundreds of researchers; formalised in the Gasper paper (2020)

---

## Bitcoin Taproot / BIP 340-342

**Goal:** Upgrade Bitcoin's signature scheme from ECDSA to Schnorr, enable private script execution (MAST), and unify simple and complex spend conditions so they are indistinguishable on-chain. Activated November 2021 (block 709,632).

**Three BIPs comprising Taproot:**

| BIP | Name | What it adds |
|-----|------|-------------|
| **BIP 340** | Schnorr Signatures | 64-byte deterministic Schnorr over secp256k1; batch-verifiable; linear in signing keys |
| **BIP 341** | Taproot | P2TR output type; key path + script path spend; MAST via Merkle tree of scripts |
| **BIP 342** | Tapscript | Updated Script semantics; enables `OP_CHECKSIGADD` for threshold |

**Key path spend:** Output = `Q = P + H(P || script_root) · G`. Spend with Schnorr signature for Q — appears identical to single-key spend. MAST branches remain hidden.

**Advantages of BIP 340 Schnorr over ECDSA:**

| Property | ECDSA | BIP 340 Schnorr |
|----------|-------|----------------|
| Batch verification | No | Yes (~60% faster) |
| Multi-signature | Rounds + complex | Native via MuSig2 |
| Signature size | 71–72 bytes DER | 64 bytes fixed |
| Adaptor signatures | Complex | Native (linear) |

**Nonce generation (BIP 340):** `k = H_tag(secret_key || aux_rand || msg)` — deterministic with 32 bytes auxiliary randomness protecting against fault attacks.

**Enables:** MuSig2 (BIP 327) threshold multisig, FROST, DLC, Lightning PTLC, cross-chain atomic swaps via adaptor signatures. ~65% of Bitcoin transactions use Taproot by 2025.

**State of the art:** Taproot is the current Bitcoin signature standard. See [Adaptor Signatures](#adaptor-signatures--scriptless-scripts), [Threshold Signatures](#threshold-signature-schemes-tss).

**Production readiness:** Production
Activated on Bitcoin mainnet November 2021 (block 709,632); ~65% of transactions use Taproot by 2025

**Implementations:**
- [bitcoin/bitcoin](https://github.com/bitcoin/bitcoin) ⭐ 88k — C++, reference implementation with BIP 340/341/342 support
- [bitcoin-core/secp256k1](https://github.com/bitcoin-core/secp256k1) ⭐ 2.4k — C, optimised Schnorr signature library (BIP 340)
- [btcsuite/btcd](https://github.com/btcsuite/btcd) ⭐ 6.7k — Go, alternative Bitcoin full node with Taproot

**Security status:** Secure
BIP 340 Schnorr signatures are provably secure under the discrete log assumption on secp256k1; deterministic nonce generation with auxiliary randomness protects against fault attacks

**Community acceptance:** Standard
Bitcoin consensus-activated soft fork (BIP 340/341/342); widely adopted by wallets and exchanges; enables MuSig2 and FROST multisig

---

## MimbleWimble

**Goal:** A blockchain protocol that achieves confidential transactions and transaction graph privacy by eliminating addresses and using Pedersen commitments + cut-through to merge transactions — making the UTXO set dramatically smaller and hiding amounts by default.

**Core insight — Confidential Transaction (CT) with no scripts:**
- Every output is a Pedersen commitment: `C = r·G + v·H` (r = blinding factor, v = value)
- No addresses: ownership proved by knowing r (blinding factor acts as private key)
- **Transaction validity**: sum of output commitments − sum of input commitments = excess (a public key to which sender proves knowledge of the secret key)
- Amounts cancel out in the commitment algebra: `Σ(outputs) - Σ(inputs) = r_excess · G`

**Cut-through:** In a block, if output O is immediately spent as input I, both can be removed — they "cut through". The resulting block contains only unspent outputs. This makes blockchain prunable to O(UTXO set size) instead of O(chain history).

**Cryptographic primitives:**

| Primitive | Role |
|-----------|------|
| Pedersen commitments (secp256k1) | Commit to amounts without revealing |
| Bulletproofs (range proofs) | Prove commitment encodes non-negative value |
| Schnorr signatures (excess) | Prove transaction is authorized |
| Diffie-Hellman (ECDH) | Share blinding factors between sender/receiver |

**Implementations:**
No notable open-source implementations available.

| Project | Year | Note |
|---------|------|------|
| **Grin** | 2019 | Pure MimbleWimble; community project; no founders allocation |
| **Beam** | 2019 | MimbleWimble + optional Lelantus; Confidential Assets |
| **Litecoin MWEB** | 2022 | Extension blocks grafted onto Litecoin; optional MW inputs/outputs |

**Original paper:** Tom Elvis Jedusor ("Voldemort"), 2016 anonymous whitepaper dropped in the #bitcoin-wizards IRC channel [[1]](https://download.wpsoftware.net/bitcoin/wizardry/mimblewimble.txt). No trusted setup; fully transparent.

**State of the art:** Litecoin MWEB (2022) is the largest production deployment. Grin uses Bulletproofs+ (2021, ~16% smaller range proofs). See [Confidential Transactions](#confidential-transactions-ct), [Range Proofs](#range-proofs).

**Production readiness:** Production
Grin and Beam mainnets since 2019; Litecoin MWEB extension blocks live since 2022

**Implementations:**
- [mimblewimble/grin](https://github.com/mimblewimble/grin) ⭐ 5.1k — Rust, pure MimbleWimble blockchain
- [BeamMW/beam](https://github.com/BeamMW/beam) ⭐ 723 — C++, MimbleWimble with Lelantus extensions
- [litecoin-project/litecoin](https://github.com/litecoin-project/litecoin) ⭐ 4.6k — C++, Litecoin with MWEB extension blocks

**Security status:** Caution
Cryptographically sound (Pedersen commitments + Bulletproofs); however, transaction graph privacy is weakened by active sniffer attacks that link senders and receivers before cut-through

**Community acceptance:** Niche
Well-studied protocol with academic pedigree; limited adoption beyond Grin, Beam, and Litecoin MWEB; privacy limitations documented in peer-reviewed research

---

## Confidential Transactions (CT)

**Goal:** Hidden amounts on public ledgers. Transaction amounts are replaced by Pedersen commitments — the network verifies that inputs equal outputs (no inflation) without seeing any amounts. Combined with range proofs to ensure no negative values.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Maxwell Confidential Transactions** | 2015 | Pedersen commitments | First CT proposal; homomorphic commitments for amount hiding on Bitcoin [[1]](https://elementsproject.org/features/confidential-transactions/investigation) |
| **RingCT (Monero)** | 2016 | Pedersen + Borromean range proofs | CT combined with linkable ring sigs; default in Monero since 2017 [[1]](https://eprint.iacr.org/2015/1098) |
| **Mimblewimble** | 2016 | Pedersen + cut-through | CT-native protocol; transactions are just kernels + commitments; no addresses [[1]](https://docs.grin.mw/wiki/introduction/mimblewimble/mimblewimble/) |
| **Bulletproofs CT (Monero)** | 2018 | Bulletproofs range proofs | Replaced Borromean proofs in Monero; 80% size reduction [[1]](https://eprint.iacr.org/2017/1066) |
| **Liquid CT (Blockstream)** | 2018 | Pedersen + surjection proofs | Bitcoin sidechain with CT + confidential assets (hide asset type too) [[1]](https://blockstream.com/liquid/) |

**State of the art:** Bulletproofs-based CT (Monero); Mimblewimble (Grin/Beam). Combines [Commitment Schemes](#commitment-schemes) and [Range Proofs](#range-proofs).

**Production readiness:** Production
Deployed in Monero (default since 2017), Liquid Network (2018), and Grin/Beam (2019)

**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, RingCT with Bulletproofs range proofs
- [ElementsProject/elements](https://github.com/ElementsProject/elements) ⭐ 1.1k — C++, Liquid CT with Confidential Assets
- [mimblewimble/grin](https://github.com/mimblewimble/grin) ⭐ 5.1k — Rust, MimbleWimble CT-native protocol

**Security status:** Secure
Pedersen commitment hiding relies on discrete log hardness; homomorphic balance check is information-theoretically sound; range proofs prevent inflation

**Community acceptance:** Widely trusted
Well-established in privacy-coin ecosystem; reviewed by leading cryptographers; Monero and Liquid are largest deployments

---

## Range Proofs

**Goal:** Committed value in range. Prove that a Pedersen-committed value v lies in [0, 2^n) without revealing v. Essential building block for confidential transactions, e-voting, anonymous credentials, and any system where committed values must be non-negative.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Boudot Range Proof** | 2000 | Integer commitments | First efficient range proof; based on Fujisaki-Okamoto commitments [[1]](https://doi.org/10.1007/3-540-45539-6_31) |
| **Borromean Ring Range Proof** | 2015 | Ring signatures | Per-bit ring signature; used in original Monero CT [[1]](https://github.com/Blockstream/borromean_paper/blob/master/borromean_draft_0.01_34241bb.pdf) |
| **Bulletproofs Range Proof** | 2018 | Inner product argument | Logarithmic-size; no trusted setup; aggregatable [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs++** | 2022 | Reciprocal argument | ~15% smaller than Bulletproofs; optimized for range proofs [[1]](https://eprint.iacr.org/2022/510) |
| **ZK-range from SNARKs** | 2020 | PLONK / Groth16 | Embed range check as circuit constraint; efficient when batched [[1]](https://eprint.iacr.org/2019/953) |

**State of the art:** Bulletproofs++ (2022) for standalone range proofs; SNARK-embedded range checks for ZK circuits. See [ZK Proofs](#zero-knowledge-proofs-zk), [Confidential Transactions](#confidential-transactions-ct).

**Production readiness:** Production
Bulletproofs deployed in Monero and Liquid; Bulletproofs+ in Monero since 2022; SNARK-embedded range checks in ZK rollups

**Implementations:**
- [dalek-cryptography/bulletproofs](https://github.com/dalek-cryptography/bulletproofs) ⭐ 1.1k — Rust, Bulletproofs implementation using Ristretto
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, Bulletproofs+ range proofs in production
- [ElementsProject/secp256k1-zkp](https://github.com/ElementsProject/secp256k1-zkp) ⭐ 419 — C, Bulletproofs for Liquid Network

**Security status:** Secure
Bulletproofs security relies on the discrete log assumption; no trusted setup required; well-studied with formal proofs

**Community acceptance:** Widely trusted
Bulletproofs are the standard range proof in production privacy systems; published at IEEE S&P 2018 with extensive peer review

---

## Fair Exchange / Atomic Swaps

**Goal:** Simultaneous exchange without trust. Two parties swap digital assets atomically — either both receive the other's asset, or neither does. No trusted third party needed in the optimistic case. Foundation of cross-chain trading.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Asokan-Shoup-Waidner Optimistic Fair Exchange** | 2000 | Verifiable escrow | TTP intervenes only on dispute; efficient for honest case [[1]](https://doi.org/10.1007/3-540-45539-6_4) |
| **HTLC (Hash Time-Locked Contracts)** | 2013 | Hash preimage + timelock | Cross-chain atomic swaps; Alice reveals preimage to claim both sides [[1]](https://en.bitcoin.it/wiki/Hash_Time_Locked_Contracts) |
| **Adaptor Signature Atomic Swaps** | 2018 | Adaptor sigs | Scriptless swaps using adaptor signatures; better privacy than HTLC [[1]](https://eprint.iacr.org/2020/476) |
| **Submarine Swaps** | 2018 | HTLC (on-chain ↔ off-chain) | Swap between Lightning Network and on-chain Bitcoin [[1]](https://docs.lightning.engineering/the-lightning-network/multihop-payments/hash-time-lock-contract-htlc) |

**State of the art:** Adaptor signature swaps for privacy (see [Adaptor Signatures](#adaptor-signatures--scriptless-scripts)); HTLC for simplicity. Atomic swaps enable trustless DEXs.

**Production readiness:** Production
HTLCs deployed in Lightning Network and cross-chain atomic swap tools; adaptor signature swaps in development

**Implementations:**
- [lightningnetwork/lnd](https://github.com/lightningnetwork/lnd) ⭐ 8.1k — Go, Lightning Network daemon with HTLC support
- [ElementsProject/lightning](https://github.com/ElementsProject/lightning) ⭐ 3.0k — C, Core Lightning with HTLC and submarine swaps
- [comit-network/xmr-btc-swap](https://github.com/comit-network/xmr-btc-swap) ⭐ 714 — Rust, BTC-XMR atomic swap using adaptor signatures

**Security status:** Secure
HTLC security reduces to hash preimage resistance and timelock enforcement; adaptor signatures rely on discrete log assumptions

**Community acceptance:** Widely trusted
HTLCs are a foundational primitive for Lightning Network and cross-chain DEXs; well-understood security model

---

## IBC / Inter-Blockchain Communication Protocol

**Goal:** Provide a standard, trust-minimized protocol for passing authenticated data packets between independent blockchains — without relying on a central bridge or trusted intermediary. Used to transfer tokens and arbitrary messages between Cosmos chains, and increasingly between Cosmos and Ethereum (via IBC Eureka).

**Trust model:** Each chain maintains a light client of the counterparty chain — verifying block headers and state proofs cryptographically, not trusting a multisig or oracle.

**Architecture:**

```
Chain A                          Chain B
┌─────────────────┐             ┌─────────────────┐
│ IBC Application │  Packet     │ IBC Application │
│   (transfer,    │ ──────────► │   (transfer,    │
│   interchain    │             │   interchain    │
│   accounts…)   │             │   accounts…)   │
│                 │             │                 │
│ Channel/Port    │             │ Channel/Port    │
│ Connection      │             │ Connection      │
│ Light client B  │  Proof      │ Light client A  │
│ (verifies B hdrs◄─────────── │ (verifies A hdrs│
└─────────────────┘             └─────────────────┘
```

**Handshake protocol (connection + channel):**
1. `MsgConnectionOpenInit` — Chain A proposes connection
2. `MsgConnectionOpenTry` — Chain B verifies A's light client state, accepts
3. `MsgConnectionOpenAck` / `MsgConnectionOpenConfirm` — mutual authentication complete
4. Channel open follows same 4-way handshake on top of established connection

**Packet lifecycle:**
```
SendPacket → CommitPacket (store hash in state)
           → RelayPacket (off-chain relayer reads, submits to B)
           → RecvPacket (Chain B verifies Merkle proof against A's header)
           → WriteAcknowledgement (success/error written to B's state)
           → AcknowledgePacket (Chain A verifies Merkle proof, releases escrow)
```

**Cryptographic core:**
- **Light client:** Tendermint light client verifies commit signatures from ≥ 2/3 of validators (weighted by stake); or alternative clients (Ethereum's Beacon chain, Ethereum execution proof, Solo machine)
- **State proofs:** IAVL+ / Merkle Patricia Trie Merkle proofs; `CommitmentProof` verified against `AppHash` in block header
- **Header commitment:** Block headers signed with Ed25519 (validator keys) aggregated by threshold (≥ 2/3 stake weight)

**ICS standards (Interchain Standards):**
| ICS | Description |
|-----|-------------|
| ICS-02 | Client semantics (light client interface) |
| ICS-03 | Connection semantics |
| ICS-04 | Channel + packet semantics |
| ICS-20 | Fungible token transfer |
| ICS-27 | Interchain accounts |
| ICS-721 | NFT transfer |

**Deployment:** 115+ chains in Cosmos IBC network (2024); ~$1B+ daily volume; Osmosis DEX, Neutron, Stride, dYdX v4. IBC Eureka extends to Ethereum; Composable Finance brings IBC to Polkadot and Solana via IBC-Substrate.

**State of the art:** IBC v1 (2021) in production; IBC v2 (ICS-02 v2 / IBC Eureka) removes channel layer for direct application-to-application messaging; Packet Forward Middleware enables multi-hop routing.

**Production readiness:** Production
115+ chains in Cosmos IBC network (2024); ~$1B+ daily volume; production since 2021

**Implementations:**
- [cosmos/ibc-go](https://github.com/cosmos/ibc-go) ⭐ 635 — Go, canonical IBC implementation for Cosmos SDK
- [cosmos/ibc-rs](https://github.com/cosmos/ibc-rs) ⭐ 223 — Rust, IBC implementation for non-Go chains
- [composablefi/composable-ibc](https://github.com/ComposableFi/composable-ibc) ⭐ 94 — Rust, IBC for Polkadot/Substrate and beyond
- [informalsystems/hermes](https://github.com/informalsystems/hermes) ⭐ 491 — Rust, IBC relayer

**Security status:** Secure
Security reduces to light client verification of counterparty chain consensus; no trusted intermediary; no known exploits

**Community acceptance:** Standard
ICS standards (ICS-02/03/04/20) are the Cosmos ecosystem standard; adopted by 115+ chains; IBC Eureka extending to Ethereum

---

## EIP-712: Ethereum Typed Structured Data Signing

**Goal:** Allow users to sign structured, human-readable data with their Ethereum private key — rather than opaque 32-byte hashes. Enables wallets (MetaMask, Ledger) to display exactly what the user is approving before signing; prevents blind signing attacks that enabled early DeFi exploits.

**Motivation:** Pre-EIP-712, dapps signed `keccak256(raw_bytes)` — users saw `"Sign this message: 0x3a9f…"` with no context. EIP-712 adds typed structure so wallets show `"Transfer 100 DAI to 0x1234… valid until block 18000000"`.

**Type hash construction:**

```
typeHash = keccak256("TypeName(field1 type1, field2 type2, ...)")

structHash = keccak256(
  typeHash
  || encode(field1)
  || encode(field2)
  || ...
)

domainSeparator = keccak256(
  DOMAIN_TYPE_HASH
  || keccak256(name)
  || keccak256(version)
  || chainId
  || verifyingContract
)

sigHash = keccak256(
  "\x19\x01"
  || domainSeparator
  || structHash
)
```

**Domain separator** binds the signature to a specific contract + chain — prevents replay across chains or contracts.

**Signing and recovery:**
- Wallet signs `sigHash` with secp256k1 ECDSA → `(v, r, s)` recoverable signature
- Contract calls `ecrecover(sigHash, v, r, s)` → recovered signer address
- Contract verifies recovered address matches expected signer

**Applications:**
| Protocol | Usage |
|----------|-------|
| Uniswap Permit2 | Token approval via signature (no on-chain allowance tx) |
| OpenSea Seaport | Off-chain order book with on-chain settlement |
| EIP-2612 (ERC-20 permit) | Gasless token approvals |
| Gnosis Safe | Multi-sig transaction approval |
| ENS off-chain resolver | Off-chain name resolution with on-chain verification |

**EIP-1271:** For smart contract wallets (Gnosis Safe, ERC-4337 accounts) — contracts implement `isValidSignature(bytes32 hash, bytes signature) → bytes4` to support EIP-712 off-chain.

**Security:** `\x19\x01` prefix prevents confusion with Ethereum transaction hashes (which start with RLP). Domain separator with `chainId` prevents cross-chain replay. `verifyingContract` prevents cross-contract replay.

**State of the art:** EIP-712 finalized (2021); EIP-2612 (ERC-20 permit), EIP-4337 (account abstraction), and EIP-3009 (ERC-20 transferWithAuthorization) all build on EIP-712. Used by every major DeFi protocol.

**Production readiness:** Production
Finalized on Ethereum (2021); used by every major DeFi protocol, wallet, and dApp for off-chain signing

**Implementations:**
- [MetaMask](https://github.com/MetaMask/metamask-extension) ⭐ 13k — JavaScript, wallet implementing EIP-712 `eth_signTypedData`
- [ethers-rs](https://github.com/gakonst/ethers-rs) ⭐ 2.5k — Rust, Ethereum library with EIP-712 support
- [ethers.js](https://github.com/ethers-io/ethers.js) ⭐ 8.7k — JavaScript/TypeScript, EIP-712 typed data signing
- [OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) ⭐ 27k — Solidity, EIP-712 base contracts

**Security status:** Secure
Domain separator with chainId and verifyingContract prevents replay; `\x19\x01` prefix prevents confusion with transaction hashes; well-audited implementations

**Community acceptance:** Standard
Ethereum EIP standard (finalized); universally adopted by wallets (MetaMask, Ledger) and DeFi protocols (Uniswap, OpenSea, Gnosis Safe)

---

## Linear BFT Consensus (HotStuff / Tendermint)

**Goal:** Byzantine Fault Tolerant (BFT) consensus with O(n) message complexity per round (vs. O(n²) for PBFT), using threshold signatures so the leader aggregates votes into a single compact certificate. Enables practical BFT at hundreds of validators.

| Protocol | Year | Complexity | Threshold primitive | Deployed |
|----------|------|-----------|---------------------|---------|
| **PBFT** | 1999 | O(n²) messages | — | Early permissioned chains |
| **Tendermint** | 2014 | O(n²) (all-to-all votes) | Ed25519 individual sigs | Cosmos Hub, 270+ chains |
| **HotStuff** | 2019 | O(n) leader-based | Threshold BLS | Diem/Libra, Aptos, Sui |
| **Fast HotStuff** | 2021 | O(n), 2 rounds | Threshold BLS | Facebook Novi (internal) |
| **DiemBFT v4** | 2021 | O(n) | BLS12-381 | Aptos blockchain |
| **Jolteon/Ditto** | 2021 | O(n) + async fallback | BLS aggregate | Aptos (production) |

**HotStuff cryptographic core:**

1. Leader collects threshold-BLS signature shares from ≥ ⌈2n/3⌉ + 1 validators
2. Aggregates into a single **Quorum Certificate (QC)** — one group signature
3. Sends QC to all validators (O(n) per round instead of O(n²) cross-validator messages)
4. Three-phase commit (Prepare → Pre-Commit → Commit) with one QC per phase

**Security:** Safety under ≤ ⌊(n-1)/3⌋ Byzantine faults. Liveness under partial synchrony (GST model). Threshold-BLS aggregation is secure under co-CDH on BLS12-381.

**State of the art:** HotStuff (PODC 2019) and its derivatives power Aptos, Sui, and Diem. Tendermint (2014) powers Cosmos. Both use [BLS Aggregate Signatures](#aggregate-signatures-bls-aggregate) or [Threshold Signatures](#threshold-signature-schemes-tss) as their cryptographic core.

**Production readiness:** Production
Tendermint powers 270+ Cosmos chains; HotStuff derivatives power Aptos and Sui mainnets

**Implementations:**
- [cometbft/cometbft](https://github.com/cometbft/cometbft) ⭐ 874 — Go, Tendermint/CometBFT consensus engine
- [aptos-labs/aptos-core](https://github.com/aptos-labs/aptos-core) ⭐ 6.4k — Rust, Jolteon/DiemBFT v4 (HotStuff derivative)
- [MystenLabs/sui](https://github.com/MystenLabs/sui) ⭐ 7.6k — Rust, Narwhal-Bullshark consensus (HotStuff-inspired)

**Security status:** Secure
Safety under <= floor((n-1)/3) Byzantine faults; liveness under partial synchrony; threshold-BLS aggregation secure under co-CDH

**Community acceptance:** Widely trusted
HotStuff published at PODC 2019; Tendermint is the most deployed BFT engine; both are considered state of the art for permissionless BFT consensus

---

## Secret Leader Election

**Goal:** Elect a leader (block proposer, committee chair) so that the leader's identity is secret until they act. Prevents targeted DoS/bribery attacks on the next leader. Used in blockchain consensus (Ethereum single-slot finality research).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Algorand Cryptographic Sortition** | 2017 | VRF | VRF-based self-selection; each user privately checks if selected [[1]](https://arxiv.org/abs/1607.01341) |
| **Boneh-Eskandarian-Fisch-Hanzlik SLE** | 2020 | Commit-reveal + VRF | Formal secret leader election; leader identity hidden until block proposal [[1]](https://eprint.iacr.org/2020/025) |
| **Whisk (Ethereum proposal)** | 2022 | Shuffle + commitments | Shuffled validator registry; no one knows next proposer; considered for Ethereum [[1]](https://ethresear.ch/t/whisk-a-practical-shuffle-based-ssle-protocol-for-ethereum/11763) |

**State of the art:** Whisk for Ethereum; Algorand sortition deployed. Combines [VRF](#verifiable-random-functions-vrf) and [Commitment Schemes](#commitment-schemes).

**Production readiness:** Experimental
Algorand sortition is in production; Whisk is proposed for Ethereum but not yet deployed

**Implementations:**
- [algorand/go-algorand](https://github.com/algorand/go-algorand) ⭐ 1.4k — Go, VRF-based cryptographic sortition in production
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, Whisk SSLE specification (proposed)

**Security status:** Secure
VRF-based selection is provably unpredictable; Whisk shuffle provides stronger privacy but adds protocol complexity

**Community acceptance:** Emerging
Algorand sortition is well-reviewed and deployed; Whisk is under active Ethereum research with positive reception from researchers

---

## Order-Fair Consensus

**Goal:** Prevent transaction reordering attacks (MEV). If most honest nodes receive transaction A before B, then A must be ordered before B in the final ledger. A new consensus property alongside safety and liveness — fairness of ordering.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Aequitas (Kelkar-Zhang-Goldfeder-Juels)** | 2020 | Threshold timestamps | First order-fair consensus; CRYPTO 2020; ordering reflects receive-order [[1]](https://eprint.iacr.org/2020/269) |
| **Themis** | 2023 | Batch-ordering + consensus | Strong order-fairness with standard liveness; negligible overhead over BFT [[1]](https://eprint.iacr.org/2021/1465) |
| **BEAT-MEV** | 2024 | Batched threshold encryption | Epochless batched TE for encrypted mempools; USENIX Security 2025 [[1]](https://eprint.iacr.org/2024/1533) |

**State of the art:** Themis (2023) for consensus-level fairness; BEAT-MEV for encryption-based MEV prevention. Extends [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering) and [Async BFT](#asynchronous-bft--asynchronous-mpc).

**Production readiness:** Research
Academic proposals (Aequitas, Themis); no large-scale mainnet deployment; BEAT-MEV accepted at USENIX Security 2025

**Implementations:**
- [shutter-network/shutter](https://github.com/shutter-network/shutter) ⭐ 69 — Go, MEV prevention infrastructure (related)

**Security status:** Caution
Fairness guarantees depend on network synchrony assumptions; weaker under asynchronous conditions; active area of formal analysis

**Community acceptance:** Emerging
Published at top venues (CRYPTO 2020, USENIX Security 2025); strongly motivated by MEV problem; no standardisation yet

---

## Groth16 / Zcash Sapling zk-SNARK

**Goal:** The smallest and fastest-verifying pairing-based zk-SNARK for arithmetic circuit satisfiability — a proof of only 3 group elements (~200 bytes) verified with a single pairing product equation — deployed as the cryptographic core of Zcash's Sapling protocol for private shielded transactions.

**Groth16 proof system (Groth, EUROCRYPT 2016):**

A proof for an R1CS (rank-1 constraint system) circuit of size m consists of:

| Component | Size | Role |
|-----------|------|------|
| `[A]₁` | 1 element in G₁ | Encodes witness left-hand side |
| `[B]₂` | 1 element in G₂ | Encodes witness right-hand side |
| `[C]₁` | 1 element in G₁ | Encodes output combination |

Verification checks a single pairing equation: `e([A]₁, [B]₂) = e(α, β) · e(Σᵢ aᵢ[γᵢ]₁, γ) · e([C]₁, δ)` — three pairings total, independent of circuit size.

**Trusted setup — Circuit-specific Powers of Tau:**

Groth16 requires a circuit-specific structured reference string (SRS) `{αG, βG, δG, {τⁱG}, ...}` derived from secret toxic waste `(α, β, δ, τ)`. Bowe-Gabizon-Miers (2017) gave a two-phase MPC ceremony where the toxic waste is split across N participants; the setup is sound as long as ≥ 1 participant destroys their share.

**Zcash Sapling deployment (2018):**

| Ceremony | Year | Participants | Circuit | Note |
|----------|------|-------------|---------|------|
| **Powers of Tau (Phase 1)** | 2017 | 87 | Universal | General-purpose phase; no circuit needed |
| **Sapling MPC (Phase 2)** | 2018 | ~200 | Spend + Output circuits | Circuit-specific; BLS12-381 curve |

Sapling uses two circuits: Spend (proves ownership + nullifier) and Output (proves new note commitment). Each shielded transaction proves both without revealing amounts, addresses, or transaction graph.

**BLS12-381:** Zcash and Groth16 popularized this curve — 128-bit security, 381-bit field, efficient pairings. Now the standard curve for Ethereum BLS signatures (Casper FFG), Filecoin, and many SNARK systems.

**Limitations:** Circuit-specific trusted setup; proving is slow (~1–3 seconds on a PC). Superseded by universal-SRS SNARKs (PLONK, Marlin) for new systems, but Groth16 remains the gold standard for per-proof verification efficiency.

**State of the art:** Groth16 is deployed in Zcash Sapling (2018, billions of shielded transactions), Filecoin PoRep/PoSt (see below), Semaphore (Ethereum), and Tornado Cash circuits. EUROCRYPT 2016 paper [[1]](https://eprint.iacr.org/2016/260). See [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [Filecoin PoRep/PoSt](#filecoin-porep--post-proof-of-replication--proof-of-spacetime).

**Production readiness:** Production
Deployed in Zcash Sapling (2018), Filecoin (2020), Semaphore, Tornado Cash; billions of proofs generated

**Implementations:**
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Zcash Sapling Groth16 prover/verifier
- [arkworks-rs/groth16](https://github.com/arkworks-rs/groth16) ⭐ 339 — Rust, generic Groth16 implementation
- [iden3/snarkjs](https://github.com/iden3/snarkjs) ⭐ 2.0k — JavaScript, Groth16 prover/verifier for browser and Node.js
- [filecoin-project/bellperson](https://github.com/filecoin-project/bellperson) ⭐ 202 — Rust, GPU-accelerated Groth16 for Filecoin

**Security status:** Secure
Provably sound under the generic group model and q-type assumptions on BLS12-381; requires trusted setup (circuit-specific SRS); setup MPC ceremonies mitigate toxic waste risk

**Community acceptance:** Widely trusted
EUROCRYPT 2016; the most cited and deployed zk-SNARK scheme; Zcash, Filecoin, and Ethereum ecosystem all rely on Groth16

---

## Lightning Network Payment Channels

**Goal:** Instant, near-zero-fee Bitcoin payments between parties without broadcasting every transaction on-chain. Two parties lock funds in a 2-of-2 multisig, then exchange cryptographically signed commitment transactions off-chain. The blockchain is used only for channel open/close; the revocation mechanism makes old state broadcasts unprofitable.

**Channel lifecycle:**

```
Open: Alice + Bob jointly fund a 2-of-2 on-chain UTXO
  │
  ├── Exchange commitment transactions off-chain (state updates)
  │   Each state invalidates the previous via revocation keys
  │
Close (cooperative): Publish final balance directly
Close (unilateral): Broadcast latest commitment tx; timelock gives other party a window to punish
```

**Poon-Dryja penalty mechanism (2016):**

Each commitment transaction is asymmetric — Alice's version of state N makes her own output subject to a CSV (CheckSequenceVerify) timelock, while Bob's output is immediately spendable. Alice also gives Bob a revocation secret for state N when they advance to state N+1. If Alice broadcasts an old state, Bob can use the revocation secret to claim all channel funds (the "penalty transaction") within the CSV window.

| Component | Mechanism | Purpose |
|-----------|-----------|---------|
| **2-of-2 funding output** | P2WSH multisig | Locks funds; requires both signatures to spend |
| **Commitment transaction** | ECDSA → Schnorr (Taproot) | Current channel state; asymmetric timelocks |
| **Revocation key** | `rev = H(per_commitment_secret)` | Claim all funds if counterparty cheats |
| **HTLC output** | SHA-256 hashlock + CLTV timelock | In-flight payments; see [Atomic Swaps](#fair-exchange--atomic-swaps) |
| **PTLC (Taproot upgrade)** | Adaptor signature + point lock | Replaces HTLC; breaks payment correlation |

**Multi-hop payments:** Alice can pay Carol through Bob using chained HTLCs. Each hop adds a hashlock with the same preimage — Carol reveals the preimage to Bob, Bob reveals it to Alice, atomically. PTLCs (Point Time-Lock Contracts) use adaptor signatures to provide the same atomicity without hash correlation across hops.

**Eltoo / LN-Symmetry (Decker-Russell-Osuntokun, 2018):** Proposed replacement for penalty channels. Uses `SIGHASH_ANYPREVOUT` (BIP 118, not yet activated) to allow the latest state to supersede any earlier state — no revocation keys, no asymmetric states, simpler watchtower logic. Awaits Bitcoin soft-fork activation.

**State of the art:** LN-Penalty (Poon-Dryja) is deployed in production — ~5,000 BTC capacity, ~15,000 nodes (2025). Taproot channels (PTLC-ready) rolled out in 2024 via LND and CLN. Original paper [[1]](https://lightning.network/lightning-network-paper.pdf); Eltoo [[2]](https://blockstream.com/eltoo.pdf). See [Adaptor Signatures](categories/08-signatures-advanced.md#adaptor-signatures--scriptless-scripts), [Fair Exchange / Atomic Swaps](#fair-exchange--atomic-swaps).

**Production readiness:** Production
~5,000 BTC capacity, ~15,000 nodes (2025); Taproot channels rolling out via LND and CLN

**Implementations:**
- [lightningnetwork/lnd](https://github.com/lightningnetwork/lnd) ⭐ 8.1k — Go, Lightning Network Daemon by Lightning Labs
- [ElementsProject/lightning](https://github.com/ElementsProject/lightning) ⭐ 3.0k — C, Core Lightning (CLN) by Blockstream
- [ACINQ/eclair](https://github.com/ACINQ/eclair) ⭐ 1.3k — Scala, Lightning implementation by ACINQ
- [lightningdevkit/rust-lightning](https://github.com/lightningdevkit/rust-lightning) ⭐ 1.3k — Rust, Lightning Development Kit (LDK)

**Security status:** Caution
Penalty mechanism is game-theoretically secure; requires watchtower or online presence to detect cheating; Eltoo (LN-Symmetry) awaits BIP 118 activation for improved security model

**Community acceptance:** Widely trusted
Original paper (Poon-Dryja, 2016) is highly cited; multiple independent implementations; adopted by major exchanges and payment processors

---

## ZK Rollups and Optimistic Rollups

**Goal:** Scale Ethereum throughput by executing transactions off-chain and posting only a compressed summary plus a cryptographic proof (ZK rollup) or an assertion subject to fraud challenge (optimistic rollup) to L1. Either approach inherits Ethereum's security while offering 10–100× cost reduction.

**Comparison of the two approaches:**

| Property | ZK Rollup | Optimistic Rollup |
|----------|-----------|-------------------|
| Validity mechanism | Validity proof (SNARK/STARK) | Fraud proof + challenge window |
| Finality on L1 | Immediate (after proof verification) | ~7 days (challenge period) |
| Proof cost | High prover compute; cheap L1 verify | None normally; expensive if challenged |
| EVM compatibility | Hard (circuit must encode EVM) | Easy (re-execute disputed tx on L1) |
| Example projects | zkSync Era, Starknet, Polygon zkEVM | Optimism (OP Stack), Arbitrum |

**ZK rollup cryptographic stack:**

Each batch of N transactions is compiled into a circuit; the prover generates a SNARK/STARK proving state transition correctness:

| System | Proof system | Trusted setup | Note |
|--------|-------------|--------------|------|
| **StarkEx / Starknet** | STARK (FRI + AIR) | None | Quantum-resistant; larger proofs (~100 KB) |
| **zkSync Era** | Boojum (Plonky2 variant + STARK) | None | Recursive STARKs for scalable batching |
| **Polygon zkEVM** | PLONK + FRI (Plonky2) | None | EVM-equivalent; type-2 zkEVM |
| **Scroll** | PLONK + KZG | KZG ceremony | EVM-equivalent; type-2 zkEVM |
| **Linea (ConsenSys)** | Gnark (PLONK) | None | EVM-compatible; deployed on Ethereum |

**Optimistic rollup fraud proof mechanism:**

Sequencer posts state root + compressed calldata on L1. During the 7-day challenge window, any verifier can initiate a bisection game (interactive fraud proof, used by Arbitrum) or single-round re-execution (Cannon, used by Optimism/OP Stack) to pinpoint and prove the invalid instruction. If a fraud proof succeeds, the sequencer's bond is slashed.

**Recursive proof aggregation:** ZK rollups chain SNARK proofs — a "proof of proofs" aggregates N batch proofs into one, amortizing L1 verification cost. Starknet, zkSync, and Polygon all use recursive SNARKs (see [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md)).

**State of the art:** Optimism and Arbitrum dominate TVL (~$10B+ combined, 2025); zkSync Era and Starknet are the leading ZK rollups by usage. All major projects are converging on ZK proofs long-term. See [Data Availability Sampling](#data-availability-sampling-das) (EIP-4844 blobs cut rollup costs ~10×). Survey [[1]](https://ethereum.org/en/developers/docs/scaling/zk-rollups/).

**Production readiness:** Production
Optimism and Arbitrum hold ~$10B+ TVL (2025); zkSync Era and Starknet are leading ZK rollups in production

**Implementations:**
- [ethereum-optimism/optimism](https://github.com/ethereum-optimism/optimism) ⭐ 6.4k — Go/Solidity, OP Stack optimistic rollup
- [OffchainLabs/nitro](https://github.com/OffchainLabs/nitro) ⭐ 906 — Go/Rust, Arbitrum Nitro optimistic rollup
- [matter-labs/zksync-era](https://github.com/matter-labs/zksync-era) ⭐ 3.2k — Rust, zkSync Era ZK rollup
- [starkware-libs/cairo](https://github.com/starkware-libs/cairo) ⭐ 1.9k — Rust, Cairo language for Starknet ZK rollup
- [scroll-tech/scroll](https://github.com/scroll-tech/scroll) ⭐ 746 — Go/Rust, Scroll zkEVM rollup

**Security status:** Caution
ZK rollups inherit Ethereum security via validity proofs; optimistic rollups rely on fraud-proof windows (7 days) and at least one honest watcher; sequencer centralisation is a current concern across all rollups

**Community acceptance:** Widely trusted
Core to Ethereum's scaling roadmap; endorsed by Ethereum Foundation; billions of dollars secured; active standardization of rollup frameworks (OP Stack, ZK Stack)

---

## Verkle Trees (Ethereum State)

**Goal:** Replace Ethereum's Merkle-Patricia Trie (MPT) with a Verkle tree — a polynomial-commitment-based authenticated data structure that produces witnesses ~6–30× smaller than Merkle proofs. The primary motivation is **stateless clients**: nodes can validate blocks without storing Ethereum's full state (~200 GB), instead receiving a compact witness with each block.

**From Merkle hashes to vector commitments:**

In a Merkle tree, a path proof requires one sibling hash per level. In a Verkle tree, each internal node is a polynomial commitment (KZG or Pedersen) to its children's values. A multiproof for k leaves across the whole tree collapses to a constant number of group elements regardless of tree depth, because commitment openings aggregate.

| Property | Merkle-Patricia Trie | Verkle Tree |
|----------|---------------------|-------------|
| Node branching factor | 16 | 256 |
| Proof per leaf | ~3 KB (MPT, hexary) | ~150 bytes |
| Multi-leaf proof | Linear in leaves | ~constant (aggregated) |
| Commitment scheme | Keccak-256 hash | Pedersen commitment (Bandersnatch curve) |
| Trusted setup | None | None (Pedersen, not KZG) |

**Ethereum's design choices:**

- **Curve:** Bandersnatch — a Jubjub-like curve embedded inside BLS12-381 scalar field, enabling efficient SNARK-friendly inner verification
- **Commitment:** Pedersen vector commitment (not KZG) — no trusted setup, 256-ary branching
- **Encoding:** Polynomial over F_p where each child is a field element; commitment = Σ child_i · Gᵢ (multi-scalar multiplication)
- **Tree structure:** Single unified trie (accounts + storage) replacing MPT's two-trie design

**Stateless Ethereum workflow:**

```
Block producer: Compute state diff → generate witness (opened commitments for all touched nodes)
Block validator: Receive block + witness → verify commitment openings → apply state transition
No local state needed — witness carries all necessary proofs
```

**EIP-6800 / Verkle migration:** Ethereum's Verkle transition requires a hard fork to migrate the existing MPT state. Devnet testing ongoing (2024–2025); full mainnet deployment expected post-Pectra upgrade.

**State of the art:** Vitalik Buterin's Verkle tree proposal (2021) [[1]](https://vitalik.eth.limo/general/2021/06/18/verkle.html); Ethereum Foundation blog post on structure [[2]](https://blog.ethereum.org/2021/12/02/verkle-tree-structure). See [Commitment Schemes](categories/09-commitments-verifiability.md#commitment-schemes), [Data Availability Sampling](#data-availability-sampling-das).

**Production readiness:** Experimental
Devnet testing ongoing (2024-2025); full Ethereum mainnet deployment expected post-Pectra upgrade

**Implementations:**
- [gballet/go-verkle](https://github.com/gballet/go-verkle) ⭐ 236 — Go, Verkle tree library for Ethereum
- [crate-crypto/go-ipa](https://github.com/crate-crypto/go-ipa) ⭐ 37 — Go, Inner Product Argument for Verkle proofs
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, Ethereum Verkle tree specification

**Security status:** Secure
Pedersen vector commitments over Bandersnatch curve; no trusted setup; security relies on discrete log assumption; formally analysed

**Community acceptance:** Emerging
Proposed by Vitalik Buterin (2021); under active Ethereum Foundation development; strong research community support; no alternative proposals competing

---

## Filecoin PoRep / PoSt (Proof of Replication / Proof of Spacetime)

**Goal:** Prove that a storage provider has dedicated unique physical storage to a specific client's data (PoRep), and continues to store it over time (PoSt) — without the verifier retrieving the data. Filecoin's entire incentive model rests on these two cryptographic proofs, both implemented as Groth16 zk-SNARKs posted on-chain.

**Proof of Replication (PoRep) — Stacked DRG (SDR):**

The raw data (a "sector", typically 32 GiB) is encoded into a replica through a sequence of directed random graph (DRG) layers. The encoding is intentionally slow — O(n log n) sequential hash operations — making it infeasible to regenerate the replica on-demand and thereby fake storage.

```
Unsealed sector (data)
  │
  └─ SDR encoding (11 layers × DRG labeling via SHA-256 + Poseidon)
      │
      └─ Sealed replica (unique per storage provider per sector)
          │
          └─ Merkle tree commitment (TreeC, TreeD, TreeR)
              │
              └─ Groth16 SNARK over commit graph (~3 MB native proof → 192 bytes on-chain)
```

**PoRep circuit:** Proves knowledge of the unsealed data and all DRG layer labels consistent with the sealed replica root, without revealing the data. Uses Poseidon hash (SNARK-friendly) inside the circuit and SHA-256 outside.

**Proof of Spacetime (PoSt):** Proves continuous storage by periodically sampling random leaves of the replica Merkle tree:

| Variant | Frequency | Purpose | Mechanism |
|---------|-----------|---------|-----------|
| **WinningPoSt** | Per block (~30 s) | Block eligibility lottery | Storage provider proves replica leaf in the elected block to win block reward |
| **WindowPoSt** | Every 24 hours | Audit / slashing | Proves all sectors in a 24-h window; failure triggers stake slashing |

Both PoSt variants are also Groth16 SNARKs, compressing large Merkle proofs to ~192 bytes each.

**Cryptographic primitives:**

| Primitive | Role |
|-----------|------|
| Poseidon hash | SNARK-friendly hash for DRG labeling and Merkle trees inside circuits |
| SHA-256 | Label seeding outside circuits |
| Pedersen commitments | Leaf value commitments in TreeC |
| Groth16 over BLS12-381 | Compress all proofs to 192 bytes for on-chain posting |
| VRF (DLEQ-based) | Randomness beacon for PoSt challenge selection |

**Scale:** Filecoin mainnet stores ~1.7 EiB (exbibytes) of data (2025), secured by continuous WindowPoSt proofs from ~2,000 storage providers. Each 32 GiB sector requires ~1.5 hours of SDR encoding and ~30 minutes of SNARK proving on GPU.

**State of the art:** SDR PoRep and PoSt are deployed on Filecoin mainnet (launched 2020). Original PoRep paper (Fisch et al.) [[1]](https://eprint.iacr.org/2018/678); Filecoin Proof of Useful Space technical report [[2]](https://research.protocol.ai/publications/filecoin-proof-of-useful-space/giacomelli2023.pdf). See [Groth16 / Zcash Sapling zk-SNARK](#groth16--zcash-sapling-zk-snark), [Proof of Work / Proof of Space](#proof-of-work-pow--proof-of-space).

**Production readiness:** Production
Filecoin mainnet since October 2020; ~1.7 EiB stored; ~2,000 storage providers running continuous PoSt proofs

**Implementations:**
- [filecoin-project/rust-fil-proofs](https://github.com/filecoin-project/rust-fil-proofs) ⭐ 503 — Rust, Filecoin proof system (PoRep/PoSt)
- [filecoin-project/bellperson](https://github.com/filecoin-project/bellperson) ⭐ 202 — Rust, GPU-accelerated Groth16 prover for Filecoin
- [filecoin-project/lotus](https://github.com/filecoin-project/lotus) ⭐ 3.0k — Go, Filecoin full node with proof generation

**Security status:** Secure
SDR encoding is intentionally sequential (O(n log n) hashes); Groth16 proofs are computationally sound; Poseidon hash is SNARK-optimised with conservative parameters

**Community acceptance:** Niche
Unique to Filecoin's decentralised storage model; peer-reviewed PoRep construction (Fisch et al.); no standardisation body adoption but well-studied in academic literature

---

## EIP-4844 Proto-Danksharding (Blob Transactions + KZG Ceremony)

**Goal:** Introduce a new transaction type carrying temporary "blobs" of data to Ethereum — committed via KZG polynomial commitments over BLS12-381 — so that rollups can post data cheaply without paying calldata gas, reducing L2 fees by ~10× as the first step toward full Danksharding.

**Motivation:** Before EIP-4844, rollups (Optimism, Arbitrum, zkSync, Starknet) posted compressed transaction data as Ethereum calldata, paying full execution-gas prices. EIP-4844 adds a separate, cheaper data "blob" lane whose contents are deleted by consensus nodes after ~18 days — long enough for fraud-proof windows — while the KZG commitment persists on-chain forever.

**Cryptographic design:**

Each blob is a polynomial `f(x)` of degree 4095 over the BLS12-381 scalar field F_r:

| Component | Mechanism |
|-----------|-----------|
| Blob data | 4096 field elements × 32 bytes = 131,072 bytes (~125 KB) of raw data |
| KZG commitment | 48-byte compressed G1 point: `C = f(τ)·G₁` (evaluated at secret τ from trusted setup) |
| KZG proof | 48-byte G1 point proving evaluation `f(z) = y` at any challenge point z |
| Versioned hash | `SHA256(commitment)[1:]` prefixed with version byte `0x01`; stored on-chain permanently |
| Point evaluation precompile | EIP-4844 adds `0x0a`: given `(commitment, z, y, proof)`, verifies `f(z) = y` using a KZG pairing check on BLS12-381 |

**KZG pairing check:** `e(proof, [τ - z]₂) == e(commitment - [y]₁, G₂)` — one pairing equation verifiable in ~3 ms.

**Trusted setup ceremony (Powers of Tau):**

The KZG setup requires a structured reference string `(τ⁰G₁, τ¹G₁, …, τ⁴⁰⁹⁵G₁, τ⁰G₂, τ¹G₂)` where τ is never known to anyone. The EIP-4844 ceremony ran from January–March 2023:

| Metric | Value |
|--------|-------|
| Total contributions | 141,416 participants |
| Setup security | Sound if ≥ 1 participant destroyed their τ shard |
| Curve | BLS12-381 (same as Ethereum BLS signatures, Zcash) |
| Output SRS | 4096 G1 points + 2 G2 points (65 KB) |

This is the largest cryptographic trusted setup ceremony ever conducted.

**Blob lifecycle:**

```
Rollup submits blob transaction
  │
  ├─ Execution layer: stores versioned_hash (32 bytes) permanently
  │
  ├─ Consensus layer (Beacon chain): propagates full blob (~125 KB) via p2p
  │   └─ Verifies KZG commitment matches blob contents
  │
  └─ After ~4096 epochs (~18 days): blob data pruned by consensus nodes
      (execution-layer commitment + versioned hash remain forever)
```

**Per-block blob capacity:** EIP-4844 targets 3 blobs/block (max 6), each ~125 KB → ~375 KB/block of rollup data at ~5–10× lower cost than equivalent calldata.

**Deployed:** Ethereum Cancun-Deneb upgrade, March 13 2024. Immediately reduced rollup fees 5–10×. Full Danksharding (64 blobs/block + DAS) is planned as the next step and reuses this same KZG commitment infrastructure.

**State of the art:** EIP-4844 live on Ethereum mainnet (March 2024). Specification [[1]](https://eips.ethereum.org/EIPS/eip-4844); KZG ceremony [[2]](https://ceremony.ethereum.org/). See [Data Availability Sampling](#data-availability-sampling-das), [ZK Rollups](#zk-rollups-and-optimistic-rollups), [Commitment Schemes](categories/09-commitments-verifiability.md#commitment-schemes).

**Production readiness:** Production
Live on Ethereum mainnet since Cancun-Deneb upgrade, March 13 2024; reduced rollup fees 5-10x

**Implementations:**
- [ethereum/c-kzg-4844](https://github.com/ethereum/c-kzg-4844) ⭐ 167 — C, KZG library for EIP-4844 blob verification
- [crate-crypto/kzg](https://github.com/crate-crypto/go-kzg-4844) ⭐ 12 — Go, KZG implementation for EIP-4844
- [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) ⭐ 3.7k — Go, Ethereum consensus client with blob support
- [sigp/lighthouse](https://github.com/sigp/lighthouse) ⭐ 3.4k — Rust, Ethereum consensus client with blob support

**Security status:** Secure
KZG commitment security relies on q-SDH assumption on BLS12-381; trusted setup ceremony had 141,416 participants (sound if >= 1 honest); blob data pruned after ~18 days

**Community acceptance:** Standard
Ethereum EIP (finalized); largest cryptographic trusted setup ceremony ever conducted; live on mainnet; critical infrastructure for all L2 rollups

---

## Mina Protocol — Pickles Recursive SNARK (22 KB Blockchain)

**Goal:** Maintain a succinct blockchain of constant size (~22 KB) by using recursive zk-SNARKs to compress the entire chain history into a single proof — so any light client can verify the whole chain state from genesis with a single proof check, regardless of chain length.

**Core insight:** Instead of replaying all transactions, Mina keeps a single proof `π_n` that attests: "there exists a valid chain of n blocks starting from genesis." When block n+1 arrives, the prover generates `π_{n+1}` that proves "π_n was valid AND block n+1 transitions the state correctly." Verification cost is O(1) regardless of chain length.

**Proof system — Pickles over Pasta curves:**

Recursive SNARKs require verifying one proof inside the circuit of another. This demands that the circuit arithmetic match the proof system's native field. Mina uses a 2-cycle of elliptic curves (the **Pasta** cycle) so that each curve's scalar field is the other's base field — eliminating expensive field-mismatch operations:

| Curve | Role | Field size |
|-------|------|-----------|
| **Pallas** | "Wrap" circuit (Tock); verifies Vesta proofs | 255-bit scalar |
| **Vesta** | "Step" circuit (Tick); verifies Pallas proofs | 255-bit scalar |

**Kimchi proof system:** Mina's underlying SNARK is Kimchi — a modified PLONK variant using an Inner Product Argument (IPA) commitment scheme (no pairing, no trusted setup). IPA provides ~O(log n) proof size with no structured reference string.

| Component | Mechanism |
|-----------|-----------|
| Polynomial commitments | IPA over Pasta curves (no trusted setup) |
| Constraint system | Kimchi (PLONK variant with custom gates) |
| Recursion | Pickles — alternating Tick/Tock proofs over Pallas/Vesta |
| Block proof size | ~22 KB (fixed, independent of chain length) |
| Verification | Single recursive proof check; ~200 ms on commodity hardware |

**zkApps (programmable privacy):** Since every Mina account can carry a SNARK proof of its state, smart contracts ("zkApps") are zero-knowledge by default. A zkApp circuit runs client-side; the on-chain state update is accompanied by a Pickles proof of correct execution — users never reveal private inputs to the network.

**State of the art:** Mina mainnet launched March 2021; Kimchi replaced the earlier Groth16-based system in 2022. Pickles specification [[1]](https://o1-labs.github.io/proof-systems/pickles/overview.html); Pasta curves [[2]](https://o1-labs.github.io/proof-systems/specs/pasta.html); technical overview [[3]](https://minaprotocol.com/blog/22kb-sized-blockchain-a-technical-reference). See [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [Groth16 / Zcash Sapling zk-SNARK](#groth16--zcash-sapling-zk-snark).

**Production readiness:** Production
Mina mainnet launched March 2021; Kimchi proof system replaced Groth16 in 2022; zkApps live

**Implementations:**
- [o1-labs/proof-systems](https://github.com/o1-labs/proof-systems) ⭐ 458 — Rust, Kimchi proof system and Pasta curves
- [o1-labs/snarkyjs](https://github.com/o1-labs/o1js) ⭐ 602 — TypeScript, o1js SDK for zkApp development
- [o1-labs/mina](https://github.com/mina-deploy/mina) ⭐ 4.4k — OCaml, Mina Protocol node with Pickles recursive proofs

**Security status:** Secure
IPA commitment scheme over Pasta curves has no trusted setup; Kimchi (PLONK variant) security under algebraic group model; recursive accumulation is formally analysed

**Community acceptance:** Niche
Novel approach to constant-size blockchain; well-reviewed by academic cryptographers; limited ecosystem compared to Ethereum; growing zkApp developer community

---

## Solana Proof of History (PoH)

**Goal:** Provide a cryptographic clock — a globally verifiable, append-only record of the passage of real time — so that Solana validators can timestamp events without communicating with each other, enabling sub-second block times and parallelized transaction processing.

**Construction:** PoH is a sequential Verifiable Delay Function (VDF) using SHA-256. The leader validator runs a tight loop:

```
state₀ = initial_hash
stateₙ₊₁ = SHA256(stateₙ)
```

Every ~400,000 iterations (~400 ms), the current `(count, stateₙ)` is checkpointed and broadcast. Transactions are mixed into the hash stream by appending their hash as additional input: `stateₙ₊₁ = SHA256(stateₙ || tx_hash)`. This "embeds" each transaction at a specific counter position, providing a cryptographic timestamp.

**Why it is a VDF:** SHA-256 is a sequential pre-image resistant function — each output depends on the previous output, so computing state_n requires n sequential hash evaluations. Parallelism does not help (no brute-force shortcut exists short of 2^128 cores). Any other validator can verify the sequence in parallel (each step is independent to check) at a fraction of the generation time.

**Role in consensus:**

| Component | Mechanism |
|-----------|-----------|
| PoH leader | Single designated validator generates the hash stream; acts as the network clock |
| Tower BFT | Solana's PoS consensus uses PoH timestamps to order votes; validators lock stake behind PoH slots |
| Gulf Stream | Transaction forwarding to the upcoming leader before their slot begins, enabled by the predictable PoH schedule |
| Turbine | Block propagation uses PoH slot timing to pipeline data across the validator tree |

**Security model:** PoH does not by itself prevent the leader from censoring or reordering transactions — Tower BFT (a BFT variant of PBFT) provides safety and liveness. PoH provides a verifiable ordering substrate, not consensus. A malicious leader's PoH stream is detectable because honest validators also run their own local PoH clocks; large deviations are slashable.

**Performance:** At ~400 ms slots with ~50,000 transactions per second, Solana's PoH enables one of the highest throughputs of any L1 (2025). The SHA-256 loop runs at ~500 MHz on modern CPUs, producing ~400,000 hashes/second.

**State of the art:** PoH deployed on Solana mainnet since March 2020. Whitepaper (Yakovenko, 2017) [[1]](https://solana.com/solana-whitepaper.pdf); blog post [[2]](https://medium.com/solana-labs/proof-of-history-a-clock-for-blockchain-cf47a61a9274). See [Verifiable Delay Functions](categories/09-commitments-verifiability.md#verifiable-delay-functions-vdf), [Linear BFT Consensus](#linear-bft-consensus-hotstuff--tendermint).

**Production readiness:** Production
Deployed on Solana mainnet since March 2020; ~50,000 TPS; one of the highest-throughput L1s

**Implementations:**
- [solana-labs/solana](https://github.com/solana-labs/solana) ⭐ 14k [archived] — Rust, Solana validator with PoH implementation
- [anza-xyz/agave](https://github.com/anza-xyz/agave) ⭐ 1.7k — Rust, Anza validator client (Solana fork)

**Security status:** Caution
PoH provides verifiable ordering but not consensus safety alone (Tower BFT provides that); SHA-256 sequential hash chain is secure but leader can censor/reorder within their slot

**Community acceptance:** Niche
Unique to Solana; provides a verifiable clock rather than traditional consensus; well-adopted within Solana ecosystem but not used elsewhere

---

## Polkadot BABE/GRANDPA Hybrid Consensus

**Goal:** Combine fast probabilistic block production (BABE) with a provably final BFT finality gadget (GRANDPA) to give Polkadot both high throughput and economic finality — finalizing entire chain prefixes (not individual blocks) in one round, enabling fast cross-chain messaging via IBC/XCM.

**Two-layer design:**

| Layer | Protocol | Purpose | Cryptography |
|-------|----------|---------|-------------|
| Block production | **BABE** (Blind Assignment for Blockchain Extension) | Probabilistic leader election; slot-based | VRF (Sr25519 / Ristretto255) |
| Finality | **GRANDPA** (GHOST-based Recursive Ancestor Deriving Prefix Agreement) | BFT finality gadget; votes on chains not blocks | Ed25519 individual votes |

**BABE — VRF-based slot assignment:**

Each validator evaluates a VRF with their secret key over the current epoch randomness and slot number. If `VRF_output < threshold`, they are the primary slot leader. Secondary (round-robin) assignments prevent empty slots. The VRF proof is included in the block header, allowing any observer to verify the leader was legitimately elected without revealing the validator's advantage in future slots.

**GRANDPA — chain-voting finality:**

GRANDPA voters cast votes on the *highest block* they believe is valid, rather than on individual blocks. The algorithm derives the block with a supermajority (> 2/3 stake) among all ancestor chains:

```
Round r:
  1. Prevote: each validator signs (round, block_hash) with Ed25519
  2. Precommit: after seeing ≥ 2/3 prevotes for a chain prefix
  3. Commit: block B is finalized when ≥ 2/3 precommits exist
     for B and all ancestors of B are transitively finalized
```

Key property: GRANDPA finalizes entire chain prefixes in one message round — if validators have converged on a long chain, thousands of blocks finalize simultaneously. This is much faster than finalizing block-by-block.

**Cryptographic primitives:**

| Primitive | Usage |
|-----------|-------|
| Sr25519 (Schnorr / Ristretto255) | BABE VRF proofs; account signatures |
| Ed25519 | GRANDPA vote signatures |
| BLS (planned/BEEFY) | BEEFY gadget — BLS aggregate finality proofs for light clients and bridges |
| BEEFY | BLS-based finality commitment scheme enabling compact Merkle Mountain Range proofs for bridges |

**BEEFY (Bridge Efficiency Enabling Finality Yielding):** An additional gadget on top of GRANDPA that produces BLS aggregate signatures over Merkle Mountain Range (MMR) commitments of the finalized chain. These compact proofs (one BLS signature per epoch) enable Polkadot's parachains to bridge to Ethereum and other chains with minimal on-chain verification cost.

**Fault tolerance:** Safe under ≤ 1/3 Byzantine stake for both BABE and GRANDPA. GRANDPA tolerates ≤ 1/5 Byzantine nodes even in asynchronous conditions (partial sync fallback).

**State of the art:** BABE/GRANDPA deployed on Polkadot mainnet (launched May 2020); BEEFY deployed for Polkadot–Ethereum bridge (2023). GRANDPA paper (Stewart & Kokoris-Kogia, 2020) [[1]](https://arxiv.org/abs/2007.01560); Web3 Foundation overview [[2]](https://wiki.polkadot.com/learn/learn-consensus/). See [Linear BFT Consensus](#linear-bft-consensus-hotstuff--tendermint), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality), [Aggregate Signatures (BLS)](categories/08-signatures-advanced.md#aggregate-signatures-bls-aggregate).

**Production readiness:** Production
Polkadot mainnet since May 2020; BEEFY finality gadget deployed for bridges (2023); powers 50+ parachains

**Implementations:**
- [nickvdS/polkadot-sdk](https://github.com/paritytech/polkadot-sdk) ⭐ 2.7k — Rust, Polkadot SDK with BABE/GRANDPA/BEEFY
- [nickvdS/polkadot-sdk (Substrate)](https://github.com/paritytech/polkadot-sdk/tree/master/substrate) ⭐ 2.7k — Rust, Substrate framework with pluggable consensus
- [nickvdS/finality-grandpa](https://github.com/paritytech/finality-grandpa) ⭐ 141 — Rust, GRANDPA finality gadget implementation

**Security status:** Secure
Safe under <= 1/3 Byzantine stake for both BABE and GRANDPA; GRANDPA tolerates <= 1/5 Byzantine nodes under asynchrony; VRF-based slot assignment prevents targeted DoS

**Community acceptance:** Widely trusted
GRANDPA paper peer-reviewed (2020); Web3 Foundation research backed; deployed across Polkadot, Kusama, and 50+ parachains

---

## Ethereum BLS Aggregate Signatures (BDN / BLS12-381)

**Goal:** Allow ~500,000 Ethereum validators to each sign every attestation slot, yet have the network process all those signatures with only a few hundred bytes of on-chain data and a constant number of pairing operations. Boneh-Drijvers-Neven (BDN) aggregation makes this practical by defending against rogue-key attacks without expensive proofs-of-possession for every signature.

**Rogue-key attack on naive BLS aggregation:** If Alice publishes pubkey `A` and Bob maliciously registers `B' = B - A`, the aggregate public key `A + B' = B` lets Bob forge aggregate signatures. BDN prevents this by hashing each signer's key into a weighting coefficient before aggregating, so the attacker cannot cancel out honest keys.

**BDN scheme (Boneh-Drijvers-Neven, CRYPTO 2018):**

```
Individual signature: σᵢ = H(m)^{skᵢ}
Aggregation weight:   tᵢ = H(pkᵢ, {pk₁, …, pkₙ})
Aggregate signature:  σ  = Π σᵢ^{tᵢ}
Aggregate pubkey:     PK = Σ tᵢ · pkᵢ
Verification:         e(σ, G₂) == e(H(m), PK)   [one pairing product check]
```

**Ethereum's deployment choices:**

| Component | Mechanism |
|-----------|-----------|
| Curve | BLS12-381 — 128-bit security; 381-bit base field; G₁ over F_p, G₂ over F_{p²} |
| Signing key | G₁ (48-byte compressed point); verification key in G₂ (96 bytes) |
| Signature | G₁ point — 48 bytes |
| Hash-to-curve | BLS12-381 G₁ hash (IETF RFC 9380 / `draft-irtf-cfrg-hash-to-curve`) |
| Rogue-key defense | Proof of possession (PoP) registered at validator deposit time; simpler than BDN weighting in the PoS setting |
| Aggregation | Bitfield tracks which validators signed; aggregate = sum of all individual G₁ sigs with same message |

**Why G₁ for sigs, G₂ for keys (not vice versa):** Signatures are aggregated (many → one 48-byte value); verification keys sit in G₂ (96 bytes) but are cached. This minimises the per-attestation wire cost, at the expense of larger per-validator pubkey storage.

**Sync committee (Altair, 2021):** A rotating committee of 512 validators produces an aggregate BLS signature on each beacon block header. Light clients (Helios, mobile wallets) need only the 512-key committee pubkey and one 48-byte aggregate sig to trustlessly verify any block — no downloading of the full validator set.

**Performance:**

| Operation | Time (BLS12-381, software) |
|-----------|---------------------------|
| Single sign | ~1 ms |
| Single verify | ~3 ms (2 pairings) |
| Aggregate N signatures | O(N) G₁ additions |
| Verify aggregate (N signers, 1 msg) | ~3 ms (same 2 pairings) |
| Batch verify M aggregates | ~3 + 0.5M ms (Miller-loop batching) |

**State of the art:** BLS12-381 aggregate signatures are live on Ethereum mainnet (since Altair, October 2021); ~500,000 validators produce ~450,000 attestations per epoch. BDN paper [[1]](https://eprint.iacr.org/2018/483); BLS12-381 spec [[2]](https://hackmd.io/@benjaminion/bls12-381). See [Aggregate Signatures (BLS)](categories/08-signatures-advanced.md#aggregate-signatures-bls-aggregate), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality).

**Production readiness:** Production
Live on Ethereum mainnet since Altair (October 2021); ~500,000 validators producing aggregate signatures every epoch

**Implementations:**
- [supranational/blst](https://github.com/supranational/blst) ⭐ 554 — C/Assembly, high-performance BLS12-381 library used by most Ethereum clients
- [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) ⭐ 3.7k — Go, Ethereum consensus client with BLS aggregation
- [herumi/bls](https://github.com/herumi/bls) ⭐ 319 — C++, BLS signature library
- [sigp/lighthouse](https://github.com/sigp/lighthouse) ⭐ 3.4k — Rust, Ethereum consensus client with BLS aggregation

**Security status:** Secure
BDN scheme is provably secure against rogue-key attacks under co-CDH on BLS12-381; Ethereum uses proof-of-possession at validator deposit; 128-bit security level

**Community acceptance:** Standard
BLS12-381 is the standard pairing curve (IETF RFC 9380 hash-to-curve); BDN published at CRYPTO 2018; used by Ethereum, Zcash, Filecoin, and many SNARK systems

---

## Helios — SNARK-Based Ethereum Light Client

**Goal:** Allow any browser, mobile device, or off-chain application to verify the current Ethereum state with full cryptographic soundness — trusting only the Ethereum genesis hash — by verifying just the Beacon chain sync-committee BLS aggregate signature, and optionally wrapping that verification in a SNARK for even cheaper on-chain use.

**Problem with naive light clients:** Downloading and verifying all ~500,000 validator attestations per epoch (~64 MB) is impractical for a phone or browser. Ethereum's Altair sync committee provides a shortcut: 512 validators rotate every ~27 hours; light clients track only this committee.

**Helios protocol (a16z, 2022):**

```
1. Bootstrap: fetch a trusted checkpoint (finalized block hash from an RPC or a trusted source)
2. Sync committee update: fetch the 512-member committee pubkeys (signed by the previous committee → chain of trust)
3. Per-block verification:
   a. Fetch beacon block header
   b. Fetch sync committee aggregate BLS signature (48 bytes) + participation bitfield
   c. Verify: e(σ_agg, G₂) == e(H(header), PK_agg)   [BLS12-381 pairing check]
   d. Check ≥ 2/3 of committee signed (participation threshold)
4. Execution payload: verify Merkle proof of execution block root against beacon state root
5. State proofs: verify account/storage Merkle-Patricia proof against execution state root
```

**SNARK wrapper — SP1-Helios / Telepathy:**

Wrapping the sync-committee BLS verification in a SNARK converts Helios's output into an on-chain-verifiable proof. This enables Ethereum state proofs on other chains without running a full BLS verifier on-chain:

| System | Proof backend | Use case |
|--------|--------------|---------|
| **Telepathy** (Succinct, 2022) | Gnark PLONK | On-chain Ethereum state proofs on other L1s |
| **SP1-Helios** (Succinct, 2024) | SP1 (RISC-V zkVM) | SNARK-proven Ethereum headers; bridging |
| **Noir-Helios** (Aztec ecosystem) | UltraPlonk | Ethereum proofs inside Noir circuits |

**Security model:** Trust reduces to (a) Ethereum genesis, (b) the sync committee assumption (≥ 2/3 of the 512-member committee is honest). This is weaker than full consensus but sufficient for many cross-chain applications.

**State of the art:** Helios (Rust, open source) is in production use for Ethereum RPC verification. Telepathy deployed on several EVM chains (2023). SP1-Helios (2024) wraps Helios in a RISC-V zkVM proof. Helios repo [[1]](https://github.com/a16z/helios); Telepathy paper [[2]](https://telepathy.gitbook.io/telepathy/). See [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [zkBridge](#zkbridge--cross-chain-state-proofs), [Ethereum BLS Aggregate Signatures](#ethereum-bls-aggregate-signatures-bdn--bls12-381).

**Production readiness:** Production
Helios (Rust) in production for Ethereum RPC verification; Telepathy deployed on EVM chains (2023); SP1-Helios (2024)

**Implementations:**
- [a16z/helios](https://github.com/a16z/helios) ⭐ 2.1k — Rust, trustless Ethereum light client
- [succinctlabs/telepathy-contracts](https://github.com/succinctlabs/telepathy-contracts) ⭐ 80 — Solidity, on-chain SNARK-verified Ethereum state proofs
- [succinctlabs/sp1-helios](https://github.com/succinctlabs/sp1-helios) ⭐ 81 — Rust, RISC-V zkVM wrapped Helios

**Security status:** Caution
Trust reduces to sync committee assumption (>= 2/3 of 512-member committee honest); weaker than full consensus but sufficient for most cross-chain applications

**Community acceptance:** Emerging
a16z open-source project with strong community adoption; Telepathy used for bridging; growing usage as Ethereum state verification standard

---

## zkBridge — Cross-Chain State Proofs

**Goal:** Enable trust-minimized bridging between blockchains by proving the consensus state of a source chain inside a succinct proof (SNARK/STARK) that can be verified cheaply on the destination chain — eliminating the multisig/oracle trust assumptions of existing bridges (Ronin, Wormhole, etc., which collectively lost >$2B to exploits).

**Architecture:**

```
Source chain (e.g. Ethereum)
  │ Block header + BLS aggregate signature
  ▼
Prover network
  │ Generates SNARK proof: "the sync-committee signed this header"
  ▼
Destination chain (e.g. BNB Chain, Gnosis, Solana)
  │ On-chain SNARK verifier checks proof (~200K gas)
  │ Updates stored Ethereum state root
  ▼
Application layer
  │ Verifies Merkle/Verkle proof of specific state item against stored root
  ▼
Cross-chain action (token transfer, message delivery, state read)
```

**Representative zkBridge systems:**

| System | Proof backend | Source → Dest | Note |
|--------|--------------|--------------|------|
| **zkBridge (Berkeley, 2022)** | Gnark (PLONK) | Ethereum → BNB | First formal zkBridge paper; recursive SNARK for BLS [[1]](https://arxiv.org/abs/2210.00264) |
| **Succinct Telepathy** | Gnark PLONK | Ethereum → EVM chains | Deployed on mainnet (2023); syncs Ethereum headers [[2]](https://github.com/succinctlabs/telepathy-contracts) |
| **Polymer** | IBC + ZK proofs | Ethereum ↔ Cosmos | IBC transport over Ethereum using ZK light clients |
| **Electron** | SP1 (RISC-V zkVM) | Ethereum → multi-chain | RISC-V execution proof of Ethereum light client logic |
| **Union** | CometBLS + Gnark | Cosmos → Ethereum | BLS-based Tendermint light client in a SNARK |

**Key cryptographic challenge — BLS12-381 in a SNARK circuit:**

BLS12-381 pairing arithmetic is expensive inside most SNARK arithmetizations because field elements are 381 bits while SNARK-native fields are ~254 bits. Solutions include:

| Technique | Idea |
|-----------|------|
| Non-native field arithmetic | Simulate BLS12-381 field ops using limb decomposition inside the SNARK field |
| Gnark/Halo2 BLS gadgets | Optimized in-circuit BLS12-381 pairing: ~2M constraints |
| Recursion over BLS12-377 | BLS12-377 embeds inside BW6-761 field; enables native pairing in outer circuit |
| STARK wrapper | Prove BLS verification inside a STARK (no field-mismatch issue); larger proof size |

**Security model:** Trust is reduced to (a) the source chain's consensus assumption and (b) the soundness of the SNARK proof system. No multisig, no oracle, no committee with a treasury to bribe.

**State of the art:** Succinct Telepathy (2023) is the first production zkBridge on Ethereum mainnet. zkBridge paper (Xie et al., 2022) [[1]](https://arxiv.org/abs/2210.00264). See [Helios Light Client](#helios--snark-based-ethereum-light-client), [IBC](#ibc--inter-blockchain-communication-protocol), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview).

**Production readiness:** Experimental
Succinct Telepathy deployed on mainnet (2023); other systems (Polymer, Union) in early production or testnet

**Implementations:**
- [succinctlabs/telepathy-contracts](https://github.com/succinctlabs/telepathy-contracts) ⭐ 80 — Solidity, zkBridge contracts for Ethereum state proofs
- [polymerdevs/monomer](https://github.com/polymerdao/monomer) ⭐ 30 — Go, IBC + ZK proofs for Ethereum-Cosmos bridging
- [unionlabs/union](https://github.com/unionlabs/union) ⭐ 74k — Rust, CometBLS + SNARK bridge for Cosmos-Ethereum

**Security status:** Secure
Trust reduced to SNARK soundness + source chain consensus; no multisig, no oracle, no bribable committee; strongest bridge trust model

**Community acceptance:** Emerging
zkBridge paper (Berkeley, 2022) peer-reviewed; endorsed by Ethereum researchers as the gold standard for bridge security; growing adoption but lower TVL than legacy bridges

---

## Monero RingCT — Ring Signatures + Confidential Transactions

**Goal:** Provide sender anonymity (via linkable ring signatures), recipient anonymity (via stealth addresses), and amount confidentiality (via Pedersen commitments + range proofs) — simultaneously — so that Monero transactions reveal no identifying information by default.

**Three privacy layers combined:**

```
Sender anonymity:     MLSAG / CLSAG ring signature hides true signer among n decoys
Recipient anonymity:  One-time stealth address derived from recipient's public key
Amount hiding:        Pedersen commitment to amount + Bulletproofs range proof
```

**Layer 1 — Stealth addresses:**

Recipient publishes spend key `(A, B)`. For each output, the sender:
1. Samples random `r`
2. Computes one-time address `P = H(r·A) · G + B`
3. Includes `r·G` in the transaction

The recipient scans all transactions, computing `H(a · r·G) · G + B` for their spend key `a`; if this matches `P`, the output is theirs. No address reuse; outputs are unlinkable across transactions.

**Layer 2 — MLSAG / CLSAG ring signatures:**

The sender signs the transaction using a ring of n public keys (the true input + n-1 decoys drawn from the blockchain). The linkability tag (key image) `I = x · H_p(P)` is unique per private key — if the same key signs twice, the image repeats, enabling double-spend detection without identifying the signer.

| Scheme | Year | Ring size | Proof size | Note |
|--------|------|-----------|-----------|------|
| **MLSAG** (Multilayered Linkable Spontaneous Anonymous Group) | 2016 | 11 | O(n) per input | Original RingCT scheme |
| **CLSAG** (Compact Linkable Spontaneous Anonymous Group) | 2019 | 11 | ~26% smaller | Single-layer ring; deployed in Monero 2020 [[1]](https://eprint.iacr.org/2019/654) |

**Layer 3 — Pedersen commitments + Bulletproofs:**

Each output amount `v` is committed as `C = v·H + r·G` (Pedersen, homomorphic). Transaction validity requires `Σ C_in = Σ C_out + fee·H`. Bulletproofs range proofs prove each output is in `[0, 2^64)` without revealing `v`. Bulletproofs (2018) replaced the earlier Borromean ring range proofs, reducing transaction size by ~80%.

**Cryptographic primitives:**

| Primitive | Role |
|-----------|------|
| Ed25519 / Curve25519 | Key generation, ECDH for stealth addresses |
| CLSAG ring signature | Sender anonymity; double-spend prevention via key images |
| Pedersen commitments (Curve25519) | Amount hiding with homomorphic validity check |
| Bulletproofs (no trusted setup) | Range proofs for committed amounts |
| `H_p` (hash-to-curve) | Maps output pubkey to curve point for key image computation |

**RingCT since 2017:** All Monero transactions use RingCT by default. Default ring size increased: 4 (2017) → 7 (2018) → 11 (2019) → 16 (2022). Seraphis/Jamtis (proposed upgrade, 2023) will replace CLSAG with a more flexible membership proof scheme.

**State of the art:** CLSAG + Bulletproofs deployed on Monero mainnet (October 2020). CLSAG paper (Goodell et al.) [[1]](https://eprint.iacr.org/2019/654); original RingCT (Shen Noether, 2015) [[2]](https://eprint.iacr.org/2015/1098). See [Confidential Transactions](#confidential-transactions-ct), [Range Proofs](#range-proofs), [Ring Signatures](categories/08-signatures-advanced.md#ring-signatures).

**Production readiness:** Production
Default for all Monero transactions since 2017; CLSAG deployed October 2020; ring size 16 since 2022

**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, full Monero node with CLSAG + Bulletproofs

**Security status:** Caution
CLSAG ring signatures hide sender among 16 decoys; anonymity set limited by ring size; statistical analysis and heuristics can reduce effective anonymity; Bulletproofs range proofs are secure

**Community acceptance:** Widely trusted
Monero is the most widely used privacy cryptocurrency; CLSAG and RingCT have been reviewed by multiple independent researchers; strong community trust

---

## Halo2 — Recursive SNARKs Without Trusted Setup (Zcash Orchard)

**Goal:** Provide a practical recursive SNARK system that eliminates the need for a per-circuit trusted setup while maintaining small proof sizes, using a polynomial IOP (PLONK-based) with an inner product argument over a cycle of curves — deployed in Zcash's Orchard protocol as a replacement for the trusted Groth16 setup of Sapling.

**Why a new system after Groth16?** Groth16 (Sapling, 2018) required a circuit-specific trusted setup MPC for each circuit change. Adding new features to Zcash required new ceremonies. Halo2 replaces the structured reference string with a transparent, trustless commitment scheme based on inner product arguments (IPA), and supports efficient recursion natively.

**Halo2 components:**

| Component | Mechanism |
|-----------|-----------|
| Polynomial commitment | IPA (Inner Product Argument) over the Pallas curve — no trusted setup, no pairings |
| Constraint system | PLONK with custom gates ("UltraPlonk" / PLONKish arithmetization) |
| Lookup arguments | Plookup / halo2 lookup — efficient table lookups inside circuits |
| Recursion | Accumulation scheme: proofs are "accumulated" rather than verified in-circuit; deferred verification |

**Accumulation-based recursion (Bowe-Grigg-Hopwood, 2019 / Halo):**

Classical recursive SNARKs verify one proof inside another circuit. Halo instead uses an *accumulator*: each proof step produces an "accumulator" that lazily defers all IPA verification checks. The final accumulated value is verified once at the end of the chain. This avoids the expensive in-circuit IPA verification.

```
Step 1: generate proof π₁, accumulator acc₁
Step 2: generate proof π₂ proving "acc₁ is well-formed", output acc₂
  ⋮
Step n: generate πₙ, output accₙ
Verifier: check accₙ directly (one IPA check) → all prior steps verified transitively
```

**Zcash Orchard (2022):**

Orchard replaces Sapling's Spend/Output circuits (Groth16 over BLS12-381) with Halo2 circuits over the Pallas curve:

| Property | Sapling (Groth16) | Orchard (Halo2) |
|----------|-------------------|-----------------|
| Trusted setup | Circuit-specific MPC ceremony | None |
| Proof size | ~192 bytes (3 G₁ points) | ~4 KB |
| Verify time | ~3 ms (3 pairings) | ~10 ms |
| Recursion | Not native | Native (accumulation) |
| Curve | BLS12-381 | Pallas (Pasta cycle) |

**PLONKish arithmetization in halo2:** Halo2's constraint system uses a rectangular table of columns (advice, fixed, instance) and gates defined as multivariate polynomials over adjacent rows. Custom gates (e.g., a Poseidon gate) can constrain many operations in a single row, dramatically reducing circuit size compared to R1CS.

**Ecosystem adoption:** Halo2 is used not only in Zcash Orchard but also in the Ethereum ecosystem: Scroll, Polygon zkEVM, and Axiom all use halo2 (with KZG commitments instead of IPA) for their zkEVM circuits; PSE (Privacy & Scaling Explorations) maintains `halo2` as an open library.

**State of the art:** Halo2 deployed in Zcash Orchard (NU5 upgrade, May 2022). Original Halo paper (Bowe-Grigg-Hopwood, 2019) [[1]](https://eprint.iacr.org/2019/1021); halo2 book [[2]](https://zcash.github.io/halo2/). See [Groth16 / Zcash Sapling zk-SNARK](#groth16--zcash-sapling-zk-snark), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [Mina Protocol](#mina-protocol--pickles-recursive-snark-22-kb-blockchain).

**Production readiness:** Production
Deployed in Zcash Orchard (NU5, May 2022); halo2 library used by Scroll, Polygon zkEVM, and Axiom

**Implementations:**
- [zcash/halo2](https://github.com/zcash/halo2) ⭐ 895 — Rust, Zcash's halo2 proof system (IPA backend)
- [privacy-scaling-explorations/halo2](https://github.com/privacy-scaling-explorations/halo2) ⭐ 244 — Rust, PSE fork with KZG backend for Ethereum zkEVMs
- [scroll-tech/halo2](https://github.com/scroll-tech/halo2) ⭐ 46 — Rust, Scroll's halo2 fork for zkEVM circuits
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Zcash Orchard shielded pool using halo2

**Security status:** Secure
IPA commitment scheme requires no trusted setup; accumulation-based recursion is formally analysed; PLONKish arithmetization is well-studied; Zcash Orchard has been audited

**Community acceptance:** Widely trusted
Original Halo paper (2019) is highly cited; halo2 library is the most widely used ZK circuit framework in the Ethereum ecosystem; deployed in Zcash, Scroll, and Polygon zkEVM

---

## Ethereum PBS — Proposer-Builder Separation and MEV

**Goal:** Decouple the roles of block *builder* (who selects and orders transactions to extract MEV) from block *proposer* (a staking validator who simply signs the most profitable header offered to them), so that validators do not need sophisticated MEV extraction software and the network avoids centralisation pressure from MEV economies of scale.

**MEV background:** Miners/validators who control transaction ordering can profit by inserting, reordering, or censoring transactions — sandwich attacks on AMM trades, liquidation front-running, arbitrage. This Maximal Extractable Value (MEV) historically flowed entirely to miners, and creates centralising incentives as larger operators can afford better order-flow pipelines.

**PBS architecture (Ethereum PoS):**

```
Builders (specialised firms)
  │ Assemble full blocks; bid a fee to the proposer
  ▼
MEV-Boost relay (trusted intermediary, e.g. Flashbots, BloXroute)
  │ Receives sealed blocks + bids; reveals winning block header only after proposer commits
  ▼
Proposer (validator)
  │ Signs the highest-bid header blind (does not see transaction contents until committed)
  │ Cannot substitute own transactions after seeing the header
  ▼
Ethereum Beacon chain finalises the block
```

**Cryptographic commitment mechanism:** The relay reveals the full block body to the proposer only after the proposer has signed and published the *blinded* header. This prevents the proposer from stealing MEV after learning the transaction order. The blinded-header scheme requires the proposer to trust the relay not to equivocate — a limitation that in-protocol PBS (ePBS, EIP-7732) will fix via an on-chain commitment.

**ePBS — enshrined PBS (EIP-7732):**

| Property | MEV-Boost (current) | ePBS (EIP-7732, proposed) |
|----------|--------------------|-----------------------------|
| Relay trust | Trusted intermediary | Eliminated — protocol enforces commitment |
| Builder payment | Off-chain (relay settles) | On-chain in the Beacon chain |
| Equivocation protection | None (relay is centralised) | Slashable on-chain if builder equivocates |
| Inclusion lists | Not enforced | Proposer can mandate a set of txs builders must include |

**Inclusion lists (EIP-7547):** Proposers can publish a list of transactions that the chosen builder *must* include, restoring censorship resistance — builders who omit listed transactions have their block rejected.

**State of the art:** MEV-Boost (Flashbots, 2022) runs on >90% of Ethereum blocks; ePBS (EIP-7732) is under active research and targeted for a future fork. Inclusion lists (EIP-7547) are planned alongside ePBS. See [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering), [Flashbots and SUAVE](#flashbots-and-suave--encrypted-order-flow-and-tee-based-mev), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality).

**Production readiness:** Production
MEV-Boost (Flashbots, 2022) runs on >90% of Ethereum blocks; ePBS (EIP-7732) under research for future fork

**Implementations:**
- [flashbots/mev-boost](https://github.com/flashbots/mev-boost) ⭐ 1.4k — Go, MEV-Boost relay software for Ethereum validators
- [flashbots/mev-boost-relay](https://github.com/flashbots/mev-boost-relay) ⭐ 492 — Go, relay infrastructure for PBS
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, ePBS (EIP-7732) specification

**Security status:** Caution
MEV-Boost requires trusting the relay not to equivocate; ePBS (EIP-7732) will eliminate relay trust via on-chain commitment; inclusion lists restore censorship resistance

**Community acceptance:** Widely trusted
De facto standard for Ethereum block production; Flashbots is the dominant relay; ePBS endorsed by Ethereum researchers for future enshrining

---

## Flashbots and SUAVE — Encrypted Order Flow and TEE-Based MEV

**Goal:** Provide infrastructure that (a) makes MEV extraction transparent and democratised rather than opaque and centralising, and (b) ultimately moves toward a world where transaction order-flow is processed inside a Trusted Execution Environment (TEE) so that neither the builder nor the relay can front-run user transactions.

**Flashbots MEV-Boost (2022):** An out-of-protocol marketplace that lets searchers (bots) submit *bundles* — ordered groups of transactions with a bid — directly to builders, who include them if profitable. Bundles are delivered via a private off-chain channel, bypassing the public mempool. This reduces failed front-running attempts (gas waste) and makes MEV more observable, but does not eliminate it.

**SUAVE — Single Unifying Auction for Value Expression (2023):**

SUAVE is Flashbots' long-term architecture: a decentralised block-building chain where transaction preferences (bids, order-flow bundles, intents) are processed inside Intel SGX / TDX TEEs. The TEE acts as a confidential compute environment:

```
User submits encrypted transaction preference to SUAVE network
  │ Encrypted under SUAVE TEE's public key
  ▼
SUAVE node (running inside SGX/TDX enclave)
  │ Decrypts, evaluates, matches preferences without leaking to operators
  │ Produces an optimal block-building plan
  ▼
Block submitted to target chain (Ethereum, Polygon, …)
  │ TEE attestation proves the build was computed correctly
```

| Component | Mechanism | Property |
|-----------|-----------|---------|
| Confidential compute | Intel SGX / TDX TEE | Operator cannot read plaintext preferences |
| Remote attestation | DCAP attestation quote | Verifiable proof that correct SUAVE code ran inside TEE |
| SUAVE chain | EVM-based preference settlement chain | Decentralised coordination of builders |
| Confidential data records | Encrypted key-value store in SUAVE runtime | Preferences persist encrypted; auditable via attestation |

**Kettle:** SUAVE's TEE execution environment for running "SUAPPs" (SUAVE applications). A Kettle node produces an attestation quote that any client can verify to confirm the correct SUAVE binary is running — no trust in the operator required.

**Comparison with threshold encryption mempools:**

| Approach | Trust model | Latency | Deployed |
|----------|-------------|---------|---------|
| Threshold encryption (Shutter) | Threshold committee | Adds key-generation round | Testnet / early mainnet |
| TEE (SUAVE) | TEE manufacturer (Intel) + attestation | Near-zero overhead | Devnet / early 2025 |
| Commit-reveal | No additional trust | Adds one block delay | Widely used (simple protocols) |

**State of the art:** SUAVE devnet launched 2024; Rigil testnet (2024) is the first public SUAVE deployment. MEV-Boost (non-TEE) remains the dominant production system. SUAVE paper [[1]](https://writings.flashbots.net/the-future-of-mev-is-suave); TEE attestation background in [TEE Remote Attestation](categories/14-applied-infrastructure-pki.md#tee-remote-attestation). See [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering), [Ethereum PBS](#ethereum-pbs--proposer-builder-separation-and-mev).

**Production readiness:** Experimental
MEV-Boost in production; SUAVE Rigil testnet launched 2024; TEE-based block building in early devnet stage

**Implementations:**
- [flashbots/mev-boost](https://github.com/flashbots/mev-boost) ⭐ 1.4k — Go, production MEV marketplace
- [flashbots/suave-geth](https://github.com/flashbots/suave-geth) ⭐ 201 — Go, SUAVE execution node (modified geth)
- [flashbots/suapp-examples](https://github.com/flashbots/suapp-examples) ⭐ 57 — Solidity, example SUAVE applications

**Security status:** Caution
SUAVE relies on Intel SGX/TDX TEE; TEE side-channel vulnerabilities (Spectre, Foreshadow) are a known risk; remote attestation verifies code integrity but not hardware invulnerability

**Community acceptance:** Emerging
Flashbots is the dominant MEV infrastructure provider; SUAVE represents the next generation but TEE-based trust model is debated among cryptographers

---

## Ethereum DVT — Distributed Validator Technology

**Goal:** Allow a single Ethereum validator key to be operated by a *cluster* of nodes using threshold cryptography — so that no single machine holds the full BLS private key, validator duties continue even if some nodes in the cluster go offline, and solo stakers can achieve high availability without trusting a centralised staking service.

**Problem:** Ethereum's proof-of-stake requires each validator to remain continuously online (to attest every epoch) or face inactivity penalties. Running a single server creates a single point of failure; commercial liquid staking operators (Lido, Rocket Pool) centralise key custody. DVT allows validator keys to be split across multiple independent operators.

**Threshold BLS signing for validator duties:**

A validator key `sk` is split into `n` shares `sk_1, …, sk_n` using a `(t, n)` threshold secret sharing scheme (Shamir-based DKG). Each node holds one share and produces a *partial BLS signature* when it is time to attest or propose. A combiner aggregates `t` partial signatures into a full BLS signature that is identical to what a single-key validator would produce — the Beacon chain cannot distinguish DVT validators from normal ones.

| Component | Mechanism |
|-----------|-----------|
| Key generation | Distributed Key Generation (DKG) — no dealer ever holds full key |
| Partial signing | Each DVT node signs with its BLS share |
| Signature combination | Lagrange interpolation over BLS12-381 G₁ → full BLS sig |
| Consensus within cluster | BFT or leader-based protocol to agree on what to sign before any node signs |
| Slashing protection | Distributed slashing database — cluster refuses to sign equivocating messages |

**Production DVT systems:**

| Project | DKG scheme | Cluster consensus | Notes |
|---------|-----------|-------------------|-------|
| **Obol Network** | Charon DVT client; threshold BLS via `dkg.obol.tech` | Multi-round simple consensus | Open-source; multiple operators per validator |
| **SSV Network** | `ssv-dkg` tool; Shamir secret sharing | Istanbul BFT (iBFT) | On-chain fee market; decentralised operator registry |
| **Diva Staking** | DVT-native liquid staking; keyshares from deposit | Custom | Liquid staking built natively on DVT |

**EIP-7441 — Whisk interaction:** EIP-7441 proposes a shuffled secret leader election (Whisk) for Ethereum that hides the next block proposer's identity until proposal time, complicating coordinated attacks on DVT clusters. DVT integration with Ethereum's validator duties is being standardised across the ecosystem.

**State of the art:** Obol and SSV both have validators on Ethereum mainnet (2024); tens of thousands of ETH secured via DVT. SSV whitepaper [[1]](https://ssv.network/tech-paper/); Obol documentation [[2]](https://docs.obol.org/). See [Threshold Signatures](categories/08-signatures-advanced.md#threshold-signature-schemes-tss), [Distributed Key Generation](categories/05-secret-sharing-threshold-cryptography.md#distributed-key-generation-dkg), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality).

**Production readiness:** Production
Obol and SSV have validators on Ethereum mainnet (2024); tens of thousands of ETH secured via DVT

**Implementations:**
- [ObolNetwork/charon](https://github.com/ObolNetwork/charon) ⭐ 219 — Go, Obol DVT middleware client
- [ssvlabs/ssv](https://github.com/ssvlabs/ssv) ⭐ 216 — Go, SSV Network DVT protocol
- [ssvlabs/ssv-dkg](https://github.com/ssvlabs/ssv-dkg) ⭐ 18 — Go, SSV distributed key generation tool

**Security status:** Secure
Threshold BLS signing ensures no single node holds the full key; DKG eliminates dealer trust; distributed slashing protection prevents equivocation; Beacon chain cannot distinguish DVT from normal validators

**Community acceptance:** Emerging
Endorsed by Ethereum Foundation as critical infrastructure for decentralisation; growing adoption by staking providers; Obol and SSV are leading standards

---

## RANDAO and VDF — Unbiasable Randomness Beacon for Ethereum

**Goal:** Provide a public, unbiasable source of randomness for Ethereum consensus — used to assign validators to committees, elect block proposers, and seed randomness-dependent protocols — by combining RANDAO (XOR-based commit-reveal across all validators) with a Verifiable Delay Function (VDF) that prevents last-revealer bias.

**RANDAO — baseline randomness accumulation:**

At each epoch, every validator contributes a randomness reveal: a BLS signature over the current epoch number (deterministic under their key). The epoch randomness is the XOR of all reveals. Because reveals are BLS signatures, they are deterministic per key — validators cannot choose a different reveal, only choose to withhold it.

```
randao_mix(epoch) = XOR of BLS_sign(sk_i, epoch) for all i that reveal
```

**Last-revealer bias attack:** The last validator to reveal can observe the running XOR and compute whether revealing or withholding produces a more favourable outcome (e.g., self-selecting as the next block proposer). With ~500,000 validators, this manipulation is small but non-zero.

**VDF as a bias-prevention layer:**

A Verifiable Delay Function `(y, π) = VDF.Eval(x, T)` takes the RANDAO output `x` as input and produces `y` after `T` sequential steps — too slow to be computed before the reveal window closes, but fast to verify given `π`.

```
RANDAO output (current epoch)
  │
  └─ VDF.Eval(T steps, ~100 seconds delay)
       │
       ├─ VDF output y  (unbiasable randomness)
       │
       └─ Proof π: VDF.Verify(x, y, π) = 1  (succinct; O(log T))
```

Because the VDF takes longer than the reveal window, the last revealer cannot compute the final randomness before deciding to reveal — eliminating the bias.

| Component | Mechanism | Note |
|-----------|-----------|------|
| RANDAO | BLS signatures XOR-accumulated | Deployed in Ethereum PoS today |
| VDF candidate | MinRoot VDF (Ethereum research, 2022) | Replaces earlier class-group VDF proposals |
| VDF hardware | Dedicated ASIC (~100 steps/s) | Needed to evaluate VDF faster than adversary's hardware |
| VDF proof | Wesolowski or Pietrzak succinct proof | O(log T) or O(√T) verification |

**MinRoot VDF (2022):** Ethereum's current preferred VDF construction iterates `(x, y) ↦ (y, (x + y)^{1/5})` over a large prime field — the inverse fifth-power is the sequential bottleneck. Faster than class-group VDFs on hardware [[1]](https://eprint.iacr.org/2022/1626).

**Current deployment:** Ethereum PoS uses RANDAO alone (VDF not yet live); VDF integration awaits ASIC hardware development and protocol specification. RANDAO spec [[2]](https://eth2book.info/capella/part2/building_blocks/randomness/). See [Verifiable Delay Functions](categories/09-commitments-verifiability.md#verifiable-delay-functions-vdf), [Secret Leader Election](#secret-leader-election), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality).

**Production readiness:** Experimental
RANDAO is live on Ethereum PoS; VDF integration awaits ASIC hardware development and protocol specification

**Implementations:**
- [ethereum/consensus-specs](https://github.com/ethereum/consensus-specs) ⭐ 3.9k — Python, RANDAO specification in Ethereum PoS
- [ethereum/research](https://github.com/ethereum/research) ⭐ 1.9k — Python, VDF research and MinRoot specification
- [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) ⭐ 3.7k — Go, RANDAO implementation in Prysm consensus client

**Security status:** Caution
RANDAO alone has last-revealer bias (small but non-zero); VDF eliminates bias but requires dedicated ASIC hardware; MinRoot VDF security under active analysis

**Community acceptance:** Emerging
RANDAO is deployed as Ethereum's randomness source; VDF integration is endorsed by Ethereum Foundation but awaits hardware readiness; MinRoot proposed as the preferred VDF construction

---

## Incremental Verifiable Computation (IVC) for Blockchain

**Goal:** Prove the correctness of an *incremental* computation — one that adds one step at a time — using a proof that remains constant-size regardless of the number of steps, enabling blockchain nodes to verify the entire chain history or a long-running program execution with a single succinct proof.

**Formal definition:** An IVC scheme for a function `F` produces, for a sequence of steps `z_0 → z_1 → … → z_n`, a proof `π_n` certifying: "starting from `z_0`, applying `F` exactly `n` times yields `z_n`." Proof size and verification time are `O(1)` in `n`.

**Why IVC matters for blockchains:**

| Application | IVC role |
|-------------|---------|
| Mina Protocol (22 KB blockchain) | IVC over the block transition function; full chain proof in ~22 KB |
| zkEVM execution proofs | IVC over EVM step function; prove N instructions without prover memory growing with N |
| zkVM (SP1, RISC Zero) | IVC over RISC-V instruction execution; prove arbitrary programs |
| Proof aggregation | Aggregate N independent batch proofs into one final proof |
| Rollup state compression | IVC accumulates all state transitions; L1 sees only final proof |

**Key constructions:**

| Scheme | Year | Recursion technique | Proof system | Trusted setup |
|--------|------|--------------------|--------------|----|
| **Halo (Bowe-Grigg-Hopwood)** | 2019 | Accumulation over Pasta cycle | IPA (no pairings) | None |
| **Nova (Kothapalli-Setty-Tzialla)** | 2021 | Folding scheme for R1CS | Pedersen commitments | None [[1]](https://eprint.iacr.org/2021/370) |
| **SuperNova** | 2022 | Non-uniform IVC via folding | R1CS per step function | None [[2]](https://eprint.iacr.org/2022/1758) |
| **HyperNova** | 2023 | CCS (generalised R1CS) folding | HyperKZG | None [[3]](https://eprint.iacr.org/2023/573) |
| **Sangria** | 2023 | Folding for PLONK | KZG | KZG setup |
| **ProtoStar** | 2023 | Special-sound IVC for PLONK | IPA/KZG | Optional |

**Nova folding scheme (key insight):** Rather than verifying one proof inside another circuit (expensive), Nova *folds* two R1CS instances into one *relaxed* R1CS instance using a random linear combination. The fold is cheap (linear in circuit size); only the final accumulated instance needs to be proven with a full SNARK. This makes recursive proving ~10–100× faster than classical in-circuit verification.

**Relationship to folding schemes and PCD:** IVC generalises to Proof-Carrying Data (PCD) — where each computation step carries a proof verified by the next step, enabling distributed/parallel incremental proving. See [Folding Schemes and PCD](categories/04-zero-knowledge-proof-systems.md#folding-schemes-and-proof-carrying-data-pcd).

**State of the art:** Nova and HyperNova are the leading theoretical constructions (2023–2024); both are integrated into production zkVMs (SP1, RISC Zero). Mina's Pickles is the most prominent production IVC system. Survey [[4]](https://eprint.iacr.org/2023/620). See [Mina Protocol](#mina-protocol--pickles-recursive-snark-22-kb-blockchain), [Halo2](#halo2--recursive-snarks-without-trusted-setup-zcash-orchard), [ZK Rollups](#zk-rollups-and-optimistic-rollups), [Folding Schemes](categories/04-zero-knowledge-proof-systems.md#folding-schemes-and-proof-carrying-data-pcd).

**Production readiness:** Experimental
Mina's Pickles is the most prominent production IVC; Nova and HyperNova integrated into zkVM prototypes (SP1, RISC Zero)

**Implementations:**
- [microsoft/Nova](https://github.com/microsoft/Nova) ⭐ 837 — Rust, Nova folding scheme by Microsoft Research
- [lurk-lab/lurk-rs](https://github.com/lurk-lab/lurk-rs) ⭐ 450 — Rust, Lurk language with Nova-based IVC
- [nexus-xyz/nexus-zkvm](https://github.com/nexus-xyz/nexus-zkvm) ⭐ 2.6k — Rust, Nexus zkVM using Nova/HyperNova folding
- [o1-labs/mina](https://github.com/mina-deploy/mina) ⭐ 4.4k — OCaml, Mina Protocol with Pickles IVC

**Security status:** Secure
Folding schemes (Nova, HyperNova) have formal security proofs under standard assumptions; accumulation-based recursion avoids in-circuit verification overhead

**Community acceptance:** Emerging
Nova published by Microsoft Research (2021); HyperNova (2023) and ProtoStar (2023) published at top venues; rapidly growing integration into production zkVMs

---

## Tornado Cash — zkSNARK Privacy Mixer

**Goal:** Allow Ethereum users to deposit ETH (or ERC-20 tokens) into a smart contract and later withdraw the same amount to a fresh address, breaking the on-chain link between depositor and withdrawer — using a Groth16 zkSNARK to prove membership in the deposit set without revealing which deposit is being withdrawn.

**Construction (Pertsev et al., 2019):**

Tornado Cash maintains an on-chain Merkle tree of deposit commitments. Every deposit inserts a commitment `C = Pedersen(nullifier || secret)` as a leaf. Withdrawal requires a zero-knowledge proof that the withdrawer knows a `(nullifier, secret)` pair whose commitment is in the tree, without revealing which leaf.

```
Deposit:
  1. User generates random (nullifier, secret) off-chain
  2. Computes commitment C = Pedersen(nullifier || secret)
  3. Sends ETH + C to smart contract; C inserted as Merkle leaf

Withdraw (to fresh address):
  1. User computes nullifierHash = Pedersen(nullifier)
  2. Generates Groth16 proof π: "I know (nullifier, secret) s.t.
     - C = Pedersen(nullifier || secret) is a leaf in Merkle tree with root R
     - nullifierHash = Pedersen(nullifier)"
  3. Submits (π, nullifierHash, recipient, relayer, fee) to contract
  4. Contract verifies π on-chain, checks nullifierHash not spent, pays recipient
```

**Why the nullifier hash:** The smart contract stores all seen `nullifierHash` values. If the same nullifier is used twice, the hash repeats and the withdrawal is rejected — preventing double-spends. The nullifier itself is never revealed, so the deposit remains unlinkable.

**Cryptographic components:**

| Component | Mechanism | Note |
|-----------|-----------|------|
| Commitment scheme | Pedersen hash (MiMC / Poseidon in later versions) | ZK-friendly; inside Groth16 circuit |
| Merkle tree | 20-level binary Merkle tree; leaves = commitments | On-chain root updated per deposit |
| Proof system | Groth16 over BN254 (alt_bn128) | ~200-byte proof; ~21K gas on-chain verify |
| Trusted setup | Ceremony (Powers of Tau + phase 2, 1,114 participants) | Circuit-specific SRS |
| Anonymity set | All unspent deposits of the same denomination | Larger anonymity set = stronger privacy |

**Denominations:** Tornado Cash deploys separate contract instances for fixed amounts (0.1, 1, 10, 100 ETH) — all deposits in one instance are identical in size, preventing amount-based deanonymisation.

**Limitations:** Anonymity set size is bounded by the number of deposits between deposit and withdrawal. Timing and gas-pattern analysis can partially deanonymise users. The relayer (who submits the withdrawal transaction to avoid linking the withdrawing address to a funding source) must be trusted for liveness but not for privacy.

**State of the art:** Tornado Cash v2 deployed on Ethereum mainnet; OFAC sanctioned the contracts (August 2022). Tornado Cash Nova (2021) generalised to arbitrary amounts using shielded transfers (a Zcash-style shielded pool on Ethereum). Source code [[1]](https://github.com/tornadocash/tornado-core); audit [[2]](https://tornado.cash/audits/TornadoCash_audit_ABDK.pdf). See [Groth16 / Zcash Sapling zk-SNARK](#groth16--zcash-sapling-zk-snark), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [Commitment Schemes](categories/09-commitments-verifiability.md#commitment-schemes).

**Production readiness:** Production
Tornado Cash v2 deployed on Ethereum mainnet; OFAC sanctioned (August 2022); contracts remain on-chain and functional

**Implementations:**
- [tornadocash/tornado-core](https://github.com/tornadocash/tornado-core) ⭐ 1.7k — Solidity/JavaScript, core Tornado Cash contracts and circuits
- [tornadocash/tornado-nova](https://github.com/tornadocash/tornado-nova) ⭐ 137 — Solidity, Tornado Nova with arbitrary amounts
- [iden3/circomlib](https://github.com/iden3/circomlib) ⭐ 735 — JavaScript, Circom circuit library used by Tornado Cash

**Security status:** Secure
Groth16 proof system over BN254 is computationally sound; trusted setup had 1,114 participants; anonymity set bounded by deposit pool size; timing analysis can reduce effective privacy

**Community acceptance:** Controversial
OFAC sanctioned (2022); legal status challenged in court (Tornado Cash developer arrested); technically sound but regulatory status is highly contested; influential design pattern for privacy protocols

---

## Zcash Sapling Transaction Structure

**Goal:** Define the cryptographic anatomy of a Zcash shielded transaction — the note format, Spend and Output descriptions, binding signature, and how all components combine to prove that amounts balance and that the spender knows the spending key — without revealing senders, recipients, or amounts.

**Note anatomy:** A Zcash Sapling *note* encodes a shielded payment:

```
Note = (d, pkd, value, rcm)
  d    — diversifier (11 bytes); selects a diversified payment address
  pkd  — recipient's diversified transmission key (32-byte Jubjub point)
  value — 64-bit amount
  rcm  — randomness (32 bytes); used to derive the Pedersen commitment
```

The **note commitment** is `cm = WindowedPedersen(repr(g_d), repr(pkd), value, rcm)` — a Jubjub-curve Pedersen commitment. The Sapling commitment tree is a Merkle tree (depth 32) over all note commitments ever created.

**Transaction components:**

| Description | What it proves | Proof system | Size |
|-------------|---------------|-------------|------|
| **Spend description** | Spender knows `(ask, nk, rcm, value, merkle_path)` for a committed note; note is in the tree; nullifier is derived correctly | Groth16 (Spend circuit, BLS12-381) | ~738 bytes |
| **Output description** | A well-formed note commitment was created for a new output; recipient can decrypt the encrypted note | Groth16 (Output circuit, BLS12-381) | ~948 bytes |
| **Binding signature** | Net value (inputs − outputs − fee) is zero; prevents value creation outside the transparent pool | RedJubjub Schnorr signature over the transaction hash | 64 bytes |

**Spend circuit (high-level):**

```
Public inputs:  root (Merkle tree root), nullifier, cv (value commitment), rk (randomized spend key)
Private inputs: note (d, pkd, value, rcm), ak (authorization key), nk (nullifier key), merkle_path

Circuit proves:
  1. cm = Commit(g_d, pkd, value, rcm) is a leaf in Merkle path to root
  2. nf = PRF_{nk}(ρ)  — nullifier derived from nullifier key and note position ρ
  3. cv = ValueCommit(value, rcv)  — Pedersen commitment to value with blinding rcv
  4. rk = ak + [α]·SpendAuthG  — randomized spend authorization key (prevents key reuse linkage)
```

**Value balance — binding signature trick:**

Each Spend adds `+value` to `cv_net`; each Output adds `−value`. The binding signature key is `bsk = Σ rcv_spends − Σ rcv_outputs`. The verifier checks that the binding signature verifies under the net commitment `cv_net − value_balance·H`. If amounts don't balance, the binding key does not exist — the Pedersen commitment algebra enforces balance without the circuit ever checking the global sum.

**Encryption:** Each Output description includes an encrypted note ciphertext (ChaCha20-Poly1305 under an ECDH key derived from the recipient's transmission key `pkd`), allowing the recipient to scan all outputs and decrypt those addressed to them.

**Key hierarchy (ZIP-32):**

```
Spending key (sk)
  ├─ Ask (spend authorizing key) → rk (randomized in each Spend)
  ├─ Nk  (nullifier key) → nullifiers for spent notes
  └─ Ovk (outgoing viewing key) → decrypt sent notes
Incoming viewing key (ivk) → scan + decrypt received notes without spending
Full viewing key (fvk = (ak, nk, ovk)) → view all activity without spending
```

**Sapling vs. Orchard:** Zcash Orchard (NU5, 2022) replaces Sapling's Groth16/BLS12-381 circuits with Halo2/Pallas circuits and unifies each Spend+Output into a single *action*, eliminating separate proof types. See [Halo2](#halo2--recursive-snarks-without-trusted-setup-zcash-orchard).

**State of the art:** Sapling activated on Zcash mainnet October 2018; remains the most widely used shielded protocol by transaction count. Sapling specification [[1]](https://zips.z.cash/protocol/sapling.pdf); ZIP 32 (HD shielded keys) [[2]](https://zips.z.cash/zip-0032). See [Groth16 / Zcash Sapling zk-SNARK](#groth16--zcash-sapling-zk-snark), [Confidential Transactions](#confidential-transactions-ct), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview).

**Production readiness:** Production
Sapling activated on Zcash mainnet October 2018; remains the most widely used shielded protocol by transaction count

**Implementations:**
- [zcash/librustzcash](https://github.com/zcash/librustzcash) ⭐ 387 — Rust, Zcash Sapling note handling, proofs, and key derivation
- [zcash/zcash](https://github.com/zcash/zcash) ⭐ 5.4k — C++, full Zcash node with Sapling circuit
- [ArkEcosystem/zcash-primitives](https://github.com/ArkEcosystem/mainsail) ⭐ 13 — Rust, Sapling primitives crate for third-party use

**Security status:** Secure
Groth16 proofs over BLS12-381; binding signature (RedJubjub Schnorr) enforces value balance via Pedersen commitment algebra; trusted setup via MPC ceremony with ~200 participants

**Community acceptance:** Widely trusted
Zcash Sapling is the most battle-tested shielded transaction protocol; ZIP specifications are peer-reviewed; adopted as reference design for privacy protocols

---

## Confidential Transactions with Bulletproofs — Liquid Network

**Goal:** Deploy confidential transactions (hidden amounts) with Bulletproofs range proofs on a Bitcoin sidechain, enabling institutional asset settlement where counterparties see transaction validity (no inflation, no negative values) but not the specific amounts — while also hiding the *asset type* in multi-asset transactions via Confidential Assets.

**Liquid Network (Blockstream, 2018):** A federated Bitcoin sidechain with a 15-of-15 functionary federation. Liquid implements Confidential Transactions with two extensions over the base CT design:

**1. Confidential Assets (CA):** Each output commits to both its *value* and its *asset type* (e.g., L-BTC, USDT, tokenised bond). The asset tag commitment prevents cross-asset inflation without revealing which asset is being transferred:

```
Output commitment: C = r·G + value·H_asset
  where H_asset = Hash_to_curve(asset_id)   — asset-specific generator
```

A *surjection proof* proves that the asset generator `H_asset` used in each output matches a generator used in some input of the same asset type, without revealing which asset it is.

**2. Bulletproofs range proofs:** Each output value commitment is accompanied by a Bulletproof proving `value ∈ [0, 2^64)`. Bulletproofs replaced the Borromean ring range proofs of the original CT proposal for their logarithmic size and absence of a trusted setup.

**Cryptographic stack:**

| Primitive | Role | Note |
|-----------|------|------|
| Pedersen commitments (secp256k1) | Hide amounts; homomorphic balance check | `Σ C_in = Σ C_out + fee·H` enforces no inflation |
| Bulletproofs (Bünz et al., 2018) | Range proofs for committed values | O(log n) proof size; no trusted setup |
| Surjection proofs | Prove asset-type balance across inputs/outputs | One-of-many proof over asset tag generators |
| ECDH (secp256k1) | Share blinding factors with recipient | Ephemeral key included in output |
| MuSig / 11-of-15 Schnorr | Federation signing for peg-in/peg-out | Emergency 2-of-3 backup path |

**Bulletproof size comparison:**

| Proof type | Borromean (original CT) | Bulletproofs |
|------------|------------------------|-------------|
| Single 64-bit range proof | ~2.5 KB | ~674 bytes |
| Aggregated 8 outputs | ~20 KB | ~2.2 KB |
| Trusted setup required | None | None |

**Transaction validation:** Each Liquid full node verifies:
- `Σ C_in = Σ C_out + fee·H` — Pedersen commitment balance
- Each Bulletproof — committed values are non-negative 64-bit integers
- Each surjection proof — asset types balance across inputs/outputs

**Limitations:** Confidential transactions are ~3–5× larger than transparent transactions; block capacity is constrained accordingly. The 15-of-15 peg federation is a trust assumption separate from the cryptographic layer — a federation compromise could allow unbacked L-BTC issuance.

**State of the art:** Liquid Network live since October 2018; Bulletproofs integrated 2019; used for institutional OTC settlement, tokenised bonds, Tether USDT on Liquid. Liquid whitepaper [[1]](https://blockstream.com/assets/downloads/pdf/liquid-whitepaper.pdf); Elements CT implementation [[2]](https://github.com/ElementsProject/elements). See [Confidential Transactions](#confidential-transactions-ct), [Range Proofs](#range-proofs), [MimbleWimble](#mimblewimble).

**Production readiness:** Production
Liquid Network live since October 2018; used for institutional OTC settlement, tokenised bonds, Tether USDT on Liquid

**Implementations:**
- [ElementsProject/elements](https://github.com/ElementsProject/elements) ⭐ 1.1k — C++, Elements sidechain with CT and Confidential Assets
- [ElementsProject/secp256k1-zkp](https://github.com/ElementsProject/secp256k1-zkp) ⭐ 419 — C, Bulletproofs and surjection proofs for Liquid
- [nickvdS/rust-secp256k1-zkp](https://github.com/mimblewimble/rust-secp256k1-zkp) ⭐ 59 — Rust, bindings for secp256k1-zkp

**Security status:** Secure
Pedersen commitments and Bulletproofs are cryptographically sound under discrete log; surjection proofs prevent cross-asset inflation; federation trust (15-of-15) is a separate non-cryptographic assumption

**Community acceptance:** Niche
Blockstream's Liquid is the primary deployment; well-reviewed Bulletproofs (IEEE S&P 2018); limited adoption outside Liquid ecosystem; federation model limits decentralisation

---

## Bridge Security — Trust Model Taxonomy

**Goal:** Classify the trust assumptions of cross-chain bridges — systems that lock assets on one chain and issue representations on another — from weakest (small multisig) to strongest (cryptographic validity proofs), and characterise the security failures that have resulted in over $2.5B of losses.

**Trust model spectrum:**

| Model | Representative bridges | Trust assumption | Loss vector |
|-------|----------------------|-----------------|------------|
| **Multisig / MPC** | Ronin (Axie), Harmony Horizon, Multichain | k-of-n custodians; safe if ≥ k honest | Key compromise; Ronin: 5-of-9 keys stolen ($625M, 2022) |
| **Optimistic** | Nomad, Hyperlane (default) | ≥ 1 honest online watcher challenges within window | Implementation bug; Nomad zero-init error ($190M, 2022) |
| **Light-client** | IBC, Near Rainbow Bridge | Cryptographic Merkle proofs against counterparty headers | Source-chain consensus failure (no known exploits) |
| **ZK / validity** | zkBridge, Succinct Telepathy, Polymer, Union | SNARK soundness + source-chain consensus; no committee | Proof system soundness (no known exploits at scale) |
| **Liquidity network** | Connext, Hop, Across | Atomic HTLC swap; no custody of assets | Counterparty liveness; limited to available liquidity |

**Wormhole exploit — February 2022, $325M:**

Wormhole is a guardian multisig bridge (19 guardians, 13-of-19 threshold). The exploit did not compromise any guardian key. It exploited a Solana program validation bug:

```
Solana's sysvar account verification was not enforced:
  Attacker passed a crafted fake "sysvar_instructions" account
  The bridge code verified guardian signatures against this fake account
  → Attacker minted 120,000 wETH on Ethereum with no corresponding SOL deposits
```

Root cause: missing validation that a Solana native program account address is canonical — a semantic input validation failure, not a cryptographic break.

**Optimistic bridge security properties:**

```
Assertion window (7 days):
  Sequencer posts state root S to destination chain
  Any watcher with local source-chain data can compute correct root S'
  If S ≠ S', watcher submits fraud proof within challenge window → sequencer slashed

Security reduces to: "at least one honest, online watcher at all times"
```

The Nomad bug (August 2022) bypassed this by allowing the zero hash `0x00...00` to be accepted as a valid Merkle root due to an uninitialised state variable — any arbitrary message could be replayed against the zero root.

**ZK bridge trust reduction — security comparison:**

| Property | Multisig bridge | Optimistic bridge | ZK bridge |
|----------|----------------|------------------|-----------|
| Committee required | Yes, k-of-n | No | No |
| Challenge period | None | 7 days | None |
| Proving cost | Negligible | Negligible | $0.10–$1.00/proof |
| Finality latency | Minutes | 7 days | Minutes–hours |
| Trust assumption | k honest signers | 1 online watcher | SNARK soundness |

**State of the art:** ZK bridges (Succinct Telepathy, Polymer, Union) are in production on mainnet (2024) but at lower TVL than multisig bridges due to proving cost. Wormhole post-mortem [[1]](https://extropy-io.medium.com/solanas-wormhole-hack-post-mortem-analysis-3b68b9e88e13); Nomad post-mortem [[2]](https://medium.com/nomad-xyz-blog/nomad-bridge-hack-root-cause-analysis-875ad2e5aacd); L2Beat bridge risk framework [[3]](https://l2beat.com/bridges/summary). See [zkBridge](#zkbridge--cross-chain-state-proofs), [IBC](#ibc--inter-blockchain-communication-protocol), [Helios Light Client](#helios--snark-based-ethereum-light-client).

**Production readiness:** Production
Multisig and light-client bridges are in production; ZK bridges deployed on mainnet (2024); >$2.5B lost to bridge exploits historically

**Implementations:**
- [cosmos/ibc-go](https://github.com/cosmos/ibc-go) ⭐ 635 — Go, IBC light-client bridge (strongest trust model)
- [succinctlabs/telepathy-contracts](https://github.com/succinctlabs/telepathy-contracts) ⭐ 80 — Solidity, ZK bridge contracts
- [connext/monorepo](https://github.com/connext/monorepo) ⭐ 302 — TypeScript, Connext liquidity network bridge
- [wormhole-foundation/wormhole](https://github.com/wormhole-foundation/wormhole) ⭐ 1.9k — Multi-language, Wormhole guardian bridge

**Security status:** Caution
Security varies dramatically by trust model: multisig bridges have suffered >$2B in losses; light-client and ZK bridges have no known exploits but are newer; implementation bugs (not crypto breaks) are the primary risk vector

**Community acceptance:** Widely trusted
Bridge security taxonomy is well-established in academic and industry literature; L2Beat risk framework is the standard assessment tool; ZK bridges increasingly accepted as the gold standard

---

## Seraphis — Monero Next-Generation Transaction Protocol

**Goal:** Replace Monero's current CLSAG-based RingCT with a more flexible membership-proof framework that supports larger anonymity sets, forward secrecy of sender identity, modular address schemes (Jamtis), and efficient scanning — while retaining Monero's default-on privacy for amounts, senders, and recipients.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Seraphis (koe et al.)** | 2022 | Grootle / Triptych membership proofs | Replaces CLSAG ring sigs with logarithmic-size set membership proofs; enables ring sizes of 128+ [[1]](https://github.com/UkoeHB/Seraphis) |
| **Jamtis Address Scheme** | 2022 | ECDH + key hierarchy | New address format for Seraphis; separates find-received, view-balance, and spend privileges; 3-tier key hierarchy [[1]](https://gist.github.com/tevador/50160d160d24cfc6c52ae02eb3d17024) |
| **Grootle One-out-of-Many Proof** | 2021 | Commitment-to-zero proof | Logarithmic-size membership proof for committed values; generalises Groth-Kohlweiss [[1]](https://eprint.iacr.org/2021/1256) |
| **Triptych** | 2020 | Generalised Schnorr + matrix | Linkable ring signature with O(log N) size; candidate for Seraphis membership layer [[1]](https://eprint.iacr.org/2020/018) |

**Key improvements over CLSAG RingCT:**

| Property | CLSAG (current Monero) | Seraphis (proposed) |
|----------|----------------------|---------------------|
| Ring size | 16 (linear proof size) | 128+ (logarithmic proof size) |
| Proof size scaling | O(n) in ring size | O(log n) in ring size |
| Address scheme | CryptoNote (limited key separation) | Jamtis (find/view/spend tiers) |
| Forward secrecy | No — compromised key reveals past sends | Yes — e_sender is ephemeral |
| Tx chaining | Not supported | Supported (outputs usable before confirmation) |

**State of the art:** Seraphis is under active development for Monero (2024-2025); no mainnet activation date yet. Seraphis specification [[1]](https://github.com/UkoeHB/Seraphis); Jamtis address scheme [[2]](https://gist.github.com/tevador/50160d160d24cfc6c52ae02eb3d17024). See [Monero RingCT](#monero-ringct--ring-signatures--confidential-transactions), [Ring Signatures](categories/08-signatures-advanced.md#ring-signatures), [Confidential Transactions](#confidential-transactions-ct).

**Production readiness:** Research
Under active development for Monero (2024-2025); no mainnet activation date; Seraphis library prototype available

**Implementations:**
- [UkoeHB/Seraphis](https://github.com/UkoeHB/Seraphis) ⭐ 57 — C++, Seraphis reference implementation
- [UkoeHB/monero](https://github.com/UkoeHB/monero/tree/seraphis_lib) ⭐ 8 — C++, Seraphis integration branch for Monero

**Security status:** Secure
Grootle/Triptych membership proofs are formally proven; logarithmic-size proofs enable larger anonymity sets (128+); Jamtis provides forward secrecy of sender identity

**Community acceptance:** Emerging
Well-received by Monero research community; Triptych published at ESORICS 2021; Grootle peer-reviewed; expected to become the next Monero transaction protocol

---

## Bulletproofs+ — Optimised Range Proofs

**Goal:** Improve upon Bulletproofs with a tighter security reduction and ~16% smaller proof size for range proofs, using a weighted inner product argument that eliminates redundant group elements — deployed in Monero (2022) and under consideration for other confidential transaction systems.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Bulletproofs (Bunz et al.)** | 2018 | Inner product argument | Logarithmic-size range proofs; no trusted setup; deployed in Monero, Liquid [[1]](https://eprint.iacr.org/2017/1066) |
| **Bulletproofs+ (Chung et al.)** | 2022 | Weighted inner product argument | ~16% smaller proofs; tighter soundness; adopted by Monero in 2022 [[1]](https://eprint.iacr.org/2020/735) |
| **Bulletproofs++ (Eagen)** | 2022 | Reciprocal argument | Further ~15% reduction over BP+; norm argument for range proofs; proposed for Monero [[1]](https://eprint.iacr.org/2022/510) |

**Size comparison for 64-bit range proofs:**

| Proof type | 1 output | 2 outputs (aggregated) | 8 outputs (aggregated) |
|------------|----------|----------------------|----------------------|
| Bulletproofs | 674 bytes | 738 bytes | 930 bytes |
| Bulletproofs+ | 576 bytes | 640 bytes | 800 bytes |
| Bulletproofs++ | ~490 bytes | ~550 bytes | ~700 bytes |

**State of the art:** Bulletproofs+ deployed on Monero mainnet (August 2022, hard fork v15). Bulletproofs++ proposed for future Monero upgrade. BP+ paper (Chung et al., 2020) [[1]](https://eprint.iacr.org/2020/735). See [Range Proofs](#range-proofs), [Confidential Transactions](#confidential-transactions-ct), [Monero RingCT](#monero-ringct--ring-signatures--confidential-transactions).

**Production readiness:** Production
Bulletproofs+ deployed on Monero mainnet (August 2022, hard fork v15); Bulletproofs++ proposed for future upgrade

**Implementations:**
- [monero-project/monero](https://github.com/monero-project/monero) ⭐ 10k — C++, Bulletproofs+ in production Monero
- [nickvdS/bulletproofs-plus](https://github.com/tari-project/bulletproofs-plus) ⭐ 11 — Rust, Bulletproofs+ reference implementation

**Security status:** Secure
Tighter security reduction than original Bulletproofs; weighted inner product argument proven under discrete log assumption; no trusted setup

**Community acceptance:** Widely trusted
Bulletproofs+ paper (Chung et al., 2020) peer-reviewed; deployed in Monero; natural evolution of the Bulletproofs line of work (IEEE S&P 2018)

---

## DECO — Decentralised Oracle via TLS Proofs

**Goal:** Allow a user to prove statements about data received from any TLS-protected web server (bank balance, identity record, API response) to a verifier or smart contract — without revealing the data to the verifier and without any server-side modification — by using a three-party handshake protocol that splits the TLS session key between the prover and a semi-trusted notary.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DECO (Zhang et al., Cornell)** | 2020 | TLS 1.2/1.3 + 2PC + ZKP | Three-party TLS handshake; prover and verifier jointly hold session key; CCS 2020 [[1]](https://eprint.iacr.org/2019/1332) |
| **TLSNotary** | 2022 | TLS 1.2 + MPC (garbled circuits) | Open-source implementation of DECO-style TLS proofs; 2PC for HMAC key split [[1]](https://tlsnotary.org/) |
| **zkTLS (Reclaim Protocol)** | 2024 | TLS 1.3 + SNARK | Generates ZK proofs of TLS session content; on-chain verifiable [[1]](https://www.reclaimprotocol.org/) |
| **Town Crier** | 2016 | TLS + TEE (Intel SGX) | TEE-based TLS oracle; predecessor to DECO; TEE scrapes HTTPS data [[1]](https://eprint.iacr.org/2016/168) |

**DECO protocol overview:**

```
Prover (P)                 Server (S, e.g. bank API)          Verifier (V, notary)
  │                              │                                │
  ├── TLS handshake with S ──────┤                                │
  │   (P and V jointly compute   │                                │
  │    session key via 2PC:      │                                │
  │    P holds key_share_P,      │                                │
  │    V holds key_share_V,      │                                │
  │    neither knows full key)   │                                │
  │                              │                                │
  ├── Request data from S ───────┤                                │
  ├── Receive encrypted response ┤                                │
  │   (P decrypts locally using  │                                │
  │    key_share_P + key_share_V │                                │
  │    via 2PC; V never sees     │                                │
  │    plaintext)                │                                │
  │                              │                                │
  ├── ZK proof to V: ────────────┼────────────────────────────────┤
  │   "decrypted response        │   V verifies: TLS MAC is valid │
  │    satisfies predicate P"    │   + ZK proof checks out        │
```

**State of the art:** TLSNotary is the most mature open-source implementation (2024). Chainlink acquired DECO from Cornell (2020) for oracle integration. zkTLS (Reclaim, Opacity) is the emerging direction using SNARKs for fully on-chain verification. DECO paper (Zhang et al., CCS 2020) [[1]](https://eprint.iacr.org/2019/1332). See [Zero-Knowledge Proofs](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview), [Secure Communication Protocols](categories/12-secure-communication-protocols.md).

**Production readiness:** Experimental
TLSNotary is the most mature implementation (2024); Chainlink acquired DECO (2020); zkTLS (Reclaim, Opacity) emerging

**Implementations:**
- [tlsnotary/tlsn](https://github.com/tlsnotary/tlsn) ⭐ 407 — Rust, TLSNotary prover and verifier
- [nickvdS/deco-paper](https://eprint.iacr.org/2019/1332) — Reference paper (Cornell/Chainlink)

**Security status:** Caution
Security relies on semi-trusted notary (TLSNotary) or TEE (Town Crier); MPC-based key splitting prevents notary from seeing plaintext; zkTLS approaches eliminate notary trust but are newer

**Community acceptance:** Emerging
DECO published at CCS 2020 (top venue); acquired by Chainlink for oracle integration; TLSNotary has growing open-source community; zkTLS is the emerging research direction

---

## VRF-Based Consensus and Leader Election (Algorand)

**Goal:** Use Verifiable Random Functions (VRFs) to enable private, non-interactive leader election and committee selection where each participant locally determines whether they are selected for a role — without any interactive protocol — and can prove their selection to the network with a compact VRF proof. Deployed in Algorand, Cardano (Ouroboros Praos), and Polkadot (BABE).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Algorand BA* (Gilad et al.)** | 2017 | VRF (ECVRF) + Byzantine agreement | Cryptographic sortition: each user evaluates VRF; selected if output < threshold; MIT [[1]](https://arxiv.org/abs/1607.01341) |
| **Ouroboros Praos (Cardano)** | 2017 | VRF + stake-weighted threshold | PoS slot leader election via VRF; security under semi-adaptive corruptions [[1]](https://eprint.iacr.org/2017/573) |
| **Ouroboros Genesis** | 2018 | VRF + chain selection rule | Extends Praos with secure bootstrapping from genesis without checkpoints [[1]](https://eprint.iacr.org/2018/378) |
| **BABE (Polkadot)** | 2020 | VRF (Sr25519 / Ristretto) | Blind slot assignment; primary + secondary leaders; see Polkadot BABE/GRANDPA [[1]](https://wiki.polkadot.com/learn/learn-consensus/) |

**Algorand cryptographic sortition:**

```
For each step of consensus:
  (hash, proof) = VRF_Eval(sk_user, seed || round || step)
  weight = user's stake / total_stake
  selected = hash < threshold(weight)

If selected:
  Broadcast (message, proof) to network
  Any node verifies: VRF_Verify(pk_user, seed || round || step, hash, proof) = 1
  and checks hash < threshold(weight)
```

**Key properties:**

| Property | Algorand sortition | Traditional leader election |
|----------|-------------------|---------------------------|
| Communication rounds | 0 (self-selection) | O(n) or O(n^2) |
| Leader known before acting | No (private until broadcast) | Yes (public schedule) |
| DoS resistance | Leader identity hidden until proposal | Leader is a known target |
| Finality | Immediate (Byzantine agreement) | Probabilistic (longest chain) |

**State of the art:** Algorand mainnet (June 2019) uses ECVRF over Ed25519; Cardano mainnet (July 2020) uses Ouroboros Praos VRF. Both process thousands of TPS with instant finality. Algorand paper [[1]](https://arxiv.org/abs/1607.01341); Ouroboros Praos [[2]](https://eprint.iacr.org/2017/573). See [Secret Leader Election](#secret-leader-election), [Verifiable Random Functions](categories/09-commitments-verifiability.md#verifiable-random-functions-vrf), [Polkadot BABE/GRANDPA](#polkadot-babegrandpa-hybrid-consensus).

**Production readiness:** Production
Algorand mainnet since June 2019; Cardano (Ouroboros Praos) since July 2020; both with instant finality

**Implementations:**
- [algorand/go-algorand](https://github.com/algorand/go-algorand) ⭐ 1.4k — Go, Algorand node with ECVRF-based sortition
- [IntersectMBO/cardano-node](https://github.com/IntersectMBO/cardano-node) ⭐ 3.2k — Haskell, Cardano node with Ouroboros Praos VRF
- [nickvdS/polkadot-sdk](https://github.com/paritytech/polkadot-sdk) ⭐ 2.7k — Rust, BABE VRF slot assignment for Polkadot

**Security status:** Secure
VRF output is provably unpredictable and non-biasable; ECVRF over Ed25519 is standardised (IETF RFC 9381); leader identity hidden until proposal

**Community acceptance:** Widely trusted
Algorand BA* published at SOSP 2017 (top systems venue); Ouroboros Praos peer-reviewed at EUROCRYPT 2018; VRF-based election is the standard approach for PoS leader selection

---

## Recursive SNARKs for Rollups — Nova and ProtoStar Folding

**Goal:** Enable ZK rollups to prove arbitrarily long sequences of state transitions with constant proof size and near-linear prover cost by *folding* successive computation steps into a single accumulated instance rather than verifying one SNARK inside another — dramatically reducing the overhead of recursive proof composition.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Nova (Kothapalli-Setty-Tzialla)** | 2021 | R1CS folding + Pedersen commitments | First practical folding scheme; fold two R1CS instances into one relaxed instance [[1]](https://eprint.iacr.org/2021/370) |
| **SuperNova** | 2022 | Non-uniform IVC via Nova | Different circuit at each step; supports branching programs (e.g., VM opcode dispatch) [[1]](https://eprint.iacr.org/2022/1758) |
| **HyperNova** | 2023 | CCS folding + sum-check | Generalises Nova to Customisable Constraint Systems; subsumes R1CS, PLONK, AIR [[1]](https://eprint.iacr.org/2023/573) |
| **ProtoStar** | 2023 | Special-sound folding for PLONK | Folding for PLONKish arithmetisation with lookup arguments; IPA/KZG compatible [[1]](https://eprint.iacr.org/2023/620) |
| **Sangria** | 2023 | Relaxed PLONK folding | Adapts Nova's approach to PLONK constraint systems; KZG-based [[1]](https://geometry.xyz/notebook/sangria-a-folding-scheme-for-plonk) |
| **ProtoGalaxy** | 2023 | Multi-instance folding | Fold k > 2 instances simultaneously; amortises folding cost [[1]](https://eprint.iacr.org/2023/1106) |

**Nova folding in detail:**

```
Classical recursion (expensive):
  π₂ proves "I verified π₁ inside my circuit" → circuit includes full SNARK verifier → huge

Nova folding (cheap):
  Instance u₁ = (commitment, public IO, error term)
  Instance u₂ = new step's instance
  Challenge r ← random (Fiat-Shamir)
  Folded instance u' = u₁ + r·u₂  (linear combination of committed witnesses)
  Cost: O(|circuit|) field operations — no SNARK verification inside the circuit
```

**Rollup deployment:**

| Rollup / zkVM | Folding scheme | Status |
|---------------|---------------|--------|
| **Nexus zkVM** | Nova / HyperNova | Research / testnet |
| **Lurk (Protocol Labs)** | Nova (Arecibo) | Alpha; Lisp-based zkVM |
| **SP1 (Succinct)** | STARK recursion (not folding) | Production; RISC-V zkVM |
| **RISC Zero** | STARK recursion + Groth16 wrapper | Production; RISC-V zkVM |

**State of the art:** Nova (2021) and HyperNova (2023) are the leading folding constructions; ProtoStar extends folding to PLONKish systems. Production rollup provers (SP1, RISC Zero) currently prefer STARK recursion but folding integration is active research. Nova paper [[1]](https://eprint.iacr.org/2021/370); ProtoStar [[2]](https://eprint.iacr.org/2023/620). See [IVC for Blockchain](#incremental-verifiable-computation-ivc-for-blockchain), [ZK Rollups](#zk-rollups-and-optimistic-rollups), [Folding Schemes](categories/04-zero-knowledge-proof-systems.md#folding-schemes-and-proof-carrying-data-pcd).

**Production readiness:** Experimental
Nova and HyperNova are research-grade with working implementations; production rollup provers (SP1, RISC Zero) currently use STARK recursion

**Implementations:**
- [microsoft/Nova](https://github.com/microsoft/Nova) ⭐ 837 — Rust, Nova R1CS folding scheme by Microsoft Research
- [lurk-lab/lurk-rs](https://github.com/lurk-lab/lurk-rs) ⭐ 450 — Rust, Lurk zkVM using Nova (Arecibo)
- [nexus-xyz/nexus-zkvm](https://github.com/nexus-xyz/nexus-zkvm) ⭐ 2.6k — Rust, Nexus zkVM with HyperNova folding
- [geometryresearch/sangria](https://geometry.xyz/notebook/sangria-a-folding-scheme-for-plonk) — Research, Sangria PLONK folding specification

**Security status:** Secure
Nova folding is formally proven under standard cryptographic assumptions; random linear combination ensures soundness; final SNARK verification remains standard

**Community acceptance:** Emerging
Nova (Microsoft Research, 2021) and HyperNova (2023) published at top venues; ProtoStar and ProtoGalaxy extend to PLONKish systems; rapidly growing academic and industry interest

---

## Cross-Chain Bridges — Hash Time-Locked Contracts and Light Client Proofs

**Goal:** Enable trustless asset transfer and message passing between independent blockchains using cryptographic mechanisms — either hash time-locked contracts (HTLCs) for atomic swaps between chains with scripting support, or light client proofs that verify the source chain's consensus on the destination chain without intermediaries.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HTLC Atomic Swap** | 2013 | Hash preimage + timelocks | Cross-chain swap: Alice locks on chain A with hash h; Bob locks on chain B with same h; preimage reveal claims both [[1]](https://en.bitcoin.it/wiki/Atomic_swap) |
| **PTLC (Point Time-Locked Contracts)** | 2019 | Adaptor signatures | Scriptless HTLC replacement; no hash correlation across hops; requires Schnorr [[1]](https://suredbits.com/payment-points-part-1/) |
| **SPV Relay (BTC Relay)** | 2016 | Merkle proof + PoW verification | Verify Bitcoin tx on Ethereum by relaying block headers + SPV proof [[1]](https://github.com/ethereum/btcrelay) |
| **IBC Light Client** | 2021 | Tendermint light client + Merkle proof | Verify counterparty chain headers via >=2/3 validator sigs; see [IBC](#ibc--inter-blockchain-communication-protocol) [[1]](https://ibc.cosmos.network/) |
| **ZK Light Client Bridge** | 2023 | SNARK-proven consensus verification | Prove BLS/Ed25519 signature verification inside a SNARK; see [zkBridge](#zkbridge--cross-chain-state-proofs) [[1]](https://arxiv.org/abs/2210.00264) |
| **Optimistic Bridge (Nomad-style)** | 2022 | Fraud proofs + challenge window | Post state root; 7-day challenge; 1-of-n honest watcher assumption [[1]](https://docs.connext.network/) |

**HTLC cross-chain protocol:**

```
Chain A (Alice has asset_A)              Chain B (Bob has asset_B)
─────────────────────────────            ─────────────────────────
Alice picks secret s, h = H(s)
Alice locks asset_A: "claimable          Bob locks asset_B: "claimable
  by Bob with preimage of h              by Alice with preimage of h
  before time T₁"                        before time T₂ (T₂ < T₁)"

Alice reveals s to claim asset_B  ────►  Bob sees s on-chain
on chain B                               Bob uses s to claim asset_A
                                          on chain A
```

**Light client proof verification cost:**

| Verification method | On-chain cost | Trust assumption |
|---------------------|--------------|-----------------|
| Full header relay | ~200K gas/header (Ethereum) | Source chain consensus |
| SNARK-wrapped light client | ~300K gas/proof (one-time) | SNARK soundness + source consensus |
| Optimistic relay | ~50K gas (post root) | 1 honest watcher |

**State of the art:** IBC (Cosmos, 115+ chains) is the most deployed light-client bridge protocol. ZK bridges (Succinct, Polymer, Union) are the emerging standard for EVM chains. HTLCs remain the simplest trustless mechanism for chains with scripting support. See [Fair Exchange / Atomic Swaps](#fair-exchange--atomic-swaps), [IBC](#ibc--inter-blockchain-communication-protocol), [zkBridge](#zkbridge--cross-chain-state-proofs), [Bridge Security](#bridge-security--trust-model-taxonomy).

**Production readiness:** Production
IBC (115+ chains), HTLCs (Lightning, atomic swaps), and ZK light client bridges (Succinct, Polymer) all in production

**Implementations:**
- [cosmos/ibc-go](https://github.com/cosmos/ibc-go) ⭐ 635 — Go, IBC light-client bridge protocol
- [connext/monorepo](https://github.com/connext/monorepo) ⭐ 302 — TypeScript, Connext HTLC-based liquidity network
- [succinctlabs/telepathy-contracts](https://github.com/succinctlabs/telepathy-contracts) ⭐ 80 — Solidity, ZK light client bridge
- [nickvdS/btcrelay](https://github.com/ethereum/btcrelay) ⭐ 632 — Solidity, SPV relay for Bitcoin on Ethereum (historical)

**Security status:** Caution
Security ranges from weak (multisig) to strong (ZK validity proofs); HTLCs are secure under hash preimage resistance + timelock enforcement; light-client bridges reduce trust to source chain consensus

**Community acceptance:** Widely trusted
HTLCs are a foundational cross-chain primitive; IBC is the Cosmos ecosystem standard; ZK bridges are emerging as the gold standard; L2Beat provides comprehensive risk assessments

---

## Penumbra — Private DEX with Threshold Encryption

**Goal:** Build a fully private, Cosmos-based decentralised exchange where transaction amounts, asset types, and trading activity are hidden by default using a combination of Groth16 zk-SNARKs, threshold encryption for MEV prevention, and a novel batch-swap mechanism that executes trades without revealing individual orders.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Penumbra Shielded Pool** | 2023 | Groth16 + Decaf377 (Decaf on Ed25519) | Zcash-style shielded notes; multi-asset; Pedersen commitments for amounts and asset types [[1]](https://penumbra.zone/technology) |
| **Penumbra Batch Swaps** | 2023 | Sealed-bid batch auction + threshold decryption | Users submit encrypted swap intents; decrypted after ordering; uniform clearing price per batch [[1]](https://penumbra.zone/blog/batching-and-uniform-clearing-prices) |
| **Flow Encryption (Penumbra TE)** | 2023 | Threshold Ferveo DKG + AES | Validators jointly decrypt swap intents only after batch cutoff; prevents front-running [[1]](https://github.com/anoma/ferveo) |

**MEV prevention via threshold encryption:**

```
User submits swap intent (encrypted under validators' threshold public key)
  │ Intent: "swap 100 ATOM for OSMO at market price"
  ▼
Block inclusion (intents are opaque ciphertext)
  │ No validator can read individual intents
  ▼
Threshold decryption (≥ 2/3 validators contribute shares)
  │ All intents in the batch decrypted simultaneously
  ▼
Batch execution (uniform clearing price)
  │ All swaps at same price — no front-running advantage
```

**State of the art:** Penumbra mainnet launched 2024 on Cosmos (IBC-connected). Combines shielded transactions (Zcash-style), threshold encryption (MEV protection), and batch auctions (fair pricing). Penumbra protocol spec [[1]](https://protocol.penumbra.zone/); Ferveo DKG [[2]](https://github.com/anoma/ferveo). See [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering), [Confidential Transactions](#confidential-transactions-ct), [IBC](#ibc--inter-blockchain-communication-protocol).

**Production readiness:** Production
Penumbra mainnet launched 2024 on Cosmos (IBC-connected); shielded transactions and batch swaps operational

**Implementations:**
- [penumbra-zone/penumbra](https://github.com/penumbra-zone/penumbra) ⭐ 476 — Rust, Penumbra full node and shielded pool
- [anoma/ferveo](https://github.com/anoma/ferveo) ⭐ 84 — Rust, Ferveo DKG for threshold encryption
- [penumbra-zone/decaf377](https://github.com/penumbra-zone/decaf377) ⭐ 17 — Rust, Decaf377 curve for Penumbra cryptography

**Security status:** Caution
Groth16 proofs over Decaf377 are sound; threshold encryption requires >= 2/3 honest validators for decryption; batch swap mechanism prevents front-running but requires committee liveness

**Community acceptance:** Niche
Novel combination of shielded transactions + threshold-encrypted DEX; well-received by Cosmos community; first private DEX with MEV prevention; small but growing ecosystem

---

## FHE-Based Encrypted DeFi (fhEVM)

**Goal:** Execute smart contract logic on encrypted state using Fully Homomorphic Encryption (FHE) — so that a blockchain can process token transfers, AMM swaps, and auctions where the on-chain state (balances, bids, votes) is never revealed in plaintext to validators, users, or observers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **fhEVM (Zama)** | 2023 | TFHE + EVM integration | EVM-compatible smart contracts operating on FHE-encrypted uint types; TFHE library for Solidity [[1]](https://github.com/zama-ai/fhevm) |
| **Sunscreen** | 2023 | BFV/CKKS FHE compiler | Rust FHE compiler targeting blockchain applications; BFV for integer arithmetic [[1]](https://sunscreen.tech/) |
| **Fhenix** | 2024 | fhEVM (Zama TFHE) + optimistic rollup | L2 rollup with native FHE execution; encrypted ERC-20 operations [[1]](https://www.fhenix.io/) |
| **Inco Network** | 2024 | fhEVM + modular chain | Standalone FHE-enabled chain; confidential DeFi and gaming [[1]](https://www.inco.org/) |

**fhEVM architecture:**

```
Solidity contract with encrypted types:
  euint32 balance;                    // encrypted 32-bit unsigned int
  function transfer(einput to, einput amount, bytes calldata proof) {
      euint32 enoughBalance = TFHE.le(amount, balance);
      balance = TFHE.select(enoughBalance, balance - amount, balance);
  }

All operations (add, sub, le, select) computed homomorphically on ciphertexts
Validators process encrypted state — never see plaintext balances
Decryption requires threshold key ceremony (network-wide threshold FHE)
```

**Threshold FHE for decryption:** The network's FHE secret key is split across validators via a threshold scheme. Decryption (e.g., for a user requesting their own balance) requires a threshold of validators to contribute partial decryptions — no single validator can decrypt any value.

**State of the art:** Zama fhEVM is the leading implementation (testnet, 2024); Fhenix and Inco are building FHE-native rollups. TFHE bootstrapping latency (~100 ms per gate) limits throughput but is improving rapidly. fhEVM whitepaper [[1]](https://github.com/zama-ai/fhevm/blob/main/fhevm-whitepaper.pdf). See [Fully Homomorphic Encryption](categories/07-homomorphic-functional-encryption.md), [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering).

**Production readiness:** Experimental
Zama fhEVM on testnet (2024); Fhenix and Inco building FHE-native rollups; no mainnet production deployment yet

**Implementations:**
- [zama-ai/fhevm](https://github.com/zama-ai/fhevm) ⭐ 25k — Solidity/Rust, FHE-enabled EVM smart contracts (TFHE)
- [zama-ai/tfhe-rs](https://github.com/zama-ai/tfhe-rs) ⭐ 1.6k — Rust, TFHE library powering fhEVM

**Security status:** Caution
TFHE is cryptographically secure under LWE assumption; threshold decryption requires honest validator majority; FHE computation overhead (~100 ms per gate) limits practical throughput; implementation maturity is low

**Community acceptance:** Emerging
Zama is the leading FHE company with strong academic credentials; fhEVM concept is well-received; practical limitations (latency, cost) mean adoption is early-stage; active research community

---

## Aztec Protocol — Private Smart Contracts (Noir / PLONK)

**Goal:** Enable programmable privacy on Ethereum — private token transfers, confidential DeFi interactions, and arbitrary private computation — by executing smart contract logic inside a zk-SNARK circuit on the client side and posting only the proof on-chain, so that transaction details (sender, recipient, amount, function arguments) remain hidden.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Aztec Connect (v1)** | 2022 | PLONK (TurboPlonk) | ZK bridge to Ethereum DeFi; private deposits into Aave/Lido/etc.; sunset 2023 [[1]](https://aztec.network/) |
| **Aztec Network (v2 / Noir)** | 2024 | UltraPlonk + Honk prover | Full private smart contract L2; client-side proof generation; private + public state [[1]](https://aztec.network/) |
| **Noir Language** | 2023 | Domain-specific ZK language | Rust-like language compiling to ACIR (Abstract Circuit IR); backend-agnostic (PLONK, Groth16) [[1]](https://noir-lang.org/) |
| **Honk Prover** | 2024 | UltraPlonk + Goblin recursive verifier | Aztec's next-gen prover; recursive proof aggregation via Goblin Plonk; no trusted setup path [[1]](https://github.com/AztecProtocol/aztec-packages) |

**Private execution model:**

```
User (client-side):
  1. Fetch encrypted note data from Aztec L2
  2. Decrypt notes using viewing key
  3. Execute private function locally (e.g., transfer, swap)
  4. Generate SNARK proof of correct execution
  5. Submit proof + encrypted output notes to Aztec sequencer

Sequencer:
  1. Verify SNARK proofs
  2. Update note commitment tree (append new commitments, record nullifiers)
  3. Aggregate batch proof → post single proof to Ethereum L1

Ethereum L1:
  1. Verify aggregated SNARK proof (~300K gas)
  2. Update Aztec rollup state root
```

**UTXO-based private state:** Aztec uses a note-based (UTXO) model for private state — similar to Zcash. Each private value is a *note* with a commitment in a global Merkle tree. Spending a note reveals a *nullifier* (unique, unlinkable to the commitment) and creates new note commitments. Public state uses a standard key-value store accessible to the kernel circuit.

**State of the art:** Aztec Network testnet launched 2024; Noir is used by external teams (e.g., Mach 34, ZKEmail). UltraPlonk deployed; Honk prover under development for production. Noir documentation [[1]](https://noir-lang.org/); Aztec protocol spec [[2]](https://docs.aztec.network/). See [ZK Rollups](#zk-rollups-and-optimistic-rollups), [Zcash Sapling Transaction Structure](#zcash-sapling-transaction-structure), [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zk-proof-systems-overview).

**Production readiness:** Experimental
Aztec Network testnet launched 2024; Noir language in active use by external teams; Aztec Connect (v1) sunset 2023

**Implementations:**
- [AztecProtocol/aztec-packages](https://github.com/AztecProtocol/aztec-packages) ⭐ 435 — TypeScript/Noir, Aztec Network monorepo
- [noir-lang/noir](https://github.com/noir-lang/noir) ⭐ 1.3k — Rust, Noir ZK domain-specific language
- [AztecProtocol/barretenberg](https://github.com/AztecProtocol/barretenberg) ⭐ 194 — C++, UltraPlonk/Honk proving backend

**Security status:** Caution
UltraPlonk proof system is well-studied; Honk prover under active development; UTXO-based private state model mirrors Zcash (battle-tested design); testnet stage means limited real-world security validation

**Community acceptance:** Emerging
Noir language gaining adoption in ZK developer community; Aztec is a well-funded project with strong cryptographic team; private smart contract L2 is a novel and desired capability

---

## Interchain Security and Mesh Security (Cosmos)

**Goal:** Allow a Cosmos Hub validator set to extend its economic security to consumer chains — so that new application-specific blockchains do not need to bootstrap their own validator set and staked capital — using cryptographic mechanisms (cross-chain validator set verification, IBC-based slashing evidence, and double-signing proofs) to enforce slashing conditions across chains.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Replicated Security (ICS v1)** | 2023 | IBC + CometBFT validator set replication | Cosmos Hub validators run consumer chain; slashing evidence relayed via IBC [[1]](https://cosmos.network/interchain-security) |
| **Opt-in Security (Partial Set Security, ICS v2)** | 2024 | IBC + selective validator participation | Validators opt in per consumer chain; subset security with top-N or power-cap [[1]](https://informal.systems/blog/partial-set-security) |
| **Mesh Security** | 2024 | IBC + cross-chain restaking | Validators on chain A can restake on chain B without running B's software; delegated security [[1]](https://mesh.informal.systems/) |
| **Double-Signing Evidence** | 2019 | Ed25519 equivocation proof | Two signed conflicting blocks at same height; relayed via IBC for cross-chain slashing [[1]](https://docs.cosmos.network/v0.50/build/modules/evidence) |

**Replicated Security architecture:**

```
Cosmos Hub (provider chain)
  │ Validator set V = {v₁, ..., vₙ} with staked ATOM
  │
  ├─ IBC: send ValidatorSetChangePacket to consumer chain
  │   (consumer adopts Hub's validator set via CometBFT light client)
  │
  ├─ Consumer chain runs with Hub's validators
  │   (validators must run consumer chain binary alongside Hub)
  │
  └─ Slashing: if validator double-signs on consumer chain,
      evidence relayed via IBC → Hub slashes validator's ATOM stake
```

**Cryptographic slashing evidence:** A double-signing proof consists of two signed block proposals (or prevotes) at the same height and round, with valid Ed25519 signatures from the same validator key. The IBC relayer submits this evidence as an IBC packet; the provider chain's evidence module verifies both signatures and slashes the validator's bond.

**State of the art:** Replicated Security live on Cosmos Hub (March 2023); Neutron and Stride are the first consumer chains. Partial Set Security (2024) allows opt-in. Mesh Security is under development by Osmosis and Informal Systems. ICS documentation [[1]](https://cosmos.network/interchain-security); Mesh Security spec [[2]](https://mesh.informal.systems/). See [IBC](#ibc--inter-blockchain-communication-protocol), [Casper FFG](#casper-ffg--ethereum-proof-of-stake-finality), [Linear BFT Consensus](#linear-bft-consensus-hotstuff--tendermint).

**Production readiness:** Production
Replicated Security live on Cosmos Hub since March 2023; Neutron and Stride are first consumer chains; Partial Set Security launched 2024

**Implementations:**
- [cosmos/interchain-security](https://github.com/cosmos/interchain-security) ⭐ 190 — Go, ICS provider and consumer chain modules
- [cosmos/ibc-go](https://github.com/cosmos/ibc-go) ⭐ 635 — Go, IBC transport for cross-chain slashing evidence
- [informalsystems/mesh-security](https://github.com/osmosis-labs/mesh-security) ⭐ 69 — Rust/Go, Mesh Security protocol

**Security status:** Secure
Economic security inherited from Cosmos Hub's staked ATOM; double-signing evidence is cryptographically verifiable (two Ed25519 signatures at same height); slashing is enforced via IBC packet relay

**Community acceptance:** Emerging
ICS is the Cosmos ecosystem standard for shared security; endorsed by Cosmos Hub governance; Partial Set Security and Mesh Security extend flexibility; growing adoption by app-chains

---
