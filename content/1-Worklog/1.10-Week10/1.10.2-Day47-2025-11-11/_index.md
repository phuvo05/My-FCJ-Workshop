---
title: "Day 47 - Question Answering Modes"
weight: 2
chapter: false
pre: "<b> 1.10.2. </b>"
---

**Date:** 2025-11-11 (Tuesday)  
**Status:** "Done"  

---

# Context-Based vs. Closed-Book QA

Two common QA setups share the same transformer backbone but differ in inputs and evaluation.

## Context-Based (Open Book)

- Input: question + supporting context paragraph(s).
- Output: span extraction or short generation grounded in context.
- Training: supervised spans (e.g., start/end indices) or seq2seq with context.
- Failure mode: wrong or missing span when context is noisy.

## Closed-Book

- Input: question only; the model must rely on internal knowledge.
- Output: generated answer without explicit context.
- Training: language modeling style on large corpora; often fine-tuned on QA pairs.
- Failure mode: hallucination; mitigated by stronger pre-training and knowledge distillation.

## Picking the Mode

- If you can supply documents at runtime -> prefer context-based (more controllable, cite-able).
- If latency/storage prevents retrieving context -> closed-book is lighter but riskier.

## Evaluation Notes

- Context-based: exact match / F1 over spans; check grounding to provided text.
- Closed-book: BLEU/ROUGE and human factuality checks; add retrieval if drift is high.

---

## Practice Targets for Today

- Draft examples for both modes using your domain data.
- Define metrics you will track (span EM/F1 vs. generative ROUGE/factuality).
- List retrieval options to upgrade closed-book to open-book if needed.
