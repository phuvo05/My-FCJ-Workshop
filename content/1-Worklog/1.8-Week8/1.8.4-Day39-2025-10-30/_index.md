---
title: "Day 39 - NMT & Text Summarization"
weight: 4
chapter: false
pre: "<b> 1.8.4. </b>"
---

**Date:** 2025-10-30 (Thursday)  
**Status:** "Done"  

---

# **Neural Machine Translation (NMT)**

## Architecture Overview

The input sentence is converted to a numerical representation and encoded into a deep representation by a **six-layer encoder**, which is subsequently decoded by a **six-layer decoder** into the translation in the target language.

### Encoder and Decoder Layers

Layers consist of:
- **Self-attention**: Helps model focus on different parts of input
- **Feed-forward layers**: Process information
- **Encoder-decoder attention layer** (decoder only): Uses deep representation from last encoder layer

---

## Attention Mechanism Example

**Translation Task:** "The woman took the empty magazine out of her gun"  
**Target Language:** Czech

### Visualization of Self-Attention

When translating "magazine", the attention mechanism:
- Creates strong attention link between 'magazine' and 'gun'
- This helps correctly translate "magazine" as "zásobník" (gun magazine)
- Instead of "časopis" (news magazine)

### Why Attention Matters

**Attention = mechanism that helps model focus on the most important parts of input when generating output**

In other words: **Attention = selective information processing instead of consuming everything at once**

In NLP, attention allows the model to decide which words most strongly influence understanding another word in the sentence.

---

## NMT Implementation Details

### Model Architecture Components:

#### Inputs:
1. **Input tokens** (source language)
2. **Target tokens** (target language)

#### Step 1: Make Copies
Create two copies each of input and target tokens (needed in different places of model)

#### Step 2: Encoder
- One copy of input tokens → encoder
- Transform into **key** and **value** vectors
- Go through embedding layer → LSTM

#### Step 3: Pre-attention Decoder
- One copy of target tokens → pre-attention decoder
- Shift sequence right + add start-of-sentence token (**teacher forcing**)
- Go through embedding layer → LSTM
- Output becomes **query** vectors

**Note:** Encoder and pre-attention decoder can run in **parallel** (no dependencies)

#### Step 4: Prepare for Attention
- Get query, key, value vectors
- Create **padding mask** to identify padding tokens
- Use copy of input tokens for this step

#### Step 5: Attention Layer
Pass queries, keys, values, and mask to attention layer
- Outputs **context vectors** and mask

#### Step 6: Post-attention Decoder
Drop mask, pass context vectors through:
- LSTM
- Dense layer
- LogSoftmax

#### Step 7: Output
Model returns:
- Log probabilities
- Copy of target tokens (for loss computation)

---

# **Text Summarization**

Summarization = condensing content while preserving main ideas

## Two Types:

### 1. Extractive Summarization

**Concept:** Select the most important sentences from original text

**Characteristics:**
- Doesn't rewrite text
- Preserves original wording
- Like "highlighting key sentences"

**Process (Classical TextRank):**
1. Split into sentences
2. Convert sentences to embeddings
3. Calculate similarity (cosine)
4. Create graph (sentences as nodes)
5. Rank using TextRank
6. Select top-ranked sentences

**Result:** Subset of original text

---

### 2. Abstractive Summarization

**Concept:** Rewrite main ideas in new sentences

**Characteristics:**
- Creates sentences that never appeared in original
- Understands content → paraphrases
- Requires strong models (seq2seq, Transformer)

**Example:**
Original article discusses prosecutor's investigation process...

Generated summary:
> "Prosecutor: So far no videos were used in the crash investigation."

This sentence doesn't exist in original but captures the main idea.

---

## Extractive vs Abstractive Summary

| Feature | Extractive | Abstractive |
|---------|-----------|-------------|
| Approach | Select existing sentences | Generate new sentences |
| Creativity | Low | High |
| Complexity | Simpler | More complex |
| Accuracy | More faithful to source | May introduce errors |
| Model | TextRank, graph-based | Seq2seq, Transformer |

---

## TextRank Pipeline

**Step-by-step extractive summarization:**

1. **Combine articles** → full text
2. **Split sentences**
3. **Convert sentences** → vectors (embeddings)
4. **Create similarity matrix**
5. **Build graph** (sentences = nodes, edges = similarity)
6. **Rank nodes** using TextRank algorithm
7. **Select top-ranked** sentences → Summary

This is the classical algorithm that dominated before deep learning!

---

# **Syntax and Semantics Review**

## Syntax – Sentence Structure

**Syntax** examines how words combine to form **grammatically correct sentences**.

### Includes:
- **Word order**: English uses S–V–O (Subject–Verb–Object)
- **Phrase structure**: NP (Noun Phrase), VP (Verb Phrase), PP (Prepositional Phrase)
- **Dependency relations**: How words relate to each other

### NLP Relevance:
- POS tagging
- Parsing
- Named Entity Recognition
- Machine translation
- Question answering

---

## Semantics – Meaning of Words and Sentences

**Semantics** focuses on meaning **independent of external context**.

### Includes:
- **Lexical semantics**: Word meaning
- **Compositional semantics**: Sentence meaning
- **Synonymy / antonymy**: Similar/opposite meanings
- **Hypernymy / hyponymy**: General/specific relationships

### NLP Relevance:
- Word embeddings
- Similarity measures
- Semantic search
- Text classification

---

## Pragmatics – Intended Meaning in Context

**Pragmatics** studies meaning from **context, speaker intention, and real-world knowledge**.

### Covers:
- **Implicature**: Hidden meaning
- **Deixis**: Context-dependent references (this/that/here/you)
- **Speech acts**: Promises, requests, apologies
- **Politeness, formality, sarcasm**: Tone and intention

### NLP Relevance:
- Dialogue systems
- Chatbots
- Sentiment and irony detection
- Contextual language models (BERT, GPT)
