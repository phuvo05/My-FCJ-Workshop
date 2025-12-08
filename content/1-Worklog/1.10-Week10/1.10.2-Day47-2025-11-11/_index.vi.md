---
title: "Ngày 47 - Hai chế độ Question Answering"
weight: 2
chapter: false
pre: "<b> 1.10.2. </b>"
---

**Ngày:** 2025-11-11 (Thứ Ba)  
**Trạng Thái:** "Hoàn thành"  

---

# QA có ngữ cảnh vs. QA closed-book

Cùng dùng transformer, nhưng khác ở dữ liệu đầu vào và cách đánh giá.

## Có ngữ cảnh (open book)

- Input: câu hỏi + đoạn văn hỗ trợ.
- Output: trích span hoặc sinh ngắn, bám sát ngữ cảnh.
- Train: span có nhãn (start/end) hoặc seq2seq kèm context.
- Lỗi thường gặp: sai span khi ngữ cảnh nhiễu.

## Closed-book

- Input: chỉ câu hỏi; model dựa vào kiến thức bên trong.
- Output: câu trả lời sinh ra không có context tường minh.
- Train: kiểu language modeling trên corpora lớn, fine-tune với QA pairs.
- Lỗi: bịa/hallucination; giảm bằng pre-train mạnh hoặc distillation.

## Chọn chế độ nào?

- Có thể cấp tài liệu lúc suy luận -> ưu tiên có ngữ cảnh (kiểm soát tốt, dễ trích dẫn).
- Bị giới hạn latency/lưu trữ -> closed-book nhẹ hơn nhưng rủi ro cao hơn.

## Đánh giá

- Có ngữ cảnh: Exact Match / F1 trên span; kiểm tra bám văn bản.
- Closed-book: BLEU/ROUGE + đánh giá factuality; cân nhắc thêm retrieval nếu lệch.

---

## Việc thực hành hôm nay

- Soạn ví dụ cho cả hai chế độ với dữ liệu miền của bạn.
- Định nghĩa metric theo chế độ (EM/F1 span vs. ROUGE/factuality).
- Liệt kê phương án retrieval để nâng closed-book lên open-book khi cần.
