---
title: "Day 48 - BERT Bidirectional Context"
weight: 3
chapter: false
pre: "<b> 1.10.3. </b>"
---

**Date:** 2025-11-12 (Wednesday)  
**Status:** "Done"  

---

# How BERT Learns

BERT pre-trains with bidirectional context so each token sees both left and right neighbors.

## Masked Language Modeling (MLM)

- Randomly mask ~15% tokens; predict the original token.
- Loss encourages contextual embeddings that consider surrounding words.

```
Input:  learning from deep learning is like watching the sunset with my best [MASK]
Target: friend
```

## Next Sentence Prediction (NSP)

- Task: predict if sentence B follows sentence A.
- Helps sentence-level coherence for tasks like QA and classification.

## Downstream Use

- Start from pre-trained weights.
- Option A: freeze encoder, train a lightweight head (feature-based).
- Option B: fine-tune encoder + head with a small learning rate.

## Tips

- Keep max_seq_length aligned to task data; long docs may need chunking.
- Watch for catastrophic forgetting; gradual unfreezing can help.
- Small batch? Use gradient accumulation to stabilize updates.

---

## Practice Targets for Today

- Prepare a BERT QA fine-tune plan (dataset, max length, lr, epochs).
- Decide whether to freeze lower layers for your data size.
- Add evaluation checkpoints (dev set EM/F1) to catch overfitting early.
