---
title: "Day 44 - Attention Types: Self, Masked, and Encoder-Decoder"
weight: 4
chapter: false
pre: "<b> 1.9.4. </b>"
---

**Date:** 2025-11-06 (Thursday)  
**Status:** "Done"  

---

# **Three Types of Attention in Transformers**

The transformer uses attention in three different ways. Understanding each is crucial.

---

# **Type 1: Self-Attention (Encoder)**

**Definition:** Each position attends to **all positions in the same sequence**.

**Use Case:** In the encoder, we want each word to understand its context by looking at all other words.

**Example:**
```
Sentence: "The cat sat on the mat"

For word "cat":
- Attend to "The": 0.15 (article)
- Attend to "cat": 0.40 (itself)
- Attend to "sat": 0.20 (verb)
- Attend to "on": 0.10
- Attend to "the": 0.08
- Attend to "mat": 0.07

Result: "cat" context = weighted combination of all 6 words
```

**Why useful:**
- Captures full sentence context
- Can identify relationships (subject-verb, adjective-noun, etc.)
- Each word gets information from entire sentence

**Implementation:**
```
Q = K = V = Input  (same source!)

attention(Q, K, V) = softmax(Q×K^T / √d_k) × V
```

Since Q, K, V come from the same place, it's called "self-attention".

---

# **Type 2: Masked Self-Attention (Decoder)**

**Problem:** During training, if the decoder can "see" future words, it cheats!

**Example - The Problem:**
```
Task: Translate "Je suis heureux" → "I am happy"

Training:
Step 1: Predict "am" using... "am" (it can see the answer!)
Step 2: Predict "happy" using "I am happy" (knows the answer!)
Step 3: Predict "happy" is done (cheating!)

Result: Model trains perfectly but fails at test time!
```

**Solution:** Mask (hide) future positions during self-attention.

**Masked Self-Attention:**
```
Instead of:              We do:
[0.30, 0.33, 0.37]      [0.30, -∞, -∞]
[0.26, 0.37, 0.37]  →   [0.26, 0.37, -∞]
[0.25, 0.36, 0.39]      [0.25, 0.36, 0.39]

After softmax:
[1.00, 0.00, 0.00]
[0.30, 0.70, 0.00]
[0.25, 0.36, 0.39]

(normalized)
```

**Mask Matrix:**
```
Mask = [1, 0, 0]
       [1, 1, 0]
       [1, 1, 1]

Or: -∞ for masked positions
```

**Effect:**
```
Position 0: Attends to position 0 only
Position 1: Attends to positions 0, 1 only
Position 2: Attends to positions 0, 1, 2

Decoder can only use past information!
```

**Why this works:**
- During training, can use autoregressive generation
- During inference, generates word-by-word naturally
- Prevents the model from "seeing the answer"

---

# **Type 3: Encoder-Decoder Attention**

**Purpose:** Decoder attends to encoder output.

**Example:**
```
Encoder processes: "Je suis heureux" (French)
Produces: Context vectors C

Decoder processes: "" (empty start)
For generating first word:
- Query: from decoder (what should I translate?)
- Key, Value: from encoder (what French words should I look at?)

Result: Decoder attends to French words to generate English
```

**Key Difference from Self-Attention:**
```
Self-Attention:           Encoder-Decoder:
Q, K, V all from input    Q from decoder
Same sequence             K, V from encoder

Attends within self       Attends to other sequence
```

**Use Cases:**
- Decoder looking back at encoder output
- Allows translation: French → English
- Allows summarization: Document → Summary
- Generally useful for seq2seq tasks

---

# **Comparison: All Three Types**

| Type | Q Source | K, V Source | Purpose |
|------|----------|-------------|---------|
| **Self-Attention** | Input | Input | Understand context within same sequence |
| **Masked Self-Attention** | Input | Input (masked future) | Autoregressive generation, prevent cheating |
| **Encoder-Decoder** | Decoder | Encoder | Cross-sequence understanding |

---

# **Masked Attention in Detail**

### The Math

**Before masking:**
```
Attention = softmax(Q×K^T / √d_k) × V
```

**With masking:**
```
Scores = Q×K^T / √d_k

Mask matrix M:
M[i,j] = 0 if j <= i (allowed)
M[i,j] = -∞ if j > i (mask future)

Masked_scores = Scores + M

Attention = softmax(Masked_scores) × V
```

### Example with Real Numbers

**Original attention scores (3×3):**
```
[0.1, 0.2, 0.3]
[0.4, 0.5, 0.6]
[0.7, 0.8, 0.9]
```

**Mask matrix:**
```
[0,  -∞, -∞]
[0,   0, -∞]
[0,   0,  0]
```

**After adding mask:**
```
[0.1, -∞, -∞]
[0.4, 0.5, -∞]
[0.7, 0.8, 0.9]
```

**After softmax (applying exp and normalize):**
```
exp(0.1) / exp(0.1) = 1.0, softmax([0.1]) = [1.0]
So:
Row 0: [1.0, 0, 0]

exp(0.4) ≈ 1.49, exp(0.5) ≈ 1.65
Row 1: [1.49/(1.49+1.65), 1.65/(1.49+1.65), 0] ≈ [0.47, 0.53, 0]

Row 2: softmax([0.7, 0.8, 0.9])  (all allowed)
```

**Final attention weights:**
```
[1.0, 0.0, 0.0]
[0.47, 0.53, 0.0]
[0.25, 0.33, 0.42]
```

**Key insight:** Position 2 can only use information from positions 0, 1, 2 (not future)

---

# **Complete Transformer Attention Flow**

```
INPUT: "Je suis heureux"
  ↓
ENCODER LAYERS (repeat 6 times):
  ├─ Self-Attention: Each French word attends to all French words
  ├─ Feed-Forward
  → Output: C (French context vectors)

DECODER LAYERS (repeat 6 times):
  ├─ Masked Self-Attention: Each generated word attends to previous words
  ├─ Encoder-Decoder Attention: Generated word attends to French context
  ├─ Feed-Forward
  → Output: Logits for next word prediction

OUTPUT: "I am happy"
```

---

# **Key Insights**

✅ **Self-Attention:** Bidirectional understanding (encoder)
✅ **Masked Attention:** Unidirectional generation (decoder)
✅ **Encoder-Decoder:** Cross-sequence transfer
✅ **Masking prevents cheating:** Model can't use future information

---

# **Why Not Always Use All Three?**

- **BERT (Encoder-only):** Uses only self-attention (bidirectional, good for classification)
- **GPT (Decoder-only):** Uses only masked self-attention (autoregressive, good for generation)
- **T5 (Full):** Uses all three (balanced, good for seq2seq tasks)

---

# **Next: Implementation**

Now that we understand the three attention types, we'll see how to implement them in code!
