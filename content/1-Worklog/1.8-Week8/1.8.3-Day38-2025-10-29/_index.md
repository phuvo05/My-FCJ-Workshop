---
title: "Day 38 - Seq2seq Models & LSTM Deep Dive"
weight: 3
chapter: false
pre: "<b> 1.8.3. </b>"
---

**Date:** 2025-10-29 (Wednesday)  
**Status:** "Done"  

---

# **Seq2seq Model**

**Sequence-to-Sequence (Seq2seq)** models introduce an encoder-decoder architecture effective for tasks like machine translation and text summarization.

## Key Features:
- Maps variable-length sequences to fixed-length memory
- Input and outputs can have different lengths
- Uses LSTMs and GRUs to avoid vanishing and exploding gradients
- Encoder takes word tokens as input → hidden state vectors → decoder generates output sequence

---

# **LSTM Architecture: Deep Dive**

## What is LSTM?

**LSTM (Long Short-Term Memory)** is like a mini version of the human brain when processing memory.

## LSTM Structure = 3 Gates + 1 Cell State

### 1. Forget Gate – Deciding What to Forget

Decides what information to discard from the old state.

**Formula:**
```
f_t = σ(W_f · [h_{t-1}, x_t] + b_f)
```

**Brain analogy:**
- Useless messages from someone who ghosted you → forget
- Formulas you use daily → keep

### 2. Input Gate – Deciding What to Remember

Decides what new information to add to memory.

**Formulas:**
```
i_t = σ(W_i · [h_{t-1}, x_t] + b_i)
Ĉ_t = tanh(W_C · [h_{t-1}, x_t] + b_C)
```

**Brain analogy:**
- Valuable information → store in long-term memory
- Irrelevant noise → discard immediately

### 3. Cell State Update – Long-term Memory

Updates long-term memory by combining forget and input gates.

**Formula:**
```
C_t = f_t ⊙ C_{t-1} + i_t ⊙ Ĉ_t
```

Where:
- `f_t ⊙ C_{t-1}` = what to keep from old memory
- `i_t ⊙ Ĉ_t` = what to add from new input

### 4. Output Gate – Deciding What to Output

Decides which memory to use for current output.

**Formulas:**
```
o_t = σ(W_o · [h_{t-1}, x_t] + b_o)
h_t = o_t ⊙ tanh(C_t)
```

**Brain analogy:**
- When taking an NLP exam → recall LSTM formulas
- When talking to someone → recall conversation context
- When doing DevOps → recall AWS specs

---

## LSTM vs Human Brain

| Human Brain | LSTM |
|------------|------|
| Long-term memory | Cell State |
| Filter out unnecessary information | Forget Gate |
| Accept new valuable information | Input Gate |
| Retrieve appropriate memory to respond | Output Gate |
| Learn from sequential experiences | RNN backbone |
| Don't forget quickly | Long-term dependencies |

---

## What is a Gate?

**Gate = cognitive filter**

Each gate = a mechanism that decides "keep or discard"

### Example: When You Study NLP

- **Forget Gate**: "Do I still need to remember this outdated method?" → Discard if no
- **Input Gate**: "Is this new concept valuable?" → Store if yes
- **Output Gate**: "What knowledge do I need right now?" → Retrieve relevant parts

---

## Hidden State Limitations

Hidden state doesn't have a token limit, but has a **capacity limit for effective memory**.

### Mathematical Perspective:
- Hidden state = fixed-size vector (e.g., 128, 256, 512 dimensions)
- Can process 10 tokens or 10,000 tokens → won't crash
- Problem: **can't remember everything**

### Why?
- Even with cell state, gradients weaken over many time steps
- Long-term dependencies get lost
- Tokens far from the start have weak influence on final output

**Solution:** This is why we need **Attention mechanism**!

---

## Throttling in NLP

### Two Meanings of Throttling:

#### 1. System-Level Throttling (API)
Limiting request rate or token processing to:
- Protect GPU resources
- Distribute resources fairly
- Avoid server overload
- Control costs

Examples:
- OpenAI GPT: 10 requests/second, 90k tokens/min
- Anthropic Claude: 20 requests/second
- HuggingFace: timeout if generation takes too long

#### 2. Model-Level Throttling (Architecture)

LSTM, Transformer, and Attention all have mechanisms to **limit information processing** at any given time:

**(A) LSTM Throttling → Forget Gate**
When sequence is too long:
- Forget gate automatically "throttles" old information
- Only allows part of meaning to pass through
- Like network throttling: "overload → reduce bandwidth → drop packets"

**(B) Transformer Throttling → Context Window Limit**
- BERT: 512 tokens
- GPT-3: 2048-4096 tokens
- GPT-4: 128k-1M tokens
- Claude 3.5 Sonnet: 200k-1M tokens

When input exceeds limit:
- Model cuts data
- Or refuses to process
- Or downgrades attention quality

**(C) Attention Throttling → Sparse Attention**
In long-context models (Longformer, BigBird, Mistral):
- Can't compute full n² attention
- Only attend to important regions (local attention)
- Or global tokens
- Or sliding window

**(D) Token Generation Throttling**
Some decoders will:
- Slow down token generation
- Limit sampling
- Apply temperature control
- Cut beam search

When input is noisy or uncertain, this acts like a brake: "Not sure → slow down generation → increase quality"

---

# **Summary**

LSTM is not just a model — it's a computational mimicry of how human memory works. Understanding gates helps you understand why certain information persists while other information fades away.
