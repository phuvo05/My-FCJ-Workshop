---
title: "Day 42 - Transformer Architecture Overview"
weight: 2
chapter: false
pre: "<b> 1.9.2. </b>"
---

**Date:** 2025-11-04 (Tuesday)  
**Status:** "Done"  

---

# **Transformer Architecture: The Big Picture**

The transformer model introduced in the paper "Attention is All You Need" revolutionized NLP. Let's understand its complete structure.

---

# **High-Level Architecture**

```
INPUT SEQUENCE
      ↓
[Tokenization & Embedding]
      ↓
[Add Positional Encoding]
      ↓
┌─────────────────────────────────┐
│  ENCODER (N layers)             │
│  ├─ Multi-Head Attention        │
│  ├─ Layer Normalization         │
│  ├─ Feed-Forward Network        │
│  └─ Residual Connections        │
└─────────────────────────────────┘
      ↓
[Context Vectors from Encoder]
      ↓
┌─────────────────────────────────┐
│  DECODER (N layers)             │
│  ├─ Masked Multi-Head Attention │
│  ├─ Encoder-Decoder Attention   │
│  ├─ Feed-Forward Network        │
│  └─ Layer Normalization         │
└─────────────────────────────────┘
      ↓
[Linear Layer + Softmax]
      ↓
OUTPUT PROBABILITIES
```

---

# **Component 1: Word Embeddings**

Each word is converted to a dense vector (typically 512-1024 dimensions).

**Example:**
```
Word: "happy"
Embedding: [0.2, -0.5, 0.8, ..., 0.1]  // 512 values
```

---

# **Component 2: Positional Encoding**

**Problem:** Transformers don't have sequential order built in (unlike RNNs). So we must add positional information explicitly.

**Solution:** Add positional encoding vectors to embeddings.

**Formula:**
```
PE(pos, 2i) = sin(pos / 10000^(2i/d_model))
PE(pos, 2i+1) = cos(pos / 10000^(2i/d_model))

Where:
- pos = position in sequence (0, 1, 2, ...)
- i = dimension index
- d_model = embedding dimension (512, 1024, etc.)
```

**Intuition:**
- Position 0: "I" gets PE₀
- Position 1: "am" gets PE₁
- Position 2: "happy" gets PE₂

**Example:**
```
Embedding("I") = [0.2, -0.5, 0.8, ..., 0.1]
PE(pos=0) = [0.0, 1.0, 0.0, 1.0, ..., 0.5]
Final = [0.2, 0.5, 0.8, 1.0, ..., 0.6]
```

---

# **Component 3: Multi-Head Attention**

Instead of one attention mechanism, we have **h different "heads"** running in parallel.

**Concept:**
```
Input: Query (Q), Key (K), Value (V) matrices

Head 1: ScaledDotProductAttention(Q₁, K₁, V₁)
Head 2: ScaledDotProductAttention(Q₂, K₂, V₂)
...
Head h: ScaledDotProductAttention(Qₕ, Kₕ, Vₕ)

Output = Concatenate(Head₁, Head₂, ..., Headₕ)
```

**Why Multiple Heads?**
- Head 1 might learn "subject-verb" relationships
- Head 2 might learn "adjective-noun" relationships
- Head 3 might learn "pronoun-reference" relationships
- Together: Rich contextual understanding

**Typical Configuration:**
- Number of heads: 8-16
- Dimension per head: 64 (if total = 512, then 512/8 = 64)

---

# **Component 4: Residual Connections & Layer Normalization**

### Residual Connections
```
Output = Input + Attention(Input)
```

This helps with gradient flow during training and allows networks to go deeper.

### Layer Normalization
```
Normalized = (x - mean) / sqrt(variance + epsilon)
```

Stabilizes training and speeds up convergence.

---

# **Component 5: Feed-Forward Network**

After attention, there's a simple 2-layer feed-forward network:

