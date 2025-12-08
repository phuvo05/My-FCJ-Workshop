---
title: "Day 43 - Scaled Dot-Product Attention Deep Dive"
weight: 3
chapter: false
pre: "<b> 1.9.3. </b>"
---

**Date:** 2025-11-05 (Wednesday)  
**Status:** "Done"  

---

# **Scaled Dot-Product Attention: The Core Mechanism**

This is the **heart and soul** of transformers. Understanding this deeply is critical.

---

# **The Attention Formula**

```
           (Q × K^T)
Attention(Q, K, V) = softmax(─────────) × V
                      √(d_k)
```

Where:
- **Q** = Query matrix (what are we looking for?)
- **K** = Key matrix (what can we attend to?)
- **V** = Value matrix (what information do we get?)
- **d_k** = dimension of keys (usually 64)

---

# **Step-by-Step Computation**

Let's compute attention for a simple example:

**Input Sentence:** "I am happy"

### Setup Phase

**Step 1: Create Word Embeddings**
```
I:      [0.1, 0.2, 0.3]
am:     [0.4, 0.5, 0.6]
happy:  [0.7, 0.8, 0.9]
```

**Step 2: Convert to Q, K, V**
In practice, we learn linear projections:
```
Q = Embedding × W_q
K = Embedding × W_k
V = Embedding × W_v
```

For simplicity, let's say:
```
Q = [0.1, 0.2, 0.3]    K = [0.1, 0.2, 0.3]    V = [0.1, 0.2, 0.3]
    [0.4, 0.5, 0.6]        [0.4, 0.5, 0.6]        [0.4, 0.5, 0.6]
    [0.7, 0.8, 0.9]        [0.7, 0.8, 0.9]        [0.7, 0.8, 0.9]
```

(In reality, Q, K, V would be different projections, but this shows the concept)

### Computation Phase

**Step 3: Compute Q × K^T (dot products)**

```
Q × K^T = [0.1, 0.2, 0.3]   [0.1, 0.4, 0.7]
          [0.4, 0.5, 0.6] × [0.2, 0.5, 0.8]
          [0.7, 0.8, 0.9]   [0.3, 0.6, 0.9]

Q₁·K₁ = 0.1×0.1 + 0.2×0.2 + 0.3×0.3 = 0.01 + 0.04 + 0.09 = 0.14
Q₁·K₂ = 0.1×0.4 + 0.2×0.5 + 0.3×0.6 = 0.04 + 0.10 + 0.18 = 0.32
Q₁·K₃ = 0.1×0.7 + 0.2×0.8 + 0.3×0.9 = 0.07 + 0.16 + 0.27 = 0.50

Result matrix:
[0.14, 0.32, 0.50]
[0.32, 0.77, 1.22]
[0.50, 1.22, 1.94]
```

**Interpretation:**
- Q₁ (query for "I") has similarity scores: [0.14, 0.32, 0.50]
  - 0.14 with "I" itself
  - 0.32 with "am"
  - 0.50 with "happy"

**Step 4: Scale by √d_k**

d_k = 3 (embedding dimension), so √d_k = √3 ≈ 1.73

```
Scaled matrix = Q×K^T / √3:
[0.14/1.73, 0.32/1.73, 0.50/1.73]     [0.08, 0.18, 0.29]
[0.32/1.73, 0.77/1.73, 1.22/1.73]  =  [0.18, 0.44, 0.70]
[0.50/1.73, 1.22/1.73, 1.94/1.73]     [0.29, 0.70, 1.12]
```

**Why scale?** 
- When d_k is large (e.g., 64), dot products get very large
- Large numbers cause softmax to have very small gradients (saturation)
- Scaling by √d_k keeps numbers in reasonable range for training

**Step 5: Apply Softmax**

Softmax converts scores to probabilities (sum to 1):

```
softmax(x) = exp(x) / sum(exp(x))

For first row [0.08, 0.18, 0.29]:
exp(0.08) ≈ 1.083
exp(0.18) ≈ 1.197
exp(0.29) ≈ 1.336
Sum ≈ 3.616

Probabilities:
[1.083/3.616, 1.197/3.616, 1.336/3.616] ≈ [0.30, 0.33, 0.37]
```

