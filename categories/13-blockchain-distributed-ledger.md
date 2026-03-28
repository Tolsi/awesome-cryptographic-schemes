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