```
Output = ReLU(Linear₁(x)) → Linear₂
```

Typical dimensions:
```
Input: [batch_size, seq_length, 512]
       ↓ Linear₁ (512 → 2048)
     [batch_size, seq_length, 2048]
       ↓ ReLU (non-linear)
     [batch_size, seq_length, 2048]
       ↓ Linear₂ (2048 → 512)
     [batch_size, seq_length, 512]
```

This expands then contracts, allowing for non-linear transformations.

---

# **The Encoder: Detailed View**

**Single Encoder Layer:**
```
Input (x)
  ↓
[Multi-Head Self-Attention]
  ↓
[+ Residual Connection with input]
  ↓
[Layer Normalization]
  ↓
[Feed-Forward Network]
  ↓
[+ Residual Connection]
  ↓
[Layer Normalization]
  ↓
Output
```

**Key Point:** In encoder, **each word attends to ALL words** (including itself) in the same sentence.

**Encoder gives:** Contextual representation of each word, considering all other words.

---

# **The Decoder: Detailed View**

Decoder is similar but with **masking**:

```
Input (shifted right by 1)
  ↓
[Masked Multi-Head Self-Attention]  ← Can only attend to previous positions
  ↓
[+ Residual + LayerNorm]
  ↓
[Encoder-Decoder Attention]  ← Attends to encoder output
  ↓
[+ Residual + LayerNorm]
  ↓
[Feed-Forward Network]
  ↓
[+ Residual + LayerNorm]
  ↓
Output
```

**Three Attention Mechanisms in Decoder:**

1. **Masked Self-Attention:**
   - Queries, Keys, Values from decoder
   - Each position can only attend to **previous positions**
   - Prevents information leakage (decoder doesn't see future words)

2. **Encoder-Decoder Attention:**
   - Queries from decoder
   - Keys, Values from encoder
   - Decoder can attend to any encoder position

3. **Feed-Forward:**
   - Same 2-layer network as encoder

---

# **Putting It Together: Full Transformer**

### Training Phase

```
Input: "Je suis heureux" (French)
Target: "I am happy" (English)

Encoder Input:
  - Tokenize: [Je, suis, heureux]
  - Embed each token
  - Add positional encoding
  - Process through N encoder layers
  → Output: C (context vectors)

Decoder Input:
  - Target shifted right: [<START>, I, am]
  - Embed each token
  - Add positional encoding
  - Process through N decoder layers
    - Using masked self-attention
    - Using encoder-decoder attention on C
  → Output logits for each position

Loss: Compare predicted "am happy" with actual "am happy"
Backprop: Update all weights
```

### Inference Phase

```
Encoder Input: [Je, suis, heureux]
→ Output: C (context vectors)

Decoder:
Step 1: Start with [<START>]
        Predict next word: "I"
Step 2: [<START>, I] 
        Predict next word: "am"
Step 3: [<START>, I, am]
        Predict next word: "happy"
Step 4: [<START>, I, am, happy]
        Predict next word: <END>

Output: "I am happy"
```

---

# **Summary: Why This Architecture Works**

| Feature | Benefit |
|---------|---------|
| **No RNN** | Fully parallelizable - train on GPUs efficiently |
| **Self-Attention in Encoder** | Each word gets context from ALL other words |
| **Masked Attention in Decoder** | Can't see future - trains with autoregressive generation |
| **Positional Encoding** | Preserves word order without RNN sequential processing |
| **Multi-Head Attention** | Learn multiple types of relationships simultaneously |
| **Residual Connections** | Gradient flow - enables training deep networks |
| **Layer Normalization** | Stability - faster convergence |

---

# **Key Innovations**

1. **Parallelization:** O(1) depth instead of O(n) for RNNs
2. **Long-range Dependencies:** Attention can directly connect any two positions
3. **Scalability:** Can increase model size with predictable improvements
4. **Transfer Learning:** Pre-trained transformers (BERT, GPT) work across tasks

