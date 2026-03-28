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

## Audio Steganography (Echo Hiding & MP3Stego)

**Goal:** Conceal a secret bitstream inside an audio signal — either by exploiting psychoacoustic masking effects (echo hiding) or by embedding data during the lossy compression process (MP3Stego) — so that the resulting audio is perceptually indistinguishable from the original.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **Echo Hiding (Gruhl-Lu-Bender)** | 1996 | Psychoacoustic echo | Embed bits by adding a delayed, attenuated echo kernel to the audio; kernel parameters (delay, amplitude, decay) encode 0/1; cepstrum analysis recovers the hidden signal [[1]](https://link.springer.com/content/pdf/10.1007/3-540-61996-8_48.pdf) |
| **MP3Stego (Petitcolas)** | 1998 | MPEG-III bit reservoir | Hides data during the MP3 encoding loop by exploiting the unused bits of the inner loop's bit reservoir; payload is 3DES-encrypted before embedding; capacity ~-1 bit/frame at 128 kbps [[1]](https://www.petitcolas.net/steganography/mp3stego/) |
| **Phase Coding** | 1996 | Phase manipulation | Encodes message bits in phase differences between audio segments; exploits the ear's relative phase insensitivity; more robust to re-encoding than LSB substitution [[1]](https://link.springer.com/article/10.1186/1687-4722-2012-25) |

**State of the art:** Echo hiding is the canonical psychoacoustic audio steganography scheme; MP3Stego remains the reference implementation for compressed-domain audio stego. Audio steganalysis relies on cepstral analysis (echo detection) and statistical modeling of MP3 bit-reservoir distributions. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) (same adaptive-distortion philosophy, different medium).

---

## Text / Linguistic Steganography

