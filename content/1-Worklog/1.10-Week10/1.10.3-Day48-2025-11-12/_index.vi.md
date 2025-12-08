---
title: "Ngày 48 - BERT và ngữ cảnh hai chiều"
weight: 3
chapter: false
pre: "<b> 1.10.3. </b>"
---

**Ngày:** 2025-11-12 (Thứ Tư)  
**Trạng Thái:** "Hoàn thành"  

---

# BERT học như thế nào

BERT tiền huấn luyện với ngữ cảnh hai chiều, nên mỗi token nhìn được cả trái lẫn phải.

## Masked Language Modeling (MLM)

- Mask ngẫu nhiên ~15% token; dự đoán token gốc.
- Mục tiêu buộc embedding hiểu ngữ cảnh xung quanh.

```
Input:  learning from deep learning is like watching the sunset with my best [MASK]
Target: friend
```

## Next Sentence Prediction (NSP)

- Nhiệm vụ: dự đoán câu B có theo sau câu A hay không.
- Hỗ trợ coherence mức câu, hữu ích cho QA và phân loại.

## Dùng cho downstream

- Bắt đầu từ trọng số đã pre-train.
- Cách A: đóng băng encoder, train head nhẹ (feature-based).
- Cách B: fine-tune encoder + head với learning rate nhỏ.

## Mẹo thực hành

- max_seq_length phải phù hợp dữ liệu; tài liệu dài cần chunk.
- Tránh quên thảm họa: unfreeze dần, lr nhỏ.
- Batch nhỏ? Dùng gradient accumulation để ổn định.

---

## Việc thực hành hôm nay

- Lập kế hoạch fine-tune BERT cho QA (dataset, max length, lr, epochs).
- Quyết định có đóng băng tầng thấp hay không dựa vào kích cỡ dữ liệu.
- Thêm checkpoint đánh giá (dev EM/F1) để dừng sớm khi overfit.