**All three rows:**
```
Softmax weights (attention matrix):
[0.30, 0.33, 0.37]
[0.26, 0.37, 0.37]
[0.25, 0.36, 0.39]
```

**Interpretation:**
- Word "I" pays 30% attention to itself, 33% to "am", 37% to "happy"
- Word "am" pays 26% attention to "I", 37% to itself, 37% to "happy"
- Word "happy" pays 25% to "I", 36% to "am", 39% to itself

**Step 6: Multiply by Value Matrix (V)**

```
Context = Softmax_weights × V

Context(for "I"):     0.30×[0.1,0.2,0.3] + 0.33×[0.4,0.5,0.6] + 0.37×[0.7,0.8,0.9]
                    = [0.03,0.06,0.09] + [0.13,0.17,0.20] + [0.26,0.30,0.33]
                    = [0.42, 0.53, 0.62]

Context(for "am"):    0.26×[0.1,0.2,0.3] + 0.37×[0.4,0.5,0.6] + 0.37×[0.7,0.8,0.9]
                    = [0.026,0.052,0.078] + [0.148,0.185,0.222] + [0.259,0.296,0.333]
                    = [0.433, 0.533, 0.633]

Context(for "happy"): 0.25×[0.1,0.2,0.3] + 0.36×[0.4,0.5,0.6] + 0.39×[0.7,0.8,0.9]
                    = [0.025,0.05,0.075] + [0.144,0.18,0.216] + [0.273,0.312,0.351]
                    = [0.442, 0.542, 0.642]
```

**Output Context Matrix:**
```
[0.42, 0.53, 0.62]
[0.433, 0.533, 0.633]
[0.442, 0.542, 0.642]
```

Each word now has a **context vector** that combines information from all words weighted by attention scores!

---

# **Why Scaled Dot-Product Attention?**

| Aspect | Reason |
|--------|--------|
| **Dot Product** | Efficient similarity measure (just matrix multiplication) |
| **Scaling** | Prevents softmax saturation (keeps gradients healthy) |
| **Softmax** | Converts similarities to normalized weights [0,1] |
| **Multiply by V** | Gets actual information (weighted combination) |

---

# **Multi-Head Attention: Multiple Perspectives**

Instead of one attention head, we use **h = 8 (or more)** attention heads:

```
MultiHeadAttention(Q, K, V) = Concat(Head₁, ..., Head₈) × W_o

Where:
Head_i = Attention(Q × W_q^i, K × W_k^i, V × W_v^i)
```

**Different heads learn different relationships:**
- Head 1: Subject-verb relationships
- Head 2: Adjective-noun relationships
- Head 3: Pronoun-antecedent relationships
- Head 4-8: Other semantic patterns

**Example:**
```
Sentence: "The quick brown fox jumps over the lazy dog"

Head 1 (subject-verb):
  - "fox" → "jumps": 0.9
  - "dog" → has_property: 0.7

Head 2 (adjective-noun):
  - "quick" → "fox": 0.85
  - "brown" → "fox": 0.8
  - "lazy" → "dog": 0.9

Head 3 (spatial):
  - "over" → connects "fox" and "dog": 0.8
```

All these different perspectives combined give rich contextual understanding.

---

# **Computational Efficiency**

**Why is scaled dot-product attention so efficient?**

1. **Matrix Operations:** Just multiplication and softmax (GPU-optimized)
2. **Parallelizable:** Can process entire sequences at once
3. **Memory Efficient:** O(n²) memory for n-length sequence (acceptable)
4. **Fast Training:** Modern GPUs can do billions of dot products/second

**Comparison:**
- RNN: O(n) sequential steps → slow
- Attention: O(1) depth, O(n²) memory → fast!

---

# **Key Insights**

✅ **Attention is learned:** W_q, W_k, W_v are trainable parameters
✅ **Position-free:** No sequential dependencies - can attend across any distance
✅ **Interpretable:** Can visualize which words attend to which
✅ **Efficient:** Uses only matrix operations (GPU-friendly)

---

# **Next Steps**

Now that we understand scaled dot-product attention, we'll explore:
1. Self-attention (query=key=value)
2. Masked attention (decoder only sees past)
3. Encoder-decoder attention (cross-lingual connections)
4. Multi-head attention in detail (learning multiple patterns)
