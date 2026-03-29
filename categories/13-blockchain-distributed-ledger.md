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

---

## Data Availability Sampling (DAS)

**Goal:** Verify data exists without downloading it. Light clients randomly sample small chunks of erasure-coded data; if enough samples succeed, the full data is available with high probability. Core to blockchain scalability (Ethereum danksharding).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **KZG-based DAS** | 2020 | KZG + Reed-Solomon | Commit to data with KZG polynomial; sample random evaluations; see [Commitment Schemes](#commitment-schemes) [[1]](https://eprint.iacr.org/2019/1205) |
| **2D KZG DAS (Danksharding)** | 2022 | KZG over 2D grid | Ethereum's approach: rows + columns of KZG commitments [[1]](https://eprint.iacr.org/2022/1592) |
| **FRI-based DAS** | 2023 | FRI + RS codes | No trusted setup (unlike KZG); used in Celestia, Avail [[1]](https://eprint.iacr.org/2023/1172) |

**State of the art:** KZG-based (Ethereum EIP-4844), FRI-based (Celestia). Critical for modular blockchain scalability.

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

| Project | Year | Note |
|---------|------|------|
| **Grin** | 2019 | Pure MimbleWimble; community project; no founders allocation |
| **Beam** | 2019 | MimbleWimble + optional Lelantus; Confidential Assets |
| **Litecoin MWEB** | 2022 | Extension blocks grafted onto Litecoin; optional MW inputs/outputs |

**Original paper:** Tom Elvis Jedusor ("Voldemort"), 2016 anonymous whitepaper dropped in the #bitcoin-wizards IRC channel [[1]](https://download.wpsoftware.net/bitcoin/wizardry/mimblewimble.txt). No trusted setup; fully transparent.

**State of the art:** Litecoin MWEB (2022) is the largest production deployment. Grin uses Bulletproofs+ (2021, ~16% smaller range proofs). See [Confidential Transactions](#confidential-transactions-ct), [Range Proofs](#range-proofs).

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

---

## Secret Leader Election

**Goal:** Elect a leader (block proposer, committee chair) so that the leader's identity is secret until they act. Prevents targeted DoS/bribery attacks on the next leader. Used in blockchain consensus (Ethereum single-slot finality research).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Algorand Cryptographic Sortition** | 2017 | VRF | VRF-based self-selection; each user privately checks if selected [[1]](https://arxiv.org/abs/1607.01341) |
| **Boneh-Eskandarian-Fisch-Hanzlik SLE** | 2020 | Commit-reveal + VRF | Formal secret leader election; leader identity hidden until block proposal [[1]](https://eprint.iacr.org/2020/025) |
| **Whisk (Ethereum proposal)** | 2022 | Shuffle + commitments | Shuffled validator registry; no one knows next proposer; considered for Ethereum [[1]](https://ethresear.ch/t/whisk-a-practical-shuffle-based-ssle-protocol-for-ethereum/11763) |

**State of the art:** Whisk for Ethereum; Algorand sortition deployed. Combines [VRF](#verifiable-random-functions-vrf) and [Commitment Schemes](#commitment-schemes).

---

## Order-Fair Consensus

**Goal:** Prevent transaction reordering attacks (MEV). If most honest nodes receive transaction A before B, then A must be ordered before B in the final ledger. A new consensus property alongside safety and liveness — fairness of ordering.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Aequitas (Kelkar-Zhang-Goldfeder-Juels)** | 2020 | Threshold timestamps | First order-fair consensus; CRYPTO 2020; ordering reflects receive-order [[1]](https://eprint.iacr.org/2020/269) |
| **Themis** | 2023 | Batch-ordering + consensus | Strong order-fairness with standard liveness; negligible overhead over BFT [[1]](https://eprint.iacr.org/2021/1465) |
| **BEAT-MEV** | 2024 | Batched threshold encryption | Epochless batched TE for encrypted mempools; USENIX Security 2025 [[1]](https://eprint.iacr.org/2024/1533) |

**State of the art:** Themis (2023) for consensus-level fairness; BEAT-MEV for encryption-based MEV prevention. Extends [Encrypted Mempools](#encrypted-mempools--threshold-encryption-for-transaction-ordering) and [Async BFT](#asynchronous-bft--asynchronous-mpc).

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

---
