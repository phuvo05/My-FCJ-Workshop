---
title: "Day 40 - MT Evaluation & Decoding Strategies"
weight: 5
chapter: false
pre: "<b> 1.8.5. </b>"
---

**Date:** 2025-10-31 (Friday)  
**Status:** "Done"  

---

# **BLEU Score – Precision-Based Evaluation**

**BLEU (Bilingual Evaluation Understudy)** is an algorithm designed to evaluate machine translation quality.

## How BLEU Works

**Core Concept:** Compare candidate translation to one or more reference translations (often human translations)

**Score Range:** 0 to 1
- Closer to 1 = better translation
- Closer to 0 = worse translation

---

## Calculating BLEU Score

### Vanilla BLEU (Problematic)

**Example:**
- Candidate: "I I am I"
- Reference 1: "Eunice said I'm hungry"
- Reference 2: "He said I'm hungry"

**Process:**
1. Count how many candidate words appear in any reference
2. Divide by total candidate words

Result: 4/4 = **1.0** (perfect score!)

**Problem:** This translation is terrible but gets perfect score! A model that outputs common words will score well.

---

### Modified BLEU (Better)

**Key Change:** After matching a word, **exhaust it** from references

**Same Example:**
1. "I" (first) → matches → exhaust "I" from references → count = 1
2. "I" (second) → no match left → count = 1
3. "am" → matches → exhaust "am" → count = 2
4. "I" (third) → no match left → count = 2

Result: 2/4 = **0.5** (more realistic!)

---

## BLEU Limitations

**❌ Doesn't consider semantic meaning**
- Only checks word matches

**❌ Doesn't consider sentence structure**
- "Ate I was hungry because" vs "I ate because I was hungry"
- Both get same score!

**✅ Still most widely adopted metric** despite limitations

---

# **ROUGE Score – Recall-Based Evaluation**

**ROUGE (Recall-Oriented Understudy for Gisting Evaluation)**

## BLEU vs ROUGE

| Metric | Focus | Calculation |
|--------|-------|-------------|
| BLEU | Precision | How many candidate words in reference? |
| ROUGE | Recall | How many reference words in candidate? |

---

## Calculating ROUGE-N Score

**Example:**
- Candidate: "I I am I"
- Reference 1: "Younes said I am hungry" (5 words)
- Reference 2: "He said I'm hungry" (5 words)

**Process for Reference 1:**
1. "Younes" → no match → count = 0
2. "said" → no match → count = 0
3. "I" → match → count = 1
4. "am" → match → count = 2
5. "hungry" → no match → count = 2

ROUGE score for Ref 1: 2/5 = **0.4**

**If multiple references:** Calculate for each, take maximum

---

# **F1 Score – Combining BLEU and ROUGE**

Since BLEU = precision and ROUGE = recall, we can calculate **F1 score**:

**Formula:**
```
F1 = 2 × (Precision × Recall) / (Precision + Recall)
F1 = 2 × (BLEU × ROUGE) / (BLEU + ROUGE)
```

**Example:**
- BLEU = 0.5
- ROUGE = 0.4
- F1 = 2 × (0.5 × 0.4) / (0.5 + 0.4) = 4/9 ≈ **0.44**

---

# **Beam Search Decoding**

**Problem:** Taking the highest probability word at each step doesn't guarantee best overall sequence

**Solution:** Beam search finds most likely sequences over a fixed window

## How Beam Search Works

**Beam Width (B):** Number of sequences to keep at each step

### Process:

#### Step 1: Start with SOS token
Get probabilities for first word:
- I: 0.5
- am: 0.4
- hungry: 0.1

Keep top B=2: **"I"** and **"am"**

#### Step 2: Calculate Conditional Probabilities
For "I":
- I am: 0.5 × 0.5 = 0.25
- I I: 0.5 × 0.1 = 0.05

For "am":
- am I: 0.4 × 0.7 = 0.28
- am hungry: 0.4 × 0.2 = 0.08

Keep top B=2: **"am I"** (0.28) and **"I am"** (0.25)

#### Step 3: Repeat
Continue until all B sequences reach EOS token

#### Step 4: Select Best
Choose sequence with highest overall probability

---

## Beam Search Characteristics

**Advantages:**
- Better than greedy decoding (B=1)
- Finds globally better sequences
- Widely used in production

**Disadvantages:**
- Memory intensive (store B sequences)
- Computationally expensive (run model B times per step)
- Penalizes long sequences (product of many probabilities)

**Solution for Long Sequences:**
Normalize by length: divide probability by number of words

---

# **Minimum Bayes Risk (MBR) Decoding**

**Concept:** Generate multiple samples and find consensus

## MBR Process:

### Step 1: Generate Multiple Samples
Create ~30 random samples from the model

### Step 2: Compare All Pairs
For each sample, compare against all others using similarity metric (e.g., ROUGE)

### Step 3: Calculate Average Similarity
For each candidate, compute average similarity with all other candidates

### Step 4: Select Best
Choose the sample with **highest average similarity** (lowest risk)

---

## MBR Formula

```
E* = argmax_E [ average ROUGE(E, E') for all E' ]
```

Where:
- E = candidate translation
- E' = all other candidates
- Goal: Find E that maximizes average ROUGE with every E'

---

## MBR Example (4 Candidates)

**Step 1:** Calculate pairwise ROUGE scores
- ROUGE(C1, C2), ROUGE(C1, C3), ROUGE(C1, C4)
- Average = R1

**Step 2:** Repeat for C2, C3, C4
- Get R2, R3, R4

**Step 3:** Select highest
- Choose candidate with max(R1, R2, R3, R4)

---

## MBR Characteristics

**Advantages:**
- More contextually accurate than random sampling
- Finds consensus translation
- Can outperform beam search

**Disadvantages:**
- Requires generating many samples (expensive)
- Requires O(n²) comparisons

**When to Use:**
- When you need high-quality translation
- When computational cost is acceptable
- When beam search outputs are inconsistent

---

# **Summary: Decoding Strategies**

| Method | Description | Pros | Cons |
|--------|-------------|------|------|
| **Greedy** | Pick highest prob at each step | Fast, simple | Suboptimal sequences |
| **Beam Search** | Keep top-B sequences | Better quality | Memory + compute cost |
| **Random Sampling** | Sample from distribution | Diverse outputs | Inconsistent quality |
| **MBR** | Consensus from samples | High quality | Very expensive |

---

# **Evaluation Metrics Summary**

| Metric | Type | Focus | Best For |
|--------|------|-------|----------|
| **BLEU** | Precision | Candidate → Reference | General MT |
| **ROUGE** | Recall | Reference → Candidate | Summarization |
| **F1** | Harmonic Mean | Both precision & recall | Balanced view |

**Critical Note:** All these metrics:
- ❌ Don't consider semantics
- ❌ Don't consider sentence structure
- ✅ Only count n-gram matches

**Modern Alternative:** Use neural metrics or human evaluation for critical applications!
