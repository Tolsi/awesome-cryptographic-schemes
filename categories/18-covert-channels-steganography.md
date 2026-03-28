# Covert Channels & Steganography

## Steganography

**Goal:** Covert communication. Hide the very existence of a secret message within an innocent-looking cover medium (image, audio, text). Even if an adversary inspects the medium, they cannot detect that a hidden message exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LSB Steganography** | 1990s | Spatial domain | Replace least significant bits of image pixels; simple but detectable [[1]](https://ieeexplore.ieee.org/document/4655281) |
| **Provably Secure Stego (Hopper-Langford-von Ahn)** | 2002 | Rejection sampling | First formal security definitions; stego from any PRG [[1]](https://eprint.iacr.org/2002/137) |
| **Meteor (LLM Stego)** | 2023 | Language model sampling | Hide messages in LLM-generated text; provably undetectable [[1]](https://eprint.iacr.org/2023/1029) |

**State of the art:** Provably-secure stego (theory), Meteor (AI-era steganography in LLM text).

---

## Digital Watermarking / Fingerprinting

**Goal:** Copyright protection and traitor tracing. Embed a hidden mark in content (image, audio, video, text, ML model) that survives transformations (compression, cropping, noise). Fingerprinting: each copy gets a unique mark to trace leakers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cox-Kilian-Leighton-Shamoon Spread Spectrum** | 1997 | Spread spectrum | Embed watermark in frequency domain; robust to compression [[1]](https://doi.org/10.1109/83.650120) |
| **Boneh-Shaw Fingerprinting** | 1998 | Collusion-resistant codes | Fingerprinting code: coalition of k users cannot frame an innocent user [[1]](https://doi.org/10.1109/18.705568) |
| **Tardos Fingerprinting Code** | 2003 | Probabilistic | Optimal-length collusion-resistant code; O(k² log n) length [[1]](https://doi.org/10.1145/779928.779945) |
| **ML Model Watermarking** | 2018 | Trigger set / backdoor | Embed verifiable watermark in neural network weights [[1]](https://arxiv.org/abs/1802.04633) |

**State of the art:** Tardos codes for collusion resistance; ML watermarking for AI model IP. Related to [Steganography](#steganography) (hide message) vs. watermarking (prove ownership).

---

## Kleptography / Algorithm-Substitution Attacks (ASA)

**Goal:** Attack model — subverted implementations. An adversary replaces a cryptographic algorithm with a modified version that covertly leaks secret keys through ciphertexts, signatures, or nonces — undetectable by black-box testing. The attack-side counterpart to [Cryptographic Reverse Firewalls](#cryptographic-reverse-firewalls).

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Simmons Subliminal Channel** | 1984 | DSA/ElGamal nonce | Original subliminal channel: embed covert message in signature nonce; "Prisoners' Problem" [[1]](https://link.springer.com/chapter/10.1007/978-1-4684-4730-9_5) |
| **Young-Yung Kleptography** | 1996 | Subliminal channels | First formalization; embed secret key in RSA key generation subliminal channel [[1]](https://doi.org/10.1007/3-540-68339-9_12) |
| **Bellare-Paterson-Rogaway ASA** | 2014 | Symmetric / AEAD | Algorithm-substitution attacks on symmetric encryption; post-Snowden model [[1]](https://eprint.iacr.org/2014/438) |
| **Dual_EC_DRBG Backdoor** | 2013 | EC points | Real-world kleptographic backdoor in NIST DRBG; NSA-planted [[1]](https://projectbullrun.org/dual-ec/documents.html) |
| **ASA on Signatures (Ateniese et al.)** | 2015 | Randomness manipulation | Subvert signature randomness to leak signing key [[1]](https://eprint.iacr.org/2015/517) |

**State of the art:** ASA model (Bellare et al. 2014); defenses include [CRF](#cryptographic-reverse-firewalls), deterministic signatures (EdDSA), and verifiable randomness. See also [DRBG](#drbg-deterministic-random-bit-generators).

---

## Deniable Encryption

**Goal:** Coercion resistance. After encryption, the sender/receiver can produce fake randomness making it look like a different plaintext was encrypted. Protects under duress or legal compulsion.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **CDNO Deniable Encryption** | 1997 | Sender-deniable PKE | Foundational definitions; first constructions [[1]](https://link.springer.com/chapter/10.1007/BFb0052229) |
| **Sahai-Waters Receiver-Deniable** | 2014 | iO (indistinguishability obfuscation) | First receiver-deniable PKE (from iO) [[1]](https://eprint.iacr.org/2014/381) |
| **OTR Messaging** | 2004 | DH + MAC (no signatures) | Practical deniability in chat; no non-repudiation [[1]](https://otr.cypherpunks.ca/otr-wpes.pdf) |
| **Signal Protocol (deniability)** | 2013 | Triple-DH + ratchet | Deniable by design: no binding signatures on messages [[1]](https://signal.org/docs/specifications/doubleratchet/) |

**State of the art:** Signal Protocol (practical messaging), OTR (classic chat), Sahai-Waters (theoretical).

---

## Deniable Authentication

**Goal:** Authenticate messages so the receiver is convinced of the sender's identity, but cannot prove this to any third party. Unlike [deniable encryption](#deniable-encryption) (hide message content), deniable authentication hides the fact of who sent the message.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dwork-Naor-Sahai Deniable Auth** | 1998 | Concurrent ZK | First formal treatment; authentication deniable under concurrent composition [[1]](https://doi.org/10.1007/BFb0055724) |
| **Di Raimondo-Gennaro-Krawczyk** | 2006 | DH + HMAC | Practical deniable authentication in key exchange; basis of Signal's deniability [[1]](https://eprint.iacr.org/2006/280) |
| **Dodis-Fiore-Ostrovsky-Rosen** | 2012 | Ring signatures | Deniable auth equivalent to ring signatures of size 2 [[1]](https://eprint.iacr.org/2012/282) |

**State of the art:** DH-based deniable auth (in Signal, OTR); ring-signature-based for formal guarantees. Related to [Designated Verifier Signatures](#designated-verifier-signatures--proofs).

---
