---
title: "Ngày 46 - Nền tảng Transfer Learning"
weight: 1
chapter: false
pre: "<b> 1.10.1. </b>"
---

**Ngày:** 2025-11-10 (Thứ Hai)  
**Trạng Thái:** "Hoàn thành"  

---

# Transfer Learning: Vì sao quan trọng

Huấn luyện truyền thống bắt đầu từ đầu cho mọi tác vụ. Transfer learning tái dùng mô hình đã tiền huấn luyện để hội tụ nhanh hơn, chính xác hơn và cần ít dữ liệu gán nhãn hơn.

## So sánh quy trình

- Truyền thống: dữ liệu -> mô hình khởi tạo ngẫu nhiên -> train -> dự đoán
- Transfer: tiền huấn luyện trên corpora lớn -> tái dùng trọng số -> fine-tune trên tác vụ đích -> dự đoán

```
[Dữ liệu lớn (không/ có nhãn)] --pre-train--> [Trọng số gốc]
                                       \
                                        fine-tune trên dữ liệu tác vụ --> deploy
```

## Hai cách tiếp cận

- Feature-based: dùng embedding đã huấn luyện như đặc trưng cố định; train head mới.
- Fine-tuning: cập nhật (một phần) trọng số gốc trên dữ liệu downstream.

## Lợi ích

- Hội tụ nhanh nhờ khởi động nóng.
- Dự đoán tốt hơn từ biểu diễn giàu ngữ cảnh.
- Cần ít dữ liệu gán nhãn; tận dụng tiền huấn luyện trên dữ liệu thô.

## Lưu ý chính

- Lệch miền: chọn dữ liệu tiền huấn luyện gần với miền đích nếu có thể.
- Quên thảm họa: dùng learning rate nhỏ hoặc đóng băng lớp đầu.
- Đánh giá: so sánh đóng băng vs. fine-tune toàn bộ để tránh overfit.

---

## Việc thực hành hôm nay

- Phác quy trình transfer cho bài QA của bạn (dữ liệu, model base, head, metric).
- Quyết định lớp nào đóng băng và lớp nào fine-tune.
- Lên plan thử nhanh: feature-based vs. fine-tune và so sánh kết quả.
