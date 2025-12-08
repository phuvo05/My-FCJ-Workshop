---
title: "Tuần 10 - Transfer Learning, BERT & T5"
weight: 10
chapter: false
pre: "<b> 1.10. </b>"
---

**Tuần:** 2025-11-10 đến 2025-11-14  
**Trạng thái:** "Đang thực hiện"  

---

## Tổng quan Tuần 10

Tuần này tập trung vào transfer learning cho NLP và cách QA hiện đại tận dụng transformer tiền huấn luyện. Ta so sánh huấn luyện truyền thống với reuse đặc trưng và fine-tuning, rồi đi vào hai mô hình tiêu biểu: BERT (ngữ cảnh hai chiều) và T5 (text-to-text đa nhiệm), kèm cách thiết lập QA có ngữ cảnh vs. closed-book.

### Chủ đề chính

#### Nền tảng Transfer Learning
- Pipeline truyền thống vs. pipeline transfer
- Tái dùng trọng số tiền huấn luyện để hội tụ nhanh hơn
- So sánh feature-based với fine-tuning
- Lợi ích: nhanh hơn, chính xác hơn, ít dữ liệu nhãn

#### Hai chế độ Question Answering
- QA có ngữ cảnh (trích span/sinh ngắn dựa vào đoạn văn)
- QA closed-book (sinh câu trả lời không có context)
- Ảnh hưởng của chất lượng tiền huấn luyện lên QA

#### BERT và ngữ cảnh hai chiều
- Masked Language Modeling cho embedding ngữ cảnh
- Next Sentence Prediction cho coherence mức câu
- Dùng cả trái và phải để dự đoán token
- Ứng dụng: QA, sentiment, phân loại

#### T5 đa nhiệm text-to-text
- Định dạng text-to-text cho nhiều tác vụ
- Prompt chung cho rating, QA, tóm tắt, dịch
- Mở rộng dữ liệu (C4 so với Wikipedia)
- Chuyển giao đa nhiệm để tổng quát hóa tốt hơn

#### Chiến lược dữ liệu & huấn luyện
- Pha trộn dữ liệu có nhãn/không nhãn; self-supervised masking
- Đóng băng backbone vs. thêm head
- Công thức fine-tuning cho QA/tóm tắt/dịch

### Mục tiêu học tập

- Giải thích khi nào nên dùng transfer thay vì huấn luyện từ đầu
- Phân biệt reuse đặc trưng và fine-tuning toàn bộ
- So sánh QA có ngữ cảnh và QA closed-book
- Tóm lược cách BERT và T5 tiền huấn luyện và chuyển giao
- Nêu vì sao transfer giúp giảm dữ liệu nhãn và thời gian train

---

## Lịch trong tuần

| Ngày | Trọng tâm | Chủ đề |
|-----|-----------|--------|
| 46 | Giới thiệu Transfer | Pipeline truyền thống vs. transfer, reuse trọng số, feature-based vs. fine-tuning, lợi ích |
| 47 | Question Answering | QA có ngữ cảnh vs. closed-book, nhu cầu dữ liệu, cách đánh giá |
| 48 | BERT hai chiều | Masked LM, NSP, tận dụng ngữ cảnh hai phía cho dự đoán token |
| 49 | Mô hình T5 | Prompt text-to-text, chia sẻ đa nhiệm, mở rộng dữ liệu (C4 vs. Wikipedia) |
| 50 | Thực hành fine-tuning | Đóng băng/lộ trình unfreeze, downstream: QA, tóm tắt, dịch |

---

## Yêu cầu nền tảng

- Nắm vững kiến trúc transformer từ Tuần 9
- Thoải mái với attention và luồng encoder-decoder
- Cơ bản PyTorch/TensorFlow để fine-tune

## Bước tiếp theo

- Đọc paper BERT và T5 để hiểu mục tiêu pre-train
- Fine-tune thử model BERT QA (kiểu SQuAD span)
- Thử prompt T5 cho QA, tóm tắt, sentiment
- So sánh hiệu năng feature-based vs. fine-tune trên dữ liệu của bạn
