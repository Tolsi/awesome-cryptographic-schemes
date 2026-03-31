# Covert Channels & Steganography

## Steganography

**Goal:** Covert communication. Hide the very existence of a secret message within an innocent-looking cover medium (image, audio, text). Even if an adversary inspects the medium, they cannot detect that a hidden message exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **LSB Steganography** | 1990s | Spatial domain | Replace least significant bits of image pixels; simple but detectable [[1]](https://ieeexplore.ieee.org/document/4655281) |
| **Provably Secure Stego (Hopper-Langford-von Ahn)** | 2002 | Rejection sampling | First formal security definitions; stego from any PRG [[1]](https://eprint.iacr.org/2002/137) |
| **Meteor (LLM Stego)** | 2023 | Language model sampling | Hide messages in LLM-generated text; provably undetectable [[1]](https://eprint.iacr.org/2023/1029) |

**State of the art:** Provably-secure stego (theory), Meteor (AI-era steganography in LLM text).


**Production readiness:** Experimental
Core steganographic techniques range from toy (LSB) to research prototypes (Meteor); no standardised production deployment.

**Implementations:**
- [OpenStego](https://github.com/syvaidya/openstego) ⭐ 1.4k — Java, LSB and randomised LSB embedding/extraction

**Security status:** Caution
LSB embedding is trivially detectable by modern steganalysis; provably secure schemes (Meteor) are secure under formal models but lack deployment hardening.

**Community acceptance:** Niche
Steganography is a well-studied academic field but has no standardisation body; used primarily in research, journalism, and activism.

---

## Information-Theoretic Steganography (Cachin Model)

**Goal:** Formalize when a steganographic system is undetectable. Model the warden as a hypothesis tester trying to distinguish cover-objects from stego-objects; bound its advantage in terms of the KL divergence between the two distributions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cachin IT Model** | 1998 | KL divergence / hypothesis testing | Defines ε-secure stego: D_KL(cover ‖ stego) ≤ ε; perfect security at ε = 0 [[1]](https://link.springer.com/chapter/10.1007/3-540-49380-8_21) |
| **Universal Stegosystem (Cachin)** | 1998 | i.i.d. cover distribution | Constructs a perfectly secure system when cover is i.i.d.; no key needed beyond shared distribution [[1]](https://eprint.iacr.org/2000/028) |
| **Perfectly Secure Stego via Min-Entropy Coupling** | 2021 | Optimal transport | Achieves zero KL divergence using minimum-entropy coupling of message and cover; capacity-optimal [[1]](https://openreview.net/forum?id=HQ67mj5rJdR) |

**State of the art:** Cachin's 1998 model is the standard information-theoretic framework; complements the computational model of [Hopper-Langford-von Ahn](#steganography). Min-entropy coupling (2021) achieves optimal capacity under perfect secrecy. Related to [Wiretap Channel](categories/17-ai-hardware-physical-security.md#wiretap-channel) (physical-layer secrecy).


**Production readiness:** Research
Cachin's model is a theoretical framework; practical implementations remain academic prototypes.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Information-theoretic guarantees (zero KL divergence) provide the strongest possible security under the model assumptions.

**Community acceptance:** Niche
Standard theoretical framework in the steganography research community; Cachin's 1998 model is universally cited but not formalised by any standards body.

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


**Production readiness:** Experimental
Research prototypes and proof-of-concept tools exist; no standardised or widely deployed production system.

**Implementations:**
- [ptunnel-ng](https://github.com/lnslbrty/ptunnel-ng) ⭐ 557 — C, ICMP tunnel for covert TCP communication
- [iodine](https://github.com/yarrick/iodine) ⭐ 7.8k — C, DNS tunnel for IPv4 over DNS

**Security status:** Caution
Network stego channels are detectable by traffic normalisation and statistical timing analysis; security depends heavily on the specific channel and warden model.

**Community acceptance:** Niche
Active research area in network security; no standardisation; used in penetration testing and censorship circumvention.

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


**Production readiness:** Mature
S-UNIWARD and HILL have production-quality reference implementations; deep-learning schemes have working codebases but are not battle-tested.

**Implementations:**
- [UNIWARD (DDE Binghamton)](http://dde.binghamton.edu/download/stego_algorithms/) — MATLAB, reference implementations of S-UNIWARD, HILL, and WOW
- [SteganoGAN](https://github.com/DAI-Lab/SteganoGAN) ⭐ 378 — Python/PyTorch, GAN-based image steganography
- [HiDDeN](https://github.com/ando-khachatryan/HiDDeN) ⭐ 423 — Python/PyTorch, encoder-decoder deep steganography

**Security status:** Caution
Adaptive schemes resist classical steganalysis but are increasingly vulnerable to CNN-based detectors (SRNet, Yedroudj-Net); security degrades with payload size.

**Community acceptance:** Widely trusted
S-UNIWARD is the de facto benchmark in the image steganography research community; widely cited and used in competitions (BOSS, ALASKA).

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


**Production readiness:** Mature
SRM and CNN-based detectors have production-quality implementations used in forensic and law enforcement contexts.

**Implementations:**
- [SRM (DDE Binghamton)](http://dde.binghamton.edu/download/feature_extractors/) — MATLAB, Spatial Rich Model feature extractor

**Security status:** Secure
State-of-the-art CNN detectors achieve >95% accuracy against most embedding schemes at moderate payloads; detection accuracy degrades at very low embedding rates.

**Community acceptance:** Widely trusted
Steganalysis is a mature forensic discipline; SRM and CNN detectors are standard tools in digital forensics; BOSS and ALASKA challenges drive community benchmarking.

---

## Broadcast Steganography

**Goal:** Enable a sender to hide covert messages intended for a dynamically designated subset of receivers inside a public broadcast, so that outsiders and unintended recipients cannot even detect that a covert message exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Broadcast Steganography (Bellare-Paterson-Rosen)** | 2014 | Outsider-anonymous broadcast encryption | Reduces to oABE with pseudorandom ciphertexts; sender targets any subset of n receivers with sublinear communication complexity; secure in the standard model [[1]](https://eprint.iacr.org/2013/078) |
| **One-Time Stegosystem (Kiayias-Raekow-Russell-Shashidhar)** | 2014 | Information-theoretic + PRG | First IT-secure stego with asymptotically optimal key-to-message ratio; composed with PRG for computationally secure covert communication [[1]](https://eprint.iacr.org/2015/684) |

**State of the art:** Bellare-Paterson-Rosen (2014) is the foundational construction. Broadcast steganography inherits the security hierarchy of [anonymous broadcast encryption](categories/07-homomorphic-functional-encryption.md#broadcast-encryption--anonymous-broadcast-encryption). Related to [Steganography](#steganography) (single-receiver) and [Deniable Encryption](#deniable-encryption).


**Production readiness:** Research
Purely theoretical constructions; no known implementation beyond academic prototypes.

**Implementations:**
- [iacr/2013/078](https://eprint.iacr.org/2013/078) — PDF, Bellare-Paterson-Rosen paper with construction details

**Security status:** Secure
Provably secure under standard-model assumptions; security reduces to outsider-anonymous broadcast encryption.

**Community acceptance:** Niche
Foundational theoretical work; cited in the steganography and broadcast encryption communities but no practical adoption.

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


**Production readiness:** Production
Deployed at scale in cinema forensic watermarking (DCI), streaming services, and ML model IP protection.

**Implementations:**
- [OpenCV watermarking](https://github.com/opencv/opencv) ⭐ 86k — C++/Python, image processing with DCT-domain watermark support
- [invisible-watermark](https://github.com/ShieldMnt/invisible-watermark) ⭐ 1.9k — Python, DWT/DCT invisible watermarking library
- [uchicago-sandlab/tree-ring-watermark](https://github.com/YuxinWenRick/tree-ring-watermark) ⭐ 352 — Python, tree-ring watermarking for diffusion models

**Security status:** Caution
Robust watermarks survive standard transformations but can be removed by sophisticated adversaries (overprinting, model fine-tuning); Tardos codes provide provable collusion resistance.

**Community acceptance:** Standard
Standardised by ISO/IEC 19794 (biometric watermarking) and DCI (cinema); Boneh-Shaw and Tardos codes are widely accepted in the fingerprinting community.

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


**Production readiness:** Research
ASA is an attack model, not a deployable system; Dual_EC_DRBG was the only known real-world kleptographic backdoor.

**Implementations:**
No notable open-source implementations available.

**Security status:** Broken
Kleptographic attacks are devastating when present; Dual_EC_DRBG was confirmed backdoored. Defence requires deterministic randomness (EdDSA) or cryptographic reverse firewalls.

**Community acceptance:** Widely trusted
The ASA threat model (Bellare et al. 2014) is universally accepted in the cryptographic community; spurred adoption of deterministic signature schemes and verifiable randomness.

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


**Production readiness:** Production
Signal Protocol and OTR are deployed at scale in messaging applications; theoretical constructions (Sahai-Waters) remain unimplemented.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, Signal Protocol with deniable messaging
- [VeraCrypt](https://github.com/veracrypt/VeraCrypt) ⭐ 9.4k — C++, hidden volume deniable encryption

**Security status:** Secure
Signal and OTR provide practical deniability against offline third-party verification; theoretical receiver-deniability (from iO) is not practically achievable.

**Community acceptance:** Widely trusted
Signal Protocol is the gold standard for deniable messaging; OTR established the concept; VeraCrypt hidden volumes are widely used for deniable storage.

---

## Deniable Authentication

**Goal:** Authenticate messages so the receiver is convinced of the sender's identity, but cannot prove this to any third party. Unlike [deniable encryption](#deniable-encryption) (hide message content), deniable authentication hides the fact of who sent the message.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Dwork-Naor-Sahai Deniable Auth** | 1998 | Concurrent ZK | First formal treatment; authentication deniable under concurrent composition [[1]](https://doi.org/10.1007/BFb0055724) |
| **Di Raimondo-Gennaro-Krawczyk** | 2006 | DH + HMAC | Practical deniable authentication in key exchange; basis of Signal's deniability [[1]](https://eprint.iacr.org/2006/280) |
| **Dodis-Fiore-Ostrovsky-Rosen** | 2012 | Ring signatures | Deniable auth equivalent to ring signatures of size 2 [[1]](https://eprint.iacr.org/2012/282) |

**State of the art:** DH-based deniable auth (in Signal, OTR); ring-signature-based for formal guarantees. Related to [Designated Verifier Signatures](#designated-verifier-signatures--proofs).


**Production readiness:** Production
Deployed in Signal and OTR messaging protocols; theoretical constructions exist for formal guarantees.

**Implementations:**
- [libsignal](https://github.com/signalapp/libsignal) ⭐ 5.6k — Rust/Java/Swift, deniable authentication via Triple-DH

**Security status:** Secure
DH-based deniable auth in Signal and OTR is secure against offline transcript analysis; concurrent composition requires stronger assumptions.

**Community acceptance:** Widely trusted
Integral to Signal Protocol security guarantees; ring-signature equivalence (Dodis et al. 2012) provides theoretical foundation.

---

## Audio Steganography (Echo Hiding & MP3Stego)

**Goal:** Conceal a secret bitstream inside an audio signal — either by exploiting psychoacoustic masking effects (echo hiding) or by embedding data during the lossy compression process (MP3Stego) — so that the resulting audio is perceptually indistinguishable from the original.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Echo Hiding (Gruhl-Lu-Bender)** | 1996 | Psychoacoustic echo | Embed bits by adding a delayed, attenuated echo kernel to the audio; kernel parameters (delay, amplitude, decay) encode 0/1; cepstrum analysis recovers the hidden signal [[1]](https://link.springer.com/content/pdf/10.1007/3-540-61996-8_48.pdf) |
| **MP3Stego (Petitcolas)** | 1998 | MPEG-III bit reservoir | Hides data during the MP3 encoding loop by exploiting the unused bits of the inner loop's bit reservoir; payload is 3DES-encrypted before embedding; capacity ~-1 bit/frame at 128 kbps [[1]](https://www.petitcolas.net/steganography/mp3stego/) |
| **Phase Coding** | 1996 | Phase manipulation | Encodes message bits in phase differences between audio segments; exploits the ear's relative phase insensitivity; more robust to re-encoding than LSB substitution [[1]](https://link.springer.com/article/10.1186/1687-4722-2012-25) |

**State of the art:** Echo hiding is the canonical psychoacoustic audio steganography scheme; MP3Stego remains the reference implementation for compressed-domain audio stego. Audio steganalysis relies on cepstral analysis (echo detection) and statistical modeling of MP3 bit-reservoir distributions. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) (same adaptive-distortion philosophy, different medium).


**Production readiness:** Experimental
MP3Stego has a stable reference implementation; echo hiding remains primarily academic.

**Implementations:**
- [MP3Stego](https://www.petitcolas.net/steganography/mp3stego/) — C, reference implementation for MP3 compressed-domain steganography
- [AudioStego](https://github.com/danielcardeenas/AudioStego) ⭐ 295 — C++, LSB audio steganography tool
- [steganography-tools](https://github.com/ragibson/Steganography) ⭐ 648 — Python, audio and image steganography toolkit

**Security status:** Caution
Echo hiding is detectable by cepstral analysis; MP3Stego resists casual inspection but is vulnerable to targeted steganalysis of bit-reservoir statistics.

**Community acceptance:** Niche
Audio steganography is a well-studied niche within the steganography community; MP3Stego is the most widely cited audio stego tool.

---

## Text / Linguistic Steganography

**Goal:** Hide a secret message inside ordinary-looking natural-language text or formatted documents by exploiting invisible formatting (trailing whitespace, zero-width characters) or semantic transformations (synonym substitution, paraphrase generation) that leave the surface meaning unchanged to a human reader.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SNOW (Whitespace Steganography)** | 1998 | Trailing whitespace encoding | Appends sequences of spaces and tabs at line endings; invisible in all common text viewers; ICE encryption of payload; capacity ~1 bit per line [[1]](https://darkside.com.au/snow/) |
| **Synonym Substitution (Chang-Clark)** | 2014 | Contextual lexical graph | Assigns bits to synonym sets via vertex colouring on a WordNet graph; uses Google n-grams to verify contextual fluency; state-of-the-art capacity/undetectability tradeoff for linguistic stego [[1]](https://direct.mit.edu/coli/article/40/2/403/1470/Practical-Linguistic-Steganography-using) |
| **Zero-Width Character Stego** | 2010s | Unicode invisible codepoints | Encodes bits in sequences of zero-width non-joiner (U+200C) and zero-width joiner (U+200D) inserted between characters; survives copy-paste; resists visual inspection [[1]](https://www.sciencedirect.com/science/article/abs/pii/S002002552200809X) |

**State of the art:** Whitespace and zero-width character methods are trivially stripped by normalisation; synonym substitution (Chang-Clark 2014) and LLM-based paraphrase methods (see [Meteor](#steganography)) provide higher security. Text steganalysis relies on perplexity-based and n-gram distributional tests. Related to [Steganography](#steganography) and [Meteor (LLM Stego)](#steganography).


**Production readiness:** Experimental
SNOW and zero-width tools are readily usable; synonym substitution methods require NLP infrastructure.

**Implementations:**
- [SNOW](https://darkside.com.au/snow/) — C, whitespace steganography with ICE encryption
- [stegcloak](https://github.com/KuroLabs/stegcloak) ⭐ 3.8k — JavaScript/Node.js, zero-width character steganography

**Security status:** Caution
Whitespace and zero-width methods are trivially stripped by text normalisation; synonym substitution is more robust but detectable by perplexity analysis.

**Community acceptance:** Niche
Active research area; SNOW is widely known; zero-width methods are popular in CTF competitions and journalism.

---

## DNA Steganography

**Goal:** Hide a secret message physically inside a DNA molecule so that the very existence of the message is concealed — the DNA appears to be ordinary biological material. Provides long-term, high-density, and chemically durable covert storage inaccessible to electronic eavesdroppers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DNA Microdot (Clelland-Risca-Bancroft)** | 1999 | Nucleotide-to-ASCII encoding | Encodes each ASCII character as a DNA triplet using a key-dependent codon table; synthesises the DNA oligomer; conceals it in a microdot disguised as a printed full stop; first experimental demonstration [[1]](https://www.nature.com/articles/21092) |
| **SNP-Based Genomic Stego** | 2020 | Single nucleotide polymorphisms | Encodes message bits into predefined SNP loci of a host genome sequence; the stego-genome passes as a normal sequencing result; includes block-sum error detection for mutation-induced bit-flips [[1]](https://microbialcellfactories.biomedcentral.com/articles/10.1186/s12934-020-01387-0) |

**State of the art:** Clelland-Risca-Bancroft (1999, Nature) is the seminal physical demonstration; SNP-based methods (2020) scale to whole-genome carriers. DNA steganography offers extraordinary density (~1 exabyte/gram) but requires wet-lab synthesis and sequencing for encode/decode. Largely orthogonal to digital steganography; no established steganalysis countermeasure exists beyond targeted sequence-pattern search. Related to [Information-Theoretic Steganography](#information-theoretic-steganography-cachin-model).


**Production readiness:** Research
Laboratory demonstrations only; requires wet-lab DNA synthesis and sequencing equipment for encode/decode.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
No established steganalysis countermeasure exists for DNA steganography; security relies on physical inaccessibility and the lack of targeted sequence-pattern search tools.

**Community acceptance:** Niche
Interdisciplinary niche spanning molecular biology and information security; Clelland-Risca-Bancroft (Nature 1999) is the seminal reference.

---

## Adversarial / GAN Steganography

**Goal:** Use deep learning — specifically generative adversarial networks (GANs) — to jointly learn a steganographic encoder and a steganographic decoder end-to-end, with the GAN discriminator acting as an automatic steganalyser during training, so that the resulting hidden-message images minimise detectability without hand-crafted distortion metrics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ste-GAN-ography (Hayes-Danezis)** | 2017 | Three-party GAN (Alice / Bob / Eve) | First adversarially trained steganography; Alice (encoder) and Bob (decoder) play against Eve (steganalyser); all three are CNNs; matches hand-crafted adaptive schemes in detectability while learning in an unsupervised manner [[1]](https://arxiv.org/abs/1703.00371) |
| **SSGAN (Shi et al.)** | 2017 | Wasserstein GAN + GNCNN discriminator | Replaces DCGAN with WGAN for training stability; adds a noise-guessing CNN discriminator; improves visual quality over SGAN [[1]](https://link.springer.com/article/10.1007/s11042-018-6951-z) |
| **SteganoGAN** | 2019 | Dense encoder-decoder + GAN | Achieves 4.4 bpp capacity in natural images; GAN discriminator enforces perceptual indistinguishability; evades standard steganalysers (SRM, Xu-Net) at moderate payloads [[1]](https://arxiv.org/abs/1901.03892) |

**State of the art:** Hayes-Danezis (NeurIPS 2017) established adversarial training as a viable steganography design methodology; SteganoGAN (2019) achieves highest reported bpp. CNN-based steganalysers (SRNet, Yedroudj-Net) remain competitive detectors. Arms race mirrors [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) vs. [Steganalysis](#steganalysis). SteganoGAN is already listed under [Content-Adaptive Image Steganography](#content-adaptive-image-steganography); this section focuses on the adversarial training paradigm distinct from hand-crafted distortion functions.


**Production readiness:** Experimental
Working research codebases exist (SteganoGAN); no production deployment.

**Implementations:**
- [SteganoGAN](https://github.com/DAI-Lab/SteganoGAN) ⭐ 378 — Python/PyTorch, GAN-based image steganography with 4.4 bpp capacity

**Security status:** Caution
GAN-trained schemes evade classical steganalysis but remain vulnerable to CNN-based detectors trained on the same generative distribution.

**Community acceptance:** Emerging
Active research frontier at the intersection of deep learning and steganography; growing publication volume since 2017.

---

## Histogram-Preserving Steganography

**Goal:** Embed a hidden payload in an image while leaving the global pixel or DCT-coefficient histogram statistically identical to that of the unmodified cover image, thereby defeating histogram-based steganalysis attacks (chi-square test, RS analysis) that detect steganography by measuring first-order statistical deviations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OutGuess (Provos)** | 2001 | JPEG DCT LSB + histogram correction | After embedding, selects a secondary set of DCT coefficients and flips them to restore the pre-embedding DCT histogram; first practical histogram-preserving JPEG scheme [[1]](https://dde.binghamton.edu/kodovsky/pdf/Fri07-ACM.pdf) |
| **LSB++ / LSB++ Generalisation** | 2003–2015 | Paired-pixel compensation | Extends OutGuess idea to spatial domain: every embedding change is paired with a compensating change elsewhere so the global histogram is exactly preserved; generalises to arbitrary embedding rates [[1]](https://www.researchgate.net/publication/277583196_A_new_steganography_method_which_preserves_histogram_Generalization_of_LSB) |
| **HPS (Histogram Preserving Steganography)** | 2014 | Pixel-pair mapping | Computes a bijective pixel-pair mapping that preserves the marginal histogram while minimising distortion; IEEE conference result for spatial-domain images [[1]](https://ieeexplore.ieee.org/document/6914260/) |

**State of the art:** Histogram preservation defeats first-order steganalysis but is ineffective against higher-order features (SPAM, SRM co-occurrences); modern content-adaptive schemes (S-UNIWARD, HILL) implicitly avoid histogram anomalies while minimising richer statistical signatures. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) and [Steganalysis](#steganalysis).


**Production readiness:** Experimental
Research implementations exist; superseded by content-adaptive schemes in practice.

**Implementations:**
- [OutGuess](https://github.com/crorvick/outguess) ⭐ 159 — C, JPEG steganography with histogram correction

**Security status:** Superseded
Histogram preservation defeats first-order attacks but is ineffective against higher-order steganalysis (SRM, SPAM); modern adaptive schemes provide strictly better security.

**Community acceptance:** Niche
Historically important; OutGuess was widely used in early 2000s. Superseded by S-UNIWARD and HILL in academic benchmarks.

---

## Video Steganography

**Goal:** Embed a hidden payload inside a compressed video stream (H.264/H.265, MPEG-4) by manipulating motion vectors, inter-frame DCT coefficients, or intra-prediction modes — exploiting the spatial redundancy and temporal correlation of video to achieve high-capacity covert communication that survives real-time streaming and re-encoding.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Motion Vector Steganography (Xu-Ping-Zhao)** | 2006 | MPEG motion vectors | Encodes bits in the phase angle of motion vectors while preserving magnitude; phase deviation is imperceptible to human vision; capacity ~1 bpp of motion-vector stream [[1]](https://link.springer.com/chapter/10.1007/11767752_21) |
| **MoVSteg** | 2013 | H.264 motion vector magnitude | Selects motion vectors with magnitudes above a threshold (minimises blocking artefacts); ±1 modification of horizontal/vertical components; capacity ~1 Mb/min at 30 fps; PSNR degradation < 0.1 dB [[1]](https://ieeexplore.ieee.org/document/6467700) |
| **Inter-Frame DCT Coefficient Stego** | 2010 | H.264 residual DCT | Hides bits in non-zero AC DCT coefficients of inter-coded blocks; applies ±1 quantised-coefficient modification analogous to F5; calibration attack adapted for video blocks [[1]](https://www.sciencedirect.com/science/article/abs/pii/S1047320309000583) |
| **Intra-Prediction Mode Stego (Zhang et al.)** | 2012 | H.264 intra-prediction modes | Encodes payload by switching between perceptually equivalent intra-prediction mode pairs in I-frames; robust to re-encoding within the same quantisation parameter [[1]](https://ieeexplore.ieee.org/document/6166374) |

**State of the art:** Motion-vector schemes (MoVSteg) dominate practical video steganography due to high capacity and low visual distortion; intra-prediction mode methods are more robust to re-compression. Video steganalysis leverages inter-frame correlation anomalies and motion-vector statistical models. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) (same DCT-domain techniques applied per-frame).


**Production readiness:** Experimental
Research prototypes for H.264/H.265; no production-quality open-source tool.

**Implementations:**
- [OpenStego](https://github.com/syvaidya/openstego) ⭐ 1.4k — Java, general steganography with video format support

**Security status:** Caution
Motion-vector schemes are difficult to detect visually but vulnerable to statistical models of inter-frame correlation; re-encoding can destroy payloads.

**Community acceptance:** Niche
Active research area with publications in multimedia security venues; no standardisation or widespread adoption.

---

## Steganographic File Systems

**Goal:** Provide plausible deniability at the storage layer. A steganographic file system allows the existence of hidden files to be denied under coercion: an adversary who obtains the storage medium and a low-sensitivity decryption key cannot determine whether a second, hidden file system exists.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rubberhose (Assange)** | 1997 | Multiple extent maps | Partitions a disk into independent extents each with its own key; no extent can be proved absent; each key unlocks only its own map; first working implementation of deniable disk encryption [[1]](https://web.archive.org/web/19990224063931/http://www.rubberhose.org/) |
| **StegFS (McDonald-Kuhn)** | 1999 | LSB embedding in free blocks | Hides a secondary file system in the unused blocks of an ext2 partition by treating them as a steganographic cover; shares inode pool with the overt file system; capacity equals free space [[1]](https://link.springer.com/chapter/10.1007/3-540-48519-8_9) |
| **TrueCrypt Hidden Volume** | 2004 | Dual-AES encrypted volume | Stores a hidden encrypted volume inside the free space of an outer volume; outer-volume password reveals innocuous data; inner-volume password reveals real data; widely deployed before TC discontinuation [[1]](https://www.veracrypt.fr/en/Hidden%20Volume.html) |
| **VeraCrypt Hidden Volume** | 2013 | TrueCrypt fork + Streebog | Audited successor to TrueCrypt; same dual-volume deniability; adds SHA-512/Whirlpool/Streebog KDFs and supports hidden OS partition [[1]](https://www.veracrypt.fr/en/Documentation.html) |
| **Plausibly Deniable Flash FS (Skillen-Mannan)** | 2013 | NAND wear-levelling cover | Exploits NAND block-erase log as a natural cover; embeds hidden file system data in the write-history entropy of unused flash blocks; resists forensic flash imaging [[1]](https://www.ndss-symposium.org/ndss2013/ndss-2013-programme/practical-plausibly-deniable-file-system-nand-flash/) |

**State of the art:** VeraCrypt hidden volumes are the deployed standard for deniable disk encryption; research focus has shifted to flash storage (Skillen-Mannan) due to NAND wear-levelling complicating traditional block-level deniability. Forensic adversaries may attempt to disprove deniability by comparing allocated vs. used block entropy. Related to [Deniable Encryption](#deniable-encryption) (cryptographic layer) and [Histogram-Preserving Steganography](#histogram-preserving-steganography) (statistical indistinguishability requirement).


**Production readiness:** Production
VeraCrypt hidden volumes are widely deployed; Rubberhose and StegFS are historical/discontinued.

**Implementations:**
- [VeraCrypt](https://github.com/veracrypt/VeraCrypt) ⭐ 9.4k — C/C++, hidden volume deniable disk encryption (TrueCrypt successor)
- [shufflecake](https://codeberg.org/shufflecake/shufflecake-c) — C, plausibly deniable hidden volumes for Linux

**Security status:** Caution
VeraCrypt hidden volumes are secure against casual inspection but forensic analysis of wear-levelling patterns on SSDs can compromise deniability.

**Community acceptance:** Widely trusted
VeraCrypt is the de facto standard for deniable disk encryption; independently audited (OSTIF 2016); recommended by EFF and other civil liberties organisations.

---

## Spread-Spectrum Steganography

**Goal:** Distribute a low-amplitude covert signal across many cover-medium samples (frequency bins, spatial locations, time slots) so that the energy per sample is below the noise floor and no single sample reveals the payload. Borrows directly from spread-spectrum communications; provides robustness to cropping, compression, and additive noise.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cox-Kilian-Leighton-Shamoon SS Watermark** | 1997 | Pseudo-random PN sequence | Adds a Gaussian PN sequence scaled by image-feature amplitude to DCT coefficients; detection by correlation; seminal frequency-domain spread-spectrum embedding [[1]](https://doi.org/10.1109/83.650120) |
| **Spread-Spectrum Audio Stego (Bender et al.)** | 1996 | Direct-sequence SS | Encodes each bit as a PN-spread pseudo-noise sequence added to the audio signal at amplitude below audibility threshold; chip sequence length determines capacity/robustness tradeoff [[1]](https://dl.acm.org/doi/10.1145/227726.227738) |
| **QIM-SS (Quantisation Index Modulation)** | 2001 | Dither modulation | Each cover sample is quantised to one of two shifted lattices depending on the message bit; more robust than additive SS against gain attacks; theoretical capacity equals the dirty-paper coding bound [[1]](https://doi.org/10.1109/18.910567) |
| **Informed Spread-Spectrum (Eggers-Bauml-Tzschoppe)** | 2003 | Costa dirty-paper coding | Jointly optimises embedding sequence and quantiser using knowledge of the host signal; approaches the Gel'fand-Pinsker capacity bound for watermarking channels [[1]](https://ieeexplore.ieee.org/document/1192077) |

**State of the art:** QIM and informed spread-spectrum achieve near-capacity embedding with provable robustness to amplitude scaling and additive noise; these dominate robust watermarking. For pure steganography (where robustness is less critical), adaptive content-based schemes (S-UNIWARD) outperform SS in undetectability. Related to [Digital Watermarking / Fingerprinting](#digital-watermarking--fingerprinting) (SS is the dominant watermarking paradigm) and [Audio Steganography](#audio-steganography-echo-hiding--mp3stego).


**Production readiness:** Mature
Spread-spectrum techniques underpin deployed watermarking systems (cinema, audio streaming); standalone stego tools exist.

**Implementations:**
- [invisible-watermark](https://github.com/ShieldMnt/invisible-watermark) ⭐ 1.9k — Python, spread-spectrum watermarking for images
- [pywatermark](https://github.com/fire-keeper/BlindWatermark) ⭐ 1.6k — Python, blind DWT/DCT spread-spectrum watermarking

**Security status:** Secure
QIM and informed spread-spectrum achieve near-capacity robustness; resistant to amplitude scaling, compression, and additive noise at recommended parameters.

**Community acceptance:** Widely trusted
Spread-spectrum watermarking is the dominant paradigm in the watermarking industry; Cox et al. 1997 is one of the most cited papers in the field.

---

## Printer Steganography (Machine Identification Codes)

**Goal:** Covertly identify the source printer of a document. Colour laser printers and photocopiers embed a nearly invisible pattern of microscopic yellow dots — a Machine Identification Code (MIC) — on every printed page, encoding the printer serial number and timestamp without the user's knowledge or consent.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Xerox DocuColor Yellow Dots (MIC)** | ~1990s | Cyan/yellow micro-dot grid | Encodes printer serial number and print date as a 15×8 dot matrix repeated across the page; dots are ~0.1 mm diameter in yellow ink, visible only under blue LED; confirmed on all major colour laser brands [[1]](https://w2.eff.org/Privacy/printers/docucolor/) |
| **EFF Dot Decoder** | 2005 | Reverse-engineered protocol | Electronic Frontier Foundation decoded the Xerox scheme by scanning prints at 2400 dpi under blue light; published an open decoder; established the presence of MICs on printers from Xerox, HP, Canon, and others [[1]](https://www.eff.org/pages/list-printers-which-do-or-do-not-print-tracking-dots) |
| **Randomised Tracking Dots (TU Dresden)** | 2018 | Reversed-engineered + anonymising patch | TU Dresden researchers fully decoded the tracking dot protocol and released an open anonymisation tool that overlays randomised noise to obscure printer fingerprint while leaving printout appearance unchanged [[1]](https://dud.inf.tu-dresden.de/en/forschung/aktuell/2018/tracking-dots/) |

**State of the art:** MICs are a mandatory (covert, non-consensual) steganographic channel in virtually all colour laser printers sold since the 1990s; the EFF/TU Dresden work makes the encoding public. No standards-track countermeasure exists; the TU Dresden anonymisation patch provides partial protection. Closely related to [Digital Watermarking / Fingerprinting](#digital-watermarking--fingerprinting) (origin identification) and [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) (covert channel embedded by the device manufacturer).


**Production readiness:** Production
MICs are embedded in virtually all colour laser printers sold since the 1990s; deployed covertly by manufacturers.

**Implementations:**
- [EFF Yellow Dots Decoder](https://www.eff.org/pages/list-printers-which-do-or-do-not-print-tracking-dots) — Web, EFF's list and analysis of tracking dot patterns
- [deda (TU Dresden)](https://github.com/dfd-tud/deda) ⭐ 2.4k — Python, tracking dot extraction, analysis, and anonymisation toolkit

**Security status:** Broken
The MIC encoding has been fully reverse-engineered by EFF and TU Dresden; the deda toolkit can anonymise printed pages by overwriting tracking dots.

**Community acceptance:** Controversial
MICs are a covert, non-consensual surveillance mechanism; widely criticised by privacy advocates (EFF); no public standard or oversight.

---

## Robustness, Capacity, and Imperceptibility Trade-offs

**Goal:** Formalise the fundamental limits governing steganographic and watermarking system design: given a fixed cover medium and channel, no scheme can simultaneously maximise payload capacity, perceptual imperceptibility (fidelity), and robustness to post-processing without incurring costs in at least one dimension.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Information-Hiding Capacity (Moulin-O'Sullivan)** | 2003 | Game-theoretic channel model | Models steganography and watermarking as a two-player game (embedder vs. attacker) on a Gaussian cover; derives capacity-fidelity-robustness region; establishes that capacity scales as C = ½ log(1 + D_w / σ²_n) [[1]](https://doi.org/10.1109/TIT.2002.807285) |
| **Dirty-Paper Coding Bound (Costa)** | 1983 | Gel'fand-Pinsker channel | Shows that knowing the interference (host signal) non-causally at the encoder does not reduce capacity; proves watermarking can achieve clean-channel capacity regardless of host signal power — the theoretical upper bound for informed embedding [[1]](https://doi.org/10.1109/TIT.1983.1056659) |
| **Steganographic Capacity (Ker)** | 2007 | Square-root law | In natural covers, the steganographic capacity grows as O(√n) with cover size n (not linearly); embedding more than O(√n) bits leads to statistically detectable modifications regardless of embedding method [[1]](https://doi.org/10.1117/12.696774) |
| **Distortion-Limited Stego (Filler-Judas-Fridrich)** | 2011 | STCs + syndrome coding | Syndrome-Trellis Codes achieve capacity of the additive distortion-limited steganographic channel; first practical scheme reaching the theoretical embedding efficiency bound [[1]](https://doi.org/10.1109/TIFS.2011.2134094) |

**State of the art:** Ker's square-root law governs undetectability limits; STCs (Filler-Judas-Fridrich 2011) achieve the practical capacity bound for additive distortion. Dirty-paper coding (Costa 1983) governs the robustness-capacity trade-off for watermarking. These results underpin all modern scheme design in [Content-Adaptive Image Steganography](#content-adaptive-image-steganography), [Spread-Spectrum Steganography](#spread-spectrum-steganography), and [Digital Watermarking / Fingerprinting](#digital-watermarking--fingerprinting).


**Production readiness:** Research
Theoretical frameworks and capacity bounds; STCs (Filler-Judas-Fridrich) are implemented in research codebases.

**Implementations:**
- [STC (DDE Binghamton)](http://dde.binghamton.edu/download/stego_algorithms/) — MATLAB/C++, Syndrome-Trellis Codes reference implementation

**Security status:** Secure
These are information-theoretic bounds, not attackable constructs; STCs provably achieve the optimal embedding efficiency.

**Community acceptance:** Widely trusted
Ker's square-root law and Costa's dirty-paper coding bound are universally accepted foundations; STCs are the standard practical embedding tool.

---

## Reversible Data Hiding / Lossless Steganography

**Goal:** Embed a secret payload in a cover medium (image, audio, document) such that both the payload and the original, unmodified cover can be perfectly reconstructed by an authorised receiver. Unlike conventional steganography, which accepts permanent modification of the cover, reversible data hiding is lossless: the cover is restored to its exact original state after extraction.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Lossless Generalised LSB (Fridrich-Goljan-Du)** | 2002 | LSB compression | Compresses original LSBs with a lossless codec, stores compressed bits plus payload in the freed space; first systematic lossless spatial-domain scheme; recovery is exact with no information loss [[1]](https://doi.org/10.1117/12.465440) |
| **Difference Expansion (Tian)** | 2003 | Integer Haar wavelet | Expands pixel-pair differences by 1 bit to embed message; inverse wavelet step restores exact cover values; dominant reversible scheme for the first decade [[1]](https://doi.org/10.1109/TCSVT.2003.815962) |
| **Histogram Shifting (Ni et al.)** | 2006 | Peak–zero histogram bins | Shifts pixel histogram to create a gap bin; embeds bits by nudging peak-bin pixels ±1; zero pixel distortion at the peak; capacity ~100 kbits for a 512×512 image at PSNR > 48 dB [[1]](https://doi.org/10.1109/TCSVT.2006.867544) |
| **PVO (Pixel Value Ordering)** | 2013 | Local prediction error | Exploits prediction-error expansion in sorted pixel quadruples; achieves high embedding capacity with very low distortion; state-of-the-art reversible image steganography [[1]](https://doi.org/10.1109/TIP.2013.2275005) |
| **RDH in Encrypted Images (Zhang et al.)** | 2011 | Compressible encrypted domain | Encrypts image, vacates room by compressing a subset of bits, embeds payload in vacated space; receiver can extract payload or restore plaintext independently; enables reversible stego over encrypted cloud storage [[1]](https://ieeexplore.ieee.org/document/5762603) |

**State of the art:** Histogram shifting (Ni et al. 2006) and PVO (2013) are the practical standards for unencrypted images; RDH-in-encrypted-images (Zhang 2011) is increasingly important for cloud storage scenarios. Reversible data hiding is used in medical imaging (where the original must be recoverable) and legal forensics. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) (irreversible counterpart) and [Digital Watermarking / Fingerprinting](#digital-watermarking--fingerprinting).


**Production readiness:** Mature
Used in medical imaging (DICOM), legal forensics, and military imagery; production-quality implementations exist.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Lossless recovery is mathematically guaranteed; embedding detectability follows the same trade-offs as conventional steganography.

**Community acceptance:** Niche
Important in specialised domains (medical imaging, legal forensics); active research community with dedicated journal tracks.

---

## Coverless Steganography

**Goal:** Transmit a hidden message without modifying any cover medium. Instead of embedding bits into an existing object, the sender selects an unaltered object (image, video clip, text) from a large database whose content hash, visual hash, or semantic index encodes the message. The receiver applies the same mapping to retrieve the message. Since the transmitted object is genuinely unmodified, it passes all statistical steganalysis tests.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Hash-Mapped Image Retrieval (Zhou et al.)** | 2015 | DCT hash indexing | Assigns a binary hash to each image in a repository using DCT coefficients; maps n-bit message blocks to images whose hash matches; receiver recomputes hashes to decode; first systematic coverless framework [[1]](https://arxiv.org/abs/1512.03948) |
| **SIFT-Feature Coverless Stego (Luo et al.)** | 2020 | SIFT keypoint indexing | Indexes images by counts of SIFT keypoints in defined regions; each region-count pattern encodes bits; tolerant to JPEG re-compression since SIFT features are robust to lossy transforms [[1]](https://ieeexplore.ieee.org/document/8809696) |
| **Text Coverless Stego (Chen et al.)** | 2018 | Knowledge-graph sentence retrieval | Selects genuine sentences from a news corpus whose knowledge-graph triples hash to message segments; retrieved sentences are forwarded unmodified; steganalysis cannot distinguish from ordinary news sharing [[1]](https://www.hindawi.com/journals/scn/2018/6941420/) |
| **GAN-Synthesised Coverless (Hu et al.)** | 2021 | Conditional GAN image generation | Generates a photorealistic image conditioned on a secret key and message index; image is never stored — it is generated fresh, so no carrier database is needed; defeats passive steganalysis by construction [[1]](https://ieeexplore.ieee.org/document/9364920) |

**State of the art:** Coverless steganography defeats all passive (statistical) steganalysis at the cost of requiring a shared corpus or generative model. GAN-based synthesis (2021) removes the database requirement. Active wardens that restrict which images may be transmitted can still block coverless channels. Related to [Steganalysis](#steganalysis) (the principal attack this approach evades) and [Adversarial / GAN Steganography](#adversarial--gan-steganography).


**Production readiness:** Research
Academic prototypes; GAN-based synthesis removes the database requirement but is not deployed.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Defeats all passive statistical steganalysis by construction since no cover medium is modified; active wardens (restricting transmittable content) remain a threat.

**Community acceptance:** Emerging
Growing research area since 2015; GAN-based methods (2021) have increased interest; no standardisation.

---

## Blockchain Steganography

**Goal:** Exploit the public, immutable, and globally replicated nature of blockchain ledgers (Bitcoin, Ethereum) as covert communication channels. Hidden data is embedded in transaction fields — scripts, addresses, metadata — that are indistinguishable from routine on-chain activity, while the blockchain itself serves as the cover medium and delivery mechanism.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OP_RETURN Embedding** | 2014 | Bitcoin scripting | Bitcoin's OP_RETURN opcode allows up to 80 bytes of arbitrary data per transaction output; used by Counterparty, Omni Layer, and covert channels alike; data is unspendable but permanently stored on-chain [[1]](https://bitcoin.org/en/transactions-guide#null-data) |
| **P2PKH Address Steganography** | 2013 | Pseudo-random address generation | Encodes payload in the public key hash of a Bitcoin pay-to-public-key-hash address by generating key pairs until the address bytes match the target bits; indistinguishable from a normal address to an observer [[1]](https://www.sciencedirect.com/science/article/abs/pii/S2214212619301759) |
| **Covert Communication via Ethereum Events (Li et al.)** | 2019 | Smart contract event logs | Deploys a smart contract that emits log events containing steganographic payload in event parameters; normal blockchain explorers display events as routine contract activity [[1]](https://ieeexplore.ieee.org/document/8845161) |
| **Bitcoin Script Steganography** | 2020 | Witness / unlocking script fields | Embeds data in the unlocking script or SegWit witness fields of multi-signature transactions; fields must contain valid script data but have spare entropy that is not consensus-checked [[1]](https://arxiv.org/abs/2005.09630) |

**State of the art:** OP_RETURN is the highest-capacity, simplest channel (80 bytes/tx, widely used by legitimate protocols). Script-field and address-generation methods provide higher imperceptibility at lower capacity. Blockchain steganography is resilient to censorship once confirmed, but transactions cost fees and capacity is low (~80 bytes/tx for OP_RETURN). Related to [Network / Protocol Steganography](#network--protocol-steganography) and [Blockchain & Distributed Ledger](categories/13-blockchain-distributed-ledger.md).


**Production readiness:** Experimental
OP_RETURN embedding is trivially deployable; address and script-field methods require custom tooling.

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
On-chain data is permanent and public; OP_RETURN is easily identifiable; address-generation methods provide better imperceptibility but lower capacity.

**Community acceptance:** Niche
Research interest driven by blockchain proliferation; no standardisation; used in practice by protocols like Counterparty and Omni Layer.

---

## Cloud Cache Covert Channels

**Goal:** Exfiltrate data across security boundaries in shared cloud infrastructure by exploiting microarchitectural resources (CPU last-level cache, DRAM row buffer, memory bus) that are shared between co-resident virtual machines or containers. The attacker encodes bits in cache occupancy or timing, creating a covert channel invisible to network-level monitoring.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cross-VM LLC Flush+Reload (Yarom-Falkner)** | 2014 | Last-level cache timing | Sender accesses cache sets encoding bit 1; receiver times its own accesses to detect presence/absence of cache lines; demonstrated cross-VM bandwidth of ~1.6 Mb/s on Xeon shared LLC [[1]](https://www.usenix.org/conference/usenixsecurity14/technical-sessions/presentation/yarom) |
| **Prime+Probe LLC Covert Channel** | 2015 | Cache-set occupancy | Sender primes LLC sets; receiver probes access latency; usable without shared memory pages; demonstrated on AWS EC2 between co-resident VMs [[1]](https://www.cs.tau.ac.il/~tromer/papers/cache.pdf) |
| **DRAM Row-Buffer Covert Channel (Pessl et al.)** | 2016 | DRAM row activation timing | Encodes bits in row-buffer hit/miss timing across process boundaries; achieves ~12 Mb/s; bypasses LLC isolation mechanisms such as Intel CAT [[1]](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/pessl) |
| **Memory-Bus Locking Covert Channel** | 2021 | LOCK prefix bus contention | Sender issues LOCK-prefixed instructions to saturate the memory bus; receiver measures instruction latency; demonstrated across containers on the same host at ~100 kb/s [[1]](https://arxiv.org/abs/2107.14808) |

**State of the art:** Flush+Reload and Prime+Probe are the foundational demonstrations; Intel CAT and page-deduplication disablement are the main mitigations. These channels exploit the same mechanisms as [Spectre/Meltdown](categories/17-ai-hardware-physical-security.md#hardware-side-channels--physical-attacks)-class side channels but target covert exfiltration rather than leaking secrets. Related to [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) (covert exfiltration of key material).


**Production readiness:** Research
Proof-of-concept demonstrations on real cloud infrastructure (AWS EC2); no deployable covert communication tool.

**Implementations:**
- [Mastik](https://github.com/0xADE1A1DE/Mastik) ⭐ 118 — C, microarchitectural side-channel toolkit (Flush+Reload, Prime+Probe)

**Security status:** Caution
Covert channels are demonstrably functional on real hardware; mitigations (Intel CAT, page-dedup disablement) reduce but do not eliminate the threat.

**Community acceptance:** Widely trusted
Flush+Reload (Yarom-Falkner 2014) is one of the most cited microarchitectural attack papers; the threat model is accepted by CPU vendors and cloud providers.

---

## Social Network Steganography

**Goal:** Exploit the re-encoding, normalisation, and metadata-stripping pipelines of social network platforms (Instagram, Twitter, Facebook) as a steganographic channel, or embed covert data in publicly observable profile attributes and posting patterns so that the platform's content-inspection systems cannot distinguish the covert traffic from ordinary user behaviour.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **StegoSocial (Tolosana et al.)** | 2019 | JPEG re-encoding profile | Characterises each platform's fixed re-encoding parameters (quality factor, chroma subsampling, resizing); embeds payload using a distortion function calibrated to survive that specific pipeline; decoded after platform re-compression [[1]](https://doi.org/10.1145/3335203.3335714) |
| **Social-Timing Covert Channel** | 2016 | Post-timing encoding | Sender encodes bits in inter-post delays on a public social account; receiver monitors the account's public timeline; 0/1 encoded as short/long inter-arrival gaps; undetectable by content analysis [[1]](https://doi.org/10.1145/2976749.2978381) |
| **Profile-Field Steganography** | 2021 | Unicode homoglyph substitution | Replaces visible ASCII characters in bio or username fields with lookalike Unicode codepoints (e.g., Cyrillic 'а' for Latin 'a'); bit encoding via the homoglyph choice; survives text normalisation pipelines that do not Unicode-normalise [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/boucher) |
| **Image-Sequence Steganography (Cao et al.)** | 2020 | Album-order encoding | Encodes bits in the ordering of images within a multi-photo post or album; 2^k orderings of k images carry log₂(k!) bits; no modification of image content required; a form of coverless steganography over social media [[1]](https://ieeexplore.ieee.org/document/9112185) |

**State of the art:** Pipeline-calibrated image embedding (StegoSocial) achieves the highest capacity (~0.1 bpp after re-encoding); timing and ordering channels are lower capacity but trivially evade image steganalysis. Platform defences include image transcoding, timestamp randomisation, and Unicode normalisation. Related to [Coverless Steganography](#coverless-steganography) (ordering-based methods) and [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) (pipeline-calibrated methods).


**Production readiness:** Experimental
Research prototypes calibrated to specific platforms; no general-purpose production tool.

**Implementations:**
- [stegcloak](https://github.com/KuroLabs/stegcloak) ⭐ 3.8k — JavaScript, zero-width character steganography usable in social media bios

**Security status:** Caution
Platform re-encoding destroys most image-based payloads; timing and ordering channels survive but have very low capacity.

**Community acceptance:** Niche
Active research area; publications in ACM CCS and multimedia security venues; no standardisation.

---

## Subliminal Channels in Zero-Knowledge Proofs

**Goal:** Exploit the verifier-chosen or prover-chosen randomness in interactive zero-knowledge proof protocols as a covert channel, allowing the prover (or a subverted verifier) to embed a hidden message in the proof transcript that is invisible to observers who only check the proof's validity. Distinct from [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) (which targets signature randomness); here the cover is the ZK proof itself.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Simmons ZK Subliminal Channel** | 1994 | Fiat-Shamir / Schnorr nonce | First analysis of subliminal channels in ZK identification schemes; prover embeds covert bits in the commitment randomness while the proof remains valid; capacity equals the entropy of the nonce [[1]](https://link.springer.com/chapter/10.1007/3-540-68339-9_6) |
| **Subliminal-Free ZK (Burmester-Desmedt-Piper)** | 1994 | Verifier-chosen challenges | Prevents prover subliminal channel by requiring the verifier to supply all randomness via coin-flipping; eliminates prover's ability to embed hidden messages but requires interaction [[1]](https://link.springer.com/chapter/10.1007/3-540-48658-5_7) |
| **Groth16 Subliminal Channel (Bellare-Hoang)** | 2021 | Groth16 proof randomness | Identifies subliminal bandwidth in the δ and γ randomness of Groth16 proofs; a subverted prover can leak ~256 bits of witness per proof while producing a perfectly valid SNARK; demonstrates ASA threat for non-interactive ZK systems [[1]](https://eprint.iacr.org/2021/1352) |
| **Subliminal-Free SNARKs (Faonio-Fiore-Russo)** | 2023 | Updatable CRS + randomness extraction | Constructs SNARKs where the prover's output is randomness-extractable; any subliminal channel is computationally closed by a public extractor; requires an updatable CRS (structured reference string) [[1]](https://eprint.iacr.org/2023/1029) |

**State of the art:** Non-interactive ZK systems (Groth16, PLONK) are susceptible to subliminal channels in proof randomness; mitigation requires deterministic randomness derivation (RFC 6979-style) or subliminal-free SNARK constructions. Related to [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) (same adversarial model applied to signatures) and [ZK Proof Systems](categories/04-zero-knowledge-proof-systems.md#zero-knowledge-proof-systems).


**Production readiness:** Research
Theoretical attack analysis and mitigation proposals; subliminal-free SNARK constructions are at the prototype stage.

**Implementations:**
- [snarkjs](https://github.com/iden3/snarkjs) ⭐ 2.0k — JavaScript, Groth16/PLONK prover (demonstrates the vulnerable proof system)
- [circom](https://github.com/iden3/circom) ⭐ 1.6k — Rust, ZK circuit compiler (context for subliminal channel analysis)

**Security status:** Caution
Groth16 and PLONK proofs contain exploitable subliminal bandwidth (~256 bits/proof); mitigation requires deterministic randomness or subliminal-free constructions.

**Community acceptance:** Emerging
Growing awareness in the ZK community; Bellare-Hoang 2021 analysis has prompted research into subliminal-free SNARKs.

---

## LLM-Based Linguistic Steganography

**Goal:** Use large language models (LLMs) as a cover-text generator in which each sampling step is repurposed to encode message bits, so that the generated text is statistically indistinguishable from natural LLM output while covertly carrying a hidden payload. Advances beyond classical synonym-substitution methods by leveraging the full probability distribution of the model at every token.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **METEOR (Kaptchuk-Jois-Green-Ruef)** | 2021 | Arithmetic coding over LM distribution | Treats the LLM token distribution as an entropy source; uses arithmetic coding to encode message bits losslessly into a sequence of token samples; provably undetectable under the hypothesis-testing model [[1]](https://eprint.iacr.org/2021/1162) |
| **ADG (Adaptive Dynamic Grouping)** | 2019 | Huffman-coded token grouping | Groups tokens by probability rank and assigns fixed-length codewords; sender samples from the group corresponding to the next message bits; simpler than arithmetic coding but slightly suboptimal capacity [[1]](https://aclanthology.org/P19-1422/) |
| **DISCOP** | 2023 | Distribution-copying sampling | Reformulates embedding as distribution matching: constructs a per-step mapping from message bits to tokens that preserves the marginal distribution exactly; zero KL divergence with unmodified LLM output under i.i.d. token assumption [[1]](https://arxiv.org/abs/2307.04451) |
| **Perfectly Secure Linguistic Stego (Ding et al.)** | 2023 | Min-entropy coupling + LLM | Applies minimum-entropy coupling (Cicalese-Gargano-Vaccaro) to the LLM token distribution to achieve ε = 0 KL divergence; optimal capacity equals the per-token min-entropy of the model [[1]](https://arxiv.org/abs/2310.09502) |

**State of the art:** METEOR and DISCOP are the leading provably-secure schemes; DISCOP achieves zero distributional divergence per token under i.i.d. assumptions. Practical detectability risks arise from multi-token dependencies not captured by marginal KL; n-gram and perplexity-ratio tests can distinguish some constructions. Builds on [Text / Linguistic Steganography](#text--linguistic-steganography) and [Information-Theoretic Steganography](#information-theoretic-steganography-cachin-model); related to [Steganography](#steganography) (where Meteor first appeared).


**Production readiness:** Experimental
Working research implementations exist for METEOR, ADG, and DISCOP; not deployed in production systems.

**Implementations:**
- [ADG-steganography](https://github.com/YangzlTHU/Linguistic-Steganography-and-Steganalysis) ⭐ 33 — Python, adaptive dynamic grouping for text steganography

**Security status:** Secure
DISCOP achieves zero KL divergence per token under i.i.d. assumptions; multi-token dependencies remain a theoretical detection vector.

**Community acceptance:** Emerging
Rapidly growing research area driven by LLM proliferation; publications at top venues (NeurIPS, ACL, EMNLP); no standardisation.

---

## Quantum Steganography

**Goal:** Exploit quantum communication channels — particularly those carrying quantum key distribution (QKD) traffic — to embed a hidden classical or quantum message so that an eavesdropper monitoring the channel cannot distinguish the covert communication from legitimate quantum noise or QKD error correction traffic. Provides information-theoretic covert communication when the cover channel is itself quantum.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Quantum Steganography via Entanglement (Shaw-Brun)** | 2010 | Shared entanglement + superdense coding | Alice and Bob pre-share EPR pairs; Alice encodes covert bits by choosing which Bell-state measurement to perform; the overt channel sees only apparently random QKD-like traffic; capacity = 2 covert bits per qubit transmitted [[1]](https://arxiv.org/abs/1006.1412) |
| **Quantum Error-Correcting Covert Channel (Bergou et al.)** | 2003 | Decoherence-free subspace | Hides classical bits in the decoherence-free subspace of a noisy quantum channel; the covert message is protected from decoherence by the same mechanism that protects legitimate QKD traffic; eavesdropper cannot distinguish from channel noise [[1]](https://journals.aps.org/pra/abstract/10.1103/PhysRevA.68.022337) |
| **QKD Traffic Steganography (Natori)** | 2006 | Polarisation basis exploitation | Embeds covert bits in the choice of polarisation basis during QKD sifting; the sifted-key rate is indistinguishable from normal QKD operation; capacity is limited to the sifting error rate [[1]](https://journals.jps.jp/doi/10.1143/JPSJ.75.014001) |
| **Quantum Covert Channel Capacity (Ahn-Winter)** | 2022 | Quantum channel capacity theory | Derives the quantum analogue of the Shannon covert-channel capacity; shows that the covert capacity of a quantum channel Q is O(√n) bits per n uses — the quantum square-root law — mirroring Ker's classical result [[1]](https://arxiv.org/abs/2110.12457) |

**State of the art:** Shaw-Brun (2010) is the foundational entanglement-based construction; the quantum square-root law (Ahn-Winter 2022) establishes information-theoretic limits analogous to the classical setting. Quantum steganography is largely theoretical; no deployed system exists. Related to [Information-Theoretic Steganography](#information-theoretic-steganography-cachin-model) (Cachin KL model), [Robustness, Capacity, and Imperceptibility Trade-offs](#robustness-capacity-and-imperceptibility-trade-offs) (square-root law), and [Quantum Cryptography](categories/15-quantum-cryptography.md#quantum-key-distribution-qkd).


**Production readiness:** Research
Entirely theoretical; no deployed quantum steganography system exists.

**Implementations:**
- [Qiskit](https://github.com/Qiskit/qiskit) ⭐ 7.2k — Python, IBM quantum computing SDK suitable for simulating quantum steganography protocols

**Security status:** Secure
Information-theoretic security guarantees under quantum channel models; quantum square-root law (Ahn-Winter 2022) establishes fundamental limits.

**Community acceptance:** Niche
Small research community at the intersection of quantum information and steganography; no practical deployment path in the near term.

---

## Optical and Thermal Covert Channels

**Goal:** Exfiltrate data from air-gapped or network-isolated systems by modulating physical emissions — visible light (screen brightness, LED blinking, laser reflections), near-infrared, or heat from CPU/GPU components — that can be observed by a nearby sensor outside the security perimeter. These channels bypass all network and electromagnetic shielding that does not address optical or thermal emissions.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SPEAKE(a)R / aIR-Jumper (Guri et al.)** | 2017 | Infrared LED on security cameras | Attacker malware modulates IR LEDs on IP security cameras to blink covert data; a nearby attacker reads the IR signal with a smartphone camera or dedicated sensor; demonstrated at ~20 b/s through physical walls [[1]](https://arxiv.org/abs/1709.05742) |
| **LED-it-GO (Guri et al.)** | 2017 | HDD activity LED | Malware on an air-gapped PC blinks the HDD activity LED at up to 6000 blinks/s; line-of-sight optical receiver at 10–100 m; demonstrated 4000 b/s exfiltration rate [[1]](https://arxiv.org/abs/1706.01140) |
| **Laser-Based Exfiltration (VAMPIRE / Lamphone)** | 2020 | Retroreflective surface vibration | Illuminates a nearby reflective object (e.g., a hanging bulb or plant) with a laser; a photo-diode captures microvibrations induced by acoustic signals (speech) in the room; passive, non-contact audio eavesdropping [[1]](https://www.usenix.org/conference/usenixsecurity20/presentation/nassi) |
| **HEAT (Thermal Covert Channel, Bartolini et al.)** | 2016 | CPU heat sink thermal gradient | CPU on one die encodes bits by toggling computational load; a co-located die's on-chip thermal sensor reads temperature fluctuations; demonstrated cross-core channel at ~1–10 b/s inside a single package [[1]](https://dl.acm.org/doi/10.1145/2934583.2934601) |
| **BitWhisper (Guri et al.)** | 2015 | Thermal emission between adjacent computers | Two physically adjacent computers (no shared network); sender CPU generates heat patterns by varying workload; receiver's thermal sensor decodes; 8 bits/hour over ~15 cm air gap [[1]](https://arxiv.org/abs/1503.07919) |

**State of the art:** Guri et al. (Ben-Gurion University) have systematically catalogued optical and thermal air-gap covert channels (2015–2021); LED-based channels achieve the highest rates (~4 kb/s). Countermeasures include LED covers, physical shielding, camera restrictions near sensitive hardware, and software LED-rate limiters. Related to [Cloud Cache Covert Channels](#cloud-cache-covert-channels) (microarchitectural exfiltration analogue) and [Hardware Side-Channels](categories/17-ai-hardware-physical-security.md#hardware-side-channels--physical-attacks).


**Production readiness:** Research
Proof-of-concept demonstrations by Guri et al. (Ben-Gurion University); no deployable exfiltration tool.

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
Channels are functional on real hardware but require physical proximity and line-of-sight; countermeasures (LED covers, shielding) are effective.

**Community acceptance:** Niche
Guri et al. have systematically catalogued these channels (2015-2024); accepted threat model in high-security environments (military, government).

---

## Steganographic Protocols (StegProtocol / HYDAN)

**Goal:** Embed hidden communication directly inside the bytestream of standard application-layer protocols or executable files so that the covert channel is indistinguishable from normal protocol traffic or benign software. Unlike network-header methods ([Network / Protocol Steganography](#network--protocol-steganography)), these schemes exploit semantic or syntactic redundancy at the application or binary level.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **HYDAN (El-Khalil-Keromytis)** | 2004 | x86 instruction redundancy | Hides data in the choice of functionally equivalent x86 instruction encodings (e.g., `add eax,1` vs. `sub eax,-1`); capacity ~1/110 of executable size; binary remains executable and passes all runtime tests [[1]](https://link.springer.com/chapter/10.1007/978-3-540-30191-2_8) |
| **StegProtocol (von Ahn-Hopper)** | 2004 | Computationally secure interactive stego | Defines a formal two-party steganographic protocol secure against active wardens; uses rejection sampling on the protocol message space; first protocol-level steganographic security proof [[1]](https://eprint.iacr.org/2004/033) |
| **HTTP Steganography (StegHTTP)** | 2010 | HTTP header field ordering | Encodes bits in the ordering and capitalisation of optional HTTP request headers (Accept-Encoding, User-Agent variants); ordering choices are semantically equivalent; covert channel survives proxies that do not reorder headers [[1]](https://www.semanticscholar.org/paper/HTTP-Protocol-Steganography-Bauer/b4b07ecbc1d7b78b2038ed6ce7f8c86f66a81ea8) |
| **TLS Record-Size Covert Channel** | 2018 | TLS fragmentation choices | Sender fragments application data into TLS records of sizes encoding message bits; record size is a free parameter within the TLS spec; receiver observes record boundaries; survives across TLS 1.3 implementations [[1]](https://ieeexplore.ieee.org/document/8622529) |
| **SkypeMorph / FTE (Format-Transforming Encryption)** | 2012–2013 | Protocol format mimicry | Transforms Tor traffic to mimic Skype or arbitrary protocol formats using a format grammar; the ciphertext byte distribution matches the target protocol's statistical profile; defeats DPI-based censorship [[1]](https://cacm.acm.org/research/format-transforming-encryption/) |

**State of the art:** HYDAN remains the reference binary-level steganographic scheme; FTE / SkypeMorph are deployed in censorship circumvention tools (Tor pluggable transports). StegProtocol (von Ahn-Hopper 2004) provides the foundational security definition for protocol-level steganography. Related to [Network / Protocol Steganography](#network--protocol-steganography) (transport-layer complement), [Kleptography / ASA](#kleptography--algorithm-substitution-attacks-asa) (protocol subversion), and [Deniable Encryption](#deniable-encryption) (coercion-resistant communication).


**Production readiness:** Experimental
HYDAN and FTE/SkypeMorph have working implementations; FTE is deployed in Tor pluggable transports.

**Implementations:**
- [fteproxy](https://github.com/kpdyer/fteproxy) ⭐ 155 — Python/C, Format-Transforming Encryption Tor pluggable transport

**Security status:** Caution
FTE provides cryptographic format compliance guarantees; HYDAN and HTTP stego are detectable by semantic analysis of instruction/header patterns.

**Community acceptance:** Niche
FTE is integrated into Tor's pluggable transport ecosystem; HYDAN is a well-cited academic reference; StegProtocol provides formal security definitions.

---

## VoIP Steganography

**Goal:** Exploit the real-time, loss-tolerant nature of Voice over IP protocols (RTP, RTCP, SIP) to create covert communication channels by embedding hidden data in codec payloads, unused protocol fields, or deliberately delayed packets — leveraging the fact that VoIP receivers routinely discard late or corrupted packets without raising alarms.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **LACK (Lost Audio Packets Steganography)** | 2008 | Intentionally delayed RTP packets | Replaces payload of deliberately delayed voice packets; receiver-side jitter buffer discards originals, covert receiver extracts hidden data; hybrid storage-timing channel with capacity dependent on codec rate [[1]](https://link.springer.com/article/10.1007/s11235-009-9245-y) |
| **RTP/RTCP Field Steganography (Mazurczyk-Szczypiorski)** | 2008 | Unused RTP/RTCP header fields | Exploits padding, extension, and CSRC count fields in RTP headers and unused fields in RTCP sender/receiver reports; first systematic application of header-field stego to VoIP-specific protocols [[1]](https://arxiv.org/abs/0805.2938) |
| **G.711 LSB Steganography (Huang et al.)** | 2011 | Codec payload LSB substitution | Replaces least significant bits of G.711 μ-law/A-law audio samples with covert data; exploits the codec's 8-bit quantisation; imperceptible degradation at 1 bit/sample (~8 kb/s capacity at 64 kb/s codec rate) [[1]](https://dl.acm.org/doi/10.1145/2543581.2543587) |
| **Stega-Talk** | 2015 | G.711 LSB matching | Implements LSB matching (±1 modification) rather than replacement in G.711 payloads to reduce statistical detectability; open-source VoIP steganography tool with real-time embedding/extraction [[1]](https://pmc.ncbi.nlm.nih.gov/articles/PMC7913304/) |

**State of the art:** LACK is the canonical VoIP timing-based covert channel; G.711 LSB methods are the simplest payload-based schemes. VoIP steganalysis uses sliding-window RS analysis and QIM detection on compressed speech frames. The high data rates and real-time nature of VoIP make it an attractive carrier — typical capacity ranges from 2–64 kb/s depending on codec and embedding depth. Related to [Network / Protocol Steganography](#network--protocol-steganography) (transport-layer channels) and [Audio Steganography](#audio-steganography-echo-hiding--mp3stego) (codec-domain embedding).


**Production readiness:** Experimental
Research prototypes and proof-of-concept tools; Stega-Talk is the most complete open-source implementation.

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
LSB payload schemes are detectable by sliding-window RS analysis; timing-based channels (LACK) are more resistant but lower capacity.

**Community acceptance:** Niche
Active research niche within network steganography; Mazurczyk-Szczypiorski are the principal contributors; no standardisation.

---

## Electromagnetic Emanation Covert Channels (TEMPEST)

**Goal:** Exploit the unintentional electromagnetic radiation emitted by computing equipment — displays, cables, keyboards, CPUs — to either passively eavesdrop on data being processed (side channel) or actively modulate emanations to exfiltrate data from air-gapped systems (covert channel). The classic TEMPEST threat, known since WWII and publicly described by van Eck in 1985.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Van Eck Phreaking** | 1985 | CRT electromagnetic emanation | First unclassified demonstration of remotely reconstructing a CRT display image from its EM emissions using a modified TV receiver and directional antenna at hundreds of metres; cost ~$15 in parts [[1]](https://en.wikipedia.org/wiki/Van_Eck_phreaking) |
| **TEMPEST Fonts (Kuhn)** | 2003 | Soft TEMPEST countermeasure | Designs display fonts that minimise high-frequency harmonic content in video signals; reduces emanation signal-to-noise ratio by >20 dB without hardware shielding; software-only TEMPEST countermeasure [[1]](https://www.cl.cam.ac.uk/~mgk25/pet2003-tempest.pdf) |
| **AirHopper (Guri et al.)** | 2014 | GPU-generated FM radio signal | Malware on an air-gapped computer generates controlled FM radio signals via the GPU/display cable acting as an antenna; a nearby mobile phone's FM receiver demodulates the covert data; demonstrated 60 bytes/s exfiltration [[1]](https://arxiv.org/abs/1411.0237) |
| **Deep-TEMPEST (Fernandez et al.)** | 2024 | Deep learning + HDMI EM emanation | Uses a CNN to reconstruct displayed text from HDMI cable electromagnetic emanations captured by an SDR; reduces character error rate from 90% (classical gr-tempest) to <30%; open-source implementation [[1]](https://arxiv.org/abs/2407.09717) |

**State of the art:** Deep-TEMPEST (2024) represents the modern state of the art, applying deep learning to dramatically improve eavesdropping quality on digital (HDMI) displays. AirHopper demonstrates active EM covert channel construction for air-gap exfiltration. Countermeasures include TEMPEST-rated shielding (NATO SDIP-27), TEMPEST fonts, and noise-injection techniques. Related to [Optical and Thermal Covert Channels](#optical-and-thermal-covert-channels) (alternative air-gap exfiltration) and [Cloud Cache Covert Channels](#cloud-cache-covert-channels) (microarchitectural analogue).


**Production readiness:** Mature
TEMPEST shielding is a mature military/government standard (NATO SDIP-27); offensive EM eavesdropping tools range from research PoCs to classified capabilities.

**Implementations:**
- [TempestSDR (gr-tempest)](https://github.com/martinmarinov/TempestSDR) ⭐ 1.6k — Java/C, SDR-based TEMPEST display eavesdropping
- [Deep-TEMPEST](https://github.com/emidan19/deep-tempest) ⭐ 673 — Python/PyTorch, CNN-enhanced HDMI EM eavesdropping

**Security status:** Caution
EM emanation attacks are well-established and effective at distance; TEMPEST-rated shielding mitigates but adds significant cost; Deep-TEMPEST (2024) dramatically improves digital display eavesdropping.

**Community acceptance:** Widely trusted
TEMPEST has been a recognised threat since WWII; NATO SDIP-27 and NSA TEMPEST standards govern shielding requirements; Deep-TEMPEST renewed academic interest.

---

## Air-Gap Acoustic and Ultrasonic Covert Channels

**Goal:** Exfiltrate data from air-gapped (network-isolated) computers by encoding information in acoustic or ultrasonic signals generated by hardware components — speakers, fans, hard drives, motherboard buzzers, or even LCD pixel-driving circuits — and received by a nearby microphone, smartphone, or gyroscope sensor outside the security perimeter.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Fansmitter (Guri et al.)** | 2016 | Computer fan RPM modulation | Malware controls CPU/chassis fan speed to encode bits in acoustic frequency shifts; no speakers required; receiver is a nearby smartphone microphone; demonstrated ~15 bits/min over several metres [[1]](https://www.sciencedirect.com/science/article/abs/pii/S0167404820300080) |
| **DiskFiltration (Guri et al.)** | 2016 | HDD seek-noise modulation | Encodes data in covert acoustic signals generated by controlled hard-drive seek operations; speakerless exfiltration at ~180 bits/min; effective up to 2 metres [[1]](https://arxiv.org/abs/1608.03431) |
| **GAIROSCOPE (Guri)** | 2021 | Speaker-to-gyroscope ultrasonic | Generates ultrasonic tones (19–24 kHz) from air-gapped PC speakers; smartphone MEMS gyroscope resonates at these frequencies and demodulates the signal without microphone access; bypasses mobile OS microphone permissions [[1]](https://arxiv.org/abs/2208.09764) |
| **PIXHELL (Guri)** | 2024 | LCD pixel-driving acoustic emission | Displays specially crafted pixel patterns on an air-gapped monitor to generate covert acoustic signals from the LCD's internal components ("singing pixels"); no speakers, fans, or external hardware required; received by nearby microphone [[1]](https://arxiv.org/abs/2409.04930) |

**State of the art:** Guri et al. (Ben-Gurion University) have systematically catalogued acoustic air-gap channels across all common PC components (2016–2024). GAIROSCOPE is notable for bypassing smartphone microphone restrictions. All acoustic channels are low-bandwidth (bits/min to bits/sec) but require no network connectivity. Countermeasures include acoustic shielding, fan-speed locking, SSD-only policies, and ultrasonic jamming. Related to [Optical and Thermal Covert Channels](#optical-and-thermal-covert-channels) (complementary air-gap exfiltration modalities) and [Electromagnetic Emanation Covert Channels](#electromagnetic-emanation-covert-channels-tempest) (EM-based air-gap channels).


**Production readiness:** Research
Proof-of-concept demonstrations by Guri et al.; no deployable tool for operational use.

**Implementations:**
- [GAIROSCOPE](https://arxiv.org/abs/2208.09764) — Paper with experimental setup details

**Security status:** Caution
Channels are low-bandwidth (bits/min to bits/sec) and require physical proximity; effective in targeted attacks but impractical for bulk exfiltration.

**Community acceptance:** Niche
Guri et al. (Ben-Gurion University) are the dominant research group; threat model accepted in high-security facility design.

---

## GPU Covert Channels

**Goal:** Exploit shared microarchitectural resources within GPUs — L2 caches, DRAM, interconnects (NVLink), and uncore components — to create covert communication channels between co-resident workloads on multi-tenant GPU infrastructure, bypassing process isolation, container boundaries, and even NVIDIA MIG (Multi-Instance GPU) hardware partitioning.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **GPU Cache Covert Channel (Naghibijouybari et al.)** | 2017 | GPU L2 cache contention | Reverse-engineers GPU cache hierarchy; uses Prime+Probe on GPU L2 cache sets to create a cross-process covert channel; demonstrated on NVIDIA GPUs at ~4 MB/s bandwidth [[1]](https://dl.acm.org/doi/10.1145/3133956.3134049) |
| **Spy in the GPU-box (Dutta et al.)** | 2023 | Cross-GPU L2 cache contention | Demonstrates covert channels across physically separate GPUs in a multi-GPU system; attacker on one GPU causes measurable contention on another GPU's L2 cache; achieved 3.95 MB/s covert bandwidth [[1]](https://dl.acm.org/doi/abs/10.1145/3579371.3589080) |
| **NVBleed (2025)** | 2025 | NVLink interconnect leakage | Exploits NVLink communication patterns between GPUs; reverse-engineers inter-GPU traffic to identify contention-based timing delays and leaky NVLink performance counters as covert channel vectors; works across separate VMs [[1]](https://arxiv.org/abs/2503.17847) |
| **Veiled Pathways (Miao et al.)** | 2024 | GPU uncore (NVENC/NVDEC/DRAM freq) | Identifies four novel leakage sources in GPU uncore: DRAM frequency scaling, NVENC utilisation, NVDEC utilisation, and NVJPEG utilisation; bypasses NVIDIA MIG hardware isolation on server GPUs [[1]](https://faculty.ist.psu.edu/wu/papers/Veiled-Pathways.pdf) |

**State of the art:** GPU covert channels are a rapidly emerging threat in cloud ML infrastructure where multiple tenants share GPU nodes. NVBleed (2025) and Veiled Pathways (2024) demonstrate that even hardware-level isolation (MIG) is insufficient. Mitigations include temporal partitioning of GPU resources and disabling performance counters. Related to [Cloud Cache Covert Channels](#cloud-cache-covert-channels) (CPU-side analogue) and [Optical and Thermal Covert Channels](#optical-and-thermal-covert-channels) (alternative exfiltration from GPU-equipped systems).


**Production readiness:** Research
Academic proof-of-concept demonstrations on NVIDIA GPUs; no production exfiltration tool.

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
Demonstrated on real multi-tenant GPU infrastructure; NVIDIA MIG is insufficient (Veiled Pathways 2024); temporal partitioning is the primary mitigation.

**Community acceptance:** Emerging
Rapidly growing concern in cloud ML security; NVBleed (2025) and Veiled Pathways (2024) published at top security venues.

---

## Transient Execution Covert Channels

**Goal:** Exploit speculative and out-of-order execution in modern CPUs to create covert channels that transmit data through microarchitectural state changes (cache occupancy, branch predictor state, TLB entries) caused by transiently executed instructions whose architectural effects are rolled back. These channels underpin Spectre-class attacks and enable cross-process, cross-VM, and cross-privilege-level data exfiltration.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Spectre v1 (Kocher et al.)** | 2018 | Branch prediction + cache timing | Mistrains branch predictor to speculatively access victim memory; transient load brings secret into cache; attacker recovers via Flush+Reload; affects virtually all modern CPUs (Intel, AMD, ARM) [[1]](https://spectreattack.com/spectre.pdf) |
| **Meltdown (Lipp et al.)** | 2018 | Out-of-order execution + cache | Exploits out-of-order execution to read kernel memory from user space; transient instruction accesses privileged data before permission check completes; secret encoded in cache state [[1]](https://meltdownattack.com/meltdown.pdf) |
| **SMoTherSpectre (Bhattacharyya et al.)** | 2019 | Port contention side channel | Uses execution-port contention rather than cache as the covert channel for transient execution; sender and receiver share an execution port; demonstrated cross-SMT-thread covert channel at ~1.2 kb/s [[1]](https://dl.acm.org/doi/10.1145/3319535.3363194) |
| **Spectre-BHB / Branch History Injection** | 2022 | Branch history buffer poisoning | Bypasses hardware Spectre mitigations (eIBRS, CSV2) by injecting attacker-controlled entries into the branch history buffer; demonstrates that hardware fixes remain insufficient; affects Intel and ARM processors [[1]](https://www.vusec.net/projects/bhi-spectre-bhb/) |

**State of the art:** Transient execution covert channels are a fundamental limitation of speculative CPUs; hardware mitigations (retpolines, eIBRS, STIBP) impose significant performance overhead and remain bypassable (Spectre-BHB 2022). The covert channel bandwidth ranges from kb/s to MB/s depending on the microarchitectural vector. Related to [Cloud Cache Covert Channels](#cloud-cache-covert-channels) (cache-based channels used as the encoding mechanism) and [GPU Covert Channels](#gpu-covert-channels) (analogous microarchitectural exploitation on accelerators).


**Production readiness:** Research
Attack demonstrations on commodity CPUs; mitigations are deployed in production OSes and microcode but the fundamental vulnerability persists.

**Implementations:**
- [spectre-meltdown-checker](https://github.com/speed47/spectre-meltdown-checker) ⭐ 3.9k — Shell, system vulnerability checker for Spectre/Meltdown
- [safeside](https://github.com/google/safeside) ⭐ 506 — C++, Google's collection of transient execution attack demonstrations
- [transient.fail](https://transient.fail/) — Web, comprehensive transient execution attack database

**Security status:** Broken
Spectre-class attacks affect virtually all modern CPUs; hardware mitigations (eIBRS, STIBP) are repeatedly bypassed (Spectre-BHB 2022); fundamental limitation of speculative execution.

**Community acceptance:** Standard
Spectre and Meltdown are among the most impactful security discoveries ever; CVEs assigned; mitigations standardised in OS kernels and CPU microcode by Intel, AMD, and ARM.

---

## Power-Line Covert Channels

**Goal:** Exfiltrate data from air-gapped computers by encoding information in deliberate fluctuations of the system's electrical power consumption, which propagate through AC power lines and can be measured by an attacker with a current sensor attached to the power outlet or electrical panel — bypassing all network, electromagnetic, and acoustic isolation.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **PowerHammer (Guri et al.)** | 2018 | CPU workload → current modulation | Malware modulates CPU utilisation to encode bits in power consumption fluctuations; attacker reads current variations on the power line using a non-invasive current clamp; line-level attack achieves ~1000 bits/s; phase-level (main panel) achieves ~10 bits/s [[1]](https://arxiv.org/abs/1804.04014) |
| **POWER-SUPPLaY (Guri)** | 2020 | PSU acoustic + power-line dual channel | Exploits the switching frequency of the computer's power supply unit to simultaneously create an acoustic emanation and a conducted emission on the power line; dual-modality covert channel; demonstrated at ~50 bits/s [[1]](https://eprint.iacr.org/2020/516.pdf) |
| **PowerBridge (Guri)** | 2024 | Smart plug power-line infiltration | Uses a compromised smart plug as a bidirectional covert channel relay; malware on the air-gapped computer modulates power consumption, smart plug measures it and relays to the attacker over Wi-Fi; also enables infiltration (commands sent via power toggling) [[1]](https://www.mdpi.com/2076-3417/14/14/6321) |

**State of the art:** PowerHammer (2018) is the foundational power-line exfiltration scheme; PowerBridge (2024) extends the threat to smart-home infrastructure. Countermeasures include power-line noise injection, UPS isolation, and monitoring for anomalous CPU utilisation patterns. Related to [Air-Gap Acoustic and Ultrasonic Covert Channels](#air-gap-acoustic-and-ultrasonic-covert-channels) (complementary air-gap exfiltration) and [Optical and Thermal Covert Channels](#optical-and-thermal-covert-channels) (alternative physical-layer channels).


**Production readiness:** Research
Proof-of-concept demonstrations by Guri et al.; no operational exfiltration tool.

**Implementations:**
- [PowerHammer PoC](https://arxiv.org/abs/1804.04014) — Paper with detailed experimental methodology

**Security status:** Caution
Channels are functional but low-bandwidth; power-line noise injection and UPS isolation are effective countermeasures.

**Community acceptance:** Niche
Part of Guri et al.'s systematic air-gap exfiltration research programme; accepted threat in high-security facility design.

---

## Domain Fronting

**Goal:** Circumvent Internet censorship by exploiting the architecture of content delivery networks (CDNs) and HTTPS encryption to disguise the true destination of a network connection. The censor sees a TLS connection to an innocuous, high-collateral-damage domain (e.g., google.com), while the actual HTTP request is routed to a censored destination — creating a covert channel inside legitimate HTTPS traffic.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Domain Fronting (Fifield et al.)** | 2015 | TLS SNI / HTTP Host mismatch | Places an allowed domain in the DNS query and TLS SNI extension while placing the true (censored) destination in the encrypted HTTP Host header; CDN edge server routes the request to the real destination; censor must block the entire CDN to block the channel [[1]](https://www.bamsoftware.com/papers/fronting/) |
| **meek (Tor Pluggable Transport)** | 2014 | Domain fronting via cloud CDN | Implements domain fronting as a Tor pluggable transport; routes Tor traffic through Google App Engine, Amazon CloudFront, or Azure CDN; deployed at scale for censorship circumvention in China and Iran [[1]](https://trac.torproject.org/projects/tor/wiki/doc/meek) |
| **Encrypted Client Hello (ECH)** | 2023 | TLS 1.3 extension | Encrypts the TLS Client Hello (including SNI) using a key published in DNS; prevents censors from observing the destination domain even at the TLS layer; IETF draft standard; deployed by Cloudflare [[1]](https://datatracker.ietf.org/doc/draft-ietf-tls-esni/) |
| **Domain Shadowing (Wei et al.)** | 2021 | Compromised CDN subdomain | Attacker registers subdomains under a legitimate CDN customer's domain; covert traffic to attacker-controlled subdomains inherits the parent domain's CDN certificate and reputation; harder to detect than standard domain fronting [[1]](https://www.usenix.org/system/files/sec21-wei.pdf) |

**State of the art:** Classic domain fronting was disabled by major CDN providers (Google, Amazon) in 2018, but ECH (2023) provides a standards-track replacement that encrypts the entire Client Hello. meek remains deployed as a Tor pluggable transport. Domain shadowing (2021) extends the technique to compromised subdomains. Related to [Steganographic Protocols](#steganographic-protocols-stegprotocol--hydan) (protocol-level covert channels) and [Network / Protocol Steganography](#network--protocol-steganography) (network-layer hiding).


**Production readiness:** Deprecated
Classic domain fronting was disabled by major CDN providers (Google, Amazon) in 2018; ECH (2023) provides a standards-track replacement.

**Implementations:**
- [meek (Tor)](https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/meek) — Go, Tor pluggable transport using domain fronting

**Security status:** Superseded
Classic domain fronting is blocked by major CDNs; ECH provides stronger guarantees by encrypting the entire Client Hello; domain shadowing remains a threat.

**Community acceptance:** Widely trusted
Foundational censorship circumvention technique; meek is deployed in Tor; ECH is an IETF draft standard deployed by Cloudflare.

---

## Font and Glyph Steganography

**Goal:** Embed hidden data in text documents by imperceptibly perturbing the shapes (glyphs) of typeset characters or by manipulating font metadata, so that the document appears visually identical to a human reader but encodes a covert payload recoverable by machine analysis — surviving printing, scanning, and format conversion.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **Line/Word Shifting (Brassil et al.)** | 1995 | Microadjustment of line/word spacing | Shifts lines vertically or words horizontally by sub-pixel amounts to encode bits; one of the earliest document steganography methods; survives photocopying; ~1 bit per line or word [[1]](https://doi.org/10.1109/JPROC.1999.771070) |
| **FontCode (Xiao et al.)** | 2018 | Glyph perturbation on font manifold | Perturbs glyph shapes along a learned font manifold using a generative model; each character encodes bits via its position on the manifold; recoverable from vector graphics, pixel images, and even print-scan; error-correction coded; ~1.6 bits/character [[1]](https://dl.acm.org/doi/10.1145/3152823) |
| **Homoglyph Substitution Steganography** | 2010s | Unicode lookalike codepoints | Replaces Latin characters with visually identical Unicode homoglyphs (e.g., Cyrillic 'а' U+0430 for Latin 'a' U+0061); encoding is invisible to the human eye; capacity ~1 bit per replaceable character; detectable by Unicode normalisation [[1]](https://www.usenix.org/conference/usenixsecurity21/presentation/boucher) |
| **FontGuard (2025)** | 2025 | Deep font watermarking | Uses deep learning to embed imperceptible watermarks in font glyph outlines; robust to rasterisation, anti-aliasing, and format conversion; designed for font IP protection and document provenance [[1]](https://www.researchgate.net/publication/390545447_FontGuard_A_Robust_Font_Watermarking_Approach_Leveraging_Deep_Font_Knowledge) |

**State of the art:** FontCode (2018) is the most capable glyph-perturbation scheme, surviving print-scan cycles with error correction. Homoglyph methods are trivially deployed but defeated by Unicode normalisation. FontGuard (2025) extends glyph-level watermarking with deep learning robustness. Related to [Text / Linguistic Steganography](#text--linguistic-steganography) (semantic-level text hiding), [Digital Watermarking / Fingerprinting](#digital-watermarking--fingerprinting) (document provenance), and [Printer Steganography](#printer-steganography-machine-identification-codes) (physical document tracking).


**Production readiness:** Experimental
FontCode has a research implementation; homoglyph tools are readily available; FontGuard (2025) is a research prototype.

**Implementations:**
- [confusables (homoglyph detection)](https://github.com/vhf/confusable_homoglyphs) ⭐ 165 — Python, Unicode homoglyph detection and substitution library

**Security status:** Caution
Homoglyph methods are trivially defeated by Unicode normalisation; FontCode survives print-scan with error correction; FontGuard adds deep-learning robustness.

**Community acceptance:** Niche
Small research community; FontCode (ACM SIGGRAPH 2018) is the most cited glyph steganography work.

---

## QUIC Protocol Steganography

**Goal:** Exploit the design features of the QUIC transport protocol — encrypted headers, variable-length Connection IDs, connection migration, padding frames, and the RETRY token mechanism — to create covert channels that are invisible to network middleboxes, since QUIC encrypts nearly all header fields beyond the first byte.

| Algorithm | Year | Type/Basis | Note |
|-----------|------|------------|------|
| **QUIC Connection ID Covert Channel (QuiCC)** | 2022 | Connection ID field manipulation | Encodes covert data in the variable-length Connection ID (CID) field of QUIC packets; CIDs are opaque to the network and chosen freely by endpoints; capacity scales with CID length (up to 20 bytes per packet) [[1]](https://github.com/nuvious/QuiCC) |
| **QUIC Covert Channel Taxonomy (Mileva et al.)** | 2023 | Systematic protocol analysis | Identifies 20 novel covert channels in QUIC exploiting header fields, frame types, padding, ACK ranges, and connection migration; analyses transmission rate, undetectability, and robustness for each; first comprehensive QUIC stego taxonomy [[1]](https://lib.jucs.org/article/154672/download/pdf/) |
| **QuicCourier** | 2025 | QUIC packet padding manipulation | Creates a covert channel by appending secret data as padding at the end of QUIC packets or within packet payloads via a proxy node; leverages QUIC's encrypted transport to hide the padding from DPI; evaluated on real web-browsing traffic [[1]](https://www.computer.org/csdl/journal/tq/2025/05/10916752/24TAwn09eRq) |
| **QUIC-Exfil** | 2025 | Server Preferred Address abuse | Exploits QUIC's Server Preferred Address feature to redirect connections to attacker-controlled endpoints for data exfiltration; the migration appears as legitimate connection migration to middleboxes [[1]](https://arxiv.org/abs/2505.05292) |

**State of the art:** QUIC's encryption-by-default design makes it inherently more hospitable to covert channels than TCP/TLS. Mileva et al. (2023) provide the definitive taxonomy of 20 QUIC covert channel vectors. QuicCourier and QUIC-Exfil (2025) demonstrate practical exploitation. Countermeasures are limited since QUIC's encrypted headers are opaque to middleboxes by design. Related to [Network / Protocol Steganography](#network--protocol-steganography) (TCP/IP-layer channels), [Steganographic Protocols](#steganographic-protocols-stegprotocol--hydan) (application-layer protocol hiding), and [Domain Fronting](#domain-fronting) (encrypted-transport censorship circumvention).


**Production readiness:** Experimental
QuiCC and QuicCourier have proof-of-concept implementations; QUIC's design inherently enables covert channels.

**Implementations:**
- [QuiCC](https://github.com/nuvious/QuiCC) ⭐ 8 — Python, QUIC Connection ID covert channel tool

**Security status:** Caution
QUIC's encrypted headers make covert channels difficult to detect; countermeasures are limited since middlebox inspection is blocked by design.

**Community acceptance:** Emerging
Growing research area as QUIC adoption increases; Mileva et al. (2023) provide the first comprehensive taxonomy of 20 QUIC covert channel vectors.

---

## Chaffing and Winnowing

**Goal:** Achieve message confidentiality without any encryption by interleaving authentic MAC-verified packets (wheat) with random fake packets (chaff), so only the MAC-keyholder can separate signal from noise.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Rivest chaffing and winnowing** | 1998 | MAC authentication only | Zero encryption; relay can add chaff without knowing MAC key or content; MIT [[1]](https://people.csail.mit.edu/rivest/pubs/Riv98a.pdf) |

**State of the art:** Demonstrates that confidentiality does not require encryption as legally defined — a live policy argument against key escrow mandates. Rare example of a covert channel a non-colluding relay can activate.


**Production readiness:** Research
Rivest's 1998 paper describes the concept; no widely used production implementation.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Confidentiality guarantee relies solely on MAC authentication; no encryption is used, so security reduces to the MAC scheme's unforgeability.

**Community acceptance:** Niche
Important theoretical contribution to the encryption export control debate; cited in cryptography policy discussions; not widely deployed.

---

## Format-Transforming Encryption (FTE)

**Goal:** Encrypt traffic so the ciphertext provably belongs to a user-specified regular language (e.g., valid HTTP GET requests), defeating protocol-classification-based deep packet inspection.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **FTE (Dyer-Coull-Ristenpart-Shrimpton)** | 2013 | DFA-based format enforcement | Cryptographic guarantee of format compliance; integrated into Tor's fteproxy; CCS 2013 [[1]](https://kpdyer.com/publications/ccs2013-fte.pdf) |

**State of the art:** Demonstrated live bypass of the Great Firewall of China. Unlike statistical mimicry, FTE provides a cryptographic guarantee that output conforms to the target format. Any format describable by a regular expression can serve as a carrier.


**Production readiness:** Production
Deployed as fteproxy in Tor's pluggable transport ecosystem; demonstrated live bypass of the Great Firewall of China.

**Implementations:**
- [fteproxy](https://github.com/kpdyer/fteproxy) ⭐ 155 — Python/C, Tor pluggable transport implementing FTE
- [libfte](https://github.com/kpdyer/libfte) ⭐ 18 — C++, core FTE library with DFA-based format enforcement

**Security status:** Secure
Provides a cryptographic guarantee that output conforms to the target regular-language format; any format describable by a regex can serve as a carrier.

**Community acceptance:** Widely trusted
Published at ACM CCS 2013; integrated into Tor; proven effective against real-world DPI systems including the Great Firewall of China.

---

## Snowflake (WebRTC-Based Pluggable Transport)

**Goal:** Route censored users' Tor traffic through ephemeral, volunteer browser-based WebRTC proxies, making the proxy population too large, transient, and distributed to enumerate and block.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Snowflake (Tor Project)** | 2021 | WebRTC + STUN/CDN signaling | Moving-target proxy model; USENIX Security 2024 formal analysis [[1]](https://www.usenix.org/conference/usenixsecurity24/presentation/bocovich) |

**State of the art:** Dominant circumvention tool in Russia (2021+) and Iran (2022+), reaching hundreds of thousands of daily users. Attacks the fundamental weakness of fixed-proxy circumvention by making proxies appear and disappear constantly.


**Production readiness:** Production
Deployed at scale by the Tor Project; hundreds of thousands of daily users in Russia and Iran.

**Implementations:**
- [snowflake](https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake) — Go, Tor Project's official Snowflake implementation
- [snowflake-webext](https://addons.mozilla.org/en-US/firefox/addon/torproject-snowflake/) — JavaScript, browser extension to volunteer as a Snowflake proxy

**Security status:** Secure
Moving-target proxy model makes enumeration and blocking impractical; WebRTC traffic blends with legitimate video conferencing.

**Community acceptance:** Widely trusted
Official Tor Project tool; formal analysis at USENIX Security 2024; dominant circumvention tool in Russia (2021+) and Iran (2022+).

---

## Neural Linguistic Steganography (LLM-Based)

**Goal:** Encode secret bitstrings by sampling tokens from a language model according to arithmetic/Huffman coding that maps secret bits to probability-weighted vocabulary choices, producing fluent cover text statistically indistinguishable from natural LLM output.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Ziegler et al.** | 2019 | Arithmetic coding over GPT-2 | Several bits per token while maintaining fluency; EMNLP 2019 [[1]](https://aclanthology.org/D19-1115/) |
| **Zero-shot generative** | 2024 | No shared model needed | Requires only knowledge of model identity; arXiv 2024 [[1]](https://arxiv.org/abs/2403.10856) |

**State of the art:** The active research frontier for covert communication in censored environments. Classical linguistic steganography is detectable; neural approaches leverage the LLM's own probability distribution as the encoding alphabet.


**Production readiness:** Experimental
Research implementations exist; not deployed in production systems.

**Implementations:**
No notable open-source implementations available.

**Security status:** Caution
Provably undetectable under marginal distribution assumptions; multi-token statistical tests may distinguish from natural text.

**Community acceptance:** Emerging
Active research frontier; builds on LLM proliferation; publications at EMNLP and arXiv.

---

## Spread-Spectrum Watermarking

**Goal:** Embed a watermark as a pseudo-random noise pattern spread across perceptually significant spectral coefficients, achieving robustness to compression, filtering, and geometric transforms while remaining imperceptible.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Cox-Kilian-Leighton-Shamoon** | 1997 | DCT-domain spread spectrum | Dominant paradigm for robust IP watermarking; IEEE Trans. Image Process. [[1]](https://ieeexplore.ieee.org/document/650120/) |

**State of the art:** Powers cinema forensic watermarking (unique per theater print), audio watermarking in streaming services, and satellite broadcast forensics. Distinct from fragile watermarking and from steganography — the watermark's existence is often public.


**Production readiness:** Production
Deployed in cinema forensic watermarking (DCI), streaming audio fingerprinting, and satellite broadcast forensics.

**Implementations:**
- [invisible-watermark](https://github.com/ShieldMnt/invisible-watermark) ⭐ 1.9k — Python, spread-spectrum image watermarking
- [AudioWmark](https://github.com/swesterfeld/audiowmark) ⭐ 536 — C++, robust audio watermarking using spread-spectrum techniques

**Security status:** Secure
Robust to compression, filtering, and geometric transforms at recommended parameters; correlation-based detection is well-understood.

**Community acceptance:** Standard
Cox et al. 1997 is the foundational work; spread-spectrum watermarking is standardised in cinema (DCI) and used by major streaming platforms.

---

## Reversible Data Hiding (RDH)

**Goal:** Embed auxiliary data in a carrier (image, medical scan, legal document) such that the original carrier can be perfectly and losslessly reconstructed after extraction.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Tian difference expansion** | 2003 | Integer difference expansion | First practical RDH for images; lossless recovery [[1]](https://doi.org/10.1109/LSP.2003.811589) |
| **Ni et al. histogram shifting** | 2006 | Pixel histogram manipulation | Higher capacity with minimal distortion [[1]](https://doi.org/10.1109/TCSVT.2006.873168) |
| **Encrypted-domain RDH** | 2025 | Homomorphic embedding | Embed metadata in encrypted images without decryption; Nature Scientific Reports [[1]](https://www.nature.com/articles/s41598-025-95433-9) |

**State of the art:** Legally/medically required for DICOM radiological images, court-admitted photographs, and military imagery where pixel-level fidelity is a diagnostic/legal requirement. Authentication metadata travels with the file, gets verified, then is completely removed.


**Production readiness:** Production
Required for DICOM medical images, court-admitted photographs, and military imagery where pixel-level fidelity is mandatory.

**Implementations:**
No notable open-source implementations available.

**Security status:** Secure
Lossless recovery is mathematically guaranteed; encrypted-domain RDH (2025) enables embedding without decryption.

**Community acceptance:** Niche
Legally and medically mandated in specific domains; active research community; Tian (2003) and Ni et al. (2006) are the foundational references.

---
