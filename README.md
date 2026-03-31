# Awesome Cryptographic Schemes [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> A curated list of cryptographic schemes, protocols, and primitives — with plain-language descriptions, goals, state-of-the-art algorithms, and references to key papers.

---

## Contents

1. **[Foundational Primitives](categories/01-foundational-primitives.md)**
   Block ciphers, stream ciphers, hash functions, MACs, digital signatures, PRFs, PRGs, random extractors, and other building blocks that everything else is built on. AES, SHA-3, HMAC, Ed25519, BLAKE3, ASCON.

2. **[Authenticated & Structured Encryption](categories/02-authenticated-structured-encryption.md)**
   Encryption schemes that go beyond confidentiality: AEAD (AES-GCM, ChaCha20-Poly1305), key-committing AEAD, KEM/DEM, format-preserving encryption, disk encryption, order-preserving encryption, and updatable/rerandomizable schemes.

3. **[Key Exchange & Key Management](categories/03-key-exchange-key-management.md)**
   Protocols for establishing and managing keys: Diffie-Hellman, PAKE, HKDF, HD wallets (BIP32/BIP39), JOSE/JWT, certificate transparency, ACME, key transparency, SLIP-39.

4. **[Zero-Knowledge & Proof Systems](categories/04-zero-knowledge-proof-systems.md)**
   Proving a statement is true without revealing why: ZK-SNARKs, STARKs, Groth16, PLONK, FRI, folding schemes, zkVMs (zkEVM, RISC Zero), zkML, and the underlying tools (Sigma protocols, sumcheck, lookup arguments).

5. **[Secret Sharing & Threshold Cryptography](categories/05-secret-sharing-threshold-cryptography.md)**
   Splitting a secret across N parties so any K can reconstruct it: Shamir SSS, Feldman/Pedersen VSS, DKG, proactive secret sharing, packed/robust/ramp/evolving variants, and threshold decryption.

6. **[Multi-Party Computation](categories/06-multi-party-computation.md)**
   Multiple parties jointly compute a function over private inputs without revealing them: garbled circuits, OT, secure aggregation, VOLE, silent OT, YOSO, fluid MPC, and asynchronous protocols.

7. **[Homomorphic & Functional Encryption](categories/07-homomorphic-functional-encryption.md)**
   Compute on encrypted data without decrypting: FHE (BGV, BFV, CKKS, TFHE), multi-key FHE, attribute-based encryption, identity-based encryption, proxy re-encryption, and functional encryption.

8. **[Signatures — Advanced](categories/08-signatures-advanced.md)**
   Beyond basic ECDSA: threshold signatures (TSS), blind signatures, ring signatures, BLS aggregate, adaptor signatures (scriptless scripts), forward-secure, sanitizable, structure-preserving, ring VRF, and 20+ other variants.

9. **[Commitments & Verifiability](categories/09-commitments-verifiability.md)**
   Cryptographic commitments and verifiable primitives: Pedersen commitments, VRFs, VDFs, verifiable computation, vector commitments, time-lock puzzles, proof of retrievability, accumulators, and Merkle mountain ranges.

10. **[Privacy-Preserving Computation](categories/10-privacy-preserving-computation.md)**
    Protocols that compute over data while hiding individual inputs: PSI, PIR, ORAM, OPRF, searchable encryption, oblivious SQL, differential privacy, Prio/VDAF aggregation, fuzzy PSI, and graph encryption.

11. **[Anonymity & Credentials](categories/11-anonymity-credentials.md)**
    Hiding identity while proving properties: anonymous credentials, mix networks, onion routing (Tor), DC-nets, Privacy Pass, stealth addresses, e-cash (Chaumian), Semaphore/RLN, and group encryption.

12. **[Secure Communication Protocols](categories/12-secure-communication-protocols.md)**
    End-to-end secure messaging and transport: Signal (Double Ratchet, X3DH), MLS/CGKA, TLS 1.3, DTLS, QUIC, IKEv2/IPsec, OpenPGP, KEMTLS, BIP 324, Apple PQ3, DKIM, FIDO2/WebAuthn.

13. **[Blockchain & Distributed Ledger](categories/13-blockchain-distributed-ledger.md)**
    Cryptography powering decentralized systems: PoW, confidential transactions, range proofs (Bulletproofs), Taproot/Schnorr, MimbleWimble, IBC, EIP-712, HotStuff/Tendermint BFT, atomic swaps, and data availability sampling.

14. **[Applied Cryptography & Infrastructure / PKI](categories/14-applied-infrastructure-pki.md)**
    Production-deployed cryptographic infrastructure: DNSSEC, DANE, TEE attestation (SGX/TDX/Nitro), Kerberos, EMV, Sigstore, TUF, W3C DIDs/VCs, C2PA/SLSA provenance.

15. **[Quantum Cryptography & Post-Quantum](categories/15-quantum-cryptography.md)**
    Quantum-safe and quantum-native cryptography: NIST PQC standards (ML-KEM, ML-DSA, SLH-DSA), QKD, quantum money, isogeny-based crypto (CSIDH, SQIsign), position-based QC, and certified quantum randomness.

16. **[Obfuscation & Advanced Hardness Assumptions](categories/16-obfuscation-advanced-hardness.md)**
    Schemes requiring stronger-than-standard hardness: indistinguishability obfuscation (iO), multilinear maps, laconic cryptography, witness encryption, batch arguments (BARG), spooky encryption.

17. **[AI, Hardware & Physical Security](categories/17-ai-hardware-physical-security.md)**
    Cryptography at the intersection of AI and hardware: zkLLM (verifiable AI inference), AI output watermarking (pseudorandom codes), physical unclonable functions (PUF), in-sensor crypto, encrypted control systems, wiretap channel, proof of location.

18. **[Covert Channels & Steganography](categories/18-covert-channels-steganography.md)**
    Hiding the existence of communication: steganography, digital watermarking/fingerprinting, kleptography and algorithm-substitution attacks (ASA), deniable encryption, deniable authentication.

19. **[Theoretical Foundations](categories/19-theoretical-foundations.md)**
    Security models and theoretical underpinnings: leakage-resilient crypto, circular/KDM security, non-malleable codes, witness indistinguishability, concurrent zero-knowledge, rational cryptography, lossy trapdoor functions, cryptographic reverse firewalls.

20. **[Applied & Niche Protocols](categories/20-applied-niche-protocols.md)**
    Specialized real-world protocols that don't fit neatly elsewhere: end-to-end verifiable e-voting, coercion-resistant voting, visual cryptography, linked timestamping (RFC 3161), proof of secure erasure, key-insulated cryptography, client puzzles, incremental cryptography.

See [INDEX.md](INDEX.md) for an alphabetical index of all 1069 schemes.

---

## Contributing

Contributions welcome! Please open an issue or PR to add missing schemes, correct references, or improve descriptions.

---

## License

[![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

This list is dedicated to the public domain under CC0 1.0.