**Goal:** Hide a secret message inside ordinary-looking natural-language text or formatted documents by exploiting invisible formatting (trailing whitespace, zero-width characters) or semantic transformations (synonym substitution, paraphrase generation) that leave the surface meaning unchanged to a human reader.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **SNOW (Whitespace Steganography)** | 1998 | Trailing whitespace encoding | Appends sequences of spaces and tabs at line endings; invisible in all common text viewers; ICE encryption of payload; capacity ~1 bit per line [[1]](https://darkside.com.au/snow/) |
| **Synonym Substitution (Chang-Clark)** | 2014 | Contextual lexical graph | Assigns bits to synonym sets via vertex colouring on a WordNet graph; uses Google n-grams to verify contextual fluency; state-of-the-art capacity/undetectability tradeoff for linguistic stego [[1]](https://direct.mit.edu/coli/article/40/2/403/1470/Practical-Linguistic-Steganography-using) |
| **Zero-Width Character Stego** | 2010s | Unicode invisible codepoints | Encodes bits in sequences of zero-width non-joiner (U+200C) and zero-width joiner (U+200D) inserted between characters; survives copy-paste; resists visual inspection [[1]](https://www.sciencedirect.com/science/article/abs/pii/S002002552200809X) |

**State of the art:** Whitespace and zero-width character methods are trivially stripped by normalisation; synonym substitution (Chang-Clark 2014) and LLM-based paraphrase methods (see [Meteor](#steganography)) provide higher security. Text steganalysis relies on perplexity-based and n-gram distributional tests. Related to [Steganography](#steganography) and [Meteor (LLM Stego)](#steganography).

---

## DNA Steganography

**Goal:** Hide a secret message physically inside a DNA molecule so that the very existence of the message is concealed — the DNA appears to be ordinary biological material. Provides long-term, high-density, and chemically durable covert storage inaccessible to electronic eavesdroppers.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **DNA Microdot (Clelland-Risca-Bancroft)** | 1999 | Nucleotide-to-ASCII encoding | Encodes each ASCII character as a DNA triplet using a key-dependent codon table; synthesises the DNA oligomer; conceals it in a microdot disguised as a printed full stop; first experimental demonstration [[1]](https://www.nature.com/articles/21092) |
| **SNP-Based Genomic Stego** | 2020 | Single nucleotide polymorphisms | Encodes message bits into predefined SNP loci of a host genome sequence; the stego-genome passes as a normal sequencing result; includes block-sum error detection for mutation-induced bit-flips [[1]](https://microbialcellfactories.biomedcentral.com/articles/10.1186/s12934-020-01387-0) |

**State of the art:** Clelland-Risca-Bancroft (1999, Nature) is the seminal physical demonstration; SNP-based methods (2020) scale to whole-genome carriers. DNA steganography offers extraordinary density (~1 exabyte/gram) but requires wet-lab synthesis and sequencing for encode/decode. Largely orthogonal to digital steganography; no established steganalysis countermeasure exists beyond targeted sequence-pattern search. Related to [Information-Theoretic Steganography](#information-theoretic-steganography-cachin-model).

---

## Adversarial / GAN Steganography

**Goal:** Use deep learning — specifically generative adversarial networks (GANs) — to jointly learn a steganographic encoder and a steganographic decoder end-to-end, with the GAN discriminator acting as an automatic steganalyser during training, so that the resulting hidden-message images minimise detectability without hand-crafted distortion metrics.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **ste-GAN-ography (Hayes-Danezis)** | 2017 | Three-party GAN (Alice / Bob / Eve) | First adversarially trained steganography; Alice (encoder) and Bob (decoder) play against Eve (steganalyser); all three are CNNs; matches hand-crafted adaptive schemes in detectability while learning in an unsupervised manner [[1]](https://arxiv.org/abs/1703.00371) |
| **SSGAN (Shi et al.)** | 2017 | Wasserstein GAN + GNCNN discriminator | Replaces DCGAN with WGAN for training stability; adds a noise-guessing CNN discriminator; improves visual quality over SGAN [[1]](https://link.springer.com/article/10.1007/s11042-018-6951-z) |
| **SteganoGAN** | 2019 | Dense encoder-decoder + GAN | Achieves 4.4 bpp capacity in natural images; GAN discriminator enforces perceptual indistinguishability; evades standard steganalysers (SRM, Xu-Net) at moderate payloads [[1]](https://arxiv.org/abs/1901.03892) |

**State of the art:** Hayes-Danezis (NeurIPS 2017) established adversarial training as a viable steganography design methodology; SteganoGAN (2019) achieves highest reported bpp. CNN-based steganalysers (SRNet, Yedroudj-Net) remain competitive detectors. Arms race mirrors [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) vs. [Steganalysis](#steganalysis). SteganoGAN is already listed under [Content-Adaptive Image Steganography](#content-adaptive-image-steganography); this section focuses on the adversarial training paradigm distinct from hand-crafted distortion functions.

---

## Histogram-Preserving Steganography

**Goal:** Embed a hidden payload in an image while leaving the global pixel or DCT-coefficient histogram statistically identical to that of the unmodified cover image, thereby defeating histogram-based steganalysis attacks (chi-square test, RS analysis) that detect steganography by measuring first-order statistical deviations.

| Scheme | Year | Basis | Note |
|--------|------|-------|------|
| **OutGuess (Provos)** | 2001 | JPEG DCT LSB + histogram correction | After embedding, selects a secondary set of DCT coefficients and flips them to restore the pre-embedding DCT histogram; first practical histogram-preserving JPEG scheme [[1]](https://dde.binghamton.edu/kodovsky/pdf/Fri07-ACM.pdf) |
| **LSB++ / LSB++ Generalisation** | 2003–2015 | Paired-pixel compensation | Extends OutGuess idea to spatial domain: every embedding change is paired with a compensating change elsewhere so the global histogram is exactly preserved; generalises to arbitrary embedding rates [[1]](https://www.researchgate.net/publication/277583196_A_new_steganography_method_which_preserves_histogram_Generalization_of_LSB) |
| **HPS (Histogram Preserving Steganography)** | 2014 | Pixel-pair mapping | Computes a bijective pixel-pair mapping that preserves the marginal histogram while minimising distortion; IEEE conference result for spatial-domain images [[1]](https://ieeexplore.ieee.org/document/6914260/) |

**State of the art:** Histogram preservation defeats first-order steganalysis but is ineffective against higher-order features (SPAM, SRM co-occurrences); modern content-adaptive schemes (S-UNIWARD, HILL) implicitly avoid histogram anomalies while minimising richer statistical signatures. Related to [Content-Adaptive Image Steganography](#content-adaptive-image-steganography) and [Steganalysis](#steganalysis).

---
