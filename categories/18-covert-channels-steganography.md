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

## Information-Theoretic Steganography (Cachin Model)

**Goal:** Formalize when a steganographic system is undetectable. Model the warden as a hypothesis tester trying to distinguish cover-objects from stego-objects; bound its advantage in terms of the KL divergence between the two distributions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cachin IT Model** | 1998 | KL divergence / hypothesis testing | Defines ε-secure stego: D_KL(cover ‖ stego) ≤ ε; perfect security at ε = 0 [[1]](https://link.springer.com/chapter/10.1007/3-540-49380-8_21) |
| **Universal Stegosystem (Cachin)** | 1998 | i.i.d. cover distribution | Constructs a perfectly secure system when cover is i.i.d.; no key needed beyond shared distribution [[1]](https://eprint.iacr.org/2000/028) |
| **Perfectly Secure Stego via Min-Entropy Coupling** | 2021 | Optimal transport | Achieves zero KL divergence using minimum-entropy coupling of message and cover; capacity-optimal [[1]](https://openreview.net/forum?id=HQ67mj5rJdR) |

**State of the art:** Cachin's 1998 model is the standard information-theoretic framework; complements the computational model of [Hopper-Langford-von Ahn](#steganography). Min-entropy coupling (2021) achieves optimal capacity under perfect secrecy. Related to [Wiretap Channel](categories/17-ai-hardware-physical-security.md#wiretap-channel) (physical-layer secrecy).

---

## Network / Protocol Steganography

**Goal:** Hide covert data within the fields or timing of standard network protocol messages (TCP/IP headers, inter-packet delays, retransmission events) so that an observer monitoring the network cannot detect the covert channel.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rowland TCP/IP Covert Channels** | 1997 | IP-ID / TCP ISN fields | First systematic exploitation of unused/pseudo-random header fields (IP Identification, TCP ISN, ACK fields) to carry covert data [[1]](https://firstmonday.org/ojs/index.php/fm/article/view/528) |
| **IP Covert Timing Channels (Cabuk-Brodley-Shields)** | 2004 | Inter-packet delays | Encode bits in inter-packet timing gaps; detected via ε-similarity and compressibility scores [[1]](https://people.cs.georgetown.edu/~clay/research/pubs/cabuk.ccs2004.pdf) |
| **RSTEG (Retransmission Steganography)** | 2008 | TCP retransmission | Intentionally suppress ACK to trigger retransmission; carry steganogram in retransmitted payload instead of original data [[1]](https://link.springer.com/article/10.1007/s00500-009-0530-1) |
| **HICCUPS** | 2003 | WLAN corrupted frames | Embed covert data in intentionally corrupted WLAN frames that legitimate receivers discard; ~1 Mb/s capacity in 802.11g networks [[1]](https://www.semanticscholar.org/paper/HICCUPS-%3A-Hidden-Communication-System-for-Corrupted-Szczypiorski/cb42073a770527059d2b597560547bf926777c7f) |

**State of the art:** Network steganography spans storage channels (header-field manipulation) and timing channels (inter-packet delays). Active-warden countermeasures (traffic normalisation, timing jitter removal) are the primary defences. See also [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) for protocol-level covert exfiltration.

---

## Content-Adaptive Image Steganography

**Goal:** Embed a secret payload in a digital image while minimising statistical detectability. Modern schemes assign per-pixel (or per-DCT-coefficient) distortion costs and concentrate changes in textured or noisy regions where modifications are hardest to detect.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **JSteg / OutGuess** | 1997–2001 | JPEG DCT LSB | Replace LSBs of quantised DCT coefficients; OutGuess additionally corrects first-order DCT histogram to resist chi-square attack [[1]](https://dde.binghamton.edu/kodovsky/pdf/Fri07-ACM.pdf) |
| **F5** | 2001 | JPEG DCT ± embedding | Decrements absolute DCT values (±1 matrix encoding) and uses shrinkage correction; more secure than LSB substitution [[1]](https://link.springer.com/chapter/10.1007/3-540-36415-3_20) |
| **HUGO** | 2010 | Spatial domain SPAM features | Assigns distortion via change in SPAM feature vector; pushes changes to high-texture regions [[1]](https://link.springer.com/chapter/10.1007/978-3-642-16435-4_13) |
| **WOW / S-UNIWARD** | 2012–2013 | Wavelet distortion | Wavelet Obtained Weights / Spatial UNIWARD: directional wavelet residuals define per-pixel cost; state-of-the-art spatial and JPEG adaptive schemes [[1]](https://dl.acm.org/doi/10.1145/2482513.2482965) |
| **SteganoGAN / HiDDeN** | 2018–2019 | GAN / encoder-decoder CNN | End-to-end learned steganography; GAN discriminator replaces hand-crafted distortion metric; up to 4.4 bpp capacity [[1]](https://arxiv.org/abs/1901.03892) |

**State of the art:** S-UNIWARD and HILL are the canonical adaptive baselines; deep-learning schemes (SteganoGAN, HiDDeN) achieve higher capacity but remain vulnerable to CNN-based steganalysis. Related to [Steganalysis](#steganalysis) (detection side) and [LSB Steganography](#steganography).

---

## Steganalysis

**Goal:** Detect the presence of a hidden message in a medium (image, audio, network traffic) without knowledge of the steganographic key or algorithm. The adversary's goal is binary hypothesis testing: does this object carry a payload?

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Chi-Square / RS Analysis** | 1999–2001 | Statistical DCT/pixel histograms | Chi-square attack exploits pair-of-values bias in sequential LSB embedding; RS detects LSB flipping by measuring regularity/singularity of pixel groups [[1]](https://www.sciencedirect.com/science/article/abs/pii/S0165168403001695) |
| **Calibration Attack (Fridrich et al.)** | 2002 | JPEG re-compression reference | Estimates clean DCT histogram by re-compressing a cropped version of the image; detects F5 and OutGuess [[1]](https://link.springer.com/chapter/10.1007/3-540-36415-3_20) |
| **Spatial Rich Model (SRM)** | 2012 | High-order co-occurrence features | 34,671-dimensional feature set of noise residuals; ensemble SVM classifier; gold standard for classical steganalysis [[1]](http://dde.binghamton.edu/kodovsky/pdf/TIFS2012-SRM.pdf) |
| **Xu-Net / Ye-Net / Yedroudj-Net** | 2016–2018 | CNN with high-pass pre-filter | Deep CNN steganalysers with fixed KV/SRM-inspired pre-processing layers; match or exceed SRM accuracy on adaptive schemes [[1]](https://arxiv.org/abs/1904.01444) |

**State of the art:** CNN-based detectors (Xu-Net, Yedroudj-Net, SRNet) are the state of the art for spatial-domain steganalysis; JPEG steganalysis uses J-UNIWARD features or DCTR. Arms race with [Content-Adaptive Image Steganography](#content-adaptive-image-steganography). Active-warden detection applies to [Network / Protocol Steganography](#network--protocol-steganography).

---

## Broadcast Steganography

**Goal:** Enable a sender to hide covert messages intended for a dynamically designated subset of receivers inside a public broadcast, so that outsiders and unintended recipients cannot even detect that a covert message exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Broadcast Steganography (Bellare-Paterson-Rosen)** | 2014 | Outsider-anonymous broadcast encryption | Reduces to oABE with pseudorandom ciphertexts; sender targets any subset of n receivers with sublinear communication complexity; secure in the standard model [[1]](https://eprint.iacr.org/2013/078) |
| **One-Time Stegosystem (Kiayias-Raekow-Russell-Shashidhar)** | 2014 | Information-theoretic + PRG | First IT-secure stego with asymptotically optimal key-to-message ratio; composed with PRG for computationally secure covert communication [[1]](https://eprint.iacr.org/2015/684) |

**State of the art:** Bellare-Paterson-Rosen (2014) is the foundational construction. Broadcast steganography inherits the security hierarchy of [anonymous broadcast encryption](categories/07-homomorphic-functional-encryption.md#broadcast-encryption--anonymous-broadcast-encryption). Related to [Steganography](#steganography) (single-receiver) and [Deniable Encryption](#deniable-encryption).

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
