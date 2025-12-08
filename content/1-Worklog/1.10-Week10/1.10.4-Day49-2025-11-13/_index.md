---
title: "Day 49 - T5 Text-to-Text Multitask"
weight: 4
chapter: false
pre: "<b> 1.10.4. </b>"
---

**Date:** 2025-11-13 (Thursday)  
**Status:** "Done"  

---

# One Model, Many Tasks

T5 frames everything as text-to-text, so the same model handles QA, summarization, translation, and classification via prompts.

## Prompt-Based Framing

- Examples:
  - `question: When is Pi Day? context: ... -> March 14`
  - `summarize: <article>`
  - `translate English to German: <sentence>`
- Consistent format lets the model share representations across tasks.

## Data Scale Matters

- Pre-trained on the C4 corpus (~800 GB) vs. Wikipedia (~13 GB).
- Larger, cleaner corpora improve downstream generalization.

## Multitask Benefits

- Shared encoder-decoder improves transfer between tasks.
- Better low-resource performance thanks to cross-task signals.

## Practical Notes

- Control output length with decoder max_length and repetition penalty.
- For QA, ensure prompts clearly separate question and context.
- Mixed-task fine-tuning: balance batches to avoid task dominance.

---

## Practice Targets for Today

- Draft prompts for your QA and summarization tasks.
- Decide model size vs. GPU budget (T5-small/base/large).
- Plan a multitask mix (ratio per task) for fine-tuning.
