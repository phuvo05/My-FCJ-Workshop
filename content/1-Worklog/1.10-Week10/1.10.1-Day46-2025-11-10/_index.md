---
title: "Day 46 - Transfer Learning Fundamentals"
weight: 1
chapter: false
pre: "<b> 1.10.1. </b>"
---

**Date:** 2025-11-10 (Monday)  
**Status:** "Done"  

---

# Transfer Learning: Why It Matters

Classical training starts from scratch for every task. Transfer learning reuses a pre-trained model so you converge faster, get better accuracy, and need less labeled data.

## Pipelines Compared

- Classical: data -> random init model -> train -> predict
- Transfer: pre-train on large corpus -> reuse weights -> fine-tune on target task -> predict

```
[Large unlabeled/labeled data] --pre-train--> [Base model weights]
                                      \
                                       fine-tune on task data --> deploy
```

## Two Approaches

- Feature-based: treat pre-trained embeddings as fixed features; train a new head.
- Fine-tuning: update (part of) the base model weights on downstream data.

## Benefits Checklist

- Faster convergence because weights are warm-started.
- Better predictions from richer representations.
- Smaller labeled datasets needed; leverage unlabeled pre-training.

## Key Considerations

- Domain shift: choose pre-training data close to target domain when possible.
- Catastrophic forgetting: use smaller learning rate or freeze early layers.
- Evaluation: monitor if freezing vs. full fine-tuning impacts overfitting.

---

## Practice Targets for Today

- Sketch a transfer pipeline for your QA task (data, base model, head, metrics).
- Decide which layers to freeze vs. fine-tune.
- Prepare a small experiment plan comparing feature-based vs. fine-tuned runs.
