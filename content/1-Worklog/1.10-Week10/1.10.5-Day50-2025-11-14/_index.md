---
title: "Day 50 - Fine-Tuning Practice"
weight: 5
chapter: false
pre: "<b> 1.10.5. </b>"
---

**Date:** 2025-11-14 (Friday)  
**Status:** "Done"  

---

# Fine-Tuning Recipes

Today focuses on practical knobs: which layers to freeze, how to schedule learning rates, and how to evaluate transfer setups.

## Freezing vs. Training

- Freeze lower layers when data is small or domain is close to pre-training.
- Unfreeze progressively (top -> bottom) if accuracy plateaus.
- Add a task-specific head (classification, span QA, seq2seq) and start there.

## Hyperparameter Basics

- Learning rate: 1e-5 to 3e-5 for full encoder; slightly higher if mostly frozen.
- Warmup steps: ~5% to 10% of total steps to stabilize early training.
- Max sequence length: match task; chunk long docs for QA.

## Evaluation Loop

- Track loss + task metrics (EM/F1 for QA, ROUGE for summarization, accuracy/F1 for classification).
- Early stop on dev set; keep best checkpoint, not just last.
- Compare feature-based baseline vs. full fine-tune for a small subset.

## Deployment Considerations

- Distill or quantize for latency if accuracy holds.
- Cache tokenizer and truncation rules to avoid drift between train and serve.
- Log prompts/inputs to debug closed-book vs. context-based behaviors.

---

## Practice Targets for Today

- Run (or plan) a small grid: learning rate, freezing strategy, max length.
- Evaluate on a held-out set and record EM/F1 or ROUGE.
- Decide post-training steps: distillation, quantization, or caching.
