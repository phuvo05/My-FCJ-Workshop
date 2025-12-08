---
title: "Week 10 - Transfer Learning, BERT & T5"
weight: 10
chapter: false
pre: "<b> 1.10. </b>"
---

**Week:** 2025-11-10 to 2025-11-14  
**Status:** "In progress"  

---

## Week 10 Overview

This week dives into transfer learning for NLP and how modern QA systems benefit from pre-trained transformers. We will contrast classical training with feature-based reuse and fine-tuning, then study two flagship models: BERT for bidirectional context and T5 for text-to-text multitask learning, along with practical QA setups (context-based vs. closed-book).

### Key Topics

#### Transfer Learning Fundamentals
- Classical vs. transfer learning pipelines
- Reusing pre-trained weights to speed convergence
- Feature-based representations vs. fine-tuning
- Benefits: faster training, better predictions, less labeled data

#### Question Answering Modes
- Context-based QA (span extraction with provided context)
- Closed-book QA (generate answers without context)
- How pre-training quality shapes QA performance

#### BERT Bidirectional Context
- Masked language modeling for contextual embeddings
- Next sentence prediction for sentence-level coherence
- Using both left and right context to predict tokens
- Typical downstream uses: QA, sentiment, classification

#### T5 Text-to-Text Multitask
- Unified text-to-text framing for multiple tasks
- Prompting the same model for rating, QA, summarization, translation
- Scaling with large corpora (e.g., C4 vs. Wikipedia)
- Multitask transfer to improve generalization

#### Training & Data Strategy
- Labeled vs. unlabeled data mix; self-supervised masking
- Freezing backbone vs. adding task heads
- Fine-tuning recipes for downstream tasks (QA, summarization, translation)

### Learning Objectives

- ✅ Explain transfer learning and when to prefer it over training from scratch
- ✅ Distinguish feature-based reuse from full fine-tuning
- ✅ Compare context-based QA and closed-book QA setups
- ✅ Summarize how BERT and T5 pre-train and transfer across tasks
- ✅ Identify why transfer learning reduces data needs and training time

---

## Daily Breakdown

| Day | Focus | Topics |
|-----|-------|--------|
| 46 | Transfer Learning Intro | Classical vs. transfer pipeline, reuse weights, feature-based vs. fine-tuning, benefits |
| 47 | Question Answering | Context-based span QA vs. closed-book QA, data needs, evaluation cues |
| 48 | BERT Bidirectionality | Masked LM, next sentence prediction, leveraging both contexts for token prediction |
| 49 | T5 Multitask Model | Text-to-text prompts, multitask sharing, scaling data (C4 vs. Wikipedia) |
| 50 | Fine-tuning Practice | Freezing layers vs. adding heads, downstream tasks: QA, summarization, translation |

---

## Prerequisites

- Solid grasp of transformer architecture from Week 9
- Comfortable with attention mechanisms and encoder-decoder flow
- Basic familiarity with PyTorch or TensorFlow for fine-tuning

## Next Steps

- Read the BERT and T5 papers to internalize pre-training objectives
- Fine-tune a pre-trained BERT QA model (e.g., SQuAD-style span extraction)
- Experiment with T5 prompts for QA, summarization, and sentiment tasks
- Compare feature-based vs. fine-tuned performance on your own dataset
